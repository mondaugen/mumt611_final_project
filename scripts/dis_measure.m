function [d] = dis_measure(x)
% DIS_MEASURE -- Find the discontinuity measure of signal x.
x=x(:);
d=sum(diff(x).^2)/sum(x);
