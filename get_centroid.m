function [ centroid ] = get_centroid( centers )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
geom = polygeom(centers.x,centers.y);
centroid.x = geom(2);
centroid.y = geom(3);
end

