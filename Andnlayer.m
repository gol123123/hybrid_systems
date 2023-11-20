function [andnlayer]=Andnlayer(N,M, Mlinlnm)
    exist Xn
    a = ~ans;
    
    if(a)
    andnlayer.Xn = zeros(2,N);
    end
    
    andnlayer.N = N;
    andnlayer.M = M;
    andnlayer.Mlinlnm = Mlinlnm;
    andnlayer.input =  andnlayer.Xn*andnlayer.Mlinlnm;
    andnlayer.TypefunS = 6;
    andnlayer.TypefunT = 1;
    
    for i=1:M  
       andnlayer.Andneuron{i} = @Andneuron;
    end
end