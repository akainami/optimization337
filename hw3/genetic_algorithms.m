clc;clear all;close all;tic;

n=1000; % Iteration Count
L=8; % Population Size or Chromosome Length
N_c=2; % Chromosome count for mating pool
% Even if there were 2 chromosomes to be used in crossing over, there would
% no need for a third chromosome since we will be using rand() function.
x=6*rand(L,2)-3; % The Initial points will be taken between (-4,4)
u=numel(x(1,:)); % u represents the number of input arguments for fun
for i=1:L
    f_v(i)=fun(x(i,:));
end
Fitness=sum(f_v);
for iteration=1:n
%         === Selection ===         %
% Using Roulette-Wheel Scheme
% So each u column represents x values
    for N=1:N_c
        for i=1:L
% Rand func can be used for probability cases
            if (rand<fun(x(i,:))/Fitness)
                M(i,u*N-(u-1):u*N)=x(i,:); % Satisfies the probability
            else
                M(i,u*N-(u-1):u*N)=6*rand(1,u)-3; % Default
            end
        end
    end
%        === Evolution ===          %
% -> Crossing Over
% Random Selection of 2 Chromosomes
    N_p=round((N-1)*rand(1,u)+1);
% There's a chance for obtaining same chromosomes.
% Crossing Over on c_site (point)
% I defined a c_over(x,y) function for a simple crossing over operation
    c_site=round((L-1)*rand+1);
    [M(c_site,u*N_p(1)-(u-1):u*N_p(1)),M(c_site,u*N_p(2)-(u-1):u*N_p(2))]=...
c_over(M(c_site,u*N_p(1)-(u-1):u*N_p(1)),M(c_site,u*N_p(2)-(u-1):u*N_p(2)));
% -> Mutation
% Similar to crossing over, a random point is chosen inside the mating pool
    m_point=round((L-1)*rand+1);
    m_chromosome=round((N-1)*rand+1);
    M(m_point,u*m_chromosome-(u-1):u*m_chromosome)=6*rand(1,u)-3;
    next=round((N-1)*rand+1);
    x=M(:,u*next-(u-1):u*next); % Selecting a chromosome randomly
    for i=1:L
        f_v(i)=fun(x(i,:));
    end
    bestf_i(iteration)=min(f_v);
end
bestf_f=min(bestf_i);
fprintf("The Minimum of function, fun(), is %.5f by Genetic Algorithm\n",bestf_f);

clear bestf_i c_site f_v Fitness i iteration L M m_chromosome m_point ...
    n N N_c N_p u next x;toc