A = [-2 1 0;1 -2 1;0 1 -2];
b = [10/16;10/16;10/16];
% initial guess
x = [0;0;0];
iters =10;
for i = 1:iters
    r = b - A*x;
    i
    r
    alpha= (r' * r)/(r'*A*r);
    alpha
    xnew = x + alpha*r;
    xnew
    x = xnew;
    hold  on;
    plot(i,r,'+k');
    plot(i,r(2),'*r');
    plot(i,r(3),'ob')
    hold off;
end
disp('The solution is: ')
x
