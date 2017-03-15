function [u]   =  GaussianDenoisingHardLRMTh( g,imorg, Param )
% Copyright Mar. 14, 2017, Prof.WEN You-Wei
% email: wenyouwei@gmail.com 

u               = g;                                                       
[Height, Width] = size(u);   
PatchSize       = Param.PatchSize; 
X0              = Image2Patch(g, PatchSize); 
SigmaAA         = Param.nSig * ones(1, size(X0,2)); 
for ii = 1 : Param.Iter  
    u             	=	u + Param.delta*(g - u);
    X = Image2Patch(u, PatchSize);     
    if ii>1, 
        SigmaAA = Param.lamada*sqrt(abs(Param.nSig^2-mean((X0-X).^2)));
    end
    if (mod(ii-1,Param.Innerloop)==0)
        Param.PatchNO   = Param.PatchNO - 10 ;
        [NLBLK, WNL,GridX,GridY]  =  ImNLPatchMatch(X, Param, Height, Width);
        Weight = Patch2Image(WNL, PatchSize, Height, Width);
    end
    
    [Xnew] = PatchHardLRTh(X,NLBLK,GridX,GridY,SigmaAA,Param, Height);
    u      = Patch2Image(Xnew,PatchSize, Height, Width)./(Weight + eps);     
    PSNR   = psnr( imorg, u, 0, 0 );    
    fprintf( 'ii = %2.3f, PSNR = %2.2f \n', ii, PSNR );
end
