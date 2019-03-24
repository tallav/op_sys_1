
_test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    return result;

}


int main(void) {
       0:	55                   	push   %ebp
    run_test(&test_exit_wait, "exit&wait");
       1:	b8 88 10 00 00       	mov    $0x1088,%eax
int main(void) {
       6:	89 e5                	mov    %esp,%ebp
       8:	83 e4 f0             	and    $0xfffffff0,%esp
       b:	83 ec 10             	sub    $0x10,%esp
    run_test(&test_exit_wait, "exit&wait");
       e:	89 44 24 04          	mov    %eax,0x4(%esp)
      12:	c7 04 24 f0 00 00 00 	movl   $0xf0,(%esp)
      19:	e8 92 02 00 00       	call   2b0 <run_test>
    run_test(&test_detach, "detach");
      1e:	ba 21 11 00 00       	mov    $0x1121,%edx
      23:	89 54 24 04          	mov    %edx,0x4(%esp)
      27:	c7 04 24 90 01 00 00 	movl   $0x190,(%esp)
      2e:	e8 7d 02 00 00       	call   2b0 <run_test>
    run_test(&test_round_robin_policy, "round robin policy");
      33:	b9 28 11 00 00       	mov    $0x1128,%ecx
      38:	89 4c 24 04          	mov    %ecx,0x4(%esp)
      3c:	c7 04 24 20 06 00 00 	movl   $0x620,(%esp)
      43:	e8 68 02 00 00       	call   2b0 <run_test>
    run_test(&test_priority_policy, "priority policy");
      48:	b8 44 11 00 00       	mov    $0x1144,%eax
      4d:	89 44 24 04          	mov    %eax,0x4(%esp)
      51:	c7 04 24 40 06 00 00 	movl   $0x640,(%esp)
      58:	e8 53 02 00 00       	call   2b0 <run_test>
    run_test(&test_extended_priority_policy, "extended priority policy");
      5d:	b8 3b 11 00 00       	mov    $0x113b,%eax
      62:	89 44 24 04          	mov    %eax,0x4(%esp)
      66:	c7 04 24 90 06 00 00 	movl   $0x690,(%esp)
      6d:	e8 3e 02 00 00       	call   2b0 <run_test>
    run_test(&test_accumulator, "accumulator");
      72:	b8 54 11 00 00       	mov    $0x1154,%eax
      77:	89 44 24 04          	mov    %eax,0x4(%esp)
      7b:	c7 04 24 40 09 00 00 	movl   $0x940,(%esp)
      82:	e8 29 02 00 00       	call   2b0 <run_test>
    run_test(&test_starvation, "starvation");
      87:	b8 60 11 00 00       	mov    $0x1160,%eax
      8c:	89 44 24 04          	mov    %eax,0x4(%esp)
      90:	c7 04 24 60 09 00 00 	movl   $0x960,(%esp)
      97:	e8 14 02 00 00       	call   2b0 <run_test>
    run_test(&test_performance_round_robin, "performance round robin");
      9c:	b8 6b 11 00 00       	mov    $0x116b,%eax
      a1:	89 44 24 04          	mov    %eax,0x4(%esp)
      a5:	c7 04 24 90 07 00 00 	movl   $0x790,(%esp)
      ac:	e8 ff 01 00 00       	call   2b0 <run_test>
    run_test(&test_performance_priority, "performance priority");
      b1:	b8 83 11 00 00       	mov    $0x1183,%eax
      b6:	89 44 24 04          	mov    %eax,0x4(%esp)
      ba:	c7 04 24 b0 07 00 00 	movl   $0x7b0,(%esp)
      c1:	e8 ea 01 00 00       	call   2b0 <run_test>
    run_test(&test_performance_extended_priority, "performance extended priority");
      c6:	ba 98 11 00 00       	mov    $0x1198,%edx
      cb:	89 54 24 04          	mov    %edx,0x4(%esp)
      cf:	c7 04 24 f0 07 00 00 	movl   $0x7f0,(%esp)
      d6:	e8 d5 01 00 00       	call   2b0 <run_test>
    exit(0);
      db:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      e2:	e8 c1 0a 00 00       	call   ba8 <exit>
      e7:	66 90                	xchg   %ax,%ax
      e9:	66 90                	xchg   %ax,%ax
      eb:	66 90                	xchg   %ax,%ax
      ed:	66 90                	xchg   %ax,%ax
      ef:	90                   	nop

000000f0 <test_exit_wait>:
boolean test_exit_wait() {
      f0:	55                   	push   %ebp
      f1:	89 e5                	mov    %esp,%ebp
      f3:	57                   	push   %edi
      f4:	56                   	push   %esi
    boolean result = true;
      f5:	be 01 00 00 00       	mov    $0x1,%esi
boolean test_exit_wait() {
      fa:	53                   	push   %ebx
    for (int i = 0; i < 20; ++i) {
      fb:	31 db                	xor    %ebx,%ebx
boolean test_exit_wait() {
      fd:	83 ec 3c             	sub    $0x3c,%esp
            wait(&status);
     100:	8d 7d e4             	lea    -0x1c(%ebp),%edi
     103:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        pid = fork();
     110:	e8 8b 0a 00 00       	call   ba0 <fork>
        if (pid > 0) {
     115:	85 c0                	test   %eax,%eax
     117:	7e 57                	jle    170 <test_exit_wait+0x80>
            wait(&status);
     119:	89 3c 24             	mov    %edi,(%esp)
     11c:	e8 8f 0a 00 00       	call   bb0 <wait>
            result = result && assert_equals(i, status, "exit&wait");
     121:	85 f6                	test   %esi,%esi
     123:	74 34                	je     159 <test_exit_wait+0x69>
     125:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     128:	be 01 00 00 00       	mov    $0x1,%esi
    if (expected != actual) {
     12d:	39 d8                	cmp    %ebx,%eax
     12f:	74 28                	je     159 <test_exit_wait+0x69>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     131:	89 44 24 10          	mov    %eax,0x10(%esp)
     135:	ba b8 11 00 00       	mov    $0x11b8,%edx
     13a:	b8 88 10 00 00       	mov    $0x1088,%eax
     13f:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
            result = result && assert_equals(i, status, "exit&wait");
     143:	31 f6                	xor    %esi,%esi
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     145:	89 44 24 08          	mov    %eax,0x8(%esp)
     149:	89 54 24 04          	mov    %edx,0x4(%esp)
     14d:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     154:	e8 b7 0b 00 00       	call   d10 <printf>
    for (int i = 0; i < 20; ++i) {
     159:	43                   	inc    %ebx
     15a:	83 fb 14             	cmp    $0x14,%ebx
            status = -1;
     15d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
    for (int i = 0; i < 20; ++i) {
     164:	75 aa                	jne    110 <test_exit_wait+0x20>
}
     166:	83 c4 3c             	add    $0x3c,%esp
     169:	89 f0                	mov    %esi,%eax
     16b:	5b                   	pop    %ebx
     16c:	5e                   	pop    %esi
     16d:	5f                   	pop    %edi
     16e:	5d                   	pop    %ebp
     16f:	c3                   	ret    
            sleep(3);
     170:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
     177:	e8 bc 0a 00 00       	call   c38 <sleep>
            exit(i);
     17c:	89 1c 24             	mov    %ebx,(%esp)
     17f:	e8 24 0a 00 00       	call   ba8 <exit>
     184:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     18a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000190 <test_detach>:
boolean test_detach() {
     190:	55                   	push   %ebp
     191:	89 e5                	mov    %esp,%ebp
     193:	56                   	push   %esi
     194:	53                   	push   %ebx
     195:	83 ec 20             	sub    $0x20,%esp
    pid = fork();
     198:	e8 03 0a 00 00       	call   ba0 <fork>
    if (pid > 0) {
     19d:	85 c0                	test   %eax,%eax
     19f:	0f 8e ea 00 00 00    	jle    28f <test_detach+0xff>
        status1 = detach(pid);
     1a5:	89 04 24             	mov    %eax,(%esp)
     1a8:	89 c3                	mov    %eax,%ebx
    } else return true;
     1aa:	be 01 00 00 00       	mov    $0x1,%esi
        status1 = detach(pid);
     1af:	e8 94 0a 00 00       	call   c48 <detach>
    if (expected != actual) {
     1b4:	85 c0                	test   %eax,%eax
     1b6:	0f 85 a4 00 00 00    	jne    260 <test_detach+0xd0>
        status2 = detach(pid);
     1bc:	89 1c 24             	mov    %ebx,(%esp)
     1bf:	e8 84 0a 00 00       	call   c48 <detach>
    if (expected != actual) {
     1c4:	83 f8 ff             	cmp    $0xffffffff,%eax
     1c7:	75 1f                	jne    1e8 <test_detach+0x58>
        status3 = detach(-10);
     1c9:	c7 04 24 f6 ff ff ff 	movl   $0xfffffff6,(%esp)
     1d0:	e8 73 0a 00 00       	call   c48 <detach>
    if (expected != actual) {
     1d5:	83 f8 ff             	cmp    $0xffffffff,%eax
     1d8:	75 4a                	jne    224 <test_detach+0x94>
}
     1da:	83 c4 20             	add    $0x20,%esp
     1dd:	89 f0                	mov    %esi,%eax
     1df:	5b                   	pop    %ebx
     1e0:	5e                   	pop    %esi
     1e1:	5d                   	pop    %ebp
     1e2:	c3                   	ret    
     1e3:	90                   	nop
     1e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     1e8:	89 44 24 10          	mov    %eax,0x10(%esp)
     1ec:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
     1f1:	b8 b8 11 00 00       	mov    $0x11b8,%eax
     1f6:	be a3 10 00 00       	mov    $0x10a3,%esi
     1fb:	89 44 24 04          	mov    %eax,0x4(%esp)
     1ff:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
     203:	89 74 24 08          	mov    %esi,0x8(%esp)
     207:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     20e:	e8 fd 0a 00 00       	call   d10 <printf>
        status3 = detach(-10);
     213:	c7 04 24 f6 ff ff ff 	movl   $0xfffffff6,(%esp)
     21a:	e8 29 0a 00 00       	call   c48 <detach>
    if (expected != actual) {
     21f:	83 f8 ff             	cmp    $0xffffffff,%eax
     222:	74 2b                	je     24f <test_detach+0xbf>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     224:	89 44 24 10          	mov    %eax,0x10(%esp)
     228:	ba b4 10 00 00       	mov    $0x10b4,%edx
     22d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     232:	b9 b8 11 00 00       	mov    $0x11b8,%ecx
     237:	89 44 24 0c          	mov    %eax,0xc(%esp)
     23b:	89 54 24 08          	mov    %edx,0x8(%esp)
     23f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     243:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     24a:	e8 c1 0a 00 00       	call   d10 <printf>
}
     24f:	83 c4 20             	add    $0x20,%esp
        return result1 && result2 && result3;
     252:	31 f6                	xor    %esi,%esi
}
     254:	5b                   	pop    %ebx
     255:	89 f0                	mov    %esi,%eax
     257:	5e                   	pop    %esi
     258:	5d                   	pop    %ebp
     259:	c3                   	ret    
     25a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     260:	89 44 24 10          	mov    %eax,0x10(%esp)
     264:	31 c0                	xor    %eax,%eax
     266:	31 f6                	xor    %esi,%esi
     268:	89 44 24 0c          	mov    %eax,0xc(%esp)
     26c:	b8 92 10 00 00       	mov    $0x1092,%eax
     271:	89 44 24 08          	mov    %eax,0x8(%esp)
     275:	b8 b8 11 00 00       	mov    $0x11b8,%eax
     27a:	89 44 24 04          	mov    %eax,0x4(%esp)
     27e:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     285:	e8 86 0a 00 00       	call   d10 <printf>
     28a:	e9 2d ff ff ff       	jmp    1bc <test_detach+0x2c>
        sleep(100);
     28f:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
     296:	e8 9d 09 00 00       	call   c38 <sleep>
        exit(0);
     29b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     2a2:	e8 01 09 00 00       	call   ba8 <exit>
     2a7:	89 f6                	mov    %esi,%esi
     2a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002b0 <run_test>:
void run_test(test_runner *test, char *name) {
     2b0:	55                   	push   %ebp
    printf(1, "========== Test - %s: Begin ==========\n", name);
     2b1:	b9 e4 11 00 00       	mov    $0x11e4,%ecx
void run_test(test_runner *test, char *name) {
     2b6:	89 e5                	mov    %esp,%ebp
     2b8:	53                   	push   %ebx
     2b9:	83 ec 14             	sub    $0x14,%esp
     2bc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    printf(1, "========== Test - %s: Begin ==========\n", name);
     2bf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     2c3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     2ca:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     2ce:	e8 3d 0a 00 00       	call   d10 <printf>
    boolean result = (*test)();
     2d3:	ff 55 08             	call   *0x8(%ebp)
        printf(1, "========== Test - %s: Passed ==========\n", name);
     2d6:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    if (result) {
     2da:	85 c0                	test   %eax,%eax
     2dc:	75 22                	jne    300 <run_test+0x50>
        printf(1, "========== Test - %s: Failed ==========\n", name);
     2de:	b8 38 12 00 00       	mov    $0x1238,%eax
     2e3:	89 44 24 04          	mov    %eax,0x4(%esp)
     2e7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     2ee:	e8 1d 0a 00 00       	call   d10 <printf>
}
     2f3:	83 c4 14             	add    $0x14,%esp
     2f6:	5b                   	pop    %ebx
     2f7:	5d                   	pop    %ebp
     2f8:	c3                   	ret    
     2f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "========== Test - %s: Passed ==========\n", name);
     300:	ba 0c 12 00 00       	mov    $0x120c,%edx
     305:	89 54 24 04          	mov    %edx,0x4(%esp)
     309:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     310:	e8 fb 09 00 00       	call   d10 <printf>
}
     315:	83 c4 14             	add    $0x14,%esp
     318:	5b                   	pop    %ebx
     319:	5d                   	pop    %ebp
     31a:	c3                   	ret    
     31b:	90                   	nop
     31c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000320 <assert_equals>:
boolean assert_equals(int expected, int actual, char *msg) {
     320:	55                   	push   %ebp
     321:	b8 01 00 00 00       	mov    $0x1,%eax
     326:	89 e5                	mov    %esp,%ebp
     328:	83 ec 28             	sub    $0x28,%esp
     32b:	8b 55 08             	mov    0x8(%ebp),%edx
     32e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    if (expected != actual) {
     331:	39 ca                	cmp    %ecx,%edx
     333:	74 26                	je     35b <assert_equals+0x3b>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     335:	8b 45 10             	mov    0x10(%ebp),%eax
     338:	89 4c 24 10          	mov    %ecx,0x10(%esp)
     33c:	89 54 24 0c          	mov    %edx,0xc(%esp)
     340:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     347:	89 44 24 08          	mov    %eax,0x8(%esp)
     34b:	b8 b8 11 00 00       	mov    $0x11b8,%eax
     350:	89 44 24 04          	mov    %eax,0x4(%esp)
     354:	e8 b7 09 00 00       	call   d10 <printf>
     359:	31 c0                	xor    %eax,%eax
}
     35b:	c9                   	leave  
     35c:	c3                   	ret    
     35d:	8d 76 00             	lea    0x0(%esi),%esi

00000360 <print_perf>:
void print_perf(struct perf *performance) {
     360:	55                   	push   %ebp
    printf(1, "pref:\n");
     361:	b8 c5 10 00 00       	mov    $0x10c5,%eax
void print_perf(struct perf *performance) {
     366:	89 e5                	mov    %esp,%ebp
     368:	53                   	push   %ebx
     369:	83 ec 14             	sub    $0x14,%esp
     36c:	8b 5d 08             	mov    0x8(%ebp),%ebx
    printf(1, "pref:\n");
     36f:	89 44 24 04          	mov    %eax,0x4(%esp)
     373:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     37a:	e8 91 09 00 00       	call   d10 <printf>
    printf(1, "\tctime: %d\n", performance->ctime);
     37f:	ba cc 10 00 00       	mov    $0x10cc,%edx
     384:	8b 03                	mov    (%ebx),%eax
     386:	89 54 24 04          	mov    %edx,0x4(%esp)
     38a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     391:	89 44 24 08          	mov    %eax,0x8(%esp)
     395:	e8 76 09 00 00       	call   d10 <printf>
    printf(1, "\tttime: %d\n", performance->ttime);
     39a:	8b 43 04             	mov    0x4(%ebx),%eax
     39d:	b9 d8 10 00 00       	mov    $0x10d8,%ecx
     3a2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     3a6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     3ad:	89 44 24 08          	mov    %eax,0x8(%esp)
     3b1:	e8 5a 09 00 00       	call   d10 <printf>
    printf(1, "\tstime: %d\n", performance->stime);
     3b6:	8b 43 08             	mov    0x8(%ebx),%eax
     3b9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     3c0:	89 44 24 08          	mov    %eax,0x8(%esp)
     3c4:	b8 e4 10 00 00       	mov    $0x10e4,%eax
     3c9:	89 44 24 04          	mov    %eax,0x4(%esp)
     3cd:	e8 3e 09 00 00       	call   d10 <printf>
    printf(1, "\tretime: %d\n", performance->retime);
     3d2:	8b 43 0c             	mov    0xc(%ebx),%eax
     3d5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     3dc:	89 44 24 08          	mov    %eax,0x8(%esp)
     3e0:	b8 f0 10 00 00       	mov    $0x10f0,%eax
     3e5:	89 44 24 04          	mov    %eax,0x4(%esp)
     3e9:	e8 22 09 00 00       	call   d10 <printf>
    printf(1, "\trutime: %d\n", performance->rutime);
     3ee:	8b 43 10             	mov    0x10(%ebx),%eax
     3f1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     3f8:	89 44 24 08          	mov    %eax,0x8(%esp)
     3fc:	b8 fd 10 00 00       	mov    $0x10fd,%eax
     401:	89 44 24 04          	mov    %eax,0x4(%esp)
     405:	e8 06 09 00 00       	call   d10 <printf>
    printf(1, "\n\tTurnaround time: %d\n", (performance->ttime - performance->ctime));
     40a:	8b 43 04             	mov    0x4(%ebx),%eax
     40d:	b9 0a 11 00 00       	mov    $0x110a,%ecx
     412:	8b 13                	mov    (%ebx),%edx
     414:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     418:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     41f:	29 d0                	sub    %edx,%eax
     421:	89 44 24 08          	mov    %eax,0x8(%esp)
     425:	e8 e6 08 00 00       	call   d10 <printf>
}
     42a:	83 c4 14             	add    $0x14,%esp
     42d:	5b                   	pop    %ebx
     42e:	5d                   	pop    %ebp
     42f:	c3                   	ret    

00000430 <fact>:
int fact(int n) {
     430:	55                   	push   %ebp
}
     431:	31 c0                	xor    %eax,%eax
int fact(int n) {
     433:	89 e5                	mov    %esp,%ebp
}
     435:	5d                   	pop    %ebp
     436:	c3                   	ret    
     437:	89 f6                	mov    %esi,%esi
     439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000440 <fact2>:
unsigned long long fact2(unsigned long long n, unsigned long long k) {
     440:	55                   	push   %ebp
     441:	89 e5                	mov    %esp,%ebp
     443:	57                   	push   %edi
     444:	56                   	push   %esi
     445:	53                   	push   %ebx
     446:	83 ec 0c             	sub    $0xc,%esp
     449:	8b 45 10             	mov    0x10(%ebp),%eax
     44c:	8b 55 14             	mov    0x14(%ebp),%edx
     44f:	8b 4d 08             	mov    0x8(%ebp),%ecx
     452:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     455:	89 45 e8             	mov    %eax,-0x18(%ebp)
     458:	89 55 ec             	mov    %edx,-0x14(%ebp)
     45b:	eb 25                	jmp    482 <fact2+0x42>
     45d:	8d 76 00             	lea    0x0(%esi),%esi
        k = k * n;
     460:	8b 75 ec             	mov    -0x14(%ebp),%esi
        --n;
     463:	83 c1 ff             	add    $0xffffffff,%ecx
        k = k * n;
     466:	8b 55 e8             	mov    -0x18(%ebp),%edx
        --n;
     469:	83 d3 ff             	adc    $0xffffffff,%ebx
        k = k * n;
     46c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     46f:	0f af f1             	imul   %ecx,%esi
     472:	0f af d3             	imul   %ebx,%edx
     475:	01 d6                	add    %edx,%esi
     477:	f7 e1                	mul    %ecx
     479:	89 55 ec             	mov    %edx,-0x14(%ebp)
     47c:	01 75 ec             	add    %esi,-0x14(%ebp)
     47f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (n == 1) {
     482:	89 ce                	mov    %ecx,%esi
     484:	89 df                	mov    %ebx,%edi
     486:	83 f6 01             	xor    $0x1,%esi
     489:	09 f7                	or     %esi,%edi
     48b:	75 d3                	jne    460 <fact2+0x20>
}
     48d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     490:	8b 55 ec             	mov    -0x14(%ebp),%edx
     493:	83 c4 0c             	add    $0xc,%esp
     496:	5b                   	pop    %ebx
     497:	5e                   	pop    %esi
     498:	5f                   	pop    %edi
     499:	5d                   	pop    %ebp
     49a:	c3                   	ret    
     49b:	90                   	nop
     49c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004a0 <fib>:
int fib(int n) {
     4a0:	55                   	push   %ebp
     4a1:	89 e5                	mov    %esp,%ebp
     4a3:	83 ec 28             	sub    $0x28,%esp
     4a6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     4a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     4ac:	89 75 f8             	mov    %esi,-0x8(%ebp)
     4af:	89 7d fc             	mov    %edi,-0x4(%ebp)
    if (!n)
     4b2:	85 db                	test   %ebx,%ebx
     4b4:	74 2a                	je     4e0 <fib+0x40>
     4b6:	4b                   	dec    %ebx
     4b7:	bf ff ff ff ff       	mov    $0xffffffff,%edi
     4bc:	31 f6                	xor    %esi,%esi
    return fib(n - 1) + fib(n - 2);
     4be:	89 1c 24             	mov    %ebx,(%esp)
     4c1:	83 eb 02             	sub    $0x2,%ebx
     4c4:	e8 d7 ff ff ff       	call   4a0 <fib>
     4c9:	01 c6                	add    %eax,%esi
    if (!n)
     4cb:	39 fb                	cmp    %edi,%ebx
     4cd:	75 ef                	jne    4be <fib+0x1e>
     4cf:	8d 46 01             	lea    0x1(%esi),%eax
}
     4d2:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     4d5:	8b 75 f8             	mov    -0x8(%ebp),%esi
     4d8:	8b 7d fc             	mov    -0x4(%ebp),%edi
     4db:	89 ec                	mov    %ebp,%esp
     4dd:	5d                   	pop    %ebp
     4de:	c3                   	ret    
     4df:	90                   	nop
     4e0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    if (!n)
     4e3:	b8 01 00 00 00       	mov    $0x1,%eax
}
     4e8:	8b 75 f8             	mov    -0x8(%ebp),%esi
     4eb:	8b 7d fc             	mov    -0x4(%ebp),%edi
     4ee:	89 ec                	mov    %ebp,%esp
     4f0:	5d                   	pop    %ebp
     4f1:	c3                   	ret    
     4f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     4f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000500 <test_policy_helper>:
boolean test_policy_helper(int *priority_mod, int policy) {
     500:	55                   	push   %ebp
     501:	89 e5                	mov    %esp,%ebp
     503:	57                   	push   %edi
     504:	56                   	push   %esi
     505:	53                   	push   %ebx
    for (int i = 0; i < nProcs; ++i) {
     506:	31 db                	xor    %ebx,%ebx
boolean test_policy_helper(int *priority_mod, int policy) {
     508:	83 ec 4c             	sub    $0x4c,%esp
     50b:	eb 0f                	jmp    51c <test_policy_helper+0x1c>
     50d:	8d 76 00             	lea    0x0(%esi),%esi
        } else if (pid == 0) {
     510:	0f 84 b6 00 00 00    	je     5cc <test_policy_helper+0xcc>
    for (int i = 0; i < nProcs; ++i) {
     516:	43                   	inc    %ebx
     517:	83 fb 64             	cmp    $0x64,%ebx
     51a:	74 0d                	je     529 <test_policy_helper+0x29>
     51c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        pid = fork();
     520:	e8 7b 06 00 00       	call   ba0 <fork>
        if (pid < 0) {
     525:	85 c0                	test   %eax,%eax
     527:	79 e7                	jns    510 <test_policy_helper+0x10>
     529:	31 f6                	xor    %esi,%esi
     52b:	ba 01 00 00 00       	mov    $0x1,%edx
     530:	8d 7d e4             	lea    -0x1c(%ebp),%edi
     533:	eb 0b                	jmp    540 <test_policy_helper+0x40>
    for (int j = 0; j < nProcs; ++j) {
     535:	83 fb 64             	cmp    $0x64,%ebx
     538:	89 de                	mov    %ebx,%esi
     53a:	74 74                	je     5b0 <test_policy_helper+0xb0>
     53c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        wait(&status);
     540:	89 3c 24             	mov    %edi,(%esp)
     543:	8d 5e 01             	lea    0x1(%esi),%ebx
     546:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     549:	e8 62 06 00 00       	call   bb0 <wait>
        result = result && assert_equals(0, status, "round robin");
     54e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     551:	85 d2                	test   %edx,%edx
     553:	74 44                	je     599 <test_policy_helper+0x99>
     555:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     558:	ba 01 00 00 00       	mov    $0x1,%edx
    if (expected != actual) {
     55d:	85 c0                	test   %eax,%eax
     55f:	74 d4                	je     535 <test_policy_helper+0x35>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     561:	89 44 24 10          	mov    %eax,0x10(%esp)
     565:	ba 77 11 00 00       	mov    $0x1177,%edx
     56a:	31 c0                	xor    %eax,%eax
     56c:	b9 b8 11 00 00       	mov    $0x11b8,%ecx
     571:	89 44 24 0c          	mov    %eax,0xc(%esp)
     575:	89 54 24 08          	mov    %edx,0x8(%esp)
     579:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     57d:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     584:	e8 87 07 00 00       	call   d10 <printf>
    for (int j = 0; j < nProcs; ++j) {
     589:	83 fb 64             	cmp    $0x64,%ebx
     58c:	74 32                	je     5c0 <test_policy_helper+0xc0>
        wait(&status);
     58e:	89 3c 24             	mov    %edi,(%esp)
     591:	8d 5e 02             	lea    0x2(%esi),%ebx
     594:	e8 17 06 00 00       	call   bb0 <wait>
    for (int j = 0; j < nProcs; ++j) {
     599:	83 fb 64             	cmp    $0x64,%ebx
     59c:	74 22                	je     5c0 <test_policy_helper+0xc0>
     59e:	43                   	inc    %ebx
        wait(&status);
     59f:	89 3c 24             	mov    %edi,(%esp)
     5a2:	89 de                	mov    %ebx,%esi
     5a4:	e8 07 06 00 00       	call   bb0 <wait>
        result = result && assert_equals(0, status, "round robin");
     5a9:	31 d2                	xor    %edx,%edx
    for (int j = 0; j < nProcs; ++j) {
     5ab:	83 fb 64             	cmp    $0x64,%ebx
     5ae:	75 90                	jne    540 <test_policy_helper+0x40>
}
     5b0:	83 c4 4c             	add    $0x4c,%esp
     5b3:	89 d0                	mov    %edx,%eax
     5b5:	5b                   	pop    %ebx
     5b6:	5e                   	pop    %esi
     5b7:	5f                   	pop    %edi
     5b8:	5d                   	pop    %ebp
     5b9:	c3                   	ret    
     5ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     5c0:	83 c4 4c             	add    $0x4c,%esp
        result = result && assert_equals(0, status, "round robin");
     5c3:	31 d2                	xor    %edx,%edx
}
     5c5:	5b                   	pop    %ebx
     5c6:	89 d0                	mov    %edx,%eax
     5c8:	5e                   	pop    %esi
     5c9:	5f                   	pop    %edi
     5ca:	5d                   	pop    %ebp
     5cb:	c3                   	ret    
            if (priority_mod) {
     5cc:	8b 75 08             	mov    0x8(%ebp),%esi
     5cf:	85 f6                	test   %esi,%esi
     5d1:	74 1a                	je     5ed <test_policy_helper+0xed>
                if ((i % *(priority_mod)) == 0 && policy == PRIORITY) {
     5d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
     5d6:	89 d8                	mov    %ebx,%eax
     5d8:	99                   	cltd   
     5d9:	f7 39                	idivl  (%ecx)
     5db:	85 d2                	test   %edx,%edx
     5dd:	75 06                	jne    5e5 <test_policy_helper+0xe5>
     5df:	83 7d 0c 02          	cmpl   $0x2,0xc(%ebp)
     5e3:	74 20                	je     605 <test_policy_helper+0x105>
                    priority(i % (*priority_mod));
     5e5:	89 14 24             	mov    %edx,(%esp)
     5e8:	e8 63 06 00 00       	call   c50 <priority>
            sleep(10);
     5ed:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
     5f4:	e8 3f 06 00 00       	call   c38 <sleep>
            exit(0);
     5f9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     600:	e8 a3 05 00 00       	call   ba8 <exit>
                    priority(1);
     605:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     60c:	e8 3f 06 00 00       	call   c50 <priority>
     611:	eb da                	jmp    5ed <test_policy_helper+0xed>
     613:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000620 <test_round_robin_policy>:
boolean test_round_robin_policy() {
     620:	55                   	push   %ebp
    return test_policy_helper(null, null);
     621:	31 c0                	xor    %eax,%eax
boolean test_round_robin_policy() {
     623:	89 e5                	mov    %esp,%ebp
     625:	83 ec 18             	sub    $0x18,%esp
    return test_policy_helper(null, null);
     628:	89 44 24 04          	mov    %eax,0x4(%esp)
     62c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     633:	e8 c8 fe ff ff       	call   500 <test_policy_helper>
}
     638:	c9                   	leave  
     639:	c3                   	ret    
     63a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000640 <test_priority_policy>:
boolean test_priority_policy() {
     640:	55                   	push   %ebp
     641:	89 e5                	mov    %esp,%ebp
     643:	83 ec 38             	sub    $0x38,%esp
    policy(PRIORITY);
     646:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    int priority_mod = 10;
     64d:	c7 45 f4 0a 00 00 00 	movl   $0xa,-0xc(%ebp)
    policy(PRIORITY);
     654:	e8 ff 05 00 00       	call   c58 <policy>
    boolean result = test_policy_helper(&priority_mod, PRIORITY);
     659:	b8 02 00 00 00       	mov    $0x2,%eax
     65e:	89 44 24 04          	mov    %eax,0x4(%esp)
     662:	8d 45 f4             	lea    -0xc(%ebp),%eax
     665:	89 04 24             	mov    %eax,(%esp)
     668:	e8 93 fe ff ff       	call   500 <test_policy_helper>
    policy(ROUND_ROBIN);
     66d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    boolean result = test_policy_helper(&priority_mod, PRIORITY);
     674:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    policy(ROUND_ROBIN);
     677:	e8 dc 05 00 00       	call   c58 <policy>
}
     67c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     67f:	c9                   	leave  
     680:	c3                   	ret    
     681:	eb 0d                	jmp    690 <test_extended_priority_policy>
     683:	90                   	nop
     684:	90                   	nop
     685:	90                   	nop
     686:	90                   	nop
     687:	90                   	nop
     688:	90                   	nop
     689:	90                   	nop
     68a:	90                   	nop
     68b:	90                   	nop
     68c:	90                   	nop
     68d:	90                   	nop
     68e:	90                   	nop
     68f:	90                   	nop

00000690 <test_extended_priority_policy>:
boolean test_extended_priority_policy() {
     690:	55                   	push   %ebp
     691:	89 e5                	mov    %esp,%ebp
     693:	83 ec 38             	sub    $0x38,%esp
    policy(EXTENED_PRIORITY);
     696:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
    int priority_mod = 10;
     69d:	c7 45 f4 0a 00 00 00 	movl   $0xa,-0xc(%ebp)
    policy(EXTENED_PRIORITY);
     6a4:	e8 af 05 00 00       	call   c58 <policy>
    boolean result = test_policy_helper(&priority_mod, EXTENED_PRIORITY);
     6a9:	b8 03 00 00 00       	mov    $0x3,%eax
     6ae:	89 44 24 04          	mov    %eax,0x4(%esp)
     6b2:	8d 45 f4             	lea    -0xc(%ebp),%eax
     6b5:	89 04 24             	mov    %eax,(%esp)
     6b8:	e8 43 fe ff ff       	call   500 <test_policy_helper>
    policy(ROUND_ROBIN);
     6bd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    boolean result = test_policy_helper(&priority_mod, EXTENED_PRIORITY);
     6c4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    policy(ROUND_ROBIN);
     6c7:	e8 8c 05 00 00       	call   c58 <policy>
}
     6cc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     6cf:	c9                   	leave  
     6d0:	c3                   	ret    
     6d1:	eb 0d                	jmp    6e0 <test_performance_helper>
     6d3:	90                   	nop
     6d4:	90                   	nop
     6d5:	90                   	nop
     6d6:	90                   	nop
     6d7:	90                   	nop
     6d8:	90                   	nop
     6d9:	90                   	nop
     6da:	90                   	nop
     6db:	90                   	nop
     6dc:	90                   	nop
     6dd:	90                   	nop
     6de:	90                   	nop
     6df:	90                   	nop

000006e0 <test_performance_helper>:
boolean test_performance_helper(int *npriority) {
     6e0:	55                   	push   %ebp
     6e1:	89 e5                	mov    %esp,%ebp
     6e3:	57                   	push   %edi
     6e4:	56                   	push   %esi
     6e5:	53                   	push   %ebx
     6e6:	83 ec 3c             	sub    $0x3c,%esp
    pid1 = fork();
     6e9:	e8 b2 04 00 00       	call   ba0 <fork>
    if (pid1 > 0) {
     6ee:	85 c0                	test   %eax,%eax
     6f0:	7f 3e                	jg     730 <test_performance_helper+0x50>
     6f2:	bb 64 00 00 00       	mov    $0x64,%ebx
                wait_stat(&status, &perf1);
     6f7:	8d 7d d4             	lea    -0x2c(%ebp),%edi
     6fa:	8d 75 d0             	lea    -0x30(%ebp),%esi
     6fd:	8d 76 00             	lea    0x0(%esi),%esi
            pid = fork();
     700:	e8 9b 04 00 00       	call   ba0 <fork>
            if (pid > 0) {
     705:	85 c0                	test   %eax,%eax
     707:	7e 4e                	jle    757 <test_performance_helper+0x77>
                sleep(5);
     709:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     710:	e8 23 05 00 00       	call   c38 <sleep>
                wait_stat(&status, &perf1);
     715:	89 7c 24 04          	mov    %edi,0x4(%esp)
     719:	89 34 24             	mov    %esi,(%esp)
     71c:	e8 3f 05 00 00       	call   c60 <wait_stat>
        for (int a = 0; a < 100; ++a) {
     721:	4b                   	dec    %ebx
     722:	75 dc                	jne    700 <test_performance_helper+0x20>
        exit(0);
     724:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     72b:	e8 78 04 00 00       	call   ba8 <exit>
        wait_stat(&status1, &perf2);
     730:	8d 5d d4             	lea    -0x2c(%ebp),%ebx
     733:	8d 45 d0             	lea    -0x30(%ebp),%eax
     736:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     73a:	89 04 24             	mov    %eax,(%esp)
     73d:	e8 1e 05 00 00       	call   c60 <wait_stat>
        print_perf(&perf2);
     742:	89 1c 24             	mov    %ebx,(%esp)
     745:	e8 16 fc ff ff       	call   360 <print_perf>
}
     74a:	83 c4 3c             	add    $0x3c,%esp
     74d:	b8 01 00 00 00       	mov    $0x1,%eax
     752:	5b                   	pop    %ebx
     753:	5e                   	pop    %esi
     754:	5f                   	pop    %edi
     755:	5d                   	pop    %ebp
     756:	c3                   	ret    
                if (npriority)
     757:	8b 45 08             	mov    0x8(%ebp),%eax
     75a:	85 c0                	test   %eax,%eax
     75c:	74 0d                	je     76b <test_performance_helper+0x8b>
                    priority(*npriority);
     75e:	8b 45 08             	mov    0x8(%ebp),%eax
     761:	8b 00                	mov    (%eax),%eax
     763:	89 04 24             	mov    %eax,(%esp)
     766:	e8 e5 04 00 00       	call   c50 <priority>
                sleep(5);
     76b:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     772:	e8 c1 04 00 00       	call   c38 <sleep>
                exit(0);
     777:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     77e:	e8 25 04 00 00       	call   ba8 <exit>
     783:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000790 <test_performance_round_robin>:
boolean test_performance_round_robin() {
     790:	55                   	push   %ebp
     791:	89 e5                	mov    %esp,%ebp
     793:	83 ec 18             	sub    $0x18,%esp
    return test_performance_helper(null);
     796:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     79d:	e8 3e ff ff ff       	call   6e0 <test_performance_helper>
}
     7a2:	c9                   	leave  
     7a3:	c3                   	ret    
     7a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     7aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000007b0 <test_performance_priority>:
boolean test_performance_priority() {
     7b0:	55                   	push   %ebp
     7b1:	89 e5                	mov    %esp,%ebp
     7b3:	83 ec 38             	sub    $0x38,%esp
    policy(PRIORITY);
     7b6:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     7bd:	e8 96 04 00 00       	call   c58 <policy>
    boolean result = test_performance_helper(&npriority);
     7c2:	8d 45 f4             	lea    -0xc(%ebp),%eax
     7c5:	89 04 24             	mov    %eax,(%esp)
    int npriority = 2;
     7c8:	c7 45 f4 02 00 00 00 	movl   $0x2,-0xc(%ebp)
    boolean result = test_performance_helper(&npriority);
     7cf:	e8 0c ff ff ff       	call   6e0 <test_performance_helper>
    policy(ROUND_ROBIN);
     7d4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    boolean result = test_performance_helper(&npriority);
     7db:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    policy(ROUND_ROBIN);
     7de:	e8 75 04 00 00       	call   c58 <policy>
}
     7e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7e6:	c9                   	leave  
     7e7:	c3                   	ret    
     7e8:	90                   	nop
     7e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000007f0 <test_performance_extended_priority>:
boolean test_performance_extended_priority() {
     7f0:	55                   	push   %ebp
     7f1:	89 e5                	mov    %esp,%ebp
     7f3:	83 ec 38             	sub    $0x38,%esp
    policy(EXTENED_PRIORITY);
     7f6:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
     7fd:	e8 56 04 00 00       	call   c58 <policy>
    boolean result = test_performance_helper(&npriority);
     802:	8d 45 f4             	lea    -0xc(%ebp),%eax
     805:	89 04 24             	mov    %eax,(%esp)
    int npriority = 0;
     808:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    boolean result = test_performance_helper(&npriority);
     80f:	e8 cc fe ff ff       	call   6e0 <test_performance_helper>
    policy(ROUND_ROBIN);
     814:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    boolean result = test_performance_helper(&npriority);
     81b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    policy(ROUND_ROBIN);
     81e:	e8 35 04 00 00       	call   c58 <policy>
}
     823:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     826:	c9                   	leave  
     827:	c3                   	ret    
     828:	90                   	nop
     829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000830 <test_starvation_helper>:
boolean test_starvation_helper(int npolicy, int npriority) {
     830:	55                   	push   %ebp
     831:	89 e5                	mov    %esp,%ebp
     833:	57                   	push   %edi
     834:	56                   	push   %esi
    memset(&pid_arr, 0, nProcs * sizeof(int));
     835:	31 f6                	xor    %esi,%esi
boolean test_starvation_helper(int npolicy, int npriority) {
     837:	53                   	push   %ebx
    memset(&pid_arr, 0, nProcs * sizeof(int));
     838:	bb 28 00 00 00       	mov    $0x28,%ebx
boolean test_starvation_helper(int npolicy, int npriority) {
     83d:	83 ec 5c             	sub    $0x5c,%esp
    policy(npolicy);
     840:	8b 45 08             	mov    0x8(%ebp),%eax
     843:	89 04 24             	mov    %eax,(%esp)
     846:	e8 0d 04 00 00       	call   c58 <policy>
    memset(&pid_arr, 0, nProcs * sizeof(int));
     84b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     84f:	8d 5d c0             	lea    -0x40(%ebp),%ebx
     852:	89 74 24 04          	mov    %esi,0x4(%esp)
     856:	89 df                	mov    %ebx,%edi
     858:	89 1c 24             	mov    %ebx,(%esp)
     85b:	8d 75 e8             	lea    -0x18(%ebp),%esi
     85e:	e8 ad 01 00 00       	call   a10 <memset>
     863:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        pid = fork();
     870:	e8 2b 03 00 00       	call   ba0 <fork>
        if (pid < 0) {
     875:	85 c0                	test   %eax,%eax
     877:	78 0f                	js     888 <test_starvation_helper+0x58>
        } else if (pid == 0) {
     879:	0f 84 a1 00 00 00    	je     920 <test_starvation_helper+0xf0>
            pid_arr[i] = pid;
     87f:	89 07                	mov    %eax,(%edi)
     881:	83 c7 04             	add    $0x4,%edi
    for (int i = 0; i < nProcs; ++i) {
     884:	39 f7                	cmp    %esi,%edi
     886:	75 e8                	jne    870 <test_starvation_helper+0x40>
    sleep(100);
     888:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
    boolean result = true;
     88f:	bf 01 00 00 00       	mov    $0x1,%edi
    sleep(100);
     894:	e8 9f 03 00 00       	call   c38 <sleep>
     899:	eb 18                	jmp    8b3 <test_starvation_helper+0x83>
     89b:	90                   	nop
     89c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            wait(null);
     8a0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     8a7:	e8 04 03 00 00       	call   bb0 <wait>
     8ac:	83 c3 04             	add    $0x4,%ebx
    for (int j = 0; j < nProcs; ++j) {
     8af:	39 de                	cmp    %ebx,%esi
     8b1:	74 4d                	je     900 <test_starvation_helper+0xd0>
        if (pid_arr[j] != 0) {
     8b3:	8b 03                	mov    (%ebx),%eax
     8b5:	85 c0                	test   %eax,%eax
     8b7:	74 f3                	je     8ac <test_starvation_helper+0x7c>
            result = result && assert_equals(0, kill(pid_arr[j]), "failed to kill child (yes it does sound horrible)");
     8b9:	85 ff                	test   %edi,%edi
     8bb:	74 e3                	je     8a0 <test_starvation_helper+0x70>
     8bd:	89 04 24             	mov    %eax,(%esp)
     8c0:	bf 01 00 00 00       	mov    $0x1,%edi
     8c5:	e8 0e 03 00 00       	call   bd8 <kill>
    if (expected != actual) {
     8ca:	85 c0                	test   %eax,%eax
     8cc:	74 d2                	je     8a0 <test_starvation_helper+0x70>
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     8ce:	89 44 24 10          	mov    %eax,0x10(%esp)
     8d2:	ba 64 12 00 00       	mov    $0x1264,%edx
     8d7:	31 c0                	xor    %eax,%eax
     8d9:	b9 b8 11 00 00       	mov    $0x11b8,%ecx
            result = result && assert_equals(0, kill(pid_arr[j]), "failed to kill child (yes it does sound horrible)");
     8de:	31 ff                	xor    %edi,%edi
        printf(2, "Assert %s failed: expected %d but got %d\n", msg, expected, actual);
     8e0:	89 44 24 0c          	mov    %eax,0xc(%esp)
     8e4:	89 54 24 08          	mov    %edx,0x8(%esp)
     8e8:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     8ec:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     8f3:	e8 18 04 00 00       	call   d10 <printf>
     8f8:	eb a6                	jmp    8a0 <test_starvation_helper+0x70>
     8fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    policy(ROUND_ROBIN);
     900:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     907:	e8 4c 03 00 00       	call   c58 <policy>
}
     90c:	83 c4 5c             	add    $0x5c,%esp
     90f:	89 f8                	mov    %edi,%eax
     911:	5b                   	pop    %ebx
     912:	5e                   	pop    %esi
     913:	5f                   	pop    %edi
     914:	5d                   	pop    %ebp
     915:	c3                   	ret    
     916:	8d 76 00             	lea    0x0(%esi),%esi
     919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            sleep(5);
     920:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     927:	e8 0c 03 00 00       	call   c38 <sleep>
            priority(npriority);
     92c:	8b 45 0c             	mov    0xc(%ebp),%eax
     92f:	89 04 24             	mov    %eax,(%esp)
     932:	e8 19 03 00 00       	call   c50 <priority>
     937:	eb fe                	jmp    937 <test_starvation_helper+0x107>
     939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000940 <test_accumulator>:
boolean test_accumulator() {
     940:	55                   	push   %ebp
    return test_starvation_helper(PRIORITY, 2);
     941:	b8 02 00 00 00       	mov    $0x2,%eax
boolean test_accumulator() {
     946:	89 e5                	mov    %esp,%ebp
     948:	83 ec 18             	sub    $0x18,%esp
    return test_starvation_helper(PRIORITY, 2);
     94b:	89 44 24 04          	mov    %eax,0x4(%esp)
     94f:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     956:	e8 d5 fe ff ff       	call   830 <test_starvation_helper>
}
     95b:	c9                   	leave  
     95c:	c3                   	ret    
     95d:	8d 76 00             	lea    0x0(%esi),%esi

00000960 <test_starvation>:
boolean test_starvation() {
     960:	55                   	push   %ebp
    return test_starvation_helper(EXTENED_PRIORITY, 0);
     961:	31 c0                	xor    %eax,%eax
boolean test_starvation() {
     963:	89 e5                	mov    %esp,%ebp
     965:	83 ec 18             	sub    $0x18,%esp
    return test_starvation_helper(EXTENED_PRIORITY, 0);
     968:	89 44 24 04          	mov    %eax,0x4(%esp)
     96c:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
     973:	e8 b8 fe ff ff       	call   830 <test_starvation_helper>
}
     978:	c9                   	leave  
     979:	c3                   	ret    
     97a:	66 90                	xchg   %ax,%ax
     97c:	66 90                	xchg   %ax,%ax
     97e:	66 90                	xchg   %ax,%ax

00000980 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     980:	55                   	push   %ebp
     981:	89 e5                	mov    %esp,%ebp
     983:	8b 45 08             	mov    0x8(%ebp),%eax
     986:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     989:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     98a:	89 c2                	mov    %eax,%edx
     98c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     990:	41                   	inc    %ecx
     991:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     995:	42                   	inc    %edx
     996:	84 db                	test   %bl,%bl
     998:	88 5a ff             	mov    %bl,-0x1(%edx)
     99b:	75 f3                	jne    990 <strcpy+0x10>
    ;
  return os;
}
     99d:	5b                   	pop    %ebx
     99e:	5d                   	pop    %ebp
     99f:	c3                   	ret    

000009a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     9a0:	55                   	push   %ebp
     9a1:	89 e5                	mov    %esp,%ebp
     9a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
     9a6:	53                   	push   %ebx
     9a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
     9aa:	0f b6 01             	movzbl (%ecx),%eax
     9ad:	0f b6 13             	movzbl (%ebx),%edx
     9b0:	84 c0                	test   %al,%al
     9b2:	75 18                	jne    9cc <strcmp+0x2c>
     9b4:	eb 22                	jmp    9d8 <strcmp+0x38>
     9b6:	8d 76 00             	lea    0x0(%esi),%esi
     9b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     9c0:	41                   	inc    %ecx
  while(*p && *p == *q)
     9c1:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
     9c4:	43                   	inc    %ebx
     9c5:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
     9c8:	84 c0                	test   %al,%al
     9ca:	74 0c                	je     9d8 <strcmp+0x38>
     9cc:	38 d0                	cmp    %dl,%al
     9ce:	74 f0                	je     9c0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
     9d0:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
     9d1:	29 d0                	sub    %edx,%eax
}
     9d3:	5d                   	pop    %ebp
     9d4:	c3                   	ret    
     9d5:	8d 76 00             	lea    0x0(%esi),%esi
     9d8:	5b                   	pop    %ebx
     9d9:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     9db:	29 d0                	sub    %edx,%eax
}
     9dd:	5d                   	pop    %ebp
     9de:	c3                   	ret    
     9df:	90                   	nop

000009e0 <strlen>:

uint
strlen(const char *s)
{
     9e0:	55                   	push   %ebp
     9e1:	89 e5                	mov    %esp,%ebp
     9e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     9e6:	80 39 00             	cmpb   $0x0,(%ecx)
     9e9:	74 15                	je     a00 <strlen+0x20>
     9eb:	31 d2                	xor    %edx,%edx
     9ed:	8d 76 00             	lea    0x0(%esi),%esi
     9f0:	42                   	inc    %edx
     9f1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     9f5:	89 d0                	mov    %edx,%eax
     9f7:	75 f7                	jne    9f0 <strlen+0x10>
    ;
  return n;
}
     9f9:	5d                   	pop    %ebp
     9fa:	c3                   	ret    
     9fb:	90                   	nop
     9fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
     a00:	31 c0                	xor    %eax,%eax
}
     a02:	5d                   	pop    %ebp
     a03:	c3                   	ret    
     a04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     a0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000a10 <memset>:

void*
memset(void *dst, int c, uint n)
{
     a10:	55                   	push   %ebp
     a11:	89 e5                	mov    %esp,%ebp
     a13:	8b 55 08             	mov    0x8(%ebp),%edx
     a16:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     a17:	8b 4d 10             	mov    0x10(%ebp),%ecx
     a1a:	8b 45 0c             	mov    0xc(%ebp),%eax
     a1d:	89 d7                	mov    %edx,%edi
     a1f:	fc                   	cld    
     a20:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     a22:	5f                   	pop    %edi
     a23:	89 d0                	mov    %edx,%eax
     a25:	5d                   	pop    %ebp
     a26:	c3                   	ret    
     a27:	89 f6                	mov    %esi,%esi
     a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a30 <strchr>:

char*
strchr(const char *s, char c)
{
     a30:	55                   	push   %ebp
     a31:	89 e5                	mov    %esp,%ebp
     a33:	8b 45 08             	mov    0x8(%ebp),%eax
     a36:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     a3a:	0f b6 10             	movzbl (%eax),%edx
     a3d:	84 d2                	test   %dl,%dl
     a3f:	74 1b                	je     a5c <strchr+0x2c>
    if(*s == c)
     a41:	38 d1                	cmp    %dl,%cl
     a43:	75 0f                	jne    a54 <strchr+0x24>
     a45:	eb 17                	jmp    a5e <strchr+0x2e>
     a47:	89 f6                	mov    %esi,%esi
     a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     a50:	38 ca                	cmp    %cl,%dl
     a52:	74 0a                	je     a5e <strchr+0x2e>
  for(; *s; s++)
     a54:	40                   	inc    %eax
     a55:	0f b6 10             	movzbl (%eax),%edx
     a58:	84 d2                	test   %dl,%dl
     a5a:	75 f4                	jne    a50 <strchr+0x20>
      return (char*)s;
  return 0;
     a5c:	31 c0                	xor    %eax,%eax
}
     a5e:	5d                   	pop    %ebp
     a5f:	c3                   	ret    

00000a60 <gets>:

char*
gets(char *buf, int max)
{
     a60:	55                   	push   %ebp
     a61:	89 e5                	mov    %esp,%ebp
     a63:	57                   	push   %edi
     a64:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     a65:	31 f6                	xor    %esi,%esi
{
     a67:	53                   	push   %ebx
     a68:	83 ec 3c             	sub    $0x3c,%esp
     a6b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
     a6e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
     a71:	eb 32                	jmp    aa5 <gets+0x45>
     a73:	90                   	nop
     a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
     a78:	ba 01 00 00 00       	mov    $0x1,%edx
     a7d:	89 54 24 08          	mov    %edx,0x8(%esp)
     a81:	89 7c 24 04          	mov    %edi,0x4(%esp)
     a85:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     a8c:	e8 2f 01 00 00       	call   bc0 <read>
    if(cc < 1)
     a91:	85 c0                	test   %eax,%eax
     a93:	7e 19                	jle    aae <gets+0x4e>
      break;
    buf[i++] = c;
     a95:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     a99:	43                   	inc    %ebx
     a9a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
     a9d:	3c 0a                	cmp    $0xa,%al
     a9f:	74 1f                	je     ac0 <gets+0x60>
     aa1:	3c 0d                	cmp    $0xd,%al
     aa3:	74 1b                	je     ac0 <gets+0x60>
  for(i=0; i+1 < max; ){
     aa5:	46                   	inc    %esi
     aa6:	3b 75 0c             	cmp    0xc(%ebp),%esi
     aa9:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
     aac:	7c ca                	jl     a78 <gets+0x18>
      break;
  }
  buf[i] = '\0';
     aae:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     ab1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
     ab4:	8b 45 08             	mov    0x8(%ebp),%eax
     ab7:	83 c4 3c             	add    $0x3c,%esp
     aba:	5b                   	pop    %ebx
     abb:	5e                   	pop    %esi
     abc:	5f                   	pop    %edi
     abd:	5d                   	pop    %ebp
     abe:	c3                   	ret    
     abf:	90                   	nop
     ac0:	8b 45 08             	mov    0x8(%ebp),%eax
     ac3:	01 c6                	add    %eax,%esi
     ac5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
     ac8:	eb e4                	jmp    aae <gets+0x4e>
     aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000ad0 <stat>:

int
stat(const char *n, struct stat *st)
{
     ad0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     ad1:	31 c0                	xor    %eax,%eax
{
     ad3:	89 e5                	mov    %esp,%ebp
     ad5:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
     ad8:	89 44 24 04          	mov    %eax,0x4(%esp)
     adc:	8b 45 08             	mov    0x8(%ebp),%eax
{
     adf:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     ae2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
     ae5:	89 04 24             	mov    %eax,(%esp)
     ae8:	e8 fb 00 00 00       	call   be8 <open>
  if(fd < 0)
     aed:	85 c0                	test   %eax,%eax
     aef:	78 2f                	js     b20 <stat+0x50>
     af1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
     af3:	8b 45 0c             	mov    0xc(%ebp),%eax
     af6:	89 1c 24             	mov    %ebx,(%esp)
     af9:	89 44 24 04          	mov    %eax,0x4(%esp)
     afd:	e8 fe 00 00 00       	call   c00 <fstat>
  close(fd);
     b02:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     b05:	89 c6                	mov    %eax,%esi
  close(fd);
     b07:	e8 c4 00 00 00       	call   bd0 <close>
  return r;
}
     b0c:	89 f0                	mov    %esi,%eax
     b0e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
     b11:	8b 75 fc             	mov    -0x4(%ebp),%esi
     b14:	89 ec                	mov    %ebp,%esp
     b16:	5d                   	pop    %ebp
     b17:	c3                   	ret    
     b18:	90                   	nop
     b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
     b20:	be ff ff ff ff       	mov    $0xffffffff,%esi
     b25:	eb e5                	jmp    b0c <stat+0x3c>
     b27:	89 f6                	mov    %esi,%esi
     b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b30 <atoi>:

int
atoi(const char *s)
{
     b30:	55                   	push   %ebp
     b31:	89 e5                	mov    %esp,%ebp
     b33:	8b 4d 08             	mov    0x8(%ebp),%ecx
     b36:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     b37:	0f be 11             	movsbl (%ecx),%edx
     b3a:	88 d0                	mov    %dl,%al
     b3c:	2c 30                	sub    $0x30,%al
     b3e:	3c 09                	cmp    $0x9,%al
  n = 0;
     b40:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
     b45:	77 1e                	ja     b65 <atoi+0x35>
     b47:	89 f6                	mov    %esi,%esi
     b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
     b50:	41                   	inc    %ecx
     b51:	8d 04 80             	lea    (%eax,%eax,4),%eax
     b54:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
     b58:	0f be 11             	movsbl (%ecx),%edx
     b5b:	88 d3                	mov    %dl,%bl
     b5d:	80 eb 30             	sub    $0x30,%bl
     b60:	80 fb 09             	cmp    $0x9,%bl
     b63:	76 eb                	jbe    b50 <atoi+0x20>
  return n;
}
     b65:	5b                   	pop    %ebx
     b66:	5d                   	pop    %ebp
     b67:	c3                   	ret    
     b68:	90                   	nop
     b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000b70 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     b70:	55                   	push   %ebp
     b71:	89 e5                	mov    %esp,%ebp
     b73:	56                   	push   %esi
     b74:	8b 45 08             	mov    0x8(%ebp),%eax
     b77:	53                   	push   %ebx
     b78:	8b 5d 10             	mov    0x10(%ebp),%ebx
     b7b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     b7e:	85 db                	test   %ebx,%ebx
     b80:	7e 1a                	jle    b9c <memmove+0x2c>
     b82:	31 d2                	xor    %edx,%edx
     b84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
     b90:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     b94:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     b97:	42                   	inc    %edx
  while(n-- > 0)
     b98:	39 d3                	cmp    %edx,%ebx
     b9a:	75 f4                	jne    b90 <memmove+0x20>
  return vdst;
}
     b9c:	5b                   	pop    %ebx
     b9d:	5e                   	pop    %esi
     b9e:	5d                   	pop    %ebp
     b9f:	c3                   	ret    

00000ba0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     ba0:	b8 01 00 00 00       	mov    $0x1,%eax
     ba5:	cd 40                	int    $0x40
     ba7:	c3                   	ret    

00000ba8 <exit>:
SYSCALL(exit)
     ba8:	b8 02 00 00 00       	mov    $0x2,%eax
     bad:	cd 40                	int    $0x40
     baf:	c3                   	ret    

00000bb0 <wait>:
SYSCALL(wait)
     bb0:	b8 03 00 00 00       	mov    $0x3,%eax
     bb5:	cd 40                	int    $0x40
     bb7:	c3                   	ret    

00000bb8 <pipe>:
SYSCALL(pipe)
     bb8:	b8 04 00 00 00       	mov    $0x4,%eax
     bbd:	cd 40                	int    $0x40
     bbf:	c3                   	ret    

00000bc0 <read>:
SYSCALL(read)
     bc0:	b8 05 00 00 00       	mov    $0x5,%eax
     bc5:	cd 40                	int    $0x40
     bc7:	c3                   	ret    

00000bc8 <write>:
SYSCALL(write)
     bc8:	b8 10 00 00 00       	mov    $0x10,%eax
     bcd:	cd 40                	int    $0x40
     bcf:	c3                   	ret    

00000bd0 <close>:
SYSCALL(close)
     bd0:	b8 15 00 00 00       	mov    $0x15,%eax
     bd5:	cd 40                	int    $0x40
     bd7:	c3                   	ret    

00000bd8 <kill>:
SYSCALL(kill)
     bd8:	b8 06 00 00 00       	mov    $0x6,%eax
     bdd:	cd 40                	int    $0x40
     bdf:	c3                   	ret    

00000be0 <exec>:
SYSCALL(exec)
     be0:	b8 07 00 00 00       	mov    $0x7,%eax
     be5:	cd 40                	int    $0x40
     be7:	c3                   	ret    

00000be8 <open>:
SYSCALL(open)
     be8:	b8 0f 00 00 00       	mov    $0xf,%eax
     bed:	cd 40                	int    $0x40
     bef:	c3                   	ret    

00000bf0 <mknod>:
SYSCALL(mknod)
     bf0:	b8 11 00 00 00       	mov    $0x11,%eax
     bf5:	cd 40                	int    $0x40
     bf7:	c3                   	ret    

00000bf8 <unlink>:
SYSCALL(unlink)
     bf8:	b8 12 00 00 00       	mov    $0x12,%eax
     bfd:	cd 40                	int    $0x40
     bff:	c3                   	ret    

00000c00 <fstat>:
SYSCALL(fstat)
     c00:	b8 08 00 00 00       	mov    $0x8,%eax
     c05:	cd 40                	int    $0x40
     c07:	c3                   	ret    

00000c08 <link>:
SYSCALL(link)
     c08:	b8 13 00 00 00       	mov    $0x13,%eax
     c0d:	cd 40                	int    $0x40
     c0f:	c3                   	ret    

00000c10 <mkdir>:
SYSCALL(mkdir)
     c10:	b8 14 00 00 00       	mov    $0x14,%eax
     c15:	cd 40                	int    $0x40
     c17:	c3                   	ret    

00000c18 <chdir>:
SYSCALL(chdir)
     c18:	b8 09 00 00 00       	mov    $0x9,%eax
     c1d:	cd 40                	int    $0x40
     c1f:	c3                   	ret    

00000c20 <dup>:
SYSCALL(dup)
     c20:	b8 0a 00 00 00       	mov    $0xa,%eax
     c25:	cd 40                	int    $0x40
     c27:	c3                   	ret    

00000c28 <getpid>:
SYSCALL(getpid)
     c28:	b8 0b 00 00 00       	mov    $0xb,%eax
     c2d:	cd 40                	int    $0x40
     c2f:	c3                   	ret    

00000c30 <sbrk>:
SYSCALL(sbrk)
     c30:	b8 0c 00 00 00       	mov    $0xc,%eax
     c35:	cd 40                	int    $0x40
     c37:	c3                   	ret    

00000c38 <sleep>:
SYSCALL(sleep)
     c38:	b8 0d 00 00 00       	mov    $0xd,%eax
     c3d:	cd 40                	int    $0x40
     c3f:	c3                   	ret    

00000c40 <uptime>:
SYSCALL(uptime)
     c40:	b8 0e 00 00 00       	mov    $0xe,%eax
     c45:	cd 40                	int    $0x40
     c47:	c3                   	ret    

00000c48 <detach>:
SYSCALL(detach)
     c48:	b8 16 00 00 00       	mov    $0x16,%eax
     c4d:	cd 40                	int    $0x40
     c4f:	c3                   	ret    

00000c50 <priority>:
SYSCALL(priority)
     c50:	b8 17 00 00 00       	mov    $0x17,%eax
     c55:	cd 40                	int    $0x40
     c57:	c3                   	ret    

00000c58 <policy>:
SYSCALL(policy)
     c58:	b8 18 00 00 00       	mov    $0x18,%eax
     c5d:	cd 40                	int    $0x40
     c5f:	c3                   	ret    

00000c60 <wait_stat>:
SYSCALL(wait_stat)
     c60:	b8 19 00 00 00       	mov    $0x19,%eax
     c65:	cd 40                	int    $0x40
     c67:	c3                   	ret    
     c68:	66 90                	xchg   %ax,%ax
     c6a:	66 90                	xchg   %ax,%ax
     c6c:	66 90                	xchg   %ax,%ax
     c6e:	66 90                	xchg   %ax,%ax

00000c70 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     c70:	55                   	push   %ebp
     c71:	89 e5                	mov    %esp,%ebp
     c73:	57                   	push   %edi
     c74:	56                   	push   %esi
     c75:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     c76:	89 d3                	mov    %edx,%ebx
     c78:	c1 eb 1f             	shr    $0x1f,%ebx
{
     c7b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
     c7e:	84 db                	test   %bl,%bl
{
     c80:	89 45 c0             	mov    %eax,-0x40(%ebp)
     c83:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
     c85:	74 79                	je     d00 <printint+0x90>
     c87:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
     c8b:	74 73                	je     d00 <printint+0x90>
    neg = 1;
    x = -xx;
     c8d:	f7 d8                	neg    %eax
    neg = 1;
     c8f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
     c96:	31 f6                	xor    %esi,%esi
     c98:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     c9b:	eb 05                	jmp    ca2 <printint+0x32>
     c9d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
     ca0:	89 fe                	mov    %edi,%esi
     ca2:	31 d2                	xor    %edx,%edx
     ca4:	f7 f1                	div    %ecx
     ca6:	8d 7e 01             	lea    0x1(%esi),%edi
     ca9:	0f b6 92 a0 12 00 00 	movzbl 0x12a0(%edx),%edx
  }while((x /= base) != 0);
     cb0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
     cb2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
     cb5:	75 e9                	jne    ca0 <printint+0x30>
  if(neg)
     cb7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
     cba:	85 d2                	test   %edx,%edx
     cbc:	74 08                	je     cc6 <printint+0x56>
    buf[i++] = '-';
     cbe:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
     cc3:	8d 7e 02             	lea    0x2(%esi),%edi
     cc6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
     cca:	8b 7d c0             	mov    -0x40(%ebp),%edi
     ccd:	8d 76 00             	lea    0x0(%esi),%esi
     cd0:	0f b6 06             	movzbl (%esi),%eax
     cd3:	4e                   	dec    %esi
  write(fd, &c, 1);
     cd4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     cd8:	89 3c 24             	mov    %edi,(%esp)
     cdb:	88 45 d7             	mov    %al,-0x29(%ebp)
     cde:	b8 01 00 00 00       	mov    $0x1,%eax
     ce3:	89 44 24 08          	mov    %eax,0x8(%esp)
     ce7:	e8 dc fe ff ff       	call   bc8 <write>

  while(--i >= 0)
     cec:	39 de                	cmp    %ebx,%esi
     cee:	75 e0                	jne    cd0 <printint+0x60>
    putc(fd, buf[i]);
}
     cf0:	83 c4 4c             	add    $0x4c,%esp
     cf3:	5b                   	pop    %ebx
     cf4:	5e                   	pop    %esi
     cf5:	5f                   	pop    %edi
     cf6:	5d                   	pop    %ebp
     cf7:	c3                   	ret    
     cf8:	90                   	nop
     cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
     d00:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     d07:	eb 8d                	jmp    c96 <printint+0x26>
     d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d10 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
     d13:	57                   	push   %edi
     d14:	56                   	push   %esi
     d15:	53                   	push   %ebx
     d16:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     d19:	8b 75 0c             	mov    0xc(%ebp),%esi
     d1c:	0f b6 1e             	movzbl (%esi),%ebx
     d1f:	84 db                	test   %bl,%bl
     d21:	0f 84 d1 00 00 00    	je     df8 <printf+0xe8>
  state = 0;
     d27:	31 ff                	xor    %edi,%edi
     d29:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
     d2a:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
     d2d:	89 fa                	mov    %edi,%edx
     d2f:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
     d32:	89 45 d0             	mov    %eax,-0x30(%ebp)
     d35:	eb 41                	jmp    d78 <printf+0x68>
     d37:	89 f6                	mov    %esi,%esi
     d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     d40:	83 f8 25             	cmp    $0x25,%eax
     d43:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
     d46:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
     d4b:	74 1e                	je     d6b <printf+0x5b>
  write(fd, &c, 1);
     d4d:	b8 01 00 00 00       	mov    $0x1,%eax
     d52:	89 44 24 08          	mov    %eax,0x8(%esp)
     d56:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     d59:	89 44 24 04          	mov    %eax,0x4(%esp)
     d5d:	89 3c 24             	mov    %edi,(%esp)
     d60:	88 5d e2             	mov    %bl,-0x1e(%ebp)
     d63:	e8 60 fe ff ff       	call   bc8 <write>
     d68:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     d6b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
     d6c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
     d70:	84 db                	test   %bl,%bl
     d72:	0f 84 80 00 00 00    	je     df8 <printf+0xe8>
    if(state == 0){
     d78:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
     d7a:	0f be cb             	movsbl %bl,%ecx
     d7d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
     d80:	74 be                	je     d40 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     d82:	83 fa 25             	cmp    $0x25,%edx
     d85:	75 e4                	jne    d6b <printf+0x5b>
      if(c == 'd'){
     d87:	83 f8 64             	cmp    $0x64,%eax
     d8a:	0f 84 f0 00 00 00    	je     e80 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     d90:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
     d96:	83 f9 70             	cmp    $0x70,%ecx
     d99:	74 65                	je     e00 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     d9b:	83 f8 73             	cmp    $0x73,%eax
     d9e:	0f 84 8c 00 00 00    	je     e30 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     da4:	83 f8 63             	cmp    $0x63,%eax
     da7:	0f 84 13 01 00 00    	je     ec0 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     dad:	83 f8 25             	cmp    $0x25,%eax
     db0:	0f 84 e2 00 00 00    	je     e98 <printf+0x188>
  write(fd, &c, 1);
     db6:	b8 01 00 00 00       	mov    $0x1,%eax
     dbb:	46                   	inc    %esi
     dbc:	89 44 24 08          	mov    %eax,0x8(%esp)
     dc0:	8d 45 e7             	lea    -0x19(%ebp),%eax
     dc3:	89 44 24 04          	mov    %eax,0x4(%esp)
     dc7:	89 3c 24             	mov    %edi,(%esp)
     dca:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
     dce:	e8 f5 fd ff ff       	call   bc8 <write>
     dd3:	ba 01 00 00 00       	mov    $0x1,%edx
     dd8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     ddb:	89 54 24 08          	mov    %edx,0x8(%esp)
     ddf:	89 44 24 04          	mov    %eax,0x4(%esp)
     de3:	89 3c 24             	mov    %edi,(%esp)
     de6:	88 5d e6             	mov    %bl,-0x1a(%ebp)
     de9:	e8 da fd ff ff       	call   bc8 <write>
  for(i = 0; fmt[i]; i++){
     dee:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     df2:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
     df4:	84 db                	test   %bl,%bl
     df6:	75 80                	jne    d78 <printf+0x68>
    }
  }
}
     df8:	83 c4 3c             	add    $0x3c,%esp
     dfb:	5b                   	pop    %ebx
     dfc:	5e                   	pop    %esi
     dfd:	5f                   	pop    %edi
     dfe:	5d                   	pop    %ebp
     dff:	c3                   	ret    
        printint(fd, *ap, 16, 0);
     e00:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     e07:	b9 10 00 00 00       	mov    $0x10,%ecx
     e0c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
     e0f:	89 f8                	mov    %edi,%eax
     e11:	8b 13                	mov    (%ebx),%edx
     e13:	e8 58 fe ff ff       	call   c70 <printint>
        ap++;
     e18:	89 d8                	mov    %ebx,%eax
      state = 0;
     e1a:	31 d2                	xor    %edx,%edx
        ap++;
     e1c:	83 c0 04             	add    $0x4,%eax
     e1f:	89 45 d0             	mov    %eax,-0x30(%ebp)
     e22:	e9 44 ff ff ff       	jmp    d6b <printf+0x5b>
     e27:	89 f6                	mov    %esi,%esi
     e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
     e30:	8b 45 d0             	mov    -0x30(%ebp),%eax
     e33:	8b 10                	mov    (%eax),%edx
        ap++;
     e35:	83 c0 04             	add    $0x4,%eax
     e38:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
     e3b:	85 d2                	test   %edx,%edx
     e3d:	0f 84 aa 00 00 00    	je     eed <printf+0x1dd>
        while(*s != 0){
     e43:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
     e46:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
     e48:	84 c0                	test   %al,%al
     e4a:	74 27                	je     e73 <printf+0x163>
     e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e50:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
     e53:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
     e58:	43                   	inc    %ebx
  write(fd, &c, 1);
     e59:	89 44 24 08          	mov    %eax,0x8(%esp)
     e5d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
     e60:	89 44 24 04          	mov    %eax,0x4(%esp)
     e64:	89 3c 24             	mov    %edi,(%esp)
     e67:	e8 5c fd ff ff       	call   bc8 <write>
        while(*s != 0){
     e6c:	0f b6 03             	movzbl (%ebx),%eax
     e6f:	84 c0                	test   %al,%al
     e71:	75 dd                	jne    e50 <printf+0x140>
      state = 0;
     e73:	31 d2                	xor    %edx,%edx
     e75:	e9 f1 fe ff ff       	jmp    d6b <printf+0x5b>
     e7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
     e80:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e87:	b9 0a 00 00 00       	mov    $0xa,%ecx
     e8c:	e9 7b ff ff ff       	jmp    e0c <printf+0xfc>
     e91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
     e98:	b9 01 00 00 00       	mov    $0x1,%ecx
     e9d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
     ea0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     ea4:	89 44 24 04          	mov    %eax,0x4(%esp)
     ea8:	89 3c 24             	mov    %edi,(%esp)
     eab:	88 5d e5             	mov    %bl,-0x1b(%ebp)
     eae:	e8 15 fd ff ff       	call   bc8 <write>
      state = 0;
     eb3:	31 d2                	xor    %edx,%edx
     eb5:	e9 b1 fe ff ff       	jmp    d6b <printf+0x5b>
     eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
     ec0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
     ec3:	8b 03                	mov    (%ebx),%eax
        ap++;
     ec5:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
     ec8:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
     ecb:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
     ece:	b8 01 00 00 00       	mov    $0x1,%eax
     ed3:	89 44 24 08          	mov    %eax,0x8(%esp)
     ed7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     eda:	89 44 24 04          	mov    %eax,0x4(%esp)
     ede:	e8 e5 fc ff ff       	call   bc8 <write>
      state = 0;
     ee3:	31 d2                	xor    %edx,%edx
        ap++;
     ee5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
     ee8:	e9 7e fe ff ff       	jmp    d6b <printf+0x5b>
          s = "(null)";
     eed:	bb 98 12 00 00       	mov    $0x1298,%ebx
        while(*s != 0){
     ef2:	b0 28                	mov    $0x28,%al
     ef4:	e9 57 ff ff ff       	jmp    e50 <printf+0x140>
     ef9:	66 90                	xchg   %ax,%ax
     efb:	66 90                	xchg   %ax,%ax
     efd:	66 90                	xchg   %ax,%ax
     eff:	90                   	nop

00000f00 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     f00:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     f01:	a1 2c 18 00 00       	mov    0x182c,%eax
{
     f06:	89 e5                	mov    %esp,%ebp
     f08:	57                   	push   %edi
     f09:	56                   	push   %esi
     f0a:	53                   	push   %ebx
     f0b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
     f0e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
     f11:	eb 0d                	jmp    f20 <free+0x20>
     f13:	90                   	nop
     f14:	90                   	nop
     f15:	90                   	nop
     f16:	90                   	nop
     f17:	90                   	nop
     f18:	90                   	nop
     f19:	90                   	nop
     f1a:	90                   	nop
     f1b:	90                   	nop
     f1c:	90                   	nop
     f1d:	90                   	nop
     f1e:	90                   	nop
     f1f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     f20:	39 c8                	cmp    %ecx,%eax
     f22:	8b 10                	mov    (%eax),%edx
     f24:	73 32                	jae    f58 <free+0x58>
     f26:	39 d1                	cmp    %edx,%ecx
     f28:	72 04                	jb     f2e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     f2a:	39 d0                	cmp    %edx,%eax
     f2c:	72 32                	jb     f60 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
     f2e:	8b 73 fc             	mov    -0x4(%ebx),%esi
     f31:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
     f34:	39 fa                	cmp    %edi,%edx
     f36:	74 30                	je     f68 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
     f38:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
     f3b:	8b 50 04             	mov    0x4(%eax),%edx
     f3e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
     f41:	39 f1                	cmp    %esi,%ecx
     f43:	74 3c                	je     f81 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
     f45:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
     f47:	5b                   	pop    %ebx
  freep = p;
     f48:	a3 2c 18 00 00       	mov    %eax,0x182c
}
     f4d:	5e                   	pop    %esi
     f4e:	5f                   	pop    %edi
     f4f:	5d                   	pop    %ebp
     f50:	c3                   	ret    
     f51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     f58:	39 d0                	cmp    %edx,%eax
     f5a:	72 04                	jb     f60 <free+0x60>
     f5c:	39 d1                	cmp    %edx,%ecx
     f5e:	72 ce                	jb     f2e <free+0x2e>
{
     f60:	89 d0                	mov    %edx,%eax
     f62:	eb bc                	jmp    f20 <free+0x20>
     f64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
     f68:	8b 7a 04             	mov    0x4(%edx),%edi
     f6b:	01 fe                	add    %edi,%esi
     f6d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
     f70:	8b 10                	mov    (%eax),%edx
     f72:	8b 12                	mov    (%edx),%edx
     f74:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
     f77:	8b 50 04             	mov    0x4(%eax),%edx
     f7a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
     f7d:	39 f1                	cmp    %esi,%ecx
     f7f:	75 c4                	jne    f45 <free+0x45>
    p->s.size += bp->s.size;
     f81:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
     f84:	a3 2c 18 00 00       	mov    %eax,0x182c
    p->s.size += bp->s.size;
     f89:	01 ca                	add    %ecx,%edx
     f8b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     f8e:	8b 53 f8             	mov    -0x8(%ebx),%edx
     f91:	89 10                	mov    %edx,(%eax)
}
     f93:	5b                   	pop    %ebx
     f94:	5e                   	pop    %esi
     f95:	5f                   	pop    %edi
     f96:	5d                   	pop    %ebp
     f97:	c3                   	ret    
     f98:	90                   	nop
     f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000fa0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
     fa0:	55                   	push   %ebp
     fa1:	89 e5                	mov    %esp,%ebp
     fa3:	57                   	push   %edi
     fa4:	56                   	push   %esi
     fa5:	53                   	push   %ebx
     fa6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     fa9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
     fac:	8b 15 2c 18 00 00    	mov    0x182c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     fb2:	8d 78 07             	lea    0x7(%eax),%edi
     fb5:	c1 ef 03             	shr    $0x3,%edi
     fb8:	47                   	inc    %edi
  if((prevp = freep) == 0){
     fb9:	85 d2                	test   %edx,%edx
     fbb:	0f 84 8f 00 00 00    	je     1050 <malloc+0xb0>
     fc1:	8b 02                	mov    (%edx),%eax
     fc3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
     fc6:	39 cf                	cmp    %ecx,%edi
     fc8:	76 66                	jbe    1030 <malloc+0x90>
     fca:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
     fd0:	bb 00 10 00 00       	mov    $0x1000,%ebx
     fd5:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
     fd8:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
     fdf:	eb 10                	jmp    ff1 <malloc+0x51>
     fe1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     fe8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
     fea:	8b 48 04             	mov    0x4(%eax),%ecx
     fed:	39 f9                	cmp    %edi,%ecx
     fef:	73 3f                	jae    1030 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
     ff1:	39 05 2c 18 00 00    	cmp    %eax,0x182c
     ff7:	89 c2                	mov    %eax,%edx
     ff9:	75 ed                	jne    fe8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
     ffb:	89 34 24             	mov    %esi,(%esp)
     ffe:	e8 2d fc ff ff       	call   c30 <sbrk>
  if(p == (char*)-1)
    1003:	83 f8 ff             	cmp    $0xffffffff,%eax
    1006:	74 18                	je     1020 <malloc+0x80>
  hp->s.size = nu;
    1008:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    100b:	83 c0 08             	add    $0x8,%eax
    100e:	89 04 24             	mov    %eax,(%esp)
    1011:	e8 ea fe ff ff       	call   f00 <free>
  return freep;
    1016:	8b 15 2c 18 00 00    	mov    0x182c,%edx
      if((p = morecore(nunits)) == 0)
    101c:	85 d2                	test   %edx,%edx
    101e:	75 c8                	jne    fe8 <malloc+0x48>
        return 0;
  }
}
    1020:	83 c4 1c             	add    $0x1c,%esp
        return 0;
    1023:	31 c0                	xor    %eax,%eax
}
    1025:	5b                   	pop    %ebx
    1026:	5e                   	pop    %esi
    1027:	5f                   	pop    %edi
    1028:	5d                   	pop    %ebp
    1029:	c3                   	ret    
    102a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1030:	39 cf                	cmp    %ecx,%edi
    1032:	74 4c                	je     1080 <malloc+0xe0>
        p->s.size -= nunits;
    1034:	29 f9                	sub    %edi,%ecx
    1036:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1039:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    103c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    103f:	89 15 2c 18 00 00    	mov    %edx,0x182c
}
    1045:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
    1048:	83 c0 08             	add    $0x8,%eax
}
    104b:	5b                   	pop    %ebx
    104c:	5e                   	pop    %esi
    104d:	5f                   	pop    %edi
    104e:	5d                   	pop    %ebp
    104f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    1050:	b8 30 18 00 00       	mov    $0x1830,%eax
    1055:	ba 30 18 00 00       	mov    $0x1830,%edx
    base.s.size = 0;
    105a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
    105c:	a3 2c 18 00 00       	mov    %eax,0x182c
    base.s.size = 0;
    1061:	b8 30 18 00 00       	mov    $0x1830,%eax
    base.s.ptr = freep = prevp = &base;
    1066:	89 15 30 18 00 00    	mov    %edx,0x1830
    base.s.size = 0;
    106c:	89 0d 34 18 00 00    	mov    %ecx,0x1834
    1072:	e9 53 ff ff ff       	jmp    fca <malloc+0x2a>
    1077:	89 f6                	mov    %esi,%esi
    1079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
    1080:	8b 08                	mov    (%eax),%ecx
    1082:	89 0a                	mov    %ecx,(%edx)
    1084:	eb b9                	jmp    103f <malloc+0x9f>
