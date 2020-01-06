
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

figure, subplot(1,2,1), imshow(img), title('gambar asli'),...
    subplot(1,2,2), imshow(o), title('otsu');
imwrite(o,'otsu.jpg')
%=====================================================================================================

%panggil fungsi bwlabel (untuk pelabelan)
[L,num] = bwlabel(o,4);
figure, subplot(1,2,1), imshow(img), title('image ori'), ...
    subplot(1,2,2), imshow(L), title('labelled cells')
num

%===================EKSTRAKSI CIRI=====================
%menampilkan properti
ShapeDescp = regionprops('table',L,'Perimeter','Area')

L = imfill(L,'holes');

%menghitung nilai roundness
Roundness = (ShapeDescp.Perimeter).^2./(4*pi*ShapeDescp.Area)

%pewarnaan
MeanR = regionprops('table',L,img(:,:,1),'MeanIntensity');
MeanG = regionprops('table',L,img(:,:,2),'MeanIntensity');
MeanB = regionprops('table',L,img(:,:,3),'MeanIntensity');
FiturWarna = [MeanR.MeanIntensity MeanG.MeanIntensity MeanB.MeanIntensity]


%EKSTRAKSI CIRI OBYEK
Ciri = [ShapeDescp.Area ShapeDescp.Perimeter Roundness FiturWarna]
%=========================================================================

%=======================Pengklasifikasian========================
%eritrosit
IndexEritrosit = find(Ciri(:,1) >1500 & Ciri(:,2) >140 & Ciri(:,3) <1)
erit = length(IndexEritrosit);
eritrosit = zeros(baris,kolom);
for i = 1:erit
    eritrosit(find(L==(IndexEritrosit(i)))) = 1 ;
end;

%leukosit
IndexLeukosit  = find( Ciri(:,1) >1500 & Ciri(:,2) <255 & Ciri(:,3) >1)
leuk = length(IndexLeukosit);
leukosit = zeros(baris,kolom);
for i = 1:leuk
    leukosit(find(L==(IndexLeukosit(i)))) = 1 ;
end;

%trombosit
IndexTrombosit = find(Ciri(:,1) <1000 & Ciri(:,2) <140 & Ciri(:,3) >0.85 & Ciri(:,3) <1.14  )
trom = length(IndexTrombosit);
trombosit = zeros(baris,kolom);
for i = 1:trom
    trombosit (find(L==(IndexTrombosit(i)))) = 1 ;
end;


%ungu
IndeksUngu = find(Ciri(:,4)<160 &  Ciri(:,6)>180 )
ung = length(IndeksUngu);
ungu= zeros(baris,kolom);
for i = 1:ung
    ungu (find(L==(IndeksUngu(i)))) = 1 ;
end;


%TAMPILKAN HASIL
figure, subplot(3,2,1:2), imshow(img), title('original');...
    subplot(3,2,3), imshow(eritrosit), title('Eritrosit');...
    subplot(3,2,4), imshow(leukosit), title('Leukosit');...
    subplot(3,2,5), imshow(trombosit), title('Trombosit');
    subplot(3,2,6), imshow(ungu), title('Polikromatofil');
