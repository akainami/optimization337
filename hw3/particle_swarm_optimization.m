clear all; close all; clc; tic
%% Particle Swarm Optimization
c1=2;   % PSO Constants
c2=2;   % PSO Constants
w=0.99; % PSO Constants
n=1000;   % Iterations

d=200;   % Particle Number

x_0=6*rand(d,2)-3;
v_0=6*rand(d,2)-3;
p_0=x_0;
for i=1:d
    argue_vals(i)=fun(x_0(i,:));
end
[f_min,x_min]=min(argue_vals);
g_0=x_0(x_min,:);
r=rand(d,1);
s=rand(d,1);

for k=1:n
v_1=w*v_0+c1*r.*(p_0-x_0)+c2*s.*(g_0.*ones(d,1)-x_0);
x_1=x_0+v_1;
for i=1:d
    if fun(x_1(i,:))<fun(p_0(i,:))
        p_1(i,:)=x_1(i,:);
    else
        p_1(i,:)=p_0(i,:);
    end
end
for i=1:d
    if fun(x_1(i,:))<fun(g_0)
        g_1=x_1(i,:);
    else
        g_1=g_0;
    end
end
v_0=v_1;
x_0=x_1;
g_0=g_1;
p_0=p_1; 
end
fprintf("The Minimum of function, fun(), is %.5f by Particle Swarm Optimization\n",f_min);
clear ans argue_vals g_0 i k n p_0 p_1 r s v_0 v_1 w x_0 x_1 x_min
%%
toc