dane_uczace = importdata('danedynucz10.txt');
dane_weryfikujace = importdata('danedynwer10.txt');

u_ucz = dane_uczace(:, 1);
y_ucz = dane_uczace(:, 2);
u_wer = dane_weryfikujace(:, 1);
y_wer = dane_weryfikujace(:, 2);

figure(1)
tiledlayout(2, 1)
nexttile
plot(u_ucz)
xlabel('k')
ylabel('u(k)')
title('u - dane uczące')

nexttile
plot(y_ucz)
xlabel('k')
ylabel('y(k)')
title('y - dane uczące')

print('modi_projekt2_zad2a_uczace','-dpng','-r400')


figure(2)
tiledlayout(2, 1)
nexttile
plot(u_wer)
xlabel('k')
ylabel('u(k)')
title('u - dane weryfikujące')

nexttile
plot(y_wer)
xlabel('k')
ylabel('y(k)')
ylim([-15 10])
title('y - dane weryfikujące')

print('modi_projekt2_zad2a_weryfikujace','-dpng','-r400')
