
A = imread('Zika Virus.tif');

[r,c,layer] = size(A);
Segmented = zeros(r,c);

B = rgb2gray(A);

for x = 1:r
    for y = 1:c
        if B(x,y) > 20 & B(x,y) <120
            Segmented(x,y) = 1;
        end;
    end
end;

Segmented = logical(Segmented);
Segmented = imfill(Segmented, 'holes');

figure, subplot(1,2,1), imshow(A), title('image ori'),...
    subplot(1,2,2), imshow(Segmented), title('objek biru');

L = bwlabel(Segmented);
ciri = regionprops('table',L,'Area', 'MajorAxisLength', 'MinorAxisLength')

