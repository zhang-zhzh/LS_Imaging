function [ImAll,ImagesNumToStore]=GetImageFromCameraToMemoryAndDisk(ImagesPerStack,SaveFolder);
    ImagesNumAvailable=vid.FramesAvailable;
    LastImageNumReal=DetectLastImageNum(SaveFolder);
    if ImagesNumAvailable>ImagesPerStack
        ImagesNumToStore=ImagesPerStack;
    else
        ImagesNumToStore=ImagesNumAvailable;
    end
    
    if ImagesNumToStore<1
        return;
    end
    for n=1:ImagesNumToStore
        CurrentNum=LastImageNumReal+n;
        CurrentImName=[SaveFolder '\' 'Image1_' num2str(CurrentNum) '.tif'];
        im = getdata(vid);
        ImAll(:,:,n)=im;
        writeTifFast(CurrentImName,im,16);
    end
end