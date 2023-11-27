classdef Mfneuron
  properties
    Xn       =0;
    param    =0;
    MF       =0;
    out      =0;
    f_out    ={};
  end

  methods
    function obj = mfinit(obj,Xn,MF, param)% инициализация нейрона
      obj.Xn       = Xn;          % вес
      obj.MF       = MF;         % вектор значений
      obj.param    = param;   % тип канормы
      
       if(isequal(obj.MF,@trimf))
            if(obj.Xn < param(1))
                out = param(1);
            elseif(param(1)<=obj.Xn<= param(2))
                syms X;
                f(X) = (X-param(1))/(param(2)-param(1));
                inv = finverse(f);
                out = double(inv(obj.Xn));
            elseif( param(2)<=obj.Xn<=param(3))
                syms X;
                f(X) = (param(3)-X)/(param(3)-param(2));
                inv = finverse(f);
                out = double(inv(obj.Xn));
            else(obj.Xn>param(3));
                out = param(3);
            end
        elseif(isequal(obj.MF,@trapmf))
            if(obj.level < param(1))
                out = param(1);
            elseif(param(1)<=obj.level<= param(2))
                syms X;
                f(X) = (X-param(1))/(param(2)-param(1));
                inv = finverse(f);
                out = double(inv(obj.level));
            elseif( param(2)<=obj.level<=param(3))
                syms X;
                out = (param(1)+param(2))/2;
            elseif( param(3)<=obj.level<=param(4))
                syms X;
                f(X) = (param(4)-X)/(param(4)-param(3));
                inv = finverse(f);
                out = double(inv(obj.level));
            else(obj.level>param(4));
                out = param(3);
            end
        elseif(isequal(obj.MF,@dsigmf))
        elseif(isequal(obj.MF,@gauss2mf))
                syms a x c;
                f = exp(-((x-c)^2)/(2*a^2));
                dif_a = diff(f,a);
                dif_c = diff(f,c);
                obj.f_out{1,1} = matlabFunction(dif_a);
        elseif(isequal(obj.MF,@gaussmf))
                syms a x c;
                f = exp(-((x-c)^2)/(2*a^2));
                dif_a = diff(f,a);
                dif_c = diff(f,c);
                obj.f_out{1,1} = matlabFunction(dif_a);
                obj.f_out{1,2} =matlabFunction(dif_c);
        elseif(isequal(obj.MF,@gbellmf))
        elseif(isequal(obj.MF,@pimf))
        elseif(isequal(obj.MF,@psigmf))
        elseif(isequal(obj.MF,@sigmf))               
                syms a x c;
                f = 1/(1+exp(-a*(x+c)));
                dif_a = diff(f,a);
                dif_c = diff(f,c);
                obj.f_out{1,1} = matlabFunction(dif_a);
                obj.f_out{1,2} = matlabFunction(dif_c);
        elseif(isequal(obj.MF,@smf))
        else(isequal(obj.MF,@zmf))
        end
    end %function
    
    function obj = mfneuron(obj,Xn)
        if nargin < 2
        Xn = obj.Xn; % По умолчанию, если S не задан.
        end
        obj.out = obj.MF(Xn, obj.param);
    end %function
    
    function mfPlot(obj)
        x = 0:0.1:20;
        plot(x, obj.MF(x, obj.param));
    end %function
    
    function obj = mfnewparam(obj,new_param)
        obj.param =new_param;
    end
    
        function out = mf(obj,param)
        if(isequal(obj.MF,@trimf))
        elseif(isequal(obj.MF,@trapmf))
        elseif(isequal(obj.MF,@dsigmf))
        elseif(isequal(obj.MF,@gauss2mf))
            if(obj.param(1) == param)
                out = obj.f_out{1,1}(obj.param(1),obj.param(2),obj.Xn);
            else
               out = obj.f_out{1,2}(obj.param(1),obj.param(2),obj.Xn);
            end
        elseif(isequal(obj.MF,@gaussmf))
            if(obj.param(1) ==param)
                out = obj.f_out{1,1}(obj.param(1),obj.param(2),obj.Xn);
            else
               out = obj.f_out{1,2}(obj.param(1),obj.param(2),obj.Xn);
            end
        elseif(isequal(obj.MF,@gbellmf))
        elseif(isequal(obj.MF,@pimf))
        elseif(isequal(obj.MF,@psigmf))
        elseif(isequal(obj.MF,@sigmf))
            if(obj.param(1) ==param)
                out = obj.f_out{1,1}(obj.param(1),obj.param(2),obj.Xn);
            else
                out = obj.f_out{1,2}(obj.param(1),obj.param(2),obj.Xn);
            end
        elseif(isequal(obj.MF,@smf))
        else(isequal(obj.MF,@zmf))
        end
    end
  end
end