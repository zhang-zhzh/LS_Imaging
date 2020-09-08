

Folder='H:\0811_YFP_CombinedStacks1_19\';
ImageSeriesNum=1:3193;
Files=dir([Folder,'*.tif']);
for i=ImageSeriesNum
    CurrentFileName=[Folder 'ImageBlue_1_' num2str(i) '.tif'];
    if i<10     
        MoveN=['00000' num2str(i)];
    elseif i>=10 & i<100
         MoveN=['0000' num2str(i)];
    elseif i>=100 & i<1000
         MoveN=['000' num2str(i)];
    elseif i>=1000 & i<10000
         MoveN=['00' num2str(i)];
    elseif i>=10000 & i<100000
         MoveN=['0' num2str(i)];
    end

    
    MoveToFileName=[Folder  MoveN '.tif']
    movefile(CurrentFileName,MoveToFileName)

end









