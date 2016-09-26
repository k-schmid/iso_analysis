clear
close all
clc

%% default settings
layer_of_interest = 8;
center_statistic = 'median';

parfor intersections = 1:22
    centers_path = ['../data/' int2str(intersections) '/'];
    fprintf('Intersection %d\n',intersections)
    save_intersection_iso_stats(centers_path,layer_of_interest,center_statistic);
    
end