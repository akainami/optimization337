clc; close all; clear all; tic;
%% Naive Random Search Algorithm
x(1,:)=6*rand(1,2)-3;
n=1000;
a=1;
b=0.5;
d(1)=0;
for k=1:n
   z(k,:)=neighbor(x(k,:),a,b);
    if fun(z(k,:))<fun(x(k,:))
        d(k)=-fun(z(k,:))+fun(x(k,:));
        x(k+1,:)=z(k,:);
                if d(k)~=0
            naive_rsa(k)=fun(x(k,:));
            x_=x(k,:);
        end
    else
        x(k+1,:)=x(k,:);
    end
end
d=nonzeros(d);
naive_rsa=nonzeros(naive_rsa);
fprintf("The Minimum of function, fun(), is %.5f by Naive RSA\n",naive_rsa(end));
clear n a b k z;
toc