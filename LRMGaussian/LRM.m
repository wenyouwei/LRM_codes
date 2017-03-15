function  [X] =  LRM( Y, C, NSig)
   
[U,SigmaY,V] = svd((Y),'econ');    
PatNum       = size(Y,2);
C            = sqrt(2*C*sqrt(PatNum))*NSig;
idx          = find(SigmaY>C);
svp          = length(idx);
SigmaX       = SigmaY(idx);
X =  U(:,1:svp)*diag(SigmaX)*V(:,1:svp)';     