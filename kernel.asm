
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
80100041:	ba 00 88 10 80       	mov    $0x80108800,%edx
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
8010005c:	e8 3f 59 00 00       	call   801059a0 <initlock>
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
80100082:	b8 07 88 10 80       	mov    $0x80108807,%eax
    b->next = bcache.head.next;
80100087:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008a:	c7 43 50 3c 1d 11 80 	movl   $0x80111d3c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100091:	89 44 24 04          	mov    %eax,0x4(%esp)
80100095:	8d 43 0c             	lea    0xc(%ebx),%eax
80100098:	89 04 24             	mov    %eax,(%esp)
8010009b:	e8 d0 57 00 00       	call   80105870 <initsleeplock>
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
801000e6:	e8 05 5a 00 00       	call   80105af0 <acquire>
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
80100161:	e8 2a 5a 00 00       	call   80105b90 <release>
      acquiresleep(&b->lock);
80100166:	8d 43 0c             	lea    0xc(%ebx),%eax
80100169:	89 04 24             	mov    %eax,(%esp)
8010016c:	e8 3f 57 00 00       	call   801058b0 <acquiresleep>
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
80100188:	c7 04 24 0e 88 10 80 	movl   $0x8010880e,(%esp)
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
801001b0:	e8 9b 57 00 00       	call   80105950 <holdingsleep>
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
801001c9:	c7 04 24 1f 88 10 80 	movl   $0x8010881f,(%esp)
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
801001f1:	e8 5a 57 00 00       	call   80105950 <holdingsleep>
801001f6:	85 c0                	test   %eax,%eax
801001f8:	74 5a                	je     80100254 <brelse+0x74>
    panic("brelse");

  releasesleep(&b->lock);
801001fa:	89 34 24             	mov    %esi,(%esp)
801001fd:	e8 0e 57 00 00       	call   80105910 <releasesleep>

  acquire(&bcache.lock);
80100202:	c7 04 24 40 d6 10 80 	movl   $0x8010d640,(%esp)
80100209:	e8 e2 58 00 00       	call   80105af0 <acquire>
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
8010024f:	e9 3c 59 00 00       	jmp    80105b90 <release>
    panic("brelse");
80100254:	c7 04 24 26 88 10 80 	movl   $0x80108826,(%esp)
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
8010027e:	e8 6d 58 00 00       	call   80105af0 <acquire>
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
801002b8:	e8 f3 41 00 00       	call   801044b0 <sleep>
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
801002de:	e8 ad 58 00 00       	call   80105b90 <release>
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
8010033a:	e8 51 58 00 00       	call   80105b90 <release>
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
8010038c:	c7 04 24 2d 88 10 80 	movl   $0x8010882d,(%esp)
80100393:	89 44 24 04          	mov    %eax,0x4(%esp)
80100397:	e8 b4 02 00 00       	call   80100650 <cprintf>
  cprintf(s);
8010039c:	8b 45 08             	mov    0x8(%ebp),%eax
8010039f:	89 04 24             	mov    %eax,(%esp)
801003a2:	e8 a9 02 00 00       	call   80100650 <cprintf>
  cprintf("\n");
801003a7:	c7 04 24 ed 8e 10 80 	movl   $0x80108eed,(%esp)
801003ae:	e8 9d 02 00 00       	call   80100650 <cprintf>
  getcallerpcs(&s, pcs);
801003b3:	8d 45 08             	lea    0x8(%ebp),%eax
801003b6:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801003ba:	89 04 24             	mov    %eax,(%esp)
801003bd:	e8 fe 55 00 00       	call   801059c0 <getcallerpcs>
801003c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    cprintf(" %p", pcs[i]);
801003d0:	8b 03                	mov    (%ebx),%eax
801003d2:	83 c3 04             	add    $0x4,%ebx
801003d5:	c7 04 24 41 88 10 80 	movl   $0x80108841,(%esp)
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
80100429:	e8 b2 6f 00 00       	call   801073e0 <uartputc>
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
801004cc:	e8 0f 6f 00 00       	call   801073e0 <uartputc>
801004d1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004d8:	e8 03 6f 00 00       	call   801073e0 <uartputc>
801004dd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004e4:	e8 f7 6e 00 00       	call   801073e0 <uartputc>
801004e9:	e9 40 ff ff ff       	jmp    8010042e <consputc+0x2e>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004ee:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
801004f5:	00 
801004f6:	c7 44 24 04 a0 80 0b 	movl   $0x800b80a0,0x4(%esp)
801004fd:	80 
801004fe:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
80100505:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80100508:	e8 93 57 00 00       	call   80105ca0 <memmove>
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
80100536:	e8 a5 56 00 00       	call   80105be0 <memset>
8010053b:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010053e:	e9 4c ff ff ff       	jmp    8010048f <consputc+0x8f>
    panic("pos under/overflow");
80100543:	c7 04 24 45 88 10 80 	movl   $0x80108845,(%esp)
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
801005a1:	0f b6 92 70 88 10 80 	movzbl -0x7fef7790(%edx),%edx
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
8010060e:	e8 dd 54 00 00       	call   80105af0 <acquire>
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
80100634:	e8 57 55 00 00       	call   80105b90 <release>
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
8010070e:	e8 7d 54 00 00       	call   80105b90 <release>
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
80100774:	bf 58 88 10 80       	mov    $0x80108858,%edi
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
801007b7:	e8 34 53 00 00       	call   80105af0 <acquire>
801007bc:	e9 a8 fe ff ff       	jmp    80100669 <cprintf+0x19>
    panic("null fmt");
801007c1:	c7 04 24 5f 88 10 80 	movl   $0x8010885f,(%esp)
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
801007e4:	e8 07 53 00 00       	call   80105af0 <acquire>
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
80100847:	e8 44 53 00 00       	call   80105b90 <release>
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
801008d9:	e8 d2 3d 00 00       	call   801046b0 <wakeup>
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
8010094e:	e9 6d 40 00 00       	jmp    801049c0 <procdump>
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
80100981:	b8 68 88 10 80       	mov    $0x80108868,%eax
{
80100986:	89 e5                	mov    %esp,%ebp
80100988:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
8010098b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010098f:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
80100996:	e8 05 50 00 00       	call   801059a0 <initlock>

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
80100a5c:	e8 df 7a 00 00       	call   80108540 <setupkvm>
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
80100ac8:	e8 93 78 00 00       	call   80108360 <allocuvm>
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
80100b05:	e8 96 77 00 00       	call   801082a0 <loaduvm>
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
80100b58:	e8 63 79 00 00       	call   801084c0 <freevm>
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
80100b92:	e8 c9 77 00 00       	call   80108360 <allocuvm>
80100b97:	85 c0                	test   %eax,%eax
80100b99:	89 c6                	mov    %eax,%esi
80100b9b:	75 33                	jne    80100bd0 <exec+0x200>
    freevm(pgdir);
80100b9d:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ba3:	89 04 24             	mov    %eax,(%esp)
80100ba6:	e8 15 79 00 00       	call   801084c0 <freevm>
  return -1;
80100bab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bb0:	e9 8c fe ff ff       	jmp    80100a41 <exec+0x71>
    end_op();
80100bb5:	e8 46 21 00 00       	call   80102d00 <end_op>
    cprintf("exec: fail\n");
80100bba:	c7 04 24 81 88 10 80 	movl   $0x80108881,(%esp)
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
80100be7:	e8 f4 79 00 00       	call   801085e0 <clearpteu>
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
80100c18:	e8 e3 51 00 00       	call   80105e00 <strlen>
80100c1d:	f7 d0                	not    %eax
80100c1f:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c21:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c24:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c27:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c2a:	89 04 24             	mov    %eax,(%esp)
80100c2d:	e8 ce 51 00 00       	call   80105e00 <strlen>
80100c32:	40                   	inc    %eax
80100c33:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c37:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c3a:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c3d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100c41:	89 34 24             	mov    %esi,(%esp)
80100c44:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c48:	e8 03 7b 00 00       	call   80108750 <copyout>
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
80100cb8:	e8 93 7a 00 00       	call   80108750 <copyout>
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
80100d01:	e8 ba 50 00 00       	call   80105dc0 <safestrcpy>
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
80100d2b:	e8 e0 73 00 00       	call   80108110 <switchuvm>
  freevm(oldpgdir);
80100d30:	89 3c 24             	mov    %edi,(%esp)
80100d33:	e8 88 77 00 00       	call   801084c0 <freevm>
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
80100d51:	b8 8d 88 10 80       	mov    $0x8010888d,%eax
{
80100d56:	89 e5                	mov    %esp,%ebp
80100d58:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100d5b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100d5f:	c7 04 24 40 20 11 80 	movl   $0x80112040,(%esp)
80100d66:	e8 35 4c 00 00       	call   801059a0 <initlock>
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
80100d83:	e8 68 4d 00 00       	call   80105af0 <acquire>
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
80100db0:	e8 db 4d 00 00       	call   80105b90 <release>
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
80100dc9:	e8 c2 4d 00 00       	call   80105b90 <release>
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
80100df1:	e8 fa 4c 00 00       	call   80105af0 <acquire>
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
80100e08:	e8 83 4d 00 00       	call   80105b90 <release>
  return f;
}
80100e0d:	83 c4 14             	add    $0x14,%esp
80100e10:	89 d8                	mov    %ebx,%eax
80100e12:	5b                   	pop    %ebx
80100e13:	5d                   	pop    %ebp
80100e14:	c3                   	ret    
    panic("filedup");
80100e15:	c7 04 24 94 88 10 80 	movl   $0x80108894,(%esp)
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
80100e49:	e8 a2 4c 00 00       	call   80105af0 <acquire>
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
80100e74:	e9 17 4d 00 00       	jmp    80105b90 <release>
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
80100e9f:	e8 ec 4c 00 00       	call   80105b90 <release>
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
80100ef9:	c7 04 24 9c 88 10 80 	movl   $0x8010889c,(%esp)
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
80100ff7:	c7 04 24 a6 88 10 80 	movl   $0x801088a6,(%esp)
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
80101112:	c7 04 24 af 88 10 80 	movl   $0x801088af,(%esp)
80101119:	e8 52 f2 ff ff       	call   80100370 <panic>
  panic("filewrite");
8010111e:	c7 04 24 b5 88 10 80 	movl   $0x801088b5,(%esp)
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
801011c8:	c7 04 24 bf 88 10 80 	movl   $0x801088bf,(%esp)
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
80101218:	e8 c3 49 00 00       	call   80105be0 <memset>
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
8010125c:	e8 8f 48 00 00       	call   80105af0 <acquire>
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
801012be:	e8 cd 48 00 00       	call   80105b90 <release>

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
801012e2:	e8 a9 48 00 00       	call   80105b90 <release>
}
801012e7:	83 c4 2c             	add    $0x2c,%esp
801012ea:	89 f0                	mov    %esi,%eax
801012ec:	5b                   	pop    %ebx
801012ed:	5e                   	pop    %esi
801012ee:	5f                   	pop    %edi
801012ef:	5d                   	pop    %ebp
801012f0:	c3                   	ret    
    panic("iget: no inodes");
801012f1:	c7 04 24 d5 88 10 80 	movl   $0x801088d5,(%esp)
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
801013c1:	c7 04 24 e5 88 10 80 	movl   $0x801088e5,(%esp)
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
80101408:	e8 93 48 00 00       	call   80105ca0 <memmove>
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
80101497:	c7 04 24 f8 88 10 80 	movl   $0x801088f8,(%esp)
8010149e:	e8 cd ee ff ff       	call   80100370 <panic>
801014a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801014a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801014b0 <iinit>:
{
801014b0:	55                   	push   %ebp
  initlock(&icache.lock, "icache");
801014b1:	b9 0b 89 10 80       	mov    $0x8010890b,%ecx
{
801014b6:	89 e5                	mov    %esp,%ebp
801014b8:	53                   	push   %ebx
801014b9:	bb a0 2a 11 80       	mov    $0x80112aa0,%ebx
801014be:	83 ec 24             	sub    $0x24,%esp
  initlock(&icache.lock, "icache");
801014c1:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801014c5:	c7 04 24 60 2a 11 80 	movl   $0x80112a60,(%esp)
801014cc:	e8 cf 44 00 00       	call   801059a0 <initlock>
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
801014e0:	ba 12 89 10 80       	mov    $0x80108912,%edx
801014e5:	89 1c 24             	mov    %ebx,(%esp)
801014e8:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014ee:	89 54 24 04          	mov    %edx,0x4(%esp)
801014f2:	e8 79 43 00 00       	call   80105870 <initsleeplock>
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
80101518:	c7 04 24 78 89 10 80 	movl   $0x80108978,(%esp)
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
801015f3:	e8 e8 45 00 00       	call   80105be0 <memset>
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
80101621:	c7 04 24 18 89 10 80 	movl   $0x80108918,(%esp)
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
801016a2:	e8 f9 45 00 00       	call   80105ca0 <memmove>
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
801016d1:	e8 1a 44 00 00       	call   80105af0 <acquire>
  ip->ref++;
801016d6:	ff 43 08             	incl   0x8(%ebx)
  release(&icache.lock);
801016d9:	c7 04 24 60 2a 11 80 	movl   $0x80112a60,(%esp)
801016e0:	e8 ab 44 00 00       	call   80105b90 <release>
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
80101714:	e8 97 41 00 00       	call   801058b0 <acquiresleep>
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
80101796:	e8 05 45 00 00       	call   80105ca0 <memmove>
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
801017b5:	c7 04 24 30 89 10 80 	movl   $0x80108930,(%esp)
801017bc:	e8 af eb ff ff       	call   80100370 <panic>
    panic("ilock");
801017c1:	c7 04 24 2a 89 10 80 	movl   $0x8010892a,(%esp)
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
801017e9:	e8 62 41 00 00       	call   80105950 <holdingsleep>
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
80101805:	e9 06 41 00 00       	jmp    80105910 <releasesleep>
    panic("iunlock");
8010180a:	c7 04 24 3f 89 10 80 	movl   $0x8010893f,(%esp)
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
80101838:	e8 73 40 00 00       	call   801058b0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
8010183d:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101840:	85 d2                	test   %edx,%edx
80101842:	74 07                	je     8010184b <iput+0x2b>
80101844:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101849:	74 35                	je     80101880 <iput+0x60>
  releasesleep(&ip->lock);
8010184b:	89 3c 24             	mov    %edi,(%esp)
8010184e:	e8 bd 40 00 00       	call   80105910 <releasesleep>
  acquire(&icache.lock);
80101853:	c7 04 24 60 2a 11 80 	movl   $0x80112a60,(%esp)
8010185a:	e8 91 42 00 00       	call   80105af0 <acquire>
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
80101875:	e9 16 43 00 00       	jmp    80105b90 <release>
8010187a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101880:	c7 04 24 60 2a 11 80 	movl   $0x80112a60,(%esp)
80101887:	e8 64 42 00 00       	call   80105af0 <acquire>
    int r = ip->ref;
8010188c:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
8010188f:	c7 04 24 60 2a 11 80 	movl   $0x80112a60,(%esp)
80101896:	e8 f5 42 00 00       	call   80105b90 <release>
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
80101a83:	e8 18 42 00 00       	call   80105ca0 <memmove>
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
80101baf:	e8 ec 40 00 00       	call   80105ca0 <memmove>
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
80101c5c:	e8 9f 40 00 00       	call   80105d00 <strncmp>
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
80101cdb:	e8 20 40 00 00       	call   80105d00 <strncmp>
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
80101d1f:	c7 04 24 59 89 10 80 	movl   $0x80108959,(%esp)
80101d26:	e8 45 e6 ff ff       	call   80100370 <panic>
    panic("dirlookup not DIR");
80101d2b:	c7 04 24 47 89 10 80 	movl   $0x80108947,(%esp)
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
80101d68:	e8 83 3d 00 00       	call   80105af0 <acquire>
  ip->ref++;
80101d6d:	ff 46 08             	incl   0x8(%esi)
  release(&icache.lock);
80101d70:	c7 04 24 60 2a 11 80 	movl   $0x80112a60,(%esp)
80101d77:	e8 14 3e 00 00       	call   80105b90 <release>
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
80101ddc:	e8 bf 3e 00 00       	call   80105ca0 <memmove>
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
80101e65:	e8 36 3e 00 00       	call   80105ca0 <memmove>
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
80101f73:	e8 e8 3d 00 00       	call   80105d60 <strncpy>
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
80101fb6:	c7 04 24 68 89 10 80 	movl   $0x80108968,(%esp)
80101fbd:	e8 ae e3 ff ff       	call   80100370 <panic>
    panic("dirlink");
80101fc2:	c7 04 24 ee 8f 10 80 	movl   $0x80108fee,(%esp)
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
801020bc:	c7 04 24 d4 89 10 80 	movl   $0x801089d4,(%esp)
801020c3:	e8 a8 e2 ff ff       	call   80100370 <panic>
    panic("idestart");
801020c8:	c7 04 24 cb 89 10 80 	movl   $0x801089cb,(%esp)
801020cf:	e8 9c e2 ff ff       	call   80100370 <panic>
801020d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801020da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801020e0 <ideinit>:
{
801020e0:	55                   	push   %ebp
  initlock(&idelock, "ide");
801020e1:	ba e6 89 10 80       	mov    $0x801089e6,%edx
{
801020e6:	89 e5                	mov    %esp,%ebp
801020e8:	83 ec 18             	sub    $0x18,%esp
  initlock(&idelock, "ide");
801020eb:	89 54 24 04          	mov    %edx,0x4(%esp)
801020ef:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
801020f6:	e8 a5 38 00 00       	call   801059a0 <initlock>
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
80102176:	e8 75 39 00 00       	call   80105af0 <acquire>

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
801021ce:	e8 dd 24 00 00       	call   801046b0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801021d3:	a1 64 c5 10 80       	mov    0x8010c564,%eax
801021d8:	85 c0                	test   %eax,%eax
801021da:	74 05                	je     801021e1 <ideintr+0x81>
    idestart(idequeue);
801021dc:	e8 2f fe ff ff       	call   80102010 <idestart>
    release(&idelock);
801021e1:	c7 04 24 80 c5 10 80 	movl   $0x8010c580,(%esp)
801021e8:	e8 a3 39 00 00       	call   80105b90 <release>

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
80102210:	e8 3b 37 00 00       	call   80105950 <holdingsleep>
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
80102247:	e8 a4 38 00 00       	call   80105af0 <acquire>

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
8010228c:	e8 1f 22 00 00       	call   801044b0 <sleep>
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
801022a7:	e9 e4 38 00 00       	jmp    80105b90 <release>
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
801022c7:	c7 04 24 00 8a 10 80 	movl   $0x80108a00,(%esp)
801022ce:	e8 9d e0 ff ff       	call   80100370 <panic>
    panic("iderw: buf not locked");
801022d3:	c7 04 24 ea 89 10 80 	movl   $0x801089ea,(%esp)
801022da:	e8 91 e0 ff ff       	call   80100370 <panic>
    panic("iderw: ide disk 1 not present");
801022df:	c7 04 24 15 8a 10 80 	movl   $0x80108a15,(%esp)
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
80102338:	c7 04 24 34 8a 10 80 	movl   $0x80108a34,(%esp)
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
801023f6:	81 fb 28 7c 11 80    	cmp    $0x80117c28,%ebx
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
80102420:	e8 bb 37 00 00       	call   80105be0 <memset>

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
8010245c:	e9 2f 37 00 00       	jmp    80105b90 <release>
80102461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&kmem.lock);
80102468:	c7 04 24 c0 46 11 80 	movl   $0x801146c0,(%esp)
8010246f:	e8 7c 36 00 00       	call   80105af0 <acquire>
80102474:	eb b8                	jmp    8010242e <kfree+0x4e>
    panic("kfree");
80102476:	c7 04 24 66 8a 10 80 	movl   $0x80108a66,(%esp)
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
801024e1:	b8 6c 8a 10 80       	mov    $0x80108a6c,%eax
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
801024fb:	e8 a0 34 00 00       	call   801059a0 <initlock>
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
801025e5:	e8 06 35 00 00       	call   80105af0 <acquire>
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
8010260f:	e8 7c 35 00 00       	call   80105b90 <release>
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
80102664:	0f b6 8a a0 8b 10 80 	movzbl -0x7fef7460(%edx),%ecx
  shift ^= togglecode[data];
8010266b:	0f b6 82 a0 8a 10 80 	movzbl -0x7fef7560(%edx),%eax
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
8010267e:	8b 04 85 80 8a 10 80 	mov    -0x7fef7580(,%eax,4),%eax
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
801026b9:	0f b6 82 a0 8b 10 80 	movzbl -0x7fef7460(%edx),%eax
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
80102a20:	e8 1b 32 00 00       	call   80105c40 <memcmp>
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
80102b3c:	e8 5f 31 00 00       	call   80105ca0 <memmove>
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
80102bf1:	ba a0 8c 10 80       	mov    $0x80108ca0,%edx
{
80102bf6:	89 e5                	mov    %esp,%ebp
80102bf8:	53                   	push   %ebx
80102bf9:	83 ec 34             	sub    $0x34,%esp
80102bfc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102bff:	89 54 24 04          	mov    %edx,0x4(%esp)
80102c03:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
80102c0a:	e8 91 2d 00 00       	call   801059a0 <initlock>
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
80102c9d:	e8 4e 2e 00 00       	call   80105af0 <acquire>
80102ca2:	eb 19                	jmp    80102cbd <begin_op+0x2d>
80102ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102ca8:	b8 00 47 11 80       	mov    $0x80114700,%eax
80102cad:	89 44 24 04          	mov    %eax,0x4(%esp)
80102cb1:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
80102cb8:	e8 f3 17 00 00       	call   801044b0 <sleep>
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
80102cea:	e8 a1 2e 00 00       	call   80105b90 <release>
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
80102d10:	e8 db 2d 00 00       	call   80105af0 <acquire>
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
80102d4a:	e8 41 2e 00 00       	call   80105b90 <release>
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
80102da9:	e8 f2 2e 00 00       	call   80105ca0 <memmove>
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
80102dec:	e8 ff 2c 00 00       	call   80105af0 <acquire>
    log.committing = 0;
80102df1:	31 c0                	xor    %eax,%eax
80102df3:	a3 40 47 11 80       	mov    %eax,0x80114740
    wakeup(&log);
80102df8:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
80102dff:	e8 ac 18 00 00       	call   801046b0 <wakeup>
    release(&log.lock);
80102e04:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
80102e0b:	e8 80 2d 00 00       	call   80105b90 <release>
}
80102e10:	83 c4 1c             	add    $0x1c,%esp
80102e13:	5b                   	pop    %ebx
80102e14:	5e                   	pop    %esi
80102e15:	5f                   	pop    %edi
80102e16:	5d                   	pop    %ebp
80102e17:	c3                   	ret    
    panic("log.committing");
80102e18:	c7 04 24 a4 8c 10 80 	movl   $0x80108ca4,(%esp)
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
80102e6b:	e8 80 2c 00 00       	call   80105af0 <acquire>
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
80102eba:	e9 d1 2c 00 00       	jmp    80105b90 <release>
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
80102ede:	c7 04 24 b3 8c 10 80 	movl   $0x80108cb3,(%esp)
80102ee5:	e8 86 d4 ff ff       	call   80100370 <panic>
    panic("log_write outside of trans");
80102eea:	c7 04 24 c9 8c 10 80 	movl   $0x80108cc9,(%esp)
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
80102f07:	e8 e4 51 00 00       	call   801080f0 <switchkvm>
  seginit();
80102f0c:	e8 4f 51 00 00       	call   80108060 <seginit>
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
80102f22:	c7 04 24 e4 8c 10 80 	movl   $0x80108ce4,(%esp)
80102f29:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f2d:	e8 1e d7 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80102f32:	e8 69 40 00 00       	call   80106fa0 <idtinit>
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
80102f6a:	c7 04 24 34 8d 10 80 	movl   $0x80108d34,(%esp)
80102f71:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f75:	e8 d6 d6 ff ff       	call   80100650 <cprintf>
  scheduler();     // start running processes
80102f7a:	e8 e1 11 00 00       	call   80104160 <scheduler>
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
80102f93:	c7 04 24 28 7c 11 80 	movl   $0x80117c28,(%esp)
80102f9a:	e8 41 f5 ff ff       	call   801024e0 <kinit1>
  kvmalloc();      // kernel page table
80102f9f:	e8 1c 56 00 00       	call   801085c0 <kvmalloc>
  mpinit();        // detect other processors
80102fa4:	e8 17 02 00 00       	call   801031c0 <mpinit>
  lapicinit();     // interrupt controller
80102fa9:	e8 82 f7 ff ff       	call   80102730 <lapicinit>
80102fae:	66 90                	xchg   %ax,%ax
  seginit();       // segment descriptors
80102fb0:	e8 ab 50 00 00       	call   80108060 <seginit>
  picinit();       // disable pic
80102fb5:	e8 e6 03 00 00       	call   801033a0 <picinit>
  ioapicinit();    // another interrupt controller
80102fba:	e8 31 f3 ff ff       	call   801022f0 <ioapicinit>
80102fbf:	90                   	nop
  consoleinit();   // console hardware
80102fc0:	e8 bb d9 ff ff       	call   80100980 <consoleinit>
  uartinit();      // serial port
80102fc5:	e8 66 43 00 00       	call   80107330 <uartinit>
  pinit();         // process table
80102fca:	e8 11 09 00 00       	call   801038e0 <pinit>
80102fcf:	90                   	nop
  tvinit();        // trap vectors
80102fd0:	e8 4b 3f 00 00       	call   80106f20 <tvinit>
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
80102ffe:	e8 9d 2c 00 00       	call   80105ca0 <memmove>

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
801030bc:	e8 4f 1d 00 00       	call   80104e10 <initSchedDS>
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
80103118:	c7 04 24 2a 8d 10 80 	movl   $0x80108d2a,(%esp)
8010311f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103123:	e8 28 d5 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80103128:	e8 73 3e 00 00       	call   80106fa0 <idtinit>
  scheduler();     // start running processes
8010312d:	e8 2e 10 00 00       	call   80104160 <scheduler>
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
80103166:	ba 48 8d 10 80       	mov    $0x80108d48,%edx
8010316b:	b8 04 00 00 00       	mov    $0x4,%eax
80103170:	89 54 24 04          	mov    %edx,0x4(%esp)
80103174:	89 44 24 08          	mov    %eax,0x8(%esp)
80103178:	89 34 24             	mov    %esi,(%esp)
8010317b:	e8 c0 2a 00 00       	call   80105c40 <memcmp>
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
80103224:	ba 65 8d 10 80       	mov    $0x80108d65,%edx
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103229:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
8010322f:	89 44 24 08          	mov    %eax,0x8(%esp)
80103233:	89 54 24 04          	mov    %edx,0x4(%esp)
80103237:	89 34 24             	mov    %esi,(%esp)
8010323a:	e8 01 2a 00 00       	call   80105c40 <memcmp>
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
801032cf:	ff 24 85 8c 8d 10 80 	jmp    *-0x7fef7274(,%eax,4)
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
80103380:	c7 04 24 4d 8d 10 80 	movl   $0x80108d4d,(%esp)
80103387:	e8 e4 cf ff ff       	call   80100370 <panic>
    panic("Didn't find a suitable machine");
8010338c:	c7 04 24 6c 8d 10 80 	movl   $0x80108d6c,(%esp)
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
80103460:	ba a0 8d 10 80       	mov    $0x80108da0,%edx
  p->nread = 0;
80103465:	89 88 34 02 00 00    	mov    %ecx,0x234(%eax)
  initlock(&p->lock, "pipe");
8010346b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010346f:	89 04 24             	mov    %eax,(%esp)
80103472:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103475:	e8 26 25 00 00       	call   801059a0 <initlock>
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
801034d5:	e8 16 26 00 00       	call   80105af0 <acquire>
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
801034ef:	e8 bc 11 00 00       	call   801046b0 <wakeup>
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
80103514:	e9 77 26 00 00       	jmp    80105b90 <release>
80103519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->readopen = 0;
80103520:	31 c9                	xor    %ecx,%ecx
    wakeup(&p->nwrite);
80103522:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103528:	89 8b 3c 02 00 00    	mov    %ecx,0x23c(%ebx)
    wakeup(&p->nwrite);
8010352e:	89 04 24             	mov    %eax,(%esp)
80103531:	e8 7a 11 00 00       	call   801046b0 <wakeup>
80103536:	eb bc                	jmp    801034f4 <pipeclose+0x34>
80103538:	90                   	nop
80103539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103540:	89 1c 24             	mov    %ebx,(%esp)
80103543:	e8 48 26 00 00       	call   80105b90 <release>
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
8010356f:	e8 7c 25 00 00       	call   80105af0 <acquire>
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
801035c3:	e8 e8 10 00 00       	call   801046b0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035c8:	89 7c 24 04          	mov    %edi,0x4(%esp)
801035cc:	89 1c 24             	mov    %ebx,(%esp)
801035cf:	e8 dc 0e 00 00       	call   801044b0 <sleep>
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
80103602:	e8 89 25 00 00       	call   80105b90 <release>
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
8010364f:	e8 5c 10 00 00       	call   801046b0 <wakeup>
  release(&p->lock);
80103654:	89 3c 24             	mov    %edi,(%esp)
80103657:	e8 34 25 00 00       	call   80105b90 <release>
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
80103682:	e8 69 24 00 00       	call   80105af0 <acquire>
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
801036b7:	e8 f4 0d 00 00       	call   801044b0 <sleep>
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
801036ec:	e8 9f 24 00 00       	call   80105b90 <release>
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
80103744:	e8 67 0f 00 00       	call   801046b0 <wakeup>
  release(&p->lock);
80103749:	89 34 24             	mov    %esi,(%esp)
8010374c:	e8 3f 24 00 00       	call   80105b90 <release>
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
80103783:	e8 68 23 00 00       	call   80105af0 <acquire>
80103788:	eb 18                	jmp    801037a2 <allocproc+0x32>
8010378a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103790:	81 c3 98 00 00 00    	add    $0x98,%ebx
80103796:	81 fb d4 73 11 80    	cmp    $0x801173d4,%ebx
8010379c:	0f 83 a6 00 00 00    	jae    80103848 <allocproc+0xd8>
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
801037c8:	e8 c3 23 00 00       	call   80105b90 <release>
  
  acquire(&tickslock);
801037cd:	c7 04 24 e0 73 11 80 	movl   $0x801173e0,(%esp)
801037d4:	e8 17 23 00 00       	call   80105af0 <acquire>
  p->performance->ctime = ticks;
801037d9:	8b 83 94 00 00 00    	mov    0x94(%ebx),%eax
801037df:	8b 15 20 7c 11 80    	mov    0x80117c20,%edx
801037e5:	89 10                	mov    %edx,(%eax)
  release(&tickslock);
801037e7:	c7 04 24 e0 73 11 80 	movl   $0x801173e0,(%esp)
801037ee:	e8 9d 23 00 00       	call   80105b90 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801037f3:	e8 b8 ed ff ff       	call   801025b0 <kalloc>
801037f8:	85 c0                	test   %eax,%eax
801037fa:	89 43 08             	mov    %eax,0x8(%ebx)
801037fd:	74 5f                	je     8010385e <allocproc+0xee>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801037ff:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103805:	b9 14 00 00 00       	mov    $0x14,%ecx
  sp -= sizeof *p->tf;
8010380a:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
8010380d:	ba 0f 6f 10 80       	mov    $0x80106f0f,%edx
  sp -= sizeof *p->context;
80103812:	05 9c 0f 00 00       	add    $0xf9c,%eax
  *(uint*)sp = (uint)trapret;
80103817:	89 50 14             	mov    %edx,0x14(%eax)
  memset(p->context, 0, sizeof *p->context);
8010381a:	31 d2                	xor    %edx,%edx
  p->context = (struct context*)sp;
8010381c:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
8010381f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80103823:	89 54 24 04          	mov    %edx,0x4(%esp)
80103827:	89 04 24             	mov    %eax,(%esp)
8010382a:	e8 b1 23 00 00       	call   80105be0 <memset>
  p->context->eip = (uint)forkret;
8010382f:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103832:	c7 40 10 70 38 10 80 	movl   $0x80103870,0x10(%eax)

  return p;
}
80103839:	83 c4 14             	add    $0x14,%esp
8010383c:	89 d8                	mov    %ebx,%eax
8010383e:	5b                   	pop    %ebx
8010383f:	5d                   	pop    %ebp
80103840:	c3                   	ret    
80103841:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80103848:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
  return 0;
8010384f:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103851:	e8 3a 23 00 00       	call   80105b90 <release>
}
80103856:	83 c4 14             	add    $0x14,%esp
80103859:	89 d8                	mov    %ebx,%eax
8010385b:	5b                   	pop    %ebx
8010385c:	5d                   	pop    %ebp
8010385d:	c3                   	ret    
    p->state = UNUSED;
8010385e:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103865:	31 db                	xor    %ebx,%ebx
80103867:	eb d0                	jmp    80103839 <allocproc+0xc9>
80103869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

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
8010387d:	e8 0e 23 00 00       	call   80105b90 <release>

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
801038e1:	b8 a5 8d 10 80       	mov    $0x80108da5,%eax
{
801038e6:	89 e5                	mov    %esp,%ebp
801038e8:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
801038eb:	89 44 24 04          	mov    %eax,0x4(%esp)
801038ef:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
801038f6:	e8 a5 20 00 00       	call   801059a0 <initlock>
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
8010395e:	c7 04 24 ac 8d 10 80 	movl   $0x80108dac,(%esp)
80103965:	e8 06 ca ff ff       	call   80100370 <panic>
    panic("mycpu called with interrupts enabled\n");
8010396a:	c7 04 24 9c 8e 10 80 	movl   $0x80108e9c,(%esp)
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
801039a7:	e8 64 20 00 00       	call   80105a10 <pushcli>
  c = mycpu();
801039ac:	e8 4f ff ff ff       	call   80103900 <mycpu>
  p = c->proc;
801039b1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039b7:	e8 94 20 00 00       	call   80105a50 <popcli>
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
801039db:	e8 30 20 00 00       	call   80105a10 <pushcli>
  c = mycpu();
801039e0:	e8 1b ff ff ff       	call   80103900 <mycpu>
  p = c->proc;
801039e5:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039eb:	e8 60 20 00 00       	call   80105a50 <popcli>
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
801039fe:	e8 0d 47 00 00       	call   80108110 <switchuvm>
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
80103a20:	e8 3b 49 00 00       	call   80108360 <allocuvm>
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
80103a40:	e8 4b 4a 00 00       	call   80108490 <deallocuvm>
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
      if (rpholder.getMinAccumulator(&acc2))
80103a6d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80103a70:	89 04 24             	mov    %eax,(%esp)
  if (pq.getMinAccumulator(&acc1)){
80103a73:	74 3b                	je     80103ab0 <setAccumulator+0x60>
      if (rpholder.getMinAccumulator(&acc2))
80103a75:	ff 15 d8 c5 10 80    	call   *0x8010c5d8
80103a7b:	85 c0                	test   %eax,%eax
80103a7d:	74 79                	je     80103af8 <setAccumulator+0xa8>
            if (acc1<acc2)
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
80103b43:	e8 f8 49 00 00       	call   80108540 <setupkvm>
80103b48:	85 c0                	test   %eax,%eax
80103b4a:	89 43 04             	mov    %eax,0x4(%ebx)
80103b4d:	0f 84 15 01 00 00    	je     80103c68 <userinit+0x138>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103b53:	b9 60 c4 10 80       	mov    $0x8010c460,%ecx
80103b58:	ba 2c 00 00 00       	mov    $0x2c,%edx
80103b5d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80103b61:	89 54 24 08          	mov    %edx,0x8(%esp)
80103b65:	89 04 24             	mov    %eax,(%esp)
80103b68:	e8 a3 46 00 00       	call   80108210 <inituvm>
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
80103b88:	e8 53 20 00 00       	call   80105be0 <memset>
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
80103bda:	b8 d5 8d 10 80       	mov    $0x80108dd5,%eax
80103bdf:	89 44 24 04          	mov    %eax,0x4(%esp)
80103be3:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103be6:	89 04 24             	mov    %eax,(%esp)
80103be9:	e8 d2 21 00 00       	call   80105dc0 <safestrcpy>
  p->cwd = namei("/");
80103bee:	c7 04 24 de 8d 10 80 	movl   $0x80108dde,(%esp)
80103bf5:	e8 d6 e3 ff ff       	call   80101fd0 <namei>
80103bfa:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103bfd:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80103c04:	e8 e7 1e 00 00       	call   80105af0 <acquire>
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
  p->priority = 5;
80103c39:	b8 05 00 00 00       	mov    $0x5,%eax
80103c3e:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
  setAccumulator(p);
80103c44:	89 1c 24             	mov    %ebx,(%esp)
80103c47:	e8 04 fe ff ff       	call   80103a50 <setAccumulator>
  release(&ptable.lock);
80103c4c:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80103c53:	e8 38 1f 00 00       	call   80105b90 <release>
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
80103c68:	c7 04 24 bc 8d 10 80 	movl   $0x80108dbc,(%esp)
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
80103c89:	e8 82 1d 00 00       	call   80105a10 <pushcli>
  c = mycpu();
80103c8e:	e8 6d fc ff ff       	call   80103900 <mycpu>
  p = c->proc;
80103c93:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103c99:	e8 b2 1d 00 00       	call   80105a50 <popcli>
  if((np = allocproc()) == 0){
80103c9e:	e8 cd fa ff ff       	call   80103770 <allocproc>
80103ca3:	85 c0                	test   %eax,%eax
80103ca5:	0f 84 1d 01 00 00    	je     80103dc8 <fork+0x148>
80103cab:	89 c7                	mov    %eax,%edi
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103cad:	8b 06                	mov    (%esi),%eax
80103caf:	89 44 24 04          	mov    %eax,0x4(%esp)
80103cb3:	8b 46 04             	mov    0x4(%esi),%eax
80103cb6:	89 04 24             	mov    %eax,(%esp)
80103cb9:	e8 52 49 00 00       	call   80108610 <copyuvm>
80103cbe:	85 c0                	test   %eax,%eax
80103cc0:	89 47 04             	mov    %eax,0x4(%edi)
80103cc3:	0f 84 09 01 00 00    	je     80103dd2 <fork+0x152>
  np->sz = curproc->sz;
80103cc9:	8b 06                	mov    (%esi),%eax
  np->parent = curproc;
80103ccb:	89 77 14             	mov    %esi,0x14(%edi)
  *np->tf = *curproc->tf;
80103cce:	8b 57 18             	mov    0x18(%edi),%edx
  np->sz = curproc->sz;
80103cd1:	89 07                	mov    %eax,(%edi)
  *np->tf = *curproc->tf;
80103cd3:	31 c0                	xor    %eax,%eax
80103cd5:	8b 4e 18             	mov    0x18(%esi),%ecx
80103cd8:	8b 1c 01             	mov    (%ecx,%eax,1),%ebx
80103cdb:	89 1c 02             	mov    %ebx,(%edx,%eax,1)
80103cde:	83 c0 04             	add    $0x4,%eax
80103ce1:	83 f8 4c             	cmp    $0x4c,%eax
80103ce4:	72 f2                	jb     80103cd8 <fork+0x58>
  np->tf->eax = 0;
80103ce6:	8b 47 18             	mov    0x18(%edi),%eax
  for(i = 0; i < NOFILE; i++)
80103ce9:	31 db                	xor    %ebx,%ebx
  np->tf->eax = 0;
80103ceb:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103cf2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(curproc->ofile[i])
80103d00:	8b 44 9e 28          	mov    0x28(%esi,%ebx,4),%eax
80103d04:	85 c0                	test   %eax,%eax
80103d06:	74 0c                	je     80103d14 <fork+0x94>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103d08:	89 04 24             	mov    %eax,(%esp)
80103d0b:	e8 d0 d0 ff ff       	call   80100de0 <filedup>
80103d10:	89 44 9f 28          	mov    %eax,0x28(%edi,%ebx,4)
  for(i = 0; i < NOFILE; i++)
80103d14:	43                   	inc    %ebx
80103d15:	83 fb 10             	cmp    $0x10,%ebx
80103d18:	75 e6                	jne    80103d00 <fork+0x80>
  np->cwd = idup(curproc->cwd);
80103d1a:	8b 46 68             	mov    0x68(%esi),%eax
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d1d:	83 c6 6c             	add    $0x6c,%esi
  np->cwd = idup(curproc->cwd);
80103d20:	89 04 24             	mov    %eax,(%esp)
80103d23:	e8 98 d9 ff ff       	call   801016c0 <idup>
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d28:	ba 10 00 00 00       	mov    $0x10,%edx
  np->cwd = idup(curproc->cwd);
80103d2d:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d30:	8d 47 6c             	lea    0x6c(%edi),%eax
80103d33:	89 54 24 08          	mov    %edx,0x8(%esp)
80103d37:	89 74 24 04          	mov    %esi,0x4(%esp)
80103d3b:	89 04 24             	mov    %eax,(%esp)
80103d3e:	e8 7d 20 00 00       	call   80105dc0 <safestrcpy>
  pid = np->pid;
80103d43:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&tickslock);
80103d46:	c7 04 24 e0 73 11 80 	movl   $0x801173e0,(%esp)
80103d4d:	e8 9e 1d 00 00       	call   80105af0 <acquire>
  np->performance->ctime = ticks;
80103d52:	8b 87 94 00 00 00    	mov    0x94(%edi),%eax
80103d58:	8b 15 20 7c 11 80    	mov    0x80117c20,%edx
80103d5e:	89 10                	mov    %edx,(%eax)
  release(&tickslock);
80103d60:	c7 04 24 e0 73 11 80 	movl   $0x801173e0,(%esp)
80103d67:	e8 24 1e 00 00       	call   80105b90 <release>
  acquire(&ptable.lock);
80103d6c:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80103d73:	e8 78 1d 00 00       	call   80105af0 <acquire>
  if(POLICY == 1)
80103d78:	83 3d 08 c0 10 80 01 	cmpl   $0x1,0x8010c008
  np->state = RUNNABLE;
80103d7f:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
      rrq.enqueue(np);
80103d86:	89 3c 24             	mov    %edi,(%esp)
  if(POLICY == 1)
80103d89:	74 35                	je     80103dc0 <fork+0x140>
      pq.put(np);
80103d8b:	ff 15 f0 c5 10 80    	call   *0x8010c5f0
  np->priority = 5; // Set the priority of new process to 5
80103d91:	b8 05 00 00 00       	mov    $0x5,%eax
80103d96:	89 87 80 00 00 00    	mov    %eax,0x80(%edi)
  setAccumulator(np);
80103d9c:	89 3c 24             	mov    %edi,(%esp)
80103d9f:	e8 ac fc ff ff       	call   80103a50 <setAccumulator>
  release(&ptable.lock);
80103da4:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80103dab:	e8 e0 1d 00 00       	call   80105b90 <release>
}
80103db0:	83 c4 1c             	add    $0x1c,%esp
80103db3:	89 d8                	mov    %ebx,%eax
80103db5:	5b                   	pop    %ebx
80103db6:	5e                   	pop    %esi
80103db7:	5f                   	pop    %edi
80103db8:	5d                   	pop    %ebp
80103db9:	c3                   	ret    
80103dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      rrq.enqueue(np);
80103dc0:	ff 15 e0 c5 10 80    	call   *0x8010c5e0
80103dc6:	eb c9                	jmp    80103d91 <fork+0x111>
    return -1;
80103dc8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103dcd:	8d 76 00             	lea    0x0(%esi),%esi
80103dd0:	eb de                	jmp    80103db0 <fork+0x130>
    kfree(np->kstack);
80103dd2:	8b 47 08             	mov    0x8(%edi),%eax
    return -1;
80103dd5:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    kfree(np->kstack);
80103dda:	89 04 24             	mov    %eax,(%esp)
80103ddd:	e8 fe e5 ff ff       	call   801023e0 <kfree>
    np->kstack = 0;
80103de2:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103de9:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103df0:	eb be                	jmp    80103db0 <fork+0x130>
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
80103e18:	81 c3 98 00 00 00    	add    $0x98,%ebx
80103e1e:	81 fb d4 73 11 80    	cmp    $0x801173d4,%ebx
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
80103e65:	81 c3 98 00 00 00    	add    $0x98,%ebx
      else
        pq.put(p);
80103e6b:	ff 15 f0 c5 10 80    	call   *0x8010c5f0
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e71:	81 fb d4 73 11 80    	cmp    $0x801173d4,%ebx
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
80103ea9:	e8 42 1c 00 00       	call   80105af0 <acquire>
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
80103ed1:	e8 3a 42 00 00       	call   80108110 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103ed6:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103ed9:	89 34 24             	mov    %esi,(%esp)
      p->state = RUNNING;
80103edc:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103ee3:	89 44 24 04          	mov    %eax,0x4(%esp)
80103ee7:	e8 2d 1f 00 00       	call   80105e19 <swtch>
      switchkvm();
80103eec:	e8 ff 41 00 00       	call   801080f0 <switchkvm>
      c->proc = 0;
80103ef1:	31 c0                	xor    %eax,%eax
80103ef3:	89 87 ac 00 00 00    	mov    %eax,0xac(%edi)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ef9:	81 c3 98 00 00 00    	add    $0x98,%ebx
80103eff:	81 fb d4 73 11 80    	cmp    $0x801173d4,%ebx
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
80103f15:	e9 76 1c 00 00       	jmp    80105b90 <release>
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
80103f33:	e8 b8 1b 00 00       	call   80105af0 <acquire>
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
80103f53:	e8 b8 41 00 00       	call   80108110 <switchuvm>
            swtch(&(c->scheduler), p->context);
80103f58:	8b 43 1c             	mov    0x1c(%ebx),%eax
            p->state = RUNNING;
80103f5b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
            swtch(&(c->scheduler), p->context);
80103f62:	89 44 24 04          	mov    %eax,0x4(%esp)
80103f66:	8d 46 04             	lea    0x4(%esi),%eax
80103f69:	89 04 24             	mov    %eax,(%esp)
80103f6c:	e8 a8 1e 00 00       	call   80105e19 <swtch>
            switchkvm();
80103f71:	e8 7a 41 00 00       	call   801080f0 <switchkvm>
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
80103f9d:	e9 ee 1b 00 00       	jmp    80105b90 <release>
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
80103fc3:	e8 28 1b 00 00       	call   80105af0 <acquire>
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
80103fe3:	e8 28 41 00 00       	call   80108110 <switchuvm>
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
8010400e:	e8 06 1e 00 00       	call   80105e19 <swtch>
        switchkvm();
80104013:	e8 d8 40 00 00       	call   801080f0 <switchkvm>
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
8010402d:	e9 5e 1b 00 00       	jmp    80105b90 <release>
80104032:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104040 <extendedPriorityScheduler>:
{
80104040:	55                   	push   %ebp
80104041:	89 e5                	mov    %esp,%ebp
80104043:	57                   	push   %edi
80104044:	56                   	push   %esi
80104045:	53                   	push   %ebx
80104046:	83 ec 3c             	sub    $0x3c,%esp
80104049:	8b 45 0c             	mov    0xc(%ebp),%eax
8010404c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010404f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80104052:	fb                   	sti    
    acquire(&ptable.lock);
80104053:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
8010405a:	e8 91 1a 00 00       	call   80105af0 <acquire>
    if(!pq.isEmpty()){
8010405f:	ff 15 ec c5 10 80    	call   *0x8010c5ec
80104065:	85 c0                	test   %eax,%eax
80104067:	75 5b                	jne    801040c4 <extendedPriorityScheduler+0x84>
            if (avoidStarv){
80104069:	8b 0d b8 c5 10 80    	mov    0x8010c5b8,%ecx
8010406f:	85 c9                	test   %ecx,%ecx
80104071:	75 6d                	jne    801040e0 <extendedPriorityScheduler+0xa0>
                np = pq.extractMin();
80104073:	ff 15 f8 c5 10 80    	call   *0x8010c5f8
80104079:	89 c3                	mov    %eax,%ebx
            c->proc = np;
8010407b:	8b 7d d4             	mov    -0x2c(%ebp),%edi
8010407e:	89 9f ac 00 00 00    	mov    %ebx,0xac(%edi)
            switchuvm(np);
80104084:	89 1c 24             	mov    %ebx,(%esp)
80104087:	e8 84 40 00 00       	call   80108110 <switchuvm>
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
801040a8:	89 44 24 04          	mov    %eax,0x4(%esp)
801040ac:	8d 47 04             	lea    0x4(%edi),%eax
801040af:	89 04 24             	mov    %eax,(%esp)
801040b2:	e8 62 1d 00 00       	call   80105e19 <swtch>
            switchkvm();
801040b7:	e8 34 40 00 00       	call   801080f0 <switchkvm>
            c->proc = 0;
801040bc:	31 c0                	xor    %eax,%eax
801040be:	89 87 ac 00 00 00    	mov    %eax,0xac(%edi)
                        release(&ptable.lock);
801040c4:	c7 45 08 a0 4d 11 80 	movl   $0x80114da0,0x8(%ebp)
}
801040cb:	83 c4 3c             	add    $0x3c,%esp
801040ce:	5b                   	pop    %ebx
801040cf:	5e                   	pop    %esi
801040d0:	5f                   	pop    %edi
801040d1:	5d                   	pop    %ebp
                        release(&ptable.lock);
801040d2:	e9 b9 1a 00 00       	jmp    80105b90 <release>
801040d7:	89 f6                	mov    %esi,%esi
801040d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
                            if (tqCounter - p->timeStamp > max){
801040e0:	8b 35 c0 c5 10 80    	mov    0x8010c5c0,%esi
                double max = 0;
801040e6:	d9 ee                	fldz   
                for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){  // Run over all the ptable and look for the process which didn't work for the lonest time.
801040e8:	b8 d4 4d 11 80       	mov    $0x80114dd4,%eax
                            if (tqCounter - p->timeStamp > max){
801040ed:	8b 3d c4 c5 10 80    	mov    0x8010c5c4,%edi
801040f3:	eb 17                	jmp    8010410c <extendedPriorityScheduler+0xcc>
801040f5:	8d 76 00             	lea    0x0(%esi),%esi
801040f8:	dd d8                	fstp   %st(0)
801040fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){  // Run over all the ptable and look for the process which didn't work for the lonest time.
80104100:	05 98 00 00 00       	add    $0x98,%eax
80104105:	3d d4 73 11 80       	cmp    $0x801173d4,%eax
8010410a:	73 34                	jae    80104140 <extendedPriorityScheduler+0x100>
                        if (p->state == RUNNABLE){
8010410c:	8b 48 0c             	mov    0xc(%eax),%ecx
8010410f:	83 f9 03             	cmp    $0x3,%ecx
80104112:	75 ec                	jne    80104100 <extendedPriorityScheduler+0xc0>
                            if (tqCounter - p->timeStamp > max){
80104114:	89 f2                	mov    %esi,%edx
80104116:	89 f9                	mov    %edi,%ecx
80104118:	2b 90 8c 00 00 00    	sub    0x8c(%eax),%edx
8010411e:	1b 88 90 00 00 00    	sbb    0x90(%eax),%ecx
80104124:	89 55 d8             	mov    %edx,-0x28(%ebp)
80104127:	89 4d dc             	mov    %ecx,-0x24(%ebp)
8010412a:	df 6d d8             	fildll -0x28(%ebp)
8010412d:	db e9                	fucomi %st(1),%st
8010412f:	76 c7                	jbe    801040f8 <extendedPriorityScheduler+0xb8>
80104131:	dd d9                	fstp   %st(1)
80104133:	89 c3                	mov    %eax,%ebx
80104135:	eb c9                	jmp    80104100 <extendedPriorityScheduler+0xc0>
80104137:	89 f6                	mov    %esi,%esi
80104139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104140:	dd d8                	fstp   %st(0)
                if (!pq.extractProc(np)){
80104142:	89 1c 24             	mov    %ebx,(%esp)
80104145:	ff 15 00 c6 10 80    	call   *0x8010c600
8010414b:	85 c0                	test   %eax,%eax
8010414d:	0f 84 71 ff ff ff    	je     801040c4 <extendedPriorityScheduler+0x84>
                 avoidStarv = 0;
80104153:	31 d2                	xor    %edx,%edx
80104155:	89 15 b8 c5 10 80    	mov    %edx,0x8010c5b8
8010415b:	e9 1b ff ff ff       	jmp    8010407b <extendedPriorityScheduler+0x3b>

80104160 <scheduler>:
{
80104160:	55                   	push   %ebp
80104161:	89 e5                	mov    %esp,%ebp
80104163:	53                   	push   %ebx
80104164:	83 ec 14             	sub    $0x14,%esp
  struct cpu *c = mycpu();
80104167:	e8 94 f7 ff ff       	call   80103900 <mycpu>
8010416c:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
8010416e:	31 c0                	xor    %eax,%eax
80104170:	89 83 ac 00 00 00    	mov    %eax,0xac(%ebx)
80104176:	8d 76 00             	lea    0x0(%esi),%esi
80104179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    switch(POLICY){
80104180:	a1 08 c0 10 80       	mov    0x8010c008,%eax
80104185:	83 f8 01             	cmp    $0x1,%eax
80104188:	74 26                	je     801041b0 <scheduler+0x50>
8010418a:	7e 3c                	jle    801041c8 <scheduler+0x68>
8010418c:	83 f8 02             	cmp    $0x2,%eax
8010418f:	74 4f                	je     801041e0 <scheduler+0x80>
80104191:	83 f8 03             	cmp    $0x3,%eax
80104194:	75 ef                	jne    80104185 <scheduler+0x25>
            extendedPriorityScheduler(p, c);
80104196:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010419a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801041a1:	e8 9a fe ff ff       	call   80104040 <extendedPriorityScheduler>
    switch(POLICY){
801041a6:	a1 08 c0 10 80       	mov    0x8010c008,%eax
801041ab:	83 f8 01             	cmp    $0x1,%eax
801041ae:	75 da                	jne    8010418a <scheduler+0x2a>
            roundRobinScheduler(p, c);
801041b0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801041b4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801041bb:	e8 60 fd ff ff       	call   80103f20 <roundRobinScheduler>
            break;
801041c0:	eb be                	jmp    80104180 <scheduler+0x20>
801041c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(POLICY){
801041c8:	85 c0                	test   %eax,%eax
801041ca:	75 b9                	jne    80104185 <scheduler+0x25>
            originalScheduler(p, c);
801041cc:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801041d0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801041d7:	e8 b4 fc ff ff       	call   80103e90 <originalScheduler>
            break;
801041dc:	eb a2                	jmp    80104180 <scheduler+0x20>
801041de:	66 90                	xchg   %ax,%ax
            priorityScheduler(p, c);
801041e0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801041e4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801041eb:	e8 c0 fd ff ff       	call   80103fb0 <priorityScheduler>
            break;
801041f0:	eb 8e                	jmp    80104180 <scheduler+0x20>
801041f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104200 <sched>:
{
80104200:	55                   	push   %ebp
80104201:	89 e5                	mov    %esp,%ebp
80104203:	56                   	push   %esi
80104204:	53                   	push   %ebx
80104205:	83 ec 10             	sub    $0x10,%esp
  pushcli();
80104208:	e8 03 18 00 00       	call   80105a10 <pushcli>
  c = mycpu();
8010420d:	e8 ee f6 ff ff       	call   80103900 <mycpu>
  p = c->proc;
80104212:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104218:	e8 33 18 00 00       	call   80105a50 <popcli>
  if(!holding(&ptable.lock))
8010421d:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104224:	e8 87 18 00 00       	call   80105ab0 <holding>
80104229:	85 c0                	test   %eax,%eax
8010422b:	74 51                	je     8010427e <sched+0x7e>
  if(mycpu()->ncli != 1)
8010422d:	e8 ce f6 ff ff       	call   80103900 <mycpu>
80104232:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80104239:	75 67                	jne    801042a2 <sched+0xa2>
  if(p->state == RUNNING)
8010423b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010423e:	83 f8 04             	cmp    $0x4,%eax
80104241:	74 53                	je     80104296 <sched+0x96>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104243:	9c                   	pushf  
80104244:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104245:	f6 c4 02             	test   $0x2,%ah
80104248:	75 40                	jne    8010428a <sched+0x8a>
  intena = mycpu()->intena;
8010424a:	e8 b1 f6 ff ff       	call   80103900 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
8010424f:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104252:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104258:	e8 a3 f6 ff ff       	call   80103900 <mycpu>
8010425d:	8b 40 04             	mov    0x4(%eax),%eax
80104260:	89 1c 24             	mov    %ebx,(%esp)
80104263:	89 44 24 04          	mov    %eax,0x4(%esp)
80104267:	e8 ad 1b 00 00       	call   80105e19 <swtch>
  mycpu()->intena = intena;
8010426c:	e8 8f f6 ff ff       	call   80103900 <mycpu>
80104271:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104277:	83 c4 10             	add    $0x10,%esp
8010427a:	5b                   	pop    %ebx
8010427b:	5e                   	pop    %esi
8010427c:	5d                   	pop    %ebp
8010427d:	c3                   	ret    
    panic("sched ptable.lock");
8010427e:	c7 04 24 e0 8d 10 80 	movl   $0x80108de0,(%esp)
80104285:	e8 e6 c0 ff ff       	call   80100370 <panic>
    panic("sched interruptible");
8010428a:	c7 04 24 0c 8e 10 80 	movl   $0x80108e0c,(%esp)
80104291:	e8 da c0 ff ff       	call   80100370 <panic>
    panic("sched running");
80104296:	c7 04 24 fe 8d 10 80 	movl   $0x80108dfe,(%esp)
8010429d:	e8 ce c0 ff ff       	call   80100370 <panic>
    panic("sched locks");
801042a2:	c7 04 24 f2 8d 10 80 	movl   $0x80108df2,(%esp)
801042a9:	e8 c2 c0 ff ff       	call   80100370 <panic>
801042ae:	66 90                	xchg   %ax,%ax

801042b0 <exit>:
{
801042b0:	55                   	push   %ebp
801042b1:	89 e5                	mov    %esp,%ebp
801042b3:	57                   	push   %edi
801042b4:	56                   	push   %esi
801042b5:	53                   	push   %ebx
801042b6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
801042b9:	e8 52 17 00 00       	call   80105a10 <pushcli>
  c = mycpu();
801042be:	e8 3d f6 ff ff       	call   80103900 <mycpu>
  p = c->proc;
801042c3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801042c9:	e8 82 17 00 00       	call   80105a50 <popcli>
  if(curproc == initproc)
801042ce:	39 35 c8 c5 10 80    	cmp    %esi,0x8010c5c8
801042d4:	0f 84 c5 00 00 00    	je     8010439f <exit+0xef>
801042da:	8d 5e 28             	lea    0x28(%esi),%ebx
801042dd:	8d 7e 68             	lea    0x68(%esi),%edi
    if(curproc->ofile[fd]){
801042e0:	8b 03                	mov    (%ebx),%eax
801042e2:	85 c0                	test   %eax,%eax
801042e4:	74 0e                	je     801042f4 <exit+0x44>
      fileclose(curproc->ofile[fd]);
801042e6:	89 04 24             	mov    %eax,(%esp)
801042e9:	e8 42 cb ff ff       	call   80100e30 <fileclose>
      curproc->ofile[fd] = 0;
801042ee:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801042f4:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
801042f7:	39 df                	cmp    %ebx,%edi
801042f9:	75 e5                	jne    801042e0 <exit+0x30>
  begin_op();
801042fb:	e8 90 e9 ff ff       	call   80102c90 <begin_op>
  iput(curproc->cwd);
80104300:	8b 46 68             	mov    0x68(%esi),%eax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104303:	bb d4 4d 11 80       	mov    $0x80114dd4,%ebx
  iput(curproc->cwd);
80104308:	89 04 24             	mov    %eax,(%esp)
8010430b:	e8 10 d5 ff ff       	call   80101820 <iput>
  end_op();
80104310:	e8 eb e9 ff ff       	call   80102d00 <end_op>
  curproc->cwd = 0;
80104315:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
8010431c:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104323:	e8 c8 17 00 00       	call   80105af0 <acquire>
  wakeup1(curproc->parent);
80104328:	8b 46 14             	mov    0x14(%esi),%eax
8010432b:	e8 d0 fa ff ff       	call   80103e00 <wakeup1>
80104330:	eb 14                	jmp    80104346 <exit+0x96>
80104332:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104338:	81 c3 98 00 00 00    	add    $0x98,%ebx
8010433e:	81 fb d4 73 11 80    	cmp    $0x801173d4,%ebx
80104344:	73 2a                	jae    80104370 <exit+0xc0>
    if(p->parent == curproc){
80104346:	39 73 14             	cmp    %esi,0x14(%ebx)
80104349:	75 ed                	jne    80104338 <exit+0x88>
      if(p->state == ZOMBIE)
8010434b:	8b 53 0c             	mov    0xc(%ebx),%edx
      p->parent = initproc;
8010434e:	a1 c8 c5 10 80       	mov    0x8010c5c8,%eax
      if(p->state == ZOMBIE)
80104353:	83 fa 05             	cmp    $0x5,%edx
      p->parent = initproc;
80104356:	89 43 14             	mov    %eax,0x14(%ebx)
      if(p->state == ZOMBIE)
80104359:	75 dd                	jne    80104338 <exit+0x88>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010435b:	81 c3 98 00 00 00    	add    $0x98,%ebx
        wakeup1(initproc);
80104361:	e8 9a fa ff ff       	call   80103e00 <wakeup1>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104366:	81 fb d4 73 11 80    	cmp    $0x801173d4,%ebx
8010436c:	72 d8                	jb     80104346 <exit+0x96>
8010436e:	66 90                	xchg   %ax,%ax
  curproc->exitStatus = status;
80104370:	8b 45 08             	mov    0x8(%ebp),%eax
80104373:	89 46 7c             	mov    %eax,0x7c(%esi)
  if(p->state == RUNNING)
80104376:	8b 43 0c             	mov    0xc(%ebx),%eax
80104379:	83 f8 04             	cmp    $0x4,%eax
8010437c:	75 09                	jne    80104387 <exit+0xd7>
      rpholder.remove(p);
8010437e:	89 1c 24             	mov    %ebx,(%esp)
80104381:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
  curproc->state = ZOMBIE;
80104387:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
8010438e:	e8 6d fe ff ff       	call   80104200 <sched>
  panic("zombie exit");
80104393:	c7 04 24 2d 8e 10 80 	movl   $0x80108e2d,(%esp)
8010439a:	e8 d1 bf ff ff       	call   80100370 <panic>
    panic("init exiting");
8010439f:	c7 04 24 20 8e 10 80 	movl   $0x80108e20,(%esp)
801043a6:	e8 c5 bf ff ff       	call   80100370 <panic>
801043ab:	90                   	nop
801043ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801043b0 <yield>:
{
801043b0:	55                   	push   %ebp
801043b1:	89 e5                	mov    %esp,%ebp
801043b3:	53                   	push   %ebx
801043b4:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801043b7:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
801043be:	e8 2d 17 00 00       	call   80105af0 <acquire>
  pushcli();
801043c3:	e8 48 16 00 00       	call   80105a10 <pushcli>
  c = mycpu();
801043c8:	e8 33 f5 ff ff       	call   80103900 <mycpu>
  p = c->proc;
801043cd:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801043d3:	e8 78 16 00 00       	call   80105a50 <popcli>
  if(p->state == RUNNING){
801043d8:	8b 43 0c             	mov    0xc(%ebx),%eax
801043db:	83 f8 04             	cmp    $0x4,%eax
801043de:	75 20                	jne    80104400 <yield+0x50>
    p->timeStamp = tqCounter;   
801043e0:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
801043e5:	8b 15 c4 c5 10 80    	mov    0x8010c5c4,%edx
801043eb:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
801043f1:	89 93 90 00 00 00    	mov    %edx,0x90(%ebx)
    rpholder.remove(p);
801043f7:	89 1c 24             	mov    %ebx,(%esp)
801043fa:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
  tqCounter++;
80104400:	83 05 c0 c5 10 80 01 	addl   $0x1,0x8010c5c0
  p->state = RUNNABLE;
80104407:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  tqCounter++;
8010440e:	83 15 c4 c5 10 80 00 	adcl   $0x0,0x8010c5c4
  if(POLICY == 1){
80104415:	83 3d 08 c0 10 80 01 	cmpl   $0x1,0x8010c008
      rrq.enqueue(p);
8010441c:	89 1c 24             	mov    %ebx,(%esp)
  if(POLICY == 1){
8010441f:	74 7f                	je     801044a0 <yield+0xf0>
      pq.put(p);
80104421:	ff 15 f0 c5 10 80    	call   *0x8010c5f0
      p->accumulator += p->priority;
80104427:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
8010442d:	99                   	cltd   
8010442e:	01 83 84 00 00 00    	add    %eax,0x84(%ebx)
80104434:	11 93 88 00 00 00    	adc    %edx,0x88(%ebx)
      if (POLICY == 3 && (tqCounter % 100 == 0)){
8010443a:	83 3d 08 c0 10 80 03 	cmpl   $0x3,0x8010c008
80104441:	74 1d                	je     80104460 <yield+0xb0>
  sched();
80104443:	e8 b8 fd ff ff       	call   80104200 <sched>
  release(&ptable.lock);
80104448:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
8010444f:	e8 3c 17 00 00       	call   80105b90 <release>
}
80104454:	83 c4 14             	add    $0x14,%esp
80104457:	5b                   	pop    %ebx
80104458:	5d                   	pop    %ebp
80104459:	c3                   	ret    
8010445a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if (POLICY == 3 && (tqCounter % 100 == 0)){
80104460:	ba 64 00 00 00       	mov    $0x64,%edx
80104465:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
8010446a:	31 c9                	xor    %ecx,%ecx
8010446c:	89 54 24 08          	mov    %edx,0x8(%esp)
80104470:	8b 15 c4 c5 10 80    	mov    0x8010c5c4,%edx
80104476:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
8010447a:	89 04 24             	mov    %eax,(%esp)
8010447d:	89 54 24 04          	mov    %edx,0x4(%esp)
80104481:	e8 1a 13 00 00       	call   801057a0 <__moddi3>
80104486:	09 c2                	or     %eax,%edx
80104488:	75 b9                	jne    80104443 <yield+0x93>
         avoidStarv = 1;
8010448a:	b8 01 00 00 00       	mov    $0x1,%eax
8010448f:	a3 b8 c5 10 80       	mov    %eax,0x8010c5b8
80104494:	eb ad                	jmp    80104443 <yield+0x93>
80104496:	8d 76 00             	lea    0x0(%esi),%esi
80104499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      rrq.enqueue(p);
801044a0:	ff 15 e0 c5 10 80    	call   *0x8010c5e0
801044a6:	eb 9b                	jmp    80104443 <yield+0x93>
801044a8:	90                   	nop
801044a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801044b0 <sleep>:
{
801044b0:	55                   	push   %ebp
801044b1:	89 e5                	mov    %esp,%ebp
801044b3:	83 ec 28             	sub    $0x28,%esp
801044b6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801044b9:	89 75 f8             	mov    %esi,-0x8(%ebp)
801044bc:	8b 75 0c             	mov    0xc(%ebp),%esi
801044bf:	89 7d fc             	mov    %edi,-0x4(%ebp)
801044c2:	8b 7d 08             	mov    0x8(%ebp),%edi
  pushcli();
801044c5:	e8 46 15 00 00       	call   80105a10 <pushcli>
  c = mycpu();
801044ca:	e8 31 f4 ff ff       	call   80103900 <mycpu>
  p = c->proc;
801044cf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801044d5:	e8 76 15 00 00       	call   80105a50 <popcli>
  if(p == 0)
801044da:	85 db                	test   %ebx,%ebx
801044dc:	0f 84 ae 00 00 00    	je     80104590 <sleep+0xe0>
  if(lk == 0)
801044e2:	85 f6                	test   %esi,%esi
801044e4:	0f 84 9a 00 00 00    	je     80104584 <sleep+0xd4>
  if(lk != &ptable.lock){  //DOC: sleeplock0
801044ea:	81 fe a0 4d 11 80    	cmp    $0x80114da0,%esi
801044f0:	74 5e                	je     80104550 <sleep+0xa0>
    acquire(&ptable.lock);  //DOC: sleeplock1
801044f2:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
801044f9:	e8 f2 15 00 00       	call   80105af0 <acquire>
    release(lk); 
801044fe:	89 34 24             	mov    %esi,(%esp)
80104501:	e8 8a 16 00 00       	call   80105b90 <release>
  if(p->state == RUNNING)
80104506:	8b 43 0c             	mov    0xc(%ebx),%eax
  p->chan = chan;
80104509:	89 7b 20             	mov    %edi,0x20(%ebx)
  if(p->state == RUNNING)
8010450c:	83 f8 04             	cmp    $0x4,%eax
8010450f:	75 09                	jne    8010451a <sleep+0x6a>
      rpholder.remove(p);
80104511:	89 1c 24             	mov    %ebx,(%esp)
80104514:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
  p->state = SLEEPING;
8010451a:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104521:	e8 da fc ff ff       	call   80104200 <sched>
  p->chan = 0;
80104526:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
8010452d:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104534:	e8 57 16 00 00       	call   80105b90 <release>
}
80104539:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    acquire(lk);
8010453c:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010453f:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104542:	8b 75 f8             	mov    -0x8(%ebp),%esi
80104545:	89 ec                	mov    %ebp,%esp
80104547:	5d                   	pop    %ebp
    acquire(lk);
80104548:	e9 a3 15 00 00       	jmp    80105af0 <acquire>
8010454d:	8d 76 00             	lea    0x0(%esi),%esi
  if(p->state == RUNNING)
80104550:	8b 43 0c             	mov    0xc(%ebx),%eax
  p->chan = chan;
80104553:	89 7b 20             	mov    %edi,0x20(%ebx)
  if(p->state == RUNNING)
80104556:	83 f8 04             	cmp    $0x4,%eax
80104559:	75 09                	jne    80104564 <sleep+0xb4>
      rpholder.remove(p);
8010455b:	89 1c 24             	mov    %ebx,(%esp)
8010455e:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
  p->state = SLEEPING;
80104564:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
8010456b:	e8 90 fc ff ff       	call   80104200 <sched>
  p->chan = 0;
80104570:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104577:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010457a:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010457d:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104580:	89 ec                	mov    %ebp,%esp
80104582:	5d                   	pop    %ebp
80104583:	c3                   	ret    
    panic("sleep without lk");
80104584:	c7 04 24 3f 8e 10 80 	movl   $0x80108e3f,(%esp)
8010458b:	e8 e0 bd ff ff       	call   80100370 <panic>
    panic("sleep");
80104590:	c7 04 24 39 8e 10 80 	movl   $0x80108e39,(%esp)
80104597:	e8 d4 bd ff ff       	call   80100370 <panic>
8010459c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801045a0 <wait>:
{
801045a0:	55                   	push   %ebp
801045a1:	89 e5                	mov    %esp,%ebp
801045a3:	57                   	push   %edi
801045a4:	56                   	push   %esi
801045a5:	53                   	push   %ebx
801045a6:	83 ec 1c             	sub    $0x1c,%esp
801045a9:	8b 7d 08             	mov    0x8(%ebp),%edi
  pushcli();
801045ac:	e8 5f 14 00 00       	call   80105a10 <pushcli>
  c = mycpu();
801045b1:	e8 4a f3 ff ff       	call   80103900 <mycpu>
  p = c->proc;
801045b6:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801045bc:	e8 8f 14 00 00       	call   80105a50 <popcli>
  acquire(&ptable.lock);
801045c1:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
801045c8:	e8 23 15 00 00       	call   80105af0 <acquire>
    havekids = 0;
801045cd:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045cf:	bb d4 4d 11 80       	mov    $0x80114dd4,%ebx
801045d4:	eb 18                	jmp    801045ee <wait+0x4e>
801045d6:	8d 76 00             	lea    0x0(%esi),%esi
801045d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801045e0:	81 c3 98 00 00 00    	add    $0x98,%ebx
801045e6:	81 fb d4 73 11 80    	cmp    $0x801173d4,%ebx
801045ec:	73 20                	jae    8010460e <wait+0x6e>
      if(p->parent != curproc)
801045ee:	39 73 14             	cmp    %esi,0x14(%ebx)
801045f1:	75 ed                	jne    801045e0 <wait+0x40>
      if(p->state == ZOMBIE){
801045f3:	8b 43 0c             	mov    0xc(%ebx),%eax
801045f6:	83 f8 05             	cmp    $0x5,%eax
801045f9:	74 35                	je     80104630 <wait+0x90>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045fb:	81 c3 98 00 00 00    	add    $0x98,%ebx
      havekids = 1;
80104601:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104606:	81 fb d4 73 11 80    	cmp    $0x801173d4,%ebx
8010460c:	72 e0                	jb     801045ee <wait+0x4e>
    if(!havekids || curproc->killed){
8010460e:	85 c0                	test   %eax,%eax
80104610:	74 7d                	je     8010468f <wait+0xef>
80104612:	8b 56 24             	mov    0x24(%esi),%edx
80104615:	85 d2                	test   %edx,%edx
80104617:	75 76                	jne    8010468f <wait+0xef>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104619:	b8 a0 4d 11 80       	mov    $0x80114da0,%eax
8010461e:	89 44 24 04          	mov    %eax,0x4(%esp)
80104622:	89 34 24             	mov    %esi,(%esp)
80104625:	e8 86 fe ff ff       	call   801044b0 <sleep>
    havekids = 0;
8010462a:	eb a1                	jmp    801045cd <wait+0x2d>
8010462c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80104630:	8b 43 08             	mov    0x8(%ebx),%eax
        pid = p->pid;
80104633:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104636:	89 04 24             	mov    %eax,(%esp)
80104639:	e8 a2 dd ff ff       	call   801023e0 <kfree>
        freevm(p->pgdir);
8010463e:	8b 43 04             	mov    0x4(%ebx),%eax
        p->kstack = 0;
80104641:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104648:	89 04 24             	mov    %eax,(%esp)
8010464b:	e8 70 3e 00 00       	call   801084c0 <freevm>
        if(status != null){ 
80104650:	85 ff                	test   %edi,%edi
        p->pid = 0;
80104652:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104659:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104660:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104664:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
8010466b:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        if(status != null){ 
80104672:	74 05                	je     80104679 <wait+0xd9>
            *status = p->exitStatus;
80104674:	8b 43 7c             	mov    0x7c(%ebx),%eax
80104677:	89 07                	mov    %eax,(%edi)
        release(&ptable.lock);
80104679:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104680:	e8 0b 15 00 00       	call   80105b90 <release>
}
80104685:	83 c4 1c             	add    $0x1c,%esp
80104688:	89 f0                	mov    %esi,%eax
8010468a:	5b                   	pop    %ebx
8010468b:	5e                   	pop    %esi
8010468c:	5f                   	pop    %edi
8010468d:	5d                   	pop    %ebp
8010468e:	c3                   	ret    
      release(&ptable.lock);
8010468f:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
      return -1;
80104696:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010469b:	e8 f0 14 00 00       	call   80105b90 <release>
      return -1;
801046a0:	eb e3                	jmp    80104685 <wait+0xe5>
801046a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046b0 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801046b0:	55                   	push   %ebp
801046b1:	89 e5                	mov    %esp,%ebp
801046b3:	53                   	push   %ebx
801046b4:	83 ec 14             	sub    $0x14,%esp
801046b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801046ba:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
801046c1:	e8 2a 14 00 00       	call   80105af0 <acquire>
  wakeup1(chan);
801046c6:	89 d8                	mov    %ebx,%eax
801046c8:	e8 33 f7 ff ff       	call   80103e00 <wakeup1>
  release(&ptable.lock);
801046cd:	c7 45 08 a0 4d 11 80 	movl   $0x80114da0,0x8(%ebp)
}
801046d4:	83 c4 14             	add    $0x14,%esp
801046d7:	5b                   	pop    %ebx
801046d8:	5d                   	pop    %ebp
  release(&ptable.lock);
801046d9:	e9 b2 14 00 00       	jmp    80105b90 <release>
801046de:	66 90                	xchg   %ax,%ax

801046e0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801046e0:	55                   	push   %ebp
801046e1:	89 e5                	mov    %esp,%ebp
801046e3:	56                   	push   %esi
801046e4:	53                   	push   %ebx
  struct proc *p;
    
  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046e5:	bb d4 4d 11 80       	mov    $0x80114dd4,%ebx
{
801046ea:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801046ed:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
{
801046f4:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&ptable.lock);
801046f7:	e8 f4 13 00 00       	call   80105af0 <acquire>
801046fc:	eb 10                	jmp    8010470e <kill+0x2e>
801046fe:	66 90                	xchg   %ax,%ax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104700:	81 c3 98 00 00 00    	add    $0x98,%ebx
80104706:	81 fb d4 73 11 80    	cmp    $0x801173d4,%ebx
8010470c:	73 72                	jae    80104780 <kill+0xa0>
    if(p->pid == pid){
8010470e:	39 73 10             	cmp    %esi,0x10(%ebx)
80104711:	75 ed                	jne    80104700 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING){
80104713:	8b 43 0c             	mov    0xc(%ebx),%eax
      p->killed = 1;
80104716:	c7 43 24 01 00 00 00 	movl   $0x1,0x24(%ebx)
      if(p->state == SLEEPING){
8010471d:	83 f8 02             	cmp    $0x2,%eax
80104720:	74 1e                	je     80104740 <kill+0x60>
        if(POLICY == 1)
            rrq.enqueue(p);
        else
            pq.put(p);
      }
      release(&ptable.lock);
80104722:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104729:	e8 62 14 00 00       	call   80105b90 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
8010472e:	83 c4 10             	add    $0x10,%esp
      return 0;
80104731:	31 c0                	xor    %eax,%eax
}
80104733:	5b                   	pop    %ebx
80104734:	5e                   	pop    %esi
80104735:	5d                   	pop    %ebp
80104736:	c3                   	ret    
80104737:	89 f6                	mov    %esi,%esi
80104739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        p->timeStamp = tqCounter;
80104740:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
80104745:	8b 15 c4 c5 10 80    	mov    0x8010c5c4,%edx
        setAccumulator(p);  
8010474b:	89 1c 24             	mov    %ebx,(%esp)
        p->state = RUNNABLE;
8010474e:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
        p->timeStamp = tqCounter;
80104755:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
8010475b:	89 93 90 00 00 00    	mov    %edx,0x90(%ebx)
        setAccumulator(p);  
80104761:	e8 ea f2 ff ff       	call   80103a50 <setAccumulator>
        if(POLICY == 1)
80104766:	83 3d 08 c0 10 80 01 	cmpl   $0x1,0x8010c008
            rrq.enqueue(p);
8010476d:	89 1c 24             	mov    %ebx,(%esp)
        if(POLICY == 1)
80104770:	74 26                	je     80104798 <kill+0xb8>
            pq.put(p);
80104772:	ff 15 f0 c5 10 80    	call   *0x8010c5f0
80104778:	eb a8                	jmp    80104722 <kill+0x42>
8010477a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104780:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104787:	e8 04 14 00 00       	call   80105b90 <release>
}
8010478c:	83 c4 10             	add    $0x10,%esp
  return -1;
8010478f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104794:	5b                   	pop    %ebx
80104795:	5e                   	pop    %esi
80104796:	5d                   	pop    %ebp
80104797:	c3                   	ret    
            rrq.enqueue(p);
80104798:	ff 15 e0 c5 10 80    	call   *0x8010c5e0
8010479e:	eb 82                	jmp    80104722 <kill+0x42>

801047a0 <detach>:

// transfer a child process with the given pid from the parent to the init process.
// return 0 when succseeds or -1 if the process has no child with this pid.
int
detach(int pid)
{ 
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	57                   	push   %edi
801047a4:	56                   	push   %esi
801047a5:	53                   	push   %ebx
801047a6:	83 ec 2c             	sub    $0x2c,%esp
801047a9:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801047ac:	e8 5f 12 00 00       	call   80105a10 <pushcli>
  c = mycpu();
801047b1:	e8 4a f1 ff ff       	call   80103900 <mycpu>
  p = c->proc;
801047b6:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
801047bc:	e8 8f 12 00 00       	call   80105a50 <popcli>
  struct proc *curproc = myproc();
  struct proc *p;
  int procExist = -1;

  if(curproc == initproc)
801047c1:	39 3d c8 c5 10 80    	cmp    %edi,0x8010c5c8
801047c7:	74 7e                	je     80104847 <detach+0xa7>
    panic("init called detach");

  acquire(&ptable.lock);
801047c9:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801047d0:	bb d4 4d 11 80       	mov    $0x80114dd4,%ebx
  acquire(&ptable.lock);
801047d5:	e8 16 13 00 00       	call   80105af0 <acquire>
  int procExist = -1;
801047da:	ba ff ff ff ff       	mov    $0xffffffff,%edx
801047df:	eb 15                	jmp    801047f6 <detach+0x56>
801047e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801047e8:	81 c3 98 00 00 00    	add    $0x98,%ebx
801047ee:	81 fb d4 73 11 80    	cmp    $0x801173d4,%ebx
801047f4:	73 35                	jae    8010482b <detach+0x8b>
    if(p->pid == pid && p->parent == curproc){
801047f6:	39 73 10             	cmp    %esi,0x10(%ebx)
801047f9:	75 ed                	jne    801047e8 <detach+0x48>
801047fb:	39 7b 14             	cmp    %edi,0x14(%ebx)
801047fe:	75 e8                	jne    801047e8 <detach+0x48>
        procExist = 0;
        p->parent = initproc;
        if(p->state == ZOMBIE)
80104800:	8b 4b 0c             	mov    0xc(%ebx),%ecx
        procExist = 0;
80104803:	31 d2                	xor    %edx,%edx
        p->parent = initproc;
80104805:	a1 c8 c5 10 80       	mov    0x8010c5c8,%eax
        if(p->state == ZOMBIE)
8010480a:	83 f9 05             	cmp    $0x5,%ecx
        p->parent = initproc;
8010480d:	89 43 14             	mov    %eax,0x14(%ebx)
        if(p->state == ZOMBIE)
80104810:	75 d6                	jne    801047e8 <detach+0x48>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104812:	81 c3 98 00 00 00    	add    $0x98,%ebx
80104818:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            wakeup1(initproc);
8010481b:	e8 e0 f5 ff ff       	call   80103e00 <wakeup1>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104820:	81 fb d4 73 11 80    	cmp    $0x801173d4,%ebx
            wakeup1(initproc);
80104826:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104829:	72 cb                	jb     801047f6 <detach+0x56>
    }
  }
  release(&ptable.lock);
8010482b:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104832:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80104835:	e8 56 13 00 00       	call   80105b90 <release>
  return procExist;
}
8010483a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010483d:	83 c4 2c             	add    $0x2c,%esp
80104840:	5b                   	pop    %ebx
80104841:	5e                   	pop    %esi
80104842:	89 d0                	mov    %edx,%eax
80104844:	5f                   	pop    %edi
80104845:	5d                   	pop    %ebp
80104846:	c3                   	ret    
    panic("init called detach");
80104847:	c7 04 24 50 8e 10 80 	movl   $0x80108e50,(%esp)
8010484e:	e8 1d bb ff ff       	call   80100370 <panic>
80104853:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104860 <priority>:

// used by a process to change its priority
void
priority(int proc_priority)
{
80104860:	55                   	push   %ebp
80104861:	89 e5                	mov    %esp,%ebp
80104863:	83 ec 18             	sub    $0x18,%esp
80104866:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104869:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010486c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  pushcli();
8010486f:	e8 9c 11 00 00       	call   80105a10 <pushcli>
  c = mycpu();
80104874:	e8 87 f0 ff ff       	call   80103900 <mycpu>
  p = c->proc;
80104879:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
8010487f:	e8 cc 11 00 00       	call   80105a50 <popcli>
  struct proc *curproc = myproc();
  
  if(proc_priority <= 10 && proc_priority >= 0){
80104884:	83 fb 0a             	cmp    $0xa,%ebx
80104887:	77 13                	ja     8010489c <priority+0x3c>
      if(POLICY == 3 || (POLICY == 2 && proc_priority >= 1)){
80104889:	a1 08 c0 10 80       	mov    0x8010c008,%eax
8010488e:	83 f8 03             	cmp    $0x3,%eax
80104891:	74 1d                	je     801048b0 <priority+0x50>
80104893:	83 f8 02             	cmp    $0x2,%eax
80104896:	75 04                	jne    8010489c <priority+0x3c>
80104898:	85 db                	test   %ebx,%ebx
8010489a:	75 14                	jne    801048b0 <priority+0x50>
        acquire(&ptable.lock);
        curproc->priority = proc_priority;
        release(&ptable.lock); 
      }
  }
}
8010489c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010489f:	8b 75 fc             	mov    -0x4(%ebp),%esi
801048a2:	89 ec                	mov    %ebp,%esp
801048a4:	5d                   	pop    %ebp
801048a5:	c3                   	ret    
801048a6:	8d 76 00             	lea    0x0(%esi),%esi
801048a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        acquire(&ptable.lock);
801048b0:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
801048b7:	e8 34 12 00 00       	call   80105af0 <acquire>
        curproc->priority = proc_priority;
801048bc:	89 9e 80 00 00 00    	mov    %ebx,0x80(%esi)
}
801048c2:	8b 5d f8             	mov    -0x8(%ebp),%ebx
        release(&ptable.lock); 
801048c5:	c7 45 08 a0 4d 11 80 	movl   $0x80114da0,0x8(%ebp)
}
801048cc:	8b 75 fc             	mov    -0x4(%ebp),%esi
801048cf:	89 ec                	mov    %ebp,%esp
801048d1:	5d                   	pop    %ebp
        release(&ptable.lock); 
801048d2:	e9 b9 12 00 00       	jmp    80105b90 <release>
801048d7:	89 f6                	mov    %esi,%esi
801048d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048e0 <policy>:

// receives a policy identifier as an argument and changes the currently used policy.
void
policy(int policy_id)
{
801048e0:	55                   	push   %ebp
801048e1:	89 e5                	mov    %esp,%ebp
801048e3:	56                   	push   %esi
801048e4:	53                   	push   %ebx
    struct proc *p;
    
    acquire(&ptable.lock);
           
    
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048e5:	bb d4 4d 11 80       	mov    $0x80114dd4,%ebx
{
801048ea:	83 ec 10             	sub    $0x10,%esp
    acquire(&ptable.lock);
801048ed:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
{
801048f4:	8b 75 08             	mov    0x8(%ebp),%esi
    acquire(&ptable.lock);
801048f7:	e8 f4 11 00 00       	call   80105af0 <acquire>
801048fc:	eb 29                	jmp    80104927 <policy+0x47>
801048fe:	66 90                	xchg   %ax,%ax
        if(policy_id == 1 && (POLICY == 2 || POLICY == 3)){ /*change from Priority to Round Robin policy*/
            pq.switchToRoundRobinPolicy();
            p->accumulator = 0;
        }
        if(policy_id == 2){ 
80104900:	83 fe 02             	cmp    $0x2,%esi
80104903:	74 73                	je     80104978 <policy+0x98>
            }
            if(POLICY == 1){ /*change from Round Robin to Priority scheduling policy*/
                rrq.switchToPriorityQueuePolicy();
            }
        }
        if(policy_id == 3 && POLICY == 1){ /*change from Extended Priority to Round Robin policy*/
80104905:	83 fe 03             	cmp    $0x3,%esi
80104908:	75 0f                	jne    80104919 <policy+0x39>
8010490a:	83 3d 08 c0 10 80 01 	cmpl   $0x1,0x8010c008
80104911:	75 06                	jne    80104919 <policy+0x39>
            pq.switchToRoundRobinPolicy();
80104913:	ff 15 fc c5 10 80    	call   *0x8010c5fc
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104919:	81 c3 98 00 00 00    	add    $0x98,%ebx
8010491f:	81 fb d4 73 11 80    	cmp    $0x801173d4,%ebx
80104925:	73 33                	jae    8010495a <policy+0x7a>
        if(policy_id == 1 && (POLICY == 2 || POLICY == 3)){ /*change from Priority to Round Robin policy*/
80104927:	83 fe 01             	cmp    $0x1,%esi
8010492a:	75 d4                	jne    80104900 <policy+0x20>
8010492c:	a1 08 c0 10 80       	mov    0x8010c008,%eax
80104931:	83 e8 02             	sub    $0x2,%eax
80104934:	83 f8 01             	cmp    $0x1,%eax
80104937:	77 e0                	ja     80104919 <policy+0x39>
            pq.switchToRoundRobinPolicy();
80104939:	ff 15 fc c5 10 80    	call   *0x8010c5fc
            p->accumulator = 0;
8010493f:	31 c9                	xor    %ecx,%ecx
80104941:	31 c0                	xor    %eax,%eax
80104943:	89 8b 84 00 00 00    	mov    %ecx,0x84(%ebx)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104949:	81 c3 98 00 00 00    	add    $0x98,%ebx
            p->accumulator = 0;
8010494f:	89 43 f0             	mov    %eax,-0x10(%ebx)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104952:	81 fb d4 73 11 80    	cmp    $0x801173d4,%ebx
80104958:	72 cd                	jb     80104927 <policy+0x47>
        }
    }
     POLICY = policy_id;
8010495a:	89 35 08 c0 10 80    	mov    %esi,0x8010c008
     release(&ptable.lock);
80104960:	c7 45 08 a0 4d 11 80 	movl   $0x80114da0,0x8(%ebp)
}
80104967:	83 c4 10             	add    $0x10,%esp
8010496a:	5b                   	pop    %ebx
8010496b:	5e                   	pop    %esi
8010496c:	5d                   	pop    %ebp
     release(&ptable.lock);
8010496d:	e9 1e 12 00 00       	jmp    80105b90 <release>
80104972:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            if(POLICY == 3){ /*change from Extended Priority to Priority scheduling policy*/
80104978:	a1 08 c0 10 80       	mov    0x8010c008,%eax
8010497d:	83 f8 03             	cmp    $0x3,%eax
80104980:	74 16                	je     80104998 <policy+0xb8>
            if(POLICY == 1){ /*change from Round Robin to Priority scheduling policy*/
80104982:	48                   	dec    %eax
80104983:	75 94                	jne    80104919 <policy+0x39>
                rrq.switchToPriorityQueuePolicy();
80104985:	ff 15 e8 c5 10 80    	call   *0x8010c5e8
8010498b:	90                   	nop
8010498c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104990:	eb 87                	jmp    80104919 <policy+0x39>
80104992:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                if(p->priority == 0){ 
80104998:	8b 93 80 00 00 00    	mov    0x80(%ebx),%edx
8010499e:	85 d2                	test   %edx,%edx
801049a0:	0f 85 73 ff ff ff    	jne    80104919 <policy+0x39>
                    p->priority = 1;
801049a6:	b8 01 00 00 00       	mov    $0x1,%eax
801049ab:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
801049b1:	e9 63 ff ff ff       	jmp    80104919 <policy+0x39>
801049b6:	8d 76 00             	lea    0x0(%esi),%esi
801049b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049c0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801049c0:	55                   	push   %ebp
801049c1:	89 e5                	mov    %esp,%ebp
801049c3:	57                   	push   %edi
801049c4:	56                   	push   %esi
801049c5:	53                   	push   %ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049c6:	bb d4 4d 11 80       	mov    $0x80114dd4,%ebx
{
801049cb:	83 ec 4c             	sub    $0x4c,%esp
801049ce:	eb 1e                	jmp    801049ee <procdump+0x2e>
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801049d0:	c7 04 24 ed 8e 10 80 	movl   $0x80108eed,(%esp)
801049d7:	e8 74 bc ff ff       	call   80100650 <cprintf>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049dc:	81 c3 98 00 00 00    	add    $0x98,%ebx
801049e2:	81 fb d4 73 11 80    	cmp    $0x801173d4,%ebx
801049e8:	0f 83 b2 00 00 00    	jae    80104aa0 <procdump+0xe0>
    if(p->state == UNUSED)
801049ee:	8b 43 0c             	mov    0xc(%ebx),%eax
801049f1:	85 c0                	test   %eax,%eax
801049f3:	74 e7                	je     801049dc <procdump+0x1c>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801049f5:	8b 43 0c             	mov    0xc(%ebx),%eax
      state = "???";
801049f8:	b8 63 8e 10 80       	mov    $0x80108e63,%eax
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801049fd:	8b 53 0c             	mov    0xc(%ebx),%edx
80104a00:	83 fa 05             	cmp    $0x5,%edx
80104a03:	77 18                	ja     80104a1d <procdump+0x5d>
80104a05:	8b 53 0c             	mov    0xc(%ebx),%edx
80104a08:	8b 14 95 c4 8e 10 80 	mov    -0x7fef713c(,%edx,4),%edx
80104a0f:	85 d2                	test   %edx,%edx
80104a11:	74 0a                	je     80104a1d <procdump+0x5d>
      state = states[p->state];
80104a13:	8b 43 0c             	mov    0xc(%ebx),%eax
80104a16:	8b 04 85 c4 8e 10 80 	mov    -0x7fef713c(,%eax,4),%eax
    cprintf("%d %s %s", p->pid, state, p->name);
80104a1d:	89 44 24 08          	mov    %eax,0x8(%esp)
80104a21:	8b 43 10             	mov    0x10(%ebx),%eax
80104a24:	8d 53 6c             	lea    0x6c(%ebx),%edx
80104a27:	89 54 24 0c          	mov    %edx,0xc(%esp)
80104a2b:	c7 04 24 67 8e 10 80 	movl   $0x80108e67,(%esp)
80104a32:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a36:	e8 15 bc ff ff       	call   80100650 <cprintf>
    if(p->state == SLEEPING){
80104a3b:	8b 43 0c             	mov    0xc(%ebx),%eax
80104a3e:	83 f8 02             	cmp    $0x2,%eax
80104a41:	75 8d                	jne    801049d0 <procdump+0x10>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104a43:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104a46:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a4a:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104a4d:	8d 75 c0             	lea    -0x40(%ebp),%esi
80104a50:	8d 7d e8             	lea    -0x18(%ebp),%edi
80104a53:	8b 40 0c             	mov    0xc(%eax),%eax
80104a56:	83 c0 08             	add    $0x8,%eax
80104a59:	89 04 24             	mov    %eax,(%esp)
80104a5c:	e8 5f 0f 00 00       	call   801059c0 <getcallerpcs>
80104a61:	eb 0d                	jmp    80104a70 <procdump+0xb0>
80104a63:	90                   	nop
80104a64:	90                   	nop
80104a65:	90                   	nop
80104a66:	90                   	nop
80104a67:	90                   	nop
80104a68:	90                   	nop
80104a69:	90                   	nop
80104a6a:	90                   	nop
80104a6b:	90                   	nop
80104a6c:	90                   	nop
80104a6d:	90                   	nop
80104a6e:	90                   	nop
80104a6f:	90                   	nop
      for(i=0; i<10 && pc[i] != 0; i++)
80104a70:	8b 16                	mov    (%esi),%edx
80104a72:	85 d2                	test   %edx,%edx
80104a74:	0f 84 56 ff ff ff    	je     801049d0 <procdump+0x10>
        cprintf(" %p", pc[i]);
80104a7a:	89 54 24 04          	mov    %edx,0x4(%esp)
80104a7e:	83 c6 04             	add    $0x4,%esi
80104a81:	c7 04 24 41 88 10 80 	movl   $0x80108841,(%esp)
80104a88:	e8 c3 bb ff ff       	call   80100650 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104a8d:	39 f7                	cmp    %esi,%edi
80104a8f:	75 df                	jne    80104a70 <procdump+0xb0>
80104a91:	e9 3a ff ff ff       	jmp    801049d0 <procdump+0x10>
80104a96:	8d 76 00             	lea    0x0(%esi),%esi
80104a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }
}
80104aa0:	83 c4 4c             	add    $0x4c,%esp
80104aa3:	5b                   	pop    %ebx
80104aa4:	5e                   	pop    %esi
80104aa5:	5f                   	pop    %edi
80104aa6:	5d                   	pop    %ebp
80104aa7:	c3                   	ret    
80104aa8:	90                   	nop
80104aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104ab0 <wait_stat>:

// Return the pidof the terminated child process or -1 upon failure.
int
wait_stat(int* status, struct perf * performance){
80104ab0:	55                   	push   %ebp
80104ab1:	89 e5                	mov    %esp,%ebp
80104ab3:	53                   	push   %ebx
80104ab4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104ab7:	e8 54 0f 00 00       	call   80105a10 <pushcli>
  c = mycpu();
80104abc:	e8 3f ee ff ff       	call   80103900 <mycpu>
  p = c->proc;
80104ac1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104ac7:	e8 84 0f 00 00       	call   80105a50 <popcli>
      struct proc *curproc = myproc();
      
      if (!curproc)
80104acc:	85 db                	test   %ebx,%ebx
80104ace:	74 0f                	je     80104adf <wait_stat+0x2f>
          return -1;
      
      performance = curproc->performance;
      *status = curproc->exitStatus;
80104ad0:	8b 45 08             	mov    0x8(%ebp),%eax
80104ad3:	8b 53 7c             	mov    0x7c(%ebx),%edx
80104ad6:	89 10                	mov    %edx,(%eax)
      
      return curproc->pid;
80104ad8:	8b 43 10             	mov    0x10(%ebx),%eax
}
80104adb:	5a                   	pop    %edx
80104adc:	5b                   	pop    %ebx
80104add:	5d                   	pop    %ebp
80104ade:	c3                   	ret    
          return -1;
80104adf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ae4:	eb f5                	jmp    80104adb <wait_stat+0x2b>
80104ae6:	8d 76 00             	lea    0x0(%esi),%esi
80104ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104af0 <updatePerformance>:

// increments performence to all proccesses that are running or sleeping
void updatePerformance(){
80104af0:	55                   	push   %ebp
80104af1:	89 e5                	mov    %esp,%ebp
80104af3:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  acquire(&ptable.lock);
80104af6:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104afd:	e8 ee 0f 00 00       	call   80105af0 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b02:	b8 d4 4d 11 80       	mov    $0x80114dd4,%eax
80104b07:	89 f6                	mov    %esi,%esi
80104b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(p->state == RUNNABLE){
80104b10:	8b 50 0c             	mov    0xc(%eax),%edx
80104b13:	83 fa 03             	cmp    $0x3,%edx
80104b16:	75 09                	jne    80104b21 <updatePerformance+0x31>
        p->performance->retime++;
80104b18:	8b 90 94 00 00 00    	mov    0x94(%eax),%edx
80104b1e:	ff 42 0c             	incl   0xc(%edx)
    }
    if(p->state == RUNNING){
80104b21:	8b 50 0c             	mov    0xc(%eax),%edx
80104b24:	83 fa 04             	cmp    $0x4,%edx
80104b27:	75 09                	jne    80104b32 <updatePerformance+0x42>
      p->performance->rutime++;
80104b29:	8b 90 94 00 00 00    	mov    0x94(%eax),%edx
80104b2f:	ff 42 10             	incl   0x10(%edx)
    }
    if(p->state == SLEEPING){
80104b32:	8b 50 0c             	mov    0xc(%eax),%edx
80104b35:	83 fa 02             	cmp    $0x2,%edx
80104b38:	75 09                	jne    80104b43 <updatePerformance+0x53>
      p->performance->stime++;
80104b3a:	8b 90 94 00 00 00    	mov    0x94(%eax),%edx
80104b40:	ff 42 08             	incl   0x8(%edx)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b43:	05 98 00 00 00       	add    $0x98,%eax
80104b48:	3d d4 73 11 80       	cmp    $0x801173d4,%eax
80104b4d:	72 c1                	jb     80104b10 <updatePerformance+0x20>
    }
  }
  release(&ptable.lock);
80104b4f:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80104b56:	e8 35 10 00 00       	call   80105b90 <release>
}
80104b5b:	c9                   	leave  
80104b5c:	c3                   	ret    
80104b5d:	66 90                	xchg   %ax,%ax
80104b5f:	90                   	nop

80104b60 <isEmptyPriorityQueue>:
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
80104b60:	a1 1c c6 10 80       	mov    0x8010c61c,%eax
static boolean isEmptyPriorityQueue() {
80104b65:	55                   	push   %ebp
80104b66:	89 e5                	mov    %esp,%ebp
}
80104b68:	5d                   	pop    %ebp
	return !root;
80104b69:	8b 00                	mov    (%eax),%eax
80104b6b:	85 c0                	test   %eax,%eax
80104b6d:	0f 94 c0             	sete   %al
80104b70:	0f b6 c0             	movzbl %al,%eax
}
80104b73:	c3                   	ret    
80104b74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104b80 <getMinAccumulatorPriorityQueue>:
	return !root;
80104b80:	a1 1c c6 10 80       	mov    0x8010c61c,%eax
80104b85:	8b 10                	mov    (%eax),%edx
	
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
	if(isEmpty())
80104b87:	85 d2                	test   %edx,%edx
80104b89:	74 35                	je     80104bc0 <getMinAccumulatorPriorityQueue+0x40>
static boolean getMinAccumulatorPriorityQueue(long long* pkey) {
80104b8b:	55                   	push   %ebp
80104b8c:	89 e5                	mov    %esp,%ebp
80104b8e:	53                   	push   %ebx
80104b8f:	eb 09                	jmp    80104b9a <getMinAccumulatorPriorityQueue+0x1a>
80104b91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	while(minNode->left)
80104b98:	89 c2                	mov    %eax,%edx
80104b9a:	8b 42 18             	mov    0x18(%edx),%eax
80104b9d:	85 c0                	test   %eax,%eax
80104b9f:	75 f7                	jne    80104b98 <getMinAccumulatorPriorityQueue+0x18>
	*pkey = getMinNode()->key;
80104ba1:	8b 45 08             	mov    0x8(%ebp),%eax
80104ba4:	8b 5a 04             	mov    0x4(%edx),%ebx
80104ba7:	8b 0a                	mov    (%edx),%ecx
80104ba9:	89 58 04             	mov    %ebx,0x4(%eax)
80104bac:	89 08                	mov    %ecx,(%eax)
80104bae:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104bb3:	5b                   	pop    %ebx
80104bb4:	5d                   	pop    %ebp
80104bb5:	c3                   	ret    
80104bb6:	8d 76 00             	lea    0x0(%esi),%esi
80104bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	if(isEmpty())
80104bc0:	31 c0                	xor    %eax,%eax
}
80104bc2:	c3                   	ret    
80104bc3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104bd0 <isEmptyRoundRobinQueue>:
	return !first;
80104bd0:	a1 18 c6 10 80       	mov    0x8010c618,%eax
static boolean isEmptyRoundRobinQueue() {
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

80104bf0 <enqueueRoundRobinQueue>:
	if(!freeLinks)
80104bf0:	a1 10 c6 10 80       	mov    0x8010c610,%eax
80104bf5:	85 c0                	test   %eax,%eax
80104bf7:	74 47                	je     80104c40 <enqueueRoundRobinQueue+0x50>
static boolean enqueueRoundRobinQueue(Proc *p) {
80104bf9:	55                   	push   %ebp
	return roundRobinQ->enqueue(p);
80104bfa:	8b 0d 18 c6 10 80    	mov    0x8010c618,%ecx
	freeLinks = freeLinks->next;
80104c00:	8b 50 04             	mov    0x4(%eax),%edx
static boolean enqueueRoundRobinQueue(Proc *p) {
80104c03:	89 e5                	mov    %esp,%ebp
	ans->next = null;
80104c05:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
80104c0c:	89 15 10 c6 10 80    	mov    %edx,0x8010c610
	ans->p = p;
80104c12:	8b 55 08             	mov    0x8(%ebp),%edx
80104c15:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80104c17:	8b 11                	mov    (%ecx),%edx
80104c19:	85 d2                	test   %edx,%edx
80104c1b:	74 2b                	je     80104c48 <enqueueRoundRobinQueue+0x58>
	else last->next = link;
80104c1d:	8b 51 04             	mov    0x4(%ecx),%edx
80104c20:	89 42 04             	mov    %eax,0x4(%edx)
80104c23:	eb 05                	jmp    80104c2a <enqueueRoundRobinQueue+0x3a>
80104c25:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
80104c28:	89 d0                	mov    %edx,%eax
80104c2a:	8b 50 04             	mov    0x4(%eax),%edx
80104c2d:	85 d2                	test   %edx,%edx
80104c2f:	75 f7                	jne    80104c28 <enqueueRoundRobinQueue+0x38>
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
80104c4a:	eb de                	jmp    80104c2a <enqueueRoundRobinQueue+0x3a>
80104c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c50 <dequeueRoundRobinQueue>:
	return roundRobinQ->dequeue();
80104c50:	8b 0d 18 c6 10 80    	mov    0x8010c618,%ecx
	return !first;
80104c56:	8b 11                	mov    (%ecx),%edx
	if(isEmpty())
80104c58:	85 d2                	test   %edx,%edx
80104c5a:	74 3c                	je     80104c98 <dequeueRoundRobinQueue+0x48>
static Proc* dequeueRoundRobinQueue() {
80104c5c:	55                   	push   %ebp
80104c5d:	89 e5                	mov    %esp,%ebp
80104c5f:	83 ec 08             	sub    $0x8,%esp
80104c62:	89 75 fc             	mov    %esi,-0x4(%ebp)
	link->next = freeLinks;
80104c65:	8b 35 10 c6 10 80    	mov    0x8010c610,%esi
static Proc* dequeueRoundRobinQueue() {
80104c6b:	89 5d f8             	mov    %ebx,-0x8(%ebp)
	Link *next = first->next;
80104c6e:	8b 5a 04             	mov    0x4(%edx),%ebx
	Proc *p = first->p;
80104c71:	8b 02                	mov    (%edx),%eax
	link->next = freeLinks;
80104c73:	89 72 04             	mov    %esi,0x4(%edx)
	freeLinks = link;
80104c76:	89 15 10 c6 10 80    	mov    %edx,0x8010c610
	if(isEmpty())
80104c7c:	85 db                	test   %ebx,%ebx
	first = next;
80104c7e:	89 19                	mov    %ebx,(%ecx)
	if(isEmpty())
80104c80:	75 07                	jne    80104c89 <dequeueRoundRobinQueue+0x39>
		last = null;
80104c82:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
}
80104c89:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104c8c:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104c8f:	89 ec                	mov    %ebp,%esp
80104c91:	5d                   	pop    %ebp
80104c92:	c3                   	ret    
80104c93:	90                   	nop
80104c94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		return null;
80104c98:	31 c0                	xor    %eax,%eax
}
80104c9a:	c3                   	ret    
80104c9b:	90                   	nop
80104c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ca0 <isEmptyRunningProcessHolder>:
	return !first;
80104ca0:	a1 14 c6 10 80       	mov    0x8010c614,%eax
static boolean isEmptyRunningProcessHolder() {
80104ca5:	55                   	push   %ebp
80104ca6:	89 e5                	mov    %esp,%ebp
}
80104ca8:	5d                   	pop    %ebp
	return !first;
80104ca9:	8b 00                	mov    (%eax),%eax
80104cab:	85 c0                	test   %eax,%eax
80104cad:	0f 94 c0             	sete   %al
80104cb0:	0f b6 c0             	movzbl %al,%eax
}
80104cb3:	c3                   	ret    
80104cb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104cba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104cc0 <addRunningProcessHolder>:
	if(!freeLinks)
80104cc0:	a1 10 c6 10 80       	mov    0x8010c610,%eax
80104cc5:	85 c0                	test   %eax,%eax
80104cc7:	74 47                	je     80104d10 <addRunningProcessHolder+0x50>
static boolean addRunningProcessHolder(Proc* p) {
80104cc9:	55                   	push   %ebp
	return runningProcHolder->enqueue(p);
80104cca:	8b 0d 14 c6 10 80    	mov    0x8010c614,%ecx
	freeLinks = freeLinks->next;
80104cd0:	8b 50 04             	mov    0x4(%eax),%edx
static boolean addRunningProcessHolder(Proc* p) {
80104cd3:	89 e5                	mov    %esp,%ebp
	ans->next = null;
80104cd5:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
80104cdc:	89 15 10 c6 10 80    	mov    %edx,0x8010c610
	ans->p = p;
80104ce2:	8b 55 08             	mov    0x8(%ebp),%edx
80104ce5:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80104ce7:	8b 11                	mov    (%ecx),%edx
80104ce9:	85 d2                	test   %edx,%edx
80104ceb:	74 2b                	je     80104d18 <addRunningProcessHolder+0x58>
	else last->next = link;
80104ced:	8b 51 04             	mov    0x4(%ecx),%edx
80104cf0:	89 42 04             	mov    %eax,0x4(%edx)
80104cf3:	eb 05                	jmp    80104cfa <addRunningProcessHolder+0x3a>
80104cf5:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
80104cf8:	89 d0                	mov    %edx,%eax
80104cfa:	8b 50 04             	mov    0x4(%eax),%edx
80104cfd:	85 d2                	test   %edx,%edx
80104cff:	75 f7                	jne    80104cf8 <addRunningProcessHolder+0x38>
	last = link->getLast();
80104d01:	89 41 04             	mov    %eax,0x4(%ecx)
80104d04:	b8 01 00 00 00       	mov    $0x1,%eax
}
80104d09:	5d                   	pop    %ebp
80104d0a:	c3                   	ret    
80104d0b:	90                   	nop
80104d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!freeLinks)
80104d10:	31 c0                	xor    %eax,%eax
}
80104d12:	c3                   	ret    
80104d13:	90                   	nop
80104d14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
80104d18:	89 01                	mov    %eax,(%ecx)
80104d1a:	eb de                	jmp    80104cfa <addRunningProcessHolder+0x3a>
80104d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104d20 <_ZL9allocNodeP4procx>:
static MapNode* allocNode(Proc *p, long long key) {
80104d20:	55                   	push   %ebp
80104d21:	89 e5                	mov    %esp,%ebp
80104d23:	56                   	push   %esi
80104d24:	53                   	push   %ebx
	if(!freeNodes)
80104d25:	8b 1d 0c c6 10 80    	mov    0x8010c60c,%ebx
80104d2b:	85 db                	test   %ebx,%ebx
80104d2d:	74 4d                	je     80104d7c <_ZL9allocNodeP4procx+0x5c>
	ans->key = key;
80104d2f:	89 13                	mov    %edx,(%ebx)
	if(!freeLinks)
80104d31:	8b 15 10 c6 10 80    	mov    0x8010c610,%edx
	freeNodes = freeNodes->next;
80104d37:	8b 73 10             	mov    0x10(%ebx),%esi
	ans->key = key;
80104d3a:	89 4b 04             	mov    %ecx,0x4(%ebx)
	ans->next = null;
80104d3d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
	if(!freeLinks)
80104d44:	85 d2                	test   %edx,%edx
	freeNodes = freeNodes->next;
80104d46:	89 35 0c c6 10 80    	mov    %esi,0x8010c60c
	if(!freeLinks)
80104d4c:	74 3f                	je     80104d8d <_ZL9allocNodeP4procx+0x6d>
	freeLinks = freeLinks->next;
80104d4e:	8b 4a 04             	mov    0x4(%edx),%ecx
	ans->p = p;
80104d51:	89 02                	mov    %eax,(%edx)
	ans->next = null;
80104d53:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
	if(isEmpty()) first = link;
80104d5a:	8b 43 08             	mov    0x8(%ebx),%eax
	freeLinks = freeLinks->next;
80104d5d:	89 0d 10 c6 10 80    	mov    %ecx,0x8010c610
	if(isEmpty()) first = link;
80104d63:	85 c0                	test   %eax,%eax
80104d65:	74 21                	je     80104d88 <_ZL9allocNodeP4procx+0x68>
	else last->next = link;
80104d67:	8b 43 0c             	mov    0xc(%ebx),%eax
80104d6a:	89 50 04             	mov    %edx,0x4(%eax)
80104d6d:	eb 03                	jmp    80104d72 <_ZL9allocNodeP4procx+0x52>
80104d6f:	90                   	nop
	while(ans->next)
80104d70:	89 ca                	mov    %ecx,%edx
80104d72:	8b 4a 04             	mov    0x4(%edx),%ecx
80104d75:	85 c9                	test   %ecx,%ecx
80104d77:	75 f7                	jne    80104d70 <_ZL9allocNodeP4procx+0x50>
	last = link->getLast();
80104d79:	89 53 0c             	mov    %edx,0xc(%ebx)
}
80104d7c:	89 d8                	mov    %ebx,%eax
80104d7e:	5b                   	pop    %ebx
80104d7f:	5e                   	pop    %esi
80104d80:	5d                   	pop    %ebp
80104d81:	c3                   	ret    
80104d82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	if(isEmpty()) first = link;
80104d88:	89 53 08             	mov    %edx,0x8(%ebx)
80104d8b:	eb e5                	jmp    80104d72 <_ZL9allocNodeP4procx+0x52>
	node->parent = node->left = node->right = null;
80104d8d:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
80104d94:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
80104d9b:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
	node->next = freeNodes;
80104da2:	89 73 10             	mov    %esi,0x10(%ebx)
	freeNodes = node;
80104da5:	89 1d 0c c6 10 80    	mov    %ebx,0x8010c60c
		return null;
80104dab:	31 db                	xor    %ebx,%ebx
80104dad:	eb cd                	jmp    80104d7c <_ZL9allocNodeP4procx+0x5c>
80104daf:	90                   	nop

80104db0 <_ZL8mymallocj>:
static char* mymalloc(uint size) {
80104db0:	55                   	push   %ebp
80104db1:	89 e5                	mov    %esp,%ebp
80104db3:	53                   	push   %ebx
80104db4:	89 c3                	mov    %eax,%ebx
80104db6:	83 ec 14             	sub    $0x14,%esp
	if(spaceLeft < size) {
80104db9:	8b 15 04 c6 10 80    	mov    0x8010c604,%edx
80104dbf:	39 c2                	cmp    %eax,%edx
80104dc1:	73 26                	jae    80104de9 <_ZL8mymallocj+0x39>
		data = kalloc();
80104dc3:	e8 e8 d7 ff ff       	call   801025b0 <kalloc>
		memset(data, 0, PGSIZE);
80104dc8:	ba 00 10 00 00       	mov    $0x1000,%edx
80104dcd:	31 c9                	xor    %ecx,%ecx
80104dcf:	89 54 24 08          	mov    %edx,0x8(%esp)
80104dd3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80104dd7:	89 04 24             	mov    %eax,(%esp)
		data = kalloc();
80104dda:	a3 08 c6 10 80       	mov    %eax,0x8010c608
		memset(data, 0, PGSIZE);
80104ddf:	e8 fc 0d 00 00       	call   80105be0 <memset>
80104de4:	ba 00 10 00 00       	mov    $0x1000,%edx
	char* ans = data;
80104de9:	a1 08 c6 10 80       	mov    0x8010c608,%eax
	spaceLeft -= size;
80104dee:	29 da                	sub    %ebx,%edx
80104df0:	89 15 04 c6 10 80    	mov    %edx,0x8010c604
	data += size;
80104df6:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80104df9:	89 0d 08 c6 10 80    	mov    %ecx,0x8010c608
}
80104dff:	83 c4 14             	add    $0x14,%esp
80104e02:	5b                   	pop    %ebx
80104e03:	5d                   	pop    %ebp
80104e04:	c3                   	ret    
80104e05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e10 <initSchedDS>:
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104e10:	55                   	push   %ebp
	data               = null;
80104e11:	31 c0                	xor    %eax,%eax
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104e13:	89 e5                	mov    %esp,%ebp
80104e15:	53                   	push   %ebx
	freeLinks = null;
80104e16:	bb 80 00 00 00       	mov    $0x80,%ebx
void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104e1b:	83 ec 04             	sub    $0x4,%esp
	data               = null;
80104e1e:	a3 08 c6 10 80       	mov    %eax,0x8010c608
	spaceLeft          = 0u;
80104e23:	31 c0                	xor    %eax,%eax
80104e25:	a3 04 c6 10 80       	mov    %eax,0x8010c604
	priorityQ          = (Map*)mymalloc(sizeof(Map));
80104e2a:	b8 04 00 00 00       	mov    $0x4,%eax
80104e2f:	e8 7c ff ff ff       	call   80104db0 <_ZL8mymallocj>
80104e34:	a3 1c c6 10 80       	mov    %eax,0x8010c61c
	*priorityQ         = Map();
80104e39:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	roundRobinQ        = (LinkedList*)mymalloc(sizeof(LinkedList));
80104e3f:	b8 08 00 00 00       	mov    $0x8,%eax
80104e44:	e8 67 ff ff ff       	call   80104db0 <_ZL8mymallocj>
80104e49:	a3 18 c6 10 80       	mov    %eax,0x8010c618
	*roundRobinQ       = LinkedList();
80104e4e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104e54:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	runningProcHolder  = (LinkedList*)mymalloc(sizeof(LinkedList));
80104e5b:	b8 08 00 00 00       	mov    $0x8,%eax
80104e60:	e8 4b ff ff ff       	call   80104db0 <_ZL8mymallocj>
80104e65:	a3 14 c6 10 80       	mov    %eax,0x8010c614
	*runningProcHolder = LinkedList();
80104e6a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104e70:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = null;
80104e77:	31 c0                	xor    %eax,%eax
80104e79:	a3 10 c6 10 80       	mov    %eax,0x8010c610
80104e7e:	66 90                	xchg   %ax,%ax
		Link *link = (Link*)mymalloc(sizeof(Link));
80104e80:	b8 08 00 00 00       	mov    $0x8,%eax
80104e85:	e8 26 ff ff ff       	call   80104db0 <_ZL8mymallocj>
		link->next = freeLinks;
80104e8a:	8b 15 10 c6 10 80    	mov    0x8010c610,%edx
	for(int i = 0; i < NPROCLIST; ++i) {
80104e90:	4b                   	dec    %ebx
		*link = Link();
80104e91:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		link->next = freeLinks;
80104e97:	89 50 04             	mov    %edx,0x4(%eax)
		freeLinks = link;
80104e9a:	a3 10 c6 10 80       	mov    %eax,0x8010c610
	for(int i = 0; i < NPROCLIST; ++i) {
80104e9f:	75 df                	jne    80104e80 <initSchedDS+0x70>
	freeNodes = null;
80104ea1:	31 c0                	xor    %eax,%eax
80104ea3:	bb 80 00 00 00       	mov    $0x80,%ebx
80104ea8:	a3 0c c6 10 80       	mov    %eax,0x8010c60c
80104ead:	8d 76 00             	lea    0x0(%esi),%esi
		MapNode *node = (MapNode*)mymalloc(sizeof(MapNode));
80104eb0:	b8 20 00 00 00       	mov    $0x20,%eax
80104eb5:	e8 f6 fe ff ff       	call   80104db0 <_ZL8mymallocj>
		node->next = freeNodes;
80104eba:	8b 15 0c c6 10 80    	mov    0x8010c60c,%edx
	for(int i = 0; i < NPROCMAP; ++i) {
80104ec0:	4b                   	dec    %ebx
		*node = MapNode();
80104ec1:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80104ec8:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
80104ecf:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
80104ed6:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
80104edd:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
		node->next = freeNodes;
80104ee4:	89 50 10             	mov    %edx,0x10(%eax)
		freeNodes = node;
80104ee7:	a3 0c c6 10 80       	mov    %eax,0x8010c60c
	for(int i = 0; i < NPROCMAP; ++i) {
80104eec:	75 c2                	jne    80104eb0 <initSchedDS+0xa0>
	pq.isEmpty                      = isEmptyPriorityQueue;
80104eee:	b8 60 4b 10 80       	mov    $0x80104b60,%eax
	pq.put                          = putPriorityQueue;
80104ef3:	ba e0 54 10 80       	mov    $0x801054e0,%edx
	pq.isEmpty                      = isEmptyPriorityQueue;
80104ef8:	a3 ec c5 10 80       	mov    %eax,0x8010c5ec
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
80104efd:	b8 a0 56 10 80       	mov    $0x801056a0,%eax
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
80104f02:	b9 80 4b 10 80       	mov    $0x80104b80,%ecx
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
80104f07:	a3 fc c5 10 80       	mov    %eax,0x8010c5fc
	pq.extractProc                  = extractProcPriorityQueue;
80104f0c:	b8 80 57 10 80       	mov    $0x80105780,%eax
	pq.extractMin                   = extractMinPriorityQueue;
80104f11:	bb 00 56 10 80       	mov    $0x80105600,%ebx
	pq.extractProc                  = extractProcPriorityQueue;
80104f16:	a3 00 c6 10 80       	mov    %eax,0x8010c600
	rrq.isEmpty                     = isEmptyRoundRobinQueue;
80104f1b:	b8 d0 4b 10 80       	mov    $0x80104bd0,%eax
80104f20:	a3 dc c5 10 80       	mov    %eax,0x8010c5dc
	rrq.enqueue                     = enqueueRoundRobinQueue;
80104f25:	b8 f0 4b 10 80       	mov    $0x80104bf0,%eax
80104f2a:	a3 e0 c5 10 80       	mov    %eax,0x8010c5e0
	rrq.dequeue                     = dequeueRoundRobinQueue;
80104f2f:	b8 50 4c 10 80       	mov    $0x80104c50,%eax
80104f34:	a3 e4 c5 10 80       	mov    %eax,0x8010c5e4
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
80104f39:	b8 10 52 10 80       	mov    $0x80105210,%eax
	pq.put                          = putPriorityQueue;
80104f3e:	89 15 f0 c5 10 80    	mov    %edx,0x8010c5f0
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
80104f44:	ba a0 4c 10 80       	mov    $0x80104ca0,%edx
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
80104f49:	89 0d f4 c5 10 80    	mov    %ecx,0x8010c5f4
	rpholder.add                    = addRunningProcessHolder;
80104f4f:	b9 c0 4c 10 80       	mov    $0x80104cc0,%ecx
	pq.extractMin                   = extractMinPriorityQueue;
80104f54:	89 1d f8 c5 10 80    	mov    %ebx,0x8010c5f8
	rpholder.remove                 = removeRunningProcessHolder;
80104f5a:	bb 70 51 10 80       	mov    $0x80105170,%ebx
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
80104f5f:	a3 e8 c5 10 80       	mov    %eax,0x8010c5e8
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
80104f64:	b8 a0 52 10 80       	mov    $0x801052a0,%eax
	rpholder.remove                 = removeRunningProcessHolder;
80104f69:	89 1d d4 c5 10 80    	mov    %ebx,0x8010c5d4
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
80104f6f:	89 15 cc c5 10 80    	mov    %edx,0x8010c5cc
	rpholder.add                    = addRunningProcessHolder;
80104f75:	89 0d d0 c5 10 80    	mov    %ecx,0x8010c5d0
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
80104f7b:	a3 d8 c5 10 80       	mov    %eax,0x8010c5d8
}
80104f80:	58                   	pop    %eax
80104f81:	5b                   	pop    %ebx
80104f82:	5d                   	pop    %ebp
80104f83:	c3                   	ret    
80104f84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104f90 <_ZN4Link7getLastEv>:
Link* Link::getLast() {
80104f90:	55                   	push   %ebp
80104f91:	89 e5                	mov    %esp,%ebp
80104f93:	8b 45 08             	mov    0x8(%ebp),%eax
80104f96:	eb 0a                	jmp    80104fa2 <_ZN4Link7getLastEv+0x12>
80104f98:	90                   	nop
80104f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fa0:	89 d0                	mov    %edx,%eax
	while(ans->next)
80104fa2:	8b 50 04             	mov    0x4(%eax),%edx
80104fa5:	85 d2                	test   %edx,%edx
80104fa7:	75 f7                	jne    80104fa0 <_ZN4Link7getLastEv+0x10>
}
80104fa9:	5d                   	pop    %ebp
80104faa:	c3                   	ret    
80104fab:	90                   	nop
80104fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104fb0 <_ZN10LinkedList7isEmptyEv>:
bool LinkedList::isEmpty() {
80104fb0:	55                   	push   %ebp
80104fb1:	89 e5                	mov    %esp,%ebp
	return !first;
80104fb3:	8b 45 08             	mov    0x8(%ebp),%eax
}
80104fb6:	5d                   	pop    %ebp
	return !first;
80104fb7:	8b 00                	mov    (%eax),%eax
80104fb9:	85 c0                	test   %eax,%eax
80104fbb:	0f 94 c0             	sete   %al
}
80104fbe:	c3                   	ret    
80104fbf:	90                   	nop

80104fc0 <_ZN10LinkedList6appendEP4Link>:
void LinkedList::append(Link *link) {
80104fc0:	55                   	push   %ebp
80104fc1:	89 e5                	mov    %esp,%ebp
80104fc3:	8b 55 0c             	mov    0xc(%ebp),%edx
80104fc6:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!link)
80104fc9:	85 d2                	test   %edx,%edx
80104fcb:	74 1f                	je     80104fec <_ZN10LinkedList6appendEP4Link+0x2c>
	if(isEmpty()) first = link;
80104fcd:	8b 01                	mov    (%ecx),%eax
80104fcf:	85 c0                	test   %eax,%eax
80104fd1:	74 1d                	je     80104ff0 <_ZN10LinkedList6appendEP4Link+0x30>
	else last->next = link;
80104fd3:	8b 41 04             	mov    0x4(%ecx),%eax
80104fd6:	89 50 04             	mov    %edx,0x4(%eax)
80104fd9:	eb 07                	jmp    80104fe2 <_ZN10LinkedList6appendEP4Link+0x22>
80104fdb:	90                   	nop
80104fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	while(ans->next)
80104fe0:	89 c2                	mov    %eax,%edx
80104fe2:	8b 42 04             	mov    0x4(%edx),%eax
80104fe5:	85 c0                	test   %eax,%eax
80104fe7:	75 f7                	jne    80104fe0 <_ZN10LinkedList6appendEP4Link+0x20>
	last = link->getLast();
80104fe9:	89 51 04             	mov    %edx,0x4(%ecx)
}
80104fec:	5d                   	pop    %ebp
80104fed:	c3                   	ret    
80104fee:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
80104ff0:	89 11                	mov    %edx,(%ecx)
80104ff2:	eb ee                	jmp    80104fe2 <_ZN10LinkedList6appendEP4Link+0x22>
80104ff4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ffa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105000 <_ZN10LinkedList7enqueueEP4proc>:
	if(!freeLinks)
80105000:	a1 10 c6 10 80       	mov    0x8010c610,%eax
bool LinkedList::enqueue(Proc *p) {
80105005:	55                   	push   %ebp
80105006:	89 e5                	mov    %esp,%ebp
80105008:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!freeLinks)
8010500b:	85 c0                	test   %eax,%eax
8010500d:	74 41                	je     80105050 <_ZN10LinkedList7enqueueEP4proc+0x50>
	freeLinks = freeLinks->next;
8010500f:	8b 50 04             	mov    0x4(%eax),%edx
	ans->next = null;
80105012:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	freeLinks = freeLinks->next;
80105019:	89 15 10 c6 10 80    	mov    %edx,0x8010c610
	ans->p = p;
8010501f:	8b 55 0c             	mov    0xc(%ebp),%edx
80105022:	89 10                	mov    %edx,(%eax)
	if(isEmpty()) first = link;
80105024:	8b 11                	mov    (%ecx),%edx
80105026:	85 d2                	test   %edx,%edx
80105028:	74 2e                	je     80105058 <_ZN10LinkedList7enqueueEP4proc+0x58>
	else last->next = link;
8010502a:	8b 51 04             	mov    0x4(%ecx),%edx
8010502d:	89 42 04             	mov    %eax,0x4(%edx)
80105030:	eb 08                	jmp    8010503a <_ZN10LinkedList7enqueueEP4proc+0x3a>
80105032:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	while(ans->next)
80105038:	89 d0                	mov    %edx,%eax
8010503a:	8b 50 04             	mov    0x4(%eax),%edx
8010503d:	85 d2                	test   %edx,%edx
8010503f:	75 f7                	jne    80105038 <_ZN10LinkedList7enqueueEP4proc+0x38>
	last = link->getLast();
80105041:	89 41 04             	mov    %eax,0x4(%ecx)
	return true;
80105044:	b0 01                	mov    $0x1,%al
}
80105046:	5d                   	pop    %ebp
80105047:	c3                   	ret    
80105048:	90                   	nop
80105049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return false;
80105050:	31 c0                	xor    %eax,%eax
}
80105052:	5d                   	pop    %ebp
80105053:	c3                   	ret    
80105054:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(isEmpty()) first = link;
80105058:	89 01                	mov    %eax,(%ecx)
8010505a:	eb de                	jmp    8010503a <_ZN10LinkedList7enqueueEP4proc+0x3a>
8010505c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105060 <_ZN10LinkedList7dequeueEv>:
Proc* LinkedList::dequeue() {
80105060:	55                   	push   %ebp
80105061:	89 e5                	mov    %esp,%ebp
80105063:	83 ec 08             	sub    $0x8,%esp
80105066:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105069:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010506c:	89 75 fc             	mov    %esi,-0x4(%ebp)
	return !first;
8010506f:	8b 11                	mov    (%ecx),%edx
	if(isEmpty())
80105071:	85 d2                	test   %edx,%edx
80105073:	74 2b                	je     801050a0 <_ZN10LinkedList7dequeueEv+0x40>
	Link *next = first->next;
80105075:	8b 5a 04             	mov    0x4(%edx),%ebx
	link->next = freeLinks;
80105078:	8b 35 10 c6 10 80    	mov    0x8010c610,%esi
	Proc *p = first->p;
8010507e:	8b 02                	mov    (%edx),%eax
	freeLinks = link;
80105080:	89 15 10 c6 10 80    	mov    %edx,0x8010c610
	if(isEmpty())
80105086:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
80105088:	89 72 04             	mov    %esi,0x4(%edx)
	first = next;
8010508b:	89 19                	mov    %ebx,(%ecx)
	if(isEmpty())
8010508d:	75 07                	jne    80105096 <_ZN10LinkedList7dequeueEv+0x36>
		last = null;
8010508f:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
}
80105096:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105099:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010509c:	89 ec                	mov    %ebp,%esp
8010509e:	5d                   	pop    %ebp
8010509f:	c3                   	ret    
		return null;
801050a0:	31 c0                	xor    %eax,%eax
801050a2:	eb f2                	jmp    80105096 <_ZN10LinkedList7dequeueEv+0x36>
801050a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801050aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801050b0 <_ZN10LinkedList6removeEP4proc>:
bool LinkedList::remove(Proc *p) {
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	56                   	push   %esi
801050b4:	8b 75 08             	mov    0x8(%ebp),%esi
801050b7:	53                   	push   %ebx
801050b8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
	return !first;
801050bb:	8b 1e                	mov    (%esi),%ebx
	if(isEmpty())
801050bd:	85 db                	test   %ebx,%ebx
801050bf:	74 2f                	je     801050f0 <_ZN10LinkedList6removeEP4proc+0x40>
	if(first->p == p) {
801050c1:	39 0b                	cmp    %ecx,(%ebx)
801050c3:	8b 53 04             	mov    0x4(%ebx),%edx
801050c6:	74 70                	je     80105138 <_ZN10LinkedList6removeEP4proc+0x88>
	while(cur) {
801050c8:	85 d2                	test   %edx,%edx
801050ca:	74 24                	je     801050f0 <_ZN10LinkedList6removeEP4proc+0x40>
		if(cur->p == p) {
801050cc:	3b 0a                	cmp    (%edx),%ecx
801050ce:	66 90                	xchg   %ax,%ax
801050d0:	75 0c                	jne    801050de <_ZN10LinkedList6removeEP4proc+0x2e>
801050d2:	eb 2c                	jmp    80105100 <_ZN10LinkedList6removeEP4proc+0x50>
801050d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801050d8:	39 08                	cmp    %ecx,(%eax)
801050da:	74 34                	je     80105110 <_ZN10LinkedList6removeEP4proc+0x60>
801050dc:	89 c2                	mov    %eax,%edx
		cur = cur->next;
801050de:	8b 42 04             	mov    0x4(%edx),%eax
	while(cur) {
801050e1:	85 c0                	test   %eax,%eax
801050e3:	75 f3                	jne    801050d8 <_ZN10LinkedList6removeEP4proc+0x28>
}
801050e5:	5b                   	pop    %ebx
801050e6:	5e                   	pop    %esi
801050e7:	5d                   	pop    %ebp
801050e8:	c3                   	ret    
801050e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050f0:	5b                   	pop    %ebx
		return false;
801050f1:	31 c0                	xor    %eax,%eax
}
801050f3:	5e                   	pop    %esi
801050f4:	5d                   	pop    %ebp
801050f5:	c3                   	ret    
801050f6:	8d 76 00             	lea    0x0(%esi),%esi
801050f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		if(cur->p == p) {
80105100:	89 d0                	mov    %edx,%eax
80105102:	89 da                	mov    %ebx,%edx
80105104:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010510a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
			prev->next = cur->next;
80105110:	8b 48 04             	mov    0x4(%eax),%ecx
80105113:	89 4a 04             	mov    %ecx,0x4(%edx)
			if(!(cur->next)) //removes the last link
80105116:	8b 48 04             	mov    0x4(%eax),%ecx
80105119:	85 c9                	test   %ecx,%ecx
8010511b:	74 43                	je     80105160 <_ZN10LinkedList6removeEP4proc+0xb0>
	link->next = freeLinks;
8010511d:	8b 15 10 c6 10 80    	mov    0x8010c610,%edx
	freeLinks = link;
80105123:	a3 10 c6 10 80       	mov    %eax,0x8010c610
	link->next = freeLinks;
80105128:	89 50 04             	mov    %edx,0x4(%eax)
			return true;
8010512b:	b0 01                	mov    $0x1,%al
}
8010512d:	5b                   	pop    %ebx
8010512e:	5e                   	pop    %esi
8010512f:	5d                   	pop    %ebp
80105130:	c3                   	ret    
80105131:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	link->next = freeLinks;
80105138:	a1 10 c6 10 80       	mov    0x8010c610,%eax
	if(isEmpty())
8010513d:	85 d2                	test   %edx,%edx
	freeLinks = link;
8010513f:	89 1d 10 c6 10 80    	mov    %ebx,0x8010c610
	link->next = freeLinks;
80105145:	89 43 04             	mov    %eax,0x4(%ebx)
		return true;
80105148:	b0 01                	mov    $0x1,%al
	first = next;
8010514a:	89 16                	mov    %edx,(%esi)
	if(isEmpty())
8010514c:	75 97                	jne    801050e5 <_ZN10LinkedList6removeEP4proc+0x35>
		last = null;
8010514e:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%esi)
80105155:	eb 8e                	jmp    801050e5 <_ZN10LinkedList6removeEP4proc+0x35>
80105157:	89 f6                	mov    %esi,%esi
80105159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
				last = prev;
80105160:	89 56 04             	mov    %edx,0x4(%esi)
80105163:	eb b8                	jmp    8010511d <_ZN10LinkedList6removeEP4proc+0x6d>
80105165:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105170 <removeRunningProcessHolder>:
static boolean removeRunningProcessHolder(Proc* p) {
80105170:	55                   	push   %ebp
80105171:	89 e5                	mov    %esp,%ebp
80105173:	83 ec 08             	sub    $0x8,%esp
	return runningProcHolder->remove(p);
80105176:	8b 45 08             	mov    0x8(%ebp),%eax
80105179:	89 44 24 04          	mov    %eax,0x4(%esp)
8010517d:	a1 14 c6 10 80       	mov    0x8010c614,%eax
80105182:	89 04 24             	mov    %eax,(%esp)
80105185:	e8 26 ff ff ff       	call   801050b0 <_ZN10LinkedList6removeEP4proc>
}
8010518a:	c9                   	leave  
	return runningProcHolder->remove(p);
8010518b:	0f b6 c0             	movzbl %al,%eax
}
8010518e:	c3                   	ret    
8010518f:	90                   	nop

80105190 <_ZN10LinkedList8transferEv>:
	if(!priorityQ->isEmpty())
80105190:	8b 15 1c c6 10 80    	mov    0x8010c61c,%edx
		return false;
80105196:	31 c0                	xor    %eax,%eax
bool LinkedList::transfer() {
80105198:	55                   	push   %ebp
80105199:	89 e5                	mov    %esp,%ebp
8010519b:	53                   	push   %ebx
8010519c:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!priorityQ->isEmpty())
8010519f:	8b 1a                	mov    (%edx),%ebx
801051a1:	85 db                	test   %ebx,%ebx
801051a3:	74 0b                	je     801051b0 <_ZN10LinkedList8transferEv+0x20>
}
801051a5:	5b                   	pop    %ebx
801051a6:	5d                   	pop    %ebp
801051a7:	c3                   	ret    
801051a8:	90                   	nop
801051a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	if(!isEmpty()) {
801051b0:	8b 19                	mov    (%ecx),%ebx
801051b2:	85 db                	test   %ebx,%ebx
801051b4:	74 4a                	je     80105200 <_ZN10LinkedList8transferEv+0x70>
	if(!freeNodes)
801051b6:	8b 1d 0c c6 10 80    	mov    0x8010c60c,%ebx
801051bc:	85 db                	test   %ebx,%ebx
801051be:	74 e5                	je     801051a5 <_ZN10LinkedList8transferEv+0x15>
	freeNodes = freeNodes->next;
801051c0:	8b 43 10             	mov    0x10(%ebx),%eax
	ans->key = key;
801051c3:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
	ans->next = null;
801051c9:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
	ans->key = key;
801051d0:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
	freeNodes = freeNodes->next;
801051d7:	a3 0c c6 10 80       	mov    %eax,0x8010c60c
		node->listOfProcs.first = first;
801051dc:	8b 01                	mov    (%ecx),%eax
801051de:	89 43 08             	mov    %eax,0x8(%ebx)
		node->listOfProcs.last = last;
801051e1:	8b 41 04             	mov    0x4(%ecx),%eax
801051e4:	89 43 0c             	mov    %eax,0xc(%ebx)
	return true;
801051e7:	b0 01                	mov    $0x1,%al
		first = last = null;
801051e9:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
801051f0:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
		priorityQ->root = node;
801051f6:	89 1a                	mov    %ebx,(%edx)
}
801051f8:	5b                   	pop    %ebx
801051f9:	5d                   	pop    %ebp
801051fa:	c3                   	ret    
801051fb:	90                   	nop
801051fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	return true;
80105200:	b0 01                	mov    $0x1,%al
80105202:	eb a1                	jmp    801051a5 <_ZN10LinkedList8transferEv+0x15>
80105204:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010520a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105210 <switchToPriorityQueuePolicyRoundRobinQueue>:
static boolean switchToPriorityQueuePolicyRoundRobinQueue() {
80105210:	55                   	push   %ebp
80105211:	89 e5                	mov    %esp,%ebp
80105213:	83 ec 04             	sub    $0x4,%esp
	return roundRobinQ->transfer();
80105216:	a1 18 c6 10 80       	mov    0x8010c618,%eax
8010521b:	89 04 24             	mov    %eax,(%esp)
8010521e:	e8 6d ff ff ff       	call   80105190 <_ZN10LinkedList8transferEv>
}
80105223:	c9                   	leave  
	return roundRobinQ->transfer();
80105224:	0f b6 c0             	movzbl %al,%eax
}
80105227:	c3                   	ret    
80105228:	90                   	nop
80105229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105230 <_ZN10LinkedList9getMinKeyEPx>:
bool LinkedList::getMinKey(long long *pkey) {
80105230:	55                   	push   %ebp
80105231:	31 c0                	xor    %eax,%eax
80105233:	89 e5                	mov    %esp,%ebp
80105235:	57                   	push   %edi
80105236:	56                   	push   %esi
80105237:	53                   	push   %ebx
80105238:	83 ec 1c             	sub    $0x1c,%esp
8010523b:	8b 7d 08             	mov    0x8(%ebp),%edi
	return !first;
8010523e:	8b 17                	mov    (%edi),%edx
	if(isEmpty())
80105240:	85 d2                	test   %edx,%edx
80105242:	74 41                	je     80105285 <_ZN10LinkedList9getMinKeyEPx+0x55>
	long long minKey = getAccumulator(first->p);
80105244:	8b 02                	mov    (%edx),%eax
80105246:	89 04 24             	mov    %eax,(%esp)
80105249:	e8 72 e6 ff ff       	call   801038c0 <getAccumulator>
	forEach([&](Proc *p) {
8010524e:	8b 3f                	mov    (%edi),%edi
	void append(Link *link); //appends the given list to the queue. No allocations always succeeds.
	
	template<typename Func>
	void forEach(const Func& accept) { //for-each loop. gets a function that applies the procin each link node.
		Link *link = first;
		while(link) {
80105250:	85 ff                	test   %edi,%edi
	long long minKey = getAccumulator(first->p);
80105252:	89 c6                	mov    %eax,%esi
80105254:	89 d3                	mov    %edx,%ebx
80105256:	74 23                	je     8010527b <_ZN10LinkedList9getMinKeyEPx+0x4b>
80105258:	90                   	nop
80105259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		long long key = getAccumulator(p);
80105260:	8b 07                	mov    (%edi),%eax
80105262:	89 04 24             	mov    %eax,(%esp)
80105265:	e8 56 e6 ff ff       	call   801038c0 <getAccumulator>
8010526a:	39 d3                	cmp    %edx,%ebx
8010526c:	7c 06                	jl     80105274 <_ZN10LinkedList9getMinKeyEPx+0x44>
8010526e:	7f 20                	jg     80105290 <_ZN10LinkedList9getMinKeyEPx+0x60>
80105270:	39 c6                	cmp    %eax,%esi
80105272:	77 1c                	ja     80105290 <_ZN10LinkedList9getMinKeyEPx+0x60>
			accept(link->p);
			link = link->next;
80105274:	8b 7f 04             	mov    0x4(%edi),%edi
		while(link) {
80105277:	85 ff                	test   %edi,%edi
80105279:	75 e5                	jne    80105260 <_ZN10LinkedList9getMinKeyEPx+0x30>
	*pkey = minKey;
8010527b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010527e:	89 30                	mov    %esi,(%eax)
80105280:	89 58 04             	mov    %ebx,0x4(%eax)
	return true;
80105283:	b0 01                	mov    $0x1,%al
}
80105285:	83 c4 1c             	add    $0x1c,%esp
80105288:	5b                   	pop    %ebx
80105289:	5e                   	pop    %esi
8010528a:	5f                   	pop    %edi
8010528b:	5d                   	pop    %ebp
8010528c:	c3                   	ret    
8010528d:	8d 76 00             	lea    0x0(%esi),%esi
			link = link->next;
80105290:	8b 7f 04             	mov    0x4(%edi),%edi
80105293:	89 c6                	mov    %eax,%esi
80105295:	89 d3                	mov    %edx,%ebx
		while(link) {
80105297:	85 ff                	test   %edi,%edi
80105299:	75 c5                	jne    80105260 <_ZN10LinkedList9getMinKeyEPx+0x30>
8010529b:	eb de                	jmp    8010527b <_ZN10LinkedList9getMinKeyEPx+0x4b>
8010529d:	8d 76 00             	lea    0x0(%esi),%esi

801052a0 <getMinAccumulatorRunningProcessHolder>:
static boolean getMinAccumulatorRunningProcessHolder(long long *pkey) {
801052a0:	55                   	push   %ebp
801052a1:	89 e5                	mov    %esp,%ebp
801052a3:	83 ec 18             	sub    $0x18,%esp
	return runningProcHolder->getMinKey(pkey);
801052a6:	8b 45 08             	mov    0x8(%ebp),%eax
801052a9:	89 44 24 04          	mov    %eax,0x4(%esp)
801052ad:	a1 14 c6 10 80       	mov    0x8010c614,%eax
801052b2:	89 04 24             	mov    %eax,(%esp)
801052b5:	e8 76 ff ff ff       	call   80105230 <_ZN10LinkedList9getMinKeyEPx>
}
801052ba:	c9                   	leave  
	return runningProcHolder->getMinKey(pkey);
801052bb:	0f b6 c0             	movzbl %al,%eax
}
801052be:	c3                   	ret    
801052bf:	90                   	nop

801052c0 <_ZN7MapNode7isEmptyEv>:
bool MapNode::isEmpty() {
801052c0:	55                   	push   %ebp
801052c1:	89 e5                	mov    %esp,%ebp
	return !first;
801052c3:	8b 45 08             	mov    0x8(%ebp),%eax
}
801052c6:	5d                   	pop    %ebp
	return !first;
801052c7:	8b 40 08             	mov    0x8(%eax),%eax
801052ca:	85 c0                	test   %eax,%eax
801052cc:	0f 94 c0             	sete   %al
}
801052cf:	c3                   	ret    

801052d0 <_ZN7MapNode3putEP4proc>:
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
801052d0:	55                   	push   %ebp
801052d1:	89 e5                	mov    %esp,%ebp
801052d3:	57                   	push   %edi
801052d4:	56                   	push   %esi
801052d5:	53                   	push   %ebx
801052d6:	83 ec 2c             	sub    $0x2c,%esp
	long long key = getAccumulator(p);
801052d9:	8b 45 0c             	mov    0xc(%ebp),%eax
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
801052dc:	8b 5d 08             	mov    0x8(%ebp),%ebx
	long long key = getAccumulator(p);
801052df:	89 04 24             	mov    %eax,(%esp)
801052e2:	e8 d9 e5 ff ff       	call   801038c0 <getAccumulator>
801052e7:	89 d1                	mov    %edx,%ecx
801052e9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801052ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		if(key == node->key)
801052f0:	8b 13                	mov    (%ebx),%edx
801052f2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801052f5:	8b 43 04             	mov    0x4(%ebx),%eax
801052f8:	31 d7                	xor    %edx,%edi
801052fa:	89 fe                	mov    %edi,%esi
801052fc:	89 c7                	mov    %eax,%edi
801052fe:	31 cf                	xor    %ecx,%edi
80105300:	09 fe                	or     %edi,%esi
80105302:	74 4c                	je     80105350 <_ZN7MapNode3putEP4proc+0x80>
		else if(key < node->key) { //left
80105304:	39 c8                	cmp    %ecx,%eax
80105306:	7c 20                	jl     80105328 <_ZN7MapNode3putEP4proc+0x58>
80105308:	7f 08                	jg     80105312 <_ZN7MapNode3putEP4proc+0x42>
8010530a:	3b 55 e4             	cmp    -0x1c(%ebp),%edx
8010530d:	8d 76 00             	lea    0x0(%esi),%esi
80105310:	76 16                	jbe    80105328 <_ZN7MapNode3putEP4proc+0x58>
			if(node->left)
80105312:	8b 43 18             	mov    0x18(%ebx),%eax
80105315:	85 c0                	test   %eax,%eax
80105317:	0f 84 83 00 00 00    	je     801053a0 <_ZN7MapNode3putEP4proc+0xd0>
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
8010531d:	89 c3                	mov    %eax,%ebx
8010531f:	eb cf                	jmp    801052f0 <_ZN7MapNode3putEP4proc+0x20>
80105321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			if(node->right)
80105328:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010532b:	85 c0                	test   %eax,%eax
8010532d:	75 ee                	jne    8010531d <_ZN7MapNode3putEP4proc+0x4d>
8010532f:	8b 75 e4             	mov    -0x1c(%ebp),%esi
				node->right = allocNode(p, key);
80105332:	8b 45 0c             	mov    0xc(%ebp),%eax
80105335:	89 f2                	mov    %esi,%edx
80105337:	e8 e4 f9 ff ff       	call   80104d20 <_ZL9allocNodeP4procx>
				if(node->right) {
8010533c:	85 c0                	test   %eax,%eax
				node->right = allocNode(p, key);
8010533e:	89 43 1c             	mov    %eax,0x1c(%ebx)
				if(node->right) {
80105341:	74 71                	je     801053b4 <_ZN7MapNode3putEP4proc+0xe4>
					node->right->parent = node;
80105343:	89 58 14             	mov    %ebx,0x14(%eax)
}
80105346:	83 c4 2c             	add    $0x2c,%esp
					return true;
80105349:	b0 01                	mov    $0x1,%al
}
8010534b:	5b                   	pop    %ebx
8010534c:	5e                   	pop    %esi
8010534d:	5f                   	pop    %edi
8010534e:	5d                   	pop    %ebp
8010534f:	c3                   	ret    
	if(!freeLinks)
80105350:	a1 10 c6 10 80       	mov    0x8010c610,%eax
80105355:	85 c0                	test   %eax,%eax
80105357:	74 5b                	je     801053b4 <_ZN7MapNode3putEP4proc+0xe4>
	ans->p = p;
80105359:	8b 75 0c             	mov    0xc(%ebp),%esi
	freeLinks = freeLinks->next;
8010535c:	8b 50 04             	mov    0x4(%eax),%edx
	ans->next = null;
8010535f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	ans->p = p;
80105366:	89 30                	mov    %esi,(%eax)
	freeLinks = freeLinks->next;
80105368:	89 15 10 c6 10 80    	mov    %edx,0x8010c610
	if(isEmpty()) first = link;
8010536e:	8b 53 08             	mov    0x8(%ebx),%edx
80105371:	85 d2                	test   %edx,%edx
80105373:	74 4b                	je     801053c0 <_ZN7MapNode3putEP4proc+0xf0>
	else last->next = link;
80105375:	8b 53 0c             	mov    0xc(%ebx),%edx
80105378:	89 42 04             	mov    %eax,0x4(%edx)
8010537b:	eb 05                	jmp    80105382 <_ZN7MapNode3putEP4proc+0xb2>
8010537d:	8d 76 00             	lea    0x0(%esi),%esi
	while(ans->next)
80105380:	89 d0                	mov    %edx,%eax
80105382:	8b 50 04             	mov    0x4(%eax),%edx
80105385:	85 d2                	test   %edx,%edx
80105387:	75 f7                	jne    80105380 <_ZN7MapNode3putEP4proc+0xb0>
	last = link->getLast();
80105389:	89 43 0c             	mov    %eax,0xc(%ebx)
}
8010538c:	83 c4 2c             	add    $0x2c,%esp
	return true;
8010538f:	b0 01                	mov    $0x1,%al
}
80105391:	5b                   	pop    %ebx
80105392:	5e                   	pop    %esi
80105393:	5f                   	pop    %edi
80105394:	5d                   	pop    %ebp
80105395:	c3                   	ret    
80105396:	8d 76 00             	lea    0x0(%esi),%esi
80105399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801053a0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
				node->left = allocNode(p, key);
801053a3:	8b 45 0c             	mov    0xc(%ebp),%eax
801053a6:	89 f2                	mov    %esi,%edx
801053a8:	e8 73 f9 ff ff       	call   80104d20 <_ZL9allocNodeP4procx>
				if(node->left) {
801053ad:	85 c0                	test   %eax,%eax
				node->left = allocNode(p, key);
801053af:	89 43 18             	mov    %eax,0x18(%ebx)
				if(node->left) {
801053b2:	75 8f                	jne    80105343 <_ZN7MapNode3putEP4proc+0x73>
}
801053b4:	83 c4 2c             	add    $0x2c,%esp
		return false;
801053b7:	31 c0                	xor    %eax,%eax
}
801053b9:	5b                   	pop    %ebx
801053ba:	5e                   	pop    %esi
801053bb:	5f                   	pop    %edi
801053bc:	5d                   	pop    %ebp
801053bd:	c3                   	ret    
801053be:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
801053c0:	89 43 08             	mov    %eax,0x8(%ebx)
801053c3:	eb bd                	jmp    80105382 <_ZN7MapNode3putEP4proc+0xb2>
801053c5:	90                   	nop
801053c6:	8d 76 00             	lea    0x0(%esi),%esi
801053c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801053d0 <_ZN7MapNode10getMinNodeEv>:
MapNode* MapNode::getMinNode() { //no recursion.
801053d0:	55                   	push   %ebp
801053d1:	89 e5                	mov    %esp,%ebp
801053d3:	8b 45 08             	mov    0x8(%ebp),%eax
801053d6:	eb 0a                	jmp    801053e2 <_ZN7MapNode10getMinNodeEv+0x12>
801053d8:	90                   	nop
801053d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801053e0:	89 d0                	mov    %edx,%eax
	while(minNode->left)
801053e2:	8b 50 18             	mov    0x18(%eax),%edx
801053e5:	85 d2                	test   %edx,%edx
801053e7:	75 f7                	jne    801053e0 <_ZN7MapNode10getMinNodeEv+0x10>
}
801053e9:	5d                   	pop    %ebp
801053ea:	c3                   	ret    
801053eb:	90                   	nop
801053ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053f0 <_ZN7MapNode9getMinKeyEPx>:
void MapNode::getMinKey(long long *pkey) {
801053f0:	55                   	push   %ebp
801053f1:	89 e5                	mov    %esp,%ebp
801053f3:	8b 55 08             	mov    0x8(%ebp),%edx
801053f6:	53                   	push   %ebx
801053f7:	eb 09                	jmp    80105402 <_ZN7MapNode9getMinKeyEPx+0x12>
801053f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	while(minNode->left)
80105400:	89 c2                	mov    %eax,%edx
80105402:	8b 42 18             	mov    0x18(%edx),%eax
80105405:	85 c0                	test   %eax,%eax
80105407:	75 f7                	jne    80105400 <_ZN7MapNode9getMinKeyEPx+0x10>
	*pkey = getMinNode()->key;
80105409:	8b 5a 04             	mov    0x4(%edx),%ebx
8010540c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010540f:	8b 0a                	mov    (%edx),%ecx
80105411:	89 58 04             	mov    %ebx,0x4(%eax)
80105414:	89 08                	mov    %ecx,(%eax)
}
80105416:	5b                   	pop    %ebx
80105417:	5d                   	pop    %ebp
80105418:	c3                   	ret    
80105419:	90                   	nop
8010541a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105420 <_ZN7MapNode7dequeueEv>:
Proc* MapNode::dequeue() {
80105420:	55                   	push   %ebp
80105421:	89 e5                	mov    %esp,%ebp
80105423:	83 ec 08             	sub    $0x8,%esp
80105426:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105429:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010542c:	89 75 fc             	mov    %esi,-0x4(%ebp)
	return !first;
8010542f:	8b 51 08             	mov    0x8(%ecx),%edx
	if(isEmpty())
80105432:	85 d2                	test   %edx,%edx
80105434:	74 32                	je     80105468 <_ZN7MapNode7dequeueEv+0x48>
	Link *next = first->next;
80105436:	8b 5a 04             	mov    0x4(%edx),%ebx
	link->next = freeLinks;
80105439:	8b 35 10 c6 10 80    	mov    0x8010c610,%esi
	Proc *p = first->p;
8010543f:	8b 02                	mov    (%edx),%eax
	freeLinks = link;
80105441:	89 15 10 c6 10 80    	mov    %edx,0x8010c610
	if(isEmpty())
80105447:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
80105449:	89 72 04             	mov    %esi,0x4(%edx)
	first = next;
8010544c:	89 59 08             	mov    %ebx,0x8(%ecx)
	if(isEmpty())
8010544f:	75 07                	jne    80105458 <_ZN7MapNode7dequeueEv+0x38>
		last = null;
80105451:	c7 41 0c 00 00 00 00 	movl   $0x0,0xc(%ecx)
}
80105458:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010545b:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010545e:	89 ec                	mov    %ebp,%esp
80105460:	5d                   	pop    %ebp
80105461:	c3                   	ret    
80105462:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		return null;
80105468:	31 c0                	xor    %eax,%eax
	return listOfProcs.dequeue();
8010546a:	eb ec                	jmp    80105458 <_ZN7MapNode7dequeueEv+0x38>
8010546c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105470 <_ZN3Map7isEmptyEv>:
bool Map::isEmpty() {
80105470:	55                   	push   %ebp
80105471:	89 e5                	mov    %esp,%ebp
	return !root;
80105473:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105476:	5d                   	pop    %ebp
	return !root;
80105477:	8b 00                	mov    (%eax),%eax
80105479:	85 c0                	test   %eax,%eax
8010547b:	0f 94 c0             	sete   %al
}
8010547e:	c3                   	ret    
8010547f:	90                   	nop

80105480 <_ZN3Map3putEP4proc>:
bool Map::put(Proc *p) {
80105480:	55                   	push   %ebp
80105481:	89 e5                	mov    %esp,%ebp
80105483:	83 ec 18             	sub    $0x18,%esp
80105486:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105489:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010548c:	89 75 fc             	mov    %esi,-0x4(%ebp)
8010548f:	8b 75 08             	mov    0x8(%ebp),%esi
	long long key = getAccumulator(p);
80105492:	89 1c 24             	mov    %ebx,(%esp)
80105495:	e8 26 e4 ff ff       	call   801038c0 <getAccumulator>
	return !root;
8010549a:	8b 0e                	mov    (%esi),%ecx
	if(isEmpty()) {
8010549c:	85 c9                	test   %ecx,%ecx
8010549e:	74 18                	je     801054b8 <_ZN3Map3putEP4proc+0x38>
	return root->put(p);
801054a0:	89 5d 0c             	mov    %ebx,0xc(%ebp)
}
801054a3:	8b 75 fc             	mov    -0x4(%ebp),%esi
	return root->put(p);
801054a6:	89 4d 08             	mov    %ecx,0x8(%ebp)
}
801054a9:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801054ac:	89 ec                	mov    %ebp,%esp
801054ae:	5d                   	pop    %ebp
	return root->put(p);
801054af:	e9 1c fe ff ff       	jmp    801052d0 <_ZN7MapNode3putEP4proc>
801054b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		root = allocNode(p, key);
801054b8:	89 d1                	mov    %edx,%ecx
801054ba:	89 c2                	mov    %eax,%edx
801054bc:	89 d8                	mov    %ebx,%eax
801054be:	e8 5d f8 ff ff       	call   80104d20 <_ZL9allocNodeP4procx>
801054c3:	89 06                	mov    %eax,(%esi)
		return !isEmpty();
801054c5:	85 c0                	test   %eax,%eax
801054c7:	0f 95 c0             	setne  %al
}
801054ca:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801054cd:	8b 75 fc             	mov    -0x4(%ebp),%esi
801054d0:	89 ec                	mov    %ebp,%esp
801054d2:	5d                   	pop    %ebp
801054d3:	c3                   	ret    
801054d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801054da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801054e0 <putPriorityQueue>:
static boolean putPriorityQueue(Proc* p) {
801054e0:	55                   	push   %ebp
801054e1:	89 e5                	mov    %esp,%ebp
801054e3:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->put(p);
801054e6:	8b 45 08             	mov    0x8(%ebp),%eax
801054e9:	89 44 24 04          	mov    %eax,0x4(%esp)
801054ed:	a1 1c c6 10 80       	mov    0x8010c61c,%eax
801054f2:	89 04 24             	mov    %eax,(%esp)
801054f5:	e8 86 ff ff ff       	call   80105480 <_ZN3Map3putEP4proc>
}
801054fa:	c9                   	leave  
	return priorityQ->put(p);
801054fb:	0f b6 c0             	movzbl %al,%eax
}
801054fe:	c3                   	ret    
801054ff:	90                   	nop

80105500 <_ZN3Map9getMinKeyEPx>:
bool Map::getMinKey(long long *pkey) {
80105500:	55                   	push   %ebp
80105501:	89 e5                	mov    %esp,%ebp
	return !root;
80105503:	8b 45 08             	mov    0x8(%ebp),%eax
bool Map::getMinKey(long long *pkey) {
80105506:	53                   	push   %ebx
	return !root;
80105507:	8b 10                	mov    (%eax),%edx
	if(isEmpty())
80105509:	85 d2                	test   %edx,%edx
8010550b:	75 05                	jne    80105512 <_ZN3Map9getMinKeyEPx+0x12>
8010550d:	eb 21                	jmp    80105530 <_ZN3Map9getMinKeyEPx+0x30>
8010550f:	90                   	nop
	while(minNode->left)
80105510:	89 c2                	mov    %eax,%edx
80105512:	8b 42 18             	mov    0x18(%edx),%eax
80105515:	85 c0                	test   %eax,%eax
80105517:	75 f7                	jne    80105510 <_ZN3Map9getMinKeyEPx+0x10>
	*pkey = getMinNode()->key;
80105519:	8b 45 0c             	mov    0xc(%ebp),%eax
8010551c:	8b 5a 04             	mov    0x4(%edx),%ebx
8010551f:	8b 0a                	mov    (%edx),%ecx
80105521:	89 58 04             	mov    %ebx,0x4(%eax)
80105524:	89 08                	mov    %ecx,(%eax)
		return false;

	root->getMinKey(pkey);
	return true;
80105526:	b0 01                	mov    $0x1,%al
}
80105528:	5b                   	pop    %ebx
80105529:	5d                   	pop    %ebp
8010552a:	c3                   	ret    
8010552b:	90                   	nop
8010552c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105530:	5b                   	pop    %ebx
		return false;
80105531:	31 c0                	xor    %eax,%eax
}
80105533:	5d                   	pop    %ebp
80105534:	c3                   	ret    
80105535:	90                   	nop
80105536:	8d 76 00             	lea    0x0(%esi),%esi
80105539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105540 <_ZN3Map10extractMinEv>:

Proc* Map::extractMin() {
80105540:	55                   	push   %ebp
80105541:	89 e5                	mov    %esp,%ebp
80105543:	57                   	push   %edi
80105544:	56                   	push   %esi
80105545:	8b 75 08             	mov    0x8(%ebp),%esi
80105548:	53                   	push   %ebx
	return !root;
80105549:	8b 1e                	mov    (%esi),%ebx
	if(isEmpty())
8010554b:	85 db                	test   %ebx,%ebx
8010554d:	0f 84 a5 00 00 00    	je     801055f8 <_ZN3Map10extractMinEv+0xb8>
80105553:	89 da                	mov    %ebx,%edx
80105555:	eb 0b                	jmp    80105562 <_ZN3Map10extractMinEv+0x22>
80105557:	89 f6                	mov    %esi,%esi
80105559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	while(minNode->left)
80105560:	89 c2                	mov    %eax,%edx
80105562:	8b 42 18             	mov    0x18(%edx),%eax
80105565:	85 c0                	test   %eax,%eax
80105567:	75 f7                	jne    80105560 <_ZN3Map10extractMinEv+0x20>
	return !first;
80105569:	8b 4a 08             	mov    0x8(%edx),%ecx
	if(isEmpty())
8010556c:	85 c9                	test   %ecx,%ecx
8010556e:	74 70                	je     801055e0 <_ZN3Map10extractMinEv+0xa0>
	Link *next = first->next;
80105570:	8b 59 04             	mov    0x4(%ecx),%ebx
	link->next = freeLinks;
80105573:	8b 3d 10 c6 10 80    	mov    0x8010c610,%edi
	Proc *p = first->p;
80105579:	8b 01                	mov    (%ecx),%eax
	freeLinks = link;
8010557b:	89 0d 10 c6 10 80    	mov    %ecx,0x8010c610
	if(isEmpty())
80105581:	85 db                	test   %ebx,%ebx
	link->next = freeLinks;
80105583:	89 79 04             	mov    %edi,0x4(%ecx)
	first = next;
80105586:	89 5a 08             	mov    %ebx,0x8(%edx)
	if(isEmpty())
80105589:	74 05                	je     80105590 <_ZN3Map10extractMinEv+0x50>
		}
		deallocNode(minNode);
	}

	return p;
}
8010558b:	5b                   	pop    %ebx
8010558c:	5e                   	pop    %esi
8010558d:	5f                   	pop    %edi
8010558e:	5d                   	pop    %ebp
8010558f:	c3                   	ret    
		last = null;
80105590:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
80105597:	8b 4a 1c             	mov    0x1c(%edx),%ecx
8010559a:	8b 1e                	mov    (%esi),%ebx
		if(minNode == root) {
8010559c:	39 da                	cmp    %ebx,%edx
8010559e:	74 49                	je     801055e9 <_ZN3Map10extractMinEv+0xa9>
			MapNode *parent = minNode->parent;
801055a0:	8b 5a 14             	mov    0x14(%edx),%ebx
			parent->left = minNode->right;
801055a3:	89 4b 18             	mov    %ecx,0x18(%ebx)
			if(minNode->right)
801055a6:	8b 4a 1c             	mov    0x1c(%edx),%ecx
801055a9:	85 c9                	test   %ecx,%ecx
801055ab:	74 03                	je     801055b0 <_ZN3Map10extractMinEv+0x70>
				minNode->right->parent = parent;
801055ad:	89 59 14             	mov    %ebx,0x14(%ecx)
	node->next = freeNodes;
801055b0:	8b 0d 0c c6 10 80    	mov    0x8010c60c,%ecx
	node->parent = node->left = node->right = null;
801055b6:	c7 42 1c 00 00 00 00 	movl   $0x0,0x1c(%edx)
801055bd:	c7 42 18 00 00 00 00 	movl   $0x0,0x18(%edx)
801055c4:	c7 42 14 00 00 00 00 	movl   $0x0,0x14(%edx)
	node->next = freeNodes;
801055cb:	89 4a 10             	mov    %ecx,0x10(%edx)
}
801055ce:	5b                   	pop    %ebx
	freeNodes = node;
801055cf:	89 15 0c c6 10 80    	mov    %edx,0x8010c60c
}
801055d5:	5e                   	pop    %esi
801055d6:	5f                   	pop    %edi
801055d7:	5d                   	pop    %ebp
801055d8:	c3                   	ret    
801055d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return null;
801055e0:	31 c0                	xor    %eax,%eax
		if(minNode == root) {
801055e2:	39 da                	cmp    %ebx,%edx
801055e4:	8b 4a 1c             	mov    0x1c(%edx),%ecx
801055e7:	75 b7                	jne    801055a0 <_ZN3Map10extractMinEv+0x60>
			if(!isEmpty())
801055e9:	85 c9                	test   %ecx,%ecx
			root = minNode->right;
801055eb:	89 0e                	mov    %ecx,(%esi)
			if(!isEmpty())
801055ed:	74 c1                	je     801055b0 <_ZN3Map10extractMinEv+0x70>
				root->parent = null;
801055ef:	c7 41 14 00 00 00 00 	movl   $0x0,0x14(%ecx)
801055f6:	eb b8                	jmp    801055b0 <_ZN3Map10extractMinEv+0x70>
		return null;
801055f8:	31 c0                	xor    %eax,%eax
801055fa:	eb 8f                	jmp    8010558b <_ZN3Map10extractMinEv+0x4b>
801055fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105600 <extractMinPriorityQueue>:
static Proc* extractMinPriorityQueue() {
80105600:	55                   	push   %ebp
80105601:	89 e5                	mov    %esp,%ebp
80105603:	83 ec 04             	sub    $0x4,%esp
	return priorityQ->extractMin();
80105606:	a1 1c c6 10 80       	mov    0x8010c61c,%eax
8010560b:	89 04 24             	mov    %eax,(%esp)
8010560e:	e8 2d ff ff ff       	call   80105540 <_ZN3Map10extractMinEv>
}
80105613:	c9                   	leave  
80105614:	c3                   	ret    
80105615:	90                   	nop
80105616:	8d 76 00             	lea    0x0(%esi),%esi
80105619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105620 <_ZN3Map8transferEv.part.1>:

bool Map::transfer() {
80105620:	55                   	push   %ebp
80105621:	89 e5                	mov    %esp,%ebp
80105623:	56                   	push   %esi
80105624:	53                   	push   %ebx
80105625:	89 c3                	mov    %eax,%ebx
80105627:	83 ec 04             	sub    $0x4,%esp
8010562a:	eb 16                	jmp    80105642 <_ZN3Map8transferEv.part.1+0x22>
8010562c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	if(!roundRobinQ->isEmpty())
		return false;

	while(!isEmpty()) {
		Proc* p = extractMin();
80105630:	89 1c 24             	mov    %ebx,(%esp)
80105633:	e8 08 ff ff ff       	call   80105540 <_ZN3Map10extractMinEv>
	if(!freeLinks)
80105638:	8b 15 10 c6 10 80    	mov    0x8010c610,%edx
8010563e:	85 d2                	test   %edx,%edx
80105640:	75 0e                	jne    80105650 <_ZN3Map8transferEv.part.1+0x30>
	while(!isEmpty()) {
80105642:	8b 03                	mov    (%ebx),%eax
80105644:	85 c0                	test   %eax,%eax
80105646:	75 e8                	jne    80105630 <_ZN3Map8transferEv.part.1+0x10>
		roundRobinQ->enqueue(p); //should succeed.
	}

	return true;
}
80105648:	5a                   	pop    %edx
80105649:	b0 01                	mov    $0x1,%al
8010564b:	5b                   	pop    %ebx
8010564c:	5e                   	pop    %esi
8010564d:	5d                   	pop    %ebp
8010564e:	c3                   	ret    
8010564f:	90                   	nop
	freeLinks = freeLinks->next;
80105650:	8b 72 04             	mov    0x4(%edx),%esi
		roundRobinQ->enqueue(p); //should succeed.
80105653:	8b 0d 18 c6 10 80    	mov    0x8010c618,%ecx
	ans->next = null;
80105659:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
	ans->p = p;
80105660:	89 02                	mov    %eax,(%edx)
	freeLinks = freeLinks->next;
80105662:	89 35 10 c6 10 80    	mov    %esi,0x8010c610
	if(isEmpty()) first = link;
80105668:	8b 31                	mov    (%ecx),%esi
8010566a:	85 f6                	test   %esi,%esi
8010566c:	74 22                	je     80105690 <_ZN3Map8transferEv.part.1+0x70>
	else last->next = link;
8010566e:	8b 41 04             	mov    0x4(%ecx),%eax
80105671:	89 50 04             	mov    %edx,0x4(%eax)
80105674:	eb 0c                	jmp    80105682 <_ZN3Map8transferEv.part.1+0x62>
80105676:	8d 76 00             	lea    0x0(%esi),%esi
80105679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	while(ans->next)
80105680:	89 c2                	mov    %eax,%edx
80105682:	8b 42 04             	mov    0x4(%edx),%eax
80105685:	85 c0                	test   %eax,%eax
80105687:	75 f7                	jne    80105680 <_ZN3Map8transferEv.part.1+0x60>
	last = link->getLast();
80105689:	89 51 04             	mov    %edx,0x4(%ecx)
8010568c:	eb b4                	jmp    80105642 <_ZN3Map8transferEv.part.1+0x22>
8010568e:	66 90                	xchg   %ax,%ax
	if(isEmpty()) first = link;
80105690:	89 11                	mov    %edx,(%ecx)
80105692:	eb ee                	jmp    80105682 <_ZN3Map8transferEv.part.1+0x62>
80105694:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010569a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801056a0 <switchToRoundRobinPolicyPriorityQueue>:
	if(!roundRobinQ->isEmpty())
801056a0:	8b 15 18 c6 10 80    	mov    0x8010c618,%edx
801056a6:	8b 02                	mov    (%edx),%eax
801056a8:	85 c0                	test   %eax,%eax
801056aa:	74 04                	je     801056b0 <switchToRoundRobinPolicyPriorityQueue+0x10>
801056ac:	31 c0                	xor    %eax,%eax
}
801056ae:	c3                   	ret    
801056af:	90                   	nop
801056b0:	a1 1c c6 10 80       	mov    0x8010c61c,%eax
static boolean switchToRoundRobinPolicyPriorityQueue() {
801056b5:	55                   	push   %ebp
801056b6:	89 e5                	mov    %esp,%ebp
801056b8:	e8 63 ff ff ff       	call   80105620 <_ZN3Map8transferEv.part.1>
}
801056bd:	5d                   	pop    %ebp
801056be:	0f b6 c0             	movzbl %al,%eax
801056c1:	c3                   	ret    
801056c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801056d0 <_ZN3Map8transferEv>:
	return !first;
801056d0:	8b 15 18 c6 10 80    	mov    0x8010c618,%edx
bool Map::transfer() {
801056d6:	55                   	push   %ebp
801056d7:	89 e5                	mov    %esp,%ebp
801056d9:	8b 45 08             	mov    0x8(%ebp),%eax
	if(!roundRobinQ->isEmpty())
801056dc:	8b 12                	mov    (%edx),%edx
801056de:	85 d2                	test   %edx,%edx
801056e0:	74 0e                	je     801056f0 <_ZN3Map8transferEv+0x20>
}
801056e2:	31 c0                	xor    %eax,%eax
801056e4:	5d                   	pop    %ebp
801056e5:	c3                   	ret    
801056e6:	8d 76 00             	lea    0x0(%esi),%esi
801056e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801056f0:	5d                   	pop    %ebp
801056f1:	e9 2a ff ff ff       	jmp    80105620 <_ZN3Map8transferEv.part.1>
801056f6:	8d 76 00             	lea    0x0(%esi),%esi
801056f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105700 <_ZN3Map11extractProcEP4proc>:

bool Map::extractProc(Proc *p) {
80105700:	55                   	push   %ebp
80105701:	89 e5                	mov    %esp,%ebp
80105703:	56                   	push   %esi
80105704:	53                   	push   %ebx
80105705:	83 ec 30             	sub    $0x30,%esp
	if(!freeNodes)
80105708:	8b 15 0c c6 10 80    	mov    0x8010c60c,%edx
bool Map::extractProc(Proc *p) {
8010570e:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105711:	8b 75 0c             	mov    0xc(%ebp),%esi
	if(!freeNodes)
80105714:	85 d2                	test   %edx,%edx
80105716:	74 50                	je     80105768 <_ZN3Map11extractProcEP4proc+0x68>
	MapNode *next, *parent, *left, *right;
};

class Map {
public:
	Map(): root(null) {}
80105718:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		return false;

	bool ans = false;
8010571f:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
80105723:	eb 13                	jmp    80105738 <_ZN3Map11extractProcEP4proc+0x38>
80105725:	8d 76 00             	lea    0x0(%esi),%esi
	Map tempMap;
	while(!isEmpty()) {
		Proc *otherP = extractMin();
80105728:	89 1c 24             	mov    %ebx,(%esp)
8010572b:	e8 10 fe ff ff       	call   80105540 <_ZN3Map10extractMinEv>
		if(otherP != p)
80105730:	39 f0                	cmp    %esi,%eax
80105732:	75 1c                	jne    80105750 <_ZN3Map11extractProcEP4proc+0x50>
			tempMap.put(otherP); //should scucceed.
		else ans = true;
80105734:	c6 45 e7 01          	movb   $0x1,-0x19(%ebp)
	while(!isEmpty()) {
80105738:	8b 03                	mov    (%ebx),%eax
8010573a:	85 c0                	test   %eax,%eax
8010573c:	75 ea                	jne    80105728 <_ZN3Map11extractProcEP4proc+0x28>
	}
	root = tempMap.root;
8010573e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105741:	89 03                	mov    %eax,(%ebx)
	return ans;
}
80105743:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80105747:	83 c4 30             	add    $0x30,%esp
8010574a:	5b                   	pop    %ebx
8010574b:	5e                   	pop    %esi
8010574c:	5d                   	pop    %ebp
8010574d:	c3                   	ret    
8010574e:	66 90                	xchg   %ax,%ax
			tempMap.put(otherP); //should scucceed.
80105750:	89 44 24 04          	mov    %eax,0x4(%esp)
80105754:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105757:	89 04 24             	mov    %eax,(%esp)
8010575a:	e8 21 fd ff ff       	call   80105480 <_ZN3Map3putEP4proc>
8010575f:	eb d7                	jmp    80105738 <_ZN3Map11extractProcEP4proc+0x38>
80105761:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return false;
80105768:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
}
8010576c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80105770:	83 c4 30             	add    $0x30,%esp
80105773:	5b                   	pop    %ebx
80105774:	5e                   	pop    %esi
80105775:	5d                   	pop    %ebp
80105776:	c3                   	ret    
80105777:	89 f6                	mov    %esi,%esi
80105779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105780 <extractProcPriorityQueue>:
static boolean extractProcPriorityQueue(Proc *p) {
80105780:	55                   	push   %ebp
80105781:	89 e5                	mov    %esp,%ebp
80105783:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->extractProc(p);
80105786:	8b 45 08             	mov    0x8(%ebp),%eax
80105789:	89 44 24 04          	mov    %eax,0x4(%esp)
8010578d:	a1 1c c6 10 80       	mov    0x8010c61c,%eax
80105792:	89 04 24             	mov    %eax,(%esp)
80105795:	e8 66 ff ff ff       	call   80105700 <_ZN3Map11extractProcEP4proc>
}
8010579a:	c9                   	leave  
	return priorityQ->extractProc(p);
8010579b:	0f b6 c0             	movzbl %al,%eax
}
8010579e:	c3                   	ret    
8010579f:	90                   	nop

801057a0 <__moddi3>:

long long __moddi3(long long number, long long divisor) { //returns number%divisor
801057a0:	55                   	push   %ebp
801057a1:	89 e5                	mov    %esp,%ebp
801057a3:	57                   	push   %edi
801057a4:	56                   	push   %esi
801057a5:	53                   	push   %ebx
801057a6:	83 ec 2c             	sub    $0x2c,%esp
801057a9:	8b 45 08             	mov    0x8(%ebp),%eax
801057ac:	8b 55 0c             	mov    0xc(%ebp),%edx
801057af:	89 45 e0             	mov    %eax,-0x20(%ebp)
801057b2:	8b 45 10             	mov    0x10(%ebp),%eax
801057b5:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801057b8:	8b 55 14             	mov    0x14(%ebp),%edx
801057bb:	89 45 d8             	mov    %eax,-0x28(%ebp)
801057be:	89 d7                	mov    %edx,%edi
	if(divisor == 0)
801057c0:	09 c2                	or     %eax,%edx
801057c2:	0f 84 9a 00 00 00    	je     80105862 <__moddi3+0xc2>
		panic((char*)"divide by zero!!!\n");

	bool isNumberNegative = false;
	if(number < 0) {
801057c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
	bool isNumberNegative = false;
801057cb:	c6 45 df 00          	movb   $0x0,-0x21(%ebp)
	if(number < 0) {
801057cf:	85 c0                	test   %eax,%eax
801057d1:	79 0e                	jns    801057e1 <__moddi3+0x41>
		number = -number;
801057d3:	f7 5d e0             	negl   -0x20(%ebp)
		isNumberNegative = true;
801057d6:	c6 45 df 01          	movb   $0x1,-0x21(%ebp)
		number = -number;
801057da:	83 55 e4 00          	adcl   $0x0,-0x1c(%ebp)
801057de:	f7 5d e4             	negl   -0x1c(%ebp)
801057e1:	8b 55 d8             	mov    -0x28(%ebp),%edx
801057e4:	89 f8                	mov    %edi,%eax
801057e6:	c1 ff 1f             	sar    $0x1f,%edi
801057e9:	31 f8                	xor    %edi,%eax
801057eb:	89 f9                	mov    %edi,%ecx
801057ed:	31 fa                	xor    %edi,%edx
801057ef:	89 c7                	mov    %eax,%edi
801057f1:	8b 45 e0             	mov    -0x20(%ebp),%eax
801057f4:	89 d6                	mov    %edx,%esi
801057f6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801057f9:	29 ce                	sub    %ecx,%esi
801057fb:	19 cf                	sbb    %ecx,%edi
	if(divisor < 0)
		divisor = -divisor;

	for(;;) {
		long long divisor2 = divisor;
		while(number >= divisor2) {
801057fd:	39 fa                	cmp    %edi,%edx
801057ff:	7d 1f                	jge    80105820 <__moddi3+0x80>
			if(divisor2 + divisor2 > 0) //exponential decay.
				divisor2 += divisor2;
		}

		if(number < divisor)
			return isNumberNegative ? -number : number;
80105801:	80 7d df 00          	cmpb   $0x0,-0x21(%ebp)
80105805:	74 07                	je     8010580e <__moddi3+0x6e>
80105807:	f7 d8                	neg    %eax
80105809:	83 d2 00             	adc    $0x0,%edx
8010580c:	f7 da                	neg    %edx
	}
}
8010580e:	83 c4 2c             	add    $0x2c,%esp
80105811:	5b                   	pop    %ebx
80105812:	5e                   	pop    %esi
80105813:	5f                   	pop    %edi
80105814:	5d                   	pop    %ebp
80105815:	c3                   	ret    
80105816:	8d 76 00             	lea    0x0(%esi),%esi
80105819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		while(number >= divisor2) {
80105820:	7f 04                	jg     80105826 <__moddi3+0x86>
80105822:	39 f0                	cmp    %esi,%eax
80105824:	72 db                	jb     80105801 <__moddi3+0x61>
80105826:	89 f1                	mov    %esi,%ecx
80105828:	89 fb                	mov    %edi,%ebx
8010582a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			number -= divisor2;
80105830:	29 c8                	sub    %ecx,%eax
80105832:	19 da                	sbb    %ebx,%edx
				divisor2 += divisor2;
80105834:	0f a4 cb 01          	shld   $0x1,%ecx,%ebx
80105838:	01 c9                	add    %ecx,%ecx
		while(number >= divisor2) {
8010583a:	39 da                	cmp    %ebx,%edx
8010583c:	7f f2                	jg     80105830 <__moddi3+0x90>
8010583e:	7d 18                	jge    80105858 <__moddi3+0xb8>
		if(number < divisor)
80105840:	39 d7                	cmp    %edx,%edi
80105842:	7c b9                	jl     801057fd <__moddi3+0x5d>
80105844:	7f bb                	jg     80105801 <__moddi3+0x61>
80105846:	39 c6                	cmp    %eax,%esi
80105848:	76 b3                	jbe    801057fd <__moddi3+0x5d>
8010584a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105850:	eb af                	jmp    80105801 <__moddi3+0x61>
80105852:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		while(number >= divisor2) {
80105858:	39 c8                	cmp    %ecx,%eax
8010585a:	73 d4                	jae    80105830 <__moddi3+0x90>
8010585c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105860:	eb de                	jmp    80105840 <__moddi3+0xa0>
		panic((char*)"divide by zero!!!\n");
80105862:	c7 04 24 dc 8e 10 80 	movl   $0x80108edc,(%esp)
80105869:	e8 02 ab ff ff       	call   80100370 <panic>
8010586e:	66 90                	xchg   %ax,%ax

80105870 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80105870:	55                   	push   %ebp
  initlock(&lk->lk, "sleep lock");
80105871:	b8 ef 8e 10 80       	mov    $0x80108eef,%eax
{
80105876:	89 e5                	mov    %esp,%ebp
80105878:	53                   	push   %ebx
80105879:	83 ec 14             	sub    $0x14,%esp
8010587c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010587f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105883:	8d 43 04             	lea    0x4(%ebx),%eax
80105886:	89 04 24             	mov    %eax,(%esp)
80105889:	e8 12 01 00 00       	call   801059a0 <initlock>
  lk->name = name;
8010588e:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80105891:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80105897:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010589e:	89 43 38             	mov    %eax,0x38(%ebx)
}
801058a1:	83 c4 14             	add    $0x14,%esp
801058a4:	5b                   	pop    %ebx
801058a5:	5d                   	pop    %ebp
801058a6:	c3                   	ret    
801058a7:	89 f6                	mov    %esi,%esi
801058a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058b0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801058b0:	55                   	push   %ebp
801058b1:	89 e5                	mov    %esp,%ebp
801058b3:	56                   	push   %esi
801058b4:	53                   	push   %ebx
801058b5:	83 ec 10             	sub    $0x10,%esp
801058b8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801058bb:	8d 73 04             	lea    0x4(%ebx),%esi
801058be:	89 34 24             	mov    %esi,(%esp)
801058c1:	e8 2a 02 00 00       	call   80105af0 <acquire>
  while (lk->locked) {
801058c6:	8b 13                	mov    (%ebx),%edx
801058c8:	85 d2                	test   %edx,%edx
801058ca:	74 16                	je     801058e2 <acquiresleep+0x32>
801058cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
801058d0:	89 74 24 04          	mov    %esi,0x4(%esp)
801058d4:	89 1c 24             	mov    %ebx,(%esp)
801058d7:	e8 d4 eb ff ff       	call   801044b0 <sleep>
  while (lk->locked) {
801058dc:	8b 03                	mov    (%ebx),%eax
801058de:	85 c0                	test   %eax,%eax
801058e0:	75 ee                	jne    801058d0 <acquiresleep+0x20>
  }
  lk->locked = 1;
801058e2:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801058e8:	e8 b3 e0 ff ff       	call   801039a0 <myproc>
801058ed:	8b 40 10             	mov    0x10(%eax),%eax
801058f0:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801058f3:	89 75 08             	mov    %esi,0x8(%ebp)
}
801058f6:	83 c4 10             	add    $0x10,%esp
801058f9:	5b                   	pop    %ebx
801058fa:	5e                   	pop    %esi
801058fb:	5d                   	pop    %ebp
  release(&lk->lk);
801058fc:	e9 8f 02 00 00       	jmp    80105b90 <release>
80105901:	eb 0d                	jmp    80105910 <releasesleep>
80105903:	90                   	nop
80105904:	90                   	nop
80105905:	90                   	nop
80105906:	90                   	nop
80105907:	90                   	nop
80105908:	90                   	nop
80105909:	90                   	nop
8010590a:	90                   	nop
8010590b:	90                   	nop
8010590c:	90                   	nop
8010590d:	90                   	nop
8010590e:	90                   	nop
8010590f:	90                   	nop

80105910 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80105910:	55                   	push   %ebp
80105911:	89 e5                	mov    %esp,%ebp
80105913:	83 ec 18             	sub    $0x18,%esp
80105916:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105919:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010591c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  acquire(&lk->lk);
8010591f:	8d 73 04             	lea    0x4(%ebx),%esi
80105922:	89 34 24             	mov    %esi,(%esp)
80105925:	e8 c6 01 00 00       	call   80105af0 <acquire>
  lk->locked = 0;
8010592a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80105930:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80105937:	89 1c 24             	mov    %ebx,(%esp)
8010593a:	e8 71 ed ff ff       	call   801046b0 <wakeup>
  release(&lk->lk);
}
8010593f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  release(&lk->lk);
80105942:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105945:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105948:	89 ec                	mov    %ebp,%esp
8010594a:	5d                   	pop    %ebp
  release(&lk->lk);
8010594b:	e9 40 02 00 00       	jmp    80105b90 <release>

80105950 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80105950:	55                   	push   %ebp
80105951:	89 e5                	mov    %esp,%ebp
80105953:	83 ec 28             	sub    $0x28,%esp
80105956:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80105959:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010595c:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010595f:	89 75 f8             	mov    %esi,-0x8(%ebp)
80105962:	31 f6                	xor    %esi,%esi
  int r;
  
  acquire(&lk->lk);
80105964:	8d 7b 04             	lea    0x4(%ebx),%edi
80105967:	89 3c 24             	mov    %edi,(%esp)
8010596a:	e8 81 01 00 00       	call   80105af0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
8010596f:	8b 03                	mov    (%ebx),%eax
80105971:	85 c0                	test   %eax,%eax
80105973:	74 11                	je     80105986 <holdingsleep+0x36>
80105975:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80105978:	e8 23 e0 ff ff       	call   801039a0 <myproc>
8010597d:	39 58 10             	cmp    %ebx,0x10(%eax)
80105980:	0f 94 c0             	sete   %al
80105983:	0f b6 f0             	movzbl %al,%esi
  release(&lk->lk);
80105986:	89 3c 24             	mov    %edi,(%esp)
80105989:	e8 02 02 00 00       	call   80105b90 <release>
  return r;
}
8010598e:	89 f0                	mov    %esi,%eax
80105990:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105993:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105996:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105999:	89 ec                	mov    %ebp,%esp
8010599b:	5d                   	pop    %ebp
8010599c:	c3                   	ret    
8010599d:	66 90                	xchg   %ax,%ax
8010599f:	90                   	nop

801059a0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801059a0:	55                   	push   %ebp
801059a1:	89 e5                	mov    %esp,%ebp
801059a3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801059a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801059a9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801059af:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801059b2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801059b9:	5d                   	pop    %ebp
801059ba:	c3                   	ret    
801059bb:	90                   	nop
801059bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801059c0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801059c0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801059c1:	31 d2                	xor    %edx,%edx
{
801059c3:	89 e5                	mov    %esp,%ebp
  ebp = (uint*)v - 2;
801059c5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801059c8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801059cb:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801059cc:	83 e8 08             	sub    $0x8,%eax
801059cf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801059d0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801059d6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801059dc:	77 12                	ja     801059f0 <getcallerpcs+0x30>
      break;
    pcs[i] = ebp[1];     // saved %eip
801059de:	8b 58 04             	mov    0x4(%eax),%ebx
801059e1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801059e4:	42                   	inc    %edx
801059e5:	83 fa 0a             	cmp    $0xa,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801059e8:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801059ea:	75 e4                	jne    801059d0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801059ec:	5b                   	pop    %ebx
801059ed:	5d                   	pop    %ebp
801059ee:	c3                   	ret    
801059ef:	90                   	nop
801059f0:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801059f3:	83 c1 28             	add    $0x28,%ecx
801059f6:	8d 76 00             	lea    0x0(%esi),%esi
801059f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80105a00:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105a06:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105a09:	39 c1                	cmp    %eax,%ecx
80105a0b:	75 f3                	jne    80105a00 <getcallerpcs+0x40>
}
80105a0d:	5b                   	pop    %ebx
80105a0e:	5d                   	pop    %ebp
80105a0f:	c3                   	ret    

80105a10 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105a10:	55                   	push   %ebp
80105a11:	89 e5                	mov    %esp,%ebp
80105a13:	53                   	push   %ebx
80105a14:	83 ec 04             	sub    $0x4,%esp
80105a17:	9c                   	pushf  
80105a18:	5b                   	pop    %ebx
  asm volatile("cli");
80105a19:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80105a1a:	e8 e1 de ff ff       	call   80103900 <mycpu>
80105a1f:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105a25:	85 d2                	test   %edx,%edx
80105a27:	75 11                	jne    80105a3a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80105a29:	e8 d2 de ff ff       	call   80103900 <mycpu>
80105a2e:	81 e3 00 02 00 00    	and    $0x200,%ebx
80105a34:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
80105a3a:	e8 c1 de ff ff       	call   80103900 <mycpu>
80105a3f:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
80105a45:	58                   	pop    %eax
80105a46:	5b                   	pop    %ebx
80105a47:	5d                   	pop    %ebp
80105a48:	c3                   	ret    
80105a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105a50 <popcli>:

void
popcli(void)
{
80105a50:	55                   	push   %ebp
80105a51:	89 e5                	mov    %esp,%ebp
80105a53:	83 ec 18             	sub    $0x18,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105a56:	9c                   	pushf  
80105a57:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80105a58:	f6 c4 02             	test   $0x2,%ah
80105a5b:	75 35                	jne    80105a92 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80105a5d:	e8 9e de ff ff       	call   80103900 <mycpu>
80105a62:	ff 88 a4 00 00 00    	decl   0xa4(%eax)
80105a68:	78 34                	js     80105a9e <popcli+0x4e>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105a6a:	e8 91 de ff ff       	call   80103900 <mycpu>
80105a6f:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105a75:	85 d2                	test   %edx,%edx
80105a77:	74 07                	je     80105a80 <popcli+0x30>
    sti();
}
80105a79:	c9                   	leave  
80105a7a:	c3                   	ret    
80105a7b:	90                   	nop
80105a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105a80:	e8 7b de ff ff       	call   80103900 <mycpu>
80105a85:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80105a8b:	85 c0                	test   %eax,%eax
80105a8d:	74 ea                	je     80105a79 <popcli+0x29>
  asm volatile("sti");
80105a8f:	fb                   	sti    
}
80105a90:	c9                   	leave  
80105a91:	c3                   	ret    
    panic("popcli - interruptible");
80105a92:	c7 04 24 fa 8e 10 80 	movl   $0x80108efa,(%esp)
80105a99:	e8 d2 a8 ff ff       	call   80100370 <panic>
    panic("popcli");
80105a9e:	c7 04 24 11 8f 10 80 	movl   $0x80108f11,(%esp)
80105aa5:	e8 c6 a8 ff ff       	call   80100370 <panic>
80105aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105ab0 <holding>:
{
80105ab0:	55                   	push   %ebp
80105ab1:	89 e5                	mov    %esp,%ebp
80105ab3:	83 ec 08             	sub    $0x8,%esp
80105ab6:	89 75 fc             	mov    %esi,-0x4(%ebp)
80105ab9:	8b 75 08             	mov    0x8(%ebp),%esi
80105abc:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105abf:	31 db                	xor    %ebx,%ebx
  pushcli();
80105ac1:	e8 4a ff ff ff       	call   80105a10 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105ac6:	8b 06                	mov    (%esi),%eax
80105ac8:	85 c0                	test   %eax,%eax
80105aca:	74 10                	je     80105adc <holding+0x2c>
80105acc:	8b 5e 08             	mov    0x8(%esi),%ebx
80105acf:	e8 2c de ff ff       	call   80103900 <mycpu>
80105ad4:	39 c3                	cmp    %eax,%ebx
80105ad6:	0f 94 c3             	sete   %bl
80105ad9:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80105adc:	e8 6f ff ff ff       	call   80105a50 <popcli>
}
80105ae1:	89 d8                	mov    %ebx,%eax
80105ae3:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105ae6:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105ae9:	89 ec                	mov    %ebp,%esp
80105aeb:	5d                   	pop    %ebp
80105aec:	c3                   	ret    
80105aed:	8d 76 00             	lea    0x0(%esi),%esi

80105af0 <acquire>:
{
80105af0:	55                   	push   %ebp
80105af1:	89 e5                	mov    %esp,%ebp
80105af3:	56                   	push   %esi
80105af4:	53                   	push   %ebx
80105af5:	83 ec 10             	sub    $0x10,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105af8:	e8 13 ff ff ff       	call   80105a10 <pushcli>
  if(holding(lk))
80105afd:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105b00:	89 1c 24             	mov    %ebx,(%esp)
80105b03:	e8 a8 ff ff ff       	call   80105ab0 <holding>
80105b08:	85 c0                	test   %eax,%eax
80105b0a:	75 78                	jne    80105b84 <acquire+0x94>
80105b0c:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80105b0e:	ba 01 00 00 00       	mov    $0x1,%edx
80105b13:	eb 06                	jmp    80105b1b <acquire+0x2b>
80105b15:	8d 76 00             	lea    0x0(%esi),%esi
80105b18:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105b1b:	89 d0                	mov    %edx,%eax
80105b1d:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80105b20:	85 c0                	test   %eax,%eax
80105b22:	75 f4                	jne    80105b18 <acquire+0x28>
  __sync_synchronize();
80105b24:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80105b29:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105b2c:	e8 cf dd ff ff       	call   80103900 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80105b31:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
80105b34:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80105b37:	89 e8                	mov    %ebp,%eax
80105b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105b40:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
80105b46:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80105b4c:	77 1a                	ja     80105b68 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
80105b4e:	8b 48 04             	mov    0x4(%eax),%ecx
80105b51:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
80105b54:	46                   	inc    %esi
80105b55:	83 fe 0a             	cmp    $0xa,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80105b58:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105b5a:	75 e4                	jne    80105b40 <acquire+0x50>
}
80105b5c:	83 c4 10             	add    $0x10,%esp
80105b5f:	5b                   	pop    %ebx
80105b60:	5e                   	pop    %esi
80105b61:	5d                   	pop    %ebp
80105b62:	c3                   	ret    
80105b63:	90                   	nop
80105b64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b68:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80105b6b:	83 c2 28             	add    $0x28,%edx
80105b6e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105b70:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105b76:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105b79:	39 d0                	cmp    %edx,%eax
80105b7b:	75 f3                	jne    80105b70 <acquire+0x80>
}
80105b7d:	83 c4 10             	add    $0x10,%esp
80105b80:	5b                   	pop    %ebx
80105b81:	5e                   	pop    %esi
80105b82:	5d                   	pop    %ebp
80105b83:	c3                   	ret    
    panic("acquire");
80105b84:	c7 04 24 18 8f 10 80 	movl   $0x80108f18,(%esp)
80105b8b:	e8 e0 a7 ff ff       	call   80100370 <panic>

80105b90 <release>:
{
80105b90:	55                   	push   %ebp
80105b91:	89 e5                	mov    %esp,%ebp
80105b93:	53                   	push   %ebx
80105b94:	83 ec 14             	sub    $0x14,%esp
80105b97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80105b9a:	89 1c 24             	mov    %ebx,(%esp)
80105b9d:	e8 0e ff ff ff       	call   80105ab0 <holding>
80105ba2:	85 c0                	test   %eax,%eax
80105ba4:	74 23                	je     80105bc9 <release+0x39>
  lk->pcs[0] = 0;
80105ba6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105bad:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105bb4:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80105bb9:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105bbf:	83 c4 14             	add    $0x14,%esp
80105bc2:	5b                   	pop    %ebx
80105bc3:	5d                   	pop    %ebp
  popcli();
80105bc4:	e9 87 fe ff ff       	jmp    80105a50 <popcli>
    panic("release");
80105bc9:	c7 04 24 20 8f 10 80 	movl   $0x80108f20,(%esp)
80105bd0:	e8 9b a7 ff ff       	call   80100370 <panic>
80105bd5:	66 90                	xchg   %ax,%ax
80105bd7:	66 90                	xchg   %ax,%ax
80105bd9:	66 90                	xchg   %ax,%ax
80105bdb:	66 90                	xchg   %ax,%ax
80105bdd:	66 90                	xchg   %ax,%ax
80105bdf:	90                   	nop

80105be0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105be0:	55                   	push   %ebp
80105be1:	89 e5                	mov    %esp,%ebp
80105be3:	83 ec 08             	sub    $0x8,%esp
80105be6:	8b 55 08             	mov    0x8(%ebp),%edx
80105be9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105bec:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105bef:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if ((int)dst%4 == 0 && n%4 == 0){
80105bf2:	f6 c2 03             	test   $0x3,%dl
80105bf5:	75 05                	jne    80105bfc <memset+0x1c>
80105bf7:	f6 c1 03             	test   $0x3,%cl
80105bfa:	74 14                	je     80105c10 <memset+0x30>
  asm volatile("cld; rep stosb" :
80105bfc:	89 d7                	mov    %edx,%edi
80105bfe:	8b 45 0c             	mov    0xc(%ebp),%eax
80105c01:	fc                   	cld    
80105c02:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80105c04:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105c07:	89 d0                	mov    %edx,%eax
80105c09:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105c0c:	89 ec                	mov    %ebp,%esp
80105c0e:	5d                   	pop    %ebp
80105c0f:	c3                   	ret    
    c &= 0xFF;
80105c10:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80105c14:	c1 e9 02             	shr    $0x2,%ecx
80105c17:	89 f8                	mov    %edi,%eax
80105c19:	89 fb                	mov    %edi,%ebx
80105c1b:	c1 e0 18             	shl    $0x18,%eax
80105c1e:	c1 e3 10             	shl    $0x10,%ebx
80105c21:	09 d8                	or     %ebx,%eax
80105c23:	09 f8                	or     %edi,%eax
80105c25:	c1 e7 08             	shl    $0x8,%edi
80105c28:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80105c2a:	89 d7                	mov    %edx,%edi
80105c2c:	fc                   	cld    
80105c2d:	f3 ab                	rep stos %eax,%es:(%edi)
}
80105c2f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105c32:	89 d0                	mov    %edx,%eax
80105c34:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105c37:	89 ec                	mov    %ebp,%esp
80105c39:	5d                   	pop    %ebp
80105c3a:	c3                   	ret    
80105c3b:	90                   	nop
80105c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c40 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105c40:	55                   	push   %ebp
80105c41:	89 e5                	mov    %esp,%ebp
80105c43:	57                   	push   %edi
80105c44:	8b 7d 0c             	mov    0xc(%ebp),%edi
80105c47:	56                   	push   %esi
80105c48:	8b 75 08             	mov    0x8(%ebp),%esi
80105c4b:	53                   	push   %ebx
80105c4c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105c4f:	85 db                	test   %ebx,%ebx
80105c51:	74 27                	je     80105c7a <memcmp+0x3a>
    if(*s1 != *s2)
80105c53:	0f b6 16             	movzbl (%esi),%edx
80105c56:	0f b6 0f             	movzbl (%edi),%ecx
80105c59:	38 d1                	cmp    %dl,%cl
80105c5b:	75 2b                	jne    80105c88 <memcmp+0x48>
80105c5d:	b8 01 00 00 00       	mov    $0x1,%eax
80105c62:	eb 12                	jmp    80105c76 <memcmp+0x36>
80105c64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c68:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80105c6c:	40                   	inc    %eax
80105c6d:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80105c72:	38 ca                	cmp    %cl,%dl
80105c74:	75 12                	jne    80105c88 <memcmp+0x48>
  while(n-- > 0){
80105c76:	39 d8                	cmp    %ebx,%eax
80105c78:	75 ee                	jne    80105c68 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80105c7a:	5b                   	pop    %ebx
  return 0;
80105c7b:	31 c0                	xor    %eax,%eax
}
80105c7d:	5e                   	pop    %esi
80105c7e:	5f                   	pop    %edi
80105c7f:	5d                   	pop    %ebp
80105c80:	c3                   	ret    
80105c81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c88:	5b                   	pop    %ebx
      return *s1 - *s2;
80105c89:	0f b6 c2             	movzbl %dl,%eax
80105c8c:	29 c8                	sub    %ecx,%eax
}
80105c8e:	5e                   	pop    %esi
80105c8f:	5f                   	pop    %edi
80105c90:	5d                   	pop    %ebp
80105c91:	c3                   	ret    
80105c92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ca0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105ca0:	55                   	push   %ebp
80105ca1:	89 e5                	mov    %esp,%ebp
80105ca3:	56                   	push   %esi
80105ca4:	8b 45 08             	mov    0x8(%ebp),%eax
80105ca7:	53                   	push   %ebx
80105ca8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80105cab:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80105cae:	39 c3                	cmp    %eax,%ebx
80105cb0:	73 26                	jae    80105cd8 <memmove+0x38>
80105cb2:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80105cb5:	39 c8                	cmp    %ecx,%eax
80105cb7:	73 1f                	jae    80105cd8 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80105cb9:	85 f6                	test   %esi,%esi
80105cbb:	8d 56 ff             	lea    -0x1(%esi),%edx
80105cbe:	74 0d                	je     80105ccd <memmove+0x2d>
      *--d = *--s;
80105cc0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105cc4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80105cc7:	4a                   	dec    %edx
80105cc8:	83 fa ff             	cmp    $0xffffffff,%edx
80105ccb:	75 f3                	jne    80105cc0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80105ccd:	5b                   	pop    %ebx
80105cce:	5e                   	pop    %esi
80105ccf:	5d                   	pop    %ebp
80105cd0:	c3                   	ret    
80105cd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80105cd8:	31 d2                	xor    %edx,%edx
80105cda:	85 f6                	test   %esi,%esi
80105cdc:	74 ef                	je     80105ccd <memmove+0x2d>
80105cde:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80105ce0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105ce4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80105ce7:	42                   	inc    %edx
    while(n-- > 0)
80105ce8:	39 d6                	cmp    %edx,%esi
80105cea:	75 f4                	jne    80105ce0 <memmove+0x40>
}
80105cec:	5b                   	pop    %ebx
80105ced:	5e                   	pop    %esi
80105cee:	5d                   	pop    %ebp
80105cef:	c3                   	ret    

80105cf0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105cf0:	55                   	push   %ebp
80105cf1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80105cf3:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80105cf4:	eb aa                	jmp    80105ca0 <memmove>
80105cf6:	8d 76 00             	lea    0x0(%esi),%esi
80105cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105d00 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80105d00:	55                   	push   %ebp
80105d01:	89 e5                	mov    %esp,%ebp
80105d03:	57                   	push   %edi
80105d04:	8b 7d 10             	mov    0x10(%ebp),%edi
80105d07:	56                   	push   %esi
80105d08:	8b 75 0c             	mov    0xc(%ebp),%esi
80105d0b:	53                   	push   %ebx
80105d0c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
80105d0f:	85 ff                	test   %edi,%edi
80105d11:	74 2d                	je     80105d40 <strncmp+0x40>
80105d13:	0f b6 03             	movzbl (%ebx),%eax
80105d16:	0f b6 0e             	movzbl (%esi),%ecx
80105d19:	84 c0                	test   %al,%al
80105d1b:	74 37                	je     80105d54 <strncmp+0x54>
80105d1d:	38 c1                	cmp    %al,%cl
80105d1f:	75 33                	jne    80105d54 <strncmp+0x54>
80105d21:	01 f7                	add    %esi,%edi
80105d23:	eb 13                	jmp    80105d38 <strncmp+0x38>
80105d25:	8d 76 00             	lea    0x0(%esi),%esi
80105d28:	0f b6 03             	movzbl (%ebx),%eax
80105d2b:	84 c0                	test   %al,%al
80105d2d:	74 21                	je     80105d50 <strncmp+0x50>
80105d2f:	0f b6 0a             	movzbl (%edx),%ecx
80105d32:	89 d6                	mov    %edx,%esi
80105d34:	38 c8                	cmp    %cl,%al
80105d36:	75 1c                	jne    80105d54 <strncmp+0x54>
    n--, p++, q++;
80105d38:	8d 56 01             	lea    0x1(%esi),%edx
80105d3b:	43                   	inc    %ebx
  while(n > 0 && *p && *p == *q)
80105d3c:	39 fa                	cmp    %edi,%edx
80105d3e:	75 e8                	jne    80105d28 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80105d40:	5b                   	pop    %ebx
    return 0;
80105d41:	31 c0                	xor    %eax,%eax
}
80105d43:	5e                   	pop    %esi
80105d44:	5f                   	pop    %edi
80105d45:	5d                   	pop    %ebp
80105d46:	c3                   	ret    
80105d47:	89 f6                	mov    %esi,%esi
80105d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105d50:	0f b6 4e 01          	movzbl 0x1(%esi),%ecx
80105d54:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
80105d55:	29 c8                	sub    %ecx,%eax
}
80105d57:	5e                   	pop    %esi
80105d58:	5f                   	pop    %edi
80105d59:	5d                   	pop    %ebp
80105d5a:	c3                   	ret    
80105d5b:	90                   	nop
80105d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d60 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105d60:	55                   	push   %ebp
80105d61:	89 e5                	mov    %esp,%ebp
80105d63:	8b 45 08             	mov    0x8(%ebp),%eax
80105d66:	56                   	push   %esi
80105d67:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105d6a:	53                   	push   %ebx
80105d6b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80105d6e:	89 c2                	mov    %eax,%edx
80105d70:	eb 15                	jmp    80105d87 <strncpy+0x27>
80105d72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105d78:	46                   	inc    %esi
80105d79:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
80105d7d:	42                   	inc    %edx
80105d7e:	84 c9                	test   %cl,%cl
80105d80:	88 4a ff             	mov    %cl,-0x1(%edx)
80105d83:	74 09                	je     80105d8e <strncpy+0x2e>
80105d85:	89 d9                	mov    %ebx,%ecx
80105d87:	85 c9                	test   %ecx,%ecx
80105d89:	8d 59 ff             	lea    -0x1(%ecx),%ebx
80105d8c:	7f ea                	jg     80105d78 <strncpy+0x18>
    ;
  while(n-- > 0)
80105d8e:	31 c9                	xor    %ecx,%ecx
80105d90:	85 db                	test   %ebx,%ebx
80105d92:	7e 19                	jle    80105dad <strncpy+0x4d>
80105d94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105d9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *s++ = 0;
80105da0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80105da4:	89 de                	mov    %ebx,%esi
80105da6:	41                   	inc    %ecx
80105da7:	29 ce                	sub    %ecx,%esi
  while(n-- > 0)
80105da9:	85 f6                	test   %esi,%esi
80105dab:	7f f3                	jg     80105da0 <strncpy+0x40>
  return os;
}
80105dad:	5b                   	pop    %ebx
80105dae:	5e                   	pop    %esi
80105daf:	5d                   	pop    %ebp
80105db0:	c3                   	ret    
80105db1:	eb 0d                	jmp    80105dc0 <safestrcpy>
80105db3:	90                   	nop
80105db4:	90                   	nop
80105db5:	90                   	nop
80105db6:	90                   	nop
80105db7:	90                   	nop
80105db8:	90                   	nop
80105db9:	90                   	nop
80105dba:	90                   	nop
80105dbb:	90                   	nop
80105dbc:	90                   	nop
80105dbd:	90                   	nop
80105dbe:	90                   	nop
80105dbf:	90                   	nop

80105dc0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105dc0:	55                   	push   %ebp
80105dc1:	89 e5                	mov    %esp,%ebp
80105dc3:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105dc6:	56                   	push   %esi
80105dc7:	8b 45 08             	mov    0x8(%ebp),%eax
80105dca:	53                   	push   %ebx
80105dcb:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80105dce:	85 c9                	test   %ecx,%ecx
80105dd0:	7e 22                	jle    80105df4 <safestrcpy+0x34>
80105dd2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80105dd6:	89 c1                	mov    %eax,%ecx
80105dd8:	eb 13                	jmp    80105ded <safestrcpy+0x2d>
80105dda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105de0:	42                   	inc    %edx
80105de1:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80105de5:	41                   	inc    %ecx
80105de6:	84 db                	test   %bl,%bl
80105de8:	88 59 ff             	mov    %bl,-0x1(%ecx)
80105deb:	74 04                	je     80105df1 <safestrcpy+0x31>
80105ded:	39 f2                	cmp    %esi,%edx
80105def:	75 ef                	jne    80105de0 <safestrcpy+0x20>
    ;
  *s = 0;
80105df1:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80105df4:	5b                   	pop    %ebx
80105df5:	5e                   	pop    %esi
80105df6:	5d                   	pop    %ebp
80105df7:	c3                   	ret    
80105df8:	90                   	nop
80105df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e00 <strlen>:

int
strlen(const char *s)
{
80105e00:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105e01:	31 c0                	xor    %eax,%eax
{
80105e03:	89 e5                	mov    %esp,%ebp
80105e05:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105e08:	80 3a 00             	cmpb   $0x0,(%edx)
80105e0b:	74 0a                	je     80105e17 <strlen+0x17>
80105e0d:	8d 76 00             	lea    0x0(%esi),%esi
80105e10:	40                   	inc    %eax
80105e11:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105e15:	75 f9                	jne    80105e10 <strlen+0x10>
    ;
  return n;
}
80105e17:	5d                   	pop    %ebp
80105e18:	c3                   	ret    

80105e19 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80105e19:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80105e1d:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80105e21:	55                   	push   %ebp
  pushl %ebx
80105e22:	53                   	push   %ebx
  pushl %esi
80105e23:	56                   	push   %esi
  pushl %edi
80105e24:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105e25:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105e27:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80105e29:	5f                   	pop    %edi
  popl %esi
80105e2a:	5e                   	pop    %esi
  popl %ebx
80105e2b:	5b                   	pop    %ebx
  popl %ebp
80105e2c:	5d                   	pop    %ebp
  ret
80105e2d:	c3                   	ret    
80105e2e:	66 90                	xchg   %ax,%ax

80105e30 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105e30:	55                   	push   %ebp
80105e31:	89 e5                	mov    %esp,%ebp
80105e33:	53                   	push   %ebx
80105e34:	83 ec 04             	sub    $0x4,%esp
80105e37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80105e3a:	e8 61 db ff ff       	call   801039a0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105e3f:	8b 00                	mov    (%eax),%eax
80105e41:	39 d8                	cmp    %ebx,%eax
80105e43:	76 1b                	jbe    80105e60 <fetchint+0x30>
80105e45:	8d 53 04             	lea    0x4(%ebx),%edx
80105e48:	39 d0                	cmp    %edx,%eax
80105e4a:	72 14                	jb     80105e60 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80105e4c:	8b 45 0c             	mov    0xc(%ebp),%eax
80105e4f:	8b 13                	mov    (%ebx),%edx
80105e51:	89 10                	mov    %edx,(%eax)
  return 0;
80105e53:	31 c0                	xor    %eax,%eax
}
80105e55:	5a                   	pop    %edx
80105e56:	5b                   	pop    %ebx
80105e57:	5d                   	pop    %ebp
80105e58:	c3                   	ret    
80105e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105e60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e65:	eb ee                	jmp    80105e55 <fetchint+0x25>
80105e67:	89 f6                	mov    %esi,%esi
80105e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e70 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105e70:	55                   	push   %ebp
80105e71:	89 e5                	mov    %esp,%ebp
80105e73:	53                   	push   %ebx
80105e74:	83 ec 04             	sub    $0x4,%esp
80105e77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80105e7a:	e8 21 db ff ff       	call   801039a0 <myproc>

  if(addr >= curproc->sz)
80105e7f:	39 18                	cmp    %ebx,(%eax)
80105e81:	76 27                	jbe    80105eaa <fetchstr+0x3a>
    return -1;
  *pp = (char*)addr;
80105e83:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105e86:	89 da                	mov    %ebx,%edx
80105e88:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80105e8a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80105e8c:	39 c3                	cmp    %eax,%ebx
80105e8e:	73 1a                	jae    80105eaa <fetchstr+0x3a>
    if(*s == 0)
80105e90:	80 3b 00             	cmpb   $0x0,(%ebx)
80105e93:	75 10                	jne    80105ea5 <fetchstr+0x35>
80105e95:	eb 29                	jmp    80105ec0 <fetchstr+0x50>
80105e97:	89 f6                	mov    %esi,%esi
80105e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105ea0:	80 3a 00             	cmpb   $0x0,(%edx)
80105ea3:	74 13                	je     80105eb8 <fetchstr+0x48>
  for(s = *pp; s < ep; s++){
80105ea5:	42                   	inc    %edx
80105ea6:	39 d0                	cmp    %edx,%eax
80105ea8:	77 f6                	ja     80105ea0 <fetchstr+0x30>
    return -1;
80105eaa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80105eaf:	5a                   	pop    %edx
80105eb0:	5b                   	pop    %ebx
80105eb1:	5d                   	pop    %ebp
80105eb2:	c3                   	ret    
80105eb3:	90                   	nop
80105eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105eb8:	89 d0                	mov    %edx,%eax
80105eba:	5a                   	pop    %edx
80105ebb:	29 d8                	sub    %ebx,%eax
80105ebd:	5b                   	pop    %ebx
80105ebe:	5d                   	pop    %ebp
80105ebf:	c3                   	ret    
    if(*s == 0)
80105ec0:	31 c0                	xor    %eax,%eax
      return s - *pp;
80105ec2:	eb eb                	jmp    80105eaf <fetchstr+0x3f>
80105ec4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105eca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105ed0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105ed0:	55                   	push   %ebp
80105ed1:	89 e5                	mov    %esp,%ebp
80105ed3:	56                   	push   %esi
80105ed4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105ed5:	e8 c6 da ff ff       	call   801039a0 <myproc>
80105eda:	8b 55 08             	mov    0x8(%ebp),%edx
80105edd:	8b 40 18             	mov    0x18(%eax),%eax
80105ee0:	8b 40 44             	mov    0x44(%eax),%eax
80105ee3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105ee6:	e8 b5 da ff ff       	call   801039a0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105eeb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105eee:	8b 00                	mov    (%eax),%eax
80105ef0:	39 c6                	cmp    %eax,%esi
80105ef2:	73 1c                	jae    80105f10 <argint+0x40>
80105ef4:	8d 53 08             	lea    0x8(%ebx),%edx
80105ef7:	39 d0                	cmp    %edx,%eax
80105ef9:	72 15                	jb     80105f10 <argint+0x40>
  *ip = *(int*)(addr);
80105efb:	8b 45 0c             	mov    0xc(%ebp),%eax
80105efe:	8b 53 04             	mov    0x4(%ebx),%edx
80105f01:	89 10                	mov    %edx,(%eax)
  return 0;
80105f03:	31 c0                	xor    %eax,%eax
}
80105f05:	5b                   	pop    %ebx
80105f06:	5e                   	pop    %esi
80105f07:	5d                   	pop    %ebp
80105f08:	c3                   	ret    
80105f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105f10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105f15:	eb ee                	jmp    80105f05 <argint+0x35>
80105f17:	89 f6                	mov    %esi,%esi
80105f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105f20 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105f20:	55                   	push   %ebp
80105f21:	89 e5                	mov    %esp,%ebp
80105f23:	56                   	push   %esi
80105f24:	53                   	push   %ebx
80105f25:	83 ec 20             	sub    $0x20,%esp
80105f28:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80105f2b:	e8 70 da ff ff       	call   801039a0 <myproc>
80105f30:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80105f32:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f35:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f39:	8b 45 08             	mov    0x8(%ebp),%eax
80105f3c:	89 04 24             	mov    %eax,(%esp)
80105f3f:	e8 8c ff ff ff       	call   80105ed0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105f44:	c1 e8 1f             	shr    $0x1f,%eax
80105f47:	84 c0                	test   %al,%al
80105f49:	75 2d                	jne    80105f78 <argptr+0x58>
80105f4b:	89 d8                	mov    %ebx,%eax
80105f4d:	c1 e8 1f             	shr    $0x1f,%eax
80105f50:	84 c0                	test   %al,%al
80105f52:	75 24                	jne    80105f78 <argptr+0x58>
80105f54:	8b 16                	mov    (%esi),%edx
80105f56:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f59:	39 c2                	cmp    %eax,%edx
80105f5b:	76 1b                	jbe    80105f78 <argptr+0x58>
80105f5d:	01 c3                	add    %eax,%ebx
80105f5f:	39 da                	cmp    %ebx,%edx
80105f61:	72 15                	jb     80105f78 <argptr+0x58>
    return -1;
  *pp = (char*)i;
80105f63:	8b 55 0c             	mov    0xc(%ebp),%edx
80105f66:	89 02                	mov    %eax,(%edx)
  return 0;
80105f68:	31 c0                	xor    %eax,%eax
}
80105f6a:	83 c4 20             	add    $0x20,%esp
80105f6d:	5b                   	pop    %ebx
80105f6e:	5e                   	pop    %esi
80105f6f:	5d                   	pop    %ebp
80105f70:	c3                   	ret    
80105f71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105f78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f7d:	eb eb                	jmp    80105f6a <argptr+0x4a>
80105f7f:	90                   	nop

80105f80 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105f80:	55                   	push   %ebp
80105f81:	89 e5                	mov    %esp,%ebp
80105f83:	83 ec 28             	sub    $0x28,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105f86:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f89:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f8d:	8b 45 08             	mov    0x8(%ebp),%eax
80105f90:	89 04 24             	mov    %eax,(%esp)
80105f93:	e8 38 ff ff ff       	call   80105ed0 <argint>
80105f98:	85 c0                	test   %eax,%eax
80105f9a:	78 14                	js     80105fb0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80105f9c:	8b 45 0c             	mov    0xc(%ebp),%eax
80105f9f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105fa3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105fa6:	89 04 24             	mov    %eax,(%esp)
80105fa9:	e8 c2 fe ff ff       	call   80105e70 <fetchstr>
}
80105fae:	c9                   	leave  
80105faf:	c3                   	ret    
    return -1;
80105fb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105fb5:	c9                   	leave  
80105fb6:	c3                   	ret    
80105fb7:	89 f6                	mov    %esi,%esi
80105fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105fc0 <syscall>:
[SYS_wait_stat] sys_wait_stat,
};

void
syscall(void)
{
80105fc0:	55                   	push   %ebp
80105fc1:	89 e5                	mov    %esp,%ebp
80105fc3:	53                   	push   %ebx
80105fc4:	83 ec 14             	sub    $0x14,%esp
  int num;
  struct proc *curproc = myproc();
80105fc7:	e8 d4 d9 ff ff       	call   801039a0 <myproc>
80105fcc:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80105fce:	8b 40 18             	mov    0x18(%eax),%eax
80105fd1:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105fd4:	8d 50 ff             	lea    -0x1(%eax),%edx
80105fd7:	83 fa 18             	cmp    $0x18,%edx
80105fda:	77 1c                	ja     80105ff8 <syscall+0x38>
80105fdc:	8b 14 85 60 8f 10 80 	mov    -0x7fef70a0(,%eax,4),%edx
80105fe3:	85 d2                	test   %edx,%edx
80105fe5:	74 11                	je     80105ff8 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80105fe7:	ff d2                	call   *%edx
80105fe9:	8b 53 18             	mov    0x18(%ebx),%edx
80105fec:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105fef:	83 c4 14             	add    $0x14,%esp
80105ff2:	5b                   	pop    %ebx
80105ff3:	5d                   	pop    %ebp
80105ff4:	c3                   	ret    
80105ff5:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80105ff8:	89 44 24 0c          	mov    %eax,0xc(%esp)
            curproc->pid, curproc->name, num);
80105ffc:	8d 43 6c             	lea    0x6c(%ebx),%eax
80105fff:	89 44 24 08          	mov    %eax,0x8(%esp)
    cprintf("%d %s: unknown sys call %d\n",
80106003:	8b 43 10             	mov    0x10(%ebx),%eax
80106006:	c7 04 24 28 8f 10 80 	movl   $0x80108f28,(%esp)
8010600d:	89 44 24 04          	mov    %eax,0x4(%esp)
80106011:	e8 3a a6 ff ff       	call   80100650 <cprintf>
    curproc->tf->eax = -1;
80106016:	8b 43 18             	mov    0x18(%ebx),%eax
80106019:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80106020:	83 c4 14             	add    $0x14,%esp
80106023:	5b                   	pop    %ebx
80106024:	5d                   	pop    %ebp
80106025:	c3                   	ret    
80106026:	66 90                	xchg   %ax,%ax
80106028:	66 90                	xchg   %ax,%ax
8010602a:	66 90                	xchg   %ax,%ax
8010602c:	66 90                	xchg   %ax,%ax
8010602e:	66 90                	xchg   %ax,%ax

80106030 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80106030:	55                   	push   %ebp
80106031:	0f bf d2             	movswl %dx,%edx
80106034:	89 e5                	mov    %esp,%ebp
80106036:	83 ec 58             	sub    $0x58,%esp
80106039:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010603c:	0f bf 7d 08          	movswl 0x8(%ebp),%edi
80106040:	0f bf c9             	movswl %cx,%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80106043:	89 04 24             	mov    %eax,(%esp)
{
80106046:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80106049:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010604c:	89 7d bc             	mov    %edi,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010604f:	8d 7d da             	lea    -0x26(%ebp),%edi
80106052:	89 7c 24 04          	mov    %edi,0x4(%esp)
{
80106056:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80106059:	89 4d c0             	mov    %ecx,-0x40(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010605c:	e8 8f bf ff ff       	call   80101ff0 <nameiparent>
80106061:	85 c0                	test   %eax,%eax
80106063:	0f 84 4f 01 00 00    	je     801061b8 <create+0x188>
    return 0;
  ilock(dp);
80106069:	89 04 24             	mov    %eax,(%esp)
8010606c:	89 c3                	mov    %eax,%ebx
8010606e:	e8 7d b6 ff ff       	call   801016f0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80106073:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80106076:	89 44 24 08          	mov    %eax,0x8(%esp)
8010607a:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010607e:	89 1c 24             	mov    %ebx,(%esp)
80106081:	e8 ea bb ff ff       	call   80101c70 <dirlookup>
80106086:	85 c0                	test   %eax,%eax
80106088:	89 c6                	mov    %eax,%esi
8010608a:	74 34                	je     801060c0 <create+0x90>
    iunlockput(dp);
8010608c:	89 1c 24             	mov    %ebx,(%esp)
8010608f:	e8 ec b8 ff ff       	call   80101980 <iunlockput>
    ilock(ip);
80106094:	89 34 24             	mov    %esi,(%esp)
80106097:	e8 54 b6 ff ff       	call   801016f0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010609c:	83 7d c4 02          	cmpl   $0x2,-0x3c(%ebp)
801060a0:	0f 85 9a 00 00 00    	jne    80106140 <create+0x110>
801060a6:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
801060ab:	0f 85 8f 00 00 00    	jne    80106140 <create+0x110>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801060b1:	89 f0                	mov    %esi,%eax
801060b3:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801060b6:	8b 75 f8             	mov    -0x8(%ebp),%esi
801060b9:	8b 7d fc             	mov    -0x4(%ebp),%edi
801060bc:	89 ec                	mov    %ebp,%esp
801060be:	5d                   	pop    %ebp
801060bf:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
801060c0:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801060c3:	89 44 24 04          	mov    %eax,0x4(%esp)
801060c7:	8b 03                	mov    (%ebx),%eax
801060c9:	89 04 24             	mov    %eax,(%esp)
801060cc:	e8 9f b4 ff ff       	call   80101570 <ialloc>
801060d1:	85 c0                	test   %eax,%eax
801060d3:	89 c6                	mov    %eax,%esi
801060d5:	0f 84 f0 00 00 00    	je     801061cb <create+0x19b>
  ilock(ip);
801060db:	89 04 24             	mov    %eax,(%esp)
801060de:	e8 0d b6 ff ff       	call   801016f0 <ilock>
  ip->major = major;
801060e3:	8b 45 c0             	mov    -0x40(%ebp),%eax
  ip->nlink = 1;
801060e6:	66 c7 46 56 01 00    	movw   $0x1,0x56(%esi)
  ip->major = major;
801060ec:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
801060f0:	8b 45 bc             	mov    -0x44(%ebp),%eax
801060f3:	66 89 46 54          	mov    %ax,0x54(%esi)
  iupdate(ip);
801060f7:	89 34 24             	mov    %esi,(%esp)
801060fa:	e8 31 b5 ff ff       	call   80101630 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
801060ff:	83 7d c4 01          	cmpl   $0x1,-0x3c(%ebp)
80106103:	74 5b                	je     80106160 <create+0x130>
  if(dirlink(dp, name, ip->inum) < 0)
80106105:	8b 46 04             	mov    0x4(%esi),%eax
80106108:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010610c:	89 1c 24             	mov    %ebx,(%esp)
8010610f:	89 44 24 08          	mov    %eax,0x8(%esp)
80106113:	e8 d8 bd ff ff       	call   80101ef0 <dirlink>
80106118:	85 c0                	test   %eax,%eax
8010611a:	0f 88 9f 00 00 00    	js     801061bf <create+0x18f>
  iunlockput(dp);
80106120:	89 1c 24             	mov    %ebx,(%esp)
80106123:	e8 58 b8 ff ff       	call   80101980 <iunlockput>
}
80106128:	89 f0                	mov    %esi,%eax
8010612a:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010612d:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106130:	8b 7d fc             	mov    -0x4(%ebp),%edi
80106133:	89 ec                	mov    %ebp,%esp
80106135:	5d                   	pop    %ebp
80106136:	c3                   	ret    
80106137:	89 f6                	mov    %esi,%esi
80106139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80106140:	89 34 24             	mov    %esi,(%esp)
    return 0;
80106143:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80106145:	e8 36 b8 ff ff       	call   80101980 <iunlockput>
}
8010614a:	89 f0                	mov    %esi,%eax
8010614c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010614f:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106152:	8b 7d fc             	mov    -0x4(%ebp),%edi
80106155:	89 ec                	mov    %ebp,%esp
80106157:	5d                   	pop    %ebp
80106158:	c3                   	ret    
80106159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80106160:	66 ff 43 56          	incw   0x56(%ebx)
    iupdate(dp);
80106164:	89 1c 24             	mov    %ebx,(%esp)
80106167:	e8 c4 b4 ff ff       	call   80101630 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010616c:	8b 46 04             	mov    0x4(%esi),%eax
8010616f:	ba e4 8f 10 80       	mov    $0x80108fe4,%edx
80106174:	89 54 24 04          	mov    %edx,0x4(%esp)
80106178:	89 34 24             	mov    %esi,(%esp)
8010617b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010617f:	e8 6c bd ff ff       	call   80101ef0 <dirlink>
80106184:	85 c0                	test   %eax,%eax
80106186:	78 20                	js     801061a8 <create+0x178>
80106188:	8b 43 04             	mov    0x4(%ebx),%eax
8010618b:	89 34 24             	mov    %esi,(%esp)
8010618e:	89 44 24 08          	mov    %eax,0x8(%esp)
80106192:	b8 e3 8f 10 80       	mov    $0x80108fe3,%eax
80106197:	89 44 24 04          	mov    %eax,0x4(%esp)
8010619b:	e8 50 bd ff ff       	call   80101ef0 <dirlink>
801061a0:	85 c0                	test   %eax,%eax
801061a2:	0f 89 5d ff ff ff    	jns    80106105 <create+0xd5>
      panic("create dots");
801061a8:	c7 04 24 d7 8f 10 80 	movl   $0x80108fd7,(%esp)
801061af:	e8 bc a1 ff ff       	call   80100370 <panic>
801061b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
801061b8:	31 f6                	xor    %esi,%esi
801061ba:	e9 f2 fe ff ff       	jmp    801060b1 <create+0x81>
    panic("create: dirlink");
801061bf:	c7 04 24 e6 8f 10 80 	movl   $0x80108fe6,(%esp)
801061c6:	e8 a5 a1 ff ff       	call   80100370 <panic>
    panic("create: ialloc");
801061cb:	c7 04 24 c8 8f 10 80 	movl   $0x80108fc8,(%esp)
801061d2:	e8 99 a1 ff ff       	call   80100370 <panic>
801061d7:	89 f6                	mov    %esi,%esi
801061d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801061e0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
801061e0:	55                   	push   %ebp
801061e1:	89 e5                	mov    %esp,%ebp
801061e3:	56                   	push   %esi
801061e4:	89 d6                	mov    %edx,%esi
801061e6:	53                   	push   %ebx
801061e7:	89 c3                	mov    %eax,%ebx
801061e9:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
801061ec:	8d 45 f4             	lea    -0xc(%ebp),%eax
801061ef:	89 44 24 04          	mov    %eax,0x4(%esp)
801061f3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801061fa:	e8 d1 fc ff ff       	call   80105ed0 <argint>
801061ff:	85 c0                	test   %eax,%eax
80106201:	78 2d                	js     80106230 <argfd.constprop.0+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80106203:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80106207:	77 27                	ja     80106230 <argfd.constprop.0+0x50>
80106209:	e8 92 d7 ff ff       	call   801039a0 <myproc>
8010620e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106211:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80106215:	85 c0                	test   %eax,%eax
80106217:	74 17                	je     80106230 <argfd.constprop.0+0x50>
  if(pfd)
80106219:	85 db                	test   %ebx,%ebx
8010621b:	74 02                	je     8010621f <argfd.constprop.0+0x3f>
    *pfd = fd;
8010621d:	89 13                	mov    %edx,(%ebx)
    *pf = f;
8010621f:	89 06                	mov    %eax,(%esi)
  return 0;
80106221:	31 c0                	xor    %eax,%eax
}
80106223:	83 c4 20             	add    $0x20,%esp
80106226:	5b                   	pop    %ebx
80106227:	5e                   	pop    %esi
80106228:	5d                   	pop    %ebp
80106229:	c3                   	ret    
8010622a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106230:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106235:	eb ec                	jmp    80106223 <argfd.constprop.0+0x43>
80106237:	89 f6                	mov    %esi,%esi
80106239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106240 <sys_dup>:
{
80106240:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80106241:	31 c0                	xor    %eax,%eax
{
80106243:	89 e5                	mov    %esp,%ebp
80106245:	56                   	push   %esi
80106246:	53                   	push   %ebx
80106247:	83 ec 20             	sub    $0x20,%esp
  if(argfd(0, 0, &f) < 0)
8010624a:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010624d:	e8 8e ff ff ff       	call   801061e0 <argfd.constprop.0>
80106252:	85 c0                	test   %eax,%eax
80106254:	78 3a                	js     80106290 <sys_dup+0x50>
  if((fd=fdalloc(f)) < 0)
80106256:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106259:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010625b:	e8 40 d7 ff ff       	call   801039a0 <myproc>
80106260:	eb 0c                	jmp    8010626e <sys_dup+0x2e>
80106262:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106268:	43                   	inc    %ebx
80106269:	83 fb 10             	cmp    $0x10,%ebx
8010626c:	74 22                	je     80106290 <sys_dup+0x50>
    if(curproc->ofile[fd] == 0){
8010626e:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80106272:	85 d2                	test   %edx,%edx
80106274:	75 f2                	jne    80106268 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80106276:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
8010627a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010627d:	89 04 24             	mov    %eax,(%esp)
80106280:	e8 5b ab ff ff       	call   80100de0 <filedup>
}
80106285:	83 c4 20             	add    $0x20,%esp
80106288:	89 d8                	mov    %ebx,%eax
8010628a:	5b                   	pop    %ebx
8010628b:	5e                   	pop    %esi
8010628c:	5d                   	pop    %ebp
8010628d:	c3                   	ret    
8010628e:	66 90                	xchg   %ax,%ax
80106290:	83 c4 20             	add    $0x20,%esp
    return -1;
80106293:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80106298:	89 d8                	mov    %ebx,%eax
8010629a:	5b                   	pop    %ebx
8010629b:	5e                   	pop    %esi
8010629c:	5d                   	pop    %ebp
8010629d:	c3                   	ret    
8010629e:	66 90                	xchg   %ax,%ax

801062a0 <sys_read>:
{
801062a0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801062a1:	31 c0                	xor    %eax,%eax
{
801062a3:	89 e5                	mov    %esp,%ebp
801062a5:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801062a8:	8d 55 ec             	lea    -0x14(%ebp),%edx
801062ab:	e8 30 ff ff ff       	call   801061e0 <argfd.constprop.0>
801062b0:	85 c0                	test   %eax,%eax
801062b2:	78 54                	js     80106308 <sys_read+0x68>
801062b4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801062b7:	89 44 24 04          	mov    %eax,0x4(%esp)
801062bb:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801062c2:	e8 09 fc ff ff       	call   80105ed0 <argint>
801062c7:	85 c0                	test   %eax,%eax
801062c9:	78 3d                	js     80106308 <sys_read+0x68>
801062cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801062ce:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801062d5:	89 44 24 08          	mov    %eax,0x8(%esp)
801062d9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801062dc:	89 44 24 04          	mov    %eax,0x4(%esp)
801062e0:	e8 3b fc ff ff       	call   80105f20 <argptr>
801062e5:	85 c0                	test   %eax,%eax
801062e7:	78 1f                	js     80106308 <sys_read+0x68>
  return fileread(f, p, n);
801062e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801062ec:	89 44 24 08          	mov    %eax,0x8(%esp)
801062f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062f3:	89 44 24 04          	mov    %eax,0x4(%esp)
801062f7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801062fa:	89 04 24             	mov    %eax,(%esp)
801062fd:	e8 5e ac ff ff       	call   80100f60 <fileread>
}
80106302:	c9                   	leave  
80106303:	c3                   	ret    
80106304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106308:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010630d:	c9                   	leave  
8010630e:	c3                   	ret    
8010630f:	90                   	nop

80106310 <sys_write>:
{
80106310:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106311:	31 c0                	xor    %eax,%eax
{
80106313:	89 e5                	mov    %esp,%ebp
80106315:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106318:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010631b:	e8 c0 fe ff ff       	call   801061e0 <argfd.constprop.0>
80106320:	85 c0                	test   %eax,%eax
80106322:	78 54                	js     80106378 <sys_write+0x68>
80106324:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106327:	89 44 24 04          	mov    %eax,0x4(%esp)
8010632b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106332:	e8 99 fb ff ff       	call   80105ed0 <argint>
80106337:	85 c0                	test   %eax,%eax
80106339:	78 3d                	js     80106378 <sys_write+0x68>
8010633b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010633e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106345:	89 44 24 08          	mov    %eax,0x8(%esp)
80106349:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010634c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106350:	e8 cb fb ff ff       	call   80105f20 <argptr>
80106355:	85 c0                	test   %eax,%eax
80106357:	78 1f                	js     80106378 <sys_write+0x68>
  return filewrite(f, p, n);
80106359:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010635c:	89 44 24 08          	mov    %eax,0x8(%esp)
80106360:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106363:	89 44 24 04          	mov    %eax,0x4(%esp)
80106367:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010636a:	89 04 24             	mov    %eax,(%esp)
8010636d:	e8 9e ac ff ff       	call   80101010 <filewrite>
}
80106372:	c9                   	leave  
80106373:	c3                   	ret    
80106374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106378:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010637d:	c9                   	leave  
8010637e:	c3                   	ret    
8010637f:	90                   	nop

80106380 <sys_close>:
{
80106380:	55                   	push   %ebp
80106381:	89 e5                	mov    %esp,%ebp
80106383:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, &fd, &f) < 0)
80106386:	8d 55 f4             	lea    -0xc(%ebp),%edx
80106389:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010638c:	e8 4f fe ff ff       	call   801061e0 <argfd.constprop.0>
80106391:	85 c0                	test   %eax,%eax
80106393:	78 23                	js     801063b8 <sys_close+0x38>
  myproc()->ofile[fd] = 0;
80106395:	e8 06 d6 ff ff       	call   801039a0 <myproc>
8010639a:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010639d:	31 c9                	xor    %ecx,%ecx
8010639f:	89 4c 90 28          	mov    %ecx,0x28(%eax,%edx,4)
  fileclose(f);
801063a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063a6:	89 04 24             	mov    %eax,(%esp)
801063a9:	e8 82 aa ff ff       	call   80100e30 <fileclose>
  return 0;
801063ae:	31 c0                	xor    %eax,%eax
}
801063b0:	c9                   	leave  
801063b1:	c3                   	ret    
801063b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801063b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801063bd:	c9                   	leave  
801063be:	c3                   	ret    
801063bf:	90                   	nop

801063c0 <sys_fstat>:
{
801063c0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801063c1:	31 c0                	xor    %eax,%eax
{
801063c3:	89 e5                	mov    %esp,%ebp
801063c5:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801063c8:	8d 55 f0             	lea    -0x10(%ebp),%edx
801063cb:	e8 10 fe ff ff       	call   801061e0 <argfd.constprop.0>
801063d0:	85 c0                	test   %eax,%eax
801063d2:	78 3c                	js     80106410 <sys_fstat+0x50>
801063d4:	b8 14 00 00 00       	mov    $0x14,%eax
801063d9:	89 44 24 08          	mov    %eax,0x8(%esp)
801063dd:	8d 45 f4             	lea    -0xc(%ebp),%eax
801063e0:	89 44 24 04          	mov    %eax,0x4(%esp)
801063e4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801063eb:	e8 30 fb ff ff       	call   80105f20 <argptr>
801063f0:	85 c0                	test   %eax,%eax
801063f2:	78 1c                	js     80106410 <sys_fstat+0x50>
  return filestat(f, st);
801063f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063f7:	89 44 24 04          	mov    %eax,0x4(%esp)
801063fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801063fe:	89 04 24             	mov    %eax,(%esp)
80106401:	e8 0a ab ff ff       	call   80100f10 <filestat>
}
80106406:	c9                   	leave  
80106407:	c3                   	ret    
80106408:	90                   	nop
80106409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106410:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106415:	c9                   	leave  
80106416:	c3                   	ret    
80106417:	89 f6                	mov    %esi,%esi
80106419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106420 <sys_link>:
{
80106420:	55                   	push   %ebp
80106421:	89 e5                	mov    %esp,%ebp
80106423:	57                   	push   %edi
80106424:	56                   	push   %esi
80106425:	53                   	push   %ebx
80106426:	83 ec 3c             	sub    $0x3c,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80106429:	8d 45 d4             	lea    -0x2c(%ebp),%eax
8010642c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106430:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106437:	e8 44 fb ff ff       	call   80105f80 <argstr>
8010643c:	85 c0                	test   %eax,%eax
8010643e:	0f 88 e5 00 00 00    	js     80106529 <sys_link+0x109>
80106444:	8d 45 d0             	lea    -0x30(%ebp),%eax
80106447:	89 44 24 04          	mov    %eax,0x4(%esp)
8010644b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106452:	e8 29 fb ff ff       	call   80105f80 <argstr>
80106457:	85 c0                	test   %eax,%eax
80106459:	0f 88 ca 00 00 00    	js     80106529 <sys_link+0x109>
  begin_op();
8010645f:	e8 2c c8 ff ff       	call   80102c90 <begin_op>
  if((ip = namei(old)) == 0){
80106464:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80106467:	89 04 24             	mov    %eax,(%esp)
8010646a:	e8 61 bb ff ff       	call   80101fd0 <namei>
8010646f:	85 c0                	test   %eax,%eax
80106471:	89 c3                	mov    %eax,%ebx
80106473:	0f 84 ab 00 00 00    	je     80106524 <sys_link+0x104>
  ilock(ip);
80106479:	89 04 24             	mov    %eax,(%esp)
8010647c:	e8 6f b2 ff ff       	call   801016f0 <ilock>
  if(ip->type == T_DIR){
80106481:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106486:	0f 84 90 00 00 00    	je     8010651c <sys_link+0xfc>
  ip->nlink++;
8010648c:	66 ff 43 56          	incw   0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80106490:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80106493:	89 1c 24             	mov    %ebx,(%esp)
80106496:	e8 95 b1 ff ff       	call   80101630 <iupdate>
  iunlock(ip);
8010649b:	89 1c 24             	mov    %ebx,(%esp)
8010649e:	e8 2d b3 ff ff       	call   801017d0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801064a3:	8b 45 d0             	mov    -0x30(%ebp),%eax
801064a6:	89 7c 24 04          	mov    %edi,0x4(%esp)
801064aa:	89 04 24             	mov    %eax,(%esp)
801064ad:	e8 3e bb ff ff       	call   80101ff0 <nameiparent>
801064b2:	85 c0                	test   %eax,%eax
801064b4:	89 c6                	mov    %eax,%esi
801064b6:	74 50                	je     80106508 <sys_link+0xe8>
  ilock(dp);
801064b8:	89 04 24             	mov    %eax,(%esp)
801064bb:	e8 30 b2 ff ff       	call   801016f0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801064c0:	8b 03                	mov    (%ebx),%eax
801064c2:	39 06                	cmp    %eax,(%esi)
801064c4:	75 3a                	jne    80106500 <sys_link+0xe0>
801064c6:	8b 43 04             	mov    0x4(%ebx),%eax
801064c9:	89 7c 24 04          	mov    %edi,0x4(%esp)
801064cd:	89 34 24             	mov    %esi,(%esp)
801064d0:	89 44 24 08          	mov    %eax,0x8(%esp)
801064d4:	e8 17 ba ff ff       	call   80101ef0 <dirlink>
801064d9:	85 c0                	test   %eax,%eax
801064db:	78 23                	js     80106500 <sys_link+0xe0>
  iunlockput(dp);
801064dd:	89 34 24             	mov    %esi,(%esp)
801064e0:	e8 9b b4 ff ff       	call   80101980 <iunlockput>
  iput(ip);
801064e5:	89 1c 24             	mov    %ebx,(%esp)
801064e8:	e8 33 b3 ff ff       	call   80101820 <iput>
  end_op();
801064ed:	e8 0e c8 ff ff       	call   80102d00 <end_op>
}
801064f2:	83 c4 3c             	add    $0x3c,%esp
  return 0;
801064f5:	31 c0                	xor    %eax,%eax
}
801064f7:	5b                   	pop    %ebx
801064f8:	5e                   	pop    %esi
801064f9:	5f                   	pop    %edi
801064fa:	5d                   	pop    %ebp
801064fb:	c3                   	ret    
801064fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(dp);
80106500:	89 34 24             	mov    %esi,(%esp)
80106503:	e8 78 b4 ff ff       	call   80101980 <iunlockput>
  ilock(ip);
80106508:	89 1c 24             	mov    %ebx,(%esp)
8010650b:	e8 e0 b1 ff ff       	call   801016f0 <ilock>
  ip->nlink--;
80106510:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
80106514:	89 1c 24             	mov    %ebx,(%esp)
80106517:	e8 14 b1 ff ff       	call   80101630 <iupdate>
  iunlockput(ip);
8010651c:	89 1c 24             	mov    %ebx,(%esp)
8010651f:	e8 5c b4 ff ff       	call   80101980 <iunlockput>
  end_op();
80106524:	e8 d7 c7 ff ff       	call   80102d00 <end_op>
}
80106529:	83 c4 3c             	add    $0x3c,%esp
  return -1;
8010652c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106531:	5b                   	pop    %ebx
80106532:	5e                   	pop    %esi
80106533:	5f                   	pop    %edi
80106534:	5d                   	pop    %ebp
80106535:	c3                   	ret    
80106536:	8d 76 00             	lea    0x0(%esi),%esi
80106539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106540 <sys_unlink>:
{
80106540:	55                   	push   %ebp
80106541:	89 e5                	mov    %esp,%ebp
80106543:	57                   	push   %edi
80106544:	56                   	push   %esi
80106545:	53                   	push   %ebx
80106546:	83 ec 5c             	sub    $0x5c,%esp
  if(argstr(0, &path) < 0)
80106549:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010654c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106550:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106557:	e8 24 fa ff ff       	call   80105f80 <argstr>
8010655c:	85 c0                	test   %eax,%eax
8010655e:	0f 88 68 01 00 00    	js     801066cc <sys_unlink+0x18c>
  begin_op();
80106564:	e8 27 c7 ff ff       	call   80102c90 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80106569:	8b 45 c0             	mov    -0x40(%ebp),%eax
8010656c:	8d 5d ca             	lea    -0x36(%ebp),%ebx
8010656f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80106573:	89 04 24             	mov    %eax,(%esp)
80106576:	e8 75 ba ff ff       	call   80101ff0 <nameiparent>
8010657b:	85 c0                	test   %eax,%eax
8010657d:	89 c6                	mov    %eax,%esi
8010657f:	0f 84 42 01 00 00    	je     801066c7 <sys_unlink+0x187>
  ilock(dp);
80106585:	89 04 24             	mov    %eax,(%esp)
80106588:	e8 63 b1 ff ff       	call   801016f0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010658d:	b8 e4 8f 10 80       	mov    $0x80108fe4,%eax
80106592:	89 44 24 04          	mov    %eax,0x4(%esp)
80106596:	89 1c 24             	mov    %ebx,(%esp)
80106599:	e8 a2 b6 ff ff       	call   80101c40 <namecmp>
8010659e:	85 c0                	test   %eax,%eax
801065a0:	0f 84 19 01 00 00    	je     801066bf <sys_unlink+0x17f>
801065a6:	b8 e3 8f 10 80       	mov    $0x80108fe3,%eax
801065ab:	89 44 24 04          	mov    %eax,0x4(%esp)
801065af:	89 1c 24             	mov    %ebx,(%esp)
801065b2:	e8 89 b6 ff ff       	call   80101c40 <namecmp>
801065b7:	85 c0                	test   %eax,%eax
801065b9:	0f 84 00 01 00 00    	je     801066bf <sys_unlink+0x17f>
  if((ip = dirlookup(dp, name, &off)) == 0)
801065bf:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801065c2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801065c6:	89 44 24 08          	mov    %eax,0x8(%esp)
801065ca:	89 34 24             	mov    %esi,(%esp)
801065cd:	e8 9e b6 ff ff       	call   80101c70 <dirlookup>
801065d2:	85 c0                	test   %eax,%eax
801065d4:	89 c3                	mov    %eax,%ebx
801065d6:	0f 84 e3 00 00 00    	je     801066bf <sys_unlink+0x17f>
  ilock(ip);
801065dc:	89 04 24             	mov    %eax,(%esp)
801065df:	e8 0c b1 ff ff       	call   801016f0 <ilock>
  if(ip->nlink < 1)
801065e4:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801065e9:	0f 8e 0e 01 00 00    	jle    801066fd <sys_unlink+0x1bd>
  if(ip->type == T_DIR && !isdirempty(ip)){
801065ef:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801065f4:	8d 7d d8             	lea    -0x28(%ebp),%edi
801065f7:	74 77                	je     80106670 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
801065f9:	31 d2                	xor    %edx,%edx
801065fb:	b8 10 00 00 00       	mov    $0x10,%eax
80106600:	89 54 24 04          	mov    %edx,0x4(%esp)
80106604:	89 44 24 08          	mov    %eax,0x8(%esp)
80106608:	89 3c 24             	mov    %edi,(%esp)
8010660b:	e8 d0 f5 ff ff       	call   80105be0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106610:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80106613:	b9 10 00 00 00       	mov    $0x10,%ecx
80106618:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
8010661c:	89 7c 24 04          	mov    %edi,0x4(%esp)
80106620:	89 34 24             	mov    %esi,(%esp)
80106623:	89 44 24 08          	mov    %eax,0x8(%esp)
80106627:	e8 c4 b4 ff ff       	call   80101af0 <writei>
8010662c:	83 f8 10             	cmp    $0x10,%eax
8010662f:	0f 85 d4 00 00 00    	jne    80106709 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
80106635:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010663a:	0f 84 a0 00 00 00    	je     801066e0 <sys_unlink+0x1a0>
  iunlockput(dp);
80106640:	89 34 24             	mov    %esi,(%esp)
80106643:	e8 38 b3 ff ff       	call   80101980 <iunlockput>
  ip->nlink--;
80106648:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
8010664c:	89 1c 24             	mov    %ebx,(%esp)
8010664f:	e8 dc af ff ff       	call   80101630 <iupdate>
  iunlockput(ip);
80106654:	89 1c 24             	mov    %ebx,(%esp)
80106657:	e8 24 b3 ff ff       	call   80101980 <iunlockput>
  end_op();
8010665c:	e8 9f c6 ff ff       	call   80102d00 <end_op>
}
80106661:	83 c4 5c             	add    $0x5c,%esp
  return 0;
80106664:	31 c0                	xor    %eax,%eax
}
80106666:	5b                   	pop    %ebx
80106667:	5e                   	pop    %esi
80106668:	5f                   	pop    %edi
80106669:	5d                   	pop    %ebp
8010666a:	c3                   	ret    
8010666b:	90                   	nop
8010666c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80106670:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80106674:	76 83                	jbe    801065f9 <sys_unlink+0xb9>
80106676:	ba 20 00 00 00       	mov    $0x20,%edx
8010667b:	eb 0f                	jmp    8010668c <sys_unlink+0x14c>
8010667d:	8d 76 00             	lea    0x0(%esi),%esi
80106680:	83 c2 10             	add    $0x10,%edx
80106683:	3b 53 58             	cmp    0x58(%ebx),%edx
80106686:	0f 83 6d ff ff ff    	jae    801065f9 <sys_unlink+0xb9>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010668c:	b8 10 00 00 00       	mov    $0x10,%eax
80106691:	89 54 24 08          	mov    %edx,0x8(%esp)
80106695:	89 44 24 0c          	mov    %eax,0xc(%esp)
80106699:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010669d:	89 1c 24             	mov    %ebx,(%esp)
801066a0:	89 55 b4             	mov    %edx,-0x4c(%ebp)
801066a3:	e8 28 b3 ff ff       	call   801019d0 <readi>
801066a8:	8b 55 b4             	mov    -0x4c(%ebp),%edx
801066ab:	83 f8 10             	cmp    $0x10,%eax
801066ae:	75 41                	jne    801066f1 <sys_unlink+0x1b1>
    if(de.inum != 0)
801066b0:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801066b5:	74 c9                	je     80106680 <sys_unlink+0x140>
    iunlockput(ip);
801066b7:	89 1c 24             	mov    %ebx,(%esp)
801066ba:	e8 c1 b2 ff ff       	call   80101980 <iunlockput>
  iunlockput(dp);
801066bf:	89 34 24             	mov    %esi,(%esp)
801066c2:	e8 b9 b2 ff ff       	call   80101980 <iunlockput>
  end_op();
801066c7:	e8 34 c6 ff ff       	call   80102d00 <end_op>
}
801066cc:	83 c4 5c             	add    $0x5c,%esp
  return -1;
801066cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801066d4:	5b                   	pop    %ebx
801066d5:	5e                   	pop    %esi
801066d6:	5f                   	pop    %edi
801066d7:	5d                   	pop    %ebp
801066d8:	c3                   	ret    
801066d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
801066e0:	66 ff 4e 56          	decw   0x56(%esi)
    iupdate(dp);
801066e4:	89 34 24             	mov    %esi,(%esp)
801066e7:	e8 44 af ff ff       	call   80101630 <iupdate>
801066ec:	e9 4f ff ff ff       	jmp    80106640 <sys_unlink+0x100>
      panic("isdirempty: readi");
801066f1:	c7 04 24 08 90 10 80 	movl   $0x80109008,(%esp)
801066f8:	e8 73 9c ff ff       	call   80100370 <panic>
    panic("unlink: nlink < 1");
801066fd:	c7 04 24 f6 8f 10 80 	movl   $0x80108ff6,(%esp)
80106704:	e8 67 9c ff ff       	call   80100370 <panic>
    panic("unlink: writei");
80106709:	c7 04 24 1a 90 10 80 	movl   $0x8010901a,(%esp)
80106710:	e8 5b 9c ff ff       	call   80100370 <panic>
80106715:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106720 <sys_open>:

int
sys_open(void)
{
80106720:	55                   	push   %ebp
80106721:	89 e5                	mov    %esp,%ebp
80106723:	57                   	push   %edi
80106724:	56                   	push   %esi
80106725:	53                   	push   %ebx
80106726:	83 ec 2c             	sub    $0x2c,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106729:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010672c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106730:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106737:	e8 44 f8 ff ff       	call   80105f80 <argstr>
8010673c:	85 c0                	test   %eax,%eax
8010673e:	0f 88 e9 00 00 00    	js     8010682d <sys_open+0x10d>
80106744:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106747:	89 44 24 04          	mov    %eax,0x4(%esp)
8010674b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106752:	e8 79 f7 ff ff       	call   80105ed0 <argint>
80106757:	85 c0                	test   %eax,%eax
80106759:	0f 88 ce 00 00 00    	js     8010682d <sys_open+0x10d>
    return -1;

  begin_op();
8010675f:	e8 2c c5 ff ff       	call   80102c90 <begin_op>

  if(omode & O_CREATE){
80106764:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80106768:	0f 85 9a 00 00 00    	jne    80106808 <sys_open+0xe8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
8010676e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106771:	89 04 24             	mov    %eax,(%esp)
80106774:	e8 57 b8 ff ff       	call   80101fd0 <namei>
80106779:	85 c0                	test   %eax,%eax
8010677b:	89 c6                	mov    %eax,%esi
8010677d:	0f 84 a5 00 00 00    	je     80106828 <sys_open+0x108>
      end_op();
      return -1;
    }
    ilock(ip);
80106783:	89 04 24             	mov    %eax,(%esp)
80106786:	e8 65 af ff ff       	call   801016f0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
8010678b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80106790:	0f 84 a2 00 00 00    	je     80106838 <sys_open+0x118>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80106796:	e8 d5 a5 ff ff       	call   80100d70 <filealloc>
8010679b:	85 c0                	test   %eax,%eax
8010679d:	89 c7                	mov    %eax,%edi
8010679f:	0f 84 9e 00 00 00    	je     80106843 <sys_open+0x123>
  struct proc *curproc = myproc();
801067a5:	e8 f6 d1 ff ff       	call   801039a0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801067aa:	31 db                	xor    %ebx,%ebx
801067ac:	eb 0c                	jmp    801067ba <sys_open+0x9a>
801067ae:	66 90                	xchg   %ax,%ax
801067b0:	43                   	inc    %ebx
801067b1:	83 fb 10             	cmp    $0x10,%ebx
801067b4:	0f 84 96 00 00 00    	je     80106850 <sys_open+0x130>
    if(curproc->ofile[fd] == 0){
801067ba:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801067be:	85 d2                	test   %edx,%edx
801067c0:	75 ee                	jne    801067b0 <sys_open+0x90>
      curproc->ofile[fd] = f;
801067c2:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801067c6:	89 34 24             	mov    %esi,(%esp)
801067c9:	e8 02 b0 ff ff       	call   801017d0 <iunlock>
  end_op();
801067ce:	e8 2d c5 ff ff       	call   80102d00 <end_op>

  f->type = FD_INODE;
801067d3:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801067d9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->ip = ip;
801067dc:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801067df:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801067e6:	89 d0                	mov    %edx,%eax
801067e8:	f7 d0                	not    %eax
801067ea:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801067ed:	f6 c2 03             	test   $0x3,%dl
  f->readable = !(omode & O_WRONLY);
801067f0:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801067f3:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801067f7:	83 c4 2c             	add    $0x2c,%esp
801067fa:	89 d8                	mov    %ebx,%eax
801067fc:	5b                   	pop    %ebx
801067fd:	5e                   	pop    %esi
801067fe:	5f                   	pop    %edi
801067ff:	5d                   	pop    %ebp
80106800:	c3                   	ret    
80106801:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80106808:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010680b:	31 c9                	xor    %ecx,%ecx
8010680d:	ba 02 00 00 00       	mov    $0x2,%edx
80106812:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106819:	e8 12 f8 ff ff       	call   80106030 <create>
    if(ip == 0){
8010681e:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80106820:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80106822:	0f 85 6e ff ff ff    	jne    80106796 <sys_open+0x76>
    end_op();
80106828:	e8 d3 c4 ff ff       	call   80102d00 <end_op>
    return -1;
8010682d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106832:	eb c3                	jmp    801067f7 <sys_open+0xd7>
80106834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80106838:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010683b:	85 c9                	test   %ecx,%ecx
8010683d:	0f 84 53 ff ff ff    	je     80106796 <sys_open+0x76>
    iunlockput(ip);
80106843:	89 34 24             	mov    %esi,(%esp)
80106846:	e8 35 b1 ff ff       	call   80101980 <iunlockput>
8010684b:	eb db                	jmp    80106828 <sys_open+0x108>
8010684d:	8d 76 00             	lea    0x0(%esi),%esi
      fileclose(f);
80106850:	89 3c 24             	mov    %edi,(%esp)
80106853:	e8 d8 a5 ff ff       	call   80100e30 <fileclose>
80106858:	eb e9                	jmp    80106843 <sys_open+0x123>
8010685a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106860 <sys_mkdir>:

int
sys_mkdir(void)
{
80106860:	55                   	push   %ebp
80106861:	89 e5                	mov    %esp,%ebp
80106863:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
80106866:	e8 25 c4 ff ff       	call   80102c90 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010686b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010686e:	89 44 24 04          	mov    %eax,0x4(%esp)
80106872:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106879:	e8 02 f7 ff ff       	call   80105f80 <argstr>
8010687e:	85 c0                	test   %eax,%eax
80106880:	78 2e                	js     801068b0 <sys_mkdir+0x50>
80106882:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106885:	31 c9                	xor    %ecx,%ecx
80106887:	ba 01 00 00 00       	mov    $0x1,%edx
8010688c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106893:	e8 98 f7 ff ff       	call   80106030 <create>
80106898:	85 c0                	test   %eax,%eax
8010689a:	74 14                	je     801068b0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010689c:	89 04 24             	mov    %eax,(%esp)
8010689f:	e8 dc b0 ff ff       	call   80101980 <iunlockput>
  end_op();
801068a4:	e8 57 c4 ff ff       	call   80102d00 <end_op>
  return 0;
801068a9:	31 c0                	xor    %eax,%eax
}
801068ab:	c9                   	leave  
801068ac:	c3                   	ret    
801068ad:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
801068b0:	e8 4b c4 ff ff       	call   80102d00 <end_op>
    return -1;
801068b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801068ba:	c9                   	leave  
801068bb:	c3                   	ret    
801068bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801068c0 <sys_mknod>:

int
sys_mknod(void)
{
801068c0:	55                   	push   %ebp
801068c1:	89 e5                	mov    %esp,%ebp
801068c3:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801068c6:	e8 c5 c3 ff ff       	call   80102c90 <begin_op>
  if((argstr(0, &path)) < 0 ||
801068cb:	8d 45 ec             	lea    -0x14(%ebp),%eax
801068ce:	89 44 24 04          	mov    %eax,0x4(%esp)
801068d2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801068d9:	e8 a2 f6 ff ff       	call   80105f80 <argstr>
801068de:	85 c0                	test   %eax,%eax
801068e0:	78 5e                	js     80106940 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801068e2:	8d 45 f0             	lea    -0x10(%ebp),%eax
801068e5:	89 44 24 04          	mov    %eax,0x4(%esp)
801068e9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801068f0:	e8 db f5 ff ff       	call   80105ed0 <argint>
  if((argstr(0, &path)) < 0 ||
801068f5:	85 c0                	test   %eax,%eax
801068f7:	78 47                	js     80106940 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801068f9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801068fc:	89 44 24 04          	mov    %eax,0x4(%esp)
80106900:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106907:	e8 c4 f5 ff ff       	call   80105ed0 <argint>
     argint(1, &major) < 0 ||
8010690c:	85 c0                	test   %eax,%eax
8010690e:	78 30                	js     80106940 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80106910:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
80106914:	ba 03 00 00 00       	mov    $0x3,%edx
     (ip = create(path, T_DEV, major, minor)) == 0){
80106919:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
8010691d:	89 04 24             	mov    %eax,(%esp)
     argint(2, &minor) < 0 ||
80106920:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106923:	e8 08 f7 ff ff       	call   80106030 <create>
80106928:	85 c0                	test   %eax,%eax
8010692a:	74 14                	je     80106940 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010692c:	89 04 24             	mov    %eax,(%esp)
8010692f:	e8 4c b0 ff ff       	call   80101980 <iunlockput>
  end_op();
80106934:	e8 c7 c3 ff ff       	call   80102d00 <end_op>
  return 0;
80106939:	31 c0                	xor    %eax,%eax
}
8010693b:	c9                   	leave  
8010693c:	c3                   	ret    
8010693d:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
80106940:	e8 bb c3 ff ff       	call   80102d00 <end_op>
    return -1;
80106945:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010694a:	c9                   	leave  
8010694b:	c3                   	ret    
8010694c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106950 <sys_chdir>:

int
sys_chdir(void)
{
80106950:	55                   	push   %ebp
80106951:	89 e5                	mov    %esp,%ebp
80106953:	56                   	push   %esi
80106954:	53                   	push   %ebx
80106955:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80106958:	e8 43 d0 ff ff       	call   801039a0 <myproc>
8010695d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010695f:	e8 2c c3 ff ff       	call   80102c90 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106964:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106967:	89 44 24 04          	mov    %eax,0x4(%esp)
8010696b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106972:	e8 09 f6 ff ff       	call   80105f80 <argstr>
80106977:	85 c0                	test   %eax,%eax
80106979:	78 4a                	js     801069c5 <sys_chdir+0x75>
8010697b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010697e:	89 04 24             	mov    %eax,(%esp)
80106981:	e8 4a b6 ff ff       	call   80101fd0 <namei>
80106986:	85 c0                	test   %eax,%eax
80106988:	89 c3                	mov    %eax,%ebx
8010698a:	74 39                	je     801069c5 <sys_chdir+0x75>
    end_op();
    return -1;
  }
  ilock(ip);
8010698c:	89 04 24             	mov    %eax,(%esp)
8010698f:	e8 5c ad ff ff       	call   801016f0 <ilock>
  if(ip->type != T_DIR){
80106994:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
    iunlockput(ip);
80106999:	89 1c 24             	mov    %ebx,(%esp)
  if(ip->type != T_DIR){
8010699c:	75 22                	jne    801069c0 <sys_chdir+0x70>
    end_op();
    return -1;
  }
  iunlock(ip);
8010699e:	e8 2d ae ff ff       	call   801017d0 <iunlock>
  iput(curproc->cwd);
801069a3:	8b 46 68             	mov    0x68(%esi),%eax
801069a6:	89 04 24             	mov    %eax,(%esp)
801069a9:	e8 72 ae ff ff       	call   80101820 <iput>
  end_op();
801069ae:	e8 4d c3 ff ff       	call   80102d00 <end_op>
  curproc->cwd = ip;
  return 0;
801069b3:	31 c0                	xor    %eax,%eax
  curproc->cwd = ip;
801069b5:	89 5e 68             	mov    %ebx,0x68(%esi)
}
801069b8:	83 c4 20             	add    $0x20,%esp
801069bb:	5b                   	pop    %ebx
801069bc:	5e                   	pop    %esi
801069bd:	5d                   	pop    %ebp
801069be:	c3                   	ret    
801069bf:	90                   	nop
    iunlockput(ip);
801069c0:	e8 bb af ff ff       	call   80101980 <iunlockput>
    end_op();
801069c5:	e8 36 c3 ff ff       	call   80102d00 <end_op>
    return -1;
801069ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801069cf:	eb e7                	jmp    801069b8 <sys_chdir+0x68>
801069d1:	eb 0d                	jmp    801069e0 <sys_exec>
801069d3:	90                   	nop
801069d4:	90                   	nop
801069d5:	90                   	nop
801069d6:	90                   	nop
801069d7:	90                   	nop
801069d8:	90                   	nop
801069d9:	90                   	nop
801069da:	90                   	nop
801069db:	90                   	nop
801069dc:	90                   	nop
801069dd:	90                   	nop
801069de:	90                   	nop
801069df:	90                   	nop

801069e0 <sys_exec>:

int
sys_exec(void)
{
801069e0:	55                   	push   %ebp
801069e1:	89 e5                	mov    %esp,%ebp
801069e3:	57                   	push   %edi
801069e4:	56                   	push   %esi
801069e5:	53                   	push   %ebx
801069e6:	81 ec ac 00 00 00    	sub    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801069ec:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
801069f2:	89 44 24 04          	mov    %eax,0x4(%esp)
801069f6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801069fd:	e8 7e f5 ff ff       	call   80105f80 <argstr>
80106a02:	85 c0                	test   %eax,%eax
80106a04:	0f 88 8e 00 00 00    	js     80106a98 <sys_exec+0xb8>
80106a0a:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80106a10:	89 44 24 04          	mov    %eax,0x4(%esp)
80106a14:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106a1b:	e8 b0 f4 ff ff       	call   80105ed0 <argint>
80106a20:	85 c0                	test   %eax,%eax
80106a22:	78 74                	js     80106a98 <sys_exec+0xb8>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80106a24:	ba 80 00 00 00       	mov    $0x80,%edx
80106a29:	31 c9                	xor    %ecx,%ecx
80106a2b:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
80106a31:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80106a33:	89 54 24 08          	mov    %edx,0x8(%esp)
80106a37:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80106a3d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80106a41:	89 04 24             	mov    %eax,(%esp)
80106a44:	e8 97 f1 ff ff       	call   80105be0 <memset>
80106a49:	eb 2e                	jmp    80106a79 <sys_exec+0x99>
80106a4b:	90                   	nop
80106a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80106a50:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80106a56:	85 c0                	test   %eax,%eax
80106a58:	74 56                	je     80106ab0 <sys_exec+0xd0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106a5a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80106a60:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80106a63:	89 54 24 04          	mov    %edx,0x4(%esp)
80106a67:	89 04 24             	mov    %eax,(%esp)
80106a6a:	e8 01 f4 ff ff       	call   80105e70 <fetchstr>
80106a6f:	85 c0                	test   %eax,%eax
80106a71:	78 25                	js     80106a98 <sys_exec+0xb8>
  for(i=0;; i++){
80106a73:	43                   	inc    %ebx
    if(i >= NELEM(argv))
80106a74:	83 fb 20             	cmp    $0x20,%ebx
80106a77:	74 1f                	je     80106a98 <sys_exec+0xb8>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106a79:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106a7f:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80106a86:	89 7c 24 04          	mov    %edi,0x4(%esp)
80106a8a:	01 f0                	add    %esi,%eax
80106a8c:	89 04 24             	mov    %eax,(%esp)
80106a8f:	e8 9c f3 ff ff       	call   80105e30 <fetchint>
80106a94:	85 c0                	test   %eax,%eax
80106a96:	79 b8                	jns    80106a50 <sys_exec+0x70>
      return -1;
  }
  return exec(path, argv);
}
80106a98:	81 c4 ac 00 00 00    	add    $0xac,%esp
    return -1;
80106a9e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106aa3:	5b                   	pop    %ebx
80106aa4:	5e                   	pop    %esi
80106aa5:	5f                   	pop    %edi
80106aa6:	5d                   	pop    %ebp
80106aa7:	c3                   	ret    
80106aa8:	90                   	nop
80106aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80106ab0:	31 c0                	xor    %eax,%eax
80106ab2:	89 84 9d 68 ff ff ff 	mov    %eax,-0x98(%ebp,%ebx,4)
  return exec(path, argv);
80106ab9:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106abf:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ac3:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
80106ac9:	89 04 24             	mov    %eax,(%esp)
80106acc:	e8 ff 9e ff ff       	call   801009d0 <exec>
}
80106ad1:	81 c4 ac 00 00 00    	add    $0xac,%esp
80106ad7:	5b                   	pop    %ebx
80106ad8:	5e                   	pop    %esi
80106ad9:	5f                   	pop    %edi
80106ada:	5d                   	pop    %ebp
80106adb:	c3                   	ret    
80106adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106ae0 <sys_pipe>:

int
sys_pipe(void)
{
80106ae0:	55                   	push   %ebp
80106ae1:	89 e5                	mov    %esp,%ebp
80106ae3:	57                   	push   %edi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106ae4:	bf 08 00 00 00       	mov    $0x8,%edi
{
80106ae9:	56                   	push   %esi
80106aea:	53                   	push   %ebx
80106aeb:	83 ec 2c             	sub    $0x2c,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106aee:	8d 45 dc             	lea    -0x24(%ebp),%eax
80106af1:	89 7c 24 08          	mov    %edi,0x8(%esp)
80106af5:	89 44 24 04          	mov    %eax,0x4(%esp)
80106af9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106b00:	e8 1b f4 ff ff       	call   80105f20 <argptr>
80106b05:	85 c0                	test   %eax,%eax
80106b07:	0f 88 a9 00 00 00    	js     80106bb6 <sys_pipe+0xd6>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80106b0d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106b10:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b14:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106b17:	89 04 24             	mov    %eax,(%esp)
80106b1a:	e8 a1 c8 ff ff       	call   801033c0 <pipealloc>
80106b1f:	85 c0                	test   %eax,%eax
80106b21:	0f 88 8f 00 00 00    	js     80106bb6 <sys_pipe+0xd6>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106b27:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80106b2a:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80106b2c:	e8 6f ce ff ff       	call   801039a0 <myproc>
80106b31:	eb 0b                	jmp    80106b3e <sys_pipe+0x5e>
80106b33:	90                   	nop
80106b34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106b38:	43                   	inc    %ebx
80106b39:	83 fb 10             	cmp    $0x10,%ebx
80106b3c:	74 62                	je     80106ba0 <sys_pipe+0xc0>
    if(curproc->ofile[fd] == 0){
80106b3e:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80106b42:	85 f6                	test   %esi,%esi
80106b44:	75 f2                	jne    80106b38 <sys_pipe+0x58>
      curproc->ofile[fd] = f;
80106b46:	8d 73 08             	lea    0x8(%ebx),%esi
80106b49:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106b4d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80106b50:	e8 4b ce ff ff       	call   801039a0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106b55:	31 d2                	xor    %edx,%edx
80106b57:	eb 0d                	jmp    80106b66 <sys_pipe+0x86>
80106b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b60:	42                   	inc    %edx
80106b61:	83 fa 10             	cmp    $0x10,%edx
80106b64:	74 2a                	je     80106b90 <sys_pipe+0xb0>
    if(curproc->ofile[fd] == 0){
80106b66:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80106b6a:	85 c9                	test   %ecx,%ecx
80106b6c:	75 f2                	jne    80106b60 <sys_pipe+0x80>
      curproc->ofile[fd] = f;
80106b6e:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80106b72:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106b75:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106b77:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106b7a:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80106b7d:	31 c0                	xor    %eax,%eax
}
80106b7f:	83 c4 2c             	add    $0x2c,%esp
80106b82:	5b                   	pop    %ebx
80106b83:	5e                   	pop    %esi
80106b84:	5f                   	pop    %edi
80106b85:	5d                   	pop    %ebp
80106b86:	c3                   	ret    
80106b87:	89 f6                	mov    %esi,%esi
80106b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      myproc()->ofile[fd0] = 0;
80106b90:	e8 0b ce ff ff       	call   801039a0 <myproc>
80106b95:	31 d2                	xor    %edx,%edx
80106b97:	89 54 b0 08          	mov    %edx,0x8(%eax,%esi,4)
80106b9b:	90                   	nop
80106b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fileclose(rf);
80106ba0:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106ba3:	89 04 24             	mov    %eax,(%esp)
80106ba6:	e8 85 a2 ff ff       	call   80100e30 <fileclose>
    fileclose(wf);
80106bab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106bae:	89 04 24             	mov    %eax,(%esp)
80106bb1:	e8 7a a2 ff ff       	call   80100e30 <fileclose>
    return -1;
80106bb6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106bbb:	eb c2                	jmp    80106b7f <sys_pipe+0x9f>
80106bbd:	66 90                	xchg   %ax,%ax
80106bbf:	90                   	nop

80106bc0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106bc0:	55                   	push   %ebp
80106bc1:	89 e5                	mov    %esp,%ebp
  return fork();
}
80106bc3:	5d                   	pop    %ebp
  return fork();
80106bc4:	e9 b7 d0 ff ff       	jmp    80103c80 <fork>
80106bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106bd0 <sys_exit>:

int
sys_exit(void)
{
80106bd0:	55                   	push   %ebp
80106bd1:	89 e5                	mov    %esp,%ebp
80106bd3:	83 ec 28             	sub    $0x28,%esp
  int status;

  if(argint(0, &status) < 0)
80106bd6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106bd9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106bdd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106be4:	e8 e7 f2 ff ff       	call   80105ed0 <argint>
80106be9:	85 c0                	test   %eax,%eax
80106beb:	78 13                	js     80106c00 <sys_exit+0x30>
    return -1;
  exit(status);
80106bed:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106bf0:	89 04 24             	mov    %eax,(%esp)
80106bf3:	e8 b8 d6 ff ff       	call   801042b0 <exit>
  return 0;  // not reached
80106bf8:	31 c0                	xor    %eax,%eax
}
80106bfa:	c9                   	leave  
80106bfb:	c3                   	ret    
80106bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106c00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106c05:	c9                   	leave  
80106c06:	c3                   	ret    
80106c07:	89 f6                	mov    %esi,%esi
80106c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c10 <sys_wait>:

int
sys_wait(void)
{
80106c10:	55                   	push   %ebp
  int *status;

  if(argptr(0, (char**)(&status), sizeof(int)) < 0)
80106c11:	b8 04 00 00 00       	mov    $0x4,%eax
{
80106c16:	89 e5                	mov    %esp,%ebp
80106c18:	83 ec 28             	sub    $0x28,%esp
  if(argptr(0, (char**)(&status), sizeof(int)) < 0)
80106c1b:	89 44 24 08          	mov    %eax,0x8(%esp)
80106c1f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106c22:	89 44 24 04          	mov    %eax,0x4(%esp)
80106c26:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106c2d:	e8 ee f2 ff ff       	call   80105f20 <argptr>
80106c32:	85 c0                	test   %eax,%eax
80106c34:	78 12                	js     80106c48 <sys_wait+0x38>
    return -1;
  return wait(status);
80106c36:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106c39:	89 04 24             	mov    %eax,(%esp)
80106c3c:	e8 5f d9 ff ff       	call   801045a0 <wait>
  //return wait();
}
80106c41:	c9                   	leave  
80106c42:	c3                   	ret    
80106c43:	90                   	nop
80106c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106c48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106c4d:	c9                   	leave  
80106c4e:	c3                   	ret    
80106c4f:	90                   	nop

80106c50 <sys_kill>:

int
sys_kill(void)
{
80106c50:	55                   	push   %ebp
80106c51:	89 e5                	mov    %esp,%ebp
80106c53:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106c56:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106c59:	89 44 24 04          	mov    %eax,0x4(%esp)
80106c5d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106c64:	e8 67 f2 ff ff       	call   80105ed0 <argint>
80106c69:	85 c0                	test   %eax,%eax
80106c6b:	78 13                	js     80106c80 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106c6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106c70:	89 04 24             	mov    %eax,(%esp)
80106c73:	e8 68 da ff ff       	call   801046e0 <kill>
}
80106c78:	c9                   	leave  
80106c79:	c3                   	ret    
80106c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106c80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106c85:	c9                   	leave  
80106c86:	c3                   	ret    
80106c87:	89 f6                	mov    %esi,%esi
80106c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c90 <sys_getpid>:

int
sys_getpid(void)
{
80106c90:	55                   	push   %ebp
80106c91:	89 e5                	mov    %esp,%ebp
80106c93:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106c96:	e8 05 cd ff ff       	call   801039a0 <myproc>
80106c9b:	8b 40 10             	mov    0x10(%eax),%eax
}
80106c9e:	c9                   	leave  
80106c9f:	c3                   	ret    

80106ca0 <sys_sbrk>:

int
sys_sbrk(void)
{
80106ca0:	55                   	push   %ebp
80106ca1:	89 e5                	mov    %esp,%ebp
80106ca3:	53                   	push   %ebx
80106ca4:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106ca7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106caa:	89 44 24 04          	mov    %eax,0x4(%esp)
80106cae:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106cb5:	e8 16 f2 ff ff       	call   80105ed0 <argint>
80106cba:	85 c0                	test   %eax,%eax
80106cbc:	78 22                	js     80106ce0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106cbe:	e8 dd cc ff ff       	call   801039a0 <myproc>
80106cc3:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106cc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106cc8:	89 04 24             	mov    %eax,(%esp)
80106ccb:	e8 00 cd ff ff       	call   801039d0 <growproc>
80106cd0:	85 c0                	test   %eax,%eax
80106cd2:	78 0c                	js     80106ce0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106cd4:	83 c4 24             	add    $0x24,%esp
80106cd7:	89 d8                	mov    %ebx,%eax
80106cd9:	5b                   	pop    %ebx
80106cda:	5d                   	pop    %ebp
80106cdb:	c3                   	ret    
80106cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106ce0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106ce5:	eb ed                	jmp    80106cd4 <sys_sbrk+0x34>
80106ce7:	89 f6                	mov    %esi,%esi
80106ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106cf0 <sys_sleep>:

int
sys_sleep(void)
{
80106cf0:	55                   	push   %ebp
80106cf1:	89 e5                	mov    %esp,%ebp
80106cf3:	53                   	push   %ebx
80106cf4:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106cf7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106cfa:	89 44 24 04          	mov    %eax,0x4(%esp)
80106cfe:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106d05:	e8 c6 f1 ff ff       	call   80105ed0 <argint>
80106d0a:	85 c0                	test   %eax,%eax
80106d0c:	78 7e                	js     80106d8c <sys_sleep+0x9c>
    return -1;
  acquire(&tickslock);
80106d0e:	c7 04 24 e0 73 11 80 	movl   $0x801173e0,(%esp)
80106d15:	e8 d6 ed ff ff       	call   80105af0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106d1a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  ticks0 = ticks;
80106d1d:	8b 1d 20 7c 11 80    	mov    0x80117c20,%ebx
  while(ticks - ticks0 < n){
80106d23:	85 c9                	test   %ecx,%ecx
80106d25:	75 2a                	jne    80106d51 <sys_sleep+0x61>
80106d27:	eb 4f                	jmp    80106d78 <sys_sleep+0x88>
80106d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106d30:	b8 e0 73 11 80       	mov    $0x801173e0,%eax
80106d35:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d39:	c7 04 24 20 7c 11 80 	movl   $0x80117c20,(%esp)
80106d40:	e8 6b d7 ff ff       	call   801044b0 <sleep>
  while(ticks - ticks0 < n){
80106d45:	a1 20 7c 11 80       	mov    0x80117c20,%eax
80106d4a:	29 d8                	sub    %ebx,%eax
80106d4c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80106d4f:	73 27                	jae    80106d78 <sys_sleep+0x88>
    if(myproc()->killed){
80106d51:	e8 4a cc ff ff       	call   801039a0 <myproc>
80106d56:	8b 50 24             	mov    0x24(%eax),%edx
80106d59:	85 d2                	test   %edx,%edx
80106d5b:	74 d3                	je     80106d30 <sys_sleep+0x40>
      release(&tickslock);
80106d5d:	c7 04 24 e0 73 11 80 	movl   $0x801173e0,(%esp)
80106d64:	e8 27 ee ff ff       	call   80105b90 <release>
  }
  release(&tickslock);
  return 0;
}
80106d69:	83 c4 24             	add    $0x24,%esp
      return -1;
80106d6c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106d71:	5b                   	pop    %ebx
80106d72:	5d                   	pop    %ebp
80106d73:	c3                   	ret    
80106d74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&tickslock);
80106d78:	c7 04 24 e0 73 11 80 	movl   $0x801173e0,(%esp)
80106d7f:	e8 0c ee ff ff       	call   80105b90 <release>
  return 0;
80106d84:	31 c0                	xor    %eax,%eax
}
80106d86:	83 c4 24             	add    $0x24,%esp
80106d89:	5b                   	pop    %ebx
80106d8a:	5d                   	pop    %ebp
80106d8b:	c3                   	ret    
    return -1;
80106d8c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106d91:	eb f3                	jmp    80106d86 <sys_sleep+0x96>
80106d93:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106da0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106da0:	55                   	push   %ebp
80106da1:	89 e5                	mov    %esp,%ebp
80106da3:	53                   	push   %ebx
80106da4:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

  acquire(&tickslock);
80106da7:	c7 04 24 e0 73 11 80 	movl   $0x801173e0,(%esp)
80106dae:	e8 3d ed ff ff       	call   80105af0 <acquire>
  xticks = ticks;
80106db3:	8b 1d 20 7c 11 80    	mov    0x80117c20,%ebx
  release(&tickslock);
80106db9:	c7 04 24 e0 73 11 80 	movl   $0x801173e0,(%esp)
80106dc0:	e8 cb ed ff ff       	call   80105b90 <release>
  return xticks;
}
80106dc5:	83 c4 14             	add    $0x14,%esp
80106dc8:	89 d8                	mov    %ebx,%eax
80106dca:	5b                   	pop    %ebx
80106dcb:	5d                   	pop    %ebp
80106dcc:	c3                   	ret    
80106dcd:	8d 76 00             	lea    0x0(%esi),%esi

80106dd0 <sys_detach>:

// transfer a child process with the given pid from the parent to the init process.
// return 0 when succseeds or -1 if the process has no child with this pid.
int
sys_detach(void)
{
80106dd0:	55                   	push   %ebp
80106dd1:	89 e5                	mov    %esp,%ebp
80106dd3:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106dd6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106dd9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ddd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106de4:	e8 e7 f0 ff ff       	call   80105ed0 <argint>
80106de9:	85 c0                	test   %eax,%eax
80106deb:	78 13                	js     80106e00 <sys_detach+0x30>
    return -1;
  return detach(pid);
80106ded:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106df0:	89 04 24             	mov    %eax,(%esp)
80106df3:	e8 a8 d9 ff ff       	call   801047a0 <detach>
}
80106df8:	c9                   	leave  
80106df9:	c3                   	ret    
80106dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106e00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106e05:	c9                   	leave  
80106e06:	c3                   	ret    
80106e07:	89 f6                	mov    %esi,%esi
80106e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e10 <sys_priority>:

//used by a process to change its priority
int
sys_priority(void)
{
80106e10:	55                   	push   %ebp
80106e11:	89 e5                	mov    %esp,%ebp
80106e13:	83 ec 28             	sub    $0x28,%esp
  int proc_priority;

  if(argint(0, &proc_priority) < 0)
80106e16:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106e19:	89 44 24 04          	mov    %eax,0x4(%esp)
80106e1d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106e24:	e8 a7 f0 ff ff       	call   80105ed0 <argint>
80106e29:	85 c0                	test   %eax,%eax
80106e2b:	78 13                	js     80106e40 <sys_priority+0x30>
    return -1;
  priority(proc_priority);
80106e2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e30:	89 04 24             	mov    %eax,(%esp)
80106e33:	e8 28 da ff ff       	call   80104860 <priority>
  return 0;
80106e38:	31 c0                	xor    %eax,%eax
}
80106e3a:	c9                   	leave  
80106e3b:	c3                   	ret    
80106e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106e40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106e45:	c9                   	leave  
80106e46:	c3                   	ret    
80106e47:	89 f6                	mov    %esi,%esi
80106e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e50 <sys_policy>:

// receives a policy identifier as an argument and changes the currently used policy.
int
sys_policy(void)
{
80106e50:	55                   	push   %ebp
80106e51:	89 e5                	mov    %esp,%ebp
80106e53:	83 ec 28             	sub    $0x28,%esp
  int policy_id;

  if(argint(0, &policy_id) < 0)
80106e56:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106e59:	89 44 24 04          	mov    %eax,0x4(%esp)
80106e5d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106e64:	e8 67 f0 ff ff       	call   80105ed0 <argint>
80106e69:	85 c0                	test   %eax,%eax
80106e6b:	78 13                	js     80106e80 <sys_policy+0x30>
    return -1;
  policy(policy_id);
80106e6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e70:	89 04 24             	mov    %eax,(%esp)
80106e73:	e8 68 da ff ff       	call   801048e0 <policy>
  return 0;
80106e78:	31 c0                	xor    %eax,%eax
}
80106e7a:	c9                   	leave  
80106e7b:	c3                   	ret    
80106e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106e80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106e85:	c9                   	leave  
80106e86:	c3                   	ret    
80106e87:	89 f6                	mov    %esi,%esi
80106e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e90 <sys_wait_stat>:

// return the pid of the terminated child process or -1 upon failure.
int
sys_wait_stat(void)
{
80106e90:	55                   	push   %ebp
     int* status;
     struct perf* perform;

     if ((argptr(0, (char**)(&status), sizeof(int)) < 0) || (argptr(0, (void*)(&perform), sizeof(*perform)) < 0))
80106e91:	ba 04 00 00 00       	mov    $0x4,%edx
{
80106e96:	89 e5                	mov    %esp,%ebp
80106e98:	83 ec 28             	sub    $0x28,%esp
     if ((argptr(0, (char**)(&status), sizeof(int)) < 0) || (argptr(0, (void*)(&perform), sizeof(*perform)) < 0))
80106e9b:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106e9e:	89 54 24 08          	mov    %edx,0x8(%esp)
80106ea2:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ea6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106ead:	e8 6e f0 ff ff       	call   80105f20 <argptr>
80106eb2:	85 c0                	test   %eax,%eax
80106eb4:	78 3a                	js     80106ef0 <sys_wait_stat+0x60>
80106eb6:	b8 14 00 00 00       	mov    $0x14,%eax
80106ebb:	89 44 24 08          	mov    %eax,0x8(%esp)
80106ebf:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106ec2:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ec6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106ecd:	e8 4e f0 ff ff       	call   80105f20 <argptr>
80106ed2:	85 c0                	test   %eax,%eax
80106ed4:	78 1a                	js     80106ef0 <sys_wait_stat+0x60>
        return -1;
    return wait_stat(status,perform);
80106ed6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ed9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106edd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106ee0:	89 04 24             	mov    %eax,(%esp)
80106ee3:	e8 c8 db ff ff       	call   80104ab0 <wait_stat>
}
80106ee8:	c9                   	leave  
80106ee9:	c3                   	ret    
80106eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
80106ef0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ef5:	c9                   	leave  
80106ef6:	c3                   	ret    

80106ef7 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106ef7:	1e                   	push   %ds
  pushl %es
80106ef8:	06                   	push   %es
  pushl %fs
80106ef9:	0f a0                	push   %fs
  pushl %gs
80106efb:	0f a8                	push   %gs
  pushal
80106efd:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106efe:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106f02:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106f04:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106f06:	54                   	push   %esp
  call trap
80106f07:	e8 c4 00 00 00       	call   80106fd0 <trap>
  addl $4, %esp
80106f0c:	83 c4 04             	add    $0x4,%esp

80106f0f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106f0f:	61                   	popa   
  popl %gs
80106f10:	0f a9                	pop    %gs
  popl %fs
80106f12:	0f a1                	pop    %fs
  popl %es
80106f14:	07                   	pop    %es
  popl %ds
80106f15:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106f16:	83 c4 08             	add    $0x8,%esp
  iret
80106f19:	cf                   	iret   
80106f1a:	66 90                	xchg   %ax,%ax
80106f1c:	66 90                	xchg   %ax,%ax
80106f1e:	66 90                	xchg   %ax,%ax

80106f20 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106f20:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106f21:	31 c0                	xor    %eax,%eax
{
80106f23:	89 e5                	mov    %esp,%ebp
80106f25:	83 ec 18             	sub    $0x18,%esp
80106f28:	90                   	nop
80106f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106f30:	8b 14 85 0c c0 10 80 	mov    -0x7fef3ff4(,%eax,4),%edx
80106f37:	b9 08 00 00 8e       	mov    $0x8e000008,%ecx
80106f3c:	89 0c c5 22 74 11 80 	mov    %ecx,-0x7fee8bde(,%eax,8)
80106f43:	66 89 14 c5 20 74 11 	mov    %dx,-0x7fee8be0(,%eax,8)
80106f4a:	80 
80106f4b:	c1 ea 10             	shr    $0x10,%edx
80106f4e:	66 89 14 c5 26 74 11 	mov    %dx,-0x7fee8bda(,%eax,8)
80106f55:	80 
  for(i = 0; i < 256; i++)
80106f56:	40                   	inc    %eax
80106f57:	3d 00 01 00 00       	cmp    $0x100,%eax
80106f5c:	75 d2                	jne    80106f30 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106f5e:	a1 0c c1 10 80       	mov    0x8010c10c,%eax

  initlock(&tickslock, "time");
80106f63:	b9 29 90 10 80       	mov    $0x80109029,%ecx
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106f68:	ba 08 00 00 ef       	mov    $0xef000008,%edx
  initlock(&tickslock, "time");
80106f6d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80106f71:	c7 04 24 e0 73 11 80 	movl   $0x801173e0,(%esp)
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106f78:	89 15 22 76 11 80    	mov    %edx,0x80117622
80106f7e:	66 a3 20 76 11 80    	mov    %ax,0x80117620
80106f84:	c1 e8 10             	shr    $0x10,%eax
80106f87:	66 a3 26 76 11 80    	mov    %ax,0x80117626
  initlock(&tickslock, "time");
80106f8d:	e8 0e ea ff ff       	call   801059a0 <initlock>
}
80106f92:	c9                   	leave  
80106f93:	c3                   	ret    
80106f94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106f9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106fa0 <idtinit>:

void
idtinit(void)
{
80106fa0:	55                   	push   %ebp
  pd[1] = (uint)p;
80106fa1:	b8 20 74 11 80       	mov    $0x80117420,%eax
80106fa6:	89 e5                	mov    %esp,%ebp
80106fa8:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
80106fab:	c1 e8 10             	shr    $0x10,%eax
80106fae:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
80106fb1:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
80106fb7:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106fbb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80106fbf:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106fc2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106fc5:	c9                   	leave  
80106fc6:	c3                   	ret    
80106fc7:	89 f6                	mov    %esi,%esi
80106fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106fd0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106fd0:	55                   	push   %ebp
80106fd1:	89 e5                	mov    %esp,%ebp
80106fd3:	83 ec 48             	sub    $0x48,%esp
80106fd6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80106fd9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80106fdc:	89 75 f8             	mov    %esi,-0x8(%ebp)
80106fdf:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(tf->trapno == T_SYSCALL){
80106fe2:	8b 43 30             	mov    0x30(%ebx),%eax
80106fe5:	83 f8 40             	cmp    $0x40,%eax
80106fe8:	0f 84 02 01 00 00    	je     801070f0 <trap+0x120>
    if(myproc()->killed)
      exit(0);
    return;
  }

  switch(tf->trapno){
80106fee:	83 e8 20             	sub    $0x20,%eax
80106ff1:	83 f8 1f             	cmp    $0x1f,%eax
80106ff4:	77 0a                	ja     80107000 <trap+0x30>
80106ff6:	ff 24 85 d0 90 10 80 	jmp    *-0x7fef6f30(,%eax,4)
80106ffd:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80107000:	e8 9b c9 ff ff       	call   801039a0 <myproc>
80107005:	8b 7b 38             	mov    0x38(%ebx),%edi
80107008:	85 c0                	test   %eax,%eax
8010700a:	0f 84 64 02 00 00    	je     80107274 <trap+0x2a4>
80107010:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80107014:	0f 84 5a 02 00 00    	je     80107274 <trap+0x2a4>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010701a:	0f 20 d1             	mov    %cr2,%ecx
8010701d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107020:	e8 5b c9 ff ff       	call   80103980 <cpuid>
80107025:	8b 73 30             	mov    0x30(%ebx),%esi
80107028:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010702b:	8b 43 34             	mov    0x34(%ebx),%eax
8010702e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80107031:	e8 6a c9 ff ff       	call   801039a0 <myproc>
80107036:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107039:	e8 62 c9 ff ff       	call   801039a0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010703e:	8b 55 dc             	mov    -0x24(%ebp),%edx
80107041:	89 74 24 0c          	mov    %esi,0xc(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
80107045:	8b 75 e0             	mov    -0x20(%ebp),%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107048:	8b 4d d8             	mov    -0x28(%ebp),%ecx
8010704b:	89 7c 24 18          	mov    %edi,0x18(%esp)
8010704f:	89 54 24 14          	mov    %edx,0x14(%esp)
80107053:	8b 55 e4             	mov    -0x1c(%ebp),%edx
            myproc()->pid, myproc()->name, tf->trapno,
80107056:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107059:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
8010705d:	89 74 24 08          	mov    %esi,0x8(%esp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107061:	89 54 24 10          	mov    %edx,0x10(%esp)
80107065:	8b 40 10             	mov    0x10(%eax),%eax
80107068:	c7 04 24 8c 90 10 80 	movl   $0x8010908c,(%esp)
8010706f:	89 44 24 04          	mov    %eax,0x4(%esp)
80107073:	e8 d8 95 ff ff       	call   80100650 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80107078:	e8 23 c9 ff ff       	call   801039a0 <myproc>
8010707d:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107084:	e8 17 c9 ff ff       	call   801039a0 <myproc>
80107089:	85 c0                	test   %eax,%eax
8010708b:	74 1b                	je     801070a8 <trap+0xd8>
8010708d:	e8 0e c9 ff ff       	call   801039a0 <myproc>
80107092:	8b 50 24             	mov    0x24(%eax),%edx
80107095:	85 d2                	test   %edx,%edx
80107097:	74 0f                	je     801070a8 <trap+0xd8>
80107099:	8b 43 3c             	mov    0x3c(%ebx),%eax
8010709c:	83 e0 03             	and    $0x3,%eax
8010709f:	83 f8 03             	cmp    $0x3,%eax
801070a2:	0f 84 80 01 00 00    	je     80107228 <trap+0x258>
    exit(0);

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801070a8:	e8 f3 c8 ff ff       	call   801039a0 <myproc>
801070ad:	85 c0                	test   %eax,%eax
801070af:	74 0d                	je     801070be <trap+0xee>
801070b1:	e8 ea c8 ff ff       	call   801039a0 <myproc>
801070b6:	8b 40 0c             	mov    0xc(%eax),%eax
801070b9:	83 f8 04             	cmp    $0x4,%eax
801070bc:	74 7a                	je     80107138 <trap+0x168>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801070be:	e8 dd c8 ff ff       	call   801039a0 <myproc>
801070c3:	85 c0                	test   %eax,%eax
801070c5:	74 17                	je     801070de <trap+0x10e>
801070c7:	e8 d4 c8 ff ff       	call   801039a0 <myproc>
801070cc:	8b 40 24             	mov    0x24(%eax),%eax
801070cf:	85 c0                	test   %eax,%eax
801070d1:	74 0b                	je     801070de <trap+0x10e>
801070d3:	8b 43 3c             	mov    0x3c(%ebx),%eax
801070d6:	83 e0 03             	and    $0x3,%eax
801070d9:	83 f8 03             	cmp    $0x3,%eax
801070dc:	74 3b                	je     80107119 <trap+0x149>
    exit(0);
}
801070de:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801070e1:	8b 75 f8             	mov    -0x8(%ebp),%esi
801070e4:	8b 7d fc             	mov    -0x4(%ebp),%edi
801070e7:	89 ec                	mov    %ebp,%esp
801070e9:	5d                   	pop    %ebp
801070ea:	c3                   	ret    
801070eb:	90                   	nop
801070ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
801070f0:	e8 ab c8 ff ff       	call   801039a0 <myproc>
801070f5:	8b 70 24             	mov    0x24(%eax),%esi
801070f8:	85 f6                	test   %esi,%esi
801070fa:	0f 85 10 01 00 00    	jne    80107210 <trap+0x240>
    myproc()->tf = tf;
80107100:	e8 9b c8 ff ff       	call   801039a0 <myproc>
80107105:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80107108:	e8 b3 ee ff ff       	call   80105fc0 <syscall>
    if(myproc()->killed)
8010710d:	e8 8e c8 ff ff       	call   801039a0 <myproc>
80107112:	8b 48 24             	mov    0x24(%eax),%ecx
80107115:	85 c9                	test   %ecx,%ecx
80107117:	74 c5                	je     801070de <trap+0x10e>
      exit(0);
80107119:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
}
80107120:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107123:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107126:	8b 7d fc             	mov    -0x4(%ebp),%edi
80107129:	89 ec                	mov    %ebp,%esp
8010712b:	5d                   	pop    %ebp
      exit(0);
8010712c:	e9 7f d1 ff ff       	jmp    801042b0 <exit>
80107131:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(myproc() && myproc()->state == RUNNING &&
80107138:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
8010713c:	75 80                	jne    801070be <trap+0xee>
    yield();
8010713e:	e8 6d d2 ff ff       	call   801043b0 <yield>
80107143:	e9 76 ff ff ff       	jmp    801070be <trap+0xee>
80107148:	90                   	nop
80107149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80107150:	e8 2b c8 ff ff       	call   80103980 <cpuid>
80107155:	85 c0                	test   %eax,%eax
80107157:	0f 84 e3 00 00 00    	je     80107240 <trap+0x270>
8010715d:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
80107160:	e8 eb b6 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107165:	e8 36 c8 ff ff       	call   801039a0 <myproc>
8010716a:	85 c0                	test   %eax,%eax
8010716c:	0f 85 1b ff ff ff    	jne    8010708d <trap+0xbd>
80107172:	e9 31 ff ff ff       	jmp    801070a8 <trap+0xd8>
80107177:	89 f6                	mov    %esi,%esi
80107179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    kbdintr();
80107180:	e8 8b b5 ff ff       	call   80102710 <kbdintr>
    lapiceoi();
80107185:	e8 c6 b6 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010718a:	e8 11 c8 ff ff       	call   801039a0 <myproc>
8010718f:	85 c0                	test   %eax,%eax
80107191:	0f 85 f6 fe ff ff    	jne    8010708d <trap+0xbd>
80107197:	e9 0c ff ff ff       	jmp    801070a8 <trap+0xd8>
8010719c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
801071a0:	e8 6b 02 00 00       	call   80107410 <uartintr>
    lapiceoi();
801071a5:	e8 a6 b6 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801071aa:	e8 f1 c7 ff ff       	call   801039a0 <myproc>
801071af:	85 c0                	test   %eax,%eax
801071b1:	0f 85 d6 fe ff ff    	jne    8010708d <trap+0xbd>
801071b7:	e9 ec fe ff ff       	jmp    801070a8 <trap+0xd8>
801071bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801071c0:	8b 7b 38             	mov    0x38(%ebx),%edi
801071c3:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801071c7:	e8 b4 c7 ff ff       	call   80103980 <cpuid>
801071cc:	c7 04 24 34 90 10 80 	movl   $0x80109034,(%esp)
801071d3:	89 7c 24 0c          	mov    %edi,0xc(%esp)
801071d7:	89 74 24 08          	mov    %esi,0x8(%esp)
801071db:	89 44 24 04          	mov    %eax,0x4(%esp)
801071df:	e8 6c 94 ff ff       	call   80100650 <cprintf>
    lapiceoi();
801071e4:	e8 67 b6 ff ff       	call   80102850 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801071e9:	e8 b2 c7 ff ff       	call   801039a0 <myproc>
801071ee:	85 c0                	test   %eax,%eax
801071f0:	0f 85 97 fe ff ff    	jne    8010708d <trap+0xbd>
801071f6:	e9 ad fe ff ff       	jmp    801070a8 <trap+0xd8>
801071fb:	90                   	nop
801071fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80107200:	e8 5b af ff ff       	call   80102160 <ideintr>
80107205:	e9 53 ff ff ff       	jmp    8010715d <trap+0x18d>
8010720a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit(0);
80107210:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80107217:	e8 94 d0 ff ff       	call   801042b0 <exit>
8010721c:	e9 df fe ff ff       	jmp    80107100 <trap+0x130>
80107221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit(0);
80107228:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010722f:	e8 7c d0 ff ff       	call   801042b0 <exit>
80107234:	e9 6f fe ff ff       	jmp    801070a8 <trap+0xd8>
80107239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      acquire(&tickslock);
80107240:	c7 04 24 e0 73 11 80 	movl   $0x801173e0,(%esp)
80107247:	e8 a4 e8 ff ff       	call   80105af0 <acquire>
      ticks++;
8010724c:	ff 05 20 7c 11 80    	incl   0x80117c20
      updatePerformance();
80107252:	e8 99 d8 ff ff       	call   80104af0 <updatePerformance>
      wakeup(&ticks);
80107257:	c7 04 24 20 7c 11 80 	movl   $0x80117c20,(%esp)
8010725e:	e8 4d d4 ff ff       	call   801046b0 <wakeup>
      release(&tickslock);
80107263:	c7 04 24 e0 73 11 80 	movl   $0x801173e0,(%esp)
8010726a:	e8 21 e9 ff ff       	call   80105b90 <release>
8010726f:	e9 e9 fe ff ff       	jmp    8010715d <trap+0x18d>
80107274:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80107277:	e8 04 c7 ff ff       	call   80103980 <cpuid>
8010727c:	89 74 24 10          	mov    %esi,0x10(%esp)
80107280:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80107284:	89 44 24 08          	mov    %eax,0x8(%esp)
80107288:	8b 43 30             	mov    0x30(%ebx),%eax
8010728b:	c7 04 24 58 90 10 80 	movl   $0x80109058,(%esp)
80107292:	89 44 24 04          	mov    %eax,0x4(%esp)
80107296:	e8 b5 93 ff ff       	call   80100650 <cprintf>
      panic("trap");
8010729b:	c7 04 24 2e 90 10 80 	movl   $0x8010902e,(%esp)
801072a2:	e8 c9 90 ff ff       	call   80100370 <panic>
801072a7:	66 90                	xchg   %ax,%ax
801072a9:	66 90                	xchg   %ax,%ax
801072ab:	66 90                	xchg   %ax,%ax
801072ad:	66 90                	xchg   %ax,%ax
801072af:	90                   	nop

801072b0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801072b0:	a1 20 c6 10 80       	mov    0x8010c620,%eax
{
801072b5:	55                   	push   %ebp
801072b6:	89 e5                	mov    %esp,%ebp
  if(!uart)
801072b8:	85 c0                	test   %eax,%eax
801072ba:	74 1c                	je     801072d8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801072bc:	ba fd 03 00 00       	mov    $0x3fd,%edx
801072c1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801072c2:	24 01                	and    $0x1,%al
801072c4:	84 c0                	test   %al,%al
801072c6:	74 10                	je     801072d8 <uartgetc+0x28>
801072c8:	ba f8 03 00 00       	mov    $0x3f8,%edx
801072cd:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801072ce:	0f b6 c0             	movzbl %al,%eax
}
801072d1:	5d                   	pop    %ebp
801072d2:	c3                   	ret    
801072d3:	90                   	nop
801072d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801072d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801072dd:	5d                   	pop    %ebp
801072de:	c3                   	ret    
801072df:	90                   	nop

801072e0 <uartputc.part.0>:
uartputc(int c)
801072e0:	55                   	push   %ebp
801072e1:	89 e5                	mov    %esp,%ebp
801072e3:	56                   	push   %esi
801072e4:	be fd 03 00 00       	mov    $0x3fd,%esi
801072e9:	53                   	push   %ebx
801072ea:	bb 80 00 00 00       	mov    $0x80,%ebx
801072ef:	83 ec 20             	sub    $0x20,%esp
801072f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
801072f5:	eb 18                	jmp    8010730f <uartputc.part.0+0x2f>
801072f7:	89 f6                	mov    %esi,%esi
801072f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80107300:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80107307:	e8 64 b5 ff ff       	call   80102870 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010730c:	4b                   	dec    %ebx
8010730d:	74 09                	je     80107318 <uartputc.part.0+0x38>
8010730f:	89 f2                	mov    %esi,%edx
80107311:	ec                   	in     (%dx),%al
80107312:	24 20                	and    $0x20,%al
80107314:	84 c0                	test   %al,%al
80107316:	74 e8                	je     80107300 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107318:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010731d:	0f b6 45 f4          	movzbl -0xc(%ebp),%eax
80107321:	ee                   	out    %al,(%dx)
}
80107322:	83 c4 20             	add    $0x20,%esp
80107325:	5b                   	pop    %ebx
80107326:	5e                   	pop    %esi
80107327:	5d                   	pop    %ebp
80107328:	c3                   	ret    
80107329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107330 <uartinit>:
{
80107330:	55                   	push   %ebp
80107331:	31 c9                	xor    %ecx,%ecx
80107333:	89 e5                	mov    %esp,%ebp
80107335:	88 c8                	mov    %cl,%al
80107337:	57                   	push   %edi
80107338:	56                   	push   %esi
80107339:	53                   	push   %ebx
8010733a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010733f:	83 ec 1c             	sub    $0x1c,%esp
80107342:	89 da                	mov    %ebx,%edx
80107344:	ee                   	out    %al,(%dx)
80107345:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010734a:	b0 80                	mov    $0x80,%al
8010734c:	89 fa                	mov    %edi,%edx
8010734e:	ee                   	out    %al,(%dx)
8010734f:	b0 0c                	mov    $0xc,%al
80107351:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107356:	ee                   	out    %al,(%dx)
80107357:	be f9 03 00 00       	mov    $0x3f9,%esi
8010735c:	88 c8                	mov    %cl,%al
8010735e:	89 f2                	mov    %esi,%edx
80107360:	ee                   	out    %al,(%dx)
80107361:	b0 03                	mov    $0x3,%al
80107363:	89 fa                	mov    %edi,%edx
80107365:	ee                   	out    %al,(%dx)
80107366:	ba fc 03 00 00       	mov    $0x3fc,%edx
8010736b:	88 c8                	mov    %cl,%al
8010736d:	ee                   	out    %al,(%dx)
8010736e:	b0 01                	mov    $0x1,%al
80107370:	89 f2                	mov    %esi,%edx
80107372:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80107373:	ba fd 03 00 00       	mov    $0x3fd,%edx
80107378:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80107379:	fe c0                	inc    %al
8010737b:	74 52                	je     801073cf <uartinit+0x9f>
  uart = 1;
8010737d:	b9 01 00 00 00       	mov    $0x1,%ecx
80107382:	89 da                	mov    %ebx,%edx
80107384:	89 0d 20 c6 10 80    	mov    %ecx,0x8010c620
8010738a:	ec                   	in     (%dx),%al
8010738b:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107390:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80107391:	31 db                	xor    %ebx,%ebx
80107393:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  for(p="xv6...\n"; *p; p++)
80107397:	bb 50 91 10 80       	mov    $0x80109150,%ebx
  ioapicenable(IRQ_COM1, 0);
8010739c:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
801073a3:	e8 f8 af ff ff       	call   801023a0 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
801073a8:	b8 78 00 00 00       	mov    $0x78,%eax
801073ad:	eb 09                	jmp    801073b8 <uartinit+0x88>
801073af:	90                   	nop
801073b0:	43                   	inc    %ebx
801073b1:	0f be 03             	movsbl (%ebx),%eax
801073b4:	84 c0                	test   %al,%al
801073b6:	74 17                	je     801073cf <uartinit+0x9f>
  if(!uart)
801073b8:	8b 15 20 c6 10 80    	mov    0x8010c620,%edx
801073be:	85 d2                	test   %edx,%edx
801073c0:	74 ee                	je     801073b0 <uartinit+0x80>
  for(p="xv6...\n"; *p; p++)
801073c2:	43                   	inc    %ebx
801073c3:	e8 18 ff ff ff       	call   801072e0 <uartputc.part.0>
801073c8:	0f be 03             	movsbl (%ebx),%eax
801073cb:	84 c0                	test   %al,%al
801073cd:	75 e9                	jne    801073b8 <uartinit+0x88>
}
801073cf:	83 c4 1c             	add    $0x1c,%esp
801073d2:	5b                   	pop    %ebx
801073d3:	5e                   	pop    %esi
801073d4:	5f                   	pop    %edi
801073d5:	5d                   	pop    %ebp
801073d6:	c3                   	ret    
801073d7:	89 f6                	mov    %esi,%esi
801073d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801073e0 <uartputc>:
  if(!uart)
801073e0:	8b 15 20 c6 10 80    	mov    0x8010c620,%edx
{
801073e6:	55                   	push   %ebp
801073e7:	89 e5                	mov    %esp,%ebp
801073e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
801073ec:	85 d2                	test   %edx,%edx
801073ee:	74 10                	je     80107400 <uartputc+0x20>
}
801073f0:	5d                   	pop    %ebp
801073f1:	e9 ea fe ff ff       	jmp    801072e0 <uartputc.part.0>
801073f6:	8d 76 00             	lea    0x0(%esi),%esi
801073f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107400:	5d                   	pop    %ebp
80107401:	c3                   	ret    
80107402:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107410 <uartintr>:

void
uartintr(void)
{
80107410:	55                   	push   %ebp
80107411:	89 e5                	mov    %esp,%ebp
80107413:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80107416:	c7 04 24 b0 72 10 80 	movl   $0x801072b0,(%esp)
8010741d:	e8 ae 93 ff ff       	call   801007d0 <consoleintr>
}
80107422:	c9                   	leave  
80107423:	c3                   	ret    

80107424 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80107424:	6a 00                	push   $0x0
  pushl $0
80107426:	6a 00                	push   $0x0
  jmp alltraps
80107428:	e9 ca fa ff ff       	jmp    80106ef7 <alltraps>

8010742d <vector1>:
.globl vector1
vector1:
  pushl $0
8010742d:	6a 00                	push   $0x0
  pushl $1
8010742f:	6a 01                	push   $0x1
  jmp alltraps
80107431:	e9 c1 fa ff ff       	jmp    80106ef7 <alltraps>

80107436 <vector2>:
.globl vector2
vector2:
  pushl $0
80107436:	6a 00                	push   $0x0
  pushl $2
80107438:	6a 02                	push   $0x2
  jmp alltraps
8010743a:	e9 b8 fa ff ff       	jmp    80106ef7 <alltraps>

8010743f <vector3>:
.globl vector3
vector3:
  pushl $0
8010743f:	6a 00                	push   $0x0
  pushl $3
80107441:	6a 03                	push   $0x3
  jmp alltraps
80107443:	e9 af fa ff ff       	jmp    80106ef7 <alltraps>

80107448 <vector4>:
.globl vector4
vector4:
  pushl $0
80107448:	6a 00                	push   $0x0
  pushl $4
8010744a:	6a 04                	push   $0x4
  jmp alltraps
8010744c:	e9 a6 fa ff ff       	jmp    80106ef7 <alltraps>

80107451 <vector5>:
.globl vector5
vector5:
  pushl $0
80107451:	6a 00                	push   $0x0
  pushl $5
80107453:	6a 05                	push   $0x5
  jmp alltraps
80107455:	e9 9d fa ff ff       	jmp    80106ef7 <alltraps>

8010745a <vector6>:
.globl vector6
vector6:
  pushl $0
8010745a:	6a 00                	push   $0x0
  pushl $6
8010745c:	6a 06                	push   $0x6
  jmp alltraps
8010745e:	e9 94 fa ff ff       	jmp    80106ef7 <alltraps>

80107463 <vector7>:
.globl vector7
vector7:
  pushl $0
80107463:	6a 00                	push   $0x0
  pushl $7
80107465:	6a 07                	push   $0x7
  jmp alltraps
80107467:	e9 8b fa ff ff       	jmp    80106ef7 <alltraps>

8010746c <vector8>:
.globl vector8
vector8:
  pushl $8
8010746c:	6a 08                	push   $0x8
  jmp alltraps
8010746e:	e9 84 fa ff ff       	jmp    80106ef7 <alltraps>

80107473 <vector9>:
.globl vector9
vector9:
  pushl $0
80107473:	6a 00                	push   $0x0
  pushl $9
80107475:	6a 09                	push   $0x9
  jmp alltraps
80107477:	e9 7b fa ff ff       	jmp    80106ef7 <alltraps>

8010747c <vector10>:
.globl vector10
vector10:
  pushl $10
8010747c:	6a 0a                	push   $0xa
  jmp alltraps
8010747e:	e9 74 fa ff ff       	jmp    80106ef7 <alltraps>

80107483 <vector11>:
.globl vector11
vector11:
  pushl $11
80107483:	6a 0b                	push   $0xb
  jmp alltraps
80107485:	e9 6d fa ff ff       	jmp    80106ef7 <alltraps>

8010748a <vector12>:
.globl vector12
vector12:
  pushl $12
8010748a:	6a 0c                	push   $0xc
  jmp alltraps
8010748c:	e9 66 fa ff ff       	jmp    80106ef7 <alltraps>

80107491 <vector13>:
.globl vector13
vector13:
  pushl $13
80107491:	6a 0d                	push   $0xd
  jmp alltraps
80107493:	e9 5f fa ff ff       	jmp    80106ef7 <alltraps>

80107498 <vector14>:
.globl vector14
vector14:
  pushl $14
80107498:	6a 0e                	push   $0xe
  jmp alltraps
8010749a:	e9 58 fa ff ff       	jmp    80106ef7 <alltraps>

8010749f <vector15>:
.globl vector15
vector15:
  pushl $0
8010749f:	6a 00                	push   $0x0
  pushl $15
801074a1:	6a 0f                	push   $0xf
  jmp alltraps
801074a3:	e9 4f fa ff ff       	jmp    80106ef7 <alltraps>

801074a8 <vector16>:
.globl vector16
vector16:
  pushl $0
801074a8:	6a 00                	push   $0x0
  pushl $16
801074aa:	6a 10                	push   $0x10
  jmp alltraps
801074ac:	e9 46 fa ff ff       	jmp    80106ef7 <alltraps>

801074b1 <vector17>:
.globl vector17
vector17:
  pushl $17
801074b1:	6a 11                	push   $0x11
  jmp alltraps
801074b3:	e9 3f fa ff ff       	jmp    80106ef7 <alltraps>

801074b8 <vector18>:
.globl vector18
vector18:
  pushl $0
801074b8:	6a 00                	push   $0x0
  pushl $18
801074ba:	6a 12                	push   $0x12
  jmp alltraps
801074bc:	e9 36 fa ff ff       	jmp    80106ef7 <alltraps>

801074c1 <vector19>:
.globl vector19
vector19:
  pushl $0
801074c1:	6a 00                	push   $0x0
  pushl $19
801074c3:	6a 13                	push   $0x13
  jmp alltraps
801074c5:	e9 2d fa ff ff       	jmp    80106ef7 <alltraps>

801074ca <vector20>:
.globl vector20
vector20:
  pushl $0
801074ca:	6a 00                	push   $0x0
  pushl $20
801074cc:	6a 14                	push   $0x14
  jmp alltraps
801074ce:	e9 24 fa ff ff       	jmp    80106ef7 <alltraps>

801074d3 <vector21>:
.globl vector21
vector21:
  pushl $0
801074d3:	6a 00                	push   $0x0
  pushl $21
801074d5:	6a 15                	push   $0x15
  jmp alltraps
801074d7:	e9 1b fa ff ff       	jmp    80106ef7 <alltraps>

801074dc <vector22>:
.globl vector22
vector22:
  pushl $0
801074dc:	6a 00                	push   $0x0
  pushl $22
801074de:	6a 16                	push   $0x16
  jmp alltraps
801074e0:	e9 12 fa ff ff       	jmp    80106ef7 <alltraps>

801074e5 <vector23>:
.globl vector23
vector23:
  pushl $0
801074e5:	6a 00                	push   $0x0
  pushl $23
801074e7:	6a 17                	push   $0x17
  jmp alltraps
801074e9:	e9 09 fa ff ff       	jmp    80106ef7 <alltraps>

801074ee <vector24>:
.globl vector24
vector24:
  pushl $0
801074ee:	6a 00                	push   $0x0
  pushl $24
801074f0:	6a 18                	push   $0x18
  jmp alltraps
801074f2:	e9 00 fa ff ff       	jmp    80106ef7 <alltraps>

801074f7 <vector25>:
.globl vector25
vector25:
  pushl $0
801074f7:	6a 00                	push   $0x0
  pushl $25
801074f9:	6a 19                	push   $0x19
  jmp alltraps
801074fb:	e9 f7 f9 ff ff       	jmp    80106ef7 <alltraps>

80107500 <vector26>:
.globl vector26
vector26:
  pushl $0
80107500:	6a 00                	push   $0x0
  pushl $26
80107502:	6a 1a                	push   $0x1a
  jmp alltraps
80107504:	e9 ee f9 ff ff       	jmp    80106ef7 <alltraps>

80107509 <vector27>:
.globl vector27
vector27:
  pushl $0
80107509:	6a 00                	push   $0x0
  pushl $27
8010750b:	6a 1b                	push   $0x1b
  jmp alltraps
8010750d:	e9 e5 f9 ff ff       	jmp    80106ef7 <alltraps>

80107512 <vector28>:
.globl vector28
vector28:
  pushl $0
80107512:	6a 00                	push   $0x0
  pushl $28
80107514:	6a 1c                	push   $0x1c
  jmp alltraps
80107516:	e9 dc f9 ff ff       	jmp    80106ef7 <alltraps>

8010751b <vector29>:
.globl vector29
vector29:
  pushl $0
8010751b:	6a 00                	push   $0x0
  pushl $29
8010751d:	6a 1d                	push   $0x1d
  jmp alltraps
8010751f:	e9 d3 f9 ff ff       	jmp    80106ef7 <alltraps>

80107524 <vector30>:
.globl vector30
vector30:
  pushl $0
80107524:	6a 00                	push   $0x0
  pushl $30
80107526:	6a 1e                	push   $0x1e
  jmp alltraps
80107528:	e9 ca f9 ff ff       	jmp    80106ef7 <alltraps>

8010752d <vector31>:
.globl vector31
vector31:
  pushl $0
8010752d:	6a 00                	push   $0x0
  pushl $31
8010752f:	6a 1f                	push   $0x1f
  jmp alltraps
80107531:	e9 c1 f9 ff ff       	jmp    80106ef7 <alltraps>

80107536 <vector32>:
.globl vector32
vector32:
  pushl $0
80107536:	6a 00                	push   $0x0
  pushl $32
80107538:	6a 20                	push   $0x20
  jmp alltraps
8010753a:	e9 b8 f9 ff ff       	jmp    80106ef7 <alltraps>

8010753f <vector33>:
.globl vector33
vector33:
  pushl $0
8010753f:	6a 00                	push   $0x0
  pushl $33
80107541:	6a 21                	push   $0x21
  jmp alltraps
80107543:	e9 af f9 ff ff       	jmp    80106ef7 <alltraps>

80107548 <vector34>:
.globl vector34
vector34:
  pushl $0
80107548:	6a 00                	push   $0x0
  pushl $34
8010754a:	6a 22                	push   $0x22
  jmp alltraps
8010754c:	e9 a6 f9 ff ff       	jmp    80106ef7 <alltraps>

80107551 <vector35>:
.globl vector35
vector35:
  pushl $0
80107551:	6a 00                	push   $0x0
  pushl $35
80107553:	6a 23                	push   $0x23
  jmp alltraps
80107555:	e9 9d f9 ff ff       	jmp    80106ef7 <alltraps>

8010755a <vector36>:
.globl vector36
vector36:
  pushl $0
8010755a:	6a 00                	push   $0x0
  pushl $36
8010755c:	6a 24                	push   $0x24
  jmp alltraps
8010755e:	e9 94 f9 ff ff       	jmp    80106ef7 <alltraps>

80107563 <vector37>:
.globl vector37
vector37:
  pushl $0
80107563:	6a 00                	push   $0x0
  pushl $37
80107565:	6a 25                	push   $0x25
  jmp alltraps
80107567:	e9 8b f9 ff ff       	jmp    80106ef7 <alltraps>

8010756c <vector38>:
.globl vector38
vector38:
  pushl $0
8010756c:	6a 00                	push   $0x0
  pushl $38
8010756e:	6a 26                	push   $0x26
  jmp alltraps
80107570:	e9 82 f9 ff ff       	jmp    80106ef7 <alltraps>

80107575 <vector39>:
.globl vector39
vector39:
  pushl $0
80107575:	6a 00                	push   $0x0
  pushl $39
80107577:	6a 27                	push   $0x27
  jmp alltraps
80107579:	e9 79 f9 ff ff       	jmp    80106ef7 <alltraps>

8010757e <vector40>:
.globl vector40
vector40:
  pushl $0
8010757e:	6a 00                	push   $0x0
  pushl $40
80107580:	6a 28                	push   $0x28
  jmp alltraps
80107582:	e9 70 f9 ff ff       	jmp    80106ef7 <alltraps>

80107587 <vector41>:
.globl vector41
vector41:
  pushl $0
80107587:	6a 00                	push   $0x0
  pushl $41
80107589:	6a 29                	push   $0x29
  jmp alltraps
8010758b:	e9 67 f9 ff ff       	jmp    80106ef7 <alltraps>

80107590 <vector42>:
.globl vector42
vector42:
  pushl $0
80107590:	6a 00                	push   $0x0
  pushl $42
80107592:	6a 2a                	push   $0x2a
  jmp alltraps
80107594:	e9 5e f9 ff ff       	jmp    80106ef7 <alltraps>

80107599 <vector43>:
.globl vector43
vector43:
  pushl $0
80107599:	6a 00                	push   $0x0
  pushl $43
8010759b:	6a 2b                	push   $0x2b
  jmp alltraps
8010759d:	e9 55 f9 ff ff       	jmp    80106ef7 <alltraps>

801075a2 <vector44>:
.globl vector44
vector44:
  pushl $0
801075a2:	6a 00                	push   $0x0
  pushl $44
801075a4:	6a 2c                	push   $0x2c
  jmp alltraps
801075a6:	e9 4c f9 ff ff       	jmp    80106ef7 <alltraps>

801075ab <vector45>:
.globl vector45
vector45:
  pushl $0
801075ab:	6a 00                	push   $0x0
  pushl $45
801075ad:	6a 2d                	push   $0x2d
  jmp alltraps
801075af:	e9 43 f9 ff ff       	jmp    80106ef7 <alltraps>

801075b4 <vector46>:
.globl vector46
vector46:
  pushl $0
801075b4:	6a 00                	push   $0x0
  pushl $46
801075b6:	6a 2e                	push   $0x2e
  jmp alltraps
801075b8:	e9 3a f9 ff ff       	jmp    80106ef7 <alltraps>

801075bd <vector47>:
.globl vector47
vector47:
  pushl $0
801075bd:	6a 00                	push   $0x0
  pushl $47
801075bf:	6a 2f                	push   $0x2f
  jmp alltraps
801075c1:	e9 31 f9 ff ff       	jmp    80106ef7 <alltraps>

801075c6 <vector48>:
.globl vector48
vector48:
  pushl $0
801075c6:	6a 00                	push   $0x0
  pushl $48
801075c8:	6a 30                	push   $0x30
  jmp alltraps
801075ca:	e9 28 f9 ff ff       	jmp    80106ef7 <alltraps>

801075cf <vector49>:
.globl vector49
vector49:
  pushl $0
801075cf:	6a 00                	push   $0x0
  pushl $49
801075d1:	6a 31                	push   $0x31
  jmp alltraps
801075d3:	e9 1f f9 ff ff       	jmp    80106ef7 <alltraps>

801075d8 <vector50>:
.globl vector50
vector50:
  pushl $0
801075d8:	6a 00                	push   $0x0
  pushl $50
801075da:	6a 32                	push   $0x32
  jmp alltraps
801075dc:	e9 16 f9 ff ff       	jmp    80106ef7 <alltraps>

801075e1 <vector51>:
.globl vector51
vector51:
  pushl $0
801075e1:	6a 00                	push   $0x0
  pushl $51
801075e3:	6a 33                	push   $0x33
  jmp alltraps
801075e5:	e9 0d f9 ff ff       	jmp    80106ef7 <alltraps>

801075ea <vector52>:
.globl vector52
vector52:
  pushl $0
801075ea:	6a 00                	push   $0x0
  pushl $52
801075ec:	6a 34                	push   $0x34
  jmp alltraps
801075ee:	e9 04 f9 ff ff       	jmp    80106ef7 <alltraps>

801075f3 <vector53>:
.globl vector53
vector53:
  pushl $0
801075f3:	6a 00                	push   $0x0
  pushl $53
801075f5:	6a 35                	push   $0x35
  jmp alltraps
801075f7:	e9 fb f8 ff ff       	jmp    80106ef7 <alltraps>

801075fc <vector54>:
.globl vector54
vector54:
  pushl $0
801075fc:	6a 00                	push   $0x0
  pushl $54
801075fe:	6a 36                	push   $0x36
  jmp alltraps
80107600:	e9 f2 f8 ff ff       	jmp    80106ef7 <alltraps>

80107605 <vector55>:
.globl vector55
vector55:
  pushl $0
80107605:	6a 00                	push   $0x0
  pushl $55
80107607:	6a 37                	push   $0x37
  jmp alltraps
80107609:	e9 e9 f8 ff ff       	jmp    80106ef7 <alltraps>

8010760e <vector56>:
.globl vector56
vector56:
  pushl $0
8010760e:	6a 00                	push   $0x0
  pushl $56
80107610:	6a 38                	push   $0x38
  jmp alltraps
80107612:	e9 e0 f8 ff ff       	jmp    80106ef7 <alltraps>

80107617 <vector57>:
.globl vector57
vector57:
  pushl $0
80107617:	6a 00                	push   $0x0
  pushl $57
80107619:	6a 39                	push   $0x39
  jmp alltraps
8010761b:	e9 d7 f8 ff ff       	jmp    80106ef7 <alltraps>

80107620 <vector58>:
.globl vector58
vector58:
  pushl $0
80107620:	6a 00                	push   $0x0
  pushl $58
80107622:	6a 3a                	push   $0x3a
  jmp alltraps
80107624:	e9 ce f8 ff ff       	jmp    80106ef7 <alltraps>

80107629 <vector59>:
.globl vector59
vector59:
  pushl $0
80107629:	6a 00                	push   $0x0
  pushl $59
8010762b:	6a 3b                	push   $0x3b
  jmp alltraps
8010762d:	e9 c5 f8 ff ff       	jmp    80106ef7 <alltraps>

80107632 <vector60>:
.globl vector60
vector60:
  pushl $0
80107632:	6a 00                	push   $0x0
  pushl $60
80107634:	6a 3c                	push   $0x3c
  jmp alltraps
80107636:	e9 bc f8 ff ff       	jmp    80106ef7 <alltraps>

8010763b <vector61>:
.globl vector61
vector61:
  pushl $0
8010763b:	6a 00                	push   $0x0
  pushl $61
8010763d:	6a 3d                	push   $0x3d
  jmp alltraps
8010763f:	e9 b3 f8 ff ff       	jmp    80106ef7 <alltraps>

80107644 <vector62>:
.globl vector62
vector62:
  pushl $0
80107644:	6a 00                	push   $0x0
  pushl $62
80107646:	6a 3e                	push   $0x3e
  jmp alltraps
80107648:	e9 aa f8 ff ff       	jmp    80106ef7 <alltraps>

8010764d <vector63>:
.globl vector63
vector63:
  pushl $0
8010764d:	6a 00                	push   $0x0
  pushl $63
8010764f:	6a 3f                	push   $0x3f
  jmp alltraps
80107651:	e9 a1 f8 ff ff       	jmp    80106ef7 <alltraps>

80107656 <vector64>:
.globl vector64
vector64:
  pushl $0
80107656:	6a 00                	push   $0x0
  pushl $64
80107658:	6a 40                	push   $0x40
  jmp alltraps
8010765a:	e9 98 f8 ff ff       	jmp    80106ef7 <alltraps>

8010765f <vector65>:
.globl vector65
vector65:
  pushl $0
8010765f:	6a 00                	push   $0x0
  pushl $65
80107661:	6a 41                	push   $0x41
  jmp alltraps
80107663:	e9 8f f8 ff ff       	jmp    80106ef7 <alltraps>

80107668 <vector66>:
.globl vector66
vector66:
  pushl $0
80107668:	6a 00                	push   $0x0
  pushl $66
8010766a:	6a 42                	push   $0x42
  jmp alltraps
8010766c:	e9 86 f8 ff ff       	jmp    80106ef7 <alltraps>

80107671 <vector67>:
.globl vector67
vector67:
  pushl $0
80107671:	6a 00                	push   $0x0
  pushl $67
80107673:	6a 43                	push   $0x43
  jmp alltraps
80107675:	e9 7d f8 ff ff       	jmp    80106ef7 <alltraps>

8010767a <vector68>:
.globl vector68
vector68:
  pushl $0
8010767a:	6a 00                	push   $0x0
  pushl $68
8010767c:	6a 44                	push   $0x44
  jmp alltraps
8010767e:	e9 74 f8 ff ff       	jmp    80106ef7 <alltraps>

80107683 <vector69>:
.globl vector69
vector69:
  pushl $0
80107683:	6a 00                	push   $0x0
  pushl $69
80107685:	6a 45                	push   $0x45
  jmp alltraps
80107687:	e9 6b f8 ff ff       	jmp    80106ef7 <alltraps>

8010768c <vector70>:
.globl vector70
vector70:
  pushl $0
8010768c:	6a 00                	push   $0x0
  pushl $70
8010768e:	6a 46                	push   $0x46
  jmp alltraps
80107690:	e9 62 f8 ff ff       	jmp    80106ef7 <alltraps>

80107695 <vector71>:
.globl vector71
vector71:
  pushl $0
80107695:	6a 00                	push   $0x0
  pushl $71
80107697:	6a 47                	push   $0x47
  jmp alltraps
80107699:	e9 59 f8 ff ff       	jmp    80106ef7 <alltraps>

8010769e <vector72>:
.globl vector72
vector72:
  pushl $0
8010769e:	6a 00                	push   $0x0
  pushl $72
801076a0:	6a 48                	push   $0x48
  jmp alltraps
801076a2:	e9 50 f8 ff ff       	jmp    80106ef7 <alltraps>

801076a7 <vector73>:
.globl vector73
vector73:
  pushl $0
801076a7:	6a 00                	push   $0x0
  pushl $73
801076a9:	6a 49                	push   $0x49
  jmp alltraps
801076ab:	e9 47 f8 ff ff       	jmp    80106ef7 <alltraps>

801076b0 <vector74>:
.globl vector74
vector74:
  pushl $0
801076b0:	6a 00                	push   $0x0
  pushl $74
801076b2:	6a 4a                	push   $0x4a
  jmp alltraps
801076b4:	e9 3e f8 ff ff       	jmp    80106ef7 <alltraps>

801076b9 <vector75>:
.globl vector75
vector75:
  pushl $0
801076b9:	6a 00                	push   $0x0
  pushl $75
801076bb:	6a 4b                	push   $0x4b
  jmp alltraps
801076bd:	e9 35 f8 ff ff       	jmp    80106ef7 <alltraps>

801076c2 <vector76>:
.globl vector76
vector76:
  pushl $0
801076c2:	6a 00                	push   $0x0
  pushl $76
801076c4:	6a 4c                	push   $0x4c
  jmp alltraps
801076c6:	e9 2c f8 ff ff       	jmp    80106ef7 <alltraps>

801076cb <vector77>:
.globl vector77
vector77:
  pushl $0
801076cb:	6a 00                	push   $0x0
  pushl $77
801076cd:	6a 4d                	push   $0x4d
  jmp alltraps
801076cf:	e9 23 f8 ff ff       	jmp    80106ef7 <alltraps>

801076d4 <vector78>:
.globl vector78
vector78:
  pushl $0
801076d4:	6a 00                	push   $0x0
  pushl $78
801076d6:	6a 4e                	push   $0x4e
  jmp alltraps
801076d8:	e9 1a f8 ff ff       	jmp    80106ef7 <alltraps>

801076dd <vector79>:
.globl vector79
vector79:
  pushl $0
801076dd:	6a 00                	push   $0x0
  pushl $79
801076df:	6a 4f                	push   $0x4f
  jmp alltraps
801076e1:	e9 11 f8 ff ff       	jmp    80106ef7 <alltraps>

801076e6 <vector80>:
.globl vector80
vector80:
  pushl $0
801076e6:	6a 00                	push   $0x0
  pushl $80
801076e8:	6a 50                	push   $0x50
  jmp alltraps
801076ea:	e9 08 f8 ff ff       	jmp    80106ef7 <alltraps>

801076ef <vector81>:
.globl vector81
vector81:
  pushl $0
801076ef:	6a 00                	push   $0x0
  pushl $81
801076f1:	6a 51                	push   $0x51
  jmp alltraps
801076f3:	e9 ff f7 ff ff       	jmp    80106ef7 <alltraps>

801076f8 <vector82>:
.globl vector82
vector82:
  pushl $0
801076f8:	6a 00                	push   $0x0
  pushl $82
801076fa:	6a 52                	push   $0x52
  jmp alltraps
801076fc:	e9 f6 f7 ff ff       	jmp    80106ef7 <alltraps>

80107701 <vector83>:
.globl vector83
vector83:
  pushl $0
80107701:	6a 00                	push   $0x0
  pushl $83
80107703:	6a 53                	push   $0x53
  jmp alltraps
80107705:	e9 ed f7 ff ff       	jmp    80106ef7 <alltraps>

8010770a <vector84>:
.globl vector84
vector84:
  pushl $0
8010770a:	6a 00                	push   $0x0
  pushl $84
8010770c:	6a 54                	push   $0x54
  jmp alltraps
8010770e:	e9 e4 f7 ff ff       	jmp    80106ef7 <alltraps>

80107713 <vector85>:
.globl vector85
vector85:
  pushl $0
80107713:	6a 00                	push   $0x0
  pushl $85
80107715:	6a 55                	push   $0x55
  jmp alltraps
80107717:	e9 db f7 ff ff       	jmp    80106ef7 <alltraps>

8010771c <vector86>:
.globl vector86
vector86:
  pushl $0
8010771c:	6a 00                	push   $0x0
  pushl $86
8010771e:	6a 56                	push   $0x56
  jmp alltraps
80107720:	e9 d2 f7 ff ff       	jmp    80106ef7 <alltraps>

80107725 <vector87>:
.globl vector87
vector87:
  pushl $0
80107725:	6a 00                	push   $0x0
  pushl $87
80107727:	6a 57                	push   $0x57
  jmp alltraps
80107729:	e9 c9 f7 ff ff       	jmp    80106ef7 <alltraps>

8010772e <vector88>:
.globl vector88
vector88:
  pushl $0
8010772e:	6a 00                	push   $0x0
  pushl $88
80107730:	6a 58                	push   $0x58
  jmp alltraps
80107732:	e9 c0 f7 ff ff       	jmp    80106ef7 <alltraps>

80107737 <vector89>:
.globl vector89
vector89:
  pushl $0
80107737:	6a 00                	push   $0x0
  pushl $89
80107739:	6a 59                	push   $0x59
  jmp alltraps
8010773b:	e9 b7 f7 ff ff       	jmp    80106ef7 <alltraps>

80107740 <vector90>:
.globl vector90
vector90:
  pushl $0
80107740:	6a 00                	push   $0x0
  pushl $90
80107742:	6a 5a                	push   $0x5a
  jmp alltraps
80107744:	e9 ae f7 ff ff       	jmp    80106ef7 <alltraps>

80107749 <vector91>:
.globl vector91
vector91:
  pushl $0
80107749:	6a 00                	push   $0x0
  pushl $91
8010774b:	6a 5b                	push   $0x5b
  jmp alltraps
8010774d:	e9 a5 f7 ff ff       	jmp    80106ef7 <alltraps>

80107752 <vector92>:
.globl vector92
vector92:
  pushl $0
80107752:	6a 00                	push   $0x0
  pushl $92
80107754:	6a 5c                	push   $0x5c
  jmp alltraps
80107756:	e9 9c f7 ff ff       	jmp    80106ef7 <alltraps>

8010775b <vector93>:
.globl vector93
vector93:
  pushl $0
8010775b:	6a 00                	push   $0x0
  pushl $93
8010775d:	6a 5d                	push   $0x5d
  jmp alltraps
8010775f:	e9 93 f7 ff ff       	jmp    80106ef7 <alltraps>

80107764 <vector94>:
.globl vector94
vector94:
  pushl $0
80107764:	6a 00                	push   $0x0
  pushl $94
80107766:	6a 5e                	push   $0x5e
  jmp alltraps
80107768:	e9 8a f7 ff ff       	jmp    80106ef7 <alltraps>

8010776d <vector95>:
.globl vector95
vector95:
  pushl $0
8010776d:	6a 00                	push   $0x0
  pushl $95
8010776f:	6a 5f                	push   $0x5f
  jmp alltraps
80107771:	e9 81 f7 ff ff       	jmp    80106ef7 <alltraps>

80107776 <vector96>:
.globl vector96
vector96:
  pushl $0
80107776:	6a 00                	push   $0x0
  pushl $96
80107778:	6a 60                	push   $0x60
  jmp alltraps
8010777a:	e9 78 f7 ff ff       	jmp    80106ef7 <alltraps>

8010777f <vector97>:
.globl vector97
vector97:
  pushl $0
8010777f:	6a 00                	push   $0x0
  pushl $97
80107781:	6a 61                	push   $0x61
  jmp alltraps
80107783:	e9 6f f7 ff ff       	jmp    80106ef7 <alltraps>

80107788 <vector98>:
.globl vector98
vector98:
  pushl $0
80107788:	6a 00                	push   $0x0
  pushl $98
8010778a:	6a 62                	push   $0x62
  jmp alltraps
8010778c:	e9 66 f7 ff ff       	jmp    80106ef7 <alltraps>

80107791 <vector99>:
.globl vector99
vector99:
  pushl $0
80107791:	6a 00                	push   $0x0
  pushl $99
80107793:	6a 63                	push   $0x63
  jmp alltraps
80107795:	e9 5d f7 ff ff       	jmp    80106ef7 <alltraps>

8010779a <vector100>:
.globl vector100
vector100:
  pushl $0
8010779a:	6a 00                	push   $0x0
  pushl $100
8010779c:	6a 64                	push   $0x64
  jmp alltraps
8010779e:	e9 54 f7 ff ff       	jmp    80106ef7 <alltraps>

801077a3 <vector101>:
.globl vector101
vector101:
  pushl $0
801077a3:	6a 00                	push   $0x0
  pushl $101
801077a5:	6a 65                	push   $0x65
  jmp alltraps
801077a7:	e9 4b f7 ff ff       	jmp    80106ef7 <alltraps>

801077ac <vector102>:
.globl vector102
vector102:
  pushl $0
801077ac:	6a 00                	push   $0x0
  pushl $102
801077ae:	6a 66                	push   $0x66
  jmp alltraps
801077b0:	e9 42 f7 ff ff       	jmp    80106ef7 <alltraps>

801077b5 <vector103>:
.globl vector103
vector103:
  pushl $0
801077b5:	6a 00                	push   $0x0
  pushl $103
801077b7:	6a 67                	push   $0x67
  jmp alltraps
801077b9:	e9 39 f7 ff ff       	jmp    80106ef7 <alltraps>

801077be <vector104>:
.globl vector104
vector104:
  pushl $0
801077be:	6a 00                	push   $0x0
  pushl $104
801077c0:	6a 68                	push   $0x68
  jmp alltraps
801077c2:	e9 30 f7 ff ff       	jmp    80106ef7 <alltraps>

801077c7 <vector105>:
.globl vector105
vector105:
  pushl $0
801077c7:	6a 00                	push   $0x0
  pushl $105
801077c9:	6a 69                	push   $0x69
  jmp alltraps
801077cb:	e9 27 f7 ff ff       	jmp    80106ef7 <alltraps>

801077d0 <vector106>:
.globl vector106
vector106:
  pushl $0
801077d0:	6a 00                	push   $0x0
  pushl $106
801077d2:	6a 6a                	push   $0x6a
  jmp alltraps
801077d4:	e9 1e f7 ff ff       	jmp    80106ef7 <alltraps>

801077d9 <vector107>:
.globl vector107
vector107:
  pushl $0
801077d9:	6a 00                	push   $0x0
  pushl $107
801077db:	6a 6b                	push   $0x6b
  jmp alltraps
801077dd:	e9 15 f7 ff ff       	jmp    80106ef7 <alltraps>

801077e2 <vector108>:
.globl vector108
vector108:
  pushl $0
801077e2:	6a 00                	push   $0x0
  pushl $108
801077e4:	6a 6c                	push   $0x6c
  jmp alltraps
801077e6:	e9 0c f7 ff ff       	jmp    80106ef7 <alltraps>

801077eb <vector109>:
.globl vector109
vector109:
  pushl $0
801077eb:	6a 00                	push   $0x0
  pushl $109
801077ed:	6a 6d                	push   $0x6d
  jmp alltraps
801077ef:	e9 03 f7 ff ff       	jmp    80106ef7 <alltraps>

801077f4 <vector110>:
.globl vector110
vector110:
  pushl $0
801077f4:	6a 00                	push   $0x0
  pushl $110
801077f6:	6a 6e                	push   $0x6e
  jmp alltraps
801077f8:	e9 fa f6 ff ff       	jmp    80106ef7 <alltraps>

801077fd <vector111>:
.globl vector111
vector111:
  pushl $0
801077fd:	6a 00                	push   $0x0
  pushl $111
801077ff:	6a 6f                	push   $0x6f
  jmp alltraps
80107801:	e9 f1 f6 ff ff       	jmp    80106ef7 <alltraps>

80107806 <vector112>:
.globl vector112
vector112:
  pushl $0
80107806:	6a 00                	push   $0x0
  pushl $112
80107808:	6a 70                	push   $0x70
  jmp alltraps
8010780a:	e9 e8 f6 ff ff       	jmp    80106ef7 <alltraps>

8010780f <vector113>:
.globl vector113
vector113:
  pushl $0
8010780f:	6a 00                	push   $0x0
  pushl $113
80107811:	6a 71                	push   $0x71
  jmp alltraps
80107813:	e9 df f6 ff ff       	jmp    80106ef7 <alltraps>

80107818 <vector114>:
.globl vector114
vector114:
  pushl $0
80107818:	6a 00                	push   $0x0
  pushl $114
8010781a:	6a 72                	push   $0x72
  jmp alltraps
8010781c:	e9 d6 f6 ff ff       	jmp    80106ef7 <alltraps>

80107821 <vector115>:
.globl vector115
vector115:
  pushl $0
80107821:	6a 00                	push   $0x0
  pushl $115
80107823:	6a 73                	push   $0x73
  jmp alltraps
80107825:	e9 cd f6 ff ff       	jmp    80106ef7 <alltraps>

8010782a <vector116>:
.globl vector116
vector116:
  pushl $0
8010782a:	6a 00                	push   $0x0
  pushl $116
8010782c:	6a 74                	push   $0x74
  jmp alltraps
8010782e:	e9 c4 f6 ff ff       	jmp    80106ef7 <alltraps>

80107833 <vector117>:
.globl vector117
vector117:
  pushl $0
80107833:	6a 00                	push   $0x0
  pushl $117
80107835:	6a 75                	push   $0x75
  jmp alltraps
80107837:	e9 bb f6 ff ff       	jmp    80106ef7 <alltraps>

8010783c <vector118>:
.globl vector118
vector118:
  pushl $0
8010783c:	6a 00                	push   $0x0
  pushl $118
8010783e:	6a 76                	push   $0x76
  jmp alltraps
80107840:	e9 b2 f6 ff ff       	jmp    80106ef7 <alltraps>

80107845 <vector119>:
.globl vector119
vector119:
  pushl $0
80107845:	6a 00                	push   $0x0
  pushl $119
80107847:	6a 77                	push   $0x77
  jmp alltraps
80107849:	e9 a9 f6 ff ff       	jmp    80106ef7 <alltraps>

8010784e <vector120>:
.globl vector120
vector120:
  pushl $0
8010784e:	6a 00                	push   $0x0
  pushl $120
80107850:	6a 78                	push   $0x78
  jmp alltraps
80107852:	e9 a0 f6 ff ff       	jmp    80106ef7 <alltraps>

80107857 <vector121>:
.globl vector121
vector121:
  pushl $0
80107857:	6a 00                	push   $0x0
  pushl $121
80107859:	6a 79                	push   $0x79
  jmp alltraps
8010785b:	e9 97 f6 ff ff       	jmp    80106ef7 <alltraps>

80107860 <vector122>:
.globl vector122
vector122:
  pushl $0
80107860:	6a 00                	push   $0x0
  pushl $122
80107862:	6a 7a                	push   $0x7a
  jmp alltraps
80107864:	e9 8e f6 ff ff       	jmp    80106ef7 <alltraps>

80107869 <vector123>:
.globl vector123
vector123:
  pushl $0
80107869:	6a 00                	push   $0x0
  pushl $123
8010786b:	6a 7b                	push   $0x7b
  jmp alltraps
8010786d:	e9 85 f6 ff ff       	jmp    80106ef7 <alltraps>

80107872 <vector124>:
.globl vector124
vector124:
  pushl $0
80107872:	6a 00                	push   $0x0
  pushl $124
80107874:	6a 7c                	push   $0x7c
  jmp alltraps
80107876:	e9 7c f6 ff ff       	jmp    80106ef7 <alltraps>

8010787b <vector125>:
.globl vector125
vector125:
  pushl $0
8010787b:	6a 00                	push   $0x0
  pushl $125
8010787d:	6a 7d                	push   $0x7d
  jmp alltraps
8010787f:	e9 73 f6 ff ff       	jmp    80106ef7 <alltraps>

80107884 <vector126>:
.globl vector126
vector126:
  pushl $0
80107884:	6a 00                	push   $0x0
  pushl $126
80107886:	6a 7e                	push   $0x7e
  jmp alltraps
80107888:	e9 6a f6 ff ff       	jmp    80106ef7 <alltraps>

8010788d <vector127>:
.globl vector127
vector127:
  pushl $0
8010788d:	6a 00                	push   $0x0
  pushl $127
8010788f:	6a 7f                	push   $0x7f
  jmp alltraps
80107891:	e9 61 f6 ff ff       	jmp    80106ef7 <alltraps>

80107896 <vector128>:
.globl vector128
vector128:
  pushl $0
80107896:	6a 00                	push   $0x0
  pushl $128
80107898:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010789d:	e9 55 f6 ff ff       	jmp    80106ef7 <alltraps>

801078a2 <vector129>:
.globl vector129
vector129:
  pushl $0
801078a2:	6a 00                	push   $0x0
  pushl $129
801078a4:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801078a9:	e9 49 f6 ff ff       	jmp    80106ef7 <alltraps>

801078ae <vector130>:
.globl vector130
vector130:
  pushl $0
801078ae:	6a 00                	push   $0x0
  pushl $130
801078b0:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801078b5:	e9 3d f6 ff ff       	jmp    80106ef7 <alltraps>

801078ba <vector131>:
.globl vector131
vector131:
  pushl $0
801078ba:	6a 00                	push   $0x0
  pushl $131
801078bc:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801078c1:	e9 31 f6 ff ff       	jmp    80106ef7 <alltraps>

801078c6 <vector132>:
.globl vector132
vector132:
  pushl $0
801078c6:	6a 00                	push   $0x0
  pushl $132
801078c8:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801078cd:	e9 25 f6 ff ff       	jmp    80106ef7 <alltraps>

801078d2 <vector133>:
.globl vector133
vector133:
  pushl $0
801078d2:	6a 00                	push   $0x0
  pushl $133
801078d4:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801078d9:	e9 19 f6 ff ff       	jmp    80106ef7 <alltraps>

801078de <vector134>:
.globl vector134
vector134:
  pushl $0
801078de:	6a 00                	push   $0x0
  pushl $134
801078e0:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801078e5:	e9 0d f6 ff ff       	jmp    80106ef7 <alltraps>

801078ea <vector135>:
.globl vector135
vector135:
  pushl $0
801078ea:	6a 00                	push   $0x0
  pushl $135
801078ec:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801078f1:	e9 01 f6 ff ff       	jmp    80106ef7 <alltraps>

801078f6 <vector136>:
.globl vector136
vector136:
  pushl $0
801078f6:	6a 00                	push   $0x0
  pushl $136
801078f8:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801078fd:	e9 f5 f5 ff ff       	jmp    80106ef7 <alltraps>

80107902 <vector137>:
.globl vector137
vector137:
  pushl $0
80107902:	6a 00                	push   $0x0
  pushl $137
80107904:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80107909:	e9 e9 f5 ff ff       	jmp    80106ef7 <alltraps>

8010790e <vector138>:
.globl vector138
vector138:
  pushl $0
8010790e:	6a 00                	push   $0x0
  pushl $138
80107910:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107915:	e9 dd f5 ff ff       	jmp    80106ef7 <alltraps>

8010791a <vector139>:
.globl vector139
vector139:
  pushl $0
8010791a:	6a 00                	push   $0x0
  pushl $139
8010791c:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80107921:	e9 d1 f5 ff ff       	jmp    80106ef7 <alltraps>

80107926 <vector140>:
.globl vector140
vector140:
  pushl $0
80107926:	6a 00                	push   $0x0
  pushl $140
80107928:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010792d:	e9 c5 f5 ff ff       	jmp    80106ef7 <alltraps>

80107932 <vector141>:
.globl vector141
vector141:
  pushl $0
80107932:	6a 00                	push   $0x0
  pushl $141
80107934:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80107939:	e9 b9 f5 ff ff       	jmp    80106ef7 <alltraps>

8010793e <vector142>:
.globl vector142
vector142:
  pushl $0
8010793e:	6a 00                	push   $0x0
  pushl $142
80107940:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107945:	e9 ad f5 ff ff       	jmp    80106ef7 <alltraps>

8010794a <vector143>:
.globl vector143
vector143:
  pushl $0
8010794a:	6a 00                	push   $0x0
  pushl $143
8010794c:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80107951:	e9 a1 f5 ff ff       	jmp    80106ef7 <alltraps>

80107956 <vector144>:
.globl vector144
vector144:
  pushl $0
80107956:	6a 00                	push   $0x0
  pushl $144
80107958:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010795d:	e9 95 f5 ff ff       	jmp    80106ef7 <alltraps>

80107962 <vector145>:
.globl vector145
vector145:
  pushl $0
80107962:	6a 00                	push   $0x0
  pushl $145
80107964:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80107969:	e9 89 f5 ff ff       	jmp    80106ef7 <alltraps>

8010796e <vector146>:
.globl vector146
vector146:
  pushl $0
8010796e:	6a 00                	push   $0x0
  pushl $146
80107970:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107975:	e9 7d f5 ff ff       	jmp    80106ef7 <alltraps>

8010797a <vector147>:
.globl vector147
vector147:
  pushl $0
8010797a:	6a 00                	push   $0x0
  pushl $147
8010797c:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107981:	e9 71 f5 ff ff       	jmp    80106ef7 <alltraps>

80107986 <vector148>:
.globl vector148
vector148:
  pushl $0
80107986:	6a 00                	push   $0x0
  pushl $148
80107988:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010798d:	e9 65 f5 ff ff       	jmp    80106ef7 <alltraps>

80107992 <vector149>:
.globl vector149
vector149:
  pushl $0
80107992:	6a 00                	push   $0x0
  pushl $149
80107994:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80107999:	e9 59 f5 ff ff       	jmp    80106ef7 <alltraps>

8010799e <vector150>:
.globl vector150
vector150:
  pushl $0
8010799e:	6a 00                	push   $0x0
  pushl $150
801079a0:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801079a5:	e9 4d f5 ff ff       	jmp    80106ef7 <alltraps>

801079aa <vector151>:
.globl vector151
vector151:
  pushl $0
801079aa:	6a 00                	push   $0x0
  pushl $151
801079ac:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801079b1:	e9 41 f5 ff ff       	jmp    80106ef7 <alltraps>

801079b6 <vector152>:
.globl vector152
vector152:
  pushl $0
801079b6:	6a 00                	push   $0x0
  pushl $152
801079b8:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801079bd:	e9 35 f5 ff ff       	jmp    80106ef7 <alltraps>

801079c2 <vector153>:
.globl vector153
vector153:
  pushl $0
801079c2:	6a 00                	push   $0x0
  pushl $153
801079c4:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801079c9:	e9 29 f5 ff ff       	jmp    80106ef7 <alltraps>

801079ce <vector154>:
.globl vector154
vector154:
  pushl $0
801079ce:	6a 00                	push   $0x0
  pushl $154
801079d0:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801079d5:	e9 1d f5 ff ff       	jmp    80106ef7 <alltraps>

801079da <vector155>:
.globl vector155
vector155:
  pushl $0
801079da:	6a 00                	push   $0x0
  pushl $155
801079dc:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801079e1:	e9 11 f5 ff ff       	jmp    80106ef7 <alltraps>

801079e6 <vector156>:
.globl vector156
vector156:
  pushl $0
801079e6:	6a 00                	push   $0x0
  pushl $156
801079e8:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801079ed:	e9 05 f5 ff ff       	jmp    80106ef7 <alltraps>

801079f2 <vector157>:
.globl vector157
vector157:
  pushl $0
801079f2:	6a 00                	push   $0x0
  pushl $157
801079f4:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801079f9:	e9 f9 f4 ff ff       	jmp    80106ef7 <alltraps>

801079fe <vector158>:
.globl vector158
vector158:
  pushl $0
801079fe:	6a 00                	push   $0x0
  pushl $158
80107a00:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107a05:	e9 ed f4 ff ff       	jmp    80106ef7 <alltraps>

80107a0a <vector159>:
.globl vector159
vector159:
  pushl $0
80107a0a:	6a 00                	push   $0x0
  pushl $159
80107a0c:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80107a11:	e9 e1 f4 ff ff       	jmp    80106ef7 <alltraps>

80107a16 <vector160>:
.globl vector160
vector160:
  pushl $0
80107a16:	6a 00                	push   $0x0
  pushl $160
80107a18:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80107a1d:	e9 d5 f4 ff ff       	jmp    80106ef7 <alltraps>

80107a22 <vector161>:
.globl vector161
vector161:
  pushl $0
80107a22:	6a 00                	push   $0x0
  pushl $161
80107a24:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80107a29:	e9 c9 f4 ff ff       	jmp    80106ef7 <alltraps>

80107a2e <vector162>:
.globl vector162
vector162:
  pushl $0
80107a2e:	6a 00                	push   $0x0
  pushl $162
80107a30:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107a35:	e9 bd f4 ff ff       	jmp    80106ef7 <alltraps>

80107a3a <vector163>:
.globl vector163
vector163:
  pushl $0
80107a3a:	6a 00                	push   $0x0
  pushl $163
80107a3c:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80107a41:	e9 b1 f4 ff ff       	jmp    80106ef7 <alltraps>

80107a46 <vector164>:
.globl vector164
vector164:
  pushl $0
80107a46:	6a 00                	push   $0x0
  pushl $164
80107a48:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80107a4d:	e9 a5 f4 ff ff       	jmp    80106ef7 <alltraps>

80107a52 <vector165>:
.globl vector165
vector165:
  pushl $0
80107a52:	6a 00                	push   $0x0
  pushl $165
80107a54:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80107a59:	e9 99 f4 ff ff       	jmp    80106ef7 <alltraps>

80107a5e <vector166>:
.globl vector166
vector166:
  pushl $0
80107a5e:	6a 00                	push   $0x0
  pushl $166
80107a60:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107a65:	e9 8d f4 ff ff       	jmp    80106ef7 <alltraps>

80107a6a <vector167>:
.globl vector167
vector167:
  pushl $0
80107a6a:	6a 00                	push   $0x0
  pushl $167
80107a6c:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107a71:	e9 81 f4 ff ff       	jmp    80106ef7 <alltraps>

80107a76 <vector168>:
.globl vector168
vector168:
  pushl $0
80107a76:	6a 00                	push   $0x0
  pushl $168
80107a78:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80107a7d:	e9 75 f4 ff ff       	jmp    80106ef7 <alltraps>

80107a82 <vector169>:
.globl vector169
vector169:
  pushl $0
80107a82:	6a 00                	push   $0x0
  pushl $169
80107a84:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80107a89:	e9 69 f4 ff ff       	jmp    80106ef7 <alltraps>

80107a8e <vector170>:
.globl vector170
vector170:
  pushl $0
80107a8e:	6a 00                	push   $0x0
  pushl $170
80107a90:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107a95:	e9 5d f4 ff ff       	jmp    80106ef7 <alltraps>

80107a9a <vector171>:
.globl vector171
vector171:
  pushl $0
80107a9a:	6a 00                	push   $0x0
  pushl $171
80107a9c:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107aa1:	e9 51 f4 ff ff       	jmp    80106ef7 <alltraps>

80107aa6 <vector172>:
.globl vector172
vector172:
  pushl $0
80107aa6:	6a 00                	push   $0x0
  pushl $172
80107aa8:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80107aad:	e9 45 f4 ff ff       	jmp    80106ef7 <alltraps>

80107ab2 <vector173>:
.globl vector173
vector173:
  pushl $0
80107ab2:	6a 00                	push   $0x0
  pushl $173
80107ab4:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80107ab9:	e9 39 f4 ff ff       	jmp    80106ef7 <alltraps>

80107abe <vector174>:
.globl vector174
vector174:
  pushl $0
80107abe:	6a 00                	push   $0x0
  pushl $174
80107ac0:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107ac5:	e9 2d f4 ff ff       	jmp    80106ef7 <alltraps>

80107aca <vector175>:
.globl vector175
vector175:
  pushl $0
80107aca:	6a 00                	push   $0x0
  pushl $175
80107acc:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107ad1:	e9 21 f4 ff ff       	jmp    80106ef7 <alltraps>

80107ad6 <vector176>:
.globl vector176
vector176:
  pushl $0
80107ad6:	6a 00                	push   $0x0
  pushl $176
80107ad8:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80107add:	e9 15 f4 ff ff       	jmp    80106ef7 <alltraps>

80107ae2 <vector177>:
.globl vector177
vector177:
  pushl $0
80107ae2:	6a 00                	push   $0x0
  pushl $177
80107ae4:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80107ae9:	e9 09 f4 ff ff       	jmp    80106ef7 <alltraps>

80107aee <vector178>:
.globl vector178
vector178:
  pushl $0
80107aee:	6a 00                	push   $0x0
  pushl $178
80107af0:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107af5:	e9 fd f3 ff ff       	jmp    80106ef7 <alltraps>

80107afa <vector179>:
.globl vector179
vector179:
  pushl $0
80107afa:	6a 00                	push   $0x0
  pushl $179
80107afc:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107b01:	e9 f1 f3 ff ff       	jmp    80106ef7 <alltraps>

80107b06 <vector180>:
.globl vector180
vector180:
  pushl $0
80107b06:	6a 00                	push   $0x0
  pushl $180
80107b08:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80107b0d:	e9 e5 f3 ff ff       	jmp    80106ef7 <alltraps>

80107b12 <vector181>:
.globl vector181
vector181:
  pushl $0
80107b12:	6a 00                	push   $0x0
  pushl $181
80107b14:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80107b19:	e9 d9 f3 ff ff       	jmp    80106ef7 <alltraps>

80107b1e <vector182>:
.globl vector182
vector182:
  pushl $0
80107b1e:	6a 00                	push   $0x0
  pushl $182
80107b20:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107b25:	e9 cd f3 ff ff       	jmp    80106ef7 <alltraps>

80107b2a <vector183>:
.globl vector183
vector183:
  pushl $0
80107b2a:	6a 00                	push   $0x0
  pushl $183
80107b2c:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107b31:	e9 c1 f3 ff ff       	jmp    80106ef7 <alltraps>

80107b36 <vector184>:
.globl vector184
vector184:
  pushl $0
80107b36:	6a 00                	push   $0x0
  pushl $184
80107b38:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80107b3d:	e9 b5 f3 ff ff       	jmp    80106ef7 <alltraps>

80107b42 <vector185>:
.globl vector185
vector185:
  pushl $0
80107b42:	6a 00                	push   $0x0
  pushl $185
80107b44:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80107b49:	e9 a9 f3 ff ff       	jmp    80106ef7 <alltraps>

80107b4e <vector186>:
.globl vector186
vector186:
  pushl $0
80107b4e:	6a 00                	push   $0x0
  pushl $186
80107b50:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107b55:	e9 9d f3 ff ff       	jmp    80106ef7 <alltraps>

80107b5a <vector187>:
.globl vector187
vector187:
  pushl $0
80107b5a:	6a 00                	push   $0x0
  pushl $187
80107b5c:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107b61:	e9 91 f3 ff ff       	jmp    80106ef7 <alltraps>

80107b66 <vector188>:
.globl vector188
vector188:
  pushl $0
80107b66:	6a 00                	push   $0x0
  pushl $188
80107b68:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80107b6d:	e9 85 f3 ff ff       	jmp    80106ef7 <alltraps>

80107b72 <vector189>:
.globl vector189
vector189:
  pushl $0
80107b72:	6a 00                	push   $0x0
  pushl $189
80107b74:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80107b79:	e9 79 f3 ff ff       	jmp    80106ef7 <alltraps>

80107b7e <vector190>:
.globl vector190
vector190:
  pushl $0
80107b7e:	6a 00                	push   $0x0
  pushl $190
80107b80:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107b85:	e9 6d f3 ff ff       	jmp    80106ef7 <alltraps>

80107b8a <vector191>:
.globl vector191
vector191:
  pushl $0
80107b8a:	6a 00                	push   $0x0
  pushl $191
80107b8c:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107b91:	e9 61 f3 ff ff       	jmp    80106ef7 <alltraps>

80107b96 <vector192>:
.globl vector192
vector192:
  pushl $0
80107b96:	6a 00                	push   $0x0
  pushl $192
80107b98:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80107b9d:	e9 55 f3 ff ff       	jmp    80106ef7 <alltraps>

80107ba2 <vector193>:
.globl vector193
vector193:
  pushl $0
80107ba2:	6a 00                	push   $0x0
  pushl $193
80107ba4:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80107ba9:	e9 49 f3 ff ff       	jmp    80106ef7 <alltraps>

80107bae <vector194>:
.globl vector194
vector194:
  pushl $0
80107bae:	6a 00                	push   $0x0
  pushl $194
80107bb0:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107bb5:	e9 3d f3 ff ff       	jmp    80106ef7 <alltraps>

80107bba <vector195>:
.globl vector195
vector195:
  pushl $0
80107bba:	6a 00                	push   $0x0
  pushl $195
80107bbc:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107bc1:	e9 31 f3 ff ff       	jmp    80106ef7 <alltraps>

80107bc6 <vector196>:
.globl vector196
vector196:
  pushl $0
80107bc6:	6a 00                	push   $0x0
  pushl $196
80107bc8:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80107bcd:	e9 25 f3 ff ff       	jmp    80106ef7 <alltraps>

80107bd2 <vector197>:
.globl vector197
vector197:
  pushl $0
80107bd2:	6a 00                	push   $0x0
  pushl $197
80107bd4:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80107bd9:	e9 19 f3 ff ff       	jmp    80106ef7 <alltraps>

80107bde <vector198>:
.globl vector198
vector198:
  pushl $0
80107bde:	6a 00                	push   $0x0
  pushl $198
80107be0:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107be5:	e9 0d f3 ff ff       	jmp    80106ef7 <alltraps>

80107bea <vector199>:
.globl vector199
vector199:
  pushl $0
80107bea:	6a 00                	push   $0x0
  pushl $199
80107bec:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107bf1:	e9 01 f3 ff ff       	jmp    80106ef7 <alltraps>

80107bf6 <vector200>:
.globl vector200
vector200:
  pushl $0
80107bf6:	6a 00                	push   $0x0
  pushl $200
80107bf8:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80107bfd:	e9 f5 f2 ff ff       	jmp    80106ef7 <alltraps>

80107c02 <vector201>:
.globl vector201
vector201:
  pushl $0
80107c02:	6a 00                	push   $0x0
  pushl $201
80107c04:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80107c09:	e9 e9 f2 ff ff       	jmp    80106ef7 <alltraps>

80107c0e <vector202>:
.globl vector202
vector202:
  pushl $0
80107c0e:	6a 00                	push   $0x0
  pushl $202
80107c10:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107c15:	e9 dd f2 ff ff       	jmp    80106ef7 <alltraps>

80107c1a <vector203>:
.globl vector203
vector203:
  pushl $0
80107c1a:	6a 00                	push   $0x0
  pushl $203
80107c1c:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107c21:	e9 d1 f2 ff ff       	jmp    80106ef7 <alltraps>

80107c26 <vector204>:
.globl vector204
vector204:
  pushl $0
80107c26:	6a 00                	push   $0x0
  pushl $204
80107c28:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80107c2d:	e9 c5 f2 ff ff       	jmp    80106ef7 <alltraps>

80107c32 <vector205>:
.globl vector205
vector205:
  pushl $0
80107c32:	6a 00                	push   $0x0
  pushl $205
80107c34:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80107c39:	e9 b9 f2 ff ff       	jmp    80106ef7 <alltraps>

80107c3e <vector206>:
.globl vector206
vector206:
  pushl $0
80107c3e:	6a 00                	push   $0x0
  pushl $206
80107c40:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107c45:	e9 ad f2 ff ff       	jmp    80106ef7 <alltraps>

80107c4a <vector207>:
.globl vector207
vector207:
  pushl $0
80107c4a:	6a 00                	push   $0x0
  pushl $207
80107c4c:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107c51:	e9 a1 f2 ff ff       	jmp    80106ef7 <alltraps>

80107c56 <vector208>:
.globl vector208
vector208:
  pushl $0
80107c56:	6a 00                	push   $0x0
  pushl $208
80107c58:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80107c5d:	e9 95 f2 ff ff       	jmp    80106ef7 <alltraps>

80107c62 <vector209>:
.globl vector209
vector209:
  pushl $0
80107c62:	6a 00                	push   $0x0
  pushl $209
80107c64:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80107c69:	e9 89 f2 ff ff       	jmp    80106ef7 <alltraps>

80107c6e <vector210>:
.globl vector210
vector210:
  pushl $0
80107c6e:	6a 00                	push   $0x0
  pushl $210
80107c70:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107c75:	e9 7d f2 ff ff       	jmp    80106ef7 <alltraps>

80107c7a <vector211>:
.globl vector211
vector211:
  pushl $0
80107c7a:	6a 00                	push   $0x0
  pushl $211
80107c7c:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107c81:	e9 71 f2 ff ff       	jmp    80106ef7 <alltraps>

80107c86 <vector212>:
.globl vector212
vector212:
  pushl $0
80107c86:	6a 00                	push   $0x0
  pushl $212
80107c88:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80107c8d:	e9 65 f2 ff ff       	jmp    80106ef7 <alltraps>

80107c92 <vector213>:
.globl vector213
vector213:
  pushl $0
80107c92:	6a 00                	push   $0x0
  pushl $213
80107c94:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80107c99:	e9 59 f2 ff ff       	jmp    80106ef7 <alltraps>

80107c9e <vector214>:
.globl vector214
vector214:
  pushl $0
80107c9e:	6a 00                	push   $0x0
  pushl $214
80107ca0:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107ca5:	e9 4d f2 ff ff       	jmp    80106ef7 <alltraps>

80107caa <vector215>:
.globl vector215
vector215:
  pushl $0
80107caa:	6a 00                	push   $0x0
  pushl $215
80107cac:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107cb1:	e9 41 f2 ff ff       	jmp    80106ef7 <alltraps>

80107cb6 <vector216>:
.globl vector216
vector216:
  pushl $0
80107cb6:	6a 00                	push   $0x0
  pushl $216
80107cb8:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80107cbd:	e9 35 f2 ff ff       	jmp    80106ef7 <alltraps>

80107cc2 <vector217>:
.globl vector217
vector217:
  pushl $0
80107cc2:	6a 00                	push   $0x0
  pushl $217
80107cc4:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80107cc9:	e9 29 f2 ff ff       	jmp    80106ef7 <alltraps>

80107cce <vector218>:
.globl vector218
vector218:
  pushl $0
80107cce:	6a 00                	push   $0x0
  pushl $218
80107cd0:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107cd5:	e9 1d f2 ff ff       	jmp    80106ef7 <alltraps>

80107cda <vector219>:
.globl vector219
vector219:
  pushl $0
80107cda:	6a 00                	push   $0x0
  pushl $219
80107cdc:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107ce1:	e9 11 f2 ff ff       	jmp    80106ef7 <alltraps>

80107ce6 <vector220>:
.globl vector220
vector220:
  pushl $0
80107ce6:	6a 00                	push   $0x0
  pushl $220
80107ce8:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80107ced:	e9 05 f2 ff ff       	jmp    80106ef7 <alltraps>

80107cf2 <vector221>:
.globl vector221
vector221:
  pushl $0
80107cf2:	6a 00                	push   $0x0
  pushl $221
80107cf4:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80107cf9:	e9 f9 f1 ff ff       	jmp    80106ef7 <alltraps>

80107cfe <vector222>:
.globl vector222
vector222:
  pushl $0
80107cfe:	6a 00                	push   $0x0
  pushl $222
80107d00:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107d05:	e9 ed f1 ff ff       	jmp    80106ef7 <alltraps>

80107d0a <vector223>:
.globl vector223
vector223:
  pushl $0
80107d0a:	6a 00                	push   $0x0
  pushl $223
80107d0c:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107d11:	e9 e1 f1 ff ff       	jmp    80106ef7 <alltraps>

80107d16 <vector224>:
.globl vector224
vector224:
  pushl $0
80107d16:	6a 00                	push   $0x0
  pushl $224
80107d18:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80107d1d:	e9 d5 f1 ff ff       	jmp    80106ef7 <alltraps>

80107d22 <vector225>:
.globl vector225
vector225:
  pushl $0
80107d22:	6a 00                	push   $0x0
  pushl $225
80107d24:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107d29:	e9 c9 f1 ff ff       	jmp    80106ef7 <alltraps>

80107d2e <vector226>:
.globl vector226
vector226:
  pushl $0
80107d2e:	6a 00                	push   $0x0
  pushl $226
80107d30:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107d35:	e9 bd f1 ff ff       	jmp    80106ef7 <alltraps>

80107d3a <vector227>:
.globl vector227
vector227:
  pushl $0
80107d3a:	6a 00                	push   $0x0
  pushl $227
80107d3c:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107d41:	e9 b1 f1 ff ff       	jmp    80106ef7 <alltraps>

80107d46 <vector228>:
.globl vector228
vector228:
  pushl $0
80107d46:	6a 00                	push   $0x0
  pushl $228
80107d48:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107d4d:	e9 a5 f1 ff ff       	jmp    80106ef7 <alltraps>

80107d52 <vector229>:
.globl vector229
vector229:
  pushl $0
80107d52:	6a 00                	push   $0x0
  pushl $229
80107d54:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107d59:	e9 99 f1 ff ff       	jmp    80106ef7 <alltraps>

80107d5e <vector230>:
.globl vector230
vector230:
  pushl $0
80107d5e:	6a 00                	push   $0x0
  pushl $230
80107d60:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107d65:	e9 8d f1 ff ff       	jmp    80106ef7 <alltraps>

80107d6a <vector231>:
.globl vector231
vector231:
  pushl $0
80107d6a:	6a 00                	push   $0x0
  pushl $231
80107d6c:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107d71:	e9 81 f1 ff ff       	jmp    80106ef7 <alltraps>

80107d76 <vector232>:
.globl vector232
vector232:
  pushl $0
80107d76:	6a 00                	push   $0x0
  pushl $232
80107d78:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107d7d:	e9 75 f1 ff ff       	jmp    80106ef7 <alltraps>

80107d82 <vector233>:
.globl vector233
vector233:
  pushl $0
80107d82:	6a 00                	push   $0x0
  pushl $233
80107d84:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107d89:	e9 69 f1 ff ff       	jmp    80106ef7 <alltraps>

80107d8e <vector234>:
.globl vector234
vector234:
  pushl $0
80107d8e:	6a 00                	push   $0x0
  pushl $234
80107d90:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107d95:	e9 5d f1 ff ff       	jmp    80106ef7 <alltraps>

80107d9a <vector235>:
.globl vector235
vector235:
  pushl $0
80107d9a:	6a 00                	push   $0x0
  pushl $235
80107d9c:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107da1:	e9 51 f1 ff ff       	jmp    80106ef7 <alltraps>

80107da6 <vector236>:
.globl vector236
vector236:
  pushl $0
80107da6:	6a 00                	push   $0x0
  pushl $236
80107da8:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107dad:	e9 45 f1 ff ff       	jmp    80106ef7 <alltraps>

80107db2 <vector237>:
.globl vector237
vector237:
  pushl $0
80107db2:	6a 00                	push   $0x0
  pushl $237
80107db4:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107db9:	e9 39 f1 ff ff       	jmp    80106ef7 <alltraps>

80107dbe <vector238>:
.globl vector238
vector238:
  pushl $0
80107dbe:	6a 00                	push   $0x0
  pushl $238
80107dc0:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107dc5:	e9 2d f1 ff ff       	jmp    80106ef7 <alltraps>

80107dca <vector239>:
.globl vector239
vector239:
  pushl $0
80107dca:	6a 00                	push   $0x0
  pushl $239
80107dcc:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107dd1:	e9 21 f1 ff ff       	jmp    80106ef7 <alltraps>

80107dd6 <vector240>:
.globl vector240
vector240:
  pushl $0
80107dd6:	6a 00                	push   $0x0
  pushl $240
80107dd8:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107ddd:	e9 15 f1 ff ff       	jmp    80106ef7 <alltraps>

80107de2 <vector241>:
.globl vector241
vector241:
  pushl $0
80107de2:	6a 00                	push   $0x0
  pushl $241
80107de4:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107de9:	e9 09 f1 ff ff       	jmp    80106ef7 <alltraps>

80107dee <vector242>:
.globl vector242
vector242:
  pushl $0
80107dee:	6a 00                	push   $0x0
  pushl $242
80107df0:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107df5:	e9 fd f0 ff ff       	jmp    80106ef7 <alltraps>

80107dfa <vector243>:
.globl vector243
vector243:
  pushl $0
80107dfa:	6a 00                	push   $0x0
  pushl $243
80107dfc:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107e01:	e9 f1 f0 ff ff       	jmp    80106ef7 <alltraps>

80107e06 <vector244>:
.globl vector244
vector244:
  pushl $0
80107e06:	6a 00                	push   $0x0
  pushl $244
80107e08:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107e0d:	e9 e5 f0 ff ff       	jmp    80106ef7 <alltraps>

80107e12 <vector245>:
.globl vector245
vector245:
  pushl $0
80107e12:	6a 00                	push   $0x0
  pushl $245
80107e14:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107e19:	e9 d9 f0 ff ff       	jmp    80106ef7 <alltraps>

80107e1e <vector246>:
.globl vector246
vector246:
  pushl $0
80107e1e:	6a 00                	push   $0x0
  pushl $246
80107e20:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107e25:	e9 cd f0 ff ff       	jmp    80106ef7 <alltraps>

80107e2a <vector247>:
.globl vector247
vector247:
  pushl $0
80107e2a:	6a 00                	push   $0x0
  pushl $247
80107e2c:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107e31:	e9 c1 f0 ff ff       	jmp    80106ef7 <alltraps>

80107e36 <vector248>:
.globl vector248
vector248:
  pushl $0
80107e36:	6a 00                	push   $0x0
  pushl $248
80107e38:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107e3d:	e9 b5 f0 ff ff       	jmp    80106ef7 <alltraps>

80107e42 <vector249>:
.globl vector249
vector249:
  pushl $0
80107e42:	6a 00                	push   $0x0
  pushl $249
80107e44:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107e49:	e9 a9 f0 ff ff       	jmp    80106ef7 <alltraps>

80107e4e <vector250>:
.globl vector250
vector250:
  pushl $0
80107e4e:	6a 00                	push   $0x0
  pushl $250
80107e50:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107e55:	e9 9d f0 ff ff       	jmp    80106ef7 <alltraps>

80107e5a <vector251>:
.globl vector251
vector251:
  pushl $0
80107e5a:	6a 00                	push   $0x0
  pushl $251
80107e5c:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107e61:	e9 91 f0 ff ff       	jmp    80106ef7 <alltraps>

80107e66 <vector252>:
.globl vector252
vector252:
  pushl $0
80107e66:	6a 00                	push   $0x0
  pushl $252
80107e68:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107e6d:	e9 85 f0 ff ff       	jmp    80106ef7 <alltraps>

80107e72 <vector253>:
.globl vector253
vector253:
  pushl $0
80107e72:	6a 00                	push   $0x0
  pushl $253
80107e74:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107e79:	e9 79 f0 ff ff       	jmp    80106ef7 <alltraps>

80107e7e <vector254>:
.globl vector254
vector254:
  pushl $0
80107e7e:	6a 00                	push   $0x0
  pushl $254
80107e80:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107e85:	e9 6d f0 ff ff       	jmp    80106ef7 <alltraps>

80107e8a <vector255>:
.globl vector255
vector255:
  pushl $0
80107e8a:	6a 00                	push   $0x0
  pushl $255
80107e8c:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107e91:	e9 61 f0 ff ff       	jmp    80106ef7 <alltraps>
80107e96:	66 90                	xchg   %ax,%ax
80107e98:	66 90                	xchg   %ax,%ax
80107e9a:	66 90                	xchg   %ax,%ax
80107e9c:	66 90                	xchg   %ax,%ax
80107e9e:	66 90                	xchg   %ax,%ax

80107ea0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107ea0:	55                   	push   %ebp
80107ea1:	89 e5                	mov    %esp,%ebp
80107ea3:	83 ec 28             	sub    $0x28,%esp
80107ea6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107ea9:	89 d3                	mov    %edx,%ebx
80107eab:	c1 eb 16             	shr    $0x16,%ebx
{
80107eae:	89 75 f8             	mov    %esi,-0x8(%ebp)
  pde = &pgdir[PDX(va)];
80107eb1:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80107eb4:	89 7d fc             	mov    %edi,-0x4(%ebp)
80107eb7:	89 d7                	mov    %edx,%edi
  if(*pde & PTE_P){
80107eb9:	8b 06                	mov    (%esi),%eax
80107ebb:	a8 01                	test   $0x1,%al
80107ebd:	74 29                	je     80107ee8 <walkpgdir+0x48>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107ebf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107ec4:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107eca:	c1 ef 0a             	shr    $0xa,%edi
}
80107ecd:	8b 75 f8             	mov    -0x8(%ebp),%esi
  return &pgtab[PTX(va)];
80107ed0:	89 fa                	mov    %edi,%edx
}
80107ed2:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return &pgtab[PTX(va)];
80107ed5:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107edb:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80107ede:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107ee1:	89 ec                	mov    %ebp,%esp
80107ee3:	5d                   	pop    %ebp
80107ee4:	c3                   	ret    
80107ee5:	8d 76 00             	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107ee8:	85 c9                	test   %ecx,%ecx
80107eea:	74 34                	je     80107f20 <walkpgdir+0x80>
80107eec:	e8 bf a6 ff ff       	call   801025b0 <kalloc>
80107ef1:	85 c0                	test   %eax,%eax
80107ef3:	89 c3                	mov    %eax,%ebx
80107ef5:	74 29                	je     80107f20 <walkpgdir+0x80>
    memset(pgtab, 0, PGSIZE);
80107ef7:	b8 00 10 00 00       	mov    $0x1000,%eax
80107efc:	31 d2                	xor    %edx,%edx
80107efe:	89 44 24 08          	mov    %eax,0x8(%esp)
80107f02:	89 54 24 04          	mov    %edx,0x4(%esp)
80107f06:	89 1c 24             	mov    %ebx,(%esp)
80107f09:	e8 d2 dc ff ff       	call   80105be0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107f0e:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107f14:	83 c8 07             	or     $0x7,%eax
80107f17:	89 06                	mov    %eax,(%esi)
80107f19:	eb af                	jmp    80107eca <walkpgdir+0x2a>
80107f1b:	90                   	nop
80107f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80107f20:	8b 5d f4             	mov    -0xc(%ebp),%ebx
      return 0;
80107f23:	31 c0                	xor    %eax,%eax
}
80107f25:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107f28:	8b 7d fc             	mov    -0x4(%ebp),%edi
80107f2b:	89 ec                	mov    %ebp,%esp
80107f2d:	5d                   	pop    %ebp
80107f2e:	c3                   	ret    
80107f2f:	90                   	nop

80107f30 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107f30:	55                   	push   %ebp
80107f31:	89 e5                	mov    %esp,%ebp
80107f33:	57                   	push   %edi
80107f34:	56                   	push   %esi
80107f35:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107f36:	89 d3                	mov    %edx,%ebx
{
80107f38:	83 ec 2c             	sub    $0x2c,%esp
  a = (char*)PGROUNDDOWN((uint)va);
80107f3b:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80107f41:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107f44:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107f48:	8b 7d 08             	mov    0x8(%ebp),%edi
80107f4b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107f50:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80107f53:	8b 45 0c             	mov    0xc(%ebp),%eax
80107f56:	29 df                	sub    %ebx,%edi
80107f58:	83 c8 01             	or     $0x1,%eax
80107f5b:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107f5e:	eb 17                	jmp    80107f77 <mappages+0x47>
    if(*pte & PTE_P)
80107f60:	f6 00 01             	testb  $0x1,(%eax)
80107f63:	75 45                	jne    80107faa <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80107f65:	8b 55 dc             	mov    -0x24(%ebp),%edx
80107f68:	09 d6                	or     %edx,%esi
    if(a == last)
80107f6a:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
80107f6d:	89 30                	mov    %esi,(%eax)
    if(a == last)
80107f6f:	74 2f                	je     80107fa0 <mappages+0x70>
      break;
    a += PGSIZE;
80107f71:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107f77:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107f7a:	b9 01 00 00 00       	mov    $0x1,%ecx
80107f7f:	89 da                	mov    %ebx,%edx
80107f81:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107f84:	e8 17 ff ff ff       	call   80107ea0 <walkpgdir>
80107f89:	85 c0                	test   %eax,%eax
80107f8b:	75 d3                	jne    80107f60 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80107f8d:	83 c4 2c             	add    $0x2c,%esp
      return -1;
80107f90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107f95:	5b                   	pop    %ebx
80107f96:	5e                   	pop    %esi
80107f97:	5f                   	pop    %edi
80107f98:	5d                   	pop    %ebp
80107f99:	c3                   	ret    
80107f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107fa0:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80107fa3:	31 c0                	xor    %eax,%eax
}
80107fa5:	5b                   	pop    %ebx
80107fa6:	5e                   	pop    %esi
80107fa7:	5f                   	pop    %edi
80107fa8:	5d                   	pop    %ebp
80107fa9:	c3                   	ret    
      panic("remap");
80107faa:	c7 04 24 58 91 10 80 	movl   $0x80109158,(%esp)
80107fb1:	e8 ba 83 ff ff       	call   80100370 <panic>
80107fb6:	8d 76 00             	lea    0x0(%esi),%esi
80107fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107fc0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107fc0:	55                   	push   %ebp
80107fc1:	89 e5                	mov    %esp,%ebp
80107fc3:	57                   	push   %edi
80107fc4:	89 c7                	mov    %eax,%edi
80107fc6:	56                   	push   %esi
80107fc7:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107fc8:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107fce:	83 ec 2c             	sub    $0x2c,%esp
  a = PGROUNDUP(newsz);
80107fd1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107fd7:	39 d3                	cmp    %edx,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107fd9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107fdc:	73 62                	jae    80108040 <deallocuvm.part.0+0x80>
80107fde:	89 d6                	mov    %edx,%esi
80107fe0:	eb 39                	jmp    8010801b <deallocuvm.part.0+0x5b>
80107fe2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80107fe8:	8b 10                	mov    (%eax),%edx
80107fea:	f6 c2 01             	test   $0x1,%dl
80107fed:	74 22                	je     80108011 <deallocuvm.part.0+0x51>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80107fef:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107ff5:	74 54                	je     8010804b <deallocuvm.part.0+0x8b>
        panic("kfree");
      char *v = P2V(pa);
80107ff7:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
80107ffd:	89 14 24             	mov    %edx,(%esp)
80108000:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108003:	e8 d8 a3 ff ff       	call   801023e0 <kfree>
      *pte = 0;
80108008:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010800b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80108011:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80108017:	39 f3                	cmp    %esi,%ebx
80108019:	73 25                	jae    80108040 <deallocuvm.part.0+0x80>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010801b:	31 c9                	xor    %ecx,%ecx
8010801d:	89 da                	mov    %ebx,%edx
8010801f:	89 f8                	mov    %edi,%eax
80108021:	e8 7a fe ff ff       	call   80107ea0 <walkpgdir>
    if(!pte)
80108026:	85 c0                	test   %eax,%eax
80108028:	75 be                	jne    80107fe8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010802a:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80108030:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80108036:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010803c:	39 f3                	cmp    %esi,%ebx
8010803e:	72 db                	jb     8010801b <deallocuvm.part.0+0x5b>
    }
  }
  return newsz;
}
80108040:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108043:	83 c4 2c             	add    $0x2c,%esp
80108046:	5b                   	pop    %ebx
80108047:	5e                   	pop    %esi
80108048:	5f                   	pop    %edi
80108049:	5d                   	pop    %ebp
8010804a:	c3                   	ret    
        panic("kfree");
8010804b:	c7 04 24 66 8a 10 80 	movl   $0x80108a66,(%esp)
80108052:	e8 19 83 ff ff       	call   80100370 <panic>
80108057:	89 f6                	mov    %esi,%esi
80108059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108060 <seginit>:
{
80108060:	55                   	push   %ebp
80108061:	89 e5                	mov    %esp,%ebp
80108063:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80108066:	e8 15 b9 ff ff       	call   80103980 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010806b:	b9 00 9a cf 00       	mov    $0xcf9a00,%ecx
  pd[0] = size-1;
80108070:	66 c7 45 f2 2f 00    	movw   $0x2f,-0xe(%ebp)
80108076:	8d 14 80             	lea    (%eax,%eax,4),%edx
80108079:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010807c:	ba ff ff 00 00       	mov    $0xffff,%edx
80108081:	c1 e0 04             	shl    $0x4,%eax
80108084:	89 90 78 48 11 80    	mov    %edx,-0x7feeb788(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010808a:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010808f:	89 88 7c 48 11 80    	mov    %ecx,-0x7feeb784(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80108095:	b9 00 92 cf 00       	mov    $0xcf9200,%ecx
8010809a:	89 90 80 48 11 80    	mov    %edx,-0x7feeb780(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801080a0:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801080a5:	89 88 84 48 11 80    	mov    %ecx,-0x7feeb77c(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801080ab:	b9 00 fa cf 00       	mov    $0xcffa00,%ecx
801080b0:	89 90 88 48 11 80    	mov    %edx,-0x7feeb778(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801080b6:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801080bb:	89 88 8c 48 11 80    	mov    %ecx,-0x7feeb774(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801080c1:	b9 00 f2 cf 00       	mov    $0xcff200,%ecx
801080c6:	89 90 90 48 11 80    	mov    %edx,-0x7feeb770(%eax)
801080cc:	89 88 94 48 11 80    	mov    %ecx,-0x7feeb76c(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
801080d2:	05 70 48 11 80       	add    $0x80114870,%eax
  pd[1] = (uint)p;
801080d7:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
801080da:	c1 e8 10             	shr    $0x10,%eax
  pd[1] = (uint)p;
801080dd:	66 89 55 f4          	mov    %dx,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801080e1:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801080e5:	8d 45 f2             	lea    -0xe(%ebp),%eax
801080e8:	0f 01 10             	lgdtl  (%eax)
}
801080eb:	c9                   	leave  
801080ec:	c3                   	ret    
801080ed:	8d 76 00             	lea    0x0(%esi),%esi

801080f0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801080f0:	a1 24 7c 11 80       	mov    0x80117c24,%eax
{
801080f5:	55                   	push   %ebp
801080f6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801080f8:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801080fd:	0f 22 d8             	mov    %eax,%cr3
}
80108100:	5d                   	pop    %ebp
80108101:	c3                   	ret    
80108102:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108110 <switchuvm>:
{
80108110:	55                   	push   %ebp
80108111:	89 e5                	mov    %esp,%ebp
80108113:	57                   	push   %edi
80108114:	56                   	push   %esi
80108115:	53                   	push   %ebx
80108116:	83 ec 2c             	sub    $0x2c,%esp
80108119:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
8010811c:	85 db                	test   %ebx,%ebx
8010811e:	0f 84 c5 00 00 00    	je     801081e9 <switchuvm+0xd9>
  if(p->kstack == 0)
80108124:	8b 7b 08             	mov    0x8(%ebx),%edi
80108127:	85 ff                	test   %edi,%edi
80108129:	0f 84 d2 00 00 00    	je     80108201 <switchuvm+0xf1>
  if(p->pgdir == 0)
8010812f:	8b 73 04             	mov    0x4(%ebx),%esi
80108132:	85 f6                	test   %esi,%esi
80108134:	0f 84 bb 00 00 00    	je     801081f5 <switchuvm+0xe5>
  pushcli();
8010813a:	e8 d1 d8 ff ff       	call   80105a10 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010813f:	e8 bc b7 ff ff       	call   80103900 <mycpu>
80108144:	89 c6                	mov    %eax,%esi
80108146:	e8 b5 b7 ff ff       	call   80103900 <mycpu>
8010814b:	89 c7                	mov    %eax,%edi
8010814d:	e8 ae b7 ff ff       	call   80103900 <mycpu>
80108152:	83 c7 08             	add    $0x8,%edi
80108155:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108158:	e8 a3 b7 ff ff       	call   80103900 <mycpu>
8010815d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80108160:	ba 67 00 00 00       	mov    $0x67,%edx
80108165:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
8010816c:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80108173:	83 c1 08             	add    $0x8,%ecx
80108176:	c1 e9 10             	shr    $0x10,%ecx
80108179:	83 c0 08             	add    $0x8,%eax
8010817c:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80108182:	c1 e8 18             	shr    $0x18,%eax
80108185:	b9 99 40 00 00       	mov    $0x4099,%ecx
8010818a:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
80108191:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->gdt[SEG_TSS].s = 0;
80108197:	e8 64 b7 ff ff       	call   80103900 <mycpu>
8010819c:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801081a3:	e8 58 b7 ff ff       	call   80103900 <mycpu>
801081a8:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801081ae:	8b 73 08             	mov    0x8(%ebx),%esi
801081b1:	e8 4a b7 ff ff       	call   80103900 <mycpu>
801081b6:	81 c6 00 10 00 00    	add    $0x1000,%esi
801081bc:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801081bf:	e8 3c b7 ff ff       	call   80103900 <mycpu>
801081c4:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801081ca:	b8 28 00 00 00       	mov    $0x28,%eax
801081cf:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801081d2:	8b 43 04             	mov    0x4(%ebx),%eax
801081d5:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801081da:	0f 22 d8             	mov    %eax,%cr3
}
801081dd:	83 c4 2c             	add    $0x2c,%esp
801081e0:	5b                   	pop    %ebx
801081e1:	5e                   	pop    %esi
801081e2:	5f                   	pop    %edi
801081e3:	5d                   	pop    %ebp
  popcli();
801081e4:	e9 67 d8 ff ff       	jmp    80105a50 <popcli>
    panic("switchuvm: no process");
801081e9:	c7 04 24 5e 91 10 80 	movl   $0x8010915e,(%esp)
801081f0:	e8 7b 81 ff ff       	call   80100370 <panic>
    panic("switchuvm: no pgdir");
801081f5:	c7 04 24 89 91 10 80 	movl   $0x80109189,(%esp)
801081fc:	e8 6f 81 ff ff       	call   80100370 <panic>
    panic("switchuvm: no kstack");
80108201:	c7 04 24 74 91 10 80 	movl   $0x80109174,(%esp)
80108208:	e8 63 81 ff ff       	call   80100370 <panic>
8010820d:	8d 76 00             	lea    0x0(%esi),%esi

80108210 <inituvm>:
{
80108210:	55                   	push   %ebp
80108211:	89 e5                	mov    %esp,%ebp
80108213:	83 ec 38             	sub    $0x38,%esp
80108216:	89 75 f8             	mov    %esi,-0x8(%ebp)
80108219:	8b 75 10             	mov    0x10(%ebp),%esi
8010821c:	8b 45 08             	mov    0x8(%ebp),%eax
8010821f:	89 7d fc             	mov    %edi,-0x4(%ebp)
80108222:	8b 7d 0c             	mov    0xc(%ebp),%edi
80108225:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  if(sz >= PGSIZE)
80108228:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
8010822e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80108231:	77 59                	ja     8010828c <inituvm+0x7c>
  mem = kalloc();
80108233:	e8 78 a3 ff ff       	call   801025b0 <kalloc>
  memset(mem, 0, PGSIZE);
80108238:	31 d2                	xor    %edx,%edx
8010823a:	89 54 24 04          	mov    %edx,0x4(%esp)
  mem = kalloc();
8010823e:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80108240:	b8 00 10 00 00       	mov    $0x1000,%eax
80108245:	89 1c 24             	mov    %ebx,(%esp)
80108248:	89 44 24 08          	mov    %eax,0x8(%esp)
8010824c:	e8 8f d9 ff ff       	call   80105be0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80108251:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80108257:	b9 06 00 00 00       	mov    $0x6,%ecx
8010825c:	89 04 24             	mov    %eax,(%esp)
8010825f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108262:	31 d2                	xor    %edx,%edx
80108264:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80108268:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010826d:	e8 be fc ff ff       	call   80107f30 <mappages>
  memmove(mem, init, sz);
80108272:	89 75 10             	mov    %esi,0x10(%ebp)
}
80108275:	8b 75 f8             	mov    -0x8(%ebp),%esi
  memmove(mem, init, sz);
80108278:	89 7d 0c             	mov    %edi,0xc(%ebp)
}
8010827b:	8b 7d fc             	mov    -0x4(%ebp),%edi
  memmove(mem, init, sz);
8010827e:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80108281:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80108284:	89 ec                	mov    %ebp,%esp
80108286:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80108287:	e9 14 da ff ff       	jmp    80105ca0 <memmove>
    panic("inituvm: more than a page");
8010828c:	c7 04 24 9d 91 10 80 	movl   $0x8010919d,(%esp)
80108293:	e8 d8 80 ff ff       	call   80100370 <panic>
80108298:	90                   	nop
80108299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801082a0 <loaduvm>:
{
801082a0:	55                   	push   %ebp
801082a1:	89 e5                	mov    %esp,%ebp
801082a3:	57                   	push   %edi
801082a4:	56                   	push   %esi
801082a5:	53                   	push   %ebx
801082a6:	83 ec 1c             	sub    $0x1c,%esp
  if((uint) addr % PGSIZE != 0)
801082a9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
801082b0:	0f 85 98 00 00 00    	jne    8010834e <loaduvm+0xae>
  for(i = 0; i < sz; i += PGSIZE){
801082b6:	8b 75 18             	mov    0x18(%ebp),%esi
801082b9:	31 db                	xor    %ebx,%ebx
801082bb:	85 f6                	test   %esi,%esi
801082bd:	75 1a                	jne    801082d9 <loaduvm+0x39>
801082bf:	eb 77                	jmp    80108338 <loaduvm+0x98>
801082c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801082c8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801082ce:	81 ee 00 10 00 00    	sub    $0x1000,%esi
801082d4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
801082d7:	76 5f                	jbe    80108338 <loaduvm+0x98>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801082d9:	8b 55 0c             	mov    0xc(%ebp),%edx
801082dc:	31 c9                	xor    %ecx,%ecx
801082de:	8b 45 08             	mov    0x8(%ebp),%eax
801082e1:	01 da                	add    %ebx,%edx
801082e3:	e8 b8 fb ff ff       	call   80107ea0 <walkpgdir>
801082e8:	85 c0                	test   %eax,%eax
801082ea:	74 56                	je     80108342 <loaduvm+0xa2>
    pa = PTE_ADDR(*pte);
801082ec:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
801082ee:	bf 00 10 00 00       	mov    $0x1000,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801082f3:	8b 4d 14             	mov    0x14(%ebp),%ecx
    pa = PTE_ADDR(*pte);
801082f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801082fb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80108301:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108304:	05 00 00 00 80       	add    $0x80000000,%eax
80108309:	89 44 24 04          	mov    %eax,0x4(%esp)
8010830d:	8b 45 10             	mov    0x10(%ebp),%eax
80108310:	01 d9                	add    %ebx,%ecx
80108312:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80108316:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010831a:	89 04 24             	mov    %eax,(%esp)
8010831d:	e8 ae 96 ff ff       	call   801019d0 <readi>
80108322:	39 f8                	cmp    %edi,%eax
80108324:	74 a2                	je     801082c8 <loaduvm+0x28>
}
80108326:	83 c4 1c             	add    $0x1c,%esp
      return -1;
80108329:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010832e:	5b                   	pop    %ebx
8010832f:	5e                   	pop    %esi
80108330:	5f                   	pop    %edi
80108331:	5d                   	pop    %ebp
80108332:	c3                   	ret    
80108333:	90                   	nop
80108334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108338:	83 c4 1c             	add    $0x1c,%esp
  return 0;
8010833b:	31 c0                	xor    %eax,%eax
}
8010833d:	5b                   	pop    %ebx
8010833e:	5e                   	pop    %esi
8010833f:	5f                   	pop    %edi
80108340:	5d                   	pop    %ebp
80108341:	c3                   	ret    
      panic("loaduvm: address should exist");
80108342:	c7 04 24 b7 91 10 80 	movl   $0x801091b7,(%esp)
80108349:	e8 22 80 ff ff       	call   80100370 <panic>
    panic("loaduvm: addr must be page aligned");
8010834e:	c7 04 24 58 92 10 80 	movl   $0x80109258,(%esp)
80108355:	e8 16 80 ff ff       	call   80100370 <panic>
8010835a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108360 <allocuvm>:
{
80108360:	55                   	push   %ebp
80108361:	89 e5                	mov    %esp,%ebp
80108363:	57                   	push   %edi
80108364:	56                   	push   %esi
80108365:	53                   	push   %ebx
80108366:	83 ec 2c             	sub    $0x2c,%esp
  if(newsz >= KERNBASE)
80108369:	8b 7d 10             	mov    0x10(%ebp),%edi
8010836c:	85 ff                	test   %edi,%edi
8010836e:	0f 88 91 00 00 00    	js     80108405 <allocuvm+0xa5>
  if(newsz < oldsz)
80108374:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80108377:	0f 82 9b 00 00 00    	jb     80108418 <allocuvm+0xb8>
  a = PGROUNDUP(oldsz);
8010837d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108380:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80108386:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010838c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010838f:	0f 86 86 00 00 00    	jbe    8010841b <allocuvm+0xbb>
80108395:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80108398:	8b 7d 08             	mov    0x8(%ebp),%edi
8010839b:	eb 49                	jmp    801083e6 <allocuvm+0x86>
8010839d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
801083a0:	31 d2                	xor    %edx,%edx
801083a2:	b8 00 10 00 00       	mov    $0x1000,%eax
801083a7:	89 54 24 04          	mov    %edx,0x4(%esp)
801083ab:	89 44 24 08          	mov    %eax,0x8(%esp)
801083af:	89 34 24             	mov    %esi,(%esp)
801083b2:	e8 29 d8 ff ff       	call   80105be0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801083b7:	b9 06 00 00 00       	mov    $0x6,%ecx
801083bc:	89 da                	mov    %ebx,%edx
801083be:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801083c4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801083c8:	b9 00 10 00 00       	mov    $0x1000,%ecx
801083cd:	89 04 24             	mov    %eax,(%esp)
801083d0:	89 f8                	mov    %edi,%eax
801083d2:	e8 59 fb ff ff       	call   80107f30 <mappages>
801083d7:	85 c0                	test   %eax,%eax
801083d9:	78 4d                	js     80108428 <allocuvm+0xc8>
  for(; a < newsz; a += PGSIZE){
801083db:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801083e1:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801083e4:	76 7a                	jbe    80108460 <allocuvm+0x100>
    mem = kalloc();
801083e6:	e8 c5 a1 ff ff       	call   801025b0 <kalloc>
    if(mem == 0){
801083eb:	85 c0                	test   %eax,%eax
    mem = kalloc();
801083ed:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801083ef:	75 af                	jne    801083a0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
801083f1:	c7 04 24 d5 91 10 80 	movl   $0x801091d5,(%esp)
801083f8:	e8 53 82 ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
801083fd:	8b 45 0c             	mov    0xc(%ebp),%eax
80108400:	39 45 10             	cmp    %eax,0x10(%ebp)
80108403:	77 6b                	ja     80108470 <allocuvm+0x110>
}
80108405:	83 c4 2c             	add    $0x2c,%esp
    return 0;
80108408:	31 ff                	xor    %edi,%edi
}
8010840a:	5b                   	pop    %ebx
8010840b:	89 f8                	mov    %edi,%eax
8010840d:	5e                   	pop    %esi
8010840e:	5f                   	pop    %edi
8010840f:	5d                   	pop    %ebp
80108410:	c3                   	ret    
80108411:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80108418:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
8010841b:	83 c4 2c             	add    $0x2c,%esp
8010841e:	89 f8                	mov    %edi,%eax
80108420:	5b                   	pop    %ebx
80108421:	5e                   	pop    %esi
80108422:	5f                   	pop    %edi
80108423:	5d                   	pop    %ebp
80108424:	c3                   	ret    
80108425:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80108428:	c7 04 24 ed 91 10 80 	movl   $0x801091ed,(%esp)
8010842f:	e8 1c 82 ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
80108434:	8b 45 0c             	mov    0xc(%ebp),%eax
80108437:	39 45 10             	cmp    %eax,0x10(%ebp)
8010843a:	76 0d                	jbe    80108449 <allocuvm+0xe9>
8010843c:	89 c1                	mov    %eax,%ecx
8010843e:	8b 55 10             	mov    0x10(%ebp),%edx
80108441:	8b 45 08             	mov    0x8(%ebp),%eax
80108444:	e8 77 fb ff ff       	call   80107fc0 <deallocuvm.part.0>
      kfree(mem);
80108449:	89 34 24             	mov    %esi,(%esp)
      return 0;
8010844c:	31 ff                	xor    %edi,%edi
      kfree(mem);
8010844e:	e8 8d 9f ff ff       	call   801023e0 <kfree>
}
80108453:	83 c4 2c             	add    $0x2c,%esp
80108456:	89 f8                	mov    %edi,%eax
80108458:	5b                   	pop    %ebx
80108459:	5e                   	pop    %esi
8010845a:	5f                   	pop    %edi
8010845b:	5d                   	pop    %ebp
8010845c:	c3                   	ret    
8010845d:	8d 76 00             	lea    0x0(%esi),%esi
80108460:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80108463:	83 c4 2c             	add    $0x2c,%esp
80108466:	5b                   	pop    %ebx
80108467:	5e                   	pop    %esi
80108468:	89 f8                	mov    %edi,%eax
8010846a:	5f                   	pop    %edi
8010846b:	5d                   	pop    %ebp
8010846c:	c3                   	ret    
8010846d:	8d 76 00             	lea    0x0(%esi),%esi
80108470:	89 c1                	mov    %eax,%ecx
80108472:	8b 55 10             	mov    0x10(%ebp),%edx
      return 0;
80108475:	31 ff                	xor    %edi,%edi
80108477:	8b 45 08             	mov    0x8(%ebp),%eax
8010847a:	e8 41 fb ff ff       	call   80107fc0 <deallocuvm.part.0>
8010847f:	eb 9a                	jmp    8010841b <allocuvm+0xbb>
80108481:	eb 0d                	jmp    80108490 <deallocuvm>
80108483:	90                   	nop
80108484:	90                   	nop
80108485:	90                   	nop
80108486:	90                   	nop
80108487:	90                   	nop
80108488:	90                   	nop
80108489:	90                   	nop
8010848a:	90                   	nop
8010848b:	90                   	nop
8010848c:	90                   	nop
8010848d:	90                   	nop
8010848e:	90                   	nop
8010848f:	90                   	nop

80108490 <deallocuvm>:
{
80108490:	55                   	push   %ebp
80108491:	89 e5                	mov    %esp,%ebp
80108493:	8b 55 0c             	mov    0xc(%ebp),%edx
80108496:	8b 4d 10             	mov    0x10(%ebp),%ecx
80108499:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010849c:	39 d1                	cmp    %edx,%ecx
8010849e:	73 10                	jae    801084b0 <deallocuvm+0x20>
}
801084a0:	5d                   	pop    %ebp
801084a1:	e9 1a fb ff ff       	jmp    80107fc0 <deallocuvm.part.0>
801084a6:	8d 76 00             	lea    0x0(%esi),%esi
801084a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801084b0:	89 d0                	mov    %edx,%eax
801084b2:	5d                   	pop    %ebp
801084b3:	c3                   	ret    
801084b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801084ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801084c0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801084c0:	55                   	push   %ebp
801084c1:	89 e5                	mov    %esp,%ebp
801084c3:	57                   	push   %edi
801084c4:	56                   	push   %esi
801084c5:	53                   	push   %ebx
801084c6:	83 ec 1c             	sub    $0x1c,%esp
801084c9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801084cc:	85 f6                	test   %esi,%esi
801084ce:	74 55                	je     80108525 <freevm+0x65>
801084d0:	31 c9                	xor    %ecx,%ecx
801084d2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801084d7:	89 f0                	mov    %esi,%eax
801084d9:	89 f3                	mov    %esi,%ebx
801084db:	e8 e0 fa ff ff       	call   80107fc0 <deallocuvm.part.0>
801084e0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801084e6:	eb 0f                	jmp    801084f7 <freevm+0x37>
801084e8:	90                   	nop
801084e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801084f0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801084f3:	39 fb                	cmp    %edi,%ebx
801084f5:	74 1f                	je     80108516 <freevm+0x56>
    if(pgdir[i] & PTE_P){
801084f7:	8b 03                	mov    (%ebx),%eax
801084f9:	a8 01                	test   $0x1,%al
801084fb:	74 f3                	je     801084f0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801084fd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108502:	83 c3 04             	add    $0x4,%ebx
80108505:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010850a:	89 04 24             	mov    %eax,(%esp)
8010850d:	e8 ce 9e ff ff       	call   801023e0 <kfree>
  for(i = 0; i < NPDENTRIES; i++){
80108512:	39 fb                	cmp    %edi,%ebx
80108514:	75 e1                	jne    801084f7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80108516:	89 75 08             	mov    %esi,0x8(%ebp)
}
80108519:	83 c4 1c             	add    $0x1c,%esp
8010851c:	5b                   	pop    %ebx
8010851d:	5e                   	pop    %esi
8010851e:	5f                   	pop    %edi
8010851f:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80108520:	e9 bb 9e ff ff       	jmp    801023e0 <kfree>
    panic("freevm: no pgdir");
80108525:	c7 04 24 09 92 10 80 	movl   $0x80109209,(%esp)
8010852c:	e8 3f 7e ff ff       	call   80100370 <panic>
80108531:	eb 0d                	jmp    80108540 <setupkvm>
80108533:	90                   	nop
80108534:	90                   	nop
80108535:	90                   	nop
80108536:	90                   	nop
80108537:	90                   	nop
80108538:	90                   	nop
80108539:	90                   	nop
8010853a:	90                   	nop
8010853b:	90                   	nop
8010853c:	90                   	nop
8010853d:	90                   	nop
8010853e:	90                   	nop
8010853f:	90                   	nop

80108540 <setupkvm>:
{
80108540:	55                   	push   %ebp
80108541:	89 e5                	mov    %esp,%ebp
80108543:	56                   	push   %esi
80108544:	53                   	push   %ebx
80108545:	83 ec 10             	sub    $0x10,%esp
  if((pgdir = (pde_t*)kalloc()) == 0)
80108548:	e8 63 a0 ff ff       	call   801025b0 <kalloc>
8010854d:	85 c0                	test   %eax,%eax
8010854f:	89 c6                	mov    %eax,%esi
80108551:	74 46                	je     80108599 <setupkvm+0x59>
  memset(pgdir, 0, PGSIZE);
80108553:	b8 00 10 00 00       	mov    $0x1000,%eax
80108558:	31 d2                	xor    %edx,%edx
8010855a:	89 44 24 08          	mov    %eax,0x8(%esp)
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010855e:	bb 20 c4 10 80       	mov    $0x8010c420,%ebx
  memset(pgdir, 0, PGSIZE);
80108563:	89 54 24 04          	mov    %edx,0x4(%esp)
80108567:	89 34 24             	mov    %esi,(%esp)
8010856a:	e8 71 d6 ff ff       	call   80105be0 <memset>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010856f:	8b 53 0c             	mov    0xc(%ebx),%edx
                (uint)k->phys_start, k->perm) < 0) {
80108572:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80108575:	8b 4b 08             	mov    0x8(%ebx),%ecx
80108578:	89 54 24 04          	mov    %edx,0x4(%esp)
8010857c:	8b 13                	mov    (%ebx),%edx
8010857e:	89 04 24             	mov    %eax,(%esp)
80108581:	29 c1                	sub    %eax,%ecx
80108583:	89 f0                	mov    %esi,%eax
80108585:	e8 a6 f9 ff ff       	call   80107f30 <mappages>
8010858a:	85 c0                	test   %eax,%eax
8010858c:	78 1a                	js     801085a8 <setupkvm+0x68>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010858e:	83 c3 10             	add    $0x10,%ebx
80108591:	81 fb 60 c4 10 80    	cmp    $0x8010c460,%ebx
80108597:	75 d6                	jne    8010856f <setupkvm+0x2f>
}
80108599:	83 c4 10             	add    $0x10,%esp
8010859c:	89 f0                	mov    %esi,%eax
8010859e:	5b                   	pop    %ebx
8010859f:	5e                   	pop    %esi
801085a0:	5d                   	pop    %ebp
801085a1:	c3                   	ret    
801085a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      freevm(pgdir);
801085a8:	89 34 24             	mov    %esi,(%esp)
      return 0;
801085ab:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
801085ad:	e8 0e ff ff ff       	call   801084c0 <freevm>
}
801085b2:	83 c4 10             	add    $0x10,%esp
801085b5:	89 f0                	mov    %esi,%eax
801085b7:	5b                   	pop    %ebx
801085b8:	5e                   	pop    %esi
801085b9:	5d                   	pop    %ebp
801085ba:	c3                   	ret    
801085bb:	90                   	nop
801085bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801085c0 <kvmalloc>:
{
801085c0:	55                   	push   %ebp
801085c1:	89 e5                	mov    %esp,%ebp
801085c3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801085c6:	e8 75 ff ff ff       	call   80108540 <setupkvm>
801085cb:	a3 24 7c 11 80       	mov    %eax,0x80117c24
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801085d0:	05 00 00 00 80       	add    $0x80000000,%eax
801085d5:	0f 22 d8             	mov    %eax,%cr3
}
801085d8:	c9                   	leave  
801085d9:	c3                   	ret    
801085da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801085e0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801085e0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801085e1:	31 c9                	xor    %ecx,%ecx
{
801085e3:	89 e5                	mov    %esp,%ebp
801085e5:	83 ec 18             	sub    $0x18,%esp
  pte = walkpgdir(pgdir, uva, 0);
801085e8:	8b 55 0c             	mov    0xc(%ebp),%edx
801085eb:	8b 45 08             	mov    0x8(%ebp),%eax
801085ee:	e8 ad f8 ff ff       	call   80107ea0 <walkpgdir>
  if(pte == 0)
801085f3:	85 c0                	test   %eax,%eax
801085f5:	74 05                	je     801085fc <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
801085f7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801085fa:	c9                   	leave  
801085fb:	c3                   	ret    
    panic("clearpteu");
801085fc:	c7 04 24 1a 92 10 80 	movl   $0x8010921a,(%esp)
80108603:	e8 68 7d ff ff       	call   80100370 <panic>
80108608:	90                   	nop
80108609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108610 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108610:	55                   	push   %ebp
80108611:	89 e5                	mov    %esp,%ebp
80108613:	57                   	push   %edi
80108614:	56                   	push   %esi
80108615:	53                   	push   %ebx
80108616:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80108619:	e8 22 ff ff ff       	call   80108540 <setupkvm>
8010861e:	85 c0                	test   %eax,%eax
80108620:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108623:	0f 84 a3 00 00 00    	je     801086cc <copyuvm+0xbc>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108629:	8b 55 0c             	mov    0xc(%ebp),%edx
8010862c:	85 d2                	test   %edx,%edx
8010862e:	0f 84 98 00 00 00    	je     801086cc <copyuvm+0xbc>
80108634:	31 ff                	xor    %edi,%edi
80108636:	eb 50                	jmp    80108688 <copyuvm+0x78>
80108638:	90                   	nop
80108639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80108640:	b8 00 10 00 00       	mov    $0x1000,%eax
80108645:	89 44 24 08          	mov    %eax,0x8(%esp)
80108649:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010864c:	89 34 24             	mov    %esi,(%esp)
8010864f:	05 00 00 00 80       	add    $0x80000000,%eax
80108654:	89 44 24 04          	mov    %eax,0x4(%esp)
80108658:	e8 43 d6 ff ff       	call   80105ca0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
8010865d:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80108663:	b9 00 10 00 00       	mov    $0x1000,%ecx
80108668:	89 04 24             	mov    %eax,(%esp)
8010866b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010866e:	89 fa                	mov    %edi,%edx
80108670:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80108674:	e8 b7 f8 ff ff       	call   80107f30 <mappages>
80108679:	85 c0                	test   %eax,%eax
8010867b:	78 63                	js     801086e0 <copyuvm+0xd0>
  for(i = 0; i < sz; i += PGSIZE){
8010867d:	81 c7 00 10 00 00    	add    $0x1000,%edi
80108683:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80108686:	76 44                	jbe    801086cc <copyuvm+0xbc>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80108688:	8b 45 08             	mov    0x8(%ebp),%eax
8010868b:	31 c9                	xor    %ecx,%ecx
8010868d:	89 fa                	mov    %edi,%edx
8010868f:	e8 0c f8 ff ff       	call   80107ea0 <walkpgdir>
80108694:	85 c0                	test   %eax,%eax
80108696:	74 5e                	je     801086f6 <copyuvm+0xe6>
    if(!(*pte & PTE_P))
80108698:	8b 18                	mov    (%eax),%ebx
8010869a:	f6 c3 01             	test   $0x1,%bl
8010869d:	74 4b                	je     801086ea <copyuvm+0xda>
    pa = PTE_ADDR(*pte);
8010869f:	89 d8                	mov    %ebx,%eax
    flags = PTE_FLAGS(*pte);
801086a1:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
801086a7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801086ac:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
801086af:	e8 fc 9e ff ff       	call   801025b0 <kalloc>
801086b4:	85 c0                	test   %eax,%eax
801086b6:	89 c6                	mov    %eax,%esi
801086b8:	75 86                	jne    80108640 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
801086ba:	8b 45 e0             	mov    -0x20(%ebp),%eax
801086bd:	89 04 24             	mov    %eax,(%esp)
801086c0:	e8 fb fd ff ff       	call   801084c0 <freevm>
  return 0;
801086c5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
801086cc:	8b 45 e0             	mov    -0x20(%ebp),%eax
801086cf:	83 c4 2c             	add    $0x2c,%esp
801086d2:	5b                   	pop    %ebx
801086d3:	5e                   	pop    %esi
801086d4:	5f                   	pop    %edi
801086d5:	5d                   	pop    %ebp
801086d6:	c3                   	ret    
801086d7:	89 f6                	mov    %esi,%esi
801086d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      kfree(mem);
801086e0:	89 34 24             	mov    %esi,(%esp)
801086e3:	e8 f8 9c ff ff       	call   801023e0 <kfree>
      goto bad;
801086e8:	eb d0                	jmp    801086ba <copyuvm+0xaa>
      panic("copyuvm: page not present");
801086ea:	c7 04 24 3e 92 10 80 	movl   $0x8010923e,(%esp)
801086f1:	e8 7a 7c ff ff       	call   80100370 <panic>
      panic("copyuvm: pte should exist");
801086f6:	c7 04 24 24 92 10 80 	movl   $0x80109224,(%esp)
801086fd:	e8 6e 7c ff ff       	call   80100370 <panic>
80108702:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108710 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108710:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108711:	31 c9                	xor    %ecx,%ecx
{
80108713:	89 e5                	mov    %esp,%ebp
80108715:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80108718:	8b 55 0c             	mov    0xc(%ebp),%edx
8010871b:	8b 45 08             	mov    0x8(%ebp),%eax
8010871e:	e8 7d f7 ff ff       	call   80107ea0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80108723:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80108725:	89 c2                	mov    %eax,%edx
80108727:	83 e2 05             	and    $0x5,%edx
8010872a:	83 fa 05             	cmp    $0x5,%edx
8010872d:	75 11                	jne    80108740 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
8010872f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108734:	05 00 00 00 80       	add    $0x80000000,%eax
}
80108739:	c9                   	leave  
8010873a:	c3                   	ret    
8010873b:	90                   	nop
8010873c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80108740:	31 c0                	xor    %eax,%eax
}
80108742:	c9                   	leave  
80108743:	c3                   	ret    
80108744:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010874a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80108750 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108750:	55                   	push   %ebp
80108751:	89 e5                	mov    %esp,%ebp
80108753:	57                   	push   %edi
80108754:	56                   	push   %esi
80108755:	53                   	push   %ebx
80108756:	83 ec 2c             	sub    $0x2c,%esp
80108759:	8b 75 14             	mov    0x14(%ebp),%esi
8010875c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
8010875f:	85 f6                	test   %esi,%esi
80108761:	74 75                	je     801087d8 <copyout+0x88>
80108763:	89 da                	mov    %ebx,%edx
80108765:	eb 3f                	jmp    801087a6 <copyout+0x56>
80108767:	89 f6                	mov    %esi,%esi
80108769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80108770:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80108773:	89 df                	mov    %ebx,%edi
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80108775:	8b 4d 10             	mov    0x10(%ebp),%ecx
    n = PGSIZE - (va - va0);
80108778:	29 d7                	sub    %edx,%edi
8010877a:	81 c7 00 10 00 00    	add    $0x1000,%edi
80108780:	39 f7                	cmp    %esi,%edi
80108782:	0f 47 fe             	cmova  %esi,%edi
    memmove(pa0 + (va - va0), buf, n);
80108785:	29 da                	sub    %ebx,%edx
80108787:	01 c2                	add    %eax,%edx
80108789:	89 14 24             	mov    %edx,(%esp)
8010878c:	89 7c 24 08          	mov    %edi,0x8(%esp)
80108790:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80108794:	e8 07 d5 ff ff       	call   80105ca0 <memmove>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
80108799:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    buf += n;
8010879f:	01 7d 10             	add    %edi,0x10(%ebp)
  while(len > 0){
801087a2:	29 fe                	sub    %edi,%esi
801087a4:	74 32                	je     801087d8 <copyout+0x88>
    pa0 = uva2ka(pgdir, (char*)va0);
801087a6:	8b 45 08             	mov    0x8(%ebp),%eax
    va0 = (uint)PGROUNDDOWN(va);
801087a9:	89 d3                	mov    %edx,%ebx
801087ab:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    pa0 = uva2ka(pgdir, (char*)va0);
801087b1:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    va0 = (uint)PGROUNDDOWN(va);
801087b5:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
801087b8:	89 04 24             	mov    %eax,(%esp)
801087bb:	e8 50 ff ff ff       	call   80108710 <uva2ka>
    if(pa0 == 0)
801087c0:	85 c0                	test   %eax,%eax
801087c2:	75 ac                	jne    80108770 <copyout+0x20>
  }
  return 0;
}
801087c4:	83 c4 2c             	add    $0x2c,%esp
      return -1;
801087c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801087cc:	5b                   	pop    %ebx
801087cd:	5e                   	pop    %esi
801087ce:	5f                   	pop    %edi
801087cf:	5d                   	pop    %ebp
801087d0:	c3                   	ret    
801087d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801087d8:	83 c4 2c             	add    $0x2c,%esp
  return 0;
801087db:	31 c0                	xor    %eax,%eax
}
801087dd:	5b                   	pop    %ebx
801087de:	5e                   	pop    %esi
801087df:	5f                   	pop    %edi
801087e0:	5d                   	pop    %ebp
801087e1:	c3                   	ret    
