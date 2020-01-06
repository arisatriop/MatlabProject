
%membaca image
img = imread('Kasus8.jpg');

%================PREPROCESSING=====================
%rgb ke gray
I = rgb2gray(img);
%memanggil matriks kernel gausian
h = gausianKernel
%memastikan output berdimensi sama dengan citra asli
G = conv2(double(I),h,'same');
%memastikan G bertipe data unsigned integer 8 bit
G = uint8(G);

%display citra asli dan citra terubah
subplot(1,2,1),imshow(img),title('asli'),subplot(1,2,2),imshow(G),title('Gausian Filtered')
%===========================================================================================

%==========SEGMENTASI (memisahkan background dengan obyek)==========
[baris, kolom] = size(G);
o = zeros (baris, kolom);
level =  graythresh(G)*256;
for i = 1:baris
    for j = 1:kolom
        if G(i,j) < level
            o(i,j) = 1;
        end;
    end
end;

o = logical(o);
figure, subplot(1,2,1), imshow(img), title('gambar asli'), subplot(1,2,2), imshow(o), title('otsu');
%=====================================================================================================

%panggil fungsi bwlabel (untuk pelabelan)
[L,num] = bwlabel(o,4);
figure, subplot(1,2,1), imshow(img), title('image ori'), ...
    subplot(1,2,2), imshow(L), title('labelled cells')
num

%===================EKSTRAKSI CIRI=====================
%menampilkan properti
ShapeDescp = regionprops('table',L,'Perimeter','Area','MajorAxisLength',...
    'MinorAxisLength','Centroid','Orientation')

%menghitung nilai roundness
Roundness = (ShapeDescp.Perimeter).^2./(4*pi*ShapeDescp.Area)

%EKSTRAKSI CIRI OBYEK
Ciri = [ShapeDescp.Area ShapeDescp.Perimeter Roundness]
%=========================================================================


%=============set nilai eritrosit, leukosit, trombosit=================
%eritrosit
IndexEritrosit = find(Ciri(:,2) <200 & Ciri(:,1) >2200 & Ciri(:,3) <=2)
erit = length(IndexEritrosit);
eritrosit = zeros(baris,kolom);
for i = 1:erit
    eritrosit(find(L==(IndexEritrosit(i)))) = 1 ;
end;
eritrosit = logical(eritrosit);

%leukosit
IndexLeukosit  = find(Ciri(:,2) <200 & Ciri(:,1) <=2200 & Ciri(:,3) <=2)
leuk = length(IndexLeukosit);
leukosit = zeros(baris,kolom);
for i = 1:leuk
    leukosit(find(L==(IndexLeukosit(i)))) = 1 ;
end;
leukosit = logical(leukosit);

%trombosit
IndexTrombosit = find(Ciri(:,2) >=200 & Ciri(:,3)  <=1.8)
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
