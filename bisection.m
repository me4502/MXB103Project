function p = bisection(f, a, b, n)
%BISECTION Bisection method
% P = BISECTION(F, A, B, N) returns the closest computed point to N after
% applying the bisection method for solving f(x) = N, looping until
% it reaches the closest index where F is an anonymous function for f, and 
% [A,B] is the initial bracketing. Errors are raised if F is not given as 
% an anonymous function and if [A,B] does not bracket the root.
if ~isa(f, 'function_handle')
error('Your first input was not a function handle')
end
if f(a) > n && f(b) > n || f(a) < n && f(b) < n
error('a and b must be on opposing sides of n.')
end
while abs(a - b) > 1
    p = int16((a+b)/2); % compute the midpoint integer value for indexing
    if f(p) < n && f(a) < n || f(p) > n && f(a) > n
        a = p; % Move a closer to value n without crossing over
    else
        b = p; % Move b closer to value n without crossing over
    end
end
if abs(f(a) - n) < abs(f(b) - n)
    p = a;
else
    p = b;
end
end
