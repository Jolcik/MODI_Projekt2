cla reset;
A = importdata('danestat10.txt');

ile_probek = size(A);
ile_uczacych = floor(0.75*ile_probek(1));
ile_weryfikujacych = ile_probek(1) - ile_uczacych;

dane_uczace = A(1:ile_uczacych, : );
dane_weryfikujace = A(ile_uczacych+1:ile_probek(1), : );

M = [
    dane_uczace(:, 1) ones(ile_uczacych, 1)
];

y = dane_uczace(:, 2);

w = M \ y;
y_mod = M * w;

E_ucz = 0;
P_ucz = size(y, 1);
for i = 1:P_ucz
    E_ucz = E_ucz + (y_mod(i) - y(i))^2;
end
E_ucz = E_ucz/P_ucz;

E_wer = 0;
M_wer = [
    dane_weryfikujace(:, 1) ones(ile_weryfikujacych, 1)
];
y_wer = dane_weryfikujace(:, 2);
y_mod_wer = M_wer * w;
P_wer = size(y_wer, 1);
for i = 1:P_wer
    E_wer = E_wer + (y_mod_wer(i) - y_wer(i))^2;
end
E_wer = E_wer/P_wer;


x_mod_wykres = -1:0.1:1;
y_mod_wykres = w(1)*x_mod_wykres + w(2);

figure(1)
plot(x_mod_wykres, y_mod_wykres);
title('Charakterystyka y(u)')
xlabel('u')
ylabel('y')
print('MODI_projekt2_zad1_b','-dpng','-r400')
ylim([-15 10])

figure(2)
hold on
plot(x_mod_wykres, y_mod_wykres);
scatter(dane_uczace(:, 1), dane_uczace(:, 2), '.', 'g');
hold off
title('Charakterystyka y(u) na tle zbioru uczącego')
xlabel('u')
ylabel('y')
legend('Charakterystyka y(u)', 'Dane uczące')
print('MODI_projekt2_zad1_b_uczace','-dpng','-r400')

figure(3)
hold on
plot(x_mod_wykres, y_mod_wykres);
scatter(dane_weryfikujace(:, 1), dane_weryfikujace(:, 2), '.', 'r');
hold off
title('Charakterystyka y(u) na tle zbioru weryfikującego')
xlabel('u')
ylabel('y')
legend('Charakterystyka y(u)', 'Dane weryfikujące')
print('MODI_projekt2_zad1_b_weryfikujace','-dpng','-r400')

