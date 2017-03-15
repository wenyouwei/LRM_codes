function  [Param]=LRMParamSet(nSig,K)

Param.nSig      =   nSig; 
Param.SearchWin =   25;     
Param.delta     =   0.1;    
Param.Innerloop =   2;       
Param.c         =   4*sqrt(2);    
if     K>=10       
    Param.PatchSize   =   7;             
    Param.PatchNO     =   80;             
    Param.Iter        =   9;                         
    Param.lamada      =   0.48;        
elseif K>= 4    
    Param.PatchSize   =   9;             
    Param.PatchNO     =   130;            
    Param.Iter        =   13;                         
    Param.lamada      =   0.60;  
elseif K>=2  
    Param.PatchSize   =   10;             
    Param.PatchNO     =   140;        
    Param.Iter        =   14;                         
    Param.lamada      =   0.70;  
else  
    Param.PatchSize   =   11;        
    Param.PatchNO     =   150;        
    Param.Iter        =   14;                         
    Param.lamada      =   0.80;       
end
Param.step      =   floor((Param.PatchSize)/2-1);                   
