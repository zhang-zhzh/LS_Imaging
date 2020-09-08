


% delete virtual images

 load('D:\WholeBrainImagingData\20180804_YFP_CUBIC_X\Stack_2\OriginalFile_MovedFile.mat');

 for i=1:length(VitualImageName)
     
     delete(VitualImageName{i})
     
     
 end
 
