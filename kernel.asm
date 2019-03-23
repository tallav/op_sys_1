
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
80100015:	b8 00 b0 10 00       	mov    $0x10b000,%eax
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
80100028:	bc 20 d6 10 80       	mov    $0x8010d620,%esp

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
80100041:	ba 20 87 10 80       	mov    $0x80108720,%edx
{
80100046:	89 e5                	mov    %esp,%ebp
80100048:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
80100049:	bb 1c 1d 11 80       	mov    $0x80111d1c,%ebx
{
8010004e:	83 ec 14             	sub    $0x14,%esp
  initlock(&bcache.lock, "bcache");
80100051:	89 54 24 04          	mov    %edx,0x4(%esp)
80100055:	c7 04 24 20 d6 10 80 	movl   $0x8010d620,(%esp)
8010005c:	e8 6f 58 00 00       	call   801058d0 <initlock>
  bcache.head.prev = &bcache.head;
80100061:	b9 1c 1d 11 80       	mov    $0x80111d1c,%ecx
  bcache.head.next = &bcache.head;
80100066:	ba 1c 1d 11 80       	mov    $0x80111d1c,%edx
8010006b:	89 1d 70 1d 11 80    	mov    %ebx,0x80111d70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100071:	bb 54 d6 10 80       	mov    $0x8010d654,%ebx
  bcache.head.prev = &bcache.head;
80100076:	89 0d 6c 1d 11 80    	mov    %ecx,0x80111d6c
8010007c:	eb 04                	jmp    80100082 <binit+0x42>
8010007e:	66 90                	xchg   %ax,%ax
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	b8 27 87 10 80       	mov    $0x80108727,%eax
    b->next = bcache.head.next;
80100087:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008a:	c7 43 50 1c 1d 11 80 	movl   $0x80111d1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100091:	89 44 24 04          	mov    %eax,0x4(%esp)
80100095:	8d 43 0c             	lea    0xc(%ebx),%eax
80100098:	89 04 24             	mov    %eax,(%esp)
8010009b:	e8 00 57 00 00       	call   801057a0 <initsleeplock>
    bcache.head.next->prev = b;
801000a0:	a1 70 1d 11 80       	mov    0x80111d70,%eax
801000a5:	89 da                	mov    %ebx,%edx
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
801000b0:	3d 1c 1d 11 80       	cmp    $0x80111d1c,%eax
    bcache.head.next = b;
801000b5:	89 1d 70 1d 11 80    	mov    %ebx,0x80111d70
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
801000d9:	c7 04 24 20 d6 10 80 	movl   $0x8010d620,(%esp)
{
801000e0:	8b 75 08             	mov    0x8(%ebp),%esi
801000e3:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000e6:	e8 35 59 00 00       	call   80105a20 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000eb:	8b 1d 70 1d 11 80    	mov    0x80111d70,%ebx
801000f1:	81 fb 1c 1d 11 80    	cmp    $0x80111d1c,%ebx
801000f7:	75 12                	jne    8010010b <bread+0x3b>
801000f9:	eb 25                	jmp    80100120 <bread+0x50>
801000fb:	90                   	nop
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c 1d 11 80    	cmp    $0x80111d1c,%ebx
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
80100120:	8b 1d 6c 1d 11 80    	mov    0x80111d6c,%ebx
80100126:	81 fb 1c 1d 11 80    	cmp    $0x80111d1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 58                	jmp    80100188 <bread+0xb8>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c 1d 11 80    	cmp    $0x80111d1c,%ebx
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
8010015a:	c7 04 24 20 d6 10 80 	movl   $0x8010d620,(%esp)
80100161:	e8 5a 59 00 00       	call   80105ac0 <release>
      acquiresleep(&b->lock);
80100166:	8d 43 0c             	lea    0xc(%ebx),%eax
80100169:	89 04 24             	mov    %eax,(%esp)
8010016c:	e8 6f 56 00 00       	call   801057e0 <acquiresleep>
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
80100188:	c7 04 24 2e 87 10 80 	movl   $0x8010872e,(%esp)
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
801001b0:	e8 cb 56 00 00       	call   80105880 <holdingsleep>
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
801001c9:	c7 04 24 3f 87 10 80 	movl   $0x8010873f,(%esp)
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
801001f1:	e8 8a 56 00 00       	call   80105880 <holdingsleep>
801001f6:	85 c0                	test   %eax,%eax
801001f8:	74 5a                	je     80100254 <brelse+0x74>
    panic("brelse");

  releasesleep(&b->lock);
801001fa:	89 34 24             	mov    %esi,(%esp)
801001fd:	e8 3e 56 00 00       	call   80105840 <releasesleep>

  acquire(&bcache.lock);
80100202:	c7 04 24 20 d6 10 80 	movl   $0x8010d620,(%esp)
80100209:	e8 12 58 00 00       	call   80105a20 <acquire>
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
80100225:	a1 70 1d 11 80       	mov    0x80111d70,%eax
    b->prev = &bcache.head;
8010022a:	c7 43 50 1c 1d 11 80 	movl   $0x80111d1c,0x50(%ebx)
    b->next = bcache.head.next;
80100231:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100234:	a1 70 1d 11 80       	mov    0x80111d70,%eax
80100239:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010023c:	89 1d 70 1d 11 80    	mov    %ebx,0x80111d70
  }
  
  release(&bcache.lock);
80100242:	c7 45 08 20 d6 10 80 	movl   $0x8010d620,0x8(%ebp)
}
80100249:	83 c4 10             	add    $0x10,%esp
8010024c:	5b                   	pop    %ebx
8010024d:	5e                   	pop    %esi
8010024e:	5d                   	pop    %ebp
  release(&bcache.lock);
8010024f:	e9 6c 58 00 00       	jmp    80105ac0 <release>
    panic("brelse");
80100254:	c7 04 24 46 87 10 80 	movl   $0x80108746,(%esp)
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
80100277:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010027e:	e8 9d 57 00 00       	call   80105a20 <acquire>
  while(n > 0){
80100283:	31 c0                	xor    %eax,%eax
80100285:	85 f6                	test   %esi,%esi
80100287:	0f 8e a3 00 00 00    	jle    80100330 <consoleread+0xd0>
8010028d:	89 f3                	mov    %esi,%ebx
8010028f:	89 75 10             	mov    %esi,0x10(%ebp)
80100292:	8b 75 0c             	mov    0xc(%ebp),%esi
    while(input.r == input.w){
80100295:	8b 15 00 20 11 80    	mov    0x80112000,%edx
8010029b:	39 15 04 20 11 80    	cmp    %edx,0x80112004
801002a1:	74 28                	je     801002cb <consoleread+0x6b>
801002a3:	eb 5b                	jmp    80100300 <consoleread+0xa0>
801002a5:	8d 76 00             	lea    0x0(%esi),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002a8:	b8 20 c5 10 80       	mov    $0x8010c520,%eax
801002ad:	89 44 24 04          	mov    %eax,0x4(%esp)
801002b1:	c7 04 24 00 20 11 80 	movl   $0x80112000,(%esp)
801002b8:	e8 33 41 00 00       	call   801043f0 <sleep>
    while(input.r == input.w){
801002bd:	8b 15 00 20 11 80    	mov    0x80112000,%edx
801002c3:	3b 15 04 20 11 80    	cmp    0x80112004,%edx
801002c9:	75 35                	jne    80100300 <consoleread+0xa0>
      if(myproc()->killed){
801002cb:	e8 d0 36 00 00       	call   801039a0 <myproc>
801002d0:	8b 50 24             	mov    0x24(%eax),%edx
801002d3:	85 d2                	test   %edx,%edx
801002d5:	74 d1                	je     801002a8 <consoleread+0x48>
        release(&cons.lock);
801002d7:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
801002de:	e8 dd 57 00 00       	call   80105ac0 <release>
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
80100303:	a3 00 20 11 80       	mov    %eax,0x80112000
80100308:	89 d0                	mov    %edx,%eax
8010030a:	83 e0 7f             	and    $0x7f,%eax
8010030d:	0f be 80 80 1f 11 80 	movsbl -0x7feee080(%eax),%eax
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
80100330:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
80100337:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010033a:	e8 81 57 00 00       	call   80105ac0 <release>
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
8010035d:	89 15 00 20 11 80    	mov    %edx,0x80112000
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
8010037b:	89 15 54 c5 10 80    	mov    %edx,0x8010c554
  getcallerpcs(&s, pcs);
80100381:	8d 5d d0             	lea    -0x30(%ebp),%ebx
  cprintf("lapicid %d: panic: ", lapicid());
80100384:	e8 a7 24 00 00       	call   80102830 <lapicid>
80100389:	8d 75 f8             	lea    -0x8(%ebp),%esi
8010038c:	c7 04 24 4d 87 10 80 	movl   $0x8010874d,(%esp)
80100393:	89 44 24 04          	mov    %eax,0x4(%esp)
80100397:	e8 b4 02 00 00       	call   80100650 <cprintf>
  cprintf(s);
8010039c:	8b 45 08             	mov    0x8(%ebp),%eax
8010039f:	89 04 24             	mov    %eax,(%esp)
801003a2:	e8 a9 02 00 00       	call   80100650 <cprintf>
  cprintf("\n");
801003a7:	c7 04 24 21 8e 10 80 	movl   $0x80108e21,(%esp)
801003ae:	e8 9d 02 00 00       	call   80100650 <cprintf>
  getcallerpcs(&s, pcs);
801003b3:	8d 45 08             	lea    0x8(%ebp),%eax
801003b6:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801003ba:	89 04 24             	mov    %eax,(%esp)
801003bd:	e8 2e 55 00 00       	call   801058f0 <getcallerpcs>
801003c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    cprintf(" %p", pcs[i]);
801003d0:	8b 03                	mov    (%ebx),%eax
801003d2:	83 c3 04             	add    $0x4,%ebx
801003d5:	c7 04 24 61 87 10 80 	movl   $0x80108761,(%esp)
801003dc:	89 44 24 04          	mov    %eax,0x4(%esp)
801003e0:	e8 6b 02 00 00       	call   80100650 <cprintf>
  for(i=0; i<10; i++)
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x60>
  panicked = 1; // freeze other CPU
801003e9:	b8 01 00 00 00       	mov    $0x1,%eax
801003ee:	a3 58 c5 10 80       	mov    %eax,0x8010c558
801003f3:	eb fe                	jmp    801003f3 <panic+0x83>
801003f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801003f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100400 <consputc>:
  if(panicked){
80100400:	8b 15 58 c5 10 80    	mov    0x8010c558,%edx
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
80100429:	e8 e2 6e 00 00       	call   80107310 <uartputc>
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
801004cc:	e8 3f 6e 00 00       	call   80107310 <uartputc>
801004d1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004d8:	e8 33 6e 00 00       	call   80107310 <uartputc>
801004dd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004e4:	e8 27 6e 00 00       	call   80107310 <uartputc>
801004e9:	e9 40 ff ff ff       	jmp    8010042e <consputc+0x2e>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004ee:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
801004f5:	00 
801004f6:	c7 44 24 04 a0 80 0b 	movl   $0x800b80a0,0x4(%esp)
801004fd:	80 
801004fe:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
80100505:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80100508:	e8 c3 56 00 00       	call   80105bd0 <memmove>
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
80100536:	e8 d5 55 00 00       	call   80105b10 <memset>
8010053b:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010053e:	e9 4c ff ff ff       	jmp    8010048f <consputc+0x8f>
    panic("pos under/overflow");
80100543:	c7 04 24 65 87 10 80 	movl   $0x80108765,(%esp)
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
801005a1:	0f b6 92 90 87 10 80 	movzbl -0x7fef7870(%edx),%edx
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
80100607:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010060e:	e8 0d 54 00 00       	call   80105a20 <acquire>
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
8010062d:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
80100634:	e8 87 54 00 00       	call   80105ac0 <release>
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
80100659:	a1 54 c5 10 80       	mov    0x8010c554,%eax
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
80100707:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010070e:	e8 ad 53 00 00       	call   80105ac0 <release>
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
80100774:	bf 78 87 10 80       	mov    $0x80108778,%edi
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
801007b0:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
801007b7:	e8 64 52 00 00       	call   80105a20 <acquire>
801007bc:	e9 a8 fe ff ff       	jmp    80100669 <cprintf+0x19>
    panic("null fmt");
801007c1:	c7 04 24 7f 87 10 80 	movl   $0x8010877f,(%esp)
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
801007da:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
{
801007e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
801007e4:	e8 37 52 00 00       	call   80105a20 <acquire>
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
80100812:	a1 08 20 11 80       	mov    0x80112008,%eax
80100817:	3b 05 04 20 11 80    	cmp    0x80112004,%eax
8010081d:	74 d1                	je     801007f0 <consoleintr+0x20>
        input.e--;
8010081f:	48                   	dec    %eax
80100820:	a3 08 20 11 80       	mov    %eax,0x80112008
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
80100840:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
80100847:	e8 74 52 00 00       	call   80105ac0 <release>
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
80100869:	a1 08 20 11 80       	mov    0x80112008,%eax
8010086e:	89 c1                	mov    %eax,%ecx
80100870:	2b 0d 00 20 11 80    	sub    0x80112000,%ecx
80100876:	83 f9 7f             	cmp    $0x7f,%ecx
80100879:	0f 87 71 ff ff ff    	ja     801007f0 <consoleintr+0x20>
8010087f:	8d 48 01             	lea    0x1(%eax),%ecx
80100882:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
80100885:	83 fa 0d             	cmp    $0xd,%edx
        input.buf[input.e++ % INPUT_BUF] = c;
80100888:	89 0d 08 20 11 80    	mov    %ecx,0x80112008
        c = (c == '\r') ? '\n' : c;
8010088e:	0f 84 c4 00 00 00    	je     80100958 <consoleintr+0x188>
        input.buf[input.e++ % INPUT_BUF] = c;
80100894:	88 90 80 1f 11 80    	mov    %dl,-0x7feee080(%eax)
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
801008b9:	a1 00 20 11 80       	mov    0x80112000,%eax
801008be:	83 e8 80             	sub    $0xffffff80,%eax
801008c1:	39 05 08 20 11 80    	cmp    %eax,0x80112008
801008c7:	0f 85 23 ff ff ff    	jne    801007f0 <consoleintr+0x20>
          wakeup(&input.r);
801008cd:	c7 04 24 00 20 11 80 	movl   $0x80112000,(%esp)
          input.w = input.e;
801008d4:	a3 04 20 11 80       	mov    %eax,0x80112004
          wakeup(&input.r);
801008d9:	e8 f2 3c 00 00       	call   801045d0 <wakeup>
801008de:	e9 0d ff ff ff       	jmp    801007f0 <consoleintr+0x20>
801008e3:	90                   	nop
801008e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
801008e8:	be 01 00 00 00       	mov    $0x1,%esi
801008ed:	e9 fe fe ff ff       	jmp    801007f0 <consoleintr+0x20>
801008f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
801008f8:	a1 08 20 11 80       	mov    0x80112008,%eax
801008fd:	39 05 04 20 11 80    	cmp    %eax,0x80112004
80100903:	75 2b                	jne    80100930 <consoleintr+0x160>
80100905:	e9 e6 fe ff ff       	jmp    801007f0 <consoleintr+0x20>
8010090a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100910:	a3 08 20 11 80       	mov    %eax,0x80112008
        consputc(BACKSPACE);
80100915:	b8 00 01 00 00       	mov    $0x100,%eax
8010091a:	e8 e1 fa ff ff       	call   80100400 <consputc>
      while(input.e != input.w &&
8010091f:	a1 08 20 11 80       	mov    0x80112008,%eax
80100924:	3b 05 04 20 11 80    	cmp    0x80112004,%eax
8010092a:	0f 84 c0 fe ff ff    	je     801007f0 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100930:	48                   	dec    %eax
80100931:	89 c2                	mov    %eax,%edx
80100933:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100936:	80 ba 80 1f 11 80 0a 	cmpb   $0xa,-0x7feee080(%edx)
8010093d:	75 d1                	jne    80100910 <consoleintr+0x140>
8010093f:	e9 ac fe ff ff       	jmp    801007f0 <consoleintr+0x20>
80100944:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80100948:	83 c4 20             	add    $0x20,%esp
8010094b:	5b                   	pop    %ebx
8010094c:	5e                   	pop    %esi
8010094d:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
8010094e:	e9 6d 3f 00 00       	jmp    801048c0 <procdump>
80100953:	90                   	nop
80100954:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
80100958:	c6 80 80 1f 11 80 0a 	movb   $0xa,-0x7feee080(%eax)
        consputc(c);
8010095f:	b8 0a 00 00 00       	mov    $0xa,%eax
80100964:	e8 97 fa ff ff       	call   80100400 <consputc>
80100969:	a1 08 20 11 80       	mov    0x80112008,%eax
8010096e:	e9 5a ff ff ff       	jmp    801008cd <consoleintr+0xfd>
80100973:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100980 <consoleinit>:

void
consoleinit(void)
{
80100980:	55                   	push   %ebp
  initlock(&cons.lock, "console");
80100981:	b8 88 87 10 80       	mov    $0x80108788,%eax
{
80100986:	89 e5                	mov    %esp,%ebp
80100988:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
8010098b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010098f:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
80100996:	e8 35 4f 00 00       	call   801058d0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;
8010099b:	b8 01 00 00 00       	mov    $0x1,%eax
  devsw[CONSOLE].write = consolewrite;
801009a0:	ba f0 05 10 80       	mov    $0x801005f0,%edx
  cons.locking = 1;
801009a5:	a3 54 c5 10 80       	mov    %eax,0x8010c554

  ioapicenable(IRQ_KBD, 0);
801009aa:	31 c0                	xor    %eax,%eax
  devsw[CONSOLE].read = consoleread;
801009ac:	b9 60 02 10 80       	mov    $0x80100260,%ecx
  ioapicenable(IRQ_KBD, 0);
801009b1:	89 44 24 04          	mov    %eax,0x4(%esp)
801009b5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  devsw[CONSOLE].write = consolewrite;
801009bc:	89 15 cc 29 11 80    	mov    %edx,0x801129cc
  devsw[CONSOLE].read = consoleread;
801009c2:	89 0d c8 29 11 80    	mov    %ecx,0x801129c8
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
801009dc:	e8 bf 2f 00 00       	call   801039a0 <myproc>
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
80100a5c:	e8 0f 7a 00 00       	call   80108470 <setupkvm>
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
80100ac8:	e8 c3 77 00 00       	call   80108290 <allocuvm>
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
80100b05:	e8 c6 76 00 00       	call   801081d0 <loaduvm>
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
80100b58:	e8 93 78 00 00       	call   801083f0 <freevm>
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
80100b92:	e8 f9 76 00 00       	call   80108290 <allocuvm>
80100b97:	85 c0                	test   %eax,%eax
80100b99:	89 c6                	mov    %eax,%esi
80100b9b:	75 33                	jne    80100bd0 <exec+0x200>
    freevm(pgdir);
80100b9d:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ba3:	89 04 24             	mov    %eax,(%esp)
80100ba6:	e8 45 78 00 00       	call   801083f0 <freevm>
  return -1;
80100bab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bb0:	e9 8c fe ff ff       	jmp    80100a41 <exec+0x71>
    end_op();
80100bb5:	e8 46 21 00 00       	call   80102d00 <end_op>
    cprintf("exec: fail\n");
80100bba:	c7 04 24 a1 87 10 80 	movl   $0x801087a1,(%esp)
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
80100be7:	e8 24 79 00 00       	call   80108510 <clearpteu>
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
80100c18:	e8 13 51 00 00       	call   80105d30 <strlen>
80100c1d:	f7 d0                	not    %eax
80100c1f:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c21:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c24:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c27:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c2a:	89 04 24             	mov    %eax,(%esp)
80100c2d:	e8 fe 50 00 00       	call   80105d30 <strlen>
80100c32:	40                   	inc    %eax
80100c33:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c37:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c3a:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c3d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100c41:	89 34 24             	mov    %esi,(%esp)
80100c44:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c48:	e8 33 7a 00 00       	call   80108680 <copyout>
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
80100cb8:	e8 c3 79 00 00       	call   80108680 <copyout>
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
80100d01:	e8 ea 4f 00 00       	call   80105cf0 <safestrcpy>
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
80100d2b:	e8 10 73 00 00       	call   80108040 <switchuvm>
  freevm(oldpgdir);
80100d30:	89 3c 24             	mov    %edi,(%esp)
80100d33:	e8 b8 76 00 00       	call   801083f0 <freevm>
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
80100d51:	b8 ad 87 10 80       	mov    $0x801087ad,%eax
{
80100d56:	89 e5                	mov    %esp,%ebp
80100d58:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100d5b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100d5f:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
80100d66:	e8 65 4b 00 00       	call   801058d0 <initlock>
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
80100d74:	bb 54 20 11 80       	mov    $0x80112054,%ebx
{
80100d79:	83 ec 14             	sub    $0x14,%esp
  acquire(&ftable.lock);
80100d7c:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
80100d83:	e8 98 4c 00 00       	call   80105a20 <acquire>
80100d88:	eb 11                	jmp    80100d9b <filealloc+0x2b>
80100d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d90:	83 c3 18             	add    $0x18,%ebx
80100d93:	81 fb b4 29 11 80    	cmp    $0x801129b4,%ebx
80100d99:	73 25                	jae    80100dc0 <filealloc+0x50>
    if(f->ref == 0){
80100d9b:	8b 43 04             	mov    0x4(%ebx),%eax
80100d9e:	85 c0                	test   %eax,%eax
80100da0:	75 ee                	jne    80100d90 <filealloc+0x20>
      f->ref = 1;
80100da2:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100da9:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
80100db0:	e8 0b 4d 00 00       	call   80105ac0 <release>
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
80100dc0:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
  return 0;
80100dc7:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100dc9:	e8 f2 4c 00 00       	call   80105ac0 <release>
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
80100dea:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
80100df1:	e8 2a 4c 00 00       	call   80105a20 <acquire>
  if(f->ref < 1)
80100df6:	8b 43 04             	mov    0x4(%ebx),%eax
80100df9:	85 c0                	test   %eax,%eax
80100dfb:	7e 18                	jle    80100e15 <filedup+0x35>
    panic("filedup");
  f->ref++;
80100dfd:	40                   	inc    %eax
80100dfe:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e01:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
80100e08:	e8 b3 4c 00 00       	call   80105ac0 <release>
  return f;
}
80100e0d:	83 c4 14             	add    $0x14,%esp
80100e10:	89 d8                	mov    %ebx,%eax
80100e12:	5b                   	pop    %ebx
80100e13:	5d                   	pop    %ebp
80100e14:	c3                   	ret    
    panic("filedup");
80100e15:	c7 04 24 b4 87 10 80 	movl   $0x801087b4,(%esp)
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
80100e3c:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
{
80100e43:	89 75 f8             	mov    %esi,-0x8(%ebp)
80100e46:	89 7d fc             	mov    %edi,-0x4(%ebp)
  acquire(&ftable.lock);
80100e49:	e8 d2 4b 00 00       	call   80105a20 <acquire>
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
80100e61:	c7 45 08 20 20 11 80 	movl   $0x80112020,0x8(%ebp)
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
80100e74:	e9 47 4c 00 00       	jmp    80105ac0 <release>
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
80100e95:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
  ff = *f;
80100e9c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100e9f:	e8 1c 4c 00 00       	call   80105ac0 <release>
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
80100ef9:	c7 04 24 bc 87 10 80 	movl   $0x801087bc,(%esp)
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
80100ff7:	c7 04 24 c6 87 10 80 	movl   $0x801087c6,(%esp)
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
80101112:	c7 04 24 cf 87 10 80 	movl   $0x801087cf,(%esp)
80101119:	e8 52 f2 ff ff       	call   80100370 <panic>
  panic("filewrite");
8010111e:	c7 04 24 d5 87 10 80 	movl   $0x801087d5,(%esp)
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
80101139:	8b 35 20 2a 11 80    	mov    0x80112a20,%esi
{
8010113f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101142:	85 f6                	test   %esi,%esi
80101144:	0f 84 7e 00 00 00    	je     801011c8 <balloc+0x98>
8010114a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101151:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101154:	8b 1d 38 2a 11 80    	mov    0x80112a38,%ebx
8010115a:	89 f0                	mov    %esi,%eax
8010115c:	c1 f8 0c             	sar    $0xc,%eax
8010115f:	01 d8                	add    %ebx,%eax
80101161:	89 44 24 04          	mov    %eax,0x4(%esp)
80101165:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101168:	89 04 24             	mov    %eax,(%esp)
8010116b:	e8 60 ef ff ff       	call   801000d0 <bread>
80101170:	89 c3                	mov    %eax,%ebx
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101172:	a1 20 2a 11 80       	mov    0x80112a20,%eax
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
801011c0:	39 05 20 2a 11 80    	cmp    %eax,0x80112a20
801011c6:	77 89                	ja     80101151 <balloc+0x21>
  }
  panic("balloc: out of blocks");
801011c8:	c7 04 24 df 87 10 80 	movl   $0x801087df,(%esp)
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
80101218:	e8 f3 48 00 00       	call   80105b10 <memset>
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
8010124a:	bb 74 2a 11 80       	mov    $0x80112a74,%ebx
{
8010124f:	83 ec 2c             	sub    $0x2c,%esp
  acquire(&icache.lock);
80101252:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
{
80101259:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
8010125c:	e8 bf 47 00 00       	call   80105a20 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101261:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101264:	eb 18                	jmp    8010127e <iget+0x3e>
80101266:	8d 76 00             	lea    0x0(%esi),%esi
80101269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101270:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101276:	81 fb 94 46 11 80    	cmp    $0x80114694,%ebx
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
80101298:	81 fb 94 46 11 80    	cmp    $0x80114694,%ebx
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
801012b7:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
801012be:	e8 fd 47 00 00       	call   80105ac0 <release>

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
801012d8:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
      ip->ref++;
801012df:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801012e2:	e8 d9 47 00 00       	call   80105ac0 <release>
}
801012e7:	83 c4 2c             	add    $0x2c,%esp
801012ea:	89 f0                	mov    %esi,%eax
801012ec:	5b                   	pop    %ebx
801012ed:	5e                   	pop    %esi
801012ee:	5f                   	pop    %edi
801012ef:	5d                   	pop    %ebp
801012f0:	c3                   	ret    
    panic("iget: no inodes");
801012f1:	c7 04 24 f5 87 10 80 	movl   $0x801087f5,(%esp)
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
801013c1:	c7 04 24 05 88 10 80 	movl   $0x80108805,(%esp)
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
80101408:	e8 c3 47 00 00       	call   80105bd0 <memmove>
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
8010142c:	ba 20 2a 11 80       	mov    $0x80112a20,%edx
80101431:	89 54 24 04          	mov    %edx,0x4(%esp)
80101435:	89 04 24             	mov    %eax,(%esp)
80101438:	e8 93 ff ff ff       	call   801013d0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
8010143d:	8b 0d 38 2a 11 80    	mov    0x80112a38,%ecx
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
80101497:	c7 04 24 18 88 10 80 	movl   $0x80108818,(%esp)
8010149e:	e8 cd ee ff ff       	call   80100370 <panic>
801014a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801014a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801014b0 <iinit>:
{
801014b0:	55                   	push   %ebp
  initlock(&icache.lock, "icache");
801014b1:	b9 2b 88 10 80       	mov    $0x8010882b,%ecx
{
801014b6:	89 e5                	mov    %esp,%ebp
801014b8:	53                   	push   %ebx
801014b9:	bb 80 2a 11 80       	mov    $0x80112a80,%ebx
801014be:	83 ec 24             	sub    $0x24,%esp
  initlock(&icache.lock, "icache");
801014c1:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801014c5:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
801014cc:	e8 ff 43 00 00       	call   801058d0 <initlock>
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
801014e0:	ba 32 88 10 80       	mov    $0x80108832,%edx
801014e5:	89 1c 24             	mov    %ebx,(%esp)
801014e8:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014ee:	89 54 24 04          	mov    %edx,0x4(%esp)
801014f2:	e8 a9 42 00 00       	call   801057a0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014f7:	81 fb a0 46 11 80    	cmp    $0x801146a0,%ebx
801014fd:	75 e1                	jne    801014e0 <iinit+0x30>
  readsb(dev, &sb);
801014ff:	b8 20 2a 11 80       	mov    $0x80112a20,%eax
80101504:	89 44 24 04          	mov    %eax,0x4(%esp)
80101508:	8b 45 08             	mov    0x8(%ebp),%eax
8010150b:	89 04 24             	mov    %eax,(%esp)
8010150e:	e8 bd fe ff ff       	call   801013d0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101513:	a1 38 2a 11 80       	mov    0x80112a38,%eax
80101518:	c7 04 24 98 88 10 80 	movl   $0x80108898,(%esp)
8010151f:	89 44 24 1c          	mov    %eax,0x1c(%esp)
80101523:	a1 34 2a 11 80       	mov    0x80112a34,%eax
80101528:	89 44 24 18          	mov    %eax,0x18(%esp)
8010152c:	a1 30 2a 11 80       	mov    0x80112a30,%eax
80101531:	89 44 24 14          	mov    %eax,0x14(%esp)
80101535:	a1 2c 2a 11 80       	mov    0x80112a2c,%eax
8010153a:	89 44 24 10          	mov    %eax,0x10(%esp)
8010153e:	a1 28 2a 11 80       	mov    0x80112a28,%eax
80101543:	89 44 24 0c          	mov    %eax,0xc(%esp)
80101547:	a1 24 2a 11 80       	mov    0x80112a24,%eax
8010154c:	89 44 24 08          	mov    %eax,0x8(%esp)
80101550:	a1 20 2a 11 80       	mov    0x80112a20,%eax
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
8010157d:	83 3d 28 2a 11 80 01 	cmpl   $0x1,0x80112a28
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
801015a9:	39 1d 28 2a 11 80    	cmp    %ebx,0x80112a28
801015af:	76 70                	jbe    80101621 <ialloc+0xb1>
    bp = bread(dev, IBLOCK(inum, sb));
801015b1:	8b 0d 34 2a 11 80    	mov    0x80112a34,%ecx
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
801015f3:	e8 18 45 00 00       	call   80105b10 <memset>
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
80101621:	c7 04 24 38 88 10 80 	movl   $0x80108838,(%esp)
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
8010163b:	8b 15 34 2a 11 80    	mov    0x80112a34,%edx
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
801016a2:	e8 29 45 00 00       	call   80105bd0 <memmove>
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
801016ca:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
801016d1:	e8 4a 43 00 00       	call   80105a20 <acquire>
  ip->ref++;
801016d6:	ff 43 08             	incl   0x8(%ebx)
  release(&icache.lock);
801016d9:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
801016e0:	e8 db 43 00 00       	call   80105ac0 <release>
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
80101714:	e8 c7 40 00 00       	call   801057e0 <acquiresleep>
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
80101733:	8b 15 34 2a 11 80    	mov    0x80112a34,%edx
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
80101796:	e8 35 44 00 00       	call   80105bd0 <memmove>
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
801017b5:	c7 04 24 50 88 10 80 	movl   $0x80108850,(%esp)
801017bc:	e8 af eb ff ff       	call   80100370 <panic>
    panic("ilock");
801017c1:	c7 04 24 4a 88 10 80 	movl   $0x8010884a,(%esp)
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
801017e9:	e8 92 40 00 00       	call   80105880 <holdingsleep>
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
80101805:	e9 36 40 00 00       	jmp    80105840 <releasesleep>
    panic("iunlock");
8010180a:	c7 04 24 5f 88 10 80 	movl   $0x8010885f,(%esp)
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
80101838:	e8 a3 3f 00 00       	call   801057e0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
8010183d:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101840:	85 d2                	test   %edx,%edx
80101842:	74 07                	je     8010184b <iput+0x2b>
80101844:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101849:	74 35                	je     80101880 <iput+0x60>
  releasesleep(&ip->lock);
8010184b:	89 3c 24             	mov    %edi,(%esp)
8010184e:	e8 ed 3f 00 00       	call   80105840 <releasesleep>
  acquire(&icache.lock);
80101853:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
8010185a:	e8 c1 41 00 00       	call   80105a20 <acquire>
  ip->ref--;
8010185f:	ff 4b 08             	decl   0x8(%ebx)
  release(&icache.lock);
80101862:	c7 45 08 40 2a 11 80 	movl   $0x80112a40,0x8(%ebp)
}
80101869:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010186c:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010186f:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101872:	89 ec                	mov    %ebp,%esp
80101874:	5d                   	pop    %ebp
  release(&icache.lock);
80101875:	e9 46 42 00 00       	jmp    80105ac0 <release>
8010187a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101880:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101887:	e8 94 41 00 00       	call   80105a20 <acquire>
    int r = ip->ref;
8010188c:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
8010188f:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101896:	e8 25 42 00 00       	call   80105ac0 <release>
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
80101a83:	e8 48 41 00 00       	call   80105bd0 <memmove>
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
80101aca:	8b 04 c5 c0 29 11 80 	mov    -0x7feed640(,%eax,8),%eax
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
80101baf:	e8 1c 40 00 00       	call   80105bd0 <memmove>
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
80101bfa:	8b 04 c5 c4 29 11 80 	mov    -0x7feed63c(,%eax,8),%eax
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
80101c5c:	e8 cf 3f 00 00       	call   80105c30 <strncmp>
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
80101cdb:	e8 50 3f 00 00       	call   80105c30 <strncmp>
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
80101d1f:	c7 04 24 79 88 10 80 	movl   $0x80108879,(%esp)
80101d26:	e8 45 e6 ff ff       	call   80100370 <panic>
    panic("dirlookup not DIR");
80101d2b:	c7 04 24 67 88 10 80 	movl   $0x80108867,(%esp)
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
80101d59:	e8 42 1c 00 00       	call   801039a0 <myproc>
80101d5e:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101d61:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101d68:	e8 b3 3c 00 00       	call   80105a20 <acquire>
  ip->ref++;
80101d6d:	ff 46 08             	incl   0x8(%esi)
  release(&icache.lock);
80101d70:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101d77:	e8 44 3d 00 00       	call   80105ac0 <release>
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
80101ddc:	e8 ef 3d 00 00       	call   80105bd0 <memmove>
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
80101e65:	e8 66 3d 00 00       	call   80105bd0 <memmove>
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
80101f73:	e8 18 3d 00 00       	call   80105c90 <strncpy>
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
80101fb6:	c7 04 24 88 88 10 80 	movl   $0x80108888,(%esp)
80101fbd:	e8 ae e3 ff ff       	call   80100370 <panic>
    panic("dirlink");
80101fc2:	c7 04 24 0e 8f 10 80 	movl   $0x80108f0e,(%esp)
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
801020bc:	c7 04 24 f4 88 10 80 	movl   $0x801088f4,(%esp)
801020c3:	e8 a8 e2 ff ff       	call   80100370 <panic>
    panic("idestart");
801020c8:	c7 04 24 eb 88 10 80 	movl   $0x801088eb,(%esp)
801020cf:	e8 9c e2 ff ff       	call   80100370 <panic>
801020d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801020da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801020e0 <ideinit>:
{
801020e0:	55                   	push   %ebp
  initlock(&idelock, "ide");
801020e1:	ba 06 89 10 80       	mov    $0x80108906,%edx
{
801020e6:	89 e5                	mov    %esp,%ebp
801020e8:	83 ec 18             	sub    $0x18,%esp
  initlock(&idelock, "ide");
801020eb:	89 54 24 04          	mov    %edx,0x4(%esp)
801020ef:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
801020f6:	e8 d5 37 00 00       	call   801058d0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801020fb:	a1 60 4d 11 80       	mov    0x80114d60,%eax
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
8010214d:	a3 60 c5 10 80       	mov    %eax,0x8010c560
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
80102166:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
{
8010216d:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80102170:	89 75 f8             	mov    %esi,-0x8(%ebp)
80102173:	89 7d fc             	mov    %edi,-0x4(%ebp)
  acquire(&idelock);
80102176:	e8 a5 38 00 00       	call   80105a20 <acquire>

  if((b = idequeue) == 0){
8010217b:	8b 1d 64 c5 10 80    	mov    0x8010c564,%ebx
80102181:	85 db                	test   %ebx,%ebx
80102183:	74 5c                	je     801021e1 <ideintr+0x81>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102185:	8b 43 58             	mov    0x58(%ebx),%eax
80102188:	a3 64 c5 10 80       	mov    %eax,0x8010c564

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
801021ce:	e8 fd 23 00 00       	call   801045d0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801021d3:	a1 64 c5 10 80       	mov    0x8010c564,%eax
801021d8:	85 c0                	test   %eax,%eax
801021da:	74 05                	je     801021e1 <ideintr+0x81>
    idestart(idequeue);
801021dc:	e8 2f fe ff ff       	call   80102010 <idestart>
    release(&idelock);
801021e1:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
801021e8:	e8 d3 38 00 00       	call   80105ac0 <release>

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
80102210:	e8 6b 36 00 00       	call   80105880 <holdingsleep>
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
80102232:	8b 15 60 c5 10 80    	mov    0x8010c560,%edx
80102238:	85 d2                	test   %edx,%edx
8010223a:	0f 84 9f 00 00 00    	je     801022df <iderw+0xdf>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102240:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
80102247:	e8 d4 37 00 00       	call   80105a20 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010224c:	8b 15 64 c5 10 80    	mov    0x8010c564,%edx
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
8010226e:	39 1d 64 c5 10 80    	cmp    %ebx,0x8010c564
80102274:	75 1b                	jne    80102291 <iderw+0x91>
80102276:	eb 38                	jmp    801022b0 <iderw+0xb0>
80102278:	90                   	nop
80102279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
80102280:	b8 80 c5 10 80       	mov    $0x8010c580,%eax
80102285:	89 44 24 04          	mov    %eax,0x4(%esp)
80102289:	89 1c 24             	mov    %ebx,(%esp)
8010228c:	e8 5f 21 00 00       	call   801043f0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102291:	8b 03                	mov    (%ebx),%eax
80102293:	83 e0 06             	and    $0x6,%eax
80102296:	83 f8 02             	cmp    $0x2,%eax
80102299:	75 e5                	jne    80102280 <iderw+0x80>
  }


  release(&idelock);
8010229b:	c7 45 08 80 c5 10 80 	movl   $0x8010c580,0x8(%ebp)
}
801022a2:	83 c4 14             	add    $0x14,%esp
801022a5:	5b                   	pop    %ebx
801022a6:	5d                   	pop    %ebp
  release(&idelock);
801022a7:	e9 14 38 00 00       	jmp    80105ac0 <release>
801022ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
801022b0:	89 d8                	mov    %ebx,%eax
801022b2:	e8 59 fd ff ff       	call   80102010 <idestart>
801022b7:	eb d8                	jmp    80102291 <iderw+0x91>
801022b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022c0:	ba 64 c5 10 80       	mov    $0x8010c564,%edx
801022c5:	eb a5                	jmp    8010226c <iderw+0x6c>
    panic("iderw: nothing to do");
801022c7:	c7 04 24 20 89 10 80 	movl   $0x80108920,(%esp)
801022ce:	e8 9d e0 ff ff       	call   80100370 <panic>
    panic("iderw: buf not locked");
801022d3:	c7 04 24 0a 89 10 80 	movl   $0x8010890a,(%esp)
801022da:	e8 91 e0 ff ff       	call   80100370 <panic>
    panic("iderw: ide disk 1 not present");
801022df:	c7 04 24 35 89 10 80 	movl   $0x80108935,(%esp)
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
80102302:	a3 94 46 11 80       	mov    %eax,0x80114694
  ioapic->reg = reg;
80102307:	89 15 00 00 c0 fe    	mov    %edx,0xfec00000
  return ioapic->data;
8010230d:	a1 94 46 11 80       	mov    0x80114694,%eax
80102312:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102315:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
8010231b:	8b 0d 94 46 11 80    	mov    0x80114694,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102321:	0f b6 15 c0 47 11 80 	movzbl 0x801147c0,%edx
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
80102338:	c7 04 24 54 89 10 80 	movl   $0x80108954,(%esp)
8010233f:	e8 0c e3 ff ff       	call   80100650 <cprintf>
80102344:	8b 0d 94 46 11 80    	mov    0x80114694,%ecx
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
80102365:	8b 0d 94 46 11 80    	mov    0x80114694,%ecx
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
8010237e:	8b 0d 94 46 11 80    	mov    0x80114694,%ecx
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
801023a1:	8b 0d 94 46 11 80    	mov    0x80114694,%ecx
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
801023b6:	8b 0d 94 46 11 80    	mov    0x80114694,%ecx
801023bc:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801023c2:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023c4:	a1 94 46 11 80       	mov    0x80114694,%eax
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
801023f6:	81 fb 08 82 11 80    	cmp    $0x80118208,%ebx
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
80102420:	e8 eb 36 00 00       	call   80105b10 <memset>

  if(kmem.use_lock)
80102425:	a1 d4 46 11 80       	mov    0x801146d4,%eax
8010242a:	85 c0                	test   %eax,%eax
8010242c:	75 3a                	jne    80102468 <kfree+0x88>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
8010242e:	a1 d8 46 11 80       	mov    0x801146d8,%eax
80102433:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
80102435:	a1 d4 46 11 80       	mov    0x801146d4,%eax
  kmem.freelist = r;
8010243a:	89 1d d8 46 11 80    	mov    %ebx,0x801146d8
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
80102450:	c7 45 08 a0 46 11 80 	movl   $0x801146a0,0x8(%ebp)
}
80102457:	83 c4 14             	add    $0x14,%esp
8010245a:	5b                   	pop    %ebx
8010245b:	5d                   	pop    %ebp
    release(&kmem.lock);
8010245c:	e9 5f 36 00 00       	jmp    80105ac0 <release>
80102461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&kmem.lock);
80102468:	c7 04 24 a0 46 11 80 	movl   $0x801146a0,(%esp)
8010246f:	e8 ac 35 00 00       	call   80105a20 <acquire>
80102474:	eb b8                	jmp    8010242e <kfree+0x4e>
    panic("kfree");
80102476:	c7 04 24 86 89 10 80 	movl   $0x80108986,(%esp)
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
801024e1:	b8 8c 89 10 80       	mov    $0x8010898c,%eax
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
801024f4:	c7 04 24 a0 46 11 80 	movl   $0x801146a0,(%esp)
801024fb:	e8 d0 33 00 00       	call   801058d0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
80102500:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 0;
80102503:	31 d2                	xor    %edx,%edx
80102505:	89 15 d4 46 11 80    	mov    %edx,0x801146d4
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
8010259d:	a3 d4 46 11 80       	mov    %eax,0x801146d4
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
801025b0:	a1 d4 46 11 80       	mov    0x801146d4,%eax
801025b5:	85 c0                	test   %eax,%eax
801025b7:	75 1f                	jne    801025d8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801025b9:	a1 d8 46 11 80       	mov    0x801146d8,%eax
  if(r)
801025be:	85 c0                	test   %eax,%eax
801025c0:	74 0e                	je     801025d0 <kalloc+0x20>
    kmem.freelist = r->next;
801025c2:	8b 10                	mov    (%eax),%edx
801025c4:	89 15 d8 46 11 80    	mov    %edx,0x801146d8
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
801025de:	c7 04 24 a0 46 11 80 	movl   $0x801146a0,(%esp)
801025e5:	e8 36 34 00 00       	call   80105a20 <acquire>
  r = kmem.freelist;
801025ea:	a1 d8 46 11 80       	mov    0x801146d8,%eax
801025ef:	8b 15 d4 46 11 80    	mov    0x801146d4,%edx
  if(r)
801025f5:	85 c0                	test   %eax,%eax
801025f7:	74 08                	je     80102601 <kalloc+0x51>
    kmem.freelist = r->next;
801025f9:	8b 08                	mov    (%eax),%ecx
801025fb:	89 0d d8 46 11 80    	mov    %ecx,0x801146d8
  if(kmem.use_lock)
80102601:	85 d2                	test   %edx,%edx
80102603:	74 12                	je     80102617 <kalloc+0x67>
    release(&kmem.lock);
80102605:	c7 04 24 a0 46 11 80 	movl   $0x801146a0,(%esp)
8010260c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010260f:	e8 ac 34 00 00       	call   80105ac0 <release>
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
8010263d:	8b 1d b4 c5 10 80    	mov    0x8010c5b4,%ebx

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
80102664:	0f b6 8a c0 8a 10 80 	movzbl -0x7fef7540(%edx),%ecx
  shift ^= togglecode[data];
8010266b:	0f b6 82 c0 89 10 80 	movzbl -0x7fef7640(%edx),%eax
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
8010267e:	8b 04 85 a0 89 10 80 	mov    -0x7fef7660(,%eax,4),%eax
  shift ^= togglecode[data];
80102685:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
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
801026b9:	0f b6 82 c0 8a 10 80 	movzbl -0x7fef7540(%edx),%eax
801026c0:	0c 40                	or     $0x40,%al
801026c2:	0f b6 c8             	movzbl %al,%ecx
    return 0;
801026c5:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801026c7:	f7 d1                	not    %ecx
801026c9:	21 d9                	and    %ebx,%ecx
801026cb:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
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
801026dd:	89 1d b4 c5 10 80    	mov    %ebx,0x8010c5b4
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
80102730:	a1 dc 46 11 80       	mov    0x801146dc,%eax
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
80102830:	a1 dc 46 11 80       	mov    0x801146dc,%eax
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
80102850:	a1 dc 46 11 80       	mov    0x801146dc,%eax
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
801028b1:	a1 dc 46 11 80       	mov    0x801146dc,%eax
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
80102a20:	e8 4b 31 00 00       	call   80105b70 <memcmp>
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
80102ad0:	8b 15 28 47 11 80    	mov    0x80114728,%edx
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
80102af0:	a1 14 47 11 80       	mov    0x80114714,%eax
80102af5:	01 d8                	add    %ebx,%eax
80102af7:	40                   	inc    %eax
80102af8:	89 44 24 04          	mov    %eax,0x4(%esp)
80102afc:	a1 24 47 11 80       	mov    0x80114724,%eax
80102b01:	89 04 24             	mov    %eax,(%esp)
80102b04:	e8 c7 d5 ff ff       	call   801000d0 <bread>
80102b09:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b0b:	8b 04 9d 2c 47 11 80 	mov    -0x7feeb8d4(,%ebx,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
80102b12:	43                   	inc    %ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b13:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b17:	a1 24 47 11 80       	mov    0x80114724,%eax
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
80102b3c:	e8 8f 30 00 00       	call   80105bd0 <memmove>
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
80102b59:	39 1d 28 47 11 80    	cmp    %ebx,0x80114728
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
80102b88:	a1 14 47 11 80       	mov    0x80114714,%eax
80102b8d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b91:	a1 24 47 11 80       	mov    0x80114724,%eax
80102b96:	89 04 24             	mov    %eax,(%esp)
80102b99:	e8 32 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b9e:	8b 1d 28 47 11 80    	mov    0x80114728,%ebx
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
80102bc0:	8b 8a 2c 47 11 80    	mov    -0x7feeb8d4(%edx),%ecx
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
80102bf1:	ba c0 8b 10 80       	mov    $0x80108bc0,%edx
{
80102bf6:	89 e5                	mov    %esp,%ebp
80102bf8:	53                   	push   %ebx
80102bf9:	83 ec 34             	sub    $0x34,%esp
80102bfc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102bff:	89 54 24 04          	mov    %edx,0x4(%esp)
80102c03:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102c0a:	e8 c1 2c 00 00       	call   801058d0 <initlock>
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
80102c27:	89 1d 24 47 11 80    	mov    %ebx,0x80114724
  struct buf *buf = bread(log.dev, log.start);
80102c2d:	89 44 24 04          	mov    %eax,0x4(%esp)
  log.start = sb.logstart;
80102c31:	a3 14 47 11 80       	mov    %eax,0x80114714
  log.size = sb.nlog;
80102c36:	89 15 18 47 11 80    	mov    %edx,0x80114718
  struct buf *buf = bread(log.dev, log.start);
80102c3c:	e8 8f d4 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102c41:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102c44:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102c46:	89 1d 28 47 11 80    	mov    %ebx,0x80114728
  for (i = 0; i < log.lh.n; i++) {
80102c4c:	7e 23                	jle    80102c71 <initlog+0x81>
80102c4e:	c1 e3 02             	shl    $0x2,%ebx
80102c51:	31 d2                	xor    %edx,%edx
80102c53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.lh.block[i] = lh->block[i];
80102c60:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102c64:	83 c2 04             	add    $0x4,%edx
80102c67:	89 8a 28 47 11 80    	mov    %ecx,-0x7feeb8d8(%edx)
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
80102c80:	a3 28 47 11 80       	mov    %eax,0x80114728
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
80102c96:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102c9d:	e8 7e 2d 00 00       	call   80105a20 <acquire>
80102ca2:	eb 19                	jmp    80102cbd <begin_op+0x2d>
80102ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102ca8:	b8 e0 46 11 80       	mov    $0x801146e0,%eax
80102cad:	89 44 24 04          	mov    %eax,0x4(%esp)
80102cb1:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102cb8:	e8 33 17 00 00       	call   801043f0 <sleep>
    if(log.committing){
80102cbd:	8b 15 20 47 11 80    	mov    0x80114720,%edx
80102cc3:	85 d2                	test   %edx,%edx
80102cc5:	75 e1                	jne    80102ca8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102cc7:	a1 1c 47 11 80       	mov    0x8011471c,%eax
80102ccc:	8b 15 28 47 11 80    	mov    0x80114728,%edx
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
80102cde:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
      log.outstanding += 1;
80102ce5:	a3 1c 47 11 80       	mov    %eax,0x8011471c
      release(&log.lock);
80102cea:	e8 d1 2d 00 00       	call   80105ac0 <release>
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
80102d09:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102d10:	e8 0b 2d 00 00       	call   80105a20 <acquire>
  log.outstanding -= 1;
80102d15:	a1 1c 47 11 80       	mov    0x8011471c,%eax
80102d1a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102d1d:	a1 20 47 11 80       	mov    0x80114720,%eax
  log.outstanding -= 1;
80102d22:	89 1d 1c 47 11 80    	mov    %ebx,0x8011471c
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
80102d3d:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
    log.committing = 1;
80102d44:	89 35 20 47 11 80    	mov    %esi,0x80114720
  release(&log.lock);
80102d4a:	e8 71 2d 00 00       	call   80105ac0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d4f:	8b 3d 28 47 11 80    	mov    0x80114728,%edi
80102d55:	85 ff                	test   %edi,%edi
80102d57:	0f 8e 88 00 00 00    	jle    80102de5 <end_op+0xe5>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102d5d:	a1 14 47 11 80       	mov    0x80114714,%eax
80102d62:	01 d8                	add    %ebx,%eax
80102d64:	40                   	inc    %eax
80102d65:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d69:	a1 24 47 11 80       	mov    0x80114724,%eax
80102d6e:	89 04 24             	mov    %eax,(%esp)
80102d71:	e8 5a d3 ff ff       	call   801000d0 <bread>
80102d76:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d78:	8b 04 9d 2c 47 11 80 	mov    -0x7feeb8d4(,%ebx,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
80102d7f:	43                   	inc    %ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d80:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d84:	a1 24 47 11 80       	mov    0x80114724,%eax
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
80102da9:	e8 22 2e 00 00       	call   80105bd0 <memmove>
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
80102dc6:	3b 1d 28 47 11 80    	cmp    0x80114728,%ebx
80102dcc:	7c 8f                	jl     80102d5d <end_op+0x5d>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102dce:	e8 ad fd ff ff       	call   80102b80 <write_head>
    install_trans(); // Now install writes to home locations
80102dd3:	e8 f8 fc ff ff       	call   80102ad0 <install_trans>
    log.lh.n = 0;
80102dd8:	31 d2                	xor    %edx,%edx
80102dda:	89 15 28 47 11 80    	mov    %edx,0x80114728
    write_head();    // Erase the transaction from the log
80102de0:	e8 9b fd ff ff       	call   80102b80 <write_head>
    acquire(&log.lock);
80102de5:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102dec:	e8 2f 2c 00 00       	call   80105a20 <acquire>
    log.committing = 0;
80102df1:	31 c0                	xor    %eax,%eax
80102df3:	a3 20 47 11 80       	mov    %eax,0x80114720
    wakeup(&log);
80102df8:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102dff:	e8 cc 17 00 00       	call   801045d0 <wakeup>
    release(&log.lock);
80102e04:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102e0b:	e8 b0 2c 00 00       	call   80105ac0 <release>
}
80102e10:	83 c4 1c             	add    $0x1c,%esp
80102e13:	5b                   	pop    %ebx
80102e14:	5e                   	pop    %esi
80102e15:	5f                   	pop    %edi
80102e16:	5d                   	pop    %ebp
80102e17:	c3                   	ret    
    panic("log.committing");
80102e18:	c7 04 24 c4 8b 10 80 	movl   $0x80108bc4,(%esp)
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
80102e37:	8b 15 28 47 11 80    	mov    0x80114728,%edx
{
80102e3d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e40:	83 fa 1d             	cmp    $0x1d,%edx
80102e43:	0f 8f 95 00 00 00    	jg     80102ede <log_write+0xae>
80102e49:	a1 18 47 11 80       	mov    0x80114718,%eax
80102e4e:	48                   	dec    %eax
80102e4f:	39 c2                	cmp    %eax,%edx
80102e51:	0f 8d 87 00 00 00    	jge    80102ede <log_write+0xae>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102e57:	a1 1c 47 11 80       	mov    0x8011471c,%eax
80102e5c:	85 c0                	test   %eax,%eax
80102e5e:	0f 8e 86 00 00 00    	jle    80102eea <log_write+0xba>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102e64:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102e6b:	e8 b0 2b 00 00       	call   80105a20 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102e70:	8b 0d 28 47 11 80    	mov    0x80114728,%ecx
80102e76:	83 f9 00             	cmp    $0x0,%ecx
80102e79:	7e 55                	jle    80102ed0 <log_write+0xa0>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e7b:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102e7e:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e80:	3b 15 2c 47 11 80    	cmp    0x8011472c,%edx
80102e86:	75 11                	jne    80102e99 <log_write+0x69>
80102e88:	eb 36                	jmp    80102ec0 <log_write+0x90>
80102e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102e90:	39 14 85 2c 47 11 80 	cmp    %edx,-0x7feeb8d4(,%eax,4)
80102e97:	74 27                	je     80102ec0 <log_write+0x90>
  for (i = 0; i < log.lh.n; i++) {
80102e99:	40                   	inc    %eax
80102e9a:	39 c1                	cmp    %eax,%ecx
80102e9c:	75 f2                	jne    80102e90 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102e9e:	89 14 85 2c 47 11 80 	mov    %edx,-0x7feeb8d4(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102ea5:	40                   	inc    %eax
80102ea6:	a3 28 47 11 80       	mov    %eax,0x80114728
  b->flags |= B_DIRTY; // prevent eviction
80102eab:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102eae:	c7 45 08 e0 46 11 80 	movl   $0x801146e0,0x8(%ebp)
}
80102eb5:	83 c4 14             	add    $0x14,%esp
80102eb8:	5b                   	pop    %ebx
80102eb9:	5d                   	pop    %ebp
  release(&log.lock);
80102eba:	e9 01 2c 00 00       	jmp    80105ac0 <release>
80102ebf:	90                   	nop
  log.lh.block[i] = b->blockno;
80102ec0:	89 14 85 2c 47 11 80 	mov    %edx,-0x7feeb8d4(,%eax,4)
80102ec7:	eb e2                	jmp    80102eab <log_write+0x7b>
80102ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ed0:	8b 43 08             	mov    0x8(%ebx),%eax
80102ed3:	a3 2c 47 11 80       	mov    %eax,0x8011472c
  if (i == log.lh.n)
80102ed8:	75 d1                	jne    80102eab <log_write+0x7b>
80102eda:	31 c0                	xor    %eax,%eax
80102edc:	eb c7                	jmp    80102ea5 <log_write+0x75>
    panic("too big a transaction");
80102ede:	c7 04 24 d3 8b 10 80 	movl   $0x80108bd3,(%esp)
80102ee5:	e8 86 d4 ff ff       	call   80100370 <panic>
    panic("log_write outside of trans");
80102eea:	c7 04 24 e9 8b 10 80 	movl   $0x80108be9,(%esp)
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
80102f07:	e8 14 51 00 00       	call   80108020 <switchkvm>
  seginit();
80102f0c:	e8 7f 50 00 00       	call   80107f90 <seginit>
  lapicinit();
80102f11:	e8 1a f8 ff ff       	call   80102730 <lapicinit>
}

static void
mpmain(void) //called by the non-boot AP cpus
{
  struct cpu* c = mycpu();
80102f16:	e8 e5 09 00 00       	call   80103900 <mycpu>
80102f1b:	89 c3                	mov    %eax,%ebx
  cprintf("cpu%d: is witing for the \"pioneer\" cpu to finish its initialization.\n", cpuid());
80102f1d:	e8 5e 0a 00 00       	call   80103980 <cpuid>
80102f22:	c7 04 24 04 8c 10 80 	movl   $0x80108c04,(%esp)
80102f29:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f2d:	e8 1e d7 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80102f32:	e8 99 3f 00 00       	call   80106ed0 <idtinit>
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
80102f5a:	e8 21 0a 00 00       	call   80103980 <cpuid>
80102f5f:	89 c3                	mov    %eax,%ebx
80102f61:	e8 1a 0a 00 00       	call   80103980 <cpuid>
80102f66:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80102f6a:	c7 04 24 54 8c 10 80 	movl   $0x80108c54,(%esp)
80102f71:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f75:	e8 d6 d6 ff ff       	call   80100650 <cprintf>
  scheduler();     // start running processes
80102f7a:	e8 51 11 00 00       	call   801040d0 <scheduler>
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
80102f93:	c7 04 24 08 82 11 80 	movl   $0x80118208,(%esp)
80102f9a:	e8 41 f5 ff ff       	call   801024e0 <kinit1>
  kvmalloc();      // kernel page table
80102f9f:	e8 4c 55 00 00       	call   801084f0 <kvmalloc>
  mpinit();        // detect other processors
80102fa4:	e8 17 02 00 00       	call   801031c0 <mpinit>
  lapicinit();     // interrupt controller
80102fa9:	e8 82 f7 ff ff       	call   80102730 <lapicinit>
80102fae:	66 90                	xchg   %ax,%ax
  seginit();       // segment descriptors
80102fb0:	e8 db 4f 00 00       	call   80107f90 <seginit>
  picinit();       // disable pic
80102fb5:	e8 e6 03 00 00       	call   801033a0 <picinit>
  ioapicinit();    // another interrupt controller
80102fba:	e8 31 f3 ff ff       	call   801022f0 <ioapicinit>
80102fbf:	90                   	nop
  consoleinit();   // console hardware
80102fc0:	e8 bb d9 ff ff       	call   80100980 <consoleinit>
  uartinit();      // serial port
80102fc5:	e8 96 42 00 00       	call   80107260 <uartinit>
  pinit();         // process table
80102fca:	e8 11 09 00 00       	call   801038e0 <pinit>
80102fcf:	90                   	nop
  tvinit();        // trap vectors
80102fd0:	e8 7b 3e 00 00       	call   80106e50 <tvinit>
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
80102fee:	b8 8c c4 10 80       	mov    $0x8010c48c,%eax
80102ff3:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ff7:	c7 04 24 00 70 00 80 	movl   $0x80007000,(%esp)
80102ffe:	e8 cd 2b 00 00       	call   80105bd0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103003:	a1 60 4d 11 80       	mov    0x80114d60,%eax
80103008:	8d 14 80             	lea    (%eax,%eax,4),%edx
8010300b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010300e:	c1 e0 04             	shl    $0x4,%eax
80103011:	05 e0 47 11 80       	add    $0x801147e0,%eax
80103016:	3d e0 47 11 80       	cmp    $0x801147e0,%eax
8010301b:	0f 86 86 00 00 00    	jbe    801030a7 <main+0x127>
80103021:	bb e0 47 11 80       	mov    $0x801147e0,%ebx
80103026:	8d 76 00             	lea    0x0(%esi),%esi
80103029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80103030:	e8 cb 08 00 00       	call   80103900 <mycpu>
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
80103043:	b9 00 b0 10 00       	mov    $0x10b000,%ecx
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
8010308a:	a1 60 4d 11 80       	mov    0x80114d60,%eax
8010308f:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103095:	8d 14 80             	lea    (%eax,%eax,4),%edx
80103098:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010309b:	c1 e0 04             	shl    $0x4,%eax
8010309e:	05 e0 47 11 80       	add    $0x801147e0,%eax
801030a3:	39 c3                	cmp    %eax,%ebx
801030a5:	72 89                	jb     80103030 <main+0xb0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801030a7:	b8 00 00 00 8e       	mov    $0x8e000000,%eax
801030ac:	89 44 24 04          	mov    %eax,0x4(%esp)
801030b0:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
801030b7:	e8 94 f4 ff ff       	call   80102550 <kinit2>
  initSchedDS(); // initialize the data structures for the processes sceduling policies
801030bc:	e8 7f 1c 00 00       	call   80104d40 <initSchedDS>
	__sync_synchronize();
801030c1:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  for(struct cpu *c = cpus; c < cpus + ncpu; ++c) //releases the non-boot AP cpus that are wating at mpmain at main.c
801030c6:	a1 60 4d 11 80       	mov    0x80114d60,%eax
801030cb:	8d 14 80             	lea    (%eax,%eax,4),%edx
801030ce:	8d 0c 50             	lea    (%eax,%edx,2),%ecx
801030d1:	c1 e1 04             	shl    $0x4,%ecx
801030d4:	81 c1 e0 47 11 80    	add    $0x801147e0,%ecx
801030da:	81 f9 e0 47 11 80    	cmp    $0x801147e0,%ecx
801030e0:	76 21                	jbe    80103103 <main+0x183>
801030e2:	ba e0 47 11 80       	mov    $0x801147e0,%edx
801030e7:	31 db                	xor    %ebx,%ebx
801030e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030f0:	89 d8                	mov    %ebx,%eax
801030f2:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
801030f9:	81 c2 b0 00 00 00    	add    $0xb0,%edx
801030ff:	39 ca                	cmp    %ecx,%edx
80103101:	72 ed                	jb     801030f0 <main+0x170>
  userinit();      // first user process
80103103:	e8 c8 08 00 00       	call   801039d0 <userinit>
  cprintf("\"pioneer\" cpu%d: starting %d\n", cpuid(), cpuid());
80103108:	e8 73 08 00 00       	call   80103980 <cpuid>
8010310d:	89 c3                	mov    %eax,%ebx
8010310f:	e8 6c 08 00 00       	call   80103980 <cpuid>
80103114:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80103118:	c7 04 24 4a 8c 10 80 	movl   $0x80108c4a,(%esp)
8010311f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103123:	e8 28 d5 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80103128:	e8 a3 3d 00 00       	call   80106ed0 <idtinit>
  scheduler();     // start running processes
8010312d:	e8 9e 0f 00 00       	call   801040d0 <scheduler>
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
80103166:	ba 68 8c 10 80       	mov    $0x80108c68,%edx
8010316b:	b8 04 00 00 00       	mov    $0x4,%eax
80103170:	89 54 24 04          	mov    %edx,0x4(%esp)
80103174:	89 44 24 08          	mov    %eax,0x8(%esp)
80103178:	89 34 24             	mov    %esi,(%esp)
8010317b:	e8 f0 29 00 00       	call   80105b70 <memcmp>
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
80103224:	ba 85 8c 10 80       	mov    $0x80108c85,%edx
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103229:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
8010322f:	89 44 24 08          	mov    %eax,0x8(%esp)
80103233:	89 54 24 04          	mov    %edx,0x4(%esp)
80103237:	89 34 24             	mov    %esi,(%esp)
8010323a:	e8 31 29 00 00       	call   80105b70 <memcmp>
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
801032b0:	a3 dc 46 11 80       	mov    %eax,0x801146dc
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
801032cf:	ff 24 85 ac 8c 10 80 	jmp    *-0x7fef7354(,%eax,4)
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
80103318:	8b 1d 60 4d 11 80    	mov    0x80114d60,%ebx
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
80103331:	89 1d 60 4d 11 80    	mov    %ebx,0x80114d60
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103337:	88 87 e0 47 11 80    	mov    %al,-0x7feeb820(%edi)
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
8010334f:	a2 c0 47 11 80       	mov    %al,0x801147c0
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
80103380:	c7 04 24 6d 8c 10 80 	movl   $0x80108c6d,(%esp)
80103387:	e8 e4 cf ff ff       	call   80100370 <panic>
    panic("Didn't find a suitable machine");
8010338c:	c7 04 24 8c 8c 10 80 	movl   $0x80108c8c,(%esp)
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
80103460:	ba c0 8c 10 80       	mov    $0x80108cc0,%edx
  p->nread = 0;
80103465:	89 88 34 02 00 00    	mov    %ecx,0x234(%eax)
  initlock(&p->lock, "pipe");
8010346b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010346f:	89 04 24             	mov    %eax,(%esp)
80103472:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103475:	e8 56 24 00 00       	call   801058d0 <initlock>
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
801034d5:	e8 46 25 00 00       	call   80105a20 <acquire>
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
801034ef:	e8 dc 10 00 00       	call   801045d0 <wakeup>
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
80103514:	e9 a7 25 00 00       	jmp    80105ac0 <release>
80103519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->readopen = 0;
80103520:	31 c9                	xor    %ecx,%ecx
    wakeup(&p->nwrite);
80103522:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103528:	89 8b 3c 02 00 00    	mov    %ecx,0x23c(%ebx)
    wakeup(&p->nwrite);
8010352e:	89 04 24             	mov    %eax,(%esp)
80103531:	e8 9a 10 00 00       	call   801045d0 <wakeup>
80103536:	eb bc                	jmp    801034f4 <pipeclose+0x34>
80103538:	90                   	nop
80103539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103540:	89 1c 24             	mov    %ebx,(%esp)
80103543:	e8 78 25 00 00       	call   80105ac0 <release>
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
8010356f:	e8 ac 24 00 00       	call   80105a20 <acquire>
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
801035c3:	e8 08 10 00 00       	call   801045d0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035c8:	89 7c 24 04          	mov    %edi,0x4(%esp)
801035cc:	89 1c 24             	mov    %ebx,(%esp)
801035cf:	e8 1c 0e 00 00       	call   801043f0 <sleep>
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
801035f3:	e8 a8 03 00 00       	call   801039a0 <myproc>
801035f8:	8b 50 24             	mov    0x24(%eax),%edx
801035fb:	85 d2                	test   %edx,%edx
801035fd:	74 c1                	je     801035c0 <pipewrite+0x60>
        release(&p->lock);
801035ff:	89 3c 24             	mov    %edi,(%esp)
80103602:	e8 b9 24 00 00       	call   80105ac0 <release>
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
8010364f:	e8 7c 0f 00 00       	call   801045d0 <wakeup>
  release(&p->lock);
80103654:	89 3c 24             	mov    %edi,(%esp)
80103657:	e8 64 24 00 00       	call   80105ac0 <release>
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
80103682:	e8 99 23 00 00       	call   80105a20 <acquire>
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
801036b7:	e8 34 0d 00 00       	call   801043f0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036bc:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801036c2:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801036c8:	75 36                	jne    80103700 <piperead+0x90>
801036ca:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
801036d0:	85 d2                	test   %edx,%edx
801036d2:	0f 84 88 00 00 00    	je     80103760 <piperead+0xf0>
    if(myproc()->killed){
801036d8:	e8 c3 02 00 00       	call   801039a0 <myproc>
801036dd:	8b 48 24             	mov    0x24(%eax),%ecx
801036e0:	85 c9                	test   %ecx,%ecx
801036e2:	74 cc                	je     801036b0 <piperead+0x40>
      release(&p->lock);
801036e4:	89 34 24             	mov    %esi,(%esp)
      return -1;
801036e7:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801036ec:	e8 cf 23 00 00       	call   80105ac0 <release>
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
80103744:	e8 87 0e 00 00       	call   801045d0 <wakeup>
  release(&p->lock);
80103749:	89 34 24             	mov    %esi,(%esp)
8010374c:	e8 6f 23 00 00       	call   80105ac0 <release>
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
80103774:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
{
80103779:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);
8010377c:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103783:	e8 98 22 00 00       	call   80105a20 <acquire>
80103788:	eb 18                	jmp    801037a2 <allocproc+0x32>
8010378a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103790:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103796:	81 fb b4 79 11 80    	cmp    $0x801179b4,%ebx
8010379c:	0f 83 9e 00 00 00    	jae    80103840 <allocproc+0xd0>
    if(p->state == UNUSED)
801037a2:	8b 43 0c             	mov    0xc(%ebx),%eax
801037a5:	85 c0                	test   %eax,%eax
801037a7:	75 e7                	jne    80103790 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801037a9:	a1 04 c0 10 80       	mov    0x8010c004,%eax
  p->state = EMBRYO;
801037ae:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
801037b5:	8d 50 01             	lea    0x1(%eax),%edx
801037b8:	89 43 10             	mov    %eax,0x10(%ebx)

  release(&ptable.lock);
801037bb:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
  p->pid = nextpid++;
801037c2:	89 15 04 c0 10 80    	mov    %edx,0x8010c004
  release(&ptable.lock);
801037c8:	e8 f3 22 00 00       	call   80105ac0 <release>
  
  acquire(&tickslock);
801037cd:	c7 04 24 c0 79 11 80 	movl   $0x801179c0,(%esp)
801037d4:	e8 47 22 00 00       	call   80105a20 <acquire>
  p->performance.ctime = ticks;
801037d9:	a1 00 82 11 80       	mov    0x80118200,%eax
801037de:	89 83 90 00 00 00    	mov    %eax,0x90(%ebx)
  release(&tickslock);
801037e4:	c7 04 24 c0 79 11 80 	movl   $0x801179c0,(%esp)
801037eb:	e8 d0 22 00 00       	call   80105ac0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801037f0:	e8 bb ed ff ff       	call   801025b0 <kalloc>
801037f5:	85 c0                	test   %eax,%eax
801037f7:	89 43 08             	mov    %eax,0x8(%ebx)
801037fa:	74 5a                	je     80103856 <allocproc+0xe6>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801037fc:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103802:	b9 14 00 00 00       	mov    $0x14,%ecx
  sp -= sizeof *p->tf;
80103807:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
8010380a:	ba 3f 6e 10 80       	mov    $0x80106e3f,%edx
  sp -= sizeof *p->context;
8010380f:	05 9c 0f 00 00       	add    $0xf9c,%eax
  *(uint*)sp = (uint)trapret;
80103814:	89 50 14             	mov    %edx,0x14(%eax)
  memset(p->context, 0, sizeof *p->context);
80103817:	31 d2                	xor    %edx,%edx
  p->context = (struct context*)sp;
80103819:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
8010381c:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80103820:	89 54 24 04          	mov    %edx,0x4(%esp)
80103824:	89 04 24             	mov    %eax,(%esp)
80103827:	e8 e4 22 00 00       	call   80105b10 <memset>
  p->context->eip = (uint)forkret;
8010382c:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010382f:	c7 40 10 70 38 10 80 	movl   $0x80103870,0x10(%eax)

  return p;
}
80103836:	83 c4 14             	add    $0x14,%esp
80103839:	89 d8                	mov    %ebx,%eax
8010383b:	5b                   	pop    %ebx
8010383c:	5d                   	pop    %ebp
8010383d:	c3                   	ret    
8010383e:	66 90                	xchg   %ax,%ax
  release(&ptable.lock);
80103840:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
  return 0;
80103847:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103849:	e8 72 22 00 00       	call   80105ac0 <release>
}
8010384e:	83 c4 14             	add    $0x14,%esp
80103851:	89 d8                	mov    %ebx,%eax
80103853:	5b                   	pop    %ebx
80103854:	5d                   	pop    %ebp
80103855:	c3                   	ret    
    p->state = UNUSED;
80103856:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
8010385d:	31 db                	xor    %ebx,%ebx
8010385f:	eb d5                	jmp    80103836 <allocproc+0xc6>
80103861:	eb 0d                	jmp    80103870 <forkret>
80103863:	90                   	nop
80103864:	90                   	nop
80103865:	90                   	nop
80103866:	90                   	nop
80103867:	90                   	nop
80103868:	90                   	nop
80103869:	90                   	nop
8010386a:	90                   	nop
8010386b:	90                   	nop
8010386c:	90                   	nop
8010386d:	90                   	nop
8010386e:	90                   	nop
8010386f:	90                   	nop

80103870 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103870:	55                   	push   %ebp
80103871:	89 e5                	mov    %esp,%ebp
80103873:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103876:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010387d:	e8 3e 22 00 00       	call   80105ac0 <release>

  if (first) {
80103882:	8b 15 00 c0 10 80    	mov    0x8010c000,%edx
80103888:	85 d2                	test   %edx,%edx
8010388a:	75 04                	jne    80103890 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010388c:	c9                   	leave  
8010388d:	c3                   	ret    
8010388e:	66 90                	xchg   %ax,%ax
    first = 0;
80103890:	31 c0                	xor    %eax,%eax
    iinit(ROOTDEV);
80103892:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    first = 0;
80103899:	a3 00 c0 10 80       	mov    %eax,0x8010c000
    iinit(ROOTDEV);
8010389e:	e8 0d dc ff ff       	call   801014b0 <iinit>
    initlog(ROOTDEV);
801038a3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801038aa:	e8 41 f3 ff ff       	call   80102bf0 <initlog>
}
801038af:	c9                   	leave  
801038b0:	c3                   	ret    
801038b1:	eb 0d                	jmp    801038c0 <getAccumulator>
801038b3:	90                   	nop
801038b4:	90                   	nop
801038b5:	90                   	nop
801038b6:	90                   	nop
801038b7:	90                   	nop
801038b8:	90                   	nop
801038b9:	90                   	nop
801038ba:	90                   	nop
801038bb:	90                   	nop
801038bc:	90                   	nop
801038bd:	90                   	nop
801038be:	90                   	nop
801038bf:	90                   	nop

801038c0 <getAccumulator>:
long long getAccumulator(struct proc *p) {
801038c0:	55                   	push   %ebp
801038c1:	89 e5                	mov    %esp,%ebp
        return p->accumulator;
801038c3:	8b 45 08             	mov    0x8(%ebp),%eax
}
801038c6:	5d                   	pop    %ebp
        return p->accumulator;
801038c7:	8b 90 88 00 00 00    	mov    0x88(%eax),%edx
801038cd:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
}
801038d3:	c3                   	ret    
801038d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801038da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801038e0 <pinit>:
{
801038e0:	55                   	push   %ebp
  initlock(&ptable.lock, "ptable");
801038e1:	b8 c5 8c 10 80       	mov    $0x80108cc5,%eax
{
801038e6:	89 e5                	mov    %esp,%ebp
801038e8:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
801038eb:	89 44 24 04          	mov    %eax,0x4(%esp)
801038ef:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801038f6:	e8 d5 1f 00 00       	call   801058d0 <initlock>
}
801038fb:	c9                   	leave  
801038fc:	c3                   	ret    
801038fd:	8d 76 00             	lea    0x0(%esi),%esi

80103900 <mycpu>:
{
80103900:	55                   	push   %ebp
80103901:	89 e5                	mov    %esp,%ebp
80103903:	56                   	push   %esi
80103904:	53                   	push   %ebx
80103905:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103908:	9c                   	pushf  
80103909:	58                   	pop    %eax
  if(readeflags()&FL_IF)
8010390a:	f6 c4 02             	test   $0x2,%ah
8010390d:	75 5b                	jne    8010396a <mycpu+0x6a>
  apicid = lapicid();
8010390f:	e8 1c ef ff ff       	call   80102830 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103914:	8b 35 60 4d 11 80    	mov    0x80114d60,%esi
8010391a:	85 f6                	test   %esi,%esi
8010391c:	7e 40                	jle    8010395e <mycpu+0x5e>
    if (cpus[i].apicid == apicid)
8010391e:	0f b6 15 e0 47 11 80 	movzbl 0x801147e0,%edx
80103925:	39 d0                	cmp    %edx,%eax
80103927:	74 2e                	je     80103957 <mycpu+0x57>
80103929:	b9 90 48 11 80       	mov    $0x80114890,%ecx
  for (i = 0; i < ncpu; ++i) {
8010392e:	31 d2                	xor    %edx,%edx
80103930:	42                   	inc    %edx
80103931:	39 f2                	cmp    %esi,%edx
80103933:	74 29                	je     8010395e <mycpu+0x5e>
    if (cpus[i].apicid == apicid)
80103935:	0f b6 19             	movzbl (%ecx),%ebx
80103938:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
8010393e:	39 c3                	cmp    %eax,%ebx
80103940:	75 ee                	jne    80103930 <mycpu+0x30>
80103942:	8d 04 92             	lea    (%edx,%edx,4),%eax
80103945:	8d 04 42             	lea    (%edx,%eax,2),%eax
80103948:	c1 e0 04             	shl    $0x4,%eax
8010394b:	05 e0 47 11 80       	add    $0x801147e0,%eax
}
80103950:	83 c4 10             	add    $0x10,%esp
80103953:	5b                   	pop    %ebx
80103954:	5e                   	pop    %esi
80103955:	5d                   	pop    %ebp
80103956:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103957:	b8 e0 47 11 80       	mov    $0x801147e0,%eax
      return &cpus[i];
8010395c:	eb f2                	jmp    80103950 <mycpu+0x50>
  panic("unknown apicid\n");
8010395e:	c7 04 24 cc 8c 10 80 	movl   $0x80108ccc,(%esp)
80103965:	e8 06 ca ff ff       	call   80100370 <panic>
    panic("mycpu called with interrupts enabled\n");
8010396a:	c7 04 24 d0 8d 10 80 	movl   $0x80108dd0,(%esp)
80103971:	e8 fa c9 ff ff       	call   80100370 <panic>
80103976:	8d 76 00             	lea    0x0(%esi),%esi
80103979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103980 <cpuid>:
cpuid() {
80103980:	55                   	push   %ebp
80103981:	89 e5                	mov    %esp,%ebp
80103983:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103986:	e8 75 ff ff ff       	call   80103900 <mycpu>
}
8010398b:	c9                   	leave  
  return mycpu()-cpus;
8010398c:	2d e0 47 11 80       	sub    $0x801147e0,%eax
80103991:	c1 f8 04             	sar    $0x4,%eax
80103994:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010399a:	c3                   	ret    
8010399b:	90                   	nop
8010399c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801039a0 <myproc>:
myproc(void) {
801039a0:	55                   	push   %ebp
801039a1:	89 e5                	mov    %esp,%ebp
801039a3:	53                   	push   %ebx
801039a4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801039a7:	e8 94 1f 00 00       	call   80105940 <pushcli>
  c = mycpu();
801039ac:	e8 4f ff ff ff       	call   80103900 <mycpu>
  p = c->proc;
801039b1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039b7:	e8 c4 1f 00 00       	call   80105980 <popcli>
}
801039bc:	5a                   	pop    %edx
801039bd:	89 d8                	mov    %ebx,%eax
801039bf:	5b                   	pop    %ebx
801039c0:	5d                   	pop    %ebp
801039c1:	c3                   	ret    
801039c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801039d0 <userinit>:
{
801039d0:	55                   	push   %ebp
801039d1:	89 e5                	mov    %esp,%ebp
801039d3:	53                   	push   %ebx
801039d4:	83 ec 14             	sub    $0x14,%esp
  p = allocproc();
801039d7:	e8 94 fd ff ff       	call   80103770 <allocproc>
801039dc:	89 c3                	mov    %eax,%ebx
  initproc = p;
801039de:	a3 bc c5 10 80       	mov    %eax,0x8010c5bc
  if((p->pgdir = setupkvm()) == 0)
801039e3:	e8 88 4a 00 00       	call   80108470 <setupkvm>
801039e8:	85 c0                	test   %eax,%eax
801039ea:	89 43 04             	mov    %eax,0x4(%ebx)
801039ed:	0f 84 fd 00 00 00    	je     80103af0 <userinit+0x120>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801039f3:	b9 60 c4 10 80       	mov    $0x8010c460,%ecx
801039f8:	ba 2c 00 00 00       	mov    $0x2c,%edx
801039fd:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80103a01:	89 54 24 08          	mov    %edx,0x8(%esp)
80103a05:	89 04 24             	mov    %eax,(%esp)
80103a08:	e8 33 47 00 00       	call   80108140 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103a0d:	b8 4c 00 00 00       	mov    $0x4c,%eax
  p->sz = PGSIZE;
80103a12:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103a18:	89 44 24 08          	mov    %eax,0x8(%esp)
80103a1c:	31 c0                	xor    %eax,%eax
80103a1e:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a22:	8b 43 18             	mov    0x18(%ebx),%eax
80103a25:	89 04 24             	mov    %eax,(%esp)
80103a28:	e8 e3 20 00 00       	call   80105b10 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a2d:	8b 43 18             	mov    0x18(%ebx),%eax
80103a30:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a36:	8b 43 18             	mov    0x18(%ebx),%eax
80103a39:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103a3f:	8b 43 18             	mov    0x18(%ebx),%eax
80103a42:	8b 50 2c             	mov    0x2c(%eax),%edx
80103a45:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103a49:	8b 43 18             	mov    0x18(%ebx),%eax
80103a4c:	8b 50 2c             	mov    0x2c(%eax),%edx
80103a4f:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103a53:	8b 43 18             	mov    0x18(%ebx),%eax
80103a56:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103a5d:	8b 43 18             	mov    0x18(%ebx),%eax
80103a60:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103a67:	8b 43 18             	mov    0x18(%ebx),%eax
80103a6a:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a71:	b8 10 00 00 00       	mov    $0x10,%eax
80103a76:	89 44 24 08          	mov    %eax,0x8(%esp)
80103a7a:	b8 f5 8c 10 80       	mov    $0x80108cf5,%eax
80103a7f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a83:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103a86:	89 04 24             	mov    %eax,(%esp)
80103a89:	e8 62 22 00 00       	call   80105cf0 <safestrcpy>
  p->cwd = namei("/");
80103a8e:	c7 04 24 fe 8c 10 80 	movl   $0x80108cfe,(%esp)
80103a95:	e8 36 e5 ff ff       	call   80101fd0 <namei>
80103a9a:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103a9d:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103aa4:	e8 77 1f 00 00       	call   80105a20 <acquire>
  if(p->state == RUNNING)
80103aa9:	8b 43 0c             	mov    0xc(%ebx),%eax
80103aac:	83 f8 04             	cmp    $0x4,%eax
80103aaf:	75 09                	jne    80103aba <userinit+0xea>
      rpholder.remove(p);
80103ab1:	89 1c 24             	mov    %ebx,(%esp)
80103ab4:	ff 15 c8 c5 10 80    	call   *0x8010c5c8
  if(POLICY == 1)
80103aba:	83 3d 08 c0 10 80 01 	cmpl   $0x1,0x8010c008
  p->state = RUNNABLE;
80103ac1:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
      rrq.enqueue(p);
80103ac8:	89 1c 24             	mov    %ebx,(%esp)
  if(POLICY == 1)
80103acb:	74 1b                	je     80103ae8 <userinit+0x118>
      pq.put(p);
80103acd:	ff 15 e4 c5 10 80    	call   *0x8010c5e4
  release(&ptable.lock);
80103ad3:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103ada:	e8 e1 1f 00 00       	call   80105ac0 <release>
}
80103adf:	83 c4 14             	add    $0x14,%esp
80103ae2:	5b                   	pop    %ebx
80103ae3:	5d                   	pop    %ebp
80103ae4:	c3                   	ret    
80103ae5:	8d 76 00             	lea    0x0(%esi),%esi
      rrq.enqueue(p);
80103ae8:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
80103aee:	eb e3                	jmp    80103ad3 <userinit+0x103>
    panic("userinit: out of memory?");
80103af0:	c7 04 24 dc 8c 10 80 	movl   $0x80108cdc,(%esp)
80103af7:	e8 74 c8 ff ff       	call   80100370 <panic>
80103afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103b00 <growproc>:
{
80103b00:	55                   	push   %ebp
80103b01:	89 e5                	mov    %esp,%ebp
80103b03:	56                   	push   %esi
80103b04:	53                   	push   %ebx
80103b05:	83 ec 10             	sub    $0x10,%esp
80103b08:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103b0b:	e8 30 1e 00 00       	call   80105940 <pushcli>
  c = mycpu();
80103b10:	e8 eb fd ff ff       	call   80103900 <mycpu>
  p = c->proc;
80103b15:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b1b:	e8 60 1e 00 00       	call   80105980 <popcli>
  if(n > 0){
80103b20:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103b23:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103b25:	7f 19                	jg     80103b40 <growproc+0x40>
  } else if(n < 0){
80103b27:	75 37                	jne    80103b60 <growproc+0x60>
  curproc->sz = sz;
80103b29:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103b2b:	89 1c 24             	mov    %ebx,(%esp)
80103b2e:	e8 0d 45 00 00       	call   80108040 <switchuvm>
  return 0;
80103b33:	31 c0                	xor    %eax,%eax
}
80103b35:	83 c4 10             	add    $0x10,%esp
80103b38:	5b                   	pop    %ebx
80103b39:	5e                   	pop    %esi
80103b3a:	5d                   	pop    %ebp
80103b3b:	c3                   	ret    
80103b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b40:	01 c6                	add    %eax,%esi
80103b42:	89 74 24 08          	mov    %esi,0x8(%esp)
80103b46:	89 44 24 04          	mov    %eax,0x4(%esp)
80103b4a:	8b 43 04             	mov    0x4(%ebx),%eax
80103b4d:	89 04 24             	mov    %eax,(%esp)
80103b50:	e8 3b 47 00 00       	call   80108290 <allocuvm>
80103b55:	85 c0                	test   %eax,%eax
80103b57:	75 d0                	jne    80103b29 <growproc+0x29>
      return -1;
80103b59:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b5e:	eb d5                	jmp    80103b35 <growproc+0x35>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b60:	01 c6                	add    %eax,%esi
80103b62:	89 74 24 08          	mov    %esi,0x8(%esp)
80103b66:	89 44 24 04          	mov    %eax,0x4(%esp)
80103b6a:	8b 43 04             	mov    0x4(%ebx),%eax
80103b6d:	89 04 24             	mov    %eax,(%esp)
80103b70:	e8 4b 48 00 00       	call   801083c0 <deallocuvm>
80103b75:	85 c0                	test   %eax,%eax
80103b77:	75 b0                	jne    80103b29 <growproc+0x29>
80103b79:	eb de                	jmp    80103b59 <growproc+0x59>
80103b7b:	90                   	nop
80103b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103b80 <setAccumulator>:
void setAccumulator(struct proc *p){
80103b80:	55                   	push   %ebp
80103b81:	89 e5                	mov    %esp,%ebp
80103b83:	83 ec 28             	sub    $0x28,%esp
  if (pq.getMinAccumulator(&acc1)){
80103b86:	8d 45 e8             	lea    -0x18(%ebp),%eax
void setAccumulator(struct proc *p){
80103b89:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80103b8c:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103b8f:	89 75 fc             	mov    %esi,-0x4(%ebp)
  if (pq.getMinAccumulator(&acc1)){
80103b92:	89 04 24             	mov    %eax,(%esp)
80103b95:	ff 15 e8 c5 10 80    	call   *0x8010c5e8
80103b9b:	85 c0                	test   %eax,%eax
      if (rpholder.getMinAccumulator(&acc2))
80103b9d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80103ba0:	89 04 24             	mov    %eax,(%esp)
  if (pq.getMinAccumulator(&acc1)){
80103ba3:	74 3b                	je     80103be0 <setAccumulator+0x60>
      if (rpholder.getMinAccumulator(&acc2))
80103ba5:	ff 15 cc c5 10 80    	call   *0x8010c5cc
80103bab:	85 c0                	test   %eax,%eax
80103bad:	74 79                	je     80103c28 <setAccumulator+0xa8>
            if (acc1<acc2)
80103baf:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103bb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bb5:	8b 75 e8             	mov    -0x18(%ebp),%esi
80103bb8:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80103bbb:	39 c2                	cmp    %eax,%edx
80103bbd:	7f 0a                	jg     80103bc9 <setAccumulator+0x49>
80103bbf:	0f 8c 83 00 00 00    	jl     80103c48 <setAccumulator+0xc8>
80103bc5:	39 ce                	cmp    %ecx,%esi
80103bc7:	72 7f                	jb     80103c48 <setAccumulator+0xc8>
                   p->accumulator = acc2;
80103bc9:	89 8b 84 00 00 00    	mov    %ecx,0x84(%ebx)
80103bcf:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
}
80103bd5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103bd8:	8b 75 fc             	mov    -0x4(%ebp),%esi
80103bdb:	89 ec                	mov    %ebp,%esp
80103bdd:	5d                   	pop    %ebp
80103bde:	c3                   	ret    
80103bdf:	90                   	nop
  else if (rpholder.getMinAccumulator(&acc2)){
80103be0:	ff 15 cc c5 10 80    	call   *0x8010c5cc
80103be6:	85 c0                	test   %eax,%eax
80103be8:	75 1e                	jne    80103c08 <setAccumulator+0x88>
       p->accumulator = 0;
80103bea:	31 c0                	xor    %eax,%eax
80103bec:	31 d2                	xor    %edx,%edx
80103bee:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)
80103bf4:	89 93 88 00 00 00    	mov    %edx,0x88(%ebx)
}
80103bfa:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103bfd:	8b 75 fc             	mov    -0x4(%ebp),%esi
80103c00:	89 ec                	mov    %ebp,%esp
80103c02:	5d                   	pop    %ebp
80103c03:	c3                   	ret    
80103c04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->accumulator = acc2;
80103c08:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c0b:	8b 55 f4             	mov    -0xc(%ebp),%edx
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
80103c28:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103c2b:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103c2e:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)
80103c34:	89 93 88 00 00 00    	mov    %edx,0x88(%ebx)
}
80103c3a:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103c3d:	8b 75 fc             	mov    -0x4(%ebp),%esi
80103c40:	89 ec                	mov    %ebp,%esp
80103c42:	5d                   	pop    %ebp
80103c43:	c3                   	ret    
80103c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                   p->accumulator = acc1;
80103c48:	89 b3 84 00 00 00    	mov    %esi,0x84(%ebx)
80103c4e:	89 93 88 00 00 00    	mov    %edx,0x88(%ebx)
}
80103c54:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103c57:	8b 75 fc             	mov    -0x4(%ebp),%esi
80103c5a:	89 ec                	mov    %ebp,%esp
80103c5c:	5d                   	pop    %ebp
80103c5d:	c3                   	ret    
80103c5e:	66 90                	xchg   %ax,%ax

80103c60 <fork>:
{
80103c60:	55                   	push   %ebp
80103c61:	89 e5                	mov    %esp,%ebp
80103c63:	57                   	push   %edi
80103c64:	56                   	push   %esi
80103c65:	53                   	push   %ebx
80103c66:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103c69:	e8 d2 1c 00 00       	call   80105940 <pushcli>
  c = mycpu();
80103c6e:	e8 8d fc ff ff       	call   80103900 <mycpu>
  p = c->proc;
80103c73:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103c79:	e8 02 1d 00 00       	call   80105980 <popcli>
  if((np = allocproc()) == 0){
80103c7e:	e8 ed fa ff ff       	call   80103770 <allocproc>
80103c83:	85 c0                	test   %eax,%eax
80103c85:	0f 84 2d 01 00 00    	je     80103db8 <fork+0x158>
80103c8b:	89 c7                	mov    %eax,%edi
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103c8d:	8b 06                	mov    (%esi),%eax
80103c8f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103c93:	8b 46 04             	mov    0x4(%esi),%eax
80103c96:	89 04 24             	mov    %eax,(%esp)
80103c99:	e8 a2 48 00 00       	call   80108540 <copyuvm>
80103c9e:	85 c0                	test   %eax,%eax
80103ca0:	89 47 04             	mov    %eax,0x4(%edi)
80103ca3:	0f 84 19 01 00 00    	je     80103dc2 <fork+0x162>
  np->sz = curproc->sz;
80103ca9:	8b 06                	mov    (%esi),%eax
  np->parent = curproc;
80103cab:	89 77 14             	mov    %esi,0x14(%edi)
  *np->tf = *curproc->tf;
80103cae:	8b 57 18             	mov    0x18(%edi),%edx
  np->sz = curproc->sz;
80103cb1:	89 07                	mov    %eax,(%edi)
  *np->tf = *curproc->tf;
80103cb3:	31 c0                	xor    %eax,%eax
80103cb5:	8b 4e 18             	mov    0x18(%esi),%ecx
80103cb8:	8b 1c 01             	mov    (%ecx,%eax,1),%ebx
80103cbb:	89 1c 02             	mov    %ebx,(%edx,%eax,1)
80103cbe:	83 c0 04             	add    $0x4,%eax
80103cc1:	83 f8 4c             	cmp    $0x4c,%eax
80103cc4:	72 f2                	jb     80103cb8 <fork+0x58>
  np->tf->eax = 0;
80103cc6:	8b 47 18             	mov    0x18(%edi),%eax
  for(i = 0; i < NOFILE; i++)
80103cc9:	31 db                	xor    %ebx,%ebx
  np->tf->eax = 0;
80103ccb:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103cd2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(curproc->ofile[i])
80103ce0:	8b 44 9e 28          	mov    0x28(%esi,%ebx,4),%eax
80103ce4:	85 c0                	test   %eax,%eax
80103ce6:	74 0c                	je     80103cf4 <fork+0x94>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103ce8:	89 04 24             	mov    %eax,(%esp)
80103ceb:	e8 f0 d0 ff ff       	call   80100de0 <filedup>
80103cf0:	89 44 9f 28          	mov    %eax,0x28(%edi,%ebx,4)
  for(i = 0; i < NOFILE; i++)
80103cf4:	43                   	inc    %ebx
80103cf5:	83 fb 10             	cmp    $0x10,%ebx
80103cf8:	75 e6                	jne    80103ce0 <fork+0x80>
  np->cwd = idup(curproc->cwd);
80103cfa:	8b 46 68             	mov    0x68(%esi),%eax
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103cfd:	83 c6 6c             	add    $0x6c,%esi
  np->cwd = idup(curproc->cwd);
80103d00:	89 04 24             	mov    %eax,(%esp)
80103d03:	e8 b8 d9 ff ff       	call   801016c0 <idup>
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d08:	ba 10 00 00 00       	mov    $0x10,%edx
  np->cwd = idup(curproc->cwd);
80103d0d:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d10:	8d 47 6c             	lea    0x6c(%edi),%eax
80103d13:	89 54 24 08          	mov    %edx,0x8(%esp)
80103d17:	89 74 24 04          	mov    %esi,0x4(%esp)
80103d1b:	89 04 24             	mov    %eax,(%esp)
80103d1e:	e8 cd 1f 00 00       	call   80105cf0 <safestrcpy>
  pid = np->pid;
80103d23:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&tickslock);
80103d26:	c7 04 24 c0 79 11 80 	movl   $0x801179c0,(%esp)
80103d2d:	e8 ee 1c 00 00       	call   80105a20 <acquire>
  np->performance.ctime = ticks;
80103d32:	a1 00 82 11 80       	mov    0x80118200,%eax
80103d37:	89 87 90 00 00 00    	mov    %eax,0x90(%edi)
  release(&tickslock);
80103d3d:	c7 04 24 c0 79 11 80 	movl   $0x801179c0,(%esp)
80103d44:	e8 77 1d 00 00       	call   80105ac0 <release>
  acquire(&ptable.lock);
80103d49:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103d50:	e8 cb 1c 00 00       	call   80105a20 <acquire>
  if(np->state == RUNNING)
80103d55:	8b 47 0c             	mov    0xc(%edi),%eax
80103d58:	83 f8 04             	cmp    $0x4,%eax
80103d5b:	75 09                	jne    80103d66 <fork+0x106>
      rpholder.remove(np);
80103d5d:	89 3c 24             	mov    %edi,(%esp)
80103d60:	ff 15 c8 c5 10 80    	call   *0x8010c5c8
  if(POLICY == 1)
80103d66:	83 3d 08 c0 10 80 01 	cmpl   $0x1,0x8010c008
  np->state = RUNNABLE;
80103d6d:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
      rrq.enqueue(np);
80103d74:	89 3c 24             	mov    %edi,(%esp)
  if(POLICY == 1)
80103d77:	74 37                	je     80103db0 <fork+0x150>
      pq.put(np);
80103d79:	ff 15 e4 c5 10 80    	call   *0x8010c5e4
  np->priority = 5; // Set the priority of new process to 5
80103d7f:	b8 05 00 00 00       	mov    $0x5,%eax
80103d84:	89 87 80 00 00 00    	mov    %eax,0x80(%edi)
  setAccumulator(np);
80103d8a:	89 3c 24             	mov    %edi,(%esp)
80103d8d:	e8 ee fd ff ff       	call   80103b80 <setAccumulator>
  release(&ptable.lock);
80103d92:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103d99:	e8 22 1d 00 00       	call   80105ac0 <release>
}
80103d9e:	83 c4 1c             	add    $0x1c,%esp
80103da1:	89 d8                	mov    %ebx,%eax
80103da3:	5b                   	pop    %ebx
80103da4:	5e                   	pop    %esi
80103da5:	5f                   	pop    %edi
80103da6:	5d                   	pop    %ebp
80103da7:	c3                   	ret    
80103da8:	90                   	nop
80103da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      rrq.enqueue(np);
80103db0:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
80103db6:	eb c7                	jmp    80103d7f <fork+0x11f>
    return -1;
80103db8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103dbd:	8d 76 00             	lea    0x0(%esi),%esi
80103dc0:	eb dc                	jmp    80103d9e <fork+0x13e>
    kfree(np->kstack);
80103dc2:	8b 47 08             	mov    0x8(%edi),%eax
    return -1;
80103dc5:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    kfree(np->kstack);
80103dca:	89 04 24             	mov    %eax,(%esp)
80103dcd:	e8 0e e6 ff ff       	call   801023e0 <kfree>
    np->kstack = 0;
80103dd2:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103dd9:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103de0:	eb bc                	jmp    80103d9e <fork+0x13e>
80103de2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103df0 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80103df0:	55                   	push   %ebp
80103df1:	89 e5                	mov    %esp,%ebp
80103df3:	56                   	push   %esi
80103df4:	89 c6                	mov    %eax,%esi
80103df6:	53                   	push   %ebx
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103df7:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
{
80103dfc:	83 ec 10             	sub    $0x10,%esp
80103dff:	eb 15                	jmp    80103e16 <wakeup1+0x26>
80103e01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e08:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103e0e:	81 fb b4 79 11 80    	cmp    $0x801179b4,%ebx
80103e14:	73 3c                	jae    80103e52 <wakeup1+0x62>
    if(p->state == SLEEPING && p->chan == chan){ 
80103e16:	8b 43 0c             	mov    0xc(%ebx),%eax
80103e19:	83 f8 02             	cmp    $0x2,%eax
80103e1c:	75 ea                	jne    80103e08 <wakeup1+0x18>
80103e1e:	39 73 20             	cmp    %esi,0x20(%ebx)
80103e21:	75 e5                	jne    80103e08 <wakeup1+0x18>
      p->state = RUNNABLE;
      //acquire(&tickslock);
      //p->performance.stime += ticks - p->performanceUtil.startSt; 
      //p->performanceUtil.startRe = ticks;
      //release(&tickslock);
      setAccumulator(p);  
80103e23:	89 1c 24             	mov    %ebx,(%esp)
      p->state = RUNNABLE;
80103e26:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
      setAccumulator(p);  
80103e2d:	e8 4e fd ff ff       	call   80103b80 <setAccumulator>
      if(POLICY == 1)
80103e32:	83 3d 08 c0 10 80 01 	cmpl   $0x1,0x8010c008
        rrq.enqueue(p);
80103e39:	89 1c 24             	mov    %ebx,(%esp)
      if(POLICY == 1)
80103e3c:	74 22                	je     80103e60 <wakeup1+0x70>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e3e:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
      else
        pq.put(p);
80103e44:	ff 15 e4 c5 10 80    	call   *0x8010c5e4
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e4a:	81 fb b4 79 11 80    	cmp    $0x801179b4,%ebx
80103e50:	72 c4                	jb     80103e16 <wakeup1+0x26>
    }
}
80103e52:	83 c4 10             	add    $0x10,%esp
80103e55:	5b                   	pop    %ebx
80103e56:	5e                   	pop    %esi
80103e57:	5d                   	pop    %ebp
80103e58:	c3                   	ret    
80103e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        rrq.enqueue(p);
80103e60:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
80103e66:	eb a0                	jmp    80103e08 <wakeup1+0x18>
80103e68:	90                   	nop
80103e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103e70 <originalScheduler>:
{
80103e70:	55                   	push   %ebp
80103e71:	89 e5                	mov    %esp,%ebp
80103e73:	57                   	push   %edi
80103e74:	56                   	push   %esi
80103e75:	53                   	push   %ebx
80103e76:	83 ec 1c             	sub    $0x1c,%esp
80103e79:	8b 7d 0c             	mov    0xc(%ebp),%edi
  asm volatile("sti");
80103e7c:	fb                   	sti    
    acquire(&ptable.lock);
80103e7d:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e84:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
    acquire(&ptable.lock);
80103e89:	e8 92 1b 00 00       	call   80105a20 <acquire>
      swtch(&(c->scheduler), p->context);
80103e8e:	8d 77 04             	lea    0x4(%edi),%esi
80103e91:	eb 0d                	jmp    80103ea0 <originalScheduler+0x30>
80103e93:	90                   	nop
80103e94:	90                   	nop
80103e95:	90                   	nop
80103e96:	90                   	nop
80103e97:	90                   	nop
80103e98:	90                   	nop
80103e99:	90                   	nop
80103e9a:	90                   	nop
80103e9b:	90                   	nop
80103e9c:	90                   	nop
80103e9d:	90                   	nop
80103e9e:	90                   	nop
80103e9f:	90                   	nop
      if(p->state != RUNNABLE)
80103ea0:	8b 43 0c             	mov    0xc(%ebx),%eax
80103ea3:	83 f8 03             	cmp    $0x3,%eax
80103ea6:	75 31                	jne    80103ed9 <originalScheduler+0x69>
      c->proc = p;
80103ea8:	89 9f ac 00 00 00    	mov    %ebx,0xac(%edi)
      switchuvm(p);
80103eae:	89 1c 24             	mov    %ebx,(%esp)
80103eb1:	e8 8a 41 00 00       	call   80108040 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103eb6:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103eb9:	89 34 24             	mov    %esi,(%esp)
      p->state = RUNNING;
80103ebc:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103ec3:	89 44 24 04          	mov    %eax,0x4(%esp)
80103ec7:	e8 7d 1e 00 00       	call   80105d49 <swtch>
      switchkvm();
80103ecc:	e8 4f 41 00 00       	call   80108020 <switchkvm>
      c->proc = 0;
80103ed1:	31 c0                	xor    %eax,%eax
80103ed3:	89 87 ac 00 00 00    	mov    %eax,0xac(%edi)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ed9:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103edf:	81 fb b4 79 11 80    	cmp    $0x801179b4,%ebx
80103ee5:	72 b9                	jb     80103ea0 <originalScheduler+0x30>
    release(&ptable.lock);
80103ee7:	c7 45 08 80 4d 11 80 	movl   $0x80114d80,0x8(%ebp)
}
80103eee:	83 c4 1c             	add    $0x1c,%esp
80103ef1:	5b                   	pop    %ebx
80103ef2:	5e                   	pop    %esi
80103ef3:	5f                   	pop    %edi
80103ef4:	5d                   	pop    %ebp
    release(&ptable.lock);
80103ef5:	e9 c6 1b 00 00       	jmp    80105ac0 <release>
80103efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103f00 <roundRobinScheduler>:
{
80103f00:	55                   	push   %ebp
80103f01:	89 e5                	mov    %esp,%ebp
80103f03:	56                   	push   %esi
80103f04:	53                   	push   %ebx
80103f05:	83 ec 10             	sub    $0x10,%esp
80103f08:	8b 75 0c             	mov    0xc(%ebp),%esi
80103f0b:	fb                   	sti    
    acquire(&ptable.lock);
80103f0c:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103f13:	e8 08 1b 00 00       	call   80105a20 <acquire>
    if(!rrq.isEmpty()){
80103f18:	ff 15 d0 c5 10 80    	call   *0x8010c5d0
80103f1e:	85 c0                	test   %eax,%eax
80103f20:	75 45                	jne    80103f67 <roundRobinScheduler+0x67>
        p = rrq.dequeue();
80103f22:	ff 15 d8 c5 10 80    	call   *0x8010c5d8
80103f28:	89 c3                	mov    %eax,%ebx
        c->proc = p;
80103f2a:	89 86 ac 00 00 00    	mov    %eax,0xac(%esi)
        switchuvm(p);
80103f30:	89 04 24             	mov    %eax,(%esp)
80103f33:	e8 08 41 00 00       	call   80108040 <switchuvm>
        p->state = RUNNING;
80103f38:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
        rpholder.add(p);
80103f3f:	89 1c 24             	mov    %ebx,(%esp)
80103f42:	ff 15 c4 c5 10 80    	call   *0x8010c5c4
        swtch(&(c->scheduler), p->context);
80103f48:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103f4b:	89 44 24 04          	mov    %eax,0x4(%esp)
80103f4f:	8d 46 04             	lea    0x4(%esi),%eax
80103f52:	89 04 24             	mov    %eax,(%esp)
80103f55:	e8 ef 1d 00 00       	call   80105d49 <swtch>
        switchkvm();
80103f5a:	e8 c1 40 00 00       	call   80108020 <switchkvm>
        c->proc = 0;
80103f5f:	31 c0                	xor    %eax,%eax
80103f61:	89 86 ac 00 00 00    	mov    %eax,0xac(%esi)
    release(&ptable.lock);
80103f67:	c7 45 08 80 4d 11 80 	movl   $0x80114d80,0x8(%ebp)
}
80103f6e:	83 c4 10             	add    $0x10,%esp
80103f71:	5b                   	pop    %ebx
80103f72:	5e                   	pop    %esi
80103f73:	5d                   	pop    %ebp
    release(&ptable.lock);
80103f74:	e9 47 1b 00 00       	jmp    80105ac0 <release>
80103f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103f80 <priorityScheduler>:
{
80103f80:	55                   	push   %ebp
80103f81:	89 e5                	mov    %esp,%ebp
80103f83:	56                   	push   %esi
80103f84:	53                   	push   %ebx
80103f85:	83 ec 10             	sub    $0x10,%esp
80103f88:	8b 75 0c             	mov    0xc(%ebp),%esi
80103f8b:	fb                   	sti    
    acquire(&ptable.lock);
80103f8c:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103f93:	e8 88 1a 00 00       	call   80105a20 <acquire>
    if(!pq.isEmpty()){
80103f98:	ff 15 e0 c5 10 80    	call   *0x8010c5e0
80103f9e:	85 c0                	test   %eax,%eax
80103fa0:	75 45                	jne    80103fe7 <priorityScheduler+0x67>
        p = pq.extractMin();
80103fa2:	ff 15 ec c5 10 80    	call   *0x8010c5ec
80103fa8:	89 c3                	mov    %eax,%ebx
        c->proc = p;
80103faa:	89 86 ac 00 00 00    	mov    %eax,0xac(%esi)
        switchuvm(p);
80103fb0:	89 04 24             	mov    %eax,(%esp)
80103fb3:	e8 88 40 00 00       	call   80108040 <switchuvm>
        p->state = RUNNING; 
80103fb8:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
        rpholder.add(p);
80103fbf:	89 1c 24             	mov    %ebx,(%esp)
80103fc2:	ff 15 c4 c5 10 80    	call   *0x8010c5c4
        swtch(&(c->scheduler), p->context);
80103fc8:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103fcb:	89 44 24 04          	mov    %eax,0x4(%esp)
80103fcf:	8d 46 04             	lea    0x4(%esi),%eax
80103fd2:	89 04 24             	mov    %eax,(%esp)
80103fd5:	e8 6f 1d 00 00       	call   80105d49 <swtch>
        switchkvm();
80103fda:	e8 41 40 00 00       	call   80108020 <switchkvm>
        c->proc = 0;
80103fdf:	31 c0                	xor    %eax,%eax
80103fe1:	89 86 ac 00 00 00    	mov    %eax,0xac(%esi)
    release(&ptable.lock);
80103fe7:	c7 45 08 80 4d 11 80 	movl   $0x80114d80,0x8(%ebp)
}
80103fee:	83 c4 10             	add    $0x10,%esp
80103ff1:	5b                   	pop    %ebx
80103ff2:	5e                   	pop    %esi
80103ff3:	5d                   	pop    %ebp
    release(&ptable.lock);
80103ff4:	e9 c7 1a 00 00       	jmp    80105ac0 <release>
80103ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104000 <extendedPriorityScheduler>:
{
80104000:	55                   	push   %ebp
80104001:	89 e5                	mov    %esp,%ebp
80104003:	56                   	push   %esi
80104004:	53                   	push   %ebx
80104005:	83 ec 20             	sub    $0x20,%esp
80104008:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010400b:	8b 75 0c             	mov    0xc(%ebp),%esi
8010400e:	fb                   	sti    
    acquire(&ptable.lock);
8010400f:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104016:	e8 05 1a 00 00       	call   80105a20 <acquire>
    if(!pq.isEmpty()){
8010401b:	ff 15 e0 c5 10 80    	call   *0x8010c5e0
80104021:	85 c0                	test   %eax,%eax
80104023:	0f 85 8d 00 00 00    	jne    801040b6 <extendedPriorityScheduler+0xb6>
            if (tqCounter - p->timeStamp > max)
80104029:	8b 15 b8 c5 10 80    	mov    0x8010c5b8,%edx
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){  // Run over all the ptable and look for the process which didn't work for the lonest time.
8010402f:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
80104034:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010403a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
            if (tqCounter - p->timeStamp > max)
80104040:	89 d1                	mov    %edx,%ecx
80104042:	2b 88 8c 00 00 00    	sub    0x8c(%eax),%ecx
80104048:	89 4d f4             	mov    %ecx,-0xc(%ebp)
8010404b:	db 45 f4             	fildl  -0xc(%ebp)
8010404e:	d9 ee                	fldz   
80104050:	d9 c9                	fxch   %st(1)
80104052:	df e9                	fucomip %st(1),%st
80104054:	dd d8                	fstp   %st(0)
80104056:	0f 47 d8             	cmova  %eax,%ebx
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){  // Run over all the ptable and look for the process which didn't work for the lonest time.
80104059:	05 b0 00 00 00       	add    $0xb0,%eax
8010405e:	3d b4 79 11 80       	cmp    $0x801179b4,%eax
80104063:	72 db                	jb     80104040 <extendedPriorityScheduler+0x40>
        if(!pq.extractProc(np))
80104065:	89 1c 24             	mov    %ebx,(%esp)
80104068:	ff 15 f4 c5 10 80    	call   *0x8010c5f4
8010406e:	85 c0                	test   %eax,%eax
80104070:	75 07                	jne    80104079 <extendedPriorityScheduler+0x79>
}
80104072:	83 c4 20             	add    $0x20,%esp
80104075:	5b                   	pop    %ebx
80104076:	5e                   	pop    %esi
80104077:	5d                   	pop    %ebp
80104078:	c3                   	ret    
        c->proc = np;
80104079:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
        switchuvm(np);
8010407f:	89 1c 24             	mov    %ebx,(%esp)
80104082:	e8 b9 3f 00 00       	call   80108040 <switchuvm>
        np->state = RUNNING;
80104087:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
        rpholder.add(np);
8010408e:	89 1c 24             	mov    %ebx,(%esp)
80104091:	ff 15 c4 c5 10 80    	call   *0x8010c5c4
        swtch(&(c->scheduler), np->context);
80104097:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010409a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010409e:	8d 46 04             	lea    0x4(%esi),%eax
801040a1:	89 04 24             	mov    %eax,(%esp)
801040a4:	e8 a0 1c 00 00       	call   80105d49 <swtch>
        switchkvm();
801040a9:	e8 72 3f 00 00       	call   80108020 <switchkvm>
        c->proc = 0;
801040ae:	31 c0                	xor    %eax,%eax
801040b0:	89 86 ac 00 00 00    	mov    %eax,0xac(%esi)
    release(&ptable.lock);
801040b6:	c7 45 08 80 4d 11 80 	movl   $0x80114d80,0x8(%ebp)
}
801040bd:	83 c4 20             	add    $0x20,%esp
801040c0:	5b                   	pop    %ebx
801040c1:	5e                   	pop    %esi
801040c2:	5d                   	pop    %ebp
    release(&ptable.lock);
801040c3:	e9 f8 19 00 00       	jmp    80105ac0 <release>
801040c8:	90                   	nop
801040c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801040d0 <scheduler>:
{
801040d0:	55                   	push   %ebp
801040d1:	89 e5                	mov    %esp,%ebp
801040d3:	53                   	push   %ebx
801040d4:	83 ec 14             	sub    $0x14,%esp
  struct cpu *c = mycpu();
801040d7:	e8 24 f8 ff ff       	call   80103900 <mycpu>
801040dc:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
801040de:	31 c0                	xor    %eax,%eax
801040e0:	89 83 ac 00 00 00    	mov    %eax,0xac(%ebx)
801040e6:	8d 76 00             	lea    0x0(%esi),%esi
801040e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    switch(POLICY){
801040f0:	a1 08 c0 10 80       	mov    0x8010c008,%eax
            priorityScheduler(p, c);
801040f5:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801040f9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    switch(POLICY){
80104100:	83 f8 02             	cmp    $0x2,%eax
80104103:	74 1b                	je     80104120 <scheduler+0x50>
80104105:	83 f8 03             	cmp    $0x3,%eax
80104108:	74 36                	je     80104140 <scheduler+0x70>
8010410a:	48                   	dec    %eax
8010410b:	74 23                	je     80104130 <scheduler+0x60>
8010410d:	8d 76 00             	lea    0x0(%esi),%esi
            originalScheduler(p, c);
80104110:	e8 5b fd ff ff       	call   80103e70 <originalScheduler>
            break;
80104115:	eb d9                	jmp    801040f0 <scheduler+0x20>
80104117:	89 f6                	mov    %esi,%esi
80104119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            priorityScheduler(p, c);
80104120:	e8 5b fe ff ff       	call   80103f80 <priorityScheduler>
            break;
80104125:	eb c9                	jmp    801040f0 <scheduler+0x20>
80104127:	89 f6                	mov    %esi,%esi
80104129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            roundRobinScheduler(p, c);
80104130:	e8 cb fd ff ff       	call   80103f00 <roundRobinScheduler>
            break;
80104135:	eb b9                	jmp    801040f0 <scheduler+0x20>
80104137:	89 f6                	mov    %esi,%esi
80104139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            extendedPriorityScheduler(p, c);
80104140:	e8 bb fe ff ff       	call   80104000 <extendedPriorityScheduler>
            break;
80104145:	eb a9                	jmp    801040f0 <scheduler+0x20>
80104147:	89 f6                	mov    %esi,%esi
80104149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104150 <sched>:
{
80104150:	55                   	push   %ebp
80104151:	89 e5                	mov    %esp,%ebp
80104153:	56                   	push   %esi
80104154:	53                   	push   %ebx
80104155:	83 ec 10             	sub    $0x10,%esp
  pushcli();
80104158:	e8 e3 17 00 00       	call   80105940 <pushcli>
  c = mycpu();
8010415d:	e8 9e f7 ff ff       	call   80103900 <mycpu>
  p = c->proc;
80104162:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104168:	e8 13 18 00 00       	call   80105980 <popcli>
  if(!holding(&ptable.lock))
8010416d:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104174:	e8 67 18 00 00       	call   801059e0 <holding>
80104179:	85 c0                	test   %eax,%eax
8010417b:	74 51                	je     801041ce <sched+0x7e>
  if(mycpu()->ncli != 1)
8010417d:	e8 7e f7 ff ff       	call   80103900 <mycpu>
80104182:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80104189:	75 67                	jne    801041f2 <sched+0xa2>
  if(p->state == RUNNING)
8010418b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010418e:	83 f8 04             	cmp    $0x4,%eax
80104191:	74 53                	je     801041e6 <sched+0x96>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104193:	9c                   	pushf  
80104194:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104195:	f6 c4 02             	test   $0x2,%ah
80104198:	75 40                	jne    801041da <sched+0x8a>
  intena = mycpu()->intena;
8010419a:	e8 61 f7 ff ff       	call   80103900 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
8010419f:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
801041a2:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
801041a8:	e8 53 f7 ff ff       	call   80103900 <mycpu>
801041ad:	8b 40 04             	mov    0x4(%eax),%eax
801041b0:	89 1c 24             	mov    %ebx,(%esp)
801041b3:	89 44 24 04          	mov    %eax,0x4(%esp)
801041b7:	e8 8d 1b 00 00       	call   80105d49 <swtch>
  mycpu()->intena = intena;
801041bc:	e8 3f f7 ff ff       	call   80103900 <mycpu>
801041c1:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
801041c7:	83 c4 10             	add    $0x10,%esp
801041ca:	5b                   	pop    %ebx
801041cb:	5e                   	pop    %esi
801041cc:	5d                   	pop    %ebp
801041cd:	c3                   	ret    
    panic("sched ptable.lock");
801041ce:	c7 04 24 00 8d 10 80 	movl   $0x80108d00,(%esp)
801041d5:	e8 96 c1 ff ff       	call   80100370 <panic>
    panic("sched interruptible");
801041da:	c7 04 24 2c 8d 10 80 	movl   $0x80108d2c,(%esp)
801041e1:	e8 8a c1 ff ff       	call   80100370 <panic>
    panic("sched running");
801041e6:	c7 04 24 1e 8d 10 80 	movl   $0x80108d1e,(%esp)
801041ed:	e8 7e c1 ff ff       	call   80100370 <panic>
    panic("sched locks");
801041f2:	c7 04 24 12 8d 10 80 	movl   $0x80108d12,(%esp)
801041f9:	e8 72 c1 ff ff       	call   80100370 <panic>
801041fe:	66 90                	xchg   %ax,%ax

80104200 <exit>:
{
80104200:	55                   	push   %ebp
80104201:	89 e5                	mov    %esp,%ebp
80104203:	57                   	push   %edi
80104204:	56                   	push   %esi
80104205:	53                   	push   %ebx
80104206:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104209:	e8 32 17 00 00       	call   80105940 <pushcli>
  c = mycpu();
8010420e:	e8 ed f6 ff ff       	call   80103900 <mycpu>
  p = c->proc;
80104213:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104219:	e8 62 17 00 00       	call   80105980 <popcli>
  if(curproc == initproc)
8010421e:	39 35 bc c5 10 80    	cmp    %esi,0x8010c5bc
80104224:	0f 84 b4 00 00 00    	je     801042de <exit+0xde>
8010422a:	8d 5e 28             	lea    0x28(%esi),%ebx
8010422d:	8d 7e 68             	lea    0x68(%esi),%edi
    if(curproc->ofile[fd]){
80104230:	8b 03                	mov    (%ebx),%eax
80104232:	85 c0                	test   %eax,%eax
80104234:	74 0e                	je     80104244 <exit+0x44>
      fileclose(curproc->ofile[fd]);
80104236:	89 04 24             	mov    %eax,(%esp)
80104239:	e8 f2 cb ff ff       	call   80100e30 <fileclose>
      curproc->ofile[fd] = 0;
8010423e:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104244:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80104247:	39 df                	cmp    %ebx,%edi
80104249:	75 e5                	jne    80104230 <exit+0x30>
  begin_op();
8010424b:	e8 40 ea ff ff       	call   80102c90 <begin_op>
  iput(curproc->cwd);
80104250:	8b 46 68             	mov    0x68(%esi),%eax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104253:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
  iput(curproc->cwd);
80104258:	89 04 24             	mov    %eax,(%esp)
8010425b:	e8 c0 d5 ff ff       	call   80101820 <iput>
  end_op();
80104260:	e8 9b ea ff ff       	call   80102d00 <end_op>
  curproc->cwd = 0;
80104265:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
8010426c:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104273:	e8 a8 17 00 00       	call   80105a20 <acquire>
  wakeup1(curproc->parent);
80104278:	8b 46 14             	mov    0x14(%esi),%eax
8010427b:	e8 70 fb ff ff       	call   80103df0 <wakeup1>
80104280:	eb 14                	jmp    80104296 <exit+0x96>
80104282:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104288:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010428e:	81 fb b4 79 11 80    	cmp    $0x801179b4,%ebx
80104294:	73 2a                	jae    801042c0 <exit+0xc0>
    if(p->parent == curproc){
80104296:	39 73 14             	cmp    %esi,0x14(%ebx)
80104299:	75 ed                	jne    80104288 <exit+0x88>
      if(p->state == ZOMBIE)
8010429b:	8b 53 0c             	mov    0xc(%ebx),%edx
      p->parent = initproc;
8010429e:	a1 bc c5 10 80       	mov    0x8010c5bc,%eax
      if(p->state == ZOMBIE)
801042a3:	83 fa 05             	cmp    $0x5,%edx
      p->parent = initproc;
801042a6:	89 43 14             	mov    %eax,0x14(%ebx)
      if(p->state == ZOMBIE)
801042a9:	75 dd                	jne    80104288 <exit+0x88>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042ab:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
        wakeup1(initproc);
801042b1:	e8 3a fb ff ff       	call   80103df0 <wakeup1>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042b6:	81 fb b4 79 11 80    	cmp    $0x801179b4,%ebx
801042bc:	72 d8                	jb     80104296 <exit+0x96>
801042be:	66 90                	xchg   %ax,%ax
  curproc->exitStatus = status;
801042c0:	8b 45 08             	mov    0x8(%ebp),%eax
  curproc->state = ZOMBIE;
801042c3:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  curproc->exitStatus = status;
801042ca:	89 46 7c             	mov    %eax,0x7c(%esi)
  sched();
801042cd:	e8 7e fe ff ff       	call   80104150 <sched>
  panic("zombie exit");
801042d2:	c7 04 24 4d 8d 10 80 	movl   $0x80108d4d,(%esp)
801042d9:	e8 92 c0 ff ff       	call   80100370 <panic>
    panic("init exiting");
801042de:	c7 04 24 40 8d 10 80 	movl   $0x80108d40,(%esp)
801042e5:	e8 86 c0 ff ff       	call   80100370 <panic>
801042ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801042f0 <yield>:
{
801042f0:	55                   	push   %ebp
801042f1:	89 e5                	mov    %esp,%ebp
801042f3:	53                   	push   %ebx
801042f4:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801042f7:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801042fe:	e8 1d 17 00 00       	call   80105a20 <acquire>
  pushcli();
80104303:	e8 38 16 00 00       	call   80105940 <pushcli>
  c = mycpu();
80104308:	e8 f3 f5 ff ff       	call   80103900 <mycpu>
  p = c->proc;
8010430d:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104313:	e8 68 16 00 00       	call   80105980 <popcli>
  if(p->state == RUNNING)
80104318:	8b 43 0c             	mov    0xc(%ebx),%eax
8010431b:	83 f8 04             	cmp    $0x4,%eax
8010431e:	75 09                	jne    80104329 <yield+0x39>
      rpholder.remove(p);
80104320:	89 1c 24             	mov    %ebx,(%esp)
80104323:	ff 15 c8 c5 10 80    	call   *0x8010c5c8
  tqCounter += 1;
80104329:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
  p->state = RUNNABLE;
8010432e:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  tqCounter += 1;
80104335:	40                   	inc    %eax
80104336:	a3 b8 c5 10 80       	mov    %eax,0x8010c5b8
  p->timeStamp = tqCounter;
8010433b:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
  if(POLICY == 1){
80104341:	a1 08 c0 10 80       	mov    0x8010c008,%eax
80104346:	83 f8 01             	cmp    $0x1,%eax
80104349:	75 2d                	jne    80104378 <yield+0x88>
      rpholder.remove(p);
8010434b:	89 1c 24             	mov    %ebx,(%esp)
8010434e:	ff 15 c8 c5 10 80    	call   *0x8010c5c8
      rrq.enqueue(p);
80104354:	89 1c 24             	mov    %ebx,(%esp)
80104357:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
  sched();
8010435d:	e8 ee fd ff ff       	call   80104150 <sched>
  release(&ptable.lock);
80104362:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104369:	e8 52 17 00 00       	call   80105ac0 <release>
}
8010436e:	83 c4 14             	add    $0x14,%esp
80104371:	5b                   	pop    %ebx
80104372:	5d                   	pop    %ebp
80104373:	c3                   	ret    
80104374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if (POLICY == 2){
80104378:	83 f8 02             	cmp    $0x2,%eax
8010437b:	75 e0                	jne    8010435d <yield+0x6d>
      pq.put(p);
8010437d:	89 1c 24             	mov    %ebx,(%esp)
80104380:	ff 15 e4 c5 10 80    	call   *0x8010c5e4
      rpholder.remove(p);
80104386:	89 1c 24             	mov    %ebx,(%esp)
80104389:	ff 15 c8 c5 10 80    	call   *0x8010c5c8
      p->accumulator += p->priority;
8010438f:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
80104395:	99                   	cltd   
80104396:	01 83 84 00 00 00    	add    %eax,0x84(%ebx)
8010439c:	11 93 88 00 00 00    	adc    %edx,0x88(%ebx)
      if (POLICY == 3 && (tqCounter % 100 == 0)){
801043a2:	83 3d 08 c0 10 80 03 	cmpl   $0x3,0x8010c008
801043a9:	75 b2                	jne    8010435d <yield+0x6d>
801043ab:	8b 0d b8 c5 10 80    	mov    0x8010c5b8,%ecx
801043b1:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
801043b6:	f7 e9                	imul   %ecx
801043b8:	89 d0                	mov    %edx,%eax
801043ba:	89 ca                	mov    %ecx,%edx
801043bc:	c1 f8 05             	sar    $0x5,%eax
801043bf:	c1 fa 1f             	sar    $0x1f,%edx
801043c2:	29 d0                	sub    %edx,%eax
801043c4:	8d 04 80             	lea    (%eax,%eax,4),%eax
801043c7:	8d 04 80             	lea    (%eax,%eax,4),%eax
801043ca:	c1 e0 02             	shl    $0x2,%eax
801043cd:	39 c1                	cmp    %eax,%ecx
801043cf:	75 8c                	jne    8010435d <yield+0x6d>
          extendedPriorityScheduler(p, mycpu());
801043d1:	e8 2a f5 ff ff       	call   80103900 <mycpu>
801043d6:	89 1c 24             	mov    %ebx,(%esp)
801043d9:	89 44 24 04          	mov    %eax,0x4(%esp)
801043dd:	e8 1e fc ff ff       	call   80104000 <extendedPriorityScheduler>
801043e2:	e9 76 ff ff ff       	jmp    8010435d <yield+0x6d>
801043e7:	89 f6                	mov    %esi,%esi
801043e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801043f0 <sleep>:
{
801043f0:	55                   	push   %ebp
801043f1:	89 e5                	mov    %esp,%ebp
801043f3:	83 ec 28             	sub    $0x28,%esp
801043f6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801043f9:	89 75 f8             	mov    %esi,-0x8(%ebp)
801043fc:	8b 75 0c             	mov    0xc(%ebp),%esi
801043ff:	89 7d fc             	mov    %edi,-0x4(%ebp)
80104402:	8b 7d 08             	mov    0x8(%ebp),%edi
  pushcli();
80104405:	e8 36 15 00 00       	call   80105940 <pushcli>
  c = mycpu();
8010440a:	e8 f1 f4 ff ff       	call   80103900 <mycpu>
  p = c->proc;
8010440f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104415:	e8 66 15 00 00       	call   80105980 <popcli>
  if(p == 0)
8010441a:	85 db                	test   %ebx,%ebx
8010441c:	0f 84 8d 00 00 00    	je     801044af <sleep+0xbf>
  if(lk == 0)
80104422:	85 f6                	test   %esi,%esi
80104424:	74 7d                	je     801044a3 <sleep+0xb3>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104426:	81 fe 80 4d 11 80    	cmp    $0x80114d80,%esi
8010442c:	74 52                	je     80104480 <sleep+0x90>
    acquire(&ptable.lock);  //DOC: sleeplock1
8010442e:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104435:	e8 e6 15 00 00       	call   80105a20 <acquire>
    release(lk); 
8010443a:	89 34 24             	mov    %esi,(%esp)
8010443d:	e8 7e 16 00 00       	call   80105ac0 <release>
  p->chan = chan;
80104442:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104445:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
8010444c:	e8 ff fc ff ff       	call   80104150 <sched>
  p->chan = 0;
80104451:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104458:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010445f:	e8 5c 16 00 00       	call   80105ac0 <release>
}
80104464:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    acquire(lk);
80104467:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010446a:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010446d:	8b 75 f8             	mov    -0x8(%ebp),%esi
80104470:	89 ec                	mov    %ebp,%esp
80104472:	5d                   	pop    %ebp
    acquire(lk);
80104473:	e9 a8 15 00 00       	jmp    80105a20 <acquire>
80104478:	90                   	nop
80104479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104480:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104483:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
8010448a:	e8 c1 fc ff ff       	call   80104150 <sched>
  p->chan = 0;
8010448f:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104496:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104499:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010449c:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010449f:	89 ec                	mov    %ebp,%esp
801044a1:	5d                   	pop    %ebp
801044a2:	c3                   	ret    
    panic("sleep without lk");
801044a3:	c7 04 24 5f 8d 10 80 	movl   $0x80108d5f,(%esp)
801044aa:	e8 c1 be ff ff       	call   80100370 <panic>
    panic("sleep");
801044af:	c7 04 24 59 8d 10 80 	movl   $0x80108d59,(%esp)
801044b6:	e8 b5 be ff ff       	call   80100370 <panic>
801044bb:	90                   	nop
801044bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801044c0 <wait>:
{
801044c0:	55                   	push   %ebp
801044c1:	89 e5                	mov    %esp,%ebp
801044c3:	57                   	push   %edi
801044c4:	56                   	push   %esi
801044c5:	53                   	push   %ebx
801044c6:	83 ec 1c             	sub    $0x1c,%esp
801044c9:	8b 7d 08             	mov    0x8(%ebp),%edi
  pushcli();
801044cc:	e8 6f 14 00 00       	call   80105940 <pushcli>
  c = mycpu();
801044d1:	e8 2a f4 ff ff       	call   80103900 <mycpu>
  p = c->proc;
801044d6:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801044dc:	e8 9f 14 00 00       	call   80105980 <popcli>
  acquire(&ptable.lock);
801044e1:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801044e8:	e8 33 15 00 00       	call   80105a20 <acquire>
    havekids = 0;
801044ed:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044ef:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
801044f4:	eb 18                	jmp    8010450e <wait+0x4e>
801044f6:	8d 76 00             	lea    0x0(%esi),%esi
801044f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104500:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80104506:	81 fb b4 79 11 80    	cmp    $0x801179b4,%ebx
8010450c:	73 20                	jae    8010452e <wait+0x6e>
      if(p->parent != curproc)
8010450e:	39 73 14             	cmp    %esi,0x14(%ebx)
80104511:	75 ed                	jne    80104500 <wait+0x40>
      if(p->state == ZOMBIE){
80104513:	8b 43 0c             	mov    0xc(%ebx),%eax
80104516:	83 f8 05             	cmp    $0x5,%eax
80104519:	74 35                	je     80104550 <wait+0x90>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010451b:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
      havekids = 1;
80104521:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104526:	81 fb b4 79 11 80    	cmp    $0x801179b4,%ebx
8010452c:	72 e0                	jb     8010450e <wait+0x4e>
    if(!havekids || curproc->killed){
8010452e:	85 c0                	test   %eax,%eax
80104530:	74 7d                	je     801045af <wait+0xef>
80104532:	8b 56 24             	mov    0x24(%esi),%edx
80104535:	85 d2                	test   %edx,%edx
80104537:	75 76                	jne    801045af <wait+0xef>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104539:	b8 80 4d 11 80       	mov    $0x80114d80,%eax
8010453e:	89 44 24 04          	mov    %eax,0x4(%esp)
80104542:	89 34 24             	mov    %esi,(%esp)
80104545:	e8 a6 fe ff ff       	call   801043f0 <sleep>
    havekids = 0;
8010454a:	eb a1                	jmp    801044ed <wait+0x2d>
8010454c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80104550:	8b 43 08             	mov    0x8(%ebx),%eax
        pid = p->pid;
80104553:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104556:	89 04 24             	mov    %eax,(%esp)
80104559:	e8 82 de ff ff       	call   801023e0 <kfree>
        freevm(p->pgdir);
8010455e:	8b 43 04             	mov    0x4(%ebx),%eax
        p->kstack = 0;
80104561:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104568:	89 04 24             	mov    %eax,(%esp)
8010456b:	e8 80 3e 00 00       	call   801083f0 <freevm>
        if(status != null){ 
80104570:	85 ff                	test   %edi,%edi
        p->pid = 0;
80104572:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104579:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104580:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104584:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
8010458b:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        if(status != null){ 
80104592:	74 05                	je     80104599 <wait+0xd9>
            *status = p->exitStatus;
80104594:	8b 43 7c             	mov    0x7c(%ebx),%eax
80104597:	89 07                	mov    %eax,(%edi)
        release(&ptable.lock);
80104599:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801045a0:	e8 1b 15 00 00       	call   80105ac0 <release>
}
801045a5:	83 c4 1c             	add    $0x1c,%esp
801045a8:	89 f0                	mov    %esi,%eax
801045aa:	5b                   	pop    %ebx
801045ab:	5e                   	pop    %esi
801045ac:	5f                   	pop    %edi
801045ad:	5d                   	pop    %ebp
801045ae:	c3                   	ret    
      release(&ptable.lock);
801045af:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
      return -1;
801045b6:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801045bb:	e8 00 15 00 00       	call   80105ac0 <release>
      return -1;
801045c0:	eb e3                	jmp    801045a5 <wait+0xe5>
801045c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045d0 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801045d0:	55                   	push   %ebp
801045d1:	89 e5                	mov    %esp,%ebp
801045d3:	53                   	push   %ebx
801045d4:	83 ec 14             	sub    $0x14,%esp
801045d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801045da:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801045e1:	e8 3a 14 00 00       	call   80105a20 <acquire>
  wakeup1(chan);
801045e6:	89 d8                	mov    %ebx,%eax
801045e8:	e8 03 f8 ff ff       	call   80103df0 <wakeup1>
  release(&ptable.lock);
801045ed:	c7 45 08 80 4d 11 80 	movl   $0x80114d80,0x8(%ebp)
}
801045f4:	83 c4 14             	add    $0x14,%esp
801045f7:	5b                   	pop    %ebx
801045f8:	5d                   	pop    %ebp
  release(&ptable.lock);
801045f9:	e9 c2 14 00 00       	jmp    80105ac0 <release>
801045fe:	66 90                	xchg   %ax,%ax

80104600 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104600:	55                   	push   %ebp
80104601:	89 e5                	mov    %esp,%ebp
80104603:	56                   	push   %esi
80104604:	53                   	push   %ebx
  struct proc *p;
    
  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104605:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
{
8010460a:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010460d:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
{
80104614:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&ptable.lock);
80104617:	e8 04 14 00 00       	call   80105a20 <acquire>
8010461c:	eb 10                	jmp    8010462e <kill+0x2e>
8010461e:	66 90                	xchg   %ax,%ax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104620:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80104626:	81 fb b4 79 11 80    	cmp    $0x801179b4,%ebx
8010462c:	73 5a                	jae    80104688 <kill+0x88>
    if(p->pid == pid){
8010462e:	39 73 10             	cmp    %esi,0x10(%ebx)
80104631:	75 ed                	jne    80104620 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING){
80104633:	8b 43 0c             	mov    0xc(%ebx),%eax
      p->killed = 1;
80104636:	c7 43 24 01 00 00 00 	movl   $0x1,0x24(%ebx)
      if(p->state == SLEEPING){
8010463d:	83 f8 02             	cmp    $0x2,%eax
80104640:	74 1e                	je     80104660 <kill+0x60>
        if(POLICY == 1)
            rrq.enqueue(p);
        else
            pq.put(p);
      }
      release(&ptable.lock);
80104642:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104649:	e8 72 14 00 00       	call   80105ac0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
8010464e:	83 c4 10             	add    $0x10,%esp
      return 0;
80104651:	31 c0                	xor    %eax,%eax
}
80104653:	5b                   	pop    %ebx
80104654:	5e                   	pop    %esi
80104655:	5d                   	pop    %ebp
80104656:	c3                   	ret    
80104657:	89 f6                	mov    %esi,%esi
80104659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        setAccumulator(p);  
80104660:	89 1c 24             	mov    %ebx,(%esp)
        p->state = RUNNABLE;
80104663:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
        setAccumulator(p);  
8010466a:	e8 11 f5 ff ff       	call   80103b80 <setAccumulator>
        if(POLICY == 1)
8010466f:	83 3d 08 c0 10 80 01 	cmpl   $0x1,0x8010c008
            rrq.enqueue(p);
80104676:	89 1c 24             	mov    %ebx,(%esp)
        if(POLICY == 1)
80104679:	74 25                	je     801046a0 <kill+0xa0>
            pq.put(p);
8010467b:	ff 15 e4 c5 10 80    	call   *0x8010c5e4
80104681:	eb bf                	jmp    80104642 <kill+0x42>
80104683:	90                   	nop
80104684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104688:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010468f:	e8 2c 14 00 00       	call   80105ac0 <release>
}
80104694:	83 c4 10             	add    $0x10,%esp
  return -1;
80104697:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010469c:	5b                   	pop    %ebx
8010469d:	5e                   	pop    %esi
8010469e:	5d                   	pop    %ebp
8010469f:	c3                   	ret    
            rrq.enqueue(p);
801046a0:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
801046a6:	eb 9a                	jmp    80104642 <kill+0x42>
801046a8:	90                   	nop
801046a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801046b0 <detach>:

// transfer a child process with the given pid from the parent to the init process.
// return 0 when succseeds or -1 if the process has no child with this pid.
int
detach(int pid)
{ 
801046b0:	55                   	push   %ebp
801046b1:	89 e5                	mov    %esp,%ebp
801046b3:	57                   	push   %edi
801046b4:	56                   	push   %esi
801046b5:	53                   	push   %ebx
801046b6:	83 ec 1c             	sub    $0x1c,%esp
801046b9:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801046bc:	e8 7f 12 00 00       	call   80105940 <pushcli>
  c = mycpu();
801046c1:	e8 3a f2 ff ff       	call   80103900 <mycpu>
  p = c->proc;
801046c6:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801046cc:	e8 af 12 00 00       	call   80105980 <popcli>
  struct proc *curproc = myproc();
  struct proc *p;
  int procExist = -1;

  if(curproc == initproc)
801046d1:	39 1d bc c5 10 80    	cmp    %ebx,0x8010c5bc
801046d7:	74 6d                	je     80104746 <detach+0x96>
    panic("init called detach");

  acquire(&ptable.lock);
801046d9:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
  int procExist = -1;
801046e0:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046e5:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
  acquire(&ptable.lock);
801046ea:	e8 31 13 00 00       	call   80105a20 <acquire>
801046ef:	eb 15                	jmp    80104706 <detach+0x56>
801046f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046f8:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801046fe:	81 fb b4 79 11 80    	cmp    $0x801179b4,%ebx
80104704:	73 2a                	jae    80104730 <detach+0x80>
    if(p->pid == pid){
80104706:	39 73 10             	cmp    %esi,0x10(%ebx)
80104709:	75 ed                	jne    801046f8 <detach+0x48>
        procExist = 0;	
        p->parent = initproc;
        if(p->state == ZOMBIE)
8010470b:	8b 53 0c             	mov    0xc(%ebx),%edx
        procExist = 0;	
8010470e:	31 ff                	xor    %edi,%edi
        p->parent = initproc;
80104710:	a1 bc c5 10 80       	mov    0x8010c5bc,%eax
        if(p->state == ZOMBIE)
80104715:	83 fa 05             	cmp    $0x5,%edx
        p->parent = initproc;
80104718:	89 43 14             	mov    %eax,0x14(%ebx)
        if(p->state == ZOMBIE)
8010471b:	75 db                	jne    801046f8 <detach+0x48>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010471d:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
            wakeup1(initproc);
80104723:	e8 c8 f6 ff ff       	call   80103df0 <wakeup1>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104728:	81 fb b4 79 11 80    	cmp    $0x801179b4,%ebx
8010472e:	72 d6                	jb     80104706 <detach+0x56>
    }
  }
  release(&ptable.lock);
80104730:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104737:	e8 84 13 00 00       	call   80105ac0 <release>
  return procExist;
}
8010473c:	83 c4 1c             	add    $0x1c,%esp
8010473f:	89 f8                	mov    %edi,%eax
80104741:	5b                   	pop    %ebx
80104742:	5e                   	pop    %esi
80104743:	5f                   	pop    %edi
80104744:	5d                   	pop    %ebp
80104745:	c3                   	ret    
    panic("init called detach");
80104746:	c7 04 24 70 8d 10 80 	movl   $0x80108d70,(%esp)
8010474d:	e8 1e bc ff ff       	call   80100370 <panic>
80104752:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104760 <priority>:

// used by a process to change its priority
void
priority(int proc_priority)
{
80104760:	55                   	push   %ebp
80104761:	89 e5                	mov    %esp,%ebp
80104763:	83 ec 18             	sub    $0x18,%esp
80104766:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104769:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010476c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  pushcli();
8010476f:	e8 cc 11 00 00       	call   80105940 <pushcli>
  c = mycpu();
80104774:	e8 87 f1 ff ff       	call   80103900 <mycpu>
  p = c->proc;
80104779:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
8010477f:	e8 fc 11 00 00       	call   80105980 <popcli>
  struct proc *curproc = myproc();
  
  if(proc_priority <= 10 && proc_priority >= 0){
80104784:	83 fb 0a             	cmp    $0xa,%ebx
80104787:	77 13                	ja     8010479c <priority+0x3c>
      if(POLICY == 3 || (POLICY == 2 && proc_priority >= 1)){
80104789:	a1 08 c0 10 80       	mov    0x8010c008,%eax
8010478e:	83 f8 03             	cmp    $0x3,%eax
80104791:	74 1d                	je     801047b0 <priority+0x50>
80104793:	83 f8 02             	cmp    $0x2,%eax
80104796:	75 04                	jne    8010479c <priority+0x3c>
80104798:	85 db                	test   %ebx,%ebx
8010479a:	75 14                	jne    801047b0 <priority+0x50>
        acquire(&ptable.lock);
        curproc->priority = proc_priority;
        release(&ptable.lock); 
      }
  }
}
8010479c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010479f:	8b 75 fc             	mov    -0x4(%ebp),%esi
801047a2:	89 ec                	mov    %ebp,%esp
801047a4:	5d                   	pop    %ebp
801047a5:	c3                   	ret    
801047a6:	8d 76 00             	lea    0x0(%esi),%esi
801047a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        acquire(&ptable.lock);
801047b0:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801047b7:	e8 64 12 00 00       	call   80105a20 <acquire>
        curproc->priority = proc_priority;
801047bc:	89 9e 80 00 00 00    	mov    %ebx,0x80(%esi)
}
801047c2:	8b 5d f8             	mov    -0x8(%ebp),%ebx
        release(&ptable.lock); 
801047c5:	c7 45 08 80 4d 11 80 	movl   $0x80114d80,0x8(%ebp)
}
801047cc:	8b 75 fc             	mov    -0x4(%ebp),%esi
801047cf:	89 ec                	mov    %ebp,%esp
801047d1:	5d                   	pop    %ebp
        release(&ptable.lock); 
801047d2:	e9 e9 12 00 00       	jmp    80105ac0 <release>
801047d7:	89 f6                	mov    %esi,%esi
801047d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047e0 <policy>:

// receives a policy identifier as an argument and changes the currently used policy.
void
policy(int policy_id)
{
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	56                   	push   %esi
801047e4:	53                   	push   %ebx
    struct proc *p;
    
    acquire(&ptable.lock);
    
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801047e5:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
{
801047ea:	83 ec 10             	sub    $0x10,%esp
    acquire(&ptable.lock);
801047ed:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
{
801047f4:	8b 75 08             	mov    0x8(%ebp),%esi
    acquire(&ptable.lock);
801047f7:	e8 24 12 00 00       	call   80105a20 <acquire>
801047fc:	eb 2f                	jmp    8010482d <policy+0x4d>
801047fe:	66 90                	xchg   %ax,%ax
        if(policy_id == 1 && (POLICY == 2 || POLICY == 3)){ /*change from Priority to Round Robin policy*/
            pq.switchToRoundRobinPolicy();
            p->accumulator = 0;
        }
        if(policy_id == 2){ 
80104800:	83 fe 02             	cmp    $0x2,%esi
80104803:	74 5b                	je     80104860 <policy+0x80>
            }
            if(POLICY == 1){ /*change from Round Robin to Priority scheduling policy*/
                rrq.switchToPriorityQueuePolicy();
            }
        }
        if(policy_id == 3 && POLICY == 1){ /*change from Extended Priority to Round Robin policy*/
80104805:	83 fe 03             	cmp    $0x3,%esi
80104808:	75 0f                	jne    80104819 <policy+0x39>
8010480a:	83 3d 08 c0 10 80 01 	cmpl   $0x1,0x8010c008
80104811:	75 06                	jne    80104819 <policy+0x39>
            pq.switchToRoundRobinPolicy();
80104813:	ff 15 f0 c5 10 80    	call   *0x8010c5f0
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104819:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010481f:	81 fb b4 79 11 80    	cmp    $0x801179b4,%ebx
        }
        POLICY = policy_id;
80104825:	89 35 08 c0 10 80    	mov    %esi,0x8010c008
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010482b:	73 63                	jae    80104890 <policy+0xb0>
        if(policy_id == 1 && (POLICY == 2 || POLICY == 3)){ /*change from Priority to Round Robin policy*/
8010482d:	83 fe 01             	cmp    $0x1,%esi
80104830:	75 ce                	jne    80104800 <policy+0x20>
80104832:	a1 08 c0 10 80       	mov    0x8010c008,%eax
80104837:	83 e8 02             	sub    $0x2,%eax
8010483a:	83 f8 01             	cmp    $0x1,%eax
8010483d:	77 da                	ja     80104819 <policy+0x39>
            pq.switchToRoundRobinPolicy();
8010483f:	ff 15 f0 c5 10 80    	call   *0x8010c5f0
            p->accumulator = 0;
80104845:	31 c9                	xor    %ecx,%ecx
80104847:	31 c0                	xor    %eax,%eax
80104849:	89 8b 84 00 00 00    	mov    %ecx,0x84(%ebx)
8010484f:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
80104855:	eb c2                	jmp    80104819 <policy+0x39>
80104857:	89 f6                	mov    %esi,%esi
80104859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            if(POLICY == 3){ /*change from Extended Priority to Priority scheduling policy*/
80104860:	a1 08 c0 10 80       	mov    0x8010c008,%eax
80104865:	83 f8 03             	cmp    $0x3,%eax
80104868:	74 0e                	je     80104878 <policy+0x98>
            if(POLICY == 1){ /*change from Round Robin to Priority scheduling policy*/
8010486a:	48                   	dec    %eax
8010486b:	75 ac                	jne    80104819 <policy+0x39>
                rrq.switchToPriorityQueuePolicy();
8010486d:	ff 15 dc c5 10 80    	call   *0x8010c5dc
80104873:	eb a4                	jmp    80104819 <policy+0x39>
80104875:	8d 76 00             	lea    0x0(%esi),%esi
                if(p->priority == 0) 
80104878:	8b 93 80 00 00 00    	mov    0x80(%ebx),%edx
8010487e:	85 d2                	test   %edx,%edx
80104880:	75 97                	jne    80104819 <policy+0x39>
                    p->priority = 1;
80104882:	b8 01 00 00 00       	mov    $0x1,%eax
80104887:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
8010488d:	eb 8a                	jmp    80104819 <policy+0x39>
8010488f:	90                   	nop
    }
    cprintf("update POLICY to %d\n", POLICY);
80104890:	89 74 24 04          	mov    %esi,0x4(%esp)
80104894:	c7 04 24 83 8d 10 80 	movl   $0x80108d83,(%esp)
8010489b:	e8 b0 bd ff ff       	call   80100650 <cprintf>
    release(&ptable.lock);
801048a0:	c7 45 08 80 4d 11 80 	movl   $0x80114d80,0x8(%ebp)
}
801048a7:	83 c4 10             	add    $0x10,%esp
801048aa:	5b                   	pop    %ebx
801048ab:	5e                   	pop    %esi
801048ac:	5d                   	pop    %ebp
    release(&ptable.lock);
801048ad:	e9 0e 12 00 00       	jmp    80105ac0 <release>
801048b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048c0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
801048c3:	57                   	push   %edi
801048c4:	56                   	push   %esi
801048c5:	53                   	push   %ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048c6:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
{
801048cb:	83 ec 4c             	sub    $0x4c,%esp
801048ce:	eb 1e                	jmp    801048ee <procdump+0x2e>
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801048d0:	c7 04 24 21 8e 10 80 	movl   $0x80108e21,(%esp)
801048d7:	e8 74 bd ff ff       	call   80100650 <cprintf>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048dc:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801048e2:	81 fb b4 79 11 80    	cmp    $0x801179b4,%ebx
801048e8:	0f 83 b2 00 00 00    	jae    801049a0 <procdump+0xe0>
    if(p->state == UNUSED)
801048ee:	8b 43 0c             	mov    0xc(%ebx),%eax
801048f1:	85 c0                	test   %eax,%eax
801048f3:	74 e7                	je     801048dc <procdump+0x1c>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801048f5:	8b 43 0c             	mov    0xc(%ebx),%eax
      state = "???";
801048f8:	b8 98 8d 10 80       	mov    $0x80108d98,%eax
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801048fd:	8b 53 0c             	mov    0xc(%ebx),%edx
80104900:	83 fa 05             	cmp    $0x5,%edx
80104903:	77 18                	ja     8010491d <procdump+0x5d>
80104905:	8b 53 0c             	mov    0xc(%ebx),%edx
80104908:	8b 14 95 f8 8d 10 80 	mov    -0x7fef7208(,%edx,4),%edx
8010490f:	85 d2                	test   %edx,%edx
80104911:	74 0a                	je     8010491d <procdump+0x5d>
      state = states[p->state];
80104913:	8b 43 0c             	mov    0xc(%ebx),%eax
80104916:	8b 04 85 f8 8d 10 80 	mov    -0x7fef7208(,%eax,4),%eax
    cprintf("%d %s %s", p->pid, state, p->name);
8010491d:	89 44 24 08          	mov    %eax,0x8(%esp)
80104921:	8b 43 10             	mov    0x10(%ebx),%eax
80104924:	8d 53 6c             	lea    0x6c(%ebx),%edx
80104927:	89 54 24 0c          	mov    %edx,0xc(%esp)
8010492b:	c7 04 24 9c 8d 10 80 	movl   $0x80108d9c,(%esp)
80104932:	89 44 24 04          	mov    %eax,0x4(%esp)
80104936:	e8 15 bd ff ff       	call   80100650 <cprintf>
    if(p->state == SLEEPING){
8010493b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010493e:	83 f8 02             	cmp    $0x2,%eax
80104941:	75 8d                	jne    801048d0 <procdump+0x10>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104943:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104946:	89 44 24 04          	mov    %eax,0x4(%esp)
8010494a:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010494d:	8d 75 c0             	lea    -0x40(%ebp),%esi
80104950:	8d 7d e8             	lea    -0x18(%ebp),%edi
80104953:	8b 40 0c             	mov    0xc(%eax),%eax
80104956:	83 c0 08             	add    $0x8,%eax
80104959:	89 04 24             	mov    %eax,(%esp)
8010495c:	e8 8f 0f 00 00       	call   801058f0 <getcallerpcs>
80104961:	eb 0d                	jmp    80104970 <procdump+0xb0>
80104963:	90                   	nop
80104964:	90                   	nop
80104965:	90                   	nop
80104966:	90                   	nop
80104967:	90                   	nop
80104968:	90                   	nop
80104969:	90                   	nop
8010496a:	90                   	nop
8010496b:	90                   	nop
8010496c:	90                   	nop
8010496d:	90                   	nop
8010496e:	90                   	nop
8010496f:	90                   	nop
      for(i=0; i<10 && pc[i] != 0; i++)
80104970:	8b 16                	mov    (%esi),%edx
80104972:	85 d2                	test   %edx,%edx
80104974:	0f 84 56 ff ff ff    	je     801048d0 <procdump+0x10>
        cprintf(" %p", pc[i]);
8010497a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010497e:	83 c6 04             	add    $0x4,%esi
80104981:	c7 04 24 61 87 10 80 	movl   $0x80108761,(%esp)
80104988:	e8 c3 bc ff ff       	call   80100650 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
8010498d:	39 f7                	cmp    %esi,%edi
8010498f:	75 df                	jne    80104970 <procdump+0xb0>
80104991:	e9 3a ff ff ff       	jmp    801048d0 <procdump+0x10>
80104996:	8d 76 00             	lea    0x0(%esi),%esi
80104999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }
}
801049a0:	83 c4 4c             	add    $0x4c,%esp
801049a3:	5b                   	pop    %ebx
801049a4:	5e                   	pop    %esi
801049a5:	5f                   	pop    %edi
801049a6:	5d                   	pop    %ebp
801049a7:	c3                   	ret    
801049a8:	90                   	nop
801049a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801049b0 <wait_stat>:

// Return the pidof the terminated child process or -1 upon failure.
int
wait_stat(int* status, struct perf * performance){
801049b0:	55                   	push   %ebp
801049b1:	89 e5                	mov    %esp,%ebp
801049b3:	56                   	push   %esi
801049b4:	8b 75 0c             	mov    0xc(%ebp),%esi
801049b7:	53                   	push   %ebx
  pushcli();
801049b8:	e8 83 0f 00 00       	call   80105940 <pushcli>
  c = mycpu();
801049bd:	e8 3e ef ff ff       	call   80103900 <mycpu>
  p = c->proc;
801049c2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801049c8:	e8 b3 0f 00 00       	call   80105980 <popcli>
      struct proc *curproc = myproc();
      
      if (!curproc)
801049cd:	85 db                	test   %ebx,%ebx
801049cf:	74 3b                	je     80104a0c <wait_stat+0x5c>
          return -1;
      
      *performance = curproc->performance;
801049d1:	8b 83 90 00 00 00    	mov    0x90(%ebx),%eax
801049d7:	89 06                	mov    %eax,(%esi)
801049d9:	8b 83 94 00 00 00    	mov    0x94(%ebx),%eax
801049df:	89 46 04             	mov    %eax,0x4(%esi)
801049e2:	8b 83 98 00 00 00    	mov    0x98(%ebx),%eax
801049e8:	89 46 08             	mov    %eax,0x8(%esi)
801049eb:	8b 83 9c 00 00 00    	mov    0x9c(%ebx),%eax
801049f1:	89 46 0c             	mov    %eax,0xc(%esi)
801049f4:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
801049fa:	89 46 10             	mov    %eax,0x10(%esi)
      *status = curproc->exitStatus;
801049fd:	8b 45 08             	mov    0x8(%ebp),%eax
80104a00:	8b 53 7c             	mov    0x7c(%ebx),%edx
80104a03:	89 10                	mov    %edx,(%eax)
      
      return curproc->pid;
80104a05:	8b 43 10             	mov    0x10(%ebx),%eax
}
80104a08:	5b                   	pop    %ebx
80104a09:	5e                   	pop    %esi
80104a0a:	5d                   	pop    %ebp
80104a0b:	c3                   	ret    
          return -1;
80104a0c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a11:	eb f5                	jmp    80104a08 <wait_stat+0x58>
80104a13:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a20 <updatePerformance>:

// increments performence to all proccesses that are running or sleeping
void updatePerformance(){
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  acquire(&ptable.lock);
80104a26:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104a2d:	e8 ee 0f 00 00       	call   80105a20 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a32:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
80104a37:	89 f6                	mov    %esi,%esi
80104a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(p->state == RUNNABLE){
80104a40:	8b 50 0c             	mov    0xc(%eax),%edx
80104a43:	83 fa 03             	cmp    $0x3,%edx
80104a46:	75 06                	jne    80104a4e <updatePerformance+0x2e>
        p->performance.retime++;
80104a48:	ff 80 9c 00 00 00    	incl   0x9c(%eax)
    }
    if(p->state == RUNNING){
80104a4e:	8b 50 0c             	mov    0xc(%eax),%edx
80104a51:	83 fa 04             	cmp    $0x4,%edx
80104a54:	75 06                	jne    80104a5c <updatePerformance+0x3c>
      p->performance.rutime++;
80104a56:	ff 80 a0 00 00 00    	incl   0xa0(%eax)
    }
    if(p->state == SLEEPING){
80104a5c:	8b 50 0c             	mov    0xc(%eax),%edx
80104a5f:	83 fa 02             	cmp    $0x2,%edx
80104a62:	75 06                	jne    80104a6a <updatePerformance+0x4a>
      p->performance.stime++;
80104a64:	ff 80 98 00 00 00    	incl   0x98(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a6a:	05 b0 00 00 00       	add    $0xb0,%eax
80104a6f:	3d b4 79 11 80       	cmp    $0x801179b4,%eax
80104a74:	72 ca                	jb     80104a40 <updatePerformance+0x20>
    }
  }
  release(&ptable.lock);
80104a76:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104a7d:	e8 3e 10 00 00       	call   80105ac0 <release>
}
80104a82:	c9                   	leave  
80104a83:	c3                   	ret    
80104a84:	66 90                	xchg   %ax,%ax
80104a86:	66 90                	xchg   %ax,%ax
80104a88:	66 90                	xchg   %ax,%ax
80104a8a:	66 90                	xchg   %ax,%ax
80104a8c:	66 90                	xchg   %ax,%ax
80104a8e:	66 90                	xchg   %ax,%ax

80104a90 <isEmptyPriorityQueue>:
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
80104a90:	a1 10 c6 10 80       	mov    0x8010c610,%eax
static boolean isEmptyPriorityQueue() {
80104a95:	55                   	push   %ebp
80104a96:	89 e5                	mov    %esp,%ebp
}
80104a98:	5d                   	pop    %ebp
	return !root;
80104a99:	8b 00                	mov    (%eax),%eax
80104a9b:	85 c0                	test   %eax,%eax
80104a9d:	0f 94 c0             	sete   %al
80104aa0:	0f b6 c0             	movzbl %al,%eax
}
80104aa3:	c3                   	ret    
80104aa4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104aaa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104ab0 <getMinAccumulatorPriorityQueue>:
	return !root;
80104ab0:	a1 10 c6 10 80       	mov    0x8010c610,%eax
80104ab5:	8b 10                	mov    (%eax),%edx
	
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
	if(isEmpty())
80104ab7:	85 d2                	test   %edx,%edx
80104ab9:	74 35                	je     80104af0 <getMinAccumulatorPriorityQueue+0x40>
static boolean getMinAccumulatorPriorityQueue(long long* pkey) {
80104abb:	55                   	push   %ebp
80104abc:	89 e5                	mov    %esp,%ebp
80104abe:	53                   	push   %ebx
80104abf:	eb 09                	jmp    80104aca <getMinAccumulatorPriorityQueue+0x1a>
80104ac1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	while(minNode->left)
80104ac8:	89 c2                	mov    %eax,%edx
80104aca:	8b 42 18             	mov    0x18(%edx),%eax
80104acd:	85 c0                	test   %eax,%eax
80104acf:	75 f7                	jne    80104ac8 <getMinAccumulatorPriorityQueue+0x18>
	*pkey = getMinNode()->key;
80104ad1:	8b 45 08             	mov    0x8(%ebp),%eax
80104ad4:	8b 5a 04             	mov    0x4(%edx),%ebx
80104ad7:	8b 0a                	mov    (%edx),%ecx
80104ad9:	89 58 04             	mov    %ebx,0x4(%eax)
80104adc:	89 08                	mov    %ecx,(%eax)
80104ade:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104ae3:	5b                   	pop    %ebx
80104ae4:	5d                   	pop    %ebp
80104ae5:	c3                   	ret    
80104ae6:	8d 76 00             	lea    0x0(%esi),%esi
80104ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	if(isEmpty())
80104af0:	31 c0                	xor    %eax,%eax
}
80104af2:	c3                   	ret    
80104af3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b00 <isEmptyRoundRobinQueue>:
	return !first;
80104b00:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
static boolean isEmptyRoundRobinQueue() {
80104b05:	55                   	push   %ebp
80104b06:	89 e5                	mov    %esp,%ebp
}
80104b08:	5d                   	pop    %ebp
	return !first;
80104b09:	8b 00                	mov    (%eax),%eax
80104b0b:	85 c0                	test   %eax,%eax
80104b0d:	0f 94 c0             	sete   %al
80104b10:	0f b6 c0             	movzbl %al,%eax
}
80104b13:	c3                   	ret    
80104b14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104b20 <enqueueRoundRobinQueue>:
	if(!freeLinks)
80104b20:	a1 04 c6 10 80       	mov    0x8010c604,%eax
80104b25:	85 c0                	test   %eax,%eax
80104b27:	74 47                	je     80104b70 <enqueueRoundRobinQueue+0x50>
static boolean enqueueRoundRobinQueue(Proc *p) {
80104b29:	55                   	push   %ebp
	return roundRobinQ->enqueue(p);
80104b2a:	8b 0d 0c c6 10 80    	mov    0x8010c60c,%ecx
	freeLinks = freeLinks->next;
80104b30:	8b 50 04             	mov    0x4(%eax),%edx
static boolean enqueueRoundRobinQueue(Proc *p) {
80104b33:	89 e5                	mov    %esp,%ebp
	ans->next = null;
80104b35:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
80104b3c:	89 15 04 c6 10 80    	mov    %edx,0x8010c604
	ans->p = p;
80104b42:	8b 55 08             	mov    0x8(%ebp),%edx
80104b45:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80104b47:	8b 11                	mov    (%ecx),%edx
80104b49:	85 d2                	test   %edx,%edx
80104b4b:	74 2b                	je     80104b78 <enqueueRoundRobinQueue+0x58>
	else last->next = link;
80104b4d:	8b 51 04             	mov    0x4(%ecx),%edx
80104b50:	89 42 04             	mov    %eax,0x4(%edx)
80104b53:	eb 05                	jmp    80104b5a <enqueueRoundRobinQueue+0x3a>
80104b55:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
80104b58:	89 d0                	mov    %edx,%eax
80104b5a:	8b 50 04             	mov    0x4(%eax),%edx
80104b5d:	85 d2                	test   %edx,%edx
80104b5f:	75 f7                	jne    80104b58 <enqueueRoundRobinQueue+0x38>
	last = link->getLast();
80104b61:	89 41 04             	mov    %eax,0x4(%ecx)
80104b64:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104b69:	5d                   	pop    %ebp
80104b6a:	c3                   	ret    
80104b6b:	90                   	nop
80104b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!freeLinks)
80104b70:	31 c0                	xor    %eax,%eax
}
80104b72:	c3                   	ret    
80104b73:	90                   	nop
80104b74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
80104b78:	89 01                	mov    %eax,(%ecx)
80104b7a:	eb de                	jmp    80104b5a <enqueueRoundRobinQueue+0x3a>
80104b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b80 <dequeueRoundRobinQueue>:
	return roundRobinQ->dequeue();
80104b80:	8b 0d 0c c6 10 80    	mov    0x8010c60c,%ecx
	return !first;
80104b86:	8b 11                	mov    (%ecx),%edx
	if(isEmpty())
80104b88:	85 d2                	test   %edx,%edx
80104b8a:	74 3c                	je     80104bc8 <dequeueRoundRobinQueue+0x48>
static Proc* dequeueRoundRobinQueue() {
80104b8c:	55                   	push   %ebp
80104b8d:	89 e5                	mov    %esp,%ebp
80104b8f:	83 ec 08             	sub    $0x8,%esp
80104b92:	89 75 fc             	mov    %esi,-0x4(%ebp)
	link->next = freeLinks;
80104b95:	8b 35 04 c6 10 80    	mov    0x8010c604,%esi
static Proc* dequeueRoundRobinQueue() {
80104b9b:	89 5d f8             	mov    %ebx,-0x8(%ebp)
	Link *next = first->next;
80104b9e:	8b 5a 04             	mov    0x4(%edx),%ebx
	Proc *p = first->p;
80104ba1:	8b 02                	mov    (%edx),%eax
	link->next = freeLinks;
80104ba3:	89 72 04             	mov    %esi,0x4(%edx)
	freeLinks = link;
80104ba6:	89 15 04 c6 10 80    	mov    %edx,0x8010c604
	if(isEmpty())
80104bac:	85 db                	test   %ebx,%ebx
	first = next;
80104bae:	89 19                	mov    %ebx,(%ecx)
	if(isEmpty())
80104bb0:	75 07                	jne    80104bb9 <dequeueRoundRobinQueue+0x39>
		last = null;
80104bb2:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
}
80104bb9:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104bbc:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104bbf:	89 ec                	mov    %ebp,%esp
80104bc1:	5d                   	pop    %ebp
80104bc2:	c3                   	ret    
80104bc3:	90                   	nop
80104bc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		return null;
80104bc8:	31 c0                	xor    %eax,%eax
}
80104bca:	c3                   	ret    
80104bcb:	90                   	nop
80104bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104bd0 <isEmptyRunningProcessHolder>:
	return !first;
80104bd0:	a1 08 c6 10 80       	mov    0x8010c608,%eax
static boolean isEmptyRunningProcessHolder() {
80104bd5:	55                   	push   %ebp
80104bd6:	89 e5                	mov    %esp,%ebp
}
80104bd8:	5d                   	pop    %ebp
	return !first;
80104bd9:	8b 00                	mov    (%eax),%eax
80104bdb:	85 c0                	test   %eax,%eax
80104bdd:	0f 94 c0             	sete   %al
80104be0:	0f b6 c0             	movzbl %al,%eax
}
80104be3:	c3                   	ret    
80104be4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104bea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104bf0 <addRunningProcessHolder>:
	if(!freeLinks)
80104bf0:	a1 04 c6 10 80       	mov    0x8010c604,%eax
80104bf5:	85 c0                	test   %eax,%eax
80104bf7:	74 47                	je     80104c40 <addRunningProcessHolder+0x50>
static boolean addRunningProcessHolder(Proc* p) {
80104bf9:	55                   	push   %ebp
	return runningProcHolder->enqueue(p);
80104bfa:	8b 0d 08 c6 10 80    	mov    0x8010c608,%ecx
	freeLinks = freeLinks->next;
80104c00:	8b 50 04             	mov    0x4(%eax),%edx
static boolean addRunningProcessHolder(Proc* p) {
80104c03:	89 e5                	mov    %esp,%ebp
	ans->next = null;
80104c05:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
80104c0c:	89 15 04 c6 10 80    	mov    %edx,0x8010c604
	ans->p = p;
80104c12:	8b 55 08             	mov    0x8(%ebp),%edx
80104c15:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80104c17:	8b 11                	mov    (%ecx),%edx
80104c19:	85 d2                	test   %edx,%edx
80104c1b:	74 2b                	je     80104c48 <addRunningProcessHolder+0x58>
	else last->next = link;
80104c1d:	8b 51 04             	mov    0x4(%ecx),%edx
80104c20:	89 42 04             	mov    %eax,0x4(%edx)
80104c23:	eb 05                	jmp    80104c2a <addRunningProcessHolder+0x3a>
80104c25:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
80104c28:	89 d0                	mov    %edx,%eax
80104c2a:	8b 50 04             	mov    0x4(%eax),%edx
80104c2d:	85 d2                	test   %edx,%edx
80104c2f:	75 f7                	jne    80104c28 <addRunningProcessHolder+0x38>
	last = link->getLast();
80104c31:	89 41 04             	mov    %eax,0x4(%ecx)
80104c34:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104c39:	5d                   	pop    %ebp
80104c3a:	c3                   	ret    
80104c3b:	90                   	nop
80104c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!freeLinks)
80104c40:	31 c0                	xor    %eax,%eax
}
80104c42:	c3                   	ret    
80104c43:	90                   	nop
80104c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
80104c48:	89 01                	mov    %eax,(%ecx)
80104c4a:	eb de                	jmp    80104c2a <addRunningProcessHolder+0x3a>
80104c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c50 <_ZL9allocNodeP4procx>:
static MapNode* allocNode(Proc *p, long long key) {
80104c50:	55                   	push   %ebp
80104c51:	89 e5                	mov    %esp,%ebp
80104c53:	56                   	push   %esi
80104c54:	53                   	push   %ebx
	if(!freeNodes)
80104c55:	8b 1d 00 c6 10 80    	mov    0x8010c600,%ebx
80104c5b:	85 db                	test   %ebx,%ebx
80104c5d:	74 4d                	je     80104cac <_ZL9allocNodeP4procx+0x5c>
	ans->key = key;
80104c5f:	89 13                	mov    %edx,(%ebx)
	if(!freeLinks)
80104c61:	8b 15 04 c6 10 80    	mov    0x8010c604,%edx
	freeNodes = freeNodes->next;
80104c67:	8b 73 10             	mov    0x10(%ebx),%esi
	ans->key = key;
80104c6a:	89 4b 04             	mov    %ecx,0x4(%ebx)
	ans->next = null;
80104c6d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
	if(!freeLinks)
80104c74:	85 d2                	test   %edx,%edx
	freeNodes = freeNodes->next;
80104c76:	89 35 00 c6 10 80    	mov    %esi,0x8010c600
	if(!freeLinks)
80104c7c:	74 3f                	je     80104cbd <_ZL9allocNodeP4procx+0x6d>
	freeLinks = freeLinks->next;
80104c7e:	8b 4a 04             	mov    0x4(%edx),%ecx
	ans->p = p;
80104c81:	89 02                	mov    %eax,(%edx)
	ans->next = null;
80104c83:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
	if(isEmpty()) first = link;
80104c8a:	8b 43 08             	mov    0x8(%ebx),%eax
	freeLinks = freeLinks->next;
80104c8d:	89 0d 04 c6 10 80    	mov    %ecx,0x8010c604
	if(isEmpty()) first = link;
80104c93:	85 c0                	test   %eax,%eax
80104c95:	74 21                	je     80104cb8 <_ZL9allocNodeP4procx+0x68>
	else last->next = link;
80104c97:	8b 43 0c             	mov    0xc(%ebx),%eax
80104c9a:	89 50 04             	mov    %edx,0x4(%eax)
80104c9d:	eb 03                	jmp    80104ca2 <_ZL9allocNodeP4procx+0x52>
80104c9f:	90                   	nop
	while(ans->next)
80104ca0:	89 ca                	mov    %ecx,%edx
80104ca2:	8b 4a 04             	mov    0x4(%edx),%ecx
80104ca5:	85 c9                	test   %ecx,%ecx
80104ca7:	75 f7                	jne    80104ca0 <_ZL9allocNodeP4procx+0x50>
	last = link->getLast();
80104ca9:	89 53 0c             	mov    %edx,0xc(%ebx)
}
80104cac:	89 d8                	mov    %ebx,%eax
80104cae:	5b                   	pop    %ebx
80104caf:	5e                   	pop    %esi
80104cb0:	5d                   	pop    %ebp
80104cb1:	c3                   	ret    
80104cb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	if(isEmpty()) first = link;
80104cb8:	89 53 08             	mov    %edx,0x8(%ebx)
80104cbb:	eb e5                	jmp    80104ca2 <_ZL9allocNodeP4procx+0x52>
	node->parent = node->left = node->right = null;
80104cbd:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
80104cc4:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
80104ccb:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
	node->next = freeNodes;
80104cd2:	89 73 10             	mov    %esi,0x10(%ebx)
	freeNodes = node;
80104cd5:	89 1d 00 c6 10 80    	mov    %ebx,0x8010c600
		return null;
80104cdb:	31 db                	xor    %ebx,%ebx
80104cdd:	eb cd                	jmp    80104cac <_ZL9allocNodeP4procx+0x5c>
80104cdf:	90                   	nop

80104ce0 <_ZL8mymallocj>:
static char* mymalloc(uint size) {
80104ce0:	55                   	push   %ebp
80104ce1:	89 e5                	mov    %esp,%ebp
80104ce3:	53                   	push   %ebx
80104ce4:	89 c3                	mov    %eax,%ebx
80104ce6:	83 ec 14             	sub    $0x14,%esp
	if(spaceLeft < size) {
80104ce9:	8b 15 f8 c5 10 80    	mov    0x8010c5f8,%edx
80104cef:	39 c2                	cmp    %eax,%edx
80104cf1:	73 26                	jae    80104d19 <_ZL8mymallocj+0x39>
		data = kalloc();
80104cf3:	e8 b8 d8 ff ff       	call   801025b0 <kalloc>
		memset(data, 0, PGSIZE);
80104cf8:	ba 00 10 00 00       	mov    $0x1000,%edx
80104cfd:	31 c9                	xor    %ecx,%ecx
80104cff:	89 54 24 08          	mov    %edx,0x8(%esp)
80104d03:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80104d07:	89 04 24             	mov    %eax,(%esp)
		data = kalloc();
80104d0a:	a3 fc c5 10 80       	mov    %eax,0x8010c5fc
		memset(data, 0, PGSIZE);
80104d0f:	e8 fc 0d 00 00       	call   80105b10 <memset>
80104d14:	ba 00 10 00 00       	mov    $0x1000,%edx
	char* ans = data;
80104d19:	a1 fc c5 10 80       	mov    0x8010c5fc,%eax
	spaceLeft -= size;
80104d1e:	29 da                	sub    %ebx,%edx
80104d20:	89 15 f8 c5 10 80    	mov    %edx,0x8010c5f8
	data += size;
80104d26:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80104d29:	89 0d fc c5 10 80    	mov    %ecx,0x8010c5fc
}
80104d2f:	83 c4 14             	add    $0x14,%esp
80104d32:	5b                   	pop    %ebx
80104d33:	5d                   	pop    %ebp
80104d34:	c3                   	ret    
80104d35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d40 <initSchedDS>:
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104d40:	55                   	push   %ebp
	data               = null;
80104d41:	31 c0                	xor    %eax,%eax
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104d43:	89 e5                	mov    %esp,%ebp
80104d45:	53                   	push   %ebx
	freeLinks = null;
80104d46:	bb 80 00 00 00       	mov    $0x80,%ebx
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104d4b:	83 ec 04             	sub    $0x4,%esp
	data               = null;
80104d4e:	a3 fc c5 10 80       	mov    %eax,0x8010c5fc
	spaceLeft          = 0u;
80104d53:	31 c0                	xor    %eax,%eax
80104d55:	a3 f8 c5 10 80       	mov    %eax,0x8010c5f8
	priorityQ          = (Map*)mymalloc(sizeof(Map));
80104d5a:	b8 04 00 00 00       	mov    $0x4,%eax
80104d5f:	e8 7c ff ff ff       	call   80104ce0 <_ZL8mymallocj>
80104d64:	a3 10 c6 10 80       	mov    %eax,0x8010c610
	*priorityQ         = Map();
80104d69:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	roundRobinQ        = (LinkedList*)mymalloc(sizeof(LinkedList));
80104d6f:	b8 08 00 00 00       	mov    $0x8,%eax
80104d74:	e8 67 ff ff ff       	call   80104ce0 <_ZL8mymallocj>
80104d79:	a3 0c c6 10 80       	mov    %eax,0x8010c60c
	*roundRobinQ       = LinkedList();
80104d7e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104d84:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	runningProcHolder  = (LinkedList*)mymalloc(sizeof(LinkedList));
80104d8b:	b8 08 00 00 00       	mov    $0x8,%eax
80104d90:	e8 4b ff ff ff       	call   80104ce0 <_ZL8mymallocj>
80104d95:	a3 08 c6 10 80       	mov    %eax,0x8010c608
	*runningProcHolder = LinkedList();
80104d9a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104da0:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = null;
80104da7:	31 c0                	xor    %eax,%eax
80104da9:	a3 04 c6 10 80       	mov    %eax,0x8010c604
80104dae:	66 90                	xchg   %ax,%ax
		Link *link = (Link*)mymalloc(sizeof(Link));
80104db0:	b8 08 00 00 00       	mov    $0x8,%eax
80104db5:	e8 26 ff ff ff       	call   80104ce0 <_ZL8mymallocj>
		link->next = freeLinks;
80104dba:	8b 15 04 c6 10 80    	mov    0x8010c604,%edx
	for(int i = 0; i < NPROCLIST; ++i) {
80104dc0:	4b                   	dec    %ebx
		*link = Link();
80104dc1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		link->next = freeLinks;
80104dc7:	89 50 04             	mov    %edx,0x4(%eax)
		freeLinks = link;
80104dca:	a3 04 c6 10 80       	mov    %eax,0x8010c604
	for(int i = 0; i < NPROCLIST; ++i) {
80104dcf:	75 df                	jne    80104db0 <initSchedDS+0x70>
	freeNodes = null;
80104dd1:	31 c0                	xor    %eax,%eax
80104dd3:	bb 80 00 00 00       	mov    $0x80,%ebx
80104dd8:	a3 00 c6 10 80       	mov    %eax,0x8010c600
80104ddd:	8d 76 00             	lea    0x0(%esi),%esi
		MapNode *node = (MapNode*)mymalloc(sizeof(MapNode));
80104de0:	b8 20 00 00 00       	mov    $0x20,%eax
80104de5:	e8 f6 fe ff ff       	call   80104ce0 <_ZL8mymallocj>
		node->next = freeNodes;
80104dea:	8b 15 00 c6 10 80    	mov    0x8010c600,%edx
	for(int i = 0; i < NPROCMAP; ++i) {
80104df0:	4b                   	dec    %ebx
		*node = MapNode();
80104df1:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80104df8:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
80104dff:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
80104e06:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
80104e0d:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
		node->next = freeNodes;
80104e14:	89 50 10             	mov    %edx,0x10(%eax)
		freeNodes = node;
80104e17:	a3 00 c6 10 80       	mov    %eax,0x8010c600
	for(int i = 0; i < NPROCMAP; ++i) {
80104e1c:	75 c2                	jne    80104de0 <initSchedDS+0xa0>
	pq.isEmpty                      = isEmptyPriorityQueue;
80104e1e:	b8 90 4a 10 80       	mov    $0x80104a90,%eax
	pq.put                          = putPriorityQueue;
80104e23:	ba 10 54 10 80       	mov    $0x80105410,%edx
	pq.isEmpty                      = isEmptyPriorityQueue;
80104e28:	a3 e0 c5 10 80       	mov    %eax,0x8010c5e0
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
80104e2d:	b8 d0 55 10 80       	mov    $0x801055d0,%eax
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
80104e32:	b9 b0 4a 10 80       	mov    $0x80104ab0,%ecx
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
80104e37:	a3 f0 c5 10 80       	mov    %eax,0x8010c5f0
	pq.extractProc                  = extractProcPriorityQueue;
80104e3c:	b8 b0 56 10 80       	mov    $0x801056b0,%eax
	pq.extractMin                   = extractMinPriorityQueue;
80104e41:	bb 30 55 10 80       	mov    $0x80105530,%ebx
	pq.extractProc                  = extractProcPriorityQueue;
80104e46:	a3 f4 c5 10 80       	mov    %eax,0x8010c5f4
	rrq.isEmpty                     = isEmptyRoundRobinQueue;
80104e4b:	b8 00 4b 10 80       	mov    $0x80104b00,%eax
80104e50:	a3 d0 c5 10 80       	mov    %eax,0x8010c5d0
	rrq.enqueue                     = enqueueRoundRobinQueue;
80104e55:	b8 20 4b 10 80       	mov    $0x80104b20,%eax
80104e5a:	a3 d4 c5 10 80       	mov    %eax,0x8010c5d4
	rrq.dequeue                     = dequeueRoundRobinQueue;
80104e5f:	b8 80 4b 10 80       	mov    $0x80104b80,%eax
80104e64:	a3 d8 c5 10 80       	mov    %eax,0x8010c5d8
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
80104e69:	b8 40 51 10 80       	mov    $0x80105140,%eax
	pq.put                          = putPriorityQueue;
80104e6e:	89 15 e4 c5 10 80    	mov    %edx,0x8010c5e4
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
80104e74:	ba d0 4b 10 80       	mov    $0x80104bd0,%edx
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
80104e79:	89 0d e8 c5 10 80    	mov    %ecx,0x8010c5e8
	rpholder.add                    = addRunningProcessHolder;
80104e7f:	b9 f0 4b 10 80       	mov    $0x80104bf0,%ecx
	pq.extractMin                   = extractMinPriorityQueue;
80104e84:	89 1d ec c5 10 80    	mov    %ebx,0x8010c5ec
	rpholder.remove                 = removeRunningProcessHolder;
80104e8a:	bb a0 50 10 80       	mov    $0x801050a0,%ebx
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
80104e8f:	a3 dc c5 10 80       	mov    %eax,0x8010c5dc
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
80104e94:	b8 d0 51 10 80       	mov    $0x801051d0,%eax
	rpholder.remove                 = removeRunningProcessHolder;
80104e99:	89 1d c8 c5 10 80    	mov    %ebx,0x8010c5c8
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
80104e9f:	89 15 c0 c5 10 80    	mov    %edx,0x8010c5c0
	rpholder.add                    = addRunningProcessHolder;
80104ea5:	89 0d c4 c5 10 80    	mov    %ecx,0x8010c5c4
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
80104eab:	a3 cc c5 10 80       	mov    %eax,0x8010c5cc
}
80104eb0:	58                   	pop    %eax
80104eb1:	5b                   	pop    %ebx
80104eb2:	5d                   	pop    %ebp
80104eb3:	c3                   	ret    
80104eb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104eba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104ec0 <_ZN4Link7getLastEv>:
Link* Link::getLast() {
80104ec0:	55                   	push   %ebp
80104ec1:	89 e5                	mov    %esp,%ebp
80104ec3:	8b 45 08             	mov    0x8(%ebp),%eax
80104ec6:	eb 0a                	jmp    80104ed2 <_ZN4Link7getLastEv+0x12>
80104ec8:	90                   	nop
80104ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ed0:	89 d0                	mov    %edx,%eax
	while(ans->next)
80104ed2:	8b 50 04             	mov    0x4(%eax),%edx
80104ed5:	85 d2                	test   %edx,%edx
80104ed7:	75 f7                	jne    80104ed0 <_ZN4Link7getLastEv+0x10>
}
80104ed9:	5d                   	pop    %ebp
80104eda:	c3                   	ret    
80104edb:	90                   	nop
80104edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ee0 <_ZN10LinkedList7isEmptyEv>:
bool LinkedList::isEmpty() {
80104ee0:	55                   	push   %ebp
80104ee1:	89 e5                	mov    %esp,%ebp
	return !first;
80104ee3:	8b 45 08             	mov    0x8(%ebp),%eax
}
80104ee6:	5d                   	pop    %ebp
	return !first;
80104ee7:	8b 00                	mov    (%eax),%eax
80104ee9:	85 c0                	test   %eax,%eax
80104eeb:	0f 94 c0             	sete   %al
}
80104eee:	c3                   	ret    
80104eef:	90                   	nop

80104ef0 <_ZN10LinkedList6appendEP4Link>:
void LinkedList::append(Link *link) {
80104ef0:	55                   	push   %ebp
80104ef1:	89 e5                	mov    %esp,%ebp
80104ef3:	8b 55 0c             	mov    0xc(%ebp),%edx
80104ef6:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!link)
80104ef9:	85 d2                	test   %edx,%edx
80104efb:	74 1f                	je     80104f1c <_ZN10LinkedList6appendEP4Link+0x2c>
	if(isEmpty()) first = link;
80104efd:	8b 01                	mov    (%ecx),%eax
80104eff:	85 c0                	test   %eax,%eax
80104f01:	74 1d                	je     80104f20 <_ZN10LinkedList6appendEP4Link+0x30>
	else last->next = link;
80104f03:	8b 41 04             	mov    0x4(%ecx),%eax
80104f06:	89 50 04             	mov    %edx,0x4(%eax)
80104f09:	eb 07                	jmp    80104f12 <_ZN10LinkedList6appendEP4Link+0x22>
80104f0b:	90                   	nop
80104f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	while(ans->next)
80104f10:	89 c2                	mov    %eax,%edx
80104f12:	8b 42 04             	mov    0x4(%edx),%eax
80104f15:	85 c0                	test   %eax,%eax
80104f17:	75 f7                	jne    80104f10 <_ZN10LinkedList6appendEP4Link+0x20>
	last = link->getLast();
80104f19:	89 51 04             	mov    %edx,0x4(%ecx)
}
80104f1c:	5d                   	pop    %ebp
80104f1d:	c3                   	ret    
80104f1e:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
80104f20:	89 11                	mov    %edx,(%ecx)
80104f22:	eb ee                	jmp    80104f12 <_ZN10LinkedList6appendEP4Link+0x22>
80104f24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104f30 <_ZN10LinkedList7enqueueEP4proc>:
	if(!freeLinks)
80104f30:	a1 04 c6 10 80       	mov    0x8010c604,%eax
bool LinkedList::enqueue(Proc *p) {
80104f35:	55                   	push   %ebp
80104f36:	89 e5                	mov    %esp,%ebp
80104f38:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!freeLinks)
80104f3b:	85 c0                	test   %eax,%eax
80104f3d:	74 41                	je     80104f80 <_ZN10LinkedList7enqueueEP4proc+0x50>
	freeLinks = freeLinks->next;
80104f3f:	8b 50 04             	mov    0x4(%eax),%edx
	ans->next = null;
80104f42:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
80104f49:	89 15 04 c6 10 80    	mov    %edx,0x8010c604
	ans->p = p;
80104f4f:	8b 55 0c             	mov    0xc(%ebp),%edx
80104f52:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80104f54:	8b 11                	mov    (%ecx),%edx
80104f56:	85 d2                	test   %edx,%edx
80104f58:	74 2e                	je     80104f88 <_ZN10LinkedList7enqueueEP4proc+0x58>
	else last->next = link;
80104f5a:	8b 51 04             	mov    0x4(%ecx),%edx
80104f5d:	89 42 04             	mov    %eax,0x4(%edx)
80104f60:	eb 08                	jmp    80104f6a <_ZN10LinkedList7enqueueEP4proc+0x3a>
80104f62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	while(ans->next)
80104f68:	89 d0                	mov    %edx,%eax
80104f6a:	8b 50 04             	mov    0x4(%eax),%edx
80104f6d:	85 d2                	test   %edx,%edx
80104f6f:	75 f7                	jne    80104f68 <_ZN10LinkedList7enqueueEP4proc+0x38>
	last = link->getLast();
80104f71:	89 41 04             	mov    %eax,0x4(%ecx)
	return true;
80104f74:	b0 01                	mov    $0x1,%al
}
80104f76:	5d                   	pop    %ebp
80104f77:	c3                   	ret    
80104f78:	90                   	nop
80104f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return false;
80104f80:	31 c0                	xor    %eax,%eax
}
80104f82:	5d                   	pop    %ebp
80104f83:	c3                   	ret    
80104f84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
80104f88:	89 01                	mov    %eax,(%ecx)
80104f8a:	eb de                	jmp    80104f6a <_ZN10LinkedList7enqueueEP4proc+0x3a>
80104f8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104f90 <_ZN10LinkedList7dequeueEv>:
Proc* LinkedList::dequeue() {
80104f90:	55                   	push   %ebp
80104f91:	89 e5                	mov    %esp,%ebp
80104f93:	83 ec 08             	sub    $0x8,%esp
80104f96:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104f99:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104f9c:	89 75 fc             	mov    %esi,-0x4(%ebp)
	return !first;
80104f9f:	8b 11                	mov    (%ecx),%edx
	if(isEmpty())
80104fa1:	85 d2                	test   %edx,%edx
80104fa3:	74 2b                	je     80104fd0 <_ZN10LinkedList7dequeueEv+0x40>
	Link *next = first->next;
80104fa5:	8b 5a 04             	mov    0x4(%edx),%ebx
	link->next = freeLinks;
80104fa8:	8b 35 04 c6 10 80    	mov    0x8010c604,%esi
	Proc *p = first->p;
80104fae:	8b 02                	mov    (%edx),%eax
	freeLinks = link;
80104fb0:	89 15 04 c6 10 80    	mov    %edx,0x8010c604
	if(isEmpty())
80104fb6:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
80104fb8:	89 72 04             	mov    %esi,0x4(%edx)
	first = next;
80104fbb:	89 19                	mov    %ebx,(%ecx)
	if(isEmpty())
80104fbd:	75 07                	jne    80104fc6 <_ZN10LinkedList7dequeueEv+0x36>
		last = null;
80104fbf:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
}
80104fc6:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104fc9:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104fcc:	89 ec                	mov    %ebp,%esp
80104fce:	5d                   	pop    %ebp
80104fcf:	c3                   	ret    
		return null;
80104fd0:	31 c0                	xor    %eax,%eax
80104fd2:	eb f2                	jmp    80104fc6 <_ZN10LinkedList7dequeueEv+0x36>
80104fd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104fda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104fe0 <_ZN10LinkedList6removeEP4proc>:
bool LinkedList::remove(Proc *p) {
80104fe0:	55                   	push   %ebp
80104fe1:	89 e5                	mov    %esp,%ebp
80104fe3:	56                   	push   %esi
80104fe4:	8b 75 08             	mov    0x8(%ebp),%esi
80104fe7:	53                   	push   %ebx
80104fe8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
	return !first;
80104feb:	8b 1e                	mov    (%esi),%ebx
	if(isEmpty())
80104fed:	85 db                	test   %ebx,%ebx
80104fef:	74 2f                	je     80105020 <_ZN10LinkedList6removeEP4proc+0x40>
	if(first->p == p) {
80104ff1:	39 0b                	cmp    %ecx,(%ebx)
80104ff3:	8b 53 04             	mov    0x4(%ebx),%edx
80104ff6:	74 70                	je     80105068 <_ZN10LinkedList6removeEP4proc+0x88>
	while(cur) {
80104ff8:	85 d2                	test   %edx,%edx
80104ffa:	74 24                	je     80105020 <_ZN10LinkedList6removeEP4proc+0x40>
		if(cur->p == p) {
80104ffc:	3b 0a                	cmp    (%edx),%ecx
80104ffe:	66 90                	xchg   %ax,%ax
80105000:	75 0c                	jne    8010500e <_ZN10LinkedList6removeEP4proc+0x2e>
80105002:	eb 2c                	jmp    80105030 <_ZN10LinkedList6removeEP4proc+0x50>
80105004:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105008:	39 08                	cmp    %ecx,(%eax)
8010500a:	74 34                	je     80105040 <_ZN10LinkedList6removeEP4proc+0x60>
8010500c:	89 c2                	mov    %eax,%edx
		cur = cur->next;
8010500e:	8b 42 04             	mov    0x4(%edx),%eax
	while(cur) {
80105011:	85 c0                	test   %eax,%eax
80105013:	75 f3                	jne    80105008 <_ZN10LinkedList6removeEP4proc+0x28>
}
80105015:	5b                   	pop    %ebx
80105016:	5e                   	pop    %esi
80105017:	5d                   	pop    %ebp
80105018:	c3                   	ret    
80105019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105020:	5b                   	pop    %ebx
		return false;
80105021:	31 c0                	xor    %eax,%eax
}
80105023:	5e                   	pop    %esi
80105024:	5d                   	pop    %ebp
80105025:	c3                   	ret    
80105026:	8d 76 00             	lea    0x0(%esi),%esi
80105029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		if(cur->p == p) {
80105030:	89 d0                	mov    %edx,%eax
80105032:	89 da                	mov    %ebx,%edx
80105034:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010503a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
			prev->next = cur->next;
80105040:	8b 48 04             	mov    0x4(%eax),%ecx
80105043:	89 4a 04             	mov    %ecx,0x4(%edx)
			if(!(cur->next)) //removes the last link
80105046:	8b 48 04             	mov    0x4(%eax),%ecx
80105049:	85 c9                	test   %ecx,%ecx
8010504b:	74 43                	je     80105090 <_ZN10LinkedList6removeEP4proc+0xb0>
	link->next = freeLinks;
8010504d:	8b 15 04 c6 10 80    	mov    0x8010c604,%edx
	freeLinks = link;
80105053:	a3 04 c6 10 80       	mov    %eax,0x8010c604
	link->next = freeLinks;
80105058:	89 50 04             	mov    %edx,0x4(%eax)
			return true;
8010505b:	b0 01                	mov    $0x1,%al
}
8010505d:	5b                   	pop    %ebx
8010505e:	5e                   	pop    %esi
8010505f:	5d                   	pop    %ebp
80105060:	c3                   	ret    
80105061:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	link->next = freeLinks;
80105068:	a1 04 c6 10 80       	mov    0x8010c604,%eax
	if(isEmpty())
8010506d:	85 d2                	test   %edx,%edx
	freeLinks = link;
8010506f:	89 1d 04 c6 10 80    	mov    %ebx,0x8010c604
	link->next = freeLinks;
80105075:	89 43 04             	mov    %eax,0x4(%ebx)
		return true;
80105078:	b0 01                	mov    $0x1,%al
	first = next;
8010507a:	89 16                	mov    %edx,(%esi)
	if(isEmpty())
8010507c:	75 97                	jne    80105015 <_ZN10LinkedList6removeEP4proc+0x35>
		last = null;
8010507e:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%esi)
80105085:	eb 8e                	jmp    80105015 <_ZN10LinkedList6removeEP4proc+0x35>
80105087:	89 f6                	mov    %esi,%esi
80105089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
				last = prev;
80105090:	89 56 04             	mov    %edx,0x4(%esi)
80105093:	eb b8                	jmp    8010504d <_ZN10LinkedList6removeEP4proc+0x6d>
80105095:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801050a0 <removeRunningProcessHolder>:
static boolean removeRunningProcessHolder(Proc* p) {
801050a0:	55                   	push   %ebp
801050a1:	89 e5                	mov    %esp,%ebp
801050a3:	83 ec 08             	sub    $0x8,%esp
	return runningProcHolder->remove(p);
801050a6:	8b 45 08             	mov    0x8(%ebp),%eax
801050a9:	89 44 24 04          	mov    %eax,0x4(%esp)
801050ad:	a1 08 c6 10 80       	mov    0x8010c608,%eax
801050b2:	89 04 24             	mov    %eax,(%esp)
801050b5:	e8 26 ff ff ff       	call   80104fe0 <_ZN10LinkedList6removeEP4proc>
}
801050ba:	c9                   	leave  
	return runningProcHolder->remove(p);
801050bb:	0f b6 c0             	movzbl %al,%eax
}
801050be:	c3                   	ret    
801050bf:	90                   	nop

801050c0 <_ZN10LinkedList8transferEv>:
	if(!priorityQ->isEmpty())
801050c0:	8b 15 10 c6 10 80    	mov    0x8010c610,%edx
		return false;
801050c6:	31 c0                	xor    %eax,%eax
bool LinkedList::transfer() {
801050c8:	55                   	push   %ebp
801050c9:	89 e5                	mov    %esp,%ebp
801050cb:	53                   	push   %ebx
801050cc:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!priorityQ->isEmpty())
801050cf:	8b 1a                	mov    (%edx),%ebx
801050d1:	85 db                	test   %ebx,%ebx
801050d3:	74 0b                	je     801050e0 <_ZN10LinkedList8transferEv+0x20>
}
801050d5:	5b                   	pop    %ebx
801050d6:	5d                   	pop    %ebp
801050d7:	c3                   	ret    
801050d8:	90                   	nop
801050d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	if(!isEmpty()) {
801050e0:	8b 19                	mov    (%ecx),%ebx
801050e2:	85 db                	test   %ebx,%ebx
801050e4:	74 4a                	je     80105130 <_ZN10LinkedList8transferEv+0x70>
	if(!freeNodes)
801050e6:	8b 1d 00 c6 10 80    	mov    0x8010c600,%ebx
801050ec:	85 db                	test   %ebx,%ebx
801050ee:	74 e5                	je     801050d5 <_ZN10LinkedList8transferEv+0x15>
	freeNodes = freeNodes->next;
801050f0:	8b 43 10             	mov    0x10(%ebx),%eax
	ans->key = key;
801050f3:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
	ans->next = null;
801050f9:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
	ans->key = key;
80105100:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
	freeNodes = freeNodes->next;
80105107:	a3 00 c6 10 80       	mov    %eax,0x8010c600
		node->listOfProcs.first = first;
8010510c:	8b 01                	mov    (%ecx),%eax
8010510e:	89 43 08             	mov    %eax,0x8(%ebx)
		node->listOfProcs.last = last;
80105111:	8b 41 04             	mov    0x4(%ecx),%eax
80105114:	89 43 0c             	mov    %eax,0xc(%ebx)
	return true;
80105117:	b0 01                	mov    $0x1,%al
		first = last = null;
80105119:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
80105120:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
		priorityQ->root = node;
80105126:	89 1a                	mov    %ebx,(%edx)
}
80105128:	5b                   	pop    %ebx
80105129:	5d                   	pop    %ebp
8010512a:	c3                   	ret    
8010512b:	90                   	nop
8010512c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	return true;
80105130:	b0 01                	mov    $0x1,%al
80105132:	eb a1                	jmp    801050d5 <_ZN10LinkedList8transferEv+0x15>
80105134:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010513a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105140 <switchToPriorityQueuePolicyRoundRobinQueue>:
static boolean switchToPriorityQueuePolicyRoundRobinQueue() {
80105140:	55                   	push   %ebp
80105141:	89 e5                	mov    %esp,%ebp
80105143:	83 ec 04             	sub    $0x4,%esp
	return roundRobinQ->transfer();
80105146:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
8010514b:	89 04 24             	mov    %eax,(%esp)
8010514e:	e8 6d ff ff ff       	call   801050c0 <_ZN10LinkedList8transferEv>
}
80105153:	c9                   	leave  
	return roundRobinQ->transfer();
80105154:	0f b6 c0             	movzbl %al,%eax
}
80105157:	c3                   	ret    
80105158:	90                   	nop
80105159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105160 <_ZN10LinkedList9getMinKeyEPx>:
bool LinkedList::getMinKey(long long *pkey) {
80105160:	55                   	push   %ebp
80105161:	31 c0                	xor    %eax,%eax
80105163:	89 e5                	mov    %esp,%ebp
80105165:	57                   	push   %edi
80105166:	56                   	push   %esi
80105167:	53                   	push   %ebx
80105168:	83 ec 1c             	sub    $0x1c,%esp
8010516b:	8b 7d 08             	mov    0x8(%ebp),%edi
	return !first;
8010516e:	8b 17                	mov    (%edi),%edx
	if(isEmpty())
80105170:	85 d2                	test   %edx,%edx
80105172:	74 41                	je     801051b5 <_ZN10LinkedList9getMinKeyEPx+0x55>
	long long minKey = getAccumulator(first->p);
80105174:	8b 02                	mov    (%edx),%eax
80105176:	89 04 24             	mov    %eax,(%esp)
80105179:	e8 42 e7 ff ff       	call   801038c0 <getAccumulator>
	forEach([&](Proc *p) {
8010517e:	8b 3f                	mov    (%edi),%edi
	void append(Link *link); //appends the given list to the queue. No allocations always succeeds.
	
	template<typename Func>
	void forEach(const Func& accept) { //for-each loop. gets a function that applies the procin each link node.
		Link *link = first;
		while(link) {
80105180:	85 ff                	test   %edi,%edi
	long long minKey = getAccumulator(first->p);
80105182:	89 c6                	mov    %eax,%esi
80105184:	89 d3                	mov    %edx,%ebx
80105186:	74 23                	je     801051ab <_ZN10LinkedList9getMinKeyEPx+0x4b>
80105188:	90                   	nop
80105189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		long long key = getAccumulator(p);
80105190:	8b 07                	mov    (%edi),%eax
80105192:	89 04 24             	mov    %eax,(%esp)
80105195:	e8 26 e7 ff ff       	call   801038c0 <getAccumulator>
8010519a:	39 d3                	cmp    %edx,%ebx
8010519c:	7c 06                	jl     801051a4 <_ZN10LinkedList9getMinKeyEPx+0x44>
8010519e:	7f 20                	jg     801051c0 <_ZN10LinkedList9getMinKeyEPx+0x60>
801051a0:	39 c6                	cmp    %eax,%esi
801051a2:	77 1c                	ja     801051c0 <_ZN10LinkedList9getMinKeyEPx+0x60>
			accept(link->p);
			link = link->next;
801051a4:	8b 7f 04             	mov    0x4(%edi),%edi
		while(link) {
801051a7:	85 ff                	test   %edi,%edi
801051a9:	75 e5                	jne    80105190 <_ZN10LinkedList9getMinKeyEPx+0x30>
	*pkey = minKey;
801051ab:	8b 45 0c             	mov    0xc(%ebp),%eax
801051ae:	89 30                	mov    %esi,(%eax)
801051b0:	89 58 04             	mov    %ebx,0x4(%eax)
	return true;
801051b3:	b0 01                	mov    $0x1,%al
}
801051b5:	83 c4 1c             	add    $0x1c,%esp
801051b8:	5b                   	pop    %ebx
801051b9:	5e                   	pop    %esi
801051ba:	5f                   	pop    %edi
801051bb:	5d                   	pop    %ebp
801051bc:	c3                   	ret    
801051bd:	8d 76 00             	lea    0x0(%esi),%esi
			link = link->next;
801051c0:	8b 7f 04             	mov    0x4(%edi),%edi
801051c3:	89 c6                	mov    %eax,%esi
801051c5:	89 d3                	mov    %edx,%ebx
		while(link) {
801051c7:	85 ff                	test   %edi,%edi
801051c9:	75 c5                	jne    80105190 <_ZN10LinkedList9getMinKeyEPx+0x30>
801051cb:	eb de                	jmp    801051ab <_ZN10LinkedList9getMinKeyEPx+0x4b>
801051cd:	8d 76 00             	lea    0x0(%esi),%esi

801051d0 <getMinAccumulatorRunningProcessHolder>:
static boolean getMinAccumulatorRunningProcessHolder(long long *pkey) {
801051d0:	55                   	push   %ebp
801051d1:	89 e5                	mov    %esp,%ebp
801051d3:	83 ec 18             	sub    $0x18,%esp
	return runningProcHolder->getMinKey(pkey);
801051d6:	8b 45 08             	mov    0x8(%ebp),%eax
801051d9:	89 44 24 04          	mov    %eax,0x4(%esp)
801051dd:	a1 08 c6 10 80       	mov    0x8010c608,%eax
801051e2:	89 04 24             	mov    %eax,(%esp)
801051e5:	e8 76 ff ff ff       	call   80105160 <_ZN10LinkedList9getMinKeyEPx>
}
801051ea:	c9                   	leave  
	return runningProcHolder->getMinKey(pkey);
801051eb:	0f b6 c0             	movzbl %al,%eax
}
801051ee:	c3                   	ret    
801051ef:	90                   	nop

801051f0 <_ZN7MapNode7isEmptyEv>:
bool MapNode::isEmpty() {
801051f0:	55                   	push   %ebp
801051f1:	89 e5                	mov    %esp,%ebp
	return !first;
801051f3:	8b 45 08             	mov    0x8(%ebp),%eax
}
801051f6:	5d                   	pop    %ebp
	return !first;
801051f7:	8b 40 08             	mov    0x8(%eax),%eax
801051fa:	85 c0                	test   %eax,%eax
801051fc:	0f 94 c0             	sete   %al
}
801051ff:	c3                   	ret    

80105200 <_ZN7MapNode3putEP4proc>:
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
80105200:	55                   	push   %ebp
80105201:	89 e5                	mov    %esp,%ebp
80105203:	57                   	push   %edi
80105204:	56                   	push   %esi
80105205:	53                   	push   %ebx
80105206:	83 ec 2c             	sub    $0x2c,%esp
	long long key = getAccumulator(p);
80105209:	8b 45 0c             	mov    0xc(%ebp),%eax
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
8010520c:	8b 5d 08             	mov    0x8(%ebp),%ebx
	long long key = getAccumulator(p);
8010520f:	89 04 24             	mov    %eax,(%esp)
80105212:	e8 a9 e6 ff ff       	call   801038c0 <getAccumulator>
80105217:	89 d1                	mov    %edx,%ecx
80105219:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010521c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		if(key == node->key)
80105220:	8b 13                	mov    (%ebx),%edx
80105222:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80105225:	8b 43 04             	mov    0x4(%ebx),%eax
80105228:	31 d7                	xor    %edx,%edi
8010522a:	89 fe                	mov    %edi,%esi
8010522c:	89 c7                	mov    %eax,%edi
8010522e:	31 cf                	xor    %ecx,%edi
80105230:	09 fe                	or     %edi,%esi
80105232:	74 4c                	je     80105280 <_ZN7MapNode3putEP4proc+0x80>
		else if(key < node->key) { //left
80105234:	39 c8                	cmp    %ecx,%eax
80105236:	7c 20                	jl     80105258 <_ZN7MapNode3putEP4proc+0x58>
80105238:	7f 08                	jg     80105242 <_ZN7MapNode3putEP4proc+0x42>
8010523a:	3b 55 e4             	cmp    -0x1c(%ebp),%edx
8010523d:	8d 76 00             	lea    0x0(%esi),%esi
80105240:	76 16                	jbe    80105258 <_ZN7MapNode3putEP4proc+0x58>
			if(node->left)
80105242:	8b 43 18             	mov    0x18(%ebx),%eax
80105245:	85 c0                	test   %eax,%eax
80105247:	0f 84 83 00 00 00    	je     801052d0 <_ZN7MapNode3putEP4proc+0xd0>
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
8010524d:	89 c3                	mov    %eax,%ebx
8010524f:	eb cf                	jmp    80105220 <_ZN7MapNode3putEP4proc+0x20>
80105251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			if(node->right)
80105258:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010525b:	85 c0                	test   %eax,%eax
8010525d:	75 ee                	jne    8010524d <_ZN7MapNode3putEP4proc+0x4d>
8010525f:	8b 75 e4             	mov    -0x1c(%ebp),%esi
				node->right = allocNode(p, key);
80105262:	8b 45 0c             	mov    0xc(%ebp),%eax
80105265:	89 f2                	mov    %esi,%edx
80105267:	e8 e4 f9 ff ff       	call   80104c50 <_ZL9allocNodeP4procx>
				if(node->right) {
8010526c:	85 c0                	test   %eax,%eax
				node->right = allocNode(p, key);
8010526e:	89 43 1c             	mov    %eax,0x1c(%ebx)
				if(node->right) {
80105271:	74 71                	je     801052e4 <_ZN7MapNode3putEP4proc+0xe4>
					node->right->parent = node;
80105273:	89 58 14             	mov    %ebx,0x14(%eax)
}
80105276:	83 c4 2c             	add    $0x2c,%esp
					return true;
80105279:	b0 01                	mov    $0x1,%al
}
8010527b:	5b                   	pop    %ebx
8010527c:	5e                   	pop    %esi
8010527d:	5f                   	pop    %edi
8010527e:	5d                   	pop    %ebp
8010527f:	c3                   	ret    
	if(!freeLinks)
80105280:	a1 04 c6 10 80       	mov    0x8010c604,%eax
80105285:	85 c0                	test   %eax,%eax
80105287:	74 5b                	je     801052e4 <_ZN7MapNode3putEP4proc+0xe4>
	ans->p = p;
80105289:	8b 75 0c             	mov    0xc(%ebp),%esi
	freeLinks = freeLinks->next;
8010528c:	8b 50 04             	mov    0x4(%eax),%edx
	ans->next = null;
8010528f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	ans->p = p;
80105296:	89 30                	mov    %esi,(%eax)
	freeLinks = freeLinks->next;
80105298:	89 15 04 c6 10 80    	mov    %edx,0x8010c604
	if(isEmpty()) first = link;
8010529e:	8b 53 08             	mov    0x8(%ebx),%edx
801052a1:	85 d2                	test   %edx,%edx
801052a3:	74 4b                	je     801052f0 <_ZN7MapNode3putEP4proc+0xf0>
	else last->next = link;
801052a5:	8b 53 0c             	mov    0xc(%ebx),%edx
801052a8:	89 42 04             	mov    %eax,0x4(%edx)
801052ab:	eb 05                	jmp    801052b2 <_ZN7MapNode3putEP4proc+0xb2>
801052ad:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
801052b0:	89 d0                	mov    %edx,%eax
801052b2:	8b 50 04             	mov    0x4(%eax),%edx
801052b5:	85 d2                	test   %edx,%edx
801052b7:	75 f7                	jne    801052b0 <_ZN7MapNode3putEP4proc+0xb0>
	last = link->getLast();
801052b9:	89 43 0c             	mov    %eax,0xc(%ebx)
}
801052bc:	83 c4 2c             	add    $0x2c,%esp
	return true;
801052bf:	b0 01                	mov    $0x1,%al
}
801052c1:	5b                   	pop    %ebx
801052c2:	5e                   	pop    %esi
801052c3:	5f                   	pop    %edi
801052c4:	5d                   	pop    %ebp
801052c5:	c3                   	ret    
801052c6:	8d 76 00             	lea    0x0(%esi),%esi
801052c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801052d0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
				node->left = allocNode(p, key);
801052d3:	8b 45 0c             	mov    0xc(%ebp),%eax
801052d6:	89 f2                	mov    %esi,%edx
801052d8:	e8 73 f9 ff ff       	call   80104c50 <_ZL9allocNodeP4procx>
				if(node->left) {
801052dd:	85 c0                	test   %eax,%eax
				node->left = allocNode(p, key);
801052df:	89 43 18             	mov    %eax,0x18(%ebx)
				if(node->left) {
801052e2:	75 8f                	jne    80105273 <_ZN7MapNode3putEP4proc+0x73>
}
801052e4:	83 c4 2c             	add    $0x2c,%esp
		return false;
801052e7:	31 c0                	xor    %eax,%eax
}
801052e9:	5b                   	pop    %ebx
801052ea:	5e                   	pop    %esi
801052eb:	5f                   	pop    %edi
801052ec:	5d                   	pop    %ebp
801052ed:	c3                   	ret    
801052ee:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
801052f0:	89 43 08             	mov    %eax,0x8(%ebx)
801052f3:	eb bd                	jmp    801052b2 <_ZN7MapNode3putEP4proc+0xb2>
801052f5:	90                   	nop
801052f6:	8d 76 00             	lea    0x0(%esi),%esi
801052f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105300 <_ZN7MapNode10getMinNodeEv>:
MapNode* MapNode::getMinNode() { //no recursion.
80105300:	55                   	push   %ebp
80105301:	89 e5                	mov    %esp,%ebp
80105303:	8b 45 08             	mov    0x8(%ebp),%eax
80105306:	eb 0a                	jmp    80105312 <_ZN7MapNode10getMinNodeEv+0x12>
80105308:	90                   	nop
80105309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105310:	89 d0                	mov    %edx,%eax
	while(minNode->left)
80105312:	8b 50 18             	mov    0x18(%eax),%edx
80105315:	85 d2                	test   %edx,%edx
80105317:	75 f7                	jne    80105310 <_ZN7MapNode10getMinNodeEv+0x10>
}
80105319:	5d                   	pop    %ebp
8010531a:	c3                   	ret    
8010531b:	90                   	nop
8010531c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105320 <_ZN7MapNode9getMinKeyEPx>:
void MapNode::getMinKey(long long *pkey) {
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	8b 55 08             	mov    0x8(%ebp),%edx
80105326:	53                   	push   %ebx
80105327:	eb 09                	jmp    80105332 <_ZN7MapNode9getMinKeyEPx+0x12>
80105329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	while(minNode->left)
80105330:	89 c2                	mov    %eax,%edx
80105332:	8b 42 18             	mov    0x18(%edx),%eax
80105335:	85 c0                	test   %eax,%eax
80105337:	75 f7                	jne    80105330 <_ZN7MapNode9getMinKeyEPx+0x10>
	*pkey = getMinNode()->key;
80105339:	8b 5a 04             	mov    0x4(%edx),%ebx
8010533c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010533f:	8b 0a                	mov    (%edx),%ecx
80105341:	89 58 04             	mov    %ebx,0x4(%eax)
80105344:	89 08                	mov    %ecx,(%eax)
}
80105346:	5b                   	pop    %ebx
80105347:	5d                   	pop    %ebp
80105348:	c3                   	ret    
80105349:	90                   	nop
8010534a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105350 <_ZN7MapNode7dequeueEv>:
Proc* MapNode::dequeue() {
80105350:	55                   	push   %ebp
80105351:	89 e5                	mov    %esp,%ebp
80105353:	83 ec 08             	sub    $0x8,%esp
80105356:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105359:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010535c:	89 75 fc             	mov    %esi,-0x4(%ebp)
	return !first;
8010535f:	8b 51 08             	mov    0x8(%ecx),%edx
	if(isEmpty())
80105362:	85 d2                	test   %edx,%edx
80105364:	74 32                	je     80105398 <_ZN7MapNode7dequeueEv+0x48>
	Link *next = first->next;
80105366:	8b 5a 04             	mov    0x4(%edx),%ebx
	link->next = freeLinks;
80105369:	8b 35 04 c6 10 80    	mov    0x8010c604,%esi
	Proc *p = first->p;
8010536f:	8b 02                	mov    (%edx),%eax
	freeLinks = link;
80105371:	89 15 04 c6 10 80    	mov    %edx,0x8010c604
	if(isEmpty())
80105377:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
80105379:	89 72 04             	mov    %esi,0x4(%edx)
	first = next;
8010537c:	89 59 08             	mov    %ebx,0x8(%ecx)
	if(isEmpty())
8010537f:	75 07                	jne    80105388 <_ZN7MapNode7dequeueEv+0x38>
		last = null;
80105381:	c7 41 0c 00 00 00 00 	movl   $0x0,0xc(%ecx)
}
80105388:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010538b:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010538e:	89 ec                	mov    %ebp,%esp
80105390:	5d                   	pop    %ebp
80105391:	c3                   	ret    
80105392:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		return null;
80105398:	31 c0                	xor    %eax,%eax
	return listOfProcs.dequeue();
8010539a:	eb ec                	jmp    80105388 <_ZN7MapNode7dequeueEv+0x38>
8010539c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053a0 <_ZN3Map7isEmptyEv>:
bool Map::isEmpty() {
801053a0:	55                   	push   %ebp
801053a1:	89 e5                	mov    %esp,%ebp
	return !root;
801053a3:	8b 45 08             	mov    0x8(%ebp),%eax
}
801053a6:	5d                   	pop    %ebp
	return !root;
801053a7:	8b 00                	mov    (%eax),%eax
801053a9:	85 c0                	test   %eax,%eax
801053ab:	0f 94 c0             	sete   %al
}
801053ae:	c3                   	ret    
801053af:	90                   	nop

801053b0 <_ZN3Map3putEP4proc>:
bool Map::put(Proc *p) {
801053b0:	55                   	push   %ebp
801053b1:	89 e5                	mov    %esp,%ebp
801053b3:	83 ec 18             	sub    $0x18,%esp
801053b6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801053b9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801053bc:	89 75 fc             	mov    %esi,-0x4(%ebp)
801053bf:	8b 75 08             	mov    0x8(%ebp),%esi
	long long key = getAccumulator(p);
801053c2:	89 1c 24             	mov    %ebx,(%esp)
801053c5:	e8 f6 e4 ff ff       	call   801038c0 <getAccumulator>
	return !root;
801053ca:	8b 0e                	mov    (%esi),%ecx
	if(isEmpty()) {
801053cc:	85 c9                	test   %ecx,%ecx
801053ce:	74 18                	je     801053e8 <_ZN3Map3putEP4proc+0x38>
	return root->put(p);
801053d0:	89 5d 0c             	mov    %ebx,0xc(%ebp)
}
801053d3:	8b 75 fc             	mov    -0x4(%ebp),%esi
	return root->put(p);
801053d6:	89 4d 08             	mov    %ecx,0x8(%ebp)
}
801053d9:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801053dc:	89 ec                	mov    %ebp,%esp
801053de:	5d                   	pop    %ebp
	return root->put(p);
801053df:	e9 1c fe ff ff       	jmp    80105200 <_ZN7MapNode3putEP4proc>
801053e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		root = allocNode(p, key);
801053e8:	89 d1                	mov    %edx,%ecx
801053ea:	89 c2                	mov    %eax,%edx
801053ec:	89 d8                	mov    %ebx,%eax
801053ee:	e8 5d f8 ff ff       	call   80104c50 <_ZL9allocNodeP4procx>
801053f3:	89 06                	mov    %eax,(%esi)
		return !isEmpty();
801053f5:	85 c0                	test   %eax,%eax
801053f7:	0f 95 c0             	setne  %al
}
801053fa:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801053fd:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105400:	89 ec                	mov    %ebp,%esp
80105402:	5d                   	pop    %ebp
80105403:	c3                   	ret    
80105404:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010540a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105410 <putPriorityQueue>:
static boolean putPriorityQueue(Proc* p) {
80105410:	55                   	push   %ebp
80105411:	89 e5                	mov    %esp,%ebp
80105413:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->put(p);
80105416:	8b 45 08             	mov    0x8(%ebp),%eax
80105419:	89 44 24 04          	mov    %eax,0x4(%esp)
8010541d:	a1 10 c6 10 80       	mov    0x8010c610,%eax
80105422:	89 04 24             	mov    %eax,(%esp)
80105425:	e8 86 ff ff ff       	call   801053b0 <_ZN3Map3putEP4proc>
}
8010542a:	c9                   	leave  
	return priorityQ->put(p);
8010542b:	0f b6 c0             	movzbl %al,%eax
}
8010542e:	c3                   	ret    
8010542f:	90                   	nop

80105430 <_ZN3Map9getMinKeyEPx>:
bool Map::getMinKey(long long *pkey) {
80105430:	55                   	push   %ebp
80105431:	89 e5                	mov    %esp,%ebp
	return !root;
80105433:	8b 45 08             	mov    0x8(%ebp),%eax
bool Map::getMinKey(long long *pkey) {
80105436:	53                   	push   %ebx
	return !root;
80105437:	8b 10                	mov    (%eax),%edx
	if(isEmpty())
80105439:	85 d2                	test   %edx,%edx
8010543b:	75 05                	jne    80105442 <_ZN3Map9getMinKeyEPx+0x12>
8010543d:	eb 21                	jmp    80105460 <_ZN3Map9getMinKeyEPx+0x30>
8010543f:	90                   	nop
	while(minNode->left)
80105440:	89 c2                	mov    %eax,%edx
80105442:	8b 42 18             	mov    0x18(%edx),%eax
80105445:	85 c0                	test   %eax,%eax
80105447:	75 f7                	jne    80105440 <_ZN3Map9getMinKeyEPx+0x10>
	*pkey = getMinNode()->key;
80105449:	8b 45 0c             	mov    0xc(%ebp),%eax
8010544c:	8b 5a 04             	mov    0x4(%edx),%ebx
8010544f:	8b 0a                	mov    (%edx),%ecx
80105451:	89 58 04             	mov    %ebx,0x4(%eax)
80105454:	89 08                	mov    %ecx,(%eax)
		return false;

	root->getMinKey(pkey);
	return true;
80105456:	b0 01                	mov    $0x1,%al
}
80105458:	5b                   	pop    %ebx
80105459:	5d                   	pop    %ebp
8010545a:	c3                   	ret    
8010545b:	90                   	nop
8010545c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105460:	5b                   	pop    %ebx
		return false;
80105461:	31 c0                	xor    %eax,%eax
}
80105463:	5d                   	pop    %ebp
80105464:	c3                   	ret    
80105465:	90                   	nop
80105466:	8d 76 00             	lea    0x0(%esi),%esi
80105469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105470 <_ZN3Map10extractMinEv>:

Proc* Map::extractMin() {
80105470:	55                   	push   %ebp
80105471:	89 e5                	mov    %esp,%ebp
80105473:	57                   	push   %edi
80105474:	56                   	push   %esi
80105475:	8b 75 08             	mov    0x8(%ebp),%esi
80105478:	53                   	push   %ebx
	return !root;
80105479:	8b 1e                	mov    (%esi),%ebx
	if(isEmpty())
8010547b:	85 db                	test   %ebx,%ebx
8010547d:	0f 84 a5 00 00 00    	je     80105528 <_ZN3Map10extractMinEv+0xb8>
80105483:	89 da                	mov    %ebx,%edx
80105485:	eb 0b                	jmp    80105492 <_ZN3Map10extractMinEv+0x22>
80105487:	89 f6                	mov    %esi,%esi
80105489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	while(minNode->left)
80105490:	89 c2                	mov    %eax,%edx
80105492:	8b 42 18             	mov    0x18(%edx),%eax
80105495:	85 c0                	test   %eax,%eax
80105497:	75 f7                	jne    80105490 <_ZN3Map10extractMinEv+0x20>
	return !first;
80105499:	8b 4a 08             	mov    0x8(%edx),%ecx
	if(isEmpty())
8010549c:	85 c9                	test   %ecx,%ecx
8010549e:	74 70                	je     80105510 <_ZN3Map10extractMinEv+0xa0>
	Link *next = first->next;
801054a0:	8b 59 04             	mov    0x4(%ecx),%ebx
	link->next = freeLinks;
801054a3:	8b 3d 04 c6 10 80    	mov    0x8010c604,%edi
	Proc *p = first->p;
801054a9:	8b 01                	mov    (%ecx),%eax
	freeLinks = link;
801054ab:	89 0d 04 c6 10 80    	mov    %ecx,0x8010c604
	if(isEmpty())
801054b1:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
801054b3:	89 79 04             	mov    %edi,0x4(%ecx)
	first = next;
801054b6:	89 5a 08             	mov    %ebx,0x8(%edx)
	if(isEmpty())
801054b9:	74 05                	je     801054c0 <_ZN3Map10extractMinEv+0x50>
		}
		deallocNode(minNode);
	}

	return p;
}
801054bb:	5b                   	pop    %ebx
801054bc:	5e                   	pop    %esi
801054bd:	5f                   	pop    %edi
801054be:	5d                   	pop    %ebp
801054bf:	c3                   	ret    
		last = null;
801054c0:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
801054c7:	8b 4a 1c             	mov    0x1c(%edx),%ecx
801054ca:	8b 1e                	mov    (%esi),%ebx
		if(minNode == root) {
801054cc:	39 da                	cmp    %ebx,%edx
801054ce:	74 49                	je     80105519 <_ZN3Map10extractMinEv+0xa9>
			MapNode *parent = minNode->parent;
801054d0:	8b 5a 14             	mov    0x14(%edx),%ebx
			parent->left = minNode->right;
801054d3:	89 4b 18             	mov    %ecx,0x18(%ebx)
			if(minNode->right)
801054d6:	8b 4a 1c             	mov    0x1c(%edx),%ecx
801054d9:	85 c9                	test   %ecx,%ecx
801054db:	74 03                	je     801054e0 <_ZN3Map10extractMinEv+0x70>
				minNode->right->parent = parent;
801054dd:	89 59 14             	mov    %ebx,0x14(%ecx)
	node->next = freeNodes;
801054e0:	8b 0d 00 c6 10 80    	mov    0x8010c600,%ecx
	node->parent = node->left = node->right = null;
801054e6:	c7 42 1c 00 00 00 00 	movl   $0x0,0x1c(%edx)
801054ed:	c7 42 18 00 00 00 00 	movl   $0x0,0x18(%edx)
801054f4:	c7 42 14 00 00 00 00 	movl   $0x0,0x14(%edx)
	node->next = freeNodes;
801054fb:	89 4a 10             	mov    %ecx,0x10(%edx)
}
801054fe:	5b                   	pop    %ebx
	freeNodes = node;
801054ff:	89 15 00 c6 10 80    	mov    %edx,0x8010c600
}
80105505:	5e                   	pop    %esi
80105506:	5f                   	pop    %edi
80105507:	5d                   	pop    %ebp
80105508:	c3                   	ret    
80105509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return null;
80105510:	31 c0                	xor    %eax,%eax
		if(minNode == root) {
80105512:	39 da                	cmp    %ebx,%edx
80105514:	8b 4a 1c             	mov    0x1c(%edx),%ecx
80105517:	75 b7                	jne    801054d0 <_ZN3Map10extractMinEv+0x60>
			if(!isEmpty())
80105519:	85 c9                	test   %ecx,%ecx
			root = minNode->right;
8010551b:	89 0e                	mov    %ecx,(%esi)
			if(!isEmpty())
8010551d:	74 c1                	je     801054e0 <_ZN3Map10extractMinEv+0x70>
				root->parent = null;
8010551f:	c7 41 14 00 00 00 00 	movl   $0x0,0x14(%ecx)
80105526:	eb b8                	jmp    801054e0 <_ZN3Map10extractMinEv+0x70>
		return null;
80105528:	31 c0                	xor    %eax,%eax
8010552a:	eb 8f                	jmp    801054bb <_ZN3Map10extractMinEv+0x4b>
8010552c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105530 <extractMinPriorityQueue>:
static Proc* extractMinPriorityQueue() {
80105530:	55                   	push   %ebp
80105531:	89 e5                	mov    %esp,%ebp
80105533:	83 ec 04             	sub    $0x4,%esp
	return priorityQ->extractMin();
80105536:	a1 10 c6 10 80       	mov    0x8010c610,%eax
8010553b:	89 04 24             	mov    %eax,(%esp)
8010553e:	e8 2d ff ff ff       	call   80105470 <_ZN3Map10extractMinEv>
}
80105543:	c9                   	leave  
80105544:	c3                   	ret    
80105545:	90                   	nop
80105546:	8d 76 00             	lea    0x0(%esi),%esi
80105549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105550 <_ZN3Map8transferEv.part.1>:

bool Map::transfer() {
80105550:	55                   	push   %ebp
80105551:	89 e5                	mov    %esp,%ebp
80105553:	56                   	push   %esi
80105554:	53                   	push   %ebx
80105555:	89 c3                	mov    %eax,%ebx
80105557:	83 ec 04             	sub    $0x4,%esp
8010555a:	eb 16                	jmp    80105572 <_ZN3Map8transferEv.part.1+0x22>
8010555c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!roundRobinQ->isEmpty())
		return false;

	while(!isEmpty()) {
		Proc* p = extractMin();
80105560:	89 1c 24             	mov    %ebx,(%esp)
80105563:	e8 08 ff ff ff       	call   80105470 <_ZN3Map10extractMinEv>
	if(!freeLinks)
80105568:	8b 15 04 c6 10 80    	mov    0x8010c604,%edx
8010556e:	85 d2                	test   %edx,%edx
80105570:	75 0e                	jne    80105580 <_ZN3Map8transferEv.part.1+0x30>
	while(!isEmpty()) {
80105572:	8b 03                	mov    (%ebx),%eax
80105574:	85 c0                	test   %eax,%eax
80105576:	75 e8                	jne    80105560 <_ZN3Map8transferEv.part.1+0x10>
		roundRobinQ->enqueue(p); //should succeed.
	}

	return true;
}
80105578:	5a                   	pop    %edx
80105579:	b0 01                	mov    $0x1,%al
8010557b:	5b                   	pop    %ebx
8010557c:	5e                   	pop    %esi
8010557d:	5d                   	pop    %ebp
8010557e:	c3                   	ret    
8010557f:	90                   	nop
	freeLinks = freeLinks->next;
80105580:	8b 72 04             	mov    0x4(%edx),%esi
		roundRobinQ->enqueue(p); //should succeed.
80105583:	8b 0d 0c c6 10 80    	mov    0x8010c60c,%ecx
	ans->next = null;
80105589:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
	ans->p = p;
80105590:	89 02                	mov    %eax,(%edx)
	freeLinks = freeLinks->next;
80105592:	89 35 04 c6 10 80    	mov    %esi,0x8010c604
	if(isEmpty()) first = link;
80105598:	8b 31                	mov    (%ecx),%esi
8010559a:	85 f6                	test   %esi,%esi
8010559c:	74 22                	je     801055c0 <_ZN3Map8transferEv.part.1+0x70>
	else last->next = link;
8010559e:	8b 41 04             	mov    0x4(%ecx),%eax
801055a1:	89 50 04             	mov    %edx,0x4(%eax)
801055a4:	eb 0c                	jmp    801055b2 <_ZN3Map8transferEv.part.1+0x62>
801055a6:	8d 76 00             	lea    0x0(%esi),%esi
801055a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	while(ans->next)
801055b0:	89 c2                	mov    %eax,%edx
801055b2:	8b 42 04             	mov    0x4(%edx),%eax
801055b5:	85 c0                	test   %eax,%eax
801055b7:	75 f7                	jne    801055b0 <_ZN3Map8transferEv.part.1+0x60>
	last = link->getLast();
801055b9:	89 51 04             	mov    %edx,0x4(%ecx)
801055bc:	eb b4                	jmp    80105572 <_ZN3Map8transferEv.part.1+0x22>
801055be:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
801055c0:	89 11                	mov    %edx,(%ecx)
801055c2:	eb ee                	jmp    801055b2 <_ZN3Map8transferEv.part.1+0x62>
801055c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801055ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801055d0 <switchToRoundRobinPolicyPriorityQueue>:
	if(!roundRobinQ->isEmpty())
801055d0:	8b 15 0c c6 10 80    	mov    0x8010c60c,%edx
801055d6:	8b 02                	mov    (%edx),%eax
801055d8:	85 c0                	test   %eax,%eax
801055da:	74 04                	je     801055e0 <switchToRoundRobinPolicyPriorityQueue+0x10>
801055dc:	31 c0                	xor    %eax,%eax
}
801055de:	c3                   	ret    
801055df:	90                   	nop
801055e0:	a1 10 c6 10 80       	mov    0x8010c610,%eax
static boolean switchToRoundRobinPolicyPriorityQueue() {
801055e5:	55                   	push   %ebp
801055e6:	89 e5                	mov    %esp,%ebp
801055e8:	e8 63 ff ff ff       	call   80105550 <_ZN3Map8transferEv.part.1>
}
801055ed:	5d                   	pop    %ebp
801055ee:	0f b6 c0             	movzbl %al,%eax
801055f1:	c3                   	ret    
801055f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801055f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105600 <_ZN3Map8transferEv>:
	return !first;
80105600:	8b 15 0c c6 10 80    	mov    0x8010c60c,%edx
bool Map::transfer() {
80105606:	55                   	push   %ebp
80105607:	89 e5                	mov    %esp,%ebp
80105609:	8b 45 08             	mov    0x8(%ebp),%eax
	if(!roundRobinQ->isEmpty())
8010560c:	8b 12                	mov    (%edx),%edx
8010560e:	85 d2                	test   %edx,%edx
80105610:	74 0e                	je     80105620 <_ZN3Map8transferEv+0x20>
}
80105612:	31 c0                	xor    %eax,%eax
80105614:	5d                   	pop    %ebp
80105615:	c3                   	ret    
80105616:	8d 76 00             	lea    0x0(%esi),%esi
80105619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105620:	5d                   	pop    %ebp
80105621:	e9 2a ff ff ff       	jmp    80105550 <_ZN3Map8transferEv.part.1>
80105626:	8d 76 00             	lea    0x0(%esi),%esi
80105629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105630 <_ZN3Map11extractProcEP4proc>:

bool Map::extractProc(Proc *p) {
80105630:	55                   	push   %ebp
80105631:	89 e5                	mov    %esp,%ebp
80105633:	56                   	push   %esi
80105634:	53                   	push   %ebx
80105635:	83 ec 30             	sub    $0x30,%esp
	if(!freeNodes)
80105638:	8b 15 00 c6 10 80    	mov    0x8010c600,%edx
bool Map::extractProc(Proc *p) {
8010563e:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105641:	8b 75 0c             	mov    0xc(%ebp),%esi
	if(!freeNodes)
80105644:	85 d2                	test   %edx,%edx
80105646:	74 50                	je     80105698 <_ZN3Map11extractProcEP4proc+0x68>
	MapNode *next, *parent, *left, *right;
};

class Map {
public:
	Map(): root(null) {}
80105648:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		return false;

	bool ans = false;
8010564f:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
80105653:	eb 13                	jmp    80105668 <_ZN3Map11extractProcEP4proc+0x38>
80105655:	8d 76 00             	lea    0x0(%esi),%esi
	Map tempMap;
	while(!isEmpty()) {
		Proc *otherP = extractMin();
80105658:	89 1c 24             	mov    %ebx,(%esp)
8010565b:	e8 10 fe ff ff       	call   80105470 <_ZN3Map10extractMinEv>
		if(otherP != p)
80105660:	39 f0                	cmp    %esi,%eax
80105662:	75 1c                	jne    80105680 <_ZN3Map11extractProcEP4proc+0x50>
			tempMap.put(otherP); //should scucceed.
		else ans = true;
80105664:	c6 45 e7 01          	movb   $0x1,-0x19(%ebp)
	while(!isEmpty()) {
80105668:	8b 03                	mov    (%ebx),%eax
8010566a:	85 c0                	test   %eax,%eax
8010566c:	75 ea                	jne    80105658 <_ZN3Map11extractProcEP4proc+0x28>
	}
	root = tempMap.root;
8010566e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105671:	89 03                	mov    %eax,(%ebx)
	return ans;
}
80105673:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80105677:	83 c4 30             	add    $0x30,%esp
8010567a:	5b                   	pop    %ebx
8010567b:	5e                   	pop    %esi
8010567c:	5d                   	pop    %ebp
8010567d:	c3                   	ret    
8010567e:	66 90                	xchg   %ax,%ax
			tempMap.put(otherP); //should scucceed.
80105680:	89 44 24 04          	mov    %eax,0x4(%esp)
80105684:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105687:	89 04 24             	mov    %eax,(%esp)
8010568a:	e8 21 fd ff ff       	call   801053b0 <_ZN3Map3putEP4proc>
8010568f:	eb d7                	jmp    80105668 <_ZN3Map11extractProcEP4proc+0x38>
80105691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return false;
80105698:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
}
8010569c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801056a0:	83 c4 30             	add    $0x30,%esp
801056a3:	5b                   	pop    %ebx
801056a4:	5e                   	pop    %esi
801056a5:	5d                   	pop    %ebp
801056a6:	c3                   	ret    
801056a7:	89 f6                	mov    %esi,%esi
801056a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801056b0 <extractProcPriorityQueue>:
static boolean extractProcPriorityQueue(Proc *p) {
801056b0:	55                   	push   %ebp
801056b1:	89 e5                	mov    %esp,%ebp
801056b3:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->extractProc(p);
801056b6:	8b 45 08             	mov    0x8(%ebp),%eax
801056b9:	89 44 24 04          	mov    %eax,0x4(%esp)
801056bd:	a1 10 c6 10 80       	mov    0x8010c610,%eax
801056c2:	89 04 24             	mov    %eax,(%esp)
801056c5:	e8 66 ff ff ff       	call   80105630 <_ZN3Map11extractProcEP4proc>
}
801056ca:	c9                   	leave  
	return priorityQ->extractProc(p);
801056cb:	0f b6 c0             	movzbl %al,%eax
}
801056ce:	c3                   	ret    
801056cf:	90                   	nop

801056d0 <__moddi3>:

long long __moddi3(long long number, long long divisor) { //returns number%divisor
801056d0:	55                   	push   %ebp
801056d1:	89 e5                	mov    %esp,%ebp
801056d3:	57                   	push   %edi
801056d4:	56                   	push   %esi
801056d5:	53                   	push   %ebx
801056d6:	83 ec 2c             	sub    $0x2c,%esp
801056d9:	8b 45 08             	mov    0x8(%ebp),%eax
801056dc:	8b 55 0c             	mov    0xc(%ebp),%edx
801056df:	89 45 e0             	mov    %eax,-0x20(%ebp)
801056e2:	8b 45 10             	mov    0x10(%ebp),%eax
801056e5:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801056e8:	8b 55 14             	mov    0x14(%ebp),%edx
801056eb:	89 45 d8             	mov    %eax,-0x28(%ebp)
801056ee:	89 d7                	mov    %edx,%edi
	if(divisor == 0)
801056f0:	09 c2                	or     %eax,%edx
801056f2:	0f 84 9a 00 00 00    	je     80105792 <__moddi3+0xc2>
		panic((char*)"divide by zero!!!\n");

	bool isNumberNegative = false;
	if(number < 0) {
801056f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
	bool isNumberNegative = false;
801056fb:	c6 45 df 00          	movb   $0x0,-0x21(%ebp)
	if(number < 0) {
801056ff:	85 c0                	test   %eax,%eax
80105701:	79 0e                	jns    80105711 <__moddi3+0x41>
		number = -number;
80105703:	f7 5d e0             	negl   -0x20(%ebp)
		isNumberNegative = true;
80105706:	c6 45 df 01          	movb   $0x1,-0x21(%ebp)
		number = -number;
8010570a:	83 55 e4 00          	adcl   $0x0,-0x1c(%ebp)
8010570e:	f7 5d e4             	negl   -0x1c(%ebp)
80105711:	8b 55 d8             	mov    -0x28(%ebp),%edx
80105714:	89 f8                	mov    %edi,%eax
80105716:	c1 ff 1f             	sar    $0x1f,%edi
80105719:	31 f8                	xor    %edi,%eax
8010571b:	89 f9                	mov    %edi,%ecx
8010571d:	31 fa                	xor    %edi,%edx
8010571f:	89 c7                	mov    %eax,%edi
80105721:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105724:	89 d6                	mov    %edx,%esi
80105726:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105729:	29 ce                	sub    %ecx,%esi
8010572b:	19 cf                	sbb    %ecx,%edi
	if(divisor < 0)
		divisor = -divisor;

	for(;;) {
		long long divisor2 = divisor;
		while(number >= divisor2) {
8010572d:	39 fa                	cmp    %edi,%edx
8010572f:	7d 1f                	jge    80105750 <__moddi3+0x80>
			if(divisor2 + divisor2 > 0) //exponential decay.
				divisor2 += divisor2;
		}

		if(number < divisor)
			return isNumberNegative ? -number : number;
80105731:	80 7d df 00          	cmpb   $0x0,-0x21(%ebp)
80105735:	74 07                	je     8010573e <__moddi3+0x6e>
80105737:	f7 d8                	neg    %eax
80105739:	83 d2 00             	adc    $0x0,%edx
8010573c:	f7 da                	neg    %edx
	}
}
8010573e:	83 c4 2c             	add    $0x2c,%esp
80105741:	5b                   	pop    %ebx
80105742:	5e                   	pop    %esi
80105743:	5f                   	pop    %edi
80105744:	5d                   	pop    %ebp
80105745:	c3                   	ret    
80105746:	8d 76 00             	lea    0x0(%esi),%esi
80105749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		while(number >= divisor2) {
80105750:	7f 04                	jg     80105756 <__moddi3+0x86>
80105752:	39 f0                	cmp    %esi,%eax
80105754:	72 db                	jb     80105731 <__moddi3+0x61>
80105756:	89 f1                	mov    %esi,%ecx
80105758:	89 fb                	mov    %edi,%ebx
8010575a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			number -= divisor2;
80105760:	29 c8                	sub    %ecx,%eax
80105762:	19 da                	sbb    %ebx,%edx
				divisor2 += divisor2;
80105764:	0f a4 cb 01          	shld   $0x1,%ecx,%ebx
80105768:	01 c9                	add    %ecx,%ecx
		while(number >= divisor2) {
8010576a:	39 da                	cmp    %ebx,%edx
8010576c:	7f f2                	jg     80105760 <__moddi3+0x90>
8010576e:	7d 18                	jge    80105788 <__moddi3+0xb8>
		if(number < divisor)
80105770:	39 d7                	cmp    %edx,%edi
80105772:	7c b9                	jl     8010572d <__moddi3+0x5d>
80105774:	7f bb                	jg     80105731 <__moddi3+0x61>
80105776:	39 c6                	cmp    %eax,%esi
80105778:	76 b3                	jbe    8010572d <__moddi3+0x5d>
8010577a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105780:	eb af                	jmp    80105731 <__moddi3+0x61>
80105782:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		while(number >= divisor2) {
80105788:	39 c8                	cmp    %ecx,%eax
8010578a:	73 d4                	jae    80105760 <__moddi3+0x90>
8010578c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105790:	eb de                	jmp    80105770 <__moddi3+0xa0>
		panic((char*)"divide by zero!!!\n");
80105792:	c7 04 24 10 8e 10 80 	movl   $0x80108e10,(%esp)
80105799:	e8 d2 ab ff ff       	call   80100370 <panic>
8010579e:	66 90                	xchg   %ax,%ax

801057a0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801057a0:	55                   	push   %ebp
  initlock(&lk->lk, "sleep lock");
801057a1:	b8 23 8e 10 80       	mov    $0x80108e23,%eax
{
801057a6:	89 e5                	mov    %esp,%ebp
801057a8:	53                   	push   %ebx
801057a9:	83 ec 14             	sub    $0x14,%esp
801057ac:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801057af:	89 44 24 04          	mov    %eax,0x4(%esp)
801057b3:	8d 43 04             	lea    0x4(%ebx),%eax
801057b6:	89 04 24             	mov    %eax,(%esp)
801057b9:	e8 12 01 00 00       	call   801058d0 <initlock>
  lk->name = name;
801057be:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801057c1:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801057c7:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801057ce:	89 43 38             	mov    %eax,0x38(%ebx)
}
801057d1:	83 c4 14             	add    $0x14,%esp
801057d4:	5b                   	pop    %ebx
801057d5:	5d                   	pop    %ebp
801057d6:	c3                   	ret    
801057d7:	89 f6                	mov    %esi,%esi
801057d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057e0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801057e0:	55                   	push   %ebp
801057e1:	89 e5                	mov    %esp,%ebp
801057e3:	56                   	push   %esi
801057e4:	53                   	push   %ebx
801057e5:	83 ec 10             	sub    $0x10,%esp
801057e8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801057eb:	8d 73 04             	lea    0x4(%ebx),%esi
801057ee:	89 34 24             	mov    %esi,(%esp)
801057f1:	e8 2a 02 00 00       	call   80105a20 <acquire>
  while (lk->locked) {
801057f6:	8b 13                	mov    (%ebx),%edx
801057f8:	85 d2                	test   %edx,%edx
801057fa:	74 16                	je     80105812 <acquiresleep+0x32>
801057fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80105800:	89 74 24 04          	mov    %esi,0x4(%esp)
80105804:	89 1c 24             	mov    %ebx,(%esp)
80105807:	e8 e4 eb ff ff       	call   801043f0 <sleep>
  while (lk->locked) {
8010580c:	8b 03                	mov    (%ebx),%eax
8010580e:	85 c0                	test   %eax,%eax
80105810:	75 ee                	jne    80105800 <acquiresleep+0x20>
  }
  lk->locked = 1;
80105812:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80105818:	e8 83 e1 ff ff       	call   801039a0 <myproc>
8010581d:	8b 40 10             	mov    0x10(%eax),%eax
80105820:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80105823:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105826:	83 c4 10             	add    $0x10,%esp
80105829:	5b                   	pop    %ebx
8010582a:	5e                   	pop    %esi
8010582b:	5d                   	pop    %ebp
  release(&lk->lk);
8010582c:	e9 8f 02 00 00       	jmp    80105ac0 <release>
80105831:	eb 0d                	jmp    80105840 <releasesleep>
80105833:	90                   	nop
80105834:	90                   	nop
80105835:	90                   	nop
80105836:	90                   	nop
80105837:	90                   	nop
80105838:	90                   	nop
80105839:	90                   	nop
8010583a:	90                   	nop
8010583b:	90                   	nop
8010583c:	90                   	nop
8010583d:	90                   	nop
8010583e:	90                   	nop
8010583f:	90                   	nop

80105840 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80105840:	55                   	push   %ebp
80105841:	89 e5                	mov    %esp,%ebp
80105843:	83 ec 18             	sub    $0x18,%esp
80105846:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105849:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010584c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  acquire(&lk->lk);
8010584f:	8d 73 04             	lea    0x4(%ebx),%esi
80105852:	89 34 24             	mov    %esi,(%esp)
80105855:	e8 c6 01 00 00       	call   80105a20 <acquire>
  lk->locked = 0;
8010585a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80105860:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80105867:	89 1c 24             	mov    %ebx,(%esp)
8010586a:	e8 61 ed ff ff       	call   801045d0 <wakeup>
  release(&lk->lk);
}
8010586f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  release(&lk->lk);
80105872:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105875:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105878:	89 ec                	mov    %ebp,%esp
8010587a:	5d                   	pop    %ebp
  release(&lk->lk);
8010587b:	e9 40 02 00 00       	jmp    80105ac0 <release>

80105880 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80105880:	55                   	push   %ebp
80105881:	89 e5                	mov    %esp,%ebp
80105883:	83 ec 28             	sub    $0x28,%esp
80105886:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80105889:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010588c:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010588f:	89 75 f8             	mov    %esi,-0x8(%ebp)
80105892:	31 f6                	xor    %esi,%esi
  int r;
  
  acquire(&lk->lk);
80105894:	8d 7b 04             	lea    0x4(%ebx),%edi
80105897:	89 3c 24             	mov    %edi,(%esp)
8010589a:	e8 81 01 00 00       	call   80105a20 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
8010589f:	8b 03                	mov    (%ebx),%eax
801058a1:	85 c0                	test   %eax,%eax
801058a3:	74 11                	je     801058b6 <holdingsleep+0x36>
801058a5:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801058a8:	e8 f3 e0 ff ff       	call   801039a0 <myproc>
801058ad:	39 58 10             	cmp    %ebx,0x10(%eax)
801058b0:	0f 94 c0             	sete   %al
801058b3:	0f b6 f0             	movzbl %al,%esi
  release(&lk->lk);
801058b6:	89 3c 24             	mov    %edi,(%esp)
801058b9:	e8 02 02 00 00       	call   80105ac0 <release>
  return r;
}
801058be:	89 f0                	mov    %esi,%eax
801058c0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801058c3:	8b 75 f8             	mov    -0x8(%ebp),%esi
801058c6:	8b 7d fc             	mov    -0x4(%ebp),%edi
801058c9:	89 ec                	mov    %ebp,%esp
801058cb:	5d                   	pop    %ebp
801058cc:	c3                   	ret    
801058cd:	66 90                	xchg   %ax,%ax
801058cf:	90                   	nop

801058d0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801058d0:	55                   	push   %ebp
801058d1:	89 e5                	mov    %esp,%ebp
801058d3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801058d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801058d9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801058df:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801058e2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801058e9:	5d                   	pop    %ebp
801058ea:	c3                   	ret    
801058eb:	90                   	nop
801058ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801058f0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801058f0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801058f1:	31 d2                	xor    %edx,%edx
{
801058f3:	89 e5                	mov    %esp,%ebp
  ebp = (uint*)v - 2;
801058f5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801058f8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801058fb:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801058fc:	83 e8 08             	sub    $0x8,%eax
801058ff:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105900:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80105906:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010590c:	77 12                	ja     80105920 <getcallerpcs+0x30>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010590e:	8b 58 04             	mov    0x4(%eax),%ebx
80105911:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80105914:	42                   	inc    %edx
80105915:	83 fa 0a             	cmp    $0xa,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80105918:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
8010591a:	75 e4                	jne    80105900 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010591c:	5b                   	pop    %ebx
8010591d:	5d                   	pop    %ebp
8010591e:	c3                   	ret    
8010591f:	90                   	nop
80105920:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80105923:	83 c1 28             	add    $0x28,%ecx
80105926:	8d 76 00             	lea    0x0(%esi),%esi
80105929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80105930:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105936:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105939:	39 c1                	cmp    %eax,%ecx
8010593b:	75 f3                	jne    80105930 <getcallerpcs+0x40>
}
8010593d:	5b                   	pop    %ebx
8010593e:	5d                   	pop    %ebp
8010593f:	c3                   	ret    

80105940 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105940:	55                   	push   %ebp
80105941:	89 e5                	mov    %esp,%ebp
80105943:	53                   	push   %ebx
80105944:	83 ec 04             	sub    $0x4,%esp
80105947:	9c                   	pushf  
80105948:	5b                   	pop    %ebx
  asm volatile("cli");
80105949:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010594a:	e8 b1 df ff ff       	call   80103900 <mycpu>
8010594f:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105955:	85 d2                	test   %edx,%edx
80105957:	75 11                	jne    8010596a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80105959:	e8 a2 df ff ff       	call   80103900 <mycpu>
8010595e:	81 e3 00 02 00 00    	and    $0x200,%ebx
80105964:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010596a:	e8 91 df ff ff       	call   80103900 <mycpu>
8010596f:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
80105975:	58                   	pop    %eax
80105976:	5b                   	pop    %ebx
80105977:	5d                   	pop    %ebp
80105978:	c3                   	ret    
80105979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105980 <popcli>:

void
popcli(void)
{
80105980:	55                   	push   %ebp
80105981:	89 e5                	mov    %esp,%ebp
80105983:	83 ec 18             	sub    $0x18,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105986:	9c                   	pushf  
80105987:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80105988:	f6 c4 02             	test   $0x2,%ah
8010598b:	75 35                	jne    801059c2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010598d:	e8 6e df ff ff       	call   80103900 <mycpu>
80105992:	ff 88 a4 00 00 00    	decl   0xa4(%eax)
80105998:	78 34                	js     801059ce <popcli+0x4e>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010599a:	e8 61 df ff ff       	call   80103900 <mycpu>
8010599f:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801059a5:	85 d2                	test   %edx,%edx
801059a7:	74 07                	je     801059b0 <popcli+0x30>
    sti();
}
801059a9:	c9                   	leave  
801059aa:	c3                   	ret    
801059ab:	90                   	nop
801059ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801059b0:	e8 4b df ff ff       	call   80103900 <mycpu>
801059b5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801059bb:	85 c0                	test   %eax,%eax
801059bd:	74 ea                	je     801059a9 <popcli+0x29>
  asm volatile("sti");
801059bf:	fb                   	sti    
}
801059c0:	c9                   	leave  
801059c1:	c3                   	ret    
    panic("popcli - interruptible");
801059c2:	c7 04 24 2e 8e 10 80 	movl   $0x80108e2e,(%esp)
801059c9:	e8 a2 a9 ff ff       	call   80100370 <panic>
    panic("popcli");
801059ce:	c7 04 24 45 8e 10 80 	movl   $0x80108e45,(%esp)
801059d5:	e8 96 a9 ff ff       	call   80100370 <panic>
801059da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801059e0 <holding>:
{
801059e0:	55                   	push   %ebp
801059e1:	89 e5                	mov    %esp,%ebp
801059e3:	83 ec 08             	sub    $0x8,%esp
801059e6:	89 75 fc             	mov    %esi,-0x4(%ebp)
801059e9:	8b 75 08             	mov    0x8(%ebp),%esi
801059ec:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801059ef:	31 db                	xor    %ebx,%ebx
  pushcli();
801059f1:	e8 4a ff ff ff       	call   80105940 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801059f6:	8b 06                	mov    (%esi),%eax
801059f8:	85 c0                	test   %eax,%eax
801059fa:	74 10                	je     80105a0c <holding+0x2c>
801059fc:	8b 5e 08             	mov    0x8(%esi),%ebx
801059ff:	e8 fc de ff ff       	call   80103900 <mycpu>
80105a04:	39 c3                	cmp    %eax,%ebx
80105a06:	0f 94 c3             	sete   %bl
80105a09:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80105a0c:	e8 6f ff ff ff       	call   80105980 <popcli>
}
80105a11:	89 d8                	mov    %ebx,%eax
80105a13:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105a16:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105a19:	89 ec                	mov    %ebp,%esp
80105a1b:	5d                   	pop    %ebp
80105a1c:	c3                   	ret    
80105a1d:	8d 76 00             	lea    0x0(%esi),%esi

80105a20 <acquire>:
{
80105a20:	55                   	push   %ebp
80105a21:	89 e5                	mov    %esp,%ebp
80105a23:	56                   	push   %esi
80105a24:	53                   	push   %ebx
80105a25:	83 ec 10             	sub    $0x10,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105a28:	e8 13 ff ff ff       	call   80105940 <pushcli>
  if(holding(lk))
80105a2d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105a30:	89 1c 24             	mov    %ebx,(%esp)
80105a33:	e8 a8 ff ff ff       	call   801059e0 <holding>
80105a38:	85 c0                	test   %eax,%eax
80105a3a:	75 78                	jne    80105ab4 <acquire+0x94>
80105a3c:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80105a3e:	ba 01 00 00 00       	mov    $0x1,%edx
80105a43:	eb 06                	jmp    80105a4b <acquire+0x2b>
80105a45:	8d 76 00             	lea    0x0(%esi),%esi
80105a48:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105a4b:	89 d0                	mov    %edx,%eax
80105a4d:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80105a50:	85 c0                	test   %eax,%eax
80105a52:	75 f4                	jne    80105a48 <acquire+0x28>
  __sync_synchronize();
80105a54:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80105a59:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105a5c:	e8 9f de ff ff       	call   80103900 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80105a61:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
80105a64:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80105a67:	89 e8                	mov    %ebp,%eax
80105a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105a70:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
80105a76:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80105a7c:	77 1a                	ja     80105a98 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
80105a7e:	8b 48 04             	mov    0x4(%eax),%ecx
80105a81:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
80105a84:	46                   	inc    %esi
80105a85:	83 fe 0a             	cmp    $0xa,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80105a88:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105a8a:	75 e4                	jne    80105a70 <acquire+0x50>
}
80105a8c:	83 c4 10             	add    $0x10,%esp
80105a8f:	5b                   	pop    %ebx
80105a90:	5e                   	pop    %esi
80105a91:	5d                   	pop    %ebp
80105a92:	c3                   	ret    
80105a93:	90                   	nop
80105a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a98:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80105a9b:	83 c2 28             	add    $0x28,%edx
80105a9e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105aa0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105aa6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105aa9:	39 d0                	cmp    %edx,%eax
80105aab:	75 f3                	jne    80105aa0 <acquire+0x80>
}
80105aad:	83 c4 10             	add    $0x10,%esp
80105ab0:	5b                   	pop    %ebx
80105ab1:	5e                   	pop    %esi
80105ab2:	5d                   	pop    %ebp
80105ab3:	c3                   	ret    
    panic("acquire");
80105ab4:	c7 04 24 4c 8e 10 80 	movl   $0x80108e4c,(%esp)
80105abb:	e8 b0 a8 ff ff       	call   80100370 <panic>

80105ac0 <release>:
{
80105ac0:	55                   	push   %ebp
80105ac1:	89 e5                	mov    %esp,%ebp
80105ac3:	53                   	push   %ebx
80105ac4:	83 ec 14             	sub    $0x14,%esp
80105ac7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80105aca:	89 1c 24             	mov    %ebx,(%esp)
80105acd:	e8 0e ff ff ff       	call   801059e0 <holding>
80105ad2:	85 c0                	test   %eax,%eax
80105ad4:	74 23                	je     80105af9 <release+0x39>
  lk->pcs[0] = 0;
80105ad6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105add:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105ae4:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80105ae9:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105aef:	83 c4 14             	add    $0x14,%esp
80105af2:	5b                   	pop    %ebx
80105af3:	5d                   	pop    %ebp
  popcli();
80105af4:	e9 87 fe ff ff       	jmp    80105980 <popcli>
    panic("release");
80105af9:	c7 04 24 54 8e 10 80 	movl   $0x80108e54,(%esp)
80105b00:	e8 6b a8 ff ff       	call   80100370 <panic>
80105b05:	66 90                	xchg   %ax,%ax
80105b07:	66 90                	xchg   %ax,%ax
80105b09:	66 90                	xchg   %ax,%ax
80105b0b:	66 90                	xchg   %ax,%ax
80105b0d:	66 90                	xchg   %ax,%ax
80105b0f:	90                   	nop

80105b10 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105b10:	55                   	push   %ebp
80105b11:	89 e5                	mov    %esp,%ebp
80105b13:	83 ec 08             	sub    $0x8,%esp
80105b16:	8b 55 08             	mov    0x8(%ebp),%edx
80105b19:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105b1c:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105b1f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if ((int)dst%4 == 0 && n%4 == 0){
80105b22:	f6 c2 03             	test   $0x3,%dl
80105b25:	75 05                	jne    80105b2c <memset+0x1c>
80105b27:	f6 c1 03             	test   $0x3,%cl
80105b2a:	74 14                	je     80105b40 <memset+0x30>
  asm volatile("cld; rep stosb" :
80105b2c:	89 d7                	mov    %edx,%edi
80105b2e:	8b 45 0c             	mov    0xc(%ebp),%eax
80105b31:	fc                   	cld    
80105b32:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80105b34:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105b37:	89 d0                	mov    %edx,%eax
80105b39:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105b3c:	89 ec                	mov    %ebp,%esp
80105b3e:	5d                   	pop    %ebp
80105b3f:	c3                   	ret    
    c &= 0xFF;
80105b40:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80105b44:	c1 e9 02             	shr    $0x2,%ecx
80105b47:	89 f8                	mov    %edi,%eax
80105b49:	89 fb                	mov    %edi,%ebx
80105b4b:	c1 e0 18             	shl    $0x18,%eax
80105b4e:	c1 e3 10             	shl    $0x10,%ebx
80105b51:	09 d8                	or     %ebx,%eax
80105b53:	09 f8                	or     %edi,%eax
80105b55:	c1 e7 08             	shl    $0x8,%edi
80105b58:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80105b5a:	89 d7                	mov    %edx,%edi
80105b5c:	fc                   	cld    
80105b5d:	f3 ab                	rep stos %eax,%es:(%edi)
}
80105b5f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105b62:	89 d0                	mov    %edx,%eax
80105b64:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105b67:	89 ec                	mov    %ebp,%esp
80105b69:	5d                   	pop    %ebp
80105b6a:	c3                   	ret    
80105b6b:	90                   	nop
80105b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b70 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105b70:	55                   	push   %ebp
80105b71:	89 e5                	mov    %esp,%ebp
80105b73:	57                   	push   %edi
80105b74:	8b 7d 0c             	mov    0xc(%ebp),%edi
80105b77:	56                   	push   %esi
80105b78:	8b 75 08             	mov    0x8(%ebp),%esi
80105b7b:	53                   	push   %ebx
80105b7c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105b7f:	85 db                	test   %ebx,%ebx
80105b81:	74 27                	je     80105baa <memcmp+0x3a>
    if(*s1 != *s2)
80105b83:	0f b6 16             	movzbl (%esi),%edx
80105b86:	0f b6 0f             	movzbl (%edi),%ecx
80105b89:	38 d1                	cmp    %dl,%cl
80105b8b:	75 2b                	jne    80105bb8 <memcmp+0x48>
80105b8d:	b8 01 00 00 00       	mov    $0x1,%eax
80105b92:	eb 12                	jmp    80105ba6 <memcmp+0x36>
80105b94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b98:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80105b9c:	40                   	inc    %eax
80105b9d:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80105ba2:	38 ca                	cmp    %cl,%dl
80105ba4:	75 12                	jne    80105bb8 <memcmp+0x48>
  while(n-- > 0){
80105ba6:	39 d8                	cmp    %ebx,%eax
80105ba8:	75 ee                	jne    80105b98 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80105baa:	5b                   	pop    %ebx
  return 0;
80105bab:	31 c0                	xor    %eax,%eax
}
80105bad:	5e                   	pop    %esi
80105bae:	5f                   	pop    %edi
80105baf:	5d                   	pop    %ebp
80105bb0:	c3                   	ret    
80105bb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105bb8:	5b                   	pop    %ebx
      return *s1 - *s2;
80105bb9:	0f b6 c2             	movzbl %dl,%eax
80105bbc:	29 c8                	sub    %ecx,%eax
}
80105bbe:	5e                   	pop    %esi
80105bbf:	5f                   	pop    %edi
80105bc0:	5d                   	pop    %ebp
80105bc1:	c3                   	ret    
80105bc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105bd0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105bd0:	55                   	push   %ebp
80105bd1:	89 e5                	mov    %esp,%ebp
80105bd3:	56                   	push   %esi
80105bd4:	8b 45 08             	mov    0x8(%ebp),%eax
80105bd7:	53                   	push   %ebx
80105bd8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80105bdb:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80105bde:	39 c3                	cmp    %eax,%ebx
80105be0:	73 26                	jae    80105c08 <memmove+0x38>
80105be2:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80105be5:	39 c8                	cmp    %ecx,%eax
80105be7:	73 1f                	jae    80105c08 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80105be9:	85 f6                	test   %esi,%esi
80105beb:	8d 56 ff             	lea    -0x1(%esi),%edx
80105bee:	74 0d                	je     80105bfd <memmove+0x2d>
      *--d = *--s;
80105bf0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105bf4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80105bf7:	4a                   	dec    %edx
80105bf8:	83 fa ff             	cmp    $0xffffffff,%edx
80105bfb:	75 f3                	jne    80105bf0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80105bfd:	5b                   	pop    %ebx
80105bfe:	5e                   	pop    %esi
80105bff:	5d                   	pop    %ebp
80105c00:	c3                   	ret    
80105c01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80105c08:	31 d2                	xor    %edx,%edx
80105c0a:	85 f6                	test   %esi,%esi
80105c0c:	74 ef                	je     80105bfd <memmove+0x2d>
80105c0e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80105c10:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105c14:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80105c17:	42                   	inc    %edx
    while(n-- > 0)
80105c18:	39 d6                	cmp    %edx,%esi
80105c1a:	75 f4                	jne    80105c10 <memmove+0x40>
}
80105c1c:	5b                   	pop    %ebx
80105c1d:	5e                   	pop    %esi
80105c1e:	5d                   	pop    %ebp
80105c1f:	c3                   	ret    

80105c20 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105c20:	55                   	push   %ebp
80105c21:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80105c23:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80105c24:	eb aa                	jmp    80105bd0 <memmove>
80105c26:	8d 76 00             	lea    0x0(%esi),%esi
80105c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105c30 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80105c30:	55                   	push   %ebp
80105c31:	89 e5                	mov    %esp,%ebp
80105c33:	57                   	push   %edi
80105c34:	8b 7d 10             	mov    0x10(%ebp),%edi
80105c37:	56                   	push   %esi
80105c38:	8b 75 0c             	mov    0xc(%ebp),%esi
80105c3b:	53                   	push   %ebx
80105c3c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
80105c3f:	85 ff                	test   %edi,%edi
80105c41:	74 2d                	je     80105c70 <strncmp+0x40>
80105c43:	0f b6 03             	movzbl (%ebx),%eax
80105c46:	0f b6 0e             	movzbl (%esi),%ecx
80105c49:	84 c0                	test   %al,%al
80105c4b:	74 37                	je     80105c84 <strncmp+0x54>
80105c4d:	38 c1                	cmp    %al,%cl
80105c4f:	75 33                	jne    80105c84 <strncmp+0x54>
80105c51:	01 f7                	add    %esi,%edi
80105c53:	eb 13                	jmp    80105c68 <strncmp+0x38>
80105c55:	8d 76 00             	lea    0x0(%esi),%esi
80105c58:	0f b6 03             	movzbl (%ebx),%eax
80105c5b:	84 c0                	test   %al,%al
80105c5d:	74 21                	je     80105c80 <strncmp+0x50>
80105c5f:	0f b6 0a             	movzbl (%edx),%ecx
80105c62:	89 d6                	mov    %edx,%esi
80105c64:	38 c8                	cmp    %cl,%al
80105c66:	75 1c                	jne    80105c84 <strncmp+0x54>
    n--, p++, q++;
80105c68:	8d 56 01             	lea    0x1(%esi),%edx
80105c6b:	43                   	inc    %ebx
  while(n > 0 && *p && *p == *q)
80105c6c:	39 fa                	cmp    %edi,%edx
80105c6e:	75 e8                	jne    80105c58 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80105c70:	5b                   	pop    %ebx
    return 0;
80105c71:	31 c0                	xor    %eax,%eax
}
80105c73:	5e                   	pop    %esi
80105c74:	5f                   	pop    %edi
80105c75:	5d                   	pop    %ebp
80105c76:	c3                   	ret    
80105c77:	89 f6                	mov    %esi,%esi
80105c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105c80:	0f b6 4e 01          	movzbl 0x1(%esi),%ecx
80105c84:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
80105c85:	29 c8                	sub    %ecx,%eax
}
80105c87:	5e                   	pop    %esi
80105c88:	5f                   	pop    %edi
80105c89:	5d                   	pop    %ebp
80105c8a:	c3                   	ret    
80105c8b:	90                   	nop
80105c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c90 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105c90:	55                   	push   %ebp
80105c91:	89 e5                	mov    %esp,%ebp
80105c93:	8b 45 08             	mov    0x8(%ebp),%eax
80105c96:	56                   	push   %esi
80105c97:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105c9a:	53                   	push   %ebx
80105c9b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80105c9e:	89 c2                	mov    %eax,%edx
80105ca0:	eb 15                	jmp    80105cb7 <strncpy+0x27>
80105ca2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105ca8:	46                   	inc    %esi
80105ca9:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
80105cad:	42                   	inc    %edx
80105cae:	84 c9                	test   %cl,%cl
80105cb0:	88 4a ff             	mov    %cl,-0x1(%edx)
80105cb3:	74 09                	je     80105cbe <strncpy+0x2e>
80105cb5:	89 d9                	mov    %ebx,%ecx
80105cb7:	85 c9                	test   %ecx,%ecx
80105cb9:	8d 59 ff             	lea    -0x1(%ecx),%ebx
80105cbc:	7f ea                	jg     80105ca8 <strncpy+0x18>
    ;
  while(n-- > 0)
80105cbe:	31 c9                	xor    %ecx,%ecx
80105cc0:	85 db                	test   %ebx,%ebx
80105cc2:	7e 19                	jle    80105cdd <strncpy+0x4d>
80105cc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105cca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *s++ = 0;
80105cd0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80105cd4:	89 de                	mov    %ebx,%esi
80105cd6:	41                   	inc    %ecx
80105cd7:	29 ce                	sub    %ecx,%esi
  while(n-- > 0)
80105cd9:	85 f6                	test   %esi,%esi
80105cdb:	7f f3                	jg     80105cd0 <strncpy+0x40>
  return os;
}
80105cdd:	5b                   	pop    %ebx
80105cde:	5e                   	pop    %esi
80105cdf:	5d                   	pop    %ebp
80105ce0:	c3                   	ret    
80105ce1:	eb 0d                	jmp    80105cf0 <safestrcpy>
80105ce3:	90                   	nop
80105ce4:	90                   	nop
80105ce5:	90                   	nop
80105ce6:	90                   	nop
80105ce7:	90                   	nop
80105ce8:	90                   	nop
80105ce9:	90                   	nop
80105cea:	90                   	nop
80105ceb:	90                   	nop
80105cec:	90                   	nop
80105ced:	90                   	nop
80105cee:	90                   	nop
80105cef:	90                   	nop

80105cf0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105cf0:	55                   	push   %ebp
80105cf1:	89 e5                	mov    %esp,%ebp
80105cf3:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105cf6:	56                   	push   %esi
80105cf7:	8b 45 08             	mov    0x8(%ebp),%eax
80105cfa:	53                   	push   %ebx
80105cfb:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80105cfe:	85 c9                	test   %ecx,%ecx
80105d00:	7e 22                	jle    80105d24 <safestrcpy+0x34>
80105d02:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80105d06:	89 c1                	mov    %eax,%ecx
80105d08:	eb 13                	jmp    80105d1d <safestrcpy+0x2d>
80105d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105d10:	42                   	inc    %edx
80105d11:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80105d15:	41                   	inc    %ecx
80105d16:	84 db                	test   %bl,%bl
80105d18:	88 59 ff             	mov    %bl,-0x1(%ecx)
80105d1b:	74 04                	je     80105d21 <safestrcpy+0x31>
80105d1d:	39 f2                	cmp    %esi,%edx
80105d1f:	75 ef                	jne    80105d10 <safestrcpy+0x20>
    ;
  *s = 0;
80105d21:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80105d24:	5b                   	pop    %ebx
80105d25:	5e                   	pop    %esi
80105d26:	5d                   	pop    %ebp
80105d27:	c3                   	ret    
80105d28:	90                   	nop
80105d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d30 <strlen>:

int
strlen(const char *s)
{
80105d30:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105d31:	31 c0                	xor    %eax,%eax
{
80105d33:	89 e5                	mov    %esp,%ebp
80105d35:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105d38:	80 3a 00             	cmpb   $0x0,(%edx)
80105d3b:	74 0a                	je     80105d47 <strlen+0x17>
80105d3d:	8d 76 00             	lea    0x0(%esi),%esi
80105d40:	40                   	inc    %eax
80105d41:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105d45:	75 f9                	jne    80105d40 <strlen+0x10>
    ;
  return n;
}
80105d47:	5d                   	pop    %ebp
80105d48:	c3                   	ret    

80105d49 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80105d49:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80105d4d:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80105d51:	55                   	push   %ebp
  pushl %ebx
80105d52:	53                   	push   %ebx
  pushl %esi
80105d53:	56                   	push   %esi
  pushl %edi
80105d54:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105d55:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105d57:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80105d59:	5f                   	pop    %edi
  popl %esi
80105d5a:	5e                   	pop    %esi
  popl %ebx
80105d5b:	5b                   	pop    %ebx
  popl %ebp
80105d5c:	5d                   	pop    %ebp
  ret
80105d5d:	c3                   	ret    
80105d5e:	66 90                	xchg   %ax,%ax

80105d60 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105d60:	55                   	push   %ebp
80105d61:	89 e5                	mov    %esp,%ebp
80105d63:	53                   	push   %ebx
80105d64:	83 ec 04             	sub    $0x4,%esp
80105d67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80105d6a:	e8 31 dc ff ff       	call   801039a0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105d6f:	8b 00                	mov    (%eax),%eax
80105d71:	39 d8                	cmp    %ebx,%eax
80105d73:	76 1b                	jbe    80105d90 <fetchint+0x30>
80105d75:	8d 53 04             	lea    0x4(%ebx),%edx
80105d78:	39 d0                	cmp    %edx,%eax
80105d7a:	72 14                	jb     80105d90 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80105d7c:	8b 45 0c             	mov    0xc(%ebp),%eax
80105d7f:	8b 13                	mov    (%ebx),%edx
80105d81:	89 10                	mov    %edx,(%eax)
  return 0;
80105d83:	31 c0                	xor    %eax,%eax
}
80105d85:	5a                   	pop    %edx
80105d86:	5b                   	pop    %ebx
80105d87:	5d                   	pop    %ebp
80105d88:	c3                   	ret    
80105d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105d90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d95:	eb ee                	jmp    80105d85 <fetchint+0x25>
80105d97:	89 f6                	mov    %esi,%esi
80105d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105da0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105da0:	55                   	push   %ebp
80105da1:	89 e5                	mov    %esp,%ebp
80105da3:	53                   	push   %ebx
80105da4:	83 ec 04             	sub    $0x4,%esp
80105da7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80105daa:	e8 f1 db ff ff       	call   801039a0 <myproc>

  if(addr >= curproc->sz)
80105daf:	39 18                	cmp    %ebx,(%eax)
80105db1:	76 27                	jbe    80105dda <fetchstr+0x3a>
    return -1;
  *pp = (char*)addr;
80105db3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105db6:	89 da                	mov    %ebx,%edx
80105db8:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80105dba:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80105dbc:	39 c3                	cmp    %eax,%ebx
80105dbe:	73 1a                	jae    80105dda <fetchstr+0x3a>
    if(*s == 0)
80105dc0:	80 3b 00             	cmpb   $0x0,(%ebx)
80105dc3:	75 10                	jne    80105dd5 <fetchstr+0x35>
80105dc5:	eb 29                	jmp    80105df0 <fetchstr+0x50>
80105dc7:	89 f6                	mov    %esi,%esi
80105dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105dd0:	80 3a 00             	cmpb   $0x0,(%edx)
80105dd3:	74 13                	je     80105de8 <fetchstr+0x48>
  for(s = *pp; s < ep; s++){
80105dd5:	42                   	inc    %edx
80105dd6:	39 d0                	cmp    %edx,%eax
80105dd8:	77 f6                	ja     80105dd0 <fetchstr+0x30>
    return -1;
80105dda:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80105ddf:	5a                   	pop    %edx
80105de0:	5b                   	pop    %ebx
80105de1:	5d                   	pop    %ebp
80105de2:	c3                   	ret    
80105de3:	90                   	nop
80105de4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105de8:	89 d0                	mov    %edx,%eax
80105dea:	5a                   	pop    %edx
80105deb:	29 d8                	sub    %ebx,%eax
80105ded:	5b                   	pop    %ebx
80105dee:	5d                   	pop    %ebp
80105def:	c3                   	ret    
    if(*s == 0)
80105df0:	31 c0                	xor    %eax,%eax
      return s - *pp;
80105df2:	eb eb                	jmp    80105ddf <fetchstr+0x3f>
80105df4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105dfa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105e00 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105e00:	55                   	push   %ebp
80105e01:	89 e5                	mov    %esp,%ebp
80105e03:	56                   	push   %esi
80105e04:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105e05:	e8 96 db ff ff       	call   801039a0 <myproc>
80105e0a:	8b 55 08             	mov    0x8(%ebp),%edx
80105e0d:	8b 40 18             	mov    0x18(%eax),%eax
80105e10:	8b 40 44             	mov    0x44(%eax),%eax
80105e13:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105e16:	e8 85 db ff ff       	call   801039a0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105e1b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105e1e:	8b 00                	mov    (%eax),%eax
80105e20:	39 c6                	cmp    %eax,%esi
80105e22:	73 1c                	jae    80105e40 <argint+0x40>
80105e24:	8d 53 08             	lea    0x8(%ebx),%edx
80105e27:	39 d0                	cmp    %edx,%eax
80105e29:	72 15                	jb     80105e40 <argint+0x40>
  *ip = *(int*)(addr);
80105e2b:	8b 45 0c             	mov    0xc(%ebp),%eax
80105e2e:	8b 53 04             	mov    0x4(%ebx),%edx
80105e31:	89 10                	mov    %edx,(%eax)
  return 0;
80105e33:	31 c0                	xor    %eax,%eax
}
80105e35:	5b                   	pop    %ebx
80105e36:	5e                   	pop    %esi
80105e37:	5d                   	pop    %ebp
80105e38:	c3                   	ret    
80105e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105e40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105e45:	eb ee                	jmp    80105e35 <argint+0x35>
80105e47:	89 f6                	mov    %esi,%esi
80105e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e50 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105e50:	55                   	push   %ebp
80105e51:	89 e5                	mov    %esp,%ebp
80105e53:	56                   	push   %esi
80105e54:	53                   	push   %ebx
80105e55:	83 ec 20             	sub    $0x20,%esp
80105e58:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80105e5b:	e8 40 db ff ff       	call   801039a0 <myproc>
80105e60:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80105e62:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e65:	89 44 24 04          	mov    %eax,0x4(%esp)
80105e69:	8b 45 08             	mov    0x8(%ebp),%eax
80105e6c:	89 04 24             	mov    %eax,(%esp)
80105e6f:	e8 8c ff ff ff       	call   80105e00 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105e74:	c1 e8 1f             	shr    $0x1f,%eax
80105e77:	84 c0                	test   %al,%al
80105e79:	75 2d                	jne    80105ea8 <argptr+0x58>
80105e7b:	89 d8                	mov    %ebx,%eax
80105e7d:	c1 e8 1f             	shr    $0x1f,%eax
80105e80:	84 c0                	test   %al,%al
80105e82:	75 24                	jne    80105ea8 <argptr+0x58>
80105e84:	8b 16                	mov    (%esi),%edx
80105e86:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e89:	39 c2                	cmp    %eax,%edx
80105e8b:	76 1b                	jbe    80105ea8 <argptr+0x58>
80105e8d:	01 c3                	add    %eax,%ebx
80105e8f:	39 da                	cmp    %ebx,%edx
80105e91:	72 15                	jb     80105ea8 <argptr+0x58>
    return -1;
  *pp = (char*)i;
80105e93:	8b 55 0c             	mov    0xc(%ebp),%edx
80105e96:	89 02                	mov    %eax,(%edx)
  return 0;
80105e98:	31 c0                	xor    %eax,%eax
}
80105e9a:	83 c4 20             	add    $0x20,%esp
80105e9d:	5b                   	pop    %ebx
80105e9e:	5e                   	pop    %esi
80105e9f:	5d                   	pop    %ebp
80105ea0:	c3                   	ret    
80105ea1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105ea8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ead:	eb eb                	jmp    80105e9a <argptr+0x4a>
80105eaf:	90                   	nop

80105eb0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105eb0:	55                   	push   %ebp
80105eb1:	89 e5                	mov    %esp,%ebp
80105eb3:	83 ec 28             	sub    $0x28,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105eb6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105eb9:	89 44 24 04          	mov    %eax,0x4(%esp)
80105ebd:	8b 45 08             	mov    0x8(%ebp),%eax
80105ec0:	89 04 24             	mov    %eax,(%esp)
80105ec3:	e8 38 ff ff ff       	call   80105e00 <argint>
80105ec8:	85 c0                	test   %eax,%eax
80105eca:	78 14                	js     80105ee0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80105ecc:	8b 45 0c             	mov    0xc(%ebp),%eax
80105ecf:	89 44 24 04          	mov    %eax,0x4(%esp)
80105ed3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ed6:	89 04 24             	mov    %eax,(%esp)
80105ed9:	e8 c2 fe ff ff       	call   80105da0 <fetchstr>
}
80105ede:	c9                   	leave  
80105edf:	c3                   	ret    
    return -1;
80105ee0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ee5:	c9                   	leave  
80105ee6:	c3                   	ret    
80105ee7:	89 f6                	mov    %esi,%esi
80105ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ef0 <syscall>:
[SYS_wait_stat] sys_wait_stat,
};

void
syscall(void)
{
80105ef0:	55                   	push   %ebp
80105ef1:	89 e5                	mov    %esp,%ebp
80105ef3:	53                   	push   %ebx
80105ef4:	83 ec 14             	sub    $0x14,%esp
  int num;
  struct proc *curproc = myproc();
80105ef7:	e8 a4 da ff ff       	call   801039a0 <myproc>
80105efc:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80105efe:	8b 40 18             	mov    0x18(%eax),%eax
80105f01:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105f04:	8d 50 ff             	lea    -0x1(%eax),%edx
80105f07:	83 fa 18             	cmp    $0x18,%edx
80105f0a:	77 1c                	ja     80105f28 <syscall+0x38>
80105f0c:	8b 14 85 80 8e 10 80 	mov    -0x7fef7180(,%eax,4),%edx
80105f13:	85 d2                	test   %edx,%edx
80105f15:	74 11                	je     80105f28 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80105f17:	ff d2                	call   *%edx
80105f19:	8b 53 18             	mov    0x18(%ebx),%edx
80105f1c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105f1f:	83 c4 14             	add    $0x14,%esp
80105f22:	5b                   	pop    %ebx
80105f23:	5d                   	pop    %ebp
80105f24:	c3                   	ret    
80105f25:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80105f28:	89 44 24 0c          	mov    %eax,0xc(%esp)
            curproc->pid, curproc->name, num);
80105f2c:	8d 43 6c             	lea    0x6c(%ebx),%eax
80105f2f:	89 44 24 08          	mov    %eax,0x8(%esp)
    cprintf("%d %s: unknown sys call %d\n",
80105f33:	8b 43 10             	mov    0x10(%ebx),%eax
80105f36:	c7 04 24 5c 8e 10 80 	movl   $0x80108e5c,(%esp)
80105f3d:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f41:	e8 0a a7 ff ff       	call   80100650 <cprintf>
    curproc->tf->eax = -1;
80105f46:	8b 43 18             	mov    0x18(%ebx),%eax
80105f49:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80105f50:	83 c4 14             	add    $0x14,%esp
80105f53:	5b                   	pop    %ebx
80105f54:	5d                   	pop    %ebp
80105f55:	c3                   	ret    
80105f56:	66 90                	xchg   %ax,%ax
80105f58:	66 90                	xchg   %ax,%ax
80105f5a:	66 90                	xchg   %ax,%ax
80105f5c:	66 90                	xchg   %ax,%ax
80105f5e:	66 90                	xchg   %ax,%ax

80105f60 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105f60:	55                   	push   %ebp
80105f61:	0f bf d2             	movswl %dx,%edx
80105f64:	89 e5                	mov    %esp,%ebp
80105f66:	83 ec 58             	sub    $0x58,%esp
80105f69:	89 7d fc             	mov    %edi,-0x4(%ebp)
80105f6c:	0f bf 7d 08          	movswl 0x8(%ebp),%edi
80105f70:	0f bf c9             	movswl %cx,%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105f73:	89 04 24             	mov    %eax,(%esp)
{
80105f76:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80105f79:	89 75 f8             	mov    %esi,-0x8(%ebp)
80105f7c:	89 7d bc             	mov    %edi,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80105f7f:	8d 7d da             	lea    -0x26(%ebp),%edi
80105f82:	89 7c 24 04          	mov    %edi,0x4(%esp)
{
80105f86:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80105f89:	89 4d c0             	mov    %ecx,-0x40(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80105f8c:	e8 5f c0 ff ff       	call   80101ff0 <nameiparent>
80105f91:	85 c0                	test   %eax,%eax
80105f93:	0f 84 4f 01 00 00    	je     801060e8 <create+0x188>
    return 0;
  ilock(dp);
80105f99:	89 04 24             	mov    %eax,(%esp)
80105f9c:	89 c3                	mov    %eax,%ebx
80105f9e:	e8 4d b7 ff ff       	call   801016f0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80105fa3:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105fa6:	89 44 24 08          	mov    %eax,0x8(%esp)
80105faa:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105fae:	89 1c 24             	mov    %ebx,(%esp)
80105fb1:	e8 ba bc ff ff       	call   80101c70 <dirlookup>
80105fb6:	85 c0                	test   %eax,%eax
80105fb8:	89 c6                	mov    %eax,%esi
80105fba:	74 34                	je     80105ff0 <create+0x90>
    iunlockput(dp);
80105fbc:	89 1c 24             	mov    %ebx,(%esp)
80105fbf:	e8 bc b9 ff ff       	call   80101980 <iunlockput>
    ilock(ip);
80105fc4:	89 34 24             	mov    %esi,(%esp)
80105fc7:	e8 24 b7 ff ff       	call   801016f0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105fcc:	83 7d c4 02          	cmpl   $0x2,-0x3c(%ebp)
80105fd0:	0f 85 9a 00 00 00    	jne    80106070 <create+0x110>
80105fd6:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80105fdb:	0f 85 8f 00 00 00    	jne    80106070 <create+0x110>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105fe1:	89 f0                	mov    %esi,%eax
80105fe3:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105fe6:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105fe9:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105fec:	89 ec                	mov    %ebp,%esp
80105fee:	5d                   	pop    %ebp
80105fef:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80105ff0:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80105ff3:	89 44 24 04          	mov    %eax,0x4(%esp)
80105ff7:	8b 03                	mov    (%ebx),%eax
80105ff9:	89 04 24             	mov    %eax,(%esp)
80105ffc:	e8 6f b5 ff ff       	call   80101570 <ialloc>
80106001:	85 c0                	test   %eax,%eax
80106003:	89 c6                	mov    %eax,%esi
80106005:	0f 84 f0 00 00 00    	je     801060fb <create+0x19b>
  ilock(ip);
8010600b:	89 04 24             	mov    %eax,(%esp)
8010600e:	e8 dd b6 ff ff       	call   801016f0 <ilock>
  ip->major = major;
80106013:	8b 45 c0             	mov    -0x40(%ebp),%eax
  ip->nlink = 1;
80106016:	66 c7 46 56 01 00    	movw   $0x1,0x56(%esi)
  ip->major = major;
8010601c:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80106020:	8b 45 bc             	mov    -0x44(%ebp),%eax
80106023:	66 89 46 54          	mov    %ax,0x54(%esi)
  iupdate(ip);
80106027:	89 34 24             	mov    %esi,(%esp)
8010602a:	e8 01 b6 ff ff       	call   80101630 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
8010602f:	83 7d c4 01          	cmpl   $0x1,-0x3c(%ebp)
80106033:	74 5b                	je     80106090 <create+0x130>
  if(dirlink(dp, name, ip->inum) < 0)
80106035:	8b 46 04             	mov    0x4(%esi),%eax
80106038:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010603c:	89 1c 24             	mov    %ebx,(%esp)
8010603f:	89 44 24 08          	mov    %eax,0x8(%esp)
80106043:	e8 a8 be ff ff       	call   80101ef0 <dirlink>
80106048:	85 c0                	test   %eax,%eax
8010604a:	0f 88 9f 00 00 00    	js     801060ef <create+0x18f>
  iunlockput(dp);
80106050:	89 1c 24             	mov    %ebx,(%esp)
80106053:	e8 28 b9 ff ff       	call   80101980 <iunlockput>
}
80106058:	89 f0                	mov    %esi,%eax
8010605a:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010605d:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106060:	8b 7d fc             	mov    -0x4(%ebp),%edi
80106063:	89 ec                	mov    %ebp,%esp
80106065:	5d                   	pop    %ebp
80106066:	c3                   	ret    
80106067:	89 f6                	mov    %esi,%esi
80106069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80106070:	89 34 24             	mov    %esi,(%esp)
    return 0;
80106073:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80106075:	e8 06 b9 ff ff       	call   80101980 <iunlockput>
}
8010607a:	89 f0                	mov    %esi,%eax
8010607c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010607f:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106082:	8b 7d fc             	mov    -0x4(%ebp),%edi
80106085:	89 ec                	mov    %ebp,%esp
80106087:	5d                   	pop    %ebp
80106088:	c3                   	ret    
80106089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80106090:	66 ff 43 56          	incw   0x56(%ebx)
    iupdate(dp);
80106094:	89 1c 24             	mov    %ebx,(%esp)
80106097:	e8 94 b5 ff ff       	call   80101630 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010609c:	8b 46 04             	mov    0x4(%esi),%eax
8010609f:	ba 04 8f 10 80       	mov    $0x80108f04,%edx
801060a4:	89 54 24 04          	mov    %edx,0x4(%esp)
801060a8:	89 34 24             	mov    %esi,(%esp)
801060ab:	89 44 24 08          	mov    %eax,0x8(%esp)
801060af:	e8 3c be ff ff       	call   80101ef0 <dirlink>
801060b4:	85 c0                	test   %eax,%eax
801060b6:	78 20                	js     801060d8 <create+0x178>
801060b8:	8b 43 04             	mov    0x4(%ebx),%eax
801060bb:	89 34 24             	mov    %esi,(%esp)
801060be:	89 44 24 08          	mov    %eax,0x8(%esp)
801060c2:	b8 03 8f 10 80       	mov    $0x80108f03,%eax
801060c7:	89 44 24 04          	mov    %eax,0x4(%esp)
801060cb:	e8 20 be ff ff       	call   80101ef0 <dirlink>
801060d0:	85 c0                	test   %eax,%eax
801060d2:	0f 89 5d ff ff ff    	jns    80106035 <create+0xd5>
      panic("create dots");
801060d8:	c7 04 24 f7 8e 10 80 	movl   $0x80108ef7,(%esp)
801060df:	e8 8c a2 ff ff       	call   80100370 <panic>
801060e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
801060e8:	31 f6                	xor    %esi,%esi
801060ea:	e9 f2 fe ff ff       	jmp    80105fe1 <create+0x81>
    panic("create: dirlink");
801060ef:	c7 04 24 06 8f 10 80 	movl   $0x80108f06,(%esp)
801060f6:	e8 75 a2 ff ff       	call   80100370 <panic>
    panic("create: ialloc");
801060fb:	c7 04 24 e8 8e 10 80 	movl   $0x80108ee8,(%esp)
80106102:	e8 69 a2 ff ff       	call   80100370 <panic>
80106107:	89 f6                	mov    %esi,%esi
80106109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106110 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80106110:	55                   	push   %ebp
80106111:	89 e5                	mov    %esp,%ebp
80106113:	56                   	push   %esi
80106114:	89 d6                	mov    %edx,%esi
80106116:	53                   	push   %ebx
80106117:	89 c3                	mov    %eax,%ebx
80106119:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
8010611c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010611f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106123:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010612a:	e8 d1 fc ff ff       	call   80105e00 <argint>
8010612f:	85 c0                	test   %eax,%eax
80106131:	78 2d                	js     80106160 <argfd.constprop.0+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80106133:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80106137:	77 27                	ja     80106160 <argfd.constprop.0+0x50>
80106139:	e8 62 d8 ff ff       	call   801039a0 <myproc>
8010613e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106141:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80106145:	85 c0                	test   %eax,%eax
80106147:	74 17                	je     80106160 <argfd.constprop.0+0x50>
  if(pfd)
80106149:	85 db                	test   %ebx,%ebx
8010614b:	74 02                	je     8010614f <argfd.constprop.0+0x3f>
    *pfd = fd;
8010614d:	89 13                	mov    %edx,(%ebx)
    *pf = f;
8010614f:	89 06                	mov    %eax,(%esi)
  return 0;
80106151:	31 c0                	xor    %eax,%eax
}
80106153:	83 c4 20             	add    $0x20,%esp
80106156:	5b                   	pop    %ebx
80106157:	5e                   	pop    %esi
80106158:	5d                   	pop    %ebp
80106159:	c3                   	ret    
8010615a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106160:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106165:	eb ec                	jmp    80106153 <argfd.constprop.0+0x43>
80106167:	89 f6                	mov    %esi,%esi
80106169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106170 <sys_dup>:
{
80106170:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80106171:	31 c0                	xor    %eax,%eax
{
80106173:	89 e5                	mov    %esp,%ebp
80106175:	56                   	push   %esi
80106176:	53                   	push   %ebx
80106177:	83 ec 20             	sub    $0x20,%esp
  if(argfd(0, 0, &f) < 0)
8010617a:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010617d:	e8 8e ff ff ff       	call   80106110 <argfd.constprop.0>
80106182:	85 c0                	test   %eax,%eax
80106184:	78 3a                	js     801061c0 <sys_dup+0x50>
  if((fd=fdalloc(f)) < 0)
80106186:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106189:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010618b:	e8 10 d8 ff ff       	call   801039a0 <myproc>
80106190:	eb 0c                	jmp    8010619e <sys_dup+0x2e>
80106192:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106198:	43                   	inc    %ebx
80106199:	83 fb 10             	cmp    $0x10,%ebx
8010619c:	74 22                	je     801061c0 <sys_dup+0x50>
    if(curproc->ofile[fd] == 0){
8010619e:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801061a2:	85 d2                	test   %edx,%edx
801061a4:	75 f2                	jne    80106198 <sys_dup+0x28>
      curproc->ofile[fd] = f;
801061a6:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
801061aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801061ad:	89 04 24             	mov    %eax,(%esp)
801061b0:	e8 2b ac ff ff       	call   80100de0 <filedup>
}
801061b5:	83 c4 20             	add    $0x20,%esp
801061b8:	89 d8                	mov    %ebx,%eax
801061ba:	5b                   	pop    %ebx
801061bb:	5e                   	pop    %esi
801061bc:	5d                   	pop    %ebp
801061bd:	c3                   	ret    
801061be:	66 90                	xchg   %ax,%ax
801061c0:	83 c4 20             	add    $0x20,%esp
    return -1;
801061c3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
801061c8:	89 d8                	mov    %ebx,%eax
801061ca:	5b                   	pop    %ebx
801061cb:	5e                   	pop    %esi
801061cc:	5d                   	pop    %ebp
801061cd:	c3                   	ret    
801061ce:	66 90                	xchg   %ax,%ax

801061d0 <sys_read>:
{
801061d0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801061d1:	31 c0                	xor    %eax,%eax
{
801061d3:	89 e5                	mov    %esp,%ebp
801061d5:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801061d8:	8d 55 ec             	lea    -0x14(%ebp),%edx
801061db:	e8 30 ff ff ff       	call   80106110 <argfd.constprop.0>
801061e0:	85 c0                	test   %eax,%eax
801061e2:	78 54                	js     80106238 <sys_read+0x68>
801061e4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801061e7:	89 44 24 04          	mov    %eax,0x4(%esp)
801061eb:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801061f2:	e8 09 fc ff ff       	call   80105e00 <argint>
801061f7:	85 c0                	test   %eax,%eax
801061f9:	78 3d                	js     80106238 <sys_read+0x68>
801061fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061fe:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106205:	89 44 24 08          	mov    %eax,0x8(%esp)
80106209:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010620c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106210:	e8 3b fc ff ff       	call   80105e50 <argptr>
80106215:	85 c0                	test   %eax,%eax
80106217:	78 1f                	js     80106238 <sys_read+0x68>
  return fileread(f, p, n);
80106219:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010621c:	89 44 24 08          	mov    %eax,0x8(%esp)
80106220:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106223:	89 44 24 04          	mov    %eax,0x4(%esp)
80106227:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010622a:	89 04 24             	mov    %eax,(%esp)
8010622d:	e8 2e ad ff ff       	call   80100f60 <fileread>
}
80106232:	c9                   	leave  
80106233:	c3                   	ret    
80106234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106238:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010623d:	c9                   	leave  
8010623e:	c3                   	ret    
8010623f:	90                   	nop

80106240 <sys_write>:
{
80106240:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106241:	31 c0                	xor    %eax,%eax
{
80106243:	89 e5                	mov    %esp,%ebp
80106245:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106248:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010624b:	e8 c0 fe ff ff       	call   80106110 <argfd.constprop.0>
80106250:	85 c0                	test   %eax,%eax
80106252:	78 54                	js     801062a8 <sys_write+0x68>
80106254:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106257:	89 44 24 04          	mov    %eax,0x4(%esp)
8010625b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106262:	e8 99 fb ff ff       	call   80105e00 <argint>
80106267:	85 c0                	test   %eax,%eax
80106269:	78 3d                	js     801062a8 <sys_write+0x68>
8010626b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010626e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106275:	89 44 24 08          	mov    %eax,0x8(%esp)
80106279:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010627c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106280:	e8 cb fb ff ff       	call   80105e50 <argptr>
80106285:	85 c0                	test   %eax,%eax
80106287:	78 1f                	js     801062a8 <sys_write+0x68>
  return filewrite(f, p, n);
80106289:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010628c:	89 44 24 08          	mov    %eax,0x8(%esp)
80106290:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106293:	89 44 24 04          	mov    %eax,0x4(%esp)
80106297:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010629a:	89 04 24             	mov    %eax,(%esp)
8010629d:	e8 6e ad ff ff       	call   80101010 <filewrite>
}
801062a2:	c9                   	leave  
801062a3:	c3                   	ret    
801062a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801062a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801062ad:	c9                   	leave  
801062ae:	c3                   	ret    
801062af:	90                   	nop

801062b0 <sys_close>:
{
801062b0:	55                   	push   %ebp
801062b1:	89 e5                	mov    %esp,%ebp
801062b3:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, &fd, &f) < 0)
801062b6:	8d 55 f4             	lea    -0xc(%ebp),%edx
801062b9:	8d 45 f0             	lea    -0x10(%ebp),%eax
801062bc:	e8 4f fe ff ff       	call   80106110 <argfd.constprop.0>
801062c1:	85 c0                	test   %eax,%eax
801062c3:	78 23                	js     801062e8 <sys_close+0x38>
  myproc()->ofile[fd] = 0;
801062c5:	e8 d6 d6 ff ff       	call   801039a0 <myproc>
801062ca:	8b 55 f0             	mov    -0x10(%ebp),%edx
801062cd:	31 c9                	xor    %ecx,%ecx
801062cf:	89 4c 90 28          	mov    %ecx,0x28(%eax,%edx,4)
  fileclose(f);
801062d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062d6:	89 04 24             	mov    %eax,(%esp)
801062d9:	e8 52 ab ff ff       	call   80100e30 <fileclose>
  return 0;
801062de:	31 c0                	xor    %eax,%eax
}
801062e0:	c9                   	leave  
801062e1:	c3                   	ret    
801062e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801062e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801062ed:	c9                   	leave  
801062ee:	c3                   	ret    
801062ef:	90                   	nop

801062f0 <sys_fstat>:
{
801062f0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801062f1:	31 c0                	xor    %eax,%eax
{
801062f3:	89 e5                	mov    %esp,%ebp
801062f5:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801062f8:	8d 55 f0             	lea    -0x10(%ebp),%edx
801062fb:	e8 10 fe ff ff       	call   80106110 <argfd.constprop.0>
80106300:	85 c0                	test   %eax,%eax
80106302:	78 3c                	js     80106340 <sys_fstat+0x50>
80106304:	b8 14 00 00 00       	mov    $0x14,%eax
80106309:	89 44 24 08          	mov    %eax,0x8(%esp)
8010630d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106310:	89 44 24 04          	mov    %eax,0x4(%esp)
80106314:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010631b:	e8 30 fb ff ff       	call   80105e50 <argptr>
80106320:	85 c0                	test   %eax,%eax
80106322:	78 1c                	js     80106340 <sys_fstat+0x50>
  return filestat(f, st);
80106324:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106327:	89 44 24 04          	mov    %eax,0x4(%esp)
8010632b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010632e:	89 04 24             	mov    %eax,(%esp)
80106331:	e8 da ab ff ff       	call   80100f10 <filestat>
}
80106336:	c9                   	leave  
80106337:	c3                   	ret    
80106338:	90                   	nop
80106339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106340:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106345:	c9                   	leave  
80106346:	c3                   	ret    
80106347:	89 f6                	mov    %esi,%esi
80106349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106350 <sys_link>:
{
80106350:	55                   	push   %ebp
80106351:	89 e5                	mov    %esp,%ebp
80106353:	57                   	push   %edi
80106354:	56                   	push   %esi
80106355:	53                   	push   %ebx
80106356:	83 ec 3c             	sub    $0x3c,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80106359:	8d 45 d4             	lea    -0x2c(%ebp),%eax
8010635c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106360:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106367:	e8 44 fb ff ff       	call   80105eb0 <argstr>
8010636c:	85 c0                	test   %eax,%eax
8010636e:	0f 88 e5 00 00 00    	js     80106459 <sys_link+0x109>
80106374:	8d 45 d0             	lea    -0x30(%ebp),%eax
80106377:	89 44 24 04          	mov    %eax,0x4(%esp)
8010637b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106382:	e8 29 fb ff ff       	call   80105eb0 <argstr>
80106387:	85 c0                	test   %eax,%eax
80106389:	0f 88 ca 00 00 00    	js     80106459 <sys_link+0x109>
  begin_op();
8010638f:	e8 fc c8 ff ff       	call   80102c90 <begin_op>
  if((ip = namei(old)) == 0){
80106394:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80106397:	89 04 24             	mov    %eax,(%esp)
8010639a:	e8 31 bc ff ff       	call   80101fd0 <namei>
8010639f:	85 c0                	test   %eax,%eax
801063a1:	89 c3                	mov    %eax,%ebx
801063a3:	0f 84 ab 00 00 00    	je     80106454 <sys_link+0x104>
  ilock(ip);
801063a9:	89 04 24             	mov    %eax,(%esp)
801063ac:	e8 3f b3 ff ff       	call   801016f0 <ilock>
  if(ip->type == T_DIR){
801063b1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801063b6:	0f 84 90 00 00 00    	je     8010644c <sys_link+0xfc>
  ip->nlink++;
801063bc:	66 ff 43 56          	incw   0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
801063c0:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801063c3:	89 1c 24             	mov    %ebx,(%esp)
801063c6:	e8 65 b2 ff ff       	call   80101630 <iupdate>
  iunlock(ip);
801063cb:	89 1c 24             	mov    %ebx,(%esp)
801063ce:	e8 fd b3 ff ff       	call   801017d0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801063d3:	8b 45 d0             	mov    -0x30(%ebp),%eax
801063d6:	89 7c 24 04          	mov    %edi,0x4(%esp)
801063da:	89 04 24             	mov    %eax,(%esp)
801063dd:	e8 0e bc ff ff       	call   80101ff0 <nameiparent>
801063e2:	85 c0                	test   %eax,%eax
801063e4:	89 c6                	mov    %eax,%esi
801063e6:	74 50                	je     80106438 <sys_link+0xe8>
  ilock(dp);
801063e8:	89 04 24             	mov    %eax,(%esp)
801063eb:	e8 00 b3 ff ff       	call   801016f0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801063f0:	8b 03                	mov    (%ebx),%eax
801063f2:	39 06                	cmp    %eax,(%esi)
801063f4:	75 3a                	jne    80106430 <sys_link+0xe0>
801063f6:	8b 43 04             	mov    0x4(%ebx),%eax
801063f9:	89 7c 24 04          	mov    %edi,0x4(%esp)
801063fd:	89 34 24             	mov    %esi,(%esp)
80106400:	89 44 24 08          	mov    %eax,0x8(%esp)
80106404:	e8 e7 ba ff ff       	call   80101ef0 <dirlink>
80106409:	85 c0                	test   %eax,%eax
8010640b:	78 23                	js     80106430 <sys_link+0xe0>
  iunlockput(dp);
8010640d:	89 34 24             	mov    %esi,(%esp)
80106410:	e8 6b b5 ff ff       	call   80101980 <iunlockput>
  iput(ip);
80106415:	89 1c 24             	mov    %ebx,(%esp)
80106418:	e8 03 b4 ff ff       	call   80101820 <iput>
  end_op();
8010641d:	e8 de c8 ff ff       	call   80102d00 <end_op>
}
80106422:	83 c4 3c             	add    $0x3c,%esp
  return 0;
80106425:	31 c0                	xor    %eax,%eax
}
80106427:	5b                   	pop    %ebx
80106428:	5e                   	pop    %esi
80106429:	5f                   	pop    %edi
8010642a:	5d                   	pop    %ebp
8010642b:	c3                   	ret    
8010642c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(dp);
80106430:	89 34 24             	mov    %esi,(%esp)
80106433:	e8 48 b5 ff ff       	call   80101980 <iunlockput>
  ilock(ip);
80106438:	89 1c 24             	mov    %ebx,(%esp)
8010643b:	e8 b0 b2 ff ff       	call   801016f0 <ilock>
  ip->nlink--;
80106440:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
80106444:	89 1c 24             	mov    %ebx,(%esp)
80106447:	e8 e4 b1 ff ff       	call   80101630 <iupdate>
  iunlockput(ip);
8010644c:	89 1c 24             	mov    %ebx,(%esp)
8010644f:	e8 2c b5 ff ff       	call   80101980 <iunlockput>
  end_op();
80106454:	e8 a7 c8 ff ff       	call   80102d00 <end_op>
}
80106459:	83 c4 3c             	add    $0x3c,%esp
  return -1;
8010645c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106461:	5b                   	pop    %ebx
80106462:	5e                   	pop    %esi
80106463:	5f                   	pop    %edi
80106464:	5d                   	pop    %ebp
80106465:	c3                   	ret    
80106466:	8d 76 00             	lea    0x0(%esi),%esi
80106469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106470 <sys_unlink>:
{
80106470:	55                   	push   %ebp
80106471:	89 e5                	mov    %esp,%ebp
80106473:	57                   	push   %edi
80106474:	56                   	push   %esi
80106475:	53                   	push   %ebx
80106476:	83 ec 5c             	sub    $0x5c,%esp
  if(argstr(0, &path) < 0)
80106479:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010647c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106480:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106487:	e8 24 fa ff ff       	call   80105eb0 <argstr>
8010648c:	85 c0                	test   %eax,%eax
8010648e:	0f 88 68 01 00 00    	js     801065fc <sys_unlink+0x18c>
  begin_op();
80106494:	e8 f7 c7 ff ff       	call   80102c90 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80106499:	8b 45 c0             	mov    -0x40(%ebp),%eax
8010649c:	8d 5d ca             	lea    -0x36(%ebp),%ebx
8010649f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801064a3:	89 04 24             	mov    %eax,(%esp)
801064a6:	e8 45 bb ff ff       	call   80101ff0 <nameiparent>
801064ab:	85 c0                	test   %eax,%eax
801064ad:	89 c6                	mov    %eax,%esi
801064af:	0f 84 42 01 00 00    	je     801065f7 <sys_unlink+0x187>
  ilock(dp);
801064b5:	89 04 24             	mov    %eax,(%esp)
801064b8:	e8 33 b2 ff ff       	call   801016f0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801064bd:	b8 04 8f 10 80       	mov    $0x80108f04,%eax
801064c2:	89 44 24 04          	mov    %eax,0x4(%esp)
801064c6:	89 1c 24             	mov    %ebx,(%esp)
801064c9:	e8 72 b7 ff ff       	call   80101c40 <namecmp>
801064ce:	85 c0                	test   %eax,%eax
801064d0:	0f 84 19 01 00 00    	je     801065ef <sys_unlink+0x17f>
801064d6:	b8 03 8f 10 80       	mov    $0x80108f03,%eax
801064db:	89 44 24 04          	mov    %eax,0x4(%esp)
801064df:	89 1c 24             	mov    %ebx,(%esp)
801064e2:	e8 59 b7 ff ff       	call   80101c40 <namecmp>
801064e7:	85 c0                	test   %eax,%eax
801064e9:	0f 84 00 01 00 00    	je     801065ef <sys_unlink+0x17f>
  if((ip = dirlookup(dp, name, &off)) == 0)
801064ef:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801064f2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801064f6:	89 44 24 08          	mov    %eax,0x8(%esp)
801064fa:	89 34 24             	mov    %esi,(%esp)
801064fd:	e8 6e b7 ff ff       	call   80101c70 <dirlookup>
80106502:	85 c0                	test   %eax,%eax
80106504:	89 c3                	mov    %eax,%ebx
80106506:	0f 84 e3 00 00 00    	je     801065ef <sys_unlink+0x17f>
  ilock(ip);
8010650c:	89 04 24             	mov    %eax,(%esp)
8010650f:	e8 dc b1 ff ff       	call   801016f0 <ilock>
  if(ip->nlink < 1)
80106514:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80106519:	0f 8e 0e 01 00 00    	jle    8010662d <sys_unlink+0x1bd>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010651f:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106524:	8d 7d d8             	lea    -0x28(%ebp),%edi
80106527:	74 77                	je     801065a0 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
80106529:	31 d2                	xor    %edx,%edx
8010652b:	b8 10 00 00 00       	mov    $0x10,%eax
80106530:	89 54 24 04          	mov    %edx,0x4(%esp)
80106534:	89 44 24 08          	mov    %eax,0x8(%esp)
80106538:	89 3c 24             	mov    %edi,(%esp)
8010653b:	e8 d0 f5 ff ff       	call   80105b10 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106540:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80106543:	b9 10 00 00 00       	mov    $0x10,%ecx
80106548:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
8010654c:	89 7c 24 04          	mov    %edi,0x4(%esp)
80106550:	89 34 24             	mov    %esi,(%esp)
80106553:	89 44 24 08          	mov    %eax,0x8(%esp)
80106557:	e8 94 b5 ff ff       	call   80101af0 <writei>
8010655c:	83 f8 10             	cmp    $0x10,%eax
8010655f:	0f 85 d4 00 00 00    	jne    80106639 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
80106565:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010656a:	0f 84 a0 00 00 00    	je     80106610 <sys_unlink+0x1a0>
  iunlockput(dp);
80106570:	89 34 24             	mov    %esi,(%esp)
80106573:	e8 08 b4 ff ff       	call   80101980 <iunlockput>
  ip->nlink--;
80106578:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
8010657c:	89 1c 24             	mov    %ebx,(%esp)
8010657f:	e8 ac b0 ff ff       	call   80101630 <iupdate>
  iunlockput(ip);
80106584:	89 1c 24             	mov    %ebx,(%esp)
80106587:	e8 f4 b3 ff ff       	call   80101980 <iunlockput>
  end_op();
8010658c:	e8 6f c7 ff ff       	call   80102d00 <end_op>
}
80106591:	83 c4 5c             	add    $0x5c,%esp
  return 0;
80106594:	31 c0                	xor    %eax,%eax
}
80106596:	5b                   	pop    %ebx
80106597:	5e                   	pop    %esi
80106598:	5f                   	pop    %edi
80106599:	5d                   	pop    %ebp
8010659a:	c3                   	ret    
8010659b:	90                   	nop
8010659c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801065a0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801065a4:	76 83                	jbe    80106529 <sys_unlink+0xb9>
801065a6:	ba 20 00 00 00       	mov    $0x20,%edx
801065ab:	eb 0f                	jmp    801065bc <sys_unlink+0x14c>
801065ad:	8d 76 00             	lea    0x0(%esi),%esi
801065b0:	83 c2 10             	add    $0x10,%edx
801065b3:	3b 53 58             	cmp    0x58(%ebx),%edx
801065b6:	0f 83 6d ff ff ff    	jae    80106529 <sys_unlink+0xb9>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801065bc:	b8 10 00 00 00       	mov    $0x10,%eax
801065c1:	89 54 24 08          	mov    %edx,0x8(%esp)
801065c5:	89 44 24 0c          	mov    %eax,0xc(%esp)
801065c9:	89 7c 24 04          	mov    %edi,0x4(%esp)
801065cd:	89 1c 24             	mov    %ebx,(%esp)
801065d0:	89 55 b4             	mov    %edx,-0x4c(%ebp)
801065d3:	e8 f8 b3 ff ff       	call   801019d0 <readi>
801065d8:	8b 55 b4             	mov    -0x4c(%ebp),%edx
801065db:	83 f8 10             	cmp    $0x10,%eax
801065de:	75 41                	jne    80106621 <sys_unlink+0x1b1>
    if(de.inum != 0)
801065e0:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801065e5:	74 c9                	je     801065b0 <sys_unlink+0x140>
    iunlockput(ip);
801065e7:	89 1c 24             	mov    %ebx,(%esp)
801065ea:	e8 91 b3 ff ff       	call   80101980 <iunlockput>
  iunlockput(dp);
801065ef:	89 34 24             	mov    %esi,(%esp)
801065f2:	e8 89 b3 ff ff       	call   80101980 <iunlockput>
  end_op();
801065f7:	e8 04 c7 ff ff       	call   80102d00 <end_op>
}
801065fc:	83 c4 5c             	add    $0x5c,%esp
  return -1;
801065ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106604:	5b                   	pop    %ebx
80106605:	5e                   	pop    %esi
80106606:	5f                   	pop    %edi
80106607:	5d                   	pop    %ebp
80106608:	c3                   	ret    
80106609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80106610:	66 ff 4e 56          	decw   0x56(%esi)
    iupdate(dp);
80106614:	89 34 24             	mov    %esi,(%esp)
80106617:	e8 14 b0 ff ff       	call   80101630 <iupdate>
8010661c:	e9 4f ff ff ff       	jmp    80106570 <sys_unlink+0x100>
      panic("isdirempty: readi");
80106621:	c7 04 24 28 8f 10 80 	movl   $0x80108f28,(%esp)
80106628:	e8 43 9d ff ff       	call   80100370 <panic>
    panic("unlink: nlink < 1");
8010662d:	c7 04 24 16 8f 10 80 	movl   $0x80108f16,(%esp)
80106634:	e8 37 9d ff ff       	call   80100370 <panic>
    panic("unlink: writei");
80106639:	c7 04 24 3a 8f 10 80 	movl   $0x80108f3a,(%esp)
80106640:	e8 2b 9d ff ff       	call   80100370 <panic>
80106645:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106650 <sys_open>:

int
sys_open(void)
{
80106650:	55                   	push   %ebp
80106651:	89 e5                	mov    %esp,%ebp
80106653:	57                   	push   %edi
80106654:	56                   	push   %esi
80106655:	53                   	push   %ebx
80106656:	83 ec 2c             	sub    $0x2c,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106659:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010665c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106660:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106667:	e8 44 f8 ff ff       	call   80105eb0 <argstr>
8010666c:	85 c0                	test   %eax,%eax
8010666e:	0f 88 e9 00 00 00    	js     8010675d <sys_open+0x10d>
80106674:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106677:	89 44 24 04          	mov    %eax,0x4(%esp)
8010667b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106682:	e8 79 f7 ff ff       	call   80105e00 <argint>
80106687:	85 c0                	test   %eax,%eax
80106689:	0f 88 ce 00 00 00    	js     8010675d <sys_open+0x10d>
    return -1;

  begin_op();
8010668f:	e8 fc c5 ff ff       	call   80102c90 <begin_op>

  if(omode & O_CREATE){
80106694:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80106698:	0f 85 9a 00 00 00    	jne    80106738 <sys_open+0xe8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
8010669e:	8b 45 e0             	mov    -0x20(%ebp),%eax
801066a1:	89 04 24             	mov    %eax,(%esp)
801066a4:	e8 27 b9 ff ff       	call   80101fd0 <namei>
801066a9:	85 c0                	test   %eax,%eax
801066ab:	89 c6                	mov    %eax,%esi
801066ad:	0f 84 a5 00 00 00    	je     80106758 <sys_open+0x108>
      end_op();
      return -1;
    }
    ilock(ip);
801066b3:	89 04 24             	mov    %eax,(%esp)
801066b6:	e8 35 b0 ff ff       	call   801016f0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801066bb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801066c0:	0f 84 a2 00 00 00    	je     80106768 <sys_open+0x118>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801066c6:	e8 a5 a6 ff ff       	call   80100d70 <filealloc>
801066cb:	85 c0                	test   %eax,%eax
801066cd:	89 c7                	mov    %eax,%edi
801066cf:	0f 84 9e 00 00 00    	je     80106773 <sys_open+0x123>
  struct proc *curproc = myproc();
801066d5:	e8 c6 d2 ff ff       	call   801039a0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801066da:	31 db                	xor    %ebx,%ebx
801066dc:	eb 0c                	jmp    801066ea <sys_open+0x9a>
801066de:	66 90                	xchg   %ax,%ax
801066e0:	43                   	inc    %ebx
801066e1:	83 fb 10             	cmp    $0x10,%ebx
801066e4:	0f 84 96 00 00 00    	je     80106780 <sys_open+0x130>
    if(curproc->ofile[fd] == 0){
801066ea:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801066ee:	85 d2                	test   %edx,%edx
801066f0:	75 ee                	jne    801066e0 <sys_open+0x90>
      curproc->ofile[fd] = f;
801066f2:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801066f6:	89 34 24             	mov    %esi,(%esp)
801066f9:	e8 d2 b0 ff ff       	call   801017d0 <iunlock>
  end_op();
801066fe:	e8 fd c5 ff ff       	call   80102d00 <end_op>

  f->type = FD_INODE;
80106703:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80106709:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->ip = ip;
8010670c:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
8010670f:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80106716:	89 d0                	mov    %edx,%eax
80106718:	f7 d0                	not    %eax
8010671a:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010671d:	f6 c2 03             	test   $0x3,%dl
  f->readable = !(omode & O_WRONLY);
80106720:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106723:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80106727:	83 c4 2c             	add    $0x2c,%esp
8010672a:	89 d8                	mov    %ebx,%eax
8010672c:	5b                   	pop    %ebx
8010672d:	5e                   	pop    %esi
8010672e:	5f                   	pop    %edi
8010672f:	5d                   	pop    %ebp
80106730:	c3                   	ret    
80106731:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80106738:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010673b:	31 c9                	xor    %ecx,%ecx
8010673d:	ba 02 00 00 00       	mov    $0x2,%edx
80106742:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106749:	e8 12 f8 ff ff       	call   80105f60 <create>
    if(ip == 0){
8010674e:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80106750:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80106752:	0f 85 6e ff ff ff    	jne    801066c6 <sys_open+0x76>
    end_op();
80106758:	e8 a3 c5 ff ff       	call   80102d00 <end_op>
    return -1;
8010675d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106762:	eb c3                	jmp    80106727 <sys_open+0xd7>
80106764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80106768:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010676b:	85 c9                	test   %ecx,%ecx
8010676d:	0f 84 53 ff ff ff    	je     801066c6 <sys_open+0x76>
    iunlockput(ip);
80106773:	89 34 24             	mov    %esi,(%esp)
80106776:	e8 05 b2 ff ff       	call   80101980 <iunlockput>
8010677b:	eb db                	jmp    80106758 <sys_open+0x108>
8010677d:	8d 76 00             	lea    0x0(%esi),%esi
      fileclose(f);
80106780:	89 3c 24             	mov    %edi,(%esp)
80106783:	e8 a8 a6 ff ff       	call   80100e30 <fileclose>
80106788:	eb e9                	jmp    80106773 <sys_open+0x123>
8010678a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106790 <sys_mkdir>:

int
sys_mkdir(void)
{
80106790:	55                   	push   %ebp
80106791:	89 e5                	mov    %esp,%ebp
80106793:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
80106796:	e8 f5 c4 ff ff       	call   80102c90 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010679b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010679e:	89 44 24 04          	mov    %eax,0x4(%esp)
801067a2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801067a9:	e8 02 f7 ff ff       	call   80105eb0 <argstr>
801067ae:	85 c0                	test   %eax,%eax
801067b0:	78 2e                	js     801067e0 <sys_mkdir+0x50>
801067b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067b5:	31 c9                	xor    %ecx,%ecx
801067b7:	ba 01 00 00 00       	mov    $0x1,%edx
801067bc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801067c3:	e8 98 f7 ff ff       	call   80105f60 <create>
801067c8:	85 c0                	test   %eax,%eax
801067ca:	74 14                	je     801067e0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801067cc:	89 04 24             	mov    %eax,(%esp)
801067cf:	e8 ac b1 ff ff       	call   80101980 <iunlockput>
  end_op();
801067d4:	e8 27 c5 ff ff       	call   80102d00 <end_op>
  return 0;
801067d9:	31 c0                	xor    %eax,%eax
}
801067db:	c9                   	leave  
801067dc:	c3                   	ret    
801067dd:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
801067e0:	e8 1b c5 ff ff       	call   80102d00 <end_op>
    return -1;
801067e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801067ea:	c9                   	leave  
801067eb:	c3                   	ret    
801067ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801067f0 <sys_mknod>:

int
sys_mknod(void)
{
801067f0:	55                   	push   %ebp
801067f1:	89 e5                	mov    %esp,%ebp
801067f3:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801067f6:	e8 95 c4 ff ff       	call   80102c90 <begin_op>
  if((argstr(0, &path)) < 0 ||
801067fb:	8d 45 ec             	lea    -0x14(%ebp),%eax
801067fe:	89 44 24 04          	mov    %eax,0x4(%esp)
80106802:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106809:	e8 a2 f6 ff ff       	call   80105eb0 <argstr>
8010680e:	85 c0                	test   %eax,%eax
80106810:	78 5e                	js     80106870 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80106812:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106815:	89 44 24 04          	mov    %eax,0x4(%esp)
80106819:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106820:	e8 db f5 ff ff       	call   80105e00 <argint>
  if((argstr(0, &path)) < 0 ||
80106825:	85 c0                	test   %eax,%eax
80106827:	78 47                	js     80106870 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80106829:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010682c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106830:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106837:	e8 c4 f5 ff ff       	call   80105e00 <argint>
     argint(1, &major) < 0 ||
8010683c:	85 c0                	test   %eax,%eax
8010683e:	78 30                	js     80106870 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80106840:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
80106844:	ba 03 00 00 00       	mov    $0x3,%edx
     (ip = create(path, T_DEV, major, minor)) == 0){
80106849:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
8010684d:	89 04 24             	mov    %eax,(%esp)
     argint(2, &minor) < 0 ||
80106850:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106853:	e8 08 f7 ff ff       	call   80105f60 <create>
80106858:	85 c0                	test   %eax,%eax
8010685a:	74 14                	je     80106870 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010685c:	89 04 24             	mov    %eax,(%esp)
8010685f:	e8 1c b1 ff ff       	call   80101980 <iunlockput>
  end_op();
80106864:	e8 97 c4 ff ff       	call   80102d00 <end_op>
  return 0;
80106869:	31 c0                	xor    %eax,%eax
}
8010686b:	c9                   	leave  
8010686c:	c3                   	ret    
8010686d:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
80106870:	e8 8b c4 ff ff       	call   80102d00 <end_op>
    return -1;
80106875:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010687a:	c9                   	leave  
8010687b:	c3                   	ret    
8010687c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106880 <sys_chdir>:

int
sys_chdir(void)
{
80106880:	55                   	push   %ebp
80106881:	89 e5                	mov    %esp,%ebp
80106883:	56                   	push   %esi
80106884:	53                   	push   %ebx
80106885:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80106888:	e8 13 d1 ff ff       	call   801039a0 <myproc>
8010688d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010688f:	e8 fc c3 ff ff       	call   80102c90 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106894:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106897:	89 44 24 04          	mov    %eax,0x4(%esp)
8010689b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801068a2:	e8 09 f6 ff ff       	call   80105eb0 <argstr>
801068a7:	85 c0                	test   %eax,%eax
801068a9:	78 4a                	js     801068f5 <sys_chdir+0x75>
801068ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801068ae:	89 04 24             	mov    %eax,(%esp)
801068b1:	e8 1a b7 ff ff       	call   80101fd0 <namei>
801068b6:	85 c0                	test   %eax,%eax
801068b8:	89 c3                	mov    %eax,%ebx
801068ba:	74 39                	je     801068f5 <sys_chdir+0x75>
    end_op();
    return -1;
  }
  ilock(ip);
801068bc:	89 04 24             	mov    %eax,(%esp)
801068bf:	e8 2c ae ff ff       	call   801016f0 <ilock>
  if(ip->type != T_DIR){
801068c4:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
    iunlockput(ip);
801068c9:	89 1c 24             	mov    %ebx,(%esp)
  if(ip->type != T_DIR){
801068cc:	75 22                	jne    801068f0 <sys_chdir+0x70>
    end_op();
    return -1;
  }
  iunlock(ip);
801068ce:	e8 fd ae ff ff       	call   801017d0 <iunlock>
  iput(curproc->cwd);
801068d3:	8b 46 68             	mov    0x68(%esi),%eax
801068d6:	89 04 24             	mov    %eax,(%esp)
801068d9:	e8 42 af ff ff       	call   80101820 <iput>
  end_op();
801068de:	e8 1d c4 ff ff       	call   80102d00 <end_op>
  curproc->cwd = ip;
  return 0;
801068e3:	31 c0                	xor    %eax,%eax
  curproc->cwd = ip;
801068e5:	89 5e 68             	mov    %ebx,0x68(%esi)
}
801068e8:	83 c4 20             	add    $0x20,%esp
801068eb:	5b                   	pop    %ebx
801068ec:	5e                   	pop    %esi
801068ed:	5d                   	pop    %ebp
801068ee:	c3                   	ret    
801068ef:	90                   	nop
    iunlockput(ip);
801068f0:	e8 8b b0 ff ff       	call   80101980 <iunlockput>
    end_op();
801068f5:	e8 06 c4 ff ff       	call   80102d00 <end_op>
    return -1;
801068fa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801068ff:	eb e7                	jmp    801068e8 <sys_chdir+0x68>
80106901:	eb 0d                	jmp    80106910 <sys_exec>
80106903:	90                   	nop
80106904:	90                   	nop
80106905:	90                   	nop
80106906:	90                   	nop
80106907:	90                   	nop
80106908:	90                   	nop
80106909:	90                   	nop
8010690a:	90                   	nop
8010690b:	90                   	nop
8010690c:	90                   	nop
8010690d:	90                   	nop
8010690e:	90                   	nop
8010690f:	90                   	nop

80106910 <sys_exec>:

int
sys_exec(void)
{
80106910:	55                   	push   %ebp
80106911:	89 e5                	mov    %esp,%ebp
80106913:	57                   	push   %edi
80106914:	56                   	push   %esi
80106915:	53                   	push   %ebx
80106916:	81 ec ac 00 00 00    	sub    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
8010691c:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80106922:	89 44 24 04          	mov    %eax,0x4(%esp)
80106926:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010692d:	e8 7e f5 ff ff       	call   80105eb0 <argstr>
80106932:	85 c0                	test   %eax,%eax
80106934:	0f 88 8e 00 00 00    	js     801069c8 <sys_exec+0xb8>
8010693a:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80106940:	89 44 24 04          	mov    %eax,0x4(%esp)
80106944:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010694b:	e8 b0 f4 ff ff       	call   80105e00 <argint>
80106950:	85 c0                	test   %eax,%eax
80106952:	78 74                	js     801069c8 <sys_exec+0xb8>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80106954:	ba 80 00 00 00       	mov    $0x80,%edx
80106959:	31 c9                	xor    %ecx,%ecx
8010695b:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
80106961:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80106963:	89 54 24 08          	mov    %edx,0x8(%esp)
80106967:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
8010696d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80106971:	89 04 24             	mov    %eax,(%esp)
80106974:	e8 97 f1 ff ff       	call   80105b10 <memset>
80106979:	eb 2e                	jmp    801069a9 <sys_exec+0x99>
8010697b:	90                   	nop
8010697c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80106980:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80106986:	85 c0                	test   %eax,%eax
80106988:	74 56                	je     801069e0 <sys_exec+0xd0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010698a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80106990:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80106993:	89 54 24 04          	mov    %edx,0x4(%esp)
80106997:	89 04 24             	mov    %eax,(%esp)
8010699a:	e8 01 f4 ff ff       	call   80105da0 <fetchstr>
8010699f:	85 c0                	test   %eax,%eax
801069a1:	78 25                	js     801069c8 <sys_exec+0xb8>
  for(i=0;; i++){
801069a3:	43                   	inc    %ebx
    if(i >= NELEM(argv))
801069a4:	83 fb 20             	cmp    $0x20,%ebx
801069a7:	74 1f                	je     801069c8 <sys_exec+0xb8>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801069a9:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801069af:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
801069b6:	89 7c 24 04          	mov    %edi,0x4(%esp)
801069ba:	01 f0                	add    %esi,%eax
801069bc:	89 04 24             	mov    %eax,(%esp)
801069bf:	e8 9c f3 ff ff       	call   80105d60 <fetchint>
801069c4:	85 c0                	test   %eax,%eax
801069c6:	79 b8                	jns    80106980 <sys_exec+0x70>
      return -1;
  }
  return exec(path, argv);
}
801069c8:	81 c4 ac 00 00 00    	add    $0xac,%esp
    return -1;
801069ce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801069d3:	5b                   	pop    %ebx
801069d4:	5e                   	pop    %esi
801069d5:	5f                   	pop    %edi
801069d6:	5d                   	pop    %ebp
801069d7:	c3                   	ret    
801069d8:	90                   	nop
801069d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
801069e0:	31 c0                	xor    %eax,%eax
801069e2:	89 84 9d 68 ff ff ff 	mov    %eax,-0x98(%ebp,%ebx,4)
  return exec(path, argv);
801069e9:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801069ef:	89 44 24 04          	mov    %eax,0x4(%esp)
801069f3:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
801069f9:	89 04 24             	mov    %eax,(%esp)
801069fc:	e8 cf 9f ff ff       	call   801009d0 <exec>
}
80106a01:	81 c4 ac 00 00 00    	add    $0xac,%esp
80106a07:	5b                   	pop    %ebx
80106a08:	5e                   	pop    %esi
80106a09:	5f                   	pop    %edi
80106a0a:	5d                   	pop    %ebp
80106a0b:	c3                   	ret    
80106a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106a10 <sys_pipe>:

int
sys_pipe(void)
{
80106a10:	55                   	push   %ebp
80106a11:	89 e5                	mov    %esp,%ebp
80106a13:	57                   	push   %edi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106a14:	bf 08 00 00 00       	mov    $0x8,%edi
{
80106a19:	56                   	push   %esi
80106a1a:	53                   	push   %ebx
80106a1b:	83 ec 2c             	sub    $0x2c,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106a1e:	8d 45 dc             	lea    -0x24(%ebp),%eax
80106a21:	89 7c 24 08          	mov    %edi,0x8(%esp)
80106a25:	89 44 24 04          	mov    %eax,0x4(%esp)
80106a29:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106a30:	e8 1b f4 ff ff       	call   80105e50 <argptr>
80106a35:	85 c0                	test   %eax,%eax
80106a37:	0f 88 a9 00 00 00    	js     80106ae6 <sys_pipe+0xd6>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80106a3d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106a40:	89 44 24 04          	mov    %eax,0x4(%esp)
80106a44:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106a47:	89 04 24             	mov    %eax,(%esp)
80106a4a:	e8 71 c9 ff ff       	call   801033c0 <pipealloc>
80106a4f:	85 c0                	test   %eax,%eax
80106a51:	0f 88 8f 00 00 00    	js     80106ae6 <sys_pipe+0xd6>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106a57:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80106a5a:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80106a5c:	e8 3f cf ff ff       	call   801039a0 <myproc>
80106a61:	eb 0b                	jmp    80106a6e <sys_pipe+0x5e>
80106a63:	90                   	nop
80106a64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106a68:	43                   	inc    %ebx
80106a69:	83 fb 10             	cmp    $0x10,%ebx
80106a6c:	74 62                	je     80106ad0 <sys_pipe+0xc0>
    if(curproc->ofile[fd] == 0){
80106a6e:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80106a72:	85 f6                	test   %esi,%esi
80106a74:	75 f2                	jne    80106a68 <sys_pipe+0x58>
      curproc->ofile[fd] = f;
80106a76:	8d 73 08             	lea    0x8(%ebx),%esi
80106a79:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106a7d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80106a80:	e8 1b cf ff ff       	call   801039a0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106a85:	31 d2                	xor    %edx,%edx
80106a87:	eb 0d                	jmp    80106a96 <sys_pipe+0x86>
80106a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a90:	42                   	inc    %edx
80106a91:	83 fa 10             	cmp    $0x10,%edx
80106a94:	74 2a                	je     80106ac0 <sys_pipe+0xb0>
    if(curproc->ofile[fd] == 0){
80106a96:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80106a9a:	85 c9                	test   %ecx,%ecx
80106a9c:	75 f2                	jne    80106a90 <sys_pipe+0x80>
      curproc->ofile[fd] = f;
80106a9e:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80106aa2:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106aa5:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106aa7:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106aaa:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80106aad:	31 c0                	xor    %eax,%eax
}
80106aaf:	83 c4 2c             	add    $0x2c,%esp
80106ab2:	5b                   	pop    %ebx
80106ab3:	5e                   	pop    %esi
80106ab4:	5f                   	pop    %edi
80106ab5:	5d                   	pop    %ebp
80106ab6:	c3                   	ret    
80106ab7:	89 f6                	mov    %esi,%esi
80106ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      myproc()->ofile[fd0] = 0;
80106ac0:	e8 db ce ff ff       	call   801039a0 <myproc>
80106ac5:	31 d2                	xor    %edx,%edx
80106ac7:	89 54 b0 08          	mov    %edx,0x8(%eax,%esi,4)
80106acb:	90                   	nop
80106acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fileclose(rf);
80106ad0:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106ad3:	89 04 24             	mov    %eax,(%esp)
80106ad6:	e8 55 a3 ff ff       	call   80100e30 <fileclose>
    fileclose(wf);
80106adb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106ade:	89 04 24             	mov    %eax,(%esp)
80106ae1:	e8 4a a3 ff ff       	call   80100e30 <fileclose>
    return -1;
80106ae6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106aeb:	eb c2                	jmp    80106aaf <sys_pipe+0x9f>
80106aed:	66 90                	xchg   %ax,%ax
80106aef:	90                   	nop

80106af0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106af0:	55                   	push   %ebp
80106af1:	89 e5                	mov    %esp,%ebp
  return fork();
}
80106af3:	5d                   	pop    %ebp
  return fork();
80106af4:	e9 67 d1 ff ff       	jmp    80103c60 <fork>
80106af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106b00 <sys_exit>:

int
sys_exit(void)
{
80106b00:	55                   	push   %ebp
80106b01:	89 e5                	mov    %esp,%ebp
80106b03:	83 ec 28             	sub    $0x28,%esp
  int status;

  if(argint(0, &status) < 0)
80106b06:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106b09:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b0d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106b14:	e8 e7 f2 ff ff       	call   80105e00 <argint>
80106b19:	85 c0                	test   %eax,%eax
80106b1b:	78 13                	js     80106b30 <sys_exit+0x30>
    return -1;
  exit(status);
80106b1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b20:	89 04 24             	mov    %eax,(%esp)
80106b23:	e8 d8 d6 ff ff       	call   80104200 <exit>
  return 0;  // not reached
80106b28:	31 c0                	xor    %eax,%eax
}
80106b2a:	c9                   	leave  
80106b2b:	c3                   	ret    
80106b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106b30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b35:	c9                   	leave  
80106b36:	c3                   	ret    
80106b37:	89 f6                	mov    %esi,%esi
80106b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b40 <sys_wait>:

int
sys_wait(void)
{
80106b40:	55                   	push   %ebp
  int *status;

  if(argptr(0, (char**)(&status), sizeof(int)) < 0)
80106b41:	b8 04 00 00 00       	mov    $0x4,%eax
{
80106b46:	89 e5                	mov    %esp,%ebp
80106b48:	83 ec 28             	sub    $0x28,%esp
  if(argptr(0, (char**)(&status), sizeof(int)) < 0)
80106b4b:	89 44 24 08          	mov    %eax,0x8(%esp)
80106b4f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106b52:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b56:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106b5d:	e8 ee f2 ff ff       	call   80105e50 <argptr>
80106b62:	85 c0                	test   %eax,%eax
80106b64:	78 12                	js     80106b78 <sys_wait+0x38>
    return -1;
  return wait(status);
80106b66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b69:	89 04 24             	mov    %eax,(%esp)
80106b6c:	e8 4f d9 ff ff       	call   801044c0 <wait>
  //return wait();
}
80106b71:	c9                   	leave  
80106b72:	c3                   	ret    
80106b73:	90                   	nop
80106b74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106b78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b7d:	c9                   	leave  
80106b7e:	c3                   	ret    
80106b7f:	90                   	nop

80106b80 <sys_kill>:

int
sys_kill(void)
{
80106b80:	55                   	push   %ebp
80106b81:	89 e5                	mov    %esp,%ebp
80106b83:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106b86:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106b89:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b8d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106b94:	e8 67 f2 ff ff       	call   80105e00 <argint>
80106b99:	85 c0                	test   %eax,%eax
80106b9b:	78 13                	js     80106bb0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106b9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ba0:	89 04 24             	mov    %eax,(%esp)
80106ba3:	e8 58 da ff ff       	call   80104600 <kill>
}
80106ba8:	c9                   	leave  
80106ba9:	c3                   	ret    
80106baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106bb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106bb5:	c9                   	leave  
80106bb6:	c3                   	ret    
80106bb7:	89 f6                	mov    %esi,%esi
80106bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106bc0 <sys_getpid>:

int
sys_getpid(void)
{
80106bc0:	55                   	push   %ebp
80106bc1:	89 e5                	mov    %esp,%ebp
80106bc3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106bc6:	e8 d5 cd ff ff       	call   801039a0 <myproc>
80106bcb:	8b 40 10             	mov    0x10(%eax),%eax
}
80106bce:	c9                   	leave  
80106bcf:	c3                   	ret    

80106bd0 <sys_sbrk>:

int
sys_sbrk(void)
{
80106bd0:	55                   	push   %ebp
80106bd1:	89 e5                	mov    %esp,%ebp
80106bd3:	53                   	push   %ebx
80106bd4:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106bd7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106bda:	89 44 24 04          	mov    %eax,0x4(%esp)
80106bde:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106be5:	e8 16 f2 ff ff       	call   80105e00 <argint>
80106bea:	85 c0                	test   %eax,%eax
80106bec:	78 22                	js     80106c10 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106bee:	e8 ad cd ff ff       	call   801039a0 <myproc>
80106bf3:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106bf5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106bf8:	89 04 24             	mov    %eax,(%esp)
80106bfb:	e8 00 cf ff ff       	call   80103b00 <growproc>
80106c00:	85 c0                	test   %eax,%eax
80106c02:	78 0c                	js     80106c10 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106c04:	83 c4 24             	add    $0x24,%esp
80106c07:	89 d8                	mov    %ebx,%eax
80106c09:	5b                   	pop    %ebx
80106c0a:	5d                   	pop    %ebp
80106c0b:	c3                   	ret    
80106c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106c10:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106c15:	eb ed                	jmp    80106c04 <sys_sbrk+0x34>
80106c17:	89 f6                	mov    %esi,%esi
80106c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c20 <sys_sleep>:

int
sys_sleep(void)
{
80106c20:	55                   	push   %ebp
80106c21:	89 e5                	mov    %esp,%ebp
80106c23:	53                   	push   %ebx
80106c24:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106c27:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106c2a:	89 44 24 04          	mov    %eax,0x4(%esp)
80106c2e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106c35:	e8 c6 f1 ff ff       	call   80105e00 <argint>
80106c3a:	85 c0                	test   %eax,%eax
80106c3c:	78 7e                	js     80106cbc <sys_sleep+0x9c>
    return -1;
  acquire(&tickslock);
80106c3e:	c7 04 24 c0 79 11 80 	movl   $0x801179c0,(%esp)
80106c45:	e8 d6 ed ff ff       	call   80105a20 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106c4a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  ticks0 = ticks;
80106c4d:	8b 1d 00 82 11 80    	mov    0x80118200,%ebx
  while(ticks - ticks0 < n){
80106c53:	85 c9                	test   %ecx,%ecx
80106c55:	75 2a                	jne    80106c81 <sys_sleep+0x61>
80106c57:	eb 4f                	jmp    80106ca8 <sys_sleep+0x88>
80106c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106c60:	b8 c0 79 11 80       	mov    $0x801179c0,%eax
80106c65:	89 44 24 04          	mov    %eax,0x4(%esp)
80106c69:	c7 04 24 00 82 11 80 	movl   $0x80118200,(%esp)
80106c70:	e8 7b d7 ff ff       	call   801043f0 <sleep>
  while(ticks - ticks0 < n){
80106c75:	a1 00 82 11 80       	mov    0x80118200,%eax
80106c7a:	29 d8                	sub    %ebx,%eax
80106c7c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80106c7f:	73 27                	jae    80106ca8 <sys_sleep+0x88>
    if(myproc()->killed){
80106c81:	e8 1a cd ff ff       	call   801039a0 <myproc>
80106c86:	8b 50 24             	mov    0x24(%eax),%edx
80106c89:	85 d2                	test   %edx,%edx
80106c8b:	74 d3                	je     80106c60 <sys_sleep+0x40>
      release(&tickslock);
80106c8d:	c7 04 24 c0 79 11 80 	movl   $0x801179c0,(%esp)
80106c94:	e8 27 ee ff ff       	call   80105ac0 <release>
  }
  release(&tickslock);
  return 0;
}
80106c99:	83 c4 24             	add    $0x24,%esp
      return -1;
80106c9c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ca1:	5b                   	pop    %ebx
80106ca2:	5d                   	pop    %ebp
80106ca3:	c3                   	ret    
80106ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&tickslock);
80106ca8:	c7 04 24 c0 79 11 80 	movl   $0x801179c0,(%esp)
80106caf:	e8 0c ee ff ff       	call   80105ac0 <release>
  return 0;
80106cb4:	31 c0                	xor    %eax,%eax
}
80106cb6:	83 c4 24             	add    $0x24,%esp
80106cb9:	5b                   	pop    %ebx
80106cba:	5d                   	pop    %ebp
80106cbb:	c3                   	ret    
    return -1;
80106cbc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106cc1:	eb f3                	jmp    80106cb6 <sys_sleep+0x96>
80106cc3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106cd0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106cd0:	55                   	push   %ebp
80106cd1:	89 e5                	mov    %esp,%ebp
80106cd3:	53                   	push   %ebx
80106cd4:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

  acquire(&tickslock);
80106cd7:	c7 04 24 c0 79 11 80 	movl   $0x801179c0,(%esp)
80106cde:	e8 3d ed ff ff       	call   80105a20 <acquire>
  xticks = ticks;
80106ce3:	8b 1d 00 82 11 80    	mov    0x80118200,%ebx
  release(&tickslock);
80106ce9:	c7 04 24 c0 79 11 80 	movl   $0x801179c0,(%esp)
80106cf0:	e8 cb ed ff ff       	call   80105ac0 <release>
  return xticks;
}
80106cf5:	83 c4 14             	add    $0x14,%esp
80106cf8:	89 d8                	mov    %ebx,%eax
80106cfa:	5b                   	pop    %ebx
80106cfb:	5d                   	pop    %ebp
80106cfc:	c3                   	ret    
80106cfd:	8d 76 00             	lea    0x0(%esi),%esi

80106d00 <sys_detach>:

// transfer a child process with the given pid from the parent to the init process.
// return 0 when succseeds or -1 if the process has no child with this pid.
int
sys_detach(void)
{
80106d00:	55                   	push   %ebp
80106d01:	89 e5                	mov    %esp,%ebp
80106d03:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106d06:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106d09:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d0d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106d14:	e8 e7 f0 ff ff       	call   80105e00 <argint>
80106d19:	85 c0                	test   %eax,%eax
80106d1b:	78 13                	js     80106d30 <sys_detach+0x30>
    return -1;
  return detach(pid);
80106d1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d20:	89 04 24             	mov    %eax,(%esp)
80106d23:	e8 88 d9 ff ff       	call   801046b0 <detach>
}
80106d28:	c9                   	leave  
80106d29:	c3                   	ret    
80106d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106d30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106d35:	c9                   	leave  
80106d36:	c3                   	ret    
80106d37:	89 f6                	mov    %esi,%esi
80106d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d40 <sys_priority>:

//used by a process to change its priority
int
sys_priority(void)
{
80106d40:	55                   	push   %ebp
80106d41:	89 e5                	mov    %esp,%ebp
80106d43:	83 ec 28             	sub    $0x28,%esp
  int proc_priority;

  if(argint(0, &proc_priority) < 0)
80106d46:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106d49:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d4d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106d54:	e8 a7 f0 ff ff       	call   80105e00 <argint>
80106d59:	85 c0                	test   %eax,%eax
80106d5b:	78 13                	js     80106d70 <sys_priority+0x30>
    return -1;
  priority(proc_priority);
80106d5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d60:	89 04 24             	mov    %eax,(%esp)
80106d63:	e8 f8 d9 ff ff       	call   80104760 <priority>
  return 0;
80106d68:	31 c0                	xor    %eax,%eax
}
80106d6a:	c9                   	leave  
80106d6b:	c3                   	ret    
80106d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106d70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106d75:	c9                   	leave  
80106d76:	c3                   	ret    
80106d77:	89 f6                	mov    %esi,%esi
80106d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d80 <sys_policy>:

// receives a policy identifier as an argument and changes the currently used policy.
int
sys_policy(void)
{
80106d80:	55                   	push   %ebp
80106d81:	89 e5                	mov    %esp,%ebp
80106d83:	83 ec 28             	sub    $0x28,%esp
  int policy_id;

  if(argint(0, &policy_id) < 0)
80106d86:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106d89:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d8d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106d94:	e8 67 f0 ff ff       	call   80105e00 <argint>
80106d99:	85 c0                	test   %eax,%eax
80106d9b:	78 13                	js     80106db0 <sys_policy+0x30>
    return -1;
  policy(policy_id);
80106d9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106da0:	89 04 24             	mov    %eax,(%esp)
80106da3:	e8 38 da ff ff       	call   801047e0 <policy>
  return 0;
80106da8:	31 c0                	xor    %eax,%eax
}
80106daa:	c9                   	leave  
80106dab:	c3                   	ret    
80106dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106db0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106db5:	c9                   	leave  
80106db6:	c3                   	ret    
80106db7:	89 f6                	mov    %esi,%esi
80106db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106dc0 <sys_wait_stat>:

// return the pid of the terminated child process or -1 upon failure.
int
sys_wait_stat(void)
{
80106dc0:	55                   	push   %ebp
     int* status;
     struct perf* perform;

     if ((argptr(0, (char**)(&status), sizeof(int)) < 0) || (argptr(0, (void*)(&perform), sizeof(*perform)) < 0))
80106dc1:	ba 04 00 00 00       	mov    $0x4,%edx
{
80106dc6:	89 e5                	mov    %esp,%ebp
80106dc8:	83 ec 28             	sub    $0x28,%esp
     if ((argptr(0, (char**)(&status), sizeof(int)) < 0) || (argptr(0, (void*)(&perform), sizeof(*perform)) < 0))
80106dcb:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106dce:	89 54 24 08          	mov    %edx,0x8(%esp)
80106dd2:	89 44 24 04          	mov    %eax,0x4(%esp)
80106dd6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106ddd:	e8 6e f0 ff ff       	call   80105e50 <argptr>
80106de2:	85 c0                	test   %eax,%eax
80106de4:	78 3a                	js     80106e20 <sys_wait_stat+0x60>
80106de6:	b8 14 00 00 00       	mov    $0x14,%eax
80106deb:	89 44 24 08          	mov    %eax,0x8(%esp)
80106def:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106df2:	89 44 24 04          	mov    %eax,0x4(%esp)
80106df6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106dfd:	e8 4e f0 ff ff       	call   80105e50 <argptr>
80106e02:	85 c0                	test   %eax,%eax
80106e04:	78 1a                	js     80106e20 <sys_wait_stat+0x60>
        return -1;
    return wait_stat(status,perform);
80106e06:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e09:	89 44 24 04          	mov    %eax,0x4(%esp)
80106e0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106e10:	89 04 24             	mov    %eax,(%esp)
80106e13:	e8 98 db ff ff       	call   801049b0 <wait_stat>
}
80106e18:	c9                   	leave  
80106e19:	c3                   	ret    
80106e1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
80106e20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106e25:	c9                   	leave  
80106e26:	c3                   	ret    

80106e27 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106e27:	1e                   	push   %ds
  pushl %es
80106e28:	06                   	push   %es
  pushl %fs
80106e29:	0f a0                	push   %fs
  pushl %gs
80106e2b:	0f a8                	push   %gs
  pushal
80106e2d:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106e2e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106e32:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106e34:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106e36:	54                   	push   %esp
  call trap
80106e37:	e8 c4 00 00 00       	call   80106f00 <trap>
  addl $4, %esp
80106e3c:	83 c4 04             	add    $0x4,%esp

80106e3f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106e3f:	61                   	popa   
  popl %gs
80106e40:	0f a9                	pop    %gs
  popl %fs
80106e42:	0f a1                	pop    %fs
  popl %es
80106e44:	07                   	pop    %es
  popl %ds
80106e45:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106e46:	83 c4 08             	add    $0x8,%esp
  iret
80106e49:	cf                   	iret   
80106e4a:	66 90                	xchg   %ax,%ax
80106e4c:	66 90                	xchg   %ax,%ax
80106e4e:	66 90                	xchg   %ax,%ax

80106e50 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106e50:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106e51:	31 c0                	xor    %eax,%eax
{
80106e53:	89 e5                	mov    %esp,%ebp
80106e55:	83 ec 18             	sub    $0x18,%esp
80106e58:	90                   	nop
80106e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106e60:	8b 14 85 0c c0 10 80 	mov    -0x7fef3ff4(,%eax,4),%edx
80106e67:	b9 08 00 00 8e       	mov    $0x8e000008,%ecx
80106e6c:	89 0c c5 02 7a 11 80 	mov    %ecx,-0x7fee85fe(,%eax,8)
80106e73:	66 89 14 c5 00 7a 11 	mov    %dx,-0x7fee8600(,%eax,8)
80106e7a:	80 
80106e7b:	c1 ea 10             	shr    $0x10,%edx
80106e7e:	66 89 14 c5 06 7a 11 	mov    %dx,-0x7fee85fa(,%eax,8)
80106e85:	80 
  for(i = 0; i < 256; i++)
80106e86:	40                   	inc    %eax
80106e87:	3d 00 01 00 00       	cmp    $0x100,%eax
80106e8c:	75 d2                	jne    80106e60 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106e8e:	a1 0c c1 10 80       	mov    0x8010c10c,%eax

  initlock(&tickslock, "time");
80106e93:	b9 49 8f 10 80       	mov    $0x80108f49,%ecx
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106e98:	ba 08 00 00 ef       	mov    $0xef000008,%edx
  initlock(&tickslock, "time");
80106e9d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80106ea1:	c7 04 24 c0 79 11 80 	movl   $0x801179c0,(%esp)
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106ea8:	89 15 02 7c 11 80    	mov    %edx,0x80117c02
80106eae:	66 a3 00 7c 11 80    	mov    %ax,0x80117c00
80106eb4:	c1 e8 10             	shr    $0x10,%eax
80106eb7:	66 a3 06 7c 11 80    	mov    %ax,0x80117c06
  initlock(&tickslock, "time");
80106ebd:	e8 0e ea ff ff       	call   801058d0 <initlock>
}
80106ec2:	c9                   	leave  
80106ec3:	c3                   	ret    
80106ec4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106eca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106ed0 <idtinit>:

void
idtinit(void)
{
80106ed0:	55                   	push   %ebp
  pd[1] = (uint)p;
80106ed1:	b8 00 7a 11 80       	mov    $0x80117a00,%eax
80106ed6:	89 e5                	mov    %esp,%ebp
80106ed8:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
80106edb:	c1 e8 10             	shr    $0x10,%eax
80106ede:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
80106ee1:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
80106ee7:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106eeb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80106eef:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106ef2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106ef5:	c9                   	leave  
80106ef6:	c3                   	ret    
80106ef7:	89 f6                	mov    %esi,%esi
80106ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f00 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106f00:	55                   	push   %ebp
80106f01:	89 e5                	mov    %esp,%ebp
80106f03:	83 ec 48             	sub    $0x48,%esp
80106f06:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80106f09:	8b 5d 08             	mov    0x8(%ebp),%ebx
80106f0c:	89 75 f8             	mov    %esi,-0x8(%ebp)
80106f0f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(tf->trapno == T_SYSCALL){
80106f12:	8b 43 30             	mov    0x30(%ebx),%eax
80106f15:	83 f8 40             	cmp    $0x40,%eax
80106f18:	0f 84 02 01 00 00    	je     80107020 <trap+0x120>
    if(myproc()->killed)
      exit(0);
    return;
  }

  switch(tf->trapno){
80106f1e:	83 e8 20             	sub    $0x20,%eax
80106f21:	83 f8 1f             	cmp    $0x1f,%eax
80106f24:	77 0a                	ja     80106f30 <trap+0x30>
80106f26:	ff 24 85 f0 8f 10 80 	jmp    *-0x7fef7010(,%eax,4)
80106f2d:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80106f30:	e8 6b ca ff ff       	call   801039a0 <myproc>
80106f35:	8b 7b 38             	mov    0x38(%ebx),%edi
80106f38:	85 c0                	test   %eax,%eax
80106f3a:	0f 84 64 02 00 00    	je     801071a4 <trap+0x2a4>
80106f40:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106f44:	0f 84 5a 02 00 00    	je     801071a4 <trap+0x2a4>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106f4a:	0f 20 d1             	mov    %cr2,%ecx
80106f4d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106f50:	e8 2b ca ff ff       	call   80103980 <cpuid>
80106f55:	8b 73 30             	mov    0x30(%ebx),%esi
80106f58:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106f5b:	8b 43 34             	mov    0x34(%ebx),%eax
80106f5e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106f61:	e8 3a ca ff ff       	call   801039a0 <myproc>
80106f66:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106f69:	e8 32 ca ff ff       	call   801039a0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106f6e:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106f71:	89 74 24 0c          	mov    %esi,0xc(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
80106f75:	8b 75 e0             	mov    -0x20(%ebp),%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106f78:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106f7b:	89 7c 24 18          	mov    %edi,0x18(%esp)
80106f7f:	89 54 24 14          	mov    %edx,0x14(%esp)
80106f83:	8b 55 e4             	mov    -0x1c(%ebp),%edx
            myproc()->pid, myproc()->name, tf->trapno,
80106f86:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106f89:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
80106f8d:	89 74 24 08          	mov    %esi,0x8(%esp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106f91:	89 54 24 10          	mov    %edx,0x10(%esp)
80106f95:	8b 40 10             	mov    0x10(%eax),%eax
80106f98:	c7 04 24 ac 8f 10 80 	movl   $0x80108fac,(%esp)
80106f9f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106fa3:	e8 a8 96 ff ff       	call   80100650 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80106fa8:	e8 f3 c9 ff ff       	call   801039a0 <myproc>
80106fad:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106fb4:	e8 e7 c9 ff ff       	call   801039a0 <myproc>
80106fb9:	85 c0                	test   %eax,%eax
80106fbb:	74 1b                	je     80106fd8 <trap+0xd8>
80106fbd:	e8 de c9 ff ff       	call   801039a0 <myproc>
80106fc2:	8b 50 24             	mov    0x24(%eax),%edx
80106fc5:	85 d2                	test   %edx,%edx
80106fc7:	74 0f                	je     80106fd8 <trap+0xd8>
80106fc9:	8b 43 3c             	mov    0x3c(%ebx),%eax
80106fcc:	83 e0 03             	and    $0x3,%eax
80106fcf:	83 f8 03             	cmp    $0x3,%eax
80106fd2:	0f 84 80 01 00 00    	je     80107158 <trap+0x258>
    exit(0);

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106fd8:	e8 c3 c9 ff ff       	call   801039a0 <myproc>
80106fdd:	85 c0                	test   %eax,%eax
80106fdf:	74 0d                	je     80106fee <trap+0xee>
80106fe1:	e8 ba c9 ff ff       	call   801039a0 <myproc>
80106fe6:	8b 40 0c             	mov    0xc(%eax),%eax
80106fe9:	83 f8 04             	cmp    $0x4,%eax
80106fec:	74 7a                	je     80107068 <trap+0x168>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106fee:	e8 ad c9 ff ff       	call   801039a0 <myproc>
80106ff3:	85 c0                	test   %eax,%eax
80106ff5:	74 17                	je     8010700e <trap+0x10e>
80106ff7:	e8 a4 c9 ff ff       	call   801039a0 <myproc>
80106ffc:	8b 40 24             	mov    0x24(%eax),%eax
80106fff:	85 c0                	test   %eax,%eax
80107001:	74 0b                	je     8010700e <trap+0x10e>
80107003:	8b 43 3c             	mov    0x3c(%ebx),%eax
80107006:	83 e0 03             	and    $0x3,%eax
80107009:	83 f8 03             	cmp    $0x3,%eax
8010700c:	74 3b                	je     80107049 <trap+0x149>
    exit(0);
}
8010700e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107011:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107014:	8b 7d fc             	mov    -0x4(%ebp),%edi
80107017:	89 ec                	mov    %ebp,%esp
80107019:	5d                   	pop    %ebp
8010701a:	c3                   	ret    
8010701b:	90                   	nop
8010701c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80107020:	e8 7b c9 ff ff       	call   801039a0 <myproc>
80107025:	8b 70 24             	mov    0x24(%eax),%esi
80107028:	85 f6                	test   %esi,%esi
8010702a:	0f 85 10 01 00 00    	jne    80107140 <trap+0x240>
    myproc()->tf = tf;
80107030:	e8 6b c9 ff ff       	call   801039a0 <myproc>
80107035:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80107038:	e8 b3 ee ff ff       	call   80105ef0 <syscall>
    if(myproc()->killed)
8010703d:	e8 5e c9 ff ff       	call   801039a0 <myproc>
80107042:	8b 48 24             	mov    0x24(%eax),%ecx
80107045:	85 c9                	test   %ecx,%ecx
80107047:	74 c5                	je     8010700e <trap+0x10e>
      exit(0);
80107049:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
}
80107050:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107053:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107056:	8b 7d fc             	mov    -0x4(%ebp),%edi
80107059:	89 ec                	mov    %ebp,%esp
8010705b:	5d                   	pop    %ebp
      exit(0);
8010705c:	e9 9f d1 ff ff       	jmp    80104200 <exit>
80107061:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(myproc() && myproc()->state == RUNNING &&
80107068:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
8010706c:	75 80                	jne    80106fee <trap+0xee>
    yield();
8010706e:	e8 7d d2 ff ff       	call   801042f0 <yield>
80107073:	e9 76 ff ff ff       	jmp    80106fee <trap+0xee>
80107078:	90                   	nop
80107079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80107080:	e8 fb c8 ff ff       	call   80103980 <cpuid>
80107085:	85 c0                	test   %eax,%eax
80107087:	0f 84 e3 00 00 00    	je     80107170 <trap+0x270>
8010708d:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
80107090:	e8 bb b7 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107095:	e8 06 c9 ff ff       	call   801039a0 <myproc>
8010709a:	85 c0                	test   %eax,%eax
8010709c:	0f 85 1b ff ff ff    	jne    80106fbd <trap+0xbd>
801070a2:	e9 31 ff ff ff       	jmp    80106fd8 <trap+0xd8>
801070a7:	89 f6                	mov    %esi,%esi
801070a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    kbdintr();
801070b0:	e8 5b b6 ff ff       	call   80102710 <kbdintr>
    lapiceoi();
801070b5:	e8 96 b7 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801070ba:	e8 e1 c8 ff ff       	call   801039a0 <myproc>
801070bf:	85 c0                	test   %eax,%eax
801070c1:	0f 85 f6 fe ff ff    	jne    80106fbd <trap+0xbd>
801070c7:	e9 0c ff ff ff       	jmp    80106fd8 <trap+0xd8>
801070cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
801070d0:	e8 6b 02 00 00       	call   80107340 <uartintr>
    lapiceoi();
801070d5:	e8 76 b7 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801070da:	e8 c1 c8 ff ff       	call   801039a0 <myproc>
801070df:	85 c0                	test   %eax,%eax
801070e1:	0f 85 d6 fe ff ff    	jne    80106fbd <trap+0xbd>
801070e7:	e9 ec fe ff ff       	jmp    80106fd8 <trap+0xd8>
801070ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801070f0:	8b 7b 38             	mov    0x38(%ebx),%edi
801070f3:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801070f7:	e8 84 c8 ff ff       	call   80103980 <cpuid>
801070fc:	c7 04 24 54 8f 10 80 	movl   $0x80108f54,(%esp)
80107103:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80107107:	89 74 24 08          	mov    %esi,0x8(%esp)
8010710b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010710f:	e8 3c 95 ff ff       	call   80100650 <cprintf>
    lapiceoi();
80107114:	e8 37 b7 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107119:	e8 82 c8 ff ff       	call   801039a0 <myproc>
8010711e:	85 c0                	test   %eax,%eax
80107120:	0f 85 97 fe ff ff    	jne    80106fbd <trap+0xbd>
80107126:	e9 ad fe ff ff       	jmp    80106fd8 <trap+0xd8>
8010712b:	90                   	nop
8010712c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80107130:	e8 2b b0 ff ff       	call   80102160 <ideintr>
80107135:	e9 53 ff ff ff       	jmp    8010708d <trap+0x18d>
8010713a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit(0);
80107140:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80107147:	e8 b4 d0 ff ff       	call   80104200 <exit>
8010714c:	e9 df fe ff ff       	jmp    80107030 <trap+0x130>
80107151:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit(0);
80107158:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010715f:	e8 9c d0 ff ff       	call   80104200 <exit>
80107164:	e9 6f fe ff ff       	jmp    80106fd8 <trap+0xd8>
80107169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      acquire(&tickslock);
80107170:	c7 04 24 c0 79 11 80 	movl   $0x801179c0,(%esp)
80107177:	e8 a4 e8 ff ff       	call   80105a20 <acquire>
      ticks++;
8010717c:	ff 05 00 82 11 80    	incl   0x80118200
      updatePerformance();
80107182:	e8 99 d8 ff ff       	call   80104a20 <updatePerformance>
      wakeup(&ticks);
80107187:	c7 04 24 00 82 11 80 	movl   $0x80118200,(%esp)
8010718e:	e8 3d d4 ff ff       	call   801045d0 <wakeup>
      release(&tickslock);
80107193:	c7 04 24 c0 79 11 80 	movl   $0x801179c0,(%esp)
8010719a:	e8 21 e9 ff ff       	call   80105ac0 <release>
8010719f:	e9 e9 fe ff ff       	jmp    8010708d <trap+0x18d>
801071a4:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801071a7:	e8 d4 c7 ff ff       	call   80103980 <cpuid>
801071ac:	89 74 24 10          	mov    %esi,0x10(%esp)
801071b0:	89 7c 24 0c          	mov    %edi,0xc(%esp)
801071b4:	89 44 24 08          	mov    %eax,0x8(%esp)
801071b8:	8b 43 30             	mov    0x30(%ebx),%eax
801071bb:	c7 04 24 78 8f 10 80 	movl   $0x80108f78,(%esp)
801071c2:	89 44 24 04          	mov    %eax,0x4(%esp)
801071c6:	e8 85 94 ff ff       	call   80100650 <cprintf>
      panic("trap");
801071cb:	c7 04 24 4e 8f 10 80 	movl   $0x80108f4e,(%esp)
801071d2:	e8 99 91 ff ff       	call   80100370 <panic>
801071d7:	66 90                	xchg   %ax,%ax
801071d9:	66 90                	xchg   %ax,%ax
801071db:	66 90                	xchg   %ax,%ax
801071dd:	66 90                	xchg   %ax,%ax
801071df:	90                   	nop

801071e0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801071e0:	a1 14 c6 10 80       	mov    0x8010c614,%eax
{
801071e5:	55                   	push   %ebp
801071e6:	89 e5                	mov    %esp,%ebp
  if(!uart)
801071e8:	85 c0                	test   %eax,%eax
801071ea:	74 1c                	je     80107208 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801071ec:	ba fd 03 00 00       	mov    $0x3fd,%edx
801071f1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801071f2:	24 01                	and    $0x1,%al
801071f4:	84 c0                	test   %al,%al
801071f6:	74 10                	je     80107208 <uartgetc+0x28>
801071f8:	ba f8 03 00 00       	mov    $0x3f8,%edx
801071fd:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801071fe:	0f b6 c0             	movzbl %al,%eax
}
80107201:	5d                   	pop    %ebp
80107202:	c3                   	ret    
80107203:	90                   	nop
80107204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80107208:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010720d:	5d                   	pop    %ebp
8010720e:	c3                   	ret    
8010720f:	90                   	nop

80107210 <uartputc.part.0>:
uartputc(int c)
80107210:	55                   	push   %ebp
80107211:	89 e5                	mov    %esp,%ebp
80107213:	56                   	push   %esi
80107214:	be fd 03 00 00       	mov    $0x3fd,%esi
80107219:	53                   	push   %ebx
8010721a:	bb 80 00 00 00       	mov    $0x80,%ebx
8010721f:	83 ec 20             	sub    $0x20,%esp
80107222:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107225:	eb 18                	jmp    8010723f <uartputc.part.0+0x2f>
80107227:	89 f6                	mov    %esi,%esi
80107229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80107230:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80107237:	e8 34 b6 ff ff       	call   80102870 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010723c:	4b                   	dec    %ebx
8010723d:	74 09                	je     80107248 <uartputc.part.0+0x38>
8010723f:	89 f2                	mov    %esi,%edx
80107241:	ec                   	in     (%dx),%al
80107242:	24 20                	and    $0x20,%al
80107244:	84 c0                	test   %al,%al
80107246:	74 e8                	je     80107230 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107248:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010724d:	0f b6 45 f4          	movzbl -0xc(%ebp),%eax
80107251:	ee                   	out    %al,(%dx)
}
80107252:	83 c4 20             	add    $0x20,%esp
80107255:	5b                   	pop    %ebx
80107256:	5e                   	pop    %esi
80107257:	5d                   	pop    %ebp
80107258:	c3                   	ret    
80107259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107260 <uartinit>:
{
80107260:	55                   	push   %ebp
80107261:	31 c9                	xor    %ecx,%ecx
80107263:	89 e5                	mov    %esp,%ebp
80107265:	88 c8                	mov    %cl,%al
80107267:	57                   	push   %edi
80107268:	56                   	push   %esi
80107269:	53                   	push   %ebx
8010726a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010726f:	83 ec 1c             	sub    $0x1c,%esp
80107272:	89 da                	mov    %ebx,%edx
80107274:	ee                   	out    %al,(%dx)
80107275:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010727a:	b0 80                	mov    $0x80,%al
8010727c:	89 fa                	mov    %edi,%edx
8010727e:	ee                   	out    %al,(%dx)
8010727f:	b0 0c                	mov    $0xc,%al
80107281:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107286:	ee                   	out    %al,(%dx)
80107287:	be f9 03 00 00       	mov    $0x3f9,%esi
8010728c:	88 c8                	mov    %cl,%al
8010728e:	89 f2                	mov    %esi,%edx
80107290:	ee                   	out    %al,(%dx)
80107291:	b0 03                	mov    $0x3,%al
80107293:	89 fa                	mov    %edi,%edx
80107295:	ee                   	out    %al,(%dx)
80107296:	ba fc 03 00 00       	mov    $0x3fc,%edx
8010729b:	88 c8                	mov    %cl,%al
8010729d:	ee                   	out    %al,(%dx)
8010729e:	b0 01                	mov    $0x1,%al
801072a0:	89 f2                	mov    %esi,%edx
801072a2:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801072a3:	ba fd 03 00 00       	mov    $0x3fd,%edx
801072a8:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801072a9:	fe c0                	inc    %al
801072ab:	74 52                	je     801072ff <uartinit+0x9f>
  uart = 1;
801072ad:	b9 01 00 00 00       	mov    $0x1,%ecx
801072b2:	89 da                	mov    %ebx,%edx
801072b4:	89 0d 14 c6 10 80    	mov    %ecx,0x8010c614
801072ba:	ec                   	in     (%dx),%al
801072bb:	ba f8 03 00 00       	mov    $0x3f8,%edx
801072c0:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801072c1:	31 db                	xor    %ebx,%ebx
801072c3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  for(p="xv6...\n"; *p; p++)
801072c7:	bb 70 90 10 80       	mov    $0x80109070,%ebx
  ioapicenable(IRQ_COM1, 0);
801072cc:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
801072d3:	e8 c8 b0 ff ff       	call   801023a0 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
801072d8:	b8 78 00 00 00       	mov    $0x78,%eax
801072dd:	eb 09                	jmp    801072e8 <uartinit+0x88>
801072df:	90                   	nop
801072e0:	43                   	inc    %ebx
801072e1:	0f be 03             	movsbl (%ebx),%eax
801072e4:	84 c0                	test   %al,%al
801072e6:	74 17                	je     801072ff <uartinit+0x9f>
  if(!uart)
801072e8:	8b 15 14 c6 10 80    	mov    0x8010c614,%edx
801072ee:	85 d2                	test   %edx,%edx
801072f0:	74 ee                	je     801072e0 <uartinit+0x80>
  for(p="xv6...\n"; *p; p++)
801072f2:	43                   	inc    %ebx
801072f3:	e8 18 ff ff ff       	call   80107210 <uartputc.part.0>
801072f8:	0f be 03             	movsbl (%ebx),%eax
801072fb:	84 c0                	test   %al,%al
801072fd:	75 e9                	jne    801072e8 <uartinit+0x88>
}
801072ff:	83 c4 1c             	add    $0x1c,%esp
80107302:	5b                   	pop    %ebx
80107303:	5e                   	pop    %esi
80107304:	5f                   	pop    %edi
80107305:	5d                   	pop    %ebp
80107306:	c3                   	ret    
80107307:	89 f6                	mov    %esi,%esi
80107309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107310 <uartputc>:
  if(!uart)
80107310:	8b 15 14 c6 10 80    	mov    0x8010c614,%edx
{
80107316:	55                   	push   %ebp
80107317:	89 e5                	mov    %esp,%ebp
80107319:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
8010731c:	85 d2                	test   %edx,%edx
8010731e:	74 10                	je     80107330 <uartputc+0x20>
}
80107320:	5d                   	pop    %ebp
80107321:	e9 ea fe ff ff       	jmp    80107210 <uartputc.part.0>
80107326:	8d 76 00             	lea    0x0(%esi),%esi
80107329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107330:	5d                   	pop    %ebp
80107331:	c3                   	ret    
80107332:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107340 <uartintr>:

void
uartintr(void)
{
80107340:	55                   	push   %ebp
80107341:	89 e5                	mov    %esp,%ebp
80107343:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80107346:	c7 04 24 e0 71 10 80 	movl   $0x801071e0,(%esp)
8010734d:	e8 7e 94 ff ff       	call   801007d0 <consoleintr>
}
80107352:	c9                   	leave  
80107353:	c3                   	ret    

80107354 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80107354:	6a 00                	push   $0x0
  pushl $0
80107356:	6a 00                	push   $0x0
  jmp alltraps
80107358:	e9 ca fa ff ff       	jmp    80106e27 <alltraps>

8010735d <vector1>:
.globl vector1
vector1:
  pushl $0
8010735d:	6a 00                	push   $0x0
  pushl $1
8010735f:	6a 01                	push   $0x1
  jmp alltraps
80107361:	e9 c1 fa ff ff       	jmp    80106e27 <alltraps>

80107366 <vector2>:
.globl vector2
vector2:
  pushl $0
80107366:	6a 00                	push   $0x0
  pushl $2
80107368:	6a 02                	push   $0x2
  jmp alltraps
8010736a:	e9 b8 fa ff ff       	jmp    80106e27 <alltraps>

8010736f <vector3>:
.globl vector3
vector3:
  pushl $0
8010736f:	6a 00                	push   $0x0
  pushl $3
80107371:	6a 03                	push   $0x3
  jmp alltraps
80107373:	e9 af fa ff ff       	jmp    80106e27 <alltraps>

80107378 <vector4>:
.globl vector4
vector4:
  pushl $0
80107378:	6a 00                	push   $0x0
  pushl $4
8010737a:	6a 04                	push   $0x4
  jmp alltraps
8010737c:	e9 a6 fa ff ff       	jmp    80106e27 <alltraps>

80107381 <vector5>:
.globl vector5
vector5:
  pushl $0
80107381:	6a 00                	push   $0x0
  pushl $5
80107383:	6a 05                	push   $0x5
  jmp alltraps
80107385:	e9 9d fa ff ff       	jmp    80106e27 <alltraps>

8010738a <vector6>:
.globl vector6
vector6:
  pushl $0
8010738a:	6a 00                	push   $0x0
  pushl $6
8010738c:	6a 06                	push   $0x6
  jmp alltraps
8010738e:	e9 94 fa ff ff       	jmp    80106e27 <alltraps>

80107393 <vector7>:
.globl vector7
vector7:
  pushl $0
80107393:	6a 00                	push   $0x0
  pushl $7
80107395:	6a 07                	push   $0x7
  jmp alltraps
80107397:	e9 8b fa ff ff       	jmp    80106e27 <alltraps>

8010739c <vector8>:
.globl vector8
vector8:
  pushl $8
8010739c:	6a 08                	push   $0x8
  jmp alltraps
8010739e:	e9 84 fa ff ff       	jmp    80106e27 <alltraps>

801073a3 <vector9>:
.globl vector9
vector9:
  pushl $0
801073a3:	6a 00                	push   $0x0
  pushl $9
801073a5:	6a 09                	push   $0x9
  jmp alltraps
801073a7:	e9 7b fa ff ff       	jmp    80106e27 <alltraps>

801073ac <vector10>:
.globl vector10
vector10:
  pushl $10
801073ac:	6a 0a                	push   $0xa
  jmp alltraps
801073ae:	e9 74 fa ff ff       	jmp    80106e27 <alltraps>

801073b3 <vector11>:
.globl vector11
vector11:
  pushl $11
801073b3:	6a 0b                	push   $0xb
  jmp alltraps
801073b5:	e9 6d fa ff ff       	jmp    80106e27 <alltraps>

801073ba <vector12>:
.globl vector12
vector12:
  pushl $12
801073ba:	6a 0c                	push   $0xc
  jmp alltraps
801073bc:	e9 66 fa ff ff       	jmp    80106e27 <alltraps>

801073c1 <vector13>:
.globl vector13
vector13:
  pushl $13
801073c1:	6a 0d                	push   $0xd
  jmp alltraps
801073c3:	e9 5f fa ff ff       	jmp    80106e27 <alltraps>

801073c8 <vector14>:
.globl vector14
vector14:
  pushl $14
801073c8:	6a 0e                	push   $0xe
  jmp alltraps
801073ca:	e9 58 fa ff ff       	jmp    80106e27 <alltraps>

801073cf <vector15>:
.globl vector15
vector15:
  pushl $0
801073cf:	6a 00                	push   $0x0
  pushl $15
801073d1:	6a 0f                	push   $0xf
  jmp alltraps
801073d3:	e9 4f fa ff ff       	jmp    80106e27 <alltraps>

801073d8 <vector16>:
.globl vector16
vector16:
  pushl $0
801073d8:	6a 00                	push   $0x0
  pushl $16
801073da:	6a 10                	push   $0x10
  jmp alltraps
801073dc:	e9 46 fa ff ff       	jmp    80106e27 <alltraps>

801073e1 <vector17>:
.globl vector17
vector17:
  pushl $17
801073e1:	6a 11                	push   $0x11
  jmp alltraps
801073e3:	e9 3f fa ff ff       	jmp    80106e27 <alltraps>

801073e8 <vector18>:
.globl vector18
vector18:
  pushl $0
801073e8:	6a 00                	push   $0x0
  pushl $18
801073ea:	6a 12                	push   $0x12
  jmp alltraps
801073ec:	e9 36 fa ff ff       	jmp    80106e27 <alltraps>

801073f1 <vector19>:
.globl vector19
vector19:
  pushl $0
801073f1:	6a 00                	push   $0x0
  pushl $19
801073f3:	6a 13                	push   $0x13
  jmp alltraps
801073f5:	e9 2d fa ff ff       	jmp    80106e27 <alltraps>

801073fa <vector20>:
.globl vector20
vector20:
  pushl $0
801073fa:	6a 00                	push   $0x0
  pushl $20
801073fc:	6a 14                	push   $0x14
  jmp alltraps
801073fe:	e9 24 fa ff ff       	jmp    80106e27 <alltraps>

80107403 <vector21>:
.globl vector21
vector21:
  pushl $0
80107403:	6a 00                	push   $0x0
  pushl $21
80107405:	6a 15                	push   $0x15
  jmp alltraps
80107407:	e9 1b fa ff ff       	jmp    80106e27 <alltraps>

8010740c <vector22>:
.globl vector22
vector22:
  pushl $0
8010740c:	6a 00                	push   $0x0
  pushl $22
8010740e:	6a 16                	push   $0x16
  jmp alltraps
80107410:	e9 12 fa ff ff       	jmp    80106e27 <alltraps>

80107415 <vector23>:
.globl vector23
vector23:
  pushl $0
80107415:	6a 00                	push   $0x0
  pushl $23
80107417:	6a 17                	push   $0x17
  jmp alltraps
80107419:	e9 09 fa ff ff       	jmp    80106e27 <alltraps>

8010741e <vector24>:
.globl vector24
vector24:
  pushl $0
8010741e:	6a 00                	push   $0x0
  pushl $24
80107420:	6a 18                	push   $0x18
  jmp alltraps
80107422:	e9 00 fa ff ff       	jmp    80106e27 <alltraps>

80107427 <vector25>:
.globl vector25
vector25:
  pushl $0
80107427:	6a 00                	push   $0x0
  pushl $25
80107429:	6a 19                	push   $0x19
  jmp alltraps
8010742b:	e9 f7 f9 ff ff       	jmp    80106e27 <alltraps>

80107430 <vector26>:
.globl vector26
vector26:
  pushl $0
80107430:	6a 00                	push   $0x0
  pushl $26
80107432:	6a 1a                	push   $0x1a
  jmp alltraps
80107434:	e9 ee f9 ff ff       	jmp    80106e27 <alltraps>

80107439 <vector27>:
.globl vector27
vector27:
  pushl $0
80107439:	6a 00                	push   $0x0
  pushl $27
8010743b:	6a 1b                	push   $0x1b
  jmp alltraps
8010743d:	e9 e5 f9 ff ff       	jmp    80106e27 <alltraps>

80107442 <vector28>:
.globl vector28
vector28:
  pushl $0
80107442:	6a 00                	push   $0x0
  pushl $28
80107444:	6a 1c                	push   $0x1c
  jmp alltraps
80107446:	e9 dc f9 ff ff       	jmp    80106e27 <alltraps>

8010744b <vector29>:
.globl vector29
vector29:
  pushl $0
8010744b:	6a 00                	push   $0x0
  pushl $29
8010744d:	6a 1d                	push   $0x1d
  jmp alltraps
8010744f:	e9 d3 f9 ff ff       	jmp    80106e27 <alltraps>

80107454 <vector30>:
.globl vector30
vector30:
  pushl $0
80107454:	6a 00                	push   $0x0
  pushl $30
80107456:	6a 1e                	push   $0x1e
  jmp alltraps
80107458:	e9 ca f9 ff ff       	jmp    80106e27 <alltraps>

8010745d <vector31>:
.globl vector31
vector31:
  pushl $0
8010745d:	6a 00                	push   $0x0
  pushl $31
8010745f:	6a 1f                	push   $0x1f
  jmp alltraps
80107461:	e9 c1 f9 ff ff       	jmp    80106e27 <alltraps>

80107466 <vector32>:
.globl vector32
vector32:
  pushl $0
80107466:	6a 00                	push   $0x0
  pushl $32
80107468:	6a 20                	push   $0x20
  jmp alltraps
8010746a:	e9 b8 f9 ff ff       	jmp    80106e27 <alltraps>

8010746f <vector33>:
.globl vector33
vector33:
  pushl $0
8010746f:	6a 00                	push   $0x0
  pushl $33
80107471:	6a 21                	push   $0x21
  jmp alltraps
80107473:	e9 af f9 ff ff       	jmp    80106e27 <alltraps>

80107478 <vector34>:
.globl vector34
vector34:
  pushl $0
80107478:	6a 00                	push   $0x0
  pushl $34
8010747a:	6a 22                	push   $0x22
  jmp alltraps
8010747c:	e9 a6 f9 ff ff       	jmp    80106e27 <alltraps>

80107481 <vector35>:
.globl vector35
vector35:
  pushl $0
80107481:	6a 00                	push   $0x0
  pushl $35
80107483:	6a 23                	push   $0x23
  jmp alltraps
80107485:	e9 9d f9 ff ff       	jmp    80106e27 <alltraps>

8010748a <vector36>:
.globl vector36
vector36:
  pushl $0
8010748a:	6a 00                	push   $0x0
  pushl $36
8010748c:	6a 24                	push   $0x24
  jmp alltraps
8010748e:	e9 94 f9 ff ff       	jmp    80106e27 <alltraps>

80107493 <vector37>:
.globl vector37
vector37:
  pushl $0
80107493:	6a 00                	push   $0x0
  pushl $37
80107495:	6a 25                	push   $0x25
  jmp alltraps
80107497:	e9 8b f9 ff ff       	jmp    80106e27 <alltraps>

8010749c <vector38>:
.globl vector38
vector38:
  pushl $0
8010749c:	6a 00                	push   $0x0
  pushl $38
8010749e:	6a 26                	push   $0x26
  jmp alltraps
801074a0:	e9 82 f9 ff ff       	jmp    80106e27 <alltraps>

801074a5 <vector39>:
.globl vector39
vector39:
  pushl $0
801074a5:	6a 00                	push   $0x0
  pushl $39
801074a7:	6a 27                	push   $0x27
  jmp alltraps
801074a9:	e9 79 f9 ff ff       	jmp    80106e27 <alltraps>

801074ae <vector40>:
.globl vector40
vector40:
  pushl $0
801074ae:	6a 00                	push   $0x0
  pushl $40
801074b0:	6a 28                	push   $0x28
  jmp alltraps
801074b2:	e9 70 f9 ff ff       	jmp    80106e27 <alltraps>

801074b7 <vector41>:
.globl vector41
vector41:
  pushl $0
801074b7:	6a 00                	push   $0x0
  pushl $41
801074b9:	6a 29                	push   $0x29
  jmp alltraps
801074bb:	e9 67 f9 ff ff       	jmp    80106e27 <alltraps>

801074c0 <vector42>:
.globl vector42
vector42:
  pushl $0
801074c0:	6a 00                	push   $0x0
  pushl $42
801074c2:	6a 2a                	push   $0x2a
  jmp alltraps
801074c4:	e9 5e f9 ff ff       	jmp    80106e27 <alltraps>

801074c9 <vector43>:
.globl vector43
vector43:
  pushl $0
801074c9:	6a 00                	push   $0x0
  pushl $43
801074cb:	6a 2b                	push   $0x2b
  jmp alltraps
801074cd:	e9 55 f9 ff ff       	jmp    80106e27 <alltraps>

801074d2 <vector44>:
.globl vector44
vector44:
  pushl $0
801074d2:	6a 00                	push   $0x0
  pushl $44
801074d4:	6a 2c                	push   $0x2c
  jmp alltraps
801074d6:	e9 4c f9 ff ff       	jmp    80106e27 <alltraps>

801074db <vector45>:
.globl vector45
vector45:
  pushl $0
801074db:	6a 00                	push   $0x0
  pushl $45
801074dd:	6a 2d                	push   $0x2d
  jmp alltraps
801074df:	e9 43 f9 ff ff       	jmp    80106e27 <alltraps>

801074e4 <vector46>:
.globl vector46
vector46:
  pushl $0
801074e4:	6a 00                	push   $0x0
  pushl $46
801074e6:	6a 2e                	push   $0x2e
  jmp alltraps
801074e8:	e9 3a f9 ff ff       	jmp    80106e27 <alltraps>

801074ed <vector47>:
.globl vector47
vector47:
  pushl $0
801074ed:	6a 00                	push   $0x0
  pushl $47
801074ef:	6a 2f                	push   $0x2f
  jmp alltraps
801074f1:	e9 31 f9 ff ff       	jmp    80106e27 <alltraps>

801074f6 <vector48>:
.globl vector48
vector48:
  pushl $0
801074f6:	6a 00                	push   $0x0
  pushl $48
801074f8:	6a 30                	push   $0x30
  jmp alltraps
801074fa:	e9 28 f9 ff ff       	jmp    80106e27 <alltraps>

801074ff <vector49>:
.globl vector49
vector49:
  pushl $0
801074ff:	6a 00                	push   $0x0
  pushl $49
80107501:	6a 31                	push   $0x31
  jmp alltraps
80107503:	e9 1f f9 ff ff       	jmp    80106e27 <alltraps>

80107508 <vector50>:
.globl vector50
vector50:
  pushl $0
80107508:	6a 00                	push   $0x0
  pushl $50
8010750a:	6a 32                	push   $0x32
  jmp alltraps
8010750c:	e9 16 f9 ff ff       	jmp    80106e27 <alltraps>

80107511 <vector51>:
.globl vector51
vector51:
  pushl $0
80107511:	6a 00                	push   $0x0
  pushl $51
80107513:	6a 33                	push   $0x33
  jmp alltraps
80107515:	e9 0d f9 ff ff       	jmp    80106e27 <alltraps>

8010751a <vector52>:
.globl vector52
vector52:
  pushl $0
8010751a:	6a 00                	push   $0x0
  pushl $52
8010751c:	6a 34                	push   $0x34
  jmp alltraps
8010751e:	e9 04 f9 ff ff       	jmp    80106e27 <alltraps>

80107523 <vector53>:
.globl vector53
vector53:
  pushl $0
80107523:	6a 00                	push   $0x0
  pushl $53
80107525:	6a 35                	push   $0x35
  jmp alltraps
80107527:	e9 fb f8 ff ff       	jmp    80106e27 <alltraps>

8010752c <vector54>:
.globl vector54
vector54:
  pushl $0
8010752c:	6a 00                	push   $0x0
  pushl $54
8010752e:	6a 36                	push   $0x36
  jmp alltraps
80107530:	e9 f2 f8 ff ff       	jmp    80106e27 <alltraps>

80107535 <vector55>:
.globl vector55
vector55:
  pushl $0
80107535:	6a 00                	push   $0x0
  pushl $55
80107537:	6a 37                	push   $0x37
  jmp alltraps
80107539:	e9 e9 f8 ff ff       	jmp    80106e27 <alltraps>

8010753e <vector56>:
.globl vector56
vector56:
  pushl $0
8010753e:	6a 00                	push   $0x0
  pushl $56
80107540:	6a 38                	push   $0x38
  jmp alltraps
80107542:	e9 e0 f8 ff ff       	jmp    80106e27 <alltraps>

80107547 <vector57>:
.globl vector57
vector57:
  pushl $0
80107547:	6a 00                	push   $0x0
  pushl $57
80107549:	6a 39                	push   $0x39
  jmp alltraps
8010754b:	e9 d7 f8 ff ff       	jmp    80106e27 <alltraps>

80107550 <vector58>:
.globl vector58
vector58:
  pushl $0
80107550:	6a 00                	push   $0x0
  pushl $58
80107552:	6a 3a                	push   $0x3a
  jmp alltraps
80107554:	e9 ce f8 ff ff       	jmp    80106e27 <alltraps>

80107559 <vector59>:
.globl vector59
vector59:
  pushl $0
80107559:	6a 00                	push   $0x0
  pushl $59
8010755b:	6a 3b                	push   $0x3b
  jmp alltraps
8010755d:	e9 c5 f8 ff ff       	jmp    80106e27 <alltraps>

80107562 <vector60>:
.globl vector60
vector60:
  pushl $0
80107562:	6a 00                	push   $0x0
  pushl $60
80107564:	6a 3c                	push   $0x3c
  jmp alltraps
80107566:	e9 bc f8 ff ff       	jmp    80106e27 <alltraps>

8010756b <vector61>:
.globl vector61
vector61:
  pushl $0
8010756b:	6a 00                	push   $0x0
  pushl $61
8010756d:	6a 3d                	push   $0x3d
  jmp alltraps
8010756f:	e9 b3 f8 ff ff       	jmp    80106e27 <alltraps>

80107574 <vector62>:
.globl vector62
vector62:
  pushl $0
80107574:	6a 00                	push   $0x0
  pushl $62
80107576:	6a 3e                	push   $0x3e
  jmp alltraps
80107578:	e9 aa f8 ff ff       	jmp    80106e27 <alltraps>

8010757d <vector63>:
.globl vector63
vector63:
  pushl $0
8010757d:	6a 00                	push   $0x0
  pushl $63
8010757f:	6a 3f                	push   $0x3f
  jmp alltraps
80107581:	e9 a1 f8 ff ff       	jmp    80106e27 <alltraps>

80107586 <vector64>:
.globl vector64
vector64:
  pushl $0
80107586:	6a 00                	push   $0x0
  pushl $64
80107588:	6a 40                	push   $0x40
  jmp alltraps
8010758a:	e9 98 f8 ff ff       	jmp    80106e27 <alltraps>

8010758f <vector65>:
.globl vector65
vector65:
  pushl $0
8010758f:	6a 00                	push   $0x0
  pushl $65
80107591:	6a 41                	push   $0x41
  jmp alltraps
80107593:	e9 8f f8 ff ff       	jmp    80106e27 <alltraps>

80107598 <vector66>:
.globl vector66
vector66:
  pushl $0
80107598:	6a 00                	push   $0x0
  pushl $66
8010759a:	6a 42                	push   $0x42
  jmp alltraps
8010759c:	e9 86 f8 ff ff       	jmp    80106e27 <alltraps>

801075a1 <vector67>:
.globl vector67
vector67:
  pushl $0
801075a1:	6a 00                	push   $0x0
  pushl $67
801075a3:	6a 43                	push   $0x43
  jmp alltraps
801075a5:	e9 7d f8 ff ff       	jmp    80106e27 <alltraps>

801075aa <vector68>:
.globl vector68
vector68:
  pushl $0
801075aa:	6a 00                	push   $0x0
  pushl $68
801075ac:	6a 44                	push   $0x44
  jmp alltraps
801075ae:	e9 74 f8 ff ff       	jmp    80106e27 <alltraps>

801075b3 <vector69>:
.globl vector69
vector69:
  pushl $0
801075b3:	6a 00                	push   $0x0
  pushl $69
801075b5:	6a 45                	push   $0x45
  jmp alltraps
801075b7:	e9 6b f8 ff ff       	jmp    80106e27 <alltraps>

801075bc <vector70>:
.globl vector70
vector70:
  pushl $0
801075bc:	6a 00                	push   $0x0
  pushl $70
801075be:	6a 46                	push   $0x46
  jmp alltraps
801075c0:	e9 62 f8 ff ff       	jmp    80106e27 <alltraps>

801075c5 <vector71>:
.globl vector71
vector71:
  pushl $0
801075c5:	6a 00                	push   $0x0
  pushl $71
801075c7:	6a 47                	push   $0x47
  jmp alltraps
801075c9:	e9 59 f8 ff ff       	jmp    80106e27 <alltraps>

801075ce <vector72>:
.globl vector72
vector72:
  pushl $0
801075ce:	6a 00                	push   $0x0
  pushl $72
801075d0:	6a 48                	push   $0x48
  jmp alltraps
801075d2:	e9 50 f8 ff ff       	jmp    80106e27 <alltraps>

801075d7 <vector73>:
.globl vector73
vector73:
  pushl $0
801075d7:	6a 00                	push   $0x0
  pushl $73
801075d9:	6a 49                	push   $0x49
  jmp alltraps
801075db:	e9 47 f8 ff ff       	jmp    80106e27 <alltraps>

801075e0 <vector74>:
.globl vector74
vector74:
  pushl $0
801075e0:	6a 00                	push   $0x0
  pushl $74
801075e2:	6a 4a                	push   $0x4a
  jmp alltraps
801075e4:	e9 3e f8 ff ff       	jmp    80106e27 <alltraps>

801075e9 <vector75>:
.globl vector75
vector75:
  pushl $0
801075e9:	6a 00                	push   $0x0
  pushl $75
801075eb:	6a 4b                	push   $0x4b
  jmp alltraps
801075ed:	e9 35 f8 ff ff       	jmp    80106e27 <alltraps>

801075f2 <vector76>:
.globl vector76
vector76:
  pushl $0
801075f2:	6a 00                	push   $0x0
  pushl $76
801075f4:	6a 4c                	push   $0x4c
  jmp alltraps
801075f6:	e9 2c f8 ff ff       	jmp    80106e27 <alltraps>

801075fb <vector77>:
.globl vector77
vector77:
  pushl $0
801075fb:	6a 00                	push   $0x0
  pushl $77
801075fd:	6a 4d                	push   $0x4d
  jmp alltraps
801075ff:	e9 23 f8 ff ff       	jmp    80106e27 <alltraps>

80107604 <vector78>:
.globl vector78
vector78:
  pushl $0
80107604:	6a 00                	push   $0x0
  pushl $78
80107606:	6a 4e                	push   $0x4e
  jmp alltraps
80107608:	e9 1a f8 ff ff       	jmp    80106e27 <alltraps>

8010760d <vector79>:
.globl vector79
vector79:
  pushl $0
8010760d:	6a 00                	push   $0x0
  pushl $79
8010760f:	6a 4f                	push   $0x4f
  jmp alltraps
80107611:	e9 11 f8 ff ff       	jmp    80106e27 <alltraps>

80107616 <vector80>:
.globl vector80
vector80:
  pushl $0
80107616:	6a 00                	push   $0x0
  pushl $80
80107618:	6a 50                	push   $0x50
  jmp alltraps
8010761a:	e9 08 f8 ff ff       	jmp    80106e27 <alltraps>

8010761f <vector81>:
.globl vector81
vector81:
  pushl $0
8010761f:	6a 00                	push   $0x0
  pushl $81
80107621:	6a 51                	push   $0x51
  jmp alltraps
80107623:	e9 ff f7 ff ff       	jmp    80106e27 <alltraps>

80107628 <vector82>:
.globl vector82
vector82:
  pushl $0
80107628:	6a 00                	push   $0x0
  pushl $82
8010762a:	6a 52                	push   $0x52
  jmp alltraps
8010762c:	e9 f6 f7 ff ff       	jmp    80106e27 <alltraps>

80107631 <vector83>:
.globl vector83
vector83:
  pushl $0
80107631:	6a 00                	push   $0x0
  pushl $83
80107633:	6a 53                	push   $0x53
  jmp alltraps
80107635:	e9 ed f7 ff ff       	jmp    80106e27 <alltraps>

8010763a <vector84>:
.globl vector84
vector84:
  pushl $0
8010763a:	6a 00                	push   $0x0
  pushl $84
8010763c:	6a 54                	push   $0x54
  jmp alltraps
8010763e:	e9 e4 f7 ff ff       	jmp    80106e27 <alltraps>

80107643 <vector85>:
.globl vector85
vector85:
  pushl $0
80107643:	6a 00                	push   $0x0
  pushl $85
80107645:	6a 55                	push   $0x55
  jmp alltraps
80107647:	e9 db f7 ff ff       	jmp    80106e27 <alltraps>

8010764c <vector86>:
.globl vector86
vector86:
  pushl $0
8010764c:	6a 00                	push   $0x0
  pushl $86
8010764e:	6a 56                	push   $0x56
  jmp alltraps
80107650:	e9 d2 f7 ff ff       	jmp    80106e27 <alltraps>

80107655 <vector87>:
.globl vector87
vector87:
  pushl $0
80107655:	6a 00                	push   $0x0
  pushl $87
80107657:	6a 57                	push   $0x57
  jmp alltraps
80107659:	e9 c9 f7 ff ff       	jmp    80106e27 <alltraps>

8010765e <vector88>:
.globl vector88
vector88:
  pushl $0
8010765e:	6a 00                	push   $0x0
  pushl $88
80107660:	6a 58                	push   $0x58
  jmp alltraps
80107662:	e9 c0 f7 ff ff       	jmp    80106e27 <alltraps>

80107667 <vector89>:
.globl vector89
vector89:
  pushl $0
80107667:	6a 00                	push   $0x0
  pushl $89
80107669:	6a 59                	push   $0x59
  jmp alltraps
8010766b:	e9 b7 f7 ff ff       	jmp    80106e27 <alltraps>

80107670 <vector90>:
.globl vector90
vector90:
  pushl $0
80107670:	6a 00                	push   $0x0
  pushl $90
80107672:	6a 5a                	push   $0x5a
  jmp alltraps
80107674:	e9 ae f7 ff ff       	jmp    80106e27 <alltraps>

80107679 <vector91>:
.globl vector91
vector91:
  pushl $0
80107679:	6a 00                	push   $0x0
  pushl $91
8010767b:	6a 5b                	push   $0x5b
  jmp alltraps
8010767d:	e9 a5 f7 ff ff       	jmp    80106e27 <alltraps>

80107682 <vector92>:
.globl vector92
vector92:
  pushl $0
80107682:	6a 00                	push   $0x0
  pushl $92
80107684:	6a 5c                	push   $0x5c
  jmp alltraps
80107686:	e9 9c f7 ff ff       	jmp    80106e27 <alltraps>

8010768b <vector93>:
.globl vector93
vector93:
  pushl $0
8010768b:	6a 00                	push   $0x0
  pushl $93
8010768d:	6a 5d                	push   $0x5d
  jmp alltraps
8010768f:	e9 93 f7 ff ff       	jmp    80106e27 <alltraps>

80107694 <vector94>:
.globl vector94
vector94:
  pushl $0
80107694:	6a 00                	push   $0x0
  pushl $94
80107696:	6a 5e                	push   $0x5e
  jmp alltraps
80107698:	e9 8a f7 ff ff       	jmp    80106e27 <alltraps>

8010769d <vector95>:
.globl vector95
vector95:
  pushl $0
8010769d:	6a 00                	push   $0x0
  pushl $95
8010769f:	6a 5f                	push   $0x5f
  jmp alltraps
801076a1:	e9 81 f7 ff ff       	jmp    80106e27 <alltraps>

801076a6 <vector96>:
.globl vector96
vector96:
  pushl $0
801076a6:	6a 00                	push   $0x0
  pushl $96
801076a8:	6a 60                	push   $0x60
  jmp alltraps
801076aa:	e9 78 f7 ff ff       	jmp    80106e27 <alltraps>

801076af <vector97>:
.globl vector97
vector97:
  pushl $0
801076af:	6a 00                	push   $0x0
  pushl $97
801076b1:	6a 61                	push   $0x61
  jmp alltraps
801076b3:	e9 6f f7 ff ff       	jmp    80106e27 <alltraps>

801076b8 <vector98>:
.globl vector98
vector98:
  pushl $0
801076b8:	6a 00                	push   $0x0
  pushl $98
801076ba:	6a 62                	push   $0x62
  jmp alltraps
801076bc:	e9 66 f7 ff ff       	jmp    80106e27 <alltraps>

801076c1 <vector99>:
.globl vector99
vector99:
  pushl $0
801076c1:	6a 00                	push   $0x0
  pushl $99
801076c3:	6a 63                	push   $0x63
  jmp alltraps
801076c5:	e9 5d f7 ff ff       	jmp    80106e27 <alltraps>

801076ca <vector100>:
.globl vector100
vector100:
  pushl $0
801076ca:	6a 00                	push   $0x0
  pushl $100
801076cc:	6a 64                	push   $0x64
  jmp alltraps
801076ce:	e9 54 f7 ff ff       	jmp    80106e27 <alltraps>

801076d3 <vector101>:
.globl vector101
vector101:
  pushl $0
801076d3:	6a 00                	push   $0x0
  pushl $101
801076d5:	6a 65                	push   $0x65
  jmp alltraps
801076d7:	e9 4b f7 ff ff       	jmp    80106e27 <alltraps>

801076dc <vector102>:
.globl vector102
vector102:
  pushl $0
801076dc:	6a 00                	push   $0x0
  pushl $102
801076de:	6a 66                	push   $0x66
  jmp alltraps
801076e0:	e9 42 f7 ff ff       	jmp    80106e27 <alltraps>

801076e5 <vector103>:
.globl vector103
vector103:
  pushl $0
801076e5:	6a 00                	push   $0x0
  pushl $103
801076e7:	6a 67                	push   $0x67
  jmp alltraps
801076e9:	e9 39 f7 ff ff       	jmp    80106e27 <alltraps>

801076ee <vector104>:
.globl vector104
vector104:
  pushl $0
801076ee:	6a 00                	push   $0x0
  pushl $104
801076f0:	6a 68                	push   $0x68
  jmp alltraps
801076f2:	e9 30 f7 ff ff       	jmp    80106e27 <alltraps>

801076f7 <vector105>:
.globl vector105
vector105:
  pushl $0
801076f7:	6a 00                	push   $0x0
  pushl $105
801076f9:	6a 69                	push   $0x69
  jmp alltraps
801076fb:	e9 27 f7 ff ff       	jmp    80106e27 <alltraps>

80107700 <vector106>:
.globl vector106
vector106:
  pushl $0
80107700:	6a 00                	push   $0x0
  pushl $106
80107702:	6a 6a                	push   $0x6a
  jmp alltraps
80107704:	e9 1e f7 ff ff       	jmp    80106e27 <alltraps>

80107709 <vector107>:
.globl vector107
vector107:
  pushl $0
80107709:	6a 00                	push   $0x0
  pushl $107
8010770b:	6a 6b                	push   $0x6b
  jmp alltraps
8010770d:	e9 15 f7 ff ff       	jmp    80106e27 <alltraps>

80107712 <vector108>:
.globl vector108
vector108:
  pushl $0
80107712:	6a 00                	push   $0x0
  pushl $108
80107714:	6a 6c                	push   $0x6c
  jmp alltraps
80107716:	e9 0c f7 ff ff       	jmp    80106e27 <alltraps>

8010771b <vector109>:
.globl vector109
vector109:
  pushl $0
8010771b:	6a 00                	push   $0x0
  pushl $109
8010771d:	6a 6d                	push   $0x6d
  jmp alltraps
8010771f:	e9 03 f7 ff ff       	jmp    80106e27 <alltraps>

80107724 <vector110>:
.globl vector110
vector110:
  pushl $0
80107724:	6a 00                	push   $0x0
  pushl $110
80107726:	6a 6e                	push   $0x6e
  jmp alltraps
80107728:	e9 fa f6 ff ff       	jmp    80106e27 <alltraps>

8010772d <vector111>:
.globl vector111
vector111:
  pushl $0
8010772d:	6a 00                	push   $0x0
  pushl $111
8010772f:	6a 6f                	push   $0x6f
  jmp alltraps
80107731:	e9 f1 f6 ff ff       	jmp    80106e27 <alltraps>

80107736 <vector112>:
.globl vector112
vector112:
  pushl $0
80107736:	6a 00                	push   $0x0
  pushl $112
80107738:	6a 70                	push   $0x70
  jmp alltraps
8010773a:	e9 e8 f6 ff ff       	jmp    80106e27 <alltraps>

8010773f <vector113>:
.globl vector113
vector113:
  pushl $0
8010773f:	6a 00                	push   $0x0
  pushl $113
80107741:	6a 71                	push   $0x71
  jmp alltraps
80107743:	e9 df f6 ff ff       	jmp    80106e27 <alltraps>

80107748 <vector114>:
.globl vector114
vector114:
  pushl $0
80107748:	6a 00                	push   $0x0
  pushl $114
8010774a:	6a 72                	push   $0x72
  jmp alltraps
8010774c:	e9 d6 f6 ff ff       	jmp    80106e27 <alltraps>

80107751 <vector115>:
.globl vector115
vector115:
  pushl $0
80107751:	6a 00                	push   $0x0
  pushl $115
80107753:	6a 73                	push   $0x73
  jmp alltraps
80107755:	e9 cd f6 ff ff       	jmp    80106e27 <alltraps>

8010775a <vector116>:
.globl vector116
vector116:
  pushl $0
8010775a:	6a 00                	push   $0x0
  pushl $116
8010775c:	6a 74                	push   $0x74
  jmp alltraps
8010775e:	e9 c4 f6 ff ff       	jmp    80106e27 <alltraps>

80107763 <vector117>:
.globl vector117
vector117:
  pushl $0
80107763:	6a 00                	push   $0x0
  pushl $117
80107765:	6a 75                	push   $0x75
  jmp alltraps
80107767:	e9 bb f6 ff ff       	jmp    80106e27 <alltraps>

8010776c <vector118>:
.globl vector118
vector118:
  pushl $0
8010776c:	6a 00                	push   $0x0
  pushl $118
8010776e:	6a 76                	push   $0x76
  jmp alltraps
80107770:	e9 b2 f6 ff ff       	jmp    80106e27 <alltraps>

80107775 <vector119>:
.globl vector119
vector119:
  pushl $0
80107775:	6a 00                	push   $0x0
  pushl $119
80107777:	6a 77                	push   $0x77
  jmp alltraps
80107779:	e9 a9 f6 ff ff       	jmp    80106e27 <alltraps>

8010777e <vector120>:
.globl vector120
vector120:
  pushl $0
8010777e:	6a 00                	push   $0x0
  pushl $120
80107780:	6a 78                	push   $0x78
  jmp alltraps
80107782:	e9 a0 f6 ff ff       	jmp    80106e27 <alltraps>

80107787 <vector121>:
.globl vector121
vector121:
  pushl $0
80107787:	6a 00                	push   $0x0
  pushl $121
80107789:	6a 79                	push   $0x79
  jmp alltraps
8010778b:	e9 97 f6 ff ff       	jmp    80106e27 <alltraps>

80107790 <vector122>:
.globl vector122
vector122:
  pushl $0
80107790:	6a 00                	push   $0x0
  pushl $122
80107792:	6a 7a                	push   $0x7a
  jmp alltraps
80107794:	e9 8e f6 ff ff       	jmp    80106e27 <alltraps>

80107799 <vector123>:
.globl vector123
vector123:
  pushl $0
80107799:	6a 00                	push   $0x0
  pushl $123
8010779b:	6a 7b                	push   $0x7b
  jmp alltraps
8010779d:	e9 85 f6 ff ff       	jmp    80106e27 <alltraps>

801077a2 <vector124>:
.globl vector124
vector124:
  pushl $0
801077a2:	6a 00                	push   $0x0
  pushl $124
801077a4:	6a 7c                	push   $0x7c
  jmp alltraps
801077a6:	e9 7c f6 ff ff       	jmp    80106e27 <alltraps>

801077ab <vector125>:
.globl vector125
vector125:
  pushl $0
801077ab:	6a 00                	push   $0x0
  pushl $125
801077ad:	6a 7d                	push   $0x7d
  jmp alltraps
801077af:	e9 73 f6 ff ff       	jmp    80106e27 <alltraps>

801077b4 <vector126>:
.globl vector126
vector126:
  pushl $0
801077b4:	6a 00                	push   $0x0
  pushl $126
801077b6:	6a 7e                	push   $0x7e
  jmp alltraps
801077b8:	e9 6a f6 ff ff       	jmp    80106e27 <alltraps>

801077bd <vector127>:
.globl vector127
vector127:
  pushl $0
801077bd:	6a 00                	push   $0x0
  pushl $127
801077bf:	6a 7f                	push   $0x7f
  jmp alltraps
801077c1:	e9 61 f6 ff ff       	jmp    80106e27 <alltraps>

801077c6 <vector128>:
.globl vector128
vector128:
  pushl $0
801077c6:	6a 00                	push   $0x0
  pushl $128
801077c8:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801077cd:	e9 55 f6 ff ff       	jmp    80106e27 <alltraps>

801077d2 <vector129>:
.globl vector129
vector129:
  pushl $0
801077d2:	6a 00                	push   $0x0
  pushl $129
801077d4:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801077d9:	e9 49 f6 ff ff       	jmp    80106e27 <alltraps>

801077de <vector130>:
.globl vector130
vector130:
  pushl $0
801077de:	6a 00                	push   $0x0
  pushl $130
801077e0:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801077e5:	e9 3d f6 ff ff       	jmp    80106e27 <alltraps>

801077ea <vector131>:
.globl vector131
vector131:
  pushl $0
801077ea:	6a 00                	push   $0x0
  pushl $131
801077ec:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801077f1:	e9 31 f6 ff ff       	jmp    80106e27 <alltraps>

801077f6 <vector132>:
.globl vector132
vector132:
  pushl $0
801077f6:	6a 00                	push   $0x0
  pushl $132
801077f8:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801077fd:	e9 25 f6 ff ff       	jmp    80106e27 <alltraps>

80107802 <vector133>:
.globl vector133
vector133:
  pushl $0
80107802:	6a 00                	push   $0x0
  pushl $133
80107804:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80107809:	e9 19 f6 ff ff       	jmp    80106e27 <alltraps>

8010780e <vector134>:
.globl vector134
vector134:
  pushl $0
8010780e:	6a 00                	push   $0x0
  pushl $134
80107810:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107815:	e9 0d f6 ff ff       	jmp    80106e27 <alltraps>

8010781a <vector135>:
.globl vector135
vector135:
  pushl $0
8010781a:	6a 00                	push   $0x0
  pushl $135
8010781c:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107821:	e9 01 f6 ff ff       	jmp    80106e27 <alltraps>

80107826 <vector136>:
.globl vector136
vector136:
  pushl $0
80107826:	6a 00                	push   $0x0
  pushl $136
80107828:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010782d:	e9 f5 f5 ff ff       	jmp    80106e27 <alltraps>

80107832 <vector137>:
.globl vector137
vector137:
  pushl $0
80107832:	6a 00                	push   $0x0
  pushl $137
80107834:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80107839:	e9 e9 f5 ff ff       	jmp    80106e27 <alltraps>

8010783e <vector138>:
.globl vector138
vector138:
  pushl $0
8010783e:	6a 00                	push   $0x0
  pushl $138
80107840:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107845:	e9 dd f5 ff ff       	jmp    80106e27 <alltraps>

8010784a <vector139>:
.globl vector139
vector139:
  pushl $0
8010784a:	6a 00                	push   $0x0
  pushl $139
8010784c:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80107851:	e9 d1 f5 ff ff       	jmp    80106e27 <alltraps>

80107856 <vector140>:
.globl vector140
vector140:
  pushl $0
80107856:	6a 00                	push   $0x0
  pushl $140
80107858:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010785d:	e9 c5 f5 ff ff       	jmp    80106e27 <alltraps>

80107862 <vector141>:
.globl vector141
vector141:
  pushl $0
80107862:	6a 00                	push   $0x0
  pushl $141
80107864:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80107869:	e9 b9 f5 ff ff       	jmp    80106e27 <alltraps>

8010786e <vector142>:
.globl vector142
vector142:
  pushl $0
8010786e:	6a 00                	push   $0x0
  pushl $142
80107870:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107875:	e9 ad f5 ff ff       	jmp    80106e27 <alltraps>

8010787a <vector143>:
.globl vector143
vector143:
  pushl $0
8010787a:	6a 00                	push   $0x0
  pushl $143
8010787c:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80107881:	e9 a1 f5 ff ff       	jmp    80106e27 <alltraps>

80107886 <vector144>:
.globl vector144
vector144:
  pushl $0
80107886:	6a 00                	push   $0x0
  pushl $144
80107888:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010788d:	e9 95 f5 ff ff       	jmp    80106e27 <alltraps>

80107892 <vector145>:
.globl vector145
vector145:
  pushl $0
80107892:	6a 00                	push   $0x0
  pushl $145
80107894:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80107899:	e9 89 f5 ff ff       	jmp    80106e27 <alltraps>

8010789e <vector146>:
.globl vector146
vector146:
  pushl $0
8010789e:	6a 00                	push   $0x0
  pushl $146
801078a0:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801078a5:	e9 7d f5 ff ff       	jmp    80106e27 <alltraps>

801078aa <vector147>:
.globl vector147
vector147:
  pushl $0
801078aa:	6a 00                	push   $0x0
  pushl $147
801078ac:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801078b1:	e9 71 f5 ff ff       	jmp    80106e27 <alltraps>

801078b6 <vector148>:
.globl vector148
vector148:
  pushl $0
801078b6:	6a 00                	push   $0x0
  pushl $148
801078b8:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801078bd:	e9 65 f5 ff ff       	jmp    80106e27 <alltraps>

801078c2 <vector149>:
.globl vector149
vector149:
  pushl $0
801078c2:	6a 00                	push   $0x0
  pushl $149
801078c4:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801078c9:	e9 59 f5 ff ff       	jmp    80106e27 <alltraps>

801078ce <vector150>:
.globl vector150
vector150:
  pushl $0
801078ce:	6a 00                	push   $0x0
  pushl $150
801078d0:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801078d5:	e9 4d f5 ff ff       	jmp    80106e27 <alltraps>

801078da <vector151>:
.globl vector151
vector151:
  pushl $0
801078da:	6a 00                	push   $0x0
  pushl $151
801078dc:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801078e1:	e9 41 f5 ff ff       	jmp    80106e27 <alltraps>

801078e6 <vector152>:
.globl vector152
vector152:
  pushl $0
801078e6:	6a 00                	push   $0x0
  pushl $152
801078e8:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801078ed:	e9 35 f5 ff ff       	jmp    80106e27 <alltraps>

801078f2 <vector153>:
.globl vector153
vector153:
  pushl $0
801078f2:	6a 00                	push   $0x0
  pushl $153
801078f4:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801078f9:	e9 29 f5 ff ff       	jmp    80106e27 <alltraps>

801078fe <vector154>:
.globl vector154
vector154:
  pushl $0
801078fe:	6a 00                	push   $0x0
  pushl $154
80107900:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107905:	e9 1d f5 ff ff       	jmp    80106e27 <alltraps>

8010790a <vector155>:
.globl vector155
vector155:
  pushl $0
8010790a:	6a 00                	push   $0x0
  pushl $155
8010790c:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107911:	e9 11 f5 ff ff       	jmp    80106e27 <alltraps>

80107916 <vector156>:
.globl vector156
vector156:
  pushl $0
80107916:	6a 00                	push   $0x0
  pushl $156
80107918:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010791d:	e9 05 f5 ff ff       	jmp    80106e27 <alltraps>

80107922 <vector157>:
.globl vector157
vector157:
  pushl $0
80107922:	6a 00                	push   $0x0
  pushl $157
80107924:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80107929:	e9 f9 f4 ff ff       	jmp    80106e27 <alltraps>

8010792e <vector158>:
.globl vector158
vector158:
  pushl $0
8010792e:	6a 00                	push   $0x0
  pushl $158
80107930:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107935:	e9 ed f4 ff ff       	jmp    80106e27 <alltraps>

8010793a <vector159>:
.globl vector159
vector159:
  pushl $0
8010793a:	6a 00                	push   $0x0
  pushl $159
8010793c:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80107941:	e9 e1 f4 ff ff       	jmp    80106e27 <alltraps>

80107946 <vector160>:
.globl vector160
vector160:
  pushl $0
80107946:	6a 00                	push   $0x0
  pushl $160
80107948:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010794d:	e9 d5 f4 ff ff       	jmp    80106e27 <alltraps>

80107952 <vector161>:
.globl vector161
vector161:
  pushl $0
80107952:	6a 00                	push   $0x0
  pushl $161
80107954:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80107959:	e9 c9 f4 ff ff       	jmp    80106e27 <alltraps>

8010795e <vector162>:
.globl vector162
vector162:
  pushl $0
8010795e:	6a 00                	push   $0x0
  pushl $162
80107960:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107965:	e9 bd f4 ff ff       	jmp    80106e27 <alltraps>

8010796a <vector163>:
.globl vector163
vector163:
  pushl $0
8010796a:	6a 00                	push   $0x0
  pushl $163
8010796c:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80107971:	e9 b1 f4 ff ff       	jmp    80106e27 <alltraps>

80107976 <vector164>:
.globl vector164
vector164:
  pushl $0
80107976:	6a 00                	push   $0x0
  pushl $164
80107978:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010797d:	e9 a5 f4 ff ff       	jmp    80106e27 <alltraps>

80107982 <vector165>:
.globl vector165
vector165:
  pushl $0
80107982:	6a 00                	push   $0x0
  pushl $165
80107984:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80107989:	e9 99 f4 ff ff       	jmp    80106e27 <alltraps>

8010798e <vector166>:
.globl vector166
vector166:
  pushl $0
8010798e:	6a 00                	push   $0x0
  pushl $166
80107990:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107995:	e9 8d f4 ff ff       	jmp    80106e27 <alltraps>

8010799a <vector167>:
.globl vector167
vector167:
  pushl $0
8010799a:	6a 00                	push   $0x0
  pushl $167
8010799c:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801079a1:	e9 81 f4 ff ff       	jmp    80106e27 <alltraps>

801079a6 <vector168>:
.globl vector168
vector168:
  pushl $0
801079a6:	6a 00                	push   $0x0
  pushl $168
801079a8:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801079ad:	e9 75 f4 ff ff       	jmp    80106e27 <alltraps>

801079b2 <vector169>:
.globl vector169
vector169:
  pushl $0
801079b2:	6a 00                	push   $0x0
  pushl $169
801079b4:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801079b9:	e9 69 f4 ff ff       	jmp    80106e27 <alltraps>

801079be <vector170>:
.globl vector170
vector170:
  pushl $0
801079be:	6a 00                	push   $0x0
  pushl $170
801079c0:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801079c5:	e9 5d f4 ff ff       	jmp    80106e27 <alltraps>

801079ca <vector171>:
.globl vector171
vector171:
  pushl $0
801079ca:	6a 00                	push   $0x0
  pushl $171
801079cc:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801079d1:	e9 51 f4 ff ff       	jmp    80106e27 <alltraps>

801079d6 <vector172>:
.globl vector172
vector172:
  pushl $0
801079d6:	6a 00                	push   $0x0
  pushl $172
801079d8:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801079dd:	e9 45 f4 ff ff       	jmp    80106e27 <alltraps>

801079e2 <vector173>:
.globl vector173
vector173:
  pushl $0
801079e2:	6a 00                	push   $0x0
  pushl $173
801079e4:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801079e9:	e9 39 f4 ff ff       	jmp    80106e27 <alltraps>

801079ee <vector174>:
.globl vector174
vector174:
  pushl $0
801079ee:	6a 00                	push   $0x0
  pushl $174
801079f0:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801079f5:	e9 2d f4 ff ff       	jmp    80106e27 <alltraps>

801079fa <vector175>:
.globl vector175
vector175:
  pushl $0
801079fa:	6a 00                	push   $0x0
  pushl $175
801079fc:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107a01:	e9 21 f4 ff ff       	jmp    80106e27 <alltraps>

80107a06 <vector176>:
.globl vector176
vector176:
  pushl $0
80107a06:	6a 00                	push   $0x0
  pushl $176
80107a08:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80107a0d:	e9 15 f4 ff ff       	jmp    80106e27 <alltraps>

80107a12 <vector177>:
.globl vector177
vector177:
  pushl $0
80107a12:	6a 00                	push   $0x0
  pushl $177
80107a14:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80107a19:	e9 09 f4 ff ff       	jmp    80106e27 <alltraps>

80107a1e <vector178>:
.globl vector178
vector178:
  pushl $0
80107a1e:	6a 00                	push   $0x0
  pushl $178
80107a20:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107a25:	e9 fd f3 ff ff       	jmp    80106e27 <alltraps>

80107a2a <vector179>:
.globl vector179
vector179:
  pushl $0
80107a2a:	6a 00                	push   $0x0
  pushl $179
80107a2c:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107a31:	e9 f1 f3 ff ff       	jmp    80106e27 <alltraps>

80107a36 <vector180>:
.globl vector180
vector180:
  pushl $0
80107a36:	6a 00                	push   $0x0
  pushl $180
80107a38:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80107a3d:	e9 e5 f3 ff ff       	jmp    80106e27 <alltraps>

80107a42 <vector181>:
.globl vector181
vector181:
  pushl $0
80107a42:	6a 00                	push   $0x0
  pushl $181
80107a44:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80107a49:	e9 d9 f3 ff ff       	jmp    80106e27 <alltraps>

80107a4e <vector182>:
.globl vector182
vector182:
  pushl $0
80107a4e:	6a 00                	push   $0x0
  pushl $182
80107a50:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107a55:	e9 cd f3 ff ff       	jmp    80106e27 <alltraps>

80107a5a <vector183>:
.globl vector183
vector183:
  pushl $0
80107a5a:	6a 00                	push   $0x0
  pushl $183
80107a5c:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107a61:	e9 c1 f3 ff ff       	jmp    80106e27 <alltraps>

80107a66 <vector184>:
.globl vector184
vector184:
  pushl $0
80107a66:	6a 00                	push   $0x0
  pushl $184
80107a68:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80107a6d:	e9 b5 f3 ff ff       	jmp    80106e27 <alltraps>

80107a72 <vector185>:
.globl vector185
vector185:
  pushl $0
80107a72:	6a 00                	push   $0x0
  pushl $185
80107a74:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80107a79:	e9 a9 f3 ff ff       	jmp    80106e27 <alltraps>

80107a7e <vector186>:
.globl vector186
vector186:
  pushl $0
80107a7e:	6a 00                	push   $0x0
  pushl $186
80107a80:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107a85:	e9 9d f3 ff ff       	jmp    80106e27 <alltraps>

80107a8a <vector187>:
.globl vector187
vector187:
  pushl $0
80107a8a:	6a 00                	push   $0x0
  pushl $187
80107a8c:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107a91:	e9 91 f3 ff ff       	jmp    80106e27 <alltraps>

80107a96 <vector188>:
.globl vector188
vector188:
  pushl $0
80107a96:	6a 00                	push   $0x0
  pushl $188
80107a98:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80107a9d:	e9 85 f3 ff ff       	jmp    80106e27 <alltraps>

80107aa2 <vector189>:
.globl vector189
vector189:
  pushl $0
80107aa2:	6a 00                	push   $0x0
  pushl $189
80107aa4:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80107aa9:	e9 79 f3 ff ff       	jmp    80106e27 <alltraps>

80107aae <vector190>:
.globl vector190
vector190:
  pushl $0
80107aae:	6a 00                	push   $0x0
  pushl $190
80107ab0:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107ab5:	e9 6d f3 ff ff       	jmp    80106e27 <alltraps>

80107aba <vector191>:
.globl vector191
vector191:
  pushl $0
80107aba:	6a 00                	push   $0x0
  pushl $191
80107abc:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107ac1:	e9 61 f3 ff ff       	jmp    80106e27 <alltraps>

80107ac6 <vector192>:
.globl vector192
vector192:
  pushl $0
80107ac6:	6a 00                	push   $0x0
  pushl $192
80107ac8:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80107acd:	e9 55 f3 ff ff       	jmp    80106e27 <alltraps>

80107ad2 <vector193>:
.globl vector193
vector193:
  pushl $0
80107ad2:	6a 00                	push   $0x0
  pushl $193
80107ad4:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80107ad9:	e9 49 f3 ff ff       	jmp    80106e27 <alltraps>

80107ade <vector194>:
.globl vector194
vector194:
  pushl $0
80107ade:	6a 00                	push   $0x0
  pushl $194
80107ae0:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107ae5:	e9 3d f3 ff ff       	jmp    80106e27 <alltraps>

80107aea <vector195>:
.globl vector195
vector195:
  pushl $0
80107aea:	6a 00                	push   $0x0
  pushl $195
80107aec:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107af1:	e9 31 f3 ff ff       	jmp    80106e27 <alltraps>

80107af6 <vector196>:
.globl vector196
vector196:
  pushl $0
80107af6:	6a 00                	push   $0x0
  pushl $196
80107af8:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80107afd:	e9 25 f3 ff ff       	jmp    80106e27 <alltraps>

80107b02 <vector197>:
.globl vector197
vector197:
  pushl $0
80107b02:	6a 00                	push   $0x0
  pushl $197
80107b04:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80107b09:	e9 19 f3 ff ff       	jmp    80106e27 <alltraps>

80107b0e <vector198>:
.globl vector198
vector198:
  pushl $0
80107b0e:	6a 00                	push   $0x0
  pushl $198
80107b10:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107b15:	e9 0d f3 ff ff       	jmp    80106e27 <alltraps>

80107b1a <vector199>:
.globl vector199
vector199:
  pushl $0
80107b1a:	6a 00                	push   $0x0
  pushl $199
80107b1c:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107b21:	e9 01 f3 ff ff       	jmp    80106e27 <alltraps>

80107b26 <vector200>:
.globl vector200
vector200:
  pushl $0
80107b26:	6a 00                	push   $0x0
  pushl $200
80107b28:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80107b2d:	e9 f5 f2 ff ff       	jmp    80106e27 <alltraps>

80107b32 <vector201>:
.globl vector201
vector201:
  pushl $0
80107b32:	6a 00                	push   $0x0
  pushl $201
80107b34:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80107b39:	e9 e9 f2 ff ff       	jmp    80106e27 <alltraps>

80107b3e <vector202>:
.globl vector202
vector202:
  pushl $0
80107b3e:	6a 00                	push   $0x0
  pushl $202
80107b40:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107b45:	e9 dd f2 ff ff       	jmp    80106e27 <alltraps>

80107b4a <vector203>:
.globl vector203
vector203:
  pushl $0
80107b4a:	6a 00                	push   $0x0
  pushl $203
80107b4c:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107b51:	e9 d1 f2 ff ff       	jmp    80106e27 <alltraps>

80107b56 <vector204>:
.globl vector204
vector204:
  pushl $0
80107b56:	6a 00                	push   $0x0
  pushl $204
80107b58:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80107b5d:	e9 c5 f2 ff ff       	jmp    80106e27 <alltraps>

80107b62 <vector205>:
.globl vector205
vector205:
  pushl $0
80107b62:	6a 00                	push   $0x0
  pushl $205
80107b64:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80107b69:	e9 b9 f2 ff ff       	jmp    80106e27 <alltraps>

80107b6e <vector206>:
.globl vector206
vector206:
  pushl $0
80107b6e:	6a 00                	push   $0x0
  pushl $206
80107b70:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107b75:	e9 ad f2 ff ff       	jmp    80106e27 <alltraps>

80107b7a <vector207>:
.globl vector207
vector207:
  pushl $0
80107b7a:	6a 00                	push   $0x0
  pushl $207
80107b7c:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107b81:	e9 a1 f2 ff ff       	jmp    80106e27 <alltraps>

80107b86 <vector208>:
.globl vector208
vector208:
  pushl $0
80107b86:	6a 00                	push   $0x0
  pushl $208
80107b88:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80107b8d:	e9 95 f2 ff ff       	jmp    80106e27 <alltraps>

80107b92 <vector209>:
.globl vector209
vector209:
  pushl $0
80107b92:	6a 00                	push   $0x0
  pushl $209
80107b94:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80107b99:	e9 89 f2 ff ff       	jmp    80106e27 <alltraps>

80107b9e <vector210>:
.globl vector210
vector210:
  pushl $0
80107b9e:	6a 00                	push   $0x0
  pushl $210
80107ba0:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107ba5:	e9 7d f2 ff ff       	jmp    80106e27 <alltraps>

80107baa <vector211>:
.globl vector211
vector211:
  pushl $0
80107baa:	6a 00                	push   $0x0
  pushl $211
80107bac:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107bb1:	e9 71 f2 ff ff       	jmp    80106e27 <alltraps>

80107bb6 <vector212>:
.globl vector212
vector212:
  pushl $0
80107bb6:	6a 00                	push   $0x0
  pushl $212
80107bb8:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80107bbd:	e9 65 f2 ff ff       	jmp    80106e27 <alltraps>

80107bc2 <vector213>:
.globl vector213
vector213:
  pushl $0
80107bc2:	6a 00                	push   $0x0
  pushl $213
80107bc4:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80107bc9:	e9 59 f2 ff ff       	jmp    80106e27 <alltraps>

80107bce <vector214>:
.globl vector214
vector214:
  pushl $0
80107bce:	6a 00                	push   $0x0
  pushl $214
80107bd0:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107bd5:	e9 4d f2 ff ff       	jmp    80106e27 <alltraps>

80107bda <vector215>:
.globl vector215
vector215:
  pushl $0
80107bda:	6a 00                	push   $0x0
  pushl $215
80107bdc:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107be1:	e9 41 f2 ff ff       	jmp    80106e27 <alltraps>

80107be6 <vector216>:
.globl vector216
vector216:
  pushl $0
80107be6:	6a 00                	push   $0x0
  pushl $216
80107be8:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80107bed:	e9 35 f2 ff ff       	jmp    80106e27 <alltraps>

80107bf2 <vector217>:
.globl vector217
vector217:
  pushl $0
80107bf2:	6a 00                	push   $0x0
  pushl $217
80107bf4:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80107bf9:	e9 29 f2 ff ff       	jmp    80106e27 <alltraps>

80107bfe <vector218>:
.globl vector218
vector218:
  pushl $0
80107bfe:	6a 00                	push   $0x0
  pushl $218
80107c00:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107c05:	e9 1d f2 ff ff       	jmp    80106e27 <alltraps>

80107c0a <vector219>:
.globl vector219
vector219:
  pushl $0
80107c0a:	6a 00                	push   $0x0
  pushl $219
80107c0c:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107c11:	e9 11 f2 ff ff       	jmp    80106e27 <alltraps>

80107c16 <vector220>:
.globl vector220
vector220:
  pushl $0
80107c16:	6a 00                	push   $0x0
  pushl $220
80107c18:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80107c1d:	e9 05 f2 ff ff       	jmp    80106e27 <alltraps>

80107c22 <vector221>:
.globl vector221
vector221:
  pushl $0
80107c22:	6a 00                	push   $0x0
  pushl $221
80107c24:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80107c29:	e9 f9 f1 ff ff       	jmp    80106e27 <alltraps>

80107c2e <vector222>:
.globl vector222
vector222:
  pushl $0
80107c2e:	6a 00                	push   $0x0
  pushl $222
80107c30:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107c35:	e9 ed f1 ff ff       	jmp    80106e27 <alltraps>

80107c3a <vector223>:
.globl vector223
vector223:
  pushl $0
80107c3a:	6a 00                	push   $0x0
  pushl $223
80107c3c:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107c41:	e9 e1 f1 ff ff       	jmp    80106e27 <alltraps>

80107c46 <vector224>:
.globl vector224
vector224:
  pushl $0
80107c46:	6a 00                	push   $0x0
  pushl $224
80107c48:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80107c4d:	e9 d5 f1 ff ff       	jmp    80106e27 <alltraps>

80107c52 <vector225>:
.globl vector225
vector225:
  pushl $0
80107c52:	6a 00                	push   $0x0
  pushl $225
80107c54:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107c59:	e9 c9 f1 ff ff       	jmp    80106e27 <alltraps>

80107c5e <vector226>:
.globl vector226
vector226:
  pushl $0
80107c5e:	6a 00                	push   $0x0
  pushl $226
80107c60:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107c65:	e9 bd f1 ff ff       	jmp    80106e27 <alltraps>

80107c6a <vector227>:
.globl vector227
vector227:
  pushl $0
80107c6a:	6a 00                	push   $0x0
  pushl $227
80107c6c:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107c71:	e9 b1 f1 ff ff       	jmp    80106e27 <alltraps>

80107c76 <vector228>:
.globl vector228
vector228:
  pushl $0
80107c76:	6a 00                	push   $0x0
  pushl $228
80107c78:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107c7d:	e9 a5 f1 ff ff       	jmp    80106e27 <alltraps>

80107c82 <vector229>:
.globl vector229
vector229:
  pushl $0
80107c82:	6a 00                	push   $0x0
  pushl $229
80107c84:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107c89:	e9 99 f1 ff ff       	jmp    80106e27 <alltraps>

80107c8e <vector230>:
.globl vector230
vector230:
  pushl $0
80107c8e:	6a 00                	push   $0x0
  pushl $230
80107c90:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107c95:	e9 8d f1 ff ff       	jmp    80106e27 <alltraps>

80107c9a <vector231>:
.globl vector231
vector231:
  pushl $0
80107c9a:	6a 00                	push   $0x0
  pushl $231
80107c9c:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107ca1:	e9 81 f1 ff ff       	jmp    80106e27 <alltraps>

80107ca6 <vector232>:
.globl vector232
vector232:
  pushl $0
80107ca6:	6a 00                	push   $0x0
  pushl $232
80107ca8:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107cad:	e9 75 f1 ff ff       	jmp    80106e27 <alltraps>

80107cb2 <vector233>:
.globl vector233
vector233:
  pushl $0
80107cb2:	6a 00                	push   $0x0
  pushl $233
80107cb4:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107cb9:	e9 69 f1 ff ff       	jmp    80106e27 <alltraps>

80107cbe <vector234>:
.globl vector234
vector234:
  pushl $0
80107cbe:	6a 00                	push   $0x0
  pushl $234
80107cc0:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107cc5:	e9 5d f1 ff ff       	jmp    80106e27 <alltraps>

80107cca <vector235>:
.globl vector235
vector235:
  pushl $0
80107cca:	6a 00                	push   $0x0
  pushl $235
80107ccc:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107cd1:	e9 51 f1 ff ff       	jmp    80106e27 <alltraps>

80107cd6 <vector236>:
.globl vector236
vector236:
  pushl $0
80107cd6:	6a 00                	push   $0x0
  pushl $236
80107cd8:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107cdd:	e9 45 f1 ff ff       	jmp    80106e27 <alltraps>

80107ce2 <vector237>:
.globl vector237
vector237:
  pushl $0
80107ce2:	6a 00                	push   $0x0
  pushl $237
80107ce4:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107ce9:	e9 39 f1 ff ff       	jmp    80106e27 <alltraps>

80107cee <vector238>:
.globl vector238
vector238:
  pushl $0
80107cee:	6a 00                	push   $0x0
  pushl $238
80107cf0:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107cf5:	e9 2d f1 ff ff       	jmp    80106e27 <alltraps>

80107cfa <vector239>:
.globl vector239
vector239:
  pushl $0
80107cfa:	6a 00                	push   $0x0
  pushl $239
80107cfc:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107d01:	e9 21 f1 ff ff       	jmp    80106e27 <alltraps>

80107d06 <vector240>:
.globl vector240
vector240:
  pushl $0
80107d06:	6a 00                	push   $0x0
  pushl $240
80107d08:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107d0d:	e9 15 f1 ff ff       	jmp    80106e27 <alltraps>

80107d12 <vector241>:
.globl vector241
vector241:
  pushl $0
80107d12:	6a 00                	push   $0x0
  pushl $241
80107d14:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107d19:	e9 09 f1 ff ff       	jmp    80106e27 <alltraps>

80107d1e <vector242>:
.globl vector242
vector242:
  pushl $0
80107d1e:	6a 00                	push   $0x0
  pushl $242
80107d20:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107d25:	e9 fd f0 ff ff       	jmp    80106e27 <alltraps>

80107d2a <vector243>:
.globl vector243
vector243:
  pushl $0
80107d2a:	6a 00                	push   $0x0
  pushl $243
80107d2c:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107d31:	e9 f1 f0 ff ff       	jmp    80106e27 <alltraps>

80107d36 <vector244>:
.globl vector244
vector244:
  pushl $0
80107d36:	6a 00                	push   $0x0
  pushl $244
80107d38:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107d3d:	e9 e5 f0 ff ff       	jmp    80106e27 <alltraps>

80107d42 <vector245>:
.globl vector245
vector245:
  pushl $0
80107d42:	6a 00                	push   $0x0
  pushl $245
80107d44:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107d49:	e9 d9 f0 ff ff       	jmp    80106e27 <alltraps>

80107d4e <vector246>:
.globl vector246
vector246:
  pushl $0
80107d4e:	6a 00                	push   $0x0
  pushl $246
80107d50:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107d55:	e9 cd f0 ff ff       	jmp    80106e27 <alltraps>

80107d5a <vector247>:
.globl vector247
vector247:
  pushl $0
80107d5a:	6a 00                	push   $0x0
  pushl $247
80107d5c:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107d61:	e9 c1 f0 ff ff       	jmp    80106e27 <alltraps>

80107d66 <vector248>:
.globl vector248
vector248:
  pushl $0
80107d66:	6a 00                	push   $0x0
  pushl $248
80107d68:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107d6d:	e9 b5 f0 ff ff       	jmp    80106e27 <alltraps>

80107d72 <vector249>:
.globl vector249
vector249:
  pushl $0
80107d72:	6a 00                	push   $0x0
  pushl $249
80107d74:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107d79:	e9 a9 f0 ff ff       	jmp    80106e27 <alltraps>

80107d7e <vector250>:
.globl vector250
vector250:
  pushl $0
80107d7e:	6a 00                	push   $0x0
  pushl $250
80107d80:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107d85:	e9 9d f0 ff ff       	jmp    80106e27 <alltraps>

80107d8a <vector251>:
.globl vector251
vector251:
  pushl $0
80107d8a:	6a 00                	push   $0x0
  pushl $251
80107d8c:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107d91:	e9 91 f0 ff ff       	jmp    80106e27 <alltraps>

80107d96 <vector252>:
.globl vector252
vector252:
  pushl $0
80107d96:	6a 00                	push   $0x0
  pushl $252
80107d98:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107d9d:	e9 85 f0 ff ff       	jmp    80106e27 <alltraps>

80107da2 <vector253>:
.globl vector253
vector253:
  pushl $0
80107da2:	6a 00                	push   $0x0
  pushl $253
80107da4:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107da9:	e9 79 f0 ff ff       	jmp    80106e27 <alltraps>

80107dae <vector254>:
.globl vector254
vector254:
  pushl $0
80107dae:	6a 00                	push   $0x0
  pushl $254
80107db0:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107db5:	e9 6d f0 ff ff       	jmp    80106e27 <alltraps>

80107dba <vector255>:
.globl vector255
vector255:
  pushl $0
80107dba:	6a 00                	push   $0x0
  pushl $255
80107dbc:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107dc1:	e9 61 f0 ff ff       	jmp    80106e27 <alltraps>
80107dc6:	66 90                	xchg   %ax,%ax
80107dc8:	66 90                	xchg   %ax,%ax
80107dca:	66 90                	xchg   %ax,%ax
80107dcc:	66 90                	xchg   %ax,%ax
80107dce:	66 90                	xchg   %ax,%ax

80107dd0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107dd0:	55                   	push   %ebp
80107dd1:	89 e5                	mov    %esp,%ebp
80107dd3:	83 ec 28             	sub    $0x28,%esp
80107dd6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107dd9:	89 d3                	mov    %edx,%ebx
80107ddb:	c1 eb 16             	shr    $0x16,%ebx
{
80107dde:	89 75 f8             	mov    %esi,-0x8(%ebp)
  pde = &pgdir[PDX(va)];
80107de1:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80107de4:	89 7d fc             	mov    %edi,-0x4(%ebp)
80107de7:	89 d7                	mov    %edx,%edi
  if(*pde & PTE_P){
80107de9:	8b 06                	mov    (%esi),%eax
80107deb:	a8 01                	test   $0x1,%al
80107ded:	74 29                	je     80107e18 <walkpgdir+0x48>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107def:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107df4:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107dfa:	c1 ef 0a             	shr    $0xa,%edi
}
80107dfd:	8b 75 f8             	mov    -0x8(%ebp),%esi
  return &pgtab[PTX(va)];
80107e00:	89 fa                	mov    %edi,%edx
}
80107e02:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return &pgtab[PTX(va)];
80107e05:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107e0b:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80107e0e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107e11:	89 ec                	mov    %ebp,%esp
80107e13:	5d                   	pop    %ebp
80107e14:	c3                   	ret    
80107e15:	8d 76 00             	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107e18:	85 c9                	test   %ecx,%ecx
80107e1a:	74 34                	je     80107e50 <walkpgdir+0x80>
80107e1c:	e8 8f a7 ff ff       	call   801025b0 <kalloc>
80107e21:	85 c0                	test   %eax,%eax
80107e23:	89 c3                	mov    %eax,%ebx
80107e25:	74 29                	je     80107e50 <walkpgdir+0x80>
    memset(pgtab, 0, PGSIZE);
80107e27:	b8 00 10 00 00       	mov    $0x1000,%eax
80107e2c:	31 d2                	xor    %edx,%edx
80107e2e:	89 44 24 08          	mov    %eax,0x8(%esp)
80107e32:	89 54 24 04          	mov    %edx,0x4(%esp)
80107e36:	89 1c 24             	mov    %ebx,(%esp)
80107e39:	e8 d2 dc ff ff       	call   80105b10 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107e3e:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107e44:	83 c8 07             	or     $0x7,%eax
80107e47:	89 06                	mov    %eax,(%esi)
80107e49:	eb af                	jmp    80107dfa <walkpgdir+0x2a>
80107e4b:	90                   	nop
80107e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80107e50:	8b 5d f4             	mov    -0xc(%ebp),%ebx
      return 0;
80107e53:	31 c0                	xor    %eax,%eax
}
80107e55:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107e58:	8b 7d fc             	mov    -0x4(%ebp),%edi
80107e5b:	89 ec                	mov    %ebp,%esp
80107e5d:	5d                   	pop    %ebp
80107e5e:	c3                   	ret    
80107e5f:	90                   	nop

80107e60 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107e60:	55                   	push   %ebp
80107e61:	89 e5                	mov    %esp,%ebp
80107e63:	57                   	push   %edi
80107e64:	56                   	push   %esi
80107e65:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107e66:	89 d3                	mov    %edx,%ebx
{
80107e68:	83 ec 2c             	sub    $0x2c,%esp
  a = (char*)PGROUNDDOWN((uint)va);
80107e6b:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80107e71:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107e74:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107e78:	8b 7d 08             	mov    0x8(%ebp),%edi
80107e7b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107e80:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80107e83:	8b 45 0c             	mov    0xc(%ebp),%eax
80107e86:	29 df                	sub    %ebx,%edi
80107e88:	83 c8 01             	or     $0x1,%eax
80107e8b:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107e8e:	eb 17                	jmp    80107ea7 <mappages+0x47>
    if(*pte & PTE_P)
80107e90:	f6 00 01             	testb  $0x1,(%eax)
80107e93:	75 45                	jne    80107eda <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80107e95:	8b 55 dc             	mov    -0x24(%ebp),%edx
80107e98:	09 d6                	or     %edx,%esi
    if(a == last)
80107e9a:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
80107e9d:	89 30                	mov    %esi,(%eax)
    if(a == last)
80107e9f:	74 2f                	je     80107ed0 <mappages+0x70>
      break;
    a += PGSIZE;
80107ea1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107ea7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107eaa:	b9 01 00 00 00       	mov    $0x1,%ecx
80107eaf:	89 da                	mov    %ebx,%edx
80107eb1:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107eb4:	e8 17 ff ff ff       	call   80107dd0 <walkpgdir>
80107eb9:	85 c0                	test   %eax,%eax
80107ebb:	75 d3                	jne    80107e90 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80107ebd:	83 c4 2c             	add    $0x2c,%esp
      return -1;
80107ec0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107ec5:	5b                   	pop    %ebx
80107ec6:	5e                   	pop    %esi
80107ec7:	5f                   	pop    %edi
80107ec8:	5d                   	pop    %ebp
80107ec9:	c3                   	ret    
80107eca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107ed0:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80107ed3:	31 c0                	xor    %eax,%eax
}
80107ed5:	5b                   	pop    %ebx
80107ed6:	5e                   	pop    %esi
80107ed7:	5f                   	pop    %edi
80107ed8:	5d                   	pop    %ebp
80107ed9:	c3                   	ret    
      panic("remap");
80107eda:	c7 04 24 78 90 10 80 	movl   $0x80109078,(%esp)
80107ee1:	e8 8a 84 ff ff       	call   80100370 <panic>
80107ee6:	8d 76 00             	lea    0x0(%esi),%esi
80107ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107ef0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107ef0:	55                   	push   %ebp
80107ef1:	89 e5                	mov    %esp,%ebp
80107ef3:	57                   	push   %edi
80107ef4:	89 c7                	mov    %eax,%edi
80107ef6:	56                   	push   %esi
80107ef7:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107ef8:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107efe:	83 ec 2c             	sub    $0x2c,%esp
  a = PGROUNDUP(newsz);
80107f01:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107f07:	39 d3                	cmp    %edx,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107f09:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107f0c:	73 62                	jae    80107f70 <deallocuvm.part.0+0x80>
80107f0e:	89 d6                	mov    %edx,%esi
80107f10:	eb 39                	jmp    80107f4b <deallocuvm.part.0+0x5b>
80107f12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80107f18:	8b 10                	mov    (%eax),%edx
80107f1a:	f6 c2 01             	test   $0x1,%dl
80107f1d:	74 22                	je     80107f41 <deallocuvm.part.0+0x51>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80107f1f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107f25:	74 54                	je     80107f7b <deallocuvm.part.0+0x8b>
        panic("kfree");
      char *v = P2V(pa);
80107f27:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
80107f2d:	89 14 24             	mov    %edx,(%esp)
80107f30:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107f33:	e8 a8 a4 ff ff       	call   801023e0 <kfree>
      *pte = 0;
80107f38:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107f3b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80107f41:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107f47:	39 f3                	cmp    %esi,%ebx
80107f49:	73 25                	jae    80107f70 <deallocuvm.part.0+0x80>
    pte = walkpgdir(pgdir, (char*)a, 0);
80107f4b:	31 c9                	xor    %ecx,%ecx
80107f4d:	89 da                	mov    %ebx,%edx
80107f4f:	89 f8                	mov    %edi,%eax
80107f51:	e8 7a fe ff ff       	call   80107dd0 <walkpgdir>
    if(!pte)
80107f56:	85 c0                	test   %eax,%eax
80107f58:	75 be                	jne    80107f18 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107f5a:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80107f60:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107f66:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107f6c:	39 f3                	cmp    %esi,%ebx
80107f6e:	72 db                	jb     80107f4b <deallocuvm.part.0+0x5b>
    }
  }
  return newsz;
}
80107f70:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107f73:	83 c4 2c             	add    $0x2c,%esp
80107f76:	5b                   	pop    %ebx
80107f77:	5e                   	pop    %esi
80107f78:	5f                   	pop    %edi
80107f79:	5d                   	pop    %ebp
80107f7a:	c3                   	ret    
        panic("kfree");
80107f7b:	c7 04 24 86 89 10 80 	movl   $0x80108986,(%esp)
80107f82:	e8 e9 83 ff ff       	call   80100370 <panic>
80107f87:	89 f6                	mov    %esi,%esi
80107f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107f90 <seginit>:
{
80107f90:	55                   	push   %ebp
80107f91:	89 e5                	mov    %esp,%ebp
80107f93:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107f96:	e8 e5 b9 ff ff       	call   80103980 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107f9b:	b9 00 9a cf 00       	mov    $0xcf9a00,%ecx
  pd[0] = size-1;
80107fa0:	66 c7 45 f2 2f 00    	movw   $0x2f,-0xe(%ebp)
80107fa6:	8d 14 80             	lea    (%eax,%eax,4),%edx
80107fa9:	8d 04 50             	lea    (%eax,%edx,2),%eax
80107fac:	ba ff ff 00 00       	mov    $0xffff,%edx
80107fb1:	c1 e0 04             	shl    $0x4,%eax
80107fb4:	89 90 58 48 11 80    	mov    %edx,-0x7feeb7a8(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107fba:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107fbf:	89 88 5c 48 11 80    	mov    %ecx,-0x7feeb7a4(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107fc5:	b9 00 92 cf 00       	mov    $0xcf9200,%ecx
80107fca:	89 90 60 48 11 80    	mov    %edx,-0x7feeb7a0(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107fd0:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107fd5:	89 88 64 48 11 80    	mov    %ecx,-0x7feeb79c(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107fdb:	b9 00 fa cf 00       	mov    $0xcffa00,%ecx
80107fe0:	89 90 68 48 11 80    	mov    %edx,-0x7feeb798(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107fe6:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107feb:	89 88 6c 48 11 80    	mov    %ecx,-0x7feeb794(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107ff1:	b9 00 f2 cf 00       	mov    $0xcff200,%ecx
80107ff6:	89 90 70 48 11 80    	mov    %edx,-0x7feeb790(%eax)
80107ffc:	89 88 74 48 11 80    	mov    %ecx,-0x7feeb78c(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80108002:	05 50 48 11 80       	add    $0x80114850,%eax
  pd[1] = (uint)p;
80108007:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
8010800a:	c1 e8 10             	shr    $0x10,%eax
  pd[1] = (uint)p;
8010800d:	66 89 55 f4          	mov    %dx,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80108011:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80108015:	8d 45 f2             	lea    -0xe(%ebp),%eax
80108018:	0f 01 10             	lgdtl  (%eax)
}
8010801b:	c9                   	leave  
8010801c:	c3                   	ret    
8010801d:	8d 76 00             	lea    0x0(%esi),%esi

80108020 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108020:	a1 04 82 11 80       	mov    0x80118204,%eax
{
80108025:	55                   	push   %ebp
80108026:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108028:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010802d:	0f 22 d8             	mov    %eax,%cr3
}
80108030:	5d                   	pop    %ebp
80108031:	c3                   	ret    
80108032:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108040 <switchuvm>:
{
80108040:	55                   	push   %ebp
80108041:	89 e5                	mov    %esp,%ebp
80108043:	57                   	push   %edi
80108044:	56                   	push   %esi
80108045:	53                   	push   %ebx
80108046:	83 ec 2c             	sub    $0x2c,%esp
80108049:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
8010804c:	85 db                	test   %ebx,%ebx
8010804e:	0f 84 c5 00 00 00    	je     80108119 <switchuvm+0xd9>
  if(p->kstack == 0)
80108054:	8b 7b 08             	mov    0x8(%ebx),%edi
80108057:	85 ff                	test   %edi,%edi
80108059:	0f 84 d2 00 00 00    	je     80108131 <switchuvm+0xf1>
  if(p->pgdir == 0)
8010805f:	8b 73 04             	mov    0x4(%ebx),%esi
80108062:	85 f6                	test   %esi,%esi
80108064:	0f 84 bb 00 00 00    	je     80108125 <switchuvm+0xe5>
  pushcli();
8010806a:	e8 d1 d8 ff ff       	call   80105940 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010806f:	e8 8c b8 ff ff       	call   80103900 <mycpu>
80108074:	89 c6                	mov    %eax,%esi
80108076:	e8 85 b8 ff ff       	call   80103900 <mycpu>
8010807b:	89 c7                	mov    %eax,%edi
8010807d:	e8 7e b8 ff ff       	call   80103900 <mycpu>
80108082:	83 c7 08             	add    $0x8,%edi
80108085:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108088:	e8 73 b8 ff ff       	call   80103900 <mycpu>
8010808d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80108090:	ba 67 00 00 00       	mov    $0x67,%edx
80108095:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
8010809c:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
801080a3:	83 c1 08             	add    $0x8,%ecx
801080a6:	c1 e9 10             	shr    $0x10,%ecx
801080a9:	83 c0 08             	add    $0x8,%eax
801080ac:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
801080b2:	c1 e8 18             	shr    $0x18,%eax
801080b5:	b9 99 40 00 00       	mov    $0x4099,%ecx
801080ba:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
801080c1:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->gdt[SEG_TSS].s = 0;
801080c7:	e8 34 b8 ff ff       	call   80103900 <mycpu>
801080cc:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801080d3:	e8 28 b8 ff ff       	call   80103900 <mycpu>
801080d8:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801080de:	8b 73 08             	mov    0x8(%ebx),%esi
801080e1:	e8 1a b8 ff ff       	call   80103900 <mycpu>
801080e6:	81 c6 00 10 00 00    	add    $0x1000,%esi
801080ec:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801080ef:	e8 0c b8 ff ff       	call   80103900 <mycpu>
801080f4:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801080fa:	b8 28 00 00 00       	mov    $0x28,%eax
801080ff:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80108102:	8b 43 04             	mov    0x4(%ebx),%eax
80108105:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010810a:	0f 22 d8             	mov    %eax,%cr3
}
8010810d:	83 c4 2c             	add    $0x2c,%esp
80108110:	5b                   	pop    %ebx
80108111:	5e                   	pop    %esi
80108112:	5f                   	pop    %edi
80108113:	5d                   	pop    %ebp
  popcli();
80108114:	e9 67 d8 ff ff       	jmp    80105980 <popcli>
    panic("switchuvm: no process");
80108119:	c7 04 24 7e 90 10 80 	movl   $0x8010907e,(%esp)
80108120:	e8 4b 82 ff ff       	call   80100370 <panic>
    panic("switchuvm: no pgdir");
80108125:	c7 04 24 a9 90 10 80 	movl   $0x801090a9,(%esp)
8010812c:	e8 3f 82 ff ff       	call   80100370 <panic>
    panic("switchuvm: no kstack");
80108131:	c7 04 24 94 90 10 80 	movl   $0x80109094,(%esp)
80108138:	e8 33 82 ff ff       	call   80100370 <panic>
8010813d:	8d 76 00             	lea    0x0(%esi),%esi

80108140 <inituvm>:
{
80108140:	55                   	push   %ebp
80108141:	89 e5                	mov    %esp,%ebp
80108143:	83 ec 38             	sub    $0x38,%esp
80108146:	89 75 f8             	mov    %esi,-0x8(%ebp)
80108149:	8b 75 10             	mov    0x10(%ebp),%esi
8010814c:	8b 45 08             	mov    0x8(%ebp),%eax
8010814f:	89 7d fc             	mov    %edi,-0x4(%ebp)
80108152:	8b 7d 0c             	mov    0xc(%ebp),%edi
80108155:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  if(sz >= PGSIZE)
80108158:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
8010815e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80108161:	77 59                	ja     801081bc <inituvm+0x7c>
  mem = kalloc();
80108163:	e8 48 a4 ff ff       	call   801025b0 <kalloc>
  memset(mem, 0, PGSIZE);
80108168:	31 d2                	xor    %edx,%edx
8010816a:	89 54 24 04          	mov    %edx,0x4(%esp)
  mem = kalloc();
8010816e:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80108170:	b8 00 10 00 00       	mov    $0x1000,%eax
80108175:	89 1c 24             	mov    %ebx,(%esp)
80108178:	89 44 24 08          	mov    %eax,0x8(%esp)
8010817c:	e8 8f d9 ff ff       	call   80105b10 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80108181:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80108187:	b9 06 00 00 00       	mov    $0x6,%ecx
8010818c:	89 04 24             	mov    %eax,(%esp)
8010818f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108192:	31 d2                	xor    %edx,%edx
80108194:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80108198:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010819d:	e8 be fc ff ff       	call   80107e60 <mappages>
  memmove(mem, init, sz);
801081a2:	89 75 10             	mov    %esi,0x10(%ebp)
}
801081a5:	8b 75 f8             	mov    -0x8(%ebp),%esi
  memmove(mem, init, sz);
801081a8:	89 7d 0c             	mov    %edi,0xc(%ebp)
}
801081ab:	8b 7d fc             	mov    -0x4(%ebp),%edi
  memmove(mem, init, sz);
801081ae:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801081b1:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801081b4:	89 ec                	mov    %ebp,%esp
801081b6:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801081b7:	e9 14 da ff ff       	jmp    80105bd0 <memmove>
    panic("inituvm: more than a page");
801081bc:	c7 04 24 bd 90 10 80 	movl   $0x801090bd,(%esp)
801081c3:	e8 a8 81 ff ff       	call   80100370 <panic>
801081c8:	90                   	nop
801081c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801081d0 <loaduvm>:
{
801081d0:	55                   	push   %ebp
801081d1:	89 e5                	mov    %esp,%ebp
801081d3:	57                   	push   %edi
801081d4:	56                   	push   %esi
801081d5:	53                   	push   %ebx
801081d6:	83 ec 1c             	sub    $0x1c,%esp
  if((uint) addr % PGSIZE != 0)
801081d9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
801081e0:	0f 85 98 00 00 00    	jne    8010827e <loaduvm+0xae>
  for(i = 0; i < sz; i += PGSIZE){
801081e6:	8b 75 18             	mov    0x18(%ebp),%esi
801081e9:	31 db                	xor    %ebx,%ebx
801081eb:	85 f6                	test   %esi,%esi
801081ed:	75 1a                	jne    80108209 <loaduvm+0x39>
801081ef:	eb 77                	jmp    80108268 <loaduvm+0x98>
801081f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801081f8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801081fe:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80108204:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80108207:	76 5f                	jbe    80108268 <loaduvm+0x98>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80108209:	8b 55 0c             	mov    0xc(%ebp),%edx
8010820c:	31 c9                	xor    %ecx,%ecx
8010820e:	8b 45 08             	mov    0x8(%ebp),%eax
80108211:	01 da                	add    %ebx,%edx
80108213:	e8 b8 fb ff ff       	call   80107dd0 <walkpgdir>
80108218:	85 c0                	test   %eax,%eax
8010821a:	74 56                	je     80108272 <loaduvm+0xa2>
    pa = PTE_ADDR(*pte);
8010821c:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
8010821e:	bf 00 10 00 00       	mov    $0x1000,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108223:	8b 4d 14             	mov    0x14(%ebp),%ecx
    pa = PTE_ADDR(*pte);
80108226:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
8010822b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80108231:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108234:	05 00 00 00 80       	add    $0x80000000,%eax
80108239:	89 44 24 04          	mov    %eax,0x4(%esp)
8010823d:	8b 45 10             	mov    0x10(%ebp),%eax
80108240:	01 d9                	add    %ebx,%ecx
80108242:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80108246:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010824a:	89 04 24             	mov    %eax,(%esp)
8010824d:	e8 7e 97 ff ff       	call   801019d0 <readi>
80108252:	39 f8                	cmp    %edi,%eax
80108254:	74 a2                	je     801081f8 <loaduvm+0x28>
}
80108256:	83 c4 1c             	add    $0x1c,%esp
      return -1;
80108259:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010825e:	5b                   	pop    %ebx
8010825f:	5e                   	pop    %esi
80108260:	5f                   	pop    %edi
80108261:	5d                   	pop    %ebp
80108262:	c3                   	ret    
80108263:	90                   	nop
80108264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108268:	83 c4 1c             	add    $0x1c,%esp
  return 0;
8010826b:	31 c0                	xor    %eax,%eax
}
8010826d:	5b                   	pop    %ebx
8010826e:	5e                   	pop    %esi
8010826f:	5f                   	pop    %edi
80108270:	5d                   	pop    %ebp
80108271:	c3                   	ret    
      panic("loaduvm: address should exist");
80108272:	c7 04 24 d7 90 10 80 	movl   $0x801090d7,(%esp)
80108279:	e8 f2 80 ff ff       	call   80100370 <panic>
    panic("loaduvm: addr must be page aligned");
8010827e:	c7 04 24 78 91 10 80 	movl   $0x80109178,(%esp)
80108285:	e8 e6 80 ff ff       	call   80100370 <panic>
8010828a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108290 <allocuvm>:
{
80108290:	55                   	push   %ebp
80108291:	89 e5                	mov    %esp,%ebp
80108293:	57                   	push   %edi
80108294:	56                   	push   %esi
80108295:	53                   	push   %ebx
80108296:	83 ec 2c             	sub    $0x2c,%esp
  if(newsz >= KERNBASE)
80108299:	8b 7d 10             	mov    0x10(%ebp),%edi
8010829c:	85 ff                	test   %edi,%edi
8010829e:	0f 88 91 00 00 00    	js     80108335 <allocuvm+0xa5>
  if(newsz < oldsz)
801082a4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801082a7:	0f 82 9b 00 00 00    	jb     80108348 <allocuvm+0xb8>
  a = PGROUNDUP(oldsz);
801082ad:	8b 45 0c             	mov    0xc(%ebp),%eax
801082b0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801082b6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
801082bc:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801082bf:	0f 86 86 00 00 00    	jbe    8010834b <allocuvm+0xbb>
801082c5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801082c8:	8b 7d 08             	mov    0x8(%ebp),%edi
801082cb:	eb 49                	jmp    80108316 <allocuvm+0x86>
801082cd:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
801082d0:	31 d2                	xor    %edx,%edx
801082d2:	b8 00 10 00 00       	mov    $0x1000,%eax
801082d7:	89 54 24 04          	mov    %edx,0x4(%esp)
801082db:	89 44 24 08          	mov    %eax,0x8(%esp)
801082df:	89 34 24             	mov    %esi,(%esp)
801082e2:	e8 29 d8 ff ff       	call   80105b10 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801082e7:	b9 06 00 00 00       	mov    $0x6,%ecx
801082ec:	89 da                	mov    %ebx,%edx
801082ee:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801082f4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801082f8:	b9 00 10 00 00       	mov    $0x1000,%ecx
801082fd:	89 04 24             	mov    %eax,(%esp)
80108300:	89 f8                	mov    %edi,%eax
80108302:	e8 59 fb ff ff       	call   80107e60 <mappages>
80108307:	85 c0                	test   %eax,%eax
80108309:	78 4d                	js     80108358 <allocuvm+0xc8>
  for(; a < newsz; a += PGSIZE){
8010830b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80108311:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80108314:	76 7a                	jbe    80108390 <allocuvm+0x100>
    mem = kalloc();
80108316:	e8 95 a2 ff ff       	call   801025b0 <kalloc>
    if(mem == 0){
8010831b:	85 c0                	test   %eax,%eax
    mem = kalloc();
8010831d:	89 c6                	mov    %eax,%esi
    if(mem == 0){
8010831f:	75 af                	jne    801082d0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80108321:	c7 04 24 f5 90 10 80 	movl   $0x801090f5,(%esp)
80108328:	e8 23 83 ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
8010832d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108330:	39 45 10             	cmp    %eax,0x10(%ebp)
80108333:	77 6b                	ja     801083a0 <allocuvm+0x110>
}
80108335:	83 c4 2c             	add    $0x2c,%esp
    return 0;
80108338:	31 ff                	xor    %edi,%edi
}
8010833a:	5b                   	pop    %ebx
8010833b:	89 f8                	mov    %edi,%eax
8010833d:	5e                   	pop    %esi
8010833e:	5f                   	pop    %edi
8010833f:	5d                   	pop    %ebp
80108340:	c3                   	ret    
80108341:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80108348:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
8010834b:	83 c4 2c             	add    $0x2c,%esp
8010834e:	89 f8                	mov    %edi,%eax
80108350:	5b                   	pop    %ebx
80108351:	5e                   	pop    %esi
80108352:	5f                   	pop    %edi
80108353:	5d                   	pop    %ebp
80108354:	c3                   	ret    
80108355:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80108358:	c7 04 24 0d 91 10 80 	movl   $0x8010910d,(%esp)
8010835f:	e8 ec 82 ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
80108364:	8b 45 0c             	mov    0xc(%ebp),%eax
80108367:	39 45 10             	cmp    %eax,0x10(%ebp)
8010836a:	76 0d                	jbe    80108379 <allocuvm+0xe9>
8010836c:	89 c1                	mov    %eax,%ecx
8010836e:	8b 55 10             	mov    0x10(%ebp),%edx
80108371:	8b 45 08             	mov    0x8(%ebp),%eax
80108374:	e8 77 fb ff ff       	call   80107ef0 <deallocuvm.part.0>
      kfree(mem);
80108379:	89 34 24             	mov    %esi,(%esp)
      return 0;
8010837c:	31 ff                	xor    %edi,%edi
      kfree(mem);
8010837e:	e8 5d a0 ff ff       	call   801023e0 <kfree>
}
80108383:	83 c4 2c             	add    $0x2c,%esp
80108386:	89 f8                	mov    %edi,%eax
80108388:	5b                   	pop    %ebx
80108389:	5e                   	pop    %esi
8010838a:	5f                   	pop    %edi
8010838b:	5d                   	pop    %ebp
8010838c:	c3                   	ret    
8010838d:	8d 76 00             	lea    0x0(%esi),%esi
80108390:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80108393:	83 c4 2c             	add    $0x2c,%esp
80108396:	5b                   	pop    %ebx
80108397:	5e                   	pop    %esi
80108398:	89 f8                	mov    %edi,%eax
8010839a:	5f                   	pop    %edi
8010839b:	5d                   	pop    %ebp
8010839c:	c3                   	ret    
8010839d:	8d 76 00             	lea    0x0(%esi),%esi
801083a0:	89 c1                	mov    %eax,%ecx
801083a2:	8b 55 10             	mov    0x10(%ebp),%edx
      return 0;
801083a5:	31 ff                	xor    %edi,%edi
801083a7:	8b 45 08             	mov    0x8(%ebp),%eax
801083aa:	e8 41 fb ff ff       	call   80107ef0 <deallocuvm.part.0>
801083af:	eb 9a                	jmp    8010834b <allocuvm+0xbb>
801083b1:	eb 0d                	jmp    801083c0 <deallocuvm>
801083b3:	90                   	nop
801083b4:	90                   	nop
801083b5:	90                   	nop
801083b6:	90                   	nop
801083b7:	90                   	nop
801083b8:	90                   	nop
801083b9:	90                   	nop
801083ba:	90                   	nop
801083bb:	90                   	nop
801083bc:	90                   	nop
801083bd:	90                   	nop
801083be:	90                   	nop
801083bf:	90                   	nop

801083c0 <deallocuvm>:
{
801083c0:	55                   	push   %ebp
801083c1:	89 e5                	mov    %esp,%ebp
801083c3:	8b 55 0c             	mov    0xc(%ebp),%edx
801083c6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801083c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801083cc:	39 d1                	cmp    %edx,%ecx
801083ce:	73 10                	jae    801083e0 <deallocuvm+0x20>
}
801083d0:	5d                   	pop    %ebp
801083d1:	e9 1a fb ff ff       	jmp    80107ef0 <deallocuvm.part.0>
801083d6:	8d 76 00             	lea    0x0(%esi),%esi
801083d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801083e0:	89 d0                	mov    %edx,%eax
801083e2:	5d                   	pop    %ebp
801083e3:	c3                   	ret    
801083e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801083ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801083f0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801083f0:	55                   	push   %ebp
801083f1:	89 e5                	mov    %esp,%ebp
801083f3:	57                   	push   %edi
801083f4:	56                   	push   %esi
801083f5:	53                   	push   %ebx
801083f6:	83 ec 1c             	sub    $0x1c,%esp
801083f9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801083fc:	85 f6                	test   %esi,%esi
801083fe:	74 55                	je     80108455 <freevm+0x65>
80108400:	31 c9                	xor    %ecx,%ecx
80108402:	ba 00 00 00 80       	mov    $0x80000000,%edx
80108407:	89 f0                	mov    %esi,%eax
80108409:	89 f3                	mov    %esi,%ebx
8010840b:	e8 e0 fa ff ff       	call   80107ef0 <deallocuvm.part.0>
80108410:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80108416:	eb 0f                	jmp    80108427 <freevm+0x37>
80108418:	90                   	nop
80108419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108420:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80108423:	39 fb                	cmp    %edi,%ebx
80108425:	74 1f                	je     80108446 <freevm+0x56>
    if(pgdir[i] & PTE_P){
80108427:	8b 03                	mov    (%ebx),%eax
80108429:	a8 01                	test   $0x1,%al
8010842b:	74 f3                	je     80108420 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010842d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108432:	83 c3 04             	add    $0x4,%ebx
80108435:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010843a:	89 04 24             	mov    %eax,(%esp)
8010843d:	e8 9e 9f ff ff       	call   801023e0 <kfree>
  for(i = 0; i < NPDENTRIES; i++){
80108442:	39 fb                	cmp    %edi,%ebx
80108444:	75 e1                	jne    80108427 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80108446:	89 75 08             	mov    %esi,0x8(%ebp)
}
80108449:	83 c4 1c             	add    $0x1c,%esp
8010844c:	5b                   	pop    %ebx
8010844d:	5e                   	pop    %esi
8010844e:	5f                   	pop    %edi
8010844f:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80108450:	e9 8b 9f ff ff       	jmp    801023e0 <kfree>
    panic("freevm: no pgdir");
80108455:	c7 04 24 29 91 10 80 	movl   $0x80109129,(%esp)
8010845c:	e8 0f 7f ff ff       	call   80100370 <panic>
80108461:	eb 0d                	jmp    80108470 <setupkvm>
80108463:	90                   	nop
80108464:	90                   	nop
80108465:	90                   	nop
80108466:	90                   	nop
80108467:	90                   	nop
80108468:	90                   	nop
80108469:	90                   	nop
8010846a:	90                   	nop
8010846b:	90                   	nop
8010846c:	90                   	nop
8010846d:	90                   	nop
8010846e:	90                   	nop
8010846f:	90                   	nop

80108470 <setupkvm>:
{
80108470:	55                   	push   %ebp
80108471:	89 e5                	mov    %esp,%ebp
80108473:	56                   	push   %esi
80108474:	53                   	push   %ebx
80108475:	83 ec 10             	sub    $0x10,%esp
  if((pgdir = (pde_t*)kalloc()) == 0)
80108478:	e8 33 a1 ff ff       	call   801025b0 <kalloc>
8010847d:	85 c0                	test   %eax,%eax
8010847f:	89 c6                	mov    %eax,%esi
80108481:	74 46                	je     801084c9 <setupkvm+0x59>
  memset(pgdir, 0, PGSIZE);
80108483:	b8 00 10 00 00       	mov    $0x1000,%eax
80108488:	31 d2                	xor    %edx,%edx
8010848a:	89 44 24 08          	mov    %eax,0x8(%esp)
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010848e:	bb 20 c4 10 80       	mov    $0x8010c420,%ebx
  memset(pgdir, 0, PGSIZE);
80108493:	89 54 24 04          	mov    %edx,0x4(%esp)
80108497:	89 34 24             	mov    %esi,(%esp)
8010849a:	e8 71 d6 ff ff       	call   80105b10 <memset>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010849f:	8b 53 0c             	mov    0xc(%ebx),%edx
                (uint)k->phys_start, k->perm) < 0) {
801084a2:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801084a5:	8b 4b 08             	mov    0x8(%ebx),%ecx
801084a8:	89 54 24 04          	mov    %edx,0x4(%esp)
801084ac:	8b 13                	mov    (%ebx),%edx
801084ae:	89 04 24             	mov    %eax,(%esp)
801084b1:	29 c1                	sub    %eax,%ecx
801084b3:	89 f0                	mov    %esi,%eax
801084b5:	e8 a6 f9 ff ff       	call   80107e60 <mappages>
801084ba:	85 c0                	test   %eax,%eax
801084bc:	78 1a                	js     801084d8 <setupkvm+0x68>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801084be:	83 c3 10             	add    $0x10,%ebx
801084c1:	81 fb 60 c4 10 80    	cmp    $0x8010c460,%ebx
801084c7:	75 d6                	jne    8010849f <setupkvm+0x2f>
}
801084c9:	83 c4 10             	add    $0x10,%esp
801084cc:	89 f0                	mov    %esi,%eax
801084ce:	5b                   	pop    %ebx
801084cf:	5e                   	pop    %esi
801084d0:	5d                   	pop    %ebp
801084d1:	c3                   	ret    
801084d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      freevm(pgdir);
801084d8:	89 34 24             	mov    %esi,(%esp)
      return 0;
801084db:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
801084dd:	e8 0e ff ff ff       	call   801083f0 <freevm>
}
801084e2:	83 c4 10             	add    $0x10,%esp
801084e5:	89 f0                	mov    %esi,%eax
801084e7:	5b                   	pop    %ebx
801084e8:	5e                   	pop    %esi
801084e9:	5d                   	pop    %ebp
801084ea:	c3                   	ret    
801084eb:	90                   	nop
801084ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801084f0 <kvmalloc>:
{
801084f0:	55                   	push   %ebp
801084f1:	89 e5                	mov    %esp,%ebp
801084f3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801084f6:	e8 75 ff ff ff       	call   80108470 <setupkvm>
801084fb:	a3 04 82 11 80       	mov    %eax,0x80118204
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108500:	05 00 00 00 80       	add    $0x80000000,%eax
80108505:	0f 22 d8             	mov    %eax,%cr3
}
80108508:	c9                   	leave  
80108509:	c3                   	ret    
8010850a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108510 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108510:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108511:	31 c9                	xor    %ecx,%ecx
{
80108513:	89 e5                	mov    %esp,%ebp
80108515:	83 ec 18             	sub    $0x18,%esp
  pte = walkpgdir(pgdir, uva, 0);
80108518:	8b 55 0c             	mov    0xc(%ebp),%edx
8010851b:	8b 45 08             	mov    0x8(%ebp),%eax
8010851e:	e8 ad f8 ff ff       	call   80107dd0 <walkpgdir>
  if(pte == 0)
80108523:	85 c0                	test   %eax,%eax
80108525:	74 05                	je     8010852c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80108527:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010852a:	c9                   	leave  
8010852b:	c3                   	ret    
    panic("clearpteu");
8010852c:	c7 04 24 3a 91 10 80 	movl   $0x8010913a,(%esp)
80108533:	e8 38 7e ff ff       	call   80100370 <panic>
80108538:	90                   	nop
80108539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108540 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108540:	55                   	push   %ebp
80108541:	89 e5                	mov    %esp,%ebp
80108543:	57                   	push   %edi
80108544:	56                   	push   %esi
80108545:	53                   	push   %ebx
80108546:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80108549:	e8 22 ff ff ff       	call   80108470 <setupkvm>
8010854e:	85 c0                	test   %eax,%eax
80108550:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108553:	0f 84 a3 00 00 00    	je     801085fc <copyuvm+0xbc>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108559:	8b 55 0c             	mov    0xc(%ebp),%edx
8010855c:	85 d2                	test   %edx,%edx
8010855e:	0f 84 98 00 00 00    	je     801085fc <copyuvm+0xbc>
80108564:	31 ff                	xor    %edi,%edi
80108566:	eb 50                	jmp    801085b8 <copyuvm+0x78>
80108568:	90                   	nop
80108569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80108570:	b8 00 10 00 00       	mov    $0x1000,%eax
80108575:	89 44 24 08          	mov    %eax,0x8(%esp)
80108579:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010857c:	89 34 24             	mov    %esi,(%esp)
8010857f:	05 00 00 00 80       	add    $0x80000000,%eax
80108584:	89 44 24 04          	mov    %eax,0x4(%esp)
80108588:	e8 43 d6 ff ff       	call   80105bd0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
8010858d:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80108593:	b9 00 10 00 00       	mov    $0x1000,%ecx
80108598:	89 04 24             	mov    %eax,(%esp)
8010859b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010859e:	89 fa                	mov    %edi,%edx
801085a0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801085a4:	e8 b7 f8 ff ff       	call   80107e60 <mappages>
801085a9:	85 c0                	test   %eax,%eax
801085ab:	78 63                	js     80108610 <copyuvm+0xd0>
  for(i = 0; i < sz; i += PGSIZE){
801085ad:	81 c7 00 10 00 00    	add    $0x1000,%edi
801085b3:	39 7d 0c             	cmp    %edi,0xc(%ebp)
801085b6:	76 44                	jbe    801085fc <copyuvm+0xbc>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801085b8:	8b 45 08             	mov    0x8(%ebp),%eax
801085bb:	31 c9                	xor    %ecx,%ecx
801085bd:	89 fa                	mov    %edi,%edx
801085bf:	e8 0c f8 ff ff       	call   80107dd0 <walkpgdir>
801085c4:	85 c0                	test   %eax,%eax
801085c6:	74 5e                	je     80108626 <copyuvm+0xe6>
    if(!(*pte & PTE_P))
801085c8:	8b 18                	mov    (%eax),%ebx
801085ca:	f6 c3 01             	test   $0x1,%bl
801085cd:	74 4b                	je     8010861a <copyuvm+0xda>
    pa = PTE_ADDR(*pte);
801085cf:	89 d8                	mov    %ebx,%eax
    flags = PTE_FLAGS(*pte);
801085d1:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
801085d7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801085dc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
801085df:	e8 cc 9f ff ff       	call   801025b0 <kalloc>
801085e4:	85 c0                	test   %eax,%eax
801085e6:	89 c6                	mov    %eax,%esi
801085e8:	75 86                	jne    80108570 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
801085ea:	8b 45 e0             	mov    -0x20(%ebp),%eax
801085ed:	89 04 24             	mov    %eax,(%esp)
801085f0:	e8 fb fd ff ff       	call   801083f0 <freevm>
  return 0;
801085f5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
801085fc:	8b 45 e0             	mov    -0x20(%ebp),%eax
801085ff:	83 c4 2c             	add    $0x2c,%esp
80108602:	5b                   	pop    %ebx
80108603:	5e                   	pop    %esi
80108604:	5f                   	pop    %edi
80108605:	5d                   	pop    %ebp
80108606:	c3                   	ret    
80108607:	89 f6                	mov    %esi,%esi
80108609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      kfree(mem);
80108610:	89 34 24             	mov    %esi,(%esp)
80108613:	e8 c8 9d ff ff       	call   801023e0 <kfree>
      goto bad;
80108618:	eb d0                	jmp    801085ea <copyuvm+0xaa>
      panic("copyuvm: page not present");
8010861a:	c7 04 24 5e 91 10 80 	movl   $0x8010915e,(%esp)
80108621:	e8 4a 7d ff ff       	call   80100370 <panic>
      panic("copyuvm: pte should exist");
80108626:	c7 04 24 44 91 10 80 	movl   $0x80109144,(%esp)
8010862d:	e8 3e 7d ff ff       	call   80100370 <panic>
80108632:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108640 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108640:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108641:	31 c9                	xor    %ecx,%ecx
{
80108643:	89 e5                	mov    %esp,%ebp
80108645:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80108648:	8b 55 0c             	mov    0xc(%ebp),%edx
8010864b:	8b 45 08             	mov    0x8(%ebp),%eax
8010864e:	e8 7d f7 ff ff       	call   80107dd0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80108653:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80108655:	89 c2                	mov    %eax,%edx
80108657:	83 e2 05             	and    $0x5,%edx
8010865a:	83 fa 05             	cmp    $0x5,%edx
8010865d:	75 11                	jne    80108670 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
8010865f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108664:	05 00 00 00 80       	add    $0x80000000,%eax
}
80108669:	c9                   	leave  
8010866a:	c3                   	ret    
8010866b:	90                   	nop
8010866c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80108670:	31 c0                	xor    %eax,%eax
}
80108672:	c9                   	leave  
80108673:	c3                   	ret    
80108674:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010867a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80108680 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108680:	55                   	push   %ebp
80108681:	89 e5                	mov    %esp,%ebp
80108683:	57                   	push   %edi
80108684:	56                   	push   %esi
80108685:	53                   	push   %ebx
80108686:	83 ec 2c             	sub    $0x2c,%esp
80108689:	8b 75 14             	mov    0x14(%ebp),%esi
8010868c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
8010868f:	85 f6                	test   %esi,%esi
80108691:	74 75                	je     80108708 <copyout+0x88>
80108693:	89 da                	mov    %ebx,%edx
80108695:	eb 3f                	jmp    801086d6 <copyout+0x56>
80108697:	89 f6                	mov    %esi,%esi
80108699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801086a0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801086a3:	89 df                	mov    %ebx,%edi
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801086a5:	8b 4d 10             	mov    0x10(%ebp),%ecx
    n = PGSIZE - (va - va0);
801086a8:	29 d7                	sub    %edx,%edi
801086aa:	81 c7 00 10 00 00    	add    $0x1000,%edi
801086b0:	39 f7                	cmp    %esi,%edi
801086b2:	0f 47 fe             	cmova  %esi,%edi
    memmove(pa0 + (va - va0), buf, n);
801086b5:	29 da                	sub    %ebx,%edx
801086b7:	01 c2                	add    %eax,%edx
801086b9:	89 14 24             	mov    %edx,(%esp)
801086bc:	89 7c 24 08          	mov    %edi,0x8(%esp)
801086c0:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801086c4:	e8 07 d5 ff ff       	call   80105bd0 <memmove>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
801086c9:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    buf += n;
801086cf:	01 7d 10             	add    %edi,0x10(%ebp)
  while(len > 0){
801086d2:	29 fe                	sub    %edi,%esi
801086d4:	74 32                	je     80108708 <copyout+0x88>
    pa0 = uva2ka(pgdir, (char*)va0);
801086d6:	8b 45 08             	mov    0x8(%ebp),%eax
    va0 = (uint)PGROUNDDOWN(va);
801086d9:	89 d3                	mov    %edx,%ebx
801086db:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    pa0 = uva2ka(pgdir, (char*)va0);
801086e1:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    va0 = (uint)PGROUNDDOWN(va);
801086e5:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
801086e8:	89 04 24             	mov    %eax,(%esp)
801086eb:	e8 50 ff ff ff       	call   80108640 <uva2ka>
    if(pa0 == 0)
801086f0:	85 c0                	test   %eax,%eax
801086f2:	75 ac                	jne    801086a0 <copyout+0x20>
  }
  return 0;
}
801086f4:	83 c4 2c             	add    $0x2c,%esp
      return -1;
801086f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801086fc:	5b                   	pop    %ebx
801086fd:	5e                   	pop    %esi
801086fe:	5f                   	pop    %edi
801086ff:	5d                   	pop    %ebp
80108700:	c3                   	ret    
80108701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108708:	83 c4 2c             	add    $0x2c,%esp
  return 0;
8010870b:	31 c0                	xor    %eax,%eax
}
8010870d:	5b                   	pop    %ebx
8010870e:	5e                   	pop    %esi
8010870f:	5f                   	pop    %edi
80108710:	5d                   	pop    %ebp
80108711:	c3                   	ret    
