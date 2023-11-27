classdef Mfneuronrev
  properties
    level    =0;
    MF       =0;
    param    =0;
    out      =0;
    f_out    ={};
  end

  methods
      function obj = Mfrevinit(obj,level, MF, param)% инициализация нейрона
      obj.MF       = MF;      % вектор значений
      obj.level    = level;   % тип канормы
      obj.param    = param;   % тип канормы
      
        if(isequal(obj.MF,@trimf))
            syms a x d;
            f{1} = 0;
            f{2} = (x-a)/(d-a);
            f{3} = (a-x)/(d-a);
            f{4} = 0;
            obj.f_out{1,1} = 0;
            obj.f_out{1,2} = 0;
            for i=2:3
            inv{i} = finverse(f{i});
            dif_a{i} = diff(inv{i},a);
            dif_c{i} = diff(inv{i},d);
            obj.f_out{i,1} = matlabFunction(dif_a{i});
            obj.f_out{i,2} = matlabFunction(dif_c{i});
            end
            obj.f_out{4,1} = 0;
            obj.f_out{4,2} = 0;
        elseif(isequal(obj.MF,@trapmf))
        elseif(isequal(obj.MF,@dsigmf))
        elseif(isequal(obj.MF,@gauss2mf))
            syms a x c;
            f = exp(-((x-c)^2)/(2*a^2));
            inv = finverse(f);
            dif_a = diff(inv,a);
            dif_c = diff(inv,c);
            obj.f_out{1,1} = matlabFunction(dif_a);
            obj.f_out{1,2} = matlabFunction(dif_c);
        elseif(isequal(obj.MF,@gaussmf))
            syms a x c;
            f = exp(-((x-a)^2)/(2*c^2));
            inv = finverse(f);
            dif_a = diff(inv,a);
            dif_c = diff(inv,c);
            obj.f_out{1,1} = matlabFunction(dif_a);
            obj.f_out{1,2} = matlabFunction(dif_c);
        elseif(isequal(obj.MF,@gbellmf))
        elseif(isequal(obj.MF,@pimf))
        elseif(isequal(obj.MF,@psigmf))
        elseif(isequal(obj.MF,@sigmf))
            syms a x c;
            f = 1/(1+exp(-a*(x+c)));
            inv = finverse(f); 
            dif_a = diff(inv,a);
            dif_c = diff(inv,c);
            obj.f_out{1,1} = matlabFunction(dif_a);
            obj.f_out{1,2} = matlabFunction(dif_c);
        elseif(isequal(obj.MF,@smf))
        else(isequal(obj.MF,@zmf))
        end
    end %function
    
    function obj = mfneuronrev(obj,range,level)
        if nargin < 3
          level = obj.level; % По умолчанию, если S не задан.
        else
          obj.level =  level;
        end
        
        mf_out = obj.MF(range,obj.param);
        MK = 100;
        [~, ind] = min(abs((mf_out-obj.level).*MK));
        obj.out = range(ind);
        
    end %function
    
      function mfrevPlot(obj)
        x = 0:0.1:20;
        plot(x, obj.MF(x, obj.param));
    end %function
    
    function obj = mfrevnewparam(obj,new_param)
        obj.param =new_param;
    end
    
     function out = mfrev(obj,param)
        if(isequal(obj.MF,@trimf))
            for i=2:3
                if(obj.param(1) ==param)||(obj.param(2) ==param)||(obj.param(3) ==param)
                    if(obj.level == 0)
                       out =  obj.f_out{1,1}();
                       break
                    elseif(obj.level > 0)
                        out =  obj.f_out{i,1}(obj.level);
                        break
%                         out =  obj.f_out{3,i}(obj.level);
                    end
                end
            end
        elseif(isequal(obj.MF,@trapmf))
        elseif(isequal(obj.MF,@dsigmf))
        elseif(isequal(obj.MF,@gauss2mf))
            if(obj.param(1) ==param)
            out = obj.f_out{1,1}(obj.level);
            else
            out = obj.f_out{1,2}(obj.level);   
            end
        elseif(isequal(obj.MF,@gaussmf))
            if(obj.param(1) ==param)
                out = obj.f_out{1,1}();
            else
                out = obj.f_out{1,2}(obj.level);
            end
        elseif(isequal(obj.MF,@gbellmf))
        elseif(isequal(obj.MF,@pimf))
        elseif(isequal(obj.MF,@psigmf))
        elseif(isequal(obj.MF,@sigmf))
            if(obj.param(1) ==param)
                out = obj.f_out{1,1}(obj.param(1),obj.param(1),obj.level);
            else
                out = obj.f_out{1,2}();
            end
        elseif(isequal(obj.MF,@smf))
        else(isequal(obj.MF,@zmf))
        end
    end
  end
end