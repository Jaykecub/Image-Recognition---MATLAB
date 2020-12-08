%%   Jacob Nading
%   Digital Image Processing
%   Final Project

%   Red Panda Image Recognition


%%  loading
close all
clear

figure
panda = imread('C:\Users\jacob_000\OneDrive\School\Digital Image Processing\FinalProject\panda2.png');
imshow(panda)
title('Original Panda')

figure
redpanda = panda(:,:,1);
imshow(redpanda)
title('Panda Red')

figure
greenpanda = panda(:,:,2);
imshow(greenpanda)
title('Panda Green')

figure
bluepanda = panda(:,:,3);
imshow(bluepanda)
title('Panda Blue')

figure
%pandacomp = imcomplement(panda);
pandathresh = redpanda > 180;
imshow(pandathresh)
title('Panda Thresh')

%%  Morph
kernelsize = 9;

kernelroad = strel('diamond',(kernelsize));
pandaroad = imerode(pandathresh, kernelroad);
figure
imshow(pandaroad)
title('Panda Erosion')


kerneldial = strel('diamond', (kernelsize*kernelsize));
pandadial =  imdilate(pandaroad, kerneldial);

pandabinary = pandadial;
figure
imshow(pandabinary)
title('Panda Dial after Erosion')

%%  Image Cleanup

figure

background = imcomplement(pandabinary);
background = im2uint8(background);
for n = 1 : 3
    pandafinal(:,:,n) = panda(:,:,n) - background(:,:);
end
imshow(pandafinal)
title('Panda Final')

%% %% more?
% 
% se = strel('diamond', 15);
% more = imopen(pandafinal,se);
% figure
% imshow(more)
% title('more?')
% more = im2uint8(more(:,:,1) > 100);
% 
% for n = 1 : 3
%     finalpanda(:,:,n) = pandafinal(:,:,n) - imcomplement(more(:,:));
% end
% figure
% imshow(finalpanda)
% title('Final Panda')