
_sanity:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
        }
        exit(0);
    }
}

int main(int argc, char **argv){
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	83 ec 10             	sub    $0x10,%esp
	/*if(argc < 2){
		printf(1, "argv missing\n");
		exit(0);
	}*/
	char* arg = argv[1];
   a:	8b 45 0c             	mov    0xc(%ebp),%eax
   d:	8b 58 04             	mov    0x4(%eax),%ebx
	if(strcmp(arg, "exit") == 0)
  10:	b8 3d 0e 00 00       	mov    $0xe3d,%eax
  15:	89 44 24 04          	mov    %eax,0x4(%esp)
  19:	89 1c 24             	mov    %ebx,(%esp)
  1c:	e8 7f 05 00 00       	call   5a0 <strcmp>
  21:	85 c0                	test   %eax,%eax
  23:	75 11                	jne    36 <main+0x36>
		testExitWait();
  25:	e8 e6 00 00 00       	call   110 <testExitWait>
        testPolicy(1);
        testPolicy(2);
        testPolicy(3);
        */
    }
    exit(0);
  2a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  31:	e8 72 07 00 00       	call   7a8 <exit>
	else if(strcmp(arg, "detach") == 0)
  36:	c7 44 24 04 42 0e 00 	movl   $0xe42,0x4(%esp)
  3d:	00 
  3e:	89 1c 24             	mov    %ebx,(%esp)
  41:	e8 5a 05 00 00       	call   5a0 <strcmp>
  46:	85 c0                	test   %eax,%eax
  48:	75 08                	jne    52 <main+0x52>
		testDetach();
  4a:	e8 61 01 00 00       	call   1b0 <testDetach>
  4f:	90                   	nop
  50:	eb d8                	jmp    2a <main+0x2a>
	else if(strcmp(arg, "wait_stat") == 0)
  52:	c7 44 24 04 49 0e 00 	movl   $0xe49,0x4(%esp)
  59:	00 
  5a:	89 1c 24             	mov    %ebx,(%esp)
  5d:	e8 3e 05 00 00       	call   5a0 <strcmp>
  62:	85 c0                	test   %eax,%eax
  64:	74 22                	je     88 <main+0x88>
	else if(strcmp(arg, "policy1") == 0)
  66:	c7 44 24 04 53 0e 00 	movl   $0xe53,0x4(%esp)
  6d:	00 
  6e:	89 1c 24             	mov    %ebx,(%esp)
  71:	e8 2a 05 00 00       	call   5a0 <strcmp>
  76:	85 c0                	test   %eax,%eax
  78:	75 18                	jne    92 <main+0x92>
		testPerf(1);
  7a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  81:	e8 1a 04 00 00       	call   4a0 <testPerf>
  86:	eb a2                	jmp    2a <main+0x2a>
		testWaitStat();
  88:	e8 b3 02 00 00       	call   340 <testWaitStat>
  8d:	8d 76 00             	lea    0x0(%esi),%esi
  90:	eb 98                	jmp    2a <main+0x2a>
	else if(strcmp(arg, "policy2") == 0)
  92:	c7 44 24 04 5b 0e 00 	movl   $0xe5b,0x4(%esp)
  99:	00 
  9a:	89 1c 24             	mov    %ebx,(%esp)
  9d:	e8 fe 04 00 00       	call   5a0 <strcmp>
  a2:	85 c0                	test   %eax,%eax
  a4:	74 4d                	je     f3 <main+0xf3>
	else if(strcmp(arg, "policy3") == 0)
  a6:	c7 44 24 04 63 0e 00 	movl   $0xe63,0x4(%esp)
  ad:	00 
  ae:	89 1c 24             	mov    %ebx,(%esp)
  b1:	e8 ea 04 00 00       	call   5a0 <strcmp>
  b6:	85 c0                	test   %eax,%eax
  b8:	74 28                	je     e2 <main+0xe2>
        testExitWait();
  ba:	e8 51 00 00 00       	call   110 <testExitWait>
  bf:	90                   	nop
		testDetach();
  c0:	e8 eb 00 00 00       	call   1b0 <testDetach>
		testWaitStat();
  c5:	e8 76 02 00 00       	call   340 <testWaitStat>
		testPerf(1);
  ca:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  d1:	e8 ca 03 00 00       	call   4a0 <testPerf>
		testPerf(2);
  d6:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  dd:	e8 be 03 00 00       	call   4a0 <testPerf>
        testPerf(3);
  e2:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
  e9:	e8 b2 03 00 00       	call   4a0 <testPerf>
  ee:	e9 37 ff ff ff       	jmp    2a <main+0x2a>
		testPerf(2);
  f3:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  fa:	e8 a1 03 00 00       	call   4a0 <testPerf>
  ff:	e9 26 ff ff ff       	jmp    2a <main+0x2a>
 104:	66 90                	xchg   %ax,%ax
 106:	66 90                	xchg   %ax,%ax
 108:	66 90                	xchg   %ax,%ax
 10a:	66 90                	xchg   %ax,%ax
 10c:	66 90                	xchg   %ax,%ax
 10e:	66 90                	xchg   %ax,%ax

00000110 <testExitWait>:
void testExitWait(){
 110:	55                   	push   %ebp
    printf(1, "----------test exit wait started\n");
 111:	b9 88 0c 00 00       	mov    $0xc88,%ecx
void testExitWait(){
 116:	89 e5                	mov    %esp,%ebp
 118:	57                   	push   %edi
 119:	56                   	push   %esi
    for (int i = 0; i < 5; i++) {
 11a:	31 f6                	xor    %esi,%esi
void testExitWait(){
 11c:	53                   	push   %ebx
 11d:	83 ec 2c             	sub    $0x2c,%esp
    printf(1, "----------test exit wait started\n");
 120:	89 4c 24 04          	mov    %ecx,0x4(%esp)
            wait(&status);
 124:	8d 7d e4             	lea    -0x1c(%ebp),%edi
    printf(1, "----------test exit wait started\n");
 127:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 12e:	e8 dd 07 00 00       	call   910 <printf>
        pid = fork();
 133:	e8 68 06 00 00       	call   7a0 <fork>
        if (pid > 0) {
 138:	85 c0                	test   %eax,%eax
        pid = fork();
 13a:	89 c3                	mov    %eax,%ebx
        if (pid > 0) {
 13c:	7e 53                	jle    191 <testExitWait+0x81>
            wait(&status);
 13e:	89 3c 24             	mov    %edi,(%esp)
    for (int i = 0; i < 5; i++) {
 141:	46                   	inc    %esi
            wait(&status);
 142:	e8 69 06 00 00       	call   7b0 <wait>
			kill(pid);
 147:	89 1c 24             	mov    %ebx,(%esp)
 14a:	e8 89 06 00 00       	call   7d8 <kill>
            printf(1, "process with pid %d exited with status %d\n", pid, status);
 14f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 152:	ba ac 0c 00 00       	mov    $0xcac,%edx
 157:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 15b:	89 54 24 04          	mov    %edx,0x4(%esp)
 15f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 166:	89 44 24 0c          	mov    %eax,0xc(%esp)
 16a:	e8 a1 07 00 00       	call   910 <printf>
    for (int i = 0; i < 5; i++) {
 16f:	83 fe 05             	cmp    $0x5,%esi
 172:	75 bf                	jne    133 <testExitWait+0x23>
    printf(1, "----------test exit wait ended\n");
 174:	b8 d8 0c 00 00       	mov    $0xcd8,%eax
 179:	89 44 24 04          	mov    %eax,0x4(%esp)
 17d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 184:	e8 87 07 00 00       	call   910 <printf>
}
 189:	83 c4 2c             	add    $0x2c,%esp
 18c:	5b                   	pop    %ebx
 18d:	5e                   	pop    %esi
 18e:	5f                   	pop    %edi
 18f:	5d                   	pop    %ebp
 190:	c3                   	ret    
            sleep(5);
 191:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 198:	e8 9b 06 00 00       	call   838 <sleep>
            exit(i);
 19d:	89 34 24             	mov    %esi,(%esp)
 1a0:	e8 03 06 00 00       	call   7a8 <exit>
 1a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001b0 <testDetach>:
void testDetach(){
 1b0:	55                   	push   %ebp
    printf(1, "----------test detach started\n");
 1b1:	b8 f8 0c 00 00       	mov    $0xcf8,%eax
void testDetach(){
 1b6:	89 e5                	mov    %esp,%ebp
 1b8:	53                   	push   %ebx
 1b9:	83 ec 14             	sub    $0x14,%esp
    printf(1, "----------test detach started\n");
 1bc:	89 44 24 04          	mov    %eax,0x4(%esp)
 1c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1c7:	e8 44 07 00 00       	call   910 <printf>
    pid = fork(); 
 1cc:	e8 cf 05 00 00       	call   7a0 <fork>
    if(pid > 0) {
 1d1:	85 c0                	test   %eax,%eax
    pid = fork(); 
 1d3:	89 c3                	mov    %eax,%ebx
    if(pid > 0) {
 1d5:	7e 67                	jle    23e <testDetach+0x8e>
        first_status = detach(pid); // status = 0
 1d7:	89 04 24             	mov    %eax,(%esp)
 1da:	e8 69 06 00 00       	call   848 <detach>
        printf(1, "first_status: %d\n", first_status);
 1df:	ba 80 0d 00 00       	mov    $0xd80,%edx
 1e4:	89 54 24 04          	mov    %edx,0x4(%esp)
 1e8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1ef:	89 44 24 08          	mov    %eax,0x8(%esp)
 1f3:	e8 18 07 00 00       	call   910 <printf>
        second_status = detach(pid); // status = -1, because this process has already detached this child, and it doesn’t have this child anymore.
 1f8:	89 1c 24             	mov    %ebx,(%esp)
 1fb:	e8 48 06 00 00       	call   848 <detach>
        printf(1, "second_status: %d\n", second_status);
 200:	b9 92 0d 00 00       	mov    $0xd92,%ecx
 205:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 209:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 210:	89 44 24 08          	mov    %eax,0x8(%esp)
 214:	e8 f7 06 00 00       	call   910 <printf>
        third_status = detach(77); // status = -1, because this process doesn’t have a child with this pid.
 219:	c7 04 24 4d 00 00 00 	movl   $0x4d,(%esp)
 220:	e8 23 06 00 00       	call   848 <detach>
        printf(1, "third_status: %d\n", third_status);
 225:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 22c:	89 44 24 08          	mov    %eax,0x8(%esp)
 230:	b8 a5 0d 00 00       	mov    $0xda5,%eax
 235:	89 44 24 04          	mov    %eax,0x4(%esp)
 239:	e8 d2 06 00 00       	call   910 <printf>
	kill(pid);
 23e:	89 1c 24             	mov    %ebx,(%esp)
 241:	e8 92 05 00 00       	call   7d8 <kill>
    printf(1, "----------test detach ended\n");
 246:	b8 b7 0d 00 00       	mov    $0xdb7,%eax
 24b:	89 44 24 04          	mov    %eax,0x4(%esp)
 24f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 256:	e8 b5 06 00 00       	call   910 <printf>
}
 25b:	83 c4 14             	add    $0x14,%esp
 25e:	5b                   	pop    %ebx
 25f:	5d                   	pop    %ebp
 260:	c3                   	ret    
 261:	eb 0d                	jmp    270 <printPerf>
 263:	90                   	nop
 264:	90                   	nop
 265:	90                   	nop
 266:	90                   	nop
 267:	90                   	nop
 268:	90                   	nop
 269:	90                   	nop
 26a:	90                   	nop
 26b:	90                   	nop
 26c:	90                   	nop
 26d:	90                   	nop
 26e:	90                   	nop
 26f:	90                   	nop

00000270 <printPerf>:
void printPerf(struct perf *performance) {
 270:	55                   	push   %ebp
    printf(1, "pref:\n");
 271:	b8 d4 0d 00 00       	mov    $0xdd4,%eax
void printPerf(struct perf *performance) {
 276:	89 e5                	mov    %esp,%ebp
 278:	53                   	push   %ebx
 279:	83 ec 14             	sub    $0x14,%esp
 27c:	8b 5d 08             	mov    0x8(%ebp),%ebx
    printf(1, "pref:\n");
 27f:	89 44 24 04          	mov    %eax,0x4(%esp)
 283:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 28a:	e8 81 06 00 00       	call   910 <printf>
    printf(1, "\tctime: %d\n", performance->ctime);
 28f:	ba db 0d 00 00       	mov    $0xddb,%edx
 294:	8b 03                	mov    (%ebx),%eax
 296:	89 54 24 04          	mov    %edx,0x4(%esp)
 29a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2a1:	89 44 24 08          	mov    %eax,0x8(%esp)
 2a5:	e8 66 06 00 00       	call   910 <printf>
    printf(1, "\tttime: %d\n", performance->ttime);
 2aa:	8b 43 04             	mov    0x4(%ebx),%eax
 2ad:	b9 e7 0d 00 00       	mov    $0xde7,%ecx
 2b2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 2b6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2bd:	89 44 24 08          	mov    %eax,0x8(%esp)
 2c1:	e8 4a 06 00 00       	call   910 <printf>
    printf(1, "\tstime: %d\n", performance->stime);
 2c6:	8b 43 08             	mov    0x8(%ebx),%eax
 2c9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2d0:	89 44 24 08          	mov    %eax,0x8(%esp)
 2d4:	b8 f3 0d 00 00       	mov    $0xdf3,%eax
 2d9:	89 44 24 04          	mov    %eax,0x4(%esp)
 2dd:	e8 2e 06 00 00       	call   910 <printf>
    printf(1, "\tretime: %d\n", performance->retime);
 2e2:	8b 43 0c             	mov    0xc(%ebx),%eax
 2e5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2ec:	89 44 24 08          	mov    %eax,0x8(%esp)
 2f0:	b8 ff 0d 00 00       	mov    $0xdff,%eax
 2f5:	89 44 24 04          	mov    %eax,0x4(%esp)
 2f9:	e8 12 06 00 00       	call   910 <printf>
    printf(1, "\trutime: %d\n", performance->rutime);
 2fe:	8b 43 10             	mov    0x10(%ebx),%eax
 301:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 308:	89 44 24 08          	mov    %eax,0x8(%esp)
 30c:	b8 0c 0e 00 00       	mov    $0xe0c,%eax
 311:	89 44 24 04          	mov    %eax,0x4(%esp)
 315:	e8 f6 05 00 00       	call   910 <printf>
    printf(1, "\n\tTurnaround time: %d\n", (performance->ttime - performance->ctime));
 31a:	8b 43 04             	mov    0x4(%ebx),%eax
 31d:	b9 19 0e 00 00       	mov    $0xe19,%ecx
 322:	8b 13                	mov    (%ebx),%edx
 324:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 328:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 32f:	29 d0                	sub    %edx,%eax
 331:	89 44 24 08          	mov    %eax,0x8(%esp)
 335:	e8 d6 05 00 00       	call   910 <printf>
}
 33a:	83 c4 14             	add    $0x14,%esp
 33d:	5b                   	pop    %ebx
 33e:	5d                   	pop    %ebp
 33f:	c3                   	ret    

00000340 <testWaitStat>:
void testWaitStat(){
 340:	55                   	push   %ebp
    printf(1, "----------test wait_stat started\n");
 341:	b9 18 0d 00 00       	mov    $0xd18,%ecx
void testWaitStat(){
 346:	89 e5                	mov    %esp,%ebp
 348:	57                   	push   %edi
 349:	56                   	push   %esi
 34a:	53                   	push   %ebx
    for (int i = 0; i < 5; i++) {
 34b:	31 db                	xor    %ebx,%ebx
void testWaitStat(){
 34d:	83 ec 3c             	sub    $0x3c,%esp
    printf(1, "----------test wait_stat started\n");
 350:	89 4c 24 04          	mov    %ecx,0x4(%esp)
            wait_stat(&status, &perf);
 354:	8d 75 d4             	lea    -0x2c(%ebp),%esi
    printf(1, "----------test wait_stat started\n");
 357:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 35e:	e8 ad 05 00 00       	call   910 <printf>
        pid = fork();
 363:	e8 38 04 00 00       	call   7a0 <fork>
        if (pid > 0) {
 368:	85 c0                	test   %eax,%eax
        pid = fork();
 36a:	89 c7                	mov    %eax,%edi
        if (pid > 0) {
 36c:	7e 62                	jle    3d0 <testWaitStat+0x90>
            wait_stat(&status, &perf);
 36e:	8d 45 d0             	lea    -0x30(%ebp),%eax
    for (int i = 0; i < 5; i++) {
 371:	43                   	inc    %ebx
            wait_stat(&status, &perf);
 372:	89 74 24 04          	mov    %esi,0x4(%esp)
 376:	89 04 24             	mov    %eax,(%esp)
 379:	e8 e2 04 00 00       	call   860 <wait_stat>
            printf(1, "process with pid %d exited with status %d\n", pid, status);
 37e:	8b 45 d0             	mov    -0x30(%ebp),%eax
 381:	ba ac 0c 00 00       	mov    $0xcac,%edx
 386:	89 54 24 04          	mov    %edx,0x4(%esp)
 38a:	89 7c 24 08          	mov    %edi,0x8(%esp)
 38e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 395:	89 44 24 0c          	mov    %eax,0xc(%esp)
 399:	e8 72 05 00 00       	call   910 <printf>
			kill(pid);
 39e:	89 3c 24             	mov    %edi,(%esp)
 3a1:	e8 32 04 00 00       	call   7d8 <kill>
            printPerf(&perf);
 3a6:	89 34 24             	mov    %esi,(%esp)
 3a9:	e8 c2 fe ff ff       	call   270 <printPerf>
    for (int i = 0; i < 5; i++) {
 3ae:	83 fb 05             	cmp    $0x5,%ebx
 3b1:	75 b0                	jne    363 <testWaitStat+0x23>
    printf(1, "----------test wait_stat ended\n");
 3b3:	b8 3c 0d 00 00       	mov    $0xd3c,%eax
 3b8:	89 44 24 04          	mov    %eax,0x4(%esp)
 3bc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 3c3:	e8 48 05 00 00       	call   910 <printf>
}
 3c8:	83 c4 3c             	add    $0x3c,%esp
 3cb:	5b                   	pop    %ebx
 3cc:	5e                   	pop    %esi
 3cd:	5f                   	pop    %edi
 3ce:	5d                   	pop    %ebp
 3cf:	c3                   	ret    
            sleep(5);
 3d0:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 3d7:	e8 5c 04 00 00       	call   838 <sleep>
            exit(i);
 3dc:	89 1c 24             	mov    %ebx,(%esp)
 3df:	e8 c4 03 00 00       	call   7a8 <exit>
 3e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000003f0 <testPolicy>:
void testPolicy(int policyNum) {
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	56                   	push   %esi
 3f4:	53                   	push   %ebx
    for (int i = 0; i < nProcs; i++) {
 3f5:	31 db                	xor    %ebx,%ebx
void testPolicy(int policyNum) {
 3f7:	83 ec 20             	sub    $0x20,%esp
 3fa:	8b 75 08             	mov    0x8(%ebp),%esi
	policy(policyNum);
 3fd:	89 34 24             	mov    %esi,(%esp)
 400:	e8 53 04 00 00       	call   858 <policy>
 405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        pid = fork();
 410:	e8 8b 03 00 00       	call   7a0 <fork>
        if (pid < 0) {
 415:	85 c0                	test   %eax,%eax
 417:	78 3f                	js     458 <testPolicy+0x68>
        } else if (pid == 0) {
 419:	74 54                	je     46f <testPolicy+0x7f>
		kill(pid);
 41b:	89 04 24             	mov    %eax,(%esp)
    for (int i = 0; i < nProcs; i++) {
 41e:	43                   	inc    %ebx
 41f:	90                   	nop
		kill(pid);
 420:	e8 b3 03 00 00       	call   7d8 <kill>
    for (int i = 0; i < nProcs; i++) {
 425:	83 fb 0a             	cmp    $0xa,%ebx
 428:	75 e6                	jne    410 <testPolicy+0x20>
				pr = 1;
 42a:	bb 0a 00 00 00       	mov    $0xa,%ebx
 42f:	8d 75 f4             	lea    -0xc(%ebp),%esi
 432:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        wait(&status);
 440:	89 34 24             	mov    %esi,(%esp)
 443:	e8 68 03 00 00       	call   7b0 <wait>
    for (int j = 0; j < nProcs; j++) {
 448:	4b                   	dec    %ebx
 449:	75 f5                	jne    440 <testPolicy+0x50>
}
 44b:	83 c4 20             	add    $0x20,%esp
 44e:	5b                   	pop    %ebx
 44f:	5e                   	pop    %esi
 450:	5d                   	pop    %ebp
 451:	c3                   	ret    
 452:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			printf(1, "fork failed\n");
 458:	b8 30 0e 00 00       	mov    $0xe30,%eax
 45d:	89 44 24 04          	mov    %eax,0x4(%esp)
 461:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 468:	e8 a3 04 00 00       	call   910 <printf>
            break;
 46d:	eb bb                	jmp    42a <testPolicy+0x3a>
			if(pr == 0 && policyNum != 3)
 46f:	85 db                	test   %ebx,%ebx
 471:	75 0b                	jne    47e <testPolicy+0x8e>
				pr = 1;
 473:	83 fe 03             	cmp    $0x3,%esi
 476:	b8 01 00 00 00       	mov    $0x1,%eax
 47b:	0f 45 d8             	cmovne %eax,%ebx
			priority(pr);
 47e:	89 1c 24             	mov    %ebx,(%esp)
 481:	e8 ca 03 00 00       	call   850 <priority>
            sleep(10);
 486:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
 48d:	e8 a6 03 00 00       	call   838 <sleep>
            exit(0);
 492:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 499:	e8 0a 03 00 00       	call   7a8 <exit>
 49e:	66 90                	xchg   %ax,%ax

000004a0 <testPerf>:
void testPerf(int policyNum){
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	56                   	push   %esi
 4a5:	53                   	push   %ebx
 4a6:	83 ec 3c             	sub    $0x3c,%esp
    printf(1, "----------test policy %d started\n", policyNum);
 4a9:	8b 45 08             	mov    0x8(%ebp),%eax
 4ac:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 4b3:	89 44 24 08          	mov    %eax,0x8(%esp)
 4b7:	b8 5c 0d 00 00       	mov    $0xd5c,%eax
 4bc:	89 44 24 04          	mov    %eax,0x4(%esp)
 4c0:	e8 4b 04 00 00       	call   910 <printf>
    policy(policyNum);
 4c5:	8b 45 08             	mov    0x8(%ebp),%eax
 4c8:	89 04 24             	mov    %eax,(%esp)
 4cb:	e8 88 03 00 00       	call   858 <policy>
    pid1 = fork();
 4d0:	e8 cb 02 00 00       	call   7a0 <fork>
    if (pid1 > 0) {
 4d5:	85 c0                	test   %eax,%eax
 4d7:	7f 47                	jg     520 <testPerf+0x80>
        for (int i = 0; i < nProcs; i++) {
 4d9:	31 db                	xor    %ebx,%ebx
                wait_stat(&status2, &perf2);
 4db:	8d 7d d4             	lea    -0x2c(%ebp),%edi
 4de:	66 90                	xchg   %ax,%ax
            pid2 = fork();
 4e0:	e8 bb 02 00 00       	call   7a0 <fork>
            if (pid2 > 0) {
 4e5:	85 c0                	test   %eax,%eax
            pid2 = fork();
 4e7:	89 c6                	mov    %eax,%esi
            if (pid2 > 0) {
 4e9:	7e 61                	jle    54c <testPerf+0xac>
                sleep(5);
 4eb:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
        for (int i = 0; i < nProcs; i++) {
 4f2:	43                   	inc    %ebx
                sleep(5);
 4f3:	e8 40 03 00 00       	call   838 <sleep>
                wait_stat(&status2, &perf2);
 4f8:	8d 45 d0             	lea    -0x30(%ebp),%eax
 4fb:	89 7c 24 04          	mov    %edi,0x4(%esp)
 4ff:	89 04 24             	mov    %eax,(%esp)
 502:	e8 59 03 00 00       	call   860 <wait_stat>
				kill(pid2);
 507:	89 34 24             	mov    %esi,(%esp)
 50a:	e8 c9 02 00 00       	call   7d8 <kill>
        for (int i = 0; i < nProcs; i++) {
 50f:	83 fb 0a             	cmp    $0xa,%ebx
 512:	75 cc                	jne    4e0 <testPerf+0x40>
        exit(0);
 514:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 51b:	e8 88 02 00 00       	call   7a8 <exit>
        wait_stat(&status1, &perf1);
 520:	8d 75 d4             	lea    -0x2c(%ebp),%esi
 523:	89 c3                	mov    %eax,%ebx
 525:	8d 45 d0             	lea    -0x30(%ebp),%eax
 528:	89 74 24 04          	mov    %esi,0x4(%esp)
 52c:	89 04 24             	mov    %eax,(%esp)
 52f:	e8 2c 03 00 00       	call   860 <wait_stat>
        printPerf(&perf1);
 534:	89 34 24             	mov    %esi,(%esp)
 537:	e8 34 fd ff ff       	call   270 <printPerf>
		kill(pid1);
 53c:	89 1c 24             	mov    %ebx,(%esp)
 53f:	e8 94 02 00 00       	call   7d8 <kill>
}
 544:	83 c4 3c             	add    $0x3c,%esp
 547:	5b                   	pop    %ebx
 548:	5e                   	pop    %esi
 549:	5f                   	pop    %edi
 54a:	5d                   	pop    %ebp
 54b:	c3                   	ret    
				if(pr == 0 && policyNum != 3)
 54c:	85 db                	test   %ebx,%ebx
 54e:	75 0c                	jne    55c <testPerf+0xbc>
					pr = 1;
 550:	83 7d 08 03          	cmpl   $0x3,0x8(%ebp)
 554:	b8 01 00 00 00       	mov    $0x1,%eax
 559:	0f 45 d8             	cmovne %eax,%ebx
				priority(pr);
 55c:	89 1c 24             	mov    %ebx,(%esp)
 55f:	e8 ec 02 00 00       	call   850 <priority>
                sleep(5);
 564:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 56b:	e8 c8 02 00 00       	call   838 <sleep>
                exit(0);
 570:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 577:	e8 2c 02 00 00       	call   7a8 <exit>
 57c:	66 90                	xchg   %ax,%ax
 57e:	66 90                	xchg   %ax,%ax

00000580 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	8b 45 08             	mov    0x8(%ebp),%eax
 586:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 589:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 58a:	89 c2                	mov    %eax,%edx
 58c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 590:	41                   	inc    %ecx
 591:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 595:	42                   	inc    %edx
 596:	84 db                	test   %bl,%bl
 598:	88 5a ff             	mov    %bl,-0x1(%edx)
 59b:	75 f3                	jne    590 <strcpy+0x10>
    ;
  return os;
}
 59d:	5b                   	pop    %ebx
 59e:	5d                   	pop    %ebp
 59f:	c3                   	ret    

000005a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 5a6:	53                   	push   %ebx
 5a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 5aa:	0f b6 01             	movzbl (%ecx),%eax
 5ad:	0f b6 13             	movzbl (%ebx),%edx
 5b0:	84 c0                	test   %al,%al
 5b2:	75 18                	jne    5cc <strcmp+0x2c>
 5b4:	eb 22                	jmp    5d8 <strcmp+0x38>
 5b6:	8d 76 00             	lea    0x0(%esi),%esi
 5b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 5c0:	41                   	inc    %ecx
  while(*p && *p == *q)
 5c1:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 5c4:	43                   	inc    %ebx
 5c5:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
 5c8:	84 c0                	test   %al,%al
 5ca:	74 0c                	je     5d8 <strcmp+0x38>
 5cc:	38 d0                	cmp    %dl,%al
 5ce:	74 f0                	je     5c0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
 5d0:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 5d1:	29 d0                	sub    %edx,%eax
}
 5d3:	5d                   	pop    %ebp
 5d4:	c3                   	ret    
 5d5:	8d 76 00             	lea    0x0(%esi),%esi
 5d8:	5b                   	pop    %ebx
 5d9:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 5db:	29 d0                	sub    %edx,%eax
}
 5dd:	5d                   	pop    %ebp
 5de:	c3                   	ret    
 5df:	90                   	nop

000005e0 <strlen>:

uint
strlen(const char *s)
{
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 5e6:	80 39 00             	cmpb   $0x0,(%ecx)
 5e9:	74 15                	je     600 <strlen+0x20>
 5eb:	31 d2                	xor    %edx,%edx
 5ed:	8d 76 00             	lea    0x0(%esi),%esi
 5f0:	42                   	inc    %edx
 5f1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 5f5:	89 d0                	mov    %edx,%eax
 5f7:	75 f7                	jne    5f0 <strlen+0x10>
    ;
  return n;
}
 5f9:	5d                   	pop    %ebp
 5fa:	c3                   	ret    
 5fb:	90                   	nop
 5fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
 600:	31 c0                	xor    %eax,%eax
}
 602:	5d                   	pop    %ebp
 603:	c3                   	ret    
 604:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 60a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000610 <memset>:

void*
memset(void *dst, int c, uint n)
{
 610:	55                   	push   %ebp
 611:	89 e5                	mov    %esp,%ebp
 613:	8b 55 08             	mov    0x8(%ebp),%edx
 616:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 617:	8b 4d 10             	mov    0x10(%ebp),%ecx
 61a:	8b 45 0c             	mov    0xc(%ebp),%eax
 61d:	89 d7                	mov    %edx,%edi
 61f:	fc                   	cld    
 620:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 622:	5f                   	pop    %edi
 623:	89 d0                	mov    %edx,%eax
 625:	5d                   	pop    %ebp
 626:	c3                   	ret    
 627:	89 f6                	mov    %esi,%esi
 629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000630 <strchr>:

char*
strchr(const char *s, char c)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	8b 45 08             	mov    0x8(%ebp),%eax
 636:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 63a:	0f b6 10             	movzbl (%eax),%edx
 63d:	84 d2                	test   %dl,%dl
 63f:	74 1b                	je     65c <strchr+0x2c>
    if(*s == c)
 641:	38 d1                	cmp    %dl,%cl
 643:	75 0f                	jne    654 <strchr+0x24>
 645:	eb 17                	jmp    65e <strchr+0x2e>
 647:	89 f6                	mov    %esi,%esi
 649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 650:	38 ca                	cmp    %cl,%dl
 652:	74 0a                	je     65e <strchr+0x2e>
  for(; *s; s++)
 654:	40                   	inc    %eax
 655:	0f b6 10             	movzbl (%eax),%edx
 658:	84 d2                	test   %dl,%dl
 65a:	75 f4                	jne    650 <strchr+0x20>
      return (char*)s;
  return 0;
 65c:	31 c0                	xor    %eax,%eax
}
 65e:	5d                   	pop    %ebp
 65f:	c3                   	ret    

00000660 <gets>:

char*
gets(char *buf, int max)
{
 660:	55                   	push   %ebp
 661:	89 e5                	mov    %esp,%ebp
 663:	57                   	push   %edi
 664:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 665:	31 f6                	xor    %esi,%esi
{
 667:	53                   	push   %ebx
 668:	83 ec 3c             	sub    $0x3c,%esp
 66b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
 66e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 671:	eb 32                	jmp    6a5 <gets+0x45>
 673:	90                   	nop
 674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 678:	ba 01 00 00 00       	mov    $0x1,%edx
 67d:	89 54 24 08          	mov    %edx,0x8(%esp)
 681:	89 7c 24 04          	mov    %edi,0x4(%esp)
 685:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 68c:	e8 2f 01 00 00       	call   7c0 <read>
    if(cc < 1)
 691:	85 c0                	test   %eax,%eax
 693:	7e 19                	jle    6ae <gets+0x4e>
      break;
    buf[i++] = c;
 695:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 699:	43                   	inc    %ebx
 69a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
 69d:	3c 0a                	cmp    $0xa,%al
 69f:	74 1f                	je     6c0 <gets+0x60>
 6a1:	3c 0d                	cmp    $0xd,%al
 6a3:	74 1b                	je     6c0 <gets+0x60>
  for(i=0; i+1 < max; ){
 6a5:	46                   	inc    %esi
 6a6:	3b 75 0c             	cmp    0xc(%ebp),%esi
 6a9:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 6ac:	7c ca                	jl     678 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 6ae:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 6b1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 6b4:	8b 45 08             	mov    0x8(%ebp),%eax
 6b7:	83 c4 3c             	add    $0x3c,%esp
 6ba:	5b                   	pop    %ebx
 6bb:	5e                   	pop    %esi
 6bc:	5f                   	pop    %edi
 6bd:	5d                   	pop    %ebp
 6be:	c3                   	ret    
 6bf:	90                   	nop
 6c0:	8b 45 08             	mov    0x8(%ebp),%eax
 6c3:	01 c6                	add    %eax,%esi
 6c5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6c8:	eb e4                	jmp    6ae <gets+0x4e>
 6ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000006d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 6d0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 6d1:	31 c0                	xor    %eax,%eax
{
 6d3:	89 e5                	mov    %esp,%ebp
 6d5:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 6d8:	89 44 24 04          	mov    %eax,0x4(%esp)
 6dc:	8b 45 08             	mov    0x8(%ebp),%eax
{
 6df:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 6e2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 6e5:	89 04 24             	mov    %eax,(%esp)
 6e8:	e8 fb 00 00 00       	call   7e8 <open>
  if(fd < 0)
 6ed:	85 c0                	test   %eax,%eax
 6ef:	78 2f                	js     720 <stat+0x50>
 6f1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 6f3:	8b 45 0c             	mov    0xc(%ebp),%eax
 6f6:	89 1c 24             	mov    %ebx,(%esp)
 6f9:	89 44 24 04          	mov    %eax,0x4(%esp)
 6fd:	e8 fe 00 00 00       	call   800 <fstat>
  close(fd);
 702:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 705:	89 c6                	mov    %eax,%esi
  close(fd);
 707:	e8 c4 00 00 00       	call   7d0 <close>
  return r;
}
 70c:	89 f0                	mov    %esi,%eax
 70e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 711:	8b 75 fc             	mov    -0x4(%ebp),%esi
 714:	89 ec                	mov    %ebp,%esp
 716:	5d                   	pop    %ebp
 717:	c3                   	ret    
 718:	90                   	nop
 719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 720:	be ff ff ff ff       	mov    $0xffffffff,%esi
 725:	eb e5                	jmp    70c <stat+0x3c>
 727:	89 f6                	mov    %esi,%esi
 729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000730 <atoi>:

int
atoi(const char *s)
{
 730:	55                   	push   %ebp
 731:	89 e5                	mov    %esp,%ebp
 733:	8b 4d 08             	mov    0x8(%ebp),%ecx
 736:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 737:	0f be 11             	movsbl (%ecx),%edx
 73a:	88 d0                	mov    %dl,%al
 73c:	2c 30                	sub    $0x30,%al
 73e:	3c 09                	cmp    $0x9,%al
  n = 0;
 740:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 745:	77 1e                	ja     765 <atoi+0x35>
 747:	89 f6                	mov    %esi,%esi
 749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 750:	41                   	inc    %ecx
 751:	8d 04 80             	lea    (%eax,%eax,4),%eax
 754:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 758:	0f be 11             	movsbl (%ecx),%edx
 75b:	88 d3                	mov    %dl,%bl
 75d:	80 eb 30             	sub    $0x30,%bl
 760:	80 fb 09             	cmp    $0x9,%bl
 763:	76 eb                	jbe    750 <atoi+0x20>
  return n;
}
 765:	5b                   	pop    %ebx
 766:	5d                   	pop    %ebp
 767:	c3                   	ret    
 768:	90                   	nop
 769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000770 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 770:	55                   	push   %ebp
 771:	89 e5                	mov    %esp,%ebp
 773:	56                   	push   %esi
 774:	8b 45 08             	mov    0x8(%ebp),%eax
 777:	53                   	push   %ebx
 778:	8b 5d 10             	mov    0x10(%ebp),%ebx
 77b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 77e:	85 db                	test   %ebx,%ebx
 780:	7e 1a                	jle    79c <memmove+0x2c>
 782:	31 d2                	xor    %edx,%edx
 784:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 78a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 790:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 794:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 797:	42                   	inc    %edx
  while(n-- > 0)
 798:	39 d3                	cmp    %edx,%ebx
 79a:	75 f4                	jne    790 <memmove+0x20>
  return vdst;
}
 79c:	5b                   	pop    %ebx
 79d:	5e                   	pop    %esi
 79e:	5d                   	pop    %ebp
 79f:	c3                   	ret    

000007a0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 7a0:	b8 01 00 00 00       	mov    $0x1,%eax
 7a5:	cd 40                	int    $0x40
 7a7:	c3                   	ret    

000007a8 <exit>:
SYSCALL(exit)
 7a8:	b8 02 00 00 00       	mov    $0x2,%eax
 7ad:	cd 40                	int    $0x40
 7af:	c3                   	ret    

000007b0 <wait>:
SYSCALL(wait)
 7b0:	b8 03 00 00 00       	mov    $0x3,%eax
 7b5:	cd 40                	int    $0x40
 7b7:	c3                   	ret    

000007b8 <pipe>:
SYSCALL(pipe)
 7b8:	b8 04 00 00 00       	mov    $0x4,%eax
 7bd:	cd 40                	int    $0x40
 7bf:	c3                   	ret    

000007c0 <read>:
SYSCALL(read)
 7c0:	b8 05 00 00 00       	mov    $0x5,%eax
 7c5:	cd 40                	int    $0x40
 7c7:	c3                   	ret    

000007c8 <write>:
SYSCALL(write)
 7c8:	b8 10 00 00 00       	mov    $0x10,%eax
 7cd:	cd 40                	int    $0x40
 7cf:	c3                   	ret    

000007d0 <close>:
SYSCALL(close)
 7d0:	b8 15 00 00 00       	mov    $0x15,%eax
 7d5:	cd 40                	int    $0x40
 7d7:	c3                   	ret    

000007d8 <kill>:
SYSCALL(kill)
 7d8:	b8 06 00 00 00       	mov    $0x6,%eax
 7dd:	cd 40                	int    $0x40
 7df:	c3                   	ret    

000007e0 <exec>:
SYSCALL(exec)
 7e0:	b8 07 00 00 00       	mov    $0x7,%eax
 7e5:	cd 40                	int    $0x40
 7e7:	c3                   	ret    

000007e8 <open>:
SYSCALL(open)
 7e8:	b8 0f 00 00 00       	mov    $0xf,%eax
 7ed:	cd 40                	int    $0x40
 7ef:	c3                   	ret    

000007f0 <mknod>:
SYSCALL(mknod)
 7f0:	b8 11 00 00 00       	mov    $0x11,%eax
 7f5:	cd 40                	int    $0x40
 7f7:	c3                   	ret    

000007f8 <unlink>:
SYSCALL(unlink)
 7f8:	b8 12 00 00 00       	mov    $0x12,%eax
 7fd:	cd 40                	int    $0x40
 7ff:	c3                   	ret    

00000800 <fstat>:
SYSCALL(fstat)
 800:	b8 08 00 00 00       	mov    $0x8,%eax
 805:	cd 40                	int    $0x40
 807:	c3                   	ret    

00000808 <link>:
SYSCALL(link)
 808:	b8 13 00 00 00       	mov    $0x13,%eax
 80d:	cd 40                	int    $0x40
 80f:	c3                   	ret    

00000810 <mkdir>:
SYSCALL(mkdir)
 810:	b8 14 00 00 00       	mov    $0x14,%eax
 815:	cd 40                	int    $0x40
 817:	c3                   	ret    

00000818 <chdir>:
SYSCALL(chdir)
 818:	b8 09 00 00 00       	mov    $0x9,%eax
 81d:	cd 40                	int    $0x40
 81f:	c3                   	ret    

00000820 <dup>:
SYSCALL(dup)
 820:	b8 0a 00 00 00       	mov    $0xa,%eax
 825:	cd 40                	int    $0x40
 827:	c3                   	ret    

00000828 <getpid>:
SYSCALL(getpid)
 828:	b8 0b 00 00 00       	mov    $0xb,%eax
 82d:	cd 40                	int    $0x40
 82f:	c3                   	ret    

00000830 <sbrk>:
SYSCALL(sbrk)
 830:	b8 0c 00 00 00       	mov    $0xc,%eax
 835:	cd 40                	int    $0x40
 837:	c3                   	ret    

00000838 <sleep>:
SYSCALL(sleep)
 838:	b8 0d 00 00 00       	mov    $0xd,%eax
 83d:	cd 40                	int    $0x40
 83f:	c3                   	ret    

00000840 <uptime>:
SYSCALL(uptime)
 840:	b8 0e 00 00 00       	mov    $0xe,%eax
 845:	cd 40                	int    $0x40
 847:	c3                   	ret    

00000848 <detach>:
SYSCALL(detach)
 848:	b8 16 00 00 00       	mov    $0x16,%eax
 84d:	cd 40                	int    $0x40
 84f:	c3                   	ret    

00000850 <priority>:
SYSCALL(priority)
 850:	b8 17 00 00 00       	mov    $0x17,%eax
 855:	cd 40                	int    $0x40
 857:	c3                   	ret    

00000858 <policy>:
SYSCALL(policy)
 858:	b8 18 00 00 00       	mov    $0x18,%eax
 85d:	cd 40                	int    $0x40
 85f:	c3                   	ret    

00000860 <wait_stat>:
SYSCALL(wait_stat)
 860:	b8 19 00 00 00       	mov    $0x19,%eax
 865:	cd 40                	int    $0x40
 867:	c3                   	ret    
 868:	66 90                	xchg   %ax,%ax
 86a:	66 90                	xchg   %ax,%ax
 86c:	66 90                	xchg   %ax,%ax
 86e:	66 90                	xchg   %ax,%ax

00000870 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 870:	55                   	push   %ebp
 871:	89 e5                	mov    %esp,%ebp
 873:	57                   	push   %edi
 874:	56                   	push   %esi
 875:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 876:	89 d3                	mov    %edx,%ebx
 878:	c1 eb 1f             	shr    $0x1f,%ebx
{
 87b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 87e:	84 db                	test   %bl,%bl
{
 880:	89 45 c0             	mov    %eax,-0x40(%ebp)
 883:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 885:	74 79                	je     900 <printint+0x90>
 887:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 88b:	74 73                	je     900 <printint+0x90>
    neg = 1;
    x = -xx;
 88d:	f7 d8                	neg    %eax
    neg = 1;
 88f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 896:	31 f6                	xor    %esi,%esi
 898:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 89b:	eb 05                	jmp    8a2 <printint+0x32>
 89d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 8a0:	89 fe                	mov    %edi,%esi
 8a2:	31 d2                	xor    %edx,%edx
 8a4:	f7 f1                	div    %ecx
 8a6:	8d 7e 01             	lea    0x1(%esi),%edi
 8a9:	0f b6 92 74 0e 00 00 	movzbl 0xe74(%edx),%edx
  }while((x /= base) != 0);
 8b0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 8b2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 8b5:	75 e9                	jne    8a0 <printint+0x30>
  if(neg)
 8b7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 8ba:	85 d2                	test   %edx,%edx
 8bc:	74 08                	je     8c6 <printint+0x56>
    buf[i++] = '-';
 8be:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 8c3:	8d 7e 02             	lea    0x2(%esi),%edi
 8c6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 8ca:	8b 7d c0             	mov    -0x40(%ebp),%edi
 8cd:	8d 76 00             	lea    0x0(%esi),%esi
 8d0:	0f b6 06             	movzbl (%esi),%eax
 8d3:	4e                   	dec    %esi
  write(fd, &c, 1);
 8d4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 8d8:	89 3c 24             	mov    %edi,(%esp)
 8db:	88 45 d7             	mov    %al,-0x29(%ebp)
 8de:	b8 01 00 00 00       	mov    $0x1,%eax
 8e3:	89 44 24 08          	mov    %eax,0x8(%esp)
 8e7:	e8 dc fe ff ff       	call   7c8 <write>

  while(--i >= 0)
 8ec:	39 de                	cmp    %ebx,%esi
 8ee:	75 e0                	jne    8d0 <printint+0x60>
    putc(fd, buf[i]);
}
 8f0:	83 c4 4c             	add    $0x4c,%esp
 8f3:	5b                   	pop    %ebx
 8f4:	5e                   	pop    %esi
 8f5:	5f                   	pop    %edi
 8f6:	5d                   	pop    %ebp
 8f7:	c3                   	ret    
 8f8:	90                   	nop
 8f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 900:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 907:	eb 8d                	jmp    896 <printint+0x26>
 909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000910 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 910:	55                   	push   %ebp
 911:	89 e5                	mov    %esp,%ebp
 913:	57                   	push   %edi
 914:	56                   	push   %esi
 915:	53                   	push   %ebx
 916:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 919:	8b 75 0c             	mov    0xc(%ebp),%esi
 91c:	0f b6 1e             	movzbl (%esi),%ebx
 91f:	84 db                	test   %bl,%bl
 921:	0f 84 d1 00 00 00    	je     9f8 <printf+0xe8>
  state = 0;
 927:	31 ff                	xor    %edi,%edi
 929:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 92a:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 92d:	89 fa                	mov    %edi,%edx
 92f:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 932:	89 45 d0             	mov    %eax,-0x30(%ebp)
 935:	eb 41                	jmp    978 <printf+0x68>
 937:	89 f6                	mov    %esi,%esi
 939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 940:	83 f8 25             	cmp    $0x25,%eax
 943:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 946:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 94b:	74 1e                	je     96b <printf+0x5b>
  write(fd, &c, 1);
 94d:	b8 01 00 00 00       	mov    $0x1,%eax
 952:	89 44 24 08          	mov    %eax,0x8(%esp)
 956:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 959:	89 44 24 04          	mov    %eax,0x4(%esp)
 95d:	89 3c 24             	mov    %edi,(%esp)
 960:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 963:	e8 60 fe ff ff       	call   7c8 <write>
 968:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 96b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 96c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 970:	84 db                	test   %bl,%bl
 972:	0f 84 80 00 00 00    	je     9f8 <printf+0xe8>
    if(state == 0){
 978:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 97a:	0f be cb             	movsbl %bl,%ecx
 97d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 980:	74 be                	je     940 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 982:	83 fa 25             	cmp    $0x25,%edx
 985:	75 e4                	jne    96b <printf+0x5b>
      if(c == 'd'){
 987:	83 f8 64             	cmp    $0x64,%eax
 98a:	0f 84 f0 00 00 00    	je     a80 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 990:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 996:	83 f9 70             	cmp    $0x70,%ecx
 999:	74 65                	je     a00 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 99b:	83 f8 73             	cmp    $0x73,%eax
 99e:	0f 84 8c 00 00 00    	je     a30 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 9a4:	83 f8 63             	cmp    $0x63,%eax
 9a7:	0f 84 13 01 00 00    	je     ac0 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 9ad:	83 f8 25             	cmp    $0x25,%eax
 9b0:	0f 84 e2 00 00 00    	je     a98 <printf+0x188>
  write(fd, &c, 1);
 9b6:	b8 01 00 00 00       	mov    $0x1,%eax
 9bb:	46                   	inc    %esi
 9bc:	89 44 24 08          	mov    %eax,0x8(%esp)
 9c0:	8d 45 e7             	lea    -0x19(%ebp),%eax
 9c3:	89 44 24 04          	mov    %eax,0x4(%esp)
 9c7:	89 3c 24             	mov    %edi,(%esp)
 9ca:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 9ce:	e8 f5 fd ff ff       	call   7c8 <write>
 9d3:	ba 01 00 00 00       	mov    $0x1,%edx
 9d8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 9db:	89 54 24 08          	mov    %edx,0x8(%esp)
 9df:	89 44 24 04          	mov    %eax,0x4(%esp)
 9e3:	89 3c 24             	mov    %edi,(%esp)
 9e6:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 9e9:	e8 da fd ff ff       	call   7c8 <write>
  for(i = 0; fmt[i]; i++){
 9ee:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9f2:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 9f4:	84 db                	test   %bl,%bl
 9f6:	75 80                	jne    978 <printf+0x68>
    }
  }
}
 9f8:	83 c4 3c             	add    $0x3c,%esp
 9fb:	5b                   	pop    %ebx
 9fc:	5e                   	pop    %esi
 9fd:	5f                   	pop    %edi
 9fe:	5d                   	pop    %ebp
 9ff:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 a00:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 a07:	b9 10 00 00 00       	mov    $0x10,%ecx
 a0c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 a0f:	89 f8                	mov    %edi,%eax
 a11:	8b 13                	mov    (%ebx),%edx
 a13:	e8 58 fe ff ff       	call   870 <printint>
        ap++;
 a18:	89 d8                	mov    %ebx,%eax
      state = 0;
 a1a:	31 d2                	xor    %edx,%edx
        ap++;
 a1c:	83 c0 04             	add    $0x4,%eax
 a1f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 a22:	e9 44 ff ff ff       	jmp    96b <printf+0x5b>
 a27:	89 f6                	mov    %esi,%esi
 a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 a30:	8b 45 d0             	mov    -0x30(%ebp),%eax
 a33:	8b 10                	mov    (%eax),%edx
        ap++;
 a35:	83 c0 04             	add    $0x4,%eax
 a38:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 a3b:	85 d2                	test   %edx,%edx
 a3d:	0f 84 aa 00 00 00    	je     aed <printf+0x1dd>
        while(*s != 0){
 a43:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 a46:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 a48:	84 c0                	test   %al,%al
 a4a:	74 27                	je     a73 <printf+0x163>
 a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a50:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 a53:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 a58:	43                   	inc    %ebx
  write(fd, &c, 1);
 a59:	89 44 24 08          	mov    %eax,0x8(%esp)
 a5d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 a60:	89 44 24 04          	mov    %eax,0x4(%esp)
 a64:	89 3c 24             	mov    %edi,(%esp)
 a67:	e8 5c fd ff ff       	call   7c8 <write>
        while(*s != 0){
 a6c:	0f b6 03             	movzbl (%ebx),%eax
 a6f:	84 c0                	test   %al,%al
 a71:	75 dd                	jne    a50 <printf+0x140>
      state = 0;
 a73:	31 d2                	xor    %edx,%edx
 a75:	e9 f1 fe ff ff       	jmp    96b <printf+0x5b>
 a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 a80:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 a87:	b9 0a 00 00 00       	mov    $0xa,%ecx
 a8c:	e9 7b ff ff ff       	jmp    a0c <printf+0xfc>
 a91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 a98:	b9 01 00 00 00       	mov    $0x1,%ecx
 a9d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 aa0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 aa4:	89 44 24 04          	mov    %eax,0x4(%esp)
 aa8:	89 3c 24             	mov    %edi,(%esp)
 aab:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 aae:	e8 15 fd ff ff       	call   7c8 <write>
      state = 0;
 ab3:	31 d2                	xor    %edx,%edx
 ab5:	e9 b1 fe ff ff       	jmp    96b <printf+0x5b>
 aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 ac0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 ac3:	8b 03                	mov    (%ebx),%eax
        ap++;
 ac5:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 ac8:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 acb:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 ace:	b8 01 00 00 00       	mov    $0x1,%eax
 ad3:	89 44 24 08          	mov    %eax,0x8(%esp)
 ad7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 ada:	89 44 24 04          	mov    %eax,0x4(%esp)
 ade:	e8 e5 fc ff ff       	call   7c8 <write>
      state = 0;
 ae3:	31 d2                	xor    %edx,%edx
        ap++;
 ae5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 ae8:	e9 7e fe ff ff       	jmp    96b <printf+0x5b>
          s = "(null)";
 aed:	bb 6b 0e 00 00       	mov    $0xe6b,%ebx
        while(*s != 0){
 af2:	b0 28                	mov    $0x28,%al
 af4:	e9 57 ff ff ff       	jmp    a50 <printf+0x140>
 af9:	66 90                	xchg   %ax,%ax
 afb:	66 90                	xchg   %ax,%ax
 afd:	66 90                	xchg   %ax,%ax
 aff:	90                   	nop

00000b00 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b00:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b01:	a1 04 12 00 00       	mov    0x1204,%eax
{
 b06:	89 e5                	mov    %esp,%ebp
 b08:	57                   	push   %edi
 b09:	56                   	push   %esi
 b0a:	53                   	push   %ebx
 b0b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 b0e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 b11:	eb 0d                	jmp    b20 <free+0x20>
 b13:	90                   	nop
 b14:	90                   	nop
 b15:	90                   	nop
 b16:	90                   	nop
 b17:	90                   	nop
 b18:	90                   	nop
 b19:	90                   	nop
 b1a:	90                   	nop
 b1b:	90                   	nop
 b1c:	90                   	nop
 b1d:	90                   	nop
 b1e:	90                   	nop
 b1f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b20:	39 c8                	cmp    %ecx,%eax
 b22:	8b 10                	mov    (%eax),%edx
 b24:	73 32                	jae    b58 <free+0x58>
 b26:	39 d1                	cmp    %edx,%ecx
 b28:	72 04                	jb     b2e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b2a:	39 d0                	cmp    %edx,%eax
 b2c:	72 32                	jb     b60 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b2e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 b31:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 b34:	39 fa                	cmp    %edi,%edx
 b36:	74 30                	je     b68 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 b38:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b3b:	8b 50 04             	mov    0x4(%eax),%edx
 b3e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b41:	39 f1                	cmp    %esi,%ecx
 b43:	74 3c                	je     b81 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 b45:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 b47:	5b                   	pop    %ebx
  freep = p;
 b48:	a3 04 12 00 00       	mov    %eax,0x1204
}
 b4d:	5e                   	pop    %esi
 b4e:	5f                   	pop    %edi
 b4f:	5d                   	pop    %ebp
 b50:	c3                   	ret    
 b51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b58:	39 d0                	cmp    %edx,%eax
 b5a:	72 04                	jb     b60 <free+0x60>
 b5c:	39 d1                	cmp    %edx,%ecx
 b5e:	72 ce                	jb     b2e <free+0x2e>
{
 b60:	89 d0                	mov    %edx,%eax
 b62:	eb bc                	jmp    b20 <free+0x20>
 b64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 b68:	8b 7a 04             	mov    0x4(%edx),%edi
 b6b:	01 fe                	add    %edi,%esi
 b6d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 b70:	8b 10                	mov    (%eax),%edx
 b72:	8b 12                	mov    (%edx),%edx
 b74:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b77:	8b 50 04             	mov    0x4(%eax),%edx
 b7a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b7d:	39 f1                	cmp    %esi,%ecx
 b7f:	75 c4                	jne    b45 <free+0x45>
    p->s.size += bp->s.size;
 b81:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 b84:	a3 04 12 00 00       	mov    %eax,0x1204
    p->s.size += bp->s.size;
 b89:	01 ca                	add    %ecx,%edx
 b8b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 b8e:	8b 53 f8             	mov    -0x8(%ebx),%edx
 b91:	89 10                	mov    %edx,(%eax)
}
 b93:	5b                   	pop    %ebx
 b94:	5e                   	pop    %esi
 b95:	5f                   	pop    %edi
 b96:	5d                   	pop    %ebp
 b97:	c3                   	ret    
 b98:	90                   	nop
 b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000ba0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ba0:	55                   	push   %ebp
 ba1:	89 e5                	mov    %esp,%ebp
 ba3:	57                   	push   %edi
 ba4:	56                   	push   %esi
 ba5:	53                   	push   %ebx
 ba6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ba9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 bac:	8b 15 04 12 00 00    	mov    0x1204,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bb2:	8d 78 07             	lea    0x7(%eax),%edi
 bb5:	c1 ef 03             	shr    $0x3,%edi
 bb8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 bb9:	85 d2                	test   %edx,%edx
 bbb:	0f 84 8f 00 00 00    	je     c50 <malloc+0xb0>
 bc1:	8b 02                	mov    (%edx),%eax
 bc3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 bc6:	39 cf                	cmp    %ecx,%edi
 bc8:	76 66                	jbe    c30 <malloc+0x90>
 bca:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 bd0:	bb 00 10 00 00       	mov    $0x1000,%ebx
 bd5:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 bd8:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 bdf:	eb 10                	jmp    bf1 <malloc+0x51>
 be1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 be8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 bea:	8b 48 04             	mov    0x4(%eax),%ecx
 bed:	39 f9                	cmp    %edi,%ecx
 bef:	73 3f                	jae    c30 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 bf1:	39 05 04 12 00 00    	cmp    %eax,0x1204
 bf7:	89 c2                	mov    %eax,%edx
 bf9:	75 ed                	jne    be8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 bfb:	89 34 24             	mov    %esi,(%esp)
 bfe:	e8 2d fc ff ff       	call   830 <sbrk>
  if(p == (char*)-1)
 c03:	83 f8 ff             	cmp    $0xffffffff,%eax
 c06:	74 18                	je     c20 <malloc+0x80>
  hp->s.size = nu;
 c08:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 c0b:	83 c0 08             	add    $0x8,%eax
 c0e:	89 04 24             	mov    %eax,(%esp)
 c11:	e8 ea fe ff ff       	call   b00 <free>
  return freep;
 c16:	8b 15 04 12 00 00    	mov    0x1204,%edx
      if((p = morecore(nunits)) == 0)
 c1c:	85 d2                	test   %edx,%edx
 c1e:	75 c8                	jne    be8 <malloc+0x48>
        return 0;
  }
}
 c20:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 c23:	31 c0                	xor    %eax,%eax
}
 c25:	5b                   	pop    %ebx
 c26:	5e                   	pop    %esi
 c27:	5f                   	pop    %edi
 c28:	5d                   	pop    %ebp
 c29:	c3                   	ret    
 c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 c30:	39 cf                	cmp    %ecx,%edi
 c32:	74 4c                	je     c80 <malloc+0xe0>
        p->s.size -= nunits;
 c34:	29 f9                	sub    %edi,%ecx
 c36:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 c39:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 c3c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 c3f:	89 15 04 12 00 00    	mov    %edx,0x1204
}
 c45:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 c48:	83 c0 08             	add    $0x8,%eax
}
 c4b:	5b                   	pop    %ebx
 c4c:	5e                   	pop    %esi
 c4d:	5f                   	pop    %edi
 c4e:	5d                   	pop    %ebp
 c4f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 c50:	b8 08 12 00 00       	mov    $0x1208,%eax
 c55:	ba 08 12 00 00       	mov    $0x1208,%edx
    base.s.size = 0;
 c5a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 c5c:	a3 04 12 00 00       	mov    %eax,0x1204
    base.s.size = 0;
 c61:	b8 08 12 00 00       	mov    $0x1208,%eax
    base.s.ptr = freep = prevp = &base;
 c66:	89 15 08 12 00 00    	mov    %edx,0x1208
    base.s.size = 0;
 c6c:	89 0d 0c 12 00 00    	mov    %ecx,0x120c
 c72:	e9 53 ff ff ff       	jmp    bca <malloc+0x2a>
 c77:	89 f6                	mov    %esi,%esi
 c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 c80:	8b 08                	mov    (%eax),%ecx
 c82:	89 0a                	mov    %ecx,(%edx)
 c84:	eb b9                	jmp    c3f <malloc+0x9f>
