
% WorkShell_SynchronizationLowMag
VoltageTrainRight=5:-0.1:4.5;% ETL voltage
% SetPulsePalVoltageNew(2,10); % light source

SleepAfterSnap=0.15; % second  LineInterval=30us,ExposureTime=50ms
% SleepAfterSnap=0.6; % second  LineInterval=50us,ExposureTime=100ms

Images=460; % Z step number
MoveStep=-0.005; % mm Z step

Normalspeed=1;
Acceleration=1;

for i=1:Images
   TriggerPulsePal([4]);
   pause(SleepAfterSnap);
   classObj.MoCtrCard_MCrlAxisRelMove(2,MoveStep,Normalspeed,Acceleration);
   pause(0.2);
 end