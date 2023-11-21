 x=0:1:200; % в наносекундах
 a = x(1);
 b = x(round(length(x)/2));
 c = x(end); 
 MF = @trimf
 param = [a b c];

 [out]=Mfneuron(x,MF,param)
TypefunT = 6;
TypefunS = 1;
Xn = [0.2 0.3];
W = [0.4 0.5];
[and]=Andneuron(W,Xn,TypefunS,TypefunT);
 
%% Andneuron test
X = [1 1 1 1];
W = [0.1 0.6 0.5 0.01];
TypefunS = 3;
TypefunT = 3;
and = Andneuron;
and = andinit(and,W,X,TypefunS,TypefunT);
and = andneuron(and);
and.out
%% Andneuron test
X = [1 1 1 1];
W = [0.1 0.6 0.5 0.01];
TypefunS = 3;
TypefunT = 3;
or = Orneuron;
or = orinit(or,W,X,TypefunS,TypefunT);
or = orneuron(or);
or.out
%% Andneuron test
X = 1;
MF = @gauss2mf;
param = [1 2 3 4];
Mf = Mfneuron;
Mf = mfinit(Mf,X,MF,param);
Mf = mfneuron(Mf);
mfPlot(Mf);
%%
g = finverse(gauss2mf)