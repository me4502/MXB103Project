function [t, y, v, h] = RK4_bungee(T, n, g, C, K, L)
%RK4_bungee fourth order Runge-Kutta method for the bungee jumping model
% [t, y, v, h] = RK4_bungee(T, n, g, C, K, L) performs fourth order Runge-Kutta
% method on the bungee jumping model, taking n steps from t = 0 to t = T.
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
    k1 = h*(g - C*abs(v(j))*v(j) - max(0, K*(y(j) - L)));
    k2 = h*(g - C*abs(v(j) + k1/2)*(v(j) + k1/2) - max(0, K*(y(j) - L)));
    k3 = h*(g - C*abs(v(j) + k2/2)*(v(j) + k2/2) - max(0, K*(y(j) - L)));
    k4 = h*(g - C*abs(v(j) + k3)*(v(j) + k3) - max(0, K*(y(j) - L)));
    v(j+1) = v(j) + 1/6 * (k1 + 2*k2 + 2*k3 + k4);
    y(j+1) = y(j) + h*v(j);
end
end