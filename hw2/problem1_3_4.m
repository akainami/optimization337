% Introduction to Optimization, Atakan Öztürk 110180026
% Problem Set 2, Problem 1 Question 3&4
clear all;
clc;
eps=0.01;
n=[2 5 10 20 100 200 300];
m=10000;
ges=0.0005;
%Using the algorithm for every n elements
for segment=1:numel(n)
    tic;
    for init=1:100 % For 100 Random Initial Points
        clear grad normgrad x y alpha;
        
        % Alpha is modified for the 4th part of Problem 1
        % alpha_k3=0.0001;
        % Please comment the steepest descent and secant methods
        
        grad=zeros(1,n(segment));
        normgrad=zeros(1,m);
        x=zeros(1,n(segment));
        y=zeros(1,n(segment));
        % Randomly Selecting x_i values between [-2,2]
        for i=1:n(segment)
            x(i)=4*rand(1)-2;
        end
        
        % This Section includes the choice of alpha for steepest descent
        syms alpha
        for i=1:numel(x)
            y(i)=y(i)+ges;
            grad(i)=(rbrock(y,n(segment))-rbrock(x,n(segment)))/ges;
            y(i)=y(i)-ges;
        end
        phi_a=diff(rbrock(x-alpha*grad,n(segment)),alpha);
        phi_a=matlabFunction(phi_a);
        alpha_k1=0.001;   alpha_k2=0.002;
        alpha_k3=alpha_k2-(alpha_k2-alpha_k1)*phi_a(alpha_k2)...
            /(phi_a(alpha_k2)-phi_a(alpha_k1));
        alpha_k1=alpha_k2; alpha_k2=alpha_k3;
        
        x=x-alpha_k3*grad;
        for k=1:m
            y=x;
            %Gradient Estimation
            for i=1:numel(x)
                y(i)=y(i)+ges;
                grad(i)=(rbrock(y,n(segment))-rbrock(x,n(segment)))/ges;
                y(i)=y(i)-ges;
            end
            
            for j=1:2
                phi_a=diff(rbrock(x-...
                    alpha*grad,n(segment)),alpha);
                phi_a=matlabFunction(phi_a);
                alpha_k3=alpha_k2-(alpha_k2-alpha_k1)*...
                    phi_a(alpha_k2)/(phi_a(alpha_k2)-phi_a(alpha_k1));
                alpha_k1=alpha_k2; alpha_k2=alpha_k3;
            end
            
            %New Values for X_i+1 and Norm of Gradient(rbrock(x))
            x=x-alpha_k3*grad;
            normgrad(k)=norm(grad);
            % Emergency Stop
            if normgrad(k)<eps
                break
            end
        end
    end
    it(segment)=k;
    t_0(segment)=(toc)*0.01;
    ave(segment)=it(segment)/t_0(segment);
end
% Plotting The Average Computation Time
figure;plot(n,ave);
xlabel("n");ylabel("Average Computation Speed");
figure;plot(n,t_0);xlabel("n");ylabel("Computation Time");
%% Definition of Rosenbrock Function
function f = rbrock(x,n)
% x is a vector containing all the variables of func
% n is size of func
f=0;
for i=1:n-1
    f=f+(100*(x(i+1)-x(i)^2)^2+(1-x(i))^2);
end
end
