function J = computeCost(X, y, theta)
%COMPUTECOST Compute cost for linear regression
%   J = COMPUTECOST(X, y, theta) computes the cost of using theta as the
%   parameter for linear regression to fit the data points in X and y

% err is a vector of errors of predictions for every input value
% X*theta is an hypothesis h
    err = X * theta - y;

    m = length(y);
    J = err' * err / (2 * m);

% =========================================================================
end

