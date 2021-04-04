%============================POROUS FIN SOLUTION==========================%
%derive params w1 and w2
Ra = 1000;
Da = 0.004;
Nu = 10;
psi = 0.05;
xi = 0.8;
k_r = 7000;
omg = compute_w(Ra,Da,Nu,psi,xi,k_r);
omega = omg(1);
w1 = omg(2);
w2 = omg(3);
%set params 
mesh=100;
params=[Ra;Da;Nu;psi;xi;k_r];
tol = 1e-8;
%%=============================NON-LINEAR FDM============================%%
[t_1,x] = Non_linear_FDM(params,mesh,tol);
figure(1)
plot(x,t_1,'+k');
hold on;
% % post process data
% perf = performance_eval(params,t_1);
% Q = perf(1);
% eta = perf(2);
% epsilon = perf(3);
%==============================LINEARIZED FDM============================%% 
[t,x] = Linearized_FDM(params,mesh,tol);
figure(1)
plot(x,t,'og');
%==================================FVM===================================%%
%construct x-vector
[t,x] = Finite_Volume_Method(params,mesh,tol);
%plot
figure(1)
plot(x,t,'-r'); 
legend('FDM-NL', 'FDM-L','FVM-L');
hold off; 