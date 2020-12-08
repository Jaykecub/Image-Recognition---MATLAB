%%   Jacob Nading
%   Digital Image Processing
%   Final Project

%   Red Panda Image Recognition


%%  loading

clear
figure

panda1 = imread('C:\Users\jacob_000\OneDrive\School\Digital Image Processing\FinalProject\panda1.png');
imshow(panda1)
title('Original')

figure
panda1R = panda1(:,:,1);
imshow(panda1R)
title('Panda Red')

figure
pandacomp = imcomplement(panda1);
bluepanda = pandacomp(:,:,3);
pandathresh = bluepanda > 150;
imshow(pandathresh)
title('Threshold Panda')

%%  Morph

kernel = strel('disk', 27);
pandadial =  imdilate(pandathresh, kernel);
pandaroad = imerode(pandadial, kernel);
pandabinary = pandaroad;
figure
imshow(pandabinary)
title('Filtered Panda')

%%  Image Cleanup

figure
for n = 1 : 3
    background(:,:,n) = imcomplement(pandabinary(:,:));
end
background = im2uint8(background);
panda = panda1 - uint8(background);
imshow(panda)
title('Final Panda')