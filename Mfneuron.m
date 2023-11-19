function [out]=Mfneuron(x,MF, param)
    if nargin < 3
        a = round(length(x)/2);
        param = [x(1) x(a) x(end)];
    end

out = MF(x, param);
end
