function [t,x] = analytical_solution(params,mesh)
    Ra = params(1);
    Da = params(2);
    Nu = params(3);
    psi = params(4);
    xi = params(5);
    k_r = params(6);
    omg = compute_w(Ra,Da,Nu,psi,xi,k_r);
    w1 = omg(2);
    w2 = omg(3);
    x=linspace(0,1,mesh);
    theta_0 = compute_th_0(w1,w2);
    t=adomain_decomposed(theta_0,w1,w2,x);
end
