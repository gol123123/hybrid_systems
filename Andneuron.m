function [and]=Andneuron(N,Xn,TypefunS,TypefunT)
and.N = N;
and.Xn = Xn;
and.TypefunS = TypefunS;
and.TypefunT = TypefunT;
and.S1=Snorm(and.Xn(1,:),and.Xn(2,:),and.TypefunS);
and.S2=Snorm(and.Xn(1,:),and.Xn(2,:),and.TypefunS);
and.out = Tnorm(and.S1,and.S2, and.TypefunT);
and.funT = @Tnorm;
and.funs = @Snorm;
end