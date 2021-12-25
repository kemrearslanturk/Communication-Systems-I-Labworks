
%part2.1
% a
Fs=20000; time=1/Fs; t=0:time:0.03; 
Fm=450; Fc=5000;
c_t=cos(t*2*pi*Fc);
m_t=3*cos(2*pi*Fm*t);

%b

dsbsc_modulated=(m_t).*(c_t);

%c
N=3*length(dsbsc_modulated);
%because of our fs 20000 and our size of signal 601 there is so much
%different and it will be cause of frequency resolution and we would have
%wrong values because of that we choose 3 time size of signal.

fs=linspace(Fs/2,-Fs/2,N);
[x,y] = butter(3,(Fc/(Fs/2)),'high');
[a,b] = butter(21,(Fc/(Fs/2)),'high');


%d

[a1,b1]=freqz(x,y,N,Fs);
[a2,b2]=freqz(a,b,N,Fs);

figure
of=plot(b1,abs(a1));
hold on;
puf=plot(b2,abs(a2));
legend([of,puf],'Order n1=3','Order n2=21');
title('Magnitude Response of Designed Filters');
xlabel('frequency(hertz)');
ylabel('amplitude');

%e
m=N/3;
HPF_res_1time=filter(x,y,dsbsc_modulated);
HPF_res_1=fft(HPF_res_1time,N)/m;  
HPF_res_1=fftshift(HPF_res_1);

HPF_res_2time=filter(a,b,dsbsc_modulated);
HPF_res_2=fft(HPF_res_2time,N)/m;  
HPF_res_2=fftshift(HPF_res_2);

%f
st_f1=fft(dsbsc_modulated,N)/m;  
st_f1=fftshift(st_f1);

figure
subplot(3,1,1);
plot(fs,abs(st_f1));
title('Frequency Response of s(t)');
xlabel('frequency(hertz)');
ylabel('amplitude');
subplot(3,1,2);
plot(fs,abs(HPF_res_1));
title('Frequency Response of Susb1');
xlabel('frequency(hertz)');
ylabel('amplitude');
subplot(3,1,3);
plot(fs,abs(HPF_res_2));
title('Frequency Response of Susb2');
xlabel('frequency(hertz)');
ylabel('amplitude');

%If we compared frequency content and magnitude contents, we can say for
%s(t) we have 0.69 magnitude at -+5450 Hertz(fc+fm,-fc-fm)(not exatcly our fc,fm values 
%because of matlab properties and our time vector if we choose 0.08 
%instead of 0.03 everything will be okey) and 0.65 amplitude 
%at +-4550(fm-fc,-fm+fc) hertz. For amplitude we get this value because of 
%product of m(t) and carrier signal and fourier transform of cos.After that for:
%susb1(result of filter order=3) we have close magnitude of s(t)(0.60)
%at -+5450 Hertz(fc+fm,-fc-fm) and we have almost half of magnitude of s(t)
%(0.321) at -+4500 Hertz(fm-fc,-fm+fc)because our order is so few because 
%of that we get so much undesired values and we do not get some desired
%values.
%It is about frequency resolution.
%For susb2(result of filter order=21) we have almost same magnitude 
%of s(t)(0.67)at -+5450 Hertz(fc+fm,-fc-fm) and we do not have any
%amplitude at4566Hertz (fm-fc,-fm+fc). Because our filter order is big so
%that we get more desired amplitudes and we do not get undesired values as
%possible as.

%Finally, we can say according to our filter order, for small orders we
%pass some undesired values and we can say we can not pass all of desired
%values. When order is increasing our filter closer to ideal(can not be reach)
% and we get more desired values and we get fewer undesired values. It is
% about transmission band of filter. For bigger order we have sharper transition.
%It is about how we have solution our equation
%for example order=1 linear polynomial
%order =2, quadratic polynomial
%order=3, cubic polynomial
%order=4, quartic polynomial

%2.2
%a
%For susb1 we have undesired values at at4550Hertz (fm-fc,-fm+fc) and we 
%miss more desired values at -+4550 Hertz(fc+fm,-fc-fm) than subs2
%because of that we choose susb2.
Acprime=4; teta=0;
localoscillator=(Acprime)*cos(2*pi*Fc*t);
vt=(HPF_res_2time).*localoscillator;
%b
[c,d] = butter(3,(1100/(Fs/2)));

%we choose cut off frequency we look which low frequency values we have
%amplitude for v(t) and because of our filter is not ideal, 1100 hz instead
%of 1066 because of transmission band.
%Also, we choose filter order according to which minimum order give us result without
%any ripple or distortion because we do not wanna see any distortion and
%ripple and we should choose low order due to easy feasibility. 

%c
LPF_res1=filter(c,d,vt);

%d
m_t_freqresponse=fft(m_t,N)/m;  
m_t_freqresponse=fftshift(m_t_freqresponse);

LPF_res=fft(LPF_res1,N)/m;  
LPF_res=fftshift(LPF_res);

vt_freqres=fft(vt,N)/m;
vt_freqres=fftshift(vt_freqres);

figure
subplot(3,1,1);
plot(fs,abs(m_t_freqresponse));
grid on;
xlabel('frequench(hz)') ;
ylabel('amplitude') ;
title('Frequency Response of m(t)'); 

subplot(3,1,2);
plot(fs,abs(vt_freqres));
grid on;
xlabel('frequench(hz)') ;
ylabel('amplitude') ;
title('Frequency Response of v(t)'); 

subplot(3,1,3);
plot(fs,abs(LPF_res));
grid on;
xlabel('frequench(hz)') ;
ylabel('amplitude') ;
title('Frequency Response of Demodulated signal'); 
%we can say for m(t),  we wait according to our function, m(t)=3*cos(2*pi*Fm*t)because of 
%that we get amplitude equal to 1.5(half of 3 because of fourier transform) 
%Also we have magnitude at -+450Hertz beucase of fm value.
% For v(t) we can say we have magnitude at 2fc-fm(9550 Hertz) and -2fc+fm(-9550 Hertz)
%.also our magnitude is 1.5 at these frequency as a result of product with
% modulated signal and local oscillator. Also we have 1.5 magnitude at
% -+455Hertz according to message signal but little different because of
% frequency resolution

%For demodulated signal, our amplitudes are 1 as like as message signal and we have
%have magnitude at -+443Hz because of low pass filter desing we can get almost same 
%signal with message signal. Our filter is non ideal and we have frequency
%resolution so that we do not have same signal.

%e 
%We can say we get almost same signal with message signal but we have phase
%reversal because of our cos operations. Also we have some distortion at
%the beginning of filter because of our filter is not ideal.

figure
huf=plot(t,m_t);
hold on
ya=plot(t,LPF_res1);
legend([huf,ya],'message signal','demodulated signal after filtering');
xlabel('time(ms)') ;
ylabel('amplitude') ;
title('Compare message signal and demodulated signal after filtering'); 
