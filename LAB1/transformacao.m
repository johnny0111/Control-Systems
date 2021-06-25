function [T,L] = transformacao(A)

    [T, D] = eig(A);
    L = diag(D)';

end

