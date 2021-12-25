%part2.1.a
Fs =2000;
time=1/Fs;
t=0.0:time:0.5;
m_t=sawtooth(2*pi*10*t+pi/2,1/2);

%part2.1.b
Fc = 100; kf = 80;
ct = cos(2*pi*Fc*t);
S_fmt=cos(2*pi*Fc*t+ 2*pi*kf*cumsum(m_t)*time);
%partc
kp_2=2*pi;
S_pmt=cos(2*pi*Fc*t+ kp_2*m_t);

%part d
figure
subplot(3,1,1);
plot(t,m_t);
title('m(t)');
xlabel('time(s)');
ylabel('amplitude');
subplot(3,1,2);
plot(t,S_fmt);
title('S_FM(t)');
xlabel('time(s)');
ylabel('amplitude');
subplot(3,1,3);
plot(t,S_pmt);
title('S_PM(t)');
xlabel('time(s)');
ylabel('amplitude');

%part e 

%comment

%part f
kp_3=3*pi;
S_pm2t=cos(2*pi*Fc*t+ kp_3*m_t);
kp_4=4*pi;
S_pm3t=cos(2*pi*Fc*t+ kp_4*m_t);

figure
subplot(3,1,1);
plot(t,S_pmt);
title('S_PM(t)');
xlabel('time(s)');
ylabel('amplitude');
subplot(3,1,2);
plot(t,S_pm2t);
title('S_PM2(t)');
xlabel('time(s)');
ylabel('amplitude');
subplot(3,1,3);
plot(t,S_pm3t);
title('S_PM3(t)');
xlabel('time(s)');
ylabel('amplitude');

%part2.2
%b
x_pmt=hilbert(S_pmt);

%partc
N=length(m_t);
fs=linspace(-Fs/2,+Fs/2,N);
x_pmf=fft(x_pmt,N)/N;  x_pmf=fftshift(x_pmf);
m_f=fft(m_t,N)/N;  m_f=fftshift(m_f);
S_pmf=fft(S_pmt,N)/N;  S_pmf=fftshift(S_pmf);


figure
subplot(3,1,1);
plot(fs,abs(m_f));
title('Frequency response of m(t)');
xlabel('frequency(hertz)');
ylabel('amplitude');
subplot(3,1,2);
plot(fs,abs(S_pmf));
title('Frequency response of S_PM(t)');
xlabel('frequency(hertz)');
ylabel('amplitude');
subplot(3,1,3);
plot(fs,abs((x_pmf)));
title('Frequency response of X_PM(t)');
xlabel('frequency(hertz)');
ylabel('amplitude');

%d
theta_1=unwrap(angle(x_pmt));
m_hilbert1=(theta_1-(2*pi*Fc*t))/kp_2;

%e
x_2pmt=hilbert(S_pm3t);
theta_2=unwrap(angle(x_2pmt));
m_hilbert2=(theta_2-(2*pi*Fc*t))/kp_4;

figure
of=plot(t,m_t);
hold on;
puf=plot(t,m_hilbert1);
hold on;
tuf=plot(t,m_hilbert2);
legend([of,puf,tuf],'Message Signal: M(t)','Demodulated signal: M"1(t)','Demodulated signal: M"3(t)');
title('Comparison message signal with modulated signals');
xlabel('time(s)');
ylabel('amplitude');


