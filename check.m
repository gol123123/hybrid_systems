 x=0:1:200; % в наносекундах
 a = x(1);
 b = x(round(length(x)/2));
 c = x(end); 
 MF = @trimf
 param = [a b c];

 [out]=Mfneuron(x,MF,param)
 
Xn = [1 2 3 4 5 6 7 8 9 10];
MF = {2, 'trimf', 8,'trapmf'};
Size = length(MF)
[out]=Mfnlayer(10, Xn, MF)
