E_bez_rekurencji = zeros(3, 2);
E_rekurencja = zeros(3, 2);
for i = 1:3
    [E_bez_rekurencji(i, 1), E_bez_rekurencji(i, 2)] = MODI_projekt2_zad2b_bez_rekurencji(i);
    [E_rekurencja(i, 1), E_rekurencja(i, 2)] = MODI_projekt2_zad2b_rekurencja(i);
end



