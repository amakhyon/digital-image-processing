rgbImage = imread('images/4.bmp');

% Extract color channels.
greenChannel = rgbImage(:,:,2); % Green channel
g = greenChannel;



%%extraction based on  gray scale below 100
binaryImage = g <= 100;
imshow(binaryImage);

%%applying dilation to fix the cell from holes
se1 = strel('disk',7 );
dilated = imdilate(binaryImage, se1);

%%applying erosion to get rid of small circles
BW2 = bwareaopen(dilated,1300);


%%creating and using a mask

maskedRgbImage = bsxfun(@times, rgbImage, cast(BW2, 'like', rgbImage));

imshow(maskedRgbImage);
