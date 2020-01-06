B = imread('GaussSegmentedBinary.jpg');
imshow(B);
%konversi menjadi citra bertipe biner
I = im2bw(B)
%meski nampak sama, tipe datanya berbeda
figure, subplot(1,2,1),imshow(B),title('ori gray'),subplot(1,2,2),imshow(I),title('ori binary')
%kernel biner 3x3 berbentuk lingkaran
kernel = strel('disk',2)
%operasi logika untuk mendapatkan tepi
Terkikis = imerode(I,kernel)
%operasi logika untuk mendapatkan tepi
Tepi = xor(Terkikis,I)
%menyimpan hasil sebagai citra bertipe jpeg
imwrite(Terkikis, 'shrink.jpg')
%display hasil
figure, subplot(2,2,1), imshow(I), title('binary'), subplot(2,2,2), imshow(Terkikis), title('eroded'), subplot(2,2,3), imshow(Tepi)