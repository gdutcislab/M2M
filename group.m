%分区域方法
function team = group(params, pop, nornal_obj)
    team              = cell(params.num_class,1);
    num_p             = size(nornal_obj,2);
    center            = [pop.center];
    dis               = center'*nornal_obj;  
    [minval,minindex] = max(dis,[],1);
    for i = 1:num_p
        team{minindex(i)}   = [team{minindex(i)},i];
    end
end
