//===============================
// Calculate Circular Constant Pi
// (1024 figures)
//-------------------------------
// for VirtexE Evaluation Board
// July.20 2003 Ver.1
//===============================

1. Introduction
---------------------------
This is a program for calculating the Circular Constant (Pi).
This source program can make 1024 figures after the decimal fraction.
If you have large memory space, you can expand figures
to be calculated only by changing the definition of MAXFIGURE.
This program is also a good verification of Aquarius quality. 

2. Algorithm
---------------------------
This program uses the basic Matin's formula.
    PI/4 =  4*arctan(1/5) -   arctan(1/239)
    arctan(1/p) = 1/p - 1/(3*p^3) + 1/(5*p^5) - 1/(7*p^7) + ...

3. How to compile
---------------------------
Simply make it.
    $ make clean
    $ make
Then, it creates a program for the FPGA System
which is described in Aquarius document.

4. Performace
---------------------------
To calculate 1024 figures, 
it approximately takes 4.5sec@20MHz.
(Aquarius don't have RTC yet, 
so accurate speed can not be measured.)

5. Result
---------------------------
Load the s-format object by the Aquarius monitor, 
and run it from the address 0x00002008.
This program displays the result on LCD display
on the Aquarius FPGA System, like as follows. 
Hit any key to page.
================
Constant Pi = 3.

1415926535897932
3846264338327950

2884197169399375
1058209749445923

0781640628620899
8628034825342117

0679821480865132
8230664709384460

9550582231725359
4081284811174502

8410270193852110
5559644622948954

9303819644288109
7566593344612847

5648233786783165
2712019091456485

6692346034861045
4326648213393607

2602491412737245
8700660631558817

4881520920962829
2540917153643678

9259036001133053
0548820466521384

1469519415116094
3305727036575959

1953092186117381
9326117931051185

4807446237996274
9567351885752724

8912279381830119
4912983367336244

0656643086021394
9463952247371907

0217986094370277
0539217176293176

7523846748184676
6940513200056812

7145263560827785
7713427577896091

7363717872146844
0901224953430146

5495853710507922
7968925892354201

9956112129021960
8640344181598136

2977477130996051
8707211349999998

3729780499510597
3173281609631859

5024459455346908
3026425223082533

4468503526193118
8171010003137838

7528865875332083
8142061717766914

7303598253490428
7554687311595628

6388235378759375
1957781857780532

1712268066130019
2787661119590921

6420198938095257
2010654858632788
================

End of document.