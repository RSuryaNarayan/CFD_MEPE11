function [t_1,x] = Finite_Volume_Method(params, mesh, tol)
    Ra = params(1);
    Da = params(2);
    Nu = params(3);
    psi = params(4);
    xi = params(5);
    k_r = params(6);
    omg = compute_w(Ra,Da,Nu,psi,xi,k_r);
    w1 = omg(2);
    w2 = omg(3);
    t=zeros(1,mesh+1);
    t(end)=1;
    dx=1/(mesh-1);
    residual = 10;
    while residual>tol
        t_old = t;
        for i = 2 : mesh
            sc = Sc(w1,w2,t_old(i));
            sp = dSdt(w1, w2, t_old(i));
            if (i == 2)
                t(i) = update_cell_1(t_old(i+1), sc, sp, dx);
            elseif (i==mesh)
                t(i) = update_end(t_old(i+1), t_old(i-1), sc, sp, dx);
            else
                t(i) = update(t_old(i+1), t_old(i-1), sc, sp, dx);
            end
        end
        t(1)=t(2); %impose the BC at the left end
        residual = sum(abs(t_old-t));
    end
    t_1 = t;
    xs = dx/2;
    xe = 1 - dx/2;
    x = linspace(xs, xe, mesh-1);
    x = [0,x,1];
end