%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%              X1 X2 X3 .. Xn            % в каждый И-нейрон        %
%%%            | A1 B1 C1 .. Z1 |andneur1  % поступает строка X1,     %
%%%  Mlinlnm = | A2 B2 C2 .. Z2 |andneur2  % [X1 X2 .. Xn]            %
%%%            | .. .. .. .. .. |........  %                          %
%%%            | An Bn Cn .. Zn |andneurN  %                          %
%%%                                        %                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef Andnlayer
  properties
    M           = 0;
    W           = 0;
    in          = 0;
    TypefunS    = 0;
    TypefunT    = 0;
    Mlinlnm   = cell(1,1);
    andn = cell(1,1);
    out = 0;
    
  end

  methods
      function obj = andnlayerinit(obj,W,in, Mlinlnm,TypefunTS)% инициализация нейрона
          obj.W       = W;               % количество фп для одной переменной
          obj.in      = in;              % количество фп для одной переменной
          obj.M       = size(in);        % количество фп для одной переменной
          obj.Mlinlnm = Mlinlnm;         % значение переменной
          obj.TypefunS= TypefunTS(1);    % параметры для функций принадлежности
          obj.TypefunT= TypefunTS(2);    % параметры для функций принадлежности
          
          for nAND=1:obj.M(1)
              neuron = Andneuron;
              obj.andn{nAND} = neuron;
              obj.andn{nAND} = andinit(obj.andn{nAND},...
                                           obj.W(nAND,:),     ...
                                           obj.in(nAND,:),    ...
                                           obj.TypefunS,      ...
                                           obj.TypefunT);
          end
      end %function
    
    function obj = andnlayerStart(obj,in)
        if nargin < 2
        in = obj.in; % По умолчанию, если S не задан.
        else
        obj.in = in;
        end
        
          for nAND=1:obj.M
              obj.andn{nAND} = andneuron(obj.andn{nAND},obj.in)
              obj.out(nAND) = obj.andn{nAND}.out;
          end     
    end %function
    
  end
end
