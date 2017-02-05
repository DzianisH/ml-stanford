function idx = findClosestCentroids(X, centroids)
%FINDCLOSESTCENTROIDS computes the centroid memberships for every example
%   idx = FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
%   in idx for a dataset X where each row is a single example. idx = m x 1 
%   vector of centroid assignments (i.e. each entry in range [1..K])
%

% Set K
K = size(centroids, 1);

% You need to return the following variables correctly.
idx = zeros(size(X,1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Go over every example, find its closest centroid, and store
%               the index inside idx at the appropriate location.
%               Concretely, idx(i) should contain the index of the centroid
%               closest to example i. Hence, it should be a value in the 
%               range 1..K
%
% Note: You can use a for-loop over the examples to compute this.
%

% Should work fine with any feature dimensions!

longDist = 2147483647;
for i = 1:size(X, 1)
    mDist2 = longDist;
    idx(i) = 1;
    for k = 1:K
        dist2 = X(i, :) - centroids(k, :);
        dist2 = dist2 .* dist2;
        dist2 = sum(sum(dist2));
        if dist2 < mDist2
            mDist2 = dist2;
            idx(i) = k;
        end
    end
end





% =============================================================

end

