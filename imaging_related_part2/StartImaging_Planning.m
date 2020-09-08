%%% This is the main function of imaging. 
%%% Usage: 
%%%     StartImaging_Planning(hObject,eventdata,handles)

function StartImaging_Planning(hObject,eventdata,handles)


%% Initialize
Update;
query(Wheel, FilterStr(FilterBlue), '%c\n');
FilterState=FilterBlue;

%% Start Planning
OverallDirection=1; % 1 from the top left to down right; -1 from the down right to the top left
ImagingMatrixA=[];
PlannedPathA=[];
ZDirectionAll=[];
StackAll=[];
DirectionAll=[];
RightOrWrong=[]; % 1 right, 0 wrong
ImageNumAfterAStack=[];
RightOrWrongPlanning=[];
ImageNumAfterAStackPlanning=[];
DirectionAllPlanning=[];

warning off
for s=1:Zstacks
%     clear ImageNumAfterAStack DirectionAll RightOrWrong
    if handles.Planning.Value==1
        % if this is not the first stack, we should first move the current
        % field of view to the center
        if s~=1
            CurrentImagingCenterLocation=GetCenterLocation(CurrentLocation,StartRowA,EndRowAV,StartColumnA,EndColumnAV,SizeImagingMatrix);
            StepUnit=MagResolutionLow;
            MoveToADestination(CurrentImagingCenterLocation,ImagingCenterLocation,classObj,StepUnit,Normalspeed,Acceleration,TimeConstant);
        end  
        % Change the magnification
        MagResolutionHigh=GetResolution(MagImaging);
        PreviousMag=CurrentMagnification;
        CurrentMagnification=ChangeMagfication(hObject,handles,CurrentMagnification,LowMagnification);
%         ComplementMagShift(CurrentMagnification,LowMagnification,MagResolutionHigh,classObj,Normalspeed,Acceleration,TimeConstant,HighPixel,LowPixel)
    
        ComplementMagShiftN(PreviousMag,CurrentMagnification,MagResolutionHigh,classObj,Normalspeed,Acceleration,TimeConstant)
    
        
        % Adjust the focus, MoveDirection, 1 up, -1 down
        

        [FocusMove,Direction]=getFocusMove(PreviousMag,CurrentMagnification);

        if CurrentMagnification~=PreviousMag
            AdJustFocus(handles,FocusMove,Direction);
        end

        % Start imaging with low magnification (0.63x) ,first we should align the center of the current field of view and the current image.
%         ImagingWithLowMag_4xN;  
        ImagingWithLowMagX_Single;
        % Load images
        InputVoulum=LoadImagesX(SaveFolder,OverLapLowMag,ImagesPerStackPlanning,ReferenceName,OverLapLowMag,[GridX,GridY]);
        TheCurrentMaxProjectionImage=max(InputVoulum,3);
        SizeMPLow=size(TheCurrentMaxProjectionImage);
        ImagingCenterLocation=size(TheCurrentMaxProjectionImage)/2;
        % detect axon signal
%         seg=Axon_Segmentation(TheCurrentMaxProjectionImage);
        seg=TheCurrentMaxProjectionImage;
        % analyze images to find the optimal path
        [ImagingMatrix,StepStage,StartRowA,EndRowA,StartColumnA,EndColumnA,MagResolutionLow,MagResolutionHigh,EndRowAV,EndColumnAV]=FindImagingMatrix(seg,DownfactorXY,DownfactorZ,MagLow,MagImaging,OverlapImaging,CutoffSignal,CutoffImagingRatio);
        Update;
        SizeImagingMatrix=size(ImagingMatrix);
        
        if ShowPlanning==1
            if handles.CheckPlanning.Value==1
                h.fig = figure;
                BackCol = [1 1 1];
                TheCurrentMaxProjectionImageHDR=tonemap(double(TheCurrentMaxProjectionImage),'AdjustSaturation',1);
                set(h.fig, 'Units', 'Normalized', 'Position', [0 1 0 1]);
%                 set(h.fig, 'DefaultAxesLineWidth', 2, 'DefaultAxesFontSize', 12, 'Color', BackCol);
                set(h.fig, 'WindowButtonDownFcn', {@figClick, h.fig,StartRowA,EndRowA,StartColumnA,EndColumnA,ImagingMatrix,TheCurrentMaxProjectionImageHDR});
                h.ax(1) = axes;
                 h.axim(1) = imshow(TheCurrentMaxProjectionImageHDR,[]); hold on;
                PlotGrids(StartRowA,EndRowA,StartColumnA,EndColumnA,ImagingMatrix);
                h.ImagingMatrix=ImagingMatrix;
                guidata(h.fig, h);
                while 1
                    if handles.StartI.Value==1
                        handles.StartI.Value=0;
                        break;
                    end
                    h = guidata(h.fig);
                    ImagingMatrix=h.ImagingMatrix;
                    pause(0.01)
                end
            else
                figure;
                imshow(TheCurrentMaxProjectionImage,[])
                hold on
                PlotGrids(StartRowA,EndRowA,StartColumnA,EndColumnA,ImagingMatrix);
            end
        end
        
        clear TheCurrentMaxProjectionImage  TheCurrentMaxProjectionImageHDR
        % find the planning path, bug when there are no images detected
        [PlannedPath XDirectionAll]=FoundPlannedPath(ImagingMatrix,OverallDirection);
        % change to imaging magnification 
        
%         pause(1);
%         mouse_control_ExternalLightSheetMode(1);
       
        
        PreviousMag=CurrentMagnification;
        CurrentMagnification=ChangeMagfication(hObject,handles,CurrentMagnification,MagImaging);
%         ComplementMagShift(CurrentMagnification,MagImaging,MagResolutionHigh,classObj,Normalspeed,Acceleration,TimeConstant,HighPixel,LowPixel)
        ComplementMagShiftN(CurrentMagnification,MagImaging,MagResolutionHigh,classObj,Normalspeed,Acceleration,TimeConstant)
        
        
        % Complement Low To High
        % complement the center difference between this two focus
        % first you should know where you are after path planning with low
        % magnification. Suppose there is a difference between the center of low
        % magnification and high magnification.
        % DeltaCenter=CenterOfHighMag-CenterOfLowMag;
        % Move To Low Mag Center when in high Mag
        
       [FocusMove,Direction]=getFocusMove(PreviousMag,CurrentMagnification);
        if PreviousMag~=CurrentMagnification
            AdJustFocus(handles,FocusMove,Direction);
        end
        
        
        % move to zeros
        OriginalCenterLocation=handles.my.OriginalCenterLocation;
        MoveToZerosF(classObj,OriginalCenterLocation);
        CurrentLocationCenter=CurrentStitchedImageRealCenter/MagResolutionLow;
        % Move To the first location of the PlannedPath
        if ~isempty(PlannedPath)
    %         ImagingCenterLocation=fix(SizeMPLow/2);  
            DestinationImagingCenterLocation=GetCenterLocation(PlannedPath(1,:),StartRowA,EndRowAV,StartColumnA,EndColumnAV,SizeImagingMatrix);
            StepUnit=MagResolutionLow;
            MoveToADestination(CurrentLocationCenter,DestinationImagingCenterLocation,classObj,StepUnit,Normalspeed,Acceleration,TimeConstant);
            CurrentLocation=PlannedPath(1,:);
        end
    end
    ImagingMatrixA(:,:,s)=ImagingMatrix;
    
    % Start Moving And Imaging. The first ZDirection is +1
    Zdirection=1;
    ImageNumAfterAStack(end+1)=DetectLastImageNum(SaveFolder);
    
  
    StackNow=0;
    Ycycle=SizeImagingMatrix(1);
    jI=0;
    
  
    LinkNone;
    
    for i=1:size(PlannedPath,1)
        j=PlannedPath(i,1);
        VoltageSampledRightN=VoltageSampledRight(j,:);
        VoltageSampledLeftN=VoltageSampledLeft(j,:);
        if jI~=j
%             NonsynLink; % close it when using Synchronization
            WorkShell_Synchronization;
            jI=j;
        end
        MoveToLocation=PlannedPath(i,:);
        StepUnit=StepStage; % um
        MoveToADestination(CurrentLocation,MoveToLocation,classObj,StepUnit,Normalspeed,Acceleration,TimeConstant);
        CurrentLocation=MoveToLocation;
        display(['Current Location: [',num2str(CurrentLocation(1)),',',num2str(CurrentLocation(2)),']'])
        Xdirection=XDirectionAll(i);
        eval('SnapAZStackSingleChannelContinuously');
%         SnapAZStackSingleChannelContinuously;
        ZDirectionAll(end+1)=Zdirection;
%         Zdirection=Zdirection*-1;
        
        PlannedPathA(end+1,1:2)=PlannedPath(i,:);
        StackAll(end+1)=s;
        
        Planning.PlannedPathA=PlannedPathA;
        Planning.StackAll=StackAll;
        Planning.ImagingMatrixA=ImagingMatrixA;
        Planning.ZDirectionAll=ZDirectionAll;

        save([SaveFolder,'Planning.mat'],'Planning'); 
    end
    handles.my.CurrentLocation=CurrentLocation;
    
    ZDirectionNextInitial=ZDirectionAll(end);
    %% final imaging
    OverallDirection=1; % 1 from the top left to down right; -1 from the down right to the top left
    ImagingMatrixA=[];
    PlannedPathA=[];
    ZDirectionAll=[];
    StackAll=[];
    DirectionAll=[];
    RightOrWrong=[]; % 1 right, 0 wrong
    ImageNumAfterAStack=[];
    RightOrWrongPlanning=[];
    ImageNumAfterAStackPlanning=[];
    DirectionAllPlanning=[];

    
    
    % complement to planning mag
%     ComplementMagShift(CurrentMagnification,LowMagnification,MagResolutionHigh,classObj,Normalspeed,Acceleration,TimeConstant,HighPixel,LowPixel)
%     ComplementMagShiftN(CurrentMagnification,LowMagnification,MagResolutionHigh,classObj,Normalspeed,Acceleration,TimeConstant);
  
    % complement to final imaging mag
    PreviousMag=CurrentMagnification;
    CurrentMagnification=ChangeMagfication(hObject,handles,CurrentMagnification,MagImaging1);
%     ComplementMagShift(CurrentMagnification,MagImaging1,MagResolutionHigh,classObj,Normalspeed,Acceleration,TimeConstant,HighPixel1,LowPixel1)
    ComplementMagShiftN(PreviousMag,CurrentMagnification,MagResolutionHigh,classObj,Normalspeed,Acceleration,TimeConstant)
    
    % focus
   [FocusMove,Direction]=getFocusMove(PreviousMag,CurrentMagnification);
    if PreviousMag~=CurrentMagnification
        AdJustFocus(handles,FocusMove,Direction);
    end
    % move to the center location
    OriginalCenterLocation=handles.my.OriginalCenterLocation;
    MoveToZerosF(classObj,OriginalCenterLocation);

    % load the middle Mag planning images
    Tag=1;
    StartStack=1;
    Overlap=OverlapImaging;
    TheCurrentMaxProjectionImage=LoadingToMaxProjection(SaveFolder,Tag,StartStack,Overlap);
    
    %
    ResolutionL=GetResolution(MagLow);
    ResolutionH=GetResolution(MagImaging); 
    OverlapImaging=str2num(handles.OverlapImaging.String);
    OverlapPlanning=str2num(handles.OverlapPlanning.String);
    
    LengthPlaning=ResolutionL*2048*2-ResolutionL*2048*OverlapPlanning/100;
    LengthImaging=ResolutionH*2048-ResolutionH*2048*OverlapImaging/100;
    DeltePixel=fix(2048*(1-(LengthPlaning/LengthImaging-floor(LengthPlaning/LengthImaging))));
    TheCurrentMaxProjectionImage=TheCurrentMaxProjectionImage(1:end-DeltePixel,1:end-DeltePixel);
    CurrentLocationCenter=size(TheCurrentMaxProjectionImage)/2;
    ImagingCenterLocation=CurrentLocationCenter;
    % start the second round planning and imaging
    % detect axon signal
    seg=Axon_Segmentation(TheCurrentMaxProjectionImage);
   
    
    % analyze images to find the optimal path
    [ImagingMatrix,StepStage,StartRowA,EndRowA,StartColumnA,EndColumnA,MagResolutionLow,MagResolutionHigh,EndRowAV,EndColumnAV]=FindImagingMatrix(seg,DownfactorXY,DownfactorZ,MagImaging,MagImaging1,OverlapImaging1,CutoffSignal1,CutoffImagingRatio1);
    Update;
    SizeImagingMatrix=size(ImagingMatrix);

    if ShowPlanning==1
        if handles.CheckPlanning.Value==1
            h.fig = figure;
            BackCol = [1 1 1];
            TheCurrentMaxProjectionImageHDR=tonemap(double(TheCurrentMaxProjectionImage),'AdjustSaturation',1);
%             TheCurrentMaxProjectionImageHDR=TheCurrentMaxProjectionImage;
            set(h.fig, 'Units', 'Normalized', 'Position', [0 1 0 1]);
%                 set(h.fig, 'DefaultAxesLineWidth', 2, 'DefaultAxesFontSize', 12, 'Color', BackCol);
            set(h.fig, 'WindowButtonDownFcn', {@figClick, h.fig,StartRowA,EndRowA,StartColumnA,EndColumnA,ImagingMatrix,TheCurrentMaxProjectionImageHDR});
            h.ax(1) = axes;
            h.axim(1) = imshow(TheCurrentMaxProjectionImageHDR,[]); hold on;
            PlotGrids(StartRowA,EndRowA,StartColumnA,EndColumnA,ImagingMatrix);
            h.ImagingMatrix=ImagingMatrix;
            guidata(h.fig, h);
            while 1
                if handles.StartI.Value==1
                    handles.StartI.Value=0;
                    break;
                end
                h = guidata(h.fig);
                ImagingMatrix=h.ImagingMatrix;
                pause(0.01)
            end
        else
            figure;
            imshow(TheCurrentMaxProjectionImage,[])
            hold on
            PlotGrids(StartRowA,EndRowA,StartColumnA,EndColumnA,ImagingMatrix);
        end
    end
    
    
    % find the planning path, bug when there are no images detected
    [PlannedPath XDirectionAll]=FoundPlannedPath(ImagingMatrix,OverallDirection);
    % change to imaging magnification 
    
    % change exposure
    % note
    
    pause(1);
    mouse_control_ExternalLightSheetMode(0);
  
  

   
    
    % Move To the first location of the PlannedPath
    if ~isempty(PlannedPath)
%         ImagingCenterLocation=fix(SizeMPLow/2);   
        DestinationImagingCenterLocation=GetCenterLocation(PlannedPath(1,:),StartRowA,EndRowAV,StartColumnA,EndColumnAV,SizeImagingMatrix);
        StepUnit=MagResolutionLow;
        MoveToADestination(CurrentLocationCenter,DestinationImagingCenterLocation,classObj,StepUnit,Normalspeed,Acceleration,TimeConstant);
        CurrentLocation=PlannedPath(1,:);
    end
    
    ImagingMatrixA(:,:,s)=ImagingMatrix;

    % Start Moving And Imaging. The first ZDirection is +1
    Zdirection=ZDirectionNextInitial;
    ImageNumAfterAStack(end+1)=DetectLastImageNum(SaveFolder);

    StackNow=0;
    Ycycle=SizeImagingMatrix(1);
    jI=0;

    LinkNone;
    for i=1:size(PlannedPath,1)
        j=PlannedPath(i,1);
        VoltageSampledRightN=VoltageSampledRight1(j,:);
        VoltageSampledLeftN=VoltageSampledLeft1(j,:);
        if jI~=j
%               NonsynLink; % close it when using Synchronization
              WorkShell_Synchronization1;
            jI=j;
        end
        MoveToLocation=PlannedPath(i,:);
        StepUnit=StepStage; % um
        MoveToADestination(CurrentLocation,MoveToLocation,classObj,StepUnit,Normalspeed,Acceleration,TimeConstant);
        CurrentLocation=MoveToLocation;
        display(['Current Location: [',num2str(CurrentLocation(1)),',',num2str(CurrentLocation(2)),']'])
        Xdirection=XDirectionAll(i);
        eval('SnapAZStackSingleChannelContinuously1');
        ZDirectionAll(end+1)=Zdirection;
    %         Zdirection=Zdirection*-1;

        PlannedPathA(end+1,1:2)=PlannedPath(i,:);
        StackAll(end+1)=s;

        Planning.PlannedPathA=PlannedPathA;
        Planning.StackAll=StackAll;
        Planning.ImagingMatrixA=ImagingMatrixA;
        Planning.ZDirectionAll=ZDirectionAll;

        save([SaveFolder,'Planning1.mat'],'Planning'); 
    end
    handles.my.CurrentLocation1=CurrentLocation;
    
    
    %%
    
    Judge;
    if handles.Break.Value==1
      handles.StartImaging.Value=0;
      guidata(hObject,handles);
      break;
    end
    
    % Complement the Current location, because the current location may not the
    % TranslationCutReadyS or TranslationCutReadyL. Suppose that the
    % TranslationCutReadyS and TranslationCutReadyL were computed from the
    % center of the image 
    
    CurrentImagingCenterLocation=GetCenterLocation(CurrentLocation,StartRowA,EndRowAV,StartColumnA,EndColumnAV,SizeImagingMatrix);      
    TranslationCutReadyS=TranslationCutReadyS-(ImagingCenterLocation(2)-CurrentImagingCenterLocation(2))*MagResolutionLow/1000;
    TranslationCutReadyL=TranslationCutReadyS;
    
    CutReturnS=abs(TranslationCutReadyS)+abs(CutStepCutting);
    CutReturnL=CutReturnS;
    TranslationCutReturnS=abs(CutReturnS)*-1;
    TranslationCutReturnL=abs(CutReturnL)*-1;

    
    
    % To Cut
    ToCut;
    OverallDirection=OverallDirection*-1;
    Judge;
    if handles.Break.Value==1
      handles.StartImaging.Value=0;
      guidata(hObject,handles);
      break;
    end

end



%%
SaveConfigure(handles);


