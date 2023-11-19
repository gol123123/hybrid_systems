function [out]=Nneuron(Slinkn,signal)
out = signal/sum(Slinkn);
end