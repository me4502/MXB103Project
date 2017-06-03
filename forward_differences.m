function T = forward_differences(Y)
%FORWARD_DIFFERENCES Newtons forward differences
% T = FORWARD_DIFFERENCES(Y) returns Newtons forward difference table.
% Note that the forward difference table is laid out in the matrix T as:
% y0
% y1 del y0
% y2 del y1 del^2 y0
% y3 del y2 del^2 y1 del^3 y0
% etc.
%The rest of the matrix T is zero.
n = length(Y);

%Construct empty forward difference table
T = zeros(n, n);

%Fill first column
T(:,1) = Y;

%Fill remaining columns
for j = 2:n % j is the column index
    for i = j:n % i is the row index
        T(i,j) = T(i,j-1) - T(i-1,j-1);
    end
end