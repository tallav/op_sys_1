
_schedtest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"
#include "fcntl.h"

int
main(int argc, char **argv)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
    int pid;
    pid = fork(); 
   9:	e8 52 02 00 00       	call   260 <fork>
    if(pid == 0){ /*child code*/
   e:	85 c0                	test   %eax,%eax
  10:	75 20                	jne    32 <main+0x32>
        printf(1, "child process\n");
  12:	c7 44 24 04 48 07 00 	movl   $0x748,0x4(%esp)
  19:	00 
  1a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  21:	e8 aa 03 00 00       	call   3d0 <printf>
    }else{ /*parent code*/
        wait(0);
    }
    exit(0);
  26:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  2d:	e8 36 02 00 00       	call   268 <exit>
        wait(0);
  32:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  39:	e8 32 02 00 00       	call   270 <wait>
  3e:	eb e6                	jmp    26 <main+0x26>

00000040 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  43:	8b 45 08             	mov    0x8(%ebp),%eax
  46:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  49:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  4a:	89 c2                	mov    %eax,%edx
  4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  50:	41                   	inc    %ecx
  51:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  55:	42                   	inc    %edx
  56:	84 db                	test   %bl,%bl
  58:	88 5a ff             	mov    %bl,-0x1(%edx)
  5b:	75 f3                	jne    50 <strcpy+0x10>
    ;
  return os;
}
  5d:	5b                   	pop    %ebx
  5e:	5d                   	pop    %ebp
  5f:	c3                   	ret    

00000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	8b 4d 08             	mov    0x8(%ebp),%ecx
  66:	53                   	push   %ebx
  67:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  6a:	0f b6 01             	movzbl (%ecx),%eax
  6d:	0f b6 13             	movzbl (%ebx),%edx
  70:	84 c0                	test   %al,%al
  72:	75 18                	jne    8c <strcmp+0x2c>
  74:	eb 22                	jmp    98 <strcmp+0x38>
  76:	8d 76 00             	lea    0x0(%esi),%esi
  79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  80:	41                   	inc    %ecx
  while(*p && *p == *q)
  81:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
  84:	43                   	inc    %ebx
  85:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
  88:	84 c0                	test   %al,%al
  8a:	74 0c                	je     98 <strcmp+0x38>
  8c:	38 d0                	cmp    %dl,%al
  8e:	74 f0                	je     80 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
  90:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
  91:	29 d0                	sub    %edx,%eax
}
  93:	5d                   	pop    %ebp
  94:	c3                   	ret    
  95:	8d 76 00             	lea    0x0(%esi),%esi
  98:	5b                   	pop    %ebx
  99:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  9b:	29 d0                	sub    %edx,%eax
}
  9d:	5d                   	pop    %ebp
  9e:	c3                   	ret    
  9f:	90                   	nop

000000a0 <strlen>:

uint
strlen(const char *s)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  a6:	80 39 00             	cmpb   $0x0,(%ecx)
  a9:	74 15                	je     c0 <strlen+0x20>
  ab:	31 d2                	xor    %edx,%edx
  ad:	8d 76 00             	lea    0x0(%esi),%esi
  b0:	42                   	inc    %edx
  b1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  b5:	89 d0                	mov    %edx,%eax
  b7:	75 f7                	jne    b0 <strlen+0x10>
    ;
  return n;
}
  b9:	5d                   	pop    %ebp
  ba:	c3                   	ret    
  bb:	90                   	nop
  bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
  c0:	31 c0                	xor    %eax,%eax
}
  c2:	5d                   	pop    %ebp
  c3:	c3                   	ret    
  c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	8b 55 08             	mov    0x8(%ebp),%edx
  d6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  da:	8b 45 0c             	mov    0xc(%ebp),%eax
  dd:	89 d7                	mov    %edx,%edi
  df:	fc                   	cld    
  e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  e2:	5f                   	pop    %edi
  e3:	89 d0                	mov    %edx,%eax
  e5:	5d                   	pop    %ebp
  e6:	c3                   	ret    
  e7:	89 f6                	mov    %esi,%esi
  e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000f0 <strchr>:

char*
strchr(const char *s, char c)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	8b 45 08             	mov    0x8(%ebp),%eax
  f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
  fa:	0f b6 10             	movzbl (%eax),%edx
  fd:	84 d2                	test   %dl,%dl
  ff:	74 1b                	je     11c <strchr+0x2c>
    if(*s == c)
 101:	38 d1                	cmp    %dl,%cl
 103:	75 0f                	jne    114 <strchr+0x24>
 105:	eb 17                	jmp    11e <strchr+0x2e>
 107:	89 f6                	mov    %esi,%esi
 109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 110:	38 ca                	cmp    %cl,%dl
 112:	74 0a                	je     11e <strchr+0x2e>
  for(; *s; s++)
 114:	40                   	inc    %eax
 115:	0f b6 10             	movzbl (%eax),%edx
 118:	84 d2                	test   %dl,%dl
 11a:	75 f4                	jne    110 <strchr+0x20>
      return (char*)s;
  return 0;
 11c:	31 c0                	xor    %eax,%eax
}
 11e:	5d                   	pop    %ebp
 11f:	c3                   	ret    

00000120 <gets>:

char*
gets(char *buf, int max)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	57                   	push   %edi
 124:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 125:	31 f6                	xor    %esi,%esi
{
 127:	53                   	push   %ebx
 128:	83 ec 3c             	sub    $0x3c,%esp
 12b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
 12e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 131:	eb 32                	jmp    165 <gets+0x45>
 133:	90                   	nop
 134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 138:	ba 01 00 00 00       	mov    $0x1,%edx
 13d:	89 54 24 08          	mov    %edx,0x8(%esp)
 141:	89 7c 24 04          	mov    %edi,0x4(%esp)
 145:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 14c:	e8 2f 01 00 00       	call   280 <read>
    if(cc < 1)
 151:	85 c0                	test   %eax,%eax
 153:	7e 19                	jle    16e <gets+0x4e>
      break;
    buf[i++] = c;
 155:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 159:	43                   	inc    %ebx
 15a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
 15d:	3c 0a                	cmp    $0xa,%al
 15f:	74 1f                	je     180 <gets+0x60>
 161:	3c 0d                	cmp    $0xd,%al
 163:	74 1b                	je     180 <gets+0x60>
  for(i=0; i+1 < max; ){
 165:	46                   	inc    %esi
 166:	3b 75 0c             	cmp    0xc(%ebp),%esi
 169:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 16c:	7c ca                	jl     138 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 16e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 171:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 174:	8b 45 08             	mov    0x8(%ebp),%eax
 177:	83 c4 3c             	add    $0x3c,%esp
 17a:	5b                   	pop    %ebx
 17b:	5e                   	pop    %esi
 17c:	5f                   	pop    %edi
 17d:	5d                   	pop    %ebp
 17e:	c3                   	ret    
 17f:	90                   	nop
 180:	8b 45 08             	mov    0x8(%ebp),%eax
 183:	01 c6                	add    %eax,%esi
 185:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 188:	eb e4                	jmp    16e <gets+0x4e>
 18a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000190 <stat>:

int
stat(const char *n, struct stat *st)
{
 190:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 191:	31 c0                	xor    %eax,%eax
{
 193:	89 e5                	mov    %esp,%ebp
 195:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 198:	89 44 24 04          	mov    %eax,0x4(%esp)
 19c:	8b 45 08             	mov    0x8(%ebp),%eax
{
 19f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1a2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 1a5:	89 04 24             	mov    %eax,(%esp)
 1a8:	e8 fb 00 00 00       	call   2a8 <open>
  if(fd < 0)
 1ad:	85 c0                	test   %eax,%eax
 1af:	78 2f                	js     1e0 <stat+0x50>
 1b1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1b3:	8b 45 0c             	mov    0xc(%ebp),%eax
 1b6:	89 1c 24             	mov    %ebx,(%esp)
 1b9:	89 44 24 04          	mov    %eax,0x4(%esp)
 1bd:	e8 fe 00 00 00       	call   2c0 <fstat>
  close(fd);
 1c2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1c5:	89 c6                	mov    %eax,%esi
  close(fd);
 1c7:	e8 c4 00 00 00       	call   290 <close>
  return r;
}
 1cc:	89 f0                	mov    %esi,%eax
 1ce:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 1d1:	8b 75 fc             	mov    -0x4(%ebp),%esi
 1d4:	89 ec                	mov    %ebp,%esp
 1d6:	5d                   	pop    %ebp
 1d7:	c3                   	ret    
 1d8:	90                   	nop
 1d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 1e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1e5:	eb e5                	jmp    1cc <stat+0x3c>
 1e7:	89 f6                	mov    %esi,%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001f0 <atoi>:

int
atoi(const char *s)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1f6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1f7:	0f be 11             	movsbl (%ecx),%edx
 1fa:	88 d0                	mov    %dl,%al
 1fc:	2c 30                	sub    $0x30,%al
 1fe:	3c 09                	cmp    $0x9,%al
  n = 0;
 200:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 205:	77 1e                	ja     225 <atoi+0x35>
 207:	89 f6                	mov    %esi,%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 210:	41                   	inc    %ecx
 211:	8d 04 80             	lea    (%eax,%eax,4),%eax
 214:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 218:	0f be 11             	movsbl (%ecx),%edx
 21b:	88 d3                	mov    %dl,%bl
 21d:	80 eb 30             	sub    $0x30,%bl
 220:	80 fb 09             	cmp    $0x9,%bl
 223:	76 eb                	jbe    210 <atoi+0x20>
  return n;
}
 225:	5b                   	pop    %ebx
 226:	5d                   	pop    %ebp
 227:	c3                   	ret    
 228:	90                   	nop
 229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000230 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	56                   	push   %esi
 234:	8b 45 08             	mov    0x8(%ebp),%eax
 237:	53                   	push   %ebx
 238:	8b 5d 10             	mov    0x10(%ebp),%ebx
 23b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 23e:	85 db                	test   %ebx,%ebx
 240:	7e 1a                	jle    25c <memmove+0x2c>
 242:	31 d2                	xor    %edx,%edx
 244:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 24a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 250:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 254:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 257:	42                   	inc    %edx
  while(n-- > 0)
 258:	39 d3                	cmp    %edx,%ebx
 25a:	75 f4                	jne    250 <memmove+0x20>
  return vdst;
}
 25c:	5b                   	pop    %ebx
 25d:	5e                   	pop    %esi
 25e:	5d                   	pop    %ebp
 25f:	c3                   	ret    

00000260 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 260:	b8 01 00 00 00       	mov    $0x1,%eax
 265:	cd 40                	int    $0x40
 267:	c3                   	ret    

00000268 <exit>:
SYSCALL(exit)
 268:	b8 02 00 00 00       	mov    $0x2,%eax
 26d:	cd 40                	int    $0x40
 26f:	c3                   	ret    

00000270 <wait>:
SYSCALL(wait)
 270:	b8 03 00 00 00       	mov    $0x3,%eax
 275:	cd 40                	int    $0x40
 277:	c3                   	ret    

00000278 <pipe>:
SYSCALL(pipe)
 278:	b8 04 00 00 00       	mov    $0x4,%eax
 27d:	cd 40                	int    $0x40
 27f:	c3                   	ret    

00000280 <read>:
SYSCALL(read)
 280:	b8 05 00 00 00       	mov    $0x5,%eax
 285:	cd 40                	int    $0x40
 287:	c3                   	ret    

00000288 <write>:
SYSCALL(write)
 288:	b8 10 00 00 00       	mov    $0x10,%eax
 28d:	cd 40                	int    $0x40
 28f:	c3                   	ret    

00000290 <close>:
SYSCALL(close)
 290:	b8 15 00 00 00       	mov    $0x15,%eax
 295:	cd 40                	int    $0x40
 297:	c3                   	ret    

00000298 <kill>:
SYSCALL(kill)
 298:	b8 06 00 00 00       	mov    $0x6,%eax
 29d:	cd 40                	int    $0x40
 29f:	c3                   	ret    

000002a0 <exec>:
SYSCALL(exec)
 2a0:	b8 07 00 00 00       	mov    $0x7,%eax
 2a5:	cd 40                	int    $0x40
 2a7:	c3                   	ret    

000002a8 <open>:
SYSCALL(open)
 2a8:	b8 0f 00 00 00       	mov    $0xf,%eax
 2ad:	cd 40                	int    $0x40
 2af:	c3                   	ret    

000002b0 <mknod>:
SYSCALL(mknod)
 2b0:	b8 11 00 00 00       	mov    $0x11,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <unlink>:
SYSCALL(unlink)
 2b8:	b8 12 00 00 00       	mov    $0x12,%eax
 2bd:	cd 40                	int    $0x40
 2bf:	c3                   	ret    

000002c0 <fstat>:
SYSCALL(fstat)
 2c0:	b8 08 00 00 00       	mov    $0x8,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <link>:
SYSCALL(link)
 2c8:	b8 13 00 00 00       	mov    $0x13,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <mkdir>:
SYSCALL(mkdir)
 2d0:	b8 14 00 00 00       	mov    $0x14,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <chdir>:
SYSCALL(chdir)
 2d8:	b8 09 00 00 00       	mov    $0x9,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <dup>:
SYSCALL(dup)
 2e0:	b8 0a 00 00 00       	mov    $0xa,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <getpid>:
SYSCALL(getpid)
 2e8:	b8 0b 00 00 00       	mov    $0xb,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <sbrk>:
SYSCALL(sbrk)
 2f0:	b8 0c 00 00 00       	mov    $0xc,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <sleep>:
SYSCALL(sleep)
 2f8:	b8 0d 00 00 00       	mov    $0xd,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <uptime>:
SYSCALL(uptime)
 300:	b8 0e 00 00 00       	mov    $0xe,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <detach>:
SYSCALL(detach)
 308:	b8 16 00 00 00       	mov    $0x16,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <priority>:
SYSCALL(priority)
 310:	b8 17 00 00 00       	mov    $0x17,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <policy>:
SYSCALL(policy)
 318:	b8 18 00 00 00       	mov    $0x18,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <wait_stat>:
SYSCALL(wait_stat)
 320:	b8 19 00 00 00       	mov    $0x19,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    
 328:	66 90                	xchg   %ax,%ax
 32a:	66 90                	xchg   %ax,%ax
 32c:	66 90                	xchg   %ax,%ax
 32e:	66 90                	xchg   %ax,%ax

00000330 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	56                   	push   %esi
 335:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 336:	89 d3                	mov    %edx,%ebx
 338:	c1 eb 1f             	shr    $0x1f,%ebx
{
 33b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 33e:	84 db                	test   %bl,%bl
{
 340:	89 45 c0             	mov    %eax,-0x40(%ebp)
 343:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 345:	74 79                	je     3c0 <printint+0x90>
 347:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 34b:	74 73                	je     3c0 <printint+0x90>
    neg = 1;
    x = -xx;
 34d:	f7 d8                	neg    %eax
    neg = 1;
 34f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 356:	31 f6                	xor    %esi,%esi
 358:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 35b:	eb 05                	jmp    362 <printint+0x32>
 35d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 360:	89 fe                	mov    %edi,%esi
 362:	31 d2                	xor    %edx,%edx
 364:	f7 f1                	div    %ecx
 366:	8d 7e 01             	lea    0x1(%esi),%edi
 369:	0f b6 92 60 07 00 00 	movzbl 0x760(%edx),%edx
  }while((x /= base) != 0);
 370:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 372:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 375:	75 e9                	jne    360 <printint+0x30>
  if(neg)
 377:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 37a:	85 d2                	test   %edx,%edx
 37c:	74 08                	je     386 <printint+0x56>
    buf[i++] = '-';
 37e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 383:	8d 7e 02             	lea    0x2(%esi),%edi
 386:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 38a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 38d:	8d 76 00             	lea    0x0(%esi),%esi
 390:	0f b6 06             	movzbl (%esi),%eax
 393:	4e                   	dec    %esi
  write(fd, &c, 1);
 394:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 398:	89 3c 24             	mov    %edi,(%esp)
 39b:	88 45 d7             	mov    %al,-0x29(%ebp)
 39e:	b8 01 00 00 00       	mov    $0x1,%eax
 3a3:	89 44 24 08          	mov    %eax,0x8(%esp)
 3a7:	e8 dc fe ff ff       	call   288 <write>

  while(--i >= 0)
 3ac:	39 de                	cmp    %ebx,%esi
 3ae:	75 e0                	jne    390 <printint+0x60>
    putc(fd, buf[i]);
}
 3b0:	83 c4 4c             	add    $0x4c,%esp
 3b3:	5b                   	pop    %ebx
 3b4:	5e                   	pop    %esi
 3b5:	5f                   	pop    %edi
 3b6:	5d                   	pop    %ebp
 3b7:	c3                   	ret    
 3b8:	90                   	nop
 3b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 3c0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3c7:	eb 8d                	jmp    356 <printint+0x26>
 3c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
 3d4:	56                   	push   %esi
 3d5:	53                   	push   %ebx
 3d6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3d9:	8b 75 0c             	mov    0xc(%ebp),%esi
 3dc:	0f b6 1e             	movzbl (%esi),%ebx
 3df:	84 db                	test   %bl,%bl
 3e1:	0f 84 d1 00 00 00    	je     4b8 <printf+0xe8>
  state = 0;
 3e7:	31 ff                	xor    %edi,%edi
 3e9:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 3ea:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 3ed:	89 fa                	mov    %edi,%edx
 3ef:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 3f2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 3f5:	eb 41                	jmp    438 <printf+0x68>
 3f7:	89 f6                	mov    %esi,%esi
 3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 400:	83 f8 25             	cmp    $0x25,%eax
 403:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 406:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 40b:	74 1e                	je     42b <printf+0x5b>
  write(fd, &c, 1);
 40d:	b8 01 00 00 00       	mov    $0x1,%eax
 412:	89 44 24 08          	mov    %eax,0x8(%esp)
 416:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 419:	89 44 24 04          	mov    %eax,0x4(%esp)
 41d:	89 3c 24             	mov    %edi,(%esp)
 420:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 423:	e8 60 fe ff ff       	call   288 <write>
 428:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 42b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 42c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 430:	84 db                	test   %bl,%bl
 432:	0f 84 80 00 00 00    	je     4b8 <printf+0xe8>
    if(state == 0){
 438:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 43a:	0f be cb             	movsbl %bl,%ecx
 43d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 440:	74 be                	je     400 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 442:	83 fa 25             	cmp    $0x25,%edx
 445:	75 e4                	jne    42b <printf+0x5b>
      if(c == 'd'){
 447:	83 f8 64             	cmp    $0x64,%eax
 44a:	0f 84 f0 00 00 00    	je     540 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 450:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 456:	83 f9 70             	cmp    $0x70,%ecx
 459:	74 65                	je     4c0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 45b:	83 f8 73             	cmp    $0x73,%eax
 45e:	0f 84 8c 00 00 00    	je     4f0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 464:	83 f8 63             	cmp    $0x63,%eax
 467:	0f 84 13 01 00 00    	je     580 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 46d:	83 f8 25             	cmp    $0x25,%eax
 470:	0f 84 e2 00 00 00    	je     558 <printf+0x188>
  write(fd, &c, 1);
 476:	b8 01 00 00 00       	mov    $0x1,%eax
 47b:	46                   	inc    %esi
 47c:	89 44 24 08          	mov    %eax,0x8(%esp)
 480:	8d 45 e7             	lea    -0x19(%ebp),%eax
 483:	89 44 24 04          	mov    %eax,0x4(%esp)
 487:	89 3c 24             	mov    %edi,(%esp)
 48a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 48e:	e8 f5 fd ff ff       	call   288 <write>
 493:	ba 01 00 00 00       	mov    $0x1,%edx
 498:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 49b:	89 54 24 08          	mov    %edx,0x8(%esp)
 49f:	89 44 24 04          	mov    %eax,0x4(%esp)
 4a3:	89 3c 24             	mov    %edi,(%esp)
 4a6:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 4a9:	e8 da fd ff ff       	call   288 <write>
  for(i = 0; fmt[i]; i++){
 4ae:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4b2:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 4b4:	84 db                	test   %bl,%bl
 4b6:	75 80                	jne    438 <printf+0x68>
    }
  }
}
 4b8:	83 c4 3c             	add    $0x3c,%esp
 4bb:	5b                   	pop    %ebx
 4bc:	5e                   	pop    %esi
 4bd:	5f                   	pop    %edi
 4be:	5d                   	pop    %ebp
 4bf:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 4c0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4c7:	b9 10 00 00 00       	mov    $0x10,%ecx
 4cc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 4cf:	89 f8                	mov    %edi,%eax
 4d1:	8b 13                	mov    (%ebx),%edx
 4d3:	e8 58 fe ff ff       	call   330 <printint>
        ap++;
 4d8:	89 d8                	mov    %ebx,%eax
      state = 0;
 4da:	31 d2                	xor    %edx,%edx
        ap++;
 4dc:	83 c0 04             	add    $0x4,%eax
 4df:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4e2:	e9 44 ff ff ff       	jmp    42b <printf+0x5b>
 4e7:	89 f6                	mov    %esi,%esi
 4e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 4f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 4f3:	8b 10                	mov    (%eax),%edx
        ap++;
 4f5:	83 c0 04             	add    $0x4,%eax
 4f8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 4fb:	85 d2                	test   %edx,%edx
 4fd:	0f 84 aa 00 00 00    	je     5ad <printf+0x1dd>
        while(*s != 0){
 503:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 506:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 508:	84 c0                	test   %al,%al
 50a:	74 27                	je     533 <printf+0x163>
 50c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 510:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 513:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 518:	43                   	inc    %ebx
  write(fd, &c, 1);
 519:	89 44 24 08          	mov    %eax,0x8(%esp)
 51d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 520:	89 44 24 04          	mov    %eax,0x4(%esp)
 524:	89 3c 24             	mov    %edi,(%esp)
 527:	e8 5c fd ff ff       	call   288 <write>
        while(*s != 0){
 52c:	0f b6 03             	movzbl (%ebx),%eax
 52f:	84 c0                	test   %al,%al
 531:	75 dd                	jne    510 <printf+0x140>
      state = 0;
 533:	31 d2                	xor    %edx,%edx
 535:	e9 f1 fe ff ff       	jmp    42b <printf+0x5b>
 53a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 540:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 547:	b9 0a 00 00 00       	mov    $0xa,%ecx
 54c:	e9 7b ff ff ff       	jmp    4cc <printf+0xfc>
 551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 558:	b9 01 00 00 00       	mov    $0x1,%ecx
 55d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 560:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 564:	89 44 24 04          	mov    %eax,0x4(%esp)
 568:	89 3c 24             	mov    %edi,(%esp)
 56b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 56e:	e8 15 fd ff ff       	call   288 <write>
      state = 0;
 573:	31 d2                	xor    %edx,%edx
 575:	e9 b1 fe ff ff       	jmp    42b <printf+0x5b>
 57a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 580:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 583:	8b 03                	mov    (%ebx),%eax
        ap++;
 585:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 588:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 58b:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 58e:	b8 01 00 00 00       	mov    $0x1,%eax
 593:	89 44 24 08          	mov    %eax,0x8(%esp)
 597:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 59a:	89 44 24 04          	mov    %eax,0x4(%esp)
 59e:	e8 e5 fc ff ff       	call   288 <write>
      state = 0;
 5a3:	31 d2                	xor    %edx,%edx
        ap++;
 5a5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5a8:	e9 7e fe ff ff       	jmp    42b <printf+0x5b>
          s = "(null)";
 5ad:	bb 57 07 00 00       	mov    $0x757,%ebx
        while(*s != 0){
 5b2:	b0 28                	mov    $0x28,%al
 5b4:	e9 57 ff ff ff       	jmp    510 <printf+0x140>
 5b9:	66 90                	xchg   %ax,%ax
 5bb:	66 90                	xchg   %ax,%ax
 5bd:	66 90                	xchg   %ax,%ax
 5bf:	90                   	nop

000005c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5c1:	a1 ec 09 00 00       	mov    0x9ec,%eax
{
 5c6:	89 e5                	mov    %esp,%ebp
 5c8:	57                   	push   %edi
 5c9:	56                   	push   %esi
 5ca:	53                   	push   %ebx
 5cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 5ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 5d1:	eb 0d                	jmp    5e0 <free+0x20>
 5d3:	90                   	nop
 5d4:	90                   	nop
 5d5:	90                   	nop
 5d6:	90                   	nop
 5d7:	90                   	nop
 5d8:	90                   	nop
 5d9:	90                   	nop
 5da:	90                   	nop
 5db:	90                   	nop
 5dc:	90                   	nop
 5dd:	90                   	nop
 5de:	90                   	nop
 5df:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e0:	39 c8                	cmp    %ecx,%eax
 5e2:	8b 10                	mov    (%eax),%edx
 5e4:	73 32                	jae    618 <free+0x58>
 5e6:	39 d1                	cmp    %edx,%ecx
 5e8:	72 04                	jb     5ee <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5ea:	39 d0                	cmp    %edx,%eax
 5ec:	72 32                	jb     620 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5ee:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5f1:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5f4:	39 fa                	cmp    %edi,%edx
 5f6:	74 30                	je     628 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5f8:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5fb:	8b 50 04             	mov    0x4(%eax),%edx
 5fe:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 601:	39 f1                	cmp    %esi,%ecx
 603:	74 3c                	je     641 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 605:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 607:	5b                   	pop    %ebx
  freep = p;
 608:	a3 ec 09 00 00       	mov    %eax,0x9ec
}
 60d:	5e                   	pop    %esi
 60e:	5f                   	pop    %edi
 60f:	5d                   	pop    %ebp
 610:	c3                   	ret    
 611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 618:	39 d0                	cmp    %edx,%eax
 61a:	72 04                	jb     620 <free+0x60>
 61c:	39 d1                	cmp    %edx,%ecx
 61e:	72 ce                	jb     5ee <free+0x2e>
{
 620:	89 d0                	mov    %edx,%eax
 622:	eb bc                	jmp    5e0 <free+0x20>
 624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 628:	8b 7a 04             	mov    0x4(%edx),%edi
 62b:	01 fe                	add    %edi,%esi
 62d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 630:	8b 10                	mov    (%eax),%edx
 632:	8b 12                	mov    (%edx),%edx
 634:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 637:	8b 50 04             	mov    0x4(%eax),%edx
 63a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 63d:	39 f1                	cmp    %esi,%ecx
 63f:	75 c4                	jne    605 <free+0x45>
    p->s.size += bp->s.size;
 641:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 644:	a3 ec 09 00 00       	mov    %eax,0x9ec
    p->s.size += bp->s.size;
 649:	01 ca                	add    %ecx,%edx
 64b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 64e:	8b 53 f8             	mov    -0x8(%ebx),%edx
 651:	89 10                	mov    %edx,(%eax)
}
 653:	5b                   	pop    %ebx
 654:	5e                   	pop    %esi
 655:	5f                   	pop    %edi
 656:	5d                   	pop    %ebp
 657:	c3                   	ret    
 658:	90                   	nop
 659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000660 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 660:	55                   	push   %ebp
 661:	89 e5                	mov    %esp,%ebp
 663:	57                   	push   %edi
 664:	56                   	push   %esi
 665:	53                   	push   %ebx
 666:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 669:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 66c:	8b 15 ec 09 00 00    	mov    0x9ec,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 672:	8d 78 07             	lea    0x7(%eax),%edi
 675:	c1 ef 03             	shr    $0x3,%edi
 678:	47                   	inc    %edi
  if((prevp = freep) == 0){
 679:	85 d2                	test   %edx,%edx
 67b:	0f 84 8f 00 00 00    	je     710 <malloc+0xb0>
 681:	8b 02                	mov    (%edx),%eax
 683:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 686:	39 cf                	cmp    %ecx,%edi
 688:	76 66                	jbe    6f0 <malloc+0x90>
 68a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 690:	bb 00 10 00 00       	mov    $0x1000,%ebx
 695:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 698:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 69f:	eb 10                	jmp    6b1 <malloc+0x51>
 6a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6a8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6aa:	8b 48 04             	mov    0x4(%eax),%ecx
 6ad:	39 f9                	cmp    %edi,%ecx
 6af:	73 3f                	jae    6f0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6b1:	39 05 ec 09 00 00    	cmp    %eax,0x9ec
 6b7:	89 c2                	mov    %eax,%edx
 6b9:	75 ed                	jne    6a8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 6bb:	89 34 24             	mov    %esi,(%esp)
 6be:	e8 2d fc ff ff       	call   2f0 <sbrk>
  if(p == (char*)-1)
 6c3:	83 f8 ff             	cmp    $0xffffffff,%eax
 6c6:	74 18                	je     6e0 <malloc+0x80>
  hp->s.size = nu;
 6c8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 6cb:	83 c0 08             	add    $0x8,%eax
 6ce:	89 04 24             	mov    %eax,(%esp)
 6d1:	e8 ea fe ff ff       	call   5c0 <free>
  return freep;
 6d6:	8b 15 ec 09 00 00    	mov    0x9ec,%edx
      if((p = morecore(nunits)) == 0)
 6dc:	85 d2                	test   %edx,%edx
 6de:	75 c8                	jne    6a8 <malloc+0x48>
        return 0;
  }
}
 6e0:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 6e3:	31 c0                	xor    %eax,%eax
}
 6e5:	5b                   	pop    %ebx
 6e6:	5e                   	pop    %esi
 6e7:	5f                   	pop    %edi
 6e8:	5d                   	pop    %ebp
 6e9:	c3                   	ret    
 6ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 6f0:	39 cf                	cmp    %ecx,%edi
 6f2:	74 4c                	je     740 <malloc+0xe0>
        p->s.size -= nunits;
 6f4:	29 f9                	sub    %edi,%ecx
 6f6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 6f9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 6fc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 6ff:	89 15 ec 09 00 00    	mov    %edx,0x9ec
}
 705:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 708:	83 c0 08             	add    $0x8,%eax
}
 70b:	5b                   	pop    %ebx
 70c:	5e                   	pop    %esi
 70d:	5f                   	pop    %edi
 70e:	5d                   	pop    %ebp
 70f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 710:	b8 f0 09 00 00       	mov    $0x9f0,%eax
 715:	ba f0 09 00 00       	mov    $0x9f0,%edx
    base.s.size = 0;
 71a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 71c:	a3 ec 09 00 00       	mov    %eax,0x9ec
    base.s.size = 0;
 721:	b8 f0 09 00 00       	mov    $0x9f0,%eax
    base.s.ptr = freep = prevp = &base;
 726:	89 15 f0 09 00 00    	mov    %edx,0x9f0
    base.s.size = 0;
 72c:	89 0d f4 09 00 00    	mov    %ecx,0x9f4
 732:	e9 53 ff ff ff       	jmp    68a <malloc+0x2a>
 737:	89 f6                	mov    %esi,%esi
 739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 740:	8b 08                	mov    (%eax),%ecx
 742:	89 0a                	mov    %ecx,(%edx)
 744:	eb b9                	jmp    6ff <malloc+0x9f>
