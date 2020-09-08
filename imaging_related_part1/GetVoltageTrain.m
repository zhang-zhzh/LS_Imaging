function [PlanningLeftETLVoltage,PlanningRightETLVoltage,VoltageSampledLeft,VoltageSampledRight,VoltageSampledLeft1,VoltageSampledRight1]=GetVoltageTrain(handles)


PlanningLeftETLVoltage=eval(handles.PlanningLeftETLVoltage.String);
PlanningRightETLVoltage=eval(handles.PlanningRightETLVoltage.String);

VoltageSampledLeft=eval(handles.ImagingLeftETLVoltage.String);
VoltageSampledRight=eval(handles.ImagingRightETLVoltage.String);

VoltageSampledLeft1=eval(handles.ImagingLeftETLVoltage1.String);
VoltageSampledRight1=eval(handles.ImagingRightETLVoltage1.String);











end