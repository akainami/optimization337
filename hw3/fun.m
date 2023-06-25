function z = fun(a)
% a is input array
x=a(1);
y=a(2);
z=3*(1-x^2)*exp(-x^2-(y+1)^2)-10*(x/5-x^3-y^5)*exp(-x^2-y^2)-exp(-(x+1)^2-y.^2)/3;
end

