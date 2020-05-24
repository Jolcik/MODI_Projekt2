function [E_ucz, E_wer] = modi_projekt2_zad1_c(n)
    close all;

    A = importdata('danestat10.txt');

    ile_probek = size(A);
    ile_uczacych = floor(0.75*ile_probek(1));
    ile_weryfikujacych = ile_probek(1) - ile_uczacych;

    dane_uczace = A(1:ile_uczacych, : );
    dane_weryfikujace = A(ile_uczacych+1:ile_probek(1), : );

    M = ones(ile_uczacych, n+1);
    y = dane_uczace(:, 2);
    for i = 1:n
        M(:, i+1) = dane_uczace(:, 1).^(i);
    end

    M_wer = ones(ile_weryfikujacych, n+1);
    y_wer = dane_weryfikujace(:, 2);
    for i = 1:n
        M_wer(:, i+1) = dane_weryfikujace(:, 1).^(i);
    end

    w = M \ y;
    y_mod = M * w;
    y_mod_wer = M_wer * w;

    E_ucz = 0;
    P_ucz = size(y, 1);
    for i = 1:P_ucz
        E_ucz = E_ucz + (y_mod(i) - y(i))^2;
    end
    E_ucz = E_ucz/P_ucz;

    E_wer = 0;
    P_wer = size(y_wer, 1);
    for i = 1:P_wer
        E_wer = E_wer + (y_mod_wer(i) - y_wer(i))^2;
    end
    E_wer = E_wer/P_wer;

    x_mod_wykres =  (-1:0.1:1)';
    y_mod_wykres = w(1)*ones(size(x_mod_wykres, 1), 1);
    for i = 1:n
       y_mod_wykres = y_mod_wykres + w(i+1)*x_mod_wykres.^(i);
    end

    % wykres
    figure(1)
    hold on
    plot(x_mod_wykres, y_mod_wykres, 'LineWidth', 1.5);
    scatter(dane_uczace(:, 1), dane_uczace(:, 2), '.', 'g')
    hold off
    nazwa_wykresu = sprintf('Statyczny model nieliniowy dla N = %d, na tle zbioru uczącego', n);
    title(nazwa_wykresu)
    legend('Wyznaczona charakterystyka y(u)', 'Dane uczące', 'Dane weryfikujące')
    xlabel('u')
    ylabel('y')
    ylim([-15 10])
    nazwa_grafiki = sprintf('MODI_projekt2_zad1_c_%d_ucz', n);
    print(nazwa_grafiki,'-dpng','-r400')
    
    figure(2)
    hold on
    plot(x_mod_wykres, y_mod_wykres, 'LineWidth', 1.5);
    scatter(dane_weryfikujace(:, 1), dane_weryfikujace(:, 2), '.', 'r')
    hold off
    nazwa_wykresu = sprintf('Statyczny model nieliniowy dla N = %d, na tle zbioru weryfikującego', n);
    title(nazwa_wykresu)
    legend('Wyznaczona charakterystyka y(u)', 'Dane uczące', 'Dane weryfikujące')
    xlabel('u')
    ylabel('y')
    ylim([-15 10])
    nazwa_grafiki = sprintf('MODI_projekt2_zad1_c_%d_wer', n);
    print(nazwa_grafiki,'-dpng','-r400')
end
