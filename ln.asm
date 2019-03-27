
_ln:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	83 ec 10             	sub    $0x10,%esp
  if(argc != 3){
   a:	83 7d 08 03          	cmpl   $0x3,0x8(%ebp)
{
   e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(argc != 3){
  11:	74 20                	je     33 <main+0x33>
    printf(2, "Usage: ln old new\n");
  13:	c7 44 24 04 88 07 00 	movl   $0x788,0x4(%esp)
  1a:	00 
  1b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  22:	e8 e9 03 00 00       	call   410 <printf>
    exit(0);
  27:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  2e:	e8 75 02 00 00       	call   2a8 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  33:	8b 43 08             	mov    0x8(%ebx),%eax
  36:	89 44 24 04          	mov    %eax,0x4(%esp)
  3a:	8b 43 04             	mov    0x4(%ebx),%eax
  3d:	89 04 24             	mov    %eax,(%esp)
  40:	e8 c3 02 00 00       	call   308 <link>
  45:	85 c0                	test   %eax,%eax
  47:	78 0c                	js     55 <main+0x55>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  49:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  50:	e8 53 02 00 00       	call   2a8 <exit>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  55:	8b 43 08             	mov    0x8(%ebx),%eax
  58:	89 44 24 0c          	mov    %eax,0xc(%esp)
  5c:	8b 43 04             	mov    0x4(%ebx),%eax
  5f:	c7 44 24 04 9b 07 00 	movl   $0x79b,0x4(%esp)
  66:	00 
  67:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  6e:	89 44 24 08          	mov    %eax,0x8(%esp)
  72:	e8 99 03 00 00       	call   410 <printf>
  77:	eb d0                	jmp    49 <main+0x49>
  79:	66 90                	xchg   %ax,%ax
  7b:	66 90                	xchg   %ax,%ax
  7d:	66 90                	xchg   %ax,%ax
  7f:	90                   	nop

00000080 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	8b 45 08             	mov    0x8(%ebp),%eax
  86:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  89:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  8a:	89 c2                	mov    %eax,%edx
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  90:	41                   	inc    %ecx
  91:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  95:	42                   	inc    %edx
  96:	84 db                	test   %bl,%bl
  98:	88 5a ff             	mov    %bl,-0x1(%edx)
  9b:	75 f3                	jne    90 <strcpy+0x10>
    ;
  return os;
}
  9d:	5b                   	pop    %ebx
  9e:	5d                   	pop    %ebp
  9f:	c3                   	ret    

000000a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  a6:	53                   	push   %ebx
  a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  aa:	0f b6 01             	movzbl (%ecx),%eax
  ad:	0f b6 13             	movzbl (%ebx),%edx
  b0:	84 c0                	test   %al,%al
  b2:	75 18                	jne    cc <strcmp+0x2c>
  b4:	eb 22                	jmp    d8 <strcmp+0x38>
  b6:	8d 76 00             	lea    0x0(%esi),%esi
  b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  c0:	41                   	inc    %ecx
  while(*p && *p == *q)
  c1:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
  c4:	43                   	inc    %ebx
  c5:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
  c8:	84 c0                	test   %al,%al
  ca:	74 0c                	je     d8 <strcmp+0x38>
  cc:	38 d0                	cmp    %dl,%al
  ce:	74 f0                	je     c0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
  d0:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
  d1:	29 d0                	sub    %edx,%eax
}
  d3:	5d                   	pop    %ebp
  d4:	c3                   	ret    
  d5:	8d 76 00             	lea    0x0(%esi),%esi
  d8:	5b                   	pop    %ebx
  d9:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  db:	29 d0                	sub    %edx,%eax
}
  dd:	5d                   	pop    %ebp
  de:	c3                   	ret    
  df:	90                   	nop

000000e0 <strlen>:

uint
strlen(const char *s)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  e6:	80 39 00             	cmpb   $0x0,(%ecx)
  e9:	74 15                	je     100 <strlen+0x20>
  eb:	31 d2                	xor    %edx,%edx
  ed:	8d 76 00             	lea    0x0(%esi),%esi
  f0:	42                   	inc    %edx
  f1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  f5:	89 d0                	mov    %edx,%eax
  f7:	75 f7                	jne    f0 <strlen+0x10>
    ;
  return n;
}
  f9:	5d                   	pop    %ebp
  fa:	c3                   	ret    
  fb:	90                   	nop
  fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
 100:	31 c0                	xor    %eax,%eax
}
 102:	5d                   	pop    %ebp
 103:	c3                   	ret    
 104:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 10a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000110 <memset>:

void*
memset(void *dst, int c, uint n)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	8b 55 08             	mov    0x8(%ebp),%edx
 116:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 117:	8b 4d 10             	mov    0x10(%ebp),%ecx
 11a:	8b 45 0c             	mov    0xc(%ebp),%eax
 11d:	89 d7                	mov    %edx,%edi
 11f:	fc                   	cld    
 120:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 122:	5f                   	pop    %edi
 123:	89 d0                	mov    %edx,%eax
 125:	5d                   	pop    %ebp
 126:	c3                   	ret    
 127:	89 f6                	mov    %esi,%esi
 129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000130 <strchr>:

char*
strchr(const char *s, char c)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	8b 45 08             	mov    0x8(%ebp),%eax
 136:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 13a:	0f b6 10             	movzbl (%eax),%edx
 13d:	84 d2                	test   %dl,%dl
 13f:	74 1b                	je     15c <strchr+0x2c>
    if(*s == c)
 141:	38 d1                	cmp    %dl,%cl
 143:	75 0f                	jne    154 <strchr+0x24>
 145:	eb 17                	jmp    15e <strchr+0x2e>
 147:	89 f6                	mov    %esi,%esi
 149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 150:	38 ca                	cmp    %cl,%dl
 152:	74 0a                	je     15e <strchr+0x2e>
  for(; *s; s++)
 154:	40                   	inc    %eax
 155:	0f b6 10             	movzbl (%eax),%edx
 158:	84 d2                	test   %dl,%dl
 15a:	75 f4                	jne    150 <strchr+0x20>
      return (char*)s;
  return 0;
 15c:	31 c0                	xor    %eax,%eax
}
 15e:	5d                   	pop    %ebp
 15f:	c3                   	ret    

00000160 <gets>:

char*
gets(char *buf, int max)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	57                   	push   %edi
 164:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 165:	31 f6                	xor    %esi,%esi
{
 167:	53                   	push   %ebx
 168:	83 ec 3c             	sub    $0x3c,%esp
 16b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
 16e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 171:	eb 32                	jmp    1a5 <gets+0x45>
 173:	90                   	nop
 174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 178:	ba 01 00 00 00       	mov    $0x1,%edx
 17d:	89 54 24 08          	mov    %edx,0x8(%esp)
 181:	89 7c 24 04          	mov    %edi,0x4(%esp)
 185:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 18c:	e8 2f 01 00 00       	call   2c0 <read>
    if(cc < 1)
 191:	85 c0                	test   %eax,%eax
 193:	7e 19                	jle    1ae <gets+0x4e>
      break;
    buf[i++] = c;
 195:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 199:	43                   	inc    %ebx
 19a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
 19d:	3c 0a                	cmp    $0xa,%al
 19f:	74 1f                	je     1c0 <gets+0x60>
 1a1:	3c 0d                	cmp    $0xd,%al
 1a3:	74 1b                	je     1c0 <gets+0x60>
  for(i=0; i+1 < max; ){
 1a5:	46                   	inc    %esi
 1a6:	3b 75 0c             	cmp    0xc(%ebp),%esi
 1a9:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 1ac:	7c ca                	jl     178 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 1ae:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 1b1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 1b4:	8b 45 08             	mov    0x8(%ebp),%eax
 1b7:	83 c4 3c             	add    $0x3c,%esp
 1ba:	5b                   	pop    %ebx
 1bb:	5e                   	pop    %esi
 1bc:	5f                   	pop    %edi
 1bd:	5d                   	pop    %ebp
 1be:	c3                   	ret    
 1bf:	90                   	nop
 1c0:	8b 45 08             	mov    0x8(%ebp),%eax
 1c3:	01 c6                	add    %eax,%esi
 1c5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 1c8:	eb e4                	jmp    1ae <gets+0x4e>
 1ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1d0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d1:	31 c0                	xor    %eax,%eax
{
 1d3:	89 e5                	mov    %esp,%ebp
 1d5:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 1d8:	89 44 24 04          	mov    %eax,0x4(%esp)
 1dc:	8b 45 08             	mov    0x8(%ebp),%eax
{
 1df:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1e2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 1e5:	89 04 24             	mov    %eax,(%esp)
 1e8:	e8 fb 00 00 00       	call   2e8 <open>
  if(fd < 0)
 1ed:	85 c0                	test   %eax,%eax
 1ef:	78 2f                	js     220 <stat+0x50>
 1f1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1f3:	8b 45 0c             	mov    0xc(%ebp),%eax
 1f6:	89 1c 24             	mov    %ebx,(%esp)
 1f9:	89 44 24 04          	mov    %eax,0x4(%esp)
 1fd:	e8 fe 00 00 00       	call   300 <fstat>
  close(fd);
 202:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 205:	89 c6                	mov    %eax,%esi
  close(fd);
 207:	e8 c4 00 00 00       	call   2d0 <close>
  return r;
}
 20c:	89 f0                	mov    %esi,%eax
 20e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 211:	8b 75 fc             	mov    -0x4(%ebp),%esi
 214:	89 ec                	mov    %ebp,%esp
 216:	5d                   	pop    %ebp
 217:	c3                   	ret    
 218:	90                   	nop
 219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 220:	be ff ff ff ff       	mov    $0xffffffff,%esi
 225:	eb e5                	jmp    20c <stat+0x3c>
 227:	89 f6                	mov    %esi,%esi
 229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000230 <atoi>:

int
atoi(const char *s)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	8b 4d 08             	mov    0x8(%ebp),%ecx
 236:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 237:	0f be 11             	movsbl (%ecx),%edx
 23a:	88 d0                	mov    %dl,%al
 23c:	2c 30                	sub    $0x30,%al
 23e:	3c 09                	cmp    $0x9,%al
  n = 0;
 240:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 245:	77 1e                	ja     265 <atoi+0x35>
 247:	89 f6                	mov    %esi,%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 250:	41                   	inc    %ecx
 251:	8d 04 80             	lea    (%eax,%eax,4),%eax
 254:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 258:	0f be 11             	movsbl (%ecx),%edx
 25b:	88 d3                	mov    %dl,%bl
 25d:	80 eb 30             	sub    $0x30,%bl
 260:	80 fb 09             	cmp    $0x9,%bl
 263:	76 eb                	jbe    250 <atoi+0x20>
  return n;
}
 265:	5b                   	pop    %ebx
 266:	5d                   	pop    %ebp
 267:	c3                   	ret    
 268:	90                   	nop
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000270 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	56                   	push   %esi
 274:	8b 45 08             	mov    0x8(%ebp),%eax
 277:	53                   	push   %ebx
 278:	8b 5d 10             	mov    0x10(%ebp),%ebx
 27b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 27e:	85 db                	test   %ebx,%ebx
 280:	7e 1a                	jle    29c <memmove+0x2c>
 282:	31 d2                	xor    %edx,%edx
 284:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 28a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 290:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 294:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 297:	42                   	inc    %edx
  while(n-- > 0)
 298:	39 d3                	cmp    %edx,%ebx
 29a:	75 f4                	jne    290 <memmove+0x20>
  return vdst;
}
 29c:	5b                   	pop    %ebx
 29d:	5e                   	pop    %esi
 29e:	5d                   	pop    %ebp
 29f:	c3                   	ret    

000002a0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2a0:	b8 01 00 00 00       	mov    $0x1,%eax
 2a5:	cd 40                	int    $0x40
 2a7:	c3                   	ret    

000002a8 <exit>:
SYSCALL(exit)
 2a8:	b8 02 00 00 00       	mov    $0x2,%eax
 2ad:	cd 40                	int    $0x40
 2af:	c3                   	ret    

000002b0 <wait>:
SYSCALL(wait)
 2b0:	b8 03 00 00 00       	mov    $0x3,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <pipe>:
SYSCALL(pipe)
 2b8:	b8 04 00 00 00       	mov    $0x4,%eax
 2bd:	cd 40                	int    $0x40
 2bf:	c3                   	ret    

000002c0 <read>:
SYSCALL(read)
 2c0:	b8 05 00 00 00       	mov    $0x5,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <write>:
SYSCALL(write)
 2c8:	b8 10 00 00 00       	mov    $0x10,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <close>:
SYSCALL(close)
 2d0:	b8 15 00 00 00       	mov    $0x15,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <kill>:
SYSCALL(kill)
 2d8:	b8 06 00 00 00       	mov    $0x6,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <exec>:
SYSCALL(exec)
 2e0:	b8 07 00 00 00       	mov    $0x7,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <open>:
SYSCALL(open)
 2e8:	b8 0f 00 00 00       	mov    $0xf,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <mknod>:
SYSCALL(mknod)
 2f0:	b8 11 00 00 00       	mov    $0x11,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <unlink>:
SYSCALL(unlink)
 2f8:	b8 12 00 00 00       	mov    $0x12,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <fstat>:
SYSCALL(fstat)
 300:	b8 08 00 00 00       	mov    $0x8,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <link>:
SYSCALL(link)
 308:	b8 13 00 00 00       	mov    $0x13,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <mkdir>:
SYSCALL(mkdir)
 310:	b8 14 00 00 00       	mov    $0x14,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <chdir>:
SYSCALL(chdir)
 318:	b8 09 00 00 00       	mov    $0x9,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <dup>:
SYSCALL(dup)
 320:	b8 0a 00 00 00       	mov    $0xa,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <getpid>:
SYSCALL(getpid)
 328:	b8 0b 00 00 00       	mov    $0xb,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <sbrk>:
SYSCALL(sbrk)
 330:	b8 0c 00 00 00       	mov    $0xc,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <sleep>:
SYSCALL(sleep)
 338:	b8 0d 00 00 00       	mov    $0xd,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <uptime>:
SYSCALL(uptime)
 340:	b8 0e 00 00 00       	mov    $0xe,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <detach>:
SYSCALL(detach)
 348:	b8 16 00 00 00       	mov    $0x16,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <priority>:
SYSCALL(priority)
 350:	b8 17 00 00 00       	mov    $0x17,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <policy>:
SYSCALL(policy)
 358:	b8 18 00 00 00       	mov    $0x18,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <wait_stat>:
SYSCALL(wait_stat)
 360:	b8 19 00 00 00       	mov    $0x19,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    
 368:	66 90                	xchg   %ax,%ax
 36a:	66 90                	xchg   %ax,%ax
 36c:	66 90                	xchg   %ax,%ax
 36e:	66 90                	xchg   %ax,%ax

00000370 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	57                   	push   %edi
 374:	56                   	push   %esi
 375:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 376:	89 d3                	mov    %edx,%ebx
 378:	c1 eb 1f             	shr    $0x1f,%ebx
{
 37b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 37e:	84 db                	test   %bl,%bl
{
 380:	89 45 c0             	mov    %eax,-0x40(%ebp)
 383:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 385:	74 79                	je     400 <printint+0x90>
 387:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 38b:	74 73                	je     400 <printint+0x90>
    neg = 1;
    x = -xx;
 38d:	f7 d8                	neg    %eax
    neg = 1;
 38f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 396:	31 f6                	xor    %esi,%esi
 398:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 39b:	eb 05                	jmp    3a2 <printint+0x32>
 39d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 3a0:	89 fe                	mov    %edi,%esi
 3a2:	31 d2                	xor    %edx,%edx
 3a4:	f7 f1                	div    %ecx
 3a6:	8d 7e 01             	lea    0x1(%esi),%edi
 3a9:	0f b6 92 b8 07 00 00 	movzbl 0x7b8(%edx),%edx
  }while((x /= base) != 0);
 3b0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 3b2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 3b5:	75 e9                	jne    3a0 <printint+0x30>
  if(neg)
 3b7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 3ba:	85 d2                	test   %edx,%edx
 3bc:	74 08                	je     3c6 <printint+0x56>
    buf[i++] = '-';
 3be:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 3c3:	8d 7e 02             	lea    0x2(%esi),%edi
 3c6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 3ca:	8b 7d c0             	mov    -0x40(%ebp),%edi
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
 3d0:	0f b6 06             	movzbl (%esi),%eax
 3d3:	4e                   	dec    %esi
  write(fd, &c, 1);
 3d4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 3d8:	89 3c 24             	mov    %edi,(%esp)
 3db:	88 45 d7             	mov    %al,-0x29(%ebp)
 3de:	b8 01 00 00 00       	mov    $0x1,%eax
 3e3:	89 44 24 08          	mov    %eax,0x8(%esp)
 3e7:	e8 dc fe ff ff       	call   2c8 <write>

  while(--i >= 0)
 3ec:	39 de                	cmp    %ebx,%esi
 3ee:	75 e0                	jne    3d0 <printint+0x60>
    putc(fd, buf[i]);
}
 3f0:	83 c4 4c             	add    $0x4c,%esp
 3f3:	5b                   	pop    %ebx
 3f4:	5e                   	pop    %esi
 3f5:	5f                   	pop    %edi
 3f6:	5d                   	pop    %ebp
 3f7:	c3                   	ret    
 3f8:	90                   	nop
 3f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 400:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 407:	eb 8d                	jmp    396 <printint+0x26>
 409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000410 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
 416:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 419:	8b 75 0c             	mov    0xc(%ebp),%esi
 41c:	0f b6 1e             	movzbl (%esi),%ebx
 41f:	84 db                	test   %bl,%bl
 421:	0f 84 d1 00 00 00    	je     4f8 <printf+0xe8>
  state = 0;
 427:	31 ff                	xor    %edi,%edi
 429:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 42a:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 42d:	89 fa                	mov    %edi,%edx
 42f:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 432:	89 45 d0             	mov    %eax,-0x30(%ebp)
 435:	eb 41                	jmp    478 <printf+0x68>
 437:	89 f6                	mov    %esi,%esi
 439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 440:	83 f8 25             	cmp    $0x25,%eax
 443:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 446:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 44b:	74 1e                	je     46b <printf+0x5b>
  write(fd, &c, 1);
 44d:	b8 01 00 00 00       	mov    $0x1,%eax
 452:	89 44 24 08          	mov    %eax,0x8(%esp)
 456:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 459:	89 44 24 04          	mov    %eax,0x4(%esp)
 45d:	89 3c 24             	mov    %edi,(%esp)
 460:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 463:	e8 60 fe ff ff       	call   2c8 <write>
 468:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 46b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 46c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 470:	84 db                	test   %bl,%bl
 472:	0f 84 80 00 00 00    	je     4f8 <printf+0xe8>
    if(state == 0){
 478:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 47a:	0f be cb             	movsbl %bl,%ecx
 47d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 480:	74 be                	je     440 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 482:	83 fa 25             	cmp    $0x25,%edx
 485:	75 e4                	jne    46b <printf+0x5b>
      if(c == 'd'){
 487:	83 f8 64             	cmp    $0x64,%eax
 48a:	0f 84 f0 00 00 00    	je     580 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 490:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 496:	83 f9 70             	cmp    $0x70,%ecx
 499:	74 65                	je     500 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 49b:	83 f8 73             	cmp    $0x73,%eax
 49e:	0f 84 8c 00 00 00    	je     530 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4a4:	83 f8 63             	cmp    $0x63,%eax
 4a7:	0f 84 13 01 00 00    	je     5c0 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4ad:	83 f8 25             	cmp    $0x25,%eax
 4b0:	0f 84 e2 00 00 00    	je     598 <printf+0x188>
  write(fd, &c, 1);
 4b6:	b8 01 00 00 00       	mov    $0x1,%eax
 4bb:	46                   	inc    %esi
 4bc:	89 44 24 08          	mov    %eax,0x8(%esp)
 4c0:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4c3:	89 44 24 04          	mov    %eax,0x4(%esp)
 4c7:	89 3c 24             	mov    %edi,(%esp)
 4ca:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4ce:	e8 f5 fd ff ff       	call   2c8 <write>
 4d3:	ba 01 00 00 00       	mov    $0x1,%edx
 4d8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4db:	89 54 24 08          	mov    %edx,0x8(%esp)
 4df:	89 44 24 04          	mov    %eax,0x4(%esp)
 4e3:	89 3c 24             	mov    %edi,(%esp)
 4e6:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 4e9:	e8 da fd ff ff       	call   2c8 <write>
  for(i = 0; fmt[i]; i++){
 4ee:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4f2:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 4f4:	84 db                	test   %bl,%bl
 4f6:	75 80                	jne    478 <printf+0x68>
    }
  }
}
 4f8:	83 c4 3c             	add    $0x3c,%esp
 4fb:	5b                   	pop    %ebx
 4fc:	5e                   	pop    %esi
 4fd:	5f                   	pop    %edi
 4fe:	5d                   	pop    %ebp
 4ff:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 500:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 507:	b9 10 00 00 00       	mov    $0x10,%ecx
 50c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 50f:	89 f8                	mov    %edi,%eax
 511:	8b 13                	mov    (%ebx),%edx
 513:	e8 58 fe ff ff       	call   370 <printint>
        ap++;
 518:	89 d8                	mov    %ebx,%eax
      state = 0;
 51a:	31 d2                	xor    %edx,%edx
        ap++;
 51c:	83 c0 04             	add    $0x4,%eax
 51f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 522:	e9 44 ff ff ff       	jmp    46b <printf+0x5b>
 527:	89 f6                	mov    %esi,%esi
 529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 530:	8b 45 d0             	mov    -0x30(%ebp),%eax
 533:	8b 10                	mov    (%eax),%edx
        ap++;
 535:	83 c0 04             	add    $0x4,%eax
 538:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 53b:	85 d2                	test   %edx,%edx
 53d:	0f 84 aa 00 00 00    	je     5ed <printf+0x1dd>
        while(*s != 0){
 543:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 546:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 548:	84 c0                	test   %al,%al
 54a:	74 27                	je     573 <printf+0x163>
 54c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 550:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 553:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 558:	43                   	inc    %ebx
  write(fd, &c, 1);
 559:	89 44 24 08          	mov    %eax,0x8(%esp)
 55d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 560:	89 44 24 04          	mov    %eax,0x4(%esp)
 564:	89 3c 24             	mov    %edi,(%esp)
 567:	e8 5c fd ff ff       	call   2c8 <write>
        while(*s != 0){
 56c:	0f b6 03             	movzbl (%ebx),%eax
 56f:	84 c0                	test   %al,%al
 571:	75 dd                	jne    550 <printf+0x140>
      state = 0;
 573:	31 d2                	xor    %edx,%edx
 575:	e9 f1 fe ff ff       	jmp    46b <printf+0x5b>
 57a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 580:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 587:	b9 0a 00 00 00       	mov    $0xa,%ecx
 58c:	e9 7b ff ff ff       	jmp    50c <printf+0xfc>
 591:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 598:	b9 01 00 00 00       	mov    $0x1,%ecx
 59d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 5a0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 5a4:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a8:	89 3c 24             	mov    %edi,(%esp)
 5ab:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 5ae:	e8 15 fd ff ff       	call   2c8 <write>
      state = 0;
 5b3:	31 d2                	xor    %edx,%edx
 5b5:	e9 b1 fe ff ff       	jmp    46b <printf+0x5b>
 5ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 5c0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5c3:	8b 03                	mov    (%ebx),%eax
        ap++;
 5c5:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 5c8:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 5cb:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 5ce:	b8 01 00 00 00       	mov    $0x1,%eax
 5d3:	89 44 24 08          	mov    %eax,0x8(%esp)
 5d7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5da:	89 44 24 04          	mov    %eax,0x4(%esp)
 5de:	e8 e5 fc ff ff       	call   2c8 <write>
      state = 0;
 5e3:	31 d2                	xor    %edx,%edx
        ap++;
 5e5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5e8:	e9 7e fe ff ff       	jmp    46b <printf+0x5b>
          s = "(null)";
 5ed:	bb af 07 00 00       	mov    $0x7af,%ebx
        while(*s != 0){
 5f2:	b0 28                	mov    $0x28,%al
 5f4:	e9 57 ff ff ff       	jmp    550 <printf+0x140>
 5f9:	66 90                	xchg   %ax,%ax
 5fb:	66 90                	xchg   %ax,%ax
 5fd:	66 90                	xchg   %ax,%ax
 5ff:	90                   	nop

00000600 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 600:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 601:	a1 44 0a 00 00       	mov    0xa44,%eax
{
 606:	89 e5                	mov    %esp,%ebp
 608:	57                   	push   %edi
 609:	56                   	push   %esi
 60a:	53                   	push   %ebx
 60b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 60e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 611:	eb 0d                	jmp    620 <free+0x20>
 613:	90                   	nop
 614:	90                   	nop
 615:	90                   	nop
 616:	90                   	nop
 617:	90                   	nop
 618:	90                   	nop
 619:	90                   	nop
 61a:	90                   	nop
 61b:	90                   	nop
 61c:	90                   	nop
 61d:	90                   	nop
 61e:	90                   	nop
 61f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 620:	39 c8                	cmp    %ecx,%eax
 622:	8b 10                	mov    (%eax),%edx
 624:	73 32                	jae    658 <free+0x58>
 626:	39 d1                	cmp    %edx,%ecx
 628:	72 04                	jb     62e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 62a:	39 d0                	cmp    %edx,%eax
 62c:	72 32                	jb     660 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 62e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 631:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 634:	39 fa                	cmp    %edi,%edx
 636:	74 30                	je     668 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 638:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 63b:	8b 50 04             	mov    0x4(%eax),%edx
 63e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 641:	39 f1                	cmp    %esi,%ecx
 643:	74 3c                	je     681 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 645:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 647:	5b                   	pop    %ebx
  freep = p;
 648:	a3 44 0a 00 00       	mov    %eax,0xa44
}
 64d:	5e                   	pop    %esi
 64e:	5f                   	pop    %edi
 64f:	5d                   	pop    %ebp
 650:	c3                   	ret    
 651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 658:	39 d0                	cmp    %edx,%eax
 65a:	72 04                	jb     660 <free+0x60>
 65c:	39 d1                	cmp    %edx,%ecx
 65e:	72 ce                	jb     62e <free+0x2e>
{
 660:	89 d0                	mov    %edx,%eax
 662:	eb bc                	jmp    620 <free+0x20>
 664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 668:	8b 7a 04             	mov    0x4(%edx),%edi
 66b:	01 fe                	add    %edi,%esi
 66d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 670:	8b 10                	mov    (%eax),%edx
 672:	8b 12                	mov    (%edx),%edx
 674:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 677:	8b 50 04             	mov    0x4(%eax),%edx
 67a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 67d:	39 f1                	cmp    %esi,%ecx
 67f:	75 c4                	jne    645 <free+0x45>
    p->s.size += bp->s.size;
 681:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 684:	a3 44 0a 00 00       	mov    %eax,0xa44
    p->s.size += bp->s.size;
 689:	01 ca                	add    %ecx,%edx
 68b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 68e:	8b 53 f8             	mov    -0x8(%ebx),%edx
 691:	89 10                	mov    %edx,(%eax)
}
 693:	5b                   	pop    %ebx
 694:	5e                   	pop    %esi
 695:	5f                   	pop    %edi
 696:	5d                   	pop    %ebp
 697:	c3                   	ret    
 698:	90                   	nop
 699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	57                   	push   %edi
 6a4:	56                   	push   %esi
 6a5:	53                   	push   %ebx
 6a6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6ac:	8b 15 44 0a 00 00    	mov    0xa44,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6b2:	8d 78 07             	lea    0x7(%eax),%edi
 6b5:	c1 ef 03             	shr    $0x3,%edi
 6b8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 6b9:	85 d2                	test   %edx,%edx
 6bb:	0f 84 8f 00 00 00    	je     750 <malloc+0xb0>
 6c1:	8b 02                	mov    (%edx),%eax
 6c3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6c6:	39 cf                	cmp    %ecx,%edi
 6c8:	76 66                	jbe    730 <malloc+0x90>
 6ca:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 6d0:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6d5:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 6d8:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6df:	eb 10                	jmp    6f1 <malloc+0x51>
 6e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6e8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6ea:	8b 48 04             	mov    0x4(%eax),%ecx
 6ed:	39 f9                	cmp    %edi,%ecx
 6ef:	73 3f                	jae    730 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6f1:	39 05 44 0a 00 00    	cmp    %eax,0xa44
 6f7:	89 c2                	mov    %eax,%edx
 6f9:	75 ed                	jne    6e8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 6fb:	89 34 24             	mov    %esi,(%esp)
 6fe:	e8 2d fc ff ff       	call   330 <sbrk>
  if(p == (char*)-1)
 703:	83 f8 ff             	cmp    $0xffffffff,%eax
 706:	74 18                	je     720 <malloc+0x80>
  hp->s.size = nu;
 708:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 70b:	83 c0 08             	add    $0x8,%eax
 70e:	89 04 24             	mov    %eax,(%esp)
 711:	e8 ea fe ff ff       	call   600 <free>
  return freep;
 716:	8b 15 44 0a 00 00    	mov    0xa44,%edx
      if((p = morecore(nunits)) == 0)
 71c:	85 d2                	test   %edx,%edx
 71e:	75 c8                	jne    6e8 <malloc+0x48>
        return 0;
  }
}
 720:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 723:	31 c0                	xor    %eax,%eax
}
 725:	5b                   	pop    %ebx
 726:	5e                   	pop    %esi
 727:	5f                   	pop    %edi
 728:	5d                   	pop    %ebp
 729:	c3                   	ret    
 72a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 730:	39 cf                	cmp    %ecx,%edi
 732:	74 4c                	je     780 <malloc+0xe0>
        p->s.size -= nunits;
 734:	29 f9                	sub    %edi,%ecx
 736:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 739:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 73c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 73f:	89 15 44 0a 00 00    	mov    %edx,0xa44
}
 745:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 748:	83 c0 08             	add    $0x8,%eax
}
 74b:	5b                   	pop    %ebx
 74c:	5e                   	pop    %esi
 74d:	5f                   	pop    %edi
 74e:	5d                   	pop    %ebp
 74f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 750:	b8 48 0a 00 00       	mov    $0xa48,%eax
 755:	ba 48 0a 00 00       	mov    $0xa48,%edx
    base.s.size = 0;
 75a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 75c:	a3 44 0a 00 00       	mov    %eax,0xa44
    base.s.size = 0;
 761:	b8 48 0a 00 00       	mov    $0xa48,%eax
    base.s.ptr = freep = prevp = &base;
 766:	89 15 48 0a 00 00    	mov    %edx,0xa48
    base.s.size = 0;
 76c:	89 0d 4c 0a 00 00    	mov    %ecx,0xa4c
 772:	e9 53 ff ff ff       	jmp    6ca <malloc+0x2a>
 777:	89 f6                	mov    %esi,%esi
 779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 780:	8b 08                	mov    (%eax),%ecx
 782:	89 0a                	mov    %ecx,(%edx)
 784:	eb b9                	jmp    73f <malloc+0x9f>
