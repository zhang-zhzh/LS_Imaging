function LastImageNum=DetectLastImageNum2(SaveFolder)
  Files=dir([SaveFolder,'Image2_*.tif']);
  
  if isempty(Files)
      LastImageNum=0;
      return;
  end
  for i=1:length(Files)
      FileName=Files(i).name;
      FileName=strsplit(FileName,'_');
      FileName=FileName{2};
      FileNameNum(i)=str2num(strrep(FileName,'.tif',''));
  end
  LastImageNum=max(FileNameNum);
end