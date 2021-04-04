function [t,x] = Non_linear_FDM(params, mesh, tol)
    Ra = params(1);
    Da = params(2);
    Nu = params(3);
    psi = params(4);
    xi = params(5);
    k_r = params(6);
    omg = compute_w(Ra,Da,Nu,psi,xi,k_r);
    w1 = omg(2);
    w2 = omg(3);
    t_1=zeros(1,mesh);
    t_1(end)=1;
    dx=1/(mesh-1);
    residual = 10;
    while residual>tol
        t_old=t_1;
        for i=2:mesh-1
            t_1(i)=(t_1(i+1)+t_1(i-1)-w1*(dx^2)*(t_1(i))^2)/(2+w2*dx^2);
        end
        t_1(1)=t_1(2);
        e = abs(t_old-t_1);
        residual = sum(e);
    end
    t = t_1;
    x=linspace(0,1,mesh);
end