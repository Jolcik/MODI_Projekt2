function F = model_nieliniowy(y_wejsciowe)

global u w
D = 5;
N = 4;

y = 0;
for j = 1:D
    for k = 1:N
        u_w = N*(j-1)+k;
        y_w = D*N+N*(j-1)+k;
        y = y + w(u_w)*(u^k);
        y = y + w(y_w)*(y_wejsciowe^k);
    end
end
 
F = y - y_wejsciowe;