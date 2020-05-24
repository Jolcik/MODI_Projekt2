A = importdata('danestat10.txt');

figure(1)
scatter(A(:, 1), A(:, 2), '.')
title('Wszystkie dane statyczne')
xlabel('u')
ylabel('y')

print('MODI_projekt2_zad1_wszystkie','-dpng','-r400')

% dane sa dzielone według zasady - 75% -> uczące, 25% -> weryfikujące
ile_probek = size(A);
ile_uczacych = floor(0.75*ile_probek(1));

dane_uczace = A(1:ile_uczacych, : );
dane_weryfikujace = A(ile_uczacych+1:ile_probek(1), : );


figure(2)
scatter(dane_uczace(:, 1), dane_uczace(:, 2), '.', 'g')
title('Dane uczące')
xlabel('u')
ylabel('y')
print('MODI_projekt2_zad1_uczace','-dpng','-r400')

figure(3)
scatter(dane_weryfikujace(:, 1), dane_weryfikujace(:, 2), '.', 'r')
title('Dane weryfikujące')
xlabel('u')
ylabel('y')
print('MODI_projekt2_zad1_weryfikujace','-dpng','-r400')

figure(4)
hold on
scatter(dane_uczace(:, 1), dane_uczace(:, 2), '.', 'g')
scatter(dane_weryfikujace(:, 1), dane_weryfikujace(:, 2), '.', 'r')
hold off
legend('Zbiór uczący', 'Zbiór weryfikujący')
xlabel('u')
ylabel('y')
print('MODI_projekt2_zad1_porownanie','-dpng','-r400')
