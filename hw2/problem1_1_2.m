% Introduction to Optimization, Atakan Öztürk 110180026
% Problem Set 2, Problem 1 Question 1&2
%% Initialization
clear all;
clc;
syms alpha;
n=10;
%alpha_k=zeros(1,n);
x=zeros(3,n);
x_0=[4,2,-1];
fun1(x(:,1));
grad_fun1(x(:,1));

%% Steepest Descent Gradient Method
x(:,1)=x_0';
% The adventure on the way of finding alpha(1)
phi_a=(diff(fun1(x(:,1)'-alpha.*grad_fun1(x(:,1))),alpha));
fplot(phi_a,[0.0033 0.0045]); xlabel('Alpha');ylabel('Phi');
phi_a=matlabFunction(phi_a);
alpha_k1=0.00402; % Estimated from graph
alpha_k2=0.00400; %Estimated from graph

%First Steps For a newborn alpha_0
alpha_k3=alpha_k2-(alpha_k2-alpha_k1)*phi_a(alpha_k2)...
    /(phi_a(alpha_k2)-phi_a(alpha_k1));
alpha_k1=alpha_k2; alpha_k2=alpha_k3; 
x(:,2)=x(:,1)'-alpha_k3*grad_fun1(x(:,1));
for i=1:n-1
    for j=1:3
    phi_a=matlabFunction(diff(fun1(x(:,i+1)'-...
        alpha.*grad_fun1(x(:,i+1))),alpha));
    alpha_k3=alpha_k2-(alpha_k2-alpha_k1)*...
    phi_a(alpha_k2)/(phi_a(alpha_k2)-phi_a(alpha_k1));
    alpha_k1=alpha_k2; alpha_k2=alpha_k3; 
    end
    x(:,i+2)=x(:,i+1)'-alpha_k3*grad_fun1(x(:,i+1));
end

%% Fixed Step Sized Gradient Descent Method
clear alpha_k x i ans alpha phi_a;
m=10000;
x=zeros(3,m);
% Same operations with a constant alpha value of alpha_c
alpha_c=0.005;
x(:,1)=x_0';
for i=1:m
    x(:,i+1)=x(:,i)'-alpha_c*grad_fun1(x(:,i));
end
%%  Function Definitions
%Function from Example 8.1
function z = fun1(x)
z=(x(1)-4)^4 + (x(2) - 3)^2 + 4*(x(3) + 5)^4;
end
%Gradient
function grad = grad_fun1(x)
grad(1)=4*(x(1)-4)^3;
grad(2)=2*(x(2)-3);
grad(3)=16*(x(3)+5)^3;
end
