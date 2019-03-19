
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3

  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 20 c6 10 80       	mov    $0x8010c620,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 80 2f 10 80       	mov    $0x80102f80,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
80100041:	ba 20 84 10 80       	mov    $0x80108420,%edx
{
80100046:	89 e5                	mov    %esp,%ebp
80100048:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
80100049:	bb 1c 0d 11 80       	mov    $0x80110d1c,%ebx
{
8010004e:	83 ec 14             	sub    $0x14,%esp
  initlock(&bcache.lock, "bcache");
80100051:	89 54 24 04          	mov    %edx,0x4(%esp)
80100055:	c7 04 24 20 c6 10 80 	movl   $0x8010c620,(%esp)
8010005c:	e8 cf 55 00 00       	call   80105630 <initlock>
  bcache.head.prev = &bcache.head;
80100061:	b9 1c 0d 11 80       	mov    $0x80110d1c,%ecx
  bcache.head.next = &bcache.head;
80100066:	ba 1c 0d 11 80       	mov    $0x80110d1c,%edx
8010006b:	89 1d 70 0d 11 80    	mov    %ebx,0x80110d70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100071:	bb 54 c6 10 80       	mov    $0x8010c654,%ebx
  bcache.head.prev = &bcache.head;
80100076:	89 0d 6c 0d 11 80    	mov    %ecx,0x80110d6c
8010007c:	eb 04                	jmp    80100082 <binit+0x42>
8010007e:	66 90                	xchg   %ax,%ax
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	b8 27 84 10 80       	mov    $0x80108427,%eax
    b->next = bcache.head.next;
80100087:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008a:	c7 43 50 1c 0d 11 80 	movl   $0x80110d1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100091:	89 44 24 04          	mov    %eax,0x4(%esp)
80100095:	8d 43 0c             	lea    0xc(%ebx),%eax
80100098:	89 04 24             	mov    %eax,(%esp)
8010009b:	e8 60 54 00 00       	call   80105500 <initsleeplock>
    bcache.head.next->prev = b;
801000a0:	a1 70 0d 11 80       	mov    0x80110d70,%eax
801000a5:	89 da                	mov    %ebx,%edx
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
801000b0:	3d 1c 0d 11 80       	cmp    $0x80110d1c,%eax
    bcache.head.next = b;
801000b5:	89 1d 70 0d 11 80    	mov    %ebx,0x80110d70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	83 c4 14             	add    $0x14,%esp
801000c0:	5b                   	pop    %ebx
801000c1:	5d                   	pop    %ebp
801000c2:	c3                   	ret    
801000c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 1c             	sub    $0x1c,%esp
  acquire(&bcache.lock);
801000d9:	c7 04 24 20 c6 10 80 	movl   $0x8010c620,(%esp)
{
801000e0:	8b 75 08             	mov    0x8(%ebp),%esi
801000e3:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000e6:	e8 95 56 00 00       	call   80105780 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000eb:	8b 1d 70 0d 11 80    	mov    0x80110d70,%ebx
801000f1:	81 fb 1c 0d 11 80    	cmp    $0x80110d1c,%ebx
801000f7:	75 12                	jne    8010010b <bread+0x3b>
801000f9:	eb 25                	jmp    80100120 <bread+0x50>
801000fb:	90                   	nop
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c 0d 11 80    	cmp    $0x80110d1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	ff 43 4c             	incl   0x4c(%ebx)
80100118:	eb 40                	jmp    8010015a <bread+0x8a>
8010011a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c 0d 11 80    	mov    0x80110d6c,%ebx
80100126:	81 fb 1c 0d 11 80    	cmp    $0x80110d1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 58                	jmp    80100188 <bread+0xb8>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c 0d 11 80    	cmp    $0x80110d1c,%ebx
80100139:	74 4d                	je     80100188 <bread+0xb8>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	c7 04 24 20 c6 10 80 	movl   $0x8010c620,(%esp)
80100161:	e8 ba 56 00 00       	call   80105820 <release>
      acquiresleep(&b->lock);
80100166:	8d 43 0c             	lea    0xc(%ebx),%eax
80100169:	89 04 24             	mov    %eax,(%esp)
8010016c:	e8 cf 53 00 00       	call   80105540 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100171:	f6 03 02             	testb  $0x2,(%ebx)
80100174:	75 08                	jne    8010017e <bread+0xae>
    iderw(b);
80100176:	89 1c 24             	mov    %ebx,(%esp)
80100179:	e8 82 20 00 00       	call   80102200 <iderw>
  }
  return b;
}
8010017e:	83 c4 1c             	add    $0x1c,%esp
80100181:	89 d8                	mov    %ebx,%eax
80100183:	5b                   	pop    %ebx
80100184:	5e                   	pop    %esi
80100185:	5f                   	pop    %edi
80100186:	5d                   	pop    %ebp
80100187:	c3                   	ret    
  panic("bget: no buffers");
80100188:	c7 04 24 2e 84 10 80 	movl   $0x8010842e,(%esp)
8010018f:	e8 dc 01 00 00       	call   80100370 <panic>
80100194:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010019a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 14             	sub    $0x14,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	89 04 24             	mov    %eax,(%esp)
801001b0:	e8 2b 54 00 00       	call   801055e0 <holdingsleep>
801001b5:	85 c0                	test   %eax,%eax
801001b7:	74 10                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001b9:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bc:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001bf:	83 c4 14             	add    $0x14,%esp
801001c2:	5b                   	pop    %ebx
801001c3:	5d                   	pop    %ebp
  iderw(b);
801001c4:	e9 37 20 00 00       	jmp    80102200 <iderw>
    panic("bwrite");
801001c9:	c7 04 24 3f 84 10 80 	movl   $0x8010843f,(%esp)
801001d0:	e8 9b 01 00 00       	call   80100370 <panic>
801001d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	83 ec 10             	sub    $0x10,%esp
801001e8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	89 34 24             	mov    %esi,(%esp)
801001f1:	e8 ea 53 00 00       	call   801055e0 <holdingsleep>
801001f6:	85 c0                	test   %eax,%eax
801001f8:	74 5a                	je     80100254 <brelse+0x74>
    panic("brelse");

  releasesleep(&b->lock);
801001fa:	89 34 24             	mov    %esi,(%esp)
801001fd:	e8 9e 53 00 00       	call   801055a0 <releasesleep>

  acquire(&bcache.lock);
80100202:	c7 04 24 20 c6 10 80 	movl   $0x8010c620,(%esp)
80100209:	e8 72 55 00 00       	call   80105780 <acquire>
  b->refcnt--;
  if (b->refcnt == 0) {
8010020e:	ff 4b 4c             	decl   0x4c(%ebx)
80100211:	75 2f                	jne    80100242 <brelse+0x62>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100213:	8b 43 54             	mov    0x54(%ebx),%eax
80100216:	8b 53 50             	mov    0x50(%ebx),%edx
80100219:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
8010021c:	8b 43 50             	mov    0x50(%ebx),%eax
8010021f:	8b 53 54             	mov    0x54(%ebx),%edx
80100222:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100225:	a1 70 0d 11 80       	mov    0x80110d70,%eax
    b->prev = &bcache.head;
8010022a:	c7 43 50 1c 0d 11 80 	movl   $0x80110d1c,0x50(%ebx)
    b->next = bcache.head.next;
80100231:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100234:	a1 70 0d 11 80       	mov    0x80110d70,%eax
80100239:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010023c:	89 1d 70 0d 11 80    	mov    %ebx,0x80110d70
  }
  
  release(&bcache.lock);
80100242:	c7 45 08 20 c6 10 80 	movl   $0x8010c620,0x8(%ebp)
}
80100249:	83 c4 10             	add    $0x10,%esp
8010024c:	5b                   	pop    %ebx
8010024d:	5e                   	pop    %esi
8010024e:	5d                   	pop    %ebp
  release(&bcache.lock);
8010024f:	e9 cc 55 00 00       	jmp    80105820 <release>
    panic("brelse");
80100254:	c7 04 24 46 84 10 80 	movl   $0x80108446,(%esp)
8010025b:	e8 10 01 00 00       	call   80100370 <panic>

80100260 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100260:	55                   	push   %ebp
80100261:	89 e5                	mov    %esp,%ebp
80100263:	57                   	push   %edi
80100264:	56                   	push   %esi
80100265:	53                   	push   %ebx
80100266:	83 ec 2c             	sub    $0x2c,%esp
80100269:	8b 7d 08             	mov    0x8(%ebp),%edi
8010026c:	8b 75 10             	mov    0x10(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010026f:	89 3c 24             	mov    %edi,(%esp)
80100272:	e8 59 15 00 00       	call   801017d0 <iunlock>
  target = n;
  acquire(&cons.lock);
80100277:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010027e:	e8 fd 54 00 00       	call   80105780 <acquire>
  while(n > 0){
80100283:	31 c0                	xor    %eax,%eax
80100285:	85 f6                	test   %esi,%esi
80100287:	0f 8e a3 00 00 00    	jle    80100330 <consoleread+0xd0>
8010028d:	89 f3                	mov    %esi,%ebx
8010028f:	89 75 10             	mov    %esi,0x10(%ebp)
80100292:	8b 75 0c             	mov    0xc(%ebp),%esi
    while(input.r == input.w){
80100295:	8b 15 00 10 11 80    	mov    0x80111000,%edx
8010029b:	39 15 04 10 11 80    	cmp    %edx,0x80111004
801002a1:	74 28                	je     801002cb <consoleread+0x6b>
801002a3:	eb 5b                	jmp    80100300 <consoleread+0xa0>
801002a5:	8d 76 00             	lea    0x0(%esi),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002a8:	b8 20 b5 10 80       	mov    $0x8010b520,%eax
801002ad:	89 44 24 04          	mov    %eax,0x4(%esp)
801002b1:	c7 04 24 00 10 11 80 	movl   $0x80111000,(%esp)
801002b8:	e8 b3 3f 00 00       	call   80104270 <sleep>
    while(input.r == input.w){
801002bd:	8b 15 00 10 11 80    	mov    0x80111000,%edx
801002c3:	3b 15 04 10 11 80    	cmp    0x80111004,%edx
801002c9:	75 35                	jne    80100300 <consoleread+0xa0>
      if(myproc()->killed){
801002cb:	e8 b0 36 00 00       	call   80103980 <myproc>
801002d0:	8b 50 24             	mov    0x24(%eax),%edx
801002d3:	85 d2                	test   %edx,%edx
801002d5:	74 d1                	je     801002a8 <consoleread+0x48>
        release(&cons.lock);
801002d7:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
801002de:	e8 3d 55 00 00       	call   80105820 <release>
        ilock(ip);
801002e3:	89 3c 24             	mov    %edi,(%esp)
801002e6:	e8 05 14 00 00       	call   801016f0 <ilock>
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002eb:	83 c4 2c             	add    $0x2c,%esp
        return -1;
801002ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801002f3:	5b                   	pop    %ebx
801002f4:	5e                   	pop    %esi
801002f5:	5f                   	pop    %edi
801002f6:	5d                   	pop    %ebp
801002f7:	c3                   	ret    
801002f8:	90                   	nop
801002f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100300:	8d 42 01             	lea    0x1(%edx),%eax
80100303:	a3 00 10 11 80       	mov    %eax,0x80111000
80100308:	89 d0                	mov    %edx,%eax
8010030a:	83 e0 7f             	and    $0x7f,%eax
8010030d:	0f be 80 80 0f 11 80 	movsbl -0x7feef080(%eax),%eax
    if(c == C('D')){  // EOF
80100314:	83 f8 04             	cmp    $0x4,%eax
80100317:	74 39                	je     80100352 <consoleread+0xf2>
    *dst++ = c;
80100319:	46                   	inc    %esi
    --n;
8010031a:	4b                   	dec    %ebx
    if(c == '\n')
8010031b:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
8010031e:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100321:	74 42                	je     80100365 <consoleread+0x105>
  while(n > 0){
80100323:	85 db                	test   %ebx,%ebx
80100325:	0f 85 6a ff ff ff    	jne    80100295 <consoleread+0x35>
8010032b:	8b 75 10             	mov    0x10(%ebp),%esi
8010032e:	89 f0                	mov    %esi,%eax
  release(&cons.lock);
80100330:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
80100337:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010033a:	e8 e1 54 00 00       	call   80105820 <release>
  ilock(ip);
8010033f:	89 3c 24             	mov    %edi,(%esp)
80100342:	e8 a9 13 00 00       	call   801016f0 <ilock>
80100347:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
8010034a:	83 c4 2c             	add    $0x2c,%esp
8010034d:	5b                   	pop    %ebx
8010034e:	5e                   	pop    %esi
8010034f:	5f                   	pop    %edi
80100350:	5d                   	pop    %ebp
80100351:	c3                   	ret    
80100352:	8b 75 10             	mov    0x10(%ebp),%esi
80100355:	89 f0                	mov    %esi,%eax
80100357:	29 d8                	sub    %ebx,%eax
      if(n < target){
80100359:	39 f3                	cmp    %esi,%ebx
8010035b:	73 d3                	jae    80100330 <consoleread+0xd0>
        input.r--;
8010035d:	89 15 00 10 11 80    	mov    %edx,0x80111000
80100363:	eb cb                	jmp    80100330 <consoleread+0xd0>
80100365:	8b 75 10             	mov    0x10(%ebp),%esi
80100368:	89 f0                	mov    %esi,%eax
8010036a:	29 d8                	sub    %ebx,%eax
8010036c:	eb c2                	jmp    80100330 <consoleread+0xd0>
8010036e:	66 90                	xchg   %ax,%ax

80100370 <panic>:
{
80100370:	55                   	push   %ebp
80100371:	89 e5                	mov    %esp,%ebp
80100373:	56                   	push   %esi
80100374:	53                   	push   %ebx
80100375:	83 ec 40             	sub    $0x40,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100378:	fa                   	cli    
  cons.locking = 0;
80100379:	31 d2                	xor    %edx,%edx
8010037b:	89 15 54 b5 10 80    	mov    %edx,0x8010b554
  getcallerpcs(&s, pcs);
80100381:	8d 5d d0             	lea    -0x30(%ebp),%ebx
  cprintf("lapicid %d: panic: ", lapicid());
80100384:	e8 a7 24 00 00       	call   80102830 <lapicid>
80100389:	8d 75 f8             	lea    -0x8(%ebp),%esi
8010038c:	c7 04 24 4d 84 10 80 	movl   $0x8010844d,(%esp)
80100393:	89 44 24 04          	mov    %eax,0x4(%esp)
80100397:	e8 b4 02 00 00       	call   80100650 <cprintf>
  cprintf(s);
8010039c:	8b 45 08             	mov    0x8(%ebp),%eax
8010039f:	89 04 24             	mov    %eax,(%esp)
801003a2:	e8 a9 02 00 00       	call   80100650 <cprintf>
  cprintf("\n");
801003a7:	c7 04 24 19 8b 10 80 	movl   $0x80108b19,(%esp)
801003ae:	e8 9d 02 00 00       	call   80100650 <cprintf>
  getcallerpcs(&s, pcs);
801003b3:	8d 45 08             	lea    0x8(%ebp),%eax
801003b6:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801003ba:	89 04 24             	mov    %eax,(%esp)
801003bd:	e8 8e 52 00 00       	call   80105650 <getcallerpcs>
801003c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    cprintf(" %p", pcs[i]);
801003d0:	8b 03                	mov    (%ebx),%eax
801003d2:	83 c3 04             	add    $0x4,%ebx
801003d5:	c7 04 24 61 84 10 80 	movl   $0x80108461,(%esp)
801003dc:	89 44 24 04          	mov    %eax,0x4(%esp)
801003e0:	e8 6b 02 00 00       	call   80100650 <cprintf>
  for(i=0; i<10; i++)
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x60>
  panicked = 1; // freeze other CPU
801003e9:	b8 01 00 00 00       	mov    $0x1,%eax
801003ee:	a3 58 b5 10 80       	mov    %eax,0x8010b558
801003f3:	eb fe                	jmp    801003f3 <panic+0x83>
801003f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801003f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100400 <consputc>:
  if(panicked){
80100400:	8b 15 58 b5 10 80    	mov    0x8010b558,%edx
80100406:	85 d2                	test   %edx,%edx
80100408:	74 06                	je     80100410 <consputc+0x10>
8010040a:	fa                   	cli    
8010040b:	eb fe                	jmp    8010040b <consputc+0xb>
8010040d:	8d 76 00             	lea    0x0(%esi),%esi
{
80100410:	55                   	push   %ebp
80100411:	89 e5                	mov    %esp,%ebp
80100413:	57                   	push   %edi
80100414:	56                   	push   %esi
80100415:	53                   	push   %ebx
80100416:	89 c3                	mov    %eax,%ebx
80100418:	83 ec 2c             	sub    $0x2c,%esp
  if(c == BACKSPACE){
8010041b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100420:	0f 84 9f 00 00 00    	je     801004c5 <consputc+0xc5>
    uartputc(c);
80100426:	89 04 24             	mov    %eax,(%esp)
80100429:	e8 d2 6b 00 00       	call   80107000 <uartputc>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010042e:	be d4 03 00 00       	mov    $0x3d4,%esi
80100433:	b0 0e                	mov    $0xe,%al
80100435:	89 f2                	mov    %esi,%edx
80100437:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100438:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010043d:	89 ca                	mov    %ecx,%edx
8010043f:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100440:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100443:	89 f2                	mov    %esi,%edx
80100445:	c1 e0 08             	shl    $0x8,%eax
80100448:	89 c7                	mov    %eax,%edi
8010044a:	b0 0f                	mov    $0xf,%al
8010044c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044d:	89 ca                	mov    %ecx,%edx
8010044f:	ec                   	in     (%dx),%al
80100450:	0f b6 c8             	movzbl %al,%ecx
  pos |= inb(CRTPORT+1);
80100453:	09 f9                	or     %edi,%ecx
  if(c == '\n')
80100455:	83 fb 0a             	cmp    $0xa,%ebx
80100458:	0f 84 ff 00 00 00    	je     8010055d <consputc+0x15d>
  else if(c == BACKSPACE){
8010045e:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
80100464:	0f 84 e5 00 00 00    	je     8010054f <consputc+0x14f>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010046a:	0f b6 c3             	movzbl %bl,%eax
8010046d:	0d 00 07 00 00       	or     $0x700,%eax
80100472:	66 89 84 09 00 80 0b 	mov    %ax,-0x7ff48000(%ecx,%ecx,1)
80100479:	80 
8010047a:	41                   	inc    %ecx
  if(pos < 0 || pos > 25*80)
8010047b:	81 f9 d0 07 00 00    	cmp    $0x7d0,%ecx
80100481:	0f 8f bc 00 00 00    	jg     80100543 <consputc+0x143>
  if((pos/80) >= 24){  // Scroll up.
80100487:	81 f9 7f 07 00 00    	cmp    $0x77f,%ecx
8010048d:	7f 5f                	jg     801004ee <consputc+0xee>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010048f:	be d4 03 00 00       	mov    $0x3d4,%esi
80100494:	b0 0e                	mov    $0xe,%al
80100496:	89 f2                	mov    %esi,%edx
80100498:	ee                   	out    %al,(%dx)
80100499:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  outb(CRTPORT+1, pos>>8);
8010049e:	89 c8                	mov    %ecx,%eax
801004a0:	c1 f8 08             	sar    $0x8,%eax
801004a3:	89 da                	mov    %ebx,%edx
801004a5:	ee                   	out    %al,(%dx)
801004a6:	b0 0f                	mov    $0xf,%al
801004a8:	89 f2                	mov    %esi,%edx
801004aa:	ee                   	out    %al,(%dx)
801004ab:	88 c8                	mov    %cl,%al
801004ad:	89 da                	mov    %ebx,%edx
801004af:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004b0:	b8 20 07 00 00       	mov    $0x720,%eax
801004b5:	66 89 84 09 00 80 0b 	mov    %ax,-0x7ff48000(%ecx,%ecx,1)
801004bc:	80 
}
801004bd:	83 c4 2c             	add    $0x2c,%esp
801004c0:	5b                   	pop    %ebx
801004c1:	5e                   	pop    %esi
801004c2:	5f                   	pop    %edi
801004c3:	5d                   	pop    %ebp
801004c4:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004c5:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004cc:	e8 2f 6b 00 00       	call   80107000 <uartputc>
801004d1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004d8:	e8 23 6b 00 00       	call   80107000 <uartputc>
801004dd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004e4:	e8 17 6b 00 00       	call   80107000 <uartputc>
801004e9:	e9 40 ff ff ff       	jmp    8010042e <consputc+0x2e>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004ee:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
801004f5:	00 
801004f6:	c7 44 24 04 a0 80 0b 	movl   $0x800b80a0,0x4(%esp)
801004fd:	80 
801004fe:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
80100505:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80100508:	e8 23 54 00 00       	call   80105930 <memmove>
    pos -= 80;
8010050d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100510:	b8 80 07 00 00       	mov    $0x780,%eax
80100515:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010051c:	00 
    pos -= 80;
8010051d:	83 e9 50             	sub    $0x50,%ecx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100520:	29 c8                	sub    %ecx,%eax
80100522:	01 c0                	add    %eax,%eax
80100524:	89 44 24 08          	mov    %eax,0x8(%esp)
80100528:	8d 04 09             	lea    (%ecx,%ecx,1),%eax
8010052b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100530:	89 04 24             	mov    %eax,(%esp)
80100533:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80100536:	e8 35 53 00 00       	call   80105870 <memset>
8010053b:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010053e:	e9 4c ff ff ff       	jmp    8010048f <consputc+0x8f>
    panic("pos under/overflow");
80100543:	c7 04 24 65 84 10 80 	movl   $0x80108465,(%esp)
8010054a:	e8 21 fe ff ff       	call   80100370 <panic>
    if(pos > 0) --pos;
8010054f:	85 c9                	test   %ecx,%ecx
80100551:	0f 84 38 ff ff ff    	je     8010048f <consputc+0x8f>
80100557:	49                   	dec    %ecx
80100558:	e9 1e ff ff ff       	jmp    8010047b <consputc+0x7b>
    pos += 80 - pos%80;
8010055d:	89 c8                	mov    %ecx,%eax
8010055f:	bb 50 00 00 00       	mov    $0x50,%ebx
80100564:	99                   	cltd   
80100565:	f7 fb                	idiv   %ebx
80100567:	29 d3                	sub    %edx,%ebx
80100569:	01 d9                	add    %ebx,%ecx
8010056b:	e9 0b ff ff ff       	jmp    8010047b <consputc+0x7b>

80100570 <printint>:
{
80100570:	55                   	push   %ebp
80100571:	89 e5                	mov    %esp,%ebp
80100573:	57                   	push   %edi
80100574:	56                   	push   %esi
80100575:	53                   	push   %ebx
80100576:	89 d3                	mov    %edx,%ebx
80100578:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010057b:	85 c9                	test   %ecx,%ecx
{
8010057d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100580:	74 04                	je     80100586 <printint+0x16>
80100582:	85 c0                	test   %eax,%eax
80100584:	78 62                	js     801005e8 <printint+0x78>
    x = xx;
80100586:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010058d:	31 c9                	xor    %ecx,%ecx
8010058f:	8d 75 d7             	lea    -0x29(%ebp),%esi
80100592:	eb 06                	jmp    8010059a <printint+0x2a>
80100594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
80100598:	89 f9                	mov    %edi,%ecx
8010059a:	31 d2                	xor    %edx,%edx
8010059c:	f7 f3                	div    %ebx
8010059e:	8d 79 01             	lea    0x1(%ecx),%edi
801005a1:	0f b6 92 90 84 10 80 	movzbl -0x7fef7b70(%edx),%edx
  }while((x /= base) != 0);
801005a8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005aa:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
801005ad:	75 e9                	jne    80100598 <printint+0x28>
  if(sign)
801005af:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005b2:	85 c0                	test   %eax,%eax
801005b4:	74 08                	je     801005be <printint+0x4e>
    buf[i++] = '-';
801005b6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
801005bb:	8d 79 02             	lea    0x2(%ecx),%edi
801005be:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801005c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    consputc(buf[i]);
801005d0:	0f be 03             	movsbl (%ebx),%eax
801005d3:	4b                   	dec    %ebx
801005d4:	e8 27 fe ff ff       	call   80100400 <consputc>
  while(--i >= 0)
801005d9:	39 f3                	cmp    %esi,%ebx
801005db:	75 f3                	jne    801005d0 <printint+0x60>
}
801005dd:	83 c4 2c             	add    $0x2c,%esp
801005e0:	5b                   	pop    %ebx
801005e1:	5e                   	pop    %esi
801005e2:	5f                   	pop    %edi
801005e3:	5d                   	pop    %ebp
801005e4:	c3                   	ret    
801005e5:	8d 76 00             	lea    0x0(%esi),%esi
    x = -xx;
801005e8:	f7 d8                	neg    %eax
801005ea:	eb a1                	jmp    8010058d <printint+0x1d>
801005ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801005f0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005f0:	55                   	push   %ebp
801005f1:	89 e5                	mov    %esp,%ebp
801005f3:	57                   	push   %edi
801005f4:	56                   	push   %esi
801005f5:	53                   	push   %ebx
801005f6:	83 ec 1c             	sub    $0x1c,%esp
  int i;

  iunlock(ip);
801005f9:	8b 45 08             	mov    0x8(%ebp),%eax
{
801005fc:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
801005ff:	89 04 24             	mov    %eax,(%esp)
80100602:	e8 c9 11 00 00       	call   801017d0 <iunlock>
  acquire(&cons.lock);
80100607:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010060e:	e8 6d 51 00 00       	call   80105780 <acquire>
  for(i = 0; i < n; i++)
80100613:	85 f6                	test   %esi,%esi
80100615:	7e 16                	jle    8010062d <consolewrite+0x3d>
80100617:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010061a:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010061d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100620:	0f b6 07             	movzbl (%edi),%eax
80100623:	47                   	inc    %edi
80100624:	e8 d7 fd ff ff       	call   80100400 <consputc>
  for(i = 0; i < n; i++)
80100629:	39 fb                	cmp    %edi,%ebx
8010062b:	75 f3                	jne    80100620 <consolewrite+0x30>
  release(&cons.lock);
8010062d:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
80100634:	e8 e7 51 00 00       	call   80105820 <release>
  ilock(ip);
80100639:	8b 45 08             	mov    0x8(%ebp),%eax
8010063c:	89 04 24             	mov    %eax,(%esp)
8010063f:	e8 ac 10 00 00       	call   801016f0 <ilock>

  return n;
}
80100644:	83 c4 1c             	add    $0x1c,%esp
80100647:	89 f0                	mov    %esi,%eax
80100649:	5b                   	pop    %ebx
8010064a:	5e                   	pop    %esi
8010064b:	5f                   	pop    %edi
8010064c:	5d                   	pop    %ebp
8010064d:	c3                   	ret    
8010064e:	66 90                	xchg   %ax,%ax

80100650 <cprintf>:
{
80100650:	55                   	push   %ebp
80100651:	89 e5                	mov    %esp,%ebp
80100653:	57                   	push   %edi
80100654:	56                   	push   %esi
80100655:	53                   	push   %ebx
80100656:	83 ec 2c             	sub    $0x2c,%esp
  locking = cons.locking;
80100659:	a1 54 b5 10 80       	mov    0x8010b554,%eax
  if(locking)
8010065e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100660:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100663:	0f 85 47 01 00 00    	jne    801007b0 <cprintf+0x160>
  if (fmt == 0)
80100669:	8b 45 08             	mov    0x8(%ebp),%eax
8010066c:	85 c0                	test   %eax,%eax
8010066e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100671:	0f 84 4a 01 00 00    	je     801007c1 <cprintf+0x171>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100677:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
8010067a:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010067d:	31 db                	xor    %ebx,%ebx
8010067f:	89 cf                	mov    %ecx,%edi
80100681:	85 c0                	test   %eax,%eax
80100683:	75 59                	jne    801006de <cprintf+0x8e>
80100685:	eb 79                	jmp    80100700 <cprintf+0xb0>
80100687:	89 f6                	mov    %esi,%esi
80100689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
80100690:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
80100693:	85 d2                	test   %edx,%edx
80100695:	74 69                	je     80100700 <cprintf+0xb0>
80100697:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010069a:	83 c3 02             	add    $0x2,%ebx
    switch(c){
8010069d:	83 fa 70             	cmp    $0x70,%edx
801006a0:	8d 34 18             	lea    (%eax,%ebx,1),%esi
801006a3:	0f 84 81 00 00 00    	je     8010072a <cprintf+0xda>
801006a9:	7f 75                	jg     80100720 <cprintf+0xd0>
801006ab:	83 fa 25             	cmp    $0x25,%edx
801006ae:	0f 84 e4 00 00 00    	je     80100798 <cprintf+0x148>
801006b4:	83 fa 64             	cmp    $0x64,%edx
801006b7:	0f 85 8b 00 00 00    	jne    80100748 <cprintf+0xf8>
      printint(*argp++, 10, 1);
801006bd:	8d 47 04             	lea    0x4(%edi),%eax
801006c0:	b9 01 00 00 00       	mov    $0x1,%ecx
801006c5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801006c8:	8b 07                	mov    (%edi),%eax
801006ca:	ba 0a 00 00 00       	mov    $0xa,%edx
801006cf:	e8 9c fe ff ff       	call   80100570 <printint>
801006d4:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006d7:	0f b6 06             	movzbl (%esi),%eax
801006da:	85 c0                	test   %eax,%eax
801006dc:	74 22                	je     80100700 <cprintf+0xb0>
801006de:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801006e1:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801006e4:	83 f8 25             	cmp    $0x25,%eax
801006e7:	8d 34 11             	lea    (%ecx,%edx,1),%esi
801006ea:	74 a4                	je     80100690 <cprintf+0x40>
801006ec:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801006ef:	e8 0c fd ff ff       	call   80100400 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006f4:	0f b6 06             	movzbl (%esi),%eax
      continue;
801006f7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fa:	85 c0                	test   %eax,%eax
      continue;
801006fc:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	75 de                	jne    801006de <cprintf+0x8e>
  if(locking)
80100700:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100703:	85 c0                	test   %eax,%eax
80100705:	74 0c                	je     80100713 <cprintf+0xc3>
    release(&cons.lock);
80100707:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010070e:	e8 0d 51 00 00       	call   80105820 <release>
}
80100713:	83 c4 2c             	add    $0x2c,%esp
80100716:	5b                   	pop    %ebx
80100717:	5e                   	pop    %esi
80100718:	5f                   	pop    %edi
80100719:	5d                   	pop    %ebp
8010071a:	c3                   	ret    
8010071b:	90                   	nop
8010071c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100720:	83 fa 73             	cmp    $0x73,%edx
80100723:	74 43                	je     80100768 <cprintf+0x118>
80100725:	83 fa 78             	cmp    $0x78,%edx
80100728:	75 1e                	jne    80100748 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010072a:	8d 47 04             	lea    0x4(%edi),%eax
8010072d:	31 c9                	xor    %ecx,%ecx
8010072f:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100732:	8b 07                	mov    (%edi),%eax
80100734:	ba 10 00 00 00       	mov    $0x10,%edx
80100739:	e8 32 fe ff ff       	call   80100570 <printint>
8010073e:	8b 7d e0             	mov    -0x20(%ebp),%edi
      break;
80100741:	eb 94                	jmp    801006d7 <cprintf+0x87>
80100743:	90                   	nop
80100744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100748:	b8 25 00 00 00       	mov    $0x25,%eax
8010074d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100750:	e8 ab fc ff ff       	call   80100400 <consputc>
      consputc(c);
80100755:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100758:	89 d0                	mov    %edx,%eax
8010075a:	e8 a1 fc ff ff       	call   80100400 <consputc>
      break;
8010075f:	e9 73 ff ff ff       	jmp    801006d7 <cprintf+0x87>
80100764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100768:	8d 47 04             	lea    0x4(%edi),%eax
8010076b:	8b 3f                	mov    (%edi),%edi
8010076d:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100770:	85 ff                	test   %edi,%edi
80100772:	75 12                	jne    80100786 <cprintf+0x136>
        s = "(null)";
80100774:	bf 78 84 10 80       	mov    $0x80108478,%edi
      for(; *s; s++)
80100779:	b8 28 00 00 00       	mov    $0x28,%eax
8010077e:	66 90                	xchg   %ax,%ax
        consputc(*s);
80100780:	e8 7b fc ff ff       	call   80100400 <consputc>
      for(; *s; s++)
80100785:	47                   	inc    %edi
80100786:	0f be 07             	movsbl (%edi),%eax
80100789:	84 c0                	test   %al,%al
8010078b:	75 f3                	jne    80100780 <cprintf+0x130>
      if((s = (char*)*argp++) == 0)
8010078d:	8b 7d e0             	mov    -0x20(%ebp),%edi
80100790:	e9 42 ff ff ff       	jmp    801006d7 <cprintf+0x87>
80100795:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
80100798:	b8 25 00 00 00       	mov    $0x25,%eax
8010079d:	e8 5e fc ff ff       	call   80100400 <consputc>
      break;
801007a2:	e9 30 ff ff ff       	jmp    801006d7 <cprintf+0x87>
801007a7:	89 f6                	mov    %esi,%esi
801007a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    acquire(&cons.lock);
801007b0:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
801007b7:	e8 c4 4f 00 00       	call   80105780 <acquire>
801007bc:	e9 a8 fe ff ff       	jmp    80100669 <cprintf+0x19>
    panic("null fmt");
801007c1:	c7 04 24 7f 84 10 80 	movl   $0x8010847f,(%esp)
801007c8:	e8 a3 fb ff ff       	call   80100370 <panic>
801007cd:	8d 76 00             	lea    0x0(%esi),%esi

801007d0 <consoleintr>:
{
801007d0:	55                   	push   %ebp
801007d1:	89 e5                	mov    %esp,%ebp
801007d3:	56                   	push   %esi
  int c, doprocdump = 0;
801007d4:	31 f6                	xor    %esi,%esi
{
801007d6:	53                   	push   %ebx
801007d7:	83 ec 20             	sub    $0x20,%esp
  acquire(&cons.lock);
801007da:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
{
801007e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
801007e4:	e8 97 4f 00 00       	call   80105780 <acquire>
801007e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while((c = getc()) >= 0){
801007f0:	ff d3                	call   *%ebx
801007f2:	85 c0                	test   %eax,%eax
801007f4:	89 c2                	mov    %eax,%edx
801007f6:	78 48                	js     80100840 <consoleintr+0x70>
    switch(c){
801007f8:	83 fa 10             	cmp    $0x10,%edx
801007fb:	0f 84 e7 00 00 00    	je     801008e8 <consoleintr+0x118>
80100801:	7e 5d                	jle    80100860 <consoleintr+0x90>
80100803:	83 fa 15             	cmp    $0x15,%edx
80100806:	0f 84 ec 00 00 00    	je     801008f8 <consoleintr+0x128>
8010080c:	83 fa 7f             	cmp    $0x7f,%edx
8010080f:	90                   	nop
80100810:	75 53                	jne    80100865 <consoleintr+0x95>
      if(input.e != input.w){
80100812:	a1 08 10 11 80       	mov    0x80111008,%eax
80100817:	3b 05 04 10 11 80    	cmp    0x80111004,%eax
8010081d:	74 d1                	je     801007f0 <consoleintr+0x20>
        input.e--;
8010081f:	48                   	dec    %eax
80100820:	a3 08 10 11 80       	mov    %eax,0x80111008
        consputc(BACKSPACE);
80100825:	b8 00 01 00 00       	mov    $0x100,%eax
8010082a:	e8 d1 fb ff ff       	call   80100400 <consputc>
  while((c = getc()) >= 0){
8010082f:	ff d3                	call   *%ebx
80100831:	85 c0                	test   %eax,%eax
80100833:	89 c2                	mov    %eax,%edx
80100835:	79 c1                	jns    801007f8 <consoleintr+0x28>
80100837:	89 f6                	mov    %esi,%esi
80100839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&cons.lock);
80100840:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
80100847:	e8 d4 4f 00 00       	call   80105820 <release>
  if(doprocdump) {
8010084c:	85 f6                	test   %esi,%esi
8010084e:	0f 85 f4 00 00 00    	jne    80100948 <consoleintr+0x178>
}
80100854:	83 c4 20             	add    $0x20,%esp
80100857:	5b                   	pop    %ebx
80100858:	5e                   	pop    %esi
80100859:	5d                   	pop    %ebp
8010085a:	c3                   	ret    
8010085b:	90                   	nop
8010085c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100860:	83 fa 08             	cmp    $0x8,%edx
80100863:	74 ad                	je     80100812 <consoleintr+0x42>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100865:	85 d2                	test   %edx,%edx
80100867:	74 87                	je     801007f0 <consoleintr+0x20>
80100869:	a1 08 10 11 80       	mov    0x80111008,%eax
8010086e:	89 c1                	mov    %eax,%ecx
80100870:	2b 0d 00 10 11 80    	sub    0x80111000,%ecx
80100876:	83 f9 7f             	cmp    $0x7f,%ecx
80100879:	0f 87 71 ff ff ff    	ja     801007f0 <consoleintr+0x20>
8010087f:	8d 48 01             	lea    0x1(%eax),%ecx
80100882:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
80100885:	83 fa 0d             	cmp    $0xd,%edx
        input.buf[input.e++ % INPUT_BUF] = c;
80100888:	89 0d 08 10 11 80    	mov    %ecx,0x80111008
        c = (c == '\r') ? '\n' : c;
8010088e:	0f 84 c4 00 00 00    	je     80100958 <consoleintr+0x188>
        input.buf[input.e++ % INPUT_BUF] = c;
80100894:	88 90 80 0f 11 80    	mov    %dl,-0x7feef080(%eax)
        consputc(c);
8010089a:	89 d0                	mov    %edx,%eax
8010089c:	89 55 f4             	mov    %edx,-0xc(%ebp)
8010089f:	e8 5c fb ff ff       	call   80100400 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008a4:	8b 55 f4             	mov    -0xc(%ebp),%edx
801008a7:	83 fa 0a             	cmp    $0xa,%edx
801008aa:	0f 84 b9 00 00 00    	je     80100969 <consoleintr+0x199>
801008b0:	83 fa 04             	cmp    $0x4,%edx
801008b3:	0f 84 b0 00 00 00    	je     80100969 <consoleintr+0x199>
801008b9:	a1 00 10 11 80       	mov    0x80111000,%eax
801008be:	83 e8 80             	sub    $0xffffff80,%eax
801008c1:	39 05 08 10 11 80    	cmp    %eax,0x80111008
801008c7:	0f 85 23 ff ff ff    	jne    801007f0 <consoleintr+0x20>
          wakeup(&input.r);
801008cd:	c7 04 24 00 10 11 80 	movl   $0x80111000,(%esp)
          input.w = input.e;
801008d4:	a3 04 10 11 80       	mov    %eax,0x80111004
          wakeup(&input.r);
801008d9:	e8 72 3b 00 00       	call   80104450 <wakeup>
801008de:	e9 0d ff ff ff       	jmp    801007f0 <consoleintr+0x20>
801008e3:	90                   	nop
801008e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
801008e8:	be 01 00 00 00       	mov    $0x1,%esi
801008ed:	e9 fe fe ff ff       	jmp    801007f0 <consoleintr+0x20>
801008f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
801008f8:	a1 08 10 11 80       	mov    0x80111008,%eax
801008fd:	39 05 04 10 11 80    	cmp    %eax,0x80111004
80100903:	75 2b                	jne    80100930 <consoleintr+0x160>
80100905:	e9 e6 fe ff ff       	jmp    801007f0 <consoleintr+0x20>
8010090a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100910:	a3 08 10 11 80       	mov    %eax,0x80111008
        consputc(BACKSPACE);
80100915:	b8 00 01 00 00       	mov    $0x100,%eax
8010091a:	e8 e1 fa ff ff       	call   80100400 <consputc>
      while(input.e != input.w &&
8010091f:	a1 08 10 11 80       	mov    0x80111008,%eax
80100924:	3b 05 04 10 11 80    	cmp    0x80111004,%eax
8010092a:	0f 84 c0 fe ff ff    	je     801007f0 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100930:	48                   	dec    %eax
80100931:	89 c2                	mov    %eax,%edx
80100933:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100936:	80 ba 80 0f 11 80 0a 	cmpb   $0xa,-0x7feef080(%edx)
8010093d:	75 d1                	jne    80100910 <consoleintr+0x140>
8010093f:	e9 ac fe ff ff       	jmp    801007f0 <consoleintr+0x20>
80100944:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80100948:	83 c4 20             	add    $0x20,%esp
8010094b:	5b                   	pop    %ebx
8010094c:	5e                   	pop    %esi
8010094d:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
8010094e:	e9 ad 3d 00 00       	jmp    80104700 <procdump>
80100953:	90                   	nop
80100954:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
80100958:	c6 80 80 0f 11 80 0a 	movb   $0xa,-0x7feef080(%eax)
        consputc(c);
8010095f:	b8 0a 00 00 00       	mov    $0xa,%eax
80100964:	e8 97 fa ff ff       	call   80100400 <consputc>
80100969:	a1 08 10 11 80       	mov    0x80111008,%eax
8010096e:	e9 5a ff ff ff       	jmp    801008cd <consoleintr+0xfd>
80100973:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100980 <consoleinit>:

void
consoleinit(void)
{
80100980:	55                   	push   %ebp
  initlock(&cons.lock, "console");
80100981:	b8 88 84 10 80       	mov    $0x80108488,%eax
{
80100986:	89 e5                	mov    %esp,%ebp
80100988:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
8010098b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010098f:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
80100996:	e8 95 4c 00 00       	call   80105630 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;
8010099b:	b8 01 00 00 00       	mov    $0x1,%eax
  devsw[CONSOLE].write = consolewrite;
801009a0:	ba f0 05 10 80       	mov    $0x801005f0,%edx
  cons.locking = 1;
801009a5:	a3 54 b5 10 80       	mov    %eax,0x8010b554

  ioapicenable(IRQ_KBD, 0);
801009aa:	31 c0                	xor    %eax,%eax
  devsw[CONSOLE].read = consoleread;
801009ac:	b9 60 02 10 80       	mov    $0x80100260,%ecx
  ioapicenable(IRQ_KBD, 0);
801009b1:	89 44 24 04          	mov    %eax,0x4(%esp)
801009b5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  devsw[CONSOLE].write = consolewrite;
801009bc:	89 15 cc 19 11 80    	mov    %edx,0x801119cc
  devsw[CONSOLE].read = consoleread;
801009c2:	89 0d c8 19 11 80    	mov    %ecx,0x801119c8
  ioapicenable(IRQ_KBD, 0);
801009c8:	e8 d3 19 00 00       	call   801023a0 <ioapicenable>
}
801009cd:	c9                   	leave  
801009ce:	c3                   	ret    
801009cf:	90                   	nop

801009d0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009d0:	55                   	push   %ebp
801009d1:	89 e5                	mov    %esp,%ebp
801009d3:	57                   	push   %edi
801009d4:	56                   	push   %esi
801009d5:	53                   	push   %ebx
801009d6:	81 ec 2c 01 00 00    	sub    $0x12c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801009dc:	e8 9f 2f 00 00       	call   80103980 <myproc>
801009e1:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
801009e7:	e8 a4 22 00 00       	call   80102c90 <begin_op>

  if((ip = namei(path)) == 0){
801009ec:	8b 45 08             	mov    0x8(%ebp),%eax
801009ef:	89 04 24             	mov    %eax,(%esp)
801009f2:	e8 d9 15 00 00       	call   80101fd0 <namei>
801009f7:	85 c0                	test   %eax,%eax
801009f9:	0f 84 b6 01 00 00    	je     80100bb5 <exec+0x1e5>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
801009ff:	89 04 24             	mov    %eax,(%esp)
80100a02:	89 c7                	mov    %eax,%edi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a04:	31 db                	xor    %ebx,%ebx
  ilock(ip);
80100a06:	e8 e5 0c 00 00       	call   801016f0 <ilock>
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a0b:	b9 34 00 00 00       	mov    $0x34,%ecx
80100a10:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a16:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80100a1a:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100a1e:	89 44 24 04          	mov    %eax,0x4(%esp)
80100a22:	89 3c 24             	mov    %edi,(%esp)
80100a25:	e8 a6 0f 00 00       	call   801019d0 <readi>
80100a2a:	83 f8 34             	cmp    $0x34,%eax
80100a2d:	74 21                	je     80100a50 <exec+0x80>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a2f:	89 3c 24             	mov    %edi,(%esp)
80100a32:	e8 49 0f 00 00       	call   80101980 <iunlockput>
    end_op();
80100a37:	e8 c4 22 00 00       	call   80102d00 <end_op>
  }
  return -1;
80100a3c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a41:	81 c4 2c 01 00 00    	add    $0x12c,%esp
80100a47:	5b                   	pop    %ebx
80100a48:	5e                   	pop    %esi
80100a49:	5f                   	pop    %edi
80100a4a:	5d                   	pop    %ebp
80100a4b:	c3                   	ret    
80100a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100a50:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a57:	45 4c 46 
80100a5a:	75 d3                	jne    80100a2f <exec+0x5f>
  if((pgdir = setupkvm()) == 0)
80100a5c:	e8 ff 76 00 00       	call   80108160 <setupkvm>
80100a61:	85 c0                	test   %eax,%eax
80100a63:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100a69:	74 c4                	je     80100a2f <exec+0x5f>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a6b:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  sz = 0;
80100a71:	31 f6                	xor    %esi,%esi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a73:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a7a:	00 
80100a7b:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100a81:	0f 84 b8 02 00 00    	je     80100d3f <exec+0x36f>
80100a87:	31 db                	xor    %ebx,%ebx
80100a89:	e9 8c 00 00 00       	jmp    80100b1a <exec+0x14a>
80100a8e:	66 90                	xchg   %ax,%ax
    if(ph.type != ELF_PROG_LOAD)
80100a90:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100a97:	75 75                	jne    80100b0e <exec+0x13e>
    if(ph.memsz < ph.filesz)
80100a99:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100a9f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100aa5:	0f 82 a4 00 00 00    	jb     80100b4f <exec+0x17f>
80100aab:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ab1:	0f 82 98 00 00 00    	jb     80100b4f <exec+0x17f>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100ab7:	89 44 24 08          	mov    %eax,0x8(%esp)
80100abb:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ac1:	89 74 24 04          	mov    %esi,0x4(%esp)
80100ac5:	89 04 24             	mov    %eax,(%esp)
80100ac8:	e8 b3 74 00 00       	call   80107f80 <allocuvm>
80100acd:	85 c0                	test   %eax,%eax
80100acf:	89 c6                	mov    %eax,%esi
80100ad1:	74 7c                	je     80100b4f <exec+0x17f>
    if(ph.vaddr % PGSIZE != 0)
80100ad3:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100ad9:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100ade:	75 6f                	jne    80100b4f <exec+0x17f>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100ae0:	8b 95 14 ff ff ff    	mov    -0xec(%ebp),%edx
80100ae6:	89 44 24 04          	mov    %eax,0x4(%esp)
80100aea:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100af0:	89 7c 24 08          	mov    %edi,0x8(%esp)
80100af4:	89 54 24 10          	mov    %edx,0x10(%esp)
80100af8:	8b 95 08 ff ff ff    	mov    -0xf8(%ebp),%edx
80100afe:	89 04 24             	mov    %eax,(%esp)
80100b01:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100b05:	e8 b6 73 00 00       	call   80107ec0 <loaduvm>
80100b0a:	85 c0                	test   %eax,%eax
80100b0c:	78 41                	js     80100b4f <exec+0x17f>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b0e:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b15:	43                   	inc    %ebx
80100b16:	39 d8                	cmp    %ebx,%eax
80100b18:	7e 48                	jle    80100b62 <exec+0x192>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b1a:	8b 95 ec fe ff ff    	mov    -0x114(%ebp),%edx
80100b20:	b8 20 00 00 00       	mov    $0x20,%eax
80100b25:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100b29:	89 d8                	mov    %ebx,%eax
80100b2b:	c1 e0 05             	shl    $0x5,%eax
80100b2e:	89 3c 24             	mov    %edi,(%esp)
80100b31:	01 d0                	add    %edx,%eax
80100b33:	89 44 24 08          	mov    %eax,0x8(%esp)
80100b37:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b3d:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b41:	e8 8a 0e 00 00       	call   801019d0 <readi>
80100b46:	83 f8 20             	cmp    $0x20,%eax
80100b49:	0f 84 41 ff ff ff    	je     80100a90 <exec+0xc0>
    freevm(pgdir);
80100b4f:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b55:	89 04 24             	mov    %eax,(%esp)
80100b58:	e8 83 75 00 00       	call   801080e0 <freevm>
80100b5d:	e9 cd fe ff ff       	jmp    80100a2f <exec+0x5f>
80100b62:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80100b68:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80100b6e:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
  iunlockput(ip);
80100b74:	89 3c 24             	mov    %edi,(%esp)
80100b77:	e8 04 0e 00 00       	call   80101980 <iunlockput>
  end_op();
80100b7c:	e8 7f 21 00 00       	call   80102d00 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b81:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b87:	89 74 24 04          	mov    %esi,0x4(%esp)
80100b8b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100b8f:	89 04 24             	mov    %eax,(%esp)
80100b92:	e8 e9 73 00 00       	call   80107f80 <allocuvm>
80100b97:	85 c0                	test   %eax,%eax
80100b99:	89 c6                	mov    %eax,%esi
80100b9b:	75 33                	jne    80100bd0 <exec+0x200>
    freevm(pgdir);
80100b9d:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ba3:	89 04 24             	mov    %eax,(%esp)
80100ba6:	e8 35 75 00 00       	call   801080e0 <freevm>
  return -1;
80100bab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bb0:	e9 8c fe ff ff       	jmp    80100a41 <exec+0x71>
    end_op();
80100bb5:	e8 46 21 00 00       	call   80102d00 <end_op>
    cprintf("exec: fail\n");
80100bba:	c7 04 24 a1 84 10 80 	movl   $0x801084a1,(%esp)
80100bc1:	e8 8a fa ff ff       	call   80100650 <cprintf>
    return -1;
80100bc6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bcb:	e9 71 fe ff ff       	jmp    80100a41 <exec+0x71>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bd0:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80100bd6:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bd8:	89 44 24 04          	mov    %eax,0x4(%esp)
80100bdc:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  for(argc = 0; argv[argc]; argc++) {
80100be2:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100be4:	89 04 24             	mov    %eax,(%esp)
80100be7:	e8 14 76 00 00       	call   80108200 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100bec:	8b 45 0c             	mov    0xc(%ebp),%eax
80100bef:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100bf5:	8b 00                	mov    (%eax),%eax
80100bf7:	85 c0                	test   %eax,%eax
80100bf9:	74 78                	je     80100c73 <exec+0x2a3>
80100bfb:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100c01:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c07:	eb 0c                	jmp    80100c15 <exec+0x245>
80100c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100c10:	83 ff 20             	cmp    $0x20,%edi
80100c13:	74 88                	je     80100b9d <exec+0x1cd>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c15:	89 04 24             	mov    %eax,(%esp)
80100c18:	e8 73 4e 00 00       	call   80105a90 <strlen>
80100c1d:	f7 d0                	not    %eax
80100c1f:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c21:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c24:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c27:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c2a:	89 04 24             	mov    %eax,(%esp)
80100c2d:	e8 5e 4e 00 00       	call   80105a90 <strlen>
80100c32:	40                   	inc    %eax
80100c33:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c37:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c3a:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c3d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100c41:	89 34 24             	mov    %esi,(%esp)
80100c44:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c48:	e8 23 77 00 00       	call   80108370 <copyout>
80100c4d:	85 c0                	test   %eax,%eax
80100c4f:	0f 88 48 ff ff ff    	js     80100b9d <exec+0x1cd>
  for(argc = 0; argv[argc]; argc++) {
80100c55:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c58:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c5e:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c65:	47                   	inc    %edi
80100c66:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c69:	85 c0                	test   %eax,%eax
80100c6b:	75 a3                	jne    80100c10 <exec+0x240>
80100c6d:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[3+argc] = 0;
80100c73:	31 c0                	xor    %eax,%eax
  ustack[0] = 0xffffffff;  // fake return PC
80100c75:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  ustack[3+argc] = 0;
80100c7a:	89 84 bd 64 ff ff ff 	mov    %eax,-0x9c(%ebp,%edi,4)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c81:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
  ustack[0] = 0xffffffff;  // fake return PC
80100c88:	89 8d 58 ff ff ff    	mov    %ecx,-0xa8(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c8e:	89 d9                	mov    %ebx,%ecx
80100c90:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100c92:	83 c0 0c             	add    $0xc,%eax
80100c95:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c97:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c9b:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ca1:	89 54 24 08          	mov    %edx,0x8(%esp)
80100ca5:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  ustack[1] = argc;
80100ca9:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100caf:	89 04 24             	mov    %eax,(%esp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb2:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cb8:	e8 b3 76 00 00       	call   80108370 <copyout>
80100cbd:	85 c0                	test   %eax,%eax
80100cbf:	0f 88 d8 fe ff ff    	js     80100b9d <exec+0x1cd>
  for(last=s=path; *s; s++)
80100cc5:	8b 45 08             	mov    0x8(%ebp),%eax
80100cc8:	0f b6 00             	movzbl (%eax),%eax
80100ccb:	84 c0                	test   %al,%al
80100ccd:	74 15                	je     80100ce4 <exec+0x314>
80100ccf:	8b 55 08             	mov    0x8(%ebp),%edx
80100cd2:	89 d1                	mov    %edx,%ecx
80100cd4:	41                   	inc    %ecx
80100cd5:	3c 2f                	cmp    $0x2f,%al
80100cd7:	0f b6 01             	movzbl (%ecx),%eax
80100cda:	0f 44 d1             	cmove  %ecx,%edx
80100cdd:	84 c0                	test   %al,%al
80100cdf:	75 f3                	jne    80100cd4 <exec+0x304>
80100ce1:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100ce4:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cea:	8b 45 08             	mov    0x8(%ebp),%eax
80100ced:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80100cf4:	00 
80100cf5:	89 44 24 04          	mov    %eax,0x4(%esp)
80100cf9:	89 f8                	mov    %edi,%eax
80100cfb:	83 c0 6c             	add    $0x6c,%eax
80100cfe:	89 04 24             	mov    %eax,(%esp)
80100d01:	e8 4a 4d 00 00       	call   80105a50 <safestrcpy>
  curproc->pgdir = pgdir;
80100d06:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  oldpgdir = curproc->pgdir;
80100d0c:	89 f9                	mov    %edi,%ecx
80100d0e:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80100d11:	89 31                	mov    %esi,(%ecx)
  curproc->tf->eip = elf.entry;  // main
80100d13:	8b 41 18             	mov    0x18(%ecx),%eax
  curproc->pgdir = pgdir;
80100d16:	89 51 04             	mov    %edx,0x4(%ecx)
  curproc->tf->eip = elf.entry;  // main
80100d19:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d1f:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d22:	8b 41 18             	mov    0x18(%ecx),%eax
80100d25:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d28:	89 0c 24             	mov    %ecx,(%esp)
80100d2b:	e8 00 70 00 00       	call   80107d30 <switchuvm>
  freevm(oldpgdir);
80100d30:	89 3c 24             	mov    %edi,(%esp)
80100d33:	e8 a8 73 00 00       	call   801080e0 <freevm>
  return 0;
80100d38:	31 c0                	xor    %eax,%eax
80100d3a:	e9 02 fd ff ff       	jmp    80100a41 <exec+0x71>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d3f:	bb 00 20 00 00       	mov    $0x2000,%ebx
80100d44:	e9 2b fe ff ff       	jmp    80100b74 <exec+0x1a4>
80100d49:	66 90                	xchg   %ax,%ax
80100d4b:	66 90                	xchg   %ax,%ax
80100d4d:	66 90                	xchg   %ax,%ax
80100d4f:	90                   	nop

80100d50 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d50:	55                   	push   %ebp
  initlock(&ftable.lock, "ftable");
80100d51:	b8 ad 84 10 80       	mov    $0x801084ad,%eax
{
80100d56:	89 e5                	mov    %esp,%ebp
80100d58:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100d5b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100d5f:	c7 04 24 20 10 11 80 	movl   $0x80111020,(%esp)
80100d66:	e8 c5 48 00 00       	call   80105630 <initlock>
}
80100d6b:	c9                   	leave  
80100d6c:	c3                   	ret    
80100d6d:	8d 76 00             	lea    0x0(%esi),%esi

80100d70 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d70:	55                   	push   %ebp
80100d71:	89 e5                	mov    %esp,%ebp
80100d73:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d74:	bb 54 10 11 80       	mov    $0x80111054,%ebx
{
80100d79:	83 ec 14             	sub    $0x14,%esp
  acquire(&ftable.lock);
80100d7c:	c7 04 24 20 10 11 80 	movl   $0x80111020,(%esp)
80100d83:	e8 f8 49 00 00       	call   80105780 <acquire>
80100d88:	eb 11                	jmp    80100d9b <filealloc+0x2b>
80100d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d90:	83 c3 18             	add    $0x18,%ebx
80100d93:	81 fb b4 19 11 80    	cmp    $0x801119b4,%ebx
80100d99:	73 25                	jae    80100dc0 <filealloc+0x50>
    if(f->ref == 0){
80100d9b:	8b 43 04             	mov    0x4(%ebx),%eax
80100d9e:	85 c0                	test   %eax,%eax
80100da0:	75 ee                	jne    80100d90 <filealloc+0x20>
      f->ref = 1;
80100da2:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100da9:	c7 04 24 20 10 11 80 	movl   $0x80111020,(%esp)
80100db0:	e8 6b 4a 00 00       	call   80105820 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100db5:	83 c4 14             	add    $0x14,%esp
80100db8:	89 d8                	mov    %ebx,%eax
80100dba:	5b                   	pop    %ebx
80100dbb:	5d                   	pop    %ebp
80100dbc:	c3                   	ret    
80100dbd:	8d 76 00             	lea    0x0(%esi),%esi
  release(&ftable.lock);
80100dc0:	c7 04 24 20 10 11 80 	movl   $0x80111020,(%esp)
  return 0;
80100dc7:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100dc9:	e8 52 4a 00 00       	call   80105820 <release>
}
80100dce:	83 c4 14             	add    $0x14,%esp
80100dd1:	89 d8                	mov    %ebx,%eax
80100dd3:	5b                   	pop    %ebx
80100dd4:	5d                   	pop    %ebp
80100dd5:	c3                   	ret    
80100dd6:	8d 76 00             	lea    0x0(%esi),%esi
80100dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100de0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100de0:	55                   	push   %ebp
80100de1:	89 e5                	mov    %esp,%ebp
80100de3:	53                   	push   %ebx
80100de4:	83 ec 14             	sub    $0x14,%esp
80100de7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dea:	c7 04 24 20 10 11 80 	movl   $0x80111020,(%esp)
80100df1:	e8 8a 49 00 00       	call   80105780 <acquire>
  if(f->ref < 1)
80100df6:	8b 43 04             	mov    0x4(%ebx),%eax
80100df9:	85 c0                	test   %eax,%eax
80100dfb:	7e 18                	jle    80100e15 <filedup+0x35>
    panic("filedup");
  f->ref++;
80100dfd:	40                   	inc    %eax
80100dfe:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e01:	c7 04 24 20 10 11 80 	movl   $0x80111020,(%esp)
80100e08:	e8 13 4a 00 00       	call   80105820 <release>
  return f;
}
80100e0d:	83 c4 14             	add    $0x14,%esp
80100e10:	89 d8                	mov    %ebx,%eax
80100e12:	5b                   	pop    %ebx
80100e13:	5d                   	pop    %ebp
80100e14:	c3                   	ret    
    panic("filedup");
80100e15:	c7 04 24 b4 84 10 80 	movl   $0x801084b4,(%esp)
80100e1c:	e8 4f f5 ff ff       	call   80100370 <panic>
80100e21:	eb 0d                	jmp    80100e30 <fileclose>
80100e23:	90                   	nop
80100e24:	90                   	nop
80100e25:	90                   	nop
80100e26:	90                   	nop
80100e27:	90                   	nop
80100e28:	90                   	nop
80100e29:	90                   	nop
80100e2a:	90                   	nop
80100e2b:	90                   	nop
80100e2c:	90                   	nop
80100e2d:	90                   	nop
80100e2e:	90                   	nop
80100e2f:	90                   	nop

80100e30 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	83 ec 38             	sub    $0x38,%esp
80100e36:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80100e39:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100e3c:	c7 04 24 20 10 11 80 	movl   $0x80111020,(%esp)
{
80100e43:	89 75 f8             	mov    %esi,-0x8(%ebp)
80100e46:	89 7d fc             	mov    %edi,-0x4(%ebp)
  acquire(&ftable.lock);
80100e49:	e8 32 49 00 00       	call   80105780 <acquire>
  if(f->ref < 1)
80100e4e:	8b 43 04             	mov    0x4(%ebx),%eax
80100e51:	85 c0                	test   %eax,%eax
80100e53:	0f 8e a0 00 00 00    	jle    80100ef9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80100e59:	48                   	dec    %eax
80100e5a:	85 c0                	test   %eax,%eax
80100e5c:	89 43 04             	mov    %eax,0x4(%ebx)
80100e5f:	74 1f                	je     80100e80 <fileclose+0x50>
    release(&ftable.lock);
80100e61:	c7 45 08 20 10 11 80 	movl   $0x80111020,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e68:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100e6b:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100e6e:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100e71:	89 ec                	mov    %ebp,%esp
80100e73:	5d                   	pop    %ebp
    release(&ftable.lock);
80100e74:	e9 a7 49 00 00       	jmp    80105820 <release>
80100e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100e80:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100e84:	8b 3b                	mov    (%ebx),%edi
80100e86:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100e89:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100e8f:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e92:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100e95:	c7 04 24 20 10 11 80 	movl   $0x80111020,(%esp)
  ff = *f;
80100e9c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100e9f:	e8 7c 49 00 00       	call   80105820 <release>
  if(ff.type == FD_PIPE)
80100ea4:	83 ff 01             	cmp    $0x1,%edi
80100ea7:	74 17                	je     80100ec0 <fileclose+0x90>
  else if(ff.type == FD_INODE){
80100ea9:	83 ff 02             	cmp    $0x2,%edi
80100eac:	74 2a                	je     80100ed8 <fileclose+0xa8>
}
80100eae:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100eb1:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100eb4:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100eb7:	89 ec                	mov    %ebp,%esp
80100eb9:	5d                   	pop    %ebp
80100eba:	c3                   	ret    
80100ebb:	90                   	nop
80100ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pipeclose(ff.pipe, ff.writable);
80100ec0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100ec4:	89 34 24             	mov    %esi,(%esp)
80100ec7:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100ecb:	e8 f0 25 00 00       	call   801034c0 <pipeclose>
80100ed0:	eb dc                	jmp    80100eae <fileclose+0x7e>
80100ed2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    begin_op();
80100ed8:	e8 b3 1d 00 00       	call   80102c90 <begin_op>
    iput(ff.ip);
80100edd:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ee0:	89 04 24             	mov    %eax,(%esp)
80100ee3:	e8 38 09 00 00       	call   80101820 <iput>
}
80100ee8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100eeb:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100eee:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100ef1:	89 ec                	mov    %ebp,%esp
80100ef3:	5d                   	pop    %ebp
    end_op();
80100ef4:	e9 07 1e 00 00       	jmp    80102d00 <end_op>
    panic("fileclose");
80100ef9:	c7 04 24 bc 84 10 80 	movl   $0x801084bc,(%esp)
80100f00:	e8 6b f4 ff ff       	call   80100370 <panic>
80100f05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f10 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	53                   	push   %ebx
80100f14:	83 ec 14             	sub    $0x14,%esp
80100f17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f1a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f1d:	75 31                	jne    80100f50 <filestat+0x40>
    ilock(f->ip);
80100f1f:	8b 43 10             	mov    0x10(%ebx),%eax
80100f22:	89 04 24             	mov    %eax,(%esp)
80100f25:	e8 c6 07 00 00       	call   801016f0 <ilock>
    stati(f->ip, st);
80100f2a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f2d:	89 44 24 04          	mov    %eax,0x4(%esp)
80100f31:	8b 43 10             	mov    0x10(%ebx),%eax
80100f34:	89 04 24             	mov    %eax,(%esp)
80100f37:	e8 64 0a 00 00       	call   801019a0 <stati>
    iunlock(f->ip);
80100f3c:	8b 43 10             	mov    0x10(%ebx),%eax
80100f3f:	89 04 24             	mov    %eax,(%esp)
80100f42:	e8 89 08 00 00       	call   801017d0 <iunlock>
    return 0;
80100f47:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f49:	83 c4 14             	add    $0x14,%esp
80100f4c:	5b                   	pop    %ebx
80100f4d:	5d                   	pop    %ebp
80100f4e:	c3                   	ret    
80100f4f:	90                   	nop
  return -1;
80100f50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f55:	eb f2                	jmp    80100f49 <filestat+0x39>
80100f57:	89 f6                	mov    %esi,%esi
80100f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f60 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f60:	55                   	push   %ebp
80100f61:	89 e5                	mov    %esp,%ebp
80100f63:	83 ec 38             	sub    $0x38,%esp
80100f66:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80100f69:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f6c:	89 75 f8             	mov    %esi,-0x8(%ebp)
80100f6f:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f72:	89 7d fc             	mov    %edi,-0x4(%ebp)
80100f75:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f78:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f7c:	74 72                	je     80100ff0 <fileread+0x90>
    return -1;
  if(f->type == FD_PIPE)
80100f7e:	8b 03                	mov    (%ebx),%eax
80100f80:	83 f8 01             	cmp    $0x1,%eax
80100f83:	74 53                	je     80100fd8 <fileread+0x78>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f85:	83 f8 02             	cmp    $0x2,%eax
80100f88:	75 6d                	jne    80100ff7 <fileread+0x97>
    ilock(f->ip);
80100f8a:	8b 43 10             	mov    0x10(%ebx),%eax
80100f8d:	89 04 24             	mov    %eax,(%esp)
80100f90:	e8 5b 07 00 00       	call   801016f0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f95:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80100f99:	8b 43 14             	mov    0x14(%ebx),%eax
80100f9c:	89 74 24 04          	mov    %esi,0x4(%esp)
80100fa0:	89 44 24 08          	mov    %eax,0x8(%esp)
80100fa4:	8b 43 10             	mov    0x10(%ebx),%eax
80100fa7:	89 04 24             	mov    %eax,(%esp)
80100faa:	e8 21 0a 00 00       	call   801019d0 <readi>
80100faf:	85 c0                	test   %eax,%eax
80100fb1:	7e 03                	jle    80100fb6 <fileread+0x56>
      f->off += r;
80100fb3:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100fb6:	8b 53 10             	mov    0x10(%ebx),%edx
80100fb9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100fbc:	89 14 24             	mov    %edx,(%esp)
80100fbf:	e8 0c 08 00 00       	call   801017d0 <iunlock>
    return r;
80100fc4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }
  panic("fileread");
}
80100fc7:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100fca:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100fcd:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100fd0:	89 ec                	mov    %ebp,%esp
80100fd2:	5d                   	pop    %ebp
80100fd3:	c3                   	ret    
80100fd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return piperead(f->pipe, addr, n);
80100fd8:	8b 43 0c             	mov    0xc(%ebx),%eax
}
80100fdb:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100fde:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100fe1:	8b 7d fc             	mov    -0x4(%ebp),%edi
    return piperead(f->pipe, addr, n);
80100fe4:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100fe7:	89 ec                	mov    %ebp,%esp
80100fe9:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100fea:	e9 81 26 00 00       	jmp    80103670 <piperead>
80100fef:	90                   	nop
    return -1;
80100ff0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100ff5:	eb d0                	jmp    80100fc7 <fileread+0x67>
  panic("fileread");
80100ff7:	c7 04 24 c6 84 10 80 	movl   $0x801084c6,(%esp)
80100ffe:	e8 6d f3 ff ff       	call   80100370 <panic>
80101003:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101010 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101010:	55                   	push   %ebp
80101011:	89 e5                	mov    %esp,%ebp
80101013:	57                   	push   %edi
80101014:	56                   	push   %esi
80101015:	53                   	push   %ebx
80101016:	83 ec 2c             	sub    $0x2c,%esp
80101019:	8b 45 0c             	mov    0xc(%ebp),%eax
8010101c:	8b 7d 08             	mov    0x8(%ebp),%edi
8010101f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101022:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101025:	80 7f 09 00          	cmpb   $0x0,0x9(%edi)
{
80101029:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010102c:	0f 84 ae 00 00 00    	je     801010e0 <filewrite+0xd0>
    return -1;
  if(f->type == FD_PIPE)
80101032:	8b 07                	mov    (%edi),%eax
80101034:	83 f8 01             	cmp    $0x1,%eax
80101037:	0f 84 c3 00 00 00    	je     80101100 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010103d:	83 f8 02             	cmp    $0x2,%eax
80101040:	0f 85 d8 00 00 00    	jne    8010111e <filewrite+0x10e>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101046:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101049:	31 f6                	xor    %esi,%esi
    while(i < n){
8010104b:	85 c0                	test   %eax,%eax
8010104d:	7f 31                	jg     80101080 <filewrite+0x70>
8010104f:	e9 9c 00 00 00       	jmp    801010f0 <filewrite+0xe0>
80101054:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
      iunlock(f->ip);
80101058:	8b 4f 10             	mov    0x10(%edi),%ecx
        f->off += r;
8010105b:	01 47 14             	add    %eax,0x14(%edi)
8010105e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101061:	89 0c 24             	mov    %ecx,(%esp)
80101064:	e8 67 07 00 00       	call   801017d0 <iunlock>
      end_op();
80101069:	e8 92 1c 00 00       	call   80102d00 <end_op>
8010106e:	8b 45 e0             	mov    -0x20(%ebp),%eax

      if(r < 0)
        break;
      if(r != n1)
80101071:	39 c3                	cmp    %eax,%ebx
80101073:	0f 85 99 00 00 00    	jne    80101112 <filewrite+0x102>
        panic("short filewrite");
      i += r;
80101079:	01 de                	add    %ebx,%esi
    while(i < n){
8010107b:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010107e:	7e 70                	jle    801010f0 <filewrite+0xe0>
      int n1 = n - i;
80101080:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101083:	b8 00 06 00 00       	mov    $0x600,%eax
80101088:	29 f3                	sub    %esi,%ebx
8010108a:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101090:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101093:	e8 f8 1b 00 00       	call   80102c90 <begin_op>
      ilock(f->ip);
80101098:	8b 47 10             	mov    0x10(%edi),%eax
8010109b:	89 04 24             	mov    %eax,(%esp)
8010109e:	e8 4d 06 00 00       	call   801016f0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801010a3:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
801010a7:	8b 47 14             	mov    0x14(%edi),%eax
801010aa:	89 44 24 08          	mov    %eax,0x8(%esp)
801010ae:	8b 45 dc             	mov    -0x24(%ebp),%eax
801010b1:	01 f0                	add    %esi,%eax
801010b3:	89 44 24 04          	mov    %eax,0x4(%esp)
801010b7:	8b 47 10             	mov    0x10(%edi),%eax
801010ba:	89 04 24             	mov    %eax,(%esp)
801010bd:	e8 2e 0a 00 00       	call   80101af0 <writei>
801010c2:	85 c0                	test   %eax,%eax
801010c4:	7f 92                	jg     80101058 <filewrite+0x48>
      iunlock(f->ip);
801010c6:	8b 4f 10             	mov    0x10(%edi),%ecx
801010c9:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010cc:	89 0c 24             	mov    %ecx,(%esp)
801010cf:	e8 fc 06 00 00       	call   801017d0 <iunlock>
      end_op();
801010d4:	e8 27 1c 00 00       	call   80102d00 <end_op>
      if(r < 0)
801010d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010dc:	85 c0                	test   %eax,%eax
801010de:	74 91                	je     80101071 <filewrite+0x61>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010e0:	83 c4 2c             	add    $0x2c,%esp
    return -1;
801010e3:	be ff ff ff ff       	mov    $0xffffffff,%esi
}
801010e8:	5b                   	pop    %ebx
801010e9:	89 f0                	mov    %esi,%eax
801010eb:	5e                   	pop    %esi
801010ec:	5f                   	pop    %edi
801010ed:	5d                   	pop    %ebp
801010ee:	c3                   	ret    
801010ef:	90                   	nop
    return i == n ? n : -1;
801010f0:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
801010f3:	75 eb                	jne    801010e0 <filewrite+0xd0>
}
801010f5:	83 c4 2c             	add    $0x2c,%esp
801010f8:	89 f0                	mov    %esi,%eax
801010fa:	5b                   	pop    %ebx
801010fb:	5e                   	pop    %esi
801010fc:	5f                   	pop    %edi
801010fd:	5d                   	pop    %ebp
801010fe:	c3                   	ret    
801010ff:	90                   	nop
    return pipewrite(f->pipe, addr, n);
80101100:	8b 47 0c             	mov    0xc(%edi),%eax
80101103:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101106:	83 c4 2c             	add    $0x2c,%esp
80101109:	5b                   	pop    %ebx
8010110a:	5e                   	pop    %esi
8010110b:	5f                   	pop    %edi
8010110c:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
8010110d:	e9 4e 24 00 00       	jmp    80103560 <pipewrite>
        panic("short filewrite");
80101112:	c7 04 24 cf 84 10 80 	movl   $0x801084cf,(%esp)
80101119:	e8 52 f2 ff ff       	call   80100370 <panic>
  panic("filewrite");
8010111e:	c7 04 24 d5 84 10 80 	movl   $0x801084d5,(%esp)
80101125:	e8 46 f2 ff ff       	call   80100370 <panic>
8010112a:	66 90                	xchg   %ax,%ax
8010112c:	66 90                	xchg   %ax,%ax
8010112e:	66 90                	xchg   %ax,%ax

80101130 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101130:	55                   	push   %ebp
80101131:	89 e5                	mov    %esp,%ebp
80101133:	57                   	push   %edi
80101134:	56                   	push   %esi
80101135:	53                   	push   %ebx
80101136:	83 ec 2c             	sub    $0x2c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101139:	8b 35 20 1a 11 80    	mov    0x80111a20,%esi
{
8010113f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101142:	85 f6                	test   %esi,%esi
80101144:	0f 84 7e 00 00 00    	je     801011c8 <balloc+0x98>
8010114a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101151:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101154:	8b 1d 38 1a 11 80    	mov    0x80111a38,%ebx
8010115a:	89 f0                	mov    %esi,%eax
8010115c:	c1 f8 0c             	sar    $0xc,%eax
8010115f:	01 d8                	add    %ebx,%eax
80101161:	89 44 24 04          	mov    %eax,0x4(%esp)
80101165:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101168:	89 04 24             	mov    %eax,(%esp)
8010116b:	e8 60 ef ff ff       	call   801000d0 <bread>
80101170:	89 c3                	mov    %eax,%ebx
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101172:	a1 20 1a 11 80       	mov    0x80111a20,%eax
80101177:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010117a:	31 c0                	xor    %eax,%eax
8010117c:	eb 2b                	jmp    801011a9 <balloc+0x79>
8010117e:	66 90                	xchg   %ax,%ax
      m = 1 << (bi % 8);
80101180:	89 c1                	mov    %eax,%ecx
80101182:	bf 01 00 00 00       	mov    $0x1,%edi
80101187:	83 e1 07             	and    $0x7,%ecx
8010118a:	d3 e7                	shl    %cl,%edi
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010118c:	89 c1                	mov    %eax,%ecx
8010118e:	c1 f9 03             	sar    $0x3,%ecx
      m = 1 << (bi % 8);
80101191:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101194:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
80101199:	85 7d e4             	test   %edi,-0x1c(%ebp)
8010119c:	89 fa                	mov    %edi,%edx
8010119e:	74 38                	je     801011d8 <balloc+0xa8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011a0:	40                   	inc    %eax
801011a1:	46                   	inc    %esi
801011a2:	3d 00 10 00 00       	cmp    $0x1000,%eax
801011a7:	74 05                	je     801011ae <balloc+0x7e>
801011a9:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801011ac:	77 d2                	ja     80101180 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801011ae:	89 1c 24             	mov    %ebx,(%esp)
801011b1:	e8 2a f0 ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801011b6:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801011bd:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011c0:	39 05 20 1a 11 80    	cmp    %eax,0x80111a20
801011c6:	77 89                	ja     80101151 <balloc+0x21>
  }
  panic("balloc: out of blocks");
801011c8:	c7 04 24 df 84 10 80 	movl   $0x801084df,(%esp)
801011cf:	e8 9c f1 ff ff       	call   80100370 <panic>
801011d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
801011d8:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
801011dc:	08 c2                	or     %al,%dl
801011de:	88 54 0b 5c          	mov    %dl,0x5c(%ebx,%ecx,1)
        log_write(bp);
801011e2:	89 1c 24             	mov    %ebx,(%esp)
801011e5:	e8 46 1c 00 00       	call   80102e30 <log_write>
        brelse(bp);
801011ea:	89 1c 24             	mov    %ebx,(%esp)
801011ed:	e8 ee ef ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
801011f2:	8b 45 d8             	mov    -0x28(%ebp),%eax
801011f5:	89 74 24 04          	mov    %esi,0x4(%esp)
801011f9:	89 04 24             	mov    %eax,(%esp)
801011fc:	e8 cf ee ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101201:	ba 00 02 00 00       	mov    $0x200,%edx
80101206:	31 c9                	xor    %ecx,%ecx
80101208:	89 54 24 08          	mov    %edx,0x8(%esp)
8010120c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  bp = bread(dev, bno);
80101210:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101212:	8d 40 5c             	lea    0x5c(%eax),%eax
80101215:	89 04 24             	mov    %eax,(%esp)
80101218:	e8 53 46 00 00       	call   80105870 <memset>
  log_write(bp);
8010121d:	89 1c 24             	mov    %ebx,(%esp)
80101220:	e8 0b 1c 00 00       	call   80102e30 <log_write>
  brelse(bp);
80101225:	89 1c 24             	mov    %ebx,(%esp)
80101228:	e8 b3 ef ff ff       	call   801001e0 <brelse>
}
8010122d:	83 c4 2c             	add    $0x2c,%esp
80101230:	89 f0                	mov    %esi,%eax
80101232:	5b                   	pop    %ebx
80101233:	5e                   	pop    %esi
80101234:	5f                   	pop    %edi
80101235:	5d                   	pop    %ebp
80101236:	c3                   	ret    
80101237:	89 f6                	mov    %esi,%esi
80101239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101240 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101240:	55                   	push   %ebp
80101241:	89 e5                	mov    %esp,%ebp
80101243:	57                   	push   %edi
80101244:	89 c7                	mov    %eax,%edi
80101246:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101247:	31 f6                	xor    %esi,%esi
{
80101249:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010124a:	bb 74 1a 11 80       	mov    $0x80111a74,%ebx
{
8010124f:	83 ec 2c             	sub    $0x2c,%esp
  acquire(&icache.lock);
80101252:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
{
80101259:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
8010125c:	e8 1f 45 00 00       	call   80105780 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101261:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101264:	eb 18                	jmp    8010127e <iget+0x3e>
80101266:	8d 76 00             	lea    0x0(%esi),%esi
80101269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101270:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101276:	81 fb 94 36 11 80    	cmp    $0x80113694,%ebx
8010127c:	73 22                	jae    801012a0 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010127e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101281:	85 c9                	test   %ecx,%ecx
80101283:	7e 04                	jle    80101289 <iget+0x49>
80101285:	39 3b                	cmp    %edi,(%ebx)
80101287:	74 47                	je     801012d0 <iget+0x90>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101289:	85 f6                	test   %esi,%esi
8010128b:	75 e3                	jne    80101270 <iget+0x30>
8010128d:	85 c9                	test   %ecx,%ecx
8010128f:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101292:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101298:	81 fb 94 36 11 80    	cmp    $0x80113694,%ebx
8010129e:	72 de                	jb     8010127e <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801012a0:	85 f6                	test   %esi,%esi
801012a2:	74 4d                	je     801012f1 <iget+0xb1>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
801012a4:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801012a6:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801012a9:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801012b0:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801012b7:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
801012be:	e8 5d 45 00 00       	call   80105820 <release>

  return ip;
}
801012c3:	83 c4 2c             	add    $0x2c,%esp
801012c6:	89 f0                	mov    %esi,%eax
801012c8:	5b                   	pop    %ebx
801012c9:	5e                   	pop    %esi
801012ca:	5f                   	pop    %edi
801012cb:	5d                   	pop    %ebp
801012cc:	c3                   	ret    
801012cd:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012d0:	39 53 04             	cmp    %edx,0x4(%ebx)
801012d3:	75 b4                	jne    80101289 <iget+0x49>
      ip->ref++;
801012d5:	41                   	inc    %ecx
      return ip;
801012d6:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801012d8:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
      ip->ref++;
801012df:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801012e2:	e8 39 45 00 00       	call   80105820 <release>
}
801012e7:	83 c4 2c             	add    $0x2c,%esp
801012ea:	89 f0                	mov    %esi,%eax
801012ec:	5b                   	pop    %ebx
801012ed:	5e                   	pop    %esi
801012ee:	5f                   	pop    %edi
801012ef:	5d                   	pop    %ebp
801012f0:	c3                   	ret    
    panic("iget: no inodes");
801012f1:	c7 04 24 f5 84 10 80 	movl   $0x801084f5,(%esp)
801012f8:	e8 73 f0 ff ff       	call   80100370 <panic>
801012fd:	8d 76 00             	lea    0x0(%esi),%esi

80101300 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101300:	55                   	push   %ebp
80101301:	89 e5                	mov    %esp,%ebp
80101303:	83 ec 38             	sub    $0x38,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101306:	83 fa 0b             	cmp    $0xb,%edx
{
80101309:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010130c:	89 c6                	mov    %eax,%esi
8010130e:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80101311:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(bn < NDIRECT){
80101314:	77 1a                	ja     80101330 <bmap+0x30>
80101316:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
80101319:	8b 5f 5c             	mov    0x5c(%edi),%ebx
8010131c:	85 db                	test   %ebx,%ebx
8010131e:	74 70                	je     80101390 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
80101320:	89 d8                	mov    %ebx,%eax
80101322:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101325:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101328:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010132b:	89 ec                	mov    %ebp,%esp
8010132d:	5d                   	pop    %ebp
8010132e:	c3                   	ret    
8010132f:	90                   	nop
  bn -= NDIRECT;
80101330:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
80101333:	83 fb 7f             	cmp    $0x7f,%ebx
80101336:	0f 87 85 00 00 00    	ja     801013c1 <bmap+0xc1>
    if((addr = ip->addrs[NDIRECT]) == 0)
8010133c:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
80101342:	8b 00                	mov    (%eax),%eax
80101344:	85 d2                	test   %edx,%edx
80101346:	74 68                	je     801013b0 <bmap+0xb0>
    bp = bread(ip->dev, addr);
80101348:	89 54 24 04          	mov    %edx,0x4(%esp)
8010134c:	89 04 24             	mov    %eax,(%esp)
8010134f:	e8 7c ed ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
80101354:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
    bp = bread(ip->dev, addr);
80101358:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
8010135a:	8b 1a                	mov    (%edx),%ebx
8010135c:	85 db                	test   %ebx,%ebx
8010135e:	75 19                	jne    80101379 <bmap+0x79>
      a[bn] = addr = balloc(ip->dev);
80101360:	8b 06                	mov    (%esi),%eax
80101362:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101365:	e8 c6 fd ff ff       	call   80101130 <balloc>
8010136a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010136d:	89 02                	mov    %eax,(%edx)
8010136f:	89 c3                	mov    %eax,%ebx
      log_write(bp);
80101371:	89 3c 24             	mov    %edi,(%esp)
80101374:	e8 b7 1a 00 00       	call   80102e30 <log_write>
    brelse(bp);
80101379:	89 3c 24             	mov    %edi,(%esp)
8010137c:	e8 5f ee ff ff       	call   801001e0 <brelse>
}
80101381:	89 d8                	mov    %ebx,%eax
80101383:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101386:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101389:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010138c:	89 ec                	mov    %ebp,%esp
8010138e:	5d                   	pop    %ebp
8010138f:	c3                   	ret    
      ip->addrs[bn] = addr = balloc(ip->dev);
80101390:	8b 00                	mov    (%eax),%eax
80101392:	e8 99 fd ff ff       	call   80101130 <balloc>
80101397:	89 47 5c             	mov    %eax,0x5c(%edi)
8010139a:	89 c3                	mov    %eax,%ebx
}
8010139c:	89 d8                	mov    %ebx,%eax
8010139e:	8b 75 f8             	mov    -0x8(%ebp),%esi
801013a1:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801013a4:	8b 7d fc             	mov    -0x4(%ebp),%edi
801013a7:	89 ec                	mov    %ebp,%esp
801013a9:	5d                   	pop    %ebp
801013aa:	c3                   	ret    
801013ab:	90                   	nop
801013ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801013b0:	e8 7b fd ff ff       	call   80101130 <balloc>
801013b5:	89 c2                	mov    %eax,%edx
801013b7:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801013bd:	8b 06                	mov    (%esi),%eax
801013bf:	eb 87                	jmp    80101348 <bmap+0x48>
  panic("bmap: out of range");
801013c1:	c7 04 24 05 85 10 80 	movl   $0x80108505,(%esp)
801013c8:	e8 a3 ef ff ff       	call   80100370 <panic>
801013cd:	8d 76 00             	lea    0x0(%esi),%esi

801013d0 <readsb>:
{
801013d0:	55                   	push   %ebp
  bp = bread(dev, 1);
801013d1:	b8 01 00 00 00       	mov    $0x1,%eax
{
801013d6:	89 e5                	mov    %esp,%ebp
801013d8:	83 ec 18             	sub    $0x18,%esp
  bp = bread(dev, 1);
801013db:	89 44 24 04          	mov    %eax,0x4(%esp)
801013df:	8b 45 08             	mov    0x8(%ebp),%eax
{
801013e2:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801013e5:	89 75 fc             	mov    %esi,-0x4(%ebp)
801013e8:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801013eb:	89 04 24             	mov    %eax,(%esp)
801013ee:	e8 dd ec ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801013f3:	ba 1c 00 00 00       	mov    $0x1c,%edx
801013f8:	89 34 24             	mov    %esi,(%esp)
801013fb:	89 54 24 08          	mov    %edx,0x8(%esp)
  bp = bread(dev, 1);
801013ff:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101401:	8d 40 5c             	lea    0x5c(%eax),%eax
80101404:	89 44 24 04          	mov    %eax,0x4(%esp)
80101408:	e8 23 45 00 00       	call   80105930 <memmove>
}
8010140d:	8b 75 fc             	mov    -0x4(%ebp),%esi
  brelse(bp);
80101410:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101413:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80101416:	89 ec                	mov    %ebp,%esp
80101418:	5d                   	pop    %ebp
  brelse(bp);
80101419:	e9 c2 ed ff ff       	jmp    801001e0 <brelse>
8010141e:	66 90                	xchg   %ax,%ax

80101420 <bfree>:
{
80101420:	55                   	push   %ebp
80101421:	89 e5                	mov    %esp,%ebp
80101423:	56                   	push   %esi
80101424:	89 c6                	mov    %eax,%esi
80101426:	53                   	push   %ebx
80101427:	89 d3                	mov    %edx,%ebx
80101429:	83 ec 10             	sub    $0x10,%esp
  readsb(dev, &sb);
8010142c:	ba 20 1a 11 80       	mov    $0x80111a20,%edx
80101431:	89 54 24 04          	mov    %edx,0x4(%esp)
80101435:	89 04 24             	mov    %eax,(%esp)
80101438:	e8 93 ff ff ff       	call   801013d0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
8010143d:	8b 0d 38 1a 11 80    	mov    0x80111a38,%ecx
80101443:	89 da                	mov    %ebx,%edx
80101445:	c1 ea 0c             	shr    $0xc,%edx
80101448:	89 34 24             	mov    %esi,(%esp)
8010144b:	01 ca                	add    %ecx,%edx
8010144d:	89 54 24 04          	mov    %edx,0x4(%esp)
80101451:	e8 7a ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
80101456:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101458:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
8010145b:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
8010145e:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101464:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80101466:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
8010146b:	0f b6 54 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%edx
  m = 1 << (bi % 8);
80101470:	d3 e0                	shl    %cl,%eax
80101472:	89 c1                	mov    %eax,%ecx
  if((bp->data[bi/8] & m) == 0)
80101474:	85 c2                	test   %eax,%edx
80101476:	74 1f                	je     80101497 <bfree+0x77>
  bp->data[bi/8] &= ~m;
80101478:	f6 d1                	not    %cl
8010147a:	20 d1                	and    %dl,%cl
8010147c:	88 4c 1e 5c          	mov    %cl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101480:	89 34 24             	mov    %esi,(%esp)
80101483:	e8 a8 19 00 00       	call   80102e30 <log_write>
  brelse(bp);
80101488:	89 34 24             	mov    %esi,(%esp)
8010148b:	e8 50 ed ff ff       	call   801001e0 <brelse>
}
80101490:	83 c4 10             	add    $0x10,%esp
80101493:	5b                   	pop    %ebx
80101494:	5e                   	pop    %esi
80101495:	5d                   	pop    %ebp
80101496:	c3                   	ret    
    panic("freeing free block");
80101497:	c7 04 24 18 85 10 80 	movl   $0x80108518,(%esp)
8010149e:	e8 cd ee ff ff       	call   80100370 <panic>
801014a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801014a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801014b0 <iinit>:
{
801014b0:	55                   	push   %ebp
  initlock(&icache.lock, "icache");
801014b1:	b9 2b 85 10 80       	mov    $0x8010852b,%ecx
{
801014b6:	89 e5                	mov    %esp,%ebp
801014b8:	53                   	push   %ebx
801014b9:	bb 80 1a 11 80       	mov    $0x80111a80,%ebx
801014be:	83 ec 24             	sub    $0x24,%esp
  initlock(&icache.lock, "icache");
801014c1:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801014c5:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
801014cc:	e8 5f 41 00 00       	call   80105630 <initlock>
801014d1:	eb 0d                	jmp    801014e0 <iinit+0x30>
801014d3:	90                   	nop
801014d4:	90                   	nop
801014d5:	90                   	nop
801014d6:	90                   	nop
801014d7:	90                   	nop
801014d8:	90                   	nop
801014d9:	90                   	nop
801014da:	90                   	nop
801014db:	90                   	nop
801014dc:	90                   	nop
801014dd:	90                   	nop
801014de:	90                   	nop
801014df:	90                   	nop
    initsleeplock(&icache.inode[i].lock, "inode");
801014e0:	ba 32 85 10 80       	mov    $0x80108532,%edx
801014e5:	89 1c 24             	mov    %ebx,(%esp)
801014e8:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014ee:	89 54 24 04          	mov    %edx,0x4(%esp)
801014f2:	e8 09 40 00 00       	call   80105500 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014f7:	81 fb a0 36 11 80    	cmp    $0x801136a0,%ebx
801014fd:	75 e1                	jne    801014e0 <iinit+0x30>
  readsb(dev, &sb);
801014ff:	b8 20 1a 11 80       	mov    $0x80111a20,%eax
80101504:	89 44 24 04          	mov    %eax,0x4(%esp)
80101508:	8b 45 08             	mov    0x8(%ebp),%eax
8010150b:	89 04 24             	mov    %eax,(%esp)
8010150e:	e8 bd fe ff ff       	call   801013d0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101513:	a1 38 1a 11 80       	mov    0x80111a38,%eax
80101518:	c7 04 24 98 85 10 80 	movl   $0x80108598,(%esp)
8010151f:	89 44 24 1c          	mov    %eax,0x1c(%esp)
80101523:	a1 34 1a 11 80       	mov    0x80111a34,%eax
80101528:	89 44 24 18          	mov    %eax,0x18(%esp)
8010152c:	a1 30 1a 11 80       	mov    0x80111a30,%eax
80101531:	89 44 24 14          	mov    %eax,0x14(%esp)
80101535:	a1 2c 1a 11 80       	mov    0x80111a2c,%eax
8010153a:	89 44 24 10          	mov    %eax,0x10(%esp)
8010153e:	a1 28 1a 11 80       	mov    0x80111a28,%eax
80101543:	89 44 24 0c          	mov    %eax,0xc(%esp)
80101547:	a1 24 1a 11 80       	mov    0x80111a24,%eax
8010154c:	89 44 24 08          	mov    %eax,0x8(%esp)
80101550:	a1 20 1a 11 80       	mov    0x80111a20,%eax
80101555:	89 44 24 04          	mov    %eax,0x4(%esp)
80101559:	e8 f2 f0 ff ff       	call   80100650 <cprintf>
}
8010155e:	83 c4 24             	add    $0x24,%esp
80101561:	5b                   	pop    %ebx
80101562:	5d                   	pop    %ebp
80101563:	c3                   	ret    
80101564:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010156a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101570 <ialloc>:
{
80101570:	55                   	push   %ebp
80101571:	89 e5                	mov    %esp,%ebp
80101573:	57                   	push   %edi
80101574:	56                   	push   %esi
80101575:	53                   	push   %ebx
80101576:	83 ec 2c             	sub    $0x2c,%esp
80101579:	0f bf 45 0c          	movswl 0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010157d:	83 3d 28 1a 11 80 01 	cmpl   $0x1,0x80111a28
{
80101584:	8b 75 08             	mov    0x8(%ebp),%esi
80101587:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
8010158a:	0f 86 91 00 00 00    	jbe    80101621 <ialloc+0xb1>
80101590:	bb 01 00 00 00       	mov    $0x1,%ebx
80101595:	eb 1a                	jmp    801015b1 <ialloc+0x41>
80101597:	89 f6                	mov    %esi,%esi
80101599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
801015a0:	89 3c 24             	mov    %edi,(%esp)
  for(inum = 1; inum < sb.ninodes; inum++){
801015a3:	43                   	inc    %ebx
    brelse(bp);
801015a4:	e8 37 ec ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801015a9:	39 1d 28 1a 11 80    	cmp    %ebx,0x80111a28
801015af:	76 70                	jbe    80101621 <ialloc+0xb1>
    bp = bread(dev, IBLOCK(inum, sb));
801015b1:	8b 0d 34 1a 11 80    	mov    0x80111a34,%ecx
801015b7:	89 d8                	mov    %ebx,%eax
801015b9:	c1 e8 03             	shr    $0x3,%eax
801015bc:	89 34 24             	mov    %esi,(%esp)
801015bf:	01 c8                	add    %ecx,%eax
801015c1:	89 44 24 04          	mov    %eax,0x4(%esp)
801015c5:	e8 06 eb ff ff       	call   801000d0 <bread>
801015ca:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
801015cc:	89 d8                	mov    %ebx,%eax
801015ce:	83 e0 07             	and    $0x7,%eax
801015d1:	c1 e0 06             	shl    $0x6,%eax
801015d4:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801015d8:	66 83 39 00          	cmpw   $0x0,(%ecx)
801015dc:	75 c2                	jne    801015a0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801015de:	31 d2                	xor    %edx,%edx
801015e0:	b8 40 00 00 00       	mov    $0x40,%eax
801015e5:	89 54 24 04          	mov    %edx,0x4(%esp)
801015e9:	89 0c 24             	mov    %ecx,(%esp)
801015ec:	89 44 24 08          	mov    %eax,0x8(%esp)
801015f0:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801015f3:	e8 78 42 00 00       	call   80105870 <memset>
      dip->type = type;
801015f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801015fb:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801015fe:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
80101601:	89 3c 24             	mov    %edi,(%esp)
80101604:	e8 27 18 00 00       	call   80102e30 <log_write>
      brelse(bp);
80101609:	89 3c 24             	mov    %edi,(%esp)
8010160c:	e8 cf eb ff ff       	call   801001e0 <brelse>
}
80101611:	83 c4 2c             	add    $0x2c,%esp
      return iget(dev, inum);
80101614:	89 da                	mov    %ebx,%edx
}
80101616:	5b                   	pop    %ebx
      return iget(dev, inum);
80101617:	89 f0                	mov    %esi,%eax
}
80101619:	5e                   	pop    %esi
8010161a:	5f                   	pop    %edi
8010161b:	5d                   	pop    %ebp
      return iget(dev, inum);
8010161c:	e9 1f fc ff ff       	jmp    80101240 <iget>
  panic("ialloc: no inodes");
80101621:	c7 04 24 38 85 10 80 	movl   $0x80108538,(%esp)
80101628:	e8 43 ed ff ff       	call   80100370 <panic>
8010162d:	8d 76 00             	lea    0x0(%esi),%esi

80101630 <iupdate>:
{
80101630:	55                   	push   %ebp
80101631:	89 e5                	mov    %esp,%ebp
80101633:	56                   	push   %esi
80101634:	53                   	push   %ebx
80101635:	83 ec 10             	sub    $0x10,%esp
80101638:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010163b:	8b 15 34 1a 11 80    	mov    0x80111a34,%edx
80101641:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101644:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101647:	c1 e8 03             	shr    $0x3,%eax
8010164a:	01 d0                	add    %edx,%eax
8010164c:	89 44 24 04          	mov    %eax,0x4(%esp)
80101650:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80101653:	89 04 24             	mov    %eax,(%esp)
80101656:	e8 75 ea ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
8010165b:	0f bf 53 f4          	movswl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010165f:	b9 34 00 00 00       	mov    $0x34,%ecx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101664:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101666:	8b 43 a8             	mov    -0x58(%ebx),%eax
80101669:	83 e0 07             	and    $0x7,%eax
8010166c:	c1 e0 06             	shl    $0x6,%eax
8010166f:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101673:	66 89 10             	mov    %dx,(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101676:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101679:	0f bf 53 f6          	movswl -0xa(%ebx),%edx
8010167d:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101681:	0f bf 53 f8          	movswl -0x8(%ebx),%edx
80101685:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
80101689:	0f bf 53 fa          	movswl -0x6(%ebx),%edx
8010168d:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101691:	8b 53 fc             	mov    -0x4(%ebx),%edx
80101694:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101697:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010169b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010169f:	89 04 24             	mov    %eax,(%esp)
801016a2:	e8 89 42 00 00       	call   80105930 <memmove>
  log_write(bp);
801016a7:	89 34 24             	mov    %esi,(%esp)
801016aa:	e8 81 17 00 00       	call   80102e30 <log_write>
  brelse(bp);
801016af:	89 75 08             	mov    %esi,0x8(%ebp)
}
801016b2:	83 c4 10             	add    $0x10,%esp
801016b5:	5b                   	pop    %ebx
801016b6:	5e                   	pop    %esi
801016b7:	5d                   	pop    %ebp
  brelse(bp);
801016b8:	e9 23 eb ff ff       	jmp    801001e0 <brelse>
801016bd:	8d 76 00             	lea    0x0(%esi),%esi

801016c0 <idup>:
{
801016c0:	55                   	push   %ebp
801016c1:	89 e5                	mov    %esp,%ebp
801016c3:	53                   	push   %ebx
801016c4:	83 ec 14             	sub    $0x14,%esp
801016c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801016ca:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
801016d1:	e8 aa 40 00 00       	call   80105780 <acquire>
  ip->ref++;
801016d6:	ff 43 08             	incl   0x8(%ebx)
  release(&icache.lock);
801016d9:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
801016e0:	e8 3b 41 00 00       	call   80105820 <release>
}
801016e5:	83 c4 14             	add    $0x14,%esp
801016e8:	89 d8                	mov    %ebx,%eax
801016ea:	5b                   	pop    %ebx
801016eb:	5d                   	pop    %ebp
801016ec:	c3                   	ret    
801016ed:	8d 76 00             	lea    0x0(%esi),%esi

801016f0 <ilock>:
{
801016f0:	55                   	push   %ebp
801016f1:	89 e5                	mov    %esp,%ebp
801016f3:	56                   	push   %esi
801016f4:	53                   	push   %ebx
801016f5:	83 ec 10             	sub    $0x10,%esp
801016f8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801016fb:	85 db                	test   %ebx,%ebx
801016fd:	0f 84 be 00 00 00    	je     801017c1 <ilock+0xd1>
80101703:	8b 43 08             	mov    0x8(%ebx),%eax
80101706:	85 c0                	test   %eax,%eax
80101708:	0f 8e b3 00 00 00    	jle    801017c1 <ilock+0xd1>
  acquiresleep(&ip->lock);
8010170e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101711:	89 04 24             	mov    %eax,(%esp)
80101714:	e8 27 3e 00 00       	call   80105540 <acquiresleep>
  if(ip->valid == 0){
80101719:	8b 73 4c             	mov    0x4c(%ebx),%esi
8010171c:	85 f6                	test   %esi,%esi
8010171e:	74 10                	je     80101730 <ilock+0x40>
}
80101720:	83 c4 10             	add    $0x10,%esp
80101723:	5b                   	pop    %ebx
80101724:	5e                   	pop    %esi
80101725:	5d                   	pop    %ebp
80101726:	c3                   	ret    
80101727:	89 f6                	mov    %esi,%esi
80101729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101730:	8b 43 04             	mov    0x4(%ebx),%eax
80101733:	8b 15 34 1a 11 80    	mov    0x80111a34,%edx
80101739:	c1 e8 03             	shr    $0x3,%eax
8010173c:	01 d0                	add    %edx,%eax
8010173e:	89 44 24 04          	mov    %eax,0x4(%esp)
80101742:	8b 03                	mov    (%ebx),%eax
80101744:	89 04 24             	mov    %eax,(%esp)
80101747:	e8 84 e9 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010174c:	b9 34 00 00 00       	mov    $0x34,%ecx
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101751:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101753:	8b 43 04             	mov    0x4(%ebx),%eax
80101756:	83 e0 07             	and    $0x7,%eax
80101759:	c1 e0 06             	shl    $0x6,%eax
8010175c:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101760:	0f bf 10             	movswl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101763:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
80101766:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
8010176a:	0f bf 50 f6          	movswl -0xa(%eax),%edx
8010176e:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101772:	0f bf 50 f8          	movswl -0x8(%eax),%edx
80101776:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
8010177a:	0f bf 50 fa          	movswl -0x6(%eax),%edx
8010177e:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101782:	8b 50 fc             	mov    -0x4(%eax),%edx
80101785:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101788:	89 44 24 04          	mov    %eax,0x4(%esp)
8010178c:	8d 43 5c             	lea    0x5c(%ebx),%eax
8010178f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101793:	89 04 24             	mov    %eax,(%esp)
80101796:	e8 95 41 00 00       	call   80105930 <memmove>
    brelse(bp);
8010179b:	89 34 24             	mov    %esi,(%esp)
8010179e:	e8 3d ea ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
801017a3:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
801017a8:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801017af:	0f 85 6b ff ff ff    	jne    80101720 <ilock+0x30>
      panic("ilock: no type");
801017b5:	c7 04 24 50 85 10 80 	movl   $0x80108550,(%esp)
801017bc:	e8 af eb ff ff       	call   80100370 <panic>
    panic("ilock");
801017c1:	c7 04 24 4a 85 10 80 	movl   $0x8010854a,(%esp)
801017c8:	e8 a3 eb ff ff       	call   80100370 <panic>
801017cd:	8d 76 00             	lea    0x0(%esi),%esi

801017d0 <iunlock>:
{
801017d0:	55                   	push   %ebp
801017d1:	89 e5                	mov    %esp,%ebp
801017d3:	83 ec 18             	sub    $0x18,%esp
801017d6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801017d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801017dc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801017df:	85 db                	test   %ebx,%ebx
801017e1:	74 27                	je     8010180a <iunlock+0x3a>
801017e3:	8d 73 0c             	lea    0xc(%ebx),%esi
801017e6:	89 34 24             	mov    %esi,(%esp)
801017e9:	e8 f2 3d 00 00       	call   801055e0 <holdingsleep>
801017ee:	85 c0                	test   %eax,%eax
801017f0:	74 18                	je     8010180a <iunlock+0x3a>
801017f2:	8b 43 08             	mov    0x8(%ebx),%eax
801017f5:	85 c0                	test   %eax,%eax
801017f7:	7e 11                	jle    8010180a <iunlock+0x3a>
  releasesleep(&ip->lock);
801017f9:	89 75 08             	mov    %esi,0x8(%ebp)
}
801017fc:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801017ff:	8b 75 fc             	mov    -0x4(%ebp),%esi
80101802:	89 ec                	mov    %ebp,%esp
80101804:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80101805:	e9 96 3d 00 00       	jmp    801055a0 <releasesleep>
    panic("iunlock");
8010180a:	c7 04 24 5f 85 10 80 	movl   $0x8010855f,(%esp)
80101811:	e8 5a eb ff ff       	call   80100370 <panic>
80101816:	8d 76 00             	lea    0x0(%esi),%esi
80101819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101820 <iput>:
{
80101820:	55                   	push   %ebp
80101821:	89 e5                	mov    %esp,%ebp
80101823:	83 ec 38             	sub    $0x38,%esp
80101826:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80101829:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010182c:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010182f:	89 75 f8             	mov    %esi,-0x8(%ebp)
  acquiresleep(&ip->lock);
80101832:	8d 7b 0c             	lea    0xc(%ebx),%edi
80101835:	89 3c 24             	mov    %edi,(%esp)
80101838:	e8 03 3d 00 00       	call   80105540 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
8010183d:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101840:	85 d2                	test   %edx,%edx
80101842:	74 07                	je     8010184b <iput+0x2b>
80101844:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101849:	74 35                	je     80101880 <iput+0x60>
  releasesleep(&ip->lock);
8010184b:	89 3c 24             	mov    %edi,(%esp)
8010184e:	e8 4d 3d 00 00       	call   801055a0 <releasesleep>
  acquire(&icache.lock);
80101853:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
8010185a:	e8 21 3f 00 00       	call   80105780 <acquire>
  ip->ref--;
8010185f:	ff 4b 08             	decl   0x8(%ebx)
  release(&icache.lock);
80101862:	c7 45 08 40 1a 11 80 	movl   $0x80111a40,0x8(%ebp)
}
80101869:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010186c:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010186f:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101872:	89 ec                	mov    %ebp,%esp
80101874:	5d                   	pop    %ebp
  release(&icache.lock);
80101875:	e9 a6 3f 00 00       	jmp    80105820 <release>
8010187a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101880:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
80101887:	e8 f4 3e 00 00       	call   80105780 <acquire>
    int r = ip->ref;
8010188c:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
8010188f:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
80101896:	e8 85 3f 00 00       	call   80105820 <release>
    if(r == 1){
8010189b:	4e                   	dec    %esi
8010189c:	75 ad                	jne    8010184b <iput+0x2b>
8010189e:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
801018a4:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801018a7:	8d 73 5c             	lea    0x5c(%ebx),%esi
801018aa:	89 cf                	mov    %ecx,%edi
801018ac:	eb 09                	jmp    801018b7 <iput+0x97>
801018ae:	66 90                	xchg   %ax,%ax
801018b0:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801018b3:	39 fe                	cmp    %edi,%esi
801018b5:	74 19                	je     801018d0 <iput+0xb0>
    if(ip->addrs[i]){
801018b7:	8b 16                	mov    (%esi),%edx
801018b9:	85 d2                	test   %edx,%edx
801018bb:	74 f3                	je     801018b0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
801018bd:	8b 03                	mov    (%ebx),%eax
801018bf:	e8 5c fb ff ff       	call   80101420 <bfree>
      ip->addrs[i] = 0;
801018c4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801018ca:	eb e4                	jmp    801018b0 <iput+0x90>
801018cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
801018d0:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
801018d6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801018d9:	85 c0                	test   %eax,%eax
801018db:	75 33                	jne    80101910 <iput+0xf0>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
801018dd:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801018e4:	89 1c 24             	mov    %ebx,(%esp)
801018e7:	e8 44 fd ff ff       	call   80101630 <iupdate>
      ip->type = 0;
801018ec:	66 c7 43 50 00 00    	movw   $0x0,0x50(%ebx)
      iupdate(ip);
801018f2:	89 1c 24             	mov    %ebx,(%esp)
801018f5:	e8 36 fd ff ff       	call   80101630 <iupdate>
      ip->valid = 0;
801018fa:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101901:	e9 45 ff ff ff       	jmp    8010184b <iput+0x2b>
80101906:	8d 76 00             	lea    0x0(%esi),%esi
80101909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101910:	89 44 24 04          	mov    %eax,0x4(%esp)
80101914:	8b 03                	mov    (%ebx),%eax
80101916:	89 04 24             	mov    %eax,(%esp)
80101919:	e8 b2 e7 ff ff       	call   801000d0 <bread>
8010191e:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101921:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101927:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
8010192a:	8d 70 5c             	lea    0x5c(%eax),%esi
8010192d:	89 cf                	mov    %ecx,%edi
8010192f:	eb 0e                	jmp    8010193f <iput+0x11f>
80101931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101938:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
8010193b:	39 fe                	cmp    %edi,%esi
8010193d:	74 0f                	je     8010194e <iput+0x12e>
      if(a[j])
8010193f:	8b 16                	mov    (%esi),%edx
80101941:	85 d2                	test   %edx,%edx
80101943:	74 f3                	je     80101938 <iput+0x118>
        bfree(ip->dev, a[j]);
80101945:	8b 03                	mov    (%ebx),%eax
80101947:	e8 d4 fa ff ff       	call   80101420 <bfree>
8010194c:	eb ea                	jmp    80101938 <iput+0x118>
    brelse(bp);
8010194e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101951:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101954:	89 04 24             	mov    %eax,(%esp)
80101957:	e8 84 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
8010195c:	8b 03                	mov    (%ebx),%eax
8010195e:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101964:	e8 b7 fa ff ff       	call   80101420 <bfree>
    ip->addrs[NDIRECT] = 0;
80101969:	31 c0                	xor    %eax,%eax
8010196b:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
80101971:	e9 67 ff ff ff       	jmp    801018dd <iput+0xbd>
80101976:	8d 76 00             	lea    0x0(%esi),%esi
80101979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101980 <iunlockput>:
{
80101980:	55                   	push   %ebp
80101981:	89 e5                	mov    %esp,%ebp
80101983:	53                   	push   %ebx
80101984:	83 ec 14             	sub    $0x14,%esp
80101987:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010198a:	89 1c 24             	mov    %ebx,(%esp)
8010198d:	e8 3e fe ff ff       	call   801017d0 <iunlock>
  iput(ip);
80101992:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101995:	83 c4 14             	add    $0x14,%esp
80101998:	5b                   	pop    %ebx
80101999:	5d                   	pop    %ebp
  iput(ip);
8010199a:	e9 81 fe ff ff       	jmp    80101820 <iput>
8010199f:	90                   	nop

801019a0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
801019a0:	55                   	push   %ebp
801019a1:	89 e5                	mov    %esp,%ebp
801019a3:	8b 55 08             	mov    0x8(%ebp),%edx
801019a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
801019a9:	8b 0a                	mov    (%edx),%ecx
801019ab:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
801019ae:	8b 4a 04             	mov    0x4(%edx),%ecx
801019b1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
801019b4:	0f bf 4a 50          	movswl 0x50(%edx),%ecx
801019b8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
801019bb:	0f bf 4a 56          	movswl 0x56(%edx),%ecx
801019bf:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
801019c3:	8b 52 58             	mov    0x58(%edx),%edx
801019c6:	89 50 10             	mov    %edx,0x10(%eax)
}
801019c9:	5d                   	pop    %ebp
801019ca:	c3                   	ret    
801019cb:	90                   	nop
801019cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019d0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801019d0:	55                   	push   %ebp
801019d1:	89 e5                	mov    %esp,%ebp
801019d3:	57                   	push   %edi
801019d4:	56                   	push   %esi
801019d5:	53                   	push   %ebx
801019d6:	83 ec 3c             	sub    $0x3c,%esp
801019d9:	8b 45 0c             	mov    0xc(%ebp),%eax
801019dc:	8b 7d 08             	mov    0x8(%ebp),%edi
801019df:	8b 75 10             	mov    0x10(%ebp),%esi
801019e2:	89 45 dc             	mov    %eax,-0x24(%ebp)
801019e5:	8b 45 14             	mov    0x14(%ebp),%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801019e8:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
{
801019ed:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(ip->type == T_DEV){
801019f0:	0f 84 ca 00 00 00    	je     80101ac0 <readi+0xf0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801019f6:	8b 47 58             	mov    0x58(%edi),%eax
801019f9:	39 c6                	cmp    %eax,%esi
801019fb:	0f 87 e3 00 00 00    	ja     80101ae4 <readi+0x114>
80101a01:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101a04:	01 f2                	add    %esi,%edx
80101a06:	0f 82 d8 00 00 00    	jb     80101ae4 <readi+0x114>
    return -1;
  if(off + n > ip->size)
80101a0c:	39 d0                	cmp    %edx,%eax
80101a0e:	0f 82 9c 00 00 00    	jb     80101ab0 <readi+0xe0>
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a14:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101a17:	85 c0                	test   %eax,%eax
80101a19:	0f 84 86 00 00 00    	je     80101aa5 <readi+0xd5>
80101a1f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101a26:	89 7d d4             	mov    %edi,-0x2c(%ebp)
80101a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a30:	8b 7d d4             	mov    -0x2c(%ebp),%edi
80101a33:	89 f2                	mov    %esi,%edx
80101a35:	c1 ea 09             	shr    $0x9,%edx
80101a38:	89 f8                	mov    %edi,%eax
80101a3a:	e8 c1 f8 ff ff       	call   80101300 <bmap>
80101a3f:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a43:	8b 07                	mov    (%edi),%eax
80101a45:	89 04 24             	mov    %eax,(%esp)
80101a48:	e8 83 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101a4d:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101a50:	b9 00 02 00 00       	mov    $0x200,%ecx
80101a55:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a58:	29 df                	sub    %ebx,%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a5a:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101a5c:	89 f0                	mov    %esi,%eax
80101a5e:	25 ff 01 00 00       	and    $0x1ff,%eax
80101a63:	89 fb                	mov    %edi,%ebx
80101a65:	29 c1                	sub    %eax,%ecx
80101a67:	39 f9                	cmp    %edi,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101a69:	8b 7d dc             	mov    -0x24(%ebp),%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101a6c:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a6f:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a73:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101a75:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101a79:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a7d:	89 3c 24             	mov    %edi,(%esp)
80101a80:	89 55 d8             	mov    %edx,-0x28(%ebp)
80101a83:	e8 a8 3e 00 00       	call   80105930 <memmove>
    brelse(bp);
80101a88:	8b 55 d8             	mov    -0x28(%ebp),%edx
80101a8b:	89 14 24             	mov    %edx,(%esp)
80101a8e:	e8 4d e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a93:	89 f9                	mov    %edi,%ecx
80101a95:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101a98:	01 d9                	add    %ebx,%ecx
80101a9a:	89 4d dc             	mov    %ecx,-0x24(%ebp)
80101a9d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101aa0:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101aa3:	77 8b                	ja     80101a30 <readi+0x60>
  }
  return n;
80101aa5:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101aa8:	83 c4 3c             	add    $0x3c,%esp
80101aab:	5b                   	pop    %ebx
80101aac:	5e                   	pop    %esi
80101aad:	5f                   	pop    %edi
80101aae:	5d                   	pop    %ebp
80101aaf:	c3                   	ret    
    n = ip->size - off;
80101ab0:	29 f0                	sub    %esi,%eax
80101ab2:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101ab5:	e9 5a ff ff ff       	jmp    80101a14 <readi+0x44>
80101aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101ac0:	0f bf 47 52          	movswl 0x52(%edi),%eax
80101ac4:	66 83 f8 09          	cmp    $0x9,%ax
80101ac8:	77 1a                	ja     80101ae4 <readi+0x114>
80101aca:	8b 04 c5 c0 19 11 80 	mov    -0x7feee640(,%eax,8),%eax
80101ad1:	85 c0                	test   %eax,%eax
80101ad3:	74 0f                	je     80101ae4 <readi+0x114>
    return devsw[ip->major].read(ip, dst, n);
80101ad5:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101ad8:	89 75 10             	mov    %esi,0x10(%ebp)
}
80101adb:	83 c4 3c             	add    $0x3c,%esp
80101ade:	5b                   	pop    %ebx
80101adf:	5e                   	pop    %esi
80101ae0:	5f                   	pop    %edi
80101ae1:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101ae2:	ff e0                	jmp    *%eax
      return -1;
80101ae4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ae9:	eb bd                	jmp    80101aa8 <readi+0xd8>
80101aeb:	90                   	nop
80101aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101af0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101af0:	55                   	push   %ebp
80101af1:	89 e5                	mov    %esp,%ebp
80101af3:	57                   	push   %edi
80101af4:	56                   	push   %esi
80101af5:	53                   	push   %ebx
80101af6:	83 ec 2c             	sub    $0x2c,%esp
80101af9:	8b 45 0c             	mov    0xc(%ebp),%eax
80101afc:	8b 7d 08             	mov    0x8(%ebp),%edi
80101aff:	8b 75 10             	mov    0x10(%ebp),%esi
80101b02:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101b05:	8b 45 14             	mov    0x14(%ebp),%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b08:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
{
80101b0d:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(ip->type == T_DEV){
80101b10:	0f 84 da 00 00 00    	je     80101bf0 <writei+0x100>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101b16:	39 77 58             	cmp    %esi,0x58(%edi)
80101b19:	0f 82 09 01 00 00    	jb     80101c28 <writei+0x138>
80101b1f:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101b22:	31 d2                	xor    %edx,%edx
80101b24:	01 f0                	add    %esi,%eax
80101b26:	0f 82 03 01 00 00    	jb     80101c2f <writei+0x13f>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101b2c:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101b31:	0f 87 f1 00 00 00    	ja     80101c28 <writei+0x138>
80101b37:	85 d2                	test   %edx,%edx
80101b39:	0f 85 e9 00 00 00    	jne    80101c28 <writei+0x138>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b3f:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80101b42:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101b49:	85 c9                	test   %ecx,%ecx
80101b4b:	0f 84 8c 00 00 00    	je     80101bdd <writei+0xed>
80101b51:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101b54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101b5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b60:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101b63:	89 f8                	mov    %edi,%eax
80101b65:	89 da                	mov    %ebx,%edx
80101b67:	c1 ea 09             	shr    $0x9,%edx
80101b6a:	e8 91 f7 ff ff       	call   80101300 <bmap>
80101b6f:	89 44 24 04          	mov    %eax,0x4(%esp)
80101b73:	8b 07                	mov    (%edi),%eax
80101b75:	89 04 24             	mov    %eax,(%esp)
80101b78:	e8 53 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b7d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101b80:	b9 00 02 00 00       	mov    $0x200,%ecx
80101b85:	89 5d e0             	mov    %ebx,-0x20(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b88:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80101b8a:	89 d8                	mov    %ebx,%eax
80101b8c:	8b 5d dc             	mov    -0x24(%ebp),%ebx
80101b8f:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b94:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101b96:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b9a:	29 d3                	sub    %edx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b9c:	8b 55 d8             	mov    -0x28(%ebp),%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101b9f:	39 d9                	cmp    %ebx,%ecx
80101ba1:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101ba4:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101ba8:	89 54 24 04          	mov    %edx,0x4(%esp)
80101bac:	89 04 24             	mov    %eax,(%esp)
80101baf:	e8 7c 3d 00 00       	call   80105930 <memmove>
    log_write(bp);
80101bb4:	89 34 24             	mov    %esi,(%esp)
80101bb7:	e8 74 12 00 00       	call   80102e30 <log_write>
    brelse(bp);
80101bbc:	89 34 24             	mov    %esi,(%esp)
80101bbf:	e8 1c e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101bc4:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101bc7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101bca:	01 5d d8             	add    %ebx,-0x28(%ebp)
80101bcd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101bd0:	39 4d dc             	cmp    %ecx,-0x24(%ebp)
80101bd3:	77 8b                	ja     80101b60 <writei+0x70>
80101bd5:	8b 75 e0             	mov    -0x20(%ebp),%esi
  }

  if(n > 0 && off > ip->size){
80101bd8:	3b 77 58             	cmp    0x58(%edi),%esi
80101bdb:	77 3b                	ja     80101c18 <writei+0x128>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101bdd:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
80101be0:	83 c4 2c             	add    $0x2c,%esp
80101be3:	5b                   	pop    %ebx
80101be4:	5e                   	pop    %esi
80101be5:	5f                   	pop    %edi
80101be6:	5d                   	pop    %ebp
80101be7:	c3                   	ret    
80101be8:	90                   	nop
80101be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101bf0:	0f bf 47 52          	movswl 0x52(%edi),%eax
80101bf4:	66 83 f8 09          	cmp    $0x9,%ax
80101bf8:	77 2e                	ja     80101c28 <writei+0x138>
80101bfa:	8b 04 c5 c4 19 11 80 	mov    -0x7feee63c(,%eax,8),%eax
80101c01:	85 c0                	test   %eax,%eax
80101c03:	74 23                	je     80101c28 <writei+0x138>
    return devsw[ip->major].write(ip, src, n);
80101c05:	8b 7d dc             	mov    -0x24(%ebp),%edi
80101c08:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101c0b:	83 c4 2c             	add    $0x2c,%esp
80101c0e:	5b                   	pop    %ebx
80101c0f:	5e                   	pop    %esi
80101c10:	5f                   	pop    %edi
80101c11:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101c12:	ff e0                	jmp    *%eax
80101c14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101c18:	89 77 58             	mov    %esi,0x58(%edi)
    iupdate(ip);
80101c1b:	89 3c 24             	mov    %edi,(%esp)
80101c1e:	e8 0d fa ff ff       	call   80101630 <iupdate>
80101c23:	eb b8                	jmp    80101bdd <writei+0xed>
80101c25:	8d 76 00             	lea    0x0(%esi),%esi
      return -1;
80101c28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c2d:	eb b1                	jmp    80101be0 <writei+0xf0>
80101c2f:	ba 01 00 00 00       	mov    $0x1,%edx
80101c34:	e9 f3 fe ff ff       	jmp    80101b2c <writei+0x3c>
80101c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101c40 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101c40:	55                   	push   %ebp
  return strncmp(s, t, DIRSIZ);
80101c41:	b8 0e 00 00 00       	mov    $0xe,%eax
{
80101c46:	89 e5                	mov    %esp,%ebp
80101c48:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
80101c4b:	89 44 24 08          	mov    %eax,0x8(%esp)
80101c4f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c52:	89 44 24 04          	mov    %eax,0x4(%esp)
80101c56:	8b 45 08             	mov    0x8(%ebp),%eax
80101c59:	89 04 24             	mov    %eax,(%esp)
80101c5c:	e8 2f 3d 00 00       	call   80105990 <strncmp>
}
80101c61:	c9                   	leave  
80101c62:	c3                   	ret    
80101c63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c70 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101c70:	55                   	push   %ebp
80101c71:	89 e5                	mov    %esp,%ebp
80101c73:	57                   	push   %edi
80101c74:	56                   	push   %esi
80101c75:	53                   	push   %ebx
80101c76:	83 ec 2c             	sub    $0x2c,%esp
80101c79:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101c7c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101c81:	0f 85 a4 00 00 00    	jne    80101d2b <dirlookup+0xbb>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101c87:	8b 43 58             	mov    0x58(%ebx),%eax
80101c8a:	31 ff                	xor    %edi,%edi
80101c8c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101c8f:	85 c0                	test   %eax,%eax
80101c91:	74 59                	je     80101cec <dirlookup+0x7c>
80101c93:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ca0:	b9 10 00 00 00       	mov    $0x10,%ecx
80101ca5:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80101ca9:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101cad:	89 74 24 04          	mov    %esi,0x4(%esp)
80101cb1:	89 1c 24             	mov    %ebx,(%esp)
80101cb4:	e8 17 fd ff ff       	call   801019d0 <readi>
80101cb9:	83 f8 10             	cmp    $0x10,%eax
80101cbc:	75 61                	jne    80101d1f <dirlookup+0xaf>
      panic("dirlookup read");
    if(de.inum == 0)
80101cbe:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101cc3:	74 1f                	je     80101ce4 <dirlookup+0x74>
  return strncmp(s, t, DIRSIZ);
80101cc5:	8d 45 da             	lea    -0x26(%ebp),%eax
80101cc8:	ba 0e 00 00 00       	mov    $0xe,%edx
80101ccd:	89 44 24 04          	mov    %eax,0x4(%esp)
80101cd1:	8b 45 0c             	mov    0xc(%ebp),%eax
80101cd4:	89 54 24 08          	mov    %edx,0x8(%esp)
80101cd8:	89 04 24             	mov    %eax,(%esp)
80101cdb:	e8 b0 3c 00 00       	call   80105990 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101ce0:	85 c0                	test   %eax,%eax
80101ce2:	74 1c                	je     80101d00 <dirlookup+0x90>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101ce4:	83 c7 10             	add    $0x10,%edi
80101ce7:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101cea:	72 b4                	jb     80101ca0 <dirlookup+0x30>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101cec:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80101cef:	31 c0                	xor    %eax,%eax
}
80101cf1:	5b                   	pop    %ebx
80101cf2:	5e                   	pop    %esi
80101cf3:	5f                   	pop    %edi
80101cf4:	5d                   	pop    %ebp
80101cf5:	c3                   	ret    
80101cf6:	8d 76 00             	lea    0x0(%esi),%esi
80101cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(poff)
80101d00:	8b 45 10             	mov    0x10(%ebp),%eax
80101d03:	85 c0                	test   %eax,%eax
80101d05:	74 05                	je     80101d0c <dirlookup+0x9c>
        *poff = off;
80101d07:	8b 45 10             	mov    0x10(%ebp),%eax
80101d0a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101d0c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101d10:	8b 03                	mov    (%ebx),%eax
80101d12:	e8 29 f5 ff ff       	call   80101240 <iget>
}
80101d17:	83 c4 2c             	add    $0x2c,%esp
80101d1a:	5b                   	pop    %ebx
80101d1b:	5e                   	pop    %esi
80101d1c:	5f                   	pop    %edi
80101d1d:	5d                   	pop    %ebp
80101d1e:	c3                   	ret    
      panic("dirlookup read");
80101d1f:	c7 04 24 79 85 10 80 	movl   $0x80108579,(%esp)
80101d26:	e8 45 e6 ff ff       	call   80100370 <panic>
    panic("dirlookup not DIR");
80101d2b:	c7 04 24 67 85 10 80 	movl   $0x80108567,(%esp)
80101d32:	e8 39 e6 ff ff       	call   80100370 <panic>
80101d37:	89 f6                	mov    %esi,%esi
80101d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101d40 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d40:	55                   	push   %ebp
80101d41:	89 e5                	mov    %esp,%ebp
80101d43:	57                   	push   %edi
80101d44:	89 cf                	mov    %ecx,%edi
80101d46:	56                   	push   %esi
80101d47:	53                   	push   %ebx
80101d48:	89 c3                	mov    %eax,%ebx
80101d4a:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101d4d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101d50:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101d53:	0f 84 5b 01 00 00    	je     80101eb4 <namex+0x174>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101d59:	e8 22 1c 00 00       	call   80103980 <myproc>
80101d5e:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101d61:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
80101d68:	e8 13 3a 00 00       	call   80105780 <acquire>
  ip->ref++;
80101d6d:	ff 46 08             	incl   0x8(%esi)
  release(&icache.lock);
80101d70:	c7 04 24 40 1a 11 80 	movl   $0x80111a40,(%esp)
80101d77:	e8 a4 3a 00 00       	call   80105820 <release>
80101d7c:	eb 03                	jmp    80101d81 <namex+0x41>
80101d7e:	66 90                	xchg   %ax,%ax
    path++;
80101d80:	43                   	inc    %ebx
  while(*path == '/')
80101d81:	0f b6 03             	movzbl (%ebx),%eax
80101d84:	3c 2f                	cmp    $0x2f,%al
80101d86:	74 f8                	je     80101d80 <namex+0x40>
  if(*path == 0)
80101d88:	84 c0                	test   %al,%al
80101d8a:	0f 84 f0 00 00 00    	je     80101e80 <namex+0x140>
  while(*path != '/' && *path != 0)
80101d90:	0f b6 03             	movzbl (%ebx),%eax
80101d93:	3c 2f                	cmp    $0x2f,%al
80101d95:	0f 84 b5 00 00 00    	je     80101e50 <namex+0x110>
80101d9b:	84 c0                	test   %al,%al
80101d9d:	89 da                	mov    %ebx,%edx
80101d9f:	75 13                	jne    80101db4 <namex+0x74>
80101da1:	e9 aa 00 00 00       	jmp    80101e50 <namex+0x110>
80101da6:	8d 76 00             	lea    0x0(%esi),%esi
80101da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101db0:	84 c0                	test   %al,%al
80101db2:	74 08                	je     80101dbc <namex+0x7c>
    path++;
80101db4:	42                   	inc    %edx
  while(*path != '/' && *path != 0)
80101db5:	0f b6 02             	movzbl (%edx),%eax
80101db8:	3c 2f                	cmp    $0x2f,%al
80101dba:	75 f4                	jne    80101db0 <namex+0x70>
80101dbc:	89 d1                	mov    %edx,%ecx
80101dbe:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101dc0:	83 f9 0d             	cmp    $0xd,%ecx
80101dc3:	0f 8e 8b 00 00 00    	jle    80101e54 <namex+0x114>
    memmove(name, s, DIRSIZ);
80101dc9:	b8 0e 00 00 00       	mov    $0xe,%eax
80101dce:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101dd2:	89 44 24 08          	mov    %eax,0x8(%esp)
80101dd6:	89 3c 24             	mov    %edi,(%esp)
80101dd9:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101ddc:	e8 4f 3b 00 00       	call   80105930 <memmove>
    path++;
80101de1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101de4:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101de6:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101de9:	75 0b                	jne    80101df6 <namex+0xb6>
80101deb:	90                   	nop
80101dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101df0:	43                   	inc    %ebx
  while(*path == '/')
80101df1:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101df4:	74 fa                	je     80101df0 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101df6:	89 34 24             	mov    %esi,(%esp)
80101df9:	e8 f2 f8 ff ff       	call   801016f0 <ilock>
    if(ip->type != T_DIR){
80101dfe:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101e03:	0f 85 8f 00 00 00    	jne    80101e98 <namex+0x158>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101e09:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e0c:	85 c0                	test   %eax,%eax
80101e0e:	74 09                	je     80101e19 <namex+0xd9>
80101e10:	80 3b 00             	cmpb   $0x0,(%ebx)
80101e13:	0f 84 b1 00 00 00    	je     80101eca <namex+0x18a>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101e19:	31 c9                	xor    %ecx,%ecx
80101e1b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101e1f:	89 7c 24 04          	mov    %edi,0x4(%esp)
80101e23:	89 34 24             	mov    %esi,(%esp)
80101e26:	e8 45 fe ff ff       	call   80101c70 <dirlookup>
80101e2b:	85 c0                	test   %eax,%eax
80101e2d:	74 69                	je     80101e98 <namex+0x158>
  iunlock(ip);
80101e2f:	89 34 24             	mov    %esi,(%esp)
80101e32:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101e35:	e8 96 f9 ff ff       	call   801017d0 <iunlock>
  iput(ip);
80101e3a:	89 34 24             	mov    %esi,(%esp)
80101e3d:	e8 de f9 ff ff       	call   80101820 <iput>
80101e42:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e45:	89 c6                	mov    %eax,%esi
80101e47:	e9 35 ff ff ff       	jmp    80101d81 <namex+0x41>
80101e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101e50:	89 da                	mov    %ebx,%edx
80101e52:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101e54:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101e58:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101e5c:	89 3c 24             	mov    %edi,(%esp)
80101e5f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101e62:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101e65:	e8 c6 3a 00 00       	call   80105930 <memmove>
    name[len] = 0;
80101e6a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101e6d:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101e70:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101e74:	89 d3                	mov    %edx,%ebx
80101e76:	e9 6b ff ff ff       	jmp    80101de6 <namex+0xa6>
80101e7b:	90                   	nop
80101e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101e80:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101e83:	85 d2                	test   %edx,%edx
80101e85:	75 55                	jne    80101edc <namex+0x19c>
    iput(ip);
    return 0;
  }
  return ip;
}
80101e87:	83 c4 2c             	add    $0x2c,%esp
80101e8a:	89 f0                	mov    %esi,%eax
80101e8c:	5b                   	pop    %ebx
80101e8d:	5e                   	pop    %esi
80101e8e:	5f                   	pop    %edi
80101e8f:	5d                   	pop    %ebp
80101e90:	c3                   	ret    
80101e91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101e98:	89 34 24             	mov    %esi,(%esp)
80101e9b:	e8 30 f9 ff ff       	call   801017d0 <iunlock>
  iput(ip);
80101ea0:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101ea3:	31 f6                	xor    %esi,%esi
  iput(ip);
80101ea5:	e8 76 f9 ff ff       	call   80101820 <iput>
}
80101eaa:	83 c4 2c             	add    $0x2c,%esp
80101ead:	89 f0                	mov    %esi,%eax
80101eaf:	5b                   	pop    %ebx
80101eb0:	5e                   	pop    %esi
80101eb1:	5f                   	pop    %edi
80101eb2:	5d                   	pop    %ebp
80101eb3:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101eb4:	ba 01 00 00 00       	mov    $0x1,%edx
80101eb9:	b8 01 00 00 00       	mov    $0x1,%eax
80101ebe:	e8 7d f3 ff ff       	call   80101240 <iget>
80101ec3:	89 c6                	mov    %eax,%esi
80101ec5:	e9 b7 fe ff ff       	jmp    80101d81 <namex+0x41>
      iunlock(ip);
80101eca:	89 34 24             	mov    %esi,(%esp)
80101ecd:	e8 fe f8 ff ff       	call   801017d0 <iunlock>
}
80101ed2:	83 c4 2c             	add    $0x2c,%esp
80101ed5:	89 f0                	mov    %esi,%eax
80101ed7:	5b                   	pop    %ebx
80101ed8:	5e                   	pop    %esi
80101ed9:	5f                   	pop    %edi
80101eda:	5d                   	pop    %ebp
80101edb:	c3                   	ret    
    iput(ip);
80101edc:	89 34 24             	mov    %esi,(%esp)
    return 0;
80101edf:	31 f6                	xor    %esi,%esi
    iput(ip);
80101ee1:	e8 3a f9 ff ff       	call   80101820 <iput>
    return 0;
80101ee6:	eb 9f                	jmp    80101e87 <namex+0x147>
80101ee8:	90                   	nop
80101ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101ef0 <dirlink>:
{
80101ef0:	55                   	push   %ebp
80101ef1:	89 e5                	mov    %esp,%ebp
80101ef3:	57                   	push   %edi
80101ef4:	56                   	push   %esi
80101ef5:	53                   	push   %ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101ef6:	31 db                	xor    %ebx,%ebx
{
80101ef8:	83 ec 2c             	sub    $0x2c,%esp
80101efb:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((ip = dirlookup(dp, name, 0)) != 0){
80101efe:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f01:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101f05:	89 3c 24             	mov    %edi,(%esp)
80101f08:	89 44 24 04          	mov    %eax,0x4(%esp)
80101f0c:	e8 5f fd ff ff       	call   80101c70 <dirlookup>
80101f11:	85 c0                	test   %eax,%eax
80101f13:	0f 85 8e 00 00 00    	jne    80101fa7 <dirlink+0xb7>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101f19:	8b 5f 58             	mov    0x58(%edi),%ebx
80101f1c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f1f:	85 db                	test   %ebx,%ebx
80101f21:	74 3a                	je     80101f5d <dirlink+0x6d>
80101f23:	31 db                	xor    %ebx,%ebx
80101f25:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f28:	eb 0e                	jmp    80101f38 <dirlink+0x48>
80101f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101f30:	83 c3 10             	add    $0x10,%ebx
80101f33:	3b 5f 58             	cmp    0x58(%edi),%ebx
80101f36:	73 25                	jae    80101f5d <dirlink+0x6d>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f38:	b9 10 00 00 00       	mov    $0x10,%ecx
80101f3d:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80101f41:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101f45:	89 74 24 04          	mov    %esi,0x4(%esp)
80101f49:	89 3c 24             	mov    %edi,(%esp)
80101f4c:	e8 7f fa ff ff       	call   801019d0 <readi>
80101f51:	83 f8 10             	cmp    $0x10,%eax
80101f54:	75 60                	jne    80101fb6 <dirlink+0xc6>
    if(de.inum == 0)
80101f56:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101f5b:	75 d3                	jne    80101f30 <dirlink+0x40>
  strncpy(de.name, name, DIRSIZ);
80101f5d:	b8 0e 00 00 00       	mov    $0xe,%eax
80101f62:	89 44 24 08          	mov    %eax,0x8(%esp)
80101f66:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f69:	89 44 24 04          	mov    %eax,0x4(%esp)
80101f6d:	8d 45 da             	lea    -0x26(%ebp),%eax
80101f70:	89 04 24             	mov    %eax,(%esp)
80101f73:	e8 78 3a 00 00       	call   801059f0 <strncpy>
  de.inum = inum;
80101f78:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f7b:	ba 10 00 00 00       	mov    $0x10,%edx
80101f80:	89 54 24 0c          	mov    %edx,0xc(%esp)
80101f84:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101f88:	89 74 24 04          	mov    %esi,0x4(%esp)
80101f8c:	89 3c 24             	mov    %edi,(%esp)
  de.inum = inum;
80101f8f:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f93:	e8 58 fb ff ff       	call   80101af0 <writei>
80101f98:	83 f8 10             	cmp    $0x10,%eax
80101f9b:	75 25                	jne    80101fc2 <dirlink+0xd2>
  return 0;
80101f9d:	31 c0                	xor    %eax,%eax
}
80101f9f:	83 c4 2c             	add    $0x2c,%esp
80101fa2:	5b                   	pop    %ebx
80101fa3:	5e                   	pop    %esi
80101fa4:	5f                   	pop    %edi
80101fa5:	5d                   	pop    %ebp
80101fa6:	c3                   	ret    
    iput(ip);
80101fa7:	89 04 24             	mov    %eax,(%esp)
80101faa:	e8 71 f8 ff ff       	call   80101820 <iput>
    return -1;
80101faf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101fb4:	eb e9                	jmp    80101f9f <dirlink+0xaf>
      panic("dirlink read");
80101fb6:	c7 04 24 88 85 10 80 	movl   $0x80108588,(%esp)
80101fbd:	e8 ae e3 ff ff       	call   80100370 <panic>
    panic("dirlink");
80101fc2:	c7 04 24 0a 8c 10 80 	movl   $0x80108c0a,(%esp)
80101fc9:	e8 a2 e3 ff ff       	call   80100370 <panic>
80101fce:	66 90                	xchg   %ax,%ax

80101fd0 <namei>:

struct inode*
namei(char *path)
{
80101fd0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101fd1:	31 d2                	xor    %edx,%edx
{
80101fd3:	89 e5                	mov    %esp,%ebp
80101fd5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101fd8:	8b 45 08             	mov    0x8(%ebp),%eax
80101fdb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101fde:	e8 5d fd ff ff       	call   80101d40 <namex>
}
80101fe3:	c9                   	leave  
80101fe4:	c3                   	ret    
80101fe5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ff0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101ff0:	55                   	push   %ebp
  return namex(path, 1, name);
80101ff1:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101ff6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101ff8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101ffb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101ffe:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101fff:	e9 3c fd ff ff       	jmp    80101d40 <namex>
80102004:	66 90                	xchg   %ax,%ax
80102006:	66 90                	xchg   %ax,%ax
80102008:	66 90                	xchg   %ax,%ax
8010200a:	66 90                	xchg   %ax,%ax
8010200c:	66 90                	xchg   %ax,%ax
8010200e:	66 90                	xchg   %ax,%ax

80102010 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102010:	55                   	push   %ebp
80102011:	89 e5                	mov    %esp,%ebp
80102013:	56                   	push   %esi
80102014:	53                   	push   %ebx
80102015:	83 ec 10             	sub    $0x10,%esp
  if(b == 0)
80102018:	85 c0                	test   %eax,%eax
8010201a:	0f 84 a8 00 00 00    	je     801020c8 <idestart+0xb8>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102020:	8b 48 08             	mov    0x8(%eax),%ecx
80102023:	89 c6                	mov    %eax,%esi
80102025:	81 f9 e7 03 00 00    	cmp    $0x3e7,%ecx
8010202b:	0f 87 8b 00 00 00    	ja     801020bc <idestart+0xac>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102031:	bb f7 01 00 00       	mov    $0x1f7,%ebx
80102036:	8d 76 00             	lea    0x0(%esi),%esi
80102039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102040:	89 da                	mov    %ebx,%edx
80102042:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102043:	24 c0                	and    $0xc0,%al
80102045:	3c 40                	cmp    $0x40,%al
80102047:	75 f7                	jne    80102040 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102049:	ba f6 03 00 00       	mov    $0x3f6,%edx
8010204e:	31 c0                	xor    %eax,%eax
80102050:	ee                   	out    %al,(%dx)
80102051:	b0 01                	mov    $0x1,%al
80102053:	ba f2 01 00 00       	mov    $0x1f2,%edx
80102058:	ee                   	out    %al,(%dx)
80102059:	ba f3 01 00 00       	mov    $0x1f3,%edx
8010205e:	88 c8                	mov    %cl,%al
80102060:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102061:	c1 f9 08             	sar    $0x8,%ecx
80102064:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102069:	89 c8                	mov    %ecx,%eax
8010206b:	ee                   	out    %al,(%dx)
8010206c:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102071:	31 c0                	xor    %eax,%eax
80102073:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102074:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80102078:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010207d:	c0 e0 04             	shl    $0x4,%al
80102080:	24 10                	and    $0x10,%al
80102082:	0c e0                	or     $0xe0,%al
80102084:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80102085:	f6 06 04             	testb  $0x4,(%esi)
80102088:	75 16                	jne    801020a0 <idestart+0x90>
8010208a:	b0 20                	mov    $0x20,%al
8010208c:	89 da                	mov    %ebx,%edx
8010208e:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010208f:	83 c4 10             	add    $0x10,%esp
80102092:	5b                   	pop    %ebx
80102093:	5e                   	pop    %esi
80102094:	5d                   	pop    %ebp
80102095:	c3                   	ret    
80102096:	8d 76 00             	lea    0x0(%esi),%esi
80102099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801020a0:	b0 30                	mov    $0x30,%al
801020a2:	89 da                	mov    %ebx,%edx
801020a4:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
801020a5:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
801020aa:	83 c6 5c             	add    $0x5c,%esi
801020ad:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020b2:	fc                   	cld    
801020b3:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
801020b5:	83 c4 10             	add    $0x10,%esp
801020b8:	5b                   	pop    %ebx
801020b9:	5e                   	pop    %esi
801020ba:	5d                   	pop    %ebp
801020bb:	c3                   	ret    
    panic("incorrect blockno");
801020bc:	c7 04 24 f4 85 10 80 	movl   $0x801085f4,(%esp)
801020c3:	e8 a8 e2 ff ff       	call   80100370 <panic>
    panic("idestart");
801020c8:	c7 04 24 eb 85 10 80 	movl   $0x801085eb,(%esp)
801020cf:	e8 9c e2 ff ff       	call   80100370 <panic>
801020d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801020da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801020e0 <ideinit>:
{
801020e0:	55                   	push   %ebp
  initlock(&idelock, "ide");
801020e1:	ba 06 86 10 80       	mov    $0x80108606,%edx
{
801020e6:	89 e5                	mov    %esp,%ebp
801020e8:	83 ec 18             	sub    $0x18,%esp
  initlock(&idelock, "ide");
801020eb:	89 54 24 04          	mov    %edx,0x4(%esp)
801020ef:	c7 04 24 80 b5 10 80 	movl   $0x8010b580,(%esp)
801020f6:	e8 35 35 00 00       	call   80105630 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801020fb:	a1 60 3d 11 80       	mov    0x80113d60,%eax
80102100:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102107:	48                   	dec    %eax
80102108:	89 44 24 04          	mov    %eax,0x4(%esp)
8010210c:	e8 8f 02 00 00       	call   801023a0 <ioapicenable>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102111:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102116:	8d 76 00             	lea    0x0(%esi),%esi
80102119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102120:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102121:	24 c0                	and    $0xc0,%al
80102123:	3c 40                	cmp    $0x40,%al
80102125:	75 f9                	jne    80102120 <ideinit+0x40>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102127:	b0 f0                	mov    $0xf0,%al
80102129:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010212e:	ee                   	out    %al,(%dx)
8010212f:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102134:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102139:	eb 08                	jmp    80102143 <ideinit+0x63>
8010213b:	90                   	nop
8010213c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i=0; i<1000; i++){
80102140:	49                   	dec    %ecx
80102141:	74 0f                	je     80102152 <ideinit+0x72>
80102143:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102144:	84 c0                	test   %al,%al
80102146:	74 f8                	je     80102140 <ideinit+0x60>
      havedisk1 = 1;
80102148:	b8 01 00 00 00       	mov    $0x1,%eax
8010214d:	a3 60 b5 10 80       	mov    %eax,0x8010b560
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102152:	b0 e0                	mov    $0xe0,%al
80102154:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102159:	ee                   	out    %al,(%dx)
}
8010215a:	c9                   	leave  
8010215b:	c3                   	ret    
8010215c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102160 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102160:	55                   	push   %ebp
80102161:	89 e5                	mov    %esp,%ebp
80102163:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102166:	c7 04 24 80 b5 10 80 	movl   $0x8010b580,(%esp)
{
8010216d:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80102170:	89 75 f8             	mov    %esi,-0x8(%ebp)
80102173:	89 7d fc             	mov    %edi,-0x4(%ebp)
  acquire(&idelock);
80102176:	e8 05 36 00 00       	call   80105780 <acquire>

  if((b = idequeue) == 0){
8010217b:	8b 1d 64 b5 10 80    	mov    0x8010b564,%ebx
80102181:	85 db                	test   %ebx,%ebx
80102183:	74 5c                	je     801021e1 <ideintr+0x81>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102185:	8b 43 58             	mov    0x58(%ebx),%eax
80102188:	a3 64 b5 10 80       	mov    %eax,0x8010b564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
8010218d:	8b 0b                	mov    (%ebx),%ecx
8010218f:	f6 c1 04             	test   $0x4,%cl
80102192:	75 2f                	jne    801021c3 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102194:	be f7 01 00 00       	mov    $0x1f7,%esi
80102199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021a0:	89 f2                	mov    %esi,%edx
801021a2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021a3:	88 c2                	mov    %al,%dl
801021a5:	80 e2 c0             	and    $0xc0,%dl
801021a8:	80 fa 40             	cmp    $0x40,%dl
801021ab:	75 f3                	jne    801021a0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801021ad:	a8 21                	test   $0x21,%al
801021af:	75 12                	jne    801021c3 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
801021b1:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801021b4:	b9 80 00 00 00       	mov    $0x80,%ecx
801021b9:	ba f0 01 00 00       	mov    $0x1f0,%edx
801021be:	fc                   	cld    
801021bf:	f3 6d                	rep insl (%dx),%es:(%edi)
801021c1:	8b 0b                	mov    (%ebx),%ecx

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801021c3:	83 e1 fb             	and    $0xfffffffb,%ecx
801021c6:	83 c9 02             	or     $0x2,%ecx
801021c9:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
801021cb:	89 1c 24             	mov    %ebx,(%esp)
801021ce:	e8 7d 22 00 00       	call   80104450 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801021d3:	a1 64 b5 10 80       	mov    0x8010b564,%eax
801021d8:	85 c0                	test   %eax,%eax
801021da:	74 05                	je     801021e1 <ideintr+0x81>
    idestart(idequeue);
801021dc:	e8 2f fe ff ff       	call   80102010 <idestart>
    release(&idelock);
801021e1:	c7 04 24 80 b5 10 80 	movl   $0x8010b580,(%esp)
801021e8:	e8 33 36 00 00       	call   80105820 <release>

  release(&idelock);
}
801021ed:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801021f0:	8b 75 f8             	mov    -0x8(%ebp),%esi
801021f3:	8b 7d fc             	mov    -0x4(%ebp),%edi
801021f6:	89 ec                	mov    %ebp,%esp
801021f8:	5d                   	pop    %ebp
801021f9:	c3                   	ret    
801021fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102200 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102200:	55                   	push   %ebp
80102201:	89 e5                	mov    %esp,%ebp
80102203:	53                   	push   %ebx
80102204:	83 ec 14             	sub    $0x14,%esp
80102207:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010220a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010220d:	89 04 24             	mov    %eax,(%esp)
80102210:	e8 cb 33 00 00       	call   801055e0 <holdingsleep>
80102215:	85 c0                	test   %eax,%eax
80102217:	0f 84 b6 00 00 00    	je     801022d3 <iderw+0xd3>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010221d:	8b 03                	mov    (%ebx),%eax
8010221f:	83 e0 06             	and    $0x6,%eax
80102222:	83 f8 02             	cmp    $0x2,%eax
80102225:	0f 84 9c 00 00 00    	je     801022c7 <iderw+0xc7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010222b:	8b 4b 04             	mov    0x4(%ebx),%ecx
8010222e:	85 c9                	test   %ecx,%ecx
80102230:	74 0e                	je     80102240 <iderw+0x40>
80102232:	8b 15 60 b5 10 80    	mov    0x8010b560,%edx
80102238:	85 d2                	test   %edx,%edx
8010223a:	0f 84 9f 00 00 00    	je     801022df <iderw+0xdf>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102240:	c7 04 24 80 b5 10 80 	movl   $0x8010b580,(%esp)
80102247:	e8 34 35 00 00       	call   80105780 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010224c:	8b 15 64 b5 10 80    	mov    0x8010b564,%edx
  b->qnext = 0;
80102252:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102259:	85 d2                	test   %edx,%edx
8010225b:	75 05                	jne    80102262 <iderw+0x62>
8010225d:	eb 61                	jmp    801022c0 <iderw+0xc0>
8010225f:	90                   	nop
80102260:	89 c2                	mov    %eax,%edx
80102262:	8b 42 58             	mov    0x58(%edx),%eax
80102265:	85 c0                	test   %eax,%eax
80102267:	75 f7                	jne    80102260 <iderw+0x60>
80102269:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010226c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010226e:	39 1d 64 b5 10 80    	cmp    %ebx,0x8010b564
80102274:	75 1b                	jne    80102291 <iderw+0x91>
80102276:	eb 38                	jmp    801022b0 <iderw+0xb0>
80102278:	90                   	nop
80102279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
80102280:	b8 80 b5 10 80       	mov    $0x8010b580,%eax
80102285:	89 44 24 04          	mov    %eax,0x4(%esp)
80102289:	89 1c 24             	mov    %ebx,(%esp)
8010228c:	e8 df 1f 00 00       	call   80104270 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102291:	8b 03                	mov    (%ebx),%eax
80102293:	83 e0 06             	and    $0x6,%eax
80102296:	83 f8 02             	cmp    $0x2,%eax
80102299:	75 e5                	jne    80102280 <iderw+0x80>
  }


  release(&idelock);
8010229b:	c7 45 08 80 b5 10 80 	movl   $0x8010b580,0x8(%ebp)
}
801022a2:	83 c4 14             	add    $0x14,%esp
801022a5:	5b                   	pop    %ebx
801022a6:	5d                   	pop    %ebp
  release(&idelock);
801022a7:	e9 74 35 00 00       	jmp    80105820 <release>
801022ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
801022b0:	89 d8                	mov    %ebx,%eax
801022b2:	e8 59 fd ff ff       	call   80102010 <idestart>
801022b7:	eb d8                	jmp    80102291 <iderw+0x91>
801022b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022c0:	ba 64 b5 10 80       	mov    $0x8010b564,%edx
801022c5:	eb a5                	jmp    8010226c <iderw+0x6c>
    panic("iderw: nothing to do");
801022c7:	c7 04 24 20 86 10 80 	movl   $0x80108620,(%esp)
801022ce:	e8 9d e0 ff ff       	call   80100370 <panic>
    panic("iderw: buf not locked");
801022d3:	c7 04 24 0a 86 10 80 	movl   $0x8010860a,(%esp)
801022da:	e8 91 e0 ff ff       	call   80100370 <panic>
    panic("iderw: ide disk 1 not present");
801022df:	c7 04 24 35 86 10 80 	movl   $0x80108635,(%esp)
801022e6:	e8 85 e0 ff ff       	call   80100370 <panic>
801022eb:	66 90                	xchg   %ax,%ax
801022ed:	66 90                	xchg   %ax,%ax
801022ef:	90                   	nop

801022f0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801022f0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801022f1:	b8 00 00 c0 fe       	mov    $0xfec00000,%eax
{
801022f6:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
801022f8:	ba 01 00 00 00       	mov    $0x1,%edx
{
801022fd:	56                   	push   %esi
801022fe:	53                   	push   %ebx
801022ff:	83 ec 10             	sub    $0x10,%esp
  ioapic = (volatile struct ioapic*)IOAPIC;
80102302:	a3 94 36 11 80       	mov    %eax,0x80113694
  ioapic->reg = reg;
80102307:	89 15 00 00 c0 fe    	mov    %edx,0xfec00000
  return ioapic->data;
8010230d:	a1 94 36 11 80       	mov    0x80113694,%eax
80102312:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102315:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
8010231b:	8b 0d 94 36 11 80    	mov    0x80113694,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102321:	0f b6 15 c0 37 11 80 	movzbl 0x801137c0,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102328:	c1 eb 10             	shr    $0x10,%ebx
8010232b:	0f b6 db             	movzbl %bl,%ebx
  return ioapic->data;
8010232e:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
80102331:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102334:	39 c2                	cmp    %eax,%edx
80102336:	74 12                	je     8010234a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102338:	c7 04 24 54 86 10 80 	movl   $0x80108654,(%esp)
8010233f:	e8 0c e3 ff ff       	call   80100650 <cprintf>
80102344:	8b 0d 94 36 11 80    	mov    0x80113694,%ecx
8010234a:	83 c3 21             	add    $0x21,%ebx
{
8010234d:	ba 10 00 00 00       	mov    $0x10,%edx
80102352:	b8 20 00 00 00       	mov    $0x20,%eax
80102357:	89 f6                	mov    %esi,%esi
80102359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
80102360:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102362:	89 c6                	mov    %eax,%esi
80102364:	40                   	inc    %eax
  ioapic->data = data;
80102365:	8b 0d 94 36 11 80    	mov    0x80113694,%ecx
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010236b:	81 ce 00 00 01 00    	or     $0x10000,%esi
  ioapic->data = data;
80102371:	89 71 10             	mov    %esi,0x10(%ecx)
80102374:	8d 72 01             	lea    0x1(%edx),%esi
80102377:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
8010237a:	89 31                	mov    %esi,(%ecx)
  for(i = 0; i <= maxintr; i++){
8010237c:	39 d8                	cmp    %ebx,%eax
  ioapic->data = data;
8010237e:	8b 0d 94 36 11 80    	mov    0x80113694,%ecx
80102384:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010238b:	75 d3                	jne    80102360 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010238d:	83 c4 10             	add    $0x10,%esp
80102390:	5b                   	pop    %ebx
80102391:	5e                   	pop    %esi
80102392:	5d                   	pop    %ebp
80102393:	c3                   	ret    
80102394:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010239a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801023a0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801023a0:	55                   	push   %ebp
  ioapic->reg = reg;
801023a1:	8b 0d 94 36 11 80    	mov    0x80113694,%ecx
{
801023a7:	89 e5                	mov    %esp,%ebp
801023a9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801023ac:	8d 50 20             	lea    0x20(%eax),%edx
801023af:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801023b3:	89 01                	mov    %eax,(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023b5:	40                   	inc    %eax
  ioapic->data = data;
801023b6:	8b 0d 94 36 11 80    	mov    0x80113694,%ecx
801023bc:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801023c2:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023c4:	a1 94 36 11 80       	mov    0x80113694,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023c9:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801023cc:	89 50 10             	mov    %edx,0x10(%eax)
}
801023cf:	5d                   	pop    %ebp
801023d0:	c3                   	ret    
801023d1:	66 90                	xchg   %ax,%ax
801023d3:	66 90                	xchg   %ax,%ax
801023d5:	66 90                	xchg   %ax,%ax
801023d7:	66 90                	xchg   %ax,%ax
801023d9:	66 90                	xchg   %ax,%ax
801023db:	66 90                	xchg   %ax,%ax
801023dd:	66 90                	xchg   %ax,%ax
801023df:	90                   	nop

801023e0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801023e0:	55                   	push   %ebp
801023e1:	89 e5                	mov    %esp,%ebp
801023e3:	53                   	push   %ebx
801023e4:	83 ec 14             	sub    $0x14,%esp
801023e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801023ea:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801023f0:	0f 85 80 00 00 00    	jne    80102476 <kfree+0x96>
801023f6:	81 fb 08 69 11 80    	cmp    $0x80116908,%ebx
801023fc:	72 78                	jb     80102476 <kfree+0x96>
801023fe:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102404:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102409:	77 6b                	ja     80102476 <kfree+0x96>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
8010240b:	ba 00 10 00 00       	mov    $0x1000,%edx
80102410:	b9 01 00 00 00       	mov    $0x1,%ecx
80102415:	89 54 24 08          	mov    %edx,0x8(%esp)
80102419:	89 4c 24 04          	mov    %ecx,0x4(%esp)
8010241d:	89 1c 24             	mov    %ebx,(%esp)
80102420:	e8 4b 34 00 00       	call   80105870 <memset>

  if(kmem.use_lock)
80102425:	a1 d4 36 11 80       	mov    0x801136d4,%eax
8010242a:	85 c0                	test   %eax,%eax
8010242c:	75 3a                	jne    80102468 <kfree+0x88>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
8010242e:	a1 d8 36 11 80       	mov    0x801136d8,%eax
80102433:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
80102435:	a1 d4 36 11 80       	mov    0x801136d4,%eax
  kmem.freelist = r;
8010243a:	89 1d d8 36 11 80    	mov    %ebx,0x801136d8
  if(kmem.use_lock)
80102440:	85 c0                	test   %eax,%eax
80102442:	75 0c                	jne    80102450 <kfree+0x70>
    release(&kmem.lock);
}
80102444:	83 c4 14             	add    $0x14,%esp
80102447:	5b                   	pop    %ebx
80102448:	5d                   	pop    %ebp
80102449:	c3                   	ret    
8010244a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102450:	c7 45 08 a0 36 11 80 	movl   $0x801136a0,0x8(%ebp)
}
80102457:	83 c4 14             	add    $0x14,%esp
8010245a:	5b                   	pop    %ebx
8010245b:	5d                   	pop    %ebp
    release(&kmem.lock);
8010245c:	e9 bf 33 00 00       	jmp    80105820 <release>
80102461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&kmem.lock);
80102468:	c7 04 24 a0 36 11 80 	movl   $0x801136a0,(%esp)
8010246f:	e8 0c 33 00 00       	call   80105780 <acquire>
80102474:	eb b8                	jmp    8010242e <kfree+0x4e>
    panic("kfree");
80102476:	c7 04 24 86 86 10 80 	movl   $0x80108686,(%esp)
8010247d:	e8 ee de ff ff       	call   80100370 <panic>
80102482:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102490 <freerange>:
{
80102490:	55                   	push   %ebp
80102491:	89 e5                	mov    %esp,%ebp
80102493:	56                   	push   %esi
80102494:	53                   	push   %ebx
80102495:	83 ec 10             	sub    $0x10,%esp
  p = (char*)PGROUNDUP((uint)vstart);
80102498:	8b 45 08             	mov    0x8(%ebp),%eax
{
8010249b:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010249e:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801024a4:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024aa:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801024b0:	39 de                	cmp    %ebx,%esi
801024b2:	72 24                	jb     801024d8 <freerange+0x48>
801024b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801024ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    kfree(p);
801024c0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024c6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024cc:	89 04 24             	mov    %eax,(%esp)
801024cf:	e8 0c ff ff ff       	call   801023e0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024d4:	39 f3                	cmp    %esi,%ebx
801024d6:	76 e8                	jbe    801024c0 <freerange+0x30>
}
801024d8:	83 c4 10             	add    $0x10,%esp
801024db:	5b                   	pop    %ebx
801024dc:	5e                   	pop    %esi
801024dd:	5d                   	pop    %ebp
801024de:	c3                   	ret    
801024df:	90                   	nop

801024e0 <kinit1>:
{
801024e0:	55                   	push   %ebp
  initlock(&kmem.lock, "kmem");
801024e1:	b8 8c 86 10 80       	mov    $0x8010868c,%eax
{
801024e6:	89 e5                	mov    %esp,%ebp
801024e8:	56                   	push   %esi
801024e9:	53                   	push   %ebx
801024ea:	83 ec 10             	sub    $0x10,%esp
  initlock(&kmem.lock, "kmem");
801024ed:	89 44 24 04          	mov    %eax,0x4(%esp)
{
801024f1:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801024f4:	c7 04 24 a0 36 11 80 	movl   $0x801136a0,(%esp)
801024fb:	e8 30 31 00 00       	call   80105630 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
80102500:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 0;
80102503:	31 d2                	xor    %edx,%edx
80102505:	89 15 d4 36 11 80    	mov    %edx,0x801136d4
  p = (char*)PGROUNDUP((uint)vstart);
8010250b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102511:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102517:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010251d:	39 de                	cmp    %ebx,%esi
8010251f:	72 27                	jb     80102548 <kinit1+0x68>
80102521:	eb 0d                	jmp    80102530 <kinit1+0x50>
80102523:	90                   	nop
80102524:	90                   	nop
80102525:	90                   	nop
80102526:	90                   	nop
80102527:	90                   	nop
80102528:	90                   	nop
80102529:	90                   	nop
8010252a:	90                   	nop
8010252b:	90                   	nop
8010252c:	90                   	nop
8010252d:	90                   	nop
8010252e:	90                   	nop
8010252f:	90                   	nop
    kfree(p);
80102530:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102536:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010253c:	89 04 24             	mov    %eax,(%esp)
8010253f:	e8 9c fe ff ff       	call   801023e0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102544:	39 de                	cmp    %ebx,%esi
80102546:	73 e8                	jae    80102530 <kinit1+0x50>
}
80102548:	83 c4 10             	add    $0x10,%esp
8010254b:	5b                   	pop    %ebx
8010254c:	5e                   	pop    %esi
8010254d:	5d                   	pop    %ebp
8010254e:	c3                   	ret    
8010254f:	90                   	nop

80102550 <kinit2>:
{
80102550:	55                   	push   %ebp
80102551:	89 e5                	mov    %esp,%ebp
80102553:	56                   	push   %esi
80102554:	53                   	push   %ebx
80102555:	83 ec 10             	sub    $0x10,%esp
  p = (char*)PGROUNDUP((uint)vstart);
80102558:	8b 45 08             	mov    0x8(%ebp),%eax
{
8010255b:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010255e:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102564:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010256a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102570:	39 de                	cmp    %ebx,%esi
80102572:	72 24                	jb     80102598 <kinit2+0x48>
80102574:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010257a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    kfree(p);
80102580:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102586:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010258c:	89 04 24             	mov    %eax,(%esp)
8010258f:	e8 4c fe ff ff       	call   801023e0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102594:	39 de                	cmp    %ebx,%esi
80102596:	73 e8                	jae    80102580 <kinit2+0x30>
  kmem.use_lock = 1;
80102598:	b8 01 00 00 00       	mov    $0x1,%eax
8010259d:	a3 d4 36 11 80       	mov    %eax,0x801136d4
}
801025a2:	83 c4 10             	add    $0x10,%esp
801025a5:	5b                   	pop    %ebx
801025a6:	5e                   	pop    %esi
801025a7:	5d                   	pop    %ebp
801025a8:	c3                   	ret    
801025a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801025b0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801025b0:	a1 d4 36 11 80       	mov    0x801136d4,%eax
801025b5:	85 c0                	test   %eax,%eax
801025b7:	75 1f                	jne    801025d8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801025b9:	a1 d8 36 11 80       	mov    0x801136d8,%eax
  if(r)
801025be:	85 c0                	test   %eax,%eax
801025c0:	74 0e                	je     801025d0 <kalloc+0x20>
    kmem.freelist = r->next;
801025c2:	8b 10                	mov    (%eax),%edx
801025c4:	89 15 d8 36 11 80    	mov    %edx,0x801136d8
801025ca:	c3                   	ret    
801025cb:	90                   	nop
801025cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
801025d0:	c3                   	ret    
801025d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
801025d8:	55                   	push   %ebp
801025d9:	89 e5                	mov    %esp,%ebp
801025db:	83 ec 28             	sub    $0x28,%esp
    acquire(&kmem.lock);
801025de:	c7 04 24 a0 36 11 80 	movl   $0x801136a0,(%esp)
801025e5:	e8 96 31 00 00       	call   80105780 <acquire>
  r = kmem.freelist;
801025ea:	a1 d8 36 11 80       	mov    0x801136d8,%eax
801025ef:	8b 15 d4 36 11 80    	mov    0x801136d4,%edx
  if(r)
801025f5:	85 c0                	test   %eax,%eax
801025f7:	74 08                	je     80102601 <kalloc+0x51>
    kmem.freelist = r->next;
801025f9:	8b 08                	mov    (%eax),%ecx
801025fb:	89 0d d8 36 11 80    	mov    %ecx,0x801136d8
  if(kmem.use_lock)
80102601:	85 d2                	test   %edx,%edx
80102603:	74 12                	je     80102617 <kalloc+0x67>
    release(&kmem.lock);
80102605:	c7 04 24 a0 36 11 80 	movl   $0x801136a0,(%esp)
8010260c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010260f:	e8 0c 32 00 00       	call   80105820 <release>
  return (char*)r;
80102614:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102617:	c9                   	leave  
80102618:	c3                   	ret    
80102619:	66 90                	xchg   %ax,%ax
8010261b:	66 90                	xchg   %ax,%ax
8010261d:	66 90                	xchg   %ax,%ax
8010261f:	90                   	nop

80102620 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102620:	ba 64 00 00 00       	mov    $0x64,%edx
80102625:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102626:	24 01                	and    $0x1,%al
80102628:	84 c0                	test   %al,%al
8010262a:	0f 84 d0 00 00 00    	je     80102700 <kbdgetc+0xe0>
{
80102630:	55                   	push   %ebp
80102631:	ba 60 00 00 00       	mov    $0x60,%edx
80102636:	89 e5                	mov    %esp,%ebp
80102638:	53                   	push   %ebx
80102639:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
8010263a:	0f b6 d0             	movzbl %al,%edx
8010263d:	8b 1d b4 b5 10 80    	mov    0x8010b5b4,%ebx

  if(data == 0xE0){
80102643:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102649:	0f 84 89 00 00 00    	je     801026d8 <kbdgetc+0xb8>
8010264f:	89 d9                	mov    %ebx,%ecx
80102651:	83 e1 40             	and    $0x40,%ecx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102654:	84 c0                	test   %al,%al
80102656:	78 58                	js     801026b0 <kbdgetc+0x90>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102658:	85 c9                	test   %ecx,%ecx
8010265a:	74 08                	je     80102664 <kbdgetc+0x44>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010265c:	0c 80                	or     $0x80,%al
    shift &= ~E0ESC;
8010265e:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102661:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102664:	0f b6 8a c0 87 10 80 	movzbl -0x7fef7840(%edx),%ecx
  shift ^= togglecode[data];
8010266b:	0f b6 82 c0 86 10 80 	movzbl -0x7fef7940(%edx),%eax
  shift |= shiftcode[data];
80102672:	09 d9                	or     %ebx,%ecx
  shift ^= togglecode[data];
80102674:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102676:	89 c8                	mov    %ecx,%eax
80102678:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010267b:	f6 c1 08             	test   $0x8,%cl
  c = charcode[shift & (CTL | SHIFT)][data];
8010267e:	8b 04 85 a0 86 10 80 	mov    -0x7fef7960(,%eax,4),%eax
  shift ^= togglecode[data];
80102685:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
  c = charcode[shift & (CTL | SHIFT)][data];
8010268b:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010268f:	74 40                	je     801026d1 <kbdgetc+0xb1>
    if('a' <= c && c <= 'z')
80102691:	8d 50 9f             	lea    -0x61(%eax),%edx
80102694:	83 fa 19             	cmp    $0x19,%edx
80102697:	76 57                	jbe    801026f0 <kbdgetc+0xd0>
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
80102699:	8d 50 bf             	lea    -0x41(%eax),%edx
8010269c:	83 fa 19             	cmp    $0x19,%edx
8010269f:	77 30                	ja     801026d1 <kbdgetc+0xb1>
      c += 'a' - 'A';
801026a1:	83 c0 20             	add    $0x20,%eax
  }
  return c;
801026a4:	eb 2b                	jmp    801026d1 <kbdgetc+0xb1>
801026a6:	8d 76 00             	lea    0x0(%esi),%esi
801026a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    data = (shift & E0ESC ? data : data & 0x7F);
801026b0:	85 c9                	test   %ecx,%ecx
801026b2:	75 05                	jne    801026b9 <kbdgetc+0x99>
801026b4:	24 7f                	and    $0x7f,%al
801026b6:	0f b6 d0             	movzbl %al,%edx
    shift &= ~(shiftcode[data] | E0ESC);
801026b9:	0f b6 82 c0 87 10 80 	movzbl -0x7fef7840(%edx),%eax
801026c0:	0c 40                	or     $0x40,%al
801026c2:	0f b6 c8             	movzbl %al,%ecx
    return 0;
801026c5:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801026c7:	f7 d1                	not    %ecx
801026c9:	21 d9                	and    %ebx,%ecx
801026cb:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
}
801026d1:	5b                   	pop    %ebx
801026d2:	5d                   	pop    %ebp
801026d3:	c3                   	ret    
801026d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801026d8:	83 cb 40             	or     $0x40,%ebx
    return 0;
801026db:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801026dd:	89 1d b4 b5 10 80    	mov    %ebx,0x8010b5b4
}
801026e3:	5b                   	pop    %ebx
801026e4:	5d                   	pop    %ebp
801026e5:	c3                   	ret    
801026e6:	8d 76 00             	lea    0x0(%esi),%esi
801026e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801026f0:	5b                   	pop    %ebx
      c += 'A' - 'a';
801026f1:	83 e8 20             	sub    $0x20,%eax
}
801026f4:	5d                   	pop    %ebp
801026f5:	c3                   	ret    
801026f6:	8d 76 00             	lea    0x0(%esi),%esi
801026f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102700:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102705:	c3                   	ret    
80102706:	8d 76 00             	lea    0x0(%esi),%esi
80102709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102710 <kbdintr>:

void
kbdintr(void)
{
80102710:	55                   	push   %ebp
80102711:	89 e5                	mov    %esp,%ebp
80102713:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
80102716:	c7 04 24 20 26 10 80 	movl   $0x80102620,(%esp)
8010271d:	e8 ae e0 ff ff       	call   801007d0 <consoleintr>
}
80102722:	c9                   	leave  
80102723:	c3                   	ret    
80102724:	66 90                	xchg   %ax,%ax
80102726:	66 90                	xchg   %ax,%ax
80102728:	66 90                	xchg   %ax,%ax
8010272a:	66 90                	xchg   %ax,%ax
8010272c:	66 90                	xchg   %ax,%ax
8010272e:	66 90                	xchg   %ax,%ax

80102730 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102730:	a1 dc 36 11 80       	mov    0x801136dc,%eax
{
80102735:	55                   	push   %ebp
80102736:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102738:	85 c0                	test   %eax,%eax
8010273a:	0f 84 c6 00 00 00    	je     80102806 <lapicinit+0xd6>
  lapic[index] = value;
80102740:	ba 3f 01 00 00       	mov    $0x13f,%edx
80102745:	b9 0b 00 00 00       	mov    $0xb,%ecx
8010274a:	89 90 f0 00 00 00    	mov    %edx,0xf0(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102750:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102753:	89 88 e0 03 00 00    	mov    %ecx,0x3e0(%eax)
80102759:	b9 80 96 98 00       	mov    $0x989680,%ecx
  lapic[ID];  // wait for write to finish, by reading
8010275e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102761:	ba 20 00 02 00       	mov    $0x20020,%edx
80102766:	89 90 20 03 00 00    	mov    %edx,0x320(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010276c:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010276f:	89 88 80 03 00 00    	mov    %ecx,0x380(%eax)
80102775:	b9 00 00 01 00       	mov    $0x10000,%ecx
  lapic[ID];  // wait for write to finish, by reading
8010277a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010277d:	ba 00 00 01 00       	mov    $0x10000,%edx
80102782:	89 90 50 03 00 00    	mov    %edx,0x350(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102788:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010278b:	89 88 60 03 00 00    	mov    %ecx,0x360(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102791:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102794:	8b 50 30             	mov    0x30(%eax),%edx
80102797:	c1 ea 10             	shr    $0x10,%edx
8010279a:	80 fa 03             	cmp    $0x3,%dl
8010279d:	77 71                	ja     80102810 <lapicinit+0xe0>
  lapic[index] = value;
8010279f:	b9 33 00 00 00       	mov    $0x33,%ecx
801027a4:	89 88 70 03 00 00    	mov    %ecx,0x370(%eax)
801027aa:	31 c9                	xor    %ecx,%ecx
  lapic[ID];  // wait for write to finish, by reading
801027ac:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027af:	31 d2                	xor    %edx,%edx
801027b1:	89 90 80 02 00 00    	mov    %edx,0x280(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027b7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027ba:	89 88 80 02 00 00    	mov    %ecx,0x280(%eax)
801027c0:	31 c9                	xor    %ecx,%ecx
  lapic[ID];  // wait for write to finish, by reading
801027c2:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027c5:	31 d2                	xor    %edx,%edx
801027c7:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027cd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027d0:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027d6:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027d9:	ba 00 85 08 00       	mov    $0x88500,%edx
801027de:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027e4:	8b 50 20             	mov    0x20(%eax),%edx
801027e7:	89 f6                	mov    %esi,%esi
801027e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801027f0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801027f6:	f6 c6 10             	test   $0x10,%dh
801027f9:	75 f5                	jne    801027f0 <lapicinit+0xc0>
  lapic[index] = value;
801027fb:	31 d2                	xor    %edx,%edx
801027fd:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102803:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102806:	5d                   	pop    %ebp
80102807:	c3                   	ret    
80102808:	90                   	nop
80102809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102810:	b9 00 00 01 00       	mov    $0x10000,%ecx
80102815:	89 88 40 03 00 00    	mov    %ecx,0x340(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010281b:	8b 50 20             	mov    0x20(%eax),%edx
8010281e:	e9 7c ff ff ff       	jmp    8010279f <lapicinit+0x6f>
80102823:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102830 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102830:	a1 dc 36 11 80       	mov    0x801136dc,%eax
{
80102835:	55                   	push   %ebp
80102836:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102838:	85 c0                	test   %eax,%eax
8010283a:	74 0c                	je     80102848 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
8010283c:	8b 40 20             	mov    0x20(%eax),%eax
}
8010283f:	5d                   	pop    %ebp
  return lapic[ID] >> 24;
80102840:	c1 e8 18             	shr    $0x18,%eax
}
80102843:	c3                   	ret    
80102844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80102848:	31 c0                	xor    %eax,%eax
}
8010284a:	5d                   	pop    %ebp
8010284b:	c3                   	ret    
8010284c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102850 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102850:	a1 dc 36 11 80       	mov    0x801136dc,%eax
{
80102855:	55                   	push   %ebp
80102856:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102858:	85 c0                	test   %eax,%eax
8010285a:	74 0b                	je     80102867 <lapiceoi+0x17>
  lapic[index] = value;
8010285c:	31 d2                	xor    %edx,%edx
8010285e:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102864:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102867:	5d                   	pop    %ebp
80102868:	c3                   	ret    
80102869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102870 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102870:	55                   	push   %ebp
80102871:	89 e5                	mov    %esp,%ebp
}
80102873:	5d                   	pop    %ebp
80102874:	c3                   	ret    
80102875:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102880 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102880:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102881:	b0 0f                	mov    $0xf,%al
80102883:	89 e5                	mov    %esp,%ebp
80102885:	ba 70 00 00 00       	mov    $0x70,%edx
8010288a:	53                   	push   %ebx
8010288b:	0f b6 4d 08          	movzbl 0x8(%ebp),%ecx
8010288f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80102892:	ee                   	out    %al,(%dx)
80102893:	b0 0a                	mov    $0xa,%al
80102895:	ba 71 00 00 00       	mov    $0x71,%edx
8010289a:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
8010289b:	31 c0                	xor    %eax,%eax
8010289d:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801028a3:	89 d8                	mov    %ebx,%eax
801028a5:	c1 e8 04             	shr    $0x4,%eax
801028a8:	66 a3 69 04 00 80    	mov    %ax,0x80000469

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801028ae:	c1 e1 18             	shl    $0x18,%ecx
  lapic[index] = value;
801028b1:	a1 dc 36 11 80       	mov    0x801136dc,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801028b6:	c1 eb 0c             	shr    $0xc,%ebx
801028b9:	81 cb 00 06 00 00    	or     $0x600,%ebx
  lapic[index] = value;
801028bf:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028c5:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028c8:	ba 00 c5 00 00       	mov    $0xc500,%edx
801028cd:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028d3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028d6:	ba 00 85 00 00       	mov    $0x8500,%edx
801028db:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028e1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028e4:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028ea:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028ed:	89 98 00 03 00 00    	mov    %ebx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028f3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028f6:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028fc:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028ff:	89 98 00 03 00 00    	mov    %ebx,0x300(%eax)
    microdelay(200);
  }
}
80102905:	5b                   	pop    %ebx
  lapic[ID];  // wait for write to finish, by reading
80102906:	8b 40 20             	mov    0x20(%eax),%eax
}
80102909:	5d                   	pop    %ebp
8010290a:	c3                   	ret    
8010290b:	90                   	nop
8010290c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102910 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102910:	55                   	push   %ebp
80102911:	b0 0b                	mov    $0xb,%al
80102913:	89 e5                	mov    %esp,%ebp
80102915:	ba 70 00 00 00       	mov    $0x70,%edx
8010291a:	57                   	push   %edi
8010291b:	56                   	push   %esi
8010291c:	53                   	push   %ebx
8010291d:	83 ec 5c             	sub    $0x5c,%esp
80102920:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102921:	ba 71 00 00 00       	mov    $0x71,%edx
80102926:	ec                   	in     (%dx),%al
80102927:	24 04                	and    $0x4,%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102929:	be 70 00 00 00       	mov    $0x70,%esi
8010292e:	88 45 b2             	mov    %al,-0x4e(%ebp)
80102931:	8d 7d d0             	lea    -0x30(%ebp),%edi
80102934:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010293a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
80102940:	31 c0                	xor    %eax,%eax
80102942:	89 f2                	mov    %esi,%edx
80102944:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102945:	bb 71 00 00 00       	mov    $0x71,%ebx
8010294a:	89 da                	mov    %ebx,%edx
8010294c:	ec                   	in     (%dx),%al
8010294d:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102950:	89 f2                	mov    %esi,%edx
80102952:	b0 02                	mov    $0x2,%al
80102954:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102955:	89 da                	mov    %ebx,%edx
80102957:	ec                   	in     (%dx),%al
80102958:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010295b:	89 f2                	mov    %esi,%edx
8010295d:	b0 04                	mov    $0x4,%al
8010295f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102960:	89 da                	mov    %ebx,%edx
80102962:	ec                   	in     (%dx),%al
80102963:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102966:	89 f2                	mov    %esi,%edx
80102968:	b0 07                	mov    $0x7,%al
8010296a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010296b:	89 da                	mov    %ebx,%edx
8010296d:	ec                   	in     (%dx),%al
8010296e:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102971:	89 f2                	mov    %esi,%edx
80102973:	b0 08                	mov    $0x8,%al
80102975:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102976:	89 da                	mov    %ebx,%edx
80102978:	ec                   	in     (%dx),%al
80102979:	88 45 b3             	mov    %al,-0x4d(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010297c:	89 f2                	mov    %esi,%edx
8010297e:	b0 09                	mov    $0x9,%al
80102980:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102981:	89 da                	mov    %ebx,%edx
80102983:	ec                   	in     (%dx),%al
80102984:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102987:	89 f2                	mov    %esi,%edx
80102989:	b0 0a                	mov    $0xa,%al
8010298b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010298c:	89 da                	mov    %ebx,%edx
8010298e:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
8010298f:	84 c0                	test   %al,%al
80102991:	78 ad                	js     80102940 <cmostime+0x30>
  return inb(CMOS_RETURN);
80102993:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102997:	89 f2                	mov    %esi,%edx
80102999:	89 4d cc             	mov    %ecx,-0x34(%ebp)
8010299c:	89 45 b8             	mov    %eax,-0x48(%ebp)
8010299f:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
801029a3:	89 45 bc             	mov    %eax,-0x44(%ebp)
801029a6:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
801029aa:	89 45 c0             	mov    %eax,-0x40(%ebp)
801029ad:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801029b1:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801029b4:	0f b6 45 b3          	movzbl -0x4d(%ebp),%eax
801029b8:	89 45 c8             	mov    %eax,-0x38(%ebp)
801029bb:	31 c0                	xor    %eax,%eax
801029bd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029be:	89 da                	mov    %ebx,%edx
801029c0:	ec                   	in     (%dx),%al
801029c1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029c4:	89 f2                	mov    %esi,%edx
801029c6:	89 45 d0             	mov    %eax,-0x30(%ebp)
801029c9:	b0 02                	mov    $0x2,%al
801029cb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029cc:	89 da                	mov    %ebx,%edx
801029ce:	ec                   	in     (%dx),%al
801029cf:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029d2:	89 f2                	mov    %esi,%edx
801029d4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801029d7:	b0 04                	mov    $0x4,%al
801029d9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029da:	89 da                	mov    %ebx,%edx
801029dc:	ec                   	in     (%dx),%al
801029dd:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029e0:	89 f2                	mov    %esi,%edx
801029e2:	89 45 d8             	mov    %eax,-0x28(%ebp)
801029e5:	b0 07                	mov    $0x7,%al
801029e7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029e8:	89 da                	mov    %ebx,%edx
801029ea:	ec                   	in     (%dx),%al
801029eb:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029ee:	89 f2                	mov    %esi,%edx
801029f0:	89 45 dc             	mov    %eax,-0x24(%ebp)
801029f3:	b0 08                	mov    $0x8,%al
801029f5:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029f6:	89 da                	mov    %ebx,%edx
801029f8:	ec                   	in     (%dx),%al
801029f9:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029fc:	89 f2                	mov    %esi,%edx
801029fe:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102a01:	b0 09                	mov    $0x9,%al
80102a03:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a04:	89 da                	mov    %ebx,%edx
80102a06:	ec                   	in     (%dx),%al
80102a07:	0f b6 c0             	movzbl %al,%eax
80102a0a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102a0d:	b8 18 00 00 00       	mov    $0x18,%eax
80102a12:	89 44 24 08          	mov    %eax,0x8(%esp)
80102a16:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102a19:	89 7c 24 04          	mov    %edi,0x4(%esp)
80102a1d:	89 04 24             	mov    %eax,(%esp)
80102a20:	e8 ab 2e 00 00       	call   801058d0 <memcmp>
80102a25:	85 c0                	test   %eax,%eax
80102a27:	0f 85 13 ff ff ff    	jne    80102940 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102a2d:	80 7d b2 00          	cmpb   $0x0,-0x4e(%ebp)
80102a31:	75 78                	jne    80102aab <cmostime+0x19b>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102a33:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a36:	89 c2                	mov    %eax,%edx
80102a38:	83 e0 0f             	and    $0xf,%eax
80102a3b:	c1 ea 04             	shr    $0x4,%edx
80102a3e:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a41:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a44:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102a47:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a4a:	89 c2                	mov    %eax,%edx
80102a4c:	83 e0 0f             	and    $0xf,%eax
80102a4f:	c1 ea 04             	shr    $0x4,%edx
80102a52:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a55:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a58:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102a5b:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a5e:	89 c2                	mov    %eax,%edx
80102a60:	83 e0 0f             	and    $0xf,%eax
80102a63:	c1 ea 04             	shr    $0x4,%edx
80102a66:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a69:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a6c:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102a6f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a72:	89 c2                	mov    %eax,%edx
80102a74:	83 e0 0f             	and    $0xf,%eax
80102a77:	c1 ea 04             	shr    $0x4,%edx
80102a7a:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a7d:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a80:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102a83:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a86:	89 c2                	mov    %eax,%edx
80102a88:	83 e0 0f             	and    $0xf,%eax
80102a8b:	c1 ea 04             	shr    $0x4,%edx
80102a8e:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a91:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a94:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102a97:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a9a:	89 c2                	mov    %eax,%edx
80102a9c:	83 e0 0f             	and    $0xf,%eax
80102a9f:	c1 ea 04             	shr    $0x4,%edx
80102aa2:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102aa5:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102aa8:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102aab:	31 c0                	xor    %eax,%eax
80102aad:	8b 54 05 b8          	mov    -0x48(%ebp,%eax,1),%edx
80102ab1:	8b 7d 08             	mov    0x8(%ebp),%edi
80102ab4:	89 14 07             	mov    %edx,(%edi,%eax,1)
80102ab7:	83 c0 04             	add    $0x4,%eax
80102aba:	83 f8 18             	cmp    $0x18,%eax
80102abd:	72 ee                	jb     80102aad <cmostime+0x19d>
  r->year += 2000;
80102abf:	81 47 14 d0 07 00 00 	addl   $0x7d0,0x14(%edi)
}
80102ac6:	83 c4 5c             	add    $0x5c,%esp
80102ac9:	5b                   	pop    %ebx
80102aca:	5e                   	pop    %esi
80102acb:	5f                   	pop    %edi
80102acc:	5d                   	pop    %ebp
80102acd:	c3                   	ret    
80102ace:	66 90                	xchg   %ax,%ax

80102ad0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ad0:	8b 15 28 37 11 80    	mov    0x80113728,%edx
80102ad6:	85 d2                	test   %edx,%edx
80102ad8:	0f 8e 92 00 00 00    	jle    80102b70 <install_trans+0xa0>
{
80102ade:	55                   	push   %ebp
80102adf:	89 e5                	mov    %esp,%ebp
80102ae1:	57                   	push   %edi
80102ae2:	56                   	push   %esi
80102ae3:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102ae4:	31 db                	xor    %ebx,%ebx
{
80102ae6:	83 ec 1c             	sub    $0x1c,%esp
80102ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102af0:	a1 14 37 11 80       	mov    0x80113714,%eax
80102af5:	01 d8                	add    %ebx,%eax
80102af7:	40                   	inc    %eax
80102af8:	89 44 24 04          	mov    %eax,0x4(%esp)
80102afc:	a1 24 37 11 80       	mov    0x80113724,%eax
80102b01:	89 04 24             	mov    %eax,(%esp)
80102b04:	e8 c7 d5 ff ff       	call   801000d0 <bread>
80102b09:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b0b:	8b 04 9d 2c 37 11 80 	mov    -0x7feec8d4(,%ebx,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
80102b12:	43                   	inc    %ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b13:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b17:	a1 24 37 11 80       	mov    0x80113724,%eax
80102b1c:	89 04 24             	mov    %eax,(%esp)
80102b1f:	e8 ac d5 ff ff       	call   801000d0 <bread>
80102b24:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102b26:	b8 00 02 00 00       	mov    $0x200,%eax
80102b2b:	89 44 24 08          	mov    %eax,0x8(%esp)
80102b2f:	8d 47 5c             	lea    0x5c(%edi),%eax
80102b32:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b36:	8d 46 5c             	lea    0x5c(%esi),%eax
80102b39:	89 04 24             	mov    %eax,(%esp)
80102b3c:	e8 ef 2d 00 00       	call   80105930 <memmove>
    bwrite(dbuf);  // write dst to disk
80102b41:	89 34 24             	mov    %esi,(%esp)
80102b44:	e8 57 d6 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102b49:	89 3c 24             	mov    %edi,(%esp)
80102b4c:	e8 8f d6 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102b51:	89 34 24             	mov    %esi,(%esp)
80102b54:	e8 87 d6 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102b59:	39 1d 28 37 11 80    	cmp    %ebx,0x80113728
80102b5f:	7f 8f                	jg     80102af0 <install_trans+0x20>
  }
}
80102b61:	83 c4 1c             	add    $0x1c,%esp
80102b64:	5b                   	pop    %ebx
80102b65:	5e                   	pop    %esi
80102b66:	5f                   	pop    %edi
80102b67:	5d                   	pop    %ebp
80102b68:	c3                   	ret    
80102b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b70:	c3                   	ret    
80102b71:	eb 0d                	jmp    80102b80 <write_head>
80102b73:	90                   	nop
80102b74:	90                   	nop
80102b75:	90                   	nop
80102b76:	90                   	nop
80102b77:	90                   	nop
80102b78:	90                   	nop
80102b79:	90                   	nop
80102b7a:	90                   	nop
80102b7b:	90                   	nop
80102b7c:	90                   	nop
80102b7d:	90                   	nop
80102b7e:	90                   	nop
80102b7f:	90                   	nop

80102b80 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102b80:	55                   	push   %ebp
80102b81:	89 e5                	mov    %esp,%ebp
80102b83:	56                   	push   %esi
80102b84:	53                   	push   %ebx
80102b85:	83 ec 10             	sub    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102b88:	a1 14 37 11 80       	mov    0x80113714,%eax
80102b8d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b91:	a1 24 37 11 80       	mov    0x80113724,%eax
80102b96:	89 04 24             	mov    %eax,(%esp)
80102b99:	e8 32 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b9e:	8b 1d 28 37 11 80    	mov    0x80113728,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102ba4:	85 db                	test   %ebx,%ebx
  struct buf *buf = bread(log.dev, log.start);
80102ba6:	89 c6                	mov    %eax,%esi
  hb->n = log.lh.n;
80102ba8:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102bab:	7e 24                	jle    80102bd1 <write_head+0x51>
80102bad:	c1 e3 02             	shl    $0x2,%ebx
80102bb0:	31 d2                	xor    %edx,%edx
80102bb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    hb->block[i] = log.lh.block[i];
80102bc0:	8b 8a 2c 37 11 80    	mov    -0x7feec8d4(%edx),%ecx
80102bc6:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102bca:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102bcd:	39 da                	cmp    %ebx,%edx
80102bcf:	75 ef                	jne    80102bc0 <write_head+0x40>
  }
  bwrite(buf);
80102bd1:	89 34 24             	mov    %esi,(%esp)
80102bd4:	e8 c7 d5 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102bd9:	89 34 24             	mov    %esi,(%esp)
80102bdc:	e8 ff d5 ff ff       	call   801001e0 <brelse>
}
80102be1:	83 c4 10             	add    $0x10,%esp
80102be4:	5b                   	pop    %ebx
80102be5:	5e                   	pop    %esi
80102be6:	5d                   	pop    %ebp
80102be7:	c3                   	ret    
80102be8:	90                   	nop
80102be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102bf0 <initlog>:
{
80102bf0:	55                   	push   %ebp
  initlock(&log.lock, "log");
80102bf1:	ba c0 88 10 80       	mov    $0x801088c0,%edx
{
80102bf6:	89 e5                	mov    %esp,%ebp
80102bf8:	53                   	push   %ebx
80102bf9:	83 ec 34             	sub    $0x34,%esp
80102bfc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102bff:	89 54 24 04          	mov    %edx,0x4(%esp)
80102c03:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
80102c0a:	e8 21 2a 00 00       	call   80105630 <initlock>
  readsb(dev, &sb);
80102c0f:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102c12:	89 44 24 04          	mov    %eax,0x4(%esp)
80102c16:	89 1c 24             	mov    %ebx,(%esp)
80102c19:	e8 b2 e7 ff ff       	call   801013d0 <readsb>
  log.start = sb.logstart;
80102c1e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  log.size = sb.nlog;
80102c21:	8b 55 e8             	mov    -0x18(%ebp),%edx
  struct buf *buf = bread(log.dev, log.start);
80102c24:	89 1c 24             	mov    %ebx,(%esp)
  log.dev = dev;
80102c27:	89 1d 24 37 11 80    	mov    %ebx,0x80113724
  struct buf *buf = bread(log.dev, log.start);
80102c2d:	89 44 24 04          	mov    %eax,0x4(%esp)
  log.start = sb.logstart;
80102c31:	a3 14 37 11 80       	mov    %eax,0x80113714
  log.size = sb.nlog;
80102c36:	89 15 18 37 11 80    	mov    %edx,0x80113718
  struct buf *buf = bread(log.dev, log.start);
80102c3c:	e8 8f d4 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102c41:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102c44:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102c46:	89 1d 28 37 11 80    	mov    %ebx,0x80113728
  for (i = 0; i < log.lh.n; i++) {
80102c4c:	7e 23                	jle    80102c71 <initlog+0x81>
80102c4e:	c1 e3 02             	shl    $0x2,%ebx
80102c51:	31 d2                	xor    %edx,%edx
80102c53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.lh.block[i] = lh->block[i];
80102c60:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102c64:	83 c2 04             	add    $0x4,%edx
80102c67:	89 8a 28 37 11 80    	mov    %ecx,-0x7feec8d8(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102c6d:	39 d3                	cmp    %edx,%ebx
80102c6f:	75 ef                	jne    80102c60 <initlog+0x70>
  brelse(buf);
80102c71:	89 04 24             	mov    %eax,(%esp)
80102c74:	e8 67 d5 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102c79:	e8 52 fe ff ff       	call   80102ad0 <install_trans>
  log.lh.n = 0;
80102c7e:	31 c0                	xor    %eax,%eax
80102c80:	a3 28 37 11 80       	mov    %eax,0x80113728
  write_head(); // clear the log
80102c85:	e8 f6 fe ff ff       	call   80102b80 <write_head>
}
80102c8a:	83 c4 34             	add    $0x34,%esp
80102c8d:	5b                   	pop    %ebx
80102c8e:	5d                   	pop    %ebp
80102c8f:	c3                   	ret    

80102c90 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102c90:	55                   	push   %ebp
80102c91:	89 e5                	mov    %esp,%ebp
80102c93:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
80102c96:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
80102c9d:	e8 de 2a 00 00       	call   80105780 <acquire>
80102ca2:	eb 19                	jmp    80102cbd <begin_op+0x2d>
80102ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102ca8:	b8 e0 36 11 80       	mov    $0x801136e0,%eax
80102cad:	89 44 24 04          	mov    %eax,0x4(%esp)
80102cb1:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
80102cb8:	e8 b3 15 00 00       	call   80104270 <sleep>
    if(log.committing){
80102cbd:	8b 15 20 37 11 80    	mov    0x80113720,%edx
80102cc3:	85 d2                	test   %edx,%edx
80102cc5:	75 e1                	jne    80102ca8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102cc7:	a1 1c 37 11 80       	mov    0x8011371c,%eax
80102ccc:	8b 15 28 37 11 80    	mov    0x80113728,%edx
80102cd2:	40                   	inc    %eax
80102cd3:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102cd6:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102cd9:	83 fa 1e             	cmp    $0x1e,%edx
80102cdc:	7f ca                	jg     80102ca8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102cde:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
      log.outstanding += 1;
80102ce5:	a3 1c 37 11 80       	mov    %eax,0x8011371c
      release(&log.lock);
80102cea:	e8 31 2b 00 00       	call   80105820 <release>
      break;
    }
  }
}
80102cef:	c9                   	leave  
80102cf0:	c3                   	ret    
80102cf1:	eb 0d                	jmp    80102d00 <end_op>
80102cf3:	90                   	nop
80102cf4:	90                   	nop
80102cf5:	90                   	nop
80102cf6:	90                   	nop
80102cf7:	90                   	nop
80102cf8:	90                   	nop
80102cf9:	90                   	nop
80102cfa:	90                   	nop
80102cfb:	90                   	nop
80102cfc:	90                   	nop
80102cfd:	90                   	nop
80102cfe:	90                   	nop
80102cff:	90                   	nop

80102d00 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102d00:	55                   	push   %ebp
80102d01:	89 e5                	mov    %esp,%ebp
80102d03:	57                   	push   %edi
80102d04:	56                   	push   %esi
80102d05:	53                   	push   %ebx
80102d06:	83 ec 1c             	sub    $0x1c,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102d09:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
80102d10:	e8 6b 2a 00 00       	call   80105780 <acquire>
  log.outstanding -= 1;
80102d15:	a1 1c 37 11 80       	mov    0x8011371c,%eax
80102d1a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102d1d:	a1 20 37 11 80       	mov    0x80113720,%eax
  log.outstanding -= 1;
80102d22:	89 1d 1c 37 11 80    	mov    %ebx,0x8011371c
  if(log.committing)
80102d28:	85 c0                	test   %eax,%eax
80102d2a:	0f 85 e8 00 00 00    	jne    80102e18 <end_op+0x118>
    panic("log.committing");
  if(log.outstanding == 0){
80102d30:	85 db                	test   %ebx,%ebx
80102d32:	0f 85 c0 00 00 00    	jne    80102df8 <end_op+0xf8>
    do_commit = 1;
    log.committing = 1;
80102d38:	be 01 00 00 00       	mov    $0x1,%esi
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102d3d:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
    log.committing = 1;
80102d44:	89 35 20 37 11 80    	mov    %esi,0x80113720
  release(&log.lock);
80102d4a:	e8 d1 2a 00 00       	call   80105820 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d4f:	8b 3d 28 37 11 80    	mov    0x80113728,%edi
80102d55:	85 ff                	test   %edi,%edi
80102d57:	0f 8e 88 00 00 00    	jle    80102de5 <end_op+0xe5>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102d5d:	a1 14 37 11 80       	mov    0x80113714,%eax
80102d62:	01 d8                	add    %ebx,%eax
80102d64:	40                   	inc    %eax
80102d65:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d69:	a1 24 37 11 80       	mov    0x80113724,%eax
80102d6e:	89 04 24             	mov    %eax,(%esp)
80102d71:	e8 5a d3 ff ff       	call   801000d0 <bread>
80102d76:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d78:	8b 04 9d 2c 37 11 80 	mov    -0x7feec8d4(,%ebx,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
80102d7f:	43                   	inc    %ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d80:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d84:	a1 24 37 11 80       	mov    0x80113724,%eax
80102d89:	89 04 24             	mov    %eax,(%esp)
80102d8c:	e8 3f d3 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102d91:	b9 00 02 00 00       	mov    $0x200,%ecx
80102d96:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d9a:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102d9c:	8d 40 5c             	lea    0x5c(%eax),%eax
80102d9f:	89 44 24 04          	mov    %eax,0x4(%esp)
80102da3:	8d 46 5c             	lea    0x5c(%esi),%eax
80102da6:	89 04 24             	mov    %eax,(%esp)
80102da9:	e8 82 2b 00 00       	call   80105930 <memmove>
    bwrite(to);  // write the log
80102dae:	89 34 24             	mov    %esi,(%esp)
80102db1:	e8 ea d3 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102db6:	89 3c 24             	mov    %edi,(%esp)
80102db9:	e8 22 d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102dbe:	89 34 24             	mov    %esi,(%esp)
80102dc1:	e8 1a d4 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102dc6:	3b 1d 28 37 11 80    	cmp    0x80113728,%ebx
80102dcc:	7c 8f                	jl     80102d5d <end_op+0x5d>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102dce:	e8 ad fd ff ff       	call   80102b80 <write_head>
    install_trans(); // Now install writes to home locations
80102dd3:	e8 f8 fc ff ff       	call   80102ad0 <install_trans>
    log.lh.n = 0;
80102dd8:	31 d2                	xor    %edx,%edx
80102dda:	89 15 28 37 11 80    	mov    %edx,0x80113728
    write_head();    // Erase the transaction from the log
80102de0:	e8 9b fd ff ff       	call   80102b80 <write_head>
    acquire(&log.lock);
80102de5:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
80102dec:	e8 8f 29 00 00       	call   80105780 <acquire>
    log.committing = 0;
80102df1:	31 c0                	xor    %eax,%eax
80102df3:	a3 20 37 11 80       	mov    %eax,0x80113720
    wakeup(&log);
80102df8:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
80102dff:	e8 4c 16 00 00       	call   80104450 <wakeup>
    release(&log.lock);
80102e04:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
80102e0b:	e8 10 2a 00 00       	call   80105820 <release>
}
80102e10:	83 c4 1c             	add    $0x1c,%esp
80102e13:	5b                   	pop    %ebx
80102e14:	5e                   	pop    %esi
80102e15:	5f                   	pop    %edi
80102e16:	5d                   	pop    %ebp
80102e17:	c3                   	ret    
    panic("log.committing");
80102e18:	c7 04 24 c4 88 10 80 	movl   $0x801088c4,(%esp)
80102e1f:	e8 4c d5 ff ff       	call   80100370 <panic>
80102e24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102e2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102e30 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102e30:	55                   	push   %ebp
80102e31:	89 e5                	mov    %esp,%ebp
80102e33:	53                   	push   %ebx
80102e34:	83 ec 14             	sub    $0x14,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e37:	8b 15 28 37 11 80    	mov    0x80113728,%edx
{
80102e3d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e40:	83 fa 1d             	cmp    $0x1d,%edx
80102e43:	0f 8f 95 00 00 00    	jg     80102ede <log_write+0xae>
80102e49:	a1 18 37 11 80       	mov    0x80113718,%eax
80102e4e:	48                   	dec    %eax
80102e4f:	39 c2                	cmp    %eax,%edx
80102e51:	0f 8d 87 00 00 00    	jge    80102ede <log_write+0xae>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102e57:	a1 1c 37 11 80       	mov    0x8011371c,%eax
80102e5c:	85 c0                	test   %eax,%eax
80102e5e:	0f 8e 86 00 00 00    	jle    80102eea <log_write+0xba>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102e64:	c7 04 24 e0 36 11 80 	movl   $0x801136e0,(%esp)
80102e6b:	e8 10 29 00 00       	call   80105780 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102e70:	8b 0d 28 37 11 80    	mov    0x80113728,%ecx
80102e76:	83 f9 00             	cmp    $0x0,%ecx
80102e79:	7e 55                	jle    80102ed0 <log_write+0xa0>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e7b:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102e7e:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e80:	3b 15 2c 37 11 80    	cmp    0x8011372c,%edx
80102e86:	75 11                	jne    80102e99 <log_write+0x69>
80102e88:	eb 36                	jmp    80102ec0 <log_write+0x90>
80102e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102e90:	39 14 85 2c 37 11 80 	cmp    %edx,-0x7feec8d4(,%eax,4)
80102e97:	74 27                	je     80102ec0 <log_write+0x90>
  for (i = 0; i < log.lh.n; i++) {
80102e99:	40                   	inc    %eax
80102e9a:	39 c1                	cmp    %eax,%ecx
80102e9c:	75 f2                	jne    80102e90 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102e9e:	89 14 85 2c 37 11 80 	mov    %edx,-0x7feec8d4(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102ea5:	40                   	inc    %eax
80102ea6:	a3 28 37 11 80       	mov    %eax,0x80113728
  b->flags |= B_DIRTY; // prevent eviction
80102eab:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102eae:	c7 45 08 e0 36 11 80 	movl   $0x801136e0,0x8(%ebp)
}
80102eb5:	83 c4 14             	add    $0x14,%esp
80102eb8:	5b                   	pop    %ebx
80102eb9:	5d                   	pop    %ebp
  release(&log.lock);
80102eba:	e9 61 29 00 00       	jmp    80105820 <release>
80102ebf:	90                   	nop
  log.lh.block[i] = b->blockno;
80102ec0:	89 14 85 2c 37 11 80 	mov    %edx,-0x7feec8d4(,%eax,4)
80102ec7:	eb e2                	jmp    80102eab <log_write+0x7b>
80102ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ed0:	8b 43 08             	mov    0x8(%ebx),%eax
80102ed3:	a3 2c 37 11 80       	mov    %eax,0x8011372c
  if (i == log.lh.n)
80102ed8:	75 d1                	jne    80102eab <log_write+0x7b>
80102eda:	31 c0                	xor    %eax,%eax
80102edc:	eb c7                	jmp    80102ea5 <log_write+0x75>
    panic("too big a transaction");
80102ede:	c7 04 24 d3 88 10 80 	movl   $0x801088d3,(%esp)
80102ee5:	e8 86 d4 ff ff       	call   80100370 <panic>
    panic("log_write outside of trans");
80102eea:	c7 04 24 e9 88 10 80 	movl   $0x801088e9,(%esp)
80102ef1:	e8 7a d4 ff ff       	call   80100370 <panic>
80102ef6:	66 90                	xchg   %ax,%ax
80102ef8:	66 90                	xchg   %ax,%ax
80102efa:	66 90                	xchg   %ax,%ax
80102efc:	66 90                	xchg   %ax,%ax
80102efe:	66 90                	xchg   %ax,%ax

80102f00 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102f00:	55                   	push   %ebp
80102f01:	89 e5                	mov    %esp,%ebp
80102f03:	53                   	push   %ebx
80102f04:	83 ec 14             	sub    $0x14,%esp
  switchkvm();
80102f07:	e8 04 4e 00 00       	call   80107d10 <switchkvm>
  seginit();
80102f0c:	e8 6f 4d 00 00       	call   80107c80 <seginit>
  lapicinit();
80102f11:	e8 1a f8 ff ff       	call   80102730 <lapicinit>
}

static void
mpmain(void) //called by the non-boot AP cpus
{
  struct cpu* c = mycpu();
80102f16:	e8 c5 09 00 00       	call   801038e0 <mycpu>
80102f1b:	89 c3                	mov    %eax,%ebx
  cprintf("cpu%d: is witing for the \"pioneer\" cpu to finish its initialization.\n", cpuid());
80102f1d:	e8 3e 0a 00 00       	call   80103960 <cpuid>
80102f22:	c7 04 24 04 89 10 80 	movl   $0x80108904,(%esp)
80102f29:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f2d:	e8 1e d7 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80102f32:	e8 89 3c 00 00       	call   80106bc0 <idtinit>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102f37:	b8 01 00 00 00       	mov    $0x1,%eax
80102f3c:	f0 87 83 a0 00 00 00 	lock xchg %eax,0xa0(%ebx)
80102f43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  xchg(&(c->started), 1); // tell startothers() we're up
  while(c->started != 0); // wait for the "pioneer" cpu to finish the scheduling data structures initialization
80102f50:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102f56:	85 c0                	test   %eax,%eax
80102f58:	75 f6                	jne    80102f50 <mpenter+0x50>
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102f5a:	e8 01 0a 00 00       	call   80103960 <cpuid>
80102f5f:	89 c3                	mov    %eax,%ebx
80102f61:	e8 fa 09 00 00       	call   80103960 <cpuid>
80102f66:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80102f6a:	c7 04 24 54 89 10 80 	movl   $0x80108954,(%esp)
80102f71:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f75:	e8 d6 d6 ff ff       	call   80100650 <cprintf>
  scheduler();     // start running processes
80102f7a:	e8 31 10 00 00       	call   80103fb0 <scheduler>
80102f7f:	90                   	nop

80102f80 <main>:
{
80102f80:	55                   	push   %ebp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102f81:	b8 00 00 40 80       	mov    $0x80400000,%eax
{
80102f86:	89 e5                	mov    %esp,%ebp
80102f88:	53                   	push   %ebx
80102f89:	83 e4 f0             	and    $0xfffffff0,%esp
80102f8c:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102f8f:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f93:	c7 04 24 08 69 11 80 	movl   $0x80116908,(%esp)
80102f9a:	e8 41 f5 ff ff       	call   801024e0 <kinit1>
  kvmalloc();      // kernel page table
80102f9f:	e8 3c 52 00 00       	call   801081e0 <kvmalloc>
  mpinit();        // detect other processors
80102fa4:	e8 17 02 00 00       	call   801031c0 <mpinit>
  lapicinit();     // interrupt controller
80102fa9:	e8 82 f7 ff ff       	call   80102730 <lapicinit>
80102fae:	66 90                	xchg   %ax,%ax
  seginit();       // segment descriptors
80102fb0:	e8 cb 4c 00 00       	call   80107c80 <seginit>
  picinit();       // disable pic
80102fb5:	e8 e6 03 00 00       	call   801033a0 <picinit>
  ioapicinit();    // another interrupt controller
80102fba:	e8 31 f3 ff ff       	call   801022f0 <ioapicinit>
80102fbf:	90                   	nop
  consoleinit();   // console hardware
80102fc0:	e8 bb d9 ff ff       	call   80100980 <consoleinit>
  uartinit();      // serial port
80102fc5:	e8 86 3f 00 00       	call   80106f50 <uartinit>
  pinit();         // process table
80102fca:	e8 f1 08 00 00       	call   801038c0 <pinit>
80102fcf:	90                   	nop
  tvinit();        // trap vectors
80102fd0:	e8 6b 3b 00 00       	call   80106b40 <tvinit>
  binit();         // buffer cache
80102fd5:	e8 66 d0 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102fda:	e8 71 dd ff ff       	call   80100d50 <fileinit>
80102fdf:	90                   	nop
  ideinit();       // disk 
80102fe0:	e8 fb f0 ff ff       	call   801020e0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102fe5:	b8 8a 00 00 00       	mov    $0x8a,%eax
80102fea:	89 44 24 08          	mov    %eax,0x8(%esp)
80102fee:	b8 8c b4 10 80       	mov    $0x8010b48c,%eax
80102ff3:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ff7:	c7 04 24 00 70 00 80 	movl   $0x80007000,(%esp)
80102ffe:	e8 2d 29 00 00       	call   80105930 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103003:	a1 60 3d 11 80       	mov    0x80113d60,%eax
80103008:	8d 14 80             	lea    (%eax,%eax,4),%edx
8010300b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010300e:	c1 e0 04             	shl    $0x4,%eax
80103011:	05 e0 37 11 80       	add    $0x801137e0,%eax
80103016:	3d e0 37 11 80       	cmp    $0x801137e0,%eax
8010301b:	0f 86 86 00 00 00    	jbe    801030a7 <main+0x127>
80103021:	bb e0 37 11 80       	mov    $0x801137e0,%ebx
80103026:	8d 76 00             	lea    0x0(%esi),%esi
80103029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80103030:	e8 ab 08 00 00       	call   801038e0 <mycpu>
80103035:	39 d8                	cmp    %ebx,%eax
80103037:	74 51                	je     8010308a <main+0x10a>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103039:	e8 72 f5 ff ff       	call   801025b0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
8010303e:	ba 00 2f 10 80       	mov    $0x80102f00,%edx
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103043:	b9 00 a0 10 00       	mov    $0x10a000,%ecx
    *(void(**)(void))(code-8) = mpenter;
80103048:	89 15 f8 6f 00 80    	mov    %edx,0x80006ff8
    *(int**)(code-12) = (void *) V2P(entrypgdir);
8010304e:	89 0d f4 6f 00 80    	mov    %ecx,0x80006ff4
    *(void**)(code-4) = stack + KSTACKSIZE;
80103054:	05 00 10 00 00       	add    $0x1000,%eax
80103059:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
8010305e:	b8 00 70 00 00       	mov    $0x7000,%eax
80103063:	89 44 24 04          	mov    %eax,0x4(%esp)
80103067:	0f b6 03             	movzbl (%ebx),%eax
8010306a:	89 04 24             	mov    %eax,(%esp)
8010306d:	e8 0e f8 ff ff       	call   80102880 <lapicstartap>
80103072:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103080:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103086:	85 c0                	test   %eax,%eax
80103088:	74 f6                	je     80103080 <main+0x100>
  for(c = cpus; c < cpus+ncpu; c++){
8010308a:	a1 60 3d 11 80       	mov    0x80113d60,%eax
8010308f:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103095:	8d 14 80             	lea    (%eax,%eax,4),%edx
80103098:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010309b:	c1 e0 04             	shl    $0x4,%eax
8010309e:	05 e0 37 11 80       	add    $0x801137e0,%eax
801030a3:	39 c3                	cmp    %eax,%ebx
801030a5:	72 89                	jb     80103030 <main+0xb0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801030a7:	b8 00 00 00 8e       	mov    $0x8e000000,%eax
801030ac:	89 44 24 04          	mov    %eax,0x4(%esp)
801030b0:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
801030b7:	e8 94 f4 ff ff       	call   80102550 <kinit2>
  initSchedDS(); // initialize the data structures for the processes sceduling policies
801030bc:	e8 df 19 00 00       	call   80104aa0 <initSchedDS>
	__sync_synchronize();
801030c1:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  for(struct cpu *c = cpus; c < cpus + ncpu; ++c) //releases the non-boot AP cpus that are wating at mpmain at main.c
801030c6:	a1 60 3d 11 80       	mov    0x80113d60,%eax
801030cb:	8d 14 80             	lea    (%eax,%eax,4),%edx
801030ce:	8d 0c 50             	lea    (%eax,%edx,2),%ecx
801030d1:	c1 e1 04             	shl    $0x4,%ecx
801030d4:	81 c1 e0 37 11 80    	add    $0x801137e0,%ecx
801030da:	81 f9 e0 37 11 80    	cmp    $0x801137e0,%ecx
801030e0:	76 21                	jbe    80103103 <main+0x183>
801030e2:	ba e0 37 11 80       	mov    $0x801137e0,%edx
801030e7:	31 db                	xor    %ebx,%ebx
801030e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030f0:	89 d8                	mov    %ebx,%eax
801030f2:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
801030f9:	81 c2 b0 00 00 00    	add    $0xb0,%edx
801030ff:	39 ca                	cmp    %ecx,%edx
80103101:	72 ed                	jb     801030f0 <main+0x170>
  userinit();      // first user process
80103103:	e8 a8 08 00 00       	call   801039b0 <userinit>
  cprintf("\"pioneer\" cpu%d: starting %d\n", cpuid(), cpuid());
80103108:	e8 53 08 00 00       	call   80103960 <cpuid>
8010310d:	89 c3                	mov    %eax,%ebx
8010310f:	e8 4c 08 00 00       	call   80103960 <cpuid>
80103114:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80103118:	c7 04 24 4a 89 10 80 	movl   $0x8010894a,(%esp)
8010311f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103123:	e8 28 d5 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80103128:	e8 93 3a 00 00       	call   80106bc0 <idtinit>
  scheduler();     // start running processes
8010312d:	e8 7e 0e 00 00       	call   80103fb0 <scheduler>
80103132:	66 90                	xchg   %ax,%ax
80103134:	66 90                	xchg   %ax,%ax
80103136:	66 90                	xchg   %ax,%ax
80103138:	66 90                	xchg   %ax,%ax
8010313a:	66 90                	xchg   %ax,%ax
8010313c:	66 90                	xchg   %ax,%ax
8010313e:	66 90                	xchg   %ax,%ax

80103140 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103140:	55                   	push   %ebp
80103141:	89 e5                	mov    %esp,%ebp
80103143:	57                   	push   %edi
80103144:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103145:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010314b:	53                   	push   %ebx
  e = addr+len;
8010314c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010314f:	83 ec 1c             	sub    $0x1c,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103152:	39 de                	cmp    %ebx,%esi
80103154:	72 10                	jb     80103166 <mpsearch1+0x26>
80103156:	eb 58                	jmp    801031b0 <mpsearch1+0x70>
80103158:	90                   	nop
80103159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103160:	39 d3                	cmp    %edx,%ebx
80103162:	89 d6                	mov    %edx,%esi
80103164:	76 4a                	jbe    801031b0 <mpsearch1+0x70>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103166:	ba 68 89 10 80       	mov    $0x80108968,%edx
8010316b:	b8 04 00 00 00       	mov    $0x4,%eax
80103170:	89 54 24 04          	mov    %edx,0x4(%esp)
80103174:	89 44 24 08          	mov    %eax,0x8(%esp)
80103178:	89 34 24             	mov    %esi,(%esp)
8010317b:	e8 50 27 00 00       	call   801058d0 <memcmp>
80103180:	8d 56 10             	lea    0x10(%esi),%edx
80103183:	85 c0                	test   %eax,%eax
80103185:	75 d9                	jne    80103160 <mpsearch1+0x20>
80103187:	89 f1                	mov    %esi,%ecx
80103189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103190:	0f b6 39             	movzbl (%ecx),%edi
80103193:	41                   	inc    %ecx
80103194:	01 f8                	add    %edi,%eax
  for(i=0; i<len; i++)
80103196:	39 d1                	cmp    %edx,%ecx
80103198:	75 f6                	jne    80103190 <mpsearch1+0x50>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010319a:	84 c0                	test   %al,%al
8010319c:	75 c2                	jne    80103160 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
8010319e:	83 c4 1c             	add    $0x1c,%esp
801031a1:	89 f0                	mov    %esi,%eax
801031a3:	5b                   	pop    %ebx
801031a4:	5e                   	pop    %esi
801031a5:	5f                   	pop    %edi
801031a6:	5d                   	pop    %ebp
801031a7:	c3                   	ret    
801031a8:	90                   	nop
801031a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031b0:	83 c4 1c             	add    $0x1c,%esp
  return 0;
801031b3:	31 f6                	xor    %esi,%esi
}
801031b5:	5b                   	pop    %ebx
801031b6:	89 f0                	mov    %esi,%eax
801031b8:	5e                   	pop    %esi
801031b9:	5f                   	pop    %edi
801031ba:	5d                   	pop    %ebp
801031bb:	c3                   	ret    
801031bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801031c0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801031c0:	55                   	push   %ebp
801031c1:	89 e5                	mov    %esp,%ebp
801031c3:	57                   	push   %edi
801031c4:	56                   	push   %esi
801031c5:	53                   	push   %ebx
801031c6:	83 ec 2c             	sub    $0x2c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801031c9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801031d0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801031d7:	c1 e0 08             	shl    $0x8,%eax
801031da:	09 d0                	or     %edx,%eax
801031dc:	c1 e0 04             	shl    $0x4,%eax
801031df:	75 1b                	jne    801031fc <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801031e1:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801031e8:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801031ef:	c1 e0 08             	shl    $0x8,%eax
801031f2:	09 d0                	or     %edx,%eax
801031f4:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801031f7:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
801031fc:	ba 00 04 00 00       	mov    $0x400,%edx
80103201:	e8 3a ff ff ff       	call   80103140 <mpsearch1>
80103206:	85 c0                	test   %eax,%eax
80103208:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010320b:	0f 84 4f 01 00 00    	je     80103360 <mpinit+0x1a0>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103211:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103214:	8b 58 04             	mov    0x4(%eax),%ebx
80103217:	85 db                	test   %ebx,%ebx
80103219:	0f 84 61 01 00 00    	je     80103380 <mpinit+0x1c0>
  if(memcmp(conf, "PCMP", 4) != 0)
8010321f:	b8 04 00 00 00       	mov    $0x4,%eax
80103224:	ba 85 89 10 80       	mov    $0x80108985,%edx
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103229:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
8010322f:	89 44 24 08          	mov    %eax,0x8(%esp)
80103233:	89 54 24 04          	mov    %edx,0x4(%esp)
80103237:	89 34 24             	mov    %esi,(%esp)
8010323a:	e8 91 26 00 00       	call   801058d0 <memcmp>
8010323f:	85 c0                	test   %eax,%eax
80103241:	0f 85 39 01 00 00    	jne    80103380 <mpinit+0x1c0>
  if(conf->version != 1 && conf->version != 4)
80103247:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
8010324e:	3c 01                	cmp    $0x1,%al
80103250:	0f 95 c2             	setne  %dl
80103253:	3c 04                	cmp    $0x4,%al
80103255:	0f 95 c0             	setne  %al
80103258:	20 d0                	and    %dl,%al
8010325a:	0f 85 20 01 00 00    	jne    80103380 <mpinit+0x1c0>
  if(sum((uchar*)conf, conf->length) != 0)
80103260:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
80103267:	85 ff                	test   %edi,%edi
80103269:	74 24                	je     8010328f <mpinit+0xcf>
8010326b:	89 f0                	mov    %esi,%eax
8010326d:	01 f7                	add    %esi,%edi
  sum = 0;
8010326f:	31 d2                	xor    %edx,%edx
80103271:	eb 0d                	jmp    80103280 <mpinit+0xc0>
80103273:	90                   	nop
80103274:	90                   	nop
80103275:	90                   	nop
80103276:	90                   	nop
80103277:	90                   	nop
80103278:	90                   	nop
80103279:	90                   	nop
8010327a:	90                   	nop
8010327b:	90                   	nop
8010327c:	90                   	nop
8010327d:	90                   	nop
8010327e:	90                   	nop
8010327f:	90                   	nop
    sum += addr[i];
80103280:	0f b6 08             	movzbl (%eax),%ecx
80103283:	40                   	inc    %eax
80103284:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103286:	39 c7                	cmp    %eax,%edi
80103288:	75 f6                	jne    80103280 <mpinit+0xc0>
8010328a:	84 d2                	test   %dl,%dl
8010328c:	0f 95 c0             	setne  %al
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
8010328f:	85 f6                	test   %esi,%esi
80103291:	0f 84 e9 00 00 00    	je     80103380 <mpinit+0x1c0>
80103297:	84 c0                	test   %al,%al
80103299:	0f 85 e1 00 00 00    	jne    80103380 <mpinit+0x1c0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
8010329f:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032a5:	8d 93 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%edx
  ismp = 1;
801032ab:	b9 01 00 00 00       	mov    $0x1,%ecx
  lapic = (uint*)conf->lapicaddr;
801032b0:	a3 dc 36 11 80       	mov    %eax,0x801136dc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032b5:	0f b7 83 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%eax
801032bc:	01 c6                	add    %eax,%esi
801032be:	66 90                	xchg   %ax,%ax
801032c0:	39 d6                	cmp    %edx,%esi
801032c2:	76 23                	jbe    801032e7 <mpinit+0x127>
    switch(*p){
801032c4:	0f b6 02             	movzbl (%edx),%eax
801032c7:	3c 04                	cmp    $0x4,%al
801032c9:	0f 87 c9 00 00 00    	ja     80103398 <mpinit+0x1d8>
801032cf:	ff 24 85 ac 89 10 80 	jmp    *-0x7fef7654(,%eax,4)
801032d6:	8d 76 00             	lea    0x0(%esi),%esi
801032d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801032e0:	83 c2 08             	add    $0x8,%edx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032e3:	39 d6                	cmp    %edx,%esi
801032e5:	77 dd                	ja     801032c4 <mpinit+0x104>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801032e7:	85 c9                	test   %ecx,%ecx
801032e9:	0f 84 9d 00 00 00    	je     8010338c <mpinit+0x1cc>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801032ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801032f2:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
801032f6:	74 11                	je     80103309 <mpinit+0x149>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032f8:	b0 70                	mov    $0x70,%al
801032fa:	ba 22 00 00 00       	mov    $0x22,%edx
801032ff:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103300:	ba 23 00 00 00       	mov    $0x23,%edx
80103305:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103306:	0c 01                	or     $0x1,%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103308:	ee                   	out    %al,(%dx)
  }
}
80103309:	83 c4 2c             	add    $0x2c,%esp
8010330c:	5b                   	pop    %ebx
8010330d:	5e                   	pop    %esi
8010330e:	5f                   	pop    %edi
8010330f:	5d                   	pop    %ebp
80103310:	c3                   	ret    
80103311:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
80103318:	8b 1d 60 3d 11 80    	mov    0x80113d60,%ebx
8010331e:	83 fb 07             	cmp    $0x7,%ebx
80103321:	7f 1a                	jg     8010333d <mpinit+0x17d>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103323:	0f b6 42 01          	movzbl 0x1(%edx),%eax
80103327:	8d 3c 9b             	lea    (%ebx,%ebx,4),%edi
8010332a:	8d 3c 7b             	lea    (%ebx,%edi,2),%edi
        ncpu++;
8010332d:	43                   	inc    %ebx
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010332e:	c1 e7 04             	shl    $0x4,%edi
        ncpu++;
80103331:	89 1d 60 3d 11 80    	mov    %ebx,0x80113d60
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103337:	88 87 e0 37 11 80    	mov    %al,-0x7feec820(%edi)
      p += sizeof(struct mpproc);
8010333d:	83 c2 14             	add    $0x14,%edx
      continue;
80103340:	e9 7b ff ff ff       	jmp    801032c0 <mpinit+0x100>
80103345:	8d 76 00             	lea    0x0(%esi),%esi
      ioapicid = ioapic->apicno;
80103348:	0f b6 42 01          	movzbl 0x1(%edx),%eax
      p += sizeof(struct mpioapic);
8010334c:	83 c2 08             	add    $0x8,%edx
      ioapicid = ioapic->apicno;
8010334f:	a2 c0 37 11 80       	mov    %al,0x801137c0
      continue;
80103354:	e9 67 ff ff ff       	jmp    801032c0 <mpinit+0x100>
80103359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return mpsearch1(0xF0000, 0x10000);
80103360:	ba 00 00 01 00       	mov    $0x10000,%edx
80103365:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010336a:	e8 d1 fd ff ff       	call   80103140 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010336f:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
80103371:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103374:	0f 85 97 fe ff ff    	jne    80103211 <mpinit+0x51>
8010337a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103380:	c7 04 24 6d 89 10 80 	movl   $0x8010896d,(%esp)
80103387:	e8 e4 cf ff ff       	call   80100370 <panic>
    panic("Didn't find a suitable machine");
8010338c:	c7 04 24 8c 89 10 80 	movl   $0x8010898c,(%esp)
80103393:	e8 d8 cf ff ff       	call   80100370 <panic>
      ismp = 0;
80103398:	31 c9                	xor    %ecx,%ecx
8010339a:	e9 28 ff ff ff       	jmp    801032c7 <mpinit+0x107>
8010339f:	90                   	nop

801033a0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801033a0:	55                   	push   %ebp
801033a1:	b0 ff                	mov    $0xff,%al
801033a3:	89 e5                	mov    %esp,%ebp
801033a5:	ba 21 00 00 00       	mov    $0x21,%edx
801033aa:	ee                   	out    %al,(%dx)
801033ab:	ba a1 00 00 00       	mov    $0xa1,%edx
801033b0:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801033b1:	5d                   	pop    %ebp
801033b2:	c3                   	ret    
801033b3:	66 90                	xchg   %ax,%ax
801033b5:	66 90                	xchg   %ax,%ax
801033b7:	66 90                	xchg   %ax,%ax
801033b9:	66 90                	xchg   %ax,%ax
801033bb:	66 90                	xchg   %ax,%ax
801033bd:	66 90                	xchg   %ax,%ax
801033bf:	90                   	nop

801033c0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801033c0:	55                   	push   %ebp
801033c1:	89 e5                	mov    %esp,%ebp
801033c3:	56                   	push   %esi
801033c4:	53                   	push   %ebx
801033c5:	83 ec 20             	sub    $0x20,%esp
801033c8:	8b 5d 08             	mov    0x8(%ebp),%ebx
801033cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801033ce:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801033d4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801033da:	e8 91 d9 ff ff       	call   80100d70 <filealloc>
801033df:	85 c0                	test   %eax,%eax
801033e1:	89 03                	mov    %eax,(%ebx)
801033e3:	74 1b                	je     80103400 <pipealloc+0x40>
801033e5:	e8 86 d9 ff ff       	call   80100d70 <filealloc>
801033ea:	85 c0                	test   %eax,%eax
801033ec:	89 06                	mov    %eax,(%esi)
801033ee:	74 30                	je     80103420 <pipealloc+0x60>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801033f0:	e8 bb f1 ff ff       	call   801025b0 <kalloc>
801033f5:	85 c0                	test   %eax,%eax
801033f7:	75 47                	jne    80103440 <pipealloc+0x80>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801033f9:	8b 03                	mov    (%ebx),%eax
801033fb:	85 c0                	test   %eax,%eax
801033fd:	75 27                	jne    80103426 <pipealloc+0x66>
801033ff:	90                   	nop
    fileclose(*f0);
  if(*f1)
80103400:	8b 06                	mov    (%esi),%eax
80103402:	85 c0                	test   %eax,%eax
80103404:	74 08                	je     8010340e <pipealloc+0x4e>
    fileclose(*f1);
80103406:	89 04 24             	mov    %eax,(%esp)
80103409:	e8 22 da ff ff       	call   80100e30 <fileclose>
  return -1;
}
8010340e:	83 c4 20             	add    $0x20,%esp
  return -1;
80103411:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103416:	5b                   	pop    %ebx
80103417:	5e                   	pop    %esi
80103418:	5d                   	pop    %ebp
80103419:	c3                   	ret    
8010341a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(*f0)
80103420:	8b 03                	mov    (%ebx),%eax
80103422:	85 c0                	test   %eax,%eax
80103424:	74 e8                	je     8010340e <pipealloc+0x4e>
    fileclose(*f0);
80103426:	89 04 24             	mov    %eax,(%esp)
80103429:	e8 02 da ff ff       	call   80100e30 <fileclose>
  if(*f1)
8010342e:	8b 06                	mov    (%esi),%eax
80103430:	85 c0                	test   %eax,%eax
80103432:	75 d2                	jne    80103406 <pipealloc+0x46>
80103434:	eb d8                	jmp    8010340e <pipealloc+0x4e>
80103436:	8d 76 00             	lea    0x0(%esi),%esi
80103439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  p->readopen = 1;
80103440:	ba 01 00 00 00       	mov    $0x1,%edx
  p->writeopen = 1;
80103445:	b9 01 00 00 00       	mov    $0x1,%ecx
  p->readopen = 1;
8010344a:	89 90 3c 02 00 00    	mov    %edx,0x23c(%eax)
  p->nwrite = 0;
80103450:	31 d2                	xor    %edx,%edx
  p->writeopen = 1;
80103452:	89 88 40 02 00 00    	mov    %ecx,0x240(%eax)
  p->nread = 0;
80103458:	31 c9                	xor    %ecx,%ecx
  p->nwrite = 0;
8010345a:	89 90 38 02 00 00    	mov    %edx,0x238(%eax)
  initlock(&p->lock, "pipe");
80103460:	ba c0 89 10 80       	mov    $0x801089c0,%edx
  p->nread = 0;
80103465:	89 88 34 02 00 00    	mov    %ecx,0x234(%eax)
  initlock(&p->lock, "pipe");
8010346b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010346f:	89 04 24             	mov    %eax,(%esp)
80103472:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103475:	e8 b6 21 00 00       	call   80105630 <initlock>
  (*f0)->type = FD_PIPE;
8010347a:	8b 13                	mov    (%ebx),%edx
  (*f0)->pipe = p;
8010347c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  (*f0)->type = FD_PIPE;
8010347f:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
  (*f0)->readable = 1;
80103485:	8b 13                	mov    (%ebx),%edx
80103487:	c6 42 08 01          	movb   $0x1,0x8(%edx)
  (*f0)->writable = 0;
8010348b:	8b 13                	mov    (%ebx),%edx
8010348d:	c6 42 09 00          	movb   $0x0,0x9(%edx)
  (*f0)->pipe = p;
80103491:	8b 13                	mov    (%ebx),%edx
80103493:	89 42 0c             	mov    %eax,0xc(%edx)
  (*f1)->type = FD_PIPE;
80103496:	8b 16                	mov    (%esi),%edx
80103498:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
  (*f1)->readable = 0;
8010349e:	8b 16                	mov    (%esi),%edx
801034a0:	c6 42 08 00          	movb   $0x0,0x8(%edx)
  (*f1)->writable = 1;
801034a4:	8b 16                	mov    (%esi),%edx
801034a6:	c6 42 09 01          	movb   $0x1,0x9(%edx)
  (*f1)->pipe = p;
801034aa:	8b 16                	mov    (%esi),%edx
801034ac:	89 42 0c             	mov    %eax,0xc(%edx)
}
801034af:	83 c4 20             	add    $0x20,%esp
  return 0;
801034b2:	31 c0                	xor    %eax,%eax
}
801034b4:	5b                   	pop    %ebx
801034b5:	5e                   	pop    %esi
801034b6:	5d                   	pop    %ebp
801034b7:	c3                   	ret    
801034b8:	90                   	nop
801034b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801034c0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801034c0:	55                   	push   %ebp
801034c1:	89 e5                	mov    %esp,%ebp
801034c3:	83 ec 18             	sub    $0x18,%esp
801034c6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801034c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801034cc:	89 75 fc             	mov    %esi,-0x4(%ebp)
801034cf:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801034d2:	89 1c 24             	mov    %ebx,(%esp)
801034d5:	e8 a6 22 00 00       	call   80105780 <acquire>
  if(writable){
801034da:	85 f6                	test   %esi,%esi
801034dc:	74 42                	je     80103520 <pipeclose+0x60>
    p->writeopen = 0;
801034de:	31 f6                	xor    %esi,%esi
    wakeup(&p->nread);
801034e0:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
801034e6:	89 b3 40 02 00 00    	mov    %esi,0x240(%ebx)
    wakeup(&p->nread);
801034ec:	89 04 24             	mov    %eax,(%esp)
801034ef:	e8 5c 0f 00 00       	call   80104450 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801034f4:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801034fa:	85 d2                	test   %edx,%edx
801034fc:	75 0a                	jne    80103508 <pipeclose+0x48>
801034fe:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103504:	85 c0                	test   %eax,%eax
80103506:	74 38                	je     80103540 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103508:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010350b:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010350e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103511:	89 ec                	mov    %ebp,%esp
80103513:	5d                   	pop    %ebp
    release(&p->lock);
80103514:	e9 07 23 00 00       	jmp    80105820 <release>
80103519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->readopen = 0;
80103520:	31 c9                	xor    %ecx,%ecx
    wakeup(&p->nwrite);
80103522:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103528:	89 8b 3c 02 00 00    	mov    %ecx,0x23c(%ebx)
    wakeup(&p->nwrite);
8010352e:	89 04 24             	mov    %eax,(%esp)
80103531:	e8 1a 0f 00 00       	call   80104450 <wakeup>
80103536:	eb bc                	jmp    801034f4 <pipeclose+0x34>
80103538:	90                   	nop
80103539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103540:	89 1c 24             	mov    %ebx,(%esp)
80103543:	e8 d8 22 00 00       	call   80105820 <release>
}
80103548:	8b 75 fc             	mov    -0x4(%ebp),%esi
    kfree((char*)p);
8010354b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010354e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103551:	89 ec                	mov    %ebp,%esp
80103553:	5d                   	pop    %ebp
    kfree((char*)p);
80103554:	e9 87 ee ff ff       	jmp    801023e0 <kfree>
80103559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103560 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103560:	55                   	push   %ebp
80103561:	89 e5                	mov    %esp,%ebp
80103563:	57                   	push   %edi
80103564:	56                   	push   %esi
80103565:	53                   	push   %ebx
80103566:	83 ec 2c             	sub    $0x2c,%esp
80103569:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i;

  acquire(&p->lock);
8010356c:	89 3c 24             	mov    %edi,(%esp)
8010356f:	e8 0c 22 00 00       	call   80105780 <acquire>
  for(i = 0; i < n; i++){
80103574:	8b 75 10             	mov    0x10(%ebp),%esi
80103577:	85 f6                	test   %esi,%esi
80103579:	0f 8e c7 00 00 00    	jle    80103646 <pipewrite+0xe6>
8010357f:	8b 45 0c             	mov    0xc(%ebp),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103582:	8d b7 34 02 00 00    	lea    0x234(%edi),%esi
80103588:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010358b:	8b 8f 38 02 00 00    	mov    0x238(%edi),%ecx
80103591:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103594:	01 d8                	add    %ebx,%eax
80103596:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103599:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
8010359f:	05 00 02 00 00       	add    $0x200,%eax
801035a4:	39 c1                	cmp    %eax,%ecx
801035a6:	75 6c                	jne    80103614 <pipewrite+0xb4>
      if(p->readopen == 0 || myproc()->killed){
801035a8:	8b 87 3c 02 00 00    	mov    0x23c(%edi),%eax
801035ae:	85 c0                	test   %eax,%eax
801035b0:	74 4d                	je     801035ff <pipewrite+0x9f>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035b2:	8d 9f 38 02 00 00    	lea    0x238(%edi),%ebx
801035b8:	eb 39                	jmp    801035f3 <pipewrite+0x93>
801035ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
801035c0:	89 34 24             	mov    %esi,(%esp)
801035c3:	e8 88 0e 00 00       	call   80104450 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035c8:	89 7c 24 04          	mov    %edi,0x4(%esp)
801035cc:	89 1c 24             	mov    %ebx,(%esp)
801035cf:	e8 9c 0c 00 00       	call   80104270 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035d4:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
801035da:	8b 97 38 02 00 00    	mov    0x238(%edi),%edx
801035e0:	05 00 02 00 00       	add    $0x200,%eax
801035e5:	39 c2                	cmp    %eax,%edx
801035e7:	75 37                	jne    80103620 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
801035e9:	8b 8f 3c 02 00 00    	mov    0x23c(%edi),%ecx
801035ef:	85 c9                	test   %ecx,%ecx
801035f1:	74 0c                	je     801035ff <pipewrite+0x9f>
801035f3:	e8 88 03 00 00       	call   80103980 <myproc>
801035f8:	8b 50 24             	mov    0x24(%eax),%edx
801035fb:	85 d2                	test   %edx,%edx
801035fd:	74 c1                	je     801035c0 <pipewrite+0x60>
        release(&p->lock);
801035ff:	89 3c 24             	mov    %edi,(%esp)
80103602:	e8 19 22 00 00       	call   80105820 <release>
        return -1;
80103607:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
8010360c:	83 c4 2c             	add    $0x2c,%esp
8010360f:	5b                   	pop    %ebx
80103610:	5e                   	pop    %esi
80103611:	5f                   	pop    %edi
80103612:	5d                   	pop    %ebp
80103613:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103614:	89 ca                	mov    %ecx,%edx
80103616:	8d 76 00             	lea    0x0(%esi),%esi
80103619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103620:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103623:	8d 4a 01             	lea    0x1(%edx),%ecx
80103626:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010362c:	89 8f 38 02 00 00    	mov    %ecx,0x238(%edi)
80103632:	0f b6 03             	movzbl (%ebx),%eax
80103635:	43                   	inc    %ebx
  for(i = 0; i < n; i++){
80103636:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
80103639:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010363c:	88 44 17 34          	mov    %al,0x34(%edi,%edx,1)
  for(i = 0; i < n; i++){
80103640:	0f 85 53 ff ff ff    	jne    80103599 <pipewrite+0x39>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103646:	8d 87 34 02 00 00    	lea    0x234(%edi),%eax
8010364c:	89 04 24             	mov    %eax,(%esp)
8010364f:	e8 fc 0d 00 00       	call   80104450 <wakeup>
  release(&p->lock);
80103654:	89 3c 24             	mov    %edi,(%esp)
80103657:	e8 c4 21 00 00       	call   80105820 <release>
  return n;
8010365c:	8b 45 10             	mov    0x10(%ebp),%eax
8010365f:	eb ab                	jmp    8010360c <pipewrite+0xac>
80103661:	eb 0d                	jmp    80103670 <piperead>
80103663:	90                   	nop
80103664:	90                   	nop
80103665:	90                   	nop
80103666:	90                   	nop
80103667:	90                   	nop
80103668:	90                   	nop
80103669:	90                   	nop
8010366a:	90                   	nop
8010366b:	90                   	nop
8010366c:	90                   	nop
8010366d:	90                   	nop
8010366e:	90                   	nop
8010366f:	90                   	nop

80103670 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103670:	55                   	push   %ebp
80103671:	89 e5                	mov    %esp,%ebp
80103673:	57                   	push   %edi
80103674:	56                   	push   %esi
80103675:	53                   	push   %ebx
80103676:	83 ec 1c             	sub    $0x1c,%esp
80103679:	8b 75 08             	mov    0x8(%ebp),%esi
8010367c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010367f:	89 34 24             	mov    %esi,(%esp)
80103682:	e8 f9 20 00 00       	call   80105780 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103687:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010368d:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103693:	75 6b                	jne    80103700 <piperead+0x90>
80103695:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010369b:	85 db                	test   %ebx,%ebx
8010369d:	0f 84 bd 00 00 00    	je     80103760 <piperead+0xf0>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801036a3:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801036a9:	eb 2d                	jmp    801036d8 <piperead+0x68>
801036ab:	90                   	nop
801036ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036b0:	89 74 24 04          	mov    %esi,0x4(%esp)
801036b4:	89 1c 24             	mov    %ebx,(%esp)
801036b7:	e8 b4 0b 00 00       	call   80104270 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036bc:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801036c2:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801036c8:	75 36                	jne    80103700 <piperead+0x90>
801036ca:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
801036d0:	85 d2                	test   %edx,%edx
801036d2:	0f 84 88 00 00 00    	je     80103760 <piperead+0xf0>
    if(myproc()->killed){
801036d8:	e8 a3 02 00 00       	call   80103980 <myproc>
801036dd:	8b 48 24             	mov    0x24(%eax),%ecx
801036e0:	85 c9                	test   %ecx,%ecx
801036e2:	74 cc                	je     801036b0 <piperead+0x40>
      release(&p->lock);
801036e4:	89 34 24             	mov    %esi,(%esp)
      return -1;
801036e7:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801036ec:	e8 2f 21 00 00       	call   80105820 <release>
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801036f1:	83 c4 1c             	add    $0x1c,%esp
801036f4:	89 d8                	mov    %ebx,%eax
801036f6:	5b                   	pop    %ebx
801036f7:	5e                   	pop    %esi
801036f8:	5f                   	pop    %edi
801036f9:	5d                   	pop    %ebp
801036fa:	c3                   	ret    
801036fb:	90                   	nop
801036fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103700:	8b 45 10             	mov    0x10(%ebp),%eax
80103703:	85 c0                	test   %eax,%eax
80103705:	7e 59                	jle    80103760 <piperead+0xf0>
    if(p->nread == p->nwrite)
80103707:	31 db                	xor    %ebx,%ebx
80103709:	eb 13                	jmp    8010371e <piperead+0xae>
8010370b:	90                   	nop
8010370c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103710:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103716:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
8010371c:	74 1d                	je     8010373b <piperead+0xcb>
    addr[i] = p->data[p->nread++ % PIPESIZE];
8010371e:	8d 41 01             	lea    0x1(%ecx),%eax
80103721:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103727:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
8010372d:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
80103732:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103735:	43                   	inc    %ebx
80103736:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103739:	75 d5                	jne    80103710 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010373b:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103741:	89 04 24             	mov    %eax,(%esp)
80103744:	e8 07 0d 00 00       	call   80104450 <wakeup>
  release(&p->lock);
80103749:	89 34 24             	mov    %esi,(%esp)
8010374c:	e8 cf 20 00 00       	call   80105820 <release>
}
80103751:	83 c4 1c             	add    $0x1c,%esp
80103754:	89 d8                	mov    %ebx,%eax
80103756:	5b                   	pop    %ebx
80103757:	5e                   	pop    %esi
80103758:	5f                   	pop    %edi
80103759:	5d                   	pop    %ebp
8010375a:	c3                   	ret    
8010375b:	90                   	nop
8010375c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103760:	31 db                	xor    %ebx,%ebx
80103762:	eb d7                	jmp    8010373b <piperead+0xcb>
80103764:	66 90                	xchg   %ax,%ax
80103766:	66 90                	xchg   %ax,%ax
80103768:	66 90                	xchg   %ax,%ax
8010376a:	66 90                	xchg   %ax,%ax
8010376c:	66 90                	xchg   %ax,%ax
8010376e:	66 90                	xchg   %ax,%ax

80103770 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103770:	55                   	push   %ebp
80103771:	89 e5                	mov    %esp,%ebp
80103773:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103774:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
{
80103779:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);
8010377c:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103783:	e8 f8 1f 00 00       	call   80105780 <acquire>
80103788:	eb 18                	jmp    801037a2 <allocproc+0x32>
8010378a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103790:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80103796:	81 fb b4 60 11 80    	cmp    $0x801160b4,%ebx
8010379c:	0f 83 7e 00 00 00    	jae    80103820 <allocproc+0xb0>
    if(p->state == UNUSED)
801037a2:	8b 43 0c             	mov    0xc(%ebx),%eax
801037a5:	85 c0                	test   %eax,%eax
801037a7:	75 e7                	jne    80103790 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801037a9:	a1 04 b0 10 80       	mov    0x8010b004,%eax
  p->state = EMBRYO;
801037ae:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
801037b5:	8d 50 01             	lea    0x1(%eax),%edx
801037b8:	89 43 10             	mov    %eax,0x10(%ebx)

  release(&ptable.lock);
801037bb:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
  p->pid = nextpid++;
801037c2:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
801037c8:	e8 53 20 00 00       	call   80105820 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801037cd:	e8 de ed ff ff       	call   801025b0 <kalloc>
801037d2:	85 c0                	test   %eax,%eax
801037d4:	89 43 08             	mov    %eax,0x8(%ebx)
801037d7:	74 5d                	je     80103836 <allocproc+0xc6>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801037d9:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801037df:	b9 14 00 00 00       	mov    $0x14,%ecx
  sp -= sizeof *p->tf;
801037e4:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
801037e7:	ba 2f 6b 10 80       	mov    $0x80106b2f,%edx
  sp -= sizeof *p->context;
801037ec:	05 9c 0f 00 00       	add    $0xf9c,%eax
  *(uint*)sp = (uint)trapret;
801037f1:	89 50 14             	mov    %edx,0x14(%eax)
  memset(p->context, 0, sizeof *p->context);
801037f4:	31 d2                	xor    %edx,%edx
  p->context = (struct context*)sp;
801037f6:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801037f9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801037fd:	89 54 24 04          	mov    %edx,0x4(%esp)
80103801:	89 04 24             	mov    %eax,(%esp)
80103804:	e8 67 20 00 00       	call   80105870 <memset>
  p->context->eip = (uint)forkret;
80103809:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010380c:	c7 40 10 50 38 10 80 	movl   $0x80103850,0x10(%eax)

  return p;
}
80103813:	83 c4 14             	add    $0x14,%esp
80103816:	89 d8                	mov    %ebx,%eax
80103818:	5b                   	pop    %ebx
80103819:	5d                   	pop    %ebp
8010381a:	c3                   	ret    
8010381b:	90                   	nop
8010381c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80103820:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
  return 0;
80103827:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103829:	e8 f2 1f 00 00       	call   80105820 <release>
}
8010382e:	83 c4 14             	add    $0x14,%esp
80103831:	89 d8                	mov    %ebx,%eax
80103833:	5b                   	pop    %ebx
80103834:	5d                   	pop    %ebp
80103835:	c3                   	ret    
    p->state = UNUSED;
80103836:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
8010383d:	31 db                	xor    %ebx,%ebx
8010383f:	eb d2                	jmp    80103813 <allocproc+0xa3>
80103841:	eb 0d                	jmp    80103850 <forkret>
80103843:	90                   	nop
80103844:	90                   	nop
80103845:	90                   	nop
80103846:	90                   	nop
80103847:	90                   	nop
80103848:	90                   	nop
80103849:	90                   	nop
8010384a:	90                   	nop
8010384b:	90                   	nop
8010384c:	90                   	nop
8010384d:	90                   	nop
8010384e:	90                   	nop
8010384f:	90                   	nop

80103850 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103850:	55                   	push   %ebp
80103851:	89 e5                	mov    %esp,%ebp
80103853:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103856:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
8010385d:	e8 be 1f 00 00       	call   80105820 <release>

  if (first) {
80103862:	8b 15 00 b0 10 80    	mov    0x8010b000,%edx
80103868:	85 d2                	test   %edx,%edx
8010386a:	75 04                	jne    80103870 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010386c:	c9                   	leave  
8010386d:	c3                   	ret    
8010386e:	66 90                	xchg   %ax,%ax
    first = 0;
80103870:	31 c0                	xor    %eax,%eax
    iinit(ROOTDEV);
80103872:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    first = 0;
80103879:	a3 00 b0 10 80       	mov    %eax,0x8010b000
    iinit(ROOTDEV);
8010387e:	e8 2d dc ff ff       	call   801014b0 <iinit>
    initlog(ROOTDEV);
80103883:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010388a:	e8 61 f3 ff ff       	call   80102bf0 <initlog>
}
8010388f:	c9                   	leave  
80103890:	c3                   	ret    
80103891:	eb 0d                	jmp    801038a0 <getAccumulator>
80103893:	90                   	nop
80103894:	90                   	nop
80103895:	90                   	nop
80103896:	90                   	nop
80103897:	90                   	nop
80103898:	90                   	nop
80103899:	90                   	nop
8010389a:	90                   	nop
8010389b:	90                   	nop
8010389c:	90                   	nop
8010389d:	90                   	nop
8010389e:	90                   	nop
8010389f:	90                   	nop

801038a0 <getAccumulator>:
long long getAccumulator(struct proc *p) {
801038a0:	55                   	push   %ebp
801038a1:	89 e5                	mov    %esp,%ebp
        return p->accumulator;
801038a3:	8b 45 08             	mov    0x8(%ebp),%eax
}
801038a6:	5d                   	pop    %ebp
        return p->accumulator;
801038a7:	8b 90 88 00 00 00    	mov    0x88(%eax),%edx
801038ad:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
}
801038b3:	c3                   	ret    
801038b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801038ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801038c0 <pinit>:
{
801038c0:	55                   	push   %ebp
  initlock(&ptable.lock, "ptable");
801038c1:	b8 c5 89 10 80       	mov    $0x801089c5,%eax
{
801038c6:	89 e5                	mov    %esp,%ebp
801038c8:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
801038cb:	89 44 24 04          	mov    %eax,0x4(%esp)
801038cf:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
801038d6:	e8 55 1d 00 00       	call   80105630 <initlock>
}
801038db:	c9                   	leave  
801038dc:	c3                   	ret    
801038dd:	8d 76 00             	lea    0x0(%esi),%esi

801038e0 <mycpu>:
{
801038e0:	55                   	push   %ebp
801038e1:	89 e5                	mov    %esp,%ebp
801038e3:	56                   	push   %esi
801038e4:	53                   	push   %ebx
801038e5:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801038e8:	9c                   	pushf  
801038e9:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801038ea:	f6 c4 02             	test   $0x2,%ah
801038ed:	75 5b                	jne    8010394a <mycpu+0x6a>
  apicid = lapicid();
801038ef:	e8 3c ef ff ff       	call   80102830 <lapicid>
  for (i = 0; i < ncpu; ++i) {
801038f4:	8b 35 60 3d 11 80    	mov    0x80113d60,%esi
801038fa:	85 f6                	test   %esi,%esi
801038fc:	7e 40                	jle    8010393e <mycpu+0x5e>
    if (cpus[i].apicid == apicid)
801038fe:	0f b6 15 e0 37 11 80 	movzbl 0x801137e0,%edx
80103905:	39 d0                	cmp    %edx,%eax
80103907:	74 2e                	je     80103937 <mycpu+0x57>
80103909:	b9 90 38 11 80       	mov    $0x80113890,%ecx
  for (i = 0; i < ncpu; ++i) {
8010390e:	31 d2                	xor    %edx,%edx
80103910:	42                   	inc    %edx
80103911:	39 f2                	cmp    %esi,%edx
80103913:	74 29                	je     8010393e <mycpu+0x5e>
    if (cpus[i].apicid == apicid)
80103915:	0f b6 19             	movzbl (%ecx),%ebx
80103918:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
8010391e:	39 c3                	cmp    %eax,%ebx
80103920:	75 ee                	jne    80103910 <mycpu+0x30>
80103922:	8d 04 92             	lea    (%edx,%edx,4),%eax
80103925:	8d 04 42             	lea    (%edx,%eax,2),%eax
80103928:	c1 e0 04             	shl    $0x4,%eax
8010392b:	05 e0 37 11 80       	add    $0x801137e0,%eax
}
80103930:	83 c4 10             	add    $0x10,%esp
80103933:	5b                   	pop    %ebx
80103934:	5e                   	pop    %esi
80103935:	5d                   	pop    %ebp
80103936:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103937:	b8 e0 37 11 80       	mov    $0x801137e0,%eax
      return &cpus[i];
8010393c:	eb f2                	jmp    80103930 <mycpu+0x50>
  panic("unknown apicid\n");
8010393e:	c7 04 24 cc 89 10 80 	movl   $0x801089cc,(%esp)
80103945:	e8 26 ca ff ff       	call   80100370 <panic>
    panic("mycpu called with interrupts enabled\n");
8010394a:	c7 04 24 c8 8a 10 80 	movl   $0x80108ac8,(%esp)
80103951:	e8 1a ca ff ff       	call   80100370 <panic>
80103956:	8d 76 00             	lea    0x0(%esi),%esi
80103959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103960 <cpuid>:
cpuid() {
80103960:	55                   	push   %ebp
80103961:	89 e5                	mov    %esp,%ebp
80103963:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103966:	e8 75 ff ff ff       	call   801038e0 <mycpu>
}
8010396b:	c9                   	leave  
  return mycpu()-cpus;
8010396c:	2d e0 37 11 80       	sub    $0x801137e0,%eax
80103971:	c1 f8 04             	sar    $0x4,%eax
80103974:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010397a:	c3                   	ret    
8010397b:	90                   	nop
8010397c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103980 <myproc>:
myproc(void) {
80103980:	55                   	push   %ebp
80103981:	89 e5                	mov    %esp,%ebp
80103983:	53                   	push   %ebx
80103984:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103987:	e8 14 1d 00 00       	call   801056a0 <pushcli>
  c = mycpu();
8010398c:	e8 4f ff ff ff       	call   801038e0 <mycpu>
  p = c->proc;
80103991:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103997:	e8 44 1d 00 00       	call   801056e0 <popcli>
}
8010399c:	5a                   	pop    %edx
8010399d:	89 d8                	mov    %ebx,%eax
8010399f:	5b                   	pop    %ebx
801039a0:	5d                   	pop    %ebp
801039a1:	c3                   	ret    
801039a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801039b0 <userinit>:
{
801039b0:	55                   	push   %ebp
801039b1:	89 e5                	mov    %esp,%ebp
801039b3:	53                   	push   %ebx
801039b4:	83 ec 14             	sub    $0x14,%esp
  p = allocproc();
801039b7:	e8 b4 fd ff ff       	call   80103770 <allocproc>
801039bc:	89 c3                	mov    %eax,%ebx
  initproc = p;
801039be:	a3 b8 b5 10 80       	mov    %eax,0x8010b5b8
  if((p->pgdir = setupkvm()) == 0)
801039c3:	e8 98 47 00 00       	call   80108160 <setupkvm>
801039c8:	85 c0                	test   %eax,%eax
801039ca:	89 43 04             	mov    %eax,0x4(%ebx)
801039cd:	0f 84 fd 00 00 00    	je     80103ad0 <userinit+0x120>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801039d3:	b9 60 b4 10 80       	mov    $0x8010b460,%ecx
801039d8:	ba 2c 00 00 00       	mov    $0x2c,%edx
801039dd:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801039e1:	89 54 24 08          	mov    %edx,0x8(%esp)
801039e5:	89 04 24             	mov    %eax,(%esp)
801039e8:	e8 43 44 00 00       	call   80107e30 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
801039ed:	b8 4c 00 00 00       	mov    $0x4c,%eax
  p->sz = PGSIZE;
801039f2:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801039f8:	89 44 24 08          	mov    %eax,0x8(%esp)
801039fc:	31 c0                	xor    %eax,%eax
801039fe:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a02:	8b 43 18             	mov    0x18(%ebx),%eax
80103a05:	89 04 24             	mov    %eax,(%esp)
80103a08:	e8 63 1e 00 00       	call   80105870 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a0d:	8b 43 18             	mov    0x18(%ebx),%eax
80103a10:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a16:	8b 43 18             	mov    0x18(%ebx),%eax
80103a19:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103a1f:	8b 43 18             	mov    0x18(%ebx),%eax
80103a22:	8b 50 2c             	mov    0x2c(%eax),%edx
80103a25:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103a29:	8b 43 18             	mov    0x18(%ebx),%eax
80103a2c:	8b 50 2c             	mov    0x2c(%eax),%edx
80103a2f:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103a33:	8b 43 18             	mov    0x18(%ebx),%eax
80103a36:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103a3d:	8b 43 18             	mov    0x18(%ebx),%eax
80103a40:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103a47:	8b 43 18             	mov    0x18(%ebx),%eax
80103a4a:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a51:	b8 10 00 00 00       	mov    $0x10,%eax
80103a56:	89 44 24 08          	mov    %eax,0x8(%esp)
80103a5a:	b8 f5 89 10 80       	mov    $0x801089f5,%eax
80103a5f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a63:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103a66:	89 04 24             	mov    %eax,(%esp)
80103a69:	e8 e2 1f 00 00       	call   80105a50 <safestrcpy>
  p->cwd = namei("/");
80103a6e:	c7 04 24 fe 89 10 80 	movl   $0x801089fe,(%esp)
80103a75:	e8 56 e5 ff ff       	call   80101fd0 <namei>
80103a7a:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103a7d:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103a84:	e8 f7 1c 00 00       	call   80105780 <acquire>
  if(p->state == RUNNING)
80103a89:	8b 43 0c             	mov    0xc(%ebx),%eax
80103a8c:	83 f8 04             	cmp    $0x4,%eax
80103a8f:	75 09                	jne    80103a9a <userinit+0xea>
      rpholder.remove(p);
80103a91:	89 1c 24             	mov    %ebx,(%esp)
80103a94:	ff 15 c4 b5 10 80    	call   *0x8010b5c4
  if(POLICY == 1)
80103a9a:	83 3d 08 b0 10 80 01 	cmpl   $0x1,0x8010b008
  p->state = RUNNABLE;
80103aa1:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
      rrq.enqueue(p);
80103aa8:	89 1c 24             	mov    %ebx,(%esp)
  if(POLICY == 1)
80103aab:	74 1b                	je     80103ac8 <userinit+0x118>
      pq.put(p);
80103aad:	ff 15 e0 b5 10 80    	call   *0x8010b5e0
  release(&ptable.lock);
80103ab3:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103aba:	e8 61 1d 00 00       	call   80105820 <release>
}
80103abf:	83 c4 14             	add    $0x14,%esp
80103ac2:	5b                   	pop    %ebx
80103ac3:	5d                   	pop    %ebp
80103ac4:	c3                   	ret    
80103ac5:	8d 76 00             	lea    0x0(%esi),%esi
      rrq.enqueue(p);
80103ac8:	ff 15 d0 b5 10 80    	call   *0x8010b5d0
80103ace:	eb e3                	jmp    80103ab3 <userinit+0x103>
    panic("userinit: out of memory?");
80103ad0:	c7 04 24 dc 89 10 80 	movl   $0x801089dc,(%esp)
80103ad7:	e8 94 c8 ff ff       	call   80100370 <panic>
80103adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103ae0 <growproc>:
{
80103ae0:	55                   	push   %ebp
80103ae1:	89 e5                	mov    %esp,%ebp
80103ae3:	56                   	push   %esi
80103ae4:	53                   	push   %ebx
80103ae5:	83 ec 10             	sub    $0x10,%esp
80103ae8:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103aeb:	e8 b0 1b 00 00       	call   801056a0 <pushcli>
  c = mycpu();
80103af0:	e8 eb fd ff ff       	call   801038e0 <mycpu>
  p = c->proc;
80103af5:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103afb:	e8 e0 1b 00 00       	call   801056e0 <popcli>
  if(n > 0){
80103b00:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103b03:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103b05:	7f 19                	jg     80103b20 <growproc+0x40>
  } else if(n < 0){
80103b07:	75 37                	jne    80103b40 <growproc+0x60>
  curproc->sz = sz;
80103b09:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103b0b:	89 1c 24             	mov    %ebx,(%esp)
80103b0e:	e8 1d 42 00 00       	call   80107d30 <switchuvm>
  return 0;
80103b13:	31 c0                	xor    %eax,%eax
}
80103b15:	83 c4 10             	add    $0x10,%esp
80103b18:	5b                   	pop    %ebx
80103b19:	5e                   	pop    %esi
80103b1a:	5d                   	pop    %ebp
80103b1b:	c3                   	ret    
80103b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b20:	01 c6                	add    %eax,%esi
80103b22:	89 74 24 08          	mov    %esi,0x8(%esp)
80103b26:	89 44 24 04          	mov    %eax,0x4(%esp)
80103b2a:	8b 43 04             	mov    0x4(%ebx),%eax
80103b2d:	89 04 24             	mov    %eax,(%esp)
80103b30:	e8 4b 44 00 00       	call   80107f80 <allocuvm>
80103b35:	85 c0                	test   %eax,%eax
80103b37:	75 d0                	jne    80103b09 <growproc+0x29>
      return -1;
80103b39:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b3e:	eb d5                	jmp    80103b15 <growproc+0x35>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b40:	01 c6                	add    %eax,%esi
80103b42:	89 74 24 08          	mov    %esi,0x8(%esp)
80103b46:	89 44 24 04          	mov    %eax,0x4(%esp)
80103b4a:	8b 43 04             	mov    0x4(%ebx),%eax
80103b4d:	89 04 24             	mov    %eax,(%esp)
80103b50:	e8 5b 45 00 00       	call   801080b0 <deallocuvm>
80103b55:	85 c0                	test   %eax,%eax
80103b57:	75 b0                	jne    80103b09 <growproc+0x29>
80103b59:	eb de                	jmp    80103b39 <growproc+0x59>
80103b5b:	90                   	nop
80103b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103b60 <setAccumulator>:
void setAccumulator(struct proc *p){
80103b60:	55                   	push   %ebp
80103b61:	89 e5                	mov    %esp,%ebp
80103b63:	83 ec 28             	sub    $0x28,%esp
  if (pq.getMinAccumulator(&acc1)){
80103b66:	8d 45 e8             	lea    -0x18(%ebp),%eax
void setAccumulator(struct proc *p){
80103b69:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80103b6c:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103b6f:	89 75 fc             	mov    %esi,-0x4(%ebp)
  if (pq.getMinAccumulator(&acc1)){
80103b72:	89 04 24             	mov    %eax,(%esp)
80103b75:	ff 15 e4 b5 10 80    	call   *0x8010b5e4
80103b7b:	85 c0                	test   %eax,%eax
      if (rpholder.getMinAccumulator(&acc2))
80103b7d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80103b80:	89 04 24             	mov    %eax,(%esp)
  if (pq.getMinAccumulator(&acc1)){
80103b83:	74 3b                	je     80103bc0 <setAccumulator+0x60>
      if (rpholder.getMinAccumulator(&acc2))
80103b85:	ff 15 c8 b5 10 80    	call   *0x8010b5c8
80103b8b:	85 c0                	test   %eax,%eax
80103b8d:	74 79                	je     80103c08 <setAccumulator+0xa8>
            if (acc1<acc2)
80103b8f:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103b92:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b95:	8b 75 e8             	mov    -0x18(%ebp),%esi
80103b98:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80103b9b:	39 c2                	cmp    %eax,%edx
80103b9d:	7f 0a                	jg     80103ba9 <setAccumulator+0x49>
80103b9f:	0f 8c 83 00 00 00    	jl     80103c28 <setAccumulator+0xc8>
80103ba5:	39 ce                	cmp    %ecx,%esi
80103ba7:	72 7f                	jb     80103c28 <setAccumulator+0xc8>
                   p->accumulator = acc2;
80103ba9:	89 8b 84 00 00 00    	mov    %ecx,0x84(%ebx)
80103baf:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
}
80103bb5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103bb8:	8b 75 fc             	mov    -0x4(%ebp),%esi
80103bbb:	89 ec                	mov    %ebp,%esp
80103bbd:	5d                   	pop    %ebp
80103bbe:	c3                   	ret    
80103bbf:	90                   	nop
  else if (rpholder.getMinAccumulator(&acc2)){
80103bc0:	ff 15 c8 b5 10 80    	call   *0x8010b5c8
80103bc6:	85 c0                	test   %eax,%eax
80103bc8:	75 1e                	jne    80103be8 <setAccumulator+0x88>
       p->accumulator = 0;
80103bca:	31 c0                	xor    %eax,%eax
80103bcc:	31 d2                	xor    %edx,%edx
80103bce:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)
80103bd4:	89 93 88 00 00 00    	mov    %edx,0x88(%ebx)
}
80103bda:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103bdd:	8b 75 fc             	mov    -0x4(%ebp),%esi
80103be0:	89 ec                	mov    %ebp,%esp
80103be2:	5d                   	pop    %ebp
80103be3:	c3                   	ret    
80103be4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->accumulator = acc2;
80103be8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103beb:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103bee:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)
80103bf4:	89 93 88 00 00 00    	mov    %edx,0x88(%ebx)
}
80103bfa:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103bfd:	8b 75 fc             	mov    -0x4(%ebp),%esi
80103c00:	89 ec                	mov    %ebp,%esp
80103c02:	5d                   	pop    %ebp
80103c03:	c3                   	ret    
80103c04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
             p->accumulator = acc1;
80103c08:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103c0b:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103c0e:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)
80103c14:	89 93 88 00 00 00    	mov    %edx,0x88(%ebx)
}
80103c1a:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103c1d:	8b 75 fc             	mov    -0x4(%ebp),%esi
80103c20:	89 ec                	mov    %ebp,%esp
80103c22:	5d                   	pop    %ebp
80103c23:	c3                   	ret    
80103c24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                   p->accumulator = acc1;
80103c28:	89 b3 84 00 00 00    	mov    %esi,0x84(%ebx)
80103c2e:	89 93 88 00 00 00    	mov    %edx,0x88(%ebx)
}
80103c34:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103c37:	8b 75 fc             	mov    -0x4(%ebp),%esi
80103c3a:	89 ec                	mov    %ebp,%esp
80103c3c:	5d                   	pop    %ebp
80103c3d:	c3                   	ret    
80103c3e:	66 90                	xchg   %ax,%ax

80103c40 <fork>:
{
80103c40:	55                   	push   %ebp
80103c41:	89 e5                	mov    %esp,%ebp
80103c43:	57                   	push   %edi
80103c44:	56                   	push   %esi
80103c45:	53                   	push   %ebx
80103c46:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103c49:	e8 52 1a 00 00       	call   801056a0 <pushcli>
  c = mycpu();
80103c4e:	e8 8d fc ff ff       	call   801038e0 <mycpu>
  p = c->proc;
80103c53:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103c59:	e8 82 1a 00 00       	call   801056e0 <popcli>
  if((np = allocproc()) == 0){
80103c5e:	e8 0d fb ff ff       	call   80103770 <allocproc>
80103c63:	85 c0                	test   %eax,%eax
80103c65:	0f 84 05 01 00 00    	je     80103d70 <fork+0x130>
80103c6b:	89 c7                	mov    %eax,%edi
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103c6d:	8b 06                	mov    (%esi),%eax
80103c6f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103c73:	8b 46 04             	mov    0x4(%esi),%eax
80103c76:	89 04 24             	mov    %eax,(%esp)
80103c79:	e8 b2 45 00 00       	call   80108230 <copyuvm>
80103c7e:	85 c0                	test   %eax,%eax
80103c80:	89 47 04             	mov    %eax,0x4(%edi)
80103c83:	0f 84 ee 00 00 00    	je     80103d77 <fork+0x137>
  np->sz = curproc->sz;
80103c89:	8b 06                	mov    (%esi),%eax
  np->parent = curproc;
80103c8b:	89 77 14             	mov    %esi,0x14(%edi)
  *np->tf = *curproc->tf;
80103c8e:	8b 57 18             	mov    0x18(%edi),%edx
  np->sz = curproc->sz;
80103c91:	89 07                	mov    %eax,(%edi)
  *np->tf = *curproc->tf;
80103c93:	31 c0                	xor    %eax,%eax
80103c95:	8b 4e 18             	mov    0x18(%esi),%ecx
80103c98:	8b 1c 01             	mov    (%ecx,%eax,1),%ebx
80103c9b:	89 1c 02             	mov    %ebx,(%edx,%eax,1)
80103c9e:	83 c0 04             	add    $0x4,%eax
80103ca1:	83 f8 4c             	cmp    $0x4c,%eax
80103ca4:	72 f2                	jb     80103c98 <fork+0x58>
  np->tf->eax = 0;
80103ca6:	8b 47 18             	mov    0x18(%edi),%eax
  for(i = 0; i < NOFILE; i++)
80103ca9:	31 db                	xor    %ebx,%ebx
  np->tf->eax = 0;
80103cab:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103cb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(curproc->ofile[i])
80103cc0:	8b 44 9e 28          	mov    0x28(%esi,%ebx,4),%eax
80103cc4:	85 c0                	test   %eax,%eax
80103cc6:	74 0c                	je     80103cd4 <fork+0x94>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103cc8:	89 04 24             	mov    %eax,(%esp)
80103ccb:	e8 10 d1 ff ff       	call   80100de0 <filedup>
80103cd0:	89 44 9f 28          	mov    %eax,0x28(%edi,%ebx,4)
  for(i = 0; i < NOFILE; i++)
80103cd4:	43                   	inc    %ebx
80103cd5:	83 fb 10             	cmp    $0x10,%ebx
80103cd8:	75 e6                	jne    80103cc0 <fork+0x80>
  np->cwd = idup(curproc->cwd);
80103cda:	8b 46 68             	mov    0x68(%esi),%eax
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103cdd:	83 c6 6c             	add    $0x6c,%esi
  np->cwd = idup(curproc->cwd);
80103ce0:	89 04 24             	mov    %eax,(%esp)
80103ce3:	e8 d8 d9 ff ff       	call   801016c0 <idup>
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ce8:	ba 10 00 00 00       	mov    $0x10,%edx
  np->cwd = idup(curproc->cwd);
80103ced:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103cf0:	8d 47 6c             	lea    0x6c(%edi),%eax
80103cf3:	89 54 24 08          	mov    %edx,0x8(%esp)
80103cf7:	89 74 24 04          	mov    %esi,0x4(%esp)
80103cfb:	89 04 24             	mov    %eax,(%esp)
80103cfe:	e8 4d 1d 00 00       	call   80105a50 <safestrcpy>
  pid = np->pid;
80103d03:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103d06:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103d0d:	e8 6e 1a 00 00       	call   80105780 <acquire>
  if(np->state == RUNNING)
80103d12:	8b 47 0c             	mov    0xc(%edi),%eax
80103d15:	83 f8 04             	cmp    $0x4,%eax
80103d18:	75 09                	jne    80103d23 <fork+0xe3>
      rpholder.remove(np);
80103d1a:	89 3c 24             	mov    %edi,(%esp)
80103d1d:	ff 15 c4 b5 10 80    	call   *0x8010b5c4
  if(POLICY == 1)
80103d23:	83 3d 08 b0 10 80 01 	cmpl   $0x1,0x8010b008
  np->state = RUNNABLE;
80103d2a:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
      rrq.enqueue(np);
80103d31:	89 3c 24             	mov    %edi,(%esp)
  if(POLICY == 1)
80103d34:	74 32                	je     80103d68 <fork+0x128>
      pq.put(np);
80103d36:	ff 15 e0 b5 10 80    	call   *0x8010b5e0
  np->priority = 5; // Set the priority of new process to 5
80103d3c:	b8 05 00 00 00       	mov    $0x5,%eax
80103d41:	89 87 80 00 00 00    	mov    %eax,0x80(%edi)
  setAccumulator(np);
80103d47:	89 3c 24             	mov    %edi,(%esp)
80103d4a:	e8 11 fe ff ff       	call   80103b60 <setAccumulator>
  release(&ptable.lock);
80103d4f:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103d56:	e8 c5 1a 00 00       	call   80105820 <release>
}
80103d5b:	83 c4 1c             	add    $0x1c,%esp
80103d5e:	89 d8                	mov    %ebx,%eax
80103d60:	5b                   	pop    %ebx
80103d61:	5e                   	pop    %esi
80103d62:	5f                   	pop    %edi
80103d63:	5d                   	pop    %ebp
80103d64:	c3                   	ret    
80103d65:	8d 76 00             	lea    0x0(%esi),%esi
      rrq.enqueue(np);
80103d68:	ff 15 d0 b5 10 80    	call   *0x8010b5d0
80103d6e:	eb cc                	jmp    80103d3c <fork+0xfc>
    return -1;
80103d70:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103d75:	eb e4                	jmp    80103d5b <fork+0x11b>
    kfree(np->kstack);
80103d77:	8b 47 08             	mov    0x8(%edi),%eax
    return -1;
80103d7a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    kfree(np->kstack);
80103d7f:	89 04 24             	mov    %eax,(%esp)
80103d82:	e8 59 e6 ff ff       	call   801023e0 <kfree>
    np->kstack = 0;
80103d87:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103d8e:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103d95:	eb c4                	jmp    80103d5b <fork+0x11b>
80103d97:	89 f6                	mov    %esi,%esi
80103d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103da0 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80103da0:	55                   	push   %ebp
80103da1:	89 e5                	mov    %esp,%ebp
80103da3:	56                   	push   %esi
80103da4:	89 c6                	mov    %eax,%esi
80103da6:	53                   	push   %ebx
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103da7:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
{
80103dac:	83 ec 10             	sub    $0x10,%esp
80103daf:	eb 15                	jmp    80103dc6 <wakeup1+0x26>
80103db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103db8:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80103dbe:	81 fb b4 60 11 80    	cmp    $0x801160b4,%ebx
80103dc4:	73 3c                	jae    80103e02 <wakeup1+0x62>
    if(p->state == SLEEPING && p->chan == chan){
80103dc6:	8b 43 0c             	mov    0xc(%ebx),%eax
80103dc9:	83 f8 02             	cmp    $0x2,%eax
80103dcc:	75 ea                	jne    80103db8 <wakeup1+0x18>
80103dce:	39 73 20             	cmp    %esi,0x20(%ebx)
80103dd1:	75 e5                	jne    80103db8 <wakeup1+0x18>
      p->state = RUNNABLE;
      setAccumulator(p);  
80103dd3:	89 1c 24             	mov    %ebx,(%esp)
      p->state = RUNNABLE;
80103dd6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
      setAccumulator(p);  
80103ddd:	e8 7e fd ff ff       	call   80103b60 <setAccumulator>
      if(POLICY == 1)
80103de2:	83 3d 08 b0 10 80 01 	cmpl   $0x1,0x8010b008
        rrq.enqueue(p);
80103de9:	89 1c 24             	mov    %ebx,(%esp)
      if(POLICY == 1)
80103dec:	74 22                	je     80103e10 <wakeup1+0x70>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103dee:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
      else
        pq.put(p);
80103df4:	ff 15 e0 b5 10 80    	call   *0x8010b5e0
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103dfa:	81 fb b4 60 11 80    	cmp    $0x801160b4,%ebx
80103e00:	72 c4                	jb     80103dc6 <wakeup1+0x26>
    }
}
80103e02:	83 c4 10             	add    $0x10,%esp
80103e05:	5b                   	pop    %ebx
80103e06:	5e                   	pop    %esi
80103e07:	5d                   	pop    %ebp
80103e08:	c3                   	ret    
80103e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        rrq.enqueue(p);
80103e10:	ff 15 d0 b5 10 80    	call   *0x8010b5d0
80103e16:	eb a0                	jmp    80103db8 <wakeup1+0x18>
80103e18:	90                   	nop
80103e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103e20 <originalScheduler>:
{
80103e20:	55                   	push   %ebp
80103e21:	89 e5                	mov    %esp,%ebp
80103e23:	57                   	push   %edi
80103e24:	56                   	push   %esi
80103e25:	53                   	push   %ebx
80103e26:	83 ec 1c             	sub    $0x1c,%esp
80103e29:	8b 7d 0c             	mov    0xc(%ebp),%edi
  asm volatile("sti");
80103e2c:	fb                   	sti    
    acquire(&ptable.lock);
80103e2d:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e34:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
    acquire(&ptable.lock);
80103e39:	e8 42 19 00 00       	call   80105780 <acquire>
      swtch(&(c->scheduler), p->context);
80103e3e:	8d 77 04             	lea    0x4(%edi),%esi
80103e41:	eb 0d                	jmp    80103e50 <originalScheduler+0x30>
80103e43:	90                   	nop
80103e44:	90                   	nop
80103e45:	90                   	nop
80103e46:	90                   	nop
80103e47:	90                   	nop
80103e48:	90                   	nop
80103e49:	90                   	nop
80103e4a:	90                   	nop
80103e4b:	90                   	nop
80103e4c:	90                   	nop
80103e4d:	90                   	nop
80103e4e:	90                   	nop
80103e4f:	90                   	nop
      if(p->state != RUNNABLE)
80103e50:	8b 43 0c             	mov    0xc(%ebx),%eax
80103e53:	83 f8 03             	cmp    $0x3,%eax
80103e56:	75 31                	jne    80103e89 <originalScheduler+0x69>
      c->proc = p;
80103e58:	89 9f ac 00 00 00    	mov    %ebx,0xac(%edi)
      switchuvm(p);
80103e5e:	89 1c 24             	mov    %ebx,(%esp)
80103e61:	e8 ca 3e 00 00       	call   80107d30 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103e66:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103e69:	89 34 24             	mov    %esi,(%esp)
      p->state = RUNNING;
80103e6c:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103e73:	89 44 24 04          	mov    %eax,0x4(%esp)
80103e77:	e8 2d 1c 00 00       	call   80105aa9 <swtch>
      switchkvm();
80103e7c:	e8 8f 3e 00 00       	call   80107d10 <switchkvm>
      c->proc = 0;
80103e81:	31 c0                	xor    %eax,%eax
80103e83:	89 87 ac 00 00 00    	mov    %eax,0xac(%edi)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e89:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80103e8f:	81 fb b4 60 11 80    	cmp    $0x801160b4,%ebx
80103e95:	72 b9                	jb     80103e50 <originalScheduler+0x30>
    release(&ptable.lock);
80103e97:	c7 45 08 80 3d 11 80 	movl   $0x80113d80,0x8(%ebp)
}
80103e9e:	83 c4 1c             	add    $0x1c,%esp
80103ea1:	5b                   	pop    %ebx
80103ea2:	5e                   	pop    %esi
80103ea3:	5f                   	pop    %edi
80103ea4:	5d                   	pop    %ebp
    release(&ptable.lock);
80103ea5:	e9 76 19 00 00       	jmp    80105820 <release>
80103eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103eb0 <roundRobinScheduler>:
{
80103eb0:	55                   	push   %ebp
80103eb1:	89 e5                	mov    %esp,%ebp
80103eb3:	56                   	push   %esi
80103eb4:	53                   	push   %ebx
80103eb5:	83 ec 10             	sub    $0x10,%esp
80103eb8:	8b 75 0c             	mov    0xc(%ebp),%esi
80103ebb:	fb                   	sti    
    acquire(&ptable.lock);
80103ebc:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103ec3:	e8 b8 18 00 00       	call   80105780 <acquire>
	if(!rrq.isEmpty()){
80103ec8:	ff 15 cc b5 10 80    	call   *0x8010b5cc
80103ece:	85 c0                	test   %eax,%eax
80103ed0:	75 45                	jne    80103f17 <roundRobinScheduler+0x67>
		p = rrq.dequeue();
80103ed2:	ff 15 d4 b5 10 80    	call   *0x8010b5d4
80103ed8:	89 c3                	mov    %eax,%ebx
		c->proc = p;
80103eda:	89 86 ac 00 00 00    	mov    %eax,0xac(%esi)
		switchuvm(p);
80103ee0:	89 04 24             	mov    %eax,(%esp)
80103ee3:	e8 48 3e 00 00       	call   80107d30 <switchuvm>
		p->state = RUNNING;
80103ee8:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
		rpholder.add(p);
80103eef:	89 1c 24             	mov    %ebx,(%esp)
80103ef2:	ff 15 c0 b5 10 80    	call   *0x8010b5c0
		swtch(&(c->scheduler), p->context);
80103ef8:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103efb:	89 44 24 04          	mov    %eax,0x4(%esp)
80103eff:	8d 46 04             	lea    0x4(%esi),%eax
80103f02:	89 04 24             	mov    %eax,(%esp)
80103f05:	e8 9f 1b 00 00       	call   80105aa9 <swtch>
		switchkvm();
80103f0a:	e8 01 3e 00 00       	call   80107d10 <switchkvm>
		c->proc = 0;
80103f0f:	31 c0                	xor    %eax,%eax
80103f11:	89 86 ac 00 00 00    	mov    %eax,0xac(%esi)
    release(&ptable.lock);
80103f17:	c7 45 08 80 3d 11 80 	movl   $0x80113d80,0x8(%ebp)
}
80103f1e:	83 c4 10             	add    $0x10,%esp
80103f21:	5b                   	pop    %ebx
80103f22:	5e                   	pop    %esi
80103f23:	5d                   	pop    %ebp
    release(&ptable.lock);
80103f24:	e9 f7 18 00 00       	jmp    80105820 <release>
80103f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103f30 <priorityScheduler>:
{
80103f30:	55                   	push   %ebp
80103f31:	89 e5                	mov    %esp,%ebp
80103f33:	56                   	push   %esi
80103f34:	53                   	push   %ebx
80103f35:	83 ec 10             	sub    $0x10,%esp
80103f38:	8b 75 0c             	mov    0xc(%ebp),%esi
80103f3b:	fb                   	sti    
    acquire(&ptable.lock);
80103f3c:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103f43:	e8 38 18 00 00       	call   80105780 <acquire>
	if(!pq.isEmpty()){
80103f48:	ff 15 dc b5 10 80    	call   *0x8010b5dc
80103f4e:	85 c0                	test   %eax,%eax
80103f50:	75 45                	jne    80103f97 <priorityScheduler+0x67>
		p = pq.extractMin();
80103f52:	ff 15 e8 b5 10 80    	call   *0x8010b5e8
80103f58:	89 c3                	mov    %eax,%ebx
		c->proc = p;
80103f5a:	89 86 ac 00 00 00    	mov    %eax,0xac(%esi)
		switchuvm(p);
80103f60:	89 04 24             	mov    %eax,(%esp)
80103f63:	e8 c8 3d 00 00       	call   80107d30 <switchuvm>
		p->state = RUNNING;
80103f68:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
		rpholder.add(p);
80103f6f:	89 1c 24             	mov    %ebx,(%esp)
80103f72:	ff 15 c0 b5 10 80    	call   *0x8010b5c0
		swtch(&(c->scheduler), p->context);
80103f78:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103f7b:	89 44 24 04          	mov    %eax,0x4(%esp)
80103f7f:	8d 46 04             	lea    0x4(%esi),%eax
80103f82:	89 04 24             	mov    %eax,(%esp)
80103f85:	e8 1f 1b 00 00       	call   80105aa9 <swtch>
		switchkvm();
80103f8a:	e8 81 3d 00 00       	call   80107d10 <switchkvm>
		c->proc = 0;
80103f8f:	31 c0                	xor    %eax,%eax
80103f91:	89 86 ac 00 00 00    	mov    %eax,0xac(%esi)
    release(&ptable.lock);
80103f97:	c7 45 08 80 3d 11 80 	movl   $0x80113d80,0x8(%ebp)
}
80103f9e:	83 c4 10             	add    $0x10,%esp
80103fa1:	5b                   	pop    %ebx
80103fa2:	5e                   	pop    %esi
80103fa3:	5d                   	pop    %ebp
    release(&ptable.lock);
80103fa4:	e9 77 18 00 00       	jmp    80105820 <release>
80103fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103fb0 <scheduler>:
{
80103fb0:	55                   	push   %ebp
80103fb1:	89 e5                	mov    %esp,%ebp
80103fb3:	53                   	push   %ebx
80103fb4:	83 ec 14             	sub    $0x14,%esp
  struct cpu *c = mycpu();
80103fb7:	e8 24 f9 ff ff       	call   801038e0 <mycpu>
80103fbc:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
80103fbe:	31 c0                	xor    %eax,%eax
80103fc0:	89 83 ac 00 00 00    	mov    %eax,0xac(%ebx)
80103fc6:	8d 76 00             	lea    0x0(%esi),%esi
80103fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        switch(POLICY){
80103fd0:	a1 08 b0 10 80       	mov    0x8010b008,%eax
			priorityScheduler(p, c);
80103fd5:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80103fd9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        switch(POLICY){
80103fe0:	83 f8 02             	cmp    $0x2,%eax
80103fe3:	74 1b                	je     80104000 <scheduler+0x50>
80103fe5:	83 f8 03             	cmp    $0x3,%eax
80103fe8:	74 16                	je     80104000 <scheduler+0x50>
80103fea:	48                   	dec    %eax
80103feb:	74 23                	je     80104010 <scheduler+0x60>
80103fed:	8d 76 00             	lea    0x0(%esi),%esi
			originalScheduler(p, c);
80103ff0:	e8 2b fe ff ff       	call   80103e20 <originalScheduler>
			break;
80103ff5:	eb d9                	jmp    80103fd0 <scheduler+0x20>
80103ff7:	89 f6                	mov    %esi,%esi
80103ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
			priorityScheduler(p, c);
80104000:	e8 2b ff ff ff       	call   80103f30 <priorityScheduler>
			break;
80104005:	eb c9                	jmp    80103fd0 <scheduler+0x20>
80104007:	89 f6                	mov    %esi,%esi
80104009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
			roundRobinScheduler(p, c);
80104010:	e8 9b fe ff ff       	call   80103eb0 <roundRobinScheduler>
			break;
80104015:	eb b9                	jmp    80103fd0 <scheduler+0x20>
80104017:	89 f6                	mov    %esi,%esi
80104019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104020 <sched>:
{
80104020:	55                   	push   %ebp
80104021:	89 e5                	mov    %esp,%ebp
80104023:	56                   	push   %esi
80104024:	53                   	push   %ebx
80104025:	83 ec 10             	sub    $0x10,%esp
  pushcli();
80104028:	e8 73 16 00 00       	call   801056a0 <pushcli>
  c = mycpu();
8010402d:	e8 ae f8 ff ff       	call   801038e0 <mycpu>
  p = c->proc;
80104032:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104038:	e8 a3 16 00 00       	call   801056e0 <popcli>
  if(!holding(&ptable.lock))
8010403d:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80104044:	e8 f7 16 00 00       	call   80105740 <holding>
80104049:	85 c0                	test   %eax,%eax
8010404b:	74 51                	je     8010409e <sched+0x7e>
  if(mycpu()->ncli != 1)
8010404d:	e8 8e f8 ff ff       	call   801038e0 <mycpu>
80104052:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80104059:	75 67                	jne    801040c2 <sched+0xa2>
  if(p->state == RUNNING)
8010405b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010405e:	83 f8 04             	cmp    $0x4,%eax
80104061:	74 53                	je     801040b6 <sched+0x96>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104063:	9c                   	pushf  
80104064:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104065:	f6 c4 02             	test   $0x2,%ah
80104068:	75 40                	jne    801040aa <sched+0x8a>
  intena = mycpu()->intena;
8010406a:	e8 71 f8 ff ff       	call   801038e0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
8010406f:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104072:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104078:	e8 63 f8 ff ff       	call   801038e0 <mycpu>
8010407d:	8b 40 04             	mov    0x4(%eax),%eax
80104080:	89 1c 24             	mov    %ebx,(%esp)
80104083:	89 44 24 04          	mov    %eax,0x4(%esp)
80104087:	e8 1d 1a 00 00       	call   80105aa9 <swtch>
  mycpu()->intena = intena;
8010408c:	e8 4f f8 ff ff       	call   801038e0 <mycpu>
80104091:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104097:	83 c4 10             	add    $0x10,%esp
8010409a:	5b                   	pop    %ebx
8010409b:	5e                   	pop    %esi
8010409c:	5d                   	pop    %ebp
8010409d:	c3                   	ret    
    panic("sched ptable.lock");
8010409e:	c7 04 24 00 8a 10 80 	movl   $0x80108a00,(%esp)
801040a5:	e8 c6 c2 ff ff       	call   80100370 <panic>
    panic("sched interruptible");
801040aa:	c7 04 24 2c 8a 10 80 	movl   $0x80108a2c,(%esp)
801040b1:	e8 ba c2 ff ff       	call   80100370 <panic>
    panic("sched running");
801040b6:	c7 04 24 1e 8a 10 80 	movl   $0x80108a1e,(%esp)
801040bd:	e8 ae c2 ff ff       	call   80100370 <panic>
    panic("sched locks");
801040c2:	c7 04 24 12 8a 10 80 	movl   $0x80108a12,(%esp)
801040c9:	e8 a2 c2 ff ff       	call   80100370 <panic>
801040ce:	66 90                	xchg   %ax,%ax

801040d0 <exit>:
{
801040d0:	55                   	push   %ebp
801040d1:	89 e5                	mov    %esp,%ebp
801040d3:	57                   	push   %edi
801040d4:	56                   	push   %esi
801040d5:	53                   	push   %ebx
801040d6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
801040d9:	e8 c2 15 00 00       	call   801056a0 <pushcli>
  c = mycpu();
801040de:	e8 fd f7 ff ff       	call   801038e0 <mycpu>
  p = c->proc;
801040e3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801040e9:	e8 f2 15 00 00       	call   801056e0 <popcli>
  if(curproc == initproc)
801040ee:	39 35 b8 b5 10 80    	cmp    %esi,0x8010b5b8
801040f4:	0f 84 b4 00 00 00    	je     801041ae <exit+0xde>
801040fa:	8d 5e 28             	lea    0x28(%esi),%ebx
801040fd:	8d 7e 68             	lea    0x68(%esi),%edi
    if(curproc->ofile[fd]){
80104100:	8b 03                	mov    (%ebx),%eax
80104102:	85 c0                	test   %eax,%eax
80104104:	74 0e                	je     80104114 <exit+0x44>
      fileclose(curproc->ofile[fd]);
80104106:	89 04 24             	mov    %eax,(%esp)
80104109:	e8 22 cd ff ff       	call   80100e30 <fileclose>
      curproc->ofile[fd] = 0;
8010410e:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104114:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80104117:	39 df                	cmp    %ebx,%edi
80104119:	75 e5                	jne    80104100 <exit+0x30>
  begin_op();
8010411b:	e8 70 eb ff ff       	call   80102c90 <begin_op>
  iput(curproc->cwd);
80104120:	8b 46 68             	mov    0x68(%esi),%eax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104123:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
  iput(curproc->cwd);
80104128:	89 04 24             	mov    %eax,(%esp)
8010412b:	e8 f0 d6 ff ff       	call   80101820 <iput>
  end_op();
80104130:	e8 cb eb ff ff       	call   80102d00 <end_op>
  curproc->cwd = 0;
80104135:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
8010413c:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80104143:	e8 38 16 00 00       	call   80105780 <acquire>
  wakeup1(curproc->parent);
80104148:	8b 46 14             	mov    0x14(%esi),%eax
8010414b:	e8 50 fc ff ff       	call   80103da0 <wakeup1>
80104150:	eb 14                	jmp    80104166 <exit+0x96>
80104152:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104158:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
8010415e:	81 fb b4 60 11 80    	cmp    $0x801160b4,%ebx
80104164:	73 2a                	jae    80104190 <exit+0xc0>
    if(p->parent == curproc){
80104166:	39 73 14             	cmp    %esi,0x14(%ebx)
80104169:	75 ed                	jne    80104158 <exit+0x88>
      if(p->state == ZOMBIE)
8010416b:	8b 53 0c             	mov    0xc(%ebx),%edx
      p->parent = initproc;
8010416e:	a1 b8 b5 10 80       	mov    0x8010b5b8,%eax
      if(p->state == ZOMBIE)
80104173:	83 fa 05             	cmp    $0x5,%edx
      p->parent = initproc;
80104176:	89 43 14             	mov    %eax,0x14(%ebx)
      if(p->state == ZOMBIE)
80104179:	75 dd                	jne    80104158 <exit+0x88>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010417b:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
        wakeup1(initproc);
80104181:	e8 1a fc ff ff       	call   80103da0 <wakeup1>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104186:	81 fb b4 60 11 80    	cmp    $0x801160b4,%ebx
8010418c:	72 d8                	jb     80104166 <exit+0x96>
8010418e:	66 90                	xchg   %ax,%ax
  curproc->exitStatus = status;
80104190:	8b 45 08             	mov    0x8(%ebp),%eax
  curproc->state = ZOMBIE;
80104193:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  curproc->exitStatus = status;
8010419a:	89 46 7c             	mov    %eax,0x7c(%esi)
  sched();
8010419d:	e8 7e fe ff ff       	call   80104020 <sched>
  panic("zombie exit");
801041a2:	c7 04 24 4d 8a 10 80 	movl   $0x80108a4d,(%esp)
801041a9:	e8 c2 c1 ff ff       	call   80100370 <panic>
    panic("init exiting");
801041ae:	c7 04 24 40 8a 10 80 	movl   $0x80108a40,(%esp)
801041b5:	e8 b6 c1 ff ff       	call   80100370 <panic>
801041ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801041c0 <yield>:
{
801041c0:	55                   	push   %ebp
801041c1:	89 e5                	mov    %esp,%ebp
801041c3:	53                   	push   %ebx
801041c4:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801041c7:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
801041ce:	e8 ad 15 00 00       	call   80105780 <acquire>
  pushcli();
801041d3:	e8 c8 14 00 00       	call   801056a0 <pushcli>
  c = mycpu();
801041d8:	e8 03 f7 ff ff       	call   801038e0 <mycpu>
  p = c->proc;
801041dd:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801041e3:	e8 f8 14 00 00       	call   801056e0 <popcli>
  if(p->state == RUNNING)
801041e8:	8b 43 0c             	mov    0xc(%ebx),%eax
801041eb:	83 f8 04             	cmp    $0x4,%eax
801041ee:	75 09                	jne    801041f9 <yield+0x39>
      rpholder.remove(p);
801041f0:	89 1c 24             	mov    %ebx,(%esp)
801041f3:	ff 15 c4 b5 10 80    	call   *0x8010b5c4
  if(POLICY == 1){
801041f9:	a1 08 b0 10 80       	mov    0x8010b008,%eax
  p->state = RUNNABLE;
801041fe:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  if(POLICY == 1){
80104205:	83 f8 01             	cmp    $0x1,%eax
80104208:	75 2e                	jne    80104238 <yield+0x78>
      rpholder.remove(p);
8010420a:	89 1c 24             	mov    %ebx,(%esp)
8010420d:	ff 15 c4 b5 10 80    	call   *0x8010b5c4
      rrq.enqueue(p);
80104213:	89 1c 24             	mov    %ebx,(%esp)
80104216:	ff 15 d0 b5 10 80    	call   *0x8010b5d0
  sched();
8010421c:	e8 ff fd ff ff       	call   80104020 <sched>
  release(&ptable.lock);
80104221:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80104228:	e8 f3 15 00 00       	call   80105820 <release>
}
8010422d:	83 c4 14             	add    $0x14,%esp
80104230:	5b                   	pop    %ebx
80104231:	5d                   	pop    %ebp
80104232:	c3                   	ret    
80104233:	90                   	nop
80104234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (POLICY == 2){
80104238:	83 f8 02             	cmp    $0x2,%eax
8010423b:	75 df                	jne    8010421c <yield+0x5c>
      pq.put(p);
8010423d:	89 1c 24             	mov    %ebx,(%esp)
80104240:	ff 15 e0 b5 10 80    	call   *0x8010b5e0
      rpholder.remove(p);
80104246:	89 1c 24             	mov    %ebx,(%esp)
80104249:	ff 15 c4 b5 10 80    	call   *0x8010b5c4
      p->accumulator += p->priority;
8010424f:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
80104255:	99                   	cltd   
80104256:	01 83 84 00 00 00    	add    %eax,0x84(%ebx)
8010425c:	11 93 88 00 00 00    	adc    %edx,0x88(%ebx)
80104262:	eb b8                	jmp    8010421c <yield+0x5c>
80104264:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010426a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104270 <sleep>:
{
80104270:	55                   	push   %ebp
80104271:	89 e5                	mov    %esp,%ebp
80104273:	83 ec 28             	sub    $0x28,%esp
80104276:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80104279:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010427c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010427f:	89 7d fc             	mov    %edi,-0x4(%ebp)
80104282:	8b 7d 08             	mov    0x8(%ebp),%edi
  pushcli();
80104285:	e8 16 14 00 00       	call   801056a0 <pushcli>
  c = mycpu();
8010428a:	e8 51 f6 ff ff       	call   801038e0 <mycpu>
  p = c->proc;
8010428f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104295:	e8 46 14 00 00       	call   801056e0 <popcli>
  if(p == 0)
8010429a:	85 db                	test   %ebx,%ebx
8010429c:	0f 84 8d 00 00 00    	je     8010432f <sleep+0xbf>
  if(lk == 0)
801042a2:	85 f6                	test   %esi,%esi
801042a4:	74 7d                	je     80104323 <sleep+0xb3>
  if(lk != &ptable.lock){  //DOC: sleeplock0
801042a6:	81 fe 80 3d 11 80    	cmp    $0x80113d80,%esi
801042ac:	74 52                	je     80104300 <sleep+0x90>
    acquire(&ptable.lock);  //DOC: sleeplock1
801042ae:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
801042b5:	e8 c6 14 00 00       	call   80105780 <acquire>
    release(lk);
801042ba:	89 34 24             	mov    %esi,(%esp)
801042bd:	e8 5e 15 00 00       	call   80105820 <release>
  p->chan = chan;
801042c2:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801042c5:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801042cc:	e8 4f fd ff ff       	call   80104020 <sched>
  p->chan = 0;
801042d1:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
801042d8:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
801042df:	e8 3c 15 00 00       	call   80105820 <release>
}
801042e4:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    acquire(lk);
801042e7:	89 75 08             	mov    %esi,0x8(%ebp)
}
801042ea:	8b 7d fc             	mov    -0x4(%ebp),%edi
801042ed:	8b 75 f8             	mov    -0x8(%ebp),%esi
801042f0:	89 ec                	mov    %ebp,%esp
801042f2:	5d                   	pop    %ebp
    acquire(lk);
801042f3:	e9 88 14 00 00       	jmp    80105780 <acquire>
801042f8:	90                   	nop
801042f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104300:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104303:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
8010430a:	e8 11 fd ff ff       	call   80104020 <sched>
  p->chan = 0;
8010430f:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104316:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104319:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010431c:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010431f:	89 ec                	mov    %ebp,%esp
80104321:	5d                   	pop    %ebp
80104322:	c3                   	ret    
    panic("sleep without lk");
80104323:	c7 04 24 5f 8a 10 80 	movl   $0x80108a5f,(%esp)
8010432a:	e8 41 c0 ff ff       	call   80100370 <panic>
    panic("sleep");
8010432f:	c7 04 24 59 8a 10 80 	movl   $0x80108a59,(%esp)
80104336:	e8 35 c0 ff ff       	call   80100370 <panic>
8010433b:	90                   	nop
8010433c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104340 <wait>:
{
80104340:	55                   	push   %ebp
80104341:	89 e5                	mov    %esp,%ebp
80104343:	57                   	push   %edi
80104344:	56                   	push   %esi
80104345:	53                   	push   %ebx
80104346:	83 ec 1c             	sub    $0x1c,%esp
80104349:	8b 7d 08             	mov    0x8(%ebp),%edi
  pushcli();
8010434c:	e8 4f 13 00 00       	call   801056a0 <pushcli>
  c = mycpu();
80104351:	e8 8a f5 ff ff       	call   801038e0 <mycpu>
  p = c->proc;
80104356:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
8010435c:	e8 7f 13 00 00       	call   801056e0 <popcli>
  acquire(&ptable.lock);
80104361:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80104368:	e8 13 14 00 00       	call   80105780 <acquire>
    havekids = 0;
8010436d:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010436f:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
80104374:	eb 18                	jmp    8010438e <wait+0x4e>
80104376:	8d 76 00             	lea    0x0(%esi),%esi
80104379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104380:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80104386:	81 fb b4 60 11 80    	cmp    $0x801160b4,%ebx
8010438c:	73 20                	jae    801043ae <wait+0x6e>
      if(p->parent != curproc)
8010438e:	39 73 14             	cmp    %esi,0x14(%ebx)
80104391:	75 ed                	jne    80104380 <wait+0x40>
      if(p->state == ZOMBIE){
80104393:	8b 43 0c             	mov    0xc(%ebx),%eax
80104396:	83 f8 05             	cmp    $0x5,%eax
80104399:	74 35                	je     801043d0 <wait+0x90>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010439b:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
      havekids = 1;
801043a1:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043a6:	81 fb b4 60 11 80    	cmp    $0x801160b4,%ebx
801043ac:	72 e0                	jb     8010438e <wait+0x4e>
    if(!havekids || curproc->killed){
801043ae:	85 c0                	test   %eax,%eax
801043b0:	74 7d                	je     8010442f <wait+0xef>
801043b2:	8b 56 24             	mov    0x24(%esi),%edx
801043b5:	85 d2                	test   %edx,%edx
801043b7:	75 76                	jne    8010442f <wait+0xef>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
801043b9:	b8 80 3d 11 80       	mov    $0x80113d80,%eax
801043be:	89 44 24 04          	mov    %eax,0x4(%esp)
801043c2:	89 34 24             	mov    %esi,(%esp)
801043c5:	e8 a6 fe ff ff       	call   80104270 <sleep>
    havekids = 0;
801043ca:	eb a1                	jmp    8010436d <wait+0x2d>
801043cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
801043d0:	8b 43 08             	mov    0x8(%ebx),%eax
        pid = p->pid;
801043d3:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801043d6:	89 04 24             	mov    %eax,(%esp)
801043d9:	e8 02 e0 ff ff       	call   801023e0 <kfree>
        freevm(p->pgdir);
801043de:	8b 43 04             	mov    0x4(%ebx),%eax
        p->kstack = 0;
801043e1:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801043e8:	89 04 24             	mov    %eax,(%esp)
801043eb:	e8 f0 3c 00 00       	call   801080e0 <freevm>
        if(status) /*status is not null*/
801043f0:	85 ff                	test   %edi,%edi
        p->pid = 0;
801043f2:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801043f9:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104400:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104404:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
8010440b:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        if(status) /*status is not null*/
80104412:	74 05                	je     80104419 <wait+0xd9>
                *status = p->exitStatus;
80104414:	8b 43 7c             	mov    0x7c(%ebx),%eax
80104417:	89 07                	mov    %eax,(%edi)
        release(&ptable.lock);
80104419:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80104420:	e8 fb 13 00 00       	call   80105820 <release>
}
80104425:	83 c4 1c             	add    $0x1c,%esp
80104428:	89 f0                	mov    %esi,%eax
8010442a:	5b                   	pop    %ebx
8010442b:	5e                   	pop    %esi
8010442c:	5f                   	pop    %edi
8010442d:	5d                   	pop    %ebp
8010442e:	c3                   	ret    
      release(&ptable.lock);
8010442f:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
      return -1;
80104436:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010443b:	e8 e0 13 00 00       	call   80105820 <release>
      return -1;
80104440:	eb e3                	jmp    80104425 <wait+0xe5>
80104442:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104450 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104450:	55                   	push   %ebp
80104451:	89 e5                	mov    %esp,%ebp
80104453:	53                   	push   %ebx
80104454:	83 ec 14             	sub    $0x14,%esp
80104457:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010445a:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80104461:	e8 1a 13 00 00       	call   80105780 <acquire>
  wakeup1(chan);
80104466:	89 d8                	mov    %ebx,%eax
80104468:	e8 33 f9 ff ff       	call   80103da0 <wakeup1>
  release(&ptable.lock);
8010446d:	c7 45 08 80 3d 11 80 	movl   $0x80113d80,0x8(%ebp)
}
80104474:	83 c4 14             	add    $0x14,%esp
80104477:	5b                   	pop    %ebx
80104478:	5d                   	pop    %ebp
  release(&ptable.lock);
80104479:	e9 a2 13 00 00       	jmp    80105820 <release>
8010447e:	66 90                	xchg   %ax,%ax

80104480 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104480:	55                   	push   %ebp
80104481:	89 e5                	mov    %esp,%ebp
80104483:	56                   	push   %esi
80104484:	53                   	push   %ebx
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104485:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
{
8010448a:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010448d:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
{
80104494:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&ptable.lock);
80104497:	e8 e4 12 00 00       	call   80105780 <acquire>
8010449c:	eb 10                	jmp    801044ae <kill+0x2e>
8010449e:	66 90                	xchg   %ax,%ax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044a0:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
801044a6:	81 fb b4 60 11 80    	cmp    $0x801160b4,%ebx
801044ac:	73 5a                	jae    80104508 <kill+0x88>
    if(p->pid == pid){
801044ae:	39 73 10             	cmp    %esi,0x10(%ebx)
801044b1:	75 ed                	jne    801044a0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING){
801044b3:	8b 43 0c             	mov    0xc(%ebx),%eax
      p->killed = 1;
801044b6:	c7 43 24 01 00 00 00 	movl   $0x1,0x24(%ebx)
      if(p->state == SLEEPING){
801044bd:	83 f8 02             	cmp    $0x2,%eax
801044c0:	74 1e                	je     801044e0 <kill+0x60>
        if(POLICY == 1)
            rrq.enqueue(p);
        else
            pq.put(p);
      }
      release(&ptable.lock);
801044c2:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
801044c9:	e8 52 13 00 00       	call   80105820 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801044ce:	83 c4 10             	add    $0x10,%esp
      return 0;
801044d1:	31 c0                	xor    %eax,%eax
}
801044d3:	5b                   	pop    %ebx
801044d4:	5e                   	pop    %esi
801044d5:	5d                   	pop    %ebp
801044d6:	c3                   	ret    
801044d7:	89 f6                	mov    %esi,%esi
801044d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        setAccumulator(p);  
801044e0:	89 1c 24             	mov    %ebx,(%esp)
        p->state = RUNNABLE;
801044e3:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
        setAccumulator(p);  
801044ea:	e8 71 f6 ff ff       	call   80103b60 <setAccumulator>
        if(POLICY == 1)
801044ef:	83 3d 08 b0 10 80 01 	cmpl   $0x1,0x8010b008
            rrq.enqueue(p);
801044f6:	89 1c 24             	mov    %ebx,(%esp)
        if(POLICY == 1)
801044f9:	74 25                	je     80104520 <kill+0xa0>
            pq.put(p);
801044fb:	ff 15 e0 b5 10 80    	call   *0x8010b5e0
80104501:	eb bf                	jmp    801044c2 <kill+0x42>
80104503:	90                   	nop
80104504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104508:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
8010450f:	e8 0c 13 00 00       	call   80105820 <release>
}
80104514:	83 c4 10             	add    $0x10,%esp
  return -1;
80104517:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010451c:	5b                   	pop    %ebx
8010451d:	5e                   	pop    %esi
8010451e:	5d                   	pop    %ebp
8010451f:	c3                   	ret    
            rrq.enqueue(p);
80104520:	ff 15 d0 b5 10 80    	call   *0x8010b5d0
80104526:	eb 9a                	jmp    801044c2 <kill+0x42>
80104528:	90                   	nop
80104529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104530 <detach>:

// transfer a child process with the given pid from the parent to the init process.
// return 0 when succseeds or -1 if the process has no child with this pid.
int
detach(int pid)
{ 
80104530:	55                   	push   %ebp
80104531:	89 e5                	mov    %esp,%ebp
80104533:	57                   	push   %edi
80104534:	56                   	push   %esi
80104535:	53                   	push   %ebx
80104536:	83 ec 1c             	sub    $0x1c,%esp
80104539:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
8010453c:	e8 5f 11 00 00       	call   801056a0 <pushcli>
  c = mycpu();
80104541:	e8 9a f3 ff ff       	call   801038e0 <mycpu>
  p = c->proc;
80104546:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010454c:	e8 8f 11 00 00       	call   801056e0 <popcli>
  struct proc *curproc = myproc();
  struct proc *p;
  int procExist = -1;

  if(curproc == initproc)
80104551:	39 1d b8 b5 10 80    	cmp    %ebx,0x8010b5b8
80104557:	74 6d                	je     801045c6 <detach+0x96>
    panic("init called detach");

  acquire(&ptable.lock);
80104559:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
  int procExist = -1;
80104560:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104565:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
  acquire(&ptable.lock);
8010456a:	e8 11 12 00 00       	call   80105780 <acquire>
8010456f:	eb 15                	jmp    80104586 <detach+0x56>
80104571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104578:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
8010457e:	81 fb b4 60 11 80    	cmp    $0x801160b4,%ebx
80104584:	73 2a                	jae    801045b0 <detach+0x80>
    if(p->pid == pid){
80104586:	39 73 10             	cmp    %esi,0x10(%ebx)
80104589:	75 ed                	jne    80104578 <detach+0x48>
	  procExist = 0;	
      p->parent = initproc;
      if(p->state == ZOMBIE)
8010458b:	8b 53 0c             	mov    0xc(%ebx),%edx
	  procExist = 0;	
8010458e:	31 ff                	xor    %edi,%edi
      p->parent = initproc;
80104590:	a1 b8 b5 10 80       	mov    0x8010b5b8,%eax
      if(p->state == ZOMBIE)
80104595:	83 fa 05             	cmp    $0x5,%edx
      p->parent = initproc;
80104598:	89 43 14             	mov    %eax,0x14(%ebx)
      if(p->state == ZOMBIE)
8010459b:	75 db                	jne    80104578 <detach+0x48>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010459d:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
        wakeup1(initproc);
801045a3:	e8 f8 f7 ff ff       	call   80103da0 <wakeup1>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045a8:	81 fb b4 60 11 80    	cmp    $0x801160b4,%ebx
801045ae:	72 d6                	jb     80104586 <detach+0x56>
    }
  }
  release(&ptable.lock);
801045b0:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
801045b7:	e8 64 12 00 00       	call   80105820 <release>
  return procExist;
}
801045bc:	83 c4 1c             	add    $0x1c,%esp
801045bf:	89 f8                	mov    %edi,%eax
801045c1:	5b                   	pop    %ebx
801045c2:	5e                   	pop    %esi
801045c3:	5f                   	pop    %edi
801045c4:	5d                   	pop    %ebp
801045c5:	c3                   	ret    
    panic("init called detach");
801045c6:	c7 04 24 70 8a 10 80 	movl   $0x80108a70,(%esp)
801045cd:	e8 9e bd ff ff       	call   80100370 <panic>
801045d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045e0 <priority>:

// used by a process to change its priority
void
priority(int proc_priority)
{
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	83 ec 18             	sub    $0x18,%esp
801045e6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801045e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801045ec:	89 75 fc             	mov    %esi,-0x4(%ebp)
  pushcli();
801045ef:	e8 ac 10 00 00       	call   801056a0 <pushcli>
  c = mycpu();
801045f4:	e8 e7 f2 ff ff       	call   801038e0 <mycpu>
  p = c->proc;
801045f9:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801045ff:	e8 dc 10 00 00       	call   801056e0 <popcli>
  struct proc *curproc = myproc();
  
  if(proc_priority <= 10 && proc_priority >= 0){
80104604:	83 fb 0a             	cmp    $0xa,%ebx
80104607:	77 13                	ja     8010461c <priority+0x3c>
      if(POLICY == 3 || (POLICY == 2 && proc_priority >= 1)){
80104609:	a1 08 b0 10 80       	mov    0x8010b008,%eax
8010460e:	83 f8 03             	cmp    $0x3,%eax
80104611:	74 1d                	je     80104630 <priority+0x50>
80104613:	83 f8 02             	cmp    $0x2,%eax
80104616:	75 04                	jne    8010461c <priority+0x3c>
80104618:	85 db                	test   %ebx,%ebx
8010461a:	75 14                	jne    80104630 <priority+0x50>
        acquire(&ptable.lock);
        curproc->priority = proc_priority;
        release(&ptable.lock); 
      }
  }
}
8010461c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010461f:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104622:	89 ec                	mov    %ebp,%esp
80104624:	5d                   	pop    %ebp
80104625:	c3                   	ret    
80104626:	8d 76 00             	lea    0x0(%esi),%esi
80104629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        acquire(&ptable.lock);
80104630:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80104637:	e8 44 11 00 00       	call   80105780 <acquire>
        curproc->priority = proc_priority;
8010463c:	89 9e 80 00 00 00    	mov    %ebx,0x80(%esi)
}
80104642:	8b 5d f8             	mov    -0x8(%ebp),%ebx
        release(&ptable.lock); 
80104645:	c7 45 08 80 3d 11 80 	movl   $0x80113d80,0x8(%ebp)
}
8010464c:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010464f:	89 ec                	mov    %ebp,%esp
80104651:	5d                   	pop    %ebp
        release(&ptable.lock); 
80104652:	e9 c9 11 00 00       	jmp    80105820 <release>
80104657:	89 f6                	mov    %esi,%esi
80104659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104660 <policy>:

// receives a policy identifier as an argument and changes the currently used policy.
void
policy(int policy_id)
{
80104660:	55                   	push   %ebp
80104661:	89 e5                	mov    %esp,%ebp
80104663:	53                   	push   %ebx
80104664:	83 ec 14             	sub    $0x14,%esp
80104667:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct proc *p;
    cprintf("policy_id: %d", policy_id);
8010466a:	c7 04 24 83 8a 10 80 	movl   $0x80108a83,(%esp)
80104671:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104675:	e8 d6 bf ff ff       	call   80100650 <cprintf>
    
    acquire(&ptable.lock);
8010467a:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80104681:	e8 fa 10 00 00       	call   80105780 <acquire>
    POLICY = policy_id;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104686:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
    POLICY = policy_id;
8010468b:	89 1d 08 b0 10 80    	mov    %ebx,0x8010b008
80104691:	eb 16                	jmp    801046a9 <policy+0x49>
80104693:	90                   	nop
80104694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(policy_id == 1) /*change to round robin policy*/
            p->accumulator = 0;
        else if(policy_id == 2){
80104698:	83 fb 02             	cmp    $0x2,%ebx
8010469b:	74 43                	je     801046e0 <policy+0x80>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010469d:	05 8c 00 00 00       	add    $0x8c,%eax
801046a2:	3d b4 60 11 80       	cmp    $0x801160b4,%eax
801046a7:	73 1e                	jae    801046c7 <policy+0x67>
        if(policy_id == 1) /*change to round robin policy*/
801046a9:	83 fb 01             	cmp    $0x1,%ebx
801046ac:	75 ea                	jne    80104698 <policy+0x38>
            p->accumulator = 0;
801046ae:	31 d2                	xor    %edx,%edx
801046b0:	31 c9                	xor    %ecx,%ecx
801046b2:	89 90 84 00 00 00    	mov    %edx,0x84(%eax)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046b8:	05 8c 00 00 00       	add    $0x8c,%eax
            p->accumulator = 0;
801046bd:	89 48 fc             	mov    %ecx,-0x4(%eax)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046c0:	3d b4 60 11 80       	cmp    $0x801160b4,%eax
801046c5:	72 e2                	jb     801046a9 <policy+0x49>
            if(p->priority == 0) /*change to priority scheduling policy*/
                p->priority = 1;
        }
    }
    release(&ptable.lock);
801046c7:	c7 45 08 80 3d 11 80 	movl   $0x80113d80,0x8(%ebp)
}
801046ce:	83 c4 14             	add    $0x14,%esp
801046d1:	5b                   	pop    %ebx
801046d2:	5d                   	pop    %ebp
    release(&ptable.lock);
801046d3:	e9 48 11 00 00       	jmp    80105820 <release>
801046d8:	90                   	nop
801046d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            if(p->priority == 0) /*change to priority scheduling policy*/
801046e0:	8b 88 80 00 00 00    	mov    0x80(%eax),%ecx
801046e6:	85 c9                	test   %ecx,%ecx
801046e8:	75 b3                	jne    8010469d <policy+0x3d>
                p->priority = 1;
801046ea:	ba 01 00 00 00       	mov    $0x1,%edx
801046ef:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
801046f5:	eb a6                	jmp    8010469d <policy+0x3d>
801046f7:	89 f6                	mov    %esi,%esi
801046f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104700 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104700:	55                   	push   %ebp
80104701:	89 e5                	mov    %esp,%ebp
80104703:	57                   	push   %edi
80104704:	56                   	push   %esi
80104705:	53                   	push   %ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104706:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
{
8010470b:	83 ec 4c             	sub    $0x4c,%esp
8010470e:	eb 1e                	jmp    8010472e <procdump+0x2e>
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104710:	c7 04 24 19 8b 10 80 	movl   $0x80108b19,(%esp)
80104717:	e8 34 bf ff ff       	call   80100650 <cprintf>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010471c:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80104722:	81 fb b4 60 11 80    	cmp    $0x801160b4,%ebx
80104728:	0f 83 b2 00 00 00    	jae    801047e0 <procdump+0xe0>
    if(p->state == UNUSED)
8010472e:	8b 43 0c             	mov    0xc(%ebx),%eax
80104731:	85 c0                	test   %eax,%eax
80104733:	74 e7                	je     8010471c <procdump+0x1c>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104735:	8b 43 0c             	mov    0xc(%ebx),%eax
      state = "???";
80104738:	b8 91 8a 10 80       	mov    $0x80108a91,%eax
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010473d:	8b 53 0c             	mov    0xc(%ebx),%edx
80104740:	83 fa 05             	cmp    $0x5,%edx
80104743:	77 18                	ja     8010475d <procdump+0x5d>
80104745:	8b 53 0c             	mov    0xc(%ebx),%edx
80104748:	8b 14 95 f0 8a 10 80 	mov    -0x7fef7510(,%edx,4),%edx
8010474f:	85 d2                	test   %edx,%edx
80104751:	74 0a                	je     8010475d <procdump+0x5d>
      state = states[p->state];
80104753:	8b 43 0c             	mov    0xc(%ebx),%eax
80104756:	8b 04 85 f0 8a 10 80 	mov    -0x7fef7510(,%eax,4),%eax
    cprintf("%d %s %s", p->pid, state, p->name);
8010475d:	89 44 24 08          	mov    %eax,0x8(%esp)
80104761:	8b 43 10             	mov    0x10(%ebx),%eax
80104764:	8d 53 6c             	lea    0x6c(%ebx),%edx
80104767:	89 54 24 0c          	mov    %edx,0xc(%esp)
8010476b:	c7 04 24 95 8a 10 80 	movl   $0x80108a95,(%esp)
80104772:	89 44 24 04          	mov    %eax,0x4(%esp)
80104776:	e8 d5 be ff ff       	call   80100650 <cprintf>
    if(p->state == SLEEPING){
8010477b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010477e:	83 f8 02             	cmp    $0x2,%eax
80104781:	75 8d                	jne    80104710 <procdump+0x10>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104783:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104786:	89 44 24 04          	mov    %eax,0x4(%esp)
8010478a:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010478d:	8d 75 c0             	lea    -0x40(%ebp),%esi
80104790:	8d 7d e8             	lea    -0x18(%ebp),%edi
80104793:	8b 40 0c             	mov    0xc(%eax),%eax
80104796:	83 c0 08             	add    $0x8,%eax
80104799:	89 04 24             	mov    %eax,(%esp)
8010479c:	e8 af 0e 00 00       	call   80105650 <getcallerpcs>
801047a1:	eb 0d                	jmp    801047b0 <procdump+0xb0>
801047a3:	90                   	nop
801047a4:	90                   	nop
801047a5:	90                   	nop
801047a6:	90                   	nop
801047a7:	90                   	nop
801047a8:	90                   	nop
801047a9:	90                   	nop
801047aa:	90                   	nop
801047ab:	90                   	nop
801047ac:	90                   	nop
801047ad:	90                   	nop
801047ae:	90                   	nop
801047af:	90                   	nop
      for(i=0; i<10 && pc[i] != 0; i++)
801047b0:	8b 16                	mov    (%esi),%edx
801047b2:	85 d2                	test   %edx,%edx
801047b4:	0f 84 56 ff ff ff    	je     80104710 <procdump+0x10>
        cprintf(" %p", pc[i]);
801047ba:	89 54 24 04          	mov    %edx,0x4(%esp)
801047be:	83 c6 04             	add    $0x4,%esi
801047c1:	c7 04 24 61 84 10 80 	movl   $0x80108461,(%esp)
801047c8:	e8 83 be ff ff       	call   80100650 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801047cd:	39 f7                	cmp    %esi,%edi
801047cf:	75 df                	jne    801047b0 <procdump+0xb0>
801047d1:	e9 3a ff ff ff       	jmp    80104710 <procdump+0x10>
801047d6:	8d 76 00             	lea    0x0(%esi),%esi
801047d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }
}
801047e0:	83 c4 4c             	add    $0x4c,%esp
801047e3:	5b                   	pop    %ebx
801047e4:	5e                   	pop    %esi
801047e5:	5f                   	pop    %edi
801047e6:	5d                   	pop    %ebp
801047e7:	c3                   	ret    
801047e8:	66 90                	xchg   %ax,%ax
801047ea:	66 90                	xchg   %ax,%ax
801047ec:	66 90                	xchg   %ax,%ax
801047ee:	66 90                	xchg   %ax,%ax

801047f0 <isEmptyPriorityQueue>:
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
801047f0:	a1 0c b6 10 80       	mov    0x8010b60c,%eax
static boolean isEmptyPriorityQueue() {
801047f5:	55                   	push   %ebp
801047f6:	89 e5                	mov    %esp,%ebp
}
801047f8:	5d                   	pop    %ebp
	return !root;
801047f9:	8b 00                	mov    (%eax),%eax
801047fb:	85 c0                	test   %eax,%eax
801047fd:	0f 94 c0             	sete   %al
80104800:	0f b6 c0             	movzbl %al,%eax
}
80104803:	c3                   	ret    
80104804:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010480a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104810 <getMinAccumulatorPriorityQueue>:
	return !root;
80104810:	a1 0c b6 10 80       	mov    0x8010b60c,%eax
80104815:	8b 10                	mov    (%eax),%edx
	
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
	if(isEmpty())
80104817:	85 d2                	test   %edx,%edx
80104819:	74 35                	je     80104850 <getMinAccumulatorPriorityQueue+0x40>
static boolean getMinAccumulatorPriorityQueue(long long* pkey) {
8010481b:	55                   	push   %ebp
8010481c:	89 e5                	mov    %esp,%ebp
8010481e:	53                   	push   %ebx
8010481f:	eb 09                	jmp    8010482a <getMinAccumulatorPriorityQueue+0x1a>
80104821:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	while(minNode->left)
80104828:	89 c2                	mov    %eax,%edx
8010482a:	8b 42 18             	mov    0x18(%edx),%eax
8010482d:	85 c0                	test   %eax,%eax
8010482f:	75 f7                	jne    80104828 <getMinAccumulatorPriorityQueue+0x18>
	*pkey = getMinNode()->key;
80104831:	8b 45 08             	mov    0x8(%ebp),%eax
80104834:	8b 5a 04             	mov    0x4(%edx),%ebx
80104837:	8b 0a                	mov    (%edx),%ecx
80104839:	89 58 04             	mov    %ebx,0x4(%eax)
8010483c:	89 08                	mov    %ecx,(%eax)
8010483e:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104843:	5b                   	pop    %ebx
80104844:	5d                   	pop    %ebp
80104845:	c3                   	ret    
80104846:	8d 76 00             	lea    0x0(%esi),%esi
80104849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	if(isEmpty())
80104850:	31 c0                	xor    %eax,%eax
}
80104852:	c3                   	ret    
80104853:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104860 <isEmptyRoundRobinQueue>:
	return !first;
80104860:	a1 08 b6 10 80       	mov    0x8010b608,%eax
static boolean isEmptyRoundRobinQueue() {
80104865:	55                   	push   %ebp
80104866:	89 e5                	mov    %esp,%ebp
}
80104868:	5d                   	pop    %ebp
	return !first;
80104869:	8b 00                	mov    (%eax),%eax
8010486b:	85 c0                	test   %eax,%eax
8010486d:	0f 94 c0             	sete   %al
80104870:	0f b6 c0             	movzbl %al,%eax
}
80104873:	c3                   	ret    
80104874:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010487a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104880 <enqueueRoundRobinQueue>:
	if(!freeLinks)
80104880:	a1 00 b6 10 80       	mov    0x8010b600,%eax
80104885:	85 c0                	test   %eax,%eax
80104887:	74 47                	je     801048d0 <enqueueRoundRobinQueue+0x50>
static boolean enqueueRoundRobinQueue(Proc *p) {
80104889:	55                   	push   %ebp
	return roundRobinQ->enqueue(p);
8010488a:	8b 0d 08 b6 10 80    	mov    0x8010b608,%ecx
	freeLinks = freeLinks->next;
80104890:	8b 50 04             	mov    0x4(%eax),%edx
static boolean enqueueRoundRobinQueue(Proc *p) {
80104893:	89 e5                	mov    %esp,%ebp
	ans->next = null;
80104895:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
8010489c:	89 15 00 b6 10 80    	mov    %edx,0x8010b600
	ans->p = p;
801048a2:	8b 55 08             	mov    0x8(%ebp),%edx
801048a5:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
801048a7:	8b 11                	mov    (%ecx),%edx
801048a9:	85 d2                	test   %edx,%edx
801048ab:	74 2b                	je     801048d8 <enqueueRoundRobinQueue+0x58>
	else last->next = link;
801048ad:	8b 51 04             	mov    0x4(%ecx),%edx
801048b0:	89 42 04             	mov    %eax,0x4(%edx)
801048b3:	eb 05                	jmp    801048ba <enqueueRoundRobinQueue+0x3a>
801048b5:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
801048b8:	89 d0                	mov    %edx,%eax
801048ba:	8b 50 04             	mov    0x4(%eax),%edx
801048bd:	85 d2                	test   %edx,%edx
801048bf:	75 f7                	jne    801048b8 <enqueueRoundRobinQueue+0x38>
	last = link->getLast();
801048c1:	89 41 04             	mov    %eax,0x4(%ecx)
801048c4:	b8 01 00 00 00       	mov    $0x1,%eax
}
801048c9:	5d                   	pop    %ebp
801048ca:	c3                   	ret    
801048cb:	90                   	nop
801048cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!freeLinks)
801048d0:	31 c0                	xor    %eax,%eax
}
801048d2:	c3                   	ret    
801048d3:	90                   	nop
801048d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
801048d8:	89 01                	mov    %eax,(%ecx)
801048da:	eb de                	jmp    801048ba <enqueueRoundRobinQueue+0x3a>
801048dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801048e0 <dequeueRoundRobinQueue>:
	return roundRobinQ->dequeue();
801048e0:	8b 0d 08 b6 10 80    	mov    0x8010b608,%ecx
	return !first;
801048e6:	8b 11                	mov    (%ecx),%edx
	if(isEmpty())
801048e8:	85 d2                	test   %edx,%edx
801048ea:	74 3c                	je     80104928 <dequeueRoundRobinQueue+0x48>
static Proc* dequeueRoundRobinQueue() {
801048ec:	55                   	push   %ebp
801048ed:	89 e5                	mov    %esp,%ebp
801048ef:	83 ec 08             	sub    $0x8,%esp
801048f2:	89 75 fc             	mov    %esi,-0x4(%ebp)
	link->next = freeLinks;
801048f5:	8b 35 00 b6 10 80    	mov    0x8010b600,%esi
static Proc* dequeueRoundRobinQueue() {
801048fb:	89 5d f8             	mov    %ebx,-0x8(%ebp)
	Link *next = first->next;
801048fe:	8b 5a 04             	mov    0x4(%edx),%ebx
	Proc *p = first->p;
80104901:	8b 02                	mov    (%edx),%eax
	link->next = freeLinks;
80104903:	89 72 04             	mov    %esi,0x4(%edx)
	freeLinks = link;
80104906:	89 15 00 b6 10 80    	mov    %edx,0x8010b600
	if(isEmpty())
8010490c:	85 db                	test   %ebx,%ebx
	first = next;
8010490e:	89 19                	mov    %ebx,(%ecx)
	if(isEmpty())
80104910:	75 07                	jne    80104919 <dequeueRoundRobinQueue+0x39>
		last = null;
80104912:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
}
80104919:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010491c:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010491f:	89 ec                	mov    %ebp,%esp
80104921:	5d                   	pop    %ebp
80104922:	c3                   	ret    
80104923:	90                   	nop
80104924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		return null;
80104928:	31 c0                	xor    %eax,%eax
}
8010492a:	c3                   	ret    
8010492b:	90                   	nop
8010492c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104930 <isEmptyRunningProcessHolder>:
	return !first;
80104930:	a1 04 b6 10 80       	mov    0x8010b604,%eax
static boolean isEmptyRunningProcessHolder() {
80104935:	55                   	push   %ebp
80104936:	89 e5                	mov    %esp,%ebp
}
80104938:	5d                   	pop    %ebp
	return !first;
80104939:	8b 00                	mov    (%eax),%eax
8010493b:	85 c0                	test   %eax,%eax
8010493d:	0f 94 c0             	sete   %al
80104940:	0f b6 c0             	movzbl %al,%eax
}
80104943:	c3                   	ret    
80104944:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010494a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104950 <addRunningProcessHolder>:
	if(!freeLinks)
80104950:	a1 00 b6 10 80       	mov    0x8010b600,%eax
80104955:	85 c0                	test   %eax,%eax
80104957:	74 47                	je     801049a0 <addRunningProcessHolder+0x50>
static boolean addRunningProcessHolder(Proc* p) {
80104959:	55                   	push   %ebp
	return runningProcHolder->enqueue(p);
8010495a:	8b 0d 04 b6 10 80    	mov    0x8010b604,%ecx
	freeLinks = freeLinks->next;
80104960:	8b 50 04             	mov    0x4(%eax),%edx
static boolean addRunningProcessHolder(Proc* p) {
80104963:	89 e5                	mov    %esp,%ebp
	ans->next = null;
80104965:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
8010496c:	89 15 00 b6 10 80    	mov    %edx,0x8010b600
	ans->p = p;
80104972:	8b 55 08             	mov    0x8(%ebp),%edx
80104975:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80104977:	8b 11                	mov    (%ecx),%edx
80104979:	85 d2                	test   %edx,%edx
8010497b:	74 2b                	je     801049a8 <addRunningProcessHolder+0x58>
	else last->next = link;
8010497d:	8b 51 04             	mov    0x4(%ecx),%edx
80104980:	89 42 04             	mov    %eax,0x4(%edx)
80104983:	eb 05                	jmp    8010498a <addRunningProcessHolder+0x3a>
80104985:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
80104988:	89 d0                	mov    %edx,%eax
8010498a:	8b 50 04             	mov    0x4(%eax),%edx
8010498d:	85 d2                	test   %edx,%edx
8010498f:	75 f7                	jne    80104988 <addRunningProcessHolder+0x38>
	last = link->getLast();
80104991:	89 41 04             	mov    %eax,0x4(%ecx)
80104994:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104999:	5d                   	pop    %ebp
8010499a:	c3                   	ret    
8010499b:	90                   	nop
8010499c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!freeLinks)
801049a0:	31 c0                	xor    %eax,%eax
}
801049a2:	c3                   	ret    
801049a3:	90                   	nop
801049a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
801049a8:	89 01                	mov    %eax,(%ecx)
801049aa:	eb de                	jmp    8010498a <addRunningProcessHolder+0x3a>
801049ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801049b0 <_ZL9allocNodeP4procx>:
static MapNode* allocNode(Proc *p, long long key) {
801049b0:	55                   	push   %ebp
801049b1:	89 e5                	mov    %esp,%ebp
801049b3:	56                   	push   %esi
801049b4:	53                   	push   %ebx
	if(!freeNodes)
801049b5:	8b 1d fc b5 10 80    	mov    0x8010b5fc,%ebx
801049bb:	85 db                	test   %ebx,%ebx
801049bd:	74 4d                	je     80104a0c <_ZL9allocNodeP4procx+0x5c>
	ans->key = key;
801049bf:	89 13                	mov    %edx,(%ebx)
	if(!freeLinks)
801049c1:	8b 15 00 b6 10 80    	mov    0x8010b600,%edx
	freeNodes = freeNodes->next;
801049c7:	8b 73 10             	mov    0x10(%ebx),%esi
	ans->key = key;
801049ca:	89 4b 04             	mov    %ecx,0x4(%ebx)
	ans->next = null;
801049cd:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
	if(!freeLinks)
801049d4:	85 d2                	test   %edx,%edx
	freeNodes = freeNodes->next;
801049d6:	89 35 fc b5 10 80    	mov    %esi,0x8010b5fc
	if(!freeLinks)
801049dc:	74 3f                	je     80104a1d <_ZL9allocNodeP4procx+0x6d>
	freeLinks = freeLinks->next;
801049de:	8b 4a 04             	mov    0x4(%edx),%ecx
	ans->p = p;
801049e1:	89 02                	mov    %eax,(%edx)
	ans->next = null;
801049e3:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
	if(isEmpty()) first = link;
801049ea:	8b 43 08             	mov    0x8(%ebx),%eax
	freeLinks = freeLinks->next;
801049ed:	89 0d 00 b6 10 80    	mov    %ecx,0x8010b600
	if(isEmpty()) first = link;
801049f3:	85 c0                	test   %eax,%eax
801049f5:	74 21                	je     80104a18 <_ZL9allocNodeP4procx+0x68>
	else last->next = link;
801049f7:	8b 43 0c             	mov    0xc(%ebx),%eax
801049fa:	89 50 04             	mov    %edx,0x4(%eax)
801049fd:	eb 03                	jmp    80104a02 <_ZL9allocNodeP4procx+0x52>
801049ff:	90                   	nop
	while(ans->next)
80104a00:	89 ca                	mov    %ecx,%edx
80104a02:	8b 4a 04             	mov    0x4(%edx),%ecx
80104a05:	85 c9                	test   %ecx,%ecx
80104a07:	75 f7                	jne    80104a00 <_ZL9allocNodeP4procx+0x50>
	last = link->getLast();
80104a09:	89 53 0c             	mov    %edx,0xc(%ebx)
}
80104a0c:	89 d8                	mov    %ebx,%eax
80104a0e:	5b                   	pop    %ebx
80104a0f:	5e                   	pop    %esi
80104a10:	5d                   	pop    %ebp
80104a11:	c3                   	ret    
80104a12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	if(isEmpty()) first = link;
80104a18:	89 53 08             	mov    %edx,0x8(%ebx)
80104a1b:	eb e5                	jmp    80104a02 <_ZL9allocNodeP4procx+0x52>
	node->parent = node->left = node->right = null;
80104a1d:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
80104a24:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
80104a2b:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
	node->next = freeNodes;
80104a32:	89 73 10             	mov    %esi,0x10(%ebx)
	freeNodes = node;
80104a35:	89 1d fc b5 10 80    	mov    %ebx,0x8010b5fc
		return null;
80104a3b:	31 db                	xor    %ebx,%ebx
80104a3d:	eb cd                	jmp    80104a0c <_ZL9allocNodeP4procx+0x5c>
80104a3f:	90                   	nop

80104a40 <_ZL8mymallocj>:
static char* mymalloc(uint size) {
80104a40:	55                   	push   %ebp
80104a41:	89 e5                	mov    %esp,%ebp
80104a43:	53                   	push   %ebx
80104a44:	89 c3                	mov    %eax,%ebx
80104a46:	83 ec 14             	sub    $0x14,%esp
	if(spaceLeft < size) {
80104a49:	8b 15 f4 b5 10 80    	mov    0x8010b5f4,%edx
80104a4f:	39 c2                	cmp    %eax,%edx
80104a51:	73 26                	jae    80104a79 <_ZL8mymallocj+0x39>
		data = kalloc();
80104a53:	e8 58 db ff ff       	call   801025b0 <kalloc>
		memset(data, 0, PGSIZE);
80104a58:	ba 00 10 00 00       	mov    $0x1000,%edx
80104a5d:	31 c9                	xor    %ecx,%ecx
80104a5f:	89 54 24 08          	mov    %edx,0x8(%esp)
80104a63:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80104a67:	89 04 24             	mov    %eax,(%esp)
		data = kalloc();
80104a6a:	a3 f8 b5 10 80       	mov    %eax,0x8010b5f8
		memset(data, 0, PGSIZE);
80104a6f:	e8 fc 0d 00 00       	call   80105870 <memset>
80104a74:	ba 00 10 00 00       	mov    $0x1000,%edx
	char* ans = data;
80104a79:	a1 f8 b5 10 80       	mov    0x8010b5f8,%eax
	spaceLeft -= size;
80104a7e:	29 da                	sub    %ebx,%edx
80104a80:	89 15 f4 b5 10 80    	mov    %edx,0x8010b5f4
	data += size;
80104a86:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80104a89:	89 0d f8 b5 10 80    	mov    %ecx,0x8010b5f8
}
80104a8f:	83 c4 14             	add    $0x14,%esp
80104a92:	5b                   	pop    %ebx
80104a93:	5d                   	pop    %ebp
80104a94:	c3                   	ret    
80104a95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104aa0 <initSchedDS>:
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104aa0:	55                   	push   %ebp
	data               = null;
80104aa1:	31 c0                	xor    %eax,%eax
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104aa3:	89 e5                	mov    %esp,%ebp
80104aa5:	53                   	push   %ebx
	freeLinks = null;
80104aa6:	bb 80 00 00 00       	mov    $0x80,%ebx
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104aab:	83 ec 04             	sub    $0x4,%esp
	data               = null;
80104aae:	a3 f8 b5 10 80       	mov    %eax,0x8010b5f8
	spaceLeft          = 0u;
80104ab3:	31 c0                	xor    %eax,%eax
80104ab5:	a3 f4 b5 10 80       	mov    %eax,0x8010b5f4
	priorityQ          = (Map*)mymalloc(sizeof(Map));
80104aba:	b8 04 00 00 00       	mov    $0x4,%eax
80104abf:	e8 7c ff ff ff       	call   80104a40 <_ZL8mymallocj>
80104ac4:	a3 0c b6 10 80       	mov    %eax,0x8010b60c
	*priorityQ         = Map();
80104ac9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	roundRobinQ        = (LinkedList*)mymalloc(sizeof(LinkedList));
80104acf:	b8 08 00 00 00       	mov    $0x8,%eax
80104ad4:	e8 67 ff ff ff       	call   80104a40 <_ZL8mymallocj>
80104ad9:	a3 08 b6 10 80       	mov    %eax,0x8010b608
	*roundRobinQ       = LinkedList();
80104ade:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104ae4:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	runningProcHolder  = (LinkedList*)mymalloc(sizeof(LinkedList));
80104aeb:	b8 08 00 00 00       	mov    $0x8,%eax
80104af0:	e8 4b ff ff ff       	call   80104a40 <_ZL8mymallocj>
80104af5:	a3 04 b6 10 80       	mov    %eax,0x8010b604
	*runningProcHolder = LinkedList();
80104afa:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104b00:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = null;
80104b07:	31 c0                	xor    %eax,%eax
80104b09:	a3 00 b6 10 80       	mov    %eax,0x8010b600
80104b0e:	66 90                	xchg   %ax,%ax
		Link *link = (Link*)mymalloc(sizeof(Link));
80104b10:	b8 08 00 00 00       	mov    $0x8,%eax
80104b15:	e8 26 ff ff ff       	call   80104a40 <_ZL8mymallocj>
		link->next = freeLinks;
80104b1a:	8b 15 00 b6 10 80    	mov    0x8010b600,%edx
	for(int i = 0; i < NPROCLIST; ++i) {
80104b20:	4b                   	dec    %ebx
		*link = Link();
80104b21:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		link->next = freeLinks;
80104b27:	89 50 04             	mov    %edx,0x4(%eax)
		freeLinks = link;
80104b2a:	a3 00 b6 10 80       	mov    %eax,0x8010b600
	for(int i = 0; i < NPROCLIST; ++i) {
80104b2f:	75 df                	jne    80104b10 <initSchedDS+0x70>
	freeNodes = null;
80104b31:	31 c0                	xor    %eax,%eax
80104b33:	bb 80 00 00 00       	mov    $0x80,%ebx
80104b38:	a3 fc b5 10 80       	mov    %eax,0x8010b5fc
80104b3d:	8d 76 00             	lea    0x0(%esi),%esi
		MapNode *node = (MapNode*)mymalloc(sizeof(MapNode));
80104b40:	b8 20 00 00 00       	mov    $0x20,%eax
80104b45:	e8 f6 fe ff ff       	call   80104a40 <_ZL8mymallocj>
		node->next = freeNodes;
80104b4a:	8b 15 fc b5 10 80    	mov    0x8010b5fc,%edx
	for(int i = 0; i < NPROCMAP; ++i) {
80104b50:	4b                   	dec    %ebx
		*node = MapNode();
80104b51:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80104b58:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
80104b5f:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
80104b66:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
80104b6d:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
		node->next = freeNodes;
80104b74:	89 50 10             	mov    %edx,0x10(%eax)
		freeNodes = node;
80104b77:	a3 fc b5 10 80       	mov    %eax,0x8010b5fc
	for(int i = 0; i < NPROCMAP; ++i) {
80104b7c:	75 c2                	jne    80104b40 <initSchedDS+0xa0>
	pq.isEmpty                      = isEmptyPriorityQueue;
80104b7e:	b8 f0 47 10 80       	mov    $0x801047f0,%eax
	pq.put                          = putPriorityQueue;
80104b83:	ba 70 51 10 80       	mov    $0x80105170,%edx
	pq.isEmpty                      = isEmptyPriorityQueue;
80104b88:	a3 dc b5 10 80       	mov    %eax,0x8010b5dc
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
80104b8d:	b8 30 53 10 80       	mov    $0x80105330,%eax
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
80104b92:	b9 10 48 10 80       	mov    $0x80104810,%ecx
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
80104b97:	a3 ec b5 10 80       	mov    %eax,0x8010b5ec
	pq.extractProc                  = extractProcPriorityQueue;
80104b9c:	b8 10 54 10 80       	mov    $0x80105410,%eax
	pq.extractMin                   = extractMinPriorityQueue;
80104ba1:	bb 90 52 10 80       	mov    $0x80105290,%ebx
	pq.extractProc                  = extractProcPriorityQueue;
80104ba6:	a3 f0 b5 10 80       	mov    %eax,0x8010b5f0
	rrq.isEmpty                     = isEmptyRoundRobinQueue;
80104bab:	b8 60 48 10 80       	mov    $0x80104860,%eax
80104bb0:	a3 cc b5 10 80       	mov    %eax,0x8010b5cc
	rrq.enqueue                     = enqueueRoundRobinQueue;
80104bb5:	b8 80 48 10 80       	mov    $0x80104880,%eax
80104bba:	a3 d0 b5 10 80       	mov    %eax,0x8010b5d0
	rrq.dequeue                     = dequeueRoundRobinQueue;
80104bbf:	b8 e0 48 10 80       	mov    $0x801048e0,%eax
80104bc4:	a3 d4 b5 10 80       	mov    %eax,0x8010b5d4
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
80104bc9:	b8 a0 4e 10 80       	mov    $0x80104ea0,%eax
	pq.put                          = putPriorityQueue;
80104bce:	89 15 e0 b5 10 80    	mov    %edx,0x8010b5e0
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
80104bd4:	ba 30 49 10 80       	mov    $0x80104930,%edx
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
80104bd9:	89 0d e4 b5 10 80    	mov    %ecx,0x8010b5e4
	rpholder.add                    = addRunningProcessHolder;
80104bdf:	b9 50 49 10 80       	mov    $0x80104950,%ecx
	pq.extractMin                   = extractMinPriorityQueue;
80104be4:	89 1d e8 b5 10 80    	mov    %ebx,0x8010b5e8
	rpholder.remove                 = removeRunningProcessHolder;
80104bea:	bb 00 4e 10 80       	mov    $0x80104e00,%ebx
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
80104bef:	a3 d8 b5 10 80       	mov    %eax,0x8010b5d8
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
80104bf4:	b8 30 4f 10 80       	mov    $0x80104f30,%eax
	rpholder.remove                 = removeRunningProcessHolder;
80104bf9:	89 1d c4 b5 10 80    	mov    %ebx,0x8010b5c4
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
80104bff:	89 15 bc b5 10 80    	mov    %edx,0x8010b5bc
	rpholder.add                    = addRunningProcessHolder;
80104c05:	89 0d c0 b5 10 80    	mov    %ecx,0x8010b5c0
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
80104c0b:	a3 c8 b5 10 80       	mov    %eax,0x8010b5c8
}
80104c10:	58                   	pop    %eax
80104c11:	5b                   	pop    %ebx
80104c12:	5d                   	pop    %ebp
80104c13:	c3                   	ret    
80104c14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104c20 <_ZN4Link7getLastEv>:
Link* Link::getLast() {
80104c20:	55                   	push   %ebp
80104c21:	89 e5                	mov    %esp,%ebp
80104c23:	8b 45 08             	mov    0x8(%ebp),%eax
80104c26:	eb 0a                	jmp    80104c32 <_ZN4Link7getLastEv+0x12>
80104c28:	90                   	nop
80104c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c30:	89 d0                	mov    %edx,%eax
	while(ans->next)
80104c32:	8b 50 04             	mov    0x4(%eax),%edx
80104c35:	85 d2                	test   %edx,%edx
80104c37:	75 f7                	jne    80104c30 <_ZN4Link7getLastEv+0x10>
}
80104c39:	5d                   	pop    %ebp
80104c3a:	c3                   	ret    
80104c3b:	90                   	nop
80104c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c40 <_ZN10LinkedList7isEmptyEv>:
bool LinkedList::isEmpty() {
80104c40:	55                   	push   %ebp
80104c41:	89 e5                	mov    %esp,%ebp
	return !first;
80104c43:	8b 45 08             	mov    0x8(%ebp),%eax
}
80104c46:	5d                   	pop    %ebp
	return !first;
80104c47:	8b 00                	mov    (%eax),%eax
80104c49:	85 c0                	test   %eax,%eax
80104c4b:	0f 94 c0             	sete   %al
}
80104c4e:	c3                   	ret    
80104c4f:	90                   	nop

80104c50 <_ZN10LinkedList6appendEP4Link>:
void LinkedList::append(Link *link) {
80104c50:	55                   	push   %ebp
80104c51:	89 e5                	mov    %esp,%ebp
80104c53:	8b 55 0c             	mov    0xc(%ebp),%edx
80104c56:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!link)
80104c59:	85 d2                	test   %edx,%edx
80104c5b:	74 1f                	je     80104c7c <_ZN10LinkedList6appendEP4Link+0x2c>
	if(isEmpty()) first = link;
80104c5d:	8b 01                	mov    (%ecx),%eax
80104c5f:	85 c0                	test   %eax,%eax
80104c61:	74 1d                	je     80104c80 <_ZN10LinkedList6appendEP4Link+0x30>
	else last->next = link;
80104c63:	8b 41 04             	mov    0x4(%ecx),%eax
80104c66:	89 50 04             	mov    %edx,0x4(%eax)
80104c69:	eb 07                	jmp    80104c72 <_ZN10LinkedList6appendEP4Link+0x22>
80104c6b:	90                   	nop
80104c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	while(ans->next)
80104c70:	89 c2                	mov    %eax,%edx
80104c72:	8b 42 04             	mov    0x4(%edx),%eax
80104c75:	85 c0                	test   %eax,%eax
80104c77:	75 f7                	jne    80104c70 <_ZN10LinkedList6appendEP4Link+0x20>
	last = link->getLast();
80104c79:	89 51 04             	mov    %edx,0x4(%ecx)
}
80104c7c:	5d                   	pop    %ebp
80104c7d:	c3                   	ret    
80104c7e:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
80104c80:	89 11                	mov    %edx,(%ecx)
80104c82:	eb ee                	jmp    80104c72 <_ZN10LinkedList6appendEP4Link+0x22>
80104c84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104c90 <_ZN10LinkedList7enqueueEP4proc>:
	if(!freeLinks)
80104c90:	a1 00 b6 10 80       	mov    0x8010b600,%eax
bool LinkedList::enqueue(Proc *p) {
80104c95:	55                   	push   %ebp
80104c96:	89 e5                	mov    %esp,%ebp
80104c98:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!freeLinks)
80104c9b:	85 c0                	test   %eax,%eax
80104c9d:	74 41                	je     80104ce0 <_ZN10LinkedList7enqueueEP4proc+0x50>
	freeLinks = freeLinks->next;
80104c9f:	8b 50 04             	mov    0x4(%eax),%edx
	ans->next = null;
80104ca2:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
80104ca9:	89 15 00 b6 10 80    	mov    %edx,0x8010b600
	ans->p = p;
80104caf:	8b 55 0c             	mov    0xc(%ebp),%edx
80104cb2:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80104cb4:	8b 11                	mov    (%ecx),%edx
80104cb6:	85 d2                	test   %edx,%edx
80104cb8:	74 2e                	je     80104ce8 <_ZN10LinkedList7enqueueEP4proc+0x58>
	else last->next = link;
80104cba:	8b 51 04             	mov    0x4(%ecx),%edx
80104cbd:	89 42 04             	mov    %eax,0x4(%edx)
80104cc0:	eb 08                	jmp    80104cca <_ZN10LinkedList7enqueueEP4proc+0x3a>
80104cc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	while(ans->next)
80104cc8:	89 d0                	mov    %edx,%eax
80104cca:	8b 50 04             	mov    0x4(%eax),%edx
80104ccd:	85 d2                	test   %edx,%edx
80104ccf:	75 f7                	jne    80104cc8 <_ZN10LinkedList7enqueueEP4proc+0x38>
	last = link->getLast();
80104cd1:	89 41 04             	mov    %eax,0x4(%ecx)
	return true;
80104cd4:	b0 01                	mov    $0x1,%al
}
80104cd6:	5d                   	pop    %ebp
80104cd7:	c3                   	ret    
80104cd8:	90                   	nop
80104cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return false;
80104ce0:	31 c0                	xor    %eax,%eax
}
80104ce2:	5d                   	pop    %ebp
80104ce3:	c3                   	ret    
80104ce4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
80104ce8:	89 01                	mov    %eax,(%ecx)
80104cea:	eb de                	jmp    80104cca <_ZN10LinkedList7enqueueEP4proc+0x3a>
80104cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104cf0 <_ZN10LinkedList7dequeueEv>:
Proc* LinkedList::dequeue() {
80104cf0:	55                   	push   %ebp
80104cf1:	89 e5                	mov    %esp,%ebp
80104cf3:	83 ec 08             	sub    $0x8,%esp
80104cf6:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104cf9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104cfc:	89 75 fc             	mov    %esi,-0x4(%ebp)
	return !first;
80104cff:	8b 11                	mov    (%ecx),%edx
	if(isEmpty())
80104d01:	85 d2                	test   %edx,%edx
80104d03:	74 2b                	je     80104d30 <_ZN10LinkedList7dequeueEv+0x40>
	Link *next = first->next;
80104d05:	8b 5a 04             	mov    0x4(%edx),%ebx
	link->next = freeLinks;
80104d08:	8b 35 00 b6 10 80    	mov    0x8010b600,%esi
	Proc *p = first->p;
80104d0e:	8b 02                	mov    (%edx),%eax
	freeLinks = link;
80104d10:	89 15 00 b6 10 80    	mov    %edx,0x8010b600
	if(isEmpty())
80104d16:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
80104d18:	89 72 04             	mov    %esi,0x4(%edx)
	first = next;
80104d1b:	89 19                	mov    %ebx,(%ecx)
	if(isEmpty())
80104d1d:	75 07                	jne    80104d26 <_ZN10LinkedList7dequeueEv+0x36>
		last = null;
80104d1f:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
}
80104d26:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104d29:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104d2c:	89 ec                	mov    %ebp,%esp
80104d2e:	5d                   	pop    %ebp
80104d2f:	c3                   	ret    
		return null;
80104d30:	31 c0                	xor    %eax,%eax
80104d32:	eb f2                	jmp    80104d26 <_ZN10LinkedList7dequeueEv+0x36>
80104d34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104d40 <_ZN10LinkedList6removeEP4proc>:
bool LinkedList::remove(Proc *p) {
80104d40:	55                   	push   %ebp
80104d41:	89 e5                	mov    %esp,%ebp
80104d43:	56                   	push   %esi
80104d44:	8b 75 08             	mov    0x8(%ebp),%esi
80104d47:	53                   	push   %ebx
80104d48:	8b 4d 0c             	mov    0xc(%ebp),%ecx
	return !first;
80104d4b:	8b 1e                	mov    (%esi),%ebx
	if(isEmpty())
80104d4d:	85 db                	test   %ebx,%ebx
80104d4f:	74 2f                	je     80104d80 <_ZN10LinkedList6removeEP4proc+0x40>
	if(first->p == p) {
80104d51:	39 0b                	cmp    %ecx,(%ebx)
80104d53:	8b 53 04             	mov    0x4(%ebx),%edx
80104d56:	74 70                	je     80104dc8 <_ZN10LinkedList6removeEP4proc+0x88>
	while(cur) {
80104d58:	85 d2                	test   %edx,%edx
80104d5a:	74 24                	je     80104d80 <_ZN10LinkedList6removeEP4proc+0x40>
		if(cur->p == p) {
80104d5c:	3b 0a                	cmp    (%edx),%ecx
80104d5e:	66 90                	xchg   %ax,%ax
80104d60:	75 0c                	jne    80104d6e <_ZN10LinkedList6removeEP4proc+0x2e>
80104d62:	eb 2c                	jmp    80104d90 <_ZN10LinkedList6removeEP4proc+0x50>
80104d64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d68:	39 08                	cmp    %ecx,(%eax)
80104d6a:	74 34                	je     80104da0 <_ZN10LinkedList6removeEP4proc+0x60>
80104d6c:	89 c2                	mov    %eax,%edx
		cur = cur->next;
80104d6e:	8b 42 04             	mov    0x4(%edx),%eax
	while(cur) {
80104d71:	85 c0                	test   %eax,%eax
80104d73:	75 f3                	jne    80104d68 <_ZN10LinkedList6removeEP4proc+0x28>
}
80104d75:	5b                   	pop    %ebx
80104d76:	5e                   	pop    %esi
80104d77:	5d                   	pop    %ebp
80104d78:	c3                   	ret    
80104d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d80:	5b                   	pop    %ebx
		return false;
80104d81:	31 c0                	xor    %eax,%eax
}
80104d83:	5e                   	pop    %esi
80104d84:	5d                   	pop    %ebp
80104d85:	c3                   	ret    
80104d86:	8d 76 00             	lea    0x0(%esi),%esi
80104d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		if(cur->p == p) {
80104d90:	89 d0                	mov    %edx,%eax
80104d92:	89 da                	mov    %ebx,%edx
80104d94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
			prev->next = cur->next;
80104da0:	8b 48 04             	mov    0x4(%eax),%ecx
80104da3:	89 4a 04             	mov    %ecx,0x4(%edx)
			if(!(cur->next)) //removes the last link
80104da6:	8b 48 04             	mov    0x4(%eax),%ecx
80104da9:	85 c9                	test   %ecx,%ecx
80104dab:	74 43                	je     80104df0 <_ZN10LinkedList6removeEP4proc+0xb0>
	link->next = freeLinks;
80104dad:	8b 15 00 b6 10 80    	mov    0x8010b600,%edx
	freeLinks = link;
80104db3:	a3 00 b6 10 80       	mov    %eax,0x8010b600
	link->next = freeLinks;
80104db8:	89 50 04             	mov    %edx,0x4(%eax)
			return true;
80104dbb:	b0 01                	mov    $0x1,%al
}
80104dbd:	5b                   	pop    %ebx
80104dbe:	5e                   	pop    %esi
80104dbf:	5d                   	pop    %ebp
80104dc0:	c3                   	ret    
80104dc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	link->next = freeLinks;
80104dc8:	a1 00 b6 10 80       	mov    0x8010b600,%eax
	if(isEmpty())
80104dcd:	85 d2                	test   %edx,%edx
	freeLinks = link;
80104dcf:	89 1d 00 b6 10 80    	mov    %ebx,0x8010b600
	link->next = freeLinks;
80104dd5:	89 43 04             	mov    %eax,0x4(%ebx)
		return true;
80104dd8:	b0 01                	mov    $0x1,%al
	first = next;
80104dda:	89 16                	mov    %edx,(%esi)
	if(isEmpty())
80104ddc:	75 97                	jne    80104d75 <_ZN10LinkedList6removeEP4proc+0x35>
		last = null;
80104dde:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%esi)
80104de5:	eb 8e                	jmp    80104d75 <_ZN10LinkedList6removeEP4proc+0x35>
80104de7:	89 f6                	mov    %esi,%esi
80104de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
				last = prev;
80104df0:	89 56 04             	mov    %edx,0x4(%esi)
80104df3:	eb b8                	jmp    80104dad <_ZN10LinkedList6removeEP4proc+0x6d>
80104df5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e00 <removeRunningProcessHolder>:
static boolean removeRunningProcessHolder(Proc* p) {
80104e00:	55                   	push   %ebp
80104e01:	89 e5                	mov    %esp,%ebp
80104e03:	83 ec 08             	sub    $0x8,%esp
	return runningProcHolder->remove(p);
80104e06:	8b 45 08             	mov    0x8(%ebp),%eax
80104e09:	89 44 24 04          	mov    %eax,0x4(%esp)
80104e0d:	a1 04 b6 10 80       	mov    0x8010b604,%eax
80104e12:	89 04 24             	mov    %eax,(%esp)
80104e15:	e8 26 ff ff ff       	call   80104d40 <_ZN10LinkedList6removeEP4proc>
}
80104e1a:	c9                   	leave  
	return runningProcHolder->remove(p);
80104e1b:	0f b6 c0             	movzbl %al,%eax
}
80104e1e:	c3                   	ret    
80104e1f:	90                   	nop

80104e20 <_ZN10LinkedList8transferEv>:
	if(!priorityQ->isEmpty())
80104e20:	8b 15 0c b6 10 80    	mov    0x8010b60c,%edx
		return false;
80104e26:	31 c0                	xor    %eax,%eax
bool LinkedList::transfer() {
80104e28:	55                   	push   %ebp
80104e29:	89 e5                	mov    %esp,%ebp
80104e2b:	53                   	push   %ebx
80104e2c:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!priorityQ->isEmpty())
80104e2f:	8b 1a                	mov    (%edx),%ebx
80104e31:	85 db                	test   %ebx,%ebx
80104e33:	74 0b                	je     80104e40 <_ZN10LinkedList8transferEv+0x20>
}
80104e35:	5b                   	pop    %ebx
80104e36:	5d                   	pop    %ebp
80104e37:	c3                   	ret    
80104e38:	90                   	nop
80104e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	if(!isEmpty()) {
80104e40:	8b 19                	mov    (%ecx),%ebx
80104e42:	85 db                	test   %ebx,%ebx
80104e44:	74 4a                	je     80104e90 <_ZN10LinkedList8transferEv+0x70>
	if(!freeNodes)
80104e46:	8b 1d fc b5 10 80    	mov    0x8010b5fc,%ebx
80104e4c:	85 db                	test   %ebx,%ebx
80104e4e:	74 e5                	je     80104e35 <_ZN10LinkedList8transferEv+0x15>
	freeNodes = freeNodes->next;
80104e50:	8b 43 10             	mov    0x10(%ebx),%eax
	ans->key = key;
80104e53:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
	ans->next = null;
80104e59:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
	ans->key = key;
80104e60:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
	freeNodes = freeNodes->next;
80104e67:	a3 fc b5 10 80       	mov    %eax,0x8010b5fc
		node->listOfProcs.first = first;
80104e6c:	8b 01                	mov    (%ecx),%eax
80104e6e:	89 43 08             	mov    %eax,0x8(%ebx)
		node->listOfProcs.last = last;
80104e71:	8b 41 04             	mov    0x4(%ecx),%eax
80104e74:	89 43 0c             	mov    %eax,0xc(%ebx)
	return true;
80104e77:	b0 01                	mov    $0x1,%al
		first = last = null;
80104e79:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
80104e80:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
		priorityQ->root = node;
80104e86:	89 1a                	mov    %ebx,(%edx)
}
80104e88:	5b                   	pop    %ebx
80104e89:	5d                   	pop    %ebp
80104e8a:	c3                   	ret    
80104e8b:	90                   	nop
80104e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	return true;
80104e90:	b0 01                	mov    $0x1,%al
80104e92:	eb a1                	jmp    80104e35 <_ZN10LinkedList8transferEv+0x15>
80104e94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104ea0 <switchToPriorityQueuePolicyRoundRobinQueue>:
static boolean switchToPriorityQueuePolicyRoundRobinQueue() {
80104ea0:	55                   	push   %ebp
80104ea1:	89 e5                	mov    %esp,%ebp
80104ea3:	83 ec 04             	sub    $0x4,%esp
	return roundRobinQ->transfer();
80104ea6:	a1 08 b6 10 80       	mov    0x8010b608,%eax
80104eab:	89 04 24             	mov    %eax,(%esp)
80104eae:	e8 6d ff ff ff       	call   80104e20 <_ZN10LinkedList8transferEv>
}
80104eb3:	c9                   	leave  
	return roundRobinQ->transfer();
80104eb4:	0f b6 c0             	movzbl %al,%eax
}
80104eb7:	c3                   	ret    
80104eb8:	90                   	nop
80104eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104ec0 <_ZN10LinkedList9getMinKeyEPx>:
bool LinkedList::getMinKey(long long *pkey) {
80104ec0:	55                   	push   %ebp
80104ec1:	31 c0                	xor    %eax,%eax
80104ec3:	89 e5                	mov    %esp,%ebp
80104ec5:	57                   	push   %edi
80104ec6:	56                   	push   %esi
80104ec7:	53                   	push   %ebx
80104ec8:	83 ec 1c             	sub    $0x1c,%esp
80104ecb:	8b 7d 08             	mov    0x8(%ebp),%edi
	return !first;
80104ece:	8b 17                	mov    (%edi),%edx
	if(isEmpty())
80104ed0:	85 d2                	test   %edx,%edx
80104ed2:	74 41                	je     80104f15 <_ZN10LinkedList9getMinKeyEPx+0x55>
	long long minKey = getAccumulator(first->p);
80104ed4:	8b 02                	mov    (%edx),%eax
80104ed6:	89 04 24             	mov    %eax,(%esp)
80104ed9:	e8 c2 e9 ff ff       	call   801038a0 <getAccumulator>
	forEach([&](Proc *p) {
80104ede:	8b 3f                	mov    (%edi),%edi
	void append(Link *link); //appends the given list to the queue. No allocations always succeeds.
	
	template<typename Func>
	void forEach(const Func& accept) { //for-each loop. gets a function that applies the procin each link node.
		Link *link = first;
		while(link) {
80104ee0:	85 ff                	test   %edi,%edi
	long long minKey = getAccumulator(first->p);
80104ee2:	89 c6                	mov    %eax,%esi
80104ee4:	89 d3                	mov    %edx,%ebx
80104ee6:	74 23                	je     80104f0b <_ZN10LinkedList9getMinKeyEPx+0x4b>
80104ee8:	90                   	nop
80104ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		long long key = getAccumulator(p);
80104ef0:	8b 07                	mov    (%edi),%eax
80104ef2:	89 04 24             	mov    %eax,(%esp)
80104ef5:	e8 a6 e9 ff ff       	call   801038a0 <getAccumulator>
80104efa:	39 d3                	cmp    %edx,%ebx
80104efc:	7c 06                	jl     80104f04 <_ZN10LinkedList9getMinKeyEPx+0x44>
80104efe:	7f 20                	jg     80104f20 <_ZN10LinkedList9getMinKeyEPx+0x60>
80104f00:	39 c6                	cmp    %eax,%esi
80104f02:	77 1c                	ja     80104f20 <_ZN10LinkedList9getMinKeyEPx+0x60>
			accept(link->p);
			link = link->next;
80104f04:	8b 7f 04             	mov    0x4(%edi),%edi
		while(link) {
80104f07:	85 ff                	test   %edi,%edi
80104f09:	75 e5                	jne    80104ef0 <_ZN10LinkedList9getMinKeyEPx+0x30>
	*pkey = minKey;
80104f0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f0e:	89 30                	mov    %esi,(%eax)
80104f10:	89 58 04             	mov    %ebx,0x4(%eax)
	return true;
80104f13:	b0 01                	mov    $0x1,%al
}
80104f15:	83 c4 1c             	add    $0x1c,%esp
80104f18:	5b                   	pop    %ebx
80104f19:	5e                   	pop    %esi
80104f1a:	5f                   	pop    %edi
80104f1b:	5d                   	pop    %ebp
80104f1c:	c3                   	ret    
80104f1d:	8d 76 00             	lea    0x0(%esi),%esi
			link = link->next;
80104f20:	8b 7f 04             	mov    0x4(%edi),%edi
80104f23:	89 c6                	mov    %eax,%esi
80104f25:	89 d3                	mov    %edx,%ebx
		while(link) {
80104f27:	85 ff                	test   %edi,%edi
80104f29:	75 c5                	jne    80104ef0 <_ZN10LinkedList9getMinKeyEPx+0x30>
80104f2b:	eb de                	jmp    80104f0b <_ZN10LinkedList9getMinKeyEPx+0x4b>
80104f2d:	8d 76 00             	lea    0x0(%esi),%esi

80104f30 <getMinAccumulatorRunningProcessHolder>:
static boolean getMinAccumulatorRunningProcessHolder(long long *pkey) {
80104f30:	55                   	push   %ebp
80104f31:	89 e5                	mov    %esp,%ebp
80104f33:	83 ec 18             	sub    $0x18,%esp
	return runningProcHolder->getMinKey(pkey);
80104f36:	8b 45 08             	mov    0x8(%ebp),%eax
80104f39:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f3d:	a1 04 b6 10 80       	mov    0x8010b604,%eax
80104f42:	89 04 24             	mov    %eax,(%esp)
80104f45:	e8 76 ff ff ff       	call   80104ec0 <_ZN10LinkedList9getMinKeyEPx>
}
80104f4a:	c9                   	leave  
	return runningProcHolder->getMinKey(pkey);
80104f4b:	0f b6 c0             	movzbl %al,%eax
}
80104f4e:	c3                   	ret    
80104f4f:	90                   	nop

80104f50 <_ZN7MapNode7isEmptyEv>:
bool MapNode::isEmpty() {
80104f50:	55                   	push   %ebp
80104f51:	89 e5                	mov    %esp,%ebp
	return !first;
80104f53:	8b 45 08             	mov    0x8(%ebp),%eax
}
80104f56:	5d                   	pop    %ebp
	return !first;
80104f57:	8b 40 08             	mov    0x8(%eax),%eax
80104f5a:	85 c0                	test   %eax,%eax
80104f5c:	0f 94 c0             	sete   %al
}
80104f5f:	c3                   	ret    

80104f60 <_ZN7MapNode3putEP4proc>:
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
80104f60:	55                   	push   %ebp
80104f61:	89 e5                	mov    %esp,%ebp
80104f63:	57                   	push   %edi
80104f64:	56                   	push   %esi
80104f65:	53                   	push   %ebx
80104f66:	83 ec 2c             	sub    $0x2c,%esp
	long long key = getAccumulator(p);
80104f69:	8b 45 0c             	mov    0xc(%ebp),%eax
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
80104f6c:	8b 5d 08             	mov    0x8(%ebp),%ebx
	long long key = getAccumulator(p);
80104f6f:	89 04 24             	mov    %eax,(%esp)
80104f72:	e8 29 e9 ff ff       	call   801038a0 <getAccumulator>
80104f77:	89 d1                	mov    %edx,%ecx
80104f79:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		if(key == node->key)
80104f80:	8b 13                	mov    (%ebx),%edx
80104f82:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80104f85:	8b 43 04             	mov    0x4(%ebx),%eax
80104f88:	31 d7                	xor    %edx,%edi
80104f8a:	89 fe                	mov    %edi,%esi
80104f8c:	89 c7                	mov    %eax,%edi
80104f8e:	31 cf                	xor    %ecx,%edi
80104f90:	09 fe                	or     %edi,%esi
80104f92:	74 4c                	je     80104fe0 <_ZN7MapNode3putEP4proc+0x80>
		else if(key < node->key) { //left
80104f94:	39 c8                	cmp    %ecx,%eax
80104f96:	7c 20                	jl     80104fb8 <_ZN7MapNode3putEP4proc+0x58>
80104f98:	7f 08                	jg     80104fa2 <_ZN7MapNode3putEP4proc+0x42>
80104f9a:	3b 55 e4             	cmp    -0x1c(%ebp),%edx
80104f9d:	8d 76 00             	lea    0x0(%esi),%esi
80104fa0:	76 16                	jbe    80104fb8 <_ZN7MapNode3putEP4proc+0x58>
			if(node->left)
80104fa2:	8b 43 18             	mov    0x18(%ebx),%eax
80104fa5:	85 c0                	test   %eax,%eax
80104fa7:	0f 84 83 00 00 00    	je     80105030 <_ZN7MapNode3putEP4proc+0xd0>
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
80104fad:	89 c3                	mov    %eax,%ebx
80104faf:	eb cf                	jmp    80104f80 <_ZN7MapNode3putEP4proc+0x20>
80104fb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			if(node->right)
80104fb8:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104fbb:	85 c0                	test   %eax,%eax
80104fbd:	75 ee                	jne    80104fad <_ZN7MapNode3putEP4proc+0x4d>
80104fbf:	8b 75 e4             	mov    -0x1c(%ebp),%esi
				node->right = allocNode(p, key);
80104fc2:	8b 45 0c             	mov    0xc(%ebp),%eax
80104fc5:	89 f2                	mov    %esi,%edx
80104fc7:	e8 e4 f9 ff ff       	call   801049b0 <_ZL9allocNodeP4procx>
				if(node->right) {
80104fcc:	85 c0                	test   %eax,%eax
				node->right = allocNode(p, key);
80104fce:	89 43 1c             	mov    %eax,0x1c(%ebx)
				if(node->right) {
80104fd1:	74 71                	je     80105044 <_ZN7MapNode3putEP4proc+0xe4>
					node->right->parent = node;
80104fd3:	89 58 14             	mov    %ebx,0x14(%eax)
}
80104fd6:	83 c4 2c             	add    $0x2c,%esp
					return true;
80104fd9:	b0 01                	mov    $0x1,%al
}
80104fdb:	5b                   	pop    %ebx
80104fdc:	5e                   	pop    %esi
80104fdd:	5f                   	pop    %edi
80104fde:	5d                   	pop    %ebp
80104fdf:	c3                   	ret    
	if(!freeLinks)
80104fe0:	a1 00 b6 10 80       	mov    0x8010b600,%eax
80104fe5:	85 c0                	test   %eax,%eax
80104fe7:	74 5b                	je     80105044 <_ZN7MapNode3putEP4proc+0xe4>
	ans->p = p;
80104fe9:	8b 75 0c             	mov    0xc(%ebp),%esi
	freeLinks = freeLinks->next;
80104fec:	8b 50 04             	mov    0x4(%eax),%edx
	ans->next = null;
80104fef:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	ans->p = p;
80104ff6:	89 30                	mov    %esi,(%eax)
	freeLinks = freeLinks->next;
80104ff8:	89 15 00 b6 10 80    	mov    %edx,0x8010b600
	if(isEmpty()) first = link;
80104ffe:	8b 53 08             	mov    0x8(%ebx),%edx
80105001:	85 d2                	test   %edx,%edx
80105003:	74 4b                	je     80105050 <_ZN7MapNode3putEP4proc+0xf0>
	else last->next = link;
80105005:	8b 53 0c             	mov    0xc(%ebx),%edx
80105008:	89 42 04             	mov    %eax,0x4(%edx)
8010500b:	eb 05                	jmp    80105012 <_ZN7MapNode3putEP4proc+0xb2>
8010500d:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
80105010:	89 d0                	mov    %edx,%eax
80105012:	8b 50 04             	mov    0x4(%eax),%edx
80105015:	85 d2                	test   %edx,%edx
80105017:	75 f7                	jne    80105010 <_ZN7MapNode3putEP4proc+0xb0>
	last = link->getLast();
80105019:	89 43 0c             	mov    %eax,0xc(%ebx)
}
8010501c:	83 c4 2c             	add    $0x2c,%esp
	return true;
8010501f:	b0 01                	mov    $0x1,%al
}
80105021:	5b                   	pop    %ebx
80105022:	5e                   	pop    %esi
80105023:	5f                   	pop    %edi
80105024:	5d                   	pop    %ebp
80105025:	c3                   	ret    
80105026:	8d 76 00             	lea    0x0(%esi),%esi
80105029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105030:	8b 75 e4             	mov    -0x1c(%ebp),%esi
				node->left = allocNode(p, key);
80105033:	8b 45 0c             	mov    0xc(%ebp),%eax
80105036:	89 f2                	mov    %esi,%edx
80105038:	e8 73 f9 ff ff       	call   801049b0 <_ZL9allocNodeP4procx>
				if(node->left) {
8010503d:	85 c0                	test   %eax,%eax
				node->left = allocNode(p, key);
8010503f:	89 43 18             	mov    %eax,0x18(%ebx)
				if(node->left) {
80105042:	75 8f                	jne    80104fd3 <_ZN7MapNode3putEP4proc+0x73>
}
80105044:	83 c4 2c             	add    $0x2c,%esp
		return false;
80105047:	31 c0                	xor    %eax,%eax
}
80105049:	5b                   	pop    %ebx
8010504a:	5e                   	pop    %esi
8010504b:	5f                   	pop    %edi
8010504c:	5d                   	pop    %ebp
8010504d:	c3                   	ret    
8010504e:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
80105050:	89 43 08             	mov    %eax,0x8(%ebx)
80105053:	eb bd                	jmp    80105012 <_ZN7MapNode3putEP4proc+0xb2>
80105055:	90                   	nop
80105056:	8d 76 00             	lea    0x0(%esi),%esi
80105059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105060 <_ZN7MapNode10getMinNodeEv>:
MapNode* MapNode::getMinNode() { //no recursion.
80105060:	55                   	push   %ebp
80105061:	89 e5                	mov    %esp,%ebp
80105063:	8b 45 08             	mov    0x8(%ebp),%eax
80105066:	eb 0a                	jmp    80105072 <_ZN7MapNode10getMinNodeEv+0x12>
80105068:	90                   	nop
80105069:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105070:	89 d0                	mov    %edx,%eax
	while(minNode->left)
80105072:	8b 50 18             	mov    0x18(%eax),%edx
80105075:	85 d2                	test   %edx,%edx
80105077:	75 f7                	jne    80105070 <_ZN7MapNode10getMinNodeEv+0x10>
}
80105079:	5d                   	pop    %ebp
8010507a:	c3                   	ret    
8010507b:	90                   	nop
8010507c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105080 <_ZN7MapNode9getMinKeyEPx>:
void MapNode::getMinKey(long long *pkey) {
80105080:	55                   	push   %ebp
80105081:	89 e5                	mov    %esp,%ebp
80105083:	8b 55 08             	mov    0x8(%ebp),%edx
80105086:	53                   	push   %ebx
80105087:	eb 09                	jmp    80105092 <_ZN7MapNode9getMinKeyEPx+0x12>
80105089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	while(minNode->left)
80105090:	89 c2                	mov    %eax,%edx
80105092:	8b 42 18             	mov    0x18(%edx),%eax
80105095:	85 c0                	test   %eax,%eax
80105097:	75 f7                	jne    80105090 <_ZN7MapNode9getMinKeyEPx+0x10>
	*pkey = getMinNode()->key;
80105099:	8b 5a 04             	mov    0x4(%edx),%ebx
8010509c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010509f:	8b 0a                	mov    (%edx),%ecx
801050a1:	89 58 04             	mov    %ebx,0x4(%eax)
801050a4:	89 08                	mov    %ecx,(%eax)
}
801050a6:	5b                   	pop    %ebx
801050a7:	5d                   	pop    %ebp
801050a8:	c3                   	ret    
801050a9:	90                   	nop
801050aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801050b0 <_ZN7MapNode7dequeueEv>:
Proc* MapNode::dequeue() {
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	83 ec 08             	sub    $0x8,%esp
801050b6:	8b 4d 08             	mov    0x8(%ebp),%ecx
801050b9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801050bc:	89 75 fc             	mov    %esi,-0x4(%ebp)
	return !first;
801050bf:	8b 51 08             	mov    0x8(%ecx),%edx
	if(isEmpty())
801050c2:	85 d2                	test   %edx,%edx
801050c4:	74 32                	je     801050f8 <_ZN7MapNode7dequeueEv+0x48>
	Link *next = first->next;
801050c6:	8b 5a 04             	mov    0x4(%edx),%ebx
	link->next = freeLinks;
801050c9:	8b 35 00 b6 10 80    	mov    0x8010b600,%esi
	Proc *p = first->p;
801050cf:	8b 02                	mov    (%edx),%eax
	freeLinks = link;
801050d1:	89 15 00 b6 10 80    	mov    %edx,0x8010b600
	if(isEmpty())
801050d7:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
801050d9:	89 72 04             	mov    %esi,0x4(%edx)
	first = next;
801050dc:	89 59 08             	mov    %ebx,0x8(%ecx)
	if(isEmpty())
801050df:	75 07                	jne    801050e8 <_ZN7MapNode7dequeueEv+0x38>
		last = null;
801050e1:	c7 41 0c 00 00 00 00 	movl   $0x0,0xc(%ecx)
}
801050e8:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801050eb:	8b 75 fc             	mov    -0x4(%ebp),%esi
801050ee:	89 ec                	mov    %ebp,%esp
801050f0:	5d                   	pop    %ebp
801050f1:	c3                   	ret    
801050f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		return null;
801050f8:	31 c0                	xor    %eax,%eax
	return listOfProcs.dequeue();
801050fa:	eb ec                	jmp    801050e8 <_ZN7MapNode7dequeueEv+0x38>
801050fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105100 <_ZN3Map7isEmptyEv>:
bool Map::isEmpty() {
80105100:	55                   	push   %ebp
80105101:	89 e5                	mov    %esp,%ebp
	return !root;
80105103:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105106:	5d                   	pop    %ebp
	return !root;
80105107:	8b 00                	mov    (%eax),%eax
80105109:	85 c0                	test   %eax,%eax
8010510b:	0f 94 c0             	sete   %al
}
8010510e:	c3                   	ret    
8010510f:	90                   	nop

80105110 <_ZN3Map3putEP4proc>:
bool Map::put(Proc *p) {
80105110:	55                   	push   %ebp
80105111:	89 e5                	mov    %esp,%ebp
80105113:	83 ec 18             	sub    $0x18,%esp
80105116:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105119:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010511c:	89 75 fc             	mov    %esi,-0x4(%ebp)
8010511f:	8b 75 08             	mov    0x8(%ebp),%esi
	long long key = getAccumulator(p);
80105122:	89 1c 24             	mov    %ebx,(%esp)
80105125:	e8 76 e7 ff ff       	call   801038a0 <getAccumulator>
	return !root;
8010512a:	8b 0e                	mov    (%esi),%ecx
	if(isEmpty()) {
8010512c:	85 c9                	test   %ecx,%ecx
8010512e:	74 18                	je     80105148 <_ZN3Map3putEP4proc+0x38>
	return root->put(p);
80105130:	89 5d 0c             	mov    %ebx,0xc(%ebp)
}
80105133:	8b 75 fc             	mov    -0x4(%ebp),%esi
	return root->put(p);
80105136:	89 4d 08             	mov    %ecx,0x8(%ebp)
}
80105139:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010513c:	89 ec                	mov    %ebp,%esp
8010513e:	5d                   	pop    %ebp
	return root->put(p);
8010513f:	e9 1c fe ff ff       	jmp    80104f60 <_ZN7MapNode3putEP4proc>
80105144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		root = allocNode(p, key);
80105148:	89 d1                	mov    %edx,%ecx
8010514a:	89 c2                	mov    %eax,%edx
8010514c:	89 d8                	mov    %ebx,%eax
8010514e:	e8 5d f8 ff ff       	call   801049b0 <_ZL9allocNodeP4procx>
80105153:	89 06                	mov    %eax,(%esi)
		return !isEmpty();
80105155:	85 c0                	test   %eax,%eax
80105157:	0f 95 c0             	setne  %al
}
8010515a:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010515d:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105160:	89 ec                	mov    %ebp,%esp
80105162:	5d                   	pop    %ebp
80105163:	c3                   	ret    
80105164:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010516a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105170 <putPriorityQueue>:
static boolean putPriorityQueue(Proc* p) {
80105170:	55                   	push   %ebp
80105171:	89 e5                	mov    %esp,%ebp
80105173:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->put(p);
80105176:	8b 45 08             	mov    0x8(%ebp),%eax
80105179:	89 44 24 04          	mov    %eax,0x4(%esp)
8010517d:	a1 0c b6 10 80       	mov    0x8010b60c,%eax
80105182:	89 04 24             	mov    %eax,(%esp)
80105185:	e8 86 ff ff ff       	call   80105110 <_ZN3Map3putEP4proc>
}
8010518a:	c9                   	leave  
	return priorityQ->put(p);
8010518b:	0f b6 c0             	movzbl %al,%eax
}
8010518e:	c3                   	ret    
8010518f:	90                   	nop

80105190 <_ZN3Map9getMinKeyEPx>:
bool Map::getMinKey(long long *pkey) {
80105190:	55                   	push   %ebp
80105191:	89 e5                	mov    %esp,%ebp
	return !root;
80105193:	8b 45 08             	mov    0x8(%ebp),%eax
bool Map::getMinKey(long long *pkey) {
80105196:	53                   	push   %ebx
	return !root;
80105197:	8b 10                	mov    (%eax),%edx
	if(isEmpty())
80105199:	85 d2                	test   %edx,%edx
8010519b:	75 05                	jne    801051a2 <_ZN3Map9getMinKeyEPx+0x12>
8010519d:	eb 21                	jmp    801051c0 <_ZN3Map9getMinKeyEPx+0x30>
8010519f:	90                   	nop
	while(minNode->left)
801051a0:	89 c2                	mov    %eax,%edx
801051a2:	8b 42 18             	mov    0x18(%edx),%eax
801051a5:	85 c0                	test   %eax,%eax
801051a7:	75 f7                	jne    801051a0 <_ZN3Map9getMinKeyEPx+0x10>
	*pkey = getMinNode()->key;
801051a9:	8b 45 0c             	mov    0xc(%ebp),%eax
801051ac:	8b 5a 04             	mov    0x4(%edx),%ebx
801051af:	8b 0a                	mov    (%edx),%ecx
801051b1:	89 58 04             	mov    %ebx,0x4(%eax)
801051b4:	89 08                	mov    %ecx,(%eax)
		return false;

	root->getMinKey(pkey);
	return true;
801051b6:	b0 01                	mov    $0x1,%al
}
801051b8:	5b                   	pop    %ebx
801051b9:	5d                   	pop    %ebp
801051ba:	c3                   	ret    
801051bb:	90                   	nop
801051bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801051c0:	5b                   	pop    %ebx
		return false;
801051c1:	31 c0                	xor    %eax,%eax
}
801051c3:	5d                   	pop    %ebp
801051c4:	c3                   	ret    
801051c5:	90                   	nop
801051c6:	8d 76 00             	lea    0x0(%esi),%esi
801051c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801051d0 <_ZN3Map10extractMinEv>:

Proc* Map::extractMin() {
801051d0:	55                   	push   %ebp
801051d1:	89 e5                	mov    %esp,%ebp
801051d3:	57                   	push   %edi
801051d4:	56                   	push   %esi
801051d5:	8b 75 08             	mov    0x8(%ebp),%esi
801051d8:	53                   	push   %ebx
	return !root;
801051d9:	8b 1e                	mov    (%esi),%ebx
	if(isEmpty())
801051db:	85 db                	test   %ebx,%ebx
801051dd:	0f 84 a5 00 00 00    	je     80105288 <_ZN3Map10extractMinEv+0xb8>
801051e3:	89 da                	mov    %ebx,%edx
801051e5:	eb 0b                	jmp    801051f2 <_ZN3Map10extractMinEv+0x22>
801051e7:	89 f6                	mov    %esi,%esi
801051e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	while(minNode->left)
801051f0:	89 c2                	mov    %eax,%edx
801051f2:	8b 42 18             	mov    0x18(%edx),%eax
801051f5:	85 c0                	test   %eax,%eax
801051f7:	75 f7                	jne    801051f0 <_ZN3Map10extractMinEv+0x20>
	return !first;
801051f9:	8b 4a 08             	mov    0x8(%edx),%ecx
	if(isEmpty())
801051fc:	85 c9                	test   %ecx,%ecx
801051fe:	74 70                	je     80105270 <_ZN3Map10extractMinEv+0xa0>
	Link *next = first->next;
80105200:	8b 59 04             	mov    0x4(%ecx),%ebx
	link->next = freeLinks;
80105203:	8b 3d 00 b6 10 80    	mov    0x8010b600,%edi
	Proc *p = first->p;
80105209:	8b 01                	mov    (%ecx),%eax
	freeLinks = link;
8010520b:	89 0d 00 b6 10 80    	mov    %ecx,0x8010b600
	if(isEmpty())
80105211:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
80105213:	89 79 04             	mov    %edi,0x4(%ecx)
	first = next;
80105216:	89 5a 08             	mov    %ebx,0x8(%edx)
	if(isEmpty())
80105219:	74 05                	je     80105220 <_ZN3Map10extractMinEv+0x50>
		}
		deallocNode(minNode);
	}

	return p;
}
8010521b:	5b                   	pop    %ebx
8010521c:	5e                   	pop    %esi
8010521d:	5f                   	pop    %edi
8010521e:	5d                   	pop    %ebp
8010521f:	c3                   	ret    
		last = null;
80105220:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
80105227:	8b 4a 1c             	mov    0x1c(%edx),%ecx
8010522a:	8b 1e                	mov    (%esi),%ebx
		if(minNode == root) {
8010522c:	39 da                	cmp    %ebx,%edx
8010522e:	74 49                	je     80105279 <_ZN3Map10extractMinEv+0xa9>
			MapNode *parent = minNode->parent;
80105230:	8b 5a 14             	mov    0x14(%edx),%ebx
			parent->left = minNode->right;
80105233:	89 4b 18             	mov    %ecx,0x18(%ebx)
			if(minNode->right)
80105236:	8b 4a 1c             	mov    0x1c(%edx),%ecx
80105239:	85 c9                	test   %ecx,%ecx
8010523b:	74 03                	je     80105240 <_ZN3Map10extractMinEv+0x70>
				minNode->right->parent = parent;
8010523d:	89 59 14             	mov    %ebx,0x14(%ecx)
	node->next = freeNodes;
80105240:	8b 0d fc b5 10 80    	mov    0x8010b5fc,%ecx
	node->parent = node->left = node->right = null;
80105246:	c7 42 1c 00 00 00 00 	movl   $0x0,0x1c(%edx)
8010524d:	c7 42 18 00 00 00 00 	movl   $0x0,0x18(%edx)
80105254:	c7 42 14 00 00 00 00 	movl   $0x0,0x14(%edx)
	node->next = freeNodes;
8010525b:	89 4a 10             	mov    %ecx,0x10(%edx)
}
8010525e:	5b                   	pop    %ebx
	freeNodes = node;
8010525f:	89 15 fc b5 10 80    	mov    %edx,0x8010b5fc
}
80105265:	5e                   	pop    %esi
80105266:	5f                   	pop    %edi
80105267:	5d                   	pop    %ebp
80105268:	c3                   	ret    
80105269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return null;
80105270:	31 c0                	xor    %eax,%eax
		if(minNode == root) {
80105272:	39 da                	cmp    %ebx,%edx
80105274:	8b 4a 1c             	mov    0x1c(%edx),%ecx
80105277:	75 b7                	jne    80105230 <_ZN3Map10extractMinEv+0x60>
			if(!isEmpty())
80105279:	85 c9                	test   %ecx,%ecx
			root = minNode->right;
8010527b:	89 0e                	mov    %ecx,(%esi)
			if(!isEmpty())
8010527d:	74 c1                	je     80105240 <_ZN3Map10extractMinEv+0x70>
				root->parent = null;
8010527f:	c7 41 14 00 00 00 00 	movl   $0x0,0x14(%ecx)
80105286:	eb b8                	jmp    80105240 <_ZN3Map10extractMinEv+0x70>
		return null;
80105288:	31 c0                	xor    %eax,%eax
8010528a:	eb 8f                	jmp    8010521b <_ZN3Map10extractMinEv+0x4b>
8010528c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105290 <extractMinPriorityQueue>:
static Proc* extractMinPriorityQueue() {
80105290:	55                   	push   %ebp
80105291:	89 e5                	mov    %esp,%ebp
80105293:	83 ec 04             	sub    $0x4,%esp
	return priorityQ->extractMin();
80105296:	a1 0c b6 10 80       	mov    0x8010b60c,%eax
8010529b:	89 04 24             	mov    %eax,(%esp)
8010529e:	e8 2d ff ff ff       	call   801051d0 <_ZN3Map10extractMinEv>
}
801052a3:	c9                   	leave  
801052a4:	c3                   	ret    
801052a5:	90                   	nop
801052a6:	8d 76 00             	lea    0x0(%esi),%esi
801052a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801052b0 <_ZN3Map8transferEv.part.1>:

bool Map::transfer() {
801052b0:	55                   	push   %ebp
801052b1:	89 e5                	mov    %esp,%ebp
801052b3:	56                   	push   %esi
801052b4:	53                   	push   %ebx
801052b5:	89 c3                	mov    %eax,%ebx
801052b7:	83 ec 04             	sub    $0x4,%esp
801052ba:	eb 16                	jmp    801052d2 <_ZN3Map8transferEv.part.1+0x22>
801052bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!roundRobinQ->isEmpty())
		return false;

	while(!isEmpty()) {
		Proc* p = extractMin();
801052c0:	89 1c 24             	mov    %ebx,(%esp)
801052c3:	e8 08 ff ff ff       	call   801051d0 <_ZN3Map10extractMinEv>
	if(!freeLinks)
801052c8:	8b 15 00 b6 10 80    	mov    0x8010b600,%edx
801052ce:	85 d2                	test   %edx,%edx
801052d0:	75 0e                	jne    801052e0 <_ZN3Map8transferEv.part.1+0x30>
	while(!isEmpty()) {
801052d2:	8b 03                	mov    (%ebx),%eax
801052d4:	85 c0                	test   %eax,%eax
801052d6:	75 e8                	jne    801052c0 <_ZN3Map8transferEv.part.1+0x10>
		roundRobinQ->enqueue(p); //should succeed.
	}

	return true;
}
801052d8:	5a                   	pop    %edx
801052d9:	b0 01                	mov    $0x1,%al
801052db:	5b                   	pop    %ebx
801052dc:	5e                   	pop    %esi
801052dd:	5d                   	pop    %ebp
801052de:	c3                   	ret    
801052df:	90                   	nop
	freeLinks = freeLinks->next;
801052e0:	8b 72 04             	mov    0x4(%edx),%esi
		roundRobinQ->enqueue(p); //should succeed.
801052e3:	8b 0d 08 b6 10 80    	mov    0x8010b608,%ecx
	ans->next = null;
801052e9:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
	ans->p = p;
801052f0:	89 02                	mov    %eax,(%edx)
	freeLinks = freeLinks->next;
801052f2:	89 35 00 b6 10 80    	mov    %esi,0x8010b600
	if(isEmpty()) first = link;
801052f8:	8b 31                	mov    (%ecx),%esi
801052fa:	85 f6                	test   %esi,%esi
801052fc:	74 22                	je     80105320 <_ZN3Map8transferEv.part.1+0x70>
	else last->next = link;
801052fe:	8b 41 04             	mov    0x4(%ecx),%eax
80105301:	89 50 04             	mov    %edx,0x4(%eax)
80105304:	eb 0c                	jmp    80105312 <_ZN3Map8transferEv.part.1+0x62>
80105306:	8d 76 00             	lea    0x0(%esi),%esi
80105309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	while(ans->next)
80105310:	89 c2                	mov    %eax,%edx
80105312:	8b 42 04             	mov    0x4(%edx),%eax
80105315:	85 c0                	test   %eax,%eax
80105317:	75 f7                	jne    80105310 <_ZN3Map8transferEv.part.1+0x60>
	last = link->getLast();
80105319:	89 51 04             	mov    %edx,0x4(%ecx)
8010531c:	eb b4                	jmp    801052d2 <_ZN3Map8transferEv.part.1+0x22>
8010531e:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
80105320:	89 11                	mov    %edx,(%ecx)
80105322:	eb ee                	jmp    80105312 <_ZN3Map8transferEv.part.1+0x62>
80105324:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010532a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105330 <switchToRoundRobinPolicyPriorityQueue>:
	if(!roundRobinQ->isEmpty())
80105330:	8b 15 08 b6 10 80    	mov    0x8010b608,%edx
80105336:	8b 02                	mov    (%edx),%eax
80105338:	85 c0                	test   %eax,%eax
8010533a:	74 04                	je     80105340 <switchToRoundRobinPolicyPriorityQueue+0x10>
8010533c:	31 c0                	xor    %eax,%eax
}
8010533e:	c3                   	ret    
8010533f:	90                   	nop
80105340:	a1 0c b6 10 80       	mov    0x8010b60c,%eax
static boolean switchToRoundRobinPolicyPriorityQueue() {
80105345:	55                   	push   %ebp
80105346:	89 e5                	mov    %esp,%ebp
80105348:	e8 63 ff ff ff       	call   801052b0 <_ZN3Map8transferEv.part.1>
}
8010534d:	5d                   	pop    %ebp
8010534e:	0f b6 c0             	movzbl %al,%eax
80105351:	c3                   	ret    
80105352:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105360 <_ZN3Map8transferEv>:
	return !first;
80105360:	8b 15 08 b6 10 80    	mov    0x8010b608,%edx
bool Map::transfer() {
80105366:	55                   	push   %ebp
80105367:	89 e5                	mov    %esp,%ebp
80105369:	8b 45 08             	mov    0x8(%ebp),%eax
	if(!roundRobinQ->isEmpty())
8010536c:	8b 12                	mov    (%edx),%edx
8010536e:	85 d2                	test   %edx,%edx
80105370:	74 0e                	je     80105380 <_ZN3Map8transferEv+0x20>
}
80105372:	31 c0                	xor    %eax,%eax
80105374:	5d                   	pop    %ebp
80105375:	c3                   	ret    
80105376:	8d 76 00             	lea    0x0(%esi),%esi
80105379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105380:	5d                   	pop    %ebp
80105381:	e9 2a ff ff ff       	jmp    801052b0 <_ZN3Map8transferEv.part.1>
80105386:	8d 76 00             	lea    0x0(%esi),%esi
80105389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105390 <_ZN3Map11extractProcEP4proc>:

bool Map::extractProc(Proc *p) {
80105390:	55                   	push   %ebp
80105391:	89 e5                	mov    %esp,%ebp
80105393:	56                   	push   %esi
80105394:	53                   	push   %ebx
80105395:	83 ec 30             	sub    $0x30,%esp
	if(!freeNodes)
80105398:	8b 15 fc b5 10 80    	mov    0x8010b5fc,%edx
bool Map::extractProc(Proc *p) {
8010539e:	8b 5d 08             	mov    0x8(%ebp),%ebx
801053a1:	8b 75 0c             	mov    0xc(%ebp),%esi
	if(!freeNodes)
801053a4:	85 d2                	test   %edx,%edx
801053a6:	74 50                	je     801053f8 <_ZN3Map11extractProcEP4proc+0x68>
	MapNode *next, *parent, *left, *right;
};

class Map {
public:
	Map(): root(null) {}
801053a8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		return false;

	bool ans = false;
801053af:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
801053b3:	eb 13                	jmp    801053c8 <_ZN3Map11extractProcEP4proc+0x38>
801053b5:	8d 76 00             	lea    0x0(%esi),%esi
	Map tempMap;
	while(!isEmpty()) {
		Proc *otherP = extractMin();
801053b8:	89 1c 24             	mov    %ebx,(%esp)
801053bb:	e8 10 fe ff ff       	call   801051d0 <_ZN3Map10extractMinEv>
		if(otherP != p)
801053c0:	39 f0                	cmp    %esi,%eax
801053c2:	75 1c                	jne    801053e0 <_ZN3Map11extractProcEP4proc+0x50>
			tempMap.put(otherP); //should scucceed.
		else ans = true;
801053c4:	c6 45 e7 01          	movb   $0x1,-0x19(%ebp)
	while(!isEmpty()) {
801053c8:	8b 03                	mov    (%ebx),%eax
801053ca:	85 c0                	test   %eax,%eax
801053cc:	75 ea                	jne    801053b8 <_ZN3Map11extractProcEP4proc+0x28>
	}
	root = tempMap.root;
801053ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053d1:	89 03                	mov    %eax,(%ebx)
	return ans;
}
801053d3:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801053d7:	83 c4 30             	add    $0x30,%esp
801053da:	5b                   	pop    %ebx
801053db:	5e                   	pop    %esi
801053dc:	5d                   	pop    %ebp
801053dd:	c3                   	ret    
801053de:	66 90                	xchg   %ax,%ax
			tempMap.put(otherP); //should scucceed.
801053e0:	89 44 24 04          	mov    %eax,0x4(%esp)
801053e4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053e7:	89 04 24             	mov    %eax,(%esp)
801053ea:	e8 21 fd ff ff       	call   80105110 <_ZN3Map3putEP4proc>
801053ef:	eb d7                	jmp    801053c8 <_ZN3Map11extractProcEP4proc+0x38>
801053f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return false;
801053f8:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
}
801053fc:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80105400:	83 c4 30             	add    $0x30,%esp
80105403:	5b                   	pop    %ebx
80105404:	5e                   	pop    %esi
80105405:	5d                   	pop    %ebp
80105406:	c3                   	ret    
80105407:	89 f6                	mov    %esi,%esi
80105409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105410 <extractProcPriorityQueue>:
static boolean extractProcPriorityQueue(Proc *p) {
80105410:	55                   	push   %ebp
80105411:	89 e5                	mov    %esp,%ebp
80105413:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->extractProc(p);
80105416:	8b 45 08             	mov    0x8(%ebp),%eax
80105419:	89 44 24 04          	mov    %eax,0x4(%esp)
8010541d:	a1 0c b6 10 80       	mov    0x8010b60c,%eax
80105422:	89 04 24             	mov    %eax,(%esp)
80105425:	e8 66 ff ff ff       	call   80105390 <_ZN3Map11extractProcEP4proc>
}
8010542a:	c9                   	leave  
	return priorityQ->extractProc(p);
8010542b:	0f b6 c0             	movzbl %al,%eax
}
8010542e:	c3                   	ret    
8010542f:	90                   	nop

80105430 <__moddi3>:

long long __moddi3(long long number, long long divisor) { //returns number%divisor
80105430:	55                   	push   %ebp
80105431:	89 e5                	mov    %esp,%ebp
80105433:	57                   	push   %edi
80105434:	56                   	push   %esi
80105435:	53                   	push   %ebx
80105436:	83 ec 2c             	sub    $0x2c,%esp
80105439:	8b 45 08             	mov    0x8(%ebp),%eax
8010543c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010543f:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105442:	8b 45 10             	mov    0x10(%ebp),%eax
80105445:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80105448:	8b 55 14             	mov    0x14(%ebp),%edx
8010544b:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010544e:	89 d7                	mov    %edx,%edi
	if(divisor == 0)
80105450:	09 c2                	or     %eax,%edx
80105452:	0f 84 9a 00 00 00    	je     801054f2 <__moddi3+0xc2>
		panic((char*)"divide by zero!!!\n");

	bool isNumberNegative = false;
	if(number < 0) {
80105458:	8b 45 e4             	mov    -0x1c(%ebp),%eax
	bool isNumberNegative = false;
8010545b:	c6 45 df 00          	movb   $0x0,-0x21(%ebp)
	if(number < 0) {
8010545f:	85 c0                	test   %eax,%eax
80105461:	79 0e                	jns    80105471 <__moddi3+0x41>
		number = -number;
80105463:	f7 5d e0             	negl   -0x20(%ebp)
		isNumberNegative = true;
80105466:	c6 45 df 01          	movb   $0x1,-0x21(%ebp)
		number = -number;
8010546a:	83 55 e4 00          	adcl   $0x0,-0x1c(%ebp)
8010546e:	f7 5d e4             	negl   -0x1c(%ebp)
80105471:	8b 55 d8             	mov    -0x28(%ebp),%edx
80105474:	89 f8                	mov    %edi,%eax
80105476:	c1 ff 1f             	sar    $0x1f,%edi
80105479:	31 f8                	xor    %edi,%eax
8010547b:	89 f9                	mov    %edi,%ecx
8010547d:	31 fa                	xor    %edi,%edx
8010547f:	89 c7                	mov    %eax,%edi
80105481:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105484:	89 d6                	mov    %edx,%esi
80105486:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105489:	29 ce                	sub    %ecx,%esi
8010548b:	19 cf                	sbb    %ecx,%edi
	if(divisor < 0)
		divisor = -divisor;

	for(;;) {
		long long divisor2 = divisor;
		while(number >= divisor2) {
8010548d:	39 fa                	cmp    %edi,%edx
8010548f:	7d 1f                	jge    801054b0 <__moddi3+0x80>
			if(divisor2 + divisor2 > 0) //exponential decay.
				divisor2 += divisor2;
		}

		if(number < divisor)
			return isNumberNegative ? -number : number;
80105491:	80 7d df 00          	cmpb   $0x0,-0x21(%ebp)
80105495:	74 07                	je     8010549e <__moddi3+0x6e>
80105497:	f7 d8                	neg    %eax
80105499:	83 d2 00             	adc    $0x0,%edx
8010549c:	f7 da                	neg    %edx
	}
}
8010549e:	83 c4 2c             	add    $0x2c,%esp
801054a1:	5b                   	pop    %ebx
801054a2:	5e                   	pop    %esi
801054a3:	5f                   	pop    %edi
801054a4:	5d                   	pop    %ebp
801054a5:	c3                   	ret    
801054a6:	8d 76 00             	lea    0x0(%esi),%esi
801054a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		while(number >= divisor2) {
801054b0:	7f 04                	jg     801054b6 <__moddi3+0x86>
801054b2:	39 f0                	cmp    %esi,%eax
801054b4:	72 db                	jb     80105491 <__moddi3+0x61>
801054b6:	89 f1                	mov    %esi,%ecx
801054b8:	89 fb                	mov    %edi,%ebx
801054ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			number -= divisor2;
801054c0:	29 c8                	sub    %ecx,%eax
801054c2:	19 da                	sbb    %ebx,%edx
				divisor2 += divisor2;
801054c4:	0f a4 cb 01          	shld   $0x1,%ecx,%ebx
801054c8:	01 c9                	add    %ecx,%ecx
		while(number >= divisor2) {
801054ca:	39 da                	cmp    %ebx,%edx
801054cc:	7f f2                	jg     801054c0 <__moddi3+0x90>
801054ce:	7d 18                	jge    801054e8 <__moddi3+0xb8>
		if(number < divisor)
801054d0:	39 d7                	cmp    %edx,%edi
801054d2:	7c b9                	jl     8010548d <__moddi3+0x5d>
801054d4:	7f bb                	jg     80105491 <__moddi3+0x61>
801054d6:	39 c6                	cmp    %eax,%esi
801054d8:	76 b3                	jbe    8010548d <__moddi3+0x5d>
801054da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801054e0:	eb af                	jmp    80105491 <__moddi3+0x61>
801054e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		while(number >= divisor2) {
801054e8:	39 c8                	cmp    %ecx,%eax
801054ea:	73 d4                	jae    801054c0 <__moddi3+0x90>
801054ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801054f0:	eb de                	jmp    801054d0 <__moddi3+0xa0>
		panic((char*)"divide by zero!!!\n");
801054f2:	c7 04 24 08 8b 10 80 	movl   $0x80108b08,(%esp)
801054f9:	e8 72 ae ff ff       	call   80100370 <panic>
801054fe:	66 90                	xchg   %ax,%ax

80105500 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80105500:	55                   	push   %ebp
  initlock(&lk->lk, "sleep lock");
80105501:	b8 1b 8b 10 80       	mov    $0x80108b1b,%eax
{
80105506:	89 e5                	mov    %esp,%ebp
80105508:	53                   	push   %ebx
80105509:	83 ec 14             	sub    $0x14,%esp
8010550c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010550f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105513:	8d 43 04             	lea    0x4(%ebx),%eax
80105516:	89 04 24             	mov    %eax,(%esp)
80105519:	e8 12 01 00 00       	call   80105630 <initlock>
  lk->name = name;
8010551e:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80105521:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80105527:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010552e:	89 43 38             	mov    %eax,0x38(%ebx)
}
80105531:	83 c4 14             	add    $0x14,%esp
80105534:	5b                   	pop    %ebx
80105535:	5d                   	pop    %ebp
80105536:	c3                   	ret    
80105537:	89 f6                	mov    %esi,%esi
80105539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105540 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80105540:	55                   	push   %ebp
80105541:	89 e5                	mov    %esp,%ebp
80105543:	56                   	push   %esi
80105544:	53                   	push   %ebx
80105545:	83 ec 10             	sub    $0x10,%esp
80105548:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010554b:	8d 73 04             	lea    0x4(%ebx),%esi
8010554e:	89 34 24             	mov    %esi,(%esp)
80105551:	e8 2a 02 00 00       	call   80105780 <acquire>
  while (lk->locked) {
80105556:	8b 13                	mov    (%ebx),%edx
80105558:	85 d2                	test   %edx,%edx
8010555a:	74 16                	je     80105572 <acquiresleep+0x32>
8010555c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80105560:	89 74 24 04          	mov    %esi,0x4(%esp)
80105564:	89 1c 24             	mov    %ebx,(%esp)
80105567:	e8 04 ed ff ff       	call   80104270 <sleep>
  while (lk->locked) {
8010556c:	8b 03                	mov    (%ebx),%eax
8010556e:	85 c0                	test   %eax,%eax
80105570:	75 ee                	jne    80105560 <acquiresleep+0x20>
  }
  lk->locked = 1;
80105572:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80105578:	e8 03 e4 ff ff       	call   80103980 <myproc>
8010557d:	8b 40 10             	mov    0x10(%eax),%eax
80105580:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80105583:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105586:	83 c4 10             	add    $0x10,%esp
80105589:	5b                   	pop    %ebx
8010558a:	5e                   	pop    %esi
8010558b:	5d                   	pop    %ebp
  release(&lk->lk);
8010558c:	e9 8f 02 00 00       	jmp    80105820 <release>
80105591:	eb 0d                	jmp    801055a0 <releasesleep>
80105593:	90                   	nop
80105594:	90                   	nop
80105595:	90                   	nop
80105596:	90                   	nop
80105597:	90                   	nop
80105598:	90                   	nop
80105599:	90                   	nop
8010559a:	90                   	nop
8010559b:	90                   	nop
8010559c:	90                   	nop
8010559d:	90                   	nop
8010559e:	90                   	nop
8010559f:	90                   	nop

801055a0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801055a0:	55                   	push   %ebp
801055a1:	89 e5                	mov    %esp,%ebp
801055a3:	83 ec 18             	sub    $0x18,%esp
801055a6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801055a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801055ac:	89 75 fc             	mov    %esi,-0x4(%ebp)
  acquire(&lk->lk);
801055af:	8d 73 04             	lea    0x4(%ebx),%esi
801055b2:	89 34 24             	mov    %esi,(%esp)
801055b5:	e8 c6 01 00 00       	call   80105780 <acquire>
  lk->locked = 0;
801055ba:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801055c0:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801055c7:	89 1c 24             	mov    %ebx,(%esp)
801055ca:	e8 81 ee ff ff       	call   80104450 <wakeup>
  release(&lk->lk);
}
801055cf:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  release(&lk->lk);
801055d2:	89 75 08             	mov    %esi,0x8(%ebp)
}
801055d5:	8b 75 fc             	mov    -0x4(%ebp),%esi
801055d8:	89 ec                	mov    %ebp,%esp
801055da:	5d                   	pop    %ebp
  release(&lk->lk);
801055db:	e9 40 02 00 00       	jmp    80105820 <release>

801055e0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801055e0:	55                   	push   %ebp
801055e1:	89 e5                	mov    %esp,%ebp
801055e3:	83 ec 28             	sub    $0x28,%esp
801055e6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801055e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801055ec:	89 7d fc             	mov    %edi,-0x4(%ebp)
801055ef:	89 75 f8             	mov    %esi,-0x8(%ebp)
801055f2:	31 f6                	xor    %esi,%esi
  int r;
  
  acquire(&lk->lk);
801055f4:	8d 7b 04             	lea    0x4(%ebx),%edi
801055f7:	89 3c 24             	mov    %edi,(%esp)
801055fa:	e8 81 01 00 00       	call   80105780 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801055ff:	8b 03                	mov    (%ebx),%eax
80105601:	85 c0                	test   %eax,%eax
80105603:	74 11                	je     80105616 <holdingsleep+0x36>
80105605:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80105608:	e8 73 e3 ff ff       	call   80103980 <myproc>
8010560d:	39 58 10             	cmp    %ebx,0x10(%eax)
80105610:	0f 94 c0             	sete   %al
80105613:	0f b6 f0             	movzbl %al,%esi
  release(&lk->lk);
80105616:	89 3c 24             	mov    %edi,(%esp)
80105619:	e8 02 02 00 00       	call   80105820 <release>
  return r;
}
8010561e:	89 f0                	mov    %esi,%eax
80105620:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105623:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105626:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105629:	89 ec                	mov    %ebp,%esp
8010562b:	5d                   	pop    %ebp
8010562c:	c3                   	ret    
8010562d:	66 90                	xchg   %ax,%ax
8010562f:	90                   	nop

80105630 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105630:	55                   	push   %ebp
80105631:	89 e5                	mov    %esp,%ebp
80105633:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80105636:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80105639:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010563f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80105642:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105649:	5d                   	pop    %ebp
8010564a:	c3                   	ret    
8010564b:	90                   	nop
8010564c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105650 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105650:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105651:	31 d2                	xor    %edx,%edx
{
80105653:	89 e5                	mov    %esp,%ebp
  ebp = (uint*)v - 2;
80105655:	8b 45 08             	mov    0x8(%ebp),%eax
{
80105658:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010565b:	53                   	push   %ebx
  ebp = (uint*)v - 2;
8010565c:	83 e8 08             	sub    $0x8,%eax
8010565f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105660:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80105666:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010566c:	77 12                	ja     80105680 <getcallerpcs+0x30>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010566e:	8b 58 04             	mov    0x4(%eax),%ebx
80105671:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80105674:	42                   	inc    %edx
80105675:	83 fa 0a             	cmp    $0xa,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80105678:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
8010567a:	75 e4                	jne    80105660 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010567c:	5b                   	pop    %ebx
8010567d:	5d                   	pop    %ebp
8010567e:	c3                   	ret    
8010567f:	90                   	nop
80105680:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80105683:	83 c1 28             	add    $0x28,%ecx
80105686:	8d 76 00             	lea    0x0(%esi),%esi
80105689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80105690:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105696:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105699:	39 c1                	cmp    %eax,%ecx
8010569b:	75 f3                	jne    80105690 <getcallerpcs+0x40>
}
8010569d:	5b                   	pop    %ebx
8010569e:	5d                   	pop    %ebp
8010569f:	c3                   	ret    

801056a0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801056a0:	55                   	push   %ebp
801056a1:	89 e5                	mov    %esp,%ebp
801056a3:	53                   	push   %ebx
801056a4:	83 ec 04             	sub    $0x4,%esp
801056a7:	9c                   	pushf  
801056a8:	5b                   	pop    %ebx
  asm volatile("cli");
801056a9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801056aa:	e8 31 e2 ff ff       	call   801038e0 <mycpu>
801056af:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801056b5:	85 d2                	test   %edx,%edx
801056b7:	75 11                	jne    801056ca <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801056b9:	e8 22 e2 ff ff       	call   801038e0 <mycpu>
801056be:	81 e3 00 02 00 00    	and    $0x200,%ebx
801056c4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801056ca:	e8 11 e2 ff ff       	call   801038e0 <mycpu>
801056cf:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
801056d5:	58                   	pop    %eax
801056d6:	5b                   	pop    %ebx
801056d7:	5d                   	pop    %ebp
801056d8:	c3                   	ret    
801056d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801056e0 <popcli>:

void
popcli(void)
{
801056e0:	55                   	push   %ebp
801056e1:	89 e5                	mov    %esp,%ebp
801056e3:	83 ec 18             	sub    $0x18,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801056e6:	9c                   	pushf  
801056e7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801056e8:	f6 c4 02             	test   $0x2,%ah
801056eb:	75 35                	jne    80105722 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801056ed:	e8 ee e1 ff ff       	call   801038e0 <mycpu>
801056f2:	ff 88 a4 00 00 00    	decl   0xa4(%eax)
801056f8:	78 34                	js     8010572e <popcli+0x4e>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801056fa:	e8 e1 e1 ff ff       	call   801038e0 <mycpu>
801056ff:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105705:	85 d2                	test   %edx,%edx
80105707:	74 07                	je     80105710 <popcli+0x30>
    sti();
}
80105709:	c9                   	leave  
8010570a:	c3                   	ret    
8010570b:	90                   	nop
8010570c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105710:	e8 cb e1 ff ff       	call   801038e0 <mycpu>
80105715:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010571b:	85 c0                	test   %eax,%eax
8010571d:	74 ea                	je     80105709 <popcli+0x29>
  asm volatile("sti");
8010571f:	fb                   	sti    
}
80105720:	c9                   	leave  
80105721:	c3                   	ret    
    panic("popcli - interruptible");
80105722:	c7 04 24 26 8b 10 80 	movl   $0x80108b26,(%esp)
80105729:	e8 42 ac ff ff       	call   80100370 <panic>
    panic("popcli");
8010572e:	c7 04 24 3d 8b 10 80 	movl   $0x80108b3d,(%esp)
80105735:	e8 36 ac ff ff       	call   80100370 <panic>
8010573a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105740 <holding>:
{
80105740:	55                   	push   %ebp
80105741:	89 e5                	mov    %esp,%ebp
80105743:	83 ec 08             	sub    $0x8,%esp
80105746:	89 75 fc             	mov    %esi,-0x4(%ebp)
80105749:	8b 75 08             	mov    0x8(%ebp),%esi
8010574c:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010574f:	31 db                	xor    %ebx,%ebx
  pushcli();
80105751:	e8 4a ff ff ff       	call   801056a0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105756:	8b 06                	mov    (%esi),%eax
80105758:	85 c0                	test   %eax,%eax
8010575a:	74 10                	je     8010576c <holding+0x2c>
8010575c:	8b 5e 08             	mov    0x8(%esi),%ebx
8010575f:	e8 7c e1 ff ff       	call   801038e0 <mycpu>
80105764:	39 c3                	cmp    %eax,%ebx
80105766:	0f 94 c3             	sete   %bl
80105769:	0f b6 db             	movzbl %bl,%ebx
  popcli();
8010576c:	e8 6f ff ff ff       	call   801056e0 <popcli>
}
80105771:	89 d8                	mov    %ebx,%eax
80105773:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105776:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105779:	89 ec                	mov    %ebp,%esp
8010577b:	5d                   	pop    %ebp
8010577c:	c3                   	ret    
8010577d:	8d 76 00             	lea    0x0(%esi),%esi

80105780 <acquire>:
{
80105780:	55                   	push   %ebp
80105781:	89 e5                	mov    %esp,%ebp
80105783:	56                   	push   %esi
80105784:	53                   	push   %ebx
80105785:	83 ec 10             	sub    $0x10,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105788:	e8 13 ff ff ff       	call   801056a0 <pushcli>
  if(holding(lk))
8010578d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105790:	89 1c 24             	mov    %ebx,(%esp)
80105793:	e8 a8 ff ff ff       	call   80105740 <holding>
80105798:	85 c0                	test   %eax,%eax
8010579a:	75 78                	jne    80105814 <acquire+0x94>
8010579c:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
8010579e:	ba 01 00 00 00       	mov    $0x1,%edx
801057a3:	eb 06                	jmp    801057ab <acquire+0x2b>
801057a5:	8d 76 00             	lea    0x0(%esi),%esi
801057a8:	8b 5d 08             	mov    0x8(%ebp),%ebx
801057ab:	89 d0                	mov    %edx,%eax
801057ad:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
801057b0:	85 c0                	test   %eax,%eax
801057b2:	75 f4                	jne    801057a8 <acquire+0x28>
  __sync_synchronize();
801057b4:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801057b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801057bc:	e8 1f e1 ff ff       	call   801038e0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801057c1:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
801057c4:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
801057c7:	89 e8                	mov    %ebp,%eax
801057c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801057d0:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801057d6:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
801057dc:	77 1a                	ja     801057f8 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
801057de:	8b 48 04             	mov    0x4(%eax),%ecx
801057e1:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
801057e4:	46                   	inc    %esi
801057e5:	83 fe 0a             	cmp    $0xa,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
801057e8:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801057ea:	75 e4                	jne    801057d0 <acquire+0x50>
}
801057ec:	83 c4 10             	add    $0x10,%esp
801057ef:	5b                   	pop    %ebx
801057f0:	5e                   	pop    %esi
801057f1:	5d                   	pop    %ebp
801057f2:	c3                   	ret    
801057f3:	90                   	nop
801057f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801057f8:	8d 04 b2             	lea    (%edx,%esi,4),%eax
801057fb:	83 c2 28             	add    $0x28,%edx
801057fe:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105800:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105806:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105809:	39 d0                	cmp    %edx,%eax
8010580b:	75 f3                	jne    80105800 <acquire+0x80>
}
8010580d:	83 c4 10             	add    $0x10,%esp
80105810:	5b                   	pop    %ebx
80105811:	5e                   	pop    %esi
80105812:	5d                   	pop    %ebp
80105813:	c3                   	ret    
    panic("acquire");
80105814:	c7 04 24 44 8b 10 80 	movl   $0x80108b44,(%esp)
8010581b:	e8 50 ab ff ff       	call   80100370 <panic>

80105820 <release>:
{
80105820:	55                   	push   %ebp
80105821:	89 e5                	mov    %esp,%ebp
80105823:	53                   	push   %ebx
80105824:	83 ec 14             	sub    $0x14,%esp
80105827:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010582a:	89 1c 24             	mov    %ebx,(%esp)
8010582d:	e8 0e ff ff ff       	call   80105740 <holding>
80105832:	85 c0                	test   %eax,%eax
80105834:	74 23                	je     80105859 <release+0x39>
  lk->pcs[0] = 0;
80105836:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010583d:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105844:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80105849:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
8010584f:	83 c4 14             	add    $0x14,%esp
80105852:	5b                   	pop    %ebx
80105853:	5d                   	pop    %ebp
  popcli();
80105854:	e9 87 fe ff ff       	jmp    801056e0 <popcli>
    panic("release");
80105859:	c7 04 24 4c 8b 10 80 	movl   $0x80108b4c,(%esp)
80105860:	e8 0b ab ff ff       	call   80100370 <panic>
80105865:	66 90                	xchg   %ax,%ax
80105867:	66 90                	xchg   %ax,%ax
80105869:	66 90                	xchg   %ax,%ax
8010586b:	66 90                	xchg   %ax,%ax
8010586d:	66 90                	xchg   %ax,%ax
8010586f:	90                   	nop

80105870 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105870:	55                   	push   %ebp
80105871:	89 e5                	mov    %esp,%ebp
80105873:	83 ec 08             	sub    $0x8,%esp
80105876:	8b 55 08             	mov    0x8(%ebp),%edx
80105879:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010587c:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010587f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if ((int)dst%4 == 0 && n%4 == 0){
80105882:	f6 c2 03             	test   $0x3,%dl
80105885:	75 05                	jne    8010588c <memset+0x1c>
80105887:	f6 c1 03             	test   $0x3,%cl
8010588a:	74 14                	je     801058a0 <memset+0x30>
  asm volatile("cld; rep stosb" :
8010588c:	89 d7                	mov    %edx,%edi
8010588e:	8b 45 0c             	mov    0xc(%ebp),%eax
80105891:	fc                   	cld    
80105892:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80105894:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105897:	89 d0                	mov    %edx,%eax
80105899:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010589c:	89 ec                	mov    %ebp,%esp
8010589e:	5d                   	pop    %ebp
8010589f:	c3                   	ret    
    c &= 0xFF;
801058a0:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801058a4:	c1 e9 02             	shr    $0x2,%ecx
801058a7:	89 f8                	mov    %edi,%eax
801058a9:	89 fb                	mov    %edi,%ebx
801058ab:	c1 e0 18             	shl    $0x18,%eax
801058ae:	c1 e3 10             	shl    $0x10,%ebx
801058b1:	09 d8                	or     %ebx,%eax
801058b3:	09 f8                	or     %edi,%eax
801058b5:	c1 e7 08             	shl    $0x8,%edi
801058b8:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
801058ba:	89 d7                	mov    %edx,%edi
801058bc:	fc                   	cld    
801058bd:	f3 ab                	rep stos %eax,%es:(%edi)
}
801058bf:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801058c2:	89 d0                	mov    %edx,%eax
801058c4:	8b 7d fc             	mov    -0x4(%ebp),%edi
801058c7:	89 ec                	mov    %ebp,%esp
801058c9:	5d                   	pop    %ebp
801058ca:	c3                   	ret    
801058cb:	90                   	nop
801058cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801058d0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801058d0:	55                   	push   %ebp
801058d1:	89 e5                	mov    %esp,%ebp
801058d3:	57                   	push   %edi
801058d4:	8b 7d 0c             	mov    0xc(%ebp),%edi
801058d7:	56                   	push   %esi
801058d8:	8b 75 08             	mov    0x8(%ebp),%esi
801058db:	53                   	push   %ebx
801058dc:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801058df:	85 db                	test   %ebx,%ebx
801058e1:	74 27                	je     8010590a <memcmp+0x3a>
    if(*s1 != *s2)
801058e3:	0f b6 16             	movzbl (%esi),%edx
801058e6:	0f b6 0f             	movzbl (%edi),%ecx
801058e9:	38 d1                	cmp    %dl,%cl
801058eb:	75 2b                	jne    80105918 <memcmp+0x48>
801058ed:	b8 01 00 00 00       	mov    $0x1,%eax
801058f2:	eb 12                	jmp    80105906 <memcmp+0x36>
801058f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801058f8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
801058fc:	40                   	inc    %eax
801058fd:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80105902:	38 ca                	cmp    %cl,%dl
80105904:	75 12                	jne    80105918 <memcmp+0x48>
  while(n-- > 0){
80105906:	39 d8                	cmp    %ebx,%eax
80105908:	75 ee                	jne    801058f8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010590a:	5b                   	pop    %ebx
  return 0;
8010590b:	31 c0                	xor    %eax,%eax
}
8010590d:	5e                   	pop    %esi
8010590e:	5f                   	pop    %edi
8010590f:	5d                   	pop    %ebp
80105910:	c3                   	ret    
80105911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105918:	5b                   	pop    %ebx
      return *s1 - *s2;
80105919:	0f b6 c2             	movzbl %dl,%eax
8010591c:	29 c8                	sub    %ecx,%eax
}
8010591e:	5e                   	pop    %esi
8010591f:	5f                   	pop    %edi
80105920:	5d                   	pop    %ebp
80105921:	c3                   	ret    
80105922:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105930 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105930:	55                   	push   %ebp
80105931:	89 e5                	mov    %esp,%ebp
80105933:	56                   	push   %esi
80105934:	8b 45 08             	mov    0x8(%ebp),%eax
80105937:	53                   	push   %ebx
80105938:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010593b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010593e:	39 c3                	cmp    %eax,%ebx
80105940:	73 26                	jae    80105968 <memmove+0x38>
80105942:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80105945:	39 c8                	cmp    %ecx,%eax
80105947:	73 1f                	jae    80105968 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80105949:	85 f6                	test   %esi,%esi
8010594b:	8d 56 ff             	lea    -0x1(%esi),%edx
8010594e:	74 0d                	je     8010595d <memmove+0x2d>
      *--d = *--s;
80105950:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105954:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80105957:	4a                   	dec    %edx
80105958:	83 fa ff             	cmp    $0xffffffff,%edx
8010595b:	75 f3                	jne    80105950 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010595d:	5b                   	pop    %ebx
8010595e:	5e                   	pop    %esi
8010595f:	5d                   	pop    %ebp
80105960:	c3                   	ret    
80105961:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80105968:	31 d2                	xor    %edx,%edx
8010596a:	85 f6                	test   %esi,%esi
8010596c:	74 ef                	je     8010595d <memmove+0x2d>
8010596e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80105970:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105974:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80105977:	42                   	inc    %edx
    while(n-- > 0)
80105978:	39 d6                	cmp    %edx,%esi
8010597a:	75 f4                	jne    80105970 <memmove+0x40>
}
8010597c:	5b                   	pop    %ebx
8010597d:	5e                   	pop    %esi
8010597e:	5d                   	pop    %ebp
8010597f:	c3                   	ret    

80105980 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105980:	55                   	push   %ebp
80105981:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80105983:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80105984:	eb aa                	jmp    80105930 <memmove>
80105986:	8d 76 00             	lea    0x0(%esi),%esi
80105989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105990 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80105990:	55                   	push   %ebp
80105991:	89 e5                	mov    %esp,%ebp
80105993:	57                   	push   %edi
80105994:	8b 7d 10             	mov    0x10(%ebp),%edi
80105997:	56                   	push   %esi
80105998:	8b 75 0c             	mov    0xc(%ebp),%esi
8010599b:	53                   	push   %ebx
8010599c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
8010599f:	85 ff                	test   %edi,%edi
801059a1:	74 2d                	je     801059d0 <strncmp+0x40>
801059a3:	0f b6 03             	movzbl (%ebx),%eax
801059a6:	0f b6 0e             	movzbl (%esi),%ecx
801059a9:	84 c0                	test   %al,%al
801059ab:	74 37                	je     801059e4 <strncmp+0x54>
801059ad:	38 c1                	cmp    %al,%cl
801059af:	75 33                	jne    801059e4 <strncmp+0x54>
801059b1:	01 f7                	add    %esi,%edi
801059b3:	eb 13                	jmp    801059c8 <strncmp+0x38>
801059b5:	8d 76 00             	lea    0x0(%esi),%esi
801059b8:	0f b6 03             	movzbl (%ebx),%eax
801059bb:	84 c0                	test   %al,%al
801059bd:	74 21                	je     801059e0 <strncmp+0x50>
801059bf:	0f b6 0a             	movzbl (%edx),%ecx
801059c2:	89 d6                	mov    %edx,%esi
801059c4:	38 c8                	cmp    %cl,%al
801059c6:	75 1c                	jne    801059e4 <strncmp+0x54>
    n--, p++, q++;
801059c8:	8d 56 01             	lea    0x1(%esi),%edx
801059cb:	43                   	inc    %ebx
  while(n > 0 && *p && *p == *q)
801059cc:	39 fa                	cmp    %edi,%edx
801059ce:	75 e8                	jne    801059b8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
801059d0:	5b                   	pop    %ebx
    return 0;
801059d1:	31 c0                	xor    %eax,%eax
}
801059d3:	5e                   	pop    %esi
801059d4:	5f                   	pop    %edi
801059d5:	5d                   	pop    %ebp
801059d6:	c3                   	ret    
801059d7:	89 f6                	mov    %esi,%esi
801059d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801059e0:	0f b6 4e 01          	movzbl 0x1(%esi),%ecx
801059e4:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
801059e5:	29 c8                	sub    %ecx,%eax
}
801059e7:	5e                   	pop    %esi
801059e8:	5f                   	pop    %edi
801059e9:	5d                   	pop    %ebp
801059ea:	c3                   	ret    
801059eb:	90                   	nop
801059ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801059f0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801059f0:	55                   	push   %ebp
801059f1:	89 e5                	mov    %esp,%ebp
801059f3:	8b 45 08             	mov    0x8(%ebp),%eax
801059f6:	56                   	push   %esi
801059f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
801059fa:	53                   	push   %ebx
801059fb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801059fe:	89 c2                	mov    %eax,%edx
80105a00:	eb 15                	jmp    80105a17 <strncpy+0x27>
80105a02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105a08:	46                   	inc    %esi
80105a09:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
80105a0d:	42                   	inc    %edx
80105a0e:	84 c9                	test   %cl,%cl
80105a10:	88 4a ff             	mov    %cl,-0x1(%edx)
80105a13:	74 09                	je     80105a1e <strncpy+0x2e>
80105a15:	89 d9                	mov    %ebx,%ecx
80105a17:	85 c9                	test   %ecx,%ecx
80105a19:	8d 59 ff             	lea    -0x1(%ecx),%ebx
80105a1c:	7f ea                	jg     80105a08 <strncpy+0x18>
    ;
  while(n-- > 0)
80105a1e:	31 c9                	xor    %ecx,%ecx
80105a20:	85 db                	test   %ebx,%ebx
80105a22:	7e 19                	jle    80105a3d <strncpy+0x4d>
80105a24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105a2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *s++ = 0;
80105a30:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80105a34:	89 de                	mov    %ebx,%esi
80105a36:	41                   	inc    %ecx
80105a37:	29 ce                	sub    %ecx,%esi
  while(n-- > 0)
80105a39:	85 f6                	test   %esi,%esi
80105a3b:	7f f3                	jg     80105a30 <strncpy+0x40>
  return os;
}
80105a3d:	5b                   	pop    %ebx
80105a3e:	5e                   	pop    %esi
80105a3f:	5d                   	pop    %ebp
80105a40:	c3                   	ret    
80105a41:	eb 0d                	jmp    80105a50 <safestrcpy>
80105a43:	90                   	nop
80105a44:	90                   	nop
80105a45:	90                   	nop
80105a46:	90                   	nop
80105a47:	90                   	nop
80105a48:	90                   	nop
80105a49:	90                   	nop
80105a4a:	90                   	nop
80105a4b:	90                   	nop
80105a4c:	90                   	nop
80105a4d:	90                   	nop
80105a4e:	90                   	nop
80105a4f:	90                   	nop

80105a50 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105a50:	55                   	push   %ebp
80105a51:	89 e5                	mov    %esp,%ebp
80105a53:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105a56:	56                   	push   %esi
80105a57:	8b 45 08             	mov    0x8(%ebp),%eax
80105a5a:	53                   	push   %ebx
80105a5b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80105a5e:	85 c9                	test   %ecx,%ecx
80105a60:	7e 22                	jle    80105a84 <safestrcpy+0x34>
80105a62:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80105a66:	89 c1                	mov    %eax,%ecx
80105a68:	eb 13                	jmp    80105a7d <safestrcpy+0x2d>
80105a6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105a70:	42                   	inc    %edx
80105a71:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80105a75:	41                   	inc    %ecx
80105a76:	84 db                	test   %bl,%bl
80105a78:	88 59 ff             	mov    %bl,-0x1(%ecx)
80105a7b:	74 04                	je     80105a81 <safestrcpy+0x31>
80105a7d:	39 f2                	cmp    %esi,%edx
80105a7f:	75 ef                	jne    80105a70 <safestrcpy+0x20>
    ;
  *s = 0;
80105a81:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80105a84:	5b                   	pop    %ebx
80105a85:	5e                   	pop    %esi
80105a86:	5d                   	pop    %ebp
80105a87:	c3                   	ret    
80105a88:	90                   	nop
80105a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105a90 <strlen>:

int
strlen(const char *s)
{
80105a90:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105a91:	31 c0                	xor    %eax,%eax
{
80105a93:	89 e5                	mov    %esp,%ebp
80105a95:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105a98:	80 3a 00             	cmpb   $0x0,(%edx)
80105a9b:	74 0a                	je     80105aa7 <strlen+0x17>
80105a9d:	8d 76 00             	lea    0x0(%esi),%esi
80105aa0:	40                   	inc    %eax
80105aa1:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105aa5:	75 f9                	jne    80105aa0 <strlen+0x10>
    ;
  return n;
}
80105aa7:	5d                   	pop    %ebp
80105aa8:	c3                   	ret    

80105aa9 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80105aa9:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80105aad:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80105ab1:	55                   	push   %ebp
  pushl %ebx
80105ab2:	53                   	push   %ebx
  pushl %esi
80105ab3:	56                   	push   %esi
  pushl %edi
80105ab4:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105ab5:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105ab7:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80105ab9:	5f                   	pop    %edi
  popl %esi
80105aba:	5e                   	pop    %esi
  popl %ebx
80105abb:	5b                   	pop    %ebx
  popl %ebp
80105abc:	5d                   	pop    %ebp
  ret
80105abd:	c3                   	ret    
80105abe:	66 90                	xchg   %ax,%ax

80105ac0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105ac0:	55                   	push   %ebp
80105ac1:	89 e5                	mov    %esp,%ebp
80105ac3:	53                   	push   %ebx
80105ac4:	83 ec 04             	sub    $0x4,%esp
80105ac7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80105aca:	e8 b1 de ff ff       	call   80103980 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105acf:	8b 00                	mov    (%eax),%eax
80105ad1:	39 d8                	cmp    %ebx,%eax
80105ad3:	76 1b                	jbe    80105af0 <fetchint+0x30>
80105ad5:	8d 53 04             	lea    0x4(%ebx),%edx
80105ad8:	39 d0                	cmp    %edx,%eax
80105ada:	72 14                	jb     80105af0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80105adc:	8b 45 0c             	mov    0xc(%ebp),%eax
80105adf:	8b 13                	mov    (%ebx),%edx
80105ae1:	89 10                	mov    %edx,(%eax)
  return 0;
80105ae3:	31 c0                	xor    %eax,%eax
}
80105ae5:	5a                   	pop    %edx
80105ae6:	5b                   	pop    %ebx
80105ae7:	5d                   	pop    %ebp
80105ae8:	c3                   	ret    
80105ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105af0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105af5:	eb ee                	jmp    80105ae5 <fetchint+0x25>
80105af7:	89 f6                	mov    %esi,%esi
80105af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b00 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105b00:	55                   	push   %ebp
80105b01:	89 e5                	mov    %esp,%ebp
80105b03:	53                   	push   %ebx
80105b04:	83 ec 04             	sub    $0x4,%esp
80105b07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80105b0a:	e8 71 de ff ff       	call   80103980 <myproc>

  if(addr >= curproc->sz)
80105b0f:	39 18                	cmp    %ebx,(%eax)
80105b11:	76 27                	jbe    80105b3a <fetchstr+0x3a>
    return -1;
  *pp = (char*)addr;
80105b13:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105b16:	89 da                	mov    %ebx,%edx
80105b18:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80105b1a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80105b1c:	39 c3                	cmp    %eax,%ebx
80105b1e:	73 1a                	jae    80105b3a <fetchstr+0x3a>
    if(*s == 0)
80105b20:	80 3b 00             	cmpb   $0x0,(%ebx)
80105b23:	75 10                	jne    80105b35 <fetchstr+0x35>
80105b25:	eb 29                	jmp    80105b50 <fetchstr+0x50>
80105b27:	89 f6                	mov    %esi,%esi
80105b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105b30:	80 3a 00             	cmpb   $0x0,(%edx)
80105b33:	74 13                	je     80105b48 <fetchstr+0x48>
  for(s = *pp; s < ep; s++){
80105b35:	42                   	inc    %edx
80105b36:	39 d0                	cmp    %edx,%eax
80105b38:	77 f6                	ja     80105b30 <fetchstr+0x30>
    return -1;
80105b3a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80105b3f:	5a                   	pop    %edx
80105b40:	5b                   	pop    %ebx
80105b41:	5d                   	pop    %ebp
80105b42:	c3                   	ret    
80105b43:	90                   	nop
80105b44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b48:	89 d0                	mov    %edx,%eax
80105b4a:	5a                   	pop    %edx
80105b4b:	29 d8                	sub    %ebx,%eax
80105b4d:	5b                   	pop    %ebx
80105b4e:	5d                   	pop    %ebp
80105b4f:	c3                   	ret    
    if(*s == 0)
80105b50:	31 c0                	xor    %eax,%eax
      return s - *pp;
80105b52:	eb eb                	jmp    80105b3f <fetchstr+0x3f>
80105b54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105b5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105b60 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105b60:	55                   	push   %ebp
80105b61:	89 e5                	mov    %esp,%ebp
80105b63:	56                   	push   %esi
80105b64:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105b65:	e8 16 de ff ff       	call   80103980 <myproc>
80105b6a:	8b 55 08             	mov    0x8(%ebp),%edx
80105b6d:	8b 40 18             	mov    0x18(%eax),%eax
80105b70:	8b 40 44             	mov    0x44(%eax),%eax
80105b73:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105b76:	e8 05 de ff ff       	call   80103980 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105b7b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105b7e:	8b 00                	mov    (%eax),%eax
80105b80:	39 c6                	cmp    %eax,%esi
80105b82:	73 1c                	jae    80105ba0 <argint+0x40>
80105b84:	8d 53 08             	lea    0x8(%ebx),%edx
80105b87:	39 d0                	cmp    %edx,%eax
80105b89:	72 15                	jb     80105ba0 <argint+0x40>
  *ip = *(int*)(addr);
80105b8b:	8b 45 0c             	mov    0xc(%ebp),%eax
80105b8e:	8b 53 04             	mov    0x4(%ebx),%edx
80105b91:	89 10                	mov    %edx,(%eax)
  return 0;
80105b93:	31 c0                	xor    %eax,%eax
}
80105b95:	5b                   	pop    %ebx
80105b96:	5e                   	pop    %esi
80105b97:	5d                   	pop    %ebp
80105b98:	c3                   	ret    
80105b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105ba0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105ba5:	eb ee                	jmp    80105b95 <argint+0x35>
80105ba7:	89 f6                	mov    %esi,%esi
80105ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105bb0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105bb0:	55                   	push   %ebp
80105bb1:	89 e5                	mov    %esp,%ebp
80105bb3:	56                   	push   %esi
80105bb4:	53                   	push   %ebx
80105bb5:	83 ec 20             	sub    $0x20,%esp
80105bb8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80105bbb:	e8 c0 dd ff ff       	call   80103980 <myproc>
80105bc0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80105bc2:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105bc5:	89 44 24 04          	mov    %eax,0x4(%esp)
80105bc9:	8b 45 08             	mov    0x8(%ebp),%eax
80105bcc:	89 04 24             	mov    %eax,(%esp)
80105bcf:	e8 8c ff ff ff       	call   80105b60 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105bd4:	c1 e8 1f             	shr    $0x1f,%eax
80105bd7:	84 c0                	test   %al,%al
80105bd9:	75 2d                	jne    80105c08 <argptr+0x58>
80105bdb:	89 d8                	mov    %ebx,%eax
80105bdd:	c1 e8 1f             	shr    $0x1f,%eax
80105be0:	84 c0                	test   %al,%al
80105be2:	75 24                	jne    80105c08 <argptr+0x58>
80105be4:	8b 16                	mov    (%esi),%edx
80105be6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105be9:	39 c2                	cmp    %eax,%edx
80105beb:	76 1b                	jbe    80105c08 <argptr+0x58>
80105bed:	01 c3                	add    %eax,%ebx
80105bef:	39 da                	cmp    %ebx,%edx
80105bf1:	72 15                	jb     80105c08 <argptr+0x58>
    return -1;
  *pp = (char*)i;
80105bf3:	8b 55 0c             	mov    0xc(%ebp),%edx
80105bf6:	89 02                	mov    %eax,(%edx)
  return 0;
80105bf8:	31 c0                	xor    %eax,%eax
}
80105bfa:	83 c4 20             	add    $0x20,%esp
80105bfd:	5b                   	pop    %ebx
80105bfe:	5e                   	pop    %esi
80105bff:	5d                   	pop    %ebp
80105c00:	c3                   	ret    
80105c01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105c08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c0d:	eb eb                	jmp    80105bfa <argptr+0x4a>
80105c0f:	90                   	nop

80105c10 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105c10:	55                   	push   %ebp
80105c11:	89 e5                	mov    %esp,%ebp
80105c13:	83 ec 28             	sub    $0x28,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105c16:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105c19:	89 44 24 04          	mov    %eax,0x4(%esp)
80105c1d:	8b 45 08             	mov    0x8(%ebp),%eax
80105c20:	89 04 24             	mov    %eax,(%esp)
80105c23:	e8 38 ff ff ff       	call   80105b60 <argint>
80105c28:	85 c0                	test   %eax,%eax
80105c2a:	78 14                	js     80105c40 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80105c2c:	8b 45 0c             	mov    0xc(%ebp),%eax
80105c2f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105c33:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c36:	89 04 24             	mov    %eax,(%esp)
80105c39:	e8 c2 fe ff ff       	call   80105b00 <fetchstr>
}
80105c3e:	c9                   	leave  
80105c3f:	c3                   	ret    
    return -1;
80105c40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c45:	c9                   	leave  
80105c46:	c3                   	ret    
80105c47:	89 f6                	mov    %esi,%esi
80105c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105c50 <syscall>:
[SYS_policy] sys_policy,
};

void
syscall(void)
{
80105c50:	55                   	push   %ebp
80105c51:	89 e5                	mov    %esp,%ebp
80105c53:	53                   	push   %ebx
80105c54:	83 ec 14             	sub    $0x14,%esp
  int num;
  struct proc *curproc = myproc();
80105c57:	e8 24 dd ff ff       	call   80103980 <myproc>
80105c5c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80105c5e:	8b 40 18             	mov    0x18(%eax),%eax
80105c61:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105c64:	8d 50 ff             	lea    -0x1(%eax),%edx
80105c67:	83 fa 17             	cmp    $0x17,%edx
80105c6a:	77 1c                	ja     80105c88 <syscall+0x38>
80105c6c:	8b 14 85 80 8b 10 80 	mov    -0x7fef7480(,%eax,4),%edx
80105c73:	85 d2                	test   %edx,%edx
80105c75:	74 11                	je     80105c88 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80105c77:	ff d2                	call   *%edx
80105c79:	8b 53 18             	mov    0x18(%ebx),%edx
80105c7c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105c7f:	83 c4 14             	add    $0x14,%esp
80105c82:	5b                   	pop    %ebx
80105c83:	5d                   	pop    %ebp
80105c84:	c3                   	ret    
80105c85:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80105c88:	89 44 24 0c          	mov    %eax,0xc(%esp)
            curproc->pid, curproc->name, num);
80105c8c:	8d 43 6c             	lea    0x6c(%ebx),%eax
80105c8f:	89 44 24 08          	mov    %eax,0x8(%esp)
    cprintf("%d %s: unknown sys call %d\n",
80105c93:	8b 43 10             	mov    0x10(%ebx),%eax
80105c96:	c7 04 24 54 8b 10 80 	movl   $0x80108b54,(%esp)
80105c9d:	89 44 24 04          	mov    %eax,0x4(%esp)
80105ca1:	e8 aa a9 ff ff       	call   80100650 <cprintf>
    curproc->tf->eax = -1;
80105ca6:	8b 43 18             	mov    0x18(%ebx),%eax
80105ca9:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80105cb0:	83 c4 14             	add    $0x14,%esp
80105cb3:	5b                   	pop    %ebx
80105cb4:	5d                   	pop    %ebp
80105cb5:	c3                   	ret    
80105cb6:	66 90                	xchg   %ax,%ax
80105cb8:	66 90                	xchg   %ax,%ax
80105cba:	66 90                	xchg   %ax,%ax
80105cbc:	66 90                	xchg   %ax,%ax
80105cbe:	66 90                	xchg   %ax,%ax

80105cc0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105cc0:	55                   	push   %ebp
80105cc1:	0f bf d2             	movswl %dx,%edx
80105cc4:	89 e5                	mov    %esp,%ebp
80105cc6:	83 ec 58             	sub    $0x58,%esp
80105cc9:	89 7d fc             	mov    %edi,-0x4(%ebp)
80105ccc:	0f bf 7d 08          	movswl 0x8(%ebp),%edi
80105cd0:	0f bf c9             	movswl %cx,%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105cd3:	89 04 24             	mov    %eax,(%esp)
{
80105cd6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80105cd9:	89 75 f8             	mov    %esi,-0x8(%ebp)
80105cdc:	89 7d bc             	mov    %edi,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80105cdf:	8d 7d da             	lea    -0x26(%ebp),%edi
80105ce2:	89 7c 24 04          	mov    %edi,0x4(%esp)
{
80105ce6:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80105ce9:	89 4d c0             	mov    %ecx,-0x40(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80105cec:	e8 ff c2 ff ff       	call   80101ff0 <nameiparent>
80105cf1:	85 c0                	test   %eax,%eax
80105cf3:	0f 84 4f 01 00 00    	je     80105e48 <create+0x188>
    return 0;
  ilock(dp);
80105cf9:	89 04 24             	mov    %eax,(%esp)
80105cfc:	89 c3                	mov    %eax,%ebx
80105cfe:	e8 ed b9 ff ff       	call   801016f0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80105d03:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105d06:	89 44 24 08          	mov    %eax,0x8(%esp)
80105d0a:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105d0e:	89 1c 24             	mov    %ebx,(%esp)
80105d11:	e8 5a bf ff ff       	call   80101c70 <dirlookup>
80105d16:	85 c0                	test   %eax,%eax
80105d18:	89 c6                	mov    %eax,%esi
80105d1a:	74 34                	je     80105d50 <create+0x90>
    iunlockput(dp);
80105d1c:	89 1c 24             	mov    %ebx,(%esp)
80105d1f:	e8 5c bc ff ff       	call   80101980 <iunlockput>
    ilock(ip);
80105d24:	89 34 24             	mov    %esi,(%esp)
80105d27:	e8 c4 b9 ff ff       	call   801016f0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105d2c:	83 7d c4 02          	cmpl   $0x2,-0x3c(%ebp)
80105d30:	0f 85 9a 00 00 00    	jne    80105dd0 <create+0x110>
80105d36:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80105d3b:	0f 85 8f 00 00 00    	jne    80105dd0 <create+0x110>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105d41:	89 f0                	mov    %esi,%eax
80105d43:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105d46:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105d49:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105d4c:	89 ec                	mov    %ebp,%esp
80105d4e:	5d                   	pop    %ebp
80105d4f:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80105d50:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80105d53:	89 44 24 04          	mov    %eax,0x4(%esp)
80105d57:	8b 03                	mov    (%ebx),%eax
80105d59:	89 04 24             	mov    %eax,(%esp)
80105d5c:	e8 0f b8 ff ff       	call   80101570 <ialloc>
80105d61:	85 c0                	test   %eax,%eax
80105d63:	89 c6                	mov    %eax,%esi
80105d65:	0f 84 f0 00 00 00    	je     80105e5b <create+0x19b>
  ilock(ip);
80105d6b:	89 04 24             	mov    %eax,(%esp)
80105d6e:	e8 7d b9 ff ff       	call   801016f0 <ilock>
  ip->major = major;
80105d73:	8b 45 c0             	mov    -0x40(%ebp),%eax
  ip->nlink = 1;
80105d76:	66 c7 46 56 01 00    	movw   $0x1,0x56(%esi)
  ip->major = major;
80105d7c:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80105d80:	8b 45 bc             	mov    -0x44(%ebp),%eax
80105d83:	66 89 46 54          	mov    %ax,0x54(%esi)
  iupdate(ip);
80105d87:	89 34 24             	mov    %esi,(%esp)
80105d8a:	e8 a1 b8 ff ff       	call   80101630 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105d8f:	83 7d c4 01          	cmpl   $0x1,-0x3c(%ebp)
80105d93:	74 5b                	je     80105df0 <create+0x130>
  if(dirlink(dp, name, ip->inum) < 0)
80105d95:	8b 46 04             	mov    0x4(%esi),%eax
80105d98:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105d9c:	89 1c 24             	mov    %ebx,(%esp)
80105d9f:	89 44 24 08          	mov    %eax,0x8(%esp)
80105da3:	e8 48 c1 ff ff       	call   80101ef0 <dirlink>
80105da8:	85 c0                	test   %eax,%eax
80105daa:	0f 88 9f 00 00 00    	js     80105e4f <create+0x18f>
  iunlockput(dp);
80105db0:	89 1c 24             	mov    %ebx,(%esp)
80105db3:	e8 c8 bb ff ff       	call   80101980 <iunlockput>
}
80105db8:	89 f0                	mov    %esi,%eax
80105dba:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105dbd:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105dc0:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105dc3:	89 ec                	mov    %ebp,%esp
80105dc5:	5d                   	pop    %ebp
80105dc6:	c3                   	ret    
80105dc7:	89 f6                	mov    %esi,%esi
80105dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105dd0:	89 34 24             	mov    %esi,(%esp)
    return 0;
80105dd3:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80105dd5:	e8 a6 bb ff ff       	call   80101980 <iunlockput>
}
80105dda:	89 f0                	mov    %esi,%eax
80105ddc:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105ddf:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105de2:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105de5:	89 ec                	mov    %ebp,%esp
80105de7:	5d                   	pop    %ebp
80105de8:	c3                   	ret    
80105de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80105df0:	66 ff 43 56          	incw   0x56(%ebx)
    iupdate(dp);
80105df4:	89 1c 24             	mov    %ebx,(%esp)
80105df7:	e8 34 b8 ff ff       	call   80101630 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105dfc:	8b 46 04             	mov    0x4(%esi),%eax
80105dff:	ba 00 8c 10 80       	mov    $0x80108c00,%edx
80105e04:	89 54 24 04          	mov    %edx,0x4(%esp)
80105e08:	89 34 24             	mov    %esi,(%esp)
80105e0b:	89 44 24 08          	mov    %eax,0x8(%esp)
80105e0f:	e8 dc c0 ff ff       	call   80101ef0 <dirlink>
80105e14:	85 c0                	test   %eax,%eax
80105e16:	78 20                	js     80105e38 <create+0x178>
80105e18:	8b 43 04             	mov    0x4(%ebx),%eax
80105e1b:	89 34 24             	mov    %esi,(%esp)
80105e1e:	89 44 24 08          	mov    %eax,0x8(%esp)
80105e22:	b8 ff 8b 10 80       	mov    $0x80108bff,%eax
80105e27:	89 44 24 04          	mov    %eax,0x4(%esp)
80105e2b:	e8 c0 c0 ff ff       	call   80101ef0 <dirlink>
80105e30:	85 c0                	test   %eax,%eax
80105e32:	0f 89 5d ff ff ff    	jns    80105d95 <create+0xd5>
      panic("create dots");
80105e38:	c7 04 24 f3 8b 10 80 	movl   $0x80108bf3,(%esp)
80105e3f:	e8 2c a5 ff ff       	call   80100370 <panic>
80105e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80105e48:	31 f6                	xor    %esi,%esi
80105e4a:	e9 f2 fe ff ff       	jmp    80105d41 <create+0x81>
    panic("create: dirlink");
80105e4f:	c7 04 24 02 8c 10 80 	movl   $0x80108c02,(%esp)
80105e56:	e8 15 a5 ff ff       	call   80100370 <panic>
    panic("create: ialloc");
80105e5b:	c7 04 24 e4 8b 10 80 	movl   $0x80108be4,(%esp)
80105e62:	e8 09 a5 ff ff       	call   80100370 <panic>
80105e67:	89 f6                	mov    %esi,%esi
80105e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e70 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80105e70:	55                   	push   %ebp
80105e71:	89 e5                	mov    %esp,%ebp
80105e73:	56                   	push   %esi
80105e74:	89 d6                	mov    %edx,%esi
80105e76:	53                   	push   %ebx
80105e77:	89 c3                	mov    %eax,%ebx
80105e79:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
80105e7c:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e7f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105e83:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105e8a:	e8 d1 fc ff ff       	call   80105b60 <argint>
80105e8f:	85 c0                	test   %eax,%eax
80105e91:	78 2d                	js     80105ec0 <argfd.constprop.0+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105e93:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105e97:	77 27                	ja     80105ec0 <argfd.constprop.0+0x50>
80105e99:	e8 e2 da ff ff       	call   80103980 <myproc>
80105e9e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105ea1:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80105ea5:	85 c0                	test   %eax,%eax
80105ea7:	74 17                	je     80105ec0 <argfd.constprop.0+0x50>
  if(pfd)
80105ea9:	85 db                	test   %ebx,%ebx
80105eab:	74 02                	je     80105eaf <argfd.constprop.0+0x3f>
    *pfd = fd;
80105ead:	89 13                	mov    %edx,(%ebx)
    *pf = f;
80105eaf:	89 06                	mov    %eax,(%esi)
  return 0;
80105eb1:	31 c0                	xor    %eax,%eax
}
80105eb3:	83 c4 20             	add    $0x20,%esp
80105eb6:	5b                   	pop    %ebx
80105eb7:	5e                   	pop    %esi
80105eb8:	5d                   	pop    %ebp
80105eb9:	c3                   	ret    
80105eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105ec0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ec5:	eb ec                	jmp    80105eb3 <argfd.constprop.0+0x43>
80105ec7:	89 f6                	mov    %esi,%esi
80105ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ed0 <sys_dup>:
{
80105ed0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80105ed1:	31 c0                	xor    %eax,%eax
{
80105ed3:	89 e5                	mov    %esp,%ebp
80105ed5:	56                   	push   %esi
80105ed6:	53                   	push   %ebx
80105ed7:	83 ec 20             	sub    $0x20,%esp
  if(argfd(0, 0, &f) < 0)
80105eda:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105edd:	e8 8e ff ff ff       	call   80105e70 <argfd.constprop.0>
80105ee2:	85 c0                	test   %eax,%eax
80105ee4:	78 3a                	js     80105f20 <sys_dup+0x50>
  if((fd=fdalloc(f)) < 0)
80105ee6:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105ee9:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105eeb:	e8 90 da ff ff       	call   80103980 <myproc>
80105ef0:	eb 0c                	jmp    80105efe <sys_dup+0x2e>
80105ef2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105ef8:	43                   	inc    %ebx
80105ef9:	83 fb 10             	cmp    $0x10,%ebx
80105efc:	74 22                	je     80105f20 <sys_dup+0x50>
    if(curproc->ofile[fd] == 0){
80105efe:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105f02:	85 d2                	test   %edx,%edx
80105f04:	75 f2                	jne    80105ef8 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80105f06:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105f0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f0d:	89 04 24             	mov    %eax,(%esp)
80105f10:	e8 cb ae ff ff       	call   80100de0 <filedup>
}
80105f15:	83 c4 20             	add    $0x20,%esp
80105f18:	89 d8                	mov    %ebx,%eax
80105f1a:	5b                   	pop    %ebx
80105f1b:	5e                   	pop    %esi
80105f1c:	5d                   	pop    %ebp
80105f1d:	c3                   	ret    
80105f1e:	66 90                	xchg   %ax,%ax
80105f20:	83 c4 20             	add    $0x20,%esp
    return -1;
80105f23:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105f28:	89 d8                	mov    %ebx,%eax
80105f2a:	5b                   	pop    %ebx
80105f2b:	5e                   	pop    %esi
80105f2c:	5d                   	pop    %ebp
80105f2d:	c3                   	ret    
80105f2e:	66 90                	xchg   %ax,%ax

80105f30 <sys_read>:
{
80105f30:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105f31:	31 c0                	xor    %eax,%eax
{
80105f33:	89 e5                	mov    %esp,%ebp
80105f35:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105f38:	8d 55 ec             	lea    -0x14(%ebp),%edx
80105f3b:	e8 30 ff ff ff       	call   80105e70 <argfd.constprop.0>
80105f40:	85 c0                	test   %eax,%eax
80105f42:	78 54                	js     80105f98 <sys_read+0x68>
80105f44:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105f47:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f4b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80105f52:	e8 09 fc ff ff       	call   80105b60 <argint>
80105f57:	85 c0                	test   %eax,%eax
80105f59:	78 3d                	js     80105f98 <sys_read+0x68>
80105f5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f5e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105f65:	89 44 24 08          	mov    %eax,0x8(%esp)
80105f69:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f6c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f70:	e8 3b fc ff ff       	call   80105bb0 <argptr>
80105f75:	85 c0                	test   %eax,%eax
80105f77:	78 1f                	js     80105f98 <sys_read+0x68>
  return fileread(f, p, n);
80105f79:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f7c:	89 44 24 08          	mov    %eax,0x8(%esp)
80105f80:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f83:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f87:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105f8a:	89 04 24             	mov    %eax,(%esp)
80105f8d:	e8 ce af ff ff       	call   80100f60 <fileread>
}
80105f92:	c9                   	leave  
80105f93:	c3                   	ret    
80105f94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105f98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f9d:	c9                   	leave  
80105f9e:	c3                   	ret    
80105f9f:	90                   	nop

80105fa0 <sys_write>:
{
80105fa0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105fa1:	31 c0                	xor    %eax,%eax
{
80105fa3:	89 e5                	mov    %esp,%ebp
80105fa5:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105fa8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80105fab:	e8 c0 fe ff ff       	call   80105e70 <argfd.constprop.0>
80105fb0:	85 c0                	test   %eax,%eax
80105fb2:	78 54                	js     80106008 <sys_write+0x68>
80105fb4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105fb7:	89 44 24 04          	mov    %eax,0x4(%esp)
80105fbb:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80105fc2:	e8 99 fb ff ff       	call   80105b60 <argint>
80105fc7:	85 c0                	test   %eax,%eax
80105fc9:	78 3d                	js     80106008 <sys_write+0x68>
80105fcb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fce:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105fd5:	89 44 24 08          	mov    %eax,0x8(%esp)
80105fd9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105fdc:	89 44 24 04          	mov    %eax,0x4(%esp)
80105fe0:	e8 cb fb ff ff       	call   80105bb0 <argptr>
80105fe5:	85 c0                	test   %eax,%eax
80105fe7:	78 1f                	js     80106008 <sys_write+0x68>
  return filewrite(f, p, n);
80105fe9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fec:	89 44 24 08          	mov    %eax,0x8(%esp)
80105ff0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ff3:	89 44 24 04          	mov    %eax,0x4(%esp)
80105ff7:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105ffa:	89 04 24             	mov    %eax,(%esp)
80105ffd:	e8 0e b0 ff ff       	call   80101010 <filewrite>
}
80106002:	c9                   	leave  
80106003:	c3                   	ret    
80106004:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106008:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010600d:	c9                   	leave  
8010600e:	c3                   	ret    
8010600f:	90                   	nop

80106010 <sys_close>:
{
80106010:	55                   	push   %ebp
80106011:	89 e5                	mov    %esp,%ebp
80106013:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, &fd, &f) < 0)
80106016:	8d 55 f4             	lea    -0xc(%ebp),%edx
80106019:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010601c:	e8 4f fe ff ff       	call   80105e70 <argfd.constprop.0>
80106021:	85 c0                	test   %eax,%eax
80106023:	78 23                	js     80106048 <sys_close+0x38>
  myproc()->ofile[fd] = 0;
80106025:	e8 56 d9 ff ff       	call   80103980 <myproc>
8010602a:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010602d:	31 c9                	xor    %ecx,%ecx
8010602f:	89 4c 90 28          	mov    %ecx,0x28(%eax,%edx,4)
  fileclose(f);
80106033:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106036:	89 04 24             	mov    %eax,(%esp)
80106039:	e8 f2 ad ff ff       	call   80100e30 <fileclose>
  return 0;
8010603e:	31 c0                	xor    %eax,%eax
}
80106040:	c9                   	leave  
80106041:	c3                   	ret    
80106042:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106048:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010604d:	c9                   	leave  
8010604e:	c3                   	ret    
8010604f:	90                   	nop

80106050 <sys_fstat>:
{
80106050:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80106051:	31 c0                	xor    %eax,%eax
{
80106053:	89 e5                	mov    %esp,%ebp
80106055:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80106058:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010605b:	e8 10 fe ff ff       	call   80105e70 <argfd.constprop.0>
80106060:	85 c0                	test   %eax,%eax
80106062:	78 3c                	js     801060a0 <sys_fstat+0x50>
80106064:	b8 14 00 00 00       	mov    $0x14,%eax
80106069:	89 44 24 08          	mov    %eax,0x8(%esp)
8010606d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106070:	89 44 24 04          	mov    %eax,0x4(%esp)
80106074:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010607b:	e8 30 fb ff ff       	call   80105bb0 <argptr>
80106080:	85 c0                	test   %eax,%eax
80106082:	78 1c                	js     801060a0 <sys_fstat+0x50>
  return filestat(f, st);
80106084:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106087:	89 44 24 04          	mov    %eax,0x4(%esp)
8010608b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010608e:	89 04 24             	mov    %eax,(%esp)
80106091:	e8 7a ae ff ff       	call   80100f10 <filestat>
}
80106096:	c9                   	leave  
80106097:	c3                   	ret    
80106098:	90                   	nop
80106099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801060a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801060a5:	c9                   	leave  
801060a6:	c3                   	ret    
801060a7:	89 f6                	mov    %esi,%esi
801060a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801060b0 <sys_link>:
{
801060b0:	55                   	push   %ebp
801060b1:	89 e5                	mov    %esp,%ebp
801060b3:	57                   	push   %edi
801060b4:	56                   	push   %esi
801060b5:	53                   	push   %ebx
801060b6:	83 ec 3c             	sub    $0x3c,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801060b9:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801060bc:	89 44 24 04          	mov    %eax,0x4(%esp)
801060c0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801060c7:	e8 44 fb ff ff       	call   80105c10 <argstr>
801060cc:	85 c0                	test   %eax,%eax
801060ce:	0f 88 e5 00 00 00    	js     801061b9 <sys_link+0x109>
801060d4:	8d 45 d0             	lea    -0x30(%ebp),%eax
801060d7:	89 44 24 04          	mov    %eax,0x4(%esp)
801060db:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801060e2:	e8 29 fb ff ff       	call   80105c10 <argstr>
801060e7:	85 c0                	test   %eax,%eax
801060e9:	0f 88 ca 00 00 00    	js     801061b9 <sys_link+0x109>
  begin_op();
801060ef:	e8 9c cb ff ff       	call   80102c90 <begin_op>
  if((ip = namei(old)) == 0){
801060f4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801060f7:	89 04 24             	mov    %eax,(%esp)
801060fa:	e8 d1 be ff ff       	call   80101fd0 <namei>
801060ff:	85 c0                	test   %eax,%eax
80106101:	89 c3                	mov    %eax,%ebx
80106103:	0f 84 ab 00 00 00    	je     801061b4 <sys_link+0x104>
  ilock(ip);
80106109:	89 04 24             	mov    %eax,(%esp)
8010610c:	e8 df b5 ff ff       	call   801016f0 <ilock>
  if(ip->type == T_DIR){
80106111:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106116:	0f 84 90 00 00 00    	je     801061ac <sys_link+0xfc>
  ip->nlink++;
8010611c:	66 ff 43 56          	incw   0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80106120:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80106123:	89 1c 24             	mov    %ebx,(%esp)
80106126:	e8 05 b5 ff ff       	call   80101630 <iupdate>
  iunlock(ip);
8010612b:	89 1c 24             	mov    %ebx,(%esp)
8010612e:	e8 9d b6 ff ff       	call   801017d0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80106133:	8b 45 d0             	mov    -0x30(%ebp),%eax
80106136:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010613a:	89 04 24             	mov    %eax,(%esp)
8010613d:	e8 ae be ff ff       	call   80101ff0 <nameiparent>
80106142:	85 c0                	test   %eax,%eax
80106144:	89 c6                	mov    %eax,%esi
80106146:	74 50                	je     80106198 <sys_link+0xe8>
  ilock(dp);
80106148:	89 04 24             	mov    %eax,(%esp)
8010614b:	e8 a0 b5 ff ff       	call   801016f0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80106150:	8b 03                	mov    (%ebx),%eax
80106152:	39 06                	cmp    %eax,(%esi)
80106154:	75 3a                	jne    80106190 <sys_link+0xe0>
80106156:	8b 43 04             	mov    0x4(%ebx),%eax
80106159:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010615d:	89 34 24             	mov    %esi,(%esp)
80106160:	89 44 24 08          	mov    %eax,0x8(%esp)
80106164:	e8 87 bd ff ff       	call   80101ef0 <dirlink>
80106169:	85 c0                	test   %eax,%eax
8010616b:	78 23                	js     80106190 <sys_link+0xe0>
  iunlockput(dp);
8010616d:	89 34 24             	mov    %esi,(%esp)
80106170:	e8 0b b8 ff ff       	call   80101980 <iunlockput>
  iput(ip);
80106175:	89 1c 24             	mov    %ebx,(%esp)
80106178:	e8 a3 b6 ff ff       	call   80101820 <iput>
  end_op();
8010617d:	e8 7e cb ff ff       	call   80102d00 <end_op>
}
80106182:	83 c4 3c             	add    $0x3c,%esp
  return 0;
80106185:	31 c0                	xor    %eax,%eax
}
80106187:	5b                   	pop    %ebx
80106188:	5e                   	pop    %esi
80106189:	5f                   	pop    %edi
8010618a:	5d                   	pop    %ebp
8010618b:	c3                   	ret    
8010618c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(dp);
80106190:	89 34 24             	mov    %esi,(%esp)
80106193:	e8 e8 b7 ff ff       	call   80101980 <iunlockput>
  ilock(ip);
80106198:	89 1c 24             	mov    %ebx,(%esp)
8010619b:	e8 50 b5 ff ff       	call   801016f0 <ilock>
  ip->nlink--;
801061a0:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
801061a4:	89 1c 24             	mov    %ebx,(%esp)
801061a7:	e8 84 b4 ff ff       	call   80101630 <iupdate>
  iunlockput(ip);
801061ac:	89 1c 24             	mov    %ebx,(%esp)
801061af:	e8 cc b7 ff ff       	call   80101980 <iunlockput>
  end_op();
801061b4:	e8 47 cb ff ff       	call   80102d00 <end_op>
}
801061b9:	83 c4 3c             	add    $0x3c,%esp
  return -1;
801061bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801061c1:	5b                   	pop    %ebx
801061c2:	5e                   	pop    %esi
801061c3:	5f                   	pop    %edi
801061c4:	5d                   	pop    %ebp
801061c5:	c3                   	ret    
801061c6:	8d 76 00             	lea    0x0(%esi),%esi
801061c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801061d0 <sys_unlink>:
{
801061d0:	55                   	push   %ebp
801061d1:	89 e5                	mov    %esp,%ebp
801061d3:	57                   	push   %edi
801061d4:	56                   	push   %esi
801061d5:	53                   	push   %ebx
801061d6:	83 ec 5c             	sub    $0x5c,%esp
  if(argstr(0, &path) < 0)
801061d9:	8d 45 c0             	lea    -0x40(%ebp),%eax
801061dc:	89 44 24 04          	mov    %eax,0x4(%esp)
801061e0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801061e7:	e8 24 fa ff ff       	call   80105c10 <argstr>
801061ec:	85 c0                	test   %eax,%eax
801061ee:	0f 88 68 01 00 00    	js     8010635c <sys_unlink+0x18c>
  begin_op();
801061f4:	e8 97 ca ff ff       	call   80102c90 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801061f9:	8b 45 c0             	mov    -0x40(%ebp),%eax
801061fc:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801061ff:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80106203:	89 04 24             	mov    %eax,(%esp)
80106206:	e8 e5 bd ff ff       	call   80101ff0 <nameiparent>
8010620b:	85 c0                	test   %eax,%eax
8010620d:	89 c6                	mov    %eax,%esi
8010620f:	0f 84 42 01 00 00    	je     80106357 <sys_unlink+0x187>
  ilock(dp);
80106215:	89 04 24             	mov    %eax,(%esp)
80106218:	e8 d3 b4 ff ff       	call   801016f0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010621d:	b8 00 8c 10 80       	mov    $0x80108c00,%eax
80106222:	89 44 24 04          	mov    %eax,0x4(%esp)
80106226:	89 1c 24             	mov    %ebx,(%esp)
80106229:	e8 12 ba ff ff       	call   80101c40 <namecmp>
8010622e:	85 c0                	test   %eax,%eax
80106230:	0f 84 19 01 00 00    	je     8010634f <sys_unlink+0x17f>
80106236:	b8 ff 8b 10 80       	mov    $0x80108bff,%eax
8010623b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010623f:	89 1c 24             	mov    %ebx,(%esp)
80106242:	e8 f9 b9 ff ff       	call   80101c40 <namecmp>
80106247:	85 c0                	test   %eax,%eax
80106249:	0f 84 00 01 00 00    	je     8010634f <sys_unlink+0x17f>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010624f:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80106252:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80106256:	89 44 24 08          	mov    %eax,0x8(%esp)
8010625a:	89 34 24             	mov    %esi,(%esp)
8010625d:	e8 0e ba ff ff       	call   80101c70 <dirlookup>
80106262:	85 c0                	test   %eax,%eax
80106264:	89 c3                	mov    %eax,%ebx
80106266:	0f 84 e3 00 00 00    	je     8010634f <sys_unlink+0x17f>
  ilock(ip);
8010626c:	89 04 24             	mov    %eax,(%esp)
8010626f:	e8 7c b4 ff ff       	call   801016f0 <ilock>
  if(ip->nlink < 1)
80106274:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80106279:	0f 8e 0e 01 00 00    	jle    8010638d <sys_unlink+0x1bd>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010627f:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106284:	8d 7d d8             	lea    -0x28(%ebp),%edi
80106287:	74 77                	je     80106300 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
80106289:	31 d2                	xor    %edx,%edx
8010628b:	b8 10 00 00 00       	mov    $0x10,%eax
80106290:	89 54 24 04          	mov    %edx,0x4(%esp)
80106294:	89 44 24 08          	mov    %eax,0x8(%esp)
80106298:	89 3c 24             	mov    %edi,(%esp)
8010629b:	e8 d0 f5 ff ff       	call   80105870 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801062a0:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801062a3:	b9 10 00 00 00       	mov    $0x10,%ecx
801062a8:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
801062ac:	89 7c 24 04          	mov    %edi,0x4(%esp)
801062b0:	89 34 24             	mov    %esi,(%esp)
801062b3:	89 44 24 08          	mov    %eax,0x8(%esp)
801062b7:	e8 34 b8 ff ff       	call   80101af0 <writei>
801062bc:	83 f8 10             	cmp    $0x10,%eax
801062bf:	0f 85 d4 00 00 00    	jne    80106399 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
801062c5:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801062ca:	0f 84 a0 00 00 00    	je     80106370 <sys_unlink+0x1a0>
  iunlockput(dp);
801062d0:	89 34 24             	mov    %esi,(%esp)
801062d3:	e8 a8 b6 ff ff       	call   80101980 <iunlockput>
  ip->nlink--;
801062d8:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
801062dc:	89 1c 24             	mov    %ebx,(%esp)
801062df:	e8 4c b3 ff ff       	call   80101630 <iupdate>
  iunlockput(ip);
801062e4:	89 1c 24             	mov    %ebx,(%esp)
801062e7:	e8 94 b6 ff ff       	call   80101980 <iunlockput>
  end_op();
801062ec:	e8 0f ca ff ff       	call   80102d00 <end_op>
}
801062f1:	83 c4 5c             	add    $0x5c,%esp
  return 0;
801062f4:	31 c0                	xor    %eax,%eax
}
801062f6:	5b                   	pop    %ebx
801062f7:	5e                   	pop    %esi
801062f8:	5f                   	pop    %edi
801062f9:	5d                   	pop    %ebp
801062fa:	c3                   	ret    
801062fb:	90                   	nop
801062fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80106300:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80106304:	76 83                	jbe    80106289 <sys_unlink+0xb9>
80106306:	ba 20 00 00 00       	mov    $0x20,%edx
8010630b:	eb 0f                	jmp    8010631c <sys_unlink+0x14c>
8010630d:	8d 76 00             	lea    0x0(%esi),%esi
80106310:	83 c2 10             	add    $0x10,%edx
80106313:	3b 53 58             	cmp    0x58(%ebx),%edx
80106316:	0f 83 6d ff ff ff    	jae    80106289 <sys_unlink+0xb9>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010631c:	b8 10 00 00 00       	mov    $0x10,%eax
80106321:	89 54 24 08          	mov    %edx,0x8(%esp)
80106325:	89 44 24 0c          	mov    %eax,0xc(%esp)
80106329:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010632d:	89 1c 24             	mov    %ebx,(%esp)
80106330:	89 55 b4             	mov    %edx,-0x4c(%ebp)
80106333:	e8 98 b6 ff ff       	call   801019d0 <readi>
80106338:	8b 55 b4             	mov    -0x4c(%ebp),%edx
8010633b:	83 f8 10             	cmp    $0x10,%eax
8010633e:	75 41                	jne    80106381 <sys_unlink+0x1b1>
    if(de.inum != 0)
80106340:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80106345:	74 c9                	je     80106310 <sys_unlink+0x140>
    iunlockput(ip);
80106347:	89 1c 24             	mov    %ebx,(%esp)
8010634a:	e8 31 b6 ff ff       	call   80101980 <iunlockput>
  iunlockput(dp);
8010634f:	89 34 24             	mov    %esi,(%esp)
80106352:	e8 29 b6 ff ff       	call   80101980 <iunlockput>
  end_op();
80106357:	e8 a4 c9 ff ff       	call   80102d00 <end_op>
}
8010635c:	83 c4 5c             	add    $0x5c,%esp
  return -1;
8010635f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106364:	5b                   	pop    %ebx
80106365:	5e                   	pop    %esi
80106366:	5f                   	pop    %edi
80106367:	5d                   	pop    %ebp
80106368:	c3                   	ret    
80106369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80106370:	66 ff 4e 56          	decw   0x56(%esi)
    iupdate(dp);
80106374:	89 34 24             	mov    %esi,(%esp)
80106377:	e8 b4 b2 ff ff       	call   80101630 <iupdate>
8010637c:	e9 4f ff ff ff       	jmp    801062d0 <sys_unlink+0x100>
      panic("isdirempty: readi");
80106381:	c7 04 24 24 8c 10 80 	movl   $0x80108c24,(%esp)
80106388:	e8 e3 9f ff ff       	call   80100370 <panic>
    panic("unlink: nlink < 1");
8010638d:	c7 04 24 12 8c 10 80 	movl   $0x80108c12,(%esp)
80106394:	e8 d7 9f ff ff       	call   80100370 <panic>
    panic("unlink: writei");
80106399:	c7 04 24 36 8c 10 80 	movl   $0x80108c36,(%esp)
801063a0:	e8 cb 9f ff ff       	call   80100370 <panic>
801063a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801063a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801063b0 <sys_open>:

int
sys_open(void)
{
801063b0:	55                   	push   %ebp
801063b1:	89 e5                	mov    %esp,%ebp
801063b3:	57                   	push   %edi
801063b4:	56                   	push   %esi
801063b5:	53                   	push   %ebx
801063b6:	83 ec 2c             	sub    $0x2c,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801063b9:	8d 45 e0             	lea    -0x20(%ebp),%eax
801063bc:	89 44 24 04          	mov    %eax,0x4(%esp)
801063c0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801063c7:	e8 44 f8 ff ff       	call   80105c10 <argstr>
801063cc:	85 c0                	test   %eax,%eax
801063ce:	0f 88 e9 00 00 00    	js     801064bd <sys_open+0x10d>
801063d4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801063d7:	89 44 24 04          	mov    %eax,0x4(%esp)
801063db:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801063e2:	e8 79 f7 ff ff       	call   80105b60 <argint>
801063e7:	85 c0                	test   %eax,%eax
801063e9:	0f 88 ce 00 00 00    	js     801064bd <sys_open+0x10d>
    return -1;

  begin_op();
801063ef:	e8 9c c8 ff ff       	call   80102c90 <begin_op>

  if(omode & O_CREATE){
801063f4:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801063f8:	0f 85 9a 00 00 00    	jne    80106498 <sys_open+0xe8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801063fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106401:	89 04 24             	mov    %eax,(%esp)
80106404:	e8 c7 bb ff ff       	call   80101fd0 <namei>
80106409:	85 c0                	test   %eax,%eax
8010640b:	89 c6                	mov    %eax,%esi
8010640d:	0f 84 a5 00 00 00    	je     801064b8 <sys_open+0x108>
      end_op();
      return -1;
    }
    ilock(ip);
80106413:	89 04 24             	mov    %eax,(%esp)
80106416:	e8 d5 b2 ff ff       	call   801016f0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
8010641b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80106420:	0f 84 a2 00 00 00    	je     801064c8 <sys_open+0x118>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80106426:	e8 45 a9 ff ff       	call   80100d70 <filealloc>
8010642b:	85 c0                	test   %eax,%eax
8010642d:	89 c7                	mov    %eax,%edi
8010642f:	0f 84 9e 00 00 00    	je     801064d3 <sys_open+0x123>
  struct proc *curproc = myproc();
80106435:	e8 46 d5 ff ff       	call   80103980 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010643a:	31 db                	xor    %ebx,%ebx
8010643c:	eb 0c                	jmp    8010644a <sys_open+0x9a>
8010643e:	66 90                	xchg   %ax,%ax
80106440:	43                   	inc    %ebx
80106441:	83 fb 10             	cmp    $0x10,%ebx
80106444:	0f 84 96 00 00 00    	je     801064e0 <sys_open+0x130>
    if(curproc->ofile[fd] == 0){
8010644a:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
8010644e:	85 d2                	test   %edx,%edx
80106450:	75 ee                	jne    80106440 <sys_open+0x90>
      curproc->ofile[fd] = f;
80106452:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106456:	89 34 24             	mov    %esi,(%esp)
80106459:	e8 72 b3 ff ff       	call   801017d0 <iunlock>
  end_op();
8010645e:	e8 9d c8 ff ff       	call   80102d00 <end_op>

  f->type = FD_INODE;
80106463:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80106469:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->ip = ip;
8010646c:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
8010646f:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80106476:	89 d0                	mov    %edx,%eax
80106478:	f7 d0                	not    %eax
8010647a:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010647d:	f6 c2 03             	test   $0x3,%dl
  f->readable = !(omode & O_WRONLY);
80106480:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106483:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80106487:	83 c4 2c             	add    $0x2c,%esp
8010648a:	89 d8                	mov    %ebx,%eax
8010648c:	5b                   	pop    %ebx
8010648d:	5e                   	pop    %esi
8010648e:	5f                   	pop    %edi
8010648f:	5d                   	pop    %ebp
80106490:	c3                   	ret    
80106491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80106498:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010649b:	31 c9                	xor    %ecx,%ecx
8010649d:	ba 02 00 00 00       	mov    $0x2,%edx
801064a2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801064a9:	e8 12 f8 ff ff       	call   80105cc0 <create>
    if(ip == 0){
801064ae:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
801064b0:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801064b2:	0f 85 6e ff ff ff    	jne    80106426 <sys_open+0x76>
    end_op();
801064b8:	e8 43 c8 ff ff       	call   80102d00 <end_op>
    return -1;
801064bd:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801064c2:	eb c3                	jmp    80106487 <sys_open+0xd7>
801064c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
801064c8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801064cb:	85 c9                	test   %ecx,%ecx
801064cd:	0f 84 53 ff ff ff    	je     80106426 <sys_open+0x76>
    iunlockput(ip);
801064d3:	89 34 24             	mov    %esi,(%esp)
801064d6:	e8 a5 b4 ff ff       	call   80101980 <iunlockput>
801064db:	eb db                	jmp    801064b8 <sys_open+0x108>
801064dd:	8d 76 00             	lea    0x0(%esi),%esi
      fileclose(f);
801064e0:	89 3c 24             	mov    %edi,(%esp)
801064e3:	e8 48 a9 ff ff       	call   80100e30 <fileclose>
801064e8:	eb e9                	jmp    801064d3 <sys_open+0x123>
801064ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801064f0 <sys_mkdir>:

int
sys_mkdir(void)
{
801064f0:	55                   	push   %ebp
801064f1:	89 e5                	mov    %esp,%ebp
801064f3:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
801064f6:	e8 95 c7 ff ff       	call   80102c90 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801064fb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801064fe:	89 44 24 04          	mov    %eax,0x4(%esp)
80106502:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106509:	e8 02 f7 ff ff       	call   80105c10 <argstr>
8010650e:	85 c0                	test   %eax,%eax
80106510:	78 2e                	js     80106540 <sys_mkdir+0x50>
80106512:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106515:	31 c9                	xor    %ecx,%ecx
80106517:	ba 01 00 00 00       	mov    $0x1,%edx
8010651c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106523:	e8 98 f7 ff ff       	call   80105cc0 <create>
80106528:	85 c0                	test   %eax,%eax
8010652a:	74 14                	je     80106540 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010652c:	89 04 24             	mov    %eax,(%esp)
8010652f:	e8 4c b4 ff ff       	call   80101980 <iunlockput>
  end_op();
80106534:	e8 c7 c7 ff ff       	call   80102d00 <end_op>
  return 0;
80106539:	31 c0                	xor    %eax,%eax
}
8010653b:	c9                   	leave  
8010653c:	c3                   	ret    
8010653d:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
80106540:	e8 bb c7 ff ff       	call   80102d00 <end_op>
    return -1;
80106545:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010654a:	c9                   	leave  
8010654b:	c3                   	ret    
8010654c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106550 <sys_mknod>:

int
sys_mknod(void)
{
80106550:	55                   	push   %ebp
80106551:	89 e5                	mov    %esp,%ebp
80106553:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80106556:	e8 35 c7 ff ff       	call   80102c90 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010655b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010655e:	89 44 24 04          	mov    %eax,0x4(%esp)
80106562:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106569:	e8 a2 f6 ff ff       	call   80105c10 <argstr>
8010656e:	85 c0                	test   %eax,%eax
80106570:	78 5e                	js     801065d0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80106572:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106575:	89 44 24 04          	mov    %eax,0x4(%esp)
80106579:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106580:	e8 db f5 ff ff       	call   80105b60 <argint>
  if((argstr(0, &path)) < 0 ||
80106585:	85 c0                	test   %eax,%eax
80106587:	78 47                	js     801065d0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80106589:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010658c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106590:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106597:	e8 c4 f5 ff ff       	call   80105b60 <argint>
     argint(1, &major) < 0 ||
8010659c:	85 c0                	test   %eax,%eax
8010659e:	78 30                	js     801065d0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801065a0:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
801065a4:	ba 03 00 00 00       	mov    $0x3,%edx
     (ip = create(path, T_DEV, major, minor)) == 0){
801065a9:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801065ad:	89 04 24             	mov    %eax,(%esp)
     argint(2, &minor) < 0 ||
801065b0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801065b3:	e8 08 f7 ff ff       	call   80105cc0 <create>
801065b8:	85 c0                	test   %eax,%eax
801065ba:	74 14                	je     801065d0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801065bc:	89 04 24             	mov    %eax,(%esp)
801065bf:	e8 bc b3 ff ff       	call   80101980 <iunlockput>
  end_op();
801065c4:	e8 37 c7 ff ff       	call   80102d00 <end_op>
  return 0;
801065c9:	31 c0                	xor    %eax,%eax
}
801065cb:	c9                   	leave  
801065cc:	c3                   	ret    
801065cd:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
801065d0:	e8 2b c7 ff ff       	call   80102d00 <end_op>
    return -1;
801065d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801065da:	c9                   	leave  
801065db:	c3                   	ret    
801065dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801065e0 <sys_chdir>:

int
sys_chdir(void)
{
801065e0:	55                   	push   %ebp
801065e1:	89 e5                	mov    %esp,%ebp
801065e3:	56                   	push   %esi
801065e4:	53                   	push   %ebx
801065e5:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801065e8:	e8 93 d3 ff ff       	call   80103980 <myproc>
801065ed:	89 c6                	mov    %eax,%esi
  
  begin_op();
801065ef:	e8 9c c6 ff ff       	call   80102c90 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801065f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801065f7:	89 44 24 04          	mov    %eax,0x4(%esp)
801065fb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106602:	e8 09 f6 ff ff       	call   80105c10 <argstr>
80106607:	85 c0                	test   %eax,%eax
80106609:	78 4a                	js     80106655 <sys_chdir+0x75>
8010660b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010660e:	89 04 24             	mov    %eax,(%esp)
80106611:	e8 ba b9 ff ff       	call   80101fd0 <namei>
80106616:	85 c0                	test   %eax,%eax
80106618:	89 c3                	mov    %eax,%ebx
8010661a:	74 39                	je     80106655 <sys_chdir+0x75>
    end_op();
    return -1;
  }
  ilock(ip);
8010661c:	89 04 24             	mov    %eax,(%esp)
8010661f:	e8 cc b0 ff ff       	call   801016f0 <ilock>
  if(ip->type != T_DIR){
80106624:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
    iunlockput(ip);
80106629:	89 1c 24             	mov    %ebx,(%esp)
  if(ip->type != T_DIR){
8010662c:	75 22                	jne    80106650 <sys_chdir+0x70>
    end_op();
    return -1;
  }
  iunlock(ip);
8010662e:	e8 9d b1 ff ff       	call   801017d0 <iunlock>
  iput(curproc->cwd);
80106633:	8b 46 68             	mov    0x68(%esi),%eax
80106636:	89 04 24             	mov    %eax,(%esp)
80106639:	e8 e2 b1 ff ff       	call   80101820 <iput>
  end_op();
8010663e:	e8 bd c6 ff ff       	call   80102d00 <end_op>
  curproc->cwd = ip;
  return 0;
80106643:	31 c0                	xor    %eax,%eax
  curproc->cwd = ip;
80106645:	89 5e 68             	mov    %ebx,0x68(%esi)
}
80106648:	83 c4 20             	add    $0x20,%esp
8010664b:	5b                   	pop    %ebx
8010664c:	5e                   	pop    %esi
8010664d:	5d                   	pop    %ebp
8010664e:	c3                   	ret    
8010664f:	90                   	nop
    iunlockput(ip);
80106650:	e8 2b b3 ff ff       	call   80101980 <iunlockput>
    end_op();
80106655:	e8 a6 c6 ff ff       	call   80102d00 <end_op>
    return -1;
8010665a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010665f:	eb e7                	jmp    80106648 <sys_chdir+0x68>
80106661:	eb 0d                	jmp    80106670 <sys_exec>
80106663:	90                   	nop
80106664:	90                   	nop
80106665:	90                   	nop
80106666:	90                   	nop
80106667:	90                   	nop
80106668:	90                   	nop
80106669:	90                   	nop
8010666a:	90                   	nop
8010666b:	90                   	nop
8010666c:	90                   	nop
8010666d:	90                   	nop
8010666e:	90                   	nop
8010666f:	90                   	nop

80106670 <sys_exec>:

int
sys_exec(void)
{
80106670:	55                   	push   %ebp
80106671:	89 e5                	mov    %esp,%ebp
80106673:	57                   	push   %edi
80106674:	56                   	push   %esi
80106675:	53                   	push   %ebx
80106676:	81 ec ac 00 00 00    	sub    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
8010667c:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80106682:	89 44 24 04          	mov    %eax,0x4(%esp)
80106686:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010668d:	e8 7e f5 ff ff       	call   80105c10 <argstr>
80106692:	85 c0                	test   %eax,%eax
80106694:	0f 88 8e 00 00 00    	js     80106728 <sys_exec+0xb8>
8010669a:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801066a0:	89 44 24 04          	mov    %eax,0x4(%esp)
801066a4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801066ab:	e8 b0 f4 ff ff       	call   80105b60 <argint>
801066b0:	85 c0                	test   %eax,%eax
801066b2:	78 74                	js     80106728 <sys_exec+0xb8>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801066b4:	ba 80 00 00 00       	mov    $0x80,%edx
801066b9:	31 c9                	xor    %ecx,%ecx
801066bb:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
801066c1:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801066c3:	89 54 24 08          	mov    %edx,0x8(%esp)
801066c7:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801066cd:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801066d1:	89 04 24             	mov    %eax,(%esp)
801066d4:	e8 97 f1 ff ff       	call   80105870 <memset>
801066d9:	eb 2e                	jmp    80106709 <sys_exec+0x99>
801066db:	90                   	nop
801066dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
801066e0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801066e6:	85 c0                	test   %eax,%eax
801066e8:	74 56                	je     80106740 <sys_exec+0xd0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801066ea:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
801066f0:	8d 14 31             	lea    (%ecx,%esi,1),%edx
801066f3:	89 54 24 04          	mov    %edx,0x4(%esp)
801066f7:	89 04 24             	mov    %eax,(%esp)
801066fa:	e8 01 f4 ff ff       	call   80105b00 <fetchstr>
801066ff:	85 c0                	test   %eax,%eax
80106701:	78 25                	js     80106728 <sys_exec+0xb8>
  for(i=0;; i++){
80106703:	43                   	inc    %ebx
    if(i >= NELEM(argv))
80106704:	83 fb 20             	cmp    $0x20,%ebx
80106707:	74 1f                	je     80106728 <sys_exec+0xb8>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106709:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
8010670f:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80106716:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010671a:	01 f0                	add    %esi,%eax
8010671c:	89 04 24             	mov    %eax,(%esp)
8010671f:	e8 9c f3 ff ff       	call   80105ac0 <fetchint>
80106724:	85 c0                	test   %eax,%eax
80106726:	79 b8                	jns    801066e0 <sys_exec+0x70>
      return -1;
  }
  return exec(path, argv);
}
80106728:	81 c4 ac 00 00 00    	add    $0xac,%esp
    return -1;
8010672e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106733:	5b                   	pop    %ebx
80106734:	5e                   	pop    %esi
80106735:	5f                   	pop    %edi
80106736:	5d                   	pop    %ebp
80106737:	c3                   	ret    
80106738:	90                   	nop
80106739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80106740:	31 c0                	xor    %eax,%eax
80106742:	89 84 9d 68 ff ff ff 	mov    %eax,-0x98(%ebp,%ebx,4)
  return exec(path, argv);
80106749:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010674f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106753:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
80106759:	89 04 24             	mov    %eax,(%esp)
8010675c:	e8 6f a2 ff ff       	call   801009d0 <exec>
}
80106761:	81 c4 ac 00 00 00    	add    $0xac,%esp
80106767:	5b                   	pop    %ebx
80106768:	5e                   	pop    %esi
80106769:	5f                   	pop    %edi
8010676a:	5d                   	pop    %ebp
8010676b:	c3                   	ret    
8010676c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106770 <sys_pipe>:

int
sys_pipe(void)
{
80106770:	55                   	push   %ebp
80106771:	89 e5                	mov    %esp,%ebp
80106773:	57                   	push   %edi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106774:	bf 08 00 00 00       	mov    $0x8,%edi
{
80106779:	56                   	push   %esi
8010677a:	53                   	push   %ebx
8010677b:	83 ec 2c             	sub    $0x2c,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010677e:	8d 45 dc             	lea    -0x24(%ebp),%eax
80106781:	89 7c 24 08          	mov    %edi,0x8(%esp)
80106785:	89 44 24 04          	mov    %eax,0x4(%esp)
80106789:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106790:	e8 1b f4 ff ff       	call   80105bb0 <argptr>
80106795:	85 c0                	test   %eax,%eax
80106797:	0f 88 a9 00 00 00    	js     80106846 <sys_pipe+0xd6>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010679d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801067a0:	89 44 24 04          	mov    %eax,0x4(%esp)
801067a4:	8d 45 e0             	lea    -0x20(%ebp),%eax
801067a7:	89 04 24             	mov    %eax,(%esp)
801067aa:	e8 11 cc ff ff       	call   801033c0 <pipealloc>
801067af:	85 c0                	test   %eax,%eax
801067b1:	0f 88 8f 00 00 00    	js     80106846 <sys_pipe+0xd6>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801067b7:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801067ba:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801067bc:	e8 bf d1 ff ff       	call   80103980 <myproc>
801067c1:	eb 0b                	jmp    801067ce <sys_pipe+0x5e>
801067c3:	90                   	nop
801067c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
801067c8:	43                   	inc    %ebx
801067c9:	83 fb 10             	cmp    $0x10,%ebx
801067cc:	74 62                	je     80106830 <sys_pipe+0xc0>
    if(curproc->ofile[fd] == 0){
801067ce:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801067d2:	85 f6                	test   %esi,%esi
801067d4:	75 f2                	jne    801067c8 <sys_pipe+0x58>
      curproc->ofile[fd] = f;
801067d6:	8d 73 08             	lea    0x8(%ebx),%esi
801067d9:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801067dd:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801067e0:	e8 9b d1 ff ff       	call   80103980 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801067e5:	31 d2                	xor    %edx,%edx
801067e7:	eb 0d                	jmp    801067f6 <sys_pipe+0x86>
801067e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801067f0:	42                   	inc    %edx
801067f1:	83 fa 10             	cmp    $0x10,%edx
801067f4:	74 2a                	je     80106820 <sys_pipe+0xb0>
    if(curproc->ofile[fd] == 0){
801067f6:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801067fa:	85 c9                	test   %ecx,%ecx
801067fc:	75 f2                	jne    801067f0 <sys_pipe+0x80>
      curproc->ofile[fd] = f;
801067fe:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80106802:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106805:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106807:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010680a:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
8010680d:	31 c0                	xor    %eax,%eax
}
8010680f:	83 c4 2c             	add    $0x2c,%esp
80106812:	5b                   	pop    %ebx
80106813:	5e                   	pop    %esi
80106814:	5f                   	pop    %edi
80106815:	5d                   	pop    %ebp
80106816:	c3                   	ret    
80106817:	89 f6                	mov    %esi,%esi
80106819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      myproc()->ofile[fd0] = 0;
80106820:	e8 5b d1 ff ff       	call   80103980 <myproc>
80106825:	31 d2                	xor    %edx,%edx
80106827:	89 54 b0 08          	mov    %edx,0x8(%eax,%esi,4)
8010682b:	90                   	nop
8010682c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fileclose(rf);
80106830:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106833:	89 04 24             	mov    %eax,(%esp)
80106836:	e8 f5 a5 ff ff       	call   80100e30 <fileclose>
    fileclose(wf);
8010683b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010683e:	89 04 24             	mov    %eax,(%esp)
80106841:	e8 ea a5 ff ff       	call   80100e30 <fileclose>
    return -1;
80106846:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010684b:	eb c2                	jmp    8010680f <sys_pipe+0x9f>
8010684d:	66 90                	xchg   %ax,%ax
8010684f:	90                   	nop

80106850 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106850:	55                   	push   %ebp
80106851:	89 e5                	mov    %esp,%ebp
  return fork();
}
80106853:	5d                   	pop    %ebp
  return fork();
80106854:	e9 e7 d3 ff ff       	jmp    80103c40 <fork>
80106859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106860 <sys_exit>:

int
sys_exit(void)
{
80106860:	55                   	push   %ebp
80106861:	89 e5                	mov    %esp,%ebp
80106863:	83 ec 28             	sub    $0x28,%esp
  int status;

  if(argint(0, &status) < 0)
80106866:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106869:	89 44 24 04          	mov    %eax,0x4(%esp)
8010686d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106874:	e8 e7 f2 ff ff       	call   80105b60 <argint>
80106879:	85 c0                	test   %eax,%eax
8010687b:	78 13                	js     80106890 <sys_exit+0x30>
    return -1;
  exit(status);
8010687d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106880:	89 04 24             	mov    %eax,(%esp)
80106883:	e8 48 d8 ff ff       	call   801040d0 <exit>
  return 0;  // not reached
80106888:	31 c0                	xor    %eax,%eax
}
8010688a:	c9                   	leave  
8010688b:	c3                   	ret    
8010688c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106890:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106895:	c9                   	leave  
80106896:	c3                   	ret    
80106897:	89 f6                	mov    %esi,%esi
80106899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801068a0 <sys_wait>:

int
sys_wait(void)
{
801068a0:	55                   	push   %ebp
  int *status;

  if(argptr(0, (char**)(&status), sizeof(int)) < 0)
801068a1:	b8 04 00 00 00       	mov    $0x4,%eax
{
801068a6:	89 e5                	mov    %esp,%ebp
801068a8:	83 ec 28             	sub    $0x28,%esp
  if(argptr(0, (char**)(&status), sizeof(int)) < 0)
801068ab:	89 44 24 08          	mov    %eax,0x8(%esp)
801068af:	8d 45 f4             	lea    -0xc(%ebp),%eax
801068b2:	89 44 24 04          	mov    %eax,0x4(%esp)
801068b6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801068bd:	e8 ee f2 ff ff       	call   80105bb0 <argptr>
801068c2:	85 c0                	test   %eax,%eax
801068c4:	78 12                	js     801068d8 <sys_wait+0x38>
    return -1;
  return wait(status);
801068c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801068c9:	89 04 24             	mov    %eax,(%esp)
801068cc:	e8 6f da ff ff       	call   80104340 <wait>
  //return wait();
}
801068d1:	c9                   	leave  
801068d2:	c3                   	ret    
801068d3:	90                   	nop
801068d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801068d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801068dd:	c9                   	leave  
801068de:	c3                   	ret    
801068df:	90                   	nop

801068e0 <sys_kill>:

int
sys_kill(void)
{
801068e0:	55                   	push   %ebp
801068e1:	89 e5                	mov    %esp,%ebp
801068e3:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
801068e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801068e9:	89 44 24 04          	mov    %eax,0x4(%esp)
801068ed:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801068f4:	e8 67 f2 ff ff       	call   80105b60 <argint>
801068f9:	85 c0                	test   %eax,%eax
801068fb:	78 13                	js     80106910 <sys_kill+0x30>
    return -1;
  return kill(pid);
801068fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106900:	89 04 24             	mov    %eax,(%esp)
80106903:	e8 78 db ff ff       	call   80104480 <kill>
}
80106908:	c9                   	leave  
80106909:	c3                   	ret    
8010690a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106910:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106915:	c9                   	leave  
80106916:	c3                   	ret    
80106917:	89 f6                	mov    %esi,%esi
80106919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106920 <sys_getpid>:

int
sys_getpid(void)
{
80106920:	55                   	push   %ebp
80106921:	89 e5                	mov    %esp,%ebp
80106923:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106926:	e8 55 d0 ff ff       	call   80103980 <myproc>
8010692b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010692e:	c9                   	leave  
8010692f:	c3                   	ret    

80106930 <sys_sbrk>:

int
sys_sbrk(void)
{
80106930:	55                   	push   %ebp
80106931:	89 e5                	mov    %esp,%ebp
80106933:	53                   	push   %ebx
80106934:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106937:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010693a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010693e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106945:	e8 16 f2 ff ff       	call   80105b60 <argint>
8010694a:	85 c0                	test   %eax,%eax
8010694c:	78 22                	js     80106970 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
8010694e:	e8 2d d0 ff ff       	call   80103980 <myproc>
80106953:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106955:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106958:	89 04 24             	mov    %eax,(%esp)
8010695b:	e8 80 d1 ff ff       	call   80103ae0 <growproc>
80106960:	85 c0                	test   %eax,%eax
80106962:	78 0c                	js     80106970 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106964:	83 c4 24             	add    $0x24,%esp
80106967:	89 d8                	mov    %ebx,%eax
80106969:	5b                   	pop    %ebx
8010696a:	5d                   	pop    %ebp
8010696b:	c3                   	ret    
8010696c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106970:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106975:	eb ed                	jmp    80106964 <sys_sbrk+0x34>
80106977:	89 f6                	mov    %esi,%esi
80106979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106980 <sys_sleep>:

int
sys_sleep(void)
{
80106980:	55                   	push   %ebp
80106981:	89 e5                	mov    %esp,%ebp
80106983:	53                   	push   %ebx
80106984:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106987:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010698a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010698e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106995:	e8 c6 f1 ff ff       	call   80105b60 <argint>
8010699a:	85 c0                	test   %eax,%eax
8010699c:	78 7e                	js     80106a1c <sys_sleep+0x9c>
    return -1;
  acquire(&tickslock);
8010699e:	c7 04 24 c0 60 11 80 	movl   $0x801160c0,(%esp)
801069a5:	e8 d6 ed ff ff       	call   80105780 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801069aa:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  ticks0 = ticks;
801069ad:	8b 1d 00 69 11 80    	mov    0x80116900,%ebx
  while(ticks - ticks0 < n){
801069b3:	85 c9                	test   %ecx,%ecx
801069b5:	75 2a                	jne    801069e1 <sys_sleep+0x61>
801069b7:	eb 4f                	jmp    80106a08 <sys_sleep+0x88>
801069b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801069c0:	b8 c0 60 11 80       	mov    $0x801160c0,%eax
801069c5:	89 44 24 04          	mov    %eax,0x4(%esp)
801069c9:	c7 04 24 00 69 11 80 	movl   $0x80116900,(%esp)
801069d0:	e8 9b d8 ff ff       	call   80104270 <sleep>
  while(ticks - ticks0 < n){
801069d5:	a1 00 69 11 80       	mov    0x80116900,%eax
801069da:	29 d8                	sub    %ebx,%eax
801069dc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801069df:	73 27                	jae    80106a08 <sys_sleep+0x88>
    if(myproc()->killed){
801069e1:	e8 9a cf ff ff       	call   80103980 <myproc>
801069e6:	8b 50 24             	mov    0x24(%eax),%edx
801069e9:	85 d2                	test   %edx,%edx
801069eb:	74 d3                	je     801069c0 <sys_sleep+0x40>
      release(&tickslock);
801069ed:	c7 04 24 c0 60 11 80 	movl   $0x801160c0,(%esp)
801069f4:	e8 27 ee ff ff       	call   80105820 <release>
  }
  release(&tickslock);
  return 0;
}
801069f9:	83 c4 24             	add    $0x24,%esp
      return -1;
801069fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106a01:	5b                   	pop    %ebx
80106a02:	5d                   	pop    %ebp
80106a03:	c3                   	ret    
80106a04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&tickslock);
80106a08:	c7 04 24 c0 60 11 80 	movl   $0x801160c0,(%esp)
80106a0f:	e8 0c ee ff ff       	call   80105820 <release>
  return 0;
80106a14:	31 c0                	xor    %eax,%eax
}
80106a16:	83 c4 24             	add    $0x24,%esp
80106a19:	5b                   	pop    %ebx
80106a1a:	5d                   	pop    %ebp
80106a1b:	c3                   	ret    
    return -1;
80106a1c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a21:	eb f3                	jmp    80106a16 <sys_sleep+0x96>
80106a23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a30 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106a30:	55                   	push   %ebp
80106a31:	89 e5                	mov    %esp,%ebp
80106a33:	53                   	push   %ebx
80106a34:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

  acquire(&tickslock);
80106a37:	c7 04 24 c0 60 11 80 	movl   $0x801160c0,(%esp)
80106a3e:	e8 3d ed ff ff       	call   80105780 <acquire>
  xticks = ticks;
80106a43:	8b 1d 00 69 11 80    	mov    0x80116900,%ebx
  release(&tickslock);
80106a49:	c7 04 24 c0 60 11 80 	movl   $0x801160c0,(%esp)
80106a50:	e8 cb ed ff ff       	call   80105820 <release>
  return xticks;
}
80106a55:	83 c4 14             	add    $0x14,%esp
80106a58:	89 d8                	mov    %ebx,%eax
80106a5a:	5b                   	pop    %ebx
80106a5b:	5d                   	pop    %ebp
80106a5c:	c3                   	ret    
80106a5d:	8d 76 00             	lea    0x0(%esi),%esi

80106a60 <sys_detach>:

// transfer a child process with the given pid from the parent to the init process.
// return 0 when succseeds or -1 if the process has no child with this pid.
int
sys_detach(void)
{
80106a60:	55                   	push   %ebp
80106a61:	89 e5                	mov    %esp,%ebp
80106a63:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106a66:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106a69:	89 44 24 04          	mov    %eax,0x4(%esp)
80106a6d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106a74:	e8 e7 f0 ff ff       	call   80105b60 <argint>
80106a79:	85 c0                	test   %eax,%eax
80106a7b:	78 13                	js     80106a90 <sys_detach+0x30>
    return -1;
  return detach(pid);
80106a7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a80:	89 04 24             	mov    %eax,(%esp)
80106a83:	e8 a8 da ff ff       	call   80104530 <detach>
}
80106a88:	c9                   	leave  
80106a89:	c3                   	ret    
80106a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106a90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106a95:	c9                   	leave  
80106a96:	c3                   	ret    
80106a97:	89 f6                	mov    %esi,%esi
80106a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106aa0 <sys_priority>:

//used by a process to change its priority
int
sys_priority(void)
{
80106aa0:	55                   	push   %ebp
80106aa1:	89 e5                	mov    %esp,%ebp
80106aa3:	83 ec 28             	sub    $0x28,%esp
  int proc_priority;

  if(argint(0, &proc_priority) < 0)
80106aa6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106aa9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106aad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106ab4:	e8 a7 f0 ff ff       	call   80105b60 <argint>
80106ab9:	85 c0                	test   %eax,%eax
80106abb:	78 13                	js     80106ad0 <sys_priority+0x30>
    return -1;
  priority(proc_priority);
80106abd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ac0:	89 04 24             	mov    %eax,(%esp)
80106ac3:	e8 18 db ff ff       	call   801045e0 <priority>
  return 0;
80106ac8:	31 c0                	xor    %eax,%eax
}
80106aca:	c9                   	leave  
80106acb:	c3                   	ret    
80106acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106ad0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ad5:	c9                   	leave  
80106ad6:	c3                   	ret    
80106ad7:	89 f6                	mov    %esi,%esi
80106ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ae0 <sys_policy>:

// receives a policy identifier as an argument and changes the currently used policy.
int
sys_policy(void)
{
80106ae0:	55                   	push   %ebp
80106ae1:	89 e5                	mov    %esp,%ebp
80106ae3:	83 ec 28             	sub    $0x28,%esp
  int policy_id;

  if(argint(0, &policy_id) < 0)
80106ae6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106ae9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106aed:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106af4:	e8 67 f0 ff ff       	call   80105b60 <argint>
80106af9:	85 c0                	test   %eax,%eax
80106afb:	78 13                	js     80106b10 <sys_policy+0x30>
    return -1;
  policy(policy_id);
80106afd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b00:	89 04 24             	mov    %eax,(%esp)
80106b03:	e8 58 db ff ff       	call   80104660 <policy>
  return 0;
80106b08:	31 c0                	xor    %eax,%eax
}
80106b0a:	c9                   	leave  
80106b0b:	c3                   	ret    
80106b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106b10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b15:	c9                   	leave  
80106b16:	c3                   	ret    

80106b17 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106b17:	1e                   	push   %ds
  pushl %es
80106b18:	06                   	push   %es
  pushl %fs
80106b19:	0f a0                	push   %fs
  pushl %gs
80106b1b:	0f a8                	push   %gs
  pushal
80106b1d:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106b1e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106b22:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106b24:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106b26:	54                   	push   %esp
  call trap
80106b27:	e8 c4 00 00 00       	call   80106bf0 <trap>
  addl $4, %esp
80106b2c:	83 c4 04             	add    $0x4,%esp

80106b2f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106b2f:	61                   	popa   
  popl %gs
80106b30:	0f a9                	pop    %gs
  popl %fs
80106b32:	0f a1                	pop    %fs
  popl %es
80106b34:	07                   	pop    %es
  popl %ds
80106b35:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106b36:	83 c4 08             	add    $0x8,%esp
  iret
80106b39:	cf                   	iret   
80106b3a:	66 90                	xchg   %ax,%ax
80106b3c:	66 90                	xchg   %ax,%ax
80106b3e:	66 90                	xchg   %ax,%ax

80106b40 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106b40:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106b41:	31 c0                	xor    %eax,%eax
{
80106b43:	89 e5                	mov    %esp,%ebp
80106b45:	83 ec 18             	sub    $0x18,%esp
80106b48:	90                   	nop
80106b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106b50:	8b 14 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%edx
80106b57:	b9 08 00 00 8e       	mov    $0x8e000008,%ecx
80106b5c:	89 0c c5 02 61 11 80 	mov    %ecx,-0x7fee9efe(,%eax,8)
80106b63:	66 89 14 c5 00 61 11 	mov    %dx,-0x7fee9f00(,%eax,8)
80106b6a:	80 
80106b6b:	c1 ea 10             	shr    $0x10,%edx
80106b6e:	66 89 14 c5 06 61 11 	mov    %dx,-0x7fee9efa(,%eax,8)
80106b75:	80 
  for(i = 0; i < 256; i++)
80106b76:	40                   	inc    %eax
80106b77:	3d 00 01 00 00       	cmp    $0x100,%eax
80106b7c:	75 d2                	jne    80106b50 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106b7e:	a1 0c b1 10 80       	mov    0x8010b10c,%eax

  initlock(&tickslock, "time");
80106b83:	b9 45 8c 10 80       	mov    $0x80108c45,%ecx
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106b88:	ba 08 00 00 ef       	mov    $0xef000008,%edx
  initlock(&tickslock, "time");
80106b8d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80106b91:	c7 04 24 c0 60 11 80 	movl   $0x801160c0,(%esp)
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106b98:	89 15 02 63 11 80    	mov    %edx,0x80116302
80106b9e:	66 a3 00 63 11 80    	mov    %ax,0x80116300
80106ba4:	c1 e8 10             	shr    $0x10,%eax
80106ba7:	66 a3 06 63 11 80    	mov    %ax,0x80116306
  initlock(&tickslock, "time");
80106bad:	e8 7e ea ff ff       	call   80105630 <initlock>
}
80106bb2:	c9                   	leave  
80106bb3:	c3                   	ret    
80106bb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106bba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106bc0 <idtinit>:

void
idtinit(void)
{
80106bc0:	55                   	push   %ebp
  pd[1] = (uint)p;
80106bc1:	b8 00 61 11 80       	mov    $0x80116100,%eax
80106bc6:	89 e5                	mov    %esp,%ebp
80106bc8:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
80106bcb:	c1 e8 10             	shr    $0x10,%eax
80106bce:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
80106bd1:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
80106bd7:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106bdb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80106bdf:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106be2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106be5:	c9                   	leave  
80106be6:	c3                   	ret    
80106be7:	89 f6                	mov    %esi,%esi
80106be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106bf0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106bf0:	55                   	push   %ebp
80106bf1:	89 e5                	mov    %esp,%ebp
80106bf3:	83 ec 48             	sub    $0x48,%esp
80106bf6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80106bf9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80106bfc:	89 75 f8             	mov    %esi,-0x8(%ebp)
80106bff:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(tf->trapno == T_SYSCALL){
80106c02:	8b 43 30             	mov    0x30(%ebx),%eax
80106c05:	83 f8 40             	cmp    $0x40,%eax
80106c08:	0f 84 02 01 00 00    	je     80106d10 <trap+0x120>
    if(myproc()->killed)
      exit(0);
    return;
  }

  switch(tf->trapno){
80106c0e:	83 e8 20             	sub    $0x20,%eax
80106c11:	83 f8 1f             	cmp    $0x1f,%eax
80106c14:	77 0a                	ja     80106c20 <trap+0x30>
80106c16:	ff 24 85 ec 8c 10 80 	jmp    *-0x7fef7314(,%eax,4)
80106c1d:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80106c20:	e8 5b cd ff ff       	call   80103980 <myproc>
80106c25:	8b 7b 38             	mov    0x38(%ebx),%edi
80106c28:	85 c0                	test   %eax,%eax
80106c2a:	0f 84 5f 02 00 00    	je     80106e8f <trap+0x29f>
80106c30:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106c34:	0f 84 55 02 00 00    	je     80106e8f <trap+0x29f>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106c3a:	0f 20 d1             	mov    %cr2,%ecx
80106c3d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106c40:	e8 1b cd ff ff       	call   80103960 <cpuid>
80106c45:	8b 73 30             	mov    0x30(%ebx),%esi
80106c48:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106c4b:	8b 43 34             	mov    0x34(%ebx),%eax
80106c4e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106c51:	e8 2a cd ff ff       	call   80103980 <myproc>
80106c56:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106c59:	e8 22 cd ff ff       	call   80103980 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106c5e:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106c61:	89 74 24 0c          	mov    %esi,0xc(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
80106c65:	8b 75 e0             	mov    -0x20(%ebp),%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106c68:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106c6b:	89 7c 24 18          	mov    %edi,0x18(%esp)
80106c6f:	89 54 24 14          	mov    %edx,0x14(%esp)
80106c73:	8b 55 e4             	mov    -0x1c(%ebp),%edx
            myproc()->pid, myproc()->name, tf->trapno,
80106c76:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106c79:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
80106c7d:	89 74 24 08          	mov    %esi,0x8(%esp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106c81:	89 54 24 10          	mov    %edx,0x10(%esp)
80106c85:	8b 40 10             	mov    0x10(%eax),%eax
80106c88:	c7 04 24 a8 8c 10 80 	movl   $0x80108ca8,(%esp)
80106c8f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106c93:	e8 b8 99 ff ff       	call   80100650 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80106c98:	e8 e3 cc ff ff       	call   80103980 <myproc>
80106c9d:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106ca4:	e8 d7 cc ff ff       	call   80103980 <myproc>
80106ca9:	85 c0                	test   %eax,%eax
80106cab:	74 1b                	je     80106cc8 <trap+0xd8>
80106cad:	e8 ce cc ff ff       	call   80103980 <myproc>
80106cb2:	8b 50 24             	mov    0x24(%eax),%edx
80106cb5:	85 d2                	test   %edx,%edx
80106cb7:	74 0f                	je     80106cc8 <trap+0xd8>
80106cb9:	8b 43 3c             	mov    0x3c(%ebx),%eax
80106cbc:	83 e0 03             	and    $0x3,%eax
80106cbf:	83 f8 03             	cmp    $0x3,%eax
80106cc2:	0f 84 80 01 00 00    	je     80106e48 <trap+0x258>
    exit(0);

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106cc8:	e8 b3 cc ff ff       	call   80103980 <myproc>
80106ccd:	85 c0                	test   %eax,%eax
80106ccf:	74 0d                	je     80106cde <trap+0xee>
80106cd1:	e8 aa cc ff ff       	call   80103980 <myproc>
80106cd6:	8b 40 0c             	mov    0xc(%eax),%eax
80106cd9:	83 f8 04             	cmp    $0x4,%eax
80106cdc:	74 7a                	je     80106d58 <trap+0x168>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106cde:	e8 9d cc ff ff       	call   80103980 <myproc>
80106ce3:	85 c0                	test   %eax,%eax
80106ce5:	74 17                	je     80106cfe <trap+0x10e>
80106ce7:	e8 94 cc ff ff       	call   80103980 <myproc>
80106cec:	8b 40 24             	mov    0x24(%eax),%eax
80106cef:	85 c0                	test   %eax,%eax
80106cf1:	74 0b                	je     80106cfe <trap+0x10e>
80106cf3:	8b 43 3c             	mov    0x3c(%ebx),%eax
80106cf6:	83 e0 03             	and    $0x3,%eax
80106cf9:	83 f8 03             	cmp    $0x3,%eax
80106cfc:	74 3b                	je     80106d39 <trap+0x149>
    exit(0);
}
80106cfe:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80106d01:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106d04:	8b 7d fc             	mov    -0x4(%ebp),%edi
80106d07:	89 ec                	mov    %ebp,%esp
80106d09:	5d                   	pop    %ebp
80106d0a:	c3                   	ret    
80106d0b:	90                   	nop
80106d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80106d10:	e8 6b cc ff ff       	call   80103980 <myproc>
80106d15:	8b 70 24             	mov    0x24(%eax),%esi
80106d18:	85 f6                	test   %esi,%esi
80106d1a:	0f 85 10 01 00 00    	jne    80106e30 <trap+0x240>
    myproc()->tf = tf;
80106d20:	e8 5b cc ff ff       	call   80103980 <myproc>
80106d25:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80106d28:	e8 23 ef ff ff       	call   80105c50 <syscall>
    if(myproc()->killed)
80106d2d:	e8 4e cc ff ff       	call   80103980 <myproc>
80106d32:	8b 48 24             	mov    0x24(%eax),%ecx
80106d35:	85 c9                	test   %ecx,%ecx
80106d37:	74 c5                	je     80106cfe <trap+0x10e>
      exit(0);
80106d39:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
}
80106d40:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80106d43:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106d46:	8b 7d fc             	mov    -0x4(%ebp),%edi
80106d49:	89 ec                	mov    %ebp,%esp
80106d4b:	5d                   	pop    %ebp
      exit(0);
80106d4c:	e9 7f d3 ff ff       	jmp    801040d0 <exit>
80106d51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(myproc() && myproc()->state == RUNNING &&
80106d58:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106d5c:	75 80                	jne    80106cde <trap+0xee>
    yield();
80106d5e:	e8 5d d4 ff ff       	call   801041c0 <yield>
80106d63:	e9 76 ff ff ff       	jmp    80106cde <trap+0xee>
80106d68:	90                   	nop
80106d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80106d70:	e8 eb cb ff ff       	call   80103960 <cpuid>
80106d75:	85 c0                	test   %eax,%eax
80106d77:	0f 84 e3 00 00 00    	je     80106e60 <trap+0x270>
80106d7d:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
80106d80:	e8 cb ba ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106d85:	e8 f6 cb ff ff       	call   80103980 <myproc>
80106d8a:	85 c0                	test   %eax,%eax
80106d8c:	0f 85 1b ff ff ff    	jne    80106cad <trap+0xbd>
80106d92:	e9 31 ff ff ff       	jmp    80106cc8 <trap+0xd8>
80106d97:	89 f6                	mov    %esi,%esi
80106d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    kbdintr();
80106da0:	e8 6b b9 ff ff       	call   80102710 <kbdintr>
    lapiceoi();
80106da5:	e8 a6 ba ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106daa:	e8 d1 cb ff ff       	call   80103980 <myproc>
80106daf:	85 c0                	test   %eax,%eax
80106db1:	0f 85 f6 fe ff ff    	jne    80106cad <trap+0xbd>
80106db7:	e9 0c ff ff ff       	jmp    80106cc8 <trap+0xd8>
80106dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106dc0:	e8 6b 02 00 00       	call   80107030 <uartintr>
    lapiceoi();
80106dc5:	e8 86 ba ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106dca:	e8 b1 cb ff ff       	call   80103980 <myproc>
80106dcf:	85 c0                	test   %eax,%eax
80106dd1:	0f 85 d6 fe ff ff    	jne    80106cad <trap+0xbd>
80106dd7:	e9 ec fe ff ff       	jmp    80106cc8 <trap+0xd8>
80106ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106de0:	8b 7b 38             	mov    0x38(%ebx),%edi
80106de3:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80106de7:	e8 74 cb ff ff       	call   80103960 <cpuid>
80106dec:	c7 04 24 50 8c 10 80 	movl   $0x80108c50,(%esp)
80106df3:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80106df7:	89 74 24 08          	mov    %esi,0x8(%esp)
80106dfb:	89 44 24 04          	mov    %eax,0x4(%esp)
80106dff:	e8 4c 98 ff ff       	call   80100650 <cprintf>
    lapiceoi();
80106e04:	e8 47 ba ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106e09:	e8 72 cb ff ff       	call   80103980 <myproc>
80106e0e:	85 c0                	test   %eax,%eax
80106e10:	0f 85 97 fe ff ff    	jne    80106cad <trap+0xbd>
80106e16:	e9 ad fe ff ff       	jmp    80106cc8 <trap+0xd8>
80106e1b:	90                   	nop
80106e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80106e20:	e8 3b b3 ff ff       	call   80102160 <ideintr>
80106e25:	e9 53 ff ff ff       	jmp    80106d7d <trap+0x18d>
80106e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit(0);
80106e30:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106e37:	e8 94 d2 ff ff       	call   801040d0 <exit>
80106e3c:	e9 df fe ff ff       	jmp    80106d20 <trap+0x130>
80106e41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit(0);
80106e48:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106e4f:	e8 7c d2 ff ff       	call   801040d0 <exit>
80106e54:	e9 6f fe ff ff       	jmp    80106cc8 <trap+0xd8>
80106e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      acquire(&tickslock);
80106e60:	c7 04 24 c0 60 11 80 	movl   $0x801160c0,(%esp)
80106e67:	e8 14 e9 ff ff       	call   80105780 <acquire>
      wakeup(&ticks);
80106e6c:	c7 04 24 00 69 11 80 	movl   $0x80116900,(%esp)
      ticks++;
80106e73:	ff 05 00 69 11 80    	incl   0x80116900
      wakeup(&ticks);
80106e79:	e8 d2 d5 ff ff       	call   80104450 <wakeup>
      release(&tickslock);
80106e7e:	c7 04 24 c0 60 11 80 	movl   $0x801160c0,(%esp)
80106e85:	e8 96 e9 ff ff       	call   80105820 <release>
80106e8a:	e9 ee fe ff ff       	jmp    80106d7d <trap+0x18d>
80106e8f:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106e92:	e8 c9 ca ff ff       	call   80103960 <cpuid>
80106e97:	89 74 24 10          	mov    %esi,0x10(%esp)
80106e9b:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80106e9f:	89 44 24 08          	mov    %eax,0x8(%esp)
80106ea3:	8b 43 30             	mov    0x30(%ebx),%eax
80106ea6:	c7 04 24 74 8c 10 80 	movl   $0x80108c74,(%esp)
80106ead:	89 44 24 04          	mov    %eax,0x4(%esp)
80106eb1:	e8 9a 97 ff ff       	call   80100650 <cprintf>
      panic("trap");
80106eb6:	c7 04 24 4a 8c 10 80 	movl   $0x80108c4a,(%esp)
80106ebd:	e8 ae 94 ff ff       	call   80100370 <panic>
80106ec2:	66 90                	xchg   %ax,%ax
80106ec4:	66 90                	xchg   %ax,%ax
80106ec6:	66 90                	xchg   %ax,%ax
80106ec8:	66 90                	xchg   %ax,%ax
80106eca:	66 90                	xchg   %ax,%ax
80106ecc:	66 90                	xchg   %ax,%ax
80106ece:	66 90                	xchg   %ax,%ax

80106ed0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106ed0:	a1 10 b6 10 80       	mov    0x8010b610,%eax
{
80106ed5:	55                   	push   %ebp
80106ed6:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106ed8:	85 c0                	test   %eax,%eax
80106eda:	74 1c                	je     80106ef8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106edc:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106ee1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106ee2:	24 01                	and    $0x1,%al
80106ee4:	84 c0                	test   %al,%al
80106ee6:	74 10                	je     80106ef8 <uartgetc+0x28>
80106ee8:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106eed:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106eee:	0f b6 c0             	movzbl %al,%eax
}
80106ef1:	5d                   	pop    %ebp
80106ef2:	c3                   	ret    
80106ef3:	90                   	nop
80106ef4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106ef8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106efd:	5d                   	pop    %ebp
80106efe:	c3                   	ret    
80106eff:	90                   	nop

80106f00 <uartputc.part.0>:
uartputc(int c)
80106f00:	55                   	push   %ebp
80106f01:	89 e5                	mov    %esp,%ebp
80106f03:	56                   	push   %esi
80106f04:	be fd 03 00 00       	mov    $0x3fd,%esi
80106f09:	53                   	push   %ebx
80106f0a:	bb 80 00 00 00       	mov    $0x80,%ebx
80106f0f:	83 ec 20             	sub    $0x20,%esp
80106f12:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106f15:	eb 18                	jmp    80106f2f <uartputc.part.0+0x2f>
80106f17:	89 f6                	mov    %esi,%esi
80106f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80106f20:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80106f27:	e8 44 b9 ff ff       	call   80102870 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106f2c:	4b                   	dec    %ebx
80106f2d:	74 09                	je     80106f38 <uartputc.part.0+0x38>
80106f2f:	89 f2                	mov    %esi,%edx
80106f31:	ec                   	in     (%dx),%al
80106f32:	24 20                	and    $0x20,%al
80106f34:	84 c0                	test   %al,%al
80106f36:	74 e8                	je     80106f20 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106f38:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106f3d:	0f b6 45 f4          	movzbl -0xc(%ebp),%eax
80106f41:	ee                   	out    %al,(%dx)
}
80106f42:	83 c4 20             	add    $0x20,%esp
80106f45:	5b                   	pop    %ebx
80106f46:	5e                   	pop    %esi
80106f47:	5d                   	pop    %ebp
80106f48:	c3                   	ret    
80106f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106f50 <uartinit>:
{
80106f50:	55                   	push   %ebp
80106f51:	31 c9                	xor    %ecx,%ecx
80106f53:	89 e5                	mov    %esp,%ebp
80106f55:	88 c8                	mov    %cl,%al
80106f57:	57                   	push   %edi
80106f58:	56                   	push   %esi
80106f59:	53                   	push   %ebx
80106f5a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80106f5f:	83 ec 1c             	sub    $0x1c,%esp
80106f62:	89 da                	mov    %ebx,%edx
80106f64:	ee                   	out    %al,(%dx)
80106f65:	bf fb 03 00 00       	mov    $0x3fb,%edi
80106f6a:	b0 80                	mov    $0x80,%al
80106f6c:	89 fa                	mov    %edi,%edx
80106f6e:	ee                   	out    %al,(%dx)
80106f6f:	b0 0c                	mov    $0xc,%al
80106f71:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106f76:	ee                   	out    %al,(%dx)
80106f77:	be f9 03 00 00       	mov    $0x3f9,%esi
80106f7c:	88 c8                	mov    %cl,%al
80106f7e:	89 f2                	mov    %esi,%edx
80106f80:	ee                   	out    %al,(%dx)
80106f81:	b0 03                	mov    $0x3,%al
80106f83:	89 fa                	mov    %edi,%edx
80106f85:	ee                   	out    %al,(%dx)
80106f86:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106f8b:	88 c8                	mov    %cl,%al
80106f8d:	ee                   	out    %al,(%dx)
80106f8e:	b0 01                	mov    $0x1,%al
80106f90:	89 f2                	mov    %esi,%edx
80106f92:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106f93:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106f98:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106f99:	fe c0                	inc    %al
80106f9b:	74 52                	je     80106fef <uartinit+0x9f>
  uart = 1;
80106f9d:	b9 01 00 00 00       	mov    $0x1,%ecx
80106fa2:	89 da                	mov    %ebx,%edx
80106fa4:	89 0d 10 b6 10 80    	mov    %ecx,0x8010b610
80106faa:	ec                   	in     (%dx),%al
80106fab:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106fb0:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106fb1:	31 db                	xor    %ebx,%ebx
80106fb3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  for(p="xv6...\n"; *p; p++)
80106fb7:	bb 6c 8d 10 80       	mov    $0x80108d6c,%ebx
  ioapicenable(IRQ_COM1, 0);
80106fbc:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80106fc3:	e8 d8 b3 ff ff       	call   801023a0 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80106fc8:	b8 78 00 00 00       	mov    $0x78,%eax
80106fcd:	eb 09                	jmp    80106fd8 <uartinit+0x88>
80106fcf:	90                   	nop
80106fd0:	43                   	inc    %ebx
80106fd1:	0f be 03             	movsbl (%ebx),%eax
80106fd4:	84 c0                	test   %al,%al
80106fd6:	74 17                	je     80106fef <uartinit+0x9f>
  if(!uart)
80106fd8:	8b 15 10 b6 10 80    	mov    0x8010b610,%edx
80106fde:	85 d2                	test   %edx,%edx
80106fe0:	74 ee                	je     80106fd0 <uartinit+0x80>
  for(p="xv6...\n"; *p; p++)
80106fe2:	43                   	inc    %ebx
80106fe3:	e8 18 ff ff ff       	call   80106f00 <uartputc.part.0>
80106fe8:	0f be 03             	movsbl (%ebx),%eax
80106feb:	84 c0                	test   %al,%al
80106fed:	75 e9                	jne    80106fd8 <uartinit+0x88>
}
80106fef:	83 c4 1c             	add    $0x1c,%esp
80106ff2:	5b                   	pop    %ebx
80106ff3:	5e                   	pop    %esi
80106ff4:	5f                   	pop    %edi
80106ff5:	5d                   	pop    %ebp
80106ff6:	c3                   	ret    
80106ff7:	89 f6                	mov    %esi,%esi
80106ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107000 <uartputc>:
  if(!uart)
80107000:	8b 15 10 b6 10 80    	mov    0x8010b610,%edx
{
80107006:	55                   	push   %ebp
80107007:	89 e5                	mov    %esp,%ebp
80107009:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
8010700c:	85 d2                	test   %edx,%edx
8010700e:	74 10                	je     80107020 <uartputc+0x20>
}
80107010:	5d                   	pop    %ebp
80107011:	e9 ea fe ff ff       	jmp    80106f00 <uartputc.part.0>
80107016:	8d 76 00             	lea    0x0(%esi),%esi
80107019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107020:	5d                   	pop    %ebp
80107021:	c3                   	ret    
80107022:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107030 <uartintr>:

void
uartintr(void)
{
80107030:	55                   	push   %ebp
80107031:	89 e5                	mov    %esp,%ebp
80107033:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80107036:	c7 04 24 d0 6e 10 80 	movl   $0x80106ed0,(%esp)
8010703d:	e8 8e 97 ff ff       	call   801007d0 <consoleintr>
}
80107042:	c9                   	leave  
80107043:	c3                   	ret    

80107044 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80107044:	6a 00                	push   $0x0
  pushl $0
80107046:	6a 00                	push   $0x0
  jmp alltraps
80107048:	e9 ca fa ff ff       	jmp    80106b17 <alltraps>

8010704d <vector1>:
.globl vector1
vector1:
  pushl $0
8010704d:	6a 00                	push   $0x0
  pushl $1
8010704f:	6a 01                	push   $0x1
  jmp alltraps
80107051:	e9 c1 fa ff ff       	jmp    80106b17 <alltraps>

80107056 <vector2>:
.globl vector2
vector2:
  pushl $0
80107056:	6a 00                	push   $0x0
  pushl $2
80107058:	6a 02                	push   $0x2
  jmp alltraps
8010705a:	e9 b8 fa ff ff       	jmp    80106b17 <alltraps>

8010705f <vector3>:
.globl vector3
vector3:
  pushl $0
8010705f:	6a 00                	push   $0x0
  pushl $3
80107061:	6a 03                	push   $0x3
  jmp alltraps
80107063:	e9 af fa ff ff       	jmp    80106b17 <alltraps>

80107068 <vector4>:
.globl vector4
vector4:
  pushl $0
80107068:	6a 00                	push   $0x0
  pushl $4
8010706a:	6a 04                	push   $0x4
  jmp alltraps
8010706c:	e9 a6 fa ff ff       	jmp    80106b17 <alltraps>

80107071 <vector5>:
.globl vector5
vector5:
  pushl $0
80107071:	6a 00                	push   $0x0
  pushl $5
80107073:	6a 05                	push   $0x5
  jmp alltraps
80107075:	e9 9d fa ff ff       	jmp    80106b17 <alltraps>

8010707a <vector6>:
.globl vector6
vector6:
  pushl $0
8010707a:	6a 00                	push   $0x0
  pushl $6
8010707c:	6a 06                	push   $0x6
  jmp alltraps
8010707e:	e9 94 fa ff ff       	jmp    80106b17 <alltraps>

80107083 <vector7>:
.globl vector7
vector7:
  pushl $0
80107083:	6a 00                	push   $0x0
  pushl $7
80107085:	6a 07                	push   $0x7
  jmp alltraps
80107087:	e9 8b fa ff ff       	jmp    80106b17 <alltraps>

8010708c <vector8>:
.globl vector8
vector8:
  pushl $8
8010708c:	6a 08                	push   $0x8
  jmp alltraps
8010708e:	e9 84 fa ff ff       	jmp    80106b17 <alltraps>

80107093 <vector9>:
.globl vector9
vector9:
  pushl $0
80107093:	6a 00                	push   $0x0
  pushl $9
80107095:	6a 09                	push   $0x9
  jmp alltraps
80107097:	e9 7b fa ff ff       	jmp    80106b17 <alltraps>

8010709c <vector10>:
.globl vector10
vector10:
  pushl $10
8010709c:	6a 0a                	push   $0xa
  jmp alltraps
8010709e:	e9 74 fa ff ff       	jmp    80106b17 <alltraps>

801070a3 <vector11>:
.globl vector11
vector11:
  pushl $11
801070a3:	6a 0b                	push   $0xb
  jmp alltraps
801070a5:	e9 6d fa ff ff       	jmp    80106b17 <alltraps>

801070aa <vector12>:
.globl vector12
vector12:
  pushl $12
801070aa:	6a 0c                	push   $0xc
  jmp alltraps
801070ac:	e9 66 fa ff ff       	jmp    80106b17 <alltraps>

801070b1 <vector13>:
.globl vector13
vector13:
  pushl $13
801070b1:	6a 0d                	push   $0xd
  jmp alltraps
801070b3:	e9 5f fa ff ff       	jmp    80106b17 <alltraps>

801070b8 <vector14>:
.globl vector14
vector14:
  pushl $14
801070b8:	6a 0e                	push   $0xe
  jmp alltraps
801070ba:	e9 58 fa ff ff       	jmp    80106b17 <alltraps>

801070bf <vector15>:
.globl vector15
vector15:
  pushl $0
801070bf:	6a 00                	push   $0x0
  pushl $15
801070c1:	6a 0f                	push   $0xf
  jmp alltraps
801070c3:	e9 4f fa ff ff       	jmp    80106b17 <alltraps>

801070c8 <vector16>:
.globl vector16
vector16:
  pushl $0
801070c8:	6a 00                	push   $0x0
  pushl $16
801070ca:	6a 10                	push   $0x10
  jmp alltraps
801070cc:	e9 46 fa ff ff       	jmp    80106b17 <alltraps>

801070d1 <vector17>:
.globl vector17
vector17:
  pushl $17
801070d1:	6a 11                	push   $0x11
  jmp alltraps
801070d3:	e9 3f fa ff ff       	jmp    80106b17 <alltraps>

801070d8 <vector18>:
.globl vector18
vector18:
  pushl $0
801070d8:	6a 00                	push   $0x0
  pushl $18
801070da:	6a 12                	push   $0x12
  jmp alltraps
801070dc:	e9 36 fa ff ff       	jmp    80106b17 <alltraps>

801070e1 <vector19>:
.globl vector19
vector19:
  pushl $0
801070e1:	6a 00                	push   $0x0
  pushl $19
801070e3:	6a 13                	push   $0x13
  jmp alltraps
801070e5:	e9 2d fa ff ff       	jmp    80106b17 <alltraps>

801070ea <vector20>:
.globl vector20
vector20:
  pushl $0
801070ea:	6a 00                	push   $0x0
  pushl $20
801070ec:	6a 14                	push   $0x14
  jmp alltraps
801070ee:	e9 24 fa ff ff       	jmp    80106b17 <alltraps>

801070f3 <vector21>:
.globl vector21
vector21:
  pushl $0
801070f3:	6a 00                	push   $0x0
  pushl $21
801070f5:	6a 15                	push   $0x15
  jmp alltraps
801070f7:	e9 1b fa ff ff       	jmp    80106b17 <alltraps>

801070fc <vector22>:
.globl vector22
vector22:
  pushl $0
801070fc:	6a 00                	push   $0x0
  pushl $22
801070fe:	6a 16                	push   $0x16
  jmp alltraps
80107100:	e9 12 fa ff ff       	jmp    80106b17 <alltraps>

80107105 <vector23>:
.globl vector23
vector23:
  pushl $0
80107105:	6a 00                	push   $0x0
  pushl $23
80107107:	6a 17                	push   $0x17
  jmp alltraps
80107109:	e9 09 fa ff ff       	jmp    80106b17 <alltraps>

8010710e <vector24>:
.globl vector24
vector24:
  pushl $0
8010710e:	6a 00                	push   $0x0
  pushl $24
80107110:	6a 18                	push   $0x18
  jmp alltraps
80107112:	e9 00 fa ff ff       	jmp    80106b17 <alltraps>

80107117 <vector25>:
.globl vector25
vector25:
  pushl $0
80107117:	6a 00                	push   $0x0
  pushl $25
80107119:	6a 19                	push   $0x19
  jmp alltraps
8010711b:	e9 f7 f9 ff ff       	jmp    80106b17 <alltraps>

80107120 <vector26>:
.globl vector26
vector26:
  pushl $0
80107120:	6a 00                	push   $0x0
  pushl $26
80107122:	6a 1a                	push   $0x1a
  jmp alltraps
80107124:	e9 ee f9 ff ff       	jmp    80106b17 <alltraps>

80107129 <vector27>:
.globl vector27
vector27:
  pushl $0
80107129:	6a 00                	push   $0x0
  pushl $27
8010712b:	6a 1b                	push   $0x1b
  jmp alltraps
8010712d:	e9 e5 f9 ff ff       	jmp    80106b17 <alltraps>

80107132 <vector28>:
.globl vector28
vector28:
  pushl $0
80107132:	6a 00                	push   $0x0
  pushl $28
80107134:	6a 1c                	push   $0x1c
  jmp alltraps
80107136:	e9 dc f9 ff ff       	jmp    80106b17 <alltraps>

8010713b <vector29>:
.globl vector29
vector29:
  pushl $0
8010713b:	6a 00                	push   $0x0
  pushl $29
8010713d:	6a 1d                	push   $0x1d
  jmp alltraps
8010713f:	e9 d3 f9 ff ff       	jmp    80106b17 <alltraps>

80107144 <vector30>:
.globl vector30
vector30:
  pushl $0
80107144:	6a 00                	push   $0x0
  pushl $30
80107146:	6a 1e                	push   $0x1e
  jmp alltraps
80107148:	e9 ca f9 ff ff       	jmp    80106b17 <alltraps>

8010714d <vector31>:
.globl vector31
vector31:
  pushl $0
8010714d:	6a 00                	push   $0x0
  pushl $31
8010714f:	6a 1f                	push   $0x1f
  jmp alltraps
80107151:	e9 c1 f9 ff ff       	jmp    80106b17 <alltraps>

80107156 <vector32>:
.globl vector32
vector32:
  pushl $0
80107156:	6a 00                	push   $0x0
  pushl $32
80107158:	6a 20                	push   $0x20
  jmp alltraps
8010715a:	e9 b8 f9 ff ff       	jmp    80106b17 <alltraps>

8010715f <vector33>:
.globl vector33
vector33:
  pushl $0
8010715f:	6a 00                	push   $0x0
  pushl $33
80107161:	6a 21                	push   $0x21
  jmp alltraps
80107163:	e9 af f9 ff ff       	jmp    80106b17 <alltraps>

80107168 <vector34>:
.globl vector34
vector34:
  pushl $0
80107168:	6a 00                	push   $0x0
  pushl $34
8010716a:	6a 22                	push   $0x22
  jmp alltraps
8010716c:	e9 a6 f9 ff ff       	jmp    80106b17 <alltraps>

80107171 <vector35>:
.globl vector35
vector35:
  pushl $0
80107171:	6a 00                	push   $0x0
  pushl $35
80107173:	6a 23                	push   $0x23
  jmp alltraps
80107175:	e9 9d f9 ff ff       	jmp    80106b17 <alltraps>

8010717a <vector36>:
.globl vector36
vector36:
  pushl $0
8010717a:	6a 00                	push   $0x0
  pushl $36
8010717c:	6a 24                	push   $0x24
  jmp alltraps
8010717e:	e9 94 f9 ff ff       	jmp    80106b17 <alltraps>

80107183 <vector37>:
.globl vector37
vector37:
  pushl $0
80107183:	6a 00                	push   $0x0
  pushl $37
80107185:	6a 25                	push   $0x25
  jmp alltraps
80107187:	e9 8b f9 ff ff       	jmp    80106b17 <alltraps>

8010718c <vector38>:
.globl vector38
vector38:
  pushl $0
8010718c:	6a 00                	push   $0x0
  pushl $38
8010718e:	6a 26                	push   $0x26
  jmp alltraps
80107190:	e9 82 f9 ff ff       	jmp    80106b17 <alltraps>

80107195 <vector39>:
.globl vector39
vector39:
  pushl $0
80107195:	6a 00                	push   $0x0
  pushl $39
80107197:	6a 27                	push   $0x27
  jmp alltraps
80107199:	e9 79 f9 ff ff       	jmp    80106b17 <alltraps>

8010719e <vector40>:
.globl vector40
vector40:
  pushl $0
8010719e:	6a 00                	push   $0x0
  pushl $40
801071a0:	6a 28                	push   $0x28
  jmp alltraps
801071a2:	e9 70 f9 ff ff       	jmp    80106b17 <alltraps>

801071a7 <vector41>:
.globl vector41
vector41:
  pushl $0
801071a7:	6a 00                	push   $0x0
  pushl $41
801071a9:	6a 29                	push   $0x29
  jmp alltraps
801071ab:	e9 67 f9 ff ff       	jmp    80106b17 <alltraps>

801071b0 <vector42>:
.globl vector42
vector42:
  pushl $0
801071b0:	6a 00                	push   $0x0
  pushl $42
801071b2:	6a 2a                	push   $0x2a
  jmp alltraps
801071b4:	e9 5e f9 ff ff       	jmp    80106b17 <alltraps>

801071b9 <vector43>:
.globl vector43
vector43:
  pushl $0
801071b9:	6a 00                	push   $0x0
  pushl $43
801071bb:	6a 2b                	push   $0x2b
  jmp alltraps
801071bd:	e9 55 f9 ff ff       	jmp    80106b17 <alltraps>

801071c2 <vector44>:
.globl vector44
vector44:
  pushl $0
801071c2:	6a 00                	push   $0x0
  pushl $44
801071c4:	6a 2c                	push   $0x2c
  jmp alltraps
801071c6:	e9 4c f9 ff ff       	jmp    80106b17 <alltraps>

801071cb <vector45>:
.globl vector45
vector45:
  pushl $0
801071cb:	6a 00                	push   $0x0
  pushl $45
801071cd:	6a 2d                	push   $0x2d
  jmp alltraps
801071cf:	e9 43 f9 ff ff       	jmp    80106b17 <alltraps>

801071d4 <vector46>:
.globl vector46
vector46:
  pushl $0
801071d4:	6a 00                	push   $0x0
  pushl $46
801071d6:	6a 2e                	push   $0x2e
  jmp alltraps
801071d8:	e9 3a f9 ff ff       	jmp    80106b17 <alltraps>

801071dd <vector47>:
.globl vector47
vector47:
  pushl $0
801071dd:	6a 00                	push   $0x0
  pushl $47
801071df:	6a 2f                	push   $0x2f
  jmp alltraps
801071e1:	e9 31 f9 ff ff       	jmp    80106b17 <alltraps>

801071e6 <vector48>:
.globl vector48
vector48:
  pushl $0
801071e6:	6a 00                	push   $0x0
  pushl $48
801071e8:	6a 30                	push   $0x30
  jmp alltraps
801071ea:	e9 28 f9 ff ff       	jmp    80106b17 <alltraps>

801071ef <vector49>:
.globl vector49
vector49:
  pushl $0
801071ef:	6a 00                	push   $0x0
  pushl $49
801071f1:	6a 31                	push   $0x31
  jmp alltraps
801071f3:	e9 1f f9 ff ff       	jmp    80106b17 <alltraps>

801071f8 <vector50>:
.globl vector50
vector50:
  pushl $0
801071f8:	6a 00                	push   $0x0
  pushl $50
801071fa:	6a 32                	push   $0x32
  jmp alltraps
801071fc:	e9 16 f9 ff ff       	jmp    80106b17 <alltraps>

80107201 <vector51>:
.globl vector51
vector51:
  pushl $0
80107201:	6a 00                	push   $0x0
  pushl $51
80107203:	6a 33                	push   $0x33
  jmp alltraps
80107205:	e9 0d f9 ff ff       	jmp    80106b17 <alltraps>

8010720a <vector52>:
.globl vector52
vector52:
  pushl $0
8010720a:	6a 00                	push   $0x0
  pushl $52
8010720c:	6a 34                	push   $0x34
  jmp alltraps
8010720e:	e9 04 f9 ff ff       	jmp    80106b17 <alltraps>

80107213 <vector53>:
.globl vector53
vector53:
  pushl $0
80107213:	6a 00                	push   $0x0
  pushl $53
80107215:	6a 35                	push   $0x35
  jmp alltraps
80107217:	e9 fb f8 ff ff       	jmp    80106b17 <alltraps>

8010721c <vector54>:
.globl vector54
vector54:
  pushl $0
8010721c:	6a 00                	push   $0x0
  pushl $54
8010721e:	6a 36                	push   $0x36
  jmp alltraps
80107220:	e9 f2 f8 ff ff       	jmp    80106b17 <alltraps>

80107225 <vector55>:
.globl vector55
vector55:
  pushl $0
80107225:	6a 00                	push   $0x0
  pushl $55
80107227:	6a 37                	push   $0x37
  jmp alltraps
80107229:	e9 e9 f8 ff ff       	jmp    80106b17 <alltraps>

8010722e <vector56>:
.globl vector56
vector56:
  pushl $0
8010722e:	6a 00                	push   $0x0
  pushl $56
80107230:	6a 38                	push   $0x38
  jmp alltraps
80107232:	e9 e0 f8 ff ff       	jmp    80106b17 <alltraps>

80107237 <vector57>:
.globl vector57
vector57:
  pushl $0
80107237:	6a 00                	push   $0x0
  pushl $57
80107239:	6a 39                	push   $0x39
  jmp alltraps
8010723b:	e9 d7 f8 ff ff       	jmp    80106b17 <alltraps>

80107240 <vector58>:
.globl vector58
vector58:
  pushl $0
80107240:	6a 00                	push   $0x0
  pushl $58
80107242:	6a 3a                	push   $0x3a
  jmp alltraps
80107244:	e9 ce f8 ff ff       	jmp    80106b17 <alltraps>

80107249 <vector59>:
.globl vector59
vector59:
  pushl $0
80107249:	6a 00                	push   $0x0
  pushl $59
8010724b:	6a 3b                	push   $0x3b
  jmp alltraps
8010724d:	e9 c5 f8 ff ff       	jmp    80106b17 <alltraps>

80107252 <vector60>:
.globl vector60
vector60:
  pushl $0
80107252:	6a 00                	push   $0x0
  pushl $60
80107254:	6a 3c                	push   $0x3c
  jmp alltraps
80107256:	e9 bc f8 ff ff       	jmp    80106b17 <alltraps>

8010725b <vector61>:
.globl vector61
vector61:
  pushl $0
8010725b:	6a 00                	push   $0x0
  pushl $61
8010725d:	6a 3d                	push   $0x3d
  jmp alltraps
8010725f:	e9 b3 f8 ff ff       	jmp    80106b17 <alltraps>

80107264 <vector62>:
.globl vector62
vector62:
  pushl $0
80107264:	6a 00                	push   $0x0
  pushl $62
80107266:	6a 3e                	push   $0x3e
  jmp alltraps
80107268:	e9 aa f8 ff ff       	jmp    80106b17 <alltraps>

8010726d <vector63>:
.globl vector63
vector63:
  pushl $0
8010726d:	6a 00                	push   $0x0
  pushl $63
8010726f:	6a 3f                	push   $0x3f
  jmp alltraps
80107271:	e9 a1 f8 ff ff       	jmp    80106b17 <alltraps>

80107276 <vector64>:
.globl vector64
vector64:
  pushl $0
80107276:	6a 00                	push   $0x0
  pushl $64
80107278:	6a 40                	push   $0x40
  jmp alltraps
8010727a:	e9 98 f8 ff ff       	jmp    80106b17 <alltraps>

8010727f <vector65>:
.globl vector65
vector65:
  pushl $0
8010727f:	6a 00                	push   $0x0
  pushl $65
80107281:	6a 41                	push   $0x41
  jmp alltraps
80107283:	e9 8f f8 ff ff       	jmp    80106b17 <alltraps>

80107288 <vector66>:
.globl vector66
vector66:
  pushl $0
80107288:	6a 00                	push   $0x0
  pushl $66
8010728a:	6a 42                	push   $0x42
  jmp alltraps
8010728c:	e9 86 f8 ff ff       	jmp    80106b17 <alltraps>

80107291 <vector67>:
.globl vector67
vector67:
  pushl $0
80107291:	6a 00                	push   $0x0
  pushl $67
80107293:	6a 43                	push   $0x43
  jmp alltraps
80107295:	e9 7d f8 ff ff       	jmp    80106b17 <alltraps>

8010729a <vector68>:
.globl vector68
vector68:
  pushl $0
8010729a:	6a 00                	push   $0x0
  pushl $68
8010729c:	6a 44                	push   $0x44
  jmp alltraps
8010729e:	e9 74 f8 ff ff       	jmp    80106b17 <alltraps>

801072a3 <vector69>:
.globl vector69
vector69:
  pushl $0
801072a3:	6a 00                	push   $0x0
  pushl $69
801072a5:	6a 45                	push   $0x45
  jmp alltraps
801072a7:	e9 6b f8 ff ff       	jmp    80106b17 <alltraps>

801072ac <vector70>:
.globl vector70
vector70:
  pushl $0
801072ac:	6a 00                	push   $0x0
  pushl $70
801072ae:	6a 46                	push   $0x46
  jmp alltraps
801072b0:	e9 62 f8 ff ff       	jmp    80106b17 <alltraps>

801072b5 <vector71>:
.globl vector71
vector71:
  pushl $0
801072b5:	6a 00                	push   $0x0
  pushl $71
801072b7:	6a 47                	push   $0x47
  jmp alltraps
801072b9:	e9 59 f8 ff ff       	jmp    80106b17 <alltraps>

801072be <vector72>:
.globl vector72
vector72:
  pushl $0
801072be:	6a 00                	push   $0x0
  pushl $72
801072c0:	6a 48                	push   $0x48
  jmp alltraps
801072c2:	e9 50 f8 ff ff       	jmp    80106b17 <alltraps>

801072c7 <vector73>:
.globl vector73
vector73:
  pushl $0
801072c7:	6a 00                	push   $0x0
  pushl $73
801072c9:	6a 49                	push   $0x49
  jmp alltraps
801072cb:	e9 47 f8 ff ff       	jmp    80106b17 <alltraps>

801072d0 <vector74>:
.globl vector74
vector74:
  pushl $0
801072d0:	6a 00                	push   $0x0
  pushl $74
801072d2:	6a 4a                	push   $0x4a
  jmp alltraps
801072d4:	e9 3e f8 ff ff       	jmp    80106b17 <alltraps>

801072d9 <vector75>:
.globl vector75
vector75:
  pushl $0
801072d9:	6a 00                	push   $0x0
  pushl $75
801072db:	6a 4b                	push   $0x4b
  jmp alltraps
801072dd:	e9 35 f8 ff ff       	jmp    80106b17 <alltraps>

801072e2 <vector76>:
.globl vector76
vector76:
  pushl $0
801072e2:	6a 00                	push   $0x0
  pushl $76
801072e4:	6a 4c                	push   $0x4c
  jmp alltraps
801072e6:	e9 2c f8 ff ff       	jmp    80106b17 <alltraps>

801072eb <vector77>:
.globl vector77
vector77:
  pushl $0
801072eb:	6a 00                	push   $0x0
  pushl $77
801072ed:	6a 4d                	push   $0x4d
  jmp alltraps
801072ef:	e9 23 f8 ff ff       	jmp    80106b17 <alltraps>

801072f4 <vector78>:
.globl vector78
vector78:
  pushl $0
801072f4:	6a 00                	push   $0x0
  pushl $78
801072f6:	6a 4e                	push   $0x4e
  jmp alltraps
801072f8:	e9 1a f8 ff ff       	jmp    80106b17 <alltraps>

801072fd <vector79>:
.globl vector79
vector79:
  pushl $0
801072fd:	6a 00                	push   $0x0
  pushl $79
801072ff:	6a 4f                	push   $0x4f
  jmp alltraps
80107301:	e9 11 f8 ff ff       	jmp    80106b17 <alltraps>

80107306 <vector80>:
.globl vector80
vector80:
  pushl $0
80107306:	6a 00                	push   $0x0
  pushl $80
80107308:	6a 50                	push   $0x50
  jmp alltraps
8010730a:	e9 08 f8 ff ff       	jmp    80106b17 <alltraps>

8010730f <vector81>:
.globl vector81
vector81:
  pushl $0
8010730f:	6a 00                	push   $0x0
  pushl $81
80107311:	6a 51                	push   $0x51
  jmp alltraps
80107313:	e9 ff f7 ff ff       	jmp    80106b17 <alltraps>

80107318 <vector82>:
.globl vector82
vector82:
  pushl $0
80107318:	6a 00                	push   $0x0
  pushl $82
8010731a:	6a 52                	push   $0x52
  jmp alltraps
8010731c:	e9 f6 f7 ff ff       	jmp    80106b17 <alltraps>

80107321 <vector83>:
.globl vector83
vector83:
  pushl $0
80107321:	6a 00                	push   $0x0
  pushl $83
80107323:	6a 53                	push   $0x53
  jmp alltraps
80107325:	e9 ed f7 ff ff       	jmp    80106b17 <alltraps>

8010732a <vector84>:
.globl vector84
vector84:
  pushl $0
8010732a:	6a 00                	push   $0x0
  pushl $84
8010732c:	6a 54                	push   $0x54
  jmp alltraps
8010732e:	e9 e4 f7 ff ff       	jmp    80106b17 <alltraps>

80107333 <vector85>:
.globl vector85
vector85:
  pushl $0
80107333:	6a 00                	push   $0x0
  pushl $85
80107335:	6a 55                	push   $0x55
  jmp alltraps
80107337:	e9 db f7 ff ff       	jmp    80106b17 <alltraps>

8010733c <vector86>:
.globl vector86
vector86:
  pushl $0
8010733c:	6a 00                	push   $0x0
  pushl $86
8010733e:	6a 56                	push   $0x56
  jmp alltraps
80107340:	e9 d2 f7 ff ff       	jmp    80106b17 <alltraps>

80107345 <vector87>:
.globl vector87
vector87:
  pushl $0
80107345:	6a 00                	push   $0x0
  pushl $87
80107347:	6a 57                	push   $0x57
  jmp alltraps
80107349:	e9 c9 f7 ff ff       	jmp    80106b17 <alltraps>

8010734e <vector88>:
.globl vector88
vector88:
  pushl $0
8010734e:	6a 00                	push   $0x0
  pushl $88
80107350:	6a 58                	push   $0x58
  jmp alltraps
80107352:	e9 c0 f7 ff ff       	jmp    80106b17 <alltraps>

80107357 <vector89>:
.globl vector89
vector89:
  pushl $0
80107357:	6a 00                	push   $0x0
  pushl $89
80107359:	6a 59                	push   $0x59
  jmp alltraps
8010735b:	e9 b7 f7 ff ff       	jmp    80106b17 <alltraps>

80107360 <vector90>:
.globl vector90
vector90:
  pushl $0
80107360:	6a 00                	push   $0x0
  pushl $90
80107362:	6a 5a                	push   $0x5a
  jmp alltraps
80107364:	e9 ae f7 ff ff       	jmp    80106b17 <alltraps>

80107369 <vector91>:
.globl vector91
vector91:
  pushl $0
80107369:	6a 00                	push   $0x0
  pushl $91
8010736b:	6a 5b                	push   $0x5b
  jmp alltraps
8010736d:	e9 a5 f7 ff ff       	jmp    80106b17 <alltraps>

80107372 <vector92>:
.globl vector92
vector92:
  pushl $0
80107372:	6a 00                	push   $0x0
  pushl $92
80107374:	6a 5c                	push   $0x5c
  jmp alltraps
80107376:	e9 9c f7 ff ff       	jmp    80106b17 <alltraps>

8010737b <vector93>:
.globl vector93
vector93:
  pushl $0
8010737b:	6a 00                	push   $0x0
  pushl $93
8010737d:	6a 5d                	push   $0x5d
  jmp alltraps
8010737f:	e9 93 f7 ff ff       	jmp    80106b17 <alltraps>

80107384 <vector94>:
.globl vector94
vector94:
  pushl $0
80107384:	6a 00                	push   $0x0
  pushl $94
80107386:	6a 5e                	push   $0x5e
  jmp alltraps
80107388:	e9 8a f7 ff ff       	jmp    80106b17 <alltraps>

8010738d <vector95>:
.globl vector95
vector95:
  pushl $0
8010738d:	6a 00                	push   $0x0
  pushl $95
8010738f:	6a 5f                	push   $0x5f
  jmp alltraps
80107391:	e9 81 f7 ff ff       	jmp    80106b17 <alltraps>

80107396 <vector96>:
.globl vector96
vector96:
  pushl $0
80107396:	6a 00                	push   $0x0
  pushl $96
80107398:	6a 60                	push   $0x60
  jmp alltraps
8010739a:	e9 78 f7 ff ff       	jmp    80106b17 <alltraps>

8010739f <vector97>:
.globl vector97
vector97:
  pushl $0
8010739f:	6a 00                	push   $0x0
  pushl $97
801073a1:	6a 61                	push   $0x61
  jmp alltraps
801073a3:	e9 6f f7 ff ff       	jmp    80106b17 <alltraps>

801073a8 <vector98>:
.globl vector98
vector98:
  pushl $0
801073a8:	6a 00                	push   $0x0
  pushl $98
801073aa:	6a 62                	push   $0x62
  jmp alltraps
801073ac:	e9 66 f7 ff ff       	jmp    80106b17 <alltraps>

801073b1 <vector99>:
.globl vector99
vector99:
  pushl $0
801073b1:	6a 00                	push   $0x0
  pushl $99
801073b3:	6a 63                	push   $0x63
  jmp alltraps
801073b5:	e9 5d f7 ff ff       	jmp    80106b17 <alltraps>

801073ba <vector100>:
.globl vector100
vector100:
  pushl $0
801073ba:	6a 00                	push   $0x0
  pushl $100
801073bc:	6a 64                	push   $0x64
  jmp alltraps
801073be:	e9 54 f7 ff ff       	jmp    80106b17 <alltraps>

801073c3 <vector101>:
.globl vector101
vector101:
  pushl $0
801073c3:	6a 00                	push   $0x0
  pushl $101
801073c5:	6a 65                	push   $0x65
  jmp alltraps
801073c7:	e9 4b f7 ff ff       	jmp    80106b17 <alltraps>

801073cc <vector102>:
.globl vector102
vector102:
  pushl $0
801073cc:	6a 00                	push   $0x0
  pushl $102
801073ce:	6a 66                	push   $0x66
  jmp alltraps
801073d0:	e9 42 f7 ff ff       	jmp    80106b17 <alltraps>

801073d5 <vector103>:
.globl vector103
vector103:
  pushl $0
801073d5:	6a 00                	push   $0x0
  pushl $103
801073d7:	6a 67                	push   $0x67
  jmp alltraps
801073d9:	e9 39 f7 ff ff       	jmp    80106b17 <alltraps>

801073de <vector104>:
.globl vector104
vector104:
  pushl $0
801073de:	6a 00                	push   $0x0
  pushl $104
801073e0:	6a 68                	push   $0x68
  jmp alltraps
801073e2:	e9 30 f7 ff ff       	jmp    80106b17 <alltraps>

801073e7 <vector105>:
.globl vector105
vector105:
  pushl $0
801073e7:	6a 00                	push   $0x0
  pushl $105
801073e9:	6a 69                	push   $0x69
  jmp alltraps
801073eb:	e9 27 f7 ff ff       	jmp    80106b17 <alltraps>

801073f0 <vector106>:
.globl vector106
vector106:
  pushl $0
801073f0:	6a 00                	push   $0x0
  pushl $106
801073f2:	6a 6a                	push   $0x6a
  jmp alltraps
801073f4:	e9 1e f7 ff ff       	jmp    80106b17 <alltraps>

801073f9 <vector107>:
.globl vector107
vector107:
  pushl $0
801073f9:	6a 00                	push   $0x0
  pushl $107
801073fb:	6a 6b                	push   $0x6b
  jmp alltraps
801073fd:	e9 15 f7 ff ff       	jmp    80106b17 <alltraps>

80107402 <vector108>:
.globl vector108
vector108:
  pushl $0
80107402:	6a 00                	push   $0x0
  pushl $108
80107404:	6a 6c                	push   $0x6c
  jmp alltraps
80107406:	e9 0c f7 ff ff       	jmp    80106b17 <alltraps>

8010740b <vector109>:
.globl vector109
vector109:
  pushl $0
8010740b:	6a 00                	push   $0x0
  pushl $109
8010740d:	6a 6d                	push   $0x6d
  jmp alltraps
8010740f:	e9 03 f7 ff ff       	jmp    80106b17 <alltraps>

80107414 <vector110>:
.globl vector110
vector110:
  pushl $0
80107414:	6a 00                	push   $0x0
  pushl $110
80107416:	6a 6e                	push   $0x6e
  jmp alltraps
80107418:	e9 fa f6 ff ff       	jmp    80106b17 <alltraps>

8010741d <vector111>:
.globl vector111
vector111:
  pushl $0
8010741d:	6a 00                	push   $0x0
  pushl $111
8010741f:	6a 6f                	push   $0x6f
  jmp alltraps
80107421:	e9 f1 f6 ff ff       	jmp    80106b17 <alltraps>

80107426 <vector112>:
.globl vector112
vector112:
  pushl $0
80107426:	6a 00                	push   $0x0
  pushl $112
80107428:	6a 70                	push   $0x70
  jmp alltraps
8010742a:	e9 e8 f6 ff ff       	jmp    80106b17 <alltraps>

8010742f <vector113>:
.globl vector113
vector113:
  pushl $0
8010742f:	6a 00                	push   $0x0
  pushl $113
80107431:	6a 71                	push   $0x71
  jmp alltraps
80107433:	e9 df f6 ff ff       	jmp    80106b17 <alltraps>

80107438 <vector114>:
.globl vector114
vector114:
  pushl $0
80107438:	6a 00                	push   $0x0
  pushl $114
8010743a:	6a 72                	push   $0x72
  jmp alltraps
8010743c:	e9 d6 f6 ff ff       	jmp    80106b17 <alltraps>

80107441 <vector115>:
.globl vector115
vector115:
  pushl $0
80107441:	6a 00                	push   $0x0
  pushl $115
80107443:	6a 73                	push   $0x73
  jmp alltraps
80107445:	e9 cd f6 ff ff       	jmp    80106b17 <alltraps>

8010744a <vector116>:
.globl vector116
vector116:
  pushl $0
8010744a:	6a 00                	push   $0x0
  pushl $116
8010744c:	6a 74                	push   $0x74
  jmp alltraps
8010744e:	e9 c4 f6 ff ff       	jmp    80106b17 <alltraps>

80107453 <vector117>:
.globl vector117
vector117:
  pushl $0
80107453:	6a 00                	push   $0x0
  pushl $117
80107455:	6a 75                	push   $0x75
  jmp alltraps
80107457:	e9 bb f6 ff ff       	jmp    80106b17 <alltraps>

8010745c <vector118>:
.globl vector118
vector118:
  pushl $0
8010745c:	6a 00                	push   $0x0
  pushl $118
8010745e:	6a 76                	push   $0x76
  jmp alltraps
80107460:	e9 b2 f6 ff ff       	jmp    80106b17 <alltraps>

80107465 <vector119>:
.globl vector119
vector119:
  pushl $0
80107465:	6a 00                	push   $0x0
  pushl $119
80107467:	6a 77                	push   $0x77
  jmp alltraps
80107469:	e9 a9 f6 ff ff       	jmp    80106b17 <alltraps>

8010746e <vector120>:
.globl vector120
vector120:
  pushl $0
8010746e:	6a 00                	push   $0x0
  pushl $120
80107470:	6a 78                	push   $0x78
  jmp alltraps
80107472:	e9 a0 f6 ff ff       	jmp    80106b17 <alltraps>

80107477 <vector121>:
.globl vector121
vector121:
  pushl $0
80107477:	6a 00                	push   $0x0
  pushl $121
80107479:	6a 79                	push   $0x79
  jmp alltraps
8010747b:	e9 97 f6 ff ff       	jmp    80106b17 <alltraps>

80107480 <vector122>:
.globl vector122
vector122:
  pushl $0
80107480:	6a 00                	push   $0x0
  pushl $122
80107482:	6a 7a                	push   $0x7a
  jmp alltraps
80107484:	e9 8e f6 ff ff       	jmp    80106b17 <alltraps>

80107489 <vector123>:
.globl vector123
vector123:
  pushl $0
80107489:	6a 00                	push   $0x0
  pushl $123
8010748b:	6a 7b                	push   $0x7b
  jmp alltraps
8010748d:	e9 85 f6 ff ff       	jmp    80106b17 <alltraps>

80107492 <vector124>:
.globl vector124
vector124:
  pushl $0
80107492:	6a 00                	push   $0x0
  pushl $124
80107494:	6a 7c                	push   $0x7c
  jmp alltraps
80107496:	e9 7c f6 ff ff       	jmp    80106b17 <alltraps>

8010749b <vector125>:
.globl vector125
vector125:
  pushl $0
8010749b:	6a 00                	push   $0x0
  pushl $125
8010749d:	6a 7d                	push   $0x7d
  jmp alltraps
8010749f:	e9 73 f6 ff ff       	jmp    80106b17 <alltraps>

801074a4 <vector126>:
.globl vector126
vector126:
  pushl $0
801074a4:	6a 00                	push   $0x0
  pushl $126
801074a6:	6a 7e                	push   $0x7e
  jmp alltraps
801074a8:	e9 6a f6 ff ff       	jmp    80106b17 <alltraps>

801074ad <vector127>:
.globl vector127
vector127:
  pushl $0
801074ad:	6a 00                	push   $0x0
  pushl $127
801074af:	6a 7f                	push   $0x7f
  jmp alltraps
801074b1:	e9 61 f6 ff ff       	jmp    80106b17 <alltraps>

801074b6 <vector128>:
.globl vector128
vector128:
  pushl $0
801074b6:	6a 00                	push   $0x0
  pushl $128
801074b8:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801074bd:	e9 55 f6 ff ff       	jmp    80106b17 <alltraps>

801074c2 <vector129>:
.globl vector129
vector129:
  pushl $0
801074c2:	6a 00                	push   $0x0
  pushl $129
801074c4:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801074c9:	e9 49 f6 ff ff       	jmp    80106b17 <alltraps>

801074ce <vector130>:
.globl vector130
vector130:
  pushl $0
801074ce:	6a 00                	push   $0x0
  pushl $130
801074d0:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801074d5:	e9 3d f6 ff ff       	jmp    80106b17 <alltraps>

801074da <vector131>:
.globl vector131
vector131:
  pushl $0
801074da:	6a 00                	push   $0x0
  pushl $131
801074dc:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801074e1:	e9 31 f6 ff ff       	jmp    80106b17 <alltraps>

801074e6 <vector132>:
.globl vector132
vector132:
  pushl $0
801074e6:	6a 00                	push   $0x0
  pushl $132
801074e8:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801074ed:	e9 25 f6 ff ff       	jmp    80106b17 <alltraps>

801074f2 <vector133>:
.globl vector133
vector133:
  pushl $0
801074f2:	6a 00                	push   $0x0
  pushl $133
801074f4:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801074f9:	e9 19 f6 ff ff       	jmp    80106b17 <alltraps>

801074fe <vector134>:
.globl vector134
vector134:
  pushl $0
801074fe:	6a 00                	push   $0x0
  pushl $134
80107500:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107505:	e9 0d f6 ff ff       	jmp    80106b17 <alltraps>

8010750a <vector135>:
.globl vector135
vector135:
  pushl $0
8010750a:	6a 00                	push   $0x0
  pushl $135
8010750c:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107511:	e9 01 f6 ff ff       	jmp    80106b17 <alltraps>

80107516 <vector136>:
.globl vector136
vector136:
  pushl $0
80107516:	6a 00                	push   $0x0
  pushl $136
80107518:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010751d:	e9 f5 f5 ff ff       	jmp    80106b17 <alltraps>

80107522 <vector137>:
.globl vector137
vector137:
  pushl $0
80107522:	6a 00                	push   $0x0
  pushl $137
80107524:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80107529:	e9 e9 f5 ff ff       	jmp    80106b17 <alltraps>

8010752e <vector138>:
.globl vector138
vector138:
  pushl $0
8010752e:	6a 00                	push   $0x0
  pushl $138
80107530:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107535:	e9 dd f5 ff ff       	jmp    80106b17 <alltraps>

8010753a <vector139>:
.globl vector139
vector139:
  pushl $0
8010753a:	6a 00                	push   $0x0
  pushl $139
8010753c:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80107541:	e9 d1 f5 ff ff       	jmp    80106b17 <alltraps>

80107546 <vector140>:
.globl vector140
vector140:
  pushl $0
80107546:	6a 00                	push   $0x0
  pushl $140
80107548:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010754d:	e9 c5 f5 ff ff       	jmp    80106b17 <alltraps>

80107552 <vector141>:
.globl vector141
vector141:
  pushl $0
80107552:	6a 00                	push   $0x0
  pushl $141
80107554:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80107559:	e9 b9 f5 ff ff       	jmp    80106b17 <alltraps>

8010755e <vector142>:
.globl vector142
vector142:
  pushl $0
8010755e:	6a 00                	push   $0x0
  pushl $142
80107560:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107565:	e9 ad f5 ff ff       	jmp    80106b17 <alltraps>

8010756a <vector143>:
.globl vector143
vector143:
  pushl $0
8010756a:	6a 00                	push   $0x0
  pushl $143
8010756c:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80107571:	e9 a1 f5 ff ff       	jmp    80106b17 <alltraps>

80107576 <vector144>:
.globl vector144
vector144:
  pushl $0
80107576:	6a 00                	push   $0x0
  pushl $144
80107578:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010757d:	e9 95 f5 ff ff       	jmp    80106b17 <alltraps>

80107582 <vector145>:
.globl vector145
vector145:
  pushl $0
80107582:	6a 00                	push   $0x0
  pushl $145
80107584:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80107589:	e9 89 f5 ff ff       	jmp    80106b17 <alltraps>

8010758e <vector146>:
.globl vector146
vector146:
  pushl $0
8010758e:	6a 00                	push   $0x0
  pushl $146
80107590:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107595:	e9 7d f5 ff ff       	jmp    80106b17 <alltraps>

8010759a <vector147>:
.globl vector147
vector147:
  pushl $0
8010759a:	6a 00                	push   $0x0
  pushl $147
8010759c:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801075a1:	e9 71 f5 ff ff       	jmp    80106b17 <alltraps>

801075a6 <vector148>:
.globl vector148
vector148:
  pushl $0
801075a6:	6a 00                	push   $0x0
  pushl $148
801075a8:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801075ad:	e9 65 f5 ff ff       	jmp    80106b17 <alltraps>

801075b2 <vector149>:
.globl vector149
vector149:
  pushl $0
801075b2:	6a 00                	push   $0x0
  pushl $149
801075b4:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801075b9:	e9 59 f5 ff ff       	jmp    80106b17 <alltraps>

801075be <vector150>:
.globl vector150
vector150:
  pushl $0
801075be:	6a 00                	push   $0x0
  pushl $150
801075c0:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801075c5:	e9 4d f5 ff ff       	jmp    80106b17 <alltraps>

801075ca <vector151>:
.globl vector151
vector151:
  pushl $0
801075ca:	6a 00                	push   $0x0
  pushl $151
801075cc:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801075d1:	e9 41 f5 ff ff       	jmp    80106b17 <alltraps>

801075d6 <vector152>:
.globl vector152
vector152:
  pushl $0
801075d6:	6a 00                	push   $0x0
  pushl $152
801075d8:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801075dd:	e9 35 f5 ff ff       	jmp    80106b17 <alltraps>

801075e2 <vector153>:
.globl vector153
vector153:
  pushl $0
801075e2:	6a 00                	push   $0x0
  pushl $153
801075e4:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801075e9:	e9 29 f5 ff ff       	jmp    80106b17 <alltraps>

801075ee <vector154>:
.globl vector154
vector154:
  pushl $0
801075ee:	6a 00                	push   $0x0
  pushl $154
801075f0:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801075f5:	e9 1d f5 ff ff       	jmp    80106b17 <alltraps>

801075fa <vector155>:
.globl vector155
vector155:
  pushl $0
801075fa:	6a 00                	push   $0x0
  pushl $155
801075fc:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107601:	e9 11 f5 ff ff       	jmp    80106b17 <alltraps>

80107606 <vector156>:
.globl vector156
vector156:
  pushl $0
80107606:	6a 00                	push   $0x0
  pushl $156
80107608:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010760d:	e9 05 f5 ff ff       	jmp    80106b17 <alltraps>

80107612 <vector157>:
.globl vector157
vector157:
  pushl $0
80107612:	6a 00                	push   $0x0
  pushl $157
80107614:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80107619:	e9 f9 f4 ff ff       	jmp    80106b17 <alltraps>

8010761e <vector158>:
.globl vector158
vector158:
  pushl $0
8010761e:	6a 00                	push   $0x0
  pushl $158
80107620:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107625:	e9 ed f4 ff ff       	jmp    80106b17 <alltraps>

8010762a <vector159>:
.globl vector159
vector159:
  pushl $0
8010762a:	6a 00                	push   $0x0
  pushl $159
8010762c:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80107631:	e9 e1 f4 ff ff       	jmp    80106b17 <alltraps>

80107636 <vector160>:
.globl vector160
vector160:
  pushl $0
80107636:	6a 00                	push   $0x0
  pushl $160
80107638:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010763d:	e9 d5 f4 ff ff       	jmp    80106b17 <alltraps>

80107642 <vector161>:
.globl vector161
vector161:
  pushl $0
80107642:	6a 00                	push   $0x0
  pushl $161
80107644:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80107649:	e9 c9 f4 ff ff       	jmp    80106b17 <alltraps>

8010764e <vector162>:
.globl vector162
vector162:
  pushl $0
8010764e:	6a 00                	push   $0x0
  pushl $162
80107650:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107655:	e9 bd f4 ff ff       	jmp    80106b17 <alltraps>

8010765a <vector163>:
.globl vector163
vector163:
  pushl $0
8010765a:	6a 00                	push   $0x0
  pushl $163
8010765c:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80107661:	e9 b1 f4 ff ff       	jmp    80106b17 <alltraps>

80107666 <vector164>:
.globl vector164
vector164:
  pushl $0
80107666:	6a 00                	push   $0x0
  pushl $164
80107668:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010766d:	e9 a5 f4 ff ff       	jmp    80106b17 <alltraps>

80107672 <vector165>:
.globl vector165
vector165:
  pushl $0
80107672:	6a 00                	push   $0x0
  pushl $165
80107674:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80107679:	e9 99 f4 ff ff       	jmp    80106b17 <alltraps>

8010767e <vector166>:
.globl vector166
vector166:
  pushl $0
8010767e:	6a 00                	push   $0x0
  pushl $166
80107680:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107685:	e9 8d f4 ff ff       	jmp    80106b17 <alltraps>

8010768a <vector167>:
.globl vector167
vector167:
  pushl $0
8010768a:	6a 00                	push   $0x0
  pushl $167
8010768c:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107691:	e9 81 f4 ff ff       	jmp    80106b17 <alltraps>

80107696 <vector168>:
.globl vector168
vector168:
  pushl $0
80107696:	6a 00                	push   $0x0
  pushl $168
80107698:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010769d:	e9 75 f4 ff ff       	jmp    80106b17 <alltraps>

801076a2 <vector169>:
.globl vector169
vector169:
  pushl $0
801076a2:	6a 00                	push   $0x0
  pushl $169
801076a4:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801076a9:	e9 69 f4 ff ff       	jmp    80106b17 <alltraps>

801076ae <vector170>:
.globl vector170
vector170:
  pushl $0
801076ae:	6a 00                	push   $0x0
  pushl $170
801076b0:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801076b5:	e9 5d f4 ff ff       	jmp    80106b17 <alltraps>

801076ba <vector171>:
.globl vector171
vector171:
  pushl $0
801076ba:	6a 00                	push   $0x0
  pushl $171
801076bc:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801076c1:	e9 51 f4 ff ff       	jmp    80106b17 <alltraps>

801076c6 <vector172>:
.globl vector172
vector172:
  pushl $0
801076c6:	6a 00                	push   $0x0
  pushl $172
801076c8:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801076cd:	e9 45 f4 ff ff       	jmp    80106b17 <alltraps>

801076d2 <vector173>:
.globl vector173
vector173:
  pushl $0
801076d2:	6a 00                	push   $0x0
  pushl $173
801076d4:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801076d9:	e9 39 f4 ff ff       	jmp    80106b17 <alltraps>

801076de <vector174>:
.globl vector174
vector174:
  pushl $0
801076de:	6a 00                	push   $0x0
  pushl $174
801076e0:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801076e5:	e9 2d f4 ff ff       	jmp    80106b17 <alltraps>

801076ea <vector175>:
.globl vector175
vector175:
  pushl $0
801076ea:	6a 00                	push   $0x0
  pushl $175
801076ec:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801076f1:	e9 21 f4 ff ff       	jmp    80106b17 <alltraps>

801076f6 <vector176>:
.globl vector176
vector176:
  pushl $0
801076f6:	6a 00                	push   $0x0
  pushl $176
801076f8:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801076fd:	e9 15 f4 ff ff       	jmp    80106b17 <alltraps>

80107702 <vector177>:
.globl vector177
vector177:
  pushl $0
80107702:	6a 00                	push   $0x0
  pushl $177
80107704:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80107709:	e9 09 f4 ff ff       	jmp    80106b17 <alltraps>

8010770e <vector178>:
.globl vector178
vector178:
  pushl $0
8010770e:	6a 00                	push   $0x0
  pushl $178
80107710:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107715:	e9 fd f3 ff ff       	jmp    80106b17 <alltraps>

8010771a <vector179>:
.globl vector179
vector179:
  pushl $0
8010771a:	6a 00                	push   $0x0
  pushl $179
8010771c:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107721:	e9 f1 f3 ff ff       	jmp    80106b17 <alltraps>

80107726 <vector180>:
.globl vector180
vector180:
  pushl $0
80107726:	6a 00                	push   $0x0
  pushl $180
80107728:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010772d:	e9 e5 f3 ff ff       	jmp    80106b17 <alltraps>

80107732 <vector181>:
.globl vector181
vector181:
  pushl $0
80107732:	6a 00                	push   $0x0
  pushl $181
80107734:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80107739:	e9 d9 f3 ff ff       	jmp    80106b17 <alltraps>

8010773e <vector182>:
.globl vector182
vector182:
  pushl $0
8010773e:	6a 00                	push   $0x0
  pushl $182
80107740:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107745:	e9 cd f3 ff ff       	jmp    80106b17 <alltraps>

8010774a <vector183>:
.globl vector183
vector183:
  pushl $0
8010774a:	6a 00                	push   $0x0
  pushl $183
8010774c:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107751:	e9 c1 f3 ff ff       	jmp    80106b17 <alltraps>

80107756 <vector184>:
.globl vector184
vector184:
  pushl $0
80107756:	6a 00                	push   $0x0
  pushl $184
80107758:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010775d:	e9 b5 f3 ff ff       	jmp    80106b17 <alltraps>

80107762 <vector185>:
.globl vector185
vector185:
  pushl $0
80107762:	6a 00                	push   $0x0
  pushl $185
80107764:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80107769:	e9 a9 f3 ff ff       	jmp    80106b17 <alltraps>

8010776e <vector186>:
.globl vector186
vector186:
  pushl $0
8010776e:	6a 00                	push   $0x0
  pushl $186
80107770:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107775:	e9 9d f3 ff ff       	jmp    80106b17 <alltraps>

8010777a <vector187>:
.globl vector187
vector187:
  pushl $0
8010777a:	6a 00                	push   $0x0
  pushl $187
8010777c:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107781:	e9 91 f3 ff ff       	jmp    80106b17 <alltraps>

80107786 <vector188>:
.globl vector188
vector188:
  pushl $0
80107786:	6a 00                	push   $0x0
  pushl $188
80107788:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010778d:	e9 85 f3 ff ff       	jmp    80106b17 <alltraps>

80107792 <vector189>:
.globl vector189
vector189:
  pushl $0
80107792:	6a 00                	push   $0x0
  pushl $189
80107794:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80107799:	e9 79 f3 ff ff       	jmp    80106b17 <alltraps>

8010779e <vector190>:
.globl vector190
vector190:
  pushl $0
8010779e:	6a 00                	push   $0x0
  pushl $190
801077a0:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801077a5:	e9 6d f3 ff ff       	jmp    80106b17 <alltraps>

801077aa <vector191>:
.globl vector191
vector191:
  pushl $0
801077aa:	6a 00                	push   $0x0
  pushl $191
801077ac:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801077b1:	e9 61 f3 ff ff       	jmp    80106b17 <alltraps>

801077b6 <vector192>:
.globl vector192
vector192:
  pushl $0
801077b6:	6a 00                	push   $0x0
  pushl $192
801077b8:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801077bd:	e9 55 f3 ff ff       	jmp    80106b17 <alltraps>

801077c2 <vector193>:
.globl vector193
vector193:
  pushl $0
801077c2:	6a 00                	push   $0x0
  pushl $193
801077c4:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801077c9:	e9 49 f3 ff ff       	jmp    80106b17 <alltraps>

801077ce <vector194>:
.globl vector194
vector194:
  pushl $0
801077ce:	6a 00                	push   $0x0
  pushl $194
801077d0:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801077d5:	e9 3d f3 ff ff       	jmp    80106b17 <alltraps>

801077da <vector195>:
.globl vector195
vector195:
  pushl $0
801077da:	6a 00                	push   $0x0
  pushl $195
801077dc:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801077e1:	e9 31 f3 ff ff       	jmp    80106b17 <alltraps>

801077e6 <vector196>:
.globl vector196
vector196:
  pushl $0
801077e6:	6a 00                	push   $0x0
  pushl $196
801077e8:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801077ed:	e9 25 f3 ff ff       	jmp    80106b17 <alltraps>

801077f2 <vector197>:
.globl vector197
vector197:
  pushl $0
801077f2:	6a 00                	push   $0x0
  pushl $197
801077f4:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801077f9:	e9 19 f3 ff ff       	jmp    80106b17 <alltraps>

801077fe <vector198>:
.globl vector198
vector198:
  pushl $0
801077fe:	6a 00                	push   $0x0
  pushl $198
80107800:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107805:	e9 0d f3 ff ff       	jmp    80106b17 <alltraps>

8010780a <vector199>:
.globl vector199
vector199:
  pushl $0
8010780a:	6a 00                	push   $0x0
  pushl $199
8010780c:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107811:	e9 01 f3 ff ff       	jmp    80106b17 <alltraps>

80107816 <vector200>:
.globl vector200
vector200:
  pushl $0
80107816:	6a 00                	push   $0x0
  pushl $200
80107818:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010781d:	e9 f5 f2 ff ff       	jmp    80106b17 <alltraps>

80107822 <vector201>:
.globl vector201
vector201:
  pushl $0
80107822:	6a 00                	push   $0x0
  pushl $201
80107824:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80107829:	e9 e9 f2 ff ff       	jmp    80106b17 <alltraps>

8010782e <vector202>:
.globl vector202
vector202:
  pushl $0
8010782e:	6a 00                	push   $0x0
  pushl $202
80107830:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107835:	e9 dd f2 ff ff       	jmp    80106b17 <alltraps>

8010783a <vector203>:
.globl vector203
vector203:
  pushl $0
8010783a:	6a 00                	push   $0x0
  pushl $203
8010783c:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107841:	e9 d1 f2 ff ff       	jmp    80106b17 <alltraps>

80107846 <vector204>:
.globl vector204
vector204:
  pushl $0
80107846:	6a 00                	push   $0x0
  pushl $204
80107848:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010784d:	e9 c5 f2 ff ff       	jmp    80106b17 <alltraps>

80107852 <vector205>:
.globl vector205
vector205:
  pushl $0
80107852:	6a 00                	push   $0x0
  pushl $205
80107854:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80107859:	e9 b9 f2 ff ff       	jmp    80106b17 <alltraps>

8010785e <vector206>:
.globl vector206
vector206:
  pushl $0
8010785e:	6a 00                	push   $0x0
  pushl $206
80107860:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107865:	e9 ad f2 ff ff       	jmp    80106b17 <alltraps>

8010786a <vector207>:
.globl vector207
vector207:
  pushl $0
8010786a:	6a 00                	push   $0x0
  pushl $207
8010786c:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107871:	e9 a1 f2 ff ff       	jmp    80106b17 <alltraps>

80107876 <vector208>:
.globl vector208
vector208:
  pushl $0
80107876:	6a 00                	push   $0x0
  pushl $208
80107878:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010787d:	e9 95 f2 ff ff       	jmp    80106b17 <alltraps>

80107882 <vector209>:
.globl vector209
vector209:
  pushl $0
80107882:	6a 00                	push   $0x0
  pushl $209
80107884:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80107889:	e9 89 f2 ff ff       	jmp    80106b17 <alltraps>

8010788e <vector210>:
.globl vector210
vector210:
  pushl $0
8010788e:	6a 00                	push   $0x0
  pushl $210
80107890:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107895:	e9 7d f2 ff ff       	jmp    80106b17 <alltraps>

8010789a <vector211>:
.globl vector211
vector211:
  pushl $0
8010789a:	6a 00                	push   $0x0
  pushl $211
8010789c:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801078a1:	e9 71 f2 ff ff       	jmp    80106b17 <alltraps>

801078a6 <vector212>:
.globl vector212
vector212:
  pushl $0
801078a6:	6a 00                	push   $0x0
  pushl $212
801078a8:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801078ad:	e9 65 f2 ff ff       	jmp    80106b17 <alltraps>

801078b2 <vector213>:
.globl vector213
vector213:
  pushl $0
801078b2:	6a 00                	push   $0x0
  pushl $213
801078b4:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801078b9:	e9 59 f2 ff ff       	jmp    80106b17 <alltraps>

801078be <vector214>:
.globl vector214
vector214:
  pushl $0
801078be:	6a 00                	push   $0x0
  pushl $214
801078c0:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801078c5:	e9 4d f2 ff ff       	jmp    80106b17 <alltraps>

801078ca <vector215>:
.globl vector215
vector215:
  pushl $0
801078ca:	6a 00                	push   $0x0
  pushl $215
801078cc:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801078d1:	e9 41 f2 ff ff       	jmp    80106b17 <alltraps>

801078d6 <vector216>:
.globl vector216
vector216:
  pushl $0
801078d6:	6a 00                	push   $0x0
  pushl $216
801078d8:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801078dd:	e9 35 f2 ff ff       	jmp    80106b17 <alltraps>

801078e2 <vector217>:
.globl vector217
vector217:
  pushl $0
801078e2:	6a 00                	push   $0x0
  pushl $217
801078e4:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801078e9:	e9 29 f2 ff ff       	jmp    80106b17 <alltraps>

801078ee <vector218>:
.globl vector218
vector218:
  pushl $0
801078ee:	6a 00                	push   $0x0
  pushl $218
801078f0:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801078f5:	e9 1d f2 ff ff       	jmp    80106b17 <alltraps>

801078fa <vector219>:
.globl vector219
vector219:
  pushl $0
801078fa:	6a 00                	push   $0x0
  pushl $219
801078fc:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107901:	e9 11 f2 ff ff       	jmp    80106b17 <alltraps>

80107906 <vector220>:
.globl vector220
vector220:
  pushl $0
80107906:	6a 00                	push   $0x0
  pushl $220
80107908:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010790d:	e9 05 f2 ff ff       	jmp    80106b17 <alltraps>

80107912 <vector221>:
.globl vector221
vector221:
  pushl $0
80107912:	6a 00                	push   $0x0
  pushl $221
80107914:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80107919:	e9 f9 f1 ff ff       	jmp    80106b17 <alltraps>

8010791e <vector222>:
.globl vector222
vector222:
  pushl $0
8010791e:	6a 00                	push   $0x0
  pushl $222
80107920:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107925:	e9 ed f1 ff ff       	jmp    80106b17 <alltraps>

8010792a <vector223>:
.globl vector223
vector223:
  pushl $0
8010792a:	6a 00                	push   $0x0
  pushl $223
8010792c:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107931:	e9 e1 f1 ff ff       	jmp    80106b17 <alltraps>

80107936 <vector224>:
.globl vector224
vector224:
  pushl $0
80107936:	6a 00                	push   $0x0
  pushl $224
80107938:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010793d:	e9 d5 f1 ff ff       	jmp    80106b17 <alltraps>

80107942 <vector225>:
.globl vector225
vector225:
  pushl $0
80107942:	6a 00                	push   $0x0
  pushl $225
80107944:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107949:	e9 c9 f1 ff ff       	jmp    80106b17 <alltraps>

8010794e <vector226>:
.globl vector226
vector226:
  pushl $0
8010794e:	6a 00                	push   $0x0
  pushl $226
80107950:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107955:	e9 bd f1 ff ff       	jmp    80106b17 <alltraps>

8010795a <vector227>:
.globl vector227
vector227:
  pushl $0
8010795a:	6a 00                	push   $0x0
  pushl $227
8010795c:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107961:	e9 b1 f1 ff ff       	jmp    80106b17 <alltraps>

80107966 <vector228>:
.globl vector228
vector228:
  pushl $0
80107966:	6a 00                	push   $0x0
  pushl $228
80107968:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010796d:	e9 a5 f1 ff ff       	jmp    80106b17 <alltraps>

80107972 <vector229>:
.globl vector229
vector229:
  pushl $0
80107972:	6a 00                	push   $0x0
  pushl $229
80107974:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107979:	e9 99 f1 ff ff       	jmp    80106b17 <alltraps>

8010797e <vector230>:
.globl vector230
vector230:
  pushl $0
8010797e:	6a 00                	push   $0x0
  pushl $230
80107980:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107985:	e9 8d f1 ff ff       	jmp    80106b17 <alltraps>

8010798a <vector231>:
.globl vector231
vector231:
  pushl $0
8010798a:	6a 00                	push   $0x0
  pushl $231
8010798c:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107991:	e9 81 f1 ff ff       	jmp    80106b17 <alltraps>

80107996 <vector232>:
.globl vector232
vector232:
  pushl $0
80107996:	6a 00                	push   $0x0
  pushl $232
80107998:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010799d:	e9 75 f1 ff ff       	jmp    80106b17 <alltraps>

801079a2 <vector233>:
.globl vector233
vector233:
  pushl $0
801079a2:	6a 00                	push   $0x0
  pushl $233
801079a4:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801079a9:	e9 69 f1 ff ff       	jmp    80106b17 <alltraps>

801079ae <vector234>:
.globl vector234
vector234:
  pushl $0
801079ae:	6a 00                	push   $0x0
  pushl $234
801079b0:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801079b5:	e9 5d f1 ff ff       	jmp    80106b17 <alltraps>

801079ba <vector235>:
.globl vector235
vector235:
  pushl $0
801079ba:	6a 00                	push   $0x0
  pushl $235
801079bc:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801079c1:	e9 51 f1 ff ff       	jmp    80106b17 <alltraps>

801079c6 <vector236>:
.globl vector236
vector236:
  pushl $0
801079c6:	6a 00                	push   $0x0
  pushl $236
801079c8:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801079cd:	e9 45 f1 ff ff       	jmp    80106b17 <alltraps>

801079d2 <vector237>:
.globl vector237
vector237:
  pushl $0
801079d2:	6a 00                	push   $0x0
  pushl $237
801079d4:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801079d9:	e9 39 f1 ff ff       	jmp    80106b17 <alltraps>

801079de <vector238>:
.globl vector238
vector238:
  pushl $0
801079de:	6a 00                	push   $0x0
  pushl $238
801079e0:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801079e5:	e9 2d f1 ff ff       	jmp    80106b17 <alltraps>

801079ea <vector239>:
.globl vector239
vector239:
  pushl $0
801079ea:	6a 00                	push   $0x0
  pushl $239
801079ec:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801079f1:	e9 21 f1 ff ff       	jmp    80106b17 <alltraps>

801079f6 <vector240>:
.globl vector240
vector240:
  pushl $0
801079f6:	6a 00                	push   $0x0
  pushl $240
801079f8:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801079fd:	e9 15 f1 ff ff       	jmp    80106b17 <alltraps>

80107a02 <vector241>:
.globl vector241
vector241:
  pushl $0
80107a02:	6a 00                	push   $0x0
  pushl $241
80107a04:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107a09:	e9 09 f1 ff ff       	jmp    80106b17 <alltraps>

80107a0e <vector242>:
.globl vector242
vector242:
  pushl $0
80107a0e:	6a 00                	push   $0x0
  pushl $242
80107a10:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107a15:	e9 fd f0 ff ff       	jmp    80106b17 <alltraps>

80107a1a <vector243>:
.globl vector243
vector243:
  pushl $0
80107a1a:	6a 00                	push   $0x0
  pushl $243
80107a1c:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107a21:	e9 f1 f0 ff ff       	jmp    80106b17 <alltraps>

80107a26 <vector244>:
.globl vector244
vector244:
  pushl $0
80107a26:	6a 00                	push   $0x0
  pushl $244
80107a28:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107a2d:	e9 e5 f0 ff ff       	jmp    80106b17 <alltraps>

80107a32 <vector245>:
.globl vector245
vector245:
  pushl $0
80107a32:	6a 00                	push   $0x0
  pushl $245
80107a34:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107a39:	e9 d9 f0 ff ff       	jmp    80106b17 <alltraps>

80107a3e <vector246>:
.globl vector246
vector246:
  pushl $0
80107a3e:	6a 00                	push   $0x0
  pushl $246
80107a40:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107a45:	e9 cd f0 ff ff       	jmp    80106b17 <alltraps>

80107a4a <vector247>:
.globl vector247
vector247:
  pushl $0
80107a4a:	6a 00                	push   $0x0
  pushl $247
80107a4c:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107a51:	e9 c1 f0 ff ff       	jmp    80106b17 <alltraps>

80107a56 <vector248>:
.globl vector248
vector248:
  pushl $0
80107a56:	6a 00                	push   $0x0
  pushl $248
80107a58:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107a5d:	e9 b5 f0 ff ff       	jmp    80106b17 <alltraps>

80107a62 <vector249>:
.globl vector249
vector249:
  pushl $0
80107a62:	6a 00                	push   $0x0
  pushl $249
80107a64:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107a69:	e9 a9 f0 ff ff       	jmp    80106b17 <alltraps>

80107a6e <vector250>:
.globl vector250
vector250:
  pushl $0
80107a6e:	6a 00                	push   $0x0
  pushl $250
80107a70:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107a75:	e9 9d f0 ff ff       	jmp    80106b17 <alltraps>

80107a7a <vector251>:
.globl vector251
vector251:
  pushl $0
80107a7a:	6a 00                	push   $0x0
  pushl $251
80107a7c:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107a81:	e9 91 f0 ff ff       	jmp    80106b17 <alltraps>

80107a86 <vector252>:
.globl vector252
vector252:
  pushl $0
80107a86:	6a 00                	push   $0x0
  pushl $252
80107a88:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107a8d:	e9 85 f0 ff ff       	jmp    80106b17 <alltraps>

80107a92 <vector253>:
.globl vector253
vector253:
  pushl $0
80107a92:	6a 00                	push   $0x0
  pushl $253
80107a94:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107a99:	e9 79 f0 ff ff       	jmp    80106b17 <alltraps>

80107a9e <vector254>:
.globl vector254
vector254:
  pushl $0
80107a9e:	6a 00                	push   $0x0
  pushl $254
80107aa0:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107aa5:	e9 6d f0 ff ff       	jmp    80106b17 <alltraps>

80107aaa <vector255>:
.globl vector255
vector255:
  pushl $0
80107aaa:	6a 00                	push   $0x0
  pushl $255
80107aac:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107ab1:	e9 61 f0 ff ff       	jmp    80106b17 <alltraps>
80107ab6:	66 90                	xchg   %ax,%ax
80107ab8:	66 90                	xchg   %ax,%ax
80107aba:	66 90                	xchg   %ax,%ax
80107abc:	66 90                	xchg   %ax,%ax
80107abe:	66 90                	xchg   %ax,%ax

80107ac0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107ac0:	55                   	push   %ebp
80107ac1:	89 e5                	mov    %esp,%ebp
80107ac3:	83 ec 28             	sub    $0x28,%esp
80107ac6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107ac9:	89 d3                	mov    %edx,%ebx
80107acb:	c1 eb 16             	shr    $0x16,%ebx
{
80107ace:	89 75 f8             	mov    %esi,-0x8(%ebp)
  pde = &pgdir[PDX(va)];
80107ad1:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80107ad4:	89 7d fc             	mov    %edi,-0x4(%ebp)
80107ad7:	89 d7                	mov    %edx,%edi
  if(*pde & PTE_P){
80107ad9:	8b 06                	mov    (%esi),%eax
80107adb:	a8 01                	test   $0x1,%al
80107add:	74 29                	je     80107b08 <walkpgdir+0x48>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107adf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107ae4:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107aea:	c1 ef 0a             	shr    $0xa,%edi
}
80107aed:	8b 75 f8             	mov    -0x8(%ebp),%esi
  return &pgtab[PTX(va)];
80107af0:	89 fa                	mov    %edi,%edx
}
80107af2:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return &pgtab[PTX(va)];
80107af5:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107afb:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80107afe:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107b01:	89 ec                	mov    %ebp,%esp
80107b03:	5d                   	pop    %ebp
80107b04:	c3                   	ret    
80107b05:	8d 76 00             	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107b08:	85 c9                	test   %ecx,%ecx
80107b0a:	74 34                	je     80107b40 <walkpgdir+0x80>
80107b0c:	e8 9f aa ff ff       	call   801025b0 <kalloc>
80107b11:	85 c0                	test   %eax,%eax
80107b13:	89 c3                	mov    %eax,%ebx
80107b15:	74 29                	je     80107b40 <walkpgdir+0x80>
    memset(pgtab, 0, PGSIZE);
80107b17:	b8 00 10 00 00       	mov    $0x1000,%eax
80107b1c:	31 d2                	xor    %edx,%edx
80107b1e:	89 44 24 08          	mov    %eax,0x8(%esp)
80107b22:	89 54 24 04          	mov    %edx,0x4(%esp)
80107b26:	89 1c 24             	mov    %ebx,(%esp)
80107b29:	e8 42 dd ff ff       	call   80105870 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107b2e:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107b34:	83 c8 07             	or     $0x7,%eax
80107b37:	89 06                	mov    %eax,(%esi)
80107b39:	eb af                	jmp    80107aea <walkpgdir+0x2a>
80107b3b:	90                   	nop
80107b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80107b40:	8b 5d f4             	mov    -0xc(%ebp),%ebx
      return 0;
80107b43:	31 c0                	xor    %eax,%eax
}
80107b45:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107b48:	8b 7d fc             	mov    -0x4(%ebp),%edi
80107b4b:	89 ec                	mov    %ebp,%esp
80107b4d:	5d                   	pop    %ebp
80107b4e:	c3                   	ret    
80107b4f:	90                   	nop

80107b50 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107b50:	55                   	push   %ebp
80107b51:	89 e5                	mov    %esp,%ebp
80107b53:	57                   	push   %edi
80107b54:	56                   	push   %esi
80107b55:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107b56:	89 d3                	mov    %edx,%ebx
{
80107b58:	83 ec 2c             	sub    $0x2c,%esp
  a = (char*)PGROUNDDOWN((uint)va);
80107b5b:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80107b61:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107b64:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107b68:	8b 7d 08             	mov    0x8(%ebp),%edi
80107b6b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107b70:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80107b73:	8b 45 0c             	mov    0xc(%ebp),%eax
80107b76:	29 df                	sub    %ebx,%edi
80107b78:	83 c8 01             	or     $0x1,%eax
80107b7b:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107b7e:	eb 17                	jmp    80107b97 <mappages+0x47>
    if(*pte & PTE_P)
80107b80:	f6 00 01             	testb  $0x1,(%eax)
80107b83:	75 45                	jne    80107bca <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80107b85:	8b 55 dc             	mov    -0x24(%ebp),%edx
80107b88:	09 d6                	or     %edx,%esi
    if(a == last)
80107b8a:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
80107b8d:	89 30                	mov    %esi,(%eax)
    if(a == last)
80107b8f:	74 2f                	je     80107bc0 <mappages+0x70>
      break;
    a += PGSIZE;
80107b91:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107b97:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107b9a:	b9 01 00 00 00       	mov    $0x1,%ecx
80107b9f:	89 da                	mov    %ebx,%edx
80107ba1:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107ba4:	e8 17 ff ff ff       	call   80107ac0 <walkpgdir>
80107ba9:	85 c0                	test   %eax,%eax
80107bab:	75 d3                	jne    80107b80 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80107bad:	83 c4 2c             	add    $0x2c,%esp
      return -1;
80107bb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107bb5:	5b                   	pop    %ebx
80107bb6:	5e                   	pop    %esi
80107bb7:	5f                   	pop    %edi
80107bb8:	5d                   	pop    %ebp
80107bb9:	c3                   	ret    
80107bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107bc0:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80107bc3:	31 c0                	xor    %eax,%eax
}
80107bc5:	5b                   	pop    %ebx
80107bc6:	5e                   	pop    %esi
80107bc7:	5f                   	pop    %edi
80107bc8:	5d                   	pop    %ebp
80107bc9:	c3                   	ret    
      panic("remap");
80107bca:	c7 04 24 74 8d 10 80 	movl   $0x80108d74,(%esp)
80107bd1:	e8 9a 87 ff ff       	call   80100370 <panic>
80107bd6:	8d 76 00             	lea    0x0(%esi),%esi
80107bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107be0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107be0:	55                   	push   %ebp
80107be1:	89 e5                	mov    %esp,%ebp
80107be3:	57                   	push   %edi
80107be4:	89 c7                	mov    %eax,%edi
80107be6:	56                   	push   %esi
80107be7:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107be8:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107bee:	83 ec 2c             	sub    $0x2c,%esp
  a = PGROUNDUP(newsz);
80107bf1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107bf7:	39 d3                	cmp    %edx,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107bf9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107bfc:	73 62                	jae    80107c60 <deallocuvm.part.0+0x80>
80107bfe:	89 d6                	mov    %edx,%esi
80107c00:	eb 39                	jmp    80107c3b <deallocuvm.part.0+0x5b>
80107c02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80107c08:	8b 10                	mov    (%eax),%edx
80107c0a:	f6 c2 01             	test   $0x1,%dl
80107c0d:	74 22                	je     80107c31 <deallocuvm.part.0+0x51>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80107c0f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107c15:	74 54                	je     80107c6b <deallocuvm.part.0+0x8b>
        panic("kfree");
      char *v = P2V(pa);
80107c17:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
80107c1d:	89 14 24             	mov    %edx,(%esp)
80107c20:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107c23:	e8 b8 a7 ff ff       	call   801023e0 <kfree>
      *pte = 0;
80107c28:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107c2b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80107c31:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107c37:	39 f3                	cmp    %esi,%ebx
80107c39:	73 25                	jae    80107c60 <deallocuvm.part.0+0x80>
    pte = walkpgdir(pgdir, (char*)a, 0);
80107c3b:	31 c9                	xor    %ecx,%ecx
80107c3d:	89 da                	mov    %ebx,%edx
80107c3f:	89 f8                	mov    %edi,%eax
80107c41:	e8 7a fe ff ff       	call   80107ac0 <walkpgdir>
    if(!pte)
80107c46:	85 c0                	test   %eax,%eax
80107c48:	75 be                	jne    80107c08 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107c4a:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80107c50:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107c56:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107c5c:	39 f3                	cmp    %esi,%ebx
80107c5e:	72 db                	jb     80107c3b <deallocuvm.part.0+0x5b>
    }
  }
  return newsz;
}
80107c60:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107c63:	83 c4 2c             	add    $0x2c,%esp
80107c66:	5b                   	pop    %ebx
80107c67:	5e                   	pop    %esi
80107c68:	5f                   	pop    %edi
80107c69:	5d                   	pop    %ebp
80107c6a:	c3                   	ret    
        panic("kfree");
80107c6b:	c7 04 24 86 86 10 80 	movl   $0x80108686,(%esp)
80107c72:	e8 f9 86 ff ff       	call   80100370 <panic>
80107c77:	89 f6                	mov    %esi,%esi
80107c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107c80 <seginit>:
{
80107c80:	55                   	push   %ebp
80107c81:	89 e5                	mov    %esp,%ebp
80107c83:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107c86:	e8 d5 bc ff ff       	call   80103960 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107c8b:	b9 00 9a cf 00       	mov    $0xcf9a00,%ecx
  pd[0] = size-1;
80107c90:	66 c7 45 f2 2f 00    	movw   $0x2f,-0xe(%ebp)
80107c96:	8d 14 80             	lea    (%eax,%eax,4),%edx
80107c99:	8d 04 50             	lea    (%eax,%edx,2),%eax
80107c9c:	ba ff ff 00 00       	mov    $0xffff,%edx
80107ca1:	c1 e0 04             	shl    $0x4,%eax
80107ca4:	89 90 58 38 11 80    	mov    %edx,-0x7feec7a8(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107caa:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107caf:	89 88 5c 38 11 80    	mov    %ecx,-0x7feec7a4(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107cb5:	b9 00 92 cf 00       	mov    $0xcf9200,%ecx
80107cba:	89 90 60 38 11 80    	mov    %edx,-0x7feec7a0(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107cc0:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107cc5:	89 88 64 38 11 80    	mov    %ecx,-0x7feec79c(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107ccb:	b9 00 fa cf 00       	mov    $0xcffa00,%ecx
80107cd0:	89 90 68 38 11 80    	mov    %edx,-0x7feec798(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107cd6:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107cdb:	89 88 6c 38 11 80    	mov    %ecx,-0x7feec794(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107ce1:	b9 00 f2 cf 00       	mov    $0xcff200,%ecx
80107ce6:	89 90 70 38 11 80    	mov    %edx,-0x7feec790(%eax)
80107cec:	89 88 74 38 11 80    	mov    %ecx,-0x7feec78c(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80107cf2:	05 50 38 11 80       	add    $0x80113850,%eax
  pd[1] = (uint)p;
80107cf7:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
80107cfa:	c1 e8 10             	shr    $0x10,%eax
  pd[1] = (uint)p;
80107cfd:	66 89 55 f4          	mov    %dx,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107d01:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80107d05:	8d 45 f2             	lea    -0xe(%ebp),%eax
80107d08:	0f 01 10             	lgdtl  (%eax)
}
80107d0b:	c9                   	leave  
80107d0c:	c3                   	ret    
80107d0d:	8d 76 00             	lea    0x0(%esi),%esi

80107d10 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107d10:	a1 04 69 11 80       	mov    0x80116904,%eax
{
80107d15:	55                   	push   %ebp
80107d16:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107d18:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107d1d:	0f 22 d8             	mov    %eax,%cr3
}
80107d20:	5d                   	pop    %ebp
80107d21:	c3                   	ret    
80107d22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107d30 <switchuvm>:
{
80107d30:	55                   	push   %ebp
80107d31:	89 e5                	mov    %esp,%ebp
80107d33:	57                   	push   %edi
80107d34:	56                   	push   %esi
80107d35:	53                   	push   %ebx
80107d36:	83 ec 2c             	sub    $0x2c,%esp
80107d39:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
80107d3c:	85 db                	test   %ebx,%ebx
80107d3e:	0f 84 c5 00 00 00    	je     80107e09 <switchuvm+0xd9>
  if(p->kstack == 0)
80107d44:	8b 7b 08             	mov    0x8(%ebx),%edi
80107d47:	85 ff                	test   %edi,%edi
80107d49:	0f 84 d2 00 00 00    	je     80107e21 <switchuvm+0xf1>
  if(p->pgdir == 0)
80107d4f:	8b 73 04             	mov    0x4(%ebx),%esi
80107d52:	85 f6                	test   %esi,%esi
80107d54:	0f 84 bb 00 00 00    	je     80107e15 <switchuvm+0xe5>
  pushcli();
80107d5a:	e8 41 d9 ff ff       	call   801056a0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107d5f:	e8 7c bb ff ff       	call   801038e0 <mycpu>
80107d64:	89 c6                	mov    %eax,%esi
80107d66:	e8 75 bb ff ff       	call   801038e0 <mycpu>
80107d6b:	89 c7                	mov    %eax,%edi
80107d6d:	e8 6e bb ff ff       	call   801038e0 <mycpu>
80107d72:	83 c7 08             	add    $0x8,%edi
80107d75:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107d78:	e8 63 bb ff ff       	call   801038e0 <mycpu>
80107d7d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107d80:	ba 67 00 00 00       	mov    $0x67,%edx
80107d85:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80107d8c:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80107d93:	83 c1 08             	add    $0x8,%ecx
80107d96:	c1 e9 10             	shr    $0x10,%ecx
80107d99:	83 c0 08             	add    $0x8,%eax
80107d9c:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80107da2:	c1 e8 18             	shr    $0x18,%eax
80107da5:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107daa:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
80107db1:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->gdt[SEG_TSS].s = 0;
80107db7:	e8 24 bb ff ff       	call   801038e0 <mycpu>
80107dbc:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107dc3:	e8 18 bb ff ff       	call   801038e0 <mycpu>
80107dc8:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107dce:	8b 73 08             	mov    0x8(%ebx),%esi
80107dd1:	e8 0a bb ff ff       	call   801038e0 <mycpu>
80107dd6:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107ddc:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107ddf:	e8 fc ba ff ff       	call   801038e0 <mycpu>
80107de4:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107dea:	b8 28 00 00 00       	mov    $0x28,%eax
80107def:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107df2:	8b 43 04             	mov    0x4(%ebx),%eax
80107df5:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107dfa:	0f 22 d8             	mov    %eax,%cr3
}
80107dfd:	83 c4 2c             	add    $0x2c,%esp
80107e00:	5b                   	pop    %ebx
80107e01:	5e                   	pop    %esi
80107e02:	5f                   	pop    %edi
80107e03:	5d                   	pop    %ebp
  popcli();
80107e04:	e9 d7 d8 ff ff       	jmp    801056e0 <popcli>
    panic("switchuvm: no process");
80107e09:	c7 04 24 7a 8d 10 80 	movl   $0x80108d7a,(%esp)
80107e10:	e8 5b 85 ff ff       	call   80100370 <panic>
    panic("switchuvm: no pgdir");
80107e15:	c7 04 24 a5 8d 10 80 	movl   $0x80108da5,(%esp)
80107e1c:	e8 4f 85 ff ff       	call   80100370 <panic>
    panic("switchuvm: no kstack");
80107e21:	c7 04 24 90 8d 10 80 	movl   $0x80108d90,(%esp)
80107e28:	e8 43 85 ff ff       	call   80100370 <panic>
80107e2d:	8d 76 00             	lea    0x0(%esi),%esi

80107e30 <inituvm>:
{
80107e30:	55                   	push   %ebp
80107e31:	89 e5                	mov    %esp,%ebp
80107e33:	83 ec 38             	sub    $0x38,%esp
80107e36:	89 75 f8             	mov    %esi,-0x8(%ebp)
80107e39:	8b 75 10             	mov    0x10(%ebp),%esi
80107e3c:	8b 45 08             	mov    0x8(%ebp),%eax
80107e3f:	89 7d fc             	mov    %edi,-0x4(%ebp)
80107e42:	8b 7d 0c             	mov    0xc(%ebp),%edi
80107e45:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  if(sz >= PGSIZE)
80107e48:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80107e4e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107e51:	77 59                	ja     80107eac <inituvm+0x7c>
  mem = kalloc();
80107e53:	e8 58 a7 ff ff       	call   801025b0 <kalloc>
  memset(mem, 0, PGSIZE);
80107e58:	31 d2                	xor    %edx,%edx
80107e5a:	89 54 24 04          	mov    %edx,0x4(%esp)
  mem = kalloc();
80107e5e:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107e60:	b8 00 10 00 00       	mov    $0x1000,%eax
80107e65:	89 1c 24             	mov    %ebx,(%esp)
80107e68:	89 44 24 08          	mov    %eax,0x8(%esp)
80107e6c:	e8 ff d9 ff ff       	call   80105870 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107e71:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107e77:	b9 06 00 00 00       	mov    $0x6,%ecx
80107e7c:	89 04 24             	mov    %eax,(%esp)
80107e7f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107e82:	31 d2                	xor    %edx,%edx
80107e84:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80107e88:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107e8d:	e8 be fc ff ff       	call   80107b50 <mappages>
  memmove(mem, init, sz);
80107e92:	89 75 10             	mov    %esi,0x10(%ebp)
}
80107e95:	8b 75 f8             	mov    -0x8(%ebp),%esi
  memmove(mem, init, sz);
80107e98:	89 7d 0c             	mov    %edi,0xc(%ebp)
}
80107e9b:	8b 7d fc             	mov    -0x4(%ebp),%edi
  memmove(mem, init, sz);
80107e9e:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80107ea1:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107ea4:	89 ec                	mov    %ebp,%esp
80107ea6:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107ea7:	e9 84 da ff ff       	jmp    80105930 <memmove>
    panic("inituvm: more than a page");
80107eac:	c7 04 24 b9 8d 10 80 	movl   $0x80108db9,(%esp)
80107eb3:	e8 b8 84 ff ff       	call   80100370 <panic>
80107eb8:	90                   	nop
80107eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107ec0 <loaduvm>:
{
80107ec0:	55                   	push   %ebp
80107ec1:	89 e5                	mov    %esp,%ebp
80107ec3:	57                   	push   %edi
80107ec4:	56                   	push   %esi
80107ec5:	53                   	push   %ebx
80107ec6:	83 ec 1c             	sub    $0x1c,%esp
  if((uint) addr % PGSIZE != 0)
80107ec9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107ed0:	0f 85 98 00 00 00    	jne    80107f6e <loaduvm+0xae>
  for(i = 0; i < sz; i += PGSIZE){
80107ed6:	8b 75 18             	mov    0x18(%ebp),%esi
80107ed9:	31 db                	xor    %ebx,%ebx
80107edb:	85 f6                	test   %esi,%esi
80107edd:	75 1a                	jne    80107ef9 <loaduvm+0x39>
80107edf:	eb 77                	jmp    80107f58 <loaduvm+0x98>
80107ee1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107ee8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107eee:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80107ef4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80107ef7:	76 5f                	jbe    80107f58 <loaduvm+0x98>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107ef9:	8b 55 0c             	mov    0xc(%ebp),%edx
80107efc:	31 c9                	xor    %ecx,%ecx
80107efe:	8b 45 08             	mov    0x8(%ebp),%eax
80107f01:	01 da                	add    %ebx,%edx
80107f03:	e8 b8 fb ff ff       	call   80107ac0 <walkpgdir>
80107f08:	85 c0                	test   %eax,%eax
80107f0a:	74 56                	je     80107f62 <loaduvm+0xa2>
    pa = PTE_ADDR(*pte);
80107f0c:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
80107f0e:	bf 00 10 00 00       	mov    $0x1000,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107f13:	8b 4d 14             	mov    0x14(%ebp),%ecx
    pa = PTE_ADDR(*pte);
80107f16:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80107f1b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80107f21:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107f24:	05 00 00 00 80       	add    $0x80000000,%eax
80107f29:	89 44 24 04          	mov    %eax,0x4(%esp)
80107f2d:	8b 45 10             	mov    0x10(%ebp),%eax
80107f30:	01 d9                	add    %ebx,%ecx
80107f32:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80107f36:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80107f3a:	89 04 24             	mov    %eax,(%esp)
80107f3d:	e8 8e 9a ff ff       	call   801019d0 <readi>
80107f42:	39 f8                	cmp    %edi,%eax
80107f44:	74 a2                	je     80107ee8 <loaduvm+0x28>
}
80107f46:	83 c4 1c             	add    $0x1c,%esp
      return -1;
80107f49:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107f4e:	5b                   	pop    %ebx
80107f4f:	5e                   	pop    %esi
80107f50:	5f                   	pop    %edi
80107f51:	5d                   	pop    %ebp
80107f52:	c3                   	ret    
80107f53:	90                   	nop
80107f54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107f58:	83 c4 1c             	add    $0x1c,%esp
  return 0;
80107f5b:	31 c0                	xor    %eax,%eax
}
80107f5d:	5b                   	pop    %ebx
80107f5e:	5e                   	pop    %esi
80107f5f:	5f                   	pop    %edi
80107f60:	5d                   	pop    %ebp
80107f61:	c3                   	ret    
      panic("loaduvm: address should exist");
80107f62:	c7 04 24 d3 8d 10 80 	movl   $0x80108dd3,(%esp)
80107f69:	e8 02 84 ff ff       	call   80100370 <panic>
    panic("loaduvm: addr must be page aligned");
80107f6e:	c7 04 24 74 8e 10 80 	movl   $0x80108e74,(%esp)
80107f75:	e8 f6 83 ff ff       	call   80100370 <panic>
80107f7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107f80 <allocuvm>:
{
80107f80:	55                   	push   %ebp
80107f81:	89 e5                	mov    %esp,%ebp
80107f83:	57                   	push   %edi
80107f84:	56                   	push   %esi
80107f85:	53                   	push   %ebx
80107f86:	83 ec 2c             	sub    $0x2c,%esp
  if(newsz >= KERNBASE)
80107f89:	8b 7d 10             	mov    0x10(%ebp),%edi
80107f8c:	85 ff                	test   %edi,%edi
80107f8e:	0f 88 91 00 00 00    	js     80108025 <allocuvm+0xa5>
  if(newsz < oldsz)
80107f94:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80107f97:	0f 82 9b 00 00 00    	jb     80108038 <allocuvm+0xb8>
  a = PGROUNDUP(oldsz);
80107f9d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107fa0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80107fa6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80107fac:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80107faf:	0f 86 86 00 00 00    	jbe    8010803b <allocuvm+0xbb>
80107fb5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80107fb8:	8b 7d 08             	mov    0x8(%ebp),%edi
80107fbb:	eb 49                	jmp    80108006 <allocuvm+0x86>
80107fbd:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80107fc0:	31 d2                	xor    %edx,%edx
80107fc2:	b8 00 10 00 00       	mov    $0x1000,%eax
80107fc7:	89 54 24 04          	mov    %edx,0x4(%esp)
80107fcb:	89 44 24 08          	mov    %eax,0x8(%esp)
80107fcf:	89 34 24             	mov    %esi,(%esp)
80107fd2:	e8 99 d8 ff ff       	call   80105870 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107fd7:	b9 06 00 00 00       	mov    $0x6,%ecx
80107fdc:	89 da                	mov    %ebx,%edx
80107fde:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107fe4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80107fe8:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107fed:	89 04 24             	mov    %eax,(%esp)
80107ff0:	89 f8                	mov    %edi,%eax
80107ff2:	e8 59 fb ff ff       	call   80107b50 <mappages>
80107ff7:	85 c0                	test   %eax,%eax
80107ff9:	78 4d                	js     80108048 <allocuvm+0xc8>
  for(; a < newsz; a += PGSIZE){
80107ffb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80108001:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80108004:	76 7a                	jbe    80108080 <allocuvm+0x100>
    mem = kalloc();
80108006:	e8 a5 a5 ff ff       	call   801025b0 <kalloc>
    if(mem == 0){
8010800b:	85 c0                	test   %eax,%eax
    mem = kalloc();
8010800d:	89 c6                	mov    %eax,%esi
    if(mem == 0){
8010800f:	75 af                	jne    80107fc0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80108011:	c7 04 24 f1 8d 10 80 	movl   $0x80108df1,(%esp)
80108018:	e8 33 86 ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
8010801d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108020:	39 45 10             	cmp    %eax,0x10(%ebp)
80108023:	77 6b                	ja     80108090 <allocuvm+0x110>
}
80108025:	83 c4 2c             	add    $0x2c,%esp
    return 0;
80108028:	31 ff                	xor    %edi,%edi
}
8010802a:	5b                   	pop    %ebx
8010802b:	89 f8                	mov    %edi,%eax
8010802d:	5e                   	pop    %esi
8010802e:	5f                   	pop    %edi
8010802f:	5d                   	pop    %ebp
80108030:	c3                   	ret    
80108031:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80108038:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
8010803b:	83 c4 2c             	add    $0x2c,%esp
8010803e:	89 f8                	mov    %edi,%eax
80108040:	5b                   	pop    %ebx
80108041:	5e                   	pop    %esi
80108042:	5f                   	pop    %edi
80108043:	5d                   	pop    %ebp
80108044:	c3                   	ret    
80108045:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80108048:	c7 04 24 09 8e 10 80 	movl   $0x80108e09,(%esp)
8010804f:	e8 fc 85 ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
80108054:	8b 45 0c             	mov    0xc(%ebp),%eax
80108057:	39 45 10             	cmp    %eax,0x10(%ebp)
8010805a:	76 0d                	jbe    80108069 <allocuvm+0xe9>
8010805c:	89 c1                	mov    %eax,%ecx
8010805e:	8b 55 10             	mov    0x10(%ebp),%edx
80108061:	8b 45 08             	mov    0x8(%ebp),%eax
80108064:	e8 77 fb ff ff       	call   80107be0 <deallocuvm.part.0>
      kfree(mem);
80108069:	89 34 24             	mov    %esi,(%esp)
      return 0;
8010806c:	31 ff                	xor    %edi,%edi
      kfree(mem);
8010806e:	e8 6d a3 ff ff       	call   801023e0 <kfree>
}
80108073:	83 c4 2c             	add    $0x2c,%esp
80108076:	89 f8                	mov    %edi,%eax
80108078:	5b                   	pop    %ebx
80108079:	5e                   	pop    %esi
8010807a:	5f                   	pop    %edi
8010807b:	5d                   	pop    %ebp
8010807c:	c3                   	ret    
8010807d:	8d 76 00             	lea    0x0(%esi),%esi
80108080:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80108083:	83 c4 2c             	add    $0x2c,%esp
80108086:	5b                   	pop    %ebx
80108087:	5e                   	pop    %esi
80108088:	89 f8                	mov    %edi,%eax
8010808a:	5f                   	pop    %edi
8010808b:	5d                   	pop    %ebp
8010808c:	c3                   	ret    
8010808d:	8d 76 00             	lea    0x0(%esi),%esi
80108090:	89 c1                	mov    %eax,%ecx
80108092:	8b 55 10             	mov    0x10(%ebp),%edx
      return 0;
80108095:	31 ff                	xor    %edi,%edi
80108097:	8b 45 08             	mov    0x8(%ebp),%eax
8010809a:	e8 41 fb ff ff       	call   80107be0 <deallocuvm.part.0>
8010809f:	eb 9a                	jmp    8010803b <allocuvm+0xbb>
801080a1:	eb 0d                	jmp    801080b0 <deallocuvm>
801080a3:	90                   	nop
801080a4:	90                   	nop
801080a5:	90                   	nop
801080a6:	90                   	nop
801080a7:	90                   	nop
801080a8:	90                   	nop
801080a9:	90                   	nop
801080aa:	90                   	nop
801080ab:	90                   	nop
801080ac:	90                   	nop
801080ad:	90                   	nop
801080ae:	90                   	nop
801080af:	90                   	nop

801080b0 <deallocuvm>:
{
801080b0:	55                   	push   %ebp
801080b1:	89 e5                	mov    %esp,%ebp
801080b3:	8b 55 0c             	mov    0xc(%ebp),%edx
801080b6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801080b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801080bc:	39 d1                	cmp    %edx,%ecx
801080be:	73 10                	jae    801080d0 <deallocuvm+0x20>
}
801080c0:	5d                   	pop    %ebp
801080c1:	e9 1a fb ff ff       	jmp    80107be0 <deallocuvm.part.0>
801080c6:	8d 76 00             	lea    0x0(%esi),%esi
801080c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801080d0:	89 d0                	mov    %edx,%eax
801080d2:	5d                   	pop    %ebp
801080d3:	c3                   	ret    
801080d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801080da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801080e0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801080e0:	55                   	push   %ebp
801080e1:	89 e5                	mov    %esp,%ebp
801080e3:	57                   	push   %edi
801080e4:	56                   	push   %esi
801080e5:	53                   	push   %ebx
801080e6:	83 ec 1c             	sub    $0x1c,%esp
801080e9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801080ec:	85 f6                	test   %esi,%esi
801080ee:	74 55                	je     80108145 <freevm+0x65>
801080f0:	31 c9                	xor    %ecx,%ecx
801080f2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801080f7:	89 f0                	mov    %esi,%eax
801080f9:	89 f3                	mov    %esi,%ebx
801080fb:	e8 e0 fa ff ff       	call   80107be0 <deallocuvm.part.0>
80108100:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80108106:	eb 0f                	jmp    80108117 <freevm+0x37>
80108108:	90                   	nop
80108109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108110:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80108113:	39 fb                	cmp    %edi,%ebx
80108115:	74 1f                	je     80108136 <freevm+0x56>
    if(pgdir[i] & PTE_P){
80108117:	8b 03                	mov    (%ebx),%eax
80108119:	a8 01                	test   $0x1,%al
8010811b:	74 f3                	je     80108110 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010811d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108122:	83 c3 04             	add    $0x4,%ebx
80108125:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010812a:	89 04 24             	mov    %eax,(%esp)
8010812d:	e8 ae a2 ff ff       	call   801023e0 <kfree>
  for(i = 0; i < NPDENTRIES; i++){
80108132:	39 fb                	cmp    %edi,%ebx
80108134:	75 e1                	jne    80108117 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80108136:	89 75 08             	mov    %esi,0x8(%ebp)
}
80108139:	83 c4 1c             	add    $0x1c,%esp
8010813c:	5b                   	pop    %ebx
8010813d:	5e                   	pop    %esi
8010813e:	5f                   	pop    %edi
8010813f:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80108140:	e9 9b a2 ff ff       	jmp    801023e0 <kfree>
    panic("freevm: no pgdir");
80108145:	c7 04 24 25 8e 10 80 	movl   $0x80108e25,(%esp)
8010814c:	e8 1f 82 ff ff       	call   80100370 <panic>
80108151:	eb 0d                	jmp    80108160 <setupkvm>
80108153:	90                   	nop
80108154:	90                   	nop
80108155:	90                   	nop
80108156:	90                   	nop
80108157:	90                   	nop
80108158:	90                   	nop
80108159:	90                   	nop
8010815a:	90                   	nop
8010815b:	90                   	nop
8010815c:	90                   	nop
8010815d:	90                   	nop
8010815e:	90                   	nop
8010815f:	90                   	nop

80108160 <setupkvm>:
{
80108160:	55                   	push   %ebp
80108161:	89 e5                	mov    %esp,%ebp
80108163:	56                   	push   %esi
80108164:	53                   	push   %ebx
80108165:	83 ec 10             	sub    $0x10,%esp
  if((pgdir = (pde_t*)kalloc()) == 0)
80108168:	e8 43 a4 ff ff       	call   801025b0 <kalloc>
8010816d:	85 c0                	test   %eax,%eax
8010816f:	89 c6                	mov    %eax,%esi
80108171:	74 46                	je     801081b9 <setupkvm+0x59>
  memset(pgdir, 0, PGSIZE);
80108173:	b8 00 10 00 00       	mov    $0x1000,%eax
80108178:	31 d2                	xor    %edx,%edx
8010817a:	89 44 24 08          	mov    %eax,0x8(%esp)
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010817e:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80108183:	89 54 24 04          	mov    %edx,0x4(%esp)
80108187:	89 34 24             	mov    %esi,(%esp)
8010818a:	e8 e1 d6 ff ff       	call   80105870 <memset>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010818f:	8b 53 0c             	mov    0xc(%ebx),%edx
                (uint)k->phys_start, k->perm) < 0) {
80108192:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80108195:	8b 4b 08             	mov    0x8(%ebx),%ecx
80108198:	89 54 24 04          	mov    %edx,0x4(%esp)
8010819c:	8b 13                	mov    (%ebx),%edx
8010819e:	89 04 24             	mov    %eax,(%esp)
801081a1:	29 c1                	sub    %eax,%ecx
801081a3:	89 f0                	mov    %esi,%eax
801081a5:	e8 a6 f9 ff ff       	call   80107b50 <mappages>
801081aa:	85 c0                	test   %eax,%eax
801081ac:	78 1a                	js     801081c8 <setupkvm+0x68>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801081ae:	83 c3 10             	add    $0x10,%ebx
801081b1:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
801081b7:	75 d6                	jne    8010818f <setupkvm+0x2f>
}
801081b9:	83 c4 10             	add    $0x10,%esp
801081bc:	89 f0                	mov    %esi,%eax
801081be:	5b                   	pop    %ebx
801081bf:	5e                   	pop    %esi
801081c0:	5d                   	pop    %ebp
801081c1:	c3                   	ret    
801081c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      freevm(pgdir);
801081c8:	89 34 24             	mov    %esi,(%esp)
      return 0;
801081cb:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
801081cd:	e8 0e ff ff ff       	call   801080e0 <freevm>
}
801081d2:	83 c4 10             	add    $0x10,%esp
801081d5:	89 f0                	mov    %esi,%eax
801081d7:	5b                   	pop    %ebx
801081d8:	5e                   	pop    %esi
801081d9:	5d                   	pop    %ebp
801081da:	c3                   	ret    
801081db:	90                   	nop
801081dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801081e0 <kvmalloc>:
{
801081e0:	55                   	push   %ebp
801081e1:	89 e5                	mov    %esp,%ebp
801081e3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801081e6:	e8 75 ff ff ff       	call   80108160 <setupkvm>
801081eb:	a3 04 69 11 80       	mov    %eax,0x80116904
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801081f0:	05 00 00 00 80       	add    $0x80000000,%eax
801081f5:	0f 22 d8             	mov    %eax,%cr3
}
801081f8:	c9                   	leave  
801081f9:	c3                   	ret    
801081fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108200 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108200:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108201:	31 c9                	xor    %ecx,%ecx
{
80108203:	89 e5                	mov    %esp,%ebp
80108205:	83 ec 18             	sub    $0x18,%esp
  pte = walkpgdir(pgdir, uva, 0);
80108208:	8b 55 0c             	mov    0xc(%ebp),%edx
8010820b:	8b 45 08             	mov    0x8(%ebp),%eax
8010820e:	e8 ad f8 ff ff       	call   80107ac0 <walkpgdir>
  if(pte == 0)
80108213:	85 c0                	test   %eax,%eax
80108215:	74 05                	je     8010821c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80108217:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010821a:	c9                   	leave  
8010821b:	c3                   	ret    
    panic("clearpteu");
8010821c:	c7 04 24 36 8e 10 80 	movl   $0x80108e36,(%esp)
80108223:	e8 48 81 ff ff       	call   80100370 <panic>
80108228:	90                   	nop
80108229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108230 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108230:	55                   	push   %ebp
80108231:	89 e5                	mov    %esp,%ebp
80108233:	57                   	push   %edi
80108234:	56                   	push   %esi
80108235:	53                   	push   %ebx
80108236:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80108239:	e8 22 ff ff ff       	call   80108160 <setupkvm>
8010823e:	85 c0                	test   %eax,%eax
80108240:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108243:	0f 84 a3 00 00 00    	je     801082ec <copyuvm+0xbc>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108249:	8b 55 0c             	mov    0xc(%ebp),%edx
8010824c:	85 d2                	test   %edx,%edx
8010824e:	0f 84 98 00 00 00    	je     801082ec <copyuvm+0xbc>
80108254:	31 ff                	xor    %edi,%edi
80108256:	eb 50                	jmp    801082a8 <copyuvm+0x78>
80108258:	90                   	nop
80108259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80108260:	b8 00 10 00 00       	mov    $0x1000,%eax
80108265:	89 44 24 08          	mov    %eax,0x8(%esp)
80108269:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010826c:	89 34 24             	mov    %esi,(%esp)
8010826f:	05 00 00 00 80       	add    $0x80000000,%eax
80108274:	89 44 24 04          	mov    %eax,0x4(%esp)
80108278:	e8 b3 d6 ff ff       	call   80105930 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
8010827d:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80108283:	b9 00 10 00 00       	mov    $0x1000,%ecx
80108288:	89 04 24             	mov    %eax,(%esp)
8010828b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010828e:	89 fa                	mov    %edi,%edx
80108290:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80108294:	e8 b7 f8 ff ff       	call   80107b50 <mappages>
80108299:	85 c0                	test   %eax,%eax
8010829b:	78 63                	js     80108300 <copyuvm+0xd0>
  for(i = 0; i < sz; i += PGSIZE){
8010829d:	81 c7 00 10 00 00    	add    $0x1000,%edi
801082a3:	39 7d 0c             	cmp    %edi,0xc(%ebp)
801082a6:	76 44                	jbe    801082ec <copyuvm+0xbc>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801082a8:	8b 45 08             	mov    0x8(%ebp),%eax
801082ab:	31 c9                	xor    %ecx,%ecx
801082ad:	89 fa                	mov    %edi,%edx
801082af:	e8 0c f8 ff ff       	call   80107ac0 <walkpgdir>
801082b4:	85 c0                	test   %eax,%eax
801082b6:	74 5e                	je     80108316 <copyuvm+0xe6>
    if(!(*pte & PTE_P))
801082b8:	8b 18                	mov    (%eax),%ebx
801082ba:	f6 c3 01             	test   $0x1,%bl
801082bd:	74 4b                	je     8010830a <copyuvm+0xda>
    pa = PTE_ADDR(*pte);
801082bf:	89 d8                	mov    %ebx,%eax
    flags = PTE_FLAGS(*pte);
801082c1:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
801082c7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801082cc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
801082cf:	e8 dc a2 ff ff       	call   801025b0 <kalloc>
801082d4:	85 c0                	test   %eax,%eax
801082d6:	89 c6                	mov    %eax,%esi
801082d8:	75 86                	jne    80108260 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
801082da:	8b 45 e0             	mov    -0x20(%ebp),%eax
801082dd:	89 04 24             	mov    %eax,(%esp)
801082e0:	e8 fb fd ff ff       	call   801080e0 <freevm>
  return 0;
801082e5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
801082ec:	8b 45 e0             	mov    -0x20(%ebp),%eax
801082ef:	83 c4 2c             	add    $0x2c,%esp
801082f2:	5b                   	pop    %ebx
801082f3:	5e                   	pop    %esi
801082f4:	5f                   	pop    %edi
801082f5:	5d                   	pop    %ebp
801082f6:	c3                   	ret    
801082f7:	89 f6                	mov    %esi,%esi
801082f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      kfree(mem);
80108300:	89 34 24             	mov    %esi,(%esp)
80108303:	e8 d8 a0 ff ff       	call   801023e0 <kfree>
      goto bad;
80108308:	eb d0                	jmp    801082da <copyuvm+0xaa>
      panic("copyuvm: page not present");
8010830a:	c7 04 24 5a 8e 10 80 	movl   $0x80108e5a,(%esp)
80108311:	e8 5a 80 ff ff       	call   80100370 <panic>
      panic("copyuvm: pte should exist");
80108316:	c7 04 24 40 8e 10 80 	movl   $0x80108e40,(%esp)
8010831d:	e8 4e 80 ff ff       	call   80100370 <panic>
80108322:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108330 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108330:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108331:	31 c9                	xor    %ecx,%ecx
{
80108333:	89 e5                	mov    %esp,%ebp
80108335:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80108338:	8b 55 0c             	mov    0xc(%ebp),%edx
8010833b:	8b 45 08             	mov    0x8(%ebp),%eax
8010833e:	e8 7d f7 ff ff       	call   80107ac0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80108343:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80108345:	89 c2                	mov    %eax,%edx
80108347:	83 e2 05             	and    $0x5,%edx
8010834a:	83 fa 05             	cmp    $0x5,%edx
8010834d:	75 11                	jne    80108360 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
8010834f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108354:	05 00 00 00 80       	add    $0x80000000,%eax
}
80108359:	c9                   	leave  
8010835a:	c3                   	ret    
8010835b:	90                   	nop
8010835c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80108360:	31 c0                	xor    %eax,%eax
}
80108362:	c9                   	leave  
80108363:	c3                   	ret    
80108364:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010836a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80108370 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108370:	55                   	push   %ebp
80108371:	89 e5                	mov    %esp,%ebp
80108373:	57                   	push   %edi
80108374:	56                   	push   %esi
80108375:	53                   	push   %ebx
80108376:	83 ec 2c             	sub    $0x2c,%esp
80108379:	8b 75 14             	mov    0x14(%ebp),%esi
8010837c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
8010837f:	85 f6                	test   %esi,%esi
80108381:	74 75                	je     801083f8 <copyout+0x88>
80108383:	89 da                	mov    %ebx,%edx
80108385:	eb 3f                	jmp    801083c6 <copyout+0x56>
80108387:	89 f6                	mov    %esi,%esi
80108389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80108390:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80108393:	89 df                	mov    %ebx,%edi
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80108395:	8b 4d 10             	mov    0x10(%ebp),%ecx
    n = PGSIZE - (va - va0);
80108398:	29 d7                	sub    %edx,%edi
8010839a:	81 c7 00 10 00 00    	add    $0x1000,%edi
801083a0:	39 f7                	cmp    %esi,%edi
801083a2:	0f 47 fe             	cmova  %esi,%edi
    memmove(pa0 + (va - va0), buf, n);
801083a5:	29 da                	sub    %ebx,%edx
801083a7:	01 c2                	add    %eax,%edx
801083a9:	89 14 24             	mov    %edx,(%esp)
801083ac:	89 7c 24 08          	mov    %edi,0x8(%esp)
801083b0:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801083b4:	e8 77 d5 ff ff       	call   80105930 <memmove>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
801083b9:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    buf += n;
801083bf:	01 7d 10             	add    %edi,0x10(%ebp)
  while(len > 0){
801083c2:	29 fe                	sub    %edi,%esi
801083c4:	74 32                	je     801083f8 <copyout+0x88>
    pa0 = uva2ka(pgdir, (char*)va0);
801083c6:	8b 45 08             	mov    0x8(%ebp),%eax
    va0 = (uint)PGROUNDDOWN(va);
801083c9:	89 d3                	mov    %edx,%ebx
801083cb:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    pa0 = uva2ka(pgdir, (char*)va0);
801083d1:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    va0 = (uint)PGROUNDDOWN(va);
801083d5:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
801083d8:	89 04 24             	mov    %eax,(%esp)
801083db:	e8 50 ff ff ff       	call   80108330 <uva2ka>
    if(pa0 == 0)
801083e0:	85 c0                	test   %eax,%eax
801083e2:	75 ac                	jne    80108390 <copyout+0x20>
  }
  return 0;
}
801083e4:	83 c4 2c             	add    $0x2c,%esp
      return -1;
801083e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801083ec:	5b                   	pop    %ebx
801083ed:	5e                   	pop    %esi
801083ee:	5f                   	pop    %edi
801083ef:	5d                   	pop    %ebp
801083f0:	c3                   	ret    
801083f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801083f8:	83 c4 2c             	add    $0x2c,%esp
  return 0;
801083fb:	31 c0                	xor    %eax,%eax
}
801083fd:	5b                   	pop    %ebx
801083fe:	5e                   	pop    %esi
801083ff:	5f                   	pop    %edi
80108400:	5d                   	pop    %ebp
80108401:	c3                   	ret    
