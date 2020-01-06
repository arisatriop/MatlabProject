A = imread('Normal-bovine-erythrocytes.jpg');
B = rgb2gray(A);
imwrite(B,'grayErythrocytes.jpg');
imshow(B);


[counts, Idx] = imhist(B)
[Idx counts]
subplot(1,2,1), imshow(B), subplot(1,2,2), imhist(B)

[baris, kolom] = size(B)
g = zeros(baris, kolom);

for i = 1:baris
    for j = 1:kolom
        if B(i,j) < 213
            g(i,j) = 1;
        end;
    end
end;

g = logical(g);
figure, subplot(1,2,1), imshow(B), subplot(1,2,2), imshow(g)

o = zeros (baris, kolom);
level =  graythresh(B)*256;
for i = 1:baris
    for j = 1:kolom
        if B(i,j) < level
            o(i,j) = 1;
        end;
    end
end;

o = logical(o);
figure, subplot(1,2,1), imshow(g), title('manual'), subplot(1,2,2), imshow(o), title('otsu');