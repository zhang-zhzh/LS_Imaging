% Suppose imaging matrix was 2x2 with a order from the topleft, topright,
% downright, downleft

function InputVolumn =LoadImagesX(SaveFolder,OverLapLowMag,ImagesPerStackPlanning,ReferenceName,Overlap,GridSize)
%    LastImageNum=DetectLastImageNum(SaveFolder);
   DeltaLoad=1;
   GridX=GridSize(1);
   GridY=GridSize(2);
   Overlap=Overlap*100;
   
   load([SaveFolder,'ImageLastNumPlanning.mat']);
   load([SaveFolder,'DirectionAllPlanning.mat']);
   
 DiGX=1;
 CurrentIndex=0;
 for GX=1:GridX
    if DiGX==1
        GYS=1;
        GYE=GridY;
        DeD=1;
    else
        GYS=GridY;
        GYE=1;
        DeD=-1;
    end
    DiGX=DiGX*-1;
    for GY=GYS:DeD:GYE
        CurrentIndex=CurrentIndex+1;
        ImageStartN=ImageNumAfterAStackPlanning(CurrentIndex)+1;
        ImageEndN=ImageNumAfterAStackPlanning(CurrentIndex+1);

        OriginalImage=loadTifFast([SaveFolder 'Image1_' num2str(ImageStartN) '.tif']);
        for j=ImageStartN+1:DeltaLoad:ImageEndN
               ImageName=[SaveFolder 'Image1_' num2str(j) '.tif'];
               CurrentImage=loadTifFast(ImageName);
               IndexB=CurrentImage>OriginalImage;
               OriginalImage(IndexB)=CurrentImage(IndexB);
         end
         SaveNameNow=[SaveFolder '\ImageLowPlanning_' num2str(GX) '_' num2str(GY) '.tif'];
         writeTifFast(SaveNameNow,OriginalImage,16);
    end
 end
 
 
   
   % stitch
   StitchedTiff=[SaveFolder,'\StichPlanning\'];
   mkdir(StitchedTiff);
   ImagePrefix='ImageLowPlanning';
   Suffix='.tif';
   ImagePatternNow=[ImagePrefix,'_','{y}','_','{x}',Suffix];
   disp(['Processing Image...    ', ImagePatternNow]);
   compute_overlap=0;
   
   Commander=['Grid/Collection stitching '...
               'type=[Filename defined position] order=[Defined by filename         ] '...
               'grid_size_x='...
               num2str(GridY)...
               ' grid_size_y='...
               num2str(GridX)...
               ' tile_overlap='...
               num2str(Overlap)...
               ' first_file_index_x=1 first_file_index_y=1 '...
               'directory=['...
               SaveFolder...
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
