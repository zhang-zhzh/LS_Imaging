
% This function was used to change file name. The input file was produced by DecodingImagingIndex.m

% OriginalMovedRelationshipFile='D:\WholeBrainImagingData\20181220_WYDiI_RP4\Stack_8\OriginalFile_MovedFile.mat';
% Direction=1;0, normal; 1 reverse
function ToChangeName(OriginalMovedRelationshipFile,Direction)
   load(OriginalMovedRelationshipFile);
   
   Direction=1;
   if Direction==0
       for i=1:length(OriginalName)
            if exist(OriginalName{i})
                movefile(OriginalName{i},MovedName{i});
            else
                display(['Did not exist:',MovedName{i}]);
            end
       end
   elseif Direction==1
       for i=1:length(OriginalName)
           if exist(MovedName{i})
                movefile(MovedName{i},OriginalName{i});
           else
               display(['Did not exist:',MovedName{i}]);
           end
       end
   end
   
   
end