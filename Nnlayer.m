function [obj]=Nnlayer(N,Xn,Mlinlnm)
    
    obj.N = N;
    obj.Mlinlnm = Mlinlnm;
    obj.Xn = Xn;
    obj.Nneuron = @Nneuron;
    for i=1:N
        obj.input(i,:) =  obj.Xn(i)*obj.Mlinlnm(i,:);
    end
    for i=1:obj.N
       output = obj.Nneuron(obj.input(i,:),obj.input(i,i));
       obj.output(i) = output;
    end
end

anfis