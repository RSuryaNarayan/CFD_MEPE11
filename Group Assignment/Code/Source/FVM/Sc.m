%constant term 
function sc = Sc(w1, w2, t)
    sc = S(w1, w2, t) - (dSdt(w1, w2, t)) * t;
end