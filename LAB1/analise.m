Y=out.RY.Data(10:end,2);
ref=out.RY.Data(10:end,1);
U=out.U.Data(10:end);
error=ref-Y;
IEQ = sum(error.^2);
IUQ = sum(U.^2);
static_error = ref(end)-Y(end);
fig=figure();
subplot(2,1,1), plot(Y), hold on, plot(ref)
title('Resposta do sistema em anel fechado')
ylabel('Saída'), xlabel('Amostra')
ylim([0 1])
subplot(2,1,2), plot(U)
title('Actuação')
ylabel('Acção de controlo'), xlabel('Amostra')
ylim([0 25])
save('control_1');
savefig('control_1');