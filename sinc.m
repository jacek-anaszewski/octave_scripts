function [y]=myexp(t)
   y=sin(t)./t;
endfunction;

function [y]=dystrybuanta(x)
   y=quad("myexp", 0, x, x);
endfunction;

x=(-20:0.1:20);
N=length(x);
y=zeros(1,N);
for (k=-20:N)
   y(k)=dystrybuanta(x(k));
endfor;
plot(x,y,"-r;Dystrybuanta N(0,1);");

