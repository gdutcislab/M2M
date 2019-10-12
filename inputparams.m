function [params,mop,pop]=inputparams(name_f,params)
    
    % 1）初始化真是的有效界面
    if( strcmpi(params.isCauIGD, 'yes'))
        PFStar   = load(strcat('PFStar/pf_',name_f,'.dat'));
        params.PFStar   =  PFStar';
    end
    
    % 2)初始化种群规模，最大进化代数，子种群的数目
    mop           = testmop(name_f);
    [params,mop]  = inputparameter(params,mop);
    
    
    % 4)初始化权重
    if( strcmpi(params.useWeight, 'yes'))
        val_w                  = Weight(params.popsize,mop.od);
        val_w                  = val_w./repmat(sqrt(sum(val_w.^2)),[mop.od,1]);
        params.weight          = val_w;
        params.popsize         = size(val_w,2);
    end
    
    % 5)初始化中心点和子种群的中心规模
    val_cp                 = Weight(params.num_class,mop.od);
    center                 = val_cp./repmat(sqrt(sum(val_cp.^2)),[mop.od,1]);
    params.num_class       = size(center,2);
    sub                    = get_structure('subclass');
    pop                    = repmat(sub, [1,params.num_class]);
    for i=1:params.num_class
        pop(i).center         = center(:,i);
    end

    if( strcmpi(params.useWeight, 'yes'))
        team                           = group(params,pop,val_w);
        for i=1:params.num_class
            pop(i).weight         = 1./val_w(:,team{i});
            pop(i).num_ind        = length(team{i});
        end
    else
        temv1     = mod(params.popsize,params.num_class);
        temv2     = floor(params.popsize/params.num_class);
        for i=1:temv1
            pop(i).num_ind=temv2+1;
        end
        for i=temv1+1:params.num_class
            pop(i).num_ind=temv2;
        end
    end   
    params.pmuta           = 1/mop.pd;
    params.idealmin        = 1000000000000*ones(mop.od,1);    
end



function [params,mop]=inputparameter(params,mop)
    switch upper(mop.name)
      case {'MOP1','MOP2','MOP3','MOP4','MOP5'}
            params.iteration   = 300000;
            params.num_class   = 10;
            params.popsize     = 100;
      case {'MOP6','MOP7'}
            params.num_class   = 30;
            params.iteration   = 900000;
            params.popsize     = 300;       
    end 
end

function val_w = Weight(popsize,objDim)
    if objDim==2
        start      = 1/(popsize*100000);
        val_w(1,:) = linspace(start,1-start,popsize);
        val_w(2,:) = ones(1,popsize)-val_w(1,:);
    elseif objDim==3
        val_w = lhsdesign(popsize, 3, 'criterion','maximin')';
    end
end

