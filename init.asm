
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	55                   	push   %ebp
  int pid, wpid;
  int status;

  if(open("console", O_RDWR) < 0){
   1:	b9 02 00 00 00       	mov    $0x2,%ecx
{
   6:	89 e5                	mov    %esp,%ebp
   8:	56                   	push   %esi
   9:	53                   	push   %ebx
   a:	83 e4 f0             	and    $0xfffffff0,%esp
   d:	83 ec 20             	sub    $0x20,%esp
  if(open("console", O_RDWR) < 0){
  10:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  14:	c7 04 24 48 08 00 00 	movl   $0x848,(%esp)
  1b:	e8 88 03 00 00       	call   3a8 <open>
  20:	85 c0                	test   %eax,%eax
  22:	0f 88 da 00 00 00    	js     102 <main+0x102>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  28:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  2f:	8d 74 24 1c          	lea    0x1c(%esp),%esi
  33:	e8 a8 03 00 00       	call   3e0 <dup>
  dup(0);  // stderr
  38:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3f:	e8 9c 03 00 00       	call   3e0 <dup>
  44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

  for(;;){
    printf(1, "init: starting sh\n");
  50:	ba 50 08 00 00       	mov    $0x850,%edx
  55:	89 54 24 04          	mov    %edx,0x4(%esp)
  59:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  60:	e8 6b 04 00 00       	call   4d0 <printf>
    pid = fork();
  65:	e8 f6 02 00 00       	call   360 <fork>
    if(pid < 0){
  6a:	85 c0                	test   %eax,%eax
    pid = fork();
  6c:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  6e:	78 3e                	js     ae <main+0xae>
      printf(1, "init: fork failed\n");
      exit(0);
    }
    if(pid == 0){
  70:	74 5c                	je     ce <main+0xce>
  72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit(0);
    }
    while((wpid=wait(&status)) >= 0 && wpid != pid)
  80:	89 34 24             	mov    %esi,(%esp)
  83:	e8 e8 02 00 00       	call   370 <wait>
  88:	89 c2                	mov    %eax,%edx
  8a:	f7 d2                	not    %edx
  8c:	c1 ea 1f             	shr    $0x1f,%edx
  8f:	84 d2                	test   %dl,%dl
  91:	74 bd                	je     50 <main+0x50>
  93:	39 c3                	cmp    %eax,%ebx
  95:	74 b9                	je     50 <main+0x50>
      printf(1, "zombie!\n");
  97:	b8 8f 08 00 00       	mov    $0x88f,%eax
  9c:	89 44 24 04          	mov    %eax,0x4(%esp)
  a0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  a7:	e8 24 04 00 00       	call   4d0 <printf>
  ac:	eb d2                	jmp    80 <main+0x80>
      printf(1, "init: fork failed\n");
  ae:	c7 44 24 04 63 08 00 	movl   $0x863,0x4(%esp)
  b5:	00 
  b6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  bd:	e8 0e 04 00 00       	call   4d0 <printf>
      exit(0);
  c2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  c9:	e8 9a 02 00 00       	call   368 <exit>
      exec("sh", argv);
  ce:	c7 44 24 04 30 0b 00 	movl   $0xb30,0x4(%esp)
  d5:	00 
  d6:	c7 04 24 76 08 00 00 	movl   $0x876,(%esp)
  dd:	e8 be 02 00 00       	call   3a0 <exec>
      printf(1, "init: exec sh failed\n");
  e2:	c7 44 24 04 79 08 00 	movl   $0x879,0x4(%esp)
  e9:	00 
  ea:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  f1:	e8 da 03 00 00       	call   4d0 <printf>
      exit(0);
  f6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  fd:	e8 66 02 00 00       	call   368 <exit>
    mknod("console", 1, 1);
 102:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 109:	00 
 10a:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
 111:	00 
 112:	c7 04 24 48 08 00 00 	movl   $0x848,(%esp)
 119:	e8 92 02 00 00       	call   3b0 <mknod>
    open("console", O_RDWR);
 11e:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
 125:	00 
 126:	c7 04 24 48 08 00 00 	movl   $0x848,(%esp)
 12d:	e8 76 02 00 00       	call   3a8 <open>
 132:	e9 f1 fe ff ff       	jmp    28 <main+0x28>
 137:	66 90                	xchg   %ax,%ax
 139:	66 90                	xchg   %ax,%ax
 13b:	66 90                	xchg   %ax,%ax
 13d:	66 90                	xchg   %ax,%ax
 13f:	90                   	nop

00000140 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	8b 45 08             	mov    0x8(%ebp),%eax
 146:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 149:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 14a:	89 c2                	mov    %eax,%edx
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 150:	41                   	inc    %ecx
 151:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 155:	42                   	inc    %edx
 156:	84 db                	test   %bl,%bl
 158:	88 5a ff             	mov    %bl,-0x1(%edx)
 15b:	75 f3                	jne    150 <strcpy+0x10>
    ;
  return os;
}
 15d:	5b                   	pop    %ebx
 15e:	5d                   	pop    %ebp
 15f:	c3                   	ret    

00000160 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	8b 4d 08             	mov    0x8(%ebp),%ecx
 166:	53                   	push   %ebx
 167:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 16a:	0f b6 01             	movzbl (%ecx),%eax
 16d:	0f b6 13             	movzbl (%ebx),%edx
 170:	84 c0                	test   %al,%al
 172:	75 18                	jne    18c <strcmp+0x2c>
 174:	eb 22                	jmp    198 <strcmp+0x38>
 176:	8d 76 00             	lea    0x0(%esi),%esi
 179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 180:	41                   	inc    %ecx
  while(*p && *p == *q)
 181:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 184:	43                   	inc    %ebx
 185:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
 188:	84 c0                	test   %al,%al
 18a:	74 0c                	je     198 <strcmp+0x38>
 18c:	38 d0                	cmp    %dl,%al
 18e:	74 f0                	je     180 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
 190:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 191:	29 d0                	sub    %edx,%eax
}
 193:	5d                   	pop    %ebp
 194:	c3                   	ret    
 195:	8d 76 00             	lea    0x0(%esi),%esi
 198:	5b                   	pop    %ebx
 199:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 19b:	29 d0                	sub    %edx,%eax
}
 19d:	5d                   	pop    %ebp
 19e:	c3                   	ret    
 19f:	90                   	nop

000001a0 <strlen>:

uint
strlen(const char *s)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1a6:	80 39 00             	cmpb   $0x0,(%ecx)
 1a9:	74 15                	je     1c0 <strlen+0x20>
 1ab:	31 d2                	xor    %edx,%edx
 1ad:	8d 76 00             	lea    0x0(%esi),%esi
 1b0:	42                   	inc    %edx
 1b1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1b5:	89 d0                	mov    %edx,%eax
 1b7:	75 f7                	jne    1b0 <strlen+0x10>
    ;
  return n;
}
 1b9:	5d                   	pop    %ebp
 1ba:	c3                   	ret    
 1bb:	90                   	nop
 1bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
 1c0:	31 c0                	xor    %eax,%eax
}
 1c2:	5d                   	pop    %ebp
 1c3:	c3                   	ret    
 1c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	8b 55 08             	mov    0x8(%ebp),%edx
 1d6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1da:	8b 45 0c             	mov    0xc(%ebp),%eax
 1dd:	89 d7                	mov    %edx,%edi
 1df:	fc                   	cld    
 1e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1e2:	5f                   	pop    %edi
 1e3:	89 d0                	mov    %edx,%eax
 1e5:	5d                   	pop    %ebp
 1e6:	c3                   	ret    
 1e7:	89 f6                	mov    %esi,%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001f0 <strchr>:

char*
strchr(const char *s, char c)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1fa:	0f b6 10             	movzbl (%eax),%edx
 1fd:	84 d2                	test   %dl,%dl
 1ff:	74 1b                	je     21c <strchr+0x2c>
    if(*s == c)
 201:	38 d1                	cmp    %dl,%cl
 203:	75 0f                	jne    214 <strchr+0x24>
 205:	eb 17                	jmp    21e <strchr+0x2e>
 207:	89 f6                	mov    %esi,%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 210:	38 ca                	cmp    %cl,%dl
 212:	74 0a                	je     21e <strchr+0x2e>
  for(; *s; s++)
 214:	40                   	inc    %eax
 215:	0f b6 10             	movzbl (%eax),%edx
 218:	84 d2                	test   %dl,%dl
 21a:	75 f4                	jne    210 <strchr+0x20>
      return (char*)s;
  return 0;
 21c:	31 c0                	xor    %eax,%eax
}
 21e:	5d                   	pop    %ebp
 21f:	c3                   	ret    

00000220 <gets>:

char*
gets(char *buf, int max)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 225:	31 f6                	xor    %esi,%esi
{
 227:	53                   	push   %ebx
 228:	83 ec 3c             	sub    $0x3c,%esp
 22b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
 22e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 231:	eb 32                	jmp    265 <gets+0x45>
 233:	90                   	nop
 234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 238:	ba 01 00 00 00       	mov    $0x1,%edx
 23d:	89 54 24 08          	mov    %edx,0x8(%esp)
 241:	89 7c 24 04          	mov    %edi,0x4(%esp)
 245:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 24c:	e8 2f 01 00 00       	call   380 <read>
    if(cc < 1)
 251:	85 c0                	test   %eax,%eax
 253:	7e 19                	jle    26e <gets+0x4e>
      break;
    buf[i++] = c;
 255:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 259:	43                   	inc    %ebx
 25a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
 25d:	3c 0a                	cmp    $0xa,%al
 25f:	74 1f                	je     280 <gets+0x60>
 261:	3c 0d                	cmp    $0xd,%al
 263:	74 1b                	je     280 <gets+0x60>
  for(i=0; i+1 < max; ){
 265:	46                   	inc    %esi
 266:	3b 75 0c             	cmp    0xc(%ebp),%esi
 269:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 26c:	7c ca                	jl     238 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 26e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 271:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 274:	8b 45 08             	mov    0x8(%ebp),%eax
 277:	83 c4 3c             	add    $0x3c,%esp
 27a:	5b                   	pop    %ebx
 27b:	5e                   	pop    %esi
 27c:	5f                   	pop    %edi
 27d:	5d                   	pop    %ebp
 27e:	c3                   	ret    
 27f:	90                   	nop
 280:	8b 45 08             	mov    0x8(%ebp),%eax
 283:	01 c6                	add    %eax,%esi
 285:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 288:	eb e4                	jmp    26e <gets+0x4e>
 28a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000290 <stat>:

int
stat(const char *n, struct stat *st)
{
 290:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 291:	31 c0                	xor    %eax,%eax
{
 293:	89 e5                	mov    %esp,%ebp
 295:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 298:	89 44 24 04          	mov    %eax,0x4(%esp)
 29c:	8b 45 08             	mov    0x8(%ebp),%eax
{
 29f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 2a2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 2a5:	89 04 24             	mov    %eax,(%esp)
 2a8:	e8 fb 00 00 00       	call   3a8 <open>
  if(fd < 0)
 2ad:	85 c0                	test   %eax,%eax
 2af:	78 2f                	js     2e0 <stat+0x50>
 2b1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 2b3:	8b 45 0c             	mov    0xc(%ebp),%eax
 2b6:	89 1c 24             	mov    %ebx,(%esp)
 2b9:	89 44 24 04          	mov    %eax,0x4(%esp)
 2bd:	e8 fe 00 00 00       	call   3c0 <fstat>
  close(fd);
 2c2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2c5:	89 c6                	mov    %eax,%esi
  close(fd);
 2c7:	e8 c4 00 00 00       	call   390 <close>
  return r;
}
 2cc:	89 f0                	mov    %esi,%eax
 2ce:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 2d1:	8b 75 fc             	mov    -0x4(%ebp),%esi
 2d4:	89 ec                	mov    %ebp,%esp
 2d6:	5d                   	pop    %ebp
 2d7:	c3                   	ret    
 2d8:	90                   	nop
 2d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 2e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2e5:	eb e5                	jmp    2cc <stat+0x3c>
 2e7:	89 f6                	mov    %esi,%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002f0 <atoi>:

int
atoi(const char *s)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2f6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2f7:	0f be 11             	movsbl (%ecx),%edx
 2fa:	88 d0                	mov    %dl,%al
 2fc:	2c 30                	sub    $0x30,%al
 2fe:	3c 09                	cmp    $0x9,%al
  n = 0;
 300:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 305:	77 1e                	ja     325 <atoi+0x35>
 307:	89 f6                	mov    %esi,%esi
 309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 310:	41                   	inc    %ecx
 311:	8d 04 80             	lea    (%eax,%eax,4),%eax
 314:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 318:	0f be 11             	movsbl (%ecx),%edx
 31b:	88 d3                	mov    %dl,%bl
 31d:	80 eb 30             	sub    $0x30,%bl
 320:	80 fb 09             	cmp    $0x9,%bl
 323:	76 eb                	jbe    310 <atoi+0x20>
  return n;
}
 325:	5b                   	pop    %ebx
 326:	5d                   	pop    %ebp
 327:	c3                   	ret    
 328:	90                   	nop
 329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000330 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	56                   	push   %esi
 334:	8b 45 08             	mov    0x8(%ebp),%eax
 337:	53                   	push   %ebx
 338:	8b 5d 10             	mov    0x10(%ebp),%ebx
 33b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 33e:	85 db                	test   %ebx,%ebx
 340:	7e 1a                	jle    35c <memmove+0x2c>
 342:	31 d2                	xor    %edx,%edx
 344:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 34a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 350:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 354:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 357:	42                   	inc    %edx
  while(n-- > 0)
 358:	39 d3                	cmp    %edx,%ebx
 35a:	75 f4                	jne    350 <memmove+0x20>
  return vdst;
}
 35c:	5b                   	pop    %ebx
 35d:	5e                   	pop    %esi
 35e:	5d                   	pop    %ebp
 35f:	c3                   	ret    

00000360 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 360:	b8 01 00 00 00       	mov    $0x1,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <exit>:
SYSCALL(exit)
 368:	b8 02 00 00 00       	mov    $0x2,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <wait>:
SYSCALL(wait)
 370:	b8 03 00 00 00       	mov    $0x3,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <pipe>:
SYSCALL(pipe)
 378:	b8 04 00 00 00       	mov    $0x4,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <read>:
SYSCALL(read)
 380:	b8 05 00 00 00       	mov    $0x5,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <write>:
SYSCALL(write)
 388:	b8 10 00 00 00       	mov    $0x10,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <close>:
SYSCALL(close)
 390:	b8 15 00 00 00       	mov    $0x15,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <kill>:
SYSCALL(kill)
 398:	b8 06 00 00 00       	mov    $0x6,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <exec>:
SYSCALL(exec)
 3a0:	b8 07 00 00 00       	mov    $0x7,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <open>:
SYSCALL(open)
 3a8:	b8 0f 00 00 00       	mov    $0xf,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <mknod>:
SYSCALL(mknod)
 3b0:	b8 11 00 00 00       	mov    $0x11,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <unlink>:
SYSCALL(unlink)
 3b8:	b8 12 00 00 00       	mov    $0x12,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <fstat>:
SYSCALL(fstat)
 3c0:	b8 08 00 00 00       	mov    $0x8,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <link>:
SYSCALL(link)
 3c8:	b8 13 00 00 00       	mov    $0x13,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <mkdir>:
SYSCALL(mkdir)
 3d0:	b8 14 00 00 00       	mov    $0x14,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <chdir>:
SYSCALL(chdir)
 3d8:	b8 09 00 00 00       	mov    $0x9,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <dup>:
SYSCALL(dup)
 3e0:	b8 0a 00 00 00       	mov    $0xa,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <getpid>:
SYSCALL(getpid)
 3e8:	b8 0b 00 00 00       	mov    $0xb,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <sbrk>:
SYSCALL(sbrk)
 3f0:	b8 0c 00 00 00       	mov    $0xc,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <sleep>:
SYSCALL(sleep)
 3f8:	b8 0d 00 00 00       	mov    $0xd,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <uptime>:
SYSCALL(uptime)
 400:	b8 0e 00 00 00       	mov    $0xe,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <detach>:
SYSCALL(detach)
 408:	b8 16 00 00 00       	mov    $0x16,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <priority>:
SYSCALL(priority)
 410:	b8 17 00 00 00       	mov    $0x17,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <policy>:
SYSCALL(policy)
 418:	b8 18 00 00 00       	mov    $0x18,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <wait_stat>:
SYSCALL(wait_stat)
 420:	b8 19 00 00 00       	mov    $0x19,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    
 428:	66 90                	xchg   %ax,%ax
 42a:	66 90                	xchg   %ax,%ax
 42c:	66 90                	xchg   %ax,%ax
 42e:	66 90                	xchg   %ax,%ax

00000430 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	57                   	push   %edi
 434:	56                   	push   %esi
 435:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 436:	89 d3                	mov    %edx,%ebx
 438:	c1 eb 1f             	shr    $0x1f,%ebx
{
 43b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 43e:	84 db                	test   %bl,%bl
{
 440:	89 45 c0             	mov    %eax,-0x40(%ebp)
 443:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 445:	74 79                	je     4c0 <printint+0x90>
 447:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 44b:	74 73                	je     4c0 <printint+0x90>
    neg = 1;
    x = -xx;
 44d:	f7 d8                	neg    %eax
    neg = 1;
 44f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 456:	31 f6                	xor    %esi,%esi
 458:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 45b:	eb 05                	jmp    462 <printint+0x32>
 45d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 460:	89 fe                	mov    %edi,%esi
 462:	31 d2                	xor    %edx,%edx
 464:	f7 f1                	div    %ecx
 466:	8d 7e 01             	lea    0x1(%esi),%edi
 469:	0f b6 92 a0 08 00 00 	movzbl 0x8a0(%edx),%edx
  }while((x /= base) != 0);
 470:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 472:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 475:	75 e9                	jne    460 <printint+0x30>
  if(neg)
 477:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 47a:	85 d2                	test   %edx,%edx
 47c:	74 08                	je     486 <printint+0x56>
    buf[i++] = '-';
 47e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 483:	8d 7e 02             	lea    0x2(%esi),%edi
 486:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 48a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 48d:	8d 76 00             	lea    0x0(%esi),%esi
 490:	0f b6 06             	movzbl (%esi),%eax
 493:	4e                   	dec    %esi
  write(fd, &c, 1);
 494:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 498:	89 3c 24             	mov    %edi,(%esp)
 49b:	88 45 d7             	mov    %al,-0x29(%ebp)
 49e:	b8 01 00 00 00       	mov    $0x1,%eax
 4a3:	89 44 24 08          	mov    %eax,0x8(%esp)
 4a7:	e8 dc fe ff ff       	call   388 <write>

  while(--i >= 0)
 4ac:	39 de                	cmp    %ebx,%esi
 4ae:	75 e0                	jne    490 <printint+0x60>
    putc(fd, buf[i]);
}
 4b0:	83 c4 4c             	add    $0x4c,%esp
 4b3:	5b                   	pop    %ebx
 4b4:	5e                   	pop    %esi
 4b5:	5f                   	pop    %edi
 4b6:	5d                   	pop    %ebp
 4b7:	c3                   	ret    
 4b8:	90                   	nop
 4b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 4c0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 4c7:	eb 8d                	jmp    456 <printint+0x26>
 4c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	57                   	push   %edi
 4d4:	56                   	push   %esi
 4d5:	53                   	push   %ebx
 4d6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4d9:	8b 75 0c             	mov    0xc(%ebp),%esi
 4dc:	0f b6 1e             	movzbl (%esi),%ebx
 4df:	84 db                	test   %bl,%bl
 4e1:	0f 84 d1 00 00 00    	je     5b8 <printf+0xe8>
  state = 0;
 4e7:	31 ff                	xor    %edi,%edi
 4e9:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 4ea:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 4ed:	89 fa                	mov    %edi,%edx
 4ef:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 4f2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4f5:	eb 41                	jmp    538 <printf+0x68>
 4f7:	89 f6                	mov    %esi,%esi
 4f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 500:	83 f8 25             	cmp    $0x25,%eax
 503:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 506:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 50b:	74 1e                	je     52b <printf+0x5b>
  write(fd, &c, 1);
 50d:	b8 01 00 00 00       	mov    $0x1,%eax
 512:	89 44 24 08          	mov    %eax,0x8(%esp)
 516:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 519:	89 44 24 04          	mov    %eax,0x4(%esp)
 51d:	89 3c 24             	mov    %edi,(%esp)
 520:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 523:	e8 60 fe ff ff       	call   388 <write>
 528:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 52b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 52c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 530:	84 db                	test   %bl,%bl
 532:	0f 84 80 00 00 00    	je     5b8 <printf+0xe8>
    if(state == 0){
 538:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 53a:	0f be cb             	movsbl %bl,%ecx
 53d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 540:	74 be                	je     500 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 542:	83 fa 25             	cmp    $0x25,%edx
 545:	75 e4                	jne    52b <printf+0x5b>
      if(c == 'd'){
 547:	83 f8 64             	cmp    $0x64,%eax
 54a:	0f 84 f0 00 00 00    	je     640 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 550:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 556:	83 f9 70             	cmp    $0x70,%ecx
 559:	74 65                	je     5c0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 55b:	83 f8 73             	cmp    $0x73,%eax
 55e:	0f 84 8c 00 00 00    	je     5f0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 564:	83 f8 63             	cmp    $0x63,%eax
 567:	0f 84 13 01 00 00    	je     680 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 56d:	83 f8 25             	cmp    $0x25,%eax
 570:	0f 84 e2 00 00 00    	je     658 <printf+0x188>
  write(fd, &c, 1);
 576:	b8 01 00 00 00       	mov    $0x1,%eax
 57b:	46                   	inc    %esi
 57c:	89 44 24 08          	mov    %eax,0x8(%esp)
 580:	8d 45 e7             	lea    -0x19(%ebp),%eax
 583:	89 44 24 04          	mov    %eax,0x4(%esp)
 587:	89 3c 24             	mov    %edi,(%esp)
 58a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 58e:	e8 f5 fd ff ff       	call   388 <write>
 593:	ba 01 00 00 00       	mov    $0x1,%edx
 598:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 59b:	89 54 24 08          	mov    %edx,0x8(%esp)
 59f:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a3:	89 3c 24             	mov    %edi,(%esp)
 5a6:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 5a9:	e8 da fd ff ff       	call   388 <write>
  for(i = 0; fmt[i]; i++){
 5ae:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5b2:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 5b4:	84 db                	test   %bl,%bl
 5b6:	75 80                	jne    538 <printf+0x68>
    }
  }
}
 5b8:	83 c4 3c             	add    $0x3c,%esp
 5bb:	5b                   	pop    %ebx
 5bc:	5e                   	pop    %esi
 5bd:	5f                   	pop    %edi
 5be:	5d                   	pop    %ebp
 5bf:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 5c0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 5c7:	b9 10 00 00 00       	mov    $0x10,%ecx
 5cc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5cf:	89 f8                	mov    %edi,%eax
 5d1:	8b 13                	mov    (%ebx),%edx
 5d3:	e8 58 fe ff ff       	call   430 <printint>
        ap++;
 5d8:	89 d8                	mov    %ebx,%eax
      state = 0;
 5da:	31 d2                	xor    %edx,%edx
        ap++;
 5dc:	83 c0 04             	add    $0x4,%eax
 5df:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5e2:	e9 44 ff ff ff       	jmp    52b <printf+0x5b>
 5e7:	89 f6                	mov    %esi,%esi
 5e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 5f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5f3:	8b 10                	mov    (%eax),%edx
        ap++;
 5f5:	83 c0 04             	add    $0x4,%eax
 5f8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 5fb:	85 d2                	test   %edx,%edx
 5fd:	0f 84 aa 00 00 00    	je     6ad <printf+0x1dd>
        while(*s != 0){
 603:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 606:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 608:	84 c0                	test   %al,%al
 60a:	74 27                	je     633 <printf+0x163>
 60c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 610:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 613:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 618:	43                   	inc    %ebx
  write(fd, &c, 1);
 619:	89 44 24 08          	mov    %eax,0x8(%esp)
 61d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 620:	89 44 24 04          	mov    %eax,0x4(%esp)
 624:	89 3c 24             	mov    %edi,(%esp)
 627:	e8 5c fd ff ff       	call   388 <write>
        while(*s != 0){
 62c:	0f b6 03             	movzbl (%ebx),%eax
 62f:	84 c0                	test   %al,%al
 631:	75 dd                	jne    610 <printf+0x140>
      state = 0;
 633:	31 d2                	xor    %edx,%edx
 635:	e9 f1 fe ff ff       	jmp    52b <printf+0x5b>
 63a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 640:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 647:	b9 0a 00 00 00       	mov    $0xa,%ecx
 64c:	e9 7b ff ff ff       	jmp    5cc <printf+0xfc>
 651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 658:	b9 01 00 00 00       	mov    $0x1,%ecx
 65d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 660:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 664:	89 44 24 04          	mov    %eax,0x4(%esp)
 668:	89 3c 24             	mov    %edi,(%esp)
 66b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 66e:	e8 15 fd ff ff       	call   388 <write>
      state = 0;
 673:	31 d2                	xor    %edx,%edx
 675:	e9 b1 fe ff ff       	jmp    52b <printf+0x5b>
 67a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 680:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 683:	8b 03                	mov    (%ebx),%eax
        ap++;
 685:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 688:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 68b:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 68e:	b8 01 00 00 00       	mov    $0x1,%eax
 693:	89 44 24 08          	mov    %eax,0x8(%esp)
 697:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 69a:	89 44 24 04          	mov    %eax,0x4(%esp)
 69e:	e8 e5 fc ff ff       	call   388 <write>
      state = 0;
 6a3:	31 d2                	xor    %edx,%edx
        ap++;
 6a5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 6a8:	e9 7e fe ff ff       	jmp    52b <printf+0x5b>
          s = "(null)";
 6ad:	bb 98 08 00 00       	mov    $0x898,%ebx
        while(*s != 0){
 6b2:	b0 28                	mov    $0x28,%al
 6b4:	e9 57 ff ff ff       	jmp    610 <printf+0x140>
 6b9:	66 90                	xchg   %ax,%ax
 6bb:	66 90                	xchg   %ax,%ax
 6bd:	66 90                	xchg   %ax,%ax
 6bf:	90                   	nop

000006c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c1:	a1 38 0b 00 00       	mov    0xb38,%eax
{
 6c6:	89 e5                	mov    %esp,%ebp
 6c8:	57                   	push   %edi
 6c9:	56                   	push   %esi
 6ca:	53                   	push   %ebx
 6cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 6ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 6d1:	eb 0d                	jmp    6e0 <free+0x20>
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
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e0:	39 c8                	cmp    %ecx,%eax
 6e2:	8b 10                	mov    (%eax),%edx
 6e4:	73 32                	jae    718 <free+0x58>
 6e6:	39 d1                	cmp    %edx,%ecx
 6e8:	72 04                	jb     6ee <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ea:	39 d0                	cmp    %edx,%eax
 6ec:	72 32                	jb     720 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6ee:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6f1:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6f4:	39 fa                	cmp    %edi,%edx
 6f6:	74 30                	je     728 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6f8:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6fb:	8b 50 04             	mov    0x4(%eax),%edx
 6fe:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 701:	39 f1                	cmp    %esi,%ecx
 703:	74 3c                	je     741 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 705:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 707:	5b                   	pop    %ebx
  freep = p;
 708:	a3 38 0b 00 00       	mov    %eax,0xb38
}
 70d:	5e                   	pop    %esi
 70e:	5f                   	pop    %edi
 70f:	5d                   	pop    %ebp
 710:	c3                   	ret    
 711:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 718:	39 d0                	cmp    %edx,%eax
 71a:	72 04                	jb     720 <free+0x60>
 71c:	39 d1                	cmp    %edx,%ecx
 71e:	72 ce                	jb     6ee <free+0x2e>
{
 720:	89 d0                	mov    %edx,%eax
 722:	eb bc                	jmp    6e0 <free+0x20>
 724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 728:	8b 7a 04             	mov    0x4(%edx),%edi
 72b:	01 fe                	add    %edi,%esi
 72d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 730:	8b 10                	mov    (%eax),%edx
 732:	8b 12                	mov    (%edx),%edx
 734:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 737:	8b 50 04             	mov    0x4(%eax),%edx
 73a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 73d:	39 f1                	cmp    %esi,%ecx
 73f:	75 c4                	jne    705 <free+0x45>
    p->s.size += bp->s.size;
 741:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 744:	a3 38 0b 00 00       	mov    %eax,0xb38
    p->s.size += bp->s.size;
 749:	01 ca                	add    %ecx,%edx
 74b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 74e:	8b 53 f8             	mov    -0x8(%ebx),%edx
 751:	89 10                	mov    %edx,(%eax)
}
 753:	5b                   	pop    %ebx
 754:	5e                   	pop    %esi
 755:	5f                   	pop    %edi
 756:	5d                   	pop    %ebp
 757:	c3                   	ret    
 758:	90                   	nop
 759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000760 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	57                   	push   %edi
 764:	56                   	push   %esi
 765:	53                   	push   %ebx
 766:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 769:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 76c:	8b 15 38 0b 00 00    	mov    0xb38,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 772:	8d 78 07             	lea    0x7(%eax),%edi
 775:	c1 ef 03             	shr    $0x3,%edi
 778:	47                   	inc    %edi
  if((prevp = freep) == 0){
 779:	85 d2                	test   %edx,%edx
 77b:	0f 84 8f 00 00 00    	je     810 <malloc+0xb0>
 781:	8b 02                	mov    (%edx),%eax
 783:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 786:	39 cf                	cmp    %ecx,%edi
 788:	76 66                	jbe    7f0 <malloc+0x90>
 78a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 790:	bb 00 10 00 00       	mov    $0x1000,%ebx
 795:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 798:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 79f:	eb 10                	jmp    7b1 <malloc+0x51>
 7a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7aa:	8b 48 04             	mov    0x4(%eax),%ecx
 7ad:	39 f9                	cmp    %edi,%ecx
 7af:	73 3f                	jae    7f0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7b1:	39 05 38 0b 00 00    	cmp    %eax,0xb38
 7b7:	89 c2                	mov    %eax,%edx
 7b9:	75 ed                	jne    7a8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 7bb:	89 34 24             	mov    %esi,(%esp)
 7be:	e8 2d fc ff ff       	call   3f0 <sbrk>
  if(p == (char*)-1)
 7c3:	83 f8 ff             	cmp    $0xffffffff,%eax
 7c6:	74 18                	je     7e0 <malloc+0x80>
  hp->s.size = nu;
 7c8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7cb:	83 c0 08             	add    $0x8,%eax
 7ce:	89 04 24             	mov    %eax,(%esp)
 7d1:	e8 ea fe ff ff       	call   6c0 <free>
  return freep;
 7d6:	8b 15 38 0b 00 00    	mov    0xb38,%edx
      if((p = morecore(nunits)) == 0)
 7dc:	85 d2                	test   %edx,%edx
 7de:	75 c8                	jne    7a8 <malloc+0x48>
        return 0;
  }
}
 7e0:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 7e3:	31 c0                	xor    %eax,%eax
}
 7e5:	5b                   	pop    %ebx
 7e6:	5e                   	pop    %esi
 7e7:	5f                   	pop    %edi
 7e8:	5d                   	pop    %ebp
 7e9:	c3                   	ret    
 7ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7f0:	39 cf                	cmp    %ecx,%edi
 7f2:	74 4c                	je     840 <malloc+0xe0>
        p->s.size -= nunits;
 7f4:	29 f9                	sub    %edi,%ecx
 7f6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7f9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7fc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7ff:	89 15 38 0b 00 00    	mov    %edx,0xb38
}
 805:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 808:	83 c0 08             	add    $0x8,%eax
}
 80b:	5b                   	pop    %ebx
 80c:	5e                   	pop    %esi
 80d:	5f                   	pop    %edi
 80e:	5d                   	pop    %ebp
 80f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 810:	b8 3c 0b 00 00       	mov    $0xb3c,%eax
 815:	ba 3c 0b 00 00       	mov    $0xb3c,%edx
    base.s.size = 0;
 81a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 81c:	a3 38 0b 00 00       	mov    %eax,0xb38
    base.s.size = 0;
 821:	b8 3c 0b 00 00       	mov    $0xb3c,%eax
    base.s.ptr = freep = prevp = &base;
 826:	89 15 3c 0b 00 00    	mov    %edx,0xb3c
    base.s.size = 0;
 82c:	89 0d 40 0b 00 00    	mov    %ecx,0xb40
 832:	e9 53 ff ff ff       	jmp    78a <malloc+0x2a>
 837:	89 f6                	mov    %esi,%esi
 839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 840:	8b 08                	mov    (%eax),%ecx
 842:	89 0a                	mov    %ecx,(%edx)
 844:	eb b9                	jmp    7ff <malloc+0x9f>
