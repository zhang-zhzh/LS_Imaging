

for j=1:9


folder=['D:\WholeBrainImagingData\20181018_WY_DiI_WithBl\Stack_' num2str(j) '\'];

% folder='D:\WholeBrainImagingData\20181120_H90_1\20181120_H90\Stack_3_OG\'
fileContain=[folder,'*left*tif'];
Files=dir(fileContain);
saveFolder=[folder,'\ChangeBrightness\'];
mkdir(saveFolder)
for i=1:length(Files)

   filename=[folder,Files(i).name];
   savename=[saveFolder,Files(i).name]
   Im=loadTifFast(filename);
   writeTifFast(savename,Im/1.468,16);
  
end
end

















