function RerataCitra
% membaca file erythrocytes
F = imread('D:grayErythrocytes.jpg');
%menyimpan dimensi citra
[r,c] = size(F)
%inisialisasi matrix output G
G = zeros(r,c)

%membuat matrix kernel
h = (1/9) *ones(3,3)
%memastikan output berdimensi sama dengan citra asli
G = conv2(F,h,'same')
%memastikan G bertipe data unsigned integer 8 bit
G = uint8(G)

%display citra asli dan citra terubah
subplot(1,2,1), title('asli'), imshow(F), subplot(1,2,2), title('terubah'), imshow(G)
