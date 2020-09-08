%a=get(0,'UserData');
%%
Images=140;
MoveStep=0.005; % mm
Normalspeed=0.1;
Acceleration=0.1;
for i=1:Images
   SetPulsePalVoltage(3,3.3);
   pause(0.004);
   SetPulsePalVoltage(3,0);
   classObj.MoCtrCard_MCrlAxisRelMove(2,MoveStep,Normalspeed,Acceleration);
   pause(0.5);  
end
%%




