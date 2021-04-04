function perf = performance_eval(params,t)
    Ra = params(1);
    Da = params(2);
    Nu = params(3);
    psi = params(4);
    xi = params(5);
    k_r = params(6);
    omega = xi + (1 - xi)*k_r;
    dx = 1/(length(t)-1);
    Q = omega*psi*(t(end)-t(end-1))/dx;
    Q_i = (Ra*Da + Nu*(1-xi))/psi;
    Q_w = 0.5*Nu;
    eta = Q/Q_i;
    epsilon = Q/Q_w;
    perf = [Q;eta;epsilon];
end