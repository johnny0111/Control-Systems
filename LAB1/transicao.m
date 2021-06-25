function [phi] = transicao(A,tau)

syms s t;

sia = s * eye(size(A,1),size(A,2)) - A
phiS = adjoint(sia) / det(sia)
phi = ilaplace(phiS, t-tau)
end

