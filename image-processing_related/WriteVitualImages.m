

for im=1:ImagesPerStack
    %% Start Imaging Blue
    if BlueImaging==1 
        % left imaging  
        if Ycycle-LeftImaging<RealJNow
            CreatName=[Folder,'\','ImageBlueLeft_',num2str(Stack),'_',num2str(im),'_',num2str(j),'_',num2str(i),'.tif'];
        end
        %right imaging
        if RightImaging>=RealJNow
            CreatName=[Folder,'\','ImageBlueRight_',num2str(Stack),'_',num2str(im),'_',num2str(j),'_',num2str(i),'.tif'];
        end
        % write image
        if exist(CreatName)
            display(['The file has already existed:',CreatName]);
        else
            VitualImageName{end+1}=CreatName;
            writeTifFast(CreatName,zeros(2048,2048),1);
        end
    end
end

for im=1:ImagesPerStack
    %% Start Imaging Red
    if RedImaging==1
         % left imaging  
        if Ycycle-LeftImaging<RealJNow
            CreatName=[Folder,'\','ImageRedLeft_',num2str(Stack),'_',num2str(im),'_',num2str(j),'_',num2str(i),'.tif'];
        end
        %right imaging
        if RightImaging>=RealJNow
            CreatName=[Folder,'\','ImageRedRight_',num2str(Stack),'_',num2str(im),'_',num2str(j),'_',num2str(i),'.tif'];
        end
        % write image
        if exist(CreatName)
            display(['The file has already existed:',CreatName]);
        else
            VitualImageName{end+1}=CreatName;
            writeTifFast(CreatName,zeros(2048,2048),1);
        end
    end

end

for im=1:ImagesPerStack
    %% Start Imaging Yellow
    if YellowImaging==1
         % left imaging  
        if Ycycle-LeftImaging<RealJNow
            CreatName=[Folder,'\','ImageYellowLeft_',num2str(Stack),'_',num2str(im),'_',num2str(j),'_',num2str(i),'.tif'];
        end
        %right imaging
        if RightImaging>=RealJNow
            CreatName=[Folder,'\','ImageYellowRight_',num2str(Stack),'_',num2str(im),'_',num2str(j),'_',num2str(i),'.tif'];
        end
        % write image
        if exist(CreatName)
            display(['The file has already existed:',CreatName]);
        else
            VitualImageName{end+1}=CreatName;
            writeTifFast(CreatName,zeros(2048,2048),1);
        end
    end
end