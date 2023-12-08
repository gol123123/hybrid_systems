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

W = [1    1
     0.1    0.1];
TypefunTS = [1 6];
AND_layer = Andnlayer;
AND_layer = andnlayerinit(AND_layer,x_and, W, TypefunTS);% инициализация нейрона
AND_layer = andnlayerStart(AND_layer);% инициализация нейрона
AND_layer.out

%% Ornlayer test
x_and = mf_layer.out;
W = [1    1
     0.1    0.1];
TypefunTS = [1 6];

OR_layer = Ornlayer;
OR_layer = ornlayerinit(OR_layer,x_and, W, TypefunTS);% инициализация нейрона
OR_layer = ornlayerStart(OR_layer);% инициализация нейрона
OR_layer.out
%% Nnlayer test
N_in = AND_layer.out;
W = [1    1
     0.1    0.1];
N_layer = Nnlayer;
N_layer = nnlayerinit(N_layer,N_in, W);% инициализация нейрона
N_layer = nnlayerStart(N_layer,N_in);% инициализация нейрона
N_layer.out
%% 
x = 0:0.00001:10;
mfneurev = Mfneuronrev;
mfneurev = Mfrevinit(mfneurev,0.5,@trimf,[2 3 6]);
mfneurev = mfneuronrev(mfneurev,x,0.3);
mfneurev.out

mf = trimf(x,[2 3 6]);
plot(x,mf)

%% Mfrevnlayer test
MFREV_in = N_in;
Mf = {@sigmf
      @sigmf}; 
  
param = {[0 6]
         [2   9]};
range = 0:0.0001:10;     
MFREV_layer = Mfrevnlayer;
MFREV_layer = mfrevnlayerinit(MFREV_layer,MFREV_in, Mf,param,range);% инициализация нейрона
MFREV_layer = mfrevnlayerStart(MFREV_layer,MFREV_in);% инициализация нейрона
MFREV_layer.out
Y = sum(MFREV_layer.out .* N_layer.out)

%% ANFIS test
clear all
Qin        = [4];        
MFQin = {@gaussmf
         @gaussmf
         @gaussmf};   
MFQinparam = {[3 0]
              [3 6]
              [3 9]};     
Qout  = [0];    
MFRQout   = {@gaussmf  @gaussmf};      
MFRQinparam = {[3 0] [3 6]};   
Mand        = 2 ;    
Mor         = 2;           
MlinkandQinMand = [1
                   1
                   1];
MlinkorMandMor = [1 
                  1 ];  
              
net = ANFIS;
net = ANFISnet(net,Qin,MFQin,MFQinparam,Qout,MFRQout,MFRQinparam,Mand,Mor,MlinkandQinMand,MlinkorMandMor)
net = simANFIS(net,Qin);

for i=1:10
Qin = [i]; 
net = simANFIS(net,Qin);
a(i) = net.Qout;
end
plot(a)
i = 1:10;
figure(2)
x = 0:0.1:10;
for i=1:length(x)/1
    Qin = x(i);
    Yn = sin(2*x(i))*exp(-0.1*x(i));
    net = trainANFIS(net,Qin,Yn);
end
x = 0:0.1:10;
for i=1:length(x)
    Qin = [x(i)];
    net = simANFIS(net,Qin);
    b(i) = net.Qout;
end
plot(x,b)
Yn = sin(2*x).*exp(-0.1*x);
hold on
plot(x,Yn)
i = 1:10;
k=1:20;
surf(k,i,b);
Qin = [3 1 1]; 
net = simANFIS(net,Qin);
net.Qout

i = 1:10;
k=1:20;
z = i+k-k;
surf(k,i,z);

Qin = [3 1 4]; 
net = simANFIS(net,Qin);
net.Qout
