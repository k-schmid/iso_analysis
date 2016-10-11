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
statistics.category = zeros(size(statistics.scene));

cat1= [1,2,6,16,17,20,21];
cat2= [3,5,8,12,13,19,22];
cat3= [7,9,10,11,14,15,18];
scene2cat = 1:22;
scene2cat(cat1) = 1;
scene2cat(cat2) = 2;
scene2cat(cat3) = 3;
for scene=1:22
    scene_idx = statistics.scene == scene;
    cat = scene2cat(scene);
    statistics.category(scene_idx) = cat;
end

save([data_path,'iso_statistics.mat'],'statistics')