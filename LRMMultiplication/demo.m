clear all;
close all;




img = double(imread('camera.tif'));  % Original image




idx=find(img==0); img(idx)=0.001;
[M,N] = size(img);  

% Corrupt by multiplicative noise: mean of iid ~ Exp(sigma). This sum is distributed ~ Gamma(K,K/sigma).
K=10;                                                                % set noise level
noise = reshape(mean(exponential_rnd(1,M*N,K),2),M,N);
nimg = img .* noise; 

npsnr  =  psnr( img,nimg,0,0);
fprintf( 'Noise level: K = %2f, PSNR = %2.2f \n\n\n', K, npsnr);


%  Estimate the delta parameter
lgnimg=log(nimg);                                                   % log transformation
[C1,L1] = wavedec(lgnimg,4,'db3');
C1=reshape(C1,1,[]);STDC1 = wnoisest(C1);
nsig=STDC1;
Par   = LRMParamSet(nsig,K);   
profile on
tic;
dnimg = MultipDenoisingHardLRMTh(lgnimg,img,Par);           %  Rank minimization denoising function
toc;
profile viewer
   
dnimg =exp(dnimg)*(mean(nimg)/mean(exp(dnimg)));                    %Exp transformation and scaling to keep the mean
dnpsnr  = psnr( img, dnimg,0,0);
dnssim = ssim(img,dnimg,0,0);
mae=norm(img(:)-dnimg(:),1)/(M*N);
fprintf( 'Recovered: PSNR = %2.3f, SSIM = %.4f ,MAE=%2.2f\n\n\n', dnpsnr,dnssim,mae); 
imshow(uint8(dnimg));

      


