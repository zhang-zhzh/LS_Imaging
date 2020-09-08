%%% This function is used to stitch images. It supports stitching multi
%%% colors, and stitching left images, right images or combine of the two
%%% sides. It also supports ComputeOverlap or not.
%%% Parameters: 
%%%                       Folder: Folder that saves all of the image files
%%%               StitchingColor: 1 Blue, 2 Red, 3 Yellow
%%%                StitchingSide: 1 Left, 2 Right, 3 combine two sides
%%%                      Overlap: Overlap between adjacent images. 
%%%               ComputeOverlap: 1 computeOverlap, 2 did not compute overlap
%%% Usage:
%%%          Stitching(Folder,[1 2 3],[1 2 3],0.31,0,0)

% Folder='D:\Project\Workplace\LightSheet\MaxProjection\'
% Overlap=34.58 %for 2x
% StitchingColor=[1]
% StitchingSide=[3];
% ComputeOverlap=1;
% StitchAccordingMaxProjection=1;
% StitchingMaxProjection(Folder,StitchingColor,StitchingSide,Overlap,ComputeOverlap)

function StitchingMaxProjection(Folder,StitchingColor,StitchingSide,Overlap,ComputeOverlap)

if ~exist('MIJ')
    Miji;
end

[FolderBase,fileName]=fileparts(Folder);
if fileName
    Folder=[Folder,'\'];
end

% find image prefix and image pattern
ListBlue=dir([Folder,'*Blue*tif']);
ListRed=dir([Folder,'*Red*tif']);
ListYellow=dir([Folder,'*Yellow*tif']);

if ~isempty(ListBlue)
    for i=1:length(ListBlue)
      pat='_';
      PatIndex=regexpi(ListBlue(i).name,pat);
      LastStr=ListBlue(i).name(PatIndex(4)+1:end);
      PatIndex(5)=regexpi(LastStr,'\.')+PatIndex(4);

      ImagePrefix{i}=ListBlue(i).name(1:PatIndex(1)-1);
      ImageStack{i}=ListBlue(i).name(PatIndex(1)+1:PatIndex(2)-1);
      ImageRow{i}=ListBlue(i).name(PatIndex(2)+1:PatIndex(3)-1);
      ImageColumn{i}=ListBlue(i).name(PatIndex(3)+1:PatIndex(4)-1);
      ImageDirection{i}=ListBlue(i).name(PatIndex(4)+1:PatIndex(5)-1);
      ImageSuffix{i}=ListBlue(i).name(PatIndex(5)+1:end);
    end
    PrefixBlue=unique(ImagePrefix);
    StackBlue=unique(ImageStack);
    RowBlue=length(unique(ImageRow));
    ColumnBlue=length(unique(ImageColumn));
    ImageDirectionBlue=unique(ImageDirection);
    SuffixBlue=unique(ImageSuffix);
elseif any(StitchingColor==1)
    display(['No blue images found! good luck!']);
    return;
end
clear Image*
if ~isempty(ListRed)
     for i=1:length(ListRed)
      pat='_';
      PatIndex=regexpi(ListRed(i).name,pat);
      LastStr=ListRed(i).name(PatIndex(4)+1:end);
      PatIndex(5)=regexpi(LastStr,'\.')+PatIndex(4);

      ImagePrefix{i}=ListRed(i).name(1:PatIndex(1)-1);
      ImageStack{i}=ListRed(i).name(PatIndex(1)+1:PatIndex(2)-1);
      ImageRow{i}=ListRed(i).name(PatIndex(2)+1:PatIndex(3)-1);
      ImageColumn{i}=ListRed(i).name(PatIndex(3)+1:PatIndex(4)-1);
      ImageDirection{i}=ListRed(i).name(PatIndex(4)+1:PatIndex(5)-1);
      ImageSuffix{i}=ListRed(i).name(PatIndex(5)+1:end);
    end
    PrefixRed=unique(ImagePrefix);
    StackRed=unique(ImageStack);
    RowRed=length(unique(ImageRow));
    ColumnRed=length(unique(ImageColumn));
    ImageDirectionRed=unique(ImageDirection);
    SuffixRed=unique(ImageSuffix);
elseif any(StitchingColor==2)
    display(['No red images found! good luck!']);
    return;
end

clear Image*
if ~isempty(ListYellow)
   for i=1:length(ListYellow)
      pat='_';
      PatIndex=regexpi(ListYellow(i).name,pat);
      LastStr=ListYellow(i).name(PatIndex(4)+1:end);
      PatIndex(5)=regexpi(LastStr,'\.')+PatIndex(4);

      ImagePrefix{i}=ListYellow(i).name(1:PatIndex(1)-1);
      ImageStack{i}=ListYellow(i).name(PatIndex(1)+1:PatIndex(2)-1);
      ImageRow{i}=ListYellow(i).name(PatIndex(2)+1:PatIndex(3)-1);
      ImageColumn{i}=ListYellow(i).name(PatIndex(3)+1:PatIndex(4)-1);
      ImageDirection{i}=ListYellow(i).name(PatIndex(4)+1:PatIndex(5)-1);
      ImageSuffix{i}=ListYellow(i).name(PatIndex(5)+1:end);
    end
    PrefixYellow=unique(ImagePrefix);
    StackYellow=unique(ImageStack);
    RowYellow=length(unique(ImageRow));
    ColumnYellow=length(unique(ImageColumn));
    ImageDirectionYellow=unique(ImageDirection);
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
        ImagePrefix=['ImageBlue'];
        Row=RowBlue;
        Column=ColumnBlue;
        Suffix=['.',SuffixBlue{1}];
    elseif Color==2
        Stack=StackYellow;
        ImagePrefix=['ImageRed'];
        Row=RowRed;
        Column=ColumnRed;
        Suffix=['.',SuffixRed{1}];
    elseif Color==3
        Stack=StackYellow;
        ImagePrefix=['ImageYellow'];
        Row=RowYellow;
        Column=ColumnYellow;
        Suffix=['.',SuffixYellow{1}];
    end
    for Side=StitchingSide
        if Side==1
            ImagePrefix=[ImagePrefix,'Left_'];
        elseif Side==2
            ImagePrefix=[ImagePrefix,'Right_'];
        elseif Side==3
            ImagePrefixLeft=[ImagePrefix,'Left_']; 
            ImagePrefixRight=[ImagePrefix,'Right_'];
            ImagePrefix=[ImagePrefix,'_']; 
        end
        % Start stitching images one by one
        for e=Stack
            e=e{1};
            if length(e)==0
                continue;
            end
            % change name
            if Side==3
                for j=1:Column
                    for k=1:Row/2
                        FullNameRight=[Folder, ImagePrefixRight,e,'_',num2str(k),'_',num2str(j),'_MaxProjection3',Suffix];
                        FullNameLeft=[Folder,ImagePrefixLeft,e,'_',num2str(k+Row/2),'_',num2str(j),'_MaxProjection3',Suffix];
                        ChangedNameRight=[Folder,ImagePrefix,e,'_',num2str(k),'_',num2str(j),'_MaxProjection3',Suffix];
                        ChangedNameLeft=[Folder,ImagePrefix,e,'_',num2str(k+Row/2),'_',num2str(j),'_MaxProjection3',Suffix];
                        if exist(ChangedNameLeft,'file')
%                            movefile(ChangedNameLeft,FullNameLeft);
                        else
                            movefile(FullNameLeft,ChangedNameLeft);
                        end
                        if exist(ChangedNameRight,'file')
%                            movefile(ChangedNameRight,FullNameRight);
                        else
                            movefile(FullNameRight,ChangedNameRight);
                        end
                    end
                end
            end
            ImagePatternNow=[ImagePrefix,e,'_','{y}','_','{x}','_MaxProjection3',Suffix];
            output_textfile_name=['TileConfiguration_Stack',e,'.txt'];
            disp(['Processing Image...    ', ImagePatternNow]);
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
                       ' output_textfile_name='...
                       output_textfile_name ...
                       ' fusion_method=[Linear Blending] '...
                       'regression_threshold=0.3 max/avg_displacement_threshold=2.50 absolute_displacement_threshold=3.50 '...
                       compute_overlap...
                       ' computation_parameters=[Save computation time (but use more RAM)] image_output=[Fuse and display]'];
             %'fusion_method=[Linear Blending] '... compute_overlap
             SaveName=[StitchedTiff,'\',ImagePrefix,e,'_Stitched.tif'];
             MIJ.run('Grid/Collection stitching', Commander)
             SaveCommander=['save=','[',SaveName,']'];
             SaveCommander=strrep(SaveCommander,'\','\\');
             MIJ.run('Save', SaveCommander);
             MIJ.run('Close')
             % rename    
             if Side==3
                for j=1:Column
                    %ImagePatternNow=[ImagePrefix,num2str(i),'_',num2str(e),'_','{y}','_','{x}','.tif','_denoised.tif'];        
                    for k=1:Row/2
                        FullNameRight=[Folder, ImagePrefixRight,e,'_',num2str(k),'_',num2str(j),'_MaxProjection3',Suffix];
                        FullNameLeft=[Folder,ImagePrefixLeft,e,'_',num2str(k+Row/2),'_',num2str(j),'_MaxProjection3',Suffix];
                        ChangedNameRight=[Folder,ImagePrefix,e,'_',num2str(k),'_',num2str(j),'_MaxProjection3',Suffix];
                        ChangedNameLeft=[Folder,ImagePrefix,e,'_',num2str(k+Row/2),'_',num2str(j),'_MaxProjection3',Suffix];
                        movefile(ChangedNameLeft,FullNameLeft);
                        movefile(ChangedNameRight,FullNameRight);
                    end
                end
             end
        end
        
    end
end

end

