function InputVolumn=LoadingToMaxProjection(Folder,Tag,StartStack,Overlap)


LoadDensity=1;
ImagesPerStack=50;
ColorSize=1;
ColorS=1;

DirectionAllName=[Folder '\DirectionAll.mat'];
ImageLastNumName=[Folder '\ImageLastNum.mat'];
RightOrWrongName=[Folder '\RightOrWrong.mat'];
PathPlanningName=[Folder '\Planning.mat'];
% CurrentColorAllName=[Folder '\CurrentColorAll.mat'];

load(DirectionAllName);
load(ImageLastNumName);
load(RightOrWrongName);
load(PathPlanningName);
% load(CurrentColorAllName);


MaxProjectedImagingMatrix=max(Planning.ImagingMatrixA,[],3);
[X,Y]=size(MaxProjectedImagingMatrix);


for i=1:X
    for j=1:Y
       IndexStackNow=find(Planning.PlannedPathA(:,1)==i & Planning.PlannedPathA(:,2)==j);
        if isempty(IndexStackNow)
            CreatName=[Folder,'\','ImagingMaxprojection_',num2str(i),'_',num2str(j),'.tif'];
            writeTifFast(CreatName,zeros(2048,2048),8);
            continue;
        end
        InT=find(RightOrWrong);
        SmallStackNow=InT((IndexStackNow-1)*ColorSize+1+ColorS-1);
        DirectionNow=DirectionAll(SmallStackNow); 
%         ColorNow=CurrentColorAll(SmallStackNow);
        FirstImageNow=ImageLastNumFinal(SmallStackNow)+1;
        
        NameNow=[Folder,'\','Image',num2str(Tag),'_',num2str(FirstImageNow),'.tif'];
        OriginalImage=loadTifFast(NameNow);
%         ImStack=[];
        for n=FirstImageNow:LoadDensity:FirstImageNow+ImagesPerStack-1
            try
                NameNow=[Folder,'\','Image',num2str(Tag),'_',num2str(n),'.tif'];
                CurrentImage=loadTifFast(NameNow);
                IndexB=CurrentImage>OriginalImage;
                OriginalImage(IndexB)=CurrentImage(IndexB);
%                 ImStack(:,:,n-FirstImageNow+1)=CurrentImage;
            catch
                break;
            end
        end
        
%         OriginalImage=max(ImStack,[],3);
        CreatName=[Folder,'\','ImagingMaxprojection_',num2str(i),'_',num2str(j),'.tif'];
        writeTifFast(CreatName,OriginalImage,16);
    end 
end
clear OriginalImage;
% StitchImages

StitchedTiff=[Folder,'\StichImaging\'];
mkdir(StitchedTiff);
ImagePrefix='ImagingMaxprojection';
Suffix='.tif';
ImagePatternNow=[ImagePrefix,'_','{y}','_','{x}',Suffix];
disp(['Processing Image...    ', ImagePatternNow]);
compute_overlap=0;

Commander=['Grid/Collection stitching '...
           'type=[Filename defined position] order=[Defined by filename         ] '...
           'grid_size_x='...
           num2str(Y)...
           ' grid_size_y='...
           num2str(X)...
           ' tile_overlap='...
           num2str(Overlap)...
           ' first_file_index_x=1 first_file_index_y=1 '...
           'directory=['...
           Folder...
           '] '...
           'file_names='...
           ImagePatternNow ...
           ' output_textfile_name=TileConfiguration.txt '...
           'fusion_method=[Linear Blending] '...
           'regression_threshold=0.3 max/avg_displacement_threshold=2.50 absolute_displacement_threshold=3.50 '...
           compute_overlap...
           ' computation_parameters=[Save computation time (but use more RAM)] image_output=[Fuse and display]'];
 %'fusion_method=[Linear Blending] '... compute_overlap
 SaveName=[StitchedTiff,'\',ImagePrefix,'_Stitched.tif'];
 MIJ.run('Grid/Collection stitching', Commander);
 SaveCommander=['save=','[',SaveName,']'];
 SaveCommander=strrep(SaveCommander,'\','\\');
%      MIJ.run('Subtract Background...', 'rolling=100');
 MIJ.run('Save', SaveCommander);
 MIJ.run('Close');

 % load images
 InputVolumn=loadTifFast(SaveName);


end