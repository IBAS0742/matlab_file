%考虑两种车型（大小分别为宽度一致，长度为a和2a）（已删除）
%速度随机但是基本差不多(默认为单元格倍数)
%大车靠边行驶(美国靠右行驶）
%各种车的变换车道的概率(不考虑)
%出现事故的概率（很低）
%刹车的考虑（有减速区）
%元胞还是模拟元胞（元胞）
%这里有一点，收费口有长度，进入到收费口后不允许变道
%这里使用了不清理垃圾的内存使用，仅仅改变每一个元胞的car属性来改变一个元胞的类型
%每一个元胞是一个信息单位
%这里有一点无法量化，车的长度，车的速度，以及每一个时间内车的行进（尽管是一个s=vt）
%这里不模拟不同车辆了，仅仅模拟一种车辆的行进（整体程序将不再适用函数createCar_）
%这里有一个奇怪的条件，就是，当限定了车辆的通过收费口类型后，变道会变得很奇怪
%		1.当前方无法完成收费时，并且又因为道路的原因无法变道，是否强制停车还是强制变道
%		2.当车辆被迫驶入无法完成收费的路口后应该如何设定他们的通过时间或者是否仅仅加入延迟来进行模拟
%	对该问题程序中实现：
%		1.当车辆进入收费站前，提前设定每一个车道上车辆的情况，使驶入车辆尽快的往目的收费口行进
%		2.当发生上述1中的情况后保持前行，并且尽可能择机变道
%		3.当发生上述2中的情况后，增加延时来继续模拟
%		4.当发生堵车后，不限道行驶（但是这里的另一个问题是如何判断堵车）
%		5.增加的延时加入到cell.toll的curTime中(即将其变为更小的数值，因为该变量使用累加)
%			(另外curTime为计数器，当值为toll.waitTime时，表示计时结束，车辆可以驶离)
%			***如何判断堵车
%			1.这里的解决方案是使用以上条件默认不进行堵车判断

%cell.type_     : 一共有八种类型
%                   -x.边界,总共有四种情况，分别表示每一个三角形的朝向 (其中包含有边界的信息.width和.height)
%                                -1 往右下 -2往左下 -3 往右上 -4 往左上
%                               （第一次绘制结束后直接转换为外边界，不需要总是重新绘制）
%                    0.外边界
%                    1.入口，
%                    2.广场（可变化车道），
%                    3.收费口前（不可变换车道），
%                    4.收费口，
%                    5.出车道（限制可变换车道），
%                    6.出车道（可变换车道）（这里感觉可以不进行考虑了）
%cell.car       : 车辆信息{0.没有车辆，1.有车辆，2.车尾}（这里暂时保留该参数，但是将无意义）（判断的优先级高于carinfo）
%cell.carinfo   : 根据cell.car 为 1 时才有具体信息
%cell.delay     : 时延（收费口有固定的时延，事故点也有固定时延，其他暂时设定为没有）（已删除）
%cell.count     : 前方车辆数量（这里仅仅计算收费口内，每次刷新）（默认为零）
%cell.toll      : 当类型为收费口时有值
%cell.fDir		: 优先变道方向(0为无优先，1为优先往上变道，-1为优先往下变道)
%cell.forceDir	: 强制只能变道的方向(0为无限制，1为限制往上变道，-1为限制往下变道)
%cell.clock		: 撞车的周转时间
%cell.count		: 记录当前位置的车的数量

%一些全局应该默认的参数
%tollType = { 1 人工收费	2 刷卡收费	 3 etc 收费}
%tollServiceTime % 收费服务时间
%close all;[d,c] = cellMock(3,3,20,20,3,3,4,3,10,1,1,1000,ones(1,10),0.8,[0.2 0.5 0.3],1);
%close all;cellMock(1,1,2,2,0,0,1,2,4,1,1,1000,ones(1,10),0.8,[0.2 0.5 0.3],1)
%%%%%%%%%%%%%%样例%%%%%%%%%%%%%
%        list = [3 3 1 1 1];
%        [
%            data                ,...
%            totalBlock          ,...
%            outNumber_          ,...
%            tollCarNumber_      ,...
%            totalTollCarNumber_ ,...
%            crashNumber_        ,...
%            totalTime_          ...
%        ] = ...
%        cellMock(3      		,...   %* the number of the lanes (Entrance)
%                 3      		,...   %* the number of the lanes (Exit)
%                 15     		,...   %* the length of the square (Entrance)
%                 j          	,...   %* the length of the square (Exit)
%                 0      		,...   %* 入口广场的水平距离
%                 6             ,...   %* 出口广场的水平距离
%                 13     		,...   %* the max length of the queue before the toll(disagree change lanes)
%                 3      		,...   %* the number of the lanes
%                 5      		,...   %* the number of the toll
%                 2      		,...   %* the shap of the square(Entrance)
%                 1      		,...   %* the shap of the square(Exit)(?)
%                 1000			,...   %* the times of the simulation
%                 list       	,...   %* the type of everyone of the toll(bottom to up)
%                 .72			,...   % 到达概率
%                 [0 .7 .3]     ,...   % 各种类型的车辆的概率(人工、自动、etc)%the probability of the type of the toll gate that a vehicle can pass through
%                 -1            ,...   %
%                 1             ...    %* 是否将过程绘制出来(1绘制，0不绘制)
%                 );

function [data,totalBlock,outNumber_,tollCarNumber_,totalTollCarNumber_,crashNumber_,totalTime_] = ...
    cellMock(inPathLen		,...   %进入路口的车道数量
             outPathLen		,...   %出口车道数量
             inSquare		,...   %入口广场长度
             outSquare		,...   %出口广场长度
             inHerLen		,...   %入口广场的水平距离
             outHerLen		,...   %出口广场的水平距离
             queueLen		,...   %排队长度（收费口前不能变道路段长度）
             lanNumber		,...   %高速路单向的车道数量
             tollNumber		,...   %收费口数量
             inType			,...   %入口的形状(v u c)
             outType		,...   %出口的形状(v u c)
             times			,...   %模拟次数
             tollTypeList	,...   %the type of everyone of the toll(bottom to up)
			 lamda			,...   %到达概率
			 carTypeRate	,...   %各种类型的车辆的概率(人工、自动、etc)%the probability of the type of the toll gate that a vehicle can pass through
             detaDis        ,...   %使用出入口形状设置为-1，否则不使用设置为正整数为偏移
             isDrawResult   ,...   %是否将过程绘制出来(1绘制，0不绘制) 
             varargin		...    %显示变道规则
             )
	%初始化
	if (length(varargin) > 0)
		[data,totalBlock,leftTop] = intiData(inPathLen,outPathLen,inSquare,outSquare,inHerLen,outHerLen,queueLen,lanNumber,tollNumber,inType,outType,tollTypeList,detaDis,1);
	else
		[data,totalBlock,leftTop] = intiData(inPathLen,outPathLen,inSquare,outSquare,inHerLen,outHerLen,queueLen,lanNumber,tollNumber,inType,outType,tollTypeList,detaDis);
    end
    if isDrawResult == 1
        [h_,w_] = size(data);
        figure('position',[100 100 w_ * 20 h_ * 20]);
        axis off;
    	drawMap(data);
    end
    outNumber_ = [];
    tollCarNumber_ = [];
    totalTollCarNumber_ = [];
    crashNumber_ = [];
	totalTime_ = [];
    index = 0;
    %开始模拟
    tr_ = [];
	while times ~= 0
		index = index + 1;
		times = times - 1;
		if times < 0
			times = -1;
		end
		%创建并添加车辆
        n_ = poissrnd(lamda);
		for i = 1 : lanNumber
			if (data(i + leftTop,1).car == 0)
				if poissrnd(lamda) >= 1
					data(i + leftTop,1) = createCar(data(i + leftTop,1),0,carTypeRate,index);
				end
			end
        end
        if isDrawResult == 1
            drawMap(data);
            pause(0.01);
        end
		%前进一步
		[data,outNumber,tollCarNumber,crashNumber,totalTime] = forward(data,tollTypeList,index);
		%处理
        outNumber_(index) = outNumber;
        tollCarNumber_(:,index) = tollCarNumber;
        totalTollCarNumber_(index) = sum(tollCarNumber);
        crashNumber_(index) = crashNumber;
		if outNumber == 0
			totalTime_(index) = 0;
		else
			totalTime_(index) = totalTime / outNumber;
		end
        tr(:,index) = calculCarType(data);
    end
    if isDrawResult == 1
        x = (1:index);
        figure;
        hold on;
        col_ = {
                'red',
                'green',
                'blue'
            };
        for i = 1 : 3
            plot(x,tr(i,:),col_{i});
        end
        %绘制时间和车辆从各个收费站离开的曲线
        figure;
        plot(x,outNumber_);
        xlabel('time');
        ylabel('the number of the car leave the toll station');
        %绘制时间和车辆从各个收费口离开的曲线
        figure;
        hold on;
        [h_,w_] = size(tollCarNumber_);
        %for i = 1 : h_
        %    plot(x,tollCarNumber_(i,:));
        %end
        plot(x,totalTollCarNumber_);
        xlabel('time');
        ylabel('the number of the car leave the toll');
        %绘制变道时间曲线
        figure;
        plot(x,crashNumber_);
        xlabel('time');
        ylabel('the number of Vehicle''s Lane-changing');
        %绘制车辆从进入收费口到离开收费站平均耗时曲线
        figure;
        plot(x,totalTime_);
        xlabel('time');
        ylabel('the avarage of every Vehicle'' serviced time');
    end
end

function ret = calculCarType(data)
    [h_,w_] = size(data);
    ret = zeros(3,1);
    for i = 1 : h_
        for j = 1 : w_
            if data(i,j).car == 1
                ret(data(i,j).carinfo.type_) = ...
                    ret(data(i,j).carinfo.type_) + 1;
            end
        end
    end
end

function drawMap(data)
	[h_,w_] = size(data);
	map = [];
    colors_ = {
            [0.5 0.5 0.5],
            [0.48828125, 0.93359375, 0.75]          ,%> 1
            [0.25390625, 0.95703125, 0.83203125]    ,%> 2
            [0.25390625, 0.95703125, 0.4765625]     ,%> 3
            [1 0 0]    ,%> 4
            [0.77734375, 0.95703125, 0.25390625]    ,%> 5
            [0.95703125, 0.875, 0.1097345132743]    ,%> 6
            [0.93359375, 0.875, 0.6640625]          ,%> no auto
            [0.6640625, 0.93359375, 0.875]          ,%> auto
            [0.4 0.2 0.5]    	 ,%tmp
            [0.7 0.2 0.5]        ,%tmp
            [1 0.2 0.5]          ,%tmp***
            [1 0.2 0.5]          ,%tmp
            [1 0.2 0.5]          ,%tmp
            [1 0.2 0.5]          ,%tmp
        };
	for i = 1 : h_
		for j = 1 : w_
			if data(i,j).car == 1
                if data(i,j).clock > 0
                    map(i,j,:) = [1,0,0];
                else
                    map(i,j,:) = colors_{data(i,j).carinfo.speech + 9};
                end
			else
				map(i,j,:) = colors_{data(i,j).type_ + 1};
			end
		end
    end
	imagesc(map);
end
	
function [data,totalBlock,leftTop] = ...
        intiData(           ...
                inPathLen   ,...
                outPathLen  ,...
                inSquare    ,...
                outSquare   ,...
                inHerLen    ,...
                outHerLen   ,...
                queueLen    ,...
                lanNumber   ,...
                tollNumber  ,...
                inType      ,...
                outType     ,...
                tollTypeList,...
                detaDis     ,...
                varargin    ...
            )
	%变量解释看函数 cellMock
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%data			:	地图数据
	%totalBlock		:	总占地块数
	%leftTop		:	地图左上角的位置
	
    global carSpeech;
    carSpeech = 2;
    global carDisa;
    carDisa = 1;
    
	%计算宽度
	width = inPathLen + inSquare + queueLen + 1 + outSquare + outPathLen;
	%计算高度
	height = tollNumber;
	
	cut_border = 0;
	for i = 1 : width
		for j = 1 : height
			data(j,i) = emptyCell(1);
		end
	end
	
	deta = tollNumber - lanNumber;
    if detaDis < 0    %%%%%%%%%%%%%%%%%%%
        if (mod(deta,2) == 1)
            u = (deta + 1) / 2;
            d = (deta - 1) / 2;
        else
            u = deta / 2;
            d = u;
        end
    else    %%%%%%%%%%%%%%%%%%%
        u = detaDis;
        d = deta - u;
    end    %%%%%%%%%%%%%%%%%%%
	leftTop = u;
	%计算地图四个角落
	for i = 1 : inPathLen
		for j = 1 : u
			data(j,i) = emptyCell(0);
			cut_border = cut_border + 1;
		end
		for j = 1 : d
			data(height - j + 1,i) = emptyCell(0);
			cut_border = cut_border + 1;
		end
	end
	for i = 1 : outPathLen
		for j = 1 : u
			data(j,width - i + 1) = emptyCell(0);
			cut_border = cut_border + 1;
		end
		for j = 1 : d
			data(height - j + 1,width - i + 1) = emptyCell(0);
			cut_border = cut_border + 1;
		end
	end
	
	leanLen = inSquare - inHerLen;
    if u == 0
        u_list = [];
        u_deta = [];
    else
    	u_list = getNumberList(u,1);
        u_deta = u_list(u) / leanLen;
    end
    if d == 0
        d_list = [];
        d_deta = [];
    else
    	d_list = getNumberList(d,1);
        d_deta = d_list(d) / leanLen;
    end
	i = 1;
	u_ = u;
	d_ = d;
	u_tmp = 0;
	d_tmp = 0;
	u_count = 1;
	d_count = 1;
	for i = 1 : leanLen
        if length(u_list) > 0
            if u_list(u_count) < u_tmp
                u_count = u_count + 1;
                u_ = u_ - 1;
            end
        end
        if length(d_list) > 0
            if d_list(d_count) < d_tmp
                d_count = d_count + 1;
                d_ = d_ - 1;
            end
        end
		for j = 1 : u_
			data(j,i + inPathLen) = emptyCell(0);
			cut_border = cut_border + 1;
		end
		for j = 1 : d_
			data(height - j + 1,i + inPathLen) = emptyCell(0);
			cut_border = cut_border + 1;
		end
		u_tmp = u_tmp + u_deta;
		d_tmp = d_tmp + d_deta;
	end
	
	leanLen = outSquare - outHerLen;
    if u == 0
        u_list = [];
        u_deta = [];
    else
    	u_list = getNumberList(u,1);
        u_deta = u_list(u) / leanLen;
    end
    if d == 0
        d_list = [];
        d_deta = [];
    else
    	d_list = getNumberList(d,1);
        d_deta = d_list(d) / leanLen;
    end
	i = 1;
	u_ = u;
	d_ = d;
	u_tmp = 0;
	d_tmp = 0;
	u_count = 1;
	d_count = 1;
	for i = 1 : leanLen
        if length(u_list)
            if u_list(u_count) < u_tmp
                u_count = u_count + 1;
                u_ = u_ - 1;
            end
        end
        if length(d_list)
            if d_list(d_count) < d_tmp
                d_count = d_count + 1;
                d_ = d_ - 1;
            end
        end
		for j = 1 : u_
			data(j,width - i + 1 - outPathLen) = emptyCell(0);
			cut_border = cut_border + 1;
		end
		for j = 1 : d_
			data(height - j + 1,width - i + 1 - outPathLen) = emptyCell(0);
			cut_border = cut_border + 1;
		end
		u_tmp = u_tmp + u_deta;
		d_tmp = d_tmp + d_deta;
	end
	
	%计算剩余的东西
	len_ = [inPathLen,inSquare,queueLen,1,outSquare,outPathLen];
	to_loc = 0;
	cur_loc = 1;
	for type = 1 : length(len_)
		to_loc = to_loc + len_(type);
		for i = cur_loc : to_loc
			for j = 1 : height
				if data(j,i).type_ == 1
					data(j,i) = emptyCell(type);
				end
			end
		end
		cur_loc = to_loc + 1;
	end
	%计算收费口
	toll_x_loc = inPathLen + inSquare + queueLen + 1;
	for i = 1 : height
        data(i,toll_x_loc) = createToll(data(i,toll_x_loc),tollTypeList(i));
	end
	totalBlock = 0;
	%设置转向（仅设置收费口的出入口类型时有效）
    if detaDis < 0
        for i = toll_x_loc + 1 : width
            tmp_n = 0;
            tmp_top = 0;
            tmp_bottom = 0;
            tmp_lanNumber = lanNumber;
            for j = 1 : height
                if (data(j,i).type_ ~= 0)
                    if (tmp_top == 0)
                        tmp_top = j;
                    end
                    tmp_n = tmp_n + 1;
                end
                totalBlock = totalBlock + tmp_n;
            end
            while tmp_lanNumber > 1
                tmp_bottom = tmp_top + tmp_n - 1;
                len = int16(tmp_n / tmp_lanNumber);
                for j = 1 : len
                    data(tmp_bottom - j + 1,i).forceDir = -1;
                    data(tmp_top + j - 1,i).forceDir = 1;
                    if (length(varargin) > 0)
                        data(tmp_bottom - j + 1,i).fDir = 8;
                        data(tmp_top + j - 1,i).fDir = 9;
                    end
                end
                tmp_n = tmp_n - 2 * len;
                tmp_bottom = tmp_bottom - len;
                tmp_top = tmp_top + len;
                tmp_lanNumber = tmp_lanNumber - 2;
            end
        end
    else
    end
	
	totalBlock = totalBlock - outPathLen * lanNumber;
	%totalBlock = width * height - cut_border - (inPathLen + outPathLen) * lanNumber;
end

function cell = emptyCell(type_)
	cell.type_ = type_;
	if type_ == 0
		cell.car = -1;
	else
		cell.car = 0;
	end
	cell.carinfo = 0;
	cell.delay = 0;
	cell.count = 0;
	cell.toll = 0;
	cell.fDir = 0;
	cell.forceDir = 0;
	cell.clock = 0;
	cell.count = 0;
end

function list = getNumberList(n,type)
	%type 1.v 2.u 3.x
	%n 是层数
	list = [];
	if type == 1
		for i = 1 : n
			list(i) = i;
		end
	elseif type == 2
		list(1) = 1;
		for i = 2 : n
			list(i) = list(i - 1) * 2;
		end
	else
		list(n) = 1;
		for i = n - 1 : -1 : 1
			list(i) = list(i + 1) * 2;
		end
	end
	for i = 2 : n
		list(i) = list(i) + list(i - 1);
	end
end

%汽车的属性有{类型type_（对应于收费口），刹车/加速加速度disA，一般速度maxSpeech和speech，颜色color，是否自动驾驶autoRate}
function cell = createCar(cell,autoRate,type_,time_)
    %cell     	: 	放置车辆的元胞
    %autoRate 	: 	是否为自动驾驶（只是添加了auto属性，并无大作用，请重写）
    %%%%%%%%%%%%%%%%%
    %cell     	: 	
    global carSpeech;
    global carDisa;
    %统一速度
    car.speech = carSpeech;
    %car.length = 2;
    car.disA = carDisa;
	car.maxSpeech = 6;
	car.time_ = time_;
    %for fun
    %car.color = getColor();
	%车的类型（对应于人工，刷卡，etc）
	%the probability of the type of the toll gate that a vehicle can pass through
	%type_ = [0.2,0.7,1];
	typeRandom = rand;
	if (typeRandom < type_(1)) 
		car.type_ = 1;
	elseif typeRandom < type_(2)
		car.type_ = 2;
	else
		car.type_ = 3;
	end
    %自动驾驶
	if (autoRate > rand)
		car.auto = 1;
		car.type_ = 3;
	else
		car.auto = 0;
	end
    %刹车加速度
    cell.carinfo = car;
    cell.car = 1;
end

%逗逼处理
function color_ = getColor
    colors = {
            'red',
            'green',
            'blue',
			'black',
			'yellow'
        };
	randColor = int16(rand * length(colors));
	if randColor <= 0
		randColor = 1;
	end
    color_ = colors{randColor};
end

%绘制每一个单元格（包括车辆等等）
function drawCell(data,varargin)
    %data   : 这里的data将记录整一个地图的所有数据
    %其中有n中颜色，对应的颜色有
    colors_ = {
            [0.48828125, 0.93359375, 0.75]          ,%空地1   > 1
            [0.25390625, 0.95703125, 0.83203125]    ,%空地2   > 2
            [0.25390625, 0.95703125, 0.4765625]     ,%空地3   > 3
            [0.29296875, 0.95703125, 0.25390625]    ,%收费口  > 4
            [0.77734375, 0.95703125, 0.25390625]    ,%空地4   > 5
            [0.95703125, 0.875, 0.1097345132743]    ,%空地5   > 6
            [0.93359375, 0.875, 0.6640625]          ,%车辆    > 飞自动
            [0.6640625, 0.93359375, 0.875]          ,%车辆    > 自动
            [0.1,0.2,0.3]    ,%tmp
            [0.4,0.5,0.6]          ,%tmp
            [0.7,0.8,0.9]          ,%tmp
        };
    [h_,w_] = size(data);
    for i = 1 : h_
        for j = 1 : w_
			%判断是否为外边界
			if data(i,j).type_ == 0
				continue;
			else
				if (data(i,j).car == 0)
					drawRect(i,j,colors_{data(i,j).type_});
				else
					if data(i,j).carinfo.auto == 1
						drawRect(i,j,colors_{8});
					else
						drawRect(i,j,colors_{7});
					end
					if (length(varargin) > 0)
						drawCar(j,i,1,1,data(i,j).carinfo.color);
					end
				end
			end
        end
    end
end

%绘制三角形
function drawTriangle(x,y,width,height,type_,color_)
    % -1 往右下 -2往左下 -3 往右上 -4 往左上
    type_ = type_ + 5;
    dx = [
            0 width width;
            0 width 0;
            width width 0;
            0 width 0;
         ];
     dy = [
             0 0 height;
             0 0 height;
             0 height height;
             0 height height
          ];
      patch(x + dx(type_,:),y + dy(type_,:),color_);
end

%绘制汽车
function drawCar(x,y,width,height,color_)
    %x,y          : the cell top-left corner
    %width height : the cell size
    minsize = min(width,height);
    hx = width / 2;
    hy = height / 2;
    body_(x + hx - minsize * 0.5,y + hy - minsize * 0.15,minsize * 0.92,color_);
end

%车轮
function wheel_(x_,y_,size_,dis,color_)
    %x,y
    %size : the wheel size
    %dis : the distance of two wheel
    deg = [6.2832 3.1415 3.5904 4.0392 4.4880 4.9368 5.3856 5.8344 6.2832]';
    m = numel(deg);
	x = repmat(x_,[m,1]) + cos(deg) * size_;
	y = repmat(y_,[m,1]) + sin(deg) * size_;
    patch(x,y,color_);
    patch(x + dis,y,color_);
end

%汽车的车身
function body_(x,y,size_,color_)
    unit = size_ / 7;
    px = [0 6.5 6.5 5 4 0 0] * unit + x;
    py = [0 0 2 2 4 4 0] * unit + y;
    wheel_(px(1) + 1.5 * unit,py(1),unit,unit * 2.8,color_);
    patch(px,py,1,'FaceColor',color_,'EdgeColor',color_);
end

%创建收费口
function cell = createToll(cell,type_)
    %type_  :三种类型，时间将有所不同
    %这里假定只有三种类型的收费口
    %分别为 人工、自动、etc
    %时间是相对于速度而言的
    waitTime = [16 8 0];
	toll.curTime = waitTime(type_);
    %toll.type = type_;
    toll.waitTime = waitTime(type_);
    %当前的等待时间为零
    toll.curTime = 0;
    cell.toll = toll;
	cell.fDir = 0;
end

%计算当前驶离到道路上的车辆的数量，并且将其从地图中删除
function [cell,c] = calcOutToLanAndAway(data)
    [h_,w_] = size(data);
	c = 0;
	for i = 1 : h_
		if data(i,w_).car == 1
			c = c + 1;
		end
	end
end

%计算当前的车辆数量
function c = totalCar(data)
    [h_,w_] = size(data);
    c = 0;
    for i = 1 : h_
        for j = 1 : w_
            if (data(i,j).car == 1)
                c = c + 1;
            end
        end
    end
end

%描述一个时刻所有车辆的行进（为完成的地方是，统计车的数量）
function [data,outNumber,tollCarNumber,crashNumber,totalTime] = forward(data,tollTypeList,index)
	%data		 :	这里是所有元胞的数据
	%tollTypeList:	这里是所有收费口的类型（从下到上）
	%index	     :	模拟时间
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %data           :   变化后的数据
    %outNumber      :   从收费口出来的车辆
    %tollCarNumber  :   从各个收费口出来的数量
    %crashNumber    :   事故数量
    %几点声明
    %1.     速度最小为零（但是当前方没车时，速度为1）（前方为空时，并且没有限制减速时，速度为最大安全值）（减速区，保持1或者某一个默认值）
    %2.     如何变道：默认以车少的道路为主（瞬移）（另外就是瞬移的最大度有没有上限，这里仅仅是说从第一道最大能瞬移到第几道）
	%				 （另外该程序中仅仅考虑能否变道，瞬移限度完全是不在考虑范围内的）（这里也暂时不提供瞬移控制参数）
    %3.     是否进入减速区，以车头位置为准
    %4.     发生撞车后，车辆停止并占用原等同格子（并设置时钟，开始倒计时，时间结束时表示事故处理完毕恢复原状）
    %5.     广场允许变道，但是排队位置不允许
	%6.		撞车的形式？这里仅仅假定在无法变道情况下的，车辆直行是否会撞上前车，同时赋以一定（很低的）概率模拟是否真的撞上（例如90%没有撞上）
	%7.		这里的减速和变道使用一种很奇怪的方式（这里有一个前提条件就是车辆行进时是有默认的安全速度的）
	%			1.例如减速后的行进距离是 s = v * t - 0.5 * a * t * t，既 s = v - 0.5 * a;
	%			2.另外这里的减速和变道是可以同时进行的，也就是变道处理程序较为复杂
	%			3.另外这里的减速后距离有可能会为<=0，这里的假设是，先表示为0，在实际情况下按照是否能行进重新赋值为>=1
	%				在距离可以更大时，相应速度更到但是在当车辆驶到靠在一起后，车速表示为零
	%8.		这里有另一个就是驶离时的加速问题，如果使用类似上面7的方式是否会无事故（但是这里就先假定是以上面的方式进行行进）
	%			1.另外一点就是，在程序中的加速度是加速和减速公用的加速度，在有必要分析的情况下该程序可能需要改写该部分代码
	%9.		根据题意是否要假定前方的收费口没有发生事故的可能性
	%10.	考虑到进入收费口后的车速只会减少，这里不考虑车辆的加速
	%11.	这里默认在或者达到收费口后，车速为零
	%12.	使用安全距离，当前进距离比安全距离大时，车辆无法安全前进，这时使用概率来计算是否可能发生事故，如果发生则停下并处理事故
	%			如果这时没发生事故则进入安全距离内，速度相应减少。
	%13.	另外，假设前方道路不会发生事故
	%14.	换道暂时不考虑减速，仅仅是换道，除非是换道后的车距过近
	%这里默认对应不同收费服务后的收费服务时间（）
	extServiceTime = [
						0 3 5;	%表示从人工服务跨越到人工，刷卡，etc时增加的超时
						0 0 3;	%同上
						0 0 0;	%同上
					 ];
	%这里默认一个撞车概率(0.1)
	crashRate = [0.3,0.7];
	%这里默认一个收费口不对应时的延时时间
	delay = -2;
	%B_len = length(tollTypeList);
	%这里应该将前面的车进行清空，同时加入计数
	%撞车的周转时间
	crashClock = 5;
	%事故统计量
	crashNumber = 0;
	
	[h_,w_] = size(data);
	%经过每一个收费口的数量
	tollCarNumber = zeros(1,h_);
	%从收费站出来的车辆数
	outNumber = 0;
	totalTime = 0;
	
	for i = w_ : -1 : 1
		for j = h_ : -1 : 1
			cell = data(j,i);
			%如果是墙壁直接继续
			if cell.type_ == 0
				continue;
			end
			%如果发生事故，时钟减一继续
			if cell.clock > 0
                data(j,i).clock = cell.clock - 1;
				continue;
			end
			%如果是空车，继续
			if cell.car == 0
				continue;
			end
			%分区讨论
			%计算一般距离，减速距离，加速距离（向下取整）
			car = cell.carinfo;
			nor_dis = car.speech;
			add_dis = int16(car.speech + 0.5 * car.disA);
			cut_dis = int16(car.speech - 0.5 * car.disA);
			if (add_dis == nor_dis) 
				add_dis = add_dis + 1;
			end
			deta_x = 0;
			deta_y = 0;
			speech = car.speech;
			isOk = 0;
			isToll = 0;
			tollTime = 0;
			halfHeight = h_ / 2;
			isCrash = 0;
			isOut = 0;
			if (j + 1) > halfHeight
				tmp_dir = 1;
			else
				tmp_dir = -1;
			end
			if j == h_
				tmp_dir = -1;
			elseif j == 1
				tmp_dir = 1;
			end
			if cut_dis < 0 
				cut_dis = 0;
			end
			if nor_dis <= 0
				nor_dis = 1;
			end
			if add_dis <= nor_dis
				add_dis = nor_dis + 1;
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if add_dis <= 0
                j
            end
			[forwardMax,tollLoc] = getMaxForwardDis(add_dis,data(j,:),i);
			if cell.type_ <= 3 || cell.type_ == 5
				%仅仅考虑前方情况和是否可以变道通过
				%考虑能否加速直行
				if add_dis < forwardMax
					speech = car.speech + car.disA;
					if (speech > car.maxSpeech) 
						speech = car.maxSpeech;
					end
					deta_x = speech;
					isOk = 1;
				end
				%考虑能否正常直行
				if nor_dis < forwardMax && isOk == 0
					deta_x = nor_dis;
					isOk = 1;
				end
				%考虑能否减速直行
				if isOk == 0
					if cut_dis < forwardMax && cut_dis ~= 0
						speech = car.speech - car.disA;
						deta_x = cut_dis;
						isOk = 1;
					elseif cell.type_ <= 2
						%尝试变道往偏向一方变道
						if j == h_ || j == 1
							if j + tmp_dir > 0 && j + tmp_dir <= h_
								if data(j + tmp_dir,i + nor_dis).car == 0
									speech = car.speech - car.disA;
									deta_x = nor_dis;
									deta_y = tmp_dir;
									isOk = 1;
								end
                            end
						else
							[forwardMax_add,tollLoc_add] = getMaxForwardDis(add_dis,data(j + tmp_dir,:),i);
							[forwardMax_cut,tollLoc_cut] = getMaxForwardDis(add_dis,data(j - tmp_dir,:),i);
							if forwardMax_add > forwardMax_cut
								if j + tmp_dir > 0 && j + tmp_dir <= h_
									if data(j + tmp_dir,i + nor_dis).car == 0
										speech = car.speech - car.disA;
										deta_x = nor_dis;
										deta_y = tmp_dir;
										isOk = 1;
									end
								end
							elseif forwardMax_add < forwardMax_cut
								if j - tmp_dir > 0 && j - tmp_dir <= h_
									if data(j - tmp_dir,i + nor_dis).car == 0
										speech = car.speech - car.disA;
										deta_x = nor_dis;
										deta_y = - tmp_dir;
										isOk = 1;
									end
								end
							else
								if j + tmp_dir > 0 && j + tmp_dir <= h_
									if data(j + tmp_dir,i + nor_dis).car == 0
										speech = car.speech - car.disA;
										deta_x = nor_dis;
										deta_y = tmp_dir;
										isOk = 1;
									end
								elseif j - tmp_dir > 0 && j - tmp_dir <= h_
									if data(j - tmp_dir,i + nor_dis).car == 0
										speech = car.speech - car.disA;
										deta_x = nor_dis;
										deta_y = - tmp_dir;
										isOk = 1;
									end
								end
							end
						end
					elseif cell.type_ == 5
                        if cell.forceDir == 0
                            if j - tmp_dir > 0 && j - tmp_dir <= h_
                                if data(j - tmp_dir,i + nor_dis).car == 0
                                    speech = car.speech - car.disA;
                                    deta_x = nor_dis;
                                    deta_y = - tmp_dir;
                                    isOk = 1;
                                end
                            end
                            if j + tmp_dir > 0 && j + tmp_dir <= h_ && isOk == 0
                                if data(j + tmp_dir,i + nor_dis).car == 0
                                    speech = car.speech - car.disA;
                                    deta_x = nor_dis;
                                    deta_y = tmp_dir;
                                    isOk = 1;
                                end
                            end
                        else
                            if j + cell.forceDir > 0 || j + cell.forceDir <= h_
                                if data(j + cell.forceDir,i + nor_dis).car == 0
                                    speech = car.speech - car.disA;
                                    deta_x = nor_dis;
                                    deta_y = cell.forceDir;
                                    isOk = 1;
                                end
                            end
                        end
					end
				end
				%考虑减速变道
				if isOk == 0 && cell.type_ <= 2 && cut_dis ~= 0
					if j == h_ || j == 1
						if j + tmp_dir > 0 && j + tmp_dir <= h_
							if data(j + tmp_dir,i + cut_dis).car == 0
								speech = car.speech - car.disA;
								deta_x = cut_dis;
								deta_y = tmp_dir;
								isOk = 1;
							end
                        end
					else
						[forwardMax_add,tollLoc_add] = getMaxForwardDis(add_dis,data(j + tmp_dir,:),i);
						[forwardMax_cut,tollLoc_cut] = getMaxForwardDis(add_dis,data(j - tmp_dir,:),i);
						if forwardMax_add > forwardMax_cut
							if j + tmp_dir > 0 && j + tmp_dir <= h_
								if data(j + tmp_dir,i + cut_dis).car == 0
									speech = car.speech - car.disA;
									deta_x = cut_dis;
									deta_y = tmp_dir;
									isOk = 1;
								end
							end
						elseif forwardMax_add < forwardMax_cut
							if j - tmp_dir > 0 && j - tmp_dir <= h_
								if data(j - tmp_dir,i + cut_dis).car == 0
									speech = car.speech - car.disA;
									deta_x = cut_dis;
									deta_y = - tmp_dir;
									isOk = 1;
								end
							end
						else
							if j + tmp_dir > 0 && j + tmp_dir <= h_
								if data(j + tmp_dir,i + cut_dis).car == 0
									speech = car.speech - car.disA;
									deta_x = cut_dis;
									deta_y = tmp_dir;
									isOk = 1;
								end
							elseif j - tmp_dir > 0 && j - tmp_dir <= h_
								if data(j - tmp_dir,i + cut_dis).car == 0
									speech = car.speech - car.disA;
									deta_x = cut_dis;
									deta_y = - tmp_dir;
									isOk = 1;
								end
							else
								deta_x = forwardMax;
								speech = car.speech - car.disA;
								%isCrash = 1;
								isOk = 1;
							end
						end
					end
                end
                %%%%%%%%%%%%%%%%%src
				if isOk == 0 && cell.type_ == 5 && cut_dis ~= 0
					%对于第五种的
                    if forwardMax == 0
                        %不能往前走
						if speech == 0
							%强制拉出去
							for ii = 0 : add_dis
                                if cell.forceDir == 0
                                    tmpDir = -tmp_dir;
                                else
                                    tmpDir = cell.forceDir;
                                end
								if data(j + tmpDir,i + ii).car == 0
									dx = ii;
									dy = tmpDir;
									break;
								end
							end
						end
                    else
                        %可以往前走
                        if cell.forceDir == 0
                            tmpDir = -tmp_dir;
                        else
                            tmpDir = cell.forceDir;
                        end
                        if j + tmpDir < 1 || j + cell.forceDir > h_
                            if data(j + cell.forceDir,i + cut_dis).car == 0
                                speech = car.speech - car.disA;
                                deta_x = cut_dis;
                                deta_y = tmpDir;
                                isOk = 1;
                            end
                        else
                            deta_x = forwardMax;
                            speech = car.speech - car.disA;
                            isOk = 1;
                            %isCrash = 1;
                        end
                    end
				end
				%此时应该在位置3（不可变道处）
				if isOk == 0
					deta_x = forwardMax;
					speech = speech - car.disA;
				end
				%判断是否进入收费口
				if deta_x >= tollLoc
					%如果进入，判断时延
					tollTime = tollTypeList(deta_y + j) + extServiceTime(car.type_,tollTypeList(deta_y + j));
					if tollTime > 0
						deta_x = tollLoc;
						speech = 0;
						isToll = 1;
                    else
                        isOk = 1;
					end
				end
				if isToll == 1 && isOk == 0
					%开启计时
					car.time_ = index;
					data(j + deta_y,i + deta_x).toll.curTime = - tollTime;
				end
				%先考虑是否是出界
				if i + forwardMax > w_
					if data(j + deta_y,w_).type_ == 6
						%越界啦
						data(j,i).car = 0;
						outNumber = outNumber + 1;
						totalTime = totalTime + index - car.time_;
						if deta_y ~= 0 && cell.type_ == 5
							crashNumber = crashNumber + 1;
						end
						continue;
					end
				end
				if isCrash == 1
					%考虑发生撞车，但不管是否撞车都将速度调整为零
					speech = 0;
					rand_ = rand();
					if rand_ < crashRate(1) || rand_ > crashRate(2)
						data(j + deta_y,i + deta_x).clock = crashClock;
						data(j + deta_y,i + deta_x + 1).clock = crashClock;
						crashNumber = crashNumber + 1;
					end
                end
				if speech > car.maxSpeech
					speech = car.maxSpeech;
				elseif speech < 0
					speech = 0;
				end
				car.speech = speech;
				data(j,i).car = 0;
                if j + deta_y < 1
                    continue;
                end
				if deta_y ~= 0 && cell.type_ == 5
					crashNumber = crashNumber + 1;
				end
				data(j + deta_y,i + deta_x).car = 1;
				data(j + deta_y,i + deta_x).carinfo = car;
				continue;
			end
			%if cell.type_ == 2
				%该区的车可以变道
				%与1合并
			%	continue;
			%end
			%if cell.type_ == 3
				%与1，2合并，区别时不能变道
			%end
			if cell.type_ == 4
				%收费口
				car.time_ = index;%%%%%%%%%%%%%记录时间
				if cell.toll.curTime >= cell.toll.waitTime
					%车辆可以离开
					tollCarNumber(j) = 1;
					%车速为零，同时判断前行即可
					if add_dis <= forwardMax
						deta_x = add_dis;
						speech = speech + car.disA;
					elseif nor_dis <= forwardMax
						deta_x = add_dis;
					end
					car.speech = speech;
					data(j,i).car = 0;
					data(j + deta_y,i + deta_x).car = 1;
					data(j + deta_y,i + deta_x).carinfo = car;
				else
					data(j,i).toll.curTime = cell.toll.curTime + 1;
				end
				continue;
			end
			%if cell.type_ == 5
				%可以变道（仅仅按照1和2的方案，但是会发生事故）
			%	continue;
			%end
			if cell.type_ == 6
				outNumber = outNumber + 1;
				totalTime = totalTime + index - car.time_;
				data(j,i).car = 0;
				continue;
			end
		end
    end
end

function [c,b] = getMaxForwardDis(u,data,first)
	%获取最大的直行范围
	%u			上限
	%data		数据
	%first		起点
	%%%%%%%%%%%%%%%%%%%%%
	%c			最多能往前走的距离
	%b			距离收费口的距离
	%修正上限
	u_ = length(data) - first;
	if (u_ < u)
		u = u_;
	end
	%给定b默认值(上限加1，表示不可达)
	b = 1000;
	%给定c默认值(0表示不能走)
	c = u;
	for i = 1 : u
		if (data(i + first).type_ == 0)
            c = i - 1;
			break;
		end
		if (data(i + first).type_ == 4)
			b = i;
		end
		if (data(i + first).car == 1)
			c = i - 1;
			break;
		end
	end
end

function c = crashHappen(car)
	%事故发生这里给一些说明：（虽然感觉放在这里有点奇怪）
	%	1.发生事故的概率很小
	%	2.发生事故后，事故车辆停止
	%	3.没有事故发生时，速度会相应减少
	%	4.事故发生时，速度减少到零
	%设定事故概率(0.1)
	rate = 0.1;
	c = 0;
	lastSpeech = car.speech - car.disA;
	if (lastSpeech > 0)
		if (rand <= rate)
			c = 1;
		end
	end
end
