%main update
function adv = update(te, tw, sc, sp, dx)
   adv = (te + tw - sc * dx^2)/(2 + sp * dx^2); 
end