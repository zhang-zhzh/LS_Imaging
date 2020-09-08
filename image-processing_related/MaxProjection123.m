

% folder='H:\20170811_YFP_CUBIC_X_BF\Stack_8\ChangeBrightness\StitchedTiff\';
folder='D:\WholeBrainImagingData\20190111_120_G\Stack_3\FFTDnoise\StitchedTiff\RegistrationResults_Batch_2\'
Files=dir([folder,'\*tif']);
Direction=[1 2 3];

Projected1=[];
Projected2=[];
Projected3=[];
for i=1:length(Files)
    filenow=[folder,'\','ImageBlue_1_' num2str(i) '_Stitched.tif'];
    im=loadTifFast(filenow);
    if any(Direction==1)
       Projected1(end+1,:)=max(im,[],1);
    end
    if any(Direction==2)
       Projected2(end+1,:)=max(im,[],2);
    end
    if any(Direction==3)
       Projected3(:,:,end+1)=im;  
    end
end


% if any(Direction==3)
%     Projected3=max(Projected3,[],3);
% end

SaveFolder=[folder,'\MaxProjected\'];
mkdir(SaveFolder)
SaveName1=[SaveFolder,'Projected1.tif'];
SaveName2=[SaveFolder,'Projected2.tif'];
SaveName3=[SaveFolder,'Projected3.tif'];

if any(Direction==1)
   writeTifFast(SaveName1,Projected1,16);
end
if any(Direction==2)
   writeTifFast(SaveName2,Projected2,16);
end
if any(Direction==3)
   writeTifFast(SaveName3,Projected3,16);
end
