% javaaddpath 'C:\Program Files\MATLAB\R2016b\java\mij.jar'

for i=1:8

% Folder='D:\WholeBrainImagingData\20180804_YFP_CUBIC_X\Stack_1\';
% ConfigureName='D:\WholeBrainImagingData\20180804_YFP_CUBIC_X\Stack_1\AnimalName\Configure_1.cfg';

Folder=['D:\WholeBrainImagingData\20180923_VJ_WY_CUBIC-X\Stack_' num2str(i)  '\'];
ConfigureName=['D:\WholeBrainImagingData\20180923_VJ_WY_CUBIC-X\Stack_' num2str(i) '\AnimalName\Configure.cfg'];
Overlap=5;
ComputeOverlap=0;
ImagingRow=[3 3];
Tag=1;
StartStack=1;
Move=1;

%% decode name
Folder='D:\WholeBrainImagingData\20181113_H85\Stack_4\'
ConfigureName='D:\WholeBrainImagingData\20181113_H85\Stack_4\AnimalName\Configure_1.cfg'
% [OriginalName,MovedName]=DecodingImagingIndexContinous_PathPlanningMultiColor(Folder,Tag,StartStack,ConfigureName,Move,MaxProjectedImagingMatrix)
[OriginalName,MovedName]=DecodingImagingIndexContinous_PathPlanning(Folder,Tag,StartStack,ConfigureName,Move,MaxProjectedImagingMatrix)


%% Max projection
 Direction=[3];
 MaxProjection(Folder,Direction)

%%
% Stitch Max projection(along Z axis) results
StitchingColor=1;
StitchingSide=3;
ImagingRow=[2 3]
ComputeOverlap=0;
FolderN=[Folder '\MaxProjection\'];

FolderN='D:\WholeBrainImagingData\20181113_H85\Stack_4\MaxProjection\ChangeBrightness\'
StitchingMaxProjection_v2(FolderN,StitchingColor,StitchingSide,Overlap,ComputeOverlap,ImagingRow);


StitchingColor=[3];
StitchingMaxProjection_v2(FolderN,StitchingColor,StitchingSide,Overlap,ComputeOverlap,ImagingRow);

% change the Confiuration file name.

% Stitch single stacks according to the Max projection results
StitchingColor=[3];
StitchingSide=3;
Overlap=5;
ComputeOverlap=0;
StitchAccordingMaxProjection=1;
StitchingConfiureFolder=[Folder '\MaxProjection\'];
% StitchingForGUIV3(Folder,StitchingColor,StitchingSide,Overlap,ComputeOverlap,StitchAccordingMaxProjection,StitchingConfiureFolder)
StitchingForGUIV3_v2(Folder,StitchingColor,StitchingSide,Overlap,ComputeOverlap,StitchAccordingMaxProjection,StitchingConfiureFolder,ImagingRow)

end