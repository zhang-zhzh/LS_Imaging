

LowMagInternalLineInterval=3e-05; % second
LowMagExposureTime=0.050; % second

%% Light-sheet mode
vid = videoinput('hamamatsu', 1, 'MONO16_LightSheet Mode_FastMode');
src = getselectedsource(vid);
vid.FramesPerTrigger = 1;
src.TriggerConnector = 'bnc';
preview(vid);

src.InternalLineInterval = LowMagInternalLineInterval;
src.ExposureTime = LowMagExposureTime;

stoppreview(vid);

% src.ReadoutDirection = 'backward';
src.ReadoutDirection = 'forward';
src.TriggerSource = 'external';
src.TriggerPolarity = 'positive';
% TriggerRepeat is zero based and is always one
% less than the number of triggers.
vid.TriggerRepeat = Inf;
triggerconfig(vid, 'hardware', 'DeviceSpecific', 'DeviceSpecific');
vid.Timeout=100;
start(vid);














