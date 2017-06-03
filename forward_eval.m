function y = forward_eval(X, T, x)
%FORWARD_EVAL Evaluate Newtons forward difference form of the
%interpolating polynomial
% y = FORWARD_EVAL(X, T, x) returns y = Pn(x), where Pn is the
% interpolating polynomial constructed using the abscissas X and
% forward difference table T

[m,n] = size(T);
if m ~= n
    error('T must be square.');
end

% due to equal spacing and ascending order of X, taking the value of the difference
% between two adjacent values will all yield the same spacing h
h = X(2) - X(1);

S = ((x - X(1))/h);

y = zeros(size(x));
for k = 1:n % loop over sum index
    P = ones(size(x)); % initialise product
    for i = 1:k-1 % loop over product index
        P = P .* (S - i + 1); % multiply next factor        
    end
    y = y + T(k,k) * (P/factorial(k-1)); % add next term
end 
end