function ret = MockGlobal(key_,varargin)
    %����αʵ��ȫ�ֱ���(���Ƽ�ֵ��)
    %key_       ��
    %varargin   ֵ
    %ʹ��mat��mock_global_var.mat
    fileName = 'mock_global_var.mat';
    if exist(fileName,'file') == 2
        %�ļ����ڣ����ļ�
        map = load(fileName);
        map = map.map;
    else
        %�ļ�������
        map = containers.Map();
    end
    if isempty(varargin) == 0
        ret = varargin{1};
        map(key_) = varargin{1};
    else
        if (map.isKey(key_) == 1)
            ret = map(key_);
        else
            ret = [];
            fprintf(2,'key_ is not exist .\r\n');
        end
    end
    save mock_global_var map
    %�˳�ǰ���ļ����б���
end