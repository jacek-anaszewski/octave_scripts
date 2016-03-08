fx=1;		#częstotliwość sygnału
fps=100;	#stara częstotliwość próbkowania
N=200;		#liczba p©óbek sygnału spróbkowanego z częstotliwością fps
K=10;		#ile razy zmniejszyć częstotliwość próbkowania

dts=1/fps;
ts=0:dts:(N-1)*dts;
xs=sin(2*pi*fx*ts);

figure(1);

subplot(4, 1, 1);
plot(ts, xs);
title("Sygnał spróbkowany");

fpn=fps/K;	#nowa częstotliwość próbkowania - zmniejszona stara

xn=xs(1:K:length(xs));
M=length(xn);
dtn=K*dts;
tn=0:dtn:(M-1)*dtn;

subplot(4, 1, 2);
plot(ts,xs);
title("Sygnał spróbkowany - fp nowe");
subplot(4, 1, 3);
plot(tn,xn);
title("Sygnał spróbkowany - fp nowe");
subplot(4, 1, 4);
stem(xn);
title("Sygnał spróbkowany - fp nowe");



t=-(N-1)*dts:dts:(N-1)*dts;
f=1/(2*dtn);
fa=sin(2*pi*f*t)./(2*pi*f*t);
fa(N)=1;
tz=[-fliplr(tn) tn(2:M)];
z=[zeros(1,M-1) 1 zeros(1,M-1)];

subplot(4, 1, 4);
plot(t,fa);
title("Sinc - funkcja aproksymująca");

y=zeros(1,N);
ty=0:dts:(N-1)*dts;

figure(2);

for (k=1:M)
   fa1=fa((N)-(k-1)*K : (2*N-1)-(k-1)*K);
   y1=xn(k)*fa1;
   y=y+y1;
   subplot(3, 1, 1);
   plot(ty,fa1);
   title("Kolejna funkcja aproksymująca");
   subplot(3, 1, 2);
   plot(ty,y1);
   title("Kolejny składnik sumy");
   subplot(3, 1, 3);
   plot(ty,y1);
   title("Suma");
endfor;

figure(3);

subplot(2, 1, 1);
plot(ty,y);
title("Sygnał odtworzony");

subplot(2, 1, 2);
plot(ty,xs);
title("Różnica między sygnałami");
