function [out]=Andnlayer(N,M, Mlinlnm)
    nett.M = N;
    nett.M = M;
    nett.Mlinlnm = Mlinlnm
    nett.Xn = zeros(2,N);
    nett.input =  nett.Xn*Mlinlnm;
    nett.TypefunS = 6;
    nett.TypefunT = 1;
for i=1:M   
   nett.Andneuron{i} = Andneuron(N,input,TypefunS,TypefunT);
end
out = MF(x, param);
end