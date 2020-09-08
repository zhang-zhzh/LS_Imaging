
function [dirOutput] = getAllFilenames(filePattern)
% Function: Get all file information (filenames) of the same directory, and sort by date.
    dirOutput = dir(filePattern);
    [~, ind] = sort([dirOutput(:).datenum], 'ascend');
    dirOutput = dirOutput(ind);
end

