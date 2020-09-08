% this function was used to decoding the name of images got from imagingV (z stacks)

if BlueImaging==1 
    % left imaging  
    if Ycycle-LeftImaging<j
        NameNow=[Folder,'\','Image',num2str(s),'_',num2str(ImNum),'.tif'];
        ChangedName=[Folder,'\','ImageBlueLeft_',num2str(Stack),'_',num2str(im),'_',num2str(j),'_',num2str(i),'.tif'];
        
        if exist(ChangedName)
            display(['The file has already existed:',ChangedName]);
        end
        if exist(NameNow)
            if Move==1
                movefile(NameNow,ChangedName);
            end
            OriginalName{ImNum}=NameNow;
            MovedName{ImNum}=ChangedName;
        else
            display(['Did not exist:',NameNow])
        end
        ImNum=ImNum+1;
    end
    %right imaging
    if RightImaging>=j
        NameNow=[Folder,'\','Image',num2str(s),'_',num2str(ImNum),'.tif'];
        ChangedName=[Folder,'\','ImageBlueRight_',num2str(Stack),'_',num2str(im),'_',num2str(j),'_',num2str(i),'.tif'];
        if exist(ChangedName)
            display(['The file has already existed:',ChangedName]);
        end
        if exist(NameNow)
            if Move==1
                movefile(NameNow,ChangedName);
            end
            OriginalName{ImNum}=NameNow;
            MovedName{ImNum}=ChangedName;
        else
            display(['Did not exist:',NameNow])
        end
        ImNum=ImNum+1;
    end
end

%% Start Imaging Red
if RedImaging==1
    % left imaging  
    if Ycycle-LeftImaging<j
        NameNow=[Folder,'\','Image',num2str(s),'_',num2str(ImNum),'.tif'];
        ChangedName=[Folder,'\','ImageRedLeft_',num2str(Stack),'_',num2str(im),'_',num2str(j),'_',num2str(i),'.tif'];
        if exist(ChangedName)
            display(['The file has already existed:',ChangedName]);
        end
        
        if exist(NameNow)
            if Move==1
                movefile(NameNow,ChangedName);
            end
            OriginalName{ImNum}=NameNow;
            MovedName{ImNum}=ChangedName;
        else
            display(['Did not exist:',NameNow])
        end
        ImNum=ImNum+1;
    end
    %right imaging
    if RightImaging>=j
        NameNow=[Folder,'\','Image',num2str(s),'_',num2str(ImNum),'.tif'];
        ChangedName=[Folder,'\','ImageRedRight_',num2str(Stack),'_',num2str(im),'_',num2str(j),'_',num2str(i),'.tif'];
        if exist(ChangedName)
            display(['The file has already existed:',ChangedName]);
        end
        
        if exist(NameNow)
            if Move==1
                movefile(NameNow,ChangedName);
            end
            OriginalName{ImNum}=NameNow;
            MovedName{ImNum}=ChangedName;
        else
            display(['Did not exist:',NameNow])
        end
        ImNum=ImNum+1;
    end
end


%% Start Imaging Yellow
if YellowImaging==1
    % left imaging  
    if Ycycle-LeftImaging<j 
        NameNow=[Folder,'\','Image',num2str(s),'_',num2str(ImNum),'.tif'];
        ChangedName=[Folder,'\','ImageYellowLeft_',num2str(Stack),'_',num2str(im),'_',num2str(j),'_',num2str(i),'.tif'];
        if exist(ChangedName)
            display(['The file has already existed:',ChangedName]);
        end
        
        if exist(NameNow)
            if Move==1
                movefile(NameNow,ChangedName);
            end
            OriginalName{ImNum}=NameNow;
            MovedName{ImNum}=ChangedName;
        else
            display(['Did not exist:',NameNow])
        end
        ImNum=ImNum+1;
    end
    %right imaging
    if RightImaging>=j
        NameNow=[Folder,'\','Image',num2str(s),'_',num2str(ImNum),'.tif'];
        ChangedName=[Folder,'\','ImageYellowRight_',num2str(Stack),'_',num2str(im),'_',num2str(j),'_',num2str(i),'.tif'];
        if exist(ChangedName)
            display(['The file has already existed:',ChangedName]);
        end
        if exist(NameNow)
            if Move==1
                movefile(NameNow,ChangedName);
            end
            OriginalName{ImNum}=NameNow;
            MovedName{ImNum}=ChangedName;
        else
            display(['Did not exist:',NameNow])
        end
        ImNum=ImNum+1;
    end
end
