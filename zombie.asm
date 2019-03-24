
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  if(fork() > 0)
   9:	e8 42 02 00 00       	call   250 <fork>
   e:	85 c0                	test   %eax,%eax
  10:	7e 0c                	jle    1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  12:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  19:	e8 ca 02 00 00       	call   2e8 <sleep>
  exit(0);
  1e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  25:	e8 2e 02 00 00       	call   258 <exit>
  2a:	66 90                	xchg   %ax,%ax
  2c:	66 90                	xchg   %ax,%ax
  2e:	66 90                	xchg   %ax,%ax

00000030 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	8b 45 08             	mov    0x8(%ebp),%eax
  36:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  39:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  3a:	89 c2                	mov    %eax,%edx
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  40:	41                   	inc    %ecx
  41:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  45:	42                   	inc    %edx
  46:	84 db                	test   %bl,%bl
  48:	88 5a ff             	mov    %bl,-0x1(%edx)
  4b:	75 f3                	jne    40 <strcpy+0x10>
    ;
  return os;
}
  4d:	5b                   	pop    %ebx
  4e:	5d                   	pop    %ebp
  4f:	c3                   	ret    

00000050 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	8b 4d 08             	mov    0x8(%ebp),%ecx
  56:	53                   	push   %ebx
  57:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  5a:	0f b6 01             	movzbl (%ecx),%eax
  5d:	0f b6 13             	movzbl (%ebx),%edx
  60:	84 c0                	test   %al,%al
  62:	75 18                	jne    7c <strcmp+0x2c>
  64:	eb 22                	jmp    88 <strcmp+0x38>
  66:	8d 76 00             	lea    0x0(%esi),%esi
  69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  70:	41                   	inc    %ecx
  while(*p && *p == *q)
  71:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
  74:	43                   	inc    %ebx
  75:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
  78:	84 c0                	test   %al,%al
  7a:	74 0c                	je     88 <strcmp+0x38>
  7c:	38 d0                	cmp    %dl,%al
  7e:	74 f0                	je     70 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
  80:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
  81:	29 d0                	sub    %edx,%eax
}
  83:	5d                   	pop    %ebp
  84:	c3                   	ret    
  85:	8d 76 00             	lea    0x0(%esi),%esi
  88:	5b                   	pop    %ebx
  89:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  8b:	29 d0                	sub    %edx,%eax
}
  8d:	5d                   	pop    %ebp
  8e:	c3                   	ret    
  8f:	90                   	nop

00000090 <strlen>:

uint
strlen(const char *s)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  96:	80 39 00             	cmpb   $0x0,(%ecx)
  99:	74 15                	je     b0 <strlen+0x20>
  9b:	31 d2                	xor    %edx,%edx
  9d:	8d 76 00             	lea    0x0(%esi),%esi
  a0:	42                   	inc    %edx
  a1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  a5:	89 d0                	mov    %edx,%eax
  a7:	75 f7                	jne    a0 <strlen+0x10>
    ;
  return n;
}
  a9:	5d                   	pop    %ebp
  aa:	c3                   	ret    
  ab:	90                   	nop
  ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
  b0:	31 c0                	xor    %eax,%eax
}
  b2:	5d                   	pop    %ebp
  b3:	c3                   	ret    
  b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	8b 55 08             	mov    0x8(%ebp),%edx
  c6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  cd:	89 d7                	mov    %edx,%edi
  cf:	fc                   	cld    
  d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  d2:	5f                   	pop    %edi
  d3:	89 d0                	mov    %edx,%eax
  d5:	5d                   	pop    %ebp
  d6:	c3                   	ret    
  d7:	89 f6                	mov    %esi,%esi
  d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000e0 <strchr>:

char*
strchr(const char *s, char c)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 45 08             	mov    0x8(%ebp),%eax
  e6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
  ea:	0f b6 10             	movzbl (%eax),%edx
  ed:	84 d2                	test   %dl,%dl
  ef:	74 1b                	je     10c <strchr+0x2c>
    if(*s == c)
  f1:	38 d1                	cmp    %dl,%cl
  f3:	75 0f                	jne    104 <strchr+0x24>
  f5:	eb 17                	jmp    10e <strchr+0x2e>
  f7:	89 f6                	mov    %esi,%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 100:	38 ca                	cmp    %cl,%dl
 102:	74 0a                	je     10e <strchr+0x2e>
  for(; *s; s++)
 104:	40                   	inc    %eax
 105:	0f b6 10             	movzbl (%eax),%edx
 108:	84 d2                	test   %dl,%dl
 10a:	75 f4                	jne    100 <strchr+0x20>
      return (char*)s;
  return 0;
 10c:	31 c0                	xor    %eax,%eax
}
 10e:	5d                   	pop    %ebp
 10f:	c3                   	ret    

00000110 <gets>:

char*
gets(char *buf, int max)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 115:	31 f6                	xor    %esi,%esi
{
 117:	53                   	push   %ebx
 118:	83 ec 3c             	sub    $0x3c,%esp
 11b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
 11e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 121:	eb 32                	jmp    155 <gets+0x45>
 123:	90                   	nop
 124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 128:	ba 01 00 00 00       	mov    $0x1,%edx
 12d:	89 54 24 08          	mov    %edx,0x8(%esp)
 131:	89 7c 24 04          	mov    %edi,0x4(%esp)
 135:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 13c:	e8 2f 01 00 00       	call   270 <read>
    if(cc < 1)
 141:	85 c0                	test   %eax,%eax
 143:	7e 19                	jle    15e <gets+0x4e>
      break;
    buf[i++] = c;
 145:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 149:	43                   	inc    %ebx
 14a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
 14d:	3c 0a                	cmp    $0xa,%al
 14f:	74 1f                	je     170 <gets+0x60>
 151:	3c 0d                	cmp    $0xd,%al
 153:	74 1b                	je     170 <gets+0x60>
  for(i=0; i+1 < max; ){
 155:	46                   	inc    %esi
 156:	3b 75 0c             	cmp    0xc(%ebp),%esi
 159:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 15c:	7c ca                	jl     128 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 15e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 161:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 164:	8b 45 08             	mov    0x8(%ebp),%eax
 167:	83 c4 3c             	add    $0x3c,%esp
 16a:	5b                   	pop    %ebx
 16b:	5e                   	pop    %esi
 16c:	5f                   	pop    %edi
 16d:	5d                   	pop    %ebp
 16e:	c3                   	ret    
 16f:	90                   	nop
 170:	8b 45 08             	mov    0x8(%ebp),%eax
 173:	01 c6                	add    %eax,%esi
 175:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 178:	eb e4                	jmp    15e <gets+0x4e>
 17a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000180 <stat>:

int
stat(const char *n, struct stat *st)
{
 180:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 181:	31 c0                	xor    %eax,%eax
{
 183:	89 e5                	mov    %esp,%ebp
 185:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 188:	89 44 24 04          	mov    %eax,0x4(%esp)
 18c:	8b 45 08             	mov    0x8(%ebp),%eax
{
 18f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 192:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 195:	89 04 24             	mov    %eax,(%esp)
 198:	e8 fb 00 00 00       	call   298 <open>
  if(fd < 0)
 19d:	85 c0                	test   %eax,%eax
 19f:	78 2f                	js     1d0 <stat+0x50>
 1a1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1a3:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a6:	89 1c 24             	mov    %ebx,(%esp)
 1a9:	89 44 24 04          	mov    %eax,0x4(%esp)
 1ad:	e8 fe 00 00 00       	call   2b0 <fstat>
  close(fd);
 1b2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1b5:	89 c6                	mov    %eax,%esi
  close(fd);
 1b7:	e8 c4 00 00 00       	call   280 <close>
  return r;
}
 1bc:	89 f0                	mov    %esi,%eax
 1be:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 1c1:	8b 75 fc             	mov    -0x4(%ebp),%esi
 1c4:	89 ec                	mov    %ebp,%esp
 1c6:	5d                   	pop    %ebp
 1c7:	c3                   	ret    
 1c8:	90                   	nop
 1c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 1d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1d5:	eb e5                	jmp    1bc <stat+0x3c>
 1d7:	89 f6                	mov    %esi,%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001e0 <atoi>:

int
atoi(const char *s)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1e6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1e7:	0f be 11             	movsbl (%ecx),%edx
 1ea:	88 d0                	mov    %dl,%al
 1ec:	2c 30                	sub    $0x30,%al
 1ee:	3c 09                	cmp    $0x9,%al
  n = 0;
 1f0:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 1f5:	77 1e                	ja     215 <atoi+0x35>
 1f7:	89 f6                	mov    %esi,%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 200:	41                   	inc    %ecx
 201:	8d 04 80             	lea    (%eax,%eax,4),%eax
 204:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 208:	0f be 11             	movsbl (%ecx),%edx
 20b:	88 d3                	mov    %dl,%bl
 20d:	80 eb 30             	sub    $0x30,%bl
 210:	80 fb 09             	cmp    $0x9,%bl
 213:	76 eb                	jbe    200 <atoi+0x20>
  return n;
}
 215:	5b                   	pop    %ebx
 216:	5d                   	pop    %ebp
 217:	c3                   	ret    
 218:	90                   	nop
 219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000220 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	56                   	push   %esi
 224:	8b 45 08             	mov    0x8(%ebp),%eax
 227:	53                   	push   %ebx
 228:	8b 5d 10             	mov    0x10(%ebp),%ebx
 22b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 22e:	85 db                	test   %ebx,%ebx
 230:	7e 1a                	jle    24c <memmove+0x2c>
 232:	31 d2                	xor    %edx,%edx
 234:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 23a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 240:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 244:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 247:	42                   	inc    %edx
  while(n-- > 0)
 248:	39 d3                	cmp    %edx,%ebx
 24a:	75 f4                	jne    240 <memmove+0x20>
  return vdst;
}
 24c:	5b                   	pop    %ebx
 24d:	5e                   	pop    %esi
 24e:	5d                   	pop    %ebp
 24f:	c3                   	ret    

00000250 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 250:	b8 01 00 00 00       	mov    $0x1,%eax
 255:	cd 40                	int    $0x40
 257:	c3                   	ret    

00000258 <exit>:
SYSCALL(exit)
 258:	b8 02 00 00 00       	mov    $0x2,%eax
 25d:	cd 40                	int    $0x40
 25f:	c3                   	ret    

00000260 <wait>:
SYSCALL(wait)
 260:	b8 03 00 00 00       	mov    $0x3,%eax
 265:	cd 40                	int    $0x40
 267:	c3                   	ret    

00000268 <pipe>:
SYSCALL(pipe)
 268:	b8 04 00 00 00       	mov    $0x4,%eax
 26d:	cd 40                	int    $0x40
 26f:	c3                   	ret    

00000270 <read>:
SYSCALL(read)
 270:	b8 05 00 00 00       	mov    $0x5,%eax
 275:	cd 40                	int    $0x40
 277:	c3                   	ret    

00000278 <write>:
SYSCALL(write)
 278:	b8 10 00 00 00       	mov    $0x10,%eax
 27d:	cd 40                	int    $0x40
 27f:	c3                   	ret    

00000280 <close>:
SYSCALL(close)
 280:	b8 15 00 00 00       	mov    $0x15,%eax
 285:	cd 40                	int    $0x40
 287:	c3                   	ret    

00000288 <kill>:
SYSCALL(kill)
 288:	b8 06 00 00 00       	mov    $0x6,%eax
 28d:	cd 40                	int    $0x40
 28f:	c3                   	ret    

00000290 <exec>:
SYSCALL(exec)
 290:	b8 07 00 00 00       	mov    $0x7,%eax
 295:	cd 40                	int    $0x40
 297:	c3                   	ret    

00000298 <open>:
SYSCALL(open)
 298:	b8 0f 00 00 00       	mov    $0xf,%eax
 29d:	cd 40                	int    $0x40
 29f:	c3                   	ret    

000002a0 <mknod>:
SYSCALL(mknod)
 2a0:	b8 11 00 00 00       	mov    $0x11,%eax
 2a5:	cd 40                	int    $0x40
 2a7:	c3                   	ret    

000002a8 <unlink>:
SYSCALL(unlink)
 2a8:	b8 12 00 00 00       	mov    $0x12,%eax
 2ad:	cd 40                	int    $0x40
 2af:	c3                   	ret    

000002b0 <fstat>:
SYSCALL(fstat)
 2b0:	b8 08 00 00 00       	mov    $0x8,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <link>:
SYSCALL(link)
 2b8:	b8 13 00 00 00       	mov    $0x13,%eax
 2bd:	cd 40                	int    $0x40
 2bf:	c3                   	ret    

000002c0 <mkdir>:
SYSCALL(mkdir)
 2c0:	b8 14 00 00 00       	mov    $0x14,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <chdir>:
SYSCALL(chdir)
 2c8:	b8 09 00 00 00       	mov    $0x9,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <dup>:
SYSCALL(dup)
 2d0:	b8 0a 00 00 00       	mov    $0xa,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <getpid>:
SYSCALL(getpid)
 2d8:	b8 0b 00 00 00       	mov    $0xb,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <sbrk>:
SYSCALL(sbrk)
 2e0:	b8 0c 00 00 00       	mov    $0xc,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <sleep>:
SYSCALL(sleep)
 2e8:	b8 0d 00 00 00       	mov    $0xd,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <uptime>:
SYSCALL(uptime)
 2f0:	b8 0e 00 00 00       	mov    $0xe,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <detach>:
SYSCALL(detach)
 2f8:	b8 16 00 00 00       	mov    $0x16,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <priority>:
SYSCALL(priority)
 300:	b8 17 00 00 00       	mov    $0x17,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <policy>:
SYSCALL(policy)
 308:	b8 18 00 00 00       	mov    $0x18,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <wait_stat>:
SYSCALL(wait_stat)
 310:	b8 19 00 00 00       	mov    $0x19,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    
 318:	66 90                	xchg   %ax,%ax
 31a:	66 90                	xchg   %ax,%ax
 31c:	66 90                	xchg   %ax,%ax
 31e:	66 90                	xchg   %ax,%ax

00000320 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	57                   	push   %edi
 324:	56                   	push   %esi
 325:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 326:	89 d3                	mov    %edx,%ebx
 328:	c1 eb 1f             	shr    $0x1f,%ebx
{
 32b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 32e:	84 db                	test   %bl,%bl
{
 330:	89 45 c0             	mov    %eax,-0x40(%ebp)
 333:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 335:	74 79                	je     3b0 <printint+0x90>
 337:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 33b:	74 73                	je     3b0 <printint+0x90>
    neg = 1;
    x = -xx;
 33d:	f7 d8                	neg    %eax
    neg = 1;
 33f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 346:	31 f6                	xor    %esi,%esi
 348:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 34b:	eb 05                	jmp    352 <printint+0x32>
 34d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 350:	89 fe                	mov    %edi,%esi
 352:	31 d2                	xor    %edx,%edx
 354:	f7 f1                	div    %ecx
 356:	8d 7e 01             	lea    0x1(%esi),%edi
 359:	0f b6 92 40 07 00 00 	movzbl 0x740(%edx),%edx
  }while((x /= base) != 0);
 360:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 362:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 365:	75 e9                	jne    350 <printint+0x30>
  if(neg)
 367:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 36a:	85 d2                	test   %edx,%edx
 36c:	74 08                	je     376 <printint+0x56>
    buf[i++] = '-';
 36e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 373:	8d 7e 02             	lea    0x2(%esi),%edi
 376:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 37a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 37d:	8d 76 00             	lea    0x0(%esi),%esi
 380:	0f b6 06             	movzbl (%esi),%eax
 383:	4e                   	dec    %esi
  write(fd, &c, 1);
 384:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 388:	89 3c 24             	mov    %edi,(%esp)
 38b:	88 45 d7             	mov    %al,-0x29(%ebp)
 38e:	b8 01 00 00 00       	mov    $0x1,%eax
 393:	89 44 24 08          	mov    %eax,0x8(%esp)
 397:	e8 dc fe ff ff       	call   278 <write>

  while(--i >= 0)
 39c:	39 de                	cmp    %ebx,%esi
 39e:	75 e0                	jne    380 <printint+0x60>
    putc(fd, buf[i]);
}
 3a0:	83 c4 4c             	add    $0x4c,%esp
 3a3:	5b                   	pop    %ebx
 3a4:	5e                   	pop    %esi
 3a5:	5f                   	pop    %edi
 3a6:	5d                   	pop    %ebp
 3a7:	c3                   	ret    
 3a8:	90                   	nop
 3a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 3b0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3b7:	eb 8d                	jmp    346 <printint+0x26>
 3b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003c0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	57                   	push   %edi
 3c4:	56                   	push   %esi
 3c5:	53                   	push   %ebx
 3c6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3c9:	8b 75 0c             	mov    0xc(%ebp),%esi
 3cc:	0f b6 1e             	movzbl (%esi),%ebx
 3cf:	84 db                	test   %bl,%bl
 3d1:	0f 84 d1 00 00 00    	je     4a8 <printf+0xe8>
  state = 0;
 3d7:	31 ff                	xor    %edi,%edi
 3d9:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 3da:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 3dd:	89 fa                	mov    %edi,%edx
 3df:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 3e2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 3e5:	eb 41                	jmp    428 <printf+0x68>
 3e7:	89 f6                	mov    %esi,%esi
 3e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3f0:	83 f8 25             	cmp    $0x25,%eax
 3f3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 3f6:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 3fb:	74 1e                	je     41b <printf+0x5b>
  write(fd, &c, 1);
 3fd:	b8 01 00 00 00       	mov    $0x1,%eax
 402:	89 44 24 08          	mov    %eax,0x8(%esp)
 406:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 409:	89 44 24 04          	mov    %eax,0x4(%esp)
 40d:	89 3c 24             	mov    %edi,(%esp)
 410:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 413:	e8 60 fe ff ff       	call   278 <write>
 418:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 41b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 41c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 420:	84 db                	test   %bl,%bl
 422:	0f 84 80 00 00 00    	je     4a8 <printf+0xe8>
    if(state == 0){
 428:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 42a:	0f be cb             	movsbl %bl,%ecx
 42d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 430:	74 be                	je     3f0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 432:	83 fa 25             	cmp    $0x25,%edx
 435:	75 e4                	jne    41b <printf+0x5b>
      if(c == 'd'){
 437:	83 f8 64             	cmp    $0x64,%eax
 43a:	0f 84 f0 00 00 00    	je     530 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 440:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 446:	83 f9 70             	cmp    $0x70,%ecx
 449:	74 65                	je     4b0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 44b:	83 f8 73             	cmp    $0x73,%eax
 44e:	0f 84 8c 00 00 00    	je     4e0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 454:	83 f8 63             	cmp    $0x63,%eax
 457:	0f 84 13 01 00 00    	je     570 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 45d:	83 f8 25             	cmp    $0x25,%eax
 460:	0f 84 e2 00 00 00    	je     548 <printf+0x188>
  write(fd, &c, 1);
 466:	b8 01 00 00 00       	mov    $0x1,%eax
 46b:	46                   	inc    %esi
 46c:	89 44 24 08          	mov    %eax,0x8(%esp)
 470:	8d 45 e7             	lea    -0x19(%ebp),%eax
 473:	89 44 24 04          	mov    %eax,0x4(%esp)
 477:	89 3c 24             	mov    %edi,(%esp)
 47a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 47e:	e8 f5 fd ff ff       	call   278 <write>
 483:	ba 01 00 00 00       	mov    $0x1,%edx
 488:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 48b:	89 54 24 08          	mov    %edx,0x8(%esp)
 48f:	89 44 24 04          	mov    %eax,0x4(%esp)
 493:	89 3c 24             	mov    %edi,(%esp)
 496:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 499:	e8 da fd ff ff       	call   278 <write>
  for(i = 0; fmt[i]; i++){
 49e:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4a2:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 4a4:	84 db                	test   %bl,%bl
 4a6:	75 80                	jne    428 <printf+0x68>
    }
  }
}
 4a8:	83 c4 3c             	add    $0x3c,%esp
 4ab:	5b                   	pop    %ebx
 4ac:	5e                   	pop    %esi
 4ad:	5f                   	pop    %edi
 4ae:	5d                   	pop    %ebp
 4af:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 4b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4b7:	b9 10 00 00 00       	mov    $0x10,%ecx
 4bc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 4bf:	89 f8                	mov    %edi,%eax
 4c1:	8b 13                	mov    (%ebx),%edx
 4c3:	e8 58 fe ff ff       	call   320 <printint>
        ap++;
 4c8:	89 d8                	mov    %ebx,%eax
      state = 0;
 4ca:	31 d2                	xor    %edx,%edx
        ap++;
 4cc:	83 c0 04             	add    $0x4,%eax
 4cf:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4d2:	e9 44 ff ff ff       	jmp    41b <printf+0x5b>
 4d7:	89 f6                	mov    %esi,%esi
 4d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 4e0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 4e3:	8b 10                	mov    (%eax),%edx
        ap++;
 4e5:	83 c0 04             	add    $0x4,%eax
 4e8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 4eb:	85 d2                	test   %edx,%edx
 4ed:	0f 84 aa 00 00 00    	je     59d <printf+0x1dd>
        while(*s != 0){
 4f3:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 4f6:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 4f8:	84 c0                	test   %al,%al
 4fa:	74 27                	je     523 <printf+0x163>
 4fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 500:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 503:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 508:	43                   	inc    %ebx
  write(fd, &c, 1);
 509:	89 44 24 08          	mov    %eax,0x8(%esp)
 50d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 510:	89 44 24 04          	mov    %eax,0x4(%esp)
 514:	89 3c 24             	mov    %edi,(%esp)
 517:	e8 5c fd ff ff       	call   278 <write>
        while(*s != 0){
 51c:	0f b6 03             	movzbl (%ebx),%eax
 51f:	84 c0                	test   %al,%al
 521:	75 dd                	jne    500 <printf+0x140>
      state = 0;
 523:	31 d2                	xor    %edx,%edx
 525:	e9 f1 fe ff ff       	jmp    41b <printf+0x5b>
 52a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 530:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 537:	b9 0a 00 00 00       	mov    $0xa,%ecx
 53c:	e9 7b ff ff ff       	jmp    4bc <printf+0xfc>
 541:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 548:	b9 01 00 00 00       	mov    $0x1,%ecx
 54d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 550:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 554:	89 44 24 04          	mov    %eax,0x4(%esp)
 558:	89 3c 24             	mov    %edi,(%esp)
 55b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 55e:	e8 15 fd ff ff       	call   278 <write>
      state = 0;
 563:	31 d2                	xor    %edx,%edx
 565:	e9 b1 fe ff ff       	jmp    41b <printf+0x5b>
 56a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 570:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 573:	8b 03                	mov    (%ebx),%eax
        ap++;
 575:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 578:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 57b:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 57e:	b8 01 00 00 00       	mov    $0x1,%eax
 583:	89 44 24 08          	mov    %eax,0x8(%esp)
 587:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 58a:	89 44 24 04          	mov    %eax,0x4(%esp)
 58e:	e8 e5 fc ff ff       	call   278 <write>
      state = 0;
 593:	31 d2                	xor    %edx,%edx
        ap++;
 595:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 598:	e9 7e fe ff ff       	jmp    41b <printf+0x5b>
          s = "(null)";
 59d:	bb 38 07 00 00       	mov    $0x738,%ebx
        while(*s != 0){
 5a2:	b0 28                	mov    $0x28,%al
 5a4:	e9 57 ff ff ff       	jmp    500 <printf+0x140>
 5a9:	66 90                	xchg   %ax,%ax
 5ab:	66 90                	xchg   %ax,%ax
 5ad:	66 90                	xchg   %ax,%ax
 5af:	90                   	nop

000005b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5b1:	a1 cc 09 00 00       	mov    0x9cc,%eax
{
 5b6:	89 e5                	mov    %esp,%ebp
 5b8:	57                   	push   %edi
 5b9:	56                   	push   %esi
 5ba:	53                   	push   %ebx
 5bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 5be:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 5c1:	eb 0d                	jmp    5d0 <free+0x20>
 5c3:	90                   	nop
 5c4:	90                   	nop
 5c5:	90                   	nop
 5c6:	90                   	nop
 5c7:	90                   	nop
 5c8:	90                   	nop
 5c9:	90                   	nop
 5ca:	90                   	nop
 5cb:	90                   	nop
 5cc:	90                   	nop
 5cd:	90                   	nop
 5ce:	90                   	nop
 5cf:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d0:	39 c8                	cmp    %ecx,%eax
 5d2:	8b 10                	mov    (%eax),%edx
 5d4:	73 32                	jae    608 <free+0x58>
 5d6:	39 d1                	cmp    %edx,%ecx
 5d8:	72 04                	jb     5de <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5da:	39 d0                	cmp    %edx,%eax
 5dc:	72 32                	jb     610 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5de:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5e1:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5e4:	39 fa                	cmp    %edi,%edx
 5e6:	74 30                	je     618 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5e8:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5eb:	8b 50 04             	mov    0x4(%eax),%edx
 5ee:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5f1:	39 f1                	cmp    %esi,%ecx
 5f3:	74 3c                	je     631 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5f5:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 5f7:	5b                   	pop    %ebx
  freep = p;
 5f8:	a3 cc 09 00 00       	mov    %eax,0x9cc
}
 5fd:	5e                   	pop    %esi
 5fe:	5f                   	pop    %edi
 5ff:	5d                   	pop    %ebp
 600:	c3                   	ret    
 601:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 608:	39 d0                	cmp    %edx,%eax
 60a:	72 04                	jb     610 <free+0x60>
 60c:	39 d1                	cmp    %edx,%ecx
 60e:	72 ce                	jb     5de <free+0x2e>
{
 610:	89 d0                	mov    %edx,%eax
 612:	eb bc                	jmp    5d0 <free+0x20>
 614:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 618:	8b 7a 04             	mov    0x4(%edx),%edi
 61b:	01 fe                	add    %edi,%esi
 61d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 620:	8b 10                	mov    (%eax),%edx
 622:	8b 12                	mov    (%edx),%edx
 624:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 627:	8b 50 04             	mov    0x4(%eax),%edx
 62a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 62d:	39 f1                	cmp    %esi,%ecx
 62f:	75 c4                	jne    5f5 <free+0x45>
    p->s.size += bp->s.size;
 631:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 634:	a3 cc 09 00 00       	mov    %eax,0x9cc
    p->s.size += bp->s.size;
 639:	01 ca                	add    %ecx,%edx
 63b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 63e:	8b 53 f8             	mov    -0x8(%ebx),%edx
 641:	89 10                	mov    %edx,(%eax)
}
 643:	5b                   	pop    %ebx
 644:	5e                   	pop    %esi
 645:	5f                   	pop    %edi
 646:	5d                   	pop    %ebp
 647:	c3                   	ret    
 648:	90                   	nop
 649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000650 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 650:	55                   	push   %ebp
 651:	89 e5                	mov    %esp,%ebp
 653:	57                   	push   %edi
 654:	56                   	push   %esi
 655:	53                   	push   %ebx
 656:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 659:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 65c:	8b 15 cc 09 00 00    	mov    0x9cc,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 662:	8d 78 07             	lea    0x7(%eax),%edi
 665:	c1 ef 03             	shr    $0x3,%edi
 668:	47                   	inc    %edi
  if((prevp = freep) == 0){
 669:	85 d2                	test   %edx,%edx
 66b:	0f 84 8f 00 00 00    	je     700 <malloc+0xb0>
 671:	8b 02                	mov    (%edx),%eax
 673:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 676:	39 cf                	cmp    %ecx,%edi
 678:	76 66                	jbe    6e0 <malloc+0x90>
 67a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 680:	bb 00 10 00 00       	mov    $0x1000,%ebx
 685:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 688:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 68f:	eb 10                	jmp    6a1 <malloc+0x51>
 691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 698:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 69a:	8b 48 04             	mov    0x4(%eax),%ecx
 69d:	39 f9                	cmp    %edi,%ecx
 69f:	73 3f                	jae    6e0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6a1:	39 05 cc 09 00 00    	cmp    %eax,0x9cc
 6a7:	89 c2                	mov    %eax,%edx
 6a9:	75 ed                	jne    698 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 6ab:	89 34 24             	mov    %esi,(%esp)
 6ae:	e8 2d fc ff ff       	call   2e0 <sbrk>
  if(p == (char*)-1)
 6b3:	83 f8 ff             	cmp    $0xffffffff,%eax
 6b6:	74 18                	je     6d0 <malloc+0x80>
  hp->s.size = nu;
 6b8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 6bb:	83 c0 08             	add    $0x8,%eax
 6be:	89 04 24             	mov    %eax,(%esp)
 6c1:	e8 ea fe ff ff       	call   5b0 <free>
  return freep;
 6c6:	8b 15 cc 09 00 00    	mov    0x9cc,%edx
      if((p = morecore(nunits)) == 0)
 6cc:	85 d2                	test   %edx,%edx
 6ce:	75 c8                	jne    698 <malloc+0x48>
        return 0;
  }
}
 6d0:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 6d3:	31 c0                	xor    %eax,%eax
}
 6d5:	5b                   	pop    %ebx
 6d6:	5e                   	pop    %esi
 6d7:	5f                   	pop    %edi
 6d8:	5d                   	pop    %ebp
 6d9:	c3                   	ret    
 6da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 6e0:	39 cf                	cmp    %ecx,%edi
 6e2:	74 4c                	je     730 <malloc+0xe0>
        p->s.size -= nunits;
 6e4:	29 f9                	sub    %edi,%ecx
 6e6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 6e9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 6ec:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 6ef:	89 15 cc 09 00 00    	mov    %edx,0x9cc
}
 6f5:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 6f8:	83 c0 08             	add    $0x8,%eax
}
 6fb:	5b                   	pop    %ebx
 6fc:	5e                   	pop    %esi
 6fd:	5f                   	pop    %edi
 6fe:	5d                   	pop    %ebp
 6ff:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 700:	b8 d0 09 00 00       	mov    $0x9d0,%eax
 705:	ba d0 09 00 00       	mov    $0x9d0,%edx
    base.s.size = 0;
 70a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 70c:	a3 cc 09 00 00       	mov    %eax,0x9cc
    base.s.size = 0;
 711:	b8 d0 09 00 00       	mov    $0x9d0,%eax
    base.s.ptr = freep = prevp = &base;
 716:	89 15 d0 09 00 00    	mov    %edx,0x9d0
    base.s.size = 0;
 71c:	89 0d d4 09 00 00    	mov    %ecx,0x9d4
 722:	e9 53 ff ff ff       	jmp    67a <malloc+0x2a>
 727:	89 f6                	mov    %esi,%esi
 729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 730:	8b 08                	mov    (%eax),%ecx
 732:	89 0a                	mov    %ecx,(%edx)
 734:	eb b9                	jmp    6ef <malloc+0x9f>
