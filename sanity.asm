
_sanity:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"
#include "fcntl.h"

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	83 ec 20             	sub    $0x20,%esp
	int status;
	int first_status;
	int second_status;
	int third_status;

	pid = fork(); 
   a:	e8 f1 02 00 00       	call   300 <fork>
	if(pid > 0) {
   f:	85 c0                	test   %eax,%eax
  11:	7e 66                	jle    79 <main+0x79>
		first_status = detach(pid); // status = 0
  13:	89 04 24             	mov    %eax,(%esp)
  16:	89 c3                	mov    %eax,%ebx
  18:	e8 8b 03 00 00       	call   3a8 <detach>
		printf(1, "first_status: %d\n", first_status);
  1d:	c7 44 24 04 d8 07 00 	movl   $0x7d8,0x4(%esp)
  24:	00 
  25:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  2c:	89 44 24 08          	mov    %eax,0x8(%esp)
  30:	e8 2b 04 00 00       	call   460 <printf>
		second_status = detach(pid); // status = -1, because this process has already detached this child, and it doesn’t have this child anymore.
  35:	89 1c 24             	mov    %ebx,(%esp)
  38:	e8 6b 03 00 00       	call   3a8 <detach>
		printf(1, "second_status: %d\n", second_status);
  3d:	c7 44 24 04 ea 07 00 	movl   $0x7ea,0x4(%esp)
  44:	00 
  45:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  4c:	89 44 24 08          	mov    %eax,0x8(%esp)
  50:	e8 0b 04 00 00       	call   460 <printf>
		third_status = detach(77); // status = -1, because this process doesn’t have a child with this pid.
  55:	c7 04 24 4d 00 00 00 	movl   $0x4d,(%esp)
  5c:	e8 47 03 00 00       	call   3a8 <detach>
		printf(1, "third_status: %d\n", third_status);
  61:	c7 44 24 04 fd 07 00 	movl   $0x7fd,0x4(%esp)
  68:	00 
  69:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  70:	89 44 24 08          	mov    %eax,0x8(%esp)
  74:	e8 e7 03 00 00       	call   460 <printf>
	}
	wait(&status);
  79:	8d 44 24 18          	lea    0x18(%esp),%eax
  7d:	89 04 24             	mov    %eax,(%esp)
  80:	e8 8b 02 00 00       	call   310 <wait>
        
        int pid2 = fork();
  85:	e8 76 02 00 00       	call   300 <fork>
        if (pid2 == 0) {
  8a:	85 c0                	test   %eax,%eax
  8c:	75 18                	jne    a6 <main+0xa6>
            sleep(100);
  8e:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
  95:	e8 fe 02 00 00       	call   398 <sleep>
            exit(5);
  9a:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  a1:	e8 62 02 00 00       	call   308 <exit>
        }
        else {
            int status2;
            wait(&status2);
  a6:	8d 44 24 1c          	lea    0x1c(%esp),%eax
  aa:	89 04 24             	mov    %eax,(%esp)
  ad:	e8 5e 02 00 00       	call   310 <wait>
            printf(1, "exit status after is %d\n", status2);
  b2:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  b6:	c7 44 24 04 0f 08 00 	movl   $0x80f,0x4(%esp)
  bd:	00 
  be:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c5:	89 44 24 08          	mov    %eax,0x8(%esp)
  c9:	e8 92 03 00 00       	call   460 <printf>
        }
        
	exit(0);
  ce:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  d5:	e8 2e 02 00 00       	call   308 <exit>
  da:	66 90                	xchg   %ax,%ax
  dc:	66 90                	xchg   %ax,%ax
  de:	66 90                	xchg   %ax,%ax

000000e0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 45 08             	mov    0x8(%ebp),%eax
  e6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  e9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  ea:	89 c2                	mov    %eax,%edx
  ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  f0:	41                   	inc    %ecx
  f1:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  f5:	42                   	inc    %edx
  f6:	84 db                	test   %bl,%bl
  f8:	88 5a ff             	mov    %bl,-0x1(%edx)
  fb:	75 f3                	jne    f0 <strcpy+0x10>
    ;
  return os;
}
  fd:	5b                   	pop    %ebx
  fe:	5d                   	pop    %ebp
  ff:	c3                   	ret    

00000100 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 4d 08             	mov    0x8(%ebp),%ecx
 106:	53                   	push   %ebx
 107:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 10a:	0f b6 01             	movzbl (%ecx),%eax
 10d:	0f b6 13             	movzbl (%ebx),%edx
 110:	84 c0                	test   %al,%al
 112:	75 18                	jne    12c <strcmp+0x2c>
 114:	eb 22                	jmp    138 <strcmp+0x38>
 116:	8d 76 00             	lea    0x0(%esi),%esi
 119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 120:	41                   	inc    %ecx
  while(*p && *p == *q)
 121:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 124:	43                   	inc    %ebx
 125:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
 128:	84 c0                	test   %al,%al
 12a:	74 0c                	je     138 <strcmp+0x38>
 12c:	38 d0                	cmp    %dl,%al
 12e:	74 f0                	je     120 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
 130:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 131:	29 d0                	sub    %edx,%eax
}
 133:	5d                   	pop    %ebp
 134:	c3                   	ret    
 135:	8d 76 00             	lea    0x0(%esi),%esi
 138:	5b                   	pop    %ebx
 139:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 13b:	29 d0                	sub    %edx,%eax
}
 13d:	5d                   	pop    %ebp
 13e:	c3                   	ret    
 13f:	90                   	nop

00000140 <strlen>:

uint
strlen(const char *s)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 146:	80 39 00             	cmpb   $0x0,(%ecx)
 149:	74 15                	je     160 <strlen+0x20>
 14b:	31 d2                	xor    %edx,%edx
 14d:	8d 76 00             	lea    0x0(%esi),%esi
 150:	42                   	inc    %edx
 151:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 155:	89 d0                	mov    %edx,%eax
 157:	75 f7                	jne    150 <strlen+0x10>
    ;
  return n;
}
 159:	5d                   	pop    %ebp
 15a:	c3                   	ret    
 15b:	90                   	nop
 15c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
 160:	31 c0                	xor    %eax,%eax
}
 162:	5d                   	pop    %ebp
 163:	c3                   	ret    
 164:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 16a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000170 <memset>:

void*
memset(void *dst, int c, uint n)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 55 08             	mov    0x8(%ebp),%edx
 176:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 177:	8b 4d 10             	mov    0x10(%ebp),%ecx
 17a:	8b 45 0c             	mov    0xc(%ebp),%eax
 17d:	89 d7                	mov    %edx,%edi
 17f:	fc                   	cld    
 180:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 182:	5f                   	pop    %edi
 183:	89 d0                	mov    %edx,%eax
 185:	5d                   	pop    %ebp
 186:	c3                   	ret    
 187:	89 f6                	mov    %esi,%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000190 <strchr>:

char*
strchr(const char *s, char c)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	8b 45 08             	mov    0x8(%ebp),%eax
 196:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 19a:	0f b6 10             	movzbl (%eax),%edx
 19d:	84 d2                	test   %dl,%dl
 19f:	74 1b                	je     1bc <strchr+0x2c>
    if(*s == c)
 1a1:	38 d1                	cmp    %dl,%cl
 1a3:	75 0f                	jne    1b4 <strchr+0x24>
 1a5:	eb 17                	jmp    1be <strchr+0x2e>
 1a7:	89 f6                	mov    %esi,%esi
 1a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 1b0:	38 ca                	cmp    %cl,%dl
 1b2:	74 0a                	je     1be <strchr+0x2e>
  for(; *s; s++)
 1b4:	40                   	inc    %eax
 1b5:	0f b6 10             	movzbl (%eax),%edx
 1b8:	84 d2                	test   %dl,%dl
 1ba:	75 f4                	jne    1b0 <strchr+0x20>
      return (char*)s;
  return 0;
 1bc:	31 c0                	xor    %eax,%eax
}
 1be:	5d                   	pop    %ebp
 1bf:	c3                   	ret    

000001c0 <gets>:

char*
gets(char *buf, int max)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	57                   	push   %edi
 1c4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c5:	31 f6                	xor    %esi,%esi
{
 1c7:	53                   	push   %ebx
 1c8:	83 ec 3c             	sub    $0x3c,%esp
 1cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
 1ce:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 1d1:	eb 32                	jmp    205 <gets+0x45>
 1d3:	90                   	nop
 1d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 1d8:	ba 01 00 00 00       	mov    $0x1,%edx
 1dd:	89 54 24 08          	mov    %edx,0x8(%esp)
 1e1:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1e5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1ec:	e8 2f 01 00 00       	call   320 <read>
    if(cc < 1)
 1f1:	85 c0                	test   %eax,%eax
 1f3:	7e 19                	jle    20e <gets+0x4e>
      break;
    buf[i++] = c;
 1f5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1f9:	43                   	inc    %ebx
 1fa:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
 1fd:	3c 0a                	cmp    $0xa,%al
 1ff:	74 1f                	je     220 <gets+0x60>
 201:	3c 0d                	cmp    $0xd,%al
 203:	74 1b                	je     220 <gets+0x60>
  for(i=0; i+1 < max; ){
 205:	46                   	inc    %esi
 206:	3b 75 0c             	cmp    0xc(%ebp),%esi
 209:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 20c:	7c ca                	jl     1d8 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 20e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 211:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 214:	8b 45 08             	mov    0x8(%ebp),%eax
 217:	83 c4 3c             	add    $0x3c,%esp
 21a:	5b                   	pop    %ebx
 21b:	5e                   	pop    %esi
 21c:	5f                   	pop    %edi
 21d:	5d                   	pop    %ebp
 21e:	c3                   	ret    
 21f:	90                   	nop
 220:	8b 45 08             	mov    0x8(%ebp),%eax
 223:	01 c6                	add    %eax,%esi
 225:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 228:	eb e4                	jmp    20e <gets+0x4e>
 22a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000230 <stat>:

int
stat(const char *n, struct stat *st)
{
 230:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 231:	31 c0                	xor    %eax,%eax
{
 233:	89 e5                	mov    %esp,%ebp
 235:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 238:	89 44 24 04          	mov    %eax,0x4(%esp)
 23c:	8b 45 08             	mov    0x8(%ebp),%eax
{
 23f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 242:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 245:	89 04 24             	mov    %eax,(%esp)
 248:	e8 fb 00 00 00       	call   348 <open>
  if(fd < 0)
 24d:	85 c0                	test   %eax,%eax
 24f:	78 2f                	js     280 <stat+0x50>
 251:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 253:	8b 45 0c             	mov    0xc(%ebp),%eax
 256:	89 1c 24             	mov    %ebx,(%esp)
 259:	89 44 24 04          	mov    %eax,0x4(%esp)
 25d:	e8 fe 00 00 00       	call   360 <fstat>
  close(fd);
 262:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 265:	89 c6                	mov    %eax,%esi
  close(fd);
 267:	e8 c4 00 00 00       	call   330 <close>
  return r;
}
 26c:	89 f0                	mov    %esi,%eax
 26e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 271:	8b 75 fc             	mov    -0x4(%ebp),%esi
 274:	89 ec                	mov    %ebp,%esp
 276:	5d                   	pop    %ebp
 277:	c3                   	ret    
 278:	90                   	nop
 279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 280:	be ff ff ff ff       	mov    $0xffffffff,%esi
 285:	eb e5                	jmp    26c <stat+0x3c>
 287:	89 f6                	mov    %esi,%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000290 <atoi>:

int
atoi(const char *s)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	8b 4d 08             	mov    0x8(%ebp),%ecx
 296:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 297:	0f be 11             	movsbl (%ecx),%edx
 29a:	88 d0                	mov    %dl,%al
 29c:	2c 30                	sub    $0x30,%al
 29e:	3c 09                	cmp    $0x9,%al
  n = 0;
 2a0:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 2a5:	77 1e                	ja     2c5 <atoi+0x35>
 2a7:	89 f6                	mov    %esi,%esi
 2a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 2b0:	41                   	inc    %ecx
 2b1:	8d 04 80             	lea    (%eax,%eax,4),%eax
 2b4:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 2b8:	0f be 11             	movsbl (%ecx),%edx
 2bb:	88 d3                	mov    %dl,%bl
 2bd:	80 eb 30             	sub    $0x30,%bl
 2c0:	80 fb 09             	cmp    $0x9,%bl
 2c3:	76 eb                	jbe    2b0 <atoi+0x20>
  return n;
}
 2c5:	5b                   	pop    %ebx
 2c6:	5d                   	pop    %ebp
 2c7:	c3                   	ret    
 2c8:	90                   	nop
 2c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002d0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	56                   	push   %esi
 2d4:	8b 45 08             	mov    0x8(%ebp),%eax
 2d7:	53                   	push   %ebx
 2d8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 2db:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2de:	85 db                	test   %ebx,%ebx
 2e0:	7e 1a                	jle    2fc <memmove+0x2c>
 2e2:	31 d2                	xor    %edx,%edx
 2e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 2f0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2f4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2f7:	42                   	inc    %edx
  while(n-- > 0)
 2f8:	39 d3                	cmp    %edx,%ebx
 2fa:	75 f4                	jne    2f0 <memmove+0x20>
  return vdst;
}
 2fc:	5b                   	pop    %ebx
 2fd:	5e                   	pop    %esi
 2fe:	5d                   	pop    %ebp
 2ff:	c3                   	ret    

00000300 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 300:	b8 01 00 00 00       	mov    $0x1,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <exit>:
SYSCALL(exit)
 308:	b8 02 00 00 00       	mov    $0x2,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <wait>:
SYSCALL(wait)
 310:	b8 03 00 00 00       	mov    $0x3,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <pipe>:
SYSCALL(pipe)
 318:	b8 04 00 00 00       	mov    $0x4,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <read>:
SYSCALL(read)
 320:	b8 05 00 00 00       	mov    $0x5,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <write>:
SYSCALL(write)
 328:	b8 10 00 00 00       	mov    $0x10,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <close>:
SYSCALL(close)
 330:	b8 15 00 00 00       	mov    $0x15,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <kill>:
SYSCALL(kill)
 338:	b8 06 00 00 00       	mov    $0x6,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <exec>:
SYSCALL(exec)
 340:	b8 07 00 00 00       	mov    $0x7,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <open>:
SYSCALL(open)
 348:	b8 0f 00 00 00       	mov    $0xf,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <mknod>:
SYSCALL(mknod)
 350:	b8 11 00 00 00       	mov    $0x11,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <unlink>:
SYSCALL(unlink)
 358:	b8 12 00 00 00       	mov    $0x12,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <fstat>:
SYSCALL(fstat)
 360:	b8 08 00 00 00       	mov    $0x8,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <link>:
SYSCALL(link)
 368:	b8 13 00 00 00       	mov    $0x13,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <mkdir>:
SYSCALL(mkdir)
 370:	b8 14 00 00 00       	mov    $0x14,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <chdir>:
SYSCALL(chdir)
 378:	b8 09 00 00 00       	mov    $0x9,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <dup>:
SYSCALL(dup)
 380:	b8 0a 00 00 00       	mov    $0xa,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <getpid>:
SYSCALL(getpid)
 388:	b8 0b 00 00 00       	mov    $0xb,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <sbrk>:
SYSCALL(sbrk)
 390:	b8 0c 00 00 00       	mov    $0xc,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <sleep>:
SYSCALL(sleep)
 398:	b8 0d 00 00 00       	mov    $0xd,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <uptime>:
SYSCALL(uptime)
 3a0:	b8 0e 00 00 00       	mov    $0xe,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <detach>:
SYSCALL(detach)
 3a8:	b8 16 00 00 00       	mov    $0x16,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <priority>:
SYSCALL(priority)
 3b0:	b8 17 00 00 00       	mov    $0x17,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <policy>:
SYSCALL(policy)
 3b8:	b8 18 00 00 00       	mov    $0x18,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	57                   	push   %edi
 3c4:	56                   	push   %esi
 3c5:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3c6:	89 d3                	mov    %edx,%ebx
 3c8:	c1 eb 1f             	shr    $0x1f,%ebx
{
 3cb:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 3ce:	84 db                	test   %bl,%bl
{
 3d0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 3d3:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 3d5:	74 79                	je     450 <printint+0x90>
 3d7:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3db:	74 73                	je     450 <printint+0x90>
    neg = 1;
    x = -xx;
 3dd:	f7 d8                	neg    %eax
    neg = 1;
 3df:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 3e6:	31 f6                	xor    %esi,%esi
 3e8:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 3eb:	eb 05                	jmp    3f2 <printint+0x32>
 3ed:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 3f0:	89 fe                	mov    %edi,%esi
 3f2:	31 d2                	xor    %edx,%edx
 3f4:	f7 f1                	div    %ecx
 3f6:	8d 7e 01             	lea    0x1(%esi),%edi
 3f9:	0f b6 92 30 08 00 00 	movzbl 0x830(%edx),%edx
  }while((x /= base) != 0);
 400:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 402:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 405:	75 e9                	jne    3f0 <printint+0x30>
  if(neg)
 407:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 40a:	85 d2                	test   %edx,%edx
 40c:	74 08                	je     416 <printint+0x56>
    buf[i++] = '-';
 40e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 413:	8d 7e 02             	lea    0x2(%esi),%edi
 416:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 41a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 41d:	8d 76 00             	lea    0x0(%esi),%esi
 420:	0f b6 06             	movzbl (%esi),%eax
 423:	4e                   	dec    %esi
  write(fd, &c, 1);
 424:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 428:	89 3c 24             	mov    %edi,(%esp)
 42b:	88 45 d7             	mov    %al,-0x29(%ebp)
 42e:	b8 01 00 00 00       	mov    $0x1,%eax
 433:	89 44 24 08          	mov    %eax,0x8(%esp)
 437:	e8 ec fe ff ff       	call   328 <write>

  while(--i >= 0)
 43c:	39 de                	cmp    %ebx,%esi
 43e:	75 e0                	jne    420 <printint+0x60>
    putc(fd, buf[i]);
}
 440:	83 c4 4c             	add    $0x4c,%esp
 443:	5b                   	pop    %ebx
 444:	5e                   	pop    %esi
 445:	5f                   	pop    %edi
 446:	5d                   	pop    %ebp
 447:	c3                   	ret    
 448:	90                   	nop
 449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 450:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 457:	eb 8d                	jmp    3e6 <printint+0x26>
 459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000460 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	56                   	push   %esi
 465:	53                   	push   %ebx
 466:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 469:	8b 75 0c             	mov    0xc(%ebp),%esi
 46c:	0f b6 1e             	movzbl (%esi),%ebx
 46f:	84 db                	test   %bl,%bl
 471:	0f 84 d1 00 00 00    	je     548 <printf+0xe8>
  state = 0;
 477:	31 ff                	xor    %edi,%edi
 479:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 47a:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 47d:	89 fa                	mov    %edi,%edx
 47f:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 482:	89 45 d0             	mov    %eax,-0x30(%ebp)
 485:	eb 41                	jmp    4c8 <printf+0x68>
 487:	89 f6                	mov    %esi,%esi
 489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 490:	83 f8 25             	cmp    $0x25,%eax
 493:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 496:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 49b:	74 1e                	je     4bb <printf+0x5b>
  write(fd, &c, 1);
 49d:	b8 01 00 00 00       	mov    $0x1,%eax
 4a2:	89 44 24 08          	mov    %eax,0x8(%esp)
 4a6:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 4a9:	89 44 24 04          	mov    %eax,0x4(%esp)
 4ad:	89 3c 24             	mov    %edi,(%esp)
 4b0:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 4b3:	e8 70 fe ff ff       	call   328 <write>
 4b8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 4bb:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 4bc:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 4c0:	84 db                	test   %bl,%bl
 4c2:	0f 84 80 00 00 00    	je     548 <printf+0xe8>
    if(state == 0){
 4c8:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 4ca:	0f be cb             	movsbl %bl,%ecx
 4cd:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 4d0:	74 be                	je     490 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4d2:	83 fa 25             	cmp    $0x25,%edx
 4d5:	75 e4                	jne    4bb <printf+0x5b>
      if(c == 'd'){
 4d7:	83 f8 64             	cmp    $0x64,%eax
 4da:	0f 84 f0 00 00 00    	je     5d0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4e0:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 4e6:	83 f9 70             	cmp    $0x70,%ecx
 4e9:	74 65                	je     550 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4eb:	83 f8 73             	cmp    $0x73,%eax
 4ee:	0f 84 8c 00 00 00    	je     580 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4f4:	83 f8 63             	cmp    $0x63,%eax
 4f7:	0f 84 13 01 00 00    	je     610 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4fd:	83 f8 25             	cmp    $0x25,%eax
 500:	0f 84 e2 00 00 00    	je     5e8 <printf+0x188>
  write(fd, &c, 1);
 506:	b8 01 00 00 00       	mov    $0x1,%eax
 50b:	46                   	inc    %esi
 50c:	89 44 24 08          	mov    %eax,0x8(%esp)
 510:	8d 45 e7             	lea    -0x19(%ebp),%eax
 513:	89 44 24 04          	mov    %eax,0x4(%esp)
 517:	89 3c 24             	mov    %edi,(%esp)
 51a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 51e:	e8 05 fe ff ff       	call   328 <write>
 523:	ba 01 00 00 00       	mov    $0x1,%edx
 528:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 52b:	89 54 24 08          	mov    %edx,0x8(%esp)
 52f:	89 44 24 04          	mov    %eax,0x4(%esp)
 533:	89 3c 24             	mov    %edi,(%esp)
 536:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 539:	e8 ea fd ff ff       	call   328 <write>
  for(i = 0; fmt[i]; i++){
 53e:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 542:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 544:	84 db                	test   %bl,%bl
 546:	75 80                	jne    4c8 <printf+0x68>
    }
  }
}
 548:	83 c4 3c             	add    $0x3c,%esp
 54b:	5b                   	pop    %ebx
 54c:	5e                   	pop    %esi
 54d:	5f                   	pop    %edi
 54e:	5d                   	pop    %ebp
 54f:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 550:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 557:	b9 10 00 00 00       	mov    $0x10,%ecx
 55c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 55f:	89 f8                	mov    %edi,%eax
 561:	8b 13                	mov    (%ebx),%edx
 563:	e8 58 fe ff ff       	call   3c0 <printint>
        ap++;
 568:	89 d8                	mov    %ebx,%eax
      state = 0;
 56a:	31 d2                	xor    %edx,%edx
        ap++;
 56c:	83 c0 04             	add    $0x4,%eax
 56f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 572:	e9 44 ff ff ff       	jmp    4bb <printf+0x5b>
 577:	89 f6                	mov    %esi,%esi
 579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 580:	8b 45 d0             	mov    -0x30(%ebp),%eax
 583:	8b 10                	mov    (%eax),%edx
        ap++;
 585:	83 c0 04             	add    $0x4,%eax
 588:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 58b:	85 d2                	test   %edx,%edx
 58d:	0f 84 aa 00 00 00    	je     63d <printf+0x1dd>
        while(*s != 0){
 593:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 596:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 598:	84 c0                	test   %al,%al
 59a:	74 27                	je     5c3 <printf+0x163>
 59c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5a0:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 5a3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 5a8:	43                   	inc    %ebx
  write(fd, &c, 1);
 5a9:	89 44 24 08          	mov    %eax,0x8(%esp)
 5ad:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 5b0:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b4:	89 3c 24             	mov    %edi,(%esp)
 5b7:	e8 6c fd ff ff       	call   328 <write>
        while(*s != 0){
 5bc:	0f b6 03             	movzbl (%ebx),%eax
 5bf:	84 c0                	test   %al,%al
 5c1:	75 dd                	jne    5a0 <printf+0x140>
      state = 0;
 5c3:	31 d2                	xor    %edx,%edx
 5c5:	e9 f1 fe ff ff       	jmp    4bb <printf+0x5b>
 5ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 5d0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5d7:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5dc:	e9 7b ff ff ff       	jmp    55c <printf+0xfc>
 5e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 5e8:	b9 01 00 00 00       	mov    $0x1,%ecx
 5ed:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 5f0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 5f4:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f8:	89 3c 24             	mov    %edi,(%esp)
 5fb:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 5fe:	e8 25 fd ff ff       	call   328 <write>
      state = 0;
 603:	31 d2                	xor    %edx,%edx
 605:	e9 b1 fe ff ff       	jmp    4bb <printf+0x5b>
 60a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 610:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 613:	8b 03                	mov    (%ebx),%eax
        ap++;
 615:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 618:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 61b:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 61e:	b8 01 00 00 00       	mov    $0x1,%eax
 623:	89 44 24 08          	mov    %eax,0x8(%esp)
 627:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 62a:	89 44 24 04          	mov    %eax,0x4(%esp)
 62e:	e8 f5 fc ff ff       	call   328 <write>
      state = 0;
 633:	31 d2                	xor    %edx,%edx
        ap++;
 635:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 638:	e9 7e fe ff ff       	jmp    4bb <printf+0x5b>
          s = "(null)";
 63d:	bb 28 08 00 00       	mov    $0x828,%ebx
        while(*s != 0){
 642:	b0 28                	mov    $0x28,%al
 644:	e9 57 ff ff ff       	jmp    5a0 <printf+0x140>
 649:	66 90                	xchg   %ax,%ax
 64b:	66 90                	xchg   %ax,%ax
 64d:	66 90                	xchg   %ax,%ax
 64f:	90                   	nop

00000650 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 650:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 651:	a1 bc 0a 00 00       	mov    0xabc,%eax
{
 656:	89 e5                	mov    %esp,%ebp
 658:	57                   	push   %edi
 659:	56                   	push   %esi
 65a:	53                   	push   %ebx
 65b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 65e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 661:	eb 0d                	jmp    670 <free+0x20>
 663:	90                   	nop
 664:	90                   	nop
 665:	90                   	nop
 666:	90                   	nop
 667:	90                   	nop
 668:	90                   	nop
 669:	90                   	nop
 66a:	90                   	nop
 66b:	90                   	nop
 66c:	90                   	nop
 66d:	90                   	nop
 66e:	90                   	nop
 66f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 670:	39 c8                	cmp    %ecx,%eax
 672:	8b 10                	mov    (%eax),%edx
 674:	73 32                	jae    6a8 <free+0x58>
 676:	39 d1                	cmp    %edx,%ecx
 678:	72 04                	jb     67e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 67a:	39 d0                	cmp    %edx,%eax
 67c:	72 32                	jb     6b0 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 67e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 681:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 684:	39 fa                	cmp    %edi,%edx
 686:	74 30                	je     6b8 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 688:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 68b:	8b 50 04             	mov    0x4(%eax),%edx
 68e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 691:	39 f1                	cmp    %esi,%ecx
 693:	74 3c                	je     6d1 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 695:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 697:	5b                   	pop    %ebx
  freep = p;
 698:	a3 bc 0a 00 00       	mov    %eax,0xabc
}
 69d:	5e                   	pop    %esi
 69e:	5f                   	pop    %edi
 69f:	5d                   	pop    %ebp
 6a0:	c3                   	ret    
 6a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6a8:	39 d0                	cmp    %edx,%eax
 6aa:	72 04                	jb     6b0 <free+0x60>
 6ac:	39 d1                	cmp    %edx,%ecx
 6ae:	72 ce                	jb     67e <free+0x2e>
{
 6b0:	89 d0                	mov    %edx,%eax
 6b2:	eb bc                	jmp    670 <free+0x20>
 6b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 6b8:	8b 7a 04             	mov    0x4(%edx),%edi
 6bb:	01 fe                	add    %edi,%esi
 6bd:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6c0:	8b 10                	mov    (%eax),%edx
 6c2:	8b 12                	mov    (%edx),%edx
 6c4:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6c7:	8b 50 04             	mov    0x4(%eax),%edx
 6ca:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6cd:	39 f1                	cmp    %esi,%ecx
 6cf:	75 c4                	jne    695 <free+0x45>
    p->s.size += bp->s.size;
 6d1:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 6d4:	a3 bc 0a 00 00       	mov    %eax,0xabc
    p->s.size += bp->s.size;
 6d9:	01 ca                	add    %ecx,%edx
 6db:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6de:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6e1:	89 10                	mov    %edx,(%eax)
}
 6e3:	5b                   	pop    %ebx
 6e4:	5e                   	pop    %esi
 6e5:	5f                   	pop    %edi
 6e6:	5d                   	pop    %ebp
 6e7:	c3                   	ret    
 6e8:	90                   	nop
 6e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	57                   	push   %edi
 6f4:	56                   	push   %esi
 6f5:	53                   	push   %ebx
 6f6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6fc:	8b 15 bc 0a 00 00    	mov    0xabc,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 702:	8d 78 07             	lea    0x7(%eax),%edi
 705:	c1 ef 03             	shr    $0x3,%edi
 708:	47                   	inc    %edi
  if((prevp = freep) == 0){
 709:	85 d2                	test   %edx,%edx
 70b:	0f 84 8f 00 00 00    	je     7a0 <malloc+0xb0>
 711:	8b 02                	mov    (%edx),%eax
 713:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 716:	39 cf                	cmp    %ecx,%edi
 718:	76 66                	jbe    780 <malloc+0x90>
 71a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 720:	bb 00 10 00 00       	mov    $0x1000,%ebx
 725:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 728:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 72f:	eb 10                	jmp    741 <malloc+0x51>
 731:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 738:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 73a:	8b 48 04             	mov    0x4(%eax),%ecx
 73d:	39 f9                	cmp    %edi,%ecx
 73f:	73 3f                	jae    780 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 741:	39 05 bc 0a 00 00    	cmp    %eax,0xabc
 747:	89 c2                	mov    %eax,%edx
 749:	75 ed                	jne    738 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 74b:	89 34 24             	mov    %esi,(%esp)
 74e:	e8 3d fc ff ff       	call   390 <sbrk>
  if(p == (char*)-1)
 753:	83 f8 ff             	cmp    $0xffffffff,%eax
 756:	74 18                	je     770 <malloc+0x80>
  hp->s.size = nu;
 758:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 75b:	83 c0 08             	add    $0x8,%eax
 75e:	89 04 24             	mov    %eax,(%esp)
 761:	e8 ea fe ff ff       	call   650 <free>
  return freep;
 766:	8b 15 bc 0a 00 00    	mov    0xabc,%edx
      if((p = morecore(nunits)) == 0)
 76c:	85 d2                	test   %edx,%edx
 76e:	75 c8                	jne    738 <malloc+0x48>
        return 0;
  }
}
 770:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 773:	31 c0                	xor    %eax,%eax
}
 775:	5b                   	pop    %ebx
 776:	5e                   	pop    %esi
 777:	5f                   	pop    %edi
 778:	5d                   	pop    %ebp
 779:	c3                   	ret    
 77a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 780:	39 cf                	cmp    %ecx,%edi
 782:	74 4c                	je     7d0 <malloc+0xe0>
        p->s.size -= nunits;
 784:	29 f9                	sub    %edi,%ecx
 786:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 789:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 78c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 78f:	89 15 bc 0a 00 00    	mov    %edx,0xabc
}
 795:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 798:	83 c0 08             	add    $0x8,%eax
}
 79b:	5b                   	pop    %ebx
 79c:	5e                   	pop    %esi
 79d:	5f                   	pop    %edi
 79e:	5d                   	pop    %ebp
 79f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 7a0:	b8 c0 0a 00 00       	mov    $0xac0,%eax
 7a5:	ba c0 0a 00 00       	mov    $0xac0,%edx
    base.s.size = 0;
 7aa:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 7ac:	a3 bc 0a 00 00       	mov    %eax,0xabc
    base.s.size = 0;
 7b1:	b8 c0 0a 00 00       	mov    $0xac0,%eax
    base.s.ptr = freep = prevp = &base;
 7b6:	89 15 c0 0a 00 00    	mov    %edx,0xac0
    base.s.size = 0;
 7bc:	89 0d c4 0a 00 00    	mov    %ecx,0xac4
 7c2:	e9 53 ff ff ff       	jmp    71a <malloc+0x2a>
 7c7:	89 f6                	mov    %esi,%esi
 7c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 7d0:	8b 08                	mov    (%eax),%ecx
 7d2:	89 0a                	mov    %ecx,(%edx)
 7d4:	eb b9                	jmp    78f <malloc+0x9f>
