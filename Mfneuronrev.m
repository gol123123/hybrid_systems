function [out]=Mfneuronrev(x,MF, lever)
    if nargin < 3
        a = round(length(x)/2);
        lever = [x(1) x(a) x(end)];
    end

out = MF(x, lever);
end