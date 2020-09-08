

% combine imaging matrix
MaxProjectedImagingMatrix=[];
for i=1:13
    load(['J:\20191114_H246_TM\Stack_' num2str(i)  '\Planning1.mat']);
    MaxProjectedImagingMatrix(:,:,i)=Planning.ImagingMatrixA;
end


