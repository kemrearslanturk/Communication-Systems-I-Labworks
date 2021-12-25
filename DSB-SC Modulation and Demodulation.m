%part1
% a
Fs=100000; time=1/Fs; t=0:time:0.08; 
Fm=100; Fc=1000;
c_t=cos(t*2*pi*Fc);
m_t=cos(2*pi*Fm*t);
modulated=(m_t).*(c_t);

%2.1.c
figure
subplot(3,1,1);
plot(t,m_t);
title('Message Signal=m(t)');
xlabel('time(s)');
ylabel('amplitude');
subplot(3,1,2);
plot(t,c_t);
title('Carrier Signal=c(t)');
xlabel('time(s)');
ylabel('amplitude');
subplot(3,1,3);
plot(t,modulated);
title('Modulated Signal=s(t)');
xlabel('time(s)');
ylabel('amplitude');

%part2.1.d
N=length(m_t);
fs=linspace(Fs/2,-Fs/2,N);
m_f=fft(m_t,N)/N;  m_f=fftshift(m_f);
modulated_f=fft(modulated,N)/N; modulated_f=fftshift(modulated_f);

figure
subplot(2,1,1);
plot(fs,abs(m_f));
title(' Message Signal in Frequency Domain=m(f)');
xlabel('frequency(hertz)');
ylabel('amplitude');
axis([-2500 2500 0 0.6])
subplot(2,1,2);
plot(fs,abs(modulated_f));
title('Modulated Signal in Frequency Domain=s(f)');
xlabel('frequency(hertz)');
ylabel('amplitude');
axis([-2500 2500 0 0.6])

%For message signal we can say we see magnitude at -100 and +100 hertz
%because our formula is m(t)=cos(2pi*fm*t) and our fm=100 Hz. Also we see
%0.5 because of fourier transform of cos formula. For modulated signal we
%see amplitude at -1100 Hz, -900 Hz, 900 Hz and 1100 Hz. Because modulated
%signal equal to product of c(t) and m(t) and our fc=1000Hz and fm=100Hz.(We
%amplitudes at fc+fm,fc-fm,-fc+fm,-fc-fm).%Also our magnitudes is 0.25 
%because of we get fourier transform and we have 2 cos function because of 
%that our amplitudes are 1*(1/2)*(1/2)=1/4.

%part2.2a
phase=0; Acprime=2;
oscillator=Acprime*cos(2*pi*Fc*t+phase);
v=(modulated).*(oscillator);
v_f=fft(v,N)/N;  v_f=fftshift(v_f);
%part2.2b
figure
plot(fs,abs(v_f));
title('Frequency Response of V(t)');
xlabel('frequency(hertz)');
ylabel('amplitude');
axis([-2500 2500 0 0.6])


%We get V(t) result of product modulated signal and local oscillator and we
%get fourier transform of this because of that according to trigonometric 
%sum product formulas we get amplitudes at 2fc+fm,2fc-fm,-2fc+fm,-2fc-fm 
%and we get amplitudes at +100 Hertz and -100 Hertz %because of our message
%signal. For amplitudes we can say at 2fc+fm, 2fc-fm,-2fc+fm,-2fc-fm, 
%our modulated signal amplitude is 0.25 and we multiply it 
%Ac'*cos(2*pi*fc) so because of fourier transform we should get
%0.25*(1/2)=0.125 amplitude but our Ac prime is because of that we get
%0.125*(2)=0.25 amplitude. At +100 and -100 Hertz we get 0.5 amplitude
%because our message signal amplitude is 1 and because of fourier transform
%of cos we should multiply with 1/2 so that we have 0.5 amplitude.

%part2.2c
[x,y] = butter(5,(500/(Fs/2)));
LPF_res=filter(x,y,v);

LPF_res_f=fft(LPF_res,N)/N;  LPF_res_f=fftshift(LPF_res_f);

%We choose our frequency value according to which we want pass frequency
%values and its relative to our message signal frequency component which
%fm=100Hz. Actually we can choose between 100Hz and 1900 Hz. But we want to
%pass all desired components and we do not want to pass any undesired
%components. Also, our filter is not ideal because of that we have
%transmission line so if we choose cut off 100 we can not get all desired
%values or if we choose so big frequency values we get undesired
%amplitudes, because of all these reasons 500 Hertz can be good for us. We
%choose our filter order according to which minimum order give us result without
%any ripple or distortion because we do not wanna see any distortion and
%ripple and we should choose low order due to easy feasibility.

%part2.2d
figure
subplot(2,1,1);
plot(t,LPF_res);
title('Recovered Signal After Filtering in Time Domain v0(t)');
xlabel('time(s)');
ylabel('amplitude');
subplot(2,1,2);
plot(fs,abs(LPF_res_f));
title('Recovered Signal After Filtering in Frequency Domain v0(f)');
xlabel('frequency(hertz)');
ylabel('amplitude');
axis([-2500 2500 0 0.6])

%We can see recovered signal after filtering, almost same as our message
%signal but in time we can see phase shifting because of our filter 
%is not ideal and we can see if do it in real world it can be because of 
%condansator. In frequency domain, we can say we get amplitudes exactly
%right frequency values but our amplitudes are 0.49 but it should be 0.5 
%it is about our filter is not ideal because we have data loss.
