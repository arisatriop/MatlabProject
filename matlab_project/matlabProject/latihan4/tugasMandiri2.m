B = imread('CitraTanpaObjekPinggiran.jpg')
I = im2bw(B)

[L,n] = bwlabel(I,4)

%tampilan
Ekstraksi = regionprops('table',L,'Area','Perimeter','Centroid')
allArea = [Ekstraksi.Area]
centroids = cat(1, Ekstraksi.Centroid)

index = find([Ekstraksi.Area] ~= 0 & [Ekstraksi.Area] < 400)

Baru = zeros(size(L));
k = length(index);
for i = 1:k
Baru(find(L==(index(i)))) = 1
end;


Z = zeros(size(I));
data = find(Ekstraksi.Area < 400)

Z(find((L == 9) | (L == 35) | (L == 37) | (L == 69) | (L == 76))) = 1

subplot(1,2,1), imshow(I), title('Labelled'), subplot(1,2,2), imshow(Baru), title('selected')