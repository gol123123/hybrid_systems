%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                             % в каждый N-нейрон        %
%%%            | out1 | Nneur1  % поступает строка X1,     %
%%%  Mlinlnm = | out2 | Nneur2  % [X1 X2 .. Xn]            %
%%%            | .... | ......  %                          %
%%%            | outN | NneurN  %                          %
%%%                             %                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef Nnlayer
  properties
    N        = 0;
    Xn       = 0;
    Mlinlnm  = 0;
    nneuron = cell(1,1);
    out = 0;
  end

  methods
      function obj = nnlayerinit(obj,Xn, Mlinlnm)% инициализация нейрона
      obj.N       = length(Xn); % количество фп для одной переменной
      obj.Xn      = Xn;         % значение переменной
      obj.Mlinlnm = Mlinlnm;    % функции принадлежности
      
      In = Xn .* Mlinlnm;
      for nX=1:obj.N
          neuron = Nneuron;
          obj.nneuron{nX} = neuron;
          obj.nneuron{nX} = Ninit(obj.nneuron{nX},obj.Xn(nX),obj.Xn);
      end
      obj.out =  zeros(1,obj.N);
    end %function
    
    function obj = nnlayerStart(obj,Xn)
        if nargin < 2
        Xn = obj.Xn; % По умолчанию, если S не задан.
        else
        obj.Xn = Xn;
        end
        
        for nX=1:obj.N
              obj.nneuron{nX} = nneuronstart(obj.nneuron{nX},obj.Xn(nX),obj.Xn);
              obj.out(nX) = obj.nneuron{nX}.out;
        end     
    end %function
  end
end


