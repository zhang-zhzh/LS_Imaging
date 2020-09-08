

% combine imaging matrix
MaxProjectedImagingMatrix=[];
for i=1:6
   
    load(['D:\WholeBrainImagingData\20190906_F19_TM\Stack_' num2str(i)  '\Planning.mat']);
    MaxProjectedImagingMatrix(:,:,i)=Planning.ImagingMatrixA;
end


