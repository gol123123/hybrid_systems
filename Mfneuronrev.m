classdef Mfneuronrev
  properties
    level    =0;
    MF       =0;
    Xout      =0;
  end

  methods
      function obj = Mfrevinit(obj,level, MF)% инициализация нейрона
      obj.MF       = MF;         % вектор значений
      obj.level    = level;   % тип канормы
    end %function
    
    function obj = mfneuronrev(obj)
        obj.Xout = obj.MF(obj.level);
    end %function
  end
end