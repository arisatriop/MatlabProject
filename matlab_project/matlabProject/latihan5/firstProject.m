C = imread('Segmented Color.jpg');

%Memanggil fungsi bwlabel
I = im2bw(C)
L = bwlabel(I)

%menampilkan rerata warna per layer per objek
MeanR = regionprops('table',L,C(:,:,1),'MeanIntensity');
MeanG = regionprops('table',L,C(:,:,2),'MeanIntensity');
MeanB = regionprops('table',L,C(:,:,3),'MeanIntensity');

%set pewarnaan
FiturWarna = [MeanR.MeanIntensity MeanG.MeanIntensity MeanB.MeanIntensity]

%menampilkan properti 
ShapeDescp = regionprops('table',L,'Perimeter','Area','MajorAxisLength',...
    'MinorAxisLength','Centroid','Orientation')

Roundness = (ShapeDescp.Perimeter).^2./(4*pi*ShapeDescp.Area)

Ciri = [FiturWarna ShapeDescp.Area ShapeDescp.Perimeter Roundness]


IndeksUngu = find(Ciri(:,1) > 200 & Ciri(:,3) > 200)
IndeksTrombosit = find(Ciri(:,1) > 200 & Ciri(:,3) > 200 & Ciri(:,6) < 0.96)

subplot(1,2,1), imshow(C), title('gambar asli'), subplot(1,2,2), imhist(MeanR);