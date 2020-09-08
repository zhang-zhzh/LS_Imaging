%%% This function is used to stitch images. It supports stitching multi
%%% colors, and stitching left images, right images or combine of the two
%%% sides. It also supports ComputeOverlap or not.
%%% Parameters: 
%%%                       Folder: Folder that saves all of the image files
%%%               StitchingColor: 1 Blue, 2 Red, 3 Yellow
%%%                StitchingSide: 1 Left, 2 Right, 3 combine two sides
%%%                      Overlap: Overlap between adjacent images. 
%%%               ComputeOverlap: 1 computeOverlap, 2 did not compute overlap
%%% StitchAccordingMaxProjection: 1, stitching based on max projection results. 0, not. 
%%%      StitchingConfiureFolder: Folder that store the max projection stitching results.
%%%                   ImagingRow: [LeftImaging RightImaging]
%%% Usage:
%%%          Stitching(Folder,[1 2 3],[1 2 3],0.31,0,0)

% Folder='I:\WholeBrainImaging\20170906_4x_YFP\Stack_1 - Copy\'
% Overlap=34.58 %for 2x
% StitchingColor=[1]
% StitchingSide=[3];
% ComputeOverlap=0;
% StitchAccordingMaxProjection=1;
% StitchingConfiureFolder='';
% StitchingForGUIV3(Folder,StitchingColor,StitchingSide,Overlap,ComputeOverlap)

function StitchingForGUIV3_v3_4x(Folder,StitchingColor,StitchingSide,Overlap,ComputeOverlap,StitchAccordingMaxProjection,StitchingConfiureFolder,ImagingRow)

if ~exist('MIJ')
    Miji;
end

[FolderBase,fileName]=fileparts(Folder);
if fileName
    Folder=[Folder,'\'];
end

% find image prefix and image pattern
ListBlueLeft=dir([Folder,'*BlueLeft*tif']);
ListBlueRight=dir([Folder,'*BlueRight*tif']);
ListRedLeft=dir([Folder,'*RedLeft*tif']);
ListRedRight=dir([Folder,'*RedRight*tif']);
ListYellowLeft=dir([Folder,'*YellowLeft*tif']);
ListYellowRight=dir([Folder,'*YellowRight*tif']);

if ~isempty(ListBlueLeft) | ~isempty(ListBlueRight)
    for k=1:(length(ListBlueLeft)+length(ListBlueRight))
      if k>length(ListBlueLeft)
          ListBlue=ListBlueRight;
          i=k-length(ListBlueLeft);
      else
          ListBlue=ListBlueLeft;
          i=k;
      end
      
      pat='_';
      PatIndex=regexpi(ListBlue(i).name,pat);
      if ~isempty(str2num(ListBlue(i).name(PatIndex(4)+2)))
          PatIndex(5)=PatIndex(4)+3;
      else
          PatIndex(5)=PatIndex(4)+2;
      end
      ImagePrefix{k}=ListBlue(i).name(1:PatIndex(1)-1);
      ImageStack{k}=ListBlue(i).name(PatIndex(1)+1:PatIndex(2)-1);
      ImageSection{k}=ListBlue(i).name(PatIndex(2)+1:PatIndex(3)-1);
      ImageRow{k}=ListBlue(i).name(PatIndex(3)+1:PatIndex(4)-1);
      ImageColumn{k}=ListBlue(i).name(PatIndex(4)+1:PatIndex(5)-1);
      ImageSuffix{k}=ListBlue(i).name(PatIndex(5)+1:end);
    end
    PrefixBlue=unique(ImagePrefix);
    StackBlue=unique(ImageStack);
    SectionBlue=unique(ImageSection);
    RowBlue=length(unique(ImageRow));
    ColumnBlue=length(unique(ImageColumn));
    SuffixBlue=unique(ImageSuffix);
elseif any(StitchingColor==1)
    display(['No blue images found! good luck!']);
    return;
end
clear Image*
if ~isempty(ListRedLeft) | ~isempty(ListRedRight)
    for k=1:length(ListRedLeft)+length(ListRedRight)
      if k>length(ListRedLeft)
          ListRed=ListRedRight;
          i=k-length(ListRedLeft);
      else
          ListRed=ListRedLeft;
          i=k;
      end
      pat='_';
      PatIndex=regexpi(ListRed(i).name,pat);
      if ~isempty(str2num(ListRed(i).name(PatIndex(4)+2)))
          PatIndex(5)=PatIndex(4)+3;
      else
          PatIndex(5)=PatIndex(4)+2;
      end
      ImagePrefix{k}=ListRed(i).name(1:PatIndex(1)-1);
      ImageStack{k}=ListRed(i).name(PatIndex(1)+1:PatIndex(2)-1);
      ImageSection{k}=ListRed(i).name(PatIndex(2)+1:PatIndex(3)-1);
      ImageRow{k}=ListRed(i).name(PatIndex(3)+1:PatIndex(4)-1);
      ImageColumn{k}=ListRed(i).name(PatIndex(4)+1:PatIndex(5)-1);
      ImageSuffix{k}=ListRed(i).name(PatIndex(5)+1:end);
    end
    PrefixRed=unique(ImagePrefix);
    StackRed=unique(ImageStack);
    SectionRed=unique(ImageSection);
    RowRed=length(unique(ImageRow));
    ColumnRed=length(unique(ImageColumn));
    SuffixRed=unique(ImageSuffix);
elseif any(StitchingColor==2)
    display(['No red images found! good luck!']);
    return;
end

LeftImaging=ImagingRow(1);
RightImaging=ImagingRow(2);
clear Image*
if ~isempty(ListYellowLeft) | ~isempty(ListYellowRight)
    for k=1:(length(ListYellowLeft)+length(ListYellowRight))
      if k>length(ListYellowLeft)
          ListYellow=ListYellowRight;
          i=k-length(ListYellowLeft);
      else
          ListYellow=ListYellowLeft;
          i=k;
      end
      pat='_';
      PatIndex=regexpi(ListYellow(i).name,pat);
      if ~isempty(str2num(ListYellow(i).name(PatIndex(4)+2)))
          PatIndex(5)=PatIndex(4)+3;
      else
          PatIndex(5)=PatIndex(4)+2;
      end
      ImagePrefix{k}=ListYellow(i).name(1:PatIndex(1)-1);
      ImageStack{k}=ListYellow(i).name(PatIndex(1)+1:PatIndex(2)-1);
      ImageSection{k}=ListYellow(i).name(PatIndex(2)+1:PatIndex(3)-1);
      ImageRow{k}=ListYellow(i).name(PatIndex(3)+1:PatIndex(4)-1);
      ImageColumn{k}=ListYellow(i).name(PatIndex(4)+1:PatIndex(5)-1);
      ImageSuffix{k}=ListYellow(i).name(PatIndex(5)+1:end);
    end
    PrefixYellow=unique(ImagePrefix);
    StackYellow=unique(ImageStack);
    SectionYellow=unique(ImageSection);
    RowYellow=length(unique(ImageRow));
    ColumnYellow=length(unique(ImageColumn));
    SuffixYellow=unique(ImageSuffix);
elseif any(StitchingColor==3)
    display(['No yellow images found! good luck!']);
    return;
end
clear Image*



if  ComputeOverlap==1
    compute_overlap='compute_overlap';
else 
    compute_overlap='';
end


StitchedTiff=[Folder,'\StitchedTiff\'];
mkdir(StitchedTiff);
for Color=StitchingColor
    if Color==1
        Stack=StackBlue;
        Sections=SectionBlue;
        ImagePrefix=['ImageBlue'];
        Row=RowBlue;
        Column=ColumnBlue;
        Suffix=['.',SuffixBlue{1}];
    elseif Color==2
        Stack=StackRed;
        Sections=SectionRed;
        ImagePrefix=['ImageRed'];
        Row=RowRed;
        Column=ColumnRed;
        Suffix=['.',SuffixRed{1}];
    elseif Color==3
        Stack=StackYellow;
        Sections=SectionYellow;
        ImagePrefix=['ImageYellow'];
        Row=RowYellow;
        Column=ColumnYellow;
        Suffix=['.',SuffixYellow{1}];
    end
    for Side=StitchingSide
        if Side==1
            ImagePrefix=[ImagePrefix,'Left4x_'];
        elseif Side==2
            ImagePrefix=[ImagePrefix,'Right4x_'];
        elseif Side==3
            ImagePrefixLeft=[ImagePrefix,'Left4x_']; 
            ImagePrefixRight=[ImagePrefix,'Right4x_'];
            ImagePrefix=[ImagePrefix,'_']; 
        end
        % Start stitching images one by one
        for i=1:length(Sections)
            SectionNow=str2num(Sections{i});
            for e=Stack
                e=e{1};
                if length(e)==0
                    continue;
                end
                % change name
                if Side==3
                    for j=1:Column
                        for k=1:Row
                          if k<=RightImaging
                                FullNameRight=[Folder, ImagePrefixRight,e,'_', num2str(SectionNow),'_',num2str(k),'_',num2str(j),Suffix];
                                ChangedNameRight=[Folder,ImagePrefix,e,'_',num2str(SectionNow),'_',num2str(k),'_',num2str(j),Suffix];
                                MaxProjectionNameRight=[Folder,ImagePrefix,e,'_',num2str(k),'_',num2str(j),'_MaxProjection3.tif'];
                                if exist(ChangedNameRight,'file')
    %                                movefile(ChangedNameRight,FullNameRight);
                                elseif exist(MaxProjectionNameRight,'file')
                                    movefile(MaxProjectionNameRight,ChangedNameRight);
                                else
                                    movefile(FullNameRight,ChangedNameRight);
                                end
                           elseif k>RightImaging & k<=RightImaging+LeftImaging
                                FullNameLeft=[Folder,ImagePrefixLeft,e,'_',num2str(SectionNow),'_',num2str(k),'_',num2str(j),Suffix];
                                ChangedNameLeft=[Folder,ImagePrefix,e,'_',num2str(SectionNow),'_',num2str(k),'_',num2str(j),Suffix];
                                MaxProjectionNameLeft=[Folder,ImagePrefix,e,'_',num2str(k),'_',num2str(j),'_MaxProjection3.tif'];
                                if exist(ChangedNameLeft,'file')
    %                                movefile(ChangedNameLeft,FullNameLeft);
                                elseif exist(MaxProjectionNameLeft,'file')
                                   movefile(MaxProjectionNameLeft,ChangedNameLeft);
                                else
                                   movefile(FullNameLeft,ChangedNameLeft);
                                end
                          end
                          
                        end
                    end
                end
                ImagePatternNow=[ImagePrefix,e,'_',num2str(SectionNow),'_','{y}','_','{x}',Suffix];
                disp(['Processing Image...    ', ImagePatternNow]);
                
                if StitchAccordingMaxProjection==1
                    ChangeToMaxProjectionName_(Folder,ImagePrefix,e,SectionNow,Row,Column,Suffix,1);
                    ConfigureName=['TileConfiguration_Stack',num2str(e),'.registered.txt'];
                    ConfigureFile=[StitchingConfiureFolder,'\',ConfigureName];
                    copyfile(ConfigureFile,[Folder,'\',ConfigureName]);
                    
                    Commander=['Grid/Collection stitching '...
                               'type=[Positions from file] order=[Defined by TileConfiguration] '...
                               'directory=['...
                               Folder...
                               '] '...
                               'layout_file=['...
                               ConfigureName...
                               '] '...
                               ' fusion_method=[Linear Blending]  '...
                               ' regression_threshold=0.3 max/avg_displacement_threshold=2.50 absolute_displacement_threshold=3.50 '...
                               compute_overlap...
                               ' computation_parameters=[Save computation time (but use more RAM)] image_output=[Fuse and display]'];
                    else          
%                 FolderFuse=strrep(Folder,'\','\\');
                    Commander=['Grid/Collection stitching '...
                               'type=[Filename defined position] order=[Defined by filename         ] '...
                               'grid_size_x='...
                               num2str(Column)...
                               ' grid_size_y='...
                               num2str(Row)...
                               ' tile_overlap='...
                               num2str(Overlap)...
                               ' first_file_index_x=1 first_file_index_y=1 '...
                               'directory=['...
                               Folder...
                               '] '...
                               'file_names='...
                               ImagePatternNow ...
                               ' output_textfile_name=TileConfiguration.txt '...
                               'fusion_method=[Linear Blending]  '...
                               'regression_threshold=0.3 max/avg_displacement_threshold=2.50 absolute_displacement_threshold=3.50 '...
                               compute_overlap...
                               ' computation_parameters=[Save computation time (but use more RAM)] image_output=[Fuse and display]'];
                     %'fusion_method=[Max. Intensity] '... compute_overlap
                 end
                 SaveName=[StitchedTiff,'\',ImagePrefix,num2str(e),'_',num2str(SectionNow),'_Stitched.tif'];
                 MIJ.run('Grid/Collection stitching', Commander)
                 SaveCommander=['save=','[',SaveName,']'];
                 SaveCommander=strrep(SaveCommander,'\','\\');
                 MIJ.run('Save', SaveCommander);
                 MIJ.run('Close')
                 % rename
                 if StitchAccordingMaxProjection==1
                    ChangeToMaxProjectionName_(Folder,ImagePrefix,e,SectionNow,Row,Column,Suffix,0);
                end
                 
                 if Side==3
                    for j=1:Column
                        %ImagePatternNow=[ImagePrefix,num2str(i),'_',num2str(e),'_','{y}','_','{x}','.tif','_denoised.tif'];        
                        for k=1:Row
                            if k<=RightImaging
                                FullNameRight=[Folder,ImagePrefixRight,e,'_',num2str(SectionNow),'_',num2str(k),'_',num2str(j),Suffix];
                                ChangedNameRight=[Folder,ImagePrefix,e,'_',num2str(SectionNow),'_',num2str(k),'_',num2str(j),Suffix];
                                movefile(ChangedNameRight,FullNameRight);
                            elseif k>RightImaging & k<=RightImaging+LeftImaging
                                FullNameLeft=[Folder,ImagePrefixLeft,e,'_',num2str(SectionNow),'_',num2str(k),'_',num2str(j),Suffix];
                                ChangedNameLeft=[Folder,ImagePrefix,e,'_',num2str(SectionNow),'_',num2str(k),'_',num2str(j),Suffix];
                                movefile(ChangedNameLeft,FullNameLeft);
                            end
                        end
                    end
                 end
            end

        end
        
    end
end

end



function ChangeToMaxProjectionName_(Folder,ImagePrefix,e,SectionNow,Row,Column,Suffix,Direction)
   %Direction 1: to maxprojection name
   %Direction 0: to original name
   for i=1:Row
       for j=1:Column
          if  Direction==1
              OriName=[Folder,ImagePrefix,e,'_',num2str(SectionNow),'_',num2str(i),'_',num2str(j),Suffix];
              DesName=[Folder,ImagePrefix,e,'_',num2str(i),'_',num2str(j),'_MaxProjection3.tif'];
          elseif Direction==0
              DesName=[Folder,ImagePrefix,e,'_',num2str(SectionNow),'_',num2str(i),'_',num2str(j),Suffix];
              OriName=[Folder,ImagePrefix,e,'_',num2str(i),'_',num2str(j),'_MaxProjection3.tif'];
          else
              warning('Undefined Direction in  ChangeToMaxProjectionName_!');
              return;
          end
          if exist(DesName,'file')
          else
              movefile(OriName,DesName);
          end
       end       
   end
end
