function [andnlayer]=Andnlayer(N,M, Mlinlnm)
    exist Xn
    a = ~ans;
    
    if(a)
    andnlayer.Xn = zeros(2,N);
    end
    
    andnlayer.N = N;
    andnlayer.M = M;
    andnlayer.Mlinlnm = Mlinlnm;
    andnlayer.TypefunS = 6;
    andnlayer.TypefunT = 1;
    andnlayer.Andneuron = @Andneuron;
    for i=1:N
        andnlayer.input(i,:) =  andnlayer.Xn(i)*andnlayer.Mlinlnm(i,:);
    end
    for i=1:obj.N
       output = andnlayer.Andneuron(andnlayer.Xn(i:(i+2)),andnlayer.Mlinlnm(i,:),andnlayer.TypefunS,andnlayer.TypefunT);
       andnlayer.output(i) = output;
    end
end