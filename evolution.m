function [params,mop,pop,state]=evolution(params,mop,pop,state)

    % 1)杂交变异产生新子代
    params.delta          = (1- state.reg_obj/params.iteration)^0.7;
    [newpop,state]        = CMOp(params,mop,pop,state);
    
    % 2)通过选择算子得到新的种群
    [pop,params,state]    = extractPop(pop,newpop,params,state);   
end


%% 更新种群
function [pop,params,state] = extractPop(pop,newpop,params,state)
    
    % 更新方式   
     allind              = [pop.inter,newpop.inter];
     val                 = [allind.objective];
     num_nod             = size(val,2);
     params.idealmin     = min([params.idealmin,val],[],2);
     noval               = val-repmat(params.idealmin,[1,num_nod]);
     team                = group(params, pop, noval);
     for i=1:params.num_class
        num_p             = length(team{i});
        if num_p<=pop(i).num_ind
            tst                      = floor(num_nod*rand(1,pop(i).num_ind-num_p))+1;
            selind                   = allind([team{i},tst]);
            pop(i).inter             = selind;
        else
            selind                   = allind(team{i});
            pop(i).inter             = selection(params,selind,pop(i));
        end
     end
end




%% 产生子代
function [newpop,state] = CMOp(params,mop,pop,state)
    PM          = [pop.inter];
    newpop      = pop;
    for i=1:params.num_class
        newinter  = pop(i).inter;
        for j=1:pop(i).num_ind
            parent1=pop(i).inter(j);
            if rand>params.selectPro
                parent2  = PM(floor(rand*params.popsize)+1);
            else
                loc                 = floor(rand*pop(i).num_ind)+1;
                parent2             = pop(i).inter(loc);
            end
            childC                  = creChild(parent1,parent2,params,mop);
            childM                  = mutationOp(childC,params,mop);
            newinter(j)             = childM;
        end
        [newinter,state]            = evaluate(newinter,mop,state);
        newpop(i).inter             = newinter;
    end
end

%% 杂交算子
function childind = creChild(parent1,parent2,params,mop)
    childind = get_structure( 'individual' );
    x1       = parent1.parameter;
    x2       = parent2.parameter;
    range_x  = mop.domain;
    rnd      = 2*(1-rand^(-params.delta))*(rand-0.5);
    x_cld    = x1+rnd*(x2-x1);
    for i = 1:mop.pd   
        if x_cld(i) < range_x(i,1)
            x_cld(i) = range_x(i,1)+0.5*rand*(x1(i)-range_x(i,1));
        elseif x_cld(i) > range_x(i,2)
            x_cld(i) = range_x(i,2)-0.5*rand*(range_x(i,2)-x1(i));
        end
    end
    childind.parameter =x_cld;
end


%% 变异算子
function childC   = mutationOp(childC,params,mop)
    range_x  = mop.domain;
    x_cld   = childC.parameter;
    lst = find(rand(1,mop.pd) <= params.pmuta);
    len = length(lst);
    if len == 0
        len = 1;
        lst = floor(rand*mop.pd)+1;
    end
    for j = 1:len
        yl  = range_x(lst(j),1);
        yu  = range_x(lst(j),2);
        y   = x_cld(lst(j));
        rnd = 0.5*(rand-0.5)*(1-rand^(-params.delta));
        y   = y+rnd*(yu-yl);
        if y > yu
            y = yu-0.5*rand*(yu-x_cld(lst(j)));
        elseif y < yl
            y = yl+0.5*rand*(x_cld(lst(j))-yl);
        end
        x_cld(lst(j)) = y;
    end
    childC.parameter = x_cld;
end







