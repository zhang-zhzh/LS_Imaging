% This function was used to adjust the brightness of left/right images to
% the same level. First, it will randomly choose some reference images.
% Second, mask the images. Third, find the average brightness. Finally,
% to change the brightness. 

% Images for different stacks were seperately computed. 



function ChangeLeftRightBrightness(Folder)


ChoseSections=10; % how many sections used to compute average. 
%Mask image parameters
fudgeFactor=0.1;
DilateThick=20;
RemovePixelSize=100000;
Clearborder=0;
CutoffLow=1000; % for mask image
CutoffHigh=50000;
%ChangeDirection,
ChangeDirection=1; % 1 change the intensity of images with higher average intensity. 0 change the intensity of images with lower average intensity. 


SaveFolder=[Folder,'\ChangeBrightness\'];
mkdir(SaveFolder);


 
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
Color=[0 0 0];


if ~isempty(ListBlueLeft) | ~isempty(ListBlueRight)
    Color(1)=1;
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
end
 


clear Image*
if ~isempty(ListRedLeft) | ~isempty(ListRedRight)
    Color(2)=1;
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
end

clear Image*
if ~isempty(ListYellowLeft) | ~isempty(ListYellowRight)
    Color(3)=1;
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
end
clear Image*





for i=1:3
    if Color(i)==1
        if i==1
            Stack=StackBlue;
            Section=SectionBlue;
            PrefixLeft='ImageBlueLeft';
            PrefixRight='ImageBlueRight';
        elseif i==2
            Stack=StackRed;
            Section=SectionRed;
            PrefixLeft='ImageRedLeft';
            PrefixRight='ImageRedRight';
        elseif i==3
            Stack=StackYellow;
            Section=SectionYellow;
            PrefixLeft='ImageYellowLeft';
            PrefixRight='ImageYellowRight';
        end
        if ChoseSections<length(Section)
            ChosedSections=randsample(Section,ChoseSections);
        else
            ChosedSections=randsample(Section,length(Section));
        end
        for sta=Stack
            MeanLeft=[];
            MeanRight=[];
            for sec=ChosedSections
                % find averagebrightness seperately for left and right images
                SubFolderNameLeft=dir([Folder,'\',PrefixLeft,'_',sta{1},'_',sec{1},'*tif']);
                SubFolderNameRight=dir([Folder,'\',PrefixRight,'_',sta{1},'_',sec{1},'*tif']);
                if length(SubFolderNameLeft)==0 | length(SubFolderNameRight)==0
                    warning('Could not find corresponding reference left/right images');
                    return;
                end
                for k=1:2
                    if k==1
                        SubFolderName=SubFolderNameLeft;
                    else
                        SubFolderName=SubFolderNameRight;
                    end
                    for kk=1:length(SubFolderName)
                           CurrentImageName=[Folder,SubFolderName(kk).name];
                           CurrentImage=loadTifFast(CurrentImageName);
                           %mask image
                           Mask=EdgeDetection(CurrentImage,fudgeFactor,DilateThick,RemovePixelSize,Clearborder,CutoffLow);
                           CurrentImage(CurrentImage>CutoffHigh)=0;
                           CurrentImage=double(CurrentImage).*double(Mask);
                           MeanNow=FindMean(CurrentImage);
                           if k==1
                               MeanLeft=[MeanLeft MeanNow];
                           else
                               MeanRight=[MeanRight MeanNow];
                           end
                    end
                end
            end
            % change brightness of each stack according to the average
            % intensity. 
            ReferenceMeanLeft=mean(MeanLeft(~isnan(MeanLeft)));
            ReferenceMeanRight=mean(MeanRight(~isnan(MeanRight)));
            if ChangeDirection==1
                if ReferenceMeanLeft>ReferenceMeanRight
                    ReferenceMean=ReferenceMeanRight;
                    ImagesTheStack=dir([Folder,'\',PrefixLeft,'_',sta{1},'*tif']);
                elseif ReferenceMeanLeft<ReferenceMeanRight
                    ReferenceMean=ReferenceMeanLeft;
                    ImagesTheStack=dir([Folder,'\',PrefixRight,'_',sta{1},'*tif']);
                else
                    display('The reference means of left and right are equal!')
                end
                
            else 
                if ReferenceMeanLeft>ReferenceMeanRight
                    ReferenceMean=ReferenceMeanLeft;
                    ImagesTheStack=dir([Folder,'\',PrefixRight,'_',Sta{1},'*tif']);
                elseif ReferenceMeanLeft<ReferenceMeanRight
                    ReferenceMean=ReferenceMeanRight;
                    ImagesTheStack=dir([Folder,'\',PrefixLeft,'_',Sta{1},'*tif']);
                else
                    display('The reference means of left and right are equal!')
                end
            end
            
            for kkk=1:length(ImagesTheStack)
                ImageName=[Folder,ImagesTheStack(kkk).name];
                ImageNameI=loadTifFast(ImageName);
                MeanNow=FindMean(ImageNameI);
                ImageNameI=double(ImageNameI)*double(ReferenceMean/MeanNow);
                SaveName=[SaveFolder,ImagesTheStack(kkk).name];
                writeTifFast(SaveName,ImageNameI,16);
            end
        end
    end
end









end