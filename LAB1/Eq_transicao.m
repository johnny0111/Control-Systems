function [] = Eq_transicao(A,B)
syms tau t0 x10 x20
u = 1;
lim0 = 0;
lim1 = t0;
phi = transicao(A,0);
phif = transicao(A,tau);
xl = phi*transpose([x10 x20])
fun = @(tau ,t) phif*B*1;
xf = integral(fun, lim0, lim1,'ArrayValued',true)
end

