clc; close all;clear all; tic
%% Simulated Annealing Algorithm
x(1,:)=6*rand(1,2)-3;
% a and b are hyperparameters for neighborhood
a=2;
b=1;
n=1000;
gamma=2;
for k=1:n
    % Next step nominee with a probability pk
    z(k,:)=neighbor(x(k,:),a,b);
    probs=min(1,exp((-fun(z(k,:))+fun(x(k,:)))*log(2+k)/gamma));
    if probs==1
        d(k)=-fun(z(k,:))+fun(x(k,:));
        x(k+1,:)=z(k,:);
        if d(k)~=0
            simulann(k)=fun(x(k,:));
            x_=x(k,:);
        end
    else
        x(k+1,:)=x(k,:);
    end
end
d=nonzeros(d);
simulann=nonzeros(simulann);
fprintf("The Minimum of function, fun(), is %.5f by Simulated Annealing\n",simulann(end));
clear a b gamma k n probs z; toc