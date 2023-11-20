function [and]=Andneuron(W,Xn,TypefunS,TypefunT)
and.N = length(Xn);
and.W = W;
and.Xn = Xn;
and.TypefunS = TypefunS;
and.TypefunT = TypefunT;

and.S1= Snorm(and.W(1),and.Xn(1),and.TypefunS);
and.S2= Snorm(and.W(2),and.Xn(2),and.TypefunS);
and.out = Tnorm(and.S1,and.S2, and.TypefunT);
end