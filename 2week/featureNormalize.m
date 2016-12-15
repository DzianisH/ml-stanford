function [X_norm, mu, sigma] = featureNormalize(X)
%FEATURENORMALIZE Normalizes the features in X 
%   FEATURENORMALIZE(X) returns a normalized version of X where
%   the mean value of each feature is 0 and the standard deviation
%   is 1. This is often a good preprocessing step to do when
%   working with learning algorithms.

% ====================== YOUR CODE HERE ======================
% Instructions: First, for each feature dimension, compute the mean
%               of the feature and subtract it from the dataset,
%               storing the mean value in mu. Next, compute the 
%               standard deviation of each feature and divide
%               each feature by it's standard deviation, storing
%               the standard deviation in sigma. 
%
%               Note that X is a matrix where each column is a 
%               feature and each row is an example. You need 
%               to perform the normalization separately for 
%               each feature. 
%
% Hint: You might find the 'mean' and 'std' functions useful.
%       


    mu = mean(X);
    sigma = std(X);

%   tmpMu/tmpSigma is a matrix of size(X) elements, and every row of matrix
%   is equals to mu/sigma row matrix.
    tmpMu = zeros(size(X));
    tmpSigma = zeros(size(X));

%   How can I simplify it?
    for i = 1:size(X, 1)
        tmpMu(i, :) = mu;
        tmpSigma(i, :) = sigma;
    end;

%   Do normalisation by substructing Mu and dividing by Sigma.
%   Every column has its own Mu and Sigma.
    X_norm = X - tmpMu;
    X_norm = X_norm ./ tmpSigma;

% ============================================================

end
