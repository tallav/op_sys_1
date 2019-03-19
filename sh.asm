
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

int
main(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	53                   	push   %ebx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	83 ec 20             	sub    $0x20,%esp
  static char buf[100];
  int fd;
  int status;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
       a:	eb 0d                	jmp    19 <main+0x19>
       c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(fd >= 3){
      10:	83 f8 02             	cmp    $0x2,%eax
      13:	0f 8f ba 00 00 00    	jg     d3 <main+0xd3>
  while((fd = open("console", O_RDWR)) >= 0){
      19:	ba 02 00 00 00       	mov    $0x2,%edx
      1e:	89 54 24 04          	mov    %edx,0x4(%esp)
      22:	c7 04 24 b8 15 00 00 	movl   $0x15b8,(%esp)
      29:	e8 4a 10 00 00       	call   1078 <open>
      2e:	85 c0                	test   %eax,%eax
      30:	79 de                	jns    10 <main+0x10>
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
    wait(&status);
      32:	8d 5c 24 1c          	lea    0x1c(%esp),%ebx
      36:	eb 26                	jmp    5e <main+0x5e>
      38:	90                   	nop
      39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
int
fork1(void)
{
  int pid;

  pid = fork();
      40:	e8 eb 0f 00 00       	call   1030 <fork>
  if(pid == -1)
      45:	83 f8 ff             	cmp    $0xffffffff,%eax
      48:	0f 84 a3 00 00 00    	je     f1 <main+0xf1>
    if(fork1() == 0)
      4e:	85 c0                	test   %eax,%eax
      50:	0f 84 a7 00 00 00    	je     fd <main+0xfd>
    wait(&status);
      56:	89 1c 24             	mov    %ebx,(%esp)
      59:	e8 e2 0f 00 00       	call   1040 <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
      5e:	b8 64 00 00 00       	mov    $0x64,%eax
      63:	89 44 24 04          	mov    %eax,0x4(%esp)
      67:	c7 04 24 00 1c 00 00 	movl   $0x1c00,(%esp)
      6e:	e8 ad 00 00 00       	call   120 <getcmd>
      73:	85 c0                	test   %eax,%eax
      75:	78 6e                	js     e5 <main+0xe5>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      77:	80 3d 00 1c 00 00 63 	cmpb   $0x63,0x1c00
      7e:	75 c0                	jne    40 <main+0x40>
      80:	80 3d 01 1c 00 00 64 	cmpb   $0x64,0x1c01
      87:	75 b7                	jne    40 <main+0x40>
      89:	80 3d 02 1c 00 00 20 	cmpb   $0x20,0x1c02
      90:	75 ae                	jne    40 <main+0x40>
      buf[strlen(buf)-1] = 0;  // chop \n
      92:	c7 04 24 00 1c 00 00 	movl   $0x1c00,(%esp)
      99:	e8 d2 0d 00 00       	call   e70 <strlen>
      if(chdir(buf+3) < 0)
      9e:	c7 04 24 03 1c 00 00 	movl   $0x1c03,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
      a5:	c6 80 ff 1b 00 00 00 	movb   $0x0,0x1bff(%eax)
      if(chdir(buf+3) < 0)
      ac:	e8 f7 0f 00 00       	call   10a8 <chdir>
      b1:	85 c0                	test   %eax,%eax
      b3:	79 a9                	jns    5e <main+0x5e>
        printf(2, "cannot cd %s\n", buf+3);
      b5:	c7 44 24 08 03 1c 00 	movl   $0x1c03,0x8(%esp)
      bc:	00 
      bd:	c7 44 24 04 c0 15 00 	movl   $0x15c0,0x4(%esp)
      c4:	00 
      c5:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      cc:	e8 bf 10 00 00       	call   1190 <printf>
      d1:	eb 8b                	jmp    5e <main+0x5e>
      close(fd);
      d3:	89 04 24             	mov    %eax,(%esp)
      d6:	e8 85 0f 00 00       	call   1060 <close>
      db:	90                   	nop
      dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      break;
      e0:	e9 4d ff ff ff       	jmp    32 <main+0x32>
  exit(0);
      e5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      ec:	e8 47 0f 00 00       	call   1038 <exit>
    panic("fork");
      f1:	c7 04 24 41 15 00 00 	movl   $0x1541,(%esp)
      f8:	e8 83 00 00 00       	call   180 <panic>
      runcmd(parsecmd(buf));
      fd:	c7 04 24 00 1c 00 00 	movl   $0x1c00,(%esp)
     104:	e8 87 0c 00 00       	call   d90 <parsecmd>
     109:	89 04 24             	mov    %eax,(%esp)
     10c:	e8 9f 00 00 00       	call   1b0 <runcmd>
     111:	66 90                	xchg   %ax,%ax
     113:	66 90                	xchg   %ax,%ax
     115:	66 90                	xchg   %ax,%ax
     117:	66 90                	xchg   %ax,%ax
     119:	66 90                	xchg   %ax,%ax
     11b:	66 90                	xchg   %ax,%ax
     11d:	66 90                	xchg   %ax,%ax
     11f:	90                   	nop

00000120 <getcmd>:
{
     120:	55                   	push   %ebp
  printf(2, "$ ");
     121:	b8 08 15 00 00       	mov    $0x1508,%eax
{
     126:	89 e5                	mov    %esp,%ebp
     128:	83 ec 18             	sub    $0x18,%esp
     12b:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     12e:	8b 5d 08             	mov    0x8(%ebp),%ebx
     131:	89 75 fc             	mov    %esi,-0x4(%ebp)
     134:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(2, "$ ");
     137:	89 44 24 04          	mov    %eax,0x4(%esp)
     13b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     142:	e8 49 10 00 00       	call   1190 <printf>
  memset(buf, 0, nbuf);
     147:	31 d2                	xor    %edx,%edx
     149:	89 74 24 08          	mov    %esi,0x8(%esp)
     14d:	89 54 24 04          	mov    %edx,0x4(%esp)
     151:	89 1c 24             	mov    %ebx,(%esp)
     154:	e8 47 0d 00 00       	call   ea0 <memset>
  gets(buf, nbuf);
     159:	89 74 24 04          	mov    %esi,0x4(%esp)
     15d:	89 1c 24             	mov    %ebx,(%esp)
     160:	e8 8b 0d 00 00       	call   ef0 <gets>
  if(buf[0] == 0) // EOF
     165:	31 c0                	xor    %eax,%eax
}
     167:	8b 75 fc             	mov    -0x4(%ebp),%esi
  if(buf[0] == 0) // EOF
     16a:	80 3b 00             	cmpb   $0x0,(%ebx)
}
     16d:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  if(buf[0] == 0) // EOF
     170:	0f 94 c0             	sete   %al
}
     173:	89 ec                	mov    %ebp,%esp
  if(buf[0] == 0) // EOF
     175:	f7 d8                	neg    %eax
}
     177:	5d                   	pop    %ebp
     178:	c3                   	ret    
     179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000180 <panic>:
{
     180:	55                   	push   %ebp
     181:	89 e5                	mov    %esp,%ebp
     183:	83 ec 18             	sub    $0x18,%esp
  printf(2, "%s\n", s);
     186:	8b 45 08             	mov    0x8(%ebp),%eax
     189:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     190:	89 44 24 08          	mov    %eax,0x8(%esp)
     194:	b8 b4 15 00 00       	mov    $0x15b4,%eax
     199:	89 44 24 04          	mov    %eax,0x4(%esp)
     19d:	e8 ee 0f 00 00       	call   1190 <printf>
  exit(0);
     1a2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     1a9:	e8 8a 0e 00 00       	call   1038 <exit>
     1ae:	66 90                	xchg   %ax,%ax

000001b0 <runcmd>:
{
     1b0:	55                   	push   %ebp
     1b1:	89 e5                	mov    %esp,%ebp
     1b3:	57                   	push   %edi
     1b4:	56                   	push   %esi
     1b5:	53                   	push   %ebx
     1b6:	81 ec 3c 04 00 00    	sub    $0x43c,%esp
     1bc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     1bf:	85 db                	test   %ebx,%ebx
     1c1:	74 5d                	je     220 <runcmd+0x70>
  char* tempDir = (char*)malloc(BUF_SIZE * sizeof(char));
     1c3:	c7 04 24 00 04 00 00 	movl   $0x400,(%esp)
     1ca:	e8 51 12 00 00       	call   1420 <malloc>
  switch(cmd->type){
     1cf:	83 3b 05             	cmpl   $0x5,(%ebx)
  char* tempDir = (char*)malloc(BUF_SIZE * sizeof(char));
     1d2:	89 c6                	mov    %eax,%esi
  switch(cmd->type){
     1d4:	0f 87 e0 01 00 00    	ja     3ba <runcmd+0x20a>
     1da:	8b 03                	mov    (%ebx),%eax
     1dc:	ff 24 85 f0 15 00 00 	jmp    *0x15f0(,%eax,4)
    close(rcmd->fd);
     1e3:	8b 43 14             	mov    0x14(%ebx),%eax
     1e6:	89 04 24             	mov    %eax,(%esp)
     1e9:	e8 72 0e 00 00       	call   1060 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     1ee:	8b 43 10             	mov    0x10(%ebx),%eax
     1f1:	89 44 24 04          	mov    %eax,0x4(%esp)
     1f5:	8b 43 08             	mov    0x8(%ebx),%eax
     1f8:	89 04 24             	mov    %eax,(%esp)
     1fb:	e8 78 0e 00 00       	call   1078 <open>
     200:	85 c0                	test   %eax,%eax
     202:	79 3a                	jns    23e <runcmd+0x8e>
      printf(2, "open %s failed\n", rcmd->file);
     204:	8b 43 08             	mov    0x8(%ebx),%eax
     207:	c7 44 24 04 31 15 00 	movl   $0x1531,0x4(%esp)
     20e:	00 
     20f:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     216:	89 44 24 08          	mov    %eax,0x8(%esp)
     21a:	e8 71 0f 00 00       	call   1190 <printf>
     21f:	90                   	nop
      exit(0);
     220:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     227:	e8 0c 0e 00 00       	call   1038 <exit>
  pid = fork();
     22c:	e8 ff 0d 00 00       	call   1030 <fork>
  if(pid == -1)
     231:	83 f8 ff             	cmp    $0xffffffff,%eax
     234:	0f 84 8c 01 00 00    	je     3c6 <runcmd+0x216>
    if(fork1() == 0)
     23a:	85 c0                	test   %eax,%eax
     23c:	75 e2                	jne    220 <runcmd+0x70>
      runcmd(bcmd->cmd);
     23e:	8b 43 04             	mov    0x4(%ebx),%eax
     241:	89 04 24             	mov    %eax,(%esp)
     244:	e8 67 ff ff ff       	call   1b0 <runcmd>
	fd = open("/path", O_RDWR | O_CREATE); /*crate path file if it is not exist*/
     249:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     250:	00 
	bytes = read(fd, buf, BUF_SIZE);
     251:	8d bd e8 fb ff ff    	lea    -0x418(%ebp),%edi
	fd = open("/path", O_RDWR | O_CREATE); /*crate path file if it is not exist*/
     257:	c7 04 24 12 15 00 00 	movl   $0x1512,(%esp)
     25e:	e8 15 0e 00 00       	call   1078 <open>
	bytes = read(fd, buf, BUF_SIZE);
     263:	c7 44 24 08 00 04 00 	movl   $0x400,0x8(%esp)
     26a:	00 
     26b:	89 7c 24 04          	mov    %edi,0x4(%esp)
     26f:	89 04 24             	mov    %eax,(%esp)
     272:	89 85 d4 fb ff ff    	mov    %eax,-0x42c(%ebp)
     278:	e8 d3 0d 00 00       	call   1050 <read>
	if(bytes == 0){ /*file path is empty*/
     27d:	8b 95 d4 fb ff ff    	mov    -0x42c(%ebp),%edx
     283:	85 c0                	test   %eax,%eax
     285:	0f 84 f6 01 00 00    	je     481 <runcmd+0x2d1>
	close(fd);
     28b:	89 14 24             	mov    %edx,(%esp)
     28e:	e8 cd 0d 00 00       	call   1060 <close>
    if(ecmd->argv[0] == 0)
     293:	8b 43 04             	mov    0x4(%ebx),%eax
     296:	85 c0                	test   %eax,%eax
     298:	74 86                	je     220 <runcmd+0x70>
    exec(ecmd->argv[0], ecmd->argv);
     29a:	8d 4b 04             	lea    0x4(%ebx),%ecx
     29d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     2a1:	89 04 24             	mov    %eax,(%esp)
     2a4:	89 8d d4 fb ff ff    	mov    %ecx,-0x42c(%ebp)
     2aa:	e8 c1 0d 00 00       	call   1070 <exec>
    if((ecmd->argv[0])[0] == '/'){ /*check for absolute path*/
     2af:	8b 43 04             	mov    0x4(%ebx),%eax
     2b2:	80 38 2f             	cmpb   $0x2f,(%eax)
     2b5:	0f 84 f7 01 00 00    	je     4b2 <runcmd+0x302>
        fd = open("/path", O_RDWR); 
     2bb:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
     2c2:	00 
     2c3:	c7 04 24 12 15 00 00 	movl   $0x1512,(%esp)
     2ca:	e8 a9 0d 00 00       	call   1078 <open>
        bytes = read(fd, buf, BUF_SIZE);
     2cf:	c7 44 24 08 00 04 00 	movl   $0x400,0x8(%esp)
     2d6:	00 
     2d7:	89 7c 24 04          	mov    %edi,0x4(%esp)
     2db:	89 04 24             	mov    %eax,(%esp)
        fd = open("/path", O_RDWR); 
     2de:	89 85 c8 fb ff ff    	mov    %eax,-0x438(%ebp)
        bytes = read(fd, buf, BUF_SIZE);
     2e4:	e8 67 0d 00 00       	call   1050 <read>
        i = 0;
     2e9:	31 d2                	xor    %edx,%edx
  int i, j = 0;
     2eb:	31 c9                	xor    %ecx,%ecx
     2ed:	89 5d 08             	mov    %ebx,0x8(%ebp)
     2f0:	89 d3                	mov    %edx,%ebx
     2f2:	89 c2                	mov    %eax,%edx
        while(i < bytes){
     2f4:	39 d3                	cmp    %edx,%ebx
     2f6:	0f 8d 40 01 00 00    	jge    43c <runcmd+0x28c>
            if(buf[i] == ':'){
     2fc:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
     300:	3c 3a                	cmp    $0x3a,%al
     302:	0f 84 ca 00 00 00    	je     3d2 <runcmd+0x222>
                tempDir[j] = buf[i];
     308:	88 04 0e             	mov    %al,(%esi,%ecx,1)
            i++;
     30b:	43                   	inc    %ebx
                j++;
     30c:	41                   	inc    %ecx
     30d:	eb e5                	jmp    2f4 <runcmd+0x144>
    if(pipe(p) < 0)
     30f:	8d 85 e0 fb ff ff    	lea    -0x420(%ebp),%eax
     315:	89 04 24             	mov    %eax,(%esp)
     318:	e8 2b 0d 00 00       	call   1048 <pipe>
     31d:	85 c0                	test   %eax,%eax
     31f:	0f 88 50 01 00 00    	js     475 <runcmd+0x2c5>
  pid = fork();
     325:	e8 06 0d 00 00       	call   1030 <fork>
  if(pid == -1)
     32a:	83 f8 ff             	cmp    $0xffffffff,%eax
     32d:	8d 76 00             	lea    0x0(%esi),%esi
     330:	0f 84 90 00 00 00    	je     3c6 <runcmd+0x216>
    if(fork1() == 0){
     336:	85 c0                	test   %eax,%eax
     338:	0f 84 91 01 00 00    	je     4cf <runcmd+0x31f>
     33e:	66 90                	xchg   %ax,%ax
  pid = fork();
     340:	e8 eb 0c 00 00       	call   1030 <fork>
  if(pid == -1)
     345:	83 f8 ff             	cmp    $0xffffffff,%eax
     348:	74 7c                	je     3c6 <runcmd+0x216>
    if(fork1() == 0){
     34a:	85 c0                	test   %eax,%eax
     34c:	0f 84 be 01 00 00    	je     510 <runcmd+0x360>
    close(p[0]);
     352:	8b 85 e0 fb ff ff    	mov    -0x420(%ebp),%eax
     358:	89 04 24             	mov    %eax,(%esp)
     35b:	e8 00 0d 00 00       	call   1060 <close>
    close(p[1]);
     360:	8b 85 e4 fb ff ff    	mov    -0x41c(%ebp),%eax
     366:	89 04 24             	mov    %eax,(%esp)
     369:	e8 f2 0c 00 00       	call   1060 <close>
    wait(&status1);
     36e:	8d 85 d8 fb ff ff    	lea    -0x428(%ebp),%eax
     374:	89 04 24             	mov    %eax,(%esp)
     377:	e8 c4 0c 00 00       	call   1040 <wait>
    wait(&status2);
     37c:	8d 85 dc fb ff ff    	lea    -0x424(%ebp),%eax
     382:	89 04 24             	mov    %eax,(%esp)
     385:	e8 b6 0c 00 00       	call   1040 <wait>
    break;
     38a:	e9 91 fe ff ff       	jmp    220 <runcmd+0x70>
  pid = fork();
     38f:	e8 9c 0c 00 00       	call   1030 <fork>
  if(pid == -1)
     394:	83 f8 ff             	cmp    $0xffffffff,%eax
     397:	74 2d                	je     3c6 <runcmd+0x216>
    if(fork1() == 0)
     399:	85 c0                	test   %eax,%eax
     39b:	0f 84 9d fe ff ff    	je     23e <runcmd+0x8e>
    wait(&status);
     3a1:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
     3a7:	89 04 24             	mov    %eax,(%esp)
     3aa:	e8 91 0c 00 00       	call   1040 <wait>
    runcmd(lcmd->right);
     3af:	8b 43 08             	mov    0x8(%ebx),%eax
     3b2:	89 04 24             	mov    %eax,(%esp)
     3b5:	e8 f6 fd ff ff       	call   1b0 <runcmd>
    panic("runcmd");
     3ba:	c7 04 24 0b 15 00 00 	movl   $0x150b,(%esp)
     3c1:	e8 ba fd ff ff       	call   180 <panic>
    panic("fork");
     3c6:	c7 04 24 41 15 00 00 	movl   $0x1541,(%esp)
     3cd:	e8 ae fd ff ff       	call   180 <panic>
                strcpy(tempDir+strlen(tempDir), ecmd->argv[0]); /*add the prefix path to the relative path*/
     3d2:	8b 45 08             	mov    0x8(%ebp),%eax
            i++;
     3d5:	43                   	inc    %ebx
     3d6:	89 95 cc fb ff ff    	mov    %edx,-0x434(%ebp)
                strcpy(tempDir+strlen(tempDir), ecmd->argv[0]); /*add the prefix path to the relative path*/
     3dc:	8b 48 04             	mov    0x4(%eax),%ecx
     3df:	89 34 24             	mov    %esi,(%esp)
     3e2:	89 8d d0 fb ff ff    	mov    %ecx,-0x430(%ebp)
     3e8:	e8 83 0a 00 00       	call   e70 <strlen>
     3ed:	8b 8d d0 fb ff ff    	mov    -0x430(%ebp),%ecx
     3f3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     3f7:	01 f0                	add    %esi,%eax
     3f9:	89 04 24             	mov    %eax,(%esp)
     3fc:	e8 0f 0a 00 00       	call   e10 <strcpy>
                exec(tempDir, ecmd->argv);
     401:	8b 85 d4 fb ff ff    	mov    -0x42c(%ebp),%eax
     407:	89 34 24             	mov    %esi,(%esp)
     40a:	89 44 24 04          	mov    %eax,0x4(%esp)
     40e:	e8 5d 0c 00 00       	call   1070 <exec>
                memset(tempDir, 0, strlen(tempDir)); /*reset the path string*/
     413:	89 34 24             	mov    %esi,(%esp)
     416:	e8 55 0a 00 00       	call   e70 <strlen>
     41b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     422:	00 
     423:	89 34 24             	mov    %esi,(%esp)
     426:	89 44 24 08          	mov    %eax,0x8(%esp)
     42a:	e8 71 0a 00 00       	call   ea0 <memset>
                j = 0;/*start over to next directory in file path*/
     42f:	31 c9                	xor    %ecx,%ecx
     431:	8b 95 cc fb ff ff    	mov    -0x434(%ebp),%edx
     437:	e9 b8 fe ff ff       	jmp    2f4 <runcmd+0x144>
        free(tempDir);
     43c:	89 34 24             	mov    %esi,(%esp)
     43f:	8b 5d 08             	mov    0x8(%ebp),%ebx
     442:	e8 39 0f 00 00       	call   1380 <free>
        close(fd);
     447:	8b 85 c8 fb ff ff    	mov    -0x438(%ebp),%eax
     44d:	89 04 24             	mov    %eax,(%esp)
     450:	e8 0b 0c 00 00       	call   1060 <close>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     455:	8b 43 04             	mov    0x4(%ebx),%eax
     458:	c7 44 24 04 21 15 00 	movl   $0x1521,0x4(%esp)
     45f:	00 
     460:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     467:	89 44 24 08          	mov    %eax,0x8(%esp)
     46b:	e8 20 0d 00 00       	call   1190 <printf>
    break;
     470:	e9 ab fd ff ff       	jmp    220 <runcmd+0x70>
      panic("pipe");
     475:	c7 04 24 46 15 00 00 	movl   $0x1546,(%esp)
     47c:	e8 ff fc ff ff       	call   180 <panic>
		write(fd, difPath, strlen(difPath)); /*write the difault value*/
     481:	c7 04 24 18 15 00 00 	movl   $0x1518,(%esp)
     488:	e8 e3 09 00 00       	call   e70 <strlen>
     48d:	8b 95 d4 fb ff ff    	mov    -0x42c(%ebp),%edx
     493:	c7 44 24 04 18 15 00 	movl   $0x1518,0x4(%esp)
     49a:	00 
     49b:	89 14 24             	mov    %edx,(%esp)
     49e:	89 44 24 08          	mov    %eax,0x8(%esp)
     4a2:	e8 b1 0b 00 00       	call   1058 <write>
     4a7:	8b 95 d4 fb ff ff    	mov    -0x42c(%ebp),%edx
     4ad:	e9 d9 fd ff ff       	jmp    28b <runcmd+0xdb>
        printf(2, "exec %s failed - absolute path\n", ecmd->argv[0]);
     4b2:	89 44 24 08          	mov    %eax,0x8(%esp)
     4b6:	c7 44 24 04 d0 15 00 	movl   $0x15d0,0x4(%esp)
     4bd:	00 
     4be:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     4c5:	e8 c6 0c 00 00       	call   1190 <printf>
        break; /*no need to seek the executable in the directories in file path*/
     4ca:	e9 51 fd ff ff       	jmp    220 <runcmd+0x70>
      close(1);
     4cf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     4d6:	e8 85 0b 00 00       	call   1060 <close>
      dup(p[1]);
     4db:	8b 85 e4 fb ff ff    	mov    -0x41c(%ebp),%eax
     4e1:	89 04 24             	mov    %eax,(%esp)
     4e4:	e8 c7 0b 00 00       	call   10b0 <dup>
      close(p[0]);
     4e9:	8b 85 e0 fb ff ff    	mov    -0x420(%ebp),%eax
     4ef:	89 04 24             	mov    %eax,(%esp)
     4f2:	e8 69 0b 00 00       	call   1060 <close>
      close(p[1]);
     4f7:	8b 85 e4 fb ff ff    	mov    -0x41c(%ebp),%eax
     4fd:	89 04 24             	mov    %eax,(%esp)
     500:	e8 5b 0b 00 00       	call   1060 <close>
      runcmd(pcmd->left);
     505:	8b 43 04             	mov    0x4(%ebx),%eax
     508:	89 04 24             	mov    %eax,(%esp)
     50b:	e8 a0 fc ff ff       	call   1b0 <runcmd>
      close(0);
     510:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     517:	e8 44 0b 00 00       	call   1060 <close>
      dup(p[0]);
     51c:	8b 85 e0 fb ff ff    	mov    -0x420(%ebp),%eax
     522:	89 04 24             	mov    %eax,(%esp)
     525:	e8 86 0b 00 00       	call   10b0 <dup>
      close(p[0]);
     52a:	8b 85 e0 fb ff ff    	mov    -0x420(%ebp),%eax
     530:	89 04 24             	mov    %eax,(%esp)
     533:	e8 28 0b 00 00       	call   1060 <close>
      close(p[1]);
     538:	8b 85 e4 fb ff ff    	mov    -0x41c(%ebp),%eax
     53e:	89 04 24             	mov    %eax,(%esp)
     541:	e8 1a 0b 00 00       	call   1060 <close>
      runcmd(pcmd->right);
     546:	8b 43 08             	mov    0x8(%ebx),%eax
     549:	89 04 24             	mov    %eax,(%esp)
     54c:	e8 5f fc ff ff       	call   1b0 <runcmd>
     551:	eb 0d                	jmp    560 <fork1>
     553:	90                   	nop
     554:	90                   	nop
     555:	90                   	nop
     556:	90                   	nop
     557:	90                   	nop
     558:	90                   	nop
     559:	90                   	nop
     55a:	90                   	nop
     55b:	90                   	nop
     55c:	90                   	nop
     55d:	90                   	nop
     55e:	90                   	nop
     55f:	90                   	nop

00000560 <fork1>:
{
     560:	55                   	push   %ebp
     561:	89 e5                	mov    %esp,%ebp
     563:	83 ec 18             	sub    $0x18,%esp
  pid = fork();
     566:	e8 c5 0a 00 00       	call   1030 <fork>
  if(pid == -1)
     56b:	83 f8 ff             	cmp    $0xffffffff,%eax
     56e:	74 02                	je     572 <fork1+0x12>
  return pid;
}
     570:	c9                   	leave  
     571:	c3                   	ret    
    panic("fork");
     572:	c7 04 24 41 15 00 00 	movl   $0x1541,(%esp)
     579:	e8 02 fc ff ff       	call   180 <panic>
     57e:	66 90                	xchg   %ax,%ax

00000580 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     580:	55                   	push   %ebp
     581:	89 e5                	mov    %esp,%ebp
     583:	53                   	push   %ebx
     584:	83 ec 14             	sub    $0x14,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     587:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
     58e:	e8 8d 0e 00 00       	call   1420 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     593:	31 d2                	xor    %edx,%edx
     595:	89 54 24 04          	mov    %edx,0x4(%esp)
  cmd = malloc(sizeof(*cmd));
     599:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     59b:	b8 54 00 00 00       	mov    $0x54,%eax
     5a0:	89 1c 24             	mov    %ebx,(%esp)
     5a3:	89 44 24 08          	mov    %eax,0x8(%esp)
     5a7:	e8 f4 08 00 00       	call   ea0 <memset>
  cmd->type = EXEC;
  return (struct cmd*)cmd;
}
     5ac:	89 d8                	mov    %ebx,%eax
  cmd->type = EXEC;
     5ae:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
}
     5b4:	83 c4 14             	add    $0x14,%esp
     5b7:	5b                   	pop    %ebx
     5b8:	5d                   	pop    %ebp
     5b9:	c3                   	ret    
     5ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000005c0 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     5c0:	55                   	push   %ebp
     5c1:	89 e5                	mov    %esp,%ebp
     5c3:	53                   	push   %ebx
     5c4:	83 ec 14             	sub    $0x14,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     5c7:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
     5ce:	e8 4d 0e 00 00       	call   1420 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     5d3:	31 d2                	xor    %edx,%edx
     5d5:	89 54 24 04          	mov    %edx,0x4(%esp)
  cmd = malloc(sizeof(*cmd));
     5d9:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     5db:	b8 18 00 00 00       	mov    $0x18,%eax
     5e0:	89 1c 24             	mov    %ebx,(%esp)
     5e3:	89 44 24 08          	mov    %eax,0x8(%esp)
     5e7:	e8 b4 08 00 00       	call   ea0 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     5ec:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     5ef:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     5f5:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     5f8:	8b 45 0c             	mov    0xc(%ebp),%eax
     5fb:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     5fe:	8b 45 10             	mov    0x10(%ebp),%eax
     601:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     604:	8b 45 14             	mov    0x14(%ebp),%eax
     607:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     60a:	8b 45 18             	mov    0x18(%ebp),%eax
     60d:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     610:	83 c4 14             	add    $0x14,%esp
     613:	89 d8                	mov    %ebx,%eax
     615:	5b                   	pop    %ebx
     616:	5d                   	pop    %ebp
     617:	c3                   	ret    
     618:	90                   	nop
     619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000620 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     620:	55                   	push   %ebp
     621:	89 e5                	mov    %esp,%ebp
     623:	53                   	push   %ebx
     624:	83 ec 14             	sub    $0x14,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     627:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     62e:	e8 ed 0d 00 00       	call   1420 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     633:	31 d2                	xor    %edx,%edx
     635:	89 54 24 04          	mov    %edx,0x4(%esp)
  cmd = malloc(sizeof(*cmd));
     639:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     63b:	b8 0c 00 00 00       	mov    $0xc,%eax
     640:	89 1c 24             	mov    %ebx,(%esp)
     643:	89 44 24 08          	mov    %eax,0x8(%esp)
     647:	e8 54 08 00 00       	call   ea0 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     64c:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     64f:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     655:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     658:	8b 45 0c             	mov    0xc(%ebp),%eax
     65b:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     65e:	83 c4 14             	add    $0x14,%esp
     661:	89 d8                	mov    %ebx,%eax
     663:	5b                   	pop    %ebx
     664:	5d                   	pop    %ebp
     665:	c3                   	ret    
     666:	8d 76 00             	lea    0x0(%esi),%esi
     669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000670 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     670:	55                   	push   %ebp
     671:	89 e5                	mov    %esp,%ebp
     673:	53                   	push   %ebx
     674:	83 ec 14             	sub    $0x14,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     677:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     67e:	e8 9d 0d 00 00       	call   1420 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     683:	31 d2                	xor    %edx,%edx
     685:	89 54 24 04          	mov    %edx,0x4(%esp)
  cmd = malloc(sizeof(*cmd));
     689:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     68b:	b8 0c 00 00 00       	mov    $0xc,%eax
     690:	89 1c 24             	mov    %ebx,(%esp)
     693:	89 44 24 08          	mov    %eax,0x8(%esp)
     697:	e8 04 08 00 00       	call   ea0 <memset>
  cmd->type = LIST;
  cmd->left = left;
     69c:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     69f:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     6a5:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     6a8:	8b 45 0c             	mov    0xc(%ebp),%eax
     6ab:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     6ae:	83 c4 14             	add    $0x14,%esp
     6b1:	89 d8                	mov    %ebx,%eax
     6b3:	5b                   	pop    %ebx
     6b4:	5d                   	pop    %ebp
     6b5:	c3                   	ret    
     6b6:	8d 76 00             	lea    0x0(%esi),%esi
     6b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006c0 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     6c0:	55                   	push   %ebp
     6c1:	89 e5                	mov    %esp,%ebp
     6c3:	53                   	push   %ebx
     6c4:	83 ec 14             	sub    $0x14,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     6c7:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     6ce:	e8 4d 0d 00 00       	call   1420 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     6d3:	31 d2                	xor    %edx,%edx
     6d5:	89 54 24 04          	mov    %edx,0x4(%esp)
  cmd = malloc(sizeof(*cmd));
     6d9:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     6db:	b8 08 00 00 00       	mov    $0x8,%eax
     6e0:	89 1c 24             	mov    %ebx,(%esp)
     6e3:	89 44 24 08          	mov    %eax,0x8(%esp)
     6e7:	e8 b4 07 00 00       	call   ea0 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     6ec:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     6ef:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     6f5:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     6f8:	83 c4 14             	add    $0x14,%esp
     6fb:	89 d8                	mov    %ebx,%eax
     6fd:	5b                   	pop    %ebx
     6fe:	5d                   	pop    %ebp
     6ff:	c3                   	ret    

00000700 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     700:	55                   	push   %ebp
     701:	89 e5                	mov    %esp,%ebp
     703:	57                   	push   %edi
     704:	56                   	push   %esi
     705:	53                   	push   %ebx
     706:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int ret;

  s = *ps;
     709:	8b 45 08             	mov    0x8(%ebp),%eax
{
     70c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     70f:	8b 7d 10             	mov    0x10(%ebp),%edi
  s = *ps;
     712:	8b 30                	mov    (%eax),%esi
  while(s < es && strchr(whitespace, *s))
     714:	39 de                	cmp    %ebx,%esi
     716:	72 0d                	jb     725 <gettoken+0x25>
     718:	eb 22                	jmp    73c <gettoken+0x3c>
     71a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     720:	46                   	inc    %esi
  while(s < es && strchr(whitespace, *s))
     721:	39 f3                	cmp    %esi,%ebx
     723:	74 17                	je     73c <gettoken+0x3c>
     725:	0f be 06             	movsbl (%esi),%eax
     728:	c7 04 24 e0 1b 00 00 	movl   $0x1be0,(%esp)
     72f:	89 44 24 04          	mov    %eax,0x4(%esp)
     733:	e8 88 07 00 00       	call   ec0 <strchr>
     738:	85 c0                	test   %eax,%eax
     73a:	75 e4                	jne    720 <gettoken+0x20>
  if(q)
     73c:	85 ff                	test   %edi,%edi
     73e:	74 02                	je     742 <gettoken+0x42>
    *q = s;
     740:	89 37                	mov    %esi,(%edi)
  ret = *s;
     742:	0f be 06             	movsbl (%esi),%eax
  switch(*s){
     745:	3c 29                	cmp    $0x29,%al
     747:	7f 57                	jg     7a0 <gettoken+0xa0>
     749:	3c 28                	cmp    $0x28,%al
     74b:	0f 8d cb 00 00 00    	jge    81c <gettoken+0x11c>
     751:	31 ff                	xor    %edi,%edi
     753:	84 c0                	test   %al,%al
     755:	0f 85 cd 00 00 00    	jne    828 <gettoken+0x128>
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     75b:	8b 55 14             	mov    0x14(%ebp),%edx
     75e:	85 d2                	test   %edx,%edx
     760:	74 05                	je     767 <gettoken+0x67>
    *eq = s;
     762:	8b 45 14             	mov    0x14(%ebp),%eax
     765:	89 30                	mov    %esi,(%eax)

  while(s < es && strchr(whitespace, *s))
     767:	39 de                	cmp    %ebx,%esi
     769:	72 0a                	jb     775 <gettoken+0x75>
     76b:	eb 1f                	jmp    78c <gettoken+0x8c>
     76d:	8d 76 00             	lea    0x0(%esi),%esi
    s++;
     770:	46                   	inc    %esi
  while(s < es && strchr(whitespace, *s))
     771:	39 f3                	cmp    %esi,%ebx
     773:	74 17                	je     78c <gettoken+0x8c>
     775:	0f be 06             	movsbl (%esi),%eax
     778:	c7 04 24 e0 1b 00 00 	movl   $0x1be0,(%esp)
     77f:	89 44 24 04          	mov    %eax,0x4(%esp)
     783:	e8 38 07 00 00       	call   ec0 <strchr>
     788:	85 c0                	test   %eax,%eax
     78a:	75 e4                	jne    770 <gettoken+0x70>
  *ps = s;
     78c:	8b 45 08             	mov    0x8(%ebp),%eax
     78f:	89 30                	mov    %esi,(%eax)
  return ret;
}
     791:	83 c4 1c             	add    $0x1c,%esp
     794:	89 f8                	mov    %edi,%eax
     796:	5b                   	pop    %ebx
     797:	5e                   	pop    %esi
     798:	5f                   	pop    %edi
     799:	5d                   	pop    %ebp
     79a:	c3                   	ret    
     79b:	90                   	nop
     79c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     7a0:	3c 3e                	cmp    $0x3e,%al
     7a2:	75 1c                	jne    7c0 <gettoken+0xc0>
    if(*s == '>'){
     7a4:	80 7e 01 3e          	cmpb   $0x3e,0x1(%esi)
    s++;
     7a8:	8d 46 01             	lea    0x1(%esi),%eax
    if(*s == '>'){
     7ab:	0f 84 94 00 00 00    	je     845 <gettoken+0x145>
    s++;
     7b1:	89 c6                	mov    %eax,%esi
     7b3:	bf 3e 00 00 00       	mov    $0x3e,%edi
     7b8:	eb a1                	jmp    75b <gettoken+0x5b>
     7ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  switch(*s){
     7c0:	7f 56                	jg     818 <gettoken+0x118>
     7c2:	88 c1                	mov    %al,%cl
     7c4:	80 e9 3b             	sub    $0x3b,%cl
     7c7:	80 f9 01             	cmp    $0x1,%cl
     7ca:	76 50                	jbe    81c <gettoken+0x11c>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     7cc:	39 f3                	cmp    %esi,%ebx
     7ce:	77 27                	ja     7f7 <gettoken+0xf7>
     7d0:	eb 5e                	jmp    830 <gettoken+0x130>
     7d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     7d8:	0f be 06             	movsbl (%esi),%eax
     7db:	c7 04 24 d8 1b 00 00 	movl   $0x1bd8,(%esp)
     7e2:	89 44 24 04          	mov    %eax,0x4(%esp)
     7e6:	e8 d5 06 00 00       	call   ec0 <strchr>
     7eb:	85 c0                	test   %eax,%eax
     7ed:	75 1c                	jne    80b <gettoken+0x10b>
      s++;
     7ef:	46                   	inc    %esi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     7f0:	39 f3                	cmp    %esi,%ebx
     7f2:	74 3c                	je     830 <gettoken+0x130>
     7f4:	0f be 06             	movsbl (%esi),%eax
     7f7:	89 44 24 04          	mov    %eax,0x4(%esp)
     7fb:	c7 04 24 e0 1b 00 00 	movl   $0x1be0,(%esp)
     802:	e8 b9 06 00 00       	call   ec0 <strchr>
     807:	85 c0                	test   %eax,%eax
     809:	74 cd                	je     7d8 <gettoken+0xd8>
    ret = 'a';
     80b:	bf 61 00 00 00       	mov    $0x61,%edi
     810:	e9 46 ff ff ff       	jmp    75b <gettoken+0x5b>
     815:	8d 76 00             	lea    0x0(%esi),%esi
  switch(*s){
     818:	3c 7c                	cmp    $0x7c,%al
     81a:	75 b0                	jne    7cc <gettoken+0xcc>
  ret = *s;
     81c:	0f be f8             	movsbl %al,%edi
    s++;
     81f:	46                   	inc    %esi
    break;
     820:	e9 36 ff ff ff       	jmp    75b <gettoken+0x5b>
     825:	8d 76 00             	lea    0x0(%esi),%esi
  switch(*s){
     828:	3c 26                	cmp    $0x26,%al
     82a:	75 a0                	jne    7cc <gettoken+0xcc>
     82c:	eb ee                	jmp    81c <gettoken+0x11c>
     82e:	66 90                	xchg   %ax,%ax
  if(eq)
     830:	8b 45 14             	mov    0x14(%ebp),%eax
     833:	bf 61 00 00 00       	mov    $0x61,%edi
     838:	85 c0                	test   %eax,%eax
     83a:	0f 85 22 ff ff ff    	jne    762 <gettoken+0x62>
     840:	e9 47 ff ff ff       	jmp    78c <gettoken+0x8c>
      s++;
     845:	83 c6 02             	add    $0x2,%esi
      ret = '+';
     848:	bf 2b 00 00 00       	mov    $0x2b,%edi
     84d:	e9 09 ff ff ff       	jmp    75b <gettoken+0x5b>
     852:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000860 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     860:	55                   	push   %ebp
     861:	89 e5                	mov    %esp,%ebp
     863:	57                   	push   %edi
     864:	56                   	push   %esi
     865:	53                   	push   %ebx
     866:	83 ec 1c             	sub    $0x1c,%esp
     869:	8b 7d 08             	mov    0x8(%ebp),%edi
     86c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     86f:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     871:	39 f3                	cmp    %esi,%ebx
     873:	72 10                	jb     885 <peek+0x25>
     875:	eb 25                	jmp    89c <peek+0x3c>
     877:	89 f6                	mov    %esi,%esi
     879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    s++;
     880:	43                   	inc    %ebx
  while(s < es && strchr(whitespace, *s))
     881:	39 de                	cmp    %ebx,%esi
     883:	74 17                	je     89c <peek+0x3c>
     885:	0f be 03             	movsbl (%ebx),%eax
     888:	c7 04 24 e0 1b 00 00 	movl   $0x1be0,(%esp)
     88f:	89 44 24 04          	mov    %eax,0x4(%esp)
     893:	e8 28 06 00 00       	call   ec0 <strchr>
     898:	85 c0                	test   %eax,%eax
     89a:	75 e4                	jne    880 <peek+0x20>
  *ps = s;
     89c:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     89e:	31 c0                	xor    %eax,%eax
     8a0:	0f be 13             	movsbl (%ebx),%edx
     8a3:	84 d2                	test   %dl,%dl
     8a5:	74 17                	je     8be <peek+0x5e>
     8a7:	8b 45 10             	mov    0x10(%ebp),%eax
     8aa:	89 54 24 04          	mov    %edx,0x4(%esp)
     8ae:	89 04 24             	mov    %eax,(%esp)
     8b1:	e8 0a 06 00 00       	call   ec0 <strchr>
     8b6:	85 c0                	test   %eax,%eax
     8b8:	0f 95 c0             	setne  %al
     8bb:	0f b6 c0             	movzbl %al,%eax
}
     8be:	83 c4 1c             	add    $0x1c,%esp
     8c1:	5b                   	pop    %ebx
     8c2:	5e                   	pop    %esi
     8c3:	5f                   	pop    %edi
     8c4:	5d                   	pop    %ebp
     8c5:	c3                   	ret    
     8c6:	8d 76 00             	lea    0x0(%esi),%esi
     8c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008d0 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     8d0:	55                   	push   %ebp
     8d1:	89 e5                	mov    %esp,%ebp
     8d3:	57                   	push   %edi
     8d4:	56                   	push   %esi
     8d5:	53                   	push   %ebx
     8d6:	83 ec 3c             	sub    $0x3c,%esp
     8d9:	8b 75 0c             	mov    0xc(%ebp),%esi
     8dc:	8b 5d 10             	mov    0x10(%ebp),%ebx
     8df:	90                   	nop
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     8e0:	b8 68 15 00 00       	mov    $0x1568,%eax
     8e5:	89 44 24 08          	mov    %eax,0x8(%esp)
     8e9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     8ed:	89 34 24             	mov    %esi,(%esp)
     8f0:	e8 6b ff ff ff       	call   860 <peek>
     8f5:	85 c0                	test   %eax,%eax
     8f7:	0f 84 93 00 00 00    	je     990 <parseredirs+0xc0>
    tok = gettoken(ps, es, 0, 0);
     8fd:	31 c0                	xor    %eax,%eax
     8ff:	89 44 24 0c          	mov    %eax,0xc(%esp)
     903:	31 c0                	xor    %eax,%eax
     905:	89 44 24 08          	mov    %eax,0x8(%esp)
     909:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     90d:	89 34 24             	mov    %esi,(%esp)
     910:	e8 eb fd ff ff       	call   700 <gettoken>
    if(gettoken(ps, es, &q, &eq) != 'a')
     915:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     919:	89 34 24             	mov    %esi,(%esp)
    tok = gettoken(ps, es, 0, 0);
     91c:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     91e:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     921:	89 44 24 0c          	mov    %eax,0xc(%esp)
     925:	8d 45 e0             	lea    -0x20(%ebp),%eax
     928:	89 44 24 08          	mov    %eax,0x8(%esp)
     92c:	e8 cf fd ff ff       	call   700 <gettoken>
     931:	83 f8 61             	cmp    $0x61,%eax
     934:	75 65                	jne    99b <parseredirs+0xcb>
      panic("missing file for redirection");
    switch(tok){
     936:	83 ff 3c             	cmp    $0x3c,%edi
     939:	74 45                	je     980 <parseredirs+0xb0>
     93b:	83 ff 3e             	cmp    $0x3e,%edi
     93e:	66 90                	xchg   %ax,%ax
     940:	74 05                	je     947 <parseredirs+0x77>
     942:	83 ff 2b             	cmp    $0x2b,%edi
     945:	75 99                	jne    8e0 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     947:	ba 01 00 00 00       	mov    $0x1,%edx
     94c:	b9 01 02 00 00       	mov    $0x201,%ecx
     951:	89 54 24 10          	mov    %edx,0x10(%esp)
     955:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
     959:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     95c:	89 44 24 08          	mov    %eax,0x8(%esp)
     960:	8b 45 e0             	mov    -0x20(%ebp),%eax
     963:	89 44 24 04          	mov    %eax,0x4(%esp)
     967:	8b 45 08             	mov    0x8(%ebp),%eax
     96a:	89 04 24             	mov    %eax,(%esp)
     96d:	e8 4e fc ff ff       	call   5c0 <redircmd>
     972:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     975:	e9 66 ff ff ff       	jmp    8e0 <parseredirs+0x10>
     97a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     980:	31 ff                	xor    %edi,%edi
     982:	31 c0                	xor    %eax,%eax
     984:	89 7c 24 10          	mov    %edi,0x10(%esp)
     988:	89 44 24 0c          	mov    %eax,0xc(%esp)
     98c:	eb cb                	jmp    959 <parseredirs+0x89>
     98e:	66 90                	xchg   %ax,%ax
    }
  }
  return cmd;
}
     990:	8b 45 08             	mov    0x8(%ebp),%eax
     993:	83 c4 3c             	add    $0x3c,%esp
     996:	5b                   	pop    %ebx
     997:	5e                   	pop    %esi
     998:	5f                   	pop    %edi
     999:	5d                   	pop    %ebp
     99a:	c3                   	ret    
      panic("missing file for redirection");
     99b:	c7 04 24 4b 15 00 00 	movl   $0x154b,(%esp)
     9a2:	e8 d9 f7 ff ff       	call   180 <panic>
     9a7:	89 f6                	mov    %esi,%esi
     9a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009b0 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     9b0:	55                   	push   %ebp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     9b1:	ba 6b 15 00 00       	mov    $0x156b,%edx
{
     9b6:	89 e5                	mov    %esp,%ebp
     9b8:	57                   	push   %edi
     9b9:	56                   	push   %esi
     9ba:	53                   	push   %ebx
     9bb:	83 ec 3c             	sub    $0x3c,%esp
     9be:	8b 75 08             	mov    0x8(%ebp),%esi
     9c1:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(peek(ps, es, "("))
     9c4:	89 54 24 08          	mov    %edx,0x8(%esp)
     9c8:	89 34 24             	mov    %esi,(%esp)
     9cb:	89 7c 24 04          	mov    %edi,0x4(%esp)
     9cf:	e8 8c fe ff ff       	call   860 <peek>
     9d4:	85 c0                	test   %eax,%eax
     9d6:	0f 85 9c 00 00 00    	jne    a78 <parseexec+0xc8>
     9dc:	89 c3                	mov    %eax,%ebx
    return parseblock(ps, es);

  ret = execcmd();
     9de:	e8 9d fb ff ff       	call   580 <execcmd>
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     9e3:	89 7c 24 08          	mov    %edi,0x8(%esp)
     9e7:	89 74 24 04          	mov    %esi,0x4(%esp)
     9eb:	89 04 24             	mov    %eax,(%esp)
  ret = execcmd();
     9ee:	89 45 d0             	mov    %eax,-0x30(%ebp)
  ret = parseredirs(ret, ps, es);
     9f1:	e8 da fe ff ff       	call   8d0 <parseredirs>
     9f6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     9f9:	eb 1b                	jmp    a16 <parseexec+0x66>
     9fb:	90                   	nop
     9fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     a00:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     a03:	89 7c 24 08          	mov    %edi,0x8(%esp)
     a07:	89 74 24 04          	mov    %esi,0x4(%esp)
     a0b:	89 04 24             	mov    %eax,(%esp)
     a0e:	e8 bd fe ff ff       	call   8d0 <parseredirs>
     a13:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     a16:	b8 82 15 00 00       	mov    $0x1582,%eax
     a1b:	89 44 24 08          	mov    %eax,0x8(%esp)
     a1f:	89 7c 24 04          	mov    %edi,0x4(%esp)
     a23:	89 34 24             	mov    %esi,(%esp)
     a26:	e8 35 fe ff ff       	call   860 <peek>
     a2b:	85 c0                	test   %eax,%eax
     a2d:	75 69                	jne    a98 <parseexec+0xe8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     a2f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     a32:	89 44 24 0c          	mov    %eax,0xc(%esp)
     a36:	8d 45 e0             	lea    -0x20(%ebp),%eax
     a39:	89 44 24 08          	mov    %eax,0x8(%esp)
     a3d:	89 7c 24 04          	mov    %edi,0x4(%esp)
     a41:	89 34 24             	mov    %esi,(%esp)
     a44:	e8 b7 fc ff ff       	call   700 <gettoken>
     a49:	85 c0                	test   %eax,%eax
     a4b:	74 4b                	je     a98 <parseexec+0xe8>
    if(tok != 'a')
     a4d:	83 f8 61             	cmp    $0x61,%eax
     a50:	75 65                	jne    ab7 <parseexec+0x107>
    cmd->argv[argc] = q;
     a52:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a55:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a58:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
    cmd->eargv[argc] = eq;
     a5c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a5f:	89 44 9a 2c          	mov    %eax,0x2c(%edx,%ebx,4)
    argc++;
     a63:	43                   	inc    %ebx
    if(argc >= MAXARGS)
     a64:	83 fb 0a             	cmp    $0xa,%ebx
     a67:	75 97                	jne    a00 <parseexec+0x50>
      panic("too many args");
     a69:	c7 04 24 74 15 00 00 	movl   $0x1574,(%esp)
     a70:	e8 0b f7 ff ff       	call   180 <panic>
     a75:	8d 76 00             	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     a78:	89 7c 24 04          	mov    %edi,0x4(%esp)
     a7c:	89 34 24             	mov    %esi,(%esp)
     a7f:	e8 9c 01 00 00       	call   c20 <parseblock>
     a84:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     a87:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     a8a:	83 c4 3c             	add    $0x3c,%esp
     a8d:	5b                   	pop    %ebx
     a8e:	5e                   	pop    %esi
     a8f:	5f                   	pop    %edi
     a90:	5d                   	pop    %ebp
     a91:	c3                   	ret    
     a92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     a98:	8b 45 d0             	mov    -0x30(%ebp),%eax
     a9b:	8d 04 98             	lea    (%eax,%ebx,4),%eax
  cmd->argv[argc] = 0;
     a9e:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  cmd->eargv[argc] = 0;
     aa5:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
}
     aac:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     aaf:	83 c4 3c             	add    $0x3c,%esp
     ab2:	5b                   	pop    %ebx
     ab3:	5e                   	pop    %esi
     ab4:	5f                   	pop    %edi
     ab5:	5d                   	pop    %ebp
     ab6:	c3                   	ret    
      panic("syntax");
     ab7:	c7 04 24 6d 15 00 00 	movl   $0x156d,(%esp)
     abe:	e8 bd f6 ff ff       	call   180 <panic>
     ac3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ad0 <parsepipe>:
{
     ad0:	55                   	push   %ebp
     ad1:	89 e5                	mov    %esp,%ebp
     ad3:	83 ec 28             	sub    $0x28,%esp
     ad6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     ad9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     adc:	89 75 f8             	mov    %esi,-0x8(%ebp)
     adf:	8b 75 0c             	mov    0xc(%ebp),%esi
     ae2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  cmd = parseexec(ps, es);
     ae5:	89 1c 24             	mov    %ebx,(%esp)
     ae8:	89 74 24 04          	mov    %esi,0x4(%esp)
     aec:	e8 bf fe ff ff       	call   9b0 <parseexec>
  if(peek(ps, es, "|")){
     af1:	b9 87 15 00 00       	mov    $0x1587,%ecx
     af6:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     afa:	89 74 24 04          	mov    %esi,0x4(%esp)
     afe:	89 1c 24             	mov    %ebx,(%esp)
  cmd = parseexec(ps, es);
     b01:	89 c7                	mov    %eax,%edi
  if(peek(ps, es, "|")){
     b03:	e8 58 fd ff ff       	call   860 <peek>
     b08:	85 c0                	test   %eax,%eax
     b0a:	75 14                	jne    b20 <parsepipe+0x50>
}
     b0c:	89 f8                	mov    %edi,%eax
     b0e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b11:	8b 75 f8             	mov    -0x8(%ebp),%esi
     b14:	8b 7d fc             	mov    -0x4(%ebp),%edi
     b17:	89 ec                	mov    %ebp,%esp
     b19:	5d                   	pop    %ebp
     b1a:	c3                   	ret    
     b1b:	90                   	nop
     b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    gettoken(ps, es, 0, 0);
     b20:	31 d2                	xor    %edx,%edx
     b22:	31 c0                	xor    %eax,%eax
     b24:	89 54 24 08          	mov    %edx,0x8(%esp)
     b28:	89 74 24 04          	mov    %esi,0x4(%esp)
     b2c:	89 1c 24             	mov    %ebx,(%esp)
     b2f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     b33:	e8 c8 fb ff ff       	call   700 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     b38:	89 74 24 04          	mov    %esi,0x4(%esp)
     b3c:	89 1c 24             	mov    %ebx,(%esp)
     b3f:	e8 8c ff ff ff       	call   ad0 <parsepipe>
}
     b44:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    cmd = pipecmd(cmd, parsepipe(ps, es));
     b47:	89 7d 08             	mov    %edi,0x8(%ebp)
}
     b4a:	8b 75 f8             	mov    -0x8(%ebp),%esi
     b4d:	8b 7d fc             	mov    -0x4(%ebp),%edi
    cmd = pipecmd(cmd, parsepipe(ps, es));
     b50:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     b53:	89 ec                	mov    %ebp,%esp
     b55:	5d                   	pop    %ebp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     b56:	e9 c5 fa ff ff       	jmp    620 <pipecmd>
     b5b:	90                   	nop
     b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000b60 <parseline>:
{
     b60:	55                   	push   %ebp
     b61:	89 e5                	mov    %esp,%ebp
     b63:	57                   	push   %edi
     b64:	56                   	push   %esi
     b65:	53                   	push   %ebx
     b66:	83 ec 1c             	sub    $0x1c,%esp
     b69:	8b 5d 08             	mov    0x8(%ebp),%ebx
     b6c:	8b 75 0c             	mov    0xc(%ebp),%esi
  cmd = parsepipe(ps, es);
     b6f:	89 1c 24             	mov    %ebx,(%esp)
     b72:	89 74 24 04          	mov    %esi,0x4(%esp)
     b76:	e8 55 ff ff ff       	call   ad0 <parsepipe>
     b7b:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     b7d:	eb 23                	jmp    ba2 <parseline+0x42>
     b7f:	90                   	nop
    gettoken(ps, es, 0, 0);
     b80:	31 c0                	xor    %eax,%eax
     b82:	89 44 24 0c          	mov    %eax,0xc(%esp)
     b86:	31 c0                	xor    %eax,%eax
     b88:	89 44 24 08          	mov    %eax,0x8(%esp)
     b8c:	89 74 24 04          	mov    %esi,0x4(%esp)
     b90:	89 1c 24             	mov    %ebx,(%esp)
     b93:	e8 68 fb ff ff       	call   700 <gettoken>
    cmd = backcmd(cmd);
     b98:	89 3c 24             	mov    %edi,(%esp)
     b9b:	e8 20 fb ff ff       	call   6c0 <backcmd>
     ba0:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     ba2:	b8 89 15 00 00       	mov    $0x1589,%eax
     ba7:	89 44 24 08          	mov    %eax,0x8(%esp)
     bab:	89 74 24 04          	mov    %esi,0x4(%esp)
     baf:	89 1c 24             	mov    %ebx,(%esp)
     bb2:	e8 a9 fc ff ff       	call   860 <peek>
     bb7:	85 c0                	test   %eax,%eax
     bb9:	75 c5                	jne    b80 <parseline+0x20>
  if(peek(ps, es, ";")){
     bbb:	b9 85 15 00 00       	mov    $0x1585,%ecx
     bc0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     bc4:	89 74 24 04          	mov    %esi,0x4(%esp)
     bc8:	89 1c 24             	mov    %ebx,(%esp)
     bcb:	e8 90 fc ff ff       	call   860 <peek>
     bd0:	85 c0                	test   %eax,%eax
     bd2:	75 0c                	jne    be0 <parseline+0x80>
}
     bd4:	83 c4 1c             	add    $0x1c,%esp
     bd7:	89 f8                	mov    %edi,%eax
     bd9:	5b                   	pop    %ebx
     bda:	5e                   	pop    %esi
     bdb:	5f                   	pop    %edi
     bdc:	5d                   	pop    %ebp
     bdd:	c3                   	ret    
     bde:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     be0:	31 d2                	xor    %edx,%edx
     be2:	31 c0                	xor    %eax,%eax
     be4:	89 54 24 08          	mov    %edx,0x8(%esp)
     be8:	89 74 24 04          	mov    %esi,0x4(%esp)
     bec:	89 1c 24             	mov    %ebx,(%esp)
     bef:	89 44 24 0c          	mov    %eax,0xc(%esp)
     bf3:	e8 08 fb ff ff       	call   700 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     bf8:	89 74 24 04          	mov    %esi,0x4(%esp)
     bfc:	89 1c 24             	mov    %ebx,(%esp)
     bff:	e8 5c ff ff ff       	call   b60 <parseline>
     c04:	89 7d 08             	mov    %edi,0x8(%ebp)
     c07:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     c0a:	83 c4 1c             	add    $0x1c,%esp
     c0d:	5b                   	pop    %ebx
     c0e:	5e                   	pop    %esi
     c0f:	5f                   	pop    %edi
     c10:	5d                   	pop    %ebp
    cmd = listcmd(cmd, parseline(ps, es));
     c11:	e9 5a fa ff ff       	jmp    670 <listcmd>
     c16:	8d 76 00             	lea    0x0(%esi),%esi
     c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c20 <parseblock>:
{
     c20:	55                   	push   %ebp
  if(!peek(ps, es, "("))
     c21:	b8 6b 15 00 00       	mov    $0x156b,%eax
{
     c26:	89 e5                	mov    %esp,%ebp
     c28:	83 ec 28             	sub    $0x28,%esp
     c2b:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     c2e:	8b 5d 08             	mov    0x8(%ebp),%ebx
     c31:	89 75 f8             	mov    %esi,-0x8(%ebp)
     c34:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     c37:	89 44 24 08          	mov    %eax,0x8(%esp)
{
     c3b:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(!peek(ps, es, "("))
     c3e:	89 1c 24             	mov    %ebx,(%esp)
     c41:	89 74 24 04          	mov    %esi,0x4(%esp)
     c45:	e8 16 fc ff ff       	call   860 <peek>
     c4a:	85 c0                	test   %eax,%eax
     c4c:	74 74                	je     cc2 <parseblock+0xa2>
  gettoken(ps, es, 0, 0);
     c4e:	31 c9                	xor    %ecx,%ecx
     c50:	31 ff                	xor    %edi,%edi
     c52:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
     c56:	89 7c 24 08          	mov    %edi,0x8(%esp)
     c5a:	89 74 24 04          	mov    %esi,0x4(%esp)
     c5e:	89 1c 24             	mov    %ebx,(%esp)
     c61:	e8 9a fa ff ff       	call   700 <gettoken>
  cmd = parseline(ps, es);
     c66:	89 74 24 04          	mov    %esi,0x4(%esp)
     c6a:	89 1c 24             	mov    %ebx,(%esp)
     c6d:	e8 ee fe ff ff       	call   b60 <parseline>
  if(!peek(ps, es, ")"))
     c72:	89 74 24 04          	mov    %esi,0x4(%esp)
     c76:	89 1c 24             	mov    %ebx,(%esp)
  cmd = parseline(ps, es);
     c79:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     c7b:	b8 a7 15 00 00       	mov    $0x15a7,%eax
     c80:	89 44 24 08          	mov    %eax,0x8(%esp)
     c84:	e8 d7 fb ff ff       	call   860 <peek>
     c89:	85 c0                	test   %eax,%eax
     c8b:	74 41                	je     cce <parseblock+0xae>
  gettoken(ps, es, 0, 0);
     c8d:	31 d2                	xor    %edx,%edx
     c8f:	31 c0                	xor    %eax,%eax
     c91:	89 54 24 08          	mov    %edx,0x8(%esp)
     c95:	89 74 24 04          	mov    %esi,0x4(%esp)
     c99:	89 1c 24             	mov    %ebx,(%esp)
     c9c:	89 44 24 0c          	mov    %eax,0xc(%esp)
     ca0:	e8 5b fa ff ff       	call   700 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     ca5:	89 74 24 08          	mov    %esi,0x8(%esp)
     ca9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     cad:	89 3c 24             	mov    %edi,(%esp)
     cb0:	e8 1b fc ff ff       	call   8d0 <parseredirs>
}
     cb5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     cb8:	8b 75 f8             	mov    -0x8(%ebp),%esi
     cbb:	8b 7d fc             	mov    -0x4(%ebp),%edi
     cbe:	89 ec                	mov    %ebp,%esp
     cc0:	5d                   	pop    %ebp
     cc1:	c3                   	ret    
    panic("parseblock");
     cc2:	c7 04 24 8b 15 00 00 	movl   $0x158b,(%esp)
     cc9:	e8 b2 f4 ff ff       	call   180 <panic>
    panic("syntax - missing )");
     cce:	c7 04 24 96 15 00 00 	movl   $0x1596,(%esp)
     cd5:	e8 a6 f4 ff ff       	call   180 <panic>
     cda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000ce0 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     ce0:	55                   	push   %ebp
     ce1:	89 e5                	mov    %esp,%ebp
     ce3:	53                   	push   %ebx
     ce4:	83 ec 14             	sub    $0x14,%esp
     ce7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     cea:	85 db                	test   %ebx,%ebx
     cec:	74 1d                	je     d0b <nulterminate+0x2b>
    return 0;

  switch(cmd->type){
     cee:	83 3b 05             	cmpl   $0x5,(%ebx)
     cf1:	77 18                	ja     d0b <nulterminate+0x2b>
     cf3:	8b 03                	mov    (%ebx),%eax
     cf5:	ff 24 85 08 16 00 00 	jmp    *0x1608(,%eax,4)
     cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
     d00:	8b 43 04             	mov    0x4(%ebx),%eax
     d03:	89 04 24             	mov    %eax,(%esp)
     d06:	e8 d5 ff ff ff       	call   ce0 <nulterminate>
    break;
  }
  return cmd;
}
     d0b:	83 c4 14             	add    $0x14,%esp
     d0e:	89 d8                	mov    %ebx,%eax
     d10:	5b                   	pop    %ebx
     d11:	5d                   	pop    %ebp
     d12:	c3                   	ret    
     d13:	90                   	nop
     d14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(lcmd->left);
     d18:	8b 43 04             	mov    0x4(%ebx),%eax
     d1b:	89 04 24             	mov    %eax,(%esp)
     d1e:	e8 bd ff ff ff       	call   ce0 <nulterminate>
    nulterminate(lcmd->right);
     d23:	8b 43 08             	mov    0x8(%ebx),%eax
     d26:	89 04 24             	mov    %eax,(%esp)
     d29:	e8 b2 ff ff ff       	call   ce0 <nulterminate>
}
     d2e:	83 c4 14             	add    $0x14,%esp
     d31:	89 d8                	mov    %ebx,%eax
     d33:	5b                   	pop    %ebx
     d34:	5d                   	pop    %ebp
     d35:	c3                   	ret    
     d36:	8d 76 00             	lea    0x0(%esi),%esi
     d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for(i=0; ecmd->argv[i]; i++)
     d40:	8b 4b 04             	mov    0x4(%ebx),%ecx
     d43:	8d 43 08             	lea    0x8(%ebx),%eax
     d46:	85 c9                	test   %ecx,%ecx
     d48:	74 c1                	je     d0b <nulterminate+0x2b>
     d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     d50:	8b 50 24             	mov    0x24(%eax),%edx
     d53:	83 c0 04             	add    $0x4,%eax
     d56:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     d59:	8b 50 fc             	mov    -0x4(%eax),%edx
     d5c:	85 d2                	test   %edx,%edx
     d5e:	75 f0                	jne    d50 <nulterminate+0x70>
}
     d60:	83 c4 14             	add    $0x14,%esp
     d63:	89 d8                	mov    %ebx,%eax
     d65:	5b                   	pop    %ebx
     d66:	5d                   	pop    %ebp
     d67:	c3                   	ret    
     d68:	90                   	nop
     d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(rcmd->cmd);
     d70:	8b 43 04             	mov    0x4(%ebx),%eax
     d73:	89 04 24             	mov    %eax,(%esp)
     d76:	e8 65 ff ff ff       	call   ce0 <nulterminate>
    *rcmd->efile = 0;
     d7b:	8b 43 0c             	mov    0xc(%ebx),%eax
     d7e:	c6 00 00             	movb   $0x0,(%eax)
}
     d81:	83 c4 14             	add    $0x14,%esp
     d84:	89 d8                	mov    %ebx,%eax
     d86:	5b                   	pop    %ebx
     d87:	5d                   	pop    %ebp
     d88:	c3                   	ret    
     d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d90 <parsecmd>:
{
     d90:	55                   	push   %ebp
     d91:	89 e5                	mov    %esp,%ebp
     d93:	56                   	push   %esi
     d94:	53                   	push   %ebx
     d95:	83 ec 10             	sub    $0x10,%esp
  es = s + strlen(s);
     d98:	8b 5d 08             	mov    0x8(%ebp),%ebx
     d9b:	89 1c 24             	mov    %ebx,(%esp)
     d9e:	e8 cd 00 00 00       	call   e70 <strlen>
     da3:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     da5:	8d 45 08             	lea    0x8(%ebp),%eax
     da8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     dac:	89 04 24             	mov    %eax,(%esp)
     daf:	e8 ac fd ff ff       	call   b60 <parseline>
  peek(&s, es, "");
     db4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  cmd = parseline(&s, es);
     db8:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     dba:	b8 30 15 00 00       	mov    $0x1530,%eax
     dbf:	89 44 24 08          	mov    %eax,0x8(%esp)
     dc3:	8d 45 08             	lea    0x8(%ebp),%eax
     dc6:	89 04 24             	mov    %eax,(%esp)
     dc9:	e8 92 fa ff ff       	call   860 <peek>
  if(s != es){
     dce:	8b 45 08             	mov    0x8(%ebp),%eax
     dd1:	39 d8                	cmp    %ebx,%eax
     dd3:	75 11                	jne    de6 <parsecmd+0x56>
  nulterminate(cmd);
     dd5:	89 34 24             	mov    %esi,(%esp)
     dd8:	e8 03 ff ff ff       	call   ce0 <nulterminate>
}
     ddd:	83 c4 10             	add    $0x10,%esp
     de0:	89 f0                	mov    %esi,%eax
     de2:	5b                   	pop    %ebx
     de3:	5e                   	pop    %esi
     de4:	5d                   	pop    %ebp
     de5:	c3                   	ret    
    printf(2, "leftovers: %s\n", s);
     de6:	89 44 24 08          	mov    %eax,0x8(%esp)
     dea:	c7 44 24 04 a9 15 00 	movl   $0x15a9,0x4(%esp)
     df1:	00 
     df2:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     df9:	e8 92 03 00 00       	call   1190 <printf>
    panic("syntax");
     dfe:	c7 04 24 6d 15 00 00 	movl   $0x156d,(%esp)
     e05:	e8 76 f3 ff ff       	call   180 <panic>
     e0a:	66 90                	xchg   %ax,%ax
     e0c:	66 90                	xchg   %ax,%ax
     e0e:	66 90                	xchg   %ax,%ax

00000e10 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     e10:	55                   	push   %ebp
     e11:	89 e5                	mov    %esp,%ebp
     e13:	8b 45 08             	mov    0x8(%ebp),%eax
     e16:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     e19:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     e1a:	89 c2                	mov    %eax,%edx
     e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e20:	41                   	inc    %ecx
     e21:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     e25:	42                   	inc    %edx
     e26:	84 db                	test   %bl,%bl
     e28:	88 5a ff             	mov    %bl,-0x1(%edx)
     e2b:	75 f3                	jne    e20 <strcpy+0x10>
    ;
  return os;
}
     e2d:	5b                   	pop    %ebx
     e2e:	5d                   	pop    %ebp
     e2f:	c3                   	ret    

00000e30 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     e30:	55                   	push   %ebp
     e31:	89 e5                	mov    %esp,%ebp
     e33:	8b 4d 08             	mov    0x8(%ebp),%ecx
     e36:	53                   	push   %ebx
     e37:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
     e3a:	0f b6 01             	movzbl (%ecx),%eax
     e3d:	0f b6 13             	movzbl (%ebx),%edx
     e40:	84 c0                	test   %al,%al
     e42:	75 18                	jne    e5c <strcmp+0x2c>
     e44:	eb 22                	jmp    e68 <strcmp+0x38>
     e46:	8d 76 00             	lea    0x0(%esi),%esi
     e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     e50:	41                   	inc    %ecx
  while(*p && *p == *q)
     e51:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
     e54:	43                   	inc    %ebx
     e55:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
     e58:	84 c0                	test   %al,%al
     e5a:	74 0c                	je     e68 <strcmp+0x38>
     e5c:	38 d0                	cmp    %dl,%al
     e5e:	74 f0                	je     e50 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
     e60:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
     e61:	29 d0                	sub    %edx,%eax
}
     e63:	5d                   	pop    %ebp
     e64:	c3                   	ret    
     e65:	8d 76 00             	lea    0x0(%esi),%esi
     e68:	5b                   	pop    %ebx
     e69:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     e6b:	29 d0                	sub    %edx,%eax
}
     e6d:	5d                   	pop    %ebp
     e6e:	c3                   	ret    
     e6f:	90                   	nop

00000e70 <strlen>:

uint
strlen(const char *s)
{
     e70:	55                   	push   %ebp
     e71:	89 e5                	mov    %esp,%ebp
     e73:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     e76:	80 39 00             	cmpb   $0x0,(%ecx)
     e79:	74 15                	je     e90 <strlen+0x20>
     e7b:	31 d2                	xor    %edx,%edx
     e7d:	8d 76 00             	lea    0x0(%esi),%esi
     e80:	42                   	inc    %edx
     e81:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     e85:	89 d0                	mov    %edx,%eax
     e87:	75 f7                	jne    e80 <strlen+0x10>
    ;
  return n;
}
     e89:	5d                   	pop    %ebp
     e8a:	c3                   	ret    
     e8b:	90                   	nop
     e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
     e90:	31 c0                	xor    %eax,%eax
}
     e92:	5d                   	pop    %ebp
     e93:	c3                   	ret    
     e94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000ea0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     ea0:	55                   	push   %ebp
     ea1:	89 e5                	mov    %esp,%ebp
     ea3:	8b 55 08             	mov    0x8(%ebp),%edx
     ea6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     ea7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     eaa:	8b 45 0c             	mov    0xc(%ebp),%eax
     ead:	89 d7                	mov    %edx,%edi
     eaf:	fc                   	cld    
     eb0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     eb2:	5f                   	pop    %edi
     eb3:	89 d0                	mov    %edx,%eax
     eb5:	5d                   	pop    %ebp
     eb6:	c3                   	ret    
     eb7:	89 f6                	mov    %esi,%esi
     eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ec0 <strchr>:

char*
strchr(const char *s, char c)
{
     ec0:	55                   	push   %ebp
     ec1:	89 e5                	mov    %esp,%ebp
     ec3:	8b 45 08             	mov    0x8(%ebp),%eax
     ec6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     eca:	0f b6 10             	movzbl (%eax),%edx
     ecd:	84 d2                	test   %dl,%dl
     ecf:	74 1b                	je     eec <strchr+0x2c>
    if(*s == c)
     ed1:	38 d1                	cmp    %dl,%cl
     ed3:	75 0f                	jne    ee4 <strchr+0x24>
     ed5:	eb 17                	jmp    eee <strchr+0x2e>
     ed7:	89 f6                	mov    %esi,%esi
     ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     ee0:	38 ca                	cmp    %cl,%dl
     ee2:	74 0a                	je     eee <strchr+0x2e>
  for(; *s; s++)
     ee4:	40                   	inc    %eax
     ee5:	0f b6 10             	movzbl (%eax),%edx
     ee8:	84 d2                	test   %dl,%dl
     eea:	75 f4                	jne    ee0 <strchr+0x20>
      return (char*)s;
  return 0;
     eec:	31 c0                	xor    %eax,%eax
}
     eee:	5d                   	pop    %ebp
     eef:	c3                   	ret    

00000ef0 <gets>:

char*
gets(char *buf, int max)
{
     ef0:	55                   	push   %ebp
     ef1:	89 e5                	mov    %esp,%ebp
     ef3:	57                   	push   %edi
     ef4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     ef5:	31 f6                	xor    %esi,%esi
{
     ef7:	53                   	push   %ebx
     ef8:	83 ec 3c             	sub    $0x3c,%esp
     efb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
     efe:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
     f01:	eb 32                	jmp    f35 <gets+0x45>
     f03:	90                   	nop
     f04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
     f08:	ba 01 00 00 00       	mov    $0x1,%edx
     f0d:	89 54 24 08          	mov    %edx,0x8(%esp)
     f11:	89 7c 24 04          	mov    %edi,0x4(%esp)
     f15:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     f1c:	e8 2f 01 00 00       	call   1050 <read>
    if(cc < 1)
     f21:	85 c0                	test   %eax,%eax
     f23:	7e 19                	jle    f3e <gets+0x4e>
      break;
    buf[i++] = c;
     f25:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     f29:	43                   	inc    %ebx
     f2a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
     f2d:	3c 0a                	cmp    $0xa,%al
     f2f:	74 1f                	je     f50 <gets+0x60>
     f31:	3c 0d                	cmp    $0xd,%al
     f33:	74 1b                	je     f50 <gets+0x60>
  for(i=0; i+1 < max; ){
     f35:	46                   	inc    %esi
     f36:	3b 75 0c             	cmp    0xc(%ebp),%esi
     f39:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
     f3c:	7c ca                	jl     f08 <gets+0x18>
      break;
  }
  buf[i] = '\0';
     f3e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     f41:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
     f44:	8b 45 08             	mov    0x8(%ebp),%eax
     f47:	83 c4 3c             	add    $0x3c,%esp
     f4a:	5b                   	pop    %ebx
     f4b:	5e                   	pop    %esi
     f4c:	5f                   	pop    %edi
     f4d:	5d                   	pop    %ebp
     f4e:	c3                   	ret    
     f4f:	90                   	nop
     f50:	8b 45 08             	mov    0x8(%ebp),%eax
     f53:	01 c6                	add    %eax,%esi
     f55:	89 75 d4             	mov    %esi,-0x2c(%ebp)
     f58:	eb e4                	jmp    f3e <gets+0x4e>
     f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000f60 <stat>:

int
stat(const char *n, struct stat *st)
{
     f60:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     f61:	31 c0                	xor    %eax,%eax
{
     f63:	89 e5                	mov    %esp,%ebp
     f65:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
     f68:	89 44 24 04          	mov    %eax,0x4(%esp)
     f6c:	8b 45 08             	mov    0x8(%ebp),%eax
{
     f6f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     f72:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
     f75:	89 04 24             	mov    %eax,(%esp)
     f78:	e8 fb 00 00 00       	call   1078 <open>
  if(fd < 0)
     f7d:	85 c0                	test   %eax,%eax
     f7f:	78 2f                	js     fb0 <stat+0x50>
     f81:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
     f83:	8b 45 0c             	mov    0xc(%ebp),%eax
     f86:	89 1c 24             	mov    %ebx,(%esp)
     f89:	89 44 24 04          	mov    %eax,0x4(%esp)
     f8d:	e8 fe 00 00 00       	call   1090 <fstat>
  close(fd);
     f92:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     f95:	89 c6                	mov    %eax,%esi
  close(fd);
     f97:	e8 c4 00 00 00       	call   1060 <close>
  return r;
}
     f9c:	89 f0                	mov    %esi,%eax
     f9e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
     fa1:	8b 75 fc             	mov    -0x4(%ebp),%esi
     fa4:	89 ec                	mov    %ebp,%esp
     fa6:	5d                   	pop    %ebp
     fa7:	c3                   	ret    
     fa8:	90                   	nop
     fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
     fb0:	be ff ff ff ff       	mov    $0xffffffff,%esi
     fb5:	eb e5                	jmp    f9c <stat+0x3c>
     fb7:	89 f6                	mov    %esi,%esi
     fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000fc0 <atoi>:

int
atoi(const char *s)
{
     fc0:	55                   	push   %ebp
     fc1:	89 e5                	mov    %esp,%ebp
     fc3:	8b 4d 08             	mov    0x8(%ebp),%ecx
     fc6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     fc7:	0f be 11             	movsbl (%ecx),%edx
     fca:	88 d0                	mov    %dl,%al
     fcc:	2c 30                	sub    $0x30,%al
     fce:	3c 09                	cmp    $0x9,%al
  n = 0;
     fd0:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
     fd5:	77 1e                	ja     ff5 <atoi+0x35>
     fd7:	89 f6                	mov    %esi,%esi
     fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
     fe0:	41                   	inc    %ecx
     fe1:	8d 04 80             	lea    (%eax,%eax,4),%eax
     fe4:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
     fe8:	0f be 11             	movsbl (%ecx),%edx
     feb:	88 d3                	mov    %dl,%bl
     fed:	80 eb 30             	sub    $0x30,%bl
     ff0:	80 fb 09             	cmp    $0x9,%bl
     ff3:	76 eb                	jbe    fe0 <atoi+0x20>
  return n;
}
     ff5:	5b                   	pop    %ebx
     ff6:	5d                   	pop    %ebp
     ff7:	c3                   	ret    
     ff8:	90                   	nop
     ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001000 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	56                   	push   %esi
    1004:	8b 45 08             	mov    0x8(%ebp),%eax
    1007:	53                   	push   %ebx
    1008:	8b 5d 10             	mov    0x10(%ebp),%ebx
    100b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    100e:	85 db                	test   %ebx,%ebx
    1010:	7e 1a                	jle    102c <memmove+0x2c>
    1012:	31 d2                	xor    %edx,%edx
    1014:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    101a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
    1020:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    1024:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    1027:	42                   	inc    %edx
  while(n-- > 0)
    1028:	39 d3                	cmp    %edx,%ebx
    102a:	75 f4                	jne    1020 <memmove+0x20>
  return vdst;
}
    102c:	5b                   	pop    %ebx
    102d:	5e                   	pop    %esi
    102e:	5d                   	pop    %ebp
    102f:	c3                   	ret    

00001030 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1030:	b8 01 00 00 00       	mov    $0x1,%eax
    1035:	cd 40                	int    $0x40
    1037:	c3                   	ret    

00001038 <exit>:
SYSCALL(exit)
    1038:	b8 02 00 00 00       	mov    $0x2,%eax
    103d:	cd 40                	int    $0x40
    103f:	c3                   	ret    

00001040 <wait>:
SYSCALL(wait)
    1040:	b8 03 00 00 00       	mov    $0x3,%eax
    1045:	cd 40                	int    $0x40
    1047:	c3                   	ret    

00001048 <pipe>:
SYSCALL(pipe)
    1048:	b8 04 00 00 00       	mov    $0x4,%eax
    104d:	cd 40                	int    $0x40
    104f:	c3                   	ret    

00001050 <read>:
SYSCALL(read)
    1050:	b8 05 00 00 00       	mov    $0x5,%eax
    1055:	cd 40                	int    $0x40
    1057:	c3                   	ret    

00001058 <write>:
SYSCALL(write)
    1058:	b8 10 00 00 00       	mov    $0x10,%eax
    105d:	cd 40                	int    $0x40
    105f:	c3                   	ret    

00001060 <close>:
SYSCALL(close)
    1060:	b8 15 00 00 00       	mov    $0x15,%eax
    1065:	cd 40                	int    $0x40
    1067:	c3                   	ret    

00001068 <kill>:
SYSCALL(kill)
    1068:	b8 06 00 00 00       	mov    $0x6,%eax
    106d:	cd 40                	int    $0x40
    106f:	c3                   	ret    

00001070 <exec>:
SYSCALL(exec)
    1070:	b8 07 00 00 00       	mov    $0x7,%eax
    1075:	cd 40                	int    $0x40
    1077:	c3                   	ret    

00001078 <open>:
SYSCALL(open)
    1078:	b8 0f 00 00 00       	mov    $0xf,%eax
    107d:	cd 40                	int    $0x40
    107f:	c3                   	ret    

00001080 <mknod>:
SYSCALL(mknod)
    1080:	b8 11 00 00 00       	mov    $0x11,%eax
    1085:	cd 40                	int    $0x40
    1087:	c3                   	ret    

00001088 <unlink>:
SYSCALL(unlink)
    1088:	b8 12 00 00 00       	mov    $0x12,%eax
    108d:	cd 40                	int    $0x40
    108f:	c3                   	ret    

00001090 <fstat>:
SYSCALL(fstat)
    1090:	b8 08 00 00 00       	mov    $0x8,%eax
    1095:	cd 40                	int    $0x40
    1097:	c3                   	ret    

00001098 <link>:
SYSCALL(link)
    1098:	b8 13 00 00 00       	mov    $0x13,%eax
    109d:	cd 40                	int    $0x40
    109f:	c3                   	ret    

000010a0 <mkdir>:
SYSCALL(mkdir)
    10a0:	b8 14 00 00 00       	mov    $0x14,%eax
    10a5:	cd 40                	int    $0x40
    10a7:	c3                   	ret    

000010a8 <chdir>:
SYSCALL(chdir)
    10a8:	b8 09 00 00 00       	mov    $0x9,%eax
    10ad:	cd 40                	int    $0x40
    10af:	c3                   	ret    

000010b0 <dup>:
SYSCALL(dup)
    10b0:	b8 0a 00 00 00       	mov    $0xa,%eax
    10b5:	cd 40                	int    $0x40
    10b7:	c3                   	ret    

000010b8 <getpid>:
SYSCALL(getpid)
    10b8:	b8 0b 00 00 00       	mov    $0xb,%eax
    10bd:	cd 40                	int    $0x40
    10bf:	c3                   	ret    

000010c0 <sbrk>:
SYSCALL(sbrk)
    10c0:	b8 0c 00 00 00       	mov    $0xc,%eax
    10c5:	cd 40                	int    $0x40
    10c7:	c3                   	ret    

000010c8 <sleep>:
SYSCALL(sleep)
    10c8:	b8 0d 00 00 00       	mov    $0xd,%eax
    10cd:	cd 40                	int    $0x40
    10cf:	c3                   	ret    

000010d0 <uptime>:
SYSCALL(uptime)
    10d0:	b8 0e 00 00 00       	mov    $0xe,%eax
    10d5:	cd 40                	int    $0x40
    10d7:	c3                   	ret    

000010d8 <detach>:
SYSCALL(detach)
    10d8:	b8 16 00 00 00       	mov    $0x16,%eax
    10dd:	cd 40                	int    $0x40
    10df:	c3                   	ret    

000010e0 <priority>:
SYSCALL(priority)
    10e0:	b8 17 00 00 00       	mov    $0x17,%eax
    10e5:	cd 40                	int    $0x40
    10e7:	c3                   	ret    
    10e8:	66 90                	xchg   %ax,%ax
    10ea:	66 90                	xchg   %ax,%ax
    10ec:	66 90                	xchg   %ax,%ax
    10ee:	66 90                	xchg   %ax,%ax

000010f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    10f0:	55                   	push   %ebp
    10f1:	89 e5                	mov    %esp,%ebp
    10f3:	57                   	push   %edi
    10f4:	56                   	push   %esi
    10f5:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    10f6:	89 d3                	mov    %edx,%ebx
    10f8:	c1 eb 1f             	shr    $0x1f,%ebx
{
    10fb:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
    10fe:	84 db                	test   %bl,%bl
{
    1100:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1103:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    1105:	74 79                	je     1180 <printint+0x90>
    1107:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    110b:	74 73                	je     1180 <printint+0x90>
    neg = 1;
    x = -xx;
    110d:	f7 d8                	neg    %eax
    neg = 1;
    110f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1116:	31 f6                	xor    %esi,%esi
    1118:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    111b:	eb 05                	jmp    1122 <printint+0x32>
    111d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1120:	89 fe                	mov    %edi,%esi
    1122:	31 d2                	xor    %edx,%edx
    1124:	f7 f1                	div    %ecx
    1126:	8d 7e 01             	lea    0x1(%esi),%edi
    1129:	0f b6 92 28 16 00 00 	movzbl 0x1628(%edx),%edx
  }while((x /= base) != 0);
    1130:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    1132:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    1135:	75 e9                	jne    1120 <printint+0x30>
  if(neg)
    1137:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    113a:	85 d2                	test   %edx,%edx
    113c:	74 08                	je     1146 <printint+0x56>
    buf[i++] = '-';
    113e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    1143:	8d 7e 02             	lea    0x2(%esi),%edi
    1146:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    114a:	8b 7d c0             	mov    -0x40(%ebp),%edi
    114d:	8d 76 00             	lea    0x0(%esi),%esi
    1150:	0f b6 06             	movzbl (%esi),%eax
    1153:	4e                   	dec    %esi
  write(fd, &c, 1);
    1154:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    1158:	89 3c 24             	mov    %edi,(%esp)
    115b:	88 45 d7             	mov    %al,-0x29(%ebp)
    115e:	b8 01 00 00 00       	mov    $0x1,%eax
    1163:	89 44 24 08          	mov    %eax,0x8(%esp)
    1167:	e8 ec fe ff ff       	call   1058 <write>

  while(--i >= 0)
    116c:	39 de                	cmp    %ebx,%esi
    116e:	75 e0                	jne    1150 <printint+0x60>
    putc(fd, buf[i]);
}
    1170:	83 c4 4c             	add    $0x4c,%esp
    1173:	5b                   	pop    %ebx
    1174:	5e                   	pop    %esi
    1175:	5f                   	pop    %edi
    1176:	5d                   	pop    %ebp
    1177:	c3                   	ret    
    1178:	90                   	nop
    1179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1180:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1187:	eb 8d                	jmp    1116 <printint+0x26>
    1189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001190 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1190:	55                   	push   %ebp
    1191:	89 e5                	mov    %esp,%ebp
    1193:	57                   	push   %edi
    1194:	56                   	push   %esi
    1195:	53                   	push   %ebx
    1196:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1199:	8b 75 0c             	mov    0xc(%ebp),%esi
    119c:	0f b6 1e             	movzbl (%esi),%ebx
    119f:	84 db                	test   %bl,%bl
    11a1:	0f 84 d1 00 00 00    	je     1278 <printf+0xe8>
  state = 0;
    11a7:	31 ff                	xor    %edi,%edi
    11a9:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
    11aa:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
    11ad:	89 fa                	mov    %edi,%edx
    11af:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
    11b2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    11b5:	eb 41                	jmp    11f8 <printf+0x68>
    11b7:	89 f6                	mov    %esi,%esi
    11b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    11c0:	83 f8 25             	cmp    $0x25,%eax
    11c3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
    11c6:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    11cb:	74 1e                	je     11eb <printf+0x5b>
  write(fd, &c, 1);
    11cd:	b8 01 00 00 00       	mov    $0x1,%eax
    11d2:	89 44 24 08          	mov    %eax,0x8(%esp)
    11d6:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    11d9:	89 44 24 04          	mov    %eax,0x4(%esp)
    11dd:	89 3c 24             	mov    %edi,(%esp)
    11e0:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    11e3:	e8 70 fe ff ff       	call   1058 <write>
    11e8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    11eb:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
    11ec:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    11f0:	84 db                	test   %bl,%bl
    11f2:	0f 84 80 00 00 00    	je     1278 <printf+0xe8>
    if(state == 0){
    11f8:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
    11fa:	0f be cb             	movsbl %bl,%ecx
    11fd:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1200:	74 be                	je     11c0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1202:	83 fa 25             	cmp    $0x25,%edx
    1205:	75 e4                	jne    11eb <printf+0x5b>
      if(c == 'd'){
    1207:	83 f8 64             	cmp    $0x64,%eax
    120a:	0f 84 f0 00 00 00    	je     1300 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1210:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    1216:	83 f9 70             	cmp    $0x70,%ecx
    1219:	74 65                	je     1280 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    121b:	83 f8 73             	cmp    $0x73,%eax
    121e:	0f 84 8c 00 00 00    	je     12b0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1224:	83 f8 63             	cmp    $0x63,%eax
    1227:	0f 84 13 01 00 00    	je     1340 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    122d:	83 f8 25             	cmp    $0x25,%eax
    1230:	0f 84 e2 00 00 00    	je     1318 <printf+0x188>
  write(fd, &c, 1);
    1236:	b8 01 00 00 00       	mov    $0x1,%eax
    123b:	46                   	inc    %esi
    123c:	89 44 24 08          	mov    %eax,0x8(%esp)
    1240:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1243:	89 44 24 04          	mov    %eax,0x4(%esp)
    1247:	89 3c 24             	mov    %edi,(%esp)
    124a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    124e:	e8 05 fe ff ff       	call   1058 <write>
    1253:	ba 01 00 00 00       	mov    $0x1,%edx
    1258:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    125b:	89 54 24 08          	mov    %edx,0x8(%esp)
    125f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1263:	89 3c 24             	mov    %edi,(%esp)
    1266:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    1269:	e8 ea fd ff ff       	call   1058 <write>
  for(i = 0; fmt[i]; i++){
    126e:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1272:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    1274:	84 db                	test   %bl,%bl
    1276:	75 80                	jne    11f8 <printf+0x68>
    }
  }
}
    1278:	83 c4 3c             	add    $0x3c,%esp
    127b:	5b                   	pop    %ebx
    127c:	5e                   	pop    %esi
    127d:	5f                   	pop    %edi
    127e:	5d                   	pop    %ebp
    127f:	c3                   	ret    
        printint(fd, *ap, 16, 0);
    1280:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1287:	b9 10 00 00 00       	mov    $0x10,%ecx
    128c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    128f:	89 f8                	mov    %edi,%eax
    1291:	8b 13                	mov    (%ebx),%edx
    1293:	e8 58 fe ff ff       	call   10f0 <printint>
        ap++;
    1298:	89 d8                	mov    %ebx,%eax
      state = 0;
    129a:	31 d2                	xor    %edx,%edx
        ap++;
    129c:	83 c0 04             	add    $0x4,%eax
    129f:	89 45 d0             	mov    %eax,-0x30(%ebp)
    12a2:	e9 44 ff ff ff       	jmp    11eb <printf+0x5b>
    12a7:	89 f6                	mov    %esi,%esi
    12a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
    12b0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    12b3:	8b 10                	mov    (%eax),%edx
        ap++;
    12b5:	83 c0 04             	add    $0x4,%eax
    12b8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    12bb:	85 d2                	test   %edx,%edx
    12bd:	0f 84 aa 00 00 00    	je     136d <printf+0x1dd>
        while(*s != 0){
    12c3:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
    12c6:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
    12c8:	84 c0                	test   %al,%al
    12ca:	74 27                	je     12f3 <printf+0x163>
    12cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    12d0:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    12d3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
    12d8:	43                   	inc    %ebx
  write(fd, &c, 1);
    12d9:	89 44 24 08          	mov    %eax,0x8(%esp)
    12dd:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    12e0:	89 44 24 04          	mov    %eax,0x4(%esp)
    12e4:	89 3c 24             	mov    %edi,(%esp)
    12e7:	e8 6c fd ff ff       	call   1058 <write>
        while(*s != 0){
    12ec:	0f b6 03             	movzbl (%ebx),%eax
    12ef:	84 c0                	test   %al,%al
    12f1:	75 dd                	jne    12d0 <printf+0x140>
      state = 0;
    12f3:	31 d2                	xor    %edx,%edx
    12f5:	e9 f1 fe ff ff       	jmp    11eb <printf+0x5b>
    12fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    1300:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1307:	b9 0a 00 00 00       	mov    $0xa,%ecx
    130c:	e9 7b ff ff ff       	jmp    128c <printf+0xfc>
    1311:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
    1318:	b9 01 00 00 00       	mov    $0x1,%ecx
    131d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1320:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    1324:	89 44 24 04          	mov    %eax,0x4(%esp)
    1328:	89 3c 24             	mov    %edi,(%esp)
    132b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    132e:	e8 25 fd ff ff       	call   1058 <write>
      state = 0;
    1333:	31 d2                	xor    %edx,%edx
    1335:	e9 b1 fe ff ff       	jmp    11eb <printf+0x5b>
    133a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
    1340:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    1343:	8b 03                	mov    (%ebx),%eax
        ap++;
    1345:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    1348:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
    134b:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    134e:	b8 01 00 00 00       	mov    $0x1,%eax
    1353:	89 44 24 08          	mov    %eax,0x8(%esp)
    1357:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    135a:	89 44 24 04          	mov    %eax,0x4(%esp)
    135e:	e8 f5 fc ff ff       	call   1058 <write>
      state = 0;
    1363:	31 d2                	xor    %edx,%edx
        ap++;
    1365:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    1368:	e9 7e fe ff ff       	jmp    11eb <printf+0x5b>
          s = "(null)";
    136d:	bb 20 16 00 00       	mov    $0x1620,%ebx
        while(*s != 0){
    1372:	b0 28                	mov    $0x28,%al
    1374:	e9 57 ff ff ff       	jmp    12d0 <printf+0x140>
    1379:	66 90                	xchg   %ax,%ax
    137b:	66 90                	xchg   %ax,%ax
    137d:	66 90                	xchg   %ax,%ax
    137f:	90                   	nop

00001380 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1380:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1381:	a1 64 1c 00 00       	mov    0x1c64,%eax
{
    1386:	89 e5                	mov    %esp,%ebp
    1388:	57                   	push   %edi
    1389:	56                   	push   %esi
    138a:	53                   	push   %ebx
    138b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    138e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1391:	eb 0d                	jmp    13a0 <free+0x20>
    1393:	90                   	nop
    1394:	90                   	nop
    1395:	90                   	nop
    1396:	90                   	nop
    1397:	90                   	nop
    1398:	90                   	nop
    1399:	90                   	nop
    139a:	90                   	nop
    139b:	90                   	nop
    139c:	90                   	nop
    139d:	90                   	nop
    139e:	90                   	nop
    139f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    13a0:	39 c8                	cmp    %ecx,%eax
    13a2:	8b 10                	mov    (%eax),%edx
    13a4:	73 32                	jae    13d8 <free+0x58>
    13a6:	39 d1                	cmp    %edx,%ecx
    13a8:	72 04                	jb     13ae <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    13aa:	39 d0                	cmp    %edx,%eax
    13ac:	72 32                	jb     13e0 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
    13ae:	8b 73 fc             	mov    -0x4(%ebx),%esi
    13b1:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    13b4:	39 fa                	cmp    %edi,%edx
    13b6:	74 30                	je     13e8 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    13b8:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    13bb:	8b 50 04             	mov    0x4(%eax),%edx
    13be:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    13c1:	39 f1                	cmp    %esi,%ecx
    13c3:	74 3c                	je     1401 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    13c5:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
    13c7:	5b                   	pop    %ebx
  freep = p;
    13c8:	a3 64 1c 00 00       	mov    %eax,0x1c64
}
    13cd:	5e                   	pop    %esi
    13ce:	5f                   	pop    %edi
    13cf:	5d                   	pop    %ebp
    13d0:	c3                   	ret    
    13d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    13d8:	39 d0                	cmp    %edx,%eax
    13da:	72 04                	jb     13e0 <free+0x60>
    13dc:	39 d1                	cmp    %edx,%ecx
    13de:	72 ce                	jb     13ae <free+0x2e>
{
    13e0:	89 d0                	mov    %edx,%eax
    13e2:	eb bc                	jmp    13a0 <free+0x20>
    13e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    13e8:	8b 7a 04             	mov    0x4(%edx),%edi
    13eb:	01 fe                	add    %edi,%esi
    13ed:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    13f0:	8b 10                	mov    (%eax),%edx
    13f2:	8b 12                	mov    (%edx),%edx
    13f4:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    13f7:	8b 50 04             	mov    0x4(%eax),%edx
    13fa:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    13fd:	39 f1                	cmp    %esi,%ecx
    13ff:	75 c4                	jne    13c5 <free+0x45>
    p->s.size += bp->s.size;
    1401:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
    1404:	a3 64 1c 00 00       	mov    %eax,0x1c64
    p->s.size += bp->s.size;
    1409:	01 ca                	add    %ecx,%edx
    140b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    140e:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1411:	89 10                	mov    %edx,(%eax)
}
    1413:	5b                   	pop    %ebx
    1414:	5e                   	pop    %esi
    1415:	5f                   	pop    %edi
    1416:	5d                   	pop    %ebp
    1417:	c3                   	ret    
    1418:	90                   	nop
    1419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001420 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1420:	55                   	push   %ebp
    1421:	89 e5                	mov    %esp,%ebp
    1423:	57                   	push   %edi
    1424:	56                   	push   %esi
    1425:	53                   	push   %ebx
    1426:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1429:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    142c:	8b 15 64 1c 00 00    	mov    0x1c64,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1432:	8d 78 07             	lea    0x7(%eax),%edi
    1435:	c1 ef 03             	shr    $0x3,%edi
    1438:	47                   	inc    %edi
  if((prevp = freep) == 0){
    1439:	85 d2                	test   %edx,%edx
    143b:	0f 84 8f 00 00 00    	je     14d0 <malloc+0xb0>
    1441:	8b 02                	mov    (%edx),%eax
    1443:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1446:	39 cf                	cmp    %ecx,%edi
    1448:	76 66                	jbe    14b0 <malloc+0x90>
    144a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1450:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1455:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    1458:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    145f:	eb 10                	jmp    1471 <malloc+0x51>
    1461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1468:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    146a:	8b 48 04             	mov    0x4(%eax),%ecx
    146d:	39 f9                	cmp    %edi,%ecx
    146f:	73 3f                	jae    14b0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1471:	39 05 64 1c 00 00    	cmp    %eax,0x1c64
    1477:	89 c2                	mov    %eax,%edx
    1479:	75 ed                	jne    1468 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    147b:	89 34 24             	mov    %esi,(%esp)
    147e:	e8 3d fc ff ff       	call   10c0 <sbrk>
  if(p == (char*)-1)
    1483:	83 f8 ff             	cmp    $0xffffffff,%eax
    1486:	74 18                	je     14a0 <malloc+0x80>
  hp->s.size = nu;
    1488:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    148b:	83 c0 08             	add    $0x8,%eax
    148e:	89 04 24             	mov    %eax,(%esp)
    1491:	e8 ea fe ff ff       	call   1380 <free>
  return freep;
    1496:	8b 15 64 1c 00 00    	mov    0x1c64,%edx
      if((p = morecore(nunits)) == 0)
    149c:	85 d2                	test   %edx,%edx
    149e:	75 c8                	jne    1468 <malloc+0x48>
        return 0;
  }
}
    14a0:	83 c4 1c             	add    $0x1c,%esp
        return 0;
    14a3:	31 c0                	xor    %eax,%eax
}
    14a5:	5b                   	pop    %ebx
    14a6:	5e                   	pop    %esi
    14a7:	5f                   	pop    %edi
    14a8:	5d                   	pop    %ebp
    14a9:	c3                   	ret    
    14aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    14b0:	39 cf                	cmp    %ecx,%edi
    14b2:	74 4c                	je     1500 <malloc+0xe0>
        p->s.size -= nunits;
    14b4:	29 f9                	sub    %edi,%ecx
    14b6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    14b9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    14bc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    14bf:	89 15 64 1c 00 00    	mov    %edx,0x1c64
}
    14c5:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
    14c8:	83 c0 08             	add    $0x8,%eax
}
    14cb:	5b                   	pop    %ebx
    14cc:	5e                   	pop    %esi
    14cd:	5f                   	pop    %edi
    14ce:	5d                   	pop    %ebp
    14cf:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    14d0:	b8 68 1c 00 00       	mov    $0x1c68,%eax
    14d5:	ba 68 1c 00 00       	mov    $0x1c68,%edx
    base.s.size = 0;
    14da:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
    14dc:	a3 64 1c 00 00       	mov    %eax,0x1c64
    base.s.size = 0;
    14e1:	b8 68 1c 00 00       	mov    $0x1c68,%eax
    base.s.ptr = freep = prevp = &base;
    14e6:	89 15 68 1c 00 00    	mov    %edx,0x1c68
    base.s.size = 0;
    14ec:	89 0d 6c 1c 00 00    	mov    %ecx,0x1c6c
    14f2:	e9 53 ff ff ff       	jmp    144a <malloc+0x2a>
    14f7:	89 f6                	mov    %esi,%esi
    14f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
    1500:	8b 08                	mov    (%eax),%ecx
    1502:	89 0a                	mov    %ecx,(%edx)
    1504:	eb b9                	jmp    14bf <malloc+0x9f>
