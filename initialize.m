function [params,mop,pop,state]= initialize(params,mop,pop,state)
    num_nod               = params.popsize;
    inds                  = randompoint(mop, num_nod);
    

    
    %% 评价每一个个体
    [inds,state]          = evaluate(inds,mop,state);
    v                     = [inds.objective];
    params.idealmin       = min(v,[],2);

    %% 种群初始化
    noval                 = v-repmat(params.idealmin,[1,num_nod]);
    team                  = group(params,pop,noval);
    for i=1:params.num_class
        num_p             = length(team{i});
        if num_p<=pop(i).num_ind
            tst                      = floor(num_nod*rand(1,pop(i).num_ind-num_p))+1;
            selind                   = inds([team{i},tst]);
            pop(i).inter             = selind;
        else
            selind                   = inds(team{i});
            pop(i).inter             = selection(params,selind,pop(i));
        end
    end 
    %% 初始化精英集
    if ( strcmpi(params.useArchive, 'yes'))
        nspop           = ndsort(params,[pop.inter]);
        state.archive   = nspop([nspop.rank]==1); 
    end 
end


%% 产生个体
function ind = randompoint(prob, n)
    if (nargin==1)
        n=1;
    end
    randarray = rand(prob.pd, n);
    lowend = prob.domain(:,1);
    span = prob.domain(:,2)-lowend;
    point = randarray.*(span(:,ones(1, n)))+ lowend(:,ones(1,n));
    cellpoints = num2cell(point, 1);
    indiv = get_structure('individual');
    ind = repmat(indiv, [1, n]);
    [ind.parameter] = cellpoints{:};
end

