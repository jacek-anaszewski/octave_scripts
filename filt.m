function [y]=sig1(t)
   y=sin(2*pi*2*t) + 0.5.*sin(2*pi*8*t);
endfunction;

function [y]=sig2(t)
   y=sin(2*pi*2*t) .* exp(-4*t)./0.1249;
endfunction;

#x=(-20:0.1:20);
#N=length(x);
#y=zeros(1,N);
#for (k=1:N)
#   y(k)=dystrybuanta(x(k));
#endfor;
#plot(x,y,"-r;Dystrybuanta N(0,1);");

x=(-2:0.01:2);
N=length(x);

base=zeros(1,N);
for (k=201:N)
   base(k) = sig1(x(k));
   printf("base(%d): %.2f\n", k, base(k));
endfor;

filt=zeros(1,N);
for (k=201:N)
#   filt(k) = sig2(x(k));
#   filt(201-(k-201)) = sig2(x(k));
   filt(402-k) = sig2(x(k));
   printf("filt(%d): %.2f\n", k, filt(k));
endfor;

y=zeros(1,N);
for (n=201:N)
   printf("----n=%d-----\n", n);
   for (k=201:N)
      y(n) = y(n) + (base(k) * filt(201+n-k));
#      printf("base(%d): %.2f, filt(%d): %.2f, y(%d): %.2f\n", k, base(k), 201+n-k, filt(201+n-k), n, y(n));
   endfor;
#   y(n) = y(n) / (N - 201);
endfor;

z = conv(base, filt, "same");

subplot(4, 1, 1);
plot(x,base);
subplot(4, 1, 2)
plot(x,filt);
subplot(4, 1, 3);
plot(x,y);
subplot(4, 1, 4);
plot(x,z);

