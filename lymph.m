rgbImage = imread('1.bmp');
hsv = rgb2hsv(rgbImage);
h = hsv(:, :, 1); % Hue image.
s = hsv(:, :, 2); % Saturation image.
v = hsv(:, :, 3); % Value (intensity) image.

%1
%subplot(2,4,1),imshow(h),title('hue');
%subplot(2,4,2), imshow(s), title('saturation');
%subplot(2,4,3), imshow(v), title('value');
%subplot(2,4,4), imshow(rgbImage), title('original image');

%%selecting areas where saturation is above 0.3
binaryImage = s >= 0.3;

%2
%subplot(2,4,5), imshow(binaryImage), title('s >=0.3');

%%getting rid of small circles
BW2 = bwareaopen(binaryImage,700);

%3
%subplot(2,4,6), imshow(BW2), title('pixels >= 700');


%%applying dilation to fix the cell from holes
se1 = strel('disk',3 );
dilated = imdilate(BW2, se1);


%4
%subplot(2,4,7), imshow(dilated), title('dilated');


%%applying image mask
maskedRgbImage = bsxfun(@times, rgbImage, cast(dilated, 'like', rgbImage));
imshow(maskedRgbImage);

%5
%subplot(2,4,8), imshow(maskedRgbImage), title('applying mask');

