function [And]=Andneuron(N,TypefunS,TypefunT)
S1=Snorm(N,TypefunS);
S2=Snorm(N,TypefunS);
And = Tnormm(S1,S2, TypefunT);
end