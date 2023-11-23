%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                             % в каждый N-нейрон        %
%%%            | out1 | Nneur1  % поступает строка X1,     %
%%%  Mlinlnm = | out2 | Nneur2  % [X1 X2 .. Xn]            %
%%%            | .... | ......  %                          %
%%%            | outN | NneurN  %                          %
%%%                             %                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef Mfrevnlayer
  properties
    N        = 0;
    Xn       = 0;
    MFn      = 0;
    param    = 0;
    mfrevneuron = cell(1,1);
    out = 0;
    range = 0;
  end

  methods
      function obj = mfrevnlayerinit(obj, Xn, MFn, param,range)% инициализация нейрона
        if nargin < 4
        range = -20:0.01:20; % По умолчанию, если S не задан.
        end
        
      obj.N       = length(Xn);   % количество фп для одной переменной
      obj.Xn      = Xn;           % значение переменной
      obj.MFn     = MFn;          % функции принадлежности
      obj.param   = param;        % параметры для функций принадлежности
      obj.range   = range;        % параметры для функций принадлежности
      for nX=1:obj.N
          neuron = Mfneuronrev;
          obj.mfrevneuron{nX} = neuron;
          obj.mfrevneuron{nX} = Mfrevinit(obj.mfrevneuron{nX},obj.Xn(nX),obj.MFn{nX},obj.param{nX});
      end
    end %function
    
    function obj = mfrevnlayerStart(obj,Xn)
        if nargin < 2
        Xn = obj.Xn; % По умолчанию, если S не задан.
        else
        obj.Xn = Xn;
        end
        
        for nX=1:obj.N
              obj.mfrevneuron{nX} = mfneuronrev(obj.mfrevneuron{nX},obj.range,obj.Xn(nX));
              obj.out(nX) = obj.mfrevneuron{nX}.out;
        end     
    end %function
  end
end
