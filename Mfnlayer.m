function [Z]=Mfnlayer(N, Xn, MFn, param)
Size = length(MFn)/2;

for i=1:Size
if nargin < 4
    if(MFn(2*i)=='dsigmf')
     a = round(length(Xn)/2);
     b = round(length(Xn)/4);
     param{i} = [Xn(1) Xn(b) Xn(a) Xn(end)];  end
    else if(MFn(2*i)=='gauss2mf')
     a = round(length(Xn)/2);
     b = round(length(Xn)/4);
     param{i} = [Xn(1) Xn(b) Xn(a) Xn(end)];      end 
    else if(MFn(2*i)=='gaussmf')
     a = round(length(Xn)/2);
     b = round(length(Xn)/4);
     param{i} = [Xn(b) Xn(a)];      end  
    else if(MFn(2*i)=='gbellmf')
     a = round(length(Xn)/2);
     b = round(length(Xn)/4);
     param{i} = [Xn(1) Xn(a) Xn(end)];  end
    else if(MFn(2*i)=='pimf')
     a = round(length(Xn)/2);
     b = round(length(Xn)/4);
     param{i} = [Xn(1) Xn(b) Xn(a) Xn(end)]; end 
    else if(MFn(2*i)=='psigmf')
     a = round(length(Xn)/2);
     b = round(length(Xn)/4);
     param{i} = [Xn(1) Xn(b) Xn(a) Xn(end)];  end
    else if(MFn(2*i)=='sigmf')
     a = round(length(Xn)/2);
     b = round(length(Xn)/4);
     param{i} = [Xn(b) Xn(a)];  end
    else if(MFn(2*i)=='smf')
     a = round(length(Xn)/2);
     b = round(length(Xn)/4);
     param{i} = [Xn(b) Xn(a)];   end
    else if(MF(2*i)=='trapmf')
     a = round(length(Xn)/2);
     b = round(length(Xn)/4);
     param{i} = [Xn(1) Xn(b) Xn(a) Xn(end)];  end
    else if(MFn(2*i)=='trimf')
     a = round(length(x)/2);
     param{i} = [x(1) x(a) x(end)]; end
    else if(MFn(2*i)=='zmf')
     a = round(length(Xn)/2);
     b = round(length(Xn)/4);
     param{i} = [Xn(b) Xn(a)];  
     end
end
end

mfnlayer.N  = N;
mfnlayer.Xn  = Xn;
mfnlayer.MFn  = MFn;
mfnlayer.param = param;
k = 0;
for i=1:Size
    for j=1:MFn(2*i-1)
        k = k+1;
        if(MFn(2*i)=='dsigmf')
          mfnlayer.mfn(k)  = dsigmf(Xn(k),param{i});  
        else if(MFn(2*i)=='gauss2mf')
          mfnlayer.mfn(k)  = gauss2mf(Xn(k),param{i});      
        else if(MFn(2*i)=='gaussmf')
          mfnlayer.mfn(k) = gaussmf(Xn(k),param{i});      
        else if(MFn(2*i)=='gbellmf')
          mfnlayer.mfn(k) = gbellmf(Xn(k),param{i}); 
        else if(MFn(2*i)=='pimf')
          mfnlayer.mfn(k) = pimf(Xn(k),param{i}); 
        else if(MFn(2*i)=='psigmf')
          mfnlayer.mfn(k)  = psigmf(Xn(k),param{i}); 
        else if(MFn(2*i)=='sigmf')
          mfnlayer.mfn(k)  = sigmf(Xn(k),param{i}); 
        else if(MFn(2*i)=='smf')
          mfnlayer.mfn(k)  = smf(Xn(k),param{i}); 
        else if(MFn(2*i)=='trapmf')
          mfnlayer.mfn(k) = trapmf(Xn(k),param{i}); 
        else if(MFn(2*i)=='trimf')
          mfnlayer.mfn(k) = trimf(Xn(k),param{i}); 
        else if(MFn(2*i)=='zmf')
          mfnlayer.mfn(k) = zmf(Xn(k),param{i}); 
        end
    end
end
k = 0;
end