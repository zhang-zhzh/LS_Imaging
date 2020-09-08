% Suppose imaging matrix was 2x2 with a order from the topleft, topright,
% downright, downleft

function InputVolumn =LoadImages_4xN_FromMemory(SaveFolder,OverLapLowMag,ImagesPerStackPlanning,ReferenceName,Overlap,ImAll)
%    LastImageNum=DetectLastImageNum(SaveFolder);
   
   
   Overlap=Overlap*100;
   
   for i=1:4
       CI=ImAll{1};
       Im(5-i)=max(CI,[],3);
   end
   % writeTifFast
   SaveNameDownLeft=[SaveFolder '\ImageLowPlanning_2_1.tif'];
   SaveNameDownRight=[SaveFolder '\ImageLowPlanning_2_2.tif'];
   SaveNameTopRight=[SaveFolder '\ImageLowPlanning_1_2.tif'];
   SaveNameTopLeft=[SaveFolder '\ImageLowPlanning_1_1.tif'];
   
   writeTifFast(SaveNameDownLeft,Im(:,:,1),16);
   writeTifFast(SaveNameDownRight,Im(:,:,2),16);
   writeTifFast(SaveNameTopRight,Im(:,:,3),16);
   writeTifFast(SaveNameTopLeft,Im(:,:,4),16);
   
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
               num2str(2)...
               ' grid_size_y='...
               num2str(2)...
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
     MIJ.run('Grid/Collection stitching', Commander)
     SaveCommander=['save=','[',SaveName,']'];
     SaveCommander=strrep(SaveCommander,'\','\\');
     MIJ.run('Save', SaveCommander);
     MIJ.run('Close')
   
     
     % load images
     InputVolumn=loadTifFast(SaveName);
     
   
   
   
   
   
   
   
   
   
end
