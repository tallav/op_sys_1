
_schedulingTest4:     file format elf32-i386


Disassembly of section .text:

00000000 <executeTimes.part.0>:
        printf(1,"fork failed\n");
        return 0;
    }
}

void executeTimes(int timeToSleep,int numberOfLoops,char* debugString){
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	89 c7                	mov    %eax,%edi
   6:	56                   	push   %esi
   7:	89 d6                	mov    %edx,%esi
   9:	53                   	push   %ebx
            printf(1,debugString);
            printf(1," starting...\n");
        }

        sleep(1000);
        for(int i = 0;i < numberOfLoops;i++){
   a:	31 db                	xor    %ebx,%ebx
void executeTimes(int timeToSleep,int numberOfLoops,char* debugString){
   c:	83 ec 18             	sub    $0x18,%esp
        sleep(1000);
   f:	68 e8 03 00 00       	push   $0x3e8
  14:	e8 5f 0b 00 00       	call   b78 <sleep>
  19:	83 c4 10             	add    $0x10,%esp
        for(int i = 0;i < numberOfLoops;i++){
  1c:	39 f3                	cmp    %esi,%ebx
  1e:	7d 0f                	jge    2f <executeTimes.part.0+0x2f>
            sleep(timeToSleep);
  20:	83 ec 0c             	sub    $0xc,%esp
        for(int i = 0;i < numberOfLoops;i++){
  23:	43                   	inc    %ebx
            sleep(timeToSleep);
  24:	57                   	push   %edi
  25:	e8 4e 0b 00 00       	call   b78 <sleep>
        for(int i = 0;i < numberOfLoops;i++){
  2a:	83 c4 10             	add    $0x10,%esp
  2d:	eb ed                	jmp    1c <executeTimes.part.0+0x1c>
        if(DEBUG){
            printf(1,debugString);
            printf(1," ending...\n");
        }

        exit(0);
  2f:	83 ec 0c             	sub    $0xc,%esp
  32:	6a 00                	push   $0x0
  34:	e8 af 0a 00 00       	call   ae8 <exit>
  39:	66 90                	xchg   %ax,%ax
  3b:	66 90                	xchg   %ax,%ax
  3d:	66 90                	xchg   %ax,%ax
  3f:	90                   	nop

00000040 <main>:
int main(int argc, char *argv[]){  
  40:	55                   	push   %ebp
    printf(1,"Initiating scheduling test, test should take approximately 30000 time quantums !!!\n");
  41:	b8 44 11 00 00       	mov    $0x1144,%eax
int main(int argc, char *argv[]){  
  46:	89 e5                	mov    %esp,%ebp
  48:	57                   	push   %edi
    childPid3 = executeForever(0,"childPid3");
  49:	bf f5 0f 00 00       	mov    $0xff5,%edi
int main(int argc, char *argv[]){  
  4e:	56                   	push   %esi
    childPid2 = executeForever(0,"childPid2");
  4f:	be eb 0f 00 00       	mov    $0xfeb,%esi
int main(int argc, char *argv[]){  
  54:	53                   	push   %ebx
    childPid1 = executeForever(0,"childPid1");
  55:	bb e1 0f 00 00       	mov    $0xfe1,%ebx
int main(int argc, char *argv[]){  
  5a:	83 e4 f0             	and    $0xfffffff0,%esp
  5d:	83 ec 40             	sub    $0x40,%esp
    printf(1,"Initiating scheduling test, test should take approximately 30000 time quantums !!!\n");
  60:	89 44 24 04          	mov    %eax,0x4(%esp)
  64:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  6b:	e8 e0 0b 00 00       	call   c50 <printf>
    executeTestMonitor(5000,5,"TestMonitor");
  70:	b9 05 00 00 00       	mov    $0x5,%ecx
  75:	ba d5 0f 00 00       	mov    $0xfd5,%edx
  7a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  7e:	89 54 24 08          	mov    %edx,0x8(%esp)
  82:	c7 04 24 88 13 00 00 	movl   $0x1388,(%esp)
  89:	e8 72 07 00 00       	call   800 <executeTestMonitor>
    childPid1 = executeForever(0,"childPid1");
  8e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    childPid12 = executeForever(20000,"childPid12");
  92:	bb 51 10 00 00       	mov    $0x1051,%ebx
    childPid1 = executeForever(0,"childPid1");
  97:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  9e:	e8 2d 06 00 00       	call   6d0 <executeForever>
    childPid2 = executeForever(0,"childPid2");
  a3:	89 74 24 04          	mov    %esi,0x4(%esp)
    childPid13 = executeForever(4567,"childPid13");
  a7:	be 5c 10 00 00       	mov    $0x105c,%esi
    childPid2 = executeForever(0,"childPid2");
  ac:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    childPid1 = executeForever(0,"childPid1");
  b3:	89 44 24 10          	mov    %eax,0x10(%esp)
    childPid2 = executeForever(0,"childPid2");
  b7:	e8 14 06 00 00       	call   6d0 <executeForever>
    childPid3 = executeForever(0,"childPid3");
  bc:	89 7c 24 04          	mov    %edi,0x4(%esp)
  c0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    childPid2 = executeForever(0,"childPid2");
  c7:	89 44 24 3c          	mov    %eax,0x3c(%esp)
    childPid3 = executeForever(0,"childPid3");
  cb:	e8 00 06 00 00       	call   6d0 <executeForever>
    childPid4 = executeForever(0,"childPid4");
  d0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    childPid3 = executeForever(0,"childPid3");
  d7:	89 44 24 38          	mov    %eax,0x38(%esp)
    childPid4 = executeForever(0,"childPid4");
  db:	b8 ff 0f 00 00       	mov    $0xfff,%eax
  e0:	89 44 24 04          	mov    %eax,0x4(%esp)
  e4:	e8 e7 05 00 00       	call   6d0 <executeForever>
    childPid5 = executeForever(1000,"childPid5");
  e9:	c7 04 24 e8 03 00 00 	movl   $0x3e8,(%esp)
    childPid4 = executeForever(0,"childPid4");
  f0:	89 44 24 34          	mov    %eax,0x34(%esp)
    childPid5 = executeForever(1000,"childPid5");
  f4:	b8 09 10 00 00       	mov    $0x1009,%eax
  f9:	89 44 24 04          	mov    %eax,0x4(%esp)
  fd:	e8 ce 05 00 00       	call   6d0 <executeForever>
    childPid6 = executeForever(10000,"childPid6");
 102:	c7 04 24 10 27 00 00 	movl   $0x2710,(%esp)
    childPid5 = executeForever(1000,"childPid5");
 109:	89 44 24 30          	mov    %eax,0x30(%esp)
    childPid6 = executeForever(10000,"childPid6");
 10d:	b8 13 10 00 00       	mov    $0x1013,%eax
 112:	89 44 24 04          	mov    %eax,0x4(%esp)
 116:	e8 b5 05 00 00       	call   6d0 <executeForever>
    childPid7 = executeForever(0,"childPid7");
 11b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    childPid6 = executeForever(10000,"childPid6");
 122:	89 44 24 2c          	mov    %eax,0x2c(%esp)
    childPid7 = executeForever(0,"childPid7");
 126:	b8 1d 10 00 00       	mov    $0x101d,%eax
 12b:	89 44 24 04          	mov    %eax,0x4(%esp)
 12f:	e8 9c 05 00 00       	call   6d0 <executeForever>
    childPid8 = executeForever(0,"childPid8");
 134:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    childPid7 = executeForever(0,"childPid7");
 13b:	89 44 24 28          	mov    %eax,0x28(%esp)
    childPid8 = executeForever(0,"childPid8");
 13f:	b8 27 10 00 00       	mov    $0x1027,%eax
 144:	89 44 24 04          	mov    %eax,0x4(%esp)
 148:	e8 83 05 00 00       	call   6d0 <executeForever>
    childPid9 = executeForever(0,"childPid9");
 14d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    childPid8 = executeForever(0,"childPid8");
 154:	89 44 24 24          	mov    %eax,0x24(%esp)
    childPid9 = executeForever(0,"childPid9");
 158:	b8 31 10 00 00       	mov    $0x1031,%eax
 15d:	89 44 24 04          	mov    %eax,0x4(%esp)
 161:	e8 6a 05 00 00       	call   6d0 <executeForever>
    childPid10 = executeForever(0,"childPid10");
 166:	ba 3b 10 00 00       	mov    $0x103b,%edx
 16b:	89 54 24 04          	mov    %edx,0x4(%esp)
 16f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    childPid9 = executeForever(0,"childPid9");
 176:	89 44 24 20          	mov    %eax,0x20(%esp)
    childPid10 = executeForever(0,"childPid10");
 17a:	e8 51 05 00 00       	call   6d0 <executeForever>
    childPid11 = executeForever(0,"childPid11");
 17f:	b9 46 10 00 00       	mov    $0x1046,%ecx
 184:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 188:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    childPid10 = executeForever(0,"childPid10");
 18f:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    childPid11 = executeForever(0,"childPid11");
 193:	e8 38 05 00 00       	call   6d0 <executeForever>
    childPid12 = executeForever(20000,"childPid12");
 198:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 19c:	c7 04 24 20 4e 00 00 	movl   $0x4e20,(%esp)
    childPid11 = executeForever(0,"childPid11");
 1a3:	89 44 24 18          	mov    %eax,0x18(%esp)
    childPid12 = executeForever(20000,"childPid12");
 1a7:	e8 24 05 00 00       	call   6d0 <executeForever>
    childPid13 = executeForever(4567,"childPid13");
 1ac:	89 74 24 04          	mov    %esi,0x4(%esp)
 1b0:	c7 04 24 d7 11 00 00 	movl   $0x11d7,(%esp)
    childPid12 = executeForever(20000,"childPid12");
 1b7:	89 44 24 14          	mov    %eax,0x14(%esp)
    childPid13 = executeForever(4567,"childPid13");
 1bb:	e8 10 05 00 00       	call   6d0 <executeForever>
    childPid14 = executeForever(0,"childPid14");
 1c0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    childPid13 = executeForever(4567,"childPid13");
 1c7:	89 c7                	mov    %eax,%edi
    childPid14 = executeForever(0,"childPid14");
 1c9:	b8 67 10 00 00       	mov    $0x1067,%eax
 1ce:	89 44 24 04          	mov    %eax,0x4(%esp)
 1d2:	e8 f9 04 00 00       	call   6d0 <executeForever>
    childPid15 = executeForever(0,"childPid15");
 1d7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    childPid14 = executeForever(0,"childPid14");
 1de:	89 c6                	mov    %eax,%esi
    childPid15 = executeForever(0,"childPid15");
 1e0:	b8 72 10 00 00       	mov    $0x1072,%eax
 1e5:	89 44 24 04          	mov    %eax,0x4(%esp)
 1e9:	e8 e2 04 00 00       	call   6d0 <executeForever>
    executeTimes(400,50,"childPid16");
 1ee:	ba 32 00 00 00       	mov    $0x32,%edx
    childPid15 = executeForever(0,"childPid15");
 1f3:	89 c3                	mov    %eax,%ebx
    executeTimes(400,50,"childPid16");
 1f5:	b8 90 01 00 00       	mov    $0x190,%eax
 1fa:	e8 71 04 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(4,50,"childPid17");
 1ff:	ba 32 00 00 00       	mov    $0x32,%edx
 204:	b8 04 00 00 00       	mov    $0x4,%eax
 209:	e8 62 04 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(100,100,"childPid18");
 20e:	ba 64 00 00 00       	mov    $0x64,%edx
 213:	b8 64 00 00 00       	mov    $0x64,%eax
 218:	e8 53 04 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(500,10,"childPid19");
 21d:	ba 0a 00 00 00       	mov    $0xa,%edx
 222:	b8 f4 01 00 00       	mov    $0x1f4,%eax
 227:	e8 44 04 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(1000,15,"childPid20");
 22c:	ba 0f 00 00 00       	mov    $0xf,%edx
 231:	b8 e8 03 00 00       	mov    $0x3e8,%eax
 236:	e8 35 04 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(2000,2,"childPid21");
 23b:	ba 02 00 00 00       	mov    $0x2,%edx
 240:	b8 d0 07 00 00       	mov    $0x7d0,%eax
 245:	e8 26 04 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(40,22,"childPid22");
 24a:	ba 16 00 00 00       	mov    $0x16,%edx
 24f:	b8 28 00 00 00       	mov    $0x28,%eax
 254:	e8 17 04 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(400,40,"childPid23");
 259:	ba 28 00 00 00       	mov    $0x28,%edx
 25e:	b8 90 01 00 00       	mov    $0x190,%eax
 263:	e8 08 04 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(4000,5,"childPid24");
 268:	ba 05 00 00 00       	mov    $0x5,%edx
 26d:	b8 a0 0f 00 00       	mov    $0xfa0,%eax
 272:	e8 f9 03 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(10,5,"childPid25");
 277:	ba 05 00 00 00       	mov    $0x5,%edx
 27c:	b8 0a 00 00 00       	mov    $0xa,%eax
 281:	e8 ea 03 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(5,1,"childPid26");
 286:	ba 01 00 00 00       	mov    $0x1,%edx
 28b:	b8 05 00 00 00       	mov    $0x5,%eax
 290:	e8 db 03 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(300,30,"childPid27");
 295:	ba 1e 00 00 00       	mov    $0x1e,%edx
 29a:	b8 2c 01 00 00       	mov    $0x12c,%eax
 29f:	e8 cc 03 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(2000,5,"childPid28");
 2a4:	ba 05 00 00 00       	mov    $0x5,%edx
 2a9:	b8 d0 07 00 00       	mov    $0x7d0,%eax
 2ae:	e8 bd 03 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(200,20,"childPid29");
 2b3:	ba 14 00 00 00       	mov    $0x14,%edx
 2b8:	b8 c8 00 00 00       	mov    $0xc8,%eax
 2bd:	e8 ae 03 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(100,70,"childPid30");
 2c2:	ba 46 00 00 00       	mov    $0x46,%edx
 2c7:	b8 64 00 00 00       	mov    $0x64,%eax
 2cc:	e8 9f 03 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(200,90,"childPid31");
 2d1:	ba 5a 00 00 00       	mov    $0x5a,%edx
 2d6:	b8 c8 00 00 00       	mov    $0xc8,%eax
 2db:	e8 90 03 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(1000,18,"childPid32");
 2e0:	ba 12 00 00 00       	mov    $0x12,%edx
 2e5:	b8 e8 03 00 00       	mov    $0x3e8,%eax
 2ea:	e8 81 03 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(20,400,"childPid33");
 2ef:	ba 90 01 00 00       	mov    $0x190,%edx
 2f4:	b8 14 00 00 00       	mov    $0x14,%eax
 2f9:	e8 72 03 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(40,200,"childPid34");
 2fe:	ba c8 00 00 00       	mov    $0xc8,%edx
 303:	b8 28 00 00 00       	mov    $0x28,%eax
 308:	e8 63 03 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(90,150,"childPid35");
 30d:	ba 96 00 00 00       	mov    $0x96,%edx
 312:	b8 5a 00 00 00       	mov    $0x5a,%eax
 317:	e8 54 03 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(9,80,"childPid36");
 31c:	ba 50 00 00 00       	mov    $0x50,%edx
 321:	b8 09 00 00 00       	mov    $0x9,%eax
 326:	e8 45 03 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(1,140,"childPid37");
 32b:	ba 8c 00 00 00       	mov    $0x8c,%edx
 330:	b8 01 00 00 00       	mov    $0x1,%eax
 335:	e8 36 03 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(300,60,"childPid38");
 33a:	ba 3c 00 00 00       	mov    $0x3c,%edx
 33f:	b8 2c 01 00 00       	mov    $0x12c,%eax
 344:	e8 27 03 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(90,50,"childPid39");
 349:	ba 32 00 00 00       	mov    $0x32,%edx
 34e:	b8 5a 00 00 00       	mov    $0x5a,%eax
 353:	e8 18 03 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(200,30,"childPid40");
 358:	ba 1e 00 00 00       	mov    $0x1e,%edx
 35d:	b8 c8 00 00 00       	mov    $0xc8,%eax
 362:	e8 09 03 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(40,5,"childPid41");
 367:	ba 05 00 00 00       	mov    $0x5,%edx
 36c:	b8 28 00 00 00       	mov    $0x28,%eax
 371:	e8 fa 02 00 00       	call   670 <executeTimes.constprop.2>
    executeTimes(2000,2,"childPid42");
 376:	ba 02 00 00 00       	mov    $0x2,%edx
 37b:	b8 d0 07 00 00       	mov    $0x7d0,%eax
 380:	e8 eb 02 00 00       	call   670 <executeTimes.constprop.2>
    executeTimesExhaust(999999999999999999,"childPid43");
 385:	b8 7d 10 00 00       	mov    $0x107d,%eax
 38a:	89 44 24 08          	mov    %eax,0x8(%esp)
 38e:	b8 b3 b6 e0 0d       	mov    $0xde0b6b3,%eax
 393:	89 44 24 04          	mov    %eax,0x4(%esp)
 397:	c7 04 24 ff ff 63 a7 	movl   $0xa763ffff,(%esp)
 39e:	e8 ed 03 00 00       	call   790 <executeTimesExhaust>
    executeTimesExhaust(999999999999999999,"childPid44");
 3a3:	b8 88 10 00 00       	mov    $0x1088,%eax
 3a8:	89 44 24 08          	mov    %eax,0x8(%esp)
 3ac:	b8 b3 b6 e0 0d       	mov    $0xde0b6b3,%eax
 3b1:	89 44 24 04          	mov    %eax,0x4(%esp)
 3b5:	c7 04 24 ff ff 63 a7 	movl   $0xa763ffff,(%esp)
 3bc:	e8 cf 03 00 00       	call   790 <executeTimesExhaust>
    executeTimesExhaust(999999999999999999,"childPid45");
 3c1:	ba 93 10 00 00       	mov    $0x1093,%edx
 3c6:	b9 b3 b6 e0 0d       	mov    $0xde0b6b3,%ecx
 3cb:	89 54 24 08          	mov    %edx,0x8(%esp)
 3cf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 3d3:	c7 04 24 ff ff 63 a7 	movl   $0xa763ffff,(%esp)
 3da:	e8 b1 03 00 00       	call   790 <executeTimesExhaust>
    executeTimesExhaust(999999999999999999,"childPid46");
 3df:	b8 9e 10 00 00       	mov    $0x109e,%eax
 3e4:	89 44 24 08          	mov    %eax,0x8(%esp)
 3e8:	b8 b3 b6 e0 0d       	mov    $0xde0b6b3,%eax
 3ed:	89 44 24 04          	mov    %eax,0x4(%esp)
 3f1:	c7 04 24 ff ff 63 a7 	movl   $0xa763ffff,(%esp)
 3f8:	e8 93 03 00 00       	call   790 <executeTimesExhaust>
    executeTimesExhaust(999999999999999999,"childPid47");
 3fd:	b8 a9 10 00 00       	mov    $0x10a9,%eax
 402:	89 44 24 08          	mov    %eax,0x8(%esp)
 406:	b8 b3 b6 e0 0d       	mov    $0xde0b6b3,%eax
 40b:	89 44 24 04          	mov    %eax,0x4(%esp)
 40f:	c7 04 24 ff ff 63 a7 	movl   $0xa763ffff,(%esp)
 416:	e8 75 03 00 00       	call   790 <executeTimesExhaust>
    executeTimesExhaust(999999999999999999,"childPid48");
 41b:	b8 b4 10 00 00       	mov    $0x10b4,%eax
 420:	89 44 24 08          	mov    %eax,0x8(%esp)
 424:	b8 b3 b6 e0 0d       	mov    $0xde0b6b3,%eax
 429:	89 44 24 04          	mov    %eax,0x4(%esp)
 42d:	c7 04 24 ff ff 63 a7 	movl   $0xa763ffff,(%esp)
 434:	e8 57 03 00 00       	call   790 <executeTimesExhaust>
    executeTimesExhaust(999999999999999999,"childPid49");
 439:	ba bf 10 00 00       	mov    $0x10bf,%edx
 43e:	b9 b3 b6 e0 0d       	mov    $0xde0b6b3,%ecx
 443:	89 54 24 08          	mov    %edx,0x8(%esp)
 447:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 44b:	c7 04 24 ff ff 63 a7 	movl   $0xa763ffff,(%esp)
 452:	e8 39 03 00 00       	call   790 <executeTimesExhaust>
    executeTimesExhaust(999999999999999999,"childPid50");
 457:	b8 ca 10 00 00       	mov    $0x10ca,%eax
 45c:	89 44 24 08          	mov    %eax,0x8(%esp)
 460:	b8 b3 b6 e0 0d       	mov    $0xde0b6b3,%eax
 465:	89 44 24 04          	mov    %eax,0x4(%esp)
 469:	c7 04 24 ff ff 63 a7 	movl   $0xa763ffff,(%esp)
 470:	e8 1b 03 00 00       	call   790 <executeTimesExhaust>
    executeTimesExhaust(999999999999999999,"childPid51");
 475:	b8 d5 10 00 00       	mov    $0x10d5,%eax
 47a:	89 44 24 08          	mov    %eax,0x8(%esp)
 47e:	b8 b3 b6 e0 0d       	mov    $0xde0b6b3,%eax
 483:	89 44 24 04          	mov    %eax,0x4(%esp)
 487:	c7 04 24 ff ff 63 a7 	movl   $0xa763ffff,(%esp)
 48e:	e8 fd 02 00 00       	call   790 <executeTimesExhaust>
    executeTimesExhaust(999999999999999999,"childPid52");
 493:	b8 e0 10 00 00       	mov    $0x10e0,%eax
 498:	89 44 24 08          	mov    %eax,0x8(%esp)
 49c:	b8 b3 b6 e0 0d       	mov    $0xde0b6b3,%eax
 4a1:	89 44 24 04          	mov    %eax,0x4(%esp)
 4a5:	c7 04 24 ff ff 63 a7 	movl   $0xa763ffff,(%esp)
 4ac:	e8 df 02 00 00       	call   790 <executeTimesExhaust>
    executeTimesExhaust(999999999999999999,"childPid53");
 4b1:	ba eb 10 00 00       	mov    $0x10eb,%edx
 4b6:	b9 b3 b6 e0 0d       	mov    $0xde0b6b3,%ecx
 4bb:	89 54 24 08          	mov    %edx,0x8(%esp)
 4bf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 4c3:	c7 04 24 ff ff 63 a7 	movl   $0xa763ffff,(%esp)
 4ca:	e8 c1 02 00 00       	call   790 <executeTimesExhaust>
    executeTimesExhaust(999999999999999999,"childPid54");
 4cf:	b8 f6 10 00 00       	mov    $0x10f6,%eax
 4d4:	89 44 24 08          	mov    %eax,0x8(%esp)
 4d8:	b8 b3 b6 e0 0d       	mov    $0xde0b6b3,%eax
 4dd:	89 44 24 04          	mov    %eax,0x4(%esp)
 4e1:	c7 04 24 ff ff 63 a7 	movl   $0xa763ffff,(%esp)
 4e8:	e8 a3 02 00 00       	call   790 <executeTimesExhaust>
    executeTimesExhaust(999999999999999999,"childPid55");
 4ed:	b8 01 11 00 00       	mov    $0x1101,%eax
 4f2:	89 44 24 08          	mov    %eax,0x8(%esp)
 4f6:	b8 b3 b6 e0 0d       	mov    $0xde0b6b3,%eax
 4fb:	89 44 24 04          	mov    %eax,0x4(%esp)
 4ff:	c7 04 24 ff ff 63 a7 	movl   $0xa763ffff,(%esp)
 506:	e8 85 02 00 00       	call   790 <executeTimesExhaust>
    executeTimesExhaust(999999999999999999,"childPid56");
 50b:	b8 0c 11 00 00       	mov    $0x110c,%eax
 510:	89 44 24 08          	mov    %eax,0x8(%esp)
 514:	b8 b3 b6 e0 0d       	mov    $0xde0b6b3,%eax
 519:	89 44 24 04          	mov    %eax,0x4(%esp)
 51d:	c7 04 24 ff ff 63 a7 	movl   $0xa763ffff,(%esp)
 524:	e8 67 02 00 00       	call   790 <executeTimesExhaust>
    executeTimesExhaust(999999999999999999,"childPid57");
 529:	ba 17 11 00 00       	mov    $0x1117,%edx
 52e:	b9 b3 b6 e0 0d       	mov    $0xde0b6b3,%ecx
 533:	89 54 24 08          	mov    %edx,0x8(%esp)
 537:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 53b:	c7 04 24 ff ff 63 a7 	movl   $0xa763ffff,(%esp)
 542:	e8 49 02 00 00       	call   790 <executeTimesExhaust>
    executeTimesExhaust(999999999999999999,"childPid58");
 547:	b8 22 11 00 00       	mov    $0x1122,%eax
 54c:	89 44 24 08          	mov    %eax,0x8(%esp)
 550:	b8 b3 b6 e0 0d       	mov    $0xde0b6b3,%eax
 555:	89 44 24 04          	mov    %eax,0x4(%esp)
 559:	c7 04 24 ff ff 63 a7 	movl   $0xa763ffff,(%esp)
 560:	e8 2b 02 00 00       	call   790 <executeTimesExhaust>
    executeTimesExhaust(999999999999999999,"childPid59");
 565:	b8 2d 11 00 00       	mov    $0x112d,%eax
 56a:	89 44 24 08          	mov    %eax,0x8(%esp)
 56e:	b8 b3 b6 e0 0d       	mov    $0xde0b6b3,%eax
 573:	89 44 24 04          	mov    %eax,0x4(%esp)
 577:	c7 04 24 ff ff 63 a7 	movl   $0xa763ffff,(%esp)
 57e:	e8 0d 02 00 00       	call   790 <executeTimesExhaust>
    executeTimesExhaust(999999999999999999,"childPid60");
 583:	b8 38 11 00 00       	mov    $0x1138,%eax
 588:	89 44 24 08          	mov    %eax,0x8(%esp)
 58c:	b8 b3 b6 e0 0d       	mov    $0xde0b6b3,%eax
 591:	89 44 24 04          	mov    %eax,0x4(%esp)
 595:	c7 04 24 ff ff 63 a7 	movl   $0xa763ffff,(%esp)
 59c:	e8 ef 01 00 00       	call   790 <executeTimesExhaust>
    sleep(25000);
 5a1:	c7 04 24 a8 61 00 00 	movl   $0x61a8,(%esp)
 5a8:	e8 cb 05 00 00       	call   b78 <sleep>
    kill(childPid1);
 5ad:	8b 4c 24 10          	mov    0x10(%esp),%ecx
 5b1:	89 0c 24             	mov    %ecx,(%esp)
 5b4:	e8 5f 05 00 00       	call   b18 <kill>
    kill(childPid2);
 5b9:	8b 4c 24 3c          	mov    0x3c(%esp),%ecx
 5bd:	89 0c 24             	mov    %ecx,(%esp)
 5c0:	e8 53 05 00 00       	call   b18 <kill>
    kill(childPid3);
 5c5:	8b 4c 24 38          	mov    0x38(%esp),%ecx
 5c9:	89 0c 24             	mov    %ecx,(%esp)
 5cc:	e8 47 05 00 00       	call   b18 <kill>
    kill(childPid4);
 5d1:	8b 4c 24 34          	mov    0x34(%esp),%ecx
 5d5:	89 0c 24             	mov    %ecx,(%esp)
 5d8:	e8 3b 05 00 00       	call   b18 <kill>
    kill(childPid5);
 5dd:	8b 4c 24 30          	mov    0x30(%esp),%ecx
 5e1:	89 0c 24             	mov    %ecx,(%esp)
 5e4:	e8 2f 05 00 00       	call   b18 <kill>
    kill(childPid6);
 5e9:	8b 4c 24 2c          	mov    0x2c(%esp),%ecx
 5ed:	89 0c 24             	mov    %ecx,(%esp)
 5f0:	e8 23 05 00 00       	call   b18 <kill>
    kill(childPid7);
 5f5:	8b 4c 24 28          	mov    0x28(%esp),%ecx
 5f9:	89 0c 24             	mov    %ecx,(%esp)
 5fc:	e8 17 05 00 00       	call   b18 <kill>
    kill(childPid8);
 601:	8b 4c 24 24          	mov    0x24(%esp),%ecx
 605:	89 0c 24             	mov    %ecx,(%esp)
 608:	e8 0b 05 00 00       	call   b18 <kill>
    kill(childPid9);
 60d:	8b 4c 24 20          	mov    0x20(%esp),%ecx
 611:	89 0c 24             	mov    %ecx,(%esp)
 614:	e8 ff 04 00 00       	call   b18 <kill>
    kill(childPid10);
 619:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
 61d:	89 0c 24             	mov    %ecx,(%esp)
 620:	e8 f3 04 00 00       	call   b18 <kill>
    kill(childPid11);
 625:	8b 4c 24 18          	mov    0x18(%esp),%ecx
 629:	89 0c 24             	mov    %ecx,(%esp)
 62c:	e8 e7 04 00 00       	call   b18 <kill>
    kill(childPid12);
 631:	8b 44 24 14          	mov    0x14(%esp),%eax
 635:	89 04 24             	mov    %eax,(%esp)
 638:	e8 db 04 00 00       	call   b18 <kill>
    kill(childPid13);
 63d:	89 3c 24             	mov    %edi,(%esp)
 640:	e8 d3 04 00 00       	call   b18 <kill>
    kill(childPid14);
 645:	89 34 24             	mov    %esi,(%esp)
 648:	e8 cb 04 00 00       	call   b18 <kill>
    kill(childPid15);
 64d:	89 1c 24             	mov    %ebx,(%esp)
 650:	e8 c3 04 00 00       	call   b18 <kill>
    sleep(5000);
 655:	c7 04 24 88 13 00 00 	movl   $0x1388,(%esp)
 65c:	e8 17 05 00 00       	call   b78 <sleep>
    exit(0);
 661:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 668:	e8 7b 04 00 00       	call   ae8 <exit>
 66d:	66 90                	xchg   %ax,%ax
 66f:	90                   	nop

00000670 <executeTimes.constprop.2>:
void executeTimes(int timeToSleep,int numberOfLoops,char* debugString){
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	83 ec 18             	sub    $0x18,%esp
 676:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 679:	89 c3                	mov    %eax,%ebx
 67b:	89 75 fc             	mov    %esi,-0x4(%ebp)
 67e:	89 d6                	mov    %edx,%esi
    if((pid = fork()) == 0){
 680:	e8 5b 04 00 00       	call   ae0 <fork>
 685:	83 f8 00             	cmp    $0x0,%eax
 688:	74 35                	je     6bf <executeTimes.constprop.2+0x4f>
    }
    else if(pid > 0){
 68a:	7e 14                	jle    6a0 <executeTimes.constprop.2+0x30>
        detach(pid);
 68c:	89 04 24             	mov    %eax,(%esp)
 68f:	90                   	nop
 690:	e8 f3 04 00 00       	call   b88 <detach>
    }
    else{
        printf(1,"fork failed\n");
    }
}
 695:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 698:	8b 75 fc             	mov    -0x4(%ebp),%esi
 69b:	89 ec                	mov    %ebp,%esp
 69d:	5d                   	pop    %ebp
 69e:	c3                   	ret    
 69f:	90                   	nop
        printf(1,"fork failed\n");
 6a0:	b8 c8 0f 00 00       	mov    $0xfc8,%eax
 6a5:	89 44 24 04          	mov    %eax,0x4(%esp)
 6a9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 6b0:	e8 9b 05 00 00       	call   c50 <printf>
}
 6b5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 6b8:	8b 75 fc             	mov    -0x4(%ebp),%esi
 6bb:	89 ec                	mov    %ebp,%esp
 6bd:	5d                   	pop    %ebp
 6be:	c3                   	ret    
 6bf:	89 f2                	mov    %esi,%edx
 6c1:	89 d8                	mov    %ebx,%eax
 6c3:	e8 38 f9 ff ff       	call   0 <executeTimes.part.0>
 6c8:	90                   	nop
 6c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006d0 <executeForever>:
int executeForever(int timeToSleep,char* debugString){
 6d0:	55                   	push   %ebp
 6d1:	89 e5                	mov    %esp,%ebp
 6d3:	56                   	push   %esi
 6d4:	53                   	push   %ebx
 6d5:	83 ec 10             	sub    $0x10,%esp
 6d8:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if((pid = fork()) == 0){
 6db:	e8 00 04 00 00       	call   ae0 <fork>
 6e0:	83 f8 00             	cmp    $0x0,%eax
 6e3:	74 23                	je     708 <executeForever+0x38>
    else if(pid > 0){
 6e5:	7e 27                	jle    70e <executeForever+0x3e>
        detach(pid);
 6e7:	89 04 24             	mov    %eax,(%esp)
 6ea:	89 c6                	mov    %eax,%esi
 6ec:	e8 97 04 00 00       	call   b88 <detach>
}
 6f1:	83 c4 10             	add    $0x10,%esp
 6f4:	89 f0                	mov    %esi,%eax
 6f6:	5b                   	pop    %ebx
 6f7:	5e                   	pop    %esi
 6f8:	5d                   	pop    %ebp
 6f9:	c3                   	ret    
 6fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                sleep(timeToSleep);    
 700:	89 1c 24             	mov    %ebx,(%esp)
 703:	e8 70 04 00 00       	call   b78 <sleep>
            if(timeToSleep){ 
 708:	85 db                	test   %ebx,%ebx
 70a:	75 f4                	jne    700 <executeForever+0x30>
 70c:	eb fe                	jmp    70c <executeForever+0x3c>
        printf(1,"fork failed\n");
 70e:	b8 c8 0f 00 00       	mov    $0xfc8,%eax
        return 0;
 713:	31 f6                	xor    %esi,%esi
        printf(1,"fork failed\n");
 715:	89 44 24 04          	mov    %eax,0x4(%esp)
 719:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 720:	e8 2b 05 00 00       	call   c50 <printf>
        return 0;
 725:	eb ca                	jmp    6f1 <executeForever+0x21>
 727:	89 f6                	mov    %esi,%esi
 729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000730 <executeTimes>:
void executeTimes(int timeToSleep,int numberOfLoops,char* debugString){
 730:	55                   	push   %ebp
 731:	89 e5                	mov    %esp,%ebp
 733:	83 ec 08             	sub    $0x8,%esp
 736:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 739:	8b 5d 08             	mov    0x8(%ebp),%ebx
 73c:	89 75 fc             	mov    %esi,-0x4(%ebp)
 73f:	8b 75 0c             	mov    0xc(%ebp),%esi
    if((pid = fork()) == 0){
 742:	e8 99 03 00 00       	call   ae0 <fork>
 747:	83 f8 00             	cmp    $0x0,%eax
 74a:	74 30                	je     77c <executeTimes+0x4c>
    else if(pid > 0){
 74c:	7e 12                	jle    760 <executeTimes+0x30>
        detach(pid);
 74e:	89 45 08             	mov    %eax,0x8(%ebp)
}
 751:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 754:	8b 75 fc             	mov    -0x4(%ebp),%esi
 757:	89 ec                	mov    %ebp,%esp
 759:	5d                   	pop    %ebp
        detach(pid);
 75a:	e9 29 04 00 00       	jmp    b88 <detach>
 75f:	90                   	nop
        printf(1,"fork failed\n");
 760:	c7 45 0c c8 0f 00 00 	movl   $0xfc8,0xc(%ebp)
}
 767:	8b 5d f8             	mov    -0x8(%ebp),%ebx
        printf(1,"fork failed\n");
 76a:	c7 45 08 01 00 00 00 	movl   $0x1,0x8(%ebp)
}
 771:	8b 75 fc             	mov    -0x4(%ebp),%esi
 774:	89 ec                	mov    %ebp,%esp
 776:	5d                   	pop    %ebp
        printf(1,"fork failed\n");
 777:	e9 d4 04 00 00       	jmp    c50 <printf>
 77c:	89 f2                	mov    %esi,%edx
 77e:	89 d8                	mov    %ebx,%eax
 780:	e8 7b f8 ff ff       	call   0 <executeTimes.part.0>
 785:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000790 <executeTimesExhaust>:

void executeTimesExhaust(long long times,char* debugString){
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	56                   	push   %esi
 794:	53                   	push   %ebx
 795:	83 ec 10             	sub    $0x10,%esp
 798:	8b 5d 08             	mov    0x8(%ebp),%ebx
 79b:	8b 75 0c             	mov    0xc(%ebp),%esi
    int pid;

    if((pid = fork()) == 0){
 79e:	e8 3d 03 00 00       	call   ae0 <fork>
 7a3:	83 f8 00             	cmp    $0x0,%eax
 7a6:	74 10                	je     7b8 <executeTimesExhaust+0x28>
            printf(1,debugString);
            printf(1," ending...\n");
        }
        exit(0);
    }
    else if(pid > 0){
 7a8:	7e 36                	jle    7e0 <executeTimesExhaust+0x50>
        detach(pid);
 7aa:	89 45 08             	mov    %eax,0x8(%ebp)
    }
    else{
        printf(1,"fork failed\n");
    }
}
 7ad:	83 c4 10             	add    $0x10,%esp
 7b0:	5b                   	pop    %ebx
 7b1:	5e                   	pop    %esi
 7b2:	5d                   	pop    %ebp
        detach(pid);
 7b3:	e9 d0 03 00 00       	jmp    b88 <detach>
        for(int i = 0;i < times;i++){
 7b8:	83 fe 00             	cmp    $0x0,%esi
 7bb:	7c 17                	jl     7d4 <executeTimesExhaust+0x44>
 7bd:	7e 3a                	jle    7f9 <executeTimesExhaust+0x69>
 7bf:	b8 ea d6 2c 7e       	mov    $0x7e2cd6ea,%eax
 7c4:	ba bf 74 f1 ef       	mov    $0xeff174bf,%edx
 7c9:	a3 78 15 00 00       	mov    %eax,0x1578
 7ce:	89 15 7c 15 00 00    	mov    %edx,0x157c
        exit(0);
 7d4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 7db:	e8 08 03 00 00       	call   ae8 <exit>
        printf(1,"fork failed\n");
 7e0:	c7 45 0c c8 0f 00 00 	movl   $0xfc8,0xc(%ebp)
 7e7:	c7 45 08 01 00 00 00 	movl   $0x1,0x8(%ebp)
}
 7ee:	83 c4 10             	add    $0x10,%esp
 7f1:	5b                   	pop    %ebx
 7f2:	5e                   	pop    %esi
 7f3:	5d                   	pop    %ebp
        printf(1,"fork failed\n");
 7f4:	e9 57 04 00 00       	jmp    c50 <printf>
        for(int i = 0;i < times;i++){
 7f9:	83 fb 00             	cmp    $0x0,%ebx
 7fc:	76 d6                	jbe    7d4 <executeTimesExhaust+0x44>
 7fe:	eb bf                	jmp    7bf <executeTimesExhaust+0x2f>

00000800 <executeTestMonitor>:

void executeTestMonitor(int timeBetweenLoop,int numberOfLoops,char* debugString){
 800:	55                   	push   %ebp
 801:	89 e5                	mov    %esp,%ebp
 803:	83 ec 38             	sub    $0x38,%esp
 806:	89 5d f4             	mov    %ebx,-0xc(%ebp)
 809:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 80c:	89 75 f8             	mov    %esi,-0x8(%ebp)
 80f:	8b 75 08             	mov    0x8(%ebp),%esi
 812:	89 7d fc             	mov    %edi,-0x4(%ebp)
    int pid;
    int changePolicy = 1;

    if((pid = fork()) == 0){
 815:	e8 c6 02 00 00       	call   ae0 <fork>
 81a:	83 f8 00             	cmp    $0x0,%eax
 81d:	89 c7                	mov    %eax,%edi
 81f:	74 3e                	je     85f <executeTestMonitor+0x5f>
            printf(1," ending...\n");
        }

        exit(0);
    }
    else if(pid > 0){
 821:	7e 1d                	jle    840 <executeTestMonitor+0x40>
        detach(pid);
 823:	89 45 08             	mov    %eax,0x8(%ebp)
    }
    else{
        printf(1,"fork failed\n");
    }
}
 826:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 829:	8b 75 f8             	mov    -0x8(%ebp),%esi
 82c:	8b 7d fc             	mov    -0x4(%ebp),%edi
 82f:	89 ec                	mov    %ebp,%esp
 831:	5d                   	pop    %ebp
        detach(pid);
 832:	e9 51 03 00 00       	jmp    b88 <detach>
 837:	89 f6                	mov    %esi,%esi
 839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        printf(1,"fork failed\n");
 840:	c7 45 0c c8 0f 00 00 	movl   $0xfc8,0xc(%ebp)
}
 847:	8b 5d f4             	mov    -0xc(%ebp),%ebx
        printf(1,"fork failed\n");
 84a:	c7 45 08 01 00 00 00 	movl   $0x1,0x8(%ebp)
}
 851:	8b 75 f8             	mov    -0x8(%ebp),%esi
 854:	8b 7d fc             	mov    -0x4(%ebp),%edi
 857:	89 ec                	mov    %ebp,%esp
 859:	5d                   	pop    %ebp
        printf(1,"fork failed\n");
 85a:	e9 f1 03 00 00       	jmp    c50 <printf>
        policy(changePolicy);
 85f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 866:	e8 2d 03 00 00       	call   b98 <policy>
        sleep(1000);
 86b:	c7 04 24 e8 03 00 00 	movl   $0x3e8,(%esp)
 872:	e8 01 03 00 00       	call   b78 <sleep>
        for(int i = 0;i < numberOfLoops;i++){
 877:	85 db                	test   %ebx,%ebx
 879:	7e 36                	jle    8b1 <executeTestMonitor+0xb1>
    int changePolicy = 1;
 87b:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
 882:	eb 14                	jmp    898 <executeTestMonitor+0x98>
                changePolicy++;
 884:	40                   	inc    %eax
 885:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            policy(changePolicy);
 888:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        for(int i = 0;i < numberOfLoops;i++){
 88b:	47                   	inc    %edi
            policy(changePolicy);
 88c:	89 04 24             	mov    %eax,(%esp)
 88f:	e8 04 03 00 00       	call   b98 <policy>
        for(int i = 0;i < numberOfLoops;i++){
 894:	39 fb                	cmp    %edi,%ebx
 896:	74 19                	je     8b1 <executeTestMonitor+0xb1>
            sleep(timeBetweenLoop);
 898:	89 34 24             	mov    %esi,(%esp)
 89b:	e8 d8 02 00 00       	call   b78 <sleep>
            if(changePolicy == 3){
 8a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8a3:	83 f8 03             	cmp    $0x3,%eax
 8a6:	75 dc                	jne    884 <executeTestMonitor+0x84>
                changePolicy = 1;
 8a8:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
 8af:	eb d7                	jmp    888 <executeTestMonitor+0x88>
        exit(0);
 8b1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 8b8:	e8 2b 02 00 00       	call   ae8 <exit>
 8bd:	66 90                	xchg   %ax,%ax
 8bf:	90                   	nop

000008c0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 8c0:	55                   	push   %ebp
 8c1:	89 e5                	mov    %esp,%ebp
 8c3:	8b 45 08             	mov    0x8(%ebp),%eax
 8c6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 8c9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 8ca:	89 c2                	mov    %eax,%edx
 8cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 8d0:	41                   	inc    %ecx
 8d1:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 8d5:	42                   	inc    %edx
 8d6:	84 db                	test   %bl,%bl
 8d8:	88 5a ff             	mov    %bl,-0x1(%edx)
 8db:	75 f3                	jne    8d0 <strcpy+0x10>
    ;
  return os;
}
 8dd:	5b                   	pop    %ebx
 8de:	5d                   	pop    %ebp
 8df:	c3                   	ret    

000008e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 8e0:	55                   	push   %ebp
 8e1:	89 e5                	mov    %esp,%ebp
 8e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 8e6:	53                   	push   %ebx
 8e7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 8ea:	0f b6 01             	movzbl (%ecx),%eax
 8ed:	0f b6 13             	movzbl (%ebx),%edx
 8f0:	84 c0                	test   %al,%al
 8f2:	75 18                	jne    90c <strcmp+0x2c>
 8f4:	eb 22                	jmp    918 <strcmp+0x38>
 8f6:	8d 76 00             	lea    0x0(%esi),%esi
 8f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 900:	41                   	inc    %ecx
  while(*p && *p == *q)
 901:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
 904:	43                   	inc    %ebx
 905:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
 908:	84 c0                	test   %al,%al
 90a:	74 0c                	je     918 <strcmp+0x38>
 90c:	38 d0                	cmp    %dl,%al
 90e:	74 f0                	je     900 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
 910:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 911:	29 d0                	sub    %edx,%eax
}
 913:	5d                   	pop    %ebp
 914:	c3                   	ret    
 915:	8d 76 00             	lea    0x0(%esi),%esi
 918:	5b                   	pop    %ebx
 919:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 91b:	29 d0                	sub    %edx,%eax
}
 91d:	5d                   	pop    %ebp
 91e:	c3                   	ret    
 91f:	90                   	nop

00000920 <strlen>:

uint
strlen(const char *s)
{
 920:	55                   	push   %ebp
 921:	89 e5                	mov    %esp,%ebp
 923:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 926:	80 39 00             	cmpb   $0x0,(%ecx)
 929:	74 15                	je     940 <strlen+0x20>
 92b:	31 d2                	xor    %edx,%edx
 92d:	8d 76 00             	lea    0x0(%esi),%esi
 930:	42                   	inc    %edx
 931:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 935:	89 d0                	mov    %edx,%eax
 937:	75 f7                	jne    930 <strlen+0x10>
    ;
  return n;
}
 939:	5d                   	pop    %ebp
 93a:	c3                   	ret    
 93b:	90                   	nop
 93c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
 940:	31 c0                	xor    %eax,%eax
}
 942:	5d                   	pop    %ebp
 943:	c3                   	ret    
 944:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 94a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000950 <memset>:

void*
memset(void *dst, int c, uint n)
{
 950:	55                   	push   %ebp
 951:	89 e5                	mov    %esp,%ebp
 953:	8b 55 08             	mov    0x8(%ebp),%edx
 956:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 957:	8b 4d 10             	mov    0x10(%ebp),%ecx
 95a:	8b 45 0c             	mov    0xc(%ebp),%eax
 95d:	89 d7                	mov    %edx,%edi
 95f:	fc                   	cld    
 960:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 962:	5f                   	pop    %edi
 963:	89 d0                	mov    %edx,%eax
 965:	5d                   	pop    %ebp
 966:	c3                   	ret    
 967:	89 f6                	mov    %esi,%esi
 969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000970 <strchr>:

char*
strchr(const char *s, char c)
{
 970:	55                   	push   %ebp
 971:	89 e5                	mov    %esp,%ebp
 973:	8b 45 08             	mov    0x8(%ebp),%eax
 976:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 97a:	0f b6 10             	movzbl (%eax),%edx
 97d:	84 d2                	test   %dl,%dl
 97f:	74 1b                	je     99c <strchr+0x2c>
    if(*s == c)
 981:	38 d1                	cmp    %dl,%cl
 983:	75 0f                	jne    994 <strchr+0x24>
 985:	eb 17                	jmp    99e <strchr+0x2e>
 987:	89 f6                	mov    %esi,%esi
 989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 990:	38 ca                	cmp    %cl,%dl
 992:	74 0a                	je     99e <strchr+0x2e>
  for(; *s; s++)
 994:	40                   	inc    %eax
 995:	0f b6 10             	movzbl (%eax),%edx
 998:	84 d2                	test   %dl,%dl
 99a:	75 f4                	jne    990 <strchr+0x20>
      return (char*)s;
  return 0;
 99c:	31 c0                	xor    %eax,%eax
}
 99e:	5d                   	pop    %ebp
 99f:	c3                   	ret    

000009a0 <gets>:

char*
gets(char *buf, int max)
{
 9a0:	55                   	push   %ebp
 9a1:	89 e5                	mov    %esp,%ebp
 9a3:	57                   	push   %edi
 9a4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 9a5:	31 f6                	xor    %esi,%esi
{
 9a7:	53                   	push   %ebx
 9a8:	83 ec 3c             	sub    $0x3c,%esp
 9ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
 9ae:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 9b1:	eb 32                	jmp    9e5 <gets+0x45>
 9b3:	90                   	nop
 9b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 9b8:	ba 01 00 00 00       	mov    $0x1,%edx
 9bd:	89 54 24 08          	mov    %edx,0x8(%esp)
 9c1:	89 7c 24 04          	mov    %edi,0x4(%esp)
 9c5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 9cc:	e8 2f 01 00 00       	call   b00 <read>
    if(cc < 1)
 9d1:	85 c0                	test   %eax,%eax
 9d3:	7e 19                	jle    9ee <gets+0x4e>
      break;
    buf[i++] = c;
 9d5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 9d9:	43                   	inc    %ebx
 9da:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
 9dd:	3c 0a                	cmp    $0xa,%al
 9df:	74 1f                	je     a00 <gets+0x60>
 9e1:	3c 0d                	cmp    $0xd,%al
 9e3:	74 1b                	je     a00 <gets+0x60>
  for(i=0; i+1 < max; ){
 9e5:	46                   	inc    %esi
 9e6:	3b 75 0c             	cmp    0xc(%ebp),%esi
 9e9:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 9ec:	7c ca                	jl     9b8 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 9ee:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 9f1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 9f4:	8b 45 08             	mov    0x8(%ebp),%eax
 9f7:	83 c4 3c             	add    $0x3c,%esp
 9fa:	5b                   	pop    %ebx
 9fb:	5e                   	pop    %esi
 9fc:	5f                   	pop    %edi
 9fd:	5d                   	pop    %ebp
 9fe:	c3                   	ret    
 9ff:	90                   	nop
 a00:	8b 45 08             	mov    0x8(%ebp),%eax
 a03:	01 c6                	add    %eax,%esi
 a05:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 a08:	eb e4                	jmp    9ee <gets+0x4e>
 a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000a10 <stat>:

int
stat(const char *n, struct stat *st)
{
 a10:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 a11:	31 c0                	xor    %eax,%eax
{
 a13:	89 e5                	mov    %esp,%ebp
 a15:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 a18:	89 44 24 04          	mov    %eax,0x4(%esp)
 a1c:	8b 45 08             	mov    0x8(%ebp),%eax
{
 a1f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 a22:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 a25:	89 04 24             	mov    %eax,(%esp)
 a28:	e8 fb 00 00 00       	call   b28 <open>
  if(fd < 0)
 a2d:	85 c0                	test   %eax,%eax
 a2f:	78 2f                	js     a60 <stat+0x50>
 a31:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 a33:	8b 45 0c             	mov    0xc(%ebp),%eax
 a36:	89 1c 24             	mov    %ebx,(%esp)
 a39:	89 44 24 04          	mov    %eax,0x4(%esp)
 a3d:	e8 fe 00 00 00       	call   b40 <fstat>
  close(fd);
 a42:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 a45:	89 c6                	mov    %eax,%esi
  close(fd);
 a47:	e8 c4 00 00 00       	call   b10 <close>
  return r;
}
 a4c:	89 f0                	mov    %esi,%eax
 a4e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 a51:	8b 75 fc             	mov    -0x4(%ebp),%esi
 a54:	89 ec                	mov    %ebp,%esp
 a56:	5d                   	pop    %ebp
 a57:	c3                   	ret    
 a58:	90                   	nop
 a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 a60:	be ff ff ff ff       	mov    $0xffffffff,%esi
 a65:	eb e5                	jmp    a4c <stat+0x3c>
 a67:	89 f6                	mov    %esi,%esi
 a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a70 <atoi>:

int
atoi(const char *s)
{
 a70:	55                   	push   %ebp
 a71:	89 e5                	mov    %esp,%ebp
 a73:	8b 4d 08             	mov    0x8(%ebp),%ecx
 a76:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 a77:	0f be 11             	movsbl (%ecx),%edx
 a7a:	88 d0                	mov    %dl,%al
 a7c:	2c 30                	sub    $0x30,%al
 a7e:	3c 09                	cmp    $0x9,%al
  n = 0;
 a80:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 a85:	77 1e                	ja     aa5 <atoi+0x35>
 a87:	89 f6                	mov    %esi,%esi
 a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 a90:	41                   	inc    %ecx
 a91:	8d 04 80             	lea    (%eax,%eax,4),%eax
 a94:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 a98:	0f be 11             	movsbl (%ecx),%edx
 a9b:	88 d3                	mov    %dl,%bl
 a9d:	80 eb 30             	sub    $0x30,%bl
 aa0:	80 fb 09             	cmp    $0x9,%bl
 aa3:	76 eb                	jbe    a90 <atoi+0x20>
  return n;
}
 aa5:	5b                   	pop    %ebx
 aa6:	5d                   	pop    %ebp
 aa7:	c3                   	ret    
 aa8:	90                   	nop
 aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000ab0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 ab0:	55                   	push   %ebp
 ab1:	89 e5                	mov    %esp,%ebp
 ab3:	56                   	push   %esi
 ab4:	8b 45 08             	mov    0x8(%ebp),%eax
 ab7:	53                   	push   %ebx
 ab8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 abb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 abe:	85 db                	test   %ebx,%ebx
 ac0:	7e 1a                	jle    adc <memmove+0x2c>
 ac2:	31 d2                	xor    %edx,%edx
 ac4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 aca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
 ad0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 ad4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 ad7:	42                   	inc    %edx
  while(n-- > 0)
 ad8:	39 d3                	cmp    %edx,%ebx
 ada:	75 f4                	jne    ad0 <memmove+0x20>
  return vdst;
}
 adc:	5b                   	pop    %ebx
 add:	5e                   	pop    %esi
 ade:	5d                   	pop    %ebp
 adf:	c3                   	ret    

00000ae0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 ae0:	b8 01 00 00 00       	mov    $0x1,%eax
 ae5:	cd 40                	int    $0x40
 ae7:	c3                   	ret    

00000ae8 <exit>:
SYSCALL(exit)
 ae8:	b8 02 00 00 00       	mov    $0x2,%eax
 aed:	cd 40                	int    $0x40
 aef:	c3                   	ret    

00000af0 <wait>:
SYSCALL(wait)
 af0:	b8 03 00 00 00       	mov    $0x3,%eax
 af5:	cd 40                	int    $0x40
 af7:	c3                   	ret    

00000af8 <pipe>:
SYSCALL(pipe)
 af8:	b8 04 00 00 00       	mov    $0x4,%eax
 afd:	cd 40                	int    $0x40
 aff:	c3                   	ret    

00000b00 <read>:
SYSCALL(read)
 b00:	b8 05 00 00 00       	mov    $0x5,%eax
 b05:	cd 40                	int    $0x40
 b07:	c3                   	ret    

00000b08 <write>:
SYSCALL(write)
 b08:	b8 10 00 00 00       	mov    $0x10,%eax
 b0d:	cd 40                	int    $0x40
 b0f:	c3                   	ret    

00000b10 <close>:
SYSCALL(close)
 b10:	b8 15 00 00 00       	mov    $0x15,%eax
 b15:	cd 40                	int    $0x40
 b17:	c3                   	ret    

00000b18 <kill>:
SYSCALL(kill)
 b18:	b8 06 00 00 00       	mov    $0x6,%eax
 b1d:	cd 40                	int    $0x40
 b1f:	c3                   	ret    

00000b20 <exec>:
SYSCALL(exec)
 b20:	b8 07 00 00 00       	mov    $0x7,%eax
 b25:	cd 40                	int    $0x40
 b27:	c3                   	ret    

00000b28 <open>:
SYSCALL(open)
 b28:	b8 0f 00 00 00       	mov    $0xf,%eax
 b2d:	cd 40                	int    $0x40
 b2f:	c3                   	ret    

00000b30 <mknod>:
SYSCALL(mknod)
 b30:	b8 11 00 00 00       	mov    $0x11,%eax
 b35:	cd 40                	int    $0x40
 b37:	c3                   	ret    

00000b38 <unlink>:
SYSCALL(unlink)
 b38:	b8 12 00 00 00       	mov    $0x12,%eax
 b3d:	cd 40                	int    $0x40
 b3f:	c3                   	ret    

00000b40 <fstat>:
SYSCALL(fstat)
 b40:	b8 08 00 00 00       	mov    $0x8,%eax
 b45:	cd 40                	int    $0x40
 b47:	c3                   	ret    

00000b48 <link>:
SYSCALL(link)
 b48:	b8 13 00 00 00       	mov    $0x13,%eax
 b4d:	cd 40                	int    $0x40
 b4f:	c3                   	ret    

00000b50 <mkdir>:
SYSCALL(mkdir)
 b50:	b8 14 00 00 00       	mov    $0x14,%eax
 b55:	cd 40                	int    $0x40
 b57:	c3                   	ret    

00000b58 <chdir>:
SYSCALL(chdir)
 b58:	b8 09 00 00 00       	mov    $0x9,%eax
 b5d:	cd 40                	int    $0x40
 b5f:	c3                   	ret    

00000b60 <dup>:
SYSCALL(dup)
 b60:	b8 0a 00 00 00       	mov    $0xa,%eax
 b65:	cd 40                	int    $0x40
 b67:	c3                   	ret    

00000b68 <getpid>:
SYSCALL(getpid)
 b68:	b8 0b 00 00 00       	mov    $0xb,%eax
 b6d:	cd 40                	int    $0x40
 b6f:	c3                   	ret    

00000b70 <sbrk>:
SYSCALL(sbrk)
 b70:	b8 0c 00 00 00       	mov    $0xc,%eax
 b75:	cd 40                	int    $0x40
 b77:	c3                   	ret    

00000b78 <sleep>:
SYSCALL(sleep)
 b78:	b8 0d 00 00 00       	mov    $0xd,%eax
 b7d:	cd 40                	int    $0x40
 b7f:	c3                   	ret    

00000b80 <uptime>:
SYSCALL(uptime)
 b80:	b8 0e 00 00 00       	mov    $0xe,%eax
 b85:	cd 40                	int    $0x40
 b87:	c3                   	ret    

00000b88 <detach>:
SYSCALL(detach)
 b88:	b8 16 00 00 00       	mov    $0x16,%eax
 b8d:	cd 40                	int    $0x40
 b8f:	c3                   	ret    

00000b90 <priority>:
SYSCALL(priority)
 b90:	b8 17 00 00 00       	mov    $0x17,%eax
 b95:	cd 40                	int    $0x40
 b97:	c3                   	ret    

00000b98 <policy>:
SYSCALL(policy)
 b98:	b8 18 00 00 00       	mov    $0x18,%eax
 b9d:	cd 40                	int    $0x40
 b9f:	c3                   	ret    

00000ba0 <wait_stat>:
SYSCALL(wait_stat)
 ba0:	b8 19 00 00 00       	mov    $0x19,%eax
 ba5:	cd 40                	int    $0x40
 ba7:	c3                   	ret    
 ba8:	66 90                	xchg   %ax,%ax
 baa:	66 90                	xchg   %ax,%ax
 bac:	66 90                	xchg   %ax,%ax
 bae:	66 90                	xchg   %ax,%ax

00000bb0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 bb0:	55                   	push   %ebp
 bb1:	89 e5                	mov    %esp,%ebp
 bb3:	57                   	push   %edi
 bb4:	56                   	push   %esi
 bb5:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 bb6:	89 d3                	mov    %edx,%ebx
 bb8:	c1 eb 1f             	shr    $0x1f,%ebx
{
 bbb:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
 bbe:	84 db                	test   %bl,%bl
{
 bc0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 bc3:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 bc5:	74 79                	je     c40 <printint+0x90>
 bc7:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 bcb:	74 73                	je     c40 <printint+0x90>
    neg = 1;
    x = -xx;
 bcd:	f7 d8                	neg    %eax
    neg = 1;
 bcf:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 bd6:	31 f6                	xor    %esi,%esi
 bd8:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 bdb:	eb 05                	jmp    be2 <printint+0x32>
 bdd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 be0:	89 fe                	mov    %edi,%esi
 be2:	31 d2                	xor    %edx,%edx
 be4:	f7 f1                	div    %ecx
 be6:	8d 7e 01             	lea    0x1(%esi),%edi
 be9:	0f b6 92 a0 11 00 00 	movzbl 0x11a0(%edx),%edx
  }while((x /= base) != 0);
 bf0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 bf2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 bf5:	75 e9                	jne    be0 <printint+0x30>
  if(neg)
 bf7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 bfa:	85 d2                	test   %edx,%edx
 bfc:	74 08                	je     c06 <printint+0x56>
    buf[i++] = '-';
 bfe:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 c03:	8d 7e 02             	lea    0x2(%esi),%edi
 c06:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 c0a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 c0d:	8d 76 00             	lea    0x0(%esi),%esi
 c10:	0f b6 06             	movzbl (%esi),%eax
 c13:	4e                   	dec    %esi
  write(fd, &c, 1);
 c14:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 c18:	89 3c 24             	mov    %edi,(%esp)
 c1b:	88 45 d7             	mov    %al,-0x29(%ebp)
 c1e:	b8 01 00 00 00       	mov    $0x1,%eax
 c23:	89 44 24 08          	mov    %eax,0x8(%esp)
 c27:	e8 dc fe ff ff       	call   b08 <write>

  while(--i >= 0)
 c2c:	39 de                	cmp    %ebx,%esi
 c2e:	75 e0                	jne    c10 <printint+0x60>
    putc(fd, buf[i]);
}
 c30:	83 c4 4c             	add    $0x4c,%esp
 c33:	5b                   	pop    %ebx
 c34:	5e                   	pop    %esi
 c35:	5f                   	pop    %edi
 c36:	5d                   	pop    %ebp
 c37:	c3                   	ret    
 c38:	90                   	nop
 c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 c40:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 c47:	eb 8d                	jmp    bd6 <printint+0x26>
 c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000c50 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 c50:	55                   	push   %ebp
 c51:	89 e5                	mov    %esp,%ebp
 c53:	57                   	push   %edi
 c54:	56                   	push   %esi
 c55:	53                   	push   %ebx
 c56:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 c59:	8b 75 0c             	mov    0xc(%ebp),%esi
 c5c:	0f b6 1e             	movzbl (%esi),%ebx
 c5f:	84 db                	test   %bl,%bl
 c61:	0f 84 d1 00 00 00    	je     d38 <printf+0xe8>
  state = 0;
 c67:	31 ff                	xor    %edi,%edi
 c69:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
 c6a:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
 c6d:	89 fa                	mov    %edi,%edx
 c6f:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
 c72:	89 45 d0             	mov    %eax,-0x30(%ebp)
 c75:	eb 41                	jmp    cb8 <printf+0x68>
 c77:	89 f6                	mov    %esi,%esi
 c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 c80:	83 f8 25             	cmp    $0x25,%eax
 c83:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 c86:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 c8b:	74 1e                	je     cab <printf+0x5b>
  write(fd, &c, 1);
 c8d:	b8 01 00 00 00       	mov    $0x1,%eax
 c92:	89 44 24 08          	mov    %eax,0x8(%esp)
 c96:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 c99:	89 44 24 04          	mov    %eax,0x4(%esp)
 c9d:	89 3c 24             	mov    %edi,(%esp)
 ca0:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 ca3:	e8 60 fe ff ff       	call   b08 <write>
 ca8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 cab:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
 cac:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 cb0:	84 db                	test   %bl,%bl
 cb2:	0f 84 80 00 00 00    	je     d38 <printf+0xe8>
    if(state == 0){
 cb8:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 cba:	0f be cb             	movsbl %bl,%ecx
 cbd:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 cc0:	74 be                	je     c80 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 cc2:	83 fa 25             	cmp    $0x25,%edx
 cc5:	75 e4                	jne    cab <printf+0x5b>
      if(c == 'd'){
 cc7:	83 f8 64             	cmp    $0x64,%eax
 cca:	0f 84 f0 00 00 00    	je     dc0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 cd0:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 cd6:	83 f9 70             	cmp    $0x70,%ecx
 cd9:	74 65                	je     d40 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 cdb:	83 f8 73             	cmp    $0x73,%eax
 cde:	0f 84 8c 00 00 00    	je     d70 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 ce4:	83 f8 63             	cmp    $0x63,%eax
 ce7:	0f 84 13 01 00 00    	je     e00 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 ced:	83 f8 25             	cmp    $0x25,%eax
 cf0:	0f 84 e2 00 00 00    	je     dd8 <printf+0x188>
  write(fd, &c, 1);
 cf6:	b8 01 00 00 00       	mov    $0x1,%eax
 cfb:	46                   	inc    %esi
 cfc:	89 44 24 08          	mov    %eax,0x8(%esp)
 d00:	8d 45 e7             	lea    -0x19(%ebp),%eax
 d03:	89 44 24 04          	mov    %eax,0x4(%esp)
 d07:	89 3c 24             	mov    %edi,(%esp)
 d0a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 d0e:	e8 f5 fd ff ff       	call   b08 <write>
 d13:	ba 01 00 00 00       	mov    $0x1,%edx
 d18:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 d1b:	89 54 24 08          	mov    %edx,0x8(%esp)
 d1f:	89 44 24 04          	mov    %eax,0x4(%esp)
 d23:	89 3c 24             	mov    %edi,(%esp)
 d26:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 d29:	e8 da fd ff ff       	call   b08 <write>
  for(i = 0; fmt[i]; i++){
 d2e:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 d32:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 d34:	84 db                	test   %bl,%bl
 d36:	75 80                	jne    cb8 <printf+0x68>
    }
  }
}
 d38:	83 c4 3c             	add    $0x3c,%esp
 d3b:	5b                   	pop    %ebx
 d3c:	5e                   	pop    %esi
 d3d:	5f                   	pop    %edi
 d3e:	5d                   	pop    %ebp
 d3f:	c3                   	ret    
        printint(fd, *ap, 16, 0);
 d40:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 d47:	b9 10 00 00 00       	mov    $0x10,%ecx
 d4c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 d4f:	89 f8                	mov    %edi,%eax
 d51:	8b 13                	mov    (%ebx),%edx
 d53:	e8 58 fe ff ff       	call   bb0 <printint>
        ap++;
 d58:	89 d8                	mov    %ebx,%eax
      state = 0;
 d5a:	31 d2                	xor    %edx,%edx
        ap++;
 d5c:	83 c0 04             	add    $0x4,%eax
 d5f:	89 45 d0             	mov    %eax,-0x30(%ebp)
 d62:	e9 44 ff ff ff       	jmp    cab <printf+0x5b>
 d67:	89 f6                	mov    %esi,%esi
 d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
 d70:	8b 45 d0             	mov    -0x30(%ebp),%eax
 d73:	8b 10                	mov    (%eax),%edx
        ap++;
 d75:	83 c0 04             	add    $0x4,%eax
 d78:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 d7b:	85 d2                	test   %edx,%edx
 d7d:	0f 84 aa 00 00 00    	je     e2d <printf+0x1dd>
        while(*s != 0){
 d83:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
 d86:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
 d88:	84 c0                	test   %al,%al
 d8a:	74 27                	je     db3 <printf+0x163>
 d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 d90:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 d93:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 d98:	43                   	inc    %ebx
  write(fd, &c, 1);
 d99:	89 44 24 08          	mov    %eax,0x8(%esp)
 d9d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 da0:	89 44 24 04          	mov    %eax,0x4(%esp)
 da4:	89 3c 24             	mov    %edi,(%esp)
 da7:	e8 5c fd ff ff       	call   b08 <write>
        while(*s != 0){
 dac:	0f b6 03             	movzbl (%ebx),%eax
 daf:	84 c0                	test   %al,%al
 db1:	75 dd                	jne    d90 <printf+0x140>
      state = 0;
 db3:	31 d2                	xor    %edx,%edx
 db5:	e9 f1 fe ff ff       	jmp    cab <printf+0x5b>
 dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 dc0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 dc7:	b9 0a 00 00 00       	mov    $0xa,%ecx
 dcc:	e9 7b ff ff ff       	jmp    d4c <printf+0xfc>
 dd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 dd8:	b9 01 00 00 00       	mov    $0x1,%ecx
 ddd:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 de0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 de4:	89 44 24 04          	mov    %eax,0x4(%esp)
 de8:	89 3c 24             	mov    %edi,(%esp)
 deb:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 dee:	e8 15 fd ff ff       	call   b08 <write>
      state = 0;
 df3:	31 d2                	xor    %edx,%edx
 df5:	e9 b1 fe ff ff       	jmp    cab <printf+0x5b>
 dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
 e00:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 e03:	8b 03                	mov    (%ebx),%eax
        ap++;
 e05:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 e08:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
 e0b:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 e0e:	b8 01 00 00 00       	mov    $0x1,%eax
 e13:	89 44 24 08          	mov    %eax,0x8(%esp)
 e17:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 e1a:	89 44 24 04          	mov    %eax,0x4(%esp)
 e1e:	e8 e5 fc ff ff       	call   b08 <write>
      state = 0;
 e23:	31 d2                	xor    %edx,%edx
        ap++;
 e25:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 e28:	e9 7e fe ff ff       	jmp    cab <printf+0x5b>
          s = "(null)";
 e2d:	bb 98 11 00 00       	mov    $0x1198,%ebx
        while(*s != 0){
 e32:	b0 28                	mov    $0x28,%al
 e34:	e9 57 ff ff ff       	jmp    d90 <printf+0x140>
 e39:	66 90                	xchg   %ax,%ax
 e3b:	66 90                	xchg   %ax,%ax
 e3d:	66 90                	xchg   %ax,%ax
 e3f:	90                   	nop

00000e40 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 e40:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e41:	a1 68 15 00 00       	mov    0x1568,%eax
{
 e46:	89 e5                	mov    %esp,%ebp
 e48:	57                   	push   %edi
 e49:	56                   	push   %esi
 e4a:	53                   	push   %ebx
 e4b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 e4e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 e51:	eb 0d                	jmp    e60 <free+0x20>
 e53:	90                   	nop
 e54:	90                   	nop
 e55:	90                   	nop
 e56:	90                   	nop
 e57:	90                   	nop
 e58:	90                   	nop
 e59:	90                   	nop
 e5a:	90                   	nop
 e5b:	90                   	nop
 e5c:	90                   	nop
 e5d:	90                   	nop
 e5e:	90                   	nop
 e5f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e60:	39 c8                	cmp    %ecx,%eax
 e62:	8b 10                	mov    (%eax),%edx
 e64:	73 32                	jae    e98 <free+0x58>
 e66:	39 d1                	cmp    %edx,%ecx
 e68:	72 04                	jb     e6e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e6a:	39 d0                	cmp    %edx,%eax
 e6c:	72 32                	jb     ea0 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 e6e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 e71:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 e74:	39 fa                	cmp    %edi,%edx
 e76:	74 30                	je     ea8 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 e78:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 e7b:	8b 50 04             	mov    0x4(%eax),%edx
 e7e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 e81:	39 f1                	cmp    %esi,%ecx
 e83:	74 3c                	je     ec1 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 e85:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 e87:	5b                   	pop    %ebx
  freep = p;
 e88:	a3 68 15 00 00       	mov    %eax,0x1568
}
 e8d:	5e                   	pop    %esi
 e8e:	5f                   	pop    %edi
 e8f:	5d                   	pop    %ebp
 e90:	c3                   	ret    
 e91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e98:	39 d0                	cmp    %edx,%eax
 e9a:	72 04                	jb     ea0 <free+0x60>
 e9c:	39 d1                	cmp    %edx,%ecx
 e9e:	72 ce                	jb     e6e <free+0x2e>
{
 ea0:	89 d0                	mov    %edx,%eax
 ea2:	eb bc                	jmp    e60 <free+0x20>
 ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 ea8:	8b 7a 04             	mov    0x4(%edx),%edi
 eab:	01 fe                	add    %edi,%esi
 ead:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 eb0:	8b 10                	mov    (%eax),%edx
 eb2:	8b 12                	mov    (%edx),%edx
 eb4:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 eb7:	8b 50 04             	mov    0x4(%eax),%edx
 eba:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 ebd:	39 f1                	cmp    %esi,%ecx
 ebf:	75 c4                	jne    e85 <free+0x45>
    p->s.size += bp->s.size;
 ec1:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
 ec4:	a3 68 15 00 00       	mov    %eax,0x1568
    p->s.size += bp->s.size;
 ec9:	01 ca                	add    %ecx,%edx
 ecb:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 ece:	8b 53 f8             	mov    -0x8(%ebx),%edx
 ed1:	89 10                	mov    %edx,(%eax)
}
 ed3:	5b                   	pop    %ebx
 ed4:	5e                   	pop    %esi
 ed5:	5f                   	pop    %edi
 ed6:	5d                   	pop    %ebp
 ed7:	c3                   	ret    
 ed8:	90                   	nop
 ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000ee0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ee0:	55                   	push   %ebp
 ee1:	89 e5                	mov    %esp,%ebp
 ee3:	57                   	push   %edi
 ee4:	56                   	push   %esi
 ee5:	53                   	push   %ebx
 ee6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ee9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 eec:	8b 15 68 15 00 00    	mov    0x1568,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ef2:	8d 78 07             	lea    0x7(%eax),%edi
 ef5:	c1 ef 03             	shr    $0x3,%edi
 ef8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 ef9:	85 d2                	test   %edx,%edx
 efb:	0f 84 8f 00 00 00    	je     f90 <malloc+0xb0>
 f01:	8b 02                	mov    (%edx),%eax
 f03:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 f06:	39 cf                	cmp    %ecx,%edi
 f08:	76 66                	jbe    f70 <malloc+0x90>
 f0a:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 f10:	bb 00 10 00 00       	mov    $0x1000,%ebx
 f15:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 f18:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 f1f:	eb 10                	jmp    f31 <malloc+0x51>
 f21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 f28:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 f2a:	8b 48 04             	mov    0x4(%eax),%ecx
 f2d:	39 f9                	cmp    %edi,%ecx
 f2f:	73 3f                	jae    f70 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 f31:	39 05 68 15 00 00    	cmp    %eax,0x1568
 f37:	89 c2                	mov    %eax,%edx
 f39:	75 ed                	jne    f28 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 f3b:	89 34 24             	mov    %esi,(%esp)
 f3e:	e8 2d fc ff ff       	call   b70 <sbrk>
  if(p == (char*)-1)
 f43:	83 f8 ff             	cmp    $0xffffffff,%eax
 f46:	74 18                	je     f60 <malloc+0x80>
  hp->s.size = nu;
 f48:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 f4b:	83 c0 08             	add    $0x8,%eax
 f4e:	89 04 24             	mov    %eax,(%esp)
 f51:	e8 ea fe ff ff       	call   e40 <free>
  return freep;
 f56:	8b 15 68 15 00 00    	mov    0x1568,%edx
      if((p = morecore(nunits)) == 0)
 f5c:	85 d2                	test   %edx,%edx
 f5e:	75 c8                	jne    f28 <malloc+0x48>
        return 0;
  }
}
 f60:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 f63:	31 c0                	xor    %eax,%eax
}
 f65:	5b                   	pop    %ebx
 f66:	5e                   	pop    %esi
 f67:	5f                   	pop    %edi
 f68:	5d                   	pop    %ebp
 f69:	c3                   	ret    
 f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 f70:	39 cf                	cmp    %ecx,%edi
 f72:	74 4c                	je     fc0 <malloc+0xe0>
        p->s.size -= nunits;
 f74:	29 f9                	sub    %edi,%ecx
 f76:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 f79:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 f7c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 f7f:	89 15 68 15 00 00    	mov    %edx,0x1568
}
 f85:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 f88:	83 c0 08             	add    $0x8,%eax
}
 f8b:	5b                   	pop    %ebx
 f8c:	5e                   	pop    %esi
 f8d:	5f                   	pop    %edi
 f8e:	5d                   	pop    %ebp
 f8f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 f90:	b8 6c 15 00 00       	mov    $0x156c,%eax
 f95:	ba 6c 15 00 00       	mov    $0x156c,%edx
    base.s.size = 0;
 f9a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
 f9c:	a3 68 15 00 00       	mov    %eax,0x1568
    base.s.size = 0;
 fa1:	b8 6c 15 00 00       	mov    $0x156c,%eax
    base.s.ptr = freep = prevp = &base;
 fa6:	89 15 6c 15 00 00    	mov    %edx,0x156c
    base.s.size = 0;
 fac:	89 0d 70 15 00 00    	mov    %ecx,0x1570
 fb2:	e9 53 ff ff ff       	jmp    f0a <malloc+0x2a>
 fb7:	89 f6                	mov    %esi,%esi
 fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
 fc0:	8b 08                	mov    (%eax),%ecx
 fc2:	89 0a                	mov    %ecx,(%edx)
 fc4:	eb b9                	jmp    f7f <malloc+0x9f>
