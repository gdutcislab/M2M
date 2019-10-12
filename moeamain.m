
%% 测试函数集合
clear; close; clc;                            %  1-7 
name_func  = {'MOP1','MOP2','MOP3','MOP4','MOP5','MOP6','MOP7'};
    %% 算法初始化
    for seq =7:7
        for nrun=1:1
            name_f   = char(name_func(seq));
            seed     = 60+nrun;randn('state',seed);rand('state',seed);
            state    = get_structure( 'state');
            params   = get_structure( 'parameter');
            [params,mop,pop]=inputparams(name_f,params);
            [params,mop,pop,state]=initialize(params,mop,pop,state); 
            while state.stopCriterion 
                [params,mop,pop,state]=evolution(params,mop,pop,state);
                % 当前状态输出
                state=stateOutput(state,params,pop,mop,nrun);
                fprintf('gen =   %d\n',state.currentGen);           
                state.currentGen=state.currentGen+1;
                % 检测是否终止
                state  = checkstop(params,state);
            end
            state=stateOutput(state,params,pop,mop,nrun);
        end
    end




  