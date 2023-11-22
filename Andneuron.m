classdef Andneuron
  properties
    N        =0;
    W        =0;
    Xn       =0;
    TypefunS =0;
    TypefunT =0;
    S        =cell(1);
    out      =0;
  end

  methods
      function obj = andinit(obj,W,Xn,TypefunS,TypefunT)% инициализация нейрона
      obj.W        = W;          % вес
      obj.Xn       = Xn;         % вектор значений
      obj.TypefunS = TypefunS;   % тип канормы
      obj.TypefunT = TypefunT;   % тип нормы   
      obj.N        = length(Xn); % длинна вектора
    end %function

    function obj = andneuron(obj,Xn)
        if nargin < 2
        Xn = obj.Xn; % По умолчанию, если S не задан.
        else
        obj.Xn = Xn;
        obj.N  = length(Xn); % длинна вектора
        end
        
        for i=1:obj.N
            obj.S{i}= Snorm(obj.W(i),obj.Xn(i),obj.TypefunS);
        end
        res = Tnorm(obj.S{1},obj.S{2}, obj.TypefunT);
        if(obj.N > 2)
            for i=3:obj.N
                res = Tnorm(res,obj.S{i}, obj.TypefunT);
            end
        end
        obj.out = res;
    end %function
  end
end