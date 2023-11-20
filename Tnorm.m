function [Tn] = Tnorm(X,Y, TypefunT)
if TypefunT == 1
    mx = max(X,Y);
    if mx<1
        Tnor = 0;
    end
    if mx == 1
        Tnor = min(X,Y);
    end
end
if TypefunT == 2
    s=0;
    d = X+Y - 1;
    Tnor = max(0, d);
end
if TypefunT == 3
    Tnor = X.*Y./(1+(1-X).*(1-Y));
end
if TypefunT == 4
    Tnor = X.*Y;
end
if TypefunT == 5
    Tnor = X.*Y/(1-(1-X).*(1-Y));
end
if TypefunT == 6
    Tnor = min(X,Y);
end
Tn = Tnor;
end
