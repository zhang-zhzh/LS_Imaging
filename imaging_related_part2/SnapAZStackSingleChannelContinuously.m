% for 1.6 x
% Snap a stack of images of single light. Only for left light or right light seperately
% Using motor control instead of the grating ruler.


ImagesPerStack=50; 

if s~=Zstacks
    ZImages=SlicesPerStack;
else
    ZImages=SlicesLastStack;
end

if Zdirection>0
    TranslationZ=TranslationZP;
    TranslationZCon=TranslationZT; 
else
    TranslationZ=TranslationZN;
    TranslationZCon=TranslationZTN;
end

% Ycycle=5;

if Ycycle-LeftImaging<j
    SetPulsePalVoltageNew(ColorRight,0); 
%     SetPulsePalVoltageNew(ColorLeft,10);
    SetPulsePalVoltageNew(ColorLeft,ColorIntensityHighMagLeft);
    FirstVoltage=VoltageSampledLeftN(1);
    Side=2;
    pause(SleepTime7);
elseif RightImaging>=j
    SetPulsePalVoltageNew(ColorLeft,0); 
    SetPulsePalVoltageNew(ColorRight,ColorIntensityHighMagRight);
    FirstVoltage=VoltageSampledRightN(1);
    Side=1;
    pause(SleepTime7);
end
    

% set first voltage
if Side==1
    SetPulsePalVoltage(1,FirstVoltage);
else
    SetPulsePalVoltage(2,FirstVoltage);
end


display(['Move' num2str(TranslationZCon)])
% classObj.MoCtrCard_MCrlAxisRelMove(2,TranslationZCon,0.1,0.05);
if TranslationZCon<0
   Di=1;
elseif TranslationZCon>0
   Di=0;
end
% classObj.MoCtrCard_MCrlAxisRelMoveAndPulse(2,Di,3,abs(TranslationZCon)+0.004,0.002,0.002,...
%     0.1,0.005,10);
% classObj.MoCtrCard_MCrlAxisRelMoveAndPulse(2,Di,3,abs(TranslationZCon),0.002,0.002,...
%    0.16,0.008,10);

% StartImageNum=ImageNumAfterAStack(end-1)+1;
% EndImageNum=ImageNumAfterAStack(end);


classObj.MoCtrCard_MCrlAxisRelMoveAndPulse(2,Di,3,abs(TranslationZCon),0.002,0.002,...
     0.08,0.02,10);
%  classObj.MoCtrCard_MCrlAxisRelMoveAndPulse(2,Di,3,abs(TranslationZCon),0.002,0.002,...
%      0.03,0.02,10);
 

 
 
classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
PosOri=classObj.gbAxisEnc(3);
TimeConstant=200;
[TimeUsedi,RunTimes]=MoveOrNot(classObj,TimeConstant,PosOri);

MakeAStackEndTag(SaveFolder)
% judge right or wrong

ImageLastNum=ImageNumAfterAStack(end)+ImagesPerStack;
DirectionAll(end+1)=Zdirection;
ImageLastNumFinal=ImageNumAfterAStack(1:end);

if exist([SaveFolder,'ImageLastNum.mat'])
    save([SaveFolder,'ImageLastNum.mat'],'ImageLastNumFinal','-append');
    save([SaveFolder,'DirectionAll.mat'],'DirectionAll','-append');
else
    save([SaveFolder,'ImageLastNum.mat'],'ImageLastNumFinal');
    save([SaveFolder,'DirectionAll.mat'],'DirectionAll');
end


LastImageNumReal=DetectLastImageNum(SaveFolder);


if abs(LastImageNumReal-ImageLastNum)<=MaxErrorPermitted % correct
      RightOrWrong(end+1)=1;
      ImageNumAfterAStack(end+1)=LastImageNumReal;
      Zdirection=-1*Zdirection;       
else % Error
     ImageNumAfterAStack(end+1)=LastImageNumReal;
     Zdirection=-1*Zdirection;
     StackNow=StackNow+1;
     RightOrWrong(end+1)=0;
     eval('SnapAZStackSingleChannelContinuously');
end


SetPulsePalVoltageNew(ColorLeft,0); 
SetPulsePalVoltageNew(ColorRight,0); 

if exist([SaveFolder,'RightOrWrong.mat'])
    save([SaveFolder,'RightOrWrong.mat'],'RightOrWrong','-append');
else
    save([SaveFolder,'RightOrWrong.mat'],'RightOrWrong');
end













