function [ x0 ] = bp(A, b)
n = size(A,2);
cvx_clear;
cvx_solver mosek;
cvx_begin quiet;
variable x(n);
minimize(norm(x,1));
subject to
A * x == b;
cvx_end
x0 = x;
end
