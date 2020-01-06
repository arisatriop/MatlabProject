img = imread('kasus8.jpg');
img2 = rgb2gray(img);
figure, subplot(1,2,1), imshow(img), title('image ori'),...
    subplot(1,2,2), imshow(img2), title('image gray');

h = gausianKernel
G = conv2(double(img2),h,'same');
G = uint8(G);
figure, subplot(1,2,1),imshow(img2),title('image gray'),...
    subplot(1,2,2),imshow(G),title('Gausian Filtered')

[baris,kolom] = size(G);
im = zeros(baris,kolom);
level = graythresh(G)*256;
for i = 1:baris
    for j = 1:kolom
        if G(i,j) < level
            im(i,j) = 1;
        end;
    end
end;
figure, subplot(1,2,1), imshow(img2), title('image gray'),...
    subplot(1,2,2), imshow(im), title('otsu');

Z = im2bw(im);


[L,num] = bwlabel(Z,4);
X = imfill(L,'holes');
figure, subplot(1,2,1), imshow(Z), title('imfill'),...
    subplot(1,2,2), imshow(X), title('labelled');
num