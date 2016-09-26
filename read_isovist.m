function [ iso,output ] = read_isovist( filename,radius )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


iso = rgb2gray(imread(filename));
[center.x,center.y] = find(iso==120);
[hsize,vsize] = size(iso);
Area = 0;
Perimeter = 0;
mean_radial_length = 0;
gravity_center_x = 0;
gravity_center_y = 0;
radials = [];

% compute Measurements
for y = 1:vsize-2
    for x = 1:hsize-2
        % Check if Pixel is within radius
        if sqrt((x-center.x)^2+(y-center.y)^2)> radius
            iso(x,y) = 0;
            continue
        end
        % Check if Pixel belongs to Isovist
        if (iso(x,y) == 0)
            continue
        end
        Area = Area + 1;
        % Check if Pixel belongs to Boundary
        if (x < 2 || x > hsize-1 || y < 2 || y > vsize - 1) ||...
                (iso(x-1,y) == 0 || iso(x+1,y) == 0 || iso(x,y-1) == 0 || iso(x,y+1) == 0)
            Perimeter = Perimeter + 1;
            dist = (y-center.y)^2 + (x-center.x)^2;
            dist = sqrt(dist);
            mean_radial_length = mean_radial_length+ dist;
            radials(end+1) = dist;
            gravity_center_x = gravity_center_x + x;
            gravity_center_y = gravity_center_y + y;
        end
    end
end

% standart deviation
mean_radial = mean_radial_length/Perimeter;
std_dev = 0;
min_rad = 9999999;
max_rad = -1;

gravity_center_x = gravity_center_x/Perimeter;
gravity_center_y = gravity_center_y/Perimeter;


drift = (gravity_center_x - center.x) * (gravity_center_x - center.x);
drift = drift + (gravity_center_y - center.y) * (gravity_center_y - center.y);
drift = sqrt(drift);

for it = radials
    std_dev = std_dev + (it-mean_radial) * (it-mean_radial);
    if (it > max_rad)
        max_rad = it;
    end
    if (it < min_rad)
        min_rad = it;
    end
end
std_dev = std_dev / Perimeter;
std_dev = sqrt(std_dev);

Dispersion = mean_radial-std_dev;
Circularity = (3.1415*mean_radial*mean_radial)/Area;
Variance =  std_dev*std_dev;
output = [Area,Perimeter,(Area/Perimeter),drift,mean_radial,std_dev,max_rad,min_rad,Dispersion,Circularity,Variance];

end

