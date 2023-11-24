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
      function obj = mfrevnlayerinit(obj,N, Xn, MFn, param,range)% инициализация нейрона
        if nargin < 4
        range = -20:0.01:20; % По умолчанию, если S не задан.
        end
        
      obj.N       = N;            % количество фп для одной переменной
      obj.Xn      = Xn;           % значение переменной
      obj.MFn     = MFn;          % функции принадлежности
      obj.param   = param;        % параметры для функций принадлежности
      obj.range   = range;        % параметры для функций принадлежности
      
      for nX=1:length(obj.Xn)
          for nMF=1:obj.N
              neuron = Mfneuronrev;
              obj.mfrevneuron{nMF,nX} = neuron;
              
              obj.mfrevneuron{nMF,nX} = Mfrevinit(obj.mfrevneuron{nMF,nX},obj.Xn(nX),obj.MFn{nMF,nX},obj.param{nMF,nX});
          end
      end
      obj.out =  zeros(obj.N,length(obj.Xn));
    end %function
    
    function obj = mfrevnlayerStart(obj,Xn)
        if nargin < 2
        Xn = obj.Xn; % По умолчанию, если S не задан.
        else
        obj.Xn = Xn;
        end
       for nX=1:length(obj.Xn)  
        for nMF=1:obj.N
              obj.mfrevneuron{nMF,nX} = mfneuronrev(obj.mfrevneuron{nMF,nX},obj.range,obj.Xn(nX));
              obj.out(nMF,nX) = obj.mfrevneuron{nMF,nX}.out;
        end 
       end
    end %function
    
    function obj = mfrevnlayernewparam(obj,new_param)
        obj.param =new_param;
        for nX=1:length(obj.Xn)
            for nMF=1:obj.N
                obj.mfrevneuron{nMF,nX} = mfrevnewparam(obj.mfrevneuron{nMF,nX},obj.param{nMF,nX});
            end
        end
    end
        
  end
end
