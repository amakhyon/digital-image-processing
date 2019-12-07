rgbImage = imread('images/3.bmp');
hsv = rgb2hsv(rgbImage);
R = rgbImage(:,:,1);
G = rgbImage(:,:,2);
B = rgbImage(:,:,3);

h = hsv(:, :, 1); % Hue image.
s = hsv(:, :, 2); % Saturation image.
v = hsv(:, :, 3); % Value (intensity) image.

imshow(G);
impixelinfo;

%monoCell = (R > 163) & ( R < 208 ) & ( G > 99) & (G < 143) & (B > 193 ) & ( B < 225);

%%choose based on both saturation and green levels
monoCell = (s > 0.4) & (G < 150);

%%remove small circless
BW2 = bwareaopen(monoCell,300);


%%applying dilation to fix the cell from holes
se1 = strel('disk',8 );
dilated = imdilate(BW2, se1);
imshow(dilated);

%%creating and using a mask

maskedRgbImage = bsxfun(@times, rgbImage, cast(dilated, 'like', rgbImage));

imshow(maskedRgbImage);