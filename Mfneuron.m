function [mfneuron]=Mfneuron(x,MF, param)
    if nargin < 3
        a = round(length(x)/2);
        param = [x(1) x(a) x(end)];
    end
mfneuron.x = x;
mfneuron.MF = MF;
mfneuron.param = param;
mfneuron.out = mfneuron.MF(mfneuron.x, mfneuron.param);
end
