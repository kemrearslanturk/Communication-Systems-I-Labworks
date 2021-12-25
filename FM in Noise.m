clc
clear all;
%Lab 9
%9.1 Construction

%a

x=load('gong');

%b
mt=x.y;
mt=mt';
Fs=x.Fs;
%c
t = 0:(1/Fs):(numel(mt) - 1)/Fs;
time=(1/Fs);
%d
Fc =2000;
c_t=cos(2*pi*Fc*t);
%Modulation
%a
Kf=10000;
Xfm=cos(2*pi*Fc*t+ 2*pi*Kf*cumsum(mt)*time);
%b
snr_1=0; snr_2=5; snr_3=10; snr_4=20;
out_1= awgn(Xfm,snr_1,'measured');
out_2= awgn(Xfm,snr_2,'measured');
out_3= awgn(Xfm,snr_3,'measured');
out_4= awgn(Xfm,snr_4,'measured');

%Demodulation and Filtering
%a
freqdev=Kf*1;
z_1 = fmdemod(out_1,Fc,Fs,freqdev);
z_2 = fmdemod(out_2,Fc,Fs,freqdev);
z_3 = fmdemod(out_3,Fc,Fs,freqdev);
z_4 = fmdemod(out_4,Fc,Fs,freqdev);
[x,y] = butter(5,(1650/(Fs/2)));
%b
res_1=filter(x,y,z_1);
res_2=filter(x,y,z_2);
res_3=filter(x,y,z_3);
res_4=filter(x,y,z_4);
%c

%sound(mt);
%sound(res_1);
%sound(res_2);
%sound(res_3);
%sound(res_4);
%9.5.Mean Square Error (MSE) and compariso
MSE1=MSE_KorkutEmre_Arslanturk(mt,res_1);
MSE2=MSE_KorkutEmre_Arslanturk(mt,res_2);
MSE3=MSE_KorkutEmre_Arslanturk(mt,res_3);
MSE4=MSE_KorkutEmre_Arslanturk(mt,res_4);


snr=[snr_1 snr_2 snr_3 snr_4];
MSE=[MSE1 MSE2 MSE3 MSE4];
figure;

plot(snr,MSE);
title(' Graph of MSE values with respect to SNR values');
xlabel('SNR Values');
ylabel('MSE Values');

%N = numel(mt);
%inf =fft(mt, N);
%f=linspace(-Fs/2,+Fs/2,N);

%figure
%plot(f, fftshift(abs(inf)/N));
