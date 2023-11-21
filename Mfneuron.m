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
    
    function obj = mfneuron(obj)
        obj.out = obj.MF(obj.Xn, obj.param);
    end %function
    
    function mfPlot(obj)
        x = 0:0.1:10;
        plot(x, obj.MF(x, obj.param));
    end %function
  end
end