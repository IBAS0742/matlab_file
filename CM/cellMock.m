%�������ֳ��ͣ���С�ֱ�Ϊ���һ�£�����Ϊa��2a������ɾ����
%�ٶ�������ǻ������(Ĭ��Ϊ��Ԫ����)
%�󳵿�����ʻ(����������ʻ��
%���ֳ��ı任�����ĸ���(������)
%�����¹ʵĸ��ʣ��ܵͣ�
%ɲ���Ŀ��ǣ��м�������
%Ԫ������ģ��Ԫ����Ԫ����
%������һ�㣬�շѿ��г��ȣ����뵽�շѿں�������
%����ʹ���˲������������ڴ�ʹ�ã������ı�ÿһ��Ԫ����car�������ı�һ��Ԫ��������
%ÿһ��Ԫ����һ����Ϣ��λ
%������һ���޷����������ĳ��ȣ������ٶȣ��Լ�ÿһ��ʱ���ڳ����н���������һ��s=vt��
%���ﲻģ�ⲻͬ�����ˣ�����ģ��һ�ֳ������н���������򽫲������ú���createCar_��
%������һ����ֵ����������ǣ����޶��˳�����ͨ���շѿ����ͺ󣬱�����ú����
%		1.��ǰ���޷�����շ�ʱ����������Ϊ��·��ԭ���޷�������Ƿ�ǿ��ͣ������ǿ�Ʊ��
%		2.����������ʻ���޷�����շѵ�·�ں�Ӧ������趨���ǵ�ͨ��ʱ������Ƿ���������ӳ�������ģ��
%	�Ը����������ʵ�֣�
%		1.�����������շ�վǰ����ǰ�趨ÿһ�������ϳ����������ʹʻ�복���������Ŀ���շѿ��н�
%		2.����������1�е�����󱣳�ǰ�У����Ҿ�����������
%		3.����������2�е������������ʱ������ģ��
%		4.�������³��󣬲��޵���ʻ�������������һ������������ж϶³���
%		5.���ӵ���ʱ���뵽cell.toll��curTime��(�������Ϊ��С����ֵ����Ϊ�ñ���ʹ���ۼ�)
%			(����curTimeΪ����������ֵΪtoll.waitTimeʱ����ʾ��ʱ��������������ʻ��)
%			***����ж϶³�
%			1.����Ľ��������ʹ����������Ĭ�ϲ����ж³��ж�

%cell.type_     : һ���а�������
%                   -x.�߽�,�ܹ�������������ֱ��ʾÿһ�������εĳ��� (���а����б߽����Ϣ.width��.height)
%                                -1 ������ -2������ -3 ������ -4 ������
%                               ����һ�λ��ƽ�����ֱ��ת��Ϊ��߽磬����Ҫ�������»��ƣ�
%                    0.��߽�
%                    1.��ڣ�
%                    2.�㳡���ɱ仯��������
%                    3.�շѿ�ǰ�����ɱ任��������
%                    4.�շѿڣ�
%                    5.�����������ƿɱ任��������
%                    6.���������ɱ任������������о����Բ����п����ˣ�
%cell.car       : ������Ϣ{0.û�г�����1.�г�����2.��β}��������ʱ�����ò��������ǽ������壩���жϵ����ȼ�����carinfo��
%cell.carinfo   : ����cell.car Ϊ 1 ʱ���о�����Ϣ
%cell.delay     : ʱ�ӣ��շѿ��й̶���ʱ�ӣ��¹ʵ�Ҳ�й̶�ʱ�ӣ�������ʱ�趨Ϊû�У�����ɾ����
%cell.count     : ǰ������������������������շѿ��ڣ�ÿ��ˢ�£���Ĭ��Ϊ�㣩
%cell.toll      : ������Ϊ�շѿ�ʱ��ֵ
%cell.fDir		: ���ȱ������(0Ϊ�����ȣ�1Ϊ�������ϱ����-1Ϊ�������±��)
%cell.forceDir	: ǿ��ֻ�ܱ���ķ���(0Ϊ�����ƣ�1Ϊ�������ϱ����-1Ϊ�������±��)
%cell.clock		: ײ������תʱ��
%cell.count		: ��¼��ǰλ�õĳ�������

%һЩȫ��Ӧ��Ĭ�ϵĲ���
%tollType = { 1 �˹��շ�	2 ˢ���շ�	 3 etc �շ�}
%tollServiceTime % �շѷ���ʱ��
%close all;[d,c] = cellMock(3,3,20,20,3,3,4,3,10,1,1,1000,ones(1,10),0.8,[0.2 0.5 0.3],1);
%close all;cellMock(1,1,2,2,0,0,1,2,4,1,1,1000,ones(1,10),0.8,[0.2 0.5 0.3],1)
%%%%%%%%%%%%%%����%%%%%%%%%%%%%
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
%                 0      		,...   %* ��ڹ㳡��ˮƽ����
%                 6             ,...   %* ���ڹ㳡��ˮƽ����
%                 13     		,...   %* the max length of the queue before the toll(disagree change lanes)
%                 3      		,...   %* the number of the lanes
%                 5      		,...   %* the number of the toll
%                 2      		,...   %* the shap of the square(Entrance)
%                 1      		,...   %* the shap of the square(Exit)(?)
%                 1000			,...   %* the times of the simulation
%                 list       	,...   %* the type of everyone of the toll(bottom to up)
%                 .72			,...   % �������
%                 [0 .7 .3]     ,...   % �������͵ĳ����ĸ���(�˹����Զ���etc)%the probability of the type of the toll gate that a vehicle can pass through
%                 -1            ,...   %
%                 1             ...    %* �Ƿ񽫹��̻��Ƴ���(1���ƣ�0������)
%                 );

function [data,totalBlock,outNumber_,tollCarNumber_,totalTollCarNumber_,crashNumber_,totalTime_] = ...
    cellMock(inPathLen		,...   %����·�ڵĳ�������
             outPathLen		,...   %���ڳ�������
             inSquare		,...   %��ڹ㳡����
             outSquare		,...   %���ڹ㳡����
             inHerLen		,...   %��ڹ㳡��ˮƽ����
             outHerLen		,...   %���ڹ㳡��ˮƽ����
             queueLen		,...   %�Ŷӳ��ȣ��շѿ�ǰ���ܱ��·�γ��ȣ�
             lanNumber		,...   %����·����ĳ�������
             tollNumber		,...   %�շѿ�����
             inType			,...   %��ڵ���״(v u c)
             outType		,...   %���ڵ���״(v u c)
             times			,...   %ģ�����
             tollTypeList	,...   %the type of everyone of the toll(bottom to up)
			 lamda			,...   %�������
			 carTypeRate	,...   %�������͵ĳ����ĸ���(�˹����Զ���etc)%the probability of the type of the toll gate that a vehicle can pass through
             detaDis        ,...   %ʹ�ó������״����Ϊ-1������ʹ������Ϊ������Ϊƫ��
             isDrawResult   ,...   %�Ƿ񽫹��̻��Ƴ���(1���ƣ�0������) 
             varargin		...    %��ʾ�������
             )
	%��ʼ��
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
    %��ʼģ��
    tr_ = [];
	while times ~= 0
		index = index + 1;
		times = times - 1;
		if times < 0
			times = -1;
		end
		%��������ӳ���
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
		%ǰ��һ��
		[data,outNumber,tollCarNumber,crashNumber,totalTime] = forward(data,tollTypeList,index);
		%����
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
        %����ʱ��ͳ����Ӹ����շ�վ�뿪������
        figure;
        plot(x,outNumber_);
        xlabel('time');
        ylabel('the number of the car leave the toll station');
        %����ʱ��ͳ����Ӹ����շѿ��뿪������
        figure;
        hold on;
        [h_,w_] = size(tollCarNumber_);
        %for i = 1 : h_
        %    plot(x,tollCarNumber_(i,:));
        %end
        plot(x,totalTollCarNumber_);
        xlabel('time');
        ylabel('the number of the car leave the toll');
        %���Ʊ��ʱ������
        figure;
        plot(x,crashNumber_);
        xlabel('time');
        ylabel('the number of Vehicle''s Lane-changing');
        %���Ƴ����ӽ����շѿڵ��뿪�շ�վƽ����ʱ����
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
	%�������Ϳ����� cellMock
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%data			:	��ͼ����
	%totalBlock		:	��ռ�ؿ���
	%leftTop		:	��ͼ���Ͻǵ�λ��
	
    global carSpeech;
    carSpeech = 2;
    global carDisa;
    carDisa = 1;
    
	%������
	width = inPathLen + inSquare + queueLen + 1 + outSquare + outPathLen;
	%����߶�
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
	%�����ͼ�ĸ�����
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
	
	%����ʣ��Ķ���
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
	%�����շѿ�
	toll_x_loc = inPathLen + inSquare + queueLen + 1;
	for i = 1 : height
        data(i,toll_x_loc) = createToll(data(i,toll_x_loc),tollTypeList(i));
	end
	totalBlock = 0;
	%����ת�򣨽������շѿڵĳ��������ʱ��Ч��
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
	%n �ǲ���
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

%������������{����type_����Ӧ���շѿڣ���ɲ��/���ټ��ٶ�disA��һ���ٶ�maxSpeech��speech����ɫcolor���Ƿ��Զ���ʻautoRate}
function cell = createCar(cell,autoRate,type_,time_)
    %cell     	: 	���ó�����Ԫ��
    %autoRate 	: 	�Ƿ�Ϊ�Զ���ʻ��ֻ�������auto���ԣ����޴����ã�����д��
    %%%%%%%%%%%%%%%%%
    %cell     	: 	
    global carSpeech;
    global carDisa;
    %ͳһ�ٶ�
    car.speech = carSpeech;
    %car.length = 2;
    car.disA = carDisa;
	car.maxSpeech = 6;
	car.time_ = time_;
    %for fun
    %car.color = getColor();
	%�������ͣ���Ӧ���˹���ˢ����etc��
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
    %�Զ���ʻ
	if (autoRate > rand)
		car.auto = 1;
		car.type_ = 3;
	else
		car.auto = 0;
	end
    %ɲ�����ٶ�
    cell.carinfo = car;
    cell.car = 1;
end

%���ƴ���
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

%����ÿһ����Ԫ�񣨰��������ȵȣ�
function drawCell(data,varargin)
    %data   : �����data����¼��һ����ͼ����������
    %������n����ɫ����Ӧ����ɫ��
    colors_ = {
            [0.48828125, 0.93359375, 0.75]          ,%�յ�1   > 1
            [0.25390625, 0.95703125, 0.83203125]    ,%�յ�2   > 2
            [0.25390625, 0.95703125, 0.4765625]     ,%�յ�3   > 3
            [0.29296875, 0.95703125, 0.25390625]    ,%�շѿ�  > 4
            [0.77734375, 0.95703125, 0.25390625]    ,%�յ�4   > 5
            [0.95703125, 0.875, 0.1097345132743]    ,%�յ�5   > 6
            [0.93359375, 0.875, 0.6640625]          ,%����    > ���Զ�
            [0.6640625, 0.93359375, 0.875]          ,%����    > �Զ�
            [0.1,0.2,0.3]    ,%tmp
            [0.4,0.5,0.6]          ,%tmp
            [0.7,0.8,0.9]          ,%tmp
        };
    [h_,w_] = size(data);
    for i = 1 : h_
        for j = 1 : w_
			%�ж��Ƿ�Ϊ��߽�
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

%����������
function drawTriangle(x,y,width,height,type_,color_)
    % -1 ������ -2������ -3 ������ -4 ������
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

%��������
function drawCar(x,y,width,height,color_)
    %x,y          : the cell top-left corner
    %width height : the cell size
    minsize = min(width,height);
    hx = width / 2;
    hy = height / 2;
    body_(x + hx - minsize * 0.5,y + hy - minsize * 0.15,minsize * 0.92,color_);
end

%����
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

%�����ĳ���
function body_(x,y,size_,color_)
    unit = size_ / 7;
    px = [0 6.5 6.5 5 4 0 0] * unit + x;
    py = [0 0 2 2 4 4 0] * unit + y;
    wheel_(px(1) + 1.5 * unit,py(1),unit,unit * 2.8,color_);
    patch(px,py,1,'FaceColor',color_,'EdgeColor',color_);
end

%�����շѿ�
function cell = createToll(cell,type_)
    %type_  :�������ͣ�ʱ�佫������ͬ
    %����ٶ�ֻ���������͵��շѿ�
    %�ֱ�Ϊ �˹����Զ���etc
    %ʱ����������ٶȶ��Ե�
    waitTime = [16 8 0];
	toll.curTime = waitTime(type_);
    %toll.type = type_;
    toll.waitTime = waitTime(type_);
    %��ǰ�ĵȴ�ʱ��Ϊ��
    toll.curTime = 0;
    cell.toll = toll;
	cell.fDir = 0;
end

%���㵱ǰʻ�뵽��·�ϵĳ��������������ҽ���ӵ�ͼ��ɾ��
function [cell,c] = calcOutToLanAndAway(data)
    [h_,w_] = size(data);
	c = 0;
	for i = 1 : h_
		if data(i,w_).car == 1
			c = c + 1;
		end
	end
end

%���㵱ǰ�ĳ�������
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

%����һ��ʱ�����г������н���Ϊ��ɵĵط��ǣ�ͳ�Ƴ���������
function [data,outNumber,tollCarNumber,crashNumber,totalTime] = forward(data,tollTypeList,index)
	%data		 :	����������Ԫ��������
	%tollTypeList:	�����������շѿڵ����ͣ����µ��ϣ�
	%index	     :	ģ��ʱ��
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %data           :   �仯�������
    %outNumber      :   ���շѿڳ����ĳ���
    %tollCarNumber  :   �Ӹ����շѿڳ���������
    %crashNumber    :   �¹�����
    %��������
    %1.     �ٶ���СΪ�㣨���ǵ�ǰ��û��ʱ���ٶ�Ϊ1����ǰ��Ϊ��ʱ������û�����Ƽ���ʱ���ٶ�Ϊ���ȫֵ����������������1����ĳһ��Ĭ��ֵ��
    %2.     ��α����Ĭ���Գ��ٵĵ�·Ϊ����˲�ƣ����������˲�Ƶ�������û�����ޣ����������˵�ӵ�һ�������˲�Ƶ��ڼ�����
	%				 ������ó����н��������ܷ�����˲���޶���ȫ�ǲ��ڿ��Ƿ�Χ�ڵģ�������Ҳ��ʱ���ṩ˲�ƿ��Ʋ�����
    %3.     �Ƿ������������Գ�ͷλ��Ϊ׼
    %4.     ����ײ���󣬳���ֹͣ��ռ��ԭ��ͬ���ӣ�������ʱ�ӣ���ʼ����ʱ��ʱ�����ʱ��ʾ�¹ʴ�����ϻָ�ԭ״��
    %5.     �㳡�������������Ŷ�λ�ò�����
	%6.		ײ������ʽ����������ٶ����޷��������µģ�����ֱ���Ƿ��ײ��ǰ����ͬʱ����һ�����ܵ͵ģ�����ģ���Ƿ����ײ�ϣ�����90%û��ײ�ϣ�
	%7.		����ļ��ٺͱ��ʹ��һ�ֺ���ֵķ�ʽ��������һ��ǰ���������ǳ����н�ʱ����Ĭ�ϵİ�ȫ�ٶȵģ�
	%			1.������ٺ���н������� s = v * t - 0.5 * a * t * t���� s = v - 0.5 * a;
	%			2.��������ļ��ٺͱ���ǿ���ͬʱ���еģ�Ҳ���Ǳ����������Ϊ����
	%			3.��������ļ��ٺ�����п��ܻ�Ϊ<=0������ļ����ǣ��ȱ�ʾΪ0����ʵ������°����Ƿ����н����¸�ֵΪ>=1
	%				�ھ�����Ը���ʱ����Ӧ�ٶȸ��������ڵ�����ʻ������һ��󣬳��ٱ�ʾΪ��
	%8.		��������һ������ʻ��ʱ�ļ������⣬���ʹ����������7�ķ�ʽ�Ƿ�����¹ʣ�����������ȼٶ���������ķ�ʽ�����н���
	%			1.����һ����ǣ��ڳ����еļ��ٶ��Ǽ��ٺͼ��ٹ��õļ��ٶȣ����б�Ҫ����������¸ó��������Ҫ��д�ò��ִ���
	%9.		���������Ƿ�Ҫ�ٶ�ǰ�����շѿ�û�з����¹ʵĿ�����
	%10.	���ǵ������շѿں�ĳ���ֻ����٣����ﲻ���ǳ����ļ���
	%11.	����Ĭ���ڻ��ߴﵽ�շѿں󣬳���Ϊ��
	%12.	ʹ�ð�ȫ���룬��ǰ������Ȱ�ȫ�����ʱ�������޷���ȫǰ������ʱʹ�ø����������Ƿ���ܷ����¹ʣ����������ͣ�²������¹�
	%			�����ʱû�����¹�����밲ȫ�����ڣ��ٶ���Ӧ���١�
	%13.	���⣬����ǰ����·���ᷢ���¹�
	%14.	������ʱ�����Ǽ��٣������ǻ����������ǻ�����ĳ������
	%����Ĭ�϶�Ӧ��ͬ�շѷ������շѷ���ʱ�䣨��
	extServiceTime = [
						0 3 5;	%��ʾ���˹������Խ���˹���ˢ����etcʱ���ӵĳ�ʱ
						0 0 3;	%ͬ��
						0 0 0;	%ͬ��
					 ];
	%����Ĭ��һ��ײ������(0.1)
	crashRate = [0.3,0.7];
	%����Ĭ��һ���շѿڲ���Ӧʱ����ʱʱ��
	delay = -2;
	%B_len = length(tollTypeList);
	%����Ӧ�ý�ǰ��ĳ�������գ�ͬʱ�������
	%ײ������תʱ��
	crashClock = 5;
	%�¹�ͳ����
	crashNumber = 0;
	
	[h_,w_] = size(data);
	%����ÿһ���շѿڵ�����
	tollCarNumber = zeros(1,h_);
	%���շ�վ�����ĳ�����
	outNumber = 0;
	totalTime = 0;
	
	for i = w_ : -1 : 1
		for j = h_ : -1 : 1
			cell = data(j,i);
			%�����ǽ��ֱ�Ӽ���
			if cell.type_ == 0
				continue;
			end
			%��������¹ʣ�ʱ�Ӽ�һ����
			if cell.clock > 0
                data(j,i).clock = cell.clock - 1;
				continue;
			end
			%����ǿճ�������
			if cell.car == 0
				continue;
			end
			%��������
			%����һ����룬���پ��룬���پ��루����ȡ����
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
				%��������ǰ��������Ƿ���Ա��ͨ��
				%�����ܷ����ֱ��
				if add_dis < forwardMax
					speech = car.speech + car.disA;
					if (speech > car.maxSpeech) 
						speech = car.maxSpeech;
					end
					deta_x = speech;
					isOk = 1;
				end
				%�����ܷ�����ֱ��
				if nor_dis < forwardMax && isOk == 0
					deta_x = nor_dis;
					isOk = 1;
				end
				%�����ܷ����ֱ��
				if isOk == 0
					if cut_dis < forwardMax && cut_dis ~= 0
						speech = car.speech - car.disA;
						deta_x = cut_dis;
						isOk = 1;
					elseif cell.type_ <= 2
						%���Ա����ƫ��һ�����
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
				%���Ǽ��ٱ��
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
					%���ڵ����ֵ�
                    if forwardMax == 0
                        %������ǰ��
						if speech == 0
							%ǿ������ȥ
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
                        %������ǰ��
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
				%��ʱӦ����λ��3�����ɱ������
				if isOk == 0
					deta_x = forwardMax;
					speech = speech - car.disA;
				end
				%�ж��Ƿ�����շѿ�
				if deta_x >= tollLoc
					%������룬�ж�ʱ��
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
					%������ʱ
					car.time_ = index;
					data(j + deta_y,i + deta_x).toll.curTime = - tollTime;
				end
				%�ȿ����Ƿ��ǳ���
				if i + forwardMax > w_
					if data(j + deta_y,w_).type_ == 6
						%Խ����
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
					%���Ƿ���ײ�����������Ƿ�ײ�������ٶȵ���Ϊ��
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
				%�����ĳ����Ա��
				%��1�ϲ�
			%	continue;
			%end
			%if cell.type_ == 3
				%��1��2�ϲ�������ʱ���ܱ��
			%end
			if cell.type_ == 4
				%�շѿ�
				car.time_ = index;%%%%%%%%%%%%%��¼ʱ��
				if cell.toll.curTime >= cell.toll.waitTime
					%���������뿪
					tollCarNumber(j) = 1;
					%����Ϊ�㣬ͬʱ�ж�ǰ�м���
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
				%���Ա������������1��2�ķ��������ǻᷢ���¹ʣ�
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
	%��ȡ����ֱ�з�Χ
	%u			����
	%data		����
	%first		���
	%%%%%%%%%%%%%%%%%%%%%
	%c			�������ǰ�ߵľ���
	%b			�����շѿڵľ���
	%��������
	u_ = length(data) - first;
	if (u_ < u)
		u = u_;
	end
	%����bĬ��ֵ(���޼�1����ʾ���ɴ�)
	b = 1000;
	%����cĬ��ֵ(0��ʾ������)
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
	%�¹ʷ��������һЩ˵��������Ȼ�о����������е���֣�
	%	1.�����¹ʵĸ��ʺ�С
	%	2.�����¹ʺ��¹ʳ���ֹͣ
	%	3.û���¹ʷ���ʱ���ٶȻ���Ӧ����
	%	4.�¹ʷ���ʱ���ٶȼ��ٵ���
	%�趨�¹ʸ���(0.1)
	rate = 0.1;
	c = 0;
	lastSpeech = car.speech - car.disA;
	if (lastSpeech > 0)
		if (rand <= rate)
			c = 1;
		end
	end
end
