  

 
img = double(imread('monarch.png'));        % Original image


sigma  = 100;                               % Gaussian noise level
[M,N]=size(img);
    
randn('seed',0);
nimg  = img + sigma * randn(size(img));     % Generate noisy image
npsnr = psnr(nimg,img,0,0);
fprintf( 'Noise level: Sigma  = %2.3f, Noisy psnr = %2.2f \n\n\n',sigma,npsnr);

Param   = LRMParamSet(sigma); 
profile on;
tic
dnimg = GaussianDenoisingHardLRMTh(nimg,img, Param);
toc
profile viewer
profile off

dnpsnr  = psnr(img,dnimg,0,0);
dnssim  = ssim(img,dnimg,0,0);
mae     = norm(img(:)-dnimg(:),1)/(M*N);
fprintf( 'Denoised: PSNR = %2.3f, SSIM = %.4f, MAE=%2.2f \n\n\n',dnpsnr,dnssim,mae); 
      
imshow(uint8(dnimg));
