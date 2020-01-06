B = imread('GaussSegmentedBinary.jpg')
%mengambil ukuran baris kolom dari matriks B
[r,c] = size(B)
%inisialisasi matriks
Gx = zeros(r,c)
Gy = zeros(r,c)
G = zeros(r,c)
%kernel sesuai operator sobel
sx = (1/8)*[-1 0 1; -2 0 2; -1 0 1]
sy = (1/8)*[1 2 1; 0 0 0; -1 -2 -1]

%memastikan output berdimensi sama dengan citra
Gx = conv2(double(B),sx,'same')
Gy = conv2(double(B),sy,'same')
absGx = uint8(abs(Gx))
absGy = uint8(abs(Gy))
%memastikan Gx dan Gy bertipe data unisgn integer 8bit
Gx = uint8(Gx)
Gy = uint8(Gy)
G = absGx + absGy;
imwrite(G,'TepiSobel.jpg')
%display citra hasil koncolusi dan absolutnya
subplot(1,2,1),imshow(Gx),title('Gx'),subplot(1,2,2),imshow(absGx),title('|Gx|')
figure, subplot(1,2,1),imshow(Gy),title('Gy'),subplot(1,2,2),imshow(absGy),title('|Gy|')
figure, subplot(1,2,1),imshow(B),title('binary'),subplot(1,2,2),imshow(G),title('Tepi/Edge')