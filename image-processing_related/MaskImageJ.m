
% MaskImage with ImageJ 

if ~exist('MIJ')
    Miji;
end

for j=9:11
folder=['D:\WholeBrainImagingData\20180811_YFP_CUBIC_X\Stack_' num2str(j) '\StitchedTiff\RegistrationResults\'];
SaveEdge=1;
SaveHDR=1;


MaskdFolder=[folder,'\Mask\'];
EdgeFolder=[folder,'\Edge\'];
HDRFolder=[folder,'\HDRS\'];

% creak folder
mkdir(MaskdFolder)
if SaveEdge==1
    mkdir(EdgeFolder)
end
if SaveHDR==1
    mkdir(HDRFolder)
end


Files = dir([folder,'*tif']);
for i=1:length(Files)
    filename=[folder,Files(i).name];
    maskname=[MaskdFolder,Files(i).name];
    edgename=[EdgeFolder,Files(i).name];
    hdrname=[HDRFolder,Files(i).name];
    
    SaveCommanderedge=['save=','[',edgename,']'];
    SaveCommanderedge=strrep(SaveCommanderedge,'\','\\');
    
    SaveCommandermask=['save=','[',maskname,']'];
    SaveCommandermask=strrep(SaveCommandermask,'\','\\');
    
    SaveCommanderhdr=['save=','[',hdrname,']'];
    SaveCommanderhdr=strrep(SaveCommanderhdr,'\','\\');
    
    OpenCommander=['path=[' filename ']'];
    MIJ.run('Open...', OpenCommander);
    MIJ.run("8-bit");
    MIJ.run('3D Edge and Symmetry Filter', 'alpha=1 radius=0 normalization=0 scaling=0 improved');
    
 
    
    % creat edge
    for i=1:4
          FileName=MIJ.getCurrentTitle;
          CharFileName=char(FileName);
          if all(FileName=='Edges')
              if SaveEdge==1
                  MIJ.run("16-bit");
                  MIJ.run('Save', SaveCommanderedge);
%                   EdgeImage=MIJ.getCurrentImage;
              end
          elseif all(CharFileName(1:8)=='Symmetry')

          else
               
          end
          MIJ.run('Close')
    end
    EdgeImage=loadTifFast(edgename);
    OriginalImage=loadTifFast(filename);
    
    % save hdr
 
    % get the mask
    Cutoff=0;
    fudgeFactor=0.5;
    DilateThick=3;
    RemovePixelSize=100000;
    Clearborder=1;

    % mask original image and save
    Mask=EdgeDetection(EdgeImage,fudgeFactor,DilateThick,RemovePixelSize,Clearborder,Cutoff);
    OriginalImage=double(OriginalImage).*double(Mask);
    if SaveHDR==1
%         CurrentImage=MIJ.getCurrentImage;
        rgb=tonemap(double(OriginalImage));
        writeTifFast(hdrname,rgb,8) ;
    end
   
    writeTifFast(maskname,OriginalImage,16);
end
end

