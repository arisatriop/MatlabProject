function PreProsesGaussian
%membaca file erythrocytes
F = imread('grayErythrocytes.jpg')
%menyimpan dimensi citra
[r,c] = size(F)
%inisialisasi matriks output G
G = zeros(r,c)

%memanggil matriks kernel gausian
h = gausianKernel
%memastikan output berdimensi sama dengan citra asli
G = conv2(double(F),h,'same')
%memastikan G bertipe data unsigned integer 8 bit
G = uint8(G)

%display citra asli dan citra terubah
subplot(1,2,1),imshow(F),title('asli'),subplot(1,2,2),imshow(G),title('Gausian Filtered')