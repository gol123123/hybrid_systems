classdef Nneuron
  properties
    Slinkn   =0;
    signal   =0;
    out      =0;
  end

  methods
      function obj = Ninit(obj,signal,Slinkn)% инициализация нейрона
      obj.signal   = signal;          % вес
      obj.Slinkn   = Slinkn;         % вектор значений
    end %function
    
    function obj = nneuron(obj,signal)
        if nargin < 2
        signal = obj.signal; % По умолчанию, если S не задан.
        end
        obj.signal = signal;
        obj.out = obj.signal/sum(obj.Slinkn);
    end %function
  end
end