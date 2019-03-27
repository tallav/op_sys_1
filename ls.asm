
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  close(fd);
}

int
main(int argc, char *argv[])
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
  14:	7e 27                	jle    3d <main+0x3d>
  16:	8d 5a 04             	lea    0x4(%edx),%ebx
  19:	8d 34 82             	lea    (%edx,%eax,4),%esi
  1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
  20:	8b 03                	mov    (%ebx),%eax
  22:	83 c3 04             	add    $0x4,%ebx
  25:	89 04 24             	mov    %eax,(%esp)
  28:	e8 d3 00 00 00       	call   100 <ls>
  for(i=1; i<argc; i++)
  2d:	39 f3                	cmp    %esi,%ebx
  2f:	75 ef                	jne    20 <main+0x20>
  exit(0);
  31:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  38:	e8 6b 05 00 00       	call   5a8 <exit>
    ls(".");
  3d:	c7 04 24 d0 0a 00 00 	movl   $0xad0,(%esp)
  44:	e8 b7 00 00 00       	call   100 <ls>
    exit(0);
  49:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  50:	e8 53 05 00 00       	call   5a8 <exit>
  55:	66 90                	xchg   %ax,%ax
  57:	66 90                	xchg   %ax,%ax
  59:	66 90                	xchg   %ax,%ax
  5b:	66 90                	xchg   %ax,%ax
  5d:	66 90                	xchg   %ax,%ax
  5f:	90                   	nop

00000060 <fmtname>:
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	56                   	push   %esi
  64:	53                   	push   %ebx
  65:	83 ec 10             	sub    $0x10,%esp
  68:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  6b:	89 1c 24             	mov    %ebx,(%esp)
  6e:	e8 6d 03 00 00       	call   3e0 <strlen>
  73:	01 d8                	add    %ebx,%eax
  75:	73 0e                	jae    85 <fmtname+0x25>
  77:	eb 11                	jmp    8a <fmtname+0x2a>
  79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  80:	48                   	dec    %eax
  81:	39 c3                	cmp    %eax,%ebx
  83:	77 05                	ja     8a <fmtname+0x2a>
  85:	80 38 2f             	cmpb   $0x2f,(%eax)
  88:	75 f6                	jne    80 <fmtname+0x20>
  p++;
  8a:	8d 58 01             	lea    0x1(%eax),%ebx
  if(strlen(p) >= DIRSIZ)
  8d:	89 1c 24             	mov    %ebx,(%esp)
  90:	e8 4b 03 00 00       	call   3e0 <strlen>
  95:	83 f8 0d             	cmp    $0xd,%eax
  98:	77 54                	ja     ee <fmtname+0x8e>
  memmove(buf, p, strlen(p));
  9a:	89 1c 24             	mov    %ebx,(%esp)
  9d:	e8 3e 03 00 00       	call   3e0 <strlen>
  a2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  a6:	c7 04 24 e0 0d 00 00 	movl   $0xde0,(%esp)
  ad:	89 44 24 08          	mov    %eax,0x8(%esp)
  b1:	e8 ba 04 00 00       	call   570 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  b6:	89 1c 24             	mov    %ebx,(%esp)
  b9:	e8 22 03 00 00       	call   3e0 <strlen>
  be:	89 1c 24             	mov    %ebx,(%esp)
  return buf;
  c1:	bb e0 0d 00 00       	mov    $0xde0,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  c6:	89 c6                	mov    %eax,%esi
  c8:	e8 13 03 00 00       	call   3e0 <strlen>
  cd:	ba 0e 00 00 00       	mov    $0xe,%edx
  d2:	29 f2                	sub    %esi,%edx
  d4:	89 54 24 08          	mov    %edx,0x8(%esp)
  d8:	ba 20 00 00 00       	mov    $0x20,%edx
  dd:	89 54 24 04          	mov    %edx,0x4(%esp)
  e1:	05 e0 0d 00 00       	add    $0xde0,%eax
  e6:	89 04 24             	mov    %eax,(%esp)
  e9:	e8 22 03 00 00       	call   410 <memset>
}
  ee:	83 c4 10             	add    $0x10,%esp
  f1:	89 d8                	mov    %ebx,%eax
  f3:	5b                   	pop    %ebx
  f4:	5e                   	pop    %esi
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    
  f7:	89 f6                	mov    %esi,%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <ls>:
{
 100:	55                   	push   %ebp
  if((fd = open(path, 0)) < 0){
 101:	31 c0                	xor    %eax,%eax
{
 103:	89 e5                	mov    %esp,%ebp
 105:	81 ec 88 02 00 00    	sub    $0x288,%esp
 10b:	89 7d fc             	mov    %edi,-0x4(%ebp)
 10e:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((fd = open(path, 0)) < 0){
 111:	89 44 24 04          	mov    %eax,0x4(%esp)
{
 115:	89 5d f4             	mov    %ebx,-0xc(%ebp)
 118:	89 75 f8             	mov    %esi,-0x8(%ebp)
  if((fd = open(path, 0)) < 0){
 11b:	89 3c 24             	mov    %edi,(%esp)
 11e:	e8 c5 04 00 00       	call   5e8 <open>
 123:	85 c0                	test   %eax,%eax
 125:	78 49                	js     170 <ls+0x70>
  if(fstat(fd, &st) < 0){
 127:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
 12d:	89 c3                	mov    %eax,%ebx
 12f:	89 74 24 04          	mov    %esi,0x4(%esp)
 133:	89 04 24             	mov    %eax,(%esp)
 136:	e8 c5 04 00 00       	call   600 <fstat>
 13b:	85 c0                	test   %eax,%eax
 13d:	0f 88 dd 00 00 00    	js     220 <ls+0x120>
  switch(st.type){
 143:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
 14a:	83 f8 01             	cmp    $0x1,%eax
 14d:	0f 84 9d 00 00 00    	je     1f0 <ls+0xf0>
 153:	83 f8 02             	cmp    $0x2,%eax
 156:	74 48                	je     1a0 <ls+0xa0>
  close(fd);
 158:	89 1c 24             	mov    %ebx,(%esp)
 15b:	e8 70 04 00 00       	call   5d0 <close>
}
 160:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 163:	8b 75 f8             	mov    -0x8(%ebp),%esi
 166:	8b 7d fc             	mov    -0x4(%ebp),%edi
 169:	89 ec                	mov    %ebp,%esp
 16b:	5d                   	pop    %ebp
 16c:	c3                   	ret    
 16d:	8d 76 00             	lea    0x0(%esi),%esi
    printf(2, "ls: cannot open %s\n", path);
 170:	89 7c 24 08          	mov    %edi,0x8(%esp)
 174:	bf 88 0a 00 00       	mov    $0xa88,%edi
 179:	89 7c 24 04          	mov    %edi,0x4(%esp)
 17d:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 184:	e8 87 05 00 00       	call   710 <printf>
}
 189:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 18c:	8b 75 f8             	mov    -0x8(%ebp),%esi
 18f:	8b 7d fc             	mov    -0x4(%ebp),%edi
 192:	89 ec                	mov    %ebp,%esp
 194:	5d                   	pop    %ebp
 195:	c3                   	ret    
 196:	8d 76 00             	lea    0x0(%esi),%esi
 199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 1a0:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 1a6:	89 3c 24             	mov    %edi,(%esp)
 1a9:	8b b5 dc fd ff ff    	mov    -0x224(%ebp),%esi
 1af:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 1b5:	e8 a6 fe ff ff       	call   60 <fmtname>
 1ba:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 1c0:	b9 b0 0a 00 00       	mov    $0xab0,%ecx
 1c5:	89 74 24 10          	mov    %esi,0x10(%esp)
 1c9:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 1cd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1d4:	89 54 24 14          	mov    %edx,0x14(%esp)
 1d8:	ba 02 00 00 00       	mov    $0x2,%edx
 1dd:	89 54 24 0c          	mov    %edx,0xc(%esp)
 1e1:	89 44 24 08          	mov    %eax,0x8(%esp)
 1e5:	e8 26 05 00 00       	call   710 <printf>
    break;
 1ea:	e9 69 ff ff ff       	jmp    158 <ls+0x58>
 1ef:	90                   	nop
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1f0:	89 3c 24             	mov    %edi,(%esp)
 1f3:	e8 e8 01 00 00       	call   3e0 <strlen>
 1f8:	83 c0 10             	add    $0x10,%eax
 1fb:	3d 00 02 00 00       	cmp    $0x200,%eax
 200:	76 4e                	jbe    250 <ls+0x150>
      printf(1, "ls: path too long\n");
 202:	b8 bd 0a 00 00       	mov    $0xabd,%eax
 207:	89 44 24 04          	mov    %eax,0x4(%esp)
 20b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 212:	e8 f9 04 00 00       	call   710 <printf>
      break;
 217:	e9 3c ff ff ff       	jmp    158 <ls+0x58>
 21c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "ls: cannot stat %s\n", path);
 220:	be 9c 0a 00 00       	mov    $0xa9c,%esi
 225:	89 7c 24 08          	mov    %edi,0x8(%esp)
 229:	89 74 24 04          	mov    %esi,0x4(%esp)
 22d:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 234:	e8 d7 04 00 00       	call   710 <printf>
    close(fd);
 239:	89 1c 24             	mov    %ebx,(%esp)
 23c:	e8 8f 03 00 00       	call   5d0 <close>
}
 241:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 244:	8b 75 f8             	mov    -0x8(%ebp),%esi
 247:	8b 7d fc             	mov    -0x4(%ebp),%edi
 24a:	89 ec                	mov    %ebp,%esp
 24c:	5d                   	pop    %ebp
 24d:	c3                   	ret    
 24e:	66 90                	xchg   %ax,%ax
    strcpy(buf, path);
 250:	89 7c 24 04          	mov    %edi,0x4(%esp)
 254:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
 25a:	89 3c 24             	mov    %edi,(%esp)
 25d:	e8 1e 01 00 00       	call   380 <strcpy>
    p = buf+strlen(buf);
 262:	89 3c 24             	mov    %edi,(%esp)
 265:	e8 76 01 00 00       	call   3e0 <strlen>
 26a:	01 f8                	add    %edi,%eax
    *p++ = '/';
 26c:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 26f:	89 85 a8 fd ff ff    	mov    %eax,-0x258(%ebp)
    *p++ = '/';
 275:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 27b:	c6 00 2f             	movb   $0x2f,(%eax)
 27e:	66 90                	xchg   %ax,%ax
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 280:	b8 10 00 00 00       	mov    $0x10,%eax
 285:	89 44 24 08          	mov    %eax,0x8(%esp)
 289:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 28f:	89 44 24 04          	mov    %eax,0x4(%esp)
 293:	89 1c 24             	mov    %ebx,(%esp)
 296:	e8 25 03 00 00       	call   5c0 <read>
 29b:	83 f8 10             	cmp    $0x10,%eax
 29e:	0f 85 b4 fe ff ff    	jne    158 <ls+0x58>
      if(de.inum == 0)
 2a4:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
 2ab:	00 
 2ac:	74 d2                	je     280 <ls+0x180>
      memmove(p, de.name, DIRSIZ);
 2ae:	b8 0e 00 00 00       	mov    $0xe,%eax
 2b3:	89 44 24 08          	mov    %eax,0x8(%esp)
 2b7:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
 2bd:	89 44 24 04          	mov    %eax,0x4(%esp)
 2c1:	8b 85 a4 fd ff ff    	mov    -0x25c(%ebp),%eax
 2c7:	89 04 24             	mov    %eax,(%esp)
 2ca:	e8 a1 02 00 00       	call   570 <memmove>
      p[DIRSIZ] = 0;
 2cf:	8b 85 a8 fd ff ff    	mov    -0x258(%ebp),%eax
 2d5:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 2d9:	89 74 24 04          	mov    %esi,0x4(%esp)
 2dd:	89 3c 24             	mov    %edi,(%esp)
 2e0:	e8 eb 01 00 00       	call   4d0 <stat>
 2e5:	85 c0                	test   %eax,%eax
 2e7:	78 6f                	js     358 <ls+0x258>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 2e9:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 2ef:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
 2f5:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
 2fc:	89 3c 24             	mov    %edi,(%esp)
 2ff:	89 8d ac fd ff ff    	mov    %ecx,-0x254(%ebp)
 305:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
 30b:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 311:	e8 4a fd ff ff       	call   60 <fmtname>
 316:	8b 8d ac fd ff ff    	mov    -0x254(%ebp),%ecx
 31c:	8b 95 b0 fd ff ff    	mov    -0x250(%ebp),%edx
 322:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 329:	89 4c 24 14          	mov    %ecx,0x14(%esp)
 32d:	8b 8d b4 fd ff ff    	mov    -0x24c(%ebp),%ecx
 333:	89 54 24 10          	mov    %edx,0x10(%esp)
 337:	ba b0 0a 00 00       	mov    $0xab0,%edx
 33c:	89 44 24 08          	mov    %eax,0x8(%esp)
 340:	89 54 24 04          	mov    %edx,0x4(%esp)
 344:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
 348:	e8 c3 03 00 00       	call   710 <printf>
 34d:	e9 2e ff ff ff       	jmp    280 <ls+0x180>
 352:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 358:	b9 9c 0a 00 00       	mov    $0xa9c,%ecx
 35d:	89 7c 24 08          	mov    %edi,0x8(%esp)
 361:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 365:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 36c:	e8 9f 03 00 00       	call   710 <printf>
        continue;
 371:	e9 0a ff ff ff       	jmp    280 <ls+0x180>
 376:	66 90                	xchg   %ax,%ax
 378:	66 90                	xchg   %ax,%ax
 37a:	66 90                	xchg   %ax,%ax
 37c:	66 90                	xchg   %ax,%ax
 37e:	66 90                	xchg   %ax,%ax

00000380 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	8b 45 08             	mov    0x8(%ebp),%eax
 386:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 389:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 38a:	89 c2                	mov    %eax,%edx
 38c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 390:	41                   	inc    %ecx
 391:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 395:	42                   	inc    %edx
 396:	84 db                	test   %bl,%bl
 398:	88 5a ff             	mov    %bl,-0x1(%edx)
 39b:	75 f3                	jne    390 <strcpy+0x10>
    ;
  return os;
}
 39d:	5b                   	pop    %ebx
 39e:	5d                   	pop    %ebp
 39f:	c3                   	ret    

000003a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3a6:	53                   	push   %ebx
 3a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 3aa:	0f b6 01             	movzbl (%ecx),%eax
 3ad:	0f b6 13             	movzbl (%ebx),%edx
 3b0:	84 c0                	test   %al,%al
 3b2:	75 18                	jne    3cc <strcmp+0x2c>
 3b4:	eb 22                	jmp    3d8 <strcmp+0x38>
 3b6:	8d 76 00             	lea    0x0(%esi),%esi
 3b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 3c0:	41                   	inc    %ecx
  while(*p && *p == *q)
 3c1:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 3c4:	43                   	inc    %ebx
 3c5:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
 3c8:	84 c0                	test   %al,%al
 3ca:	74 0c                	je     3d8 <strcmp+0x38>
 3cc:	38 d0                	cmp    %dl,%al
 3ce:	74 f0                	je     3c0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
 3d0:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 3d1:	29 d0                	sub    %edx,%eax
}
 3d3:	5d                   	pop    %ebp
 3d4:	c3                   	ret    
 3d5:	8d 76 00             	lea    0x0(%esi),%esi
 3d8:	5b                   	pop    %ebx
 3d9:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 3db:	29 d0                	sub    %edx,%eax
}
 3dd:	5d                   	pop    %ebp
 3de:	c3                   	ret    
 3df:	90                   	nop

000003e0 <strlen>:

uint
strlen(const char *s)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 3e6:	80 39 00             	cmpb   $0x0,(%ecx)
 3e9:	74 15                	je     400 <strlen+0x20>
 3eb:	31 d2                	xor    %edx,%edx
 3ed:	8d 76 00             	lea    0x0(%esi),%esi
 3f0:	42                   	inc    %edx
 3f1:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 3f5:	89 d0                	mov    %edx,%eax
 3f7:	75 f7                	jne    3f0 <strlen+0x10>
    ;
  return n;
}
 3f9:	5d                   	pop    %ebp
 3fa:	c3                   	ret    
 3fb:	90                   	nop
 3fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
 400:	31 c0                	xor    %eax,%eax
}
 402:	5d                   	pop    %ebp
 403:	c3                   	ret    
 404:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 40a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000410 <memset>:

void*
memset(void *dst, int c, uint n)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	8b 55 08             	mov    0x8(%ebp),%edx
 416:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 417:	8b 4d 10             	mov    0x10(%ebp),%ecx
 41a:	8b 45 0c             	mov    0xc(%ebp),%eax
 41d:	89 d7                	mov    %edx,%edi
 41f:	fc                   	cld    
 420:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 422:	5f                   	pop    %edi
 423:	89 d0                	mov    %edx,%eax
 425:	5d                   	pop    %ebp
 426:	c3                   	ret    
 427:	89 f6                	mov    %esi,%esi
 429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000430 <strchr>:

char*
strchr(const char *s, char c)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	8b 45 08             	mov    0x8(%ebp),%eax
 436:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 43a:	0f b6 10             	movzbl (%eax),%edx
 43d:	84 d2                	test   %dl,%dl
 43f:	74 1b                	je     45c <strchr+0x2c>
    if(*s == c)
 441:	38 d1                	cmp    %dl,%cl
 443:	75 0f                	jne    454 <strchr+0x24>
 445:	eb 17                	jmp    45e <strchr+0x2e>
 447:	89 f6                	mov    %esi,%esi
 449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 450:	38 ca                	cmp    %cl,%dl
 452:	74 0a                	je     45e <strchr+0x2e>
  for(; *s; s++)
 454:	40                   	inc    %eax
 455:	0f b6 10             	movzbl (%eax),%edx
 458:	84 d2                	test   %dl,%dl
 45a:	75 f4                	jne    450 <strchr+0x20>
      return (char*)s;
  return 0;
 45c:	31 c0                	xor    %eax,%eax
}
 45e:	5d                   	pop    %ebp
 45f:	c3                   	ret    

00000460 <gets>:

char*
gets(char *buf, int max)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 465:	31 f6                	xor    %esi,%esi
{
 467:	53                   	push   %ebx
 468:	83 ec 3c             	sub    $0x3c,%esp
 46b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
 46e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 471:	eb 32                	jmp    4a5 <gets+0x45>
 473:	90                   	nop
 474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 478:	ba 01 00 00 00       	mov    $0x1,%edx
 47d:	89 54 24 08          	mov    %edx,0x8(%esp)
 481:	89 7c 24 04          	mov    %edi,0x4(%esp)
 485:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 48c:	e8 2f 01 00 00       	call   5c0 <read>
    if(cc < 1)
 491:	85 c0                	test   %eax,%eax
 493:	7e 19                	jle    4ae <gets+0x4e>
      break;
    buf[i++] = c;
 495:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 499:	43                   	inc    %ebx
 49a:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
 49d:	3c 0a                	cmp    $0xa,%al
 49f:	74 1f                	je     4c0 <gets+0x60>
 4a1:	3c 0d                	cmp    $0xd,%al
 4a3:	74 1b                	je     4c0 <gets+0x60>
  for(i=0; i+1 < max; ){
 4a5:	46                   	inc    %esi
 4a6:	3b 75 0c             	cmp    0xc(%ebp),%esi
 4a9:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 4ac:	7c ca                	jl     478 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 4ae:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4b1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 4b4:	8b 45 08             	mov    0x8(%ebp),%eax
 4b7:	83 c4 3c             	add    $0x3c,%esp
 4ba:	5b                   	pop    %ebx
 4bb:	5e                   	pop    %esi
 4bc:	5f                   	pop    %edi
 4bd:	5d                   	pop    %ebp
 4be:	c3                   	ret    
 4bf:	90                   	nop
 4c0:	8b 45 08             	mov    0x8(%ebp),%eax
 4c3:	01 c6                	add    %eax,%esi
 4c5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 4c8:	eb e4                	jmp    4ae <gets+0x4e>
 4ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000004d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 4d0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4d1:	31 c0                	xor    %eax,%eax
{
 4d3:	89 e5                	mov    %esp,%ebp
 4d5:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 4d8:	89 44 24 04          	mov    %eax,0x4(%esp)
 4dc:	8b 45 08             	mov    0x8(%ebp),%eax
{
 4df:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 4e2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 4e5:	89 04 24             	mov    %eax,(%esp)
 4e8:	e8 fb 00 00 00       	call   5e8 <open>
  if(fd < 0)
 4ed:	85 c0                	test   %eax,%eax
 4ef:	78 2f                	js     520 <stat+0x50>
 4f1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 4f3:	8b 45 0c             	mov    0xc(%ebp),%eax
 4f6:	89 1c 24             	mov    %ebx,(%esp)
 4f9:	89 44 24 04          	mov    %eax,0x4(%esp)
 4fd:	e8 fe 00 00 00       	call   600 <fstat>
  close(fd);
 502:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 505:	89 c6                	mov    %eax,%esi
  close(fd);
 507:	e8 c4 00 00 00       	call   5d0 <close>
  return r;
}
 50c:	89 f0                	mov    %esi,%eax
 50e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 511:	8b 75 fc             	mov    -0x4(%ebp),%esi
 514:	89 ec                	mov    %ebp,%esp
 516:	5d                   	pop    %ebp
 517:	c3                   	ret    
 518:	90                   	nop
 519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 520:	be ff ff ff ff       	mov    $0xffffffff,%esi
 525:	eb e5                	jmp    50c <stat+0x3c>
 527:	89 f6                	mov    %esi,%esi
 529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000530 <atoi>:

int
atoi(const char *s)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	8b 4d 08             	mov    0x8(%ebp),%ecx
 536:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 537:	0f be 11             	movsbl (%ecx),%edx
 53a:	88 d0                	mov    %dl,%al
 53c:	2c 30                	sub    $0x30,%al
 53e:	3c 09                	cmp    $0x9,%al
  n = 0;
 540:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 545:	77 1e                	ja     565 <atoi+0x35>
 547:	89 f6                	mov    %esi,%esi
 549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 550:	41                   	inc    %ecx
 551:	8d 04 80             	lea    (%eax,%eax,4),%eax
 554:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 558:	0f be 11             	movsbl (%ecx),%edx
 55b:	88 d3                	mov    %dl,%bl
 55d:	80 eb 30             	sub    $0x30,%bl
 560:	80 fb 09             	cmp    $0x9,%bl
 563:	76 eb                	jbe    550 <atoi+0x20>
  return n;
}
 565:	5b                   	pop    %ebx
 566:	5d                   	pop    %ebp
 567:	c3                   	ret    
 568:	90                   	nop
 569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000570 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 570:	55                   	push   %ebp
 571:	89 e5                	mov    %esp,%ebp
 573:	56                   	push   %esi
 574:	8b 45 08             	mov    0x8(%ebp),%eax
 577:	53                   	push   %ebx
 578:	8b 5d 10             	mov    0x10(%ebp),%ebx
 57b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 57e:	85 db                	test   %ebx,%ebx
 580:	7e 1a                	jle    59c <memmove+0x2c>
 582:	31 d2                	xor    %edx,%edx
 584:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 58a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 590:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 594:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 597:	42                   	inc    %edx
  while(n-- > 0)
 598:	39 d3                	cmp    %edx,%ebx
 59a:	75 f4                	jne    590 <memmove+0x20>
  return vdst;
}
 59c:	5b                   	pop    %ebx
 59d:	5e                   	pop    %esi
 59e:	5d                   	pop    %ebp
 59f:	c3                   	ret    

000005a0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5a0:	b8 01 00 00 00       	mov    $0x1,%eax
 5a5:	cd 40                	int    $0x40
 5a7:	c3                   	ret    

000005a8 <exit>:
SYSCALL(exit)
 5a8:	b8 02 00 00 00       	mov    $0x2,%eax
 5ad:	cd 40                	int    $0x40
 5af:	c3                   	ret    

000005b0 <wait>:
SYSCALL(wait)
 5b0:	b8 03 00 00 00       	mov    $0x3,%eax
 5b5:	cd 40                	int    $0x40
 5b7:	c3                   	ret    

000005b8 <pipe>:
SYSCALL(pipe)
 5b8:	b8 04 00 00 00       	mov    $0x4,%eax
 5bd:	cd 40                	int    $0x40
 5bf:	c3                   	ret    

000005c0 <read>:
SYSCALL(read)
 5c0:	b8 05 00 00 00       	mov    $0x5,%eax
 5c5:	cd 40                	int    $0x40
 5c7:	c3                   	ret    

000005c8 <write>:
SYSCALL(write)
 5c8:	b8 10 00 00 00       	mov    $0x10,%eax
 5cd:	cd 40                	int    $0x40
 5cf:	c3                   	ret    

000005d0 <close>:
SYSCALL(close)
 5d0:	b8 15 00 00 00       	mov    $0x15,%eax
 5d5:	cd 40                	int    $0x40
 5d7:	c3                   	ret    

000005d8 <kill>:
SYSCALL(kill)
 5d8:	b8 06 00 00 00       	mov    $0x6,%eax
 5dd:	cd 40                	int    $0x40
 5df:	c3                   	ret    

000005e0 <exec>:
SYSCALL(exec)
 5e0:	b8 07 00 00 00       	mov    $0x7,%eax
 5e5:	cd 40                	int    $0x40
 5e7:	c3                   	ret    

000005e8 <open>:
SYSCALL(open)
 5e8:	b8 0f 00 00 00       	mov    $0xf,%eax
 5ed:	cd 40                	int    $0x40
 5ef:	c3                   	ret    

000005f0 <mknod>:
SYSCALL(mknod)
 5f0:	b8 11 00 00 00       	mov    $0x11,%eax
 5f5:	cd 40                	int    $0x40
 5f7:	c3                   	ret    

000005f8 <unlink>:
SYSCALL(unlink)
 5f8:	b8 12 00 00 00       	mov    $0x12,%eax
 5fd:	cd 40                	int    $0x40
 5ff:	c3                   	ret    

00000600 <fstat>:
SYSCALL(fstat)
 600:	b8 08 00 00 00       	mov    $0x8,%eax
 605:	cd 40                	int    $0x40
 607:	c3                   	ret    

00000608 <link>:
SYSCALL(link)
 608:	b8 13 00 00 00       	mov    $0x13,%eax
 60d:	cd 40                	int    $0x40
 60f:	c3                   	ret    

00000610 <mkdir>:
SYSCALL(mkdir)
 610:	b8 14 00 00 00       	mov    $0x14,%eax
 615:	cd 40                	int    $0x40
 617:	c3                   	ret    

00000618 <chdir>:
SYSCALL(chdir)
 618:	b8 09 00 00 00       	mov    $0x9,%eax
 61d:	cd 40                	int    $0x40
 61f:	c3                   	ret    

00000620 <dup>:
SYSCALL(dup)
 620:	b8 0a 00 00 00       	mov    $0xa,%eax
 625:	cd 40                	int    $0x40
 627:	c3                   	ret    

00000628 <getpid>:
SYSCALL(getpid)
 628:	b8 0b 00 00 00       	mov    $0xb,%eax
 62d:	cd 40                	int    $0x40
 62f:	c3                   	ret    

00000630 <sbrk>:
SYSCALL(sbrk)
 630:	b8 0c 00 00 00       	mov    $0xc,%eax
 635:	cd 40                	int    $0x40
 637:	c3                   	ret    

00000638 <sleep>:
SYSCALL(sleep)
 638:	b8 0d 00 00 00       	mov    $0xd,%eax
 63d:	cd 40                	int    $0x40
 63f:	c3                   	ret    

00000640 <uptime>:
SYSCALL(uptime)
 640:	b8 0e 00 00 00       	mov    $0xe,%eax
 645:	cd 40                	int    $0x40
 647:	c3                   	ret    

00000648 <detach>:
SYSCALL(detach)
 648:	b8 16 00 00 00       	mov    $0x16,%eax
 64d:	cd 40                	int    $0x40
 64f:	c3                   	ret    

00000650 <priority>:
SYSCALL(priority)
 650:	b8 17 00 00 00       	mov    $0x17,%eax
 655:	cd 40                	int    $0x40
 657:	c3                   	ret    

00000658 <policy>:
SYSCALL(policy)
 658:	b8 18 00 00 00       	mov    $0x18,%eax
 65d:	cd 40                	int    $0x40
 65f:	c3                   	ret    

00000660 <wait_stat>:
SYSCALL(wait_stat)
 660:	b8 19 00 00 00       	mov    $0x19,%eax
 665:	cd 40                	int    $0x40
 667:	c3                   	ret    
 668:	66 90                	xchg   %ax,%ax
 66a:	66 90                	xchg   %ax,%ax
 66c:	66 90                	xchg   %ax,%ax
 66e:	66 90                	xchg   %ax,%ax

00000670 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	57                   	push   %edi
 674:	56                   	push   %esi
 675:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 676:	89 d3                	mov    %edx,%ebx
 678:	c1 eb 1f             	shr    $0x1f,%ebx
{
 67b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 67e:	84 db                	test   %bl,%bl
{
 680:	89 45 c0             	mov    %eax,-0x40(%ebp)
 683:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 685:	74 79                	je     700 <printint+0x90>
 687:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 68b:	74 73                	je     700 <printint+0x90>
    neg = 1;
    x = -xx;
 68d:	f7 d8                	neg    %eax
    neg = 1;
 68f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 696:	31 f6                	xor    %esi,%esi
 698:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 69b:	eb 05                	jmp    6a2 <printint+0x32>
 69d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 6a0:	89 fe                	mov    %edi,%esi
 6a2:	31 d2                	xor    %edx,%edx
 6a4:	f7 f1                	div    %ecx
 6a6:	8d 7e 01             	lea    0x1(%esi),%edi
 6a9:	0f b6 92 dc 0a 00 00 	movzbl 0xadc(%edx),%edx
  }while((x /= base) != 0);
 6b0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 6b2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 6b5:	75 e9                	jne    6a0 <printint+0x30>
  if(neg)
 6b7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 6ba:	85 d2                	test   %edx,%edx
 6bc:	74 08                	je     6c6 <printint+0x56>
    buf[i++] = '-';
 6be:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 6c3:	8d 7e 02             	lea    0x2(%esi),%edi
 6c6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 6ca:	8b 7d c0             	mov    -0x40(%ebp),%edi
 6cd:	8d 76 00             	lea    0x0(%esi),%esi
 6d0:	0f b6 06             	movzbl (%esi),%eax
 6d3:	4e                   	dec    %esi
  write(fd, &c, 1);
 6d4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 6d8:	89 3c 24             	mov    %edi,(%esp)
 6db:	88 45 d7             	mov    %al,-0x29(%ebp)
 6de:	b8 01 00 00 00       	mov    $0x1,%eax
 6e3:	89 44 24 08          	mov    %eax,0x8(%esp)
 6e7:	e8 dc fe ff ff       	call   5c8 <write>

  while(--i >= 0)
 6ec:	39 de                	cmp    %ebx,%esi
 6ee:	75 e0                	jne    6d0 <printint+0x60>
    putc(fd, buf[i]);
}
 6f0:	83 c4 4c             	add    $0x4c,%esp
 6f3:	5b                   	pop    %ebx
 6f4:	5e                   	pop    %esi
 6f5:	5f                   	pop    %edi
 6f6:	5d                   	pop    %ebp
 6f7:	c3                   	ret    
 6f8:	90                   	nop
 6f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 700:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 707:	eb 8d                	jmp    696 <printint+0x26>
 709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000710 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 710:	55                   	push   %ebp
 711:	89 e5                	mov    %esp,%ebp
 713:	57                   	push   %edi
 714:	56                   	push   %esi
 715:	53                   	push   %ebx
 716:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 719:	8b 75 0c             	mov    0xc(%ebp),%esi
 71c:	0f b6 1e             	movzbl (%esi),%ebx
 71f:	84 db                	test   %bl,%bl
 721:	0f 84 d1 00 00 00    	je     7f8 <printf+0xe8>
  state = 0;
 727:	31 ff                	xor    %edi,%edi
 729:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 72a:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 72d:	89 fa                	mov    %edi,%edx
 72f:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 732:	89 45 d0             	mov    %eax,-0x30(%ebp)
 735:	eb 41                	jmp    778 <printf+0x68>
 737:	89 f6                	mov    %esi,%esi
 739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 740:	83 f8 25             	cmp    $0x25,%eax
 743:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 746:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 74b:	74 1e                	je     76b <printf+0x5b>
  write(fd, &c, 1);
 74d:	b8 01 00 00 00       	mov    $0x1,%eax
 752:	89 44 24 08          	mov    %eax,0x8(%esp)
 756:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 759:	89 44 24 04          	mov    %eax,0x4(%esp)
 75d:	89 3c 24             	mov    %edi,(%esp)
 760:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 763:	e8 60 fe ff ff       	call   5c8 <write>
 768:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 76b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 76c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 770:	84 db                	test   %bl,%bl
 772:	0f 84 80 00 00 00    	je     7f8 <printf+0xe8>
    if(state == 0){
 778:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 77a:	0f be cb             	movsbl %bl,%ecx
 77d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 780:	74 be                	je     740 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 782:	83 fa 25             	cmp    $0x25,%edx
 785:	75 e4                	jne    76b <printf+0x5b>
      if(c == 'd'){
 787:	83 f8 64             	cmp    $0x64,%eax
 78a:	0f 84 f0 00 00 00    	je     880 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 790:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 796:	83 f9 70             	cmp    $0x70,%ecx
 799:	74 65                	je     800 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 79b:	83 f8 73             	cmp    $0x73,%eax
 79e:	0f 84 8c 00 00 00    	je     830 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7a4:	83 f8 63             	cmp    $0x63,%eax
 7a7:	0f 84 13 01 00 00    	je     8c0 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 7ad:	83 f8 25             	cmp    $0x25,%eax
 7b0:	0f 84 e2 00 00 00    	je     898 <printf+0x188>
  write(fd, &c, 1);
 7b6:	b8 01 00 00 00       	mov    $0x1,%eax
 7bb:	46                   	inc    %esi
 7bc:	89 44 24 08          	mov    %eax,0x8(%esp)
 7c0:	8d 45 e7             	lea    -0x19(%ebp),%eax
 7c3:	89 44 24 04          	mov    %eax,0x4(%esp)
 7c7:	89 3c 24             	mov    %edi,(%esp)
 7ca:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 7ce:	e8 f5 fd ff ff       	call   5c8 <write>
 7d3:	ba 01 00 00 00       	mov    $0x1,%edx
 7d8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 7db:	89 54 24 08          	mov    %edx,0x8(%esp)
 7df:	89 44 24 04          	mov    %eax,0x4(%esp)
 7e3:	89 3c 24             	mov    %edi,(%esp)
 7e6:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 7e9:	e8 da fd ff ff       	call   5c8 <write>
  for(i = 0; fmt[i]; i++){
 7ee:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7f2:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 7f4:	84 db                	test   %bl,%bl
 7f6:	75 80                	jne    778 <printf+0x68>
    }
  }
}
 7f8:	83 c4 3c             	add    $0x3c,%esp
 7fb:	5b                   	pop    %ebx
 7fc:	5e                   	pop    %esi
 7fd:	5f                   	pop    %edi
 7fe:	5d                   	pop    %ebp
 7ff:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 800:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 807:	b9 10 00 00 00       	mov    $0x10,%ecx
 80c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 80f:	89 f8                	mov    %edi,%eax
 811:	8b 13                	mov    (%ebx),%edx
 813:	e8 58 fe ff ff       	call   670 <printint>
        ap++;
 818:	89 d8                	mov    %ebx,%eax
      state = 0;
 81a:	31 d2                	xor    %edx,%edx
        ap++;
 81c:	83 c0 04             	add    $0x4,%eax
 81f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 822:	e9 44 ff ff ff       	jmp    76b <printf+0x5b>
 827:	89 f6                	mov    %esi,%esi
 829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 830:	8b 45 d0             	mov    -0x30(%ebp),%eax
 833:	8b 10                	mov    (%eax),%edx
        ap++;
 835:	83 c0 04             	add    $0x4,%eax
 838:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 83b:	85 d2                	test   %edx,%edx
 83d:	0f 84 aa 00 00 00    	je     8ed <printf+0x1dd>
        while(*s != 0){
 843:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 846:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 848:	84 c0                	test   %al,%al
 84a:	74 27                	je     873 <printf+0x163>
 84c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 850:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 853:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 858:	43                   	inc    %ebx
  write(fd, &c, 1);
 859:	89 44 24 08          	mov    %eax,0x8(%esp)
 85d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 860:	89 44 24 04          	mov    %eax,0x4(%esp)
 864:	89 3c 24             	mov    %edi,(%esp)
 867:	e8 5c fd ff ff       	call   5c8 <write>
        while(*s != 0){
 86c:	0f b6 03             	movzbl (%ebx),%eax
 86f:	84 c0                	test   %al,%al
 871:	75 dd                	jne    850 <printf+0x140>
      state = 0;
 873:	31 d2                	xor    %edx,%edx
 875:	e9 f1 fe ff ff       	jmp    76b <printf+0x5b>
 87a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 880:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 887:	b9 0a 00 00 00       	mov    $0xa,%ecx
 88c:	e9 7b ff ff ff       	jmp    80c <printf+0xfc>
 891:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 898:	b9 01 00 00 00       	mov    $0x1,%ecx
 89d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 8a0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 8a4:	89 44 24 04          	mov    %eax,0x4(%esp)
 8a8:	89 3c 24             	mov    %edi,(%esp)
 8ab:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 8ae:	e8 15 fd ff ff       	call   5c8 <write>
      state = 0;
 8b3:	31 d2                	xor    %edx,%edx
 8b5:	e9 b1 fe ff ff       	jmp    76b <printf+0x5b>
 8ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 8c0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 8c3:	8b 03                	mov    (%ebx),%eax
        ap++;
 8c5:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 8c8:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 8cb:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 8ce:	b8 01 00 00 00       	mov    $0x1,%eax
 8d3:	89 44 24 08          	mov    %eax,0x8(%esp)
 8d7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 8da:	89 44 24 04          	mov    %eax,0x4(%esp)
 8de:	e8 e5 fc ff ff       	call   5c8 <write>
      state = 0;
 8e3:	31 d2                	xor    %edx,%edx
        ap++;
 8e5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 8e8:	e9 7e fe ff ff       	jmp    76b <printf+0x5b>
          s = "(null)";
 8ed:	bb d2 0a 00 00       	mov    $0xad2,%ebx
        while(*s != 0){
 8f2:	b0 28                	mov    $0x28,%al
 8f4:	e9 57 ff ff ff       	jmp    850 <printf+0x140>
 8f9:	66 90                	xchg   %ax,%ax
 8fb:	66 90                	xchg   %ax,%ax
 8fd:	66 90                	xchg   %ax,%ax
 8ff:	90                   	nop

00000900 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 900:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 901:	a1 f0 0d 00 00       	mov    0xdf0,%eax
{
 906:	89 e5                	mov    %esp,%ebp
 908:	57                   	push   %edi
 909:	56                   	push   %esi
 90a:	53                   	push   %ebx
 90b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 90e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 911:	eb 0d                	jmp    920 <free+0x20>
 913:	90                   	nop
 914:	90                   	nop
 915:	90                   	nop
 916:	90                   	nop
 917:	90                   	nop
 918:	90                   	nop
 919:	90                   	nop
 91a:	90                   	nop
 91b:	90                   	nop
 91c:	90                   	nop
 91d:	90                   	nop
 91e:	90                   	nop
 91f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 920:	39 c8                	cmp    %ecx,%eax
 922:	8b 10                	mov    (%eax),%edx
 924:	73 32                	jae    958 <free+0x58>
 926:	39 d1                	cmp    %edx,%ecx
 928:	72 04                	jb     92e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 92a:	39 d0                	cmp    %edx,%eax
 92c:	72 32                	jb     960 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 92e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 931:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 934:	39 fa                	cmp    %edi,%edx
 936:	74 30                	je     968 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 938:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 93b:	8b 50 04             	mov    0x4(%eax),%edx
 93e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 941:	39 f1                	cmp    %esi,%ecx
 943:	74 3c                	je     981 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 945:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 947:	5b                   	pop    %ebx
  freep = p;
 948:	a3 f0 0d 00 00       	mov    %eax,0xdf0
}
 94d:	5e                   	pop    %esi
 94e:	5f                   	pop    %edi
 94f:	5d                   	pop    %ebp
 950:	c3                   	ret    
 951:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 958:	39 d0                	cmp    %edx,%eax
 95a:	72 04                	jb     960 <free+0x60>
 95c:	39 d1                	cmp    %edx,%ecx
 95e:	72 ce                	jb     92e <free+0x2e>
{
 960:	89 d0                	mov    %edx,%eax
 962:	eb bc                	jmp    920 <free+0x20>
 964:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 968:	8b 7a 04             	mov    0x4(%edx),%edi
 96b:	01 fe                	add    %edi,%esi
 96d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 970:	8b 10                	mov    (%eax),%edx
 972:	8b 12                	mov    (%edx),%edx
 974:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 977:	8b 50 04             	mov    0x4(%eax),%edx
 97a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 97d:	39 f1                	cmp    %esi,%ecx
 97f:	75 c4                	jne    945 <free+0x45>
    p->s.size += bp->s.size;
 981:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 984:	a3 f0 0d 00 00       	mov    %eax,0xdf0
    p->s.size += bp->s.size;
 989:	01 ca                	add    %ecx,%edx
 98b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 98e:	8b 53 f8             	mov    -0x8(%ebx),%edx
 991:	89 10                	mov    %edx,(%eax)
}
 993:	5b                   	pop    %ebx
 994:	5e                   	pop    %esi
 995:	5f                   	pop    %edi
 996:	5d                   	pop    %ebp
 997:	c3                   	ret    
 998:	90                   	nop
 999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000009a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9a0:	55                   	push   %ebp
 9a1:	89 e5                	mov    %esp,%ebp
 9a3:	57                   	push   %edi
 9a4:	56                   	push   %esi
 9a5:	53                   	push   %ebx
 9a6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 9ac:	8b 15 f0 0d 00 00    	mov    0xdf0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9b2:	8d 78 07             	lea    0x7(%eax),%edi
 9b5:	c1 ef 03             	shr    $0x3,%edi
 9b8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 9b9:	85 d2                	test   %edx,%edx
 9bb:	0f 84 8f 00 00 00    	je     a50 <malloc+0xb0>
 9c1:	8b 02                	mov    (%edx),%eax
 9c3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 9c6:	39 cf                	cmp    %ecx,%edi
 9c8:	76 66                	jbe    a30 <malloc+0x90>
 9ca:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 9d0:	bb 00 10 00 00       	mov    $0x1000,%ebx
 9d5:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 9d8:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 9df:	eb 10                	jmp    9f1 <malloc+0x51>
 9e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9e8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 9ea:	8b 48 04             	mov    0x4(%eax),%ecx
 9ed:	39 f9                	cmp    %edi,%ecx
 9ef:	73 3f                	jae    a30 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9f1:	39 05 f0 0d 00 00    	cmp    %eax,0xdf0
 9f7:	89 c2                	mov    %eax,%edx
 9f9:	75 ed                	jne    9e8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 9fb:	89 34 24             	mov    %esi,(%esp)
 9fe:	e8 2d fc ff ff       	call   630 <sbrk>
  if(p == (char*)-1)
 a03:	83 f8 ff             	cmp    $0xffffffff,%eax
 a06:	74 18                	je     a20 <malloc+0x80>
  hp->s.size = nu;
 a08:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 a0b:	83 c0 08             	add    $0x8,%eax
 a0e:	89 04 24             	mov    %eax,(%esp)
 a11:	e8 ea fe ff ff       	call   900 <free>
  return freep;
 a16:	8b 15 f0 0d 00 00    	mov    0xdf0,%edx
      if((p = morecore(nunits)) == 0)
 a1c:	85 d2                	test   %edx,%edx
 a1e:	75 c8                	jne    9e8 <malloc+0x48>
        return 0;
  }
}
 a20:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 a23:	31 c0                	xor    %eax,%eax
}
 a25:	5b                   	pop    %ebx
 a26:	5e                   	pop    %esi
 a27:	5f                   	pop    %edi
 a28:	5d                   	pop    %ebp
 a29:	c3                   	ret    
 a2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 a30:	39 cf                	cmp    %ecx,%edi
 a32:	74 4c                	je     a80 <malloc+0xe0>
        p->s.size -= nunits;
 a34:	29 f9                	sub    %edi,%ecx
 a36:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 a39:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 a3c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 a3f:	89 15 f0 0d 00 00    	mov    %edx,0xdf0
}
 a45:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 a48:	83 c0 08             	add    $0x8,%eax
}
 a4b:	5b                   	pop    %ebx
 a4c:	5e                   	pop    %esi
 a4d:	5f                   	pop    %edi
 a4e:	5d                   	pop    %ebp
 a4f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 a50:	b8 f4 0d 00 00       	mov    $0xdf4,%eax
 a55:	ba f4 0d 00 00       	mov    $0xdf4,%edx
    base.s.size = 0;
 a5a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 a5c:	a3 f0 0d 00 00       	mov    %eax,0xdf0
    base.s.size = 0;
 a61:	b8 f4 0d 00 00       	mov    $0xdf4,%eax
    base.s.ptr = freep = prevp = &base;
 a66:	89 15 f4 0d 00 00    	mov    %edx,0xdf4
    base.s.size = 0;
 a6c:	89 0d f8 0d 00 00    	mov    %ecx,0xdf8
 a72:	e9 53 ff ff ff       	jmp    9ca <malloc+0x2a>
 a77:	89 f6                	mov    %esi,%esi
 a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 a80:	8b 08                	mov    (%eax),%ecx
 a82:	89 0a                	mov    %ecx,(%edx)
 a84:	eb b9                	jmp    a3f <malloc+0x9f>
