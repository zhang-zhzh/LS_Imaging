

for i=1:13
    for j=1:20
        ImMaxProjection=[];

        FolderA=['L:\20191118_Y34_TM_Copy\Stack_' num2str(i)  '\StitchedTiff\'];
        FolderP=['L:\20191118_Y34_TM_Copy\Stack_' num2str(i+1)  '\StitchedTiff\'];
        FolderNew=[FolderP,'\MergeImages\'];
        mkdir(FolderNew);
        
        
        ImP=loadTifFast([FolderP,'\','ImageBlue_1_' num2str(j) '_Stitched.tif']);
        
        if isempty(ImMaxProjection)
            ImMaxProjection=ImP;
        end
        
        ImMaxProjection=cat(3,ImMaxProjection,ImP);
        ImMaxProjection=max(ImMaxProjection,[],3);
        
        ImA=loadTifFast([FolderA,'\','ImageBlue_1_' num2str(j+180) '_Stitched.tif']);
        ImMaxProjection=cat(3,ImMaxProjection,ImA);
        ImMaxProjection=max(ImMaxProjection,[],3);
        
%         subplot(1,3,1);imshow(ImA,[]);subplot(1,3,2);imshow(ImP,[]);subplot(1,3,3);imshow(ImMaxProjection,[]);
        
        writeTifFast([FolderNew,'\','ImageBlue_1_' num2str(j) '_Stitched.tif'],ImMaxProjection,16);
    end

end
