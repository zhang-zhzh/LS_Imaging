
function [Snap ,ExposureDefault ,ExposureBlueLeft ,ExposureBlueRight ,ExposureYellowLeft ,ExposureYellowRight ,ExposureRedLeft ,ExposureRedRight]=GetValueCamera(handles)
   try 
       Snap=handles.SnapPop.Value;
       ExposureDefault=handles.ExposureDefaultPop.Value;
       ExposureBlueLeft=eval(handles.ExposureBlueLeft.String);
       ExposureBlueRight=eval(handles.ExposureBlueRight.String);
       ExposureYellowLeft=eval(handles.ExposureYellowLeft.String);
       ExposureYellowRight=eval(handles.ExposureYellowRight.String);
       ExposureRedLeft=eval(handles.ExposureRedLeft.String);
       ExposureRedRight=eval(handles.ExposureRedRight.String);
   catch
       Snap=1000;
       ExposureDefault=[];
       ExposureBlueLeft=[];
       ExposureBlueRight=[];
       ExposureYellowLeft=[];
       ExposureYellowRight=[];
       ExposureRedLeft=[];
       ExposureRedRight=[];
   end