function [LeftImaging,RightImaging,BlueImaging,YellowImaging,RedImaging,LeftImaging1,RightImaging1]=getValueImaging(handles)
      
      LeftImaging=str2num(handles.LeftImaging.String);
      RightImaging=str2num(handles.RightImaging.String);
      BlueImaging=handles.BlueImaging.Value;
      YellowImaging=handles.YellowImaging.Value;
      RedImaging=handles.RedImaging.Value;
      
      LeftImaging1=str2num(handles.LeftImaging1.String);
      RightImaging1=str2num(handles.RightImaging1.String);
end