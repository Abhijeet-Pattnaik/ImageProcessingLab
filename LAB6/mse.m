clc;
clear all;
close all;
we = [1 2 1; 2 4 2; 1 2 1];
im_o = imread('cameraman.tif');
im_double = im2double(im_o);

im_noise_wopad = imnoise(im_double, 'gaussian');
im_noise = padarray(im_noise_wopad,[1,1]);
[m,n] = size(we);
[r,c] = size(im_o);
%weighted average
q = 0.67;
for i = 2:r
    for j = 2:c
        im_w_avg(i,j) = sum(sum(we.*im_noise(i-1:i+1,j-1:j+1)))/16;
        im_avg_f(i,j) =  sum(sum(im_noise(i-1:i+1,j-1:j+1)))/9;
        im_geom_mean(i,j) = prod(prod(im_noise(i-1:i+1,j-1:j+1)))^(1/9);
        im_harmonic(i,j) = 9/sum(sum(1./im_noise(i-1:i+1,j-1:j+1)));
        im_contra_har(i,j) = (sum(sum(im_noise(i-1:i+1,j-1:j+1))))^(q+1) / (sum(sum(im_noise(i-1:i+1,j-1:j+1))))^(q);
    end
end
mse_w_avg = sum(sum((im_w_avg - im_noise_wopad).^2));
mse_avg_f = sum(sum((im_avg_f - im_noise_wopad).^2));
mse_geom_mean = sum(sum((im_geom_mean - im_noise_wopad).^2));
mse_harmonic = sum(sum((im_harmonic - im_noise_wopad).^2));
mse_contra_har = sum(sum((im_contra_har - im_noise_wopad).^2));

snr_w_avg = sum(sum((im_w_avg ).^2/mse_w_avg));
snr_avg_f = sum(sum((im_avg_f ).^2/mse_avg_f));
snr_geom_mean = sum(sum((im_geom_mean ).^2/mse_geom_mean));
snr_harmonic = sum(sum((im_harmonic ).^2/mse_harmonic));
snr_contra_har = sum(sum((im_contra_har ).^2/mse_contra_har));

psnr_w_avg =(255*255)/mse_w_avg;
psnr_avg_f =(255*255)/mse_avg_f;
psnr_geom_mean =(255*255)/mse_geom_mean;
psnr_harmonic =(255*255)/mse_harmonic;
psnr_contra_har =(255*255)/mse_contra_har;


% subplot(2,4,1);imshow(im);title('original image');
% subplot(2,4,2);imshow(im_noise,[]);title('image with gaussian noise');
% subplot(2,4,3);imshow(im_w_avg,[]);title('weighted average filter');
% subplot(2,4,4);imshow(im_avg_f,[]);title('arithmatic mean filter');
% subplot(2,4,5);imshow(im_geom_mean,[]);title('geometric mean filter');
% subplot(2,4,6);imshow(im_harmonic,[]);title('Harmonic mean filter');
% subplot(2,4,7);imshow(im_contra_har,[]);title('contra harmonic mean filter');
