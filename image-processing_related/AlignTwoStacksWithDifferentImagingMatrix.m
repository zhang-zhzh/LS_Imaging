% This function was used to align two stacks with different imaging
% matrix. But the center of the imaging matrix was same. 

% ImagingMatrix1=[0 1 1 1 0;1 1 1 1 1;0 0 0 1 0];
% ImagingMatrix2=[0 1 1 1 0;1 1 1 1 1;0 0 0 1 0];
ExampleImage1Name='D:\WholeBrainImagingData\20180804_YFP_CUBIC_X\Stack_7\StitchedTiff\ImageBlue_1_113_Stitched.tif';
ExampleImage2Name='D:\WholeBrainImagingData\20180804_YFP_CUBIC_X\Stack_8\StitchedTiff\ImageBlue_1_1_Stitched.tif';
PlanningOverlap1=35;
ImagingOverlap1=5;
PlanningOverlap2=30;
ImagingOverlap2=5;
MagLow=0.63;
MagImaging=2.5;
MagResolutionLow=5.1760;
MagResolutionHigh=1.3082;


ImagingMatrix1=max(ImagingMatrix1,[],3);
ImagingMatrix2=max(ImagingMatrix2,[],3);
% for imaging matrix 1
SizeLowImaging=fix(2048*2-2048*PlanningOverlap1/100);
InputVolume=ones(SizeLowImaging,SizeLowImaging);
ImagingCenterLocation=size(InputVolume)/2;
DownfactorXY=1;
DownfactorZ=1;
CutoffSignal=0;
CutoffImaging=0.01;
[ImagingMatrix,StepStage,StartRowA,EndRowA,StartColumnA,EndColumnA,ResolutionProgramme,ResolutionImaging,EndRowAV,EndColumnAV]=FindImagingMatrix(InputVolume,DownfactorXY,DownfactorZ,MagLow,MagImaging,ImagingOverlap1,CutoffSignal,CutoffImaging);
PlanningCenter1=[SizeLowImaging/2 SizeLowImaging/2];
ImagingCenter1=[];
[Rows Cols]=find(ImagingMatrix1);
MinR=min(Rows);
MaxR=max(Rows);
MinC=min(Cols);
MaxC=max(Cols);
SizeImagingMatrix=size(ImagingMatrix1);
Ind=(MinR-1)*SizeImagingMatrix(1)+1;
StartR=StartRowA(Ind);
Ind=(MaxR-1)*SizeImagingMatrix(1)+1;
EndR=EndRowAV(Ind);

Ind=MinC;
StartC=StartColumnA(Ind);
Ind=MaxC;
EndC=EndColumnAV(Ind);
ImagingCenter1=[(StartR+EndR)/2 (StartC+EndC)/2];



% for imaging matrix 2
SizeLowImaging=fix(2048*2-2048*PlanningOverlap2/100);
InputVolume=ones(SizeLowImaging,SizeLowImaging);
ImagingCenterLocation=size(InputVolume)/2;
DownfactorXY=1;
DownfactorZ=1;
CutoffSignal=0;
CutoffImaging=0.01;
[ImagingMatrix,StepStage,StartRowA,EndRowA,StartColumnA,EndColumnA,ResolutionProgramme,ResolutionImaging,EndRowAV,EndColumnAV]=FindImagingMatrix(InputVolume,DownfactorXY,DownfactorZ,MagLow,MagImaging,ImagingOverlap2,CutoffSignal,CutoffImaging);
PlanningCenter2=[SizeLowImaging/2 SizeLowImaging/2];
ImagingCenter2=[];
[Rows Cols]=find(ImagingMatrix2);
MinR=min(Rows);
MaxR=max(Rows);
MinC=min(Cols);
MaxC=max(Cols);
SizeImagingMatrix=size(ImagingMatrix2);
Ind=(MinR-1)*SizeImagingMatrix(1)+1;
StartR=StartRowA(Ind);
Ind=(MaxR-1)*SizeImagingMatrix(1)+1;
EndR=EndRowAV(Ind);

Ind=MinC;
StartC=StartColumnA(Ind);
Ind=MaxC;
EndC=EndColumnAV(Ind);
ImagingCenter2=[(StartR+EndR)/2 (StartC+EndC)/2];


display(['PlanningCenter1:' num2str(PlanningCenter1)])
display(['ImagingCenter1:' num2str(ImagingCenter1)])
display(['PlanningCenter2:' num2str(PlanningCenter2)])
display(['ImagingCenter2:' num2str(ImagingCenter2)])



DeltaCenter1=ImagingCenter1-PlanningCenter1;
DeltaCenter2=ImagingCenter2-PlanningCenter2;



%% start moving

% Move1To2=1; % 1 move ImagingMatrix1 to ImagingMatrix2; 0 move ImagingMatrix2 to ImagingMatrix1

ExampleImage1=loadTifFast(ExampleImage1Name);
ExampleImage2=loadTifFast(ExampleImage2Name);
Contain='Image';
ImagingMatrix1RelatedStack={'D:\WholeBrainImagingData\20180804_YFP_CUBIC_X\Stack_7\StitchedTiff\Newfolder\',...
    'D:\WholeBrainImagingData\20180804_YFP_CUBIC_X\Stack_6\StitchedTiff\Newfolder','D:\WholeBrainImagingData\20180804_YFP_CUBIC_X\Stack_5\StitchedTiff\Newfolder',...
    'D:\WholeBrainImagingData\20180804_YFP_CUBIC_X\Stack_4\StitchedTiff\Newfolder','D:\WholeBrainImagingData\20180804_YFP_CUBIC_X\Stack_3\StitchedTiff\Newfolder'...
    'D:\WholeBrainImagingData\20180804_YFP_CUBIC_X\Stack_2\StitchedTiff\Newfolder','D:\WholeBrainImagingData\20180804_YFP_CUBIC_X\Stack_1\StitchedTiff\Newfolder'};
% ImagingMatrix2RelatedStack={'1', ...
%                              '23'};

DelataSize=size(ExampleImage2)-size(ExampleImage1);
Size1=size(ExampleImage1);
Size2=size(ExampleImage2);

DeltaPixel=(DeltaCenter2-DeltaCenter1)*MagResolutionLow/MagResolutionHigh;
DeltaPixel=fix(DeltaPixel);


if DelataSize(1)<0 | DelataSize(2)<0
    error('Size Error!')
end



for i=1:length(ImagingMatrix1RelatedStack)
    StackFolder=ImagingMatrix1RelatedStack{i};
    SaveFolder=[StackFolder '\MoveTo'];
    mkdir(SaveFolder);
    Files=dir([StackFolder '\*' Contain '*.tif']);
    for j=1:length(Files)
        FileNameNow=Files(j).name;
        FileFullNameNow=[StackFolder '\' FileNameNow];
        SaveNameNow=[SaveFolder '\' FileNameNow];
        ImNow=loadTifFast(FileFullNameNow);
        
        % first add to the same size
        if DelataSize(1)>0
            AddTop=fix(DelataSize(1)/2);
            AddDown=DelataSize(1)-AddTop;
        else
            AddTop=0;
            AddDown=0;
        end
        
        if DelataSize(2)>0
            AddLeft=fix(DelataSize(2)/2);
            AddRight=DelataSize(2)-AddLeft;
        else
            AddLeft=0;
            AddRight=0;
        end
        
        % Add Images
        ImTmpZeros=zeros([Size1(1)+AddTop+AddDown,Size1(2)+AddLeft+AddRight]);
        ImTmpZeros(AddTop+1:Size1(1)+AddTop,AddLeft+1:Size1(2)+AddLeft)=ImNow;
        SizeT=size(ImTmpZeros);
        % Move Images
        if DeltaPixel(1)>0
            MoveRow=DeltaPixel(1);
            if MoveRow>0 % remove up
                ImTmpZeros(1:SizeT(1)-MoveRow,:)=ImTmpZeros(MoveRow+1:end,:);
                ImTmpZeros(SizeT(1)-MoveRow+1:end,:)=0;
            else % remove down
                MoveRow=abs(MoveRow);
                ImTmpZeros(MoveRow+1:end,:)=ImTmpZeros(1:SizeT(1)-MoveRow,:);
                ImTmpZeros(1:MoveRow,:)=0;
            end
        end
        if DeltaPixel(2)>0
            MoveCol=DeltaPixel(2);
            if MoveCol>0 % remove up
                ImTmpZeros(:,1:SizeT(2)-MoveCol)=ImTmpZeros(:,MoveCol+1:end);
                ImTmpZeros(:,SizeT(2)-MoveCol+1:end)=0;
            else % remove down
                MoveCol=abs(MoveCol);
                ImTmpZeros(:,MoveCol+1:end)=ImTmpZeros(:,1:SizeT(2)-MoveCol);
                ImTmpZeros(:,1:MoveCol)=0;
            end
        end
        
        writeTifFast(SaveNameNow,ImTmpZeros,16);
        
    end
end
































