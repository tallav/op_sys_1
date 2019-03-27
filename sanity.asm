
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
  10:	b8 85 11 00 00       	mov    $0x1185,%eax
  15:	89 44 24 04          	mov    %eax,0x4(%esp)
  19:	89 1c 24             	mov    %ebx,(%esp)
  1c:	e8 7f 08 00 00       	call   8a0 <strcmp>
  21:	85 c0                	test   %eax,%eax
  23:	75 11                	jne    36 <main+0x36>
		testExitWait();
  25:	e8 a6 01 00 00       	call   1d0 <testExitWait>
            testPolicy(3);
            testPerf(1);
            testPerf(2);
            testPerf(3);
        }
       exit(0);
  2a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  31:	e8 72 0a 00 00       	call   aa8 <exit>
	else if(strcmp(arg, "detach") == 0)
  36:	c7 44 24 04 8a 11 00 	movl   $0x118a,0x4(%esp)
  3d:	00 
  3e:	89 1c 24             	mov    %ebx,(%esp)
  41:	e8 5a 08 00 00       	call   8a0 <strcmp>
  46:	85 c0                	test   %eax,%eax
  48:	75 08                	jne    52 <main+0x52>
		testDetach();
  4a:	e8 21 02 00 00       	call   270 <testDetach>
  4f:	90                   	nop
  50:	eb d8                	jmp    2a <main+0x2a>
	else if(strcmp(arg, "wait_stat") == 0)
  52:	c7 44 24 04 91 11 00 	movl   $0x1191,0x4(%esp)
  59:	00 
  5a:	89 1c 24             	mov    %ebx,(%esp)
  5d:	e8 3e 08 00 00       	call   8a0 <strcmp>
  62:	85 c0                	test   %eax,%eax
  64:	74 22                	je     88 <main+0x88>
	else if(strcmp(arg, "policy1") == 0)
  66:	c7 44 24 04 9b 11 00 	movl   $0x119b,0x4(%esp)
  6d:	00 
  6e:	89 1c 24             	mov    %ebx,(%esp)
  71:	e8 2a 08 00 00       	call   8a0 <strcmp>
  76:	85 c0                	test   %eax,%eax
  78:	75 18                	jne    92 <main+0x92>
		testPolicy(1);
  7a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  81:	e8 2a 04 00 00       	call   4b0 <testPolicy>
  86:	eb a2                	jmp    2a <main+0x2a>
		testWaitStat();
  88:	e8 73 03 00 00       	call   400 <testWaitStat>
  8d:	8d 76 00             	lea    0x0(%esi),%esi
  90:	eb 98                	jmp    2a <main+0x2a>
	else if(strcmp(arg, "policy2") == 0)
  92:	c7 44 24 04 a3 11 00 	movl   $0x11a3,0x4(%esp)
  99:	00 
  9a:	89 1c 24             	mov    %ebx,(%esp)
  9d:	e8 fe 07 00 00       	call   8a0 <strcmp>
  a2:	85 c0                	test   %eax,%eax
  a4:	74 25                	je     cb <main+0xcb>
	else if(strcmp(arg, "policy3") == 0)
  a6:	c7 44 24 04 ab 11 00 	movl   $0x11ab,0x4(%esp)
  ad:	00 
  ae:	89 1c 24             	mov    %ebx,(%esp)
  b1:	e8 ea 07 00 00       	call   8a0 <strcmp>
  b6:	85 c0                	test   %eax,%eax
  b8:	75 22                	jne    dc <main+0xdc>
		testPolicy(3);
  ba:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
  c1:	e8 ea 03 00 00       	call   4b0 <testPolicy>
  c6:	e9 5f ff ff ff       	jmp    2a <main+0x2a>
		testPolicy(2);
  cb:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  d2:	e8 d9 03 00 00       	call   4b0 <testPolicy>
  d7:	e9 4e ff ff ff       	jmp    2a <main+0x2a>
        else if(strcmp(arg, "perf1") == 0)
  dc:	c7 44 24 04 b3 11 00 	movl   $0x11b3,0x4(%esp)
  e3:	00 
  e4:	89 1c 24             	mov    %ebx,(%esp)
  e7:	e8 b4 07 00 00       	call   8a0 <strcmp>
  ec:	85 c0                	test   %eax,%eax
  ee:	75 11                	jne    101 <main+0x101>
		testPerf(1);
  f0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  f7:	e8 a4 05 00 00       	call   6a0 <testPerf>
  fc:	e9 29 ff ff ff       	jmp    2a <main+0x2a>
	else if(strcmp(arg, "perf2") == 0)
 101:	c7 44 24 04 b9 11 00 	movl   $0x11b9,0x4(%esp)
 108:	00 
 109:	89 1c 24             	mov    %ebx,(%esp)
 10c:	e8 8f 07 00 00       	call   8a0 <strcmp>
 111:	85 c0                	test   %eax,%eax
 113:	0f 84 9e 00 00 00    	je     1b7 <main+0x1b7>
	else if(strcmp(arg, "perf3") == 0)
 119:	c7 44 24 04 bf 11 00 	movl   $0x11bf,0x4(%esp)
 120:	00 
 121:	89 1c 24             	mov    %ebx,(%esp)
 124:	e8 77 07 00 00       	call   8a0 <strcmp>
 129:	85 c0                	test   %eax,%eax
 12b:	74 79                	je     1a6 <main+0x1a6>
        else if(strcmp(arg, "priority2") == 0)
 12d:	c7 44 24 04 c5 11 00 	movl   $0x11c5,0x4(%esp)
 134:	00 
 135:	89 1c 24             	mov    %ebx,(%esp)
 138:	e8 63 07 00 00       	call   8a0 <strcmp>
 13d:	85 c0                	test   %eax,%eax
 13f:	74 76                	je     1b7 <main+0x1b7>
        else if(strcmp(arg, "priority3") == 0)
 141:	c7 44 24 04 cf 11 00 	movl   $0x11cf,0x4(%esp)
 148:	00 
 149:	89 1c 24             	mov    %ebx,(%esp)
 14c:	e8 4f 07 00 00       	call   8a0 <strcmp>
 151:	85 c0                	test   %eax,%eax
 153:	74 51                	je     1a6 <main+0x1a6>
            testExitWait();
 155:	e8 76 00 00 00       	call   1d0 <testExitWait>
 15a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            testDetach();
 160:	e8 0b 01 00 00       	call   270 <testDetach>
            testWaitStat();
 165:	e8 96 02 00 00       	call   400 <testWaitStat>
            testPolicy(1);
 16a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 171:	e8 3a 03 00 00       	call   4b0 <testPolicy>
            testPolicy(2);
 176:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 17d:	e8 2e 03 00 00       	call   4b0 <testPolicy>
            testPolicy(3);
 182:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
 189:	e8 22 03 00 00       	call   4b0 <testPolicy>
            testPerf(1);
 18e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 195:	e8 06 05 00 00       	call   6a0 <testPerf>
            testPerf(2);
 19a:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 1a1:	e8 fa 04 00 00       	call   6a0 <testPerf>
            testPerf(3);
 1a6:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
 1ad:	e8 ee 04 00 00       	call   6a0 <testPerf>
 1b2:	e9 73 fe ff ff       	jmp    2a <main+0x2a>
		testPerf(2);
 1b7:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 1be:	e8 dd 04 00 00       	call   6a0 <testPerf>
 1c3:	e9 62 fe ff ff       	jmp    2a <main+0x2a>
 1c8:	66 90                	xchg   %ax,%ax
 1ca:	66 90                	xchg   %ax,%ax
 1cc:	66 90                	xchg   %ax,%ax
 1ce:	66 90                	xchg   %ax,%ax

000001d0 <testExitWait>:
void testExitWait(){
 1d0:	55                   	push   %ebp
    printf(1, "----------test exit wait started\n");
 1d1:	b9 88 0f 00 00       	mov    $0xf88,%ecx
void testExitWait(){
 1d6:	89 e5                	mov    %esp,%ebp
 1d8:	57                   	push   %edi
 1d9:	56                   	push   %esi
    for (int i = 0; i < 5; i++) {
 1da:	31 f6                	xor    %esi,%esi
void testExitWait(){
 1dc:	53                   	push   %ebx
 1dd:	83 ec 2c             	sub    $0x2c,%esp
    printf(1, "----------test exit wait started\n");
 1e0:	89 4c 24 04          	mov    %ecx,0x4(%esp)
            wait(&status);
 1e4:	8d 7d e4             	lea    -0x1c(%ebp),%edi
    printf(1, "----------test exit wait started\n");
 1e7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1ee:	e8 1d 0a 00 00       	call   c10 <printf>
        pid = fork();
 1f3:	e8 a8 08 00 00       	call   aa0 <fork>
        if (pid > 0) {
 1f8:	85 c0                	test   %eax,%eax
        pid = fork();
 1fa:	89 c3                	mov    %eax,%ebx
        if (pid > 0) {
 1fc:	7e 53                	jle    251 <testExitWait+0x81>
            wait(&status);
 1fe:	89 3c 24             	mov    %edi,(%esp)
    for (int i = 0; i < 5; i++) {
 201:	46                   	inc    %esi
            wait(&status);
 202:	e8 a9 08 00 00       	call   ab0 <wait>
			kill(pid);
 207:	89 1c 24             	mov    %ebx,(%esp)
 20a:	e8 c9 08 00 00       	call   ad8 <kill>
            printf(1, "process with pid %d exited with status %d\n", pid, status);
 20f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 212:	ba ac 0f 00 00       	mov    $0xfac,%edx
 217:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 21b:	89 54 24 04          	mov    %edx,0x4(%esp)
 21f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 226:	89 44 24 0c          	mov    %eax,0xc(%esp)
 22a:	e8 e1 09 00 00       	call   c10 <printf>
    for (int i = 0; i < 5; i++) {
 22f:	83 fe 05             	cmp    $0x5,%esi
 232:	75 bf                	jne    1f3 <testExitWait+0x23>
    printf(1, "----------test exit wait ended\n");
 234:	b8 d8 0f 00 00       	mov    $0xfd8,%eax
 239:	89 44 24 04          	mov    %eax,0x4(%esp)
 23d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 244:	e8 c7 09 00 00       	call   c10 <printf>
}
 249:	83 c4 2c             	add    $0x2c,%esp
 24c:	5b                   	pop    %ebx
 24d:	5e                   	pop    %esi
 24e:	5f                   	pop    %edi
 24f:	5d                   	pop    %ebp
 250:	c3                   	ret    
            sleep(5);
 251:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 258:	e8 db 08 00 00       	call   b38 <sleep>
            exit(i);
 25d:	89 34 24             	mov    %esi,(%esp)
 260:	e8 43 08 00 00       	call   aa8 <exit>
 265:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000270 <testDetach>:
void testDetach(){
 270:	55                   	push   %ebp
    printf(1, "----------test detach started\n");
 271:	b8 f8 0f 00 00       	mov    $0xff8,%eax
void testDetach(){
 276:	89 e5                	mov    %esp,%ebp
 278:	53                   	push   %ebx
 279:	83 ec 14             	sub    $0x14,%esp
    printf(1, "----------test detach started\n");
 27c:	89 44 24 04          	mov    %eax,0x4(%esp)
 280:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 287:	e8 84 09 00 00       	call   c10 <printf>
    pid = fork(); 
 28c:	e8 0f 08 00 00       	call   aa0 <fork>
    if(pid > 0) {
 291:	85 c0                	test   %eax,%eax
    pid = fork(); 
 293:	89 c3                	mov    %eax,%ebx
    if(pid > 0) {
 295:	7e 67                	jle    2fe <testDetach+0x8e>
        first_status = detach(pid); // status = 0
 297:	89 04 24             	mov    %eax,(%esp)
 29a:	e8 a9 08 00 00       	call   b48 <detach>
        printf(1, "first_status: %d\n", first_status);
 29f:	ba a8 10 00 00       	mov    $0x10a8,%edx
 2a4:	89 54 24 04          	mov    %edx,0x4(%esp)
 2a8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2af:	89 44 24 08          	mov    %eax,0x8(%esp)
 2b3:	e8 58 09 00 00       	call   c10 <printf>
        second_status = detach(pid); // status = -1, because this process has already detached this child, and it doesn’t have this child anymore.
 2b8:	89 1c 24             	mov    %ebx,(%esp)
 2bb:	e8 88 08 00 00       	call   b48 <detach>
        printf(1, "second_status: %d\n", second_status);
 2c0:	b9 ba 10 00 00       	mov    $0x10ba,%ecx
 2c5:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 2c9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2d0:	89 44 24 08          	mov    %eax,0x8(%esp)
 2d4:	e8 37 09 00 00       	call   c10 <printf>
        third_status = detach(77); // status = -1, because this process doesn’t have a child with this pid.
 2d9:	c7 04 24 4d 00 00 00 	movl   $0x4d,(%esp)
 2e0:	e8 63 08 00 00       	call   b48 <detach>
        printf(1, "third_status: %d\n", third_status);
 2e5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2ec:	89 44 24 08          	mov    %eax,0x8(%esp)
 2f0:	b8 cd 10 00 00       	mov    $0x10cd,%eax
 2f5:	89 44 24 04          	mov    %eax,0x4(%esp)
 2f9:	e8 12 09 00 00       	call   c10 <printf>
	kill(pid);
 2fe:	89 1c 24             	mov    %ebx,(%esp)
 301:	e8 d2 07 00 00       	call   ad8 <kill>
    printf(1, "----------test detach ended\n");
 306:	b8 df 10 00 00       	mov    $0x10df,%eax
 30b:	89 44 24 04          	mov    %eax,0x4(%esp)
 30f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 316:	e8 f5 08 00 00       	call   c10 <printf>
}
 31b:	83 c4 14             	add    $0x14,%esp
 31e:	5b                   	pop    %ebx
 31f:	5d                   	pop    %ebp
 320:	c3                   	ret    
 321:	eb 0d                	jmp    330 <printPerf>
 323:	90                   	nop
 324:	90                   	nop
 325:	90                   	nop
 326:	90                   	nop
 327:	90                   	nop
 328:	90                   	nop
 329:	90                   	nop
 32a:	90                   	nop
 32b:	90                   	nop
 32c:	90                   	nop
 32d:	90                   	nop
 32e:	90                   	nop
 32f:	90                   	nop

00000330 <printPerf>:
void printPerf(struct perf *performance) {
 330:	55                   	push   %ebp
    printf(1, "pref:\n");
 331:	b8 fc 10 00 00       	mov    $0x10fc,%eax
void printPerf(struct perf *performance) {
 336:	89 e5                	mov    %esp,%ebp
 338:	53                   	push   %ebx
 339:	83 ec 14             	sub    $0x14,%esp
 33c:	8b 5d 08             	mov    0x8(%ebp),%ebx
    printf(1, "pref:\n");
 33f:	89 44 24 04          	mov    %eax,0x4(%esp)
 343:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 34a:	e8 c1 08 00 00       	call   c10 <printf>
    printf(1, "\tctime: %d\n", performance->ctime);
 34f:	ba 03 11 00 00       	mov    $0x1103,%edx
 354:	8b 03                	mov    (%ebx),%eax
 356:	89 54 24 04          	mov    %edx,0x4(%esp)
 35a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 361:	89 44 24 08          	mov    %eax,0x8(%esp)
 365:	e8 a6 08 00 00       	call   c10 <printf>
    printf(1, "\tttime: %d\n", performance->ttime);
 36a:	8b 43 04             	mov    0x4(%ebx),%eax
 36d:	b9 0f 11 00 00       	mov    $0x110f,%ecx
 372:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 376:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 37d:	89 44 24 08          	mov    %eax,0x8(%esp)
 381:	e8 8a 08 00 00       	call   c10 <printf>
    printf(1, "\tstime: %d\n", performance->stime);
 386:	8b 43 08             	mov    0x8(%ebx),%eax
 389:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 390:	89 44 24 08          	mov    %eax,0x8(%esp)
 394:	b8 1b 11 00 00       	mov    $0x111b,%eax
 399:	89 44 24 04          	mov    %eax,0x4(%esp)
 39d:	e8 6e 08 00 00       	call   c10 <printf>
    printf(1, "\tretime: %d\n", performance->retime);
 3a2:	8b 43 0c             	mov    0xc(%ebx),%eax
 3a5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 3ac:	89 44 24 08          	mov    %eax,0x8(%esp)
 3b0:	b8 27 11 00 00       	mov    $0x1127,%eax
 3b5:	89 44 24 04          	mov    %eax,0x4(%esp)
 3b9:	e8 52 08 00 00       	call   c10 <printf>
    printf(1, "\trutime: %d\n", performance->rutime);
 3be:	8b 43 10             	mov    0x10(%ebx),%eax
 3c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 3c8:	89 44 24 08          	mov    %eax,0x8(%esp)
 3cc:	b8 34 11 00 00       	mov    $0x1134,%eax
 3d1:	89 44 24 04          	mov    %eax,0x4(%esp)
 3d5:	e8 36 08 00 00       	call   c10 <printf>
    printf(1, "\n\tTurnaround time: %d\n", (performance->ttime - performance->ctime));
 3da:	8b 43 04             	mov    0x4(%ebx),%eax
 3dd:	b9 41 11 00 00       	mov    $0x1141,%ecx
 3e2:	8b 13                	mov    (%ebx),%edx
 3e4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 3e8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 3ef:	29 d0                	sub    %edx,%eax
 3f1:	89 44 24 08          	mov    %eax,0x8(%esp)
 3f5:	e8 16 08 00 00       	call   c10 <printf>
}
 3fa:	83 c4 14             	add    $0x14,%esp
 3fd:	5b                   	pop    %ebx
 3fe:	5d                   	pop    %ebp
 3ff:	c3                   	ret    

00000400 <testWaitStat>:
void testWaitStat(){
 400:	55                   	push   %ebp
    printf(1, "----------test wait_stat started\n");
 401:	b9 18 10 00 00       	mov    $0x1018,%ecx
void testWaitStat(){
 406:	89 e5                	mov    %esp,%ebp
 408:	57                   	push   %edi
 409:	56                   	push   %esi
 40a:	53                   	push   %ebx
    for (int i = 0; i < 5; i++) {
 40b:	31 db                	xor    %ebx,%ebx
void testWaitStat(){
 40d:	83 ec 3c             	sub    $0x3c,%esp
    printf(1, "----------test wait_stat started\n");
 410:	89 4c 24 04          	mov    %ecx,0x4(%esp)
            wait_stat(&status, &perf);
 414:	8d 75 d4             	lea    -0x2c(%ebp),%esi
    printf(1, "----------test wait_stat started\n");
 417:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 41e:	e8 ed 07 00 00       	call   c10 <printf>
        pid = fork();
 423:	e8 78 06 00 00       	call   aa0 <fork>
        if (pid > 0) {
 428:	85 c0                	test   %eax,%eax
        pid = fork();
 42a:	89 c7                	mov    %eax,%edi
        if (pid > 0) {
 42c:	7e 62                	jle    490 <testWaitStat+0x90>
            wait_stat(&status, &perf);
 42e:	8d 45 d0             	lea    -0x30(%ebp),%eax
    for (int i = 0; i < 5; i++) {
 431:	43                   	inc    %ebx
            wait_stat(&status, &perf);
 432:	89 74 24 04          	mov    %esi,0x4(%esp)
 436:	89 04 24             	mov    %eax,(%esp)
 439:	e8 22 07 00 00       	call   b60 <wait_stat>
            printf(1, "process with pid %d exited with status %d\n", pid, status);
 43e:	8b 45 d0             	mov    -0x30(%ebp),%eax
 441:	ba ac 0f 00 00       	mov    $0xfac,%edx
 446:	89 54 24 04          	mov    %edx,0x4(%esp)
 44a:	89 7c 24 08          	mov    %edi,0x8(%esp)
 44e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 455:	89 44 24 0c          	mov    %eax,0xc(%esp)
 459:	e8 b2 07 00 00       	call   c10 <printf>
			kill(pid);
 45e:	89 3c 24             	mov    %edi,(%esp)
 461:	e8 72 06 00 00       	call   ad8 <kill>
            printPerf(&perf);
 466:	89 34 24             	mov    %esi,(%esp)
 469:	e8 c2 fe ff ff       	call   330 <printPerf>
    for (int i = 0; i < 5; i++) {
 46e:	83 fb 05             	cmp    $0x5,%ebx
 471:	75 b0                	jne    423 <testWaitStat+0x23>
    printf(1, "----------test wait_stat ended\n");
 473:	b8 3c 10 00 00       	mov    $0x103c,%eax
 478:	89 44 24 04          	mov    %eax,0x4(%esp)
 47c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 483:	e8 88 07 00 00       	call   c10 <printf>
}
 488:	83 c4 3c             	add    $0x3c,%esp
 48b:	5b                   	pop    %ebx
 48c:	5e                   	pop    %esi
 48d:	5f                   	pop    %edi
 48e:	5d                   	pop    %ebp
 48f:	c3                   	ret    
            sleep(5);
 490:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 497:	e8 9c 06 00 00       	call   b38 <sleep>
            exit(i);
 49c:	89 1c 24             	mov    %ebx,(%esp)
 49f:	e8 04 06 00 00       	call   aa8 <exit>
 4a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000004b0 <testPolicy>:
void testPolicy(int policyNum) {
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	57                   	push   %edi
 4b4:	56                   	push   %esi
 4b5:	53                   	push   %ebx
 4b6:	83 ec 3c             	sub    $0x3c,%esp
    printf(1, "----------test policy %d started\n", policyNum);
 4b9:	8b 45 08             	mov    0x8(%ebp),%eax
 4bc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 4c3:	89 44 24 08          	mov    %eax,0x8(%esp)
 4c7:	b8 5c 10 00 00       	mov    $0x105c,%eax
 4cc:	89 44 24 04          	mov    %eax,0x4(%esp)
 4d0:	e8 3b 07 00 00       	call   c10 <printf>
    policy(policyNum);
 4d5:	8b 45 08             	mov    0x8(%ebp),%eax
 4d8:	89 04 24             	mov    %eax,(%esp)
 4db:	e8 78 06 00 00       	call   b58 <policy>
    pid1 = fork();
 4e0:	e8 bb 05 00 00       	call   aa0 <fork>
    if (pid1 > 0) {
 4e5:	85 c0                	test   %eax,%eax
 4e7:	7f 4a                	jg     533 <testPolicy+0x83>
 4e9:	31 db                	xor    %ebx,%ebx
                wait_stat(&status, &perf1);
 4eb:	8d 7d d4             	lea    -0x2c(%ebp),%edi
 4ee:	8d 75 d0             	lea    -0x30(%ebp),%esi
 4f1:	eb 0d                	jmp    500 <testPolicy+0x50>
 4f3:	90                   	nop
 4f4:	90                   	nop
 4f5:	90                   	nop
 4f6:	90                   	nop
 4f7:	90                   	nop
 4f8:	90                   	nop
 4f9:	90                   	nop
 4fa:	90                   	nop
 4fb:	90                   	nop
 4fc:	90                   	nop
 4fd:	90                   	nop
 4fe:	90                   	nop
 4ff:	90                   	nop
            pid = fork();
 500:	e8 9b 05 00 00       	call   aa0 <fork>
            if (pid > 0) {
 505:	85 c0                	test   %eax,%eax
 507:	7e 4c                	jle    555 <testPolicy+0xa5>
                sleep(5);
 509:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
        for (int a = 0; a < 100; ++a) {
 510:	43                   	inc    %ebx
                sleep(5);
 511:	e8 22 06 00 00       	call   b38 <sleep>
                wait_stat(&status, &perf1);
 516:	89 7c 24 04          	mov    %edi,0x4(%esp)
 51a:	89 34 24             	mov    %esi,(%esp)
 51d:	e8 3e 06 00 00       	call   b60 <wait_stat>
        for (int a = 0; a < 100; ++a) {
 522:	83 fb 64             	cmp    $0x64,%ebx
 525:	75 d9                	jne    500 <testPolicy+0x50>
        exit(0);
 527:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 52e:	e8 75 05 00 00       	call   aa8 <exit>
        wait_stat(&status1, &perf2);
 533:	8d 5d d4             	lea    -0x2c(%ebp),%ebx
 536:	8d 45 d0             	lea    -0x30(%ebp),%eax
 539:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 53d:	89 04 24             	mov    %eax,(%esp)
 540:	e8 1b 06 00 00       	call   b60 <wait_stat>
        printPerf(&perf2);
 545:	89 1c 24             	mov    %ebx,(%esp)
 548:	e8 e3 fd ff ff       	call   330 <printPerf>
}
 54d:	83 c4 3c             	add    $0x3c,%esp
 550:	5b                   	pop    %ebx
 551:	5e                   	pop    %esi
 552:	5f                   	pop    %edi
 553:	5d                   	pop    %ebp
 554:	c3                   	ret    
                int pr = a % 10;
 555:	89 d8                	mov    %ebx,%eax
 557:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
 55c:	f7 e2                	mul    %edx
 55e:	89 d0                	mov    %edx,%eax
 560:	c1 e8 03             	shr    $0x3,%eax
 563:	8d 04 80             	lea    (%eax,%eax,4),%eax
 566:	01 c0                	add    %eax,%eax
                if(pr == 0 && policyNum == 2)
 568:	29 c3                	sub    %eax,%ebx
 56a:	89 d8                	mov    %ebx,%eax
 56c:	75 0c                	jne    57a <testPolicy+0xca>
                    pr = 1;
 56e:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
 572:	ba 01 00 00 00       	mov    $0x1,%edx
 577:	0f 44 c2             	cmove  %edx,%eax
                priority(pr);
 57a:	89 04 24             	mov    %eax,(%esp)
 57d:	e8 ce 05 00 00       	call   b50 <priority>
                sleep(5);
 582:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 589:	e8 aa 05 00 00       	call   b38 <sleep>
                exit(0);
 58e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 595:	e8 0e 05 00 00       	call   aa8 <exit>
 59a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000005a0 <testPriority>:
void testPriority(int policyNum) {
 5a0:	55                   	push   %ebp
    printf(1, "----------test policy %d started\n", policyNum);
 5a1:	b8 5c 10 00 00       	mov    $0x105c,%eax
void testPriority(int policyNum) {
 5a6:	89 e5                	mov    %esp,%ebp
 5a8:	57                   	push   %edi
 5a9:	56                   	push   %esi
 5aa:	53                   	push   %ebx
 5ab:	83 ec 3c             	sub    $0x3c,%esp
 5ae:	8b 75 08             	mov    0x8(%ebp),%esi
    printf(1, "----------test policy %d started\n", policyNum);
 5b1:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5bc:	89 74 24 08          	mov    %esi,0x8(%esp)
 5c0:	e8 4b 06 00 00       	call   c10 <printf>
    policy(policyNum);
 5c5:	89 34 24             	mov    %esi,(%esp)
 5c8:	e8 8b 05 00 00       	call   b58 <policy>
    pid1 = fork();
 5cd:	e8 ce 04 00 00       	call   aa0 <fork>
    if (pid1 > 0) {
 5d2:	85 c0                	test   %eax,%eax
 5d4:	7f 58                	jg     62e <testPriority+0x8e>
 5d6:	bb 64 00 00 00       	mov    $0x64,%ebx
                wait_stat(&status, &perf1);
 5db:	8d 7d d4             	lea    -0x2c(%ebp),%edi
 5de:	eb 23                	jmp    603 <testPriority+0x63>
                if(policyNum == 3)
 5e0:	83 fe 03             	cmp    $0x3,%esi
 5e3:	74 3b                	je     620 <testPriority+0x80>
                sleep(5);
 5e5:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 5ec:	e8 47 05 00 00       	call   b38 <sleep>
                wait_stat(&status, &perf1);
 5f1:	8d 45 d0             	lea    -0x30(%ebp),%eax
 5f4:	89 7c 24 04          	mov    %edi,0x4(%esp)
 5f8:	89 04 24             	mov    %eax,(%esp)
 5fb:	e8 60 05 00 00       	call   b60 <wait_stat>
        for (int a = 0; a < 100; ++a) {
 600:	4b                   	dec    %ebx
 601:	74 45                	je     648 <testPriority+0xa8>
            pid = fork();
 603:	e8 98 04 00 00       	call   aa0 <fork>
            if (pid > 0) {
 608:	85 c0                	test   %eax,%eax
 60a:	7e 44                	jle    650 <testPriority+0xb0>
                if(policyNum == 2)
 60c:	83 fe 02             	cmp    $0x2,%esi
 60f:	90                   	nop
 610:	75 ce                	jne    5e0 <testPriority+0x40>
                    priority(1);
 612:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 619:	e8 32 05 00 00       	call   b50 <priority>
 61e:	eb c5                	jmp    5e5 <testPriority+0x45>
                    priority(0);
 620:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 627:	e8 24 05 00 00       	call   b50 <priority>
 62c:	eb b7                	jmp    5e5 <testPriority+0x45>
        wait_stat(&status1, &perf2);
 62e:	8d 5d d4             	lea    -0x2c(%ebp),%ebx
 631:	8d 45 d0             	lea    -0x30(%ebp),%eax
 634:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 638:	89 04 24             	mov    %eax,(%esp)
 63b:	e8 20 05 00 00       	call   b60 <wait_stat>
        printPerf(&perf2);
 640:	89 1c 24             	mov    %ebx,(%esp)
 643:	e8 e8 fc ff ff       	call   330 <printPerf>
}
 648:	83 c4 3c             	add    $0x3c,%esp
 64b:	5b                   	pop    %ebx
 64c:	5e                   	pop    %esi
 64d:	5f                   	pop    %edi
 64e:	5d                   	pop    %ebp
 64f:	c3                   	ret    
                priority(5);
 650:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 657:	e8 f4 04 00 00       	call   b50 <priority>
                sleep(5);
 65c:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 663:	e8 d0 04 00 00       	call   b38 <sleep>
                exit(0);
 668:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 66f:	e8 34 04 00 00       	call   aa8 <exit>
 674:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 67a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000680 <procCalculate>:
int procCalculate(int x) {
 680:	55                   	push   %ebp
 681:	89 e5                	mov    %esp,%ebp
 683:	83 ec 18             	sub    $0x18,%esp
    for (int i = 0; i < x; ++i) {
 686:	8b 45 08             	mov    0x8(%ebp),%eax
 689:	85 c0                	test   %eax,%eax
 68b:	7f 04                	jg     691 <procCalculate+0x11>
}
 68d:	31 c0                	xor    %eax,%eax
 68f:	c9                   	leave  
 690:	c3                   	ret    
        exit(0);
 691:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 698:	e8 0b 04 00 00       	call   aa8 <exit>
 69d:	8d 76 00             	lea    0x0(%esi),%esi

000006a0 <testPerf>:
void testPerf(int policyNum){
 6a0:	55                   	push   %ebp
    printf(1, "----------test preformance %d started\n", policyNum);
 6a1:	b8 80 10 00 00       	mov    $0x1080,%eax
void testPerf(int policyNum){
 6a6:	89 e5                	mov    %esp,%ebp
 6a8:	57                   	push   %edi
 6a9:	56                   	push   %esi
 6aa:	53                   	push   %ebx
 6ab:	83 ec 3c             	sub    $0x3c,%esp
 6ae:	8b 7d 08             	mov    0x8(%ebp),%edi
    printf(1, "----------test preformance %d started\n", policyNum);
 6b1:	89 44 24 04          	mov    %eax,0x4(%esp)
 6b5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 6bc:	89 7c 24 08          	mov    %edi,0x8(%esp)
 6c0:	e8 4b 05 00 00       	call   c10 <printf>
    policy(policyNum);
 6c5:	89 3c 24             	mov    %edi,(%esp)
 6c8:	e8 8b 04 00 00       	call   b58 <policy>
    int pid1 = fork();
 6cd:	e8 ce 03 00 00       	call   aa0 <fork>
    if (pid1 > 0) {
 6d2:	85 c0                	test   %eax,%eax
 6d4:	7e 1a                	jle    6f0 <testPerf+0x50>
        wait(&status1);
 6d6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
 6d9:	89 04 24             	mov    %eax,(%esp)
 6dc:	e8 cf 03 00 00       	call   ab0 <wait>
}
 6e1:	83 c4 3c             	add    $0x3c,%esp
 6e4:	5b                   	pop    %ebx
 6e5:	5e                   	pop    %esi
 6e6:	5f                   	pop    %edi
 6e7:	5d                   	pop    %ebp
 6e8:	c3                   	ret    
 6e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        int pid5 = fork();
 6f0:	e8 ab 03 00 00       	call   aa0 <fork>
        if (pid5 > 0) {
 6f5:	85 c0                	test   %eax,%eax
 6f7:	0f 8f 56 01 00 00    	jg     853 <testPerf+0x1b3>
 6fd:	bb 0a 00 00 00       	mov    $0xa,%ebx
                    wait(&status_5);
 702:	8d 75 d4             	lea    -0x2c(%ebp),%esi
 705:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
                int pid_5 = fork();
 710:	e8 8b 03 00 00       	call   aa0 <fork>
                if (pid_5 > 0) {
 715:	85 c0                	test   %eax,%eax
 717:	0f 8e b2 00 00 00    	jle    7cf <testPerf+0x12f>
                    sleep(10);
 71d:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
 724:	e8 0f 04 00 00       	call   b38 <sleep>
                    wait(&status_5);
 729:	89 34 24             	mov    %esi,(%esp)
 72c:	e8 7f 03 00 00       	call   ab0 <wait>
            for (int i = 0; i < nProcs; i++){
 731:	4b                   	dec    %ebx
 732:	75 dc                	jne    710 <testPerf+0x70>
        int pid2 = fork();
 734:	e8 67 03 00 00       	call   aa0 <fork>
        if (pid2 > 0) {
 739:	85 c0                	test   %eax,%eax
 73b:	90                   	nop
 73c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 740:	0f 8f af 00 00 00    	jg     7f5 <testPerf+0x155>
 746:	bb 0a 00 00 00       	mov    $0xa,%ebx
 74b:	90                   	nop
 74c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                int pid_5 = fork();
 750:	e8 4b 03 00 00       	call   aa0 <fork>
                if (pid_5 > 0) {
 755:	85 c0                	test   %eax,%eax
 757:	7e 63                	jle    7bc <testPerf+0x11c>
                    sleep(10);
 759:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
 760:	e8 d3 03 00 00       	call   b38 <sleep>
                    wait(&status_5);
 765:	89 34 24             	mov    %esi,(%esp)
 768:	e8 43 03 00 00       	call   ab0 <wait>
            for (int i = 0; i < nProcs; i++){
 76d:	4b                   	dec    %ebx
 76e:	75 e0                	jne    750 <testPerf+0xb0>
        int pid3 = fork();
 770:	e8 2b 03 00 00       	call   aa0 <fork>
        if (pid3 > 0) {
 775:	85 c0                	test   %eax,%eax
 777:	0f 8f b1 00 00 00    	jg     82e <testPerf+0x18e>
 77d:	bb 0a 00 00 00       	mov    $0xa,%ebx
 782:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
                int pid_5 = fork();
 790:	e8 0b 03 00 00       	call   aa0 <fork>
                    sleep(10);
 795:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
                if (pid_5 > 0) {
 79c:	85 c0                	test   %eax,%eax
 79e:	7e 28                	jle    7c8 <testPerf+0x128>
                    sleep(10);
 7a0:	e8 93 03 00 00       	call   b38 <sleep>
                    wait(&status_5);
 7a5:	89 34 24             	mov    %esi,(%esp)
 7a8:	e8 03 03 00 00       	call   ab0 <wait>
            for (int i = 0; i < nProcs; i++){
 7ad:	4b                   	dec    %ebx
 7ae:	75 e0                	jne    790 <testPerf+0xf0>
            exit(0);
 7b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 7b7:	e8 ec 02 00 00       	call   aa8 <exit>
                    if(policyNum == 3)
 7bc:	83 ff 03             	cmp    $0x3,%edi
 7bf:	74 26                	je     7e7 <testPerf+0x147>
                        priority(1);
 7c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 7c8:	e8 83 03 00 00       	call   b50 <priority>
 7cd:	eb e1                	jmp    7b0 <testPerf+0x110>
                    priority(5);
 7cf:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 7d6:	e8 75 03 00 00       	call   b50 <priority>
        exit(0);
 7db:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 7e2:	e8 c1 02 00 00       	call   aa8 <exit>
                        priority(0);
 7e7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 7ee:	e8 5d 03 00 00       	call   b50 <priority>
 7f3:	eb bb                	jmp    7b0 <testPerf+0x110>
            sleep(10);
 7f5:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
 7fc:	e8 37 03 00 00       	call   b38 <sleep>
            wait_stat(&status2, &perf2);
 801:	8d 45 d0             	lea    -0x30(%ebp),%eax
 804:	89 74 24 04          	mov    %esi,0x4(%esp)
 808:	89 04 24             	mov    %eax,(%esp)
 80b:	e8 50 03 00 00       	call   b60 <wait_stat>
            printf(1, "high priority process\n");
 810:	c7 44 24 04 58 11 00 	movl   $0x1158,0x4(%esp)
 817:	00 
            printf(1, "low priority process\n");
 818:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 81f:	e8 ec 03 00 00       	call   c10 <printf>
            printPerf(&perf3);
 824:	89 34 24             	mov    %esi,(%esp)
 827:	e8 04 fb ff ff       	call   330 <printPerf>
 82c:	eb 82                	jmp    7b0 <testPerf+0x110>
            sleep(10);
 82e:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
 835:	e8 fe 02 00 00       	call   b38 <sleep>
            wait_stat(&status3, &perf3);
 83a:	8d 45 d0             	lea    -0x30(%ebp),%eax
 83d:	89 74 24 04          	mov    %esi,0x4(%esp)
 841:	89 04 24             	mov    %eax,(%esp)
 844:	e8 17 03 00 00       	call   b60 <wait_stat>
            printf(1, "low priority process\n");
 849:	c7 44 24 04 6f 11 00 	movl   $0x116f,0x4(%esp)
 850:	00 
 851:	eb c5                	jmp    818 <testPerf+0x178>
            sleep(10);
 853:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
 85a:	e8 d9 02 00 00       	call   b38 <sleep>
            wait(&status5);
 85f:	8d 45 d4             	lea    -0x2c(%ebp),%eax
 862:	89 04 24             	mov    %eax,(%esp)
 865:	e8 46 02 00 00       	call   ab0 <wait>
            exit(0);
 86a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 871:	e8 32 02 00 00       	call   aa8 <exit>
 876:	66 90                	xchg   %ax,%ax
 878:	66 90                	xchg   %ax,%ax
 87a:	66 90                	xchg   %ax,%ax
 87c:	66 90                	xchg   %ax,%ax
 87e:	66 90                	xchg   %ax,%ax

00000880 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 880:	55                   	push   %ebp
 881:	89 e5                	mov    %esp,%ebp
 883:	8b 45 08             	mov    0x8(%ebp),%eax
 886:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 889:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 88a:	89 c2                	mov    %eax,%edx
 88c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 890:	41                   	inc    %ecx
 891:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 895:	42                   	inc    %edx
 896:	84 db                	test   %bl,%bl
 898:	88 5a ff             	mov    %bl,-0x1(%edx)
 89b:	75 f3                	jne    890 <strcpy+0x10>
    ;
  return os;
}
 89d:	5b                   	pop    %ebx
 89e:	5d                   	pop    %ebp
 89f:	c3                   	ret    

000008a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 8a0:	55                   	push   %ebp
 8a1:	89 e5                	mov    %esp,%ebp
 8a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 8a6:	53                   	push   %ebx
 8a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 8aa:	0f b6 01             	movzbl (%ecx),%eax
 8ad:	0f b6 13             	movzbl (%ebx),%edx
 8b0:	84 c0                	test   %al,%al
 8b2:	75 18                	jne    8cc <strcmp+0x2c>
 8b4:	eb 22                	jmp    8d8 <strcmp+0x38>
 8b6:	8d 76 00             	lea    0x0(%esi),%esi
 8b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 8c0:	41                   	inc    %ecx
  while(*p && *p == *q)
 8c1:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 8c4:	43                   	inc    %ebx
 8c5:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
 8c8:	84 c0                	test   %al,%al
 8ca:	74 0c                	je     8d8 <strcmp+0x38>
 8cc:	38 d0                	cmp    %dl,%al
 8ce:	74 f0                	je     8c0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
 8d0:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 8d1:	29 d0                	sub    %edx,%eax
}
 8d3:	5d                   	pop    %ebp
 8d4:	c3                   	ret    
 8d5:	8d 76 00             	lea    0x0(%esi),%esi
 8d8:	5b                   	pop    %ebx
 8d9:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 8db:	29 d0                	sub    %edx,%eax
}
 8dd:	5d                   	pop    %ebp
 8de:	c3                   	ret    
 8df:	90                   	nop

000008e0 <strlen>:

uint
strlen(const char *s)
{
 8e0:	55                   	push   %ebp
 8e1:	89 e5                	mov    %esp,%ebp
 8e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 8e6:	80 39 00             	cmpb   $0x0,(%ecx)
 8e9:	74 15                	je     900 <strlen+0x20>
 8eb:	31 d2                	xor    %edx,%edx
 8ed:	8d 76 00             	lea    0x0(%esi),%esi
 8f0:	42                   	inc    %edx
 8f1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 8f5:	89 d0                	mov    %edx,%eax
 8f7:	75 f7                	jne    8f0 <strlen+0x10>
    ;
  return n;
}
 8f9:	5d                   	pop    %ebp
 8fa:	c3                   	ret    
 8fb:	90                   	nop
 8fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
 900:	31 c0                	xor    %eax,%eax
}
 902:	5d                   	pop    %ebp
 903:	c3                   	ret    
 904:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 90a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000910 <memset>:

void*
memset(void *dst, int c, uint n)
{
 910:	55                   	push   %ebp
 911:	89 e5                	mov    %esp,%ebp
 913:	8b 55 08             	mov    0x8(%ebp),%edx
 916:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 917:	8b 4d 10             	mov    0x10(%ebp),%ecx
 91a:	8b 45 0c             	mov    0xc(%ebp),%eax
 91d:	89 d7                	mov    %edx,%edi
 91f:	fc                   	cld    
 920:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 922:	5f                   	pop    %edi
 923:	89 d0                	mov    %edx,%eax
 925:	5d                   	pop    %ebp
 926:	c3                   	ret    
 927:	89 f6                	mov    %esi,%esi
 929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000930 <strchr>:

char*
strchr(const char *s, char c)
{
 930:	55                   	push   %ebp
 931:	89 e5                	mov    %esp,%ebp
 933:	8b 45 08             	mov    0x8(%ebp),%eax
 936:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 93a:	0f b6 10             	movzbl (%eax),%edx
 93d:	84 d2                	test   %dl,%dl
 93f:	74 1b                	je     95c <strchr+0x2c>
    if(*s == c)
 941:	38 d1                	cmp    %dl,%cl
 943:	75 0f                	jne    954 <strchr+0x24>
 945:	eb 17                	jmp    95e <strchr+0x2e>
 947:	89 f6                	mov    %esi,%esi
 949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 950:	38 ca                	cmp    %cl,%dl
 952:	74 0a                	je     95e <strchr+0x2e>
  for(; *s; s++)
 954:	40                   	inc    %eax
 955:	0f b6 10             	movzbl (%eax),%edx
 958:	84 d2                	test   %dl,%dl
 95a:	75 f4                	jne    950 <strchr+0x20>
      return (char*)s;
  return 0;
 95c:	31 c0                	xor    %eax,%eax
}
 95e:	5d                   	pop    %ebp
 95f:	c3                   	ret    

00000960 <gets>:

char*
gets(char *buf, int max)
{
 960:	55                   	push   %ebp
 961:	89 e5                	mov    %esp,%ebp
 963:	57                   	push   %edi
 964:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 965:	31 f6                	xor    %esi,%esi
{
 967:	53                   	push   %ebx
 968:	83 ec 3c             	sub    $0x3c,%esp
 96b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
 96e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 971:	eb 32                	jmp    9a5 <gets+0x45>
 973:	90                   	nop
 974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 978:	ba 01 00 00 00       	mov    $0x1,%edx
 97d:	89 54 24 08          	mov    %edx,0x8(%esp)
 981:	89 7c 24 04          	mov    %edi,0x4(%esp)
 985:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 98c:	e8 2f 01 00 00       	call   ac0 <read>
    if(cc < 1)
 991:	85 c0                	test   %eax,%eax
 993:	7e 19                	jle    9ae <gets+0x4e>
      break;
    buf[i++] = c;
 995:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 999:	43                   	inc    %ebx
 99a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
 99d:	3c 0a                	cmp    $0xa,%al
 99f:	74 1f                	je     9c0 <gets+0x60>
 9a1:	3c 0d                	cmp    $0xd,%al
 9a3:	74 1b                	je     9c0 <gets+0x60>
  for(i=0; i+1 < max; ){
 9a5:	46                   	inc    %esi
 9a6:	3b 75 0c             	cmp    0xc(%ebp),%esi
 9a9:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 9ac:	7c ca                	jl     978 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 9ae:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 9b1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 9b4:	8b 45 08             	mov    0x8(%ebp),%eax
 9b7:	83 c4 3c             	add    $0x3c,%esp
 9ba:	5b                   	pop    %ebx
 9bb:	5e                   	pop    %esi
 9bc:	5f                   	pop    %edi
 9bd:	5d                   	pop    %ebp
 9be:	c3                   	ret    
 9bf:	90                   	nop
 9c0:	8b 45 08             	mov    0x8(%ebp),%eax
 9c3:	01 c6                	add    %eax,%esi
 9c5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 9c8:	eb e4                	jmp    9ae <gets+0x4e>
 9ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000009d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 9d0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 9d1:	31 c0                	xor    %eax,%eax
{
 9d3:	89 e5                	mov    %esp,%ebp
 9d5:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 9d8:	89 44 24 04          	mov    %eax,0x4(%esp)
 9dc:	8b 45 08             	mov    0x8(%ebp),%eax
{
 9df:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 9e2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 9e5:	89 04 24             	mov    %eax,(%esp)
 9e8:	e8 fb 00 00 00       	call   ae8 <open>
  if(fd < 0)
 9ed:	85 c0                	test   %eax,%eax
 9ef:	78 2f                	js     a20 <stat+0x50>
 9f1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 9f3:	8b 45 0c             	mov    0xc(%ebp),%eax
 9f6:	89 1c 24             	mov    %ebx,(%esp)
 9f9:	89 44 24 04          	mov    %eax,0x4(%esp)
 9fd:	e8 fe 00 00 00       	call   b00 <fstat>
  close(fd);
 a02:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 a05:	89 c6                	mov    %eax,%esi
  close(fd);
 a07:	e8 c4 00 00 00       	call   ad0 <close>
  return r;
}
 a0c:	89 f0                	mov    %esi,%eax
 a0e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 a11:	8b 75 fc             	mov    -0x4(%ebp),%esi
 a14:	89 ec                	mov    %ebp,%esp
 a16:	5d                   	pop    %ebp
 a17:	c3                   	ret    
 a18:	90                   	nop
 a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 a20:	be ff ff ff ff       	mov    $0xffffffff,%esi
 a25:	eb e5                	jmp    a0c <stat+0x3c>
 a27:	89 f6                	mov    %esi,%esi
 a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a30 <atoi>:

int
atoi(const char *s)
{
 a30:	55                   	push   %ebp
 a31:	89 e5                	mov    %esp,%ebp
 a33:	8b 4d 08             	mov    0x8(%ebp),%ecx
 a36:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 a37:	0f be 11             	movsbl (%ecx),%edx
 a3a:	88 d0                	mov    %dl,%al
 a3c:	2c 30                	sub    $0x30,%al
 a3e:	3c 09                	cmp    $0x9,%al
  n = 0;
 a40:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 a45:	77 1e                	ja     a65 <atoi+0x35>
 a47:	89 f6                	mov    %esi,%esi
 a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 a50:	41                   	inc    %ecx
 a51:	8d 04 80             	lea    (%eax,%eax,4),%eax
 a54:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 a58:	0f be 11             	movsbl (%ecx),%edx
 a5b:	88 d3                	mov    %dl,%bl
 a5d:	80 eb 30             	sub    $0x30,%bl
 a60:	80 fb 09             	cmp    $0x9,%bl
 a63:	76 eb                	jbe    a50 <atoi+0x20>
  return n;
}
 a65:	5b                   	pop    %ebx
 a66:	5d                   	pop    %ebp
 a67:	c3                   	ret    
 a68:	90                   	nop
 a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000a70 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 a70:	55                   	push   %ebp
 a71:	89 e5                	mov    %esp,%ebp
 a73:	56                   	push   %esi
 a74:	8b 45 08             	mov    0x8(%ebp),%eax
 a77:	53                   	push   %ebx
 a78:	8b 5d 10             	mov    0x10(%ebp),%ebx
 a7b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 a7e:	85 db                	test   %ebx,%ebx
 a80:	7e 1a                	jle    a9c <memmove+0x2c>
 a82:	31 d2                	xor    %edx,%edx
 a84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 a8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 a90:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 a94:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 a97:	42                   	inc    %edx
  while(n-- > 0)
 a98:	39 d3                	cmp    %edx,%ebx
 a9a:	75 f4                	jne    a90 <memmove+0x20>
  return vdst;
}
 a9c:	5b                   	pop    %ebx
 a9d:	5e                   	pop    %esi
 a9e:	5d                   	pop    %ebp
 a9f:	c3                   	ret    

00000aa0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 aa0:	b8 01 00 00 00       	mov    $0x1,%eax
 aa5:	cd 40                	int    $0x40
 aa7:	c3                   	ret    

00000aa8 <exit>:
SYSCALL(exit)
 aa8:	b8 02 00 00 00       	mov    $0x2,%eax
 aad:	cd 40                	int    $0x40
 aaf:	c3                   	ret    

00000ab0 <wait>:
SYSCALL(wait)
 ab0:	b8 03 00 00 00       	mov    $0x3,%eax
 ab5:	cd 40                	int    $0x40
 ab7:	c3                   	ret    

00000ab8 <pipe>:
SYSCALL(pipe)
 ab8:	b8 04 00 00 00       	mov    $0x4,%eax
 abd:	cd 40                	int    $0x40
 abf:	c3                   	ret    

00000ac0 <read>:
SYSCALL(read)
 ac0:	b8 05 00 00 00       	mov    $0x5,%eax
 ac5:	cd 40                	int    $0x40
 ac7:	c3                   	ret    

00000ac8 <write>:
SYSCALL(write)
 ac8:	b8 10 00 00 00       	mov    $0x10,%eax
 acd:	cd 40                	int    $0x40
 acf:	c3                   	ret    

00000ad0 <close>:
SYSCALL(close)
 ad0:	b8 15 00 00 00       	mov    $0x15,%eax
 ad5:	cd 40                	int    $0x40
 ad7:	c3                   	ret    

00000ad8 <kill>:
SYSCALL(kill)
 ad8:	b8 06 00 00 00       	mov    $0x6,%eax
 add:	cd 40                	int    $0x40
 adf:	c3                   	ret    

00000ae0 <exec>:
SYSCALL(exec)
 ae0:	b8 07 00 00 00       	mov    $0x7,%eax
 ae5:	cd 40                	int    $0x40
 ae7:	c3                   	ret    

00000ae8 <open>:
SYSCALL(open)
 ae8:	b8 0f 00 00 00       	mov    $0xf,%eax
 aed:	cd 40                	int    $0x40
 aef:	c3                   	ret    

00000af0 <mknod>:
SYSCALL(mknod)
 af0:	b8 11 00 00 00       	mov    $0x11,%eax
 af5:	cd 40                	int    $0x40
 af7:	c3                   	ret    

00000af8 <unlink>:
SYSCALL(unlink)
 af8:	b8 12 00 00 00       	mov    $0x12,%eax
 afd:	cd 40                	int    $0x40
 aff:	c3                   	ret    

00000b00 <fstat>:
SYSCALL(fstat)
 b00:	b8 08 00 00 00       	mov    $0x8,%eax
 b05:	cd 40                	int    $0x40
 b07:	c3                   	ret    

00000b08 <link>:
SYSCALL(link)
 b08:	b8 13 00 00 00       	mov    $0x13,%eax
 b0d:	cd 40                	int    $0x40
 b0f:	c3                   	ret    

00000b10 <mkdir>:
SYSCALL(mkdir)
 b10:	b8 14 00 00 00       	mov    $0x14,%eax
 b15:	cd 40                	int    $0x40
 b17:	c3                   	ret    

00000b18 <chdir>:
SYSCALL(chdir)
 b18:	b8 09 00 00 00       	mov    $0x9,%eax
 b1d:	cd 40                	int    $0x40
 b1f:	c3                   	ret    

00000b20 <dup>:
SYSCALL(dup)
 b20:	b8 0a 00 00 00       	mov    $0xa,%eax
 b25:	cd 40                	int    $0x40
 b27:	c3                   	ret    

00000b28 <getpid>:
SYSCALL(getpid)
 b28:	b8 0b 00 00 00       	mov    $0xb,%eax
 b2d:	cd 40                	int    $0x40
 b2f:	c3                   	ret    

00000b30 <sbrk>:
SYSCALL(sbrk)
 b30:	b8 0c 00 00 00       	mov    $0xc,%eax
 b35:	cd 40                	int    $0x40
 b37:	c3                   	ret    

00000b38 <sleep>:
SYSCALL(sleep)
 b38:	b8 0d 00 00 00       	mov    $0xd,%eax
 b3d:	cd 40                	int    $0x40
 b3f:	c3                   	ret    

00000b40 <uptime>:
SYSCALL(uptime)
 b40:	b8 0e 00 00 00       	mov    $0xe,%eax
 b45:	cd 40                	int    $0x40
 b47:	c3                   	ret    

00000b48 <detach>:
SYSCALL(detach)
 b48:	b8 16 00 00 00       	mov    $0x16,%eax
 b4d:	cd 40                	int    $0x40
 b4f:	c3                   	ret    

00000b50 <priority>:
SYSCALL(priority)
 b50:	b8 17 00 00 00       	mov    $0x17,%eax
 b55:	cd 40                	int    $0x40
 b57:	c3                   	ret    

00000b58 <policy>:
SYSCALL(policy)
 b58:	b8 18 00 00 00       	mov    $0x18,%eax
 b5d:	cd 40                	int    $0x40
 b5f:	c3                   	ret    

00000b60 <wait_stat>:
SYSCALL(wait_stat)
 b60:	b8 19 00 00 00       	mov    $0x19,%eax
 b65:	cd 40                	int    $0x40
 b67:	c3                   	ret    
 b68:	66 90                	xchg   %ax,%ax
 b6a:	66 90                	xchg   %ax,%ax
 b6c:	66 90                	xchg   %ax,%ax
 b6e:	66 90                	xchg   %ax,%ax

00000b70 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 b70:	55                   	push   %ebp
 b71:	89 e5                	mov    %esp,%ebp
 b73:	57                   	push   %edi
 b74:	56                   	push   %esi
 b75:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 b76:	89 d3                	mov    %edx,%ebx
 b78:	c1 eb 1f             	shr    $0x1f,%ebx
{
 b7b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 b7e:	84 db                	test   %bl,%bl
{
 b80:	89 45 c0             	mov    %eax,-0x40(%ebp)
 b83:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 b85:	74 79                	je     c00 <printint+0x90>
 b87:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 b8b:	74 73                	je     c00 <printint+0x90>
    neg = 1;
    x = -xx;
 b8d:	f7 d8                	neg    %eax
    neg = 1;
 b8f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 b96:	31 f6                	xor    %esi,%esi
 b98:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 b9b:	eb 05                	jmp    ba2 <printint+0x32>
 b9d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 ba0:	89 fe                	mov    %edi,%esi
 ba2:	31 d2                	xor    %edx,%edx
 ba4:	f7 f1                	div    %ecx
 ba6:	8d 7e 01             	lea    0x1(%esi),%edi
 ba9:	0f b6 92 e0 11 00 00 	movzbl 0x11e0(%edx),%edx
  }while((x /= base) != 0);
 bb0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 bb2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 bb5:	75 e9                	jne    ba0 <printint+0x30>
  if(neg)
 bb7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 bba:	85 d2                	test   %edx,%edx
 bbc:	74 08                	je     bc6 <printint+0x56>
    buf[i++] = '-';
 bbe:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 bc3:	8d 7e 02             	lea    0x2(%esi),%edi
 bc6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 bca:	8b 7d c0             	mov    -0x40(%ebp),%edi
 bcd:	8d 76 00             	lea    0x0(%esi),%esi
 bd0:	0f b6 06             	movzbl (%esi),%eax
 bd3:	4e                   	dec    %esi
  write(fd, &c, 1);
 bd4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 bd8:	89 3c 24             	mov    %edi,(%esp)
 bdb:	88 45 d7             	mov    %al,-0x29(%ebp)
 bde:	b8 01 00 00 00       	mov    $0x1,%eax
 be3:	89 44 24 08          	mov    %eax,0x8(%esp)
 be7:	e8 dc fe ff ff       	call   ac8 <write>

  while(--i >= 0)
 bec:	39 de                	cmp    %ebx,%esi
 bee:	75 e0                	jne    bd0 <printint+0x60>
    putc(fd, buf[i]);
}
 bf0:	83 c4 4c             	add    $0x4c,%esp
 bf3:	5b                   	pop    %ebx
 bf4:	5e                   	pop    %esi
 bf5:	5f                   	pop    %edi
 bf6:	5d                   	pop    %ebp
 bf7:	c3                   	ret    
 bf8:	90                   	nop
 bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 c00:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 c07:	eb 8d                	jmp    b96 <printint+0x26>
 c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000c10 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 c10:	55                   	push   %ebp
 c11:	89 e5                	mov    %esp,%ebp
 c13:	57                   	push   %edi
 c14:	56                   	push   %esi
 c15:	53                   	push   %ebx
 c16:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 c19:	8b 75 0c             	mov    0xc(%ebp),%esi
 c1c:	0f b6 1e             	movzbl (%esi),%ebx
 c1f:	84 db                	test   %bl,%bl
 c21:	0f 84 d1 00 00 00    	je     cf8 <printf+0xe8>
  state = 0;
 c27:	31 ff                	xor    %edi,%edi
 c29:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 c2a:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 c2d:	89 fa                	mov    %edi,%edx
 c2f:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 c32:	89 45 d0             	mov    %eax,-0x30(%ebp)
 c35:	eb 41                	jmp    c78 <printf+0x68>
 c37:	89 f6                	mov    %esi,%esi
 c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 c40:	83 f8 25             	cmp    $0x25,%eax
 c43:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 c46:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 c4b:	74 1e                	je     c6b <printf+0x5b>
  write(fd, &c, 1);
 c4d:	b8 01 00 00 00       	mov    $0x1,%eax
 c52:	89 44 24 08          	mov    %eax,0x8(%esp)
 c56:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 c59:	89 44 24 04          	mov    %eax,0x4(%esp)
 c5d:	89 3c 24             	mov    %edi,(%esp)
 c60:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 c63:	e8 60 fe ff ff       	call   ac8 <write>
 c68:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 c6b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 c6c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 c70:	84 db                	test   %bl,%bl
 c72:	0f 84 80 00 00 00    	je     cf8 <printf+0xe8>
    if(state == 0){
 c78:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 c7a:	0f be cb             	movsbl %bl,%ecx
 c7d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 c80:	74 be                	je     c40 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 c82:	83 fa 25             	cmp    $0x25,%edx
 c85:	75 e4                	jne    c6b <printf+0x5b>
      if(c == 'd'){
 c87:	83 f8 64             	cmp    $0x64,%eax
 c8a:	0f 84 f0 00 00 00    	je     d80 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 c90:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 c96:	83 f9 70             	cmp    $0x70,%ecx
 c99:	74 65                	je     d00 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 c9b:	83 f8 73             	cmp    $0x73,%eax
 c9e:	0f 84 8c 00 00 00    	je     d30 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 ca4:	83 f8 63             	cmp    $0x63,%eax
 ca7:	0f 84 13 01 00 00    	je     dc0 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 cad:	83 f8 25             	cmp    $0x25,%eax
 cb0:	0f 84 e2 00 00 00    	je     d98 <printf+0x188>
  write(fd, &c, 1);
 cb6:	b8 01 00 00 00       	mov    $0x1,%eax
 cbb:	46                   	inc    %esi
 cbc:	89 44 24 08          	mov    %eax,0x8(%esp)
 cc0:	8d 45 e7             	lea    -0x19(%ebp),%eax
 cc3:	89 44 24 04          	mov    %eax,0x4(%esp)
 cc7:	89 3c 24             	mov    %edi,(%esp)
 cca:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 cce:	e8 f5 fd ff ff       	call   ac8 <write>
 cd3:	ba 01 00 00 00       	mov    $0x1,%edx
 cd8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 cdb:	89 54 24 08          	mov    %edx,0x8(%esp)
 cdf:	89 44 24 04          	mov    %eax,0x4(%esp)
 ce3:	89 3c 24             	mov    %edi,(%esp)
 ce6:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 ce9:	e8 da fd ff ff       	call   ac8 <write>
  for(i = 0; fmt[i]; i++){
 cee:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 cf2:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 cf4:	84 db                	test   %bl,%bl
 cf6:	75 80                	jne    c78 <printf+0x68>
    }
  }
}
 cf8:	83 c4 3c             	add    $0x3c,%esp
 cfb:	5b                   	pop    %ebx
 cfc:	5e                   	pop    %esi
 cfd:	5f                   	pop    %edi
 cfe:	5d                   	pop    %ebp
 cff:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 d00:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 d07:	b9 10 00 00 00       	mov    $0x10,%ecx
 d0c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 d0f:	89 f8                	mov    %edi,%eax
 d11:	8b 13                	mov    (%ebx),%edx
 d13:	e8 58 fe ff ff       	call   b70 <printint>
        ap++;
 d18:	89 d8                	mov    %ebx,%eax
      state = 0;
 d1a:	31 d2                	xor    %edx,%edx
        ap++;
 d1c:	83 c0 04             	add    $0x4,%eax
 d1f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 d22:	e9 44 ff ff ff       	jmp    c6b <printf+0x5b>
 d27:	89 f6                	mov    %esi,%esi
 d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 d30:	8b 45 d0             	mov    -0x30(%ebp),%eax
 d33:	8b 10                	mov    (%eax),%edx
        ap++;
 d35:	83 c0 04             	add    $0x4,%eax
 d38:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 d3b:	85 d2                	test   %edx,%edx
 d3d:	0f 84 aa 00 00 00    	je     ded <printf+0x1dd>
        while(*s != 0){
 d43:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 d46:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 d48:	84 c0                	test   %al,%al
 d4a:	74 27                	je     d73 <printf+0x163>
 d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 d50:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 d53:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 d58:	43                   	inc    %ebx
  write(fd, &c, 1);
 d59:	89 44 24 08          	mov    %eax,0x8(%esp)
 d5d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 d60:	89 44 24 04          	mov    %eax,0x4(%esp)
 d64:	89 3c 24             	mov    %edi,(%esp)
 d67:	e8 5c fd ff ff       	call   ac8 <write>
        while(*s != 0){
 d6c:	0f b6 03             	movzbl (%ebx),%eax
 d6f:	84 c0                	test   %al,%al
 d71:	75 dd                	jne    d50 <printf+0x140>
      state = 0;
 d73:	31 d2                	xor    %edx,%edx
 d75:	e9 f1 fe ff ff       	jmp    c6b <printf+0x5b>
 d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 d80:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 d87:	b9 0a 00 00 00       	mov    $0xa,%ecx
 d8c:	e9 7b ff ff ff       	jmp    d0c <printf+0xfc>
 d91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 d98:	b9 01 00 00 00       	mov    $0x1,%ecx
 d9d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 da0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 da4:	89 44 24 04          	mov    %eax,0x4(%esp)
 da8:	89 3c 24             	mov    %edi,(%esp)
 dab:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 dae:	e8 15 fd ff ff       	call   ac8 <write>
      state = 0;
 db3:	31 d2                	xor    %edx,%edx
 db5:	e9 b1 fe ff ff       	jmp    c6b <printf+0x5b>
 dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 dc0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 dc3:	8b 03                	mov    (%ebx),%eax
        ap++;
 dc5:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 dc8:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 dcb:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 dce:	b8 01 00 00 00       	mov    $0x1,%eax
 dd3:	89 44 24 08          	mov    %eax,0x8(%esp)
 dd7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 dda:	89 44 24 04          	mov    %eax,0x4(%esp)
 dde:	e8 e5 fc ff ff       	call   ac8 <write>
      state = 0;
 de3:	31 d2                	xor    %edx,%edx
        ap++;
 de5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 de8:	e9 7e fe ff ff       	jmp    c6b <printf+0x5b>
          s = "(null)";
 ded:	bb d9 11 00 00       	mov    $0x11d9,%ebx
        while(*s != 0){
 df2:	b0 28                	mov    $0x28,%al
 df4:	e9 57 ff ff ff       	jmp    d50 <printf+0x140>
 df9:	66 90                	xchg   %ax,%ax
 dfb:	66 90                	xchg   %ax,%ax
 dfd:	66 90                	xchg   %ax,%ax
 dff:	90                   	nop

00000e00 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 e00:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e01:	a1 c8 15 00 00       	mov    0x15c8,%eax
{
 e06:	89 e5                	mov    %esp,%ebp
 e08:	57                   	push   %edi
 e09:	56                   	push   %esi
 e0a:	53                   	push   %ebx
 e0b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 e0e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 e11:	eb 0d                	jmp    e20 <free+0x20>
 e13:	90                   	nop
 e14:	90                   	nop
 e15:	90                   	nop
 e16:	90                   	nop
 e17:	90                   	nop
 e18:	90                   	nop
 e19:	90                   	nop
 e1a:	90                   	nop
 e1b:	90                   	nop
 e1c:	90                   	nop
 e1d:	90                   	nop
 e1e:	90                   	nop
 e1f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e20:	39 c8                	cmp    %ecx,%eax
 e22:	8b 10                	mov    (%eax),%edx
 e24:	73 32                	jae    e58 <free+0x58>
 e26:	39 d1                	cmp    %edx,%ecx
 e28:	72 04                	jb     e2e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e2a:	39 d0                	cmp    %edx,%eax
 e2c:	72 32                	jb     e60 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 e2e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 e31:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 e34:	39 fa                	cmp    %edi,%edx
 e36:	74 30                	je     e68 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 e38:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 e3b:	8b 50 04             	mov    0x4(%eax),%edx
 e3e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 e41:	39 f1                	cmp    %esi,%ecx
 e43:	74 3c                	je     e81 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 e45:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 e47:	5b                   	pop    %ebx
  freep = p;
 e48:	a3 c8 15 00 00       	mov    %eax,0x15c8
}
 e4d:	5e                   	pop    %esi
 e4e:	5f                   	pop    %edi
 e4f:	5d                   	pop    %ebp
 e50:	c3                   	ret    
 e51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e58:	39 d0                	cmp    %edx,%eax
 e5a:	72 04                	jb     e60 <free+0x60>
 e5c:	39 d1                	cmp    %edx,%ecx
 e5e:	72 ce                	jb     e2e <free+0x2e>
{
 e60:	89 d0                	mov    %edx,%eax
 e62:	eb bc                	jmp    e20 <free+0x20>
 e64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 e68:	8b 7a 04             	mov    0x4(%edx),%edi
 e6b:	01 fe                	add    %edi,%esi
 e6d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 e70:	8b 10                	mov    (%eax),%edx
 e72:	8b 12                	mov    (%edx),%edx
 e74:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 e77:	8b 50 04             	mov    0x4(%eax),%edx
 e7a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 e7d:	39 f1                	cmp    %esi,%ecx
 e7f:	75 c4                	jne    e45 <free+0x45>
    p->s.size += bp->s.size;
 e81:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 e84:	a3 c8 15 00 00       	mov    %eax,0x15c8
    p->s.size += bp->s.size;
 e89:	01 ca                	add    %ecx,%edx
 e8b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 e8e:	8b 53 f8             	mov    -0x8(%ebx),%edx
 e91:	89 10                	mov    %edx,(%eax)
}
 e93:	5b                   	pop    %ebx
 e94:	5e                   	pop    %esi
 e95:	5f                   	pop    %edi
 e96:	5d                   	pop    %ebp
 e97:	c3                   	ret    
 e98:	90                   	nop
 e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000ea0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ea0:	55                   	push   %ebp
 ea1:	89 e5                	mov    %esp,%ebp
 ea3:	57                   	push   %edi
 ea4:	56                   	push   %esi
 ea5:	53                   	push   %ebx
 ea6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ea9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 eac:	8b 15 c8 15 00 00    	mov    0x15c8,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 eb2:	8d 78 07             	lea    0x7(%eax),%edi
 eb5:	c1 ef 03             	shr    $0x3,%edi
 eb8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 eb9:	85 d2                	test   %edx,%edx
 ebb:	0f 84 8f 00 00 00    	je     f50 <malloc+0xb0>
 ec1:	8b 02                	mov    (%edx),%eax
 ec3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 ec6:	39 cf                	cmp    %ecx,%edi
 ec8:	76 66                	jbe    f30 <malloc+0x90>
 eca:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 ed0:	bb 00 10 00 00       	mov    $0x1000,%ebx
 ed5:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 ed8:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 edf:	eb 10                	jmp    ef1 <malloc+0x51>
 ee1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ee8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 eea:	8b 48 04             	mov    0x4(%eax),%ecx
 eed:	39 f9                	cmp    %edi,%ecx
 eef:	73 3f                	jae    f30 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ef1:	39 05 c8 15 00 00    	cmp    %eax,0x15c8
 ef7:	89 c2                	mov    %eax,%edx
 ef9:	75 ed                	jne    ee8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 efb:	89 34 24             	mov    %esi,(%esp)
 efe:	e8 2d fc ff ff       	call   b30 <sbrk>
  if(p == (char*)-1)
 f03:	83 f8 ff             	cmp    $0xffffffff,%eax
 f06:	74 18                	je     f20 <malloc+0x80>
  hp->s.size = nu;
 f08:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 f0b:	83 c0 08             	add    $0x8,%eax
 f0e:	89 04 24             	mov    %eax,(%esp)
 f11:	e8 ea fe ff ff       	call   e00 <free>
  return freep;
 f16:	8b 15 c8 15 00 00    	mov    0x15c8,%edx
      if((p = morecore(nunits)) == 0)
 f1c:	85 d2                	test   %edx,%edx
 f1e:	75 c8                	jne    ee8 <malloc+0x48>
        return 0;
  }
}
 f20:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 f23:	31 c0                	xor    %eax,%eax
}
 f25:	5b                   	pop    %ebx
 f26:	5e                   	pop    %esi
 f27:	5f                   	pop    %edi
 f28:	5d                   	pop    %ebp
 f29:	c3                   	ret    
 f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 f30:	39 cf                	cmp    %ecx,%edi
 f32:	74 4c                	je     f80 <malloc+0xe0>
        p->s.size -= nunits;
 f34:	29 f9                	sub    %edi,%ecx
 f36:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 f39:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 f3c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 f3f:	89 15 c8 15 00 00    	mov    %edx,0x15c8
}
 f45:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 f48:	83 c0 08             	add    $0x8,%eax
}
 f4b:	5b                   	pop    %ebx
 f4c:	5e                   	pop    %esi
 f4d:	5f                   	pop    %edi
 f4e:	5d                   	pop    %ebp
 f4f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 f50:	b8 cc 15 00 00       	mov    $0x15cc,%eax
 f55:	ba cc 15 00 00       	mov    $0x15cc,%edx
    base.s.size = 0;
 f5a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 f5c:	a3 c8 15 00 00       	mov    %eax,0x15c8
    base.s.size = 0;
 f61:	b8 cc 15 00 00       	mov    $0x15cc,%eax
    base.s.ptr = freep = prevp = &base;
 f66:	89 15 cc 15 00 00    	mov    %edx,0x15cc
    base.s.size = 0;
 f6c:	89 0d d0 15 00 00    	mov    %ecx,0x15d0
 f72:	e9 53 ff ff ff       	jmp    eca <malloc+0x2a>
 f77:	89 f6                	mov    %esi,%esi
 f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 f80:	8b 08                	mov    (%eax),%ecx
 f82:	89 0a                	mov    %ecx,(%edx)
 f84:	eb b9                	jmp    f3f <malloc+0x9f>
