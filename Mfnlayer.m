%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%          X1 X2 X3 .. Xn    % каждому Xn соответствует %
%%%        | A1 B1 C1 .. Z1 |  % An ФП                    %
%%%  MFn = | A2 B2 C2 .. Z2 |  %                          %
%%%        | .. .. .. .. .. |  %                          %
%%%        | An Bn Cn .. Zn |  %                          %
%%%                            %                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef Mfnlayer
  properties
    N        = 0;
    Xn       = 0;
    MFn      = 0;
    param    = 0;
    mfneuron = cell(1,1);
    out = 0;
  end

  methods
      function obj = mfnlayerinit(obj,N, Xn, MFn, param)% инициализация нейрона
      obj.N       = N;        % количество фп для одной переменной
      obj.Xn      = Xn;       % значение переменной
      obj.MFn     = MFn;      % функции принадлежности
      obj.param   = param;    % параметры для функций принадлежности
      
      for nX=1:length(obj.Xn)
          for nMF=1:obj.N
              neuron = Mfneuron;
              obj.mfneuron{nMF,nX} = neuron;
              obj.mfneuron{nMF,nX} = mfinit(obj.mfneuron{nMF,nX},obj.Xn(nX),obj.MFn{nMF,nX}, obj.param{nMF,nX});
          end
      end
      obj.out =  zeros(length(obj.Xn),obj.N);
    end %function
    
    function obj = mfnlayerStart(obj,Xn)
        if nargin < 2
        Xn = obj.Xn; % По умолчанию, если S не задан.
        else
        obj.Xn = Xn;
        end
        
        for nX=1:length(obj.Xn)
          for nMF=1:obj.N
              obj.mfneuron{nMF,nX} = mfneuron(obj.mfneuron{nMF,nX},obj.Xn(nX));
              obj.out(nX,nMF) = obj.mfneuron{nMF,nX}.out;
          end
        end     
    end %function
    
    function mfnlayerplot(obj)
        for nX=1:length(obj.Xn)
            for nMF=1:obj.N
                mfPlot(obj.mfneuron{nMF,nX});
                hold on
            end
        end
        hold off
        
        
    end %function
    
    function obj = mfnlayernewparam(obj,new_param)
        obj.param =new_param;
        for nX=1:length(obj.Xn)
          for nMF=1:obj.N
              obj.mfneuron{nMF,nX} = mfnewparam(obj.mfneuron{nMF,nX},obj.param{nMF,nX});
          end
        end 
    end
  end
end


