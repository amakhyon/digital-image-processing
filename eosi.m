rgbImage = imread('images/5.bmp');
hsv = rgb2hsv(rgbImage);
h = hsv(:, :, 1);
%hsv = rgb2hsv(rgbImage);
%h = hsv(:, :, 1); % Hue image.
%s = hsv(:, :, 2); % Saturation image.
%v = hsv(:, :, 3); % Value (intensity) image.

%1
%subplot(2,4,1),imshow(h),title('hue');
%subplot(2,4,2), imshow(s), title('saturation');
%subplot(2,4,3), imshow(v), title('value');
%subplot(2,4,4), imshow(rgbImage), title('original image');

%2 
%r = rgbImage(:,:,1); % red channel
%g = rgbImage(:,:,2); % Green channel
%b = rgbImage(:,:,3); % blue channel


%subplot(2,4,5),imshow(r),title('red');
%subplot(2,4,6),imshow(g),title('green');
%subplot(2,4,7),imshow(b),title('bluee');
%impixelinfo;

%%get only eosi cell by hue value
eosiCell = h > 0.77;


%%applying erosion to get rid of small circles
BW2 = bwareaopen(eosiCell,1300);

%%applying dilation to fix the cell from holes
se1 = strel('disk',7 );
dilated = imdilate(BW2, se1);





%%creating and using a mask

maskedRgbImage = bsxfun(@times, rgbImage, cast(dilated, 'like', rgbImage));

%%another iteration at saturation > 0.15
hsv = rgb2hsv(maskedRgbImage);
s = hsv(:, :, 2);
finalS = s > 0.25;


%%applying erosion to get rid of small circles
BW3 = bwareaopen(finalS,1300);



%%applying dilation to fix the cell from holes
se1 = strel('disk',8 );
dilated = imdilate(BW3, se1);


%%creating and using a final mask

finalMaskedImage = bsxfun(@times, rgbImage, cast(dilated, 'like', rgbImage));
imshow(finalMaskedImage);
subplot(2,2,1), imshow(finalMaskedImage);
subplot(2,2,2), imshow(rgbImage);
impixelinfo;