function [B,G] = nmf(X,J,N=100)
% Factorizes X of size K-by-T into the matrices B and G each of size K-by-J and
% J-by-T resp.
% N is the number of iterations to perform.
[K,T] = size(X);
B = rand(K,J);
G = rand(J,T);
ONES = ones(K,T);
for n=(1:N),
    B = B.*((X./(B*G))*G')./(ONES*G');
    G = G.*(B'*(X./(B*G)))./(B'*ONES);
end;
