function z = neighbor(x,a,b)
% a and b are hypmerparameters for neighborhood
% x is input array
z=x+(a*rand(1,numel(x))-b);
end

