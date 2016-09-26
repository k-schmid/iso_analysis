function [ all_statistics ] = save_intersection_iso_stats( folder_path,layer_of_interest,center_statistic )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% Get a list of all files and folders in this folder.
files = dir(folder_path);
% Get a logical vector that tells which is a directory.
dirFlags = [files.isdir];
% Extract only those that are directories.
subFolders = files(dirFlags);

folderNames = {subFolders.('name')};
folderIdx = cellfun(@str2num,folderNames,'un',0);
%Check for none numeric folder names (which are ignored)
numericValue = ~cell2mat(cellfun(@isempty,folderIdx,'un',0));
% Remove none numeric folder names and change to array
folderIdx = cell2mat(folderIdx);
[~,idx] = sort(folderIdx);

%Remove first folders with non numeric names and sort afterwards
subFolders = subFolders(numericValue);
subFolders = subFolders(idx);

numFolder = length(subFolders);
all_statistics = struct();
for image_id = 1:numFolder
    subFolder = subFolders(image_id);
    subFolderPath = [folder_path subFolder.name];
    loaded_data = load(sprintf('%s/cloud_preprocessed_%d.mat',subFolderPath,layer_of_interest));
    centers = loaded_data.centers.(center_statistic);
    statistics = get_iso_statistics(centers);
    all_fieldnames = fieldnames(statistics);
    if image_id == 1
        all_statistics = statistics;
        all_statistics.image_id = ones(length(statistics.(all_fieldnames{1})),1);
    else
        for j = 1:length(all_fieldnames)
            fieldname = all_fieldnames{j};
            all_statistics.(fieldname) = [all_statistics.(fieldname);statistics.(fieldname)];
            
        end
        all_statistics.image_id = [all_statistics.image_id; ones(length(statistics.(all_fieldnames{1})),1)*image_id];
    end
    save(sprintf('%s/statistics.mat',subFolderPath),'statistics')
end

end

