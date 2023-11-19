function [Or]=Orneuron(N,TypefunS,TypefunT)
T1 = Tnorm(N,TypefunT);
T2 = Tnorm(N,TypefunT);
Or = Snormm(T1,T2,TypefunS);
end
