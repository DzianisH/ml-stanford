function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
                               
% input_layer_size = 2;              % input layer
% hidden_layer_size = 2;              % hidden layer
% num_labels = 4;              % number of labels
% nn_params = [ 1:18 ] / 10;  % nn_params
% X = cos([1 2 ; 3 4 ; 5 6]);
% y = [4; 2; 3];
% lambda = 4;
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%


% 1) FF
a1 = [ones(size(X, 1), 1), X];
z2 = a1 * Theta1';
a2 = [ones(size(z2, 1), 1), sigmoid(z2)];
z3 = a2 * Theta2';
a3 = sigmoid(z3);
h = a3;

% unroll vector y to logical array
Y = zeros(size(y,1), num_labels);
for i=1:m
    Y(i, y(i,1)) = 1;
end

J = Y .* log(h) + (1 - Y) .* log(1 - h);
J = -sum(sum(J)) / m;
if isnan(J)
    J = 0;
end


% 2) BP
Delta1 = zeros(size(Theta1));
Delta2 = zeros(size(Theta2));
for i=1:m
   delta3 = (h(i,:) - Y(i,:))';
   delta2 = Theta2' * delta3; % need to scip delta for bias
   delta2 = delta2(2:end,:) .* sigmoidGradient(z2(i,:)'); % (a2(i,:) .* (1 - a2(i,:)))';

   Delta1 = Delta1 +  delta2 * a1(i,:);
   Delta2 = Delta2 +  delta3 * a2(i,:);
end
Theta1_grad = Delta1 / m;
Theta2_grad = Delta2 / m;


% 3) L2 Regularisation
tmp1 = Theta1(:, 2:end);
tmp2 = Theta2(:, 2:end);
J = J + (sum(sum(tmp1 .* tmp1)) + sum(sum(tmp2 .* tmp2))) * lambda / (2*m);

Theta1_grad = Theta1_grad + [zeros(size(tmp1, 1), 1), tmp1] * lambda / m;
Theta2_grad = Theta2_grad + [zeros(size(tmp2, 1), 1), tmp2] * lambda / m;


% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
