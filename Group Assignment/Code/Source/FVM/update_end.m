%cell n update (accounts for the shrunk ghost-cell
function adv_end = update_end(te, tw, sc, sp, dx)
    adv_end = (2 * te + tw - sc * dx^2)/(3 + sp * dx^2);
end