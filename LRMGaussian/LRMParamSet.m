function  [Param]=LRMParamSet(nSig)

Param.nSig      =   nSig; 
Param.SearchWin =   30;     
Param.delta     =   0.1;    
Param.Innerloop =   2;       
Param.c         =   6*sqrt(2);    %4*sqrt(2) for images images with size 512*512 or 512*768
if nSig<=20       
    Param.PatchSize   =   6;             
    Param.PatchNO     =   60;     %70          
    Param.Iter        =   8;                         
    Param.lamada      =   0.54;   %0.67      
elseif nSig <= 40    
    Param.PatchSize   =   7;             
    Param.PatchNO     =   80;            
    Param.Iter        =   10;                         
    Param.lamada      =   0.60;   %0.7   
elseif nSig<=60  
    Param.PatchSize   =   8;             
    Param.PatchNO     =   90;     %100         
    Param.Iter        =   12;                         
    Param.lamada      =   0.62;   %0.71   
else  
    Param.PatchSize   =   9;        
    Param.PatchNO     =   120;    %130         
    Param.Iter        =   14;                         
    Param.lamada      =   0.62;   %0.72      
end
Param.step      =   floor((Param.PatchSize)/2-1);                   
