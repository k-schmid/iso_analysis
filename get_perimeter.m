function [ perimeter ] = get_perimeter( centers )
%GET_PERIMETER Summary of this function goes here
%   Detailed explanation goes here
geom = polygeom(centers.x,centers.y);
perimeter = geom(4);
end

