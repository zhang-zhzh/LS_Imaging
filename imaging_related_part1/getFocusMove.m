function  [FocusMove,Direction]=getFocusMove(PreviousMag,CurrentMagnification)


if (CurrentMagnification==0.63 & PreviousMag==1.6) | (CurrentMagnification==1.6 & PreviousMag==0.63)
    FocusMove=12188;
elseif (CurrentMagnification==1.6 & PreviousMag==4) | (CurrentMagnification==4 & PreviousMag==1.6)
    FocusMove=1722;
elseif (CurrentMagnification==0.63 & PreviousMag==4) | (CurrentMagnification==4 & PreviousMag==0.63)
    FocusMove=1722+12188;
else
    FocusMove=0;
end


if CurrentMagnification>PreviousMag
    Direction=-1;
else
    Direction=1;
end
    
end