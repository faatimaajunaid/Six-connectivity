function [I_Label] = update(I_Label,B_Label,C_Label)

[rows,columns,dim] = size(I_Label);
for i=1:rows
    for j=1:columns
        if I_Label(i,j) == C_Label
            I_Label(i,j) = B_Label;
        end
    end
end

end

