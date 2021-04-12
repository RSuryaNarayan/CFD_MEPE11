function t_0 =  compute_th_0(w1,w2)
    eq = @(x) 1 - x - P1(w1,w2,x) - P2(w1,w2,x) - P3(w1,w2,x) - P4(w1,w2,x);
    options = optimoptions('fsolve','Display','none','PlotFcn',@optimplotfirstorderopt);
    t_0 = fsolve(eq,0.5,options);
end