% This function was used to decode the image index for imaging along Z
% axis. 
% Usage: DecodingImagingIndex(Stacks,AnimalName.cfg)
%           Folder: Folder that saves the images.
%              Tag: Tag to decode, e.g. [1 2 3]. These stacks must be continuous stacks( Imaging without breaking). 
%       StartImNum: The first image number.
%       StartStack: Start image stack
%             *cfg: Configure file produced by ImagingV.
%             Move: 1 Move file. 0 Not move file.
%    StartPosition: Imaging start position. 'TL': Topleft; 'TR': TopRight; 'DL': DownLeft; 'DR':DownRight
% The changed name format is ImageColor_Stack_Slice_j_i.tif


% Folder='I:\WholeBrainImaging\20170906_4x_YFP\Stack_1Copy\';
% Tag=1;
% ConfigureName='I:\WholeBrainImaging\20170906_4x_YFP\Stack_2\AnimalName\Configure_1.cfg';
% StartImNum=1;
% StartStack=1;
% Move=1;
% StartPosition='TL'
% [OriginalName,MovedName]=DecodingImagingIndex(Folder,Tag,StartStack,StartImNum,ConfigureName,Move,StartPosition)
function [OriginalName,MovedName]=DecodingImagingIndex(Folder,Tag,StartStack,StartImNum,ConfigureName,Move,StartPosition)

% declare/ default
% 1) Imaging started from the topleft and the first stack was got from top to down. 
% 2) When there are multi-channels, imaging order is blue, red, and yellow.
% 3) X move first.
P=file2struct(ConfigureName);
ImagesPerStack=P.Zcut/P.Zstep+1;
BlueImaging=P.BlueImaging;
RedImaging=P.RedImaging;
YellowImaging=P.YellowImaging;
LeftImaging=P.LeftImaging;
RightImaging=P.RightImaging;
Xcycle=P.Xcycle;
Ycycle=P.Ycycle;
ImNum=StartImNum;
Stack=StartStack;

if strcmp(StartPosition,'TL')
    StartJ=1;StepJ=1;EndJ=Ycycle;
    StartI=1;StepI=1;EndI=Xcycle;
    StartIm=1;StepIm=1;EndIm=ImagesPerStack;
elseif strcmp(StartPosition,'TR')
    StartJ=1;StepJ=1;EndJ=Ycycle;
    StartI=Xcycle;StepI=-1;EndI=1;
    StartIm=1;StepIm=1;EndIm=ImagesPerStack;  
elseif strcmp(StartPosition,'DL')
    StartJ=Ycycle;StepJ=-1;EndJ=1;
    StartI=1;StepI=1;EndI=Xcycle;
    StartIm=ImagesPerStack;StepIm=-1;EndIm=1;  
elseif strcmp(StartPosition,'DR')
    StartJ=Ycycle;StepJ=-1;EndJ=1;
    StartI=Xcycle;StepI=-1;EndI=1;
    StartIm=ImagesPerStack;StepIm=-1;EndIm=1;  
else
    warning('Error, wrong start posision!')
    return;
end


for s=Tag
     L=length(dir([Folder,'\Image',num2str(s),'_*tif']));
     while 1 
         if ImNum-StartImNum+1>L
             break;
         end
         for j=StartJ:StepJ:EndJ
            for i=StartI:StepI:EndI
                for im=StartIm:StepIm:EndIm
                    DecodingSnap;
                end
                StepIm=-1*StepIm; T=EndIm;  EndIm=StartIm; StartIm=T;
            end
            StepI=-1*StepI; T=EndI;  EndI=StartI; StartI=T;
         end
         StepJ=-1*StepJ; T=EndJ;  EndJ=StartJ; StartJ=T;
         Stack=Stack+1;
     end
end

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
save(SavedName,'OriginalName','MovedName');
end





