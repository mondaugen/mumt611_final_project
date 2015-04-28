function [B,G] = nmf(X,J,N=100,verbose=1)
% Factorizes X of size K-by-T into the matrices B and G each of size K-by-J and
% J-by-T resp.
% N is the number of iterations to perform.
% verbose - if non-zero, algorithm prints out current difference between X and
% B*G as the sum of the squared differences of each element, divided by the
% number of elements in X 
[K,T] = size(X);
B = rand(K,J);
G = rand(J,T);
%R=sum(sum(X))/sum(sum(B*G));
%B=sqrt(R)*B;
%G=sqrt(R)*G;
ONES = ones(K,T);
for n=(1:N),
    B = B.*((X./(B*G))*G')./(ONES*G');
    G = G.*(B'*(X./(B*G)))./(B'*ONES);
    if verbose && (mod(n,verbose) == 0),
        div = sum(sum(X.*log(X./(B*G)).-X.+(B*G)))/numel(X);
        fprintf(stderr,'iter: %d, diff: %f\n',n,div);
    end
end;
