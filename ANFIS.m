classdef ANFIS
  properties
    Qin             = 0; % количество входов
    MFQin           = 0; % матрица ФП
	MFQinparam      = 0; % матрица параметров ФП
    Qout            = 0; % количество выходов
    MFRQout         = 0; % матрица обратных ФП
	MFRQinparam     = 0; % матрица параметров обратных ФП
    mf_size         = 0; % количество ФП на переменную
    mfrev_size      = 0; % количество обратных ФП на переменную
    Mor             = 0; % количество И-нейронов
    Mand            = 0; % количество ИЛИ-нейронов
    TypefunTS_and_or= 0; % тип T-нормы и S-канормы для И-нейронов и ИЛИ-нейронов
    Typelayer       = 0; % матрица слоёв, которые будут применятся
    MlinkandQinMand = 0; % матрица связи  входов и И-нейронов
    MlinkorMandMor  = 0; % матрица связи   И-нейронов и ИЛИ-нейронов
    MF_layer        = 0; % слой ФП-нейрон
    AND_layer       = 0; % слой И-нейрон 
    OR_layer        = 0; % слой ИЛИ-нейрон  
    N_layer         = 0; % слой нормализующий нейрон 
    MFrev_layer     = 0; % слой обратный ФП-нейрон 
    range           = 0; % диапазон ФП 
    W               =[]; % весовая матрица для нормализирующего слоя 
    learn           = 0; % скорость обучения
    e               = 0; % ошибка
    set_e           = 0; % устанавливаение минимальной ошибки
    typemetod       = 0; % тип алгоритма
    Sugeno          = 0;
  end

  methods
      function obj = ANFISnet(obj,             ... % объект нейросети
                              Qin,             ... % количество входов
                              MFQin,           ... % матрица ФП
                              MFQinparam,      ... % матрица параметров ФП
                              Qout,            ... % количество выходов
                              MFRQout,         ... % матрица обратных ФП
                              MFRQinparam,     ... % матрица параметров обратных ФП
                              Mand,            ... % количество И-нейронов
                              Mor,             ... % количество ИЛИ-нейронов
                              MlinkandQinMand, ... % матрица связи  входов и И-нейронов
                              MlinkorMandMor   ... % матрица связи   И-нейронов и ИЛИ-нейронов 
                              )% инициализация нейросети
        
          obj.Qin             = Qin            ;
          obj.MFQin           = MFQin          ;
          obj.Qout            = Qout           ;
          obj.MFRQout         = MFRQout        ;
          obj.Mor             = Mor            ;
          obj.Mand            = Mand           ;
          obj.MlinkandQinMand = MlinkandQinMand;
          obj.MlinkorMandMor  = MlinkorMandMor ;
          obj.MFQinparam      = MFQinparam     ;
          obj.MFRQinparam     = MFRQinparam    ;
          obj.TypefunTS_and_or= [1 6]          ;
          obj.range           = 0:0.001:10    ;
          obj.mf_size         = size(obj.MFQin);
          obj.mfrev_size      = size(obj.MFRQout);
          obj.Typelayer       = "and";
          obj.typemetod       = "Sugeno";
          obj.Sugeno          = struct('b',{},'b0',{});
          obj.learn           = 0.01; 
          obj.set_e           = 0.001; 
          %% создаёс слои нейронов
          layer = Mfnlayer;
          obj.MF_layer = layer;
          clear layer;
          if ((obj.Typelayer == "and")||(obj.Typelayer == "and_or"))
              layer = Andnlayer;
              obj.AND_layer = layer;
          elseif (obj.Typelayer == "or")||(obj.Typelayer == "and_or")
              layer = Ornlayer;
              obj.OR_layer = layer;
          else
              layer = Andnlayer;
              obj.AND_layer = layer;
          end
          clear layer;
          layer = Nnlayer;
          obj.N_layer = layer;
          clear layer;
          layer = Mfrevnlayer;
          obj.MFrev_layer = layer;
          %% инициализипуем слои нейронов
          
          obj.MF_layer = mfnlayerinit(obj.MF_layer,  ... % объект нейросети
                                      obj.mf_size(1),... % количество ФП на переменную
                                      obj.Qin,       ... % количество входов X = [X1 X2 .. XN]
                                      obj.MFQin,     ... % матрица ФП
                                      obj.MFQinparam ... % матрица параметров ФП
                                     );% инициализация слоя
          
          if((obj.Typelayer == 'and')|| (obj.Typelayer == 'and_or'))                       
          obj.AND_layer = andnlayerinit(obj.AND_layer,      ... % объект нейросети
                                        obj.MF_layer.out,   ... % матрица значений на входе слоя
                                        obj.MlinkandQinMand,... % матрица связи  входов и И-нейронов
                                        obj.TypefunTS_and_or... % тип T-нормы и S-канормы для И-нейронов и ИЛИ-нейронов
                                       );% инициализация слоя
                                    N_layer_in = obj.AND_layer.out;
                                    MFREV_in = obj.AND_layer.out;
          end
          
          if((obj.Typelayer == 'or')|| (obj.Typelayer == 'and_or'))
          obj.OR_layer = ornlayerinit(obj.OR_layer,       ... % объект нейросети
                                      obj.MF_layer.out,   ... % матрица значений на входе слоя
                                      obj.MlinkandQinMand,... % матрица связи  входов и ИЛИ-нейронов
                                      obj.TypefunTS_and_or... % тип T-нормы и S-канормы для И-нейронов и ИЛИ-нейронов
                                     );% инициализация слоя
                                 N_layer_in = obj.OR_layer.out;
                                 MFREV_in = obj.OR_layer.out;
          end
          
          if isempty(obj.W)
          obj.W  = zeros(length(N_layer_in),length(N_layer_in))+1;  % инициализация весовой матрицы 
%           obj.W = w;
          end
          
          obj.N_layer = nnlayerinit(obj.N_layer,     ... % объект нейросети
                                    N_layer_in,... % матрица значений на входе слоя
                                    obj.W            ... % объект нейросети
                                    );% инициализация слоя
          if(obj.typemetod == "Tsukamoto")                      
          obj.MFrev_layer = mfrevnlayerinit(obj.MFrev_layer,  ... % объект нейросети
                                            obj.mfrev_size(1),... % количество ФП на переменную
                                            MFREV_in,... % матрица значений на входе слоя
                                            obj.MFRQout,      ... % матрица обратных ФП
                                            obj.MFRQinparam,  ... % матрица параметров обратных ФП
                                            obj.range         ... % объект нейросети
                                            );% инициализация слоя
          end
        if(obj.typemetod == "Sugeno")
            stract.b0{1} = 1;
            for nn=1:length(obj.Qin)
                stract.b{1}(nn) = 1;
            end
            obj.Sugeno = stract;
        end
    end %function
        
    function obj = simANFIS(obj,Xn)
        if(length(Xn) > length(obj.Qin))
            obj.Qin = Xn(1:length(obj.Qin));
        elseif (length(Xn) < length(obj.Qin))
            obj.Qin = obj.Qin*0;
            for K=1:length(obj.Qin)
                obj.Qin(K) = Xn(K);
            end
        else
            obj.Qin = Xn;
        end
        
        obj.MF_layer = mfnlayerStart(obj.MF_layer,obj.Qin);% инициализация нейрона
        
        if((obj.Typelayer == "and")|| (obj.Typelayer == "and_or"))  
        obj.AND_layer = andnlayerStart(obj.AND_layer,obj.MF_layer.out);% инициализация нейрона
        N_in = obj.AND_layer.out;
        MFREV_in = obj.AND_layer.out;
        end
        
        if((obj.Typelayer == "or")|| (obj.Typelayer == "and_or"))
        obj.OR_layer = ornlayerStart(obj.OR_layer,obj.MF_layer.out);% инициализация нейрона
        N_in = obj.OR_layer.out;
        MFREV_in = obj.OR_layer.out;
        end
        
        obj.N_layer = nnlayerStart(obj.N_layer,N_in);
        
        numpravil =1;
        
        
        if(obj.typemetod == "Tsukamoto")
        obj.MFrev_layer = mfrevnlayerStart(obj.MFrev_layer,MFREV_in);% инициализация нейрона
        obj.Qout  = sum(obj.MFrev_layer.out.* obj.N_layer.out);
        elseif(obj.typemetod == "Sugeno")
            for i=1:numpravil
              f_conclusion(i) = obj.Sugeno.b0{i} + sum(obj.Sugeno.b{i}*sin(2*obj.Qin)*exp(-0.1*obj.Qin));
            end
           obj.Qout  = sum(obj.N_layer.out.*f_conclusion);
           
        end

              
        if(1)
        obj.MFrev_layer.mfrevnlayerplot();
        figure(2)
        obj.MF_layer.mfnlayerplot();
        end
    end %function
        
    function obj = trainANFIS(obj,Xn,Yn)
        obj = simANFIS(obj,Xn);
        obj.e = 0.5*(Yn-obj.Qout).^2;
        num =0;
        while(obj.set_e < obj.e)
            numpravil =1;
            MF_size = size(obj.MFQinparam);
            
            if(obj.typemetod == "Sugeno")
                for i =1:numpravil
                    obj.Sugeno.b0{i} = obj.Sugeno.b0{i}-obj.learn*2*(obj.Qout-Yn)*obj.N_layer.out(i);
                    for j = 1:(length(obj.Sugeno.b))
                        obj.Sugeno.b{i}(i) = obj.Sugeno.b{i}(i)-obj.learn*(obj.Qout-Yn)*obj.N_layer.out(i)*obj.Qin(j);
                    end
                end
                
                for i=1:MF_size(1)
                    for j=1:MF_size(2)
                        for k=1:length(obj.MFQinparam{i,j})
                            n =  obj.MF_layer.mfneuron{i,j};
                            na = mf(n, obj.MFQinparam{i,j}(k));
                            if(na == Inf) na = obj.range(end); end
                            obj.MFQinparam{i,j}(k) = obj.MFQinparam{i,j}(k) - obj.learn*(na-Yn);
                        end
                    end
                end
                obj.MF_layer = mfnlayernewparam(obj.MF_layer,obj.MFQinparam);
            end
             
        if( obj.typemetod == "Tsukamoto"  )    
            MF_size = size(obj.MFQinparam);
            MFR_size= size(obj.MFRQinparam);
            
            for i=1:MFR_size(1) % количество строк
                for j=1:MFR_size(2) % количество столбцов
                    for k=1:length(obj.MFRQinparam{i,j})  % длинна элемента
                         n =  obj.MFrev_layer.mfrevneuron{i,j};
                         na = mfrev(n, obj.MFRQinparam{i,j}(k));
                         if(na == Inf) na = obj.range(end); end
                        obj.MFRQinparam{i,j}(k) = obj.MFRQinparam{i,j}(k) -obj.learn*(Yn-obj.Qout);
                    end
                end
            end
           

                 
            obj.MFrev_layer = mfrevnlayernewparam(obj.MFrev_layer,obj.MFRQinparam);
            obj.MF_layer = mfnlayernewparam(obj.MF_layer,obj.MFQinparam);
        end
         
            obj = simANFIS(obj,Xn);
            obj.e = 0.5*(Yn-obj.Qout).^2;
            disp('e')
            obj.e
            num = num +1;
            if(num == 100)
               break
            end
        end
    end %function
  end
end