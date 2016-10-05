clear
close all
clc
addpath('..');
%% default settings
layer_of_interest = 8;
center_statistic = 'median';
statistics = struct();

data_path = get_dataPath();
for intersections = 1:22
    centers_path = [data_path int2str(intersections) '/'];
    fprintf('Intersection %d\n',intersections)
    statistics_intersection = save_intersection_iso_stats(centers_path,center_statistic);
    
    all_fieldnames = fieldnames(statistics_intersection);
    if intersections == 1
        statistics = statistics_intersection;
        statistics.scene = ones(length(statistics_intersection.(all_fieldnames{1})),1);
    else
        for j = 1:length(all_fieldnames)
            fieldname = all_fieldnames{j};
            statistics.(fieldname) = [statistics.(fieldname);statistics_intersection.(fieldname)];
            
        end
        statistics.scene = [statistics.scene; ones(length(statistics_intersection.(all_fieldnames{1})),1)*intersections];
    end
end
save(sprintf('%s iso_statistics.mat',data_path),'statistics')