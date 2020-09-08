% This function was used to perform max projection. 
% Usage:
%        MaxProjection(Folder,Direction)
%        Folder: folder that stores files produced by GUIV3 and file names have been changed by DecodingImagingIndex. 
%     Direction: projection direction. 1,X; 2,Y; 3,Z.

% Folder='I:\WholeBrainImaging\20170906_4x_YFP\Stack_1Copy\'
% Direction=[1 2 3]
% MaxProjection(Folder,Direction)

% Folder='H:\20170811_YFP_CUBIC_X_BF\Stack_6\StitchedTiff\';
% Direction=[1 2 3];


function MaxProjection(Folder,Direction)
[FolderBase,fileName]=fileparts(Folder);
if fileName
    Folder=[Folder,'\'];
end
SaveFolder=[Folder,'\MaxProjection\'];
mkdir(SaveFolder);
% find image prefix and image pattern
ListBlue=dir([Folder,'*Blue*tif']);
ListRed=dir([Folder,'*Red*tif']);
ListYellow=dir([Folder,'*Yellow*tif']);

if ~isempty(ListBlue)
    for i=1:length(ListBlue)
      pat='_';
      PatIndex=regexpi(ListBlue(i).name,pat);
      if ~isempty(str2num(ListBlue(i).name(PatIndex(4)+2)))
          PatIndex(5)=PatIndex(4)+3;
      else
          PatIndex(5)=PatIndex(4)+2;
      end
      ImagePrefix{i}=ListBlue(i).name(1:PatIndex(1)-1);
      ImageStack{i}=ListBlue(i).name(PatIndex(1)+1:PatIndex(2)-1);
      ImageSection{i}=ListBlue(i).name(PatIndex(2)+1:PatIndex(3)-1);
      ImageRow{i}=ListBlue(i).name(PatIndex(3)+1:PatIndex(4)-1);
      ImageColumn{i}=ListBlue(i).name(PatIndex(4)+1:PatIndex(5)-1);
      ImageSuffix{i}=ListBlue(i).name(PatIndex(5)+1:end);
    end
    PrefixBlue=unique(ImagePrefix);
    StackBlue=unique(ImageStack);
    SectionBlue=unique(ImageSection);
    RowBlue=length(unique(ImageRow));
    ColumnBlue=length(unique(ImageColumn));
    SuffixBlue=unique(ImageSuffix);
    ProjectionPrepare_(Folder,SaveFolder,PrefixBlue,StackBlue,RowBlue,ColumnBlue,SuffixBlue,Direction);
end

clear Image*
if ~isempty(ListRed)
    for i=1:length(ListRed)
      pat='_';
      PatIndex=regexpi(ListRed(i).name,pat);
      if ~isempty(str2num(ListRed(i).name(PatIndex(4)+2)))
          PatIndex(5)=PatIndex(4)+3;
      else
          PatIndex(5)=PatIndex(4)+2;
      end
      ImagePrefix{i}=ListRed(i).name(1:PatIndex(1)-1);
      ImageStack{i}=ListRed(i).name(PatIndex(1)+1:PatIndex(2)-1);
      ImageSection{i}=ListRed(i).name(PatIndex(2)+1:PatIndex(3)-1);
      ImageRow{i}=ListRed(i).name(PatIndex(3)+1:PatIndex(4)-1);
      ImageColumn{i}=ListRed(i).name(PatIndex(4)+1:PatIndex(5)-1);
      ImageSuffix{i}=ListRed(i).name(PatIndex(5)+1:end);
    end
    PrefixRed=unique(ImagePrefix);
    StackRed=unique(ImageStack);
    SectionRed=unique(ImageSection);
    RowRed=length(unique(ImageRow));
    ColumnRed=length(unique(ImageColumn));
    SuffixRed=unique(ImageSuffix);
    ProjectionPrepare_(Folder,SaveFolder,PrefixRed,StackRed,RowRed,ColumnRed,SuffixRed,Direction);
end

clear Image*
if ~isempty(ListYellow)
    for i=1:length(ListYellow)
      pat='_';
      PatIndex=regexpi(ListYellow(i).name,pat);
      if ~isempty(str2num(ListYellow(i).name(PatIndex(4)+2)))
          PatIndex(5)=PatIndex(4)+3;
      else
          PatIndex(5)=PatIndex(4)+2;
      end
      ImagePrefix{i}=ListYellow(i).name(1:PatIndex(1)-1);
      ImageStack{i}=ListYellow(i).name(PatIndex(1)+1:PatIndex(2)-1);
      ImageSection{i}=ListYellow(i).name(PatIndex(2)+1:PatIndex(3)-1);
      ImageRow{i}=ListYellow(i).name(PatIndex(3)+1:PatIndex(4)-1);
      ImageColumn{i}=ListYellow(i).name(PatIndex(4)+1:PatIndex(5)-1);
      ImageSuffix{i}=ListYellow(i).name(PatIndex(5)+1:end);
    end
    PrefixYellow=unique(ImagePrefix);
    StackYellow=unique(ImageStack);
    SectionYellow=unique(ImageSection);
    RowYellow=length(unique(ImageRow));
    ColumnYellow=length(unique(ImageColumn));
    SuffixYellow=unique(ImageSuffix);
    ProjectionPrepare_(Folder,SaveFolder,PrefixYellow,StackYellow,RowYellow,ColumnYellow,SuffixYellow,Direction);
end
clear Image*
end



function ProjectionPrepare_(Folder,SaveFolder,Prefix,Stack,Row,Column,Suffix,Direction)


for p=Prefix
    for s=Stack
        for r=1:Row
            for c=1:Column
                Pattern=[Folder,p{1},'_',s{1},'_*_',num2str(r),'_',num2str(c),'.',Suffix{1}];
                SaveName1=[SaveFolder,p{1},'_',s{1},'_',num2str(r),'_',num2str(c),'_MaxProjection',num2str(1),'.',Suffix{1}];
                SaveName2=[SaveFolder,p{1},'_',s{1},'_',num2str(r),'_',num2str(c),'_MaxProjection',num2str(2),'.',Suffix{1}];
                SaveName3=[SaveFolder,p{1},'_',s{1},'_',num2str(r),'_',num2str(c),'_MaxProjection',num2str(3),'.',Suffix{1}];
                Projection(Pattern,SaveName1,SaveName2,SaveName3,Direction);
            end
        end
    end
end

end

function  Projection(Pattern,SaveName1,SaveName2,SaveName3,Direction)
    Folder=fileparts(Pattern);
    List=dir(Pattern);
    FinalImage3=zeros(2048,2048);
    for i=1:length(List)
        ImageNow=loadTifFast([Folder,'\',List(i).name]);
        if any(Direction==1)
            FinalImage1(i,:)=max(ImageNow,[],1);
        end
        if any(Direction==2)
            FinalImage2(i,:)=max(ImageNow,[],2);
        end
        if any(Direction==3)
            A(:,:,1)=FinalImage3;
            A(:,:,2)=ImageNow;
            FinalImage3 = max(A,[], 3);
        end
    end
    if length(List)>0
        if any(Direction==1)
            writeTifFast(SaveName1,FinalImage1,16);
        end
        if any(Direction==2)
            writeTifFast(SaveName2,FinalImage2,16);
        end
        if any(Direction==3)
            writeTifFast(SaveName3,FinalImage3,16);
        end
    end
end


