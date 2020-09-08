% This function was used to decode the image index for imaging along Z
% axis. 
% Usage: DecodingImagingIndex(Stacks,AnimalName.cfg)
%           Folder: Folder that saves the images.
%              Tag: Tag to decode, e.g. [1 2 3]. These stacks must be continuous stacks( Imaging without breaking). 
%       StartStack: Start image stack
%             *cfg: Configure file produced by ImagingV.
%             Move: 1 Move file. 0 Not move file.
% The changed name format is ImageColor_Stack_Slice_j_i.tif


% Folder='M:\ProjectsData\LightSheetRelated\ImageData\Stack_2\';
% Tag=1;
% ConfigureName='M:\ProjectsData\LightSheetRelated\ImageData\Stack_2\AnimalName\Configure_6.cfg';
% StartStack=1;
% Move=1;
% [OriginalName,MovedName]=DecodingImagingIndex(Folder,Tag,StartStack,ConfigureName,Move)
function [OriginalName,MovedName]=DecodingImagingIndexContinous_PathPlanning(Folder,Tag,StartStack,ConfigureName,Move,MaxProjectedImagingMatrix)

% declare/ default
% 1) When there are multi-channels, imaging order is blue, red, and yellow.
P=file2struct(ConfigureName);
DirectionAllName=[Folder '\DirectionAll.mat'];
ImageLastNumName=[Folder '\ImageLastNum.mat'];
RightOrWrongName=[Folder '\RightOrWrong.mat'];
PathPlanningName=[Folder '\Planning.mat'];
load(DirectionAllName);
load(ImageLastNumName);
load(RightOrWrongName);
load(PathPlanningName);


ImagesPerStack=200;  %P.Zcut/P.ZstepGratingRule; % step decided by the grating rule
BlueImaging=P.BlueImaging;
RedImaging=P.RedImaging;
YellowImaging=P.YellowImaging;
LeftImaging=P.LeftImaging;
RightImaging=P.RightImaging;
Xcycle=size(Planning.ImagingMatrixA,2);
Ycycle=size(Planning.ImagingMatrixA,1);
Stack=StartStack;

if ~exist('MaxProjectedImagingMatrix')
    MaxProjectedImagingMatrix=max(Planning.ImagingMatrixA,[],3);
else
    MaxProjectedImagingMatrix=max(MaxProjectedImagingMatrix,[],3);
end

[Row,Col]=find(MaxProjectedImagingMatrix);
MaxJ=max(Row);
MinJ=min(Row);
MaxI=max(Col);
MinI=min(Col);

if MinI==MaxI
    ISeries=MinI;
    MinI=0;
else
    ISeries=1:MaxI-MinI+1;
end

if MinJ==MaxJ
    JSeries=MinJ;
    MinJ=0;
else
    JSeries=1:MaxJ-MinJ+1;
end

s=Tag;
VitualImageName={};
for z=1:size(Planning.ImagingMatrixA,3)
    for j=JSeries
        for i=ISeries
            RealINow=i+MinI-1;
            RealJNow=j+MinJ-1;
            IndexStackNow=find(Planning.PlannedPathA(:,1)==RealJNow & Planning.PlannedPathA(:,2)==RealINow);
            if isempty(IndexStackNow)
                WriteVitualImages;
                continue;
            end
            InT=find(RightOrWrong);
            SmallStackNow=InT(IndexStackNow);
            DirectionNow=DirectionAll(SmallStackNow); 
            FirstImageNow=ImageLastNumFinal(SmallStackNow)+1;
            ImNum=FirstImageNow;
            if DirectionNow==1
                StartIm=1;StepIm=1;EndIm=ImagesPerStack;
            else
                StartIm=ImagesPerStack;StepIm=-1;EndIm=1;
            end
            for im=StartIm:StepIm:EndIm
                DecodingSnapPlanning;
            end
        end
    end
    Stack=Stack+1;
end
    



% for s=Tag
%      L=length(dir([Folder,'\Image',num2str(s),'_*tif']));
%      
%      
%      for k=1:size(Planning.PlannedPathA,1)
%          
%      while 1 
%          if ImNum-StartImNum+1>L
%              break;
%          end
%          SmallStackNow=0;
%          for j=StartJ:StepJ:EndJ
%             for i=StartI:StepI:EndI
%                 SmallStackNow=SmallStackNow+1;
%                 while 1
%                     if RightOrWrong(SmallStackNow)==1 % 0 right
%                         SmallStackNow=SmallStackNow+1;
%                     else
%                         break;
%                     end
%                 end
%                 DirectionNow=DirectionAll(SmallStackNow); 
%                 FirstImageNow=ImageLastNumFinal(SmallStackNow)+1;
%                 ImNum=FirstImageNow;
%                 if DirectionNow==1
%                     StartIm=1;StepIm=1;EndIm=ImagesPerStack;
%                 else
%                     StartIm=ImagesPerStack;StepIm=-1;EndIm=1;
%                 end
%                 for im=StartIm:StepIm:EndIm
%                     DecodingSnap;
%                 end
%             end
%             StepI=-1*StepI; T=EndI;  EndI=StartI; StartI=T;
%          end
%          StepJ=-1*StepJ; T=EndJ;  EndJ=StartJ; StartJ=T;
%          Stack=Stack+1;
%      end
% end

SavedName=[Folder,'\','OriginalFile_MovedFile.mat'];
n=0;
while 1
    n=n+1;
    if exist(SavedName,'file')
        SavedName=subsFileExt(SavedName,'');
        SavedName=[SavedName,'_',num2str(n),'.mat'];
    else
        break;
    end
end
save(SavedName,'OriginalName','MovedName','VitualImageName');
end


