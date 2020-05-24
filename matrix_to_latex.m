function matrix_to_latex(M)
    format short
    P = size(M, 1);
    for i = 1:P
        napis = strcat(num2str(i), ' &');
        for j = 1:P
            napis = strcat(napis, num2str(M(i, j), '%.4f'));
            if j == P
                napis = strcat(napis, ' \\');
            else
                napis = strcat(napis, ' & ');
            end
        end
        disp(napis);
        disp('\hline')
    end
end