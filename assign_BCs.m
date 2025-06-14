function [ENL, DOFs, DOCs] = assign_BCs(NL)

NoN = size(NL, 1); %Number of Nodes
PD = size(NL, 2); % Problem Dimension

ENL = zeros(NoN, PD*6);

ENL(:,1:2) = NL; % Coordinates

for i = 1 : NoN
    if((ENL(i, 1) == 0) && (ENL(i, 2) == 0)) % Node 1
        ENL(i,3) = -1; % BC of x
        ENL(i, 4) = -1 % BC of y

        ENL(i, 9) = 0; %Prescribed Disp. of x
        ENL(i, 10) = 0; % Prescribed disp of y
    
    elseif((ENL(i, 1) == 1) && (ENL(i, 2) == 0)) % Node 2   
        ENL(i,3) = 1; % BC of x
        ENL(i, 4) = -1 % BC of y

        ENL(i, 10) = 0; %Prescribed Disp. of x
        ENL(i, 11) = 0; % Prescribed Force of y

    elseif((ENL(i, 1) == 0.5) && (ENL(i, 2) == 1)) % Node 3   
        ENL(i,3) = 1; % BC of x
        ENL(i, 4) = 1 % BC of y

        ENL(i, 11) = 0; %Prescribed Force of x
        ENL(i, 12) = -20; % Prescribed Force of y
    end
end

DOFs = 0;
DOCs = 0;

for i = 1:NoN
    for j = 1:PD
        if(ENL(i, (PD+j)) == -1)
            DOCs = DOCs - 1;
            ENL(i, 2*PD+j) = DOCs;
        else
            DOFs = DOFs + 1;
            ENL(i, 2*PD+j) = DOFs;
        end
    end
end


for i = 1:NoN
    for j = 1:PD
        if (ENL(i, (2*PD+j)) < 0)
            ENL(i, PD*3+j) = DOFs + abs(ENL(i, (2*PD+j)));
        else
            ENL(i, PD*3+j) = ENL(i, (2*PD+j));
        end
    end
end

DOCs = abs(DOCs);

end
    