function xnew = conjugate_gradient(A,b)
    xnew=0;
    % initial guess
    x0 = [0;0];
    P0 = b - A*x0;
    alpha= (P0' * P0)/(P0'*A*P0);
    x = x0 + alpha*P0;
    iters =5;
    for i = 1:iters
        i
        r1 = b-A*x
        if (sum(r1.^2)==0)
            break;
        end
        beta= (P0' * A *r1)/(P0' * A * P0)
        P1 = r1 - beta*P0
        alpha = (P1' * r1)/(P1' * A * P1)
        xnew = x + alpha*P1
        P0 = P1;
        x=xnew;
        hold  on;
        plot(i,r1(1),'+k');
%         plot(i,r1(2),'*r');
    %     plot(i,r1(3),'ob');
        hold off;
    end
end
