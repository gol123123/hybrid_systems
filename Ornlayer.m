%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%              X1 X2 X3 .. Xn            % в каждый И-нейрон        %
%%%            | A1 B1 C1 .. Z1 |andneur1  % поступает строка X1,     %
%%%  Mlinlnm = | A2 B2 C2 .. Z2 |andneur2  % [X1 X2 .. Xn]            %
%%%            | .. .. .. .. .. |........  %                          %
%%%            | An Bn Cn .. Zn |andneurN  %                          %
%%%                                        %                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef Ornlayer
  properties
    M           = 0;
    W           = 0;
    in          = 0;
    TypefunS    = 0;
    TypefunT    = 0;
    Mlinlnm   = cell(1,1);
    orn = cell(1,1);
    out = 0;
    
  end

  methods
      function obj = ornlayerinit(obj,in, Mlinlnm,TypefunTS)% инициализация нейрона
          obj.in      = in;              % количество фп для одной переменной
          obj.M       = size(in);        % количество фп для одной переменной
          obj.Mlinlnm = Mlinlnm;         % значение переменной
          obj.TypefunS= TypefunTS(1);    % параметры для функций принадлежности
          obj.TypefunT= TypefunTS(2);    % параметры для функций принадлежности
          
          for nOR=1:obj.M(1)
              neuron = Orneuron;
              obj.orn{nOR} = neuron;
              obj.orn{nOR} = orinit(obj.orn{nOR},           ...
                                           obj.Mlinlnm(nOR,:),  ...
                                           obj.in(nOR,:),       ...
                                           obj.TypefunS,         ...
                                           obj.TypefunT);
          end
          obj.out =  zeros(1,obj.M(1));
      end %function
    
    function obj = ornlayerStart(obj,in)
        if nargin < 2
        in = obj.in; % По умолчанию, если S не задан.
        else
        obj.in = in;
        end
        
          for nOR=1:obj.M
              obj.orn{nOR} = orneuron(obj.orn{nOR},obj.in(nOR,:))
              obj.out(nOR) = obj.orn{nOR}.out;
          end     
    end %function
    
  end
end