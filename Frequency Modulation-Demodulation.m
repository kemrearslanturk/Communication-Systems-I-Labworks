
%part2.1
% a
Fs=2000; time=1/Fs; t=0:time:0.2;
Fm=50; Fc=200; Ac=1; Am=2;
%b
c_t=Ac*cos(t*2*pi*Fc);
%c
m_t=Am*cos(2*pi*Fm*t);
%d
kf=[5,25,50];
s1t=Ac*cos(2*pi*Fc*t+ 2*pi*kf(1)*cumsum(m_t)*time);
s2t=Ac*cos(2*pi*Fc*t+ 2*pi*kf(2)*cumsum(m_t)*time);
s3t=Ac*cos(2*pi*Fc*t+ 2*pi*kf(3)*cumsum(m_t)*time);

%e
figure
subplot(4,1,1);
plot(t,m_t);
title('m(t)');
xlabel('time(s)');
ylabel('amplitude');
subplot(4,1,2);
plot(t,s1t);
title('s1(t)');
xlabel('time(s)');
ylabel('amplitude');
subplot(4,1,3);
plot(t,s2t);
title('s2(t)');
xlabel('time(s)');
ylabel('amplitude');
subplot(4,1,4);
plot(t,s3t);
title('s3(t)');
xlabel('time(s)');
ylabel('amplitude');

%f
%yorum

%2.2 Signals in Frequency Domain
%a
N=length(m_t);
fs=linspace(Fs/2,-Fs/2,N);

mt_f1=fft(m_t,N)/N;  
mt_f1=fftshift(mt_f1);

ct_f1=fft(c_t,N)/N;  
ct_f1=fftshift(ct_f1);

st_f1=fft(s1t,N)/N;  
st_f1=fftshift(st_f1);

st_f2=fft(s2t,N)/N;  
st_f2=fftshift(st_f2);

st_f3=fft(s3t,N)/N;  
st_f3=fftshift(st_f3);
%b
figure
subplot(2,1,1);
plot(fs,abs(mt_f1));
title('Magnitude of the Frequency Spectrum of m(t)');
xlabel('frequency(hertz)');
ylabel('amplitude');
subplot(2,1,2);
plot(fs,abs(ct_f1));
title('Magnitude of the Frequency Spectrum of c(t)');
xlabel('frequency(hertz)');
ylabel('amplitude');

%c
figure
subplot(3,1,1);
plot(fs,abs(st_f1));
title('Magnitude of the Frequency Spectrum of s1(t)');
xlabel('frequency(hertz)');
ylabel('amplitude');
subplot(3,1,2);
plot(fs,abs(st_f2));
title('Magnitude of the Frequency Spectrum of s2(t)');
xlabel('frequency(hertz)');
ylabel('amplitude');
subplot(3,1,3);
plot(fs,abs(st_f3));
title('Magnitude of the Frequency Spectrum of s3(t)');
xlabel('frequency(hertz)');
ylabel('amplitude');
%d
%comment

%Part2.3 Demodulation
%part a
freqdev1=kf(1)*Am;
freqdev2=kf(2)*Am;
freqdev3=kf(3)*Am;
demod1 = Am*fmdemod(s1t,Fc,Fs,freqdev1);
demod2 = Am*fmdemod(s2t,Fc,Fs,freqdev2);
demod3 = Am*fmdemod(s3t,Fc,Fs,freqdev3);

%partb
figure
subplot(3,1,1);
of=plot(t,demod1);
hold on;
puf=plot(t,m_t);
legend([of,puf],'Demod 1','M(t)');
title('demodulated s1(t)');
xlabel('time(s)');
ylabel('amplitude');
subplot(3,1,2);
huf=plot(t,demod2);
hold on;
cuf=plot(t,m_t);
legend([huf,cuf],'Demod 2','M(t)');
title('demodulated s2(t)');
xlabel('time(s)');
ylabel('amplitude');
subplot(3,1,3);
duf=plot(t,demod3);
hold on;
kuf=plot(t,m_t);
legend([duf,kuf],'Demod 3','M(t)');
title('demodulated s3(t)');
xlabel('time(s)');
ylabel('amplitude');

