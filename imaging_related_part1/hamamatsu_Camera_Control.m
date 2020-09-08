
%% Fast Mode
vid = videoinput('hamamatsu', 1, 'MONO16_2048x2048_FastMode');
src = getselectedsource(vid);
vid.FramesPerTrigger = 1;
src.TriggerConnector = 'bnc';


src.TriggerActive = 'edge';
src.TriggerSource = 'external';
% TriggerRepeat is zero based and is always one
% less than the number of triggers.
vid.TriggerRepeat = Inf;
triggerconfig(vid, 'hardware', 'DeviceSpecific', 'DeviceSpecific');
vid.Timeout=100;
start(vid);




stop(vid)

vid.FramesAvailable

im = getdata(vid);


%% Light-sheet mode
vid = videoinput('hamamatsu', 1, 'MONO16_LightSheet Mode_FastMode');
src = getselectedsource(vid);
vid.FramesPerTrigger = 1;
src.TriggerConnector = 'bnc';


src.InternalLineInterval = 1e-05;
src.ExposureTime = 0.050;

src.ReadoutDirection = 'backward';
src.ReadoutDirection = 'forward';
src.TriggerSource = 'external';
src.TriggerPolarity = 'positive';
% TriggerRepeat is zero based and is always one
% less than the number of triggers.
vid.TriggerRepeat = Inf;
triggerconfig(vid, 'hardware', 'DeviceSpecific', 'DeviceSpecific');
vid.Timeout=100;
start(vid);

stop(vid)

vid.FramesAvailable

im = getdata(vid);

im = getdata(vid);
save('D:\WholeBrainImagingData\20190418_Tem\Stack_1\MATLAB.mat', 'test');
clear im;






%% Preview and auto adjust
figure('Name', 'My Custom Preview Window');
uicontrol('String', 'Close', 'Callback', 'close(gcf)');
% Create an image object for previewing.
vidRes = get(vid, 'VideoResolution');
nBands = get(vid, 'NumberOfBands');
hImage = image( zeros(vidRes(2), vidRes(1), nBands) );
setappdata(hImage,'UpdatePreviewWindowFcn',@(s,e,o)imadjust_(s,e,o));
% src.ExposureTime=0.05;
preview(vid, hImage);
%%
stoppreview(vid)
%%
delete(vid)

