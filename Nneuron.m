function [out]=Nneuron(Slinkn,signal)
out = signal/sum(Slinkn);
end

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
    
    function obj = Nneuron(obj)
        obj.out = obj.signal/sum(obj.Slinkn);
    end %function
  end
end