%cell 1 update (to account for BC)
function cell_1 = update_cell_1(te, sc, sp, dx)
    cell_1 = (te - sc * dx^2)/(1 + sp * dx^2);
end