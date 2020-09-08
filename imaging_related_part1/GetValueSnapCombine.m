function [Snapcombine,VoltageSampledLeft,VoltageSampledRight]=getValueSnapCombine(handles)
      try 
          Snapcombine=handles.CombinePop.Value;
          VoltageSampledLeft=eval(handles.VoltageLeft.String);
          VoltageSampledRight=eval(handles.VoltageRight.String);
      catch
          Snapcombine=[];
          VoltageSampledLeft=[];
          VoltageSampledRight=[];
      end
end