

HigMagExposureTime=0.02; % second


%% Fast Mode
vid = videoinput('hamamatsu', 1, 'MONO16_2048x2048_FastMode');
src = getselectedsource(vid);
vid.FramesPerTrigger = 1;
src.TriggerConnector = 'bnc';
src.ExposureTime = HigMagExposureTime;


src.TriggerActive = 'edge';
src.TriggerSource = 'external';
% TriggerRepeat is zero based and is always one
% less than the number of triggers.
vid.TriggerRepeat = Inf;
triggerconfig(vid, 'hardware', 'DeviceSpecific', 'DeviceSpecific');
vid.Timeout=100;
start(vid);



