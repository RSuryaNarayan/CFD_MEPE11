function s = compute_w(Ra,Da,Nu,psi,xi,k_r)
    omega = xi + (1 - xi)*k_r;
    w1 = (Ra*Da)/(omega*psi^2);
    w2 = (Nu*(1-xi))/(omega*psi^2);
    s = [omega;w1;w2];
end