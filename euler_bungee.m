function [t, y, v, h] = euler_bungee(T, n, g, C, K, L)
%euler_bungee Euler's method for the bungee jumping model
% [t, y, v, h] = euler_bungee(T, n, g, C, K, L) performs Euler's method on
% the bungee jumping model, taking n steps from t = 0 to t = T.
% The initial conditions are y(0) = 0 and v(0) = 0.
% The inputs g, C, K and L are parameters from the model (see project description).
% The outputs are the time array t, the solution arrays y and v, and the
% subinterval width h.

% Calculate subinterval width h
h = T / n;

% Create time array t
t = 0:h:T;

% Initialise solution arrays y and v
y = zeros(1,n+1);
v = zeros(1,n+1);

% Perform iterations
for j = 1:n
    y(j+1) = y(j) + h*v(j);
    v(j+1) = v(j) + h*(g - C*abs(v(j))*v(j) - max(0, K*(y(j) - L)));
end
end