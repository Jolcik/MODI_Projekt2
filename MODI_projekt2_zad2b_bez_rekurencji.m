function [E_ucz, E_wer] = MODI_projekt2_zad2b_bez_rekurencji(n)
    cla reset;
    dane_uczace = importdata('danedynucz10.txt');
    dane_weryfikujace = importdata('danedynwer10.txt');
    u_ucz = dane_uczace(:, 1);
    y_ucz = dane_uczace(:, 2);
    u_wer = dane_weryfikujace(:, 1);
    y_wer = dane_weryfikujace(:, 2);

    P = size(y_ucz, 1);
    M = zeros(P-n, 2*n);

    % M dla zbioru uczącego
    y = y_ucz(n+1:P);
    for i = n:-1:1
        M(:, n-i+1) = u_ucz(i: P+i-n-1);
        M(:, 2*n-i+1) = y_ucz(i: P+i-n-1);
    end
    w = M\y;
    y_mod = M * w;

    % M dla zbioru weryfikacyjnego
    P_wer = size(y_wer, 1);
    M_wer = zeros(P-n, 2*n);
    for i = n:-1:1
        M_wer(:, n-i+1) = u_wer(i: P_wer+i-n-1);
        M_wer(:, 2*n-i+1) = y_wer(i: P_wer+i-n-1);
    end

    y_mod_wer = M_wer * w;
    
    % liczenie błędów
    E_ucz = 0;
    for i = 1:size(y, 1)
       E_ucz = E_ucz + (y(i) - y_mod(i))^2; 
    end
    E_ucz = E_ucz/P;
    
    E_wer = 0;
    y_wer_ograniczone = y_wer(n+1:P);
    for i = 1:size(y_wer_ograniczone, 1)
       E_wer = E_wer + (y_wer_ograniczone(i) - y_mod_wer(i))^2; 
    end
    E_wer = E_wer/P_wer;

    % wykres
    figure(1)
    plot(y)
    hold on
    plot(y_mod, '--', 'LineWidth', 2.5)
    hold off
    xlabel('k')
    ylabel('y(k)')
    legend('Model', 'Zbiór uczący')
    tytul = sprintf('Model dla danych uczących, bez rekurencji dla n = %d', n);
    title(tytul)
    nazwa_pliku = sprintf('modi_projekt2_zad2b_ucz_bez_rekurencji_%d', n);
    print(nazwa_pliku, '-dpng', '-r400')
    
    figure(2)
    plot(y_mod_wer, '--', 'LineWidth', 2.5)
    hold on
    plot(y_wer_ograniczone)
    hold off
    xlabel('k')
    ylabel('y(k)')
    legend('Model', 'Zbiór weryfikujący')
    tytul = sprintf('Model dla danych weryfikujących, bez rekurencji dla n = %d', n);
    title(tytul)
    nazwa_pliku = sprintf('modi_projekt2_zad2b_wer_bez_rekurencji_%d', n);
    print(nazwa_pliku, '-dpng', '-r400')
end