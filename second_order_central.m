function fdash = second_order_central(f, x0, i, h)
%SECOND_ORDER_CENTRAL Second order central difference approximation of f'.
% fdash = SECOND_ORDER_CENTRAL(F, X0, I, H) returns
% (F(X0+I) - F(X0-I)) / (2*h) where F is a function handle, I is the index,
% and H is the subinterval with regards to time.
if ~isa(f, 'function_handle')
error('Your first argument was not a function handle')
end
fdash = (f(x0 + i) - f(x0 - i)) / (2 * h);
end