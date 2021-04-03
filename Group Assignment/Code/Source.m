%============================POROUS FIN SOLUTION==========================%
%%=============================NON-LINEAR FDM============================%%
mesh=100;
t_1=zeros(1,mesh);
t_1(end)=1;
dx=1/(mesh-1);
w1=1.1422;w2=0.5710;
residual = 10;
while residual>1e-18
    t_old=t_1;
    for i=2:mesh-1
        t_1(i)=(t_1(i+1)+t_1(i-1)-w1*(dx^2)*(t_1(i))^2)/(2+w2*dx^2);
    end
    t_1(1)=t_1(2);
    e = abs(t_old-t_1);
    residual = sum(e);
end
x=linspace(0,1,mesh);
plot(x,t_1,'-g');
hold on;
%==============================LINEARIZED FDM============================%% 
mesh = 11;
t=zeros(1,mesh);
t(end)=1;
dx = 1/(mesh-1);
r =10;
while r > 1e-15
    t_old=t;
    for i=2:mesh-1
        t(i) = (t_old(i+1) + t_old(i-1) - (w2*dx^2)*t_old(i))/(2 + t_old(i)*w1*dx^2);
    end
    t(1)=t(2);
    e = abs(t_old-t);
    r = sum(e)
end
x=linspace(0,1,mesh);
plot(x,t,'or');
%==================================FVM===================================%%
%%===============================VARIABLES===============================%%
% source term variables - add routine to compute based on other params
w1=1.1422; w2=0.5710;
% mesh: there will be (n-1) cells 
n = 15;
% mesh resolution
dx = 1 / (n-1);
% theta
t = zeros(1,n+1); 
% impose right boundary BC
t(end) = 1;
% outer iterations for the main loop
iter = 100000; 
residual =10; 
tol = 1e-20;
%%==========================THE JACOBI ITERATOR==========================%%
while residual>tol
    t_old = t;
    for i = 2 : n
        sc = Sc(w1,w2,t_old(i));
        sp = dSdt(w1, w2, t_old(i));
        if (i == 2)
            t(i) = update_cell_1(t_old(i+1), sc, sp, dx);
        elseif (i==n)
            t(i) = update_end(t_old(i+1), t_old(i-1), sc, sp, dx);
        else
            t(i) = update(t_old(i+1), t_old(i-1), sc, sp, dx);
        end
    end
    t(1)=t(2); %impose the BC at the left end
    residual = sum(abs(t_old-t));
end
%%============================PLOTTING AND VIS===========================%%
%construct x-vector
xs = dx/2;
xe = 1 - dx/2;
x = linspace(xs, xe, n-1);
x = [0,x,1];
%plot
plot(x,t,'*b'); 
legend('FDM-NL', 'FDM-L','FVM-L')
hold off;
%%=============================LOOP UPDATES==============================%%
%main update
function adv = update(te, tw, sc, sp, dx)
   adv = (te + tw - sc * dx^2)/(2 + sp * dx^2); 
end
%cell 1 update (to account for BC)
function cell_1 = update_cell_1(te, sc, sp, dx)
    cell_1 = (te - sc * dx^2)/(1 + sp * dx^2);
end
%cell n update (accounts for the shrunk ghost-cell
function adv_end = update_end(te, tw, sc, sp, dx)
    adv_end = (2 * te + tw - sc * dx^2)/(3 + sp * dx^2);
end
%%==========================SOURCE TERM FUNCTIONS========================%%
%original source term
function s = S(w1, w2, t)
    s = w1 * t^2 + w2 * t; 
end
% derivative and the Sp term 
function sp = dSdt(w1, w2, t)
    sp = 2 * w1 * t + w2;
end
%constant term 
function sc = Sc(w1, w2, t)
    sc = S(w1, w2, t) - (dSdt(w1, w2, t)) * t;
end
