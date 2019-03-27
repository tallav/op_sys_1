
_sanity:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
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
  10:	b8 05 11 00 00       	mov    $0x1105,%eax
  15:	89 44 24 04          	mov    %eax,0x4(%esp)
  19:	89 1c 24             	mov    %ebx,(%esp)
  1c:	e8 ff 07 00 00       	call   820 <strcmp>
  21:	85 c0                	test   %eax,%eax
  23:	75 11                	jne    36 <main+0x36>
		testExitWait();
  25:	e8 76 01 00 00       	call   1a0 <testExitWait>
            testPolicy(3);
            testPerf(1);
            testPerf(2);
            testPerf(3);
        }
       exit(0);
  2a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  31:	e8 f2 09 00 00       	call   a28 <exit>
	else if(strcmp(arg, "detach") == 0)
  36:	c7 44 24 04 0a 11 00 	movl   $0x110a,0x4(%esp)
  3d:	00 
  3e:	89 1c 24             	mov    %ebx,(%esp)
  41:	e8 da 07 00 00       	call   820 <strcmp>
  46:	85 c0                	test   %eax,%eax
  48:	75 08                	jne    52 <main+0x52>
		testDetach();
  4a:	e8 f1 01 00 00       	call   240 <testDetach>
  4f:	90                   	nop
  50:	eb d8                	jmp    2a <main+0x2a>
	else if(strcmp(arg, "wait_stat") == 0)
  52:	c7 44 24 04 11 11 00 	movl   $0x1111,0x4(%esp)
  59:	00 
  5a:	89 1c 24             	mov    %ebx,(%esp)
  5d:	e8 be 07 00 00       	call   820 <strcmp>
  62:	85 c0                	test   %eax,%eax
  64:	74 22                	je     88 <main+0x88>
	else if(strcmp(arg, "policy1") == 0)
  66:	c7 44 24 04 1b 11 00 	movl   $0x111b,0x4(%esp)
  6d:	00 
  6e:	89 1c 24             	mov    %ebx,(%esp)
  71:	e8 aa 07 00 00       	call   820 <strcmp>
  76:	85 c0                	test   %eax,%eax
  78:	75 18                	jne    92 <main+0x92>
		testPolicy(1);
  7a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  81:	e8 fa 03 00 00       	call   480 <testPolicy>
  86:	eb a2                	jmp    2a <main+0x2a>
		testWaitStat();
  88:	e8 43 03 00 00       	call   3d0 <testWaitStat>
  8d:	8d 76 00             	lea    0x0(%esi),%esi
  90:	eb 98                	jmp    2a <main+0x2a>
	else if(strcmp(arg, "policy2") == 0)
  92:	c7 44 24 04 23 11 00 	movl   $0x1123,0x4(%esp)
  99:	00 
  9a:	89 1c 24             	mov    %ebx,(%esp)
  9d:	e8 7e 07 00 00       	call   820 <strcmp>
  a2:	85 c0                	test   %eax,%eax
  a4:	74 25                	je     cb <main+0xcb>
	else if(strcmp(arg, "policy3") == 0)
  a6:	c7 44 24 04 2b 11 00 	movl   $0x112b,0x4(%esp)
  ad:	00 
  ae:	89 1c 24             	mov    %ebx,(%esp)
  b1:	e8 6a 07 00 00       	call   820 <strcmp>
  b6:	85 c0                	test   %eax,%eax
  b8:	75 22                	jne    dc <main+0xdc>
		testPolicy(3);
  ba:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
  c1:	e8 ba 03 00 00       	call   480 <testPolicy>
  c6:	e9 5f ff ff ff       	jmp    2a <main+0x2a>
		testPolicy(2);
  cb:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  d2:	e8 a9 03 00 00       	call   480 <testPolicy>
  d7:	e9 4e ff ff ff       	jmp    2a <main+0x2a>
        else if(strcmp(arg, "perf1") == 0)
  dc:	c7 44 24 04 33 11 00 	movl   $0x1133,0x4(%esp)
  e3:	00 
  e4:	89 1c 24             	mov    %ebx,(%esp)
  e7:	e8 34 07 00 00       	call   820 <strcmp>
  ec:	85 c0                	test   %eax,%eax
  ee:	75 11                	jne    101 <main+0x101>
		testPerf(1);
  f0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  f7:	e8 14 05 00 00       	call   610 <testPerf>
  fc:	e9 29 ff ff ff       	jmp    2a <main+0x2a>
	else if(strcmp(arg, "perf2") == 0)
 101:	c7 44 24 04 39 11 00 	movl   $0x1139,0x4(%esp)
 108:	00 
 109:	89 1c 24             	mov    %ebx,(%esp)
 10c:	e8 0f 07 00 00       	call   820 <strcmp>
 111:	85 c0                	test   %eax,%eax
 113:	75 11                	jne    126 <main+0x126>
		testPerf(2);
 115:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 11c:	e8 ef 04 00 00       	call   610 <testPerf>
 121:	e9 04 ff ff ff       	jmp    2a <main+0x2a>
	else if(strcmp(arg, "perf3") == 0)
 126:	c7 44 24 04 3f 11 00 	movl   $0x113f,0x4(%esp)
 12d:	00 
 12e:	89 1c 24             	mov    %ebx,(%esp)
 131:	e8 ea 06 00 00       	call   820 <strcmp>
 136:	85 c0                	test   %eax,%eax
 138:	74 4c                	je     186 <main+0x186>
            testExitWait();
 13a:	e8 61 00 00 00       	call   1a0 <testExitWait>
 13f:	90                   	nop
            testDetach();
 140:	e8 fb 00 00 00       	call   240 <testDetach>
            testWaitStat();
 145:	e8 86 02 00 00       	call   3d0 <testWaitStat>
            testPolicy(1);
 14a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 151:	e8 2a 03 00 00       	call   480 <testPolicy>
            testPolicy(2);
 156:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 15d:	e8 1e 03 00 00       	call   480 <testPolicy>
            testPolicy(3);
 162:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
 169:	e8 12 03 00 00       	call   480 <testPolicy>
            testPerf(1);
 16e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 175:	e8 96 04 00 00       	call   610 <testPerf>
            testPerf(2);
 17a:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 181:	e8 8a 04 00 00       	call   610 <testPerf>
            testPerf(3);
 186:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
 18d:	e8 7e 04 00 00       	call   610 <testPerf>
 192:	e9 93 fe ff ff       	jmp    2a <main+0x2a>
 197:	66 90                	xchg   %ax,%ax
 199:	66 90                	xchg   %ax,%ax
 19b:	66 90                	xchg   %ax,%ax
 19d:	66 90                	xchg   %ax,%ax
 19f:	90                   	nop

000001a0 <testExitWait>:
void testExitWait(){
 1a0:	55                   	push   %ebp
    printf(1, "----------test exit wait started\n");
 1a1:	b9 08 0f 00 00       	mov    $0xf08,%ecx
void testExitWait(){
 1a6:	89 e5                	mov    %esp,%ebp
 1a8:	57                   	push   %edi
 1a9:	56                   	push   %esi
    for (int i = 0; i < 5; i++) {
 1aa:	31 f6                	xor    %esi,%esi
void testExitWait(){
 1ac:	53                   	push   %ebx
 1ad:	83 ec 2c             	sub    $0x2c,%esp
    printf(1, "----------test exit wait started\n");
 1b0:	89 4c 24 04          	mov    %ecx,0x4(%esp)
            wait(&status);
 1b4:	8d 7d e4             	lea    -0x1c(%ebp),%edi
    printf(1, "----------test exit wait started\n");
 1b7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1be:	e8 cd 09 00 00       	call   b90 <printf>
        pid = fork();
 1c3:	e8 58 08 00 00       	call   a20 <fork>
        if (pid > 0) {
 1c8:	85 c0                	test   %eax,%eax
        pid = fork();
 1ca:	89 c3                	mov    %eax,%ebx
        if (pid > 0) {
 1cc:	7e 53                	jle    221 <testExitWait+0x81>
            wait(&status);
 1ce:	89 3c 24             	mov    %edi,(%esp)
    for (int i = 0; i < 5; i++) {
 1d1:	46                   	inc    %esi
            wait(&status);
 1d2:	e8 59 08 00 00       	call   a30 <wait>
			kill(pid);
 1d7:	89 1c 24             	mov    %ebx,(%esp)
 1da:	e8 79 08 00 00       	call   a58 <kill>
            printf(1, "process with pid %d exited with status %d\n", pid, status);
 1df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 1e2:	ba 2c 0f 00 00       	mov    $0xf2c,%edx
 1e7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 1eb:	89 54 24 04          	mov    %edx,0x4(%esp)
 1ef:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1f6:	89 44 24 0c          	mov    %eax,0xc(%esp)
 1fa:	e8 91 09 00 00       	call   b90 <printf>
    for (int i = 0; i < 5; i++) {
 1ff:	83 fe 05             	cmp    $0x5,%esi
 202:	75 bf                	jne    1c3 <testExitWait+0x23>
    printf(1, "----------test exit wait ended\n");
 204:	b8 58 0f 00 00       	mov    $0xf58,%eax
 209:	89 44 24 04          	mov    %eax,0x4(%esp)
 20d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 214:	e8 77 09 00 00       	call   b90 <printf>
}
 219:	83 c4 2c             	add    $0x2c,%esp
 21c:	5b                   	pop    %ebx
 21d:	5e                   	pop    %esi
 21e:	5f                   	pop    %edi
 21f:	5d                   	pop    %ebp
 220:	c3                   	ret    
            sleep(5);
 221:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 228:	e8 8b 08 00 00       	call   ab8 <sleep>
            exit(i);
 22d:	89 34 24             	mov    %esi,(%esp)
 230:	e8 f3 07 00 00       	call   a28 <exit>
 235:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000240 <testDetach>:
void testDetach(){
 240:	55                   	push   %ebp
    printf(1, "----------test detach started\n");
 241:	b8 78 0f 00 00       	mov    $0xf78,%eax
void testDetach(){
 246:	89 e5                	mov    %esp,%ebp
 248:	53                   	push   %ebx
 249:	83 ec 14             	sub    $0x14,%esp
    printf(1, "----------test detach started\n");
 24c:	89 44 24 04          	mov    %eax,0x4(%esp)
 250:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 257:	e8 34 09 00 00       	call   b90 <printf>
    pid = fork(); 
 25c:	e8 bf 07 00 00       	call   a20 <fork>
    if(pid > 0) {
 261:	85 c0                	test   %eax,%eax
    pid = fork(); 
 263:	89 c3                	mov    %eax,%ebx
    if(pid > 0) {
 265:	7e 67                	jle    2ce <testDetach+0x8e>
        first_status = detach(pid); // status = 0
 267:	89 04 24             	mov    %eax,(%esp)
 26a:	e8 59 08 00 00       	call   ac8 <detach>
        printf(1, "first_status: %d\n", first_status);
 26f:	ba 28 10 00 00       	mov    $0x1028,%edx
 274:	89 54 24 04          	mov    %edx,0x4(%esp)
 278:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 27f:	89 44 24 08          	mov    %eax,0x8(%esp)
 283:	e8 08 09 00 00       	call   b90 <printf>
        second_status = detach(pid); // status = -1, because this process has already detached this child, and it doesn’t have this child anymore.
 288:	89 1c 24             	mov    %ebx,(%esp)
 28b:	e8 38 08 00 00       	call   ac8 <detach>
        printf(1, "second_status: %d\n", second_status);
 290:	b9 3a 10 00 00       	mov    $0x103a,%ecx
 295:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 299:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2a0:	89 44 24 08          	mov    %eax,0x8(%esp)
 2a4:	e8 e7 08 00 00       	call   b90 <printf>
        third_status = detach(77); // status = -1, because this process doesn’t have a child with this pid.
 2a9:	c7 04 24 4d 00 00 00 	movl   $0x4d,(%esp)
 2b0:	e8 13 08 00 00       	call   ac8 <detach>
        printf(1, "third_status: %d\n", third_status);
 2b5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2bc:	89 44 24 08          	mov    %eax,0x8(%esp)
 2c0:	b8 4d 10 00 00       	mov    $0x104d,%eax
 2c5:	89 44 24 04          	mov    %eax,0x4(%esp)
 2c9:	e8 c2 08 00 00       	call   b90 <printf>
	kill(pid);
 2ce:	89 1c 24             	mov    %ebx,(%esp)
 2d1:	e8 82 07 00 00       	call   a58 <kill>
    printf(1, "----------test detach ended\n");
 2d6:	b8 5f 10 00 00       	mov    $0x105f,%eax
 2db:	89 44 24 04          	mov    %eax,0x4(%esp)
 2df:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2e6:	e8 a5 08 00 00       	call   b90 <printf>
}
 2eb:	83 c4 14             	add    $0x14,%esp
 2ee:	5b                   	pop    %ebx
 2ef:	5d                   	pop    %ebp
 2f0:	c3                   	ret    
 2f1:	eb 0d                	jmp    300 <printPerf>
 2f3:	90                   	nop
 2f4:	90                   	nop
 2f5:	90                   	nop
 2f6:	90                   	nop
 2f7:	90                   	nop
 2f8:	90                   	nop
 2f9:	90                   	nop
 2fa:	90                   	nop
 2fb:	90                   	nop
 2fc:	90                   	nop
 2fd:	90                   	nop
 2fe:	90                   	nop
 2ff:	90                   	nop

00000300 <printPerf>:
void printPerf(struct perf *performance) {
 300:	55                   	push   %ebp
    printf(1, "pref:\n");
 301:	b8 7c 10 00 00       	mov    $0x107c,%eax
void printPerf(struct perf *performance) {
 306:	89 e5                	mov    %esp,%ebp
 308:	53                   	push   %ebx
 309:	83 ec 14             	sub    $0x14,%esp
 30c:	8b 5d 08             	mov    0x8(%ebp),%ebx
    printf(1, "pref:\n");
 30f:	89 44 24 04          	mov    %eax,0x4(%esp)
 313:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 31a:	e8 71 08 00 00       	call   b90 <printf>
    printf(1, "\tctime: %d\n", performance->ctime);
 31f:	ba 83 10 00 00       	mov    $0x1083,%edx
 324:	8b 03                	mov    (%ebx),%eax
 326:	89 54 24 04          	mov    %edx,0x4(%esp)
 32a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 331:	89 44 24 08          	mov    %eax,0x8(%esp)
 335:	e8 56 08 00 00       	call   b90 <printf>
    printf(1, "\tttime: %d\n", performance->ttime);
 33a:	8b 43 04             	mov    0x4(%ebx),%eax
 33d:	b9 8f 10 00 00       	mov    $0x108f,%ecx
 342:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 346:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 34d:	89 44 24 08          	mov    %eax,0x8(%esp)
 351:	e8 3a 08 00 00       	call   b90 <printf>
    printf(1, "\tstime: %d\n", performance->stime);
 356:	8b 43 08             	mov    0x8(%ebx),%eax
 359:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 360:	89 44 24 08          	mov    %eax,0x8(%esp)
 364:	b8 9b 10 00 00       	mov    $0x109b,%eax
 369:	89 44 24 04          	mov    %eax,0x4(%esp)
 36d:	e8 1e 08 00 00       	call   b90 <printf>
    printf(1, "\tretime: %d\n", performance->retime);
 372:	8b 43 0c             	mov    0xc(%ebx),%eax
 375:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 37c:	89 44 24 08          	mov    %eax,0x8(%esp)
 380:	b8 a7 10 00 00       	mov    $0x10a7,%eax
 385:	89 44 24 04          	mov    %eax,0x4(%esp)
 389:	e8 02 08 00 00       	call   b90 <printf>
    printf(1, "\trutime: %d\n", performance->rutime);
 38e:	8b 43 10             	mov    0x10(%ebx),%eax
 391:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 398:	89 44 24 08          	mov    %eax,0x8(%esp)
 39c:	b8 b4 10 00 00       	mov    $0x10b4,%eax
 3a1:	89 44 24 04          	mov    %eax,0x4(%esp)
 3a5:	e8 e6 07 00 00       	call   b90 <printf>
    printf(1, "\n\tTurnaround time: %d\n", (performance->ttime - performance->ctime));
 3aa:	8b 43 04             	mov    0x4(%ebx),%eax
 3ad:	b9 c1 10 00 00       	mov    $0x10c1,%ecx
 3b2:	8b 13                	mov    (%ebx),%edx
 3b4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 3b8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 3bf:	29 d0                	sub    %edx,%eax
 3c1:	89 44 24 08          	mov    %eax,0x8(%esp)
 3c5:	e8 c6 07 00 00       	call   b90 <printf>
}
 3ca:	83 c4 14             	add    $0x14,%esp
 3cd:	5b                   	pop    %ebx
 3ce:	5d                   	pop    %ebp
 3cf:	c3                   	ret    

000003d0 <testWaitStat>:
void testWaitStat(){
 3d0:	55                   	push   %ebp
    printf(1, "----------test wait_stat started\n");
 3d1:	b9 98 0f 00 00       	mov    $0xf98,%ecx
void testWaitStat(){
 3d6:	89 e5                	mov    %esp,%ebp
 3d8:	57                   	push   %edi
 3d9:	56                   	push   %esi
 3da:	53                   	push   %ebx
    for (int i = 0; i < 5; i++) {
 3db:	31 db                	xor    %ebx,%ebx
void testWaitStat(){
 3dd:	83 ec 3c             	sub    $0x3c,%esp
    printf(1, "----------test wait_stat started\n");
 3e0:	89 4c 24 04          	mov    %ecx,0x4(%esp)
            wait_stat(&status, &perf);
 3e4:	8d 75 d4             	lea    -0x2c(%ebp),%esi
    printf(1, "----------test wait_stat started\n");
 3e7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 3ee:	e8 9d 07 00 00       	call   b90 <printf>
        pid = fork();
 3f3:	e8 28 06 00 00       	call   a20 <fork>
        if (pid > 0) {
 3f8:	85 c0                	test   %eax,%eax
        pid = fork();
 3fa:	89 c7                	mov    %eax,%edi
        if (pid > 0) {
 3fc:	7e 62                	jle    460 <testWaitStat+0x90>
            wait_stat(&status, &perf);
 3fe:	8d 45 d0             	lea    -0x30(%ebp),%eax
    for (int i = 0; i < 5; i++) {
 401:	43                   	inc    %ebx
            wait_stat(&status, &perf);
 402:	89 74 24 04          	mov    %esi,0x4(%esp)
 406:	89 04 24             	mov    %eax,(%esp)
 409:	e8 d2 06 00 00       	call   ae0 <wait_stat>
            printf(1, "process with pid %d exited with status %d\n", pid, status);
 40e:	8b 45 d0             	mov    -0x30(%ebp),%eax
 411:	ba 2c 0f 00 00       	mov    $0xf2c,%edx
 416:	89 54 24 04          	mov    %edx,0x4(%esp)
 41a:	89 7c 24 08          	mov    %edi,0x8(%esp)
 41e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 425:	89 44 24 0c          	mov    %eax,0xc(%esp)
 429:	e8 62 07 00 00       	call   b90 <printf>
			kill(pid);
 42e:	89 3c 24             	mov    %edi,(%esp)
 431:	e8 22 06 00 00       	call   a58 <kill>
            printPerf(&perf);
 436:	89 34 24             	mov    %esi,(%esp)
 439:	e8 c2 fe ff ff       	call   300 <printPerf>
    for (int i = 0; i < 5; i++) {
 43e:	83 fb 05             	cmp    $0x5,%ebx
 441:	75 b0                	jne    3f3 <testWaitStat+0x23>
    printf(1, "----------test wait_stat ended\n");
 443:	b8 bc 0f 00 00       	mov    $0xfbc,%eax
 448:	89 44 24 04          	mov    %eax,0x4(%esp)
 44c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 453:	e8 38 07 00 00       	call   b90 <printf>
}
 458:	83 c4 3c             	add    $0x3c,%esp
 45b:	5b                   	pop    %ebx
 45c:	5e                   	pop    %esi
 45d:	5f                   	pop    %edi
 45e:	5d                   	pop    %ebp
 45f:	c3                   	ret    
            sleep(5);
 460:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 467:	e8 4c 06 00 00       	call   ab8 <sleep>
            exit(i);
 46c:	89 1c 24             	mov    %ebx,(%esp)
 46f:	e8 b4 05 00 00       	call   a28 <exit>
 474:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 47a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000480 <testPolicy>:
void testPolicy(int policyNum) {
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	53                   	push   %ebx
 486:	83 ec 3c             	sub    $0x3c,%esp
    printf(1, "----------test policy %d started\n", policyNum);
 489:	8b 45 08             	mov    0x8(%ebp),%eax
 48c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 493:	89 44 24 08          	mov    %eax,0x8(%esp)
 497:	b8 dc 0f 00 00       	mov    $0xfdc,%eax
 49c:	89 44 24 04          	mov    %eax,0x4(%esp)
 4a0:	e8 eb 06 00 00       	call   b90 <printf>
    policy(policyNum);
 4a5:	8b 45 08             	mov    0x8(%ebp),%eax
 4a8:	89 04 24             	mov    %eax,(%esp)
 4ab:	e8 28 06 00 00       	call   ad8 <policy>
    pid1 = fork();
 4b0:	e8 6b 05 00 00       	call   a20 <fork>
    if (pid1 > 0) {
 4b5:	85 c0                	test   %eax,%eax
 4b7:	7f 4a                	jg     503 <testPolicy+0x83>
 4b9:	31 db                	xor    %ebx,%ebx
                wait_stat(&status, &perf1);
 4bb:	8d 7d d4             	lea    -0x2c(%ebp),%edi
 4be:	8d 75 d0             	lea    -0x30(%ebp),%esi
 4c1:	eb 0d                	jmp    4d0 <testPolicy+0x50>
 4c3:	90                   	nop
 4c4:	90                   	nop
 4c5:	90                   	nop
 4c6:	90                   	nop
 4c7:	90                   	nop
 4c8:	90                   	nop
 4c9:	90                   	nop
 4ca:	90                   	nop
 4cb:	90                   	nop
 4cc:	90                   	nop
 4cd:	90                   	nop
 4ce:	90                   	nop
 4cf:	90                   	nop
            pid = fork();
 4d0:	e8 4b 05 00 00       	call   a20 <fork>
            if (pid > 0) {
 4d5:	85 c0                	test   %eax,%eax
 4d7:	7e 4c                	jle    525 <testPolicy+0xa5>
                sleep(5);
 4d9:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
        for (int a = 0; a < 100; ++a) {
 4e0:	43                   	inc    %ebx
                sleep(5);
 4e1:	e8 d2 05 00 00       	call   ab8 <sleep>
                wait_stat(&status, &perf1);
 4e6:	89 7c 24 04          	mov    %edi,0x4(%esp)
 4ea:	89 34 24             	mov    %esi,(%esp)
 4ed:	e8 ee 05 00 00       	call   ae0 <wait_stat>
        for (int a = 0; a < 100; ++a) {
 4f2:	83 fb 64             	cmp    $0x64,%ebx
 4f5:	75 d9                	jne    4d0 <testPolicy+0x50>
        exit(0);
 4f7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4fe:	e8 25 05 00 00       	call   a28 <exit>
        wait_stat(&status1, &perf2);
 503:	8d 5d d4             	lea    -0x2c(%ebp),%ebx
 506:	8d 45 d0             	lea    -0x30(%ebp),%eax
 509:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 50d:	89 04 24             	mov    %eax,(%esp)
 510:	e8 cb 05 00 00       	call   ae0 <wait_stat>
        printPerf(&perf2);
 515:	89 1c 24             	mov    %ebx,(%esp)
 518:	e8 e3 fd ff ff       	call   300 <printPerf>
}
 51d:	83 c4 3c             	add    $0x3c,%esp
 520:	5b                   	pop    %ebx
 521:	5e                   	pop    %esi
 522:	5f                   	pop    %edi
 523:	5d                   	pop    %ebp
 524:	c3                   	ret    
                int pr = a % 10;
 525:	89 d8                	mov    %ebx,%eax
 527:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
 52c:	f7 e2                	mul    %edx
 52e:	89 d0                	mov    %edx,%eax
 530:	c1 e8 03             	shr    $0x3,%eax
 533:	8d 04 80             	lea    (%eax,%eax,4),%eax
 536:	01 c0                	add    %eax,%eax
                if(pr == 0 && policyNum == 2)
 538:	29 c3                	sub    %eax,%ebx
 53a:	89 d8                	mov    %ebx,%eax
 53c:	75 0c                	jne    54a <testPolicy+0xca>
                    pr = 1;
 53e:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
 542:	ba 01 00 00 00       	mov    $0x1,%edx
 547:	0f 44 c2             	cmove  %edx,%eax
                priority(pr);
 54a:	89 04 24             	mov    %eax,(%esp)
 54d:	e8 7e 05 00 00       	call   ad0 <priority>
                sleep(5);
 552:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 559:	e8 5a 05 00 00       	call   ab8 <sleep>
                exit(0);
 55e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 565:	e8 be 04 00 00       	call   a28 <exit>
 56a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000570 <procCalculate>:
int procCalculate(int x) {
 570:	55                   	push   %ebp
 571:	89 e5                	mov    %esp,%ebp
 573:	8b 4d 08             	mov    0x8(%ebp),%ecx
    for (int i = 0; i < x; ++i) {
 576:	85 c9                	test   %ecx,%ecx
 578:	7e 16                	jle    590 <procCalculate+0x20>
 57a:	31 d2                	xor    %edx,%edx
    int sum = 0;
 57c:	31 c0                	xor    %eax,%eax
 57e:	66 90                	xchg   %ax,%ax
    for (int i = 0; i < x; ++i) {
 580:	42                   	inc    %edx
 581:	01 c8                	add    %ecx,%eax
 583:	39 d1                	cmp    %edx,%ecx
 585:	75 f9                	jne    580 <procCalculate+0x10>
}
 587:	5d                   	pop    %ebp
 588:	c3                   	ret    
 589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    int sum = 0;
 590:	31 c0                	xor    %eax,%eax
}
 592:	5d                   	pop    %ebp
 593:	c3                   	ret    
 594:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 59a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000005a0 <createProcs>:
int createProcs(int nProcs, int pr){
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	57                   	push   %edi
 5a4:	56                   	push   %esi
 5a5:	53                   	push   %ebx
 5a6:	83 ec 2c             	sub    $0x2c,%esp
 5a9:	8b 75 08             	mov    0x8(%ebp),%esi
    for (int i = 0; i < nProcs; i++){
 5ac:	85 f6                	test   %esi,%esi
 5ae:	7e 32                	jle    5e2 <createProcs+0x42>
 5b0:	31 db                	xor    %ebx,%ebx
            wait(&status_5);
 5b2:	8d 7d e4             	lea    -0x1c(%ebp),%edi
 5b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        int pid_5 = fork();
 5c0:	e8 5b 04 00 00       	call   a20 <fork>
        if (pid_5 > 0) {
 5c5:	85 c0                	test   %eax,%eax
 5c7:	7e 23                	jle    5ec <createProcs+0x4c>
            sleep(10);
 5c9:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
    for (int i = 0; i < nProcs; i++){
 5d0:	43                   	inc    %ebx
            sleep(10);
 5d1:	e8 e2 04 00 00       	call   ab8 <sleep>
            wait(&status_5);
 5d6:	89 3c 24             	mov    %edi,(%esp)
 5d9:	e8 52 04 00 00       	call   a30 <wait>
    for (int i = 0; i < nProcs; i++){
 5de:	39 de                	cmp    %ebx,%esi
 5e0:	75 de                	jne    5c0 <createProcs+0x20>
}
 5e2:	83 c4 2c             	add    $0x2c,%esp
 5e5:	31 c0                	xor    %eax,%eax
 5e7:	5b                   	pop    %ebx
 5e8:	5e                   	pop    %esi
 5e9:	5f                   	pop    %edi
 5ea:	5d                   	pop    %ebp
 5eb:	c3                   	ret    
            priority(pr);
 5ec:	8b 45 0c             	mov    0xc(%ebp),%eax
 5ef:	89 04 24             	mov    %eax,(%esp)
 5f2:	e8 d9 04 00 00       	call   ad0 <priority>
            exit(sum);
 5f7:	c7 04 24 00 00 64 a7 	movl   $0xa7640000,(%esp)
 5fe:	e8 25 04 00 00       	call   a28 <exit>
 603:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000610 <testPerf>:
void testPerf(int policyNum){
 610:	55                   	push   %ebp
    printf(1, "----------test preformance %d started\n", policyNum);
 611:	b8 00 10 00 00       	mov    $0x1000,%eax
void testPerf(int policyNum){
 616:	89 e5                	mov    %esp,%ebp
 618:	57                   	push   %edi
 619:	56                   	push   %esi
 61a:	53                   	push   %ebx
 61b:	83 ec 3c             	sub    $0x3c,%esp
 61e:	8b 7d 08             	mov    0x8(%ebp),%edi
    printf(1, "----------test preformance %d started\n", policyNum);
 621:	89 44 24 04          	mov    %eax,0x4(%esp)
 625:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 62c:	89 7c 24 08          	mov    %edi,0x8(%esp)
 630:	e8 5b 05 00 00       	call   b90 <printf>
    policy(policyNum);
 635:	89 3c 24             	mov    %edi,(%esp)
 638:	e8 9b 04 00 00       	call   ad8 <policy>
    int pid1 = fork();
 63d:	e8 de 03 00 00       	call   a20 <fork>
    if (pid1 > 0) {
 642:	85 c0                	test   %eax,%eax
 644:	7e 1a                	jle    660 <testPerf+0x50>
        wait(&status1);
 646:	8d 45 d4             	lea    -0x2c(%ebp),%eax
 649:	89 04 24             	mov    %eax,(%esp)
 64c:	e8 df 03 00 00       	call   a30 <wait>
}
 651:	83 c4 3c             	add    $0x3c,%esp
 654:	5b                   	pop    %ebx
 655:	5e                   	pop    %esi
 656:	5f                   	pop    %edi
 657:	5d                   	pop    %ebp
 658:	c3                   	ret    
 659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        int pid5 = fork();
 660:	e8 bb 03 00 00       	call   a20 <fork>
        if (pid5 > 0) {
 665:	85 c0                	test   %eax,%eax
 667:	0f 8f f4 00 00 00    	jg     761 <testPerf+0x151>
 66d:	be 0a 00 00 00       	mov    $0xa,%esi
                    wait(&status_5);
 672:	8d 5d d4             	lea    -0x2c(%ebp),%ebx
 675:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
                int pid_5 = fork();
 680:	e8 9b 03 00 00       	call   a20 <fork>
                if (pid_5 > 0) {
 685:	85 c0                	test   %eax,%eax
 687:	0f 8e 9f 00 00 00    	jle    72c <testPerf+0x11c>
                    sleep(10);
 68d:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
 694:	e8 1f 04 00 00       	call   ab8 <sleep>
                    wait(&status_5);
 699:	89 1c 24             	mov    %ebx,(%esp)
 69c:	e8 8f 03 00 00       	call   a30 <wait>
            for (int i = 0; i < nProcs; i++){
 6a1:	4e                   	dec    %esi
 6a2:	75 dc                	jne    680 <testPerf+0x70>
        int pid2 = fork();
 6a4:	e8 77 03 00 00       	call   a20 <fork>
        if (pid2 > 0) {
 6a9:	85 c0                	test   %eax,%eax
 6ab:	90                   	nop
 6ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6b0:	0f 8f dc 00 00 00    	jg     792 <testPerf+0x182>
 6b6:	be 0a 00 00 00       	mov    $0xa,%esi
 6bb:	90                   	nop
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                int pid_5 = fork();
 6c0:	e8 5b 03 00 00       	call   a20 <fork>
                    sleep(10);
 6c5:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
                if (pid_5 > 0) {
 6cc:	85 c0                	test   %eax,%eax
 6ce:	7e 68                	jle    738 <testPerf+0x128>
                    sleep(10);
 6d0:	e8 e3 03 00 00       	call   ab8 <sleep>
                    wait(&status_5);
 6d5:	89 1c 24             	mov    %ebx,(%esp)
 6d8:	e8 53 03 00 00       	call   a30 <wait>
            for (int i = 0; i < nProcs; i++){
 6dd:	4e                   	dec    %esi
 6de:	75 e0                	jne    6c0 <testPerf+0xb0>
        int pid3 = fork();
 6e0:	e8 3b 03 00 00       	call   a20 <fork>
        if (pid3 > 0) {
 6e5:	85 c0                	test   %eax,%eax
 6e7:	0f 8f e1 00 00 00    	jg     7ce <testPerf+0x1be>
 6ed:	be 0a 00 00 00       	mov    $0xa,%esi
 6f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            int pid_5 = fork();
 700:	e8 1b 03 00 00       	call   a20 <fork>
            if (pid_5 > 0) {
 705:	85 c0                	test   %eax,%eax
 707:	7e 40                	jle    749 <testPerf+0x139>
                sleep(10);
 709:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
 710:	e8 a3 03 00 00       	call   ab8 <sleep>
                wait(&status_5);
 715:	89 1c 24             	mov    %ebx,(%esp)
 718:	e8 13 03 00 00       	call   a30 <wait>
         for (int i = 0; i < nProcs; i++){
 71d:	4e                   	dec    %esi
 71e:	75 e0                	jne    700 <testPerf+0xf0>
            exit(0);
 720:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 727:	e8 fc 02 00 00       	call   a28 <exit>
                    if (policyNum == 3)
 72c:	83 ff 03             	cmp    $0x3,%edi
 72f:	74 53                	je     784 <testPerf+0x174>
                        priority(1);
 731:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 738:	e8 93 03 00 00       	call   ad0 <priority>
                    exit(sum);
 73d:	c7 04 24 00 00 64 a7 	movl   $0xa7640000,(%esp)
 744:	e8 df 02 00 00       	call   a28 <exit>
                priority(5);
 749:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 750:	e8 7b 03 00 00       	call   ad0 <priority>
                exit(sum);
 755:	c7 04 24 00 00 64 a7 	movl   $0xa7640000,(%esp)
 75c:	e8 c7 02 00 00       	call   a28 <exit>
            sleep(10);
 761:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
 768:	e8 4b 03 00 00       	call   ab8 <sleep>
            wait(&status5);
 76d:	8d 45 d4             	lea    -0x2c(%ebp),%eax
 770:	89 04 24             	mov    %eax,(%esp)
 773:	e8 b8 02 00 00       	call   a30 <wait>
            exit(0);
 778:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 77f:	e8 a4 02 00 00       	call   a28 <exit>
                        priority(0);
 784:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 78b:	e8 40 03 00 00       	call   ad0 <priority>
 790:	eb ab                	jmp    73d <testPerf+0x12d>
            sleep(10);
 792:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
 799:	e8 1a 03 00 00       	call   ab8 <sleep>
            wait_stat(&status2, &perf2);
 79e:	8d 45 d0             	lea    -0x30(%ebp),%eax
 7a1:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 7a5:	89 04 24             	mov    %eax,(%esp)
 7a8:	e8 33 03 00 00       	call   ae0 <wait_stat>
            printf(1, "high priority process\n");
 7ad:	c7 44 24 04 d8 10 00 	movl   $0x10d8,0x4(%esp)
 7b4:	00 
            printf(1, "low priority process\n");
 7b5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 7bc:	e8 cf 03 00 00       	call   b90 <printf>
            printPerf(&perf3);
 7c1:	89 1c 24             	mov    %ebx,(%esp)
 7c4:	e8 37 fb ff ff       	call   300 <printPerf>
 7c9:	e9 52 ff ff ff       	jmp    720 <testPerf+0x110>
            sleep(10);
 7ce:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
 7d5:	e8 de 02 00 00       	call   ab8 <sleep>
            wait_stat(&status3, &perf3);
 7da:	8d 45 d0             	lea    -0x30(%ebp),%eax
 7dd:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 7e1:	89 04 24             	mov    %eax,(%esp)
 7e4:	e8 f7 02 00 00       	call   ae0 <wait_stat>
            printf(1, "low priority process\n");
 7e9:	c7 44 24 04 ef 10 00 	movl   $0x10ef,0x4(%esp)
 7f0:	00 
 7f1:	eb c2                	jmp    7b5 <testPerf+0x1a5>
 7f3:	66 90                	xchg   %ax,%ax
 7f5:	66 90                	xchg   %ax,%ax
 7f7:	66 90                	xchg   %ax,%ax
 7f9:	66 90                	xchg   %ax,%ax
 7fb:	66 90                	xchg   %ax,%ax
 7fd:	66 90                	xchg   %ax,%ax
 7ff:	90                   	nop

00000800 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 800:	55                   	push   %ebp
 801:	89 e5                	mov    %esp,%ebp
 803:	8b 45 08             	mov    0x8(%ebp),%eax
 806:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 809:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 80a:	89 c2                	mov    %eax,%edx
 80c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 810:	41                   	inc    %ecx
 811:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 815:	42                   	inc    %edx
 816:	84 db                	test   %bl,%bl
 818:	88 5a ff             	mov    %bl,-0x1(%edx)
 81b:	75 f3                	jne    810 <strcpy+0x10>
    ;
  return os;
}
 81d:	5b                   	pop    %ebx
 81e:	5d                   	pop    %ebp
 81f:	c3                   	ret    

00000820 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 820:	55                   	push   %ebp
 821:	89 e5                	mov    %esp,%ebp
 823:	8b 4d 08             	mov    0x8(%ebp),%ecx
 826:	53                   	push   %ebx
 827:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 82a:	0f b6 01             	movzbl (%ecx),%eax
 82d:	0f b6 13             	movzbl (%ebx),%edx
 830:	84 c0                	test   %al,%al
 832:	75 18                	jne    84c <strcmp+0x2c>
 834:	eb 22                	jmp    858 <strcmp+0x38>
 836:	8d 76 00             	lea    0x0(%esi),%esi
 839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 840:	41                   	inc    %ecx
  while(*p && *p == *q)
 841:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 844:	43                   	inc    %ebx
 845:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
 848:	84 c0                	test   %al,%al
 84a:	74 0c                	je     858 <strcmp+0x38>
 84c:	38 d0                	cmp    %dl,%al
 84e:	74 f0                	je     840 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
 850:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 851:	29 d0                	sub    %edx,%eax
}
 853:	5d                   	pop    %ebp
 854:	c3                   	ret    
 855:	8d 76 00             	lea    0x0(%esi),%esi
 858:	5b                   	pop    %ebx
 859:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 85b:	29 d0                	sub    %edx,%eax
}
 85d:	5d                   	pop    %ebp
 85e:	c3                   	ret    
 85f:	90                   	nop

00000860 <strlen>:

uint
strlen(const char *s)
{
 860:	55                   	push   %ebp
 861:	89 e5                	mov    %esp,%ebp
 863:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 866:	80 39 00             	cmpb   $0x0,(%ecx)
 869:	74 15                	je     880 <strlen+0x20>
 86b:	31 d2                	xor    %edx,%edx
 86d:	8d 76 00             	lea    0x0(%esi),%esi
 870:	42                   	inc    %edx
 871:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 875:	89 d0                	mov    %edx,%eax
 877:	75 f7                	jne    870 <strlen+0x10>
    ;
  return n;
}
 879:	5d                   	pop    %ebp
 87a:	c3                   	ret    
 87b:	90                   	nop
 87c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
 880:	31 c0                	xor    %eax,%eax
}
 882:	5d                   	pop    %ebp
 883:	c3                   	ret    
 884:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 88a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000890 <memset>:

void*
memset(void *dst, int c, uint n)
{
 890:	55                   	push   %ebp
 891:	89 e5                	mov    %esp,%ebp
 893:	8b 55 08             	mov    0x8(%ebp),%edx
 896:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 897:	8b 4d 10             	mov    0x10(%ebp),%ecx
 89a:	8b 45 0c             	mov    0xc(%ebp),%eax
 89d:	89 d7                	mov    %edx,%edi
 89f:	fc                   	cld    
 8a0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 8a2:	5f                   	pop    %edi
 8a3:	89 d0                	mov    %edx,%eax
 8a5:	5d                   	pop    %ebp
 8a6:	c3                   	ret    
 8a7:	89 f6                	mov    %esi,%esi
 8a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008b0 <strchr>:

char*
strchr(const char *s, char c)
{
 8b0:	55                   	push   %ebp
 8b1:	89 e5                	mov    %esp,%ebp
 8b3:	8b 45 08             	mov    0x8(%ebp),%eax
 8b6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 8ba:	0f b6 10             	movzbl (%eax),%edx
 8bd:	84 d2                	test   %dl,%dl
 8bf:	74 1b                	je     8dc <strchr+0x2c>
    if(*s == c)
 8c1:	38 d1                	cmp    %dl,%cl
 8c3:	75 0f                	jne    8d4 <strchr+0x24>
 8c5:	eb 17                	jmp    8de <strchr+0x2e>
 8c7:	89 f6                	mov    %esi,%esi
 8c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 8d0:	38 ca                	cmp    %cl,%dl
 8d2:	74 0a                	je     8de <strchr+0x2e>
  for(; *s; s++)
 8d4:	40                   	inc    %eax
 8d5:	0f b6 10             	movzbl (%eax),%edx
 8d8:	84 d2                	test   %dl,%dl
 8da:	75 f4                	jne    8d0 <strchr+0x20>
      return (char*)s;
  return 0;
 8dc:	31 c0                	xor    %eax,%eax
}
 8de:	5d                   	pop    %ebp
 8df:	c3                   	ret    

000008e0 <gets>:

char*
gets(char *buf, int max)
{
 8e0:	55                   	push   %ebp
 8e1:	89 e5                	mov    %esp,%ebp
 8e3:	57                   	push   %edi
 8e4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 8e5:	31 f6                	xor    %esi,%esi
{
 8e7:	53                   	push   %ebx
 8e8:	83 ec 3c             	sub    $0x3c,%esp
 8eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
 8ee:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 8f1:	eb 32                	jmp    925 <gets+0x45>
 8f3:	90                   	nop
 8f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 8f8:	ba 01 00 00 00       	mov    $0x1,%edx
 8fd:	89 54 24 08          	mov    %edx,0x8(%esp)
 901:	89 7c 24 04          	mov    %edi,0x4(%esp)
 905:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 90c:	e8 2f 01 00 00       	call   a40 <read>
    if(cc < 1)
 911:	85 c0                	test   %eax,%eax
 913:	7e 19                	jle    92e <gets+0x4e>
      break;
    buf[i++] = c;
 915:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 919:	43                   	inc    %ebx
 91a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
 91d:	3c 0a                	cmp    $0xa,%al
 91f:	74 1f                	je     940 <gets+0x60>
 921:	3c 0d                	cmp    $0xd,%al
 923:	74 1b                	je     940 <gets+0x60>
  for(i=0; i+1 < max; ){
 925:	46                   	inc    %esi
 926:	3b 75 0c             	cmp    0xc(%ebp),%esi
 929:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 92c:	7c ca                	jl     8f8 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 92e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 931:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 934:	8b 45 08             	mov    0x8(%ebp),%eax
 937:	83 c4 3c             	add    $0x3c,%esp
 93a:	5b                   	pop    %ebx
 93b:	5e                   	pop    %esi
 93c:	5f                   	pop    %edi
 93d:	5d                   	pop    %ebp
 93e:	c3                   	ret    
 93f:	90                   	nop
 940:	8b 45 08             	mov    0x8(%ebp),%eax
 943:	01 c6                	add    %eax,%esi
 945:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 948:	eb e4                	jmp    92e <gets+0x4e>
 94a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000950 <stat>:

int
stat(const char *n, struct stat *st)
{
 950:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 951:	31 c0                	xor    %eax,%eax
{
 953:	89 e5                	mov    %esp,%ebp
 955:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 958:	89 44 24 04          	mov    %eax,0x4(%esp)
 95c:	8b 45 08             	mov    0x8(%ebp),%eax
{
 95f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 962:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 965:	89 04 24             	mov    %eax,(%esp)
 968:	e8 fb 00 00 00       	call   a68 <open>
  if(fd < 0)
 96d:	85 c0                	test   %eax,%eax
 96f:	78 2f                	js     9a0 <stat+0x50>
 971:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 973:	8b 45 0c             	mov    0xc(%ebp),%eax
 976:	89 1c 24             	mov    %ebx,(%esp)
 979:	89 44 24 04          	mov    %eax,0x4(%esp)
 97d:	e8 fe 00 00 00       	call   a80 <fstat>
  close(fd);
 982:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 985:	89 c6                	mov    %eax,%esi
  close(fd);
 987:	e8 c4 00 00 00       	call   a50 <close>
  return r;
}
 98c:	89 f0                	mov    %esi,%eax
 98e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 991:	8b 75 fc             	mov    -0x4(%ebp),%esi
 994:	89 ec                	mov    %ebp,%esp
 996:	5d                   	pop    %ebp
 997:	c3                   	ret    
 998:	90                   	nop
 999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 9a0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 9a5:	eb e5                	jmp    98c <stat+0x3c>
 9a7:	89 f6                	mov    %esi,%esi
 9a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009b0 <atoi>:

int
atoi(const char *s)
{
 9b0:	55                   	push   %ebp
 9b1:	89 e5                	mov    %esp,%ebp
 9b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 9b6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 9b7:	0f be 11             	movsbl (%ecx),%edx
 9ba:	88 d0                	mov    %dl,%al
 9bc:	2c 30                	sub    $0x30,%al
 9be:	3c 09                	cmp    $0x9,%al
  n = 0;
 9c0:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 9c5:	77 1e                	ja     9e5 <atoi+0x35>
 9c7:	89 f6                	mov    %esi,%esi
 9c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 9d0:	41                   	inc    %ecx
 9d1:	8d 04 80             	lea    (%eax,%eax,4),%eax
 9d4:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 9d8:	0f be 11             	movsbl (%ecx),%edx
 9db:	88 d3                	mov    %dl,%bl
 9dd:	80 eb 30             	sub    $0x30,%bl
 9e0:	80 fb 09             	cmp    $0x9,%bl
 9e3:	76 eb                	jbe    9d0 <atoi+0x20>
  return n;
}
 9e5:	5b                   	pop    %ebx
 9e6:	5d                   	pop    %ebp
 9e7:	c3                   	ret    
 9e8:	90                   	nop
 9e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000009f0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 9f0:	55                   	push   %ebp
 9f1:	89 e5                	mov    %esp,%ebp
 9f3:	56                   	push   %esi
 9f4:	8b 45 08             	mov    0x8(%ebp),%eax
 9f7:	53                   	push   %ebx
 9f8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 9fb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 9fe:	85 db                	test   %ebx,%ebx
 a00:	7e 1a                	jle    a1c <memmove+0x2c>
 a02:	31 d2                	xor    %edx,%edx
 a04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 a0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 a10:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 a14:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 a17:	42                   	inc    %edx
  while(n-- > 0)
 a18:	39 d3                	cmp    %edx,%ebx
 a1a:	75 f4                	jne    a10 <memmove+0x20>
  return vdst;
}
 a1c:	5b                   	pop    %ebx
 a1d:	5e                   	pop    %esi
 a1e:	5d                   	pop    %ebp
 a1f:	c3                   	ret    

00000a20 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 a20:	b8 01 00 00 00       	mov    $0x1,%eax
 a25:	cd 40                	int    $0x40
 a27:	c3                   	ret    

00000a28 <exit>:
SYSCALL(exit)
 a28:	b8 02 00 00 00       	mov    $0x2,%eax
 a2d:	cd 40                	int    $0x40
 a2f:	c3                   	ret    

00000a30 <wait>:
SYSCALL(wait)
 a30:	b8 03 00 00 00       	mov    $0x3,%eax
 a35:	cd 40                	int    $0x40
 a37:	c3                   	ret    

00000a38 <pipe>:
SYSCALL(pipe)
 a38:	b8 04 00 00 00       	mov    $0x4,%eax
 a3d:	cd 40                	int    $0x40
 a3f:	c3                   	ret    

00000a40 <read>:
SYSCALL(read)
 a40:	b8 05 00 00 00       	mov    $0x5,%eax
 a45:	cd 40                	int    $0x40
 a47:	c3                   	ret    

00000a48 <write>:
SYSCALL(write)
 a48:	b8 10 00 00 00       	mov    $0x10,%eax
 a4d:	cd 40                	int    $0x40
 a4f:	c3                   	ret    

00000a50 <close>:
SYSCALL(close)
 a50:	b8 15 00 00 00       	mov    $0x15,%eax
 a55:	cd 40                	int    $0x40
 a57:	c3                   	ret    

00000a58 <kill>:
SYSCALL(kill)
 a58:	b8 06 00 00 00       	mov    $0x6,%eax
 a5d:	cd 40                	int    $0x40
 a5f:	c3                   	ret    

00000a60 <exec>:
SYSCALL(exec)
 a60:	b8 07 00 00 00       	mov    $0x7,%eax
 a65:	cd 40                	int    $0x40
 a67:	c3                   	ret    

00000a68 <open>:
SYSCALL(open)
 a68:	b8 0f 00 00 00       	mov    $0xf,%eax
 a6d:	cd 40                	int    $0x40
 a6f:	c3                   	ret    

00000a70 <mknod>:
SYSCALL(mknod)
 a70:	b8 11 00 00 00       	mov    $0x11,%eax
 a75:	cd 40                	int    $0x40
 a77:	c3                   	ret    

00000a78 <unlink>:
SYSCALL(unlink)
 a78:	b8 12 00 00 00       	mov    $0x12,%eax
 a7d:	cd 40                	int    $0x40
 a7f:	c3                   	ret    

00000a80 <fstat>:
SYSCALL(fstat)
 a80:	b8 08 00 00 00       	mov    $0x8,%eax
 a85:	cd 40                	int    $0x40
 a87:	c3                   	ret    

00000a88 <link>:
SYSCALL(link)
 a88:	b8 13 00 00 00       	mov    $0x13,%eax
 a8d:	cd 40                	int    $0x40
 a8f:	c3                   	ret    

00000a90 <mkdir>:
SYSCALL(mkdir)
 a90:	b8 14 00 00 00       	mov    $0x14,%eax
 a95:	cd 40                	int    $0x40
 a97:	c3                   	ret    

00000a98 <chdir>:
SYSCALL(chdir)
 a98:	b8 09 00 00 00       	mov    $0x9,%eax
 a9d:	cd 40                	int    $0x40
 a9f:	c3                   	ret    

00000aa0 <dup>:
SYSCALL(dup)
 aa0:	b8 0a 00 00 00       	mov    $0xa,%eax
 aa5:	cd 40                	int    $0x40
 aa7:	c3                   	ret    

00000aa8 <getpid>:
SYSCALL(getpid)
 aa8:	b8 0b 00 00 00       	mov    $0xb,%eax
 aad:	cd 40                	int    $0x40
 aaf:	c3                   	ret    

00000ab0 <sbrk>:
SYSCALL(sbrk)
 ab0:	b8 0c 00 00 00       	mov    $0xc,%eax
 ab5:	cd 40                	int    $0x40
 ab7:	c3                   	ret    

00000ab8 <sleep>:
SYSCALL(sleep)
 ab8:	b8 0d 00 00 00       	mov    $0xd,%eax
 abd:	cd 40                	int    $0x40
 abf:	c3                   	ret    

00000ac0 <uptime>:
SYSCALL(uptime)
 ac0:	b8 0e 00 00 00       	mov    $0xe,%eax
 ac5:	cd 40                	int    $0x40
 ac7:	c3                   	ret    

00000ac8 <detach>:
SYSCALL(detach)
 ac8:	b8 16 00 00 00       	mov    $0x16,%eax
 acd:	cd 40                	int    $0x40
 acf:	c3                   	ret    

00000ad0 <priority>:
SYSCALL(priority)
 ad0:	b8 17 00 00 00       	mov    $0x17,%eax
 ad5:	cd 40                	int    $0x40
 ad7:	c3                   	ret    

00000ad8 <policy>:
SYSCALL(policy)
 ad8:	b8 18 00 00 00       	mov    $0x18,%eax
 add:	cd 40                	int    $0x40
 adf:	c3                   	ret    

00000ae0 <wait_stat>:
SYSCALL(wait_stat)
 ae0:	b8 19 00 00 00       	mov    $0x19,%eax
 ae5:	cd 40                	int    $0x40
 ae7:	c3                   	ret    
 ae8:	66 90                	xchg   %ax,%ax
 aea:	66 90                	xchg   %ax,%ax
 aec:	66 90                	xchg   %ax,%ax
 aee:	66 90                	xchg   %ax,%ax

00000af0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 af0:	55                   	push   %ebp
 af1:	89 e5                	mov    %esp,%ebp
 af3:	57                   	push   %edi
 af4:	56                   	push   %esi
 af5:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 af6:	89 d3                	mov    %edx,%ebx
 af8:	c1 eb 1f             	shr    $0x1f,%ebx
{
 afb:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 afe:	84 db                	test   %bl,%bl
{
 b00:	89 45 c0             	mov    %eax,-0x40(%ebp)
 b03:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 b05:	74 79                	je     b80 <printint+0x90>
 b07:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 b0b:	74 73                	je     b80 <printint+0x90>
    neg = 1;
    x = -xx;
 b0d:	f7 d8                	neg    %eax
    neg = 1;
 b0f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 b16:	31 f6                	xor    %esi,%esi
 b18:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 b1b:	eb 05                	jmp    b22 <printint+0x32>
 b1d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 b20:	89 fe                	mov    %edi,%esi
 b22:	31 d2                	xor    %edx,%edx
 b24:	f7 f1                	div    %ecx
 b26:	8d 7e 01             	lea    0x1(%esi),%edi
 b29:	0f b6 92 4c 11 00 00 	movzbl 0x114c(%edx),%edx
  }while((x /= base) != 0);
 b30:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 b32:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 b35:	75 e9                	jne    b20 <printint+0x30>
  if(neg)
 b37:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 b3a:	85 d2                	test   %edx,%edx
 b3c:	74 08                	je     b46 <printint+0x56>
    buf[i++] = '-';
 b3e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 b43:	8d 7e 02             	lea    0x2(%esi),%edi
 b46:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 b4a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 b4d:	8d 76 00             	lea    0x0(%esi),%esi
 b50:	0f b6 06             	movzbl (%esi),%eax
 b53:	4e                   	dec    %esi
  write(fd, &c, 1);
 b54:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 b58:	89 3c 24             	mov    %edi,(%esp)
 b5b:	88 45 d7             	mov    %al,-0x29(%ebp)
 b5e:	b8 01 00 00 00       	mov    $0x1,%eax
 b63:	89 44 24 08          	mov    %eax,0x8(%esp)
 b67:	e8 dc fe ff ff       	call   a48 <write>

  while(--i >= 0)
 b6c:	39 de                	cmp    %ebx,%esi
 b6e:	75 e0                	jne    b50 <printint+0x60>
    putc(fd, buf[i]);
}
 b70:	83 c4 4c             	add    $0x4c,%esp
 b73:	5b                   	pop    %ebx
 b74:	5e                   	pop    %esi
 b75:	5f                   	pop    %edi
 b76:	5d                   	pop    %ebp
 b77:	c3                   	ret    
 b78:	90                   	nop
 b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 b80:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 b87:	eb 8d                	jmp    b16 <printint+0x26>
 b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000b90 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 b90:	55                   	push   %ebp
 b91:	89 e5                	mov    %esp,%ebp
 b93:	57                   	push   %edi
 b94:	56                   	push   %esi
 b95:	53                   	push   %ebx
 b96:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 b99:	8b 75 0c             	mov    0xc(%ebp),%esi
 b9c:	0f b6 1e             	movzbl (%esi),%ebx
 b9f:	84 db                	test   %bl,%bl
 ba1:	0f 84 d1 00 00 00    	je     c78 <printf+0xe8>
  state = 0;
 ba7:	31 ff                	xor    %edi,%edi
 ba9:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 baa:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 bad:	89 fa                	mov    %edi,%edx
 baf:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 bb2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 bb5:	eb 41                	jmp    bf8 <printf+0x68>
 bb7:	89 f6                	mov    %esi,%esi
 bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 bc0:	83 f8 25             	cmp    $0x25,%eax
 bc3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 bc6:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 bcb:	74 1e                	je     beb <printf+0x5b>
  write(fd, &c, 1);
 bcd:	b8 01 00 00 00       	mov    $0x1,%eax
 bd2:	89 44 24 08          	mov    %eax,0x8(%esp)
 bd6:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 bd9:	89 44 24 04          	mov    %eax,0x4(%esp)
 bdd:	89 3c 24             	mov    %edi,(%esp)
 be0:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 be3:	e8 60 fe ff ff       	call   a48 <write>
 be8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 beb:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 bec:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 bf0:	84 db                	test   %bl,%bl
 bf2:	0f 84 80 00 00 00    	je     c78 <printf+0xe8>
    if(state == 0){
 bf8:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 bfa:	0f be cb             	movsbl %bl,%ecx
 bfd:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 c00:	74 be                	je     bc0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 c02:	83 fa 25             	cmp    $0x25,%edx
 c05:	75 e4                	jne    beb <printf+0x5b>
      if(c == 'd'){
 c07:	83 f8 64             	cmp    $0x64,%eax
 c0a:	0f 84 f0 00 00 00    	je     d00 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 c10:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 c16:	83 f9 70             	cmp    $0x70,%ecx
 c19:	74 65                	je     c80 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 c1b:	83 f8 73             	cmp    $0x73,%eax
 c1e:	0f 84 8c 00 00 00    	je     cb0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 c24:	83 f8 63             	cmp    $0x63,%eax
 c27:	0f 84 13 01 00 00    	je     d40 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 c2d:	83 f8 25             	cmp    $0x25,%eax
 c30:	0f 84 e2 00 00 00    	je     d18 <printf+0x188>
  write(fd, &c, 1);
 c36:	b8 01 00 00 00       	mov    $0x1,%eax
 c3b:	46                   	inc    %esi
 c3c:	89 44 24 08          	mov    %eax,0x8(%esp)
 c40:	8d 45 e7             	lea    -0x19(%ebp),%eax
 c43:	89 44 24 04          	mov    %eax,0x4(%esp)
 c47:	89 3c 24             	mov    %edi,(%esp)
 c4a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 c4e:	e8 f5 fd ff ff       	call   a48 <write>
 c53:	ba 01 00 00 00       	mov    $0x1,%edx
 c58:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 c5b:	89 54 24 08          	mov    %edx,0x8(%esp)
 c5f:	89 44 24 04          	mov    %eax,0x4(%esp)
 c63:	89 3c 24             	mov    %edi,(%esp)
 c66:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 c69:	e8 da fd ff ff       	call   a48 <write>
  for(i = 0; fmt[i]; i++){
 c6e:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 c72:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 c74:	84 db                	test   %bl,%bl
 c76:	75 80                	jne    bf8 <printf+0x68>
    }
  }
}
 c78:	83 c4 3c             	add    $0x3c,%esp
 c7b:	5b                   	pop    %ebx
 c7c:	5e                   	pop    %esi
 c7d:	5f                   	pop    %edi
 c7e:	5d                   	pop    %ebp
 c7f:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 c80:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 c87:	b9 10 00 00 00       	mov    $0x10,%ecx
 c8c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 c8f:	89 f8                	mov    %edi,%eax
 c91:	8b 13                	mov    (%ebx),%edx
 c93:	e8 58 fe ff ff       	call   af0 <printint>
        ap++;
 c98:	89 d8                	mov    %ebx,%eax
      state = 0;
 c9a:	31 d2                	xor    %edx,%edx
        ap++;
 c9c:	83 c0 04             	add    $0x4,%eax
 c9f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 ca2:	e9 44 ff ff ff       	jmp    beb <printf+0x5b>
 ca7:	89 f6                	mov    %esi,%esi
 ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 cb0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 cb3:	8b 10                	mov    (%eax),%edx
        ap++;
 cb5:	83 c0 04             	add    $0x4,%eax
 cb8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 cbb:	85 d2                	test   %edx,%edx
 cbd:	0f 84 aa 00 00 00    	je     d6d <printf+0x1dd>
        while(*s != 0){
 cc3:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 cc6:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 cc8:	84 c0                	test   %al,%al
 cca:	74 27                	je     cf3 <printf+0x163>
 ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 cd0:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 cd3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 cd8:	43                   	inc    %ebx
  write(fd, &c, 1);
 cd9:	89 44 24 08          	mov    %eax,0x8(%esp)
 cdd:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 ce0:	89 44 24 04          	mov    %eax,0x4(%esp)
 ce4:	89 3c 24             	mov    %edi,(%esp)
 ce7:	e8 5c fd ff ff       	call   a48 <write>
        while(*s != 0){
 cec:	0f b6 03             	movzbl (%ebx),%eax
 cef:	84 c0                	test   %al,%al
 cf1:	75 dd                	jne    cd0 <printf+0x140>
      state = 0;
 cf3:	31 d2                	xor    %edx,%edx
 cf5:	e9 f1 fe ff ff       	jmp    beb <printf+0x5b>
 cfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 d00:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 d07:	b9 0a 00 00 00       	mov    $0xa,%ecx
 d0c:	e9 7b ff ff ff       	jmp    c8c <printf+0xfc>
 d11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 d18:	b9 01 00 00 00       	mov    $0x1,%ecx
 d1d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 d20:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 d24:	89 44 24 04          	mov    %eax,0x4(%esp)
 d28:	89 3c 24             	mov    %edi,(%esp)
 d2b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 d2e:	e8 15 fd ff ff       	call   a48 <write>
      state = 0;
 d33:	31 d2                	xor    %edx,%edx
 d35:	e9 b1 fe ff ff       	jmp    beb <printf+0x5b>
 d3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 d40:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 d43:	8b 03                	mov    (%ebx),%eax
        ap++;
 d45:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 d48:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 d4b:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 d4e:	b8 01 00 00 00       	mov    $0x1,%eax
 d53:	89 44 24 08          	mov    %eax,0x8(%esp)
 d57:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 d5a:	89 44 24 04          	mov    %eax,0x4(%esp)
 d5e:	e8 e5 fc ff ff       	call   a48 <write>
      state = 0;
 d63:	31 d2                	xor    %edx,%edx
        ap++;
 d65:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 d68:	e9 7e fe ff ff       	jmp    beb <printf+0x5b>
          s = "(null)";
 d6d:	bb 45 11 00 00       	mov    $0x1145,%ebx
        while(*s != 0){
 d72:	b0 28                	mov    $0x28,%al
 d74:	e9 57 ff ff ff       	jmp    cd0 <printf+0x140>
 d79:	66 90                	xchg   %ax,%ax
 d7b:	66 90                	xchg   %ax,%ax
 d7d:	66 90                	xchg   %ax,%ax
 d7f:	90                   	nop

00000d80 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 d80:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d81:	a1 38 15 00 00       	mov    0x1538,%eax
{
 d86:	89 e5                	mov    %esp,%ebp
 d88:	57                   	push   %edi
 d89:	56                   	push   %esi
 d8a:	53                   	push   %ebx
 d8b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 d8e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 d91:	eb 0d                	jmp    da0 <free+0x20>
 d93:	90                   	nop
 d94:	90                   	nop
 d95:	90                   	nop
 d96:	90                   	nop
 d97:	90                   	nop
 d98:	90                   	nop
 d99:	90                   	nop
 d9a:	90                   	nop
 d9b:	90                   	nop
 d9c:	90                   	nop
 d9d:	90                   	nop
 d9e:	90                   	nop
 d9f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 da0:	39 c8                	cmp    %ecx,%eax
 da2:	8b 10                	mov    (%eax),%edx
 da4:	73 32                	jae    dd8 <free+0x58>
 da6:	39 d1                	cmp    %edx,%ecx
 da8:	72 04                	jb     dae <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 daa:	39 d0                	cmp    %edx,%eax
 dac:	72 32                	jb     de0 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 dae:	8b 73 fc             	mov    -0x4(%ebx),%esi
 db1:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 db4:	39 fa                	cmp    %edi,%edx
 db6:	74 30                	je     de8 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 db8:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 dbb:	8b 50 04             	mov    0x4(%eax),%edx
 dbe:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 dc1:	39 f1                	cmp    %esi,%ecx
 dc3:	74 3c                	je     e01 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 dc5:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 dc7:	5b                   	pop    %ebx
  freep = p;
 dc8:	a3 38 15 00 00       	mov    %eax,0x1538
}
 dcd:	5e                   	pop    %esi
 dce:	5f                   	pop    %edi
 dcf:	5d                   	pop    %ebp
 dd0:	c3                   	ret    
 dd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 dd8:	39 d0                	cmp    %edx,%eax
 dda:	72 04                	jb     de0 <free+0x60>
 ddc:	39 d1                	cmp    %edx,%ecx
 dde:	72 ce                	jb     dae <free+0x2e>
{
 de0:	89 d0                	mov    %edx,%eax
 de2:	eb bc                	jmp    da0 <free+0x20>
 de4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 de8:	8b 7a 04             	mov    0x4(%edx),%edi
 deb:	01 fe                	add    %edi,%esi
 ded:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 df0:	8b 10                	mov    (%eax),%edx
 df2:	8b 12                	mov    (%edx),%edx
 df4:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 df7:	8b 50 04             	mov    0x4(%eax),%edx
 dfa:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 dfd:	39 f1                	cmp    %esi,%ecx
 dff:	75 c4                	jne    dc5 <free+0x45>
    p->s.size += bp->s.size;
 e01:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 e04:	a3 38 15 00 00       	mov    %eax,0x1538
    p->s.size += bp->s.size;
 e09:	01 ca                	add    %ecx,%edx
 e0b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 e0e:	8b 53 f8             	mov    -0x8(%ebx),%edx
 e11:	89 10                	mov    %edx,(%eax)
}
 e13:	5b                   	pop    %ebx
 e14:	5e                   	pop    %esi
 e15:	5f                   	pop    %edi
 e16:	5d                   	pop    %ebp
 e17:	c3                   	ret    
 e18:	90                   	nop
 e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000e20 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 e20:	55                   	push   %ebp
 e21:	89 e5                	mov    %esp,%ebp
 e23:	57                   	push   %edi
 e24:	56                   	push   %esi
 e25:	53                   	push   %ebx
 e26:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 e29:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 e2c:	8b 15 38 15 00 00    	mov    0x1538,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 e32:	8d 78 07             	lea    0x7(%eax),%edi
 e35:	c1 ef 03             	shr    $0x3,%edi
 e38:	47                   	inc    %edi
  if((prevp = freep) == 0){
 e39:	85 d2                	test   %edx,%edx
 e3b:	0f 84 8f 00 00 00    	je     ed0 <malloc+0xb0>
 e41:	8b 02                	mov    (%edx),%eax
 e43:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 e46:	39 cf                	cmp    %ecx,%edi
 e48:	76 66                	jbe    eb0 <malloc+0x90>
 e4a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 e50:	bb 00 10 00 00       	mov    $0x1000,%ebx
 e55:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 e58:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 e5f:	eb 10                	jmp    e71 <malloc+0x51>
 e61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e68:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 e6a:	8b 48 04             	mov    0x4(%eax),%ecx
 e6d:	39 f9                	cmp    %edi,%ecx
 e6f:	73 3f                	jae    eb0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 e71:	39 05 38 15 00 00    	cmp    %eax,0x1538
 e77:	89 c2                	mov    %eax,%edx
 e79:	75 ed                	jne    e68 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 e7b:	89 34 24             	mov    %esi,(%esp)
 e7e:	e8 2d fc ff ff       	call   ab0 <sbrk>
  if(p == (char*)-1)
 e83:	83 f8 ff             	cmp    $0xffffffff,%eax
 e86:	74 18                	je     ea0 <malloc+0x80>
  hp->s.size = nu;
 e88:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 e8b:	83 c0 08             	add    $0x8,%eax
 e8e:	89 04 24             	mov    %eax,(%esp)
 e91:	e8 ea fe ff ff       	call   d80 <free>
  return freep;
 e96:	8b 15 38 15 00 00    	mov    0x1538,%edx
      if((p = morecore(nunits)) == 0)
 e9c:	85 d2                	test   %edx,%edx
 e9e:	75 c8                	jne    e68 <malloc+0x48>
        return 0;
  }
}
 ea0:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 ea3:	31 c0                	xor    %eax,%eax
}
 ea5:	5b                   	pop    %ebx
 ea6:	5e                   	pop    %esi
 ea7:	5f                   	pop    %edi
 ea8:	5d                   	pop    %ebp
 ea9:	c3                   	ret    
 eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 eb0:	39 cf                	cmp    %ecx,%edi
 eb2:	74 4c                	je     f00 <malloc+0xe0>
        p->s.size -= nunits;
 eb4:	29 f9                	sub    %edi,%ecx
 eb6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 eb9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 ebc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 ebf:	89 15 38 15 00 00    	mov    %edx,0x1538
}
 ec5:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 ec8:	83 c0 08             	add    $0x8,%eax
}
 ecb:	5b                   	pop    %ebx
 ecc:	5e                   	pop    %esi
 ecd:	5f                   	pop    %edi
 ece:	5d                   	pop    %ebp
 ecf:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 ed0:	b8 3c 15 00 00       	mov    $0x153c,%eax
 ed5:	ba 3c 15 00 00       	mov    $0x153c,%edx
    base.s.size = 0;
 eda:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 edc:	a3 38 15 00 00       	mov    %eax,0x1538
    base.s.size = 0;
 ee1:	b8 3c 15 00 00       	mov    $0x153c,%eax
    base.s.ptr = freep = prevp = &base;
 ee6:	89 15 3c 15 00 00    	mov    %edx,0x153c
    base.s.size = 0;
 eec:	89 0d 40 15 00 00    	mov    %ecx,0x1540
 ef2:	e9 53 ff ff ff       	jmp    e4a <malloc+0x2a>
 ef7:	89 f6                	mov    %esi,%esi
 ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 f00:	8b 08                	mov    (%eax),%ecx
 f02:	89 0a                	mov    %ecx,(%edx)
 f04:	eb b9                	jmp    ebf <malloc+0x9f>
