
_policy:     file format elf32-i386


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
    if(argc < 2){
   9:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
   d:	7e 22                	jle    31 <main+0x31>
        printf(2, "usage: policy policy_id...\n");
        exit(0);
    }
    policy(atoi(argv[1]));
   f:	8b 45 0c             	mov    0xc(%ebp),%eax
  12:	8b 40 04             	mov    0x4(%eax),%eax
  15:	89 04 24             	mov    %eax,(%esp)
  18:	e8 f3 01 00 00       	call   210 <atoi>
  1d:	89 04 24             	mov    %eax,(%esp)
  20:	e8 13 03 00 00       	call   338 <policy>
    exit(0);
  25:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  2c:	e8 57 02 00 00       	call   288 <exit>
        printf(2, "usage: policy policy_id...\n");
  31:	c7 44 24 04 68 07 00 	movl   $0x768,0x4(%esp)
  38:	00 
  39:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  40:	e8 ab 03 00 00       	call   3f0 <printf>
        exit(0);
  45:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  4c:	e8 37 02 00 00       	call   288 <exit>
  51:	66 90                	xchg   %ax,%ax
  53:	66 90                	xchg   %ax,%ax
  55:	66 90                	xchg   %ax,%ax
  57:	66 90                	xchg   %ax,%ax
  59:	66 90                	xchg   %ax,%ax
  5b:	66 90                	xchg   %ax,%ax
  5d:	66 90                	xchg   %ax,%ax
  5f:	90                   	nop

00000060 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	8b 45 08             	mov    0x8(%ebp),%eax
  66:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  69:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6a:	89 c2                	mov    %eax,%edx
  6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  70:	41                   	inc    %ecx
  71:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  75:	42                   	inc    %edx
  76:	84 db                	test   %bl,%bl
  78:	88 5a ff             	mov    %bl,-0x1(%edx)
  7b:	75 f3                	jne    70 <strcpy+0x10>
    ;
  return os;
}
  7d:	5b                   	pop    %ebx
  7e:	5d                   	pop    %ebp
  7f:	c3                   	ret    

00000080 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	8b 4d 08             	mov    0x8(%ebp),%ecx
  86:	53                   	push   %ebx
  87:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  8a:	0f b6 01             	movzbl (%ecx),%eax
  8d:	0f b6 13             	movzbl (%ebx),%edx
  90:	84 c0                	test   %al,%al
  92:	75 18                	jne    ac <strcmp+0x2c>
  94:	eb 22                	jmp    b8 <strcmp+0x38>
  96:	8d 76 00             	lea    0x0(%esi),%esi
  99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  a0:	41                   	inc    %ecx
  while(*p && *p == *q)
  a1:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
  a4:	43                   	inc    %ebx
  a5:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
  a8:	84 c0                	test   %al,%al
  aa:	74 0c                	je     b8 <strcmp+0x38>
  ac:	38 d0                	cmp    %dl,%al
  ae:	74 f0                	je     a0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
  b0:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
  b1:	29 d0                	sub    %edx,%eax
}
  b3:	5d                   	pop    %ebp
  b4:	c3                   	ret    
  b5:	8d 76 00             	lea    0x0(%esi),%esi
  b8:	5b                   	pop    %ebx
  b9:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  bb:	29 d0                	sub    %edx,%eax
}
  bd:	5d                   	pop    %ebp
  be:	c3                   	ret    
  bf:	90                   	nop

000000c0 <strlen>:

uint
strlen(const char *s)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  c6:	80 39 00             	cmpb   $0x0,(%ecx)
  c9:	74 15                	je     e0 <strlen+0x20>
  cb:	31 d2                	xor    %edx,%edx
  cd:	8d 76 00             	lea    0x0(%esi),%esi
  d0:	42                   	inc    %edx
  d1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  d5:	89 d0                	mov    %edx,%eax
  d7:	75 f7                	jne    d0 <strlen+0x10>
    ;
  return n;
}
  d9:	5d                   	pop    %ebp
  da:	c3                   	ret    
  db:	90                   	nop
  dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
  e0:	31 c0                	xor    %eax,%eax
}
  e2:	5d                   	pop    %ebp
  e3:	c3                   	ret    
  e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	8b 55 08             	mov    0x8(%ebp),%edx
  f6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  fd:	89 d7                	mov    %edx,%edi
  ff:	fc                   	cld    
 100:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 102:	5f                   	pop    %edi
 103:	89 d0                	mov    %edx,%eax
 105:	5d                   	pop    %ebp
 106:	c3                   	ret    
 107:	89 f6                	mov    %esi,%esi
 109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000110 <strchr>:

char*
strchr(const char *s, char c)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	8b 45 08             	mov    0x8(%ebp),%eax
 116:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 11a:	0f b6 10             	movzbl (%eax),%edx
 11d:	84 d2                	test   %dl,%dl
 11f:	74 1b                	je     13c <strchr+0x2c>
    if(*s == c)
 121:	38 d1                	cmp    %dl,%cl
 123:	75 0f                	jne    134 <strchr+0x24>
 125:	eb 17                	jmp    13e <strchr+0x2e>
 127:	89 f6                	mov    %esi,%esi
 129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 130:	38 ca                	cmp    %cl,%dl
 132:	74 0a                	je     13e <strchr+0x2e>
  for(; *s; s++)
 134:	40                   	inc    %eax
 135:	0f b6 10             	movzbl (%eax),%edx
 138:	84 d2                	test   %dl,%dl
 13a:	75 f4                	jne    130 <strchr+0x20>
      return (char*)s;
  return 0;
 13c:	31 c0                	xor    %eax,%eax
}
 13e:	5d                   	pop    %ebp
 13f:	c3                   	ret    

00000140 <gets>:

char*
gets(char *buf, int max)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
 144:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 145:	31 f6                	xor    %esi,%esi
{
 147:	53                   	push   %ebx
 148:	83 ec 3c             	sub    $0x3c,%esp
 14b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
 14e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 151:	eb 32                	jmp    185 <gets+0x45>
 153:	90                   	nop
 154:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 158:	ba 01 00 00 00       	mov    $0x1,%edx
 15d:	89 54 24 08          	mov    %edx,0x8(%esp)
 161:	89 7c 24 04          	mov    %edi,0x4(%esp)
 165:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 16c:	e8 2f 01 00 00       	call   2a0 <read>
    if(cc < 1)
 171:	85 c0                	test   %eax,%eax
 173:	7e 19                	jle    18e <gets+0x4e>
      break;
    buf[i++] = c;
 175:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 179:	43                   	inc    %ebx
 17a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
 17d:	3c 0a                	cmp    $0xa,%al
 17f:	74 1f                	je     1a0 <gets+0x60>
 181:	3c 0d                	cmp    $0xd,%al
 183:	74 1b                	je     1a0 <gets+0x60>
  for(i=0; i+1 < max; ){
 185:	46                   	inc    %esi
 186:	3b 75 0c             	cmp    0xc(%ebp),%esi
 189:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 18c:	7c ca                	jl     158 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 18e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 191:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 194:	8b 45 08             	mov    0x8(%ebp),%eax
 197:	83 c4 3c             	add    $0x3c,%esp
 19a:	5b                   	pop    %ebx
 19b:	5e                   	pop    %esi
 19c:	5f                   	pop    %edi
 19d:	5d                   	pop    %ebp
 19e:	c3                   	ret    
 19f:	90                   	nop
 1a0:	8b 45 08             	mov    0x8(%ebp),%eax
 1a3:	01 c6                	add    %eax,%esi
 1a5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 1a8:	eb e4                	jmp    18e <gets+0x4e>
 1aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001b0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1b0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b1:	31 c0                	xor    %eax,%eax
{
 1b3:	89 e5                	mov    %esp,%ebp
 1b5:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 1b8:	89 44 24 04          	mov    %eax,0x4(%esp)
 1bc:	8b 45 08             	mov    0x8(%ebp),%eax
{
 1bf:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1c2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 1c5:	89 04 24             	mov    %eax,(%esp)
 1c8:	e8 fb 00 00 00       	call   2c8 <open>
  if(fd < 0)
 1cd:	85 c0                	test   %eax,%eax
 1cf:	78 2f                	js     200 <stat+0x50>
 1d1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1d3:	8b 45 0c             	mov    0xc(%ebp),%eax
 1d6:	89 1c 24             	mov    %ebx,(%esp)
 1d9:	89 44 24 04          	mov    %eax,0x4(%esp)
 1dd:	e8 fe 00 00 00       	call   2e0 <fstat>
  close(fd);
 1e2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1e5:	89 c6                	mov    %eax,%esi
  close(fd);
 1e7:	e8 c4 00 00 00       	call   2b0 <close>
  return r;
}
 1ec:	89 f0                	mov    %esi,%eax
 1ee:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 1f1:	8b 75 fc             	mov    -0x4(%ebp),%esi
 1f4:	89 ec                	mov    %ebp,%esp
 1f6:	5d                   	pop    %ebp
 1f7:	c3                   	ret    
 1f8:	90                   	nop
 1f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 200:	be ff ff ff ff       	mov    $0xffffffff,%esi
 205:	eb e5                	jmp    1ec <stat+0x3c>
 207:	89 f6                	mov    %esi,%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <atoi>:

int
atoi(const char *s)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 4d 08             	mov    0x8(%ebp),%ecx
 216:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 217:	0f be 11             	movsbl (%ecx),%edx
 21a:	88 d0                	mov    %dl,%al
 21c:	2c 30                	sub    $0x30,%al
 21e:	3c 09                	cmp    $0x9,%al
  n = 0;
 220:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 225:	77 1e                	ja     245 <atoi+0x35>
 227:	89 f6                	mov    %esi,%esi
 229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 230:	41                   	inc    %ecx
 231:	8d 04 80             	lea    (%eax,%eax,4),%eax
 234:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 238:	0f be 11             	movsbl (%ecx),%edx
 23b:	88 d3                	mov    %dl,%bl
 23d:	80 eb 30             	sub    $0x30,%bl
 240:	80 fb 09             	cmp    $0x9,%bl
 243:	76 eb                	jbe    230 <atoi+0x20>
  return n;
}
 245:	5b                   	pop    %ebx
 246:	5d                   	pop    %ebp
 247:	c3                   	ret    
 248:	90                   	nop
 249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000250 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	56                   	push   %esi
 254:	8b 45 08             	mov    0x8(%ebp),%eax
 257:	53                   	push   %ebx
 258:	8b 5d 10             	mov    0x10(%ebp),%ebx
 25b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 25e:	85 db                	test   %ebx,%ebx
 260:	7e 1a                	jle    27c <memmove+0x2c>
 262:	31 d2                	xor    %edx,%edx
 264:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 26a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 270:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 274:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 277:	42                   	inc    %edx
  while(n-- > 0)
 278:	39 d3                	cmp    %edx,%ebx
 27a:	75 f4                	jne    270 <memmove+0x20>
  return vdst;
}
 27c:	5b                   	pop    %ebx
 27d:	5e                   	pop    %esi
 27e:	5d                   	pop    %ebp
 27f:	c3                   	ret    

00000280 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 280:	b8 01 00 00 00       	mov    $0x1,%eax
 285:	cd 40                	int    $0x40
 287:	c3                   	ret    

00000288 <exit>:
SYSCALL(exit)
 288:	b8 02 00 00 00       	mov    $0x2,%eax
 28d:	cd 40                	int    $0x40
 28f:	c3                   	ret    

00000290 <wait>:
SYSCALL(wait)
 290:	b8 03 00 00 00       	mov    $0x3,%eax
 295:	cd 40                	int    $0x40
 297:	c3                   	ret    

00000298 <pipe>:
SYSCALL(pipe)
 298:	b8 04 00 00 00       	mov    $0x4,%eax
 29d:	cd 40                	int    $0x40
 29f:	c3                   	ret    

000002a0 <read>:
SYSCALL(read)
 2a0:	b8 05 00 00 00       	mov    $0x5,%eax
 2a5:	cd 40                	int    $0x40
 2a7:	c3                   	ret    

000002a8 <write>:
SYSCALL(write)
 2a8:	b8 10 00 00 00       	mov    $0x10,%eax
 2ad:	cd 40                	int    $0x40
 2af:	c3                   	ret    

000002b0 <close>:
SYSCALL(close)
 2b0:	b8 15 00 00 00       	mov    $0x15,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <kill>:
SYSCALL(kill)
 2b8:	b8 06 00 00 00       	mov    $0x6,%eax
 2bd:	cd 40                	int    $0x40
 2bf:	c3                   	ret    

000002c0 <exec>:
SYSCALL(exec)
 2c0:	b8 07 00 00 00       	mov    $0x7,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <open>:
SYSCALL(open)
 2c8:	b8 0f 00 00 00       	mov    $0xf,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <mknod>:
SYSCALL(mknod)
 2d0:	b8 11 00 00 00       	mov    $0x11,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <unlink>:
SYSCALL(unlink)
 2d8:	b8 12 00 00 00       	mov    $0x12,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <fstat>:
SYSCALL(fstat)
 2e0:	b8 08 00 00 00       	mov    $0x8,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <link>:
SYSCALL(link)
 2e8:	b8 13 00 00 00       	mov    $0x13,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <mkdir>:
SYSCALL(mkdir)
 2f0:	b8 14 00 00 00       	mov    $0x14,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <chdir>:
SYSCALL(chdir)
 2f8:	b8 09 00 00 00       	mov    $0x9,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <dup>:
SYSCALL(dup)
 300:	b8 0a 00 00 00       	mov    $0xa,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <getpid>:
SYSCALL(getpid)
 308:	b8 0b 00 00 00       	mov    $0xb,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <sbrk>:
SYSCALL(sbrk)
 310:	b8 0c 00 00 00       	mov    $0xc,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <sleep>:
SYSCALL(sleep)
 318:	b8 0d 00 00 00       	mov    $0xd,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <uptime>:
SYSCALL(uptime)
 320:	b8 0e 00 00 00       	mov    $0xe,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <detach>:
SYSCALL(detach)
 328:	b8 16 00 00 00       	mov    $0x16,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <priority>:
SYSCALL(priority)
 330:	b8 17 00 00 00       	mov    $0x17,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <policy>:
SYSCALL(policy)
 338:	b8 18 00 00 00       	mov    $0x18,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <wait_stat>:
SYSCALL(wait_stat)
 340:	b8 19 00 00 00       	mov    $0x19,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    
 348:	66 90                	xchg   %ax,%ax
 34a:	66 90                	xchg   %ax,%ax
 34c:	66 90                	xchg   %ax,%ax
 34e:	66 90                	xchg   %ax,%ax

00000350 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	56                   	push   %esi
 355:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 356:	89 d3                	mov    %edx,%ebx
 358:	c1 eb 1f             	shr    $0x1f,%ebx
{
 35b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 35e:	84 db                	test   %bl,%bl
{
 360:	89 45 c0             	mov    %eax,-0x40(%ebp)
 363:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 365:	74 79                	je     3e0 <printint+0x90>
 367:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 36b:	74 73                	je     3e0 <printint+0x90>
    neg = 1;
    x = -xx;
 36d:	f7 d8                	neg    %eax
    neg = 1;
 36f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 376:	31 f6                	xor    %esi,%esi
 378:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 37b:	eb 05                	jmp    382 <printint+0x32>
 37d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 380:	89 fe                	mov    %edi,%esi
 382:	31 d2                	xor    %edx,%edx
 384:	f7 f1                	div    %ecx
 386:	8d 7e 01             	lea    0x1(%esi),%edi
 389:	0f b6 92 8c 07 00 00 	movzbl 0x78c(%edx),%edx
  }while((x /= base) != 0);
 390:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 392:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 395:	75 e9                	jne    380 <printint+0x30>
  if(neg)
 397:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 39a:	85 d2                	test   %edx,%edx
 39c:	74 08                	je     3a6 <printint+0x56>
    buf[i++] = '-';
 39e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 3a3:	8d 7e 02             	lea    0x2(%esi),%edi
 3a6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 3aa:	8b 7d c0             	mov    -0x40(%ebp),%edi
 3ad:	8d 76 00             	lea    0x0(%esi),%esi
 3b0:	0f b6 06             	movzbl (%esi),%eax
 3b3:	4e                   	dec    %esi
  write(fd, &c, 1);
 3b4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 3b8:	89 3c 24             	mov    %edi,(%esp)
 3bb:	88 45 d7             	mov    %al,-0x29(%ebp)
 3be:	b8 01 00 00 00       	mov    $0x1,%eax
 3c3:	89 44 24 08          	mov    %eax,0x8(%esp)
 3c7:	e8 dc fe ff ff       	call   2a8 <write>

  while(--i >= 0)
 3cc:	39 de                	cmp    %ebx,%esi
 3ce:	75 e0                	jne    3b0 <printint+0x60>
    putc(fd, buf[i]);
}
 3d0:	83 c4 4c             	add    $0x4c,%esp
 3d3:	5b                   	pop    %ebx
 3d4:	5e                   	pop    %esi
 3d5:	5f                   	pop    %edi
 3d6:	5d                   	pop    %ebp
 3d7:	c3                   	ret    
 3d8:	90                   	nop
 3d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 3e0:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3e7:	eb 8d                	jmp    376 <printint+0x26>
 3e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	56                   	push   %esi
 3f5:	53                   	push   %ebx
 3f6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3f9:	8b 75 0c             	mov    0xc(%ebp),%esi
 3fc:	0f b6 1e             	movzbl (%esi),%ebx
 3ff:	84 db                	test   %bl,%bl
 401:	0f 84 d1 00 00 00    	je     4d8 <printf+0xe8>
  state = 0;
 407:	31 ff                	xor    %edi,%edi
 409:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 40a:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 40d:	89 fa                	mov    %edi,%edx
 40f:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 412:	89 45 d0             	mov    %eax,-0x30(%ebp)
 415:	eb 41                	jmp    458 <printf+0x68>
 417:	89 f6                	mov    %esi,%esi
 419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 420:	83 f8 25             	cmp    $0x25,%eax
 423:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 426:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 42b:	74 1e                	je     44b <printf+0x5b>
  write(fd, &c, 1);
 42d:	b8 01 00 00 00       	mov    $0x1,%eax
 432:	89 44 24 08          	mov    %eax,0x8(%esp)
 436:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 439:	89 44 24 04          	mov    %eax,0x4(%esp)
 43d:	89 3c 24             	mov    %edi,(%esp)
 440:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 443:	e8 60 fe ff ff       	call   2a8 <write>
 448:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 44b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 44c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 450:	84 db                	test   %bl,%bl
 452:	0f 84 80 00 00 00    	je     4d8 <printf+0xe8>
    if(state == 0){
 458:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 45a:	0f be cb             	movsbl %bl,%ecx
 45d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 460:	74 be                	je     420 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 462:	83 fa 25             	cmp    $0x25,%edx
 465:	75 e4                	jne    44b <printf+0x5b>
      if(c == 'd'){
 467:	83 f8 64             	cmp    $0x64,%eax
 46a:	0f 84 f0 00 00 00    	je     560 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 470:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 476:	83 f9 70             	cmp    $0x70,%ecx
 479:	74 65                	je     4e0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 47b:	83 f8 73             	cmp    $0x73,%eax
 47e:	0f 84 8c 00 00 00    	je     510 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 484:	83 f8 63             	cmp    $0x63,%eax
 487:	0f 84 13 01 00 00    	je     5a0 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 48d:	83 f8 25             	cmp    $0x25,%eax
 490:	0f 84 e2 00 00 00    	je     578 <printf+0x188>
  write(fd, &c, 1);
 496:	b8 01 00 00 00       	mov    $0x1,%eax
 49b:	46                   	inc    %esi
 49c:	89 44 24 08          	mov    %eax,0x8(%esp)
 4a0:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4a3:	89 44 24 04          	mov    %eax,0x4(%esp)
 4a7:	89 3c 24             	mov    %edi,(%esp)
 4aa:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4ae:	e8 f5 fd ff ff       	call   2a8 <write>
 4b3:	ba 01 00 00 00       	mov    $0x1,%edx
 4b8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4bb:	89 54 24 08          	mov    %edx,0x8(%esp)
 4bf:	89 44 24 04          	mov    %eax,0x4(%esp)
 4c3:	89 3c 24             	mov    %edi,(%esp)
 4c6:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 4c9:	e8 da fd ff ff       	call   2a8 <write>
  for(i = 0; fmt[i]; i++){
 4ce:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4d2:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 4d4:	84 db                	test   %bl,%bl
 4d6:	75 80                	jne    458 <printf+0x68>
    }
  }
}
 4d8:	83 c4 3c             	add    $0x3c,%esp
 4db:	5b                   	pop    %ebx
 4dc:	5e                   	pop    %esi
 4dd:	5f                   	pop    %edi
 4de:	5d                   	pop    %ebp
 4df:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 4e0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4e7:	b9 10 00 00 00       	mov    $0x10,%ecx
 4ec:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 4ef:	89 f8                	mov    %edi,%eax
 4f1:	8b 13                	mov    (%ebx),%edx
 4f3:	e8 58 fe ff ff       	call   350 <printint>
        ap++;
 4f8:	89 d8                	mov    %ebx,%eax
      state = 0;
 4fa:	31 d2                	xor    %edx,%edx
        ap++;
 4fc:	83 c0 04             	add    $0x4,%eax
 4ff:	89 45 d0             	mov    %eax,-0x30(%ebp)
 502:	e9 44 ff ff ff       	jmp    44b <printf+0x5b>
 507:	89 f6                	mov    %esi,%esi
 509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 510:	8b 45 d0             	mov    -0x30(%ebp),%eax
 513:	8b 10                	mov    (%eax),%edx
        ap++;
 515:	83 c0 04             	add    $0x4,%eax
 518:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 51b:	85 d2                	test   %edx,%edx
 51d:	0f 84 aa 00 00 00    	je     5cd <printf+0x1dd>
        while(*s != 0){
 523:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 526:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 528:	84 c0                	test   %al,%al
 52a:	74 27                	je     553 <printf+0x163>
 52c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 530:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 533:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 538:	43                   	inc    %ebx
  write(fd, &c, 1);
 539:	89 44 24 08          	mov    %eax,0x8(%esp)
 53d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 540:	89 44 24 04          	mov    %eax,0x4(%esp)
 544:	89 3c 24             	mov    %edi,(%esp)
 547:	e8 5c fd ff ff       	call   2a8 <write>
        while(*s != 0){
 54c:	0f b6 03             	movzbl (%ebx),%eax
 54f:	84 c0                	test   %al,%al
 551:	75 dd                	jne    530 <printf+0x140>
      state = 0;
 553:	31 d2                	xor    %edx,%edx
 555:	e9 f1 fe ff ff       	jmp    44b <printf+0x5b>
 55a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 560:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 567:	b9 0a 00 00 00       	mov    $0xa,%ecx
 56c:	e9 7b ff ff ff       	jmp    4ec <printf+0xfc>
 571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 578:	b9 01 00 00 00       	mov    $0x1,%ecx
 57d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 580:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 584:	89 44 24 04          	mov    %eax,0x4(%esp)
 588:	89 3c 24             	mov    %edi,(%esp)
 58b:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 58e:	e8 15 fd ff ff       	call   2a8 <write>
      state = 0;
 593:	31 d2                	xor    %edx,%edx
 595:	e9 b1 fe ff ff       	jmp    44b <printf+0x5b>
 59a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 5a0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5a3:	8b 03                	mov    (%ebx),%eax
        ap++;
 5a5:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 5a8:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 5ab:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 5ae:	b8 01 00 00 00       	mov    $0x1,%eax
 5b3:	89 44 24 08          	mov    %eax,0x8(%esp)
 5b7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5ba:	89 44 24 04          	mov    %eax,0x4(%esp)
 5be:	e8 e5 fc ff ff       	call   2a8 <write>
      state = 0;
 5c3:	31 d2                	xor    %edx,%edx
        ap++;
 5c5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5c8:	e9 7e fe ff ff       	jmp    44b <printf+0x5b>
          s = "(null)";
 5cd:	bb 84 07 00 00       	mov    $0x784,%ebx
        while(*s != 0){
 5d2:	b0 28                	mov    $0x28,%al
 5d4:	e9 57 ff ff ff       	jmp    530 <printf+0x140>
 5d9:	66 90                	xchg   %ax,%ax
 5db:	66 90                	xchg   %ax,%ax
 5dd:	66 90                	xchg   %ax,%ax
 5df:	90                   	nop

000005e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e1:	a1 18 0a 00 00       	mov    0xa18,%eax
{
 5e6:	89 e5                	mov    %esp,%ebp
 5e8:	57                   	push   %edi
 5e9:	56                   	push   %esi
 5ea:	53                   	push   %ebx
 5eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 5ee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 5f1:	eb 0d                	jmp    600 <free+0x20>
 5f3:	90                   	nop
 5f4:	90                   	nop
 5f5:	90                   	nop
 5f6:	90                   	nop
 5f7:	90                   	nop
 5f8:	90                   	nop
 5f9:	90                   	nop
 5fa:	90                   	nop
 5fb:	90                   	nop
 5fc:	90                   	nop
 5fd:	90                   	nop
 5fe:	90                   	nop
 5ff:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 600:	39 c8                	cmp    %ecx,%eax
 602:	8b 10                	mov    (%eax),%edx
 604:	73 32                	jae    638 <free+0x58>
 606:	39 d1                	cmp    %edx,%ecx
 608:	72 04                	jb     60e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 60a:	39 d0                	cmp    %edx,%eax
 60c:	72 32                	jb     640 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 60e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 611:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 614:	39 fa                	cmp    %edi,%edx
 616:	74 30                	je     648 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 618:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 61b:	8b 50 04             	mov    0x4(%eax),%edx
 61e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 621:	39 f1                	cmp    %esi,%ecx
 623:	74 3c                	je     661 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 625:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 627:	5b                   	pop    %ebx
  freep = p;
 628:	a3 18 0a 00 00       	mov    %eax,0xa18
}
 62d:	5e                   	pop    %esi
 62e:	5f                   	pop    %edi
 62f:	5d                   	pop    %ebp
 630:	c3                   	ret    
 631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 638:	39 d0                	cmp    %edx,%eax
 63a:	72 04                	jb     640 <free+0x60>
 63c:	39 d1                	cmp    %edx,%ecx
 63e:	72 ce                	jb     60e <free+0x2e>
{
 640:	89 d0                	mov    %edx,%eax
 642:	eb bc                	jmp    600 <free+0x20>
 644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 648:	8b 7a 04             	mov    0x4(%edx),%edi
 64b:	01 fe                	add    %edi,%esi
 64d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 650:	8b 10                	mov    (%eax),%edx
 652:	8b 12                	mov    (%edx),%edx
 654:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 657:	8b 50 04             	mov    0x4(%eax),%edx
 65a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 65d:	39 f1                	cmp    %esi,%ecx
 65f:	75 c4                	jne    625 <free+0x45>
    p->s.size += bp->s.size;
 661:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 664:	a3 18 0a 00 00       	mov    %eax,0xa18
    p->s.size += bp->s.size;
 669:	01 ca                	add    %ecx,%edx
 66b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 66e:	8b 53 f8             	mov    -0x8(%ebx),%edx
 671:	89 10                	mov    %edx,(%eax)
}
 673:	5b                   	pop    %ebx
 674:	5e                   	pop    %esi
 675:	5f                   	pop    %edi
 676:	5d                   	pop    %ebp
 677:	c3                   	ret    
 678:	90                   	nop
 679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000680 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 680:	55                   	push   %ebp
 681:	89 e5                	mov    %esp,%ebp
 683:	57                   	push   %edi
 684:	56                   	push   %esi
 685:	53                   	push   %ebx
 686:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 689:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 68c:	8b 15 18 0a 00 00    	mov    0xa18,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 692:	8d 78 07             	lea    0x7(%eax),%edi
 695:	c1 ef 03             	shr    $0x3,%edi
 698:	47                   	inc    %edi
  if((prevp = freep) == 0){
 699:	85 d2                	test   %edx,%edx
 69b:	0f 84 8f 00 00 00    	je     730 <malloc+0xb0>
 6a1:	8b 02                	mov    (%edx),%eax
 6a3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6a6:	39 cf                	cmp    %ecx,%edi
 6a8:	76 66                	jbe    710 <malloc+0x90>
 6aa:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 6b0:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6b5:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 6b8:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6bf:	eb 10                	jmp    6d1 <malloc+0x51>
 6c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6c8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6ca:	8b 48 04             	mov    0x4(%eax),%ecx
 6cd:	39 f9                	cmp    %edi,%ecx
 6cf:	73 3f                	jae    710 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6d1:	39 05 18 0a 00 00    	cmp    %eax,0xa18
 6d7:	89 c2                	mov    %eax,%edx
 6d9:	75 ed                	jne    6c8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 6db:	89 34 24             	mov    %esi,(%esp)
 6de:	e8 2d fc ff ff       	call   310 <sbrk>
  if(p == (char*)-1)
 6e3:	83 f8 ff             	cmp    $0xffffffff,%eax
 6e6:	74 18                	je     700 <malloc+0x80>
  hp->s.size = nu;
 6e8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 6eb:	83 c0 08             	add    $0x8,%eax
 6ee:	89 04 24             	mov    %eax,(%esp)
 6f1:	e8 ea fe ff ff       	call   5e0 <free>
  return freep;
 6f6:	8b 15 18 0a 00 00    	mov    0xa18,%edx
      if((p = morecore(nunits)) == 0)
 6fc:	85 d2                	test   %edx,%edx
 6fe:	75 c8                	jne    6c8 <malloc+0x48>
        return 0;
  }
}
 700:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 703:	31 c0                	xor    %eax,%eax
}
 705:	5b                   	pop    %ebx
 706:	5e                   	pop    %esi
 707:	5f                   	pop    %edi
 708:	5d                   	pop    %ebp
 709:	c3                   	ret    
 70a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 710:	39 cf                	cmp    %ecx,%edi
 712:	74 4c                	je     760 <malloc+0xe0>
        p->s.size -= nunits;
 714:	29 f9                	sub    %edi,%ecx
 716:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 719:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 71c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 71f:	89 15 18 0a 00 00    	mov    %edx,0xa18
}
 725:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 728:	83 c0 08             	add    $0x8,%eax
}
 72b:	5b                   	pop    %ebx
 72c:	5e                   	pop    %esi
 72d:	5f                   	pop    %edi
 72e:	5d                   	pop    %ebp
 72f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 730:	b8 1c 0a 00 00       	mov    $0xa1c,%eax
 735:	ba 1c 0a 00 00       	mov    $0xa1c,%edx
    base.s.size = 0;
 73a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 73c:	a3 18 0a 00 00       	mov    %eax,0xa18
    base.s.size = 0;
 741:	b8 1c 0a 00 00       	mov    $0xa1c,%eax
    base.s.ptr = freep = prevp = &base;
 746:	89 15 1c 0a 00 00    	mov    %edx,0xa1c
    base.s.size = 0;
 74c:	89 0d 20 0a 00 00    	mov    %ecx,0xa20
 752:	e9 53 ff ff ff       	jmp    6aa <malloc+0x2a>
 757:	89 f6                	mov    %esi,%esi
 759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 760:	8b 08                	mov    (%eax),%ecx
 762:	89 0a                	mov    %ecx,(%edx)
 764:	eb b9                	jmp    71f <malloc+0x9f>
