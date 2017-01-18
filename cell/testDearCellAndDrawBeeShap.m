%testDearCellAndDrawBeeShap(5,4,1000,0.01)
function testDearCellAndDrawBeeShap(n,base,times,timespan,varargin)
    %
    %绘制        n * n
    %base       边数
    %times      次数
    %timespan   时间间隔
    %varargin   数据
    close all;
    if (length(varargin) > 0)
        data = varargin{1};
    else
        data = ones(n);
        for i = 1 : n
            data(i,:) = data(i,:) * i;
        end
    end
    drawBeeShap(0,1,base,5,data,1,1);
    for i = 1 : times
        data = dearCell(base,data,'example');
        drawBeeShap(0,1,base,5,data,1,1);
        pause(timespan);
        clf('reset');
    end
    drawBeeShap(0,1,base,5,data,1,1);
end��