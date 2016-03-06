N=64;
n=0:1:N-1;
NN=2*N;

f=1/sqrt(2/N);
c=[sqrt(1/N) sqrt(2/N)*ones(1,N-1)];
s=sqrt(2/(N+1));
for (k=0:N-1)
   bf(k+1, n+1) = f * cos(2*pi/N*k*n);
   bc(k+1, n+1) = c(k+1) * cos(pi*k*(2*n+1)/NN);
   bs(k+1, n+1) = s * sin(pi*(k+1)*(n+1)/(N+1));
endfor;

figure(1);

subplot(5, 1, 1);
plot(n,bf);
subplot(5, 1, 2)
plot(n,bc);
subplot(5, 1, 3);
plot(n,bs);

m=log2(N);
c=sqrt(1/N);
for (k=0:N-1)
   kk=k;
   for (i=0:m-1)
      ki(i+1)=rem(kk,2);
      kk=floor(kk/2);
   endfor;
   for (l=0:N-1)
      nn=l;
      for (i=0:m-1)
         ni(i+1)=rem(nn,2);
         nn=floor(nn/2);
      endfor;
      bHD(k+1,l+1) = c * (-1)^sum(ki .* ni);
   endfor;
endfor;

subplot(5, 1, 5);
plot(n,bHD);

c=sqrt(1/N);
#bHR=[c, c*ones(1,N-1)];
#printf("sqrt N:%d %f", N, sqrt(1/N));
bHR(1,1:N)=c*ones(1,N);
for (k=1:N-1)
   p=0;
   while (k+1 > 2^p)
      p=p+1;
   endwhile;
   p=p-1;
   q=k-2^p+1;
   for (l=0:N-1)
      x=l/N;
      if (((q-1)/2^p <= x) && (x < (q-1/2)/2^p))
         bHR(k+1, l+1) = c*2^(p/2);
      elseif (((q-1/2)/2^p <= x) && (x < q/2^p))
         bHR(k+1, l+1) = -c*2^(p/2);
      else
         bHR(k+1, l+1) = 0;
      endif;
   endfor;
endfor;

subplot(5, 1, 4);
plot(n,bHR);


for (k=1:N)
   Tf(k,1:N)=bf(k,1:N);
   Tc(k,1:N)=bc(k,1:N);
   Ts(k,1:N)=bs(k,1:N);
   THD(k,1:N)=bHD(k,1:N);
   THR(k,1:N)=bHR(k,1:N);
endfor;

#T=THR;
#I=T * T';
#for (i=1:N)
#   for (j=1:N)
#      printf("%.2f ", I(i, j));
#   endfor
#   printf("\n");
#endfor

#for (i=1:N)
#   printf("%.2f ", T(3, i) * T(4, i));
#endfor

kk=5;
fi=0;
n=0:N-1;
x1=cos((2*pi/N)*kk*n + fi);
x2=cos(pi*kk*(2*n+1)/NN + fi);
x3=sin(pi*(kk+1)*(n+1)/(N+1) + fi);
x4=cos((2*pi/N)*2*n + fi) + cos((2*pi/N)*4*n + fi);
x5=[ones(1,N/2) zeros(1,N/2)];
x6=[-ones(1,N/4) ones(1,N/2) -ones(1,N/4)]

x=x4;
T=Tf;
a=T*x';
y=T' * a;
y=y';

figure(2);

subplot(5, 1, 1);
plot(n,x);
subplot(5, 1, 2);
plot(n,real(a));
subplot(5, 1, 3);
plot(n,y);
subplot(5, 1, 4);
plot(n,y-x);

y=zeros(1,N);
for (k=0:N-1)
   a(k+1)=sum(x .* conj(T(k+1,1:N)));
endfor
for (k=0:N-1)
   y=y+a(k+1) * T(k+1,1:N);
endfor

figure(3)

subplot(5, 1, 5);
plot(n,y-x);
