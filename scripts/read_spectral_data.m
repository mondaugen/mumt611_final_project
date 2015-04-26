function [X] = read_spectral_data(path,N)
% Return a complex matrix of N rows and L/N columns where L is 1/2 the number of
% doubles contained in the file at path.
if strcmp(path,"stdin")==1,
    f=stdin;
else,
    f=fopen(path)
end
X = fread(f,Inf,'double');
if strcmp(path,"stdin")==0,
    fclose(f);
end
X = X(1:2:end) + 1i*X(2:2:end);
X = reshape(X,[N length(X)/N]);
