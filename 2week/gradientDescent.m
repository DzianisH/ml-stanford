function [theta, J_history] = gradientDescent(X, y, theta, alpha, num_iters)
    m = length(y);
    J_history = zeros(num_iters, 1);

    for iter = 1:num_iters
%         Save the cost J in every iteration    
        J_history(iter) = computeCost(X, y, theta);

        dJ = computeCostPartialDerivatives(X, y, theta);
%         Do next gradient step
        theta = theta - alpha * dJ;
    end

    figure(4)
    plot(J_history);
    title('Cost function progress');
    xlabel('Nubmer of iteration');
    ylabel('cost');

%     hardcoded back to prev figure
    figure(1);

end

% this function should be some where else, but I can't create additional
% files
% Returns an vector of partial derivaters per every X
% (including first immutable x=1)
function dJ = computeCostPartialDerivatives(X, y, theta)

    err = X * theta - y;

    m = length(y);
    dJ = X' * err / m;

end

