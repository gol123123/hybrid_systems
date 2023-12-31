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
    
    function obj = nneuronstart(obj,signal,Slinkn)
        if nargin < 2
        signal = obj.signal; % По умолчанию, если S не задан.
        Slinkn = obj.Slinkn;
        else
          obj.signal =  signal;
          obj.Slinkn =  Slinkn;
        end
        obj.out = obj.signal/sum(obj.Slinkn);
    end %function
  end
end