function [ stats ] = get_iso_statistics( centers )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
stats.centroid = get_centroid(centers);
stats.area = get_area(centers);
stats.perimeter = get_perimeter(centers);
stats.area_perimeter_ratio = stats.area/stats.perimeter;
stats.drift = sqrt(stats.centroid.x^2+stats.centroid.y^2);
radials = sqrt(centers.x .*centers.x + centers.y .*centers.y);
stats.mean_radial = mean(radials);
stats.stddev = std(radials);
stats.max_radial = max(radials);
stats.min_radial = min(radials);
stats.dispersion = stats.mean_radial - stats.stddev;
stats.circularity = (pi * stats.mean_radial^2) / stats.area ;
stats.variance = sqrt(stats.stddev);

end

