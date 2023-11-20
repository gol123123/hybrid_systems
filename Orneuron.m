function [Or]=Orneuron(W,Xn,TypefunS,TypefunT)

Or.N = length(Xn);
Or.W = W;
Or.Xn = Xn;
Or.TypefunS = TypefunS;
Or.TypefunT = TypefunT;

Or.T1= Snorm(Or.W(1),Or.Xn(1),Or.TypefunT);
Or.T2= Snorm(Or.W(2),Or.Xn(2),Or.TypefunT);
Or.out = Tnorm(Or.S1,Or.S2, Or.TypefunS);
end
