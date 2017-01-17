function ret = MockGlobal(key_,varargin)
    %用于伪实现全局变量(类似键值对)
    %key_       键
    %varargin   值
    %使用mat，mock_global_var.mat
    fileName = 'mock_global_var.mat';
    if exist(fileName,'file') == 2
        %文件存在，读文件
        map = load(fileName);
        map = map.map;
    else
        %文件不存在
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
    %退出前将文件进行保存
end