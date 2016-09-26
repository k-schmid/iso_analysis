function [ out_struct ] = getfields( in_struct,field_names )
out_struct = struct();
all_names =  fieldnames(in_struct);
for i = 1:numel(field_names)
    field_name = field_names{i};
    if not(isempty(find(cellfun(@(x) strcmp(x,field_name), all_names, 'UniformOutput', 1))))
        out_struct.(field_name) = getfield(in_struct,field_name);
    end
end


end