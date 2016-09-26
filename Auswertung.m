clear
close all
clc
% exclude_ids = [47,79,106,114,172,184,198,203,283,331,441,444,917];
sicht = [61,47,685,730];
sichtbarkeit = [170,66,162,198,203,404,606,273,282,331,397,608,828];
[num,txt,raw] = xlsread('..\SonjasDaten.xlsx');
new_data = csvread('..\Neue Isovisten\results.csv');
[~,idx]=sort(new_data(:,1));
new_data = new_data(idx,:);
metrics = {'ID','Iso_num','Area','Perimeter','AreaPerimeterRatio','drift','mean_radial','stddev',...
    'maxradial','minradial','Dispersion','Circularity','Variance'};
new_data_cell =  mat2cell(new_data,size(new_data,1),ones(1,size(new_data,2)));
new_data = cell2struct(new_data_cell,metrics,2);

data = struct();
data_num = struct();
txt = strrep(txt(1,:),'.','_');
txt = strrep(txt(1,:),'ß','ss');
txt = strrep(txt(1,:),'ö','oe');
txt = strrep(txt(1,:),'$','');

for icol=1:size(num,2)
    if all(cellfun(@isnumeric,raw(2:end,icol)))
        data.(txt{1,icol})=cell2mat(raw(2:end,icol));
        data_num.(txt{1,icol})=cell2mat(raw(2:end,icol));
    else
        data.(txt{1,icol})=raw(2:end,icol);
    end
end

%% CHECK IF ID ORDER IS THE SAME
if not(isequal(data.VP_Nr,new_data.ID))
    error('IDs not equal')
end
%%
data_names = fieldnames(data);
reset_counter = 0;
updated_fields={};
not_updated_fields={};
for loopIndex = 1:numel(data_names)
    field_name = data_names{loopIndex};
    idx = find(cellfun(@(x) strcmp(x,field_name), fieldnames(new_data), 'UniformOutput', 1));
    if not(isempty(idx))
        data.(field_name) = new_data.(field_name);
        reset_counter = reset_counter +1;
        updated_fields{end+1} = field_name;
    else
        not_updated_fields{end+1} = field_name;
    end
end
sprintf('Updated %d data fields',reset_counter)
%%
% exclude_ids = setdiff(data.VP_Nr,new_data.ID)
% use_only = not(ismember(data.VP_Nr,exclude_ids));
use_only = ismember(data.VP_Nr,[sicht,sichtbarkeit]);
% writetable(struct2table(data),'new_results.xls')
data_results = rmfield(data,{'filter_','Vertrauen_18','KenntnisOrt_18','Zeit_18','Zustimmung_18','Verkehr_18','SchwereProblem_dreistufig_Sonja','Accidentswithin10m' ,'accumulatedinverseaccidentseverity','Commentswithin10m','Kategorie','VP_Nr'});

% uv = rmfield(data_results,updated_fields);
% av = getfields(data_results,updated_fields);
% a=struct2array(uv);
% a=a(use_only,:);
% b=struct2array(av);
% b=b(use_only,:);
data_array = struct2array(data_results);
data_array = data_array(use_only,:);
[r,p]=(corr([data_array]));
names = fieldnames(data_results);


%%
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

set(gca,'XTick',1:length(names),...                         %# Change the axes tick marks
    'XTickLabel',names,...  %#   and tick labels
    'YTick',1:length(names),...
    'YTickLabel',names,...
    'TickLength',[0 0],...
    'XTickLabelRotation',45,...
    'TickLabelInterpreter', 'none');

title('Correlation')
fig.PaperOrientation = 'landscape';
fig.PaperPosition = [1,0,30,20];
fig.PaperType = 'a4'



%%
fig=figure()
imagesc(p);            %# Create a colored plot of the matrix values
colorbar()
colormap(flipud(gray));  %# Change the colormap to gray (so higher values are
%#   black and lower values are white)

textStrings = num2str(p(:),'%0.2f');  %# Create strings from the matrix values
textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
[x,y] = meshgrid(1:sqrt(size(textStrings,1)));   %# Create x and y coordinates for the strings
hStrings = text(x(:),y(:),textStrings(:),...      %# Plot the strings
    'HorizontalAlignment','center');
midValue = mean(get(gca,'CLim'));  %# Get the middle value of the color range
textColors = repmat(p(:) > midValue,1,3);  %# Choose white or black for the
%#   text color of the strings so
%#   they can be easily seen over
%#   the background color
set(hStrings,{'Color'},num2cell(textColors,2));  %# Change the text colors

set(gca,'XTick',1:length(names),...                         %# Change the axes tick marks
    'XTickLabel',names,...  %#   and tick labels
    'YTick',1:length(names),...
    'YTickLabel',names,...
    'TickLength',[0 0],...
    'XTickLabelRotation',45,...
    'TickLabelInterpreter', 'none');

title('P-Value')

fig.PaperOrientation = 'landscape';
fig.PaperPosition = [1,0,30,20];


