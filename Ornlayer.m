function [ernlayer]=Ornlayer(N,M, Mlinlnm)
    exist Xn
    a = ~ans;
    
    if(a)
    ernlayer.Xn = zeros(2,N);
    end
    
    ernlayer.N = N;
    ernlayer.M = M;
    ernlayer.Mlinlnm = Mlinlnm;
    ernlayer.input =  ernlayer.Xn*ernlayer.Mlinlnm;
    ernlayer.TypefunS = 6;
    ernlayer.TypefunT = 1;
    
    for i=1:M  
       ernlayer.Orneuron{i} = @Orneuron;
    end
end