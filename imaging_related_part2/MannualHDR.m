


im=loadTifFast('D:\WholeBrainImagingData\20190511_H167_MultiScale\ImageLowPlanning_2_1.tif');
imHDR=tonemap(double(im),'AdjustSaturation',1);
writeTifFast('D:\WholeBrainImagingData\20190511_H167_MultiScale\HDR.tif',imHDR,8);