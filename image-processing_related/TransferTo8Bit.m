


function TransferTo8Bit(ImageName)
      im=loadTifFast(ImageName);       
      im=im/(2^16-1);
      TransferredNmae=strrep(ImageName,'.mat','_8Bit.mat');
      writeTifFast(TransferredNmae,im,8);
end