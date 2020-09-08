% this function was used to decoding the name of images got from imagingV(z stacks)


if ColorNow==1 
    % left imaging  
    if Ycycle-LeftImaging<RealJNow
        NameNow=[Folder,'\','Image',num2str(s),'_',num2str(ImNum),'.tif'];
        ChangedName=[Folder,'\','ImageBlueLeft4x_',num2str(Stack),'_',num2str(im),'_',num2str(j),'_',num2str(i),'.tif'];
        if ImNum>EndImageNow
            copyfile(LastChangeName_1L,ChangedName);
        else
            if ImNum==EndImageNow
                LastChangeName_1L=ChangedName;
            end

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
        end
        ImNum=ImNum+1;
    end
    %right imaging
    if RightImaging>=RealJNow
        NameNow=[Folder,'\','Image',num2str(s),'_',num2str(ImNum),'.tif'];
        ChangedName=[Folder,'\','ImageBlueRight4x_',num2str(Stack),'_',num2str(im),'_',num2str(j),'_',num2str(i),'.tif'];
        if ImNum>EndImageNow
            copyfile(LastChangeName_1R,ChangedName);
        else
            if ImNum==EndImageNow
                LastChangeName_1R=ChangedName;
            end
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
        end
        ImNum=ImNum+1;
    end
end




%% Start Imaging Yellow
if ColorNow==2
    % left imaging  
    if Ycycle-LeftImaging<RealJNow
        NameNow=[Folder,'\','Image',num2str(s),'_',num2str(ImNum),'.tif'];
        ChangedName=[Folder,'\','ImageYellowLeft4x_',num2str(Stack),'_',num2str(im),'_',num2str(j),'_',num2str(i),'.tif'];
        if ImNum>EndImageNow
            copyfile(LastChangeName_2L,ChangedName);
        else
           if ImNum==EndImageNow
                LastChangeName_2L=ChangedName;
           end
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
        end
        ImNum=ImNum+1;
    end
    %right imaging
    if RightImaging>=RealJNow
        NameNow=[Folder,'\','Image',num2str(s),'_',num2str(ImNum),'.tif'];
        ChangedName=[Folder,'\','ImageYellowRight4x_',num2str(Stack),'_',num2str(im),'_',num2str(j),'_',num2str(i),'.tif'];
        if ImNum>EndImageNow
            copyfile(LastChangeName_2R,ChangedName);
        else
           if ImNum==EndImageNow
                LastChangeName_2R=ChangedName;
           end
        
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
        end
        ImNum=ImNum+1;
    end
end



%% Start Imaging Red
if ColorNow==3
    % left imaging  
    if Ycycle-LeftImaging<RealJNow
        NameNow=[Folder,'\','Image',num2str(s),'_',num2str(ImNum),'.tif'];
        ChangedName=[Folder,'\','ImageRedLeft4x_',num2str(Stack),'_',num2str(im),'_',num2str(j),'_',num2str(i),'.tif'];
        if ImNum>EndImageNow
            copyfile(LastChangeName_3L,ChangedName);
        else
           if ImNum==EndImageNow
                LastChangeName_3L=ChangedName;
           end
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
        end
        ImNum=ImNum+1;
    end
    %right imaging
    if RightImaging>=RealJNow
        NameNow=[Folder,'\','Image',num2str(s),'_',num2str(ImNum),'.tif'];
        ChangedName=[Folder,'\','ImageRedRight4x_',num2str(Stack),'_',num2str(im),'_',num2str(j),'_',num2str(i),'.tif'];
        if ImNum>EndImageNow
            copyfile(LastChangeName_3R,ChangedName);
        else
            if ImNum==EndImageNow
                LastChangeName_3R=ChangedName;
            end
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
        end
        ImNum=ImNum+1;
    end
end