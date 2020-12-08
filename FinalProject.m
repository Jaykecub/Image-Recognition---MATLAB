%%   Jacob Nading
%   Digital Image Processing
%   Final Project

%   Red Panda Image Recognition

%   Universal Code but requires some analysis

%%  loading
close all
clear

%   Load image in
figure
%   INPUT PANDA IMAGE
panda = imread('panda.png');
imshow(panda)
title('Original Panda')

%   show red spectrum
figure
redpanda = panda(:,:,1);
imshow(redpanda)
title('Panda Red')

%   show green spectrum
figure
greenpanda = panda(:,:,2);
imshow(greenpanda)
title('Panda Green')

%   show blue spectrum
figure
bluepanda = panda(:,:,3);
imshow(bluepanda)
title('Panda Blue')

%%  Threshold
figure
%   take complement if background is higher value
%pandacomp = imcomplement(panda);

%   Threshold Panda to help narrow-down panda outline
%   SELECT WHICH COLOR SPECTRUM AND CHOOSE THRESHOLD VALUE
pandathresh = redpanda > 180;
imshow(pandathresh)
title('Panda Thresh')

%%  Morph

%   INPUT KERNEL SIZE
kernel = 9;

%   erode excess pixels (background noise)
kernelroad = strel('diamond',kernel);
pandaroad = imerode(pandathresh, kernelroad);

figure
imshow(pandaroad)
title('Panda Road')


%   dilate hopefully the major markings to the panda to fill in
kerneldial = strel('diamond', (kernel*kernel));
pandadial =  imdilate(pandaroad, kerneldial);

pandabinary = pandadial;
figure
imshow(pandabinary)
title('Panda Dial after Road')

%%  Image Cleanup | Background elimination & panda selection

figure
%   complement picture to select the background pixels (as 1 in binary)
background = imcomplement(pandabinary);
background = im2uint8(background);

%   each RGB value needs to be subtracted from the original
for n = 1 : 3
    pandafinal(:,:,n) = panda(:,:,n) - background(:,:);
end
imshow(pandafinal)
title('Panda Final')
