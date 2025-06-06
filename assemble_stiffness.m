function [K] = assemble_stiffness(ENL, EL, NL, E, A)

NoE = size(EL, 1); % Number of elements
NPE = size(EL, 2); % Nodes per element

NoN = size(NL, 1);
PD = size(NL, 2);

K = zeros(NoN+PD, NoN+PD);

for i = 1:NoE
    nl = EL(i, 1:NPE); % Node list of each element
    k = element_stiffness(nl, ENL, E, A);
    for r= 1:NPE %d1
        for p = 1:PD

            for q = 1:NPE %d2
                for s = 1:PD
                    row = ENL(nl(r), P+3*PD); % orders wrt the global degree
                    column = ENL(nl(q), s+3*PD);

                    value = k((r-1)*PD+p, (q-1)*PD+s);
                    K(row, column) = K(row, column) + value;
                end
            end
        end
    end
end