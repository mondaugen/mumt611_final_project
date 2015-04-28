function [B,G] = nmf(X,J,N=100,verbose=1,sanity=0)
% Factorizes X of size K-by-T into the matrices B and G each of size K-by-J and
% J-by-T resp.
% N is the number of iterations to perform.
% verbose - if non-zero, algorithm prints out current difference between X and
% B*G as the sum of the squared differences of each element, divided by the
% number of elements in X 
% sanity - if non-zero, algorithm checks values of matrices
[K,T] = size(X);
B = rand(K,J);
G = rand(J,T);
X += 1.0E-10; % Add regularization
%R=sum(sum(X))/sum(sum(B*G));
%B=sqrt(R)*B;
%G=sqrt(R)*G;
ONES = ones(K,T);
for n=(1:N),
    % Do updates and add regularization
    B = B.*((X./(B*G))*G')./(ONES*G') + 1.0E-10;
    G = G.*(B'*(X./(B*G)))./(B'*ONES) + 1.0E-10;
%    G(1:J,1:T) = G(1:J,1:T).*sum(B(:,(1:J)).*X(:,(1:T))./(B*G))./sum(B(:,(1:J)));
%    B = B.*sum(G.*X./(B*G))./sum(G);
    if verbose && (mod(n,verbose) == 0),
        TMP=B*G;
        if sanity,
            fprintf(stderr,'X negative? ');
            if (any(any(X < 0))),
                fprintf(stderr,'Yes');
            else,
                fprintf(stderr,'No');
            end;
            fprintf(stderr,'.\n');
            fprintf(stderr,'B*G negative? ');
            if (any(any(TMP < 0))),
                fprintf(stderr,'Yes');
            else,
                fprintf(stderr,'No');
            end;
            fprintf(stderr,'.\n');
            fprintf(stderr,'B*G == 0? ');
            if (any(any(TMP == 0))),
                fprintf(stderr,'Yes');
            else,
                fprintf(stderr,'No');
            end;
            fprintf(stderr,'.\n');
            fprintf(stderr,'X == 0? ');
            if (any(any(X == 0))),
                fprintf(stderr,'Yes');
            else,
                fprintf(stderr,'No');
            end;
            fprintf(stderr,'.\n');
            fprintf(stderr,'X == NaN? ');
            if (any(any(X == NaN))),
                fprintf(stderr,'Yes');
            else,
                fprintf(stderr,'No');
            end;
            fprintf(stderr,'.\n');
            fprintf(stderr,'B*G == NaN? ');
            if (any(any(TMP == NaN))),
                fprintf(stderr,'Yes');
            else,
                fprintf(stderr,'No');
            end;
            fprintf(stderr,'.\n');
            fprintf(stderr,'X == +-Inf? ');
            if (any(any(X == -Inf)) || any(any(X == Inf))),
                fprintf(stderr,'Yes');
            else,
                fprintf(stderr,'No');
            end;
            fprintf(stderr,'.\n');
            fprintf(stderr,'B*G == +-Inf? ');
            if (any(any(TMP == -Inf)) || any(any(TMP == Inf))),
                fprintf(stderr,'Yes');
            else,
                fprintf(stderr,'No');
            end;
            fprintf(stderr,'.\n');
        end;
        div = sum(sum(X.*log(X./(TMP)).-X.+(TMP)))/numel(X);
        fprintf(stderr,'iter: %d, diff: %f\n',n,div);
    end
end;
