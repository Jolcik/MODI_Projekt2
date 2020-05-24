function [E_ucz_arx, E_ucz_oe, E_wer_arx, E_wer_oe] = MODI_projekt2_zad2c(D, N, czy_rysowac_wykresy)
    cla reset;
    dane_uczace = importdata('danedynucz10.txt');
    dane_weryfikujace = importdata('danedynwer10.txt');
    u_ucz = dane_uczace(:, 1);
    y_ucz = dane_uczace(:, 2);
    u_wer = dane_weryfikujace(:, 1);
    y_wer = dane_weryfikujace(:, 2);

    P = size(y_ucz, 1);
    M = zeros(P-D, 2*D*N);

    y_ucz_ograniczone = y_ucz(D+1:P);
    for i = 1:D
        for j = 1:N
            index = N*(i-1) + j;
            M(:, index) = u_ucz(D-i+1: P-i).^j;
            M(:, D*N + index) = y_ucz(D-i+1: P-i).^j;
        end
    end
    w = M\y_ucz_ograniczone;
    y_ucz_arx = M*w;
    
    y_wer_ograniczone = y_wer(D+1:P);
    M_wer = zeros(P-D, 2*D*N);
    for i = 1:D
        for j = 1:N
            index = N*(i-1) + j;
            M_wer(:, index) = u_wer(D-i+1: P-i).^j;
            M_wer(:, D*N + index) = y_wer(D-i+1: P-i).^j;
        end
    end
    y_wer_arx = M_wer*w;

    %y_mod = M*w;
    % OE dla zbioru uczącego
    y_ucz_oe = zeros(size(y_ucz, 1), 1);
    y_ucz_oe(1:D) = y_ucz(1:D);
    for i = D+1:size(y_ucz, 1)
        for j = 1:D
            for k = 1:N
                u_w = N*(j-1)+k;
                y_w = D*N+N*(j-1)+k;
                y_ucz_oe(i) = y_ucz_oe(i) + w(u_w)*(u_ucz(i-j)^(k));
                y_ucz_oe(i) = y_ucz_oe(i) + w(y_w)*(y_ucz_oe(i-j)^(k));
            end
        end
    end
    y_ucz_oe = y_ucz_oe(D+1:size(y_ucz_oe, 1));

    % OE dla zbioru weryfikującego
    y_wer_oe = zeros(size(y_wer, 1), 1);
    y_wer_oe(1:D) = y_wer(1:D);
    for i = D+1:size(y_ucz, 1)
        for j = 1:D
            for k = 1:N
                u_w = N*(j-1)+k;
                y_w = D*N+N*(j-1)+k;
                y_wer_oe(i) = y_wer_oe(i) + w(u_w)*(u_wer(i-j)^(k));
                y_wer_oe(i) = y_wer_oe(i) + w(y_w)*(y_wer_oe(i-j)^(k));
            end
        end
    end
    y_wer_oe = y_wer_oe(D+1:size(y_wer_oe, 1));
    
    % liczenie błędów
    function E = oblicz_blad(y_obiekt, y_model)        
        ile_punktow = size(y_obiekt, 1);
        E = 0;
        for ind = 1:ile_punktow
            E = E + (y_obiekt(ind) - y_model(ind))^2;
        end
        E = E/ile_punktow;
    end
    E_ucz_arx = oblicz_blad(y_ucz_ograniczone, y_ucz_arx);
    E_ucz_oe = oblicz_blad(y_ucz_ograniczone, y_ucz_oe);
    E_wer_arx = oblicz_blad(y_wer_ograniczone, y_wer_arx);
    E_wer_oe = oblicz_blad(y_wer_ograniczone, y_wer_oe);
    
    if czy_rysowac_wykresy
        % wykres dla ARX
        figure(1)
        tiledlayout(2, 1)
        nexttile
        plot(y_ucz_ograniczone)
        hold on
        plot(y_ucz_arx, '--', 'LineWidth', 1.5)
        hold off
        xlabel('k')
        ylabel('y(k)')
        legend('Zbiór uczący', 'Model')
        tytul = sprintf('Model dla danych uczących, bez rekurencji dla D=%d, N=%d', D, N);
        title(tytul)
        %nazwa_pliku = sprintf('modi_projekt2_zad2c_ucz_bez_rekurencji_D%d_N%d', D, N);
        %print(nazwa_pliku, '-dpng', '-r400')

        nexttile
        plot(y_wer_ograniczone)
        hold on
        plot(y_wer_arx, '--', 'LineWidth', 1.5)
        hold off
        xlabel('k')
        ylabel('y(k)')
        legend('Zbiór weryfikujący', 'Model')
        tytul = sprintf('Model dla danych weryfikujących, bez rekurencji dla D=%d, N=%d', D, N);
        title(tytul)
        nazwa_pliku = sprintf('modi_projekt2_zad2c_bez_rekurencji_D%d_N%d', D, N);
        print(nazwa_pliku, '-dpng', '-r400')

        % wykres dla OE
        figure(2)
        tiledlayout(2, 1)
        nexttile
        plot(y_ucz_ograniczone)
        hold on
        plot(y_ucz_oe, '--', 'LineWidth', 1.5)
        hold off
        xlabel('k')
        ylabel('y(k)')
        legend('Zbiór uczący', 'Model')
        tytul = sprintf('Model dla danych uczących, z rekurencją dla D=%d, N=%d', D, N);
        title(tytul)
        %nazwa_pliku = sprintf('modi_projekt2_zad2c_ucz_rekurencja_D%d_N%d', D, N);
        %print(nazwa_pliku, '-dpng', '-r400')

        nexttile
        plot(y_wer_ograniczone)
        hold on
        plot(y_wer_oe, '--', 'LineWidth', 1.5)
        hold off
        xlabel('k')
        ylabel('y(k)')
        legend('Zbiór weryfikujący', 'Model')
        tytul = sprintf('Model dla danych weryfikujących, z rekurencją dla D=%d, N=%d', D, N);
        title(tytul)
        nazwa_pliku = sprintf('modi_projekt2_zad2c_rekurencja_D%d_N%d', D, N);
        print(nazwa_pliku, '-dpng', '-r400')
    end
end