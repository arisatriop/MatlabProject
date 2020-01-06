%membaca file 
F = imread('GaussSegmentedBinary.jpg')
%konversi ke citra biner
I = im2bw(F);

%panggil fungsi bwlabel
[L,num] = bwlabel(I,4);
figure, subplot(1,2,1), imshow(I), title('ori binary'), ...
    subplot(1,2,2), imshow(L), title('labelled cells')
num
Baru = zeros(size(I));
Baru(find((L ==15) | (L ==30) | (L ==60))) = 1;
figure, subplot(1,2,1), imshow(L), title('labelled cells'), ...
    subplot(1,2,2), imshow(Baru), title('selected cells by label');