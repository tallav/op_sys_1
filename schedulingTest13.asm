
_schedulingTest13:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

struct perf childPerfs[NUM_OF_CHILDS];

struct perf perf_temp;

int main(int argc, char *argv[]){  
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	56                   	push   %esi
    policy(1);

    printf(1,"Initiating scheduling test, test should take approximately 10000 time quantums !!!\n");
    
    childPids[0] = executeForever(0,0,"childPid0");
       4:	be b5 11 00 00       	mov    $0x11b5,%esi
int main(int argc, char *argv[]){  
       9:	53                   	push   %ebx
    printf(1,"Initiating scheduling test, test should take approximately 10000 time quantums !!!\n");
       a:	bb e8 15 00 00       	mov    $0x15e8,%ebx
int main(int argc, char *argv[]){  
       f:	83 e4 f0             	and    $0xfffffff0,%esp
      12:	83 ec 10             	sub    $0x10,%esp
    policy(1);
      15:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      1c:	e8 57 0d 00 00       	call   d78 <policy>
    printf(1,"Initiating scheduling test, test should take approximately 10000 time quantums !!!\n");
      21:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    childPids[1] = executeForever(0,0,"childPid1");

    childPids[2] = executeTimes(10,100,0,"childPid2");
    childPids[3] = executeTimes(10,300,0,"childPid3");
      25:	bb 2c 01 00 00       	mov    $0x12c,%ebx
    printf(1,"Initiating scheduling test, test should take approximately 10000 time quantums !!!\n");
      2a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      31:	e8 fa 0d 00 00       	call   e30 <printf>
    childPids[0] = executeForever(0,0,"childPid0");
      36:	31 c0                	xor    %eax,%eax
      38:	89 74 24 08          	mov    %esi,0x8(%esp)
    childPids[4] = executeTimes(10,500,0,"childPid4");
      3c:	be dd 11 00 00       	mov    $0x11dd,%esi
    childPids[0] = executeForever(0,0,"childPid0");
      41:	89 44 24 04          	mov    %eax,0x4(%esp)
      45:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      4c:	e8 7f 07 00 00       	call   7d0 <executeForever>
    childPids[1] = executeForever(0,0,"childPid1");
      51:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    childPids[0] = executeForever(0,0,"childPid0");
      58:	a3 40 1a 00 00       	mov    %eax,0x1a40
    childPids[1] = executeForever(0,0,"childPid1");
      5d:	b8 bf 11 00 00       	mov    $0x11bf,%eax
      62:	89 44 24 08          	mov    %eax,0x8(%esp)
      66:	31 c0                	xor    %eax,%eax
      68:	89 44 24 04          	mov    %eax,0x4(%esp)
      6c:	e8 5f 07 00 00       	call   7d0 <executeForever>
    childPids[2] = executeTimes(10,100,0,"childPid2");
      71:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
    childPids[1] = executeForever(0,0,"childPid1");
      78:	a3 44 1a 00 00       	mov    %eax,0x1a44
    childPids[2] = executeTimes(10,100,0,"childPid2");
      7d:	b8 c9 11 00 00       	mov    $0x11c9,%eax
      82:	89 44 24 0c          	mov    %eax,0xc(%esp)
      86:	31 c0                	xor    %eax,%eax
      88:	89 44 24 08          	mov    %eax,0x8(%esp)
      8c:	b8 64 00 00 00       	mov    $0x64,%eax
      91:	89 44 24 04          	mov    %eax,0x4(%esp)
      95:	e8 96 07 00 00       	call   830 <executeTimes>
    childPids[3] = executeTimes(10,300,0,"childPid3");
      9a:	31 c9                	xor    %ecx,%ecx
      9c:	ba d3 11 00 00       	mov    $0x11d3,%edx
      a1:	89 54 24 0c          	mov    %edx,0xc(%esp)
      a5:	89 4c 24 08          	mov    %ecx,0x8(%esp)
      a9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      ad:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
    childPids[2] = executeTimes(10,100,0,"childPid2");
      b4:	a3 48 1a 00 00       	mov    %eax,0x1a48
    childPids[3] = executeTimes(10,300,0,"childPid3");
      b9:	e8 72 07 00 00       	call   830 <executeTimes>
    childPids[4] = executeTimes(10,500,0,"childPid4");
      be:	89 74 24 0c          	mov    %esi,0xc(%esp)
      c2:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
    childPids[3] = executeTimes(10,300,0,"childPid3");
      c9:	a3 4c 1a 00 00       	mov    %eax,0x1a4c
    childPids[4] = executeTimes(10,500,0,"childPid4");
      ce:	31 c0                	xor    %eax,%eax
      d0:	89 44 24 08          	mov    %eax,0x8(%esp)
      d4:	b8 f4 01 00 00       	mov    $0x1f4,%eax
      d9:	89 44 24 04          	mov    %eax,0x4(%esp)
      dd:	e8 4e 07 00 00       	call   830 <executeTimes>
    childPids[5] = executeTimes(10,700,0,"childPid5");
      e2:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
    childPids[4] = executeTimes(10,500,0,"childPid4");
      e9:	a3 50 1a 00 00       	mov    %eax,0x1a50
    childPids[5] = executeTimes(10,700,0,"childPid5");
      ee:	b8 e7 11 00 00       	mov    $0x11e7,%eax
      f3:	89 44 24 0c          	mov    %eax,0xc(%esp)
      f7:	31 c0                	xor    %eax,%eax
      f9:	89 44 24 08          	mov    %eax,0x8(%esp)
      fd:	b8 bc 02 00 00       	mov    $0x2bc,%eax
     102:	89 44 24 04          	mov    %eax,0x4(%esp)
     106:	e8 25 07 00 00       	call   830 <executeTimes>
    childPids[6] = executeTimes(10,900,0,"childPid6");
     10b:	31 d2                	xor    %edx,%edx
     10d:	b9 84 03 00 00       	mov    $0x384,%ecx
     112:	89 54 24 08          	mov    %edx,0x8(%esp)
     116:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     11a:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
    childPids[5] = executeTimes(10,700,0,"childPid5");
     121:	a3 54 1a 00 00       	mov    %eax,0x1a54
    childPids[6] = executeTimes(10,900,0,"childPid6");
     126:	b8 f1 11 00 00       	mov    $0x11f1,%eax
     12b:	89 44 24 0c          	mov    %eax,0xc(%esp)
     12f:	e8 fc 06 00 00       	call   830 <executeTimes>
    
     for(int i = 0;i < numOfNotForeverChilds;i++){
     134:	8b 1d 00 1a 00 00    	mov    0x1a00,%ebx
     13a:	85 db                	test   %ebx,%ebx
    childPids[6] = executeTimes(10,900,0,"childPid6");
     13c:	a3 58 1a 00 00       	mov    %eax,0x1a58
     for(int i = 0;i < numOfNotForeverChilds;i++){
     141:	7e 1b                	jle    15e <main+0x15e>
     143:	31 db                	xor    %ebx,%ebx
     145:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     150:	43                   	inc    %ebx
         retrieveNextChildPerf();
     151:	e8 7a 07 00 00       	call   8d0 <retrieveNextChildPerf>
     for(int i = 0;i < numOfNotForeverChilds;i++){
     156:	39 1d 00 1a 00 00    	cmp    %ebx,0x1a00
     15c:	7f f2                	jg     150 <main+0x150>
     }

    kill(childPids[0]);
     15e:	a1 40 1a 00 00       	mov    0x1a40,%eax
     163:	89 04 24             	mov    %eax,(%esp)
     166:	e8 8d 0b 00 00       	call   cf8 <kill>
    kill(childPids[1]);
     16b:	a1 44 1a 00 00       	mov    0x1a44,%eax
     170:	89 04 24             	mov    %eax,(%esp)
     173:	e8 80 0b 00 00       	call   cf8 <kill>
    
   for(int i = 0;i < (NUM_OF_CHILDS - numOfNotForeverChilds);i++){
     178:	8b 0d 00 1a 00 00    	mov    0x1a00,%ecx
     17e:	b8 07 00 00 00       	mov    $0x7,%eax
     183:	29 c8                	sub    %ecx,%eax
     185:	85 c0                	test   %eax,%eax
     187:	7e 1b                	jle    1a4 <main+0x1a4>
     189:	31 db                	xor    %ebx,%ebx
     18b:	be 07 00 00 00       	mov    $0x7,%esi
         retrieveNextChildPerf();
     190:	e8 3b 07 00 00       	call   8d0 <retrieveNextChildPerf>
   for(int i = 0;i < (NUM_OF_CHILDS - numOfNotForeverChilds);i++){
     195:	8b 15 00 1a 00 00    	mov    0x1a00,%edx
     19b:	89 f0                	mov    %esi,%eax
     19d:	43                   	inc    %ebx
     19e:	29 d0                	sub    %edx,%eax
     1a0:	39 d8                	cmp    %ebx,%eax
     1a2:	7f ec                	jg     190 <main+0x190>
     }

    if(childPerfs[1].ctime < childPerfs[0].ctime){
     1a4:	a1 80 1a 00 00       	mov    0x1a80,%eax
     1a9:	39 05 94 1a 00 00    	cmp    %eax,0x1a94
     1af:	0f 8d ee 03 00 00    	jge    5a3 <main+0x5a3>
        printf(1,"error in ctime test 1\n");
     1b5:	c7 44 24 04 fb 11 00 	movl   $0x11fb,0x4(%esp)
     1bc:	00 
     1bd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1c4:	e8 67 0c 00 00       	call   e30 <printf>
    }
    else{
        printf(1,"ctime test 1 ok\n");
    }

    if(childPerfs[2].ctime < childPerfs[1].ctime){
     1c9:	a1 94 1a 00 00       	mov    0x1a94,%eax
     1ce:	39 05 a8 1a 00 00    	cmp    %eax,0x1aa8
     1d4:	0f 8d ba 05 00 00    	jge    794 <main+0x794>
        printf(1,"error in ctime test 2\n");
     1da:	c7 44 24 04 23 12 00 	movl   $0x1223,0x4(%esp)
     1e1:	00 
     1e2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1e9:	e8 42 0c 00 00       	call   e30 <printf>
    }
    else{
        printf(1,"ctime test 2 ok\n");
    }

    if(childPerfs[3].ctime < childPerfs[2].ctime){
     1ee:	a1 a8 1a 00 00       	mov    0x1aa8,%eax
     1f3:	39 05 bc 1a 00 00    	cmp    %eax,0x1abc
     1f9:	0f 8d 7c 05 00 00    	jge    77b <main+0x77b>
        printf(1,"error in ctime test 3\n");
     1ff:	c7 44 24 04 4b 12 00 	movl   $0x124b,0x4(%esp)
     206:	00 
     207:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     20e:	e8 1d 0c 00 00       	call   e30 <printf>
    }
    else{
        printf(1,"ctime test 3 ok\n");
    }

    if(childPerfs[4].ctime < childPerfs[3].ctime){
     213:	a1 bc 1a 00 00       	mov    0x1abc,%eax
     218:	39 05 d0 1a 00 00    	cmp    %eax,0x1ad0
     21e:	0f 8d 3e 05 00 00    	jge    762 <main+0x762>
        printf(1,"error in ctime test 4\n");
     224:	c7 44 24 04 73 12 00 	movl   $0x1273,0x4(%esp)
     22b:	00 
     22c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     233:	e8 f8 0b 00 00       	call   e30 <printf>
    }
    else{
        printf(1,"ctime test 4 ok\n");
    }

    if(childPerfs[6].ctime < childPerfs[5].ctime){
     238:	a1 e4 1a 00 00       	mov    0x1ae4,%eax
     23d:	39 05 f8 1a 00 00    	cmp    %eax,0x1af8
     243:	0f 8d 00 05 00 00    	jge    749 <main+0x749>
        printf(1,"error in ctime test 5\n");
     249:	c7 44 24 04 9b 12 00 	movl   $0x129b,0x4(%esp)
     250:	00 
     251:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     258:	e8 d3 0b 00 00       	call   e30 <printf>


    
    // ------------------------------------------------------------------------------------------------------------------------

    if(childPerfs[1].stime != childPerfs[0].stime){
     25d:	a1 88 1a 00 00       	mov    0x1a88,%eax
     262:	39 05 9c 1a 00 00    	cmp    %eax,0x1a9c
     268:	0f 84 3f 05 00 00    	je     7ad <main+0x7ad>
        printf(1,"error in stime test 1\n");
     26e:	c7 44 24 04 c3 12 00 	movl   $0x12c3,0x4(%esp)
     275:	00 
     276:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     27d:	e8 ae 0b 00 00       	call   e30 <printf>
    }
    else{
        printf(1,"stime test 1 ok\n");
    }

    if(childPerfs[2].stime < childPerfs[1].stime){
     282:	a1 9c 1a 00 00       	mov    0x1a9c,%eax
     287:	39 05 b0 1a 00 00    	cmp    %eax,0x1ab0
     28d:	0f 8d 9d 04 00 00    	jge    730 <main+0x730>
        printf(1,"error in stime test 2\n");
     293:	c7 44 24 04 eb 12 00 	movl   $0x12eb,0x4(%esp)
     29a:	00 
     29b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     2a2:	e8 89 0b 00 00       	call   e30 <printf>
    }
    else{
        printf(1,"stime test 2 ok\n");
    }

    if(childPerfs[3].stime < childPerfs[2].stime){
     2a7:	a1 b0 1a 00 00       	mov    0x1ab0,%eax
     2ac:	39 05 c4 1a 00 00    	cmp    %eax,0x1ac4
     2b2:	0f 8d 5f 04 00 00    	jge    717 <main+0x717>
        printf(1,"error in stime test 3\n");
     2b8:	c7 44 24 04 13 13 00 	movl   $0x1313,0x4(%esp)
     2bf:	00 
     2c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     2c7:	e8 64 0b 00 00       	call   e30 <printf>
    }
    else{
        printf(1,"stime test 3 ok\n");
    }

    if(childPerfs[4].stime < childPerfs[3].stime){
     2cc:	a1 c4 1a 00 00       	mov    0x1ac4,%eax
     2d1:	39 05 d8 1a 00 00    	cmp    %eax,0x1ad8
     2d7:	0f 8d 21 04 00 00    	jge    6fe <main+0x6fe>
        printf(1,"error in stime test 4\n");
     2dd:	c7 44 24 04 3b 13 00 	movl   $0x133b,0x4(%esp)
     2e4:	00 
     2e5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     2ec:	e8 3f 0b 00 00       	call   e30 <printf>
    }
    else{
        printf(1,"stime test 4 ok\n");
    }

    if(childPerfs[6].stime < childPerfs[5].stime){
     2f1:	a1 ec 1a 00 00       	mov    0x1aec,%eax
     2f6:	39 05 00 1b 00 00    	cmp    %eax,0x1b00
     2fc:	0f 8d e3 03 00 00    	jge    6e5 <main+0x6e5>
        printf(1,"error in stime test 5\n");
     302:	c7 44 24 04 63 13 00 	movl   $0x1363,0x4(%esp)
     309:	00 
     30a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     311:	e8 1a 0b 00 00       	call   e30 <printf>


    
    // ------------------------------------------------------------------------------------------------------------------------

    if(childPerfs[0].rutime < childPerfs[2].rutime){
     316:	a1 b8 1a 00 00       	mov    0x1ab8,%eax
     31b:	39 05 90 1a 00 00    	cmp    %eax,0x1a90
     321:	0f 8d a5 03 00 00    	jge    6cc <main+0x6cc>
        printf(1,"error in rutime test 1\n");
     327:	c7 44 24 04 8b 13 00 	movl   $0x138b,0x4(%esp)
     32e:	00 
     32f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     336:	e8 f5 0a 00 00       	call   e30 <printf>
    }
    else{
        printf(1,"rutime test 1 ok\n");
    }

    if(childPerfs[0].rutime < childPerfs[3].rutime){
     33b:	a1 cc 1a 00 00       	mov    0x1acc,%eax
     340:	39 05 90 1a 00 00    	cmp    %eax,0x1a90
     346:	0f 8d 67 03 00 00    	jge    6b3 <main+0x6b3>
        printf(1,"error in rutime test 2\n");
     34c:	c7 44 24 04 b5 13 00 	movl   $0x13b5,0x4(%esp)
     353:	00 
     354:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     35b:	e8 d0 0a 00 00       	call   e30 <printf>
    }
    else{
        printf(1,"rutime test 2 ok\n");
    }

    if(childPerfs[0].rutime < childPerfs[4].rutime){
     360:	a1 e0 1a 00 00       	mov    0x1ae0,%eax
     365:	39 05 90 1a 00 00    	cmp    %eax,0x1a90
     36b:	0f 8d 29 03 00 00    	jge    69a <main+0x69a>
        printf(1,"error in rutime test 3\n");
     371:	c7 44 24 04 df 13 00 	movl   $0x13df,0x4(%esp)
     378:	00 
     379:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     380:	e8 ab 0a 00 00       	call   e30 <printf>
    }
    else{
        printf(1,"rutime test 3 ok\n");
    }

    if(childPerfs[0].rutime < childPerfs[5].rutime){
     385:	a1 f4 1a 00 00       	mov    0x1af4,%eax
     38a:	39 05 90 1a 00 00    	cmp    %eax,0x1a90
     390:	0f 8d eb 02 00 00    	jge    681 <main+0x681>
        printf(1,"error in rutime test 4\n");
     396:	c7 44 24 04 09 14 00 	movl   $0x1409,0x4(%esp)
     39d:	00 
     39e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     3a5:	e8 86 0a 00 00       	call   e30 <printf>
    }
    else{
        printf(1,"rutime test 4 ok\n");
    }

    if(childPerfs[0].rutime  < childPerfs[6].rutime){
     3aa:	a1 08 1b 00 00       	mov    0x1b08,%eax
     3af:	39 05 90 1a 00 00    	cmp    %eax,0x1a90
     3b5:	0f 8d ad 02 00 00    	jge    668 <main+0x668>
        printf(1,"error in rutime test 5\n");
     3bb:	c7 44 24 04 33 14 00 	movl   $0x1433,0x4(%esp)
     3c2:	00 
     3c3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     3ca:	e8 61 0a 00 00       	call   e30 <printf>


    
    // ------------------------------------------------------------------------------------------------------------------------

    if((childPerfs[0].rutime + childPerfs[0].retime + childPerfs[0].stime) > (childPerfs[0].ttime - childPerfs[0].ctime + 20)){
     3cf:	8b 15 8c 1a 00 00    	mov    0x1a8c,%edx
     3d5:	8b 1d 90 1a 00 00    	mov    0x1a90,%ebx
     3db:	a1 84 1a 00 00       	mov    0x1a84,%eax
     3e0:	8b 0d 80 1a 00 00    	mov    0x1a80,%ecx
     3e6:	8b 35 88 1a 00 00    	mov    0x1a88,%esi
     3ec:	01 da                	add    %ebx,%edx
     3ee:	29 c8                	sub    %ecx,%eax
     3f0:	01 f2                	add    %esi,%edx
     3f2:	83 c0 14             	add    $0x14,%eax
     3f5:	39 c2                	cmp    %eax,%edx
     3f7:	0f 8e 52 02 00 00    	jle    64f <main+0x64f>
        printf(1,"error in ttime test 1\n");
     3fd:	c7 44 24 04 5d 14 00 	movl   $0x145d,0x4(%esp)
     404:	00 
     405:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     40c:	e8 1f 0a 00 00       	call   e30 <printf>
    }
    else{
        printf(1,"ttime test 1 ok\n");
    }

    if((childPerfs[1].rutime + childPerfs[1].retime + childPerfs[1].stime) > (childPerfs[1].ttime - childPerfs[1].ctime + 20)){
     411:	8b 15 a0 1a 00 00    	mov    0x1aa0,%edx
     417:	8b 1d a4 1a 00 00    	mov    0x1aa4,%ebx
     41d:	a1 98 1a 00 00       	mov    0x1a98,%eax
     422:	8b 0d 94 1a 00 00    	mov    0x1a94,%ecx
     428:	8b 35 9c 1a 00 00    	mov    0x1a9c,%esi
     42e:	01 da                	add    %ebx,%edx
     430:	29 c8                	sub    %ecx,%eax
     432:	01 f2                	add    %esi,%edx
     434:	83 c0 14             	add    $0x14,%eax
     437:	39 c2                	cmp    %eax,%edx
     439:	0f 8e f7 01 00 00    	jle    636 <main+0x636>
        printf(1,"error in ttime test 2\n");
     43f:	c7 44 24 04 85 14 00 	movl   $0x1485,0x4(%esp)
     446:	00 
     447:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     44e:	e8 dd 09 00 00       	call   e30 <printf>
    }
    else{
        printf(1,"ttime test 2 ok\n");
    }

    if((childPerfs[2].rutime + childPerfs[2].retime + childPerfs[2].stime) > (childPerfs[2].ttime - childPerfs[2].ctime + 20)){
     453:	8b 15 b4 1a 00 00    	mov    0x1ab4,%edx
     459:	8b 1d b8 1a 00 00    	mov    0x1ab8,%ebx
     45f:	a1 ac 1a 00 00       	mov    0x1aac,%eax
     464:	8b 0d a8 1a 00 00    	mov    0x1aa8,%ecx
     46a:	8b 35 b0 1a 00 00    	mov    0x1ab0,%esi
     470:	01 da                	add    %ebx,%edx
     472:	29 c8                	sub    %ecx,%eax
     474:	01 f2                	add    %esi,%edx
     476:	83 c0 14             	add    $0x14,%eax
     479:	39 c2                	cmp    %eax,%edx
     47b:	0f 8e 9c 01 00 00    	jle    61d <main+0x61d>
        printf(1,"error in ttime test 3\n");
     481:	c7 44 24 04 ad 14 00 	movl   $0x14ad,0x4(%esp)
     488:	00 
     489:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     490:	e8 9b 09 00 00       	call   e30 <printf>
    }
    else{
        printf(1,"ttime test 3 ok\n");
    }

    if((childPerfs[3].rutime + childPerfs[3].retime + childPerfs[3].stime) > (childPerfs[3].ttime - childPerfs[3].ctime + 20)){
     495:	8b 15 c8 1a 00 00    	mov    0x1ac8,%edx
     49b:	8b 1d cc 1a 00 00    	mov    0x1acc,%ebx
     4a1:	a1 c0 1a 00 00       	mov    0x1ac0,%eax
     4a6:	8b 0d bc 1a 00 00    	mov    0x1abc,%ecx
     4ac:	8b 35 c4 1a 00 00    	mov    0x1ac4,%esi
     4b2:	01 da                	add    %ebx,%edx
     4b4:	29 c8                	sub    %ecx,%eax
     4b6:	01 f2                	add    %esi,%edx
     4b8:	83 c0 14             	add    $0x14,%eax
     4bb:	39 c2                	cmp    %eax,%edx
     4bd:	0f 8e 41 01 00 00    	jle    604 <main+0x604>
        printf(1,"error in ttime test 4\n");
     4c3:	c7 44 24 04 d5 14 00 	movl   $0x14d5,0x4(%esp)
     4ca:	00 
     4cb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     4d2:	e8 59 09 00 00       	call   e30 <printf>
    }
    else{
        printf(1,"ttime test 4 ok\n");
    }

    if((childPerfs[4].rutime + childPerfs[4].retime + childPerfs[4].stime) > (childPerfs[4].ttime - childPerfs[4].ctime + 20)){
     4d7:	8b 15 dc 1a 00 00    	mov    0x1adc,%edx
     4dd:	8b 1d e0 1a 00 00    	mov    0x1ae0,%ebx
     4e3:	a1 d4 1a 00 00       	mov    0x1ad4,%eax
     4e8:	8b 0d d0 1a 00 00    	mov    0x1ad0,%ecx
     4ee:	8b 35 d8 1a 00 00    	mov    0x1ad8,%esi
     4f4:	01 da                	add    %ebx,%edx
     4f6:	29 c8                	sub    %ecx,%eax
     4f8:	01 f2                	add    %esi,%edx
     4fa:	83 c0 14             	add    $0x14,%eax
     4fd:	39 c2                	cmp    %eax,%edx
     4ff:	0f 8e e6 00 00 00    	jle    5eb <main+0x5eb>
        printf(1,"error in ttime test 5\n");
     505:	c7 44 24 04 fd 14 00 	movl   $0x14fd,0x4(%esp)
     50c:	00 
     50d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     514:	e8 17 09 00 00       	call   e30 <printf>
    }
    else{
        printf(1,"ttime test 5 ok\n");
    }
    
    if((childPerfs[5].rutime + childPerfs[5].retime + childPerfs[5].stime) > (childPerfs[5].ttime - childPerfs[5].ctime + 20)){
     519:	8b 15 f0 1a 00 00    	mov    0x1af0,%edx
     51f:	8b 35 f4 1a 00 00    	mov    0x1af4,%esi
     525:	a1 ec 1a 00 00       	mov    0x1aec,%eax
     52a:	8b 0d e4 1a 00 00    	mov    0x1ae4,%ecx
     530:	01 f2                	add    %esi,%edx
     532:	01 c2                	add    %eax,%edx
     534:	a1 e8 1a 00 00       	mov    0x1ae8,%eax
     539:	29 c8                	sub    %ecx,%eax
     53b:	83 c0 14             	add    $0x14,%eax
     53e:	39 c2                	cmp    %eax,%edx
     540:	0f 8e 8c 00 00 00    	jle    5d2 <main+0x5d2>
        printf(1,"error in ttime test 6\n");
     546:	c7 44 24 04 25 15 00 	movl   $0x1525,0x4(%esp)
     54d:	00 
     54e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     555:	e8 d6 08 00 00       	call   e30 <printf>
    }
    else{
        printf(1,"ttime test 6 ok\n");
    }

    if((childPerfs[6].rutime + childPerfs[6].retime + childPerfs[6].stime) > (childPerfs[6].ttime - childPerfs[6].ctime + 20)){
     55a:	a1 08 1b 00 00       	mov    0x1b08,%eax
     55f:	8b 15 04 1b 00 00    	mov    0x1b04,%edx
     565:	8b 1d f8 1a 00 00    	mov    0x1af8,%ebx
     56b:	8b 0d 00 1b 00 00    	mov    0x1b00,%ecx
     571:	01 c2                	add    %eax,%edx
     573:	a1 fc 1a 00 00       	mov    0x1afc,%eax
     578:	01 ca                	add    %ecx,%edx
     57a:	29 d8                	sub    %ebx,%eax
     57c:	83 c0 14             	add    $0x14,%eax
     57f:	39 c2                	cmp    %eax,%edx
     581:	7e 39                	jle    5bc <main+0x5bc>
        printf(1,"error in ttime test 7\n");
     583:	c7 44 24 04 4d 15 00 	movl   $0x154d,0x4(%esp)
     58a:	00 
     58b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     592:	e8 99 08 00 00       	call   e30 <printf>
    else{
        printf(1,"ttime test 7 ok\n");

    }

    exit(0);
     597:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     59e:	e8 25 07 00 00       	call   cc8 <exit>
        printf(1,"ctime test 1 ok\n");
     5a3:	c7 44 24 04 12 12 00 	movl   $0x1212,0x4(%esp)
     5aa:	00 
     5ab:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     5b2:	e8 79 08 00 00       	call   e30 <printf>
     5b7:	e9 0d fc ff ff       	jmp    1c9 <main+0x1c9>
        printf(1,"ttime test 7 ok\n");
     5bc:	c7 44 24 04 64 15 00 	movl   $0x1564,0x4(%esp)
     5c3:	00 
     5c4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     5cb:	e8 60 08 00 00       	call   e30 <printf>
     5d0:	eb c5                	jmp    597 <main+0x597>
        printf(1,"ttime test 6 ok\n");
     5d2:	c7 44 24 04 3c 15 00 	movl   $0x153c,0x4(%esp)
     5d9:	00 
     5da:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     5e1:	e8 4a 08 00 00       	call   e30 <printf>
     5e6:	e9 6f ff ff ff       	jmp    55a <main+0x55a>
        printf(1,"ttime test 5 ok\n");
     5eb:	c7 44 24 04 14 15 00 	movl   $0x1514,0x4(%esp)
     5f2:	00 
     5f3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     5fa:	e8 31 08 00 00       	call   e30 <printf>
     5ff:	e9 15 ff ff ff       	jmp    519 <main+0x519>
        printf(1,"ttime test 4 ok\n");
     604:	c7 44 24 04 ec 14 00 	movl   $0x14ec,0x4(%esp)
     60b:	00 
     60c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     613:	e8 18 08 00 00       	call   e30 <printf>
     618:	e9 ba fe ff ff       	jmp    4d7 <main+0x4d7>
        printf(1,"ttime test 3 ok\n");
     61d:	c7 44 24 04 c4 14 00 	movl   $0x14c4,0x4(%esp)
     624:	00 
     625:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     62c:	e8 ff 07 00 00       	call   e30 <printf>
     631:	e9 5f fe ff ff       	jmp    495 <main+0x495>
        printf(1,"ttime test 2 ok\n");
     636:	c7 44 24 04 9c 14 00 	movl   $0x149c,0x4(%esp)
     63d:	00 
     63e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     645:	e8 e6 07 00 00       	call   e30 <printf>
     64a:	e9 04 fe ff ff       	jmp    453 <main+0x453>
        printf(1,"ttime test 1 ok\n");
     64f:	c7 44 24 04 74 14 00 	movl   $0x1474,0x4(%esp)
     656:	00 
     657:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     65e:	e8 cd 07 00 00       	call   e30 <printf>
     663:	e9 a9 fd ff ff       	jmp    411 <main+0x411>
        printf(1,"rutime test 5 ok\n");
     668:	c7 44 24 04 4b 14 00 	movl   $0x144b,0x4(%esp)
     66f:	00 
     670:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     677:	e8 b4 07 00 00       	call   e30 <printf>
     67c:	e9 4e fd ff ff       	jmp    3cf <main+0x3cf>
        printf(1,"rutime test 4 ok\n");
     681:	c7 44 24 04 21 14 00 	movl   $0x1421,0x4(%esp)
     688:	00 
     689:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     690:	e8 9b 07 00 00       	call   e30 <printf>
     695:	e9 10 fd ff ff       	jmp    3aa <main+0x3aa>
        printf(1,"rutime test 3 ok\n");
     69a:	c7 44 24 04 f7 13 00 	movl   $0x13f7,0x4(%esp)
     6a1:	00 
     6a2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     6a9:	e8 82 07 00 00       	call   e30 <printf>
     6ae:	e9 d2 fc ff ff       	jmp    385 <main+0x385>
        printf(1,"rutime test 2 ok\n");
     6b3:	c7 44 24 04 cd 13 00 	movl   $0x13cd,0x4(%esp)
     6ba:	00 
     6bb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     6c2:	e8 69 07 00 00       	call   e30 <printf>
     6c7:	e9 94 fc ff ff       	jmp    360 <main+0x360>
        printf(1,"rutime test 1 ok\n");
     6cc:	c7 44 24 04 a3 13 00 	movl   $0x13a3,0x4(%esp)
     6d3:	00 
     6d4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     6db:	e8 50 07 00 00       	call   e30 <printf>
     6e0:	e9 56 fc ff ff       	jmp    33b <main+0x33b>
        printf(1,"stime test 5 ok\n");
     6e5:	c7 44 24 04 7a 13 00 	movl   $0x137a,0x4(%esp)
     6ec:	00 
     6ed:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     6f4:	e8 37 07 00 00       	call   e30 <printf>
     6f9:	e9 18 fc ff ff       	jmp    316 <main+0x316>
        printf(1,"stime test 4 ok\n");
     6fe:	c7 44 24 04 52 13 00 	movl   $0x1352,0x4(%esp)
     705:	00 
     706:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     70d:	e8 1e 07 00 00       	call   e30 <printf>
     712:	e9 da fb ff ff       	jmp    2f1 <main+0x2f1>
        printf(1,"stime test 3 ok\n");
     717:	c7 44 24 04 2a 13 00 	movl   $0x132a,0x4(%esp)
     71e:	00 
     71f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     726:	e8 05 07 00 00       	call   e30 <printf>
     72b:	e9 9c fb ff ff       	jmp    2cc <main+0x2cc>
        printf(1,"stime test 2 ok\n");
     730:	c7 44 24 04 02 13 00 	movl   $0x1302,0x4(%esp)
     737:	00 
     738:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     73f:	e8 ec 06 00 00       	call   e30 <printf>
     744:	e9 5e fb ff ff       	jmp    2a7 <main+0x2a7>
        printf(1,"ctime test 5 ok\n");
     749:	c7 44 24 04 b2 12 00 	movl   $0x12b2,0x4(%esp)
     750:	00 
     751:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     758:	e8 d3 06 00 00       	call   e30 <printf>
     75d:	e9 fb fa ff ff       	jmp    25d <main+0x25d>
        printf(1,"ctime test 4 ok\n");
     762:	c7 44 24 04 8a 12 00 	movl   $0x128a,0x4(%esp)
     769:	00 
     76a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     771:	e8 ba 06 00 00       	call   e30 <printf>
     776:	e9 bd fa ff ff       	jmp    238 <main+0x238>
        printf(1,"ctime test 3 ok\n");
     77b:	c7 44 24 04 62 12 00 	movl   $0x1262,0x4(%esp)
     782:	00 
     783:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     78a:	e8 a1 06 00 00       	call   e30 <printf>
     78f:	e9 7f fa ff ff       	jmp    213 <main+0x213>
        printf(1,"ctime test 2 ok\n");
     794:	c7 44 24 04 3a 12 00 	movl   $0x123a,0x4(%esp)
     79b:	00 
     79c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     7a3:	e8 88 06 00 00       	call   e30 <printf>
     7a8:	e9 41 fa ff ff       	jmp    1ee <main+0x1ee>
        printf(1,"stime test 1 ok\n");
     7ad:	c7 44 24 04 da 12 00 	movl   $0x12da,0x4(%esp)
     7b4:	00 
     7b5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     7bc:	e8 6f 06 00 00       	call   e30 <printf>
     7c1:	e9 bc fa ff ff       	jmp    282 <main+0x282>
     7c6:	66 90                	xchg   %ax,%ax
     7c8:	66 90                	xchg   %ax,%ax
     7ca:	66 90                	xchg   %ax,%ax
     7cc:	66 90                	xchg   %ax,%ax
     7ce:	66 90                	xchg   %ax,%ax

000007d0 <executeForever>:
}


int executeForever(int timeToSleep,int isDetach,char* debugString){
     7d0:	55                   	push   %ebp
     7d1:	89 e5                	mov    %esp,%ebp
     7d3:	56                   	push   %esi
     7d4:	53                   	push   %ebx
     7d5:	83 ec 10             	sub    $0x10,%esp
     7d8:	8b 5d 08             	mov    0x8(%ebp),%ebx
    int pid;

    if((pid = fork()) == 0){
     7db:	e8 e0 04 00 00       	call   cc0 <fork>
     7e0:	83 f8 00             	cmp    $0x0,%eax
     7e3:	74 2b                	je     810 <executeForever+0x40>
            printf(1," ending...\n");
        }

        exit(0);
    }
    else if(pid > 0){
     7e5:	7e 2f                	jle    816 <executeForever+0x46>
        if(isDetach){
     7e7:	8b 55 0c             	mov    0xc(%ebp),%edx
     7ea:	89 c6                	mov    %eax,%esi
     7ec:	85 d2                	test   %edx,%edx
     7ee:	74 08                	je     7f8 <executeForever+0x28>
            detach(pid);        
     7f0:	89 04 24             	mov    %eax,(%esp)
     7f3:	e8 70 05 00 00       	call   d68 <detach>
    }
    else{
        printf(1,"fork failed\n");
        return 0;
    }
}
     7f8:	83 c4 10             	add    $0x10,%esp
     7fb:	89 f0                	mov    %esi,%eax
     7fd:	5b                   	pop    %ebx
     7fe:	5e                   	pop    %esi
     7ff:	5d                   	pop    %ebp
     800:	c3                   	ret    
     801:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                sleep(timeToSleep);   
     808:	89 1c 24             	mov    %ebx,(%esp)
     80b:	e8 48 05 00 00       	call   d58 <sleep>
            if(timeToSleep){   
     810:	85 db                	test   %ebx,%ebx
     812:	75 f4                	jne    808 <executeForever+0x38>
     814:	eb fe                	jmp    814 <executeForever+0x44>
        printf(1,"fork failed\n");
     816:	b8 a8 11 00 00       	mov    $0x11a8,%eax
        return 0;
     81b:	31 f6                	xor    %esi,%esi
        printf(1,"fork failed\n");
     81d:	89 44 24 04          	mov    %eax,0x4(%esp)
     821:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     828:	e8 03 06 00 00       	call   e30 <printf>
        return 0;
     82d:	eb c9                	jmp    7f8 <executeForever+0x28>
     82f:	90                   	nop

00000830 <executeTimes>:

int executeTimes(int timeToSleep,int numberOfLoops,int isDetach,char* debugString){
     830:	55                   	push   %ebp
     831:	89 e5                	mov    %esp,%ebp
     833:	53                   	push   %ebx
     834:	83 ec 14             	sub    $0x14,%esp
    int pid;

    if((pid = fork()) == 0){
     837:	e8 84 04 00 00       	call   cc0 <fork>
     83c:	83 f8 00             	cmp    $0x0,%eax
     83f:	89 c3                	mov    %eax,%ebx
     841:	74 4c                	je     88f <executeTimes+0x5f>
            printf(1," ending...\n");
        }

        exit(0);
    }
    else if(pid > 0){
     843:	7e 2b                	jle    870 <executeTimes+0x40>
        if(isDetach){
     845:	8b 55 10             	mov    0x10(%ebp),%edx
     848:	85 d2                	test   %edx,%edx
     84a:	75 0c                	jne    858 <executeTimes+0x28>
    }
    else{
        printf(1,"fork failed\n");
        return 0;
    }
}
     84c:	83 c4 14             	add    $0x14,%esp
     84f:	89 d8                	mov    %ebx,%eax
     851:	5b                   	pop    %ebx
     852:	5d                   	pop    %ebp
     853:	c3                   	ret    
     854:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            detach(pid);        
     858:	89 04 24             	mov    %eax,(%esp)
     85b:	e8 08 05 00 00       	call   d68 <detach>
}
     860:	83 c4 14             	add    $0x14,%esp
     863:	89 d8                	mov    %ebx,%eax
     865:	5b                   	pop    %ebx
     866:	5d                   	pop    %ebp
     867:	c3                   	ret    
     868:	90                   	nop
     869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1,"fork failed\n");
     870:	b8 a8 11 00 00       	mov    $0x11a8,%eax
        return 0;
     875:	31 db                	xor    %ebx,%ebx
        printf(1,"fork failed\n");
     877:	89 44 24 04          	mov    %eax,0x4(%esp)
     87b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     882:	e8 a9 05 00 00       	call   e30 <printf>
}
     887:	83 c4 14             	add    $0x14,%esp
     88a:	89 d8                	mov    %ebx,%eax
     88c:	5b                   	pop    %ebx
     88d:	5d                   	pop    %ebp
     88e:	c3                   	ret    
        priority(4);
     88f:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
     896:	e8 d5 04 00 00       	call   d70 <priority>
        sleep(1000);
     89b:	c7 04 24 e8 03 00 00 	movl   $0x3e8,(%esp)
     8a2:	e8 b1 04 00 00       	call   d58 <sleep>
        for(int i = 0;i < numberOfLoops;i++){
     8a7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     8ab:	7e 11                	jle    8be <executeTimes+0x8e>
            sleep(timeToSleep);
     8ad:	8b 45 08             	mov    0x8(%ebp),%eax
        for(int i = 0;i < numberOfLoops;i++){
     8b0:	43                   	inc    %ebx
            sleep(timeToSleep);
     8b1:	89 04 24             	mov    %eax,(%esp)
     8b4:	e8 9f 04 00 00       	call   d58 <sleep>
        for(int i = 0;i < numberOfLoops;i++){
     8b9:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
     8bc:	75 ef                	jne    8ad <executeTimes+0x7d>
        exit(0);
     8be:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     8c5:	e8 fe 03 00 00       	call   cc8 <exit>
     8ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000008d0 <retrieveNextChildPerf>:

void retrieveNextChildPerf(){
     8d0:	55                   	push   %ebp
    int pid;
    int childNum;

    pid = wait_stat(null,&perf_temp);
     8d1:	ba 5c 1a 00 00       	mov    $0x1a5c,%edx
void retrieveNextChildPerf(){
     8d6:	89 e5                	mov    %esp,%ebp
     8d8:	83 ec 18             	sub    $0x18,%esp
    pid = wait_stat(null,&perf_temp);
     8db:	89 54 24 04          	mov    %edx,0x4(%esp)
     8df:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     8e6:	e8 95 04 00 00       	call   d80 <wait_stat>
    }
}

int getChildNum(int pid){

    for(int i = 0;i < NUM_OF_CHILDS;i++){
     8eb:	31 d2                	xor    %edx,%edx
        if(childPids[i] == pid){
     8ed:	3b 04 95 40 1a 00 00 	cmp    0x1a40(,%edx,4),%eax
     8f4:	74 22                	je     918 <retrieveNextChildPerf+0x48>
    for(int i = 0;i < NUM_OF_CHILDS;i++){
     8f6:	42                   	inc    %edx
     8f7:	83 fa 07             	cmp    $0x7,%edx
     8fa:	75 f1                	jne    8ed <retrieveNextChildPerf+0x1d>
        printf(1,"couldn't find child num in retrieveNextChildPerf\n");
     8fc:	b8 b4 15 00 00       	mov    $0x15b4,%eax
     901:	89 44 24 04          	mov    %eax,0x4(%esp)
     905:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     90c:	e8 1f 05 00 00       	call   e30 <printf>
}
     911:	c9                   	leave  
     912:	c3                   	ret    
     913:	90                   	nop
     914:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        childPerfs[childNum].ctime = perf_temp.ctime;
     918:	8b 0d 5c 1a 00 00    	mov    0x1a5c,%ecx
     91e:	8d 14 92             	lea    (%edx,%edx,4),%edx
     921:	c1 e2 02             	shl    $0x2,%edx
     924:	8d 82 80 1a 00 00    	lea    0x1a80(%edx),%eax
     92a:	89 8a 80 1a 00 00    	mov    %ecx,0x1a80(%edx)
        childPerfs[childNum].ttime = perf_temp.ttime;
     930:	8b 15 60 1a 00 00    	mov    0x1a60,%edx
     936:	89 50 04             	mov    %edx,0x4(%eax)
        childPerfs[childNum].stime = perf_temp.stime;
     939:	8b 15 64 1a 00 00    	mov    0x1a64,%edx
     93f:	89 50 08             	mov    %edx,0x8(%eax)
        childPerfs[childNum].retime = perf_temp.retime;
     942:	8b 15 68 1a 00 00    	mov    0x1a68,%edx
     948:	89 50 0c             	mov    %edx,0xc(%eax)
        childPerfs[childNum].rutime = perf_temp.rutime;
     94b:	8b 15 6c 1a 00 00    	mov    0x1a6c,%edx
     951:	89 50 10             	mov    %edx,0x10(%eax)
}
     954:	c9                   	leave  
     955:	c3                   	ret    
     956:	8d 76 00             	lea    0x0(%esi),%esi
     959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000960 <getChildNum>:
int getChildNum(int pid){
     960:	55                   	push   %ebp
    for(int i = 0;i < NUM_OF_CHILDS;i++){
     961:	31 c0                	xor    %eax,%eax
int getChildNum(int pid){
     963:	89 e5                	mov    %esp,%ebp
     965:	8b 55 08             	mov    0x8(%ebp),%edx
        if(childPids[i] == pid){
     968:	39 14 85 40 1a 00 00 	cmp    %edx,0x1a40(,%eax,4)
     96f:	74 0b                	je     97c <getChildNum+0x1c>
    for(int i = 0;i < NUM_OF_CHILDS;i++){
     971:	40                   	inc    %eax
     972:	83 f8 07             	cmp    $0x7,%eax
     975:	75 f1                	jne    968 <getChildNum+0x8>
            return i;
        }
    }

    return -1;
     977:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     97c:	5d                   	pop    %ebp
     97d:	c3                   	ret    
     97e:	66 90                	xchg   %ax,%ax

00000980 <print_perf>:

void print_perf(struct perf performance){
     980:	55                   	push   %ebp
    printf(1,"----------------------------------------------------\n");
     981:	b8 3c 16 00 00       	mov    $0x163c,%eax
void print_perf(struct perf performance){
     986:	89 e5                	mov    %esp,%ebp
     988:	83 ec 18             	sub    $0x18,%esp
    printf(1,"----------------------------------------------------\n");
     98b:	89 44 24 04          	mov    %eax,0x4(%esp)
     98f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     996:	e8 95 04 00 00       	call   e30 <printf>
    printf(1,"ctime = %d\n",performance.ctime);
     99b:	8b 45 08             	mov    0x8(%ebp),%eax
     99e:	ba 75 15 00 00       	mov    $0x1575,%edx
     9a3:	89 54 24 04          	mov    %edx,0x4(%esp)
     9a7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     9ae:	89 44 24 08          	mov    %eax,0x8(%esp)
     9b2:	e8 79 04 00 00       	call   e30 <printf>
    printf(1,"ttime = %d\n",performance.ttime);
     9b7:	8b 45 0c             	mov    0xc(%ebp),%eax
     9ba:	b9 81 15 00 00       	mov    $0x1581,%ecx
     9bf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     9c3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     9ca:	89 44 24 08          	mov    %eax,0x8(%esp)
     9ce:	e8 5d 04 00 00       	call   e30 <printf>
    printf(1,"stime = %d\n",performance.stime);
     9d3:	8b 45 10             	mov    0x10(%ebp),%eax
     9d6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     9dd:	89 44 24 08          	mov    %eax,0x8(%esp)
     9e1:	b8 8d 15 00 00       	mov    $0x158d,%eax
     9e6:	89 44 24 04          	mov    %eax,0x4(%esp)
     9ea:	e8 41 04 00 00       	call   e30 <printf>
    printf(1,"retime = %d\n",performance.retime);
     9ef:	8b 45 14             	mov    0x14(%ebp),%eax
     9f2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     9f9:	89 44 24 08          	mov    %eax,0x8(%esp)
     9fd:	b8 99 15 00 00       	mov    $0x1599,%eax
     a02:	89 44 24 04          	mov    %eax,0x4(%esp)
     a06:	e8 25 04 00 00       	call   e30 <printf>
    printf(1,"rutime = %d\n",performance.rutime);
     a0b:	8b 45 18             	mov    0x18(%ebp),%eax
     a0e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a15:	89 44 24 08          	mov    %eax,0x8(%esp)
     a19:	b8 a6 15 00 00       	mov    $0x15a6,%eax
     a1e:	89 44 24 04          	mov    %eax,0x4(%esp)
     a22:	e8 09 04 00 00       	call   e30 <printf>
    printf(1,"----------------------------------------------------\n");
     a27:	c7 45 0c 3c 16 00 00 	movl   $0x163c,0xc(%ebp)
     a2e:	c7 45 08 01 00 00 00 	movl   $0x1,0x8(%ebp)
}
     a35:	c9                   	leave  
    printf(1,"----------------------------------------------------\n");
     a36:	e9 f5 03 00 00       	jmp    e30 <printf>
     a3b:	90                   	nop
     a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a40 <print_all_perfs>:

void print_all_perfs(){
     a40:	55                   	push   %ebp
     a41:	89 e5                	mov    %esp,%ebp
     a43:	53                   	push   %ebx
    for(int i = 0;i < NUM_OF_CHILDS;i++){
     a44:	31 db                	xor    %ebx,%ebx
void print_all_perfs(){
     a46:	83 ec 24             	sub    $0x24,%esp
     a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        print_perf(childPerfs[i]);
     a50:	8d 14 9b             	lea    (%ebx,%ebx,4),%edx
    for(int i = 0;i < NUM_OF_CHILDS;i++){
     a53:	43                   	inc    %ebx
        print_perf(childPerfs[i]);
     a54:	c1 e2 02             	shl    $0x2,%edx
     a57:	8d 82 80 1a 00 00    	lea    0x1a80(%edx),%eax
     a5d:	8b 92 80 1a 00 00    	mov    0x1a80(%edx),%edx
     a63:	89 14 24             	mov    %edx,(%esp)
     a66:	8b 50 04             	mov    0x4(%eax),%edx
     a69:	89 54 24 04          	mov    %edx,0x4(%esp)
     a6d:	8b 50 08             	mov    0x8(%eax),%edx
     a70:	89 54 24 08          	mov    %edx,0x8(%esp)
     a74:	8b 50 0c             	mov    0xc(%eax),%edx
     a77:	89 54 24 0c          	mov    %edx,0xc(%esp)
     a7b:	8b 40 10             	mov    0x10(%eax),%eax
     a7e:	89 44 24 10          	mov    %eax,0x10(%esp)
     a82:	e8 f9 fe ff ff       	call   980 <print_perf>
    for(int i = 0;i < NUM_OF_CHILDS;i++){
     a87:	83 fb 07             	cmp    $0x7,%ebx
     a8a:	75 c4                	jne    a50 <print_all_perfs+0x10>
    }
}
     a8c:	83 c4 24             	add    $0x24,%esp
     a8f:	5b                   	pop    %ebx
     a90:	5d                   	pop    %ebp
     a91:	c3                   	ret    
     a92:	66 90                	xchg   %ax,%ax
     a94:	66 90                	xchg   %ax,%ax
     a96:	66 90                	xchg   %ax,%ax
     a98:	66 90                	xchg   %ax,%ax
     a9a:	66 90                	xchg   %ax,%ax
     a9c:	66 90                	xchg   %ax,%ax
     a9e:	66 90                	xchg   %ax,%ax

00000aa0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     aa0:	55                   	push   %ebp
     aa1:	89 e5                	mov    %esp,%ebp
     aa3:	8b 45 08             	mov    0x8(%ebp),%eax
     aa6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     aa9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     aaa:	89 c2                	mov    %eax,%edx
     aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ab0:	41                   	inc    %ecx
     ab1:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     ab5:	42                   	inc    %edx
     ab6:	84 db                	test   %bl,%bl
     ab8:	88 5a ff             	mov    %bl,-0x1(%edx)
     abb:	75 f3                	jne    ab0 <strcpy+0x10>
    ;
  return os;
}
     abd:	5b                   	pop    %ebx
     abe:	5d                   	pop    %ebp
     abf:	c3                   	ret    

00000ac0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     ac0:	55                   	push   %ebp
     ac1:	89 e5                	mov    %esp,%ebp
     ac3:	8b 4d 08             	mov    0x8(%ebp),%ecx
     ac6:	53                   	push   %ebx
     ac7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
     aca:	0f b6 01             	movzbl (%ecx),%eax
     acd:	0f b6 13             	movzbl (%ebx),%edx
     ad0:	84 c0                	test   %al,%al
     ad2:	75 18                	jne    aec <strcmp+0x2c>
     ad4:	eb 22                	jmp    af8 <strcmp+0x38>
     ad6:	8d 76 00             	lea    0x0(%esi),%esi
     ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     ae0:	41                   	inc    %ecx
  while(*p && *p == *q)
     ae1:	0f b6 01             	movzbl (%ecx),%eax
    p++, q++;
     ae4:	43                   	inc    %ebx
     ae5:	0f b6 13             	movzbl (%ebx),%edx
  while(*p && *p == *q)
     ae8:	84 c0                	test   %al,%al
     aea:	74 0c                	je     af8 <strcmp+0x38>
     aec:	38 d0                	cmp    %dl,%al
     aee:	74 f0                	je     ae0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
     af0:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
     af1:	29 d0                	sub    %edx,%eax
}
     af3:	5d                   	pop    %ebp
     af4:	c3                   	ret    
     af5:	8d 76 00             	lea    0x0(%esi),%esi
     af8:	5b                   	pop    %ebx
     af9:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     afb:	29 d0                	sub    %edx,%eax
}
     afd:	5d                   	pop    %ebp
     afe:	c3                   	ret    
     aff:	90                   	nop

00000b00 <strlen>:

uint
strlen(const char *s)
{
     b00:	55                   	push   %ebp
     b01:	89 e5                	mov    %esp,%ebp
     b03:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     b06:	80 39 00             	cmpb   $0x0,(%ecx)
     b09:	74 15                	je     b20 <strlen+0x20>
     b0b:	31 d2                	xor    %edx,%edx
     b0d:	8d 76 00             	lea    0x0(%esi),%esi
     b10:	42                   	inc    %edx
     b11:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     b15:	89 d0                	mov    %edx,%eax
     b17:	75 f7                	jne    b10 <strlen+0x10>
    ;
  return n;
}
     b19:	5d                   	pop    %ebp
     b1a:	c3                   	ret    
     b1b:	90                   	nop
     b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(n = 0; s[n]; n++)
     b20:	31 c0                	xor    %eax,%eax
}
     b22:	5d                   	pop    %ebp
     b23:	c3                   	ret    
     b24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000b30 <memset>:

void*
memset(void *dst, int c, uint n)
{
     b30:	55                   	push   %ebp
     b31:	89 e5                	mov    %esp,%ebp
     b33:	8b 55 08             	mov    0x8(%ebp),%edx
     b36:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     b37:	8b 4d 10             	mov    0x10(%ebp),%ecx
     b3a:	8b 45 0c             	mov    0xc(%ebp),%eax
     b3d:	89 d7                	mov    %edx,%edi
     b3f:	fc                   	cld    
     b40:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     b42:	5f                   	pop    %edi
     b43:	89 d0                	mov    %edx,%eax
     b45:	5d                   	pop    %ebp
     b46:	c3                   	ret    
     b47:	89 f6                	mov    %esi,%esi
     b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b50 <strchr>:

char*
strchr(const char *s, char c)
{
     b50:	55                   	push   %ebp
     b51:	89 e5                	mov    %esp,%ebp
     b53:	8b 45 08             	mov    0x8(%ebp),%eax
     b56:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     b5a:	0f b6 10             	movzbl (%eax),%edx
     b5d:	84 d2                	test   %dl,%dl
     b5f:	74 1b                	je     b7c <strchr+0x2c>
    if(*s == c)
     b61:	38 d1                	cmp    %dl,%cl
     b63:	75 0f                	jne    b74 <strchr+0x24>
     b65:	eb 17                	jmp    b7e <strchr+0x2e>
     b67:	89 f6                	mov    %esi,%esi
     b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     b70:	38 ca                	cmp    %cl,%dl
     b72:	74 0a                	je     b7e <strchr+0x2e>
  for(; *s; s++)
     b74:	40                   	inc    %eax
     b75:	0f b6 10             	movzbl (%eax),%edx
     b78:	84 d2                	test   %dl,%dl
     b7a:	75 f4                	jne    b70 <strchr+0x20>
      return (char*)s;
  return 0;
     b7c:	31 c0                	xor    %eax,%eax
}
     b7e:	5d                   	pop    %ebp
     b7f:	c3                   	ret    

00000b80 <gets>:

char*
gets(char *buf, int max)
{
     b80:	55                   	push   %ebp
     b81:	89 e5                	mov    %esp,%ebp
     b83:	57                   	push   %edi
     b84:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     b85:	31 f6                	xor    %esi,%esi
{
     b87:	53                   	push   %ebx
     b88:	83 ec 3c             	sub    $0x3c,%esp
     b8b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cc = read(0, &c, 1);
     b8e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
     b91:	eb 32                	jmp    bc5 <gets+0x45>
     b93:	90                   	nop
     b94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
     b98:	ba 01 00 00 00       	mov    $0x1,%edx
     b9d:	89 54 24 08          	mov    %edx,0x8(%esp)
     ba1:	89 7c 24 04          	mov    %edi,0x4(%esp)
     ba5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     bac:	e8 2f 01 00 00       	call   ce0 <read>
    if(cc < 1)
     bb1:	85 c0                	test   %eax,%eax
     bb3:	7e 19                	jle    bce <gets+0x4e>
      break;
    buf[i++] = c;
     bb5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     bb9:	43                   	inc    %ebx
     bba:	88 43 ff             	mov    %al,-0x1(%ebx)
    if(c == '\n' || c == '\r')
     bbd:	3c 0a                	cmp    $0xa,%al
     bbf:	74 1f                	je     be0 <gets+0x60>
     bc1:	3c 0d                	cmp    $0xd,%al
     bc3:	74 1b                	je     be0 <gets+0x60>
  for(i=0; i+1 < max; ){
     bc5:	46                   	inc    %esi
     bc6:	3b 75 0c             	cmp    0xc(%ebp),%esi
     bc9:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
     bcc:	7c ca                	jl     b98 <gets+0x18>
      break;
  }
  buf[i] = '\0';
     bce:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     bd1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
     bd4:	8b 45 08             	mov    0x8(%ebp),%eax
     bd7:	83 c4 3c             	add    $0x3c,%esp
     bda:	5b                   	pop    %ebx
     bdb:	5e                   	pop    %esi
     bdc:	5f                   	pop    %edi
     bdd:	5d                   	pop    %ebp
     bde:	c3                   	ret    
     bdf:	90                   	nop
     be0:	8b 45 08             	mov    0x8(%ebp),%eax
     be3:	01 c6                	add    %eax,%esi
     be5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
     be8:	eb e4                	jmp    bce <gets+0x4e>
     bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000bf0 <stat>:

int
stat(const char *n, struct stat *st)
{
     bf0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     bf1:	31 c0                	xor    %eax,%eax
{
     bf3:	89 e5                	mov    %esp,%ebp
     bf5:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
     bf8:	89 44 24 04          	mov    %eax,0x4(%esp)
     bfc:	8b 45 08             	mov    0x8(%ebp),%eax
{
     bff:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     c02:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
     c05:	89 04 24             	mov    %eax,(%esp)
     c08:	e8 fb 00 00 00       	call   d08 <open>
  if(fd < 0)
     c0d:	85 c0                	test   %eax,%eax
     c0f:	78 2f                	js     c40 <stat+0x50>
     c11:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
     c13:	8b 45 0c             	mov    0xc(%ebp),%eax
     c16:	89 1c 24             	mov    %ebx,(%esp)
     c19:	89 44 24 04          	mov    %eax,0x4(%esp)
     c1d:	e8 fe 00 00 00       	call   d20 <fstat>
  close(fd);
     c22:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     c25:	89 c6                	mov    %eax,%esi
  close(fd);
     c27:	e8 c4 00 00 00       	call   cf0 <close>
  return r;
}
     c2c:	89 f0                	mov    %esi,%eax
     c2e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
     c31:	8b 75 fc             	mov    -0x4(%ebp),%esi
     c34:	89 ec                	mov    %ebp,%esp
     c36:	5d                   	pop    %ebp
     c37:	c3                   	ret    
     c38:	90                   	nop
     c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
     c40:	be ff ff ff ff       	mov    $0xffffffff,%esi
     c45:	eb e5                	jmp    c2c <stat+0x3c>
     c47:	89 f6                	mov    %esi,%esi
     c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c50 <atoi>:

int
atoi(const char *s)
{
     c50:	55                   	push   %ebp
     c51:	89 e5                	mov    %esp,%ebp
     c53:	8b 4d 08             	mov    0x8(%ebp),%ecx
     c56:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     c57:	0f be 11             	movsbl (%ecx),%edx
     c5a:	88 d0                	mov    %dl,%al
     c5c:	2c 30                	sub    $0x30,%al
     c5e:	3c 09                	cmp    $0x9,%al
  n = 0;
     c60:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
     c65:	77 1e                	ja     c85 <atoi+0x35>
     c67:	89 f6                	mov    %esi,%esi
     c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
     c70:	41                   	inc    %ecx
     c71:	8d 04 80             	lea    (%eax,%eax,4),%eax
     c74:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
     c78:	0f be 11             	movsbl (%ecx),%edx
     c7b:	88 d3                	mov    %dl,%bl
     c7d:	80 eb 30             	sub    $0x30,%bl
     c80:	80 fb 09             	cmp    $0x9,%bl
     c83:	76 eb                	jbe    c70 <atoi+0x20>
  return n;
}
     c85:	5b                   	pop    %ebx
     c86:	5d                   	pop    %ebp
     c87:	c3                   	ret    
     c88:	90                   	nop
     c89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000c90 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     c90:	55                   	push   %ebp
     c91:	89 e5                	mov    %esp,%ebp
     c93:	56                   	push   %esi
     c94:	8b 45 08             	mov    0x8(%ebp),%eax
     c97:	53                   	push   %ebx
     c98:	8b 5d 10             	mov    0x10(%ebp),%ebx
     c9b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     c9e:	85 db                	test   %ebx,%ebx
     ca0:	7e 1a                	jle    cbc <memmove+0x2c>
     ca2:	31 d2                	xor    %edx,%edx
     ca4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     caa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *dst++ = *src++;
     cb0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     cb4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     cb7:	42                   	inc    %edx
  while(n-- > 0)
     cb8:	39 d3                	cmp    %edx,%ebx
     cba:	75 f4                	jne    cb0 <memmove+0x20>
  return vdst;
}
     cbc:	5b                   	pop    %ebx
     cbd:	5e                   	pop    %esi
     cbe:	5d                   	pop    %ebp
     cbf:	c3                   	ret    

00000cc0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     cc0:	b8 01 00 00 00       	mov    $0x1,%eax
     cc5:	cd 40                	int    $0x40
     cc7:	c3                   	ret    

00000cc8 <exit>:
SYSCALL(exit)
     cc8:	b8 02 00 00 00       	mov    $0x2,%eax
     ccd:	cd 40                	int    $0x40
     ccf:	c3                   	ret    

00000cd0 <wait>:
SYSCALL(wait)
     cd0:	b8 03 00 00 00       	mov    $0x3,%eax
     cd5:	cd 40                	int    $0x40
     cd7:	c3                   	ret    

00000cd8 <pipe>:
SYSCALL(pipe)
     cd8:	b8 04 00 00 00       	mov    $0x4,%eax
     cdd:	cd 40                	int    $0x40
     cdf:	c3                   	ret    

00000ce0 <read>:
SYSCALL(read)
     ce0:	b8 05 00 00 00       	mov    $0x5,%eax
     ce5:	cd 40                	int    $0x40
     ce7:	c3                   	ret    

00000ce8 <write>:
SYSCALL(write)
     ce8:	b8 10 00 00 00       	mov    $0x10,%eax
     ced:	cd 40                	int    $0x40
     cef:	c3                   	ret    

00000cf0 <close>:
SYSCALL(close)
     cf0:	b8 15 00 00 00       	mov    $0x15,%eax
     cf5:	cd 40                	int    $0x40
     cf7:	c3                   	ret    

00000cf8 <kill>:
SYSCALL(kill)
     cf8:	b8 06 00 00 00       	mov    $0x6,%eax
     cfd:	cd 40                	int    $0x40
     cff:	c3                   	ret    

00000d00 <exec>:
SYSCALL(exec)
     d00:	b8 07 00 00 00       	mov    $0x7,%eax
     d05:	cd 40                	int    $0x40
     d07:	c3                   	ret    

00000d08 <open>:
SYSCALL(open)
     d08:	b8 0f 00 00 00       	mov    $0xf,%eax
     d0d:	cd 40                	int    $0x40
     d0f:	c3                   	ret    

00000d10 <mknod>:
SYSCALL(mknod)
     d10:	b8 11 00 00 00       	mov    $0x11,%eax
     d15:	cd 40                	int    $0x40
     d17:	c3                   	ret    

00000d18 <unlink>:
SYSCALL(unlink)
     d18:	b8 12 00 00 00       	mov    $0x12,%eax
     d1d:	cd 40                	int    $0x40
     d1f:	c3                   	ret    

00000d20 <fstat>:
SYSCALL(fstat)
     d20:	b8 08 00 00 00       	mov    $0x8,%eax
     d25:	cd 40                	int    $0x40
     d27:	c3                   	ret    

00000d28 <link>:
SYSCALL(link)
     d28:	b8 13 00 00 00       	mov    $0x13,%eax
     d2d:	cd 40                	int    $0x40
     d2f:	c3                   	ret    

00000d30 <mkdir>:
SYSCALL(mkdir)
     d30:	b8 14 00 00 00       	mov    $0x14,%eax
     d35:	cd 40                	int    $0x40
     d37:	c3                   	ret    

00000d38 <chdir>:
SYSCALL(chdir)
     d38:	b8 09 00 00 00       	mov    $0x9,%eax
     d3d:	cd 40                	int    $0x40
     d3f:	c3                   	ret    

00000d40 <dup>:
SYSCALL(dup)
     d40:	b8 0a 00 00 00       	mov    $0xa,%eax
     d45:	cd 40                	int    $0x40
     d47:	c3                   	ret    

00000d48 <getpid>:
SYSCALL(getpid)
     d48:	b8 0b 00 00 00       	mov    $0xb,%eax
     d4d:	cd 40                	int    $0x40
     d4f:	c3                   	ret    

00000d50 <sbrk>:
SYSCALL(sbrk)
     d50:	b8 0c 00 00 00       	mov    $0xc,%eax
     d55:	cd 40                	int    $0x40
     d57:	c3                   	ret    

00000d58 <sleep>:
SYSCALL(sleep)
     d58:	b8 0d 00 00 00       	mov    $0xd,%eax
     d5d:	cd 40                	int    $0x40
     d5f:	c3                   	ret    

00000d60 <uptime>:
SYSCALL(uptime)
     d60:	b8 0e 00 00 00       	mov    $0xe,%eax
     d65:	cd 40                	int    $0x40
     d67:	c3                   	ret    

00000d68 <detach>:
SYSCALL(detach)
     d68:	b8 16 00 00 00       	mov    $0x16,%eax
     d6d:	cd 40                	int    $0x40
     d6f:	c3                   	ret    

00000d70 <priority>:
SYSCALL(priority)
     d70:	b8 17 00 00 00       	mov    $0x17,%eax
     d75:	cd 40                	int    $0x40
     d77:	c3                   	ret    

00000d78 <policy>:
SYSCALL(policy)
     d78:	b8 18 00 00 00       	mov    $0x18,%eax
     d7d:	cd 40                	int    $0x40
     d7f:	c3                   	ret    

00000d80 <wait_stat>:
SYSCALL(wait_stat)
     d80:	b8 19 00 00 00       	mov    $0x19,%eax
     d85:	cd 40                	int    $0x40
     d87:	c3                   	ret    
     d88:	66 90                	xchg   %ax,%ax
     d8a:	66 90                	xchg   %ax,%ax
     d8c:	66 90                	xchg   %ax,%ax
     d8e:	66 90                	xchg   %ax,%ax

00000d90 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     d90:	55                   	push   %ebp
     d91:	89 e5                	mov    %esp,%ebp
     d93:	57                   	push   %edi
     d94:	56                   	push   %esi
     d95:	53                   	push   %ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     d96:	89 d3                	mov    %edx,%ebx
     d98:	c1 eb 1f             	shr    $0x1f,%ebx
{
     d9b:	83 ec 4c             	sub    $0x4c,%esp
  if(sgn && xx < 0){
     d9e:	84 db                	test   %bl,%bl
{
     da0:	89 45 c0             	mov    %eax,-0x40(%ebp)
     da3:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
     da5:	74 79                	je     e20 <printint+0x90>
     da7:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
     dab:	74 73                	je     e20 <printint+0x90>
    neg = 1;
    x = -xx;
     dad:	f7 d8                	neg    %eax
    neg = 1;
     daf:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
     db6:	31 f6                	xor    %esi,%esi
     db8:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     dbb:	eb 05                	jmp    dc2 <printint+0x32>
     dbd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
     dc0:	89 fe                	mov    %edi,%esi
     dc2:	31 d2                	xor    %edx,%edx
     dc4:	f7 f1                	div    %ecx
     dc6:	8d 7e 01             	lea    0x1(%esi),%edi
     dc9:	0f b6 92 7c 16 00 00 	movzbl 0x167c(%edx),%edx
  }while((x /= base) != 0);
     dd0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
     dd2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
     dd5:	75 e9                	jne    dc0 <printint+0x30>
  if(neg)
     dd7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
     dda:	85 d2                	test   %edx,%edx
     ddc:	74 08                	je     de6 <printint+0x56>
    buf[i++] = '-';
     dde:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
     de3:	8d 7e 02             	lea    0x2(%esi),%edi
     de6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
     dea:	8b 7d c0             	mov    -0x40(%ebp),%edi
     ded:	8d 76 00             	lea    0x0(%esi),%esi
     df0:	0f b6 06             	movzbl (%esi),%eax
     df3:	4e                   	dec    %esi
  write(fd, &c, 1);
     df4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     df8:	89 3c 24             	mov    %edi,(%esp)
     dfb:	88 45 d7             	mov    %al,-0x29(%ebp)
     dfe:	b8 01 00 00 00       	mov    $0x1,%eax
     e03:	89 44 24 08          	mov    %eax,0x8(%esp)
     e07:	e8 dc fe ff ff       	call   ce8 <write>

  while(--i >= 0)
     e0c:	39 de                	cmp    %ebx,%esi
     e0e:	75 e0                	jne    df0 <printint+0x60>
    putc(fd, buf[i]);
}
     e10:	83 c4 4c             	add    $0x4c,%esp
     e13:	5b                   	pop    %ebx
     e14:	5e                   	pop    %esi
     e15:	5f                   	pop    %edi
     e16:	5d                   	pop    %ebp
     e17:	c3                   	ret    
     e18:	90                   	nop
     e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
     e20:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     e27:	eb 8d                	jmp    db6 <printint+0x26>
     e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000e30 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
     e30:	55                   	push   %ebp
     e31:	89 e5                	mov    %esp,%ebp
     e33:	57                   	push   %edi
     e34:	56                   	push   %esi
     e35:	53                   	push   %ebx
     e36:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     e39:	8b 75 0c             	mov    0xc(%ebp),%esi
     e3c:	0f b6 1e             	movzbl (%esi),%ebx
     e3f:	84 db                	test   %bl,%bl
     e41:	0f 84 d1 00 00 00    	je     f18 <printf+0xe8>
  state = 0;
     e47:	31 ff                	xor    %edi,%edi
     e49:	46                   	inc    %esi
  ap = (uint*)(void*)&fmt + 1;
     e4a:	8d 45 10             	lea    0x10(%ebp),%eax
  write(fd, &c, 1);
     e4d:	89 fa                	mov    %edi,%edx
     e4f:	8b 7d 08             	mov    0x8(%ebp),%edi
  ap = (uint*)(void*)&fmt + 1;
     e52:	89 45 d0             	mov    %eax,-0x30(%ebp)
     e55:	eb 41                	jmp    e98 <printf+0x68>
     e57:	89 f6                	mov    %esi,%esi
     e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     e60:	83 f8 25             	cmp    $0x25,%eax
     e63:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
     e66:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
     e6b:	74 1e                	je     e8b <printf+0x5b>
  write(fd, &c, 1);
     e6d:	b8 01 00 00 00       	mov    $0x1,%eax
     e72:	89 44 24 08          	mov    %eax,0x8(%esp)
     e76:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     e79:	89 44 24 04          	mov    %eax,0x4(%esp)
     e7d:	89 3c 24             	mov    %edi,(%esp)
     e80:	88 5d e2             	mov    %bl,-0x1e(%ebp)
     e83:	e8 60 fe ff ff       	call   ce8 <write>
     e88:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     e8b:	46                   	inc    %esi
  for(i = 0; fmt[i]; i++){
     e8c:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
     e90:	84 db                	test   %bl,%bl
     e92:	0f 84 80 00 00 00    	je     f18 <printf+0xe8>
    if(state == 0){
     e98:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
     e9a:	0f be cb             	movsbl %bl,%ecx
     e9d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
     ea0:	74 be                	je     e60 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     ea2:	83 fa 25             	cmp    $0x25,%edx
     ea5:	75 e4                	jne    e8b <printf+0x5b>
      if(c == 'd'){
     ea7:	83 f8 64             	cmp    $0x64,%eax
     eaa:	0f 84 f0 00 00 00    	je     fa0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     eb0:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
     eb6:	83 f9 70             	cmp    $0x70,%ecx
     eb9:	74 65                	je     f20 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     ebb:	83 f8 73             	cmp    $0x73,%eax
     ebe:	0f 84 8c 00 00 00    	je     f50 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     ec4:	83 f8 63             	cmp    $0x63,%eax
     ec7:	0f 84 13 01 00 00    	je     fe0 <printf+0x1b0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     ecd:	83 f8 25             	cmp    $0x25,%eax
     ed0:	0f 84 e2 00 00 00    	je     fb8 <printf+0x188>
  write(fd, &c, 1);
     ed6:	b8 01 00 00 00       	mov    $0x1,%eax
     edb:	46                   	inc    %esi
     edc:	89 44 24 08          	mov    %eax,0x8(%esp)
     ee0:	8d 45 e7             	lea    -0x19(%ebp),%eax
     ee3:	89 44 24 04          	mov    %eax,0x4(%esp)
     ee7:	89 3c 24             	mov    %edi,(%esp)
     eea:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
     eee:	e8 f5 fd ff ff       	call   ce8 <write>
     ef3:	ba 01 00 00 00       	mov    $0x1,%edx
     ef8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     efb:	89 54 24 08          	mov    %edx,0x8(%esp)
     eff:	89 44 24 04          	mov    %eax,0x4(%esp)
     f03:	89 3c 24             	mov    %edi,(%esp)
     f06:	88 5d e6             	mov    %bl,-0x1a(%ebp)
     f09:	e8 da fd ff ff       	call   ce8 <write>
  for(i = 0; fmt[i]; i++){
     f0e:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     f12:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
     f14:	84 db                	test   %bl,%bl
     f16:	75 80                	jne    e98 <printf+0x68>
    }
  }
}
     f18:	83 c4 3c             	add    $0x3c,%esp
     f1b:	5b                   	pop    %ebx
     f1c:	5e                   	pop    %esi
     f1d:	5f                   	pop    %edi
     f1e:	5d                   	pop    %ebp
     f1f:	c3                   	ret    
        printint(fd, *ap, 16, 0);
     f20:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     f27:	b9 10 00 00 00       	mov    $0x10,%ecx
     f2c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
     f2f:	89 f8                	mov    %edi,%eax
     f31:	8b 13                	mov    (%ebx),%edx
     f33:	e8 58 fe ff ff       	call   d90 <printint>
        ap++;
     f38:	89 d8                	mov    %ebx,%eax
      state = 0;
     f3a:	31 d2                	xor    %edx,%edx
        ap++;
     f3c:	83 c0 04             	add    $0x4,%eax
     f3f:	89 45 d0             	mov    %eax,-0x30(%ebp)
     f42:	e9 44 ff ff ff       	jmp    e8b <printf+0x5b>
     f47:	89 f6                	mov    %esi,%esi
     f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        s = (char*)*ap;
     f50:	8b 45 d0             	mov    -0x30(%ebp),%eax
     f53:	8b 10                	mov    (%eax),%edx
        ap++;
     f55:	83 c0 04             	add    $0x4,%eax
     f58:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
     f5b:	85 d2                	test   %edx,%edx
     f5d:	0f 84 aa 00 00 00    	je     100d <printf+0x1dd>
        while(*s != 0){
     f63:	0f b6 02             	movzbl (%edx),%eax
        s = (char*)*ap;
     f66:	89 d3                	mov    %edx,%ebx
        while(*s != 0){
     f68:	84 c0                	test   %al,%al
     f6a:	74 27                	je     f93 <printf+0x163>
     f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     f70:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
     f73:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
     f78:	43                   	inc    %ebx
  write(fd, &c, 1);
     f79:	89 44 24 08          	mov    %eax,0x8(%esp)
     f7d:	8d 45 e3             	lea    -0x1d(%ebp),%eax
     f80:	89 44 24 04          	mov    %eax,0x4(%esp)
     f84:	89 3c 24             	mov    %edi,(%esp)
     f87:	e8 5c fd ff ff       	call   ce8 <write>
        while(*s != 0){
     f8c:	0f b6 03             	movzbl (%ebx),%eax
     f8f:	84 c0                	test   %al,%al
     f91:	75 dd                	jne    f70 <printf+0x140>
      state = 0;
     f93:	31 d2                	xor    %edx,%edx
     f95:	e9 f1 fe ff ff       	jmp    e8b <printf+0x5b>
     f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
     fa0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     fa7:	b9 0a 00 00 00       	mov    $0xa,%ecx
     fac:	e9 7b ff ff ff       	jmp    f2c <printf+0xfc>
     fb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
     fb8:	b9 01 00 00 00       	mov    $0x1,%ecx
     fbd:	8d 45 e5             	lea    -0x1b(%ebp),%eax
     fc0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     fc4:	89 44 24 04          	mov    %eax,0x4(%esp)
     fc8:	89 3c 24             	mov    %edi,(%esp)
     fcb:	88 5d e5             	mov    %bl,-0x1b(%ebp)
     fce:	e8 15 fd ff ff       	call   ce8 <write>
      state = 0;
     fd3:	31 d2                	xor    %edx,%edx
     fd5:	e9 b1 fe ff ff       	jmp    e8b <printf+0x5b>
     fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, *ap);
     fe0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
     fe3:	8b 03                	mov    (%ebx),%eax
        ap++;
     fe5:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
     fe8:	89 3c 24             	mov    %edi,(%esp)
        putc(fd, *ap);
     feb:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
     fee:	b8 01 00 00 00       	mov    $0x1,%eax
     ff3:	89 44 24 08          	mov    %eax,0x8(%esp)
     ff7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     ffa:	89 44 24 04          	mov    %eax,0x4(%esp)
     ffe:	e8 e5 fc ff ff       	call   ce8 <write>
      state = 0;
    1003:	31 d2                	xor    %edx,%edx
        ap++;
    1005:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    1008:	e9 7e fe ff ff       	jmp    e8b <printf+0x5b>
          s = "(null)";
    100d:	bb 74 16 00 00       	mov    $0x1674,%ebx
        while(*s != 0){
    1012:	b0 28                	mov    $0x28,%al
    1014:	e9 57 ff ff ff       	jmp    f70 <printf+0x140>
    1019:	66 90                	xchg   %ax,%ax
    101b:	66 90                	xchg   %ax,%ax
    101d:	66 90                	xchg   %ax,%ax
    101f:	90                   	nop

00001020 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1020:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1021:	a1 20 1a 00 00       	mov    0x1a20,%eax
{
    1026:	89 e5                	mov    %esp,%ebp
    1028:	57                   	push   %edi
    1029:	56                   	push   %esi
    102a:	53                   	push   %ebx
    102b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    102e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1031:	eb 0d                	jmp    1040 <free+0x20>
    1033:	90                   	nop
    1034:	90                   	nop
    1035:	90                   	nop
    1036:	90                   	nop
    1037:	90                   	nop
    1038:	90                   	nop
    1039:	90                   	nop
    103a:	90                   	nop
    103b:	90                   	nop
    103c:	90                   	nop
    103d:	90                   	nop
    103e:	90                   	nop
    103f:	90                   	nop
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1040:	39 c8                	cmp    %ecx,%eax
    1042:	8b 10                	mov    (%eax),%edx
    1044:	73 32                	jae    1078 <free+0x58>
    1046:	39 d1                	cmp    %edx,%ecx
    1048:	72 04                	jb     104e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    104a:	39 d0                	cmp    %edx,%eax
    104c:	72 32                	jb     1080 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
    104e:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1051:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1054:	39 fa                	cmp    %edi,%edx
    1056:	74 30                	je     1088 <free+0x68>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1058:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    105b:	8b 50 04             	mov    0x4(%eax),%edx
    105e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1061:	39 f1                	cmp    %esi,%ecx
    1063:	74 3c                	je     10a1 <free+0x81>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1065:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
    1067:	5b                   	pop    %ebx
  freep = p;
    1068:	a3 20 1a 00 00       	mov    %eax,0x1a20
}
    106d:	5e                   	pop    %esi
    106e:	5f                   	pop    %edi
    106f:	5d                   	pop    %ebp
    1070:	c3                   	ret    
    1071:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1078:	39 d0                	cmp    %edx,%eax
    107a:	72 04                	jb     1080 <free+0x60>
    107c:	39 d1                	cmp    %edx,%ecx
    107e:	72 ce                	jb     104e <free+0x2e>
{
    1080:	89 d0                	mov    %edx,%eax
    1082:	eb bc                	jmp    1040 <free+0x20>
    1084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1088:	8b 7a 04             	mov    0x4(%edx),%edi
    108b:	01 fe                	add    %edi,%esi
    108d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1090:	8b 10                	mov    (%eax),%edx
    1092:	8b 12                	mov    (%edx),%edx
    1094:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1097:	8b 50 04             	mov    0x4(%eax),%edx
    109a:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    109d:	39 f1                	cmp    %esi,%ecx
    109f:	75 c4                	jne    1065 <free+0x45>
    p->s.size += bp->s.size;
    10a1:	8b 4b fc             	mov    -0x4(%ebx),%ecx
  freep = p;
    10a4:	a3 20 1a 00 00       	mov    %eax,0x1a20
    p->s.size += bp->s.size;
    10a9:	01 ca                	add    %ecx,%edx
    10ab:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    10ae:	8b 53 f8             	mov    -0x8(%ebx),%edx
    10b1:	89 10                	mov    %edx,(%eax)
}
    10b3:	5b                   	pop    %ebx
    10b4:	5e                   	pop    %esi
    10b5:	5f                   	pop    %edi
    10b6:	5d                   	pop    %ebp
    10b7:	c3                   	ret    
    10b8:	90                   	nop
    10b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000010c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    10c0:	55                   	push   %ebp
    10c1:	89 e5                	mov    %esp,%ebp
    10c3:	57                   	push   %edi
    10c4:	56                   	push   %esi
    10c5:	53                   	push   %ebx
    10c6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    10c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    10cc:	8b 15 20 1a 00 00    	mov    0x1a20,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    10d2:	8d 78 07             	lea    0x7(%eax),%edi
    10d5:	c1 ef 03             	shr    $0x3,%edi
    10d8:	47                   	inc    %edi
  if((prevp = freep) == 0){
    10d9:	85 d2                	test   %edx,%edx
    10db:	0f 84 8f 00 00 00    	je     1170 <malloc+0xb0>
    10e1:	8b 02                	mov    (%edx),%eax
    10e3:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    10e6:	39 cf                	cmp    %ecx,%edi
    10e8:	76 66                	jbe    1150 <malloc+0x90>
    10ea:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    10f0:	bb 00 10 00 00       	mov    $0x1000,%ebx
    10f5:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    10f8:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    10ff:	eb 10                	jmp    1111 <malloc+0x51>
    1101:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1108:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    110a:	8b 48 04             	mov    0x4(%eax),%ecx
    110d:	39 f9                	cmp    %edi,%ecx
    110f:	73 3f                	jae    1150 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1111:	39 05 20 1a 00 00    	cmp    %eax,0x1a20
    1117:	89 c2                	mov    %eax,%edx
    1119:	75 ed                	jne    1108 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    111b:	89 34 24             	mov    %esi,(%esp)
    111e:	e8 2d fc ff ff       	call   d50 <sbrk>
  if(p == (char*)-1)
    1123:	83 f8 ff             	cmp    $0xffffffff,%eax
    1126:	74 18                	je     1140 <malloc+0x80>
  hp->s.size = nu;
    1128:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    112b:	83 c0 08             	add    $0x8,%eax
    112e:	89 04 24             	mov    %eax,(%esp)
    1131:	e8 ea fe ff ff       	call   1020 <free>
  return freep;
    1136:	8b 15 20 1a 00 00    	mov    0x1a20,%edx
      if((p = morecore(nunits)) == 0)
    113c:	85 d2                	test   %edx,%edx
    113e:	75 c8                	jne    1108 <malloc+0x48>
        return 0;
  }
}
    1140:	83 c4 1c             	add    $0x1c,%esp
        return 0;
    1143:	31 c0                	xor    %eax,%eax
}
    1145:	5b                   	pop    %ebx
    1146:	5e                   	pop    %esi
    1147:	5f                   	pop    %edi
    1148:	5d                   	pop    %ebp
    1149:	c3                   	ret    
    114a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1150:	39 cf                	cmp    %ecx,%edi
    1152:	74 4c                	je     11a0 <malloc+0xe0>
        p->s.size -= nunits;
    1154:	29 f9                	sub    %edi,%ecx
    1156:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1159:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    115c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    115f:	89 15 20 1a 00 00    	mov    %edx,0x1a20
}
    1165:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
    1168:	83 c0 08             	add    $0x8,%eax
}
    116b:	5b                   	pop    %ebx
    116c:	5e                   	pop    %esi
    116d:	5f                   	pop    %edi
    116e:	5d                   	pop    %ebp
    116f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    1170:	b8 24 1a 00 00       	mov    $0x1a24,%eax
    1175:	ba 24 1a 00 00       	mov    $0x1a24,%edx
    base.s.size = 0;
    117a:	31 c9                	xor    %ecx,%ecx
    base.s.ptr = freep = prevp = &base;
    117c:	a3 20 1a 00 00       	mov    %eax,0x1a20
    base.s.size = 0;
    1181:	b8 24 1a 00 00       	mov    $0x1a24,%eax
    base.s.ptr = freep = prevp = &base;
    1186:	89 15 24 1a 00 00    	mov    %edx,0x1a24
    base.s.size = 0;
    118c:	89 0d 28 1a 00 00    	mov    %ecx,0x1a28
    1192:	e9 53 ff ff ff       	jmp    10ea <malloc+0x2a>
    1197:	89 f6                	mov    %esi,%esi
    1199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        prevp->s.ptr = p->s.ptr;
    11a0:	8b 08                	mov    (%eax),%ecx
    11a2:	89 0a                	mov    %ecx,(%edx)
    11a4:	eb b9                	jmp    115f <malloc+0x9f>
