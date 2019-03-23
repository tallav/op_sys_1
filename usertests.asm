
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return randstate;
}

int
main(int argc, char *argv[])
{
       0:	55                   	push   %ebp
  printf(1, "usertests starting\n");
       1:	b8 52 55 00 00       	mov    $0x5552,%eax
{
       6:	89 e5                	mov    %esp,%ebp
       8:	83 e4 f0             	and    $0xfffffff0,%esp
       b:	83 ec 10             	sub    $0x10,%esp
  printf(1, "usertests starting\n");
       e:	89 44 24 04          	mov    %eax,0x4(%esp)
      12:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      19:	e8 c2 41 00 00       	call   41e0 <printf>

  if(open("usertests.ran", 0) >= 0){
      1e:	31 d2                	xor    %edx,%edx
      20:	89 54 24 04          	mov    %edx,0x4(%esp)
      24:	c7 04 24 66 55 00 00 	movl   $0x5566,(%esp)
      2b:	e8 88 40 00 00       	call   40b8 <open>
      30:	85 c0                	test   %eax,%eax
      32:	78 20                	js     54 <main+0x54>
    printf(1, "already ran user tests -- rebuild fs.img\n");
      34:	c7 44 24 04 d0 5c 00 	movl   $0x5cd0,0x4(%esp)
      3b:	00 
      3c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      43:	e8 98 41 00 00       	call   41e0 <printf>
    exit(0);
      48:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      4f:	e8 24 40 00 00       	call   4078 <exit>
  }
  close(open("usertests.ran", O_CREATE));
      54:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
      5b:	00 
      5c:	c7 04 24 66 55 00 00 	movl   $0x5566,(%esp)
      63:	e8 50 40 00 00       	call   40b8 <open>
      68:	89 04 24             	mov    %eax,(%esp)
      6b:	e8 30 40 00 00       	call   40a0 <close>

  argptest();
      70:	e8 2b 3d 00 00       	call   3da0 <argptest>
  createdelete();
      75:	e8 e6 12 00 00       	call   1360 <createdelete>
  linkunlink();
      7a:	e8 91 1d 00 00       	call   1e10 <linkunlink>
      7f:	90                   	nop
  concreate();
      80:	e8 1b 1a 00 00       	call   1aa0 <concreate>
  fourfiles();
      85:	e8 66 10 00 00       	call   10f0 <fourfiles>
  sharedfd();
      8a:	e8 51 0e 00 00       	call   ee0 <sharedfd>
      8f:	90                   	nop

  bigargtest();
      90:	e8 5b 39 00 00       	call   39f0 <bigargtest>
  bigwrite();
      95:	e8 76 28 00 00       	call   2910 <bigwrite>
  bigargtest();
      9a:	e8 51 39 00 00       	call   39f0 <bigargtest>
      9f:	90                   	nop
  bsstest();
      a0:	e8 cb 38 00 00       	call   3970 <bsstest>
  sbrktest();
      a5:	e8 d6 33 00 00       	call   3480 <sbrktest>
  validatetest();
      aa:	e8 01 38 00 00       	call   38b0 <validatetest>
      af:	90                   	nop

  opentest();
      b0:	e8 1b 03 00 00       	call   3d0 <opentest>
  writetest();
      b5:	e8 b6 03 00 00       	call   470 <writetest>
  writetest1();
      ba:	e8 91 05 00 00       	call   650 <writetest1>
      bf:	90                   	nop
  createtest();
      c0:	e8 5b 07 00 00       	call   820 <createtest>

  openiputtest();
      c5:	e8 16 02 00 00       	call   2e0 <openiputtest>
  exitiputtest();
      ca:	e8 31 01 00 00       	call   200 <exitiputtest>
      cf:	90                   	nop
  iputtest();
      d0:	e8 6b 00 00 00       	call   140 <iputtest>

  mem();
      d5:	e8 16 0d 00 00       	call   df0 <mem>
  pipe1();
      da:	e8 11 09 00 00       	call   9f0 <pipe1>
      df:	90                   	nop
  preempt();
      e0:	e8 fb 0a 00 00       	call   be0 <preempt>
  exitwait();
      e5:	e8 66 0c 00 00       	call   d50 <exitwait>

  rmdot();
      ea:	e8 01 2d 00 00       	call   2df0 <rmdot>
      ef:	90                   	nop
  fourteen();
      f0:	e8 6b 2b 00 00       	call   2c60 <fourteen>
  bigfile();
      f5:	e8 26 29 00 00       	call   2a20 <bigfile>
  subdir();
      fa:	e8 81 1f 00 00       	call   2080 <subdir>
      ff:	90                   	nop
  linktest();
     100:	e8 fb 16 00 00       	call   1800 <linktest>
  unlinkread();
     105:	e8 e6 14 00 00       	call   15f0 <unlinkread>
  dirfile();
     10a:	e8 b1 2e 00 00       	call   2fc0 <dirfile>
     10f:	90                   	nop
  iref();
     110:	e8 2b 31 00 00       	call   3240 <iref>
  forktest();
     115:	e8 66 32 00 00       	call   3380 <forktest>
  bigdir(); // slow
     11a:	e8 01 1e 00 00       	call   1f20 <bigdir>
     11f:	90                   	nop

  uio();
     120:	e8 db 3b 00 00       	call   3d00 <uio>

  exectest();
     125:	e8 66 08 00 00       	call   990 <exectest>

  exit(0);
     12a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     131:	e8 42 3f 00 00       	call   4078 <exit>
     136:	66 90                	xchg   %ax,%ax
     138:	66 90                	xchg   %ax,%ax
     13a:	66 90                	xchg   %ax,%ax
     13c:	66 90                	xchg   %ax,%ax
     13e:	66 90                	xchg   %ax,%ax

00000140 <iputtest>:
{
     140:	55                   	push   %ebp
  printf(stdout, "iput test\n");
     141:	ba ec 45 00 00       	mov    $0x45ec,%edx
{
     146:	89 e5                	mov    %esp,%ebp
     148:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "iput test\n");
     14b:	a1 0c 66 00 00       	mov    0x660c,%eax
     150:	89 54 24 04          	mov    %edx,0x4(%esp)
     154:	89 04 24             	mov    %eax,(%esp)
     157:	e8 84 40 00 00       	call   41e0 <printf>
  if(mkdir("iputdir") < 0){
     15c:	c7 04 24 7f 45 00 00 	movl   $0x457f,(%esp)
     163:	e8 78 3f 00 00       	call   40e0 <mkdir>
     168:	85 c0                	test   %eax,%eax
     16a:	78 48                	js     1b4 <iputtest+0x74>
  if(chdir("iputdir") < 0){
     16c:	c7 04 24 7f 45 00 00 	movl   $0x457f,(%esp)
     173:	e8 70 3f 00 00       	call   40e8 <chdir>
     178:	85 c0                	test   %eax,%eax
     17a:	78 6d                	js     1e9 <iputtest+0xa9>
  if(unlink("../iputdir") < 0){
     17c:	c7 04 24 7c 45 00 00 	movl   $0x457c,(%esp)
     183:	e8 40 3f 00 00       	call   40c8 <unlink>
     188:	85 c0                	test   %eax,%eax
     18a:	78 53                	js     1df <iputtest+0x9f>
  if(chdir("/") < 0){
     18c:	c7 04 24 a1 45 00 00 	movl   $0x45a1,(%esp)
     193:	e8 50 3f 00 00       	call   40e8 <chdir>
     198:	85 c0                	test   %eax,%eax
     19a:	78 39                	js     1d5 <iputtest+0x95>
  printf(stdout, "iput test ok\n");
     19c:	b8 24 46 00 00       	mov    $0x4624,%eax
     1a1:	89 44 24 04          	mov    %eax,0x4(%esp)
     1a5:	a1 0c 66 00 00       	mov    0x660c,%eax
     1aa:	89 04 24             	mov    %eax,(%esp)
     1ad:	e8 2e 40 00 00       	call   41e0 <printf>
}
     1b2:	c9                   	leave  
     1b3:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
     1b4:	c7 44 24 04 58 45 00 	movl   $0x4558,0x4(%esp)
     1bb:	00 
    printf(stdout, "chdir iputdir failed\n");
     1bc:	a1 0c 66 00 00       	mov    0x660c,%eax
     1c1:	89 04 24             	mov    %eax,(%esp)
     1c4:	e8 17 40 00 00       	call   41e0 <printf>
    exit(0);
     1c9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     1d0:	e8 a3 3e 00 00       	call   4078 <exit>
    printf(stdout, "chdir / failed\n");
     1d5:	c7 44 24 04 a3 45 00 	movl   $0x45a3,0x4(%esp)
     1dc:	00 
     1dd:	eb dd                	jmp    1bc <iputtest+0x7c>
    printf(stdout, "unlink ../iputdir failed\n");
     1df:	c7 44 24 04 87 45 00 	movl   $0x4587,0x4(%esp)
     1e6:	00 
     1e7:	eb d3                	jmp    1bc <iputtest+0x7c>
    printf(stdout, "chdir iputdir failed\n");
     1e9:	c7 44 24 04 66 45 00 	movl   $0x4566,0x4(%esp)
     1f0:	00 
     1f1:	eb c9                	jmp    1bc <iputtest+0x7c>
     1f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <exitiputtest>:
{
     200:	55                   	push   %ebp
  printf(stdout, "exitiput test\n");
     201:	b9 b3 45 00 00       	mov    $0x45b3,%ecx
{
     206:	89 e5                	mov    %esp,%ebp
     208:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "exitiput test\n");
     20b:	a1 0c 66 00 00       	mov    0x660c,%eax
     210:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     214:	89 04 24             	mov    %eax,(%esp)
     217:	e8 c4 3f 00 00       	call   41e0 <printf>
  pid = fork();
     21c:	e8 4f 3e 00 00       	call   4070 <fork>
  if(pid < 0){
     221:	85 c0                	test   %eax,%eax
     223:	0f 88 91 00 00 00    	js     2ba <exitiputtest+0xba>
  if(pid == 0){
     229:	75 45                	jne    270 <exitiputtest+0x70>
    if(mkdir("iputdir") < 0){
     22b:	c7 04 24 7f 45 00 00 	movl   $0x457f,(%esp)
     232:	e8 a9 3e 00 00       	call   40e0 <mkdir>
     237:	85 c0                	test   %eax,%eax
     239:	0f 88 8f 00 00 00    	js     2ce <exitiputtest+0xce>
    if(chdir("iputdir") < 0){
     23f:	c7 04 24 7f 45 00 00 	movl   $0x457f,(%esp)
     246:	e8 9d 3e 00 00       	call   40e8 <chdir>
     24b:	85 c0                	test   %eax,%eax
     24d:	78 75                	js     2c4 <exitiputtest+0xc4>
    if(unlink("../iputdir") < 0){
     24f:	c7 04 24 7c 45 00 00 	movl   $0x457c,(%esp)
     256:	e8 6d 3e 00 00       	call   40c8 <unlink>
     25b:	85 c0                	test   %eax,%eax
     25d:	78 39                	js     298 <exitiputtest+0x98>
      exit(0);
     25f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     266:	e8 0d 3e 00 00       	call   4078 <exit>
     26b:	90                   	nop
     26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  wait(0);
     270:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     277:	e8 04 3e 00 00       	call   4080 <wait>
  printf(stdout, "exitiput test ok\n");
     27c:	b8 d6 45 00 00       	mov    $0x45d6,%eax
     281:	89 44 24 04          	mov    %eax,0x4(%esp)
     285:	a1 0c 66 00 00       	mov    0x660c,%eax
     28a:	89 04 24             	mov    %eax,(%esp)
     28d:	e8 4e 3f 00 00       	call   41e0 <printf>
}
     292:	c9                   	leave  
     293:	c3                   	ret    
     294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(stdout, "unlink ../iputdir failed\n");
     298:	ba 87 45 00 00       	mov    $0x4587,%edx
     29d:	89 54 24 04          	mov    %edx,0x4(%esp)
      printf(stdout, "mkdir failed\n");
     2a1:	a1 0c 66 00 00       	mov    0x660c,%eax
     2a6:	89 04 24             	mov    %eax,(%esp)
     2a9:	e8 32 3f 00 00       	call   41e0 <printf>
      exit(0);
     2ae:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     2b5:	e8 be 3d 00 00       	call   4078 <exit>
    printf(stdout, "fork failed\n");
     2ba:	c7 44 24 04 a5 54 00 	movl   $0x54a5,0x4(%esp)
     2c1:	00 
     2c2:	eb dd                	jmp    2a1 <exitiputtest+0xa1>
      printf(stdout, "child chdir failed\n");
     2c4:	c7 44 24 04 c2 45 00 	movl   $0x45c2,0x4(%esp)
     2cb:	00 
     2cc:	eb d3                	jmp    2a1 <exitiputtest+0xa1>
      printf(stdout, "mkdir failed\n");
     2ce:	c7 44 24 04 58 45 00 	movl   $0x4558,0x4(%esp)
     2d5:	00 
     2d6:	eb c9                	jmp    2a1 <exitiputtest+0xa1>
     2d8:	90                   	nop
     2d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002e0 <openiputtest>:
{
     2e0:	55                   	push   %ebp
  printf(stdout, "openiput test\n");
     2e1:	b8 e8 45 00 00       	mov    $0x45e8,%eax
{
     2e6:	89 e5                	mov    %esp,%ebp
     2e8:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "openiput test\n");
     2eb:	89 44 24 04          	mov    %eax,0x4(%esp)
     2ef:	a1 0c 66 00 00       	mov    0x660c,%eax
     2f4:	89 04 24             	mov    %eax,(%esp)
     2f7:	e8 e4 3e 00 00       	call   41e0 <printf>
  if(mkdir("oidir") < 0){
     2fc:	c7 04 24 f7 45 00 00 	movl   $0x45f7,(%esp)
     303:	e8 d8 3d 00 00       	call   40e0 <mkdir>
     308:	85 c0                	test   %eax,%eax
     30a:	0f 88 9a 00 00 00    	js     3aa <openiputtest+0xca>
  pid = fork();
     310:	e8 5b 3d 00 00       	call   4070 <fork>
  if(pid < 0){
     315:	85 c0                	test   %eax,%eax
     317:	0f 88 83 00 00 00    	js     3a0 <openiputtest+0xc0>
     31d:	8d 76 00             	lea    0x0(%esi),%esi
  if(pid == 0){
     320:	75 3e                	jne    360 <openiputtest+0x80>
    int fd = open("oidir", O_RDWR);
     322:	b9 02 00 00 00       	mov    $0x2,%ecx
     327:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     32b:	c7 04 24 f7 45 00 00 	movl   $0x45f7,(%esp)
     332:	e8 81 3d 00 00       	call   40b8 <open>
    if(fd >= 0){
     337:	85 c0                	test   %eax,%eax
     339:	78 16                	js     351 <openiputtest+0x71>
      printf(stdout, "open directory for write succeeded\n");
     33b:	ba 88 55 00 00       	mov    $0x5588,%edx
     340:	89 54 24 04          	mov    %edx,0x4(%esp)
    printf(stdout, "fork failed\n");
     344:	a1 0c 66 00 00       	mov    0x660c,%eax
     349:	89 04 24             	mov    %eax,(%esp)
     34c:	e8 8f 3e 00 00       	call   41e0 <printf>
    exit(0);
     351:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     358:	e8 1b 3d 00 00       	call   4078 <exit>
     35d:	8d 76 00             	lea    0x0(%esi),%esi
  sleep(1);
     360:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     367:	e8 9c 3d 00 00       	call   4108 <sleep>
  if(unlink("oidir") != 0){
     36c:	c7 04 24 f7 45 00 00 	movl   $0x45f7,(%esp)
     373:	e8 50 3d 00 00       	call   40c8 <unlink>
     378:	85 c0                	test   %eax,%eax
     37a:	75 38                	jne    3b4 <openiputtest+0xd4>
  wait(0);
     37c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     383:	e8 f8 3c 00 00       	call   4080 <wait>
  printf(stdout, "openiput test ok\n");
     388:	b8 20 46 00 00       	mov    $0x4620,%eax
     38d:	89 44 24 04          	mov    %eax,0x4(%esp)
     391:	a1 0c 66 00 00       	mov    0x660c,%eax
     396:	89 04 24             	mov    %eax,(%esp)
     399:	e8 42 3e 00 00       	call   41e0 <printf>
}
     39e:	c9                   	leave  
     39f:	c3                   	ret    
    printf(stdout, "fork failed\n");
     3a0:	c7 44 24 04 a5 54 00 	movl   $0x54a5,0x4(%esp)
     3a7:	00 
     3a8:	eb 9a                	jmp    344 <openiputtest+0x64>
    printf(stdout, "mkdir oidir failed\n");
     3aa:	c7 44 24 04 fd 45 00 	movl   $0x45fd,0x4(%esp)
     3b1:	00 
     3b2:	eb 90                	jmp    344 <openiputtest+0x64>
    printf(stdout, "unlink failed\n");
     3b4:	c7 44 24 04 11 46 00 	movl   $0x4611,0x4(%esp)
     3bb:	00 
     3bc:	e9 83 ff ff ff       	jmp    344 <openiputtest+0x64>
     3c1:	eb 0d                	jmp    3d0 <opentest>
     3c3:	90                   	nop
     3c4:	90                   	nop
     3c5:	90                   	nop
     3c6:	90                   	nop
     3c7:	90                   	nop
     3c8:	90                   	nop
     3c9:	90                   	nop
     3ca:	90                   	nop
     3cb:	90                   	nop
     3cc:	90                   	nop
     3cd:	90                   	nop
     3ce:	90                   	nop
     3cf:	90                   	nop

000003d0 <opentest>:
{
     3d0:	55                   	push   %ebp
  printf(stdout, "open test\n");
     3d1:	b9 32 46 00 00       	mov    $0x4632,%ecx
{
     3d6:	89 e5                	mov    %esp,%ebp
     3d8:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "open test\n");
     3db:	a1 0c 66 00 00       	mov    0x660c,%eax
     3e0:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     3e4:	89 04 24             	mov    %eax,(%esp)
     3e7:	e8 f4 3d 00 00       	call   41e0 <printf>
  fd = open("echo", 0);
     3ec:	31 c0                	xor    %eax,%eax
     3ee:	89 44 24 04          	mov    %eax,0x4(%esp)
     3f2:	c7 04 24 3d 46 00 00 	movl   $0x463d,(%esp)
     3f9:	e8 ba 3c 00 00       	call   40b8 <open>
  if(fd < 0){
     3fe:	85 c0                	test   %eax,%eax
     400:	78 36                	js     438 <opentest+0x68>
  close(fd);
     402:	89 04 24             	mov    %eax,(%esp)
     405:	e8 96 3c 00 00       	call   40a0 <close>
  fd = open("doesnotexist", 0);
     40a:	31 d2                	xor    %edx,%edx
     40c:	89 54 24 04          	mov    %edx,0x4(%esp)
     410:	c7 04 24 55 46 00 00 	movl   $0x4655,(%esp)
     417:	e8 9c 3c 00 00       	call   40b8 <open>
  if(fd >= 0){
     41c:	85 c0                	test   %eax,%eax
     41e:	79 39                	jns    459 <opentest+0x89>
  printf(stdout, "open test ok\n");
     420:	b8 80 46 00 00       	mov    $0x4680,%eax
     425:	89 44 24 04          	mov    %eax,0x4(%esp)
     429:	a1 0c 66 00 00       	mov    0x660c,%eax
     42e:	89 04 24             	mov    %eax,(%esp)
     431:	e8 aa 3d 00 00       	call   41e0 <printf>
}
     436:	c9                   	leave  
     437:	c3                   	ret    
    printf(stdout, "open echo failed!\n");
     438:	c7 44 24 04 42 46 00 	movl   $0x4642,0x4(%esp)
     43f:	00 
    printf(stdout, "open doesnotexist succeeded!\n");
     440:	a1 0c 66 00 00       	mov    0x660c,%eax
     445:	89 04 24             	mov    %eax,(%esp)
     448:	e8 93 3d 00 00       	call   41e0 <printf>
    exit(0);
     44d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     454:	e8 1f 3c 00 00       	call   4078 <exit>
    printf(stdout, "open doesnotexist succeeded!\n");
     459:	c7 44 24 04 62 46 00 	movl   $0x4662,0x4(%esp)
     460:	00 
     461:	eb dd                	jmp    440 <opentest+0x70>
     463:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000470 <writetest>:
{
     470:	55                   	push   %ebp
  printf(stdout, "small file test\n");
     471:	b8 8e 46 00 00       	mov    $0x468e,%eax
{
     476:	89 e5                	mov    %esp,%ebp
     478:	56                   	push   %esi
     479:	53                   	push   %ebx
     47a:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "small file test\n");
     47d:	89 44 24 04          	mov    %eax,0x4(%esp)
     481:	a1 0c 66 00 00       	mov    0x660c,%eax
     486:	89 04 24             	mov    %eax,(%esp)
     489:	e8 52 3d 00 00       	call   41e0 <printf>
  fd = open("small", O_CREATE|O_RDWR);
     48e:	b8 02 02 00 00       	mov    $0x202,%eax
     493:	89 44 24 04          	mov    %eax,0x4(%esp)
     497:	c7 04 24 9f 46 00 00 	movl   $0x469f,(%esp)
     49e:	e8 15 3c 00 00       	call   40b8 <open>
  if(fd >= 0){
     4a3:	85 c0                	test   %eax,%eax
     4a5:	0f 88 9b 01 00 00    	js     646 <writetest+0x1d6>
     4ab:	89 c6                	mov    %eax,%esi
    printf(stdout, "creat small succeeded; ok\n");
     4ad:	b8 a5 46 00 00       	mov    $0x46a5,%eax
     4b2:	89 44 24 04          	mov    %eax,0x4(%esp)
     4b6:	a1 0c 66 00 00       	mov    0x660c,%eax
  for(i = 0; i < 100; i++){
     4bb:	31 db                	xor    %ebx,%ebx
    printf(stdout, "creat small succeeded; ok\n");
     4bd:	89 04 24             	mov    %eax,(%esp)
     4c0:	e8 1b 3d 00 00       	call   41e0 <printf>
     4c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     4c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     4d0:	b9 0a 00 00 00       	mov    $0xa,%ecx
     4d5:	b8 dc 46 00 00       	mov    $0x46dc,%eax
     4da:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     4de:	89 44 24 04          	mov    %eax,0x4(%esp)
     4e2:	89 34 24             	mov    %esi,(%esp)
     4e5:	e8 ae 3b 00 00       	call   4098 <write>
     4ea:	83 f8 0a             	cmp    $0xa,%eax
     4ed:	0f 85 e9 00 00 00    	jne    5dc <writetest+0x16c>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     4f3:	b8 0a 00 00 00       	mov    $0xa,%eax
     4f8:	89 44 24 08          	mov    %eax,0x8(%esp)
     4fc:	b8 e7 46 00 00       	mov    $0x46e7,%eax
     501:	89 44 24 04          	mov    %eax,0x4(%esp)
     505:	89 34 24             	mov    %esi,(%esp)
     508:	e8 8b 3b 00 00       	call   4098 <write>
     50d:	83 f8 0a             	cmp    $0xa,%eax
     510:	0f 85 ec 00 00 00    	jne    602 <writetest+0x192>
  for(i = 0; i < 100; i++){
     516:	43                   	inc    %ebx
     517:	83 fb 64             	cmp    $0x64,%ebx
     51a:	75 b4                	jne    4d0 <writetest+0x60>
  printf(stdout, "writes ok\n");
     51c:	b8 f2 46 00 00       	mov    $0x46f2,%eax
     521:	89 44 24 04          	mov    %eax,0x4(%esp)
     525:	a1 0c 66 00 00       	mov    0x660c,%eax
     52a:	89 04 24             	mov    %eax,(%esp)
     52d:	e8 ae 3c 00 00       	call   41e0 <printf>
  close(fd);
     532:	89 34 24             	mov    %esi,(%esp)
     535:	e8 66 3b 00 00       	call   40a0 <close>
  fd = open("small", O_RDONLY);
     53a:	31 c0                	xor    %eax,%eax
     53c:	89 44 24 04          	mov    %eax,0x4(%esp)
     540:	c7 04 24 9f 46 00 00 	movl   $0x469f,(%esp)
     547:	e8 6c 3b 00 00       	call   40b8 <open>
  if(fd >= 0){
     54c:	85 c0                	test   %eax,%eax
  fd = open("small", O_RDONLY);
     54e:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     550:	0f 88 bb 00 00 00    	js     611 <writetest+0x1a1>
    printf(stdout, "open small succeeded ok\n");
     556:	a1 0c 66 00 00       	mov    0x660c,%eax
     55b:	b9 fd 46 00 00       	mov    $0x46fd,%ecx
  i = read(fd, buf, 2000);
     560:	be d0 07 00 00       	mov    $0x7d0,%esi
    printf(stdout, "open small succeeded ok\n");
     565:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     569:	89 04 24             	mov    %eax,(%esp)
     56c:	e8 6f 3c 00 00       	call   41e0 <printf>
  i = read(fd, buf, 2000);
     571:	b8 00 8e 00 00       	mov    $0x8e00,%eax
     576:	89 74 24 08          	mov    %esi,0x8(%esp)
     57a:	89 44 24 04          	mov    %eax,0x4(%esp)
     57e:	89 1c 24             	mov    %ebx,(%esp)
     581:	e8 0a 3b 00 00       	call   4090 <read>
  if(i == 2000){
     586:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     58b:	0f 85 a1 00 00 00    	jne    632 <writetest+0x1c2>
    printf(stdout, "read succeeded ok\n");
     591:	a1 0c 66 00 00       	mov    0x660c,%eax
     596:	ba 31 47 00 00       	mov    $0x4731,%edx
     59b:	89 54 24 04          	mov    %edx,0x4(%esp)
     59f:	89 04 24             	mov    %eax,(%esp)
     5a2:	e8 39 3c 00 00       	call   41e0 <printf>
  close(fd);
     5a7:	89 1c 24             	mov    %ebx,(%esp)
     5aa:	e8 f1 3a 00 00       	call   40a0 <close>
  if(unlink("small") < 0){
     5af:	c7 04 24 9f 46 00 00 	movl   $0x469f,(%esp)
     5b6:	e8 0d 3b 00 00       	call   40c8 <unlink>
     5bb:	85 c0                	test   %eax,%eax
     5bd:	78 7d                	js     63c <writetest+0x1cc>
  printf(stdout, "small file test ok\n");
     5bf:	b8 59 47 00 00       	mov    $0x4759,%eax
     5c4:	89 44 24 04          	mov    %eax,0x4(%esp)
     5c8:	a1 0c 66 00 00       	mov    0x660c,%eax
     5cd:	89 04 24             	mov    %eax,(%esp)
     5d0:	e8 0b 3c 00 00       	call   41e0 <printf>
}
     5d5:	83 c4 10             	add    $0x10,%esp
     5d8:	5b                   	pop    %ebx
     5d9:	5e                   	pop    %esi
     5da:	5d                   	pop    %ebp
     5db:	c3                   	ret    
      printf(stdout, "error: write aa %d new file failed\n", i);
     5dc:	ba ac 55 00 00       	mov    $0x55ac,%edx
     5e1:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     5e5:	89 54 24 04          	mov    %edx,0x4(%esp)
      printf(stdout, "error: write bb %d new file failed\n", i);
     5e9:	a1 0c 66 00 00       	mov    0x660c,%eax
     5ee:	89 04 24             	mov    %eax,(%esp)
     5f1:	e8 ea 3b 00 00       	call   41e0 <printf>
      exit(0);
     5f6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     5fd:	e8 76 3a 00 00       	call   4078 <exit>
      printf(stdout, "error: write bb %d new file failed\n", i);
     602:	b8 d0 55 00 00       	mov    $0x55d0,%eax
     607:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     60b:	89 44 24 04          	mov    %eax,0x4(%esp)
     60f:	eb d8                	jmp    5e9 <writetest+0x179>
    printf(stdout, "error: open small failed!\n");
     611:	c7 44 24 04 16 47 00 	movl   $0x4716,0x4(%esp)
     618:	00 
     619:	a1 0c 66 00 00       	mov    0x660c,%eax
     61e:	89 04 24             	mov    %eax,(%esp)
     621:	e8 ba 3b 00 00       	call   41e0 <printf>
    exit(0);
     626:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     62d:	e8 46 3a 00 00       	call   4078 <exit>
    printf(stdout, "read failed\n");
     632:	c7 44 24 04 69 4a 00 	movl   $0x4a69,0x4(%esp)
     639:	00 
     63a:	eb dd                	jmp    619 <writetest+0x1a9>
    printf(stdout, "unlink small failed\n");
     63c:	c7 44 24 04 44 47 00 	movl   $0x4744,0x4(%esp)
     643:	00 
     644:	eb d3                	jmp    619 <writetest+0x1a9>
    printf(stdout, "error: creat small failed!\n");
     646:	c7 44 24 04 c0 46 00 	movl   $0x46c0,0x4(%esp)
     64d:	00 
     64e:	eb c9                	jmp    619 <writetest+0x1a9>

00000650 <writetest1>:
{
     650:	55                   	push   %ebp
  printf(stdout, "big files test\n");
     651:	ba 6d 47 00 00       	mov    $0x476d,%edx
{
     656:	89 e5                	mov    %esp,%ebp
     658:	56                   	push   %esi
     659:	53                   	push   %ebx
     65a:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "big files test\n");
     65d:	a1 0c 66 00 00       	mov    0x660c,%eax
     662:	89 54 24 04          	mov    %edx,0x4(%esp)
     666:	89 04 24             	mov    %eax,(%esp)
     669:	e8 72 3b 00 00       	call   41e0 <printf>
  fd = open("big", O_CREATE|O_RDWR);
     66e:	b9 02 02 00 00       	mov    $0x202,%ecx
     673:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     677:	c7 04 24 e7 47 00 00 	movl   $0x47e7,(%esp)
     67e:	e8 35 3a 00 00       	call   40b8 <open>
  if(fd < 0){
     683:	85 c0                	test   %eax,%eax
     685:	0f 88 73 01 00 00    	js     7fe <writetest1+0x1ae>
     68b:	89 c6                	mov    %eax,%esi
  for(i = 0; i < MAXFILE; i++){
     68d:	31 db                	xor    %ebx,%ebx
     68f:	90                   	nop
    if(write(fd, buf, 512) != 512){
     690:	b8 00 02 00 00       	mov    $0x200,%eax
     695:	89 44 24 08          	mov    %eax,0x8(%esp)
     699:	b8 00 8e 00 00       	mov    $0x8e00,%eax
     69e:	89 44 24 04          	mov    %eax,0x4(%esp)
     6a2:	89 34 24             	mov    %esi,(%esp)
    ((int*)buf)[0] = i;
     6a5:	89 1d 00 8e 00 00    	mov    %ebx,0x8e00
    if(write(fd, buf, 512) != 512){
     6ab:	e8 e8 39 00 00       	call   4098 <write>
     6b0:	3d 00 02 00 00       	cmp    $0x200,%eax
     6b5:	0f 85 b1 00 00 00    	jne    76c <writetest1+0x11c>
  for(i = 0; i < MAXFILE; i++){
     6bb:	43                   	inc    %ebx
     6bc:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     6c2:	75 cc                	jne    690 <writetest1+0x40>
  close(fd);
     6c4:	89 34 24             	mov    %esi,(%esp)
     6c7:	e8 d4 39 00 00       	call   40a0 <close>
  fd = open("big", O_RDONLY);
     6cc:	31 c0                	xor    %eax,%eax
     6ce:	89 44 24 04          	mov    %eax,0x4(%esp)
     6d2:	c7 04 24 e7 47 00 00 	movl   $0x47e7,(%esp)
     6d9:	e8 da 39 00 00       	call   40b8 <open>
  if(fd < 0){
     6de:	85 c0                	test   %eax,%eax
  fd = open("big", O_RDONLY);
     6e0:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     6e2:	0f 88 f5 00 00 00    	js     7dd <writetest1+0x18d>
  n = 0;
     6e8:	31 db                	xor    %ebx,%ebx
     6ea:	eb 1d                	jmp    709 <writetest1+0xb9>
     6ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(i != 512){
     6f0:	3d 00 02 00 00       	cmp    $0x200,%eax
     6f5:	0f 85 c1 00 00 00    	jne    7bc <writetest1+0x16c>
    if(((int*)buf)[0] != n){
     6fb:	a1 00 8e 00 00       	mov    0x8e00,%eax
     700:	39 d8                	cmp    %ebx,%eax
     702:	0f 85 8a 00 00 00    	jne    792 <writetest1+0x142>
    n++;
     708:	43                   	inc    %ebx
    i = read(fd, buf, 512);
     709:	b8 00 02 00 00       	mov    $0x200,%eax
     70e:	89 44 24 08          	mov    %eax,0x8(%esp)
     712:	b8 00 8e 00 00       	mov    $0x8e00,%eax
     717:	89 44 24 04          	mov    %eax,0x4(%esp)
     71b:	89 34 24             	mov    %esi,(%esp)
     71e:	e8 6d 39 00 00       	call   4090 <read>
    if(i == 0){
     723:	85 c0                	test   %eax,%eax
     725:	75 c9                	jne    6f0 <writetest1+0xa0>
      if(n == MAXFILE - 1){
     727:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     72d:	0f 84 98 00 00 00    	je     7cb <writetest1+0x17b>
  close(fd);
     733:	89 34 24             	mov    %esi,(%esp)
     736:	e8 65 39 00 00       	call   40a0 <close>
  if(unlink("big") < 0){
     73b:	c7 04 24 e7 47 00 00 	movl   $0x47e7,(%esp)
     742:	e8 81 39 00 00       	call   40c8 <unlink>
     747:	85 c0                	test   %eax,%eax
     749:	0f 88 b9 00 00 00    	js     808 <writetest1+0x1b8>
  printf(stdout, "big files ok\n");
     74f:	b8 0e 48 00 00       	mov    $0x480e,%eax
     754:	89 44 24 04          	mov    %eax,0x4(%esp)
     758:	a1 0c 66 00 00       	mov    0x660c,%eax
     75d:	89 04 24             	mov    %eax,(%esp)
     760:	e8 7b 3a 00 00       	call   41e0 <printf>
}
     765:	83 c4 10             	add    $0x10,%esp
     768:	5b                   	pop    %ebx
     769:	5e                   	pop    %esi
     76a:	5d                   	pop    %ebp
     76b:	c3                   	ret    
      printf(stdout, "error: write big file failed\n", i);
     76c:	b8 97 47 00 00       	mov    $0x4797,%eax
     771:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     775:	89 44 24 04          	mov    %eax,0x4(%esp)
        printf(stdout, "read only %d blocks from big", n);
     779:	a1 0c 66 00 00       	mov    0x660c,%eax
     77e:	89 04 24             	mov    %eax,(%esp)
     781:	e8 5a 3a 00 00       	call   41e0 <printf>
        exit(0);
     786:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     78d:	e8 e6 38 00 00       	call   4078 <exit>
      printf(stdout, "read content of block %d is %d\n",
     792:	89 44 24 0c          	mov    %eax,0xc(%esp)
     796:	a1 0c 66 00 00       	mov    0x660c,%eax
     79b:	ba f4 55 00 00       	mov    $0x55f4,%edx
     7a0:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     7a4:	89 54 24 04          	mov    %edx,0x4(%esp)
     7a8:	89 04 24             	mov    %eax,(%esp)
     7ab:	e8 30 3a 00 00       	call   41e0 <printf>
      exit(0);
     7b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     7b7:	e8 bc 38 00 00       	call   4078 <exit>
      printf(stdout, "read failed %d\n", i);
     7bc:	b9 eb 47 00 00       	mov    $0x47eb,%ecx
     7c1:	89 44 24 08          	mov    %eax,0x8(%esp)
     7c5:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     7c9:	eb ae                	jmp    779 <writetest1+0x129>
        printf(stdout, "read only %d blocks from big", n);
     7cb:	c7 44 24 08 8b 00 00 	movl   $0x8b,0x8(%esp)
     7d2:	00 
     7d3:	c7 44 24 04 ce 47 00 	movl   $0x47ce,0x4(%esp)
     7da:	00 
     7db:	eb 9c                	jmp    779 <writetest1+0x129>
    printf(stdout, "error: open big failed!\n");
     7dd:	c7 44 24 04 b5 47 00 	movl   $0x47b5,0x4(%esp)
     7e4:	00 
     7e5:	a1 0c 66 00 00       	mov    0x660c,%eax
     7ea:	89 04 24             	mov    %eax,(%esp)
     7ed:	e8 ee 39 00 00       	call   41e0 <printf>
    exit(0);
     7f2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     7f9:	e8 7a 38 00 00       	call   4078 <exit>
    printf(stdout, "error: creat big failed!\n");
     7fe:	c7 44 24 04 7d 47 00 	movl   $0x477d,0x4(%esp)
     805:	00 
     806:	eb dd                	jmp    7e5 <writetest1+0x195>
    printf(stdout, "unlink big failed\n");
     808:	c7 44 24 04 fb 47 00 	movl   $0x47fb,0x4(%esp)
     80f:	00 
     810:	eb d3                	jmp    7e5 <writetest1+0x195>
     812:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000820 <createtest>:
{
     820:	55                   	push   %ebp
  printf(stdout, "many creates, followed by unlink test\n");
     821:	b8 14 56 00 00       	mov    $0x5614,%eax
{
     826:	89 e5                	mov    %esp,%ebp
     828:	53                   	push   %ebx
  name[2] = '\0';
     829:	b3 30                	mov    $0x30,%bl
{
     82b:	83 ec 14             	sub    $0x14,%esp
  printf(stdout, "many creates, followed by unlink test\n");
     82e:	89 44 24 04          	mov    %eax,0x4(%esp)
     832:	a1 0c 66 00 00       	mov    0x660c,%eax
     837:	89 04 24             	mov    %eax,(%esp)
     83a:	e8 a1 39 00 00       	call   41e0 <printf>
  name[0] = 'a';
     83f:	b0 61                	mov    $0x61,%al
     841:	a2 00 ae 00 00       	mov    %al,0xae00
  name[2] = '\0';
     846:	31 c0                	xor    %eax,%eax
     848:	a2 02 ae 00 00       	mov    %al,0xae02
     84d:	8d 76 00             	lea    0x0(%esi),%esi
    fd = open(name, O_CREATE|O_RDWR);
     850:	b8 02 02 00 00       	mov    $0x202,%eax
     855:	89 44 24 04          	mov    %eax,0x4(%esp)
     859:	c7 04 24 00 ae 00 00 	movl   $0xae00,(%esp)
    name[1] = '0' + i;
     860:	88 1d 01 ae 00 00    	mov    %bl,0xae01
     866:	fe c3                	inc    %bl
    fd = open(name, O_CREATE|O_RDWR);
     868:	e8 4b 38 00 00       	call   40b8 <open>
    close(fd);
     86d:	89 04 24             	mov    %eax,(%esp)
     870:	e8 2b 38 00 00       	call   40a0 <close>
  for(i = 0; i < 52; i++){
     875:	80 fb 64             	cmp    $0x64,%bl
     878:	75 d6                	jne    850 <createtest+0x30>
  name[0] = 'a';
     87a:	b2 61                	mov    $0x61,%dl
  name[2] = '\0';
     87c:	31 c9                	xor    %ecx,%ecx
  name[0] = 'a';
     87e:	88 15 00 ae 00 00    	mov    %dl,0xae00
  name[2] = '\0';
     884:	b3 30                	mov    $0x30,%bl
     886:	88 0d 02 ae 00 00    	mov    %cl,0xae02
     88c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    name[1] = '0' + i;
     890:	88 1d 01 ae 00 00    	mov    %bl,0xae01
     896:	fe c3                	inc    %bl
    unlink(name);
     898:	c7 04 24 00 ae 00 00 	movl   $0xae00,(%esp)
     89f:	e8 24 38 00 00       	call   40c8 <unlink>
  for(i = 0; i < 52; i++){
     8a4:	80 fb 64             	cmp    $0x64,%bl
     8a7:	75 e7                	jne    890 <createtest+0x70>
  printf(stdout, "many creates, followed by unlink; ok\n");
     8a9:	b8 3c 56 00 00       	mov    $0x563c,%eax
     8ae:	89 44 24 04          	mov    %eax,0x4(%esp)
     8b2:	a1 0c 66 00 00       	mov    0x660c,%eax
     8b7:	89 04 24             	mov    %eax,(%esp)
     8ba:	e8 21 39 00 00       	call   41e0 <printf>
}
     8bf:	83 c4 14             	add    $0x14,%esp
     8c2:	5b                   	pop    %ebx
     8c3:	5d                   	pop    %ebp
     8c4:	c3                   	ret    
     8c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     8c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008d0 <dirtest>:
{
     8d0:	55                   	push   %ebp
  printf(stdout, "mkdir test\n");
     8d1:	ba 1c 48 00 00       	mov    $0x481c,%edx
{
     8d6:	89 e5                	mov    %esp,%ebp
     8d8:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "mkdir test\n");
     8db:	a1 0c 66 00 00       	mov    0x660c,%eax
     8e0:	89 54 24 04          	mov    %edx,0x4(%esp)
     8e4:	89 04 24             	mov    %eax,(%esp)
     8e7:	e8 f4 38 00 00       	call   41e0 <printf>
  if(mkdir("dir0") < 0){
     8ec:	c7 04 24 28 48 00 00 	movl   $0x4828,(%esp)
     8f3:	e8 e8 37 00 00       	call   40e0 <mkdir>
     8f8:	85 c0                	test   %eax,%eax
     8fa:	78 48                	js     944 <dirtest+0x74>
  if(chdir("dir0") < 0){
     8fc:	c7 04 24 28 48 00 00 	movl   $0x4828,(%esp)
     903:	e8 e0 37 00 00       	call   40e8 <chdir>
     908:	85 c0                	test   %eax,%eax
     90a:	78 6d                	js     979 <dirtest+0xa9>
  if(chdir("..") < 0){
     90c:	c7 04 24 d9 4d 00 00 	movl   $0x4dd9,(%esp)
     913:	e8 d0 37 00 00       	call   40e8 <chdir>
     918:	85 c0                	test   %eax,%eax
     91a:	78 53                	js     96f <dirtest+0x9f>
  if(unlink("dir0") < 0){
     91c:	c7 04 24 28 48 00 00 	movl   $0x4828,(%esp)
     923:	e8 a0 37 00 00       	call   40c8 <unlink>
     928:	85 c0                	test   %eax,%eax
     92a:	78 39                	js     965 <dirtest+0x95>
  printf(stdout, "mkdir test ok\n");
     92c:	b8 65 48 00 00       	mov    $0x4865,%eax
     931:	89 44 24 04          	mov    %eax,0x4(%esp)
     935:	a1 0c 66 00 00       	mov    0x660c,%eax
     93a:	89 04 24             	mov    %eax,(%esp)
     93d:	e8 9e 38 00 00       	call   41e0 <printf>
}
     942:	c9                   	leave  
     943:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
     944:	c7 44 24 04 58 45 00 	movl   $0x4558,0x4(%esp)
     94b:	00 
    printf(stdout, "chdir dir0 failed\n");
     94c:	a1 0c 66 00 00       	mov    0x660c,%eax
     951:	89 04 24             	mov    %eax,(%esp)
     954:	e8 87 38 00 00       	call   41e0 <printf>
    exit(0);
     959:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     960:	e8 13 37 00 00       	call   4078 <exit>
    printf(stdout, "unlink dir0 failed\n");
     965:	c7 44 24 04 51 48 00 	movl   $0x4851,0x4(%esp)
     96c:	00 
     96d:	eb dd                	jmp    94c <dirtest+0x7c>
    printf(stdout, "chdir .. failed\n");
     96f:	c7 44 24 04 40 48 00 	movl   $0x4840,0x4(%esp)
     976:	00 
     977:	eb d3                	jmp    94c <dirtest+0x7c>
    printf(stdout, "chdir dir0 failed\n");
     979:	c7 44 24 04 2d 48 00 	movl   $0x482d,0x4(%esp)
     980:	00 
     981:	eb c9                	jmp    94c <dirtest+0x7c>
     983:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000990 <exectest>:
{
     990:	55                   	push   %ebp
  printf(stdout, "exec test\n");
     991:	b8 74 48 00 00       	mov    $0x4874,%eax
{
     996:	89 e5                	mov    %esp,%ebp
     998:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "exec test\n");
     99b:	89 44 24 04          	mov    %eax,0x4(%esp)
     99f:	a1 0c 66 00 00       	mov    0x660c,%eax
     9a4:	89 04 24             	mov    %eax,(%esp)
     9a7:	e8 34 38 00 00       	call   41e0 <printf>
  if(exec("echo", echoargv) < 0){
     9ac:	ba 10 66 00 00       	mov    $0x6610,%edx
     9b1:	89 54 24 04          	mov    %edx,0x4(%esp)
     9b5:	c7 04 24 3d 46 00 00 	movl   $0x463d,(%esp)
     9bc:	e8 ef 36 00 00       	call   40b0 <exec>
     9c1:	85 c0                	test   %eax,%eax
     9c3:	78 02                	js     9c7 <exectest+0x37>
}
     9c5:	c9                   	leave  
     9c6:	c3                   	ret    
    printf(stdout, "exec echo failed\n");
     9c7:	a1 0c 66 00 00       	mov    0x660c,%eax
     9cc:	c7 44 24 04 7f 48 00 	movl   $0x487f,0x4(%esp)
     9d3:	00 
     9d4:	89 04 24             	mov    %eax,(%esp)
     9d7:	e8 04 38 00 00       	call   41e0 <printf>
    exit(0);
     9dc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     9e3:	e8 90 36 00 00       	call   4078 <exit>
     9e8:	90                   	nop
     9e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000009f0 <pipe1>:
{
     9f0:	55                   	push   %ebp
     9f1:	89 e5                	mov    %esp,%ebp
     9f3:	57                   	push   %edi
     9f4:	56                   	push   %esi
     9f5:	53                   	push   %ebx
     9f6:	83 ec 3c             	sub    $0x3c,%esp
  if(pipe(fds) != 0){
     9f9:	8d 45 e0             	lea    -0x20(%ebp),%eax
     9fc:	89 04 24             	mov    %eax,(%esp)
     9ff:	e8 84 36 00 00       	call   4088 <pipe>
     a04:	85 c0                	test   %eax,%eax
     a06:	0f 85 6a 01 00 00    	jne    b76 <pipe1+0x186>
     a0c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  pid = fork();
     a0f:	e8 5c 36 00 00       	call   4070 <fork>
  if(pid == 0){
     a14:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     a17:	83 f8 00             	cmp    $0x0,%eax
     a1a:	0f 84 94 00 00 00    	je     ab4 <pipe1+0xc4>
     a20:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  } else if(pid > 0){
     a23:	0f 8e 6d 01 00 00    	jle    b96 <pipe1+0x1a6>
    close(fds[1]);
     a29:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    cc = 1;
     a2c:	bf 01 00 00 00       	mov    $0x1,%edi
    close(fds[1]);
     a31:	89 04 24             	mov    %eax,(%esp)
     a34:	e8 67 36 00 00       	call   40a0 <close>
     a39:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    total = 0;
     a3c:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     a43:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a46:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     a49:	ba 00 8e 00 00       	mov    $0x8e00,%edx
     a4e:	89 54 24 04          	mov    %edx,0x4(%esp)
     a52:	89 7c 24 08          	mov    %edi,0x8(%esp)
     a56:	89 04 24             	mov    %eax,(%esp)
     a59:	e8 32 36 00 00       	call   4090 <read>
     a5e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     a61:	85 c0                	test   %eax,%eax
     a63:	0f 8e b3 00 00 00    	jle    b1c <pipe1+0x12c>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     a69:	89 d3                	mov    %edx,%ebx
     a6b:	8d 34 10             	lea    (%eax,%edx,1),%esi
     a6e:	f7 db                	neg    %ebx
     a70:	38 94 1a 00 8e 00 00 	cmp    %dl,0x8e00(%edx,%ebx,1)
     a77:	8d 4a 01             	lea    0x1(%edx),%ecx
     a7a:	75 1b                	jne    a97 <pipe1+0xa7>
      for(i = 0; i < n; i++){
     a7c:	39 ce                	cmp    %ecx,%esi
     a7e:	89 ca                	mov    %ecx,%edx
     a80:	75 ee                	jne    a70 <pipe1+0x80>
      cc = cc * 2;
     a82:	01 ff                	add    %edi,%edi
      total += n;
     a84:	01 45 d0             	add    %eax,-0x30(%ebp)
     a87:	81 ff 00 20 00 00    	cmp    $0x2000,%edi
     a8d:	b8 00 20 00 00       	mov    $0x2000,%eax
     a92:	0f 4f f8             	cmovg  %eax,%edi
     a95:	eb ac                	jmp    a43 <pipe1+0x53>
          printf(1, "pipe1 oops 2\n");
     a97:	b9 ae 48 00 00       	mov    $0x48ae,%ecx
     a9c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     aa0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     aa7:	e8 34 37 00 00       	call   41e0 <printf>
}
     aac:	83 c4 3c             	add    $0x3c,%esp
     aaf:	5b                   	pop    %ebx
     ab0:	5e                   	pop    %esi
     ab1:	5f                   	pop    %edi
     ab2:	5d                   	pop    %ebp
     ab3:	c3                   	ret    
    close(fds[0]);
     ab4:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ab7:	31 db                	xor    %ebx,%ebx
     ab9:	89 04 24             	mov    %eax,(%esp)
     abc:	e8 df 35 00 00       	call   40a0 <close>
{
     ac1:	88 da                	mov    %bl,%dl
      for(i = 0; i < 1033; i++)
     ac3:	31 c0                	xor    %eax,%eax
     ac5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        buf[i] = seq++;
     ad0:	88 90 00 8e 00 00    	mov    %dl,0x8e00(%eax)
      for(i = 0; i < 1033; i++)
     ad6:	40                   	inc    %eax
     ad7:	fe c2                	inc    %dl
     ad9:	3d 09 04 00 00       	cmp    $0x409,%eax
     ade:	75 f0                	jne    ad0 <pipe1+0xe0>
      if(write(fds[1], buf, 1033) != 1033){
     ae0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ae3:	be 09 04 00 00       	mov    $0x409,%esi
     ae8:	bf 00 8e 00 00       	mov    $0x8e00,%edi
     aed:	89 74 24 08          	mov    %esi,0x8(%esp)
     af1:	89 7c 24 04          	mov    %edi,0x4(%esp)
     af5:	89 04 24             	mov    %eax,(%esp)
     af8:	e8 9b 35 00 00       	call   4098 <write>
     afd:	3d 09 04 00 00       	cmp    $0x409,%eax
     b02:	0f 85 ae 00 00 00    	jne    bb6 <pipe1+0x1c6>
     b08:	80 c3 09             	add    $0x9,%bl
    for(n = 0; n < 5; n++){
     b0b:	80 fb 2d             	cmp    $0x2d,%bl
     b0e:	75 b1                	jne    ac1 <pipe1+0xd1>
      exit(0);
     b10:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     b17:	e8 5c 35 00 00       	call   4078 <exit>
    if(total != 5 * 1033){
     b1c:	81 7d d0 2d 14 00 00 	cmpl   $0x142d,-0x30(%ebp)
     b23:	75 34                	jne    b59 <pipe1+0x169>
    close(fds[0]);
     b25:	8b 45 e0             	mov    -0x20(%ebp),%eax
     b28:	89 04 24             	mov    %eax,(%esp)
     b2b:	e8 70 35 00 00       	call   40a0 <close>
    wait(0);
     b30:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     b37:	e8 44 35 00 00       	call   4080 <wait>
  printf(1, "pipe1 ok\n");
     b3c:	b8 d3 48 00 00       	mov    $0x48d3,%eax
     b41:	89 44 24 04          	mov    %eax,0x4(%esp)
     b45:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b4c:	e8 8f 36 00 00       	call   41e0 <printf>
}
     b51:	83 c4 3c             	add    $0x3c,%esp
     b54:	5b                   	pop    %ebx
     b55:	5e                   	pop    %esi
     b56:	5f                   	pop    %edi
     b57:	5d                   	pop    %ebp
     b58:	c3                   	ret    
      printf(1, "pipe1 oops 3 total %d\n", total);
     b59:	8b 45 d0             	mov    -0x30(%ebp),%eax
     b5c:	c7 44 24 04 bc 48 00 	movl   $0x48bc,0x4(%esp)
     b63:	00 
     b64:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b6b:	89 44 24 08          	mov    %eax,0x8(%esp)
     b6f:	e8 6c 36 00 00       	call   41e0 <printf>
     b74:	eb 9a                	jmp    b10 <pipe1+0x120>
    printf(1, "pipe() failed\n");
     b76:	c7 44 24 04 91 48 00 	movl   $0x4891,0x4(%esp)
     b7d:	00 
     b7e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b85:	e8 56 36 00 00       	call   41e0 <printf>
    exit(0);
     b8a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     b91:	e8 e2 34 00 00       	call   4078 <exit>
    printf(1, "fork() failed\n");
     b96:	c7 44 24 04 dd 48 00 	movl   $0x48dd,0x4(%esp)
     b9d:	00 
     b9e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ba5:	e8 36 36 00 00       	call   41e0 <printf>
    exit(0);
     baa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     bb1:	e8 c2 34 00 00       	call   4078 <exit>
        printf(1, "pipe1 oops 1\n");
     bb6:	c7 44 24 04 a0 48 00 	movl   $0x48a0,0x4(%esp)
     bbd:	00 
     bbe:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     bc5:	e8 16 36 00 00       	call   41e0 <printf>
        exit(0);
     bca:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     bd1:	e8 a2 34 00 00       	call   4078 <exit>
     bd6:	8d 76 00             	lea    0x0(%esi),%esi
     bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000be0 <preempt>:
{
     be0:	55                   	push   %ebp
  printf(1, "preempt: ");
     be1:	b8 ec 48 00 00       	mov    $0x48ec,%eax
{
     be6:	89 e5                	mov    %esp,%ebp
     be8:	57                   	push   %edi
     be9:	56                   	push   %esi
     bea:	53                   	push   %ebx
     beb:	83 ec 2c             	sub    $0x2c,%esp
  printf(1, "preempt: ");
     bee:	89 44 24 04          	mov    %eax,0x4(%esp)
     bf2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     bf9:	e8 e2 35 00 00       	call   41e0 <printf>
  pid1 = fork();
     bfe:	e8 6d 34 00 00       	call   4070 <fork>
  if(pid1 == 0)
     c03:	85 c0                	test   %eax,%eax
     c05:	75 02                	jne    c09 <preempt+0x29>
     c07:	eb fe                	jmp    c07 <preempt+0x27>
     c09:	89 c7                	mov    %eax,%edi
     c0b:	90                   	nop
     c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  pid2 = fork();
     c10:	e8 5b 34 00 00       	call   4070 <fork>
  if(pid2 == 0)
     c15:	85 c0                	test   %eax,%eax
  pid2 = fork();
     c17:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     c19:	75 02                	jne    c1d <preempt+0x3d>
     c1b:	eb fe                	jmp    c1b <preempt+0x3b>
  pipe(pfds);
     c1d:	8d 45 e0             	lea    -0x20(%ebp),%eax
     c20:	89 04 24             	mov    %eax,(%esp)
     c23:	e8 60 34 00 00       	call   4088 <pipe>
  pid3 = fork();
     c28:	e8 43 34 00 00       	call   4070 <fork>
  if(pid3 == 0){
     c2d:	85 c0                	test   %eax,%eax
  pid3 = fork();
     c2f:	89 c3                	mov    %eax,%ebx
  if(pid3 == 0){
     c31:	75 4a                	jne    c7d <preempt+0x9d>
    close(pfds[0]);
     c33:	8b 45 e0             	mov    -0x20(%ebp),%eax
     c36:	89 04 24             	mov    %eax,(%esp)
     c39:	e8 62 34 00 00       	call   40a0 <close>
    if(write(pfds[1], "x", 1) != 1)
     c3e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c41:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     c48:	00 
     c49:	c7 44 24 04 bd 4e 00 	movl   $0x4ebd,0x4(%esp)
     c50:	00 
     c51:	89 04 24             	mov    %eax,(%esp)
     c54:	e8 3f 34 00 00       	call   4098 <write>
     c59:	48                   	dec    %eax
     c5a:	74 14                	je     c70 <preempt+0x90>
      printf(1, "preempt write error");
     c5c:	c7 44 24 04 f6 48 00 	movl   $0x48f6,0x4(%esp)
     c63:	00 
     c64:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c6b:	e8 70 35 00 00       	call   41e0 <printf>
    close(pfds[1]);
     c70:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c73:	89 04 24             	mov    %eax,(%esp)
     c76:	e8 25 34 00 00       	call   40a0 <close>
     c7b:	eb fe                	jmp    c7b <preempt+0x9b>
  close(pfds[1]);
     c7d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c80:	89 04 24             	mov    %eax,(%esp)
     c83:	e8 18 34 00 00       	call   40a0 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     c88:	8b 45 e0             	mov    -0x20(%ebp),%eax
     c8b:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
     c92:	00 
     c93:	c7 44 24 04 00 8e 00 	movl   $0x8e00,0x4(%esp)
     c9a:	00 
     c9b:	89 04 24             	mov    %eax,(%esp)
     c9e:	e8 ed 33 00 00       	call   4090 <read>
     ca3:	48                   	dec    %eax
     ca4:	74 1c                	je     cc2 <preempt+0xe2>
    printf(1, "preempt read error");
     ca6:	c7 44 24 04 0a 49 00 	movl   $0x490a,0x4(%esp)
     cad:	00 
     cae:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     cb5:	e8 26 35 00 00       	call   41e0 <printf>
}
     cba:	83 c4 2c             	add    $0x2c,%esp
     cbd:	5b                   	pop    %ebx
     cbe:	5e                   	pop    %esi
     cbf:	5f                   	pop    %edi
     cc0:	5d                   	pop    %ebp
     cc1:	c3                   	ret    
  close(pfds[0]);
     cc2:	8b 45 e0             	mov    -0x20(%ebp),%eax
     cc5:	89 04 24             	mov    %eax,(%esp)
     cc8:	e8 d3 33 00 00       	call   40a0 <close>
  printf(1, "kill... ");
     ccd:	c7 44 24 04 1d 49 00 	movl   $0x491d,0x4(%esp)
     cd4:	00 
     cd5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     cdc:	e8 ff 34 00 00       	call   41e0 <printf>
  kill(pid1);
     ce1:	89 3c 24             	mov    %edi,(%esp)
     ce4:	e8 bf 33 00 00       	call   40a8 <kill>
  kill(pid2);
     ce9:	89 34 24             	mov    %esi,(%esp)
     cec:	e8 b7 33 00 00       	call   40a8 <kill>
  kill(pid3);
     cf1:	89 1c 24             	mov    %ebx,(%esp)
     cf4:	e8 af 33 00 00       	call   40a8 <kill>
  printf(1, "wait... ");
     cf9:	c7 44 24 04 26 49 00 	movl   $0x4926,0x4(%esp)
     d00:	00 
     d01:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d08:	e8 d3 34 00 00       	call   41e0 <printf>
  wait(0);
     d0d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     d14:	e8 67 33 00 00       	call   4080 <wait>
  wait(0);
     d19:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     d20:	e8 5b 33 00 00       	call   4080 <wait>
  wait(0);
     d25:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     d2c:	e8 4f 33 00 00       	call   4080 <wait>
  printf(1, "preempt ok\n");
     d31:	c7 44 24 04 2f 49 00 	movl   $0x492f,0x4(%esp)
     d38:	00 
     d39:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d40:	e8 9b 34 00 00       	call   41e0 <printf>
     d45:	e9 70 ff ff ff       	jmp    cba <preempt+0xda>
     d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000d50 <exitwait>:
{
     d50:	55                   	push   %ebp
     d51:	89 e5                	mov    %esp,%ebp
     d53:	56                   	push   %esi
     d54:	be 64 00 00 00       	mov    $0x64,%esi
     d59:	53                   	push   %ebx
     d5a:	83 ec 10             	sub    $0x10,%esp
     d5d:	eb 16                	jmp    d75 <exitwait+0x25>
     d5f:	90                   	nop
      if(wait(0) != pid){
     d60:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    if(pid){
     d67:	74 73                	je     ddc <exitwait+0x8c>
      if(wait(0) != pid){
     d69:	e8 12 33 00 00       	call   4080 <wait>
     d6e:	39 d8                	cmp    %ebx,%eax
     d70:	75 2e                	jne    da0 <exitwait+0x50>
  for(i = 0; i < 100; i++){
     d72:	4e                   	dec    %esi
     d73:	74 4b                	je     dc0 <exitwait+0x70>
    pid = fork();
     d75:	e8 f6 32 00 00       	call   4070 <fork>
    if(pid < 0){
     d7a:	85 c0                	test   %eax,%eax
    pid = fork();
     d7c:	89 c3                	mov    %eax,%ebx
     d7e:	66 90                	xchg   %ax,%ax
    if(pid < 0){
     d80:	79 de                	jns    d60 <exitwait+0x10>
      printf(1, "fork failed\n");
     d82:	b9 a5 54 00 00       	mov    $0x54a5,%ecx
     d87:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     d8b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d92:	e8 49 34 00 00       	call   41e0 <printf>
}
     d97:	83 c4 10             	add    $0x10,%esp
     d9a:	5b                   	pop    %ebx
     d9b:	5e                   	pop    %esi
     d9c:	5d                   	pop    %ebp
     d9d:	c3                   	ret    
     d9e:	66 90                	xchg   %ax,%ax
        printf(1, "wait wrong pid\n");
     da0:	ba 3b 49 00 00       	mov    $0x493b,%edx
     da5:	89 54 24 04          	mov    %edx,0x4(%esp)
     da9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     db0:	e8 2b 34 00 00       	call   41e0 <printf>
}
     db5:	83 c4 10             	add    $0x10,%esp
     db8:	5b                   	pop    %ebx
     db9:	5e                   	pop    %esi
     dba:	5d                   	pop    %ebp
     dbb:	c3                   	ret    
     dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  printf(1, "exitwait ok\n");
     dc0:	b8 4b 49 00 00       	mov    $0x494b,%eax
     dc5:	89 44 24 04          	mov    %eax,0x4(%esp)
     dc9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     dd0:	e8 0b 34 00 00       	call   41e0 <printf>
}
     dd5:	83 c4 10             	add    $0x10,%esp
     dd8:	5b                   	pop    %ebx
     dd9:	5e                   	pop    %esi
     dda:	5d                   	pop    %ebp
     ddb:	c3                   	ret    
      exit(0);
     ddc:	e8 97 32 00 00       	call   4078 <exit>
     de1:	eb 0d                	jmp    df0 <mem>
     de3:	90                   	nop
     de4:	90                   	nop
     de5:	90                   	nop
     de6:	90                   	nop
     de7:	90                   	nop
     de8:	90                   	nop
     de9:	90                   	nop
     dea:	90                   	nop
     deb:	90                   	nop
     dec:	90                   	nop
     ded:	90                   	nop
     dee:	90                   	nop
     def:	90                   	nop

00000df0 <mem>:
{
     df0:	55                   	push   %ebp
  printf(1, "mem test\n");
     df1:	b9 58 49 00 00       	mov    $0x4958,%ecx
{
     df6:	89 e5                	mov    %esp,%ebp
     df8:	57                   	push   %edi
     df9:	56                   	push   %esi
     dfa:	53                   	push   %ebx
     dfb:	31 db                	xor    %ebx,%ebx
     dfd:	83 ec 1c             	sub    $0x1c,%esp
  printf(1, "mem test\n");
     e00:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     e04:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e0b:	e8 d0 33 00 00       	call   41e0 <printf>
  ppid = getpid();
     e10:	e8 e3 32 00 00       	call   40f8 <getpid>
     e15:	89 c6                	mov    %eax,%esi
  if((pid = fork()) == 0){
     e17:	e8 54 32 00 00       	call   4070 <fork>
     e1c:	85 c0                	test   %eax,%eax
     e1e:	74 0c                	je     e2c <mem+0x3c>
     e20:	e9 9b 00 00 00       	jmp    ec0 <mem+0xd0>
     e25:	8d 76 00             	lea    0x0(%esi),%esi
      *(char**)m2 = m1;
     e28:	89 18                	mov    %ebx,(%eax)
     e2a:	89 c3                	mov    %eax,%ebx
    while((m2 = malloc(10001)) != 0){
     e2c:	c7 04 24 11 27 00 00 	movl   $0x2711,(%esp)
     e33:	e8 38 36 00 00       	call   4470 <malloc>
     e38:	85 c0                	test   %eax,%eax
     e3a:	75 ec                	jne    e28 <mem+0x38>
    while(m1){
     e3c:	85 db                	test   %ebx,%ebx
     e3e:	74 10                	je     e50 <mem+0x60>
      m2 = *(char**)m1;
     e40:	8b 3b                	mov    (%ebx),%edi
      free(m1);
     e42:	89 1c 24             	mov    %ebx,(%esp)
     e45:	e8 86 35 00 00       	call   43d0 <free>
     e4a:	89 fb                	mov    %edi,%ebx
    while(m1){
     e4c:	85 db                	test   %ebx,%ebx
     e4e:	75 f0                	jne    e40 <mem+0x50>
    m1 = malloc(1024*20);
     e50:	c7 04 24 00 50 00 00 	movl   $0x5000,(%esp)
     e57:	e8 14 36 00 00       	call   4470 <malloc>
    if(m1 == 0){
     e5c:	85 c0                	test   %eax,%eax
     e5e:	74 30                	je     e90 <mem+0xa0>
    free(m1);
     e60:	89 04 24             	mov    %eax,(%esp)
     e63:	e8 68 35 00 00       	call   43d0 <free>
    printf(1, "mem ok\n");
     e68:	b8 7c 49 00 00       	mov    $0x497c,%eax
     e6d:	89 44 24 04          	mov    %eax,0x4(%esp)
     e71:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e78:	e8 63 33 00 00       	call   41e0 <printf>
    exit(0);
     e7d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     e84:	e8 ef 31 00 00       	call   4078 <exit>
     e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "couldn't allocate mem?!!\n");
     e90:	ba 62 49 00 00       	mov    $0x4962,%edx
     e95:	89 54 24 04          	mov    %edx,0x4(%esp)
     e99:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ea0:	e8 3b 33 00 00       	call   41e0 <printf>
      kill(ppid);
     ea5:	89 34 24             	mov    %esi,(%esp)
     ea8:	e8 fb 31 00 00       	call   40a8 <kill>
      exit(0);
     ead:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     eb4:	e8 bf 31 00 00       	call   4078 <exit>
     eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wait(0);
     ec0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     ec7:	e8 b4 31 00 00       	call   4080 <wait>
}
     ecc:	83 c4 1c             	add    $0x1c,%esp
     ecf:	5b                   	pop    %ebx
     ed0:	5e                   	pop    %esi
     ed1:	5f                   	pop    %edi
     ed2:	5d                   	pop    %ebp
     ed3:	c3                   	ret    
     ed4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     eda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000ee0 <sharedfd>:
{
     ee0:	55                   	push   %ebp
     ee1:	89 e5                	mov    %esp,%ebp
     ee3:	57                   	push   %edi
     ee4:	56                   	push   %esi
  fd = open("sharedfd", O_CREATE|O_RDWR);
     ee5:	be 02 02 00 00       	mov    $0x202,%esi
{
     eea:	53                   	push   %ebx
  printf(1, "sharedfd test\n");
     eeb:	bb 84 49 00 00       	mov    $0x4984,%ebx
{
     ef0:	83 ec 3c             	sub    $0x3c,%esp
  printf(1, "sharedfd test\n");
     ef3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     ef7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     efe:	e8 dd 32 00 00       	call   41e0 <printf>
  unlink("sharedfd");
     f03:	c7 04 24 93 49 00 00 	movl   $0x4993,(%esp)
     f0a:	e8 b9 31 00 00       	call   40c8 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     f0f:	89 74 24 04          	mov    %esi,0x4(%esp)
     f13:	c7 04 24 93 49 00 00 	movl   $0x4993,(%esp)
     f1a:	e8 99 31 00 00       	call   40b8 <open>
  if(fd < 0){
     f1f:	85 c0                	test   %eax,%eax
     f21:	0f 88 59 01 00 00    	js     1080 <sharedfd+0x1a0>
     f27:	89 c6                	mov    %eax,%esi
  memset(buf, pid==0?'c':'p', sizeof(buf));
     f29:	bb e8 03 00 00       	mov    $0x3e8,%ebx
  pid = fork();
     f2e:	e8 3d 31 00 00       	call   4070 <fork>
  memset(buf, pid==0?'c':'p', sizeof(buf));
     f33:	8d 7d de             	lea    -0x22(%ebp),%edi
     f36:	ba 0a 00 00 00       	mov    $0xa,%edx
     f3b:	89 54 24 08          	mov    %edx,0x8(%esp)
     f3f:	89 3c 24             	mov    %edi,(%esp)
     f42:	83 f8 01             	cmp    $0x1,%eax
  pid = fork();
     f45:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     f48:	19 c0                	sbb    %eax,%eax
     f4a:	83 e0 f3             	and    $0xfffffff3,%eax
     f4d:	83 c0 70             	add    $0x70,%eax
     f50:	89 44 24 04          	mov    %eax,0x4(%esp)
     f54:	e8 87 2f 00 00       	call   3ee0 <memset>
     f59:	eb 08                	jmp    f63 <sharedfd+0x83>
     f5b:	90                   	nop
     f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 1000; i++){
     f60:	4b                   	dec    %ebx
     f61:	74 2f                	je     f92 <sharedfd+0xb2>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     f63:	b8 0a 00 00 00       	mov    $0xa,%eax
     f68:	89 44 24 08          	mov    %eax,0x8(%esp)
     f6c:	89 7c 24 04          	mov    %edi,0x4(%esp)
     f70:	89 34 24             	mov    %esi,(%esp)
     f73:	e8 20 31 00 00       	call   4098 <write>
     f78:	83 f8 0a             	cmp    $0xa,%eax
     f7b:	74 e3                	je     f60 <sharedfd+0x80>
      printf(1, "fstests: write sharedfd failed\n");
     f7d:	b8 90 56 00 00       	mov    $0x5690,%eax
     f82:	89 44 24 04          	mov    %eax,0x4(%esp)
     f86:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f8d:	e8 4e 32 00 00       	call   41e0 <printf>
  if(pid == 0)
     f92:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    exit(0);
     f95:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  if(pid == 0)
     f9c:	85 c0                	test   %eax,%eax
     f9e:	0f 84 39 01 00 00    	je     10dd <sharedfd+0x1fd>
    wait(0);
     fa4:	e8 d7 30 00 00       	call   4080 <wait>
  fd = open("sharedfd", 0);
     fa9:	31 db                	xor    %ebx,%ebx
  close(fd);
     fab:	89 34 24             	mov    %esi,(%esp)
     fae:	e8 ed 30 00 00       	call   40a0 <close>
  fd = open("sharedfd", 0);
     fb3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     fb7:	c7 04 24 93 49 00 00 	movl   $0x4993,(%esp)
     fbe:	e8 f5 30 00 00       	call   40b8 <open>
  if(fd < 0){
     fc3:	85 c0                	test   %eax,%eax
  fd = open("sharedfd", 0);
     fc5:	89 45 d0             	mov    %eax,-0x30(%ebp)
  if(fd < 0){
     fc8:	0f 88 cf 00 00 00    	js     109d <sharedfd+0x1bd>
  nc = np = 0;
     fce:	31 db                	xor    %ebx,%ebx
     fd0:	31 c9                	xor    %ecx,%ecx
     fd2:	8d 75 e8             	lea    -0x18(%ebp),%esi
     fd5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  while((n = read(fd, buf, sizeof(buf))) > 0){
     fe0:	8b 45 d0             	mov    -0x30(%ebp),%eax
     fe3:	ba 0a 00 00 00       	mov    $0xa,%edx
     fe8:	89 54 24 08          	mov    %edx,0x8(%esp)
     fec:	89 7c 24 04          	mov    %edi,0x4(%esp)
     ff0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
     ff3:	89 04 24             	mov    %eax,(%esp)
     ff6:	e8 95 30 00 00       	call   4090 <read>
     ffb:	85 c0                	test   %eax,%eax
     ffd:	7e 31                	jle    1030 <sharedfd+0x150>
     fff:	89 f8                	mov    %edi,%eax
    1001:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1004:	eb 1a                	jmp    1020 <sharedfd+0x140>
    1006:	8d 76 00             	lea    0x0(%esi),%esi
    1009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        np++;
    1010:	80 fa 70             	cmp    $0x70,%dl
    1013:	0f 94 c2             	sete   %dl
    1016:	0f b6 d2             	movzbl %dl,%edx
    1019:	01 d3                	add    %edx,%ebx
    101b:	40                   	inc    %eax
    for(i = 0; i < sizeof(buf); i++){
    101c:	39 f0                	cmp    %esi,%eax
    101e:	74 c0                	je     fe0 <sharedfd+0x100>
      if(buf[i] == 'c')
    1020:	0f b6 10             	movzbl (%eax),%edx
    1023:	80 fa 63             	cmp    $0x63,%dl
    1026:	75 e8                	jne    1010 <sharedfd+0x130>
        nc++;
    1028:	41                   	inc    %ecx
    1029:	eb f0                	jmp    101b <sharedfd+0x13b>
    102b:	90                   	nop
    102c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  close(fd);
    1030:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1033:	89 04 24             	mov    %eax,(%esp)
    1036:	e8 65 30 00 00       	call   40a0 <close>
  unlink("sharedfd");
    103b:	c7 04 24 93 49 00 00 	movl   $0x4993,(%esp)
    1042:	e8 81 30 00 00       	call   40c8 <unlink>
  if(nc == 10000 && np == 10000){
    1047:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    104a:	81 f9 10 27 00 00    	cmp    $0x2710,%ecx
    1050:	75 68                	jne    10ba <sharedfd+0x1da>
    1052:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
    1058:	75 60                	jne    10ba <sharedfd+0x1da>
    printf(1, "sharedfd ok\n");
    105a:	b8 9c 49 00 00       	mov    $0x499c,%eax
    105f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1063:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    106a:	e8 71 31 00 00       	call   41e0 <printf>
}
    106f:	83 c4 3c             	add    $0x3c,%esp
    1072:	5b                   	pop    %ebx
    1073:	5e                   	pop    %esi
    1074:	5f                   	pop    %edi
    1075:	5d                   	pop    %ebp
    1076:	c3                   	ret    
    1077:	89 f6                	mov    %esi,%esi
    1079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    printf(1, "fstests: cannot open sharedfd for writing");
    1080:	b9 64 56 00 00       	mov    $0x5664,%ecx
    1085:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    1089:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1090:	e8 4b 31 00 00       	call   41e0 <printf>
}
    1095:	83 c4 3c             	add    $0x3c,%esp
    1098:	5b                   	pop    %ebx
    1099:	5e                   	pop    %esi
    109a:	5f                   	pop    %edi
    109b:	5d                   	pop    %ebp
    109c:	c3                   	ret    
    printf(1, "fstests: cannot open sharedfd for reading\n");
    109d:	b9 b0 56 00 00       	mov    $0x56b0,%ecx
    10a2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    10a6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10ad:	e8 2e 31 00 00       	call   41e0 <printf>
}
    10b2:	83 c4 3c             	add    $0x3c,%esp
    10b5:	5b                   	pop    %ebx
    10b6:	5e                   	pop    %esi
    10b7:	5f                   	pop    %edi
    10b8:	5d                   	pop    %ebp
    10b9:	c3                   	ret    
    printf(1, "sharedfd oops %d %d\n", nc, np);
    10ba:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    10be:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    10c2:	c7 44 24 04 a9 49 00 	movl   $0x49a9,0x4(%esp)
    10c9:	00 
    10ca:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10d1:	e8 0a 31 00 00       	call   41e0 <printf>
    exit(0);
    10d6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    10dd:	e8 96 2f 00 00       	call   4078 <exit>
    10e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000010f0 <fourfiles>:
{
    10f0:	55                   	push   %ebp
  printf(1, "fourfiles test\n");
    10f1:	b8 c4 49 00 00       	mov    $0x49c4,%eax
{
    10f6:	89 e5                	mov    %esp,%ebp
    10f8:	57                   	push   %edi
    10f9:	56                   	push   %esi
  printf(1, "fourfiles test\n");
    10fa:	be be 49 00 00       	mov    $0x49be,%esi
{
    10ff:	53                   	push   %ebx
  for(pi = 0; pi < 4; pi++){
    1100:	31 db                	xor    %ebx,%ebx
{
    1102:	83 ec 3c             	sub    $0x3c,%esp
  printf(1, "fourfiles test\n");
    1105:	89 44 24 04          	mov    %eax,0x4(%esp)
    1109:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  char *names[] = { "f0", "f1", "f2", "f3" };
    1110:	c7 45 d8 be 49 00 00 	movl   $0x49be,-0x28(%ebp)
    1117:	c7 45 dc 13 4b 00 00 	movl   $0x4b13,-0x24(%ebp)
    111e:	c7 45 e0 17 4b 00 00 	movl   $0x4b17,-0x20(%ebp)
    1125:	c7 45 e4 c1 49 00 00 	movl   $0x49c1,-0x1c(%ebp)
  printf(1, "fourfiles test\n");
    112c:	e8 af 30 00 00       	call   41e0 <printf>
    unlink(fname);
    1131:	89 34 24             	mov    %esi,(%esp)
    1134:	e8 8f 2f 00 00       	call   40c8 <unlink>
    pid = fork();
    1139:	e8 32 2f 00 00       	call   4070 <fork>
    if(pid < 0){
    113e:	85 c0                	test   %eax,%eax
    1140:	0f 88 a8 01 00 00    	js     12ee <fourfiles+0x1fe>
    if(pid == 0){
    1146:	0f 84 f5 00 00 00    	je     1241 <fourfiles+0x151>
  for(pi = 0; pi < 4; pi++){
    114c:	43                   	inc    %ebx
    114d:	83 fb 04             	cmp    $0x4,%ebx
    1150:	74 06                	je     1158 <fourfiles+0x68>
    1152:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    1156:	eb d9                	jmp    1131 <fourfiles+0x41>
    wait(0);
    1158:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  for(i = 0; i < 2; i++){
    115f:	31 ff                	xor    %edi,%edi
    wait(0);
    1161:	e8 1a 2f 00 00       	call   4080 <wait>
    1166:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    116d:	e8 0e 2f 00 00       	call   4080 <wait>
    1172:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1179:	e8 02 2f 00 00       	call   4080 <wait>
    117e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1185:	e8 f6 2e 00 00       	call   4080 <wait>
    118a:	c7 45 d0 be 49 00 00 	movl   $0x49be,-0x30(%ebp)
    fd = open(fname, 0);
    1191:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1194:	31 f6                	xor    %esi,%esi
    1196:	89 74 24 04          	mov    %esi,0x4(%esp)
    119a:	89 04 24             	mov    %eax,(%esp)
    119d:	e8 16 2f 00 00       	call   40b8 <open>
    total = 0;
    11a2:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    fd = open(fname, 0);
    11a9:	89 c3                	mov    %eax,%ebx
    11ab:	90                   	nop
    11ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while((n = read(fd, buf, sizeof(buf))) > 0){
    11b0:	ba 00 20 00 00       	mov    $0x2000,%edx
    11b5:	b9 00 8e 00 00       	mov    $0x8e00,%ecx
    11ba:	89 54 24 08          	mov    %edx,0x8(%esp)
    11be:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    11c2:	89 1c 24             	mov    %ebx,(%esp)
    11c5:	e8 c6 2e 00 00       	call   4090 <read>
    11ca:	85 c0                	test   %eax,%eax
    11cc:	7e 23                	jle    11f1 <fourfiles+0x101>
      for(j = 0; j < n; j++){
    11ce:	31 d2                	xor    %edx,%edx
        if(buf[j] != '0'+i){
    11d0:	0f be b2 00 8e 00 00 	movsbl 0x8e00(%edx),%esi
    11d7:	83 ff 01             	cmp    $0x1,%edi
    11da:	19 c9                	sbb    %ecx,%ecx
    11dc:	83 c1 31             	add    $0x31,%ecx
    11df:	39 ce                	cmp    %ecx,%esi
    11e1:	0f 85 c6 00 00 00    	jne    12ad <fourfiles+0x1bd>
      for(j = 0; j < n; j++){
    11e7:	42                   	inc    %edx
    11e8:	39 d0                	cmp    %edx,%eax
    11ea:	75 e4                	jne    11d0 <fourfiles+0xe0>
      total += n;
    11ec:	01 45 d4             	add    %eax,-0x2c(%ebp)
    11ef:	eb bf                	jmp    11b0 <fourfiles+0xc0>
    close(fd);
    11f1:	89 1c 24             	mov    %ebx,(%esp)
    11f4:	e8 a7 2e 00 00       	call   40a0 <close>
    if(total != 12*500){
    11f9:	81 7d d4 70 17 00 00 	cmpl   $0x1770,-0x2c(%ebp)
    1200:	0f 85 08 01 00 00    	jne    130e <fourfiles+0x21e>
    unlink(fname);
    1206:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1209:	89 04 24             	mov    %eax,(%esp)
    120c:	e8 b7 2e 00 00       	call   40c8 <unlink>
  for(i = 0; i < 2; i++){
    1211:	4f                   	dec    %edi
    1212:	75 1d                	jne    1231 <fourfiles+0x141>
  printf(1, "fourfiles ok\n");
    1214:	b8 02 4a 00 00       	mov    $0x4a02,%eax
    1219:	89 44 24 04          	mov    %eax,0x4(%esp)
    121d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1224:	e8 b7 2f 00 00       	call   41e0 <printf>
}
    1229:	83 c4 3c             	add    $0x3c,%esp
    122c:	5b                   	pop    %ebx
    122d:	5e                   	pop    %esi
    122e:	5f                   	pop    %edi
    122f:	5d                   	pop    %ebp
    1230:	c3                   	ret    
    1231:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1234:	bf 01 00 00 00       	mov    $0x1,%edi
    1239:	89 45 d0             	mov    %eax,-0x30(%ebp)
    123c:	e9 50 ff ff ff       	jmp    1191 <fourfiles+0xa1>
      fd = open(fname, O_CREATE | O_RDWR);
    1241:	b8 02 02 00 00       	mov    $0x202,%eax
    1246:	89 34 24             	mov    %esi,(%esp)
    1249:	89 44 24 04          	mov    %eax,0x4(%esp)
    124d:	e8 66 2e 00 00       	call   40b8 <open>
      if(fd < 0){
    1252:	85 c0                	test   %eax,%eax
      fd = open(fname, O_CREATE | O_RDWR);
    1254:	89 c6                	mov    %eax,%esi
      if(fd < 0){
    1256:	78 76                	js     12ce <fourfiles+0x1de>
      memset(buf, '0'+pi, 512);
    1258:	b8 00 02 00 00       	mov    $0x200,%eax
    125d:	83 c3 30             	add    $0x30,%ebx
    1260:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    1264:	bb 0c 00 00 00       	mov    $0xc,%ebx
    1269:	89 44 24 08          	mov    %eax,0x8(%esp)
    126d:	c7 04 24 00 8e 00 00 	movl   $0x8e00,(%esp)
    1274:	e8 67 2c 00 00       	call   3ee0 <memset>
        if((n = write(fd, buf, 500)) != 500){
    1279:	b8 00 8e 00 00       	mov    $0x8e00,%eax
    127e:	bf f4 01 00 00       	mov    $0x1f4,%edi
    1283:	89 7c 24 08          	mov    %edi,0x8(%esp)
    1287:	89 44 24 04          	mov    %eax,0x4(%esp)
    128b:	89 34 24             	mov    %esi,(%esp)
    128e:	e8 05 2e 00 00       	call   4098 <write>
    1293:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    1298:	0f 85 97 00 00 00    	jne    1335 <fourfiles+0x245>
      for(i = 0; i < 12; i++){
    129e:	4b                   	dec    %ebx
    129f:	75 d8                	jne    1279 <fourfiles+0x189>
          exit(0);
    12a1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    12a8:	e8 cb 2d 00 00       	call   4078 <exit>
          printf(1, "wrong char\n");
    12ad:	bb e5 49 00 00       	mov    $0x49e5,%ebx
    12b2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    12b6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12bd:	e8 1e 2f 00 00       	call   41e0 <printf>
          exit(0);
    12c2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    12c9:	e8 aa 2d 00 00       	call   4078 <exit>
        printf(1, "create failed\n");
    12ce:	c7 44 24 04 6b 4c 00 	movl   $0x4c6b,0x4(%esp)
    12d5:	00 
    12d6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12dd:	e8 fe 2e 00 00       	call   41e0 <printf>
        exit(0);
    12e2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    12e9:	e8 8a 2d 00 00       	call   4078 <exit>
      printf(1, "fork failed\n");
    12ee:	c7 44 24 04 a5 54 00 	movl   $0x54a5,0x4(%esp)
    12f5:	00 
    12f6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12fd:	e8 de 2e 00 00       	call   41e0 <printf>
      exit(0);
    1302:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1309:	e8 6a 2d 00 00       	call   4078 <exit>
      printf(1, "wrong length %d\n", total);
    130e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1311:	c7 44 24 04 f1 49 00 	movl   $0x49f1,0x4(%esp)
    1318:	00 
    1319:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1320:	89 44 24 08          	mov    %eax,0x8(%esp)
    1324:	e8 b7 2e 00 00       	call   41e0 <printf>
      exit(0);
    1329:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1330:	e8 43 2d 00 00       	call   4078 <exit>
          printf(1, "write failed %d\n", n);
    1335:	89 44 24 08          	mov    %eax,0x8(%esp)
    1339:	c7 44 24 04 d4 49 00 	movl   $0x49d4,0x4(%esp)
    1340:	00 
    1341:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1348:	e8 93 2e 00 00       	call   41e0 <printf>
          exit(0);
    134d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1354:	e8 1f 2d 00 00       	call   4078 <exit>
    1359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001360 <createdelete>:
{
    1360:	55                   	push   %ebp
  printf(1, "createdelete test\n");
    1361:	b8 10 4a 00 00       	mov    $0x4a10,%eax
{
    1366:	89 e5                	mov    %esp,%ebp
    1368:	57                   	push   %edi
    1369:	56                   	push   %esi
    136a:	53                   	push   %ebx
  for(pi = 0; pi < 4; pi++){
    136b:	31 db                	xor    %ebx,%ebx
{
    136d:	83 ec 4c             	sub    $0x4c,%esp
  printf(1, "createdelete test\n");
    1370:	89 44 24 04          	mov    %eax,0x4(%esp)
    1374:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    137b:	e8 60 2e 00 00       	call   41e0 <printf>
    pid = fork();
    1380:	e8 eb 2c 00 00       	call   4070 <fork>
    if(pid < 0){
    1385:	85 c0                	test   %eax,%eax
    1387:	0f 88 10 02 00 00    	js     159d <createdelete+0x23d>
    138d:	8d 76 00             	lea    0x0(%esi),%esi
    if(pid == 0){
    1390:	0f 84 3a 01 00 00    	je     14d0 <createdelete+0x170>
  for(pi = 0; pi < 4; pi++){
    1396:	43                   	inc    %ebx
    1397:	83 fb 04             	cmp    $0x4,%ebx
    139a:	75 e4                	jne    1380 <createdelete+0x20>
    wait(0);
    139c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  printf(1, "after wait\n");
    13a3:	bb 23 4a 00 00       	mov    $0x4a23,%ebx
  name[0] = name[1] = name[2] = 0;
    13a8:	bf ff ff ff ff       	mov    $0xffffffff,%edi
    wait(0);
    13ad:	e8 ce 2c 00 00       	call   4080 <wait>
    13b2:	8d 75 c8             	lea    -0x38(%ebp),%esi
    13b5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    13bc:	e8 bf 2c 00 00       	call   4080 <wait>
    13c1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    13c8:	e8 b3 2c 00 00       	call   4080 <wait>
    13cd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    13d4:	e8 a7 2c 00 00       	call   4080 <wait>
  printf(1, "after wait\n");
    13d9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    13dd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13e4:	e8 f7 2d 00 00       	call   41e0 <printf>
  name[0] = name[1] = name[2] = 0;
    13e9:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    13ed:	c6 45 c7 30          	movb   $0x30,-0x39(%ebp)
  for(i = 0; i < N; i++){
    13f1:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    13f8:	90                   	nop
    13f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1400:	8b 45 c0             	mov    -0x40(%ebp),%eax
      name[2] = '\0';
    1403:	b3 70                	mov    $0x70,%bl
    1405:	83 f8 09             	cmp    $0x9,%eax
    1408:	0f 9f c2             	setg   %dl
    140b:	85 c0                	test   %eax,%eax
    140d:	0f 94 c0             	sete   %al
    1410:	08 c2                	or     %al,%dl
    1412:	88 55 c6             	mov    %dl,-0x3a(%ebp)
      name[1] = '0' + i;
    1415:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
      fd = open(name, 0);
    1419:	31 c9                	xor    %ecx,%ecx
    141b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    141f:	89 34 24             	mov    %esi,(%esp)
      name[0] = 'p' + pi;
    1422:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[1] = '0' + i;
    1425:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    1428:	e8 8b 2c 00 00       	call   40b8 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    142d:	80 7d c6 00          	cmpb   $0x0,-0x3a(%ebp)
    1431:	0f 84 81 00 00 00    	je     14b8 <createdelete+0x158>
    1437:	85 c0                	test   %eax,%eax
    1439:	0f 88 19 01 00 00    	js     1558 <createdelete+0x1f8>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    143f:	83 ff 08             	cmp    $0x8,%edi
    1442:	0f 86 7d 01 00 00    	jbe    15c5 <createdelete+0x265>
        close(fd);
    1448:	89 04 24             	mov    %eax,(%esp)
    144b:	e8 50 2c 00 00       	call   40a0 <close>
    1450:	fe c3                	inc    %bl
    for(pi = 0; pi < 4; pi++){
    1452:	80 fb 74             	cmp    $0x74,%bl
    1455:	75 be                	jne    1415 <createdelete+0xb5>
  for(i = 0; i < N; i++){
    1457:	ff 45 c0             	incl   -0x40(%ebp)
    145a:	47                   	inc    %edi
    145b:	fe 45 c7             	incb   -0x39(%ebp)
    145e:	8b 55 c0             	mov    -0x40(%ebp),%edx
    1461:	83 fa 14             	cmp    $0x14,%edx
    1464:	75 9a                	jne    1400 <createdelete+0xa0>
    1466:	b3 70                	mov    $0x70,%bl
    1468:	90                   	nop
    1469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1470:	88 d8                	mov    %bl,%al
    1472:	bf 04 00 00 00       	mov    $0x4,%edi
    1477:	2c 40                	sub    $0x40,%al
    1479:	88 45 c7             	mov    %al,-0x39(%ebp)
      name[1] = '0' + i;
    147c:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
      unlink(name);
    1480:	89 34 24             	mov    %esi,(%esp)
      name[0] = 'p' + i;
    1483:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[1] = '0' + i;
    1486:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    1489:	e8 3a 2c 00 00       	call   40c8 <unlink>
    for(pi = 0; pi < 4; pi++){
    148e:	4f                   	dec    %edi
    148f:	75 eb                	jne    147c <createdelete+0x11c>
    1491:	fe c3                	inc    %bl
  for(i = 0; i < N; i++){
    1493:	80 fb 84             	cmp    $0x84,%bl
    1496:	75 d8                	jne    1470 <createdelete+0x110>
  printf(1, "createdelete ok\n");
    1498:	b8 2f 4a 00 00       	mov    $0x4a2f,%eax
    149d:	89 44 24 04          	mov    %eax,0x4(%esp)
    14a1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14a8:	e8 33 2d 00 00       	call   41e0 <printf>
}
    14ad:	83 c4 4c             	add    $0x4c,%esp
    14b0:	5b                   	pop    %ebx
    14b1:	5e                   	pop    %esi
    14b2:	5f                   	pop    %edi
    14b3:	5d                   	pop    %ebp
    14b4:	c3                   	ret    
    14b5:	8d 76 00             	lea    0x0(%esi),%esi
      } else if((i >= 1 && i < N/2) && fd >= 0){
    14b8:	83 ff 08             	cmp    $0x8,%edi
    14bb:	0f 86 fc 00 00 00    	jbe    15bd <createdelete+0x25d>
      if(fd >= 0)
    14c1:	85 c0                	test   %eax,%eax
    14c3:	78 8b                	js     1450 <createdelete+0xf0>
    14c5:	e9 7e ff ff ff       	jmp    1448 <createdelete+0xe8>
    14ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      name[0] = 'p' + pi;
    14d0:	80 c3 70             	add    $0x70,%bl
      name[2] = '\0';
    14d3:	31 ff                	xor    %edi,%edi
      name[0] = 'p' + pi;
    14d5:	88 5d c8             	mov    %bl,-0x38(%ebp)
    14d8:	8d 75 c8             	lea    -0x38(%ebp),%esi
      name[2] = '\0';
    14db:	b3 30                	mov    $0x30,%bl
    14dd:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    14e1:	eb 11                	jmp    14f4 <createdelete+0x194>
    14e3:	90                   	nop
    14e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i = 0; i < N; i++){
    14e8:	83 ff 13             	cmp    $0x13,%edi
    14eb:	0f 84 80 00 00 00    	je     1571 <createdelete+0x211>
    14f1:	47                   	inc    %edi
    14f2:	fe c3                	inc    %bl
        fd = open(name, O_CREATE | O_RDWR);
    14f4:	b8 02 02 00 00       	mov    $0x202,%eax
    14f9:	89 44 24 04          	mov    %eax,0x4(%esp)
    14fd:	89 34 24             	mov    %esi,(%esp)
        name[1] = '0' + i;
    1500:	88 5d c9             	mov    %bl,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    1503:	e8 b0 2b 00 00       	call   40b8 <open>
        if(fd < 0){
    1508:	85 c0                	test   %eax,%eax
    150a:	78 71                	js     157d <createdelete+0x21d>
        close(fd);
    150c:	89 04 24             	mov    %eax,(%esp)
    150f:	e8 8c 2b 00 00       	call   40a0 <close>
        if(i > 0 && (i % 2 ) == 0){
    1514:	85 ff                	test   %edi,%edi
    1516:	74 d9                	je     14f1 <createdelete+0x191>
    1518:	f7 c7 01 00 00 00    	test   $0x1,%edi
    151e:	75 c8                	jne    14e8 <createdelete+0x188>
          name[1] = '0' + (i / 2);
    1520:	89 f8                	mov    %edi,%eax
    1522:	d1 f8                	sar    %eax
    1524:	04 30                	add    $0x30,%al
          if(unlink(name) < 0){
    1526:	89 34 24             	mov    %esi,(%esp)
          name[1] = '0' + (i / 2);
    1529:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    152c:	e8 97 2b 00 00       	call   40c8 <unlink>
    1531:	85 c0                	test   %eax,%eax
    1533:	79 b3                	jns    14e8 <createdelete+0x188>
            printf(1, "unlink failed\n");
    1535:	c7 44 24 04 11 46 00 	movl   $0x4611,0x4(%esp)
    153c:	00 
    153d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1544:	e8 97 2c 00 00       	call   41e0 <printf>
            exit(0);
    1549:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1550:	e8 23 2b 00 00       	call   4078 <exit>
    1555:	8d 76 00             	lea    0x0(%esi),%esi
        printf(1, "oops createdelete %s didn't exist\n", name);
    1558:	ba dc 56 00 00       	mov    $0x56dc,%edx
    155d:	89 74 24 08          	mov    %esi,0x8(%esp)
    1561:	89 54 24 04          	mov    %edx,0x4(%esp)
    1565:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    156c:	e8 6f 2c 00 00       	call   41e0 <printf>
        exit(0);
    1571:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1578:	e8 fb 2a 00 00       	call   4078 <exit>
          printf(1, "create failed\n");
    157d:	c7 44 24 04 6b 4c 00 	movl   $0x4c6b,0x4(%esp)
    1584:	00 
    1585:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    158c:	e8 4f 2c 00 00       	call   41e0 <printf>
          exit(0);
    1591:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1598:	e8 db 2a 00 00       	call   4078 <exit>
      printf(1, "fork failed\n");
    159d:	c7 44 24 04 a5 54 00 	movl   $0x54a5,0x4(%esp)
    15a4:	00 
    15a5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15ac:	e8 2f 2c 00 00       	call   41e0 <printf>
      exit(0);
    15b1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    15b8:	e8 bb 2a 00 00       	call   4078 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    15bd:	85 c0                	test   %eax,%eax
    15bf:	0f 88 8b fe ff ff    	js     1450 <createdelete+0xf0>
        printf(1, "oops createdelete %s did exist\n", name);
    15c5:	89 74 24 08          	mov    %esi,0x8(%esp)
    15c9:	c7 44 24 04 00 57 00 	movl   $0x5700,0x4(%esp)
    15d0:	00 
    15d1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15d8:	e8 03 2c 00 00       	call   41e0 <printf>
        exit(0);
    15dd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    15e4:	e8 8f 2a 00 00       	call   4078 <exit>
    15e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000015f0 <unlinkread>:
{
    15f0:	55                   	push   %ebp
  printf(1, "unlinkread test\n");
    15f1:	b9 40 4a 00 00       	mov    $0x4a40,%ecx
{
    15f6:	89 e5                	mov    %esp,%ebp
    15f8:	56                   	push   %esi
    15f9:	53                   	push   %ebx
  fd = open("unlinkread", O_CREATE | O_RDWR);
    15fa:	bb 02 02 00 00       	mov    $0x202,%ebx
{
    15ff:	83 ec 10             	sub    $0x10,%esp
  printf(1, "unlinkread test\n");
    1602:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    1606:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    160d:	e8 ce 2b 00 00       	call   41e0 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1612:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    1616:	c7 04 24 51 4a 00 00 	movl   $0x4a51,(%esp)
    161d:	e8 96 2a 00 00       	call   40b8 <open>
  if(fd < 0){
    1622:	85 c0                	test   %eax,%eax
    1624:	0f 88 0f 01 00 00    	js     1739 <unlinkread+0x149>
    162a:	89 c3                	mov    %eax,%ebx
  write(fd, "hello", 5);
    162c:	b8 05 00 00 00       	mov    $0x5,%eax
    1631:	89 44 24 08          	mov    %eax,0x8(%esp)
    1635:	b8 76 4a 00 00       	mov    $0x4a76,%eax
    163a:	89 1c 24             	mov    %ebx,(%esp)
    163d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1641:	e8 52 2a 00 00       	call   4098 <write>
  close(fd);
    1646:	89 1c 24             	mov    %ebx,(%esp)
    1649:	e8 52 2a 00 00       	call   40a0 <close>
  fd = open("unlinkread", O_RDWR);
    164e:	ba 02 00 00 00       	mov    $0x2,%edx
    1653:	89 54 24 04          	mov    %edx,0x4(%esp)
    1657:	c7 04 24 51 4a 00 00 	movl   $0x4a51,(%esp)
    165e:	e8 55 2a 00 00       	call   40b8 <open>
  if(fd < 0){
    1663:	85 c0                	test   %eax,%eax
  fd = open("unlinkread", O_RDWR);
    1665:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1667:	0f 88 6c 01 00 00    	js     17d9 <unlinkread+0x1e9>
  if(unlink("unlinkread") != 0){
    166d:	c7 04 24 51 4a 00 00 	movl   $0x4a51,(%esp)
    1674:	e8 4f 2a 00 00       	call   40c8 <unlink>
    1679:	85 c0                	test   %eax,%eax
    167b:	0f 85 38 01 00 00    	jne    17b9 <unlinkread+0x1c9>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    1681:	be 02 02 00 00       	mov    $0x202,%esi
    1686:	89 74 24 04          	mov    %esi,0x4(%esp)
    168a:	c7 04 24 51 4a 00 00 	movl   $0x4a51,(%esp)
    1691:	e8 22 2a 00 00       	call   40b8 <open>
    1696:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    1698:	b8 03 00 00 00       	mov    $0x3,%eax
    169d:	89 44 24 08          	mov    %eax,0x8(%esp)
    16a1:	b8 ae 4a 00 00       	mov    $0x4aae,%eax
    16a6:	89 44 24 04          	mov    %eax,0x4(%esp)
    16aa:	89 34 24             	mov    %esi,(%esp)
    16ad:	e8 e6 29 00 00       	call   4098 <write>
  close(fd1);
    16b2:	89 34 24             	mov    %esi,(%esp)
    16b5:	e8 e6 29 00 00       	call   40a0 <close>
  if(read(fd, buf, sizeof(buf)) != 5){
    16ba:	b8 00 20 00 00       	mov    $0x2000,%eax
    16bf:	89 44 24 08          	mov    %eax,0x8(%esp)
    16c3:	b8 00 8e 00 00       	mov    $0x8e00,%eax
    16c8:	89 44 24 04          	mov    %eax,0x4(%esp)
    16cc:	89 1c 24             	mov    %ebx,(%esp)
    16cf:	e8 bc 29 00 00       	call   4090 <read>
    16d4:	83 f8 05             	cmp    $0x5,%eax
    16d7:	0f 85 bc 00 00 00    	jne    1799 <unlinkread+0x1a9>
  if(buf[0] != 'h'){
    16dd:	80 3d 00 8e 00 00 68 	cmpb   $0x68,0x8e00
    16e4:	0f 85 8f 00 00 00    	jne    1779 <unlinkread+0x189>
  if(write(fd, buf, 10) != 10){
    16ea:	ba 0a 00 00 00       	mov    $0xa,%edx
    16ef:	b9 00 8e 00 00       	mov    $0x8e00,%ecx
    16f4:	89 54 24 08          	mov    %edx,0x8(%esp)
    16f8:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    16fc:	89 1c 24             	mov    %ebx,(%esp)
    16ff:	e8 94 29 00 00       	call   4098 <write>
    1704:	83 f8 0a             	cmp    $0xa,%eax
    1707:	75 50                	jne    1759 <unlinkread+0x169>
  close(fd);
    1709:	89 1c 24             	mov    %ebx,(%esp)
    170c:	e8 8f 29 00 00       	call   40a0 <close>
  unlink("unlinkread");
    1711:	c7 04 24 51 4a 00 00 	movl   $0x4a51,(%esp)
    1718:	e8 ab 29 00 00       	call   40c8 <unlink>
  printf(1, "unlinkread ok\n");
    171d:	b8 f9 4a 00 00       	mov    $0x4af9,%eax
    1722:	89 44 24 04          	mov    %eax,0x4(%esp)
    1726:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    172d:	e8 ae 2a 00 00       	call   41e0 <printf>
}
    1732:	83 c4 10             	add    $0x10,%esp
    1735:	5b                   	pop    %ebx
    1736:	5e                   	pop    %esi
    1737:	5d                   	pop    %ebp
    1738:	c3                   	ret    
    printf(1, "create unlinkread failed\n");
    1739:	c7 44 24 04 5c 4a 00 	movl   $0x4a5c,0x4(%esp)
    1740:	00 
    1741:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1748:	e8 93 2a 00 00       	call   41e0 <printf>
    exit(0);
    174d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1754:	e8 1f 29 00 00       	call   4078 <exit>
    printf(1, "unlinkread write failed\n");
    1759:	c7 44 24 04 e0 4a 00 	movl   $0x4ae0,0x4(%esp)
    1760:	00 
    1761:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1768:	e8 73 2a 00 00       	call   41e0 <printf>
    exit(0);
    176d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1774:	e8 ff 28 00 00       	call   4078 <exit>
    printf(1, "unlinkread wrong data\n");
    1779:	c7 44 24 04 c9 4a 00 	movl   $0x4ac9,0x4(%esp)
    1780:	00 
    1781:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1788:	e8 53 2a 00 00       	call   41e0 <printf>
    exit(0);
    178d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1794:	e8 df 28 00 00       	call   4078 <exit>
    printf(1, "unlinkread read failed");
    1799:	c7 44 24 04 b2 4a 00 	movl   $0x4ab2,0x4(%esp)
    17a0:	00 
    17a1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17a8:	e8 33 2a 00 00       	call   41e0 <printf>
    exit(0);
    17ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    17b4:	e8 bf 28 00 00       	call   4078 <exit>
    printf(1, "unlink unlinkread failed\n");
    17b9:	c7 44 24 04 94 4a 00 	movl   $0x4a94,0x4(%esp)
    17c0:	00 
    17c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17c8:	e8 13 2a 00 00       	call   41e0 <printf>
    exit(0);
    17cd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    17d4:	e8 9f 28 00 00       	call   4078 <exit>
    printf(1, "open unlinkread failed\n");
    17d9:	c7 44 24 04 7c 4a 00 	movl   $0x4a7c,0x4(%esp)
    17e0:	00 
    17e1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17e8:	e8 f3 29 00 00       	call   41e0 <printf>
    exit(0);
    17ed:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    17f4:	e8 7f 28 00 00       	call   4078 <exit>
    17f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001800 <linktest>:
{
    1800:	55                   	push   %ebp
  printf(1, "linktest\n");
    1801:	b9 08 4b 00 00       	mov    $0x4b08,%ecx
{
    1806:	89 e5                	mov    %esp,%ebp
    1808:	53                   	push   %ebx
  fd = open("lf1", O_CREATE|O_RDWR);
    1809:	bb 02 02 00 00       	mov    $0x202,%ebx
{
    180e:	83 ec 14             	sub    $0x14,%esp
  printf(1, "linktest\n");
    1811:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    1815:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    181c:	e8 bf 29 00 00       	call   41e0 <printf>
  unlink("lf1");
    1821:	c7 04 24 12 4b 00 00 	movl   $0x4b12,(%esp)
    1828:	e8 9b 28 00 00       	call   40c8 <unlink>
  unlink("lf2");
    182d:	c7 04 24 16 4b 00 00 	movl   $0x4b16,(%esp)
    1834:	e8 8f 28 00 00       	call   40c8 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
    1839:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    183d:	c7 04 24 12 4b 00 00 	movl   $0x4b12,(%esp)
    1844:	e8 6f 28 00 00       	call   40b8 <open>
  if(fd < 0){
    1849:	85 c0                	test   %eax,%eax
    184b:	0f 88 2d 01 00 00    	js     197e <linktest+0x17e>
    1851:	89 c3                	mov    %eax,%ebx
  if(write(fd, "hello", 5) != 5){
    1853:	ba 76 4a 00 00       	mov    $0x4a76,%edx
    1858:	b8 05 00 00 00       	mov    $0x5,%eax
    185d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1861:	89 54 24 04          	mov    %edx,0x4(%esp)
    1865:	89 1c 24             	mov    %ebx,(%esp)
    1868:	e8 2b 28 00 00       	call   4098 <write>
    186d:	83 f8 05             	cmp    $0x5,%eax
    1870:	0f 85 08 02 00 00    	jne    1a7e <linktest+0x27e>
  close(fd);
    1876:	89 1c 24             	mov    %ebx,(%esp)
    1879:	e8 22 28 00 00       	call   40a0 <close>
  if(link("lf1", "lf2") < 0){
    187e:	b8 16 4b 00 00       	mov    $0x4b16,%eax
    1883:	89 44 24 04          	mov    %eax,0x4(%esp)
    1887:	c7 04 24 12 4b 00 00 	movl   $0x4b12,(%esp)
    188e:	e8 45 28 00 00       	call   40d8 <link>
    1893:	85 c0                	test   %eax,%eax
    1895:	0f 88 c3 01 00 00    	js     1a5e <linktest+0x25e>
  unlink("lf1");
    189b:	c7 04 24 12 4b 00 00 	movl   $0x4b12,(%esp)
    18a2:	e8 21 28 00 00       	call   40c8 <unlink>
  if(open("lf1", 0) >= 0){
    18a7:	31 c0                	xor    %eax,%eax
    18a9:	89 44 24 04          	mov    %eax,0x4(%esp)
    18ad:	c7 04 24 12 4b 00 00 	movl   $0x4b12,(%esp)
    18b4:	e8 ff 27 00 00       	call   40b8 <open>
    18b9:	85 c0                	test   %eax,%eax
    18bb:	0f 89 7d 01 00 00    	jns    1a3e <linktest+0x23e>
  fd = open("lf2", 0);
    18c1:	31 c0                	xor    %eax,%eax
    18c3:	89 44 24 04          	mov    %eax,0x4(%esp)
    18c7:	c7 04 24 16 4b 00 00 	movl   $0x4b16,(%esp)
    18ce:	e8 e5 27 00 00       	call   40b8 <open>
  if(fd < 0){
    18d3:	85 c0                	test   %eax,%eax
  fd = open("lf2", 0);
    18d5:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    18d7:	0f 88 41 01 00 00    	js     1a1e <linktest+0x21e>
  if(read(fd, buf, sizeof(buf)) != 5){
    18dd:	b8 00 20 00 00       	mov    $0x2000,%eax
    18e2:	89 44 24 08          	mov    %eax,0x8(%esp)
    18e6:	b8 00 8e 00 00       	mov    $0x8e00,%eax
    18eb:	89 44 24 04          	mov    %eax,0x4(%esp)
    18ef:	89 1c 24             	mov    %ebx,(%esp)
    18f2:	e8 99 27 00 00       	call   4090 <read>
    18f7:	83 f8 05             	cmp    $0x5,%eax
    18fa:	0f 85 fe 00 00 00    	jne    19fe <linktest+0x1fe>
  close(fd);
    1900:	89 1c 24             	mov    %ebx,(%esp)
  if(link("lf2", "lf2") >= 0){
    1903:	bb 16 4b 00 00       	mov    $0x4b16,%ebx
  close(fd);
    1908:	e8 93 27 00 00       	call   40a0 <close>
  if(link("lf2", "lf2") >= 0){
    190d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    1911:	c7 04 24 16 4b 00 00 	movl   $0x4b16,(%esp)
    1918:	e8 bb 27 00 00       	call   40d8 <link>
    191d:	85 c0                	test   %eax,%eax
    191f:	0f 89 b9 00 00 00    	jns    19de <linktest+0x1de>
  unlink("lf2");
    1925:	c7 04 24 16 4b 00 00 	movl   $0x4b16,(%esp)
    192c:	e8 97 27 00 00       	call   40c8 <unlink>
  if(link("lf2", "lf1") >= 0){
    1931:	b9 12 4b 00 00       	mov    $0x4b12,%ecx
    1936:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    193a:	c7 04 24 16 4b 00 00 	movl   $0x4b16,(%esp)
    1941:	e8 92 27 00 00       	call   40d8 <link>
    1946:	85 c0                	test   %eax,%eax
    1948:	79 74                	jns    19be <linktest+0x1be>
  if(link(".", "lf1") >= 0){
    194a:	ba 12 4b 00 00       	mov    $0x4b12,%edx
    194f:	89 54 24 04          	mov    %edx,0x4(%esp)
    1953:	c7 04 24 da 4d 00 00 	movl   $0x4dda,(%esp)
    195a:	e8 79 27 00 00       	call   40d8 <link>
    195f:	85 c0                	test   %eax,%eax
    1961:	79 3b                	jns    199e <linktest+0x19e>
  printf(1, "linktest ok\n");
    1963:	b8 b0 4b 00 00       	mov    $0x4bb0,%eax
    1968:	89 44 24 04          	mov    %eax,0x4(%esp)
    196c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1973:	e8 68 28 00 00       	call   41e0 <printf>
}
    1978:	83 c4 14             	add    $0x14,%esp
    197b:	5b                   	pop    %ebx
    197c:	5d                   	pop    %ebp
    197d:	c3                   	ret    
    printf(1, "create lf1 failed\n");
    197e:	c7 44 24 04 1a 4b 00 	movl   $0x4b1a,0x4(%esp)
    1985:	00 
    1986:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    198d:	e8 4e 28 00 00       	call   41e0 <printf>
    exit(0);
    1992:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1999:	e8 da 26 00 00       	call   4078 <exit>
    printf(1, "link . lf1 succeeded! oops\n");
    199e:	c7 44 24 04 94 4b 00 	movl   $0x4b94,0x4(%esp)
    19a5:	00 
    19a6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19ad:	e8 2e 28 00 00       	call   41e0 <printf>
    exit(0);
    19b2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    19b9:	e8 ba 26 00 00       	call   4078 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    19be:	c7 44 24 04 48 57 00 	movl   $0x5748,0x4(%esp)
    19c5:	00 
    19c6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19cd:	e8 0e 28 00 00       	call   41e0 <printf>
    exit(0);
    19d2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    19d9:	e8 9a 26 00 00       	call   4078 <exit>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    19de:	c7 44 24 04 76 4b 00 	movl   $0x4b76,0x4(%esp)
    19e5:	00 
    19e6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19ed:	e8 ee 27 00 00       	call   41e0 <printf>
    exit(0);
    19f2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    19f9:	e8 7a 26 00 00       	call   4078 <exit>
    printf(1, "read lf2 failed\n");
    19fe:	c7 44 24 04 65 4b 00 	movl   $0x4b65,0x4(%esp)
    1a05:	00 
    1a06:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a0d:	e8 ce 27 00 00       	call   41e0 <printf>
    exit(0);
    1a12:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1a19:	e8 5a 26 00 00       	call   4078 <exit>
    printf(1, "open lf2 failed\n");
    1a1e:	c7 44 24 04 54 4b 00 	movl   $0x4b54,0x4(%esp)
    1a25:	00 
    1a26:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a2d:	e8 ae 27 00 00       	call   41e0 <printf>
    exit(0);
    1a32:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1a39:	e8 3a 26 00 00       	call   4078 <exit>
    printf(1, "unlinked lf1 but it is still there!\n");
    1a3e:	c7 44 24 04 20 57 00 	movl   $0x5720,0x4(%esp)
    1a45:	00 
    1a46:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a4d:	e8 8e 27 00 00       	call   41e0 <printf>
    exit(0);
    1a52:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1a59:	e8 1a 26 00 00       	call   4078 <exit>
    printf(1, "link lf1 lf2 failed\n");
    1a5e:	c7 44 24 04 3f 4b 00 	movl   $0x4b3f,0x4(%esp)
    1a65:	00 
    1a66:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a6d:	e8 6e 27 00 00       	call   41e0 <printf>
    exit(0);
    1a72:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1a79:	e8 fa 25 00 00       	call   4078 <exit>
    printf(1, "write lf1 failed\n");
    1a7e:	c7 44 24 04 2d 4b 00 	movl   $0x4b2d,0x4(%esp)
    1a85:	00 
    1a86:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a8d:	e8 4e 27 00 00       	call   41e0 <printf>
    exit(0);
    1a92:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1a99:	e8 da 25 00 00       	call   4078 <exit>
    1a9e:	66 90                	xchg   %ax,%ax

00001aa0 <concreate>:
{
    1aa0:	55                   	push   %ebp
    1aa1:	89 e5                	mov    %esp,%ebp
    1aa3:	57                   	push   %edi
  printf(1, "concreate test\n");
    1aa4:	bf bd 4b 00 00       	mov    $0x4bbd,%edi
{
    1aa9:	56                   	push   %esi
    1aaa:	53                   	push   %ebx
  file[2] = '\0';
    1aab:	b3 30                	mov    $0x30,%bl
{
    1aad:	83 ec 6c             	sub    $0x6c,%esp
  printf(1, "concreate test\n");
    1ab0:	89 7c 24 04          	mov    %edi,0x4(%esp)
    1ab4:	8d 75 ad             	lea    -0x53(%ebp),%esi
  for(i = 0; i < 40; i++){
    1ab7:	31 ff                	xor    %edi,%edi
  printf(1, "concreate test\n");
    1ab9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ac0:	e8 1b 27 00 00       	call   41e0 <printf>
  file[0] = 'C';
    1ac5:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
  file[2] = '\0';
    1ac9:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
    1acd:	eb 4f                	jmp    1b1e <concreate+0x7e>
    1acf:	90                   	nop
    if(pid && (i % 3) == 1){
    1ad0:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    1ad5:	89 f9                	mov    %edi,%ecx
    1ad7:	f7 e7                	mul    %edi
    1ad9:	d1 ea                	shr    %edx
    1adb:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1ade:	29 c1                	sub    %eax,%ecx
    1ae0:	89 c8                	mov    %ecx,%eax
    1ae2:	48                   	dec    %eax
    1ae3:	0f 84 bf 00 00 00    	je     1ba8 <concreate+0x108>
      fd = open(file, O_CREATE | O_RDWR);
    1ae9:	b8 02 02 00 00       	mov    $0x202,%eax
    1aee:	89 44 24 04          	mov    %eax,0x4(%esp)
    1af2:	89 34 24             	mov    %esi,(%esp)
    1af5:	e8 be 25 00 00       	call   40b8 <open>
      if(fd < 0){
    1afa:	85 c0                	test   %eax,%eax
    1afc:	78 61                	js     1b5f <concreate+0xbf>
      close(fd);
    1afe:	89 04 24             	mov    %eax,(%esp)
    1b01:	e8 9a 25 00 00       	call   40a0 <close>
      wait(0);
    1b06:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  for(i = 0; i < 40; i++){
    1b0d:	47                   	inc    %edi
    1b0e:	fe c3                	inc    %bl
      wait(0);
    1b10:	e8 6b 25 00 00       	call   4080 <wait>
  for(i = 0; i < 40; i++){
    1b15:	83 ff 28             	cmp    $0x28,%edi
    1b18:	0f 84 a2 00 00 00    	je     1bc0 <concreate+0x120>
    unlink(file);
    1b1e:	89 34 24             	mov    %esi,(%esp)
    file[1] = '0' + i;
    1b21:	88 5d ae             	mov    %bl,-0x52(%ebp)
    unlink(file);
    1b24:	e8 9f 25 00 00       	call   40c8 <unlink>
    pid = fork();
    1b29:	e8 42 25 00 00       	call   4070 <fork>
    if(pid && (i % 3) == 1){
    1b2e:	85 c0                	test   %eax,%eax
    1b30:	75 9e                	jne    1ad0 <concreate+0x30>
    } else if(pid == 0 && (i % 5) == 1){
    1b32:	89 f8                	mov    %edi,%eax
    1b34:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
    1b39:	f7 e2                	mul    %edx
    1b3b:	c1 ea 02             	shr    $0x2,%edx
    1b3e:	8d 04 92             	lea    (%edx,%edx,4),%eax
    1b41:	29 c7                	sub    %eax,%edi
    1b43:	4f                   	dec    %edi
    1b44:	74 42                	je     1b88 <concreate+0xe8>
      fd = open(file, O_CREATE | O_RDWR);
    1b46:	ba 02 02 00 00       	mov    $0x202,%edx
    1b4b:	89 54 24 04          	mov    %edx,0x4(%esp)
    1b4f:	89 34 24             	mov    %esi,(%esp)
    1b52:	e8 61 25 00 00       	call   40b8 <open>
      if(fd < 0){
    1b57:	85 c0                	test   %eax,%eax
    1b59:	0f 89 96 02 00 00    	jns    1df5 <concreate+0x355>
        printf(1, "concreate create %s failed\n", file);
    1b5f:	89 74 24 08          	mov    %esi,0x8(%esp)
    1b63:	be d0 4b 00 00       	mov    $0x4bd0,%esi
    1b68:	89 74 24 04          	mov    %esi,0x4(%esp)
    1b6c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b73:	e8 68 26 00 00       	call   41e0 <printf>
        exit(0);
    1b78:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1b7f:	e8 f4 24 00 00       	call   4078 <exit>
    1b84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      link("C0", file);
    1b88:	89 74 24 04          	mov    %esi,0x4(%esp)
    1b8c:	c7 04 24 cd 4b 00 00 	movl   $0x4bcd,(%esp)
    1b93:	e8 40 25 00 00       	call   40d8 <link>
        exit(0);
    1b98:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1b9f:	e8 d4 24 00 00       	call   4078 <exit>
    1ba4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      link("C0", file);
    1ba8:	89 74 24 04          	mov    %esi,0x4(%esp)
    1bac:	c7 04 24 cd 4b 00 00 	movl   $0x4bcd,(%esp)
    1bb3:	e8 20 25 00 00       	call   40d8 <link>
    1bb8:	e9 49 ff ff ff       	jmp    1b06 <concreate+0x66>
    1bbd:	8d 76 00             	lea    0x0(%esi),%esi
  memset(fa, 0, sizeof(fa));
    1bc0:	ba 28 00 00 00       	mov    $0x28,%edx
    1bc5:	31 c9                	xor    %ecx,%ecx
    1bc7:	8d 45 c0             	lea    -0x40(%ebp),%eax
  fd = open(".", 0);
    1bca:	31 db                	xor    %ebx,%ebx
  memset(fa, 0, sizeof(fa));
    1bcc:	89 54 24 08          	mov    %edx,0x8(%esp)
    1bd0:	8d 7d b0             	lea    -0x50(%ebp),%edi
    1bd3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    1bd7:	89 04 24             	mov    %eax,(%esp)
    1bda:	e8 01 23 00 00       	call   3ee0 <memset>
  fd = open(".", 0);
    1bdf:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    1be3:	c7 04 24 da 4d 00 00 	movl   $0x4dda,(%esp)
    1bea:	e8 c9 24 00 00       	call   40b8 <open>
  n = 0;
    1bef:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
  fd = open(".", 0);
    1bf6:	89 c3                	mov    %eax,%ebx
    1bf8:	90                   	nop
    1bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(read(fd, &de, sizeof(de)) > 0){
    1c00:	b8 10 00 00 00       	mov    $0x10,%eax
    1c05:	89 44 24 08          	mov    %eax,0x8(%esp)
    1c09:	89 7c 24 04          	mov    %edi,0x4(%esp)
    1c0d:	89 1c 24             	mov    %ebx,(%esp)
    1c10:	e8 7b 24 00 00       	call   4090 <read>
    1c15:	85 c0                	test   %eax,%eax
    1c17:	7e 3f                	jle    1c58 <concreate+0x1b8>
    if(de.inum == 0)
    1c19:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    1c1e:	74 e0                	je     1c00 <concreate+0x160>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    1c20:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    1c24:	75 da                	jne    1c00 <concreate+0x160>
    1c26:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    1c2a:	75 d4                	jne    1c00 <concreate+0x160>
      i = de.name[1] - '0';
    1c2c:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    1c30:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    1c33:	83 f8 27             	cmp    $0x27,%eax
    1c36:	0f 87 99 01 00 00    	ja     1dd5 <concreate+0x335>
      if(fa[i]){
    1c3c:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    1c41:	0f 85 67 01 00 00    	jne    1dae <concreate+0x30e>
      fa[i] = 1;
    1c47:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
      n++;
    1c4c:	ff 45 a4             	incl   -0x5c(%ebp)
    1c4f:	eb af                	jmp    1c00 <concreate+0x160>
    1c51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  close(fd);
    1c58:	89 1c 24             	mov    %ebx,(%esp)
    1c5b:	e8 40 24 00 00       	call   40a0 <close>
  if(n != 40){
    1c60:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    1c64:	0f 85 24 01 00 00    	jne    1d8e <concreate+0x2ee>
    1c6a:	b3 30                	mov    $0x30,%bl
  for(i = 0; i < 40; i++){
    1c6c:	31 ff                	xor    %edi,%edi
    1c6e:	eb 4d                	jmp    1cbd <concreate+0x21d>
       ((i % 3) == 1 && pid != 0)){
    1c70:	85 c9                	test   %ecx,%ecx
    1c72:	74 03                	je     1c77 <concreate+0x1d7>
    1c74:	4a                   	dec    %edx
    1c75:	74 6e                	je     1ce5 <concreate+0x245>
      unlink(file);
    1c77:	89 34 24             	mov    %esi,(%esp)
    1c7a:	89 4d a4             	mov    %ecx,-0x5c(%ebp)
    1c7d:	e8 46 24 00 00       	call   40c8 <unlink>
      unlink(file);
    1c82:	89 34 24             	mov    %esi,(%esp)
    1c85:	e8 3e 24 00 00       	call   40c8 <unlink>
      unlink(file);
    1c8a:	89 34 24             	mov    %esi,(%esp)
    1c8d:	e8 36 24 00 00       	call   40c8 <unlink>
      unlink(file);
    1c92:	89 34 24             	mov    %esi,(%esp)
    1c95:	e8 2e 24 00 00       	call   40c8 <unlink>
    1c9a:	8b 4d a4             	mov    -0x5c(%ebp),%ecx
    if(pid == 0)
    1c9d:	85 c9                	test   %ecx,%ecx
    1c9f:	0f 84 f3 fe ff ff    	je     1b98 <concreate+0xf8>
      wait(0);
    1ca5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  for(i = 0; i < 40; i++){
    1cac:	47                   	inc    %edi
    1cad:	fe c3                	inc    %bl
      wait(0);
    1caf:	e8 cc 23 00 00       	call   4080 <wait>
  for(i = 0; i < 40; i++){
    1cb4:	83 ff 28             	cmp    $0x28,%edi
    1cb7:	0f 84 93 00 00 00    	je     1d50 <concreate+0x2b0>
    file[1] = '0' + i;
    1cbd:	88 5d ae             	mov    %bl,-0x52(%ebp)
    pid = fork();
    1cc0:	e8 ab 23 00 00       	call   4070 <fork>
    if(pid < 0){
    1cc5:	85 c0                	test   %eax,%eax
    pid = fork();
    1cc7:	89 c1                	mov    %eax,%ecx
    if(pid < 0){
    1cc9:	0f 88 9e 00 00 00    	js     1d6d <concreate+0x2cd>
    if(((i % 3) == 0 && pid == 0) ||
    1ccf:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    1cd4:	f7 e7                	mul    %edi
    1cd6:	d1 ea                	shr    %edx
    1cd8:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1cdb:	89 fa                	mov    %edi,%edx
    1cdd:	29 c2                	sub    %eax,%edx
    1cdf:	89 d0                	mov    %edx,%eax
    1ce1:	09 c8                	or     %ecx,%eax
    1ce3:	75 8b                	jne    1c70 <concreate+0x1d0>
      close(open(file, 0));
    1ce5:	31 c0                	xor    %eax,%eax
    1ce7:	89 44 24 04          	mov    %eax,0x4(%esp)
    1ceb:	89 34 24             	mov    %esi,(%esp)
    1cee:	89 4d a4             	mov    %ecx,-0x5c(%ebp)
    1cf1:	e8 c2 23 00 00       	call   40b8 <open>
    1cf6:	89 04 24             	mov    %eax,(%esp)
    1cf9:	e8 a2 23 00 00       	call   40a0 <close>
      close(open(file, 0));
    1cfe:	31 c0                	xor    %eax,%eax
    1d00:	89 44 24 04          	mov    %eax,0x4(%esp)
    1d04:	89 34 24             	mov    %esi,(%esp)
    1d07:	e8 ac 23 00 00       	call   40b8 <open>
    1d0c:	89 04 24             	mov    %eax,(%esp)
    1d0f:	e8 8c 23 00 00       	call   40a0 <close>
      close(open(file, 0));
    1d14:	31 c0                	xor    %eax,%eax
    1d16:	89 44 24 04          	mov    %eax,0x4(%esp)
    1d1a:	89 34 24             	mov    %esi,(%esp)
    1d1d:	e8 96 23 00 00       	call   40b8 <open>
    1d22:	89 04 24             	mov    %eax,(%esp)
    1d25:	e8 76 23 00 00       	call   40a0 <close>
      close(open(file, 0));
    1d2a:	31 c0                	xor    %eax,%eax
    1d2c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1d30:	89 34 24             	mov    %esi,(%esp)
    1d33:	e8 80 23 00 00       	call   40b8 <open>
    1d38:	89 04 24             	mov    %eax,(%esp)
    1d3b:	e8 60 23 00 00       	call   40a0 <close>
    1d40:	8b 4d a4             	mov    -0x5c(%ebp),%ecx
    1d43:	e9 55 ff ff ff       	jmp    1c9d <concreate+0x1fd>
    1d48:	90                   	nop
    1d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  printf(1, "concreate ok\n");
    1d50:	b9 22 4c 00 00       	mov    $0x4c22,%ecx
    1d55:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    1d59:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d60:	e8 7b 24 00 00       	call   41e0 <printf>
}
    1d65:	83 c4 6c             	add    $0x6c,%esp
    1d68:	5b                   	pop    %ebx
    1d69:	5e                   	pop    %esi
    1d6a:	5f                   	pop    %edi
    1d6b:	5d                   	pop    %ebp
    1d6c:	c3                   	ret    
      printf(1, "fork failed\n");
    1d6d:	b8 a5 54 00 00       	mov    $0x54a5,%eax
    1d72:	89 44 24 04          	mov    %eax,0x4(%esp)
    1d76:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d7d:	e8 5e 24 00 00       	call   41e0 <printf>
      exit(0);
    1d82:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1d89:	e8 ea 22 00 00       	call   4078 <exit>
    printf(1, "concreate not enough files in directory listing\n");
    1d8e:	c7 44 24 04 6c 57 00 	movl   $0x576c,0x4(%esp)
    1d95:	00 
    1d96:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d9d:	e8 3e 24 00 00       	call   41e0 <printf>
    exit(0);
    1da2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1da9:	e8 ca 22 00 00       	call   4078 <exit>
        printf(1, "concreate duplicate file %s\n", de.name);
    1dae:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1db1:	89 44 24 08          	mov    %eax,0x8(%esp)
    1db5:	c7 44 24 04 05 4c 00 	movl   $0x4c05,0x4(%esp)
    1dbc:	00 
    1dbd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1dc4:	e8 17 24 00 00       	call   41e0 <printf>
        exit(0);
    1dc9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1dd0:	e8 a3 22 00 00       	call   4078 <exit>
        printf(1, "concreate weird file %s\n", de.name);
    1dd5:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1dd8:	89 44 24 08          	mov    %eax,0x8(%esp)
    1ddc:	c7 44 24 04 ec 4b 00 	movl   $0x4bec,0x4(%esp)
    1de3:	00 
    1de4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1deb:	e8 f0 23 00 00       	call   41e0 <printf>
    1df0:	e9 a3 fd ff ff       	jmp    1b98 <concreate+0xf8>
      close(fd);
    1df5:	89 04 24             	mov    %eax,(%esp)
    1df8:	e8 a3 22 00 00       	call   40a0 <close>
    1dfd:	8d 76 00             	lea    0x0(%esi),%esi
    1e00:	e9 93 fd ff ff       	jmp    1b98 <concreate+0xf8>
    1e05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001e10 <linkunlink>:
{
    1e10:	55                   	push   %ebp
  printf(1, "linkunlink test\n");
    1e11:	b8 30 4c 00 00       	mov    $0x4c30,%eax
{
    1e16:	89 e5                	mov    %esp,%ebp
    1e18:	57                   	push   %edi
    1e19:	56                   	push   %esi
    1e1a:	53                   	push   %ebx
    1e1b:	83 ec 2c             	sub    $0x2c,%esp
  printf(1, "linkunlink test\n");
    1e1e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1e22:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e29:	e8 b2 23 00 00       	call   41e0 <printf>
  unlink("x");
    1e2e:	c7 04 24 bd 4e 00 00 	movl   $0x4ebd,(%esp)
    1e35:	e8 8e 22 00 00       	call   40c8 <unlink>
  pid = fork();
    1e3a:	e8 31 22 00 00       	call   4070 <fork>
  if(pid < 0){
    1e3f:	85 c0                	test   %eax,%eax
  pid = fork();
    1e41:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    1e44:	0f 88 b0 00 00 00    	js     1efa <linkunlink+0xea>
  unsigned int x = (pid ? 1 : 97);
    1e4a:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1e4e:	bb 64 00 00 00       	mov    $0x64,%ebx
    if((x % 3) == 0){
    1e53:	be ab aa aa aa       	mov    $0xaaaaaaab,%esi
  unsigned int x = (pid ? 1 : 97);
    1e58:	19 ff                	sbb    %edi,%edi
    1e5a:	83 e7 60             	and    $0x60,%edi
    1e5d:	47                   	inc    %edi
    1e5e:	eb 12                	jmp    1e72 <linkunlink+0x62>
    } else if((x % 3) == 1){
    1e60:	4a                   	dec    %edx
    1e61:	74 7d                	je     1ee0 <linkunlink+0xd0>
      unlink("x");
    1e63:	c7 04 24 bd 4e 00 00 	movl   $0x4ebd,(%esp)
    1e6a:	e8 59 22 00 00       	call   40c8 <unlink>
  for(i = 0; i < 100; i++){
    1e6f:	4b                   	dec    %ebx
    1e70:	74 3b                	je     1ead <linkunlink+0x9d>
    x = x * 1103515245 + 12345;
    1e72:	69 cf 6d 4e c6 41    	imul   $0x41c64e6d,%edi,%ecx
    1e78:	8d b9 39 30 00 00    	lea    0x3039(%ecx),%edi
    if((x % 3) == 0){
    1e7e:	89 f8                	mov    %edi,%eax
    1e80:	f7 e6                	mul    %esi
    1e82:	d1 ea                	shr    %edx
    1e84:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1e87:	89 fa                	mov    %edi,%edx
    1e89:	29 c2                	sub    %eax,%edx
    1e8b:	75 d3                	jne    1e60 <linkunlink+0x50>
      close(open("x", O_RDWR | O_CREATE));
    1e8d:	b8 02 02 00 00       	mov    $0x202,%eax
    1e92:	89 44 24 04          	mov    %eax,0x4(%esp)
    1e96:	c7 04 24 bd 4e 00 00 	movl   $0x4ebd,(%esp)
    1e9d:	e8 16 22 00 00       	call   40b8 <open>
    1ea2:	89 04 24             	mov    %eax,(%esp)
    1ea5:	e8 f6 21 00 00       	call   40a0 <close>
  for(i = 0; i < 100; i++){
    1eaa:	4b                   	dec    %ebx
    1eab:	75 c5                	jne    1e72 <linkunlink+0x62>
  if(pid)
    1ead:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    wait(0);
    1eb0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  if(pid)
    1eb7:	85 d2                	test   %edx,%edx
    1eb9:	74 5f                	je     1f1a <linkunlink+0x10a>
    wait(0);
    1ebb:	e8 c0 21 00 00       	call   4080 <wait>
  printf(1, "linkunlink ok\n");
    1ec0:	b8 45 4c 00 00       	mov    $0x4c45,%eax
    1ec5:	89 44 24 04          	mov    %eax,0x4(%esp)
    1ec9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ed0:	e8 0b 23 00 00       	call   41e0 <printf>
}
    1ed5:	83 c4 2c             	add    $0x2c,%esp
    1ed8:	5b                   	pop    %ebx
    1ed9:	5e                   	pop    %esi
    1eda:	5f                   	pop    %edi
    1edb:	5d                   	pop    %ebp
    1edc:	c3                   	ret    
    1edd:	8d 76 00             	lea    0x0(%esi),%esi
      link("cat", "x");
    1ee0:	b9 bd 4e 00 00       	mov    $0x4ebd,%ecx
    1ee5:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    1ee9:	c7 04 24 41 4c 00 00 	movl   $0x4c41,(%esp)
    1ef0:	e8 e3 21 00 00       	call   40d8 <link>
    1ef5:	e9 75 ff ff ff       	jmp    1e6f <linkunlink+0x5f>
    printf(1, "fork failed\n");
    1efa:	c7 44 24 04 a5 54 00 	movl   $0x54a5,0x4(%esp)
    1f01:	00 
    1f02:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f09:	e8 d2 22 00 00       	call   41e0 <printf>
    exit(0);
    1f0e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1f15:	e8 5e 21 00 00       	call   4078 <exit>
    exit(0);
    1f1a:	e8 59 21 00 00       	call   4078 <exit>
    1f1f:	90                   	nop

00001f20 <bigdir>:
{
    1f20:	55                   	push   %ebp
    1f21:	89 e5                	mov    %esp,%ebp
    1f23:	57                   	push   %edi
    1f24:	56                   	push   %esi
  fd = open("bd", O_CREATE);
    1f25:	be 00 02 00 00       	mov    $0x200,%esi
{
    1f2a:	53                   	push   %ebx
  printf(1, "bigdir test\n");
    1f2b:	bb 54 4c 00 00       	mov    $0x4c54,%ebx
{
    1f30:	83 ec 2c             	sub    $0x2c,%esp
  printf(1, "bigdir test\n");
    1f33:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    1f37:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f3e:	e8 9d 22 00 00       	call   41e0 <printf>
  unlink("bd");
    1f43:	c7 04 24 61 4c 00 00 	movl   $0x4c61,(%esp)
    1f4a:	e8 79 21 00 00       	call   40c8 <unlink>
  fd = open("bd", O_CREATE);
    1f4f:	89 74 24 04          	mov    %esi,0x4(%esp)
    1f53:	c7 04 24 61 4c 00 00 	movl   $0x4c61,(%esp)
    1f5a:	e8 59 21 00 00       	call   40b8 <open>
  if(fd < 0){
    1f5f:	85 c0                	test   %eax,%eax
    1f61:	0f 88 f9 00 00 00    	js     2060 <bigdir+0x140>
  close(fd);
    1f67:	89 04 24             	mov    %eax,(%esp)
  for(i = 0; i < 500; i++){
    1f6a:	31 f6                	xor    %esi,%esi
  close(fd);
    1f6c:	e8 2f 21 00 00       	call   40a0 <close>
    1f71:	8d 7d de             	lea    -0x22(%ebp),%edi
    1f74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1f7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    name[1] = '0' + (i / 64);
    1f80:	89 f0                	mov    %esi,%eax
    1f82:	c1 f8 06             	sar    $0x6,%eax
    1f85:	04 30                	add    $0x30,%al
    1f87:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1f8a:	89 f0                	mov    %esi,%eax
    1f8c:	83 e0 3f             	and    $0x3f,%eax
    1f8f:	04 30                	add    $0x30,%al
    if(link("bd", name) != 0){
    1f91:	89 7c 24 04          	mov    %edi,0x4(%esp)
    1f95:	c7 04 24 61 4c 00 00 	movl   $0x4c61,(%esp)
    name[0] = 'x';
    1f9c:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[2] = '0' + (i % 64);
    1fa0:	88 45 e0             	mov    %al,-0x20(%ebp)
    name[3] = '\0';
    1fa3:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    if(link("bd", name) != 0){
    1fa7:	e8 2c 21 00 00       	call   40d8 <link>
    1fac:	85 c0                	test   %eax,%eax
    1fae:	89 c3                	mov    %eax,%ebx
    1fb0:	75 6c                	jne    201e <bigdir+0xfe>
  for(i = 0; i < 500; i++){
    1fb2:	46                   	inc    %esi
    1fb3:	81 fe f4 01 00 00    	cmp    $0x1f4,%esi
    1fb9:	75 c5                	jne    1f80 <bigdir+0x60>
  unlink("bd");
    1fbb:	c7 04 24 61 4c 00 00 	movl   $0x4c61,(%esp)
    1fc2:	e8 01 21 00 00       	call   40c8 <unlink>
    1fc7:	89 f6                	mov    %esi,%esi
    1fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    name[1] = '0' + (i / 64);
    1fd0:	89 d8                	mov    %ebx,%eax
    1fd2:	c1 f8 06             	sar    $0x6,%eax
    1fd5:	04 30                	add    $0x30,%al
    1fd7:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1fda:	89 d8                	mov    %ebx,%eax
    1fdc:	83 e0 3f             	and    $0x3f,%eax
    1fdf:	04 30                	add    $0x30,%al
    if(unlink(name) != 0){
    1fe1:	89 3c 24             	mov    %edi,(%esp)
    name[0] = 'x';
    1fe4:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[2] = '0' + (i % 64);
    1fe8:	88 45 e0             	mov    %al,-0x20(%ebp)
    name[3] = '\0';
    1feb:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    if(unlink(name) != 0){
    1fef:	e8 d4 20 00 00       	call   40c8 <unlink>
    1ff4:	85 c0                	test   %eax,%eax
    1ff6:	75 47                	jne    203f <bigdir+0x11f>
  for(i = 0; i < 500; i++){
    1ff8:	43                   	inc    %ebx
    1ff9:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1fff:	75 cf                	jne    1fd0 <bigdir+0xb0>
  printf(1, "bigdir ok\n");
    2001:	b8 a3 4c 00 00       	mov    $0x4ca3,%eax
    2006:	89 44 24 04          	mov    %eax,0x4(%esp)
    200a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2011:	e8 ca 21 00 00       	call   41e0 <printf>
}
    2016:	83 c4 2c             	add    $0x2c,%esp
    2019:	5b                   	pop    %ebx
    201a:	5e                   	pop    %esi
    201b:	5f                   	pop    %edi
    201c:	5d                   	pop    %ebp
    201d:	c3                   	ret    
      printf(1, "bigdir link failed\n");
    201e:	b9 7a 4c 00 00       	mov    $0x4c7a,%ecx
    2023:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    2027:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    202e:	e8 ad 21 00 00       	call   41e0 <printf>
      exit(0);
    2033:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    203a:	e8 39 20 00 00       	call   4078 <exit>
      printf(1, "bigdir unlink failed");
    203f:	ba 8e 4c 00 00       	mov    $0x4c8e,%edx
    2044:	89 54 24 04          	mov    %edx,0x4(%esp)
    2048:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    204f:	e8 8c 21 00 00       	call   41e0 <printf>
      exit(0);
    2054:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    205b:	e8 18 20 00 00       	call   4078 <exit>
    printf(1, "bigdir create failed\n");
    2060:	c7 44 24 04 64 4c 00 	movl   $0x4c64,0x4(%esp)
    2067:	00 
    2068:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    206f:	e8 6c 21 00 00       	call   41e0 <printf>
    exit(0);
    2074:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    207b:	e8 f8 1f 00 00       	call   4078 <exit>

00002080 <subdir>:
{
    2080:	55                   	push   %ebp
  printf(1, "subdir test\n");
    2081:	b8 ae 4c 00 00       	mov    $0x4cae,%eax
{
    2086:	89 e5                	mov    %esp,%ebp
    2088:	53                   	push   %ebx
    2089:	83 ec 14             	sub    $0x14,%esp
  printf(1, "subdir test\n");
    208c:	89 44 24 04          	mov    %eax,0x4(%esp)
    2090:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2097:	e8 44 21 00 00       	call   41e0 <printf>
  unlink("ff");
    209c:	c7 04 24 37 4d 00 00 	movl   $0x4d37,(%esp)
    20a3:	e8 20 20 00 00       	call   40c8 <unlink>
  if(mkdir("dd") != 0){
    20a8:	c7 04 24 d4 4d 00 00 	movl   $0x4dd4,(%esp)
    20af:	e8 2c 20 00 00       	call   40e0 <mkdir>
    20b4:	85 c0                	test   %eax,%eax
    20b6:	0f 85 ad 06 00 00    	jne    2769 <subdir+0x6e9>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    20bc:	b8 02 02 00 00       	mov    $0x202,%eax
    20c1:	89 44 24 04          	mov    %eax,0x4(%esp)
    20c5:	c7 04 24 0d 4d 00 00 	movl   $0x4d0d,(%esp)
    20cc:	e8 e7 1f 00 00       	call   40b8 <open>
  if(fd < 0){
    20d1:	85 c0                	test   %eax,%eax
  fd = open("dd/ff", O_CREATE | O_RDWR);
    20d3:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    20d5:	0f 88 6e 06 00 00    	js     2749 <subdir+0x6c9>
  write(fd, "ff", 2);
    20db:	b8 02 00 00 00       	mov    $0x2,%eax
    20e0:	89 44 24 08          	mov    %eax,0x8(%esp)
    20e4:	b8 37 4d 00 00       	mov    $0x4d37,%eax
    20e9:	89 44 24 04          	mov    %eax,0x4(%esp)
    20ed:	89 1c 24             	mov    %ebx,(%esp)
    20f0:	e8 a3 1f 00 00       	call   4098 <write>
  close(fd);
    20f5:	89 1c 24             	mov    %ebx,(%esp)
    20f8:	e8 a3 1f 00 00       	call   40a0 <close>
  if(unlink("dd") >= 0){
    20fd:	c7 04 24 d4 4d 00 00 	movl   $0x4dd4,(%esp)
    2104:	e8 bf 1f 00 00       	call   40c8 <unlink>
    2109:	85 c0                	test   %eax,%eax
    210b:	0f 89 18 06 00 00    	jns    2729 <subdir+0x6a9>
  if(mkdir("/dd/dd") != 0){
    2111:	c7 04 24 e8 4c 00 00 	movl   $0x4ce8,(%esp)
    2118:	e8 c3 1f 00 00       	call   40e0 <mkdir>
    211d:	85 c0                	test   %eax,%eax
    211f:	0f 85 e4 05 00 00    	jne    2709 <subdir+0x689>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    2125:	b9 02 02 00 00       	mov    $0x202,%ecx
    212a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    212e:	c7 04 24 0a 4d 00 00 	movl   $0x4d0a,(%esp)
    2135:	e8 7e 1f 00 00       	call   40b8 <open>
  if(fd < 0){
    213a:	85 c0                	test   %eax,%eax
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    213c:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    213e:	0f 88 65 04 00 00    	js     25a9 <subdir+0x529>
  write(fd, "FF", 2);
    2144:	b8 02 00 00 00       	mov    $0x2,%eax
    2149:	89 44 24 08          	mov    %eax,0x8(%esp)
    214d:	b8 2b 4d 00 00       	mov    $0x4d2b,%eax
    2152:	89 1c 24             	mov    %ebx,(%esp)
    2155:	89 44 24 04          	mov    %eax,0x4(%esp)
    2159:	e8 3a 1f 00 00       	call   4098 <write>
  close(fd);
    215e:	89 1c 24             	mov    %ebx,(%esp)
    2161:	e8 3a 1f 00 00       	call   40a0 <close>
  fd = open("dd/dd/../ff", 0);
    2166:	31 d2                	xor    %edx,%edx
    2168:	89 54 24 04          	mov    %edx,0x4(%esp)
    216c:	c7 04 24 2e 4d 00 00 	movl   $0x4d2e,(%esp)
    2173:	e8 40 1f 00 00       	call   40b8 <open>
  if(fd < 0){
    2178:	85 c0                	test   %eax,%eax
  fd = open("dd/dd/../ff", 0);
    217a:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    217c:	0f 88 07 04 00 00    	js     2589 <subdir+0x509>
  cc = read(fd, buf, sizeof(buf));
    2182:	b8 00 20 00 00       	mov    $0x2000,%eax
    2187:	89 44 24 08          	mov    %eax,0x8(%esp)
    218b:	b8 00 8e 00 00       	mov    $0x8e00,%eax
    2190:	89 44 24 04          	mov    %eax,0x4(%esp)
    2194:	89 1c 24             	mov    %ebx,(%esp)
    2197:	e8 f4 1e 00 00       	call   4090 <read>
  if(cc != 2 || buf[0] != 'f'){
    219c:	83 f8 02             	cmp    $0x2,%eax
    219f:	0f 85 04 03 00 00    	jne    24a9 <subdir+0x429>
    21a5:	80 3d 00 8e 00 00 66 	cmpb   $0x66,0x8e00
    21ac:	0f 85 f7 02 00 00    	jne    24a9 <subdir+0x429>
  close(fd);
    21b2:	89 1c 24             	mov    %ebx,(%esp)
    21b5:	e8 e6 1e 00 00       	call   40a0 <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    21ba:	b8 6e 4d 00 00       	mov    $0x4d6e,%eax
    21bf:	89 44 24 04          	mov    %eax,0x4(%esp)
    21c3:	c7 04 24 0a 4d 00 00 	movl   $0x4d0a,(%esp)
    21ca:	e8 09 1f 00 00       	call   40d8 <link>
    21cf:	85 c0                	test   %eax,%eax
    21d1:	0f 85 12 04 00 00    	jne    25e9 <subdir+0x569>
  if(unlink("dd/dd/ff") != 0){
    21d7:	c7 04 24 0a 4d 00 00 	movl   $0x4d0a,(%esp)
    21de:	e8 e5 1e 00 00       	call   40c8 <unlink>
    21e3:	85 c0                	test   %eax,%eax
    21e5:	0f 85 fe 02 00 00    	jne    24e9 <subdir+0x469>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    21eb:	31 c0                	xor    %eax,%eax
    21ed:	89 44 24 04          	mov    %eax,0x4(%esp)
    21f1:	c7 04 24 0a 4d 00 00 	movl   $0x4d0a,(%esp)
    21f8:	e8 bb 1e 00 00       	call   40b8 <open>
    21fd:	85 c0                	test   %eax,%eax
    21ff:	0f 89 e4 04 00 00    	jns    26e9 <subdir+0x669>
  if(chdir("dd") != 0){
    2205:	c7 04 24 d4 4d 00 00 	movl   $0x4dd4,(%esp)
    220c:	e8 d7 1e 00 00       	call   40e8 <chdir>
    2211:	85 c0                	test   %eax,%eax
    2213:	0f 85 b0 04 00 00    	jne    26c9 <subdir+0x649>
  if(chdir("dd/../../dd") != 0){
    2219:	c7 04 24 a2 4d 00 00 	movl   $0x4da2,(%esp)
    2220:	e8 c3 1e 00 00       	call   40e8 <chdir>
    2225:	85 c0                	test   %eax,%eax
    2227:	0f 85 9c 02 00 00    	jne    24c9 <subdir+0x449>
  if(chdir("dd/../../../dd") != 0){
    222d:	c7 04 24 c8 4d 00 00 	movl   $0x4dc8,(%esp)
    2234:	e8 af 1e 00 00       	call   40e8 <chdir>
    2239:	85 c0                	test   %eax,%eax
    223b:	0f 85 88 02 00 00    	jne    24c9 <subdir+0x449>
  if(chdir("./..") != 0){
    2241:	c7 04 24 d7 4d 00 00 	movl   $0x4dd7,(%esp)
    2248:	e8 9b 1e 00 00       	call   40e8 <chdir>
    224d:	85 c0                	test   %eax,%eax
    224f:	0f 85 74 03 00 00    	jne    25c9 <subdir+0x549>
  fd = open("dd/dd/ffff", 0);
    2255:	31 db                	xor    %ebx,%ebx
    2257:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    225b:	c7 04 24 6e 4d 00 00 	movl   $0x4d6e,(%esp)
    2262:	e8 51 1e 00 00       	call   40b8 <open>
  if(fd < 0){
    2267:	85 c0                	test   %eax,%eax
  fd = open("dd/dd/ffff", 0);
    2269:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    226b:	0f 88 78 06 00 00    	js     28e9 <subdir+0x869>
  if(read(fd, buf, sizeof(buf)) != 2){
    2271:	ba 00 20 00 00       	mov    $0x2000,%edx
    2276:	b9 00 8e 00 00       	mov    $0x8e00,%ecx
    227b:	89 54 24 08          	mov    %edx,0x8(%esp)
    227f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    2283:	89 04 24             	mov    %eax,(%esp)
    2286:	e8 05 1e 00 00       	call   4090 <read>
    228b:	83 f8 02             	cmp    $0x2,%eax
    228e:	0f 85 35 06 00 00    	jne    28c9 <subdir+0x849>
  close(fd);
    2294:	89 1c 24             	mov    %ebx,(%esp)
    2297:	e8 04 1e 00 00       	call   40a0 <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    229c:	31 c0                	xor    %eax,%eax
    229e:	89 44 24 04          	mov    %eax,0x4(%esp)
    22a2:	c7 04 24 0a 4d 00 00 	movl   $0x4d0a,(%esp)
    22a9:	e8 0a 1e 00 00       	call   40b8 <open>
    22ae:	85 c0                	test   %eax,%eax
    22b0:	0f 89 73 02 00 00    	jns    2529 <subdir+0x4a9>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    22b6:	b8 02 02 00 00       	mov    $0x202,%eax
    22bb:	89 44 24 04          	mov    %eax,0x4(%esp)
    22bf:	c7 04 24 22 4e 00 00 	movl   $0x4e22,(%esp)
    22c6:	e8 ed 1d 00 00       	call   40b8 <open>
    22cb:	85 c0                	test   %eax,%eax
    22cd:	0f 89 36 02 00 00    	jns    2509 <subdir+0x489>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    22d3:	b8 02 02 00 00       	mov    $0x202,%eax
    22d8:	89 44 24 04          	mov    %eax,0x4(%esp)
    22dc:	c7 04 24 47 4e 00 00 	movl   $0x4e47,(%esp)
    22e3:	e8 d0 1d 00 00       	call   40b8 <open>
    22e8:	85 c0                	test   %eax,%eax
    22ea:	0f 89 b9 03 00 00    	jns    26a9 <subdir+0x629>
  if(open("dd", O_CREATE) >= 0){
    22f0:	b8 00 02 00 00       	mov    $0x200,%eax
    22f5:	89 44 24 04          	mov    %eax,0x4(%esp)
    22f9:	c7 04 24 d4 4d 00 00 	movl   $0x4dd4,(%esp)
    2300:	e8 b3 1d 00 00       	call   40b8 <open>
    2305:	85 c0                	test   %eax,%eax
    2307:	0f 89 7c 03 00 00    	jns    2689 <subdir+0x609>
  if(open("dd", O_RDWR) >= 0){
    230d:	b8 02 00 00 00       	mov    $0x2,%eax
    2312:	89 44 24 04          	mov    %eax,0x4(%esp)
    2316:	c7 04 24 d4 4d 00 00 	movl   $0x4dd4,(%esp)
    231d:	e8 96 1d 00 00       	call   40b8 <open>
    2322:	85 c0                	test   %eax,%eax
    2324:	0f 89 3f 03 00 00    	jns    2669 <subdir+0x5e9>
  if(open("dd", O_WRONLY) >= 0){
    232a:	b8 01 00 00 00       	mov    $0x1,%eax
    232f:	89 44 24 04          	mov    %eax,0x4(%esp)
    2333:	c7 04 24 d4 4d 00 00 	movl   $0x4dd4,(%esp)
    233a:	e8 79 1d 00 00       	call   40b8 <open>
    233f:	85 c0                	test   %eax,%eax
    2341:	0f 89 02 03 00 00    	jns    2649 <subdir+0x5c9>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    2347:	bb b6 4e 00 00       	mov    $0x4eb6,%ebx
    234c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    2350:	c7 04 24 22 4e 00 00 	movl   $0x4e22,(%esp)
    2357:	e8 7c 1d 00 00       	call   40d8 <link>
    235c:	85 c0                	test   %eax,%eax
    235e:	0f 84 c5 02 00 00    	je     2629 <subdir+0x5a9>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    2364:	b9 b6 4e 00 00       	mov    $0x4eb6,%ecx
    2369:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    236d:	c7 04 24 47 4e 00 00 	movl   $0x4e47,(%esp)
    2374:	e8 5f 1d 00 00       	call   40d8 <link>
    2379:	85 c0                	test   %eax,%eax
    237b:	0f 84 88 02 00 00    	je     2609 <subdir+0x589>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2381:	ba 6e 4d 00 00       	mov    $0x4d6e,%edx
    2386:	89 54 24 04          	mov    %edx,0x4(%esp)
    238a:	c7 04 24 0d 4d 00 00 	movl   $0x4d0d,(%esp)
    2391:	e8 42 1d 00 00       	call   40d8 <link>
    2396:	85 c0                	test   %eax,%eax
    2398:	0f 84 cb 01 00 00    	je     2569 <subdir+0x4e9>
  if(mkdir("dd/ff/ff") == 0){
    239e:	c7 04 24 22 4e 00 00 	movl   $0x4e22,(%esp)
    23a5:	e8 36 1d 00 00       	call   40e0 <mkdir>
    23aa:	85 c0                	test   %eax,%eax
    23ac:	0f 84 97 01 00 00    	je     2549 <subdir+0x4c9>
  if(mkdir("dd/xx/ff") == 0){
    23b2:	c7 04 24 47 4e 00 00 	movl   $0x4e47,(%esp)
    23b9:	e8 22 1d 00 00       	call   40e0 <mkdir>
    23be:	85 c0                	test   %eax,%eax
    23c0:	0f 84 e3 04 00 00    	je     28a9 <subdir+0x829>
  if(mkdir("dd/dd/ffff") == 0){
    23c6:	c7 04 24 6e 4d 00 00 	movl   $0x4d6e,(%esp)
    23cd:	e8 0e 1d 00 00       	call   40e0 <mkdir>
    23d2:	85 c0                	test   %eax,%eax
    23d4:	0f 84 af 04 00 00    	je     2889 <subdir+0x809>
  if(unlink("dd/xx/ff") == 0){
    23da:	c7 04 24 47 4e 00 00 	movl   $0x4e47,(%esp)
    23e1:	e8 e2 1c 00 00       	call   40c8 <unlink>
    23e6:	85 c0                	test   %eax,%eax
    23e8:	0f 84 7b 04 00 00    	je     2869 <subdir+0x7e9>
  if(unlink("dd/ff/ff") == 0){
    23ee:	c7 04 24 22 4e 00 00 	movl   $0x4e22,(%esp)
    23f5:	e8 ce 1c 00 00       	call   40c8 <unlink>
    23fa:	85 c0                	test   %eax,%eax
    23fc:	0f 84 47 04 00 00    	je     2849 <subdir+0x7c9>
  if(chdir("dd/ff") == 0){
    2402:	c7 04 24 0d 4d 00 00 	movl   $0x4d0d,(%esp)
    2409:	e8 da 1c 00 00       	call   40e8 <chdir>
    240e:	85 c0                	test   %eax,%eax
    2410:	0f 84 13 04 00 00    	je     2829 <subdir+0x7a9>
  if(chdir("dd/xx") == 0){
    2416:	c7 04 24 b9 4e 00 00 	movl   $0x4eb9,(%esp)
    241d:	e8 c6 1c 00 00       	call   40e8 <chdir>
    2422:	85 c0                	test   %eax,%eax
    2424:	0f 84 df 03 00 00    	je     2809 <subdir+0x789>
  if(unlink("dd/dd/ffff") != 0){
    242a:	c7 04 24 6e 4d 00 00 	movl   $0x4d6e,(%esp)
    2431:	e8 92 1c 00 00       	call   40c8 <unlink>
    2436:	85 c0                	test   %eax,%eax
    2438:	0f 85 ab 00 00 00    	jne    24e9 <subdir+0x469>
  if(unlink("dd/ff") != 0){
    243e:	c7 04 24 0d 4d 00 00 	movl   $0x4d0d,(%esp)
    2445:	e8 7e 1c 00 00       	call   40c8 <unlink>
    244a:	85 c0                	test   %eax,%eax
    244c:	0f 85 97 03 00 00    	jne    27e9 <subdir+0x769>
  if(unlink("dd") == 0){
    2452:	c7 04 24 d4 4d 00 00 	movl   $0x4dd4,(%esp)
    2459:	e8 6a 1c 00 00       	call   40c8 <unlink>
    245e:	85 c0                	test   %eax,%eax
    2460:	0f 84 63 03 00 00    	je     27c9 <subdir+0x749>
  if(unlink("dd/dd") < 0){
    2466:	c7 04 24 e9 4c 00 00 	movl   $0x4ce9,(%esp)
    246d:	e8 56 1c 00 00       	call   40c8 <unlink>
    2472:	85 c0                	test   %eax,%eax
    2474:	0f 88 2f 03 00 00    	js     27a9 <subdir+0x729>
  if(unlink("dd") < 0){
    247a:	c7 04 24 d4 4d 00 00 	movl   $0x4dd4,(%esp)
    2481:	e8 42 1c 00 00       	call   40c8 <unlink>
    2486:	85 c0                	test   %eax,%eax
    2488:	0f 88 fb 02 00 00    	js     2789 <subdir+0x709>
  printf(1, "subdir ok\n");
    248e:	b8 b6 4f 00 00       	mov    $0x4fb6,%eax
    2493:	89 44 24 04          	mov    %eax,0x4(%esp)
    2497:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    249e:	e8 3d 1d 00 00       	call   41e0 <printf>
}
    24a3:	83 c4 14             	add    $0x14,%esp
    24a6:	5b                   	pop    %ebx
    24a7:	5d                   	pop    %ebp
    24a8:	c3                   	ret    
    printf(1, "dd/dd/../ff wrong content\n");
    24a9:	c7 44 24 04 53 4d 00 	movl   $0x4d53,0x4(%esp)
    24b0:	00 
    24b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24b8:	e8 23 1d 00 00       	call   41e0 <printf>
    exit(0);
    24bd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    24c4:	e8 af 1b 00 00       	call   4078 <exit>
    printf(1, "chdir dd/../../dd failed\n");
    24c9:	c7 44 24 04 ae 4d 00 	movl   $0x4dae,0x4(%esp)
    24d0:	00 
    24d1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24d8:	e8 03 1d 00 00       	call   41e0 <printf>
    exit(0);
    24dd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    24e4:	e8 8f 1b 00 00       	call   4078 <exit>
    printf(1, "unlink dd/dd/ff failed\n");
    24e9:	c7 44 24 04 79 4d 00 	movl   $0x4d79,0x4(%esp)
    24f0:	00 
    24f1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24f8:	e8 e3 1c 00 00       	call   41e0 <printf>
    exit(0);
    24fd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2504:	e8 6f 1b 00 00       	call   4078 <exit>
    printf(1, "create dd/ff/ff succeeded!\n");
    2509:	c7 44 24 04 2b 4e 00 	movl   $0x4e2b,0x4(%esp)
    2510:	00 
    2511:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2518:	e8 c3 1c 00 00       	call   41e0 <printf>
    exit(0);
    251d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2524:	e8 4f 1b 00 00       	call   4078 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    2529:	c7 44 24 04 10 58 00 	movl   $0x5810,0x4(%esp)
    2530:	00 
    2531:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2538:	e8 a3 1c 00 00       	call   41e0 <printf>
    exit(0);
    253d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2544:	e8 2f 1b 00 00       	call   4078 <exit>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    2549:	c7 44 24 04 bf 4e 00 	movl   $0x4ebf,0x4(%esp)
    2550:	00 
    2551:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2558:	e8 83 1c 00 00       	call   41e0 <printf>
    exit(0);
    255d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2564:	e8 0f 1b 00 00       	call   4078 <exit>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    2569:	c7 44 24 04 80 58 00 	movl   $0x5880,0x4(%esp)
    2570:	00 
    2571:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2578:	e8 63 1c 00 00       	call   41e0 <printf>
    exit(0);
    257d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2584:	e8 ef 1a 00 00       	call   4078 <exit>
    printf(1, "open dd/dd/../ff failed\n");
    2589:	c7 44 24 04 3a 4d 00 	movl   $0x4d3a,0x4(%esp)
    2590:	00 
    2591:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2598:	e8 43 1c 00 00       	call   41e0 <printf>
    exit(0);
    259d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    25a4:	e8 cf 1a 00 00       	call   4078 <exit>
    printf(1, "create dd/dd/ff failed\n");
    25a9:	c7 44 24 04 13 4d 00 	movl   $0x4d13,0x4(%esp)
    25b0:	00 
    25b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    25b8:	e8 23 1c 00 00       	call   41e0 <printf>
    exit(0);
    25bd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    25c4:	e8 af 1a 00 00       	call   4078 <exit>
    printf(1, "chdir ./.. failed\n");
    25c9:	c7 44 24 04 dc 4d 00 	movl   $0x4ddc,0x4(%esp)
    25d0:	00 
    25d1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    25d8:	e8 03 1c 00 00       	call   41e0 <printf>
    exit(0);
    25dd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    25e4:	e8 8f 1a 00 00       	call   4078 <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    25e9:	c7 44 24 04 c8 57 00 	movl   $0x57c8,0x4(%esp)
    25f0:	00 
    25f1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    25f8:	e8 e3 1b 00 00       	call   41e0 <printf>
    exit(0);
    25fd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2604:	e8 6f 1a 00 00       	call   4078 <exit>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    2609:	c7 44 24 04 5c 58 00 	movl   $0x585c,0x4(%esp)
    2610:	00 
    2611:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2618:	e8 c3 1b 00 00       	call   41e0 <printf>
    exit(0);
    261d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2624:	e8 4f 1a 00 00       	call   4078 <exit>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    2629:	c7 44 24 04 38 58 00 	movl   $0x5838,0x4(%esp)
    2630:	00 
    2631:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2638:	e8 a3 1b 00 00       	call   41e0 <printf>
    exit(0);
    263d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2644:	e8 2f 1a 00 00       	call   4078 <exit>
    printf(1, "open dd wronly succeeded!\n");
    2649:	c7 44 24 04 9b 4e 00 	movl   $0x4e9b,0x4(%esp)
    2650:	00 
    2651:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2658:	e8 83 1b 00 00       	call   41e0 <printf>
    exit(0);
    265d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2664:	e8 0f 1a 00 00       	call   4078 <exit>
    printf(1, "open dd rdwr succeeded!\n");
    2669:	c7 44 24 04 82 4e 00 	movl   $0x4e82,0x4(%esp)
    2670:	00 
    2671:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2678:	e8 63 1b 00 00       	call   41e0 <printf>
    exit(0);
    267d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2684:	e8 ef 19 00 00       	call   4078 <exit>
    printf(1, "create dd succeeded!\n");
    2689:	c7 44 24 04 6c 4e 00 	movl   $0x4e6c,0x4(%esp)
    2690:	00 
    2691:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2698:	e8 43 1b 00 00       	call   41e0 <printf>
    exit(0);
    269d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    26a4:	e8 cf 19 00 00       	call   4078 <exit>
    printf(1, "create dd/xx/ff succeeded!\n");
    26a9:	c7 44 24 04 50 4e 00 	movl   $0x4e50,0x4(%esp)
    26b0:	00 
    26b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    26b8:	e8 23 1b 00 00       	call   41e0 <printf>
    exit(0);
    26bd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    26c4:	e8 af 19 00 00       	call   4078 <exit>
    printf(1, "chdir dd failed\n");
    26c9:	c7 44 24 04 91 4d 00 	movl   $0x4d91,0x4(%esp)
    26d0:	00 
    26d1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    26d8:	e8 03 1b 00 00       	call   41e0 <printf>
    exit(0);
    26dd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    26e4:	e8 8f 19 00 00       	call   4078 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    26e9:	c7 44 24 04 ec 57 00 	movl   $0x57ec,0x4(%esp)
    26f0:	00 
    26f1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    26f8:	e8 e3 1a 00 00       	call   41e0 <printf>
    exit(0);
    26fd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2704:	e8 6f 19 00 00       	call   4078 <exit>
    printf(1, "subdir mkdir dd/dd failed\n");
    2709:	c7 44 24 04 ef 4c 00 	movl   $0x4cef,0x4(%esp)
    2710:	00 
    2711:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2718:	e8 c3 1a 00 00       	call   41e0 <printf>
    exit(0);
    271d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2724:	e8 4f 19 00 00       	call   4078 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    2729:	c7 44 24 04 a0 57 00 	movl   $0x57a0,0x4(%esp)
    2730:	00 
    2731:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2738:	e8 a3 1a 00 00       	call   41e0 <printf>
    exit(0);
    273d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2744:	e8 2f 19 00 00       	call   4078 <exit>
    printf(1, "create dd/ff failed\n");
    2749:	c7 44 24 04 d3 4c 00 	movl   $0x4cd3,0x4(%esp)
    2750:	00 
    2751:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2758:	e8 83 1a 00 00       	call   41e0 <printf>
    exit(0);
    275d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2764:	e8 0f 19 00 00       	call   4078 <exit>
    printf(1, "subdir mkdir dd failed\n");
    2769:	c7 44 24 04 bb 4c 00 	movl   $0x4cbb,0x4(%esp)
    2770:	00 
    2771:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2778:	e8 63 1a 00 00       	call   41e0 <printf>
    exit(0);
    277d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2784:	e8 ef 18 00 00       	call   4078 <exit>
    printf(1, "unlink dd failed\n");
    2789:	c7 44 24 04 a4 4f 00 	movl   $0x4fa4,0x4(%esp)
    2790:	00 
    2791:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2798:	e8 43 1a 00 00       	call   41e0 <printf>
    exit(0);
    279d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    27a4:	e8 cf 18 00 00       	call   4078 <exit>
    printf(1, "unlink dd/dd failed\n");
    27a9:	c7 44 24 04 8f 4f 00 	movl   $0x4f8f,0x4(%esp)
    27b0:	00 
    27b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27b8:	e8 23 1a 00 00       	call   41e0 <printf>
    exit(0);
    27bd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    27c4:	e8 af 18 00 00       	call   4078 <exit>
    printf(1, "unlink non-empty dd succeeded!\n");
    27c9:	c7 44 24 04 a4 58 00 	movl   $0x58a4,0x4(%esp)
    27d0:	00 
    27d1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27d8:	e8 03 1a 00 00       	call   41e0 <printf>
    exit(0);
    27dd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    27e4:	e8 8f 18 00 00       	call   4078 <exit>
    printf(1, "unlink dd/ff failed\n");
    27e9:	c7 44 24 04 7a 4f 00 	movl   $0x4f7a,0x4(%esp)
    27f0:	00 
    27f1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27f8:	e8 e3 19 00 00       	call   41e0 <printf>
    exit(0);
    27fd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2804:	e8 6f 18 00 00       	call   4078 <exit>
    printf(1, "chdir dd/xx succeeded!\n");
    2809:	c7 44 24 04 62 4f 00 	movl   $0x4f62,0x4(%esp)
    2810:	00 
    2811:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2818:	e8 c3 19 00 00       	call   41e0 <printf>
    exit(0);
    281d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2824:	e8 4f 18 00 00       	call   4078 <exit>
    printf(1, "chdir dd/ff succeeded!\n");
    2829:	c7 44 24 04 4a 4f 00 	movl   $0x4f4a,0x4(%esp)
    2830:	00 
    2831:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2838:	e8 a3 19 00 00       	call   41e0 <printf>
    exit(0);
    283d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2844:	e8 2f 18 00 00       	call   4078 <exit>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    2849:	c7 44 24 04 2e 4f 00 	movl   $0x4f2e,0x4(%esp)
    2850:	00 
    2851:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2858:	e8 83 19 00 00       	call   41e0 <printf>
    exit(0);
    285d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2864:	e8 0f 18 00 00       	call   4078 <exit>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    2869:	c7 44 24 04 12 4f 00 	movl   $0x4f12,0x4(%esp)
    2870:	00 
    2871:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2878:	e8 63 19 00 00       	call   41e0 <printf>
    exit(0);
    287d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2884:	e8 ef 17 00 00       	call   4078 <exit>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    2889:	c7 44 24 04 f5 4e 00 	movl   $0x4ef5,0x4(%esp)
    2890:	00 
    2891:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2898:	e8 43 19 00 00       	call   41e0 <printf>
    exit(0);
    289d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    28a4:	e8 cf 17 00 00       	call   4078 <exit>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    28a9:	c7 44 24 04 da 4e 00 	movl   $0x4eda,0x4(%esp)
    28b0:	00 
    28b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    28b8:	e8 23 19 00 00       	call   41e0 <printf>
    exit(0);
    28bd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    28c4:	e8 af 17 00 00       	call   4078 <exit>
    printf(1, "read dd/dd/ffff wrong len\n");
    28c9:	c7 44 24 04 07 4e 00 	movl   $0x4e07,0x4(%esp)
    28d0:	00 
    28d1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    28d8:	e8 03 19 00 00       	call   41e0 <printf>
    exit(0);
    28dd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    28e4:	e8 8f 17 00 00       	call   4078 <exit>
    printf(1, "open dd/dd/ffff failed\n");
    28e9:	c7 44 24 04 ef 4d 00 	movl   $0x4def,0x4(%esp)
    28f0:	00 
    28f1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    28f8:	e8 e3 18 00 00       	call   41e0 <printf>
    exit(0);
    28fd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2904:	e8 6f 17 00 00       	call   4078 <exit>
    2909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00002910 <bigwrite>:
{
    2910:	55                   	push   %ebp
  printf(1, "bigwrite test\n");
    2911:	b8 c1 4f 00 00       	mov    $0x4fc1,%eax
{
    2916:	89 e5                	mov    %esp,%ebp
    2918:	56                   	push   %esi
    2919:	53                   	push   %ebx
  for(sz = 499; sz < 12*512; sz += 471){
    291a:	bb f3 01 00 00       	mov    $0x1f3,%ebx
{
    291f:	83 ec 10             	sub    $0x10,%esp
  printf(1, "bigwrite test\n");
    2922:	89 44 24 04          	mov    %eax,0x4(%esp)
    2926:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    292d:	e8 ae 18 00 00       	call   41e0 <printf>
  unlink("bigwrite");
    2932:	c7 04 24 d0 4f 00 00 	movl   $0x4fd0,(%esp)
    2939:	e8 8a 17 00 00       	call   40c8 <unlink>
    293e:	66 90                	xchg   %ax,%ax
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2940:	b8 02 02 00 00       	mov    $0x202,%eax
    2945:	89 44 24 04          	mov    %eax,0x4(%esp)
    2949:	c7 04 24 d0 4f 00 00 	movl   $0x4fd0,(%esp)
    2950:	e8 63 17 00 00       	call   40b8 <open>
    if(fd < 0){
    2955:	85 c0                	test   %eax,%eax
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2957:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    2959:	0f 88 99 00 00 00    	js     29f8 <bigwrite+0xe8>
      int cc = write(fd, buf, sz);
    295f:	b8 00 8e 00 00       	mov    $0x8e00,%eax
    2964:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    2968:	89 44 24 04          	mov    %eax,0x4(%esp)
    296c:	89 34 24             	mov    %esi,(%esp)
    296f:	e8 24 17 00 00       	call   4098 <write>
      if(cc != sz){
    2974:	39 d8                	cmp    %ebx,%eax
    2976:	75 57                	jne    29cf <bigwrite+0xbf>
      int cc = write(fd, buf, sz);
    2978:	b8 00 8e 00 00       	mov    $0x8e00,%eax
    297d:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    2981:	89 44 24 04          	mov    %eax,0x4(%esp)
    2985:	89 34 24             	mov    %esi,(%esp)
    2988:	e8 0b 17 00 00       	call   4098 <write>
      if(cc != sz){
    298d:	39 d8                	cmp    %ebx,%eax
    298f:	75 3e                	jne    29cf <bigwrite+0xbf>
    close(fd);
    2991:	89 34 24             	mov    %esi,(%esp)
  for(sz = 499; sz < 12*512; sz += 471){
    2994:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
    close(fd);
    299a:	e8 01 17 00 00       	call   40a0 <close>
    unlink("bigwrite");
    299f:	c7 04 24 d0 4f 00 00 	movl   $0x4fd0,(%esp)
    29a6:	e8 1d 17 00 00       	call   40c8 <unlink>
  for(sz = 499; sz < 12*512; sz += 471){
    29ab:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    29b1:	75 8d                	jne    2940 <bigwrite+0x30>
  printf(1, "bigwrite ok\n");
    29b3:	b8 03 50 00 00       	mov    $0x5003,%eax
    29b8:	89 44 24 04          	mov    %eax,0x4(%esp)
    29bc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    29c3:	e8 18 18 00 00       	call   41e0 <printf>
}
    29c8:	83 c4 10             	add    $0x10,%esp
    29cb:	5b                   	pop    %ebx
    29cc:	5e                   	pop    %esi
    29cd:	5d                   	pop    %ebp
    29ce:	c3                   	ret    
        printf(1, "write(%d) ret %d\n", sz, cc);
    29cf:	ba f1 4f 00 00       	mov    $0x4ff1,%edx
    29d4:	89 44 24 0c          	mov    %eax,0xc(%esp)
    29d8:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    29dc:	89 54 24 04          	mov    %edx,0x4(%esp)
    29e0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    29e7:	e8 f4 17 00 00       	call   41e0 <printf>
        exit(0);
    29ec:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    29f3:	e8 80 16 00 00       	call   4078 <exit>
      printf(1, "cannot create bigwrite\n");
    29f8:	b9 d9 4f 00 00       	mov    $0x4fd9,%ecx
    29fd:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    2a01:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a08:	e8 d3 17 00 00       	call   41e0 <printf>
      exit(0);
    2a0d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2a14:	e8 5f 16 00 00       	call   4078 <exit>
    2a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00002a20 <bigfile>:
{
    2a20:	55                   	push   %ebp
  printf(1, "bigfile test\n");
    2a21:	b9 10 50 00 00       	mov    $0x5010,%ecx
{
    2a26:	89 e5                	mov    %esp,%ebp
    2a28:	57                   	push   %edi
    2a29:	56                   	push   %esi
    2a2a:	53                   	push   %ebx
  fd = open("bigfile", O_CREATE | O_RDWR);
    2a2b:	bb 02 02 00 00       	mov    $0x202,%ebx
{
    2a30:	83 ec 1c             	sub    $0x1c,%esp
  printf(1, "bigfile test\n");
    2a33:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    2a37:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a3e:	e8 9d 17 00 00       	call   41e0 <printf>
  unlink("bigfile");
    2a43:	c7 04 24 2c 50 00 00 	movl   $0x502c,(%esp)
    2a4a:	e8 79 16 00 00       	call   40c8 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    2a4f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    2a53:	c7 04 24 2c 50 00 00 	movl   $0x502c,(%esp)
    2a5a:	e8 59 16 00 00       	call   40b8 <open>
  if(fd < 0){
    2a5f:	85 c0                	test   %eax,%eax
    2a61:	0f 88 aa 01 00 00    	js     2c11 <bigfile+0x1f1>
    2a67:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 20; i++){
    2a69:	31 db                	xor    %ebx,%ebx
    2a6b:	90                   	nop
    2a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memset(buf, i, 600);
    2a70:	b8 58 02 00 00       	mov    $0x258,%eax
    2a75:	89 44 24 08          	mov    %eax,0x8(%esp)
    2a79:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    2a7d:	c7 04 24 00 8e 00 00 	movl   $0x8e00,(%esp)
    2a84:	e8 57 14 00 00       	call   3ee0 <memset>
    if(write(fd, buf, 600) != 600){
    2a89:	b8 58 02 00 00       	mov    $0x258,%eax
    2a8e:	ba 00 8e 00 00       	mov    $0x8e00,%edx
    2a93:	89 44 24 08          	mov    %eax,0x8(%esp)
    2a97:	89 54 24 04          	mov    %edx,0x4(%esp)
    2a9b:	89 34 24             	mov    %esi,(%esp)
    2a9e:	e8 f5 15 00 00       	call   4098 <write>
    2aa3:	3d 58 02 00 00       	cmp    $0x258,%eax
    2aa8:	0f 85 22 01 00 00    	jne    2bd0 <bigfile+0x1b0>
  for(i = 0; i < 20; i++){
    2aae:	43                   	inc    %ebx
    2aaf:	83 fb 14             	cmp    $0x14,%ebx
    2ab2:	75 bc                	jne    2a70 <bigfile+0x50>
  close(fd);
    2ab4:	89 34 24             	mov    %esi,(%esp)
    2ab7:	e8 e4 15 00 00       	call   40a0 <close>
  fd = open("bigfile", 0);
    2abc:	31 c0                	xor    %eax,%eax
    2abe:	89 44 24 04          	mov    %eax,0x4(%esp)
    2ac2:	c7 04 24 2c 50 00 00 	movl   $0x502c,(%esp)
    2ac9:	e8 ea 15 00 00       	call   40b8 <open>
  if(fd < 0){
    2ace:	85 c0                	test   %eax,%eax
  fd = open("bigfile", 0);
    2ad0:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2ad2:	0f 88 19 01 00 00    	js     2bf1 <bigfile+0x1d1>
  total = 0;
    2ad8:	31 db                	xor    %ebx,%ebx
  for(i = 0; ; i++){
    2ada:	31 ff                	xor    %edi,%edi
    2adc:	eb 2e                	jmp    2b0c <bigfile+0xec>
    2ade:	66 90                	xchg   %ax,%ax
    if(cc != 300){
    2ae0:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2ae5:	0f 85 a3 00 00 00    	jne    2b8e <bigfile+0x16e>
    if(buf[0] != i/2 || buf[299] != i/2){
    2aeb:	0f be 05 00 8e 00 00 	movsbl 0x8e00,%eax
    2af2:	89 fa                	mov    %edi,%edx
    2af4:	d1 fa                	sar    %edx
    2af6:	39 d0                	cmp    %edx,%eax
    2af8:	75 73                	jne    2b6d <bigfile+0x14d>
    2afa:	0f be 15 2b 8f 00 00 	movsbl 0x8f2b,%edx
    2b01:	39 d0                	cmp    %edx,%eax
    2b03:	75 68                	jne    2b6d <bigfile+0x14d>
    total += cc;
    2b05:	81 c3 2c 01 00 00    	add    $0x12c,%ebx
  for(i = 0; ; i++){
    2b0b:	47                   	inc    %edi
    cc = read(fd, buf, 300);
    2b0c:	b8 2c 01 00 00       	mov    $0x12c,%eax
    2b11:	89 44 24 08          	mov    %eax,0x8(%esp)
    2b15:	b8 00 8e 00 00       	mov    $0x8e00,%eax
    2b1a:	89 44 24 04          	mov    %eax,0x4(%esp)
    2b1e:	89 34 24             	mov    %esi,(%esp)
    2b21:	e8 6a 15 00 00       	call   4090 <read>
    if(cc < 0){
    2b26:	85 c0                	test   %eax,%eax
    2b28:	0f 88 81 00 00 00    	js     2baf <bigfile+0x18f>
    if(cc == 0)
    2b2e:	75 b0                	jne    2ae0 <bigfile+0xc0>
  close(fd);
    2b30:	89 34 24             	mov    %esi,(%esp)
    2b33:	e8 68 15 00 00       	call   40a0 <close>
  if(total != 20*600){
    2b38:	81 fb e0 2e 00 00    	cmp    $0x2ee0,%ebx
    2b3e:	0f 85 ed 00 00 00    	jne    2c31 <bigfile+0x211>
  unlink("bigfile");
    2b44:	c7 04 24 2c 50 00 00 	movl   $0x502c,(%esp)
    2b4b:	e8 78 15 00 00       	call   40c8 <unlink>
  printf(1, "bigfile test ok\n");
    2b50:	b8 bb 50 00 00       	mov    $0x50bb,%eax
    2b55:	89 44 24 04          	mov    %eax,0x4(%esp)
    2b59:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b60:	e8 7b 16 00 00       	call   41e0 <printf>
}
    2b65:	83 c4 1c             	add    $0x1c,%esp
    2b68:	5b                   	pop    %ebx
    2b69:	5e                   	pop    %esi
    2b6a:	5f                   	pop    %edi
    2b6b:	5d                   	pop    %ebp
    2b6c:	c3                   	ret    
      printf(1, "read bigfile wrong data\n");
    2b6d:	ba 88 50 00 00       	mov    $0x5088,%edx
    2b72:	89 54 24 04          	mov    %edx,0x4(%esp)
    2b76:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b7d:	e8 5e 16 00 00       	call   41e0 <printf>
      exit(0);
    2b82:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2b89:	e8 ea 14 00 00       	call   4078 <exit>
      printf(1, "short read bigfile\n");
    2b8e:	b9 74 50 00 00       	mov    $0x5074,%ecx
    2b93:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    2b97:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b9e:	e8 3d 16 00 00       	call   41e0 <printf>
      exit(0);
    2ba3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2baa:	e8 c9 14 00 00       	call   4078 <exit>
      printf(1, "read bigfile failed\n");
    2baf:	bb 5f 50 00 00       	mov    $0x505f,%ebx
    2bb4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    2bb8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2bbf:	e8 1c 16 00 00       	call   41e0 <printf>
      exit(0);
    2bc4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2bcb:	e8 a8 14 00 00       	call   4078 <exit>
      printf(1, "write bigfile failed\n");
    2bd0:	b8 34 50 00 00       	mov    $0x5034,%eax
    2bd5:	89 44 24 04          	mov    %eax,0x4(%esp)
    2bd9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2be0:	e8 fb 15 00 00       	call   41e0 <printf>
      exit(0);
    2be5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2bec:	e8 87 14 00 00       	call   4078 <exit>
    printf(1, "cannot open bigfile\n");
    2bf1:	c7 44 24 04 4a 50 00 	movl   $0x504a,0x4(%esp)
    2bf8:	00 
    2bf9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c00:	e8 db 15 00 00       	call   41e0 <printf>
    exit(0);
    2c05:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2c0c:	e8 67 14 00 00       	call   4078 <exit>
    printf(1, "cannot create bigfile");
    2c11:	c7 44 24 04 1e 50 00 	movl   $0x501e,0x4(%esp)
    2c18:	00 
    2c19:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c20:	e8 bb 15 00 00       	call   41e0 <printf>
    exit(0);
    2c25:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2c2c:	e8 47 14 00 00       	call   4078 <exit>
    printf(1, "read bigfile wrong total\n");
    2c31:	c7 44 24 04 a1 50 00 	movl   $0x50a1,0x4(%esp)
    2c38:	00 
    2c39:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c40:	e8 9b 15 00 00       	call   41e0 <printf>
    exit(0);
    2c45:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2c4c:	e8 27 14 00 00       	call   4078 <exit>
    2c51:	eb 0d                	jmp    2c60 <fourteen>
    2c53:	90                   	nop
    2c54:	90                   	nop
    2c55:	90                   	nop
    2c56:	90                   	nop
    2c57:	90                   	nop
    2c58:	90                   	nop
    2c59:	90                   	nop
    2c5a:	90                   	nop
    2c5b:	90                   	nop
    2c5c:	90                   	nop
    2c5d:	90                   	nop
    2c5e:	90                   	nop
    2c5f:	90                   	nop

00002c60 <fourteen>:
{
    2c60:	55                   	push   %ebp
  printf(1, "fourteen test\n");
    2c61:	b8 cc 50 00 00       	mov    $0x50cc,%eax
{
    2c66:	89 e5                	mov    %esp,%ebp
    2c68:	83 ec 18             	sub    $0x18,%esp
  printf(1, "fourteen test\n");
    2c6b:	89 44 24 04          	mov    %eax,0x4(%esp)
    2c6f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c76:	e8 65 15 00 00       	call   41e0 <printf>
  if(mkdir("12345678901234") != 0){
    2c7b:	c7 04 24 07 51 00 00 	movl   $0x5107,(%esp)
    2c82:	e8 59 14 00 00       	call   40e0 <mkdir>
    2c87:	85 c0                	test   %eax,%eax
    2c89:	0f 85 92 00 00 00    	jne    2d21 <fourteen+0xc1>
  if(mkdir("12345678901234/123456789012345") != 0){
    2c8f:	c7 04 24 c4 58 00 00 	movl   $0x58c4,(%esp)
    2c96:	e8 45 14 00 00       	call   40e0 <mkdir>
    2c9b:	85 c0                	test   %eax,%eax
    2c9d:	0f 85 1e 01 00 00    	jne    2dc1 <fourteen+0x161>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2ca3:	b9 00 02 00 00       	mov    $0x200,%ecx
    2ca8:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    2cac:	c7 04 24 14 59 00 00 	movl   $0x5914,(%esp)
    2cb3:	e8 00 14 00 00       	call   40b8 <open>
  if(fd < 0){
    2cb8:	85 c0                	test   %eax,%eax
    2cba:	0f 88 e1 00 00 00    	js     2da1 <fourteen+0x141>
  close(fd);
    2cc0:	89 04 24             	mov    %eax,(%esp)
    2cc3:	e8 d8 13 00 00       	call   40a0 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2cc8:	31 d2                	xor    %edx,%edx
    2cca:	89 54 24 04          	mov    %edx,0x4(%esp)
    2cce:	c7 04 24 84 59 00 00 	movl   $0x5984,(%esp)
    2cd5:	e8 de 13 00 00       	call   40b8 <open>
  if(fd < 0){
    2cda:	85 c0                	test   %eax,%eax
    2cdc:	0f 88 9f 00 00 00    	js     2d81 <fourteen+0x121>
  close(fd);
    2ce2:	89 04 24             	mov    %eax,(%esp)
    2ce5:	e8 b6 13 00 00       	call   40a0 <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    2cea:	c7 04 24 f8 50 00 00 	movl   $0x50f8,(%esp)
    2cf1:	e8 ea 13 00 00       	call   40e0 <mkdir>
    2cf6:	85 c0                	test   %eax,%eax
    2cf8:	74 67                	je     2d61 <fourteen+0x101>
  if(mkdir("123456789012345/12345678901234") == 0){
    2cfa:	c7 04 24 20 5a 00 00 	movl   $0x5a20,(%esp)
    2d01:	e8 da 13 00 00       	call   40e0 <mkdir>
    2d06:	85 c0                	test   %eax,%eax
    2d08:	74 37                	je     2d41 <fourteen+0xe1>
  printf(1, "fourteen ok\n");
    2d0a:	b8 16 51 00 00       	mov    $0x5116,%eax
    2d0f:	89 44 24 04          	mov    %eax,0x4(%esp)
    2d13:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d1a:	e8 c1 14 00 00       	call   41e0 <printf>
}
    2d1f:	c9                   	leave  
    2d20:	c3                   	ret    
    printf(1, "mkdir 12345678901234 failed\n");
    2d21:	c7 44 24 04 db 50 00 	movl   $0x50db,0x4(%esp)
    2d28:	00 
    2d29:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d30:	e8 ab 14 00 00       	call   41e0 <printf>
    exit(0);
    2d35:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d3c:	e8 37 13 00 00       	call   4078 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2d41:	c7 44 24 04 40 5a 00 	movl   $0x5a40,0x4(%esp)
    2d48:	00 
    2d49:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d50:	e8 8b 14 00 00       	call   41e0 <printf>
    exit(0);
    2d55:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d5c:	e8 17 13 00 00       	call   4078 <exit>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2d61:	c7 44 24 04 f0 59 00 	movl   $0x59f0,0x4(%esp)
    2d68:	00 
    2d69:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d70:	e8 6b 14 00 00       	call   41e0 <printf>
    exit(0);
    2d75:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d7c:	e8 f7 12 00 00       	call   4078 <exit>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    2d81:	c7 44 24 04 b4 59 00 	movl   $0x59b4,0x4(%esp)
    2d88:	00 
    2d89:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d90:	e8 4b 14 00 00       	call   41e0 <printf>
    exit(0);
    2d95:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d9c:	e8 d7 12 00 00       	call   4078 <exit>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    2da1:	c7 44 24 04 44 59 00 	movl   $0x5944,0x4(%esp)
    2da8:	00 
    2da9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2db0:	e8 2b 14 00 00       	call   41e0 <printf>
    exit(0);
    2db5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2dbc:	e8 b7 12 00 00       	call   4078 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    2dc1:	c7 44 24 04 e4 58 00 	movl   $0x58e4,0x4(%esp)
    2dc8:	00 
    2dc9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2dd0:	e8 0b 14 00 00       	call   41e0 <printf>
    exit(0);
    2dd5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2ddc:	e8 97 12 00 00       	call   4078 <exit>
    2de1:	eb 0d                	jmp    2df0 <rmdot>
    2de3:	90                   	nop
    2de4:	90                   	nop
    2de5:	90                   	nop
    2de6:	90                   	nop
    2de7:	90                   	nop
    2de8:	90                   	nop
    2de9:	90                   	nop
    2dea:	90                   	nop
    2deb:	90                   	nop
    2dec:	90                   	nop
    2ded:	90                   	nop
    2dee:	90                   	nop
    2def:	90                   	nop

00002df0 <rmdot>:
{
    2df0:	55                   	push   %ebp
  printf(1, "rmdot test\n");
    2df1:	ba 23 51 00 00       	mov    $0x5123,%edx
{
    2df6:	89 e5                	mov    %esp,%ebp
    2df8:	83 ec 18             	sub    $0x18,%esp
  printf(1, "rmdot test\n");
    2dfb:	89 54 24 04          	mov    %edx,0x4(%esp)
    2dff:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e06:	e8 d5 13 00 00       	call   41e0 <printf>
  if(mkdir("dots") != 0){
    2e0b:	c7 04 24 2f 51 00 00 	movl   $0x512f,(%esp)
    2e12:	e8 c9 12 00 00       	call   40e0 <mkdir>
    2e17:	85 c0                	test   %eax,%eax
    2e19:	0f 85 9b 00 00 00    	jne    2eba <rmdot+0xca>
  if(chdir("dots") != 0){
    2e1f:	c7 04 24 2f 51 00 00 	movl   $0x512f,(%esp)
    2e26:	e8 bd 12 00 00       	call   40e8 <chdir>
    2e2b:	85 c0                	test   %eax,%eax
    2e2d:	0f 85 67 01 00 00    	jne    2f9a <rmdot+0x1aa>
  if(unlink(".") == 0){
    2e33:	c7 04 24 da 4d 00 00 	movl   $0x4dda,(%esp)
    2e3a:	e8 89 12 00 00       	call   40c8 <unlink>
    2e3f:	85 c0                	test   %eax,%eax
    2e41:	0f 84 33 01 00 00    	je     2f7a <rmdot+0x18a>
  if(unlink("..") == 0){
    2e47:	c7 04 24 d9 4d 00 00 	movl   $0x4dd9,(%esp)
    2e4e:	e8 75 12 00 00       	call   40c8 <unlink>
    2e53:	85 c0                	test   %eax,%eax
    2e55:	0f 84 ff 00 00 00    	je     2f5a <rmdot+0x16a>
  if(chdir("/") != 0){
    2e5b:	c7 04 24 a1 45 00 00 	movl   $0x45a1,(%esp)
    2e62:	e8 81 12 00 00       	call   40e8 <chdir>
    2e67:	85 c0                	test   %eax,%eax
    2e69:	0f 85 cb 00 00 00    	jne    2f3a <rmdot+0x14a>
  if(unlink("dots/.") == 0){
    2e6f:	c7 04 24 77 51 00 00 	movl   $0x5177,(%esp)
    2e76:	e8 4d 12 00 00       	call   40c8 <unlink>
    2e7b:	85 c0                	test   %eax,%eax
    2e7d:	0f 84 97 00 00 00    	je     2f1a <rmdot+0x12a>
  if(unlink("dots/..") == 0){
    2e83:	c7 04 24 95 51 00 00 	movl   $0x5195,(%esp)
    2e8a:	e8 39 12 00 00       	call   40c8 <unlink>
    2e8f:	85 c0                	test   %eax,%eax
    2e91:	74 67                	je     2efa <rmdot+0x10a>
  if(unlink("dots") != 0){
    2e93:	c7 04 24 2f 51 00 00 	movl   $0x512f,(%esp)
    2e9a:	e8 29 12 00 00       	call   40c8 <unlink>
    2e9f:	85 c0                	test   %eax,%eax
    2ea1:	75 37                	jne    2eda <rmdot+0xea>
  printf(1, "rmdot ok\n");
    2ea3:	b8 ca 51 00 00       	mov    $0x51ca,%eax
    2ea8:	89 44 24 04          	mov    %eax,0x4(%esp)
    2eac:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2eb3:	e8 28 13 00 00       	call   41e0 <printf>
}
    2eb8:	c9                   	leave  
    2eb9:	c3                   	ret    
    printf(1, "mkdir dots failed\n");
    2eba:	c7 44 24 04 34 51 00 	movl   $0x5134,0x4(%esp)
    2ec1:	00 
    2ec2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ec9:	e8 12 13 00 00       	call   41e0 <printf>
    exit(0);
    2ece:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2ed5:	e8 9e 11 00 00       	call   4078 <exit>
    printf(1, "unlink dots failed!\n");
    2eda:	c7 44 24 04 b5 51 00 	movl   $0x51b5,0x4(%esp)
    2ee1:	00 
    2ee2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ee9:	e8 f2 12 00 00       	call   41e0 <printf>
    exit(0);
    2eee:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2ef5:	e8 7e 11 00 00       	call   4078 <exit>
    printf(1, "unlink dots/.. worked!\n");
    2efa:	c7 44 24 04 9d 51 00 	movl   $0x519d,0x4(%esp)
    2f01:	00 
    2f02:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f09:	e8 d2 12 00 00       	call   41e0 <printf>
    exit(0);
    2f0e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f15:	e8 5e 11 00 00       	call   4078 <exit>
    printf(1, "unlink dots/. worked!\n");
    2f1a:	c7 44 24 04 7e 51 00 	movl   $0x517e,0x4(%esp)
    2f21:	00 
    2f22:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f29:	e8 b2 12 00 00       	call   41e0 <printf>
    exit(0);
    2f2e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f35:	e8 3e 11 00 00       	call   4078 <exit>
    printf(1, "chdir / failed\n");
    2f3a:	c7 44 24 04 a3 45 00 	movl   $0x45a3,0x4(%esp)
    2f41:	00 
    2f42:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f49:	e8 92 12 00 00       	call   41e0 <printf>
    exit(0);
    2f4e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f55:	e8 1e 11 00 00       	call   4078 <exit>
    printf(1, "rm .. worked!\n");
    2f5a:	c7 44 24 04 68 51 00 	movl   $0x5168,0x4(%esp)
    2f61:	00 
    2f62:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f69:	e8 72 12 00 00       	call   41e0 <printf>
    exit(0);
    2f6e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f75:	e8 fe 10 00 00       	call   4078 <exit>
    printf(1, "rm . worked!\n");
    2f7a:	c7 44 24 04 5a 51 00 	movl   $0x515a,0x4(%esp)
    2f81:	00 
    2f82:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f89:	e8 52 12 00 00       	call   41e0 <printf>
    exit(0);
    2f8e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f95:	e8 de 10 00 00       	call   4078 <exit>
    printf(1, "chdir dots failed\n");
    2f9a:	c7 44 24 04 47 51 00 	movl   $0x5147,0x4(%esp)
    2fa1:	00 
    2fa2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2fa9:	e8 32 12 00 00       	call   41e0 <printf>
    exit(0);
    2fae:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2fb5:	e8 be 10 00 00       	call   4078 <exit>
    2fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00002fc0 <dirfile>:
{
    2fc0:	55                   	push   %ebp
  printf(1, "dir vs file\n");
    2fc1:	b8 d4 51 00 00       	mov    $0x51d4,%eax
{
    2fc6:	89 e5                	mov    %esp,%ebp
    2fc8:	53                   	push   %ebx
    2fc9:	83 ec 14             	sub    $0x14,%esp
  printf(1, "dir vs file\n");
    2fcc:	89 44 24 04          	mov    %eax,0x4(%esp)
    2fd0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2fd7:	e8 04 12 00 00       	call   41e0 <printf>
  fd = open("dirfile", O_CREATE);
    2fdc:	ba 00 02 00 00       	mov    $0x200,%edx
    2fe1:	89 54 24 04          	mov    %edx,0x4(%esp)
    2fe5:	c7 04 24 e1 51 00 00 	movl   $0x51e1,(%esp)
    2fec:	e8 c7 10 00 00       	call   40b8 <open>
  if(fd < 0){
    2ff1:	85 c0                	test   %eax,%eax
    2ff3:	0f 88 62 01 00 00    	js     315b <dirfile+0x19b>
  close(fd);
    2ff9:	89 04 24             	mov    %eax,(%esp)
    2ffc:	e8 9f 10 00 00       	call   40a0 <close>
  if(chdir("dirfile") == 0){
    3001:	c7 04 24 e1 51 00 00 	movl   $0x51e1,(%esp)
    3008:	e8 db 10 00 00       	call   40e8 <chdir>
    300d:	85 c0                	test   %eax,%eax
    300f:	0f 84 26 01 00 00    	je     313b <dirfile+0x17b>
  fd = open("dirfile/xx", 0);
    3015:	31 c0                	xor    %eax,%eax
    3017:	89 44 24 04          	mov    %eax,0x4(%esp)
    301b:	c7 04 24 1a 52 00 00 	movl   $0x521a,(%esp)
    3022:	e8 91 10 00 00       	call   40b8 <open>
  if(fd >= 0){
    3027:	85 c0                	test   %eax,%eax
    3029:	0f 89 ec 00 00 00    	jns    311b <dirfile+0x15b>
  fd = open("dirfile/xx", O_CREATE);
    302f:	b8 00 02 00 00       	mov    $0x200,%eax
    3034:	89 44 24 04          	mov    %eax,0x4(%esp)
    3038:	c7 04 24 1a 52 00 00 	movl   $0x521a,(%esp)
    303f:	e8 74 10 00 00       	call   40b8 <open>
  if(fd >= 0){
    3044:	85 c0                	test   %eax,%eax
    3046:	0f 89 cf 00 00 00    	jns    311b <dirfile+0x15b>
  if(mkdir("dirfile/xx") == 0){
    304c:	c7 04 24 1a 52 00 00 	movl   $0x521a,(%esp)
    3053:	e8 88 10 00 00       	call   40e0 <mkdir>
    3058:	85 c0                	test   %eax,%eax
    305a:	0f 84 bb 01 00 00    	je     321b <dirfile+0x25b>
  if(unlink("dirfile/xx") == 0){
    3060:	c7 04 24 1a 52 00 00 	movl   $0x521a,(%esp)
    3067:	e8 5c 10 00 00       	call   40c8 <unlink>
    306c:	85 c0                	test   %eax,%eax
    306e:	0f 84 87 01 00 00    	je     31fb <dirfile+0x23b>
  if(link("README", "dirfile/xx") == 0){
    3074:	b8 1a 52 00 00       	mov    $0x521a,%eax
    3079:	89 44 24 04          	mov    %eax,0x4(%esp)
    307d:	c7 04 24 7e 52 00 00 	movl   $0x527e,(%esp)
    3084:	e8 4f 10 00 00       	call   40d8 <link>
    3089:	85 c0                	test   %eax,%eax
    308b:	0f 84 4a 01 00 00    	je     31db <dirfile+0x21b>
  if(unlink("dirfile") != 0){
    3091:	c7 04 24 e1 51 00 00 	movl   $0x51e1,(%esp)
    3098:	e8 2b 10 00 00       	call   40c8 <unlink>
    309d:	85 c0                	test   %eax,%eax
    309f:	0f 85 16 01 00 00    	jne    31bb <dirfile+0x1fb>
  fd = open(".", O_RDWR);
    30a5:	b8 02 00 00 00       	mov    $0x2,%eax
    30aa:	89 44 24 04          	mov    %eax,0x4(%esp)
    30ae:	c7 04 24 da 4d 00 00 	movl   $0x4dda,(%esp)
    30b5:	e8 fe 0f 00 00       	call   40b8 <open>
  if(fd >= 0){
    30ba:	85 c0                	test   %eax,%eax
    30bc:	0f 89 d9 00 00 00    	jns    319b <dirfile+0x1db>
  fd = open(".", 0);
    30c2:	31 d2                	xor    %edx,%edx
    30c4:	89 54 24 04          	mov    %edx,0x4(%esp)
    30c8:	c7 04 24 da 4d 00 00 	movl   $0x4dda,(%esp)
    30cf:	e8 e4 0f 00 00       	call   40b8 <open>
  if(write(fd, "x", 1) > 0){
    30d4:	b9 01 00 00 00       	mov    $0x1,%ecx
    30d9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  fd = open(".", 0);
    30dd:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    30df:	b8 bd 4e 00 00       	mov    $0x4ebd,%eax
    30e4:	89 44 24 04          	mov    %eax,0x4(%esp)
    30e8:	89 1c 24             	mov    %ebx,(%esp)
    30eb:	e8 a8 0f 00 00       	call   4098 <write>
    30f0:	85 c0                	test   %eax,%eax
    30f2:	0f 8f 83 00 00 00    	jg     317b <dirfile+0x1bb>
  close(fd);
    30f8:	89 1c 24             	mov    %ebx,(%esp)
    30fb:	e8 a0 0f 00 00       	call   40a0 <close>
  printf(1, "dir vs file OK\n");
    3100:	b8 b1 52 00 00       	mov    $0x52b1,%eax
    3105:	89 44 24 04          	mov    %eax,0x4(%esp)
    3109:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3110:	e8 cb 10 00 00       	call   41e0 <printf>
}
    3115:	83 c4 14             	add    $0x14,%esp
    3118:	5b                   	pop    %ebx
    3119:	5d                   	pop    %ebp
    311a:	c3                   	ret    
    printf(1, "create dirfile/xx succeeded!\n");
    311b:	c7 44 24 04 25 52 00 	movl   $0x5225,0x4(%esp)
    3122:	00 
    3123:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    312a:	e8 b1 10 00 00       	call   41e0 <printf>
    exit(0);
    312f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3136:	e8 3d 0f 00 00       	call   4078 <exit>
    printf(1, "chdir dirfile succeeded!\n");
    313b:	c7 44 24 04 00 52 00 	movl   $0x5200,0x4(%esp)
    3142:	00 
    3143:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    314a:	e8 91 10 00 00       	call   41e0 <printf>
    exit(0);
    314f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3156:	e8 1d 0f 00 00       	call   4078 <exit>
    printf(1, "create dirfile failed\n");
    315b:	c7 44 24 04 e9 51 00 	movl   $0x51e9,0x4(%esp)
    3162:	00 
    3163:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    316a:	e8 71 10 00 00       	call   41e0 <printf>
    exit(0);
    316f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3176:	e8 fd 0e 00 00       	call   4078 <exit>
    printf(1, "write . succeeded!\n");
    317b:	c7 44 24 04 9d 52 00 	movl   $0x529d,0x4(%esp)
    3182:	00 
    3183:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    318a:	e8 51 10 00 00       	call   41e0 <printf>
    exit(0);
    318f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3196:	e8 dd 0e 00 00       	call   4078 <exit>
    printf(1, "open . for writing succeeded!\n");
    319b:	c7 44 24 04 94 5a 00 	movl   $0x5a94,0x4(%esp)
    31a2:	00 
    31a3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    31aa:	e8 31 10 00 00       	call   41e0 <printf>
    exit(0);
    31af:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    31b6:	e8 bd 0e 00 00       	call   4078 <exit>
    printf(1, "unlink dirfile failed!\n");
    31bb:	c7 44 24 04 85 52 00 	movl   $0x5285,0x4(%esp)
    31c2:	00 
    31c3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    31ca:	e8 11 10 00 00       	call   41e0 <printf>
    exit(0);
    31cf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    31d6:	e8 9d 0e 00 00       	call   4078 <exit>
    printf(1, "link to dirfile/xx succeeded!\n");
    31db:	c7 44 24 04 74 5a 00 	movl   $0x5a74,0x4(%esp)
    31e2:	00 
    31e3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    31ea:	e8 f1 0f 00 00       	call   41e0 <printf>
    exit(0);
    31ef:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    31f6:	e8 7d 0e 00 00       	call   4078 <exit>
    printf(1, "unlink dirfile/xx succeeded!\n");
    31fb:	c7 44 24 04 60 52 00 	movl   $0x5260,0x4(%esp)
    3202:	00 
    3203:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    320a:	e8 d1 0f 00 00       	call   41e0 <printf>
    exit(0);
    320f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3216:	e8 5d 0e 00 00       	call   4078 <exit>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    321b:	c7 44 24 04 43 52 00 	movl   $0x5243,0x4(%esp)
    3222:	00 
    3223:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    322a:	e8 b1 0f 00 00       	call   41e0 <printf>
    exit(0);
    322f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3236:	e8 3d 0e 00 00       	call   4078 <exit>
    323b:	90                   	nop
    323c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003240 <iref>:
{
    3240:	55                   	push   %ebp
  printf(1, "empty file name\n");
    3241:	b8 c1 52 00 00       	mov    $0x52c1,%eax
{
    3246:	89 e5                	mov    %esp,%ebp
    3248:	53                   	push   %ebx
  printf(1, "empty file name\n");
    3249:	bb 33 00 00 00       	mov    $0x33,%ebx
{
    324e:	83 ec 14             	sub    $0x14,%esp
  printf(1, "empty file name\n");
    3251:	89 44 24 04          	mov    %eax,0x4(%esp)
    3255:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    325c:	e8 7f 0f 00 00       	call   41e0 <printf>
    3261:	eb 0d                	jmp    3270 <iref+0x30>
    3263:	90                   	nop
    3264:	90                   	nop
    3265:	90                   	nop
    3266:	90                   	nop
    3267:	90                   	nop
    3268:	90                   	nop
    3269:	90                   	nop
    326a:	90                   	nop
    326b:	90                   	nop
    326c:	90                   	nop
    326d:	90                   	nop
    326e:	90                   	nop
    326f:	90                   	nop
    if(mkdir("irefd") != 0){
    3270:	c7 04 24 d2 52 00 00 	movl   $0x52d2,(%esp)
    3277:	e8 64 0e 00 00       	call   40e0 <mkdir>
    327c:	85 c0                	test   %eax,%eax
    327e:	0f 85 b1 00 00 00    	jne    3335 <iref+0xf5>
    if(chdir("irefd") != 0){
    3284:	c7 04 24 d2 52 00 00 	movl   $0x52d2,(%esp)
    328b:	e8 58 0e 00 00       	call   40e8 <chdir>
    3290:	85 c0                	test   %eax,%eax
    3292:	0f 85 be 00 00 00    	jne    3356 <iref+0x116>
    mkdir("");
    3298:	c7 04 24 7b 49 00 00 	movl   $0x497b,(%esp)
    329f:	e8 3c 0e 00 00       	call   40e0 <mkdir>
    link("README", "");
    32a4:	b9 7b 49 00 00       	mov    $0x497b,%ecx
    32a9:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    32ad:	c7 04 24 7e 52 00 00 	movl   $0x527e,(%esp)
    32b4:	e8 1f 0e 00 00       	call   40d8 <link>
    fd = open("", O_CREATE);
    32b9:	b8 00 02 00 00       	mov    $0x200,%eax
    32be:	89 44 24 04          	mov    %eax,0x4(%esp)
    32c2:	c7 04 24 7b 49 00 00 	movl   $0x497b,(%esp)
    32c9:	e8 ea 0d 00 00       	call   40b8 <open>
    if(fd >= 0)
    32ce:	85 c0                	test   %eax,%eax
    32d0:	78 08                	js     32da <iref+0x9a>
      close(fd);
    32d2:	89 04 24             	mov    %eax,(%esp)
    32d5:	e8 c6 0d 00 00       	call   40a0 <close>
    fd = open("xx", O_CREATE);
    32da:	ba 00 02 00 00       	mov    $0x200,%edx
    32df:	89 54 24 04          	mov    %edx,0x4(%esp)
    32e3:	c7 04 24 bc 4e 00 00 	movl   $0x4ebc,(%esp)
    32ea:	e8 c9 0d 00 00       	call   40b8 <open>
    if(fd >= 0)
    32ef:	85 c0                	test   %eax,%eax
    32f1:	78 08                	js     32fb <iref+0xbb>
      close(fd);
    32f3:	89 04 24             	mov    %eax,(%esp)
    32f6:	e8 a5 0d 00 00       	call   40a0 <close>
    unlink("xx");
    32fb:	c7 04 24 bc 4e 00 00 	movl   $0x4ebc,(%esp)
    3302:	e8 c1 0d 00 00       	call   40c8 <unlink>
  for(i = 0; i < 50 + 1; i++){
    3307:	4b                   	dec    %ebx
    3308:	0f 85 62 ff ff ff    	jne    3270 <iref+0x30>
  chdir("/");
    330e:	c7 04 24 a1 45 00 00 	movl   $0x45a1,(%esp)
    3315:	e8 ce 0d 00 00       	call   40e8 <chdir>
  printf(1, "empty file name OK\n");
    331a:	b8 00 53 00 00       	mov    $0x5300,%eax
    331f:	89 44 24 04          	mov    %eax,0x4(%esp)
    3323:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    332a:	e8 b1 0e 00 00       	call   41e0 <printf>
}
    332f:	83 c4 14             	add    $0x14,%esp
    3332:	5b                   	pop    %ebx
    3333:	5d                   	pop    %ebp
    3334:	c3                   	ret    
      printf(1, "mkdir irefd failed\n");
    3335:	b8 d8 52 00 00       	mov    $0x52d8,%eax
    333a:	89 44 24 04          	mov    %eax,0x4(%esp)
    333e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3345:	e8 96 0e 00 00       	call   41e0 <printf>
      exit(0);
    334a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3351:	e8 22 0d 00 00       	call   4078 <exit>
      printf(1, "chdir irefd failed\n");
    3356:	b8 ec 52 00 00       	mov    $0x52ec,%eax
    335b:	89 44 24 04          	mov    %eax,0x4(%esp)
    335f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3366:	e8 75 0e 00 00       	call   41e0 <printf>
      exit(0);
    336b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3372:	e8 01 0d 00 00       	call   4078 <exit>
    3377:	89 f6                	mov    %esi,%esi
    3379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003380 <forktest>:
{
    3380:	55                   	push   %ebp
    3381:	89 e5                	mov    %esp,%ebp
    3383:	53                   	push   %ebx
  printf(1, "fork test\n");
    3384:	bb 14 53 00 00       	mov    $0x5314,%ebx
{
    3389:	83 ec 14             	sub    $0x14,%esp
  printf(1, "fork test\n");
    338c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  for(n=0; n<1000; n++){
    3390:	31 db                	xor    %ebx,%ebx
  printf(1, "fork test\n");
    3392:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3399:	e8 42 0e 00 00       	call   41e0 <printf>
    339e:	eb 12                	jmp    33b2 <forktest+0x32>
    if(pid == 0)
    33a0:	0f 84 a0 00 00 00    	je     3446 <forktest+0xc6>
  for(n=0; n<1000; n++){
    33a6:	43                   	inc    %ebx
    33a7:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    33ad:	8d 76 00             	lea    0x0(%esi),%esi
    33b0:	74 5e                	je     3410 <forktest+0x90>
    pid = fork();
    33b2:	e8 b9 0c 00 00       	call   4070 <fork>
    if(pid < 0)
    33b7:	85 c0                	test   %eax,%eax
    33b9:	79 e5                	jns    33a0 <forktest+0x20>
  for(; n > 0; n--){
    33bb:	85 db                	test   %ebx,%ebx
    33bd:	8d 76 00             	lea    0x0(%esi),%esi
    33c0:	74 21                	je     33e3 <forktest+0x63>
    33c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    33c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(wait(0) < 0){
    33d0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    33d7:	e8 a4 0c 00 00       	call   4080 <wait>
    33dc:	85 c0                	test   %eax,%eax
    33de:	78 51                	js     3431 <forktest+0xb1>
  for(; n > 0; n--){
    33e0:	4b                   	dec    %ebx
    33e1:	75 ed                	jne    33d0 <forktest+0x50>
  if(wait(0) != -1){
    33e3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    33ea:	e8 91 0c 00 00       	call   4080 <wait>
    33ef:	40                   	inc    %eax
    33f0:	75 60                	jne    3452 <forktest+0xd2>
  printf(1, "fork test OK\n");
    33f2:	ba 46 53 00 00       	mov    $0x5346,%edx
    33f7:	89 54 24 04          	mov    %edx,0x4(%esp)
    33fb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3402:	e8 d9 0d 00 00       	call   41e0 <printf>
}
    3407:	83 c4 14             	add    $0x14,%esp
    340a:	5b                   	pop    %ebx
    340b:	5d                   	pop    %ebp
    340c:	c3                   	ret    
    340d:	8d 76 00             	lea    0x0(%esi),%esi
    printf(1, "fork claimed to work 1000 times!\n");
    3410:	b8 b4 5a 00 00       	mov    $0x5ab4,%eax
    3415:	89 44 24 04          	mov    %eax,0x4(%esp)
    3419:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3420:	e8 bb 0d 00 00       	call   41e0 <printf>
    exit(0);
    3425:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    342c:	e8 47 0c 00 00       	call   4078 <exit>
      printf(1, "wait stopped early\n");
    3431:	b9 1f 53 00 00       	mov    $0x531f,%ecx
    3436:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    343a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3441:	e8 9a 0d 00 00       	call   41e0 <printf>
      exit(0);
    3446:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    344d:	e8 26 0c 00 00       	call   4078 <exit>
    printf(1, "wait got too many\n");
    3452:	c7 44 24 04 33 53 00 	movl   $0x5333,0x4(%esp)
    3459:	00 
    345a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3461:	e8 7a 0d 00 00       	call   41e0 <printf>
    exit(0);
    3466:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    346d:	e8 06 0c 00 00       	call   4078 <exit>
    3472:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003480 <sbrktest>:
{
    3480:	55                   	push   %ebp
  printf(stdout, "sbrk test\n");
    3481:	b8 54 53 00 00       	mov    $0x5354,%eax
{
    3486:	89 e5                	mov    %esp,%ebp
    3488:	57                   	push   %edi
  for(i = 0; i < 5000; i++){
    3489:	31 ff                	xor    %edi,%edi
{
    348b:	56                   	push   %esi
    348c:	53                   	push   %ebx
    348d:	83 ec 7c             	sub    $0x7c,%esp
  printf(stdout, "sbrk test\n");
    3490:	89 44 24 04          	mov    %eax,0x4(%esp)
    3494:	a1 0c 66 00 00       	mov    0x660c,%eax
    3499:	89 04 24             	mov    %eax,(%esp)
    349c:	e8 3f 0d 00 00       	call   41e0 <printf>
  oldbrk = sbrk(0);
    34a1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    34a8:	e8 53 0c 00 00       	call   4100 <sbrk>
  a = sbrk(0);
    34ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  oldbrk = sbrk(0);
    34b4:	89 c3                	mov    %eax,%ebx
  a = sbrk(0);
    34b6:	e8 45 0c 00 00       	call   4100 <sbrk>
    34bb:	89 c6                	mov    %eax,%esi
    34bd:	eb 03                	jmp    34c2 <sbrktest+0x42>
    34bf:	90                   	nop
    a = b + 1;
    34c0:	89 c6                	mov    %eax,%esi
    b = sbrk(1);
    34c2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    34c9:	e8 32 0c 00 00       	call   4100 <sbrk>
    if(b != a){
    34ce:	39 f0                	cmp    %esi,%eax
    34d0:	0f 85 6d 02 00 00    	jne    3743 <sbrktest+0x2c3>
  for(i = 0; i < 5000; i++){
    34d6:	47                   	inc    %edi
    34d7:	81 ff 88 13 00 00    	cmp    $0x1388,%edi
    *b = 1;
    34dd:	c6 06 01             	movb   $0x1,(%esi)
    a = b + 1;
    34e0:	8d 46 01             	lea    0x1(%esi),%eax
  for(i = 0; i < 5000; i++){
    34e3:	75 db                	jne    34c0 <sbrktest+0x40>
  pid = fork();
    34e5:	e8 86 0b 00 00       	call   4070 <fork>
  if(pid < 0){
    34ea:	85 c0                	test   %eax,%eax
  pid = fork();
    34ec:	89 c7                	mov    %eax,%edi
  if(pid < 0){
    34ee:	0f 88 94 03 00 00    	js     3888 <sbrktest+0x408>
  c = sbrk(1);
    34f4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  if(c != a + 1){
    34fb:	83 c6 02             	add    $0x2,%esi
  c = sbrk(1);
    34fe:	e8 fd 0b 00 00       	call   4100 <sbrk>
  c = sbrk(1);
    3503:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    350a:	e8 f1 0b 00 00       	call   4100 <sbrk>
  if(c != a + 1){
    350f:	39 f0                	cmp    %esi,%eax
    3511:	0f 85 64 03 00 00    	jne    387b <sbrktest+0x3fb>
  if(pid == 0)
    3517:	85 ff                	test   %edi,%edi
    exit(0);
    3519:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  if(pid == 0)
    3520:	0f 84 9e 02 00 00    	je     37c4 <sbrktest+0x344>
  wait(0);
    3526:	e8 55 0b 00 00       	call   4080 <wait>
  a = sbrk(0);
    352b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3532:	e8 c9 0b 00 00       	call   4100 <sbrk>
    3537:	89 c6                	mov    %eax,%esi
  amt = (BIG) - (uint)a;
    3539:	b8 00 00 40 06       	mov    $0x6400000,%eax
    353e:	29 f0                	sub    %esi,%eax
  p = sbrk(amt);
    3540:	89 04 24             	mov    %eax,(%esp)
    3543:	e8 b8 0b 00 00       	call   4100 <sbrk>
  if (p != a) {
    3548:	39 c6                	cmp    %eax,%esi
    354a:	0f 85 ff 02 00 00    	jne    384f <sbrktest+0x3cf>
  *lastaddr = 99;
    3550:	b0 63                	mov    $0x63,%al
    3552:	a2 ff ff 3f 06       	mov    %al,0x63fffff
  a = sbrk(0);
    3557:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    355e:	e8 9d 0b 00 00       	call   4100 <sbrk>
  c = sbrk(-4096);
    3563:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
  a = sbrk(0);
    356a:	89 c6                	mov    %eax,%esi
  c = sbrk(-4096);
    356c:	e8 8f 0b 00 00       	call   4100 <sbrk>
  if(c == (char*)0xffffffff){
    3571:	40                   	inc    %eax
    3572:	0f 84 f6 02 00 00    	je     386e <sbrktest+0x3ee>
  c = sbrk(0);
    3578:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    357f:	e8 7c 0b 00 00       	call   4100 <sbrk>
  if(c != a - 4096){
    3584:	8d 96 00 f0 ff ff    	lea    -0x1000(%esi),%edx
    358a:	39 d0                	cmp    %edx,%eax
    358c:	0f 85 ca 02 00 00    	jne    385c <sbrktest+0x3dc>
  a = sbrk(0);
    3592:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3599:	e8 62 0b 00 00       	call   4100 <sbrk>
  c = sbrk(4096);
    359e:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  a = sbrk(0);
    35a5:	89 c6                	mov    %eax,%esi
  c = sbrk(4096);
    35a7:	e8 54 0b 00 00       	call   4100 <sbrk>
  if(c != a || sbrk(0) != a + 4096){
    35ac:	39 c6                	cmp    %eax,%esi
  c = sbrk(4096);
    35ae:	89 c7                	mov    %eax,%edi
  if(c != a || sbrk(0) != a + 4096){
    35b0:	0f 85 87 02 00 00    	jne    383d <sbrktest+0x3bd>
    35b6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    35bd:	e8 3e 0b 00 00       	call   4100 <sbrk>
    35c2:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    35c8:	39 d0                	cmp    %edx,%eax
    35ca:	0f 85 6d 02 00 00    	jne    383d <sbrktest+0x3bd>
  if(*lastaddr == 99){
    35d0:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    35d7:	0f 84 53 02 00 00    	je     3830 <sbrktest+0x3b0>
  a = sbrk(0);
    35dd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    35e4:	e8 17 0b 00 00       	call   4100 <sbrk>
  c = sbrk(-(sbrk(0) - oldbrk));
    35e9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  a = sbrk(0);
    35f0:	89 c6                	mov    %eax,%esi
  c = sbrk(-(sbrk(0) - oldbrk));
    35f2:	e8 09 0b 00 00       	call   4100 <sbrk>
    35f7:	89 d9                	mov    %ebx,%ecx
    35f9:	29 c1                	sub    %eax,%ecx
    35fb:	89 0c 24             	mov    %ecx,(%esp)
    35fe:	e8 fd 0a 00 00       	call   4100 <sbrk>
  if(c != a){
    3603:	39 c6                	cmp    %eax,%esi
    3605:	0f 85 fc 01 00 00    	jne    3807 <sbrktest+0x387>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    360b:	be 00 00 00 80       	mov    $0x80000000,%esi
    ppid = getpid();
    3610:	e8 e3 0a 00 00       	call   40f8 <getpid>
    3615:	89 c7                	mov    %eax,%edi
    pid = fork();
    3617:	e8 54 0a 00 00       	call   4070 <fork>
    if(pid < 0){
    361c:	85 c0                	test   %eax,%eax
    361e:	0f 88 d9 01 00 00    	js     37fd <sbrktest+0x37d>
    if(pid == 0){
    3624:	0f 84 9f 01 00 00    	je     37c9 <sbrktest+0x349>
    wait(0);
    362a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    3631:	81 c6 50 c3 00 00    	add    $0xc350,%esi
    wait(0);
    3637:	e8 44 0a 00 00       	call   4080 <wait>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    363c:	81 fe 80 84 1e 80    	cmp    $0x801e8480,%esi
    3642:	75 cc                	jne    3610 <sbrktest+0x190>
  if(pipe(fds) != 0){
    3644:	8d 45 b8             	lea    -0x48(%ebp),%eax
    3647:	89 04 24             	mov    %eax,(%esp)
    364a:	e8 39 0a 00 00       	call   4088 <pipe>
    364f:	85 c0                	test   %eax,%eax
    3651:	0f 85 52 01 00 00    	jne    37a9 <sbrktest+0x329>
    3657:	8d 7d c0             	lea    -0x40(%ebp),%edi
    365a:	89 fe                	mov    %edi,%esi
    365c:	eb 29                	jmp    3687 <sbrktest+0x207>
    if(pids[i] != -1)
    365e:	40                   	inc    %eax
    365f:	90                   	nop
    3660:	74 1b                	je     367d <sbrktest+0x1fd>
      read(fds[0], &scratch, 1);
    3662:	8d 45 b7             	lea    -0x49(%ebp),%eax
    3665:	ba 01 00 00 00       	mov    $0x1,%edx
    366a:	89 44 24 04          	mov    %eax,0x4(%esp)
    366e:	8b 45 b8             	mov    -0x48(%ebp),%eax
    3671:	89 54 24 08          	mov    %edx,0x8(%esp)
    3675:	89 04 24             	mov    %eax,(%esp)
    3678:	e8 13 0a 00 00       	call   4090 <read>
    367d:	83 c6 04             	add    $0x4,%esi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3680:	8d 45 e8             	lea    -0x18(%ebp),%eax
    3683:	39 c6                	cmp    %eax,%esi
    3685:	74 57                	je     36de <sbrktest+0x25e>
    if((pids[i] = fork()) == 0){
    3687:	e8 e4 09 00 00       	call   4070 <fork>
    368c:	85 c0                	test   %eax,%eax
    368e:	89 06                	mov    %eax,(%esi)
    3690:	75 cc                	jne    365e <sbrktest+0x1de>
      sbrk(BIG - (uint)sbrk(0));
    3692:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      write(fds[1], "x", 1);
    3699:	bb bd 4e 00 00       	mov    $0x4ebd,%ebx
      sbrk(BIG - (uint)sbrk(0));
    369e:	e8 5d 0a 00 00       	call   4100 <sbrk>
    36a3:	ba 00 00 40 06       	mov    $0x6400000,%edx
    36a8:	29 c2                	sub    %eax,%edx
    36aa:	89 14 24             	mov    %edx,(%esp)
    36ad:	e8 4e 0a 00 00       	call   4100 <sbrk>
      write(fds[1], "x", 1);
    36b2:	8b 45 bc             	mov    -0x44(%ebp),%eax
    36b5:	b9 01 00 00 00       	mov    $0x1,%ecx
    36ba:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    36be:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    36c2:	89 04 24             	mov    %eax,(%esp)
    36c5:	e8 ce 09 00 00       	call   4098 <write>
    36ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      for(;;) sleep(1000);
    36d0:	c7 04 24 e8 03 00 00 	movl   $0x3e8,(%esp)
    36d7:	e8 2c 0a 00 00       	call   4108 <sleep>
    36dc:	eb f2                	jmp    36d0 <sbrktest+0x250>
  c = sbrk(4096);
    36de:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    36e5:	e8 16 0a 00 00       	call   4100 <sbrk>
    36ea:	89 45 a4             	mov    %eax,-0x5c(%ebp)
    if(pids[i] == -1)
    36ed:	8b 07                	mov    (%edi),%eax
    36ef:	83 f8 ff             	cmp    $0xffffffff,%eax
    36f2:	74 14                	je     3708 <sbrktest+0x288>
    kill(pids[i]);
    36f4:	89 04 24             	mov    %eax,(%esp)
    36f7:	e8 ac 09 00 00       	call   40a8 <kill>
    wait(0);
    36fc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3703:	e8 78 09 00 00       	call   4080 <wait>
    3708:	83 c7 04             	add    $0x4,%edi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    370b:	39 fe                	cmp    %edi,%esi
    370d:	75 de                	jne    36ed <sbrktest+0x26d>
  if(c == (char*)0xffffffff){
    370f:	83 7d a4 ff          	cmpl   $0xffffffff,-0x5c(%ebp)
    3713:	74 73                	je     3788 <sbrktest+0x308>
  if(sbrk(0) > oldbrk)
    3715:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    371c:	e8 df 09 00 00       	call   4100 <sbrk>
    3721:	39 d8                	cmp    %ebx,%eax
    3723:	77 4b                	ja     3770 <sbrktest+0x2f0>
  printf(stdout, "sbrk test OK\n");
    3725:	b8 fc 53 00 00       	mov    $0x53fc,%eax
    372a:	89 44 24 04          	mov    %eax,0x4(%esp)
    372e:	a1 0c 66 00 00       	mov    0x660c,%eax
    3733:	89 04 24             	mov    %eax,(%esp)
    3736:	e8 a5 0a 00 00       	call   41e0 <printf>
}
    373b:	83 c4 7c             	add    $0x7c,%esp
    373e:	5b                   	pop    %ebx
    373f:	5e                   	pop    %esi
    3740:	5f                   	pop    %edi
    3741:	5d                   	pop    %ebp
    3742:	c3                   	ret    
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    3743:	89 44 24 10          	mov    %eax,0x10(%esp)
    3747:	a1 0c 66 00 00       	mov    0x660c,%eax
    374c:	89 74 24 0c          	mov    %esi,0xc(%esp)
    3750:	89 7c 24 08          	mov    %edi,0x8(%esp)
    3754:	c7 44 24 04 5f 53 00 	movl   $0x535f,0x4(%esp)
    375b:	00 
    375c:	89 04 24             	mov    %eax,(%esp)
    375f:	e8 7c 0a 00 00       	call   41e0 <printf>
      exit(0);
    3764:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    376b:	e8 08 09 00 00       	call   4078 <exit>
    sbrk(-(sbrk(0) - oldbrk));
    3770:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3777:	e8 84 09 00 00       	call   4100 <sbrk>
    377c:	29 c3                	sub    %eax,%ebx
    377e:	89 1c 24             	mov    %ebx,(%esp)
    3781:	e8 7a 09 00 00       	call   4100 <sbrk>
    3786:	eb 9d                	jmp    3725 <sbrktest+0x2a5>
    printf(stdout, "failed sbrk leaked memory\n");
    3788:	c7 44 24 04 e1 53 00 	movl   $0x53e1,0x4(%esp)
    378f:	00 
    printf(stdout, "sbrk test failed post-fork\n");
    3790:	a1 0c 66 00 00       	mov    0x660c,%eax
    3795:	89 04 24             	mov    %eax,(%esp)
    3798:	e8 43 0a 00 00       	call   41e0 <printf>
    exit(0);
    379d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    37a4:	e8 cf 08 00 00       	call   4078 <exit>
    printf(1, "pipe() failed\n");
    37a9:	c7 44 24 04 91 48 00 	movl   $0x4891,0x4(%esp)
    37b0:	00 
    37b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    37b8:	e8 23 0a 00 00       	call   41e0 <printf>
    exit(0);
    37bd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    37c4:	e8 af 08 00 00       	call   4078 <exit>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    37c9:	0f be 06             	movsbl (%esi),%eax
    37cc:	89 74 24 08          	mov    %esi,0x8(%esp)
    37d0:	c7 44 24 04 c8 53 00 	movl   $0x53c8,0x4(%esp)
    37d7:	00 
    37d8:	89 44 24 0c          	mov    %eax,0xc(%esp)
    37dc:	a1 0c 66 00 00       	mov    0x660c,%eax
    37e1:	89 04 24             	mov    %eax,(%esp)
    37e4:	e8 f7 09 00 00       	call   41e0 <printf>
      kill(ppid);
    37e9:	89 3c 24             	mov    %edi,(%esp)
    37ec:	e8 b7 08 00 00       	call   40a8 <kill>
      exit(0);
    37f1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    37f8:	e8 7b 08 00 00       	call   4078 <exit>
      printf(stdout, "fork failed\n");
    37fd:	c7 44 24 04 a5 54 00 	movl   $0x54a5,0x4(%esp)
    3804:	00 
    3805:	eb 89                	jmp    3790 <sbrktest+0x310>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    3807:	89 44 24 0c          	mov    %eax,0xc(%esp)
    380b:	89 74 24 08          	mov    %esi,0x8(%esp)
    380f:	c7 44 24 04 a8 5b 00 	movl   $0x5ba8,0x4(%esp)
    3816:	00 
    3817:	a1 0c 66 00 00       	mov    0x660c,%eax
    381c:	89 04 24             	mov    %eax,(%esp)
    381f:	e8 bc 09 00 00       	call   41e0 <printf>
    exit(0);
    3824:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    382b:	e8 48 08 00 00       	call   4078 <exit>
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    3830:	c7 44 24 04 78 5b 00 	movl   $0x5b78,0x4(%esp)
    3837:	00 
    3838:	e9 53 ff ff ff       	jmp    3790 <sbrktest+0x310>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    383d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
    3841:	89 74 24 08          	mov    %esi,0x8(%esp)
    3845:	c7 44 24 04 50 5b 00 	movl   $0x5b50,0x4(%esp)
    384c:	00 
    384d:	eb c8                	jmp    3817 <sbrktest+0x397>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    384f:	c7 44 24 04 d8 5a 00 	movl   $0x5ad8,0x4(%esp)
    3856:	00 
    3857:	e9 34 ff ff ff       	jmp    3790 <sbrktest+0x310>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    385c:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3860:	89 74 24 08          	mov    %esi,0x8(%esp)
    3864:	c7 44 24 04 18 5b 00 	movl   $0x5b18,0x4(%esp)
    386b:	00 
    386c:	eb a9                	jmp    3817 <sbrktest+0x397>
    printf(stdout, "sbrk could not deallocate\n");
    386e:	c7 44 24 04 ad 53 00 	movl   $0x53ad,0x4(%esp)
    3875:	00 
    3876:	e9 15 ff ff ff       	jmp    3790 <sbrktest+0x310>
    printf(stdout, "sbrk test failed post-fork\n");
    387b:	c7 44 24 04 91 53 00 	movl   $0x5391,0x4(%esp)
    3882:	00 
    3883:	e9 08 ff ff ff       	jmp    3790 <sbrktest+0x310>
    printf(stdout, "sbrk test fork failed\n");
    3888:	c7 44 24 04 7a 53 00 	movl   $0x537a,0x4(%esp)
    388f:	00 
    3890:	e9 fb fe ff ff       	jmp    3790 <sbrktest+0x310>
    3895:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000038a0 <validateint>:
{
    38a0:	55                   	push   %ebp
    38a1:	89 e5                	mov    %esp,%ebp
}
    38a3:	5d                   	pop    %ebp
    38a4:	c3                   	ret    
    38a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    38a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000038b0 <validatetest>:
{
    38b0:	55                   	push   %ebp
  printf(stdout, "validate test\n");
    38b1:	b9 0a 54 00 00       	mov    $0x540a,%ecx
{
    38b6:	89 e5                	mov    %esp,%ebp
    38b8:	56                   	push   %esi
    38b9:	53                   	push   %ebx
  for(p = 0; p <= (uint)hi; p += 4096){
    38ba:	31 db                	xor    %ebx,%ebx
{
    38bc:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "validate test\n");
    38bf:	a1 0c 66 00 00       	mov    0x660c,%eax
    38c4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    38c8:	89 04 24             	mov    %eax,(%esp)
    38cb:	e8 10 09 00 00       	call   41e0 <printf>
    if((pid = fork()) == 0){
    38d0:	e8 9b 07 00 00       	call   4070 <fork>
      exit(0);
    38d5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    if((pid = fork()) == 0){
    38dc:	85 c0                	test   %eax,%eax
    38de:	89 c6                	mov    %eax,%esi
    38e0:	0f 84 80 00 00 00    	je     3966 <validatetest+0xb6>
    sleep(0);
    38e6:	e8 1d 08 00 00       	call   4108 <sleep>
    sleep(0);
    38eb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    38f2:	e8 11 08 00 00       	call   4108 <sleep>
    kill(pid);
    38f7:	89 34 24             	mov    %esi,(%esp)
    38fa:	e8 a9 07 00 00       	call   40a8 <kill>
    wait(0);
    38ff:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3906:	e8 75 07 00 00       	call   4080 <wait>
    if(link("nosuchfile", (char*)p) != -1){
    390b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    390f:	c7 04 24 19 54 00 00 	movl   $0x5419,(%esp)
    3916:	e8 bd 07 00 00       	call   40d8 <link>
    391b:	40                   	inc    %eax
    391c:	75 2b                	jne    3949 <validatetest+0x99>
  for(p = 0; p <= (uint)hi; p += 4096){
    391e:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    3924:	81 fb 00 40 11 00    	cmp    $0x114000,%ebx
    392a:	75 a4                	jne    38d0 <validatetest+0x20>
  printf(stdout, "validate ok\n");
    392c:	b8 3d 54 00 00       	mov    $0x543d,%eax
    3931:	89 44 24 04          	mov    %eax,0x4(%esp)
    3935:	a1 0c 66 00 00       	mov    0x660c,%eax
    393a:	89 04 24             	mov    %eax,(%esp)
    393d:	e8 9e 08 00 00       	call   41e0 <printf>
}
    3942:	83 c4 10             	add    $0x10,%esp
    3945:	5b                   	pop    %ebx
    3946:	5e                   	pop    %esi
    3947:	5d                   	pop    %ebp
    3948:	c3                   	ret    
      printf(stdout, "link should not succeed\n");
    3949:	a1 0c 66 00 00       	mov    0x660c,%eax
    394e:	ba 24 54 00 00       	mov    $0x5424,%edx
    3953:	89 54 24 04          	mov    %edx,0x4(%esp)
    3957:	89 04 24             	mov    %eax,(%esp)
    395a:	e8 81 08 00 00       	call   41e0 <printf>
      exit(0);
    395f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3966:	e8 0d 07 00 00       	call   4078 <exit>
    396b:	90                   	nop
    396c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003970 <bsstest>:
{
    3970:	55                   	push   %ebp
  printf(stdout, "bss test\n");
    3971:	b9 4a 54 00 00       	mov    $0x544a,%ecx
{
    3976:	89 e5                	mov    %esp,%ebp
    3978:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "bss test\n");
    397b:	a1 0c 66 00 00       	mov    0x660c,%eax
    3980:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    3984:	89 04 24             	mov    %eax,(%esp)
    3987:	e8 54 08 00 00       	call   41e0 <printf>
    if(uninit[i] != '\0'){
    398c:	80 3d e0 66 00 00 00 	cmpb   $0x0,0x66e0
    3993:	75 34                	jne    39c9 <bsstest+0x59>
  for(i = 0; i < sizeof(uninit); i++){
    3995:	b8 01 00 00 00       	mov    $0x1,%eax
    399a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(uninit[i] != '\0'){
    39a0:	80 b8 e0 66 00 00 00 	cmpb   $0x0,0x66e0(%eax)
    39a7:	75 20                	jne    39c9 <bsstest+0x59>
  for(i = 0; i < sizeof(uninit); i++){
    39a9:	40                   	inc    %eax
    39aa:	3d 10 27 00 00       	cmp    $0x2710,%eax
    39af:	75 ef                	jne    39a0 <bsstest+0x30>
  printf(stdout, "bss test ok\n");
    39b1:	b8 65 54 00 00       	mov    $0x5465,%eax
    39b6:	89 44 24 04          	mov    %eax,0x4(%esp)
    39ba:	a1 0c 66 00 00       	mov    0x660c,%eax
    39bf:	89 04 24             	mov    %eax,(%esp)
    39c2:	e8 19 08 00 00       	call   41e0 <printf>
}
    39c7:	c9                   	leave  
    39c8:	c3                   	ret    
      printf(stdout, "bss test failed\n");
    39c9:	a1 0c 66 00 00       	mov    0x660c,%eax
    39ce:	ba 54 54 00 00       	mov    $0x5454,%edx
    39d3:	89 54 24 04          	mov    %edx,0x4(%esp)
    39d7:	89 04 24             	mov    %eax,(%esp)
    39da:	e8 01 08 00 00       	call   41e0 <printf>
      exit(0);
    39df:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    39e6:	e8 8d 06 00 00       	call   4078 <exit>
    39eb:	90                   	nop
    39ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000039f0 <bigargtest>:
{
    39f0:	55                   	push   %ebp
    39f1:	89 e5                	mov    %esp,%ebp
    39f3:	83 ec 18             	sub    $0x18,%esp
  unlink("bigarg-ok");
    39f6:	c7 04 24 72 54 00 00 	movl   $0x5472,(%esp)
    39fd:	e8 c6 06 00 00       	call   40c8 <unlink>
  pid = fork();
    3a02:	e8 69 06 00 00       	call   4070 <fork>
  if(pid == 0){
    3a07:	85 c0                	test   %eax,%eax
    3a09:	74 47                	je     3a52 <bigargtest+0x62>
    3a0b:	90                   	nop
    3a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  } else if(pid < 0){
    3a10:	0f 88 eb 00 00 00    	js     3b01 <bigargtest+0x111>
  wait(0);
    3a16:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3a1d:	e8 5e 06 00 00       	call   4080 <wait>
  fd = open("bigarg-ok", 0);
    3a22:	31 c0                	xor    %eax,%eax
    3a24:	89 44 24 04          	mov    %eax,0x4(%esp)
    3a28:	c7 04 24 72 54 00 00 	movl   $0x5472,(%esp)
    3a2f:	e8 84 06 00 00       	call   40b8 <open>
  if(fd < 0){
    3a34:	85 c0                	test   %eax,%eax
    3a36:	0f 88 a4 00 00 00    	js     3ae0 <bigargtest+0xf0>
  close(fd);
    3a3c:	89 04 24             	mov    %eax,(%esp)
    3a3f:	e8 5c 06 00 00       	call   40a0 <close>
  unlink("bigarg-ok");
    3a44:	c7 04 24 72 54 00 00 	movl   $0x5472,(%esp)
    3a4b:	e8 78 06 00 00       	call   40c8 <unlink>
}
    3a50:	c9                   	leave  
    3a51:	c3                   	ret    
    3a52:	b8 40 66 00 00       	mov    $0x6640,%eax
    3a57:	89 f6                	mov    %esi,%esi
    3a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    3a60:	c7 00 cc 5b 00 00    	movl   $0x5bcc,(%eax)
    3a66:	83 c0 04             	add    $0x4,%eax
    for(i = 0; i < MAXARG-1; i++)
    3a69:	3d bc 66 00 00       	cmp    $0x66bc,%eax
    3a6e:	75 f0                	jne    3a60 <bigargtest+0x70>
    printf(stdout, "bigarg test\n");
    3a70:	a1 0c 66 00 00       	mov    0x660c,%eax
    3a75:	c7 44 24 04 7c 54 00 	movl   $0x547c,0x4(%esp)
    3a7c:	00 
    args[MAXARG-1] = 0;
    3a7d:	c7 05 bc 66 00 00 00 	movl   $0x0,0x66bc
    3a84:	00 00 00 
    printf(stdout, "bigarg test\n");
    3a87:	89 04 24             	mov    %eax,(%esp)
    3a8a:	e8 51 07 00 00       	call   41e0 <printf>
    exec("echo", args);
    3a8f:	c7 44 24 04 40 66 00 	movl   $0x6640,0x4(%esp)
    3a96:	00 
    3a97:	c7 04 24 3d 46 00 00 	movl   $0x463d,(%esp)
    3a9e:	e8 0d 06 00 00       	call   40b0 <exec>
    printf(stdout, "bigarg test ok\n");
    3aa3:	a1 0c 66 00 00       	mov    0x660c,%eax
    3aa8:	c7 44 24 04 89 54 00 	movl   $0x5489,0x4(%esp)
    3aaf:	00 
    3ab0:	89 04 24             	mov    %eax,(%esp)
    3ab3:	e8 28 07 00 00       	call   41e0 <printf>
    fd = open("bigarg-ok", O_CREATE);
    3ab8:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    3abf:	00 
    3ac0:	c7 04 24 72 54 00 00 	movl   $0x5472,(%esp)
    3ac7:	e8 ec 05 00 00       	call   40b8 <open>
    close(fd);
    3acc:	89 04 24             	mov    %eax,(%esp)
    3acf:	e8 cc 05 00 00       	call   40a0 <close>
    exit(0);
    3ad4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3adb:	e8 98 05 00 00       	call   4078 <exit>
    printf(stdout, "bigarg test failed!\n");
    3ae0:	c7 44 24 04 b2 54 00 	movl   $0x54b2,0x4(%esp)
    3ae7:	00 
    3ae8:	a1 0c 66 00 00       	mov    0x660c,%eax
    3aed:	89 04 24             	mov    %eax,(%esp)
    3af0:	e8 eb 06 00 00       	call   41e0 <printf>
    exit(0);
    3af5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3afc:	e8 77 05 00 00       	call   4078 <exit>
    printf(stdout, "bigargtest: fork failed\n");
    3b01:	c7 44 24 04 99 54 00 	movl   $0x5499,0x4(%esp)
    3b08:	00 
    3b09:	eb dd                	jmp    3ae8 <bigargtest+0xf8>
    3b0b:	90                   	nop
    3b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003b10 <fsfull>:
{
    3b10:	55                   	push   %ebp
  printf(1, "fsfull test\n");
    3b11:	b8 c7 54 00 00       	mov    $0x54c7,%eax
{
    3b16:	89 e5                	mov    %esp,%ebp
    3b18:	57                   	push   %edi
    3b19:	56                   	push   %esi
    3b1a:	53                   	push   %ebx
  for(nfiles = 0; ; nfiles++){
    3b1b:	31 db                	xor    %ebx,%ebx
{
    3b1d:	83 ec 5c             	sub    $0x5c,%esp
  printf(1, "fsfull test\n");
    3b20:	89 44 24 04          	mov    %eax,0x4(%esp)
    3b24:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3b2b:	e8 b0 06 00 00       	call   41e0 <printf>
    name[1] = '0' + nfiles / 1000;
    3b30:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    3b35:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    name[1] = '0' + nfiles / 1000;
    3b3a:	f7 e3                	mul    %ebx
    printf(1, "writing %s\n", name);
    3b3c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    name[0] = 'f';
    3b43:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[5] = '\0';
    3b47:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    name[1] = '0' + nfiles / 1000;
    3b4b:	c1 ea 06             	shr    $0x6,%edx
    3b4e:	88 d0                	mov    %dl,%al
    name[2] = '0' + (nfiles % 1000) / 100;
    3b50:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    name[1] = '0' + nfiles / 1000;
    3b56:	04 30                	add    $0x30,%al
    3b58:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3b5b:	89 d8                	mov    %ebx,%eax
    3b5d:	29 d0                	sub    %edx,%eax
    3b5f:	89 c2                	mov    %eax,%edx
    3b61:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3b66:	f7 e2                	mul    %edx
    name[3] = '0' + (nfiles % 100) / 10;
    3b68:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    3b6d:	c1 ea 05             	shr    $0x5,%edx
    3b70:	80 c2 30             	add    $0x30,%dl
    3b73:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3b76:	f7 e3                	mul    %ebx
    3b78:	c1 ea 05             	shr    $0x5,%edx
    3b7b:	8d 04 92             	lea    (%edx,%edx,4),%eax
    3b7e:	89 da                	mov    %ebx,%edx
    3b80:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3b83:	c1 e0 02             	shl    $0x2,%eax
    3b86:	29 c2                	sub    %eax,%edx
    3b88:	89 d0                	mov    %edx,%eax
    3b8a:	f7 e1                	mul    %ecx
    name[4] = '0' + (nfiles % 10);
    3b8c:	89 d8                	mov    %ebx,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    3b8e:	c1 ea 03             	shr    $0x3,%edx
    3b91:	80 c2 30             	add    $0x30,%dl
    3b94:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    3b97:	f7 e1                	mul    %ecx
    3b99:	89 d9                	mov    %ebx,%ecx
    3b9b:	c1 ea 03             	shr    $0x3,%edx
    3b9e:	8d 04 92             	lea    (%edx,%edx,4),%eax
    3ba1:	01 c0                	add    %eax,%eax
    3ba3:	29 c1                	sub    %eax,%ecx
    3ba5:	89 c8                	mov    %ecx,%eax
    3ba7:	04 30                	add    $0x30,%al
    3ba9:	88 45 ac             	mov    %al,-0x54(%ebp)
    printf(1, "writing %s\n", name);
    3bac:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3baf:	89 44 24 08          	mov    %eax,0x8(%esp)
    3bb3:	b8 d4 54 00 00       	mov    $0x54d4,%eax
    3bb8:	89 44 24 04          	mov    %eax,0x4(%esp)
    3bbc:	e8 1f 06 00 00       	call   41e0 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    3bc1:	b8 02 02 00 00       	mov    $0x202,%eax
    3bc6:	89 44 24 04          	mov    %eax,0x4(%esp)
    3bca:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3bcd:	89 04 24             	mov    %eax,(%esp)
    3bd0:	e8 e3 04 00 00       	call   40b8 <open>
    if(fd < 0){
    3bd5:	85 c0                	test   %eax,%eax
    int fd = open(name, O_CREATE|O_RDWR);
    3bd7:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    3bd9:	78 55                	js     3c30 <fsfull+0x120>
    int total = 0;
    3bdb:	31 f6                	xor    %esi,%esi
    3bdd:	eb 03                	jmp    3be2 <fsfull+0xd2>
    3bdf:	90                   	nop
      total += cc;
    3be0:	01 c6                	add    %eax,%esi
      int cc = write(fd, buf, 512);
    3be2:	b9 00 02 00 00       	mov    $0x200,%ecx
    3be7:	b8 00 8e 00 00       	mov    $0x8e00,%eax
    3bec:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    3bf0:	89 44 24 04          	mov    %eax,0x4(%esp)
    3bf4:	89 3c 24             	mov    %edi,(%esp)
    3bf7:	e8 9c 04 00 00       	call   4098 <write>
      if(cc < 512)
    3bfc:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    3c01:	7f dd                	jg     3be0 <fsfull+0xd0>
    printf(1, "wrote %d bytes\n", total);
    3c03:	ba f0 54 00 00       	mov    $0x54f0,%edx
    3c08:	89 54 24 04          	mov    %edx,0x4(%esp)
    3c0c:	89 74 24 08          	mov    %esi,0x8(%esp)
    3c10:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3c17:	e8 c4 05 00 00       	call   41e0 <printf>
    close(fd);
    3c1c:	89 3c 24             	mov    %edi,(%esp)
    3c1f:	e8 7c 04 00 00       	call   40a0 <close>
    if(total == 0)
    3c24:	85 f6                	test   %esi,%esi
    3c26:	74 24                	je     3c4c <fsfull+0x13c>
  for(nfiles = 0; ; nfiles++){
    3c28:	43                   	inc    %ebx
    3c29:	e9 02 ff ff ff       	jmp    3b30 <fsfull+0x20>
    3c2e:	66 90                	xchg   %ax,%ax
      printf(1, "open %s failed\n", name);
    3c30:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3c33:	89 44 24 08          	mov    %eax,0x8(%esp)
    3c37:	b8 e0 54 00 00       	mov    $0x54e0,%eax
    3c3c:	89 44 24 04          	mov    %eax,0x4(%esp)
    3c40:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3c47:	e8 94 05 00 00       	call   41e0 <printf>
    name[1] = '0' + nfiles / 1000;
    3c4c:	be d3 4d 62 10       	mov    $0x10624dd3,%esi
    name[2] = '0' + (nfiles % 1000) / 100;
    3c51:	bf 1f 85 eb 51       	mov    $0x51eb851f,%edi
    3c56:	8d 76 00             	lea    0x0(%esi),%esi
    3c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    name[1] = '0' + nfiles / 1000;
    3c60:	89 d8                	mov    %ebx,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    3c62:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    name[1] = '0' + nfiles / 1000;
    3c67:	f7 e6                	mul    %esi
    name[0] = 'f';
    3c69:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[5] = '\0';
    3c6d:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    name[1] = '0' + nfiles / 1000;
    3c71:	c1 ea 06             	shr    $0x6,%edx
    3c74:	88 d0                	mov    %dl,%al
    name[2] = '0' + (nfiles % 1000) / 100;
    3c76:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    name[1] = '0' + nfiles / 1000;
    3c7c:	04 30                	add    $0x30,%al
    3c7e:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3c81:	89 d8                	mov    %ebx,%eax
    3c83:	29 d0                	sub    %edx,%eax
    3c85:	f7 e7                	mul    %edi
    name[3] = '0' + (nfiles % 100) / 10;
    3c87:	89 d8                	mov    %ebx,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    3c89:	c1 ea 05             	shr    $0x5,%edx
    3c8c:	80 c2 30             	add    $0x30,%dl
    3c8f:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3c92:	f7 e7                	mul    %edi
    3c94:	c1 ea 05             	shr    $0x5,%edx
    3c97:	8d 04 92             	lea    (%edx,%edx,4),%eax
    3c9a:	89 da                	mov    %ebx,%edx
    3c9c:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3c9f:	c1 e0 02             	shl    $0x2,%eax
    3ca2:	29 c2                	sub    %eax,%edx
    3ca4:	89 d0                	mov    %edx,%eax
    3ca6:	f7 e1                	mul    %ecx
    name[4] = '0' + (nfiles % 10);
    3ca8:	89 d8                	mov    %ebx,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    3caa:	c1 ea 03             	shr    $0x3,%edx
    3cad:	80 c2 30             	add    $0x30,%dl
    3cb0:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    3cb3:	f7 e1                	mul    %ecx
    3cb5:	89 d9                	mov    %ebx,%ecx
    nfiles--;
    3cb7:	4b                   	dec    %ebx
    name[4] = '0' + (nfiles % 10);
    3cb8:	c1 ea 03             	shr    $0x3,%edx
    3cbb:	8d 04 92             	lea    (%edx,%edx,4),%eax
    3cbe:	01 c0                	add    %eax,%eax
    3cc0:	29 c1                	sub    %eax,%ecx
    3cc2:	89 c8                	mov    %ecx,%eax
    3cc4:	04 30                	add    $0x30,%al
    3cc6:	88 45 ac             	mov    %al,-0x54(%ebp)
    unlink(name);
    3cc9:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3ccc:	89 04 24             	mov    %eax,(%esp)
    3ccf:	e8 f4 03 00 00       	call   40c8 <unlink>
  while(nfiles >= 0){
    3cd4:	83 fb ff             	cmp    $0xffffffff,%ebx
    3cd7:	75 87                	jne    3c60 <fsfull+0x150>
  printf(1, "fsfull test finished\n");
    3cd9:	b8 00 55 00 00       	mov    $0x5500,%eax
    3cde:	89 44 24 04          	mov    %eax,0x4(%esp)
    3ce2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3ce9:	e8 f2 04 00 00       	call   41e0 <printf>
}
    3cee:	83 c4 5c             	add    $0x5c,%esp
    3cf1:	5b                   	pop    %ebx
    3cf2:	5e                   	pop    %esi
    3cf3:	5f                   	pop    %edi
    3cf4:	5d                   	pop    %ebp
    3cf5:	c3                   	ret    
    3cf6:	8d 76 00             	lea    0x0(%esi),%esi
    3cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003d00 <uio>:
{
    3d00:	55                   	push   %ebp
  printf(1, "uio test\n");
    3d01:	ba 16 55 00 00       	mov    $0x5516,%edx
{
    3d06:	89 e5                	mov    %esp,%ebp
    3d08:	83 ec 18             	sub    $0x18,%esp
  printf(1, "uio test\n");
    3d0b:	89 54 24 04          	mov    %edx,0x4(%esp)
    3d0f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3d16:	e8 c5 04 00 00       	call   41e0 <printf>
  pid = fork();
    3d1b:	e8 50 03 00 00       	call   4070 <fork>
  if(pid == 0){
    3d20:	85 c0                	test   %eax,%eax
    3d22:	74 25                	je     3d49 <uio+0x49>
  } else if(pid < 0){
    3d24:	78 53                	js     3d79 <uio+0x79>
  wait(0);
    3d26:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3d2d:	e8 4e 03 00 00       	call   4080 <wait>
  printf(1, "uio test done\n");
    3d32:	b8 20 55 00 00       	mov    $0x5520,%eax
    3d37:	89 44 24 04          	mov    %eax,0x4(%esp)
    3d3b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3d42:	e8 99 04 00 00       	call   41e0 <printf>
}
    3d47:	c9                   	leave  
    3d48:	c3                   	ret    
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    3d49:	b0 09                	mov    $0x9,%al
    3d4b:	ba 70 00 00 00       	mov    $0x70,%edx
    3d50:	ee                   	out    %al,(%dx)
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    3d51:	b8 71 00 00 00       	mov    $0x71,%eax
    3d56:	89 c2                	mov    %eax,%edx
    3d58:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
    3d59:	c7 44 24 04 ac 5c 00 	movl   $0x5cac,0x4(%esp)
    3d60:	00 
    3d61:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3d68:	e8 73 04 00 00       	call   41e0 <printf>
    exit(0);
    3d6d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3d74:	e8 ff 02 00 00       	call   4078 <exit>
    printf (1, "fork failed\n");
    3d79:	c7 44 24 04 a5 54 00 	movl   $0x54a5,0x4(%esp)
    3d80:	00 
    3d81:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3d88:	e8 53 04 00 00       	call   41e0 <printf>
    exit(0);
    3d8d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3d94:	e8 df 02 00 00       	call   4078 <exit>
    3d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003da0 <argptest>:
{
    3da0:	55                   	push   %ebp
    3da1:	89 e5                	mov    %esp,%ebp
    3da3:	53                   	push   %ebx
  fd = open("init", O_RDONLY);
    3da4:	31 db                	xor    %ebx,%ebx
{
    3da6:	83 ec 14             	sub    $0x14,%esp
  fd = open("init", O_RDONLY);
    3da9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    3dad:	c7 04 24 2f 55 00 00 	movl   $0x552f,(%esp)
    3db4:	e8 ff 02 00 00       	call   40b8 <open>
  if (fd < 0) {
    3db9:	85 c0                	test   %eax,%eax
    3dbb:	78 47                	js     3e04 <argptest+0x64>
  read(fd, sbrk(0) - 1, -1);
    3dbd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3dc4:	89 c3                	mov    %eax,%ebx
    3dc6:	e8 35 03 00 00       	call   4100 <sbrk>
    3dcb:	ba ff ff ff ff       	mov    $0xffffffff,%edx
    3dd0:	89 54 24 08          	mov    %edx,0x8(%esp)
    3dd4:	89 1c 24             	mov    %ebx,(%esp)
    3dd7:	48                   	dec    %eax
    3dd8:	89 44 24 04          	mov    %eax,0x4(%esp)
    3ddc:	e8 af 02 00 00       	call   4090 <read>
  close(fd);
    3de1:	89 1c 24             	mov    %ebx,(%esp)
    3de4:	e8 b7 02 00 00       	call   40a0 <close>
  printf(1, "arg test passed\n");
    3de9:	b9 41 55 00 00       	mov    $0x5541,%ecx
    3dee:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    3df2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3df9:	e8 e2 03 00 00       	call   41e0 <printf>
}
    3dfe:	83 c4 14             	add    $0x14,%esp
    3e01:	5b                   	pop    %ebx
    3e02:	5d                   	pop    %ebp
    3e03:	c3                   	ret    
    printf(2, "open failed\n");
    3e04:	c7 44 24 04 34 55 00 	movl   $0x5534,0x4(%esp)
    3e0b:	00 
    3e0c:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    3e13:	e8 c8 03 00 00       	call   41e0 <printf>
    exit(0);
    3e18:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3e1f:	e8 54 02 00 00       	call   4078 <exit>
    3e24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3e2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00003e30 <rand>:
  randstate = randstate * 1664525 + 1013904223;
    3e30:	69 05 08 66 00 00 0d 	imul   $0x19660d,0x6608,%eax
    3e37:	66 19 00 
{
    3e3a:	55                   	push   %ebp
    3e3b:	89 e5                	mov    %esp,%ebp
}
    3e3d:	5d                   	pop    %ebp
  randstate = randstate * 1664525 + 1013904223;
    3e3e:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    3e43:	a3 08 66 00 00       	mov    %eax,0x6608
}
    3e48:	c3                   	ret    
    3e49:	66 90                	xchg   %ax,%ax
    3e4b:	66 90                	xchg   %ax,%ax
    3e4d:	66 90                	xchg   %ax,%ax
    3e4f:	90                   	nop

00003e50 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    3e50:	55                   	push   %ebp
    3e51:	89 e5                	mov    %esp,%ebp
    3e53:	8b 45 08             	mov    0x8(%ebp),%eax
    3e56:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    3e59:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3e5a:	89 c2                	mov    %eax,%edx
    3e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3e60:	41                   	inc    %ecx
    3e61:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    3e65:	42                   	inc    %edx
    3e66:	84 db                	test   %bl,%bl
    3e68:	88 5a ff             	mov    %bl,-0x1(%edx)
    3e6b:	75 f3                	jne    3e60 <strcpy+0x10>
    ;
  return os;
}
    3e6d:	5b                   	pop    %ebx
    3e6e:	5d                   	pop    %ebp
    3e6f:	c3                   	ret    

00003e70 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3e70:	55                   	push   %ebp
    3e71:	89 e5                	mov    %esp,%ebp
    3e73:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3e76:	53                   	push   %ebx
    3e77:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
    3e7a:	0f b6 01             	movzbl (%ecx),%eax
    3e7d:	0f b6 13             	movzbl (%ebx),%edx
    3e80:	84 c0                	test   %al,%al
    3e82:	75 18                	jne    3e9c <strcmp+0x2c>
    3e84:	eb 22                	jmp    3ea8 <strcmp+0x38>
    3e86:	8d 76 00             	lea    0x0(%esi),%esi
    3e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    3e90:	41                   	inc    %ecx
  while(*p && *p == *q)
    3e91:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
    3e94:	43                   	inc    %ebx
    3e95:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
    3e98:	84 c0                	test   %al,%al
    3e9a:	74 0c                	je     3ea8 <strcmp+0x38>
    3e9c:	38 d0                	cmp    %dl,%al
    3e9e:	74 f0                	je     3e90 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
    3ea0:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
    3ea1:	29 d0                	sub    %edx,%eax
}
    3ea3:	5d                   	pop    %ebp
    3ea4:	c3                   	ret    
    3ea5:	8d 76 00             	lea    0x0(%esi),%esi
    3ea8:	5b                   	pop    %ebx
    3ea9:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    3eab:	29 d0                	sub    %edx,%eax
}
    3ead:	5d                   	pop    %ebp
    3eae:	c3                   	ret    
    3eaf:	90                   	nop

00003eb0 <strlen>:

uint
strlen(const char *s)
{
    3eb0:	55                   	push   %ebp
    3eb1:	89 e5                	mov    %esp,%ebp
    3eb3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    3eb6:	80 39 00             	cmpb   $0x0,(%ecx)
    3eb9:	74 15                	je     3ed0 <strlen+0x20>
    3ebb:	31 d2                	xor    %edx,%edx
    3ebd:	8d 76 00             	lea    0x0(%esi),%esi
    3ec0:	42                   	inc    %edx
    3ec1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    3ec5:	89 d0                	mov    %edx,%eax
    3ec7:	75 f7                	jne    3ec0 <strlen+0x10>
    ;
  return n;
}
    3ec9:	5d                   	pop    %ebp
    3eca:	c3                   	ret    
    3ecb:	90                   	nop
    3ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
    3ed0:	31 c0                	xor    %eax,%eax
}
    3ed2:	5d                   	pop    %ebp
    3ed3:	c3                   	ret    
    3ed4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3eda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00003ee0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3ee0:	55                   	push   %ebp
    3ee1:	89 e5                	mov    %esp,%ebp
    3ee3:	8b 55 08             	mov    0x8(%ebp),%edx
    3ee6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3ee7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    3eea:	8b 45 0c             	mov    0xc(%ebp),%eax
    3eed:	89 d7                	mov    %edx,%edi
    3eef:	fc                   	cld    
    3ef0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3ef2:	5f                   	pop    %edi
    3ef3:	89 d0                	mov    %edx,%eax
    3ef5:	5d                   	pop    %ebp
    3ef6:	c3                   	ret    
    3ef7:	89 f6                	mov    %esi,%esi
    3ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003f00 <strchr>:

char*
strchr(const char *s, char c)
{
    3f00:	55                   	push   %ebp
    3f01:	89 e5                	mov    %esp,%ebp
    3f03:	8b 45 08             	mov    0x8(%ebp),%eax
    3f06:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    3f0a:	0f b6 10             	movzbl (%eax),%edx
    3f0d:	84 d2                	test   %dl,%dl
    3f0f:	74 1b                	je     3f2c <strchr+0x2c>
    if(*s == c)
    3f11:	38 d1                	cmp    %dl,%cl
    3f13:	75 0f                	jne    3f24 <strchr+0x24>
    3f15:	eb 17                	jmp    3f2e <strchr+0x2e>
    3f17:	89 f6                	mov    %esi,%esi
    3f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    3f20:	38 ca                	cmp    %cl,%dl
    3f22:	74 0a                	je     3f2e <strchr+0x2e>
  for(; *s; s++)
    3f24:	40                   	inc    %eax
    3f25:	0f b6 10             	movzbl (%eax),%edx
    3f28:	84 d2                	test   %dl,%dl
    3f2a:	75 f4                	jne    3f20 <strchr+0x20>
      return (char*)s;
  return 0;
    3f2c:	31 c0                	xor    %eax,%eax
}
    3f2e:	5d                   	pop    %ebp
    3f2f:	c3                   	ret    

00003f30 <gets>:

char*
gets(char *buf, int max)
{
    3f30:	55                   	push   %ebp
    3f31:	89 e5                	mov    %esp,%ebp
    3f33:	57                   	push   %edi
    3f34:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3f35:	31 f6                	xor    %esi,%esi
{
    3f37:	53                   	push   %ebx
    3f38:	83 ec 3c             	sub    $0x3c,%esp
    3f3b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
    3f3e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
    3f41:	eb 32                	jmp    3f75 <gets+0x45>
    3f43:	90                   	nop
    3f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
    3f48:	ba 01 00 00 00       	mov    $0x1,%edx
    3f4d:	89 54 24 08          	mov    %edx,0x8(%esp)
    3f51:	89 7c 24 04          	mov    %edi,0x4(%esp)
    3f55:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3f5c:	e8 2f 01 00 00       	call   4090 <read>
    if(cc < 1)
    3f61:	85 c0                	test   %eax,%eax
    3f63:	7e 19                	jle    3f7e <gets+0x4e>
      break;
    buf[i++] = c;
    3f65:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    3f69:	43                   	inc    %ebx
    3f6a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
    3f6d:	3c 0a                	cmp    $0xa,%al
    3f6f:	74 1f                	je     3f90 <gets+0x60>
    3f71:	3c 0d                	cmp    $0xd,%al
    3f73:	74 1b                	je     3f90 <gets+0x60>
  for(i=0; i+1 < max; ){
    3f75:	46                   	inc    %esi
    3f76:	3b 75 0c             	cmp    0xc(%ebp),%esi
    3f79:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    3f7c:	7c ca                	jl     3f48 <gets+0x18>
      break;
  }
  buf[i] = '\0';
    3f7e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3f81:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
    3f84:	8b 45 08             	mov    0x8(%ebp),%eax
    3f87:	83 c4 3c             	add    $0x3c,%esp
    3f8a:	5b                   	pop    %ebx
    3f8b:	5e                   	pop    %esi
    3f8c:	5f                   	pop    %edi
    3f8d:	5d                   	pop    %ebp
    3f8e:	c3                   	ret    
    3f8f:	90                   	nop
    3f90:	8b 45 08             	mov    0x8(%ebp),%eax
    3f93:	01 c6                	add    %eax,%esi
    3f95:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    3f98:	eb e4                	jmp    3f7e <gets+0x4e>
    3f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00003fa0 <stat>:

int
stat(const char *n, struct stat *st)
{
    3fa0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3fa1:	31 c0                	xor    %eax,%eax
{
    3fa3:	89 e5                	mov    %esp,%ebp
    3fa5:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
    3fa8:	89 44 24 04          	mov    %eax,0x4(%esp)
    3fac:	8b 45 08             	mov    0x8(%ebp),%eax
{
    3faf:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    3fb2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
    3fb5:	89 04 24             	mov    %eax,(%esp)
    3fb8:	e8 fb 00 00 00       	call   40b8 <open>
  if(fd < 0)
    3fbd:	85 c0                	test   %eax,%eax
    3fbf:	78 2f                	js     3ff0 <stat+0x50>
    3fc1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    3fc3:	8b 45 0c             	mov    0xc(%ebp),%eax
    3fc6:	89 1c 24             	mov    %ebx,(%esp)
    3fc9:	89 44 24 04          	mov    %eax,0x4(%esp)
    3fcd:	e8 fe 00 00 00       	call   40d0 <fstat>
  close(fd);
    3fd2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    3fd5:	89 c6                	mov    %eax,%esi
  close(fd);
    3fd7:	e8 c4 00 00 00       	call   40a0 <close>
  return r;
}
    3fdc:	89 f0                	mov    %esi,%eax
    3fde:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    3fe1:	8b 75 fc             	mov    -0x4(%ebp),%esi
    3fe4:	89 ec                	mov    %ebp,%esp
    3fe6:	5d                   	pop    %ebp
    3fe7:	c3                   	ret    
    3fe8:	90                   	nop
    3fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
    3ff0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    3ff5:	eb e5                	jmp    3fdc <stat+0x3c>
    3ff7:	89 f6                	mov    %esi,%esi
    3ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00004000 <atoi>:

int
atoi(const char *s)
{
    4000:	55                   	push   %ebp
    4001:	89 e5                	mov    %esp,%ebp
    4003:	8b 4d 08             	mov    0x8(%ebp),%ecx
    4006:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    4007:	0f be 11             	movsbl (%ecx),%edx
    400a:	88 d0                	mov    %dl,%al
    400c:	2c 30                	sub    $0x30,%al
    400e:	3c 09                	cmp    $0x9,%al
  n = 0;
    4010:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    4015:	77 1e                	ja     4035 <atoi+0x35>
    4017:	89 f6                	mov    %esi,%esi
    4019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    4020:	41                   	inc    %ecx
    4021:	8d 04 80             	lea    (%eax,%eax,4),%eax
    4024:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    4028:	0f be 11             	movsbl (%ecx),%edx
    402b:	88 d3                	mov    %dl,%bl
    402d:	80 eb 30             	sub    $0x30,%bl
    4030:	80 fb 09             	cmp    $0x9,%bl
    4033:	76 eb                	jbe    4020 <atoi+0x20>
  return n;
}
    4035:	5b                   	pop    %ebx
    4036:	5d                   	pop    %ebp
    4037:	c3                   	ret    
    4038:	90                   	nop
    4039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00004040 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    4040:	55                   	push   %ebp
    4041:	89 e5                	mov    %esp,%ebp
    4043:	56                   	push   %esi
    4044:	8b 45 08             	mov    0x8(%ebp),%eax
    4047:	53                   	push   %ebx
    4048:	8b 5d 10             	mov    0x10(%ebp),%ebx
    404b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    404e:	85 db                	test   %ebx,%ebx
    4050:	7e 1a                	jle    406c <memmove+0x2c>
    4052:	31 d2                	xor    %edx,%edx
    4054:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    405a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
    4060:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    4064:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    4067:	42                   	inc    %edx
  while(n-- > 0)
    4068:	39 d3                	cmp    %edx,%ebx
    406a:	75 f4                	jne    4060 <memmove+0x20>
  return vdst;
}
    406c:	5b                   	pop    %ebx
    406d:	5e                   	pop    %esi
    406e:	5d                   	pop    %ebp
    406f:	c3                   	ret    

00004070 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    4070:	b8 01 00 00 00       	mov    $0x1,%eax
    4075:	cd 40                	int    $0x40
    4077:	c3                   	ret    

00004078 <exit>:
SYSCALL(exit)
    4078:	b8 02 00 00 00       	mov    $0x2,%eax
    407d:	cd 40                	int    $0x40
    407f:	c3                   	ret    

00004080 <wait>:
SYSCALL(wait)
    4080:	b8 03 00 00 00       	mov    $0x3,%eax
    4085:	cd 40                	int    $0x40
    4087:	c3                   	ret    

00004088 <pipe>:
SYSCALL(pipe)
    4088:	b8 04 00 00 00       	mov    $0x4,%eax
    408d:	cd 40                	int    $0x40
    408f:	c3                   	ret    

00004090 <read>:
SYSCALL(read)
    4090:	b8 05 00 00 00       	mov    $0x5,%eax
    4095:	cd 40                	int    $0x40
    4097:	c3                   	ret    

00004098 <write>:
SYSCALL(write)
    4098:	b8 10 00 00 00       	mov    $0x10,%eax
    409d:	cd 40                	int    $0x40
    409f:	c3                   	ret    

000040a0 <close>:
SYSCALL(close)
    40a0:	b8 15 00 00 00       	mov    $0x15,%eax
    40a5:	cd 40                	int    $0x40
    40a7:	c3                   	ret    

000040a8 <kill>:
SYSCALL(kill)
    40a8:	b8 06 00 00 00       	mov    $0x6,%eax
    40ad:	cd 40                	int    $0x40
    40af:	c3                   	ret    

000040b0 <exec>:
SYSCALL(exec)
    40b0:	b8 07 00 00 00       	mov    $0x7,%eax
    40b5:	cd 40                	int    $0x40
    40b7:	c3                   	ret    

000040b8 <open>:
SYSCALL(open)
    40b8:	b8 0f 00 00 00       	mov    $0xf,%eax
    40bd:	cd 40                	int    $0x40
    40bf:	c3                   	ret    

000040c0 <mknod>:
SYSCALL(mknod)
    40c0:	b8 11 00 00 00       	mov    $0x11,%eax
    40c5:	cd 40                	int    $0x40
    40c7:	c3                   	ret    

000040c8 <unlink>:
SYSCALL(unlink)
    40c8:	b8 12 00 00 00       	mov    $0x12,%eax
    40cd:	cd 40                	int    $0x40
    40cf:	c3                   	ret    

000040d0 <fstat>:
SYSCALL(fstat)
    40d0:	b8 08 00 00 00       	mov    $0x8,%eax
    40d5:	cd 40                	int    $0x40
    40d7:	c3                   	ret    

000040d8 <link>:
SYSCALL(link)
    40d8:	b8 13 00 00 00       	mov    $0x13,%eax
    40dd:	cd 40                	int    $0x40
    40df:	c3                   	ret    

000040e0 <mkdir>:
SYSCALL(mkdir)
    40e0:	b8 14 00 00 00       	mov    $0x14,%eax
    40e5:	cd 40                	int    $0x40
    40e7:	c3                   	ret    

000040e8 <chdir>:
SYSCALL(chdir)
    40e8:	b8 09 00 00 00       	mov    $0x9,%eax
    40ed:	cd 40                	int    $0x40
    40ef:	c3                   	ret    

000040f0 <dup>:
SYSCALL(dup)
    40f0:	b8 0a 00 00 00       	mov    $0xa,%eax
    40f5:	cd 40                	int    $0x40
    40f7:	c3                   	ret    

000040f8 <getpid>:
SYSCALL(getpid)
    40f8:	b8 0b 00 00 00       	mov    $0xb,%eax
    40fd:	cd 40                	int    $0x40
    40ff:	c3                   	ret    

00004100 <sbrk>:
SYSCALL(sbrk)
    4100:	b8 0c 00 00 00       	mov    $0xc,%eax
    4105:	cd 40                	int    $0x40
    4107:	c3                   	ret    

00004108 <sleep>:
SYSCALL(sleep)
    4108:	b8 0d 00 00 00       	mov    $0xd,%eax
    410d:	cd 40                	int    $0x40
    410f:	c3                   	ret    

00004110 <uptime>:
SYSCALL(uptime)
    4110:	b8 0e 00 00 00       	mov    $0xe,%eax
    4115:	cd 40                	int    $0x40
    4117:	c3                   	ret    

00004118 <detach>:
SYSCALL(detach)
    4118:	b8 16 00 00 00       	mov    $0x16,%eax
    411d:	cd 40                	int    $0x40
    411f:	c3                   	ret    

00004120 <priority>:
SYSCALL(priority)
    4120:	b8 17 00 00 00       	mov    $0x17,%eax
    4125:	cd 40                	int    $0x40
    4127:	c3                   	ret    

00004128 <policy>:
SYSCALL(policy)
    4128:	b8 18 00 00 00       	mov    $0x18,%eax
    412d:	cd 40                	int    $0x40
    412f:	c3                   	ret    

00004130 <wait_stat>:
SYSCALL(wait_stat)
    4130:	b8 19 00 00 00       	mov    $0x19,%eax
    4135:	cd 40                	int    $0x40
    4137:	c3                   	ret    
    4138:	66 90                	xchg   %ax,%ax
    413a:	66 90                	xchg   %ax,%ax
    413c:	66 90                	xchg   %ax,%ax
    413e:	66 90                	xchg   %ax,%ax

00004140 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    4140:	55                   	push   %ebp
    4141:	89 e5                	mov    %esp,%ebp
    4143:	57                   	push   %edi
    4144:	56                   	push   %esi
    4145:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    4146:	89 d3                	mov    %edx,%ebx
    4148:	c1 eb 1f             	shr    $0x1f,%ebx
{
    414b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
    414e:	84 db                	test   %bl,%bl
{
    4150:	89 45 c0             	mov    %eax,-0x40(%ebp)
    4153:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    4155:	74 79                	je     41d0 <printint+0x90>
    4157:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    415b:	74 73                	je     41d0 <printint+0x90>
    neg = 1;
    x = -xx;
    415d:	f7 d8                	neg    %eax
    neg = 1;
    415f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    4166:	31 f6                	xor    %esi,%esi
    4168:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    416b:	eb 05                	jmp    4172 <printint+0x32>
    416d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    4170:	89 fe                	mov    %edi,%esi
    4172:	31 d2                	xor    %edx,%edx
    4174:	f7 f1                	div    %ecx
    4176:	8d 7e 01             	lea    0x1(%esi),%edi
    4179:	0f b6 92 04 5d 00 00 	movzbl 0x5d04(%edx),%edx
  }while((x /= base) != 0);
    4180:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    4182:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    4185:	75 e9                	jne    4170 <printint+0x30>
  if(neg)
    4187:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    418a:	85 d2                	test   %edx,%edx
    418c:	74 08                	je     4196 <printint+0x56>
    buf[i++] = '-';
    418e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    4193:	8d 7e 02             	lea    0x2(%esi),%edi
    4196:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    419a:	8b 7d c0             	mov    -0x40(%ebp),%edi
    419d:	8d 76 00             	lea    0x0(%esi),%esi
    41a0:	0f b6 06             	movzbl (%esi),%eax
    41a3:	4e                   	dec    %esi
  write(fd, &c, 1);
    41a4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    41a8:	89 3c 24             	mov    %edi,(%esp)
    41ab:	88 45 d7             	mov    %al,-0x29(%ebp)
    41ae:	b8 01 00 00 00       	mov    $0x1,%eax
    41b3:	89 44 24 08          	mov    %eax,0x8(%esp)
    41b7:	e8 dc fe ff ff       	call   4098 <write>

  while(--i >= 0)
    41bc:	39 de                	cmp    %ebx,%esi
    41be:	75 e0                	jne    41a0 <printint+0x60>
    putc(fd, buf[i]);
}
    41c0:	83 c4 4c             	add    $0x4c,%esp
    41c3:	5b                   	pop    %ebx
    41c4:	5e                   	pop    %esi
    41c5:	5f                   	pop    %edi
    41c6:	5d                   	pop    %ebp
    41c7:	c3                   	ret    
    41c8:	90                   	nop
    41c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    41d0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    41d7:	eb 8d                	jmp    4166 <printint+0x26>
    41d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000041e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    41e0:	55                   	push   %ebp
    41e1:	89 e5                	mov    %esp,%ebp
    41e3:	57                   	push   %edi
    41e4:	56                   	push   %esi
    41e5:	53                   	push   %ebx
    41e6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    41e9:	8b 75 0c             	mov    0xc(%ebp),%esi
    41ec:	0f b6 1e             	movzbl (%esi),%ebx
    41ef:	84 db                	test   %bl,%bl
    41f1:	0f 84 d1 00 00 00    	je     42c8 <printf+0xe8>
  state = 0;
    41f7:	31 ff                	xor    %edi,%edi
    41f9:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
    41fa:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
    41fd:	89 fa                	mov    %edi,%edx
    41ff:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
    4202:	89 45 d0             	mov    %eax,-0x30(%ebp)
    4205:	eb 41                	jmp    4248 <printf+0x68>
    4207:	89 f6                	mov    %esi,%esi
    4209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    4210:	83 f8 25             	cmp    $0x25,%eax
    4213:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
    4216:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    421b:	74 1e                	je     423b <printf+0x5b>
  write(fd, &c, 1);
    421d:	b8 01 00 00 00       	mov    $0x1,%eax
    4222:	89 44 24 08          	mov    %eax,0x8(%esp)
    4226:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    4229:	89 44 24 04          	mov    %eax,0x4(%esp)
    422d:	89 3c 24             	mov    %edi,(%esp)
    4230:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    4233:	e8 60 fe ff ff       	call   4098 <write>
    4238:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    423b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
    423c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    4240:	84 db                	test   %bl,%bl
    4242:	0f 84 80 00 00 00    	je     42c8 <printf+0xe8>
    if(state == 0){
    4248:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
    424a:	0f be cb             	movsbl %bl,%ecx
    424d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    4250:	74 be                	je     4210 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    4252:	83 fa 25             	cmp    $0x25,%edx
    4255:	75 e4                	jne    423b <printf+0x5b>
      if(c == 'd'){
    4257:	83 f8 64             	cmp    $0x64,%eax
    425a:	0f 84 f0 00 00 00    	je     4350 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    4260:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    4266:	83 f9 70             	cmp    $0x70,%ecx
    4269:	74 65                	je     42d0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    426b:	83 f8 73             	cmp    $0x73,%eax
    426e:	0f 84 8c 00 00 00    	je     4300 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    4274:	83 f8 63             	cmp    $0x63,%eax
    4277:	0f 84 13 01 00 00    	je     4390 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    427d:	83 f8 25             	cmp    $0x25,%eax
    4280:	0f 84 e2 00 00 00    	je     4368 <printf+0x188>
  write(fd, &c, 1);
    4286:	b8 01 00 00 00       	mov    $0x1,%eax
    428b:	46                   	inc    %esi
    428c:	89 44 24 08          	mov    %eax,0x8(%esp)
    4290:	8d 45 e7             	lea    -0x19(%ebp),%eax
    4293:	89 44 24 04          	mov    %eax,0x4(%esp)
    4297:	89 3c 24             	mov    %edi,(%esp)
    429a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    429e:	e8 f5 fd ff ff       	call   4098 <write>
    42a3:	ba 01 00 00 00       	mov    $0x1,%edx
    42a8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    42ab:	89 54 24 08          	mov    %edx,0x8(%esp)
    42af:	89 44 24 04          	mov    %eax,0x4(%esp)
    42b3:	89 3c 24             	mov    %edi,(%esp)
    42b6:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    42b9:	e8 da fd ff ff       	call   4098 <write>
  for(i = 0; fmt[i]; i++){
    42be:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    42c2:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    42c4:	84 db                	test   %bl,%bl
    42c6:	75 80                	jne    4248 <printf+0x68>
    }
  }
}
    42c8:	83 c4 3c             	add    $0x3c,%esp
    42cb:	5b                   	pop    %ebx
    42cc:	5e                   	pop    %esi
    42cd:	5f                   	pop    %edi
    42ce:	5d                   	pop    %ebp
    42cf:	c3                   	ret    
        printint(fd, *ap, 16, 0);
    42d0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    42d7:	b9 10 00 00 00       	mov    $0x10,%ecx
    42dc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    42df:	89 f8                	mov    %edi,%eax
    42e1:	8b 13                	mov    (%ebx),%edx
    42e3:	e8 58 fe ff ff       	call   4140 <printint>
        ap++;
    42e8:	89 d8                	mov    %ebx,%eax
      state = 0;
    42ea:	31 d2                	xor    %edx,%edx
        ap++;
    42ec:	83 c0 04             	add    $0x4,%eax
    42ef:	89 45 d0             	mov    %eax,-0x30(%ebp)
    42f2:	e9 44 ff ff ff       	jmp    423b <printf+0x5b>
    42f7:	89 f6                	mov    %esi,%esi
    42f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
    4300:	8b 45 d0             	mov    -0x30(%ebp),%eax
    4303:	8b 10                	mov    (%eax),%edx
        ap++;
    4305:	83 c0 04             	add    $0x4,%eax
    4308:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    430b:	85 d2                	test   %edx,%edx
    430d:	0f 84 aa 00 00 00    	je     43bd <printf+0x1dd>
        while(*s != 0){
    4313:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
    4316:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
    4318:	84 c0                	test   %al,%al
    431a:	74 27                	je     4343 <printf+0x163>
    431c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    4320:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    4323:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
    4328:	43                   	inc    %ebx
  write(fd, &c, 1);
    4329:	89 44 24 08          	mov    %eax,0x8(%esp)
    432d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    4330:	89 44 24 04          	mov    %eax,0x4(%esp)
    4334:	89 3c 24             	mov    %edi,(%esp)
    4337:	e8 5c fd ff ff       	call   4098 <write>
        while(*s != 0){
    433c:	0f b6 03             	movzbl (%ebx),%eax
    433f:	84 c0                	test   %al,%al
    4341:	75 dd                	jne    4320 <printf+0x140>
      state = 0;
    4343:	31 d2                	xor    %edx,%edx
    4345:	e9 f1 fe ff ff       	jmp    423b <printf+0x5b>
    434a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    4350:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    4357:	b9 0a 00 00 00       	mov    $0xa,%ecx
    435c:	e9 7b ff ff ff       	jmp    42dc <printf+0xfc>
    4361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
    4368:	b9 01 00 00 00       	mov    $0x1,%ecx
    436d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    4370:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    4374:	89 44 24 04          	mov    %eax,0x4(%esp)
    4378:	89 3c 24             	mov    %edi,(%esp)
    437b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    437e:	e8 15 fd ff ff       	call   4098 <write>
      state = 0;
    4383:	31 d2                	xor    %edx,%edx
    4385:	e9 b1 fe ff ff       	jmp    423b <printf+0x5b>
    438a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
    4390:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    4393:	8b 03                	mov    (%ebx),%eax
        ap++;
    4395:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    4398:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
    439b:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    439e:	b8 01 00 00 00       	mov    $0x1,%eax
    43a3:	89 44 24 08          	mov    %eax,0x8(%esp)
    43a7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    43aa:	89 44 24 04          	mov    %eax,0x4(%esp)
    43ae:	e8 e5 fc ff ff       	call   4098 <write>
      state = 0;
    43b3:	31 d2                	xor    %edx,%edx
        ap++;
    43b5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    43b8:	e9 7e fe ff ff       	jmp    423b <printf+0x5b>
          s = "(null)";
    43bd:	bb fc 5c 00 00       	mov    $0x5cfc,%ebx
        while(*s != 0){
    43c2:	b0 28                	mov    $0x28,%al
    43c4:	e9 57 ff ff ff       	jmp    4320 <printf+0x140>
    43c9:	66 90                	xchg   %ax,%ax
    43cb:	66 90                	xchg   %ax,%ax
    43cd:	66 90                	xchg   %ax,%ax
    43cf:	90                   	nop

000043d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    43d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    43d1:	a1 c0 66 00 00       	mov    0x66c0,%eax
{
    43d6:	89 e5                	mov    %esp,%ebp
    43d8:	57                   	push   %edi
    43d9:	56                   	push   %esi
    43da:	53                   	push   %ebx
    43db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    43de:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    43e1:	eb 0d                	jmp    43f0 <free+0x20>
    43e3:	90                   	nop
    43e4:	90                   	nop
    43e5:	90                   	nop
    43e6:	90                   	nop
    43e7:	90                   	nop
    43e8:	90                   	nop
    43e9:	90                   	nop
    43ea:	90                   	nop
    43eb:	90                   	nop
    43ec:	90                   	nop
    43ed:	90                   	nop
    43ee:	90                   	nop
    43ef:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    43f0:	39 c8                	cmp    %ecx,%eax
    43f2:	8b 10                	mov    (%eax),%edx
    43f4:	73 32                	jae    4428 <free+0x58>
    43f6:	39 d1                	cmp    %edx,%ecx
    43f8:	72 04                	jb     43fe <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    43fa:	39 d0                	cmp    %edx,%eax
    43fc:	72 32                	jb     4430 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
    43fe:	8b 73 fc             	mov    -0x4(%ebx),%esi
    4401:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    4404:	39 fa                	cmp    %edi,%edx
    4406:	74 30                	je     4438 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    4408:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    440b:	8b 50 04             	mov    0x4(%eax),%edx
    440e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    4411:	39 f1                	cmp    %esi,%ecx
    4413:	74 3c                	je     4451 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    4415:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
    4417:	5b                   	pop    %ebx
  freep = p;
    4418:	a3 c0 66 00 00       	mov    %eax,0x66c0
}
    441d:	5e                   	pop    %esi
    441e:	5f                   	pop    %edi
    441f:	5d                   	pop    %ebp
    4420:	c3                   	ret    
    4421:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4428:	39 d0                	cmp    %edx,%eax
    442a:	72 04                	jb     4430 <free+0x60>
    442c:	39 d1                	cmp    %edx,%ecx
    442e:	72 ce                	jb     43fe <free+0x2e>
{
    4430:	89 d0                	mov    %edx,%eax
    4432:	eb bc                	jmp    43f0 <free+0x20>
    4434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    4438:	8b 7a 04             	mov    0x4(%edx),%edi
    443b:	01 fe                	add    %edi,%esi
    443d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    4440:	8b 10                	mov    (%eax),%edx
    4442:	8b 12                	mov    (%edx),%edx
    4444:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    4447:	8b 50 04             	mov    0x4(%eax),%edx
    444a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    444d:	39 f1                	cmp    %esi,%ecx
    444f:	75 c4                	jne    4415 <free+0x45>
    p->s.size += bp->s.size;
    4451:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
    4454:	a3 c0 66 00 00       	mov    %eax,0x66c0
    p->s.size += bp->s.size;
    4459:	01 ca                	add    %ecx,%edx
    445b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    445e:	8b 53 f8             	mov    -0x8(%ebx),%edx
    4461:	89 10                	mov    %edx,(%eax)
}
    4463:	5b                   	pop    %ebx
    4464:	5e                   	pop    %esi
    4465:	5f                   	pop    %edi
    4466:	5d                   	pop    %ebp
    4467:	c3                   	ret    
    4468:	90                   	nop
    4469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00004470 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    4470:	55                   	push   %ebp
    4471:	89 e5                	mov    %esp,%ebp
    4473:	57                   	push   %edi
    4474:	56                   	push   %esi
    4475:	53                   	push   %ebx
    4476:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4479:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    447c:	8b 15 c0 66 00 00    	mov    0x66c0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4482:	8d 78 07             	lea    0x7(%eax),%edi
    4485:	c1 ef 03             	shr    $0x3,%edi
    4488:	47                   	inc    %edi
  if((prevp = freep) == 0){
    4489:	85 d2                	test   %edx,%edx
    448b:	0f 84 8f 00 00 00    	je     4520 <malloc+0xb0>
    4491:	8b 02                	mov    (%edx),%eax
    4493:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    4496:	39 cf                	cmp    %ecx,%edi
    4498:	76 66                	jbe    4500 <malloc+0x90>
    449a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    44a0:	bb 00 10 00 00       	mov    $0x1000,%ebx
    44a5:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    44a8:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    44af:	eb 10                	jmp    44c1 <malloc+0x51>
    44b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    44b8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    44ba:	8b 48 04             	mov    0x4(%eax),%ecx
    44bd:	39 f9                	cmp    %edi,%ecx
    44bf:	73 3f                	jae    4500 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    44c1:	39 05 c0 66 00 00    	cmp    %eax,0x66c0
    44c7:	89 c2                	mov    %eax,%edx
    44c9:	75 ed                	jne    44b8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    44cb:	89 34 24             	mov    %esi,(%esp)
    44ce:	e8 2d fc ff ff       	call   4100 <sbrk>
  if(p == (char*)-1)
    44d3:	83 f8 ff             	cmp    $0xffffffff,%eax
    44d6:	74 18                	je     44f0 <malloc+0x80>
  hp->s.size = nu;
    44d8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    44db:	83 c0 08             	add    $0x8,%eax
    44de:	89 04 24             	mov    %eax,(%esp)
    44e1:	e8 ea fe ff ff       	call   43d0 <free>
  return freep;
    44e6:	8b 15 c0 66 00 00    	mov    0x66c0,%edx
      if((p = morecore(nunits)) == 0)
    44ec:	85 d2                	test   %edx,%edx
    44ee:	75 c8                	jne    44b8 <malloc+0x48>
        return 0;
  }
}
    44f0:	83 c4 1c             	add    $0x1c,%esp
        return 0;
    44f3:	31 c0                	xor    %eax,%eax
}
    44f5:	5b                   	pop    %ebx
    44f6:	5e                   	pop    %esi
    44f7:	5f                   	pop    %edi
    44f8:	5d                   	pop    %ebp
    44f9:	c3                   	ret    
    44fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    4500:	39 cf                	cmp    %ecx,%edi
    4502:	74 4c                	je     4550 <malloc+0xe0>
        p->s.size -= nunits;
    4504:	29 f9                	sub    %edi,%ecx
    4506:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    4509:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    450c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    450f:	89 15 c0 66 00 00    	mov    %edx,0x66c0
}
    4515:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
    4518:	83 c0 08             	add    $0x8,%eax
}
    451b:	5b                   	pop    %ebx
    451c:	5e                   	pop    %esi
    451d:	5f                   	pop    %edi
    451e:	5d                   	pop    %ebp
    451f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    4520:	b8 c4 66 00 00       	mov    $0x66c4,%eax
    4525:	ba c4 66 00 00       	mov    $0x66c4,%edx
    base.s.size = 0;
    452a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
    452c:	a3 c0 66 00 00       	mov    %eax,0x66c0
    base.s.size = 0;
    4531:	b8 c4 66 00 00       	mov    $0x66c4,%eax
    base.s.ptr = freep = prevp = &base;
    4536:	89 15 c4 66 00 00    	mov    %edx,0x66c4
    base.s.size = 0;
    453c:	89 0d c8 66 00 00    	mov    %ecx,0x66c8
    4542:	e9 53 ff ff ff       	jmp    449a <malloc+0x2a>
    4547:	89 f6                	mov    %esi,%esi
    4549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
    4550:	8b 08                	mov    (%eax),%ecx
    4552:	89 0a                	mov    %ecx,(%edx)
    4554:	eb b9                	jmp    450f <malloc+0x9f>
