% for 4 x
% Snap a stack of images of single light. Only for left light or right light seperately
% Using motor control instead of the grating ruler.


ImagesPerStack=200; 

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

% Ycycle=12;

if Ycycle-LeftImaging1<j
    SetPulsePalVoltageNew(ColorRight,0); 
%     SetPulsePalVoltageNew(ColorLeft,10);
    SetPulsePalVoltageNew(ColorLeft,ColorIntensityHighMagLeft);
    FirstVoltage=VoltageSampledLeftN(1);
    Side=2;
    pause(SleepTime7);
elseif RightImaging1>=j
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
     0.1,0.005,10);
% classObj.MoCtrCard_MCrlAxisRelMoveAndPulse(2,Di,3,abs(TranslationZCon),0.002,0.002,...
%      0.07,0.005,10);

 
 
 
classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
PosOri=classObj.gbAxisEnc(3);
TimeConstant=200;
[TimeUsedi,RunTimes]=MoveOrNot(classObj,TimeConstant,PosOri);



% SingleMoveHighMag; % #
% ImagesPerStack=201; % # 


 

% time delay
% SleepMyTime1=1.5;% first move
% SleepMyTime2=15; % move and snap
% SleepMyTime3=3; % return time 


% tell the arduino not to snap
% try
%   fwrite(ARDUINO,'z');
% catch
%   fclose(ARDUINO);
%   fopen(ARDUINO);
%   fwrite(ARDUINO,'z');
% end


% % return
% SnapMoveReturn=Zcut+1;
% classObj.MoCtrCard_MCrlAxisRelMove(2,SnapMoveReturn,1,1);
% pause(SleepMyTime3)
% 
% 
% 
% % first move 
% classObj.MoCtrCard_MCrlAxisRelMove(2,-1,1,1);
% pause(SleepMyTime1)

% tell the arduino to be ready
% try
%   fwrite(ARDUINO,'a');
% catch
%   fclose(ARDUINO);
%   fopen(ARDUINO);
%   fwrite(ARDUINO,'a');
% end
% 
% pause(1);

% move and snap
% SnapMove=Zcut*-1;
% classObj.MoCtrCard_MCrlAxisRelMove(2,SnapMove,0.1,0.1);
% pause(SleepMyTime2)
% 
% try
%   fwrite(ARDUINO,'z');
% catch
%   fclose(ARDUINO);
%   fopen(ARDUINO);
%   fwrite(ARDUINO,'z');
% end
% pause(0.5);

MakeAStackEndTag(SaveFolder)

% judge right or wrong


ImageLastNum=ImageNumAfterAStack(end)+ImagesPerStack;
DirectionAll(end+1)=Zdirection;
ImageLastNumFinal=ImageNumAfterAStack(1:end);

if exist([SaveFolder,'ImageLastNum1.mat'])
    save([SaveFolder,'ImageLastNum1.mat'],'ImageLastNumFinal','-append');
    save([SaveFolder,'DirectionAll1.mat'],'DirectionAll','-append');
else
    save([SaveFolder,'ImageLastNum1.mat'],'ImageLastNumFinal');
    save([SaveFolder,'DirectionAll1.mat'],'DirectionAll');
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
     eval('SnapAZStackSingleChannelContinuously1');
end

SetPulsePalVoltageNew(ColorLeft,0); 
SetPulsePalVoltageNew(ColorRight,0); 

if exist([SaveFolder,'RightOrWrong1.mat'])
    save([SaveFolder,'RightOrWrong1.mat'],'RightOrWrong','-append');
else
    save([SaveFolder,'RightOrWrong1.mat'],'RightOrWrong');
end













