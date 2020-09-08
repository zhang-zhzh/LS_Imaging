function tform=func_lightsheet_affine_registration( filenamefirststack, filenamesecondstack )

%%%% filenamefirststack, full file path and file names of the first stack

%%%% filenamesecondstack, full file path and file names of the first stack

 

nslice=numel(filenamefirststack);

ntotal=min(nslice, numel(filenamesecondstack));

nslice_upper=floor(nslice/3);

 

for i=nslice_upper:ntotal

   

    fixed=imread(filenamefirststack{i});

    moving=imread(filenamesecondstack{i});

 

    [optimizer,metric] = imregconfig('monomodal');

    tform = imregtform(moving,fixed,'affine',optimizer,metric);

    movingReg=imwarp(moving, tform, 'OutputView',imref2d(size(fixed)));

    filename_write=filenamesecondstack{i};

    filename_write=[filename_write(1:end-4), '_registered.tif'];

    imwrite(movingReg, filename_write);

end

 

 

return;