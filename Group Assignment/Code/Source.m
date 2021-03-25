%cfdassy: FDM porous fin 
mesh=11;
t=zeros(1,mesh);
t(end)=1;
dx=1/(mesh-1);
w1=1.1422;w2=0.5710;
for k=1:100
    %t_old=t;
    for i=2:mesh-1
        t(i)=(t(i+1)+t(i-1)-w1*(dx^2)*(t(i))^2)/(2+w2*dx^2);
    end
    t(1)=t(2);
end
% alternative numerical formulation: 
for k=1:100
    t_old=t;
    for i=2:mesh-1
        t(i) = (t_old(i+1) + t_old(i-1) - (w2*dx^2)*t_old(i))/(2 + t_old(i)*w1*dx^2);
    end
    t(1)=t(2);
end
x=linspace(0,1,mesh);
plot(x,t,'*r');hold on;%put analytical here
plot(x,t,'-g');hold off;
