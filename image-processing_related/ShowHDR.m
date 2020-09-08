

folder='C:\Users\ZZZ\Desktop\First_120\Right\09\HDRS\test2\';

Folder=folder;
Thre=200;

Files=dir([Folder,'*.tif']);
SaveFolder=[Folder,'HDRS\'];
mkdir(SaveFolder)
for i=1:length(Files)
    filename=[Folder,Files(i).name];
    savename=[SaveFolder,Files(i).name];
    Im=loadTifFast(filename);
    Im(Im<Thre)=0;
    Im=double(Im);
    rgb=tonemap(Im,'AdjustSaturation',1);
    writeTifFast(savename,rgb,8)    
end


