classdef ANFIS
  properties
    Qin             = 0;
    MFQin           = 0;
    Qout            = 0;
    MFRQout         = 0;
    Mor             = 0;
    Mand            = 0;
    MlinkandQinMand = 0;
    MlinkorMandMor  = 0;
    mf_layer        = 0;
    AND_layer       = 0;
    OR_layer        = 0;
    N_layer         = 0;
    MFrev_layer     = 0;
    MFQinparam      = 0;
    MFRQinparam     = 0;
  end

  methods
      function obj = ANFISnet(obj,Qin, MFQin,MFQinparam, Qout, MFRQout,MFRQinparam, Mand, Mor, MlinkandQinMand, MlinkorMandMor)% инициализация нейрона
        
          obj.Qin             = Qin            ;
          obj.MFQin           = MFQin          ;
          obj.Qout            = Qout           ;
          obj.MFRQout         = MFRQout        ;
          obj.Mor             = Mor            ;
          obj.Mand            = Mand            ;
          obj.MlinkandQinMand = MlinkandQinMand;
          obj.MlinkorMandMor  = MlinkorMandMor ;
          obj.MFQinparam      = MFQinparam     ;
          obj.MFRQinparam     = MFRQinparam     ;
          
          mf_size = size(obj.MFQin)
          obj.mf_layer = Mfnlayer;
          obj.mf_layer = mfnlayerinit(obj.mf_layer,mf_size(1),obj.Qin, obj.MFQin, obj.MFQinparam)% инициализация нейрона
          
          TypefunTS = [1 6];
          
          obj.AND_layer = Andnlayer;
          obj.AND_layer = andnlayerinit(obj.AND_layer,obj.mf_layer.out, obj.MlinkandQinMand, TypefunTS);% инициализация нейрона
          
          obj.OR_layer = Ornlayer;
          obj.OR_layer = ornlayerinit(obj.OR_layer,obj.mf_layer.out, obj.MlinkandQinMand, TypefunTS);% инициализация нейрона
          
          W = zeros(obj.OR_layer.out,obj.OR_layer.out)+1;
          
          obj.N_layer = Nnlayer;
          obj.N_layer = nnlayerinit(obj.N_layer,obj.OR_layer.out, W);% инициализация нейрона
          
          range = 0:0.0001:10;
          
          obj.MFrev_layer = Mfrevnlayer;
          obj.MFrev_layer = mfrevnlayerinit(obj.MFrev_layer,obj.OR_layer.out,obj.MFRQout,obj.MFRQinparam,range);% инициализация нейрона
                 
    end %function
    
    function obj = mfrevnlayerStart(obj,Xn)
       
        obj.mf_layer = mfnlayerStart(obj.mf_layer)% инициализация нейрона
        obj.mf_layer.out
        
        obj.AND_layer = andnlayerStart(obj.AND_layer);% инициализация нейрона
        obj.AND_layer.out
        
        obj.OR_layer = ornlayerStart(obj.OR_layer);% инициализация нейрона
        obj.OR_layer.out
        
        obj.MFrev_layer = mfrevnlayerStart(obj.MFrev_layer,MFREV_in);% инициализация нейрона
        obj.MFrev_layer.out
        
        obj.Qout  = sum(obj.MFrev_layer.out .* obj.N_layer.out);
    end %function
  end
end