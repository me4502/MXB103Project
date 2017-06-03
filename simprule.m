function I = simprule(f, a, b, n, h)
%SIMPRULE Simpson's rule integration.
% I = SIMPRULE(F, A, B, N) returns Simpson's rule approximation for
% the integral of f(x) from x=A to x=B, using N subintervals,
% where F is a function handle.
if ~isa(f, 'function_handle')
error('Your first argument was not a function handle')
end
i = (b-a) / n;
x = a:i:b; % an array of length n+1
S = 0;
for j = (2:(n+2)/2)
    S = S + f(x(2*j - 2));
end
Q = 0;
for j = (2:(n+2)/2 - 1)
    Q = Q + f(x(2*(j-0.5)));
end
I = h/3 * (f(a) + 4*S + 2*Q + f(b));
end