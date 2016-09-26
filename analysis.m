function [ output_args ] = analysis( data,field_names,radius,prefix)
%UNTITLED3 Summary of this function goes here
if nargin <4
    prefix='';
end

[r,p]=(corr(data));

% r = abs(r);
fig=figure();
imagesc(abs(r));            %# Create a colored plot of the matrix values
colorbar()
colormap(flipud(gray));  %# Change the colormap to gray (so higher values are
%#   black and lower values are white)

textStrings = num2str(r(:),'%0.2f');  %# Create strings from the matrix values
textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
[x,y] = meshgrid(1:sqrt(size(textStrings,1)));   %# Create x and y coordinates for the strings
hStrings = text(x(:),y(:),textStrings(:),...      %# Plot the strings
    'HorizontalAlignment','center');
midValue = mean(get(gca,'CLim'));  %# Get the middle value of the color range
textColors = repmat(r(:) > midValue,1,3);  %# Choose white or black for the
%#   text color of the strings so
%#   they can be easily seen over
%#   the background color
set(hStrings,{'Color'},num2cell(textColors,2));  %# Change the text colors

set(gca,...
    'XTick',1:length(field_names),...                         %# Change the axes tick marks
    'XTickLabel',field_names,...  %#   and tick labels
    'YTick',1:length(field_names),...
    'YTickLabel',field_names,...
    'TickLength',[0 0],...
    'XTickLabelRotation',45,...
    'TickLabelInterpreter', 'none');

title(sprintf('Correlation (r=%d m)',radius))
fig.PaperPosition = [1,0,30,20];
fig.PaperType = 'a4';
fig.PaperOrientation = 'landscape';
rectangle('Position',[2.5 16.5 11 1],'EdgeColor','r')
print([prefix,int2str(radius)],'-dpng')

% %%
% fig=figure()
% imagesc(p);            %# Create a colored plot of the matrix values
% colorbar()
% colormap(flipud(gray));  %# Change the colormap to gray (so higher values are
% %#   black and lower values are white)
% 
% textStrings = num2str(p(:),'%0.2f');  %# Create strings from the matrix values
% textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
% [x,y] = meshgrid(1:sqrt(size(textStrings,1)));   %# Create x and y coordinates for the strings
% hStrings = text(x(:),y(:),textStrings(:),...      %# Plot the strings
%     'HorizontalAlignment','center');
% midValue = mean(get(gca,'CLim'));  %# Get the middle value of the color range
% textColors = repmat(p(:) > midValue,1,3);  %# Choose white or black for the
% %#   text color of the strings so
% %#   they can be easily seen over
% %#   the background color
% set(hStrings,{'Color'},num2cell(textColors,2));  %# Change the text colors
% 
% set(gca,'XTick',1:length(field_names),...                         %# Change the axes tick marks
%     'XTickLabel',field_names,...  %#   and tick labels
%     'YTick',1:length(field_names),...
%     'YTickLabel',field_names,...
%     'TickLength',[0 0],...
%     'XTickLabelRotation',45,...
%     'TickLabelInterpreter', 'none');
% 
% title('P-Value')
% 
% fig.PaperOrientation = 'landscape';
% fig.PaperPosition = [1,0,30,20];




end

