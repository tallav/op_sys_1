
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	56                   	push   %esi
   4:	53                   	push   %ebx
   5:	83 e4 f0             	and    $0xfffffff0,%esp
   8:	83 ec 10             	sub    $0x10,%esp
   b:	8b 45 08             	mov    0x8(%ebp),%eax
   e:	8b 55 0c             	mov    0xc(%ebp),%edx
  int i;

  if(argc < 2){
  11:	83 f8 01             	cmp    $0x1,%eax
  14:	7e 2f                	jle    45 <main+0x45>
  16:	8d 5a 04             	lea    0x4(%edx),%ebx
  19:	8d 34 82             	lea    (%edx,%eax,4),%esi
  1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "usage: kill pid...\n");
    exit(0);
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  20:	8b 03                	mov    (%ebx),%eax
  22:	83 c3 04             	add    $0x4,%ebx
  25:	89 04 24             	mov    %eax,(%esp)
  28:	e8 f3 01 00 00       	call   220 <atoi>
  2d:	89 04 24             	mov    %eax,(%esp)
  30:	e8 93 02 00 00       	call   2c8 <kill>
  for(i=1; i<argc; i++)
  35:	39 f3                	cmp    %esi,%ebx
  37:	75 e7                	jne    20 <main+0x20>
  exit(0);
  39:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  40:	e8 53 02 00 00       	call   298 <exit>
    printf(2, "usage: kill pid...\n");
  45:	c7 44 24 04 78 07 00 	movl   $0x778,0x4(%esp)
  4c:	00 
  4d:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  54:	e8 a7 03 00 00       	call   400 <printf>
    exit(0);
  59:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  60:	e8 33 02 00 00       	call   298 <exit>
  65:	66 90                	xchg   %ax,%ax
  67:	66 90                	xchg   %ax,%ax
  69:	66 90                	xchg   %ax,%ax
  6b:	66 90                	xchg   %ax,%ax
  6d:	66 90                	xchg   %ax,%ax
  6f:	90                   	nop

00000070 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	8b 45 08             	mov    0x8(%ebp),%eax
  76:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  79:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  7a:	89 c2                	mov    %eax,%edx
  7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  80:	41                   	inc    %ecx
  81:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  85:	42                   	inc    %edx
  86:	84 db                	test   %bl,%bl
  88:	88 5a ff             	mov    %bl,-0x1(%edx)
  8b:	75 f3                	jne    80 <strcpy+0x10>
    ;
  return os;
}
  8d:	5b                   	pop    %ebx
  8e:	5d                   	pop    %ebp
  8f:	c3                   	ret    

00000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	8b 4d 08             	mov    0x8(%ebp),%ecx
  96:	53                   	push   %ebx
  97:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  9a:	0f b6 01             	movzbl (%ecx),%eax
  9d:	0f b6 13             	movzbl (%ebx),%edx
  a0:	84 c0                	test   %al,%al
  a2:	75 18                	jne    bc <strcmp+0x2c>
  a4:	eb 22                	jmp    c8 <strcmp+0x38>
  a6:	8d 76 00             	lea    0x0(%esi),%esi
  a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  b0:	41                   	inc    %ecx
  while(*p && *p == *q)
  b1:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
  b4:	43                   	inc    %ebx
  b5:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
  b8:	84 c0                	test   %al,%al
  ba:	74 0c                	je     c8 <strcmp+0x38>
  bc:	38 d0                	cmp    %dl,%al
  be:	74 f0                	je     b0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
  c0:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
  c1:	29 d0                	sub    %edx,%eax
}
  c3:	5d                   	pop    %ebp
  c4:	c3                   	ret    
  c5:	8d 76 00             	lea    0x0(%esi),%esi
  c8:	5b                   	pop    %ebx
  c9:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  cb:	29 d0                	sub    %edx,%eax
}
  cd:	5d                   	pop    %ebp
  ce:	c3                   	ret    
  cf:	90                   	nop

000000d0 <strlen>:

uint
strlen(const char *s)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  d6:	80 39 00             	cmpb   $0x0,(%ecx)
  d9:	74 15                	je     f0 <strlen+0x20>
  db:	31 d2                	xor    %edx,%edx
  dd:	8d 76 00             	lea    0x0(%esi),%esi
  e0:	42                   	inc    %edx
  e1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  e5:	89 d0                	mov    %edx,%eax
  e7:	75 f7                	jne    e0 <strlen+0x10>
    ;
  return n;
}
  e9:	5d                   	pop    %ebp
  ea:	c3                   	ret    
  eb:	90                   	nop
  ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
  f0:	31 c0                	xor    %eax,%eax
}
  f2:	5d                   	pop    %ebp
  f3:	c3                   	ret    
  f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000100 <memset>:

void*
memset(void *dst, int c, uint n)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 55 08             	mov    0x8(%ebp),%edx
 106:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 107:	8b 4d 10             	mov    0x10(%ebp),%ecx
 10a:	8b 45 0c             	mov    0xc(%ebp),%eax
 10d:	89 d7                	mov    %edx,%edi
 10f:	fc                   	cld    
 110:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 112:	5f                   	pop    %edi
 113:	89 d0                	mov    %edx,%eax
 115:	5d                   	pop    %ebp
 116:	c3                   	ret    
 117:	89 f6                	mov    %esi,%esi
 119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000120 <strchr>:

char*
strchr(const char *s, char c)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 45 08             	mov    0x8(%ebp),%eax
 126:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 12a:	0f b6 10             	movzbl (%eax),%edx
 12d:	84 d2                	test   %dl,%dl
 12f:	74 1b                	je     14c <strchr+0x2c>
    if(*s == c)
 131:	38 d1                	cmp    %dl,%cl
 133:	75 0f                	jne    144 <strchr+0x24>
 135:	eb 17                	jmp    14e <strchr+0x2e>
 137:	89 f6                	mov    %esi,%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 140:	38 ca                	cmp    %cl,%dl
 142:	74 0a                	je     14e <strchr+0x2e>
  for(; *s; s++)
 144:	40                   	inc    %eax
 145:	0f b6 10             	movzbl (%eax),%edx
 148:	84 d2                	test   %dl,%dl
 14a:	75 f4                	jne    140 <strchr+0x20>
      return (char*)s;
  return 0;
 14c:	31 c0                	xor    %eax,%eax
}
 14e:	5d                   	pop    %ebp
 14f:	c3                   	ret    

00000150 <gets>:

char*
gets(char *buf, int max)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	57                   	push   %edi
 154:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 155:	31 f6                	xor    %esi,%esi
{
 157:	53                   	push   %ebx
 158:	83 ec 3c             	sub    $0x3c,%esp
 15b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
 15e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 161:	eb 32                	jmp    195 <gets+0x45>
 163:	90                   	nop
 164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 168:	ba 01 00 00 00       	mov    $0x1,%edx
 16d:	89 54 24 08          	mov    %edx,0x8(%esp)
 171:	89 7c 24 04          	mov    %edi,0x4(%esp)
 175:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 17c:	e8 2f 01 00 00       	call   2b0 <read>
    if(cc < 1)
 181:	85 c0                	test   %eax,%eax
 183:	7e 19                	jle    19e <gets+0x4e>
      break;
    buf[i++] = c;
 185:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 189:	43                   	inc    %ebx
 18a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
 18d:	3c 0a                	cmp    $0xa,%al
 18f:	74 1f                	je     1b0 <gets+0x60>
 191:	3c 0d                	cmp    $0xd,%al
 193:	74 1b                	je     1b0 <gets+0x60>
  for(i=0; i+1 < max; ){
 195:	46                   	inc    %esi
 196:	3b 75 0c             	cmp    0xc(%ebp),%esi
 199:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 19c:	7c ca                	jl     168 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 19e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 1a1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 1a4:	8b 45 08             	mov    0x8(%ebp),%eax
 1a7:	83 c4 3c             	add    $0x3c,%esp
 1aa:	5b                   	pop    %ebx
 1ab:	5e                   	pop    %esi
 1ac:	5f                   	pop    %edi
 1ad:	5d                   	pop    %ebp
 1ae:	c3                   	ret    
 1af:	90                   	nop
 1b0:	8b 45 08             	mov    0x8(%ebp),%eax
 1b3:	01 c6                	add    %eax,%esi
 1b5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 1b8:	eb e4                	jmp    19e <gets+0x4e>
 1ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001c0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1c0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c1:	31 c0                	xor    %eax,%eax
{
 1c3:	89 e5                	mov    %esp,%ebp
 1c5:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 1c8:	89 44 24 04          	mov    %eax,0x4(%esp)
 1cc:	8b 45 08             	mov    0x8(%ebp),%eax
{
 1cf:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1d2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 1d5:	89 04 24             	mov    %eax,(%esp)
 1d8:	e8 fb 00 00 00       	call   2d8 <open>
  if(fd < 0)
 1dd:	85 c0                	test   %eax,%eax
 1df:	78 2f                	js     210 <stat+0x50>
 1e1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1e3:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e6:	89 1c 24             	mov    %ebx,(%esp)
 1e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 1ed:	e8 fe 00 00 00       	call   2f0 <fstat>
  close(fd);
 1f2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1f5:	89 c6                	mov    %eax,%esi
  close(fd);
 1f7:	e8 c4 00 00 00       	call   2c0 <close>
  return r;
}
 1fc:	89 f0                	mov    %esi,%eax
 1fe:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 201:	8b 75 fc             	mov    -0x4(%ebp),%esi
 204:	89 ec                	mov    %ebp,%esp
 206:	5d                   	pop    %ebp
 207:	c3                   	ret    
 208:	90                   	nop
 209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 210:	be ff ff ff ff       	mov    $0xffffffff,%esi
 215:	eb e5                	jmp    1fc <stat+0x3c>
 217:	89 f6                	mov    %esi,%esi
 219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000220 <atoi>:

int
atoi(const char *s)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	8b 4d 08             	mov    0x8(%ebp),%ecx
 226:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 227:	0f be 11             	movsbl (%ecx),%edx
 22a:	88 d0                	mov    %dl,%al
 22c:	2c 30                	sub    $0x30,%al
 22e:	3c 09                	cmp    $0x9,%al
  n = 0;
 230:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 235:	77 1e                	ja     255 <atoi+0x35>
 237:	89 f6                	mov    %esi,%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 240:	41                   	inc    %ecx
 241:	8d 04 80             	lea    (%eax,%eax,4),%eax
 244:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 248:	0f be 11             	movsbl (%ecx),%edx
 24b:	88 d3                	mov    %dl,%bl
 24d:	80 eb 30             	sub    $0x30,%bl
 250:	80 fb 09             	cmp    $0x9,%bl
 253:	76 eb                	jbe    240 <atoi+0x20>
  return n;
}
 255:	5b                   	pop    %ebx
 256:	5d                   	pop    %ebp
 257:	c3                   	ret    
 258:	90                   	nop
 259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000260 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	56                   	push   %esi
 264:	8b 45 08             	mov    0x8(%ebp),%eax
 267:	53                   	push   %ebx
 268:	8b 5d 10             	mov    0x10(%ebp),%ebx
 26b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 26e:	85 db                	test   %ebx,%ebx
 270:	7e 1a                	jle    28c <memmove+0x2c>
 272:	31 d2                	xor    %edx,%edx
 274:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 27a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 280:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 284:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 287:	42                   	inc    %edx
  while(n-- > 0)
 288:	39 d3                	cmp    %edx,%ebx
 28a:	75 f4                	jne    280 <memmove+0x20>
  return vdst;
}
 28c:	5b                   	pop    %ebx
 28d:	5e                   	pop    %esi
 28e:	5d                   	pop    %ebp
 28f:	c3                   	ret    

00000290 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 290:	b8 01 00 00 00       	mov    $0x1,%eax
 295:	cd 40                	int    $0x40
 297:	c3                   	ret    

00000298 <exit>:
SYSCALL(exit)
 298:	b8 02 00 00 00       	mov    $0x2,%eax
 29d:	cd 40                	int    $0x40
 29f:	c3                   	ret    

000002a0 <wait>:
SYSCALL(wait)
 2a0:	b8 03 00 00 00       	mov    $0x3,%eax
 2a5:	cd 40                	int    $0x40
 2a7:	c3                   	ret    

000002a8 <pipe>:
SYSCALL(pipe)
 2a8:	b8 04 00 00 00       	mov    $0x4,%eax
 2ad:	cd 40                	int    $0x40
 2af:	c3                   	ret    

000002b0 <read>:
SYSCALL(read)
 2b0:	b8 05 00 00 00       	mov    $0x5,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <write>:
SYSCALL(write)
 2b8:	b8 10 00 00 00       	mov    $0x10,%eax
 2bd:	cd 40                	int    $0x40
 2bf:	c3                   	ret    

000002c0 <close>:
SYSCALL(close)
 2c0:	b8 15 00 00 00       	mov    $0x15,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <kill>:
SYSCALL(kill)
 2c8:	b8 06 00 00 00       	mov    $0x6,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <exec>:
SYSCALL(exec)
 2d0:	b8 07 00 00 00       	mov    $0x7,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <open>:
SYSCALL(open)
 2d8:	b8 0f 00 00 00       	mov    $0xf,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <mknod>:
SYSCALL(mknod)
 2e0:	b8 11 00 00 00       	mov    $0x11,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <unlink>:
SYSCALL(unlink)
 2e8:	b8 12 00 00 00       	mov    $0x12,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <fstat>:
SYSCALL(fstat)
 2f0:	b8 08 00 00 00       	mov    $0x8,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <link>:
SYSCALL(link)
 2f8:	b8 13 00 00 00       	mov    $0x13,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <mkdir>:
SYSCALL(mkdir)
 300:	b8 14 00 00 00       	mov    $0x14,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <chdir>:
SYSCALL(chdir)
 308:	b8 09 00 00 00       	mov    $0x9,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <dup>:
SYSCALL(dup)
 310:	b8 0a 00 00 00       	mov    $0xa,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <getpid>:
SYSCALL(getpid)
 318:	b8 0b 00 00 00       	mov    $0xb,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <sbrk>:
SYSCALL(sbrk)
 320:	b8 0c 00 00 00       	mov    $0xc,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <sleep>:
SYSCALL(sleep)
 328:	b8 0d 00 00 00       	mov    $0xd,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <uptime>:
SYSCALL(uptime)
 330:	b8 0e 00 00 00       	mov    $0xe,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <detach>:
SYSCALL(detach)
 338:	b8 16 00 00 00       	mov    $0x16,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <priority>:
SYSCALL(priority)
 340:	b8 17 00 00 00       	mov    $0x17,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <policy>:
SYSCALL(policy)
 348:	b8 18 00 00 00       	mov    $0x18,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <wait_stat>:
SYSCALL(wait_stat)
 350:	b8 19 00 00 00       	mov    $0x19,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    
 358:	66 90                	xchg   %ax,%ax
 35a:	66 90                	xchg   %ax,%ax
 35c:	66 90                	xchg   %ax,%ax
 35e:	66 90                	xchg   %ax,%ax

00000360 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	56                   	push   %esi
 365:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 366:	89 d3                	mov    %edx,%ebx
 368:	c1 eb 1f             	shr    $0x1f,%ebx
{
 36b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 36e:	84 db                	test   %bl,%bl
{
 370:	89 45 c0             	mov    %eax,-0x40(%ebp)
 373:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 375:	74 79                	je     3f0 <printint+0x90>
 377:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 37b:	74 73                	je     3f0 <printint+0x90>
    neg = 1;
    x = -xx;
 37d:	f7 d8                	neg    %eax
    neg = 1;
 37f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 386:	31 f6                	xor    %esi,%esi
 388:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 38b:	eb 05                	jmp    392 <printint+0x32>
 38d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 390:	89 fe                	mov    %edi,%esi
 392:	31 d2                	xor    %edx,%edx
 394:	f7 f1                	div    %ecx
 396:	8d 7e 01             	lea    0x1(%esi),%edi
 399:	0f b6 92 94 07 00 00 	movzbl 0x794(%edx),%edx
  }while((x /= base) != 0);
 3a0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 3a2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 3a5:	75 e9                	jne    390 <printint+0x30>
  if(neg)
 3a7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 3aa:	85 d2                	test   %edx,%edx
 3ac:	74 08                	je     3b6 <printint+0x56>
    buf[i++] = '-';
 3ae:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 3b3:	8d 7e 02             	lea    0x2(%esi),%edi
 3b6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 3ba:	8b 7d c0             	mov    -0x40(%ebp),%edi
 3bd:	8d 76 00             	lea    0x0(%esi),%esi
 3c0:	0f b6 06             	movzbl (%esi),%eax
 3c3:	4e                   	dec    %esi
  write(fd, &c, 1);
 3c4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 3c8:	89 3c 24             	mov    %edi,(%esp)
 3cb:	88 45 d7             	mov    %al,-0x29(%ebp)
 3ce:	b8 01 00 00 00       	mov    $0x1,%eax
 3d3:	89 44 24 08          	mov    %eax,0x8(%esp)
 3d7:	e8 dc fe ff ff       	call   2b8 <write>

  while(--i >= 0)
 3dc:	39 de                	cmp    %ebx,%esi
 3de:	75 e0                	jne    3c0 <printint+0x60>
    putc(fd, buf[i]);
}
 3e0:	83 c4 4c             	add    $0x4c,%esp
 3e3:	5b                   	pop    %ebx
 3e4:	5e                   	pop    %esi
 3e5:	5f                   	pop    %edi
 3e6:	5d                   	pop    %ebp
 3e7:	c3                   	ret    
 3e8:	90                   	nop
 3e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 3f0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3f7:	eb 8d                	jmp    386 <printint+0x26>
 3f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000400 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	56                   	push   %esi
 405:	53                   	push   %ebx
 406:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 409:	8b 75 0c             	mov    0xc(%ebp),%esi
 40c:	0f b6 1e             	movzbl (%esi),%ebx
 40f:	84 db                	test   %bl,%bl
 411:	0f 84 d1 00 00 00    	je     4e8 <printf+0xe8>
  state = 0;
 417:	31 ff                	xor    %edi,%edi
 419:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 41a:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 41d:	89 fa                	mov    %edi,%edx
 41f:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 422:	89 45 d0             	mov    %eax,-0x30(%ebp)
 425:	eb 41                	jmp    468 <printf+0x68>
 427:	89 f6                	mov    %esi,%esi
 429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 430:	83 f8 25             	cmp    $0x25,%eax
 433:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 436:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 43b:	74 1e                	je     45b <printf+0x5b>
  write(fd, &c, 1);
 43d:	b8 01 00 00 00       	mov    $0x1,%eax
 442:	89 44 24 08          	mov    %eax,0x8(%esp)
 446:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 449:	89 44 24 04          	mov    %eax,0x4(%esp)
 44d:	89 3c 24             	mov    %edi,(%esp)
 450:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 453:	e8 60 fe ff ff       	call   2b8 <write>
 458:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 45b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 45c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 460:	84 db                	test   %bl,%bl
 462:	0f 84 80 00 00 00    	je     4e8 <printf+0xe8>
    if(state == 0){
 468:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 46a:	0f be cb             	movsbl %bl,%ecx
 46d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 470:	74 be                	je     430 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 472:	83 fa 25             	cmp    $0x25,%edx
 475:	75 e4                	jne    45b <printf+0x5b>
      if(c == 'd'){
 477:	83 f8 64             	cmp    $0x64,%eax
 47a:	0f 84 f0 00 00 00    	je     570 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 480:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 486:	83 f9 70             	cmp    $0x70,%ecx
 489:	74 65                	je     4f0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 48b:	83 f8 73             	cmp    $0x73,%eax
 48e:	0f 84 8c 00 00 00    	je     520 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 494:	83 f8 63             	cmp    $0x63,%eax
 497:	0f 84 13 01 00 00    	je     5b0 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 49d:	83 f8 25             	cmp    $0x25,%eax
 4a0:	0f 84 e2 00 00 00    	je     588 <printf+0x188>
  write(fd, &c, 1);
 4a6:	b8 01 00 00 00       	mov    $0x1,%eax
 4ab:	46                   	inc    %esi
 4ac:	89 44 24 08          	mov    %eax,0x8(%esp)
 4b0:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4b3:	89 44 24 04          	mov    %eax,0x4(%esp)
 4b7:	89 3c 24             	mov    %edi,(%esp)
 4ba:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4be:	e8 f5 fd ff ff       	call   2b8 <write>
 4c3:	ba 01 00 00 00       	mov    $0x1,%edx
 4c8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4cb:	89 54 24 08          	mov    %edx,0x8(%esp)
 4cf:	89 44 24 04          	mov    %eax,0x4(%esp)
 4d3:	89 3c 24             	mov    %edi,(%esp)
 4d6:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 4d9:	e8 da fd ff ff       	call   2b8 <write>
  for(i = 0; fmt[i]; i++){
 4de:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4e2:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 4e4:	84 db                	test   %bl,%bl
 4e6:	75 80                	jne    468 <printf+0x68>
    }
  }
}
 4e8:	83 c4 3c             	add    $0x3c,%esp
 4eb:	5b                   	pop    %ebx
 4ec:	5e                   	pop    %esi
 4ed:	5f                   	pop    %edi
 4ee:	5d                   	pop    %ebp
 4ef:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 4f0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4f7:	b9 10 00 00 00       	mov    $0x10,%ecx
 4fc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 4ff:	89 f8                	mov    %edi,%eax
 501:	8b 13                	mov    (%ebx),%edx
 503:	e8 58 fe ff ff       	call   360 <printint>
        ap++;
 508:	89 d8                	mov    %ebx,%eax
      state = 0;
 50a:	31 d2                	xor    %edx,%edx
        ap++;
 50c:	83 c0 04             	add    $0x4,%eax
 50f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 512:	e9 44 ff ff ff       	jmp    45b <printf+0x5b>
 517:	89 f6                	mov    %esi,%esi
 519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 520:	8b 45 d0             	mov    -0x30(%ebp),%eax
 523:	8b 10                	mov    (%eax),%edx
        ap++;
 525:	83 c0 04             	add    $0x4,%eax
 528:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 52b:	85 d2                	test   %edx,%edx
 52d:	0f 84 aa 00 00 00    	je     5dd <printf+0x1dd>
        while(*s != 0){
 533:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 536:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 538:	84 c0                	test   %al,%al
 53a:	74 27                	je     563 <printf+0x163>
 53c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 540:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 543:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 548:	43                   	inc    %ebx
  write(fd, &c, 1);
 549:	89 44 24 08          	mov    %eax,0x8(%esp)
 54d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 550:	89 44 24 04          	mov    %eax,0x4(%esp)
 554:	89 3c 24             	mov    %edi,(%esp)
 557:	e8 5c fd ff ff       	call   2b8 <write>
        while(*s != 0){
 55c:	0f b6 03             	movzbl (%ebx),%eax
 55f:	84 c0                	test   %al,%al
 561:	75 dd                	jne    540 <printf+0x140>
      state = 0;
 563:	31 d2                	xor    %edx,%edx
 565:	e9 f1 fe ff ff       	jmp    45b <printf+0x5b>
 56a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 570:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 577:	b9 0a 00 00 00       	mov    $0xa,%ecx
 57c:	e9 7b ff ff ff       	jmp    4fc <printf+0xfc>
 581:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 588:	b9 01 00 00 00       	mov    $0x1,%ecx
 58d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 590:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 594:	89 44 24 04          	mov    %eax,0x4(%esp)
 598:	89 3c 24             	mov    %edi,(%esp)
 59b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 59e:	e8 15 fd ff ff       	call   2b8 <write>
      state = 0;
 5a3:	31 d2                	xor    %edx,%edx
 5a5:	e9 b1 fe ff ff       	jmp    45b <printf+0x5b>
 5aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 5b0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5b3:	8b 03                	mov    (%ebx),%eax
        ap++;
 5b5:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 5b8:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 5bb:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 5be:	b8 01 00 00 00       	mov    $0x1,%eax
 5c3:	89 44 24 08          	mov    %eax,0x8(%esp)
 5c7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5ca:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ce:	e8 e5 fc ff ff       	call   2b8 <write>
      state = 0;
 5d3:	31 d2                	xor    %edx,%edx
        ap++;
 5d5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5d8:	e9 7e fe ff ff       	jmp    45b <printf+0x5b>
          s = "(null)";
 5dd:	bb 8c 07 00 00       	mov    $0x78c,%ebx
        while(*s != 0){
 5e2:	b0 28                	mov    $0x28,%al
 5e4:	e9 57 ff ff ff       	jmp    540 <printf+0x140>
 5e9:	66 90                	xchg   %ax,%ax
 5eb:	66 90                	xchg   %ax,%ax
 5ed:	66 90                	xchg   %ax,%ax
 5ef:	90                   	nop

000005f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f1:	a1 24 0a 00 00       	mov    0xa24,%eax
{
 5f6:	89 e5                	mov    %esp,%ebp
 5f8:	57                   	push   %edi
 5f9:	56                   	push   %esi
 5fa:	53                   	push   %ebx
 5fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 5fe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 601:	eb 0d                	jmp    610 <free+0x20>
 603:	90                   	nop
 604:	90                   	nop
 605:	90                   	nop
 606:	90                   	nop
 607:	90                   	nop
 608:	90                   	nop
 609:	90                   	nop
 60a:	90                   	nop
 60b:	90                   	nop
 60c:	90                   	nop
 60d:	90                   	nop
 60e:	90                   	nop
 60f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 610:	39 c8                	cmp    %ecx,%eax
 612:	8b 10                	mov    (%eax),%edx
 614:	73 32                	jae    648 <free+0x58>
 616:	39 d1                	cmp    %edx,%ecx
 618:	72 04                	jb     61e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 61a:	39 d0                	cmp    %edx,%eax
 61c:	72 32                	jb     650 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 61e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 621:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 624:	39 fa                	cmp    %edi,%edx
 626:	74 30                	je     658 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 628:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 62b:	8b 50 04             	mov    0x4(%eax),%edx
 62e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 631:	39 f1                	cmp    %esi,%ecx
 633:	74 3c                	je     671 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 635:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 637:	5b                   	pop    %ebx
  freep = p;
 638:	a3 24 0a 00 00       	mov    %eax,0xa24
}
 63d:	5e                   	pop    %esi
 63e:	5f                   	pop    %edi
 63f:	5d                   	pop    %ebp
 640:	c3                   	ret    
 641:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 648:	39 d0                	cmp    %edx,%eax
 64a:	72 04                	jb     650 <free+0x60>
 64c:	39 d1                	cmp    %edx,%ecx
 64e:	72 ce                	jb     61e <free+0x2e>
{
 650:	89 d0                	mov    %edx,%eax
 652:	eb bc                	jmp    610 <free+0x20>
 654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 658:	8b 7a 04             	mov    0x4(%edx),%edi
 65b:	01 fe                	add    %edi,%esi
 65d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 660:	8b 10                	mov    (%eax),%edx
 662:	8b 12                	mov    (%edx),%edx
 664:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 667:	8b 50 04             	mov    0x4(%eax),%edx
 66a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 66d:	39 f1                	cmp    %esi,%ecx
 66f:	75 c4                	jne    635 <free+0x45>
    p->s.size += bp->s.size;
 671:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 674:	a3 24 0a 00 00       	mov    %eax,0xa24
    p->s.size += bp->s.size;
 679:	01 ca                	add    %ecx,%edx
 67b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 67e:	8b 53 f8             	mov    -0x8(%ebx),%edx
 681:	89 10                	mov    %edx,(%eax)
}
 683:	5b                   	pop    %ebx
 684:	5e                   	pop    %esi
 685:	5f                   	pop    %edi
 686:	5d                   	pop    %ebp
 687:	c3                   	ret    
 688:	90                   	nop
 689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000690 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	57                   	push   %edi
 694:	56                   	push   %esi
 695:	53                   	push   %ebx
 696:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 699:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 69c:	8b 15 24 0a 00 00    	mov    0xa24,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6a2:	8d 78 07             	lea    0x7(%eax),%edi
 6a5:	c1 ef 03             	shr    $0x3,%edi
 6a8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 6a9:	85 d2                	test   %edx,%edx
 6ab:	0f 84 8f 00 00 00    	je     740 <malloc+0xb0>
 6b1:	8b 02                	mov    (%edx),%eax
 6b3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6b6:	39 cf                	cmp    %ecx,%edi
 6b8:	76 66                	jbe    720 <malloc+0x90>
 6ba:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 6c0:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6c5:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 6c8:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6cf:	eb 10                	jmp    6e1 <malloc+0x51>
 6d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6d8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6da:	8b 48 04             	mov    0x4(%eax),%ecx
 6dd:	39 f9                	cmp    %edi,%ecx
 6df:	73 3f                	jae    720 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6e1:	39 05 24 0a 00 00    	cmp    %eax,0xa24
 6e7:	89 c2                	mov    %eax,%edx
 6e9:	75 ed                	jne    6d8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 6eb:	89 34 24             	mov    %esi,(%esp)
 6ee:	e8 2d fc ff ff       	call   320 <sbrk>
  if(p == (char*)-1)
 6f3:	83 f8 ff             	cmp    $0xffffffff,%eax
 6f6:	74 18                	je     710 <malloc+0x80>
  hp->s.size = nu;
 6f8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 6fb:	83 c0 08             	add    $0x8,%eax
 6fe:	89 04 24             	mov    %eax,(%esp)
 701:	e8 ea fe ff ff       	call   5f0 <free>
  return freep;
 706:	8b 15 24 0a 00 00    	mov    0xa24,%edx
      if((p = morecore(nunits)) == 0)
 70c:	85 d2                	test   %edx,%edx
 70e:	75 c8                	jne    6d8 <malloc+0x48>
        return 0;
  }
}
 710:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 713:	31 c0                	xor    %eax,%eax
}
 715:	5b                   	pop    %ebx
 716:	5e                   	pop    %esi
 717:	5f                   	pop    %edi
 718:	5d                   	pop    %ebp
 719:	c3                   	ret    
 71a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 720:	39 cf                	cmp    %ecx,%edi
 722:	74 4c                	je     770 <malloc+0xe0>
        p->s.size -= nunits;
 724:	29 f9                	sub    %edi,%ecx
 726:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 729:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 72c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 72f:	89 15 24 0a 00 00    	mov    %edx,0xa24
}
 735:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 738:	83 c0 08             	add    $0x8,%eax
}
 73b:	5b                   	pop    %ebx
 73c:	5e                   	pop    %esi
 73d:	5f                   	pop    %edi
 73e:	5d                   	pop    %ebp
 73f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 740:	b8 28 0a 00 00       	mov    $0xa28,%eax
 745:	ba 28 0a 00 00       	mov    $0xa28,%edx
    base.s.size = 0;
 74a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 74c:	a3 24 0a 00 00       	mov    %eax,0xa24
    base.s.size = 0;
 751:	b8 28 0a 00 00       	mov    $0xa28,%eax
    base.s.ptr = freep = prevp = &base;
 756:	89 15 28 0a 00 00    	mov    %edx,0xa28
    base.s.size = 0;
 75c:	89 0d 2c 0a 00 00    	mov    %ecx,0xa2c
 762:	e9 53 ff ff ff       	jmp    6ba <malloc+0x2a>
 767:	89 f6                	mov    %esi,%esi
 769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 770:	8b 08                	mov    (%eax),%ecx
 772:	89 0a                	mov    %ecx,(%edx)
 774:	eb b9                	jmp    72f <malloc+0x9f>
