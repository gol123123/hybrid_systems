classdef Mfneuronrev
  properties
    level    =0;
    MF       =0;
    param    =0;
    out      =0;
  end

  methods
      function obj = Mfrevinit(obj,level, MF, param)% инициализация нейрона
      obj.MF       = MF;      % вектор значений
      obj.level    = level;   % тип канормы
      obj.param    = param;   % тип канормы
    end %function
    
    function obj = mfneuronrev(obj,range,level)
        if nargin < 3
          level = obj.level; % По умолчанию, если S не задан.
        else
          obj.level =  level;
        end
        mf_out = obj.MF(range,obj.param);
        [~, ind] = min(abs(mf_out-obj.level));
        obj.out = range(ind);
    end %function
  end
end