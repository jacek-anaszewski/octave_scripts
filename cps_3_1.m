T=1;		#okres przebiegu prostokatnego
N=1000;		#liczba próbek przypadających na ten okres
dt=T/N;		#odległość między próbkami
t=0:dt:(N-1)*dt;#kolejne chwile czasowe odpowiadające próbkom sygnału
A=1;		#amplituda sygnału [-A, +A]
NF=300;		#liczba współczynników szeregu Fouriera do wyznaczenia (mniejsza lub równa N/2)
isygnal=1;	#numer sygnału testowego

f0=1/T;		#częstotliwość podstawowa szeregu Fouriera

if (isygnal==1) x=[0 A*ones(1,N/2-1) 0 -A*ones(1,N/2-1)]; endif;
if (isygnal==2) x=[A*ones(1,N/4) 0 -A*ones(1,N/2-1) 0 A*ones(1,N/4-1)]; endif;
if (isygnal==3) x=[A*ones(1,N/8) 0 -A*ones(1,5*N/8-1) 0 A*ones(1,N/4-1)]; endif;
if (isygnal==4) x=(A/T)*t; endif;
if (isygnal==5) x=[(2*A/T)*t(1:N/2+1) (2*A/T)*t(N/2:-1:2)]; endif;
if (isygnal==6) x=sin(2*pi*t/(T)); endif;

figure(1);
subplot(3, 1, 1);
plot(t, x);
title("Sygnał analizowany");

for (k=0:NF-1)
   ck=cos(2*pi*k*f0*t);
   subplot(3, 1, 2);
   plot(t,ck);
   title("cosinus");
#   pause(0.1);
   sk=sin(2*pi*k*f0*t);
   subplot(3, 1, 3);
   plot(t,sk);
   title("sinus");
#   pause(0.1);
   a(k+1)=sum(x.*ck)/N;
   b(k+1)=sum(x.*sk)/N;
   F(k+1,1:N)=(ck-j*sk)/sqrt(N);
endfor;

f=0:f0:(NF-1)*f0;

figure(2);

subplot(4, 1, 1);
stem(f,a);
title("Współczynniki cos");
subplot(4, 1, 2);
stem(f,b);
title("Współczynniki sin");

#porównanie ze współczynnikami teoretycznymi

if (isygnal==1)
   at=[];
   bt=[];
   for (k=1:2:NF)
      at=[at 0 0];
      bt=[bt 0 (2*A)/(pi*k)];
   endfor;
   subplot(4, 1, 3);
   plot(f,a);
   title("Różnica cosinus");
   subplot(4, 1, 4);
   plot(f,b);
   title("Różnica sinus");
endif;


figure(3);

X=fft(x,N)/N;
X=conj(X);

subplot(2, 1, 1);
plot(f,a-real(X(1:NF)));
title("Różnica z DFT - COS");
subplot(2, 1, 2);
plot(f,a-imag(X(1:NF)));
title("Różnica z DFT - SIN");


figure(4);

a(1)=a(1)/2;
y=zeros(1,N);
for (k=0:NF-1)
   y=y+2*a(k+1)*cos(k*2*pi*f0*t) + 2*b(k+1)*sin(k*2*pi*f0*t);
   subplot(3, 1, 1);
   plot(t,y);
   title("Suma = k pierwszych funkcji bazowych");
   pause(0.1);
endfor

subplot(3, 1, 2);
plot(t,y);
title("Całkowity sygnał zsyntezowany");
subplot(3, 1, 3);
plot(t,y-x);
title("Sygnał błędu");
