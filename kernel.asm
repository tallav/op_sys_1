
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
80100041:	ba e0 88 10 80       	mov    $0x801088e0,%edx
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
8010005c:	e8 2f 5a 00 00       	call   80105a90 <initlock>
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
80100082:	b8 e7 88 10 80       	mov    $0x801088e7,%eax
    b->next = bcache.head.next;
80100087:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008a:	c7 43 50 3c 1d 11 80 	movl   $0x80111d3c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100091:	89 44 24 04          	mov    %eax,0x4(%esp)
80100095:	8d 43 0c             	lea    0xc(%ebx),%eax
80100098:	89 04 24             	mov    %eax,(%esp)
8010009b:	e8 c0 58 00 00       	call   80105960 <initsleeplock>
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
801000e6:	e8 f5 5a 00 00       	call   80105be0 <acquire>
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
80100161:	e8 1a 5b 00 00       	call   80105c80 <release>
      acquiresleep(&b->lock);
80100166:	8d 43 0c             	lea    0xc(%ebx),%eax
80100169:	89 04 24             	mov    %eax,(%esp)
8010016c:	e8 2f 58 00 00       	call   801059a0 <acquiresleep>
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
80100188:	c7 04 24 ee 88 10 80 	movl   $0x801088ee,(%esp)
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
801001b0:	e8 8b 58 00 00       	call   80105a40 <holdingsleep>
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
801001c9:	c7 04 24 ff 88 10 80 	movl   $0x801088ff,(%esp)
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
801001f1:	e8 4a 58 00 00       	call   80105a40 <holdingsleep>
801001f6:	85 c0                	test   %eax,%eax
801001f8:	74 5a                	je     80100254 <brelse+0x74>
    panic("brelse");

  releasesleep(&b->lock);
801001fa:	89 34 24             	mov    %esi,(%esp)
801001fd:	e8 fe 57 00 00       	call   80105a00 <releasesleep>

  acquire(&bcache.lock);
80100202:	c7 04 24 40 d6 10 80 	movl   $0x8010d640,(%esp)
80100209:	e8 d2 59 00 00       	call   80105be0 <acquire>
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
8010024f:	e9 2c 5a 00 00       	jmp    80105c80 <release>
    panic("brelse");
80100254:	c7 04 24 06 89 10 80 	movl   $0x80108906,(%esp)
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
8010027e:	e8 5d 59 00 00       	call   80105be0 <acquire>
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
801002b8:	e8 e3 41 00 00       	call   801044a0 <sleep>
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
801002de:	e8 9d 59 00 00       	call   80105c80 <release>
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
8010033a:	e8 41 59 00 00       	call   80105c80 <release>
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
8010038c:	c7 04 24 0d 89 10 80 	movl   $0x8010890d,(%esp)
80100393:	89 44 24 04          	mov    %eax,0x4(%esp)
80100397:	e8 b4 02 00 00       	call   80100650 <cprintf>
  cprintf(s);
8010039c:	8b 45 08             	mov    0x8(%ebp),%eax
8010039f:	89 04 24             	mov    %eax,(%esp)
801003a2:	e8 a9 02 00 00       	call   80100650 <cprintf>
  cprintf("\n");
801003a7:	c7 04 24 cd 8f 10 80 	movl   $0x80108fcd,(%esp)
801003ae:	e8 9d 02 00 00       	call   80100650 <cprintf>
  getcallerpcs(&s, pcs);
801003b3:	8d 45 08             	lea    0x8(%ebp),%eax
801003b6:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801003ba:	89 04 24             	mov    %eax,(%esp)
801003bd:	e8 ee 56 00 00       	call   80105ab0 <getcallerpcs>
801003c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    cprintf(" %p", pcs[i]);
801003d0:	8b 03                	mov    (%ebx),%eax
801003d2:	83 c3 04             	add    $0x4,%ebx
801003d5:	c7 04 24 21 89 10 80 	movl   $0x80108921,(%esp)
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
80100429:	e8 a2 70 00 00       	call   801074d0 <uartputc>
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
801004cc:	e8 ff 6f 00 00       	call   801074d0 <uartputc>
801004d1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004d8:	e8 f3 6f 00 00       	call   801074d0 <uartputc>
801004dd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004e4:	e8 e7 6f 00 00       	call   801074d0 <uartputc>
801004e9:	e9 40 ff ff ff       	jmp    8010042e <consputc+0x2e>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004ee:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
801004f5:	00 
801004f6:	c7 44 24 04 a0 80 0b 	movl   $0x800b80a0,0x4(%esp)
801004fd:	80 
801004fe:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
80100505:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80100508:	e8 83 58 00 00       	call   80105d90 <memmove>
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
80100536:	e8 95 57 00 00       	call   80105cd0 <memset>
8010053b:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010053e:	e9 4c ff ff ff       	jmp    8010048f <consputc+0x8f>
    panic("pos under/overflow");
80100543:	c7 04 24 25 89 10 80 	movl   $0x80108925,(%esp)
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
801005a1:	0f b6 92 50 89 10 80 	movzbl -0x7fef76b0(%edx),%edx
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
8010060e:	e8 cd 55 00 00       	call   80105be0 <acquire>
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
80100634:	e8 47 56 00 00       	call   80105c80 <release>
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
8010070e:	e8 6d 55 00 00       	call   80105c80 <release>
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
80100774:	bf 38 89 10 80       	mov    $0x80108938,%edi
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
801007b7:	e8 24 54 00 00       	call   80105be0 <acquire>
801007bc:	e9 a8 fe ff ff       	jmp    80100669 <cprintf+0x19>
    panic("null fmt");
801007c1:	c7 04 24 3f 89 10 80 	movl   $0x8010893f,(%esp)
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
801007e4:	e8 f7 53 00 00       	call   80105be0 <acquire>
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
80100847:	e8 34 54 00 00       	call   80105c80 <release>
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
801008d9:	e8 c2 3d 00 00       	call   801046a0 <wakeup>
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
8010094e:	e9 5d 40 00 00       	jmp    801049b0 <procdump>
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
80100981:	b8 48 89 10 80       	mov    $0x80108948,%eax
{
80100986:	89 e5                	mov    %esp,%ebp
80100988:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
8010098b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010098f:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
80100996:	e8 f5 50 00 00       	call   80105a90 <initlock>

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
80100a5c:	e8 cf 7b 00 00       	call   80108630 <setupkvm>
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
80100ac8:	e8 83 79 00 00       	call   80108450 <allocuvm>
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
80100b05:	e8 86 78 00 00       	call   80108390 <loaduvm>
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
80100b58:	e8 53 7a 00 00       	call   801085b0 <freevm>
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
80100b92:	e8 b9 78 00 00       	call   80108450 <allocuvm>
80100b97:	85 c0                	test   %eax,%eax
80100b99:	89 c6                	mov    %eax,%esi
80100b9b:	75 33                	jne    80100bd0 <exec+0x200>
    freevm(pgdir);
80100b9d:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ba3:	89 04 24             	mov    %eax,(%esp)
80100ba6:	e8 05 7a 00 00       	call   801085b0 <freevm>
  return -1;
80100bab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bb0:	e9 8c fe ff ff       	jmp    80100a41 <exec+0x71>
    end_op();
80100bb5:	e8 46 21 00 00       	call   80102d00 <end_op>
    cprintf("exec: fail\n");
80100bba:	c7 04 24 61 89 10 80 	movl   $0x80108961,(%esp)
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
80100be7:	e8 e4 7a 00 00       	call   801086d0 <clearpteu>
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
80100c18:	e8 d3 52 00 00       	call   80105ef0 <strlen>
80100c1d:	f7 d0                	not    %eax
80100c1f:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c21:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c24:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c27:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c2a:	89 04 24             	mov    %eax,(%esp)
80100c2d:	e8 be 52 00 00       	call   80105ef0 <strlen>
80100c32:	40                   	inc    %eax
80100c33:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c37:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c3a:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c3d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100c41:	89 34 24             	mov    %esi,(%esp)
80100c44:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c48:	e8 f3 7b 00 00       	call   80108840 <copyout>
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
80100cb8:	e8 83 7b 00 00       	call   80108840 <copyout>
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
80100d01:	e8 aa 51 00 00       	call   80105eb0 <safestrcpy>
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
80100d2b:	e8 d0 74 00 00       	call   80108200 <switchuvm>
  freevm(oldpgdir);
80100d30:	89 3c 24             	mov    %edi,(%esp)
80100d33:	e8 78 78 00 00       	call   801085b0 <freevm>
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
80100d51:	b8 6d 89 10 80       	mov    $0x8010896d,%eax
{
80100d56:	89 e5                	mov    %esp,%ebp
80100d58:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100d5b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100d5f:	c7 04 24 40 20 11 80 	movl   $0x80112040,(%esp)
80100d66:	e8 25 4d 00 00       	call   80105a90 <initlock>
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
80100d83:	e8 58 4e 00 00       	call   80105be0 <acquire>
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
80100db0:	e8 cb 4e 00 00       	call   80105c80 <release>
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
80100dc9:	e8 b2 4e 00 00       	call   80105c80 <release>
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
80100df1:	e8 ea 4d 00 00       	call   80105be0 <acquire>
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
80100e08:	e8 73 4e 00 00       	call   80105c80 <release>
  return f;
}
80100e0d:	83 c4 14             	add    $0x14,%esp
80100e10:	89 d8                	mov    %ebx,%eax
80100e12:	5b                   	pop    %ebx
80100e13:	5d                   	pop    %ebp
80100e14:	c3                   	ret    
    panic("filedup");
80100e15:	c7 04 24 74 89 10 80 	movl   $0x80108974,(%esp)
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
80100e49:	e8 92 4d 00 00       	call   80105be0 <acquire>
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
80100e74:	e9 07 4e 00 00       	jmp    80105c80 <release>
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
80100e9f:	e8 dc 4d 00 00       	call   80105c80 <release>
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
80100ef9:	c7 04 24 7c 89 10 80 	movl   $0x8010897c,(%esp)
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
80100ff7:	c7 04 24 86 89 10 80 	movl   $0x80108986,(%esp)
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
80101112:	c7 04 24 8f 89 10 80 	movl   $0x8010898f,(%esp)
80101119:	e8 52 f2 ff ff       	call   80100370 <panic>
  panic("filewrite");
8010111e:	c7 04 24 95 89 10 80 	movl   $0x80108995,(%esp)
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
801011c8:	c7 04 24 9f 89 10 80 	movl   $0x8010899f,(%esp)
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
80101218:	e8 b3 4a 00 00       	call   80105cd0 <memset>
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
8010125c:	e8 7f 49 00 00       	call   80105be0 <acquire>
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
801012be:	e8 bd 49 00 00       	call   80105c80 <release>

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
801012e2:	e8 99 49 00 00       	call   80105c80 <release>
}
801012e7:	83 c4 2c             	add    $0x2c,%esp
801012ea:	89 f0                	mov    %esi,%eax
801012ec:	5b                   	pop    %ebx
801012ed:	5e                   	pop    %esi
801012ee:	5f                   	pop    %edi
801012ef:	5d                   	pop    %ebp
801012f0:	c3                   	ret    
    panic("iget: no inodes");
801012f1:	c7 04 24 b5 89 10 80 	movl   $0x801089b5,(%esp)
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
801013c1:	c7 04 24 c5 89 10 80 	movl   $0x801089c5,(%esp)
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
80101408:	e8 83 49 00 00       	call   80105d90 <memmove>
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
80101497:	c7 04 24 d8 89 10 80 	movl   $0x801089d8,(%esp)
8010149e:	e8 cd ee ff ff       	call   80100370 <panic>
801014a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801014a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801014b0 <iinit>:
{
801014b0:	55                   	push   %ebp
  initlock(&icache.lock, "icache");
801014b1:	b9 eb 89 10 80       	mov    $0x801089eb,%ecx
{
801014b6:	89 e5                	mov    %esp,%ebp
801014b8:	53                   	push   %ebx
801014b9:	bb a0 2a 11 80       	mov    $0x80112aa0,%ebx
801014be:	83 ec 24             	sub    $0x24,%esp
  initlock(&icache.lock, "icache");
801014c1:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801014c5:	c7 04 24 60 2a 11 80 	movl   $0x80112a60,(%esp)
801014cc:	e8 bf 45 00 00       	call   80105a90 <initlock>
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
801014e0:	ba f2 89 10 80       	mov    $0x801089f2,%edx
801014e5:	89 1c 24             	mov    %ebx,(%esp)
801014e8:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014ee:	89 54 24 04          	mov    %edx,0x4(%esp)
801014f2:	e8 69 44 00 00       	call   80105960 <initsleeplock>
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
80101518:	c7 04 24 58 8a 10 80 	movl   $0x80108a58,(%esp)
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
801015f3:	e8 d8 46 00 00       	call   80105cd0 <memset>
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
80101621:	c7 04 24 f8 89 10 80 	movl   $0x801089f8,(%esp)
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
801016a2:	e8 e9 46 00 00       	call   80105d90 <memmove>
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
801016d1:	e8 0a 45 00 00       	call   80105be0 <acquire>
  ip->ref++;
801016d6:	ff 43 08             	incl   0x8(%ebx)
  release(&icache.lock);
801016d9:	c7 04 24 60 2a 11 80 	movl   $0x80112a60,(%esp)
801016e0:	e8 9b 45 00 00       	call   80105c80 <release>
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
80101714:	e8 87 42 00 00       	call   801059a0 <acquiresleep>
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
80101796:	e8 f5 45 00 00       	call   80105d90 <memmove>
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
801017b5:	c7 04 24 10 8a 10 80 	movl   $0x80108a10,(%esp)
801017bc:	e8 af eb ff ff       	call   80100370 <panic>
    panic("ilock");
801017c1:	c7 04 24 0a 8a 10 80 	movl   $0x80108a0a,(%esp)
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
801017e9:	e8 52 42 00 00       	call   80105a40 <holdingsleep>
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
80101805:	e9 f6 41 00 00       	jmp    80105a00 <releasesleep>
    panic("iunlock");
8010180a:	c7 04 24 1f 8a 10 80 	movl   $0x80108a1f,(%esp)
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
80101838:	e8 63 41 00 00       	call   801059a0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
8010183d:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101840:	85 d2                	test   %edx,%edx
80101842:	74 07                	je     8010184b <iput+0x2b>
80101844:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101849:	74 35                	je     80101880 <iput+0x60>
  releasesleep(&ip->lock);
8010184b:	89 3c 24             	mov    %edi,(%esp)
8010184e:	e8 ad 41 00 00       	call   80105a00 <releasesleep>
  acquire(&icache.lock);
80101853:	c7 04 24 60 2a 11 80 	movl   $0x80112a60,(%esp)
8010185a:	e8 81 43 00 00       	call   80105be0 <acquire>
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
80101875:	e9 06 44 00 00       	jmp    80105c80 <release>
8010187a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101880:	c7 04 24 60 2a 11 80 	movl   $0x80112a60,(%esp)
80101887:	e8 54 43 00 00       	call   80105be0 <acquire>
    int r = ip->ref;
8010188c:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
8010188f:	c7 04 24 60 2a 11 80 	movl   $0x80112a60,(%esp)
80101896:	e8 e5 43 00 00       	call   80105c80 <release>
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
80101a83:	e8 08 43 00 00       	call   80105d90 <memmove>
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
80101baf:	e8 dc 41 00 00       	call   80105d90 <memmove>
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
80101c5c:	e8 8f 41 00 00       	call   80105df0 <strncmp>
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
80101cdb:	e8 10 41 00 00       	call   80105df0 <strncmp>
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
80101d1f:	c7 04 24 39 8a 10 80 	movl   $0x80108a39,(%esp)
80101d26:	e8 45 e6 ff ff       	call   80100370 <panic>
    panic("dirlookup not DIR");
80101d2b:	c7 04 24 27 8a 10 80 	movl   $0x80108a27,(%esp)
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
80101d68:	e8 73 3e 00 00       	call   80105be0 <acquire>
  ip->ref++;
80101d6d:	ff 46 08             	incl   0x8(%esi)
  release(&icache.lock);
80101d70:	c7 04 24 60 2a 11 80 	movl   $0x80112a60,(%esp)
80101d77:	e8 04 3f 00 00       	call   80105c80 <release>
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
80101ddc:	e8 af 3f 00 00       	call   80105d90 <memmove>
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
80101e65:	e8 26 3f 00 00       	call   80105d90 <memmove>
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
80101f73:	e8 d8 3e 00 00       	call   80105e50 <strncpy>
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
80101fb6:	c7 04 24 48 8a 10 80 	movl   $0x80108a48,(%esp)
80101fbd:	e8 ae e3 ff ff       	call   80100370 <panic>
    panic("dirlink");
80101fc2:	c7 04 24 ce 90 10 80 	movl   $0x801090ce,(%esp)
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
801020bc:	c7 04 24 b4 8a 10 80 	movl   $0x80108ab4,(%esp)
801020c3:	e8 a8 e2 ff ff       	call   80100370 <panic>
    panic("idestart");
801020c8:	c7 04 24 ab 8a 10 80 	movl   $0x80108aab,(%esp)
801020cf:	e8 9c e2 ff ff       	call   80100370 <panic>
801020d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801020da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801020e0 <ideinit>:
{
801020e0:	55                   	push   %ebp
  initlock(&idelock, "ide");
801020e1:	ba c6 8a 10 80       	mov    $0x80108ac6,%edx
{
801020e6:	89 e5                	mov    %esp,%ebp
801020e8:	83 ec 18             	sub    $0x18,%esp
  initlock(&idelock, "ide");
801020eb:	89 54 24 04          	mov    %edx,0x4(%esp)
801020ef:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
801020f6:	e8 95 39 00 00       	call   80105a90 <initlock>
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
80102176:	e8 65 3a 00 00       	call   80105be0 <acquire>

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
801021ce:	e8 cd 24 00 00       	call   801046a0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801021d3:	a1 64 c5 10 80       	mov    0x8010c564,%eax
801021d8:	85 c0                	test   %eax,%eax
801021da:	74 05                	je     801021e1 <ideintr+0x81>
    idestart(idequeue);
801021dc:	e8 2f fe ff ff       	call   80102010 <idestart>
    release(&idelock);
801021e1:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
801021e8:	e8 93 3a 00 00       	call   80105c80 <release>

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
80102210:	e8 2b 38 00 00       	call   80105a40 <holdingsleep>
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
80102247:	e8 94 39 00 00       	call   80105be0 <acquire>

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
8010228c:	e8 0f 22 00 00       	call   801044a0 <sleep>
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
801022a7:	e9 d4 39 00 00       	jmp    80105c80 <release>
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
801022c7:	c7 04 24 e0 8a 10 80 	movl   $0x80108ae0,(%esp)
801022ce:	e8 9d e0 ff ff       	call   80100370 <panic>
    panic("iderw: buf not locked");
801022d3:	c7 04 24 ca 8a 10 80 	movl   $0x80108aca,(%esp)
801022da:	e8 91 e0 ff ff       	call   80100370 <panic>
    panic("iderw: ide disk 1 not present");
801022df:	c7 04 24 f5 8a 10 80 	movl   $0x80108af5,(%esp)
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
80102338:	c7 04 24 14 8b 10 80 	movl   $0x80108b14,(%esp)
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
80102420:	e8 ab 38 00 00       	call   80105cd0 <memset>

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
8010245c:	e9 1f 38 00 00       	jmp    80105c80 <release>
80102461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&kmem.lock);
80102468:	c7 04 24 c0 46 11 80 	movl   $0x801146c0,(%esp)
8010246f:	e8 6c 37 00 00       	call   80105be0 <acquire>
80102474:	eb b8                	jmp    8010242e <kfree+0x4e>
    panic("kfree");
80102476:	c7 04 24 46 8b 10 80 	movl   $0x80108b46,(%esp)
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
801024e1:	b8 4c 8b 10 80       	mov    $0x80108b4c,%eax
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
801024fb:	e8 90 35 00 00       	call   80105a90 <initlock>
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
801025e5:	e8 f6 35 00 00       	call   80105be0 <acquire>
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
8010260f:	e8 6c 36 00 00       	call   80105c80 <release>
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
80102664:	0f b6 8a 80 8c 10 80 	movzbl -0x7fef7380(%edx),%ecx
  shift ^= togglecode[data];
8010266b:	0f b6 82 80 8b 10 80 	movzbl -0x7fef7480(%edx),%eax
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
8010267e:	8b 04 85 60 8b 10 80 	mov    -0x7fef74a0(,%eax,4),%eax
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
801026b9:	0f b6 82 80 8c 10 80 	movzbl -0x7fef7380(%edx),%eax
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
80102a20:	e8 0b 33 00 00       	call   80105d30 <memcmp>
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
80102b3c:	e8 4f 32 00 00       	call   80105d90 <memmove>
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
80102bf1:	ba 80 8d 10 80       	mov    $0x80108d80,%edx
{
80102bf6:	89 e5                	mov    %esp,%ebp
80102bf8:	53                   	push   %ebx
80102bf9:	83 ec 34             	sub    $0x34,%esp
80102bfc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102bff:	89 54 24 04          	mov    %edx,0x4(%esp)
80102c03:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
80102c0a:	e8 81 2e 00 00       	call   80105a90 <initlock>
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
80102c9d:	e8 3e 2f 00 00       	call   80105be0 <acquire>
80102ca2:	eb 19                	jmp    80102cbd <begin_op+0x2d>
80102ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102ca8:	b8 00 47 11 80       	mov    $0x80114700,%eax
80102cad:	89 44 24 04          	mov    %eax,0x4(%esp)
80102cb1:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
80102cb8:	e8 e3 17 00 00       	call   801044a0 <sleep>
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
80102cea:	e8 91 2f 00 00       	call   80105c80 <release>
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
80102d10:	e8 cb 2e 00 00       	call   80105be0 <acquire>
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
80102d4a:	e8 31 2f 00 00       	call   80105c80 <release>
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
80102da9:	e8 e2 2f 00 00       	call   80105d90 <memmove>
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
80102dec:	e8 ef 2d 00 00       	call   80105be0 <acquire>
    log.committing = 0;
80102df1:	31 c0                	xor    %eax,%eax
80102df3:	a3 40 47 11 80       	mov    %eax,0x80114740
    wakeup(&log);
80102df8:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
80102dff:	e8 9c 18 00 00       	call   801046a0 <wakeup>
    release(&log.lock);
80102e04:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
80102e0b:	e8 70 2e 00 00       	call   80105c80 <release>
}
80102e10:	83 c4 1c             	add    $0x1c,%esp
80102e13:	5b                   	pop    %ebx
80102e14:	5e                   	pop    %esi
80102e15:	5f                   	pop    %edi
80102e16:	5d                   	pop    %ebp
80102e17:	c3                   	ret    
    panic("log.committing");
80102e18:	c7 04 24 84 8d 10 80 	movl   $0x80108d84,(%esp)
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
80102e6b:	e8 70 2d 00 00       	call   80105be0 <acquire>
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
80102eba:	e9 c1 2d 00 00       	jmp    80105c80 <release>
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
80102ede:	c7 04 24 93 8d 10 80 	movl   $0x80108d93,(%esp)
80102ee5:	e8 86 d4 ff ff       	call   80100370 <panic>
    panic("log_write outside of trans");
80102eea:	c7 04 24 a9 8d 10 80 	movl   $0x80108da9,(%esp)
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
80102f07:	e8 d4 52 00 00       	call   801081e0 <switchkvm>
  seginit();
80102f0c:	e8 3f 52 00 00       	call   80108150 <seginit>
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
80102f22:	c7 04 24 c4 8d 10 80 	movl   $0x80108dc4,(%esp)
80102f29:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f2d:	e8 1e d7 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80102f32:	e8 59 41 00 00       	call   80107090 <idtinit>
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
80102f6a:	c7 04 24 14 8e 10 80 	movl   $0x80108e14,(%esp)
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
80102f9f:	e8 0c 57 00 00       	call   801086b0 <kvmalloc>
  mpinit();        // detect other processors
80102fa4:	e8 17 02 00 00       	call   801031c0 <mpinit>
  lapicinit();     // interrupt controller
80102fa9:	e8 82 f7 ff ff       	call   80102730 <lapicinit>
80102fae:	66 90                	xchg   %ax,%ax
  seginit();       // segment descriptors
80102fb0:	e8 9b 51 00 00       	call   80108150 <seginit>
  picinit();       // disable pic
80102fb5:	e8 e6 03 00 00       	call   801033a0 <picinit>
  ioapicinit();    // another interrupt controller
80102fba:	e8 31 f3 ff ff       	call   801022f0 <ioapicinit>
80102fbf:	90                   	nop
  consoleinit();   // console hardware
80102fc0:	e8 bb d9 ff ff       	call   80100980 <consoleinit>
  uartinit();      // serial port
80102fc5:	e8 56 44 00 00       	call   80107420 <uartinit>
  pinit();         // process table
80102fca:	e8 11 09 00 00       	call   801038e0 <pinit>
80102fcf:	90                   	nop
  tvinit();        // trap vectors
80102fd0:	e8 3b 40 00 00       	call   80107010 <tvinit>
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
80102ffe:	e8 8d 2d 00 00       	call   80105d90 <memmove>

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
801030bc:	e8 3f 1e 00 00       	call   80104f00 <initSchedDS>
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
80103118:	c7 04 24 0a 8e 10 80 	movl   $0x80108e0a,(%esp)
8010311f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103123:	e8 28 d5 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80103128:	e8 63 3f 00 00       	call   80107090 <idtinit>
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
80103166:	ba 28 8e 10 80       	mov    $0x80108e28,%edx
8010316b:	b8 04 00 00 00       	mov    $0x4,%eax
80103170:	89 54 24 04          	mov    %edx,0x4(%esp)
80103174:	89 44 24 08          	mov    %eax,0x8(%esp)
80103178:	89 34 24             	mov    %esi,(%esp)
8010317b:	e8 b0 2b 00 00       	call   80105d30 <memcmp>
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
80103224:	ba 45 8e 10 80       	mov    $0x80108e45,%edx
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103229:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
8010322f:	89 44 24 08          	mov    %eax,0x8(%esp)
80103233:	89 54 24 04          	mov    %edx,0x4(%esp)
80103237:	89 34 24             	mov    %esi,(%esp)
8010323a:	e8 f1 2a 00 00       	call   80105d30 <memcmp>
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
801032cf:	ff 24 85 6c 8e 10 80 	jmp    *-0x7fef7194(,%eax,4)
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
80103380:	c7 04 24 2d 8e 10 80 	movl   $0x80108e2d,(%esp)
80103387:	e8 e4 cf ff ff       	call   80100370 <panic>
    panic("Didn't find a suitable machine");
8010338c:	c7 04 24 4c 8e 10 80 	movl   $0x80108e4c,(%esp)
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
80103460:	ba 80 8e 10 80       	mov    $0x80108e80,%edx
  p->nread = 0;
80103465:	89 88 34 02 00 00    	mov    %ecx,0x234(%eax)
  initlock(&p->lock, "pipe");
8010346b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010346f:	89 04 24             	mov    %eax,(%esp)
80103472:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103475:	e8 16 26 00 00       	call   80105a90 <initlock>
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
801034d5:	e8 06 27 00 00       	call   80105be0 <acquire>
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
801034ef:	e8 ac 11 00 00       	call   801046a0 <wakeup>
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
80103514:	e9 67 27 00 00       	jmp    80105c80 <release>
80103519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->readopen = 0;
80103520:	31 c9                	xor    %ecx,%ecx
    wakeup(&p->nwrite);
80103522:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103528:	89 8b 3c 02 00 00    	mov    %ecx,0x23c(%ebx)
    wakeup(&p->nwrite);
8010352e:	89 04 24             	mov    %eax,(%esp)
80103531:	e8 6a 11 00 00       	call   801046a0 <wakeup>
80103536:	eb bc                	jmp    801034f4 <pipeclose+0x34>
80103538:	90                   	nop
80103539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103540:	89 1c 24             	mov    %ebx,(%esp)
80103543:	e8 38 27 00 00       	call   80105c80 <release>
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
8010356f:	e8 6c 26 00 00       	call   80105be0 <acquire>
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
801035c3:	e8 d8 10 00 00       	call   801046a0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035c8:	89 7c 24 04          	mov    %edi,0x4(%esp)
801035cc:	89 1c 24             	mov    %ebx,(%esp)
801035cf:	e8 cc 0e 00 00       	call   801044a0 <sleep>
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
80103602:	e8 79 26 00 00       	call   80105c80 <release>
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
8010364f:	e8 4c 10 00 00       	call   801046a0 <wakeup>
  release(&p->lock);
80103654:	89 3c 24             	mov    %edi,(%esp)
80103657:	e8 24 26 00 00       	call   80105c80 <release>
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
80103682:	e8 59 25 00 00       	call   80105be0 <acquire>
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
801036b7:	e8 e4 0d 00 00       	call   801044a0 <sleep>
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
801036ec:	e8 8f 25 00 00       	call   80105c80 <release>
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
80103744:	e8 57 0f 00 00       	call   801046a0 <wakeup>
  release(&p->lock);
80103749:	89 34 24             	mov    %esi,(%esp)
8010374c:	e8 2f 25 00 00       	call   80105c80 <release>
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
80103783:	e8 58 24 00 00       	call   80105be0 <acquire>
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
801037c8:	e8 b3 24 00 00       	call   80105c80 <release>
  
  acquire(&tickslock);
801037cd:	c7 04 24 e0 77 11 80 	movl   $0x801177e0,(%esp)
801037d4:	e8 07 24 00 00       	call   80105be0 <acquire>
  p->performance.ctime = ticks;
801037d9:	a1 20 80 11 80       	mov    0x80118020,%eax
801037de:	89 83 94 00 00 00    	mov    %eax,0x94(%ebx)
  release(&tickslock);
801037e4:	c7 04 24 e0 77 11 80 	movl   $0x801177e0,(%esp)
801037eb:	e8 90 24 00 00       	call   80105c80 <release>

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
8010380a:	ba ff 6f 10 80       	mov    $0x80106fff,%edx
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
80103827:	e8 a4 24 00 00       	call   80105cd0 <memset>
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
80103849:	e8 32 24 00 00       	call   80105c80 <release>
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
8010387d:	e8 fe 23 00 00       	call   80105c80 <release>

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
801038e1:	b8 85 8e 10 80       	mov    $0x80108e85,%eax
{
801038e6:	89 e5                	mov    %esp,%ebp
801038e8:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
801038eb:	89 44 24 04          	mov    %eax,0x4(%esp)
801038ef:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
801038f6:	e8 95 21 00 00       	call   80105a90 <initlock>
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
8010395e:	c7 04 24 8c 8e 10 80 	movl   $0x80108e8c,(%esp)
80103965:	e8 06 ca ff ff       	call   80100370 <panic>
    panic("mycpu called with interrupts enabled\n");
8010396a:	c7 04 24 7c 8f 10 80 	movl   $0x80108f7c,(%esp)
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
801039a7:	e8 54 21 00 00       	call   80105b00 <pushcli>
  c = mycpu();
801039ac:	e8 4f ff ff ff       	call   80103900 <mycpu>
  p = c->proc;
801039b1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039b7:	e8 84 21 00 00       	call   80105b40 <popcli>
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
801039db:	e8 20 21 00 00       	call   80105b00 <pushcli>
  c = mycpu();
801039e0:	e8 1b ff ff ff       	call   80103900 <mycpu>
  p = c->proc;
801039e5:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039eb:	e8 50 21 00 00       	call   80105b40 <popcli>
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
801039fe:	e8 fd 47 00 00       	call   80108200 <switchuvm>
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
80103a20:	e8 2b 4a 00 00       	call   80108450 <allocuvm>
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
80103a40:	e8 3b 4b 00 00       	call   80108580 <deallocuvm>
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
80103b43:	e8 e8 4a 00 00       	call   80108630 <setupkvm>
80103b48:	85 c0                	test   %eax,%eax
80103b4a:	89 43 04             	mov    %eax,0x4(%ebx)
80103b4d:	0f 84 15 01 00 00    	je     80103c68 <userinit+0x138>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103b53:	b9 60 c4 10 80       	mov    $0x8010c460,%ecx
80103b58:	ba 2c 00 00 00       	mov    $0x2c,%edx
80103b5d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80103b61:	89 54 24 08          	mov    %edx,0x8(%esp)
80103b65:	89 04 24             	mov    %eax,(%esp)
80103b68:	e8 93 47 00 00       	call   80108300 <inituvm>
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
80103b88:	e8 43 21 00 00       	call   80105cd0 <memset>
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
80103bda:	b8 b5 8e 10 80       	mov    $0x80108eb5,%eax
80103bdf:	89 44 24 04          	mov    %eax,0x4(%esp)
80103be3:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103be6:	89 04 24             	mov    %eax,(%esp)
80103be9:	e8 c2 22 00 00       	call   80105eb0 <safestrcpy>
  p->cwd = namei("/");
80103bee:	c7 04 24 be 8e 10 80 	movl   $0x80108ebe,(%esp)
80103bf5:	e8 d6 e3 ff ff       	call   80101fd0 <namei>
80103bfa:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103bfd:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80103c04:	e8 d7 1f 00 00       	call   80105be0 <acquire>
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
80103c53:	e8 28 20 00 00       	call   80105c80 <release>
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
80103c68:	c7 04 24 9c 8e 10 80 	movl   $0x80108e9c,(%esp)
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
80103c89:	e8 72 1e 00 00       	call   80105b00 <pushcli>
  c = mycpu();
80103c8e:	e8 6d fc ff ff       	call   80103900 <mycpu>
  p = c->proc;
80103c93:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
80103c99:	e8 a2 1e 00 00       	call   80105b40 <popcli>
  if((np = allocproc()) == 0){
80103c9e:	e8 cd fa ff ff       	call   80103770 <allocproc>
80103ca3:	85 c0                	test   %eax,%eax
80103ca5:	0f 84 3d 01 00 00    	je     80103de8 <fork+0x168>
80103cab:	89 c6                	mov    %eax,%esi
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103cad:	8b 07                	mov    (%edi),%eax
80103caf:	89 44 24 04          	mov    %eax,0x4(%esp)
80103cb3:	8b 47 04             	mov    0x4(%edi),%eax
80103cb6:	89 04 24             	mov    %eax,(%esp)
80103cb9:	e8 42 4a 00 00       	call   80108700 <copyuvm>
80103cbe:	85 c0                	test   %eax,%eax
80103cc0:	89 46 04             	mov    %eax,0x4(%esi)
80103cc3:	0f 84 29 01 00 00    	je     80103df2 <fork+0x172>
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
80103d3e:	e8 6d 21 00 00       	call   80105eb0 <safestrcpy>
  pid = np->pid;
80103d43:	8b 5e 10             	mov    0x10(%esi),%ebx
  acquire(&tickslock);
80103d46:	c7 04 24 e0 77 11 80 	movl   $0x801177e0,(%esp)
80103d4d:	e8 8e 1e 00 00       	call   80105be0 <acquire>
  np->performance.ctime = ticks;
80103d52:	a1 20 80 11 80       	mov    0x80118020,%eax
80103d57:	89 86 94 00 00 00    	mov    %eax,0x94(%esi)
  release(&tickslock);
80103d5d:	c7 04 24 e0 77 11 80 	movl   $0x801177e0,(%esp)
80103d64:	e8 17 1f 00 00       	call   80105c80 <release>
  acquire(&ptable.lock);
80103d69:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80103d70:	e8 6b 1e 00 00       	call   80105be0 <acquire>
  if(np->state == RUNNING)
80103d75:	8b 46 0c             	mov    0xc(%esi),%eax
80103d78:	83 f8 04             	cmp    $0x4,%eax
80103d7b:	75 09                	jne    80103d86 <fork+0x106>
      rpholder.remove(np);
80103d7d:	89 34 24             	mov    %esi,(%esp)
80103d80:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
  np->timeStamp = tqCounter;
80103d86:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
80103d8b:	8b 15 c4 c5 10 80    	mov    0x8010c5c4,%edx
  if(POLICY == 1)
80103d91:	83 3d 08 c0 10 80 01 	cmpl   $0x1,0x8010c008
  np->state = RUNNABLE;
80103d98:	c7 46 0c 03 00 00 00 	movl   $0x3,0xc(%esi)
  np->timeStamp = tqCounter;
80103d9f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80103da5:	89 96 90 00 00 00    	mov    %edx,0x90(%esi)
      rrq.enqueue(np);
80103dab:	89 34 24             	mov    %esi,(%esp)
  if(POLICY == 1)
80103dae:	74 30                	je     80103de0 <fork+0x160>
      pq.put(np);
80103db0:	ff 15 f0 c5 10 80    	call   *0x8010c5f0
  np->priority = 5; // Set the priority of new process to 5
80103db6:	b8 05 00 00 00       	mov    $0x5,%eax
80103dbb:	89 86 80 00 00 00    	mov    %eax,0x80(%esi)
  setAccumulator(np);
80103dc1:	89 34 24             	mov    %esi,(%esp)
80103dc4:	e8 87 fc ff ff       	call   80103a50 <setAccumulator>
  release(&ptable.lock);
80103dc9:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80103dd0:	e8 ab 1e 00 00       	call   80105c80 <release>
}
80103dd5:	83 c4 1c             	add    $0x1c,%esp
80103dd8:	89 d8                	mov    %ebx,%eax
80103dda:	5b                   	pop    %ebx
80103ddb:	5e                   	pop    %esi
80103ddc:	5f                   	pop    %edi
80103ddd:	5d                   	pop    %ebp
80103dde:	c3                   	ret    
80103ddf:	90                   	nop
      rrq.enqueue(np);
80103de0:	ff 15 e0 c5 10 80    	call   *0x8010c5e0
80103de6:	eb ce                	jmp    80103db6 <fork+0x136>
    return -1;
80103de8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103ded:	8d 76 00             	lea    0x0(%esi),%esi
80103df0:	eb e3                	jmp    80103dd5 <fork+0x155>
    kfree(np->kstack);
80103df2:	8b 46 08             	mov    0x8(%esi),%eax
    return -1;
80103df5:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    kfree(np->kstack);
80103dfa:	89 04 24             	mov    %eax,(%esp)
80103dfd:	e8 de e5 ff ff       	call   801023e0 <kfree>
    np->kstack = 0;
80103e02:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
    np->state = UNUSED;
80103e09:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    return -1;
80103e10:	eb c3                	jmp    80103dd5 <fork+0x155>
80103e12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e20 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80103e20:	55                   	push   %ebp
80103e21:	89 e5                	mov    %esp,%ebp
80103e23:	56                   	push   %esi
80103e24:	89 c6                	mov    %eax,%esi
80103e26:	53                   	push   %ebx
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e27:	bb d4 4d 11 80       	mov    $0x80114dd4,%ebx
{
80103e2c:	83 ec 10             	sub    $0x10,%esp
80103e2f:	eb 15                	jmp    80103e46 <wakeup1+0x26>
80103e31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e38:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80103e3e:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
80103e44:	73 53                	jae    80103e99 <wakeup1+0x79>
    if(p->state == SLEEPING && p->chan == chan){ 
80103e46:	8b 43 0c             	mov    0xc(%ebx),%eax
80103e49:	83 f8 02             	cmp    $0x2,%eax
80103e4c:	75 ea                	jne    80103e38 <wakeup1+0x18>
80103e4e:	39 73 20             	cmp    %esi,0x20(%ebx)
80103e51:	75 e5                	jne    80103e38 <wakeup1+0x18>
      p->state = RUNNABLE;
      p->timeStamp = tqCounter;
80103e53:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
80103e58:	8b 15 c4 c5 10 80    	mov    0x8010c5c4,%edx
      setAccumulator(p);  
80103e5e:	89 1c 24             	mov    %ebx,(%esp)
      p->state = RUNNABLE;
80103e61:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
      p->timeStamp = tqCounter;
80103e68:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
80103e6e:	89 93 90 00 00 00    	mov    %edx,0x90(%ebx)
      setAccumulator(p);  
80103e74:	e8 d7 fb ff ff       	call   80103a50 <setAccumulator>
      if(POLICY == 1)
80103e79:	83 3d 08 c0 10 80 01 	cmpl   $0x1,0x8010c008
        rrq.enqueue(p);
80103e80:	89 1c 24             	mov    %ebx,(%esp)
      if(POLICY == 1)
80103e83:	74 1b                	je     80103ea0 <wakeup1+0x80>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e85:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
      else
        pq.put(p);
80103e8b:	ff 15 f0 c5 10 80    	call   *0x8010c5f0
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e91:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
80103e97:	72 ad                	jb     80103e46 <wakeup1+0x26>
    }
}
80103e99:	83 c4 10             	add    $0x10,%esp
80103e9c:	5b                   	pop    %ebx
80103e9d:	5e                   	pop    %esi
80103e9e:	5d                   	pop    %ebp
80103e9f:	c3                   	ret    
        rrq.enqueue(p);
80103ea0:	ff 15 e0 c5 10 80    	call   *0x8010c5e0
80103ea6:	eb 90                	jmp    80103e38 <wakeup1+0x18>
80103ea8:	90                   	nop
80103ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103eb0 <originalScheduler>:
{
80103eb0:	55                   	push   %ebp
80103eb1:	89 e5                	mov    %esp,%ebp
80103eb3:	57                   	push   %edi
80103eb4:	56                   	push   %esi
80103eb5:	53                   	push   %ebx
80103eb6:	83 ec 1c             	sub    $0x1c,%esp
80103eb9:	8b 7d 0c             	mov    0xc(%ebp),%edi
  asm volatile("sti");
80103ebc:	fb                   	sti    
    acquire(&ptable.lock);
80103ebd:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ec4:	bb d4 4d 11 80       	mov    $0x80114dd4,%ebx
    acquire(&ptable.lock);
80103ec9:	e8 12 1d 00 00       	call   80105be0 <acquire>
      swtch(&(c->scheduler), p->context);
80103ece:	8d 77 04             	lea    0x4(%edi),%esi
80103ed1:	eb 0d                	jmp    80103ee0 <originalScheduler+0x30>
80103ed3:	90                   	nop
80103ed4:	90                   	nop
80103ed5:	90                   	nop
80103ed6:	90                   	nop
80103ed7:	90                   	nop
80103ed8:	90                   	nop
80103ed9:	90                   	nop
80103eda:	90                   	nop
80103edb:	90                   	nop
80103edc:	90                   	nop
80103edd:	90                   	nop
80103ede:	90                   	nop
80103edf:	90                   	nop
      if(p->state != RUNNABLE)
80103ee0:	8b 43 0c             	mov    0xc(%ebx),%eax
80103ee3:	83 f8 03             	cmp    $0x3,%eax
80103ee6:	75 31                	jne    80103f19 <originalScheduler+0x69>
      c->proc = p;
80103ee8:	89 9f ac 00 00 00    	mov    %ebx,0xac(%edi)
      switchuvm(p);
80103eee:	89 1c 24             	mov    %ebx,(%esp)
80103ef1:	e8 0a 43 00 00       	call   80108200 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103ef6:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103ef9:	89 34 24             	mov    %esi,(%esp)
      p->state = RUNNING;
80103efc:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103f03:	89 44 24 04          	mov    %eax,0x4(%esp)
80103f07:	e8 fd 1f 00 00       	call   80105f09 <swtch>
      switchkvm();
80103f0c:	e8 cf 42 00 00       	call   801081e0 <switchkvm>
      c->proc = 0;
80103f11:	31 c0                	xor    %eax,%eax
80103f13:	89 87 ac 00 00 00    	mov    %eax,0xac(%edi)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f19:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80103f1f:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
80103f25:	72 b9                	jb     80103ee0 <originalScheduler+0x30>
    release(&ptable.lock);
80103f27:	c7 45 08 a0 4d 11 80 	movl   $0x80114da0,0x8(%ebp)
}
80103f2e:	83 c4 1c             	add    $0x1c,%esp
80103f31:	5b                   	pop    %ebx
80103f32:	5e                   	pop    %esi
80103f33:	5f                   	pop    %edi
80103f34:	5d                   	pop    %ebp
    release(&ptable.lock);
80103f35:	e9 46 1d 00 00       	jmp    80105c80 <release>
80103f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103f40 <roundRobinScheduler>:
{
80103f40:	55                   	push   %ebp
80103f41:	89 e5                	mov    %esp,%ebp
80103f43:	56                   	push   %esi
80103f44:	53                   	push   %ebx
80103f45:	83 ec 10             	sub    $0x10,%esp
80103f48:	8b 75 0c             	mov    0xc(%ebp),%esi
80103f4b:	fb                   	sti    
    acquire(&ptable.lock);
80103f4c:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80103f53:	e8 88 1c 00 00       	call   80105be0 <acquire>
    if(!rrq.isEmpty()){
80103f58:	ff 15 dc c5 10 80    	call   *0x8010c5dc
80103f5e:	85 c0                	test   %eax,%eax
80103f60:	75 4e                	jne    80103fb0 <roundRobinScheduler+0x70>
            p = rrq.dequeue();
80103f62:	ff 15 e4 c5 10 80    	call   *0x8010c5e4
80103f68:	89 c3                	mov    %eax,%ebx
            c->proc = p;
80103f6a:	89 86 ac 00 00 00    	mov    %eax,0xac(%esi)
            switchuvm(p);
80103f70:	89 04 24             	mov    %eax,(%esp)
80103f73:	e8 88 42 00 00       	call   80108200 <switchuvm>
            swtch(&(c->scheduler), p->context);
80103f78:	8b 43 1c             	mov    0x1c(%ebx),%eax
            p->state = RUNNING;
80103f7b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
            swtch(&(c->scheduler), p->context);
80103f82:	89 44 24 04          	mov    %eax,0x4(%esp)
80103f86:	8d 46 04             	lea    0x4(%esi),%eax
80103f89:	89 04 24             	mov    %eax,(%esp)
80103f8c:	e8 78 1f 00 00       	call   80105f09 <swtch>
            switchkvm();
80103f91:	e8 4a 42 00 00       	call   801081e0 <switchkvm>
            rpholder.remove(p);
80103f96:	89 1c 24             	mov    %ebx,(%esp)
80103f99:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
            rpholder.add(p);
80103f9f:	89 1c 24             	mov    %ebx,(%esp)
80103fa2:	ff 15 d0 c5 10 80    	call   *0x8010c5d0
            c->proc = 0;
80103fa8:	31 c0                	xor    %eax,%eax
80103faa:	89 86 ac 00 00 00    	mov    %eax,0xac(%esi)
    release(&ptable.lock);
80103fb0:	c7 45 08 a0 4d 11 80 	movl   $0x80114da0,0x8(%ebp)
}
80103fb7:	83 c4 10             	add    $0x10,%esp
80103fba:	5b                   	pop    %ebx
80103fbb:	5e                   	pop    %esi
80103fbc:	5d                   	pop    %ebp
    release(&ptable.lock);
80103fbd:	e9 be 1c 00 00       	jmp    80105c80 <release>
80103fc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103fd0 <priorityScheduler>:
{
80103fd0:	55                   	push   %ebp
80103fd1:	89 e5                	mov    %esp,%ebp
80103fd3:	56                   	push   %esi
80103fd4:	53                   	push   %ebx
80103fd5:	83 ec 10             	sub    $0x10,%esp
80103fd8:	8b 75 0c             	mov    0xc(%ebp),%esi
80103fdb:	fb                   	sti    
    acquire(&ptable.lock);
80103fdc:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80103fe3:	e8 f8 1b 00 00       	call   80105be0 <acquire>
    if(!pq.isEmpty()){
80103fe8:	ff 15 ec c5 10 80    	call   *0x8010c5ec
80103fee:	85 c0                	test   %eax,%eax
80103ff0:	75 4e                	jne    80104040 <priorityScheduler+0x70>
        p = pq.extractMin();
80103ff2:	ff 15 f8 c5 10 80    	call   *0x8010c5f8
80103ff8:	89 c3                	mov    %eax,%ebx
        c->proc = p;
80103ffa:	89 86 ac 00 00 00    	mov    %eax,0xac(%esi)
        switchuvm(p);
80104000:	89 04 24             	mov    %eax,(%esp)
80104003:	e8 f8 41 00 00       	call   80108200 <switchuvm>
        p->state = RUNNING; 
80104008:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
        rpholder.remove(p);
8010400f:	89 1c 24             	mov    %ebx,(%esp)
80104012:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
        rpholder.add(p);
80104018:	89 1c 24             	mov    %ebx,(%esp)
8010401b:	ff 15 d0 c5 10 80    	call   *0x8010c5d0
        swtch(&(c->scheduler), p->context);
80104021:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104024:	89 44 24 04          	mov    %eax,0x4(%esp)
80104028:	8d 46 04             	lea    0x4(%esi),%eax
8010402b:	89 04 24             	mov    %eax,(%esp)
8010402e:	e8 d6 1e 00 00       	call   80105f09 <swtch>
        switchkvm();
80104033:	e8 a8 41 00 00       	call   801081e0 <switchkvm>
        c->proc = 0;
80104038:	31 c0                	xor    %eax,%eax
8010403a:	89 86 ac 00 00 00    	mov    %eax,0xac(%esi)
    release(&ptable.lock);
80104040:	c7 45 08 a0 4d 11 80 	movl   $0x80114da0,0x8(%ebp)
}
80104047:	83 c4 10             	add    $0x10,%esp
8010404a:	5b                   	pop    %ebx
8010404b:	5e                   	pop    %esi
8010404c:	5d                   	pop    %ebp
    release(&ptable.lock);
8010404d:	e9 2e 1c 00 00       	jmp    80105c80 <release>
80104052:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104060 <extendedPriorityScheduler>:
{
80104060:	55                   	push   %ebp
80104061:	89 e5                	mov    %esp,%ebp
80104063:	57                   	push   %edi
80104064:	56                   	push   %esi
80104065:	53                   	push   %ebx
80104066:	83 ec 3c             	sub    $0x3c,%esp
80104069:	8b 75 08             	mov    0x8(%ebp),%esi
8010406c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010406f:	fb                   	sti    
    acquire(&ptable.lock);
80104070:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104077:	e8 64 1b 00 00       	call   80105be0 <acquire>
    if(!pq.isEmpty()){
8010407c:	ff 15 ec c5 10 80    	call   *0x8010c5ec
80104082:	85 c0                	test   %eax,%eax
80104084:	0f 85 81 00 00 00    	jne    8010410b <extendedPriorityScheduler+0xab>
            if(tqCounter % 100 == 0){
8010408a:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
8010408f:	b9 64 00 00 00       	mov    $0x64,%ecx
80104094:	31 ff                	xor    %edi,%edi
80104096:	8b 15 c4 c5 10 80    	mov    0x8010c5c4,%edx
8010409c:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801040a0:	89 7c 24 0c          	mov    %edi,0xc(%esp)
801040a4:	89 04 24             	mov    %eax,(%esp)
801040a7:	89 54 24 04          	mov    %edx,0x4(%esp)
801040ab:	89 45 d8             	mov    %eax,-0x28(%ebp)
801040ae:	89 55 dc             	mov    %edx,-0x24(%ebp)
801040b1:	e8 da 17 00 00       	call   80105890 <__moddi3>
801040b6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801040b9:	09 d0                	or     %edx,%eax
801040bb:	74 63                	je     80104120 <extendedPriorityScheduler+0xc0>
                np = pq.extractMin();
801040bd:	ff 15 f8 c5 10 80    	call   *0x8010c5f8
801040c3:	89 c6                	mov    %eax,%esi
            c->proc = np;
801040c5:	89 b3 ac 00 00 00    	mov    %esi,0xac(%ebx)
            switchuvm(np);
801040cb:	89 34 24             	mov    %esi,(%esp)
801040ce:	e8 2d 41 00 00       	call   80108200 <switchuvm>
            np->state = RUNNING;
801040d3:	c7 46 0c 04 00 00 00 	movl   $0x4,0xc(%esi)
            rpholder.remove(np);
801040da:	89 34 24             	mov    %esi,(%esp)
801040dd:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
            rpholder.add(np);
801040e3:	89 34 24             	mov    %esi,(%esp)
801040e6:	ff 15 d0 c5 10 80    	call   *0x8010c5d0
            swtch(&(c->scheduler), np->context);
801040ec:	8b 46 1c             	mov    0x1c(%esi),%eax
801040ef:	89 44 24 04          	mov    %eax,0x4(%esp)
801040f3:	8d 43 04             	lea    0x4(%ebx),%eax
801040f6:	89 04 24             	mov    %eax,(%esp)
801040f9:	e8 0b 1e 00 00       	call   80105f09 <swtch>
            switchkvm();
801040fe:	e8 dd 40 00 00       	call   801081e0 <switchkvm>
            c->proc = 0;
80104103:	31 c0                	xor    %eax,%eax
80104105:	89 83 ac 00 00 00    	mov    %eax,0xac(%ebx)
                        release(&ptable.lock);
8010410b:	c7 45 08 a0 4d 11 80 	movl   $0x80114da0,0x8(%ebp)
}
80104112:	83 c4 3c             	add    $0x3c,%esp
80104115:	5b                   	pop    %ebx
80104116:	5e                   	pop    %esi
80104117:	5f                   	pop    %edi
80104118:	5d                   	pop    %ebp
                        release(&ptable.lock);
80104119:	e9 62 1b 00 00       	jmp    80105c80 <release>
8010411e:	66 90                	xchg   %ax,%ax
                for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){  // Run over all the ptable and look for the process which didn't work for the lonest time.
80104120:	89 75 e0             	mov    %esi,-0x20(%ebp)
80104123:	b9 d4 4d 11 80       	mov    $0x80114dd4,%ecx
80104128:	8b 75 d8             	mov    -0x28(%ebp),%esi
8010412b:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
8010412e:	8b 7d dc             	mov    -0x24(%ebp),%edi
80104131:	89 d3                	mov    %edx,%ebx
80104133:	eb 11                	jmp    80104146 <extendedPriorityScheduler+0xe6>
80104135:	8d 76 00             	lea    0x0(%esi),%esi
80104138:	81 c1 a8 00 00 00    	add    $0xa8,%ecx
8010413e:	81 f9 d4 77 11 80    	cmp    $0x801177d4,%ecx
80104144:	73 32                	jae    80104178 <extendedPriorityScheduler+0x118>
                        if (p->state == RUNNABLE){
80104146:	8b 41 0c             	mov    0xc(%ecx),%eax
80104149:	83 f8 03             	cmp    $0x3,%eax
8010414c:	75 ea                	jne    80104138 <extendedPriorityScheduler+0xd8>
                            if (tqCounter - p->timeStamp > max){
8010414e:	89 f0                	mov    %esi,%eax
80104150:	89 fa                	mov    %edi,%edx
80104152:	2b 81 8c 00 00 00    	sub    0x8c(%ecx),%eax
80104158:	1b 91 90 00 00 00    	sbb    0x90(%ecx),%edx
8010415e:	39 da                	cmp    %ebx,%edx
80104160:	7c d6                	jl     80104138 <extendedPriorityScheduler+0xd8>
80104162:	7f 05                	jg     80104169 <extendedPriorityScheduler+0x109>
80104164:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
80104167:	76 cf                	jbe    80104138 <extendedPriorityScheduler+0xd8>
80104169:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010416c:	89 d3                	mov    %edx,%ebx
8010416e:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80104171:	eb c5                	jmp    80104138 <extendedPriorityScheduler+0xd8>
80104173:	90                   	nop
80104174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104178:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010417b:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
                if (!pq.extractProc(np)){
8010417e:	89 34 24             	mov    %esi,(%esp)
80104181:	ff 15 00 c6 10 80    	call   *0x8010c600
80104187:	85 c0                	test   %eax,%eax
80104189:	74 80                	je     8010410b <extendedPriorityScheduler+0xab>
                 avoidStarv = 0;
8010418b:	31 d2                	xor    %edx,%edx
8010418d:	89 15 b8 c5 10 80    	mov    %edx,0x8010c5b8
80104193:	e9 2d ff ff ff       	jmp    801040c5 <extendedPriorityScheduler+0x65>
80104198:	90                   	nop
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
801041e1:	e8 7a fe ff ff       	call   80104060 <extendedPriorityScheduler>
    switch(POLICY){
801041e6:	a1 08 c0 10 80       	mov    0x8010c008,%eax
801041eb:	83 f8 01             	cmp    $0x1,%eax
801041ee:	75 da                	jne    801041ca <scheduler+0x2a>
            roundRobinScheduler(p, c);
801041f0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801041f4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801041fb:	e8 40 fd ff ff       	call   80103f40 <roundRobinScheduler>
            break;
80104200:	eb be                	jmp    801041c0 <scheduler+0x20>
80104202:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(POLICY){
80104208:	85 c0                	test   %eax,%eax
8010420a:	75 b9                	jne    801041c5 <scheduler+0x25>
            originalScheduler(p, c);
8010420c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104210:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104217:	e8 94 fc ff ff       	call   80103eb0 <originalScheduler>
            break;
8010421c:	eb a2                	jmp    801041c0 <scheduler+0x20>
8010421e:	66 90                	xchg   %ax,%ax
            priorityScheduler(p, c);
80104220:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104224:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010422b:	e8 a0 fd ff ff       	call   80103fd0 <priorityScheduler>
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
80104248:	e8 b3 18 00 00       	call   80105b00 <pushcli>
  c = mycpu();
8010424d:	e8 ae f6 ff ff       	call   80103900 <mycpu>
  p = c->proc;
80104252:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104258:	e8 e3 18 00 00       	call   80105b40 <popcli>
  if(!holding(&ptable.lock))
8010425d:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104264:	e8 37 19 00 00       	call   80105ba0 <holding>
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
801042a7:	e8 5d 1c 00 00       	call   80105f09 <swtch>
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
801042be:	c7 04 24 c0 8e 10 80 	movl   $0x80108ec0,(%esp)
801042c5:	e8 a6 c0 ff ff       	call   80100370 <panic>
    panic("sched interruptible");
801042ca:	c7 04 24 ec 8e 10 80 	movl   $0x80108eec,(%esp)
801042d1:	e8 9a c0 ff ff       	call   80100370 <panic>
    panic("sched running");
801042d6:	c7 04 24 de 8e 10 80 	movl   $0x80108ede,(%esp)
801042dd:	e8 8e c0 ff ff       	call   80100370 <panic>
    panic("sched locks");
801042e2:	c7 04 24 d2 8e 10 80 	movl   $0x80108ed2,(%esp)
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
801042f9:	e8 02 18 00 00       	call   80105b00 <pushcli>
  c = mycpu();
801042fe:	e8 fd f5 ff ff       	call   80103900 <mycpu>
  p = c->proc;
80104303:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104309:	e8 32 18 00 00       	call   80105b40 <popcli>
  if(curproc == initproc)
8010430e:	39 35 c8 c5 10 80    	cmp    %esi,0x8010c5c8
80104314:	0f 84 c5 00 00 00    	je     801043df <exit+0xef>
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
  acquire(&ptable.lock);
8010435c:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104363:	e8 78 18 00 00       	call   80105be0 <acquire>
  wakeup1(curproc->parent);
80104368:	8b 46 14             	mov    0x14(%esi),%eax
8010436b:	e8 b0 fa ff ff       	call   80103e20 <wakeup1>
80104370:	eb 14                	jmp    80104386 <exit+0x96>
80104372:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104378:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
8010437e:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
80104384:	73 2a                	jae    801043b0 <exit+0xc0>
    if(p->parent == curproc){
80104386:	39 73 14             	cmp    %esi,0x14(%ebx)
80104389:	75 ed                	jne    80104378 <exit+0x88>
      if(p->state == ZOMBIE)
8010438b:	8b 53 0c             	mov    0xc(%ebx),%edx
      p->parent = initproc;
8010438e:	a1 c8 c5 10 80       	mov    0x8010c5c8,%eax
      if(p->state == ZOMBIE)
80104393:	83 fa 05             	cmp    $0x5,%edx
      p->parent = initproc;
80104396:	89 43 14             	mov    %eax,0x14(%ebx)
      if(p->state == ZOMBIE)
80104399:	75 dd                	jne    80104378 <exit+0x88>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010439b:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
        wakeup1(initproc);
801043a1:	e8 7a fa ff ff       	call   80103e20 <wakeup1>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043a6:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
801043ac:	72 d8                	jb     80104386 <exit+0x96>
801043ae:	66 90                	xchg   %ax,%ax
  curproc->exitStatus = status;
801043b0:	8b 45 08             	mov    0x8(%ebp),%eax
801043b3:	89 46 7c             	mov    %eax,0x7c(%esi)
  if(p->state == RUNNING)
801043b6:	8b 43 0c             	mov    0xc(%ebx),%eax
801043b9:	83 f8 04             	cmp    $0x4,%eax
801043bc:	75 09                	jne    801043c7 <exit+0xd7>
      rpholder.remove(p);
801043be:	89 1c 24             	mov    %ebx,(%esp)
801043c1:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
  curproc->state = ZOMBIE;
801043c7:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
801043ce:	e8 6d fe ff ff       	call   80104240 <sched>
  panic("zombie exit");
801043d3:	c7 04 24 0d 8f 10 80 	movl   $0x80108f0d,(%esp)
801043da:	e8 91 bf ff ff       	call   80100370 <panic>
    panic("init exiting");
801043df:	c7 04 24 00 8f 10 80 	movl   $0x80108f00,(%esp)
801043e6:	e8 85 bf ff ff       	call   80100370 <panic>
801043eb:	90                   	nop
801043ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801043f0 <yield>:
{
801043f0:	55                   	push   %ebp
801043f1:	89 e5                	mov    %esp,%ebp
801043f3:	53                   	push   %ebx
801043f4:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801043f7:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
801043fe:	e8 dd 17 00 00       	call   80105be0 <acquire>
  pushcli();
80104403:	e8 f8 16 00 00       	call   80105b00 <pushcli>
  c = mycpu();
80104408:	e8 f3 f4 ff ff       	call   80103900 <mycpu>
  p = c->proc;
8010440d:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104413:	e8 28 17 00 00       	call   80105b40 <popcli>
  if(p->state == RUNNING){
80104418:	8b 43 0c             	mov    0xc(%ebx),%eax
8010441b:	83 f8 04             	cmp    $0x4,%eax
8010441e:	75 09                	jne    80104429 <yield+0x39>
    rpholder.remove(p);
80104420:	89 1c 24             	mov    %ebx,(%esp)
80104423:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
  tqCounter++;
80104429:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
8010442e:	8b 15 c4 c5 10 80    	mov    0x8010c5c4,%edx
  p->state = RUNNABLE;
80104434:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  tqCounter++;
8010443b:	83 c0 01             	add    $0x1,%eax
8010443e:	83 d2 00             	adc    $0x0,%edx
  if(POLICY == 1){
80104441:	83 3d 08 c0 10 80 01 	cmpl   $0x1,0x8010c008
  p->timeStamp = tqCounter;
80104448:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
8010444e:	89 93 90 00 00 00    	mov    %edx,0x90(%ebx)
  tqCounter++;
80104454:	a3 c0 c5 10 80       	mov    %eax,0x8010c5c0
80104459:	89 15 c4 c5 10 80    	mov    %edx,0x8010c5c4
      rrq.enqueue(p);
8010445f:	89 1c 24             	mov    %ebx,(%esp)
  if(POLICY == 1){
80104462:	74 34                	je     80104498 <yield+0xa8>
      pq.put(p);
80104464:	ff 15 f0 c5 10 80    	call   *0x8010c5f0
      p->accumulator += p->priority;
8010446a:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
80104470:	99                   	cltd   
80104471:	01 83 84 00 00 00    	add    %eax,0x84(%ebx)
80104477:	11 93 88 00 00 00    	adc    %edx,0x88(%ebx)
  sched();
8010447d:	e8 be fd ff ff       	call   80104240 <sched>
  release(&ptable.lock);
80104482:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104489:	e8 f2 17 00 00       	call   80105c80 <release>
}
8010448e:	83 c4 14             	add    $0x14,%esp
80104491:	5b                   	pop    %ebx
80104492:	5d                   	pop    %ebp
80104493:	c3                   	ret    
80104494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      rrq.enqueue(p);
80104498:	ff 15 e0 c5 10 80    	call   *0x8010c5e0
8010449e:	eb dd                	jmp    8010447d <yield+0x8d>

801044a0 <sleep>:
{
801044a0:	55                   	push   %ebp
801044a1:	89 e5                	mov    %esp,%ebp
801044a3:	83 ec 28             	sub    $0x28,%esp
801044a6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801044a9:	89 75 f8             	mov    %esi,-0x8(%ebp)
801044ac:	8b 75 0c             	mov    0xc(%ebp),%esi
801044af:	89 7d fc             	mov    %edi,-0x4(%ebp)
801044b2:	8b 7d 08             	mov    0x8(%ebp),%edi
  pushcli();
801044b5:	e8 46 16 00 00       	call   80105b00 <pushcli>
  c = mycpu();
801044ba:	e8 41 f4 ff ff       	call   80103900 <mycpu>
  p = c->proc;
801044bf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801044c5:	e8 76 16 00 00       	call   80105b40 <popcli>
  if(p == 0)
801044ca:	85 db                	test   %ebx,%ebx
801044cc:	0f 84 ae 00 00 00    	je     80104580 <sleep+0xe0>
  if(lk == 0)
801044d2:	85 f6                	test   %esi,%esi
801044d4:	0f 84 9a 00 00 00    	je     80104574 <sleep+0xd4>
  if(lk != &ptable.lock){  //DOC: sleeplock0
801044da:	81 fe a0 4d 11 80    	cmp    $0x80114da0,%esi
801044e0:	74 5e                	je     80104540 <sleep+0xa0>
    acquire(&ptable.lock);  //DOC: sleeplock1
801044e2:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
801044e9:	e8 f2 16 00 00       	call   80105be0 <acquire>
    release(lk); 
801044ee:	89 34 24             	mov    %esi,(%esp)
801044f1:	e8 8a 17 00 00       	call   80105c80 <release>
  if(p->state == RUNNING)
801044f6:	8b 43 0c             	mov    0xc(%ebx),%eax
  p->chan = chan;
801044f9:	89 7b 20             	mov    %edi,0x20(%ebx)
  if(p->state == RUNNING)
801044fc:	83 f8 04             	cmp    $0x4,%eax
801044ff:	75 09                	jne    8010450a <sleep+0x6a>
      rpholder.remove(p);
80104501:	89 1c 24             	mov    %ebx,(%esp)
80104504:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
  p->state = SLEEPING;
8010450a:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104511:	e8 2a fd ff ff       	call   80104240 <sched>
  p->chan = 0;
80104516:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
8010451d:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104524:	e8 57 17 00 00       	call   80105c80 <release>
}
80104529:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    acquire(lk);
8010452c:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010452f:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104532:	8b 75 f8             	mov    -0x8(%ebp),%esi
80104535:	89 ec                	mov    %ebp,%esp
80104537:	5d                   	pop    %ebp
    acquire(lk);
80104538:	e9 a3 16 00 00       	jmp    80105be0 <acquire>
8010453d:	8d 76 00             	lea    0x0(%esi),%esi
  if(p->state == RUNNING)
80104540:	8b 43 0c             	mov    0xc(%ebx),%eax
  p->chan = chan;
80104543:	89 7b 20             	mov    %edi,0x20(%ebx)
  if(p->state == RUNNING)
80104546:	83 f8 04             	cmp    $0x4,%eax
80104549:	75 09                	jne    80104554 <sleep+0xb4>
      rpholder.remove(p);
8010454b:	89 1c 24             	mov    %ebx,(%esp)
8010454e:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
  p->state = SLEEPING;
80104554:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
8010455b:	e8 e0 fc ff ff       	call   80104240 <sched>
  p->chan = 0;
80104560:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104567:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010456a:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010456d:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104570:	89 ec                	mov    %ebp,%esp
80104572:	5d                   	pop    %ebp
80104573:	c3                   	ret    
    panic("sleep without lk");
80104574:	c7 04 24 1f 8f 10 80 	movl   $0x80108f1f,(%esp)
8010457b:	e8 f0 bd ff ff       	call   80100370 <panic>
    panic("sleep");
80104580:	c7 04 24 19 8f 10 80 	movl   $0x80108f19,(%esp)
80104587:	e8 e4 bd ff ff       	call   80100370 <panic>
8010458c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104590 <wait>:
{
80104590:	55                   	push   %ebp
80104591:	89 e5                	mov    %esp,%ebp
80104593:	57                   	push   %edi
80104594:	56                   	push   %esi
80104595:	53                   	push   %ebx
80104596:	83 ec 1c             	sub    $0x1c,%esp
80104599:	8b 7d 08             	mov    0x8(%ebp),%edi
  pushcli();
8010459c:	e8 5f 15 00 00       	call   80105b00 <pushcli>
  c = mycpu();
801045a1:	e8 5a f3 ff ff       	call   80103900 <mycpu>
  p = c->proc;
801045a6:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801045ac:	e8 8f 15 00 00       	call   80105b40 <popcli>
  acquire(&ptable.lock);
801045b1:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
801045b8:	e8 23 16 00 00       	call   80105be0 <acquire>
    havekids = 0;
801045bd:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045bf:	bb d4 4d 11 80       	mov    $0x80114dd4,%ebx
801045c4:	eb 18                	jmp    801045de <wait+0x4e>
801045c6:	8d 76 00             	lea    0x0(%esi),%esi
801045c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801045d0:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
801045d6:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
801045dc:	73 20                	jae    801045fe <wait+0x6e>
      if(p->parent != curproc)
801045de:	39 73 14             	cmp    %esi,0x14(%ebx)
801045e1:	75 ed                	jne    801045d0 <wait+0x40>
      if(p->state == ZOMBIE){
801045e3:	8b 43 0c             	mov    0xc(%ebx),%eax
801045e6:	83 f8 05             	cmp    $0x5,%eax
801045e9:	74 35                	je     80104620 <wait+0x90>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045eb:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
      havekids = 1;
801045f1:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045f6:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
801045fc:	72 e0                	jb     801045de <wait+0x4e>
    if(!havekids || curproc->killed){
801045fe:	85 c0                	test   %eax,%eax
80104600:	74 7d                	je     8010467f <wait+0xef>
80104602:	8b 56 24             	mov    0x24(%esi),%edx
80104605:	85 d2                	test   %edx,%edx
80104607:	75 76                	jne    8010467f <wait+0xef>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104609:	b8 a0 4d 11 80       	mov    $0x80114da0,%eax
8010460e:	89 44 24 04          	mov    %eax,0x4(%esp)
80104612:	89 34 24             	mov    %esi,(%esp)
80104615:	e8 86 fe ff ff       	call   801044a0 <sleep>
    havekids = 0;
8010461a:	eb a1                	jmp    801045bd <wait+0x2d>
8010461c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80104620:	8b 43 08             	mov    0x8(%ebx),%eax
        pid = p->pid;
80104623:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104626:	89 04 24             	mov    %eax,(%esp)
80104629:	e8 b2 dd ff ff       	call   801023e0 <kfree>
        freevm(p->pgdir);
8010462e:	8b 43 04             	mov    0x4(%ebx),%eax
        p->kstack = 0;
80104631:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104638:	89 04 24             	mov    %eax,(%esp)
8010463b:	e8 70 3f 00 00       	call   801085b0 <freevm>
        if(status != null){ 
80104640:	85 ff                	test   %edi,%edi
        p->pid = 0;
80104642:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104649:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104650:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104654:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
8010465b:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        if(status != null){ 
80104662:	74 05                	je     80104669 <wait+0xd9>
            *status = p->exitStatus;
80104664:	8b 43 7c             	mov    0x7c(%ebx),%eax
80104667:	89 07                	mov    %eax,(%edi)
        release(&ptable.lock);
80104669:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104670:	e8 0b 16 00 00       	call   80105c80 <release>
}
80104675:	83 c4 1c             	add    $0x1c,%esp
80104678:	89 f0                	mov    %esi,%eax
8010467a:	5b                   	pop    %ebx
8010467b:	5e                   	pop    %esi
8010467c:	5f                   	pop    %edi
8010467d:	5d                   	pop    %ebp
8010467e:	c3                   	ret    
      release(&ptable.lock);
8010467f:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
      return -1;
80104686:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010468b:	e8 f0 15 00 00       	call   80105c80 <release>
      return -1;
80104690:	eb e3                	jmp    80104675 <wait+0xe5>
80104692:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046a0 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801046a0:	55                   	push   %ebp
801046a1:	89 e5                	mov    %esp,%ebp
801046a3:	53                   	push   %ebx
801046a4:	83 ec 14             	sub    $0x14,%esp
801046a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801046aa:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
801046b1:	e8 2a 15 00 00       	call   80105be0 <acquire>
  wakeup1(chan);
801046b6:	89 d8                	mov    %ebx,%eax
801046b8:	e8 63 f7 ff ff       	call   80103e20 <wakeup1>
  release(&ptable.lock);
801046bd:	c7 45 08 a0 4d 11 80 	movl   $0x80114da0,0x8(%ebp)
}
801046c4:	83 c4 14             	add    $0x14,%esp
801046c7:	5b                   	pop    %ebx
801046c8:	5d                   	pop    %ebp
  release(&ptable.lock);
801046c9:	e9 b2 15 00 00       	jmp    80105c80 <release>
801046ce:	66 90                	xchg   %ax,%ax

801046d0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801046d0:	55                   	push   %ebp
801046d1:	89 e5                	mov    %esp,%ebp
801046d3:	56                   	push   %esi
801046d4:	53                   	push   %ebx
  struct proc *p;
    
  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046d5:	bb d4 4d 11 80       	mov    $0x80114dd4,%ebx
{
801046da:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801046dd:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
{
801046e4:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&ptable.lock);
801046e7:	e8 f4 14 00 00       	call   80105be0 <acquire>
801046ec:	eb 10                	jmp    801046fe <kill+0x2e>
801046ee:	66 90                	xchg   %ax,%ax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046f0:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
801046f6:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
801046fc:	73 72                	jae    80104770 <kill+0xa0>
    if(p->pid == pid){
801046fe:	39 73 10             	cmp    %esi,0x10(%ebx)
80104701:	75 ed                	jne    801046f0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING){
80104703:	8b 43 0c             	mov    0xc(%ebx),%eax
      p->killed = 1;
80104706:	c7 43 24 01 00 00 00 	movl   $0x1,0x24(%ebx)
      if(p->state == SLEEPING){
8010470d:	83 f8 02             	cmp    $0x2,%eax
80104710:	74 1e                	je     80104730 <kill+0x60>
        if(POLICY == 1)
            rrq.enqueue(p);
        else
            pq.put(p);
      }
      release(&ptable.lock);
80104712:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104719:	e8 62 15 00 00       	call   80105c80 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
8010471e:	83 c4 10             	add    $0x10,%esp
      return 0;
80104721:	31 c0                	xor    %eax,%eax
}
80104723:	5b                   	pop    %ebx
80104724:	5e                   	pop    %esi
80104725:	5d                   	pop    %ebp
80104726:	c3                   	ret    
80104727:	89 f6                	mov    %esi,%esi
80104729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        p->timeStamp = tqCounter;
80104730:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
80104735:	8b 15 c4 c5 10 80    	mov    0x8010c5c4,%edx
        setAccumulator(p);  
8010473b:	89 1c 24             	mov    %ebx,(%esp)
        p->state = RUNNABLE;
8010473e:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
        p->timeStamp = tqCounter;
80104745:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
8010474b:	89 93 90 00 00 00    	mov    %edx,0x90(%ebx)
        setAccumulator(p);  
80104751:	e8 fa f2 ff ff       	call   80103a50 <setAccumulator>
        if(POLICY == 1)
80104756:	83 3d 08 c0 10 80 01 	cmpl   $0x1,0x8010c008
            rrq.enqueue(p);
8010475d:	89 1c 24             	mov    %ebx,(%esp)
        if(POLICY == 1)
80104760:	74 26                	je     80104788 <kill+0xb8>
            pq.put(p);
80104762:	ff 15 f0 c5 10 80    	call   *0x8010c5f0
80104768:	eb a8                	jmp    80104712 <kill+0x42>
8010476a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104770:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104777:	e8 04 15 00 00       	call   80105c80 <release>
}
8010477c:	83 c4 10             	add    $0x10,%esp
  return -1;
8010477f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104784:	5b                   	pop    %ebx
80104785:	5e                   	pop    %esi
80104786:	5d                   	pop    %ebp
80104787:	c3                   	ret    
            rrq.enqueue(p);
80104788:	ff 15 e0 c5 10 80    	call   *0x8010c5e0
8010478e:	eb 82                	jmp    80104712 <kill+0x42>

80104790 <detach>:

// transfer a child process with the given pid from the parent to the init process.
// return 0 when succseeds or -1 if the process has no child with this pid.
int
detach(int pid)
{ 
80104790:	55                   	push   %ebp
80104791:	89 e5                	mov    %esp,%ebp
80104793:	57                   	push   %edi
80104794:	56                   	push   %esi
80104795:	53                   	push   %ebx
80104796:	83 ec 2c             	sub    $0x2c,%esp
80104799:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
8010479c:	e8 5f 13 00 00       	call   80105b00 <pushcli>
  c = mycpu();
801047a1:	e8 5a f1 ff ff       	call   80103900 <mycpu>
  p = c->proc;
801047a6:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
801047ac:	e8 8f 13 00 00       	call   80105b40 <popcli>
  struct proc *curproc = myproc();
  struct proc *p;
  int procExist = -1;

  if(curproc == initproc)
801047b1:	39 3d c8 c5 10 80    	cmp    %edi,0x8010c5c8
801047b7:	74 7e                	je     80104837 <detach+0xa7>
    panic("init called detach");

  acquire(&ptable.lock);
801047b9:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801047c0:	bb d4 4d 11 80       	mov    $0x80114dd4,%ebx
  acquire(&ptable.lock);
801047c5:	e8 16 14 00 00       	call   80105be0 <acquire>
  int procExist = -1;
801047ca:	ba ff ff ff ff       	mov    $0xffffffff,%edx
801047cf:	eb 15                	jmp    801047e6 <detach+0x56>
801047d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801047d8:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
801047de:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
801047e4:	73 35                	jae    8010481b <detach+0x8b>
    if(p->pid == pid && p->parent == curproc){
801047e6:	39 73 10             	cmp    %esi,0x10(%ebx)
801047e9:	75 ed                	jne    801047d8 <detach+0x48>
801047eb:	39 7b 14             	cmp    %edi,0x14(%ebx)
801047ee:	75 e8                	jne    801047d8 <detach+0x48>
        procExist = 0;
        p->parent = initproc;
        if(p->state == ZOMBIE)
801047f0:	8b 4b 0c             	mov    0xc(%ebx),%ecx
        procExist = 0;
801047f3:	31 d2                	xor    %edx,%edx
        p->parent = initproc;
801047f5:	a1 c8 c5 10 80       	mov    0x8010c5c8,%eax
        if(p->state == ZOMBIE)
801047fa:	83 f9 05             	cmp    $0x5,%ecx
        p->parent = initproc;
801047fd:	89 43 14             	mov    %eax,0x14(%ebx)
        if(p->state == ZOMBIE)
80104800:	75 d6                	jne    801047d8 <detach+0x48>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104802:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80104808:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            wakeup1(initproc);
8010480b:	e8 10 f6 ff ff       	call   80103e20 <wakeup1>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104810:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
            wakeup1(initproc);
80104816:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104819:	72 cb                	jb     801047e6 <detach+0x56>
    }
  }
  release(&ptable.lock);
8010481b:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104822:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80104825:	e8 56 14 00 00       	call   80105c80 <release>
  return procExist;
}
8010482a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010482d:	83 c4 2c             	add    $0x2c,%esp
80104830:	5b                   	pop    %ebx
80104831:	5e                   	pop    %esi
80104832:	89 d0                	mov    %edx,%eax
80104834:	5f                   	pop    %edi
80104835:	5d                   	pop    %ebp
80104836:	c3                   	ret    
    panic("init called detach");
80104837:	c7 04 24 30 8f 10 80 	movl   $0x80108f30,(%esp)
8010483e:	e8 2d bb ff ff       	call   80100370 <panic>
80104843:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104850 <priority>:

// used by a process to change its priority
void
priority(int proc_priority)
{
80104850:	55                   	push   %ebp
80104851:	89 e5                	mov    %esp,%ebp
80104853:	83 ec 18             	sub    $0x18,%esp
80104856:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104859:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010485c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  pushcli();
8010485f:	e8 9c 12 00 00       	call   80105b00 <pushcli>
  c = mycpu();
80104864:	e8 97 f0 ff ff       	call   80103900 <mycpu>
  p = c->proc;
80104869:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
8010486f:	e8 cc 12 00 00       	call   80105b40 <popcli>
  struct proc *curproc = myproc();
  
  if(proc_priority <= 10 && proc_priority >= 0){
80104874:	83 fb 0a             	cmp    $0xa,%ebx
80104877:	77 13                	ja     8010488c <priority+0x3c>
      if(POLICY == 3 || (POLICY == 2 && proc_priority >= 1)){
80104879:	a1 08 c0 10 80       	mov    0x8010c008,%eax
8010487e:	83 f8 03             	cmp    $0x3,%eax
80104881:	74 1d                	je     801048a0 <priority+0x50>
80104883:	83 f8 02             	cmp    $0x2,%eax
80104886:	75 04                	jne    8010488c <priority+0x3c>
80104888:	85 db                	test   %ebx,%ebx
8010488a:	75 14                	jne    801048a0 <priority+0x50>
        acquire(&ptable.lock);
        curproc->priority = proc_priority;
        release(&ptable.lock); 
      }
  }
}
8010488c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010488f:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104892:	89 ec                	mov    %ebp,%esp
80104894:	5d                   	pop    %ebp
80104895:	c3                   	ret    
80104896:	8d 76 00             	lea    0x0(%esi),%esi
80104899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        acquire(&ptable.lock);
801048a0:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
801048a7:	e8 34 13 00 00       	call   80105be0 <acquire>
        curproc->priority = proc_priority;
801048ac:	89 9e 80 00 00 00    	mov    %ebx,0x80(%esi)
}
801048b2:	8b 5d f8             	mov    -0x8(%ebp),%ebx
        release(&ptable.lock); 
801048b5:	c7 45 08 a0 4d 11 80 	movl   $0x80114da0,0x8(%ebp)
}
801048bc:	8b 75 fc             	mov    -0x4(%ebp),%esi
801048bf:	89 ec                	mov    %ebp,%esp
801048c1:	5d                   	pop    %ebp
        release(&ptable.lock); 
801048c2:	e9 b9 13 00 00       	jmp    80105c80 <release>
801048c7:	89 f6                	mov    %esi,%esi
801048c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048d0 <policy>:

// receives a policy identifier as an argument and changes the currently used policy.
void
policy(int policy_id)
{
801048d0:	55                   	push   %ebp
801048d1:	89 e5                	mov    %esp,%ebp
801048d3:	56                   	push   %esi
801048d4:	53                   	push   %ebx
    struct proc *p;
    
    acquire(&ptable.lock);
           
    
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048d5:	bb d4 4d 11 80       	mov    $0x80114dd4,%ebx
{
801048da:	83 ec 10             	sub    $0x10,%esp
    acquire(&ptable.lock);
801048dd:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
{
801048e4:	8b 75 08             	mov    0x8(%ebp),%esi
    acquire(&ptable.lock);
801048e7:	e8 f4 12 00 00       	call   80105be0 <acquire>
801048ec:	eb 29                	jmp    80104917 <policy+0x47>
801048ee:	66 90                	xchg   %ax,%ax
        if(policy_id == 1 && (POLICY == 2 || POLICY == 3)){ /*change from Priority to Round Robin policy*/
            pq.switchToRoundRobinPolicy();
            p->accumulator = 0;
        }
        if(policy_id == 2){ 
801048f0:	83 fe 02             	cmp    $0x2,%esi
801048f3:	74 73                	je     80104968 <policy+0x98>
            }
            if(POLICY == 1){ /*change from Round Robin to Priority scheduling policy*/
                rrq.switchToPriorityQueuePolicy();
            }
        }
        if(policy_id == 3 && POLICY == 1){ /*change from Extended Priority to Round Robin policy*/
801048f5:	83 fe 03             	cmp    $0x3,%esi
801048f8:	75 0f                	jne    80104909 <policy+0x39>
801048fa:	83 3d 08 c0 10 80 01 	cmpl   $0x1,0x8010c008
80104901:	75 06                	jne    80104909 <policy+0x39>
            pq.switchToRoundRobinPolicy();
80104903:	ff 15 fc c5 10 80    	call   *0x8010c5fc
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104909:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
8010490f:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
80104915:	73 33                	jae    8010494a <policy+0x7a>
        if(policy_id == 1 && (POLICY == 2 || POLICY == 3)){ /*change from Priority to Round Robin policy*/
80104917:	83 fe 01             	cmp    $0x1,%esi
8010491a:	75 d4                	jne    801048f0 <policy+0x20>
8010491c:	a1 08 c0 10 80       	mov    0x8010c008,%eax
80104921:	83 e8 02             	sub    $0x2,%eax
80104924:	83 f8 01             	cmp    $0x1,%eax
80104927:	77 e0                	ja     80104909 <policy+0x39>
            pq.switchToRoundRobinPolicy();
80104929:	ff 15 fc c5 10 80    	call   *0x8010c5fc
            p->accumulator = 0;
8010492f:	31 c9                	xor    %ecx,%ecx
80104931:	31 c0                	xor    %eax,%eax
80104933:	89 8b 84 00 00 00    	mov    %ecx,0x84(%ebx)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104939:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
            p->accumulator = 0;
8010493f:	89 43 e0             	mov    %eax,-0x20(%ebx)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104942:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
80104948:	72 cd                	jb     80104917 <policy+0x47>
        }
    }
     POLICY = policy_id;
8010494a:	89 35 08 c0 10 80    	mov    %esi,0x8010c008
    release(&ptable.lock);
80104950:	c7 45 08 a0 4d 11 80 	movl   $0x80114da0,0x8(%ebp)
}
80104957:	83 c4 10             	add    $0x10,%esp
8010495a:	5b                   	pop    %ebx
8010495b:	5e                   	pop    %esi
8010495c:	5d                   	pop    %ebp
    release(&ptable.lock);
8010495d:	e9 1e 13 00 00       	jmp    80105c80 <release>
80104962:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            if(POLICY == 3){ /*change from Extended Priority to Priority scheduling policy*/
80104968:	a1 08 c0 10 80       	mov    0x8010c008,%eax
8010496d:	83 f8 03             	cmp    $0x3,%eax
80104970:	74 16                	je     80104988 <policy+0xb8>
            if(POLICY == 1){ /*change from Round Robin to Priority scheduling policy*/
80104972:	48                   	dec    %eax
80104973:	75 94                	jne    80104909 <policy+0x39>
                rrq.switchToPriorityQueuePolicy();
80104975:	ff 15 e8 c5 10 80    	call   *0x8010c5e8
8010497b:	90                   	nop
8010497c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104980:	eb 87                	jmp    80104909 <policy+0x39>
80104982:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                if(p->priority == 0){ 
80104988:	8b 93 80 00 00 00    	mov    0x80(%ebx),%edx
8010498e:	85 d2                	test   %edx,%edx
80104990:	0f 85 73 ff ff ff    	jne    80104909 <policy+0x39>
                    p->priority = 1;
80104996:	b8 01 00 00 00       	mov    $0x1,%eax
8010499b:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
801049a1:	e9 63 ff ff ff       	jmp    80104909 <policy+0x39>
801049a6:	8d 76 00             	lea    0x0(%esi),%esi
801049a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049b0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801049b0:	55                   	push   %ebp
801049b1:	89 e5                	mov    %esp,%ebp
801049b3:	57                   	push   %edi
801049b4:	56                   	push   %esi
801049b5:	53                   	push   %ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049b6:	bb d4 4d 11 80       	mov    $0x80114dd4,%ebx
{
801049bb:	83 ec 4c             	sub    $0x4c,%esp
801049be:	eb 1e                	jmp    801049de <procdump+0x2e>
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801049c0:	c7 04 24 cd 8f 10 80 	movl   $0x80108fcd,(%esp)
801049c7:	e8 84 bc ff ff       	call   80100650 <cprintf>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049cc:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
801049d2:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
801049d8:	0f 83 b2 00 00 00    	jae    80104a90 <procdump+0xe0>
    if(p->state == UNUSED)
801049de:	8b 43 0c             	mov    0xc(%ebx),%eax
801049e1:	85 c0                	test   %eax,%eax
801049e3:	74 e7                	je     801049cc <procdump+0x1c>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801049e5:	8b 43 0c             	mov    0xc(%ebx),%eax
      state = "???";
801049e8:	b8 43 8f 10 80       	mov    $0x80108f43,%eax
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801049ed:	8b 53 0c             	mov    0xc(%ebx),%edx
801049f0:	83 fa 05             	cmp    $0x5,%edx
801049f3:	77 18                	ja     80104a0d <procdump+0x5d>
801049f5:	8b 53 0c             	mov    0xc(%ebx),%edx
801049f8:	8b 14 95 a4 8f 10 80 	mov    -0x7fef705c(,%edx,4),%edx
801049ff:	85 d2                	test   %edx,%edx
80104a01:	74 0a                	je     80104a0d <procdump+0x5d>
      state = states[p->state];
80104a03:	8b 43 0c             	mov    0xc(%ebx),%eax
80104a06:	8b 04 85 a4 8f 10 80 	mov    -0x7fef705c(,%eax,4),%eax
    cprintf("%d %s %s", p->pid, state, p->name);
80104a0d:	89 44 24 08          	mov    %eax,0x8(%esp)
80104a11:	8b 43 10             	mov    0x10(%ebx),%eax
80104a14:	8d 53 6c             	lea    0x6c(%ebx),%edx
80104a17:	89 54 24 0c          	mov    %edx,0xc(%esp)
80104a1b:	c7 04 24 47 8f 10 80 	movl   $0x80108f47,(%esp)
80104a22:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a26:	e8 25 bc ff ff       	call   80100650 <cprintf>
    if(p->state == SLEEPING){
80104a2b:	8b 43 0c             	mov    0xc(%ebx),%eax
80104a2e:	83 f8 02             	cmp    $0x2,%eax
80104a31:	75 8d                	jne    801049c0 <procdump+0x10>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104a33:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104a36:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a3a:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104a3d:	8d 75 c0             	lea    -0x40(%ebp),%esi
80104a40:	8d 7d e8             	lea    -0x18(%ebp),%edi
80104a43:	8b 40 0c             	mov    0xc(%eax),%eax
80104a46:	83 c0 08             	add    $0x8,%eax
80104a49:	89 04 24             	mov    %eax,(%esp)
80104a4c:	e8 5f 10 00 00       	call   80105ab0 <getcallerpcs>
80104a51:	eb 0d                	jmp    80104a60 <procdump+0xb0>
80104a53:	90                   	nop
80104a54:	90                   	nop
80104a55:	90                   	nop
80104a56:	90                   	nop
80104a57:	90                   	nop
80104a58:	90                   	nop
80104a59:	90                   	nop
80104a5a:	90                   	nop
80104a5b:	90                   	nop
80104a5c:	90                   	nop
80104a5d:	90                   	nop
80104a5e:	90                   	nop
80104a5f:	90                   	nop
      for(i=0; i<10 && pc[i] != 0; i++)
80104a60:	8b 16                	mov    (%esi),%edx
80104a62:	85 d2                	test   %edx,%edx
80104a64:	0f 84 56 ff ff ff    	je     801049c0 <procdump+0x10>
        cprintf(" %p", pc[i]);
80104a6a:	89 54 24 04          	mov    %edx,0x4(%esp)
80104a6e:	83 c6 04             	add    $0x4,%esi
80104a71:	c7 04 24 21 89 10 80 	movl   $0x80108921,(%esp)
80104a78:	e8 d3 bb ff ff       	call   80100650 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104a7d:	39 f7                	cmp    %esi,%edi
80104a7f:	75 df                	jne    80104a60 <procdump+0xb0>
80104a81:	e9 3a ff ff ff       	jmp    801049c0 <procdump+0x10>
80104a86:	8d 76 00             	lea    0x0(%esi),%esi
80104a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }
}
80104a90:	83 c4 4c             	add    $0x4c,%esp
80104a93:	5b                   	pop    %ebx
80104a94:	5e                   	pop    %esi
80104a95:	5f                   	pop    %edi
80104a96:	5d                   	pop    %ebp
80104a97:	c3                   	ret    
80104a98:	90                   	nop
80104a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104aa0 <wait_stat>:

// Return the pid of the terminated child process or -1 upon failure.
int
wait_stat(int* status, struct perf * performance){
80104aa0:	55                   	push   %ebp
80104aa1:	89 e5                	mov    %esp,%ebp
80104aa3:	57                   	push   %edi
80104aa4:	56                   	push   %esi
80104aa5:	53                   	push   %ebx
80104aa6:	83 ec 1c             	sub    $0x1c,%esp
80104aa9:	8b 7d 0c             	mov    0xc(%ebp),%edi
  pushcli();
80104aac:	e8 4f 10 00 00       	call   80105b00 <pushcli>
  c = mycpu();
80104ab1:	e8 4a ee ff ff       	call   80103900 <mycpu>
  p = c->proc;
80104ab6:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104abc:	e8 7f 10 00 00       	call   80105b40 <popcli>
      struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();

  acquire(&ptable.lock);
80104ac1:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104ac8:	e8 13 11 00 00       	call   80105be0 <acquire>
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80104acd:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104acf:	bb d4 4d 11 80       	mov    $0x80114dd4,%ebx
80104ad4:	eb 18                	jmp    80104aee <wait_stat+0x4e>
80104ad6:	8d 76 00             	lea    0x0(%esi),%esi
80104ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104ae0:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80104ae6:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
80104aec:	73 20                	jae    80104b0e <wait_stat+0x6e>
      if(p->parent != curproc)
80104aee:	39 73 14             	cmp    %esi,0x14(%ebx)
80104af1:	75 ed                	jne    80104ae0 <wait_stat+0x40>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80104af3:	8b 43 0c             	mov    0xc(%ebx),%eax
80104af6:	83 f8 05             	cmp    $0x5,%eax
80104af9:	74 3d                	je     80104b38 <wait_stat+0x98>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104afb:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
      havekids = 1;
80104b01:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b06:	81 fb d4 77 11 80    	cmp    $0x801177d4,%ebx
80104b0c:	72 e0                	jb     80104aee <wait_stat+0x4e>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80104b0e:	85 c0                	test   %eax,%eax
80104b10:	0f 84 b7 00 00 00    	je     80104bcd <wait_stat+0x12d>
80104b16:	8b 56 24             	mov    0x24(%esi),%edx
80104b19:	85 d2                	test   %edx,%edx
80104b1b:	0f 85 ac 00 00 00    	jne    80104bcd <wait_stat+0x12d>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104b21:	b8 a0 4d 11 80       	mov    $0x80114da0,%eax
80104b26:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b2a:	89 34 24             	mov    %esi,(%esp)
80104b2d:	e8 6e f9 ff ff       	call   801044a0 <sleep>
    havekids = 0;
80104b32:	eb 99                	jmp    80104acd <wait_stat+0x2d>
80104b34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80104b38:	8b 43 08             	mov    0x8(%ebx),%eax
        pid = p->pid;
80104b3b:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104b3e:	89 04 24             	mov    %eax,(%esp)
80104b41:	e8 9a d8 ff ff       	call   801023e0 <kfree>
        freevm(p->pgdir);
80104b46:	8b 43 04             	mov    0x4(%ebx),%eax
        p->kstack = 0;
80104b49:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104b50:	89 04 24             	mov    %eax,(%esp)
80104b53:	e8 58 3a 00 00       	call   801085b0 <freevm>
        if(status != null){ 
80104b58:	8b 4d 08             	mov    0x8(%ebp),%ecx
        p->pid = 0;
80104b5b:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104b62:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104b69:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        if(status != null){ 
80104b6d:	85 c9                	test   %ecx,%ecx
        p->killed = 0;
80104b6f:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104b76:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        if(status != null){ 
80104b7d:	74 08                	je     80104b87 <wait_stat+0xe7>
            *status = p->exitStatus;
80104b7f:	8b 43 7c             	mov    0x7c(%ebx),%eax
80104b82:	8b 55 08             	mov    0x8(%ebp),%edx
80104b85:	89 02                	mov    %eax,(%edx)
        if(performance != null){ 
80104b87:	85 ff                	test   %edi,%edi
80104b89:	74 2c                	je     80104bb7 <wait_stat+0x117>
            *performance = p->performance;
80104b8b:	8b 83 94 00 00 00    	mov    0x94(%ebx),%eax
80104b91:	89 07                	mov    %eax,(%edi)
80104b93:	8b 83 98 00 00 00    	mov    0x98(%ebx),%eax
80104b99:	89 47 04             	mov    %eax,0x4(%edi)
80104b9c:	8b 83 9c 00 00 00    	mov    0x9c(%ebx),%eax
80104ba2:	89 47 08             	mov    %eax,0x8(%edi)
80104ba5:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80104bab:	89 47 0c             	mov    %eax,0xc(%edi)
80104bae:	8b 83 a4 00 00 00    	mov    0xa4(%ebx),%eax
80104bb4:	89 47 10             	mov    %eax,0x10(%edi)
        release(&ptable.lock);
80104bb7:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104bbe:	e8 bd 10 00 00       	call   80105c80 <release>
  }
}
80104bc3:	83 c4 1c             	add    $0x1c,%esp
80104bc6:	89 f0                	mov    %esi,%eax
80104bc8:	5b                   	pop    %ebx
80104bc9:	5e                   	pop    %esi
80104bca:	5f                   	pop    %edi
80104bcb:	5d                   	pop    %ebp
80104bcc:	c3                   	ret    
      release(&ptable.lock);
80104bcd:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
      return -1;
80104bd4:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104bd9:	e8 a2 10 00 00       	call   80105c80 <release>
      return -1;
80104bde:	eb e3                	jmp    80104bc3 <wait_stat+0x123>

80104be0 <updatePerformance>:

// increments performence to all proccesses that are running or sleeping
void updatePerformance(){
80104be0:	55                   	push   %ebp
80104be1:	89 e5                	mov    %esp,%ebp
80104be3:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  acquire(&ptable.lock);
80104be6:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104bed:	e8 ee 0f 00 00       	call   80105be0 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104bf2:	b8 d4 4d 11 80       	mov    $0x80114dd4,%eax
80104bf7:	89 f6                	mov    %esi,%esi
80104bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(p->state == RUNNABLE){
80104c00:	8b 50 0c             	mov    0xc(%eax),%edx
80104c03:	83 fa 03             	cmp    $0x3,%edx
80104c06:	75 06                	jne    80104c0e <updatePerformance+0x2e>
        p->performance.retime++;
80104c08:	ff 80 a0 00 00 00    	incl   0xa0(%eax)
    }
    if(p->state == RUNNING){
80104c0e:	8b 50 0c             	mov    0xc(%eax),%edx
80104c11:	83 fa 04             	cmp    $0x4,%edx
80104c14:	75 06                	jne    80104c1c <updatePerformance+0x3c>
      p->performance.rutime++;
80104c16:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
    }
    if(p->state == SLEEPING){
80104c1c:	8b 50 0c             	mov    0xc(%eax),%edx
80104c1f:	83 fa 02             	cmp    $0x2,%edx
80104c22:	75 06                	jne    80104c2a <updatePerformance+0x4a>
      p->performance.stime++;
80104c24:	ff 80 9c 00 00 00    	incl   0x9c(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c2a:	05 a8 00 00 00       	add    $0xa8,%eax
80104c2f:	3d d4 77 11 80       	cmp    $0x801177d4,%eax
80104c34:	72 ca                	jb     80104c00 <updatePerformance+0x20>
    }
  }
  release(&ptable.lock);
80104c36:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104c3d:	e8 3e 10 00 00       	call   80105c80 <release>
}
80104c42:	c9                   	leave  
80104c43:	c3                   	ret    
80104c44:	66 90                	xchg   %ax,%ax
80104c46:	66 90                	xchg   %ax,%ax
80104c48:	66 90                	xchg   %ax,%ax
80104c4a:	66 90                	xchg   %ax,%ax
80104c4c:	66 90                	xchg   %ax,%ax
80104c4e:	66 90                	xchg   %ax,%ax

80104c50 <isEmptyPriorityQueue>:
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
80104c50:	a1 1c c6 10 80       	mov    0x8010c61c,%eax
static boolean isEmptyPriorityQueue() {
80104c55:	55                   	push   %ebp
80104c56:	89 e5                	mov    %esp,%ebp
}
80104c58:	5d                   	pop    %ebp
	return !root;
80104c59:	8b 00                	mov    (%eax),%eax
80104c5b:	85 c0                	test   %eax,%eax
80104c5d:	0f 94 c0             	sete   %al
80104c60:	0f b6 c0             	movzbl %al,%eax
}
80104c63:	c3                   	ret    
80104c64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104c70 <getMinAccumulatorPriorityQueue>:
	return !root;
80104c70:	a1 1c c6 10 80       	mov    0x8010c61c,%eax
80104c75:	8b 10                	mov    (%eax),%edx
	
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
	if(isEmpty())
80104c77:	85 d2                	test   %edx,%edx
80104c79:	74 35                	je     80104cb0 <getMinAccumulatorPriorityQueue+0x40>
static boolean getMinAccumulatorPriorityQueue(long long* pkey) {
80104c7b:	55                   	push   %ebp
80104c7c:	89 e5                	mov    %esp,%ebp
80104c7e:	53                   	push   %ebx
80104c7f:	eb 09                	jmp    80104c8a <getMinAccumulatorPriorityQueue+0x1a>
80104c81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	while(minNode->left)
80104c88:	89 c2                	mov    %eax,%edx
80104c8a:	8b 42 18             	mov    0x18(%edx),%eax
80104c8d:	85 c0                	test   %eax,%eax
80104c8f:	75 f7                	jne    80104c88 <getMinAccumulatorPriorityQueue+0x18>
	*pkey = getMinNode()->key;
80104c91:	8b 45 08             	mov    0x8(%ebp),%eax
80104c94:	8b 5a 04             	mov    0x4(%edx),%ebx
80104c97:	8b 0a                	mov    (%edx),%ecx
80104c99:	89 58 04             	mov    %ebx,0x4(%eax)
80104c9c:	89 08                	mov    %ecx,(%eax)
80104c9e:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104ca3:	5b                   	pop    %ebx
80104ca4:	5d                   	pop    %ebp
80104ca5:	c3                   	ret    
80104ca6:	8d 76 00             	lea    0x0(%esi),%esi
80104ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	if(isEmpty())
80104cb0:	31 c0                	xor    %eax,%eax
}
80104cb2:	c3                   	ret    
80104cb3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104cc0 <isEmptyRoundRobinQueue>:
	return !first;
80104cc0:	a1 18 c6 10 80       	mov    0x8010c618,%eax
static boolean isEmptyRoundRobinQueue() {
80104cc5:	55                   	push   %ebp
80104cc6:	89 e5                	mov    %esp,%ebp
}
80104cc8:	5d                   	pop    %ebp
	return !first;
80104cc9:	8b 00                	mov    (%eax),%eax
80104ccb:	85 c0                	test   %eax,%eax
80104ccd:	0f 94 c0             	sete   %al
80104cd0:	0f b6 c0             	movzbl %al,%eax
}
80104cd3:	c3                   	ret    
80104cd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104cda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104ce0 <enqueueRoundRobinQueue>:
	if(!freeLinks)
80104ce0:	a1 10 c6 10 80       	mov    0x8010c610,%eax
80104ce5:	85 c0                	test   %eax,%eax
80104ce7:	74 47                	je     80104d30 <enqueueRoundRobinQueue+0x50>
static boolean enqueueRoundRobinQueue(Proc *p) {
80104ce9:	55                   	push   %ebp
	return roundRobinQ->enqueue(p);
80104cea:	8b 0d 18 c6 10 80    	mov    0x8010c618,%ecx
	freeLinks = freeLinks->next;
80104cf0:	8b 50 04             	mov    0x4(%eax),%edx
static boolean enqueueRoundRobinQueue(Proc *p) {
80104cf3:	89 e5                	mov    %esp,%ebp
	ans->next = null;
80104cf5:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
80104cfc:	89 15 10 c6 10 80    	mov    %edx,0x8010c610
	ans->p = p;
80104d02:	8b 55 08             	mov    0x8(%ebp),%edx
80104d05:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80104d07:	8b 11                	mov    (%ecx),%edx
80104d09:	85 d2                	test   %edx,%edx
80104d0b:	74 2b                	je     80104d38 <enqueueRoundRobinQueue+0x58>
	else last->next = link;
80104d0d:	8b 51 04             	mov    0x4(%ecx),%edx
80104d10:	89 42 04             	mov    %eax,0x4(%edx)
80104d13:	eb 05                	jmp    80104d1a <enqueueRoundRobinQueue+0x3a>
80104d15:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
80104d18:	89 d0                	mov    %edx,%eax
80104d1a:	8b 50 04             	mov    0x4(%eax),%edx
80104d1d:	85 d2                	test   %edx,%edx
80104d1f:	75 f7                	jne    80104d18 <enqueueRoundRobinQueue+0x38>
	last = link->getLast();
80104d21:	89 41 04             	mov    %eax,0x4(%ecx)
80104d24:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104d29:	5d                   	pop    %ebp
80104d2a:	c3                   	ret    
80104d2b:	90                   	nop
80104d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!freeLinks)
80104d30:	31 c0                	xor    %eax,%eax
}
80104d32:	c3                   	ret    
80104d33:	90                   	nop
80104d34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
80104d38:	89 01                	mov    %eax,(%ecx)
80104d3a:	eb de                	jmp    80104d1a <enqueueRoundRobinQueue+0x3a>
80104d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104d40 <dequeueRoundRobinQueue>:
	return roundRobinQ->dequeue();
80104d40:	8b 0d 18 c6 10 80    	mov    0x8010c618,%ecx
	return !first;
80104d46:	8b 11                	mov    (%ecx),%edx
	if(isEmpty())
80104d48:	85 d2                	test   %edx,%edx
80104d4a:	74 3c                	je     80104d88 <dequeueRoundRobinQueue+0x48>
static Proc* dequeueRoundRobinQueue() {
80104d4c:	55                   	push   %ebp
80104d4d:	89 e5                	mov    %esp,%ebp
80104d4f:	83 ec 08             	sub    $0x8,%esp
80104d52:	89 75 fc             	mov    %esi,-0x4(%ebp)
	link->next = freeLinks;
80104d55:	8b 35 10 c6 10 80    	mov    0x8010c610,%esi
static Proc* dequeueRoundRobinQueue() {
80104d5b:	89 5d f8             	mov    %ebx,-0x8(%ebp)
	Link *next = first->next;
80104d5e:	8b 5a 04             	mov    0x4(%edx),%ebx
	Proc *p = first->p;
80104d61:	8b 02                	mov    (%edx),%eax
	link->next = freeLinks;
80104d63:	89 72 04             	mov    %esi,0x4(%edx)
	freeLinks = link;
80104d66:	89 15 10 c6 10 80    	mov    %edx,0x8010c610
	if(isEmpty())
80104d6c:	85 db                	test   %ebx,%ebx
	first = next;
80104d6e:	89 19                	mov    %ebx,(%ecx)
	if(isEmpty())
80104d70:	75 07                	jne    80104d79 <dequeueRoundRobinQueue+0x39>
		last = null;
80104d72:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
}
80104d79:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104d7c:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104d7f:	89 ec                	mov    %ebp,%esp
80104d81:	5d                   	pop    %ebp
80104d82:	c3                   	ret    
80104d83:	90                   	nop
80104d84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		return null;
80104d88:	31 c0                	xor    %eax,%eax
}
80104d8a:	c3                   	ret    
80104d8b:	90                   	nop
80104d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104d90 <isEmptyRunningProcessHolder>:
	return !first;
80104d90:	a1 14 c6 10 80       	mov    0x8010c614,%eax
static boolean isEmptyRunningProcessHolder() {
80104d95:	55                   	push   %ebp
80104d96:	89 e5                	mov    %esp,%ebp
}
80104d98:	5d                   	pop    %ebp
	return !first;
80104d99:	8b 00                	mov    (%eax),%eax
80104d9b:	85 c0                	test   %eax,%eax
80104d9d:	0f 94 c0             	sete   %al
80104da0:	0f b6 c0             	movzbl %al,%eax
}
80104da3:	c3                   	ret    
80104da4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104daa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104db0 <addRunningProcessHolder>:
	if(!freeLinks)
80104db0:	a1 10 c6 10 80       	mov    0x8010c610,%eax
80104db5:	85 c0                	test   %eax,%eax
80104db7:	74 47                	je     80104e00 <addRunningProcessHolder+0x50>
static boolean addRunningProcessHolder(Proc* p) {
80104db9:	55                   	push   %ebp
	return runningProcHolder->enqueue(p);
80104dba:	8b 0d 14 c6 10 80    	mov    0x8010c614,%ecx
	freeLinks = freeLinks->next;
80104dc0:	8b 50 04             	mov    0x4(%eax),%edx
static boolean addRunningProcessHolder(Proc* p) {
80104dc3:	89 e5                	mov    %esp,%ebp
	ans->next = null;
80104dc5:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
80104dcc:	89 15 10 c6 10 80    	mov    %edx,0x8010c610
	ans->p = p;
80104dd2:	8b 55 08             	mov    0x8(%ebp),%edx
80104dd5:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80104dd7:	8b 11                	mov    (%ecx),%edx
80104dd9:	85 d2                	test   %edx,%edx
80104ddb:	74 2b                	je     80104e08 <addRunningProcessHolder+0x58>
	else last->next = link;
80104ddd:	8b 51 04             	mov    0x4(%ecx),%edx
80104de0:	89 42 04             	mov    %eax,0x4(%edx)
80104de3:	eb 05                	jmp    80104dea <addRunningProcessHolder+0x3a>
80104de5:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
80104de8:	89 d0                	mov    %edx,%eax
80104dea:	8b 50 04             	mov    0x4(%eax),%edx
80104ded:	85 d2                	test   %edx,%edx
80104def:	75 f7                	jne    80104de8 <addRunningProcessHolder+0x38>
	last = link->getLast();
80104df1:	89 41 04             	mov    %eax,0x4(%ecx)
80104df4:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104df9:	5d                   	pop    %ebp
80104dfa:	c3                   	ret    
80104dfb:	90                   	nop
80104dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!freeLinks)
80104e00:	31 c0                	xor    %eax,%eax
}
80104e02:	c3                   	ret    
80104e03:	90                   	nop
80104e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
80104e08:	89 01                	mov    %eax,(%ecx)
80104e0a:	eb de                	jmp    80104dea <addRunningProcessHolder+0x3a>
80104e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104e10 <_ZL9allocNodeP4procx>:
static MapNode* allocNode(Proc *p, long long key) {
80104e10:	55                   	push   %ebp
80104e11:	89 e5                	mov    %esp,%ebp
80104e13:	56                   	push   %esi
80104e14:	53                   	push   %ebx
	if(!freeNodes)
80104e15:	8b 1d 0c c6 10 80    	mov    0x8010c60c,%ebx
80104e1b:	85 db                	test   %ebx,%ebx
80104e1d:	74 4d                	je     80104e6c <_ZL9allocNodeP4procx+0x5c>
	ans->key = key;
80104e1f:	89 13                	mov    %edx,(%ebx)
	if(!freeLinks)
80104e21:	8b 15 10 c6 10 80    	mov    0x8010c610,%edx
	freeNodes = freeNodes->next;
80104e27:	8b 73 10             	mov    0x10(%ebx),%esi
	ans->key = key;
80104e2a:	89 4b 04             	mov    %ecx,0x4(%ebx)
	ans->next = null;
80104e2d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
	if(!freeLinks)
80104e34:	85 d2                	test   %edx,%edx
	freeNodes = freeNodes->next;
80104e36:	89 35 0c c6 10 80    	mov    %esi,0x8010c60c
	if(!freeLinks)
80104e3c:	74 3f                	je     80104e7d <_ZL9allocNodeP4procx+0x6d>
	freeLinks = freeLinks->next;
80104e3e:	8b 4a 04             	mov    0x4(%edx),%ecx
	ans->p = p;
80104e41:	89 02                	mov    %eax,(%edx)
	ans->next = null;
80104e43:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
	if(isEmpty()) first = link;
80104e4a:	8b 43 08             	mov    0x8(%ebx),%eax
	freeLinks = freeLinks->next;
80104e4d:	89 0d 10 c6 10 80    	mov    %ecx,0x8010c610
	if(isEmpty()) first = link;
80104e53:	85 c0                	test   %eax,%eax
80104e55:	74 21                	je     80104e78 <_ZL9allocNodeP4procx+0x68>
	else last->next = link;
80104e57:	8b 43 0c             	mov    0xc(%ebx),%eax
80104e5a:	89 50 04             	mov    %edx,0x4(%eax)
80104e5d:	eb 03                	jmp    80104e62 <_ZL9allocNodeP4procx+0x52>
80104e5f:	90                   	nop
	while(ans->next)
80104e60:	89 ca                	mov    %ecx,%edx
80104e62:	8b 4a 04             	mov    0x4(%edx),%ecx
80104e65:	85 c9                	test   %ecx,%ecx
80104e67:	75 f7                	jne    80104e60 <_ZL9allocNodeP4procx+0x50>
	last = link->getLast();
80104e69:	89 53 0c             	mov    %edx,0xc(%ebx)
}
80104e6c:	89 d8                	mov    %ebx,%eax
80104e6e:	5b                   	pop    %ebx
80104e6f:	5e                   	pop    %esi
80104e70:	5d                   	pop    %ebp
80104e71:	c3                   	ret    
80104e72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	if(isEmpty()) first = link;
80104e78:	89 53 08             	mov    %edx,0x8(%ebx)
80104e7b:	eb e5                	jmp    80104e62 <_ZL9allocNodeP4procx+0x52>
	node->parent = node->left = node->right = null;
80104e7d:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
80104e84:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
80104e8b:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
	node->next = freeNodes;
80104e92:	89 73 10             	mov    %esi,0x10(%ebx)
	freeNodes = node;
80104e95:	89 1d 0c c6 10 80    	mov    %ebx,0x8010c60c
		return null;
80104e9b:	31 db                	xor    %ebx,%ebx
80104e9d:	eb cd                	jmp    80104e6c <_ZL9allocNodeP4procx+0x5c>
80104e9f:	90                   	nop

80104ea0 <_ZL8mymallocj>:
static char* mymalloc(uint size) {
80104ea0:	55                   	push   %ebp
80104ea1:	89 e5                	mov    %esp,%ebp
80104ea3:	53                   	push   %ebx
80104ea4:	89 c3                	mov    %eax,%ebx
80104ea6:	83 ec 14             	sub    $0x14,%esp
	if(spaceLeft < size) {
80104ea9:	8b 15 04 c6 10 80    	mov    0x8010c604,%edx
80104eaf:	39 c2                	cmp    %eax,%edx
80104eb1:	73 26                	jae    80104ed9 <_ZL8mymallocj+0x39>
		data = kalloc();
80104eb3:	e8 f8 d6 ff ff       	call   801025b0 <kalloc>
		memset(data, 0, PGSIZE);
80104eb8:	ba 00 10 00 00       	mov    $0x1000,%edx
80104ebd:	31 c9                	xor    %ecx,%ecx
80104ebf:	89 54 24 08          	mov    %edx,0x8(%esp)
80104ec3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80104ec7:	89 04 24             	mov    %eax,(%esp)
		data = kalloc();
80104eca:	a3 08 c6 10 80       	mov    %eax,0x8010c608
		memset(data, 0, PGSIZE);
80104ecf:	e8 fc 0d 00 00       	call   80105cd0 <memset>
80104ed4:	ba 00 10 00 00       	mov    $0x1000,%edx
	char* ans = data;
80104ed9:	a1 08 c6 10 80       	mov    0x8010c608,%eax
	spaceLeft -= size;
80104ede:	29 da                	sub    %ebx,%edx
80104ee0:	89 15 04 c6 10 80    	mov    %edx,0x8010c604
	data += size;
80104ee6:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80104ee9:	89 0d 08 c6 10 80    	mov    %ecx,0x8010c608
}
80104eef:	83 c4 14             	add    $0x14,%esp
80104ef2:	5b                   	pop    %ebx
80104ef3:	5d                   	pop    %ebp
80104ef4:	c3                   	ret    
80104ef5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f00 <initSchedDS>:
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104f00:	55                   	push   %ebp
	data               = null;
80104f01:	31 c0                	xor    %eax,%eax
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104f03:	89 e5                	mov    %esp,%ebp
80104f05:	53                   	push   %ebx
	freeLinks = null;
80104f06:	bb 80 00 00 00       	mov    $0x80,%ebx
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104f0b:	83 ec 04             	sub    $0x4,%esp
	data               = null;
80104f0e:	a3 08 c6 10 80       	mov    %eax,0x8010c608
	spaceLeft          = 0u;
80104f13:	31 c0                	xor    %eax,%eax
80104f15:	a3 04 c6 10 80       	mov    %eax,0x8010c604
	priorityQ          = (Map*)mymalloc(sizeof(Map));
80104f1a:	b8 04 00 00 00       	mov    $0x4,%eax
80104f1f:	e8 7c ff ff ff       	call   80104ea0 <_ZL8mymallocj>
80104f24:	a3 1c c6 10 80       	mov    %eax,0x8010c61c
	*priorityQ         = Map();
80104f29:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	roundRobinQ        = (LinkedList*)mymalloc(sizeof(LinkedList));
80104f2f:	b8 08 00 00 00       	mov    $0x8,%eax
80104f34:	e8 67 ff ff ff       	call   80104ea0 <_ZL8mymallocj>
80104f39:	a3 18 c6 10 80       	mov    %eax,0x8010c618
	*roundRobinQ       = LinkedList();
80104f3e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104f44:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	runningProcHolder  = (LinkedList*)mymalloc(sizeof(LinkedList));
80104f4b:	b8 08 00 00 00       	mov    $0x8,%eax
80104f50:	e8 4b ff ff ff       	call   80104ea0 <_ZL8mymallocj>
80104f55:	a3 14 c6 10 80       	mov    %eax,0x8010c614
	*runningProcHolder = LinkedList();
80104f5a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104f60:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = null;
80104f67:	31 c0                	xor    %eax,%eax
80104f69:	a3 10 c6 10 80       	mov    %eax,0x8010c610
80104f6e:	66 90                	xchg   %ax,%ax
		Link *link = (Link*)mymalloc(sizeof(Link));
80104f70:	b8 08 00 00 00       	mov    $0x8,%eax
80104f75:	e8 26 ff ff ff       	call   80104ea0 <_ZL8mymallocj>
		link->next = freeLinks;
80104f7a:	8b 15 10 c6 10 80    	mov    0x8010c610,%edx
	for(int i = 0; i < NPROCLIST; ++i) {
80104f80:	4b                   	dec    %ebx
		*link = Link();
80104f81:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		link->next = freeLinks;
80104f87:	89 50 04             	mov    %edx,0x4(%eax)
		freeLinks = link;
80104f8a:	a3 10 c6 10 80       	mov    %eax,0x8010c610
	for(int i = 0; i < NPROCLIST; ++i) {
80104f8f:	75 df                	jne    80104f70 <initSchedDS+0x70>
	freeNodes = null;
80104f91:	31 c0                	xor    %eax,%eax
80104f93:	bb 80 00 00 00       	mov    $0x80,%ebx
80104f98:	a3 0c c6 10 80       	mov    %eax,0x8010c60c
80104f9d:	8d 76 00             	lea    0x0(%esi),%esi
		MapNode *node = (MapNode*)mymalloc(sizeof(MapNode));
80104fa0:	b8 20 00 00 00       	mov    $0x20,%eax
80104fa5:	e8 f6 fe ff ff       	call   80104ea0 <_ZL8mymallocj>
		node->next = freeNodes;
80104faa:	8b 15 0c c6 10 80    	mov    0x8010c60c,%edx
	for(int i = 0; i < NPROCMAP; ++i) {
80104fb0:	4b                   	dec    %ebx
		*node = MapNode();
80104fb1:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80104fb8:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
80104fbf:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
80104fc6:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
80104fcd:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
		node->next = freeNodes;
80104fd4:	89 50 10             	mov    %edx,0x10(%eax)
		freeNodes = node;
80104fd7:	a3 0c c6 10 80       	mov    %eax,0x8010c60c
	for(int i = 0; i < NPROCMAP; ++i) {
80104fdc:	75 c2                	jne    80104fa0 <initSchedDS+0xa0>
	pq.isEmpty                      = isEmptyPriorityQueue;
80104fde:	b8 50 4c 10 80       	mov    $0x80104c50,%eax
	pq.put                          = putPriorityQueue;
80104fe3:	ba d0 55 10 80       	mov    $0x801055d0,%edx
	pq.isEmpty                      = isEmptyPriorityQueue;
80104fe8:	a3 ec c5 10 80       	mov    %eax,0x8010c5ec
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
80104fed:	b8 90 57 10 80       	mov    $0x80105790,%eax
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
80104ff2:	b9 70 4c 10 80       	mov    $0x80104c70,%ecx
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
80104ff7:	a3 fc c5 10 80       	mov    %eax,0x8010c5fc
	pq.extractProc                  = extractProcPriorityQueue;
80104ffc:	b8 70 58 10 80       	mov    $0x80105870,%eax
	pq.extractMin                   = extractMinPriorityQueue;
80105001:	bb f0 56 10 80       	mov    $0x801056f0,%ebx
	pq.extractProc                  = extractProcPriorityQueue;
80105006:	a3 00 c6 10 80       	mov    %eax,0x8010c600
	rrq.isEmpty                     = isEmptyRoundRobinQueue;
8010500b:	b8 c0 4c 10 80       	mov    $0x80104cc0,%eax
80105010:	a3 dc c5 10 80       	mov    %eax,0x8010c5dc
	rrq.enqueue                     = enqueueRoundRobinQueue;
80105015:	b8 e0 4c 10 80       	mov    $0x80104ce0,%eax
8010501a:	a3 e0 c5 10 80       	mov    %eax,0x8010c5e0
	rrq.dequeue                     = dequeueRoundRobinQueue;
8010501f:	b8 40 4d 10 80       	mov    $0x80104d40,%eax
80105024:	a3 e4 c5 10 80       	mov    %eax,0x8010c5e4
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
80105029:	b8 00 53 10 80       	mov    $0x80105300,%eax
	pq.put                          = putPriorityQueue;
8010502e:	89 15 f0 c5 10 80    	mov    %edx,0x8010c5f0
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
80105034:	ba 90 4d 10 80       	mov    $0x80104d90,%edx
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
80105039:	89 0d f4 c5 10 80    	mov    %ecx,0x8010c5f4
	rpholder.add                    = addRunningProcessHolder;
8010503f:	b9 b0 4d 10 80       	mov    $0x80104db0,%ecx
	pq.extractMin                   = extractMinPriorityQueue;
80105044:	89 1d f8 c5 10 80    	mov    %ebx,0x8010c5f8
	rpholder.remove                 = removeRunningProcessHolder;
8010504a:	bb 60 52 10 80       	mov    $0x80105260,%ebx
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
8010504f:	a3 e8 c5 10 80       	mov    %eax,0x8010c5e8
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
80105054:	b8 90 53 10 80       	mov    $0x80105390,%eax
	rpholder.remove                 = removeRunningProcessHolder;
80105059:	89 1d d4 c5 10 80    	mov    %ebx,0x8010c5d4
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
8010505f:	89 15 cc c5 10 80    	mov    %edx,0x8010c5cc
	rpholder.add                    = addRunningProcessHolder;
80105065:	89 0d d0 c5 10 80    	mov    %ecx,0x8010c5d0
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
8010506b:	a3 d8 c5 10 80       	mov    %eax,0x8010c5d8
}
80105070:	58                   	pop    %eax
80105071:	5b                   	pop    %ebx
80105072:	5d                   	pop    %ebp
80105073:	c3                   	ret    
80105074:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010507a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105080 <_ZN4Link7getLastEv>:
Link* Link::getLast() {
80105080:	55                   	push   %ebp
80105081:	89 e5                	mov    %esp,%ebp
80105083:	8b 45 08             	mov    0x8(%ebp),%eax
80105086:	eb 0a                	jmp    80105092 <_ZN4Link7getLastEv+0x12>
80105088:	90                   	nop
80105089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105090:	89 d0                	mov    %edx,%eax
	while(ans->next)
80105092:	8b 50 04             	mov    0x4(%eax),%edx
80105095:	85 d2                	test   %edx,%edx
80105097:	75 f7                	jne    80105090 <_ZN4Link7getLastEv+0x10>
}
80105099:	5d                   	pop    %ebp
8010509a:	c3                   	ret    
8010509b:	90                   	nop
8010509c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801050a0 <_ZN10LinkedList7isEmptyEv>:
bool LinkedList::isEmpty() {
801050a0:	55                   	push   %ebp
801050a1:	89 e5                	mov    %esp,%ebp
	return !first;
801050a3:	8b 45 08             	mov    0x8(%ebp),%eax
}
801050a6:	5d                   	pop    %ebp
	return !first;
801050a7:	8b 00                	mov    (%eax),%eax
801050a9:	85 c0                	test   %eax,%eax
801050ab:	0f 94 c0             	sete   %al
}
801050ae:	c3                   	ret    
801050af:	90                   	nop

801050b0 <_ZN10LinkedList6appendEP4Link>:
void LinkedList::append(Link *link) {
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	8b 55 0c             	mov    0xc(%ebp),%edx
801050b6:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!link)
801050b9:	85 d2                	test   %edx,%edx
801050bb:	74 1f                	je     801050dc <_ZN10LinkedList6appendEP4Link+0x2c>
	if(isEmpty()) first = link;
801050bd:	8b 01                	mov    (%ecx),%eax
801050bf:	85 c0                	test   %eax,%eax
801050c1:	74 1d                	je     801050e0 <_ZN10LinkedList6appendEP4Link+0x30>
	else last->next = link;
801050c3:	8b 41 04             	mov    0x4(%ecx),%eax
801050c6:	89 50 04             	mov    %edx,0x4(%eax)
801050c9:	eb 07                	jmp    801050d2 <_ZN10LinkedList6appendEP4Link+0x22>
801050cb:	90                   	nop
801050cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	while(ans->next)
801050d0:	89 c2                	mov    %eax,%edx
801050d2:	8b 42 04             	mov    0x4(%edx),%eax
801050d5:	85 c0                	test   %eax,%eax
801050d7:	75 f7                	jne    801050d0 <_ZN10LinkedList6appendEP4Link+0x20>
	last = link->getLast();
801050d9:	89 51 04             	mov    %edx,0x4(%ecx)
}
801050dc:	5d                   	pop    %ebp
801050dd:	c3                   	ret    
801050de:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
801050e0:	89 11                	mov    %edx,(%ecx)
801050e2:	eb ee                	jmp    801050d2 <_ZN10LinkedList6appendEP4Link+0x22>
801050e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801050ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801050f0 <_ZN10LinkedList7enqueueEP4proc>:
	if(!freeLinks)
801050f0:	a1 10 c6 10 80       	mov    0x8010c610,%eax
bool LinkedList::enqueue(Proc *p) {
801050f5:	55                   	push   %ebp
801050f6:	89 e5                	mov    %esp,%ebp
801050f8:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!freeLinks)
801050fb:	85 c0                	test   %eax,%eax
801050fd:	74 41                	je     80105140 <_ZN10LinkedList7enqueueEP4proc+0x50>
	freeLinks = freeLinks->next;
801050ff:	8b 50 04             	mov    0x4(%eax),%edx
	ans->next = null;
80105102:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
80105109:	89 15 10 c6 10 80    	mov    %edx,0x8010c610
	ans->p = p;
8010510f:	8b 55 0c             	mov    0xc(%ebp),%edx
80105112:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80105114:	8b 11                	mov    (%ecx),%edx
80105116:	85 d2                	test   %edx,%edx
80105118:	74 2e                	je     80105148 <_ZN10LinkedList7enqueueEP4proc+0x58>
	else last->next = link;
8010511a:	8b 51 04             	mov    0x4(%ecx),%edx
8010511d:	89 42 04             	mov    %eax,0x4(%edx)
80105120:	eb 08                	jmp    8010512a <_ZN10LinkedList7enqueueEP4proc+0x3a>
80105122:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	while(ans->next)
80105128:	89 d0                	mov    %edx,%eax
8010512a:	8b 50 04             	mov    0x4(%eax),%edx
8010512d:	85 d2                	test   %edx,%edx
8010512f:	75 f7                	jne    80105128 <_ZN10LinkedList7enqueueEP4proc+0x38>
	last = link->getLast();
80105131:	89 41 04             	mov    %eax,0x4(%ecx)
	return true;
80105134:	b0 01                	mov    $0x1,%al
}
80105136:	5d                   	pop    %ebp
80105137:	c3                   	ret    
80105138:	90                   	nop
80105139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return false;
80105140:	31 c0                	xor    %eax,%eax
}
80105142:	5d                   	pop    %ebp
80105143:	c3                   	ret    
80105144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
80105148:	89 01                	mov    %eax,(%ecx)
8010514a:	eb de                	jmp    8010512a <_ZN10LinkedList7enqueueEP4proc+0x3a>
8010514c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105150 <_ZN10LinkedList7dequeueEv>:
Proc* LinkedList::dequeue() {
80105150:	55                   	push   %ebp
80105151:	89 e5                	mov    %esp,%ebp
80105153:	83 ec 08             	sub    $0x8,%esp
80105156:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105159:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010515c:	89 75 fc             	mov    %esi,-0x4(%ebp)
	return !first;
8010515f:	8b 11                	mov    (%ecx),%edx
	if(isEmpty())
80105161:	85 d2                	test   %edx,%edx
80105163:	74 2b                	je     80105190 <_ZN10LinkedList7dequeueEv+0x40>
	Link *next = first->next;
80105165:	8b 5a 04             	mov    0x4(%edx),%ebx
	link->next = freeLinks;
80105168:	8b 35 10 c6 10 80    	mov    0x8010c610,%esi
	Proc *p = first->p;
8010516e:	8b 02                	mov    (%edx),%eax
	freeLinks = link;
80105170:	89 15 10 c6 10 80    	mov    %edx,0x8010c610
	if(isEmpty())
80105176:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
80105178:	89 72 04             	mov    %esi,0x4(%edx)
	first = next;
8010517b:	89 19                	mov    %ebx,(%ecx)
	if(isEmpty())
8010517d:	75 07                	jne    80105186 <_ZN10LinkedList7dequeueEv+0x36>
		last = null;
8010517f:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
}
80105186:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105189:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010518c:	89 ec                	mov    %ebp,%esp
8010518e:	5d                   	pop    %ebp
8010518f:	c3                   	ret    
		return null;
80105190:	31 c0                	xor    %eax,%eax
80105192:	eb f2                	jmp    80105186 <_ZN10LinkedList7dequeueEv+0x36>
80105194:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010519a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801051a0 <_ZN10LinkedList6removeEP4proc>:
bool LinkedList::remove(Proc *p) {
801051a0:	55                   	push   %ebp
801051a1:	89 e5                	mov    %esp,%ebp
801051a3:	56                   	push   %esi
801051a4:	8b 75 08             	mov    0x8(%ebp),%esi
801051a7:	53                   	push   %ebx
801051a8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
	return !first;
801051ab:	8b 1e                	mov    (%esi),%ebx
	if(isEmpty())
801051ad:	85 db                	test   %ebx,%ebx
801051af:	74 2f                	je     801051e0 <_ZN10LinkedList6removeEP4proc+0x40>
	if(first->p == p) {
801051b1:	39 0b                	cmp    %ecx,(%ebx)
801051b3:	8b 53 04             	mov    0x4(%ebx),%edx
801051b6:	74 70                	je     80105228 <_ZN10LinkedList6removeEP4proc+0x88>
	while(cur) {
801051b8:	85 d2                	test   %edx,%edx
801051ba:	74 24                	je     801051e0 <_ZN10LinkedList6removeEP4proc+0x40>
		if(cur->p == p) {
801051bc:	3b 0a                	cmp    (%edx),%ecx
801051be:	66 90                	xchg   %ax,%ax
801051c0:	75 0c                	jne    801051ce <_ZN10LinkedList6removeEP4proc+0x2e>
801051c2:	eb 2c                	jmp    801051f0 <_ZN10LinkedList6removeEP4proc+0x50>
801051c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801051c8:	39 08                	cmp    %ecx,(%eax)
801051ca:	74 34                	je     80105200 <_ZN10LinkedList6removeEP4proc+0x60>
801051cc:	89 c2                	mov    %eax,%edx
		cur = cur->next;
801051ce:	8b 42 04             	mov    0x4(%edx),%eax
	while(cur) {
801051d1:	85 c0                	test   %eax,%eax
801051d3:	75 f3                	jne    801051c8 <_ZN10LinkedList6removeEP4proc+0x28>
}
801051d5:	5b                   	pop    %ebx
801051d6:	5e                   	pop    %esi
801051d7:	5d                   	pop    %ebp
801051d8:	c3                   	ret    
801051d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051e0:	5b                   	pop    %ebx
		return false;
801051e1:	31 c0                	xor    %eax,%eax
}
801051e3:	5e                   	pop    %esi
801051e4:	5d                   	pop    %ebp
801051e5:	c3                   	ret    
801051e6:	8d 76 00             	lea    0x0(%esi),%esi
801051e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		if(cur->p == p) {
801051f0:	89 d0                	mov    %edx,%eax
801051f2:	89 da                	mov    %ebx,%edx
801051f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801051fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
			prev->next = cur->next;
80105200:	8b 48 04             	mov    0x4(%eax),%ecx
80105203:	89 4a 04             	mov    %ecx,0x4(%edx)
			if(!(cur->next)) //removes the last link
80105206:	8b 48 04             	mov    0x4(%eax),%ecx
80105209:	85 c9                	test   %ecx,%ecx
8010520b:	74 43                	je     80105250 <_ZN10LinkedList6removeEP4proc+0xb0>
	link->next = freeLinks;
8010520d:	8b 15 10 c6 10 80    	mov    0x8010c610,%edx
	freeLinks = link;
80105213:	a3 10 c6 10 80       	mov    %eax,0x8010c610
	link->next = freeLinks;
80105218:	89 50 04             	mov    %edx,0x4(%eax)
			return true;
8010521b:	b0 01                	mov    $0x1,%al
}
8010521d:	5b                   	pop    %ebx
8010521e:	5e                   	pop    %esi
8010521f:	5d                   	pop    %ebp
80105220:	c3                   	ret    
80105221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	link->next = freeLinks;
80105228:	a1 10 c6 10 80       	mov    0x8010c610,%eax
	if(isEmpty())
8010522d:	85 d2                	test   %edx,%edx
	freeLinks = link;
8010522f:	89 1d 10 c6 10 80    	mov    %ebx,0x8010c610
	link->next = freeLinks;
80105235:	89 43 04             	mov    %eax,0x4(%ebx)
		return true;
80105238:	b0 01                	mov    $0x1,%al
	first = next;
8010523a:	89 16                	mov    %edx,(%esi)
	if(isEmpty())
8010523c:	75 97                	jne    801051d5 <_ZN10LinkedList6removeEP4proc+0x35>
		last = null;
8010523e:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%esi)
80105245:	eb 8e                	jmp    801051d5 <_ZN10LinkedList6removeEP4proc+0x35>
80105247:	89 f6                	mov    %esi,%esi
80105249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
				last = prev;
80105250:	89 56 04             	mov    %edx,0x4(%esi)
80105253:	eb b8                	jmp    8010520d <_ZN10LinkedList6removeEP4proc+0x6d>
80105255:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105260 <removeRunningProcessHolder>:
static boolean removeRunningProcessHolder(Proc* p) {
80105260:	55                   	push   %ebp
80105261:	89 e5                	mov    %esp,%ebp
80105263:	83 ec 08             	sub    $0x8,%esp
	return runningProcHolder->remove(p);
80105266:	8b 45 08             	mov    0x8(%ebp),%eax
80105269:	89 44 24 04          	mov    %eax,0x4(%esp)
8010526d:	a1 14 c6 10 80       	mov    0x8010c614,%eax
80105272:	89 04 24             	mov    %eax,(%esp)
80105275:	e8 26 ff ff ff       	call   801051a0 <_ZN10LinkedList6removeEP4proc>
}
8010527a:	c9                   	leave  
	return runningProcHolder->remove(p);
8010527b:	0f b6 c0             	movzbl %al,%eax
}
8010527e:	c3                   	ret    
8010527f:	90                   	nop

80105280 <_ZN10LinkedList8transferEv>:
	if(!priorityQ->isEmpty())
80105280:	8b 15 1c c6 10 80    	mov    0x8010c61c,%edx
		return false;
80105286:	31 c0                	xor    %eax,%eax
bool LinkedList::transfer() {
80105288:	55                   	push   %ebp
80105289:	89 e5                	mov    %esp,%ebp
8010528b:	53                   	push   %ebx
8010528c:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!priorityQ->isEmpty())
8010528f:	8b 1a                	mov    (%edx),%ebx
80105291:	85 db                	test   %ebx,%ebx
80105293:	74 0b                	je     801052a0 <_ZN10LinkedList8transferEv+0x20>
}
80105295:	5b                   	pop    %ebx
80105296:	5d                   	pop    %ebp
80105297:	c3                   	ret    
80105298:	90                   	nop
80105299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	if(!isEmpty()) {
801052a0:	8b 19                	mov    (%ecx),%ebx
801052a2:	85 db                	test   %ebx,%ebx
801052a4:	74 4a                	je     801052f0 <_ZN10LinkedList8transferEv+0x70>
	if(!freeNodes)
801052a6:	8b 1d 0c c6 10 80    	mov    0x8010c60c,%ebx
801052ac:	85 db                	test   %ebx,%ebx
801052ae:	74 e5                	je     80105295 <_ZN10LinkedList8transferEv+0x15>
	freeNodes = freeNodes->next;
801052b0:	8b 43 10             	mov    0x10(%ebx),%eax
	ans->key = key;
801052b3:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
	ans->next = null;
801052b9:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
	ans->key = key;
801052c0:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
	freeNodes = freeNodes->next;
801052c7:	a3 0c c6 10 80       	mov    %eax,0x8010c60c
		node->listOfProcs.first = first;
801052cc:	8b 01                	mov    (%ecx),%eax
801052ce:	89 43 08             	mov    %eax,0x8(%ebx)
		node->listOfProcs.last = last;
801052d1:	8b 41 04             	mov    0x4(%ecx),%eax
801052d4:	89 43 0c             	mov    %eax,0xc(%ebx)
	return true;
801052d7:	b0 01                	mov    $0x1,%al
		first = last = null;
801052d9:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
801052e0:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
		priorityQ->root = node;
801052e6:	89 1a                	mov    %ebx,(%edx)
}
801052e8:	5b                   	pop    %ebx
801052e9:	5d                   	pop    %ebp
801052ea:	c3                   	ret    
801052eb:	90                   	nop
801052ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	return true;
801052f0:	b0 01                	mov    $0x1,%al
801052f2:	eb a1                	jmp    80105295 <_ZN10LinkedList8transferEv+0x15>
801052f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801052fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105300 <switchToPriorityQueuePolicyRoundRobinQueue>:
static boolean switchToPriorityQueuePolicyRoundRobinQueue() {
80105300:	55                   	push   %ebp
80105301:	89 e5                	mov    %esp,%ebp
80105303:	83 ec 04             	sub    $0x4,%esp
	return roundRobinQ->transfer();
80105306:	a1 18 c6 10 80       	mov    0x8010c618,%eax
8010530b:	89 04 24             	mov    %eax,(%esp)
8010530e:	e8 6d ff ff ff       	call   80105280 <_ZN10LinkedList8transferEv>
}
80105313:	c9                   	leave  
	return roundRobinQ->transfer();
80105314:	0f b6 c0             	movzbl %al,%eax
}
80105317:	c3                   	ret    
80105318:	90                   	nop
80105319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105320 <_ZN10LinkedList9getMinKeyEPx>:
bool LinkedList::getMinKey(long long *pkey) {
80105320:	55                   	push   %ebp
80105321:	31 c0                	xor    %eax,%eax
80105323:	89 e5                	mov    %esp,%ebp
80105325:	57                   	push   %edi
80105326:	56                   	push   %esi
80105327:	53                   	push   %ebx
80105328:	83 ec 1c             	sub    $0x1c,%esp
8010532b:	8b 7d 08             	mov    0x8(%ebp),%edi
	return !first;
8010532e:	8b 17                	mov    (%edi),%edx
	if(isEmpty())
80105330:	85 d2                	test   %edx,%edx
80105332:	74 41                	je     80105375 <_ZN10LinkedList9getMinKeyEPx+0x55>
	long long minKey = getAccumulator(first->p);
80105334:	8b 02                	mov    (%edx),%eax
80105336:	89 04 24             	mov    %eax,(%esp)
80105339:	e8 82 e5 ff ff       	call   801038c0 <getAccumulator>
	forEach([&](Proc *p) {
8010533e:	8b 3f                	mov    (%edi),%edi
	void append(Link *link); //appends the given list to the queue. No allocations always succeeds.
	
	template<typename Func>
	void forEach(const Func& accept) { //for-each loop. gets a function that applies the procin each link node.
		Link *link = first;
		while(link) {
80105340:	85 ff                	test   %edi,%edi
	long long minKey = getAccumulator(first->p);
80105342:	89 c6                	mov    %eax,%esi
80105344:	89 d3                	mov    %edx,%ebx
80105346:	74 23                	je     8010536b <_ZN10LinkedList9getMinKeyEPx+0x4b>
80105348:	90                   	nop
80105349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		long long key = getAccumulator(p);
80105350:	8b 07                	mov    (%edi),%eax
80105352:	89 04 24             	mov    %eax,(%esp)
80105355:	e8 66 e5 ff ff       	call   801038c0 <getAccumulator>
8010535a:	39 d3                	cmp    %edx,%ebx
8010535c:	7c 06                	jl     80105364 <_ZN10LinkedList9getMinKeyEPx+0x44>
8010535e:	7f 20                	jg     80105380 <_ZN10LinkedList9getMinKeyEPx+0x60>
80105360:	39 c6                	cmp    %eax,%esi
80105362:	77 1c                	ja     80105380 <_ZN10LinkedList9getMinKeyEPx+0x60>
			accept(link->p);
			link = link->next;
80105364:	8b 7f 04             	mov    0x4(%edi),%edi
		while(link) {
80105367:	85 ff                	test   %edi,%edi
80105369:	75 e5                	jne    80105350 <_ZN10LinkedList9getMinKeyEPx+0x30>
	*pkey = minKey;
8010536b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010536e:	89 30                	mov    %esi,(%eax)
80105370:	89 58 04             	mov    %ebx,0x4(%eax)
	return true;
80105373:	b0 01                	mov    $0x1,%al
}
80105375:	83 c4 1c             	add    $0x1c,%esp
80105378:	5b                   	pop    %ebx
80105379:	5e                   	pop    %esi
8010537a:	5f                   	pop    %edi
8010537b:	5d                   	pop    %ebp
8010537c:	c3                   	ret    
8010537d:	8d 76 00             	lea    0x0(%esi),%esi
			link = link->next;
80105380:	8b 7f 04             	mov    0x4(%edi),%edi
80105383:	89 c6                	mov    %eax,%esi
80105385:	89 d3                	mov    %edx,%ebx
		while(link) {
80105387:	85 ff                	test   %edi,%edi
80105389:	75 c5                	jne    80105350 <_ZN10LinkedList9getMinKeyEPx+0x30>
8010538b:	eb de                	jmp    8010536b <_ZN10LinkedList9getMinKeyEPx+0x4b>
8010538d:	8d 76 00             	lea    0x0(%esi),%esi

80105390 <getMinAccumulatorRunningProcessHolder>:
static boolean getMinAccumulatorRunningProcessHolder(long long *pkey) {
80105390:	55                   	push   %ebp
80105391:	89 e5                	mov    %esp,%ebp
80105393:	83 ec 18             	sub    $0x18,%esp
	return runningProcHolder->getMinKey(pkey);
80105396:	8b 45 08             	mov    0x8(%ebp),%eax
80105399:	89 44 24 04          	mov    %eax,0x4(%esp)
8010539d:	a1 14 c6 10 80       	mov    0x8010c614,%eax
801053a2:	89 04 24             	mov    %eax,(%esp)
801053a5:	e8 76 ff ff ff       	call   80105320 <_ZN10LinkedList9getMinKeyEPx>
}
801053aa:	c9                   	leave  
	return runningProcHolder->getMinKey(pkey);
801053ab:	0f b6 c0             	movzbl %al,%eax
}
801053ae:	c3                   	ret    
801053af:	90                   	nop

801053b0 <_ZN7MapNode7isEmptyEv>:
bool MapNode::isEmpty() {
801053b0:	55                   	push   %ebp
801053b1:	89 e5                	mov    %esp,%ebp
	return !first;
801053b3:	8b 45 08             	mov    0x8(%ebp),%eax
}
801053b6:	5d                   	pop    %ebp
	return !first;
801053b7:	8b 40 08             	mov    0x8(%eax),%eax
801053ba:	85 c0                	test   %eax,%eax
801053bc:	0f 94 c0             	sete   %al
}
801053bf:	c3                   	ret    

801053c0 <_ZN7MapNode3putEP4proc>:
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
801053c0:	55                   	push   %ebp
801053c1:	89 e5                	mov    %esp,%ebp
801053c3:	57                   	push   %edi
801053c4:	56                   	push   %esi
801053c5:	53                   	push   %ebx
801053c6:	83 ec 2c             	sub    $0x2c,%esp
	long long key = getAccumulator(p);
801053c9:	8b 45 0c             	mov    0xc(%ebp),%eax
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
801053cc:	8b 5d 08             	mov    0x8(%ebp),%ebx
	long long key = getAccumulator(p);
801053cf:	89 04 24             	mov    %eax,(%esp)
801053d2:	e8 e9 e4 ff ff       	call   801038c0 <getAccumulator>
801053d7:	89 d1                	mov    %edx,%ecx
801053d9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801053dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		if(key == node->key)
801053e0:	8b 13                	mov    (%ebx),%edx
801053e2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801053e5:	8b 43 04             	mov    0x4(%ebx),%eax
801053e8:	31 d7                	xor    %edx,%edi
801053ea:	89 fe                	mov    %edi,%esi
801053ec:	89 c7                	mov    %eax,%edi
801053ee:	31 cf                	xor    %ecx,%edi
801053f0:	09 fe                	or     %edi,%esi
801053f2:	74 4c                	je     80105440 <_ZN7MapNode3putEP4proc+0x80>
		else if(key < node->key) { //left
801053f4:	39 c8                	cmp    %ecx,%eax
801053f6:	7c 20                	jl     80105418 <_ZN7MapNode3putEP4proc+0x58>
801053f8:	7f 08                	jg     80105402 <_ZN7MapNode3putEP4proc+0x42>
801053fa:	3b 55 e4             	cmp    -0x1c(%ebp),%edx
801053fd:	8d 76 00             	lea    0x0(%esi),%esi
80105400:	76 16                	jbe    80105418 <_ZN7MapNode3putEP4proc+0x58>
			if(node->left)
80105402:	8b 43 18             	mov    0x18(%ebx),%eax
80105405:	85 c0                	test   %eax,%eax
80105407:	0f 84 83 00 00 00    	je     80105490 <_ZN7MapNode3putEP4proc+0xd0>
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
8010540d:	89 c3                	mov    %eax,%ebx
8010540f:	eb cf                	jmp    801053e0 <_ZN7MapNode3putEP4proc+0x20>
80105411:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			if(node->right)
80105418:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010541b:	85 c0                	test   %eax,%eax
8010541d:	75 ee                	jne    8010540d <_ZN7MapNode3putEP4proc+0x4d>
8010541f:	8b 75 e4             	mov    -0x1c(%ebp),%esi
				node->right = allocNode(p, key);
80105422:	8b 45 0c             	mov    0xc(%ebp),%eax
80105425:	89 f2                	mov    %esi,%edx
80105427:	e8 e4 f9 ff ff       	call   80104e10 <_ZL9allocNodeP4procx>
				if(node->right) {
8010542c:	85 c0                	test   %eax,%eax
				node->right = allocNode(p, key);
8010542e:	89 43 1c             	mov    %eax,0x1c(%ebx)
				if(node->right) {
80105431:	74 71                	je     801054a4 <_ZN7MapNode3putEP4proc+0xe4>
					node->right->parent = node;
80105433:	89 58 14             	mov    %ebx,0x14(%eax)
}
80105436:	83 c4 2c             	add    $0x2c,%esp
					return true;
80105439:	b0 01                	mov    $0x1,%al
}
8010543b:	5b                   	pop    %ebx
8010543c:	5e                   	pop    %esi
8010543d:	5f                   	pop    %edi
8010543e:	5d                   	pop    %ebp
8010543f:	c3                   	ret    
	if(!freeLinks)
80105440:	a1 10 c6 10 80       	mov    0x8010c610,%eax
80105445:	85 c0                	test   %eax,%eax
80105447:	74 5b                	je     801054a4 <_ZN7MapNode3putEP4proc+0xe4>
	ans->p = p;
80105449:	8b 75 0c             	mov    0xc(%ebp),%esi
	freeLinks = freeLinks->next;
8010544c:	8b 50 04             	mov    0x4(%eax),%edx
	ans->next = null;
8010544f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	ans->p = p;
80105456:	89 30                	mov    %esi,(%eax)
	freeLinks = freeLinks->next;
80105458:	89 15 10 c6 10 80    	mov    %edx,0x8010c610
	if(isEmpty()) first = link;
8010545e:	8b 53 08             	mov    0x8(%ebx),%edx
80105461:	85 d2                	test   %edx,%edx
80105463:	74 4b                	je     801054b0 <_ZN7MapNode3putEP4proc+0xf0>
	else last->next = link;
80105465:	8b 53 0c             	mov    0xc(%ebx),%edx
80105468:	89 42 04             	mov    %eax,0x4(%edx)
8010546b:	eb 05                	jmp    80105472 <_ZN7MapNode3putEP4proc+0xb2>
8010546d:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
80105470:	89 d0                	mov    %edx,%eax
80105472:	8b 50 04             	mov    0x4(%eax),%edx
80105475:	85 d2                	test   %edx,%edx
80105477:	75 f7                	jne    80105470 <_ZN7MapNode3putEP4proc+0xb0>
	last = link->getLast();
80105479:	89 43 0c             	mov    %eax,0xc(%ebx)
}
8010547c:	83 c4 2c             	add    $0x2c,%esp
	return true;
8010547f:	b0 01                	mov    $0x1,%al
}
80105481:	5b                   	pop    %ebx
80105482:	5e                   	pop    %esi
80105483:	5f                   	pop    %edi
80105484:	5d                   	pop    %ebp
80105485:	c3                   	ret    
80105486:	8d 76 00             	lea    0x0(%esi),%esi
80105489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105490:	8b 75 e4             	mov    -0x1c(%ebp),%esi
				node->left = allocNode(p, key);
80105493:	8b 45 0c             	mov    0xc(%ebp),%eax
80105496:	89 f2                	mov    %esi,%edx
80105498:	e8 73 f9 ff ff       	call   80104e10 <_ZL9allocNodeP4procx>
				if(node->left) {
8010549d:	85 c0                	test   %eax,%eax
				node->left = allocNode(p, key);
8010549f:	89 43 18             	mov    %eax,0x18(%ebx)
				if(node->left) {
801054a2:	75 8f                	jne    80105433 <_ZN7MapNode3putEP4proc+0x73>
}
801054a4:	83 c4 2c             	add    $0x2c,%esp
		return false;
801054a7:	31 c0                	xor    %eax,%eax
}
801054a9:	5b                   	pop    %ebx
801054aa:	5e                   	pop    %esi
801054ab:	5f                   	pop    %edi
801054ac:	5d                   	pop    %ebp
801054ad:	c3                   	ret    
801054ae:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
801054b0:	89 43 08             	mov    %eax,0x8(%ebx)
801054b3:	eb bd                	jmp    80105472 <_ZN7MapNode3putEP4proc+0xb2>
801054b5:	90                   	nop
801054b6:	8d 76 00             	lea    0x0(%esi),%esi
801054b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801054c0 <_ZN7MapNode10getMinNodeEv>:
MapNode* MapNode::getMinNode() { //no recursion.
801054c0:	55                   	push   %ebp
801054c1:	89 e5                	mov    %esp,%ebp
801054c3:	8b 45 08             	mov    0x8(%ebp),%eax
801054c6:	eb 0a                	jmp    801054d2 <_ZN7MapNode10getMinNodeEv+0x12>
801054c8:	90                   	nop
801054c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054d0:	89 d0                	mov    %edx,%eax
	while(minNode->left)
801054d2:	8b 50 18             	mov    0x18(%eax),%edx
801054d5:	85 d2                	test   %edx,%edx
801054d7:	75 f7                	jne    801054d0 <_ZN7MapNode10getMinNodeEv+0x10>
}
801054d9:	5d                   	pop    %ebp
801054da:	c3                   	ret    
801054db:	90                   	nop
801054dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054e0 <_ZN7MapNode9getMinKeyEPx>:
void MapNode::getMinKey(long long *pkey) {
801054e0:	55                   	push   %ebp
801054e1:	89 e5                	mov    %esp,%ebp
801054e3:	8b 55 08             	mov    0x8(%ebp),%edx
801054e6:	53                   	push   %ebx
801054e7:	eb 09                	jmp    801054f2 <_ZN7MapNode9getMinKeyEPx+0x12>
801054e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	while(minNode->left)
801054f0:	89 c2                	mov    %eax,%edx
801054f2:	8b 42 18             	mov    0x18(%edx),%eax
801054f5:	85 c0                	test   %eax,%eax
801054f7:	75 f7                	jne    801054f0 <_ZN7MapNode9getMinKeyEPx+0x10>
	*pkey = getMinNode()->key;
801054f9:	8b 5a 04             	mov    0x4(%edx),%ebx
801054fc:	8b 45 0c             	mov    0xc(%ebp),%eax
801054ff:	8b 0a                	mov    (%edx),%ecx
80105501:	89 58 04             	mov    %ebx,0x4(%eax)
80105504:	89 08                	mov    %ecx,(%eax)
}
80105506:	5b                   	pop    %ebx
80105507:	5d                   	pop    %ebp
80105508:	c3                   	ret    
80105509:	90                   	nop
8010550a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105510 <_ZN7MapNode7dequeueEv>:
Proc* MapNode::dequeue() {
80105510:	55                   	push   %ebp
80105511:	89 e5                	mov    %esp,%ebp
80105513:	83 ec 08             	sub    $0x8,%esp
80105516:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105519:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010551c:	89 75 fc             	mov    %esi,-0x4(%ebp)
	return !first;
8010551f:	8b 51 08             	mov    0x8(%ecx),%edx
	if(isEmpty())
80105522:	85 d2                	test   %edx,%edx
80105524:	74 32                	je     80105558 <_ZN7MapNode7dequeueEv+0x48>
	Link *next = first->next;
80105526:	8b 5a 04             	mov    0x4(%edx),%ebx
	link->next = freeLinks;
80105529:	8b 35 10 c6 10 80    	mov    0x8010c610,%esi
	Proc *p = first->p;
8010552f:	8b 02                	mov    (%edx),%eax
	freeLinks = link;
80105531:	89 15 10 c6 10 80    	mov    %edx,0x8010c610
	if(isEmpty())
80105537:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
80105539:	89 72 04             	mov    %esi,0x4(%edx)
	first = next;
8010553c:	89 59 08             	mov    %ebx,0x8(%ecx)
	if(isEmpty())
8010553f:	75 07                	jne    80105548 <_ZN7MapNode7dequeueEv+0x38>
		last = null;
80105541:	c7 41 0c 00 00 00 00 	movl   $0x0,0xc(%ecx)
}
80105548:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010554b:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010554e:	89 ec                	mov    %ebp,%esp
80105550:	5d                   	pop    %ebp
80105551:	c3                   	ret    
80105552:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		return null;
80105558:	31 c0                	xor    %eax,%eax
	return listOfProcs.dequeue();
8010555a:	eb ec                	jmp    80105548 <_ZN7MapNode7dequeueEv+0x38>
8010555c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105560 <_ZN3Map7isEmptyEv>:
bool Map::isEmpty() {
80105560:	55                   	push   %ebp
80105561:	89 e5                	mov    %esp,%ebp
	return !root;
80105563:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105566:	5d                   	pop    %ebp
	return !root;
80105567:	8b 00                	mov    (%eax),%eax
80105569:	85 c0                	test   %eax,%eax
8010556b:	0f 94 c0             	sete   %al
}
8010556e:	c3                   	ret    
8010556f:	90                   	nop

80105570 <_ZN3Map3putEP4proc>:
bool Map::put(Proc *p) {
80105570:	55                   	push   %ebp
80105571:	89 e5                	mov    %esp,%ebp
80105573:	83 ec 18             	sub    $0x18,%esp
80105576:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105579:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010557c:	89 75 fc             	mov    %esi,-0x4(%ebp)
8010557f:	8b 75 08             	mov    0x8(%ebp),%esi
	long long key = getAccumulator(p);
80105582:	89 1c 24             	mov    %ebx,(%esp)
80105585:	e8 36 e3 ff ff       	call   801038c0 <getAccumulator>
	return !root;
8010558a:	8b 0e                	mov    (%esi),%ecx
	if(isEmpty()) {
8010558c:	85 c9                	test   %ecx,%ecx
8010558e:	74 18                	je     801055a8 <_ZN3Map3putEP4proc+0x38>
	return root->put(p);
80105590:	89 5d 0c             	mov    %ebx,0xc(%ebp)
}
80105593:	8b 75 fc             	mov    -0x4(%ebp),%esi
	return root->put(p);
80105596:	89 4d 08             	mov    %ecx,0x8(%ebp)
}
80105599:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010559c:	89 ec                	mov    %ebp,%esp
8010559e:	5d                   	pop    %ebp
	return root->put(p);
8010559f:	e9 1c fe ff ff       	jmp    801053c0 <_ZN7MapNode3putEP4proc>
801055a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		root = allocNode(p, key);
801055a8:	89 d1                	mov    %edx,%ecx
801055aa:	89 c2                	mov    %eax,%edx
801055ac:	89 d8                	mov    %ebx,%eax
801055ae:	e8 5d f8 ff ff       	call   80104e10 <_ZL9allocNodeP4procx>
801055b3:	89 06                	mov    %eax,(%esi)
		return !isEmpty();
801055b5:	85 c0                	test   %eax,%eax
801055b7:	0f 95 c0             	setne  %al
}
801055ba:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801055bd:	8b 75 fc             	mov    -0x4(%ebp),%esi
801055c0:	89 ec                	mov    %ebp,%esp
801055c2:	5d                   	pop    %ebp
801055c3:	c3                   	ret    
801055c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801055ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801055d0 <putPriorityQueue>:
static boolean putPriorityQueue(Proc* p) {
801055d0:	55                   	push   %ebp
801055d1:	89 e5                	mov    %esp,%ebp
801055d3:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->put(p);
801055d6:	8b 45 08             	mov    0x8(%ebp),%eax
801055d9:	89 44 24 04          	mov    %eax,0x4(%esp)
801055dd:	a1 1c c6 10 80       	mov    0x8010c61c,%eax
801055e2:	89 04 24             	mov    %eax,(%esp)
801055e5:	e8 86 ff ff ff       	call   80105570 <_ZN3Map3putEP4proc>
}
801055ea:	c9                   	leave  
	return priorityQ->put(p);
801055eb:	0f b6 c0             	movzbl %al,%eax
}
801055ee:	c3                   	ret    
801055ef:	90                   	nop

801055f0 <_ZN3Map9getMinKeyEPx>:
bool Map::getMinKey(long long *pkey) {
801055f0:	55                   	push   %ebp
801055f1:	89 e5                	mov    %esp,%ebp
	return !root;
801055f3:	8b 45 08             	mov    0x8(%ebp),%eax
bool Map::getMinKey(long long *pkey) {
801055f6:	53                   	push   %ebx
	return !root;
801055f7:	8b 10                	mov    (%eax),%edx
	if(isEmpty())
801055f9:	85 d2                	test   %edx,%edx
801055fb:	75 05                	jne    80105602 <_ZN3Map9getMinKeyEPx+0x12>
801055fd:	eb 21                	jmp    80105620 <_ZN3Map9getMinKeyEPx+0x30>
801055ff:	90                   	nop
	while(minNode->left)
80105600:	89 c2                	mov    %eax,%edx
80105602:	8b 42 18             	mov    0x18(%edx),%eax
80105605:	85 c0                	test   %eax,%eax
80105607:	75 f7                	jne    80105600 <_ZN3Map9getMinKeyEPx+0x10>
	*pkey = getMinNode()->key;
80105609:	8b 45 0c             	mov    0xc(%ebp),%eax
8010560c:	8b 5a 04             	mov    0x4(%edx),%ebx
8010560f:	8b 0a                	mov    (%edx),%ecx
80105611:	89 58 04             	mov    %ebx,0x4(%eax)
80105614:	89 08                	mov    %ecx,(%eax)
		return false;

	root->getMinKey(pkey);
	return true;
80105616:	b0 01                	mov    $0x1,%al
}
80105618:	5b                   	pop    %ebx
80105619:	5d                   	pop    %ebp
8010561a:	c3                   	ret    
8010561b:	90                   	nop
8010561c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105620:	5b                   	pop    %ebx
		return false;
80105621:	31 c0                	xor    %eax,%eax
}
80105623:	5d                   	pop    %ebp
80105624:	c3                   	ret    
80105625:	90                   	nop
80105626:	8d 76 00             	lea    0x0(%esi),%esi
80105629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105630 <_ZN3Map10extractMinEv>:

Proc* Map::extractMin() {
80105630:	55                   	push   %ebp
80105631:	89 e5                	mov    %esp,%ebp
80105633:	57                   	push   %edi
80105634:	56                   	push   %esi
80105635:	8b 75 08             	mov    0x8(%ebp),%esi
80105638:	53                   	push   %ebx
	return !root;
80105639:	8b 1e                	mov    (%esi),%ebx
	if(isEmpty())
8010563b:	85 db                	test   %ebx,%ebx
8010563d:	0f 84 a5 00 00 00    	je     801056e8 <_ZN3Map10extractMinEv+0xb8>
80105643:	89 da                	mov    %ebx,%edx
80105645:	eb 0b                	jmp    80105652 <_ZN3Map10extractMinEv+0x22>
80105647:	89 f6                	mov    %esi,%esi
80105649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	while(minNode->left)
80105650:	89 c2                	mov    %eax,%edx
80105652:	8b 42 18             	mov    0x18(%edx),%eax
80105655:	85 c0                	test   %eax,%eax
80105657:	75 f7                	jne    80105650 <_ZN3Map10extractMinEv+0x20>
	return !first;
80105659:	8b 4a 08             	mov    0x8(%edx),%ecx
	if(isEmpty())
8010565c:	85 c9                	test   %ecx,%ecx
8010565e:	74 70                	je     801056d0 <_ZN3Map10extractMinEv+0xa0>
	Link *next = first->next;
80105660:	8b 59 04             	mov    0x4(%ecx),%ebx
	link->next = freeLinks;
80105663:	8b 3d 10 c6 10 80    	mov    0x8010c610,%edi
	Proc *p = first->p;
80105669:	8b 01                	mov    (%ecx),%eax
	freeLinks = link;
8010566b:	89 0d 10 c6 10 80    	mov    %ecx,0x8010c610
	if(isEmpty())
80105671:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
80105673:	89 79 04             	mov    %edi,0x4(%ecx)
	first = next;
80105676:	89 5a 08             	mov    %ebx,0x8(%edx)
	if(isEmpty())
80105679:	74 05                	je     80105680 <_ZN3Map10extractMinEv+0x50>
		}
		deallocNode(minNode);
	}

	return p;
}
8010567b:	5b                   	pop    %ebx
8010567c:	5e                   	pop    %esi
8010567d:	5f                   	pop    %edi
8010567e:	5d                   	pop    %ebp
8010567f:	c3                   	ret    
		last = null;
80105680:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
80105687:	8b 4a 1c             	mov    0x1c(%edx),%ecx
8010568a:	8b 1e                	mov    (%esi),%ebx
		if(minNode == root) {
8010568c:	39 da                	cmp    %ebx,%edx
8010568e:	74 49                	je     801056d9 <_ZN3Map10extractMinEv+0xa9>
			MapNode *parent = minNode->parent;
80105690:	8b 5a 14             	mov    0x14(%edx),%ebx
			parent->left = minNode->right;
80105693:	89 4b 18             	mov    %ecx,0x18(%ebx)
			if(minNode->right)
80105696:	8b 4a 1c             	mov    0x1c(%edx),%ecx
80105699:	85 c9                	test   %ecx,%ecx
8010569b:	74 03                	je     801056a0 <_ZN3Map10extractMinEv+0x70>
				minNode->right->parent = parent;
8010569d:	89 59 14             	mov    %ebx,0x14(%ecx)
	node->next = freeNodes;
801056a0:	8b 0d 0c c6 10 80    	mov    0x8010c60c,%ecx
	node->parent = node->left = node->right = null;
801056a6:	c7 42 1c 00 00 00 00 	movl   $0x0,0x1c(%edx)
801056ad:	c7 42 18 00 00 00 00 	movl   $0x0,0x18(%edx)
801056b4:	c7 42 14 00 00 00 00 	movl   $0x0,0x14(%edx)
	node->next = freeNodes;
801056bb:	89 4a 10             	mov    %ecx,0x10(%edx)
}
801056be:	5b                   	pop    %ebx
	freeNodes = node;
801056bf:	89 15 0c c6 10 80    	mov    %edx,0x8010c60c
}
801056c5:	5e                   	pop    %esi
801056c6:	5f                   	pop    %edi
801056c7:	5d                   	pop    %ebp
801056c8:	c3                   	ret    
801056c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return null;
801056d0:	31 c0                	xor    %eax,%eax
		if(minNode == root) {
801056d2:	39 da                	cmp    %ebx,%edx
801056d4:	8b 4a 1c             	mov    0x1c(%edx),%ecx
801056d7:	75 b7                	jne    80105690 <_ZN3Map10extractMinEv+0x60>
			if(!isEmpty())
801056d9:	85 c9                	test   %ecx,%ecx
			root = minNode->right;
801056db:	89 0e                	mov    %ecx,(%esi)
			if(!isEmpty())
801056dd:	74 c1                	je     801056a0 <_ZN3Map10extractMinEv+0x70>
				root->parent = null;
801056df:	c7 41 14 00 00 00 00 	movl   $0x0,0x14(%ecx)
801056e6:	eb b8                	jmp    801056a0 <_ZN3Map10extractMinEv+0x70>
		return null;
801056e8:	31 c0                	xor    %eax,%eax
801056ea:	eb 8f                	jmp    8010567b <_ZN3Map10extractMinEv+0x4b>
801056ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801056f0 <extractMinPriorityQueue>:
static Proc* extractMinPriorityQueue() {
801056f0:	55                   	push   %ebp
801056f1:	89 e5                	mov    %esp,%ebp
801056f3:	83 ec 04             	sub    $0x4,%esp
	return priorityQ->extractMin();
801056f6:	a1 1c c6 10 80       	mov    0x8010c61c,%eax
801056fb:	89 04 24             	mov    %eax,(%esp)
801056fe:	e8 2d ff ff ff       	call   80105630 <_ZN3Map10extractMinEv>
}
80105703:	c9                   	leave  
80105704:	c3                   	ret    
80105705:	90                   	nop
80105706:	8d 76 00             	lea    0x0(%esi),%esi
80105709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105710 <_ZN3Map8transferEv.part.1>:

bool Map::transfer() {
80105710:	55                   	push   %ebp
80105711:	89 e5                	mov    %esp,%ebp
80105713:	56                   	push   %esi
80105714:	53                   	push   %ebx
80105715:	89 c3                	mov    %eax,%ebx
80105717:	83 ec 04             	sub    $0x4,%esp
8010571a:	eb 16                	jmp    80105732 <_ZN3Map8transferEv.part.1+0x22>
8010571c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!roundRobinQ->isEmpty())
		return false;

	while(!isEmpty()) {
		Proc* p = extractMin();
80105720:	89 1c 24             	mov    %ebx,(%esp)
80105723:	e8 08 ff ff ff       	call   80105630 <_ZN3Map10extractMinEv>
	if(!freeLinks)
80105728:	8b 15 10 c6 10 80    	mov    0x8010c610,%edx
8010572e:	85 d2                	test   %edx,%edx
80105730:	75 0e                	jne    80105740 <_ZN3Map8transferEv.part.1+0x30>
	while(!isEmpty()) {
80105732:	8b 03                	mov    (%ebx),%eax
80105734:	85 c0                	test   %eax,%eax
80105736:	75 e8                	jne    80105720 <_ZN3Map8transferEv.part.1+0x10>
		roundRobinQ->enqueue(p); //should succeed.
	}

	return true;
}
80105738:	5a                   	pop    %edx
80105739:	b0 01                	mov    $0x1,%al
8010573b:	5b                   	pop    %ebx
8010573c:	5e                   	pop    %esi
8010573d:	5d                   	pop    %ebp
8010573e:	c3                   	ret    
8010573f:	90                   	nop
	freeLinks = freeLinks->next;
80105740:	8b 72 04             	mov    0x4(%edx),%esi
		roundRobinQ->enqueue(p); //should succeed.
80105743:	8b 0d 18 c6 10 80    	mov    0x8010c618,%ecx
	ans->next = null;
80105749:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
	ans->p = p;
80105750:	89 02                	mov    %eax,(%edx)
	freeLinks = freeLinks->next;
80105752:	89 35 10 c6 10 80    	mov    %esi,0x8010c610
	if(isEmpty()) first = link;
80105758:	8b 31                	mov    (%ecx),%esi
8010575a:	85 f6                	test   %esi,%esi
8010575c:	74 22                	je     80105780 <_ZN3Map8transferEv.part.1+0x70>
	else last->next = link;
8010575e:	8b 41 04             	mov    0x4(%ecx),%eax
80105761:	89 50 04             	mov    %edx,0x4(%eax)
80105764:	eb 0c                	jmp    80105772 <_ZN3Map8transferEv.part.1+0x62>
80105766:	8d 76 00             	lea    0x0(%esi),%esi
80105769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	while(ans->next)
80105770:	89 c2                	mov    %eax,%edx
80105772:	8b 42 04             	mov    0x4(%edx),%eax
80105775:	85 c0                	test   %eax,%eax
80105777:	75 f7                	jne    80105770 <_ZN3Map8transferEv.part.1+0x60>
	last = link->getLast();
80105779:	89 51 04             	mov    %edx,0x4(%ecx)
8010577c:	eb b4                	jmp    80105732 <_ZN3Map8transferEv.part.1+0x22>
8010577e:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
80105780:	89 11                	mov    %edx,(%ecx)
80105782:	eb ee                	jmp    80105772 <_ZN3Map8transferEv.part.1+0x62>
80105784:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010578a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105790 <switchToRoundRobinPolicyPriorityQueue>:
	if(!roundRobinQ->isEmpty())
80105790:	8b 15 18 c6 10 80    	mov    0x8010c618,%edx
80105796:	8b 02                	mov    (%edx),%eax
80105798:	85 c0                	test   %eax,%eax
8010579a:	74 04                	je     801057a0 <switchToRoundRobinPolicyPriorityQueue+0x10>
8010579c:	31 c0                	xor    %eax,%eax
}
8010579e:	c3                   	ret    
8010579f:	90                   	nop
801057a0:	a1 1c c6 10 80       	mov    0x8010c61c,%eax
static boolean switchToRoundRobinPolicyPriorityQueue() {
801057a5:	55                   	push   %ebp
801057a6:	89 e5                	mov    %esp,%ebp
801057a8:	e8 63 ff ff ff       	call   80105710 <_ZN3Map8transferEv.part.1>
}
801057ad:	5d                   	pop    %ebp
801057ae:	0f b6 c0             	movzbl %al,%eax
801057b1:	c3                   	ret    
801057b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057c0 <_ZN3Map8transferEv>:
	return !first;
801057c0:	8b 15 18 c6 10 80    	mov    0x8010c618,%edx
bool Map::transfer() {
801057c6:	55                   	push   %ebp
801057c7:	89 e5                	mov    %esp,%ebp
801057c9:	8b 45 08             	mov    0x8(%ebp),%eax
	if(!roundRobinQ->isEmpty())
801057cc:	8b 12                	mov    (%edx),%edx
801057ce:	85 d2                	test   %edx,%edx
801057d0:	74 0e                	je     801057e0 <_ZN3Map8transferEv+0x20>
}
801057d2:	31 c0                	xor    %eax,%eax
801057d4:	5d                   	pop    %ebp
801057d5:	c3                   	ret    
801057d6:	8d 76 00             	lea    0x0(%esi),%esi
801057d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801057e0:	5d                   	pop    %ebp
801057e1:	e9 2a ff ff ff       	jmp    80105710 <_ZN3Map8transferEv.part.1>
801057e6:	8d 76 00             	lea    0x0(%esi),%esi
801057e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057f0 <_ZN3Map11extractProcEP4proc>:

bool Map::extractProc(Proc *p) {
801057f0:	55                   	push   %ebp
801057f1:	89 e5                	mov    %esp,%ebp
801057f3:	56                   	push   %esi
801057f4:	53                   	push   %ebx
801057f5:	83 ec 30             	sub    $0x30,%esp
	if(!freeNodes)
801057f8:	8b 15 0c c6 10 80    	mov    0x8010c60c,%edx
bool Map::extractProc(Proc *p) {
801057fe:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105801:	8b 75 0c             	mov    0xc(%ebp),%esi
	if(!freeNodes)
80105804:	85 d2                	test   %edx,%edx
80105806:	74 50                	je     80105858 <_ZN3Map11extractProcEP4proc+0x68>
	MapNode *next, *parent, *left, *right;
};

class Map {
public:
	Map(): root(null) {}
80105808:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		return false;

	bool ans = false;
8010580f:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
80105813:	eb 13                	jmp    80105828 <_ZN3Map11extractProcEP4proc+0x38>
80105815:	8d 76 00             	lea    0x0(%esi),%esi
	Map tempMap;
	while(!isEmpty()) {
		Proc *otherP = extractMin();
80105818:	89 1c 24             	mov    %ebx,(%esp)
8010581b:	e8 10 fe ff ff       	call   80105630 <_ZN3Map10extractMinEv>
		if(otherP != p)
80105820:	39 f0                	cmp    %esi,%eax
80105822:	75 1c                	jne    80105840 <_ZN3Map11extractProcEP4proc+0x50>
			tempMap.put(otherP); //should scucceed.
		else ans = true;
80105824:	c6 45 e7 01          	movb   $0x1,-0x19(%ebp)
	while(!isEmpty()) {
80105828:	8b 03                	mov    (%ebx),%eax
8010582a:	85 c0                	test   %eax,%eax
8010582c:	75 ea                	jne    80105818 <_ZN3Map11extractProcEP4proc+0x28>
	}
	root = tempMap.root;
8010582e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105831:	89 03                	mov    %eax,(%ebx)
	return ans;
}
80105833:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80105837:	83 c4 30             	add    $0x30,%esp
8010583a:	5b                   	pop    %ebx
8010583b:	5e                   	pop    %esi
8010583c:	5d                   	pop    %ebp
8010583d:	c3                   	ret    
8010583e:	66 90                	xchg   %ax,%ax
			tempMap.put(otherP); //should scucceed.
80105840:	89 44 24 04          	mov    %eax,0x4(%esp)
80105844:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105847:	89 04 24             	mov    %eax,(%esp)
8010584a:	e8 21 fd ff ff       	call   80105570 <_ZN3Map3putEP4proc>
8010584f:	eb d7                	jmp    80105828 <_ZN3Map11extractProcEP4proc+0x38>
80105851:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return false;
80105858:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
}
8010585c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80105860:	83 c4 30             	add    $0x30,%esp
80105863:	5b                   	pop    %ebx
80105864:	5e                   	pop    %esi
80105865:	5d                   	pop    %ebp
80105866:	c3                   	ret    
80105867:	89 f6                	mov    %esi,%esi
80105869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105870 <extractProcPriorityQueue>:
static boolean extractProcPriorityQueue(Proc *p) {
80105870:	55                   	push   %ebp
80105871:	89 e5                	mov    %esp,%ebp
80105873:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->extractProc(p);
80105876:	8b 45 08             	mov    0x8(%ebp),%eax
80105879:	89 44 24 04          	mov    %eax,0x4(%esp)
8010587d:	a1 1c c6 10 80       	mov    0x8010c61c,%eax
80105882:	89 04 24             	mov    %eax,(%esp)
80105885:	e8 66 ff ff ff       	call   801057f0 <_ZN3Map11extractProcEP4proc>
}
8010588a:	c9                   	leave  
	return priorityQ->extractProc(p);
8010588b:	0f b6 c0             	movzbl %al,%eax
}
8010588e:	c3                   	ret    
8010588f:	90                   	nop

80105890 <__moddi3>:

long long __moddi3(long long number, long long divisor) { //returns number%divisor
80105890:	55                   	push   %ebp
80105891:	89 e5                	mov    %esp,%ebp
80105893:	57                   	push   %edi
80105894:	56                   	push   %esi
80105895:	53                   	push   %ebx
80105896:	83 ec 2c             	sub    $0x2c,%esp
80105899:	8b 45 08             	mov    0x8(%ebp),%eax
8010589c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010589f:	89 45 e0             	mov    %eax,-0x20(%ebp)
801058a2:	8b 45 10             	mov    0x10(%ebp),%eax
801058a5:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801058a8:	8b 55 14             	mov    0x14(%ebp),%edx
801058ab:	89 45 d8             	mov    %eax,-0x28(%ebp)
801058ae:	89 d7                	mov    %edx,%edi
	if(divisor == 0)
801058b0:	09 c2                	or     %eax,%edx
801058b2:	0f 84 9a 00 00 00    	je     80105952 <__moddi3+0xc2>
		panic((char*)"divide by zero!!!\n");

	bool isNumberNegative = false;
	if(number < 0) {
801058b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
	bool isNumberNegative = false;
801058bb:	c6 45 df 00          	movb   $0x0,-0x21(%ebp)
	if(number < 0) {
801058bf:	85 c0                	test   %eax,%eax
801058c1:	79 0e                	jns    801058d1 <__moddi3+0x41>
		number = -number;
801058c3:	f7 5d e0             	negl   -0x20(%ebp)
		isNumberNegative = true;
801058c6:	c6 45 df 01          	movb   $0x1,-0x21(%ebp)
		number = -number;
801058ca:	83 55 e4 00          	adcl   $0x0,-0x1c(%ebp)
801058ce:	f7 5d e4             	negl   -0x1c(%ebp)
801058d1:	8b 55 d8             	mov    -0x28(%ebp),%edx
801058d4:	89 f8                	mov    %edi,%eax
801058d6:	c1 ff 1f             	sar    $0x1f,%edi
801058d9:	31 f8                	xor    %edi,%eax
801058db:	89 f9                	mov    %edi,%ecx
801058dd:	31 fa                	xor    %edi,%edx
801058df:	89 c7                	mov    %eax,%edi
801058e1:	8b 45 e0             	mov    -0x20(%ebp),%eax
801058e4:	89 d6                	mov    %edx,%esi
801058e6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801058e9:	29 ce                	sub    %ecx,%esi
801058eb:	19 cf                	sbb    %ecx,%edi
	if(divisor < 0)
		divisor = -divisor;

	for(;;) {
		long long divisor2 = divisor;
		while(number >= divisor2) {
801058ed:	39 fa                	cmp    %edi,%edx
801058ef:	7d 1f                	jge    80105910 <__moddi3+0x80>
			if(divisor2 + divisor2 > 0) //exponential decay.
				divisor2 += divisor2;
		}

		if(number < divisor)
			return isNumberNegative ? -number : number;
801058f1:	80 7d df 00          	cmpb   $0x0,-0x21(%ebp)
801058f5:	74 07                	je     801058fe <__moddi3+0x6e>
801058f7:	f7 d8                	neg    %eax
801058f9:	83 d2 00             	adc    $0x0,%edx
801058fc:	f7 da                	neg    %edx
	}
}
801058fe:	83 c4 2c             	add    $0x2c,%esp
80105901:	5b                   	pop    %ebx
80105902:	5e                   	pop    %esi
80105903:	5f                   	pop    %edi
80105904:	5d                   	pop    %ebp
80105905:	c3                   	ret    
80105906:	8d 76 00             	lea    0x0(%esi),%esi
80105909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		while(number >= divisor2) {
80105910:	7f 04                	jg     80105916 <__moddi3+0x86>
80105912:	39 f0                	cmp    %esi,%eax
80105914:	72 db                	jb     801058f1 <__moddi3+0x61>
80105916:	89 f1                	mov    %esi,%ecx
80105918:	89 fb                	mov    %edi,%ebx
8010591a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			number -= divisor2;
80105920:	29 c8                	sub    %ecx,%eax
80105922:	19 da                	sbb    %ebx,%edx
				divisor2 += divisor2;
80105924:	0f a4 cb 01          	shld   $0x1,%ecx,%ebx
80105928:	01 c9                	add    %ecx,%ecx
		while(number >= divisor2) {
8010592a:	39 da                	cmp    %ebx,%edx
8010592c:	7f f2                	jg     80105920 <__moddi3+0x90>
8010592e:	7d 18                	jge    80105948 <__moddi3+0xb8>
		if(number < divisor)
80105930:	39 d7                	cmp    %edx,%edi
80105932:	7c b9                	jl     801058ed <__moddi3+0x5d>
80105934:	7f bb                	jg     801058f1 <__moddi3+0x61>
80105936:	39 c6                	cmp    %eax,%esi
80105938:	76 b3                	jbe    801058ed <__moddi3+0x5d>
8010593a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105940:	eb af                	jmp    801058f1 <__moddi3+0x61>
80105942:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		while(number >= divisor2) {
80105948:	39 c8                	cmp    %ecx,%eax
8010594a:	73 d4                	jae    80105920 <__moddi3+0x90>
8010594c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105950:	eb de                	jmp    80105930 <__moddi3+0xa0>
		panic((char*)"divide by zero!!!\n");
80105952:	c7 04 24 bc 8f 10 80 	movl   $0x80108fbc,(%esp)
80105959:	e8 12 aa ff ff       	call   80100370 <panic>
8010595e:	66 90                	xchg   %ax,%ax

80105960 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80105960:	55                   	push   %ebp
  initlock(&lk->lk, "sleep lock");
80105961:	b8 cf 8f 10 80       	mov    $0x80108fcf,%eax
{
80105966:	89 e5                	mov    %esp,%ebp
80105968:	53                   	push   %ebx
80105969:	83 ec 14             	sub    $0x14,%esp
8010596c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010596f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105973:	8d 43 04             	lea    0x4(%ebx),%eax
80105976:	89 04 24             	mov    %eax,(%esp)
80105979:	e8 12 01 00 00       	call   80105a90 <initlock>
  lk->name = name;
8010597e:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80105981:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80105987:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010598e:	89 43 38             	mov    %eax,0x38(%ebx)
}
80105991:	83 c4 14             	add    $0x14,%esp
80105994:	5b                   	pop    %ebx
80105995:	5d                   	pop    %ebp
80105996:	c3                   	ret    
80105997:	89 f6                	mov    %esi,%esi
80105999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801059a0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801059a0:	55                   	push   %ebp
801059a1:	89 e5                	mov    %esp,%ebp
801059a3:	56                   	push   %esi
801059a4:	53                   	push   %ebx
801059a5:	83 ec 10             	sub    $0x10,%esp
801059a8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801059ab:	8d 73 04             	lea    0x4(%ebx),%esi
801059ae:	89 34 24             	mov    %esi,(%esp)
801059b1:	e8 2a 02 00 00       	call   80105be0 <acquire>
  while (lk->locked) {
801059b6:	8b 13                	mov    (%ebx),%edx
801059b8:	85 d2                	test   %edx,%edx
801059ba:	74 16                	je     801059d2 <acquiresleep+0x32>
801059bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
801059c0:	89 74 24 04          	mov    %esi,0x4(%esp)
801059c4:	89 1c 24             	mov    %ebx,(%esp)
801059c7:	e8 d4 ea ff ff       	call   801044a0 <sleep>
  while (lk->locked) {
801059cc:	8b 03                	mov    (%ebx),%eax
801059ce:	85 c0                	test   %eax,%eax
801059d0:	75 ee                	jne    801059c0 <acquiresleep+0x20>
  }
  lk->locked = 1;
801059d2:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801059d8:	e8 c3 df ff ff       	call   801039a0 <myproc>
801059dd:	8b 40 10             	mov    0x10(%eax),%eax
801059e0:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801059e3:	89 75 08             	mov    %esi,0x8(%ebp)
}
801059e6:	83 c4 10             	add    $0x10,%esp
801059e9:	5b                   	pop    %ebx
801059ea:	5e                   	pop    %esi
801059eb:	5d                   	pop    %ebp
  release(&lk->lk);
801059ec:	e9 8f 02 00 00       	jmp    80105c80 <release>
801059f1:	eb 0d                	jmp    80105a00 <releasesleep>
801059f3:	90                   	nop
801059f4:	90                   	nop
801059f5:	90                   	nop
801059f6:	90                   	nop
801059f7:	90                   	nop
801059f8:	90                   	nop
801059f9:	90                   	nop
801059fa:	90                   	nop
801059fb:	90                   	nop
801059fc:	90                   	nop
801059fd:	90                   	nop
801059fe:	90                   	nop
801059ff:	90                   	nop

80105a00 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80105a00:	55                   	push   %ebp
80105a01:	89 e5                	mov    %esp,%ebp
80105a03:	83 ec 18             	sub    $0x18,%esp
80105a06:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105a09:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105a0c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  acquire(&lk->lk);
80105a0f:	8d 73 04             	lea    0x4(%ebx),%esi
80105a12:	89 34 24             	mov    %esi,(%esp)
80105a15:	e8 c6 01 00 00       	call   80105be0 <acquire>
  lk->locked = 0;
80105a1a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80105a20:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80105a27:	89 1c 24             	mov    %ebx,(%esp)
80105a2a:	e8 71 ec ff ff       	call   801046a0 <wakeup>
  release(&lk->lk);
}
80105a2f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  release(&lk->lk);
80105a32:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105a35:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105a38:	89 ec                	mov    %ebp,%esp
80105a3a:	5d                   	pop    %ebp
  release(&lk->lk);
80105a3b:	e9 40 02 00 00       	jmp    80105c80 <release>

80105a40 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80105a40:	55                   	push   %ebp
80105a41:	89 e5                	mov    %esp,%ebp
80105a43:	83 ec 28             	sub    $0x28,%esp
80105a46:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80105a49:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105a4c:	89 7d fc             	mov    %edi,-0x4(%ebp)
80105a4f:	89 75 f8             	mov    %esi,-0x8(%ebp)
80105a52:	31 f6                	xor    %esi,%esi
  int r;
  
  acquire(&lk->lk);
80105a54:	8d 7b 04             	lea    0x4(%ebx),%edi
80105a57:	89 3c 24             	mov    %edi,(%esp)
80105a5a:	e8 81 01 00 00       	call   80105be0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80105a5f:	8b 03                	mov    (%ebx),%eax
80105a61:	85 c0                	test   %eax,%eax
80105a63:	74 11                	je     80105a76 <holdingsleep+0x36>
80105a65:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80105a68:	e8 33 df ff ff       	call   801039a0 <myproc>
80105a6d:	39 58 10             	cmp    %ebx,0x10(%eax)
80105a70:	0f 94 c0             	sete   %al
80105a73:	0f b6 f0             	movzbl %al,%esi
  release(&lk->lk);
80105a76:	89 3c 24             	mov    %edi,(%esp)
80105a79:	e8 02 02 00 00       	call   80105c80 <release>
  return r;
}
80105a7e:	89 f0                	mov    %esi,%eax
80105a80:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105a83:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105a86:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105a89:	89 ec                	mov    %ebp,%esp
80105a8b:	5d                   	pop    %ebp
80105a8c:	c3                   	ret    
80105a8d:	66 90                	xchg   %ax,%ax
80105a8f:	90                   	nop

80105a90 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105a90:	55                   	push   %ebp
80105a91:	89 e5                	mov    %esp,%ebp
80105a93:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80105a96:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80105a99:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80105a9f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80105aa2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105aa9:	5d                   	pop    %ebp
80105aaa:	c3                   	ret    
80105aab:	90                   	nop
80105aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ab0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105ab0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105ab1:	31 d2                	xor    %edx,%edx
{
80105ab3:	89 e5                	mov    %esp,%ebp
  ebp = (uint*)v - 2;
80105ab5:	8b 45 08             	mov    0x8(%ebp),%eax
{
80105ab8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105abb:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80105abc:	83 e8 08             	sub    $0x8,%eax
80105abf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105ac0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80105ac6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80105acc:	77 12                	ja     80105ae0 <getcallerpcs+0x30>
      break;
    pcs[i] = ebp[1];     // saved %eip
80105ace:	8b 58 04             	mov    0x4(%eax),%ebx
80105ad1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80105ad4:	42                   	inc    %edx
80105ad5:	83 fa 0a             	cmp    $0xa,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80105ad8:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105ada:	75 e4                	jne    80105ac0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80105adc:	5b                   	pop    %ebx
80105add:	5d                   	pop    %ebp
80105ade:	c3                   	ret    
80105adf:	90                   	nop
80105ae0:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80105ae3:	83 c1 28             	add    $0x28,%ecx
80105ae6:	8d 76 00             	lea    0x0(%esi),%esi
80105ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80105af0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105af6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105af9:	39 c1                	cmp    %eax,%ecx
80105afb:	75 f3                	jne    80105af0 <getcallerpcs+0x40>
}
80105afd:	5b                   	pop    %ebx
80105afe:	5d                   	pop    %ebp
80105aff:	c3                   	ret    

80105b00 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105b00:	55                   	push   %ebp
80105b01:	89 e5                	mov    %esp,%ebp
80105b03:	53                   	push   %ebx
80105b04:	83 ec 04             	sub    $0x4,%esp
80105b07:	9c                   	pushf  
80105b08:	5b                   	pop    %ebx
  asm volatile("cli");
80105b09:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80105b0a:	e8 f1 dd ff ff       	call   80103900 <mycpu>
80105b0f:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105b15:	85 d2                	test   %edx,%edx
80105b17:	75 11                	jne    80105b2a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80105b19:	e8 e2 dd ff ff       	call   80103900 <mycpu>
80105b1e:	81 e3 00 02 00 00    	and    $0x200,%ebx
80105b24:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
80105b2a:	e8 d1 dd ff ff       	call   80103900 <mycpu>
80105b2f:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
80105b35:	58                   	pop    %eax
80105b36:	5b                   	pop    %ebx
80105b37:	5d                   	pop    %ebp
80105b38:	c3                   	ret    
80105b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105b40 <popcli>:

void
popcli(void)
{
80105b40:	55                   	push   %ebp
80105b41:	89 e5                	mov    %esp,%ebp
80105b43:	83 ec 18             	sub    $0x18,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105b46:	9c                   	pushf  
80105b47:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80105b48:	f6 c4 02             	test   $0x2,%ah
80105b4b:	75 35                	jne    80105b82 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80105b4d:	e8 ae dd ff ff       	call   80103900 <mycpu>
80105b52:	ff 88 a4 00 00 00    	decl   0xa4(%eax)
80105b58:	78 34                	js     80105b8e <popcli+0x4e>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105b5a:	e8 a1 dd ff ff       	call   80103900 <mycpu>
80105b5f:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105b65:	85 d2                	test   %edx,%edx
80105b67:	74 07                	je     80105b70 <popcli+0x30>
    sti();
}
80105b69:	c9                   	leave  
80105b6a:	c3                   	ret    
80105b6b:	90                   	nop
80105b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105b70:	e8 8b dd ff ff       	call   80103900 <mycpu>
80105b75:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80105b7b:	85 c0                	test   %eax,%eax
80105b7d:	74 ea                	je     80105b69 <popcli+0x29>
  asm volatile("sti");
80105b7f:	fb                   	sti    
}
80105b80:	c9                   	leave  
80105b81:	c3                   	ret    
    panic("popcli - interruptible");
80105b82:	c7 04 24 da 8f 10 80 	movl   $0x80108fda,(%esp)
80105b89:	e8 e2 a7 ff ff       	call   80100370 <panic>
    panic("popcli");
80105b8e:	c7 04 24 f1 8f 10 80 	movl   $0x80108ff1,(%esp)
80105b95:	e8 d6 a7 ff ff       	call   80100370 <panic>
80105b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105ba0 <holding>:
{
80105ba0:	55                   	push   %ebp
80105ba1:	89 e5                	mov    %esp,%ebp
80105ba3:	83 ec 08             	sub    $0x8,%esp
80105ba6:	89 75 fc             	mov    %esi,-0x4(%ebp)
80105ba9:	8b 75 08             	mov    0x8(%ebp),%esi
80105bac:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105baf:	31 db                	xor    %ebx,%ebx
  pushcli();
80105bb1:	e8 4a ff ff ff       	call   80105b00 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105bb6:	8b 06                	mov    (%esi),%eax
80105bb8:	85 c0                	test   %eax,%eax
80105bba:	74 10                	je     80105bcc <holding+0x2c>
80105bbc:	8b 5e 08             	mov    0x8(%esi),%ebx
80105bbf:	e8 3c dd ff ff       	call   80103900 <mycpu>
80105bc4:	39 c3                	cmp    %eax,%ebx
80105bc6:	0f 94 c3             	sete   %bl
80105bc9:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80105bcc:	e8 6f ff ff ff       	call   80105b40 <popcli>
}
80105bd1:	89 d8                	mov    %ebx,%eax
80105bd3:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105bd6:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105bd9:	89 ec                	mov    %ebp,%esp
80105bdb:	5d                   	pop    %ebp
80105bdc:	c3                   	ret    
80105bdd:	8d 76 00             	lea    0x0(%esi),%esi

80105be0 <acquire>:
{
80105be0:	55                   	push   %ebp
80105be1:	89 e5                	mov    %esp,%ebp
80105be3:	56                   	push   %esi
80105be4:	53                   	push   %ebx
80105be5:	83 ec 10             	sub    $0x10,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105be8:	e8 13 ff ff ff       	call   80105b00 <pushcli>
  if(holding(lk))
80105bed:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105bf0:	89 1c 24             	mov    %ebx,(%esp)
80105bf3:	e8 a8 ff ff ff       	call   80105ba0 <holding>
80105bf8:	85 c0                	test   %eax,%eax
80105bfa:	75 78                	jne    80105c74 <acquire+0x94>
80105bfc:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80105bfe:	ba 01 00 00 00       	mov    $0x1,%edx
80105c03:	eb 06                	jmp    80105c0b <acquire+0x2b>
80105c05:	8d 76 00             	lea    0x0(%esi),%esi
80105c08:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105c0b:	89 d0                	mov    %edx,%eax
80105c0d:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80105c10:	85 c0                	test   %eax,%eax
80105c12:	75 f4                	jne    80105c08 <acquire+0x28>
  __sync_synchronize();
80105c14:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80105c19:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105c1c:	e8 df dc ff ff       	call   80103900 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80105c21:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
80105c24:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80105c27:	89 e8                	mov    %ebp,%eax
80105c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105c30:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
80105c36:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80105c3c:	77 1a                	ja     80105c58 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
80105c3e:	8b 48 04             	mov    0x4(%eax),%ecx
80105c41:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
80105c44:	46                   	inc    %esi
80105c45:	83 fe 0a             	cmp    $0xa,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80105c48:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105c4a:	75 e4                	jne    80105c30 <acquire+0x50>
}
80105c4c:	83 c4 10             	add    $0x10,%esp
80105c4f:	5b                   	pop    %ebx
80105c50:	5e                   	pop    %esi
80105c51:	5d                   	pop    %ebp
80105c52:	c3                   	ret    
80105c53:	90                   	nop
80105c54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c58:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80105c5b:	83 c2 28             	add    $0x28,%edx
80105c5e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105c60:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105c66:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105c69:	39 d0                	cmp    %edx,%eax
80105c6b:	75 f3                	jne    80105c60 <acquire+0x80>
}
80105c6d:	83 c4 10             	add    $0x10,%esp
80105c70:	5b                   	pop    %ebx
80105c71:	5e                   	pop    %esi
80105c72:	5d                   	pop    %ebp
80105c73:	c3                   	ret    
    panic("acquire");
80105c74:	c7 04 24 f8 8f 10 80 	movl   $0x80108ff8,(%esp)
80105c7b:	e8 f0 a6 ff ff       	call   80100370 <panic>

80105c80 <release>:
{
80105c80:	55                   	push   %ebp
80105c81:	89 e5                	mov    %esp,%ebp
80105c83:	53                   	push   %ebx
80105c84:	83 ec 14             	sub    $0x14,%esp
80105c87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80105c8a:	89 1c 24             	mov    %ebx,(%esp)
80105c8d:	e8 0e ff ff ff       	call   80105ba0 <holding>
80105c92:	85 c0                	test   %eax,%eax
80105c94:	74 23                	je     80105cb9 <release+0x39>
  lk->pcs[0] = 0;
80105c96:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105c9d:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105ca4:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80105ca9:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105caf:	83 c4 14             	add    $0x14,%esp
80105cb2:	5b                   	pop    %ebx
80105cb3:	5d                   	pop    %ebp
  popcli();
80105cb4:	e9 87 fe ff ff       	jmp    80105b40 <popcli>
    panic("release");
80105cb9:	c7 04 24 00 90 10 80 	movl   $0x80109000,(%esp)
80105cc0:	e8 ab a6 ff ff       	call   80100370 <panic>
80105cc5:	66 90                	xchg   %ax,%ax
80105cc7:	66 90                	xchg   %ax,%ax
80105cc9:	66 90                	xchg   %ax,%ax
80105ccb:	66 90                	xchg   %ax,%ax
80105ccd:	66 90                	xchg   %ax,%ax
80105ccf:	90                   	nop

80105cd0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105cd0:	55                   	push   %ebp
80105cd1:	89 e5                	mov    %esp,%ebp
80105cd3:	83 ec 08             	sub    $0x8,%esp
80105cd6:	8b 55 08             	mov    0x8(%ebp),%edx
80105cd9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105cdc:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105cdf:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if ((int)dst%4 == 0 && n%4 == 0){
80105ce2:	f6 c2 03             	test   $0x3,%dl
80105ce5:	75 05                	jne    80105cec <memset+0x1c>
80105ce7:	f6 c1 03             	test   $0x3,%cl
80105cea:	74 14                	je     80105d00 <memset+0x30>
  asm volatile("cld; rep stosb" :
80105cec:	89 d7                	mov    %edx,%edi
80105cee:	8b 45 0c             	mov    0xc(%ebp),%eax
80105cf1:	fc                   	cld    
80105cf2:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80105cf4:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105cf7:	89 d0                	mov    %edx,%eax
80105cf9:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105cfc:	89 ec                	mov    %ebp,%esp
80105cfe:	5d                   	pop    %ebp
80105cff:	c3                   	ret    
    c &= 0xFF;
80105d00:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80105d04:	c1 e9 02             	shr    $0x2,%ecx
80105d07:	89 f8                	mov    %edi,%eax
80105d09:	89 fb                	mov    %edi,%ebx
80105d0b:	c1 e0 18             	shl    $0x18,%eax
80105d0e:	c1 e3 10             	shl    $0x10,%ebx
80105d11:	09 d8                	or     %ebx,%eax
80105d13:	09 f8                	or     %edi,%eax
80105d15:	c1 e7 08             	shl    $0x8,%edi
80105d18:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80105d1a:	89 d7                	mov    %edx,%edi
80105d1c:	fc                   	cld    
80105d1d:	f3 ab                	rep stos %eax,%es:(%edi)
}
80105d1f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105d22:	89 d0                	mov    %edx,%eax
80105d24:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105d27:	89 ec                	mov    %ebp,%esp
80105d29:	5d                   	pop    %ebp
80105d2a:	c3                   	ret    
80105d2b:	90                   	nop
80105d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d30 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105d30:	55                   	push   %ebp
80105d31:	89 e5                	mov    %esp,%ebp
80105d33:	57                   	push   %edi
80105d34:	8b 7d 0c             	mov    0xc(%ebp),%edi
80105d37:	56                   	push   %esi
80105d38:	8b 75 08             	mov    0x8(%ebp),%esi
80105d3b:	53                   	push   %ebx
80105d3c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105d3f:	85 db                	test   %ebx,%ebx
80105d41:	74 27                	je     80105d6a <memcmp+0x3a>
    if(*s1 != *s2)
80105d43:	0f b6 16             	movzbl (%esi),%edx
80105d46:	0f b6 0f             	movzbl (%edi),%ecx
80105d49:	38 d1                	cmp    %dl,%cl
80105d4b:	75 2b                	jne    80105d78 <memcmp+0x48>
80105d4d:	b8 01 00 00 00       	mov    $0x1,%eax
80105d52:	eb 12                	jmp    80105d66 <memcmp+0x36>
80105d54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d58:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80105d5c:	40                   	inc    %eax
80105d5d:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80105d62:	38 ca                	cmp    %cl,%dl
80105d64:	75 12                	jne    80105d78 <memcmp+0x48>
  while(n-- > 0){
80105d66:	39 d8                	cmp    %ebx,%eax
80105d68:	75 ee                	jne    80105d58 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80105d6a:	5b                   	pop    %ebx
  return 0;
80105d6b:	31 c0                	xor    %eax,%eax
}
80105d6d:	5e                   	pop    %esi
80105d6e:	5f                   	pop    %edi
80105d6f:	5d                   	pop    %ebp
80105d70:	c3                   	ret    
80105d71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d78:	5b                   	pop    %ebx
      return *s1 - *s2;
80105d79:	0f b6 c2             	movzbl %dl,%eax
80105d7c:	29 c8                	sub    %ecx,%eax
}
80105d7e:	5e                   	pop    %esi
80105d7f:	5f                   	pop    %edi
80105d80:	5d                   	pop    %ebp
80105d81:	c3                   	ret    
80105d82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105d90 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105d90:	55                   	push   %ebp
80105d91:	89 e5                	mov    %esp,%ebp
80105d93:	56                   	push   %esi
80105d94:	8b 45 08             	mov    0x8(%ebp),%eax
80105d97:	53                   	push   %ebx
80105d98:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80105d9b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80105d9e:	39 c3                	cmp    %eax,%ebx
80105da0:	73 26                	jae    80105dc8 <memmove+0x38>
80105da2:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80105da5:	39 c8                	cmp    %ecx,%eax
80105da7:	73 1f                	jae    80105dc8 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80105da9:	85 f6                	test   %esi,%esi
80105dab:	8d 56 ff             	lea    -0x1(%esi),%edx
80105dae:	74 0d                	je     80105dbd <memmove+0x2d>
      *--d = *--s;
80105db0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105db4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80105db7:	4a                   	dec    %edx
80105db8:	83 fa ff             	cmp    $0xffffffff,%edx
80105dbb:	75 f3                	jne    80105db0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80105dbd:	5b                   	pop    %ebx
80105dbe:	5e                   	pop    %esi
80105dbf:	5d                   	pop    %ebp
80105dc0:	c3                   	ret    
80105dc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80105dc8:	31 d2                	xor    %edx,%edx
80105dca:	85 f6                	test   %esi,%esi
80105dcc:	74 ef                	je     80105dbd <memmove+0x2d>
80105dce:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80105dd0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105dd4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80105dd7:	42                   	inc    %edx
    while(n-- > 0)
80105dd8:	39 d6                	cmp    %edx,%esi
80105dda:	75 f4                	jne    80105dd0 <memmove+0x40>
}
80105ddc:	5b                   	pop    %ebx
80105ddd:	5e                   	pop    %esi
80105dde:	5d                   	pop    %ebp
80105ddf:	c3                   	ret    

80105de0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105de0:	55                   	push   %ebp
80105de1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80105de3:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80105de4:	eb aa                	jmp    80105d90 <memmove>
80105de6:	8d 76 00             	lea    0x0(%esi),%esi
80105de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105df0 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80105df0:	55                   	push   %ebp
80105df1:	89 e5                	mov    %esp,%ebp
80105df3:	57                   	push   %edi
80105df4:	8b 7d 10             	mov    0x10(%ebp),%edi
80105df7:	56                   	push   %esi
80105df8:	8b 75 0c             	mov    0xc(%ebp),%esi
80105dfb:	53                   	push   %ebx
80105dfc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
80105dff:	85 ff                	test   %edi,%edi
80105e01:	74 2d                	je     80105e30 <strncmp+0x40>
80105e03:	0f b6 03             	movzbl (%ebx),%eax
80105e06:	0f b6 0e             	movzbl (%esi),%ecx
80105e09:	84 c0                	test   %al,%al
80105e0b:	74 37                	je     80105e44 <strncmp+0x54>
80105e0d:	38 c1                	cmp    %al,%cl
80105e0f:	75 33                	jne    80105e44 <strncmp+0x54>
80105e11:	01 f7                	add    %esi,%edi
80105e13:	eb 13                	jmp    80105e28 <strncmp+0x38>
80105e15:	8d 76 00             	lea    0x0(%esi),%esi
80105e18:	0f b6 03             	movzbl (%ebx),%eax
80105e1b:	84 c0                	test   %al,%al
80105e1d:	74 21                	je     80105e40 <strncmp+0x50>
80105e1f:	0f b6 0a             	movzbl (%edx),%ecx
80105e22:	89 d6                	mov    %edx,%esi
80105e24:	38 c8                	cmp    %cl,%al
80105e26:	75 1c                	jne    80105e44 <strncmp+0x54>
    n--, p++, q++;
80105e28:	8d 56 01             	lea    0x1(%esi),%edx
80105e2b:	43                   	inc    %ebx
  while(n > 0 && *p && *p == *q)
80105e2c:	39 fa                	cmp    %edi,%edx
80105e2e:	75 e8                	jne    80105e18 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80105e30:	5b                   	pop    %ebx
    return 0;
80105e31:	31 c0                	xor    %eax,%eax
}
80105e33:	5e                   	pop    %esi
80105e34:	5f                   	pop    %edi
80105e35:	5d                   	pop    %ebp
80105e36:	c3                   	ret    
80105e37:	89 f6                	mov    %esi,%esi
80105e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105e40:	0f b6 4e 01          	movzbl 0x1(%esi),%ecx
80105e44:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
80105e45:	29 c8                	sub    %ecx,%eax
}
80105e47:	5e                   	pop    %esi
80105e48:	5f                   	pop    %edi
80105e49:	5d                   	pop    %ebp
80105e4a:	c3                   	ret    
80105e4b:	90                   	nop
80105e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105e50 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105e50:	55                   	push   %ebp
80105e51:	89 e5                	mov    %esp,%ebp
80105e53:	8b 45 08             	mov    0x8(%ebp),%eax
80105e56:	56                   	push   %esi
80105e57:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105e5a:	53                   	push   %ebx
80105e5b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80105e5e:	89 c2                	mov    %eax,%edx
80105e60:	eb 15                	jmp    80105e77 <strncpy+0x27>
80105e62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105e68:	46                   	inc    %esi
80105e69:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
80105e6d:	42                   	inc    %edx
80105e6e:	84 c9                	test   %cl,%cl
80105e70:	88 4a ff             	mov    %cl,-0x1(%edx)
80105e73:	74 09                	je     80105e7e <strncpy+0x2e>
80105e75:	89 d9                	mov    %ebx,%ecx
80105e77:	85 c9                	test   %ecx,%ecx
80105e79:	8d 59 ff             	lea    -0x1(%ecx),%ebx
80105e7c:	7f ea                	jg     80105e68 <strncpy+0x18>
    ;
  while(n-- > 0)
80105e7e:	31 c9                	xor    %ecx,%ecx
80105e80:	85 db                	test   %ebx,%ebx
80105e82:	7e 19                	jle    80105e9d <strncpy+0x4d>
80105e84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105e8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *s++ = 0;
80105e90:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80105e94:	89 de                	mov    %ebx,%esi
80105e96:	41                   	inc    %ecx
80105e97:	29 ce                	sub    %ecx,%esi
  while(n-- > 0)
80105e99:	85 f6                	test   %esi,%esi
80105e9b:	7f f3                	jg     80105e90 <strncpy+0x40>
  return os;
}
80105e9d:	5b                   	pop    %ebx
80105e9e:	5e                   	pop    %esi
80105e9f:	5d                   	pop    %ebp
80105ea0:	c3                   	ret    
80105ea1:	eb 0d                	jmp    80105eb0 <safestrcpy>
80105ea3:	90                   	nop
80105ea4:	90                   	nop
80105ea5:	90                   	nop
80105ea6:	90                   	nop
80105ea7:	90                   	nop
80105ea8:	90                   	nop
80105ea9:	90                   	nop
80105eaa:	90                   	nop
80105eab:	90                   	nop
80105eac:	90                   	nop
80105ead:	90                   	nop
80105eae:	90                   	nop
80105eaf:	90                   	nop

80105eb0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105eb0:	55                   	push   %ebp
80105eb1:	89 e5                	mov    %esp,%ebp
80105eb3:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105eb6:	56                   	push   %esi
80105eb7:	8b 45 08             	mov    0x8(%ebp),%eax
80105eba:	53                   	push   %ebx
80105ebb:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80105ebe:	85 c9                	test   %ecx,%ecx
80105ec0:	7e 22                	jle    80105ee4 <safestrcpy+0x34>
80105ec2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80105ec6:	89 c1                	mov    %eax,%ecx
80105ec8:	eb 13                	jmp    80105edd <safestrcpy+0x2d>
80105eca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105ed0:	42                   	inc    %edx
80105ed1:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80105ed5:	41                   	inc    %ecx
80105ed6:	84 db                	test   %bl,%bl
80105ed8:	88 59 ff             	mov    %bl,-0x1(%ecx)
80105edb:	74 04                	je     80105ee1 <safestrcpy+0x31>
80105edd:	39 f2                	cmp    %esi,%edx
80105edf:	75 ef                	jne    80105ed0 <safestrcpy+0x20>
    ;
  *s = 0;
80105ee1:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80105ee4:	5b                   	pop    %ebx
80105ee5:	5e                   	pop    %esi
80105ee6:	5d                   	pop    %ebp
80105ee7:	c3                   	ret    
80105ee8:	90                   	nop
80105ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ef0 <strlen>:

int
strlen(const char *s)
{
80105ef0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105ef1:	31 c0                	xor    %eax,%eax
{
80105ef3:	89 e5                	mov    %esp,%ebp
80105ef5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105ef8:	80 3a 00             	cmpb   $0x0,(%edx)
80105efb:	74 0a                	je     80105f07 <strlen+0x17>
80105efd:	8d 76 00             	lea    0x0(%esi),%esi
80105f00:	40                   	inc    %eax
80105f01:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105f05:	75 f9                	jne    80105f00 <strlen+0x10>
    ;
  return n;
}
80105f07:	5d                   	pop    %ebp
80105f08:	c3                   	ret    

80105f09 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80105f09:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80105f0d:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80105f11:	55                   	push   %ebp
  pushl %ebx
80105f12:	53                   	push   %ebx
  pushl %esi
80105f13:	56                   	push   %esi
  pushl %edi
80105f14:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105f15:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105f17:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80105f19:	5f                   	pop    %edi
  popl %esi
80105f1a:	5e                   	pop    %esi
  popl %ebx
80105f1b:	5b                   	pop    %ebx
  popl %ebp
80105f1c:	5d                   	pop    %ebp
  ret
80105f1d:	c3                   	ret    
80105f1e:	66 90                	xchg   %ax,%ax

80105f20 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105f20:	55                   	push   %ebp
80105f21:	89 e5                	mov    %esp,%ebp
80105f23:	53                   	push   %ebx
80105f24:	83 ec 04             	sub    $0x4,%esp
80105f27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80105f2a:	e8 71 da ff ff       	call   801039a0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105f2f:	8b 00                	mov    (%eax),%eax
80105f31:	39 d8                	cmp    %ebx,%eax
80105f33:	76 1b                	jbe    80105f50 <fetchint+0x30>
80105f35:	8d 53 04             	lea    0x4(%ebx),%edx
80105f38:	39 d0                	cmp    %edx,%eax
80105f3a:	72 14                	jb     80105f50 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80105f3c:	8b 45 0c             	mov    0xc(%ebp),%eax
80105f3f:	8b 13                	mov    (%ebx),%edx
80105f41:	89 10                	mov    %edx,(%eax)
  return 0;
80105f43:	31 c0                	xor    %eax,%eax
}
80105f45:	5a                   	pop    %edx
80105f46:	5b                   	pop    %ebx
80105f47:	5d                   	pop    %ebp
80105f48:	c3                   	ret    
80105f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105f50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f55:	eb ee                	jmp    80105f45 <fetchint+0x25>
80105f57:	89 f6                	mov    %esi,%esi
80105f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105f60 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105f60:	55                   	push   %ebp
80105f61:	89 e5                	mov    %esp,%ebp
80105f63:	53                   	push   %ebx
80105f64:	83 ec 04             	sub    $0x4,%esp
80105f67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80105f6a:	e8 31 da ff ff       	call   801039a0 <myproc>

  if(addr >= curproc->sz)
80105f6f:	39 18                	cmp    %ebx,(%eax)
80105f71:	76 27                	jbe    80105f9a <fetchstr+0x3a>
    return -1;
  *pp = (char*)addr;
80105f73:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105f76:	89 da                	mov    %ebx,%edx
80105f78:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80105f7a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80105f7c:	39 c3                	cmp    %eax,%ebx
80105f7e:	73 1a                	jae    80105f9a <fetchstr+0x3a>
    if(*s == 0)
80105f80:	80 3b 00             	cmpb   $0x0,(%ebx)
80105f83:	75 10                	jne    80105f95 <fetchstr+0x35>
80105f85:	eb 29                	jmp    80105fb0 <fetchstr+0x50>
80105f87:	89 f6                	mov    %esi,%esi
80105f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105f90:	80 3a 00             	cmpb   $0x0,(%edx)
80105f93:	74 13                	je     80105fa8 <fetchstr+0x48>
  for(s = *pp; s < ep; s++){
80105f95:	42                   	inc    %edx
80105f96:	39 d0                	cmp    %edx,%eax
80105f98:	77 f6                	ja     80105f90 <fetchstr+0x30>
    return -1;
80105f9a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80105f9f:	5a                   	pop    %edx
80105fa0:	5b                   	pop    %ebx
80105fa1:	5d                   	pop    %ebp
80105fa2:	c3                   	ret    
80105fa3:	90                   	nop
80105fa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105fa8:	89 d0                	mov    %edx,%eax
80105faa:	5a                   	pop    %edx
80105fab:	29 d8                	sub    %ebx,%eax
80105fad:	5b                   	pop    %ebx
80105fae:	5d                   	pop    %ebp
80105faf:	c3                   	ret    
    if(*s == 0)
80105fb0:	31 c0                	xor    %eax,%eax
      return s - *pp;
80105fb2:	eb eb                	jmp    80105f9f <fetchstr+0x3f>
80105fb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105fba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105fc0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105fc0:	55                   	push   %ebp
80105fc1:	89 e5                	mov    %esp,%ebp
80105fc3:	56                   	push   %esi
80105fc4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105fc5:	e8 d6 d9 ff ff       	call   801039a0 <myproc>
80105fca:	8b 55 08             	mov    0x8(%ebp),%edx
80105fcd:	8b 40 18             	mov    0x18(%eax),%eax
80105fd0:	8b 40 44             	mov    0x44(%eax),%eax
80105fd3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105fd6:	e8 c5 d9 ff ff       	call   801039a0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105fdb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105fde:	8b 00                	mov    (%eax),%eax
80105fe0:	39 c6                	cmp    %eax,%esi
80105fe2:	73 1c                	jae    80106000 <argint+0x40>
80105fe4:	8d 53 08             	lea    0x8(%ebx),%edx
80105fe7:	39 d0                	cmp    %edx,%eax
80105fe9:	72 15                	jb     80106000 <argint+0x40>
  *ip = *(int*)(addr);
80105feb:	8b 45 0c             	mov    0xc(%ebp),%eax
80105fee:	8b 53 04             	mov    0x4(%ebx),%edx
80105ff1:	89 10                	mov    %edx,(%eax)
  return 0;
80105ff3:	31 c0                	xor    %eax,%eax
}
80105ff5:	5b                   	pop    %ebx
80105ff6:	5e                   	pop    %esi
80105ff7:	5d                   	pop    %ebp
80105ff8:	c3                   	ret    
80105ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106000:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80106005:	eb ee                	jmp    80105ff5 <argint+0x35>
80106007:	89 f6                	mov    %esi,%esi
80106009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106010 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80106010:	55                   	push   %ebp
80106011:	89 e5                	mov    %esp,%ebp
80106013:	56                   	push   %esi
80106014:	53                   	push   %ebx
80106015:	83 ec 20             	sub    $0x20,%esp
80106018:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010601b:	e8 80 d9 ff ff       	call   801039a0 <myproc>
80106020:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80106022:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106025:	89 44 24 04          	mov    %eax,0x4(%esp)
80106029:	8b 45 08             	mov    0x8(%ebp),%eax
8010602c:	89 04 24             	mov    %eax,(%esp)
8010602f:	e8 8c ff ff ff       	call   80105fc0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80106034:	c1 e8 1f             	shr    $0x1f,%eax
80106037:	84 c0                	test   %al,%al
80106039:	75 2d                	jne    80106068 <argptr+0x58>
8010603b:	89 d8                	mov    %ebx,%eax
8010603d:	c1 e8 1f             	shr    $0x1f,%eax
80106040:	84 c0                	test   %al,%al
80106042:	75 24                	jne    80106068 <argptr+0x58>
80106044:	8b 16                	mov    (%esi),%edx
80106046:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106049:	39 c2                	cmp    %eax,%edx
8010604b:	76 1b                	jbe    80106068 <argptr+0x58>
8010604d:	01 c3                	add    %eax,%ebx
8010604f:	39 da                	cmp    %ebx,%edx
80106051:	72 15                	jb     80106068 <argptr+0x58>
    return -1;
  *pp = (char*)i;
80106053:	8b 55 0c             	mov    0xc(%ebp),%edx
80106056:	89 02                	mov    %eax,(%edx)
  return 0;
80106058:	31 c0                	xor    %eax,%eax
}
8010605a:	83 c4 20             	add    $0x20,%esp
8010605d:	5b                   	pop    %ebx
8010605e:	5e                   	pop    %esi
8010605f:	5d                   	pop    %ebp
80106060:	c3                   	ret    
80106061:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106068:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010606d:	eb eb                	jmp    8010605a <argptr+0x4a>
8010606f:	90                   	nop

80106070 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80106070:	55                   	push   %ebp
80106071:	89 e5                	mov    %esp,%ebp
80106073:	83 ec 28             	sub    $0x28,%esp
  int addr;
  if(argint(n, &addr) < 0)
80106076:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106079:	89 44 24 04          	mov    %eax,0x4(%esp)
8010607d:	8b 45 08             	mov    0x8(%ebp),%eax
80106080:	89 04 24             	mov    %eax,(%esp)
80106083:	e8 38 ff ff ff       	call   80105fc0 <argint>
80106088:	85 c0                	test   %eax,%eax
8010608a:	78 14                	js     801060a0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
8010608c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010608f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106093:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106096:	89 04 24             	mov    %eax,(%esp)
80106099:	e8 c2 fe ff ff       	call   80105f60 <fetchstr>
}
8010609e:	c9                   	leave  
8010609f:	c3                   	ret    
    return -1;
801060a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801060a5:	c9                   	leave  
801060a6:	c3                   	ret    
801060a7:	89 f6                	mov    %esi,%esi
801060a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801060b0 <syscall>:
[SYS_wait_stat] sys_wait_stat,
};

void
syscall(void)
{
801060b0:	55                   	push   %ebp
801060b1:	89 e5                	mov    %esp,%ebp
801060b3:	53                   	push   %ebx
801060b4:	83 ec 14             	sub    $0x14,%esp
  int num;
  struct proc *curproc = myproc();
801060b7:	e8 e4 d8 ff ff       	call   801039a0 <myproc>
801060bc:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
801060be:	8b 40 18             	mov    0x18(%eax),%eax
801060c1:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801060c4:	8d 50 ff             	lea    -0x1(%eax),%edx
801060c7:	83 fa 18             	cmp    $0x18,%edx
801060ca:	77 1c                	ja     801060e8 <syscall+0x38>
801060cc:	8b 14 85 40 90 10 80 	mov    -0x7fef6fc0(,%eax,4),%edx
801060d3:	85 d2                	test   %edx,%edx
801060d5:	74 11                	je     801060e8 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
801060d7:	ff d2                	call   *%edx
801060d9:	8b 53 18             	mov    0x18(%ebx),%edx
801060dc:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801060df:	83 c4 14             	add    $0x14,%esp
801060e2:	5b                   	pop    %ebx
801060e3:	5d                   	pop    %ebp
801060e4:	c3                   	ret    
801060e5:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
801060e8:	89 44 24 0c          	mov    %eax,0xc(%esp)
            curproc->pid, curproc->name, num);
801060ec:	8d 43 6c             	lea    0x6c(%ebx),%eax
801060ef:	89 44 24 08          	mov    %eax,0x8(%esp)
    cprintf("%d %s: unknown sys call %d\n",
801060f3:	8b 43 10             	mov    0x10(%ebx),%eax
801060f6:	c7 04 24 08 90 10 80 	movl   $0x80109008,(%esp)
801060fd:	89 44 24 04          	mov    %eax,0x4(%esp)
80106101:	e8 4a a5 ff ff       	call   80100650 <cprintf>
    curproc->tf->eax = -1;
80106106:	8b 43 18             	mov    0x18(%ebx),%eax
80106109:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80106110:	83 c4 14             	add    $0x14,%esp
80106113:	5b                   	pop    %ebx
80106114:	5d                   	pop    %ebp
80106115:	c3                   	ret    
80106116:	66 90                	xchg   %ax,%ax
80106118:	66 90                	xchg   %ax,%ax
8010611a:	66 90                	xchg   %ax,%ax
8010611c:	66 90                	xchg   %ax,%ax
8010611e:	66 90                	xchg   %ax,%ax

80106120 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80106120:	55                   	push   %ebp
80106121:	0f bf d2             	movswl %dx,%edx
80106124:	89 e5                	mov    %esp,%ebp
80106126:	83 ec 58             	sub    $0x58,%esp
80106129:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010612c:	0f bf 7d 08          	movswl 0x8(%ebp),%edi
80106130:	0f bf c9             	movswl %cx,%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80106133:	89 04 24             	mov    %eax,(%esp)
{
80106136:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80106139:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010613c:	89 7d bc             	mov    %edi,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010613f:	8d 7d da             	lea    -0x26(%ebp),%edi
80106142:	89 7c 24 04          	mov    %edi,0x4(%esp)
{
80106146:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80106149:	89 4d c0             	mov    %ecx,-0x40(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010614c:	e8 9f be ff ff       	call   80101ff0 <nameiparent>
80106151:	85 c0                	test   %eax,%eax
80106153:	0f 84 4f 01 00 00    	je     801062a8 <create+0x188>
    return 0;
  ilock(dp);
80106159:	89 04 24             	mov    %eax,(%esp)
8010615c:	89 c3                	mov    %eax,%ebx
8010615e:	e8 8d b5 ff ff       	call   801016f0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80106163:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80106166:	89 44 24 08          	mov    %eax,0x8(%esp)
8010616a:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010616e:	89 1c 24             	mov    %ebx,(%esp)
80106171:	e8 fa ba ff ff       	call   80101c70 <dirlookup>
80106176:	85 c0                	test   %eax,%eax
80106178:	89 c6                	mov    %eax,%esi
8010617a:	74 34                	je     801061b0 <create+0x90>
    iunlockput(dp);
8010617c:	89 1c 24             	mov    %ebx,(%esp)
8010617f:	e8 fc b7 ff ff       	call   80101980 <iunlockput>
    ilock(ip);
80106184:	89 34 24             	mov    %esi,(%esp)
80106187:	e8 64 b5 ff ff       	call   801016f0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010618c:	83 7d c4 02          	cmpl   $0x2,-0x3c(%ebp)
80106190:	0f 85 9a 00 00 00    	jne    80106230 <create+0x110>
80106196:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010619b:	0f 85 8f 00 00 00    	jne    80106230 <create+0x110>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801061a1:	89 f0                	mov    %esi,%eax
801061a3:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801061a6:	8b 75 f8             	mov    -0x8(%ebp),%esi
801061a9:	8b 7d fc             	mov    -0x4(%ebp),%edi
801061ac:	89 ec                	mov    %ebp,%esp
801061ae:	5d                   	pop    %ebp
801061af:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
801061b0:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801061b3:	89 44 24 04          	mov    %eax,0x4(%esp)
801061b7:	8b 03                	mov    (%ebx),%eax
801061b9:	89 04 24             	mov    %eax,(%esp)
801061bc:	e8 af b3 ff ff       	call   80101570 <ialloc>
801061c1:	85 c0                	test   %eax,%eax
801061c3:	89 c6                	mov    %eax,%esi
801061c5:	0f 84 f0 00 00 00    	je     801062bb <create+0x19b>
  ilock(ip);
801061cb:	89 04 24             	mov    %eax,(%esp)
801061ce:	e8 1d b5 ff ff       	call   801016f0 <ilock>
  ip->major = major;
801061d3:	8b 45 c0             	mov    -0x40(%ebp),%eax
  ip->nlink = 1;
801061d6:	66 c7 46 56 01 00    	movw   $0x1,0x56(%esi)
  ip->major = major;
801061dc:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
801061e0:	8b 45 bc             	mov    -0x44(%ebp),%eax
801061e3:	66 89 46 54          	mov    %ax,0x54(%esi)
  iupdate(ip);
801061e7:	89 34 24             	mov    %esi,(%esp)
801061ea:	e8 41 b4 ff ff       	call   80101630 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
801061ef:	83 7d c4 01          	cmpl   $0x1,-0x3c(%ebp)
801061f3:	74 5b                	je     80106250 <create+0x130>
  if(dirlink(dp, name, ip->inum) < 0)
801061f5:	8b 46 04             	mov    0x4(%esi),%eax
801061f8:	89 7c 24 04          	mov    %edi,0x4(%esp)
801061fc:	89 1c 24             	mov    %ebx,(%esp)
801061ff:	89 44 24 08          	mov    %eax,0x8(%esp)
80106203:	e8 e8 bc ff ff       	call   80101ef0 <dirlink>
80106208:	85 c0                	test   %eax,%eax
8010620a:	0f 88 9f 00 00 00    	js     801062af <create+0x18f>
  iunlockput(dp);
80106210:	89 1c 24             	mov    %ebx,(%esp)
80106213:	e8 68 b7 ff ff       	call   80101980 <iunlockput>
}
80106218:	89 f0                	mov    %esi,%eax
8010621a:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010621d:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106220:	8b 7d fc             	mov    -0x4(%ebp),%edi
80106223:	89 ec                	mov    %ebp,%esp
80106225:	5d                   	pop    %ebp
80106226:	c3                   	ret    
80106227:	89 f6                	mov    %esi,%esi
80106229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80106230:	89 34 24             	mov    %esi,(%esp)
    return 0;
80106233:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80106235:	e8 46 b7 ff ff       	call   80101980 <iunlockput>
}
8010623a:	89 f0                	mov    %esi,%eax
8010623c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010623f:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106242:	8b 7d fc             	mov    -0x4(%ebp),%edi
80106245:	89 ec                	mov    %ebp,%esp
80106247:	5d                   	pop    %ebp
80106248:	c3                   	ret    
80106249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80106250:	66 ff 43 56          	incw   0x56(%ebx)
    iupdate(dp);
80106254:	89 1c 24             	mov    %ebx,(%esp)
80106257:	e8 d4 b3 ff ff       	call   80101630 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010625c:	8b 46 04             	mov    0x4(%esi),%eax
8010625f:	ba c4 90 10 80       	mov    $0x801090c4,%edx
80106264:	89 54 24 04          	mov    %edx,0x4(%esp)
80106268:	89 34 24             	mov    %esi,(%esp)
8010626b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010626f:	e8 7c bc ff ff       	call   80101ef0 <dirlink>
80106274:	85 c0                	test   %eax,%eax
80106276:	78 20                	js     80106298 <create+0x178>
80106278:	8b 43 04             	mov    0x4(%ebx),%eax
8010627b:	89 34 24             	mov    %esi,(%esp)
8010627e:	89 44 24 08          	mov    %eax,0x8(%esp)
80106282:	b8 c3 90 10 80       	mov    $0x801090c3,%eax
80106287:	89 44 24 04          	mov    %eax,0x4(%esp)
8010628b:	e8 60 bc ff ff       	call   80101ef0 <dirlink>
80106290:	85 c0                	test   %eax,%eax
80106292:	0f 89 5d ff ff ff    	jns    801061f5 <create+0xd5>
      panic("create dots");
80106298:	c7 04 24 b7 90 10 80 	movl   $0x801090b7,(%esp)
8010629f:	e8 cc a0 ff ff       	call   80100370 <panic>
801062a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
801062a8:	31 f6                	xor    %esi,%esi
801062aa:	e9 f2 fe ff ff       	jmp    801061a1 <create+0x81>
    panic("create: dirlink");
801062af:	c7 04 24 c6 90 10 80 	movl   $0x801090c6,(%esp)
801062b6:	e8 b5 a0 ff ff       	call   80100370 <panic>
    panic("create: ialloc");
801062bb:	c7 04 24 a8 90 10 80 	movl   $0x801090a8,(%esp)
801062c2:	e8 a9 a0 ff ff       	call   80100370 <panic>
801062c7:	89 f6                	mov    %esi,%esi
801062c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801062d0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
801062d0:	55                   	push   %ebp
801062d1:	89 e5                	mov    %esp,%ebp
801062d3:	56                   	push   %esi
801062d4:	89 d6                	mov    %edx,%esi
801062d6:	53                   	push   %ebx
801062d7:	89 c3                	mov    %eax,%ebx
801062d9:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
801062dc:	8d 45 f4             	lea    -0xc(%ebp),%eax
801062df:	89 44 24 04          	mov    %eax,0x4(%esp)
801062e3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801062ea:	e8 d1 fc ff ff       	call   80105fc0 <argint>
801062ef:	85 c0                	test   %eax,%eax
801062f1:	78 2d                	js     80106320 <argfd.constprop.0+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801062f3:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801062f7:	77 27                	ja     80106320 <argfd.constprop.0+0x50>
801062f9:	e8 a2 d6 ff ff       	call   801039a0 <myproc>
801062fe:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106301:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80106305:	85 c0                	test   %eax,%eax
80106307:	74 17                	je     80106320 <argfd.constprop.0+0x50>
  if(pfd)
80106309:	85 db                	test   %ebx,%ebx
8010630b:	74 02                	je     8010630f <argfd.constprop.0+0x3f>
    *pfd = fd;
8010630d:	89 13                	mov    %edx,(%ebx)
    *pf = f;
8010630f:	89 06                	mov    %eax,(%esi)
  return 0;
80106311:	31 c0                	xor    %eax,%eax
}
80106313:	83 c4 20             	add    $0x20,%esp
80106316:	5b                   	pop    %ebx
80106317:	5e                   	pop    %esi
80106318:	5d                   	pop    %ebp
80106319:	c3                   	ret    
8010631a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106320:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106325:	eb ec                	jmp    80106313 <argfd.constprop.0+0x43>
80106327:	89 f6                	mov    %esi,%esi
80106329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106330 <sys_dup>:
{
80106330:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80106331:	31 c0                	xor    %eax,%eax
{
80106333:	89 e5                	mov    %esp,%ebp
80106335:	56                   	push   %esi
80106336:	53                   	push   %ebx
80106337:	83 ec 20             	sub    $0x20,%esp
  if(argfd(0, 0, &f) < 0)
8010633a:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010633d:	e8 8e ff ff ff       	call   801062d0 <argfd.constprop.0>
80106342:	85 c0                	test   %eax,%eax
80106344:	78 3a                	js     80106380 <sys_dup+0x50>
  if((fd=fdalloc(f)) < 0)
80106346:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106349:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010634b:	e8 50 d6 ff ff       	call   801039a0 <myproc>
80106350:	eb 0c                	jmp    8010635e <sys_dup+0x2e>
80106352:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106358:	43                   	inc    %ebx
80106359:	83 fb 10             	cmp    $0x10,%ebx
8010635c:	74 22                	je     80106380 <sys_dup+0x50>
    if(curproc->ofile[fd] == 0){
8010635e:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80106362:	85 d2                	test   %edx,%edx
80106364:	75 f2                	jne    80106358 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80106366:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
8010636a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010636d:	89 04 24             	mov    %eax,(%esp)
80106370:	e8 6b aa ff ff       	call   80100de0 <filedup>
}
80106375:	83 c4 20             	add    $0x20,%esp
80106378:	89 d8                	mov    %ebx,%eax
8010637a:	5b                   	pop    %ebx
8010637b:	5e                   	pop    %esi
8010637c:	5d                   	pop    %ebp
8010637d:	c3                   	ret    
8010637e:	66 90                	xchg   %ax,%ax
80106380:	83 c4 20             	add    $0x20,%esp
    return -1;
80106383:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80106388:	89 d8                	mov    %ebx,%eax
8010638a:	5b                   	pop    %ebx
8010638b:	5e                   	pop    %esi
8010638c:	5d                   	pop    %ebp
8010638d:	c3                   	ret    
8010638e:	66 90                	xchg   %ax,%ax

80106390 <sys_read>:
{
80106390:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106391:	31 c0                	xor    %eax,%eax
{
80106393:	89 e5                	mov    %esp,%ebp
80106395:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106398:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010639b:	e8 30 ff ff ff       	call   801062d0 <argfd.constprop.0>
801063a0:	85 c0                	test   %eax,%eax
801063a2:	78 54                	js     801063f8 <sys_read+0x68>
801063a4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801063a7:	89 44 24 04          	mov    %eax,0x4(%esp)
801063ab:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801063b2:	e8 09 fc ff ff       	call   80105fc0 <argint>
801063b7:	85 c0                	test   %eax,%eax
801063b9:	78 3d                	js     801063f8 <sys_read+0x68>
801063bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801063be:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801063c5:	89 44 24 08          	mov    %eax,0x8(%esp)
801063c9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801063cc:	89 44 24 04          	mov    %eax,0x4(%esp)
801063d0:	e8 3b fc ff ff       	call   80106010 <argptr>
801063d5:	85 c0                	test   %eax,%eax
801063d7:	78 1f                	js     801063f8 <sys_read+0x68>
  return fileread(f, p, n);
801063d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801063dc:	89 44 24 08          	mov    %eax,0x8(%esp)
801063e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063e3:	89 44 24 04          	mov    %eax,0x4(%esp)
801063e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801063ea:	89 04 24             	mov    %eax,(%esp)
801063ed:	e8 6e ab ff ff       	call   80100f60 <fileread>
}
801063f2:	c9                   	leave  
801063f3:	c3                   	ret    
801063f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801063f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801063fd:	c9                   	leave  
801063fe:	c3                   	ret    
801063ff:	90                   	nop

80106400 <sys_write>:
{
80106400:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106401:	31 c0                	xor    %eax,%eax
{
80106403:	89 e5                	mov    %esp,%ebp
80106405:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106408:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010640b:	e8 c0 fe ff ff       	call   801062d0 <argfd.constprop.0>
80106410:	85 c0                	test   %eax,%eax
80106412:	78 54                	js     80106468 <sys_write+0x68>
80106414:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106417:	89 44 24 04          	mov    %eax,0x4(%esp)
8010641b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106422:	e8 99 fb ff ff       	call   80105fc0 <argint>
80106427:	85 c0                	test   %eax,%eax
80106429:	78 3d                	js     80106468 <sys_write+0x68>
8010642b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010642e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106435:	89 44 24 08          	mov    %eax,0x8(%esp)
80106439:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010643c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106440:	e8 cb fb ff ff       	call   80106010 <argptr>
80106445:	85 c0                	test   %eax,%eax
80106447:	78 1f                	js     80106468 <sys_write+0x68>
  return filewrite(f, p, n);
80106449:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010644c:	89 44 24 08          	mov    %eax,0x8(%esp)
80106450:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106453:	89 44 24 04          	mov    %eax,0x4(%esp)
80106457:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010645a:	89 04 24             	mov    %eax,(%esp)
8010645d:	e8 ae ab ff ff       	call   80101010 <filewrite>
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

80106470 <sys_close>:
{
80106470:	55                   	push   %ebp
80106471:	89 e5                	mov    %esp,%ebp
80106473:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, &fd, &f) < 0)
80106476:	8d 55 f4             	lea    -0xc(%ebp),%edx
80106479:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010647c:	e8 4f fe ff ff       	call   801062d0 <argfd.constprop.0>
80106481:	85 c0                	test   %eax,%eax
80106483:	78 23                	js     801064a8 <sys_close+0x38>
  myproc()->ofile[fd] = 0;
80106485:	e8 16 d5 ff ff       	call   801039a0 <myproc>
8010648a:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010648d:	31 c9                	xor    %ecx,%ecx
8010648f:	89 4c 90 28          	mov    %ecx,0x28(%eax,%edx,4)
  fileclose(f);
80106493:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106496:	89 04 24             	mov    %eax,(%esp)
80106499:	e8 92 a9 ff ff       	call   80100e30 <fileclose>
  return 0;
8010649e:	31 c0                	xor    %eax,%eax
}
801064a0:	c9                   	leave  
801064a1:	c3                   	ret    
801064a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801064a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801064ad:	c9                   	leave  
801064ae:	c3                   	ret    
801064af:	90                   	nop

801064b0 <sys_fstat>:
{
801064b0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801064b1:	31 c0                	xor    %eax,%eax
{
801064b3:	89 e5                	mov    %esp,%ebp
801064b5:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801064b8:	8d 55 f0             	lea    -0x10(%ebp),%edx
801064bb:	e8 10 fe ff ff       	call   801062d0 <argfd.constprop.0>
801064c0:	85 c0                	test   %eax,%eax
801064c2:	78 3c                	js     80106500 <sys_fstat+0x50>
801064c4:	b8 14 00 00 00       	mov    $0x14,%eax
801064c9:	89 44 24 08          	mov    %eax,0x8(%esp)
801064cd:	8d 45 f4             	lea    -0xc(%ebp),%eax
801064d0:	89 44 24 04          	mov    %eax,0x4(%esp)
801064d4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801064db:	e8 30 fb ff ff       	call   80106010 <argptr>
801064e0:	85 c0                	test   %eax,%eax
801064e2:	78 1c                	js     80106500 <sys_fstat+0x50>
  return filestat(f, st);
801064e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064e7:	89 44 24 04          	mov    %eax,0x4(%esp)
801064eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801064ee:	89 04 24             	mov    %eax,(%esp)
801064f1:	e8 1a aa ff ff       	call   80100f10 <filestat>
}
801064f6:	c9                   	leave  
801064f7:	c3                   	ret    
801064f8:	90                   	nop
801064f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106500:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106505:	c9                   	leave  
80106506:	c3                   	ret    
80106507:	89 f6                	mov    %esi,%esi
80106509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106510 <sys_link>:
{
80106510:	55                   	push   %ebp
80106511:	89 e5                	mov    %esp,%ebp
80106513:	57                   	push   %edi
80106514:	56                   	push   %esi
80106515:	53                   	push   %ebx
80106516:	83 ec 3c             	sub    $0x3c,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80106519:	8d 45 d4             	lea    -0x2c(%ebp),%eax
8010651c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106520:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106527:	e8 44 fb ff ff       	call   80106070 <argstr>
8010652c:	85 c0                	test   %eax,%eax
8010652e:	0f 88 e5 00 00 00    	js     80106619 <sys_link+0x109>
80106534:	8d 45 d0             	lea    -0x30(%ebp),%eax
80106537:	89 44 24 04          	mov    %eax,0x4(%esp)
8010653b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106542:	e8 29 fb ff ff       	call   80106070 <argstr>
80106547:	85 c0                	test   %eax,%eax
80106549:	0f 88 ca 00 00 00    	js     80106619 <sys_link+0x109>
  begin_op();
8010654f:	e8 3c c7 ff ff       	call   80102c90 <begin_op>
  if((ip = namei(old)) == 0){
80106554:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80106557:	89 04 24             	mov    %eax,(%esp)
8010655a:	e8 71 ba ff ff       	call   80101fd0 <namei>
8010655f:	85 c0                	test   %eax,%eax
80106561:	89 c3                	mov    %eax,%ebx
80106563:	0f 84 ab 00 00 00    	je     80106614 <sys_link+0x104>
  ilock(ip);
80106569:	89 04 24             	mov    %eax,(%esp)
8010656c:	e8 7f b1 ff ff       	call   801016f0 <ilock>
  if(ip->type == T_DIR){
80106571:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106576:	0f 84 90 00 00 00    	je     8010660c <sys_link+0xfc>
  ip->nlink++;
8010657c:	66 ff 43 56          	incw   0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80106580:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80106583:	89 1c 24             	mov    %ebx,(%esp)
80106586:	e8 a5 b0 ff ff       	call   80101630 <iupdate>
  iunlock(ip);
8010658b:	89 1c 24             	mov    %ebx,(%esp)
8010658e:	e8 3d b2 ff ff       	call   801017d0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80106593:	8b 45 d0             	mov    -0x30(%ebp),%eax
80106596:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010659a:	89 04 24             	mov    %eax,(%esp)
8010659d:	e8 4e ba ff ff       	call   80101ff0 <nameiparent>
801065a2:	85 c0                	test   %eax,%eax
801065a4:	89 c6                	mov    %eax,%esi
801065a6:	74 50                	je     801065f8 <sys_link+0xe8>
  ilock(dp);
801065a8:	89 04 24             	mov    %eax,(%esp)
801065ab:	e8 40 b1 ff ff       	call   801016f0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801065b0:	8b 03                	mov    (%ebx),%eax
801065b2:	39 06                	cmp    %eax,(%esi)
801065b4:	75 3a                	jne    801065f0 <sys_link+0xe0>
801065b6:	8b 43 04             	mov    0x4(%ebx),%eax
801065b9:	89 7c 24 04          	mov    %edi,0x4(%esp)
801065bd:	89 34 24             	mov    %esi,(%esp)
801065c0:	89 44 24 08          	mov    %eax,0x8(%esp)
801065c4:	e8 27 b9 ff ff       	call   80101ef0 <dirlink>
801065c9:	85 c0                	test   %eax,%eax
801065cb:	78 23                	js     801065f0 <sys_link+0xe0>
  iunlockput(dp);
801065cd:	89 34 24             	mov    %esi,(%esp)
801065d0:	e8 ab b3 ff ff       	call   80101980 <iunlockput>
  iput(ip);
801065d5:	89 1c 24             	mov    %ebx,(%esp)
801065d8:	e8 43 b2 ff ff       	call   80101820 <iput>
  end_op();
801065dd:	e8 1e c7 ff ff       	call   80102d00 <end_op>
}
801065e2:	83 c4 3c             	add    $0x3c,%esp
  return 0;
801065e5:	31 c0                	xor    %eax,%eax
}
801065e7:	5b                   	pop    %ebx
801065e8:	5e                   	pop    %esi
801065e9:	5f                   	pop    %edi
801065ea:	5d                   	pop    %ebp
801065eb:	c3                   	ret    
801065ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(dp);
801065f0:	89 34 24             	mov    %esi,(%esp)
801065f3:	e8 88 b3 ff ff       	call   80101980 <iunlockput>
  ilock(ip);
801065f8:	89 1c 24             	mov    %ebx,(%esp)
801065fb:	e8 f0 b0 ff ff       	call   801016f0 <ilock>
  ip->nlink--;
80106600:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
80106604:	89 1c 24             	mov    %ebx,(%esp)
80106607:	e8 24 b0 ff ff       	call   80101630 <iupdate>
  iunlockput(ip);
8010660c:	89 1c 24             	mov    %ebx,(%esp)
8010660f:	e8 6c b3 ff ff       	call   80101980 <iunlockput>
  end_op();
80106614:	e8 e7 c6 ff ff       	call   80102d00 <end_op>
}
80106619:	83 c4 3c             	add    $0x3c,%esp
  return -1;
8010661c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106621:	5b                   	pop    %ebx
80106622:	5e                   	pop    %esi
80106623:	5f                   	pop    %edi
80106624:	5d                   	pop    %ebp
80106625:	c3                   	ret    
80106626:	8d 76 00             	lea    0x0(%esi),%esi
80106629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106630 <sys_unlink>:
{
80106630:	55                   	push   %ebp
80106631:	89 e5                	mov    %esp,%ebp
80106633:	57                   	push   %edi
80106634:	56                   	push   %esi
80106635:	53                   	push   %ebx
80106636:	83 ec 5c             	sub    $0x5c,%esp
  if(argstr(0, &path) < 0)
80106639:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010663c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106640:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106647:	e8 24 fa ff ff       	call   80106070 <argstr>
8010664c:	85 c0                	test   %eax,%eax
8010664e:	0f 88 68 01 00 00    	js     801067bc <sys_unlink+0x18c>
  begin_op();
80106654:	e8 37 c6 ff ff       	call   80102c90 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80106659:	8b 45 c0             	mov    -0x40(%ebp),%eax
8010665c:	8d 5d ca             	lea    -0x36(%ebp),%ebx
8010665f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80106663:	89 04 24             	mov    %eax,(%esp)
80106666:	e8 85 b9 ff ff       	call   80101ff0 <nameiparent>
8010666b:	85 c0                	test   %eax,%eax
8010666d:	89 c6                	mov    %eax,%esi
8010666f:	0f 84 42 01 00 00    	je     801067b7 <sys_unlink+0x187>
  ilock(dp);
80106675:	89 04 24             	mov    %eax,(%esp)
80106678:	e8 73 b0 ff ff       	call   801016f0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010667d:	b8 c4 90 10 80       	mov    $0x801090c4,%eax
80106682:	89 44 24 04          	mov    %eax,0x4(%esp)
80106686:	89 1c 24             	mov    %ebx,(%esp)
80106689:	e8 b2 b5 ff ff       	call   80101c40 <namecmp>
8010668e:	85 c0                	test   %eax,%eax
80106690:	0f 84 19 01 00 00    	je     801067af <sys_unlink+0x17f>
80106696:	b8 c3 90 10 80       	mov    $0x801090c3,%eax
8010669b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010669f:	89 1c 24             	mov    %ebx,(%esp)
801066a2:	e8 99 b5 ff ff       	call   80101c40 <namecmp>
801066a7:	85 c0                	test   %eax,%eax
801066a9:	0f 84 00 01 00 00    	je     801067af <sys_unlink+0x17f>
  if((ip = dirlookup(dp, name, &off)) == 0)
801066af:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801066b2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801066b6:	89 44 24 08          	mov    %eax,0x8(%esp)
801066ba:	89 34 24             	mov    %esi,(%esp)
801066bd:	e8 ae b5 ff ff       	call   80101c70 <dirlookup>
801066c2:	85 c0                	test   %eax,%eax
801066c4:	89 c3                	mov    %eax,%ebx
801066c6:	0f 84 e3 00 00 00    	je     801067af <sys_unlink+0x17f>
  ilock(ip);
801066cc:	89 04 24             	mov    %eax,(%esp)
801066cf:	e8 1c b0 ff ff       	call   801016f0 <ilock>
  if(ip->nlink < 1)
801066d4:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801066d9:	0f 8e 0e 01 00 00    	jle    801067ed <sys_unlink+0x1bd>
  if(ip->type == T_DIR && !isdirempty(ip)){
801066df:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801066e4:	8d 7d d8             	lea    -0x28(%ebp),%edi
801066e7:	74 77                	je     80106760 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
801066e9:	31 d2                	xor    %edx,%edx
801066eb:	b8 10 00 00 00       	mov    $0x10,%eax
801066f0:	89 54 24 04          	mov    %edx,0x4(%esp)
801066f4:	89 44 24 08          	mov    %eax,0x8(%esp)
801066f8:	89 3c 24             	mov    %edi,(%esp)
801066fb:	e8 d0 f5 ff ff       	call   80105cd0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106700:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80106703:	b9 10 00 00 00       	mov    $0x10,%ecx
80106708:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
8010670c:	89 7c 24 04          	mov    %edi,0x4(%esp)
80106710:	89 34 24             	mov    %esi,(%esp)
80106713:	89 44 24 08          	mov    %eax,0x8(%esp)
80106717:	e8 d4 b3 ff ff       	call   80101af0 <writei>
8010671c:	83 f8 10             	cmp    $0x10,%eax
8010671f:	0f 85 d4 00 00 00    	jne    801067f9 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
80106725:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010672a:	0f 84 a0 00 00 00    	je     801067d0 <sys_unlink+0x1a0>
  iunlockput(dp);
80106730:	89 34 24             	mov    %esi,(%esp)
80106733:	e8 48 b2 ff ff       	call   80101980 <iunlockput>
  ip->nlink--;
80106738:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
8010673c:	89 1c 24             	mov    %ebx,(%esp)
8010673f:	e8 ec ae ff ff       	call   80101630 <iupdate>
  iunlockput(ip);
80106744:	89 1c 24             	mov    %ebx,(%esp)
80106747:	e8 34 b2 ff ff       	call   80101980 <iunlockput>
  end_op();
8010674c:	e8 af c5 ff ff       	call   80102d00 <end_op>
}
80106751:	83 c4 5c             	add    $0x5c,%esp
  return 0;
80106754:	31 c0                	xor    %eax,%eax
}
80106756:	5b                   	pop    %ebx
80106757:	5e                   	pop    %esi
80106758:	5f                   	pop    %edi
80106759:	5d                   	pop    %ebp
8010675a:	c3                   	ret    
8010675b:	90                   	nop
8010675c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80106760:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80106764:	76 83                	jbe    801066e9 <sys_unlink+0xb9>
80106766:	ba 20 00 00 00       	mov    $0x20,%edx
8010676b:	eb 0f                	jmp    8010677c <sys_unlink+0x14c>
8010676d:	8d 76 00             	lea    0x0(%esi),%esi
80106770:	83 c2 10             	add    $0x10,%edx
80106773:	3b 53 58             	cmp    0x58(%ebx),%edx
80106776:	0f 83 6d ff ff ff    	jae    801066e9 <sys_unlink+0xb9>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010677c:	b8 10 00 00 00       	mov    $0x10,%eax
80106781:	89 54 24 08          	mov    %edx,0x8(%esp)
80106785:	89 44 24 0c          	mov    %eax,0xc(%esp)
80106789:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010678d:	89 1c 24             	mov    %ebx,(%esp)
80106790:	89 55 b4             	mov    %edx,-0x4c(%ebp)
80106793:	e8 38 b2 ff ff       	call   801019d0 <readi>
80106798:	8b 55 b4             	mov    -0x4c(%ebp),%edx
8010679b:	83 f8 10             	cmp    $0x10,%eax
8010679e:	75 41                	jne    801067e1 <sys_unlink+0x1b1>
    if(de.inum != 0)
801067a0:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801067a5:	74 c9                	je     80106770 <sys_unlink+0x140>
    iunlockput(ip);
801067a7:	89 1c 24             	mov    %ebx,(%esp)
801067aa:	e8 d1 b1 ff ff       	call   80101980 <iunlockput>
  iunlockput(dp);
801067af:	89 34 24             	mov    %esi,(%esp)
801067b2:	e8 c9 b1 ff ff       	call   80101980 <iunlockput>
  end_op();
801067b7:	e8 44 c5 ff ff       	call   80102d00 <end_op>
}
801067bc:	83 c4 5c             	add    $0x5c,%esp
  return -1;
801067bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801067c4:	5b                   	pop    %ebx
801067c5:	5e                   	pop    %esi
801067c6:	5f                   	pop    %edi
801067c7:	5d                   	pop    %ebp
801067c8:	c3                   	ret    
801067c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
801067d0:	66 ff 4e 56          	decw   0x56(%esi)
    iupdate(dp);
801067d4:	89 34 24             	mov    %esi,(%esp)
801067d7:	e8 54 ae ff ff       	call   80101630 <iupdate>
801067dc:	e9 4f ff ff ff       	jmp    80106730 <sys_unlink+0x100>
      panic("isdirempty: readi");
801067e1:	c7 04 24 e8 90 10 80 	movl   $0x801090e8,(%esp)
801067e8:	e8 83 9b ff ff       	call   80100370 <panic>
    panic("unlink: nlink < 1");
801067ed:	c7 04 24 d6 90 10 80 	movl   $0x801090d6,(%esp)
801067f4:	e8 77 9b ff ff       	call   80100370 <panic>
    panic("unlink: writei");
801067f9:	c7 04 24 fa 90 10 80 	movl   $0x801090fa,(%esp)
80106800:	e8 6b 9b ff ff       	call   80100370 <panic>
80106805:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106810 <sys_open>:

int
sys_open(void)
{
80106810:	55                   	push   %ebp
80106811:	89 e5                	mov    %esp,%ebp
80106813:	57                   	push   %edi
80106814:	56                   	push   %esi
80106815:	53                   	push   %ebx
80106816:	83 ec 2c             	sub    $0x2c,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106819:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010681c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106820:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106827:	e8 44 f8 ff ff       	call   80106070 <argstr>
8010682c:	85 c0                	test   %eax,%eax
8010682e:	0f 88 e9 00 00 00    	js     8010691d <sys_open+0x10d>
80106834:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106837:	89 44 24 04          	mov    %eax,0x4(%esp)
8010683b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106842:	e8 79 f7 ff ff       	call   80105fc0 <argint>
80106847:	85 c0                	test   %eax,%eax
80106849:	0f 88 ce 00 00 00    	js     8010691d <sys_open+0x10d>
    return -1;

  begin_op();
8010684f:	e8 3c c4 ff ff       	call   80102c90 <begin_op>

  if(omode & O_CREATE){
80106854:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80106858:	0f 85 9a 00 00 00    	jne    801068f8 <sys_open+0xe8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
8010685e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106861:	89 04 24             	mov    %eax,(%esp)
80106864:	e8 67 b7 ff ff       	call   80101fd0 <namei>
80106869:	85 c0                	test   %eax,%eax
8010686b:	89 c6                	mov    %eax,%esi
8010686d:	0f 84 a5 00 00 00    	je     80106918 <sys_open+0x108>
      end_op();
      return -1;
    }
    ilock(ip);
80106873:	89 04 24             	mov    %eax,(%esp)
80106876:	e8 75 ae ff ff       	call   801016f0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
8010687b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80106880:	0f 84 a2 00 00 00    	je     80106928 <sys_open+0x118>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80106886:	e8 e5 a4 ff ff       	call   80100d70 <filealloc>
8010688b:	85 c0                	test   %eax,%eax
8010688d:	89 c7                	mov    %eax,%edi
8010688f:	0f 84 9e 00 00 00    	je     80106933 <sys_open+0x123>
  struct proc *curproc = myproc();
80106895:	e8 06 d1 ff ff       	call   801039a0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010689a:	31 db                	xor    %ebx,%ebx
8010689c:	eb 0c                	jmp    801068aa <sys_open+0x9a>
8010689e:	66 90                	xchg   %ax,%ax
801068a0:	43                   	inc    %ebx
801068a1:	83 fb 10             	cmp    $0x10,%ebx
801068a4:	0f 84 96 00 00 00    	je     80106940 <sys_open+0x130>
    if(curproc->ofile[fd] == 0){
801068aa:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801068ae:	85 d2                	test   %edx,%edx
801068b0:	75 ee                	jne    801068a0 <sys_open+0x90>
      curproc->ofile[fd] = f;
801068b2:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801068b6:	89 34 24             	mov    %esi,(%esp)
801068b9:	e8 12 af ff ff       	call   801017d0 <iunlock>
  end_op();
801068be:	e8 3d c4 ff ff       	call   80102d00 <end_op>

  f->type = FD_INODE;
801068c3:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801068c9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->ip = ip;
801068cc:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801068cf:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801068d6:	89 d0                	mov    %edx,%eax
801068d8:	f7 d0                	not    %eax
801068da:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801068dd:	f6 c2 03             	test   $0x3,%dl
  f->readable = !(omode & O_WRONLY);
801068e0:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801068e3:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801068e7:	83 c4 2c             	add    $0x2c,%esp
801068ea:	89 d8                	mov    %ebx,%eax
801068ec:	5b                   	pop    %ebx
801068ed:	5e                   	pop    %esi
801068ee:	5f                   	pop    %edi
801068ef:	5d                   	pop    %ebp
801068f0:	c3                   	ret    
801068f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
801068f8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801068fb:	31 c9                	xor    %ecx,%ecx
801068fd:	ba 02 00 00 00       	mov    $0x2,%edx
80106902:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106909:	e8 12 f8 ff ff       	call   80106120 <create>
    if(ip == 0){
8010690e:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80106910:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80106912:	0f 85 6e ff ff ff    	jne    80106886 <sys_open+0x76>
    end_op();
80106918:	e8 e3 c3 ff ff       	call   80102d00 <end_op>
    return -1;
8010691d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106922:	eb c3                	jmp    801068e7 <sys_open+0xd7>
80106924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80106928:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010692b:	85 c9                	test   %ecx,%ecx
8010692d:	0f 84 53 ff ff ff    	je     80106886 <sys_open+0x76>
    iunlockput(ip);
80106933:	89 34 24             	mov    %esi,(%esp)
80106936:	e8 45 b0 ff ff       	call   80101980 <iunlockput>
8010693b:	eb db                	jmp    80106918 <sys_open+0x108>
8010693d:	8d 76 00             	lea    0x0(%esi),%esi
      fileclose(f);
80106940:	89 3c 24             	mov    %edi,(%esp)
80106943:	e8 e8 a4 ff ff       	call   80100e30 <fileclose>
80106948:	eb e9                	jmp    80106933 <sys_open+0x123>
8010694a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106950 <sys_mkdir>:

int
sys_mkdir(void)
{
80106950:	55                   	push   %ebp
80106951:	89 e5                	mov    %esp,%ebp
80106953:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
80106956:	e8 35 c3 ff ff       	call   80102c90 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010695b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010695e:	89 44 24 04          	mov    %eax,0x4(%esp)
80106962:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106969:	e8 02 f7 ff ff       	call   80106070 <argstr>
8010696e:	85 c0                	test   %eax,%eax
80106970:	78 2e                	js     801069a0 <sys_mkdir+0x50>
80106972:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106975:	31 c9                	xor    %ecx,%ecx
80106977:	ba 01 00 00 00       	mov    $0x1,%edx
8010697c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106983:	e8 98 f7 ff ff       	call   80106120 <create>
80106988:	85 c0                	test   %eax,%eax
8010698a:	74 14                	je     801069a0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010698c:	89 04 24             	mov    %eax,(%esp)
8010698f:	e8 ec af ff ff       	call   80101980 <iunlockput>
  end_op();
80106994:	e8 67 c3 ff ff       	call   80102d00 <end_op>
  return 0;
80106999:	31 c0                	xor    %eax,%eax
}
8010699b:	c9                   	leave  
8010699c:	c3                   	ret    
8010699d:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
801069a0:	e8 5b c3 ff ff       	call   80102d00 <end_op>
    return -1;
801069a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801069aa:	c9                   	leave  
801069ab:	c3                   	ret    
801069ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801069b0 <sys_mknod>:

int
sys_mknod(void)
{
801069b0:	55                   	push   %ebp
801069b1:	89 e5                	mov    %esp,%ebp
801069b3:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801069b6:	e8 d5 c2 ff ff       	call   80102c90 <begin_op>
  if((argstr(0, &path)) < 0 ||
801069bb:	8d 45 ec             	lea    -0x14(%ebp),%eax
801069be:	89 44 24 04          	mov    %eax,0x4(%esp)
801069c2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801069c9:	e8 a2 f6 ff ff       	call   80106070 <argstr>
801069ce:	85 c0                	test   %eax,%eax
801069d0:	78 5e                	js     80106a30 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801069d2:	8d 45 f0             	lea    -0x10(%ebp),%eax
801069d5:	89 44 24 04          	mov    %eax,0x4(%esp)
801069d9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801069e0:	e8 db f5 ff ff       	call   80105fc0 <argint>
  if((argstr(0, &path)) < 0 ||
801069e5:	85 c0                	test   %eax,%eax
801069e7:	78 47                	js     80106a30 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801069e9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801069ec:	89 44 24 04          	mov    %eax,0x4(%esp)
801069f0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801069f7:	e8 c4 f5 ff ff       	call   80105fc0 <argint>
     argint(1, &major) < 0 ||
801069fc:	85 c0                	test   %eax,%eax
801069fe:	78 30                	js     80106a30 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80106a00:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
80106a04:	ba 03 00 00 00       	mov    $0x3,%edx
     (ip = create(path, T_DEV, major, minor)) == 0){
80106a09:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80106a0d:	89 04 24             	mov    %eax,(%esp)
     argint(2, &minor) < 0 ||
80106a10:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106a13:	e8 08 f7 ff ff       	call   80106120 <create>
80106a18:	85 c0                	test   %eax,%eax
80106a1a:	74 14                	je     80106a30 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80106a1c:	89 04 24             	mov    %eax,(%esp)
80106a1f:	e8 5c af ff ff       	call   80101980 <iunlockput>
  end_op();
80106a24:	e8 d7 c2 ff ff       	call   80102d00 <end_op>
  return 0;
80106a29:	31 c0                	xor    %eax,%eax
}
80106a2b:	c9                   	leave  
80106a2c:	c3                   	ret    
80106a2d:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
80106a30:	e8 cb c2 ff ff       	call   80102d00 <end_op>
    return -1;
80106a35:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106a3a:	c9                   	leave  
80106a3b:	c3                   	ret    
80106a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106a40 <sys_chdir>:

int
sys_chdir(void)
{
80106a40:	55                   	push   %ebp
80106a41:	89 e5                	mov    %esp,%ebp
80106a43:	56                   	push   %esi
80106a44:	53                   	push   %ebx
80106a45:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80106a48:	e8 53 cf ff ff       	call   801039a0 <myproc>
80106a4d:	89 c6                	mov    %eax,%esi
  
  begin_op();
80106a4f:	e8 3c c2 ff ff       	call   80102c90 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106a54:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106a57:	89 44 24 04          	mov    %eax,0x4(%esp)
80106a5b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106a62:	e8 09 f6 ff ff       	call   80106070 <argstr>
80106a67:	85 c0                	test   %eax,%eax
80106a69:	78 4a                	js     80106ab5 <sys_chdir+0x75>
80106a6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a6e:	89 04 24             	mov    %eax,(%esp)
80106a71:	e8 5a b5 ff ff       	call   80101fd0 <namei>
80106a76:	85 c0                	test   %eax,%eax
80106a78:	89 c3                	mov    %eax,%ebx
80106a7a:	74 39                	je     80106ab5 <sys_chdir+0x75>
    end_op();
    return -1;
  }
  ilock(ip);
80106a7c:	89 04 24             	mov    %eax,(%esp)
80106a7f:	e8 6c ac ff ff       	call   801016f0 <ilock>
  if(ip->type != T_DIR){
80106a84:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
    iunlockput(ip);
80106a89:	89 1c 24             	mov    %ebx,(%esp)
  if(ip->type != T_DIR){
80106a8c:	75 22                	jne    80106ab0 <sys_chdir+0x70>
    end_op();
    return -1;
  }
  iunlock(ip);
80106a8e:	e8 3d ad ff ff       	call   801017d0 <iunlock>
  iput(curproc->cwd);
80106a93:	8b 46 68             	mov    0x68(%esi),%eax
80106a96:	89 04 24             	mov    %eax,(%esp)
80106a99:	e8 82 ad ff ff       	call   80101820 <iput>
  end_op();
80106a9e:	e8 5d c2 ff ff       	call   80102d00 <end_op>
  curproc->cwd = ip;
  return 0;
80106aa3:	31 c0                	xor    %eax,%eax
  curproc->cwd = ip;
80106aa5:	89 5e 68             	mov    %ebx,0x68(%esi)
}
80106aa8:	83 c4 20             	add    $0x20,%esp
80106aab:	5b                   	pop    %ebx
80106aac:	5e                   	pop    %esi
80106aad:	5d                   	pop    %ebp
80106aae:	c3                   	ret    
80106aaf:	90                   	nop
    iunlockput(ip);
80106ab0:	e8 cb ae ff ff       	call   80101980 <iunlockput>
    end_op();
80106ab5:	e8 46 c2 ff ff       	call   80102d00 <end_op>
    return -1;
80106aba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106abf:	eb e7                	jmp    80106aa8 <sys_chdir+0x68>
80106ac1:	eb 0d                	jmp    80106ad0 <sys_exec>
80106ac3:	90                   	nop
80106ac4:	90                   	nop
80106ac5:	90                   	nop
80106ac6:	90                   	nop
80106ac7:	90                   	nop
80106ac8:	90                   	nop
80106ac9:	90                   	nop
80106aca:	90                   	nop
80106acb:	90                   	nop
80106acc:	90                   	nop
80106acd:	90                   	nop
80106ace:	90                   	nop
80106acf:	90                   	nop

80106ad0 <sys_exec>:

int
sys_exec(void)
{
80106ad0:	55                   	push   %ebp
80106ad1:	89 e5                	mov    %esp,%ebp
80106ad3:	57                   	push   %edi
80106ad4:	56                   	push   %esi
80106ad5:	53                   	push   %ebx
80106ad6:	81 ec ac 00 00 00    	sub    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106adc:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80106ae2:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ae6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106aed:	e8 7e f5 ff ff       	call   80106070 <argstr>
80106af2:	85 c0                	test   %eax,%eax
80106af4:	0f 88 8e 00 00 00    	js     80106b88 <sys_exec+0xb8>
80106afa:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80106b00:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b04:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106b0b:	e8 b0 f4 ff ff       	call   80105fc0 <argint>
80106b10:	85 c0                	test   %eax,%eax
80106b12:	78 74                	js     80106b88 <sys_exec+0xb8>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80106b14:	ba 80 00 00 00       	mov    $0x80,%edx
80106b19:	31 c9                	xor    %ecx,%ecx
80106b1b:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
80106b21:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80106b23:	89 54 24 08          	mov    %edx,0x8(%esp)
80106b27:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80106b2d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80106b31:	89 04 24             	mov    %eax,(%esp)
80106b34:	e8 97 f1 ff ff       	call   80105cd0 <memset>
80106b39:	eb 2e                	jmp    80106b69 <sys_exec+0x99>
80106b3b:	90                   	nop
80106b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80106b40:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80106b46:	85 c0                	test   %eax,%eax
80106b48:	74 56                	je     80106ba0 <sys_exec+0xd0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106b4a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80106b50:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80106b53:	89 54 24 04          	mov    %edx,0x4(%esp)
80106b57:	89 04 24             	mov    %eax,(%esp)
80106b5a:	e8 01 f4 ff ff       	call   80105f60 <fetchstr>
80106b5f:	85 c0                	test   %eax,%eax
80106b61:	78 25                	js     80106b88 <sys_exec+0xb8>
  for(i=0;; i++){
80106b63:	43                   	inc    %ebx
    if(i >= NELEM(argv))
80106b64:	83 fb 20             	cmp    $0x20,%ebx
80106b67:	74 1f                	je     80106b88 <sys_exec+0xb8>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106b69:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106b6f:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80106b76:	89 7c 24 04          	mov    %edi,0x4(%esp)
80106b7a:	01 f0                	add    %esi,%eax
80106b7c:	89 04 24             	mov    %eax,(%esp)
80106b7f:	e8 9c f3 ff ff       	call   80105f20 <fetchint>
80106b84:	85 c0                	test   %eax,%eax
80106b86:	79 b8                	jns    80106b40 <sys_exec+0x70>
      return -1;
  }
  return exec(path, argv);
}
80106b88:	81 c4 ac 00 00 00    	add    $0xac,%esp
    return -1;
80106b8e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b93:	5b                   	pop    %ebx
80106b94:	5e                   	pop    %esi
80106b95:	5f                   	pop    %edi
80106b96:	5d                   	pop    %ebp
80106b97:	c3                   	ret    
80106b98:	90                   	nop
80106b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80106ba0:	31 c0                	xor    %eax,%eax
80106ba2:	89 84 9d 68 ff ff ff 	mov    %eax,-0x98(%ebp,%ebx,4)
  return exec(path, argv);
80106ba9:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106baf:	89 44 24 04          	mov    %eax,0x4(%esp)
80106bb3:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
80106bb9:	89 04 24             	mov    %eax,(%esp)
80106bbc:	e8 0f 9e ff ff       	call   801009d0 <exec>
}
80106bc1:	81 c4 ac 00 00 00    	add    $0xac,%esp
80106bc7:	5b                   	pop    %ebx
80106bc8:	5e                   	pop    %esi
80106bc9:	5f                   	pop    %edi
80106bca:	5d                   	pop    %ebp
80106bcb:	c3                   	ret    
80106bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106bd0 <sys_pipe>:

int
sys_pipe(void)
{
80106bd0:	55                   	push   %ebp
80106bd1:	89 e5                	mov    %esp,%ebp
80106bd3:	57                   	push   %edi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106bd4:	bf 08 00 00 00       	mov    $0x8,%edi
{
80106bd9:	56                   	push   %esi
80106bda:	53                   	push   %ebx
80106bdb:	83 ec 2c             	sub    $0x2c,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106bde:	8d 45 dc             	lea    -0x24(%ebp),%eax
80106be1:	89 7c 24 08          	mov    %edi,0x8(%esp)
80106be5:	89 44 24 04          	mov    %eax,0x4(%esp)
80106be9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106bf0:	e8 1b f4 ff ff       	call   80106010 <argptr>
80106bf5:	85 c0                	test   %eax,%eax
80106bf7:	0f 88 a9 00 00 00    	js     80106ca6 <sys_pipe+0xd6>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80106bfd:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106c00:	89 44 24 04          	mov    %eax,0x4(%esp)
80106c04:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106c07:	89 04 24             	mov    %eax,(%esp)
80106c0a:	e8 b1 c7 ff ff       	call   801033c0 <pipealloc>
80106c0f:	85 c0                	test   %eax,%eax
80106c11:	0f 88 8f 00 00 00    	js     80106ca6 <sys_pipe+0xd6>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106c17:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80106c1a:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80106c1c:	e8 7f cd ff ff       	call   801039a0 <myproc>
80106c21:	eb 0b                	jmp    80106c2e <sys_pipe+0x5e>
80106c23:	90                   	nop
80106c24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106c28:	43                   	inc    %ebx
80106c29:	83 fb 10             	cmp    $0x10,%ebx
80106c2c:	74 62                	je     80106c90 <sys_pipe+0xc0>
    if(curproc->ofile[fd] == 0){
80106c2e:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80106c32:	85 f6                	test   %esi,%esi
80106c34:	75 f2                	jne    80106c28 <sys_pipe+0x58>
      curproc->ofile[fd] = f;
80106c36:	8d 73 08             	lea    0x8(%ebx),%esi
80106c39:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106c3d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80106c40:	e8 5b cd ff ff       	call   801039a0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106c45:	31 d2                	xor    %edx,%edx
80106c47:	eb 0d                	jmp    80106c56 <sys_pipe+0x86>
80106c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c50:	42                   	inc    %edx
80106c51:	83 fa 10             	cmp    $0x10,%edx
80106c54:	74 2a                	je     80106c80 <sys_pipe+0xb0>
    if(curproc->ofile[fd] == 0){
80106c56:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80106c5a:	85 c9                	test   %ecx,%ecx
80106c5c:	75 f2                	jne    80106c50 <sys_pipe+0x80>
      curproc->ofile[fd] = f;
80106c5e:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80106c62:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106c65:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106c67:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106c6a:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80106c6d:	31 c0                	xor    %eax,%eax
}
80106c6f:	83 c4 2c             	add    $0x2c,%esp
80106c72:	5b                   	pop    %ebx
80106c73:	5e                   	pop    %esi
80106c74:	5f                   	pop    %edi
80106c75:	5d                   	pop    %ebp
80106c76:	c3                   	ret    
80106c77:	89 f6                	mov    %esi,%esi
80106c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      myproc()->ofile[fd0] = 0;
80106c80:	e8 1b cd ff ff       	call   801039a0 <myproc>
80106c85:	31 d2                	xor    %edx,%edx
80106c87:	89 54 b0 08          	mov    %edx,0x8(%eax,%esi,4)
80106c8b:	90                   	nop
80106c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fileclose(rf);
80106c90:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106c93:	89 04 24             	mov    %eax,(%esp)
80106c96:	e8 95 a1 ff ff       	call   80100e30 <fileclose>
    fileclose(wf);
80106c9b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106c9e:	89 04 24             	mov    %eax,(%esp)
80106ca1:	e8 8a a1 ff ff       	call   80100e30 <fileclose>
    return -1;
80106ca6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106cab:	eb c2                	jmp    80106c6f <sys_pipe+0x9f>
80106cad:	66 90                	xchg   %ax,%ax
80106caf:	90                   	nop

80106cb0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106cb0:	55                   	push   %ebp
80106cb1:	89 e5                	mov    %esp,%ebp
  return fork();
}
80106cb3:	5d                   	pop    %ebp
  return fork();
80106cb4:	e9 c7 cf ff ff       	jmp    80103c80 <fork>
80106cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106cc0 <sys_exit>:

int
sys_exit(void)
{
80106cc0:	55                   	push   %ebp
80106cc1:	89 e5                	mov    %esp,%ebp
80106cc3:	83 ec 28             	sub    $0x28,%esp
  int status;

  if(argint(0, &status) < 0)
80106cc6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106cc9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ccd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106cd4:	e8 e7 f2 ff ff       	call   80105fc0 <argint>
80106cd9:	85 c0                	test   %eax,%eax
80106cdb:	78 13                	js     80106cf0 <sys_exit+0x30>
    return -1;
  exit(status);
80106cdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ce0:	89 04 24             	mov    %eax,(%esp)
80106ce3:	e8 08 d6 ff ff       	call   801042f0 <exit>
  return 0;  // not reached
80106ce8:	31 c0                	xor    %eax,%eax
}
80106cea:	c9                   	leave  
80106ceb:	c3                   	ret    
80106cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106cf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106cf5:	c9                   	leave  
80106cf6:	c3                   	ret    
80106cf7:	89 f6                	mov    %esi,%esi
80106cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d00 <sys_wait>:

int
sys_wait(void)
{
80106d00:	55                   	push   %ebp
  int *status;

  if(argptr(0, (char**)(&status), sizeof(int)) < 0)
80106d01:	b8 04 00 00 00       	mov    $0x4,%eax
{
80106d06:	89 e5                	mov    %esp,%ebp
80106d08:	83 ec 28             	sub    $0x28,%esp
  if(argptr(0, (char**)(&status), sizeof(int)) < 0)
80106d0b:	89 44 24 08          	mov    %eax,0x8(%esp)
80106d0f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106d12:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d16:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106d1d:	e8 ee f2 ff ff       	call   80106010 <argptr>
80106d22:	85 c0                	test   %eax,%eax
80106d24:	78 12                	js     80106d38 <sys_wait+0x38>
    return -1;
  return wait(status);
80106d26:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d29:	89 04 24             	mov    %eax,(%esp)
80106d2c:	e8 5f d8 ff ff       	call   80104590 <wait>
  //return wait();
}
80106d31:	c9                   	leave  
80106d32:	c3                   	ret    
80106d33:	90                   	nop
80106d34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106d38:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106d3d:	c9                   	leave  
80106d3e:	c3                   	ret    
80106d3f:	90                   	nop

80106d40 <sys_kill>:

int
sys_kill(void)
{
80106d40:	55                   	push   %ebp
80106d41:	89 e5                	mov    %esp,%ebp
80106d43:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106d46:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106d49:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d4d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106d54:	e8 67 f2 ff ff       	call   80105fc0 <argint>
80106d59:	85 c0                	test   %eax,%eax
80106d5b:	78 13                	js     80106d70 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106d5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d60:	89 04 24             	mov    %eax,(%esp)
80106d63:	e8 68 d9 ff ff       	call   801046d0 <kill>
}
80106d68:	c9                   	leave  
80106d69:	c3                   	ret    
80106d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106d70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106d75:	c9                   	leave  
80106d76:	c3                   	ret    
80106d77:	89 f6                	mov    %esi,%esi
80106d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d80 <sys_getpid>:

int
sys_getpid(void)
{
80106d80:	55                   	push   %ebp
80106d81:	89 e5                	mov    %esp,%ebp
80106d83:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106d86:	e8 15 cc ff ff       	call   801039a0 <myproc>
80106d8b:	8b 40 10             	mov    0x10(%eax),%eax
}
80106d8e:	c9                   	leave  
80106d8f:	c3                   	ret    

80106d90 <sys_sbrk>:

int
sys_sbrk(void)
{
80106d90:	55                   	push   %ebp
80106d91:	89 e5                	mov    %esp,%ebp
80106d93:	53                   	push   %ebx
80106d94:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106d97:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106d9a:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d9e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106da5:	e8 16 f2 ff ff       	call   80105fc0 <argint>
80106daa:	85 c0                	test   %eax,%eax
80106dac:	78 22                	js     80106dd0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106dae:	e8 ed cb ff ff       	call   801039a0 <myproc>
80106db3:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106db5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106db8:	89 04 24             	mov    %eax,(%esp)
80106dbb:	e8 10 cc ff ff       	call   801039d0 <growproc>
80106dc0:	85 c0                	test   %eax,%eax
80106dc2:	78 0c                	js     80106dd0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106dc4:	83 c4 24             	add    $0x24,%esp
80106dc7:	89 d8                	mov    %ebx,%eax
80106dc9:	5b                   	pop    %ebx
80106dca:	5d                   	pop    %ebp
80106dcb:	c3                   	ret    
80106dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106dd0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106dd5:	eb ed                	jmp    80106dc4 <sys_sbrk+0x34>
80106dd7:	89 f6                	mov    %esi,%esi
80106dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106de0 <sys_sleep>:

int
sys_sleep(void)
{
80106de0:	55                   	push   %ebp
80106de1:	89 e5                	mov    %esp,%ebp
80106de3:	53                   	push   %ebx
80106de4:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106de7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106dea:	89 44 24 04          	mov    %eax,0x4(%esp)
80106dee:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106df5:	e8 c6 f1 ff ff       	call   80105fc0 <argint>
80106dfa:	85 c0                	test   %eax,%eax
80106dfc:	78 7e                	js     80106e7c <sys_sleep+0x9c>
    return -1;
  acquire(&tickslock);
80106dfe:	c7 04 24 e0 77 11 80 	movl   $0x801177e0,(%esp)
80106e05:	e8 d6 ed ff ff       	call   80105be0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106e0a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  ticks0 = ticks;
80106e0d:	8b 1d 20 80 11 80    	mov    0x80118020,%ebx
  while(ticks - ticks0 < n){
80106e13:	85 c9                	test   %ecx,%ecx
80106e15:	75 2a                	jne    80106e41 <sys_sleep+0x61>
80106e17:	eb 4f                	jmp    80106e68 <sys_sleep+0x88>
80106e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106e20:	b8 e0 77 11 80       	mov    $0x801177e0,%eax
80106e25:	89 44 24 04          	mov    %eax,0x4(%esp)
80106e29:	c7 04 24 20 80 11 80 	movl   $0x80118020,(%esp)
80106e30:	e8 6b d6 ff ff       	call   801044a0 <sleep>
  while(ticks - ticks0 < n){
80106e35:	a1 20 80 11 80       	mov    0x80118020,%eax
80106e3a:	29 d8                	sub    %ebx,%eax
80106e3c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80106e3f:	73 27                	jae    80106e68 <sys_sleep+0x88>
    if(myproc()->killed){
80106e41:	e8 5a cb ff ff       	call   801039a0 <myproc>
80106e46:	8b 50 24             	mov    0x24(%eax),%edx
80106e49:	85 d2                	test   %edx,%edx
80106e4b:	74 d3                	je     80106e20 <sys_sleep+0x40>
      release(&tickslock);
80106e4d:	c7 04 24 e0 77 11 80 	movl   $0x801177e0,(%esp)
80106e54:	e8 27 ee ff ff       	call   80105c80 <release>
  }
  release(&tickslock);
  return 0;
}
80106e59:	83 c4 24             	add    $0x24,%esp
      return -1;
80106e5c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106e61:	5b                   	pop    %ebx
80106e62:	5d                   	pop    %ebp
80106e63:	c3                   	ret    
80106e64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&tickslock);
80106e68:	c7 04 24 e0 77 11 80 	movl   $0x801177e0,(%esp)
80106e6f:	e8 0c ee ff ff       	call   80105c80 <release>
  return 0;
80106e74:	31 c0                	xor    %eax,%eax
}
80106e76:	83 c4 24             	add    $0x24,%esp
80106e79:	5b                   	pop    %ebx
80106e7a:	5d                   	pop    %ebp
80106e7b:	c3                   	ret    
    return -1;
80106e7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106e81:	eb f3                	jmp    80106e76 <sys_sleep+0x96>
80106e83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e90 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106e90:	55                   	push   %ebp
80106e91:	89 e5                	mov    %esp,%ebp
80106e93:	53                   	push   %ebx
80106e94:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

  acquire(&tickslock);
80106e97:	c7 04 24 e0 77 11 80 	movl   $0x801177e0,(%esp)
80106e9e:	e8 3d ed ff ff       	call   80105be0 <acquire>
  xticks = ticks;
80106ea3:	8b 1d 20 80 11 80    	mov    0x80118020,%ebx
  release(&tickslock);
80106ea9:	c7 04 24 e0 77 11 80 	movl   $0x801177e0,(%esp)
80106eb0:	e8 cb ed ff ff       	call   80105c80 <release>
  return xticks;
}
80106eb5:	83 c4 14             	add    $0x14,%esp
80106eb8:	89 d8                	mov    %ebx,%eax
80106eba:	5b                   	pop    %ebx
80106ebb:	5d                   	pop    %ebp
80106ebc:	c3                   	ret    
80106ebd:	8d 76 00             	lea    0x0(%esi),%esi

80106ec0 <sys_detach>:

// transfer a child process with the given pid from the parent to the init process.
// return 0 when succseeds or -1 if the process has no child with this pid.
int
sys_detach(void)
{
80106ec0:	55                   	push   %ebp
80106ec1:	89 e5                	mov    %esp,%ebp
80106ec3:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106ec6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106ec9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ecd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106ed4:	e8 e7 f0 ff ff       	call   80105fc0 <argint>
80106ed9:	85 c0                	test   %eax,%eax
80106edb:	78 13                	js     80106ef0 <sys_detach+0x30>
    return -1;
  return detach(pid);
80106edd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ee0:	89 04 24             	mov    %eax,(%esp)
80106ee3:	e8 a8 d8 ff ff       	call   80104790 <detach>
}
80106ee8:	c9                   	leave  
80106ee9:	c3                   	ret    
80106eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106ef0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ef5:	c9                   	leave  
80106ef6:	c3                   	ret    
80106ef7:	89 f6                	mov    %esi,%esi
80106ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f00 <sys_priority>:

//used by a process to change its priority
int
sys_priority(void)
{
80106f00:	55                   	push   %ebp
80106f01:	89 e5                	mov    %esp,%ebp
80106f03:	83 ec 28             	sub    $0x28,%esp
  int proc_priority;

  if(argint(0, &proc_priority) < 0)
80106f06:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106f09:	89 44 24 04          	mov    %eax,0x4(%esp)
80106f0d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106f14:	e8 a7 f0 ff ff       	call   80105fc0 <argint>
80106f19:	85 c0                	test   %eax,%eax
80106f1b:	78 13                	js     80106f30 <sys_priority+0x30>
    return -1;
  priority(proc_priority);
80106f1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f20:	89 04 24             	mov    %eax,(%esp)
80106f23:	e8 28 d9 ff ff       	call   80104850 <priority>
  return 0;
80106f28:	31 c0                	xor    %eax,%eax
}
80106f2a:	c9                   	leave  
80106f2b:	c3                   	ret    
80106f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106f30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106f35:	c9                   	leave  
80106f36:	c3                   	ret    
80106f37:	89 f6                	mov    %esi,%esi
80106f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f40 <sys_policy>:

// receives a policy identifier as an argument and changes the currently used policy.
int
sys_policy(void)
{
80106f40:	55                   	push   %ebp
80106f41:	89 e5                	mov    %esp,%ebp
80106f43:	83 ec 28             	sub    $0x28,%esp
  int policy_id;

  if(argint(0, &policy_id) < 0)
80106f46:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106f49:	89 44 24 04          	mov    %eax,0x4(%esp)
80106f4d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106f54:	e8 67 f0 ff ff       	call   80105fc0 <argint>
80106f59:	85 c0                	test   %eax,%eax
80106f5b:	78 13                	js     80106f70 <sys_policy+0x30>
    return -1;
  policy(policy_id);
80106f5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f60:	89 04 24             	mov    %eax,(%esp)
80106f63:	e8 68 d9 ff ff       	call   801048d0 <policy>
  return 0;
80106f68:	31 c0                	xor    %eax,%eax
}
80106f6a:	c9                   	leave  
80106f6b:	c3                   	ret    
80106f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106f70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106f75:	c9                   	leave  
80106f76:	c3                   	ret    
80106f77:	89 f6                	mov    %esi,%esi
80106f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f80 <sys_wait_stat>:

// return the pid of the terminated child process or -1 upon failure.
int
sys_wait_stat(void)
{
80106f80:	55                   	push   %ebp
     int* status;
     struct perf* perform;

     if ((argptr(0, (char**)(&status), sizeof(int)) < 0) || (argptr(0, (void*)(&perform), sizeof(*perform)) < 0))
80106f81:	ba 04 00 00 00       	mov    $0x4,%edx
{
80106f86:	89 e5                	mov    %esp,%ebp
80106f88:	83 ec 28             	sub    $0x28,%esp
     if ((argptr(0, (char**)(&status), sizeof(int)) < 0) || (argptr(0, (void*)(&perform), sizeof(*perform)) < 0))
80106f8b:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106f8e:	89 54 24 08          	mov    %edx,0x8(%esp)
80106f92:	89 44 24 04          	mov    %eax,0x4(%esp)
80106f96:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106f9d:	e8 6e f0 ff ff       	call   80106010 <argptr>
80106fa2:	85 c0                	test   %eax,%eax
80106fa4:	78 3a                	js     80106fe0 <sys_wait_stat+0x60>
80106fa6:	b8 14 00 00 00       	mov    $0x14,%eax
80106fab:	89 44 24 08          	mov    %eax,0x8(%esp)
80106faf:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106fb2:	89 44 24 04          	mov    %eax,0x4(%esp)
80106fb6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106fbd:	e8 4e f0 ff ff       	call   80106010 <argptr>
80106fc2:	85 c0                	test   %eax,%eax
80106fc4:	78 1a                	js     80106fe0 <sys_wait_stat+0x60>
        return -1;
    return wait_stat(status,perform);
80106fc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106fc9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106fcd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106fd0:	89 04 24             	mov    %eax,(%esp)
80106fd3:	e8 c8 da ff ff       	call   80104aa0 <wait_stat>
}
80106fd8:	c9                   	leave  
80106fd9:	c3                   	ret    
80106fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
80106fe0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106fe5:	c9                   	leave  
80106fe6:	c3                   	ret    

80106fe7 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106fe7:	1e                   	push   %ds
  pushl %es
80106fe8:	06                   	push   %es
  pushl %fs
80106fe9:	0f a0                	push   %fs
  pushl %gs
80106feb:	0f a8                	push   %gs
  pushal
80106fed:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106fee:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106ff2:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106ff4:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106ff6:	54                   	push   %esp
  call trap
80106ff7:	e8 c4 00 00 00       	call   801070c0 <trap>
  addl $4, %esp
80106ffc:	83 c4 04             	add    $0x4,%esp

80106fff <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106fff:	61                   	popa   
  popl %gs
80107000:	0f a9                	pop    %gs
  popl %fs
80107002:	0f a1                	pop    %fs
  popl %es
80107004:	07                   	pop    %es
  popl %ds
80107005:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80107006:	83 c4 08             	add    $0x8,%esp
  iret
80107009:	cf                   	iret   
8010700a:	66 90                	xchg   %ax,%ax
8010700c:	66 90                	xchg   %ax,%ax
8010700e:	66 90                	xchg   %ax,%ax

80107010 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80107010:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80107011:	31 c0                	xor    %eax,%eax
{
80107013:	89 e5                	mov    %esp,%ebp
80107015:	83 ec 18             	sub    $0x18,%esp
80107018:	90                   	nop
80107019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80107020:	8b 14 85 0c c0 10 80 	mov    -0x7fef3ff4(,%eax,4),%edx
80107027:	b9 08 00 00 8e       	mov    $0x8e000008,%ecx
8010702c:	89 0c c5 22 78 11 80 	mov    %ecx,-0x7fee87de(,%eax,8)
80107033:	66 89 14 c5 20 78 11 	mov    %dx,-0x7fee87e0(,%eax,8)
8010703a:	80 
8010703b:	c1 ea 10             	shr    $0x10,%edx
8010703e:	66 89 14 c5 26 78 11 	mov    %dx,-0x7fee87da(,%eax,8)
80107045:	80 
  for(i = 0; i < 256; i++)
80107046:	40                   	inc    %eax
80107047:	3d 00 01 00 00       	cmp    $0x100,%eax
8010704c:	75 d2                	jne    80107020 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010704e:	a1 0c c1 10 80       	mov    0x8010c10c,%eax

  initlock(&tickslock, "time");
80107053:	b9 09 91 10 80       	mov    $0x80109109,%ecx
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80107058:	ba 08 00 00 ef       	mov    $0xef000008,%edx
  initlock(&tickslock, "time");
8010705d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80107061:	c7 04 24 e0 77 11 80 	movl   $0x801177e0,(%esp)
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80107068:	89 15 22 7a 11 80    	mov    %edx,0x80117a22
8010706e:	66 a3 20 7a 11 80    	mov    %ax,0x80117a20
80107074:	c1 e8 10             	shr    $0x10,%eax
80107077:	66 a3 26 7a 11 80    	mov    %ax,0x80117a26
  initlock(&tickslock, "time");
8010707d:	e8 0e ea ff ff       	call   80105a90 <initlock>
}
80107082:	c9                   	leave  
80107083:	c3                   	ret    
80107084:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010708a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107090 <idtinit>:

void
idtinit(void)
{
80107090:	55                   	push   %ebp
  pd[1] = (uint)p;
80107091:	b8 20 78 11 80       	mov    $0x80117820,%eax
80107096:	89 e5                	mov    %esp,%ebp
80107098:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
8010709b:	c1 e8 10             	shr    $0x10,%eax
8010709e:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
801070a1:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
801070a7:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801070ab:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801070af:	8d 45 fa             	lea    -0x6(%ebp),%eax
801070b2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801070b5:	c9                   	leave  
801070b6:	c3                   	ret    
801070b7:	89 f6                	mov    %esi,%esi
801070b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801070c0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801070c0:	55                   	push   %ebp
801070c1:	89 e5                	mov    %esp,%ebp
801070c3:	83 ec 48             	sub    $0x48,%esp
801070c6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801070c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801070cc:	89 75 f8             	mov    %esi,-0x8(%ebp)
801070cf:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(tf->trapno == T_SYSCALL){
801070d2:	8b 43 30             	mov    0x30(%ebx),%eax
801070d5:	83 f8 40             	cmp    $0x40,%eax
801070d8:	0f 84 02 01 00 00    	je     801071e0 <trap+0x120>
    if(myproc()->killed)
      exit(0);
    return;
  }

  switch(tf->trapno){
801070de:	83 e8 20             	sub    $0x20,%eax
801070e1:	83 f8 1f             	cmp    $0x1f,%eax
801070e4:	77 0a                	ja     801070f0 <trap+0x30>
801070e6:	ff 24 85 b0 91 10 80 	jmp    *-0x7fef6e50(,%eax,4)
801070ed:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
801070f0:	e8 ab c8 ff ff       	call   801039a0 <myproc>
801070f5:	8b 7b 38             	mov    0x38(%ebx),%edi
801070f8:	85 c0                	test   %eax,%eax
801070fa:	0f 84 64 02 00 00    	je     80107364 <trap+0x2a4>
80107100:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80107104:	0f 84 5a 02 00 00    	je     80107364 <trap+0x2a4>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010710a:	0f 20 d1             	mov    %cr2,%ecx
8010710d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107110:	e8 6b c8 ff ff       	call   80103980 <cpuid>
80107115:	8b 73 30             	mov    0x30(%ebx),%esi
80107118:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010711b:	8b 43 34             	mov    0x34(%ebx),%eax
8010711e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80107121:	e8 7a c8 ff ff       	call   801039a0 <myproc>
80107126:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107129:	e8 72 c8 ff ff       	call   801039a0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010712e:	8b 55 dc             	mov    -0x24(%ebp),%edx
80107131:	89 74 24 0c          	mov    %esi,0xc(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
80107135:	8b 75 e0             	mov    -0x20(%ebp),%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107138:	8b 4d d8             	mov    -0x28(%ebp),%ecx
8010713b:	89 7c 24 18          	mov    %edi,0x18(%esp)
8010713f:	89 54 24 14          	mov    %edx,0x14(%esp)
80107143:	8b 55 e4             	mov    -0x1c(%ebp),%edx
            myproc()->pid, myproc()->name, tf->trapno,
80107146:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107149:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
8010714d:	89 74 24 08          	mov    %esi,0x8(%esp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107151:	89 54 24 10          	mov    %edx,0x10(%esp)
80107155:	8b 40 10             	mov    0x10(%eax),%eax
80107158:	c7 04 24 6c 91 10 80 	movl   $0x8010916c,(%esp)
8010715f:	89 44 24 04          	mov    %eax,0x4(%esp)
80107163:	e8 e8 94 ff ff       	call   80100650 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80107168:	e8 33 c8 ff ff       	call   801039a0 <myproc>
8010716d:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107174:	e8 27 c8 ff ff       	call   801039a0 <myproc>
80107179:	85 c0                	test   %eax,%eax
8010717b:	74 1b                	je     80107198 <trap+0xd8>
8010717d:	e8 1e c8 ff ff       	call   801039a0 <myproc>
80107182:	8b 50 24             	mov    0x24(%eax),%edx
80107185:	85 d2                	test   %edx,%edx
80107187:	74 0f                	je     80107198 <trap+0xd8>
80107189:	8b 43 3c             	mov    0x3c(%ebx),%eax
8010718c:	83 e0 03             	and    $0x3,%eax
8010718f:	83 f8 03             	cmp    $0x3,%eax
80107192:	0f 84 80 01 00 00    	je     80107318 <trap+0x258>
    exit(0);

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80107198:	e8 03 c8 ff ff       	call   801039a0 <myproc>
8010719d:	85 c0                	test   %eax,%eax
8010719f:	74 0d                	je     801071ae <trap+0xee>
801071a1:	e8 fa c7 ff ff       	call   801039a0 <myproc>
801071a6:	8b 40 0c             	mov    0xc(%eax),%eax
801071a9:	83 f8 04             	cmp    $0x4,%eax
801071ac:	74 7a                	je     80107228 <trap+0x168>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801071ae:	e8 ed c7 ff ff       	call   801039a0 <myproc>
801071b3:	85 c0                	test   %eax,%eax
801071b5:	74 17                	je     801071ce <trap+0x10e>
801071b7:	e8 e4 c7 ff ff       	call   801039a0 <myproc>
801071bc:	8b 40 24             	mov    0x24(%eax),%eax
801071bf:	85 c0                	test   %eax,%eax
801071c1:	74 0b                	je     801071ce <trap+0x10e>
801071c3:	8b 43 3c             	mov    0x3c(%ebx),%eax
801071c6:	83 e0 03             	and    $0x3,%eax
801071c9:	83 f8 03             	cmp    $0x3,%eax
801071cc:	74 3b                	je     80107209 <trap+0x149>
    exit(0);
}
801071ce:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801071d1:	8b 75 f8             	mov    -0x8(%ebp),%esi
801071d4:	8b 7d fc             	mov    -0x4(%ebp),%edi
801071d7:	89 ec                	mov    %ebp,%esp
801071d9:	5d                   	pop    %ebp
801071da:	c3                   	ret    
801071db:	90                   	nop
801071dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
801071e0:	e8 bb c7 ff ff       	call   801039a0 <myproc>
801071e5:	8b 70 24             	mov    0x24(%eax),%esi
801071e8:	85 f6                	test   %esi,%esi
801071ea:	0f 85 10 01 00 00    	jne    80107300 <trap+0x240>
    myproc()->tf = tf;
801071f0:	e8 ab c7 ff ff       	call   801039a0 <myproc>
801071f5:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
801071f8:	e8 b3 ee ff ff       	call   801060b0 <syscall>
    if(myproc()->killed)
801071fd:	e8 9e c7 ff ff       	call   801039a0 <myproc>
80107202:	8b 48 24             	mov    0x24(%eax),%ecx
80107205:	85 c9                	test   %ecx,%ecx
80107207:	74 c5                	je     801071ce <trap+0x10e>
      exit(0);
80107209:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
}
80107210:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107213:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107216:	8b 7d fc             	mov    -0x4(%ebp),%edi
80107219:	89 ec                	mov    %ebp,%esp
8010721b:	5d                   	pop    %ebp
      exit(0);
8010721c:	e9 cf d0 ff ff       	jmp    801042f0 <exit>
80107221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(myproc() && myproc()->state == RUNNING &&
80107228:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
8010722c:	75 80                	jne    801071ae <trap+0xee>
    yield();
8010722e:	e8 bd d1 ff ff       	call   801043f0 <yield>
80107233:	e9 76 ff ff ff       	jmp    801071ae <trap+0xee>
80107238:	90                   	nop
80107239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80107240:	e8 3b c7 ff ff       	call   80103980 <cpuid>
80107245:	85 c0                	test   %eax,%eax
80107247:	0f 84 e3 00 00 00    	je     80107330 <trap+0x270>
8010724d:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
80107250:	e8 fb b5 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107255:	e8 46 c7 ff ff       	call   801039a0 <myproc>
8010725a:	85 c0                	test   %eax,%eax
8010725c:	0f 85 1b ff ff ff    	jne    8010717d <trap+0xbd>
80107262:	e9 31 ff ff ff       	jmp    80107198 <trap+0xd8>
80107267:	89 f6                	mov    %esi,%esi
80107269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    kbdintr();
80107270:	e8 9b b4 ff ff       	call   80102710 <kbdintr>
    lapiceoi();
80107275:	e8 d6 b5 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010727a:	e8 21 c7 ff ff       	call   801039a0 <myproc>
8010727f:	85 c0                	test   %eax,%eax
80107281:	0f 85 f6 fe ff ff    	jne    8010717d <trap+0xbd>
80107287:	e9 0c ff ff ff       	jmp    80107198 <trap+0xd8>
8010728c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80107290:	e8 6b 02 00 00       	call   80107500 <uartintr>
    lapiceoi();
80107295:	e8 b6 b5 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010729a:	e8 01 c7 ff ff       	call   801039a0 <myproc>
8010729f:	85 c0                	test   %eax,%eax
801072a1:	0f 85 d6 fe ff ff    	jne    8010717d <trap+0xbd>
801072a7:	e9 ec fe ff ff       	jmp    80107198 <trap+0xd8>
801072ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801072b0:	8b 7b 38             	mov    0x38(%ebx),%edi
801072b3:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801072b7:	e8 c4 c6 ff ff       	call   80103980 <cpuid>
801072bc:	c7 04 24 14 91 10 80 	movl   $0x80109114,(%esp)
801072c3:	89 7c 24 0c          	mov    %edi,0xc(%esp)
801072c7:	89 74 24 08          	mov    %esi,0x8(%esp)
801072cb:	89 44 24 04          	mov    %eax,0x4(%esp)
801072cf:	e8 7c 93 ff ff       	call   80100650 <cprintf>
    lapiceoi();
801072d4:	e8 77 b5 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801072d9:	e8 c2 c6 ff ff       	call   801039a0 <myproc>
801072de:	85 c0                	test   %eax,%eax
801072e0:	0f 85 97 fe ff ff    	jne    8010717d <trap+0xbd>
801072e6:	e9 ad fe ff ff       	jmp    80107198 <trap+0xd8>
801072eb:	90                   	nop
801072ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
801072f0:	e8 6b ae ff ff       	call   80102160 <ideintr>
801072f5:	e9 53 ff ff ff       	jmp    8010724d <trap+0x18d>
801072fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit(0);
80107300:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80107307:	e8 e4 cf ff ff       	call   801042f0 <exit>
8010730c:	e9 df fe ff ff       	jmp    801071f0 <trap+0x130>
80107311:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit(0);
80107318:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010731f:	e8 cc cf ff ff       	call   801042f0 <exit>
80107324:	e9 6f fe ff ff       	jmp    80107198 <trap+0xd8>
80107329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      acquire(&tickslock);
80107330:	c7 04 24 e0 77 11 80 	movl   $0x801177e0,(%esp)
80107337:	e8 a4 e8 ff ff       	call   80105be0 <acquire>
      ticks++;
8010733c:	ff 05 20 80 11 80    	incl   0x80118020
      updatePerformance();
80107342:	e8 99 d8 ff ff       	call   80104be0 <updatePerformance>
      wakeup(&ticks);
80107347:	c7 04 24 20 80 11 80 	movl   $0x80118020,(%esp)
8010734e:	e8 4d d3 ff ff       	call   801046a0 <wakeup>
      release(&tickslock);
80107353:	c7 04 24 e0 77 11 80 	movl   $0x801177e0,(%esp)
8010735a:	e8 21 e9 ff ff       	call   80105c80 <release>
8010735f:	e9 e9 fe ff ff       	jmp    8010724d <trap+0x18d>
80107364:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80107367:	e8 14 c6 ff ff       	call   80103980 <cpuid>
8010736c:	89 74 24 10          	mov    %esi,0x10(%esp)
80107370:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80107374:	89 44 24 08          	mov    %eax,0x8(%esp)
80107378:	8b 43 30             	mov    0x30(%ebx),%eax
8010737b:	c7 04 24 38 91 10 80 	movl   $0x80109138,(%esp)
80107382:	89 44 24 04          	mov    %eax,0x4(%esp)
80107386:	e8 c5 92 ff ff       	call   80100650 <cprintf>
      panic("trap");
8010738b:	c7 04 24 0e 91 10 80 	movl   $0x8010910e,(%esp)
80107392:	e8 d9 8f ff ff       	call   80100370 <panic>
80107397:	66 90                	xchg   %ax,%ax
80107399:	66 90                	xchg   %ax,%ax
8010739b:	66 90                	xchg   %ax,%ax
8010739d:	66 90                	xchg   %ax,%ax
8010739f:	90                   	nop

801073a0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801073a0:	a1 20 c6 10 80       	mov    0x8010c620,%eax
{
801073a5:	55                   	push   %ebp
801073a6:	89 e5                	mov    %esp,%ebp
  if(!uart)
801073a8:	85 c0                	test   %eax,%eax
801073aa:	74 1c                	je     801073c8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801073ac:	ba fd 03 00 00       	mov    $0x3fd,%edx
801073b1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801073b2:	24 01                	and    $0x1,%al
801073b4:	84 c0                	test   %al,%al
801073b6:	74 10                	je     801073c8 <uartgetc+0x28>
801073b8:	ba f8 03 00 00       	mov    $0x3f8,%edx
801073bd:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801073be:	0f b6 c0             	movzbl %al,%eax
}
801073c1:	5d                   	pop    %ebp
801073c2:	c3                   	ret    
801073c3:	90                   	nop
801073c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801073c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801073cd:	5d                   	pop    %ebp
801073ce:	c3                   	ret    
801073cf:	90                   	nop

801073d0 <uartputc.part.0>:
uartputc(int c)
801073d0:	55                   	push   %ebp
801073d1:	89 e5                	mov    %esp,%ebp
801073d3:	56                   	push   %esi
801073d4:	be fd 03 00 00       	mov    $0x3fd,%esi
801073d9:	53                   	push   %ebx
801073da:	bb 80 00 00 00       	mov    $0x80,%ebx
801073df:	83 ec 20             	sub    $0x20,%esp
801073e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
801073e5:	eb 18                	jmp    801073ff <uartputc.part.0+0x2f>
801073e7:	89 f6                	mov    %esi,%esi
801073e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
801073f0:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
801073f7:	e8 74 b4 ff ff       	call   80102870 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801073fc:	4b                   	dec    %ebx
801073fd:	74 09                	je     80107408 <uartputc.part.0+0x38>
801073ff:	89 f2                	mov    %esi,%edx
80107401:	ec                   	in     (%dx),%al
80107402:	24 20                	and    $0x20,%al
80107404:	84 c0                	test   %al,%al
80107406:	74 e8                	je     801073f0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107408:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010740d:	0f b6 45 f4          	movzbl -0xc(%ebp),%eax
80107411:	ee                   	out    %al,(%dx)
}
80107412:	83 c4 20             	add    $0x20,%esp
80107415:	5b                   	pop    %ebx
80107416:	5e                   	pop    %esi
80107417:	5d                   	pop    %ebp
80107418:	c3                   	ret    
80107419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107420 <uartinit>:
{
80107420:	55                   	push   %ebp
80107421:	31 c9                	xor    %ecx,%ecx
80107423:	89 e5                	mov    %esp,%ebp
80107425:	88 c8                	mov    %cl,%al
80107427:	57                   	push   %edi
80107428:	56                   	push   %esi
80107429:	53                   	push   %ebx
8010742a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010742f:	83 ec 1c             	sub    $0x1c,%esp
80107432:	89 da                	mov    %ebx,%edx
80107434:	ee                   	out    %al,(%dx)
80107435:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010743a:	b0 80                	mov    $0x80,%al
8010743c:	89 fa                	mov    %edi,%edx
8010743e:	ee                   	out    %al,(%dx)
8010743f:	b0 0c                	mov    $0xc,%al
80107441:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107446:	ee                   	out    %al,(%dx)
80107447:	be f9 03 00 00       	mov    $0x3f9,%esi
8010744c:	88 c8                	mov    %cl,%al
8010744e:	89 f2                	mov    %esi,%edx
80107450:	ee                   	out    %al,(%dx)
80107451:	b0 03                	mov    $0x3,%al
80107453:	89 fa                	mov    %edi,%edx
80107455:	ee                   	out    %al,(%dx)
80107456:	ba fc 03 00 00       	mov    $0x3fc,%edx
8010745b:	88 c8                	mov    %cl,%al
8010745d:	ee                   	out    %al,(%dx)
8010745e:	b0 01                	mov    $0x1,%al
80107460:	89 f2                	mov    %esi,%edx
80107462:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80107463:	ba fd 03 00 00       	mov    $0x3fd,%edx
80107468:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80107469:	fe c0                	inc    %al
8010746b:	74 52                	je     801074bf <uartinit+0x9f>
  uart = 1;
8010746d:	b9 01 00 00 00       	mov    $0x1,%ecx
80107472:	89 da                	mov    %ebx,%edx
80107474:	89 0d 20 c6 10 80    	mov    %ecx,0x8010c620
8010747a:	ec                   	in     (%dx),%al
8010747b:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107480:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80107481:	31 db                	xor    %ebx,%ebx
80107483:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  for(p="xv6...\n"; *p; p++)
80107487:	bb 30 92 10 80       	mov    $0x80109230,%ebx
  ioapicenable(IRQ_COM1, 0);
8010748c:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80107493:	e8 08 af ff ff       	call   801023a0 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80107498:	b8 78 00 00 00       	mov    $0x78,%eax
8010749d:	eb 09                	jmp    801074a8 <uartinit+0x88>
8010749f:	90                   	nop
801074a0:	43                   	inc    %ebx
801074a1:	0f be 03             	movsbl (%ebx),%eax
801074a4:	84 c0                	test   %al,%al
801074a6:	74 17                	je     801074bf <uartinit+0x9f>
  if(!uart)
801074a8:	8b 15 20 c6 10 80    	mov    0x8010c620,%edx
801074ae:	85 d2                	test   %edx,%edx
801074b0:	74 ee                	je     801074a0 <uartinit+0x80>
  for(p="xv6...\n"; *p; p++)
801074b2:	43                   	inc    %ebx
801074b3:	e8 18 ff ff ff       	call   801073d0 <uartputc.part.0>
801074b8:	0f be 03             	movsbl (%ebx),%eax
801074bb:	84 c0                	test   %al,%al
801074bd:	75 e9                	jne    801074a8 <uartinit+0x88>
}
801074bf:	83 c4 1c             	add    $0x1c,%esp
801074c2:	5b                   	pop    %ebx
801074c3:	5e                   	pop    %esi
801074c4:	5f                   	pop    %edi
801074c5:	5d                   	pop    %ebp
801074c6:	c3                   	ret    
801074c7:	89 f6                	mov    %esi,%esi
801074c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801074d0 <uartputc>:
  if(!uart)
801074d0:	8b 15 20 c6 10 80    	mov    0x8010c620,%edx
{
801074d6:	55                   	push   %ebp
801074d7:	89 e5                	mov    %esp,%ebp
801074d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
801074dc:	85 d2                	test   %edx,%edx
801074de:	74 10                	je     801074f0 <uartputc+0x20>
}
801074e0:	5d                   	pop    %ebp
801074e1:	e9 ea fe ff ff       	jmp    801073d0 <uartputc.part.0>
801074e6:	8d 76 00             	lea    0x0(%esi),%esi
801074e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801074f0:	5d                   	pop    %ebp
801074f1:	c3                   	ret    
801074f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801074f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107500 <uartintr>:

void
uartintr(void)
{
80107500:	55                   	push   %ebp
80107501:	89 e5                	mov    %esp,%ebp
80107503:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80107506:	c7 04 24 a0 73 10 80 	movl   $0x801073a0,(%esp)
8010750d:	e8 be 92 ff ff       	call   801007d0 <consoleintr>
}
80107512:	c9                   	leave  
80107513:	c3                   	ret    

80107514 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80107514:	6a 00                	push   $0x0
  pushl $0
80107516:	6a 00                	push   $0x0
  jmp alltraps
80107518:	e9 ca fa ff ff       	jmp    80106fe7 <alltraps>

8010751d <vector1>:
.globl vector1
vector1:
  pushl $0
8010751d:	6a 00                	push   $0x0
  pushl $1
8010751f:	6a 01                	push   $0x1
  jmp alltraps
80107521:	e9 c1 fa ff ff       	jmp    80106fe7 <alltraps>

80107526 <vector2>:
.globl vector2
vector2:
  pushl $0
80107526:	6a 00                	push   $0x0
  pushl $2
80107528:	6a 02                	push   $0x2
  jmp alltraps
8010752a:	e9 b8 fa ff ff       	jmp    80106fe7 <alltraps>

8010752f <vector3>:
.globl vector3
vector3:
  pushl $0
8010752f:	6a 00                	push   $0x0
  pushl $3
80107531:	6a 03                	push   $0x3
  jmp alltraps
80107533:	e9 af fa ff ff       	jmp    80106fe7 <alltraps>

80107538 <vector4>:
.globl vector4
vector4:
  pushl $0
80107538:	6a 00                	push   $0x0
  pushl $4
8010753a:	6a 04                	push   $0x4
  jmp alltraps
8010753c:	e9 a6 fa ff ff       	jmp    80106fe7 <alltraps>

80107541 <vector5>:
.globl vector5
vector5:
  pushl $0
80107541:	6a 00                	push   $0x0
  pushl $5
80107543:	6a 05                	push   $0x5
  jmp alltraps
80107545:	e9 9d fa ff ff       	jmp    80106fe7 <alltraps>

8010754a <vector6>:
.globl vector6
vector6:
  pushl $0
8010754a:	6a 00                	push   $0x0
  pushl $6
8010754c:	6a 06                	push   $0x6
  jmp alltraps
8010754e:	e9 94 fa ff ff       	jmp    80106fe7 <alltraps>

80107553 <vector7>:
.globl vector7
vector7:
  pushl $0
80107553:	6a 00                	push   $0x0
  pushl $7
80107555:	6a 07                	push   $0x7
  jmp alltraps
80107557:	e9 8b fa ff ff       	jmp    80106fe7 <alltraps>

8010755c <vector8>:
.globl vector8
vector8:
  pushl $8
8010755c:	6a 08                	push   $0x8
  jmp alltraps
8010755e:	e9 84 fa ff ff       	jmp    80106fe7 <alltraps>

80107563 <vector9>:
.globl vector9
vector9:
  pushl $0
80107563:	6a 00                	push   $0x0
  pushl $9
80107565:	6a 09                	push   $0x9
  jmp alltraps
80107567:	e9 7b fa ff ff       	jmp    80106fe7 <alltraps>

8010756c <vector10>:
.globl vector10
vector10:
  pushl $10
8010756c:	6a 0a                	push   $0xa
  jmp alltraps
8010756e:	e9 74 fa ff ff       	jmp    80106fe7 <alltraps>

80107573 <vector11>:
.globl vector11
vector11:
  pushl $11
80107573:	6a 0b                	push   $0xb
  jmp alltraps
80107575:	e9 6d fa ff ff       	jmp    80106fe7 <alltraps>

8010757a <vector12>:
.globl vector12
vector12:
  pushl $12
8010757a:	6a 0c                	push   $0xc
  jmp alltraps
8010757c:	e9 66 fa ff ff       	jmp    80106fe7 <alltraps>

80107581 <vector13>:
.globl vector13
vector13:
  pushl $13
80107581:	6a 0d                	push   $0xd
  jmp alltraps
80107583:	e9 5f fa ff ff       	jmp    80106fe7 <alltraps>

80107588 <vector14>:
.globl vector14
vector14:
  pushl $14
80107588:	6a 0e                	push   $0xe
  jmp alltraps
8010758a:	e9 58 fa ff ff       	jmp    80106fe7 <alltraps>

8010758f <vector15>:
.globl vector15
vector15:
  pushl $0
8010758f:	6a 00                	push   $0x0
  pushl $15
80107591:	6a 0f                	push   $0xf
  jmp alltraps
80107593:	e9 4f fa ff ff       	jmp    80106fe7 <alltraps>

80107598 <vector16>:
.globl vector16
vector16:
  pushl $0
80107598:	6a 00                	push   $0x0
  pushl $16
8010759a:	6a 10                	push   $0x10
  jmp alltraps
8010759c:	e9 46 fa ff ff       	jmp    80106fe7 <alltraps>

801075a1 <vector17>:
.globl vector17
vector17:
  pushl $17
801075a1:	6a 11                	push   $0x11
  jmp alltraps
801075a3:	e9 3f fa ff ff       	jmp    80106fe7 <alltraps>

801075a8 <vector18>:
.globl vector18
vector18:
  pushl $0
801075a8:	6a 00                	push   $0x0
  pushl $18
801075aa:	6a 12                	push   $0x12
  jmp alltraps
801075ac:	e9 36 fa ff ff       	jmp    80106fe7 <alltraps>

801075b1 <vector19>:
.globl vector19
vector19:
  pushl $0
801075b1:	6a 00                	push   $0x0
  pushl $19
801075b3:	6a 13                	push   $0x13
  jmp alltraps
801075b5:	e9 2d fa ff ff       	jmp    80106fe7 <alltraps>

801075ba <vector20>:
.globl vector20
vector20:
  pushl $0
801075ba:	6a 00                	push   $0x0
  pushl $20
801075bc:	6a 14                	push   $0x14
  jmp alltraps
801075be:	e9 24 fa ff ff       	jmp    80106fe7 <alltraps>

801075c3 <vector21>:
.globl vector21
vector21:
  pushl $0
801075c3:	6a 00                	push   $0x0
  pushl $21
801075c5:	6a 15                	push   $0x15
  jmp alltraps
801075c7:	e9 1b fa ff ff       	jmp    80106fe7 <alltraps>

801075cc <vector22>:
.globl vector22
vector22:
  pushl $0
801075cc:	6a 00                	push   $0x0
  pushl $22
801075ce:	6a 16                	push   $0x16
  jmp alltraps
801075d0:	e9 12 fa ff ff       	jmp    80106fe7 <alltraps>

801075d5 <vector23>:
.globl vector23
vector23:
  pushl $0
801075d5:	6a 00                	push   $0x0
  pushl $23
801075d7:	6a 17                	push   $0x17
  jmp alltraps
801075d9:	e9 09 fa ff ff       	jmp    80106fe7 <alltraps>

801075de <vector24>:
.globl vector24
vector24:
  pushl $0
801075de:	6a 00                	push   $0x0
  pushl $24
801075e0:	6a 18                	push   $0x18
  jmp alltraps
801075e2:	e9 00 fa ff ff       	jmp    80106fe7 <alltraps>

801075e7 <vector25>:
.globl vector25
vector25:
  pushl $0
801075e7:	6a 00                	push   $0x0
  pushl $25
801075e9:	6a 19                	push   $0x19
  jmp alltraps
801075eb:	e9 f7 f9 ff ff       	jmp    80106fe7 <alltraps>

801075f0 <vector26>:
.globl vector26
vector26:
  pushl $0
801075f0:	6a 00                	push   $0x0
  pushl $26
801075f2:	6a 1a                	push   $0x1a
  jmp alltraps
801075f4:	e9 ee f9 ff ff       	jmp    80106fe7 <alltraps>

801075f9 <vector27>:
.globl vector27
vector27:
  pushl $0
801075f9:	6a 00                	push   $0x0
  pushl $27
801075fb:	6a 1b                	push   $0x1b
  jmp alltraps
801075fd:	e9 e5 f9 ff ff       	jmp    80106fe7 <alltraps>

80107602 <vector28>:
.globl vector28
vector28:
  pushl $0
80107602:	6a 00                	push   $0x0
  pushl $28
80107604:	6a 1c                	push   $0x1c
  jmp alltraps
80107606:	e9 dc f9 ff ff       	jmp    80106fe7 <alltraps>

8010760b <vector29>:
.globl vector29
vector29:
  pushl $0
8010760b:	6a 00                	push   $0x0
  pushl $29
8010760d:	6a 1d                	push   $0x1d
  jmp alltraps
8010760f:	e9 d3 f9 ff ff       	jmp    80106fe7 <alltraps>

80107614 <vector30>:
.globl vector30
vector30:
  pushl $0
80107614:	6a 00                	push   $0x0
  pushl $30
80107616:	6a 1e                	push   $0x1e
  jmp alltraps
80107618:	e9 ca f9 ff ff       	jmp    80106fe7 <alltraps>

8010761d <vector31>:
.globl vector31
vector31:
  pushl $0
8010761d:	6a 00                	push   $0x0
  pushl $31
8010761f:	6a 1f                	push   $0x1f
  jmp alltraps
80107621:	e9 c1 f9 ff ff       	jmp    80106fe7 <alltraps>

80107626 <vector32>:
.globl vector32
vector32:
  pushl $0
80107626:	6a 00                	push   $0x0
  pushl $32
80107628:	6a 20                	push   $0x20
  jmp alltraps
8010762a:	e9 b8 f9 ff ff       	jmp    80106fe7 <alltraps>

8010762f <vector33>:
.globl vector33
vector33:
  pushl $0
8010762f:	6a 00                	push   $0x0
  pushl $33
80107631:	6a 21                	push   $0x21
  jmp alltraps
80107633:	e9 af f9 ff ff       	jmp    80106fe7 <alltraps>

80107638 <vector34>:
.globl vector34
vector34:
  pushl $0
80107638:	6a 00                	push   $0x0
  pushl $34
8010763a:	6a 22                	push   $0x22
  jmp alltraps
8010763c:	e9 a6 f9 ff ff       	jmp    80106fe7 <alltraps>

80107641 <vector35>:
.globl vector35
vector35:
  pushl $0
80107641:	6a 00                	push   $0x0
  pushl $35
80107643:	6a 23                	push   $0x23
  jmp alltraps
80107645:	e9 9d f9 ff ff       	jmp    80106fe7 <alltraps>

8010764a <vector36>:
.globl vector36
vector36:
  pushl $0
8010764a:	6a 00                	push   $0x0
  pushl $36
8010764c:	6a 24                	push   $0x24
  jmp alltraps
8010764e:	e9 94 f9 ff ff       	jmp    80106fe7 <alltraps>

80107653 <vector37>:
.globl vector37
vector37:
  pushl $0
80107653:	6a 00                	push   $0x0
  pushl $37
80107655:	6a 25                	push   $0x25
  jmp alltraps
80107657:	e9 8b f9 ff ff       	jmp    80106fe7 <alltraps>

8010765c <vector38>:
.globl vector38
vector38:
  pushl $0
8010765c:	6a 00                	push   $0x0
  pushl $38
8010765e:	6a 26                	push   $0x26
  jmp alltraps
80107660:	e9 82 f9 ff ff       	jmp    80106fe7 <alltraps>

80107665 <vector39>:
.globl vector39
vector39:
  pushl $0
80107665:	6a 00                	push   $0x0
  pushl $39
80107667:	6a 27                	push   $0x27
  jmp alltraps
80107669:	e9 79 f9 ff ff       	jmp    80106fe7 <alltraps>

8010766e <vector40>:
.globl vector40
vector40:
  pushl $0
8010766e:	6a 00                	push   $0x0
  pushl $40
80107670:	6a 28                	push   $0x28
  jmp alltraps
80107672:	e9 70 f9 ff ff       	jmp    80106fe7 <alltraps>

80107677 <vector41>:
.globl vector41
vector41:
  pushl $0
80107677:	6a 00                	push   $0x0
  pushl $41
80107679:	6a 29                	push   $0x29
  jmp alltraps
8010767b:	e9 67 f9 ff ff       	jmp    80106fe7 <alltraps>

80107680 <vector42>:
.globl vector42
vector42:
  pushl $0
80107680:	6a 00                	push   $0x0
  pushl $42
80107682:	6a 2a                	push   $0x2a
  jmp alltraps
80107684:	e9 5e f9 ff ff       	jmp    80106fe7 <alltraps>

80107689 <vector43>:
.globl vector43
vector43:
  pushl $0
80107689:	6a 00                	push   $0x0
  pushl $43
8010768b:	6a 2b                	push   $0x2b
  jmp alltraps
8010768d:	e9 55 f9 ff ff       	jmp    80106fe7 <alltraps>

80107692 <vector44>:
.globl vector44
vector44:
  pushl $0
80107692:	6a 00                	push   $0x0
  pushl $44
80107694:	6a 2c                	push   $0x2c
  jmp alltraps
80107696:	e9 4c f9 ff ff       	jmp    80106fe7 <alltraps>

8010769b <vector45>:
.globl vector45
vector45:
  pushl $0
8010769b:	6a 00                	push   $0x0
  pushl $45
8010769d:	6a 2d                	push   $0x2d
  jmp alltraps
8010769f:	e9 43 f9 ff ff       	jmp    80106fe7 <alltraps>

801076a4 <vector46>:
.globl vector46
vector46:
  pushl $0
801076a4:	6a 00                	push   $0x0
  pushl $46
801076a6:	6a 2e                	push   $0x2e
  jmp alltraps
801076a8:	e9 3a f9 ff ff       	jmp    80106fe7 <alltraps>

801076ad <vector47>:
.globl vector47
vector47:
  pushl $0
801076ad:	6a 00                	push   $0x0
  pushl $47
801076af:	6a 2f                	push   $0x2f
  jmp alltraps
801076b1:	e9 31 f9 ff ff       	jmp    80106fe7 <alltraps>

801076b6 <vector48>:
.globl vector48
vector48:
  pushl $0
801076b6:	6a 00                	push   $0x0
  pushl $48
801076b8:	6a 30                	push   $0x30
  jmp alltraps
801076ba:	e9 28 f9 ff ff       	jmp    80106fe7 <alltraps>

801076bf <vector49>:
.globl vector49
vector49:
  pushl $0
801076bf:	6a 00                	push   $0x0
  pushl $49
801076c1:	6a 31                	push   $0x31
  jmp alltraps
801076c3:	e9 1f f9 ff ff       	jmp    80106fe7 <alltraps>

801076c8 <vector50>:
.globl vector50
vector50:
  pushl $0
801076c8:	6a 00                	push   $0x0
  pushl $50
801076ca:	6a 32                	push   $0x32
  jmp alltraps
801076cc:	e9 16 f9 ff ff       	jmp    80106fe7 <alltraps>

801076d1 <vector51>:
.globl vector51
vector51:
  pushl $0
801076d1:	6a 00                	push   $0x0
  pushl $51
801076d3:	6a 33                	push   $0x33
  jmp alltraps
801076d5:	e9 0d f9 ff ff       	jmp    80106fe7 <alltraps>

801076da <vector52>:
.globl vector52
vector52:
  pushl $0
801076da:	6a 00                	push   $0x0
  pushl $52
801076dc:	6a 34                	push   $0x34
  jmp alltraps
801076de:	e9 04 f9 ff ff       	jmp    80106fe7 <alltraps>

801076e3 <vector53>:
.globl vector53
vector53:
  pushl $0
801076e3:	6a 00                	push   $0x0
  pushl $53
801076e5:	6a 35                	push   $0x35
  jmp alltraps
801076e7:	e9 fb f8 ff ff       	jmp    80106fe7 <alltraps>

801076ec <vector54>:
.globl vector54
vector54:
  pushl $0
801076ec:	6a 00                	push   $0x0
  pushl $54
801076ee:	6a 36                	push   $0x36
  jmp alltraps
801076f0:	e9 f2 f8 ff ff       	jmp    80106fe7 <alltraps>

801076f5 <vector55>:
.globl vector55
vector55:
  pushl $0
801076f5:	6a 00                	push   $0x0
  pushl $55
801076f7:	6a 37                	push   $0x37
  jmp alltraps
801076f9:	e9 e9 f8 ff ff       	jmp    80106fe7 <alltraps>

801076fe <vector56>:
.globl vector56
vector56:
  pushl $0
801076fe:	6a 00                	push   $0x0
  pushl $56
80107700:	6a 38                	push   $0x38
  jmp alltraps
80107702:	e9 e0 f8 ff ff       	jmp    80106fe7 <alltraps>

80107707 <vector57>:
.globl vector57
vector57:
  pushl $0
80107707:	6a 00                	push   $0x0
  pushl $57
80107709:	6a 39                	push   $0x39
  jmp alltraps
8010770b:	e9 d7 f8 ff ff       	jmp    80106fe7 <alltraps>

80107710 <vector58>:
.globl vector58
vector58:
  pushl $0
80107710:	6a 00                	push   $0x0
  pushl $58
80107712:	6a 3a                	push   $0x3a
  jmp alltraps
80107714:	e9 ce f8 ff ff       	jmp    80106fe7 <alltraps>

80107719 <vector59>:
.globl vector59
vector59:
  pushl $0
80107719:	6a 00                	push   $0x0
  pushl $59
8010771b:	6a 3b                	push   $0x3b
  jmp alltraps
8010771d:	e9 c5 f8 ff ff       	jmp    80106fe7 <alltraps>

80107722 <vector60>:
.globl vector60
vector60:
  pushl $0
80107722:	6a 00                	push   $0x0
  pushl $60
80107724:	6a 3c                	push   $0x3c
  jmp alltraps
80107726:	e9 bc f8 ff ff       	jmp    80106fe7 <alltraps>

8010772b <vector61>:
.globl vector61
vector61:
  pushl $0
8010772b:	6a 00                	push   $0x0
  pushl $61
8010772d:	6a 3d                	push   $0x3d
  jmp alltraps
8010772f:	e9 b3 f8 ff ff       	jmp    80106fe7 <alltraps>

80107734 <vector62>:
.globl vector62
vector62:
  pushl $0
80107734:	6a 00                	push   $0x0
  pushl $62
80107736:	6a 3e                	push   $0x3e
  jmp alltraps
80107738:	e9 aa f8 ff ff       	jmp    80106fe7 <alltraps>

8010773d <vector63>:
.globl vector63
vector63:
  pushl $0
8010773d:	6a 00                	push   $0x0
  pushl $63
8010773f:	6a 3f                	push   $0x3f
  jmp alltraps
80107741:	e9 a1 f8 ff ff       	jmp    80106fe7 <alltraps>

80107746 <vector64>:
.globl vector64
vector64:
  pushl $0
80107746:	6a 00                	push   $0x0
  pushl $64
80107748:	6a 40                	push   $0x40
  jmp alltraps
8010774a:	e9 98 f8 ff ff       	jmp    80106fe7 <alltraps>

8010774f <vector65>:
.globl vector65
vector65:
  pushl $0
8010774f:	6a 00                	push   $0x0
  pushl $65
80107751:	6a 41                	push   $0x41
  jmp alltraps
80107753:	e9 8f f8 ff ff       	jmp    80106fe7 <alltraps>

80107758 <vector66>:
.globl vector66
vector66:
  pushl $0
80107758:	6a 00                	push   $0x0
  pushl $66
8010775a:	6a 42                	push   $0x42
  jmp alltraps
8010775c:	e9 86 f8 ff ff       	jmp    80106fe7 <alltraps>

80107761 <vector67>:
.globl vector67
vector67:
  pushl $0
80107761:	6a 00                	push   $0x0
  pushl $67
80107763:	6a 43                	push   $0x43
  jmp alltraps
80107765:	e9 7d f8 ff ff       	jmp    80106fe7 <alltraps>

8010776a <vector68>:
.globl vector68
vector68:
  pushl $0
8010776a:	6a 00                	push   $0x0
  pushl $68
8010776c:	6a 44                	push   $0x44
  jmp alltraps
8010776e:	e9 74 f8 ff ff       	jmp    80106fe7 <alltraps>

80107773 <vector69>:
.globl vector69
vector69:
  pushl $0
80107773:	6a 00                	push   $0x0
  pushl $69
80107775:	6a 45                	push   $0x45
  jmp alltraps
80107777:	e9 6b f8 ff ff       	jmp    80106fe7 <alltraps>

8010777c <vector70>:
.globl vector70
vector70:
  pushl $0
8010777c:	6a 00                	push   $0x0
  pushl $70
8010777e:	6a 46                	push   $0x46
  jmp alltraps
80107780:	e9 62 f8 ff ff       	jmp    80106fe7 <alltraps>

80107785 <vector71>:
.globl vector71
vector71:
  pushl $0
80107785:	6a 00                	push   $0x0
  pushl $71
80107787:	6a 47                	push   $0x47
  jmp alltraps
80107789:	e9 59 f8 ff ff       	jmp    80106fe7 <alltraps>

8010778e <vector72>:
.globl vector72
vector72:
  pushl $0
8010778e:	6a 00                	push   $0x0
  pushl $72
80107790:	6a 48                	push   $0x48
  jmp alltraps
80107792:	e9 50 f8 ff ff       	jmp    80106fe7 <alltraps>

80107797 <vector73>:
.globl vector73
vector73:
  pushl $0
80107797:	6a 00                	push   $0x0
  pushl $73
80107799:	6a 49                	push   $0x49
  jmp alltraps
8010779b:	e9 47 f8 ff ff       	jmp    80106fe7 <alltraps>

801077a0 <vector74>:
.globl vector74
vector74:
  pushl $0
801077a0:	6a 00                	push   $0x0
  pushl $74
801077a2:	6a 4a                	push   $0x4a
  jmp alltraps
801077a4:	e9 3e f8 ff ff       	jmp    80106fe7 <alltraps>

801077a9 <vector75>:
.globl vector75
vector75:
  pushl $0
801077a9:	6a 00                	push   $0x0
  pushl $75
801077ab:	6a 4b                	push   $0x4b
  jmp alltraps
801077ad:	e9 35 f8 ff ff       	jmp    80106fe7 <alltraps>

801077b2 <vector76>:
.globl vector76
vector76:
  pushl $0
801077b2:	6a 00                	push   $0x0
  pushl $76
801077b4:	6a 4c                	push   $0x4c
  jmp alltraps
801077b6:	e9 2c f8 ff ff       	jmp    80106fe7 <alltraps>

801077bb <vector77>:
.globl vector77
vector77:
  pushl $0
801077bb:	6a 00                	push   $0x0
  pushl $77
801077bd:	6a 4d                	push   $0x4d
  jmp alltraps
801077bf:	e9 23 f8 ff ff       	jmp    80106fe7 <alltraps>

801077c4 <vector78>:
.globl vector78
vector78:
  pushl $0
801077c4:	6a 00                	push   $0x0
  pushl $78
801077c6:	6a 4e                	push   $0x4e
  jmp alltraps
801077c8:	e9 1a f8 ff ff       	jmp    80106fe7 <alltraps>

801077cd <vector79>:
.globl vector79
vector79:
  pushl $0
801077cd:	6a 00                	push   $0x0
  pushl $79
801077cf:	6a 4f                	push   $0x4f
  jmp alltraps
801077d1:	e9 11 f8 ff ff       	jmp    80106fe7 <alltraps>

801077d6 <vector80>:
.globl vector80
vector80:
  pushl $0
801077d6:	6a 00                	push   $0x0
  pushl $80
801077d8:	6a 50                	push   $0x50
  jmp alltraps
801077da:	e9 08 f8 ff ff       	jmp    80106fe7 <alltraps>

801077df <vector81>:
.globl vector81
vector81:
  pushl $0
801077df:	6a 00                	push   $0x0
  pushl $81
801077e1:	6a 51                	push   $0x51
  jmp alltraps
801077e3:	e9 ff f7 ff ff       	jmp    80106fe7 <alltraps>

801077e8 <vector82>:
.globl vector82
vector82:
  pushl $0
801077e8:	6a 00                	push   $0x0
  pushl $82
801077ea:	6a 52                	push   $0x52
  jmp alltraps
801077ec:	e9 f6 f7 ff ff       	jmp    80106fe7 <alltraps>

801077f1 <vector83>:
.globl vector83
vector83:
  pushl $0
801077f1:	6a 00                	push   $0x0
  pushl $83
801077f3:	6a 53                	push   $0x53
  jmp alltraps
801077f5:	e9 ed f7 ff ff       	jmp    80106fe7 <alltraps>

801077fa <vector84>:
.globl vector84
vector84:
  pushl $0
801077fa:	6a 00                	push   $0x0
  pushl $84
801077fc:	6a 54                	push   $0x54
  jmp alltraps
801077fe:	e9 e4 f7 ff ff       	jmp    80106fe7 <alltraps>

80107803 <vector85>:
.globl vector85
vector85:
  pushl $0
80107803:	6a 00                	push   $0x0
  pushl $85
80107805:	6a 55                	push   $0x55
  jmp alltraps
80107807:	e9 db f7 ff ff       	jmp    80106fe7 <alltraps>

8010780c <vector86>:
.globl vector86
vector86:
  pushl $0
8010780c:	6a 00                	push   $0x0
  pushl $86
8010780e:	6a 56                	push   $0x56
  jmp alltraps
80107810:	e9 d2 f7 ff ff       	jmp    80106fe7 <alltraps>

80107815 <vector87>:
.globl vector87
vector87:
  pushl $0
80107815:	6a 00                	push   $0x0
  pushl $87
80107817:	6a 57                	push   $0x57
  jmp alltraps
80107819:	e9 c9 f7 ff ff       	jmp    80106fe7 <alltraps>

8010781e <vector88>:
.globl vector88
vector88:
  pushl $0
8010781e:	6a 00                	push   $0x0
  pushl $88
80107820:	6a 58                	push   $0x58
  jmp alltraps
80107822:	e9 c0 f7 ff ff       	jmp    80106fe7 <alltraps>

80107827 <vector89>:
.globl vector89
vector89:
  pushl $0
80107827:	6a 00                	push   $0x0
  pushl $89
80107829:	6a 59                	push   $0x59
  jmp alltraps
8010782b:	e9 b7 f7 ff ff       	jmp    80106fe7 <alltraps>

80107830 <vector90>:
.globl vector90
vector90:
  pushl $0
80107830:	6a 00                	push   $0x0
  pushl $90
80107832:	6a 5a                	push   $0x5a
  jmp alltraps
80107834:	e9 ae f7 ff ff       	jmp    80106fe7 <alltraps>

80107839 <vector91>:
.globl vector91
vector91:
  pushl $0
80107839:	6a 00                	push   $0x0
  pushl $91
8010783b:	6a 5b                	push   $0x5b
  jmp alltraps
8010783d:	e9 a5 f7 ff ff       	jmp    80106fe7 <alltraps>

80107842 <vector92>:
.globl vector92
vector92:
  pushl $0
80107842:	6a 00                	push   $0x0
  pushl $92
80107844:	6a 5c                	push   $0x5c
  jmp alltraps
80107846:	e9 9c f7 ff ff       	jmp    80106fe7 <alltraps>

8010784b <vector93>:
.globl vector93
vector93:
  pushl $0
8010784b:	6a 00                	push   $0x0
  pushl $93
8010784d:	6a 5d                	push   $0x5d
  jmp alltraps
8010784f:	e9 93 f7 ff ff       	jmp    80106fe7 <alltraps>

80107854 <vector94>:
.globl vector94
vector94:
  pushl $0
80107854:	6a 00                	push   $0x0
  pushl $94
80107856:	6a 5e                	push   $0x5e
  jmp alltraps
80107858:	e9 8a f7 ff ff       	jmp    80106fe7 <alltraps>

8010785d <vector95>:
.globl vector95
vector95:
  pushl $0
8010785d:	6a 00                	push   $0x0
  pushl $95
8010785f:	6a 5f                	push   $0x5f
  jmp alltraps
80107861:	e9 81 f7 ff ff       	jmp    80106fe7 <alltraps>

80107866 <vector96>:
.globl vector96
vector96:
  pushl $0
80107866:	6a 00                	push   $0x0
  pushl $96
80107868:	6a 60                	push   $0x60
  jmp alltraps
8010786a:	e9 78 f7 ff ff       	jmp    80106fe7 <alltraps>

8010786f <vector97>:
.globl vector97
vector97:
  pushl $0
8010786f:	6a 00                	push   $0x0
  pushl $97
80107871:	6a 61                	push   $0x61
  jmp alltraps
80107873:	e9 6f f7 ff ff       	jmp    80106fe7 <alltraps>

80107878 <vector98>:
.globl vector98
vector98:
  pushl $0
80107878:	6a 00                	push   $0x0
  pushl $98
8010787a:	6a 62                	push   $0x62
  jmp alltraps
8010787c:	e9 66 f7 ff ff       	jmp    80106fe7 <alltraps>

80107881 <vector99>:
.globl vector99
vector99:
  pushl $0
80107881:	6a 00                	push   $0x0
  pushl $99
80107883:	6a 63                	push   $0x63
  jmp alltraps
80107885:	e9 5d f7 ff ff       	jmp    80106fe7 <alltraps>

8010788a <vector100>:
.globl vector100
vector100:
  pushl $0
8010788a:	6a 00                	push   $0x0
  pushl $100
8010788c:	6a 64                	push   $0x64
  jmp alltraps
8010788e:	e9 54 f7 ff ff       	jmp    80106fe7 <alltraps>

80107893 <vector101>:
.globl vector101
vector101:
  pushl $0
80107893:	6a 00                	push   $0x0
  pushl $101
80107895:	6a 65                	push   $0x65
  jmp alltraps
80107897:	e9 4b f7 ff ff       	jmp    80106fe7 <alltraps>

8010789c <vector102>:
.globl vector102
vector102:
  pushl $0
8010789c:	6a 00                	push   $0x0
  pushl $102
8010789e:	6a 66                	push   $0x66
  jmp alltraps
801078a0:	e9 42 f7 ff ff       	jmp    80106fe7 <alltraps>

801078a5 <vector103>:
.globl vector103
vector103:
  pushl $0
801078a5:	6a 00                	push   $0x0
  pushl $103
801078a7:	6a 67                	push   $0x67
  jmp alltraps
801078a9:	e9 39 f7 ff ff       	jmp    80106fe7 <alltraps>

801078ae <vector104>:
.globl vector104
vector104:
  pushl $0
801078ae:	6a 00                	push   $0x0
  pushl $104
801078b0:	6a 68                	push   $0x68
  jmp alltraps
801078b2:	e9 30 f7 ff ff       	jmp    80106fe7 <alltraps>

801078b7 <vector105>:
.globl vector105
vector105:
  pushl $0
801078b7:	6a 00                	push   $0x0
  pushl $105
801078b9:	6a 69                	push   $0x69
  jmp alltraps
801078bb:	e9 27 f7 ff ff       	jmp    80106fe7 <alltraps>

801078c0 <vector106>:
.globl vector106
vector106:
  pushl $0
801078c0:	6a 00                	push   $0x0
  pushl $106
801078c2:	6a 6a                	push   $0x6a
  jmp alltraps
801078c4:	e9 1e f7 ff ff       	jmp    80106fe7 <alltraps>

801078c9 <vector107>:
.globl vector107
vector107:
  pushl $0
801078c9:	6a 00                	push   $0x0
  pushl $107
801078cb:	6a 6b                	push   $0x6b
  jmp alltraps
801078cd:	e9 15 f7 ff ff       	jmp    80106fe7 <alltraps>

801078d2 <vector108>:
.globl vector108
vector108:
  pushl $0
801078d2:	6a 00                	push   $0x0
  pushl $108
801078d4:	6a 6c                	push   $0x6c
  jmp alltraps
801078d6:	e9 0c f7 ff ff       	jmp    80106fe7 <alltraps>

801078db <vector109>:
.globl vector109
vector109:
  pushl $0
801078db:	6a 00                	push   $0x0
  pushl $109
801078dd:	6a 6d                	push   $0x6d
  jmp alltraps
801078df:	e9 03 f7 ff ff       	jmp    80106fe7 <alltraps>

801078e4 <vector110>:
.globl vector110
vector110:
  pushl $0
801078e4:	6a 00                	push   $0x0
  pushl $110
801078e6:	6a 6e                	push   $0x6e
  jmp alltraps
801078e8:	e9 fa f6 ff ff       	jmp    80106fe7 <alltraps>

801078ed <vector111>:
.globl vector111
vector111:
  pushl $0
801078ed:	6a 00                	push   $0x0
  pushl $111
801078ef:	6a 6f                	push   $0x6f
  jmp alltraps
801078f1:	e9 f1 f6 ff ff       	jmp    80106fe7 <alltraps>

801078f6 <vector112>:
.globl vector112
vector112:
  pushl $0
801078f6:	6a 00                	push   $0x0
  pushl $112
801078f8:	6a 70                	push   $0x70
  jmp alltraps
801078fa:	e9 e8 f6 ff ff       	jmp    80106fe7 <alltraps>

801078ff <vector113>:
.globl vector113
vector113:
  pushl $0
801078ff:	6a 00                	push   $0x0
  pushl $113
80107901:	6a 71                	push   $0x71
  jmp alltraps
80107903:	e9 df f6 ff ff       	jmp    80106fe7 <alltraps>

80107908 <vector114>:
.globl vector114
vector114:
  pushl $0
80107908:	6a 00                	push   $0x0
  pushl $114
8010790a:	6a 72                	push   $0x72
  jmp alltraps
8010790c:	e9 d6 f6 ff ff       	jmp    80106fe7 <alltraps>

80107911 <vector115>:
.globl vector115
vector115:
  pushl $0
80107911:	6a 00                	push   $0x0
  pushl $115
80107913:	6a 73                	push   $0x73
  jmp alltraps
80107915:	e9 cd f6 ff ff       	jmp    80106fe7 <alltraps>

8010791a <vector116>:
.globl vector116
vector116:
  pushl $0
8010791a:	6a 00                	push   $0x0
  pushl $116
8010791c:	6a 74                	push   $0x74
  jmp alltraps
8010791e:	e9 c4 f6 ff ff       	jmp    80106fe7 <alltraps>

80107923 <vector117>:
.globl vector117
vector117:
  pushl $0
80107923:	6a 00                	push   $0x0
  pushl $117
80107925:	6a 75                	push   $0x75
  jmp alltraps
80107927:	e9 bb f6 ff ff       	jmp    80106fe7 <alltraps>

8010792c <vector118>:
.globl vector118
vector118:
  pushl $0
8010792c:	6a 00                	push   $0x0
  pushl $118
8010792e:	6a 76                	push   $0x76
  jmp alltraps
80107930:	e9 b2 f6 ff ff       	jmp    80106fe7 <alltraps>

80107935 <vector119>:
.globl vector119
vector119:
  pushl $0
80107935:	6a 00                	push   $0x0
  pushl $119
80107937:	6a 77                	push   $0x77
  jmp alltraps
80107939:	e9 a9 f6 ff ff       	jmp    80106fe7 <alltraps>

8010793e <vector120>:
.globl vector120
vector120:
  pushl $0
8010793e:	6a 00                	push   $0x0
  pushl $120
80107940:	6a 78                	push   $0x78
  jmp alltraps
80107942:	e9 a0 f6 ff ff       	jmp    80106fe7 <alltraps>

80107947 <vector121>:
.globl vector121
vector121:
  pushl $0
80107947:	6a 00                	push   $0x0
  pushl $121
80107949:	6a 79                	push   $0x79
  jmp alltraps
8010794b:	e9 97 f6 ff ff       	jmp    80106fe7 <alltraps>

80107950 <vector122>:
.globl vector122
vector122:
  pushl $0
80107950:	6a 00                	push   $0x0
  pushl $122
80107952:	6a 7a                	push   $0x7a
  jmp alltraps
80107954:	e9 8e f6 ff ff       	jmp    80106fe7 <alltraps>

80107959 <vector123>:
.globl vector123
vector123:
  pushl $0
80107959:	6a 00                	push   $0x0
  pushl $123
8010795b:	6a 7b                	push   $0x7b
  jmp alltraps
8010795d:	e9 85 f6 ff ff       	jmp    80106fe7 <alltraps>

80107962 <vector124>:
.globl vector124
vector124:
  pushl $0
80107962:	6a 00                	push   $0x0
  pushl $124
80107964:	6a 7c                	push   $0x7c
  jmp alltraps
80107966:	e9 7c f6 ff ff       	jmp    80106fe7 <alltraps>

8010796b <vector125>:
.globl vector125
vector125:
  pushl $0
8010796b:	6a 00                	push   $0x0
  pushl $125
8010796d:	6a 7d                	push   $0x7d
  jmp alltraps
8010796f:	e9 73 f6 ff ff       	jmp    80106fe7 <alltraps>

80107974 <vector126>:
.globl vector126
vector126:
  pushl $0
80107974:	6a 00                	push   $0x0
  pushl $126
80107976:	6a 7e                	push   $0x7e
  jmp alltraps
80107978:	e9 6a f6 ff ff       	jmp    80106fe7 <alltraps>

8010797d <vector127>:
.globl vector127
vector127:
  pushl $0
8010797d:	6a 00                	push   $0x0
  pushl $127
8010797f:	6a 7f                	push   $0x7f
  jmp alltraps
80107981:	e9 61 f6 ff ff       	jmp    80106fe7 <alltraps>

80107986 <vector128>:
.globl vector128
vector128:
  pushl $0
80107986:	6a 00                	push   $0x0
  pushl $128
80107988:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010798d:	e9 55 f6 ff ff       	jmp    80106fe7 <alltraps>

80107992 <vector129>:
.globl vector129
vector129:
  pushl $0
80107992:	6a 00                	push   $0x0
  pushl $129
80107994:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80107999:	e9 49 f6 ff ff       	jmp    80106fe7 <alltraps>

8010799e <vector130>:
.globl vector130
vector130:
  pushl $0
8010799e:	6a 00                	push   $0x0
  pushl $130
801079a0:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801079a5:	e9 3d f6 ff ff       	jmp    80106fe7 <alltraps>

801079aa <vector131>:
.globl vector131
vector131:
  pushl $0
801079aa:	6a 00                	push   $0x0
  pushl $131
801079ac:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801079b1:	e9 31 f6 ff ff       	jmp    80106fe7 <alltraps>

801079b6 <vector132>:
.globl vector132
vector132:
  pushl $0
801079b6:	6a 00                	push   $0x0
  pushl $132
801079b8:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801079bd:	e9 25 f6 ff ff       	jmp    80106fe7 <alltraps>

801079c2 <vector133>:
.globl vector133
vector133:
  pushl $0
801079c2:	6a 00                	push   $0x0
  pushl $133
801079c4:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801079c9:	e9 19 f6 ff ff       	jmp    80106fe7 <alltraps>

801079ce <vector134>:
.globl vector134
vector134:
  pushl $0
801079ce:	6a 00                	push   $0x0
  pushl $134
801079d0:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801079d5:	e9 0d f6 ff ff       	jmp    80106fe7 <alltraps>

801079da <vector135>:
.globl vector135
vector135:
  pushl $0
801079da:	6a 00                	push   $0x0
  pushl $135
801079dc:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801079e1:	e9 01 f6 ff ff       	jmp    80106fe7 <alltraps>

801079e6 <vector136>:
.globl vector136
vector136:
  pushl $0
801079e6:	6a 00                	push   $0x0
  pushl $136
801079e8:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801079ed:	e9 f5 f5 ff ff       	jmp    80106fe7 <alltraps>

801079f2 <vector137>:
.globl vector137
vector137:
  pushl $0
801079f2:	6a 00                	push   $0x0
  pushl $137
801079f4:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801079f9:	e9 e9 f5 ff ff       	jmp    80106fe7 <alltraps>

801079fe <vector138>:
.globl vector138
vector138:
  pushl $0
801079fe:	6a 00                	push   $0x0
  pushl $138
80107a00:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107a05:	e9 dd f5 ff ff       	jmp    80106fe7 <alltraps>

80107a0a <vector139>:
.globl vector139
vector139:
  pushl $0
80107a0a:	6a 00                	push   $0x0
  pushl $139
80107a0c:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80107a11:	e9 d1 f5 ff ff       	jmp    80106fe7 <alltraps>

80107a16 <vector140>:
.globl vector140
vector140:
  pushl $0
80107a16:	6a 00                	push   $0x0
  pushl $140
80107a18:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80107a1d:	e9 c5 f5 ff ff       	jmp    80106fe7 <alltraps>

80107a22 <vector141>:
.globl vector141
vector141:
  pushl $0
80107a22:	6a 00                	push   $0x0
  pushl $141
80107a24:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80107a29:	e9 b9 f5 ff ff       	jmp    80106fe7 <alltraps>

80107a2e <vector142>:
.globl vector142
vector142:
  pushl $0
80107a2e:	6a 00                	push   $0x0
  pushl $142
80107a30:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107a35:	e9 ad f5 ff ff       	jmp    80106fe7 <alltraps>

80107a3a <vector143>:
.globl vector143
vector143:
  pushl $0
80107a3a:	6a 00                	push   $0x0
  pushl $143
80107a3c:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80107a41:	e9 a1 f5 ff ff       	jmp    80106fe7 <alltraps>

80107a46 <vector144>:
.globl vector144
vector144:
  pushl $0
80107a46:	6a 00                	push   $0x0
  pushl $144
80107a48:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80107a4d:	e9 95 f5 ff ff       	jmp    80106fe7 <alltraps>

80107a52 <vector145>:
.globl vector145
vector145:
  pushl $0
80107a52:	6a 00                	push   $0x0
  pushl $145
80107a54:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80107a59:	e9 89 f5 ff ff       	jmp    80106fe7 <alltraps>

80107a5e <vector146>:
.globl vector146
vector146:
  pushl $0
80107a5e:	6a 00                	push   $0x0
  pushl $146
80107a60:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107a65:	e9 7d f5 ff ff       	jmp    80106fe7 <alltraps>

80107a6a <vector147>:
.globl vector147
vector147:
  pushl $0
80107a6a:	6a 00                	push   $0x0
  pushl $147
80107a6c:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107a71:	e9 71 f5 ff ff       	jmp    80106fe7 <alltraps>

80107a76 <vector148>:
.globl vector148
vector148:
  pushl $0
80107a76:	6a 00                	push   $0x0
  pushl $148
80107a78:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80107a7d:	e9 65 f5 ff ff       	jmp    80106fe7 <alltraps>

80107a82 <vector149>:
.globl vector149
vector149:
  pushl $0
80107a82:	6a 00                	push   $0x0
  pushl $149
80107a84:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80107a89:	e9 59 f5 ff ff       	jmp    80106fe7 <alltraps>

80107a8e <vector150>:
.globl vector150
vector150:
  pushl $0
80107a8e:	6a 00                	push   $0x0
  pushl $150
80107a90:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107a95:	e9 4d f5 ff ff       	jmp    80106fe7 <alltraps>

80107a9a <vector151>:
.globl vector151
vector151:
  pushl $0
80107a9a:	6a 00                	push   $0x0
  pushl $151
80107a9c:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107aa1:	e9 41 f5 ff ff       	jmp    80106fe7 <alltraps>

80107aa6 <vector152>:
.globl vector152
vector152:
  pushl $0
80107aa6:	6a 00                	push   $0x0
  pushl $152
80107aa8:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80107aad:	e9 35 f5 ff ff       	jmp    80106fe7 <alltraps>

80107ab2 <vector153>:
.globl vector153
vector153:
  pushl $0
80107ab2:	6a 00                	push   $0x0
  pushl $153
80107ab4:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80107ab9:	e9 29 f5 ff ff       	jmp    80106fe7 <alltraps>

80107abe <vector154>:
.globl vector154
vector154:
  pushl $0
80107abe:	6a 00                	push   $0x0
  pushl $154
80107ac0:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107ac5:	e9 1d f5 ff ff       	jmp    80106fe7 <alltraps>

80107aca <vector155>:
.globl vector155
vector155:
  pushl $0
80107aca:	6a 00                	push   $0x0
  pushl $155
80107acc:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107ad1:	e9 11 f5 ff ff       	jmp    80106fe7 <alltraps>

80107ad6 <vector156>:
.globl vector156
vector156:
  pushl $0
80107ad6:	6a 00                	push   $0x0
  pushl $156
80107ad8:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80107add:	e9 05 f5 ff ff       	jmp    80106fe7 <alltraps>

80107ae2 <vector157>:
.globl vector157
vector157:
  pushl $0
80107ae2:	6a 00                	push   $0x0
  pushl $157
80107ae4:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80107ae9:	e9 f9 f4 ff ff       	jmp    80106fe7 <alltraps>

80107aee <vector158>:
.globl vector158
vector158:
  pushl $0
80107aee:	6a 00                	push   $0x0
  pushl $158
80107af0:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107af5:	e9 ed f4 ff ff       	jmp    80106fe7 <alltraps>

80107afa <vector159>:
.globl vector159
vector159:
  pushl $0
80107afa:	6a 00                	push   $0x0
  pushl $159
80107afc:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80107b01:	e9 e1 f4 ff ff       	jmp    80106fe7 <alltraps>

80107b06 <vector160>:
.globl vector160
vector160:
  pushl $0
80107b06:	6a 00                	push   $0x0
  pushl $160
80107b08:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80107b0d:	e9 d5 f4 ff ff       	jmp    80106fe7 <alltraps>

80107b12 <vector161>:
.globl vector161
vector161:
  pushl $0
80107b12:	6a 00                	push   $0x0
  pushl $161
80107b14:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80107b19:	e9 c9 f4 ff ff       	jmp    80106fe7 <alltraps>

80107b1e <vector162>:
.globl vector162
vector162:
  pushl $0
80107b1e:	6a 00                	push   $0x0
  pushl $162
80107b20:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107b25:	e9 bd f4 ff ff       	jmp    80106fe7 <alltraps>

80107b2a <vector163>:
.globl vector163
vector163:
  pushl $0
80107b2a:	6a 00                	push   $0x0
  pushl $163
80107b2c:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80107b31:	e9 b1 f4 ff ff       	jmp    80106fe7 <alltraps>

80107b36 <vector164>:
.globl vector164
vector164:
  pushl $0
80107b36:	6a 00                	push   $0x0
  pushl $164
80107b38:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80107b3d:	e9 a5 f4 ff ff       	jmp    80106fe7 <alltraps>

80107b42 <vector165>:
.globl vector165
vector165:
  pushl $0
80107b42:	6a 00                	push   $0x0
  pushl $165
80107b44:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80107b49:	e9 99 f4 ff ff       	jmp    80106fe7 <alltraps>

80107b4e <vector166>:
.globl vector166
vector166:
  pushl $0
80107b4e:	6a 00                	push   $0x0
  pushl $166
80107b50:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107b55:	e9 8d f4 ff ff       	jmp    80106fe7 <alltraps>

80107b5a <vector167>:
.globl vector167
vector167:
  pushl $0
80107b5a:	6a 00                	push   $0x0
  pushl $167
80107b5c:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107b61:	e9 81 f4 ff ff       	jmp    80106fe7 <alltraps>

80107b66 <vector168>:
.globl vector168
vector168:
  pushl $0
80107b66:	6a 00                	push   $0x0
  pushl $168
80107b68:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80107b6d:	e9 75 f4 ff ff       	jmp    80106fe7 <alltraps>

80107b72 <vector169>:
.globl vector169
vector169:
  pushl $0
80107b72:	6a 00                	push   $0x0
  pushl $169
80107b74:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80107b79:	e9 69 f4 ff ff       	jmp    80106fe7 <alltraps>

80107b7e <vector170>:
.globl vector170
vector170:
  pushl $0
80107b7e:	6a 00                	push   $0x0
  pushl $170
80107b80:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107b85:	e9 5d f4 ff ff       	jmp    80106fe7 <alltraps>

80107b8a <vector171>:
.globl vector171
vector171:
  pushl $0
80107b8a:	6a 00                	push   $0x0
  pushl $171
80107b8c:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107b91:	e9 51 f4 ff ff       	jmp    80106fe7 <alltraps>

80107b96 <vector172>:
.globl vector172
vector172:
  pushl $0
80107b96:	6a 00                	push   $0x0
  pushl $172
80107b98:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80107b9d:	e9 45 f4 ff ff       	jmp    80106fe7 <alltraps>

80107ba2 <vector173>:
.globl vector173
vector173:
  pushl $0
80107ba2:	6a 00                	push   $0x0
  pushl $173
80107ba4:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80107ba9:	e9 39 f4 ff ff       	jmp    80106fe7 <alltraps>

80107bae <vector174>:
.globl vector174
vector174:
  pushl $0
80107bae:	6a 00                	push   $0x0
  pushl $174
80107bb0:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107bb5:	e9 2d f4 ff ff       	jmp    80106fe7 <alltraps>

80107bba <vector175>:
.globl vector175
vector175:
  pushl $0
80107bba:	6a 00                	push   $0x0
  pushl $175
80107bbc:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107bc1:	e9 21 f4 ff ff       	jmp    80106fe7 <alltraps>

80107bc6 <vector176>:
.globl vector176
vector176:
  pushl $0
80107bc6:	6a 00                	push   $0x0
  pushl $176
80107bc8:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80107bcd:	e9 15 f4 ff ff       	jmp    80106fe7 <alltraps>

80107bd2 <vector177>:
.globl vector177
vector177:
  pushl $0
80107bd2:	6a 00                	push   $0x0
  pushl $177
80107bd4:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80107bd9:	e9 09 f4 ff ff       	jmp    80106fe7 <alltraps>

80107bde <vector178>:
.globl vector178
vector178:
  pushl $0
80107bde:	6a 00                	push   $0x0
  pushl $178
80107be0:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107be5:	e9 fd f3 ff ff       	jmp    80106fe7 <alltraps>

80107bea <vector179>:
.globl vector179
vector179:
  pushl $0
80107bea:	6a 00                	push   $0x0
  pushl $179
80107bec:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107bf1:	e9 f1 f3 ff ff       	jmp    80106fe7 <alltraps>

80107bf6 <vector180>:
.globl vector180
vector180:
  pushl $0
80107bf6:	6a 00                	push   $0x0
  pushl $180
80107bf8:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80107bfd:	e9 e5 f3 ff ff       	jmp    80106fe7 <alltraps>

80107c02 <vector181>:
.globl vector181
vector181:
  pushl $0
80107c02:	6a 00                	push   $0x0
  pushl $181
80107c04:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80107c09:	e9 d9 f3 ff ff       	jmp    80106fe7 <alltraps>

80107c0e <vector182>:
.globl vector182
vector182:
  pushl $0
80107c0e:	6a 00                	push   $0x0
  pushl $182
80107c10:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107c15:	e9 cd f3 ff ff       	jmp    80106fe7 <alltraps>

80107c1a <vector183>:
.globl vector183
vector183:
  pushl $0
80107c1a:	6a 00                	push   $0x0
  pushl $183
80107c1c:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107c21:	e9 c1 f3 ff ff       	jmp    80106fe7 <alltraps>

80107c26 <vector184>:
.globl vector184
vector184:
  pushl $0
80107c26:	6a 00                	push   $0x0
  pushl $184
80107c28:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80107c2d:	e9 b5 f3 ff ff       	jmp    80106fe7 <alltraps>

80107c32 <vector185>:
.globl vector185
vector185:
  pushl $0
80107c32:	6a 00                	push   $0x0
  pushl $185
80107c34:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80107c39:	e9 a9 f3 ff ff       	jmp    80106fe7 <alltraps>

80107c3e <vector186>:
.globl vector186
vector186:
  pushl $0
80107c3e:	6a 00                	push   $0x0
  pushl $186
80107c40:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107c45:	e9 9d f3 ff ff       	jmp    80106fe7 <alltraps>

80107c4a <vector187>:
.globl vector187
vector187:
  pushl $0
80107c4a:	6a 00                	push   $0x0
  pushl $187
80107c4c:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107c51:	e9 91 f3 ff ff       	jmp    80106fe7 <alltraps>

80107c56 <vector188>:
.globl vector188
vector188:
  pushl $0
80107c56:	6a 00                	push   $0x0
  pushl $188
80107c58:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80107c5d:	e9 85 f3 ff ff       	jmp    80106fe7 <alltraps>

80107c62 <vector189>:
.globl vector189
vector189:
  pushl $0
80107c62:	6a 00                	push   $0x0
  pushl $189
80107c64:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80107c69:	e9 79 f3 ff ff       	jmp    80106fe7 <alltraps>

80107c6e <vector190>:
.globl vector190
vector190:
  pushl $0
80107c6e:	6a 00                	push   $0x0
  pushl $190
80107c70:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107c75:	e9 6d f3 ff ff       	jmp    80106fe7 <alltraps>

80107c7a <vector191>:
.globl vector191
vector191:
  pushl $0
80107c7a:	6a 00                	push   $0x0
  pushl $191
80107c7c:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107c81:	e9 61 f3 ff ff       	jmp    80106fe7 <alltraps>

80107c86 <vector192>:
.globl vector192
vector192:
  pushl $0
80107c86:	6a 00                	push   $0x0
  pushl $192
80107c88:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80107c8d:	e9 55 f3 ff ff       	jmp    80106fe7 <alltraps>

80107c92 <vector193>:
.globl vector193
vector193:
  pushl $0
80107c92:	6a 00                	push   $0x0
  pushl $193
80107c94:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80107c99:	e9 49 f3 ff ff       	jmp    80106fe7 <alltraps>

80107c9e <vector194>:
.globl vector194
vector194:
  pushl $0
80107c9e:	6a 00                	push   $0x0
  pushl $194
80107ca0:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107ca5:	e9 3d f3 ff ff       	jmp    80106fe7 <alltraps>

80107caa <vector195>:
.globl vector195
vector195:
  pushl $0
80107caa:	6a 00                	push   $0x0
  pushl $195
80107cac:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107cb1:	e9 31 f3 ff ff       	jmp    80106fe7 <alltraps>

80107cb6 <vector196>:
.globl vector196
vector196:
  pushl $0
80107cb6:	6a 00                	push   $0x0
  pushl $196
80107cb8:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80107cbd:	e9 25 f3 ff ff       	jmp    80106fe7 <alltraps>

80107cc2 <vector197>:
.globl vector197
vector197:
  pushl $0
80107cc2:	6a 00                	push   $0x0
  pushl $197
80107cc4:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80107cc9:	e9 19 f3 ff ff       	jmp    80106fe7 <alltraps>

80107cce <vector198>:
.globl vector198
vector198:
  pushl $0
80107cce:	6a 00                	push   $0x0
  pushl $198
80107cd0:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107cd5:	e9 0d f3 ff ff       	jmp    80106fe7 <alltraps>

80107cda <vector199>:
.globl vector199
vector199:
  pushl $0
80107cda:	6a 00                	push   $0x0
  pushl $199
80107cdc:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107ce1:	e9 01 f3 ff ff       	jmp    80106fe7 <alltraps>

80107ce6 <vector200>:
.globl vector200
vector200:
  pushl $0
80107ce6:	6a 00                	push   $0x0
  pushl $200
80107ce8:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80107ced:	e9 f5 f2 ff ff       	jmp    80106fe7 <alltraps>

80107cf2 <vector201>:
.globl vector201
vector201:
  pushl $0
80107cf2:	6a 00                	push   $0x0
  pushl $201
80107cf4:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80107cf9:	e9 e9 f2 ff ff       	jmp    80106fe7 <alltraps>

80107cfe <vector202>:
.globl vector202
vector202:
  pushl $0
80107cfe:	6a 00                	push   $0x0
  pushl $202
80107d00:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107d05:	e9 dd f2 ff ff       	jmp    80106fe7 <alltraps>

80107d0a <vector203>:
.globl vector203
vector203:
  pushl $0
80107d0a:	6a 00                	push   $0x0
  pushl $203
80107d0c:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107d11:	e9 d1 f2 ff ff       	jmp    80106fe7 <alltraps>

80107d16 <vector204>:
.globl vector204
vector204:
  pushl $0
80107d16:	6a 00                	push   $0x0
  pushl $204
80107d18:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80107d1d:	e9 c5 f2 ff ff       	jmp    80106fe7 <alltraps>

80107d22 <vector205>:
.globl vector205
vector205:
  pushl $0
80107d22:	6a 00                	push   $0x0
  pushl $205
80107d24:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80107d29:	e9 b9 f2 ff ff       	jmp    80106fe7 <alltraps>

80107d2e <vector206>:
.globl vector206
vector206:
  pushl $0
80107d2e:	6a 00                	push   $0x0
  pushl $206
80107d30:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107d35:	e9 ad f2 ff ff       	jmp    80106fe7 <alltraps>

80107d3a <vector207>:
.globl vector207
vector207:
  pushl $0
80107d3a:	6a 00                	push   $0x0
  pushl $207
80107d3c:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107d41:	e9 a1 f2 ff ff       	jmp    80106fe7 <alltraps>

80107d46 <vector208>:
.globl vector208
vector208:
  pushl $0
80107d46:	6a 00                	push   $0x0
  pushl $208
80107d48:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80107d4d:	e9 95 f2 ff ff       	jmp    80106fe7 <alltraps>

80107d52 <vector209>:
.globl vector209
vector209:
  pushl $0
80107d52:	6a 00                	push   $0x0
  pushl $209
80107d54:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80107d59:	e9 89 f2 ff ff       	jmp    80106fe7 <alltraps>

80107d5e <vector210>:
.globl vector210
vector210:
  pushl $0
80107d5e:	6a 00                	push   $0x0
  pushl $210
80107d60:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107d65:	e9 7d f2 ff ff       	jmp    80106fe7 <alltraps>

80107d6a <vector211>:
.globl vector211
vector211:
  pushl $0
80107d6a:	6a 00                	push   $0x0
  pushl $211
80107d6c:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107d71:	e9 71 f2 ff ff       	jmp    80106fe7 <alltraps>

80107d76 <vector212>:
.globl vector212
vector212:
  pushl $0
80107d76:	6a 00                	push   $0x0
  pushl $212
80107d78:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80107d7d:	e9 65 f2 ff ff       	jmp    80106fe7 <alltraps>

80107d82 <vector213>:
.globl vector213
vector213:
  pushl $0
80107d82:	6a 00                	push   $0x0
  pushl $213
80107d84:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80107d89:	e9 59 f2 ff ff       	jmp    80106fe7 <alltraps>

80107d8e <vector214>:
.globl vector214
vector214:
  pushl $0
80107d8e:	6a 00                	push   $0x0
  pushl $214
80107d90:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107d95:	e9 4d f2 ff ff       	jmp    80106fe7 <alltraps>

80107d9a <vector215>:
.globl vector215
vector215:
  pushl $0
80107d9a:	6a 00                	push   $0x0
  pushl $215
80107d9c:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107da1:	e9 41 f2 ff ff       	jmp    80106fe7 <alltraps>

80107da6 <vector216>:
.globl vector216
vector216:
  pushl $0
80107da6:	6a 00                	push   $0x0
  pushl $216
80107da8:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80107dad:	e9 35 f2 ff ff       	jmp    80106fe7 <alltraps>

80107db2 <vector217>:
.globl vector217
vector217:
  pushl $0
80107db2:	6a 00                	push   $0x0
  pushl $217
80107db4:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80107db9:	e9 29 f2 ff ff       	jmp    80106fe7 <alltraps>

80107dbe <vector218>:
.globl vector218
vector218:
  pushl $0
80107dbe:	6a 00                	push   $0x0
  pushl $218
80107dc0:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107dc5:	e9 1d f2 ff ff       	jmp    80106fe7 <alltraps>

80107dca <vector219>:
.globl vector219
vector219:
  pushl $0
80107dca:	6a 00                	push   $0x0
  pushl $219
80107dcc:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107dd1:	e9 11 f2 ff ff       	jmp    80106fe7 <alltraps>

80107dd6 <vector220>:
.globl vector220
vector220:
  pushl $0
80107dd6:	6a 00                	push   $0x0
  pushl $220
80107dd8:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80107ddd:	e9 05 f2 ff ff       	jmp    80106fe7 <alltraps>

80107de2 <vector221>:
.globl vector221
vector221:
  pushl $0
80107de2:	6a 00                	push   $0x0
  pushl $221
80107de4:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80107de9:	e9 f9 f1 ff ff       	jmp    80106fe7 <alltraps>

80107dee <vector222>:
.globl vector222
vector222:
  pushl $0
80107dee:	6a 00                	push   $0x0
  pushl $222
80107df0:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107df5:	e9 ed f1 ff ff       	jmp    80106fe7 <alltraps>

80107dfa <vector223>:
.globl vector223
vector223:
  pushl $0
80107dfa:	6a 00                	push   $0x0
  pushl $223
80107dfc:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107e01:	e9 e1 f1 ff ff       	jmp    80106fe7 <alltraps>

80107e06 <vector224>:
.globl vector224
vector224:
  pushl $0
80107e06:	6a 00                	push   $0x0
  pushl $224
80107e08:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80107e0d:	e9 d5 f1 ff ff       	jmp    80106fe7 <alltraps>

80107e12 <vector225>:
.globl vector225
vector225:
  pushl $0
80107e12:	6a 00                	push   $0x0
  pushl $225
80107e14:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107e19:	e9 c9 f1 ff ff       	jmp    80106fe7 <alltraps>

80107e1e <vector226>:
.globl vector226
vector226:
  pushl $0
80107e1e:	6a 00                	push   $0x0
  pushl $226
80107e20:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107e25:	e9 bd f1 ff ff       	jmp    80106fe7 <alltraps>

80107e2a <vector227>:
.globl vector227
vector227:
  pushl $0
80107e2a:	6a 00                	push   $0x0
  pushl $227
80107e2c:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107e31:	e9 b1 f1 ff ff       	jmp    80106fe7 <alltraps>

80107e36 <vector228>:
.globl vector228
vector228:
  pushl $0
80107e36:	6a 00                	push   $0x0
  pushl $228
80107e38:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107e3d:	e9 a5 f1 ff ff       	jmp    80106fe7 <alltraps>

80107e42 <vector229>:
.globl vector229
vector229:
  pushl $0
80107e42:	6a 00                	push   $0x0
  pushl $229
80107e44:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107e49:	e9 99 f1 ff ff       	jmp    80106fe7 <alltraps>

80107e4e <vector230>:
.globl vector230
vector230:
  pushl $0
80107e4e:	6a 00                	push   $0x0
  pushl $230
80107e50:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107e55:	e9 8d f1 ff ff       	jmp    80106fe7 <alltraps>

80107e5a <vector231>:
.globl vector231
vector231:
  pushl $0
80107e5a:	6a 00                	push   $0x0
  pushl $231
80107e5c:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107e61:	e9 81 f1 ff ff       	jmp    80106fe7 <alltraps>

80107e66 <vector232>:
.globl vector232
vector232:
  pushl $0
80107e66:	6a 00                	push   $0x0
  pushl $232
80107e68:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107e6d:	e9 75 f1 ff ff       	jmp    80106fe7 <alltraps>

80107e72 <vector233>:
.globl vector233
vector233:
  pushl $0
80107e72:	6a 00                	push   $0x0
  pushl $233
80107e74:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107e79:	e9 69 f1 ff ff       	jmp    80106fe7 <alltraps>

80107e7e <vector234>:
.globl vector234
vector234:
  pushl $0
80107e7e:	6a 00                	push   $0x0
  pushl $234
80107e80:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107e85:	e9 5d f1 ff ff       	jmp    80106fe7 <alltraps>

80107e8a <vector235>:
.globl vector235
vector235:
  pushl $0
80107e8a:	6a 00                	push   $0x0
  pushl $235
80107e8c:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107e91:	e9 51 f1 ff ff       	jmp    80106fe7 <alltraps>

80107e96 <vector236>:
.globl vector236
vector236:
  pushl $0
80107e96:	6a 00                	push   $0x0
  pushl $236
80107e98:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107e9d:	e9 45 f1 ff ff       	jmp    80106fe7 <alltraps>

80107ea2 <vector237>:
.globl vector237
vector237:
  pushl $0
80107ea2:	6a 00                	push   $0x0
  pushl $237
80107ea4:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107ea9:	e9 39 f1 ff ff       	jmp    80106fe7 <alltraps>

80107eae <vector238>:
.globl vector238
vector238:
  pushl $0
80107eae:	6a 00                	push   $0x0
  pushl $238
80107eb0:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107eb5:	e9 2d f1 ff ff       	jmp    80106fe7 <alltraps>

80107eba <vector239>:
.globl vector239
vector239:
  pushl $0
80107eba:	6a 00                	push   $0x0
  pushl $239
80107ebc:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107ec1:	e9 21 f1 ff ff       	jmp    80106fe7 <alltraps>

80107ec6 <vector240>:
.globl vector240
vector240:
  pushl $0
80107ec6:	6a 00                	push   $0x0
  pushl $240
80107ec8:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107ecd:	e9 15 f1 ff ff       	jmp    80106fe7 <alltraps>

80107ed2 <vector241>:
.globl vector241
vector241:
  pushl $0
80107ed2:	6a 00                	push   $0x0
  pushl $241
80107ed4:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107ed9:	e9 09 f1 ff ff       	jmp    80106fe7 <alltraps>

80107ede <vector242>:
.globl vector242
vector242:
  pushl $0
80107ede:	6a 00                	push   $0x0
  pushl $242
80107ee0:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107ee5:	e9 fd f0 ff ff       	jmp    80106fe7 <alltraps>

80107eea <vector243>:
.globl vector243
vector243:
  pushl $0
80107eea:	6a 00                	push   $0x0
  pushl $243
80107eec:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107ef1:	e9 f1 f0 ff ff       	jmp    80106fe7 <alltraps>

80107ef6 <vector244>:
.globl vector244
vector244:
  pushl $0
80107ef6:	6a 00                	push   $0x0
  pushl $244
80107ef8:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107efd:	e9 e5 f0 ff ff       	jmp    80106fe7 <alltraps>

80107f02 <vector245>:
.globl vector245
vector245:
  pushl $0
80107f02:	6a 00                	push   $0x0
  pushl $245
80107f04:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107f09:	e9 d9 f0 ff ff       	jmp    80106fe7 <alltraps>

80107f0e <vector246>:
.globl vector246
vector246:
  pushl $0
80107f0e:	6a 00                	push   $0x0
  pushl $246
80107f10:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107f15:	e9 cd f0 ff ff       	jmp    80106fe7 <alltraps>

80107f1a <vector247>:
.globl vector247
vector247:
  pushl $0
80107f1a:	6a 00                	push   $0x0
  pushl $247
80107f1c:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107f21:	e9 c1 f0 ff ff       	jmp    80106fe7 <alltraps>

80107f26 <vector248>:
.globl vector248
vector248:
  pushl $0
80107f26:	6a 00                	push   $0x0
  pushl $248
80107f28:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107f2d:	e9 b5 f0 ff ff       	jmp    80106fe7 <alltraps>

80107f32 <vector249>:
.globl vector249
vector249:
  pushl $0
80107f32:	6a 00                	push   $0x0
  pushl $249
80107f34:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107f39:	e9 a9 f0 ff ff       	jmp    80106fe7 <alltraps>

80107f3e <vector250>:
.globl vector250
vector250:
  pushl $0
80107f3e:	6a 00                	push   $0x0
  pushl $250
80107f40:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107f45:	e9 9d f0 ff ff       	jmp    80106fe7 <alltraps>

80107f4a <vector251>:
.globl vector251
vector251:
  pushl $0
80107f4a:	6a 00                	push   $0x0
  pushl $251
80107f4c:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107f51:	e9 91 f0 ff ff       	jmp    80106fe7 <alltraps>

80107f56 <vector252>:
.globl vector252
vector252:
  pushl $0
80107f56:	6a 00                	push   $0x0
  pushl $252
80107f58:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107f5d:	e9 85 f0 ff ff       	jmp    80106fe7 <alltraps>

80107f62 <vector253>:
.globl vector253
vector253:
  pushl $0
80107f62:	6a 00                	push   $0x0
  pushl $253
80107f64:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107f69:	e9 79 f0 ff ff       	jmp    80106fe7 <alltraps>

80107f6e <vector254>:
.globl vector254
vector254:
  pushl $0
80107f6e:	6a 00                	push   $0x0
  pushl $254
80107f70:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107f75:	e9 6d f0 ff ff       	jmp    80106fe7 <alltraps>

80107f7a <vector255>:
.globl vector255
vector255:
  pushl $0
80107f7a:	6a 00                	push   $0x0
  pushl $255
80107f7c:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107f81:	e9 61 f0 ff ff       	jmp    80106fe7 <alltraps>
80107f86:	66 90                	xchg   %ax,%ax
80107f88:	66 90                	xchg   %ax,%ax
80107f8a:	66 90                	xchg   %ax,%ax
80107f8c:	66 90                	xchg   %ax,%ax
80107f8e:	66 90                	xchg   %ax,%ax

80107f90 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107f90:	55                   	push   %ebp
80107f91:	89 e5                	mov    %esp,%ebp
80107f93:	83 ec 28             	sub    $0x28,%esp
80107f96:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107f99:	89 d3                	mov    %edx,%ebx
80107f9b:	c1 eb 16             	shr    $0x16,%ebx
{
80107f9e:	89 75 f8             	mov    %esi,-0x8(%ebp)
  pde = &pgdir[PDX(va)];
80107fa1:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80107fa4:	89 7d fc             	mov    %edi,-0x4(%ebp)
80107fa7:	89 d7                	mov    %edx,%edi
  if(*pde & PTE_P){
80107fa9:	8b 06                	mov    (%esi),%eax
80107fab:	a8 01                	test   $0x1,%al
80107fad:	74 29                	je     80107fd8 <walkpgdir+0x48>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107faf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107fb4:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107fba:	c1 ef 0a             	shr    $0xa,%edi
}
80107fbd:	8b 75 f8             	mov    -0x8(%ebp),%esi
  return &pgtab[PTX(va)];
80107fc0:	89 fa                	mov    %edi,%edx
}
80107fc2:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return &pgtab[PTX(va)];
80107fc5:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107fcb:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80107fce:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107fd1:	89 ec                	mov    %ebp,%esp
80107fd3:	5d                   	pop    %ebp
80107fd4:	c3                   	ret    
80107fd5:	8d 76 00             	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107fd8:	85 c9                	test   %ecx,%ecx
80107fda:	74 34                	je     80108010 <walkpgdir+0x80>
80107fdc:	e8 cf a5 ff ff       	call   801025b0 <kalloc>
80107fe1:	85 c0                	test   %eax,%eax
80107fe3:	89 c3                	mov    %eax,%ebx
80107fe5:	74 29                	je     80108010 <walkpgdir+0x80>
    memset(pgtab, 0, PGSIZE);
80107fe7:	b8 00 10 00 00       	mov    $0x1000,%eax
80107fec:	31 d2                	xor    %edx,%edx
80107fee:	89 44 24 08          	mov    %eax,0x8(%esp)
80107ff2:	89 54 24 04          	mov    %edx,0x4(%esp)
80107ff6:	89 1c 24             	mov    %ebx,(%esp)
80107ff9:	e8 d2 dc ff ff       	call   80105cd0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107ffe:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80108004:	83 c8 07             	or     $0x7,%eax
80108007:	89 06                	mov    %eax,(%esi)
80108009:	eb af                	jmp    80107fba <walkpgdir+0x2a>
8010800b:	90                   	nop
8010800c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80108010:	8b 5d f4             	mov    -0xc(%ebp),%ebx
      return 0;
80108013:	31 c0                	xor    %eax,%eax
}
80108015:	8b 75 f8             	mov    -0x8(%ebp),%esi
80108018:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010801b:	89 ec                	mov    %ebp,%esp
8010801d:	5d                   	pop    %ebp
8010801e:	c3                   	ret    
8010801f:	90                   	nop

80108020 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80108020:	55                   	push   %ebp
80108021:	89 e5                	mov    %esp,%ebp
80108023:	57                   	push   %edi
80108024:	56                   	push   %esi
80108025:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80108026:	89 d3                	mov    %edx,%ebx
{
80108028:	83 ec 2c             	sub    $0x2c,%esp
  a = (char*)PGROUNDDOWN((uint)va);
8010802b:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80108031:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80108034:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80108038:	8b 7d 08             	mov    0x8(%ebp),%edi
8010803b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108040:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80108043:	8b 45 0c             	mov    0xc(%ebp),%eax
80108046:	29 df                	sub    %ebx,%edi
80108048:	83 c8 01             	or     $0x1,%eax
8010804b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010804e:	eb 17                	jmp    80108067 <mappages+0x47>
    if(*pte & PTE_P)
80108050:	f6 00 01             	testb  $0x1,(%eax)
80108053:	75 45                	jne    8010809a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80108055:	8b 55 dc             	mov    -0x24(%ebp),%edx
80108058:	09 d6                	or     %edx,%esi
    if(a == last)
8010805a:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
8010805d:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010805f:	74 2f                	je     80108090 <mappages+0x70>
      break;
    a += PGSIZE;
80108061:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80108067:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010806a:	b9 01 00 00 00       	mov    $0x1,%ecx
8010806f:	89 da                	mov    %ebx,%edx
80108071:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80108074:	e8 17 ff ff ff       	call   80107f90 <walkpgdir>
80108079:	85 c0                	test   %eax,%eax
8010807b:	75 d3                	jne    80108050 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010807d:	83 c4 2c             	add    $0x2c,%esp
      return -1;
80108080:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80108085:	5b                   	pop    %ebx
80108086:	5e                   	pop    %esi
80108087:	5f                   	pop    %edi
80108088:	5d                   	pop    %ebp
80108089:	c3                   	ret    
8010808a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80108090:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80108093:	31 c0                	xor    %eax,%eax
}
80108095:	5b                   	pop    %ebx
80108096:	5e                   	pop    %esi
80108097:	5f                   	pop    %edi
80108098:	5d                   	pop    %ebp
80108099:	c3                   	ret    
      panic("remap");
8010809a:	c7 04 24 38 92 10 80 	movl   $0x80109238,(%esp)
801080a1:	e8 ca 82 ff ff       	call   80100370 <panic>
801080a6:	8d 76 00             	lea    0x0(%esi),%esi
801080a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801080b0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801080b0:	55                   	push   %ebp
801080b1:	89 e5                	mov    %esp,%ebp
801080b3:	57                   	push   %edi
801080b4:	89 c7                	mov    %eax,%edi
801080b6:	56                   	push   %esi
801080b7:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801080b8:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801080be:	83 ec 2c             	sub    $0x2c,%esp
  a = PGROUNDUP(newsz);
801080c1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801080c7:	39 d3                	cmp    %edx,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801080c9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801080cc:	73 62                	jae    80108130 <deallocuvm.part.0+0x80>
801080ce:	89 d6                	mov    %edx,%esi
801080d0:	eb 39                	jmp    8010810b <deallocuvm.part.0+0x5b>
801080d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
801080d8:	8b 10                	mov    (%eax),%edx
801080da:	f6 c2 01             	test   $0x1,%dl
801080dd:	74 22                	je     80108101 <deallocuvm.part.0+0x51>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801080df:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801080e5:	74 54                	je     8010813b <deallocuvm.part.0+0x8b>
        panic("kfree");
      char *v = P2V(pa);
801080e7:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
801080ed:	89 14 24             	mov    %edx,(%esp)
801080f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801080f3:	e8 e8 a2 ff ff       	call   801023e0 <kfree>
      *pte = 0;
801080f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801080fb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80108101:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80108107:	39 f3                	cmp    %esi,%ebx
80108109:	73 25                	jae    80108130 <deallocuvm.part.0+0x80>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010810b:	31 c9                	xor    %ecx,%ecx
8010810d:	89 da                	mov    %ebx,%edx
8010810f:	89 f8                	mov    %edi,%eax
80108111:	e8 7a fe ff ff       	call   80107f90 <walkpgdir>
    if(!pte)
80108116:	85 c0                	test   %eax,%eax
80108118:	75 be                	jne    801080d8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010811a:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80108120:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80108126:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010812c:	39 f3                	cmp    %esi,%ebx
8010812e:	72 db                	jb     8010810b <deallocuvm.part.0+0x5b>
    }
  }
  return newsz;
}
80108130:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108133:	83 c4 2c             	add    $0x2c,%esp
80108136:	5b                   	pop    %ebx
80108137:	5e                   	pop    %esi
80108138:	5f                   	pop    %edi
80108139:	5d                   	pop    %ebp
8010813a:	c3                   	ret    
        panic("kfree");
8010813b:	c7 04 24 46 8b 10 80 	movl   $0x80108b46,(%esp)
80108142:	e8 29 82 ff ff       	call   80100370 <panic>
80108147:	89 f6                	mov    %esi,%esi
80108149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108150 <seginit>:
{
80108150:	55                   	push   %ebp
80108151:	89 e5                	mov    %esp,%ebp
80108153:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80108156:	e8 25 b8 ff ff       	call   80103980 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010815b:	b9 00 9a cf 00       	mov    $0xcf9a00,%ecx
  pd[0] = size-1;
80108160:	66 c7 45 f2 2f 00    	movw   $0x2f,-0xe(%ebp)
80108166:	8d 14 80             	lea    (%eax,%eax,4),%edx
80108169:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010816c:	ba ff ff 00 00       	mov    $0xffff,%edx
80108171:	c1 e0 04             	shl    $0x4,%eax
80108174:	89 90 78 48 11 80    	mov    %edx,-0x7feeb788(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010817a:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010817f:	89 88 7c 48 11 80    	mov    %ecx,-0x7feeb784(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80108185:	b9 00 92 cf 00       	mov    $0xcf9200,%ecx
8010818a:	89 90 80 48 11 80    	mov    %edx,-0x7feeb780(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80108190:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80108195:	89 88 84 48 11 80    	mov    %ecx,-0x7feeb77c(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010819b:	b9 00 fa cf 00       	mov    $0xcffa00,%ecx
801081a0:	89 90 88 48 11 80    	mov    %edx,-0x7feeb778(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801081a6:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801081ab:	89 88 8c 48 11 80    	mov    %ecx,-0x7feeb774(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801081b1:	b9 00 f2 cf 00       	mov    $0xcff200,%ecx
801081b6:	89 90 90 48 11 80    	mov    %edx,-0x7feeb770(%eax)
801081bc:	89 88 94 48 11 80    	mov    %ecx,-0x7feeb76c(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
801081c2:	05 70 48 11 80       	add    $0x80114870,%eax
  pd[1] = (uint)p;
801081c7:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
801081ca:	c1 e8 10             	shr    $0x10,%eax
  pd[1] = (uint)p;
801081cd:	66 89 55 f4          	mov    %dx,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801081d1:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801081d5:	8d 45 f2             	lea    -0xe(%ebp),%eax
801081d8:	0f 01 10             	lgdtl  (%eax)
}
801081db:	c9                   	leave  
801081dc:	c3                   	ret    
801081dd:	8d 76 00             	lea    0x0(%esi),%esi

801081e0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801081e0:	a1 24 80 11 80       	mov    0x80118024,%eax
{
801081e5:	55                   	push   %ebp
801081e6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801081e8:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801081ed:	0f 22 d8             	mov    %eax,%cr3
}
801081f0:	5d                   	pop    %ebp
801081f1:	c3                   	ret    
801081f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801081f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108200 <switchuvm>:
{
80108200:	55                   	push   %ebp
80108201:	89 e5                	mov    %esp,%ebp
80108203:	57                   	push   %edi
80108204:	56                   	push   %esi
80108205:	53                   	push   %ebx
80108206:	83 ec 2c             	sub    $0x2c,%esp
80108209:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
8010820c:	85 db                	test   %ebx,%ebx
8010820e:	0f 84 c5 00 00 00    	je     801082d9 <switchuvm+0xd9>
  if(p->kstack == 0)
80108214:	8b 7b 08             	mov    0x8(%ebx),%edi
80108217:	85 ff                	test   %edi,%edi
80108219:	0f 84 d2 00 00 00    	je     801082f1 <switchuvm+0xf1>
  if(p->pgdir == 0)
8010821f:	8b 73 04             	mov    0x4(%ebx),%esi
80108222:	85 f6                	test   %esi,%esi
80108224:	0f 84 bb 00 00 00    	je     801082e5 <switchuvm+0xe5>
  pushcli();
8010822a:	e8 d1 d8 ff ff       	call   80105b00 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010822f:	e8 cc b6 ff ff       	call   80103900 <mycpu>
80108234:	89 c6                	mov    %eax,%esi
80108236:	e8 c5 b6 ff ff       	call   80103900 <mycpu>
8010823b:	89 c7                	mov    %eax,%edi
8010823d:	e8 be b6 ff ff       	call   80103900 <mycpu>
80108242:	83 c7 08             	add    $0x8,%edi
80108245:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108248:	e8 b3 b6 ff ff       	call   80103900 <mycpu>
8010824d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80108250:	ba 67 00 00 00       	mov    $0x67,%edx
80108255:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
8010825c:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80108263:	83 c1 08             	add    $0x8,%ecx
80108266:	c1 e9 10             	shr    $0x10,%ecx
80108269:	83 c0 08             	add    $0x8,%eax
8010826c:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80108272:	c1 e8 18             	shr    $0x18,%eax
80108275:	b9 99 40 00 00       	mov    $0x4099,%ecx
8010827a:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
80108281:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->gdt[SEG_TSS].s = 0;
80108287:	e8 74 b6 ff ff       	call   80103900 <mycpu>
8010828c:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80108293:	e8 68 b6 ff ff       	call   80103900 <mycpu>
80108298:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
8010829e:	8b 73 08             	mov    0x8(%ebx),%esi
801082a1:	e8 5a b6 ff ff       	call   80103900 <mycpu>
801082a6:	81 c6 00 10 00 00    	add    $0x1000,%esi
801082ac:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801082af:	e8 4c b6 ff ff       	call   80103900 <mycpu>
801082b4:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801082ba:	b8 28 00 00 00       	mov    $0x28,%eax
801082bf:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801082c2:	8b 43 04             	mov    0x4(%ebx),%eax
801082c5:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801082ca:	0f 22 d8             	mov    %eax,%cr3
}
801082cd:	83 c4 2c             	add    $0x2c,%esp
801082d0:	5b                   	pop    %ebx
801082d1:	5e                   	pop    %esi
801082d2:	5f                   	pop    %edi
801082d3:	5d                   	pop    %ebp
  popcli();
801082d4:	e9 67 d8 ff ff       	jmp    80105b40 <popcli>
    panic("switchuvm: no process");
801082d9:	c7 04 24 3e 92 10 80 	movl   $0x8010923e,(%esp)
801082e0:	e8 8b 80 ff ff       	call   80100370 <panic>
    panic("switchuvm: no pgdir");
801082e5:	c7 04 24 69 92 10 80 	movl   $0x80109269,(%esp)
801082ec:	e8 7f 80 ff ff       	call   80100370 <panic>
    panic("switchuvm: no kstack");
801082f1:	c7 04 24 54 92 10 80 	movl   $0x80109254,(%esp)
801082f8:	e8 73 80 ff ff       	call   80100370 <panic>
801082fd:	8d 76 00             	lea    0x0(%esi),%esi

80108300 <inituvm>:
{
80108300:	55                   	push   %ebp
80108301:	89 e5                	mov    %esp,%ebp
80108303:	83 ec 38             	sub    $0x38,%esp
80108306:	89 75 f8             	mov    %esi,-0x8(%ebp)
80108309:	8b 75 10             	mov    0x10(%ebp),%esi
8010830c:	8b 45 08             	mov    0x8(%ebp),%eax
8010830f:	89 7d fc             	mov    %edi,-0x4(%ebp)
80108312:	8b 7d 0c             	mov    0xc(%ebp),%edi
80108315:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  if(sz >= PGSIZE)
80108318:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
8010831e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80108321:	77 59                	ja     8010837c <inituvm+0x7c>
  mem = kalloc();
80108323:	e8 88 a2 ff ff       	call   801025b0 <kalloc>
  memset(mem, 0, PGSIZE);
80108328:	31 d2                	xor    %edx,%edx
8010832a:	89 54 24 04          	mov    %edx,0x4(%esp)
  mem = kalloc();
8010832e:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80108330:	b8 00 10 00 00       	mov    $0x1000,%eax
80108335:	89 1c 24             	mov    %ebx,(%esp)
80108338:	89 44 24 08          	mov    %eax,0x8(%esp)
8010833c:	e8 8f d9 ff ff       	call   80105cd0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80108341:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80108347:	b9 06 00 00 00       	mov    $0x6,%ecx
8010834c:	89 04 24             	mov    %eax,(%esp)
8010834f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108352:	31 d2                	xor    %edx,%edx
80108354:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80108358:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010835d:	e8 be fc ff ff       	call   80108020 <mappages>
  memmove(mem, init, sz);
80108362:	89 75 10             	mov    %esi,0x10(%ebp)
}
80108365:	8b 75 f8             	mov    -0x8(%ebp),%esi
  memmove(mem, init, sz);
80108368:	89 7d 0c             	mov    %edi,0xc(%ebp)
}
8010836b:	8b 7d fc             	mov    -0x4(%ebp),%edi
  memmove(mem, init, sz);
8010836e:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80108371:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80108374:	89 ec                	mov    %ebp,%esp
80108376:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80108377:	e9 14 da ff ff       	jmp    80105d90 <memmove>
    panic("inituvm: more than a page");
8010837c:	c7 04 24 7d 92 10 80 	movl   $0x8010927d,(%esp)
80108383:	e8 e8 7f ff ff       	call   80100370 <panic>
80108388:	90                   	nop
80108389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108390 <loaduvm>:
{
80108390:	55                   	push   %ebp
80108391:	89 e5                	mov    %esp,%ebp
80108393:	57                   	push   %edi
80108394:	56                   	push   %esi
80108395:	53                   	push   %ebx
80108396:	83 ec 1c             	sub    $0x1c,%esp
  if((uint) addr % PGSIZE != 0)
80108399:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
801083a0:	0f 85 98 00 00 00    	jne    8010843e <loaduvm+0xae>
  for(i = 0; i < sz; i += PGSIZE){
801083a6:	8b 75 18             	mov    0x18(%ebp),%esi
801083a9:	31 db                	xor    %ebx,%ebx
801083ab:	85 f6                	test   %esi,%esi
801083ad:	75 1a                	jne    801083c9 <loaduvm+0x39>
801083af:	eb 77                	jmp    80108428 <loaduvm+0x98>
801083b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801083b8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801083be:	81 ee 00 10 00 00    	sub    $0x1000,%esi
801083c4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
801083c7:	76 5f                	jbe    80108428 <loaduvm+0x98>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801083c9:	8b 55 0c             	mov    0xc(%ebp),%edx
801083cc:	31 c9                	xor    %ecx,%ecx
801083ce:	8b 45 08             	mov    0x8(%ebp),%eax
801083d1:	01 da                	add    %ebx,%edx
801083d3:	e8 b8 fb ff ff       	call   80107f90 <walkpgdir>
801083d8:	85 c0                	test   %eax,%eax
801083da:	74 56                	je     80108432 <loaduvm+0xa2>
    pa = PTE_ADDR(*pte);
801083dc:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
801083de:	bf 00 10 00 00       	mov    $0x1000,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801083e3:	8b 4d 14             	mov    0x14(%ebp),%ecx
    pa = PTE_ADDR(*pte);
801083e6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801083eb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801083f1:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801083f4:	05 00 00 00 80       	add    $0x80000000,%eax
801083f9:	89 44 24 04          	mov    %eax,0x4(%esp)
801083fd:	8b 45 10             	mov    0x10(%ebp),%eax
80108400:	01 d9                	add    %ebx,%ecx
80108402:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80108406:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010840a:	89 04 24             	mov    %eax,(%esp)
8010840d:	e8 be 95 ff ff       	call   801019d0 <readi>
80108412:	39 f8                	cmp    %edi,%eax
80108414:	74 a2                	je     801083b8 <loaduvm+0x28>
}
80108416:	83 c4 1c             	add    $0x1c,%esp
      return -1;
80108419:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010841e:	5b                   	pop    %ebx
8010841f:	5e                   	pop    %esi
80108420:	5f                   	pop    %edi
80108421:	5d                   	pop    %ebp
80108422:	c3                   	ret    
80108423:	90                   	nop
80108424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108428:	83 c4 1c             	add    $0x1c,%esp
  return 0;
8010842b:	31 c0                	xor    %eax,%eax
}
8010842d:	5b                   	pop    %ebx
8010842e:	5e                   	pop    %esi
8010842f:	5f                   	pop    %edi
80108430:	5d                   	pop    %ebp
80108431:	c3                   	ret    
      panic("loaduvm: address should exist");
80108432:	c7 04 24 97 92 10 80 	movl   $0x80109297,(%esp)
80108439:	e8 32 7f ff ff       	call   80100370 <panic>
    panic("loaduvm: addr must be page aligned");
8010843e:	c7 04 24 38 93 10 80 	movl   $0x80109338,(%esp)
80108445:	e8 26 7f ff ff       	call   80100370 <panic>
8010844a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108450 <allocuvm>:
{
80108450:	55                   	push   %ebp
80108451:	89 e5                	mov    %esp,%ebp
80108453:	57                   	push   %edi
80108454:	56                   	push   %esi
80108455:	53                   	push   %ebx
80108456:	83 ec 2c             	sub    $0x2c,%esp
  if(newsz >= KERNBASE)
80108459:	8b 7d 10             	mov    0x10(%ebp),%edi
8010845c:	85 ff                	test   %edi,%edi
8010845e:	0f 88 91 00 00 00    	js     801084f5 <allocuvm+0xa5>
  if(newsz < oldsz)
80108464:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80108467:	0f 82 9b 00 00 00    	jb     80108508 <allocuvm+0xb8>
  a = PGROUNDUP(oldsz);
8010846d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108470:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80108476:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010847c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010847f:	0f 86 86 00 00 00    	jbe    8010850b <allocuvm+0xbb>
80108485:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80108488:	8b 7d 08             	mov    0x8(%ebp),%edi
8010848b:	eb 49                	jmp    801084d6 <allocuvm+0x86>
8010848d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80108490:	31 d2                	xor    %edx,%edx
80108492:	b8 00 10 00 00       	mov    $0x1000,%eax
80108497:	89 54 24 04          	mov    %edx,0x4(%esp)
8010849b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010849f:	89 34 24             	mov    %esi,(%esp)
801084a2:	e8 29 d8 ff ff       	call   80105cd0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801084a7:	b9 06 00 00 00       	mov    $0x6,%ecx
801084ac:	89 da                	mov    %ebx,%edx
801084ae:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801084b4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801084b8:	b9 00 10 00 00       	mov    $0x1000,%ecx
801084bd:	89 04 24             	mov    %eax,(%esp)
801084c0:	89 f8                	mov    %edi,%eax
801084c2:	e8 59 fb ff ff       	call   80108020 <mappages>
801084c7:	85 c0                	test   %eax,%eax
801084c9:	78 4d                	js     80108518 <allocuvm+0xc8>
  for(; a < newsz; a += PGSIZE){
801084cb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801084d1:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801084d4:	76 7a                	jbe    80108550 <allocuvm+0x100>
    mem = kalloc();
801084d6:	e8 d5 a0 ff ff       	call   801025b0 <kalloc>
    if(mem == 0){
801084db:	85 c0                	test   %eax,%eax
    mem = kalloc();
801084dd:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801084df:	75 af                	jne    80108490 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
801084e1:	c7 04 24 b5 92 10 80 	movl   $0x801092b5,(%esp)
801084e8:	e8 63 81 ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
801084ed:	8b 45 0c             	mov    0xc(%ebp),%eax
801084f0:	39 45 10             	cmp    %eax,0x10(%ebp)
801084f3:	77 6b                	ja     80108560 <allocuvm+0x110>
}
801084f5:	83 c4 2c             	add    $0x2c,%esp
    return 0;
801084f8:	31 ff                	xor    %edi,%edi
}
801084fa:	5b                   	pop    %ebx
801084fb:	89 f8                	mov    %edi,%eax
801084fd:	5e                   	pop    %esi
801084fe:	5f                   	pop    %edi
801084ff:	5d                   	pop    %ebp
80108500:	c3                   	ret    
80108501:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80108508:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
8010850b:	83 c4 2c             	add    $0x2c,%esp
8010850e:	89 f8                	mov    %edi,%eax
80108510:	5b                   	pop    %ebx
80108511:	5e                   	pop    %esi
80108512:	5f                   	pop    %edi
80108513:	5d                   	pop    %ebp
80108514:	c3                   	ret    
80108515:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80108518:	c7 04 24 cd 92 10 80 	movl   $0x801092cd,(%esp)
8010851f:	e8 2c 81 ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
80108524:	8b 45 0c             	mov    0xc(%ebp),%eax
80108527:	39 45 10             	cmp    %eax,0x10(%ebp)
8010852a:	76 0d                	jbe    80108539 <allocuvm+0xe9>
8010852c:	89 c1                	mov    %eax,%ecx
8010852e:	8b 55 10             	mov    0x10(%ebp),%edx
80108531:	8b 45 08             	mov    0x8(%ebp),%eax
80108534:	e8 77 fb ff ff       	call   801080b0 <deallocuvm.part.0>
      kfree(mem);
80108539:	89 34 24             	mov    %esi,(%esp)
      return 0;
8010853c:	31 ff                	xor    %edi,%edi
      kfree(mem);
8010853e:	e8 9d 9e ff ff       	call   801023e0 <kfree>
}
80108543:	83 c4 2c             	add    $0x2c,%esp
80108546:	89 f8                	mov    %edi,%eax
80108548:	5b                   	pop    %ebx
80108549:	5e                   	pop    %esi
8010854a:	5f                   	pop    %edi
8010854b:	5d                   	pop    %ebp
8010854c:	c3                   	ret    
8010854d:	8d 76 00             	lea    0x0(%esi),%esi
80108550:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80108553:	83 c4 2c             	add    $0x2c,%esp
80108556:	5b                   	pop    %ebx
80108557:	5e                   	pop    %esi
80108558:	89 f8                	mov    %edi,%eax
8010855a:	5f                   	pop    %edi
8010855b:	5d                   	pop    %ebp
8010855c:	c3                   	ret    
8010855d:	8d 76 00             	lea    0x0(%esi),%esi
80108560:	89 c1                	mov    %eax,%ecx
80108562:	8b 55 10             	mov    0x10(%ebp),%edx
      return 0;
80108565:	31 ff                	xor    %edi,%edi
80108567:	8b 45 08             	mov    0x8(%ebp),%eax
8010856a:	e8 41 fb ff ff       	call   801080b0 <deallocuvm.part.0>
8010856f:	eb 9a                	jmp    8010850b <allocuvm+0xbb>
80108571:	eb 0d                	jmp    80108580 <deallocuvm>
80108573:	90                   	nop
80108574:	90                   	nop
80108575:	90                   	nop
80108576:	90                   	nop
80108577:	90                   	nop
80108578:	90                   	nop
80108579:	90                   	nop
8010857a:	90                   	nop
8010857b:	90                   	nop
8010857c:	90                   	nop
8010857d:	90                   	nop
8010857e:	90                   	nop
8010857f:	90                   	nop

80108580 <deallocuvm>:
{
80108580:	55                   	push   %ebp
80108581:	89 e5                	mov    %esp,%ebp
80108583:	8b 55 0c             	mov    0xc(%ebp),%edx
80108586:	8b 4d 10             	mov    0x10(%ebp),%ecx
80108589:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010858c:	39 d1                	cmp    %edx,%ecx
8010858e:	73 10                	jae    801085a0 <deallocuvm+0x20>
}
80108590:	5d                   	pop    %ebp
80108591:	e9 1a fb ff ff       	jmp    801080b0 <deallocuvm.part.0>
80108596:	8d 76 00             	lea    0x0(%esi),%esi
80108599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801085a0:	89 d0                	mov    %edx,%eax
801085a2:	5d                   	pop    %ebp
801085a3:	c3                   	ret    
801085a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801085aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801085b0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801085b0:	55                   	push   %ebp
801085b1:	89 e5                	mov    %esp,%ebp
801085b3:	57                   	push   %edi
801085b4:	56                   	push   %esi
801085b5:	53                   	push   %ebx
801085b6:	83 ec 1c             	sub    $0x1c,%esp
801085b9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801085bc:	85 f6                	test   %esi,%esi
801085be:	74 55                	je     80108615 <freevm+0x65>
801085c0:	31 c9                	xor    %ecx,%ecx
801085c2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801085c7:	89 f0                	mov    %esi,%eax
801085c9:	89 f3                	mov    %esi,%ebx
801085cb:	e8 e0 fa ff ff       	call   801080b0 <deallocuvm.part.0>
801085d0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801085d6:	eb 0f                	jmp    801085e7 <freevm+0x37>
801085d8:	90                   	nop
801085d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801085e0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801085e3:	39 fb                	cmp    %edi,%ebx
801085e5:	74 1f                	je     80108606 <freevm+0x56>
    if(pgdir[i] & PTE_P){
801085e7:	8b 03                	mov    (%ebx),%eax
801085e9:	a8 01                	test   $0x1,%al
801085eb:	74 f3                	je     801085e0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801085ed:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801085f2:	83 c3 04             	add    $0x4,%ebx
801085f5:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801085fa:	89 04 24             	mov    %eax,(%esp)
801085fd:	e8 de 9d ff ff       	call   801023e0 <kfree>
  for(i = 0; i < NPDENTRIES; i++){
80108602:	39 fb                	cmp    %edi,%ebx
80108604:	75 e1                	jne    801085e7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80108606:	89 75 08             	mov    %esi,0x8(%ebp)
}
80108609:	83 c4 1c             	add    $0x1c,%esp
8010860c:	5b                   	pop    %ebx
8010860d:	5e                   	pop    %esi
8010860e:	5f                   	pop    %edi
8010860f:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80108610:	e9 cb 9d ff ff       	jmp    801023e0 <kfree>
    panic("freevm: no pgdir");
80108615:	c7 04 24 e9 92 10 80 	movl   $0x801092e9,(%esp)
8010861c:	e8 4f 7d ff ff       	call   80100370 <panic>
80108621:	eb 0d                	jmp    80108630 <setupkvm>
80108623:	90                   	nop
80108624:	90                   	nop
80108625:	90                   	nop
80108626:	90                   	nop
80108627:	90                   	nop
80108628:	90                   	nop
80108629:	90                   	nop
8010862a:	90                   	nop
8010862b:	90                   	nop
8010862c:	90                   	nop
8010862d:	90                   	nop
8010862e:	90                   	nop
8010862f:	90                   	nop

80108630 <setupkvm>:
{
80108630:	55                   	push   %ebp
80108631:	89 e5                	mov    %esp,%ebp
80108633:	56                   	push   %esi
80108634:	53                   	push   %ebx
80108635:	83 ec 10             	sub    $0x10,%esp
  if((pgdir = (pde_t*)kalloc()) == 0)
80108638:	e8 73 9f ff ff       	call   801025b0 <kalloc>
8010863d:	85 c0                	test   %eax,%eax
8010863f:	89 c6                	mov    %eax,%esi
80108641:	74 46                	je     80108689 <setupkvm+0x59>
  memset(pgdir, 0, PGSIZE);
80108643:	b8 00 10 00 00       	mov    $0x1000,%eax
80108648:	31 d2                	xor    %edx,%edx
8010864a:	89 44 24 08          	mov    %eax,0x8(%esp)
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010864e:	bb 20 c4 10 80       	mov    $0x8010c420,%ebx
  memset(pgdir, 0, PGSIZE);
80108653:	89 54 24 04          	mov    %edx,0x4(%esp)
80108657:	89 34 24             	mov    %esi,(%esp)
8010865a:	e8 71 d6 ff ff       	call   80105cd0 <memset>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010865f:	8b 53 0c             	mov    0xc(%ebx),%edx
                (uint)k->phys_start, k->perm) < 0) {
80108662:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80108665:	8b 4b 08             	mov    0x8(%ebx),%ecx
80108668:	89 54 24 04          	mov    %edx,0x4(%esp)
8010866c:	8b 13                	mov    (%ebx),%edx
8010866e:	89 04 24             	mov    %eax,(%esp)
80108671:	29 c1                	sub    %eax,%ecx
80108673:	89 f0                	mov    %esi,%eax
80108675:	e8 a6 f9 ff ff       	call   80108020 <mappages>
8010867a:	85 c0                	test   %eax,%eax
8010867c:	78 1a                	js     80108698 <setupkvm+0x68>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010867e:	83 c3 10             	add    $0x10,%ebx
80108681:	81 fb 60 c4 10 80    	cmp    $0x8010c460,%ebx
80108687:	75 d6                	jne    8010865f <setupkvm+0x2f>
}
80108689:	83 c4 10             	add    $0x10,%esp
8010868c:	89 f0                	mov    %esi,%eax
8010868e:	5b                   	pop    %ebx
8010868f:	5e                   	pop    %esi
80108690:	5d                   	pop    %ebp
80108691:	c3                   	ret    
80108692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      freevm(pgdir);
80108698:	89 34 24             	mov    %esi,(%esp)
      return 0;
8010869b:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
8010869d:	e8 0e ff ff ff       	call   801085b0 <freevm>
}
801086a2:	83 c4 10             	add    $0x10,%esp
801086a5:	89 f0                	mov    %esi,%eax
801086a7:	5b                   	pop    %ebx
801086a8:	5e                   	pop    %esi
801086a9:	5d                   	pop    %ebp
801086aa:	c3                   	ret    
801086ab:	90                   	nop
801086ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801086b0 <kvmalloc>:
{
801086b0:	55                   	push   %ebp
801086b1:	89 e5                	mov    %esp,%ebp
801086b3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801086b6:	e8 75 ff ff ff       	call   80108630 <setupkvm>
801086bb:	a3 24 80 11 80       	mov    %eax,0x80118024
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801086c0:	05 00 00 00 80       	add    $0x80000000,%eax
801086c5:	0f 22 d8             	mov    %eax,%cr3
}
801086c8:	c9                   	leave  
801086c9:	c3                   	ret    
801086ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801086d0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801086d0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801086d1:	31 c9                	xor    %ecx,%ecx
{
801086d3:	89 e5                	mov    %esp,%ebp
801086d5:	83 ec 18             	sub    $0x18,%esp
  pte = walkpgdir(pgdir, uva, 0);
801086d8:	8b 55 0c             	mov    0xc(%ebp),%edx
801086db:	8b 45 08             	mov    0x8(%ebp),%eax
801086de:	e8 ad f8 ff ff       	call   80107f90 <walkpgdir>
  if(pte == 0)
801086e3:	85 c0                	test   %eax,%eax
801086e5:	74 05                	je     801086ec <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
801086e7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801086ea:	c9                   	leave  
801086eb:	c3                   	ret    
    panic("clearpteu");
801086ec:	c7 04 24 fa 92 10 80 	movl   $0x801092fa,(%esp)
801086f3:	e8 78 7c ff ff       	call   80100370 <panic>
801086f8:	90                   	nop
801086f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108700 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108700:	55                   	push   %ebp
80108701:	89 e5                	mov    %esp,%ebp
80108703:	57                   	push   %edi
80108704:	56                   	push   %esi
80108705:	53                   	push   %ebx
80108706:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80108709:	e8 22 ff ff ff       	call   80108630 <setupkvm>
8010870e:	85 c0                	test   %eax,%eax
80108710:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108713:	0f 84 a3 00 00 00    	je     801087bc <copyuvm+0xbc>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108719:	8b 55 0c             	mov    0xc(%ebp),%edx
8010871c:	85 d2                	test   %edx,%edx
8010871e:	0f 84 98 00 00 00    	je     801087bc <copyuvm+0xbc>
80108724:	31 ff                	xor    %edi,%edi
80108726:	eb 50                	jmp    80108778 <copyuvm+0x78>
80108728:	90                   	nop
80108729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80108730:	b8 00 10 00 00       	mov    $0x1000,%eax
80108735:	89 44 24 08          	mov    %eax,0x8(%esp)
80108739:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010873c:	89 34 24             	mov    %esi,(%esp)
8010873f:	05 00 00 00 80       	add    $0x80000000,%eax
80108744:	89 44 24 04          	mov    %eax,0x4(%esp)
80108748:	e8 43 d6 ff ff       	call   80105d90 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
8010874d:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80108753:	b9 00 10 00 00       	mov    $0x1000,%ecx
80108758:	89 04 24             	mov    %eax,(%esp)
8010875b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010875e:	89 fa                	mov    %edi,%edx
80108760:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80108764:	e8 b7 f8 ff ff       	call   80108020 <mappages>
80108769:	85 c0                	test   %eax,%eax
8010876b:	78 63                	js     801087d0 <copyuvm+0xd0>
  for(i = 0; i < sz; i += PGSIZE){
8010876d:	81 c7 00 10 00 00    	add    $0x1000,%edi
80108773:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80108776:	76 44                	jbe    801087bc <copyuvm+0xbc>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80108778:	8b 45 08             	mov    0x8(%ebp),%eax
8010877b:	31 c9                	xor    %ecx,%ecx
8010877d:	89 fa                	mov    %edi,%edx
8010877f:	e8 0c f8 ff ff       	call   80107f90 <walkpgdir>
80108784:	85 c0                	test   %eax,%eax
80108786:	74 5e                	je     801087e6 <copyuvm+0xe6>
    if(!(*pte & PTE_P))
80108788:	8b 18                	mov    (%eax),%ebx
8010878a:	f6 c3 01             	test   $0x1,%bl
8010878d:	74 4b                	je     801087da <copyuvm+0xda>
    pa = PTE_ADDR(*pte);
8010878f:	89 d8                	mov    %ebx,%eax
    flags = PTE_FLAGS(*pte);
80108791:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
80108797:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010879c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
8010879f:	e8 0c 9e ff ff       	call   801025b0 <kalloc>
801087a4:	85 c0                	test   %eax,%eax
801087a6:	89 c6                	mov    %eax,%esi
801087a8:	75 86                	jne    80108730 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
801087aa:	8b 45 e0             	mov    -0x20(%ebp),%eax
801087ad:	89 04 24             	mov    %eax,(%esp)
801087b0:	e8 fb fd ff ff       	call   801085b0 <freevm>
  return 0;
801087b5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
801087bc:	8b 45 e0             	mov    -0x20(%ebp),%eax
801087bf:	83 c4 2c             	add    $0x2c,%esp
801087c2:	5b                   	pop    %ebx
801087c3:	5e                   	pop    %esi
801087c4:	5f                   	pop    %edi
801087c5:	5d                   	pop    %ebp
801087c6:	c3                   	ret    
801087c7:	89 f6                	mov    %esi,%esi
801087c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      kfree(mem);
801087d0:	89 34 24             	mov    %esi,(%esp)
801087d3:	e8 08 9c ff ff       	call   801023e0 <kfree>
      goto bad;
801087d8:	eb d0                	jmp    801087aa <copyuvm+0xaa>
      panic("copyuvm: page not present");
801087da:	c7 04 24 1e 93 10 80 	movl   $0x8010931e,(%esp)
801087e1:	e8 8a 7b ff ff       	call   80100370 <panic>
      panic("copyuvm: pte should exist");
801087e6:	c7 04 24 04 93 10 80 	movl   $0x80109304,(%esp)
801087ed:	e8 7e 7b ff ff       	call   80100370 <panic>
801087f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801087f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108800 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108800:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108801:	31 c9                	xor    %ecx,%ecx
{
80108803:	89 e5                	mov    %esp,%ebp
80108805:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80108808:	8b 55 0c             	mov    0xc(%ebp),%edx
8010880b:	8b 45 08             	mov    0x8(%ebp),%eax
8010880e:	e8 7d f7 ff ff       	call   80107f90 <walkpgdir>
  if((*pte & PTE_P) == 0)
80108813:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80108815:	89 c2                	mov    %eax,%edx
80108817:	83 e2 05             	and    $0x5,%edx
8010881a:	83 fa 05             	cmp    $0x5,%edx
8010881d:	75 11                	jne    80108830 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
8010881f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108824:	05 00 00 00 80       	add    $0x80000000,%eax
}
80108829:	c9                   	leave  
8010882a:	c3                   	ret    
8010882b:	90                   	nop
8010882c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80108830:	31 c0                	xor    %eax,%eax
}
80108832:	c9                   	leave  
80108833:	c3                   	ret    
80108834:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010883a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80108840 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108840:	55                   	push   %ebp
80108841:	89 e5                	mov    %esp,%ebp
80108843:	57                   	push   %edi
80108844:	56                   	push   %esi
80108845:	53                   	push   %ebx
80108846:	83 ec 2c             	sub    $0x2c,%esp
80108849:	8b 75 14             	mov    0x14(%ebp),%esi
8010884c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
8010884f:	85 f6                	test   %esi,%esi
80108851:	74 75                	je     801088c8 <copyout+0x88>
80108853:	89 da                	mov    %ebx,%edx
80108855:	eb 3f                	jmp    80108896 <copyout+0x56>
80108857:	89 f6                	mov    %esi,%esi
80108859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80108860:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80108863:	89 df                	mov    %ebx,%edi
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80108865:	8b 4d 10             	mov    0x10(%ebp),%ecx
    n = PGSIZE - (va - va0);
80108868:	29 d7                	sub    %edx,%edi
8010886a:	81 c7 00 10 00 00    	add    $0x1000,%edi
80108870:	39 f7                	cmp    %esi,%edi
80108872:	0f 47 fe             	cmova  %esi,%edi
    memmove(pa0 + (va - va0), buf, n);
80108875:	29 da                	sub    %ebx,%edx
80108877:	01 c2                	add    %eax,%edx
80108879:	89 14 24             	mov    %edx,(%esp)
8010887c:	89 7c 24 08          	mov    %edi,0x8(%esp)
80108880:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80108884:	e8 07 d5 ff ff       	call   80105d90 <memmove>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
80108889:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    buf += n;
8010888f:	01 7d 10             	add    %edi,0x10(%ebp)
  while(len > 0){
80108892:	29 fe                	sub    %edi,%esi
80108894:	74 32                	je     801088c8 <copyout+0x88>
    pa0 = uva2ka(pgdir, (char*)va0);
80108896:	8b 45 08             	mov    0x8(%ebp),%eax
    va0 = (uint)PGROUNDDOWN(va);
80108899:	89 d3                	mov    %edx,%ebx
8010889b:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    pa0 = uva2ka(pgdir, (char*)va0);
801088a1:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    va0 = (uint)PGROUNDDOWN(va);
801088a5:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
801088a8:	89 04 24             	mov    %eax,(%esp)
801088ab:	e8 50 ff ff ff       	call   80108800 <uva2ka>
    if(pa0 == 0)
801088b0:	85 c0                	test   %eax,%eax
801088b2:	75 ac                	jne    80108860 <copyout+0x20>
  }
  return 0;
}
801088b4:	83 c4 2c             	add    $0x2c,%esp
      return -1;
801088b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801088bc:	5b                   	pop    %ebx
801088bd:	5e                   	pop    %esi
801088be:	5f                   	pop    %edi
801088bf:	5d                   	pop    %ebp
801088c0:	c3                   	ret    
801088c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801088c8:	83 c4 2c             	add    $0x2c,%esp
  return 0;
801088cb:	31 c0                	xor    %eax,%eax
}
801088cd:	5b                   	pop    %ebx
801088ce:	5e                   	pop    %esi
801088cf:	5f                   	pop    %edi
801088d0:	5d                   	pop    %ebp
801088d1:	c3                   	ret    
