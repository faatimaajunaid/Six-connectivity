function [BW,B] = findthreshold(inputfile)

%inputfile='coins.png';

I = imread(inputfile);
level = graythresh(I);
BW = im2bw(I,level);
BW = imfill(BW,'holes');

[rows,columns,dim] = size(I);

% I_Label(1,1) = 0;
% I_Label(1,2) = 0;
% I_Label(2,1) = 0;
for i=1:rows
    for j=1:columns
        I_Label(i,j) = 0;
    end
end

count = 1;
for i=2:rows-1
    for j=2:columns-1
        
        B_Label = I_Label(i,j-1);
        C_Label = I_Label(i-1,j);
        D_Label = I_Label(i-1,j-1);
        
        A = BW(i,j);
        B = BW(i,j-1);
        C = BW(i-1,j);
        D = BW(i-1,j-1);
        
        if A ~= 0
            if A ~= D
                if A == B
                    if A ~= C
                        A_Label = B_Label;
                        I_Label(i,j) = A_Label;
                        continue;
                    else
                        if B_Label == C_Label
                            A_Label = B_Label;
                            I_Label(i,j) = A_Label;
                            continue;
                        else
                            I_Label = update(I_Label,B_Label,C_Label);
                            A_Label = B_Label;
                            I_Label(i,j) = A_Label;
                            continue; 
                        end
                    end
                else
                    if A == C
                        A_Label = C_Label;
                        I_Label(i,j) = A_Label;
                        continue;
                    else
                        A_Label = count;
                        I_Label(i,j) = A_Label;
                        count = count+1;
                        continue;
                    end
                end
            else
                A_Label = D_Label;
                I_Label(i,j) = A_Label;
                continue;
            end
        else
            continue;
        end
    end
end

% I_Label2 = bwlabel(BW);
% 
% I_Label2 = uint8(I_Label2);

I_Label = uint8(I_Label);


I_Label2 = I_Label;
I_Label2 = I_Label2(:); 
I_Label2 = sort(I_Label2);

counter = 0;
for i=1:size(I_Label2)-1
    if I_Label2(i) ~= I_Label2(i+1)
        
        counter = counter+1;
        map(counter) = I_Label2(i+1);
    end
end

map = uint8(map);


[rows,columns,dim] = size(I_Label)

for i=1:rows
    for j=1:columns
        for k=1:counter
            if I_Label(i,j) == map(k)
                
                I_Label(i,j) = uint8(k);
                
            end
        end
    end
end

for i=1:rows
    for j=1:columns
        B(i,j,1) = 255;
        B(i,j,2) = 255;
        B(i,j,3) = 255;
    end
end

B = double(B);

for i=1:rows
    for j=1:columns
        
        if I_Label(i,j) == 0
            B(i,j,1) = 255;
            B(i,j,2) = 255;
            B(i,j,3) = 255;
        elseif I_Label(i,j) == 1
            B(i,j,1) = 255;
            B(i,j,2) = 0;
            B(i,j,3) = 0;
        elseif I_Label(i,j) == 2
            B(i,j,1) = 0;
            B(i,j,2) = 255;
            B(i,j,3) = 0;      
        elseif I_Label(i,j) == 3
            B(i,j,1) = 0;
            B(i,j,2) = 0;
            B(i,j,3) = 255;
        elseif I_Label(i,j) == 4
            B(i,j,1) = 0;
            B(i,j,2) = 255;
            B(i,j,3) = 255;
        elseif I_Label(i,j) == 5
            B(i,j,1) = 255;
            B(i,j,2) = 0;
            B(i,j,3) = 255;
        elseif I_Label(i,j) == 6
            B(i,j,1) = 255;
            B(i,j,2) = 255;
            B(i,j,3) = 0;
        elseif I_Label(i,j) == 7
            B(i,j,1) = 128;
            B(i,j,2) = 0;
            B(i,j,3) = 0;
        elseif I_Label(i,j) == 8
            B(i,j,1) = 0;
            B(i,j,2) = 128;
            B(i,j,3) = 0;
        elseif I_Label(i,j) == 9
            B(i,j,1) = 0;
            B(i,j,2) = 0;
            B(i,j,3) = 128;
        elseif I_Label(i,j) == 10
            B(i,j,1) = 128;
            B(i,j,2) = 128;
            B(i,j,3) = 0;
         end
    end
end
B=uint8(B);
imshow(B);

imwrite(BW,'binary.png');

imwrite(B,'output.png');
