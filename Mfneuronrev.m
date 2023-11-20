function [mfneuronrev]=Mfneuronrev(level,MF)
    
mfneuronrev.MF = MF;
mfneuronrev.level = level;

mfneuronrev.calculateValue = @(level) neuron.MF(level);
end