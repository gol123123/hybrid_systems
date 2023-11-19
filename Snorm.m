function [Sn]=Snorm(X,Y,TypefunS)
if TypefunS == 1
Sko = max(X,Y);
end
if TypefunS == 2
  Sko = 1-(1-Y)*(1-X)/(1-Y*X);
end
if TypefunS == 3
 Sko = 1-(1-Y)*(1-X);   
end
if TypefunS == 4
   Sko = 1-(1-Y)*(1-X)/(1+Y*X);
end
if TypefunS == 5
    d = X+Y;
   Sko = min(1,d);
end
if TypefunS == 6
   mn = min(X,Y); 
 if mn>0
    Sko = 1;
end
if mn == 0
    Sko = max(X,Y);
end
end
Sn = Sko;
end