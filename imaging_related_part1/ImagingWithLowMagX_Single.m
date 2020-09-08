% Start Imaging With Low Magnification
% Usually, imaging with 0.63x. Start with the current center
OverLapLowMag=str2num(handles.OverlapPlanning.String)/100;
StepLowMag=2048*ResolutionProgramme-2048*ResolutionProgramme*OverLapLowMag;
StepUnit=1;
SleepAfterSnap=0.2;

GridX=str2num(handles.GridX.String);
GridY=str2num(handles.GridY.String);

CurrentStitchedImagePixelSize=[GridX*2048-2048*OverLapLowMag*(GridX-1),GridY*2048-2048*OverLapLowMag*(GridY-1)];
CurrentStitchedImagePixelSize=fix(CurrentStitchedImagePixelSize);
CurrentStitchedImageRealSize=CurrentStitchedImagePixelSize*ResolutionProgramme;
CurrentStitchedImageRealCenter=CurrentStitchedImageRealSize/2;

StoreLocation=[];
DiGX=1;
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
        LocationToRun=[2048/2+(GX-1)*2048*(1-OverLapLowMag),2048/2+(GY-1)*2048*(1-OverLapLowMag)]*ResolutionProgramme;
        StoreLocation=[StoreLocation;LocationToRun];
    end
end

DirectionPlanning=1;
% get the initial image number
ImageNumAfterAStackPlanning(end+1)=DetectLastImageNum(SaveFolder);
% initialization
ImagesPerStackPlanning=1;% #
TranslationZCon=TranslationZT;
MoveToADestination(CurrentStitchedImageRealCenter,StoreLocation(1,:),classObj,StepUnit,Normalspeed,Acceleration,TimeConstant);
CurrentLoactionN=StoreLocation(1,:);
% first move to the down of the stack 
PosOri=GetCurrentStageLocation(classObj,2);
classObj.MoCtrCard_MCrlAxisRelMove(2,abs(TranslationZCon)*-1,Normalspeed,Acceleration);
[TimeUsedAll,RunTimes]=MoveOrNot_V2(classObj,TimeConstant,PosOri,2);
DirectionPlanning=DirectionPlanning*-1;
for M=1:size(StoreLocation,1)
    % change light
    if M/GridY<=ceil(GridX/2)
        SetPulsePalVoltageNew(ColorLeft,0); 
        SetPulsePalVoltageNew(ColorRight,ColorIntensityLowMagRight);
        pause(SleepTime7);
    else
        SetPulsePalVoltageNew(ColorRight,0); 
        SetPulsePalVoltageNew(ColorLeft,ColorIntensityLowMagLeft);
        pause(SleepTime7);
    end
    WorkShell_SynchronizationLowMagX;
    MoveToLocationN=StoreLocation(M,:);
    MoveToADestination(CurrentLoactionN,MoveToLocationN,classObj,StepUnit,Normalspeed,Acceleration,TimeConstant);
    CurrentLoactionN=MoveToLocationN;
    TriggerPulsePal([4]);
    pause(SleepAfterSnap);
    DirectionAllPlanning(end+1)=DirectionPlanning;    
    ImageLastNumPlanning=DetectLastImageNum(SaveFolder);
    ImageNumAfterAStackPlanning(end+1)=ImageLastNumPlanning;
end

save([SaveFolder,'ImageLastNumPlanning.mat'],'ImageNumAfterAStackPlanning');
save([SaveFolder,'DirectionAllPlanning.mat'],'DirectionAllPlanning');

CurrentLocationCenter=CurrentLoactionN/ResolutionProgramme;
% Close light
SetPulsePalVoltageNew(ColorLeft,0); 
SetPulsePalVoltageNew(ColorRight,0);

% Return to the original location
% change
if DirectionPlanning==-1
    PosOri=GetCurrentStageLocation(classObj,2);
    classObj.MoCtrCard_MCrlAxisRelMove(2,abs(TranslationZCon),Normalspeed,Acceleration);
    [TimeUsedAll,RunTimes]=MoveOrNot_V2(classObj,TimeConstant,PosOri,2);
end































