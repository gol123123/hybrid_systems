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
%% Mfneuron test
X = 1;
MF = @gauss2mf;
param = [1 2 3 4];
Mf = Mfneuron;
Mf = mfinit(Mf,X,MF,param);
Mf = mfneuron(Mf);
mfPlot(Mf);
%% Mfnlayer test
x = [1 2];

Mf = {@gaussmf    @sigmf
      @gaussmf    @sigmf}; 
  
param = {[0.1 0.5   1 1.5] [0.1 0.5]
         [0.4 0.8 1.3 1.9] [1   1.5]  };
  size(param)   
mf_layer = Mfnlayer;
mf_layer = mfnlayerinit(mf_layer,2, x, Mf, param)% инициализация нейрона
mf_layer = mfnlayerStart(mf_layer)% инициализация нейрона
mf_layer.out
mfnlayerplot(mf_layer)
%% Andnlayer test
x_and = mf_layer.out;

W = [0.1    0.1
     1    1];
TypefunTS = [1 6];
AND_layer = Andnlayer;
AND_layer = andnlayerinit(AND_layer,W, x_and, W, TypefunTS);% инициализация нейрона
AND_layer = andnlayerStart(AND_layer);% инициализация нейрона
AND_layer.out

