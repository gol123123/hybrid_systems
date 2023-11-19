function [Z]=Mfnlayer(N, Xn, MF, param)
Size = length(MF)/2;
for i=1:Size
    if nargin < 4
        if(MF(2*i)=='dsigmf')
         a = round(length(Xn)/2);
         b = round(length(Xn)/4);
         param{i} = [Xn(1) Xn(b) Xn(a) Xn(end)];  end
        else if(MF(2*i)=='gauss2mf')
         a = round(length(Xn)/2);
         b = round(length(Xn)/4);
         param{i} = [Xn(1) Xn(b) Xn(a) Xn(end)];      end 
        else if(MF(2*i)=='gaussmf')
         a = round(length(Xn)/2);
         b = round(length(Xn)/4);
         param{i} = [Xn(b) Xn(a)];      end  
        else if(MF(2*i)=='gbellmf')
         a = round(length(Xn)/2);
         b = round(length(Xn)/4);
         param{i} = [Xn(1) Xn(a) Xn(end)];  end
        else if(MF(2*i)=='pimf')
         a = round(length(Xn)/2);
         b = round(length(Xn)/4);
         param{i} = [Xn(1) Xn(b) Xn(a) Xn(end)]; end 
        else if(MF(2*i)=='psigmf')
         a = round(length(Xn)/2);
         b = round(length(Xn)/4);
         param{i} = [Xn(1) Xn(b) Xn(a) Xn(end)];  end
        else if(MF(2*i)=='sigmf')
         a = round(length(Xn)/2);
         b = round(length(Xn)/4);
         param{i} = [Xn(b) Xn(a)];  end
        else if(MF(2*i)=='smf')
         a = round(length(Xn)/2);
         b = round(length(Xn)/4);
         param{i} = [Xn(b) Xn(a)];   end
        else if(MF(2*i)=='trapmf')
         a = round(length(Xn)/2);
         b = round(length(Xn)/4);
         param{i} = [Xn(1) Xn(b) Xn(a) Xn(end)];  end
        else if(MF(2*i)=='trimf')
         a = round(length(x)/2);
         param{i} = [x(1) x(a) x(end)]; end
        else if(MF(2*i)=='zmf')
         a = round(length(Xn)/2);
         b = round(length(Xn)/4);
         param{i} = [Xn(b) Xn(a)];  
         end
    end
end

Size = length(MF)/2;

for i=1:Size
    for j=1:MF(2*i-1)
        if(MF(2*i)=='dsigmf')
          Z(i, :) = dsigmf(Xn,param{i});  
        else if(MF(2*i)=='gauss2mf')
          Z(i, :) = gauss2mf(Xn,param{i});      
        else if(MF(2*i)=='gaussmf')
          Z(i, :) = gaussmf(Xn,param{i});      
        else if(MF(2*i)=='gbellmf')
          Z(i, :) = gbellmf(Xn,param{i}); 
        else if(MF(2*i)=='pimf')
          Z(i, :) = pimf(Xn,param{i}); 
        else if(MF(2*i)=='psigmf')
          Z(i, :) = psigmf(Xn,param{i}); 
        else if(MF(2*i)=='sigmf')
          Z(i, :) = sigmf(Xn,param{i}); 
        else if(MF(2*i)=='smf')
          Z(i, :) = smf(Xn,param{i}); 
        else if(MF(2*i)=='trapmf')
          Z(i, :) = trapmf(Xn,param{i}); 
        else if(MF(2*i)=='trimf')
          Z(i, :) = trimf(Xn,param{i}); 
        else if(MF(2*i)=='zmf')
          Z(i, :) = zmf(Xn,param{i}); 
        end
    end
end


for i=1:N
out(i) = MF(Xn);    
end
end