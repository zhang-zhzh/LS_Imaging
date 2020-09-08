EdgeFile='C:\Users\ZZZ\Desktop\0811YFP_10UM\edge\Edges.tif';
OriginalFile='C:\Users\ZZZ\Desktop\0811YFP_10UM\original\1_19.tif';

% Edge=loadTifFast('EdgeFile');
% OriginalIm=loadTifFast('OriginalFile');

Edge=imread_big(EdgeFile);
OriginalIm=imread_big(OriginalFile);


EdgeFolder=fileparts(EdgeFile);
OriginalFolder=fileparts(OriginalFile);

SaveFolderEdge=[EdgeFolder '\SlicesEdges\'];
SaveFolderOri=[OriginalFolder '\SlicesOriginal\'];

mkdir(SaveFolderEdge)
mkdir(SaveFolderOri)

for i=1:size(Edge,3)
   savename=[SaveFolderEdge,'Image',num2str(i),'.tif'];
   writeTifFast(savename,Edge(:,:,i),16);
end

for i=1:size(OriginalIm,3)
   savename=[SaveFolderOri,'Image',num2str(i),'.tif'];
   writeTifFast(savename,OriginalIm(:,:,i),16);
end


%%
folderEdge=SaveFolderEdge;
folderOriginal=SaveFolderOri;
Cutoff=0;
suffix='tif';
fudgeFactor=1;
DilateThick=200;
RemovePixelSize=1000;
Clearborder=0;
MaskImagesAccordingToImageJResults(folderEdge,folderOriginal,Cutoff,suffix,fudgeFactor,DilateThick,RemovePixelSize,Clearborder)
