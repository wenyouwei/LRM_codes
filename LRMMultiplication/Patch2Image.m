function  Y  =  Patch2Image(Z, PatchSize, H, W)
% Copyright Jan. 25, 2017, Prof.WEN You-Wei
% email: wenyouwei@gmail.com 
    
H2   =   H - PatchSize + 1;          W2   = W - PatchSize + 1;
OffR =   0:H2-1;                     OffC = 0:W2-1;    
dimX = ndims(Z);
if dimX == 2
    d    = size(Z,1)/PatchSize/PatchSize;
elseif dimX == 4
    d    = size(Z,3);
end

Y  	 =  zeros(H, W, d);
L    =   0;
   
for k = 1:d
    for i  = 1:PatchSize
        for j  = 1:PatchSize
            L = L + 1; 
            if dimX == 2
                tmp = Z(L,:); %row, should be rearrange as image
            else
                tmp = Z(i,j,k,:);
            end
            Y(OffR+i,OffC+j, k)  =  Y(OffR+i,OffC+j, k) + reshape(tmp, [H2 W2]);
        end
    end    
end
% whos Y;

