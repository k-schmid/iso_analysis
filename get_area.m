function [ area ] = get_area( centers )
%GET_AREA Summary of this function goes here
%   Detailed explanation goes here
geom = polygeom(centers.x,centers.y);
area = geom(1);
end

