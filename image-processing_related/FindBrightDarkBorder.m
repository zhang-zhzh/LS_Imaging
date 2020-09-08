

Folder='I:\WholeBrainImaging\20171220_6.3x_YFP - Copy\Stack_7_TL\StitchedTiff_7\';
List=dir([Folder,'*tif']);

for i=1:length(List)
   FileName=[Folder,List(i).name];
   a=loadTifFast(FileName);
   b(:,i)=mean(a,2);
end
FinalMean=mean(b,2);
figure; plot(FinalMean)
find(diff(FinalMean)==max(diff(FinalMean)));









