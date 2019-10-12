function str = get_structure( name )
switch name 
    % state: optimization state of one generation
    case 'state'
    str = struct(...
          'currentGen', 1,...         % current generation number
          'reg_obj', 0,...            % number of objective function evaluation
          'totalTime', 0,...          % total time from the beginning
          'stopCriterion',1,...       % ��ֹ����
          'val_IGD',[],...            % �����IGD��ֵ
          'val_H',[],...              % ��ǰ��H��ֵ
          'archive',[]);              % ��Ӣ��              
      
    case 'individual' 
        str = struct(...
            ...%%%%%%%%%%%%%%%%%%%%%%%%%%%�����ʽ�Ĳ�����
            'parameter',[],...            %parameter���Ա�����
            'objective',[],...            %objective��Ŀ�꺯�� 
            ...%%%%%%%%%%%%%%%%%%%%%%%%%%%˽�в���������ض��㷨��
            ...%%%%%%%%%%%%%%%%%����֧���ϵ���㷨
            'rank',[],...                 %�����rank����֧���������õ�
            'distance',[],...             %ӵ�����룬��֧�������㷨���õ�
            ...%%%%%%%%%%%%%%%%����ָ����㷨
            'inValue',[]);                %ָ��ֵ           

    case 'parameter'
        str = struct(...
            ...%%%%%%%%%%%%%%%%%%%%%%%%%%%���в���
            'popsize',[],...              % popsize����Ⱥ��ģ
            'isCauIGD','yes',...          % �Ƿ����IGD
            'isDebug',1,...               % �Ƿ��ǵ��԰汾��1��0��
            'resultOut','save',...        % ����������ʽ���Ǳ��滹����ʾ
            'iteration',[],...            % iteration���Ŀ�꺯���ļ������
            'PFStar',[],...               % ��Ч��������ʵ�ľ��ȷֲ��ĵ�
            'isCauH','yes',...            % �Ƿ����H����ֵ 
            'useArchive','no',...         % �Ƿ�Ծ�Ӣ�����д浵
            ...%%%%%%%%%%%%%%%%%%%%%%%%%%%˽�в���
            ...%%%%%%%%%%%%������Ͳ��м���Ĳ���
            'num_class',[],...            % num_class���������Ŀ
            ...%%%%%%%%%%%%�ӽ������ֵĲ���
            'pmuta',[],...                % pmuta����ĸ��ʣ�
            'delta',[],...                % delta�ӽ�����ʱ��ģ���˻����ӣ�
            'selectPro',0.7,...           % ��ôѡ������ӽ�����ĸ��壬�ڷ������㷨���õ� 
            ...%%%%%%%%%%%%ѡ�������õ��Ĳ���
            'selectMethod','MM',...       % ѡ��ʽ����NS����nsga-II��ѡ��ʽ��
            ...                           %'WS'��Ȩ��ѡ��ʽ����MM������Сѡ��ʽ
            ...                           % 'VEGA����vega��ѡ��ʽ
            ...%%%%%%%%%%%%�ڻ���Ȩ��ѡ���㷨���õ���Ȩ�ز���
            'idealmin',[],...              % ��ĿǰΪֹ�����ֵ���Сֵ
            'useWeight','yes',...          % �Ƿ���ҪȨ��
            'weight',[],...                % ����Ӧ��Ȩ��
            ...%%%%%%%%%%%��hype���õ��Ĳ���
            'reference',[]);               % ����H-valueʱ�õ��Ĳο���          
            
    case 'testmop'
         str = struct(...
             'name',[],...                %name�ǲ��Ժ��������ƣ�
             'od',[],...                  %od��Ŀ�꺯����ά����
             'pd',[],...                  %pd���Ա�����ά����
             'domain',[],...              %domain���Ա�����ȡֵ��Χ
             'func',[]);                  %func�ǲ��Ժ���
                                        

    case 'subclass' 
        str = struct(...
            ...%%%%%%%%%%%%%%%%%%%%%%%%%%%���в���
            'center',[],...               %center�������������
            'inter',[],...                %inter������Ⱥ
            'num_ind',[],...              % num_ind����Ⱥ�Ĺ�ģ
            ...%%%%%%%%%%%%%%%%%%%%%%%%%%%˽�в���
            ...%%%%%%%%%%%%%%����Ȩ�����ѡ�����ӵ�Ȩ�ز���
            'weight',[]);               % ÿ������Ⱥ��Ȩ��
      
    otherwise
        error('the structure name requried does not exist!');

end