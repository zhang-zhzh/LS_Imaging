%% 1.6x imaging
for i=1
    Folder=['D:\WholeBrainImagingData\20190906_F19_TM\Stack_' num2str(i) '\'];
    ConfigureName='D:\WholeBrainImagingData\20190906_F19_TM\Stack_1\AnimalName\Configure.cfg'
    Tag=1;
    StartStack=1;
    Move=1;
    [OriginalName,MovedName]=DecodingImagingIndexContinous_PathPlanningMultiColor_v2(Folder,Tag,StartStack,ConfigureName,Move,MaxProjectedImagingMatrix)
    % [OriginalName,MovedName]=DecodingImagingIndexContinous_PathPlanning(Folder,Tag,StartStack,ConfigureName,Move,MaxProjectedImagingMatrix)
    
    Direction=[3];
    MaxProjection(Folder,Direction);
end
%%
for i=1
    FolderN=['D:\WholeBrainImagingData\20190906_F19_TM\Stack_' num2str(i) '\MaxProjection\'];
    StitchingColor=[1];
    StitchingSide=3;
    Overlap=5;
    ComputeOverlap=0;
    ImagingRow=[1 2];
    StitchingMaxProjection_v2(FolderN,StitchingColor,StitchingSide,Overlap,ComputeOverlap,ImagingRow);
end

%% 
for i=1
StitchingColor=[1];
StitchingSide=[3];
Overlap=5;
ComputeOverlap=0;
StitchAccordingMaxProjection=0;
ImagingRow=[1 2];
StitchingConfiureFolder='D:\WholeBrainImagingData\20190906_F19_TM\Stack_1\MaxProjection\';
Folder=['D:\WholeBrainImagingData\20190906_F19_TM\Stack_' num2str(i)  '\'];
% StitchingForGUIV3(Folder,StitchingColor,StitchingSide,Overlap,ComputeOverlap,StitchAccordingMaxProjection,StitchingConfiureFolder)
StitchingForGUIV3_v3(Folder,StitchingColor,StitchingSide,Overlap,ComputeOverlap,StitchAccordingMaxProjection,StitchingConfiureFolder,ImagingRow)
end


%% 4x imaging

for i=5
    Folder=['J:\20191114_H246_TM\Stack_' num2str(i) '\'];
    ConfigureName='J:\20191114_H246_TM\Stack_1\AnimalName\AnimalName\Configure_3.cfg';
    Tag=1;
    StartStack=1;
    Move=1;
    [OriginalName,MovedName]=DecodingImagingIndexContinous_PathPlanningMultiColor_v2_4x(Folder,Tag,StartStack,ConfigureName,Move,MaxProjectedImagingMatrix);

    Direction=[3];
    MaxProjection(Folder,Direction);
end
%%
for i=1:14
    FolderN=['L:\20191118_Y34_TM_Copy\Stack_' num2str(i) '\MaxProjection\'];
    StitchingColor=[1];
    StitchingSide=3;
    Overlap=6;
    ComputeOverlap=0;
    ImagingRow=[3 4];
    StitchingMaxProjection_v2_4x(FolderN,StitchingColor,StitchingSide,Overlap,ComputeOverlap,ImagingRow);
end
%%
for i=1:14

StitchingColor=[1];
StitchingSide=[3];
Overlap=6;
ComputeOverlap=0;
StitchAccordingMaxProjection=0;
ImagingRow=[3 4];
StitchingConfiureFolder='L:\20191118_Y34_TM_Copy\Stack_5\MaxProjection\';
Folder=['L:\20191118_Y34_TM_Copy\Stack_' num2str(i)  '\'];
StitchingForGUIV3_v3_4x(Folder,StitchingColor,StitchingSide,Overlap,ComputeOverlap,StitchAccordingMaxProjection,StitchingConfiureFolder,ImagingRow)
end



