classdef Mfneuron
  properties
    Xn       =0;
    param    =0;
    MF       =0;
    out      =0;
  end

  methods
      function obj = mfinit(obj,Xn,MF, param)% инициализация нейрона
      obj.Xn       = Xn;          % вес
      obj.MF       = MF;         % вектор значений
      obj.param    = param;   % тип канормы
    end %function
    
    function obj = mfneuron(obj,Xn)
        if nargin < 2
        Xn = obj.Xn; % По умолчанию, если S не задан.
        end
        obj.out = obj.MF(Xn, obj.param);
    end %function
    
    function mfPlot(obj)
        x = 0:0.1:20;
        plot(x, obj.MF(x, obj.param));
    end %function
    
    function obj = mfnewparam(obj,new_param)
        obj.param =new_param;
    end
  end
end