%thomas algorithm/TDMA
mesh=101;
T=zeros(1,mesh);
T(1)=263;T(end)=323;
P=zeros(1,mesh);
Q=zeros(1,mesh);
P(1)=0;Q(1)=263;
dx=10/(mesh-1);
a=(2+0.15*dx^2);
b=1;c=1;d=0;
for i=2:mesh
    P(i)=b/(a-c*P(i-1));
    Q(i)=(d+c*Q(i-1))/(a-c*P(i-1));
end
Q(mesh)=T(end);
for i=mesh-1:-1:2
    T(i)=T(i+1)*P(i)+Q(i);
end
x=linspace(0,10,mesh);
plot(x,T);
