D = 5;
N = 4;

dane_uczace = importdata('danedynucz10.txt');
u_ucz = dane_uczace(:, 1);
y_ucz = dane_uczace(:, 2);

P = size(y_ucz, 1);
M = zeros(P-D, 2*D*N);

global u w

y_ucz_ograniczone = y_ucz(D+1:P);
for i = 1:D
    for j = 1:N
        index = N*(i-1) + j;
        M(:, index) = u_ucz(D-i+1: P-i).^j;
        M(:, D*N + index) = y_ucz(D-i+1: P-i).^j;
    end
end
w = M\y_ucz_ograniczone;

x0 = [0];
wektor_u = linspace(-1, 1, 50);
wektor_y = zeros(size(wektor_u', 1), 1);
for i = 1:size(wektor_u', 1)
    u = wektor_u(i);
    wektor_y(i) = fsolve(@model_nieliniowy, x0);
end

plot(wektor_u, wektor_y)
title('Charakterystyka y(u) statycznego modelu nieliniowego')
xlabel('u')
ylabel('y(u)')
print('modi_projekt2_zad2d', '-dpng', '-r400')
