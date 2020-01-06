%membaca image
img = imread('Kasus8.jpg');

%================PREPROCESSING=====================
%rgb ke gray
I = rgb2gray(img);
%imwrite(I,'grayBloodCells.jpg');

%display citra asli dan citra grayscale
figure,subplot(1,2,1),imshow(img),title('Ori'),...
    subplot(1,2,2),imshow(I),title('Gray');

%====SEGMENTASI (memisahkan background dengan obyek)=====
[baris, kolom] = size(I);
o = zeros (baris, kolom);
level =  graythresh(I)*256;
for i = 1:baris
    for j = 1:kolom
        if I(i,j) < level
            o(i,j) = 1;
        end;
    end
end;

o = logical(o);
figure, subplot(1,2,1), imshow(I), title('Gray'),...
    subplot(1,2,2), imshow(o), title('Otsu');
%imwrite(o,'otsuBloodCells.jpg');
%=======================================================

%fill holes
F = imfill(o,'holes');
figure, subplot(1,2,1), imshow(o), title('Sebelum di Fill'),...
    subplot(1,2,2), imshow(F), title('Fill Holes');
%imwrite(F,'objectFillHolse.jpg');

%panggil fungsi bwlabel (untuk pelabelan)
[L,num] = bwlabel(F,4);
%figure, subplot(1,2,1), imshow(F), title('No Label'), ...
    figure, subplot(1,2,1), imshow(L), title('Labelled cells');
num

%===================EKSTRAKSI CIRI=====================
%menampilkan properti
ShapeDescp = regionprops('table',L,'Perimeter','Area');

%menghitung nilai roundness
Roundness = (ShapeDescp.Perimeter).^2./(4*pi*ShapeDescp.Area);

%EKSTRAKSI CIRI OBYEK
Ciri = [ShapeDescp.Area ShapeDescp.Perimeter Roundness]
%======================================================================

%=============set nilai eritrosit, leukosit, trombosit=================
%eritrosit
IndexEritrosit = find(Ciri(:,1) >= 1000 & Ciri(:,1) <= 2500 &...
    Ciri(:,2) >= 154 & Ciri(:,2) <= 170 & Ciri(:,3) <= 1.1) 
erit = length(IndexEritrosit);
eritrosit = zeros(baris,kolom);
for i = 1:erit
    eritrosit(find(L==(IndexEritrosit(i)))) = 1 ;
end;
eritrosit = logical(eritrosit);

%leukosit
IndexLeukosit  = find(Ciri(:,1) >= 1000 & Ciri(:,1) <= 2500 &...
    Ciri(:,2) > 170 & Ciri(:,3) <= 1.11)
leuk = length(IndexLeukosit);
leukosit = zeros(baris,kolom);
for i = 1:leuk
    leukosit(find(L==(IndexLeukosit(i)))) = 1 ;
end;
leukosit = logical(leukosit);

%trombosit
IndexTrombosit = find(Ciri(:,1) >= 2500 & Ciri(:,3) <= 1.1)
trom = length(IndexTrombosit);
trombosit = zeros(baris,kolom);
for i = 1:trom
    trombosit (find(L==(IndexTrombosit(i)))) = 1 ;
end;
trombosit  = logical(trombosit );

%TAMPILKAN HASIL
figure, subplot(2,2,1), imshow(img), title('original');...
    subplot(2,2,2), imshow(eritrosit), title('Eritrosit');...
    subplot(2,2,3), imshow(leukosit), title('Leukosit');...
    subplot(2,2,4), imshow(trombosit), title('Trombosit');
