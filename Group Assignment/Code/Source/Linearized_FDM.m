function [t_1,x] = Linearized_FDM(params, mesh, tol)
    Ra = params(1);
    Da = params(2);
    Nu = params(3);
    psi = params(4);
    xi = params(5);
    k_r = params(6);
    omg = compute_w(Ra,Da,Nu,psi,xi,k_r);
    w1 = omg(2);
    w2 = omg(3);
    t=zeros(1,mesh);
    t(end)=1;
    dx=1/(mesh-1);
    r = 10;
    while r > tol
        t_old=t;
        for i=2:mesh-1
            t(i) = (t_old(i+1) + t_old(i-1) - (w2*dx^2)*t_old(i))/(2 + t_old(i)*w1*dx^2);
        end
        t(1)=t(2);
        e = abs(t_old-t);
        r = sum(e);
    end
    t_1 = t;
    x=linspace(0,1,mesh);
end