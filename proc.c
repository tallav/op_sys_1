#include "schedulinginterface.h"
#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"

extern PriorityQueue pq;
extern RoundRobinQueue rrq;
extern RunningProcessesHolder rpholder;

long long tqCounter = 0; // Time Quantums counter
int POLICY = 1; // scheduler policy - round robin by default (can be changed with policy syscall)
int avoidStarv = 0; // flag that get value 1 evry 100 time quantumes

// returns the process accumulator
long long getAccumulator(struct proc *p) {
    return p->accumulator;
}

struct {
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

static struct proc *initproc;

int nextpid = 1;
extern void forkret(void);
extern void trapret(void);

static void wakeup1(void *chan);

void
pinit(void)
{
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
}

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
  int apicid, i;

  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");

  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
  c = mycpu();
  p = c->proc;
  popcli();
  return p;
}

//PAGEBREAK: 32
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;

  release(&ptable.lock);
  
  // initialize performance fields
  p->performance.ctime = ticks; // new process gets ctime
  p->performance.stime = 0;
  p->performance.retime = 0;
  p->performance.rutime = 0;
  p->performance.ttime = 0;
  p->performUt.startRetime = 0;
  p->performUt.startRutime = 0;
  p->performUt.startStime = 0;

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();

  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
  
  p->state = RUNNABLE;
  p->performUt.startRetime = ticks; // update last READY time for performance calculation
  p->timeStamp = tqCounter; // policy 3 - holds the last time the process executed
  // insert the process to the runnable queue
  if(POLICY == 1)
      rrq.enqueue(p);
  else
      pq.put(p);
  p->priority = 5; // set the priority of the new process to 5
  setAccumulator(p); // set the accumulator of the new process
  
  release(&ptable.lock);
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));

  pid = np->pid;
  
  acquire(&ptable.lock);

  np->state = RUNNABLE;
  np->performUt.startRetime = ticks; // update last READY time for performance calculation
  np->timeStamp = tqCounter; // policy 3 - holds the last time the process executed
  // insert the process to the runnable queue
  if(POLICY == 1)
      rrq.enqueue(np);
  else
      pq.put(np);
  np->priority = 5; // set the priority of the new process to 5
  setAccumulator(np); // set the accumulator of the new process

  release(&ptable.lock);
  return pid;
}

// Each time a new process is created or a process shifts from the blocked state to the runnable state, 
// set the value of its accumulator field to the minimum value of the accumulator fields of all the runnable/running processe.
// If it is the only runnable process, set its accumulator value to 0.
void setAccumulator(struct proc *p){
  long long acc1;
  long long acc2; 

  if (pq.getMinAccumulator(&acc1)){
    if (rpholder.getMinAccumulator(&acc2)){
        if (acc1<acc2)
            p->accumulator = acc1;
        else
            p->accumulator = acc2;
    } else {
        p->accumulator = acc1;
    }
  } else if (rpholder.getMinAccumulator(&acc2)){
        p->accumulator = acc2;
  } else {
        p->accumulator = 0;
  }
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(int status)
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(curproc->cwd);
  end_op();
  curproc->cwd = 0;
  
  curproc->performance.ttime = ticks; // exited process gets ctime
  
  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }
  
  // update process exit status 
  curproc->exitStatus = status;
  // Jump into the scheduler, never to return.
  if(p->state == RUNNING)
      rpholder.remove(p);
  curproc->state = ZOMBIE;
  sched();
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
// return the exit status in status arg.
int
wait(int *status)
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        // return the terminated child exit status.
        if(status != null){ 
            *status = p->exitStatus;
        }
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}

//PAGEBREAK: 42
// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  struct proc *p = null; // for uninitialize error
  struct cpu *c = mycpu();
  c->proc = 0;
  // checks the POLICY value and choose the appropriate scheduler
  for(;;){
    switch(POLICY){
        case 0: // for testing
            originalScheduler(p, c);
            break;
        case 1: // Round Robin
            roundRobinScheduler(p, c);
            break;
        case 2: // Priority Scheduling
            priorityScheduler(p, c);
            break;
        case 3: // Extended Priority Scheduling
            extendedPriorityScheduler(p, c);
            break;
    }
  }
}

void
originalScheduler(struct proc *p, struct cpu *c)
{
    // Enable interrupts on this processor.
    sti();
	
    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
      
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
}

void
roundRobinScheduler(struct proc *p, struct cpu *c)
{
    // Enable interrupts on this processor.
    sti();
  
    // dequeue from RoundRobinQueue the next process to run.
    acquire(&ptable.lock);
    
    if(!rrq.isEmpty()){
        p = rrq.dequeue();

        // Switch to chosen process.  It is the process's job
        // to release ptable.lock and then reacquire it
        // before jumping back to us.
        c->proc = p;
        switchuvm(p);
        p->state = RUNNING;
        
        p->performance.retime += ticks - p->performUt.startRetime; // add to READY time
        p->performUt.startRutime = ticks; // update last RUNNING time for performance calculation
        rpholder.remove(p); // makes sure the process is not in the queue (avoids overflow)
        rpholder.add(p); // insert the process to the running holder
        
        swtch(&(c->scheduler), p->context);
        switchkvm();

        // Process is done running for now.
        // It should have changed its p->state before coming back.
        c->proc = 0;
    }
    
    release(&ptable.lock);
}

void
priorityScheduler(struct proc *p, struct cpu *c)
{
    // Enable interrupts on this processor.
    sti();
    
    // dequeue from RoundRobinQueue the next process to run.
    acquire(&ptable.lock);

    if(!pq.isEmpty()){
        p = pq.extractMin();

        // Switch to chosen process.  It is the process's job
        // to release ptable.lock and then reacquire it
        // before jumping back to us.
        c->proc = p;
        switchuvm(p);
        p->state = RUNNING; 
        
        p->performance.retime += ticks - p->performUt.startRetime; // add to READY time
        p->performUt.startRutime = ticks; // update last RUNNING time for performance calculation
        rpholder.remove(p); // makes sure the process is not in the queue (avoids overflow)
        rpholder.add(p); // insert the process to the running holder

        swtch(&(c->scheduler), p->context);
        switchkvm();

        // Process is done running for now.
        // It should have changed its p->state before coming back.
        c->proc = 0;
    }
    release(&ptable.lock);
}

void
extendedPriorityScheduler(struct proc *p, struct cpu *c)
{
    // Enable interrupts on this processor.
    sti();
    
    // dequeue from RoundRobinQueue the next process to run.
    acquire(&ptable.lock);

    if(!pq.isEmpty()){
        struct proc *np = p;
        if(avoidStarv){ // every 100 time quantums (flag update in yield) 
            long long max = 0;
            for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){  // run over all the ptable and look for the process which didn't work for the lonest time
                if (p->state == RUNNABLE){
                    if (tqCounter - p->timeStamp > max || np == null){
                        np = p;
                        max = tqCounter - p->timeStamp;
                    }
                }
            }
            avoidStarv = 0;
            if (np != null){ // process was found in the ptable
                if (!pq.extractProc(np)){ // try to extract it from the runnable queue
                    release(&ptable.lock);
                    return;
                }
            }
        } else { // work like policy 2
            np = pq.extractMin();
        }
        
        // Switch to chosen process.  It is the process's job
        // to release ptable.lock and then reacquire it
        // before jumping back to us.
        c->proc = np;
        switchuvm(np);
        np->state = RUNNING;
        
        np->performance.retime += ticks - np->performUt.startRetime; // add to READY time
        np->performUt.startRutime = ticks; // update last RUNNING time for performance calculation
        rpholder.remove(np); // makes sure the process is not in the queue (avoids overflow)
        rpholder.add(np); // insert the process to the running holder

        swtch(&(c->scheduler), np->context);
        switchkvm();

        // Process is done running for now.
        // It should have changed its p->state before coming back.
        c->proc = 0;
    }
    release(&ptable.lock);
}

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  
  struct proc *p = myproc();
  if(p->state == RUNNING){
    rpholder.remove(p);
    p->performance.rutime += ticks - p->performUt.startRutime; // add to RUNNING time
  }
  p->state = RUNNABLE;
  p->performUt.startRetime = ticks; // update last READY time for performance calculation
  p->timeStamp = tqCounter; // policy 3 - holds the last time the process executed
  tqCounter++; // update the counter
  // insert the process to the runnable queue
  if(POLICY == 1)
      rrq.enqueue(p);
  else {
      pq.put(p);
      p->accumulator += p->priority;
      if (POLICY == 3 && tqCounter % 100 == 0)
         avoidStarv = 1;
  }
  
  sched();
  release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();

  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk); 
  }
  
  if(p->state == RUNNING){
    rpholder.remove(p);
    p->performance.rutime += ticks - p->performUt.startRutime; // add to RUNNING time
  }
  
  // Go to sleep.
  p->chan = chan;
  p->state = SLEEPING;
  p->performUt.startStime = ticks; // update last SLEEPING time for performance calculation
  
  sched();

  // Tidy up.
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == SLEEPING && p->chan == chan){ 
      p->state = RUNNABLE;
      
      p->performance.stime += ticks - p->performUt.startStime; // add to SLEEPING time 
      p->performUt.startRetime = ticks; // update last READY time for performance calculation
      p->timeStamp = tqCounter; // policy 3 - holds the last time the process executed
      setAccumulator(p); // set the process accumulater after beeing blocked
      // insert the process to the runnable queue
      if(POLICY == 1)
        rrq.enqueue(p);
      else
        pq.put(p);
    }
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  struct proc *p;
    
  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING){
        p->state = RUNNABLE;
        
        p->performance.stime += ticks - p->performUt.startStime; // add to SLEEPING time 
        p->performUt.startRetime = ticks; // update last READY time for performance calculation
        p->timeStamp = tqCounter; // policy 3 - holds the last time the process executed
        setAccumulator(p); // set the process accumulater after beeing blocked 
        // insert the process to the runnable queue
        if(POLICY == 1)
            rrq.enqueue(p);
        else
            pq.put(p);
      }
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}

// transfer a child process with the given pid from the parent to the init process.
// return 0 when succseeds or -1 if the process has no child with this pid.
int
detach(int pid)
{ 
  struct proc *curproc = myproc();
  struct proc *p;
  int procExist = -1;

  if(curproc == initproc)
    panic("init called detach");

  acquire(&ptable.lock);
  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid && p->parent == curproc){
        procExist = 0;
        p->parent = initproc;
        if(p->state == ZOMBIE)
            wakeup1(initproc);
    }
  }
  release(&ptable.lock);
  return procExist;
}

// used by a process to change its priority
void
priority(int proc_priority)
{
  struct proc *curproc = myproc();
  
  if(proc_priority <= 10 && proc_priority >= 0){
      if(POLICY == 3 || (POLICY == 2 && proc_priority >= 1)){
        acquire(&ptable.lock);
        curproc->priority = proc_priority;
        release(&ptable.lock); 
      }
  }
}

// receives a policy identifier as an argument and changes the currently used policy.
void
policy(int policy_id)
{
    struct proc *p;
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(policy_id == 1 && (POLICY == 2 || POLICY == 3)){ /*change from Priority to Round Robin policy*/
            pq.switchToRoundRobinPolicy();
            p->accumulator = 0;
        }
        if(policy_id == 2){ 
            if(POLICY == 3){ /*change from Extended Priority to Priority scheduling policy*/
                if(p->priority == 0){ 
                    p->priority = 1;
                }
            }
            if(POLICY == 1){ /*change from Round Robin to Priority scheduling policy*/
                rrq.switchToPriorityQueuePolicy();
            }
        }
        if(policy_id == 3 && POLICY == 1){ /*change from Extended Priority to Round Robin policy*/
            pq.switchToRoundRobinPolicy();
        }
    }
    POLICY = policy_id;
    release(&ptable.lock);
}

//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  static char *states[] = {
  [UNUSED]    "unused",
  [EMBRYO]    "embryo",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
  [RUNNING]   "run   ",
  [ZOMBIE]    "zombie"
  };
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}

// Return the pid of the terminated child process or -1 upon failure.
int
wait_stat(int* status, struct perf * performance){
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        // Return the terminated child exit status.
        if(status != null){ 
            *status = p->exitStatus;
        }
        // Return the terminated child performance.
        if(performance != null){ 
            *performance = p->performance;
        }
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}

// increments performance to all proccesses that are running or sleeping
/*void updatePerformance(){
  struct proc *p;
  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(p->state == RUNNABLE ){
        p->performance.retime++;
        }
        if(p->state == RUNNING){
        p->performance.rutime++;
        }
        if(p->state == SLEEPING && p->performance.ttime == 0){
        p->performance.stime++;
        }
  }
  release(&ptable.lock);
}*/
