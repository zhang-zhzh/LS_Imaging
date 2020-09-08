
Folder='D:\WholeBrainImagingData\20190111_120_G\Stack_6\FFTDnoise\';
SaveFolder='D:\WholeBrainImagingData\20190111_120_G\Stack_6\FFTDnoise\Move_4_4\';
mkdir(SaveFolder)
StackIndex=[4 4];
Files=dir([Folder,'\','*_',num2str(StackIndex(1)),'_',num2str(StackIndex(2)),'.tif']);
for i=1:length(Files)
    CurrentName=[Folder,'\',Files(i).name];
    MoveName=[SaveFolder,'\',Files(i).name];
    copyfile(CurrentName,MoveName);
end
