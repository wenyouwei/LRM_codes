function  [NLBLK, WNL,GridX,GridY]  =  ImNLPatchMatch(X, Param, Height, Width)
%   Copyright(c), March 14, 2017, Prof. WEN You-wei(wenyouwei@gmail.com)

PatchNO  = 30;          PatchSize  = 8;  SW  = 20; s = 1; 
if isfield(Param,'PatchNO'),        PatchNO    = Param.PatchNO;    end
if isfield(Param,'PatchSize'),      PatchSize  = Param.PatchSize;  end
if isfield(Param,'SearchWin'),      SW         = Param.SearchWin;  end
if isfield(Param,'step'),           s          = Param.step;       end
ImClipH   =   Height - PatchSize +1;
ImClipW   =   Width  - PatchSize +1;

GridX	=   1:s:ImClipH;
GridX	=   [GridX GridX(end)+1:ImClipH];
GridY	=   1:s:ImClipW;
GridY	=   [GridY GridY(end)+1:ImClipW];

Idx     =   (1:ImClipH*ImClipW);
Idx     =   reshape(Idx, ImClipH, ImClipW);
LGridH  =   length(GridX);    
LGridW  =   length(GridY); 

NLBLK = zeros(PatchNO,LGridH * LGridW);
WNL   = zeros(size(X));

for  i  =  1 : LGridH
    for  j  =  1 : LGridW    
        x      =   GridX(i);              y      =   GridY(j);
        top    =   max( x-SW, 1 );        button =   min( x+SW, ImClipH );        
        left   =   max( y-SW, 1 );        right  =   min( y+SW, ImClipW );     
        
        kk     =  (j-1)*LGridH + i;
        NL_Idx =   Idx(top:button, left:right);
        NL_Idx =   NL_Idx(:);
        
        RefPatch  = X(:,(y-1)*ImClipH + x);
        Neighbors = X(:,NL_Idx); 
        %NLBLKdiff   = bsxfun(@minus,Neighbors,RefPatch);        
        %Dist        = sum(NLBLKdiff.^2);
        Dist   = sum((repmat(RefPatch,1,size(Neighbors,2))-Neighbors).^2); 
        [~, idx]    = sort(Dist);
        NLBLK(:,kk) = NL_Idx(idx(1:PatchNO));
        WNL(:,NLBLK(:,kk)) = WNL(:,NLBLK(:,kk)) + 1; 
    end
end
