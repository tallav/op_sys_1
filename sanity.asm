
_sanity:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
        }
    }
    exit(0);
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
  10:	b8 48 0f 00 00       	mov    $0xf48,%eax
  15:	89 44 24 04          	mov    %eax,0x4(%esp)
  19:	89 1c 24             	mov    %ebx,(%esp)
  1c:	e8 6f 06 00 00       	call   690 <strcmp>
  21:	85 c0                	test   %eax,%eax
  23:	75 11                	jne    36 <main+0x36>
		testExitWait();
  25:	e8 46 01 00 00       	call   170 <testExitWait>
            testPolicy(3);
            testPerf(1);
            testPerf(2);
            testPerf(3);
        }
        exit(0);
  2a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  31:	e8 62 08 00 00       	call   898 <exit>
	else if(strcmp(arg, "detach") == 0)
  36:	c7 44 24 04 4d 0f 00 	movl   $0xf4d,0x4(%esp)
  3d:	00 
  3e:	89 1c 24             	mov    %ebx,(%esp)
  41:	e8 4a 06 00 00       	call   690 <strcmp>
  46:	85 c0                	test   %eax,%eax
  48:	75 08                	jne    52 <main+0x52>
		testDetach();
  4a:	e8 c1 01 00 00       	call   210 <testDetach>
  4f:	90                   	nop
  50:	eb d8                	jmp    2a <main+0x2a>
	else if(strcmp(arg, "wait_stat") == 0)
  52:	c7 44 24 04 54 0f 00 	movl   $0xf54,0x4(%esp)
  59:	00 
  5a:	89 1c 24             	mov    %ebx,(%esp)
  5d:	e8 2e 06 00 00       	call   690 <strcmp>
  62:	85 c0                	test   %eax,%eax
  64:	74 22                	je     88 <main+0x88>
	else if(strcmp(arg, "policy1") == 0)
  66:	c7 44 24 04 5e 0f 00 	movl   $0xf5e,0x4(%esp)
  6d:	00 
  6e:	89 1c 24             	mov    %ebx,(%esp)
  71:	e8 1a 06 00 00       	call   690 <strcmp>
  76:	85 c0                	test   %eax,%eax
  78:	75 18                	jne    92 <main+0x92>
		testPolicy(1);
  7a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  81:	e8 ca 03 00 00       	call   450 <testPolicy>
  86:	eb a2                	jmp    2a <main+0x2a>
		testWaitStat();
  88:	e8 13 03 00 00       	call   3a0 <testWaitStat>
  8d:	8d 76 00             	lea    0x0(%esi),%esi
  90:	eb 98                	jmp    2a <main+0x2a>
	else if(strcmp(arg, "policy2") == 0)
  92:	c7 44 24 04 66 0f 00 	movl   $0xf66,0x4(%esp)
  99:	00 
  9a:	89 1c 24             	mov    %ebx,(%esp)
  9d:	e8 ee 05 00 00       	call   690 <strcmp>
  a2:	85 c0                	test   %eax,%eax
  a4:	74 25                	je     cb <main+0xcb>
	else if(strcmp(arg, "policy3") == 0)
  a6:	c7 44 24 04 6e 0f 00 	movl   $0xf6e,0x4(%esp)
  ad:	00 
  ae:	89 1c 24             	mov    %ebx,(%esp)
  b1:	e8 da 05 00 00       	call   690 <strcmp>
  b6:	85 c0                	test   %eax,%eax
  b8:	75 22                	jne    dc <main+0xdc>
		testPolicy(3);
  ba:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
  c1:	e8 8a 03 00 00       	call   450 <testPolicy>
  c6:	e9 5f ff ff ff       	jmp    2a <main+0x2a>
		testPolicy(2);
  cb:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  d2:	e8 79 03 00 00       	call   450 <testPolicy>
  d7:	e9 4e ff ff ff       	jmp    2a <main+0x2a>
        else if(strcmp(arg, "perf1") == 0)
  dc:	c7 44 24 04 76 0f 00 	movl   $0xf76,0x4(%esp)
  e3:	00 
  e4:	89 1c 24             	mov    %ebx,(%esp)
  e7:	e8 a4 05 00 00       	call   690 <strcmp>
  ec:	85 c0                	test   %eax,%eax
  ee:	74 53                	je     143 <main+0x143>
	else if(strcmp(arg, "perf2") == 0)
  f0:	c7 44 24 04 7c 0f 00 	movl   $0xf7c,0x4(%esp)
  f7:	00 
  f8:	89 1c 24             	mov    %ebx,(%esp)
  fb:	e8 90 05 00 00       	call   690 <strcmp>
 100:	85 c0                	test   %eax,%eax
 102:	75 4b                	jne    14f <main+0x14f>
		testPerf(2);
 104:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 10b:	e8 d0 04 00 00       	call   5e0 <testPerf>
            testExitWait();
 110:	e8 5b 00 00 00       	call   170 <testExitWait>
            testDetach();
 115:	e8 f6 00 00 00       	call   210 <testDetach>
            testWaitStat();
 11a:	e8 81 02 00 00       	call   3a0 <testWaitStat>
            testPolicy(1);
 11f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 126:	e8 25 03 00 00       	call   450 <testPolicy>
            testPolicy(2);
 12b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 132:	e8 19 03 00 00       	call   450 <testPolicy>
            testPolicy(3);
 137:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
 13e:	e8 0d 03 00 00       	call   450 <testPolicy>
            testPerf(1);
 143:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 14a:	e8 91 04 00 00       	call   5e0 <testPerf>
	else if(strcmp(arg, "perf3") == 0)
 14f:	c7 44 24 04 82 0f 00 	movl   $0xf82,0x4(%esp)
 156:	00 
 157:	89 1c 24             	mov    %ebx,(%esp)
 15a:	e8 31 05 00 00       	call   690 <strcmp>
 15f:	85 c0                	test   %eax,%eax
 161:	75 ad                	jne    110 <main+0x110>
		testPerf(3);
 163:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
 16a:	e8 71 04 00 00       	call   5e0 <testPerf>
 16f:	90                   	nop

00000170 <testExitWait>:
void testExitWait(){
 170:	55                   	push   %ebp
    printf(1, "----------test exit wait started\n");
 171:	b9 78 0d 00 00       	mov    $0xd78,%ecx
void testExitWait(){
 176:	89 e5                	mov    %esp,%ebp
 178:	57                   	push   %edi
 179:	56                   	push   %esi
    for (int i = 0; i < 5; i++) {
 17a:	31 f6                	xor    %esi,%esi
void testExitWait(){
 17c:	53                   	push   %ebx
 17d:	83 ec 2c             	sub    $0x2c,%esp
    printf(1, "----------test exit wait started\n");
 180:	89 4c 24 04          	mov    %ecx,0x4(%esp)
            wait(&status);
 184:	8d 7d e4             	lea    -0x1c(%ebp),%edi
    printf(1, "----------test exit wait started\n");
 187:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 18e:	e8 6d 08 00 00       	call   a00 <printf>
        pid = fork();
 193:	e8 f8 06 00 00       	call   890 <fork>
        if (pid > 0) {
 198:	85 c0                	test   %eax,%eax
        pid = fork();
 19a:	89 c3                	mov    %eax,%ebx
        if (pid > 0) {
 19c:	7e 53                	jle    1f1 <testExitWait+0x81>
            wait(&status);
 19e:	89 3c 24             	mov    %edi,(%esp)
    for (int i = 0; i < 5; i++) {
 1a1:	46                   	inc    %esi
            wait(&status);
 1a2:	e8 f9 06 00 00       	call   8a0 <wait>
			kill(pid);
 1a7:	89 1c 24             	mov    %ebx,(%esp)
 1aa:	e8 19 07 00 00       	call   8c8 <kill>
            printf(1, "process with pid %d exited with status %d\n", pid, status);
 1af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 1b2:	ba 9c 0d 00 00       	mov    $0xd9c,%edx
 1b7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 1bb:	89 54 24 04          	mov    %edx,0x4(%esp)
 1bf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1c6:	89 44 24 0c          	mov    %eax,0xc(%esp)
 1ca:	e8 31 08 00 00       	call   a00 <printf>
    for (int i = 0; i < 5; i++) {
 1cf:	83 fe 05             	cmp    $0x5,%esi
 1d2:	75 bf                	jne    193 <testExitWait+0x23>
    printf(1, "----------test exit wait ended\n");
 1d4:	b8 c8 0d 00 00       	mov    $0xdc8,%eax
 1d9:	89 44 24 04          	mov    %eax,0x4(%esp)
 1dd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1e4:	e8 17 08 00 00       	call   a00 <printf>
}
 1e9:	83 c4 2c             	add    $0x2c,%esp
 1ec:	5b                   	pop    %ebx
 1ed:	5e                   	pop    %esi
 1ee:	5f                   	pop    %edi
 1ef:	5d                   	pop    %ebp
 1f0:	c3                   	ret    
            sleep(5);
 1f1:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 1f8:	e8 2b 07 00 00       	call   928 <sleep>
            exit(i);
 1fd:	89 34 24             	mov    %esi,(%esp)
 200:	e8 93 06 00 00       	call   898 <exit>
 205:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <testDetach>:
void testDetach(){
 210:	55                   	push   %ebp
    printf(1, "----------test detach started\n");
 211:	b8 e8 0d 00 00       	mov    $0xde8,%eax
void testDetach(){
 216:	89 e5                	mov    %esp,%ebp
 218:	53                   	push   %ebx
 219:	83 ec 14             	sub    $0x14,%esp
    printf(1, "----------test detach started\n");
 21c:	89 44 24 04          	mov    %eax,0x4(%esp)
 220:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 227:	e8 d4 07 00 00       	call   a00 <printf>
    pid = fork(); 
 22c:	e8 5f 06 00 00       	call   890 <fork>
    if(pid > 0) {
 231:	85 c0                	test   %eax,%eax
    pid = fork(); 
 233:	89 c3                	mov    %eax,%ebx
    if(pid > 0) {
 235:	7e 67                	jle    29e <testDetach+0x8e>
        first_status = detach(pid); // status = 0
 237:	89 04 24             	mov    %eax,(%esp)
 23a:	e8 f9 06 00 00       	call   938 <detach>
        printf(1, "first_status: %d\n", first_status);
 23f:	ba 98 0e 00 00       	mov    $0xe98,%edx
 244:	89 54 24 04          	mov    %edx,0x4(%esp)
 248:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 24f:	89 44 24 08          	mov    %eax,0x8(%esp)
 253:	e8 a8 07 00 00       	call   a00 <printf>
        second_status = detach(pid); // status = -1, because this process has already detached this child, and it doesn’t have this child anymore.
 258:	89 1c 24             	mov    %ebx,(%esp)
 25b:	e8 d8 06 00 00       	call   938 <detach>
        printf(1, "second_status: %d\n", second_status);
 260:	b9 aa 0e 00 00       	mov    $0xeaa,%ecx
 265:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 269:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 270:	89 44 24 08          	mov    %eax,0x8(%esp)
 274:	e8 87 07 00 00       	call   a00 <printf>
        third_status = detach(77); // status = -1, because this process doesn’t have a child with this pid.
 279:	c7 04 24 4d 00 00 00 	movl   $0x4d,(%esp)
 280:	e8 b3 06 00 00       	call   938 <detach>
        printf(1, "third_status: %d\n", third_status);
 285:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 28c:	89 44 24 08          	mov    %eax,0x8(%esp)
 290:	b8 bd 0e 00 00       	mov    $0xebd,%eax
 295:	89 44 24 04          	mov    %eax,0x4(%esp)
 299:	e8 62 07 00 00       	call   a00 <printf>
	kill(pid);
 29e:	89 1c 24             	mov    %ebx,(%esp)
 2a1:	e8 22 06 00 00       	call   8c8 <kill>
    printf(1, "----------test detach ended\n");
 2a6:	b8 cf 0e 00 00       	mov    $0xecf,%eax
 2ab:	89 44 24 04          	mov    %eax,0x4(%esp)
 2af:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2b6:	e8 45 07 00 00       	call   a00 <printf>
}
 2bb:	83 c4 14             	add    $0x14,%esp
 2be:	5b                   	pop    %ebx
 2bf:	5d                   	pop    %ebp
 2c0:	c3                   	ret    
 2c1:	eb 0d                	jmp    2d0 <printPerf>
 2c3:	90                   	nop
 2c4:	90                   	nop
 2c5:	90                   	nop
 2c6:	90                   	nop
 2c7:	90                   	nop
 2c8:	90                   	nop
 2c9:	90                   	nop
 2ca:	90                   	nop
 2cb:	90                   	nop
 2cc:	90                   	nop
 2cd:	90                   	nop
 2ce:	90                   	nop
 2cf:	90                   	nop

000002d0 <printPerf>:
void printPerf(struct perf *performance) {
 2d0:	55                   	push   %ebp
    printf(1, "pref:\n");
 2d1:	b8 ec 0e 00 00       	mov    $0xeec,%eax
void printPerf(struct perf *performance) {
 2d6:	89 e5                	mov    %esp,%ebp
 2d8:	53                   	push   %ebx
 2d9:	83 ec 14             	sub    $0x14,%esp
 2dc:	8b 5d 08             	mov    0x8(%ebp),%ebx
    printf(1, "pref:\n");
 2df:	89 44 24 04          	mov    %eax,0x4(%esp)
 2e3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2ea:	e8 11 07 00 00       	call   a00 <printf>
    printf(1, "\tctime: %d\n", performance->ctime);
 2ef:	ba f3 0e 00 00       	mov    $0xef3,%edx
 2f4:	8b 03                	mov    (%ebx),%eax
 2f6:	89 54 24 04          	mov    %edx,0x4(%esp)
 2fa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 301:	89 44 24 08          	mov    %eax,0x8(%esp)
 305:	e8 f6 06 00 00       	call   a00 <printf>
    printf(1, "\tttime: %d\n", performance->ttime);
 30a:	8b 43 04             	mov    0x4(%ebx),%eax
 30d:	b9 ff 0e 00 00       	mov    $0xeff,%ecx
 312:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 316:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 31d:	89 44 24 08          	mov    %eax,0x8(%esp)
 321:	e8 da 06 00 00       	call   a00 <printf>
    printf(1, "\tstime: %d\n", performance->stime);
 326:	8b 43 08             	mov    0x8(%ebx),%eax
 329:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 330:	89 44 24 08          	mov    %eax,0x8(%esp)
 334:	b8 0b 0f 00 00       	mov    $0xf0b,%eax
 339:	89 44 24 04          	mov    %eax,0x4(%esp)
 33d:	e8 be 06 00 00       	call   a00 <printf>
    printf(1, "\tretime: %d\n", performance->retime);
 342:	8b 43 0c             	mov    0xc(%ebx),%eax
 345:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 34c:	89 44 24 08          	mov    %eax,0x8(%esp)
 350:	b8 17 0f 00 00       	mov    $0xf17,%eax
 355:	89 44 24 04          	mov    %eax,0x4(%esp)
 359:	e8 a2 06 00 00       	call   a00 <printf>
    printf(1, "\trutime: %d\n", performance->rutime);
 35e:	8b 43 10             	mov    0x10(%ebx),%eax
 361:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 368:	89 44 24 08          	mov    %eax,0x8(%esp)
 36c:	b8 24 0f 00 00       	mov    $0xf24,%eax
 371:	89 44 24 04          	mov    %eax,0x4(%esp)
 375:	e8 86 06 00 00       	call   a00 <printf>
    printf(1, "\n\tTurnaround time: %d\n", (performance->ttime - performance->ctime));
 37a:	8b 43 04             	mov    0x4(%ebx),%eax
 37d:	b9 31 0f 00 00       	mov    $0xf31,%ecx
 382:	8b 13                	mov    (%ebx),%edx
 384:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 388:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 38f:	29 d0                	sub    %edx,%eax
 391:	89 44 24 08          	mov    %eax,0x8(%esp)
 395:	e8 66 06 00 00       	call   a00 <printf>
}
 39a:	83 c4 14             	add    $0x14,%esp
 39d:	5b                   	pop    %ebx
 39e:	5d                   	pop    %ebp
 39f:	c3                   	ret    

000003a0 <testWaitStat>:
void testWaitStat(){
 3a0:	55                   	push   %ebp
    printf(1, "----------test wait_stat started\n");
 3a1:	b9 08 0e 00 00       	mov    $0xe08,%ecx
void testWaitStat(){
 3a6:	89 e5                	mov    %esp,%ebp
 3a8:	57                   	push   %edi
 3a9:	56                   	push   %esi
 3aa:	53                   	push   %ebx
    for (int i = 0; i < 5; i++) {
 3ab:	31 db                	xor    %ebx,%ebx
void testWaitStat(){
 3ad:	83 ec 3c             	sub    $0x3c,%esp
    printf(1, "----------test wait_stat started\n");
 3b0:	89 4c 24 04          	mov    %ecx,0x4(%esp)
            wait_stat(&status, &perf);
 3b4:	8d 75 d4             	lea    -0x2c(%ebp),%esi
    printf(1, "----------test wait_stat started\n");
 3b7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 3be:	e8 3d 06 00 00       	call   a00 <printf>
        pid = fork();
 3c3:	e8 c8 04 00 00       	call   890 <fork>
        if (pid > 0) {
 3c8:	85 c0                	test   %eax,%eax
        pid = fork();
 3ca:	89 c7                	mov    %eax,%edi
        if (pid > 0) {
 3cc:	7e 62                	jle    430 <testWaitStat+0x90>
            wait_stat(&status, &perf);
 3ce:	8d 45 d0             	lea    -0x30(%ebp),%eax
    for (int i = 0; i < 5; i++) {
 3d1:	43                   	inc    %ebx
            wait_stat(&status, &perf);
 3d2:	89 74 24 04          	mov    %esi,0x4(%esp)
 3d6:	89 04 24             	mov    %eax,(%esp)
 3d9:	e8 72 05 00 00       	call   950 <wait_stat>
            printf(1, "process with pid %d exited with status %d\n", pid, status);
 3de:	8b 45 d0             	mov    -0x30(%ebp),%eax
 3e1:	ba 9c 0d 00 00       	mov    $0xd9c,%edx
 3e6:	89 54 24 04          	mov    %edx,0x4(%esp)
 3ea:	89 7c 24 08          	mov    %edi,0x8(%esp)
 3ee:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 3f5:	89 44 24 0c          	mov    %eax,0xc(%esp)
 3f9:	e8 02 06 00 00       	call   a00 <printf>
			kill(pid);
 3fe:	89 3c 24             	mov    %edi,(%esp)
 401:	e8 c2 04 00 00       	call   8c8 <kill>
            printPerf(&perf);
 406:	89 34 24             	mov    %esi,(%esp)
 409:	e8 c2 fe ff ff       	call   2d0 <printPerf>
    for (int i = 0; i < 5; i++) {
 40e:	83 fb 05             	cmp    $0x5,%ebx
 411:	75 b0                	jne    3c3 <testWaitStat+0x23>
    printf(1, "----------test wait_stat ended\n");
 413:	b8 2c 0e 00 00       	mov    $0xe2c,%eax
 418:	89 44 24 04          	mov    %eax,0x4(%esp)
 41c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 423:	e8 d8 05 00 00       	call   a00 <printf>
}
 428:	83 c4 3c             	add    $0x3c,%esp
 42b:	5b                   	pop    %ebx
 42c:	5e                   	pop    %esi
 42d:	5f                   	pop    %edi
 42e:	5d                   	pop    %ebp
 42f:	c3                   	ret    
            sleep(5);
 430:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 437:	e8 ec 04 00 00       	call   928 <sleep>
            exit(i);
 43c:	89 1c 24             	mov    %ebx,(%esp)
 43f:	e8 54 04 00 00       	call   898 <exit>
 444:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 44a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000450 <testPolicy>:
void testPolicy(int policyNum) {
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	56                   	push   %esi
 455:	53                   	push   %ebx
 456:	83 ec 3c             	sub    $0x3c,%esp
    printf(1, "----------test policy %d started\n", policyNum);
 459:	8b 45 08             	mov    0x8(%ebp),%eax
 45c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 463:	89 44 24 08          	mov    %eax,0x8(%esp)
 467:	b8 4c 0e 00 00       	mov    $0xe4c,%eax
 46c:	89 44 24 04          	mov    %eax,0x4(%esp)
 470:	e8 8b 05 00 00       	call   a00 <printf>
    policy(policyNum);
 475:	8b 45 08             	mov    0x8(%ebp),%eax
 478:	89 04 24             	mov    %eax,(%esp)
 47b:	e8 c8 04 00 00       	call   948 <policy>
    pid1 = fork();
 480:	e8 0b 04 00 00       	call   890 <fork>
    if (pid1 > 0) {
 485:	85 c0                	test   %eax,%eax
 487:	7f 4a                	jg     4d3 <testPolicy+0x83>
 489:	31 db                	xor    %ebx,%ebx
                wait_stat(&status, &perf1);
 48b:	8d 7d d4             	lea    -0x2c(%ebp),%edi
 48e:	8d 75 d0             	lea    -0x30(%ebp),%esi
 491:	eb 0d                	jmp    4a0 <testPolicy+0x50>
 493:	90                   	nop
 494:	90                   	nop
 495:	90                   	nop
 496:	90                   	nop
 497:	90                   	nop
 498:	90                   	nop
 499:	90                   	nop
 49a:	90                   	nop
 49b:	90                   	nop
 49c:	90                   	nop
 49d:	90                   	nop
 49e:	90                   	nop
 49f:	90                   	nop
            pid = fork();
 4a0:	e8 eb 03 00 00       	call   890 <fork>
            if (pid > 0) {
 4a5:	85 c0                	test   %eax,%eax
 4a7:	7e 4c                	jle    4f5 <testPolicy+0xa5>
                sleep(5);
 4a9:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
        for (int a = 0; a < 100; ++a) {
 4b0:	43                   	inc    %ebx
                sleep(5);
 4b1:	e8 72 04 00 00       	call   928 <sleep>
                wait_stat(&status, &perf1);
 4b6:	89 7c 24 04          	mov    %edi,0x4(%esp)
 4ba:	89 34 24             	mov    %esi,(%esp)
 4bd:	e8 8e 04 00 00       	call   950 <wait_stat>
        for (int a = 0; a < 100; ++a) {
 4c2:	83 fb 64             	cmp    $0x64,%ebx
 4c5:	75 d9                	jne    4a0 <testPolicy+0x50>
        exit(0);
 4c7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4ce:	e8 c5 03 00 00       	call   898 <exit>
        wait_stat(&status1, &perf2);
 4d3:	8d 5d d4             	lea    -0x2c(%ebp),%ebx
 4d6:	8d 45 d0             	lea    -0x30(%ebp),%eax
 4d9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 4dd:	89 04 24             	mov    %eax,(%esp)
 4e0:	e8 6b 04 00 00       	call   950 <wait_stat>
        printPerf(&perf2);
 4e5:	89 1c 24             	mov    %ebx,(%esp)
 4e8:	e8 e3 fd ff ff       	call   2d0 <printPerf>
}
 4ed:	83 c4 3c             	add    $0x3c,%esp
 4f0:	5b                   	pop    %ebx
 4f1:	5e                   	pop    %esi
 4f2:	5f                   	pop    %edi
 4f3:	5d                   	pop    %ebp
 4f4:	c3                   	ret    
                int pr = a % 10;
 4f5:	89 d8                	mov    %ebx,%eax
 4f7:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
 4fc:	f7 e2                	mul    %edx
 4fe:	89 d0                	mov    %edx,%eax
 500:	c1 e8 03             	shr    $0x3,%eax
 503:	8d 04 80             	lea    (%eax,%eax,4),%eax
 506:	01 c0                	add    %eax,%eax
                if(pr == 0 && policyNum == 2)
 508:	29 c3                	sub    %eax,%ebx
 50a:	89 d8                	mov    %ebx,%eax
 50c:	75 0c                	jne    51a <testPolicy+0xca>
                    pr = 1;
 50e:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
 512:	ba 01 00 00 00       	mov    $0x1,%edx
 517:	0f 44 c2             	cmove  %edx,%eax
                priority(pr);
 51a:	89 04 24             	mov    %eax,(%esp)
 51d:	e8 1e 04 00 00       	call   940 <priority>
                sleep(5);
 522:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 529:	e8 fa 03 00 00       	call   928 <sleep>
                exit(0);
 52e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 535:	e8 5e 03 00 00       	call   898 <exit>
 53a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000540 <procCalculate>:
int procCalculate(int x) {
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	8b 4d 08             	mov    0x8(%ebp),%ecx
    for (int i = 0; i < x; ++i) {
 546:	85 c9                	test   %ecx,%ecx
 548:	7e 16                	jle    560 <procCalculate+0x20>
 54a:	31 d2                	xor    %edx,%edx
    int sum = 0;
 54c:	31 c0                	xor    %eax,%eax
 54e:	66 90                	xchg   %ax,%ax
    for (int i = 0; i < x; ++i) {
 550:	42                   	inc    %edx
 551:	01 c8                	add    %ecx,%eax
 553:	39 d1                	cmp    %edx,%ecx
 555:	75 f9                	jne    550 <procCalculate+0x10>
}
 557:	5d                   	pop    %ebp
 558:	c3                   	ret    
 559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    int sum = 0;
 560:	31 c0                	xor    %eax,%eax
}
 562:	5d                   	pop    %ebp
 563:	c3                   	ret    
 564:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 56a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000570 <createProcs>:
int createProcs(int nProcs, int pr){
 570:	55                   	push   %ebp
 571:	89 e5                	mov    %esp,%ebp
 573:	57                   	push   %edi
 574:	56                   	push   %esi
 575:	53                   	push   %ebx
 576:	83 ec 2c             	sub    $0x2c,%esp
 579:	8b 75 08             	mov    0x8(%ebp),%esi
    for (int i = 0; i < nProcs; i++){
 57c:	85 f6                	test   %esi,%esi
 57e:	7e 32                	jle    5b2 <createProcs+0x42>
 580:	31 db                	xor    %ebx,%ebx
            wait(&status_5);
 582:	8d 7d e4             	lea    -0x1c(%ebp),%edi
 585:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        int pid_5 = fork();
 590:	e8 fb 02 00 00       	call   890 <fork>
        if (pid_5 > 0) {
 595:	85 c0                	test   %eax,%eax
 597:	7e 23                	jle    5bc <createProcs+0x4c>
            sleep(10);
 599:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
    for (int i = 0; i < nProcs; i++){
 5a0:	43                   	inc    %ebx
            sleep(10);
 5a1:	e8 82 03 00 00       	call   928 <sleep>
            wait(&status_5);
 5a6:	89 3c 24             	mov    %edi,(%esp)
 5a9:	e8 f2 02 00 00       	call   8a0 <wait>
    for (int i = 0; i < nProcs; i++){
 5ae:	39 de                	cmp    %ebx,%esi
 5b0:	75 de                	jne    590 <createProcs+0x20>
}
 5b2:	83 c4 2c             	add    $0x2c,%esp
 5b5:	31 c0                	xor    %eax,%eax
 5b7:	5b                   	pop    %ebx
 5b8:	5e                   	pop    %esi
 5b9:	5f                   	pop    %edi
 5ba:	5d                   	pop    %ebp
 5bb:	c3                   	ret    
            priority(pr);
 5bc:	8b 45 0c             	mov    0xc(%ebp),%eax
 5bf:	89 04 24             	mov    %eax,(%esp)
 5c2:	e8 79 03 00 00       	call   940 <priority>
            exit(sum);
 5c7:	c7 04 24 00 00 64 a7 	movl   $0xa7640000,(%esp)
 5ce:	e8 c5 02 00 00       	call   898 <exit>
 5d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005e0 <testPerf>:
void testPerf(int policyNum){
 5e0:	55                   	push   %ebp
    printf(1, "----------test preformance %d started\n", policyNum);
 5e1:	b8 70 0e 00 00       	mov    $0xe70,%eax
void testPerf(int policyNum){
 5e6:	89 e5                	mov    %esp,%ebp
 5e8:	53                   	push   %ebx
 5e9:	83 ec 24             	sub    $0x24,%esp
 5ec:	8b 5d 08             	mov    0x8(%ebp),%ebx
    printf(1, "----------test preformance %d started\n", policyNum);
 5ef:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5fa:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 5fe:	e8 fd 03 00 00       	call   a00 <printf>
    policy(policyNum);
 603:	89 1c 24             	mov    %ebx,(%esp)
 606:	e8 3d 03 00 00       	call   948 <policy>
    int pid1 = fork();
 60b:	e8 80 02 00 00       	call   890 <fork>
    if (pid1 > 0) {
 610:	85 c0                	test   %eax,%eax
 612:	7e 17                	jle    62b <testPerf+0x4b>
            wait(&status5);
 614:	8d 45 f4             	lea    -0xc(%ebp),%eax
 617:	89 04 24             	mov    %eax,(%esp)
 61a:	e8 81 02 00 00       	call   8a0 <wait>
            exit(0);
 61f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 626:	e8 6d 02 00 00       	call   898 <exit>
        int pid5 = fork();
 62b:	e8 60 02 00 00       	call   890 <fork>
        if (pid5 > 0) {
 630:	85 c0                	test   %eax,%eax
 632:	7e 0e                	jle    642 <testPerf+0x62>
            sleep(10);
 634:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
 63b:	e8 e8 02 00 00       	call   928 <sleep>
 640:	eb d2                	jmp    614 <testPerf+0x34>
            createProcs(nProcs, 5);
 642:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
 649:	00 
 64a:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
 651:	e8 1a ff ff ff       	call   570 <createProcs>
            exit(0);
 656:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 65d:	e8 36 02 00 00       	call   898 <exit>
 662:	66 90                	xchg   %ax,%ax
 664:	66 90                	xchg   %ax,%ax
 666:	66 90                	xchg   %ax,%ax
 668:	66 90                	xchg   %ax,%ax
 66a:	66 90                	xchg   %ax,%ax
 66c:	66 90                	xchg   %ax,%ax
 66e:	66 90                	xchg   %ax,%ax

00000670 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	8b 45 08             	mov    0x8(%ebp),%eax
 676:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 679:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 67a:	89 c2                	mov    %eax,%edx
 67c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 680:	41                   	inc    %ecx
 681:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 685:	42                   	inc    %edx
 686:	84 db                	test   %bl,%bl
 688:	88 5a ff             	mov    %bl,-0x1(%edx)
 68b:	75 f3                	jne    680 <strcpy+0x10>
    ;
  return os;
}
 68d:	5b                   	pop    %ebx
 68e:	5d                   	pop    %ebp
 68f:	c3                   	ret    

00000690 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	8b 4d 08             	mov    0x8(%ebp),%ecx
 696:	53                   	push   %ebx
 697:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 69a:	0f b6 01             	movzbl (%ecx),%eax
 69d:	0f b6 13             	movzbl (%ebx),%edx
 6a0:	84 c0                	test   %al,%al
 6a2:	75 18                	jne    6bc <strcmp+0x2c>
 6a4:	eb 22                	jmp    6c8 <strcmp+0x38>
 6a6:	8d 76 00             	lea    0x0(%esi),%esi
 6a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 6b0:	41                   	inc    %ecx
  while(*p && *p == *q)
 6b1:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 6b4:	43                   	inc    %ebx
 6b5:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
 6b8:	84 c0                	test   %al,%al
 6ba:	74 0c                	je     6c8 <strcmp+0x38>
 6bc:	38 d0                	cmp    %dl,%al
 6be:	74 f0                	je     6b0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
 6c0:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 6c1:	29 d0                	sub    %edx,%eax
}
 6c3:	5d                   	pop    %ebp
 6c4:	c3                   	ret    
 6c5:	8d 76 00             	lea    0x0(%esi),%esi
 6c8:	5b                   	pop    %ebx
 6c9:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 6cb:	29 d0                	sub    %edx,%eax
}
 6cd:	5d                   	pop    %ebp
 6ce:	c3                   	ret    
 6cf:	90                   	nop

000006d0 <strlen>:

uint
strlen(const char *s)
{
 6d0:	55                   	push   %ebp
 6d1:	89 e5                	mov    %esp,%ebp
 6d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 6d6:	80 39 00             	cmpb   $0x0,(%ecx)
 6d9:	74 15                	je     6f0 <strlen+0x20>
 6db:	31 d2                	xor    %edx,%edx
 6dd:	8d 76 00             	lea    0x0(%esi),%esi
 6e0:	42                   	inc    %edx
 6e1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 6e5:	89 d0                	mov    %edx,%eax
 6e7:	75 f7                	jne    6e0 <strlen+0x10>
    ;
  return n;
}
 6e9:	5d                   	pop    %ebp
 6ea:	c3                   	ret    
 6eb:	90                   	nop
 6ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
 6f0:	31 c0                	xor    %eax,%eax
}
 6f2:	5d                   	pop    %ebp
 6f3:	c3                   	ret    
 6f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000700 <memset>:

void*
memset(void *dst, int c, uint n)
{
 700:	55                   	push   %ebp
 701:	89 e5                	mov    %esp,%ebp
 703:	8b 55 08             	mov    0x8(%ebp),%edx
 706:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 707:	8b 4d 10             	mov    0x10(%ebp),%ecx
 70a:	8b 45 0c             	mov    0xc(%ebp),%eax
 70d:	89 d7                	mov    %edx,%edi
 70f:	fc                   	cld    
 710:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 712:	5f                   	pop    %edi
 713:	89 d0                	mov    %edx,%eax
 715:	5d                   	pop    %ebp
 716:	c3                   	ret    
 717:	89 f6                	mov    %esi,%esi
 719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000720 <strchr>:

char*
strchr(const char *s, char c)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	8b 45 08             	mov    0x8(%ebp),%eax
 726:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 72a:	0f b6 10             	movzbl (%eax),%edx
 72d:	84 d2                	test   %dl,%dl
 72f:	74 1b                	je     74c <strchr+0x2c>
    if(*s == c)
 731:	38 d1                	cmp    %dl,%cl
 733:	75 0f                	jne    744 <strchr+0x24>
 735:	eb 17                	jmp    74e <strchr+0x2e>
 737:	89 f6                	mov    %esi,%esi
 739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 740:	38 ca                	cmp    %cl,%dl
 742:	74 0a                	je     74e <strchr+0x2e>
  for(; *s; s++)
 744:	40                   	inc    %eax
 745:	0f b6 10             	movzbl (%eax),%edx
 748:	84 d2                	test   %dl,%dl
 74a:	75 f4                	jne    740 <strchr+0x20>
      return (char*)s;
  return 0;
 74c:	31 c0                	xor    %eax,%eax
}
 74e:	5d                   	pop    %ebp
 74f:	c3                   	ret    

00000750 <gets>:

char*
gets(char *buf, int max)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	57                   	push   %edi
 754:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 755:	31 f6                	xor    %esi,%esi
{
 757:	53                   	push   %ebx
 758:	83 ec 3c             	sub    $0x3c,%esp
 75b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
 75e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 761:	eb 32                	jmp    795 <gets+0x45>
 763:	90                   	nop
 764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 768:	ba 01 00 00 00       	mov    $0x1,%edx
 76d:	89 54 24 08          	mov    %edx,0x8(%esp)
 771:	89 7c 24 04          	mov    %edi,0x4(%esp)
 775:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 77c:	e8 2f 01 00 00       	call   8b0 <read>
    if(cc < 1)
 781:	85 c0                	test   %eax,%eax
 783:	7e 19                	jle    79e <gets+0x4e>
      break;
    buf[i++] = c;
 785:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 789:	43                   	inc    %ebx
 78a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
 78d:	3c 0a                	cmp    $0xa,%al
 78f:	74 1f                	je     7b0 <gets+0x60>
 791:	3c 0d                	cmp    $0xd,%al
 793:	74 1b                	je     7b0 <gets+0x60>
  for(i=0; i+1 < max; ){
 795:	46                   	inc    %esi
 796:	3b 75 0c             	cmp    0xc(%ebp),%esi
 799:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 79c:	7c ca                	jl     768 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 79e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 7a1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 7a4:	8b 45 08             	mov    0x8(%ebp),%eax
 7a7:	83 c4 3c             	add    $0x3c,%esp
 7aa:	5b                   	pop    %ebx
 7ab:	5e                   	pop    %esi
 7ac:	5f                   	pop    %edi
 7ad:	5d                   	pop    %ebp
 7ae:	c3                   	ret    
 7af:	90                   	nop
 7b0:	8b 45 08             	mov    0x8(%ebp),%eax
 7b3:	01 c6                	add    %eax,%esi
 7b5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 7b8:	eb e4                	jmp    79e <gets+0x4e>
 7ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000007c0 <stat>:

int
stat(const char *n, struct stat *st)
{
 7c0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 7c1:	31 c0                	xor    %eax,%eax
{
 7c3:	89 e5                	mov    %esp,%ebp
 7c5:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 7c8:	89 44 24 04          	mov    %eax,0x4(%esp)
 7cc:	8b 45 08             	mov    0x8(%ebp),%eax
{
 7cf:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 7d2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 7d5:	89 04 24             	mov    %eax,(%esp)
 7d8:	e8 fb 00 00 00       	call   8d8 <open>
  if(fd < 0)
 7dd:	85 c0                	test   %eax,%eax
 7df:	78 2f                	js     810 <stat+0x50>
 7e1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 7e3:	8b 45 0c             	mov    0xc(%ebp),%eax
 7e6:	89 1c 24             	mov    %ebx,(%esp)
 7e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 7ed:	e8 fe 00 00 00       	call   8f0 <fstat>
  close(fd);
 7f2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 7f5:	89 c6                	mov    %eax,%esi
  close(fd);
 7f7:	e8 c4 00 00 00       	call   8c0 <close>
  return r;
}
 7fc:	89 f0                	mov    %esi,%eax
 7fe:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 801:	8b 75 fc             	mov    -0x4(%ebp),%esi
 804:	89 ec                	mov    %ebp,%esp
 806:	5d                   	pop    %ebp
 807:	c3                   	ret    
 808:	90                   	nop
 809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 810:	be ff ff ff ff       	mov    $0xffffffff,%esi
 815:	eb e5                	jmp    7fc <stat+0x3c>
 817:	89 f6                	mov    %esi,%esi
 819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000820 <atoi>:

int
atoi(const char *s)
{
 820:	55                   	push   %ebp
 821:	89 e5                	mov    %esp,%ebp
 823:	8b 4d 08             	mov    0x8(%ebp),%ecx
 826:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 827:	0f be 11             	movsbl (%ecx),%edx
 82a:	88 d0                	mov    %dl,%al
 82c:	2c 30                	sub    $0x30,%al
 82e:	3c 09                	cmp    $0x9,%al
  n = 0;
 830:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 835:	77 1e                	ja     855 <atoi+0x35>
 837:	89 f6                	mov    %esi,%esi
 839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 840:	41                   	inc    %ecx
 841:	8d 04 80             	lea    (%eax,%eax,4),%eax
 844:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 848:	0f be 11             	movsbl (%ecx),%edx
 84b:	88 d3                	mov    %dl,%bl
 84d:	80 eb 30             	sub    $0x30,%bl
 850:	80 fb 09             	cmp    $0x9,%bl
 853:	76 eb                	jbe    840 <atoi+0x20>
  return n;
}
 855:	5b                   	pop    %ebx
 856:	5d                   	pop    %ebp
 857:	c3                   	ret    
 858:	90                   	nop
 859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000860 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 860:	55                   	push   %ebp
 861:	89 e5                	mov    %esp,%ebp
 863:	56                   	push   %esi
 864:	8b 45 08             	mov    0x8(%ebp),%eax
 867:	53                   	push   %ebx
 868:	8b 5d 10             	mov    0x10(%ebp),%ebx
 86b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 86e:	85 db                	test   %ebx,%ebx
 870:	7e 1a                	jle    88c <memmove+0x2c>
 872:	31 d2                	xor    %edx,%edx
 874:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 87a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 880:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 884:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 887:	42                   	inc    %edx
  while(n-- > 0)
 888:	39 d3                	cmp    %edx,%ebx
 88a:	75 f4                	jne    880 <memmove+0x20>
  return vdst;
}
 88c:	5b                   	pop    %ebx
 88d:	5e                   	pop    %esi
 88e:	5d                   	pop    %ebp
 88f:	c3                   	ret    

00000890 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 890:	b8 01 00 00 00       	mov    $0x1,%eax
 895:	cd 40                	int    $0x40
 897:	c3                   	ret    

00000898 <exit>:
SYSCALL(exit)
 898:	b8 02 00 00 00       	mov    $0x2,%eax
 89d:	cd 40                	int    $0x40
 89f:	c3                   	ret    

000008a0 <wait>:
SYSCALL(wait)
 8a0:	b8 03 00 00 00       	mov    $0x3,%eax
 8a5:	cd 40                	int    $0x40
 8a7:	c3                   	ret    

000008a8 <pipe>:
SYSCALL(pipe)
 8a8:	b8 04 00 00 00       	mov    $0x4,%eax
 8ad:	cd 40                	int    $0x40
 8af:	c3                   	ret    

000008b0 <read>:
SYSCALL(read)
 8b0:	b8 05 00 00 00       	mov    $0x5,%eax
 8b5:	cd 40                	int    $0x40
 8b7:	c3                   	ret    

000008b8 <write>:
SYSCALL(write)
 8b8:	b8 10 00 00 00       	mov    $0x10,%eax
 8bd:	cd 40                	int    $0x40
 8bf:	c3                   	ret    

000008c0 <close>:
SYSCALL(close)
 8c0:	b8 15 00 00 00       	mov    $0x15,%eax
 8c5:	cd 40                	int    $0x40
 8c7:	c3                   	ret    

000008c8 <kill>:
SYSCALL(kill)
 8c8:	b8 06 00 00 00       	mov    $0x6,%eax
 8cd:	cd 40                	int    $0x40
 8cf:	c3                   	ret    

000008d0 <exec>:
SYSCALL(exec)
 8d0:	b8 07 00 00 00       	mov    $0x7,%eax
 8d5:	cd 40                	int    $0x40
 8d7:	c3                   	ret    

000008d8 <open>:
SYSCALL(open)
 8d8:	b8 0f 00 00 00       	mov    $0xf,%eax
 8dd:	cd 40                	int    $0x40
 8df:	c3                   	ret    

000008e0 <mknod>:
SYSCALL(mknod)
 8e0:	b8 11 00 00 00       	mov    $0x11,%eax
 8e5:	cd 40                	int    $0x40
 8e7:	c3                   	ret    

000008e8 <unlink>:
SYSCALL(unlink)
 8e8:	b8 12 00 00 00       	mov    $0x12,%eax
 8ed:	cd 40                	int    $0x40
 8ef:	c3                   	ret    

000008f0 <fstat>:
SYSCALL(fstat)
 8f0:	b8 08 00 00 00       	mov    $0x8,%eax
 8f5:	cd 40                	int    $0x40
 8f7:	c3                   	ret    

000008f8 <link>:
SYSCALL(link)
 8f8:	b8 13 00 00 00       	mov    $0x13,%eax
 8fd:	cd 40                	int    $0x40
 8ff:	c3                   	ret    

00000900 <mkdir>:
SYSCALL(mkdir)
 900:	b8 14 00 00 00       	mov    $0x14,%eax
 905:	cd 40                	int    $0x40
 907:	c3                   	ret    

00000908 <chdir>:
SYSCALL(chdir)
 908:	b8 09 00 00 00       	mov    $0x9,%eax
 90d:	cd 40                	int    $0x40
 90f:	c3                   	ret    

00000910 <dup>:
SYSCALL(dup)
 910:	b8 0a 00 00 00       	mov    $0xa,%eax
 915:	cd 40                	int    $0x40
 917:	c3                   	ret    

00000918 <getpid>:
SYSCALL(getpid)
 918:	b8 0b 00 00 00       	mov    $0xb,%eax
 91d:	cd 40                	int    $0x40
 91f:	c3                   	ret    

00000920 <sbrk>:
SYSCALL(sbrk)
 920:	b8 0c 00 00 00       	mov    $0xc,%eax
 925:	cd 40                	int    $0x40
 927:	c3                   	ret    

00000928 <sleep>:
SYSCALL(sleep)
 928:	b8 0d 00 00 00       	mov    $0xd,%eax
 92d:	cd 40                	int    $0x40
 92f:	c3                   	ret    

00000930 <uptime>:
SYSCALL(uptime)
 930:	b8 0e 00 00 00       	mov    $0xe,%eax
 935:	cd 40                	int    $0x40
 937:	c3                   	ret    

00000938 <detach>:
SYSCALL(detach)
 938:	b8 16 00 00 00       	mov    $0x16,%eax
 93d:	cd 40                	int    $0x40
 93f:	c3                   	ret    

00000940 <priority>:
SYSCALL(priority)
 940:	b8 17 00 00 00       	mov    $0x17,%eax
 945:	cd 40                	int    $0x40
 947:	c3                   	ret    

00000948 <policy>:
SYSCALL(policy)
 948:	b8 18 00 00 00       	mov    $0x18,%eax
 94d:	cd 40                	int    $0x40
 94f:	c3                   	ret    

00000950 <wait_stat>:
SYSCALL(wait_stat)
 950:	b8 19 00 00 00       	mov    $0x19,%eax
 955:	cd 40                	int    $0x40
 957:	c3                   	ret    
 958:	66 90                	xchg   %ax,%ax
 95a:	66 90                	xchg   %ax,%ax
 95c:	66 90                	xchg   %ax,%ax
 95e:	66 90                	xchg   %ax,%ax

00000960 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 960:	55                   	push   %ebp
 961:	89 e5                	mov    %esp,%ebp
 963:	57                   	push   %edi
 964:	56                   	push   %esi
 965:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 966:	89 d3                	mov    %edx,%ebx
 968:	c1 eb 1f             	shr    $0x1f,%ebx
{
 96b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 96e:	84 db                	test   %bl,%bl
{
 970:	89 45 c0             	mov    %eax,-0x40(%ebp)
 973:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 975:	74 79                	je     9f0 <printint+0x90>
 977:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 97b:	74 73                	je     9f0 <printint+0x90>
    neg = 1;
    x = -xx;
 97d:	f7 d8                	neg    %eax
    neg = 1;
 97f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 986:	31 f6                	xor    %esi,%esi
 988:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 98b:	eb 05                	jmp    992 <printint+0x32>
 98d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 990:	89 fe                	mov    %edi,%esi
 992:	31 d2                	xor    %edx,%edx
 994:	f7 f1                	div    %ecx
 996:	8d 7e 01             	lea    0x1(%esi),%edi
 999:	0f b6 92 90 0f 00 00 	movzbl 0xf90(%edx),%edx
  }while((x /= base) != 0);
 9a0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 9a2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 9a5:	75 e9                	jne    990 <printint+0x30>
  if(neg)
 9a7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 9aa:	85 d2                	test   %edx,%edx
 9ac:	74 08                	je     9b6 <printint+0x56>
    buf[i++] = '-';
 9ae:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 9b3:	8d 7e 02             	lea    0x2(%esi),%edi
 9b6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 9ba:	8b 7d c0             	mov    -0x40(%ebp),%edi
 9bd:	8d 76 00             	lea    0x0(%esi),%esi
 9c0:	0f b6 06             	movzbl (%esi),%eax
 9c3:	4e                   	dec    %esi
  write(fd, &c, 1);
 9c4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 9c8:	89 3c 24             	mov    %edi,(%esp)
 9cb:	88 45 d7             	mov    %al,-0x29(%ebp)
 9ce:	b8 01 00 00 00       	mov    $0x1,%eax
 9d3:	89 44 24 08          	mov    %eax,0x8(%esp)
 9d7:	e8 dc fe ff ff       	call   8b8 <write>

  while(--i >= 0)
 9dc:	39 de                	cmp    %ebx,%esi
 9de:	75 e0                	jne    9c0 <printint+0x60>
    putc(fd, buf[i]);
}
 9e0:	83 c4 4c             	add    $0x4c,%esp
 9e3:	5b                   	pop    %ebx
 9e4:	5e                   	pop    %esi
 9e5:	5f                   	pop    %edi
 9e6:	5d                   	pop    %ebp
 9e7:	c3                   	ret    
 9e8:	90                   	nop
 9e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 9f0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 9f7:	eb 8d                	jmp    986 <printint+0x26>
 9f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000a00 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 a00:	55                   	push   %ebp
 a01:	89 e5                	mov    %esp,%ebp
 a03:	57                   	push   %edi
 a04:	56                   	push   %esi
 a05:	53                   	push   %ebx
 a06:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 a09:	8b 75 0c             	mov    0xc(%ebp),%esi
 a0c:	0f b6 1e             	movzbl (%esi),%ebx
 a0f:	84 db                	test   %bl,%bl
 a11:	0f 84 d1 00 00 00    	je     ae8 <printf+0xe8>
  state = 0;
 a17:	31 ff                	xor    %edi,%edi
 a19:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 a1a:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 a1d:	89 fa                	mov    %edi,%edx
 a1f:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 a22:	89 45 d0             	mov    %eax,-0x30(%ebp)
 a25:	eb 41                	jmp    a68 <printf+0x68>
 a27:	89 f6                	mov    %esi,%esi
 a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 a30:	83 f8 25             	cmp    $0x25,%eax
 a33:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 a36:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 a3b:	74 1e                	je     a5b <printf+0x5b>
  write(fd, &c, 1);
 a3d:	b8 01 00 00 00       	mov    $0x1,%eax
 a42:	89 44 24 08          	mov    %eax,0x8(%esp)
 a46:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 a49:	89 44 24 04          	mov    %eax,0x4(%esp)
 a4d:	89 3c 24             	mov    %edi,(%esp)
 a50:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 a53:	e8 60 fe ff ff       	call   8b8 <write>
 a58:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 a5b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 a5c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 a60:	84 db                	test   %bl,%bl
 a62:	0f 84 80 00 00 00    	je     ae8 <printf+0xe8>
    if(state == 0){
 a68:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 a6a:	0f be cb             	movsbl %bl,%ecx
 a6d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 a70:	74 be                	je     a30 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 a72:	83 fa 25             	cmp    $0x25,%edx
 a75:	75 e4                	jne    a5b <printf+0x5b>
      if(c == 'd'){
 a77:	83 f8 64             	cmp    $0x64,%eax
 a7a:	0f 84 f0 00 00 00    	je     b70 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 a80:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 a86:	83 f9 70             	cmp    $0x70,%ecx
 a89:	74 65                	je     af0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 a8b:	83 f8 73             	cmp    $0x73,%eax
 a8e:	0f 84 8c 00 00 00    	je     b20 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 a94:	83 f8 63             	cmp    $0x63,%eax
 a97:	0f 84 13 01 00 00    	je     bb0 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 a9d:	83 f8 25             	cmp    $0x25,%eax
 aa0:	0f 84 e2 00 00 00    	je     b88 <printf+0x188>
  write(fd, &c, 1);
 aa6:	b8 01 00 00 00       	mov    $0x1,%eax
 aab:	46                   	inc    %esi
 aac:	89 44 24 08          	mov    %eax,0x8(%esp)
 ab0:	8d 45 e7             	lea    -0x19(%ebp),%eax
 ab3:	89 44 24 04          	mov    %eax,0x4(%esp)
 ab7:	89 3c 24             	mov    %edi,(%esp)
 aba:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 abe:	e8 f5 fd ff ff       	call   8b8 <write>
 ac3:	ba 01 00 00 00       	mov    $0x1,%edx
 ac8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 acb:	89 54 24 08          	mov    %edx,0x8(%esp)
 acf:	89 44 24 04          	mov    %eax,0x4(%esp)
 ad3:	89 3c 24             	mov    %edi,(%esp)
 ad6:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 ad9:	e8 da fd ff ff       	call   8b8 <write>
  for(i = 0; fmt[i]; i++){
 ade:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 ae2:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 ae4:	84 db                	test   %bl,%bl
 ae6:	75 80                	jne    a68 <printf+0x68>
    }
  }
}
 ae8:	83 c4 3c             	add    $0x3c,%esp
 aeb:	5b                   	pop    %ebx
 aec:	5e                   	pop    %esi
 aed:	5f                   	pop    %edi
 aee:	5d                   	pop    %ebp
 aef:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 af0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 af7:	b9 10 00 00 00       	mov    $0x10,%ecx
 afc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 aff:	89 f8                	mov    %edi,%eax
 b01:	8b 13                	mov    (%ebx),%edx
 b03:	e8 58 fe ff ff       	call   960 <printint>
        ap++;
 b08:	89 d8                	mov    %ebx,%eax
      state = 0;
 b0a:	31 d2                	xor    %edx,%edx
        ap++;
 b0c:	83 c0 04             	add    $0x4,%eax
 b0f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 b12:	e9 44 ff ff ff       	jmp    a5b <printf+0x5b>
 b17:	89 f6                	mov    %esi,%esi
 b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 b20:	8b 45 d0             	mov    -0x30(%ebp),%eax
 b23:	8b 10                	mov    (%eax),%edx
        ap++;
 b25:	83 c0 04             	add    $0x4,%eax
 b28:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 b2b:	85 d2                	test   %edx,%edx
 b2d:	0f 84 aa 00 00 00    	je     bdd <printf+0x1dd>
        while(*s != 0){
 b33:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 b36:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 b38:	84 c0                	test   %al,%al
 b3a:	74 27                	je     b63 <printf+0x163>
 b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 b40:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 b43:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 b48:	43                   	inc    %ebx
  write(fd, &c, 1);
 b49:	89 44 24 08          	mov    %eax,0x8(%esp)
 b4d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 b50:	89 44 24 04          	mov    %eax,0x4(%esp)
 b54:	89 3c 24             	mov    %edi,(%esp)
 b57:	e8 5c fd ff ff       	call   8b8 <write>
        while(*s != 0){
 b5c:	0f b6 03             	movzbl (%ebx),%eax
 b5f:	84 c0                	test   %al,%al
 b61:	75 dd                	jne    b40 <printf+0x140>
      state = 0;
 b63:	31 d2                	xor    %edx,%edx
 b65:	e9 f1 fe ff ff       	jmp    a5b <printf+0x5b>
 b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 b70:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 b77:	b9 0a 00 00 00       	mov    $0xa,%ecx
 b7c:	e9 7b ff ff ff       	jmp    afc <printf+0xfc>
 b81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 b88:	b9 01 00 00 00       	mov    $0x1,%ecx
 b8d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 b90:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 b94:	89 44 24 04          	mov    %eax,0x4(%esp)
 b98:	89 3c 24             	mov    %edi,(%esp)
 b9b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 b9e:	e8 15 fd ff ff       	call   8b8 <write>
      state = 0;
 ba3:	31 d2                	xor    %edx,%edx
 ba5:	e9 b1 fe ff ff       	jmp    a5b <printf+0x5b>
 baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 bb0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 bb3:	8b 03                	mov    (%ebx),%eax
        ap++;
 bb5:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 bb8:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 bbb:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 bbe:	b8 01 00 00 00       	mov    $0x1,%eax
 bc3:	89 44 24 08          	mov    %eax,0x8(%esp)
 bc7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 bca:	89 44 24 04          	mov    %eax,0x4(%esp)
 bce:	e8 e5 fc ff ff       	call   8b8 <write>
      state = 0;
 bd3:	31 d2                	xor    %edx,%edx
        ap++;
 bd5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 bd8:	e9 7e fe ff ff       	jmp    a5b <printf+0x5b>
          s = "(null)";
 bdd:	bb 88 0f 00 00       	mov    $0xf88,%ebx
        while(*s != 0){
 be2:	b0 28                	mov    $0x28,%al
 be4:	e9 57 ff ff ff       	jmp    b40 <printf+0x140>
 be9:	66 90                	xchg   %ax,%ax
 beb:	66 90                	xchg   %ax,%ax
 bed:	66 90                	xchg   %ax,%ax
 bef:	90                   	nop

00000bf0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 bf0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bf1:	a1 68 13 00 00       	mov    0x1368,%eax
{
 bf6:	89 e5                	mov    %esp,%ebp
 bf8:	57                   	push   %edi
 bf9:	56                   	push   %esi
 bfa:	53                   	push   %ebx
 bfb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 bfe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 c01:	eb 0d                	jmp    c10 <free+0x20>
 c03:	90                   	nop
 c04:	90                   	nop
 c05:	90                   	nop
 c06:	90                   	nop
 c07:	90                   	nop
 c08:	90                   	nop
 c09:	90                   	nop
 c0a:	90                   	nop
 c0b:	90                   	nop
 c0c:	90                   	nop
 c0d:	90                   	nop
 c0e:	90                   	nop
 c0f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c10:	39 c8                	cmp    %ecx,%eax
 c12:	8b 10                	mov    (%eax),%edx
 c14:	73 32                	jae    c48 <free+0x58>
 c16:	39 d1                	cmp    %edx,%ecx
 c18:	72 04                	jb     c1e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c1a:	39 d0                	cmp    %edx,%eax
 c1c:	72 32                	jb     c50 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 c1e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 c21:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 c24:	39 fa                	cmp    %edi,%edx
 c26:	74 30                	je     c58 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 c28:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 c2b:	8b 50 04             	mov    0x4(%eax),%edx
 c2e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 c31:	39 f1                	cmp    %esi,%ecx
 c33:	74 3c                	je     c71 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 c35:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 c37:	5b                   	pop    %ebx
  freep = p;
 c38:	a3 68 13 00 00       	mov    %eax,0x1368
}
 c3d:	5e                   	pop    %esi
 c3e:	5f                   	pop    %edi
 c3f:	5d                   	pop    %ebp
 c40:	c3                   	ret    
 c41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c48:	39 d0                	cmp    %edx,%eax
 c4a:	72 04                	jb     c50 <free+0x60>
 c4c:	39 d1                	cmp    %edx,%ecx
 c4e:	72 ce                	jb     c1e <free+0x2e>
{
 c50:	89 d0                	mov    %edx,%eax
 c52:	eb bc                	jmp    c10 <free+0x20>
 c54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 c58:	8b 7a 04             	mov    0x4(%edx),%edi
 c5b:	01 fe                	add    %edi,%esi
 c5d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 c60:	8b 10                	mov    (%eax),%edx
 c62:	8b 12                	mov    (%edx),%edx
 c64:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 c67:	8b 50 04             	mov    0x4(%eax),%edx
 c6a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 c6d:	39 f1                	cmp    %esi,%ecx
 c6f:	75 c4                	jne    c35 <free+0x45>
    p->s.size += bp->s.size;
 c71:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 c74:	a3 68 13 00 00       	mov    %eax,0x1368
    p->s.size += bp->s.size;
 c79:	01 ca                	add    %ecx,%edx
 c7b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 c7e:	8b 53 f8             	mov    -0x8(%ebx),%edx
 c81:	89 10                	mov    %edx,(%eax)
}
 c83:	5b                   	pop    %ebx
 c84:	5e                   	pop    %esi
 c85:	5f                   	pop    %edi
 c86:	5d                   	pop    %ebp
 c87:	c3                   	ret    
 c88:	90                   	nop
 c89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000c90 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c90:	55                   	push   %ebp
 c91:	89 e5                	mov    %esp,%ebp
 c93:	57                   	push   %edi
 c94:	56                   	push   %esi
 c95:	53                   	push   %ebx
 c96:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c99:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 c9c:	8b 15 68 13 00 00    	mov    0x1368,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ca2:	8d 78 07             	lea    0x7(%eax),%edi
 ca5:	c1 ef 03             	shr    $0x3,%edi
 ca8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 ca9:	85 d2                	test   %edx,%edx
 cab:	0f 84 8f 00 00 00    	je     d40 <malloc+0xb0>
 cb1:	8b 02                	mov    (%edx),%eax
 cb3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 cb6:	39 cf                	cmp    %ecx,%edi
 cb8:	76 66                	jbe    d20 <malloc+0x90>
 cba:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 cc0:	bb 00 10 00 00       	mov    $0x1000,%ebx
 cc5:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 cc8:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 ccf:	eb 10                	jmp    ce1 <malloc+0x51>
 cd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cd8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 cda:	8b 48 04             	mov    0x4(%eax),%ecx
 cdd:	39 f9                	cmp    %edi,%ecx
 cdf:	73 3f                	jae    d20 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ce1:	39 05 68 13 00 00    	cmp    %eax,0x1368
 ce7:	89 c2                	mov    %eax,%edx
 ce9:	75 ed                	jne    cd8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 ceb:	89 34 24             	mov    %esi,(%esp)
 cee:	e8 2d fc ff ff       	call   920 <sbrk>
  if(p == (char*)-1)
 cf3:	83 f8 ff             	cmp    $0xffffffff,%eax
 cf6:	74 18                	je     d10 <malloc+0x80>
  hp->s.size = nu;
 cf8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 cfb:	83 c0 08             	add    $0x8,%eax
 cfe:	89 04 24             	mov    %eax,(%esp)
 d01:	e8 ea fe ff ff       	call   bf0 <free>
  return freep;
 d06:	8b 15 68 13 00 00    	mov    0x1368,%edx
      if((p = morecore(nunits)) == 0)
 d0c:	85 d2                	test   %edx,%edx
 d0e:	75 c8                	jne    cd8 <malloc+0x48>
        return 0;
  }
}
 d10:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 d13:	31 c0                	xor    %eax,%eax
}
 d15:	5b                   	pop    %ebx
 d16:	5e                   	pop    %esi
 d17:	5f                   	pop    %edi
 d18:	5d                   	pop    %ebp
 d19:	c3                   	ret    
 d1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 d20:	39 cf                	cmp    %ecx,%edi
 d22:	74 4c                	je     d70 <malloc+0xe0>
        p->s.size -= nunits;
 d24:	29 f9                	sub    %edi,%ecx
 d26:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 d29:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 d2c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 d2f:	89 15 68 13 00 00    	mov    %edx,0x1368
}
 d35:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 d38:	83 c0 08             	add    $0x8,%eax
}
 d3b:	5b                   	pop    %ebx
 d3c:	5e                   	pop    %esi
 d3d:	5f                   	pop    %edi
 d3e:	5d                   	pop    %ebp
 d3f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 d40:	b8 6c 13 00 00       	mov    $0x136c,%eax
 d45:	ba 6c 13 00 00       	mov    $0x136c,%edx
    base.s.size = 0;
 d4a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 d4c:	a3 68 13 00 00       	mov    %eax,0x1368
    base.s.size = 0;
 d51:	b8 6c 13 00 00       	mov    $0x136c,%eax
    base.s.ptr = freep = prevp = &base;
 d56:	89 15 6c 13 00 00    	mov    %edx,0x136c
    base.s.size = 0;
 d5c:	89 0d 70 13 00 00    	mov    %ecx,0x1370
 d62:	e9 53 ff ff ff       	jmp    cba <malloc+0x2a>
 d67:	89 f6                	mov    %esi,%esi
 d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 d70:	8b 08                	mov    (%eax),%ecx
 d72:	89 0a                	mov    %ecx,(%edx)
 d74:	eb b9                	jmp    d2f <malloc+0x9f>
