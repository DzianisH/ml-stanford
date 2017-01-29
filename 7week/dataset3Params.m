function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 0;
sigma = 0;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

hyperParams = [0.01; 0.05; 1.5];

bestScore = -1;
bestC = 0;
bestSigma = 0;

for nextC = hyperParams(1):hyperParams(2):hyperParams(3)
    for nextSigma = hyperParams(1):hyperParams(2):hyperParams(3)
        model = svmTrain(X, y, nextC, @(x1, x2) gaussianKernel(x1, x2, nextSigma));
        predictions = svmPredict(model, Xval);
        
        score = mean(double( predictions == yval));
        if score > bestScore
            bestScore = score;
            bestC = nextC;
            bestSigma = nextSigma;
        end
    end
end

bestC
bestSigma
bestScore

C = bestC;
sigma = bestSigma;




% =========================================================================

end
