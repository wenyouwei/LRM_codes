function [Xnew] = PatchHardLRTh(X,NLBLK,GridX,GridY,SigmaVec,Param,Height)

PatchNO    = Param.PatchNO;       PatchSize  = Param.PatchSize;
Xnew  = zeros(size(X));

LGridH  =   length(GridX);    
LGridW  =   length(GridY); 

for  i  =  1 : LGridH
    for  j  =  1 : LGridW    
        kk      =  (j-1)*LGridH + i;
        Temp    = X(:, NLBLK(:,kk));      
        MTemp   = repmat(mean(Temp, 2),1,PatchNO);
        Temp    = Temp - MTemp ;
            
        lambda  = SigmaVec((GridY(j)-1)*(Height-PatchSize+1) + GridX(i)); 
        ETemp 	= LRM(Temp, Param.c,lambda) + MTemp ; % RM Estimation of low rank image patch matrix
   
        Xnew(:,NLBLK(:,kk))  = Xnew(:,NLBLK(:,kk))+ETemp;      
    end
end