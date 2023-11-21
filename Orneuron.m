classdef Orneuron
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
      function obj = orinit(obj,W,Xn,TypefunS,TypefunT)% инициализация нейрона
      obj.W        = W;          % вес
      obj.Xn       = Xn;         % вектор значений
      obj.TypefunS = TypefunS;   % тип канормы
      obj.TypefunT = TypefunT;   % тип нормы   
      obj.N        = length(Xn); % длинна вектора
    end %function

    function obj = orneuron(obj)
        for i=1:obj.N
            obj.S{i}= Tnorm(obj.W(i),obj.Xn(i),obj.TypefunT);
        end
        res = Snorm(obj.S{1},obj.S{2}, obj.TypefunS);
        if(obj.N > 2)
            for i=3:obj.N
                res = Snorm(res,obj.S{i}, obj.TypefunS);
            end
        end
        obj.out = res;
    end %function
  end
end