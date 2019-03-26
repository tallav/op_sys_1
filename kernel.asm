
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
80100028:	bc 30 d6 10 80       	mov    $0x8010d630,%esp

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
80100041:	ba 60 89 10 80       	mov    $0x80108960,%edx
{
80100046:	89 e5                	mov    %esp,%ebp
80100048:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
80100049:	bb 3c 1d 11 80       	mov    $0x80111d3c,%ebx
{
8010004e:	83 ec 14             	sub    $0x14,%esp
  initlock(&bcache.lock, "bcache");
80100051:	89 54 24 04          	mov    %edx,0x4(%esp)
80100055:	c7 04 24 40 d6 10 80 	movl   $0x8010d640,(%esp)
8010005c:	e8 9f 5a 00 00       	call   80105b00 <initlock>
  bcache.head.prev = &bcache.head;
80100061:	b9 3c 1d 11 80       	mov    $0x80111d3c,%ecx
  bcache.head.next = &bcache.head;
80100066:	ba 3c 1d 11 80       	mov    $0x80111d3c,%edx
8010006b:	89 1d 90 1d 11 80    	mov    %ebx,0x80111d90
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100071:	bb 74 d6 10 80       	mov    $0x8010d674,%ebx
  bcache.head.prev = &bcache.head;
80100076:	89 0d 8c 1d 11 80    	mov    %ecx,0x80111d8c
8010007c:	eb 04                	jmp    80100082 <binit+0x42>
8010007e:	66 90                	xchg   %ax,%ax
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	b8 67 89 10 80       	mov    $0x80108967,%eax
    b->next = bcache.head.next;
80100087:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008a:	c7 43 50 3c 1d 11 80 	movl   $0x80111d3c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100091:	89 44 24 04          	mov    %eax,0x4(%esp)
80100095:	8d 43 0c             	lea    0xc(%ebx),%eax
80100098:	89 04 24             	mov    %eax,(%esp)
8010009b:	e8 30 59 00 00       	call   801059d0 <initsleeplock>
    bcache.head.next->prev = b;
801000a0:	a1 90 1d 11 80       	mov    0x80111d90,%eax
801000a5:	89 da                	mov    %ebx,%edx
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
801000b0:	3d 3c 1d 11 80       	cmp    $0x80111d3c,%eax
    bcache.head.next = b;
801000b5:	89 1d 90 1d 11 80    	mov    %ebx,0x80111d90
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
801000d9:	c7 04 24 40 d6 10 80 	movl   $0x8010d640,(%esp)
{
801000e0:	8b 75 08             	mov    0x8(%ebp),%esi
801000e3:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000e6:	e8 65 5b 00 00       	call   80105c50 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000eb:	8b 1d 90 1d 11 80    	mov    0x80111d90,%ebx
801000f1:	81 fb 3c 1d 11 80    	cmp    $0x80111d3c,%ebx
801000f7:	75 12                	jne    8010010b <bread+0x3b>
801000f9:	eb 25                	jmp    80100120 <bread+0x50>
801000fb:	90                   	nop
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 3c 1d 11 80    	cmp    $0x80111d3c,%ebx
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
80100120:	8b 1d 8c 1d 11 80    	mov    0x80111d8c,%ebx
80100126:	81 fb 3c 1d 11 80    	cmp    $0x80111d3c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 58                	jmp    80100188 <bread+0xb8>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 3c 1d 11 80    	cmp    $0x80111d3c,%ebx
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
8010015a:	c7 04 24 40 d6 10 80 	movl   $0x8010d640,(%esp)
80100161:	e8 8a 5b 00 00       	call   80105cf0 <release>
      acquiresleep(&b->lock);
80100166:	8d 43 0c             	lea    0xc(%ebx),%eax
80100169:	89 04 24             	mov    %eax,(%esp)
8010016c:	e8 9f 58 00 00       	call   80105a10 <acquiresleep>
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
80100188:	c7 04 24 6e 89 10 80 	movl   $0x8010896e,(%esp)
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
801001b0:	e8 fb 58 00 00       	call   80105ab0 <holdingsleep>
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
801001c9:	c7 04 24 7f 89 10 80 	movl   $0x8010897f,(%esp)
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
801001f1:	e8 ba 58 00 00       	call   80105ab0 <holdingsleep>
801001f6:	85 c0                	test   %eax,%eax
801001f8:	74 5a                	je     80100254 <brelse+0x74>
    panic("brelse");

  releasesleep(&b->lock);
801001fa:	89 34 24             	mov    %esi,(%esp)
801001fd:	e8 6e 58 00 00       	call   80105a70 <releasesleep>

  acquire(&bcache.lock);
80100202:	c7 04 24 40 d6 10 80 	movl   $0x8010d640,(%esp)
80100209:	e8 42 5a 00 00       	call   80105c50 <acquire>
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
80100225:	a1 90 1d 11 80       	mov    0x80111d90,%eax
    b->prev = &bcache.head;
8010022a:	c7 43 50 3c 1d 11 80 	movl   $0x80111d3c,0x50(%ebx)
    b->next = bcache.head.next;
80100231:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100234:	a1 90 1d 11 80       	mov    0x80111d90,%eax
80100239:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010023c:	89 1d 90 1d 11 80    	mov    %ebx,0x80111d90
  }
  
  release(&bcache.lock);
80100242:	c7 45 08 40 d6 10 80 	movl   $0x8010d640,0x8(%ebp)
}
80100249:	83 c4 10             	add    $0x10,%esp
8010024c:	5b                   	pop    %ebx
8010024d:	5e                   	pop    %esi
8010024e:	5d                   	pop    %ebp
  release(&bcache.lock);
8010024f:	e9 9c 5a 00 00       	jmp    80105cf0 <release>
    panic("brelse");
80100254:	c7 04 24 86 89 10 80 	movl   $0x80108986,(%esp)
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
8010027e:	e8 cd 59 00 00       	call   80105c50 <acquire>
  while(n > 0){
80100283:	31 c0                	xor    %eax,%eax
80100285:	85 f6                	test   %esi,%esi
80100287:	0f 8e a3 00 00 00    	jle    80100330 <consoleread+0xd0>
8010028d:	89 f3                	mov    %esi,%ebx
8010028f:	89 75 10             	mov    %esi,0x10(%ebp)
80100292:	8b 75 0c             	mov    0xc(%ebp),%esi
    while(input.r == input.w){
80100295:	8b 15 20 20 11 80    	mov    0x80112020,%edx
8010029b:	39 15 24 20 11 80    	cmp    %edx,0x80112024
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
801002b1:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
801002b8:	e8 53 42 00 00       	call   80104510 <sleep>
    while(input.r == input.w){
801002bd:	8b 15 20 20 11 80    	mov    0x80112020,%edx
801002c3:	3b 15 24 20 11 80    	cmp    0x80112024,%edx
801002c9:	75 35                	jne    80100300 <consoleread+0xa0>
      if(myproc()->killed){
801002cb:	e8 d0 36 00 00       	call   801039a0 <myproc>
801002d0:	8b 50 24             	mov    0x24(%eax),%edx
801002d3:	85 d2                	test   %edx,%edx
801002d5:	74 d1                	je     801002a8 <consoleread+0x48>
        release(&cons.lock);
801002d7:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
801002de:	e8 0d 5a 00 00       	call   80105cf0 <release>
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
80100303:	a3 20 20 11 80       	mov    %eax,0x80112020
80100308:	89 d0                	mov    %edx,%eax
8010030a:	83 e0 7f             	and    $0x7f,%eax
8010030d:	0f be 80 a0 1f 11 80 	movsbl -0x7feee060(%eax),%eax
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
8010033a:	e8 b1 59 00 00       	call   80105cf0 <release>
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
8010035d:	89 15 20 20 11 80    	mov    %edx,0x80112020
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
8010038c:	c7 04 24 8d 89 10 80 	movl   $0x8010898d,(%esp)
80100393:	89 44 24 04          	mov    %eax,0x4(%esp)
80100397:	e8 b4 02 00 00       	call   80100650 <cprintf>
  cprintf(s);
8010039c:	8b 45 08             	mov    0x8(%ebp),%eax
8010039f:	89 04 24             	mov    %eax,(%esp)
801003a2:	e8 a9 02 00 00       	call   80100650 <cprintf>
  cprintf("\n");
801003a7:	c7 04 24 4d 90 10 80 	movl   $0x8010904d,(%esp)
801003ae:	e8 9d 02 00 00       	call   80100650 <cprintf>
  getcallerpcs(&s, pcs);
801003b3:	8d 45 08             	lea    0x8(%ebp),%eax
801003b6:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801003ba:	89 04 24             	mov    %eax,(%esp)
801003bd:	e8 5e 57 00 00       	call   80105b20 <getcallerpcs>
801003c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    cprintf(" %p", pcs[i]);
801003d0:	8b 03                	mov    (%ebx),%eax
801003d2:	83 c3 04             	add    $0x4,%ebx
801003d5:	c7 04 24 a1 89 10 80 	movl   $0x801089a1,(%esp)
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
80100429:	e8 12 71 00 00       	call   80107540 <uartputc>
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
801004cc:	e8 6f 70 00 00       	call   80107540 <uartputc>
801004d1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004d8:	e8 63 70 00 00       	call   80107540 <uartputc>
801004dd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004e4:	e8 57 70 00 00       	call   80107540 <uartputc>
801004e9:	e9 40 ff ff ff       	jmp    8010042e <consputc+0x2e>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004ee:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
801004f5:	00 
801004f6:	c7 44 24 04 a0 80 0b 	movl   $0x800b80a0,0x4(%esp)
801004fd:	80 
801004fe:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
80100505:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80100508:	e8 f3 58 00 00       	call   80105e00 <memmove>
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
80100536:	e8 05 58 00 00       	call   80105d40 <memset>
8010053b:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010053e:	e9 4c ff ff ff       	jmp    8010048f <consputc+0x8f>
    panic("pos under/overflow");
80100543:	c7 04 24 a5 89 10 80 	movl   $0x801089a5,(%esp)
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
801005a1:	0f b6 92 d0 89 10 80 	movzbl -0x7fef7630(%edx),%edx
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
8010060e:	e8 3d 56 00 00       	call   80105c50 <acquire>
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
80100634:	e8 b7 56 00 00       	call   80105cf0 <release>
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
8010070e:	e8 dd 55 00 00       	call   80105cf0 <release>
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
80100774:	bf b8 89 10 80       	mov    $0x801089b8,%edi
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
801007b7:	e8 94 54 00 00       	call   80105c50 <acquire>
801007bc:	e9 a8 fe ff ff       	jmp    80100669 <cprintf+0x19>
    panic("null fmt");
801007c1:	c7 04 24 bf 89 10 80 	movl   $0x801089bf,(%esp)
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
801007e4:	e8 67 54 00 00       	call   80105c50 <acquire>
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
80100812:	a1 28 20 11 80       	mov    0x80112028,%eax
80100817:	3b 05 24 20 11 80    	cmp    0x80112024,%eax
8010081d:	74 d1                	je     801007f0 <consoleintr+0x20>
        input.e--;
8010081f:	48                   	dec    %eax
80100820:	a3 28 20 11 80       	mov    %eax,0x80112028
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
80100847:	e8 a4 54 00 00       	call   80105cf0 <release>
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
80100869:	a1 28 20 11 80       	mov    0x80112028,%eax
8010086e:	89 c1                	mov    %eax,%ecx
80100870:	2b 0d 20 20 11 80    	sub    0x80112020,%ecx
80100876:	83 f9 7f             	cmp    $0x7f,%ecx
80100879:	0f 87 71 ff ff ff    	ja     801007f0 <consoleintr+0x20>
8010087f:	8d 48 01             	lea    0x1(%eax),%ecx
80100882:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
80100885:	83 fa 0d             	cmp    $0xd,%edx
        input.buf[input.e++ % INPUT_BUF] = c;
80100888:	89 0d 28 20 11 80    	mov    %ecx,0x80112028
        c = (c == '\r') ? '\n' : c;
8010088e:	0f 84 c4 00 00 00    	je     80100958 <consoleintr+0x188>
        input.buf[input.e++ % INPUT_BUF] = c;
80100894:	88 90 a0 1f 11 80    	mov    %dl,-0x7feee060(%eax)
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
801008b9:	a1 20 20 11 80       	mov    0x80112020,%eax
801008be:	83 e8 80             	sub    $0xffffff80,%eax
801008c1:	39 05 28 20 11 80    	cmp    %eax,0x80112028
801008c7:	0f 85 23 ff ff ff    	jne    801007f0 <consoleintr+0x20>
          wakeup(&input.r);
801008cd:	c7 04 24 20 20 11 80 	movl   $0x80112020,(%esp)
          input.w = input.e;
801008d4:	a3 24 20 11 80       	mov    %eax,0x80112024
          wakeup(&input.r);
801008d9:	e8 32 3e 00 00       	call   80104710 <wakeup>
801008de:	e9 0d ff ff ff       	jmp    801007f0 <consoleintr+0x20>
801008e3:	90                   	nop
801008e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
801008e8:	be 01 00 00 00       	mov    $0x1,%esi
801008ed:	e9 fe fe ff ff       	jmp    801007f0 <consoleintr+0x20>
801008f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
801008f8:	a1 28 20 11 80       	mov    0x80112028,%eax
801008fd:	39 05 24 20 11 80    	cmp    %eax,0x80112024
80100903:	75 2b                	jne    80100930 <consoleintr+0x160>
80100905:	e9 e6 fe ff ff       	jmp    801007f0 <consoleintr+0x20>
8010090a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100910:	a3 28 20 11 80       	mov    %eax,0x80112028
        consputc(BACKSPACE);
80100915:	b8 00 01 00 00       	mov    $0x100,%eax
8010091a:	e8 e1 fa ff ff       	call   80100400 <consputc>
      while(input.e != input.w &&
8010091f:	a1 28 20 11 80       	mov    0x80112028,%eax
80100924:	3b 05 24 20 11 80    	cmp    0x80112024,%eax
8010092a:	0f 84 c0 fe ff ff    	je     801007f0 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100930:	48                   	dec    %eax
80100931:	89 c2                	mov    %eax,%edx
80100933:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100936:	80 ba a0 1f 11 80 0a 	cmpb   $0xa,-0x7feee060(%edx)
8010093d:	75 d1                	jne    80100910 <consoleintr+0x140>
8010093f:	e9 ac fe ff ff       	jmp    801007f0 <consoleintr+0x20>
80100944:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80100948:	83 c4 20             	add    $0x20,%esp
8010094b:	5b                   	pop    %ebx
8010094c:	5e                   	pop    %esi
8010094d:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
8010094e:	e9 cd 40 00 00       	jmp    80104a20 <procdump>
80100953:	90                   	nop
80100954:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
80100958:	c6 80 a0 1f 11 80 0a 	movb   $0xa,-0x7feee060(%eax)
        consputc(c);
8010095f:	b8 0a 00 00 00       	mov    $0xa,%eax
80100964:	e8 97 fa ff ff       	call   80100400 <consputc>
80100969:	a1 28 20 11 80       	mov    0x80112028,%eax
8010096e:	e9 5a ff ff ff       	jmp    801008cd <consoleintr+0xfd>
80100973:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100980 <consoleinit>:

void
consoleinit(void)
{
80100980:	55                   	push   %ebp
  initlock(&cons.lock, "console");
80100981:	b8 c8 89 10 80       	mov    $0x801089c8,%eax
{
80100986:	89 e5                	mov    %esp,%ebp
80100988:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
8010098b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010098f:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
80100996:	e8 65 51 00 00       	call   80105b00 <initlock>

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
801009bc:	89 15 ec 29 11 80    	mov    %edx,0x801129ec
  devsw[CONSOLE].read = consoleread;
801009c2:	89 0d e8 29 11 80    	mov    %ecx,0x801129e8
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
80100a5c:	e8 3f 7c 00 00       	call   801086a0 <setupkvm>
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
80100ac8:	e8 f3 79 00 00       	call   801084c0 <allocuvm>
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
80100b05:	e8 f6 78 00 00       	call   80108400 <loaduvm>
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
80100b58:	e8 c3 7a 00 00       	call   80108620 <freevm>
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
80100b92:	e8 29 79 00 00       	call   801084c0 <allocuvm>
80100b97:	85 c0                	test   %eax,%eax
80100b99:	89 c6                	mov    %eax,%esi
80100b9b:	75 33                	jne    80100bd0 <exec+0x200>
    freevm(pgdir);
80100b9d:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ba3:	89 04 24             	mov    %eax,(%esp)
80100ba6:	e8 75 7a 00 00       	call   80108620 <freevm>
  return -1;
80100bab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bb0:	e9 8c fe ff ff       	jmp    80100a41 <exec+0x71>
    end_op();
80100bb5:	e8 46 21 00 00       	call   80102d00 <end_op>
    cprintf("exec: fail\n");
80100bba:	c7 04 24 e1 89 10 80 	movl   $0x801089e1,(%esp)
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
80100be7:	e8 54 7b 00 00       	call   80108740 <clearpteu>
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
80100c18:	e8 43 53 00 00       	call   80105f60 <strlen>
80100c1d:	f7 d0                	not    %eax
80100c1f:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c21:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c24:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c27:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c2a:	89 04 24             	mov    %eax,(%esp)
80100c2d:	e8 2e 53 00 00       	call   80105f60 <strlen>
80100c32:	40                   	inc    %eax
80100c33:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c37:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c3a:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c3d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100c41:	89 34 24             	mov    %esi,(%esp)
80100c44:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c48:	e8 63 7c 00 00       	call   801088b0 <copyout>
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
80100cb8:	e8 f3 7b 00 00       	call   801088b0 <copyout>
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
80100d01:	e8 1a 52 00 00       	call   80105f20 <safestrcpy>
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
80100d2b:	e8 40 75 00 00       	call   80108270 <switchuvm>
  freevm(oldpgdir);
80100d30:	89 3c 24             	mov    %edi,(%esp)
80100d33:	e8 e8 78 00 00       	call   80108620 <freevm>
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
80100d51:	b8 ed 89 10 80       	mov    $0x801089ed,%eax
{
80100d56:	89 e5                	mov    %esp,%ebp
80100d58:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100d5b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100d5f:	c7 04 24 40 20 11 80 	movl   $0x80112040,(%esp)
80100d66:	e8 95 4d 00 00       	call   80105b00 <initlock>
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
80100d74:	bb 74 20 11 80       	mov    $0x80112074,%ebx
{
80100d79:	83 ec 14             	sub    $0x14,%esp
  acquire(&ftable.lock);
80100d7c:	c7 04 24 40 20 11 80 	movl   $0x80112040,(%esp)
80100d83:	e8 c8 4e 00 00       	call   80105c50 <acquire>
80100d88:	eb 11                	jmp    80100d9b <filealloc+0x2b>
80100d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d90:	83 c3 18             	add    $0x18,%ebx
80100d93:	81 fb d4 29 11 80    	cmp    $0x801129d4,%ebx
80100d99:	73 25                	jae    80100dc0 <filealloc+0x50>
    if(f->ref == 0){
80100d9b:	8b 43 04             	mov    0x4(%ebx),%eax
80100d9e:	85 c0                	test   %eax,%eax
80100da0:	75 ee                	jne    80100d90 <filealloc+0x20>
      f->ref = 1;
80100da2:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100da9:	c7 04 24 40 20 11 80 	movl   $0x80112040,(%esp)
80100db0:	e8 3b 4f 00 00       	call   80105cf0 <release>
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
80100dc0:	c7 04 24 40 20 11 80 	movl   $0x80112040,(%esp)
  return 0;
80100dc7:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100dc9:	e8 22 4f 00 00       	call   80105cf0 <release>
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
80100dea:	c7 04 24 40 20 11 80 	movl   $0x80112040,(%esp)
80100df1:	e8 5a 4e 00 00       	call   80105c50 <acquire>
  if(f->ref < 1)
80100df6:	8b 43 04             	mov    0x4(%ebx),%eax
80100df9:	85 c0                	test   %eax,%eax
80100dfb:	7e 18                	jle    80100e15 <filedup+0x35>
    panic("filedup");
  f->ref++;
80100dfd:	40                   	inc    %eax
80100dfe:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e01:	c7 04 24 40 20 11 80 	movl   $0x80112040,(%esp)
80100e08:	e8 e3 4e 00 00       	call   80105cf0 <release>
  return f;
}
80100e0d:	83 c4 14             	add    $0x14,%esp
80100e10:	89 d8                	mov    %ebx,%eax
80100e12:	5b                   	pop    %ebx
80100e13:	5d                   	pop    %ebp
80100e14:	c3                   	ret    
    panic("filedup");
80100e15:	c7 04 24 f4 89 10 80 	movl   $0x801089f4,(%esp)
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
80100e3c:	c7 04 24 40 20 11 80 	movl   $0x80112040,(%esp)
{
80100e43:	89 75 f8             	mov    %esi,-0x8(%ebp)
80100e46:	89 7d fc             	mov    %edi,-0x4(%ebp)
  acquire(&ftable.lock);
80100e49:	e8 02 4e 00 00       	call   80105c50 <acquire>
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
80100e61:	c7 45 08 40 20 11 80 	movl   $0x80112040,0x8(%ebp)
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
80100e74:	e9 77 4e 00 00       	jmp    80105cf0 <release>
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
80100e95:	c7 04 24 40 20 11 80 	movl   $0x80112040,(%esp)
  ff = *f;
80100e9c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100e9f:	e8 4c 4e 00 00       	call   80105cf0 <release>
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
80100ef9:	c7 04 24 fc 89 10 80 	movl   $0x801089fc,(%esp)
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
80100ff7:	c7 04 24 06 8a 10 80 	movl   $0x80108a06,(%esp)
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
80101112:	c7 04 24 0f 8a 10 80 	movl   $0x80108a0f,(%esp)
80101119:	e8 52 f2 ff ff       	call   80100370 <panic>
  panic("filewrite");
8010111e:	c7 04 24 15 8a 10 80 	movl   $0x80108a15,(%esp)
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
80101139:	8b 35 40 2a 11 80    	mov    0x80112a40,%esi
{
8010113f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101142:	85 f6                	test   %esi,%esi
80101144:	0f 84 7e 00 00 00    	je     801011c8 <balloc+0x98>
8010114a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101151:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101154:	8b 1d 58 2a 11 80    	mov    0x80112a58,%ebx
8010115a:	89 f0                	mov    %esi,%eax
8010115c:	c1 f8 0c             	sar    $0xc,%eax
8010115f:	01 d8                	add    %ebx,%eax
80101161:	89 44 24 04          	mov    %eax,0x4(%esp)
80101165:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101168:	89 04 24             	mov    %eax,(%esp)
8010116b:	e8 60 ef ff ff       	call   801000d0 <bread>
80101170:	89 c3                	mov    %eax,%ebx
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101172:	a1 40 2a 11 80       	mov    0x80112a40,%eax
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
801011c0:	39 05 40 2a 11 80    	cmp    %eax,0x80112a40
801011c6:	77 89                	ja     80101151 <balloc+0x21>
  }
  panic("balloc: out of blocks");
801011c8:	c7 04 24 1f 8a 10 80 	movl   $0x80108a1f,(%esp)
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
80101218:	e8 23 4b 00 00       	call   80105d40 <memset>
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
8010124a:	bb 94 2a 11 80       	mov    $0x80112a94,%ebx
{
8010124f:	83 ec 2c             	sub    $0x2c,%esp
  acquire(&icache.lock);
80101252:	c7 04 24 60 2a 11 80 	movl   $0x80112a60,(%esp)
{
80101259:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
8010125c:	e8 ef 49 00 00       	call   80105c50 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101261:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101264:	eb 18                	jmp    8010127e <iget+0x3e>
80101266:	8d 76 00             	lea    0x0(%esi),%esi
80101269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101270:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101276:	81 fb b4 46 11 80    	cmp    $0x801146b4,%ebx
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
80101298:	81 fb b4 46 11 80    	cmp    $0x801146b4,%ebx
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
801012b7:	c7 04 24 60 2a 11 80 	movl   $0x80112a60,(%esp)
801012be:	e8 2d 4a 00 00       	call   80105cf0 <release>

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
801012d8:	c7 04 24 60 2a 11 80 	movl   $0x80112a60,(%esp)
      ip->ref++;
801012df:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801012e2:	e8 09 4a 00 00       	call   80105cf0 <release>
}
801012e7:	83 c4 2c             	add    $0x2c,%esp
801012ea:	89 f0                	mov    %esi,%eax
801012ec:	5b                   	pop    %ebx
801012ed:	5e                   	pop    %esi
801012ee:	5f                   	pop    %edi
801012ef:	5d                   	pop    %ebp
801012f0:	c3                   	ret    
    panic("iget: no inodes");
801012f1:	c7 04 24 35 8a 10 80 	movl   $0x80108a35,(%esp)
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
801013c1:	c7 04 24 45 8a 10 80 	movl   $0x80108a45,(%esp)
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
80101408:	e8 f3 49 00 00       	call   80105e00 <memmove>
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
8010142c:	ba 40 2a 11 80       	mov    $0x80112a40,%edx
80101431:	89 54 24 04          	mov    %edx,0x4(%esp)
80101435:	89 04 24             	mov    %eax,(%esp)
80101438:	e8 93 ff ff ff       	call   801013d0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
8010143d:	8b 0d 58 2a 11 80    	mov    0x80112a58,%ecx
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
80101497:	c7 04 24 58 8a 10 80 	movl   $0x80108a58,(%esp)
8010149e:	e8 cd ee ff ff       	call   80100370 <panic>
801014a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801014a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801014b0 <iinit>:
{
801014b0:	55                   	push   %ebp
  initlock(&icache.lock, "icache");
801014b1:	b9 6b 8a 10 80       	mov    $0x80108a6b,%ecx
{
801014b6:	89 e5                	mov    %esp,%ebp
801014b8:	53                   	push   %ebx
801014b9:	bb a0 2a 11 80       	mov    $0x80112aa0,%ebx
801014be:	83 ec 24             	sub    $0x24,%esp
  initlock(&icache.lock, "icache");
801014c1:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801014c5:	c7 04 24 60 2a 11 80 	movl   $0x80112a60,(%esp)
801014cc:	e8 2f 46 00 00       	call   80105b00 <initlock>
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
801014e0:	ba 72 8a 10 80       	mov    $0x80108a72,%edx
801014e5:	89 1c 24             	mov    %ebx,(%esp)
801014e8:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014ee:	89 54 24 04          	mov    %edx,0x4(%esp)
801014f2:	e8 d9 44 00 00       	call   801059d0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014f7:	81 fb c0 46 11 80    	cmp    $0x801146c0,%ebx
801014fd:	75 e1                	jne    801014e0 <iinit+0x30>
  readsb(dev, &sb);
801014ff:	b8 40 2a 11 80       	mov    $0x80112a40,%eax
80101504:	89 44 24 04          	mov    %eax,0x4(%esp)
80101508:	8b 45 08             	mov    0x8(%ebp),%eax
8010150b:	89 04 24             	mov    %eax,(%esp)
8010150e:	e8 bd fe ff ff       	call   801013d0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101513:	a1 58 2a 11 80       	mov    0x80112a58,%eax
80101518:	c7 04 24 d8 8a 10 80 	movl   $0x80108ad8,(%esp)
8010151f:	89 44 24 1c          	mov    %eax,0x1c(%esp)
80101523:	a1 54 2a 11 80       	mov    0x80112a54,%eax
80101528:	89 44 24 18          	mov    %eax,0x18(%esp)
8010152c:	a1 50 2a 11 80       	mov    0x80112a50,%eax
80101531:	89 44 24 14          	mov    %eax,0x14(%esp)
80101535:	a1 4c 2a 11 80       	mov    0x80112a4c,%eax
8010153a:	89 44 24 10          	mov    %eax,0x10(%esp)
8010153e:	a1 48 2a 11 80       	mov    0x80112a48,%eax
80101543:	89 44 24 0c          	mov    %eax,0xc(%esp)
80101547:	a1 44 2a 11 80       	mov    0x80112a44,%eax
8010154c:	89 44 24 08          	mov    %eax,0x8(%esp)
80101550:	a1 40 2a 11 80       	mov    0x80112a40,%eax
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
8010157d:	83 3d 48 2a 11 80 01 	cmpl   $0x1,0x80112a48
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
801015a9:	39 1d 48 2a 11 80    	cmp    %ebx,0x80112a48
801015af:	76 70                	jbe    80101621 <ialloc+0xb1>
    bp = bread(dev, IBLOCK(inum, sb));
801015b1:	8b 0d 54 2a 11 80    	mov    0x80112a54,%ecx
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
801015f3:	e8 48 47 00 00       	call   80105d40 <memset>
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
80101621:	c7 04 24 78 8a 10 80 	movl   $0x80108a78,(%esp)
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
8010163b:	8b 15 54 2a 11 80    	mov    0x80112a54,%edx
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
801016a2:	e8 59 47 00 00       	call   80105e00 <memmove>
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
801016ca:	c7 04 24 60 2a 11 80 	movl   $0x80112a60,(%esp)
801016d1:	e8 7a 45 00 00       	call   80105c50 <acquire>
  ip->ref++;
801016d6:	ff 43 08             	incl   0x8(%ebx)
  release(&icache.lock);
801016d9:	c7 04 24 60 2a 11 80 	movl   $0x80112a60,(%esp)
801016e0:	e8 0b 46 00 00       	call   80105cf0 <release>
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
80101714:	e8 f7 42 00 00       	call   80105a10 <acquiresleep>
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
80101733:	8b 15 54 2a 11 80    	mov    0x80112a54,%edx
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
80101796:	e8 65 46 00 00       	call   80105e00 <memmove>
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
801017b5:	c7 04 24 90 8a 10 80 	movl   $0x80108a90,(%esp)
801017bc:	e8 af eb ff ff       	call   80100370 <panic>
    panic("ilock");
801017c1:	c7 04 24 8a 8a 10 80 	movl   $0x80108a8a,(%esp)
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
801017e9:	e8 c2 42 00 00       	call   80105ab0 <holdingsleep>
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
80101805:	e9 66 42 00 00       	jmp    80105a70 <releasesleep>
    panic("iunlock");
8010180a:	c7 04 24 9f 8a 10 80 	movl   $0x80108a9f,(%esp)
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
80101838:	e8 d3 41 00 00       	call   80105a10 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
8010183d:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101840:	85 d2                	test   %edx,%edx
80101842:	74 07                	je     8010184b <iput+0x2b>
80101844:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101849:	74 35                	je     80101880 <iput+0x60>
  releasesleep(&ip->lock);
8010184b:	89 3c 24             	mov    %edi,(%esp)
8010184e:	e8 1d 42 00 00       	call   80105a70 <releasesleep>
  acquire(&icache.lock);
80101853:	c7 04 24 60 2a 11 80 	movl   $0x80112a60,(%esp)
8010185a:	e8 f1 43 00 00       	call   80105c50 <acquire>
  ip->ref--;
8010185f:	ff 4b 08             	decl   0x8(%ebx)
  release(&icache.lock);
80101862:	c7 45 08 60 2a 11 80 	movl   $0x80112a60,0x8(%ebp)
}
80101869:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010186c:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010186f:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101872:	89 ec                	mov    %ebp,%esp
80101874:	5d                   	pop    %ebp
  release(&icache.lock);
80101875:	e9 76 44 00 00       	jmp    80105cf0 <release>
8010187a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101880:	c7 04 24 60 2a 11 80 	movl   $0x80112a60,(%esp)
80101887:	e8 c4 43 00 00       	call   80105c50 <acquire>
    int r = ip->ref;
8010188c:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
8010188f:	c7 04 24 60 2a 11 80 	movl   $0x80112a60,(%esp)
80101896:	e8 55 44 00 00       	call   80105cf0 <release>
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
80101a83:	e8 78 43 00 00       	call   80105e00 <memmove>
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
80101aca:	8b 04 c5 e0 29 11 80 	mov    -0x7feed620(,%eax,8),%eax
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
80101baf:	e8 4c 42 00 00       	call   80105e00 <memmove>
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
80101bfa:	8b 04 c5 e4 29 11 80 	mov    -0x7feed61c(,%eax,8),%eax
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
80101c5c:	e8 ff 41 00 00       	call   80105e60 <strncmp>
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
80101cdb:	e8 80 41 00 00       	call   80105e60 <strncmp>
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
80101d1f:	c7 04 24 b9 8a 10 80 	movl   $0x80108ab9,(%esp)
80101d26:	e8 45 e6 ff ff       	call   80100370 <panic>
    panic("dirlookup not DIR");
80101d2b:	c7 04 24 a7 8a 10 80 	movl   $0x80108aa7,(%esp)
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
80101d61:	c7 04 24 60 2a 11 80 	movl   $0x80112a60,(%esp)
80101d68:	e8 e3 3e 00 00       	call   80105c50 <acquire>
  ip->ref++;
80101d6d:	ff 46 08             	incl   0x8(%esi)
  release(&icache.lock);
80101d70:	c7 04 24 60 2a 11 80 	movl   $0x80112a60,(%esp)
80101d77:	e8 74 3f 00 00       	call   80105cf0 <release>
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
80101ddc:	e8 1f 40 00 00       	call   80105e00 <memmove>
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
80101e65:	e8 96 3f 00 00       	call   80105e00 <memmove>
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
80101f73:	e8 48 3f 00 00       	call   80105ec0 <strncpy>
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
80101fb6:	c7 04 24 c8 8a 10 80 	movl   $0x80108ac8,(%esp)
80101fbd:	e8 ae e3 ff ff       	call   80100370 <panic>
    panic("dirlink");
80101fc2:	c7 04 24 4e 91 10 80 	movl   $0x8010914e,(%esp)
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
801020bc:	c7 04 24 34 8b 10 80 	movl   $0x80108b34,(%esp)
801020c3:	e8 a8 e2 ff ff       	call   80100370 <panic>
    panic("idestart");
801020c8:	c7 04 24 2b 8b 10 80 	movl   $0x80108b2b,(%esp)
801020cf:	e8 9c e2 ff ff       	call   80100370 <panic>
801020d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801020da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801020e0 <ideinit>:
{
801020e0:	55                   	push   %ebp
  initlock(&idelock, "ide");
801020e1:	ba 46 8b 10 80       	mov    $0x80108b46,%edx
{
801020e6:	89 e5                	mov    %esp,%ebp
801020e8:	83 ec 18             	sub    $0x18,%esp
  initlock(&idelock, "ide");
801020eb:	89 54 24 04          	mov    %edx,0x4(%esp)
801020ef:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
801020f6:	e8 05 3a 00 00       	call   80105b00 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801020fb:	a1 80 4d 11 80       	mov    0x80114d80,%eax
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
80102176:	e8 d5 3a 00 00       	call   80105c50 <acquire>

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
801021ce:	e8 3d 25 00 00       	call   80104710 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801021d3:	a1 64 c5 10 80       	mov    0x8010c564,%eax
801021d8:	85 c0                	test   %eax,%eax
801021da:	74 05                	je     801021e1 <ideintr+0x81>
    idestart(idequeue);
801021dc:	e8 2f fe ff ff       	call   80102010 <idestart>
    release(&idelock);
801021e1:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
801021e8:	e8 03 3b 00 00       	call   80105cf0 <release>

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
80102210:	e8 9b 38 00 00       	call   80105ab0 <holdingsleep>
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
80102247:	e8 04 3a 00 00       	call   80105c50 <acquire>

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
8010228c:	e8 7f 22 00 00       	call   80104510 <sleep>
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
801022a7:	e9 44 3a 00 00       	jmp    80105cf0 <release>
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
801022c7:	c7 04 24 60 8b 10 80 	movl   $0x80108b60,(%esp)
801022ce:	e8 9d e0 ff ff       	call   80100370 <panic>
    panic("iderw: buf not locked");
801022d3:	c7 04 24 4a 8b 10 80 	movl   $0x80108b4a,(%esp)
801022da:	e8 91 e0 ff ff       	call   80100370 <panic>
    panic("iderw: ide disk 1 not present");
801022df:	c7 04 24 75 8b 10 80 	movl   $0x80108b75,(%esp)
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
80102302:	a3 b4 46 11 80       	mov    %eax,0x801146b4
  ioapic->reg = reg;
80102307:	89 15 00 00 c0 fe    	mov    %edx,0xfec00000
  return ioapic->data;
8010230d:	a1 b4 46 11 80       	mov    0x801146b4,%eax
80102312:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102315:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
8010231b:	8b 0d b4 46 11 80    	mov    0x801146b4,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102321:	0f b6 15 e0 47 11 80 	movzbl 0x801147e0,%edx
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
80102338:	c7 04 24 94 8b 10 80 	movl   $0x80108b94,(%esp)
8010233f:	e8 0c e3 ff ff       	call   80100650 <cprintf>
80102344:	8b 0d b4 46 11 80    	mov    0x801146b4,%ecx
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
80102365:	8b 0d b4 46 11 80    	mov    0x801146b4,%ecx
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
8010237e:	8b 0d b4 46 11 80    	mov    0x801146b4,%ecx
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
801023a1:	8b 0d b4 46 11 80    	mov    0x801146b4,%ecx
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
801023b6:	8b 0d b4 46 11 80    	mov    0x801146b4,%ecx
801023bc:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801023c2:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023c4:	a1 b4 46 11 80       	mov    0x801146b4,%eax
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
801023f6:	81 fb 28 80 11 80    	cmp    $0x80118028,%ebx
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
80102420:	e8 1b 39 00 00       	call   80105d40 <memset>

  if(kmem.use_lock)
80102425:	a1 f4 46 11 80       	mov    0x801146f4,%eax
8010242a:	85 c0                	test   %eax,%eax
8010242c:	75 3a                	jne    80102468 <kfree+0x88>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
8010242e:	a1 f8 46 11 80       	mov    0x801146f8,%eax
80102433:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
80102435:	a1 f4 46 11 80       	mov    0x801146f4,%eax
  kmem.freelist = r;
8010243a:	89 1d f8 46 11 80    	mov    %ebx,0x801146f8
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
80102450:	c7 45 08 c0 46 11 80 	movl   $0x801146c0,0x8(%ebp)
}
80102457:	83 c4 14             	add    $0x14,%esp
8010245a:	5b                   	pop    %ebx
8010245b:	5d                   	pop    %ebp
    release(&kmem.lock);
8010245c:	e9 8f 38 00 00       	jmp    80105cf0 <release>
80102461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&kmem.lock);
80102468:	c7 04 24 c0 46 11 80 	movl   $0x801146c0,(%esp)
8010246f:	e8 dc 37 00 00       	call   80105c50 <acquire>
80102474:	eb b8                	jmp    8010242e <kfree+0x4e>
    panic("kfree");
80102476:	c7 04 24 c6 8b 10 80 	movl   $0x80108bc6,(%esp)
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
801024e1:	b8 cc 8b 10 80       	mov    $0x80108bcc,%eax
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
801024f4:	c7 04 24 c0 46 11 80 	movl   $0x801146c0,(%esp)
801024fb:	e8 00 36 00 00       	call   80105b00 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
80102500:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 0;
80102503:	31 d2                	xor    %edx,%edx
80102505:	89 15 f4 46 11 80    	mov    %edx,0x801146f4
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
8010259d:	a3 f4 46 11 80       	mov    %eax,0x801146f4
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
801025b0:	a1 f4 46 11 80       	mov    0x801146f4,%eax
801025b5:	85 c0                	test   %eax,%eax
801025b7:	75 1f                	jne    801025d8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801025b9:	a1 f8 46 11 80       	mov    0x801146f8,%eax
  if(r)
801025be:	85 c0                	test   %eax,%eax
801025c0:	74 0e                	je     801025d0 <kalloc+0x20>
    kmem.freelist = r->next;
801025c2:	8b 10                	mov    (%eax),%edx
801025c4:	89 15 f8 46 11 80    	mov    %edx,0x801146f8
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
801025de:	c7 04 24 c0 46 11 80 	movl   $0x801146c0,(%esp)
801025e5:	e8 66 36 00 00       	call   80105c50 <acquire>
  r = kmem.freelist;
801025ea:	a1 f8 46 11 80       	mov    0x801146f8,%eax
801025ef:	8b 15 f4 46 11 80    	mov    0x801146f4,%edx
  if(r)
801025f5:	85 c0                	test   %eax,%eax
801025f7:	74 08                	je     80102601 <kalloc+0x51>
    kmem.freelist = r->next;
801025f9:	8b 08                	mov    (%eax),%ecx
801025fb:	89 0d f8 46 11 80    	mov    %ecx,0x801146f8
  if(kmem.use_lock)
80102601:	85 d2                	test   %edx,%edx
80102603:	74 12                	je     80102617 <kalloc+0x67>
    release(&kmem.lock);
80102605:	c7 04 24 c0 46 11 80 	movl   $0x801146c0,(%esp)
8010260c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010260f:	e8 dc 36 00 00       	call   80105cf0 <release>
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
80102664:	0f b6 8a 00 8d 10 80 	movzbl -0x7fef7300(%edx),%ecx
  shift ^= togglecode[data];
8010266b:	0f b6 82 00 8c 10 80 	movzbl -0x7fef7400(%edx),%eax
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
8010267e:	8b 04 85 e0 8b 10 80 	mov    -0x7fef7420(,%eax,4),%eax
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
801026b9:	0f b6 82 00 8d 10 80 	movzbl -0x7fef7300(%edx),%eax
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
80102730:	a1 fc 46 11 80       	mov    0x801146fc,%eax
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
80102830:	a1 fc 46 11 80       	mov    0x801146fc,%eax
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
80102850:	a1 fc 46 11 80       	mov    0x801146fc,%eax
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
801028b1:	a1 fc 46 11 80       	mov    0x801146fc,%eax
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
80102a20:	e8 7b 33 00 00       	call   80105da0 <memcmp>
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
80102ad0:	8b 15 48 47 11 80    	mov    0x80114748,%edx
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
80102af0:	a1 34 47 11 80       	mov    0x80114734,%eax
80102af5:	01 d8                	add    %ebx,%eax
80102af7:	40                   	inc    %eax
80102af8:	89 44 24 04          	mov    %eax,0x4(%esp)
80102afc:	a1 44 47 11 80       	mov    0x80114744,%eax
80102b01:	89 04 24             	mov    %eax,(%esp)
80102b04:	e8 c7 d5 ff ff       	call   801000d0 <bread>
80102b09:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b0b:	8b 04 9d 4c 47 11 80 	mov    -0x7feeb8b4(,%ebx,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
80102b12:	43                   	inc    %ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b13:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b17:	a1 44 47 11 80       	mov    0x80114744,%eax
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
80102b3c:	e8 bf 32 00 00       	call   80105e00 <memmove>
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
80102b59:	39 1d 48 47 11 80    	cmp    %ebx,0x80114748
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
80102b88:	a1 34 47 11 80       	mov    0x80114734,%eax
80102b8d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b91:	a1 44 47 11 80       	mov    0x80114744,%eax
80102b96:	89 04 24             	mov    %eax,(%esp)
80102b99:	e8 32 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b9e:	8b 1d 48 47 11 80    	mov    0x80114748,%ebx
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
80102bc0:	8b 8a 4c 47 11 80    	mov    -0x7feeb8b4(%edx),%ecx
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
80102bf1:	ba 00 8e 10 80       	mov    $0x80108e00,%edx
{
80102bf6:	89 e5                	mov    %esp,%ebp
80102bf8:	53                   	push   %ebx
80102bf9:	83 ec 34             	sub    $0x34,%esp
80102bfc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102bff:	89 54 24 04          	mov    %edx,0x4(%esp)
80102c03:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
80102c0a:	e8 f1 2e 00 00       	call   80105b00 <initlock>
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
80102c27:	89 1d 44 47 11 80    	mov    %ebx,0x80114744
  struct buf *buf = bread(log.dev, log.start);
80102c2d:	89 44 24 04          	mov    %eax,0x4(%esp)
  log.start = sb.logstart;
80102c31:	a3 34 47 11 80       	mov    %eax,0x80114734
  log.size = sb.nlog;
80102c36:	89 15 38 47 11 80    	mov    %edx,0x80114738
  struct buf *buf = bread(log.dev, log.start);
80102c3c:	e8 8f d4 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102c41:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102c44:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102c46:	89 1d 48 47 11 80    	mov    %ebx,0x80114748
  for (i = 0; i < log.lh.n; i++) {
80102c4c:	7e 23                	jle    80102c71 <initlog+0x81>
80102c4e:	c1 e3 02             	shl    $0x2,%ebx
80102c51:	31 d2                	xor    %edx,%edx
80102c53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.lh.block[i] = lh->block[i];
80102c60:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102c64:	83 c2 04             	add    $0x4,%edx
80102c67:	89 8a 48 47 11 80    	mov    %ecx,-0x7feeb8b8(%edx)
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
80102c80:	a3 48 47 11 80       	mov    %eax,0x80114748
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
80102c96:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
80102c9d:	e8 ae 2f 00 00       	call   80105c50 <acquire>
80102ca2:	eb 19                	jmp    80102cbd <begin_op+0x2d>
80102ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102ca8:	b8 00 47 11 80       	mov    $0x80114700,%eax
80102cad:	89 44 24 04          	mov    %eax,0x4(%esp)
80102cb1:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
80102cb8:	e8 53 18 00 00       	call   80104510 <sleep>
    if(log.committing){
80102cbd:	8b 15 40 47 11 80    	mov    0x80114740,%edx
80102cc3:	85 d2                	test   %edx,%edx
80102cc5:	75 e1                	jne    80102ca8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102cc7:	a1 3c 47 11 80       	mov    0x8011473c,%eax
80102ccc:	8b 15 48 47 11 80    	mov    0x80114748,%edx
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
80102cde:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
      log.outstanding += 1;
80102ce5:	a3 3c 47 11 80       	mov    %eax,0x8011473c
      release(&log.lock);
80102cea:	e8 01 30 00 00       	call   80105cf0 <release>
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
80102d09:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
80102d10:	e8 3b 2f 00 00       	call   80105c50 <acquire>
  log.outstanding -= 1;
80102d15:	a1 3c 47 11 80       	mov    0x8011473c,%eax
80102d1a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102d1d:	a1 40 47 11 80       	mov    0x80114740,%eax
  log.outstanding -= 1;
80102d22:	89 1d 3c 47 11 80    	mov    %ebx,0x8011473c
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
80102d3d:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
    log.committing = 1;
80102d44:	89 35 40 47 11 80    	mov    %esi,0x80114740
  release(&log.lock);
80102d4a:	e8 a1 2f 00 00       	call   80105cf0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d4f:	8b 3d 48 47 11 80    	mov    0x80114748,%edi
80102d55:	85 ff                	test   %edi,%edi
80102d57:	0f 8e 88 00 00 00    	jle    80102de5 <end_op+0xe5>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102d5d:	a1 34 47 11 80       	mov    0x80114734,%eax
80102d62:	01 d8                	add    %ebx,%eax
80102d64:	40                   	inc    %eax
80102d65:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d69:	a1 44 47 11 80       	mov    0x80114744,%eax
80102d6e:	89 04 24             	mov    %eax,(%esp)
80102d71:	e8 5a d3 ff ff       	call   801000d0 <bread>
80102d76:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d78:	8b 04 9d 4c 47 11 80 	mov    -0x7feeb8b4(,%ebx,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
80102d7f:	43                   	inc    %ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d80:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d84:	a1 44 47 11 80       	mov    0x80114744,%eax
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
80102da9:	e8 52 30 00 00       	call   80105e00 <memmove>
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
80102dc6:	3b 1d 48 47 11 80    	cmp    0x80114748,%ebx
80102dcc:	7c 8f                	jl     80102d5d <end_op+0x5d>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102dce:	e8 ad fd ff ff       	call   80102b80 <write_head>
    install_trans(); // Now install writes to home locations
80102dd3:	e8 f8 fc ff ff       	call   80102ad0 <install_trans>
    log.lh.n = 0;
80102dd8:	31 d2                	xor    %edx,%edx
80102dda:	89 15 48 47 11 80    	mov    %edx,0x80114748
    write_head();    // Erase the transaction from the log
80102de0:	e8 9b fd ff ff       	call   80102b80 <write_head>
    acquire(&log.lock);
80102de5:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
80102dec:	e8 5f 2e 00 00       	call   80105c50 <acquire>
    log.committing = 0;
80102df1:	31 c0                	xor    %eax,%eax
80102df3:	a3 40 47 11 80       	mov    %eax,0x80114740
    wakeup(&log);
80102df8:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
80102dff:	e8 0c 19 00 00       	call   80104710 <wakeup>
    release(&log.lock);
80102e04:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
80102e0b:	e8 e0 2e 00 00       	call   80105cf0 <release>
}
80102e10:	83 c4 1c             	add    $0x1c,%esp
80102e13:	5b                   	pop    %ebx
80102e14:	5e                   	pop    %esi
80102e15:	5f                   	pop    %edi
80102e16:	5d                   	pop    %ebp
80102e17:	c3                   	ret    
    panic("log.committing");
80102e18:	c7 04 24 04 8e 10 80 	movl   $0x80108e04,(%esp)
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
80102e37:	8b 15 48 47 11 80    	mov    0x80114748,%edx
{
80102e3d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e40:	83 fa 1d             	cmp    $0x1d,%edx
80102e43:	0f 8f 95 00 00 00    	jg     80102ede <log_write+0xae>
80102e49:	a1 38 47 11 80       	mov    0x80114738,%eax
80102e4e:	48                   	dec    %eax
80102e4f:	39 c2                	cmp    %eax,%edx
80102e51:	0f 8d 87 00 00 00    	jge    80102ede <log_write+0xae>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102e57:	a1 3c 47 11 80       	mov    0x8011473c,%eax
80102e5c:	85 c0                	test   %eax,%eax
80102e5e:	0f 8e 86 00 00 00    	jle    80102eea <log_write+0xba>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102e64:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
80102e6b:	e8 e0 2d 00 00       	call   80105c50 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102e70:	8b 0d 48 47 11 80    	mov    0x80114748,%ecx
80102e76:	83 f9 00             	cmp    $0x0,%ecx
80102e79:	7e 55                	jle    80102ed0 <log_write+0xa0>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e7b:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102e7e:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e80:	3b 15 4c 47 11 80    	cmp    0x8011474c,%edx
80102e86:	75 11                	jne    80102e99 <log_write+0x69>
80102e88:	eb 36                	jmp    80102ec0 <log_write+0x90>
80102e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102e90:	39 14 85 4c 47 11 80 	cmp    %edx,-0x7feeb8b4(,%eax,4)
80102e97:	74 27                	je     80102ec0 <log_write+0x90>
  for (i = 0; i < log.lh.n; i++) {
80102e99:	40                   	inc    %eax
80102e9a:	39 c1                	cmp    %eax,%ecx
80102e9c:	75 f2                	jne    80102e90 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102e9e:	89 14 85 4c 47 11 80 	mov    %edx,-0x7feeb8b4(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102ea5:	40                   	inc    %eax
80102ea6:	a3 48 47 11 80       	mov    %eax,0x80114748
  b->flags |= B_DIRTY; // prevent eviction
80102eab:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102eae:	c7 45 08 00 47 11 80 	movl   $0x80114700,0x8(%ebp)
}
80102eb5:	83 c4 14             	add    $0x14,%esp
80102eb8:	5b                   	pop    %ebx
80102eb9:	5d                   	pop    %ebp
  release(&log.lock);
80102eba:	e9 31 2e 00 00       	jmp    80105cf0 <release>
80102ebf:	90                   	nop
  log.lh.block[i] = b->blockno;
80102ec0:	89 14 85 4c 47 11 80 	mov    %edx,-0x7feeb8b4(,%eax,4)
80102ec7:	eb e2                	jmp    80102eab <log_write+0x7b>
80102ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ed0:	8b 43 08             	mov    0x8(%ebx),%eax
80102ed3:	a3 4c 47 11 80       	mov    %eax,0x8011474c
  if (i == log.lh.n)
80102ed8:	75 d1                	jne    80102eab <log_write+0x7b>
80102eda:	31 c0                	xor    %eax,%eax
80102edc:	eb c7                	jmp    80102ea5 <log_write+0x75>
    panic("too big a transaction");
80102ede:	c7 04 24 13 8e 10 80 	movl   $0x80108e13,(%esp)
80102ee5:	e8 86 d4 ff ff       	call   80100370 <panic>
    panic("log_write outside of trans");
80102eea:	c7 04 24 29 8e 10 80 	movl   $0x80108e29,(%esp)
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
80102f07:	e8 44 53 00 00       	call   80108250 <switchkvm>
  seginit();
80102f0c:	e8 af 52 00 00       	call   801081c0 <seginit>
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
80102f22:	c7 04 24 44 8e 10 80 	movl   $0x80108e44,(%esp)
80102f29:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f2d:	e8 1e d7 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80102f32:	e8 c9 41 00 00       	call   80107100 <idtinit>
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
80102f6a:	c7 04 24 94 8e 10 80 	movl   $0x80108e94,(%esp)
80102f71:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f75:	e8 d6 d6 ff ff       	call   80100650 <cprintf>
  scheduler();     // start running processes
80102f7a:	e8 21 12 00 00       	call   801041a0 <scheduler>
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
80102f93:	c7 04 24 28 80 11 80 	movl   $0x80118028,(%esp)
80102f9a:	e8 41 f5 ff ff       	call   801024e0 <kinit1>
  kvmalloc();      // kernel page table
80102f9f:	e8 7c 57 00 00       	call   80108720 <kvmalloc>
  mpinit();        // detect other processors
80102fa4:	e8 17 02 00 00       	call   801031c0 <mpinit>
  lapicinit();     // interrupt controller
80102fa9:	e8 82 f7 ff ff       	call   80102730 <lapicinit>
80102fae:	66 90                	xchg   %ax,%ax
  seginit();       // segment descriptors
80102fb0:	e8 0b 52 00 00       	call   801081c0 <seginit>
  picinit();       // disable pic
80102fb5:	e8 e6 03 00 00       	call   801033a0 <picinit>
  ioapicinit();    // another interrupt controller
80102fba:	e8 31 f3 ff ff       	call   801022f0 <ioapicinit>
80102fbf:	90                   	nop
  consoleinit();   // console hardware
80102fc0:	e8 bb d9 ff ff       	call   80100980 <consoleinit>
  uartinit();      // serial port
80102fc5:	e8 c6 44 00 00       	call   80107490 <uartinit>
  pinit();         // process table
80102fca:	e8 11 09 00 00       	call   801038e0 <pinit>
80102fcf:	90                   	nop
  tvinit();        // trap vectors
80102fd0:	e8 ab 40 00 00       	call   80107080 <tvinit>
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
80102ffe:	e8 fd 2d 00 00       	call   80105e00 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103003:	a1 80 4d 11 80       	mov    0x80114d80,%eax
80103008:	8d 14 80             	lea    (%eax,%eax,4),%edx
8010300b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010300e:	c1 e0 04             	shl    $0x4,%eax
80103011:	05 00 48 11 80       	add    $0x80114800,%eax
80103016:	3d 00 48 11 80       	cmp    $0x80114800,%eax
8010301b:	0f 86 86 00 00 00    	jbe    801030a7 <main+0x127>
80103021:	bb 00 48 11 80       	mov    $0x80114800,%ebx
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
8010308a:	a1 80 4d 11 80       	mov    0x80114d80,%eax
8010308f:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103095:	8d 14 80             	lea    (%eax,%eax,4),%edx
80103098:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010309b:	c1 e0 04             	shl    $0x4,%eax
8010309e:	05 00 48 11 80       	add    $0x80114800,%eax
801030a3:	39 c3                	cmp    %eax,%ebx
801030a5:	72 89                	jb     80103030 <main+0xb0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801030a7:	b8 00 00 00 8e       	mov    $0x8e000000,%eax
801030ac:	89 44 24 04          	mov    %eax,0x4(%esp)
801030b0:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
801030b7:	e8 94 f4 ff ff       	call   80102550 <kinit2>
  initSchedDS(); // initialize the data structures for the processes sceduling policies
801030bc:	e8 af 1e 00 00       	call   80104f70 <initSchedDS>
	__sync_synchronize();
801030c1:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  for(struct cpu *c = cpus; c < cpus + ncpu; ++c) //releases the non-boot AP cpus that are wating at mpmain at main.c
801030c6:	a1 80 4d 11 80       	mov    0x80114d80,%eax
801030cb:	8d 14 80             	lea    (%eax,%eax,4),%edx
801030ce:	8d 0c 50             	lea    (%eax,%edx,2),%ecx
801030d1:	c1 e1 04             	shl    $0x4,%ecx
801030d4:	81 c1 00 48 11 80    	add    $0x80114800,%ecx
801030da:	81 f9 00 48 11 80    	cmp    $0x80114800,%ecx
801030e0:	76 21                	jbe    80103103 <main+0x183>
801030e2:	ba 00 48 11 80       	mov    $0x80114800,%edx
801030e7:	31 db                	xor    %ebx,%ebx
801030e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030f0:	89 d8                	mov    %ebx,%eax
801030f2:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
801030f9:	81 c2 b0 00 00 00    	add    $0xb0,%edx
801030ff:	39 ca                	cmp    %ecx,%edx
80103101:	72 ed                	jb     801030f0 <main+0x170>
  userinit();      // first user process
80103103:	e8 28 0a 00 00       	call   80103b30 <userinit>
  cprintf("\"pioneer\" cpu%d: starting %d\n", cpuid(), cpuid());
80103108:	e8 73 08 00 00       	call   80103980 <cpuid>
8010310d:	89 c3                	mov    %eax,%ebx
8010310f:	e8 6c 08 00 00       	call   80103980 <cpuid>
80103114:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80103118:	c7 04 24 8a 8e 10 80 	movl   $0x80108e8a,(%esp)
8010311f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103123:	e8 28 d5 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80103128:	e8 d3 3f 00 00       	call   80107100 <idtinit>
  scheduler();     // start running processes
8010312d:	e8 6e 10 00 00       	call   801041a0 <scheduler>
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
80103166:	ba a8 8e 10 80       	mov    $0x80108ea8,%edx
8010316b:	b8 04 00 00 00       	mov    $0x4,%eax
80103170:	89 54 24 04          	mov    %edx,0x4(%esp)
80103174:	89 44 24 08          	mov    %eax,0x8(%esp)
80103178:	89 34 24             	mov    %esi,(%esp)
8010317b:	e8 20 2c 00 00       	call   80105da0 <memcmp>
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
80103224:	ba c5 8e 10 80       	mov    $0x80108ec5,%edx
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103229:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
8010322f:	89 44 24 08          	mov    %eax,0x8(%esp)
80103233:	89 54 24 04          	mov    %edx,0x4(%esp)
80103237:	89 34 24             	mov    %esi,(%esp)
8010323a:	e8 61 2b 00 00       	call   80105da0 <memcmp>
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
801032b0:	a3 fc 46 11 80       	mov    %eax,0x801146fc
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
801032cf:	ff 24 85 ec 8e 10 80 	jmp    *-0x7fef7114(,%eax,4)
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
80103318:	8b 1d 80 4d 11 80    	mov    0x80114d80,%ebx
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
80103331:	89 1d 80 4d 11 80    	mov    %ebx,0x80114d80
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103337:	88 87 00 48 11 80    	mov    %al,-0x7feeb800(%edi)
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
8010334f:	a2 e0 47 11 80       	mov    %al,0x801147e0
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
80103380:	c7 04 24 ad 8e 10 80 	movl   $0x80108ead,(%esp)
80103387:	e8 e4 cf ff ff       	call   80100370 <panic>
    panic("Didn't find a suitable machine");
8010338c:	c7 04 24 cc 8e 10 80 	movl   $0x80108ecc,(%esp)
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
80103460:	ba 00 8f 10 80       	mov    $0x80108f00,%edx
  p->nread = 0;
80103465:	89 88 34 02 00 00    	mov    %ecx,0x234(%eax)
  initlock(&p->lock, "pipe");
8010346b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010346f:	89 04 24             	mov    %eax,(%esp)
80103472:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103475:	e8 86 26 00 00       	call   80105b00 <initlock>
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
801034d5:	e8 76 27 00 00       	call   80105c50 <acquire>
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
801034ef:	e8 1c 12 00 00       	call   80104710 <wakeup>
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
80103514:	e9 d7 27 00 00       	jmp    80105cf0 <release>
80103519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->readopen = 0;
80103520:	31 c9                	xor    %ecx,%ecx
    wakeup(&p->nwrite);
80103522:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103528:	89 8b 3c 02 00 00    	mov    %ecx,0x23c(%ebx)
    wakeup(&p->nwrite);
8010352e:	89 04 24             	mov    %eax,(%esp)
80103531:	e8 da 11 00 00       	call   80104710 <wakeup>
80103536:	eb bc                	jmp    801034f4 <pipeclose+0x34>
80103538:	90                   	nop
80103539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103540:	89 1c 24             	mov    %ebx,(%esp)
80103543:	e8 a8 27 00 00       	call   80105cf0 <release>
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
8010356f:	e8 dc 26 00 00       	call   80105c50 <acquire>
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
801035c3:	e8 48 11 00 00       	call   80104710 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035c8:	89 7c 24 04          	mov    %edi,0x4(%esp)
801035cc:	89 1c 24             	mov    %ebx,(%esp)
801035cf:	e8 3c 0f 00 00       	call   80104510 <sleep>
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
80103602:	e8 e9 26 00 00       	call   80105cf0 <release>
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
8010364f:	e8 bc 10 00 00       	call   80104710 <wakeup>
  release(&p->lock);
80103654:	89 3c 24             	mov    %edi,(%esp)
80103657:	e8 94 26 00 00       	call   80105cf0 <release>
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
80103682:	e8 c9 25 00 00       	call   80105c50 <acquire>
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
801036b7:	e8 54 0e 00 00       	call   80104510 <sleep>
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
801036ec:	e8 ff 25 00 00       	call   80105cf0 <release>
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
80103744:	e8 c7 0f 00 00       	call   80104710 <wakeup>
  release(&p->lock);
80103749:	89 34 24             	mov    %esi,(%esp)
8010374c:	e8 9f 25 00 00       	call   80105cf0 <release>
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
80103774:	bb d4 4d 11 80       	mov    $0x80114dd4,%ebx
{
80103779:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);
8010377c:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80103783:	e8 c8 24 00 00       	call   80105c50 <acquire>
80103788:	eb 18                	jmp    801037a2 <allocproc+0x32>
8010378a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103790:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80103796:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
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
801037bb:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
  p->pid = nextpid++;
801037c2:	89 15 04 c0 10 80    	mov    %edx,0x8010c004
  release(&ptable.lock);
801037c8:	e8 23 25 00 00       	call   80105cf0 <release>
  
  acquire(&tickslock);
801037cd:	c7 04 24 e0 77 11 80 	movl   $0x801177e0,(%esp)
801037d4:	e8 77 24 00 00       	call   80105c50 <acquire>
  p->performance.ctime = ticks;
801037d9:	a1 20 80 11 80       	mov    0x80118020,%eax
801037de:	89 83 94 00 00 00    	mov    %eax,0x94(%ebx)
  release(&tickslock);
801037e4:	c7 04 24 e0 77 11 80 	movl   $0x801177e0,(%esp)
801037eb:	e8 00 25 00 00       	call   80105cf0 <release>

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
8010380a:	ba 6f 70 10 80       	mov    $0x8010706f,%edx
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
80103827:	e8 14 25 00 00       	call   80105d40 <memset>
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
80103840:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
  return 0;
80103847:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103849:	e8 a2 24 00 00       	call   80105cf0 <release>
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
80103876:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
8010387d:	e8 6e 24 00 00       	call   80105cf0 <release>

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
801038e1:	b8 05 8f 10 80       	mov    $0x80108f05,%eax
{
801038e6:	89 e5                	mov    %esp,%ebp
801038e8:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
801038eb:	89 44 24 04          	mov    %eax,0x4(%esp)
801038ef:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
801038f6:	e8 05 22 00 00       	call   80105b00 <initlock>
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
80103914:	8b 35 80 4d 11 80    	mov    0x80114d80,%esi
8010391a:	85 f6                	test   %esi,%esi
8010391c:	7e 40                	jle    8010395e <mycpu+0x5e>
    if (cpus[i].apicid == apicid)
8010391e:	0f b6 15 00 48 11 80 	movzbl 0x80114800,%edx
80103925:	39 d0                	cmp    %edx,%eax
80103927:	74 2e                	je     80103957 <mycpu+0x57>
80103929:	b9 b0 48 11 80       	mov    $0x801148b0,%ecx
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
8010394b:	05 00 48 11 80       	add    $0x80114800,%eax
}
80103950:	83 c4 10             	add    $0x10,%esp
80103953:	5b                   	pop    %ebx
80103954:	5e                   	pop    %esi
80103955:	5d                   	pop    %ebp
80103956:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103957:	b8 00 48 11 80       	mov    $0x80114800,%eax
      return &cpus[i];
8010395c:	eb f2                	jmp    80103950 <mycpu+0x50>
  panic("unknown apicid\n");
8010395e:	c7 04 24 0c 8f 10 80 	movl   $0x80108f0c,(%esp)
80103965:	e8 06 ca ff ff       	call   80100370 <panic>
    panic("mycpu called with interrupts enabled\n");
8010396a:	c7 04 24 fc 8f 10 80 	movl   $0x80108ffc,(%esp)
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
8010398c:	2d 00 48 11 80       	sub    $0x80114800,%eax
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
801039a7:	e8 c4 21 00 00       	call   80105b70 <pushcli>
  c = mycpu();
801039ac:	e8 4f ff ff ff       	call   80103900 <mycpu>
  p = c->proc;
801039b1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039b7:	e8 f4 21 00 00       	call   80105bb0 <popcli>
}
801039bc:	5a                   	pop    %edx
801039bd:	89 d8                	mov    %ebx,%eax
801039bf:	5b                   	pop    %ebx
801039c0:	5d                   	pop    %ebp
801039c1:	c3                   	ret    
801039c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801039d0 <growproc>:
{
801039d0:	55                   	push   %ebp
801039d1:	89 e5                	mov    %esp,%ebp
801039d3:	56                   	push   %esi
801039d4:	53                   	push   %ebx
801039d5:	83 ec 10             	sub    $0x10,%esp
801039d8:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801039db:	e8 90 21 00 00       	call   80105b70 <pushcli>
  c = mycpu();
801039e0:	e8 1b ff ff ff       	call   80103900 <mycpu>
  p = c->proc;
801039e5:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039eb:	e8 c0 21 00 00       	call   80105bb0 <popcli>
  if(n > 0){
801039f0:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
801039f3:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
801039f5:	7f 19                	jg     80103a10 <growproc+0x40>
  } else if(n < 0){
801039f7:	75 37                	jne    80103a30 <growproc+0x60>
  curproc->sz = sz;
801039f9:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801039fb:	89 1c 24             	mov    %ebx,(%esp)
801039fe:	e8 6d 48 00 00       	call   80108270 <switchuvm>
  return 0;
80103a03:	31 c0                	xor    %eax,%eax
}
80103a05:	83 c4 10             	add    $0x10,%esp
80103a08:	5b                   	pop    %ebx
80103a09:	5e                   	pop    %esi
80103a0a:	5d                   	pop    %ebp
80103a0b:	c3                   	ret    
80103a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a10:	01 c6                	add    %eax,%esi
80103a12:	89 74 24 08          	mov    %esi,0x8(%esp)
80103a16:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a1a:	8b 43 04             	mov    0x4(%ebx),%eax
80103a1d:	89 04 24             	mov    %eax,(%esp)
80103a20:	e8 9b 4a 00 00       	call   801084c0 <allocuvm>
80103a25:	85 c0                	test   %eax,%eax
80103a27:	75 d0                	jne    801039f9 <growproc+0x29>
      return -1;
80103a29:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a2e:	eb d5                	jmp    80103a05 <growproc+0x35>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a30:	01 c6                	add    %eax,%esi
80103a32:	89 74 24 08          	mov    %esi,0x8(%esp)
80103a36:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a3a:	8b 43 04             	mov    0x4(%ebx),%eax
80103a3d:	89 04 24             	mov    %eax,(%esp)
80103a40:	e8 ab 4b 00 00       	call   801085f0 <deallocuvm>
80103a45:	85 c0                	test   %eax,%eax
80103a47:	75 b0                	jne    801039f9 <growproc+0x29>
80103a49:	eb de                	jmp    80103a29 <growproc+0x59>
80103a4b:	90                   	nop
80103a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103a50 <setAccumulator>:
void setAccumulator(struct proc *p){
80103a50:	55                   	push   %ebp
80103a51:	89 e5                	mov    %esp,%ebp
80103a53:	83 ec 28             	sub    $0x28,%esp
  if (pq.getMinAccumulator(&acc1)){
80103a56:	8d 45 e8             	lea    -0x18(%ebp),%eax
void setAccumulator(struct proc *p){
80103a59:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80103a5c:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103a5f:	89 75 fc             	mov    %esi,-0x4(%ebp)
  if (pq.getMinAccumulator(&acc1)){
80103a62:	89 04 24             	mov    %eax,(%esp)
80103a65:	ff 15 f4 c5 10 80    	call   *0x8010c5f4
80103a6b:	85 c0                	test   %eax,%eax
      if (rpholder.getMinAccumulator(&acc2)){
80103a6d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80103a70:	89 04 24             	mov    %eax,(%esp)
  if (pq.getMinAccumulator(&acc1)){
80103a73:	74 3b                	je     80103ab0 <setAccumulator+0x60>
      if (rpholder.getMinAccumulator(&acc2)){
80103a75:	ff 15 d8 c5 10 80    	call   *0x8010c5d8
80103a7b:	85 c0                	test   %eax,%eax
80103a7d:	74 79                	je     80103af8 <setAccumulator+0xa8>
            if (acc1<acc2){
80103a7f:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103a82:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a85:	8b 75 e8             	mov    -0x18(%ebp),%esi
80103a88:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80103a8b:	39 c2                	cmp    %eax,%edx
80103a8d:	7f 0a                	jg     80103a99 <setAccumulator+0x49>
80103a8f:	0f 8c 83 00 00 00    	jl     80103b18 <setAccumulator+0xc8>
80103a95:	39 ce                	cmp    %ecx,%esi
80103a97:	72 7f                	jb     80103b18 <setAccumulator+0xc8>
                   p->accumulator = acc2;
80103a99:	89 8b 84 00 00 00    	mov    %ecx,0x84(%ebx)
80103a9f:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
}
80103aa5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103aa8:	8b 75 fc             	mov    -0x4(%ebp),%esi
80103aab:	89 ec                	mov    %ebp,%esp
80103aad:	5d                   	pop    %ebp
80103aae:	c3                   	ret    
80103aaf:	90                   	nop
  else if (rpholder.getMinAccumulator(&acc2)){
80103ab0:	ff 15 d8 c5 10 80    	call   *0x8010c5d8
80103ab6:	85 c0                	test   %eax,%eax
80103ab8:	75 1e                	jne    80103ad8 <setAccumulator+0x88>
       p->accumulator = 0;
80103aba:	31 c0                	xor    %eax,%eax
80103abc:	31 d2                	xor    %edx,%edx
80103abe:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)
80103ac4:	89 93 88 00 00 00    	mov    %edx,0x88(%ebx)
}
80103aca:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103acd:	8b 75 fc             	mov    -0x4(%ebp),%esi
80103ad0:	89 ec                	mov    %ebp,%esp
80103ad2:	5d                   	pop    %ebp
80103ad3:	c3                   	ret    
80103ad4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->accumulator = acc2;
80103ad8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103adb:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103ade:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)
80103ae4:	89 93 88 00 00 00    	mov    %edx,0x88(%ebx)
}
80103aea:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103aed:	8b 75 fc             	mov    -0x4(%ebp),%esi
80103af0:	89 ec                	mov    %ebp,%esp
80103af2:	5d                   	pop    %ebp
80103af3:	c3                   	ret    
80103af4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
             p->accumulator = acc1;
80103af8:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103afb:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103afe:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)
80103b04:	89 93 88 00 00 00    	mov    %edx,0x88(%ebx)
}
80103b0a:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103b0d:	8b 75 fc             	mov    -0x4(%ebp),%esi
80103b10:	89 ec                	mov    %ebp,%esp
80103b12:	5d                   	pop    %ebp
80103b13:	c3                   	ret    
80103b14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                   p->accumulator = acc1;
80103b18:	89 b3 84 00 00 00    	mov    %esi,0x84(%ebx)
80103b1e:	89 93 88 00 00 00    	mov    %edx,0x88(%ebx)
}
80103b24:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103b27:	8b 75 fc             	mov    -0x4(%ebp),%esi
80103b2a:	89 ec                	mov    %ebp,%esp
80103b2c:	5d                   	pop    %ebp
80103b2d:	c3                   	ret    
80103b2e:	66 90                	xchg   %ax,%ax

80103b30 <userinit>:
{
80103b30:	55                   	push   %ebp
80103b31:	89 e5                	mov    %esp,%ebp
80103b33:	53                   	push   %ebx
80103b34:	83 ec 14             	sub    $0x14,%esp
  p = allocproc();
80103b37:	e8 34 fc ff ff       	call   80103770 <allocproc>
80103b3c:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103b3e:	a3 c8 c5 10 80       	mov    %eax,0x8010c5c8
  if((p->pgdir = setupkvm()) == 0)
80103b43:	e8 58 4b 00 00       	call   801086a0 <setupkvm>
80103b48:	85 c0                	test   %eax,%eax
80103b4a:	89 43 04             	mov    %eax,0x4(%ebx)
80103b4d:	0f 84 15 01 00 00    	je     80103c68 <userinit+0x138>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103b53:	b9 60 c4 10 80       	mov    $0x8010c460,%ecx
80103b58:	ba 2c 00 00 00       	mov    $0x2c,%edx
80103b5d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80103b61:	89 54 24 08          	mov    %edx,0x8(%esp)
80103b65:	89 04 24             	mov    %eax,(%esp)
80103b68:	e8 03 48 00 00       	call   80108370 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103b6d:	b8 4c 00 00 00       	mov    $0x4c,%eax
  p->sz = PGSIZE;
80103b72:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103b78:	89 44 24 08          	mov    %eax,0x8(%esp)
80103b7c:	31 c0                	xor    %eax,%eax
80103b7e:	89 44 24 04          	mov    %eax,0x4(%esp)
80103b82:	8b 43 18             	mov    0x18(%ebx),%eax
80103b85:	89 04 24             	mov    %eax,(%esp)
80103b88:	e8 b3 21 00 00       	call   80105d40 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103b8d:	8b 43 18             	mov    0x18(%ebx),%eax
80103b90:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103b96:	8b 43 18             	mov    0x18(%ebx),%eax
80103b99:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103b9f:	8b 43 18             	mov    0x18(%ebx),%eax
80103ba2:	8b 50 2c             	mov    0x2c(%eax),%edx
80103ba5:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103ba9:	8b 43 18             	mov    0x18(%ebx),%eax
80103bac:	8b 50 2c             	mov    0x2c(%eax),%edx
80103baf:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103bb3:	8b 43 18             	mov    0x18(%ebx),%eax
80103bb6:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103bbd:	8b 43 18             	mov    0x18(%ebx),%eax
80103bc0:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103bc7:	8b 43 18             	mov    0x18(%ebx),%eax
80103bca:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103bd1:	b8 10 00 00 00       	mov    $0x10,%eax
80103bd6:	89 44 24 08          	mov    %eax,0x8(%esp)
80103bda:	b8 35 8f 10 80       	mov    $0x80108f35,%eax
80103bdf:	89 44 24 04          	mov    %eax,0x4(%esp)
80103be3:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103be6:	89 04 24             	mov    %eax,(%esp)
80103be9:	e8 32 23 00 00       	call   80105f20 <safestrcpy>
  p->cwd = namei("/");
80103bee:	c7 04 24 3e 8f 10 80 	movl   $0x80108f3e,(%esp)
80103bf5:	e8 d6 e3 ff ff       	call   80101fd0 <namei>
80103bfa:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103bfd:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80103c04:	e8 47 20 00 00       	call   80105c50 <acquire>
  p->timeStamp = tqCounter;
80103c09:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
80103c0e:	8b 15 c4 c5 10 80    	mov    0x8010c5c4,%edx
  if(POLICY == 1)
80103c14:	83 3d 08 c0 10 80 01 	cmpl   $0x1,0x8010c008
  p->state = RUNNABLE;
80103c1b:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  p->timeStamp = tqCounter;
80103c22:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
80103c28:	89 93 90 00 00 00    	mov    %edx,0x90(%ebx)
      rrq.enqueue(p);
80103c2e:	89 1c 24             	mov    %ebx,(%esp)
  if(POLICY == 1)
80103c31:	74 2d                	je     80103c60 <userinit+0x130>
      pq.put(p);
80103c33:	ff 15 f0 c5 10 80    	call   *0x8010c5f0
  p->priority = 5; // Set the priority of new process to 5
80103c39:	b8 05 00 00 00       	mov    $0x5,%eax
80103c3e:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
  setAccumulator(p); 
80103c44:	89 1c 24             	mov    %ebx,(%esp)
80103c47:	e8 04 fe ff ff       	call   80103a50 <setAccumulator>
  release(&ptable.lock);
80103c4c:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80103c53:	e8 98 20 00 00       	call   80105cf0 <release>
}
80103c58:	83 c4 14             	add    $0x14,%esp
80103c5b:	5b                   	pop    %ebx
80103c5c:	5d                   	pop    %ebp
80103c5d:	c3                   	ret    
80103c5e:	66 90                	xchg   %ax,%ax
      rrq.enqueue(p);
80103c60:	ff 15 e0 c5 10 80    	call   *0x8010c5e0
80103c66:	eb d1                	jmp    80103c39 <userinit+0x109>
    panic("userinit: out of memory?");
80103c68:	c7 04 24 1c 8f 10 80 	movl   $0x80108f1c,(%esp)
80103c6f:	e8 fc c6 ff ff       	call   80100370 <panic>
80103c74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103c7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103c80 <fork>:
{
80103c80:	55                   	push   %ebp
80103c81:	89 e5                	mov    %esp,%ebp
80103c83:	57                   	push   %edi
80103c84:	56                   	push   %esi
80103c85:	53                   	push   %ebx
80103c86:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103c89:	e8 e2 1e 00 00       	call   80105b70 <pushcli>
  c = mycpu();
80103c8e:	e8 6d fc ff ff       	call   80103900 <mycpu>
  p = c->proc;
80103c93:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
80103c99:	e8 12 1f 00 00       	call   80105bb0 <popcli>
  if((np = allocproc()) == 0){
80103c9e:	e8 cd fa ff ff       	call   80103770 <allocproc>
80103ca3:	85 c0                	test   %eax,%eax
80103ca5:	0f 84 1d 01 00 00    	je     80103dc8 <fork+0x148>
80103cab:	89 c6                	mov    %eax,%esi
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103cad:	8b 07                	mov    (%edi),%eax
80103caf:	89 44 24 04          	mov    %eax,0x4(%esp)
80103cb3:	8b 47 04             	mov    0x4(%edi),%eax
80103cb6:	89 04 24             	mov    %eax,(%esp)
80103cb9:	e8 b2 4a 00 00       	call   80108770 <copyuvm>
80103cbe:	85 c0                	test   %eax,%eax
80103cc0:	89 46 04             	mov    %eax,0x4(%esi)
80103cc3:	0f 84 09 01 00 00    	je     80103dd2 <fork+0x152>
  np->sz = curproc->sz;
80103cc9:	8b 07                	mov    (%edi),%eax
  np->parent = curproc;
80103ccb:	89 7e 14             	mov    %edi,0x14(%esi)
  *np->tf = *curproc->tf;
80103cce:	8b 56 18             	mov    0x18(%esi),%edx
  np->sz = curproc->sz;
80103cd1:	89 06                	mov    %eax,(%esi)
  *np->tf = *curproc->tf;
80103cd3:	31 c0                	xor    %eax,%eax
80103cd5:	8b 4f 18             	mov    0x18(%edi),%ecx
80103cd8:	8b 1c 01             	mov    (%ecx,%eax,1),%ebx
80103cdb:	89 1c 02             	mov    %ebx,(%edx,%eax,1)
80103cde:	83 c0 04             	add    $0x4,%eax
80103ce1:	83 f8 4c             	cmp    $0x4c,%eax
80103ce4:	72 f2                	jb     80103cd8 <fork+0x58>
  np->tf->eax = 0;
80103ce6:	8b 46 18             	mov    0x18(%esi),%eax
  for(i = 0; i < NOFILE; i++)
80103ce9:	31 db                	xor    %ebx,%ebx
  np->tf->eax = 0;
80103ceb:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103cf2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(curproc->ofile[i])
80103d00:	8b 44 9f 28          	mov    0x28(%edi,%ebx,4),%eax
80103d04:	85 c0                	test   %eax,%eax
80103d06:	74 0c                	je     80103d14 <fork+0x94>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103d08:	89 04 24             	mov    %eax,(%esp)
80103d0b:	e8 d0 d0 ff ff       	call   80100de0 <filedup>
80103d10:	89 44 9e 28          	mov    %eax,0x28(%esi,%ebx,4)
  for(i = 0; i < NOFILE; i++)
80103d14:	43                   	inc    %ebx
80103d15:	83 fb 10             	cmp    $0x10,%ebx
80103d18:	75 e6                	jne    80103d00 <fork+0x80>
  np->cwd = idup(curproc->cwd);
80103d1a:	8b 47 68             	mov    0x68(%edi),%eax
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d1d:	83 c7 6c             	add    $0x6c,%edi
  np->cwd = idup(curproc->cwd);
80103d20:	89 04 24             	mov    %eax,(%esp)
80103d23:	e8 98 d9 ff ff       	call   801016c0 <idup>
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d28:	ba 10 00 00 00       	mov    $0x10,%edx
  np->cwd = idup(curproc->cwd);
80103d2d:	89 46 68             	mov    %eax,0x68(%esi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d30:	8d 46 6c             	lea    0x6c(%esi),%eax
80103d33:	89 54 24 08          	mov    %edx,0x8(%esp)
80103d37:	89 7c 24 04          	mov    %edi,0x4(%esp)
80103d3b:	89 04 24             	mov    %eax,(%esp)
80103d3e:	e8 dd 21 00 00       	call   80105f20 <safestrcpy>
  pid = np->pid;
80103d43:	8b 5e 10             	mov    0x10(%esi),%ebx
  acquire(&ptable.lock);
80103d46:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80103d4d:	e8 fe 1e 00 00       	call   80105c50 <acquire>
  if(np->state == RUNNING)
80103d52:	8b 46 0c             	mov    0xc(%esi),%eax
80103d55:	83 f8 04             	cmp    $0x4,%eax
80103d58:	75 09                	jne    80103d63 <fork+0xe3>
      rpholder.remove(np);
80103d5a:	89 34 24             	mov    %esi,(%esp)
80103d5d:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
  np->timeStamp = tqCounter;
80103d63:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
80103d68:	8b 15 c4 c5 10 80    	mov    0x8010c5c4,%edx
  if(POLICY == 1)
80103d6e:	83 3d 08 c0 10 80 01 	cmpl   $0x1,0x8010c008
  np->state = RUNNABLE;
80103d75:	c7 46 0c 03 00 00 00 	movl   $0x3,0xc(%esi)
  np->timeStamp = tqCounter;
80103d7c:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80103d82:	89 96 90 00 00 00    	mov    %edx,0x90(%esi)
      rrq.enqueue(np);
80103d88:	89 34 24             	mov    %esi,(%esp)
  if(POLICY == 1)
80103d8b:	74 33                	je     80103dc0 <fork+0x140>
      pq.put(np);
80103d8d:	ff 15 f0 c5 10 80    	call   *0x8010c5f0
  np->priority = 5; // Set the priority of new process to 5
80103d93:	b8 05 00 00 00       	mov    $0x5,%eax
80103d98:	89 86 80 00 00 00    	mov    %eax,0x80(%esi)
  setAccumulator(np);
80103d9e:	89 34 24             	mov    %esi,(%esp)
80103da1:	e8 aa fc ff ff       	call   80103a50 <setAccumulator>
  release(&ptable.lock);
80103da6:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80103dad:	e8 3e 1f 00 00       	call   80105cf0 <release>
}
80103db2:	83 c4 1c             	add    $0x1c,%esp
80103db5:	89 d8                	mov    %ebx,%eax
80103db7:	5b                   	pop    %ebx
80103db8:	5e                   	pop    %esi
80103db9:	5f                   	pop    %edi
80103dba:	5d                   	pop    %ebp
80103dbb:	c3                   	ret    
80103dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      rrq.enqueue(np);
80103dc0:	ff 15 e0 c5 10 80    	call   *0x8010c5e0
80103dc6:	eb cb                	jmp    80103d93 <fork+0x113>
    return -1;
80103dc8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103dcd:	8d 76 00             	lea    0x0(%esi),%esi
80103dd0:	eb e0                	jmp    80103db2 <fork+0x132>
    kfree(np->kstack);
80103dd2:	8b 46 08             	mov    0x8(%esi),%eax
    return -1;
80103dd5:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    kfree(np->kstack);
80103dda:	89 04 24             	mov    %eax,(%esp)
80103ddd:	e8 fe e5 ff ff       	call   801023e0 <kfree>
    np->kstack = 0;
80103de2:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
    np->state = UNUSED;
80103de9:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    return -1;
80103df0:	eb c0                	jmp    80103db2 <fork+0x132>
80103df2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e00 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80103e00:	55                   	push   %ebp
80103e01:	89 e5                	mov    %esp,%ebp
80103e03:	56                   	push   %esi
80103e04:	89 c6                	mov    %eax,%esi
80103e06:	53                   	push   %ebx
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e07:	bb d4 4d 11 80       	mov    $0x80114dd4,%ebx
{
80103e0c:	83 ec 10             	sub    $0x10,%esp
80103e0f:	eb 15                	jmp    80103e26 <wakeup1+0x26>
80103e11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e18:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80103e1e:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
80103e24:	73 53                	jae    80103e79 <wakeup1+0x79>
    if(p->state == SLEEPING && p->chan == chan){ 
80103e26:	8b 43 0c             	mov    0xc(%ebx),%eax
80103e29:	83 f8 02             	cmp    $0x2,%eax
80103e2c:	75 ea                	jne    80103e18 <wakeup1+0x18>
80103e2e:	39 73 20             	cmp    %esi,0x20(%ebx)
80103e31:	75 e5                	jne    80103e18 <wakeup1+0x18>
      p->state = RUNNABLE;
      p->timeStamp = tqCounter;
80103e33:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
80103e38:	8b 15 c4 c5 10 80    	mov    0x8010c5c4,%edx
      setAccumulator(p);  
80103e3e:	89 1c 24             	mov    %ebx,(%esp)
      p->state = RUNNABLE;
80103e41:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
      p->timeStamp = tqCounter;
80103e48:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
80103e4e:	89 93 90 00 00 00    	mov    %edx,0x90(%ebx)
      setAccumulator(p);  
80103e54:	e8 f7 fb ff ff       	call   80103a50 <setAccumulator>
      if(POLICY == 1)
80103e59:	83 3d 08 c0 10 80 01 	cmpl   $0x1,0x8010c008
        rrq.enqueue(p);
80103e60:	89 1c 24             	mov    %ebx,(%esp)
      if(POLICY == 1)
80103e63:	74 1b                	je     80103e80 <wakeup1+0x80>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e65:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
      else
        pq.put(p);
80103e6b:	ff 15 f0 c5 10 80    	call   *0x8010c5f0
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e71:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
80103e77:	72 ad                	jb     80103e26 <wakeup1+0x26>
    }
}
80103e79:	83 c4 10             	add    $0x10,%esp
80103e7c:	5b                   	pop    %ebx
80103e7d:	5e                   	pop    %esi
80103e7e:	5d                   	pop    %ebp
80103e7f:	c3                   	ret    
        rrq.enqueue(p);
80103e80:	ff 15 e0 c5 10 80    	call   *0x8010c5e0
80103e86:	eb 90                	jmp    80103e18 <wakeup1+0x18>
80103e88:	90                   	nop
80103e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103e90 <originalScheduler>:
{
80103e90:	55                   	push   %ebp
80103e91:	89 e5                	mov    %esp,%ebp
80103e93:	57                   	push   %edi
80103e94:	56                   	push   %esi
80103e95:	53                   	push   %ebx
80103e96:	83 ec 1c             	sub    $0x1c,%esp
80103e99:	8b 7d 0c             	mov    0xc(%ebp),%edi
  asm volatile("sti");
80103e9c:	fb                   	sti    
    acquire(&ptable.lock);
80103e9d:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ea4:	bb d4 4d 11 80       	mov    $0x80114dd4,%ebx
    acquire(&ptable.lock);
80103ea9:	e8 a2 1d 00 00       	call   80105c50 <acquire>
      swtch(&(c->scheduler), p->context);
80103eae:	8d 77 04             	lea    0x4(%edi),%esi
80103eb1:	eb 0d                	jmp    80103ec0 <originalScheduler+0x30>
80103eb3:	90                   	nop
80103eb4:	90                   	nop
80103eb5:	90                   	nop
80103eb6:	90                   	nop
80103eb7:	90                   	nop
80103eb8:	90                   	nop
80103eb9:	90                   	nop
80103eba:	90                   	nop
80103ebb:	90                   	nop
80103ebc:	90                   	nop
80103ebd:	90                   	nop
80103ebe:	90                   	nop
80103ebf:	90                   	nop
      if(p->state != RUNNABLE)
80103ec0:	8b 43 0c             	mov    0xc(%ebx),%eax
80103ec3:	83 f8 03             	cmp    $0x3,%eax
80103ec6:	75 31                	jne    80103ef9 <originalScheduler+0x69>
      c->proc = p;
80103ec8:	89 9f ac 00 00 00    	mov    %ebx,0xac(%edi)
      switchuvm(p);
80103ece:	89 1c 24             	mov    %ebx,(%esp)
80103ed1:	e8 9a 43 00 00       	call   80108270 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103ed6:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103ed9:	89 34 24             	mov    %esi,(%esp)
      p->state = RUNNING;
80103edc:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103ee3:	89 44 24 04          	mov    %eax,0x4(%esp)
80103ee7:	e8 8d 20 00 00       	call   80105f79 <swtch>
      switchkvm();
80103eec:	e8 5f 43 00 00       	call   80108250 <switchkvm>
      c->proc = 0;
80103ef1:	31 c0                	xor    %eax,%eax
80103ef3:	89 87 ac 00 00 00    	mov    %eax,0xac(%edi)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ef9:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80103eff:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
80103f05:	72 b9                	jb     80103ec0 <originalScheduler+0x30>
    release(&ptable.lock);
80103f07:	c7 45 08 a0 4d 11 80 	movl   $0x80114da0,0x8(%ebp)
}
80103f0e:	83 c4 1c             	add    $0x1c,%esp
80103f11:	5b                   	pop    %ebx
80103f12:	5e                   	pop    %esi
80103f13:	5f                   	pop    %edi
80103f14:	5d                   	pop    %ebp
    release(&ptable.lock);
80103f15:	e9 d6 1d 00 00       	jmp    80105cf0 <release>
80103f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103f20 <roundRobinScheduler>:
{
80103f20:	55                   	push   %ebp
80103f21:	89 e5                	mov    %esp,%ebp
80103f23:	56                   	push   %esi
80103f24:	53                   	push   %ebx
80103f25:	83 ec 10             	sub    $0x10,%esp
80103f28:	8b 75 0c             	mov    0xc(%ebp),%esi
80103f2b:	fb                   	sti    
    acquire(&ptable.lock);
80103f2c:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80103f33:	e8 18 1d 00 00       	call   80105c50 <acquire>
    if(!rrq.isEmpty()){
80103f38:	ff 15 dc c5 10 80    	call   *0x8010c5dc
80103f3e:	85 c0                	test   %eax,%eax
80103f40:	75 4e                	jne    80103f90 <roundRobinScheduler+0x70>
            p = rrq.dequeue();
80103f42:	ff 15 e4 c5 10 80    	call   *0x8010c5e4
80103f48:	89 c3                	mov    %eax,%ebx
            c->proc = p;
80103f4a:	89 86 ac 00 00 00    	mov    %eax,0xac(%esi)
            switchuvm(p);
80103f50:	89 04 24             	mov    %eax,(%esp)
80103f53:	e8 18 43 00 00       	call   80108270 <switchuvm>
            swtch(&(c->scheduler), p->context);
80103f58:	8b 43 1c             	mov    0x1c(%ebx),%eax
            p->state = RUNNING;
80103f5b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
            swtch(&(c->scheduler), p->context);
80103f62:	89 44 24 04          	mov    %eax,0x4(%esp)
80103f66:	8d 46 04             	lea    0x4(%esi),%eax
80103f69:	89 04 24             	mov    %eax,(%esp)
80103f6c:	e8 08 20 00 00       	call   80105f79 <swtch>
            switchkvm();
80103f71:	e8 da 42 00 00       	call   80108250 <switchkvm>
            rpholder.remove(p);
80103f76:	89 1c 24             	mov    %ebx,(%esp)
80103f79:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
            rpholder.add(p);
80103f7f:	89 1c 24             	mov    %ebx,(%esp)
80103f82:	ff 15 d0 c5 10 80    	call   *0x8010c5d0
            c->proc = 0;
80103f88:	31 c0                	xor    %eax,%eax
80103f8a:	89 86 ac 00 00 00    	mov    %eax,0xac(%esi)
    release(&ptable.lock);
80103f90:	c7 45 08 a0 4d 11 80 	movl   $0x80114da0,0x8(%ebp)
}
80103f97:	83 c4 10             	add    $0x10,%esp
80103f9a:	5b                   	pop    %ebx
80103f9b:	5e                   	pop    %esi
80103f9c:	5d                   	pop    %ebp
    release(&ptable.lock);
80103f9d:	e9 4e 1d 00 00       	jmp    80105cf0 <release>
80103fa2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103fb0 <priorityScheduler>:
{
80103fb0:	55                   	push   %ebp
80103fb1:	89 e5                	mov    %esp,%ebp
80103fb3:	56                   	push   %esi
80103fb4:	53                   	push   %ebx
80103fb5:	83 ec 10             	sub    $0x10,%esp
80103fb8:	8b 75 0c             	mov    0xc(%ebp),%esi
80103fbb:	fb                   	sti    
    acquire(&ptable.lock);
80103fbc:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80103fc3:	e8 88 1c 00 00       	call   80105c50 <acquire>
    if(!pq.isEmpty()){
80103fc8:	ff 15 ec c5 10 80    	call   *0x8010c5ec
80103fce:	85 c0                	test   %eax,%eax
80103fd0:	75 4e                	jne    80104020 <priorityScheduler+0x70>
        p = pq.extractMin();
80103fd2:	ff 15 f8 c5 10 80    	call   *0x8010c5f8
80103fd8:	89 c3                	mov    %eax,%ebx
        c->proc = p;
80103fda:	89 86 ac 00 00 00    	mov    %eax,0xac(%esi)
        switchuvm(p);
80103fe0:	89 04 24             	mov    %eax,(%esp)
80103fe3:	e8 88 42 00 00       	call   80108270 <switchuvm>
        p->state = RUNNING; 
80103fe8:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
        rpholder.remove(p);
80103fef:	89 1c 24             	mov    %ebx,(%esp)
80103ff2:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
        rpholder.add(p);
80103ff8:	89 1c 24             	mov    %ebx,(%esp)
80103ffb:	ff 15 d0 c5 10 80    	call   *0x8010c5d0
        swtch(&(c->scheduler), p->context);
80104001:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104004:	89 44 24 04          	mov    %eax,0x4(%esp)
80104008:	8d 46 04             	lea    0x4(%esi),%eax
8010400b:	89 04 24             	mov    %eax,(%esp)
8010400e:	e8 66 1f 00 00       	call   80105f79 <swtch>
        switchkvm();
80104013:	e8 38 42 00 00       	call   80108250 <switchkvm>
        c->proc = 0;
80104018:	31 c0                	xor    %eax,%eax
8010401a:	89 86 ac 00 00 00    	mov    %eax,0xac(%esi)
    release(&ptable.lock);
80104020:	c7 45 08 a0 4d 11 80 	movl   $0x80114da0,0x8(%ebp)
}
80104027:	83 c4 10             	add    $0x10,%esp
8010402a:	5b                   	pop    %ebx
8010402b:	5e                   	pop    %esi
8010402c:	5d                   	pop    %ebp
    release(&ptable.lock);
8010402d:	e9 be 1c 00 00       	jmp    80105cf0 <release>
80104032:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104040 <extendedPriorityScheduler>:
{
80104040:	55                   	push   %ebp
80104041:	89 e5                	mov    %esp,%ebp
80104043:	57                   	push   %edi
80104044:	56                   	push   %esi
80104045:	53                   	push   %ebx
80104046:	83 ec 2c             	sub    $0x2c,%esp
80104049:	8b 45 0c             	mov    0xc(%ebp),%eax
8010404c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010404f:	89 45 e0             	mov    %eax,-0x20(%ebp)
80104052:	fb                   	sti    
    acquire(&ptable.lock);
80104053:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
8010405a:	e8 f1 1b 00 00       	call   80105c50 <acquire>
    if(!pq.isEmpty()){
8010405f:	ff 15 ec c5 10 80    	call   *0x8010c5ec
80104065:	85 c0                	test   %eax,%eax
80104067:	75 5b                	jne    801040c4 <extendedPriorityScheduler+0x84>
            if(avoidStarv){
80104069:	8b 3d b8 c5 10 80    	mov    0x8010c5b8,%edi
8010406f:	85 ff                	test   %edi,%edi
80104071:	75 6d                	jne    801040e0 <extendedPriorityScheduler+0xa0>
                    np = pq.extractMin();
80104073:	ff 15 f8 c5 10 80    	call   *0x8010c5f8
80104079:	89 c3                	mov    %eax,%ebx
            c->proc = np;
8010407b:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010407e:	89 9f ac 00 00 00    	mov    %ebx,0xac(%edi)
            switchuvm(np);
80104084:	89 1c 24             	mov    %ebx,(%esp)
80104087:	e8 e4 41 00 00       	call   80108270 <switchuvm>
            np->state = RUNNING;
8010408c:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
            rpholder.remove(np);
80104093:	89 1c 24             	mov    %ebx,(%esp)
80104096:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
            rpholder.add(np);
8010409c:	89 1c 24             	mov    %ebx,(%esp)
8010409f:	ff 15 d0 c5 10 80    	call   *0x8010c5d0
            swtch(&(c->scheduler), np->context);
801040a5:	8b 43 1c             	mov    0x1c(%ebx),%eax
            c->proc = 0;
801040a8:	31 db                	xor    %ebx,%ebx
            swtch(&(c->scheduler), np->context);
801040aa:	89 44 24 04          	mov    %eax,0x4(%esp)
801040ae:	8d 47 04             	lea    0x4(%edi),%eax
801040b1:	89 04 24             	mov    %eax,(%esp)
801040b4:	e8 c0 1e 00 00       	call   80105f79 <swtch>
            switchkvm();
801040b9:	e8 92 41 00 00       	call   80108250 <switchkvm>
            c->proc = 0;
801040be:	89 9f ac 00 00 00    	mov    %ebx,0xac(%edi)
                            release(&ptable.lock);
801040c4:	c7 45 08 a0 4d 11 80 	movl   $0x80114da0,0x8(%ebp)
}
801040cb:	83 c4 2c             	add    $0x2c,%esp
801040ce:	5b                   	pop    %ebx
801040cf:	5e                   	pop    %esi
801040d0:	5f                   	pop    %edi
801040d1:	5d                   	pop    %ebp
                            release(&ptable.lock);
801040d2:	e9 19 1c 00 00       	jmp    80105cf0 <release>
801040d7:	89 f6                	mov    %esi,%esi
801040d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
                            if (tqCounter - p->timeStamp > max || np == null){
801040e0:	8b 15 c0 c5 10 80    	mov    0x8010c5c0,%edx
                for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){  // Run over all the ptable and look for the process which didn't work for the lonest time.
801040e6:	b8 d4 4d 11 80       	mov    $0x80114dd4,%eax
                            if (tqCounter - p->timeStamp > max || np == null){
801040eb:	8b 0d c4 c5 10 80    	mov    0x8010c5c4,%ecx
                long long max = 0;
801040f1:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
801040f8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801040ff:	eb 13                	jmp    80104114 <extendedPriorityScheduler+0xd4>
80104101:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){  // Run over all the ptable and look for the process which didn't work for the lonest time.
80104108:	05 a8 00 00 00       	add    $0xa8,%eax
8010410d:	3d d4 77 11 80       	cmp    $0x801177d4,%eax
80104112:	73 3c                	jae    80104150 <extendedPriorityScheduler+0x110>
                        if (p->state == RUNNABLE){
80104114:	8b 70 0c             	mov    0xc(%eax),%esi
80104117:	83 fe 03             	cmp    $0x3,%esi
8010411a:	75 ec                	jne    80104108 <extendedPriorityScheduler+0xc8>
                            if (tqCounter - p->timeStamp > max || np == null){
8010411c:	89 d6                	mov    %edx,%esi
8010411e:	89 cf                	mov    %ecx,%edi
80104120:	2b b0 8c 00 00 00    	sub    0x8c(%eax),%esi
80104126:	1b b8 90 00 00 00    	sbb    0x90(%eax),%edi
8010412c:	85 db                	test   %ebx,%ebx
8010412e:	74 10                	je     80104140 <extendedPriorityScheduler+0x100>
80104130:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80104133:	7f 0b                	jg     80104140 <extendedPriorityScheduler+0x100>
80104135:	7c d1                	jl     80104108 <extendedPriorityScheduler+0xc8>
80104137:	3b 75 dc             	cmp    -0x24(%ebp),%esi
8010413a:	76 cc                	jbe    80104108 <extendedPriorityScheduler+0xc8>
8010413c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104140:	89 75 dc             	mov    %esi,-0x24(%ebp)
80104143:	89 c3                	mov    %eax,%ebx
80104145:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80104148:	eb be                	jmp    80104108 <extendedPriorityScheduler+0xc8>
8010414a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                avoidStarv = 0;
80104150:	31 f6                	xor    %esi,%esi
                if (np != null){
80104152:	85 db                	test   %ebx,%ebx
                avoidStarv = 0;
80104154:	89 35 b8 c5 10 80    	mov    %esi,0x8010c5b8
                if (np != null){
8010415a:	74 1c                	je     80104178 <extendedPriorityScheduler+0x138>
                    if (!pq.extractProc(np)){
8010415c:	89 1c 24             	mov    %ebx,(%esp)
8010415f:	ff 15 00 c6 10 80    	call   *0x8010c600
80104165:	85 c0                	test   %eax,%eax
80104167:	0f 85 0e ff ff ff    	jne    8010407b <extendedPriorityScheduler+0x3b>
8010416d:	8d 76 00             	lea    0x0(%esi),%esi
80104170:	e9 4f ff ff ff       	jmp    801040c4 <extendedPriorityScheduler+0x84>
80104175:	8d 76 00             	lea    0x0(%esi),%esi
            c->proc = np;
80104178:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010417b:	31 d2                	xor    %edx,%edx
8010417d:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
            switchuvm(np);
80104183:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010418a:	e8 e1 40 00 00       	call   80108270 <switchuvm>
            np->state = RUNNING;
8010418f:	31 c9                	xor    %ecx,%ecx
80104191:	89 0d 0c 00 00 00    	mov    %ecx,0xc
80104197:	0f 0b                	ud2    
80104199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801041a0 <scheduler>:
{
801041a0:	55                   	push   %ebp
801041a1:	89 e5                	mov    %esp,%ebp
801041a3:	53                   	push   %ebx
801041a4:	83 ec 14             	sub    $0x14,%esp
  struct cpu *c = mycpu();
801041a7:	e8 54 f7 ff ff       	call   80103900 <mycpu>
801041ac:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
801041ae:	31 c0                	xor    %eax,%eax
801041b0:	89 83 ac 00 00 00    	mov    %eax,0xac(%ebx)
801041b6:	8d 76 00             	lea    0x0(%esi),%esi
801041b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    switch(POLICY){
801041c0:	a1 08 c0 10 80       	mov    0x8010c008,%eax
801041c5:	83 f8 01             	cmp    $0x1,%eax
801041c8:	74 26                	je     801041f0 <scheduler+0x50>
801041ca:	7e 3c                	jle    80104208 <scheduler+0x68>
801041cc:	83 f8 02             	cmp    $0x2,%eax
801041cf:	74 4f                	je     80104220 <scheduler+0x80>
801041d1:	83 f8 03             	cmp    $0x3,%eax
801041d4:	75 ef                	jne    801041c5 <scheduler+0x25>
            extendedPriorityScheduler(p, c);
801041d6:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801041da:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801041e1:	e8 5a fe ff ff       	call   80104040 <extendedPriorityScheduler>
    switch(POLICY){
801041e6:	a1 08 c0 10 80       	mov    0x8010c008,%eax
801041eb:	83 f8 01             	cmp    $0x1,%eax
801041ee:	75 da                	jne    801041ca <scheduler+0x2a>
            roundRobinScheduler(p, c);
801041f0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801041f4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801041fb:	e8 20 fd ff ff       	call   80103f20 <roundRobinScheduler>
            break;
80104200:	eb be                	jmp    801041c0 <scheduler+0x20>
80104202:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(POLICY){
80104208:	85 c0                	test   %eax,%eax
8010420a:	75 b9                	jne    801041c5 <scheduler+0x25>
            originalScheduler(p, c);
8010420c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104210:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104217:	e8 74 fc ff ff       	call   80103e90 <originalScheduler>
            break;
8010421c:	eb a2                	jmp    801041c0 <scheduler+0x20>
8010421e:	66 90                	xchg   %ax,%ax
            priorityScheduler(p, c);
80104220:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104224:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010422b:	e8 80 fd ff ff       	call   80103fb0 <priorityScheduler>
            break;
80104230:	eb 8e                	jmp    801041c0 <scheduler+0x20>
80104232:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104240 <sched>:
{
80104240:	55                   	push   %ebp
80104241:	89 e5                	mov    %esp,%ebp
80104243:	56                   	push   %esi
80104244:	53                   	push   %ebx
80104245:	83 ec 10             	sub    $0x10,%esp
  pushcli();
80104248:	e8 23 19 00 00       	call   80105b70 <pushcli>
  c = mycpu();
8010424d:	e8 ae f6 ff ff       	call   80103900 <mycpu>
  p = c->proc;
80104252:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104258:	e8 53 19 00 00       	call   80105bb0 <popcli>
  if(!holding(&ptable.lock))
8010425d:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104264:	e8 a7 19 00 00       	call   80105c10 <holding>
80104269:	85 c0                	test   %eax,%eax
8010426b:	74 51                	je     801042be <sched+0x7e>
  if(mycpu()->ncli != 1)
8010426d:	e8 8e f6 ff ff       	call   80103900 <mycpu>
80104272:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80104279:	75 67                	jne    801042e2 <sched+0xa2>
  if(p->state == RUNNING)
8010427b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010427e:	83 f8 04             	cmp    $0x4,%eax
80104281:	74 53                	je     801042d6 <sched+0x96>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104283:	9c                   	pushf  
80104284:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104285:	f6 c4 02             	test   $0x2,%ah
80104288:	75 40                	jne    801042ca <sched+0x8a>
  intena = mycpu()->intena;
8010428a:	e8 71 f6 ff ff       	call   80103900 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
8010428f:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104292:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104298:	e8 63 f6 ff ff       	call   80103900 <mycpu>
8010429d:	8b 40 04             	mov    0x4(%eax),%eax
801042a0:	89 1c 24             	mov    %ebx,(%esp)
801042a3:	89 44 24 04          	mov    %eax,0x4(%esp)
801042a7:	e8 cd 1c 00 00       	call   80105f79 <swtch>
  mycpu()->intena = intena;
801042ac:	e8 4f f6 ff ff       	call   80103900 <mycpu>
801042b1:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
801042b7:	83 c4 10             	add    $0x10,%esp
801042ba:	5b                   	pop    %ebx
801042bb:	5e                   	pop    %esi
801042bc:	5d                   	pop    %ebp
801042bd:	c3                   	ret    
    panic("sched ptable.lock");
801042be:	c7 04 24 40 8f 10 80 	movl   $0x80108f40,(%esp)
801042c5:	e8 a6 c0 ff ff       	call   80100370 <panic>
    panic("sched interruptible");
801042ca:	c7 04 24 6c 8f 10 80 	movl   $0x80108f6c,(%esp)
801042d1:	e8 9a c0 ff ff       	call   80100370 <panic>
    panic("sched running");
801042d6:	c7 04 24 5e 8f 10 80 	movl   $0x80108f5e,(%esp)
801042dd:	e8 8e c0 ff ff       	call   80100370 <panic>
    panic("sched locks");
801042e2:	c7 04 24 52 8f 10 80 	movl   $0x80108f52,(%esp)
801042e9:	e8 82 c0 ff ff       	call   80100370 <panic>
801042ee:	66 90                	xchg   %ax,%ax

801042f0 <exit>:
{
801042f0:	55                   	push   %ebp
801042f1:	89 e5                	mov    %esp,%ebp
801042f3:	57                   	push   %edi
801042f4:	56                   	push   %esi
801042f5:	53                   	push   %ebx
801042f6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
801042f9:	e8 72 18 00 00       	call   80105b70 <pushcli>
  c = mycpu();
801042fe:	e8 fd f5 ff ff       	call   80103900 <mycpu>
  p = c->proc;
80104303:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104309:	e8 a2 18 00 00       	call   80105bb0 <popcli>
  if(curproc == initproc)
8010430e:	39 35 c8 c5 10 80    	cmp    %esi,0x8010c5c8
80104314:	0f 84 e5 00 00 00    	je     801043ff <exit+0x10f>
8010431a:	8d 5e 28             	lea    0x28(%esi),%ebx
8010431d:	8d 7e 68             	lea    0x68(%esi),%edi
    if(curproc->ofile[fd]){
80104320:	8b 03                	mov    (%ebx),%eax
80104322:	85 c0                	test   %eax,%eax
80104324:	74 0e                	je     80104334 <exit+0x44>
      fileclose(curproc->ofile[fd]);
80104326:	89 04 24             	mov    %eax,(%esp)
80104329:	e8 02 cb ff ff       	call   80100e30 <fileclose>
      curproc->ofile[fd] = 0;
8010432e:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104334:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80104337:	39 df                	cmp    %ebx,%edi
80104339:	75 e5                	jne    80104320 <exit+0x30>
  begin_op();
8010433b:	e8 50 e9 ff ff       	call   80102c90 <begin_op>
  iput(curproc->cwd);
80104340:	8b 46 68             	mov    0x68(%esi),%eax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104343:	bb d4 4d 11 80       	mov    $0x80114dd4,%ebx
  iput(curproc->cwd);
80104348:	89 04 24             	mov    %eax,(%esp)
8010434b:	e8 d0 d4 ff ff       	call   80101820 <iput>
  end_op();
80104350:	e8 ab e9 ff ff       	call   80102d00 <end_op>
  curproc->cwd = 0;
80104355:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&tickslock);
8010435c:	c7 04 24 e0 77 11 80 	movl   $0x801177e0,(%esp)
80104363:	e8 e8 18 00 00       	call   80105c50 <acquire>
  curproc->performance.ttime = ticks;
80104368:	a1 20 80 11 80       	mov    0x80118020,%eax
8010436d:	89 86 98 00 00 00    	mov    %eax,0x98(%esi)
  release(&tickslock);
80104373:	c7 04 24 e0 77 11 80 	movl   $0x801177e0,(%esp)
8010437a:	e8 71 19 00 00       	call   80105cf0 <release>
  acquire(&ptable.lock);
8010437f:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104386:	e8 c5 18 00 00       	call   80105c50 <acquire>
  wakeup1(curproc->parent);
8010438b:	8b 46 14             	mov    0x14(%esi),%eax
8010438e:	e8 6d fa ff ff       	call   80103e00 <wakeup1>
80104393:	eb 11                	jmp    801043a6 <exit+0xb6>
80104395:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104398:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
8010439e:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
801043a4:	73 2a                	jae    801043d0 <exit+0xe0>
    if(p->parent == curproc){
801043a6:	39 73 14             	cmp    %esi,0x14(%ebx)
801043a9:	75 ed                	jne    80104398 <exit+0xa8>
      if(p->state == ZOMBIE)
801043ab:	8b 53 0c             	mov    0xc(%ebx),%edx
      p->parent = initproc;
801043ae:	a1 c8 c5 10 80       	mov    0x8010c5c8,%eax
      if(p->state == ZOMBIE)
801043b3:	83 fa 05             	cmp    $0x5,%edx
      p->parent = initproc;
801043b6:	89 43 14             	mov    %eax,0x14(%ebx)
      if(p->state == ZOMBIE)
801043b9:	75 dd                	jne    80104398 <exit+0xa8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043bb:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
        wakeup1(initproc);
801043c1:	e8 3a fa ff ff       	call   80103e00 <wakeup1>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043c6:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
801043cc:	72 d8                	jb     801043a6 <exit+0xb6>
801043ce:	66 90                	xchg   %ax,%ax
  curproc->exitStatus = status;
801043d0:	8b 45 08             	mov    0x8(%ebp),%eax
801043d3:	89 46 7c             	mov    %eax,0x7c(%esi)
  if(p->state == RUNNING)
801043d6:	8b 43 0c             	mov    0xc(%ebx),%eax
801043d9:	83 f8 04             	cmp    $0x4,%eax
801043dc:	75 09                	jne    801043e7 <exit+0xf7>
      rpholder.remove(p);
801043de:	89 1c 24             	mov    %ebx,(%esp)
801043e1:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
  curproc->state = ZOMBIE;
801043e7:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
801043ee:	e8 4d fe ff ff       	call   80104240 <sched>
  panic("zombie exit");
801043f3:	c7 04 24 8d 8f 10 80 	movl   $0x80108f8d,(%esp)
801043fa:	e8 71 bf ff ff       	call   80100370 <panic>
    panic("init exiting");
801043ff:	c7 04 24 80 8f 10 80 	movl   $0x80108f80,(%esp)
80104406:	e8 65 bf ff ff       	call   80100370 <panic>
8010440b:	90                   	nop
8010440c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104410 <yield>:
{
80104410:	55                   	push   %ebp
80104411:	89 e5                	mov    %esp,%ebp
80104413:	53                   	push   %ebx
80104414:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104417:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
8010441e:	e8 2d 18 00 00       	call   80105c50 <acquire>
  pushcli();
80104423:	e8 48 17 00 00       	call   80105b70 <pushcli>
  c = mycpu();
80104428:	e8 d3 f4 ff ff       	call   80103900 <mycpu>
  p = c->proc;
8010442d:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104433:	e8 78 17 00 00       	call   80105bb0 <popcli>
  if(p->state == RUNNING){
80104438:	8b 43 0c             	mov    0xc(%ebx),%eax
8010443b:	83 f8 04             	cmp    $0x4,%eax
8010443e:	75 09                	jne    80104449 <yield+0x39>
    rpholder.remove(p);
80104440:	89 1c 24             	mov    %ebx,(%esp)
80104443:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
  tqCounter++;
80104449:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
8010444e:	8b 15 c4 c5 10 80    	mov    0x8010c5c4,%edx
  p->state = RUNNABLE;
80104454:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  tqCounter++;
8010445b:	83 c0 01             	add    $0x1,%eax
8010445e:	83 d2 00             	adc    $0x0,%edx
  if(POLICY == 1){
80104461:	83 3d 08 c0 10 80 01 	cmpl   $0x1,0x8010c008
  p->timeStamp = tqCounter;
80104468:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
8010446e:	89 93 90 00 00 00    	mov    %edx,0x90(%ebx)
  tqCounter++;
80104474:	a3 c0 c5 10 80       	mov    %eax,0x8010c5c0
80104479:	89 15 c4 c5 10 80    	mov    %edx,0x8010c5c4
      rrq.enqueue(p);
8010447f:	89 1c 24             	mov    %ebx,(%esp)
  if(POLICY == 1){
80104482:	74 7c                	je     80104500 <yield+0xf0>
      pq.put(p);
80104484:	ff 15 f0 c5 10 80    	call   *0x8010c5f0
      p->accumulator += p->priority;
8010448a:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
80104490:	99                   	cltd   
80104491:	01 83 84 00 00 00    	add    %eax,0x84(%ebx)
80104497:	11 93 88 00 00 00    	adc    %edx,0x88(%ebx)
      if (POLICY == 3 && (tqCounter % 100 == 0)){
8010449d:	83 3d 08 c0 10 80 03 	cmpl   $0x3,0x8010c008
801044a4:	74 1a                	je     801044c0 <yield+0xb0>
  sched();
801044a6:	e8 95 fd ff ff       	call   80104240 <sched>
  release(&ptable.lock);
801044ab:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
801044b2:	e8 39 18 00 00       	call   80105cf0 <release>
}
801044b7:	83 c4 14             	add    $0x14,%esp
801044ba:	5b                   	pop    %ebx
801044bb:	5d                   	pop    %ebp
801044bc:	c3                   	ret    
801044bd:	8d 76 00             	lea    0x0(%esi),%esi
      if (POLICY == 3 && (tqCounter % 100 == 0)){
801044c0:	ba 64 00 00 00       	mov    $0x64,%edx
801044c5:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
801044ca:	31 c9                	xor    %ecx,%ecx
801044cc:	89 54 24 08          	mov    %edx,0x8(%esp)
801044d0:	8b 15 c4 c5 10 80    	mov    0x8010c5c4,%edx
801044d6:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
801044da:	89 04 24             	mov    %eax,(%esp)
801044dd:	89 54 24 04          	mov    %edx,0x4(%esp)
801044e1:	e8 1a 14 00 00       	call   80105900 <__moddi3>
801044e6:	09 c2                	or     %eax,%edx
801044e8:	75 bc                	jne    801044a6 <yield+0x96>
         avoidStarv = 1;
801044ea:	b8 01 00 00 00       	mov    $0x1,%eax
801044ef:	a3 b8 c5 10 80       	mov    %eax,0x8010c5b8
801044f4:	eb b0                	jmp    801044a6 <yield+0x96>
801044f6:	8d 76 00             	lea    0x0(%esi),%esi
801044f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      rrq.enqueue(p);
80104500:	ff 15 e0 c5 10 80    	call   *0x8010c5e0
80104506:	eb 9e                	jmp    801044a6 <yield+0x96>
80104508:	90                   	nop
80104509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104510 <sleep>:
{
80104510:	55                   	push   %ebp
80104511:	89 e5                	mov    %esp,%ebp
80104513:	83 ec 28             	sub    $0x28,%esp
80104516:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80104519:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010451c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010451f:	89 7d fc             	mov    %edi,-0x4(%ebp)
80104522:	8b 7d 08             	mov    0x8(%ebp),%edi
  pushcli();
80104525:	e8 46 16 00 00       	call   80105b70 <pushcli>
  c = mycpu();
8010452a:	e8 d1 f3 ff ff       	call   80103900 <mycpu>
  p = c->proc;
8010452f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104535:	e8 76 16 00 00       	call   80105bb0 <popcli>
  if(p == 0)
8010453a:	85 db                	test   %ebx,%ebx
8010453c:	0f 84 ae 00 00 00    	je     801045f0 <sleep+0xe0>
  if(lk == 0)
80104542:	85 f6                	test   %esi,%esi
80104544:	0f 84 9a 00 00 00    	je     801045e4 <sleep+0xd4>
  if(lk != &ptable.lock){  //DOC: sleeplock0
8010454a:	81 fe a0 4d 11 80    	cmp    $0x80114da0,%esi
80104550:	74 5e                	je     801045b0 <sleep+0xa0>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104552:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104559:	e8 f2 16 00 00       	call   80105c50 <acquire>
    release(lk); 
8010455e:	89 34 24             	mov    %esi,(%esp)
80104561:	e8 8a 17 00 00       	call   80105cf0 <release>
  if(p->state == RUNNING)
80104566:	8b 43 0c             	mov    0xc(%ebx),%eax
  p->chan = chan;
80104569:	89 7b 20             	mov    %edi,0x20(%ebx)
  if(p->state == RUNNING)
8010456c:	83 f8 04             	cmp    $0x4,%eax
8010456f:	75 09                	jne    8010457a <sleep+0x6a>
      rpholder.remove(p);
80104571:	89 1c 24             	mov    %ebx,(%esp)
80104574:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
  p->state = SLEEPING;
8010457a:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104581:	e8 ba fc ff ff       	call   80104240 <sched>
  p->chan = 0;
80104586:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
8010458d:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104594:	e8 57 17 00 00       	call   80105cf0 <release>
}
80104599:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    acquire(lk);
8010459c:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010459f:	8b 7d fc             	mov    -0x4(%ebp),%edi
801045a2:	8b 75 f8             	mov    -0x8(%ebp),%esi
801045a5:	89 ec                	mov    %ebp,%esp
801045a7:	5d                   	pop    %ebp
    acquire(lk);
801045a8:	e9 a3 16 00 00       	jmp    80105c50 <acquire>
801045ad:	8d 76 00             	lea    0x0(%esi),%esi
  if(p->state == RUNNING)
801045b0:	8b 43 0c             	mov    0xc(%ebx),%eax
  p->chan = chan;
801045b3:	89 7b 20             	mov    %edi,0x20(%ebx)
  if(p->state == RUNNING)
801045b6:	83 f8 04             	cmp    $0x4,%eax
801045b9:	75 09                	jne    801045c4 <sleep+0xb4>
      rpholder.remove(p);
801045bb:	89 1c 24             	mov    %ebx,(%esp)
801045be:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
  p->state = SLEEPING;
801045c4:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801045cb:	e8 70 fc ff ff       	call   80104240 <sched>
  p->chan = 0;
801045d0:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801045d7:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801045da:	8b 75 f8             	mov    -0x8(%ebp),%esi
801045dd:	8b 7d fc             	mov    -0x4(%ebp),%edi
801045e0:	89 ec                	mov    %ebp,%esp
801045e2:	5d                   	pop    %ebp
801045e3:	c3                   	ret    
    panic("sleep without lk");
801045e4:	c7 04 24 9f 8f 10 80 	movl   $0x80108f9f,(%esp)
801045eb:	e8 80 bd ff ff       	call   80100370 <panic>
    panic("sleep");
801045f0:	c7 04 24 99 8f 10 80 	movl   $0x80108f99,(%esp)
801045f7:	e8 74 bd ff ff       	call   80100370 <panic>
801045fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104600 <wait>:
{
80104600:	55                   	push   %ebp
80104601:	89 e5                	mov    %esp,%ebp
80104603:	57                   	push   %edi
80104604:	56                   	push   %esi
80104605:	53                   	push   %ebx
80104606:	83 ec 1c             	sub    $0x1c,%esp
80104609:	8b 7d 08             	mov    0x8(%ebp),%edi
  pushcli();
8010460c:	e8 5f 15 00 00       	call   80105b70 <pushcli>
  c = mycpu();
80104611:	e8 ea f2 ff ff       	call   80103900 <mycpu>
  p = c->proc;
80104616:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
8010461c:	e8 8f 15 00 00       	call   80105bb0 <popcli>
  acquire(&ptable.lock);
80104621:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104628:	e8 23 16 00 00       	call   80105c50 <acquire>
    havekids = 0;
8010462d:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010462f:	bb d4 4d 11 80       	mov    $0x80114dd4,%ebx
80104634:	eb 18                	jmp    8010464e <wait+0x4e>
80104636:	8d 76 00             	lea    0x0(%esi),%esi
80104639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104640:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80104646:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
8010464c:	73 20                	jae    8010466e <wait+0x6e>
      if(p->parent != curproc)
8010464e:	39 73 14             	cmp    %esi,0x14(%ebx)
80104651:	75 ed                	jne    80104640 <wait+0x40>
      if(p->state == ZOMBIE){
80104653:	8b 43 0c             	mov    0xc(%ebx),%eax
80104656:	83 f8 05             	cmp    $0x5,%eax
80104659:	74 35                	je     80104690 <wait+0x90>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010465b:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
      havekids = 1;
80104661:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104666:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
8010466c:	72 e0                	jb     8010464e <wait+0x4e>
    if(!havekids || curproc->killed){
8010466e:	85 c0                	test   %eax,%eax
80104670:	74 7d                	je     801046ef <wait+0xef>
80104672:	8b 56 24             	mov    0x24(%esi),%edx
80104675:	85 d2                	test   %edx,%edx
80104677:	75 76                	jne    801046ef <wait+0xef>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104679:	b8 a0 4d 11 80       	mov    $0x80114da0,%eax
8010467e:	89 44 24 04          	mov    %eax,0x4(%esp)
80104682:	89 34 24             	mov    %esi,(%esp)
80104685:	e8 86 fe ff ff       	call   80104510 <sleep>
    havekids = 0;
8010468a:	eb a1                	jmp    8010462d <wait+0x2d>
8010468c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80104690:	8b 43 08             	mov    0x8(%ebx),%eax
        pid = p->pid;
80104693:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104696:	89 04 24             	mov    %eax,(%esp)
80104699:	e8 42 dd ff ff       	call   801023e0 <kfree>
        freevm(p->pgdir);
8010469e:	8b 43 04             	mov    0x4(%ebx),%eax
        p->kstack = 0;
801046a1:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801046a8:	89 04 24             	mov    %eax,(%esp)
801046ab:	e8 70 3f 00 00       	call   80108620 <freevm>
        if(status != null){ 
801046b0:	85 ff                	test   %edi,%edi
        p->pid = 0;
801046b2:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801046b9:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801046c0:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801046c4:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801046cb:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        if(status != null){ 
801046d2:	74 05                	je     801046d9 <wait+0xd9>
            *status = p->exitStatus;
801046d4:	8b 43 7c             	mov    0x7c(%ebx),%eax
801046d7:	89 07                	mov    %eax,(%edi)
        release(&ptable.lock);
801046d9:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
801046e0:	e8 0b 16 00 00       	call   80105cf0 <release>
}
801046e5:	83 c4 1c             	add    $0x1c,%esp
801046e8:	89 f0                	mov    %esi,%eax
801046ea:	5b                   	pop    %ebx
801046eb:	5e                   	pop    %esi
801046ec:	5f                   	pop    %edi
801046ed:	5d                   	pop    %ebp
801046ee:	c3                   	ret    
      release(&ptable.lock);
801046ef:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
      return -1;
801046f6:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801046fb:	e8 f0 15 00 00       	call   80105cf0 <release>
      return -1;
80104700:	eb e3                	jmp    801046e5 <wait+0xe5>
80104702:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104710 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104710:	55                   	push   %ebp
80104711:	89 e5                	mov    %esp,%ebp
80104713:	53                   	push   %ebx
80104714:	83 ec 14             	sub    $0x14,%esp
80104717:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010471a:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104721:	e8 2a 15 00 00       	call   80105c50 <acquire>
  wakeup1(chan);
80104726:	89 d8                	mov    %ebx,%eax
80104728:	e8 d3 f6 ff ff       	call   80103e00 <wakeup1>
  release(&ptable.lock);
8010472d:	c7 45 08 a0 4d 11 80 	movl   $0x80114da0,0x8(%ebp)
}
80104734:	83 c4 14             	add    $0x14,%esp
80104737:	5b                   	pop    %ebx
80104738:	5d                   	pop    %ebp
  release(&ptable.lock);
80104739:	e9 b2 15 00 00       	jmp    80105cf0 <release>
8010473e:	66 90                	xchg   %ax,%ax

80104740 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	56                   	push   %esi
80104744:	53                   	push   %ebx
  struct proc *p;
    
  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104745:	bb d4 4d 11 80       	mov    $0x80114dd4,%ebx
{
8010474a:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010474d:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
{
80104754:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&ptable.lock);
80104757:	e8 f4 14 00 00       	call   80105c50 <acquire>
8010475c:	eb 10                	jmp    8010476e <kill+0x2e>
8010475e:	66 90                	xchg   %ax,%ax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104760:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80104766:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
8010476c:	73 72                	jae    801047e0 <kill+0xa0>
    if(p->pid == pid){
8010476e:	39 73 10             	cmp    %esi,0x10(%ebx)
80104771:	75 ed                	jne    80104760 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING){
80104773:	8b 43 0c             	mov    0xc(%ebx),%eax
      p->killed = 1;
80104776:	c7 43 24 01 00 00 00 	movl   $0x1,0x24(%ebx)
      if(p->state == SLEEPING){
8010477d:	83 f8 02             	cmp    $0x2,%eax
80104780:	74 1e                	je     801047a0 <kill+0x60>
        if(POLICY == 1)
            rrq.enqueue(p);
        else
            pq.put(p);
      }
      release(&ptable.lock);
80104782:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104789:	e8 62 15 00 00       	call   80105cf0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
8010478e:	83 c4 10             	add    $0x10,%esp
      return 0;
80104791:	31 c0                	xor    %eax,%eax
}
80104793:	5b                   	pop    %ebx
80104794:	5e                   	pop    %esi
80104795:	5d                   	pop    %ebp
80104796:	c3                   	ret    
80104797:	89 f6                	mov    %esi,%esi
80104799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        p->timeStamp = tqCounter;
801047a0:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
801047a5:	8b 15 c4 c5 10 80    	mov    0x8010c5c4,%edx
        setAccumulator(p);  
801047ab:	89 1c 24             	mov    %ebx,(%esp)
        p->state = RUNNABLE;
801047ae:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
        p->timeStamp = tqCounter;
801047b5:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
801047bb:	89 93 90 00 00 00    	mov    %edx,0x90(%ebx)
        setAccumulator(p);  
801047c1:	e8 8a f2 ff ff       	call   80103a50 <setAccumulator>
        if(POLICY == 1)
801047c6:	83 3d 08 c0 10 80 01 	cmpl   $0x1,0x8010c008
            rrq.enqueue(p);
801047cd:	89 1c 24             	mov    %ebx,(%esp)
        if(POLICY == 1)
801047d0:	74 26                	je     801047f8 <kill+0xb8>
            pq.put(p);
801047d2:	ff 15 f0 c5 10 80    	call   *0x8010c5f0
801047d8:	eb a8                	jmp    80104782 <kill+0x42>
801047da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
801047e0:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
801047e7:	e8 04 15 00 00       	call   80105cf0 <release>
}
801047ec:	83 c4 10             	add    $0x10,%esp
  return -1;
801047ef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801047f4:	5b                   	pop    %ebx
801047f5:	5e                   	pop    %esi
801047f6:	5d                   	pop    %ebp
801047f7:	c3                   	ret    
            rrq.enqueue(p);
801047f8:	ff 15 e0 c5 10 80    	call   *0x8010c5e0
801047fe:	eb 82                	jmp    80104782 <kill+0x42>

80104800 <detach>:

// transfer a child process with the given pid from the parent to the init process.
// return 0 when succseeds or -1 if the process has no child with this pid.
int
detach(int pid)
{ 
80104800:	55                   	push   %ebp
80104801:	89 e5                	mov    %esp,%ebp
80104803:	57                   	push   %edi
80104804:	56                   	push   %esi
80104805:	53                   	push   %ebx
80104806:	83 ec 2c             	sub    $0x2c,%esp
80104809:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
8010480c:	e8 5f 13 00 00       	call   80105b70 <pushcli>
  c = mycpu();
80104811:	e8 ea f0 ff ff       	call   80103900 <mycpu>
  p = c->proc;
80104816:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
8010481c:	e8 8f 13 00 00       	call   80105bb0 <popcli>
  struct proc *curproc = myproc();
  struct proc *p;
  int procExist = -1;

  if(curproc == initproc)
80104821:	39 3d c8 c5 10 80    	cmp    %edi,0x8010c5c8
80104827:	74 7e                	je     801048a7 <detach+0xa7>
    panic("init called detach");

  acquire(&ptable.lock);
80104829:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104830:	bb d4 4d 11 80       	mov    $0x80114dd4,%ebx
  acquire(&ptable.lock);
80104835:	e8 16 14 00 00       	call   80105c50 <acquire>
  int procExist = -1;
8010483a:	ba ff ff ff ff       	mov    $0xffffffff,%edx
8010483f:	eb 15                	jmp    80104856 <detach+0x56>
80104841:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104848:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
8010484e:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
80104854:	73 35                	jae    8010488b <detach+0x8b>
    if(p->pid == pid && p->parent == curproc){
80104856:	39 73 10             	cmp    %esi,0x10(%ebx)
80104859:	75 ed                	jne    80104848 <detach+0x48>
8010485b:	39 7b 14             	cmp    %edi,0x14(%ebx)
8010485e:	75 e8                	jne    80104848 <detach+0x48>
        procExist = 0;
        p->parent = initproc;
        if(p->state == ZOMBIE)
80104860:	8b 4b 0c             	mov    0xc(%ebx),%ecx
        procExist = 0;
80104863:	31 d2                	xor    %edx,%edx
        p->parent = initproc;
80104865:	a1 c8 c5 10 80       	mov    0x8010c5c8,%eax
        if(p->state == ZOMBIE)
8010486a:	83 f9 05             	cmp    $0x5,%ecx
        p->parent = initproc;
8010486d:	89 43 14             	mov    %eax,0x14(%ebx)
        if(p->state == ZOMBIE)
80104870:	75 d6                	jne    80104848 <detach+0x48>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104872:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80104878:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            wakeup1(initproc);
8010487b:	e8 80 f5 ff ff       	call   80103e00 <wakeup1>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104880:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
            wakeup1(initproc);
80104886:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104889:	72 cb                	jb     80104856 <detach+0x56>
    }
  }
  release(&ptable.lock);
8010488b:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104892:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80104895:	e8 56 14 00 00       	call   80105cf0 <release>
  return procExist;
}
8010489a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010489d:	83 c4 2c             	add    $0x2c,%esp
801048a0:	5b                   	pop    %ebx
801048a1:	5e                   	pop    %esi
801048a2:	89 d0                	mov    %edx,%eax
801048a4:	5f                   	pop    %edi
801048a5:	5d                   	pop    %ebp
801048a6:	c3                   	ret    
    panic("init called detach");
801048a7:	c7 04 24 b0 8f 10 80 	movl   $0x80108fb0,(%esp)
801048ae:	e8 bd ba ff ff       	call   80100370 <panic>
801048b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801048b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048c0 <priority>:

// used by a process to change its priority
void
priority(int proc_priority)
{
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
801048c3:	83 ec 18             	sub    $0x18,%esp
801048c6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801048c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801048cc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  pushcli();
801048cf:	e8 9c 12 00 00       	call   80105b70 <pushcli>
  c = mycpu();
801048d4:	e8 27 f0 ff ff       	call   80103900 <mycpu>
  p = c->proc;
801048d9:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801048df:	e8 cc 12 00 00       	call   80105bb0 <popcli>
  struct proc *curproc = myproc();
  
  if(proc_priority <= 10 && proc_priority >= 0){
801048e4:	83 fb 0a             	cmp    $0xa,%ebx
801048e7:	77 13                	ja     801048fc <priority+0x3c>
      if(POLICY == 3 || (POLICY == 2 && proc_priority >= 1)){
801048e9:	a1 08 c0 10 80       	mov    0x8010c008,%eax
801048ee:	83 f8 03             	cmp    $0x3,%eax
801048f1:	74 1d                	je     80104910 <priority+0x50>
801048f3:	83 f8 02             	cmp    $0x2,%eax
801048f6:	75 04                	jne    801048fc <priority+0x3c>
801048f8:	85 db                	test   %ebx,%ebx
801048fa:	75 14                	jne    80104910 <priority+0x50>
        acquire(&ptable.lock);
        curproc->priority = proc_priority;
        release(&ptable.lock); 
      }
  }
}
801048fc:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801048ff:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104902:	89 ec                	mov    %ebp,%esp
80104904:	5d                   	pop    %ebp
80104905:	c3                   	ret    
80104906:	8d 76 00             	lea    0x0(%esi),%esi
80104909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        acquire(&ptable.lock);
80104910:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104917:	e8 34 13 00 00       	call   80105c50 <acquire>
        curproc->priority = proc_priority;
8010491c:	89 9e 80 00 00 00    	mov    %ebx,0x80(%esi)
}
80104922:	8b 5d f8             	mov    -0x8(%ebp),%ebx
        release(&ptable.lock); 
80104925:	c7 45 08 a0 4d 11 80 	movl   $0x80114da0,0x8(%ebp)
}
8010492c:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010492f:	89 ec                	mov    %ebp,%esp
80104931:	5d                   	pop    %ebp
        release(&ptable.lock); 
80104932:	e9 b9 13 00 00       	jmp    80105cf0 <release>
80104937:	89 f6                	mov    %esi,%esi
80104939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104940 <policy>:

// receives a policy identifier as an argument and changes the currently used policy.
void
policy(int policy_id)
{
80104940:	55                   	push   %ebp
80104941:	89 e5                	mov    %esp,%ebp
80104943:	56                   	push   %esi
80104944:	53                   	push   %ebx
    struct proc *p;
    
    acquire(&ptable.lock);
           
    
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104945:	bb d4 4d 11 80       	mov    $0x80114dd4,%ebx
{
8010494a:	83 ec 10             	sub    $0x10,%esp
    acquire(&ptable.lock);
8010494d:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
{
80104954:	8b 75 08             	mov    0x8(%ebp),%esi
    acquire(&ptable.lock);
80104957:	e8 f4 12 00 00       	call   80105c50 <acquire>
8010495c:	eb 29                	jmp    80104987 <policy+0x47>
8010495e:	66 90                	xchg   %ax,%ax
        if(policy_id == 1 && (POLICY == 2 || POLICY == 3)){ /*change from Priority to Round Robin policy*/
            pq.switchToRoundRobinPolicy();
            p->accumulator = 0;
        }
        if(policy_id == 2){ 
80104960:	83 fe 02             	cmp    $0x2,%esi
80104963:	74 73                	je     801049d8 <policy+0x98>
            }
            if(POLICY == 1){ /*change from Round Robin to Priority scheduling policy*/
                rrq.switchToPriorityQueuePolicy();
            }
        }
        if(policy_id == 3 && POLICY == 1){ /*change from Extended Priority to Round Robin policy*/
80104965:	83 fe 03             	cmp    $0x3,%esi
80104968:	75 0f                	jne    80104979 <policy+0x39>
8010496a:	83 3d 08 c0 10 80 01 	cmpl   $0x1,0x8010c008
80104971:	75 06                	jne    80104979 <policy+0x39>
            pq.switchToRoundRobinPolicy();
80104973:	ff 15 fc c5 10 80    	call   *0x8010c5fc
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104979:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
8010497f:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
80104985:	73 33                	jae    801049ba <policy+0x7a>
        if(policy_id == 1 && (POLICY == 2 || POLICY == 3)){ /*change from Priority to Round Robin policy*/
80104987:	83 fe 01             	cmp    $0x1,%esi
8010498a:	75 d4                	jne    80104960 <policy+0x20>
8010498c:	a1 08 c0 10 80       	mov    0x8010c008,%eax
80104991:	83 e8 02             	sub    $0x2,%eax
80104994:	83 f8 01             	cmp    $0x1,%eax
80104997:	77 e0                	ja     80104979 <policy+0x39>
            pq.switchToRoundRobinPolicy();
80104999:	ff 15 fc c5 10 80    	call   *0x8010c5fc
            p->accumulator = 0;
8010499f:	31 c9                	xor    %ecx,%ecx
801049a1:	31 c0                	xor    %eax,%eax
801049a3:	89 8b 84 00 00 00    	mov    %ecx,0x84(%ebx)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049a9:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
            p->accumulator = 0;
801049af:	89 43 e0             	mov    %eax,-0x20(%ebx)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049b2:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
801049b8:	72 cd                	jb     80104987 <policy+0x47>
        }
    }
     POLICY = policy_id;
801049ba:	89 35 08 c0 10 80    	mov    %esi,0x8010c008
    release(&ptable.lock);
801049c0:	c7 45 08 a0 4d 11 80 	movl   $0x80114da0,0x8(%ebp)
}
801049c7:	83 c4 10             	add    $0x10,%esp
801049ca:	5b                   	pop    %ebx
801049cb:	5e                   	pop    %esi
801049cc:	5d                   	pop    %ebp
    release(&ptable.lock);
801049cd:	e9 1e 13 00 00       	jmp    80105cf0 <release>
801049d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            if(POLICY == 3){ /*change from Extended Priority to Priority scheduling policy*/
801049d8:	a1 08 c0 10 80       	mov    0x8010c008,%eax
801049dd:	83 f8 03             	cmp    $0x3,%eax
801049e0:	74 16                	je     801049f8 <policy+0xb8>
            if(POLICY == 1){ /*change from Round Robin to Priority scheduling policy*/
801049e2:	48                   	dec    %eax
801049e3:	75 94                	jne    80104979 <policy+0x39>
                rrq.switchToPriorityQueuePolicy();
801049e5:	ff 15 e8 c5 10 80    	call   *0x8010c5e8
801049eb:	90                   	nop
801049ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801049f0:	eb 87                	jmp    80104979 <policy+0x39>
801049f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                if(p->priority == 0){ 
801049f8:	8b 93 80 00 00 00    	mov    0x80(%ebx),%edx
801049fe:	85 d2                	test   %edx,%edx
80104a00:	0f 85 73 ff ff ff    	jne    80104979 <policy+0x39>
                    p->priority = 1;
80104a06:	b8 01 00 00 00       	mov    $0x1,%eax
80104a0b:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
80104a11:	e9 63 ff ff ff       	jmp    80104979 <policy+0x39>
80104a16:	8d 76 00             	lea    0x0(%esi),%esi
80104a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a20 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	57                   	push   %edi
80104a24:	56                   	push   %esi
80104a25:	53                   	push   %ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a26:	bb d4 4d 11 80       	mov    $0x80114dd4,%ebx
{
80104a2b:	83 ec 4c             	sub    $0x4c,%esp
80104a2e:	eb 1e                	jmp    80104a4e <procdump+0x2e>
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104a30:	c7 04 24 4d 90 10 80 	movl   $0x8010904d,(%esp)
80104a37:	e8 14 bc ff ff       	call   80100650 <cprintf>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a3c:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80104a42:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
80104a48:	0f 83 b2 00 00 00    	jae    80104b00 <procdump+0xe0>
    if(p->state == UNUSED)
80104a4e:	8b 43 0c             	mov    0xc(%ebx),%eax
80104a51:	85 c0                	test   %eax,%eax
80104a53:	74 e7                	je     80104a3c <procdump+0x1c>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104a55:	8b 43 0c             	mov    0xc(%ebx),%eax
      state = "???";
80104a58:	b8 c3 8f 10 80       	mov    $0x80108fc3,%eax
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104a5d:	8b 53 0c             	mov    0xc(%ebx),%edx
80104a60:	83 fa 05             	cmp    $0x5,%edx
80104a63:	77 18                	ja     80104a7d <procdump+0x5d>
80104a65:	8b 53 0c             	mov    0xc(%ebx),%edx
80104a68:	8b 14 95 24 90 10 80 	mov    -0x7fef6fdc(,%edx,4),%edx
80104a6f:	85 d2                	test   %edx,%edx
80104a71:	74 0a                	je     80104a7d <procdump+0x5d>
      state = states[p->state];
80104a73:	8b 43 0c             	mov    0xc(%ebx),%eax
80104a76:	8b 04 85 24 90 10 80 	mov    -0x7fef6fdc(,%eax,4),%eax
    cprintf("%d %s %s", p->pid, state, p->name);
80104a7d:	89 44 24 08          	mov    %eax,0x8(%esp)
80104a81:	8b 43 10             	mov    0x10(%ebx),%eax
80104a84:	8d 53 6c             	lea    0x6c(%ebx),%edx
80104a87:	89 54 24 0c          	mov    %edx,0xc(%esp)
80104a8b:	c7 04 24 c7 8f 10 80 	movl   $0x80108fc7,(%esp)
80104a92:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a96:	e8 b5 bb ff ff       	call   80100650 <cprintf>
    if(p->state == SLEEPING){
80104a9b:	8b 43 0c             	mov    0xc(%ebx),%eax
80104a9e:	83 f8 02             	cmp    $0x2,%eax
80104aa1:	75 8d                	jne    80104a30 <procdump+0x10>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104aa3:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104aa6:	89 44 24 04          	mov    %eax,0x4(%esp)
80104aaa:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104aad:	8d 75 c0             	lea    -0x40(%ebp),%esi
80104ab0:	8d 7d e8             	lea    -0x18(%ebp),%edi
80104ab3:	8b 40 0c             	mov    0xc(%eax),%eax
80104ab6:	83 c0 08             	add    $0x8,%eax
80104ab9:	89 04 24             	mov    %eax,(%esp)
80104abc:	e8 5f 10 00 00       	call   80105b20 <getcallerpcs>
80104ac1:	eb 0d                	jmp    80104ad0 <procdump+0xb0>
80104ac3:	90                   	nop
80104ac4:	90                   	nop
80104ac5:	90                   	nop
80104ac6:	90                   	nop
80104ac7:	90                   	nop
80104ac8:	90                   	nop
80104ac9:	90                   	nop
80104aca:	90                   	nop
80104acb:	90                   	nop
80104acc:	90                   	nop
80104acd:	90                   	nop
80104ace:	90                   	nop
80104acf:	90                   	nop
      for(i=0; i<10 && pc[i] != 0; i++)
80104ad0:	8b 16                	mov    (%esi),%edx
80104ad2:	85 d2                	test   %edx,%edx
80104ad4:	0f 84 56 ff ff ff    	je     80104a30 <procdump+0x10>
        cprintf(" %p", pc[i]);
80104ada:	89 54 24 04          	mov    %edx,0x4(%esp)
80104ade:	83 c6 04             	add    $0x4,%esi
80104ae1:	c7 04 24 a1 89 10 80 	movl   $0x801089a1,(%esp)
80104ae8:	e8 63 bb ff ff       	call   80100650 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104aed:	39 f7                	cmp    %esi,%edi
80104aef:	75 df                	jne    80104ad0 <procdump+0xb0>
80104af1:	e9 3a ff ff ff       	jmp    80104a30 <procdump+0x10>
80104af6:	8d 76 00             	lea    0x0(%esi),%esi
80104af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }
}
80104b00:	83 c4 4c             	add    $0x4c,%esp
80104b03:	5b                   	pop    %ebx
80104b04:	5e                   	pop    %esi
80104b05:	5f                   	pop    %edi
80104b06:	5d                   	pop    %ebp
80104b07:	c3                   	ret    
80104b08:	90                   	nop
80104b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104b10 <wait_stat>:

// Return the pid of the terminated child process or -1 upon failure.
int
wait_stat(int* status, struct perf * performance){
80104b10:	55                   	push   %ebp
80104b11:	89 e5                	mov    %esp,%ebp
80104b13:	57                   	push   %edi
80104b14:	56                   	push   %esi
80104b15:	53                   	push   %ebx
80104b16:	83 ec 1c             	sub    $0x1c,%esp
80104b19:	8b 7d 0c             	mov    0xc(%ebp),%edi
  pushcli();
80104b1c:	e8 4f 10 00 00       	call   80105b70 <pushcli>
  c = mycpu();
80104b21:	e8 da ed ff ff       	call   80103900 <mycpu>
  p = c->proc;
80104b26:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104b2c:	e8 7f 10 00 00       	call   80105bb0 <popcli>
      struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();

  acquire(&ptable.lock);
80104b31:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104b38:	e8 13 11 00 00       	call   80105c50 <acquire>
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80104b3d:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b3f:	bb d4 4d 11 80       	mov    $0x80114dd4,%ebx
80104b44:	eb 18                	jmp    80104b5e <wait_stat+0x4e>
80104b46:	8d 76 00             	lea    0x0(%esi),%esi
80104b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104b50:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80104b56:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
80104b5c:	73 20                	jae    80104b7e <wait_stat+0x6e>
      if(p->parent != curproc)
80104b5e:	39 73 14             	cmp    %esi,0x14(%ebx)
80104b61:	75 ed                	jne    80104b50 <wait_stat+0x40>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80104b63:	8b 43 0c             	mov    0xc(%ebx),%eax
80104b66:	83 f8 05             	cmp    $0x5,%eax
80104b69:	74 3d                	je     80104ba8 <wait_stat+0x98>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b6b:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
      havekids = 1;
80104b71:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b76:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
80104b7c:	72 e0                	jb     80104b5e <wait_stat+0x4e>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80104b7e:	85 c0                	test   %eax,%eax
80104b80:	0f 84 b7 00 00 00    	je     80104c3d <wait_stat+0x12d>
80104b86:	8b 56 24             	mov    0x24(%esi),%edx
80104b89:	85 d2                	test   %edx,%edx
80104b8b:	0f 85 ac 00 00 00    	jne    80104c3d <wait_stat+0x12d>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104b91:	b8 a0 4d 11 80       	mov    $0x80114da0,%eax
80104b96:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b9a:	89 34 24             	mov    %esi,(%esp)
80104b9d:	e8 6e f9 ff ff       	call   80104510 <sleep>
    havekids = 0;
80104ba2:	eb 99                	jmp    80104b3d <wait_stat+0x2d>
80104ba4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80104ba8:	8b 43 08             	mov    0x8(%ebx),%eax
        pid = p->pid;
80104bab:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104bae:	89 04 24             	mov    %eax,(%esp)
80104bb1:	e8 2a d8 ff ff       	call   801023e0 <kfree>
        freevm(p->pgdir);
80104bb6:	8b 43 04             	mov    0x4(%ebx),%eax
        p->kstack = 0;
80104bb9:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104bc0:	89 04 24             	mov    %eax,(%esp)
80104bc3:	e8 58 3a 00 00       	call   80108620 <freevm>
        if(status != null){ 
80104bc8:	8b 4d 08             	mov    0x8(%ebp),%ecx
        p->pid = 0;
80104bcb:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104bd2:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104bd9:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        if(status != null){ 
80104bdd:	85 c9                	test   %ecx,%ecx
        p->killed = 0;
80104bdf:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104be6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        if(status != null){ 
80104bed:	74 08                	je     80104bf7 <wait_stat+0xe7>
            *status = p->exitStatus;
80104bef:	8b 43 7c             	mov    0x7c(%ebx),%eax
80104bf2:	8b 55 08             	mov    0x8(%ebp),%edx
80104bf5:	89 02                	mov    %eax,(%edx)
        if(performance != null){ 
80104bf7:	85 ff                	test   %edi,%edi
80104bf9:	74 2c                	je     80104c27 <wait_stat+0x117>
            *performance = p->performance;
80104bfb:	8b 83 94 00 00 00    	mov    0x94(%ebx),%eax
80104c01:	89 07                	mov    %eax,(%edi)
80104c03:	8b 83 98 00 00 00    	mov    0x98(%ebx),%eax
80104c09:	89 47 04             	mov    %eax,0x4(%edi)
80104c0c:	8b 83 9c 00 00 00    	mov    0x9c(%ebx),%eax
80104c12:	89 47 08             	mov    %eax,0x8(%edi)
80104c15:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80104c1b:	89 47 0c             	mov    %eax,0xc(%edi)
80104c1e:	8b 83 a4 00 00 00    	mov    0xa4(%ebx),%eax
80104c24:	89 47 10             	mov    %eax,0x10(%edi)
        release(&ptable.lock);
80104c27:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104c2e:	e8 bd 10 00 00       	call   80105cf0 <release>
  }
}
80104c33:	83 c4 1c             	add    $0x1c,%esp
80104c36:	89 f0                	mov    %esi,%eax
80104c38:	5b                   	pop    %ebx
80104c39:	5e                   	pop    %esi
80104c3a:	5f                   	pop    %edi
80104c3b:	5d                   	pop    %ebp
80104c3c:	c3                   	ret    
      release(&ptable.lock);
80104c3d:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
      return -1;
80104c44:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104c49:	e8 a2 10 00 00       	call   80105cf0 <release>
      return -1;
80104c4e:	eb e3                	jmp    80104c33 <wait_stat+0x123>

80104c50 <updatePerformance>:

// increments performence to all proccesses that are running or sleeping
void updatePerformance(){
80104c50:	55                   	push   %ebp
80104c51:	89 e5                	mov    %esp,%ebp
80104c53:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  acquire(&ptable.lock);
80104c56:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104c5d:	e8 ee 0f 00 00       	call   80105c50 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c62:	b8 d4 4d 11 80       	mov    $0x80114dd4,%eax
80104c67:	89 f6                	mov    %esi,%esi
80104c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(p->state == RUNNABLE){
80104c70:	8b 50 0c             	mov    0xc(%eax),%edx
80104c73:	83 fa 03             	cmp    $0x3,%edx
80104c76:	75 06                	jne    80104c7e <updatePerformance+0x2e>
      p->performance.retime++;
80104c78:	ff 80 a0 00 00 00    	incl   0xa0(%eax)
    }
    if(p->state == RUNNING){
80104c7e:	8b 50 0c             	mov    0xc(%eax),%edx
80104c81:	83 fa 04             	cmp    $0x4,%edx
80104c84:	75 06                	jne    80104c8c <updatePerformance+0x3c>
      p->performance.rutime++;
80104c86:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
    }
    if(p->state == SLEEPING){
80104c8c:	8b 50 0c             	mov    0xc(%eax),%edx
80104c8f:	83 fa 02             	cmp    $0x2,%edx
80104c92:	75 06                	jne    80104c9a <updatePerformance+0x4a>
      p->performance.stime++;
80104c94:	ff 80 9c 00 00 00    	incl   0x9c(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c9a:	05 a8 00 00 00       	add    $0xa8,%eax
80104c9f:	3d d4 77 11 80       	cmp    $0x801177d4,%eax
80104ca4:	72 ca                	jb     80104c70 <updatePerformance+0x20>
    }
  }
  release(&ptable.lock);
80104ca6:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104cad:	e8 3e 10 00 00       	call   80105cf0 <release>
}
80104cb2:	c9                   	leave  
80104cb3:	c3                   	ret    
80104cb4:	66 90                	xchg   %ax,%ax
80104cb6:	66 90                	xchg   %ax,%ax
80104cb8:	66 90                	xchg   %ax,%ax
80104cba:	66 90                	xchg   %ax,%ax
80104cbc:	66 90                	xchg   %ax,%ax
80104cbe:	66 90                	xchg   %ax,%ax

80104cc0 <isEmptyPriorityQueue>:
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
80104cc0:	a1 1c c6 10 80       	mov    0x8010c61c,%eax
static boolean isEmptyPriorityQueue() {
80104cc5:	55                   	push   %ebp
80104cc6:	89 e5                	mov    %esp,%ebp
}
80104cc8:	5d                   	pop    %ebp
	return !root;
80104cc9:	8b 00                	mov    (%eax),%eax
80104ccb:	85 c0                	test   %eax,%eax
80104ccd:	0f 94 c0             	sete   %al
80104cd0:	0f b6 c0             	movzbl %al,%eax
}
80104cd3:	c3                   	ret    
80104cd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104cda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104ce0 <getMinAccumulatorPriorityQueue>:
	return !root;
80104ce0:	a1 1c c6 10 80       	mov    0x8010c61c,%eax
80104ce5:	8b 10                	mov    (%eax),%edx
	
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
	if(isEmpty())
80104ce7:	85 d2                	test   %edx,%edx
80104ce9:	74 35                	je     80104d20 <getMinAccumulatorPriorityQueue+0x40>
static boolean getMinAccumulatorPriorityQueue(long long* pkey) {
80104ceb:	55                   	push   %ebp
80104cec:	89 e5                	mov    %esp,%ebp
80104cee:	53                   	push   %ebx
80104cef:	eb 09                	jmp    80104cfa <getMinAccumulatorPriorityQueue+0x1a>
80104cf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	while(minNode->left)
80104cf8:	89 c2                	mov    %eax,%edx
80104cfa:	8b 42 18             	mov    0x18(%edx),%eax
80104cfd:	85 c0                	test   %eax,%eax
80104cff:	75 f7                	jne    80104cf8 <getMinAccumulatorPriorityQueue+0x18>
	*pkey = getMinNode()->key;
80104d01:	8b 45 08             	mov    0x8(%ebp),%eax
80104d04:	8b 5a 04             	mov    0x4(%edx),%ebx
80104d07:	8b 0a                	mov    (%edx),%ecx
80104d09:	89 58 04             	mov    %ebx,0x4(%eax)
80104d0c:	89 08                	mov    %ecx,(%eax)
80104d0e:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104d13:	5b                   	pop    %ebx
80104d14:	5d                   	pop    %ebp
80104d15:	c3                   	ret    
80104d16:	8d 76 00             	lea    0x0(%esi),%esi
80104d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	if(isEmpty())
80104d20:	31 c0                	xor    %eax,%eax
}
80104d22:	c3                   	ret    
80104d23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d30 <isEmptyRoundRobinQueue>:
	return !first;
80104d30:	a1 18 c6 10 80       	mov    0x8010c618,%eax
static boolean isEmptyRoundRobinQueue() {
80104d35:	55                   	push   %ebp
80104d36:	89 e5                	mov    %esp,%ebp
}
80104d38:	5d                   	pop    %ebp
	return !first;
80104d39:	8b 00                	mov    (%eax),%eax
80104d3b:	85 c0                	test   %eax,%eax
80104d3d:	0f 94 c0             	sete   %al
80104d40:	0f b6 c0             	movzbl %al,%eax
}
80104d43:	c3                   	ret    
80104d44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104d50 <enqueueRoundRobinQueue>:
	if(!freeLinks)
80104d50:	a1 10 c6 10 80       	mov    0x8010c610,%eax
80104d55:	85 c0                	test   %eax,%eax
80104d57:	74 47                	je     80104da0 <enqueueRoundRobinQueue+0x50>
static boolean enqueueRoundRobinQueue(Proc *p) {
80104d59:	55                   	push   %ebp
	return roundRobinQ->enqueue(p);
80104d5a:	8b 0d 18 c6 10 80    	mov    0x8010c618,%ecx
	freeLinks = freeLinks->next;
80104d60:	8b 50 04             	mov    0x4(%eax),%edx
static boolean enqueueRoundRobinQueue(Proc *p) {
80104d63:	89 e5                	mov    %esp,%ebp
	ans->next = null;
80104d65:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
80104d6c:	89 15 10 c6 10 80    	mov    %edx,0x8010c610
	ans->p = p;
80104d72:	8b 55 08             	mov    0x8(%ebp),%edx
80104d75:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80104d77:	8b 11                	mov    (%ecx),%edx
80104d79:	85 d2                	test   %edx,%edx
80104d7b:	74 2b                	je     80104da8 <enqueueRoundRobinQueue+0x58>
	else last->next = link;
80104d7d:	8b 51 04             	mov    0x4(%ecx),%edx
80104d80:	89 42 04             	mov    %eax,0x4(%edx)
80104d83:	eb 05                	jmp    80104d8a <enqueueRoundRobinQueue+0x3a>
80104d85:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
80104d88:	89 d0                	mov    %edx,%eax
80104d8a:	8b 50 04             	mov    0x4(%eax),%edx
80104d8d:	85 d2                	test   %edx,%edx
80104d8f:	75 f7                	jne    80104d88 <enqueueRoundRobinQueue+0x38>
	last = link->getLast();
80104d91:	89 41 04             	mov    %eax,0x4(%ecx)
80104d94:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104d99:	5d                   	pop    %ebp
80104d9a:	c3                   	ret    
80104d9b:	90                   	nop
80104d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!freeLinks)
80104da0:	31 c0                	xor    %eax,%eax
}
80104da2:	c3                   	ret    
80104da3:	90                   	nop
80104da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
80104da8:	89 01                	mov    %eax,(%ecx)
80104daa:	eb de                	jmp    80104d8a <enqueueRoundRobinQueue+0x3a>
80104dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104db0 <dequeueRoundRobinQueue>:
	return roundRobinQ->dequeue();
80104db0:	8b 0d 18 c6 10 80    	mov    0x8010c618,%ecx
	return !first;
80104db6:	8b 11                	mov    (%ecx),%edx
	if(isEmpty())
80104db8:	85 d2                	test   %edx,%edx
80104dba:	74 3c                	je     80104df8 <dequeueRoundRobinQueue+0x48>
static Proc* dequeueRoundRobinQueue() {
80104dbc:	55                   	push   %ebp
80104dbd:	89 e5                	mov    %esp,%ebp
80104dbf:	83 ec 08             	sub    $0x8,%esp
80104dc2:	89 75 fc             	mov    %esi,-0x4(%ebp)
	link->next = freeLinks;
80104dc5:	8b 35 10 c6 10 80    	mov    0x8010c610,%esi
static Proc* dequeueRoundRobinQueue() {
80104dcb:	89 5d f8             	mov    %ebx,-0x8(%ebp)
	Link *next = first->next;
80104dce:	8b 5a 04             	mov    0x4(%edx),%ebx
	Proc *p = first->p;
80104dd1:	8b 02                	mov    (%edx),%eax
	link->next = freeLinks;
80104dd3:	89 72 04             	mov    %esi,0x4(%edx)
	freeLinks = link;
80104dd6:	89 15 10 c6 10 80    	mov    %edx,0x8010c610
	if(isEmpty())
80104ddc:	85 db                	test   %ebx,%ebx
	first = next;
80104dde:	89 19                	mov    %ebx,(%ecx)
	if(isEmpty())
80104de0:	75 07                	jne    80104de9 <dequeueRoundRobinQueue+0x39>
		last = null;
80104de2:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
}
80104de9:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104dec:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104def:	89 ec                	mov    %ebp,%esp
80104df1:	5d                   	pop    %ebp
80104df2:	c3                   	ret    
80104df3:	90                   	nop
80104df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		return null;
80104df8:	31 c0                	xor    %eax,%eax
}
80104dfa:	c3                   	ret    
80104dfb:	90                   	nop
80104dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104e00 <isEmptyRunningProcessHolder>:
	return !first;
80104e00:	a1 14 c6 10 80       	mov    0x8010c614,%eax
static boolean isEmptyRunningProcessHolder() {
80104e05:	55                   	push   %ebp
80104e06:	89 e5                	mov    %esp,%ebp
}
80104e08:	5d                   	pop    %ebp
	return !first;
80104e09:	8b 00                	mov    (%eax),%eax
80104e0b:	85 c0                	test   %eax,%eax
80104e0d:	0f 94 c0             	sete   %al
80104e10:	0f b6 c0             	movzbl %al,%eax
}
80104e13:	c3                   	ret    
80104e14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104e20 <addRunningProcessHolder>:
	if(!freeLinks)
80104e20:	a1 10 c6 10 80       	mov    0x8010c610,%eax
80104e25:	85 c0                	test   %eax,%eax
80104e27:	74 47                	je     80104e70 <addRunningProcessHolder+0x50>
static boolean addRunningProcessHolder(Proc* p) {
80104e29:	55                   	push   %ebp
	return runningProcHolder->enqueue(p);
80104e2a:	8b 0d 14 c6 10 80    	mov    0x8010c614,%ecx
	freeLinks = freeLinks->next;
80104e30:	8b 50 04             	mov    0x4(%eax),%edx
static boolean addRunningProcessHolder(Proc* p) {
80104e33:	89 e5                	mov    %esp,%ebp
	ans->next = null;
80104e35:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
80104e3c:	89 15 10 c6 10 80    	mov    %edx,0x8010c610
	ans->p = p;
80104e42:	8b 55 08             	mov    0x8(%ebp),%edx
80104e45:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80104e47:	8b 11                	mov    (%ecx),%edx
80104e49:	85 d2                	test   %edx,%edx
80104e4b:	74 2b                	je     80104e78 <addRunningProcessHolder+0x58>
	else last->next = link;
80104e4d:	8b 51 04             	mov    0x4(%ecx),%edx
80104e50:	89 42 04             	mov    %eax,0x4(%edx)
80104e53:	eb 05                	jmp    80104e5a <addRunningProcessHolder+0x3a>
80104e55:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
80104e58:	89 d0                	mov    %edx,%eax
80104e5a:	8b 50 04             	mov    0x4(%eax),%edx
80104e5d:	85 d2                	test   %edx,%edx
80104e5f:	75 f7                	jne    80104e58 <addRunningProcessHolder+0x38>
	last = link->getLast();
80104e61:	89 41 04             	mov    %eax,0x4(%ecx)
80104e64:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104e69:	5d                   	pop    %ebp
80104e6a:	c3                   	ret    
80104e6b:	90                   	nop
80104e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!freeLinks)
80104e70:	31 c0                	xor    %eax,%eax
}
80104e72:	c3                   	ret    
80104e73:	90                   	nop
80104e74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
80104e78:	89 01                	mov    %eax,(%ecx)
80104e7a:	eb de                	jmp    80104e5a <addRunningProcessHolder+0x3a>
80104e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104e80 <_ZL9allocNodeP4procx>:
static MapNode* allocNode(Proc *p, long long key) {
80104e80:	55                   	push   %ebp
80104e81:	89 e5                	mov    %esp,%ebp
80104e83:	56                   	push   %esi
80104e84:	53                   	push   %ebx
	if(!freeNodes)
80104e85:	8b 1d 0c c6 10 80    	mov    0x8010c60c,%ebx
80104e8b:	85 db                	test   %ebx,%ebx
80104e8d:	74 4d                	je     80104edc <_ZL9allocNodeP4procx+0x5c>
	ans->key = key;
80104e8f:	89 13                	mov    %edx,(%ebx)
	if(!freeLinks)
80104e91:	8b 15 10 c6 10 80    	mov    0x8010c610,%edx
	freeNodes = freeNodes->next;
80104e97:	8b 73 10             	mov    0x10(%ebx),%esi
	ans->key = key;
80104e9a:	89 4b 04             	mov    %ecx,0x4(%ebx)
	ans->next = null;
80104e9d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
	if(!freeLinks)
80104ea4:	85 d2                	test   %edx,%edx
	freeNodes = freeNodes->next;
80104ea6:	89 35 0c c6 10 80    	mov    %esi,0x8010c60c
	if(!freeLinks)
80104eac:	74 3f                	je     80104eed <_ZL9allocNodeP4procx+0x6d>
	freeLinks = freeLinks->next;
80104eae:	8b 4a 04             	mov    0x4(%edx),%ecx
	ans->p = p;
80104eb1:	89 02                	mov    %eax,(%edx)
	ans->next = null;
80104eb3:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
	if(isEmpty()) first = link;
80104eba:	8b 43 08             	mov    0x8(%ebx),%eax
	freeLinks = freeLinks->next;
80104ebd:	89 0d 10 c6 10 80    	mov    %ecx,0x8010c610
	if(isEmpty()) first = link;
80104ec3:	85 c0                	test   %eax,%eax
80104ec5:	74 21                	je     80104ee8 <_ZL9allocNodeP4procx+0x68>
	else last->next = link;
80104ec7:	8b 43 0c             	mov    0xc(%ebx),%eax
80104eca:	89 50 04             	mov    %edx,0x4(%eax)
80104ecd:	eb 03                	jmp    80104ed2 <_ZL9allocNodeP4procx+0x52>
80104ecf:	90                   	nop
	while(ans->next)
80104ed0:	89 ca                	mov    %ecx,%edx
80104ed2:	8b 4a 04             	mov    0x4(%edx),%ecx
80104ed5:	85 c9                	test   %ecx,%ecx
80104ed7:	75 f7                	jne    80104ed0 <_ZL9allocNodeP4procx+0x50>
	last = link->getLast();
80104ed9:	89 53 0c             	mov    %edx,0xc(%ebx)
}
80104edc:	89 d8                	mov    %ebx,%eax
80104ede:	5b                   	pop    %ebx
80104edf:	5e                   	pop    %esi
80104ee0:	5d                   	pop    %ebp
80104ee1:	c3                   	ret    
80104ee2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	if(isEmpty()) first = link;
80104ee8:	89 53 08             	mov    %edx,0x8(%ebx)
80104eeb:	eb e5                	jmp    80104ed2 <_ZL9allocNodeP4procx+0x52>
	node->parent = node->left = node->right = null;
80104eed:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
80104ef4:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
80104efb:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
	node->next = freeNodes;
80104f02:	89 73 10             	mov    %esi,0x10(%ebx)
	freeNodes = node;
80104f05:	89 1d 0c c6 10 80    	mov    %ebx,0x8010c60c
		return null;
80104f0b:	31 db                	xor    %ebx,%ebx
80104f0d:	eb cd                	jmp    80104edc <_ZL9allocNodeP4procx+0x5c>
80104f0f:	90                   	nop

80104f10 <_ZL8mymallocj>:
static char* mymalloc(uint size) {
80104f10:	55                   	push   %ebp
80104f11:	89 e5                	mov    %esp,%ebp
80104f13:	53                   	push   %ebx
80104f14:	89 c3                	mov    %eax,%ebx
80104f16:	83 ec 14             	sub    $0x14,%esp
	if(spaceLeft < size) {
80104f19:	8b 15 04 c6 10 80    	mov    0x8010c604,%edx
80104f1f:	39 c2                	cmp    %eax,%edx
80104f21:	73 26                	jae    80104f49 <_ZL8mymallocj+0x39>
		data = kalloc();
80104f23:	e8 88 d6 ff ff       	call   801025b0 <kalloc>
		memset(data, 0, PGSIZE);
80104f28:	ba 00 10 00 00       	mov    $0x1000,%edx
80104f2d:	31 c9                	xor    %ecx,%ecx
80104f2f:	89 54 24 08          	mov    %edx,0x8(%esp)
80104f33:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80104f37:	89 04 24             	mov    %eax,(%esp)
		data = kalloc();
80104f3a:	a3 08 c6 10 80       	mov    %eax,0x8010c608
		memset(data, 0, PGSIZE);
80104f3f:	e8 fc 0d 00 00       	call   80105d40 <memset>
80104f44:	ba 00 10 00 00       	mov    $0x1000,%edx
	char* ans = data;
80104f49:	a1 08 c6 10 80       	mov    0x8010c608,%eax
	spaceLeft -= size;
80104f4e:	29 da                	sub    %ebx,%edx
80104f50:	89 15 04 c6 10 80    	mov    %edx,0x8010c604
	data += size;
80104f56:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80104f59:	89 0d 08 c6 10 80    	mov    %ecx,0x8010c608
}
80104f5f:	83 c4 14             	add    $0x14,%esp
80104f62:	5b                   	pop    %ebx
80104f63:	5d                   	pop    %ebp
80104f64:	c3                   	ret    
80104f65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f70 <initSchedDS>:
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104f70:	55                   	push   %ebp
	data               = null;
80104f71:	31 c0                	xor    %eax,%eax
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104f73:	89 e5                	mov    %esp,%ebp
80104f75:	53                   	push   %ebx
	freeLinks = null;
80104f76:	bb 80 00 00 00       	mov    $0x80,%ebx
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104f7b:	83 ec 04             	sub    $0x4,%esp
	data               = null;
80104f7e:	a3 08 c6 10 80       	mov    %eax,0x8010c608
	spaceLeft          = 0u;
80104f83:	31 c0                	xor    %eax,%eax
80104f85:	a3 04 c6 10 80       	mov    %eax,0x8010c604
	priorityQ          = (Map*)mymalloc(sizeof(Map));
80104f8a:	b8 04 00 00 00       	mov    $0x4,%eax
80104f8f:	e8 7c ff ff ff       	call   80104f10 <_ZL8mymallocj>
80104f94:	a3 1c c6 10 80       	mov    %eax,0x8010c61c
	*priorityQ         = Map();
80104f99:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	roundRobinQ        = (LinkedList*)mymalloc(sizeof(LinkedList));
80104f9f:	b8 08 00 00 00       	mov    $0x8,%eax
80104fa4:	e8 67 ff ff ff       	call   80104f10 <_ZL8mymallocj>
80104fa9:	a3 18 c6 10 80       	mov    %eax,0x8010c618
	*roundRobinQ       = LinkedList();
80104fae:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104fb4:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	runningProcHolder  = (LinkedList*)mymalloc(sizeof(LinkedList));
80104fbb:	b8 08 00 00 00       	mov    $0x8,%eax
80104fc0:	e8 4b ff ff ff       	call   80104f10 <_ZL8mymallocj>
80104fc5:	a3 14 c6 10 80       	mov    %eax,0x8010c614
	*runningProcHolder = LinkedList();
80104fca:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104fd0:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = null;
80104fd7:	31 c0                	xor    %eax,%eax
80104fd9:	a3 10 c6 10 80       	mov    %eax,0x8010c610
80104fde:	66 90                	xchg   %ax,%ax
		Link *link = (Link*)mymalloc(sizeof(Link));
80104fe0:	b8 08 00 00 00       	mov    $0x8,%eax
80104fe5:	e8 26 ff ff ff       	call   80104f10 <_ZL8mymallocj>
		link->next = freeLinks;
80104fea:	8b 15 10 c6 10 80    	mov    0x8010c610,%edx
	for(int i = 0; i < NPROCLIST; ++i) {
80104ff0:	4b                   	dec    %ebx
		*link = Link();
80104ff1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		link->next = freeLinks;
80104ff7:	89 50 04             	mov    %edx,0x4(%eax)
		freeLinks = link;
80104ffa:	a3 10 c6 10 80       	mov    %eax,0x8010c610
	for(int i = 0; i < NPROCLIST; ++i) {
80104fff:	75 df                	jne    80104fe0 <initSchedDS+0x70>
	freeNodes = null;
80105001:	31 c0                	xor    %eax,%eax
80105003:	bb 80 00 00 00       	mov    $0x80,%ebx
80105008:	a3 0c c6 10 80       	mov    %eax,0x8010c60c
8010500d:	8d 76 00             	lea    0x0(%esi),%esi
		MapNode *node = (MapNode*)mymalloc(sizeof(MapNode));
80105010:	b8 20 00 00 00       	mov    $0x20,%eax
80105015:	e8 f6 fe ff ff       	call   80104f10 <_ZL8mymallocj>
		node->next = freeNodes;
8010501a:	8b 15 0c c6 10 80    	mov    0x8010c60c,%edx
	for(int i = 0; i < NPROCMAP; ++i) {
80105020:	4b                   	dec    %ebx
		*node = MapNode();
80105021:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80105028:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
8010502f:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
80105036:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
8010503d:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
		node->next = freeNodes;
80105044:	89 50 10             	mov    %edx,0x10(%eax)
		freeNodes = node;
80105047:	a3 0c c6 10 80       	mov    %eax,0x8010c60c
	for(int i = 0; i < NPROCMAP; ++i) {
8010504c:	75 c2                	jne    80105010 <initSchedDS+0xa0>
	pq.isEmpty                      = isEmptyPriorityQueue;
8010504e:	b8 c0 4c 10 80       	mov    $0x80104cc0,%eax
	pq.put                          = putPriorityQueue;
80105053:	ba 40 56 10 80       	mov    $0x80105640,%edx
	pq.isEmpty                      = isEmptyPriorityQueue;
80105058:	a3 ec c5 10 80       	mov    %eax,0x8010c5ec
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
8010505d:	b8 00 58 10 80       	mov    $0x80105800,%eax
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
80105062:	b9 e0 4c 10 80       	mov    $0x80104ce0,%ecx
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
80105067:	a3 fc c5 10 80       	mov    %eax,0x8010c5fc
	pq.extractProc                  = extractProcPriorityQueue;
8010506c:	b8 e0 58 10 80       	mov    $0x801058e0,%eax
	pq.extractMin                   = extractMinPriorityQueue;
80105071:	bb 60 57 10 80       	mov    $0x80105760,%ebx
	pq.extractProc                  = extractProcPriorityQueue;
80105076:	a3 00 c6 10 80       	mov    %eax,0x8010c600
	rrq.isEmpty                     = isEmptyRoundRobinQueue;
8010507b:	b8 30 4d 10 80       	mov    $0x80104d30,%eax
80105080:	a3 dc c5 10 80       	mov    %eax,0x8010c5dc
	rrq.enqueue                     = enqueueRoundRobinQueue;
80105085:	b8 50 4d 10 80       	mov    $0x80104d50,%eax
8010508a:	a3 e0 c5 10 80       	mov    %eax,0x8010c5e0
	rrq.dequeue                     = dequeueRoundRobinQueue;
8010508f:	b8 b0 4d 10 80       	mov    $0x80104db0,%eax
80105094:	a3 e4 c5 10 80       	mov    %eax,0x8010c5e4
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
80105099:	b8 70 53 10 80       	mov    $0x80105370,%eax
	pq.put                          = putPriorityQueue;
8010509e:	89 15 f0 c5 10 80    	mov    %edx,0x8010c5f0
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
801050a4:	ba 00 4e 10 80       	mov    $0x80104e00,%edx
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
801050a9:	89 0d f4 c5 10 80    	mov    %ecx,0x8010c5f4
	rpholder.add                    = addRunningProcessHolder;
801050af:	b9 20 4e 10 80       	mov    $0x80104e20,%ecx
	pq.extractMin                   = extractMinPriorityQueue;
801050b4:	89 1d f8 c5 10 80    	mov    %ebx,0x8010c5f8
	rpholder.remove                 = removeRunningProcessHolder;
801050ba:	bb d0 52 10 80       	mov    $0x801052d0,%ebx
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
801050bf:	a3 e8 c5 10 80       	mov    %eax,0x8010c5e8
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
801050c4:	b8 00 54 10 80       	mov    $0x80105400,%eax
	rpholder.remove                 = removeRunningProcessHolder;
801050c9:	89 1d d4 c5 10 80    	mov    %ebx,0x8010c5d4
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
801050cf:	89 15 cc c5 10 80    	mov    %edx,0x8010c5cc
	rpholder.add                    = addRunningProcessHolder;
801050d5:	89 0d d0 c5 10 80    	mov    %ecx,0x8010c5d0
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
801050db:	a3 d8 c5 10 80       	mov    %eax,0x8010c5d8
}
801050e0:	58                   	pop    %eax
801050e1:	5b                   	pop    %ebx
801050e2:	5d                   	pop    %ebp
801050e3:	c3                   	ret    
801050e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801050ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801050f0 <_ZN4Link7getLastEv>:
Link* Link::getLast() {
801050f0:	55                   	push   %ebp
801050f1:	89 e5                	mov    %esp,%ebp
801050f3:	8b 45 08             	mov    0x8(%ebp),%eax
801050f6:	eb 0a                	jmp    80105102 <_ZN4Link7getLastEv+0x12>
801050f8:	90                   	nop
801050f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105100:	89 d0                	mov    %edx,%eax
	while(ans->next)
80105102:	8b 50 04             	mov    0x4(%eax),%edx
80105105:	85 d2                	test   %edx,%edx
80105107:	75 f7                	jne    80105100 <_ZN4Link7getLastEv+0x10>
}
80105109:	5d                   	pop    %ebp
8010510a:	c3                   	ret    
8010510b:	90                   	nop
8010510c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105110 <_ZN10LinkedList7isEmptyEv>:
bool LinkedList::isEmpty() {
80105110:	55                   	push   %ebp
80105111:	89 e5                	mov    %esp,%ebp
	return !first;
80105113:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105116:	5d                   	pop    %ebp
	return !first;
80105117:	8b 00                	mov    (%eax),%eax
80105119:	85 c0                	test   %eax,%eax
8010511b:	0f 94 c0             	sete   %al
}
8010511e:	c3                   	ret    
8010511f:	90                   	nop

80105120 <_ZN10LinkedList6appendEP4Link>:
void LinkedList::append(Link *link) {
80105120:	55                   	push   %ebp
80105121:	89 e5                	mov    %esp,%ebp
80105123:	8b 55 0c             	mov    0xc(%ebp),%edx
80105126:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!link)
80105129:	85 d2                	test   %edx,%edx
8010512b:	74 1f                	je     8010514c <_ZN10LinkedList6appendEP4Link+0x2c>
	if(isEmpty()) first = link;
8010512d:	8b 01                	mov    (%ecx),%eax
8010512f:	85 c0                	test   %eax,%eax
80105131:	74 1d                	je     80105150 <_ZN10LinkedList6appendEP4Link+0x30>
	else last->next = link;
80105133:	8b 41 04             	mov    0x4(%ecx),%eax
80105136:	89 50 04             	mov    %edx,0x4(%eax)
80105139:	eb 07                	jmp    80105142 <_ZN10LinkedList6appendEP4Link+0x22>
8010513b:	90                   	nop
8010513c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	while(ans->next)
80105140:	89 c2                	mov    %eax,%edx
80105142:	8b 42 04             	mov    0x4(%edx),%eax
80105145:	85 c0                	test   %eax,%eax
80105147:	75 f7                	jne    80105140 <_ZN10LinkedList6appendEP4Link+0x20>
	last = link->getLast();
80105149:	89 51 04             	mov    %edx,0x4(%ecx)
}
8010514c:	5d                   	pop    %ebp
8010514d:	c3                   	ret    
8010514e:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
80105150:	89 11                	mov    %edx,(%ecx)
80105152:	eb ee                	jmp    80105142 <_ZN10LinkedList6appendEP4Link+0x22>
80105154:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010515a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105160 <_ZN10LinkedList7enqueueEP4proc>:
	if(!freeLinks)
80105160:	a1 10 c6 10 80       	mov    0x8010c610,%eax
bool LinkedList::enqueue(Proc *p) {
80105165:	55                   	push   %ebp
80105166:	89 e5                	mov    %esp,%ebp
80105168:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!freeLinks)
8010516b:	85 c0                	test   %eax,%eax
8010516d:	74 41                	je     801051b0 <_ZN10LinkedList7enqueueEP4proc+0x50>
	freeLinks = freeLinks->next;
8010516f:	8b 50 04             	mov    0x4(%eax),%edx
	ans->next = null;
80105172:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
80105179:	89 15 10 c6 10 80    	mov    %edx,0x8010c610
	ans->p = p;
8010517f:	8b 55 0c             	mov    0xc(%ebp),%edx
80105182:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80105184:	8b 11                	mov    (%ecx),%edx
80105186:	85 d2                	test   %edx,%edx
80105188:	74 2e                	je     801051b8 <_ZN10LinkedList7enqueueEP4proc+0x58>
	else last->next = link;
8010518a:	8b 51 04             	mov    0x4(%ecx),%edx
8010518d:	89 42 04             	mov    %eax,0x4(%edx)
80105190:	eb 08                	jmp    8010519a <_ZN10LinkedList7enqueueEP4proc+0x3a>
80105192:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	while(ans->next)
80105198:	89 d0                	mov    %edx,%eax
8010519a:	8b 50 04             	mov    0x4(%eax),%edx
8010519d:	85 d2                	test   %edx,%edx
8010519f:	75 f7                	jne    80105198 <_ZN10LinkedList7enqueueEP4proc+0x38>
	last = link->getLast();
801051a1:	89 41 04             	mov    %eax,0x4(%ecx)
	return true;
801051a4:	b0 01                	mov    $0x1,%al
}
801051a6:	5d                   	pop    %ebp
801051a7:	c3                   	ret    
801051a8:	90                   	nop
801051a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return false;
801051b0:	31 c0                	xor    %eax,%eax
}
801051b2:	5d                   	pop    %ebp
801051b3:	c3                   	ret    
801051b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
801051b8:	89 01                	mov    %eax,(%ecx)
801051ba:	eb de                	jmp    8010519a <_ZN10LinkedList7enqueueEP4proc+0x3a>
801051bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801051c0 <_ZN10LinkedList7dequeueEv>:
Proc* LinkedList::dequeue() {
801051c0:	55                   	push   %ebp
801051c1:	89 e5                	mov    %esp,%ebp
801051c3:	83 ec 08             	sub    $0x8,%esp
801051c6:	8b 4d 08             	mov    0x8(%ebp),%ecx
801051c9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801051cc:	89 75 fc             	mov    %esi,-0x4(%ebp)
	return !first;
801051cf:	8b 11                	mov    (%ecx),%edx
	if(isEmpty())
801051d1:	85 d2                	test   %edx,%edx
801051d3:	74 2b                	je     80105200 <_ZN10LinkedList7dequeueEv+0x40>
	Link *next = first->next;
801051d5:	8b 5a 04             	mov    0x4(%edx),%ebx
	link->next = freeLinks;
801051d8:	8b 35 10 c6 10 80    	mov    0x8010c610,%esi
	Proc *p = first->p;
801051de:	8b 02                	mov    (%edx),%eax
	freeLinks = link;
801051e0:	89 15 10 c6 10 80    	mov    %edx,0x8010c610
	if(isEmpty())
801051e6:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
801051e8:	89 72 04             	mov    %esi,0x4(%edx)
	first = next;
801051eb:	89 19                	mov    %ebx,(%ecx)
	if(isEmpty())
801051ed:	75 07                	jne    801051f6 <_ZN10LinkedList7dequeueEv+0x36>
		last = null;
801051ef:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
}
801051f6:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801051f9:	8b 75 fc             	mov    -0x4(%ebp),%esi
801051fc:	89 ec                	mov    %ebp,%esp
801051fe:	5d                   	pop    %ebp
801051ff:	c3                   	ret    
		return null;
80105200:	31 c0                	xor    %eax,%eax
80105202:	eb f2                	jmp    801051f6 <_ZN10LinkedList7dequeueEv+0x36>
80105204:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010520a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105210 <_ZN10LinkedList6removeEP4proc>:
bool LinkedList::remove(Proc *p) {
80105210:	55                   	push   %ebp
80105211:	89 e5                	mov    %esp,%ebp
80105213:	56                   	push   %esi
80105214:	8b 75 08             	mov    0x8(%ebp),%esi
80105217:	53                   	push   %ebx
80105218:	8b 4d 0c             	mov    0xc(%ebp),%ecx
	return !first;
8010521b:	8b 1e                	mov    (%esi),%ebx
	if(isEmpty())
8010521d:	85 db                	test   %ebx,%ebx
8010521f:	74 2f                	je     80105250 <_ZN10LinkedList6removeEP4proc+0x40>
	if(first->p == p) {
80105221:	39 0b                	cmp    %ecx,(%ebx)
80105223:	8b 53 04             	mov    0x4(%ebx),%edx
80105226:	74 70                	je     80105298 <_ZN10LinkedList6removeEP4proc+0x88>
	while(cur) {
80105228:	85 d2                	test   %edx,%edx
8010522a:	74 24                	je     80105250 <_ZN10LinkedList6removeEP4proc+0x40>
		if(cur->p == p) {
8010522c:	3b 0a                	cmp    (%edx),%ecx
8010522e:	66 90                	xchg   %ax,%ax
80105230:	75 0c                	jne    8010523e <_ZN10LinkedList6removeEP4proc+0x2e>
80105232:	eb 2c                	jmp    80105260 <_ZN10LinkedList6removeEP4proc+0x50>
80105234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105238:	39 08                	cmp    %ecx,(%eax)
8010523a:	74 34                	je     80105270 <_ZN10LinkedList6removeEP4proc+0x60>
8010523c:	89 c2                	mov    %eax,%edx
		cur = cur->next;
8010523e:	8b 42 04             	mov    0x4(%edx),%eax
	while(cur) {
80105241:	85 c0                	test   %eax,%eax
80105243:	75 f3                	jne    80105238 <_ZN10LinkedList6removeEP4proc+0x28>
}
80105245:	5b                   	pop    %ebx
80105246:	5e                   	pop    %esi
80105247:	5d                   	pop    %ebp
80105248:	c3                   	ret    
80105249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105250:	5b                   	pop    %ebx
		return false;
80105251:	31 c0                	xor    %eax,%eax
}
80105253:	5e                   	pop    %esi
80105254:	5d                   	pop    %ebp
80105255:	c3                   	ret    
80105256:	8d 76 00             	lea    0x0(%esi),%esi
80105259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		if(cur->p == p) {
80105260:	89 d0                	mov    %edx,%eax
80105262:	89 da                	mov    %ebx,%edx
80105264:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010526a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
			prev->next = cur->next;
80105270:	8b 48 04             	mov    0x4(%eax),%ecx
80105273:	89 4a 04             	mov    %ecx,0x4(%edx)
			if(!(cur->next)) //removes the last link
80105276:	8b 48 04             	mov    0x4(%eax),%ecx
80105279:	85 c9                	test   %ecx,%ecx
8010527b:	74 43                	je     801052c0 <_ZN10LinkedList6removeEP4proc+0xb0>
	link->next = freeLinks;
8010527d:	8b 15 10 c6 10 80    	mov    0x8010c610,%edx
	freeLinks = link;
80105283:	a3 10 c6 10 80       	mov    %eax,0x8010c610
	link->next = freeLinks;
80105288:	89 50 04             	mov    %edx,0x4(%eax)
			return true;
8010528b:	b0 01                	mov    $0x1,%al
}
8010528d:	5b                   	pop    %ebx
8010528e:	5e                   	pop    %esi
8010528f:	5d                   	pop    %ebp
80105290:	c3                   	ret    
80105291:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	link->next = freeLinks;
80105298:	a1 10 c6 10 80       	mov    0x8010c610,%eax
	if(isEmpty())
8010529d:	85 d2                	test   %edx,%edx
	freeLinks = link;
8010529f:	89 1d 10 c6 10 80    	mov    %ebx,0x8010c610
	link->next = freeLinks;
801052a5:	89 43 04             	mov    %eax,0x4(%ebx)
		return true;
801052a8:	b0 01                	mov    $0x1,%al
	first = next;
801052aa:	89 16                	mov    %edx,(%esi)
	if(isEmpty())
801052ac:	75 97                	jne    80105245 <_ZN10LinkedList6removeEP4proc+0x35>
		last = null;
801052ae:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%esi)
801052b5:	eb 8e                	jmp    80105245 <_ZN10LinkedList6removeEP4proc+0x35>
801052b7:	89 f6                	mov    %esi,%esi
801052b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
				last = prev;
801052c0:	89 56 04             	mov    %edx,0x4(%esi)
801052c3:	eb b8                	jmp    8010527d <_ZN10LinkedList6removeEP4proc+0x6d>
801052c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801052c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801052d0 <removeRunningProcessHolder>:
static boolean removeRunningProcessHolder(Proc* p) {
801052d0:	55                   	push   %ebp
801052d1:	89 e5                	mov    %esp,%ebp
801052d3:	83 ec 08             	sub    $0x8,%esp
	return runningProcHolder->remove(p);
801052d6:	8b 45 08             	mov    0x8(%ebp),%eax
801052d9:	89 44 24 04          	mov    %eax,0x4(%esp)
801052dd:	a1 14 c6 10 80       	mov    0x8010c614,%eax
801052e2:	89 04 24             	mov    %eax,(%esp)
801052e5:	e8 26 ff ff ff       	call   80105210 <_ZN10LinkedList6removeEP4proc>
}
801052ea:	c9                   	leave  
	return runningProcHolder->remove(p);
801052eb:	0f b6 c0             	movzbl %al,%eax
}
801052ee:	c3                   	ret    
801052ef:	90                   	nop

801052f0 <_ZN10LinkedList8transferEv>:
	if(!priorityQ->isEmpty())
801052f0:	8b 15 1c c6 10 80    	mov    0x8010c61c,%edx
		return false;
801052f6:	31 c0                	xor    %eax,%eax
bool LinkedList::transfer() {
801052f8:	55                   	push   %ebp
801052f9:	89 e5                	mov    %esp,%ebp
801052fb:	53                   	push   %ebx
801052fc:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!priorityQ->isEmpty())
801052ff:	8b 1a                	mov    (%edx),%ebx
80105301:	85 db                	test   %ebx,%ebx
80105303:	74 0b                	je     80105310 <_ZN10LinkedList8transferEv+0x20>
}
80105305:	5b                   	pop    %ebx
80105306:	5d                   	pop    %ebp
80105307:	c3                   	ret    
80105308:	90                   	nop
80105309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	if(!isEmpty()) {
80105310:	8b 19                	mov    (%ecx),%ebx
80105312:	85 db                	test   %ebx,%ebx
80105314:	74 4a                	je     80105360 <_ZN10LinkedList8transferEv+0x70>
	if(!freeNodes)
80105316:	8b 1d 0c c6 10 80    	mov    0x8010c60c,%ebx
8010531c:	85 db                	test   %ebx,%ebx
8010531e:	74 e5                	je     80105305 <_ZN10LinkedList8transferEv+0x15>
	freeNodes = freeNodes->next;
80105320:	8b 43 10             	mov    0x10(%ebx),%eax
	ans->key = key;
80105323:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
	ans->next = null;
80105329:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
	ans->key = key;
80105330:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
	freeNodes = freeNodes->next;
80105337:	a3 0c c6 10 80       	mov    %eax,0x8010c60c
		node->listOfProcs.first = first;
8010533c:	8b 01                	mov    (%ecx),%eax
8010533e:	89 43 08             	mov    %eax,0x8(%ebx)
		node->listOfProcs.last = last;
80105341:	8b 41 04             	mov    0x4(%ecx),%eax
80105344:	89 43 0c             	mov    %eax,0xc(%ebx)
	return true;
80105347:	b0 01                	mov    $0x1,%al
		first = last = null;
80105349:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
80105350:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
		priorityQ->root = node;
80105356:	89 1a                	mov    %ebx,(%edx)
}
80105358:	5b                   	pop    %ebx
80105359:	5d                   	pop    %ebp
8010535a:	c3                   	ret    
8010535b:	90                   	nop
8010535c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	return true;
80105360:	b0 01                	mov    $0x1,%al
80105362:	eb a1                	jmp    80105305 <_ZN10LinkedList8transferEv+0x15>
80105364:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010536a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105370 <switchToPriorityQueuePolicyRoundRobinQueue>:
static boolean switchToPriorityQueuePolicyRoundRobinQueue() {
80105370:	55                   	push   %ebp
80105371:	89 e5                	mov    %esp,%ebp
80105373:	83 ec 04             	sub    $0x4,%esp
	return roundRobinQ->transfer();
80105376:	a1 18 c6 10 80       	mov    0x8010c618,%eax
8010537b:	89 04 24             	mov    %eax,(%esp)
8010537e:	e8 6d ff ff ff       	call   801052f0 <_ZN10LinkedList8transferEv>
}
80105383:	c9                   	leave  
	return roundRobinQ->transfer();
80105384:	0f b6 c0             	movzbl %al,%eax
}
80105387:	c3                   	ret    
80105388:	90                   	nop
80105389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105390 <_ZN10LinkedList9getMinKeyEPx>:
bool LinkedList::getMinKey(long long *pkey) {
80105390:	55                   	push   %ebp
80105391:	31 c0                	xor    %eax,%eax
80105393:	89 e5                	mov    %esp,%ebp
80105395:	57                   	push   %edi
80105396:	56                   	push   %esi
80105397:	53                   	push   %ebx
80105398:	83 ec 1c             	sub    $0x1c,%esp
8010539b:	8b 7d 08             	mov    0x8(%ebp),%edi
	return !first;
8010539e:	8b 17                	mov    (%edi),%edx
	if(isEmpty())
801053a0:	85 d2                	test   %edx,%edx
801053a2:	74 41                	je     801053e5 <_ZN10LinkedList9getMinKeyEPx+0x55>
	long long minKey = getAccumulator(first->p);
801053a4:	8b 02                	mov    (%edx),%eax
801053a6:	89 04 24             	mov    %eax,(%esp)
801053a9:	e8 12 e5 ff ff       	call   801038c0 <getAccumulator>
	forEach([&](Proc *p) {
801053ae:	8b 3f                	mov    (%edi),%edi
	void append(Link *link); //appends the given list to the queue. No allocations always succeeds.
	
	template<typename Func>
	void forEach(const Func& accept) { //for-each loop. gets a function that applies the procin each link node.
		Link *link = first;
		while(link) {
801053b0:	85 ff                	test   %edi,%edi
	long long minKey = getAccumulator(first->p);
801053b2:	89 c6                	mov    %eax,%esi
801053b4:	89 d3                	mov    %edx,%ebx
801053b6:	74 23                	je     801053db <_ZN10LinkedList9getMinKeyEPx+0x4b>
801053b8:	90                   	nop
801053b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		long long key = getAccumulator(p);
801053c0:	8b 07                	mov    (%edi),%eax
801053c2:	89 04 24             	mov    %eax,(%esp)
801053c5:	e8 f6 e4 ff ff       	call   801038c0 <getAccumulator>
801053ca:	39 d3                	cmp    %edx,%ebx
801053cc:	7c 06                	jl     801053d4 <_ZN10LinkedList9getMinKeyEPx+0x44>
801053ce:	7f 20                	jg     801053f0 <_ZN10LinkedList9getMinKeyEPx+0x60>
801053d0:	39 c6                	cmp    %eax,%esi
801053d2:	77 1c                	ja     801053f0 <_ZN10LinkedList9getMinKeyEPx+0x60>
			accept(link->p);
			link = link->next;
801053d4:	8b 7f 04             	mov    0x4(%edi),%edi
		while(link) {
801053d7:	85 ff                	test   %edi,%edi
801053d9:	75 e5                	jne    801053c0 <_ZN10LinkedList9getMinKeyEPx+0x30>
	*pkey = minKey;
801053db:	8b 45 0c             	mov    0xc(%ebp),%eax
801053de:	89 30                	mov    %esi,(%eax)
801053e0:	89 58 04             	mov    %ebx,0x4(%eax)
	return true;
801053e3:	b0 01                	mov    $0x1,%al
}
801053e5:	83 c4 1c             	add    $0x1c,%esp
801053e8:	5b                   	pop    %ebx
801053e9:	5e                   	pop    %esi
801053ea:	5f                   	pop    %edi
801053eb:	5d                   	pop    %ebp
801053ec:	c3                   	ret    
801053ed:	8d 76 00             	lea    0x0(%esi),%esi
			link = link->next;
801053f0:	8b 7f 04             	mov    0x4(%edi),%edi
801053f3:	89 c6                	mov    %eax,%esi
801053f5:	89 d3                	mov    %edx,%ebx
		while(link) {
801053f7:	85 ff                	test   %edi,%edi
801053f9:	75 c5                	jne    801053c0 <_ZN10LinkedList9getMinKeyEPx+0x30>
801053fb:	eb de                	jmp    801053db <_ZN10LinkedList9getMinKeyEPx+0x4b>
801053fd:	8d 76 00             	lea    0x0(%esi),%esi

80105400 <getMinAccumulatorRunningProcessHolder>:
static boolean getMinAccumulatorRunningProcessHolder(long long *pkey) {
80105400:	55                   	push   %ebp
80105401:	89 e5                	mov    %esp,%ebp
80105403:	83 ec 18             	sub    $0x18,%esp
	return runningProcHolder->getMinKey(pkey);
80105406:	8b 45 08             	mov    0x8(%ebp),%eax
80105409:	89 44 24 04          	mov    %eax,0x4(%esp)
8010540d:	a1 14 c6 10 80       	mov    0x8010c614,%eax
80105412:	89 04 24             	mov    %eax,(%esp)
80105415:	e8 76 ff ff ff       	call   80105390 <_ZN10LinkedList9getMinKeyEPx>
}
8010541a:	c9                   	leave  
	return runningProcHolder->getMinKey(pkey);
8010541b:	0f b6 c0             	movzbl %al,%eax
}
8010541e:	c3                   	ret    
8010541f:	90                   	nop

80105420 <_ZN7MapNode7isEmptyEv>:
bool MapNode::isEmpty() {
80105420:	55                   	push   %ebp
80105421:	89 e5                	mov    %esp,%ebp
	return !first;
80105423:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105426:	5d                   	pop    %ebp
	return !first;
80105427:	8b 40 08             	mov    0x8(%eax),%eax
8010542a:	85 c0                	test   %eax,%eax
8010542c:	0f 94 c0             	sete   %al
}
8010542f:	c3                   	ret    

80105430 <_ZN7MapNode3putEP4proc>:
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
80105430:	55                   	push   %ebp
80105431:	89 e5                	mov    %esp,%ebp
80105433:	57                   	push   %edi
80105434:	56                   	push   %esi
80105435:	53                   	push   %ebx
80105436:	83 ec 2c             	sub    $0x2c,%esp
	long long key = getAccumulator(p);
80105439:	8b 45 0c             	mov    0xc(%ebp),%eax
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
8010543c:	8b 5d 08             	mov    0x8(%ebp),%ebx
	long long key = getAccumulator(p);
8010543f:	89 04 24             	mov    %eax,(%esp)
80105442:	e8 79 e4 ff ff       	call   801038c0 <getAccumulator>
80105447:	89 d1                	mov    %edx,%ecx
80105449:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010544c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		if(key == node->key)
80105450:	8b 13                	mov    (%ebx),%edx
80105452:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80105455:	8b 43 04             	mov    0x4(%ebx),%eax
80105458:	31 d7                	xor    %edx,%edi
8010545a:	89 fe                	mov    %edi,%esi
8010545c:	89 c7                	mov    %eax,%edi
8010545e:	31 cf                	xor    %ecx,%edi
80105460:	09 fe                	or     %edi,%esi
80105462:	74 4c                	je     801054b0 <_ZN7MapNode3putEP4proc+0x80>
		else if(key < node->key) { //left
80105464:	39 c8                	cmp    %ecx,%eax
80105466:	7c 20                	jl     80105488 <_ZN7MapNode3putEP4proc+0x58>
80105468:	7f 08                	jg     80105472 <_ZN7MapNode3putEP4proc+0x42>
8010546a:	3b 55 e4             	cmp    -0x1c(%ebp),%edx
8010546d:	8d 76 00             	lea    0x0(%esi),%esi
80105470:	76 16                	jbe    80105488 <_ZN7MapNode3putEP4proc+0x58>
			if(node->left)
80105472:	8b 43 18             	mov    0x18(%ebx),%eax
80105475:	85 c0                	test   %eax,%eax
80105477:	0f 84 83 00 00 00    	je     80105500 <_ZN7MapNode3putEP4proc+0xd0>
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
8010547d:	89 c3                	mov    %eax,%ebx
8010547f:	eb cf                	jmp    80105450 <_ZN7MapNode3putEP4proc+0x20>
80105481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			if(node->right)
80105488:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010548b:	85 c0                	test   %eax,%eax
8010548d:	75 ee                	jne    8010547d <_ZN7MapNode3putEP4proc+0x4d>
8010548f:	8b 75 e4             	mov    -0x1c(%ebp),%esi
				node->right = allocNode(p, key);
80105492:	8b 45 0c             	mov    0xc(%ebp),%eax
80105495:	89 f2                	mov    %esi,%edx
80105497:	e8 e4 f9 ff ff       	call   80104e80 <_ZL9allocNodeP4procx>
				if(node->right) {
8010549c:	85 c0                	test   %eax,%eax
				node->right = allocNode(p, key);
8010549e:	89 43 1c             	mov    %eax,0x1c(%ebx)
				if(node->right) {
801054a1:	74 71                	je     80105514 <_ZN7MapNode3putEP4proc+0xe4>
					node->right->parent = node;
801054a3:	89 58 14             	mov    %ebx,0x14(%eax)
}
801054a6:	83 c4 2c             	add    $0x2c,%esp
					return true;
801054a9:	b0 01                	mov    $0x1,%al
}
801054ab:	5b                   	pop    %ebx
801054ac:	5e                   	pop    %esi
801054ad:	5f                   	pop    %edi
801054ae:	5d                   	pop    %ebp
801054af:	c3                   	ret    
	if(!freeLinks)
801054b0:	a1 10 c6 10 80       	mov    0x8010c610,%eax
801054b5:	85 c0                	test   %eax,%eax
801054b7:	74 5b                	je     80105514 <_ZN7MapNode3putEP4proc+0xe4>
	ans->p = p;
801054b9:	8b 75 0c             	mov    0xc(%ebp),%esi
	freeLinks = freeLinks->next;
801054bc:	8b 50 04             	mov    0x4(%eax),%edx
	ans->next = null;
801054bf:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	ans->p = p;
801054c6:	89 30                	mov    %esi,(%eax)
	freeLinks = freeLinks->next;
801054c8:	89 15 10 c6 10 80    	mov    %edx,0x8010c610
	if(isEmpty()) first = link;
801054ce:	8b 53 08             	mov    0x8(%ebx),%edx
801054d1:	85 d2                	test   %edx,%edx
801054d3:	74 4b                	je     80105520 <_ZN7MapNode3putEP4proc+0xf0>
	else last->next = link;
801054d5:	8b 53 0c             	mov    0xc(%ebx),%edx
801054d8:	89 42 04             	mov    %eax,0x4(%edx)
801054db:	eb 05                	jmp    801054e2 <_ZN7MapNode3putEP4proc+0xb2>
801054dd:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
801054e0:	89 d0                	mov    %edx,%eax
801054e2:	8b 50 04             	mov    0x4(%eax),%edx
801054e5:	85 d2                	test   %edx,%edx
801054e7:	75 f7                	jne    801054e0 <_ZN7MapNode3putEP4proc+0xb0>
	last = link->getLast();
801054e9:	89 43 0c             	mov    %eax,0xc(%ebx)
}
801054ec:	83 c4 2c             	add    $0x2c,%esp
	return true;
801054ef:	b0 01                	mov    $0x1,%al
}
801054f1:	5b                   	pop    %ebx
801054f2:	5e                   	pop    %esi
801054f3:	5f                   	pop    %edi
801054f4:	5d                   	pop    %ebp
801054f5:	c3                   	ret    
801054f6:	8d 76 00             	lea    0x0(%esi),%esi
801054f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105500:	8b 75 e4             	mov    -0x1c(%ebp),%esi
				node->left = allocNode(p, key);
80105503:	8b 45 0c             	mov    0xc(%ebp),%eax
80105506:	89 f2                	mov    %esi,%edx
80105508:	e8 73 f9 ff ff       	call   80104e80 <_ZL9allocNodeP4procx>
				if(node->left) {
8010550d:	85 c0                	test   %eax,%eax
				node->left = allocNode(p, key);
8010550f:	89 43 18             	mov    %eax,0x18(%ebx)
				if(node->left) {
80105512:	75 8f                	jne    801054a3 <_ZN7MapNode3putEP4proc+0x73>
}
80105514:	83 c4 2c             	add    $0x2c,%esp
		return false;
80105517:	31 c0                	xor    %eax,%eax
}
80105519:	5b                   	pop    %ebx
8010551a:	5e                   	pop    %esi
8010551b:	5f                   	pop    %edi
8010551c:	5d                   	pop    %ebp
8010551d:	c3                   	ret    
8010551e:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
80105520:	89 43 08             	mov    %eax,0x8(%ebx)
80105523:	eb bd                	jmp    801054e2 <_ZN7MapNode3putEP4proc+0xb2>
80105525:	90                   	nop
80105526:	8d 76 00             	lea    0x0(%esi),%esi
80105529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105530 <_ZN7MapNode10getMinNodeEv>:
MapNode* MapNode::getMinNode() { //no recursion.
80105530:	55                   	push   %ebp
80105531:	89 e5                	mov    %esp,%ebp
80105533:	8b 45 08             	mov    0x8(%ebp),%eax
80105536:	eb 0a                	jmp    80105542 <_ZN7MapNode10getMinNodeEv+0x12>
80105538:	90                   	nop
80105539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105540:	89 d0                	mov    %edx,%eax
	while(minNode->left)
80105542:	8b 50 18             	mov    0x18(%eax),%edx
80105545:	85 d2                	test   %edx,%edx
80105547:	75 f7                	jne    80105540 <_ZN7MapNode10getMinNodeEv+0x10>
}
80105549:	5d                   	pop    %ebp
8010554a:	c3                   	ret    
8010554b:	90                   	nop
8010554c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105550 <_ZN7MapNode9getMinKeyEPx>:
void MapNode::getMinKey(long long *pkey) {
80105550:	55                   	push   %ebp
80105551:	89 e5                	mov    %esp,%ebp
80105553:	8b 55 08             	mov    0x8(%ebp),%edx
80105556:	53                   	push   %ebx
80105557:	eb 09                	jmp    80105562 <_ZN7MapNode9getMinKeyEPx+0x12>
80105559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	while(minNode->left)
80105560:	89 c2                	mov    %eax,%edx
80105562:	8b 42 18             	mov    0x18(%edx),%eax
80105565:	85 c0                	test   %eax,%eax
80105567:	75 f7                	jne    80105560 <_ZN7MapNode9getMinKeyEPx+0x10>
	*pkey = getMinNode()->key;
80105569:	8b 5a 04             	mov    0x4(%edx),%ebx
8010556c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010556f:	8b 0a                	mov    (%edx),%ecx
80105571:	89 58 04             	mov    %ebx,0x4(%eax)
80105574:	89 08                	mov    %ecx,(%eax)
}
80105576:	5b                   	pop    %ebx
80105577:	5d                   	pop    %ebp
80105578:	c3                   	ret    
80105579:	90                   	nop
8010557a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105580 <_ZN7MapNode7dequeueEv>:
Proc* MapNode::dequeue() {
80105580:	55                   	push   %ebp
80105581:	89 e5                	mov    %esp,%ebp
80105583:	83 ec 08             	sub    $0x8,%esp
80105586:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105589:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010558c:	89 75 fc             	mov    %esi,-0x4(%ebp)
	return !first;
8010558f:	8b 51 08             	mov    0x8(%ecx),%edx
	if(isEmpty())
80105592:	85 d2                	test   %edx,%edx
80105594:	74 32                	je     801055c8 <_ZN7MapNode7dequeueEv+0x48>
	Link *next = first->next;
80105596:	8b 5a 04             	mov    0x4(%edx),%ebx
	link->next = freeLinks;
80105599:	8b 35 10 c6 10 80    	mov    0x8010c610,%esi
	Proc *p = first->p;
8010559f:	8b 02                	mov    (%edx),%eax
	freeLinks = link;
801055a1:	89 15 10 c6 10 80    	mov    %edx,0x8010c610
	if(isEmpty())
801055a7:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
801055a9:	89 72 04             	mov    %esi,0x4(%edx)
	first = next;
801055ac:	89 59 08             	mov    %ebx,0x8(%ecx)
	if(isEmpty())
801055af:	75 07                	jne    801055b8 <_ZN7MapNode7dequeueEv+0x38>
		last = null;
801055b1:	c7 41 0c 00 00 00 00 	movl   $0x0,0xc(%ecx)
}
801055b8:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801055bb:	8b 75 fc             	mov    -0x4(%ebp),%esi
801055be:	89 ec                	mov    %ebp,%esp
801055c0:	5d                   	pop    %ebp
801055c1:	c3                   	ret    
801055c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		return null;
801055c8:	31 c0                	xor    %eax,%eax
	return listOfProcs.dequeue();
801055ca:	eb ec                	jmp    801055b8 <_ZN7MapNode7dequeueEv+0x38>
801055cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801055d0 <_ZN3Map7isEmptyEv>:
bool Map::isEmpty() {
801055d0:	55                   	push   %ebp
801055d1:	89 e5                	mov    %esp,%ebp
	return !root;
801055d3:	8b 45 08             	mov    0x8(%ebp),%eax
}
801055d6:	5d                   	pop    %ebp
	return !root;
801055d7:	8b 00                	mov    (%eax),%eax
801055d9:	85 c0                	test   %eax,%eax
801055db:	0f 94 c0             	sete   %al
}
801055de:	c3                   	ret    
801055df:	90                   	nop

801055e0 <_ZN3Map3putEP4proc>:
bool Map::put(Proc *p) {
801055e0:	55                   	push   %ebp
801055e1:	89 e5                	mov    %esp,%ebp
801055e3:	83 ec 18             	sub    $0x18,%esp
801055e6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801055e9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801055ec:	89 75 fc             	mov    %esi,-0x4(%ebp)
801055ef:	8b 75 08             	mov    0x8(%ebp),%esi
	long long key = getAccumulator(p);
801055f2:	89 1c 24             	mov    %ebx,(%esp)
801055f5:	e8 c6 e2 ff ff       	call   801038c0 <getAccumulator>
	return !root;
801055fa:	8b 0e                	mov    (%esi),%ecx
	if(isEmpty()) {
801055fc:	85 c9                	test   %ecx,%ecx
801055fe:	74 18                	je     80105618 <_ZN3Map3putEP4proc+0x38>
	return root->put(p);
80105600:	89 5d 0c             	mov    %ebx,0xc(%ebp)
}
80105603:	8b 75 fc             	mov    -0x4(%ebp),%esi
	return root->put(p);
80105606:	89 4d 08             	mov    %ecx,0x8(%ebp)
}
80105609:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010560c:	89 ec                	mov    %ebp,%esp
8010560e:	5d                   	pop    %ebp
	return root->put(p);
8010560f:	e9 1c fe ff ff       	jmp    80105430 <_ZN7MapNode3putEP4proc>
80105614:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		root = allocNode(p, key);
80105618:	89 d1                	mov    %edx,%ecx
8010561a:	89 c2                	mov    %eax,%edx
8010561c:	89 d8                	mov    %ebx,%eax
8010561e:	e8 5d f8 ff ff       	call   80104e80 <_ZL9allocNodeP4procx>
80105623:	89 06                	mov    %eax,(%esi)
		return !isEmpty();
80105625:	85 c0                	test   %eax,%eax
80105627:	0f 95 c0             	setne  %al
}
8010562a:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010562d:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105630:	89 ec                	mov    %ebp,%esp
80105632:	5d                   	pop    %ebp
80105633:	c3                   	ret    
80105634:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010563a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105640 <putPriorityQueue>:
static boolean putPriorityQueue(Proc* p) {
80105640:	55                   	push   %ebp
80105641:	89 e5                	mov    %esp,%ebp
80105643:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->put(p);
80105646:	8b 45 08             	mov    0x8(%ebp),%eax
80105649:	89 44 24 04          	mov    %eax,0x4(%esp)
8010564d:	a1 1c c6 10 80       	mov    0x8010c61c,%eax
80105652:	89 04 24             	mov    %eax,(%esp)
80105655:	e8 86 ff ff ff       	call   801055e0 <_ZN3Map3putEP4proc>
}
8010565a:	c9                   	leave  
	return priorityQ->put(p);
8010565b:	0f b6 c0             	movzbl %al,%eax
}
8010565e:	c3                   	ret    
8010565f:	90                   	nop

80105660 <_ZN3Map9getMinKeyEPx>:
bool Map::getMinKey(long long *pkey) {
80105660:	55                   	push   %ebp
80105661:	89 e5                	mov    %esp,%ebp
	return !root;
80105663:	8b 45 08             	mov    0x8(%ebp),%eax
bool Map::getMinKey(long long *pkey) {
80105666:	53                   	push   %ebx
	return !root;
80105667:	8b 10                	mov    (%eax),%edx
	if(isEmpty())
80105669:	85 d2                	test   %edx,%edx
8010566b:	75 05                	jne    80105672 <_ZN3Map9getMinKeyEPx+0x12>
8010566d:	eb 21                	jmp    80105690 <_ZN3Map9getMinKeyEPx+0x30>
8010566f:	90                   	nop
	while(minNode->left)
80105670:	89 c2                	mov    %eax,%edx
80105672:	8b 42 18             	mov    0x18(%edx),%eax
80105675:	85 c0                	test   %eax,%eax
80105677:	75 f7                	jne    80105670 <_ZN3Map9getMinKeyEPx+0x10>
	*pkey = getMinNode()->key;
80105679:	8b 45 0c             	mov    0xc(%ebp),%eax
8010567c:	8b 5a 04             	mov    0x4(%edx),%ebx
8010567f:	8b 0a                	mov    (%edx),%ecx
80105681:	89 58 04             	mov    %ebx,0x4(%eax)
80105684:	89 08                	mov    %ecx,(%eax)
		return false;

	root->getMinKey(pkey);
	return true;
80105686:	b0 01                	mov    $0x1,%al
}
80105688:	5b                   	pop    %ebx
80105689:	5d                   	pop    %ebp
8010568a:	c3                   	ret    
8010568b:	90                   	nop
8010568c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105690:	5b                   	pop    %ebx
		return false;
80105691:	31 c0                	xor    %eax,%eax
}
80105693:	5d                   	pop    %ebp
80105694:	c3                   	ret    
80105695:	90                   	nop
80105696:	8d 76 00             	lea    0x0(%esi),%esi
80105699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801056a0 <_ZN3Map10extractMinEv>:

Proc* Map::extractMin() {
801056a0:	55                   	push   %ebp
801056a1:	89 e5                	mov    %esp,%ebp
801056a3:	57                   	push   %edi
801056a4:	56                   	push   %esi
801056a5:	8b 75 08             	mov    0x8(%ebp),%esi
801056a8:	53                   	push   %ebx
	return !root;
801056a9:	8b 1e                	mov    (%esi),%ebx
	if(isEmpty())
801056ab:	85 db                	test   %ebx,%ebx
801056ad:	0f 84 a5 00 00 00    	je     80105758 <_ZN3Map10extractMinEv+0xb8>
801056b3:	89 da                	mov    %ebx,%edx
801056b5:	eb 0b                	jmp    801056c2 <_ZN3Map10extractMinEv+0x22>
801056b7:	89 f6                	mov    %esi,%esi
801056b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	while(minNode->left)
801056c0:	89 c2                	mov    %eax,%edx
801056c2:	8b 42 18             	mov    0x18(%edx),%eax
801056c5:	85 c0                	test   %eax,%eax
801056c7:	75 f7                	jne    801056c0 <_ZN3Map10extractMinEv+0x20>
	return !first;
801056c9:	8b 4a 08             	mov    0x8(%edx),%ecx
	if(isEmpty())
801056cc:	85 c9                	test   %ecx,%ecx
801056ce:	74 70                	je     80105740 <_ZN3Map10extractMinEv+0xa0>
	Link *next = first->next;
801056d0:	8b 59 04             	mov    0x4(%ecx),%ebx
	link->next = freeLinks;
801056d3:	8b 3d 10 c6 10 80    	mov    0x8010c610,%edi
	Proc *p = first->p;
801056d9:	8b 01                	mov    (%ecx),%eax
	freeLinks = link;
801056db:	89 0d 10 c6 10 80    	mov    %ecx,0x8010c610
	if(isEmpty())
801056e1:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
801056e3:	89 79 04             	mov    %edi,0x4(%ecx)
	first = next;
801056e6:	89 5a 08             	mov    %ebx,0x8(%edx)
	if(isEmpty())
801056e9:	74 05                	je     801056f0 <_ZN3Map10extractMinEv+0x50>
		}
		deallocNode(minNode);
	}

	return p;
}
801056eb:	5b                   	pop    %ebx
801056ec:	5e                   	pop    %esi
801056ed:	5f                   	pop    %edi
801056ee:	5d                   	pop    %ebp
801056ef:	c3                   	ret    
		last = null;
801056f0:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
801056f7:	8b 4a 1c             	mov    0x1c(%edx),%ecx
801056fa:	8b 1e                	mov    (%esi),%ebx
		if(minNode == root) {
801056fc:	39 da                	cmp    %ebx,%edx
801056fe:	74 49                	je     80105749 <_ZN3Map10extractMinEv+0xa9>
			MapNode *parent = minNode->parent;
80105700:	8b 5a 14             	mov    0x14(%edx),%ebx
			parent->left = minNode->right;
80105703:	89 4b 18             	mov    %ecx,0x18(%ebx)
			if(minNode->right)
80105706:	8b 4a 1c             	mov    0x1c(%edx),%ecx
80105709:	85 c9                	test   %ecx,%ecx
8010570b:	74 03                	je     80105710 <_ZN3Map10extractMinEv+0x70>
				minNode->right->parent = parent;
8010570d:	89 59 14             	mov    %ebx,0x14(%ecx)
	node->next = freeNodes;
80105710:	8b 0d 0c c6 10 80    	mov    0x8010c60c,%ecx
	node->parent = node->left = node->right = null;
80105716:	c7 42 1c 00 00 00 00 	movl   $0x0,0x1c(%edx)
8010571d:	c7 42 18 00 00 00 00 	movl   $0x0,0x18(%edx)
80105724:	c7 42 14 00 00 00 00 	movl   $0x0,0x14(%edx)
	node->next = freeNodes;
8010572b:	89 4a 10             	mov    %ecx,0x10(%edx)
}
8010572e:	5b                   	pop    %ebx
	freeNodes = node;
8010572f:	89 15 0c c6 10 80    	mov    %edx,0x8010c60c
}
80105735:	5e                   	pop    %esi
80105736:	5f                   	pop    %edi
80105737:	5d                   	pop    %ebp
80105738:	c3                   	ret    
80105739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return null;
80105740:	31 c0                	xor    %eax,%eax
		if(minNode == root) {
80105742:	39 da                	cmp    %ebx,%edx
80105744:	8b 4a 1c             	mov    0x1c(%edx),%ecx
80105747:	75 b7                	jne    80105700 <_ZN3Map10extractMinEv+0x60>
			if(!isEmpty())
80105749:	85 c9                	test   %ecx,%ecx
			root = minNode->right;
8010574b:	89 0e                	mov    %ecx,(%esi)
			if(!isEmpty())
8010574d:	74 c1                	je     80105710 <_ZN3Map10extractMinEv+0x70>
				root->parent = null;
8010574f:	c7 41 14 00 00 00 00 	movl   $0x0,0x14(%ecx)
80105756:	eb b8                	jmp    80105710 <_ZN3Map10extractMinEv+0x70>
		return null;
80105758:	31 c0                	xor    %eax,%eax
8010575a:	eb 8f                	jmp    801056eb <_ZN3Map10extractMinEv+0x4b>
8010575c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105760 <extractMinPriorityQueue>:
static Proc* extractMinPriorityQueue() {
80105760:	55                   	push   %ebp
80105761:	89 e5                	mov    %esp,%ebp
80105763:	83 ec 04             	sub    $0x4,%esp
	return priorityQ->extractMin();
80105766:	a1 1c c6 10 80       	mov    0x8010c61c,%eax
8010576b:	89 04 24             	mov    %eax,(%esp)
8010576e:	e8 2d ff ff ff       	call   801056a0 <_ZN3Map10extractMinEv>
}
80105773:	c9                   	leave  
80105774:	c3                   	ret    
80105775:	90                   	nop
80105776:	8d 76 00             	lea    0x0(%esi),%esi
80105779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105780 <_ZN3Map8transferEv.part.1>:

bool Map::transfer() {
80105780:	55                   	push   %ebp
80105781:	89 e5                	mov    %esp,%ebp
80105783:	56                   	push   %esi
80105784:	53                   	push   %ebx
80105785:	89 c3                	mov    %eax,%ebx
80105787:	83 ec 04             	sub    $0x4,%esp
8010578a:	eb 16                	jmp    801057a2 <_ZN3Map8transferEv.part.1+0x22>
8010578c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!roundRobinQ->isEmpty())
		return false;

	while(!isEmpty()) {
		Proc* p = extractMin();
80105790:	89 1c 24             	mov    %ebx,(%esp)
80105793:	e8 08 ff ff ff       	call   801056a0 <_ZN3Map10extractMinEv>
	if(!freeLinks)
80105798:	8b 15 10 c6 10 80    	mov    0x8010c610,%edx
8010579e:	85 d2                	test   %edx,%edx
801057a0:	75 0e                	jne    801057b0 <_ZN3Map8transferEv.part.1+0x30>
	while(!isEmpty()) {
801057a2:	8b 03                	mov    (%ebx),%eax
801057a4:	85 c0                	test   %eax,%eax
801057a6:	75 e8                	jne    80105790 <_ZN3Map8transferEv.part.1+0x10>
		roundRobinQ->enqueue(p); //should succeed.
	}

	return true;
}
801057a8:	5a                   	pop    %edx
801057a9:	b0 01                	mov    $0x1,%al
801057ab:	5b                   	pop    %ebx
801057ac:	5e                   	pop    %esi
801057ad:	5d                   	pop    %ebp
801057ae:	c3                   	ret    
801057af:	90                   	nop
	freeLinks = freeLinks->next;
801057b0:	8b 72 04             	mov    0x4(%edx),%esi
		roundRobinQ->enqueue(p); //should succeed.
801057b3:	8b 0d 18 c6 10 80    	mov    0x8010c618,%ecx
	ans->next = null;
801057b9:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
	ans->p = p;
801057c0:	89 02                	mov    %eax,(%edx)
	freeLinks = freeLinks->next;
801057c2:	89 35 10 c6 10 80    	mov    %esi,0x8010c610
	if(isEmpty()) first = link;
801057c8:	8b 31                	mov    (%ecx),%esi
801057ca:	85 f6                	test   %esi,%esi
801057cc:	74 22                	je     801057f0 <_ZN3Map8transferEv.part.1+0x70>
	else last->next = link;
801057ce:	8b 41 04             	mov    0x4(%ecx),%eax
801057d1:	89 50 04             	mov    %edx,0x4(%eax)
801057d4:	eb 0c                	jmp    801057e2 <_ZN3Map8transferEv.part.1+0x62>
801057d6:	8d 76 00             	lea    0x0(%esi),%esi
801057d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	while(ans->next)
801057e0:	89 c2                	mov    %eax,%edx
801057e2:	8b 42 04             	mov    0x4(%edx),%eax
801057e5:	85 c0                	test   %eax,%eax
801057e7:	75 f7                	jne    801057e0 <_ZN3Map8transferEv.part.1+0x60>
	last = link->getLast();
801057e9:	89 51 04             	mov    %edx,0x4(%ecx)
801057ec:	eb b4                	jmp    801057a2 <_ZN3Map8transferEv.part.1+0x22>
801057ee:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
801057f0:	89 11                	mov    %edx,(%ecx)
801057f2:	eb ee                	jmp    801057e2 <_ZN3Map8transferEv.part.1+0x62>
801057f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801057fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105800 <switchToRoundRobinPolicyPriorityQueue>:
	if(!roundRobinQ->isEmpty())
80105800:	8b 15 18 c6 10 80    	mov    0x8010c618,%edx
80105806:	8b 02                	mov    (%edx),%eax
80105808:	85 c0                	test   %eax,%eax
8010580a:	74 04                	je     80105810 <switchToRoundRobinPolicyPriorityQueue+0x10>
8010580c:	31 c0                	xor    %eax,%eax
}
8010580e:	c3                   	ret    
8010580f:	90                   	nop
80105810:	a1 1c c6 10 80       	mov    0x8010c61c,%eax
static boolean switchToRoundRobinPolicyPriorityQueue() {
80105815:	55                   	push   %ebp
80105816:	89 e5                	mov    %esp,%ebp
80105818:	e8 63 ff ff ff       	call   80105780 <_ZN3Map8transferEv.part.1>
}
8010581d:	5d                   	pop    %ebp
8010581e:	0f b6 c0             	movzbl %al,%eax
80105821:	c3                   	ret    
80105822:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105830 <_ZN3Map8transferEv>:
	return !first;
80105830:	8b 15 18 c6 10 80    	mov    0x8010c618,%edx
bool Map::transfer() {
80105836:	55                   	push   %ebp
80105837:	89 e5                	mov    %esp,%ebp
80105839:	8b 45 08             	mov    0x8(%ebp),%eax
	if(!roundRobinQ->isEmpty())
8010583c:	8b 12                	mov    (%edx),%edx
8010583e:	85 d2                	test   %edx,%edx
80105840:	74 0e                	je     80105850 <_ZN3Map8transferEv+0x20>
}
80105842:	31 c0                	xor    %eax,%eax
80105844:	5d                   	pop    %ebp
80105845:	c3                   	ret    
80105846:	8d 76 00             	lea    0x0(%esi),%esi
80105849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105850:	5d                   	pop    %ebp
80105851:	e9 2a ff ff ff       	jmp    80105780 <_ZN3Map8transferEv.part.1>
80105856:	8d 76 00             	lea    0x0(%esi),%esi
80105859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105860 <_ZN3Map11extractProcEP4proc>:

bool Map::extractProc(Proc *p) {
80105860:	55                   	push   %ebp
80105861:	89 e5                	mov    %esp,%ebp
80105863:	56                   	push   %esi
80105864:	53                   	push   %ebx
80105865:	83 ec 30             	sub    $0x30,%esp
	if(!freeNodes)
80105868:	8b 15 0c c6 10 80    	mov    0x8010c60c,%edx
bool Map::extractProc(Proc *p) {
8010586e:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105871:	8b 75 0c             	mov    0xc(%ebp),%esi
	if(!freeNodes)
80105874:	85 d2                	test   %edx,%edx
80105876:	74 50                	je     801058c8 <_ZN3Map11extractProcEP4proc+0x68>
	MapNode *next, *parent, *left, *right;
};

class Map {
public:
	Map(): root(null) {}
80105878:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		return false;

	bool ans = false;
8010587f:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
80105883:	eb 13                	jmp    80105898 <_ZN3Map11extractProcEP4proc+0x38>
80105885:	8d 76 00             	lea    0x0(%esi),%esi
	Map tempMap;
	while(!isEmpty()) {
		Proc *otherP = extractMin();
80105888:	89 1c 24             	mov    %ebx,(%esp)
8010588b:	e8 10 fe ff ff       	call   801056a0 <_ZN3Map10extractMinEv>
		if(otherP != p)
80105890:	39 f0                	cmp    %esi,%eax
80105892:	75 1c                	jne    801058b0 <_ZN3Map11extractProcEP4proc+0x50>
			tempMap.put(otherP); //should scucceed.
		else ans = true;
80105894:	c6 45 e7 01          	movb   $0x1,-0x19(%ebp)
	while(!isEmpty()) {
80105898:	8b 03                	mov    (%ebx),%eax
8010589a:	85 c0                	test   %eax,%eax
8010589c:	75 ea                	jne    80105888 <_ZN3Map11extractProcEP4proc+0x28>
	}
	root = tempMap.root;
8010589e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058a1:	89 03                	mov    %eax,(%ebx)
	return ans;
}
801058a3:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801058a7:	83 c4 30             	add    $0x30,%esp
801058aa:	5b                   	pop    %ebx
801058ab:	5e                   	pop    %esi
801058ac:	5d                   	pop    %ebp
801058ad:	c3                   	ret    
801058ae:	66 90                	xchg   %ax,%ax
			tempMap.put(otherP); //should scucceed.
801058b0:	89 44 24 04          	mov    %eax,0x4(%esp)
801058b4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058b7:	89 04 24             	mov    %eax,(%esp)
801058ba:	e8 21 fd ff ff       	call   801055e0 <_ZN3Map3putEP4proc>
801058bf:	eb d7                	jmp    80105898 <_ZN3Map11extractProcEP4proc+0x38>
801058c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return false;
801058c8:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
}
801058cc:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801058d0:	83 c4 30             	add    $0x30,%esp
801058d3:	5b                   	pop    %ebx
801058d4:	5e                   	pop    %esi
801058d5:	5d                   	pop    %ebp
801058d6:	c3                   	ret    
801058d7:	89 f6                	mov    %esi,%esi
801058d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058e0 <extractProcPriorityQueue>:
static boolean extractProcPriorityQueue(Proc *p) {
801058e0:	55                   	push   %ebp
801058e1:	89 e5                	mov    %esp,%ebp
801058e3:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->extractProc(p);
801058e6:	8b 45 08             	mov    0x8(%ebp),%eax
801058e9:	89 44 24 04          	mov    %eax,0x4(%esp)
801058ed:	a1 1c c6 10 80       	mov    0x8010c61c,%eax
801058f2:	89 04 24             	mov    %eax,(%esp)
801058f5:	e8 66 ff ff ff       	call   80105860 <_ZN3Map11extractProcEP4proc>
}
801058fa:	c9                   	leave  
	return priorityQ->extractProc(p);
801058fb:	0f b6 c0             	movzbl %al,%eax
}
801058fe:	c3                   	ret    
801058ff:	90                   	nop

80105900 <__moddi3>:

long long __moddi3(long long number, long long divisor) { //returns number%divisor
80105900:	55                   	push   %ebp
80105901:	89 e5                	mov    %esp,%ebp
80105903:	57                   	push   %edi
80105904:	56                   	push   %esi
80105905:	53                   	push   %ebx
80105906:	83 ec 2c             	sub    $0x2c,%esp
80105909:	8b 45 08             	mov    0x8(%ebp),%eax
8010590c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010590f:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105912:	8b 45 10             	mov    0x10(%ebp),%eax
80105915:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80105918:	8b 55 14             	mov    0x14(%ebp),%edx
8010591b:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010591e:	89 d7                	mov    %edx,%edi
	if(divisor == 0)
80105920:	09 c2                	or     %eax,%edx
80105922:	0f 84 9a 00 00 00    	je     801059c2 <__moddi3+0xc2>
		panic((char*)"divide by zero!!!\n");

	bool isNumberNegative = false;
	if(number < 0) {
80105928:	8b 45 e4             	mov    -0x1c(%ebp),%eax
	bool isNumberNegative = false;
8010592b:	c6 45 df 00          	movb   $0x0,-0x21(%ebp)
	if(number < 0) {
8010592f:	85 c0                	test   %eax,%eax
80105931:	79 0e                	jns    80105941 <__moddi3+0x41>
		number = -number;
80105933:	f7 5d e0             	negl   -0x20(%ebp)
		isNumberNegative = true;
80105936:	c6 45 df 01          	movb   $0x1,-0x21(%ebp)
		number = -number;
8010593a:	83 55 e4 00          	adcl   $0x0,-0x1c(%ebp)
8010593e:	f7 5d e4             	negl   -0x1c(%ebp)
80105941:	8b 55 d8             	mov    -0x28(%ebp),%edx
80105944:	89 f8                	mov    %edi,%eax
80105946:	c1 ff 1f             	sar    $0x1f,%edi
80105949:	31 f8                	xor    %edi,%eax
8010594b:	89 f9                	mov    %edi,%ecx
8010594d:	31 fa                	xor    %edi,%edx
8010594f:	89 c7                	mov    %eax,%edi
80105951:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105954:	89 d6                	mov    %edx,%esi
80105956:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105959:	29 ce                	sub    %ecx,%esi
8010595b:	19 cf                	sbb    %ecx,%edi
	if(divisor < 0)
		divisor = -divisor;

	for(;;) {
		long long divisor2 = divisor;
		while(number >= divisor2) {
8010595d:	39 fa                	cmp    %edi,%edx
8010595f:	7d 1f                	jge    80105980 <__moddi3+0x80>
			if(divisor2 + divisor2 > 0) //exponential decay.
				divisor2 += divisor2;
		}

		if(number < divisor)
			return isNumberNegative ? -number : number;
80105961:	80 7d df 00          	cmpb   $0x0,-0x21(%ebp)
80105965:	74 07                	je     8010596e <__moddi3+0x6e>
80105967:	f7 d8                	neg    %eax
80105969:	83 d2 00             	adc    $0x0,%edx
8010596c:	f7 da                	neg    %edx
	}
}
8010596e:	83 c4 2c             	add    $0x2c,%esp
80105971:	5b                   	pop    %ebx
80105972:	5e                   	pop    %esi
80105973:	5f                   	pop    %edi
80105974:	5d                   	pop    %ebp
80105975:	c3                   	ret    
80105976:	8d 76 00             	lea    0x0(%esi),%esi
80105979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		while(number >= divisor2) {
80105980:	7f 04                	jg     80105986 <__moddi3+0x86>
80105982:	39 f0                	cmp    %esi,%eax
80105984:	72 db                	jb     80105961 <__moddi3+0x61>
80105986:	89 f1                	mov    %esi,%ecx
80105988:	89 fb                	mov    %edi,%ebx
8010598a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			number -= divisor2;
80105990:	29 c8                	sub    %ecx,%eax
80105992:	19 da                	sbb    %ebx,%edx
				divisor2 += divisor2;
80105994:	0f a4 cb 01          	shld   $0x1,%ecx,%ebx
80105998:	01 c9                	add    %ecx,%ecx
		while(number >= divisor2) {
8010599a:	39 da                	cmp    %ebx,%edx
8010599c:	7f f2                	jg     80105990 <__moddi3+0x90>
8010599e:	7d 18                	jge    801059b8 <__moddi3+0xb8>
		if(number < divisor)
801059a0:	39 d7                	cmp    %edx,%edi
801059a2:	7c b9                	jl     8010595d <__moddi3+0x5d>
801059a4:	7f bb                	jg     80105961 <__moddi3+0x61>
801059a6:	39 c6                	cmp    %eax,%esi
801059a8:	76 b3                	jbe    8010595d <__moddi3+0x5d>
801059aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801059b0:	eb af                	jmp    80105961 <__moddi3+0x61>
801059b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		while(number >= divisor2) {
801059b8:	39 c8                	cmp    %ecx,%eax
801059ba:	73 d4                	jae    80105990 <__moddi3+0x90>
801059bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801059c0:	eb de                	jmp    801059a0 <__moddi3+0xa0>
		panic((char*)"divide by zero!!!\n");
801059c2:	c7 04 24 3c 90 10 80 	movl   $0x8010903c,(%esp)
801059c9:	e8 a2 a9 ff ff       	call   80100370 <panic>
801059ce:	66 90                	xchg   %ax,%ax

801059d0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801059d0:	55                   	push   %ebp
  initlock(&lk->lk, "sleep lock");
801059d1:	b8 4f 90 10 80       	mov    $0x8010904f,%eax
{
801059d6:	89 e5                	mov    %esp,%ebp
801059d8:	53                   	push   %ebx
801059d9:	83 ec 14             	sub    $0x14,%esp
801059dc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801059df:	89 44 24 04          	mov    %eax,0x4(%esp)
801059e3:	8d 43 04             	lea    0x4(%ebx),%eax
801059e6:	89 04 24             	mov    %eax,(%esp)
801059e9:	e8 12 01 00 00       	call   80105b00 <initlock>
  lk->name = name;
801059ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801059f1:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801059f7:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801059fe:	89 43 38             	mov    %eax,0x38(%ebx)
}
80105a01:	83 c4 14             	add    $0x14,%esp
80105a04:	5b                   	pop    %ebx
80105a05:	5d                   	pop    %ebp
80105a06:	c3                   	ret    
80105a07:	89 f6                	mov    %esi,%esi
80105a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a10 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80105a10:	55                   	push   %ebp
80105a11:	89 e5                	mov    %esp,%ebp
80105a13:	56                   	push   %esi
80105a14:	53                   	push   %ebx
80105a15:	83 ec 10             	sub    $0x10,%esp
80105a18:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105a1b:	8d 73 04             	lea    0x4(%ebx),%esi
80105a1e:	89 34 24             	mov    %esi,(%esp)
80105a21:	e8 2a 02 00 00       	call   80105c50 <acquire>
  while (lk->locked) {
80105a26:	8b 13                	mov    (%ebx),%edx
80105a28:	85 d2                	test   %edx,%edx
80105a2a:	74 16                	je     80105a42 <acquiresleep+0x32>
80105a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80105a30:	89 74 24 04          	mov    %esi,0x4(%esp)
80105a34:	89 1c 24             	mov    %ebx,(%esp)
80105a37:	e8 d4 ea ff ff       	call   80104510 <sleep>
  while (lk->locked) {
80105a3c:	8b 03                	mov    (%ebx),%eax
80105a3e:	85 c0                	test   %eax,%eax
80105a40:	75 ee                	jne    80105a30 <acquiresleep+0x20>
  }
  lk->locked = 1;
80105a42:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80105a48:	e8 53 df ff ff       	call   801039a0 <myproc>
80105a4d:	8b 40 10             	mov    0x10(%eax),%eax
80105a50:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80105a53:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105a56:	83 c4 10             	add    $0x10,%esp
80105a59:	5b                   	pop    %ebx
80105a5a:	5e                   	pop    %esi
80105a5b:	5d                   	pop    %ebp
  release(&lk->lk);
80105a5c:	e9 8f 02 00 00       	jmp    80105cf0 <release>
80105a61:	eb 0d                	jmp    80105a70 <releasesleep>
80105a63:	90                   	nop
80105a64:	90                   	nop
80105a65:	90                   	nop
80105a66:	90                   	nop
80105a67:	90                   	nop
80105a68:	90                   	nop
80105a69:	90                   	nop
80105a6a:	90                   	nop
80105a6b:	90                   	nop
80105a6c:	90                   	nop
80105a6d:	90                   	nop
80105a6e:	90                   	nop
80105a6f:	90                   	nop

80105a70 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80105a70:	55                   	push   %ebp
80105a71:	89 e5                	mov    %esp,%ebp
80105a73:	83 ec 18             	sub    $0x18,%esp
80105a76:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105a79:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105a7c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  acquire(&lk->lk);
80105a7f:	8d 73 04             	lea    0x4(%ebx),%esi
80105a82:	89 34 24             	mov    %esi,(%esp)
80105a85:	e8 c6 01 00 00       	call   80105c50 <acquire>
  lk->locked = 0;
80105a8a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80105a90:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80105a97:	89 1c 24             	mov    %ebx,(%esp)
80105a9a:	e8 71 ec ff ff       	call   80104710 <wakeup>
  release(&lk->lk);
}
80105a9f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  release(&lk->lk);
80105aa2:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105aa5:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105aa8:	89 ec                	mov    %ebp,%esp
80105aaa:	5d                   	pop    %ebp
  release(&lk->lk);
80105aab:	e9 40 02 00 00       	jmp    80105cf0 <release>

80105ab0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80105ab0:	55                   	push   %ebp
80105ab1:	89 e5                	mov    %esp,%ebp
80105ab3:	83 ec 28             	sub    $0x28,%esp
80105ab6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80105ab9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105abc:	89 7d fc             	mov    %edi,-0x4(%ebp)
80105abf:	89 75 f8             	mov    %esi,-0x8(%ebp)
80105ac2:	31 f6                	xor    %esi,%esi
  int r;
  
  acquire(&lk->lk);
80105ac4:	8d 7b 04             	lea    0x4(%ebx),%edi
80105ac7:	89 3c 24             	mov    %edi,(%esp)
80105aca:	e8 81 01 00 00       	call   80105c50 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80105acf:	8b 03                	mov    (%ebx),%eax
80105ad1:	85 c0                	test   %eax,%eax
80105ad3:	74 11                	je     80105ae6 <holdingsleep+0x36>
80105ad5:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80105ad8:	e8 c3 de ff ff       	call   801039a0 <myproc>
80105add:	39 58 10             	cmp    %ebx,0x10(%eax)
80105ae0:	0f 94 c0             	sete   %al
80105ae3:	0f b6 f0             	movzbl %al,%esi
  release(&lk->lk);
80105ae6:	89 3c 24             	mov    %edi,(%esp)
80105ae9:	e8 02 02 00 00       	call   80105cf0 <release>
  return r;
}
80105aee:	89 f0                	mov    %esi,%eax
80105af0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105af3:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105af6:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105af9:	89 ec                	mov    %ebp,%esp
80105afb:	5d                   	pop    %ebp
80105afc:	c3                   	ret    
80105afd:	66 90                	xchg   %ax,%ax
80105aff:	90                   	nop

80105b00 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105b00:	55                   	push   %ebp
80105b01:	89 e5                	mov    %esp,%ebp
80105b03:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80105b06:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80105b09:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80105b0f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80105b12:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105b19:	5d                   	pop    %ebp
80105b1a:	c3                   	ret    
80105b1b:	90                   	nop
80105b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b20 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105b20:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105b21:	31 d2                	xor    %edx,%edx
{
80105b23:	89 e5                	mov    %esp,%ebp
  ebp = (uint*)v - 2;
80105b25:	8b 45 08             	mov    0x8(%ebp),%eax
{
80105b28:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105b2b:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80105b2c:	83 e8 08             	sub    $0x8,%eax
80105b2f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105b30:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80105b36:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80105b3c:	77 12                	ja     80105b50 <getcallerpcs+0x30>
      break;
    pcs[i] = ebp[1];     // saved %eip
80105b3e:	8b 58 04             	mov    0x4(%eax),%ebx
80105b41:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80105b44:	42                   	inc    %edx
80105b45:	83 fa 0a             	cmp    $0xa,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80105b48:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105b4a:	75 e4                	jne    80105b30 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80105b4c:	5b                   	pop    %ebx
80105b4d:	5d                   	pop    %ebp
80105b4e:	c3                   	ret    
80105b4f:	90                   	nop
80105b50:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80105b53:	83 c1 28             	add    $0x28,%ecx
80105b56:	8d 76 00             	lea    0x0(%esi),%esi
80105b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80105b60:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105b66:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105b69:	39 c1                	cmp    %eax,%ecx
80105b6b:	75 f3                	jne    80105b60 <getcallerpcs+0x40>
}
80105b6d:	5b                   	pop    %ebx
80105b6e:	5d                   	pop    %ebp
80105b6f:	c3                   	ret    

80105b70 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105b70:	55                   	push   %ebp
80105b71:	89 e5                	mov    %esp,%ebp
80105b73:	53                   	push   %ebx
80105b74:	83 ec 04             	sub    $0x4,%esp
80105b77:	9c                   	pushf  
80105b78:	5b                   	pop    %ebx
  asm volatile("cli");
80105b79:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80105b7a:	e8 81 dd ff ff       	call   80103900 <mycpu>
80105b7f:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105b85:	85 d2                	test   %edx,%edx
80105b87:	75 11                	jne    80105b9a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80105b89:	e8 72 dd ff ff       	call   80103900 <mycpu>
80105b8e:	81 e3 00 02 00 00    	and    $0x200,%ebx
80105b94:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
80105b9a:	e8 61 dd ff ff       	call   80103900 <mycpu>
80105b9f:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
80105ba5:	58                   	pop    %eax
80105ba6:	5b                   	pop    %ebx
80105ba7:	5d                   	pop    %ebp
80105ba8:	c3                   	ret    
80105ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105bb0 <popcli>:

void
popcli(void)
{
80105bb0:	55                   	push   %ebp
80105bb1:	89 e5                	mov    %esp,%ebp
80105bb3:	83 ec 18             	sub    $0x18,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105bb6:	9c                   	pushf  
80105bb7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80105bb8:	f6 c4 02             	test   $0x2,%ah
80105bbb:	75 35                	jne    80105bf2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80105bbd:	e8 3e dd ff ff       	call   80103900 <mycpu>
80105bc2:	ff 88 a4 00 00 00    	decl   0xa4(%eax)
80105bc8:	78 34                	js     80105bfe <popcli+0x4e>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105bca:	e8 31 dd ff ff       	call   80103900 <mycpu>
80105bcf:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105bd5:	85 d2                	test   %edx,%edx
80105bd7:	74 07                	je     80105be0 <popcli+0x30>
    sti();
}
80105bd9:	c9                   	leave  
80105bda:	c3                   	ret    
80105bdb:	90                   	nop
80105bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105be0:	e8 1b dd ff ff       	call   80103900 <mycpu>
80105be5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80105beb:	85 c0                	test   %eax,%eax
80105bed:	74 ea                	je     80105bd9 <popcli+0x29>
  asm volatile("sti");
80105bef:	fb                   	sti    
}
80105bf0:	c9                   	leave  
80105bf1:	c3                   	ret    
    panic("popcli - interruptible");
80105bf2:	c7 04 24 5a 90 10 80 	movl   $0x8010905a,(%esp)
80105bf9:	e8 72 a7 ff ff       	call   80100370 <panic>
    panic("popcli");
80105bfe:	c7 04 24 71 90 10 80 	movl   $0x80109071,(%esp)
80105c05:	e8 66 a7 ff ff       	call   80100370 <panic>
80105c0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105c10 <holding>:
{
80105c10:	55                   	push   %ebp
80105c11:	89 e5                	mov    %esp,%ebp
80105c13:	83 ec 08             	sub    $0x8,%esp
80105c16:	89 75 fc             	mov    %esi,-0x4(%ebp)
80105c19:	8b 75 08             	mov    0x8(%ebp),%esi
80105c1c:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105c1f:	31 db                	xor    %ebx,%ebx
  pushcli();
80105c21:	e8 4a ff ff ff       	call   80105b70 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105c26:	8b 06                	mov    (%esi),%eax
80105c28:	85 c0                	test   %eax,%eax
80105c2a:	74 10                	je     80105c3c <holding+0x2c>
80105c2c:	8b 5e 08             	mov    0x8(%esi),%ebx
80105c2f:	e8 cc dc ff ff       	call   80103900 <mycpu>
80105c34:	39 c3                	cmp    %eax,%ebx
80105c36:	0f 94 c3             	sete   %bl
80105c39:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80105c3c:	e8 6f ff ff ff       	call   80105bb0 <popcli>
}
80105c41:	89 d8                	mov    %ebx,%eax
80105c43:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105c46:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105c49:	89 ec                	mov    %ebp,%esp
80105c4b:	5d                   	pop    %ebp
80105c4c:	c3                   	ret    
80105c4d:	8d 76 00             	lea    0x0(%esi),%esi

80105c50 <acquire>:
{
80105c50:	55                   	push   %ebp
80105c51:	89 e5                	mov    %esp,%ebp
80105c53:	56                   	push   %esi
80105c54:	53                   	push   %ebx
80105c55:	83 ec 10             	sub    $0x10,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105c58:	e8 13 ff ff ff       	call   80105b70 <pushcli>
  if(holding(lk))
80105c5d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105c60:	89 1c 24             	mov    %ebx,(%esp)
80105c63:	e8 a8 ff ff ff       	call   80105c10 <holding>
80105c68:	85 c0                	test   %eax,%eax
80105c6a:	75 78                	jne    80105ce4 <acquire+0x94>
80105c6c:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80105c6e:	ba 01 00 00 00       	mov    $0x1,%edx
80105c73:	eb 06                	jmp    80105c7b <acquire+0x2b>
80105c75:	8d 76 00             	lea    0x0(%esi),%esi
80105c78:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105c7b:	89 d0                	mov    %edx,%eax
80105c7d:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80105c80:	85 c0                	test   %eax,%eax
80105c82:	75 f4                	jne    80105c78 <acquire+0x28>
  __sync_synchronize();
80105c84:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80105c89:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105c8c:	e8 6f dc ff ff       	call   80103900 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80105c91:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
80105c94:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80105c97:	89 e8                	mov    %ebp,%eax
80105c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105ca0:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
80105ca6:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80105cac:	77 1a                	ja     80105cc8 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
80105cae:	8b 48 04             	mov    0x4(%eax),%ecx
80105cb1:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
80105cb4:	46                   	inc    %esi
80105cb5:	83 fe 0a             	cmp    $0xa,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80105cb8:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105cba:	75 e4                	jne    80105ca0 <acquire+0x50>
}
80105cbc:	83 c4 10             	add    $0x10,%esp
80105cbf:	5b                   	pop    %ebx
80105cc0:	5e                   	pop    %esi
80105cc1:	5d                   	pop    %ebp
80105cc2:	c3                   	ret    
80105cc3:	90                   	nop
80105cc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105cc8:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80105ccb:	83 c2 28             	add    $0x28,%edx
80105cce:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105cd0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105cd6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105cd9:	39 d0                	cmp    %edx,%eax
80105cdb:	75 f3                	jne    80105cd0 <acquire+0x80>
}
80105cdd:	83 c4 10             	add    $0x10,%esp
80105ce0:	5b                   	pop    %ebx
80105ce1:	5e                   	pop    %esi
80105ce2:	5d                   	pop    %ebp
80105ce3:	c3                   	ret    
    panic("acquire");
80105ce4:	c7 04 24 78 90 10 80 	movl   $0x80109078,(%esp)
80105ceb:	e8 80 a6 ff ff       	call   80100370 <panic>

80105cf0 <release>:
{
80105cf0:	55                   	push   %ebp
80105cf1:	89 e5                	mov    %esp,%ebp
80105cf3:	53                   	push   %ebx
80105cf4:	83 ec 14             	sub    $0x14,%esp
80105cf7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80105cfa:	89 1c 24             	mov    %ebx,(%esp)
80105cfd:	e8 0e ff ff ff       	call   80105c10 <holding>
80105d02:	85 c0                	test   %eax,%eax
80105d04:	74 23                	je     80105d29 <release+0x39>
  lk->pcs[0] = 0;
80105d06:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105d0d:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105d14:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80105d19:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105d1f:	83 c4 14             	add    $0x14,%esp
80105d22:	5b                   	pop    %ebx
80105d23:	5d                   	pop    %ebp
  popcli();
80105d24:	e9 87 fe ff ff       	jmp    80105bb0 <popcli>
    panic("release");
80105d29:	c7 04 24 80 90 10 80 	movl   $0x80109080,(%esp)
80105d30:	e8 3b a6 ff ff       	call   80100370 <panic>
80105d35:	66 90                	xchg   %ax,%ax
80105d37:	66 90                	xchg   %ax,%ax
80105d39:	66 90                	xchg   %ax,%ax
80105d3b:	66 90                	xchg   %ax,%ax
80105d3d:	66 90                	xchg   %ax,%ax
80105d3f:	90                   	nop

80105d40 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105d40:	55                   	push   %ebp
80105d41:	89 e5                	mov    %esp,%ebp
80105d43:	83 ec 08             	sub    $0x8,%esp
80105d46:	8b 55 08             	mov    0x8(%ebp),%edx
80105d49:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105d4c:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105d4f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if ((int)dst%4 == 0 && n%4 == 0){
80105d52:	f6 c2 03             	test   $0x3,%dl
80105d55:	75 05                	jne    80105d5c <memset+0x1c>
80105d57:	f6 c1 03             	test   $0x3,%cl
80105d5a:	74 14                	je     80105d70 <memset+0x30>
  asm volatile("cld; rep stosb" :
80105d5c:	89 d7                	mov    %edx,%edi
80105d5e:	8b 45 0c             	mov    0xc(%ebp),%eax
80105d61:	fc                   	cld    
80105d62:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80105d64:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105d67:	89 d0                	mov    %edx,%eax
80105d69:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105d6c:	89 ec                	mov    %ebp,%esp
80105d6e:	5d                   	pop    %ebp
80105d6f:	c3                   	ret    
    c &= 0xFF;
80105d70:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80105d74:	c1 e9 02             	shr    $0x2,%ecx
80105d77:	89 f8                	mov    %edi,%eax
80105d79:	89 fb                	mov    %edi,%ebx
80105d7b:	c1 e0 18             	shl    $0x18,%eax
80105d7e:	c1 e3 10             	shl    $0x10,%ebx
80105d81:	09 d8                	or     %ebx,%eax
80105d83:	09 f8                	or     %edi,%eax
80105d85:	c1 e7 08             	shl    $0x8,%edi
80105d88:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80105d8a:	89 d7                	mov    %edx,%edi
80105d8c:	fc                   	cld    
80105d8d:	f3 ab                	rep stos %eax,%es:(%edi)
}
80105d8f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105d92:	89 d0                	mov    %edx,%eax
80105d94:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105d97:	89 ec                	mov    %ebp,%esp
80105d99:	5d                   	pop    %ebp
80105d9a:	c3                   	ret    
80105d9b:	90                   	nop
80105d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105da0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105da0:	55                   	push   %ebp
80105da1:	89 e5                	mov    %esp,%ebp
80105da3:	57                   	push   %edi
80105da4:	8b 7d 0c             	mov    0xc(%ebp),%edi
80105da7:	56                   	push   %esi
80105da8:	8b 75 08             	mov    0x8(%ebp),%esi
80105dab:	53                   	push   %ebx
80105dac:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105daf:	85 db                	test   %ebx,%ebx
80105db1:	74 27                	je     80105dda <memcmp+0x3a>
    if(*s1 != *s2)
80105db3:	0f b6 16             	movzbl (%esi),%edx
80105db6:	0f b6 0f             	movzbl (%edi),%ecx
80105db9:	38 d1                	cmp    %dl,%cl
80105dbb:	75 2b                	jne    80105de8 <memcmp+0x48>
80105dbd:	b8 01 00 00 00       	mov    $0x1,%eax
80105dc2:	eb 12                	jmp    80105dd6 <memcmp+0x36>
80105dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105dc8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80105dcc:	40                   	inc    %eax
80105dcd:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80105dd2:	38 ca                	cmp    %cl,%dl
80105dd4:	75 12                	jne    80105de8 <memcmp+0x48>
  while(n-- > 0){
80105dd6:	39 d8                	cmp    %ebx,%eax
80105dd8:	75 ee                	jne    80105dc8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80105dda:	5b                   	pop    %ebx
  return 0;
80105ddb:	31 c0                	xor    %eax,%eax
}
80105ddd:	5e                   	pop    %esi
80105dde:	5f                   	pop    %edi
80105ddf:	5d                   	pop    %ebp
80105de0:	c3                   	ret    
80105de1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105de8:	5b                   	pop    %ebx
      return *s1 - *s2;
80105de9:	0f b6 c2             	movzbl %dl,%eax
80105dec:	29 c8                	sub    %ecx,%eax
}
80105dee:	5e                   	pop    %esi
80105def:	5f                   	pop    %edi
80105df0:	5d                   	pop    %ebp
80105df1:	c3                   	ret    
80105df2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e00 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105e00:	55                   	push   %ebp
80105e01:	89 e5                	mov    %esp,%ebp
80105e03:	56                   	push   %esi
80105e04:	8b 45 08             	mov    0x8(%ebp),%eax
80105e07:	53                   	push   %ebx
80105e08:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80105e0b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80105e0e:	39 c3                	cmp    %eax,%ebx
80105e10:	73 26                	jae    80105e38 <memmove+0x38>
80105e12:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80105e15:	39 c8                	cmp    %ecx,%eax
80105e17:	73 1f                	jae    80105e38 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80105e19:	85 f6                	test   %esi,%esi
80105e1b:	8d 56 ff             	lea    -0x1(%esi),%edx
80105e1e:	74 0d                	je     80105e2d <memmove+0x2d>
      *--d = *--s;
80105e20:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105e24:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80105e27:	4a                   	dec    %edx
80105e28:	83 fa ff             	cmp    $0xffffffff,%edx
80105e2b:	75 f3                	jne    80105e20 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80105e2d:	5b                   	pop    %ebx
80105e2e:	5e                   	pop    %esi
80105e2f:	5d                   	pop    %ebp
80105e30:	c3                   	ret    
80105e31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80105e38:	31 d2                	xor    %edx,%edx
80105e3a:	85 f6                	test   %esi,%esi
80105e3c:	74 ef                	je     80105e2d <memmove+0x2d>
80105e3e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80105e40:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105e44:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80105e47:	42                   	inc    %edx
    while(n-- > 0)
80105e48:	39 d6                	cmp    %edx,%esi
80105e4a:	75 f4                	jne    80105e40 <memmove+0x40>
}
80105e4c:	5b                   	pop    %ebx
80105e4d:	5e                   	pop    %esi
80105e4e:	5d                   	pop    %ebp
80105e4f:	c3                   	ret    

80105e50 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105e50:	55                   	push   %ebp
80105e51:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80105e53:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80105e54:	eb aa                	jmp    80105e00 <memmove>
80105e56:	8d 76 00             	lea    0x0(%esi),%esi
80105e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e60 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80105e60:	55                   	push   %ebp
80105e61:	89 e5                	mov    %esp,%ebp
80105e63:	57                   	push   %edi
80105e64:	8b 7d 10             	mov    0x10(%ebp),%edi
80105e67:	56                   	push   %esi
80105e68:	8b 75 0c             	mov    0xc(%ebp),%esi
80105e6b:	53                   	push   %ebx
80105e6c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
80105e6f:	85 ff                	test   %edi,%edi
80105e71:	74 2d                	je     80105ea0 <strncmp+0x40>
80105e73:	0f b6 03             	movzbl (%ebx),%eax
80105e76:	0f b6 0e             	movzbl (%esi),%ecx
80105e79:	84 c0                	test   %al,%al
80105e7b:	74 37                	je     80105eb4 <strncmp+0x54>
80105e7d:	38 c1                	cmp    %al,%cl
80105e7f:	75 33                	jne    80105eb4 <strncmp+0x54>
80105e81:	01 f7                	add    %esi,%edi
80105e83:	eb 13                	jmp    80105e98 <strncmp+0x38>
80105e85:	8d 76 00             	lea    0x0(%esi),%esi
80105e88:	0f b6 03             	movzbl (%ebx),%eax
80105e8b:	84 c0                	test   %al,%al
80105e8d:	74 21                	je     80105eb0 <strncmp+0x50>
80105e8f:	0f b6 0a             	movzbl (%edx),%ecx
80105e92:	89 d6                	mov    %edx,%esi
80105e94:	38 c8                	cmp    %cl,%al
80105e96:	75 1c                	jne    80105eb4 <strncmp+0x54>
    n--, p++, q++;
80105e98:	8d 56 01             	lea    0x1(%esi),%edx
80105e9b:	43                   	inc    %ebx
  while(n > 0 && *p && *p == *q)
80105e9c:	39 fa                	cmp    %edi,%edx
80105e9e:	75 e8                	jne    80105e88 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80105ea0:	5b                   	pop    %ebx
    return 0;
80105ea1:	31 c0                	xor    %eax,%eax
}
80105ea3:	5e                   	pop    %esi
80105ea4:	5f                   	pop    %edi
80105ea5:	5d                   	pop    %ebp
80105ea6:	c3                   	ret    
80105ea7:	89 f6                	mov    %esi,%esi
80105ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105eb0:	0f b6 4e 01          	movzbl 0x1(%esi),%ecx
80105eb4:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
80105eb5:	29 c8                	sub    %ecx,%eax
}
80105eb7:	5e                   	pop    %esi
80105eb8:	5f                   	pop    %edi
80105eb9:	5d                   	pop    %ebp
80105eba:	c3                   	ret    
80105ebb:	90                   	nop
80105ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ec0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105ec0:	55                   	push   %ebp
80105ec1:	89 e5                	mov    %esp,%ebp
80105ec3:	8b 45 08             	mov    0x8(%ebp),%eax
80105ec6:	56                   	push   %esi
80105ec7:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105eca:	53                   	push   %ebx
80105ecb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80105ece:	89 c2                	mov    %eax,%edx
80105ed0:	eb 15                	jmp    80105ee7 <strncpy+0x27>
80105ed2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105ed8:	46                   	inc    %esi
80105ed9:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
80105edd:	42                   	inc    %edx
80105ede:	84 c9                	test   %cl,%cl
80105ee0:	88 4a ff             	mov    %cl,-0x1(%edx)
80105ee3:	74 09                	je     80105eee <strncpy+0x2e>
80105ee5:	89 d9                	mov    %ebx,%ecx
80105ee7:	85 c9                	test   %ecx,%ecx
80105ee9:	8d 59 ff             	lea    -0x1(%ecx),%ebx
80105eec:	7f ea                	jg     80105ed8 <strncpy+0x18>
    ;
  while(n-- > 0)
80105eee:	31 c9                	xor    %ecx,%ecx
80105ef0:	85 db                	test   %ebx,%ebx
80105ef2:	7e 19                	jle    80105f0d <strncpy+0x4d>
80105ef4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105efa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *s++ = 0;
80105f00:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80105f04:	89 de                	mov    %ebx,%esi
80105f06:	41                   	inc    %ecx
80105f07:	29 ce                	sub    %ecx,%esi
  while(n-- > 0)
80105f09:	85 f6                	test   %esi,%esi
80105f0b:	7f f3                	jg     80105f00 <strncpy+0x40>
  return os;
}
80105f0d:	5b                   	pop    %ebx
80105f0e:	5e                   	pop    %esi
80105f0f:	5d                   	pop    %ebp
80105f10:	c3                   	ret    
80105f11:	eb 0d                	jmp    80105f20 <safestrcpy>
80105f13:	90                   	nop
80105f14:	90                   	nop
80105f15:	90                   	nop
80105f16:	90                   	nop
80105f17:	90                   	nop
80105f18:	90                   	nop
80105f19:	90                   	nop
80105f1a:	90                   	nop
80105f1b:	90                   	nop
80105f1c:	90                   	nop
80105f1d:	90                   	nop
80105f1e:	90                   	nop
80105f1f:	90                   	nop

80105f20 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105f20:	55                   	push   %ebp
80105f21:	89 e5                	mov    %esp,%ebp
80105f23:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105f26:	56                   	push   %esi
80105f27:	8b 45 08             	mov    0x8(%ebp),%eax
80105f2a:	53                   	push   %ebx
80105f2b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80105f2e:	85 c9                	test   %ecx,%ecx
80105f30:	7e 22                	jle    80105f54 <safestrcpy+0x34>
80105f32:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80105f36:	89 c1                	mov    %eax,%ecx
80105f38:	eb 13                	jmp    80105f4d <safestrcpy+0x2d>
80105f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105f40:	42                   	inc    %edx
80105f41:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80105f45:	41                   	inc    %ecx
80105f46:	84 db                	test   %bl,%bl
80105f48:	88 59 ff             	mov    %bl,-0x1(%ecx)
80105f4b:	74 04                	je     80105f51 <safestrcpy+0x31>
80105f4d:	39 f2                	cmp    %esi,%edx
80105f4f:	75 ef                	jne    80105f40 <safestrcpy+0x20>
    ;
  *s = 0;
80105f51:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80105f54:	5b                   	pop    %ebx
80105f55:	5e                   	pop    %esi
80105f56:	5d                   	pop    %ebp
80105f57:	c3                   	ret    
80105f58:	90                   	nop
80105f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105f60 <strlen>:

int
strlen(const char *s)
{
80105f60:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105f61:	31 c0                	xor    %eax,%eax
{
80105f63:	89 e5                	mov    %esp,%ebp
80105f65:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105f68:	80 3a 00             	cmpb   $0x0,(%edx)
80105f6b:	74 0a                	je     80105f77 <strlen+0x17>
80105f6d:	8d 76 00             	lea    0x0(%esi),%esi
80105f70:	40                   	inc    %eax
80105f71:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105f75:	75 f9                	jne    80105f70 <strlen+0x10>
    ;
  return n;
}
80105f77:	5d                   	pop    %ebp
80105f78:	c3                   	ret    

80105f79 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80105f79:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80105f7d:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80105f81:	55                   	push   %ebp
  pushl %ebx
80105f82:	53                   	push   %ebx
  pushl %esi
80105f83:	56                   	push   %esi
  pushl %edi
80105f84:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105f85:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105f87:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80105f89:	5f                   	pop    %edi
  popl %esi
80105f8a:	5e                   	pop    %esi
  popl %ebx
80105f8b:	5b                   	pop    %ebx
  popl %ebp
80105f8c:	5d                   	pop    %ebp
  ret
80105f8d:	c3                   	ret    
80105f8e:	66 90                	xchg   %ax,%ax

80105f90 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105f90:	55                   	push   %ebp
80105f91:	89 e5                	mov    %esp,%ebp
80105f93:	53                   	push   %ebx
80105f94:	83 ec 04             	sub    $0x4,%esp
80105f97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80105f9a:	e8 01 da ff ff       	call   801039a0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105f9f:	8b 00                	mov    (%eax),%eax
80105fa1:	39 d8                	cmp    %ebx,%eax
80105fa3:	76 1b                	jbe    80105fc0 <fetchint+0x30>
80105fa5:	8d 53 04             	lea    0x4(%ebx),%edx
80105fa8:	39 d0                	cmp    %edx,%eax
80105faa:	72 14                	jb     80105fc0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80105fac:	8b 45 0c             	mov    0xc(%ebp),%eax
80105faf:	8b 13                	mov    (%ebx),%edx
80105fb1:	89 10                	mov    %edx,(%eax)
  return 0;
80105fb3:	31 c0                	xor    %eax,%eax
}
80105fb5:	5a                   	pop    %edx
80105fb6:	5b                   	pop    %ebx
80105fb7:	5d                   	pop    %ebp
80105fb8:	c3                   	ret    
80105fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105fc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fc5:	eb ee                	jmp    80105fb5 <fetchint+0x25>
80105fc7:	89 f6                	mov    %esi,%esi
80105fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105fd0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105fd0:	55                   	push   %ebp
80105fd1:	89 e5                	mov    %esp,%ebp
80105fd3:	53                   	push   %ebx
80105fd4:	83 ec 04             	sub    $0x4,%esp
80105fd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80105fda:	e8 c1 d9 ff ff       	call   801039a0 <myproc>

  if(addr >= curproc->sz)
80105fdf:	39 18                	cmp    %ebx,(%eax)
80105fe1:	76 27                	jbe    8010600a <fetchstr+0x3a>
    return -1;
  *pp = (char*)addr;
80105fe3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105fe6:	89 da                	mov    %ebx,%edx
80105fe8:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80105fea:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80105fec:	39 c3                	cmp    %eax,%ebx
80105fee:	73 1a                	jae    8010600a <fetchstr+0x3a>
    if(*s == 0)
80105ff0:	80 3b 00             	cmpb   $0x0,(%ebx)
80105ff3:	75 10                	jne    80106005 <fetchstr+0x35>
80105ff5:	eb 29                	jmp    80106020 <fetchstr+0x50>
80105ff7:	89 f6                	mov    %esi,%esi
80105ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106000:	80 3a 00             	cmpb   $0x0,(%edx)
80106003:	74 13                	je     80106018 <fetchstr+0x48>
  for(s = *pp; s < ep; s++){
80106005:	42                   	inc    %edx
80106006:	39 d0                	cmp    %edx,%eax
80106008:	77 f6                	ja     80106000 <fetchstr+0x30>
    return -1;
8010600a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
8010600f:	5a                   	pop    %edx
80106010:	5b                   	pop    %ebx
80106011:	5d                   	pop    %ebp
80106012:	c3                   	ret    
80106013:	90                   	nop
80106014:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106018:	89 d0                	mov    %edx,%eax
8010601a:	5a                   	pop    %edx
8010601b:	29 d8                	sub    %ebx,%eax
8010601d:	5b                   	pop    %ebx
8010601e:	5d                   	pop    %ebp
8010601f:	c3                   	ret    
    if(*s == 0)
80106020:	31 c0                	xor    %eax,%eax
      return s - *pp;
80106022:	eb eb                	jmp    8010600f <fetchstr+0x3f>
80106024:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010602a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106030 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80106030:	55                   	push   %ebp
80106031:	89 e5                	mov    %esp,%ebp
80106033:	56                   	push   %esi
80106034:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80106035:	e8 66 d9 ff ff       	call   801039a0 <myproc>
8010603a:	8b 55 08             	mov    0x8(%ebp),%edx
8010603d:	8b 40 18             	mov    0x18(%eax),%eax
80106040:	8b 40 44             	mov    0x44(%eax),%eax
80106043:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80106046:	e8 55 d9 ff ff       	call   801039a0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010604b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010604e:	8b 00                	mov    (%eax),%eax
80106050:	39 c6                	cmp    %eax,%esi
80106052:	73 1c                	jae    80106070 <argint+0x40>
80106054:	8d 53 08             	lea    0x8(%ebx),%edx
80106057:	39 d0                	cmp    %edx,%eax
80106059:	72 15                	jb     80106070 <argint+0x40>
  *ip = *(int*)(addr);
8010605b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010605e:	8b 53 04             	mov    0x4(%ebx),%edx
80106061:	89 10                	mov    %edx,(%eax)
  return 0;
80106063:	31 c0                	xor    %eax,%eax
}
80106065:	5b                   	pop    %ebx
80106066:	5e                   	pop    %esi
80106067:	5d                   	pop    %ebp
80106068:	c3                   	ret    
80106069:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106070:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80106075:	eb ee                	jmp    80106065 <argint+0x35>
80106077:	89 f6                	mov    %esi,%esi
80106079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106080 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80106080:	55                   	push   %ebp
80106081:	89 e5                	mov    %esp,%ebp
80106083:	56                   	push   %esi
80106084:	53                   	push   %ebx
80106085:	83 ec 20             	sub    $0x20,%esp
80106088:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010608b:	e8 10 d9 ff ff       	call   801039a0 <myproc>
80106090:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80106092:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106095:	89 44 24 04          	mov    %eax,0x4(%esp)
80106099:	8b 45 08             	mov    0x8(%ebp),%eax
8010609c:	89 04 24             	mov    %eax,(%esp)
8010609f:	e8 8c ff ff ff       	call   80106030 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801060a4:	c1 e8 1f             	shr    $0x1f,%eax
801060a7:	84 c0                	test   %al,%al
801060a9:	75 2d                	jne    801060d8 <argptr+0x58>
801060ab:	89 d8                	mov    %ebx,%eax
801060ad:	c1 e8 1f             	shr    $0x1f,%eax
801060b0:	84 c0                	test   %al,%al
801060b2:	75 24                	jne    801060d8 <argptr+0x58>
801060b4:	8b 16                	mov    (%esi),%edx
801060b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060b9:	39 c2                	cmp    %eax,%edx
801060bb:	76 1b                	jbe    801060d8 <argptr+0x58>
801060bd:	01 c3                	add    %eax,%ebx
801060bf:	39 da                	cmp    %ebx,%edx
801060c1:	72 15                	jb     801060d8 <argptr+0x58>
    return -1;
  *pp = (char*)i;
801060c3:	8b 55 0c             	mov    0xc(%ebp),%edx
801060c6:	89 02                	mov    %eax,(%edx)
  return 0;
801060c8:	31 c0                	xor    %eax,%eax
}
801060ca:	83 c4 20             	add    $0x20,%esp
801060cd:	5b                   	pop    %ebx
801060ce:	5e                   	pop    %esi
801060cf:	5d                   	pop    %ebp
801060d0:	c3                   	ret    
801060d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801060d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060dd:	eb eb                	jmp    801060ca <argptr+0x4a>
801060df:	90                   	nop

801060e0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801060e0:	55                   	push   %ebp
801060e1:	89 e5                	mov    %esp,%ebp
801060e3:	83 ec 28             	sub    $0x28,%esp
  int addr;
  if(argint(n, &addr) < 0)
801060e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801060e9:	89 44 24 04          	mov    %eax,0x4(%esp)
801060ed:	8b 45 08             	mov    0x8(%ebp),%eax
801060f0:	89 04 24             	mov    %eax,(%esp)
801060f3:	e8 38 ff ff ff       	call   80106030 <argint>
801060f8:	85 c0                	test   %eax,%eax
801060fa:	78 14                	js     80106110 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
801060fc:	8b 45 0c             	mov    0xc(%ebp),%eax
801060ff:	89 44 24 04          	mov    %eax,0x4(%esp)
80106103:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106106:	89 04 24             	mov    %eax,(%esp)
80106109:	e8 c2 fe ff ff       	call   80105fd0 <fetchstr>
}
8010610e:	c9                   	leave  
8010610f:	c3                   	ret    
    return -1;
80106110:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106115:	c9                   	leave  
80106116:	c3                   	ret    
80106117:	89 f6                	mov    %esi,%esi
80106119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106120 <syscall>:
[SYS_wait_stat] sys_wait_stat,
};

void
syscall(void)
{
80106120:	55                   	push   %ebp
80106121:	89 e5                	mov    %esp,%ebp
80106123:	53                   	push   %ebx
80106124:	83 ec 14             	sub    $0x14,%esp
  int num;
  struct proc *curproc = myproc();
80106127:	e8 74 d8 ff ff       	call   801039a0 <myproc>
8010612c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010612e:	8b 40 18             	mov    0x18(%eax),%eax
80106131:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80106134:	8d 50 ff             	lea    -0x1(%eax),%edx
80106137:	83 fa 18             	cmp    $0x18,%edx
8010613a:	77 1c                	ja     80106158 <syscall+0x38>
8010613c:	8b 14 85 c0 90 10 80 	mov    -0x7fef6f40(,%eax,4),%edx
80106143:	85 d2                	test   %edx,%edx
80106145:	74 11                	je     80106158 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80106147:	ff d2                	call   *%edx
80106149:	8b 53 18             	mov    0x18(%ebx),%edx
8010614c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
8010614f:	83 c4 14             	add    $0x14,%esp
80106152:	5b                   	pop    %ebx
80106153:	5d                   	pop    %ebp
80106154:	c3                   	ret    
80106155:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80106158:	89 44 24 0c          	mov    %eax,0xc(%esp)
            curproc->pid, curproc->name, num);
8010615c:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010615f:	89 44 24 08          	mov    %eax,0x8(%esp)
    cprintf("%d %s: unknown sys call %d\n",
80106163:	8b 43 10             	mov    0x10(%ebx),%eax
80106166:	c7 04 24 88 90 10 80 	movl   $0x80109088,(%esp)
8010616d:	89 44 24 04          	mov    %eax,0x4(%esp)
80106171:	e8 da a4 ff ff       	call   80100650 <cprintf>
    curproc->tf->eax = -1;
80106176:	8b 43 18             	mov    0x18(%ebx),%eax
80106179:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80106180:	83 c4 14             	add    $0x14,%esp
80106183:	5b                   	pop    %ebx
80106184:	5d                   	pop    %ebp
80106185:	c3                   	ret    
80106186:	66 90                	xchg   %ax,%ax
80106188:	66 90                	xchg   %ax,%ax
8010618a:	66 90                	xchg   %ax,%ax
8010618c:	66 90                	xchg   %ax,%ax
8010618e:	66 90                	xchg   %ax,%ax

80106190 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80106190:	55                   	push   %ebp
80106191:	0f bf d2             	movswl %dx,%edx
80106194:	89 e5                	mov    %esp,%ebp
80106196:	83 ec 58             	sub    $0x58,%esp
80106199:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010619c:	0f bf 7d 08          	movswl 0x8(%ebp),%edi
801061a0:	0f bf c9             	movswl %cx,%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801061a3:	89 04 24             	mov    %eax,(%esp)
{
801061a6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801061a9:	89 75 f8             	mov    %esi,-0x8(%ebp)
801061ac:	89 7d bc             	mov    %edi,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801061af:	8d 7d da             	lea    -0x26(%ebp),%edi
801061b2:	89 7c 24 04          	mov    %edi,0x4(%esp)
{
801061b6:	89 55 c4             	mov    %edx,-0x3c(%ebp)
801061b9:	89 4d c0             	mov    %ecx,-0x40(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801061bc:	e8 2f be ff ff       	call   80101ff0 <nameiparent>
801061c1:	85 c0                	test   %eax,%eax
801061c3:	0f 84 4f 01 00 00    	je     80106318 <create+0x188>
    return 0;
  ilock(dp);
801061c9:	89 04 24             	mov    %eax,(%esp)
801061cc:	89 c3                	mov    %eax,%ebx
801061ce:	e8 1d b5 ff ff       	call   801016f0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
801061d3:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801061d6:	89 44 24 08          	mov    %eax,0x8(%esp)
801061da:	89 7c 24 04          	mov    %edi,0x4(%esp)
801061de:	89 1c 24             	mov    %ebx,(%esp)
801061e1:	e8 8a ba ff ff       	call   80101c70 <dirlookup>
801061e6:	85 c0                	test   %eax,%eax
801061e8:	89 c6                	mov    %eax,%esi
801061ea:	74 34                	je     80106220 <create+0x90>
    iunlockput(dp);
801061ec:	89 1c 24             	mov    %ebx,(%esp)
801061ef:	e8 8c b7 ff ff       	call   80101980 <iunlockput>
    ilock(ip);
801061f4:	89 34 24             	mov    %esi,(%esp)
801061f7:	e8 f4 b4 ff ff       	call   801016f0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801061fc:	83 7d c4 02          	cmpl   $0x2,-0x3c(%ebp)
80106200:	0f 85 9a 00 00 00    	jne    801062a0 <create+0x110>
80106206:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010620b:	0f 85 8f 00 00 00    	jne    801062a0 <create+0x110>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80106211:	89 f0                	mov    %esi,%eax
80106213:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80106216:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106219:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010621c:	89 ec                	mov    %ebp,%esp
8010621e:	5d                   	pop    %ebp
8010621f:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80106220:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80106223:	89 44 24 04          	mov    %eax,0x4(%esp)
80106227:	8b 03                	mov    (%ebx),%eax
80106229:	89 04 24             	mov    %eax,(%esp)
8010622c:	e8 3f b3 ff ff       	call   80101570 <ialloc>
80106231:	85 c0                	test   %eax,%eax
80106233:	89 c6                	mov    %eax,%esi
80106235:	0f 84 f0 00 00 00    	je     8010632b <create+0x19b>
  ilock(ip);
8010623b:	89 04 24             	mov    %eax,(%esp)
8010623e:	e8 ad b4 ff ff       	call   801016f0 <ilock>
  ip->major = major;
80106243:	8b 45 c0             	mov    -0x40(%ebp),%eax
  ip->nlink = 1;
80106246:	66 c7 46 56 01 00    	movw   $0x1,0x56(%esi)
  ip->major = major;
8010624c:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80106250:	8b 45 bc             	mov    -0x44(%ebp),%eax
80106253:	66 89 46 54          	mov    %ax,0x54(%esi)
  iupdate(ip);
80106257:	89 34 24             	mov    %esi,(%esp)
8010625a:	e8 d1 b3 ff ff       	call   80101630 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
8010625f:	83 7d c4 01          	cmpl   $0x1,-0x3c(%ebp)
80106263:	74 5b                	je     801062c0 <create+0x130>
  if(dirlink(dp, name, ip->inum) < 0)
80106265:	8b 46 04             	mov    0x4(%esi),%eax
80106268:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010626c:	89 1c 24             	mov    %ebx,(%esp)
8010626f:	89 44 24 08          	mov    %eax,0x8(%esp)
80106273:	e8 78 bc ff ff       	call   80101ef0 <dirlink>
80106278:	85 c0                	test   %eax,%eax
8010627a:	0f 88 9f 00 00 00    	js     8010631f <create+0x18f>
  iunlockput(dp);
80106280:	89 1c 24             	mov    %ebx,(%esp)
80106283:	e8 f8 b6 ff ff       	call   80101980 <iunlockput>
}
80106288:	89 f0                	mov    %esi,%eax
8010628a:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010628d:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106290:	8b 7d fc             	mov    -0x4(%ebp),%edi
80106293:	89 ec                	mov    %ebp,%esp
80106295:	5d                   	pop    %ebp
80106296:	c3                   	ret    
80106297:	89 f6                	mov    %esi,%esi
80106299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
801062a0:	89 34 24             	mov    %esi,(%esp)
    return 0;
801062a3:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
801062a5:	e8 d6 b6 ff ff       	call   80101980 <iunlockput>
}
801062aa:	89 f0                	mov    %esi,%eax
801062ac:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801062af:	8b 75 f8             	mov    -0x8(%ebp),%esi
801062b2:	8b 7d fc             	mov    -0x4(%ebp),%edi
801062b5:	89 ec                	mov    %ebp,%esp
801062b7:	5d                   	pop    %ebp
801062b8:	c3                   	ret    
801062b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
801062c0:	66 ff 43 56          	incw   0x56(%ebx)
    iupdate(dp);
801062c4:	89 1c 24             	mov    %ebx,(%esp)
801062c7:	e8 64 b3 ff ff       	call   80101630 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801062cc:	8b 46 04             	mov    0x4(%esi),%eax
801062cf:	ba 44 91 10 80       	mov    $0x80109144,%edx
801062d4:	89 54 24 04          	mov    %edx,0x4(%esp)
801062d8:	89 34 24             	mov    %esi,(%esp)
801062db:	89 44 24 08          	mov    %eax,0x8(%esp)
801062df:	e8 0c bc ff ff       	call   80101ef0 <dirlink>
801062e4:	85 c0                	test   %eax,%eax
801062e6:	78 20                	js     80106308 <create+0x178>
801062e8:	8b 43 04             	mov    0x4(%ebx),%eax
801062eb:	89 34 24             	mov    %esi,(%esp)
801062ee:	89 44 24 08          	mov    %eax,0x8(%esp)
801062f2:	b8 43 91 10 80       	mov    $0x80109143,%eax
801062f7:	89 44 24 04          	mov    %eax,0x4(%esp)
801062fb:	e8 f0 bb ff ff       	call   80101ef0 <dirlink>
80106300:	85 c0                	test   %eax,%eax
80106302:	0f 89 5d ff ff ff    	jns    80106265 <create+0xd5>
      panic("create dots");
80106308:	c7 04 24 37 91 10 80 	movl   $0x80109137,(%esp)
8010630f:	e8 5c a0 ff ff       	call   80100370 <panic>
80106314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80106318:	31 f6                	xor    %esi,%esi
8010631a:	e9 f2 fe ff ff       	jmp    80106211 <create+0x81>
    panic("create: dirlink");
8010631f:	c7 04 24 46 91 10 80 	movl   $0x80109146,(%esp)
80106326:	e8 45 a0 ff ff       	call   80100370 <panic>
    panic("create: ialloc");
8010632b:	c7 04 24 28 91 10 80 	movl   $0x80109128,(%esp)
80106332:	e8 39 a0 ff ff       	call   80100370 <panic>
80106337:	89 f6                	mov    %esi,%esi
80106339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106340 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80106340:	55                   	push   %ebp
80106341:	89 e5                	mov    %esp,%ebp
80106343:	56                   	push   %esi
80106344:	89 d6                	mov    %edx,%esi
80106346:	53                   	push   %ebx
80106347:	89 c3                	mov    %eax,%ebx
80106349:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
8010634c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010634f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106353:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010635a:	e8 d1 fc ff ff       	call   80106030 <argint>
8010635f:	85 c0                	test   %eax,%eax
80106361:	78 2d                	js     80106390 <argfd.constprop.0+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80106363:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80106367:	77 27                	ja     80106390 <argfd.constprop.0+0x50>
80106369:	e8 32 d6 ff ff       	call   801039a0 <myproc>
8010636e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106371:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80106375:	85 c0                	test   %eax,%eax
80106377:	74 17                	je     80106390 <argfd.constprop.0+0x50>
  if(pfd)
80106379:	85 db                	test   %ebx,%ebx
8010637b:	74 02                	je     8010637f <argfd.constprop.0+0x3f>
    *pfd = fd;
8010637d:	89 13                	mov    %edx,(%ebx)
    *pf = f;
8010637f:	89 06                	mov    %eax,(%esi)
  return 0;
80106381:	31 c0                	xor    %eax,%eax
}
80106383:	83 c4 20             	add    $0x20,%esp
80106386:	5b                   	pop    %ebx
80106387:	5e                   	pop    %esi
80106388:	5d                   	pop    %ebp
80106389:	c3                   	ret    
8010638a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106390:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106395:	eb ec                	jmp    80106383 <argfd.constprop.0+0x43>
80106397:	89 f6                	mov    %esi,%esi
80106399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801063a0 <sys_dup>:
{
801063a0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
801063a1:	31 c0                	xor    %eax,%eax
{
801063a3:	89 e5                	mov    %esp,%ebp
801063a5:	56                   	push   %esi
801063a6:	53                   	push   %ebx
801063a7:	83 ec 20             	sub    $0x20,%esp
  if(argfd(0, 0, &f) < 0)
801063aa:	8d 55 f4             	lea    -0xc(%ebp),%edx
801063ad:	e8 8e ff ff ff       	call   80106340 <argfd.constprop.0>
801063b2:	85 c0                	test   %eax,%eax
801063b4:	78 3a                	js     801063f0 <sys_dup+0x50>
  if((fd=fdalloc(f)) < 0)
801063b6:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
801063b9:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801063bb:	e8 e0 d5 ff ff       	call   801039a0 <myproc>
801063c0:	eb 0c                	jmp    801063ce <sys_dup+0x2e>
801063c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
801063c8:	43                   	inc    %ebx
801063c9:	83 fb 10             	cmp    $0x10,%ebx
801063cc:	74 22                	je     801063f0 <sys_dup+0x50>
    if(curproc->ofile[fd] == 0){
801063ce:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801063d2:	85 d2                	test   %edx,%edx
801063d4:	75 f2                	jne    801063c8 <sys_dup+0x28>
      curproc->ofile[fd] = f;
801063d6:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
801063da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063dd:	89 04 24             	mov    %eax,(%esp)
801063e0:	e8 fb a9 ff ff       	call   80100de0 <filedup>
}
801063e5:	83 c4 20             	add    $0x20,%esp
801063e8:	89 d8                	mov    %ebx,%eax
801063ea:	5b                   	pop    %ebx
801063eb:	5e                   	pop    %esi
801063ec:	5d                   	pop    %ebp
801063ed:	c3                   	ret    
801063ee:	66 90                	xchg   %ax,%ax
801063f0:	83 c4 20             	add    $0x20,%esp
    return -1;
801063f3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
801063f8:	89 d8                	mov    %ebx,%eax
801063fa:	5b                   	pop    %ebx
801063fb:	5e                   	pop    %esi
801063fc:	5d                   	pop    %ebp
801063fd:	c3                   	ret    
801063fe:	66 90                	xchg   %ax,%ax

80106400 <sys_read>:
{
80106400:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106401:	31 c0                	xor    %eax,%eax
{
80106403:	89 e5                	mov    %esp,%ebp
80106405:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106408:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010640b:	e8 30 ff ff ff       	call   80106340 <argfd.constprop.0>
80106410:	85 c0                	test   %eax,%eax
80106412:	78 54                	js     80106468 <sys_read+0x68>
80106414:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106417:	89 44 24 04          	mov    %eax,0x4(%esp)
8010641b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106422:	e8 09 fc ff ff       	call   80106030 <argint>
80106427:	85 c0                	test   %eax,%eax
80106429:	78 3d                	js     80106468 <sys_read+0x68>
8010642b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010642e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106435:	89 44 24 08          	mov    %eax,0x8(%esp)
80106439:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010643c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106440:	e8 3b fc ff ff       	call   80106080 <argptr>
80106445:	85 c0                	test   %eax,%eax
80106447:	78 1f                	js     80106468 <sys_read+0x68>
  return fileread(f, p, n);
80106449:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010644c:	89 44 24 08          	mov    %eax,0x8(%esp)
80106450:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106453:	89 44 24 04          	mov    %eax,0x4(%esp)
80106457:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010645a:	89 04 24             	mov    %eax,(%esp)
8010645d:	e8 fe aa ff ff       	call   80100f60 <fileread>
}
80106462:	c9                   	leave  
80106463:	c3                   	ret    
80106464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106468:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010646d:	c9                   	leave  
8010646e:	c3                   	ret    
8010646f:	90                   	nop

80106470 <sys_write>:
{
80106470:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106471:	31 c0                	xor    %eax,%eax
{
80106473:	89 e5                	mov    %esp,%ebp
80106475:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106478:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010647b:	e8 c0 fe ff ff       	call   80106340 <argfd.constprop.0>
80106480:	85 c0                	test   %eax,%eax
80106482:	78 54                	js     801064d8 <sys_write+0x68>
80106484:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106487:	89 44 24 04          	mov    %eax,0x4(%esp)
8010648b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106492:	e8 99 fb ff ff       	call   80106030 <argint>
80106497:	85 c0                	test   %eax,%eax
80106499:	78 3d                	js     801064d8 <sys_write+0x68>
8010649b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010649e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801064a5:	89 44 24 08          	mov    %eax,0x8(%esp)
801064a9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801064ac:	89 44 24 04          	mov    %eax,0x4(%esp)
801064b0:	e8 cb fb ff ff       	call   80106080 <argptr>
801064b5:	85 c0                	test   %eax,%eax
801064b7:	78 1f                	js     801064d8 <sys_write+0x68>
  return filewrite(f, p, n);
801064b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801064bc:	89 44 24 08          	mov    %eax,0x8(%esp)
801064c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064c3:	89 44 24 04          	mov    %eax,0x4(%esp)
801064c7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801064ca:	89 04 24             	mov    %eax,(%esp)
801064cd:	e8 3e ab ff ff       	call   80101010 <filewrite>
}
801064d2:	c9                   	leave  
801064d3:	c3                   	ret    
801064d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801064d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801064dd:	c9                   	leave  
801064de:	c3                   	ret    
801064df:	90                   	nop

801064e0 <sys_close>:
{
801064e0:	55                   	push   %ebp
801064e1:	89 e5                	mov    %esp,%ebp
801064e3:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, &fd, &f) < 0)
801064e6:	8d 55 f4             	lea    -0xc(%ebp),%edx
801064e9:	8d 45 f0             	lea    -0x10(%ebp),%eax
801064ec:	e8 4f fe ff ff       	call   80106340 <argfd.constprop.0>
801064f1:	85 c0                	test   %eax,%eax
801064f3:	78 23                	js     80106518 <sys_close+0x38>
  myproc()->ofile[fd] = 0;
801064f5:	e8 a6 d4 ff ff       	call   801039a0 <myproc>
801064fa:	8b 55 f0             	mov    -0x10(%ebp),%edx
801064fd:	31 c9                	xor    %ecx,%ecx
801064ff:	89 4c 90 28          	mov    %ecx,0x28(%eax,%edx,4)
  fileclose(f);
80106503:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106506:	89 04 24             	mov    %eax,(%esp)
80106509:	e8 22 a9 ff ff       	call   80100e30 <fileclose>
  return 0;
8010650e:	31 c0                	xor    %eax,%eax
}
80106510:	c9                   	leave  
80106511:	c3                   	ret    
80106512:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106518:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010651d:	c9                   	leave  
8010651e:	c3                   	ret    
8010651f:	90                   	nop

80106520 <sys_fstat>:
{
80106520:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80106521:	31 c0                	xor    %eax,%eax
{
80106523:	89 e5                	mov    %esp,%ebp
80106525:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80106528:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010652b:	e8 10 fe ff ff       	call   80106340 <argfd.constprop.0>
80106530:	85 c0                	test   %eax,%eax
80106532:	78 3c                	js     80106570 <sys_fstat+0x50>
80106534:	b8 14 00 00 00       	mov    $0x14,%eax
80106539:	89 44 24 08          	mov    %eax,0x8(%esp)
8010653d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106540:	89 44 24 04          	mov    %eax,0x4(%esp)
80106544:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010654b:	e8 30 fb ff ff       	call   80106080 <argptr>
80106550:	85 c0                	test   %eax,%eax
80106552:	78 1c                	js     80106570 <sys_fstat+0x50>
  return filestat(f, st);
80106554:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106557:	89 44 24 04          	mov    %eax,0x4(%esp)
8010655b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010655e:	89 04 24             	mov    %eax,(%esp)
80106561:	e8 aa a9 ff ff       	call   80100f10 <filestat>
}
80106566:	c9                   	leave  
80106567:	c3                   	ret    
80106568:	90                   	nop
80106569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106570:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106575:	c9                   	leave  
80106576:	c3                   	ret    
80106577:	89 f6                	mov    %esi,%esi
80106579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106580 <sys_link>:
{
80106580:	55                   	push   %ebp
80106581:	89 e5                	mov    %esp,%ebp
80106583:	57                   	push   %edi
80106584:	56                   	push   %esi
80106585:	53                   	push   %ebx
80106586:	83 ec 3c             	sub    $0x3c,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80106589:	8d 45 d4             	lea    -0x2c(%ebp),%eax
8010658c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106590:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106597:	e8 44 fb ff ff       	call   801060e0 <argstr>
8010659c:	85 c0                	test   %eax,%eax
8010659e:	0f 88 e5 00 00 00    	js     80106689 <sys_link+0x109>
801065a4:	8d 45 d0             	lea    -0x30(%ebp),%eax
801065a7:	89 44 24 04          	mov    %eax,0x4(%esp)
801065ab:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801065b2:	e8 29 fb ff ff       	call   801060e0 <argstr>
801065b7:	85 c0                	test   %eax,%eax
801065b9:	0f 88 ca 00 00 00    	js     80106689 <sys_link+0x109>
  begin_op();
801065bf:	e8 cc c6 ff ff       	call   80102c90 <begin_op>
  if((ip = namei(old)) == 0){
801065c4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801065c7:	89 04 24             	mov    %eax,(%esp)
801065ca:	e8 01 ba ff ff       	call   80101fd0 <namei>
801065cf:	85 c0                	test   %eax,%eax
801065d1:	89 c3                	mov    %eax,%ebx
801065d3:	0f 84 ab 00 00 00    	je     80106684 <sys_link+0x104>
  ilock(ip);
801065d9:	89 04 24             	mov    %eax,(%esp)
801065dc:	e8 0f b1 ff ff       	call   801016f0 <ilock>
  if(ip->type == T_DIR){
801065e1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801065e6:	0f 84 90 00 00 00    	je     8010667c <sys_link+0xfc>
  ip->nlink++;
801065ec:	66 ff 43 56          	incw   0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
801065f0:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801065f3:	89 1c 24             	mov    %ebx,(%esp)
801065f6:	e8 35 b0 ff ff       	call   80101630 <iupdate>
  iunlock(ip);
801065fb:	89 1c 24             	mov    %ebx,(%esp)
801065fe:	e8 cd b1 ff ff       	call   801017d0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80106603:	8b 45 d0             	mov    -0x30(%ebp),%eax
80106606:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010660a:	89 04 24             	mov    %eax,(%esp)
8010660d:	e8 de b9 ff ff       	call   80101ff0 <nameiparent>
80106612:	85 c0                	test   %eax,%eax
80106614:	89 c6                	mov    %eax,%esi
80106616:	74 50                	je     80106668 <sys_link+0xe8>
  ilock(dp);
80106618:	89 04 24             	mov    %eax,(%esp)
8010661b:	e8 d0 b0 ff ff       	call   801016f0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80106620:	8b 03                	mov    (%ebx),%eax
80106622:	39 06                	cmp    %eax,(%esi)
80106624:	75 3a                	jne    80106660 <sys_link+0xe0>
80106626:	8b 43 04             	mov    0x4(%ebx),%eax
80106629:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010662d:	89 34 24             	mov    %esi,(%esp)
80106630:	89 44 24 08          	mov    %eax,0x8(%esp)
80106634:	e8 b7 b8 ff ff       	call   80101ef0 <dirlink>
80106639:	85 c0                	test   %eax,%eax
8010663b:	78 23                	js     80106660 <sys_link+0xe0>
  iunlockput(dp);
8010663d:	89 34 24             	mov    %esi,(%esp)
80106640:	e8 3b b3 ff ff       	call   80101980 <iunlockput>
  iput(ip);
80106645:	89 1c 24             	mov    %ebx,(%esp)
80106648:	e8 d3 b1 ff ff       	call   80101820 <iput>
  end_op();
8010664d:	e8 ae c6 ff ff       	call   80102d00 <end_op>
}
80106652:	83 c4 3c             	add    $0x3c,%esp
  return 0;
80106655:	31 c0                	xor    %eax,%eax
}
80106657:	5b                   	pop    %ebx
80106658:	5e                   	pop    %esi
80106659:	5f                   	pop    %edi
8010665a:	5d                   	pop    %ebp
8010665b:	c3                   	ret    
8010665c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(dp);
80106660:	89 34 24             	mov    %esi,(%esp)
80106663:	e8 18 b3 ff ff       	call   80101980 <iunlockput>
  ilock(ip);
80106668:	89 1c 24             	mov    %ebx,(%esp)
8010666b:	e8 80 b0 ff ff       	call   801016f0 <ilock>
  ip->nlink--;
80106670:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
80106674:	89 1c 24             	mov    %ebx,(%esp)
80106677:	e8 b4 af ff ff       	call   80101630 <iupdate>
  iunlockput(ip);
8010667c:	89 1c 24             	mov    %ebx,(%esp)
8010667f:	e8 fc b2 ff ff       	call   80101980 <iunlockput>
  end_op();
80106684:	e8 77 c6 ff ff       	call   80102d00 <end_op>
}
80106689:	83 c4 3c             	add    $0x3c,%esp
  return -1;
8010668c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106691:	5b                   	pop    %ebx
80106692:	5e                   	pop    %esi
80106693:	5f                   	pop    %edi
80106694:	5d                   	pop    %ebp
80106695:	c3                   	ret    
80106696:	8d 76 00             	lea    0x0(%esi),%esi
80106699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801066a0 <sys_unlink>:
{
801066a0:	55                   	push   %ebp
801066a1:	89 e5                	mov    %esp,%ebp
801066a3:	57                   	push   %edi
801066a4:	56                   	push   %esi
801066a5:	53                   	push   %ebx
801066a6:	83 ec 5c             	sub    $0x5c,%esp
  if(argstr(0, &path) < 0)
801066a9:	8d 45 c0             	lea    -0x40(%ebp),%eax
801066ac:	89 44 24 04          	mov    %eax,0x4(%esp)
801066b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801066b7:	e8 24 fa ff ff       	call   801060e0 <argstr>
801066bc:	85 c0                	test   %eax,%eax
801066be:	0f 88 68 01 00 00    	js     8010682c <sys_unlink+0x18c>
  begin_op();
801066c4:	e8 c7 c5 ff ff       	call   80102c90 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801066c9:	8b 45 c0             	mov    -0x40(%ebp),%eax
801066cc:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801066cf:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801066d3:	89 04 24             	mov    %eax,(%esp)
801066d6:	e8 15 b9 ff ff       	call   80101ff0 <nameiparent>
801066db:	85 c0                	test   %eax,%eax
801066dd:	89 c6                	mov    %eax,%esi
801066df:	0f 84 42 01 00 00    	je     80106827 <sys_unlink+0x187>
  ilock(dp);
801066e5:	89 04 24             	mov    %eax,(%esp)
801066e8:	e8 03 b0 ff ff       	call   801016f0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801066ed:	b8 44 91 10 80       	mov    $0x80109144,%eax
801066f2:	89 44 24 04          	mov    %eax,0x4(%esp)
801066f6:	89 1c 24             	mov    %ebx,(%esp)
801066f9:	e8 42 b5 ff ff       	call   80101c40 <namecmp>
801066fe:	85 c0                	test   %eax,%eax
80106700:	0f 84 19 01 00 00    	je     8010681f <sys_unlink+0x17f>
80106706:	b8 43 91 10 80       	mov    $0x80109143,%eax
8010670b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010670f:	89 1c 24             	mov    %ebx,(%esp)
80106712:	e8 29 b5 ff ff       	call   80101c40 <namecmp>
80106717:	85 c0                	test   %eax,%eax
80106719:	0f 84 00 01 00 00    	je     8010681f <sys_unlink+0x17f>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010671f:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80106722:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80106726:	89 44 24 08          	mov    %eax,0x8(%esp)
8010672a:	89 34 24             	mov    %esi,(%esp)
8010672d:	e8 3e b5 ff ff       	call   80101c70 <dirlookup>
80106732:	85 c0                	test   %eax,%eax
80106734:	89 c3                	mov    %eax,%ebx
80106736:	0f 84 e3 00 00 00    	je     8010681f <sys_unlink+0x17f>
  ilock(ip);
8010673c:	89 04 24             	mov    %eax,(%esp)
8010673f:	e8 ac af ff ff       	call   801016f0 <ilock>
  if(ip->nlink < 1)
80106744:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80106749:	0f 8e 0e 01 00 00    	jle    8010685d <sys_unlink+0x1bd>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010674f:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106754:	8d 7d d8             	lea    -0x28(%ebp),%edi
80106757:	74 77                	je     801067d0 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
80106759:	31 d2                	xor    %edx,%edx
8010675b:	b8 10 00 00 00       	mov    $0x10,%eax
80106760:	89 54 24 04          	mov    %edx,0x4(%esp)
80106764:	89 44 24 08          	mov    %eax,0x8(%esp)
80106768:	89 3c 24             	mov    %edi,(%esp)
8010676b:	e8 d0 f5 ff ff       	call   80105d40 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106770:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80106773:	b9 10 00 00 00       	mov    $0x10,%ecx
80106778:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
8010677c:	89 7c 24 04          	mov    %edi,0x4(%esp)
80106780:	89 34 24             	mov    %esi,(%esp)
80106783:	89 44 24 08          	mov    %eax,0x8(%esp)
80106787:	e8 64 b3 ff ff       	call   80101af0 <writei>
8010678c:	83 f8 10             	cmp    $0x10,%eax
8010678f:	0f 85 d4 00 00 00    	jne    80106869 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
80106795:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010679a:	0f 84 a0 00 00 00    	je     80106840 <sys_unlink+0x1a0>
  iunlockput(dp);
801067a0:	89 34 24             	mov    %esi,(%esp)
801067a3:	e8 d8 b1 ff ff       	call   80101980 <iunlockput>
  ip->nlink--;
801067a8:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
801067ac:	89 1c 24             	mov    %ebx,(%esp)
801067af:	e8 7c ae ff ff       	call   80101630 <iupdate>
  iunlockput(ip);
801067b4:	89 1c 24             	mov    %ebx,(%esp)
801067b7:	e8 c4 b1 ff ff       	call   80101980 <iunlockput>
  end_op();
801067bc:	e8 3f c5 ff ff       	call   80102d00 <end_op>
}
801067c1:	83 c4 5c             	add    $0x5c,%esp
  return 0;
801067c4:	31 c0                	xor    %eax,%eax
}
801067c6:	5b                   	pop    %ebx
801067c7:	5e                   	pop    %esi
801067c8:	5f                   	pop    %edi
801067c9:	5d                   	pop    %ebp
801067ca:	c3                   	ret    
801067cb:	90                   	nop
801067cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801067d0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801067d4:	76 83                	jbe    80106759 <sys_unlink+0xb9>
801067d6:	ba 20 00 00 00       	mov    $0x20,%edx
801067db:	eb 0f                	jmp    801067ec <sys_unlink+0x14c>
801067dd:	8d 76 00             	lea    0x0(%esi),%esi
801067e0:	83 c2 10             	add    $0x10,%edx
801067e3:	3b 53 58             	cmp    0x58(%ebx),%edx
801067e6:	0f 83 6d ff ff ff    	jae    80106759 <sys_unlink+0xb9>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801067ec:	b8 10 00 00 00       	mov    $0x10,%eax
801067f1:	89 54 24 08          	mov    %edx,0x8(%esp)
801067f5:	89 44 24 0c          	mov    %eax,0xc(%esp)
801067f9:	89 7c 24 04          	mov    %edi,0x4(%esp)
801067fd:	89 1c 24             	mov    %ebx,(%esp)
80106800:	89 55 b4             	mov    %edx,-0x4c(%ebp)
80106803:	e8 c8 b1 ff ff       	call   801019d0 <readi>
80106808:	8b 55 b4             	mov    -0x4c(%ebp),%edx
8010680b:	83 f8 10             	cmp    $0x10,%eax
8010680e:	75 41                	jne    80106851 <sys_unlink+0x1b1>
    if(de.inum != 0)
80106810:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80106815:	74 c9                	je     801067e0 <sys_unlink+0x140>
    iunlockput(ip);
80106817:	89 1c 24             	mov    %ebx,(%esp)
8010681a:	e8 61 b1 ff ff       	call   80101980 <iunlockput>
  iunlockput(dp);
8010681f:	89 34 24             	mov    %esi,(%esp)
80106822:	e8 59 b1 ff ff       	call   80101980 <iunlockput>
  end_op();
80106827:	e8 d4 c4 ff ff       	call   80102d00 <end_op>
}
8010682c:	83 c4 5c             	add    $0x5c,%esp
  return -1;
8010682f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106834:	5b                   	pop    %ebx
80106835:	5e                   	pop    %esi
80106836:	5f                   	pop    %edi
80106837:	5d                   	pop    %ebp
80106838:	c3                   	ret    
80106839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80106840:	66 ff 4e 56          	decw   0x56(%esi)
    iupdate(dp);
80106844:	89 34 24             	mov    %esi,(%esp)
80106847:	e8 e4 ad ff ff       	call   80101630 <iupdate>
8010684c:	e9 4f ff ff ff       	jmp    801067a0 <sys_unlink+0x100>
      panic("isdirempty: readi");
80106851:	c7 04 24 68 91 10 80 	movl   $0x80109168,(%esp)
80106858:	e8 13 9b ff ff       	call   80100370 <panic>
    panic("unlink: nlink < 1");
8010685d:	c7 04 24 56 91 10 80 	movl   $0x80109156,(%esp)
80106864:	e8 07 9b ff ff       	call   80100370 <panic>
    panic("unlink: writei");
80106869:	c7 04 24 7a 91 10 80 	movl   $0x8010917a,(%esp)
80106870:	e8 fb 9a ff ff       	call   80100370 <panic>
80106875:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106880 <sys_open>:

int
sys_open(void)
{
80106880:	55                   	push   %ebp
80106881:	89 e5                	mov    %esp,%ebp
80106883:	57                   	push   %edi
80106884:	56                   	push   %esi
80106885:	53                   	push   %ebx
80106886:	83 ec 2c             	sub    $0x2c,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106889:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010688c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106890:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106897:	e8 44 f8 ff ff       	call   801060e0 <argstr>
8010689c:	85 c0                	test   %eax,%eax
8010689e:	0f 88 e9 00 00 00    	js     8010698d <sys_open+0x10d>
801068a4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801068a7:	89 44 24 04          	mov    %eax,0x4(%esp)
801068ab:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801068b2:	e8 79 f7 ff ff       	call   80106030 <argint>
801068b7:	85 c0                	test   %eax,%eax
801068b9:	0f 88 ce 00 00 00    	js     8010698d <sys_open+0x10d>
    return -1;

  begin_op();
801068bf:	e8 cc c3 ff ff       	call   80102c90 <begin_op>

  if(omode & O_CREATE){
801068c4:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801068c8:	0f 85 9a 00 00 00    	jne    80106968 <sys_open+0xe8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801068ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
801068d1:	89 04 24             	mov    %eax,(%esp)
801068d4:	e8 f7 b6 ff ff       	call   80101fd0 <namei>
801068d9:	85 c0                	test   %eax,%eax
801068db:	89 c6                	mov    %eax,%esi
801068dd:	0f 84 a5 00 00 00    	je     80106988 <sys_open+0x108>
      end_op();
      return -1;
    }
    ilock(ip);
801068e3:	89 04 24             	mov    %eax,(%esp)
801068e6:	e8 05 ae ff ff       	call   801016f0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801068eb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801068f0:	0f 84 a2 00 00 00    	je     80106998 <sys_open+0x118>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801068f6:	e8 75 a4 ff ff       	call   80100d70 <filealloc>
801068fb:	85 c0                	test   %eax,%eax
801068fd:	89 c7                	mov    %eax,%edi
801068ff:	0f 84 9e 00 00 00    	je     801069a3 <sys_open+0x123>
  struct proc *curproc = myproc();
80106905:	e8 96 d0 ff ff       	call   801039a0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010690a:	31 db                	xor    %ebx,%ebx
8010690c:	eb 0c                	jmp    8010691a <sys_open+0x9a>
8010690e:	66 90                	xchg   %ax,%ax
80106910:	43                   	inc    %ebx
80106911:	83 fb 10             	cmp    $0x10,%ebx
80106914:	0f 84 96 00 00 00    	je     801069b0 <sys_open+0x130>
    if(curproc->ofile[fd] == 0){
8010691a:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
8010691e:	85 d2                	test   %edx,%edx
80106920:	75 ee                	jne    80106910 <sys_open+0x90>
      curproc->ofile[fd] = f;
80106922:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106926:	89 34 24             	mov    %esi,(%esp)
80106929:	e8 a2 ae ff ff       	call   801017d0 <iunlock>
  end_op();
8010692e:	e8 cd c3 ff ff       	call   80102d00 <end_op>

  f->type = FD_INODE;
80106933:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80106939:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->ip = ip;
8010693c:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
8010693f:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80106946:	89 d0                	mov    %edx,%eax
80106948:	f7 d0                	not    %eax
8010694a:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010694d:	f6 c2 03             	test   $0x3,%dl
  f->readable = !(omode & O_WRONLY);
80106950:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106953:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80106957:	83 c4 2c             	add    $0x2c,%esp
8010695a:	89 d8                	mov    %ebx,%eax
8010695c:	5b                   	pop    %ebx
8010695d:	5e                   	pop    %esi
8010695e:	5f                   	pop    %edi
8010695f:	5d                   	pop    %ebp
80106960:	c3                   	ret    
80106961:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80106968:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010696b:	31 c9                	xor    %ecx,%ecx
8010696d:	ba 02 00 00 00       	mov    $0x2,%edx
80106972:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106979:	e8 12 f8 ff ff       	call   80106190 <create>
    if(ip == 0){
8010697e:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80106980:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80106982:	0f 85 6e ff ff ff    	jne    801068f6 <sys_open+0x76>
    end_op();
80106988:	e8 73 c3 ff ff       	call   80102d00 <end_op>
    return -1;
8010698d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106992:	eb c3                	jmp    80106957 <sys_open+0xd7>
80106994:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80106998:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010699b:	85 c9                	test   %ecx,%ecx
8010699d:	0f 84 53 ff ff ff    	je     801068f6 <sys_open+0x76>
    iunlockput(ip);
801069a3:	89 34 24             	mov    %esi,(%esp)
801069a6:	e8 d5 af ff ff       	call   80101980 <iunlockput>
801069ab:	eb db                	jmp    80106988 <sys_open+0x108>
801069ad:	8d 76 00             	lea    0x0(%esi),%esi
      fileclose(f);
801069b0:	89 3c 24             	mov    %edi,(%esp)
801069b3:	e8 78 a4 ff ff       	call   80100e30 <fileclose>
801069b8:	eb e9                	jmp    801069a3 <sys_open+0x123>
801069ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801069c0 <sys_mkdir>:

int
sys_mkdir(void)
{
801069c0:	55                   	push   %ebp
801069c1:	89 e5                	mov    %esp,%ebp
801069c3:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
801069c6:	e8 c5 c2 ff ff       	call   80102c90 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801069cb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801069ce:	89 44 24 04          	mov    %eax,0x4(%esp)
801069d2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801069d9:	e8 02 f7 ff ff       	call   801060e0 <argstr>
801069de:	85 c0                	test   %eax,%eax
801069e0:	78 2e                	js     80106a10 <sys_mkdir+0x50>
801069e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069e5:	31 c9                	xor    %ecx,%ecx
801069e7:	ba 01 00 00 00       	mov    $0x1,%edx
801069ec:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801069f3:	e8 98 f7 ff ff       	call   80106190 <create>
801069f8:	85 c0                	test   %eax,%eax
801069fa:	74 14                	je     80106a10 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801069fc:	89 04 24             	mov    %eax,(%esp)
801069ff:	e8 7c af ff ff       	call   80101980 <iunlockput>
  end_op();
80106a04:	e8 f7 c2 ff ff       	call   80102d00 <end_op>
  return 0;
80106a09:	31 c0                	xor    %eax,%eax
}
80106a0b:	c9                   	leave  
80106a0c:	c3                   	ret    
80106a0d:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
80106a10:	e8 eb c2 ff ff       	call   80102d00 <end_op>
    return -1;
80106a15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106a1a:	c9                   	leave  
80106a1b:	c3                   	ret    
80106a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106a20 <sys_mknod>:

int
sys_mknod(void)
{
80106a20:	55                   	push   %ebp
80106a21:	89 e5                	mov    %esp,%ebp
80106a23:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80106a26:	e8 65 c2 ff ff       	call   80102c90 <begin_op>
  if((argstr(0, &path)) < 0 ||
80106a2b:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106a2e:	89 44 24 04          	mov    %eax,0x4(%esp)
80106a32:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106a39:	e8 a2 f6 ff ff       	call   801060e0 <argstr>
80106a3e:	85 c0                	test   %eax,%eax
80106a40:	78 5e                	js     80106aa0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80106a42:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106a45:	89 44 24 04          	mov    %eax,0x4(%esp)
80106a49:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106a50:	e8 db f5 ff ff       	call   80106030 <argint>
  if((argstr(0, &path)) < 0 ||
80106a55:	85 c0                	test   %eax,%eax
80106a57:	78 47                	js     80106aa0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80106a59:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106a5c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106a60:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106a67:	e8 c4 f5 ff ff       	call   80106030 <argint>
     argint(1, &major) < 0 ||
80106a6c:	85 c0                	test   %eax,%eax
80106a6e:	78 30                	js     80106aa0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80106a70:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
80106a74:	ba 03 00 00 00       	mov    $0x3,%edx
     (ip = create(path, T_DEV, major, minor)) == 0){
80106a79:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80106a7d:	89 04 24             	mov    %eax,(%esp)
     argint(2, &minor) < 0 ||
80106a80:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106a83:	e8 08 f7 ff ff       	call   80106190 <create>
80106a88:	85 c0                	test   %eax,%eax
80106a8a:	74 14                	je     80106aa0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80106a8c:	89 04 24             	mov    %eax,(%esp)
80106a8f:	e8 ec ae ff ff       	call   80101980 <iunlockput>
  end_op();
80106a94:	e8 67 c2 ff ff       	call   80102d00 <end_op>
  return 0;
80106a99:	31 c0                	xor    %eax,%eax
}
80106a9b:	c9                   	leave  
80106a9c:	c3                   	ret    
80106a9d:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
80106aa0:	e8 5b c2 ff ff       	call   80102d00 <end_op>
    return -1;
80106aa5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106aaa:	c9                   	leave  
80106aab:	c3                   	ret    
80106aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106ab0 <sys_chdir>:

int
sys_chdir(void)
{
80106ab0:	55                   	push   %ebp
80106ab1:	89 e5                	mov    %esp,%ebp
80106ab3:	56                   	push   %esi
80106ab4:	53                   	push   %ebx
80106ab5:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80106ab8:	e8 e3 ce ff ff       	call   801039a0 <myproc>
80106abd:	89 c6                	mov    %eax,%esi
  
  begin_op();
80106abf:	e8 cc c1 ff ff       	call   80102c90 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106ac4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106ac7:	89 44 24 04          	mov    %eax,0x4(%esp)
80106acb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106ad2:	e8 09 f6 ff ff       	call   801060e0 <argstr>
80106ad7:	85 c0                	test   %eax,%eax
80106ad9:	78 4a                	js     80106b25 <sys_chdir+0x75>
80106adb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ade:	89 04 24             	mov    %eax,(%esp)
80106ae1:	e8 ea b4 ff ff       	call   80101fd0 <namei>
80106ae6:	85 c0                	test   %eax,%eax
80106ae8:	89 c3                	mov    %eax,%ebx
80106aea:	74 39                	je     80106b25 <sys_chdir+0x75>
    end_op();
    return -1;
  }
  ilock(ip);
80106aec:	89 04 24             	mov    %eax,(%esp)
80106aef:	e8 fc ab ff ff       	call   801016f0 <ilock>
  if(ip->type != T_DIR){
80106af4:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
    iunlockput(ip);
80106af9:	89 1c 24             	mov    %ebx,(%esp)
  if(ip->type != T_DIR){
80106afc:	75 22                	jne    80106b20 <sys_chdir+0x70>
    end_op();
    return -1;
  }
  iunlock(ip);
80106afe:	e8 cd ac ff ff       	call   801017d0 <iunlock>
  iput(curproc->cwd);
80106b03:	8b 46 68             	mov    0x68(%esi),%eax
80106b06:	89 04 24             	mov    %eax,(%esp)
80106b09:	e8 12 ad ff ff       	call   80101820 <iput>
  end_op();
80106b0e:	e8 ed c1 ff ff       	call   80102d00 <end_op>
  curproc->cwd = ip;
  return 0;
80106b13:	31 c0                	xor    %eax,%eax
  curproc->cwd = ip;
80106b15:	89 5e 68             	mov    %ebx,0x68(%esi)
}
80106b18:	83 c4 20             	add    $0x20,%esp
80106b1b:	5b                   	pop    %ebx
80106b1c:	5e                   	pop    %esi
80106b1d:	5d                   	pop    %ebp
80106b1e:	c3                   	ret    
80106b1f:	90                   	nop
    iunlockput(ip);
80106b20:	e8 5b ae ff ff       	call   80101980 <iunlockput>
    end_op();
80106b25:	e8 d6 c1 ff ff       	call   80102d00 <end_op>
    return -1;
80106b2a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106b2f:	eb e7                	jmp    80106b18 <sys_chdir+0x68>
80106b31:	eb 0d                	jmp    80106b40 <sys_exec>
80106b33:	90                   	nop
80106b34:	90                   	nop
80106b35:	90                   	nop
80106b36:	90                   	nop
80106b37:	90                   	nop
80106b38:	90                   	nop
80106b39:	90                   	nop
80106b3a:	90                   	nop
80106b3b:	90                   	nop
80106b3c:	90                   	nop
80106b3d:	90                   	nop
80106b3e:	90                   	nop
80106b3f:	90                   	nop

80106b40 <sys_exec>:

int
sys_exec(void)
{
80106b40:	55                   	push   %ebp
80106b41:	89 e5                	mov    %esp,%ebp
80106b43:	57                   	push   %edi
80106b44:	56                   	push   %esi
80106b45:	53                   	push   %ebx
80106b46:	81 ec ac 00 00 00    	sub    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106b4c:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80106b52:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b56:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106b5d:	e8 7e f5 ff ff       	call   801060e0 <argstr>
80106b62:	85 c0                	test   %eax,%eax
80106b64:	0f 88 8e 00 00 00    	js     80106bf8 <sys_exec+0xb8>
80106b6a:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80106b70:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b74:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106b7b:	e8 b0 f4 ff ff       	call   80106030 <argint>
80106b80:	85 c0                	test   %eax,%eax
80106b82:	78 74                	js     80106bf8 <sys_exec+0xb8>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80106b84:	ba 80 00 00 00       	mov    $0x80,%edx
80106b89:	31 c9                	xor    %ecx,%ecx
80106b8b:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
80106b91:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80106b93:	89 54 24 08          	mov    %edx,0x8(%esp)
80106b97:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80106b9d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80106ba1:	89 04 24             	mov    %eax,(%esp)
80106ba4:	e8 97 f1 ff ff       	call   80105d40 <memset>
80106ba9:	eb 2e                	jmp    80106bd9 <sys_exec+0x99>
80106bab:	90                   	nop
80106bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80106bb0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80106bb6:	85 c0                	test   %eax,%eax
80106bb8:	74 56                	je     80106c10 <sys_exec+0xd0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106bba:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80106bc0:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80106bc3:	89 54 24 04          	mov    %edx,0x4(%esp)
80106bc7:	89 04 24             	mov    %eax,(%esp)
80106bca:	e8 01 f4 ff ff       	call   80105fd0 <fetchstr>
80106bcf:	85 c0                	test   %eax,%eax
80106bd1:	78 25                	js     80106bf8 <sys_exec+0xb8>
  for(i=0;; i++){
80106bd3:	43                   	inc    %ebx
    if(i >= NELEM(argv))
80106bd4:	83 fb 20             	cmp    $0x20,%ebx
80106bd7:	74 1f                	je     80106bf8 <sys_exec+0xb8>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106bd9:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106bdf:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80106be6:	89 7c 24 04          	mov    %edi,0x4(%esp)
80106bea:	01 f0                	add    %esi,%eax
80106bec:	89 04 24             	mov    %eax,(%esp)
80106bef:	e8 9c f3 ff ff       	call   80105f90 <fetchint>
80106bf4:	85 c0                	test   %eax,%eax
80106bf6:	79 b8                	jns    80106bb0 <sys_exec+0x70>
      return -1;
  }
  return exec(path, argv);
}
80106bf8:	81 c4 ac 00 00 00    	add    $0xac,%esp
    return -1;
80106bfe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106c03:	5b                   	pop    %ebx
80106c04:	5e                   	pop    %esi
80106c05:	5f                   	pop    %edi
80106c06:	5d                   	pop    %ebp
80106c07:	c3                   	ret    
80106c08:	90                   	nop
80106c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80106c10:	31 c0                	xor    %eax,%eax
80106c12:	89 84 9d 68 ff ff ff 	mov    %eax,-0x98(%ebp,%ebx,4)
  return exec(path, argv);
80106c19:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106c1f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106c23:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
80106c29:	89 04 24             	mov    %eax,(%esp)
80106c2c:	e8 9f 9d ff ff       	call   801009d0 <exec>
}
80106c31:	81 c4 ac 00 00 00    	add    $0xac,%esp
80106c37:	5b                   	pop    %ebx
80106c38:	5e                   	pop    %esi
80106c39:	5f                   	pop    %edi
80106c3a:	5d                   	pop    %ebp
80106c3b:	c3                   	ret    
80106c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106c40 <sys_pipe>:

int
sys_pipe(void)
{
80106c40:	55                   	push   %ebp
80106c41:	89 e5                	mov    %esp,%ebp
80106c43:	57                   	push   %edi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106c44:	bf 08 00 00 00       	mov    $0x8,%edi
{
80106c49:	56                   	push   %esi
80106c4a:	53                   	push   %ebx
80106c4b:	83 ec 2c             	sub    $0x2c,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106c4e:	8d 45 dc             	lea    -0x24(%ebp),%eax
80106c51:	89 7c 24 08          	mov    %edi,0x8(%esp)
80106c55:	89 44 24 04          	mov    %eax,0x4(%esp)
80106c59:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106c60:	e8 1b f4 ff ff       	call   80106080 <argptr>
80106c65:	85 c0                	test   %eax,%eax
80106c67:	0f 88 a9 00 00 00    	js     80106d16 <sys_pipe+0xd6>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80106c6d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106c70:	89 44 24 04          	mov    %eax,0x4(%esp)
80106c74:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106c77:	89 04 24             	mov    %eax,(%esp)
80106c7a:	e8 41 c7 ff ff       	call   801033c0 <pipealloc>
80106c7f:	85 c0                	test   %eax,%eax
80106c81:	0f 88 8f 00 00 00    	js     80106d16 <sys_pipe+0xd6>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106c87:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80106c8a:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80106c8c:	e8 0f cd ff ff       	call   801039a0 <myproc>
80106c91:	eb 0b                	jmp    80106c9e <sys_pipe+0x5e>
80106c93:	90                   	nop
80106c94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106c98:	43                   	inc    %ebx
80106c99:	83 fb 10             	cmp    $0x10,%ebx
80106c9c:	74 62                	je     80106d00 <sys_pipe+0xc0>
    if(curproc->ofile[fd] == 0){
80106c9e:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80106ca2:	85 f6                	test   %esi,%esi
80106ca4:	75 f2                	jne    80106c98 <sys_pipe+0x58>
      curproc->ofile[fd] = f;
80106ca6:	8d 73 08             	lea    0x8(%ebx),%esi
80106ca9:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106cad:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80106cb0:	e8 eb cc ff ff       	call   801039a0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106cb5:	31 d2                	xor    %edx,%edx
80106cb7:	eb 0d                	jmp    80106cc6 <sys_pipe+0x86>
80106cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106cc0:	42                   	inc    %edx
80106cc1:	83 fa 10             	cmp    $0x10,%edx
80106cc4:	74 2a                	je     80106cf0 <sys_pipe+0xb0>
    if(curproc->ofile[fd] == 0){
80106cc6:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80106cca:	85 c9                	test   %ecx,%ecx
80106ccc:	75 f2                	jne    80106cc0 <sys_pipe+0x80>
      curproc->ofile[fd] = f;
80106cce:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80106cd2:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106cd5:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106cd7:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106cda:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80106cdd:	31 c0                	xor    %eax,%eax
}
80106cdf:	83 c4 2c             	add    $0x2c,%esp
80106ce2:	5b                   	pop    %ebx
80106ce3:	5e                   	pop    %esi
80106ce4:	5f                   	pop    %edi
80106ce5:	5d                   	pop    %ebp
80106ce6:	c3                   	ret    
80106ce7:	89 f6                	mov    %esi,%esi
80106ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      myproc()->ofile[fd0] = 0;
80106cf0:	e8 ab cc ff ff       	call   801039a0 <myproc>
80106cf5:	31 d2                	xor    %edx,%edx
80106cf7:	89 54 b0 08          	mov    %edx,0x8(%eax,%esi,4)
80106cfb:	90                   	nop
80106cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fileclose(rf);
80106d00:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106d03:	89 04 24             	mov    %eax,(%esp)
80106d06:	e8 25 a1 ff ff       	call   80100e30 <fileclose>
    fileclose(wf);
80106d0b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d0e:	89 04 24             	mov    %eax,(%esp)
80106d11:	e8 1a a1 ff ff       	call   80100e30 <fileclose>
    return -1;
80106d16:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106d1b:	eb c2                	jmp    80106cdf <sys_pipe+0x9f>
80106d1d:	66 90                	xchg   %ax,%ax
80106d1f:	90                   	nop

80106d20 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106d20:	55                   	push   %ebp
80106d21:	89 e5                	mov    %esp,%ebp
  return fork();
}
80106d23:	5d                   	pop    %ebp
  return fork();
80106d24:	e9 57 cf ff ff       	jmp    80103c80 <fork>
80106d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106d30 <sys_exit>:

int
sys_exit(void)
{
80106d30:	55                   	push   %ebp
80106d31:	89 e5                	mov    %esp,%ebp
80106d33:	83 ec 28             	sub    $0x28,%esp
  int status;

  if(argint(0, &status) < 0)
80106d36:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106d39:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d3d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106d44:	e8 e7 f2 ff ff       	call   80106030 <argint>
80106d49:	85 c0                	test   %eax,%eax
80106d4b:	78 13                	js     80106d60 <sys_exit+0x30>
    return -1;
  exit(status);
80106d4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d50:	89 04 24             	mov    %eax,(%esp)
80106d53:	e8 98 d5 ff ff       	call   801042f0 <exit>
  return 0;  // not reached
80106d58:	31 c0                	xor    %eax,%eax
}
80106d5a:	c9                   	leave  
80106d5b:	c3                   	ret    
80106d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106d60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106d65:	c9                   	leave  
80106d66:	c3                   	ret    
80106d67:	89 f6                	mov    %esi,%esi
80106d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d70 <sys_wait>:

int
sys_wait(void)
{
80106d70:	55                   	push   %ebp
  int *status;

  if(argptr(0, (char**)(&status), sizeof(int)) < 0)
80106d71:	b8 04 00 00 00       	mov    $0x4,%eax
{
80106d76:	89 e5                	mov    %esp,%ebp
80106d78:	83 ec 28             	sub    $0x28,%esp
  if(argptr(0, (char**)(&status), sizeof(int)) < 0)
80106d7b:	89 44 24 08          	mov    %eax,0x8(%esp)
80106d7f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106d82:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d86:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106d8d:	e8 ee f2 ff ff       	call   80106080 <argptr>
80106d92:	85 c0                	test   %eax,%eax
80106d94:	78 12                	js     80106da8 <sys_wait+0x38>
    return -1;
  return wait(status);
80106d96:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d99:	89 04 24             	mov    %eax,(%esp)
80106d9c:	e8 5f d8 ff ff       	call   80104600 <wait>
  //return wait();
}
80106da1:	c9                   	leave  
80106da2:	c3                   	ret    
80106da3:	90                   	nop
80106da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106da8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106dad:	c9                   	leave  
80106dae:	c3                   	ret    
80106daf:	90                   	nop

80106db0 <sys_kill>:

int
sys_kill(void)
{
80106db0:	55                   	push   %ebp
80106db1:	89 e5                	mov    %esp,%ebp
80106db3:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106db6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106db9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106dbd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106dc4:	e8 67 f2 ff ff       	call   80106030 <argint>
80106dc9:	85 c0                	test   %eax,%eax
80106dcb:	78 13                	js     80106de0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106dcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106dd0:	89 04 24             	mov    %eax,(%esp)
80106dd3:	e8 68 d9 ff ff       	call   80104740 <kill>
}
80106dd8:	c9                   	leave  
80106dd9:	c3                   	ret    
80106dda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106de0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106de5:	c9                   	leave  
80106de6:	c3                   	ret    
80106de7:	89 f6                	mov    %esi,%esi
80106de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106df0 <sys_getpid>:

int
sys_getpid(void)
{
80106df0:	55                   	push   %ebp
80106df1:	89 e5                	mov    %esp,%ebp
80106df3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106df6:	e8 a5 cb ff ff       	call   801039a0 <myproc>
80106dfb:	8b 40 10             	mov    0x10(%eax),%eax
}
80106dfe:	c9                   	leave  
80106dff:	c3                   	ret    

80106e00 <sys_sbrk>:

int
sys_sbrk(void)
{
80106e00:	55                   	push   %ebp
80106e01:	89 e5                	mov    %esp,%ebp
80106e03:	53                   	push   %ebx
80106e04:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106e07:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106e0a:	89 44 24 04          	mov    %eax,0x4(%esp)
80106e0e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106e15:	e8 16 f2 ff ff       	call   80106030 <argint>
80106e1a:	85 c0                	test   %eax,%eax
80106e1c:	78 22                	js     80106e40 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106e1e:	e8 7d cb ff ff       	call   801039a0 <myproc>
80106e23:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106e25:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e28:	89 04 24             	mov    %eax,(%esp)
80106e2b:	e8 a0 cb ff ff       	call   801039d0 <growproc>
80106e30:	85 c0                	test   %eax,%eax
80106e32:	78 0c                	js     80106e40 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106e34:	83 c4 24             	add    $0x24,%esp
80106e37:	89 d8                	mov    %ebx,%eax
80106e39:	5b                   	pop    %ebx
80106e3a:	5d                   	pop    %ebp
80106e3b:	c3                   	ret    
80106e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106e40:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106e45:	eb ed                	jmp    80106e34 <sys_sbrk+0x34>
80106e47:	89 f6                	mov    %esi,%esi
80106e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e50 <sys_sleep>:

int
sys_sleep(void)
{
80106e50:	55                   	push   %ebp
80106e51:	89 e5                	mov    %esp,%ebp
80106e53:	53                   	push   %ebx
80106e54:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106e57:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106e5a:	89 44 24 04          	mov    %eax,0x4(%esp)
80106e5e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106e65:	e8 c6 f1 ff ff       	call   80106030 <argint>
80106e6a:	85 c0                	test   %eax,%eax
80106e6c:	78 7e                	js     80106eec <sys_sleep+0x9c>
    return -1;
  acquire(&tickslock);
80106e6e:	c7 04 24 e0 77 11 80 	movl   $0x801177e0,(%esp)
80106e75:	e8 d6 ed ff ff       	call   80105c50 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106e7a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  ticks0 = ticks;
80106e7d:	8b 1d 20 80 11 80    	mov    0x80118020,%ebx
  while(ticks - ticks0 < n){
80106e83:	85 c9                	test   %ecx,%ecx
80106e85:	75 2a                	jne    80106eb1 <sys_sleep+0x61>
80106e87:	eb 4f                	jmp    80106ed8 <sys_sleep+0x88>
80106e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106e90:	b8 e0 77 11 80       	mov    $0x801177e0,%eax
80106e95:	89 44 24 04          	mov    %eax,0x4(%esp)
80106e99:	c7 04 24 20 80 11 80 	movl   $0x80118020,(%esp)
80106ea0:	e8 6b d6 ff ff       	call   80104510 <sleep>
  while(ticks - ticks0 < n){
80106ea5:	a1 20 80 11 80       	mov    0x80118020,%eax
80106eaa:	29 d8                	sub    %ebx,%eax
80106eac:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80106eaf:	73 27                	jae    80106ed8 <sys_sleep+0x88>
    if(myproc()->killed){
80106eb1:	e8 ea ca ff ff       	call   801039a0 <myproc>
80106eb6:	8b 50 24             	mov    0x24(%eax),%edx
80106eb9:	85 d2                	test   %edx,%edx
80106ebb:	74 d3                	je     80106e90 <sys_sleep+0x40>
      release(&tickslock);
80106ebd:	c7 04 24 e0 77 11 80 	movl   $0x801177e0,(%esp)
80106ec4:	e8 27 ee ff ff       	call   80105cf0 <release>
  }
  release(&tickslock);
  return 0;
}
80106ec9:	83 c4 24             	add    $0x24,%esp
      return -1;
80106ecc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ed1:	5b                   	pop    %ebx
80106ed2:	5d                   	pop    %ebp
80106ed3:	c3                   	ret    
80106ed4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&tickslock);
80106ed8:	c7 04 24 e0 77 11 80 	movl   $0x801177e0,(%esp)
80106edf:	e8 0c ee ff ff       	call   80105cf0 <release>
  return 0;
80106ee4:	31 c0                	xor    %eax,%eax
}
80106ee6:	83 c4 24             	add    $0x24,%esp
80106ee9:	5b                   	pop    %ebx
80106eea:	5d                   	pop    %ebp
80106eeb:	c3                   	ret    
    return -1;
80106eec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106ef1:	eb f3                	jmp    80106ee6 <sys_sleep+0x96>
80106ef3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f00 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106f00:	55                   	push   %ebp
80106f01:	89 e5                	mov    %esp,%ebp
80106f03:	53                   	push   %ebx
80106f04:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

  acquire(&tickslock);
80106f07:	c7 04 24 e0 77 11 80 	movl   $0x801177e0,(%esp)
80106f0e:	e8 3d ed ff ff       	call   80105c50 <acquire>
  xticks = ticks;
80106f13:	8b 1d 20 80 11 80    	mov    0x80118020,%ebx
  release(&tickslock);
80106f19:	c7 04 24 e0 77 11 80 	movl   $0x801177e0,(%esp)
80106f20:	e8 cb ed ff ff       	call   80105cf0 <release>
  return xticks;
}
80106f25:	83 c4 14             	add    $0x14,%esp
80106f28:	89 d8                	mov    %ebx,%eax
80106f2a:	5b                   	pop    %ebx
80106f2b:	5d                   	pop    %ebp
80106f2c:	c3                   	ret    
80106f2d:	8d 76 00             	lea    0x0(%esi),%esi

80106f30 <sys_detach>:

// transfer a child process with the given pid from the parent to the init process.
// return 0 when succseeds or -1 if the process has no child with this pid.
int
sys_detach(void)
{
80106f30:	55                   	push   %ebp
80106f31:	89 e5                	mov    %esp,%ebp
80106f33:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106f36:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106f39:	89 44 24 04          	mov    %eax,0x4(%esp)
80106f3d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106f44:	e8 e7 f0 ff ff       	call   80106030 <argint>
80106f49:	85 c0                	test   %eax,%eax
80106f4b:	78 13                	js     80106f60 <sys_detach+0x30>
    return -1;
  return detach(pid);
80106f4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f50:	89 04 24             	mov    %eax,(%esp)
80106f53:	e8 a8 d8 ff ff       	call   80104800 <detach>
}
80106f58:	c9                   	leave  
80106f59:	c3                   	ret    
80106f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106f60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106f65:	c9                   	leave  
80106f66:	c3                   	ret    
80106f67:	89 f6                	mov    %esi,%esi
80106f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f70 <sys_priority>:

//used by a process to change its priority
int
sys_priority(void)
{
80106f70:	55                   	push   %ebp
80106f71:	89 e5                	mov    %esp,%ebp
80106f73:	83 ec 28             	sub    $0x28,%esp
  int proc_priority;

  if(argint(0, &proc_priority) < 0)
80106f76:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106f79:	89 44 24 04          	mov    %eax,0x4(%esp)
80106f7d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106f84:	e8 a7 f0 ff ff       	call   80106030 <argint>
80106f89:	85 c0                	test   %eax,%eax
80106f8b:	78 13                	js     80106fa0 <sys_priority+0x30>
    return -1;
  priority(proc_priority);
80106f8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f90:	89 04 24             	mov    %eax,(%esp)
80106f93:	e8 28 d9 ff ff       	call   801048c0 <priority>
  return 0;
80106f98:	31 c0                	xor    %eax,%eax
}
80106f9a:	c9                   	leave  
80106f9b:	c3                   	ret    
80106f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106fa0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106fa5:	c9                   	leave  
80106fa6:	c3                   	ret    
80106fa7:	89 f6                	mov    %esi,%esi
80106fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106fb0 <sys_policy>:

// receives a policy identifier as an argument and changes the currently used policy.
int
sys_policy(void)
{
80106fb0:	55                   	push   %ebp
80106fb1:	89 e5                	mov    %esp,%ebp
80106fb3:	83 ec 28             	sub    $0x28,%esp
  int policy_id;

  if(argint(0, &policy_id) < 0)
80106fb6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106fb9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106fbd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106fc4:	e8 67 f0 ff ff       	call   80106030 <argint>
80106fc9:	85 c0                	test   %eax,%eax
80106fcb:	78 13                	js     80106fe0 <sys_policy+0x30>
    return -1;
  policy(policy_id);
80106fcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106fd0:	89 04 24             	mov    %eax,(%esp)
80106fd3:	e8 68 d9 ff ff       	call   80104940 <policy>
  return 0;
80106fd8:	31 c0                	xor    %eax,%eax
}
80106fda:	c9                   	leave  
80106fdb:	c3                   	ret    
80106fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106fe0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106fe5:	c9                   	leave  
80106fe6:	c3                   	ret    
80106fe7:	89 f6                	mov    %esi,%esi
80106fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ff0 <sys_wait_stat>:

// return the pid of the terminated child process or -1 upon failure.
int
sys_wait_stat(void)
{
80106ff0:	55                   	push   %ebp
     int* status;
     struct perf* perform;

     if ((argptr(0, (char**)(&status), sizeof(int)) < 0) || (argptr(1, (void*)(&perform), sizeof(*perform)) < 0))
80106ff1:	ba 04 00 00 00       	mov    $0x4,%edx
{
80106ff6:	89 e5                	mov    %esp,%ebp
80106ff8:	83 ec 28             	sub    $0x28,%esp
     if ((argptr(0, (char**)(&status), sizeof(int)) < 0) || (argptr(1, (void*)(&perform), sizeof(*perform)) < 0))
80106ffb:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106ffe:	89 54 24 08          	mov    %edx,0x8(%esp)
80107002:	89 44 24 04          	mov    %eax,0x4(%esp)
80107006:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010700d:	e8 6e f0 ff ff       	call   80106080 <argptr>
80107012:	85 c0                	test   %eax,%eax
80107014:	78 3a                	js     80107050 <sys_wait_stat+0x60>
80107016:	b8 14 00 00 00       	mov    $0x14,%eax
8010701b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010701f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107022:	89 44 24 04          	mov    %eax,0x4(%esp)
80107026:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010702d:	e8 4e f0 ff ff       	call   80106080 <argptr>
80107032:	85 c0                	test   %eax,%eax
80107034:	78 1a                	js     80107050 <sys_wait_stat+0x60>
        return -1;
    return wait_stat(status,perform);
80107036:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107039:	89 44 24 04          	mov    %eax,0x4(%esp)
8010703d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107040:	89 04 24             	mov    %eax,(%esp)
80107043:	e8 c8 da ff ff       	call   80104b10 <wait_stat>
}
80107048:	c9                   	leave  
80107049:	c3                   	ret    
8010704a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
80107050:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107055:	c9                   	leave  
80107056:	c3                   	ret    

80107057 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80107057:	1e                   	push   %ds
  pushl %es
80107058:	06                   	push   %es
  pushl %fs
80107059:	0f a0                	push   %fs
  pushl %gs
8010705b:	0f a8                	push   %gs
  pushal
8010705d:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
8010705e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80107062:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80107064:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80107066:	54                   	push   %esp
  call trap
80107067:	e8 c4 00 00 00       	call   80107130 <trap>
  addl $4, %esp
8010706c:	83 c4 04             	add    $0x4,%esp

8010706f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
8010706f:	61                   	popa   
  popl %gs
80107070:	0f a9                	pop    %gs
  popl %fs
80107072:	0f a1                	pop    %fs
  popl %es
80107074:	07                   	pop    %es
  popl %ds
80107075:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80107076:	83 c4 08             	add    $0x8,%esp
  iret
80107079:	cf                   	iret   
8010707a:	66 90                	xchg   %ax,%ax
8010707c:	66 90                	xchg   %ax,%ax
8010707e:	66 90                	xchg   %ax,%ax

80107080 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80107080:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80107081:	31 c0                	xor    %eax,%eax
{
80107083:	89 e5                	mov    %esp,%ebp
80107085:	83 ec 18             	sub    $0x18,%esp
80107088:	90                   	nop
80107089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80107090:	8b 14 85 0c c0 10 80 	mov    -0x7fef3ff4(,%eax,4),%edx
80107097:	b9 08 00 00 8e       	mov    $0x8e000008,%ecx
8010709c:	89 0c c5 22 78 11 80 	mov    %ecx,-0x7fee87de(,%eax,8)
801070a3:	66 89 14 c5 20 78 11 	mov    %dx,-0x7fee87e0(,%eax,8)
801070aa:	80 
801070ab:	c1 ea 10             	shr    $0x10,%edx
801070ae:	66 89 14 c5 26 78 11 	mov    %dx,-0x7fee87da(,%eax,8)
801070b5:	80 
  for(i = 0; i < 256; i++)
801070b6:	40                   	inc    %eax
801070b7:	3d 00 01 00 00       	cmp    $0x100,%eax
801070bc:	75 d2                	jne    80107090 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801070be:	a1 0c c1 10 80       	mov    0x8010c10c,%eax

  initlock(&tickslock, "time");
801070c3:	b9 89 91 10 80       	mov    $0x80109189,%ecx
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801070c8:	ba 08 00 00 ef       	mov    $0xef000008,%edx
  initlock(&tickslock, "time");
801070cd:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801070d1:	c7 04 24 e0 77 11 80 	movl   $0x801177e0,(%esp)
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801070d8:	89 15 22 7a 11 80    	mov    %edx,0x80117a22
801070de:	66 a3 20 7a 11 80    	mov    %ax,0x80117a20
801070e4:	c1 e8 10             	shr    $0x10,%eax
801070e7:	66 a3 26 7a 11 80    	mov    %ax,0x80117a26
  initlock(&tickslock, "time");
801070ed:	e8 0e ea ff ff       	call   80105b00 <initlock>
}
801070f2:	c9                   	leave  
801070f3:	c3                   	ret    
801070f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801070fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107100 <idtinit>:

void
idtinit(void)
{
80107100:	55                   	push   %ebp
  pd[1] = (uint)p;
80107101:	b8 20 78 11 80       	mov    $0x80117820,%eax
80107106:	89 e5                	mov    %esp,%ebp
80107108:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
8010710b:	c1 e8 10             	shr    $0x10,%eax
8010710e:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
80107111:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
80107117:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010711b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010711f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80107122:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80107125:	c9                   	leave  
80107126:	c3                   	ret    
80107127:	89 f6                	mov    %esi,%esi
80107129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107130 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80107130:	55                   	push   %ebp
80107131:	89 e5                	mov    %esp,%ebp
80107133:	83 ec 48             	sub    $0x48,%esp
80107136:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80107139:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010713c:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010713f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(tf->trapno == T_SYSCALL){
80107142:	8b 43 30             	mov    0x30(%ebx),%eax
80107145:	83 f8 40             	cmp    $0x40,%eax
80107148:	0f 84 02 01 00 00    	je     80107250 <trap+0x120>
    if(myproc()->killed)
      exit(0);
    return;
  }

  switch(tf->trapno){
8010714e:	83 e8 20             	sub    $0x20,%eax
80107151:	83 f8 1f             	cmp    $0x1f,%eax
80107154:	77 0a                	ja     80107160 <trap+0x30>
80107156:	ff 24 85 30 92 10 80 	jmp    *-0x7fef6dd0(,%eax,4)
8010715d:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80107160:	e8 3b c8 ff ff       	call   801039a0 <myproc>
80107165:	8b 7b 38             	mov    0x38(%ebx),%edi
80107168:	85 c0                	test   %eax,%eax
8010716a:	0f 84 64 02 00 00    	je     801073d4 <trap+0x2a4>
80107170:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80107174:	0f 84 5a 02 00 00    	je     801073d4 <trap+0x2a4>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010717a:	0f 20 d1             	mov    %cr2,%ecx
8010717d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107180:	e8 fb c7 ff ff       	call   80103980 <cpuid>
80107185:	8b 73 30             	mov    0x30(%ebx),%esi
80107188:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010718b:	8b 43 34             	mov    0x34(%ebx),%eax
8010718e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80107191:	e8 0a c8 ff ff       	call   801039a0 <myproc>
80107196:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107199:	e8 02 c8 ff ff       	call   801039a0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010719e:	8b 55 dc             	mov    -0x24(%ebp),%edx
801071a1:	89 74 24 0c          	mov    %esi,0xc(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
801071a5:	8b 75 e0             	mov    -0x20(%ebp),%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801071a8:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801071ab:	89 7c 24 18          	mov    %edi,0x18(%esp)
801071af:	89 54 24 14          	mov    %edx,0x14(%esp)
801071b3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
            myproc()->pid, myproc()->name, tf->trapno,
801071b6:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801071b9:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
801071bd:	89 74 24 08          	mov    %esi,0x8(%esp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801071c1:	89 54 24 10          	mov    %edx,0x10(%esp)
801071c5:	8b 40 10             	mov    0x10(%eax),%eax
801071c8:	c7 04 24 ec 91 10 80 	movl   $0x801091ec,(%esp)
801071cf:	89 44 24 04          	mov    %eax,0x4(%esp)
801071d3:	e8 78 94 ff ff       	call   80100650 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
801071d8:	e8 c3 c7 ff ff       	call   801039a0 <myproc>
801071dd:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801071e4:	e8 b7 c7 ff ff       	call   801039a0 <myproc>
801071e9:	85 c0                	test   %eax,%eax
801071eb:	74 1b                	je     80107208 <trap+0xd8>
801071ed:	e8 ae c7 ff ff       	call   801039a0 <myproc>
801071f2:	8b 50 24             	mov    0x24(%eax),%edx
801071f5:	85 d2                	test   %edx,%edx
801071f7:	74 0f                	je     80107208 <trap+0xd8>
801071f9:	8b 43 3c             	mov    0x3c(%ebx),%eax
801071fc:	83 e0 03             	and    $0x3,%eax
801071ff:	83 f8 03             	cmp    $0x3,%eax
80107202:	0f 84 80 01 00 00    	je     80107388 <trap+0x258>
    exit(0);

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80107208:	e8 93 c7 ff ff       	call   801039a0 <myproc>
8010720d:	85 c0                	test   %eax,%eax
8010720f:	74 0d                	je     8010721e <trap+0xee>
80107211:	e8 8a c7 ff ff       	call   801039a0 <myproc>
80107216:	8b 40 0c             	mov    0xc(%eax),%eax
80107219:	83 f8 04             	cmp    $0x4,%eax
8010721c:	74 7a                	je     80107298 <trap+0x168>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010721e:	e8 7d c7 ff ff       	call   801039a0 <myproc>
80107223:	85 c0                	test   %eax,%eax
80107225:	74 17                	je     8010723e <trap+0x10e>
80107227:	e8 74 c7 ff ff       	call   801039a0 <myproc>
8010722c:	8b 40 24             	mov    0x24(%eax),%eax
8010722f:	85 c0                	test   %eax,%eax
80107231:	74 0b                	je     8010723e <trap+0x10e>
80107233:	8b 43 3c             	mov    0x3c(%ebx),%eax
80107236:	83 e0 03             	and    $0x3,%eax
80107239:	83 f8 03             	cmp    $0x3,%eax
8010723c:	74 3b                	je     80107279 <trap+0x149>
    exit(0);
}
8010723e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107241:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107244:	8b 7d fc             	mov    -0x4(%ebp),%edi
80107247:	89 ec                	mov    %ebp,%esp
80107249:	5d                   	pop    %ebp
8010724a:	c3                   	ret    
8010724b:	90                   	nop
8010724c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80107250:	e8 4b c7 ff ff       	call   801039a0 <myproc>
80107255:	8b 70 24             	mov    0x24(%eax),%esi
80107258:	85 f6                	test   %esi,%esi
8010725a:	0f 85 10 01 00 00    	jne    80107370 <trap+0x240>
    myproc()->tf = tf;
80107260:	e8 3b c7 ff ff       	call   801039a0 <myproc>
80107265:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80107268:	e8 b3 ee ff ff       	call   80106120 <syscall>
    if(myproc()->killed)
8010726d:	e8 2e c7 ff ff       	call   801039a0 <myproc>
80107272:	8b 48 24             	mov    0x24(%eax),%ecx
80107275:	85 c9                	test   %ecx,%ecx
80107277:	74 c5                	je     8010723e <trap+0x10e>
      exit(0);
80107279:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
}
80107280:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107283:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107286:	8b 7d fc             	mov    -0x4(%ebp),%edi
80107289:	89 ec                	mov    %ebp,%esp
8010728b:	5d                   	pop    %ebp
      exit(0);
8010728c:	e9 5f d0 ff ff       	jmp    801042f0 <exit>
80107291:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(myproc() && myproc()->state == RUNNING &&
80107298:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
8010729c:	75 80                	jne    8010721e <trap+0xee>
    yield();
8010729e:	e8 6d d1 ff ff       	call   80104410 <yield>
801072a3:	e9 76 ff ff ff       	jmp    8010721e <trap+0xee>
801072a8:	90                   	nop
801072a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
801072b0:	e8 cb c6 ff ff       	call   80103980 <cpuid>
801072b5:	85 c0                	test   %eax,%eax
801072b7:	0f 84 e3 00 00 00    	je     801073a0 <trap+0x270>
801072bd:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
801072c0:	e8 8b b5 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801072c5:	e8 d6 c6 ff ff       	call   801039a0 <myproc>
801072ca:	85 c0                	test   %eax,%eax
801072cc:	0f 85 1b ff ff ff    	jne    801071ed <trap+0xbd>
801072d2:	e9 31 ff ff ff       	jmp    80107208 <trap+0xd8>
801072d7:	89 f6                	mov    %esi,%esi
801072d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    kbdintr();
801072e0:	e8 2b b4 ff ff       	call   80102710 <kbdintr>
    lapiceoi();
801072e5:	e8 66 b5 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801072ea:	e8 b1 c6 ff ff       	call   801039a0 <myproc>
801072ef:	85 c0                	test   %eax,%eax
801072f1:	0f 85 f6 fe ff ff    	jne    801071ed <trap+0xbd>
801072f7:	e9 0c ff ff ff       	jmp    80107208 <trap+0xd8>
801072fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80107300:	e8 6b 02 00 00       	call   80107570 <uartintr>
    lapiceoi();
80107305:	e8 46 b5 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010730a:	e8 91 c6 ff ff       	call   801039a0 <myproc>
8010730f:	85 c0                	test   %eax,%eax
80107311:	0f 85 d6 fe ff ff    	jne    801071ed <trap+0xbd>
80107317:	e9 ec fe ff ff       	jmp    80107208 <trap+0xd8>
8010731c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80107320:	8b 7b 38             	mov    0x38(%ebx),%edi
80107323:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80107327:	e8 54 c6 ff ff       	call   80103980 <cpuid>
8010732c:	c7 04 24 94 91 10 80 	movl   $0x80109194,(%esp)
80107333:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80107337:	89 74 24 08          	mov    %esi,0x8(%esp)
8010733b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010733f:	e8 0c 93 ff ff       	call   80100650 <cprintf>
    lapiceoi();
80107344:	e8 07 b5 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107349:	e8 52 c6 ff ff       	call   801039a0 <myproc>
8010734e:	85 c0                	test   %eax,%eax
80107350:	0f 85 97 fe ff ff    	jne    801071ed <trap+0xbd>
80107356:	e9 ad fe ff ff       	jmp    80107208 <trap+0xd8>
8010735b:	90                   	nop
8010735c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80107360:	e8 fb ad ff ff       	call   80102160 <ideintr>
80107365:	e9 53 ff ff ff       	jmp    801072bd <trap+0x18d>
8010736a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit(0);
80107370:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80107377:	e8 74 cf ff ff       	call   801042f0 <exit>
8010737c:	e9 df fe ff ff       	jmp    80107260 <trap+0x130>
80107381:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit(0);
80107388:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010738f:	e8 5c cf ff ff       	call   801042f0 <exit>
80107394:	e9 6f fe ff ff       	jmp    80107208 <trap+0xd8>
80107399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      acquire(&tickslock);
801073a0:	c7 04 24 e0 77 11 80 	movl   $0x801177e0,(%esp)
801073a7:	e8 a4 e8 ff ff       	call   80105c50 <acquire>
      ticks++;
801073ac:	ff 05 20 80 11 80    	incl   0x80118020
      updatePerformance();
801073b2:	e8 99 d8 ff ff       	call   80104c50 <updatePerformance>
      wakeup(&ticks);
801073b7:	c7 04 24 20 80 11 80 	movl   $0x80118020,(%esp)
801073be:	e8 4d d3 ff ff       	call   80104710 <wakeup>
      release(&tickslock);
801073c3:	c7 04 24 e0 77 11 80 	movl   $0x801177e0,(%esp)
801073ca:	e8 21 e9 ff ff       	call   80105cf0 <release>
801073cf:	e9 e9 fe ff ff       	jmp    801072bd <trap+0x18d>
801073d4:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801073d7:	e8 a4 c5 ff ff       	call   80103980 <cpuid>
801073dc:	89 74 24 10          	mov    %esi,0x10(%esp)
801073e0:	89 7c 24 0c          	mov    %edi,0xc(%esp)
801073e4:	89 44 24 08          	mov    %eax,0x8(%esp)
801073e8:	8b 43 30             	mov    0x30(%ebx),%eax
801073eb:	c7 04 24 b8 91 10 80 	movl   $0x801091b8,(%esp)
801073f2:	89 44 24 04          	mov    %eax,0x4(%esp)
801073f6:	e8 55 92 ff ff       	call   80100650 <cprintf>
      panic("trap");
801073fb:	c7 04 24 8e 91 10 80 	movl   $0x8010918e,(%esp)
80107402:	e8 69 8f ff ff       	call   80100370 <panic>
80107407:	66 90                	xchg   %ax,%ax
80107409:	66 90                	xchg   %ax,%ax
8010740b:	66 90                	xchg   %ax,%ax
8010740d:	66 90                	xchg   %ax,%ax
8010740f:	90                   	nop

80107410 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80107410:	a1 20 c6 10 80       	mov    0x8010c620,%eax
{
80107415:	55                   	push   %ebp
80107416:	89 e5                	mov    %esp,%ebp
  if(!uart)
80107418:	85 c0                	test   %eax,%eax
8010741a:	74 1c                	je     80107438 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010741c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80107421:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80107422:	24 01                	and    $0x1,%al
80107424:	84 c0                	test   %al,%al
80107426:	74 10                	je     80107438 <uartgetc+0x28>
80107428:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010742d:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010742e:	0f b6 c0             	movzbl %al,%eax
}
80107431:	5d                   	pop    %ebp
80107432:	c3                   	ret    
80107433:	90                   	nop
80107434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80107438:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010743d:	5d                   	pop    %ebp
8010743e:	c3                   	ret    
8010743f:	90                   	nop

80107440 <uartputc.part.0>:
uartputc(int c)
80107440:	55                   	push   %ebp
80107441:	89 e5                	mov    %esp,%ebp
80107443:	56                   	push   %esi
80107444:	be fd 03 00 00       	mov    $0x3fd,%esi
80107449:	53                   	push   %ebx
8010744a:	bb 80 00 00 00       	mov    $0x80,%ebx
8010744f:	83 ec 20             	sub    $0x20,%esp
80107452:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107455:	eb 18                	jmp    8010746f <uartputc.part.0+0x2f>
80107457:	89 f6                	mov    %esi,%esi
80107459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80107460:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80107467:	e8 04 b4 ff ff       	call   80102870 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010746c:	4b                   	dec    %ebx
8010746d:	74 09                	je     80107478 <uartputc.part.0+0x38>
8010746f:	89 f2                	mov    %esi,%edx
80107471:	ec                   	in     (%dx),%al
80107472:	24 20                	and    $0x20,%al
80107474:	84 c0                	test   %al,%al
80107476:	74 e8                	je     80107460 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107478:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010747d:	0f b6 45 f4          	movzbl -0xc(%ebp),%eax
80107481:	ee                   	out    %al,(%dx)
}
80107482:	83 c4 20             	add    $0x20,%esp
80107485:	5b                   	pop    %ebx
80107486:	5e                   	pop    %esi
80107487:	5d                   	pop    %ebp
80107488:	c3                   	ret    
80107489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107490 <uartinit>:
{
80107490:	55                   	push   %ebp
80107491:	31 c9                	xor    %ecx,%ecx
80107493:	89 e5                	mov    %esp,%ebp
80107495:	88 c8                	mov    %cl,%al
80107497:	57                   	push   %edi
80107498:	56                   	push   %esi
80107499:	53                   	push   %ebx
8010749a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010749f:	83 ec 1c             	sub    $0x1c,%esp
801074a2:	89 da                	mov    %ebx,%edx
801074a4:	ee                   	out    %al,(%dx)
801074a5:	bf fb 03 00 00       	mov    $0x3fb,%edi
801074aa:	b0 80                	mov    $0x80,%al
801074ac:	89 fa                	mov    %edi,%edx
801074ae:	ee                   	out    %al,(%dx)
801074af:	b0 0c                	mov    $0xc,%al
801074b1:	ba f8 03 00 00       	mov    $0x3f8,%edx
801074b6:	ee                   	out    %al,(%dx)
801074b7:	be f9 03 00 00       	mov    $0x3f9,%esi
801074bc:	88 c8                	mov    %cl,%al
801074be:	89 f2                	mov    %esi,%edx
801074c0:	ee                   	out    %al,(%dx)
801074c1:	b0 03                	mov    $0x3,%al
801074c3:	89 fa                	mov    %edi,%edx
801074c5:	ee                   	out    %al,(%dx)
801074c6:	ba fc 03 00 00       	mov    $0x3fc,%edx
801074cb:	88 c8                	mov    %cl,%al
801074cd:	ee                   	out    %al,(%dx)
801074ce:	b0 01                	mov    $0x1,%al
801074d0:	89 f2                	mov    %esi,%edx
801074d2:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801074d3:	ba fd 03 00 00       	mov    $0x3fd,%edx
801074d8:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801074d9:	fe c0                	inc    %al
801074db:	74 52                	je     8010752f <uartinit+0x9f>
  uart = 1;
801074dd:	b9 01 00 00 00       	mov    $0x1,%ecx
801074e2:	89 da                	mov    %ebx,%edx
801074e4:	89 0d 20 c6 10 80    	mov    %ecx,0x8010c620
801074ea:	ec                   	in     (%dx),%al
801074eb:	ba f8 03 00 00       	mov    $0x3f8,%edx
801074f0:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801074f1:	31 db                	xor    %ebx,%ebx
801074f3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  for(p="xv6...\n"; *p; p++)
801074f7:	bb b0 92 10 80       	mov    $0x801092b0,%ebx
  ioapicenable(IRQ_COM1, 0);
801074fc:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80107503:	e8 98 ae ff ff       	call   801023a0 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80107508:	b8 78 00 00 00       	mov    $0x78,%eax
8010750d:	eb 09                	jmp    80107518 <uartinit+0x88>
8010750f:	90                   	nop
80107510:	43                   	inc    %ebx
80107511:	0f be 03             	movsbl (%ebx),%eax
80107514:	84 c0                	test   %al,%al
80107516:	74 17                	je     8010752f <uartinit+0x9f>
  if(!uart)
80107518:	8b 15 20 c6 10 80    	mov    0x8010c620,%edx
8010751e:	85 d2                	test   %edx,%edx
80107520:	74 ee                	je     80107510 <uartinit+0x80>
  for(p="xv6...\n"; *p; p++)
80107522:	43                   	inc    %ebx
80107523:	e8 18 ff ff ff       	call   80107440 <uartputc.part.0>
80107528:	0f be 03             	movsbl (%ebx),%eax
8010752b:	84 c0                	test   %al,%al
8010752d:	75 e9                	jne    80107518 <uartinit+0x88>
}
8010752f:	83 c4 1c             	add    $0x1c,%esp
80107532:	5b                   	pop    %ebx
80107533:	5e                   	pop    %esi
80107534:	5f                   	pop    %edi
80107535:	5d                   	pop    %ebp
80107536:	c3                   	ret    
80107537:	89 f6                	mov    %esi,%esi
80107539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107540 <uartputc>:
  if(!uart)
80107540:	8b 15 20 c6 10 80    	mov    0x8010c620,%edx
{
80107546:	55                   	push   %ebp
80107547:	89 e5                	mov    %esp,%ebp
80107549:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
8010754c:	85 d2                	test   %edx,%edx
8010754e:	74 10                	je     80107560 <uartputc+0x20>
}
80107550:	5d                   	pop    %ebp
80107551:	e9 ea fe ff ff       	jmp    80107440 <uartputc.part.0>
80107556:	8d 76 00             	lea    0x0(%esi),%esi
80107559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107560:	5d                   	pop    %ebp
80107561:	c3                   	ret    
80107562:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107570 <uartintr>:

void
uartintr(void)
{
80107570:	55                   	push   %ebp
80107571:	89 e5                	mov    %esp,%ebp
80107573:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80107576:	c7 04 24 10 74 10 80 	movl   $0x80107410,(%esp)
8010757d:	e8 4e 92 ff ff       	call   801007d0 <consoleintr>
}
80107582:	c9                   	leave  
80107583:	c3                   	ret    

80107584 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80107584:	6a 00                	push   $0x0
  pushl $0
80107586:	6a 00                	push   $0x0
  jmp alltraps
80107588:	e9 ca fa ff ff       	jmp    80107057 <alltraps>

8010758d <vector1>:
.globl vector1
vector1:
  pushl $0
8010758d:	6a 00                	push   $0x0
  pushl $1
8010758f:	6a 01                	push   $0x1
  jmp alltraps
80107591:	e9 c1 fa ff ff       	jmp    80107057 <alltraps>

80107596 <vector2>:
.globl vector2
vector2:
  pushl $0
80107596:	6a 00                	push   $0x0
  pushl $2
80107598:	6a 02                	push   $0x2
  jmp alltraps
8010759a:	e9 b8 fa ff ff       	jmp    80107057 <alltraps>

8010759f <vector3>:
.globl vector3
vector3:
  pushl $0
8010759f:	6a 00                	push   $0x0
  pushl $3
801075a1:	6a 03                	push   $0x3
  jmp alltraps
801075a3:	e9 af fa ff ff       	jmp    80107057 <alltraps>

801075a8 <vector4>:
.globl vector4
vector4:
  pushl $0
801075a8:	6a 00                	push   $0x0
  pushl $4
801075aa:	6a 04                	push   $0x4
  jmp alltraps
801075ac:	e9 a6 fa ff ff       	jmp    80107057 <alltraps>

801075b1 <vector5>:
.globl vector5
vector5:
  pushl $0
801075b1:	6a 00                	push   $0x0
  pushl $5
801075b3:	6a 05                	push   $0x5
  jmp alltraps
801075b5:	e9 9d fa ff ff       	jmp    80107057 <alltraps>

801075ba <vector6>:
.globl vector6
vector6:
  pushl $0
801075ba:	6a 00                	push   $0x0
  pushl $6
801075bc:	6a 06                	push   $0x6
  jmp alltraps
801075be:	e9 94 fa ff ff       	jmp    80107057 <alltraps>

801075c3 <vector7>:
.globl vector7
vector7:
  pushl $0
801075c3:	6a 00                	push   $0x0
  pushl $7
801075c5:	6a 07                	push   $0x7
  jmp alltraps
801075c7:	e9 8b fa ff ff       	jmp    80107057 <alltraps>

801075cc <vector8>:
.globl vector8
vector8:
  pushl $8
801075cc:	6a 08                	push   $0x8
  jmp alltraps
801075ce:	e9 84 fa ff ff       	jmp    80107057 <alltraps>

801075d3 <vector9>:
.globl vector9
vector9:
  pushl $0
801075d3:	6a 00                	push   $0x0
  pushl $9
801075d5:	6a 09                	push   $0x9
  jmp alltraps
801075d7:	e9 7b fa ff ff       	jmp    80107057 <alltraps>

801075dc <vector10>:
.globl vector10
vector10:
  pushl $10
801075dc:	6a 0a                	push   $0xa
  jmp alltraps
801075de:	e9 74 fa ff ff       	jmp    80107057 <alltraps>

801075e3 <vector11>:
.globl vector11
vector11:
  pushl $11
801075e3:	6a 0b                	push   $0xb
  jmp alltraps
801075e5:	e9 6d fa ff ff       	jmp    80107057 <alltraps>

801075ea <vector12>:
.globl vector12
vector12:
  pushl $12
801075ea:	6a 0c                	push   $0xc
  jmp alltraps
801075ec:	e9 66 fa ff ff       	jmp    80107057 <alltraps>

801075f1 <vector13>:
.globl vector13
vector13:
  pushl $13
801075f1:	6a 0d                	push   $0xd
  jmp alltraps
801075f3:	e9 5f fa ff ff       	jmp    80107057 <alltraps>

801075f8 <vector14>:
.globl vector14
vector14:
  pushl $14
801075f8:	6a 0e                	push   $0xe
  jmp alltraps
801075fa:	e9 58 fa ff ff       	jmp    80107057 <alltraps>

801075ff <vector15>:
.globl vector15
vector15:
  pushl $0
801075ff:	6a 00                	push   $0x0
  pushl $15
80107601:	6a 0f                	push   $0xf
  jmp alltraps
80107603:	e9 4f fa ff ff       	jmp    80107057 <alltraps>

80107608 <vector16>:
.globl vector16
vector16:
  pushl $0
80107608:	6a 00                	push   $0x0
  pushl $16
8010760a:	6a 10                	push   $0x10
  jmp alltraps
8010760c:	e9 46 fa ff ff       	jmp    80107057 <alltraps>

80107611 <vector17>:
.globl vector17
vector17:
  pushl $17
80107611:	6a 11                	push   $0x11
  jmp alltraps
80107613:	e9 3f fa ff ff       	jmp    80107057 <alltraps>

80107618 <vector18>:
.globl vector18
vector18:
  pushl $0
80107618:	6a 00                	push   $0x0
  pushl $18
8010761a:	6a 12                	push   $0x12
  jmp alltraps
8010761c:	e9 36 fa ff ff       	jmp    80107057 <alltraps>

80107621 <vector19>:
.globl vector19
vector19:
  pushl $0
80107621:	6a 00                	push   $0x0
  pushl $19
80107623:	6a 13                	push   $0x13
  jmp alltraps
80107625:	e9 2d fa ff ff       	jmp    80107057 <alltraps>

8010762a <vector20>:
.globl vector20
vector20:
  pushl $0
8010762a:	6a 00                	push   $0x0
  pushl $20
8010762c:	6a 14                	push   $0x14
  jmp alltraps
8010762e:	e9 24 fa ff ff       	jmp    80107057 <alltraps>

80107633 <vector21>:
.globl vector21
vector21:
  pushl $0
80107633:	6a 00                	push   $0x0
  pushl $21
80107635:	6a 15                	push   $0x15
  jmp alltraps
80107637:	e9 1b fa ff ff       	jmp    80107057 <alltraps>

8010763c <vector22>:
.globl vector22
vector22:
  pushl $0
8010763c:	6a 00                	push   $0x0
  pushl $22
8010763e:	6a 16                	push   $0x16
  jmp alltraps
80107640:	e9 12 fa ff ff       	jmp    80107057 <alltraps>

80107645 <vector23>:
.globl vector23
vector23:
  pushl $0
80107645:	6a 00                	push   $0x0
  pushl $23
80107647:	6a 17                	push   $0x17
  jmp alltraps
80107649:	e9 09 fa ff ff       	jmp    80107057 <alltraps>

8010764e <vector24>:
.globl vector24
vector24:
  pushl $0
8010764e:	6a 00                	push   $0x0
  pushl $24
80107650:	6a 18                	push   $0x18
  jmp alltraps
80107652:	e9 00 fa ff ff       	jmp    80107057 <alltraps>

80107657 <vector25>:
.globl vector25
vector25:
  pushl $0
80107657:	6a 00                	push   $0x0
  pushl $25
80107659:	6a 19                	push   $0x19
  jmp alltraps
8010765b:	e9 f7 f9 ff ff       	jmp    80107057 <alltraps>

80107660 <vector26>:
.globl vector26
vector26:
  pushl $0
80107660:	6a 00                	push   $0x0
  pushl $26
80107662:	6a 1a                	push   $0x1a
  jmp alltraps
80107664:	e9 ee f9 ff ff       	jmp    80107057 <alltraps>

80107669 <vector27>:
.globl vector27
vector27:
  pushl $0
80107669:	6a 00                	push   $0x0
  pushl $27
8010766b:	6a 1b                	push   $0x1b
  jmp alltraps
8010766d:	e9 e5 f9 ff ff       	jmp    80107057 <alltraps>

80107672 <vector28>:
.globl vector28
vector28:
  pushl $0
80107672:	6a 00                	push   $0x0
  pushl $28
80107674:	6a 1c                	push   $0x1c
  jmp alltraps
80107676:	e9 dc f9 ff ff       	jmp    80107057 <alltraps>

8010767b <vector29>:
.globl vector29
vector29:
  pushl $0
8010767b:	6a 00                	push   $0x0
  pushl $29
8010767d:	6a 1d                	push   $0x1d
  jmp alltraps
8010767f:	e9 d3 f9 ff ff       	jmp    80107057 <alltraps>

80107684 <vector30>:
.globl vector30
vector30:
  pushl $0
80107684:	6a 00                	push   $0x0
  pushl $30
80107686:	6a 1e                	push   $0x1e
  jmp alltraps
80107688:	e9 ca f9 ff ff       	jmp    80107057 <alltraps>

8010768d <vector31>:
.globl vector31
vector31:
  pushl $0
8010768d:	6a 00                	push   $0x0
  pushl $31
8010768f:	6a 1f                	push   $0x1f
  jmp alltraps
80107691:	e9 c1 f9 ff ff       	jmp    80107057 <alltraps>

80107696 <vector32>:
.globl vector32
vector32:
  pushl $0
80107696:	6a 00                	push   $0x0
  pushl $32
80107698:	6a 20                	push   $0x20
  jmp alltraps
8010769a:	e9 b8 f9 ff ff       	jmp    80107057 <alltraps>

8010769f <vector33>:
.globl vector33
vector33:
  pushl $0
8010769f:	6a 00                	push   $0x0
  pushl $33
801076a1:	6a 21                	push   $0x21
  jmp alltraps
801076a3:	e9 af f9 ff ff       	jmp    80107057 <alltraps>

801076a8 <vector34>:
.globl vector34
vector34:
  pushl $0
801076a8:	6a 00                	push   $0x0
  pushl $34
801076aa:	6a 22                	push   $0x22
  jmp alltraps
801076ac:	e9 a6 f9 ff ff       	jmp    80107057 <alltraps>

801076b1 <vector35>:
.globl vector35
vector35:
  pushl $0
801076b1:	6a 00                	push   $0x0
  pushl $35
801076b3:	6a 23                	push   $0x23
  jmp alltraps
801076b5:	e9 9d f9 ff ff       	jmp    80107057 <alltraps>

801076ba <vector36>:
.globl vector36
vector36:
  pushl $0
801076ba:	6a 00                	push   $0x0
  pushl $36
801076bc:	6a 24                	push   $0x24
  jmp alltraps
801076be:	e9 94 f9 ff ff       	jmp    80107057 <alltraps>

801076c3 <vector37>:
.globl vector37
vector37:
  pushl $0
801076c3:	6a 00                	push   $0x0
  pushl $37
801076c5:	6a 25                	push   $0x25
  jmp alltraps
801076c7:	e9 8b f9 ff ff       	jmp    80107057 <alltraps>

801076cc <vector38>:
.globl vector38
vector38:
  pushl $0
801076cc:	6a 00                	push   $0x0
  pushl $38
801076ce:	6a 26                	push   $0x26
  jmp alltraps
801076d0:	e9 82 f9 ff ff       	jmp    80107057 <alltraps>

801076d5 <vector39>:
.globl vector39
vector39:
  pushl $0
801076d5:	6a 00                	push   $0x0
  pushl $39
801076d7:	6a 27                	push   $0x27
  jmp alltraps
801076d9:	e9 79 f9 ff ff       	jmp    80107057 <alltraps>

801076de <vector40>:
.globl vector40
vector40:
  pushl $0
801076de:	6a 00                	push   $0x0
  pushl $40
801076e0:	6a 28                	push   $0x28
  jmp alltraps
801076e2:	e9 70 f9 ff ff       	jmp    80107057 <alltraps>

801076e7 <vector41>:
.globl vector41
vector41:
  pushl $0
801076e7:	6a 00                	push   $0x0
  pushl $41
801076e9:	6a 29                	push   $0x29
  jmp alltraps
801076eb:	e9 67 f9 ff ff       	jmp    80107057 <alltraps>

801076f0 <vector42>:
.globl vector42
vector42:
  pushl $0
801076f0:	6a 00                	push   $0x0
  pushl $42
801076f2:	6a 2a                	push   $0x2a
  jmp alltraps
801076f4:	e9 5e f9 ff ff       	jmp    80107057 <alltraps>

801076f9 <vector43>:
.globl vector43
vector43:
  pushl $0
801076f9:	6a 00                	push   $0x0
  pushl $43
801076fb:	6a 2b                	push   $0x2b
  jmp alltraps
801076fd:	e9 55 f9 ff ff       	jmp    80107057 <alltraps>

80107702 <vector44>:
.globl vector44
vector44:
  pushl $0
80107702:	6a 00                	push   $0x0
  pushl $44
80107704:	6a 2c                	push   $0x2c
  jmp alltraps
80107706:	e9 4c f9 ff ff       	jmp    80107057 <alltraps>

8010770b <vector45>:
.globl vector45
vector45:
  pushl $0
8010770b:	6a 00                	push   $0x0
  pushl $45
8010770d:	6a 2d                	push   $0x2d
  jmp alltraps
8010770f:	e9 43 f9 ff ff       	jmp    80107057 <alltraps>

80107714 <vector46>:
.globl vector46
vector46:
  pushl $0
80107714:	6a 00                	push   $0x0
  pushl $46
80107716:	6a 2e                	push   $0x2e
  jmp alltraps
80107718:	e9 3a f9 ff ff       	jmp    80107057 <alltraps>

8010771d <vector47>:
.globl vector47
vector47:
  pushl $0
8010771d:	6a 00                	push   $0x0
  pushl $47
8010771f:	6a 2f                	push   $0x2f
  jmp alltraps
80107721:	e9 31 f9 ff ff       	jmp    80107057 <alltraps>

80107726 <vector48>:
.globl vector48
vector48:
  pushl $0
80107726:	6a 00                	push   $0x0
  pushl $48
80107728:	6a 30                	push   $0x30
  jmp alltraps
8010772a:	e9 28 f9 ff ff       	jmp    80107057 <alltraps>

8010772f <vector49>:
.globl vector49
vector49:
  pushl $0
8010772f:	6a 00                	push   $0x0
  pushl $49
80107731:	6a 31                	push   $0x31
  jmp alltraps
80107733:	e9 1f f9 ff ff       	jmp    80107057 <alltraps>

80107738 <vector50>:
.globl vector50
vector50:
  pushl $0
80107738:	6a 00                	push   $0x0
  pushl $50
8010773a:	6a 32                	push   $0x32
  jmp alltraps
8010773c:	e9 16 f9 ff ff       	jmp    80107057 <alltraps>

80107741 <vector51>:
.globl vector51
vector51:
  pushl $0
80107741:	6a 00                	push   $0x0
  pushl $51
80107743:	6a 33                	push   $0x33
  jmp alltraps
80107745:	e9 0d f9 ff ff       	jmp    80107057 <alltraps>

8010774a <vector52>:
.globl vector52
vector52:
  pushl $0
8010774a:	6a 00                	push   $0x0
  pushl $52
8010774c:	6a 34                	push   $0x34
  jmp alltraps
8010774e:	e9 04 f9 ff ff       	jmp    80107057 <alltraps>

80107753 <vector53>:
.globl vector53
vector53:
  pushl $0
80107753:	6a 00                	push   $0x0
  pushl $53
80107755:	6a 35                	push   $0x35
  jmp alltraps
80107757:	e9 fb f8 ff ff       	jmp    80107057 <alltraps>

8010775c <vector54>:
.globl vector54
vector54:
  pushl $0
8010775c:	6a 00                	push   $0x0
  pushl $54
8010775e:	6a 36                	push   $0x36
  jmp alltraps
80107760:	e9 f2 f8 ff ff       	jmp    80107057 <alltraps>

80107765 <vector55>:
.globl vector55
vector55:
  pushl $0
80107765:	6a 00                	push   $0x0
  pushl $55
80107767:	6a 37                	push   $0x37
  jmp alltraps
80107769:	e9 e9 f8 ff ff       	jmp    80107057 <alltraps>

8010776e <vector56>:
.globl vector56
vector56:
  pushl $0
8010776e:	6a 00                	push   $0x0
  pushl $56
80107770:	6a 38                	push   $0x38
  jmp alltraps
80107772:	e9 e0 f8 ff ff       	jmp    80107057 <alltraps>

80107777 <vector57>:
.globl vector57
vector57:
  pushl $0
80107777:	6a 00                	push   $0x0
  pushl $57
80107779:	6a 39                	push   $0x39
  jmp alltraps
8010777b:	e9 d7 f8 ff ff       	jmp    80107057 <alltraps>

80107780 <vector58>:
.globl vector58
vector58:
  pushl $0
80107780:	6a 00                	push   $0x0
  pushl $58
80107782:	6a 3a                	push   $0x3a
  jmp alltraps
80107784:	e9 ce f8 ff ff       	jmp    80107057 <alltraps>

80107789 <vector59>:
.globl vector59
vector59:
  pushl $0
80107789:	6a 00                	push   $0x0
  pushl $59
8010778b:	6a 3b                	push   $0x3b
  jmp alltraps
8010778d:	e9 c5 f8 ff ff       	jmp    80107057 <alltraps>

80107792 <vector60>:
.globl vector60
vector60:
  pushl $0
80107792:	6a 00                	push   $0x0
  pushl $60
80107794:	6a 3c                	push   $0x3c
  jmp alltraps
80107796:	e9 bc f8 ff ff       	jmp    80107057 <alltraps>

8010779b <vector61>:
.globl vector61
vector61:
  pushl $0
8010779b:	6a 00                	push   $0x0
  pushl $61
8010779d:	6a 3d                	push   $0x3d
  jmp alltraps
8010779f:	e9 b3 f8 ff ff       	jmp    80107057 <alltraps>

801077a4 <vector62>:
.globl vector62
vector62:
  pushl $0
801077a4:	6a 00                	push   $0x0
  pushl $62
801077a6:	6a 3e                	push   $0x3e
  jmp alltraps
801077a8:	e9 aa f8 ff ff       	jmp    80107057 <alltraps>

801077ad <vector63>:
.globl vector63
vector63:
  pushl $0
801077ad:	6a 00                	push   $0x0
  pushl $63
801077af:	6a 3f                	push   $0x3f
  jmp alltraps
801077b1:	e9 a1 f8 ff ff       	jmp    80107057 <alltraps>

801077b6 <vector64>:
.globl vector64
vector64:
  pushl $0
801077b6:	6a 00                	push   $0x0
  pushl $64
801077b8:	6a 40                	push   $0x40
  jmp alltraps
801077ba:	e9 98 f8 ff ff       	jmp    80107057 <alltraps>

801077bf <vector65>:
.globl vector65
vector65:
  pushl $0
801077bf:	6a 00                	push   $0x0
  pushl $65
801077c1:	6a 41                	push   $0x41
  jmp alltraps
801077c3:	e9 8f f8 ff ff       	jmp    80107057 <alltraps>

801077c8 <vector66>:
.globl vector66
vector66:
  pushl $0
801077c8:	6a 00                	push   $0x0
  pushl $66
801077ca:	6a 42                	push   $0x42
  jmp alltraps
801077cc:	e9 86 f8 ff ff       	jmp    80107057 <alltraps>

801077d1 <vector67>:
.globl vector67
vector67:
  pushl $0
801077d1:	6a 00                	push   $0x0
  pushl $67
801077d3:	6a 43                	push   $0x43
  jmp alltraps
801077d5:	e9 7d f8 ff ff       	jmp    80107057 <alltraps>

801077da <vector68>:
.globl vector68
vector68:
  pushl $0
801077da:	6a 00                	push   $0x0
  pushl $68
801077dc:	6a 44                	push   $0x44
  jmp alltraps
801077de:	e9 74 f8 ff ff       	jmp    80107057 <alltraps>

801077e3 <vector69>:
.globl vector69
vector69:
  pushl $0
801077e3:	6a 00                	push   $0x0
  pushl $69
801077e5:	6a 45                	push   $0x45
  jmp alltraps
801077e7:	e9 6b f8 ff ff       	jmp    80107057 <alltraps>

801077ec <vector70>:
.globl vector70
vector70:
  pushl $0
801077ec:	6a 00                	push   $0x0
  pushl $70
801077ee:	6a 46                	push   $0x46
  jmp alltraps
801077f0:	e9 62 f8 ff ff       	jmp    80107057 <alltraps>

801077f5 <vector71>:
.globl vector71
vector71:
  pushl $0
801077f5:	6a 00                	push   $0x0
  pushl $71
801077f7:	6a 47                	push   $0x47
  jmp alltraps
801077f9:	e9 59 f8 ff ff       	jmp    80107057 <alltraps>

801077fe <vector72>:
.globl vector72
vector72:
  pushl $0
801077fe:	6a 00                	push   $0x0
  pushl $72
80107800:	6a 48                	push   $0x48
  jmp alltraps
80107802:	e9 50 f8 ff ff       	jmp    80107057 <alltraps>

80107807 <vector73>:
.globl vector73
vector73:
  pushl $0
80107807:	6a 00                	push   $0x0
  pushl $73
80107809:	6a 49                	push   $0x49
  jmp alltraps
8010780b:	e9 47 f8 ff ff       	jmp    80107057 <alltraps>

80107810 <vector74>:
.globl vector74
vector74:
  pushl $0
80107810:	6a 00                	push   $0x0
  pushl $74
80107812:	6a 4a                	push   $0x4a
  jmp alltraps
80107814:	e9 3e f8 ff ff       	jmp    80107057 <alltraps>

80107819 <vector75>:
.globl vector75
vector75:
  pushl $0
80107819:	6a 00                	push   $0x0
  pushl $75
8010781b:	6a 4b                	push   $0x4b
  jmp alltraps
8010781d:	e9 35 f8 ff ff       	jmp    80107057 <alltraps>

80107822 <vector76>:
.globl vector76
vector76:
  pushl $0
80107822:	6a 00                	push   $0x0
  pushl $76
80107824:	6a 4c                	push   $0x4c
  jmp alltraps
80107826:	e9 2c f8 ff ff       	jmp    80107057 <alltraps>

8010782b <vector77>:
.globl vector77
vector77:
  pushl $0
8010782b:	6a 00                	push   $0x0
  pushl $77
8010782d:	6a 4d                	push   $0x4d
  jmp alltraps
8010782f:	e9 23 f8 ff ff       	jmp    80107057 <alltraps>

80107834 <vector78>:
.globl vector78
vector78:
  pushl $0
80107834:	6a 00                	push   $0x0
  pushl $78
80107836:	6a 4e                	push   $0x4e
  jmp alltraps
80107838:	e9 1a f8 ff ff       	jmp    80107057 <alltraps>

8010783d <vector79>:
.globl vector79
vector79:
  pushl $0
8010783d:	6a 00                	push   $0x0
  pushl $79
8010783f:	6a 4f                	push   $0x4f
  jmp alltraps
80107841:	e9 11 f8 ff ff       	jmp    80107057 <alltraps>

80107846 <vector80>:
.globl vector80
vector80:
  pushl $0
80107846:	6a 00                	push   $0x0
  pushl $80
80107848:	6a 50                	push   $0x50
  jmp alltraps
8010784a:	e9 08 f8 ff ff       	jmp    80107057 <alltraps>

8010784f <vector81>:
.globl vector81
vector81:
  pushl $0
8010784f:	6a 00                	push   $0x0
  pushl $81
80107851:	6a 51                	push   $0x51
  jmp alltraps
80107853:	e9 ff f7 ff ff       	jmp    80107057 <alltraps>

80107858 <vector82>:
.globl vector82
vector82:
  pushl $0
80107858:	6a 00                	push   $0x0
  pushl $82
8010785a:	6a 52                	push   $0x52
  jmp alltraps
8010785c:	e9 f6 f7 ff ff       	jmp    80107057 <alltraps>

80107861 <vector83>:
.globl vector83
vector83:
  pushl $0
80107861:	6a 00                	push   $0x0
  pushl $83
80107863:	6a 53                	push   $0x53
  jmp alltraps
80107865:	e9 ed f7 ff ff       	jmp    80107057 <alltraps>

8010786a <vector84>:
.globl vector84
vector84:
  pushl $0
8010786a:	6a 00                	push   $0x0
  pushl $84
8010786c:	6a 54                	push   $0x54
  jmp alltraps
8010786e:	e9 e4 f7 ff ff       	jmp    80107057 <alltraps>

80107873 <vector85>:
.globl vector85
vector85:
  pushl $0
80107873:	6a 00                	push   $0x0
  pushl $85
80107875:	6a 55                	push   $0x55
  jmp alltraps
80107877:	e9 db f7 ff ff       	jmp    80107057 <alltraps>

8010787c <vector86>:
.globl vector86
vector86:
  pushl $0
8010787c:	6a 00                	push   $0x0
  pushl $86
8010787e:	6a 56                	push   $0x56
  jmp alltraps
80107880:	e9 d2 f7 ff ff       	jmp    80107057 <alltraps>

80107885 <vector87>:
.globl vector87
vector87:
  pushl $0
80107885:	6a 00                	push   $0x0
  pushl $87
80107887:	6a 57                	push   $0x57
  jmp alltraps
80107889:	e9 c9 f7 ff ff       	jmp    80107057 <alltraps>

8010788e <vector88>:
.globl vector88
vector88:
  pushl $0
8010788e:	6a 00                	push   $0x0
  pushl $88
80107890:	6a 58                	push   $0x58
  jmp alltraps
80107892:	e9 c0 f7 ff ff       	jmp    80107057 <alltraps>

80107897 <vector89>:
.globl vector89
vector89:
  pushl $0
80107897:	6a 00                	push   $0x0
  pushl $89
80107899:	6a 59                	push   $0x59
  jmp alltraps
8010789b:	e9 b7 f7 ff ff       	jmp    80107057 <alltraps>

801078a0 <vector90>:
.globl vector90
vector90:
  pushl $0
801078a0:	6a 00                	push   $0x0
  pushl $90
801078a2:	6a 5a                	push   $0x5a
  jmp alltraps
801078a4:	e9 ae f7 ff ff       	jmp    80107057 <alltraps>

801078a9 <vector91>:
.globl vector91
vector91:
  pushl $0
801078a9:	6a 00                	push   $0x0
  pushl $91
801078ab:	6a 5b                	push   $0x5b
  jmp alltraps
801078ad:	e9 a5 f7 ff ff       	jmp    80107057 <alltraps>

801078b2 <vector92>:
.globl vector92
vector92:
  pushl $0
801078b2:	6a 00                	push   $0x0
  pushl $92
801078b4:	6a 5c                	push   $0x5c
  jmp alltraps
801078b6:	e9 9c f7 ff ff       	jmp    80107057 <alltraps>

801078bb <vector93>:
.globl vector93
vector93:
  pushl $0
801078bb:	6a 00                	push   $0x0
  pushl $93
801078bd:	6a 5d                	push   $0x5d
  jmp alltraps
801078bf:	e9 93 f7 ff ff       	jmp    80107057 <alltraps>

801078c4 <vector94>:
.globl vector94
vector94:
  pushl $0
801078c4:	6a 00                	push   $0x0
  pushl $94
801078c6:	6a 5e                	push   $0x5e
  jmp alltraps
801078c8:	e9 8a f7 ff ff       	jmp    80107057 <alltraps>

801078cd <vector95>:
.globl vector95
vector95:
  pushl $0
801078cd:	6a 00                	push   $0x0
  pushl $95
801078cf:	6a 5f                	push   $0x5f
  jmp alltraps
801078d1:	e9 81 f7 ff ff       	jmp    80107057 <alltraps>

801078d6 <vector96>:
.globl vector96
vector96:
  pushl $0
801078d6:	6a 00                	push   $0x0
  pushl $96
801078d8:	6a 60                	push   $0x60
  jmp alltraps
801078da:	e9 78 f7 ff ff       	jmp    80107057 <alltraps>

801078df <vector97>:
.globl vector97
vector97:
  pushl $0
801078df:	6a 00                	push   $0x0
  pushl $97
801078e1:	6a 61                	push   $0x61
  jmp alltraps
801078e3:	e9 6f f7 ff ff       	jmp    80107057 <alltraps>

801078e8 <vector98>:
.globl vector98
vector98:
  pushl $0
801078e8:	6a 00                	push   $0x0
  pushl $98
801078ea:	6a 62                	push   $0x62
  jmp alltraps
801078ec:	e9 66 f7 ff ff       	jmp    80107057 <alltraps>

801078f1 <vector99>:
.globl vector99
vector99:
  pushl $0
801078f1:	6a 00                	push   $0x0
  pushl $99
801078f3:	6a 63                	push   $0x63
  jmp alltraps
801078f5:	e9 5d f7 ff ff       	jmp    80107057 <alltraps>

801078fa <vector100>:
.globl vector100
vector100:
  pushl $0
801078fa:	6a 00                	push   $0x0
  pushl $100
801078fc:	6a 64                	push   $0x64
  jmp alltraps
801078fe:	e9 54 f7 ff ff       	jmp    80107057 <alltraps>

80107903 <vector101>:
.globl vector101
vector101:
  pushl $0
80107903:	6a 00                	push   $0x0
  pushl $101
80107905:	6a 65                	push   $0x65
  jmp alltraps
80107907:	e9 4b f7 ff ff       	jmp    80107057 <alltraps>

8010790c <vector102>:
.globl vector102
vector102:
  pushl $0
8010790c:	6a 00                	push   $0x0
  pushl $102
8010790e:	6a 66                	push   $0x66
  jmp alltraps
80107910:	e9 42 f7 ff ff       	jmp    80107057 <alltraps>

80107915 <vector103>:
.globl vector103
vector103:
  pushl $0
80107915:	6a 00                	push   $0x0
  pushl $103
80107917:	6a 67                	push   $0x67
  jmp alltraps
80107919:	e9 39 f7 ff ff       	jmp    80107057 <alltraps>

8010791e <vector104>:
.globl vector104
vector104:
  pushl $0
8010791e:	6a 00                	push   $0x0
  pushl $104
80107920:	6a 68                	push   $0x68
  jmp alltraps
80107922:	e9 30 f7 ff ff       	jmp    80107057 <alltraps>

80107927 <vector105>:
.globl vector105
vector105:
  pushl $0
80107927:	6a 00                	push   $0x0
  pushl $105
80107929:	6a 69                	push   $0x69
  jmp alltraps
8010792b:	e9 27 f7 ff ff       	jmp    80107057 <alltraps>

80107930 <vector106>:
.globl vector106
vector106:
  pushl $0
80107930:	6a 00                	push   $0x0
  pushl $106
80107932:	6a 6a                	push   $0x6a
  jmp alltraps
80107934:	e9 1e f7 ff ff       	jmp    80107057 <alltraps>

80107939 <vector107>:
.globl vector107
vector107:
  pushl $0
80107939:	6a 00                	push   $0x0
  pushl $107
8010793b:	6a 6b                	push   $0x6b
  jmp alltraps
8010793d:	e9 15 f7 ff ff       	jmp    80107057 <alltraps>

80107942 <vector108>:
.globl vector108
vector108:
  pushl $0
80107942:	6a 00                	push   $0x0
  pushl $108
80107944:	6a 6c                	push   $0x6c
  jmp alltraps
80107946:	e9 0c f7 ff ff       	jmp    80107057 <alltraps>

8010794b <vector109>:
.globl vector109
vector109:
  pushl $0
8010794b:	6a 00                	push   $0x0
  pushl $109
8010794d:	6a 6d                	push   $0x6d
  jmp alltraps
8010794f:	e9 03 f7 ff ff       	jmp    80107057 <alltraps>

80107954 <vector110>:
.globl vector110
vector110:
  pushl $0
80107954:	6a 00                	push   $0x0
  pushl $110
80107956:	6a 6e                	push   $0x6e
  jmp alltraps
80107958:	e9 fa f6 ff ff       	jmp    80107057 <alltraps>

8010795d <vector111>:
.globl vector111
vector111:
  pushl $0
8010795d:	6a 00                	push   $0x0
  pushl $111
8010795f:	6a 6f                	push   $0x6f
  jmp alltraps
80107961:	e9 f1 f6 ff ff       	jmp    80107057 <alltraps>

80107966 <vector112>:
.globl vector112
vector112:
  pushl $0
80107966:	6a 00                	push   $0x0
  pushl $112
80107968:	6a 70                	push   $0x70
  jmp alltraps
8010796a:	e9 e8 f6 ff ff       	jmp    80107057 <alltraps>

8010796f <vector113>:
.globl vector113
vector113:
  pushl $0
8010796f:	6a 00                	push   $0x0
  pushl $113
80107971:	6a 71                	push   $0x71
  jmp alltraps
80107973:	e9 df f6 ff ff       	jmp    80107057 <alltraps>

80107978 <vector114>:
.globl vector114
vector114:
  pushl $0
80107978:	6a 00                	push   $0x0
  pushl $114
8010797a:	6a 72                	push   $0x72
  jmp alltraps
8010797c:	e9 d6 f6 ff ff       	jmp    80107057 <alltraps>

80107981 <vector115>:
.globl vector115
vector115:
  pushl $0
80107981:	6a 00                	push   $0x0
  pushl $115
80107983:	6a 73                	push   $0x73
  jmp alltraps
80107985:	e9 cd f6 ff ff       	jmp    80107057 <alltraps>

8010798a <vector116>:
.globl vector116
vector116:
  pushl $0
8010798a:	6a 00                	push   $0x0
  pushl $116
8010798c:	6a 74                	push   $0x74
  jmp alltraps
8010798e:	e9 c4 f6 ff ff       	jmp    80107057 <alltraps>

80107993 <vector117>:
.globl vector117
vector117:
  pushl $0
80107993:	6a 00                	push   $0x0
  pushl $117
80107995:	6a 75                	push   $0x75
  jmp alltraps
80107997:	e9 bb f6 ff ff       	jmp    80107057 <alltraps>

8010799c <vector118>:
.globl vector118
vector118:
  pushl $0
8010799c:	6a 00                	push   $0x0
  pushl $118
8010799e:	6a 76                	push   $0x76
  jmp alltraps
801079a0:	e9 b2 f6 ff ff       	jmp    80107057 <alltraps>

801079a5 <vector119>:
.globl vector119
vector119:
  pushl $0
801079a5:	6a 00                	push   $0x0
  pushl $119
801079a7:	6a 77                	push   $0x77
  jmp alltraps
801079a9:	e9 a9 f6 ff ff       	jmp    80107057 <alltraps>

801079ae <vector120>:
.globl vector120
vector120:
  pushl $0
801079ae:	6a 00                	push   $0x0
  pushl $120
801079b0:	6a 78                	push   $0x78
  jmp alltraps
801079b2:	e9 a0 f6 ff ff       	jmp    80107057 <alltraps>

801079b7 <vector121>:
.globl vector121
vector121:
  pushl $0
801079b7:	6a 00                	push   $0x0
  pushl $121
801079b9:	6a 79                	push   $0x79
  jmp alltraps
801079bb:	e9 97 f6 ff ff       	jmp    80107057 <alltraps>

801079c0 <vector122>:
.globl vector122
vector122:
  pushl $0
801079c0:	6a 00                	push   $0x0
  pushl $122
801079c2:	6a 7a                	push   $0x7a
  jmp alltraps
801079c4:	e9 8e f6 ff ff       	jmp    80107057 <alltraps>

801079c9 <vector123>:
.globl vector123
vector123:
  pushl $0
801079c9:	6a 00                	push   $0x0
  pushl $123
801079cb:	6a 7b                	push   $0x7b
  jmp alltraps
801079cd:	e9 85 f6 ff ff       	jmp    80107057 <alltraps>

801079d2 <vector124>:
.globl vector124
vector124:
  pushl $0
801079d2:	6a 00                	push   $0x0
  pushl $124
801079d4:	6a 7c                	push   $0x7c
  jmp alltraps
801079d6:	e9 7c f6 ff ff       	jmp    80107057 <alltraps>

801079db <vector125>:
.globl vector125
vector125:
  pushl $0
801079db:	6a 00                	push   $0x0
  pushl $125
801079dd:	6a 7d                	push   $0x7d
  jmp alltraps
801079df:	e9 73 f6 ff ff       	jmp    80107057 <alltraps>

801079e4 <vector126>:
.globl vector126
vector126:
  pushl $0
801079e4:	6a 00                	push   $0x0
  pushl $126
801079e6:	6a 7e                	push   $0x7e
  jmp alltraps
801079e8:	e9 6a f6 ff ff       	jmp    80107057 <alltraps>

801079ed <vector127>:
.globl vector127
vector127:
  pushl $0
801079ed:	6a 00                	push   $0x0
  pushl $127
801079ef:	6a 7f                	push   $0x7f
  jmp alltraps
801079f1:	e9 61 f6 ff ff       	jmp    80107057 <alltraps>

801079f6 <vector128>:
.globl vector128
vector128:
  pushl $0
801079f6:	6a 00                	push   $0x0
  pushl $128
801079f8:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801079fd:	e9 55 f6 ff ff       	jmp    80107057 <alltraps>

80107a02 <vector129>:
.globl vector129
vector129:
  pushl $0
80107a02:	6a 00                	push   $0x0
  pushl $129
80107a04:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80107a09:	e9 49 f6 ff ff       	jmp    80107057 <alltraps>

80107a0e <vector130>:
.globl vector130
vector130:
  pushl $0
80107a0e:	6a 00                	push   $0x0
  pushl $130
80107a10:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80107a15:	e9 3d f6 ff ff       	jmp    80107057 <alltraps>

80107a1a <vector131>:
.globl vector131
vector131:
  pushl $0
80107a1a:	6a 00                	push   $0x0
  pushl $131
80107a1c:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80107a21:	e9 31 f6 ff ff       	jmp    80107057 <alltraps>

80107a26 <vector132>:
.globl vector132
vector132:
  pushl $0
80107a26:	6a 00                	push   $0x0
  pushl $132
80107a28:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80107a2d:	e9 25 f6 ff ff       	jmp    80107057 <alltraps>

80107a32 <vector133>:
.globl vector133
vector133:
  pushl $0
80107a32:	6a 00                	push   $0x0
  pushl $133
80107a34:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80107a39:	e9 19 f6 ff ff       	jmp    80107057 <alltraps>

80107a3e <vector134>:
.globl vector134
vector134:
  pushl $0
80107a3e:	6a 00                	push   $0x0
  pushl $134
80107a40:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107a45:	e9 0d f6 ff ff       	jmp    80107057 <alltraps>

80107a4a <vector135>:
.globl vector135
vector135:
  pushl $0
80107a4a:	6a 00                	push   $0x0
  pushl $135
80107a4c:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107a51:	e9 01 f6 ff ff       	jmp    80107057 <alltraps>

80107a56 <vector136>:
.globl vector136
vector136:
  pushl $0
80107a56:	6a 00                	push   $0x0
  pushl $136
80107a58:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80107a5d:	e9 f5 f5 ff ff       	jmp    80107057 <alltraps>

80107a62 <vector137>:
.globl vector137
vector137:
  pushl $0
80107a62:	6a 00                	push   $0x0
  pushl $137
80107a64:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80107a69:	e9 e9 f5 ff ff       	jmp    80107057 <alltraps>

80107a6e <vector138>:
.globl vector138
vector138:
  pushl $0
80107a6e:	6a 00                	push   $0x0
  pushl $138
80107a70:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107a75:	e9 dd f5 ff ff       	jmp    80107057 <alltraps>

80107a7a <vector139>:
.globl vector139
vector139:
  pushl $0
80107a7a:	6a 00                	push   $0x0
  pushl $139
80107a7c:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80107a81:	e9 d1 f5 ff ff       	jmp    80107057 <alltraps>

80107a86 <vector140>:
.globl vector140
vector140:
  pushl $0
80107a86:	6a 00                	push   $0x0
  pushl $140
80107a88:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80107a8d:	e9 c5 f5 ff ff       	jmp    80107057 <alltraps>

80107a92 <vector141>:
.globl vector141
vector141:
  pushl $0
80107a92:	6a 00                	push   $0x0
  pushl $141
80107a94:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80107a99:	e9 b9 f5 ff ff       	jmp    80107057 <alltraps>

80107a9e <vector142>:
.globl vector142
vector142:
  pushl $0
80107a9e:	6a 00                	push   $0x0
  pushl $142
80107aa0:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107aa5:	e9 ad f5 ff ff       	jmp    80107057 <alltraps>

80107aaa <vector143>:
.globl vector143
vector143:
  pushl $0
80107aaa:	6a 00                	push   $0x0
  pushl $143
80107aac:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80107ab1:	e9 a1 f5 ff ff       	jmp    80107057 <alltraps>

80107ab6 <vector144>:
.globl vector144
vector144:
  pushl $0
80107ab6:	6a 00                	push   $0x0
  pushl $144
80107ab8:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80107abd:	e9 95 f5 ff ff       	jmp    80107057 <alltraps>

80107ac2 <vector145>:
.globl vector145
vector145:
  pushl $0
80107ac2:	6a 00                	push   $0x0
  pushl $145
80107ac4:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80107ac9:	e9 89 f5 ff ff       	jmp    80107057 <alltraps>

80107ace <vector146>:
.globl vector146
vector146:
  pushl $0
80107ace:	6a 00                	push   $0x0
  pushl $146
80107ad0:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107ad5:	e9 7d f5 ff ff       	jmp    80107057 <alltraps>

80107ada <vector147>:
.globl vector147
vector147:
  pushl $0
80107ada:	6a 00                	push   $0x0
  pushl $147
80107adc:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107ae1:	e9 71 f5 ff ff       	jmp    80107057 <alltraps>

80107ae6 <vector148>:
.globl vector148
vector148:
  pushl $0
80107ae6:	6a 00                	push   $0x0
  pushl $148
80107ae8:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80107aed:	e9 65 f5 ff ff       	jmp    80107057 <alltraps>

80107af2 <vector149>:
.globl vector149
vector149:
  pushl $0
80107af2:	6a 00                	push   $0x0
  pushl $149
80107af4:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80107af9:	e9 59 f5 ff ff       	jmp    80107057 <alltraps>

80107afe <vector150>:
.globl vector150
vector150:
  pushl $0
80107afe:	6a 00                	push   $0x0
  pushl $150
80107b00:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107b05:	e9 4d f5 ff ff       	jmp    80107057 <alltraps>

80107b0a <vector151>:
.globl vector151
vector151:
  pushl $0
80107b0a:	6a 00                	push   $0x0
  pushl $151
80107b0c:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107b11:	e9 41 f5 ff ff       	jmp    80107057 <alltraps>

80107b16 <vector152>:
.globl vector152
vector152:
  pushl $0
80107b16:	6a 00                	push   $0x0
  pushl $152
80107b18:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80107b1d:	e9 35 f5 ff ff       	jmp    80107057 <alltraps>

80107b22 <vector153>:
.globl vector153
vector153:
  pushl $0
80107b22:	6a 00                	push   $0x0
  pushl $153
80107b24:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80107b29:	e9 29 f5 ff ff       	jmp    80107057 <alltraps>

80107b2e <vector154>:
.globl vector154
vector154:
  pushl $0
80107b2e:	6a 00                	push   $0x0
  pushl $154
80107b30:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107b35:	e9 1d f5 ff ff       	jmp    80107057 <alltraps>

80107b3a <vector155>:
.globl vector155
vector155:
  pushl $0
80107b3a:	6a 00                	push   $0x0
  pushl $155
80107b3c:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107b41:	e9 11 f5 ff ff       	jmp    80107057 <alltraps>

80107b46 <vector156>:
.globl vector156
vector156:
  pushl $0
80107b46:	6a 00                	push   $0x0
  pushl $156
80107b48:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80107b4d:	e9 05 f5 ff ff       	jmp    80107057 <alltraps>

80107b52 <vector157>:
.globl vector157
vector157:
  pushl $0
80107b52:	6a 00                	push   $0x0
  pushl $157
80107b54:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80107b59:	e9 f9 f4 ff ff       	jmp    80107057 <alltraps>

80107b5e <vector158>:
.globl vector158
vector158:
  pushl $0
80107b5e:	6a 00                	push   $0x0
  pushl $158
80107b60:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107b65:	e9 ed f4 ff ff       	jmp    80107057 <alltraps>

80107b6a <vector159>:
.globl vector159
vector159:
  pushl $0
80107b6a:	6a 00                	push   $0x0
  pushl $159
80107b6c:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80107b71:	e9 e1 f4 ff ff       	jmp    80107057 <alltraps>

80107b76 <vector160>:
.globl vector160
vector160:
  pushl $0
80107b76:	6a 00                	push   $0x0
  pushl $160
80107b78:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80107b7d:	e9 d5 f4 ff ff       	jmp    80107057 <alltraps>

80107b82 <vector161>:
.globl vector161
vector161:
  pushl $0
80107b82:	6a 00                	push   $0x0
  pushl $161
80107b84:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80107b89:	e9 c9 f4 ff ff       	jmp    80107057 <alltraps>

80107b8e <vector162>:
.globl vector162
vector162:
  pushl $0
80107b8e:	6a 00                	push   $0x0
  pushl $162
80107b90:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107b95:	e9 bd f4 ff ff       	jmp    80107057 <alltraps>

80107b9a <vector163>:
.globl vector163
vector163:
  pushl $0
80107b9a:	6a 00                	push   $0x0
  pushl $163
80107b9c:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80107ba1:	e9 b1 f4 ff ff       	jmp    80107057 <alltraps>

80107ba6 <vector164>:
.globl vector164
vector164:
  pushl $0
80107ba6:	6a 00                	push   $0x0
  pushl $164
80107ba8:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80107bad:	e9 a5 f4 ff ff       	jmp    80107057 <alltraps>

80107bb2 <vector165>:
.globl vector165
vector165:
  pushl $0
80107bb2:	6a 00                	push   $0x0
  pushl $165
80107bb4:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80107bb9:	e9 99 f4 ff ff       	jmp    80107057 <alltraps>

80107bbe <vector166>:
.globl vector166
vector166:
  pushl $0
80107bbe:	6a 00                	push   $0x0
  pushl $166
80107bc0:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107bc5:	e9 8d f4 ff ff       	jmp    80107057 <alltraps>

80107bca <vector167>:
.globl vector167
vector167:
  pushl $0
80107bca:	6a 00                	push   $0x0
  pushl $167
80107bcc:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107bd1:	e9 81 f4 ff ff       	jmp    80107057 <alltraps>

80107bd6 <vector168>:
.globl vector168
vector168:
  pushl $0
80107bd6:	6a 00                	push   $0x0
  pushl $168
80107bd8:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80107bdd:	e9 75 f4 ff ff       	jmp    80107057 <alltraps>

80107be2 <vector169>:
.globl vector169
vector169:
  pushl $0
80107be2:	6a 00                	push   $0x0
  pushl $169
80107be4:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80107be9:	e9 69 f4 ff ff       	jmp    80107057 <alltraps>

80107bee <vector170>:
.globl vector170
vector170:
  pushl $0
80107bee:	6a 00                	push   $0x0
  pushl $170
80107bf0:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107bf5:	e9 5d f4 ff ff       	jmp    80107057 <alltraps>

80107bfa <vector171>:
.globl vector171
vector171:
  pushl $0
80107bfa:	6a 00                	push   $0x0
  pushl $171
80107bfc:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107c01:	e9 51 f4 ff ff       	jmp    80107057 <alltraps>

80107c06 <vector172>:
.globl vector172
vector172:
  pushl $0
80107c06:	6a 00                	push   $0x0
  pushl $172
80107c08:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80107c0d:	e9 45 f4 ff ff       	jmp    80107057 <alltraps>

80107c12 <vector173>:
.globl vector173
vector173:
  pushl $0
80107c12:	6a 00                	push   $0x0
  pushl $173
80107c14:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80107c19:	e9 39 f4 ff ff       	jmp    80107057 <alltraps>

80107c1e <vector174>:
.globl vector174
vector174:
  pushl $0
80107c1e:	6a 00                	push   $0x0
  pushl $174
80107c20:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107c25:	e9 2d f4 ff ff       	jmp    80107057 <alltraps>

80107c2a <vector175>:
.globl vector175
vector175:
  pushl $0
80107c2a:	6a 00                	push   $0x0
  pushl $175
80107c2c:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107c31:	e9 21 f4 ff ff       	jmp    80107057 <alltraps>

80107c36 <vector176>:
.globl vector176
vector176:
  pushl $0
80107c36:	6a 00                	push   $0x0
  pushl $176
80107c38:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80107c3d:	e9 15 f4 ff ff       	jmp    80107057 <alltraps>

80107c42 <vector177>:
.globl vector177
vector177:
  pushl $0
80107c42:	6a 00                	push   $0x0
  pushl $177
80107c44:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80107c49:	e9 09 f4 ff ff       	jmp    80107057 <alltraps>

80107c4e <vector178>:
.globl vector178
vector178:
  pushl $0
80107c4e:	6a 00                	push   $0x0
  pushl $178
80107c50:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107c55:	e9 fd f3 ff ff       	jmp    80107057 <alltraps>

80107c5a <vector179>:
.globl vector179
vector179:
  pushl $0
80107c5a:	6a 00                	push   $0x0
  pushl $179
80107c5c:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107c61:	e9 f1 f3 ff ff       	jmp    80107057 <alltraps>

80107c66 <vector180>:
.globl vector180
vector180:
  pushl $0
80107c66:	6a 00                	push   $0x0
  pushl $180
80107c68:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80107c6d:	e9 e5 f3 ff ff       	jmp    80107057 <alltraps>

80107c72 <vector181>:
.globl vector181
vector181:
  pushl $0
80107c72:	6a 00                	push   $0x0
  pushl $181
80107c74:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80107c79:	e9 d9 f3 ff ff       	jmp    80107057 <alltraps>

80107c7e <vector182>:
.globl vector182
vector182:
  pushl $0
80107c7e:	6a 00                	push   $0x0
  pushl $182
80107c80:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107c85:	e9 cd f3 ff ff       	jmp    80107057 <alltraps>

80107c8a <vector183>:
.globl vector183
vector183:
  pushl $0
80107c8a:	6a 00                	push   $0x0
  pushl $183
80107c8c:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107c91:	e9 c1 f3 ff ff       	jmp    80107057 <alltraps>

80107c96 <vector184>:
.globl vector184
vector184:
  pushl $0
80107c96:	6a 00                	push   $0x0
  pushl $184
80107c98:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80107c9d:	e9 b5 f3 ff ff       	jmp    80107057 <alltraps>

80107ca2 <vector185>:
.globl vector185
vector185:
  pushl $0
80107ca2:	6a 00                	push   $0x0
  pushl $185
80107ca4:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80107ca9:	e9 a9 f3 ff ff       	jmp    80107057 <alltraps>

80107cae <vector186>:
.globl vector186
vector186:
  pushl $0
80107cae:	6a 00                	push   $0x0
  pushl $186
80107cb0:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107cb5:	e9 9d f3 ff ff       	jmp    80107057 <alltraps>

80107cba <vector187>:
.globl vector187
vector187:
  pushl $0
80107cba:	6a 00                	push   $0x0
  pushl $187
80107cbc:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107cc1:	e9 91 f3 ff ff       	jmp    80107057 <alltraps>

80107cc6 <vector188>:
.globl vector188
vector188:
  pushl $0
80107cc6:	6a 00                	push   $0x0
  pushl $188
80107cc8:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80107ccd:	e9 85 f3 ff ff       	jmp    80107057 <alltraps>

80107cd2 <vector189>:
.globl vector189
vector189:
  pushl $0
80107cd2:	6a 00                	push   $0x0
  pushl $189
80107cd4:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80107cd9:	e9 79 f3 ff ff       	jmp    80107057 <alltraps>

80107cde <vector190>:
.globl vector190
vector190:
  pushl $0
80107cde:	6a 00                	push   $0x0
  pushl $190
80107ce0:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107ce5:	e9 6d f3 ff ff       	jmp    80107057 <alltraps>

80107cea <vector191>:
.globl vector191
vector191:
  pushl $0
80107cea:	6a 00                	push   $0x0
  pushl $191
80107cec:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107cf1:	e9 61 f3 ff ff       	jmp    80107057 <alltraps>

80107cf6 <vector192>:
.globl vector192
vector192:
  pushl $0
80107cf6:	6a 00                	push   $0x0
  pushl $192
80107cf8:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80107cfd:	e9 55 f3 ff ff       	jmp    80107057 <alltraps>

80107d02 <vector193>:
.globl vector193
vector193:
  pushl $0
80107d02:	6a 00                	push   $0x0
  pushl $193
80107d04:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80107d09:	e9 49 f3 ff ff       	jmp    80107057 <alltraps>

80107d0e <vector194>:
.globl vector194
vector194:
  pushl $0
80107d0e:	6a 00                	push   $0x0
  pushl $194
80107d10:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107d15:	e9 3d f3 ff ff       	jmp    80107057 <alltraps>

80107d1a <vector195>:
.globl vector195
vector195:
  pushl $0
80107d1a:	6a 00                	push   $0x0
  pushl $195
80107d1c:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107d21:	e9 31 f3 ff ff       	jmp    80107057 <alltraps>

80107d26 <vector196>:
.globl vector196
vector196:
  pushl $0
80107d26:	6a 00                	push   $0x0
  pushl $196
80107d28:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80107d2d:	e9 25 f3 ff ff       	jmp    80107057 <alltraps>

80107d32 <vector197>:
.globl vector197
vector197:
  pushl $0
80107d32:	6a 00                	push   $0x0
  pushl $197
80107d34:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80107d39:	e9 19 f3 ff ff       	jmp    80107057 <alltraps>

80107d3e <vector198>:
.globl vector198
vector198:
  pushl $0
80107d3e:	6a 00                	push   $0x0
  pushl $198
80107d40:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107d45:	e9 0d f3 ff ff       	jmp    80107057 <alltraps>

80107d4a <vector199>:
.globl vector199
vector199:
  pushl $0
80107d4a:	6a 00                	push   $0x0
  pushl $199
80107d4c:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107d51:	e9 01 f3 ff ff       	jmp    80107057 <alltraps>

80107d56 <vector200>:
.globl vector200
vector200:
  pushl $0
80107d56:	6a 00                	push   $0x0
  pushl $200
80107d58:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80107d5d:	e9 f5 f2 ff ff       	jmp    80107057 <alltraps>

80107d62 <vector201>:
.globl vector201
vector201:
  pushl $0
80107d62:	6a 00                	push   $0x0
  pushl $201
80107d64:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80107d69:	e9 e9 f2 ff ff       	jmp    80107057 <alltraps>

80107d6e <vector202>:
.globl vector202
vector202:
  pushl $0
80107d6e:	6a 00                	push   $0x0
  pushl $202
80107d70:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107d75:	e9 dd f2 ff ff       	jmp    80107057 <alltraps>

80107d7a <vector203>:
.globl vector203
vector203:
  pushl $0
80107d7a:	6a 00                	push   $0x0
  pushl $203
80107d7c:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107d81:	e9 d1 f2 ff ff       	jmp    80107057 <alltraps>

80107d86 <vector204>:
.globl vector204
vector204:
  pushl $0
80107d86:	6a 00                	push   $0x0
  pushl $204
80107d88:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80107d8d:	e9 c5 f2 ff ff       	jmp    80107057 <alltraps>

80107d92 <vector205>:
.globl vector205
vector205:
  pushl $0
80107d92:	6a 00                	push   $0x0
  pushl $205
80107d94:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80107d99:	e9 b9 f2 ff ff       	jmp    80107057 <alltraps>

80107d9e <vector206>:
.globl vector206
vector206:
  pushl $0
80107d9e:	6a 00                	push   $0x0
  pushl $206
80107da0:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107da5:	e9 ad f2 ff ff       	jmp    80107057 <alltraps>

80107daa <vector207>:
.globl vector207
vector207:
  pushl $0
80107daa:	6a 00                	push   $0x0
  pushl $207
80107dac:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107db1:	e9 a1 f2 ff ff       	jmp    80107057 <alltraps>

80107db6 <vector208>:
.globl vector208
vector208:
  pushl $0
80107db6:	6a 00                	push   $0x0
  pushl $208
80107db8:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80107dbd:	e9 95 f2 ff ff       	jmp    80107057 <alltraps>

80107dc2 <vector209>:
.globl vector209
vector209:
  pushl $0
80107dc2:	6a 00                	push   $0x0
  pushl $209
80107dc4:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80107dc9:	e9 89 f2 ff ff       	jmp    80107057 <alltraps>

80107dce <vector210>:
.globl vector210
vector210:
  pushl $0
80107dce:	6a 00                	push   $0x0
  pushl $210
80107dd0:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107dd5:	e9 7d f2 ff ff       	jmp    80107057 <alltraps>

80107dda <vector211>:
.globl vector211
vector211:
  pushl $0
80107dda:	6a 00                	push   $0x0
  pushl $211
80107ddc:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107de1:	e9 71 f2 ff ff       	jmp    80107057 <alltraps>

80107de6 <vector212>:
.globl vector212
vector212:
  pushl $0
80107de6:	6a 00                	push   $0x0
  pushl $212
80107de8:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80107ded:	e9 65 f2 ff ff       	jmp    80107057 <alltraps>

80107df2 <vector213>:
.globl vector213
vector213:
  pushl $0
80107df2:	6a 00                	push   $0x0
  pushl $213
80107df4:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80107df9:	e9 59 f2 ff ff       	jmp    80107057 <alltraps>

80107dfe <vector214>:
.globl vector214
vector214:
  pushl $0
80107dfe:	6a 00                	push   $0x0
  pushl $214
80107e00:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107e05:	e9 4d f2 ff ff       	jmp    80107057 <alltraps>

80107e0a <vector215>:
.globl vector215
vector215:
  pushl $0
80107e0a:	6a 00                	push   $0x0
  pushl $215
80107e0c:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107e11:	e9 41 f2 ff ff       	jmp    80107057 <alltraps>

80107e16 <vector216>:
.globl vector216
vector216:
  pushl $0
80107e16:	6a 00                	push   $0x0
  pushl $216
80107e18:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80107e1d:	e9 35 f2 ff ff       	jmp    80107057 <alltraps>

80107e22 <vector217>:
.globl vector217
vector217:
  pushl $0
80107e22:	6a 00                	push   $0x0
  pushl $217
80107e24:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80107e29:	e9 29 f2 ff ff       	jmp    80107057 <alltraps>

80107e2e <vector218>:
.globl vector218
vector218:
  pushl $0
80107e2e:	6a 00                	push   $0x0
  pushl $218
80107e30:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107e35:	e9 1d f2 ff ff       	jmp    80107057 <alltraps>

80107e3a <vector219>:
.globl vector219
vector219:
  pushl $0
80107e3a:	6a 00                	push   $0x0
  pushl $219
80107e3c:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107e41:	e9 11 f2 ff ff       	jmp    80107057 <alltraps>

80107e46 <vector220>:
.globl vector220
vector220:
  pushl $0
80107e46:	6a 00                	push   $0x0
  pushl $220
80107e48:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80107e4d:	e9 05 f2 ff ff       	jmp    80107057 <alltraps>

80107e52 <vector221>:
.globl vector221
vector221:
  pushl $0
80107e52:	6a 00                	push   $0x0
  pushl $221
80107e54:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80107e59:	e9 f9 f1 ff ff       	jmp    80107057 <alltraps>

80107e5e <vector222>:
.globl vector222
vector222:
  pushl $0
80107e5e:	6a 00                	push   $0x0
  pushl $222
80107e60:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107e65:	e9 ed f1 ff ff       	jmp    80107057 <alltraps>

80107e6a <vector223>:
.globl vector223
vector223:
  pushl $0
80107e6a:	6a 00                	push   $0x0
  pushl $223
80107e6c:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107e71:	e9 e1 f1 ff ff       	jmp    80107057 <alltraps>

80107e76 <vector224>:
.globl vector224
vector224:
  pushl $0
80107e76:	6a 00                	push   $0x0
  pushl $224
80107e78:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80107e7d:	e9 d5 f1 ff ff       	jmp    80107057 <alltraps>

80107e82 <vector225>:
.globl vector225
vector225:
  pushl $0
80107e82:	6a 00                	push   $0x0
  pushl $225
80107e84:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107e89:	e9 c9 f1 ff ff       	jmp    80107057 <alltraps>

80107e8e <vector226>:
.globl vector226
vector226:
  pushl $0
80107e8e:	6a 00                	push   $0x0
  pushl $226
80107e90:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107e95:	e9 bd f1 ff ff       	jmp    80107057 <alltraps>

80107e9a <vector227>:
.globl vector227
vector227:
  pushl $0
80107e9a:	6a 00                	push   $0x0
  pushl $227
80107e9c:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107ea1:	e9 b1 f1 ff ff       	jmp    80107057 <alltraps>

80107ea6 <vector228>:
.globl vector228
vector228:
  pushl $0
80107ea6:	6a 00                	push   $0x0
  pushl $228
80107ea8:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107ead:	e9 a5 f1 ff ff       	jmp    80107057 <alltraps>

80107eb2 <vector229>:
.globl vector229
vector229:
  pushl $0
80107eb2:	6a 00                	push   $0x0
  pushl $229
80107eb4:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107eb9:	e9 99 f1 ff ff       	jmp    80107057 <alltraps>

80107ebe <vector230>:
.globl vector230
vector230:
  pushl $0
80107ebe:	6a 00                	push   $0x0
  pushl $230
80107ec0:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107ec5:	e9 8d f1 ff ff       	jmp    80107057 <alltraps>

80107eca <vector231>:
.globl vector231
vector231:
  pushl $0
80107eca:	6a 00                	push   $0x0
  pushl $231
80107ecc:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107ed1:	e9 81 f1 ff ff       	jmp    80107057 <alltraps>

80107ed6 <vector232>:
.globl vector232
vector232:
  pushl $0
80107ed6:	6a 00                	push   $0x0
  pushl $232
80107ed8:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107edd:	e9 75 f1 ff ff       	jmp    80107057 <alltraps>

80107ee2 <vector233>:
.globl vector233
vector233:
  pushl $0
80107ee2:	6a 00                	push   $0x0
  pushl $233
80107ee4:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107ee9:	e9 69 f1 ff ff       	jmp    80107057 <alltraps>

80107eee <vector234>:
.globl vector234
vector234:
  pushl $0
80107eee:	6a 00                	push   $0x0
  pushl $234
80107ef0:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107ef5:	e9 5d f1 ff ff       	jmp    80107057 <alltraps>

80107efa <vector235>:
.globl vector235
vector235:
  pushl $0
80107efa:	6a 00                	push   $0x0
  pushl $235
80107efc:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107f01:	e9 51 f1 ff ff       	jmp    80107057 <alltraps>

80107f06 <vector236>:
.globl vector236
vector236:
  pushl $0
80107f06:	6a 00                	push   $0x0
  pushl $236
80107f08:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107f0d:	e9 45 f1 ff ff       	jmp    80107057 <alltraps>

80107f12 <vector237>:
.globl vector237
vector237:
  pushl $0
80107f12:	6a 00                	push   $0x0
  pushl $237
80107f14:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107f19:	e9 39 f1 ff ff       	jmp    80107057 <alltraps>

80107f1e <vector238>:
.globl vector238
vector238:
  pushl $0
80107f1e:	6a 00                	push   $0x0
  pushl $238
80107f20:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107f25:	e9 2d f1 ff ff       	jmp    80107057 <alltraps>

80107f2a <vector239>:
.globl vector239
vector239:
  pushl $0
80107f2a:	6a 00                	push   $0x0
  pushl $239
80107f2c:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107f31:	e9 21 f1 ff ff       	jmp    80107057 <alltraps>

80107f36 <vector240>:
.globl vector240
vector240:
  pushl $0
80107f36:	6a 00                	push   $0x0
  pushl $240
80107f38:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107f3d:	e9 15 f1 ff ff       	jmp    80107057 <alltraps>

80107f42 <vector241>:
.globl vector241
vector241:
  pushl $0
80107f42:	6a 00                	push   $0x0
  pushl $241
80107f44:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107f49:	e9 09 f1 ff ff       	jmp    80107057 <alltraps>

80107f4e <vector242>:
.globl vector242
vector242:
  pushl $0
80107f4e:	6a 00                	push   $0x0
  pushl $242
80107f50:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107f55:	e9 fd f0 ff ff       	jmp    80107057 <alltraps>

80107f5a <vector243>:
.globl vector243
vector243:
  pushl $0
80107f5a:	6a 00                	push   $0x0
  pushl $243
80107f5c:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107f61:	e9 f1 f0 ff ff       	jmp    80107057 <alltraps>

80107f66 <vector244>:
.globl vector244
vector244:
  pushl $0
80107f66:	6a 00                	push   $0x0
  pushl $244
80107f68:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107f6d:	e9 e5 f0 ff ff       	jmp    80107057 <alltraps>

80107f72 <vector245>:
.globl vector245
vector245:
  pushl $0
80107f72:	6a 00                	push   $0x0
  pushl $245
80107f74:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107f79:	e9 d9 f0 ff ff       	jmp    80107057 <alltraps>

80107f7e <vector246>:
.globl vector246
vector246:
  pushl $0
80107f7e:	6a 00                	push   $0x0
  pushl $246
80107f80:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107f85:	e9 cd f0 ff ff       	jmp    80107057 <alltraps>

80107f8a <vector247>:
.globl vector247
vector247:
  pushl $0
80107f8a:	6a 00                	push   $0x0
  pushl $247
80107f8c:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107f91:	e9 c1 f0 ff ff       	jmp    80107057 <alltraps>

80107f96 <vector248>:
.globl vector248
vector248:
  pushl $0
80107f96:	6a 00                	push   $0x0
  pushl $248
80107f98:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107f9d:	e9 b5 f0 ff ff       	jmp    80107057 <alltraps>

80107fa2 <vector249>:
.globl vector249
vector249:
  pushl $0
80107fa2:	6a 00                	push   $0x0
  pushl $249
80107fa4:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107fa9:	e9 a9 f0 ff ff       	jmp    80107057 <alltraps>

80107fae <vector250>:
.globl vector250
vector250:
  pushl $0
80107fae:	6a 00                	push   $0x0
  pushl $250
80107fb0:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107fb5:	e9 9d f0 ff ff       	jmp    80107057 <alltraps>

80107fba <vector251>:
.globl vector251
vector251:
  pushl $0
80107fba:	6a 00                	push   $0x0
  pushl $251
80107fbc:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107fc1:	e9 91 f0 ff ff       	jmp    80107057 <alltraps>

80107fc6 <vector252>:
.globl vector252
vector252:
  pushl $0
80107fc6:	6a 00                	push   $0x0
  pushl $252
80107fc8:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107fcd:	e9 85 f0 ff ff       	jmp    80107057 <alltraps>

80107fd2 <vector253>:
.globl vector253
vector253:
  pushl $0
80107fd2:	6a 00                	push   $0x0
  pushl $253
80107fd4:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107fd9:	e9 79 f0 ff ff       	jmp    80107057 <alltraps>

80107fde <vector254>:
.globl vector254
vector254:
  pushl $0
80107fde:	6a 00                	push   $0x0
  pushl $254
80107fe0:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107fe5:	e9 6d f0 ff ff       	jmp    80107057 <alltraps>

80107fea <vector255>:
.globl vector255
vector255:
  pushl $0
80107fea:	6a 00                	push   $0x0
  pushl $255
80107fec:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107ff1:	e9 61 f0 ff ff       	jmp    80107057 <alltraps>
80107ff6:	66 90                	xchg   %ax,%ax
80107ff8:	66 90                	xchg   %ax,%ax
80107ffa:	66 90                	xchg   %ax,%ax
80107ffc:	66 90                	xchg   %ax,%ax
80107ffe:	66 90                	xchg   %ax,%ax

80108000 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80108000:	55                   	push   %ebp
80108001:	89 e5                	mov    %esp,%ebp
80108003:	83 ec 28             	sub    $0x28,%esp
80108006:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80108009:	89 d3                	mov    %edx,%ebx
8010800b:	c1 eb 16             	shr    $0x16,%ebx
{
8010800e:	89 75 f8             	mov    %esi,-0x8(%ebp)
  pde = &pgdir[PDX(va)];
80108011:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80108014:	89 7d fc             	mov    %edi,-0x4(%ebp)
80108017:	89 d7                	mov    %edx,%edi
  if(*pde & PTE_P){
80108019:	8b 06                	mov    (%esi),%eax
8010801b:	a8 01                	test   $0x1,%al
8010801d:	74 29                	je     80108048 <walkpgdir+0x48>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010801f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108024:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
8010802a:	c1 ef 0a             	shr    $0xa,%edi
}
8010802d:	8b 75 f8             	mov    -0x8(%ebp),%esi
  return &pgtab[PTX(va)];
80108030:	89 fa                	mov    %edi,%edx
}
80108032:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return &pgtab[PTX(va)];
80108035:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
8010803b:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
8010803e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80108041:	89 ec                	mov    %ebp,%esp
80108043:	5d                   	pop    %ebp
80108044:	c3                   	ret    
80108045:	8d 76 00             	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80108048:	85 c9                	test   %ecx,%ecx
8010804a:	74 34                	je     80108080 <walkpgdir+0x80>
8010804c:	e8 5f a5 ff ff       	call   801025b0 <kalloc>
80108051:	85 c0                	test   %eax,%eax
80108053:	89 c3                	mov    %eax,%ebx
80108055:	74 29                	je     80108080 <walkpgdir+0x80>
    memset(pgtab, 0, PGSIZE);
80108057:	b8 00 10 00 00       	mov    $0x1000,%eax
8010805c:	31 d2                	xor    %edx,%edx
8010805e:	89 44 24 08          	mov    %eax,0x8(%esp)
80108062:	89 54 24 04          	mov    %edx,0x4(%esp)
80108066:	89 1c 24             	mov    %ebx,(%esp)
80108069:	e8 d2 dc ff ff       	call   80105d40 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010806e:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80108074:	83 c8 07             	or     $0x7,%eax
80108077:	89 06                	mov    %eax,(%esi)
80108079:	eb af                	jmp    8010802a <walkpgdir+0x2a>
8010807b:	90                   	nop
8010807c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80108080:	8b 5d f4             	mov    -0xc(%ebp),%ebx
      return 0;
80108083:	31 c0                	xor    %eax,%eax
}
80108085:	8b 75 f8             	mov    -0x8(%ebp),%esi
80108088:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010808b:	89 ec                	mov    %ebp,%esp
8010808d:	5d                   	pop    %ebp
8010808e:	c3                   	ret    
8010808f:	90                   	nop

80108090 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80108090:	55                   	push   %ebp
80108091:	89 e5                	mov    %esp,%ebp
80108093:	57                   	push   %edi
80108094:	56                   	push   %esi
80108095:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80108096:	89 d3                	mov    %edx,%ebx
{
80108098:	83 ec 2c             	sub    $0x2c,%esp
  a = (char*)PGROUNDDOWN((uint)va);
8010809b:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
801080a1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801080a4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801080a8:	8b 7d 08             	mov    0x8(%ebp),%edi
801080ab:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801080b0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801080b3:	8b 45 0c             	mov    0xc(%ebp),%eax
801080b6:	29 df                	sub    %ebx,%edi
801080b8:	83 c8 01             	or     $0x1,%eax
801080bb:	89 45 dc             	mov    %eax,-0x24(%ebp)
801080be:	eb 17                	jmp    801080d7 <mappages+0x47>
    if(*pte & PTE_P)
801080c0:	f6 00 01             	testb  $0x1,(%eax)
801080c3:	75 45                	jne    8010810a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
801080c5:	8b 55 dc             	mov    -0x24(%ebp),%edx
801080c8:	09 d6                	or     %edx,%esi
    if(a == last)
801080ca:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
801080cd:	89 30                	mov    %esi,(%eax)
    if(a == last)
801080cf:	74 2f                	je     80108100 <mappages+0x70>
      break;
    a += PGSIZE;
801080d1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801080d7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801080da:	b9 01 00 00 00       	mov    $0x1,%ecx
801080df:	89 da                	mov    %ebx,%edx
801080e1:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
801080e4:	e8 17 ff ff ff       	call   80108000 <walkpgdir>
801080e9:	85 c0                	test   %eax,%eax
801080eb:	75 d3                	jne    801080c0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
801080ed:	83 c4 2c             	add    $0x2c,%esp
      return -1;
801080f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801080f5:	5b                   	pop    %ebx
801080f6:	5e                   	pop    %esi
801080f7:	5f                   	pop    %edi
801080f8:	5d                   	pop    %ebp
801080f9:	c3                   	ret    
801080fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80108100:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80108103:	31 c0                	xor    %eax,%eax
}
80108105:	5b                   	pop    %ebx
80108106:	5e                   	pop    %esi
80108107:	5f                   	pop    %edi
80108108:	5d                   	pop    %ebp
80108109:	c3                   	ret    
      panic("remap");
8010810a:	c7 04 24 b8 92 10 80 	movl   $0x801092b8,(%esp)
80108111:	e8 5a 82 ff ff       	call   80100370 <panic>
80108116:	8d 76 00             	lea    0x0(%esi),%esi
80108119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108120 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80108120:	55                   	push   %ebp
80108121:	89 e5                	mov    %esp,%ebp
80108123:	57                   	push   %edi
80108124:	89 c7                	mov    %eax,%edi
80108126:	56                   	push   %esi
80108127:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80108128:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010812e:	83 ec 2c             	sub    $0x2c,%esp
  a = PGROUNDUP(newsz);
80108131:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80108137:	39 d3                	cmp    %edx,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80108139:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010813c:	73 62                	jae    801081a0 <deallocuvm.part.0+0x80>
8010813e:	89 d6                	mov    %edx,%esi
80108140:	eb 39                	jmp    8010817b <deallocuvm.part.0+0x5b>
80108142:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80108148:	8b 10                	mov    (%eax),%edx
8010814a:	f6 c2 01             	test   $0x1,%dl
8010814d:	74 22                	je     80108171 <deallocuvm.part.0+0x51>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010814f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80108155:	74 54                	je     801081ab <deallocuvm.part.0+0x8b>
        panic("kfree");
      char *v = P2V(pa);
80108157:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
8010815d:	89 14 24             	mov    %edx,(%esp)
80108160:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108163:	e8 78 a2 ff ff       	call   801023e0 <kfree>
      *pte = 0;
80108168:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010816b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80108171:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80108177:	39 f3                	cmp    %esi,%ebx
80108179:	73 25                	jae    801081a0 <deallocuvm.part.0+0x80>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010817b:	31 c9                	xor    %ecx,%ecx
8010817d:	89 da                	mov    %ebx,%edx
8010817f:	89 f8                	mov    %edi,%eax
80108181:	e8 7a fe ff ff       	call   80108000 <walkpgdir>
    if(!pte)
80108186:	85 c0                	test   %eax,%eax
80108188:	75 be                	jne    80108148 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010818a:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80108190:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80108196:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010819c:	39 f3                	cmp    %esi,%ebx
8010819e:	72 db                	jb     8010817b <deallocuvm.part.0+0x5b>
    }
  }
  return newsz;
}
801081a0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801081a3:	83 c4 2c             	add    $0x2c,%esp
801081a6:	5b                   	pop    %ebx
801081a7:	5e                   	pop    %esi
801081a8:	5f                   	pop    %edi
801081a9:	5d                   	pop    %ebp
801081aa:	c3                   	ret    
        panic("kfree");
801081ab:	c7 04 24 c6 8b 10 80 	movl   $0x80108bc6,(%esp)
801081b2:	e8 b9 81 ff ff       	call   80100370 <panic>
801081b7:	89 f6                	mov    %esi,%esi
801081b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801081c0 <seginit>:
{
801081c0:	55                   	push   %ebp
801081c1:	89 e5                	mov    %esp,%ebp
801081c3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
801081c6:	e8 b5 b7 ff ff       	call   80103980 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801081cb:	b9 00 9a cf 00       	mov    $0xcf9a00,%ecx
  pd[0] = size-1;
801081d0:	66 c7 45 f2 2f 00    	movw   $0x2f,-0xe(%ebp)
801081d6:	8d 14 80             	lea    (%eax,%eax,4),%edx
801081d9:	8d 04 50             	lea    (%eax,%edx,2),%eax
801081dc:	ba ff ff 00 00       	mov    $0xffff,%edx
801081e1:	c1 e0 04             	shl    $0x4,%eax
801081e4:	89 90 78 48 11 80    	mov    %edx,-0x7feeb788(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801081ea:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801081ef:	89 88 7c 48 11 80    	mov    %ecx,-0x7feeb784(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801081f5:	b9 00 92 cf 00       	mov    $0xcf9200,%ecx
801081fa:	89 90 80 48 11 80    	mov    %edx,-0x7feeb780(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80108200:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80108205:	89 88 84 48 11 80    	mov    %ecx,-0x7feeb77c(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010820b:	b9 00 fa cf 00       	mov    $0xcffa00,%ecx
80108210:	89 90 88 48 11 80    	mov    %edx,-0x7feeb778(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80108216:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010821b:	89 88 8c 48 11 80    	mov    %ecx,-0x7feeb774(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80108221:	b9 00 f2 cf 00       	mov    $0xcff200,%ecx
80108226:	89 90 90 48 11 80    	mov    %edx,-0x7feeb770(%eax)
8010822c:	89 88 94 48 11 80    	mov    %ecx,-0x7feeb76c(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80108232:	05 70 48 11 80       	add    $0x80114870,%eax
  pd[1] = (uint)p;
80108237:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
8010823a:	c1 e8 10             	shr    $0x10,%eax
  pd[1] = (uint)p;
8010823d:	66 89 55 f4          	mov    %dx,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80108241:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80108245:	8d 45 f2             	lea    -0xe(%ebp),%eax
80108248:	0f 01 10             	lgdtl  (%eax)
}
8010824b:	c9                   	leave  
8010824c:	c3                   	ret    
8010824d:	8d 76 00             	lea    0x0(%esi),%esi

80108250 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108250:	a1 24 80 11 80       	mov    0x80118024,%eax
{
80108255:	55                   	push   %ebp
80108256:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108258:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010825d:	0f 22 d8             	mov    %eax,%cr3
}
80108260:	5d                   	pop    %ebp
80108261:	c3                   	ret    
80108262:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108270 <switchuvm>:
{
80108270:	55                   	push   %ebp
80108271:	89 e5                	mov    %esp,%ebp
80108273:	57                   	push   %edi
80108274:	56                   	push   %esi
80108275:	53                   	push   %ebx
80108276:	83 ec 2c             	sub    $0x2c,%esp
80108279:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
8010827c:	85 db                	test   %ebx,%ebx
8010827e:	0f 84 c5 00 00 00    	je     80108349 <switchuvm+0xd9>
  if(p->kstack == 0)
80108284:	8b 7b 08             	mov    0x8(%ebx),%edi
80108287:	85 ff                	test   %edi,%edi
80108289:	0f 84 d2 00 00 00    	je     80108361 <switchuvm+0xf1>
  if(p->pgdir == 0)
8010828f:	8b 73 04             	mov    0x4(%ebx),%esi
80108292:	85 f6                	test   %esi,%esi
80108294:	0f 84 bb 00 00 00    	je     80108355 <switchuvm+0xe5>
  pushcli();
8010829a:	e8 d1 d8 ff ff       	call   80105b70 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010829f:	e8 5c b6 ff ff       	call   80103900 <mycpu>
801082a4:	89 c6                	mov    %eax,%esi
801082a6:	e8 55 b6 ff ff       	call   80103900 <mycpu>
801082ab:	89 c7                	mov    %eax,%edi
801082ad:	e8 4e b6 ff ff       	call   80103900 <mycpu>
801082b2:	83 c7 08             	add    $0x8,%edi
801082b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801082b8:	e8 43 b6 ff ff       	call   80103900 <mycpu>
801082bd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801082c0:	ba 67 00 00 00       	mov    $0x67,%edx
801082c5:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
801082cc:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
801082d3:	83 c1 08             	add    $0x8,%ecx
801082d6:	c1 e9 10             	shr    $0x10,%ecx
801082d9:	83 c0 08             	add    $0x8,%eax
801082dc:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
801082e2:	c1 e8 18             	shr    $0x18,%eax
801082e5:	b9 99 40 00 00       	mov    $0x4099,%ecx
801082ea:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
801082f1:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->gdt[SEG_TSS].s = 0;
801082f7:	e8 04 b6 ff ff       	call   80103900 <mycpu>
801082fc:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80108303:	e8 f8 b5 ff ff       	call   80103900 <mycpu>
80108308:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
8010830e:	8b 73 08             	mov    0x8(%ebx),%esi
80108311:	e8 ea b5 ff ff       	call   80103900 <mycpu>
80108316:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010831c:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010831f:	e8 dc b5 ff ff       	call   80103900 <mycpu>
80108324:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
8010832a:	b8 28 00 00 00       	mov    $0x28,%eax
8010832f:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80108332:	8b 43 04             	mov    0x4(%ebx),%eax
80108335:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010833a:	0f 22 d8             	mov    %eax,%cr3
}
8010833d:	83 c4 2c             	add    $0x2c,%esp
80108340:	5b                   	pop    %ebx
80108341:	5e                   	pop    %esi
80108342:	5f                   	pop    %edi
80108343:	5d                   	pop    %ebp
  popcli();
80108344:	e9 67 d8 ff ff       	jmp    80105bb0 <popcli>
    panic("switchuvm: no process");
80108349:	c7 04 24 be 92 10 80 	movl   $0x801092be,(%esp)
80108350:	e8 1b 80 ff ff       	call   80100370 <panic>
    panic("switchuvm: no pgdir");
80108355:	c7 04 24 e9 92 10 80 	movl   $0x801092e9,(%esp)
8010835c:	e8 0f 80 ff ff       	call   80100370 <panic>
    panic("switchuvm: no kstack");
80108361:	c7 04 24 d4 92 10 80 	movl   $0x801092d4,(%esp)
80108368:	e8 03 80 ff ff       	call   80100370 <panic>
8010836d:	8d 76 00             	lea    0x0(%esi),%esi

80108370 <inituvm>:
{
80108370:	55                   	push   %ebp
80108371:	89 e5                	mov    %esp,%ebp
80108373:	83 ec 38             	sub    $0x38,%esp
80108376:	89 75 f8             	mov    %esi,-0x8(%ebp)
80108379:	8b 75 10             	mov    0x10(%ebp),%esi
8010837c:	8b 45 08             	mov    0x8(%ebp),%eax
8010837f:	89 7d fc             	mov    %edi,-0x4(%ebp)
80108382:	8b 7d 0c             	mov    0xc(%ebp),%edi
80108385:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  if(sz >= PGSIZE)
80108388:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
8010838e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80108391:	77 59                	ja     801083ec <inituvm+0x7c>
  mem = kalloc();
80108393:	e8 18 a2 ff ff       	call   801025b0 <kalloc>
  memset(mem, 0, PGSIZE);
80108398:	31 d2                	xor    %edx,%edx
8010839a:	89 54 24 04          	mov    %edx,0x4(%esp)
  mem = kalloc();
8010839e:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801083a0:	b8 00 10 00 00       	mov    $0x1000,%eax
801083a5:	89 1c 24             	mov    %ebx,(%esp)
801083a8:	89 44 24 08          	mov    %eax,0x8(%esp)
801083ac:	e8 8f d9 ff ff       	call   80105d40 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801083b1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801083b7:	b9 06 00 00 00       	mov    $0x6,%ecx
801083bc:	89 04 24             	mov    %eax,(%esp)
801083bf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801083c2:	31 d2                	xor    %edx,%edx
801083c4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801083c8:	b9 00 10 00 00       	mov    $0x1000,%ecx
801083cd:	e8 be fc ff ff       	call   80108090 <mappages>
  memmove(mem, init, sz);
801083d2:	89 75 10             	mov    %esi,0x10(%ebp)
}
801083d5:	8b 75 f8             	mov    -0x8(%ebp),%esi
  memmove(mem, init, sz);
801083d8:	89 7d 0c             	mov    %edi,0xc(%ebp)
}
801083db:	8b 7d fc             	mov    -0x4(%ebp),%edi
  memmove(mem, init, sz);
801083de:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801083e1:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801083e4:	89 ec                	mov    %ebp,%esp
801083e6:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801083e7:	e9 14 da ff ff       	jmp    80105e00 <memmove>
    panic("inituvm: more than a page");
801083ec:	c7 04 24 fd 92 10 80 	movl   $0x801092fd,(%esp)
801083f3:	e8 78 7f ff ff       	call   80100370 <panic>
801083f8:	90                   	nop
801083f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108400 <loaduvm>:
{
80108400:	55                   	push   %ebp
80108401:	89 e5                	mov    %esp,%ebp
80108403:	57                   	push   %edi
80108404:	56                   	push   %esi
80108405:	53                   	push   %ebx
80108406:	83 ec 1c             	sub    $0x1c,%esp
  if((uint) addr % PGSIZE != 0)
80108409:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80108410:	0f 85 98 00 00 00    	jne    801084ae <loaduvm+0xae>
  for(i = 0; i < sz; i += PGSIZE){
80108416:	8b 75 18             	mov    0x18(%ebp),%esi
80108419:	31 db                	xor    %ebx,%ebx
8010841b:	85 f6                	test   %esi,%esi
8010841d:	75 1a                	jne    80108439 <loaduvm+0x39>
8010841f:	eb 77                	jmp    80108498 <loaduvm+0x98>
80108421:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108428:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010842e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80108434:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80108437:	76 5f                	jbe    80108498 <loaduvm+0x98>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80108439:	8b 55 0c             	mov    0xc(%ebp),%edx
8010843c:	31 c9                	xor    %ecx,%ecx
8010843e:	8b 45 08             	mov    0x8(%ebp),%eax
80108441:	01 da                	add    %ebx,%edx
80108443:	e8 b8 fb ff ff       	call   80108000 <walkpgdir>
80108448:	85 c0                	test   %eax,%eax
8010844a:	74 56                	je     801084a2 <loaduvm+0xa2>
    pa = PTE_ADDR(*pte);
8010844c:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
8010844e:	bf 00 10 00 00       	mov    $0x1000,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108453:	8b 4d 14             	mov    0x14(%ebp),%ecx
    pa = PTE_ADDR(*pte);
80108456:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
8010845b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80108461:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108464:	05 00 00 00 80       	add    $0x80000000,%eax
80108469:	89 44 24 04          	mov    %eax,0x4(%esp)
8010846d:	8b 45 10             	mov    0x10(%ebp),%eax
80108470:	01 d9                	add    %ebx,%ecx
80108472:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80108476:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010847a:	89 04 24             	mov    %eax,(%esp)
8010847d:	e8 4e 95 ff ff       	call   801019d0 <readi>
80108482:	39 f8                	cmp    %edi,%eax
80108484:	74 a2                	je     80108428 <loaduvm+0x28>
}
80108486:	83 c4 1c             	add    $0x1c,%esp
      return -1;
80108489:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010848e:	5b                   	pop    %ebx
8010848f:	5e                   	pop    %esi
80108490:	5f                   	pop    %edi
80108491:	5d                   	pop    %ebp
80108492:	c3                   	ret    
80108493:	90                   	nop
80108494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108498:	83 c4 1c             	add    $0x1c,%esp
  return 0;
8010849b:	31 c0                	xor    %eax,%eax
}
8010849d:	5b                   	pop    %ebx
8010849e:	5e                   	pop    %esi
8010849f:	5f                   	pop    %edi
801084a0:	5d                   	pop    %ebp
801084a1:	c3                   	ret    
      panic("loaduvm: address should exist");
801084a2:	c7 04 24 17 93 10 80 	movl   $0x80109317,(%esp)
801084a9:	e8 c2 7e ff ff       	call   80100370 <panic>
    panic("loaduvm: addr must be page aligned");
801084ae:	c7 04 24 b8 93 10 80 	movl   $0x801093b8,(%esp)
801084b5:	e8 b6 7e ff ff       	call   80100370 <panic>
801084ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801084c0 <allocuvm>:
{
801084c0:	55                   	push   %ebp
801084c1:	89 e5                	mov    %esp,%ebp
801084c3:	57                   	push   %edi
801084c4:	56                   	push   %esi
801084c5:	53                   	push   %ebx
801084c6:	83 ec 2c             	sub    $0x2c,%esp
  if(newsz >= KERNBASE)
801084c9:	8b 7d 10             	mov    0x10(%ebp),%edi
801084cc:	85 ff                	test   %edi,%edi
801084ce:	0f 88 91 00 00 00    	js     80108565 <allocuvm+0xa5>
  if(newsz < oldsz)
801084d4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801084d7:	0f 82 9b 00 00 00    	jb     80108578 <allocuvm+0xb8>
  a = PGROUNDUP(oldsz);
801084dd:	8b 45 0c             	mov    0xc(%ebp),%eax
801084e0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801084e6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
801084ec:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801084ef:	0f 86 86 00 00 00    	jbe    8010857b <allocuvm+0xbb>
801084f5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801084f8:	8b 7d 08             	mov    0x8(%ebp),%edi
801084fb:	eb 49                	jmp    80108546 <allocuvm+0x86>
801084fd:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80108500:	31 d2                	xor    %edx,%edx
80108502:	b8 00 10 00 00       	mov    $0x1000,%eax
80108507:	89 54 24 04          	mov    %edx,0x4(%esp)
8010850b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010850f:	89 34 24             	mov    %esi,(%esp)
80108512:	e8 29 d8 ff ff       	call   80105d40 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80108517:	b9 06 00 00 00       	mov    $0x6,%ecx
8010851c:	89 da                	mov    %ebx,%edx
8010851e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80108524:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80108528:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010852d:	89 04 24             	mov    %eax,(%esp)
80108530:	89 f8                	mov    %edi,%eax
80108532:	e8 59 fb ff ff       	call   80108090 <mappages>
80108537:	85 c0                	test   %eax,%eax
80108539:	78 4d                	js     80108588 <allocuvm+0xc8>
  for(; a < newsz; a += PGSIZE){
8010853b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80108541:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80108544:	76 7a                	jbe    801085c0 <allocuvm+0x100>
    mem = kalloc();
80108546:	e8 65 a0 ff ff       	call   801025b0 <kalloc>
    if(mem == 0){
8010854b:	85 c0                	test   %eax,%eax
    mem = kalloc();
8010854d:	89 c6                	mov    %eax,%esi
    if(mem == 0){
8010854f:	75 af                	jne    80108500 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80108551:	c7 04 24 35 93 10 80 	movl   $0x80109335,(%esp)
80108558:	e8 f3 80 ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
8010855d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108560:	39 45 10             	cmp    %eax,0x10(%ebp)
80108563:	77 6b                	ja     801085d0 <allocuvm+0x110>
}
80108565:	83 c4 2c             	add    $0x2c,%esp
    return 0;
80108568:	31 ff                	xor    %edi,%edi
}
8010856a:	5b                   	pop    %ebx
8010856b:	89 f8                	mov    %edi,%eax
8010856d:	5e                   	pop    %esi
8010856e:	5f                   	pop    %edi
8010856f:	5d                   	pop    %ebp
80108570:	c3                   	ret    
80108571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80108578:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
8010857b:	83 c4 2c             	add    $0x2c,%esp
8010857e:	89 f8                	mov    %edi,%eax
80108580:	5b                   	pop    %ebx
80108581:	5e                   	pop    %esi
80108582:	5f                   	pop    %edi
80108583:	5d                   	pop    %ebp
80108584:	c3                   	ret    
80108585:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80108588:	c7 04 24 4d 93 10 80 	movl   $0x8010934d,(%esp)
8010858f:	e8 bc 80 ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
80108594:	8b 45 0c             	mov    0xc(%ebp),%eax
80108597:	39 45 10             	cmp    %eax,0x10(%ebp)
8010859a:	76 0d                	jbe    801085a9 <allocuvm+0xe9>
8010859c:	89 c1                	mov    %eax,%ecx
8010859e:	8b 55 10             	mov    0x10(%ebp),%edx
801085a1:	8b 45 08             	mov    0x8(%ebp),%eax
801085a4:	e8 77 fb ff ff       	call   80108120 <deallocuvm.part.0>
      kfree(mem);
801085a9:	89 34 24             	mov    %esi,(%esp)
      return 0;
801085ac:	31 ff                	xor    %edi,%edi
      kfree(mem);
801085ae:	e8 2d 9e ff ff       	call   801023e0 <kfree>
}
801085b3:	83 c4 2c             	add    $0x2c,%esp
801085b6:	89 f8                	mov    %edi,%eax
801085b8:	5b                   	pop    %ebx
801085b9:	5e                   	pop    %esi
801085ba:	5f                   	pop    %edi
801085bb:	5d                   	pop    %ebp
801085bc:	c3                   	ret    
801085bd:	8d 76 00             	lea    0x0(%esi),%esi
801085c0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801085c3:	83 c4 2c             	add    $0x2c,%esp
801085c6:	5b                   	pop    %ebx
801085c7:	5e                   	pop    %esi
801085c8:	89 f8                	mov    %edi,%eax
801085ca:	5f                   	pop    %edi
801085cb:	5d                   	pop    %ebp
801085cc:	c3                   	ret    
801085cd:	8d 76 00             	lea    0x0(%esi),%esi
801085d0:	89 c1                	mov    %eax,%ecx
801085d2:	8b 55 10             	mov    0x10(%ebp),%edx
      return 0;
801085d5:	31 ff                	xor    %edi,%edi
801085d7:	8b 45 08             	mov    0x8(%ebp),%eax
801085da:	e8 41 fb ff ff       	call   80108120 <deallocuvm.part.0>
801085df:	eb 9a                	jmp    8010857b <allocuvm+0xbb>
801085e1:	eb 0d                	jmp    801085f0 <deallocuvm>
801085e3:	90                   	nop
801085e4:	90                   	nop
801085e5:	90                   	nop
801085e6:	90                   	nop
801085e7:	90                   	nop
801085e8:	90                   	nop
801085e9:	90                   	nop
801085ea:	90                   	nop
801085eb:	90                   	nop
801085ec:	90                   	nop
801085ed:	90                   	nop
801085ee:	90                   	nop
801085ef:	90                   	nop

801085f0 <deallocuvm>:
{
801085f0:	55                   	push   %ebp
801085f1:	89 e5                	mov    %esp,%ebp
801085f3:	8b 55 0c             	mov    0xc(%ebp),%edx
801085f6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801085f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801085fc:	39 d1                	cmp    %edx,%ecx
801085fe:	73 10                	jae    80108610 <deallocuvm+0x20>
}
80108600:	5d                   	pop    %ebp
80108601:	e9 1a fb ff ff       	jmp    80108120 <deallocuvm.part.0>
80108606:	8d 76 00             	lea    0x0(%esi),%esi
80108609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80108610:	89 d0                	mov    %edx,%eax
80108612:	5d                   	pop    %ebp
80108613:	c3                   	ret    
80108614:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010861a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80108620 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80108620:	55                   	push   %ebp
80108621:	89 e5                	mov    %esp,%ebp
80108623:	57                   	push   %edi
80108624:	56                   	push   %esi
80108625:	53                   	push   %ebx
80108626:	83 ec 1c             	sub    $0x1c,%esp
80108629:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010862c:	85 f6                	test   %esi,%esi
8010862e:	74 55                	je     80108685 <freevm+0x65>
80108630:	31 c9                	xor    %ecx,%ecx
80108632:	ba 00 00 00 80       	mov    $0x80000000,%edx
80108637:	89 f0                	mov    %esi,%eax
80108639:	89 f3                	mov    %esi,%ebx
8010863b:	e8 e0 fa ff ff       	call   80108120 <deallocuvm.part.0>
80108640:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80108646:	eb 0f                	jmp    80108657 <freevm+0x37>
80108648:	90                   	nop
80108649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108650:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80108653:	39 fb                	cmp    %edi,%ebx
80108655:	74 1f                	je     80108676 <freevm+0x56>
    if(pgdir[i] & PTE_P){
80108657:	8b 03                	mov    (%ebx),%eax
80108659:	a8 01                	test   $0x1,%al
8010865b:	74 f3                	je     80108650 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010865d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108662:	83 c3 04             	add    $0x4,%ebx
80108665:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010866a:	89 04 24             	mov    %eax,(%esp)
8010866d:	e8 6e 9d ff ff       	call   801023e0 <kfree>
  for(i = 0; i < NPDENTRIES; i++){
80108672:	39 fb                	cmp    %edi,%ebx
80108674:	75 e1                	jne    80108657 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80108676:	89 75 08             	mov    %esi,0x8(%ebp)
}
80108679:	83 c4 1c             	add    $0x1c,%esp
8010867c:	5b                   	pop    %ebx
8010867d:	5e                   	pop    %esi
8010867e:	5f                   	pop    %edi
8010867f:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80108680:	e9 5b 9d ff ff       	jmp    801023e0 <kfree>
    panic("freevm: no pgdir");
80108685:	c7 04 24 69 93 10 80 	movl   $0x80109369,(%esp)
8010868c:	e8 df 7c ff ff       	call   80100370 <panic>
80108691:	eb 0d                	jmp    801086a0 <setupkvm>
80108693:	90                   	nop
80108694:	90                   	nop
80108695:	90                   	nop
80108696:	90                   	nop
80108697:	90                   	nop
80108698:	90                   	nop
80108699:	90                   	nop
8010869a:	90                   	nop
8010869b:	90                   	nop
8010869c:	90                   	nop
8010869d:	90                   	nop
8010869e:	90                   	nop
8010869f:	90                   	nop

801086a0 <setupkvm>:
{
801086a0:	55                   	push   %ebp
801086a1:	89 e5                	mov    %esp,%ebp
801086a3:	56                   	push   %esi
801086a4:	53                   	push   %ebx
801086a5:	83 ec 10             	sub    $0x10,%esp
  if((pgdir = (pde_t*)kalloc()) == 0)
801086a8:	e8 03 9f ff ff       	call   801025b0 <kalloc>
801086ad:	85 c0                	test   %eax,%eax
801086af:	89 c6                	mov    %eax,%esi
801086b1:	74 46                	je     801086f9 <setupkvm+0x59>
  memset(pgdir, 0, PGSIZE);
801086b3:	b8 00 10 00 00       	mov    $0x1000,%eax
801086b8:	31 d2                	xor    %edx,%edx
801086ba:	89 44 24 08          	mov    %eax,0x8(%esp)
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801086be:	bb 20 c4 10 80       	mov    $0x8010c420,%ebx
  memset(pgdir, 0, PGSIZE);
801086c3:	89 54 24 04          	mov    %edx,0x4(%esp)
801086c7:	89 34 24             	mov    %esi,(%esp)
801086ca:	e8 71 d6 ff ff       	call   80105d40 <memset>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801086cf:	8b 53 0c             	mov    0xc(%ebx),%edx
                (uint)k->phys_start, k->perm) < 0) {
801086d2:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801086d5:	8b 4b 08             	mov    0x8(%ebx),%ecx
801086d8:	89 54 24 04          	mov    %edx,0x4(%esp)
801086dc:	8b 13                	mov    (%ebx),%edx
801086de:	89 04 24             	mov    %eax,(%esp)
801086e1:	29 c1                	sub    %eax,%ecx
801086e3:	89 f0                	mov    %esi,%eax
801086e5:	e8 a6 f9 ff ff       	call   80108090 <mappages>
801086ea:	85 c0                	test   %eax,%eax
801086ec:	78 1a                	js     80108708 <setupkvm+0x68>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801086ee:	83 c3 10             	add    $0x10,%ebx
801086f1:	81 fb 60 c4 10 80    	cmp    $0x8010c460,%ebx
801086f7:	75 d6                	jne    801086cf <setupkvm+0x2f>
}
801086f9:	83 c4 10             	add    $0x10,%esp
801086fc:	89 f0                	mov    %esi,%eax
801086fe:	5b                   	pop    %ebx
801086ff:	5e                   	pop    %esi
80108700:	5d                   	pop    %ebp
80108701:	c3                   	ret    
80108702:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      freevm(pgdir);
80108708:	89 34 24             	mov    %esi,(%esp)
      return 0;
8010870b:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
8010870d:	e8 0e ff ff ff       	call   80108620 <freevm>
}
80108712:	83 c4 10             	add    $0x10,%esp
80108715:	89 f0                	mov    %esi,%eax
80108717:	5b                   	pop    %ebx
80108718:	5e                   	pop    %esi
80108719:	5d                   	pop    %ebp
8010871a:	c3                   	ret    
8010871b:	90                   	nop
8010871c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80108720 <kvmalloc>:
{
80108720:	55                   	push   %ebp
80108721:	89 e5                	mov    %esp,%ebp
80108723:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80108726:	e8 75 ff ff ff       	call   801086a0 <setupkvm>
8010872b:	a3 24 80 11 80       	mov    %eax,0x80118024
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108730:	05 00 00 00 80       	add    $0x80000000,%eax
80108735:	0f 22 d8             	mov    %eax,%cr3
}
80108738:	c9                   	leave  
80108739:	c3                   	ret    
8010873a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108740 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108740:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108741:	31 c9                	xor    %ecx,%ecx
{
80108743:	89 e5                	mov    %esp,%ebp
80108745:	83 ec 18             	sub    $0x18,%esp
  pte = walkpgdir(pgdir, uva, 0);
80108748:	8b 55 0c             	mov    0xc(%ebp),%edx
8010874b:	8b 45 08             	mov    0x8(%ebp),%eax
8010874e:	e8 ad f8 ff ff       	call   80108000 <walkpgdir>
  if(pte == 0)
80108753:	85 c0                	test   %eax,%eax
80108755:	74 05                	je     8010875c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80108757:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010875a:	c9                   	leave  
8010875b:	c3                   	ret    
    panic("clearpteu");
8010875c:	c7 04 24 7a 93 10 80 	movl   $0x8010937a,(%esp)
80108763:	e8 08 7c ff ff       	call   80100370 <panic>
80108768:	90                   	nop
80108769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108770 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108770:	55                   	push   %ebp
80108771:	89 e5                	mov    %esp,%ebp
80108773:	57                   	push   %edi
80108774:	56                   	push   %esi
80108775:	53                   	push   %ebx
80108776:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80108779:	e8 22 ff ff ff       	call   801086a0 <setupkvm>
8010877e:	85 c0                	test   %eax,%eax
80108780:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108783:	0f 84 a3 00 00 00    	je     8010882c <copyuvm+0xbc>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108789:	8b 55 0c             	mov    0xc(%ebp),%edx
8010878c:	85 d2                	test   %edx,%edx
8010878e:	0f 84 98 00 00 00    	je     8010882c <copyuvm+0xbc>
80108794:	31 ff                	xor    %edi,%edi
80108796:	eb 50                	jmp    801087e8 <copyuvm+0x78>
80108798:	90                   	nop
80108799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801087a0:	b8 00 10 00 00       	mov    $0x1000,%eax
801087a5:	89 44 24 08          	mov    %eax,0x8(%esp)
801087a9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801087ac:	89 34 24             	mov    %esi,(%esp)
801087af:	05 00 00 00 80       	add    $0x80000000,%eax
801087b4:	89 44 24 04          	mov    %eax,0x4(%esp)
801087b8:	e8 43 d6 ff ff       	call   80105e00 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801087bd:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801087c3:	b9 00 10 00 00       	mov    $0x1000,%ecx
801087c8:	89 04 24             	mov    %eax,(%esp)
801087cb:	8b 45 e0             	mov    -0x20(%ebp),%eax
801087ce:	89 fa                	mov    %edi,%edx
801087d0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801087d4:	e8 b7 f8 ff ff       	call   80108090 <mappages>
801087d9:	85 c0                	test   %eax,%eax
801087db:	78 63                	js     80108840 <copyuvm+0xd0>
  for(i = 0; i < sz; i += PGSIZE){
801087dd:	81 c7 00 10 00 00    	add    $0x1000,%edi
801087e3:	39 7d 0c             	cmp    %edi,0xc(%ebp)
801087e6:	76 44                	jbe    8010882c <copyuvm+0xbc>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801087e8:	8b 45 08             	mov    0x8(%ebp),%eax
801087eb:	31 c9                	xor    %ecx,%ecx
801087ed:	89 fa                	mov    %edi,%edx
801087ef:	e8 0c f8 ff ff       	call   80108000 <walkpgdir>
801087f4:	85 c0                	test   %eax,%eax
801087f6:	74 5e                	je     80108856 <copyuvm+0xe6>
    if(!(*pte & PTE_P))
801087f8:	8b 18                	mov    (%eax),%ebx
801087fa:	f6 c3 01             	test   $0x1,%bl
801087fd:	74 4b                	je     8010884a <copyuvm+0xda>
    pa = PTE_ADDR(*pte);
801087ff:	89 d8                	mov    %ebx,%eax
    flags = PTE_FLAGS(*pte);
80108801:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
80108807:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010880c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
8010880f:	e8 9c 9d ff ff       	call   801025b0 <kalloc>
80108814:	85 c0                	test   %eax,%eax
80108816:	89 c6                	mov    %eax,%esi
80108818:	75 86                	jne    801087a0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
8010881a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010881d:	89 04 24             	mov    %eax,(%esp)
80108820:	e8 fb fd ff ff       	call   80108620 <freevm>
  return 0;
80108825:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
8010882c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010882f:	83 c4 2c             	add    $0x2c,%esp
80108832:	5b                   	pop    %ebx
80108833:	5e                   	pop    %esi
80108834:	5f                   	pop    %edi
80108835:	5d                   	pop    %ebp
80108836:	c3                   	ret    
80108837:	89 f6                	mov    %esi,%esi
80108839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      kfree(mem);
80108840:	89 34 24             	mov    %esi,(%esp)
80108843:	e8 98 9b ff ff       	call   801023e0 <kfree>
      goto bad;
80108848:	eb d0                	jmp    8010881a <copyuvm+0xaa>
      panic("copyuvm: page not present");
8010884a:	c7 04 24 9e 93 10 80 	movl   $0x8010939e,(%esp)
80108851:	e8 1a 7b ff ff       	call   80100370 <panic>
      panic("copyuvm: pte should exist");
80108856:	c7 04 24 84 93 10 80 	movl   $0x80109384,(%esp)
8010885d:	e8 0e 7b ff ff       	call   80100370 <panic>
80108862:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108870 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108870:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108871:	31 c9                	xor    %ecx,%ecx
{
80108873:	89 e5                	mov    %esp,%ebp
80108875:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80108878:	8b 55 0c             	mov    0xc(%ebp),%edx
8010887b:	8b 45 08             	mov    0x8(%ebp),%eax
8010887e:	e8 7d f7 ff ff       	call   80108000 <walkpgdir>
  if((*pte & PTE_P) == 0)
80108883:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80108885:	89 c2                	mov    %eax,%edx
80108887:	83 e2 05             	and    $0x5,%edx
8010888a:	83 fa 05             	cmp    $0x5,%edx
8010888d:	75 11                	jne    801088a0 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
8010888f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108894:	05 00 00 00 80       	add    $0x80000000,%eax
}
80108899:	c9                   	leave  
8010889a:	c3                   	ret    
8010889b:	90                   	nop
8010889c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
801088a0:	31 c0                	xor    %eax,%eax
}
801088a2:	c9                   	leave  
801088a3:	c3                   	ret    
801088a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801088aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801088b0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801088b0:	55                   	push   %ebp
801088b1:	89 e5                	mov    %esp,%ebp
801088b3:	57                   	push   %edi
801088b4:	56                   	push   %esi
801088b5:	53                   	push   %ebx
801088b6:	83 ec 2c             	sub    $0x2c,%esp
801088b9:	8b 75 14             	mov    0x14(%ebp),%esi
801088bc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801088bf:	85 f6                	test   %esi,%esi
801088c1:	74 75                	je     80108938 <copyout+0x88>
801088c3:	89 da                	mov    %ebx,%edx
801088c5:	eb 3f                	jmp    80108906 <copyout+0x56>
801088c7:	89 f6                	mov    %esi,%esi
801088c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801088d0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801088d3:	89 df                	mov    %ebx,%edi
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801088d5:	8b 4d 10             	mov    0x10(%ebp),%ecx
    n = PGSIZE - (va - va0);
801088d8:	29 d7                	sub    %edx,%edi
801088da:	81 c7 00 10 00 00    	add    $0x1000,%edi
801088e0:	39 f7                	cmp    %esi,%edi
801088e2:	0f 47 fe             	cmova  %esi,%edi
    memmove(pa0 + (va - va0), buf, n);
801088e5:	29 da                	sub    %ebx,%edx
801088e7:	01 c2                	add    %eax,%edx
801088e9:	89 14 24             	mov    %edx,(%esp)
801088ec:	89 7c 24 08          	mov    %edi,0x8(%esp)
801088f0:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801088f4:	e8 07 d5 ff ff       	call   80105e00 <memmove>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
801088f9:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    buf += n;
801088ff:	01 7d 10             	add    %edi,0x10(%ebp)
  while(len > 0){
80108902:	29 fe                	sub    %edi,%esi
80108904:	74 32                	je     80108938 <copyout+0x88>
    pa0 = uva2ka(pgdir, (char*)va0);
80108906:	8b 45 08             	mov    0x8(%ebp),%eax
    va0 = (uint)PGROUNDDOWN(va);
80108909:	89 d3                	mov    %edx,%ebx
8010890b:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    pa0 = uva2ka(pgdir, (char*)va0);
80108911:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    va0 = (uint)PGROUNDDOWN(va);
80108915:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80108918:	89 04 24             	mov    %eax,(%esp)
8010891b:	e8 50 ff ff ff       	call   80108870 <uva2ka>
    if(pa0 == 0)
80108920:	85 c0                	test   %eax,%eax
80108922:	75 ac                	jne    801088d0 <copyout+0x20>
  }
  return 0;
}
80108924:	83 c4 2c             	add    $0x2c,%esp
      return -1;
80108927:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010892c:	5b                   	pop    %ebx
8010892d:	5e                   	pop    %esi
8010892e:	5f                   	pop    %edi
8010892f:	5d                   	pop    %ebp
80108930:	c3                   	ret    
80108931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108938:	83 c4 2c             	add    $0x2c,%esp
  return 0;
8010893b:	31 c0                	xor    %eax,%eax
}
8010893d:	5b                   	pop    %ebx
8010893e:	5e                   	pop    %esi
8010893f:	5f                   	pop    %edi
80108940:	5d                   	pop    %ebp
80108941:	c3                   	ret    
