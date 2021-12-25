%part2.1
%part 2.1a
fs=1000;
step=1/fs;
time_1=0:step:2;
x2t=cos(120*pi*time_1)+cos(500*pi*time_1);
N=length(x2t);
F=linspace(-fs/2,fs/2,N);
x2F=fft(x2t,N)/N;
x2F=fftshift(x2F);

%part 2.1b
g=zeros(1,900); e=linspace(0,1,100); f=linspace(1,0,101); h=zeros(1,900);
x=[g e f h];
%part 2.1c
Y=x+x2F;
%part 2.1d
figure
subplot(3,1,1);
plot(F,(abs(x)));
grid on;
xlabel('frequench(hz)') ;
ylabel('amplitude') ;
title('the magnitude of the x(F)'); 

subplot(3,1,2);
plot(F,abs(x2F));
grid on;
xlabel('frequench(hz)') ;
ylabel('amplitude') ;
title('the magnitude of the x2(F)'); 
subplot(3,1,3);

plot(F,abs(Y));
grid on;
xlabel('frequench(hz)') ;
ylabel('amplitude') ;
title('the magnitude of the y1(F)'); 

%part2.2

%part 2.2a
ideal_lp=zeros(1,2001); ideal_lp(abs(F)<50)=1;
Result_Lp=Y.*ideal_lp;
%part 2.2b
figure
subplot(2,1,1);
plot(F,ideal_lp);
grid on;
xlabel('frequench(hz)') ;
ylabel('amplitude') ;
title('H1F-Ideal Low Pass Filter'); 

subplot(2,1,2);
plot(F,abs(Result_Lp));
grid on;
xlabel('frequench(hz)') ;
ylabel('amplitude') ;
title('Y2(F)-Nonzero frequency components of X(F)'); 

%part 2.2c

ideal_bandpass=zeros(1,2001); ideal_bandpass(abs(F)>200 & abs(F)<300 )=1;
Result_Bp=Y.*ideal_bandpass;
%part 2.2d

figure
subplot(2,1,1);
plot(F,ideal_bandpass);
grid on;
xlabel('frequench(hz)') ;
ylabel('amplitude') ;
title('H2F-Ideal Band Pass Filter'); 

subplot(2,1,2);
plot(F,abs(Result_Bp));
grid on;
xlabel('frequench(hz)') ;
ylabel('amplitude') ;
title('Y3(F)- frequency components of X2(F)'); 

%part 2.2e
[b,a] = butter(6,[200 300]/(fs/2)); bp=filter(b,a,x2t);
bp_last=fftshift(fft(bp,N)/N);

%part 2.2f
figure
subplot(2,1,1);
freqz(b,a,N,fs);
grid on;
title('H3F-Nonideal Band Pass Filter'); 
subplot(2,1,2);
plot(F,abs(bp_last));
grid on;
xlabel('frequench(hz)') ;
ylabel('amplitude') ;
title('Ybpf(F)-frequency components of |X2(f)| stemming from cos(500*PI*t)'); 





