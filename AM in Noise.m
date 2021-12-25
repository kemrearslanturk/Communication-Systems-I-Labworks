
%9.1.Construction
%a
img = imread('cameraman.tif');
M = im2double(img);
%b
Fs=numel(M);
%c
y=reshape(M,1,numel(M));
t=0:(1/Fs):(numel(y)-1)/Fs;
%d
fc = 20000;  c_t = cos(2*pi*fc*t);
%9.2.Modulation
%a
in=(y).*(c_t);
%b
snr_1=0; snr_2=5; snr_3=10; snr_4=20; snr_5=30;
out_1= awgn(in,snr_1,'measured');
out_2= awgn(in,snr_2,'measured');
out_3= awgn(in,snr_3,'measured');
out_4= awgn(in,snr_4,'measured');
out_5= awgn(in,snr_5,'measured');

%9.3.Demodulation and Filtering
%a
phase=0; Acprime=2;
oscillator=Acprime*cos(2*pi*fc*t+phase);


%v_t = in .* oscillator;
%N = numel(M);
%inf =fft(y, N);
%f=linspace(-Fs/2,+Fs/2,N);

%figure
%plot(f, fftshift(abs(inf)/N));
%title('fourier of v(t)');
%xlabel('frequency (Hz)');
%ylabel('amplitude');

v_1=(out_1).*(oscillator);
v_2=(out_2).*(oscillator);
v_3=(out_3).*(oscillator);
v_4=(out_4).*(oscillator);
v_5=(out_5).*(oscillator);
[x,y] = butter(2,(12000/(Fs/2)));
res_1=filter(x,y,v_1);
res_2=filter(x,y,v_2);
res_3=filter(x,y,v_3);
res_4=filter(x,y,v_4);
res_5=filter(x,y,v_5);
%b
matrice_1=reshape(res_1,256,256);
matrice_2=reshape(res_2,256,256);
matrice_3=reshape(res_3,256,256);
matrice_4=reshape(res_4,256,256);
matrice_5=reshape(res_5,256,256);


%9.4.Plots

figure
subplot(3,2,1);
imshow(M);
title('Original Image');
subplot(3,2,2);
imshow(matrice_1);
title('Demodulated Image with SNR=0dB');
subplot(3,2,3);
imshow(matrice_2);
title('Demodulated Image with SNR=5dB');
subplot(3,2,4);
imshow(matrice_3);
title('Demodulated Image with SNR=10dB');
subplot(3,2,5);
imshow(matrice_4);
title('Demodulated Image with SNR=20dB');
subplot(3,2,6);
imshow(matrice_5);
title('Demodulated Image with SNR=30dB');
%9.5.Mean Square Error (MSE) and compariso
MSE1=MSE_KorkutEmre_Arslanturk(M,matrice_1);
MSE2=MSE_KorkutEmre_Arslanturk(M,matrice_2);
MSE3=MSE_KorkutEmre_Arslanturk(M,matrice_3);
MSE4=MSE_KorkutEmre_Arslanturk(M,matrice_4);
MSE5=MSE_KorkutEmre_Arslanturk(M,matrice_5);

snr=[snr_1 snr_2 snr_3 snr_4 snr_5];
MSE=[MSE1 MSE2 MSE3 MSE4 MSE5];
figure

plot(snr,MSE);
title(' Graph of MSE values with respect to SNR values');
xlabel('SNR Values');
ylabel('MSE Values');
