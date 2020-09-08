% This function was used to find the mask of the image. 
% Usage: 
%      DetectedArea=EdgeDetection(InputIm,fudgeFactor,DilateThick,RemovePixelSize,Clearborder)
%         InputIm: input images
%     fudgeFactor: detect sensitivity. smaller, more sensitive
%     DilateThick: line thickness to draw the outline. 
% RemovePixelSize: remove area with pixel number lower than RemovePixelSize (100000). 
%     Clearborder: clear border(1) or not(0).

function DetectedArea=EdgeDetectionConvolve(InputIm,fudgeFactor,DilateThick,RemovePixelSize,Clearborder,Cutoff)

if exist('Cutoff')
    if length(Cutoff)>0
        InputIm(InputIm<Cutoff)=0;
    end
end

%Step 3: Dilate the Image
se90 = strel('line', DilateThick, 90);
se0 = strel('line', DilateThick, 0);
BWsdil = imdilate(InputIm, [se90 se0]);
% figure, imshow(BWsdil), title('dilated gradient mask');

%Step 4: Fill Interior Gaps
BWdfill = imfill(BWsdil, 'holes');
% figure, imshow(BWdfill);
% title('binary image with filled holes');

% move small connected areas
BWdfill=bwareaopen(BWdfill,RemovePixelSize);
% BWdfill= xor(bwareaopen(BWdfill,1000),  bwareaopen(BWdfill,10000));
% figure;imshow(BWdfill)

%Step 5: Remove Connected Objects on Border
% BWnobord = imclearborder(BWdfill, 4);
% figure, imshow(BWnobord,[]), title('cleared border image');

if Clearborder
    BWnobord = imclearborder(BWdfill, 4);
else
    BWnobord=BWdfill;
end


seD = strel('diamond',1);
BWfinal = imerode(BWnobord,seD);
DetectedArea = imerode(BWfinal,seD);

seD = strel('diamond',5);
DetectedArea = imerode(DetectedArea,seD);

% seD = strel('diamond',50);
% DetectedArea = imerode(DetectedArea,seD);

% figure, imshow(DetectedArea), title('segmented image');

end