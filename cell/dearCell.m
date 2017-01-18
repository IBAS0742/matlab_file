function data_ = dearCell(type_,data,fn,varargin)
    %配合drawBeeShap.m文件一起使用
    %data       数据
    %type_      类型
    %               = 3 三角形
    %               = 4 正方形
    %               = 6 六角形
    %fn         对每一个元包的处理函数(example调用例子函数)
    %               这里仅将数据依次放入
    %varargin   边界数据默认值
    %               这里默认边界数据为0
    dearFn = {
                @forNone,
                @forNone,
                @forThree,
                @forFour,
                @forNone,
                @forSix
              };
    if (strcmp(class(fn),'char') == 1)
        fn = @exampleFn;
    elseif (strcmp(class(fn),'function_handle') == 0)
        fprintf(2,'处理函数无效.');
        return ;
    end

    dir = {
                [],
                [],
                [
                  0 1;1 1;1 0;0 -1;-1 0;-1 1;
                  0 1;1 0;1 -1;0 -1;-1 -1;-1 0
                ],
                [1 0;0 1;-1 0;0 -1],
                [],
                [
                  0 1;1 0;-1 0;
                  1 0;0 -1;-1 0
                ]
          };
    part = [
            0 0 2 1 0 2
        ];
    if (length(varargin) == 1)
        %for six
        data_ = forAll(data,fn,varargin{1},part(type_),type_,dir{type_});
        %data_ = dearFn{type_}(data,fn,varargin{1});
    else
        %for six
        data_ = forAll(data,fn,0,part(type_),type_,dir{type_});
        %data_ = dearFn{type_}(data,fn,0);
    end
end

%简单的处理函数
function data = exampleFn(data)
    data = mean(data);
end

function data = exampleFn_(data)
    sum = 0;
    co = 0;
    for i = 1 : length(data)
        if (data(i) ~= 0)
            co = co + 1;
            sum = sum + data(i);
        end
    end
    data = sum / co * 1.5;
end

function data_ = forNone(data,fn,b)
end

function data_ = forAll(data,fn,borderNum,mod_Number,base_Number,dir)
    %mod_Number     路径数量
    %base_Number    边的数量
    %dir            路径
    data_ = zeros(size(data));
    [h_,w_] = size(data);
    for i = 1 : h_
        d = mod(i,mod_Number) * base_Number;
        for j = 1 : w_
            cdata = [];
            for k = 1 : base_Number
                x = j + dir(k,1);
                y = i + dir(k,2);
                if (x < 1 || x > w_ || y < 1 || y > h_)
                    cdata(k) = borderNum;
                else
                    cdata(k) = data(x,y);
                end
            end
            data_(j,i) = fn(cdata);
        end
    end
end
?