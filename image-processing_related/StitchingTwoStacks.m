% This function was used to stitch two stacks. The second stack will be
% moved to match the first stack.
%%

FirstStackReferenceImageName='D:\WholeBrainImagingData\20180811_YFP_CUBIC_X\Stack_3\StitchedTiff\MAX_Stack3_E.tif';
SecondStackReferenceImageName='D:\WholeBrainImagingData\20180811_YFP_CUBIC_X\Stack_4\StitchedTiff\MAX_Stack4_F.tif';

FirstStackFolder=fileparts(FirstStackReferenceImageName);
SecondStackFolder=fileparts(SecondStackReferenceImageName);

FolderRegistration=[SecondStackFolder,'\RegistrationResults'];
mkdir(FolderRegistration);

FirstStackReferenceImage=loadTifFast(FirstStackReferenceImageName);
SecondStackReferenceImage=loadTifFast(SecondStackReferenceImageName);

% registration
[optimizer, metric] = imregconfig('multimodal');
optimizer.GrowthFactor=1.01;
optimizer.InitialRadius=optimizer.InitialRadius/10;
optimizer.Epsilon=optimizer.Epsilon/10;
[movingRegistered, R_reg,tForm]= imregisterYin(SecondStackReferenceImage, FirstStackReferenceImage, 'translation', optimizer, metric);
Rfixed = imref2d(size(FirstStackReferenceImage));
% transfer
Files=dir([SecondStackFolder, '\*.tif']);
for i=1:length(Files)
   imName= [SecondStackFolder,'\',Files(i).name];
   WaitTransform=loadTifFast(imName);
   Rmoving = imref2d(size(WaitTransform));
   [movingReg,Rreg] = imwarp(WaitTransform,Rmoving,tForm,'OutputView',Rfixed); 
   writeTifFast([FolderRegistration,'\',Files(i).name],movingReg,16)  
end

%% 
for j=4:18
    
FirstStackReferenceImageName=['D:\WholeBrainImagingData\20180811_YFP_CUBIC_X\Stack_' num2str(j) '\StitchedTiff\RegistrationResults\MAX_Stack' num2str(j) '_E.tif'];
SecondStackReferenceImageName=['D:\WholeBrainImagingData\20180811_YFP_CUBIC_X\Stack_' num2str(j+1) '\StitchedTiff\MAX_Stack' num2str(j+1) '_F.tif'];

FirstStackFolder=fileparts(FirstStackReferenceImageName);
SecondStackFolder=fileparts(SecondStackReferenceImageName);

FolderRegistration=[SecondStackFolder,'\RegistrationResults'];
mkdir(FolderRegistration);

FirstStackReferenceImage=loadTifFast(FirstStackReferenceImageName);
SecondStackReferenceImage=loadTifFast(SecondStackReferenceImageName);

% registration
[optimizer, metric] = imregconfig('multimodal');
optimizer.GrowthFactor=1.01;
optimizer.InitialRadius=optimizer.InitialRadius/10;
optimizer.Epsilon=optimizer.Epsilon/10;
[movingRegistered, R_reg,tForm]= imregisterYin(SecondStackReferenceImage, FirstStackReferenceImage, 'translation', optimizer, metric);
Rfixed = imref2d(size(FirstStackReferenceImage));
% transfer
Files=dir([SecondStackFolder, '\*.tif']);
for i=1:length(Files)
   imName= [SecondStackFolder,'\',Files(i).name];
   WaitTransform=loadTifFast(imName);
   Rmoving = imref2d(size(WaitTransform));
   [movingReg,Rreg] = imwarp(WaitTransform,Rmoving,tForm,'OutputView',Rfixed); 
   writeTifFast([FolderRegistration,'\',Files(i).name],movingReg,16)  
end
end






















