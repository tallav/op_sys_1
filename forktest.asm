
_forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "fork test OK\n");
}

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  forktest();
   9:	e8 42 00 00 00       	call   50 <forktest>
  exit(0);
   e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  15:	e8 ae 03 00 00       	call   3c8 <exit>
  1a:	66 90                	xchg   %ax,%ax
  1c:	66 90                	xchg   %ax,%ax
  1e:	66 90                	xchg   %ax,%ax

00000020 <printf>:
{
  20:	55                   	push   %ebp
  21:	89 e5                	mov    %esp,%ebp
  23:	53                   	push   %ebx
  24:	83 ec 14             	sub    $0x14,%esp
  27:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  write(fd, s, strlen(s));
  2a:	89 1c 24             	mov    %ebx,(%esp)
  2d:	e8 ce 01 00 00       	call   200 <strlen>
  32:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  36:	89 44 24 08          	mov    %eax,0x8(%esp)
  3a:	8b 45 08             	mov    0x8(%ebp),%eax
  3d:	89 04 24             	mov    %eax,(%esp)
  40:	e8 a3 03 00 00       	call   3e8 <write>
}
  45:	83 c4 14             	add    $0x14,%esp
  48:	5b                   	pop    %ebx
  49:	5d                   	pop    %ebp
  4a:	c3                   	ret    
  4b:	90                   	nop
  4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000050 <forktest>:
{
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	56                   	push   %esi
  54:	53                   	push   %ebx
  write(fd, s, strlen(s));
  55:	bb 78 04 00 00       	mov    $0x478,%ebx
{
  5a:	83 ec 20             	sub    $0x20,%esp
  write(fd, s, strlen(s));
  5d:	c7 04 24 78 04 00 00 	movl   $0x478,(%esp)
  64:	e8 97 01 00 00       	call   200 <strlen>
  69:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  for(n=0; n<N; n++){
  6d:	31 db                	xor    %ebx,%ebx
  write(fd, s, strlen(s));
  6f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  76:	89 44 24 08          	mov    %eax,0x8(%esp)
  7a:	e8 69 03 00 00       	call   3e8 <write>
  7f:	eb 16                	jmp    97 <forktest+0x47>
  81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(pid == 0)
  88:	0f 84 c8 00 00 00    	je     156 <forktest+0x106>
  for(n=0; n<N; n++){
  8e:	43                   	inc    %ebx
  8f:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  95:	74 69                	je     100 <forktest+0xb0>
    pid = fork();
  97:	e8 24 03 00 00       	call   3c0 <fork>
    if(pid < 0)
  9c:	85 c0                	test   %eax,%eax
  9e:	79 e8                	jns    88 <forktest+0x38>
  for(; n > 0; n--){
  a0:	85 db                	test   %ebx,%ebx
  a2:	8d 75 f4             	lea    -0xc(%ebp),%esi
  a5:	74 18                	je     bf <forktest+0x6f>
  a7:	89 f6                	mov    %esi,%esi
  a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(wait(&status) < 0){
  b0:	89 34 24             	mov    %esi,(%esp)
  b3:	e8 18 03 00 00       	call   3d0 <wait>
  b8:	85 c0                	test   %eax,%eax
  ba:	78 75                	js     131 <forktest+0xe1>
  for(; n > 0; n--){
  bc:	4b                   	dec    %ebx
  bd:	75 f1                	jne    b0 <forktest+0x60>
  if(wait(&status) != -1){
  bf:	89 34 24             	mov    %esi,(%esp)
  c2:	e8 09 03 00 00       	call   3d0 <wait>
  c7:	40                   	inc    %eax
  c8:	0f 85 94 00 00 00    	jne    162 <forktest+0x112>
  write(fd, s, strlen(s));
  ce:	c7 04 24 aa 04 00 00 	movl   $0x4aa,(%esp)
  d5:	e8 26 01 00 00       	call   200 <strlen>
  da:	ba aa 04 00 00       	mov    $0x4aa,%edx
  df:	89 54 24 04          	mov    %edx,0x4(%esp)
  e3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  ea:	89 44 24 08          	mov    %eax,0x8(%esp)
  ee:	e8 f5 02 00 00       	call   3e8 <write>
}
  f3:	83 c4 20             	add    $0x20,%esp
  f6:	5b                   	pop    %ebx
  f7:	5e                   	pop    %esi
  f8:	5d                   	pop    %ebp
  f9:	c3                   	ret    
  fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, s, strlen(s));
 100:	c7 04 24 b8 04 00 00 	movl   $0x4b8,(%esp)
 107:	e8 f4 00 00 00       	call   200 <strlen>
 10c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 113:	89 44 24 08          	mov    %eax,0x8(%esp)
 117:	b8 b8 04 00 00       	mov    $0x4b8,%eax
 11c:	89 44 24 04          	mov    %eax,0x4(%esp)
 120:	e8 c3 02 00 00       	call   3e8 <write>
    exit(0);
 125:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 12c:	e8 97 02 00 00       	call   3c8 <exit>
  write(fd, s, strlen(s));
 131:	c7 04 24 83 04 00 00 	movl   $0x483,(%esp)
 138:	e8 c3 00 00 00       	call   200 <strlen>
 13d:	b9 83 04 00 00       	mov    $0x483,%ecx
 142:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 146:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 14d:	89 44 24 08          	mov    %eax,0x8(%esp)
 151:	e8 92 02 00 00       	call   3e8 <write>
      exit(0);
 156:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 15d:	e8 66 02 00 00       	call   3c8 <exit>
  write(fd, s, strlen(s));
 162:	c7 04 24 97 04 00 00 	movl   $0x497,(%esp)
 169:	e8 92 00 00 00       	call   200 <strlen>
 16e:	c7 44 24 04 97 04 00 	movl   $0x497,0x4(%esp)
 175:	00 
 176:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 17d:	89 44 24 08          	mov    %eax,0x8(%esp)
 181:	e8 62 02 00 00       	call   3e8 <write>
    exit(0);
 186:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 18d:	e8 36 02 00 00       	call   3c8 <exit>
 192:	66 90                	xchg   %ax,%ax
 194:	66 90                	xchg   %ax,%ax
 196:	66 90                	xchg   %ax,%ax
 198:	66 90                	xchg   %ax,%ax
 19a:	66 90                	xchg   %ax,%ax
 19c:	66 90                	xchg   %ax,%ax
 19e:	66 90                	xchg   %ax,%ax

000001a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	8b 45 08             	mov    0x8(%ebp),%eax
 1a6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1a9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1aa:	89 c2                	mov    %eax,%edx
 1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1b0:	41                   	inc    %ecx
 1b1:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 1b5:	42                   	inc    %edx
 1b6:	84 db                	test   %bl,%bl
 1b8:	88 5a ff             	mov    %bl,-0x1(%edx)
 1bb:	75 f3                	jne    1b0 <strcpy+0x10>
    ;
  return os;
}
 1bd:	5b                   	pop    %ebx
 1be:	5d                   	pop    %ebp
 1bf:	c3                   	ret    

000001c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1c6:	53                   	push   %ebx
 1c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 1ca:	0f b6 01             	movzbl (%ecx),%eax
 1cd:	0f b6 13             	movzbl (%ebx),%edx
 1d0:	84 c0                	test   %al,%al
 1d2:	75 18                	jne    1ec <strcmp+0x2c>
 1d4:	eb 22                	jmp    1f8 <strcmp+0x38>
 1d6:	8d 76 00             	lea    0x0(%esi),%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 1e0:	41                   	inc    %ecx
  while(*p && *p == *q)
 1e1:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 1e4:	43                   	inc    %ebx
 1e5:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
 1e8:	84 c0                	test   %al,%al
 1ea:	74 0c                	je     1f8 <strcmp+0x38>
 1ec:	38 d0                	cmp    %dl,%al
 1ee:	74 f0                	je     1e0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
 1f0:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 1f1:	29 d0                	sub    %edx,%eax
}
 1f3:	5d                   	pop    %ebp
 1f4:	c3                   	ret    
 1f5:	8d 76 00             	lea    0x0(%esi),%esi
 1f8:	5b                   	pop    %ebx
 1f9:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 1fb:	29 d0                	sub    %edx,%eax
}
 1fd:	5d                   	pop    %ebp
 1fe:	c3                   	ret    
 1ff:	90                   	nop

00000200 <strlen>:

uint
strlen(const char *s)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 206:	80 39 00             	cmpb   $0x0,(%ecx)
 209:	74 15                	je     220 <strlen+0x20>
 20b:	31 d2                	xor    %edx,%edx
 20d:	8d 76 00             	lea    0x0(%esi),%esi
 210:	42                   	inc    %edx
 211:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 215:	89 d0                	mov    %edx,%eax
 217:	75 f7                	jne    210 <strlen+0x10>
    ;
  return n;
}
 219:	5d                   	pop    %ebp
 21a:	c3                   	ret    
 21b:	90                   	nop
 21c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
 220:	31 c0                	xor    %eax,%eax
}
 222:	5d                   	pop    %ebp
 223:	c3                   	ret    
 224:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 22a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000230 <memset>:

void*
memset(void *dst, int c, uint n)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	8b 55 08             	mov    0x8(%ebp),%edx
 236:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 237:	8b 4d 10             	mov    0x10(%ebp),%ecx
 23a:	8b 45 0c             	mov    0xc(%ebp),%eax
 23d:	89 d7                	mov    %edx,%edi
 23f:	fc                   	cld    
 240:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 242:	5f                   	pop    %edi
 243:	89 d0                	mov    %edx,%eax
 245:	5d                   	pop    %ebp
 246:	c3                   	ret    
 247:	89 f6                	mov    %esi,%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <strchr>:

char*
strchr(const char *s, char c)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	8b 45 08             	mov    0x8(%ebp),%eax
 256:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 25a:	0f b6 10             	movzbl (%eax),%edx
 25d:	84 d2                	test   %dl,%dl
 25f:	74 1b                	je     27c <strchr+0x2c>
    if(*s == c)
 261:	38 d1                	cmp    %dl,%cl
 263:	75 0f                	jne    274 <strchr+0x24>
 265:	eb 17                	jmp    27e <strchr+0x2e>
 267:	89 f6                	mov    %esi,%esi
 269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 270:	38 ca                	cmp    %cl,%dl
 272:	74 0a                	je     27e <strchr+0x2e>
  for(; *s; s++)
 274:	40                   	inc    %eax
 275:	0f b6 10             	movzbl (%eax),%edx
 278:	84 d2                	test   %dl,%dl
 27a:	75 f4                	jne    270 <strchr+0x20>
      return (char*)s;
  return 0;
 27c:	31 c0                	xor    %eax,%eax
}
 27e:	5d                   	pop    %ebp
 27f:	c3                   	ret    

00000280 <gets>:

char*
gets(char *buf, int max)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	57                   	push   %edi
 284:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 285:	31 f6                	xor    %esi,%esi
{
 287:	53                   	push   %ebx
 288:	83 ec 3c             	sub    $0x3c,%esp
 28b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
 28e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 291:	eb 32                	jmp    2c5 <gets+0x45>
 293:	90                   	nop
 294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 298:	ba 01 00 00 00       	mov    $0x1,%edx
 29d:	89 54 24 08          	mov    %edx,0x8(%esp)
 2a1:	89 7c 24 04          	mov    %edi,0x4(%esp)
 2a5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2ac:	e8 2f 01 00 00       	call   3e0 <read>
    if(cc < 1)
 2b1:	85 c0                	test   %eax,%eax
 2b3:	7e 19                	jle    2ce <gets+0x4e>
      break;
    buf[i++] = c;
 2b5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2b9:	43                   	inc    %ebx
 2ba:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
 2bd:	3c 0a                	cmp    $0xa,%al
 2bf:	74 1f                	je     2e0 <gets+0x60>
 2c1:	3c 0d                	cmp    $0xd,%al
 2c3:	74 1b                	je     2e0 <gets+0x60>
  for(i=0; i+1 < max; ){
 2c5:	46                   	inc    %esi
 2c6:	3b 75 0c             	cmp    0xc(%ebp),%esi
 2c9:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 2cc:	7c ca                	jl     298 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 2ce:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 2d1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 2d4:	8b 45 08             	mov    0x8(%ebp),%eax
 2d7:	83 c4 3c             	add    $0x3c,%esp
 2da:	5b                   	pop    %ebx
 2db:	5e                   	pop    %esi
 2dc:	5f                   	pop    %edi
 2dd:	5d                   	pop    %ebp
 2de:	c3                   	ret    
 2df:	90                   	nop
 2e0:	8b 45 08             	mov    0x8(%ebp),%eax
 2e3:	01 c6                	add    %eax,%esi
 2e5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 2e8:	eb e4                	jmp    2ce <gets+0x4e>
 2ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2f0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2f1:	31 c0                	xor    %eax,%eax
{
 2f3:	89 e5                	mov    %esp,%ebp
 2f5:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 2f8:	89 44 24 04          	mov    %eax,0x4(%esp)
 2fc:	8b 45 08             	mov    0x8(%ebp),%eax
{
 2ff:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 302:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 305:	89 04 24             	mov    %eax,(%esp)
 308:	e8 fb 00 00 00       	call   408 <open>
  if(fd < 0)
 30d:	85 c0                	test   %eax,%eax
 30f:	78 2f                	js     340 <stat+0x50>
 311:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 313:	8b 45 0c             	mov    0xc(%ebp),%eax
 316:	89 1c 24             	mov    %ebx,(%esp)
 319:	89 44 24 04          	mov    %eax,0x4(%esp)
 31d:	e8 fe 00 00 00       	call   420 <fstat>
  close(fd);
 322:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 325:	89 c6                	mov    %eax,%esi
  close(fd);
 327:	e8 c4 00 00 00       	call   3f0 <close>
  return r;
}
 32c:	89 f0                	mov    %esi,%eax
 32e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 331:	8b 75 fc             	mov    -0x4(%ebp),%esi
 334:	89 ec                	mov    %ebp,%esp
 336:	5d                   	pop    %ebp
 337:	c3                   	ret    
 338:	90                   	nop
 339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 340:	be ff ff ff ff       	mov    $0xffffffff,%esi
 345:	eb e5                	jmp    32c <stat+0x3c>
 347:	89 f6                	mov    %esi,%esi
 349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000350 <atoi>:

int
atoi(const char *s)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	8b 4d 08             	mov    0x8(%ebp),%ecx
 356:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 357:	0f be 11             	movsbl (%ecx),%edx
 35a:	88 d0                	mov    %dl,%al
 35c:	2c 30                	sub    $0x30,%al
 35e:	3c 09                	cmp    $0x9,%al
  n = 0;
 360:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 365:	77 1e                	ja     385 <atoi+0x35>
 367:	89 f6                	mov    %esi,%esi
 369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 370:	41                   	inc    %ecx
 371:	8d 04 80             	lea    (%eax,%eax,4),%eax
 374:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 378:	0f be 11             	movsbl (%ecx),%edx
 37b:	88 d3                	mov    %dl,%bl
 37d:	80 eb 30             	sub    $0x30,%bl
 380:	80 fb 09             	cmp    $0x9,%bl
 383:	76 eb                	jbe    370 <atoi+0x20>
  return n;
}
 385:	5b                   	pop    %ebx
 386:	5d                   	pop    %ebp
 387:	c3                   	ret    
 388:	90                   	nop
 389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000390 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	56                   	push   %esi
 394:	8b 45 08             	mov    0x8(%ebp),%eax
 397:	53                   	push   %ebx
 398:	8b 5d 10             	mov    0x10(%ebp),%ebx
 39b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 39e:	85 db                	test   %ebx,%ebx
 3a0:	7e 1a                	jle    3bc <memmove+0x2c>
 3a2:	31 d2                	xor    %edx,%edx
 3a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 3b0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 3b4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 3b7:	42                   	inc    %edx
  while(n-- > 0)
 3b8:	39 d3                	cmp    %edx,%ebx
 3ba:	75 f4                	jne    3b0 <memmove+0x20>
  return vdst;
}
 3bc:	5b                   	pop    %ebx
 3bd:	5e                   	pop    %esi
 3be:	5d                   	pop    %ebp
 3bf:	c3                   	ret    

000003c0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3c0:	b8 01 00 00 00       	mov    $0x1,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <exit>:
SYSCALL(exit)
 3c8:	b8 02 00 00 00       	mov    $0x2,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <wait>:
SYSCALL(wait)
 3d0:	b8 03 00 00 00       	mov    $0x3,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <pipe>:
SYSCALL(pipe)
 3d8:	b8 04 00 00 00       	mov    $0x4,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <read>:
SYSCALL(read)
 3e0:	b8 05 00 00 00       	mov    $0x5,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <write>:
SYSCALL(write)
 3e8:	b8 10 00 00 00       	mov    $0x10,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <close>:
SYSCALL(close)
 3f0:	b8 15 00 00 00       	mov    $0x15,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <kill>:
SYSCALL(kill)
 3f8:	b8 06 00 00 00       	mov    $0x6,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <exec>:
SYSCALL(exec)
 400:	b8 07 00 00 00       	mov    $0x7,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <open>:
SYSCALL(open)
 408:	b8 0f 00 00 00       	mov    $0xf,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <mknod>:
SYSCALL(mknod)
 410:	b8 11 00 00 00       	mov    $0x11,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <unlink>:
SYSCALL(unlink)
 418:	b8 12 00 00 00       	mov    $0x12,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <fstat>:
SYSCALL(fstat)
 420:	b8 08 00 00 00       	mov    $0x8,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <link>:
SYSCALL(link)
 428:	b8 13 00 00 00       	mov    $0x13,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <mkdir>:
SYSCALL(mkdir)
 430:	b8 14 00 00 00       	mov    $0x14,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <chdir>:
SYSCALL(chdir)
 438:	b8 09 00 00 00       	mov    $0x9,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <dup>:
SYSCALL(dup)
 440:	b8 0a 00 00 00       	mov    $0xa,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <getpid>:
SYSCALL(getpid)
 448:	b8 0b 00 00 00       	mov    $0xb,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <sbrk>:
SYSCALL(sbrk)
 450:	b8 0c 00 00 00       	mov    $0xc,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <sleep>:
SYSCALL(sleep)
 458:	b8 0d 00 00 00       	mov    $0xd,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <uptime>:
SYSCALL(uptime)
 460:	b8 0e 00 00 00       	mov    $0xe,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    

00000468 <detach>:
SYSCALL(detach)
 468:	b8 16 00 00 00       	mov    $0x16,%eax
 46d:	cd 40                	int    $0x40
 46f:	c3                   	ret    

00000470 <priority>:
SYSCALL(priority)
 470:	b8 17 00 00 00       	mov    $0x17,%eax
 475:	cd 40                	int    $0x40
 477:	c3                   	ret    
