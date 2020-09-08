function  ComplementMagShiftN(CurrentMag,MoveToMag,MagResolutionHigh,classObj,Normalspeed,Acceleration,TimeConstant)
    
    if (CurrentMag==0.63 & MoveToMag==1.6) | (CurrentMag==1.6 & MoveToMag==0.63)
        HighPixel=[1116 1047];
        LowPixel=[1024 1024];
        MagResolutionHigh=2.04;
    elseif (CurrentMag==1.6 & MoveToMag==4) | (CurrentMag==4 & MoveToMag==1.6)
%         LowPixel=[1116 1047];
%         HighPixel=[1352 1099];
        LowPixel=[0 0];
        HighPixel=[78.4592 13.9350]/0.8114;
        MagResolutionHigh=0.8114;
    elseif (CurrentMag==0.63 & MoveToMag==4) | (CurrentMag==4 & MoveToMag==0.63)
        LowPixel=[1024 1024];
        HighPixel=[1352 1099];
        MagResolutionHigh=0.8114;
    end
    StepUnit=MagResolutionHigh;
    % complement from high to low
    if CurrentMag>MoveToMag
        MoveToADestination(HighPixel,LowPixel,classObj,StepUnit,Normalspeed,Acceleration,TimeConstant);
    elseif MoveToMag>CurrentMag
        MoveToADestination(LowPixel,HighPixel,classObj,StepUnit,Normalspeed,Acceleration,TimeConstant);
    end
end