%part2.1.a
fs=500;
step=1/fs;
time_1=0:step:4;
xt=(time_1>1)-3*(time_1>2)+2*(time_1>3);
%2.1.b
figure
plot(time_1,xt);
grid on;
xlabel('time(s)') ;
ylabel('amplitude') ;
title('Graph of x(t) function'); 
set(gca,'FontSize', 12,'FontName','Arial'); 
%2.1.c
x2t=cos(2*pi*50*time_1);
y1t=xt.*x2t;
%2.1.d
figure
plot(time_1,y1t);
grid on;
xlabel('time(s)') ;
ylabel('amplitude') ;
title('Graph of y1(t) function'); 
set(gca,'FontSize', 12,'FontName','Arial'); 


% part2.2.a
N=length(xt);
F=linspace(-fs/2,fs/2,N);
X1=fft(xt,N)/N;
X1=fftshift(X1);
Y1=fft(y1t,N)/N;
Y1=fftshift(Y1);
figure
subplot(2,1,1);
plot(F,(abs(X1)));
grid on;
xlabel('frequench(hz)') ;
ylabel('amplitude') ;
title('the magnitude of the frequency spectrum of x(t)'); 

subplot(2,1,2);
plot(F,(abs(Y1)));
grid on;
xlabel('frequench(hz)') ;
ylabel('amplitude') ;
title('the magnitude of the frequency spectrum of y1(t)'); 


%part2.2b

t_2=0:step:8;
N=2*N;
N=N-1;
X1=fft(xt,N);
X2=fft(x2t,N);
fs2=linspace(-fs/2,fs/2,N);
Y2=X1.*X2;
figure;
plot(fs2,(abs(fftshift(Y2))/N));
grid on;
xlabel('frequench(hz)') ;
ylabel('amplitude') ;
title('Graph of Y2(f)'); 


%part2.2c

Y_2=ifft(Y2,N);
figure
plot(t_2,(Y_2));
grid on;
xlabel('time(s)') ;
ylabel('amplitude') ;
title('Graph of Y2(t) via inverse Fourier transform'); 


%part2d
y2=conv(xt,x2t);
figure
plot(t_2,(y2));
grid on;
xlabel('time(s)') ;
ylabel('amplitude');
title('graph of Y2(t) with conv function');

figure
plot(Y_2,(y2));
grid on;
xlabel('y2(t) which we get in 2.2c') ;
ylabel('y2(t) which we get in 2.2d');
title('Show that y2(t) which is obtained by convolution is the same as the signal obtained in 2.2.c.');
