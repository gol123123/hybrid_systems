function [out]=Nnlayer(N,Mlinlnm)
netnorm.N = N;
netnorm.Mlinlnm = Mlinlnm;
netnorm.Xn = rand(N);
for i=1:N
   netnorm.out{i} = Nneuron(netnorm.Xn,netnorm.Xn(i));
end
end