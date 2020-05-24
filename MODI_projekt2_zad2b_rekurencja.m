function [E_ucz, E_wer] = MODI_projekt2_zad2b_rekurencja(n)
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
    
    % OE dla zbioru uczącego
    y_mod = zeros(size(y_ucz, 1), 1);
    y_mod(1:n) = y_ucz(1:n);
    for i = n+1:size(y_ucz, 1)
        for j = 1:n
            y_mod(i) = y_mod(i) + w(j)*u_ucz(i-j) + w(n+j)*y_mod(i-j);
        end
    end
    y_mod = y_mod(n+1:size(y_mod, 1));

    % M dla zbioru weryfikacyjnego
    P_wer = size(y_wer, 1);
    M_wer = zeros(P-n, 2*n);
    for i = n:-1:1
        M_wer(:, i) = u_wer(i: P_wer+i-n-1);
        M_wer(:, n+i) = y_wer(i: P_wer+i-n-1);
    end

    % OE dla zbioru weryfikującego
    y_mod_wer = zeros(P_wer, 1);
    y_mod_wer(1:n) = y_wer(1:n);
    for i = n+1:P_wer
        for j = 1:n
            y_mod_wer(i) = y_mod_wer(i) + w(j)*u_wer(i-j) + w(n+j)*y_mod_wer(i-j);
        end
    end
    y_mod_wer = y_mod_wer(n+1:P_wer);
    
    
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
    plot(y_mod, '--')
    hold on
    plot(y)
    hold off
    xlabel('k')
    ylabel('y(k)')
    legend('Model', 'Zbiór uczący')
    tytul = sprintf('Model dla danych uczących, z rekurencją dla n = %d', n);
    title(tytul)
    nazwa_pliku = sprintf('modi_projekt2_zad2b_ucz_rekurencja_%d', n);
    print(nazwa_pliku, '-dpng', '-r400')
    
    figure(2)
    plot(y_mod_wer, '--')
    hold on
    plot(y_wer_ograniczone)
    hold off
    xlabel('k')
    ylabel('y(k)')
    legend('Model', 'Zbiór weryfikujący')
    tytul = sprintf('Model dla danych weryfikujących, z rekurencją dla n = %d', n);
    title(tytul)
    nazwa_pliku = sprintf('modi_projekt2_zad2b_wer_rekurencja_%d', n);
    print(nazwa_pliku, '-dpng', '-r400')
end