
%part1
% a
Fs=10000; time=1/Fs; t=0:time:0.1;
%b
Ac=1; Am=1; Fm=100; Fc=1000;
c_t=Ac*cos(t*2*pi*Fc);
m_t=Am*cos(2*pi*Fm*t);
mfac_1=0.5; mfac_2=1; mfac_3=2;
%c
st1= ((mfac_1*m_t)+1).*c_t;
st2= ((mfac_2*m_t)+1).*c_t;
st3= ((mfac_3*m_t)+1).*c_t;

%d

figure
subplot(3,1,1);
plot(t,st1);
title('modulated signal s(t) for modulation factor=0.5');
xlabel('time(s)');
ylabel('amplitude');
subplot(3,1,2);
plot(t,st2);
title('modulated signal s(t) for modulation factor=1');
xlabel('time(s)');
ylabel('amplitude');
subplot(3,1,3);
plot(t,st3);
title('modulated signal s(t) for modulation factor=2');
xlabel('time(s)');
ylabel('amplitude');

%e
%We can say when modulation factor increasing, we see distortion on the
%graph. Modulation factor is ka*Am and our Am value is 1. Also we can say
%if ka*m(t)>1 we get overmodulated(envolope distortion), as we can see in
%the graph.

%f
ka=0.5; N=1001;
fs=linspace(Fs/2,-Fs/2,N);
m_f=fft(m_t,N)/N;  m_f=fftshift(m_f);
c_f=fft(c_t,N)/N; c_f=fftshift(c_f);
Sf1=fft(st1,N)/N; Sf1=fftshift(Sf1);

figure
subplot(3,1,1);
plot(fs,abs(m_f));
title('frequency response m(t) with ka=0.5');
xlabel('frequency(hz)');
ylabel('amplitude');
subplot(3,1,2);
plot(fs,abs(c_f));
title('frequency response c(t) with ka=0.5');
xlabel('frequency(hz)');
ylabel('amplitude');
subplot(3,1,3);
plot(fs,abs(Sf1));
title('frequency response s1(t) with ka=0.5');
xlabel('frequency(hz)');
ylabel('amplitude');

%part2
%a
ka_1=0.9; ka_2=2;
st4= ((ka_1*m_t)+1).*c_t;
st5= ((ka_2*m_t)+1).*c_t;
st_4=st4.*st4;
st_5=st5.*st5;

[x,y] = butter(5,(700/(Fs/2)));
LPF_res_st4=filter(x,y,st_4);
LPF_res_st5=filter(x,y,st_5);
result_st_4=sqrt(LPF_res_st4);
result_st_5=sqrt(LPF_res_st5);

%st_5=fft(st_5,N)/N; st_5=fftshift(st_5);

%figure
%plot(fs,abs(st_5));

%b

%I choose cut off frequency according to our message signal frequency. If
%draw a graph fourier transform of the square of st_4 or st_5 we can see we
%want frequency values between 230 and -230. Also we can say because of AM
%modulation our bandwidth is doubled. So if we choose cut off frequency
%values like 700 Hz we are in desired values. Actually we must choose a between
%500-1000Hz. Also we can say because of matlab rules to get all desired values
%we should choose a bit bigger value.If we examine graph of filter we can 
%see we get in true points. Also, I choose the filter order which value is
%the minimum value I do not see any distortion because we do not want to
%see distortion and we should choose low order due to easy feasibility.

%c
figure
subplot(2,1,1);
plot(t,abs((result_st_4)));
title('Demodulated signal for ka=0.9');
xlabel('time(s)');
ylabel('amplitude');

subplot(2,1,2);
plot(t,abs(result_st_5));
title('Demodulated signal for ka=2');
xlabel('time(s)');
ylabel('amplitude');

%d
%We can say for ka=0.9 we got a result very close to our message signal
%because of ka value. Also for ka=2.2 we got a overmodulated signal and we
%get distortion.

