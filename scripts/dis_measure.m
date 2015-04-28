function [d] = dis_measure(x)
% DIS_MEASURE -- Find the discontinuity measure of signal x.
x=x(:);
d=sum((x(2:end)-x(1:end-1)).^2)/sum(x.^2);
