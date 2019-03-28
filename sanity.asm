
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
  10:	b8 55 10 00 00       	mov    $0x1055,%eax
  15:	89 44 24 04          	mov    %eax,0x4(%esp)
  19:	89 1c 24             	mov    %ebx,(%esp)
  1c:	e8 4f 07 00 00       	call   770 <strcmp>
  21:	85 c0                	test   %eax,%eax
  23:	75 11                	jne    36 <main+0x36>
		testExitWait();
  25:	e8 56 01 00 00       	call   180 <testExitWait>
        testWaitStat();
        testPolicy(1);
        testPolicy(2);
        testPolicy(3);
    }
    exit(0);
  2a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  31:	e8 42 09 00 00       	call   978 <exit>
	else if(strcmp(arg, "detach") == 0)
  36:	c7 44 24 04 5a 10 00 	movl   $0x105a,0x4(%esp)
  3d:	00 
  3e:	89 1c 24             	mov    %ebx,(%esp)
  41:	e8 2a 07 00 00       	call   770 <strcmp>
  46:	85 c0                	test   %eax,%eax
  48:	75 08                	jne    52 <main+0x52>
		testDetach();
  4a:	e8 d1 01 00 00       	call   220 <testDetach>
  4f:	90                   	nop
  50:	eb d8                	jmp    2a <main+0x2a>
	else if(strcmp(arg, "wait_stat") == 0)
  52:	c7 44 24 04 61 10 00 	movl   $0x1061,0x4(%esp)
  59:	00 
  5a:	89 1c 24             	mov    %ebx,(%esp)
  5d:	e8 0e 07 00 00       	call   770 <strcmp>
  62:	85 c0                	test   %eax,%eax
  64:	74 22                	je     88 <main+0x88>
	else if(strcmp(arg, "policy1") == 0)
  66:	c7 44 24 04 6b 10 00 	movl   $0x106b,0x4(%esp)
  6d:	00 
  6e:	89 1c 24             	mov    %ebx,(%esp)
  71:	e8 fa 06 00 00       	call   770 <strcmp>
  76:	85 c0                	test   %eax,%eax
  78:	75 18                	jne    92 <main+0x92>
		testPolicy(1);
  7a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  81:	e8 da 03 00 00       	call   460 <testPolicy>
  86:	eb a2                	jmp    2a <main+0x2a>
		testWaitStat();
  88:	e8 23 03 00 00       	call   3b0 <testWaitStat>
  8d:	8d 76 00             	lea    0x0(%esi),%esi
  90:	eb 98                	jmp    2a <main+0x2a>
	else if(strcmp(arg, "policy2") == 0)
  92:	c7 44 24 04 73 10 00 	movl   $0x1073,0x4(%esp)
  99:	00 
  9a:	89 1c 24             	mov    %ebx,(%esp)
  9d:	e8 ce 06 00 00       	call   770 <strcmp>
  a2:	85 c0                	test   %eax,%eax
  a4:	74 39                	je     df <main+0xdf>
	else if(strcmp(arg, "policy3") == 0)
  a6:	c7 44 24 04 7b 10 00 	movl   $0x107b,0x4(%esp)
  ad:	00 
  ae:	89 1c 24             	mov    %ebx,(%esp)
  b1:	e8 ba 06 00 00       	call   770 <strcmp>
  b6:	85 c0                	test   %eax,%eax
  b8:	74 5d                	je     117 <main+0x117>
    else if(strcmp(arg, "perf1") == 0)
  ba:	c7 44 24 04 83 10 00 	movl   $0x1083,0x4(%esp)
  c1:	00 
  c2:	89 1c 24             	mov    %ebx,(%esp)
  c5:	e8 a6 06 00 00       	call   770 <strcmp>
  ca:	85 c0                	test   %eax,%eax
  cc:	75 5a                	jne    128 <main+0x128>
		testPerf(1);
  ce:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  d5:	e8 96 04 00 00       	call   570 <testPerf>
  da:	e9 4b ff ff ff       	jmp    2a <main+0x2a>
		testPolicy(2);
  df:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  e6:	e8 75 03 00 00       	call   460 <testPolicy>
  eb:	e9 3a ff ff ff       	jmp    2a <main+0x2a>
        testExitWait();
  f0:	e8 8b 00 00 00       	call   180 <testExitWait>
        testDetach();
  f5:	e8 26 01 00 00       	call   220 <testDetach>
        testWaitStat();
  fa:	e8 b1 02 00 00       	call   3b0 <testWaitStat>
        testPolicy(1);
  ff:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 106:	e8 55 03 00 00       	call   460 <testPolicy>
        testPolicy(2);
 10b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 112:	e8 49 03 00 00       	call   460 <testPolicy>
        testPolicy(3);
 117:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
 11e:	e8 3d 03 00 00       	call   460 <testPolicy>
 123:	e9 02 ff ff ff       	jmp    2a <main+0x2a>
	else if(strcmp(arg, "perf2") == 0)
 128:	c7 44 24 04 89 10 00 	movl   $0x1089,0x4(%esp)
 12f:	00 
 130:	89 1c 24             	mov    %ebx,(%esp)
 133:	e8 38 06 00 00       	call   770 <strcmp>
 138:	85 c0                	test   %eax,%eax
 13a:	75 11                	jne    14d <main+0x14d>
		testPerf(2);
 13c:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 143:	e8 28 04 00 00       	call   570 <testPerf>
 148:	e9 dd fe ff ff       	jmp    2a <main+0x2a>
	else if(strcmp(arg, "perf3") == 0)
 14d:	c7 44 24 04 8f 10 00 	movl   $0x108f,0x4(%esp)
 154:	00 
 155:	89 1c 24             	mov    %ebx,(%esp)
 158:	e8 13 06 00 00       	call   770 <strcmp>
 15d:	85 c0                	test   %eax,%eax
 15f:	75 8f                	jne    f0 <main+0xf0>
		testPerf(3);
 161:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
 168:	e8 03 04 00 00       	call   570 <testPerf>
 16d:	e9 b8 fe ff ff       	jmp    2a <main+0x2a>
 172:	66 90                	xchg   %ax,%ax
 174:	66 90                	xchg   %ax,%ax
 176:	66 90                	xchg   %ax,%ax
 178:	66 90                	xchg   %ax,%ax
 17a:	66 90                	xchg   %ax,%ax
 17c:	66 90                	xchg   %ax,%ax
 17e:	66 90                	xchg   %ax,%ax

00000180 <testExitWait>:
void testExitWait(){
 180:	55                   	push   %ebp
    printf(1, "----------test exit wait started\n");
 181:	b9 58 0e 00 00       	mov    $0xe58,%ecx
void testExitWait(){
 186:	89 e5                	mov    %esp,%ebp
 188:	57                   	push   %edi
 189:	56                   	push   %esi
    for (int i = 0; i < 5; i++) {
 18a:	31 f6                	xor    %esi,%esi
void testExitWait(){
 18c:	53                   	push   %ebx
 18d:	83 ec 2c             	sub    $0x2c,%esp
    printf(1, "----------test exit wait started\n");
 190:	89 4c 24 04          	mov    %ecx,0x4(%esp)
            wait(&status);
 194:	8d 7d e4             	lea    -0x1c(%ebp),%edi
    printf(1, "----------test exit wait started\n");
 197:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 19e:	e8 3d 09 00 00       	call   ae0 <printf>
        pid = fork();
 1a3:	e8 c8 07 00 00       	call   970 <fork>
        if (pid > 0) {
 1a8:	85 c0                	test   %eax,%eax
        pid = fork();
 1aa:	89 c3                	mov    %eax,%ebx
        if (pid > 0) {
 1ac:	7e 53                	jle    201 <testExitWait+0x81>
            wait(&status);
 1ae:	89 3c 24             	mov    %edi,(%esp)
    for (int i = 0; i < 5; i++) {
 1b1:	46                   	inc    %esi
            wait(&status);
 1b2:	e8 c9 07 00 00       	call   980 <wait>
            kill(pid);
 1b7:	89 1c 24             	mov    %ebx,(%esp)
 1ba:	e8 e9 07 00 00       	call   9a8 <kill>
            printf(1, "process with pid %d exited with status %d\n", pid, status);
 1bf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 1c2:	ba 7c 0e 00 00       	mov    $0xe7c,%edx
 1c7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 1cb:	89 54 24 04          	mov    %edx,0x4(%esp)
 1cf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1d6:	89 44 24 0c          	mov    %eax,0xc(%esp)
 1da:	e8 01 09 00 00       	call   ae0 <printf>
    for (int i = 0; i < 5; i++) {
 1df:	83 fe 05             	cmp    $0x5,%esi
 1e2:	75 bf                	jne    1a3 <testExitWait+0x23>
    printf(1, "----------test exit wait ended\n");
 1e4:	b8 a8 0e 00 00       	mov    $0xea8,%eax
 1e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 1ed:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1f4:	e8 e7 08 00 00       	call   ae0 <printf>
}
 1f9:	83 c4 2c             	add    $0x2c,%esp
 1fc:	5b                   	pop    %ebx
 1fd:	5e                   	pop    %esi
 1fe:	5f                   	pop    %edi
 1ff:	5d                   	pop    %ebp
 200:	c3                   	ret    
            sleep(5);
 201:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 208:	e8 fb 07 00 00       	call   a08 <sleep>
            exit(i);
 20d:	89 34 24             	mov    %esi,(%esp)
 210:	e8 63 07 00 00       	call   978 <exit>
 215:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000220 <testDetach>:
void testDetach(){
 220:	55                   	push   %ebp
    printf(1, "----------test detach started\n");
 221:	b8 c8 0e 00 00       	mov    $0xec8,%eax
void testDetach(){
 226:	89 e5                	mov    %esp,%ebp
 228:	53                   	push   %ebx
 229:	83 ec 14             	sub    $0x14,%esp
    printf(1, "----------test detach started\n");
 22c:	89 44 24 04          	mov    %eax,0x4(%esp)
 230:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 237:	e8 a4 08 00 00       	call   ae0 <printf>
    pid = fork(); 
 23c:	e8 2f 07 00 00       	call   970 <fork>
    if(pid > 0) {
 241:	85 c0                	test   %eax,%eax
    pid = fork(); 
 243:	89 c3                	mov    %eax,%ebx
    if(pid > 0) {
 245:	7e 67                	jle    2ae <testDetach+0x8e>
        first_status = detach(pid); // status = 0
 247:	89 04 24             	mov    %eax,(%esp)
 24a:	e8 c9 07 00 00       	call   a18 <detach>
        printf(1, "first_status: %d\n", first_status);
 24f:	ba 78 0f 00 00       	mov    $0xf78,%edx
 254:	89 54 24 04          	mov    %edx,0x4(%esp)
 258:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 25f:	89 44 24 08          	mov    %eax,0x8(%esp)
 263:	e8 78 08 00 00       	call   ae0 <printf>
        second_status = detach(pid); // status = -1, because this process has already detached this child, and it doesn’t have this child anymore.
 268:	89 1c 24             	mov    %ebx,(%esp)
 26b:	e8 a8 07 00 00       	call   a18 <detach>
        printf(1, "second_status: %d\n", second_status);
 270:	b9 8a 0f 00 00       	mov    $0xf8a,%ecx
 275:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 279:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 280:	89 44 24 08          	mov    %eax,0x8(%esp)
 284:	e8 57 08 00 00       	call   ae0 <printf>
        third_status = detach(77); // status = -1, because this process doesn’t have a child with this pid.
 289:	c7 04 24 4d 00 00 00 	movl   $0x4d,(%esp)
 290:	e8 83 07 00 00       	call   a18 <detach>
        printf(1, "third_status: %d\n", third_status);
 295:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 29c:	89 44 24 08          	mov    %eax,0x8(%esp)
 2a0:	b8 9d 0f 00 00       	mov    $0xf9d,%eax
 2a5:	89 44 24 04          	mov    %eax,0x4(%esp)
 2a9:	e8 32 08 00 00       	call   ae0 <printf>
    kill(pid);
 2ae:	89 1c 24             	mov    %ebx,(%esp)
 2b1:	e8 f2 06 00 00       	call   9a8 <kill>
    sleep(10);
 2b6:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
 2bd:	e8 46 07 00 00       	call   a08 <sleep>
    printf(1, "----------test detach ended\n");
 2c2:	b8 af 0f 00 00       	mov    $0xfaf,%eax
 2c7:	89 44 24 04          	mov    %eax,0x4(%esp)
 2cb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2d2:	e8 09 08 00 00       	call   ae0 <printf>
}
 2d7:	83 c4 14             	add    $0x14,%esp
 2da:	5b                   	pop    %ebx
 2db:	5d                   	pop    %ebp
 2dc:	c3                   	ret    
 2dd:	8d 76 00             	lea    0x0(%esi),%esi

000002e0 <printPerf>:
void printPerf(struct perf *performance) {
 2e0:	55                   	push   %ebp
    printf(1, "pref:\n");
 2e1:	b8 cc 0f 00 00       	mov    $0xfcc,%eax
void printPerf(struct perf *performance) {
 2e6:	89 e5                	mov    %esp,%ebp
 2e8:	53                   	push   %ebx
 2e9:	83 ec 14             	sub    $0x14,%esp
 2ec:	8b 5d 08             	mov    0x8(%ebp),%ebx
    printf(1, "pref:\n");
 2ef:	89 44 24 04          	mov    %eax,0x4(%esp)
 2f3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2fa:	e8 e1 07 00 00       	call   ae0 <printf>
    printf(1, "\tctime: %d\n", performance->ctime);
 2ff:	ba d3 0f 00 00       	mov    $0xfd3,%edx
 304:	8b 03                	mov    (%ebx),%eax
 306:	89 54 24 04          	mov    %edx,0x4(%esp)
 30a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 311:	89 44 24 08          	mov    %eax,0x8(%esp)
 315:	e8 c6 07 00 00       	call   ae0 <printf>
    printf(1, "\tttime: %d\n", performance->ttime);
 31a:	8b 43 04             	mov    0x4(%ebx),%eax
 31d:	b9 df 0f 00 00       	mov    $0xfdf,%ecx
 322:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 326:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 32d:	89 44 24 08          	mov    %eax,0x8(%esp)
 331:	e8 aa 07 00 00       	call   ae0 <printf>
    printf(1, "\tstime: %d\n", performance->stime);
 336:	8b 43 08             	mov    0x8(%ebx),%eax
 339:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 340:	89 44 24 08          	mov    %eax,0x8(%esp)
 344:	b8 eb 0f 00 00       	mov    $0xfeb,%eax
 349:	89 44 24 04          	mov    %eax,0x4(%esp)
 34d:	e8 8e 07 00 00       	call   ae0 <printf>
    printf(1, "\tretime: %d\n", performance->retime);
 352:	8b 43 0c             	mov    0xc(%ebx),%eax
 355:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 35c:	89 44 24 08          	mov    %eax,0x8(%esp)
 360:	b8 f7 0f 00 00       	mov    $0xff7,%eax
 365:	89 44 24 04          	mov    %eax,0x4(%esp)
 369:	e8 72 07 00 00       	call   ae0 <printf>
    printf(1, "\trutime: %d\n", performance->rutime);
 36e:	8b 43 10             	mov    0x10(%ebx),%eax
 371:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 378:	89 44 24 08          	mov    %eax,0x8(%esp)
 37c:	b8 04 10 00 00       	mov    $0x1004,%eax
 381:	89 44 24 04          	mov    %eax,0x4(%esp)
 385:	e8 56 07 00 00       	call   ae0 <printf>
    printf(1, "\n\tTurnaround time: %d\n", (performance->ttime - performance->ctime));
 38a:	8b 43 04             	mov    0x4(%ebx),%eax
 38d:	b9 11 10 00 00       	mov    $0x1011,%ecx
 392:	8b 13                	mov    (%ebx),%edx
 394:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 398:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 39f:	29 d0                	sub    %edx,%eax
 3a1:	89 44 24 08          	mov    %eax,0x8(%esp)
 3a5:	e8 36 07 00 00       	call   ae0 <printf>
}
 3aa:	83 c4 14             	add    $0x14,%esp
 3ad:	5b                   	pop    %ebx
 3ae:	5d                   	pop    %ebp
 3af:	c3                   	ret    

000003b0 <testWaitStat>:
void testWaitStat(){
 3b0:	55                   	push   %ebp
    printf(1, "----------test wait_stat started\n");
 3b1:	b9 e8 0e 00 00       	mov    $0xee8,%ecx
void testWaitStat(){
 3b6:	89 e5                	mov    %esp,%ebp
 3b8:	57                   	push   %edi
 3b9:	56                   	push   %esi
 3ba:	53                   	push   %ebx
    for (int i = 0; i < 3; i++) {
 3bb:	31 db                	xor    %ebx,%ebx
void testWaitStat(){
 3bd:	83 ec 3c             	sub    $0x3c,%esp
    printf(1, "----------test wait_stat started\n");
 3c0:	89 4c 24 04          	mov    %ecx,0x4(%esp)
            wait_stat(&status, &perf);
 3c4:	8d 75 d4             	lea    -0x2c(%ebp),%esi
    printf(1, "----------test wait_stat started\n");
 3c7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 3ce:	e8 0d 07 00 00       	call   ae0 <printf>
        pid = fork();
 3d3:	e8 98 05 00 00       	call   970 <fork>
        if (pid > 0) {
 3d8:	85 c0                	test   %eax,%eax
        pid = fork();
 3da:	89 c7                	mov    %eax,%edi
        if (pid > 0) {
 3dc:	7e 62                	jle    440 <testWaitStat+0x90>
            wait_stat(&status, &perf);
 3de:	8d 45 d0             	lea    -0x30(%ebp),%eax
    for (int i = 0; i < 3; i++) {
 3e1:	43                   	inc    %ebx
            wait_stat(&status, &perf);
 3e2:	89 74 24 04          	mov    %esi,0x4(%esp)
 3e6:	89 04 24             	mov    %eax,(%esp)
 3e9:	e8 42 06 00 00       	call   a30 <wait_stat>
            printf(1, "process with pid %d exited with status %d\n", pid, status);
 3ee:	8b 45 d0             	mov    -0x30(%ebp),%eax
 3f1:	ba 7c 0e 00 00       	mov    $0xe7c,%edx
 3f6:	89 54 24 04          	mov    %edx,0x4(%esp)
 3fa:	89 7c 24 08          	mov    %edi,0x8(%esp)
 3fe:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 405:	89 44 24 0c          	mov    %eax,0xc(%esp)
 409:	e8 d2 06 00 00       	call   ae0 <printf>
            kill(pid);
 40e:	89 3c 24             	mov    %edi,(%esp)
 411:	e8 92 05 00 00       	call   9a8 <kill>
            printPerf(&perf);
 416:	89 34 24             	mov    %esi,(%esp)
 419:	e8 c2 fe ff ff       	call   2e0 <printPerf>
    for (int i = 0; i < 3; i++) {
 41e:	83 fb 03             	cmp    $0x3,%ebx
 421:	75 b0                	jne    3d3 <testWaitStat+0x23>
    printf(1, "----------test wait_stat ended\n");
 423:	b8 0c 0f 00 00       	mov    $0xf0c,%eax
 428:	89 44 24 04          	mov    %eax,0x4(%esp)
 42c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 433:	e8 a8 06 00 00       	call   ae0 <printf>
}
 438:	83 c4 3c             	add    $0x3c,%esp
 43b:	5b                   	pop    %ebx
 43c:	5e                   	pop    %esi
 43d:	5f                   	pop    %edi
 43e:	5d                   	pop    %ebp
 43f:	c3                   	ret    
            sleep(5);
 440:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 447:	e8 bc 05 00 00       	call   a08 <sleep>
            exit(i);
 44c:	89 1c 24             	mov    %ebx,(%esp)
 44f:	e8 24 05 00 00       	call   978 <exit>
 454:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 45a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000460 <testPolicy>:
void testPolicy(int policyNum) {
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	56                   	push   %esi
 465:	53                   	push   %ebx
 466:	83 ec 3c             	sub    $0x3c,%esp
    printf(1, "----------test policy %d started\n", policyNum);
 469:	8b 45 08             	mov    0x8(%ebp),%eax
 46c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 473:	89 44 24 08          	mov    %eax,0x8(%esp)
 477:	b8 2c 0f 00 00       	mov    $0xf2c,%eax
 47c:	89 44 24 04          	mov    %eax,0x4(%esp)
 480:	e8 5b 06 00 00       	call   ae0 <printf>
    policy(policyNum);
 485:	8b 45 08             	mov    0x8(%ebp),%eax
 488:	89 04 24             	mov    %eax,(%esp)
 48b:	e8 98 05 00 00       	call   a28 <policy>
    pid1 = fork();
 490:	e8 db 04 00 00       	call   970 <fork>
    if (pid1 > 0) {
 495:	85 c0                	test   %eax,%eax
 497:	7f 4a                	jg     4e3 <testPolicy+0x83>
 499:	31 db                	xor    %ebx,%ebx
                wait_stat(&status, &perf1);
 49b:	8d 7d d4             	lea    -0x2c(%ebp),%edi
 49e:	8d 75 d0             	lea    -0x30(%ebp),%esi
 4a1:	eb 0d                	jmp    4b0 <testPolicy+0x50>
 4a3:	90                   	nop
 4a4:	90                   	nop
 4a5:	90                   	nop
 4a6:	90                   	nop
 4a7:	90                   	nop
 4a8:	90                   	nop
 4a9:	90                   	nop
 4aa:	90                   	nop
 4ab:	90                   	nop
 4ac:	90                   	nop
 4ad:	90                   	nop
 4ae:	90                   	nop
 4af:	90                   	nop
            pid = fork();
 4b0:	e8 bb 04 00 00       	call   970 <fork>
            if (pid > 0) {
 4b5:	85 c0                	test   %eax,%eax
 4b7:	7e 4c                	jle    505 <testPolicy+0xa5>
                sleep(5);
 4b9:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
        for (int a = 0; a < 100; ++a) {
 4c0:	43                   	inc    %ebx
                sleep(5);
 4c1:	e8 42 05 00 00       	call   a08 <sleep>
                wait_stat(&status, &perf1);
 4c6:	89 7c 24 04          	mov    %edi,0x4(%esp)
 4ca:	89 34 24             	mov    %esi,(%esp)
 4cd:	e8 5e 05 00 00       	call   a30 <wait_stat>
        for (int a = 0; a < 100; ++a) {
 4d2:	83 fb 64             	cmp    $0x64,%ebx
 4d5:	75 d9                	jne    4b0 <testPolicy+0x50>
        exit(0);
 4d7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4de:	e8 95 04 00 00       	call   978 <exit>
        wait_stat(&status1, &perf2);
 4e3:	8d 5d d4             	lea    -0x2c(%ebp),%ebx
 4e6:	8d 45 d0             	lea    -0x30(%ebp),%eax
 4e9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 4ed:	89 04 24             	mov    %eax,(%esp)
 4f0:	e8 3b 05 00 00       	call   a30 <wait_stat>
        printPerf(&perf2);
 4f5:	89 1c 24             	mov    %ebx,(%esp)
 4f8:	e8 e3 fd ff ff       	call   2e0 <printPerf>
}
 4fd:	83 c4 3c             	add    $0x3c,%esp
 500:	5b                   	pop    %ebx
 501:	5e                   	pop    %esi
 502:	5f                   	pop    %edi
 503:	5d                   	pop    %ebp
 504:	c3                   	ret    
                int pr = a % 11;
 505:	89 d8                	mov    %ebx,%eax
 507:	ba a3 8b 2e ba       	mov    $0xba2e8ba3,%edx
 50c:	f7 e2                	mul    %edx
 50e:	89 d0                	mov    %edx,%eax
 510:	c1 e8 03             	shr    $0x3,%eax
 513:	8d 14 80             	lea    (%eax,%eax,4),%edx
 516:	8d 04 50             	lea    (%eax,%edx,2),%eax
                if(pr == 0 && policyNum == 2)
 519:	29 c3                	sub    %eax,%ebx
 51b:	89 d8                	mov    %ebx,%eax
 51d:	75 0c                	jne    52b <testPolicy+0xcb>
                    pr = 1;
 51f:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
 523:	ba 01 00 00 00       	mov    $0x1,%edx
 528:	0f 44 c2             	cmove  %edx,%eax
                priority(pr);
 52b:	89 04 24             	mov    %eax,(%esp)
 52e:	e8 ed 04 00 00       	call   a20 <priority>
                sleep(5);
 533:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 53a:	e8 c9 04 00 00       	call   a08 <sleep>
                exit(0);
 53f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 546:	e8 2d 04 00 00       	call   978 <exit>
 54b:	90                   	nop
 54c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000550 <procCalculate>:
int procCalculate(int x) {
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	83 ec 18             	sub    $0x18,%esp
    for (int i = 0; i < x; ++i) {
 556:	8b 45 08             	mov    0x8(%ebp),%eax
 559:	85 c0                	test   %eax,%eax
 55b:	7f 04                	jg     561 <procCalculate+0x11>
}
 55d:	31 c0                	xor    %eax,%eax
 55f:	c9                   	leave  
 560:	c3                   	ret    
        exit(0);
 561:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 568:	e8 0b 04 00 00       	call   978 <exit>
 56d:	8d 76 00             	lea    0x0(%esi),%esi

00000570 <testPerf>:
void testPerf(int policyNum){
 570:	55                   	push   %ebp
    printf(1, "----------test preformance %d started\n", policyNum);
 571:	b8 50 0f 00 00       	mov    $0xf50,%eax
void testPerf(int policyNum){
 576:	89 e5                	mov    %esp,%ebp
 578:	57                   	push   %edi
 579:	56                   	push   %esi
 57a:	53                   	push   %ebx
 57b:	83 ec 3c             	sub    $0x3c,%esp
 57e:	8b 7d 08             	mov    0x8(%ebp),%edi
    printf(1, "----------test preformance %d started\n", policyNum);
 581:	89 44 24 04          	mov    %eax,0x4(%esp)
 585:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 58c:	89 7c 24 08          	mov    %edi,0x8(%esp)
 590:	e8 4b 05 00 00       	call   ae0 <printf>
    policy(policyNum);
 595:	89 3c 24             	mov    %edi,(%esp)
 598:	e8 8b 04 00 00       	call   a28 <policy>
    int pid1 = fork();
 59d:	e8 ce 03 00 00       	call   970 <fork>
    if (pid1 > 0) {
 5a2:	85 c0                	test   %eax,%eax
 5a4:	7e 1a                	jle    5c0 <testPerf+0x50>
        wait(&status1);
 5a6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
 5a9:	89 04 24             	mov    %eax,(%esp)
 5ac:	e8 cf 03 00 00       	call   980 <wait>
}
 5b1:	83 c4 3c             	add    $0x3c,%esp
 5b4:	5b                   	pop    %ebx
 5b5:	5e                   	pop    %esi
 5b6:	5f                   	pop    %edi
 5b7:	5d                   	pop    %ebp
 5b8:	c3                   	ret    
 5b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        int pid3 = fork();
 5c0:	e8 ab 03 00 00       	call   970 <fork>
        if (pid3 > 0) {
 5c5:	85 c0                	test   %eax,%eax
 5c7:	0f 8f 1c 01 00 00    	jg     6e9 <testPerf+0x179>
 5cd:	bb 0a 00 00 00       	mov    $0xa,%ebx
                    wait(&status_5);
 5d2:	8d 75 d4             	lea    -0x2c(%ebp),%esi
 5d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
                int pid_5 = fork();
 5e0:	e8 8b 03 00 00       	call   970 <fork>
                    sleep(10);
 5e5:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
                if (pid_5 > 0) {
 5ec:	85 c0                	test   %eax,%eax
 5ee:	0f 8e 94 00 00 00    	jle    688 <testPerf+0x118>
                    sleep(10);
 5f4:	e8 0f 04 00 00       	call   a08 <sleep>
                    wait(&status_5);
 5f9:	89 34 24             	mov    %esi,(%esp)
 5fc:	e8 7f 03 00 00       	call   980 <wait>
            for (int i = 0; i < nProcs; i++){
 601:	4b                   	dec    %ebx
 602:	75 dc                	jne    5e0 <testPerf+0x70>
        int pid5 = fork();
 604:	e8 67 03 00 00       	call   970 <fork>
        if (pid5 > 0) {
 609:	85 c0                	test   %eax,%eax
 60b:	90                   	nop
 60c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 610:	0f 8f 19 01 00 00    	jg     72f <testPerf+0x1bf>
 616:	bb 0a 00 00 00       	mov    $0xa,%ebx
 61b:	90                   	nop
 61c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                int pid_5 = fork();
 620:	e8 4b 03 00 00       	call   970 <fork>
                if (pid_5 > 0) {
 625:	85 c0                	test   %eax,%eax
 627:	7e 66                	jle    68f <testPerf+0x11f>
                    sleep(10);
 629:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
 630:	e8 d3 03 00 00       	call   a08 <sleep>
                    wait(&status_5);
 635:	89 34 24             	mov    %esi,(%esp)
 638:	e8 43 03 00 00       	call   980 <wait>
            for (int i = 0; i < nProcs; i++){
 63d:	4b                   	dec    %ebx
 63e:	75 e0                	jne    620 <testPerf+0xb0>
        int pid2 = fork();
 640:	e8 2b 03 00 00       	call   970 <fork>
        if (pid2 > 0) {
 645:	85 c0                	test   %eax,%eax
 647:	7f 5d                	jg     6a6 <testPerf+0x136>
 649:	bb 0a 00 00 00       	mov    $0xa,%ebx
 64e:	66 90                	xchg   %ax,%ax
                int pid_5 = fork();
 650:	e8 1b 03 00 00       	call   970 <fork>
                if (pid_5 > 0) {
 655:	85 c0                	test   %eax,%eax
 657:	7e 23                	jle    67c <testPerf+0x10c>
                    sleep(10);
 659:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
 660:	e8 a3 03 00 00       	call   a08 <sleep>
                    wait(&status_5);
 665:	89 34 24             	mov    %esi,(%esp)
 668:	e8 13 03 00 00       	call   980 <wait>
            for (int i = 0; i < nProcs; i++){
 66d:	4b                   	dec    %ebx
 66e:	75 e0                	jne    650 <testPerf+0xe0>
        exit(0);
 670:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 677:	e8 fc 02 00 00       	call   978 <exit>
                    if(policyNum == 3)
 67c:	83 ff 03             	cmp    $0x3,%edi
 67f:	74 17                	je     698 <testPerf+0x128>
                        priority(1);
 681:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 688:	e8 93 03 00 00       	call   a20 <priority>
 68d:	eb e1                	jmp    670 <testPerf+0x100>
                    priority(5);
 68f:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 696:	eb f0                	jmp    688 <testPerf+0x118>
                        priority(0);
 698:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 69f:	e8 7c 03 00 00       	call   a20 <priority>
 6a4:	eb ca                	jmp    670 <testPerf+0x100>
            sleep(10);
 6a6:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
 6ad:	e8 56 03 00 00       	call   a08 <sleep>
            wait_stat(&status2, &perf2);
 6b2:	8d 45 d0             	lea    -0x30(%ebp),%eax
 6b5:	89 74 24 04          	mov    %esi,0x4(%esp)
 6b9:	89 04 24             	mov    %eax,(%esp)
 6bc:	e8 6f 03 00 00       	call   a30 <wait_stat>
            printf(1, "high priority process\n");
 6c1:	c7 44 24 04 3e 10 00 	movl   $0x103e,0x4(%esp)
 6c8:	00 
 6c9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 6d0:	e8 0b 04 00 00       	call   ae0 <printf>
            printPerf(&perf2);
 6d5:	89 34 24             	mov    %esi,(%esp)
 6d8:	e8 03 fc ff ff       	call   2e0 <printPerf>
            exit(0);
 6dd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 6e4:	e8 8f 02 00 00       	call   978 <exit>
            sleep(10);
 6e9:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
            wait_stat(&status3, &perf3);
 6f0:	8d 5d d4             	lea    -0x2c(%ebp),%ebx
            sleep(10);
 6f3:	e8 10 03 00 00       	call   a08 <sleep>
            wait_stat(&status3, &perf3);
 6f8:	8d 45 d0             	lea    -0x30(%ebp),%eax
 6fb:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 6ff:	89 04 24             	mov    %eax,(%esp)
 702:	e8 29 03 00 00       	call   a30 <wait_stat>
            printf(1, "low priority process\n");
 707:	c7 44 24 04 28 10 00 	movl   $0x1028,0x4(%esp)
 70e:	00 
 70f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 716:	e8 c5 03 00 00       	call   ae0 <printf>
            printPerf(&perf3);
 71b:	89 1c 24             	mov    %ebx,(%esp)
 71e:	e8 bd fb ff ff       	call   2e0 <printPerf>
            exit(0);
 723:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 72a:	e8 49 02 00 00       	call   978 <exit>
            sleep(10);
 72f:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
 736:	e8 cd 02 00 00       	call   a08 <sleep>
            wait(&status5);
 73b:	89 34 24             	mov    %esi,(%esp)
 73e:	e8 3d 02 00 00       	call   980 <wait>
            exit(0);
 743:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 74a:	e8 29 02 00 00       	call   978 <exit>
 74f:	90                   	nop

00000750 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	8b 45 08             	mov    0x8(%ebp),%eax
 756:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 759:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 75a:	89 c2                	mov    %eax,%edx
 75c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 760:	41                   	inc    %ecx
 761:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 765:	42                   	inc    %edx
 766:	84 db                	test   %bl,%bl
 768:	88 5a ff             	mov    %bl,-0x1(%edx)
 76b:	75 f3                	jne    760 <strcpy+0x10>
    ;
  return os;
}
 76d:	5b                   	pop    %ebx
 76e:	5d                   	pop    %ebp
 76f:	c3                   	ret    

00000770 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 770:	55                   	push   %ebp
 771:	89 e5                	mov    %esp,%ebp
 773:	8b 4d 08             	mov    0x8(%ebp),%ecx
 776:	53                   	push   %ebx
 777:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 77a:	0f b6 01             	movzbl (%ecx),%eax
 77d:	0f b6 13             	movzbl (%ebx),%edx
 780:	84 c0                	test   %al,%al
 782:	75 18                	jne    79c <strcmp+0x2c>
 784:	eb 22                	jmp    7a8 <strcmp+0x38>
 786:	8d 76 00             	lea    0x0(%esi),%esi
 789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 790:	41                   	inc    %ecx
  while(*p && *p == *q)
 791:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 794:	43                   	inc    %ebx
 795:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
 798:	84 c0                	test   %al,%al
 79a:	74 0c                	je     7a8 <strcmp+0x38>
 79c:	38 d0                	cmp    %dl,%al
 79e:	74 f0                	je     790 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
 7a0:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 7a1:	29 d0                	sub    %edx,%eax
}
 7a3:	5d                   	pop    %ebp
 7a4:	c3                   	ret    
 7a5:	8d 76 00             	lea    0x0(%esi),%esi
 7a8:	5b                   	pop    %ebx
 7a9:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 7ab:	29 d0                	sub    %edx,%eax
}
 7ad:	5d                   	pop    %ebp
 7ae:	c3                   	ret    
 7af:	90                   	nop

000007b0 <strlen>:

uint
strlen(const char *s)
{
 7b0:	55                   	push   %ebp
 7b1:	89 e5                	mov    %esp,%ebp
 7b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 7b6:	80 39 00             	cmpb   $0x0,(%ecx)
 7b9:	74 15                	je     7d0 <strlen+0x20>
 7bb:	31 d2                	xor    %edx,%edx
 7bd:	8d 76 00             	lea    0x0(%esi),%esi
 7c0:	42                   	inc    %edx
 7c1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 7c5:	89 d0                	mov    %edx,%eax
 7c7:	75 f7                	jne    7c0 <strlen+0x10>
    ;
  return n;
}
 7c9:	5d                   	pop    %ebp
 7ca:	c3                   	ret    
 7cb:	90                   	nop
 7cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
 7d0:	31 c0                	xor    %eax,%eax
}
 7d2:	5d                   	pop    %ebp
 7d3:	c3                   	ret    
 7d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000007e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 7e0:	55                   	push   %ebp
 7e1:	89 e5                	mov    %esp,%ebp
 7e3:	8b 55 08             	mov    0x8(%ebp),%edx
 7e6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 7e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 7ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 7ed:	89 d7                	mov    %edx,%edi
 7ef:	fc                   	cld    
 7f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 7f2:	5f                   	pop    %edi
 7f3:	89 d0                	mov    %edx,%eax
 7f5:	5d                   	pop    %ebp
 7f6:	c3                   	ret    
 7f7:	89 f6                	mov    %esi,%esi
 7f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000800 <strchr>:

char*
strchr(const char *s, char c)
{
 800:	55                   	push   %ebp
 801:	89 e5                	mov    %esp,%ebp
 803:	8b 45 08             	mov    0x8(%ebp),%eax
 806:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 80a:	0f b6 10             	movzbl (%eax),%edx
 80d:	84 d2                	test   %dl,%dl
 80f:	74 1b                	je     82c <strchr+0x2c>
    if(*s == c)
 811:	38 d1                	cmp    %dl,%cl
 813:	75 0f                	jne    824 <strchr+0x24>
 815:	eb 17                	jmp    82e <strchr+0x2e>
 817:	89 f6                	mov    %esi,%esi
 819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 820:	38 ca                	cmp    %cl,%dl
 822:	74 0a                	je     82e <strchr+0x2e>
  for(; *s; s++)
 824:	40                   	inc    %eax
 825:	0f b6 10             	movzbl (%eax),%edx
 828:	84 d2                	test   %dl,%dl
 82a:	75 f4                	jne    820 <strchr+0x20>
      return (char*)s;
  return 0;
 82c:	31 c0                	xor    %eax,%eax
}
 82e:	5d                   	pop    %ebp
 82f:	c3                   	ret    

00000830 <gets>:

char*
gets(char *buf, int max)
{
 830:	55                   	push   %ebp
 831:	89 e5                	mov    %esp,%ebp
 833:	57                   	push   %edi
 834:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 835:	31 f6                	xor    %esi,%esi
{
 837:	53                   	push   %ebx
 838:	83 ec 3c             	sub    $0x3c,%esp
 83b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
 83e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 841:	eb 32                	jmp    875 <gets+0x45>
 843:	90                   	nop
 844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 848:	ba 01 00 00 00       	mov    $0x1,%edx
 84d:	89 54 24 08          	mov    %edx,0x8(%esp)
 851:	89 7c 24 04          	mov    %edi,0x4(%esp)
 855:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 85c:	e8 2f 01 00 00       	call   990 <read>
    if(cc < 1)
 861:	85 c0                	test   %eax,%eax
 863:	7e 19                	jle    87e <gets+0x4e>
      break;
    buf[i++] = c;
 865:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 869:	43                   	inc    %ebx
 86a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
 86d:	3c 0a                	cmp    $0xa,%al
 86f:	74 1f                	je     890 <gets+0x60>
 871:	3c 0d                	cmp    $0xd,%al
 873:	74 1b                	je     890 <gets+0x60>
  for(i=0; i+1 < max; ){
 875:	46                   	inc    %esi
 876:	3b 75 0c             	cmp    0xc(%ebp),%esi
 879:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 87c:	7c ca                	jl     848 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 87e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 881:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 884:	8b 45 08             	mov    0x8(%ebp),%eax
 887:	83 c4 3c             	add    $0x3c,%esp
 88a:	5b                   	pop    %ebx
 88b:	5e                   	pop    %esi
 88c:	5f                   	pop    %edi
 88d:	5d                   	pop    %ebp
 88e:	c3                   	ret    
 88f:	90                   	nop
 890:	8b 45 08             	mov    0x8(%ebp),%eax
 893:	01 c6                	add    %eax,%esi
 895:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 898:	eb e4                	jmp    87e <gets+0x4e>
 89a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000008a0 <stat>:

int
stat(const char *n, struct stat *st)
{
 8a0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 8a1:	31 c0                	xor    %eax,%eax
{
 8a3:	89 e5                	mov    %esp,%ebp
 8a5:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 8a8:	89 44 24 04          	mov    %eax,0x4(%esp)
 8ac:	8b 45 08             	mov    0x8(%ebp),%eax
{
 8af:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 8b2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 8b5:	89 04 24             	mov    %eax,(%esp)
 8b8:	e8 fb 00 00 00       	call   9b8 <open>
  if(fd < 0)
 8bd:	85 c0                	test   %eax,%eax
 8bf:	78 2f                	js     8f0 <stat+0x50>
 8c1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 8c3:	8b 45 0c             	mov    0xc(%ebp),%eax
 8c6:	89 1c 24             	mov    %ebx,(%esp)
 8c9:	89 44 24 04          	mov    %eax,0x4(%esp)
 8cd:	e8 fe 00 00 00       	call   9d0 <fstat>
  close(fd);
 8d2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 8d5:	89 c6                	mov    %eax,%esi
  close(fd);
 8d7:	e8 c4 00 00 00       	call   9a0 <close>
  return r;
}
 8dc:	89 f0                	mov    %esi,%eax
 8de:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 8e1:	8b 75 fc             	mov    -0x4(%ebp),%esi
 8e4:	89 ec                	mov    %ebp,%esp
 8e6:	5d                   	pop    %ebp
 8e7:	c3                   	ret    
 8e8:	90                   	nop
 8e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 8f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 8f5:	eb e5                	jmp    8dc <stat+0x3c>
 8f7:	89 f6                	mov    %esi,%esi
 8f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000900 <atoi>:

int
atoi(const char *s)
{
 900:	55                   	push   %ebp
 901:	89 e5                	mov    %esp,%ebp
 903:	8b 4d 08             	mov    0x8(%ebp),%ecx
 906:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 907:	0f be 11             	movsbl (%ecx),%edx
 90a:	88 d0                	mov    %dl,%al
 90c:	2c 30                	sub    $0x30,%al
 90e:	3c 09                	cmp    $0x9,%al
  n = 0;
 910:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 915:	77 1e                	ja     935 <atoi+0x35>
 917:	89 f6                	mov    %esi,%esi
 919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 920:	41                   	inc    %ecx
 921:	8d 04 80             	lea    (%eax,%eax,4),%eax
 924:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 928:	0f be 11             	movsbl (%ecx),%edx
 92b:	88 d3                	mov    %dl,%bl
 92d:	80 eb 30             	sub    $0x30,%bl
 930:	80 fb 09             	cmp    $0x9,%bl
 933:	76 eb                	jbe    920 <atoi+0x20>
  return n;
}
 935:	5b                   	pop    %ebx
 936:	5d                   	pop    %ebp
 937:	c3                   	ret    
 938:	90                   	nop
 939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000940 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 940:	55                   	push   %ebp
 941:	89 e5                	mov    %esp,%ebp
 943:	56                   	push   %esi
 944:	8b 45 08             	mov    0x8(%ebp),%eax
 947:	53                   	push   %ebx
 948:	8b 5d 10             	mov    0x10(%ebp),%ebx
 94b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 94e:	85 db                	test   %ebx,%ebx
 950:	7e 1a                	jle    96c <memmove+0x2c>
 952:	31 d2                	xor    %edx,%edx
 954:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 95a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 960:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 964:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 967:	42                   	inc    %edx
  while(n-- > 0)
 968:	39 d3                	cmp    %edx,%ebx
 96a:	75 f4                	jne    960 <memmove+0x20>
  return vdst;
}
 96c:	5b                   	pop    %ebx
 96d:	5e                   	pop    %esi
 96e:	5d                   	pop    %ebp
 96f:	c3                   	ret    

00000970 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 970:	b8 01 00 00 00       	mov    $0x1,%eax
 975:	cd 40                	int    $0x40
 977:	c3                   	ret    

00000978 <exit>:
SYSCALL(exit)
 978:	b8 02 00 00 00       	mov    $0x2,%eax
 97d:	cd 40                	int    $0x40
 97f:	c3                   	ret    

00000980 <wait>:
SYSCALL(wait)
 980:	b8 03 00 00 00       	mov    $0x3,%eax
 985:	cd 40                	int    $0x40
 987:	c3                   	ret    

00000988 <pipe>:
SYSCALL(pipe)
 988:	b8 04 00 00 00       	mov    $0x4,%eax
 98d:	cd 40                	int    $0x40
 98f:	c3                   	ret    

00000990 <read>:
SYSCALL(read)
 990:	b8 05 00 00 00       	mov    $0x5,%eax
 995:	cd 40                	int    $0x40
 997:	c3                   	ret    

00000998 <write>:
SYSCALL(write)
 998:	b8 10 00 00 00       	mov    $0x10,%eax
 99d:	cd 40                	int    $0x40
 99f:	c3                   	ret    

000009a0 <close>:
SYSCALL(close)
 9a0:	b8 15 00 00 00       	mov    $0x15,%eax
 9a5:	cd 40                	int    $0x40
 9a7:	c3                   	ret    

000009a8 <kill>:
SYSCALL(kill)
 9a8:	b8 06 00 00 00       	mov    $0x6,%eax
 9ad:	cd 40                	int    $0x40
 9af:	c3                   	ret    

000009b0 <exec>:
SYSCALL(exec)
 9b0:	b8 07 00 00 00       	mov    $0x7,%eax
 9b5:	cd 40                	int    $0x40
 9b7:	c3                   	ret    

000009b8 <open>:
SYSCALL(open)
 9b8:	b8 0f 00 00 00       	mov    $0xf,%eax
 9bd:	cd 40                	int    $0x40
 9bf:	c3                   	ret    

000009c0 <mknod>:
SYSCALL(mknod)
 9c0:	b8 11 00 00 00       	mov    $0x11,%eax
 9c5:	cd 40                	int    $0x40
 9c7:	c3                   	ret    

000009c8 <unlink>:
SYSCALL(unlink)
 9c8:	b8 12 00 00 00       	mov    $0x12,%eax
 9cd:	cd 40                	int    $0x40
 9cf:	c3                   	ret    

000009d0 <fstat>:
SYSCALL(fstat)
 9d0:	b8 08 00 00 00       	mov    $0x8,%eax
 9d5:	cd 40                	int    $0x40
 9d7:	c3                   	ret    

000009d8 <link>:
SYSCALL(link)
 9d8:	b8 13 00 00 00       	mov    $0x13,%eax
 9dd:	cd 40                	int    $0x40
 9df:	c3                   	ret    

000009e0 <mkdir>:
SYSCALL(mkdir)
 9e0:	b8 14 00 00 00       	mov    $0x14,%eax
 9e5:	cd 40                	int    $0x40
 9e7:	c3                   	ret    

000009e8 <chdir>:
SYSCALL(chdir)
 9e8:	b8 09 00 00 00       	mov    $0x9,%eax
 9ed:	cd 40                	int    $0x40
 9ef:	c3                   	ret    

000009f0 <dup>:
SYSCALL(dup)
 9f0:	b8 0a 00 00 00       	mov    $0xa,%eax
 9f5:	cd 40                	int    $0x40
 9f7:	c3                   	ret    

000009f8 <getpid>:
SYSCALL(getpid)
 9f8:	b8 0b 00 00 00       	mov    $0xb,%eax
 9fd:	cd 40                	int    $0x40
 9ff:	c3                   	ret    

00000a00 <sbrk>:
SYSCALL(sbrk)
 a00:	b8 0c 00 00 00       	mov    $0xc,%eax
 a05:	cd 40                	int    $0x40
 a07:	c3                   	ret    

00000a08 <sleep>:
SYSCALL(sleep)
 a08:	b8 0d 00 00 00       	mov    $0xd,%eax
 a0d:	cd 40                	int    $0x40
 a0f:	c3                   	ret    

00000a10 <uptime>:
SYSCALL(uptime)
 a10:	b8 0e 00 00 00       	mov    $0xe,%eax
 a15:	cd 40                	int    $0x40
 a17:	c3                   	ret    

00000a18 <detach>:
SYSCALL(detach)
 a18:	b8 16 00 00 00       	mov    $0x16,%eax
 a1d:	cd 40                	int    $0x40
 a1f:	c3                   	ret    

00000a20 <priority>:
SYSCALL(priority)
 a20:	b8 17 00 00 00       	mov    $0x17,%eax
 a25:	cd 40                	int    $0x40
 a27:	c3                   	ret    

00000a28 <policy>:
SYSCALL(policy)
 a28:	b8 18 00 00 00       	mov    $0x18,%eax
 a2d:	cd 40                	int    $0x40
 a2f:	c3                   	ret    

00000a30 <wait_stat>:
SYSCALL(wait_stat)
 a30:	b8 19 00 00 00       	mov    $0x19,%eax
 a35:	cd 40                	int    $0x40
 a37:	c3                   	ret    
 a38:	66 90                	xchg   %ax,%ax
 a3a:	66 90                	xchg   %ax,%ax
 a3c:	66 90                	xchg   %ax,%ax
 a3e:	66 90                	xchg   %ax,%ax

00000a40 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 a40:	55                   	push   %ebp
 a41:	89 e5                	mov    %esp,%ebp
 a43:	57                   	push   %edi
 a44:	56                   	push   %esi
 a45:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 a46:	89 d3                	mov    %edx,%ebx
 a48:	c1 eb 1f             	shr    $0x1f,%ebx
{
 a4b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 a4e:	84 db                	test   %bl,%bl
{
 a50:	89 45 c0             	mov    %eax,-0x40(%ebp)
 a53:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 a55:	74 79                	je     ad0 <printint+0x90>
 a57:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 a5b:	74 73                	je     ad0 <printint+0x90>
    neg = 1;
    x = -xx;
 a5d:	f7 d8                	neg    %eax
    neg = 1;
 a5f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 a66:	31 f6                	xor    %esi,%esi
 a68:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 a6b:	eb 05                	jmp    a72 <printint+0x32>
 a6d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 a70:	89 fe                	mov    %edi,%esi
 a72:	31 d2                	xor    %edx,%edx
 a74:	f7 f1                	div    %ecx
 a76:	8d 7e 01             	lea    0x1(%esi),%edi
 a79:	0f b6 92 9c 10 00 00 	movzbl 0x109c(%edx),%edx
  }while((x /= base) != 0);
 a80:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 a82:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 a85:	75 e9                	jne    a70 <printint+0x30>
  if(neg)
 a87:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 a8a:	85 d2                	test   %edx,%edx
 a8c:	74 08                	je     a96 <printint+0x56>
    buf[i++] = '-';
 a8e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 a93:	8d 7e 02             	lea    0x2(%esi),%edi
 a96:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 a9a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 a9d:	8d 76 00             	lea    0x0(%esi),%esi
 aa0:	0f b6 06             	movzbl (%esi),%eax
 aa3:	4e                   	dec    %esi
  write(fd, &c, 1);
 aa4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 aa8:	89 3c 24             	mov    %edi,(%esp)
 aab:	88 45 d7             	mov    %al,-0x29(%ebp)
 aae:	b8 01 00 00 00       	mov    $0x1,%eax
 ab3:	89 44 24 08          	mov    %eax,0x8(%esp)
 ab7:	e8 dc fe ff ff       	call   998 <write>

  while(--i >= 0)
 abc:	39 de                	cmp    %ebx,%esi
 abe:	75 e0                	jne    aa0 <printint+0x60>
    putc(fd, buf[i]);
}
 ac0:	83 c4 4c             	add    $0x4c,%esp
 ac3:	5b                   	pop    %ebx
 ac4:	5e                   	pop    %esi
 ac5:	5f                   	pop    %edi
 ac6:	5d                   	pop    %ebp
 ac7:	c3                   	ret    
 ac8:	90                   	nop
 ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 ad0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 ad7:	eb 8d                	jmp    a66 <printint+0x26>
 ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000ae0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 ae0:	55                   	push   %ebp
 ae1:	89 e5                	mov    %esp,%ebp
 ae3:	57                   	push   %edi
 ae4:	56                   	push   %esi
 ae5:	53                   	push   %ebx
 ae6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 ae9:	8b 75 0c             	mov    0xc(%ebp),%esi
 aec:	0f b6 1e             	movzbl (%esi),%ebx
 aef:	84 db                	test   %bl,%bl
 af1:	0f 84 d1 00 00 00    	je     bc8 <printf+0xe8>
  state = 0;
 af7:	31 ff                	xor    %edi,%edi
 af9:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 afa:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 afd:	89 fa                	mov    %edi,%edx
 aff:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 b02:	89 45 d0             	mov    %eax,-0x30(%ebp)
 b05:	eb 41                	jmp    b48 <printf+0x68>
 b07:	89 f6                	mov    %esi,%esi
 b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 b10:	83 f8 25             	cmp    $0x25,%eax
 b13:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 b16:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 b1b:	74 1e                	je     b3b <printf+0x5b>
  write(fd, &c, 1);
 b1d:	b8 01 00 00 00       	mov    $0x1,%eax
 b22:	89 44 24 08          	mov    %eax,0x8(%esp)
 b26:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 b29:	89 44 24 04          	mov    %eax,0x4(%esp)
 b2d:	89 3c 24             	mov    %edi,(%esp)
 b30:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 b33:	e8 60 fe ff ff       	call   998 <write>
 b38:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 b3b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 b3c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 b40:	84 db                	test   %bl,%bl
 b42:	0f 84 80 00 00 00    	je     bc8 <printf+0xe8>
    if(state == 0){
 b48:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 b4a:	0f be cb             	movsbl %bl,%ecx
 b4d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 b50:	74 be                	je     b10 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 b52:	83 fa 25             	cmp    $0x25,%edx
 b55:	75 e4                	jne    b3b <printf+0x5b>
      if(c == 'd'){
 b57:	83 f8 64             	cmp    $0x64,%eax
 b5a:	0f 84 f0 00 00 00    	je     c50 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 b60:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 b66:	83 f9 70             	cmp    $0x70,%ecx
 b69:	74 65                	je     bd0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 b6b:	83 f8 73             	cmp    $0x73,%eax
 b6e:	0f 84 8c 00 00 00    	je     c00 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 b74:	83 f8 63             	cmp    $0x63,%eax
 b77:	0f 84 13 01 00 00    	je     c90 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 b7d:	83 f8 25             	cmp    $0x25,%eax
 b80:	0f 84 e2 00 00 00    	je     c68 <printf+0x188>
  write(fd, &c, 1);
 b86:	b8 01 00 00 00       	mov    $0x1,%eax
 b8b:	46                   	inc    %esi
 b8c:	89 44 24 08          	mov    %eax,0x8(%esp)
 b90:	8d 45 e7             	lea    -0x19(%ebp),%eax
 b93:	89 44 24 04          	mov    %eax,0x4(%esp)
 b97:	89 3c 24             	mov    %edi,(%esp)
 b9a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 b9e:	e8 f5 fd ff ff       	call   998 <write>
 ba3:	ba 01 00 00 00       	mov    $0x1,%edx
 ba8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 bab:	89 54 24 08          	mov    %edx,0x8(%esp)
 baf:	89 44 24 04          	mov    %eax,0x4(%esp)
 bb3:	89 3c 24             	mov    %edi,(%esp)
 bb6:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 bb9:	e8 da fd ff ff       	call   998 <write>
  for(i = 0; fmt[i]; i++){
 bbe:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 bc2:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 bc4:	84 db                	test   %bl,%bl
 bc6:	75 80                	jne    b48 <printf+0x68>
    }
  }
}
 bc8:	83 c4 3c             	add    $0x3c,%esp
 bcb:	5b                   	pop    %ebx
 bcc:	5e                   	pop    %esi
 bcd:	5f                   	pop    %edi
 bce:	5d                   	pop    %ebp
 bcf:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 bd0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 bd7:	b9 10 00 00 00       	mov    $0x10,%ecx
 bdc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 bdf:	89 f8                	mov    %edi,%eax
 be1:	8b 13                	mov    (%ebx),%edx
 be3:	e8 58 fe ff ff       	call   a40 <printint>
        ap++;
 be8:	89 d8                	mov    %ebx,%eax
      state = 0;
 bea:	31 d2                	xor    %edx,%edx
        ap++;
 bec:	83 c0 04             	add    $0x4,%eax
 bef:	89 45 d0             	mov    %eax,-0x30(%ebp)
 bf2:	e9 44 ff ff ff       	jmp    b3b <printf+0x5b>
 bf7:	89 f6                	mov    %esi,%esi
 bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 c00:	8b 45 d0             	mov    -0x30(%ebp),%eax
 c03:	8b 10                	mov    (%eax),%edx
        ap++;
 c05:	83 c0 04             	add    $0x4,%eax
 c08:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 c0b:	85 d2                	test   %edx,%edx
 c0d:	0f 84 aa 00 00 00    	je     cbd <printf+0x1dd>
        while(*s != 0){
 c13:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 c16:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 c18:	84 c0                	test   %al,%al
 c1a:	74 27                	je     c43 <printf+0x163>
 c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 c20:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 c23:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 c28:	43                   	inc    %ebx
  write(fd, &c, 1);
 c29:	89 44 24 08          	mov    %eax,0x8(%esp)
 c2d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 c30:	89 44 24 04          	mov    %eax,0x4(%esp)
 c34:	89 3c 24             	mov    %edi,(%esp)
 c37:	e8 5c fd ff ff       	call   998 <write>
        while(*s != 0){
 c3c:	0f b6 03             	movzbl (%ebx),%eax
 c3f:	84 c0                	test   %al,%al
 c41:	75 dd                	jne    c20 <printf+0x140>
      state = 0;
 c43:	31 d2                	xor    %edx,%edx
 c45:	e9 f1 fe ff ff       	jmp    b3b <printf+0x5b>
 c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 c50:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 c57:	b9 0a 00 00 00       	mov    $0xa,%ecx
 c5c:	e9 7b ff ff ff       	jmp    bdc <printf+0xfc>
 c61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 c68:	b9 01 00 00 00       	mov    $0x1,%ecx
 c6d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 c70:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 c74:	89 44 24 04          	mov    %eax,0x4(%esp)
 c78:	89 3c 24             	mov    %edi,(%esp)
 c7b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 c7e:	e8 15 fd ff ff       	call   998 <write>
      state = 0;
 c83:	31 d2                	xor    %edx,%edx
 c85:	e9 b1 fe ff ff       	jmp    b3b <printf+0x5b>
 c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 c90:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 c93:	8b 03                	mov    (%ebx),%eax
        ap++;
 c95:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 c98:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 c9b:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 c9e:	b8 01 00 00 00       	mov    $0x1,%eax
 ca3:	89 44 24 08          	mov    %eax,0x8(%esp)
 ca7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 caa:	89 44 24 04          	mov    %eax,0x4(%esp)
 cae:	e8 e5 fc ff ff       	call   998 <write>
      state = 0;
 cb3:	31 d2                	xor    %edx,%edx
        ap++;
 cb5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 cb8:	e9 7e fe ff ff       	jmp    b3b <printf+0x5b>
          s = "(null)";
 cbd:	bb 95 10 00 00       	mov    $0x1095,%ebx
        while(*s != 0){
 cc2:	b0 28                	mov    $0x28,%al
 cc4:	e9 57 ff ff ff       	jmp    c20 <printf+0x140>
 cc9:	66 90                	xchg   %ax,%ax
 ccb:	66 90                	xchg   %ax,%ax
 ccd:	66 90                	xchg   %ax,%ax
 ccf:	90                   	nop

00000cd0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 cd0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 cd1:	a1 54 14 00 00       	mov    0x1454,%eax
{
 cd6:	89 e5                	mov    %esp,%ebp
 cd8:	57                   	push   %edi
 cd9:	56                   	push   %esi
 cda:	53                   	push   %ebx
 cdb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 cde:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 ce1:	eb 0d                	jmp    cf0 <free+0x20>
 ce3:	90                   	nop
 ce4:	90                   	nop
 ce5:	90                   	nop
 ce6:	90                   	nop
 ce7:	90                   	nop
 ce8:	90                   	nop
 ce9:	90                   	nop
 cea:	90                   	nop
 ceb:	90                   	nop
 cec:	90                   	nop
 ced:	90                   	nop
 cee:	90                   	nop
 cef:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 cf0:	39 c8                	cmp    %ecx,%eax
 cf2:	8b 10                	mov    (%eax),%edx
 cf4:	73 32                	jae    d28 <free+0x58>
 cf6:	39 d1                	cmp    %edx,%ecx
 cf8:	72 04                	jb     cfe <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 cfa:	39 d0                	cmp    %edx,%eax
 cfc:	72 32                	jb     d30 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 cfe:	8b 73 fc             	mov    -0x4(%ebx),%esi
 d01:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 d04:	39 fa                	cmp    %edi,%edx
 d06:	74 30                	je     d38 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 d08:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 d0b:	8b 50 04             	mov    0x4(%eax),%edx
 d0e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 d11:	39 f1                	cmp    %esi,%ecx
 d13:	74 3c                	je     d51 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 d15:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 d17:	5b                   	pop    %ebx
  freep = p;
 d18:	a3 54 14 00 00       	mov    %eax,0x1454
}
 d1d:	5e                   	pop    %esi
 d1e:	5f                   	pop    %edi
 d1f:	5d                   	pop    %ebp
 d20:	c3                   	ret    
 d21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d28:	39 d0                	cmp    %edx,%eax
 d2a:	72 04                	jb     d30 <free+0x60>
 d2c:	39 d1                	cmp    %edx,%ecx
 d2e:	72 ce                	jb     cfe <free+0x2e>
{
 d30:	89 d0                	mov    %edx,%eax
 d32:	eb bc                	jmp    cf0 <free+0x20>
 d34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 d38:	8b 7a 04             	mov    0x4(%edx),%edi
 d3b:	01 fe                	add    %edi,%esi
 d3d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 d40:	8b 10                	mov    (%eax),%edx
 d42:	8b 12                	mov    (%edx),%edx
 d44:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 d47:	8b 50 04             	mov    0x4(%eax),%edx
 d4a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 d4d:	39 f1                	cmp    %esi,%ecx
 d4f:	75 c4                	jne    d15 <free+0x45>
    p->s.size += bp->s.size;
 d51:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 d54:	a3 54 14 00 00       	mov    %eax,0x1454
    p->s.size += bp->s.size;
 d59:	01 ca                	add    %ecx,%edx
 d5b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 d5e:	8b 53 f8             	mov    -0x8(%ebx),%edx
 d61:	89 10                	mov    %edx,(%eax)
}
 d63:	5b                   	pop    %ebx
 d64:	5e                   	pop    %esi
 d65:	5f                   	pop    %edi
 d66:	5d                   	pop    %ebp
 d67:	c3                   	ret    
 d68:	90                   	nop
 d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d70 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 d70:	55                   	push   %ebp
 d71:	89 e5                	mov    %esp,%ebp
 d73:	57                   	push   %edi
 d74:	56                   	push   %esi
 d75:	53                   	push   %ebx
 d76:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d79:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 d7c:	8b 15 54 14 00 00    	mov    0x1454,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d82:	8d 78 07             	lea    0x7(%eax),%edi
 d85:	c1 ef 03             	shr    $0x3,%edi
 d88:	47                   	inc    %edi
  if((prevp = freep) == 0){
 d89:	85 d2                	test   %edx,%edx
 d8b:	0f 84 8f 00 00 00    	je     e20 <malloc+0xb0>
 d91:	8b 02                	mov    (%edx),%eax
 d93:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 d96:	39 cf                	cmp    %ecx,%edi
 d98:	76 66                	jbe    e00 <malloc+0x90>
 d9a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 da0:	bb 00 10 00 00       	mov    $0x1000,%ebx
 da5:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 da8:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 daf:	eb 10                	jmp    dc1 <malloc+0x51>
 db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 db8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 dba:	8b 48 04             	mov    0x4(%eax),%ecx
 dbd:	39 f9                	cmp    %edi,%ecx
 dbf:	73 3f                	jae    e00 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 dc1:	39 05 54 14 00 00    	cmp    %eax,0x1454
 dc7:	89 c2                	mov    %eax,%edx
 dc9:	75 ed                	jne    db8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 dcb:	89 34 24             	mov    %esi,(%esp)
 dce:	e8 2d fc ff ff       	call   a00 <sbrk>
  if(p == (char*)-1)
 dd3:	83 f8 ff             	cmp    $0xffffffff,%eax
 dd6:	74 18                	je     df0 <malloc+0x80>
  hp->s.size = nu;
 dd8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 ddb:	83 c0 08             	add    $0x8,%eax
 dde:	89 04 24             	mov    %eax,(%esp)
 de1:	e8 ea fe ff ff       	call   cd0 <free>
  return freep;
 de6:	8b 15 54 14 00 00    	mov    0x1454,%edx
      if((p = morecore(nunits)) == 0)
 dec:	85 d2                	test   %edx,%edx
 dee:	75 c8                	jne    db8 <malloc+0x48>
        return 0;
  }
}
 df0:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 df3:	31 c0                	xor    %eax,%eax
}
 df5:	5b                   	pop    %ebx
 df6:	5e                   	pop    %esi
 df7:	5f                   	pop    %edi
 df8:	5d                   	pop    %ebp
 df9:	c3                   	ret    
 dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 e00:	39 cf                	cmp    %ecx,%edi
 e02:	74 4c                	je     e50 <malloc+0xe0>
        p->s.size -= nunits;
 e04:	29 f9                	sub    %edi,%ecx
 e06:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 e09:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 e0c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 e0f:	89 15 54 14 00 00    	mov    %edx,0x1454
}
 e15:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 e18:	83 c0 08             	add    $0x8,%eax
}
 e1b:	5b                   	pop    %ebx
 e1c:	5e                   	pop    %esi
 e1d:	5f                   	pop    %edi
 e1e:	5d                   	pop    %ebp
 e1f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 e20:	b8 58 14 00 00       	mov    $0x1458,%eax
 e25:	ba 58 14 00 00       	mov    $0x1458,%edx
    base.s.size = 0;
 e2a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 e2c:	a3 54 14 00 00       	mov    %eax,0x1454
    base.s.size = 0;
 e31:	b8 58 14 00 00       	mov    $0x1458,%eax
    base.s.ptr = freep = prevp = &base;
 e36:	89 15 58 14 00 00    	mov    %edx,0x1458
    base.s.size = 0;
 e3c:	89 0d 5c 14 00 00    	mov    %ecx,0x145c
 e42:	e9 53 ff ff ff       	jmp    d9a <malloc+0x2a>
 e47:	89 f6                	mov    %esi,%esi
 e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 e50:	8b 08                	mov    (%eax),%ecx
 e52:	89 0a                	mov    %ecx,(%edx)
 e54:	eb b9                	jmp    e0f <malloc+0x9f>
