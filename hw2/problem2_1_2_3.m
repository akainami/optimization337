% Introduction to Optimization, Atakan Öztürk 110180026
% Problem Set 2, Problem 2 Question 1&2&3
clc;
clear all;
close all;
syms x1 x2 x3 x4;

% Function (symbolic) Definition for the problem 2.1 (Q is positive defined)
f=(x1-4)^4 + (x2 - 3)^2 + 4*(x3 + 5)^4;
x=[x1,x2,x3];
x_0=[4,2,-1];

% Function (symbolic) Definition for the problem 2.2 (h(x_0) is not positive defined)
% f=-2*x1^2+(x1-x2)^2+(x2-x3)^2+x3^2;
% x=[x1 x2 x3];
% x_0=[1,2,3];
% mu_k=0.001;

% Function (symbolic) Definition for the problem 2.3
% f=(x1-x2)^2+(x2-x3)^2+x3^2;
% x=[x1 x2 x3];
% x_0=[1,2,3];
% mu_k=0.01;

n=10;

% Using the algorithm, x_(k+1)=x_(k)-inv(F(x_0))*g(x_0)
g=gradient(f,x);
h=hessian(f,x);
for i=1:n
Q=(subs(g,x,x_0));
% Levenberg Modification
% F=(subs(h,x,x_0))+mu_k*eye(numel(Q));
F=(subs(h,x,x_0));
x_f=matlabFunction(x_0-(F\Q)');
x_0=x_f()
end