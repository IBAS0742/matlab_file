%标*（星号）必要的，同时标 ^ 为多个选一个即可(^1表示多个标有^1的语句中，只要有一个存在即可)
%例如以下实例中，仅仅需要
%	data = int32(rand(20,20) * 60);
%	drawBeeShap(cool(61),1,3,5,data);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	*^1:data_ = [1,0,2,5;2,0,5,5;5,0,0,1;1,0,2,2];
%获知使用随机函数产生data
%	*^1:data = int32(rand(20,20) * 60);
%绘制蜂窝形状 drawBeeShap({'red','blue','green','yellow'},1,6,5,data);
%绘制三角形	drawBeeShap({'red','blue','green','yellow'},1,3,5,data);
%使用hot或cool来产生颜色
%	hot		*^2:drawBeeShap(hot(61),1,3,5,data);
%	cool	*^2:drawBeeShap(cool(61),1,3,5,data);
%	varargin : (扩展功能)
%	0	使用常量（使用于多次使用该函数时）
%		当常量是 0 时将返回常量，当常量是结构体是将使用该对象作为常量
%		*^2:c = drawBeeShap(cool(61),1,3,5,data,0,0);
%		*^2:drawBeeShap(cool(61),1,3,5,data,0,c);
%使用自动颜色
%	1	*^2:drawBeeShap(cool(61),1,3,5,data,1);
%		*^2:drawBeeShap(0,1,3,5,data,1);
%	2	*^2:drawBeeShap(cool(61),1,3,5,data,2,cool);
%		*^2:drawBeeShap(0,1,3,5,data,2,cool);
%	3	*^2:drawBeeShap(cool(61),1,3,5,data,3,@cool,61);
%		*^2:drawBeeShap(0,1,3,5,data,3,@cool,61);
%▲注意：可以在 varargin{1} == 0 其后补充颜色参数
%		*^2:drawBeeShap(cool(200),3,5,data,0,0,2,@cool)
%2017年01月18日09:29:53新增边框颜色
%例子
%	data = int32(rand(20,20) * 60);
%	drawBeeShap(cool(61),1,6,5,data);
%	>>>(等同于)    drawBeeShap(cool(61),'black',6,5,data);
%	>>>(等同于)    drawBeeShap(cool(61),[0 0 0],6,5,data);
%	drawBeeShap(cool(61),2,6,5,data);
%	drawBeeShap(cool(61),[0.5 0.5 0.5],6,5,data);
function c = drawBeeShap(colors_,borderColor,edges_,len_,data,varargin)
	%colors_        颜色【多个颜色，用于多个数值表示时可用】
    %borderColor    边框颜色
    %                   = 1 时为无边框(即黑色边框)
    %                   = 2 时为同板色边框
    %                   = [r g b] 时为默认指定边框 (也可以是颜色名 'black')
	%edges_         边的数量（例如：6【表示正六边形】）
	%len_           边的长度
	%varargin       自动补充颜色(此时第一个参数随意填写)
	%               1	自动默认颜色（仅468个）
	%               1	自动默认颜色（仅468个）
	%               2	使用函数来产生颜色，函数无参
	%                   fn	(第二个参数是一个函数)
	%               3	使用函数来产生颜色，并赋予参数值
	%                   fn,arg(随后两个参数是函数和参数)
	%c = constValue_();
	cdata = unique(data);
	colorSheet = containers.Map();
	if (length(varargin) > 0)
		varargin_offset = 0;
		if (varargin{1} == 0)
			varargin_offset = 2;
			if (strcmp(class(varargin{2}),'struct') == 1)
				c = varargin{2};
			else 
				c = constValue_();
				drawBeeShap(colors_,edges_,len_,data,0,c,varargin(:,3:length(varargin)));
				return ;
			end
		else
			c = constValue_();
		end
		if (length(varargin) <= varargin_offset) 
			return;
		end
		if varargin_offset > 0
			var_ = varargin(3);
			var_ = var_{1};
		else
			var_ = varargin;
		end
		if (var_{1} == 1)
			colors_ = c.color;
		elseif (var_{1} == 2)
			colors_ = var_{2};
			colors_ = colors_();
		elseif (var_{1} == 3)
			colors_ = var_{2};
			colors_ = colors_(var_{3});
		else
			disp(['error : 参数不正确']);
		end
	else
		c = constValue_();
	end
	if (length(cdata) <= length(colors_))
		%形成颜色表
		csize_ = size(colors_);
		if (csize_(1) == 1)
			for i = 1 : length(cdata)
				colorSheet(num2str(cdata(i))) = colors_(i);
			end
		else 
			for i = 1 : length(cdata)
				colorSheet(num2str(cdata(i))) = colors_(i,:);
			end
		end
		if (edges_ == 6)
			forSix_(c,borderColor,len_,colorSheet,data);
		elseif (edges_ == 3)
			forThree(c,borderColor,len_,colorSheet,data);
		elseif (edges_ == 4)
			forFour(c,borderColor,len_,colorSheet,data);
		end
	else
		display(['颜色值不足']);
	end
end

function [c] = constValue_() 
	%获取一些常用的数值
	c.sqrt2 = sqrt(2);
	c.sqrt2_h = sqrt(2) / 2;
	c.sqrt3 = sqrt(3);
	c.sqrt3_h = sqrt(3) / 2;
	c.pi_d6 = pi / 6;
	c.pi_d4 = pi / 4;
	c.pi_d3 = pi / 3;
	c.color = [102 102 102;102 102 153;102 102 204;102 102 255;102 153 102;102 153 153;102 153 204;102 153 255;102 204 102;102 204 153;102 204 204;102 204 255;102 255 102;102 255 153;102 255 204;102 255 255;153 102 102;153 102 153;153 102 204;153 102 255;153 153 102;153 153 153;153 153 204;153 153 255;153 204 102;153 204 153;153 204 204;153 204 255;153 255 102;153 255 153;153 255 204;153 255 255;204 102 102;204 102 153;204 102 204;204 102 255;204 153 102;204 153 153;204 153 204;204 153 255;204 204 102;204 204 153;204 204 204;204 204 255;204 255 102;204 255 153;204 255 204;204 255 255;255 102 102;255 102 153;255 102 204;255 102 255;255 153 102;255 153 153;255 153 204;255 153 255;255 204 102;255 204 153;255 204 204;255 204 255;255 255 102;255 255 153;255 255 204;255 255 255;0 0 0;0 0 51;0 0 102;0 0 153;0 0 204;0 0 255;0 51 0;0 51 51;0 51 102;0 51 153;0 51 204;0 51 255;0 102 0;0 102 51;0 102 102;0 102 153;0 102 204;0 102 255;0 153 0;0 153 51;0 153 102;0 153 153;0 153 204;0 153 255;0 204 0;0 204 51;0 204 102;0 204 153;0 204 204;0 204 255;0 255 0;0 255 51;0 255 102;0 255 153;0 255 204;0 255 255;51 0 0;51 0 51;51 0 102;51 0 153;51 0 204;51 0 255;51 51 0;51 51 51;51 51 102;51 51 153;51 51 204;51 51 255;51 102 0;51 102 51;51 102 102;51 102 153;51 102 204;51 102 255;51 153 0;51 153 51;51 153 102;51 153 153;51 153 204;51 153 255;51 204 0;51 204 51;51 204 102;51 204 153;51 204 204;51 204 255;51 255 0;51 255 51;51 255 102;51 255 153;51 255 204;51 255 255;102 0 0;102 0 51;102 0 102;102 0 153;102 0 204;102 0 255;102 51 0;102 51 51;102 51 102;102 51 153;102 51 204;102 51 255;102 102 0;102 102 51;102 102 102;102 102 153;102 102 204;102 102 255;102 153 0;102 153 51;102 153 102;102 153 153;102 153 204;102 153 255;102 204 0;102 204 51;102 204 102;102 204 153;102 204 204;102 204 255;102 255 0;102 255 51;102 255 102;102 255 153;102 255 204;102 255 255;153 0 0;153 0 51;153 0 102;153 0 153;153 0 204;153 0 255;153 51 0;153 51 51;153 51 102;153 51 153;153 51 204;153 51 255;153 102 0;153 102 51;153 102 102;153 102 153;153 102 204;153 102 255;153 153 0;153 153 51;153 153 102;153 153 153;153 153 204;153 153 255;153 204 0;153 204 51;153 204 102;153 204 153;153 204 204;153 204 255;153 255 0;153 255 51;153 255 102;153 255 153;153 255 204;153 255 255;204 0 0;204 0 51;204 0 102;204 0 153;204 0 204;204 0 255;204 51 0;204 51 51;204 51 102;204 51 153;204 51 204;204 51 255;204 102 0;204 102 51;204 102 102;204 102 153;204 102 204;204 102 255;204 153 0;204 153 51;204 153 102;204 153 153;204 153 204;204 153 255;204 204 0;204 204 51;204 204 102;204 204 153;204 204 204;204 204 255;204 255 0;204 255 51;204 255 102;204 255 153;204 255 204;204 255 255;255 0 0;255 0 51;255 0 102;255 0 153;255 0 204;255 0 255;255 51 0;255 51 51;255 51 102;255 51 153;255 51 204;255 51 255;255 102 0;255 102 51;255 102 102;255 102 153;255 102 204;255 102 255;255 153 0;255 153 51;255 153 102;255 153 153;255 153 204;255 153 255;255 204 0;255 204 51;255 204 102;255 204 153;255 204 204;255 204 255;255 255 0;255 255 51;255 255 102;255 255 153;255 255 204;255 255 255;0 0 0;0 0 51;0 0 102;0 0 153;0 0 204;0 0 255;0 51 0;0 51 51;0 51 102;0 51 153;0 51 204;0 51 255;0 102 0;0 102 51;0 102 102;0 102 153;0 102 204;0 102 255;0 153 0;0 153 51;0 153 102;0 153 153;0 153 204;0 153 255;0 204 0;0 204 51;0 204 102;0 204 153;0 204 204;0 204 255;0 255 0;0 255 51;0 255 102;0 255 153;0 255 204;0 255 255;0 0 0;0 0 51;0 0 102;0 0 153;0 0 204;0 0 255;51 0 0;51 0 51;51 0 102;51 0 153;51 0 204;51 0 255;102 0 0;102 0 51;102 0 102;102 0 153;102 0 204;102 0 255;153 0 0;153 0 51;153 0 102;153 0 153;153 0 204;153 0 255;204 0 0;204 0 51;204 0 102;204 0 153;204 0 204;204 0 255;255 0 0;255 0 51;255 0 102;255 0 153;255 0 204;255 0 255;0 0 0;0 51 0;0 102 0;0 153 0;0 204 0;0 255 0;51 0 0;51 51 0;51 102 0;51 153 0;51 204 0;51 255 0;102 0 0;102 51 0;102 102 0;102 153 0;102 204 0;102 255 0;153 0 0;153 51 0;153 102 0;153 153 0;153 204 0;153 255 0;204 0 0;204 51 0;204 102 0;204 153 0;204 204 0;204 255 0;255 0 0;255 51 0;255 102 0;255 153 0;255 204 0;255 255 0;0 0 0;17 17 17;34 34 34;51 51 51;68 68 68;85 85 85;102 102 102;119 119 119;136 136 136;153 153 153;170 170 170;187 187 187;204 204 204;221 221 221;238 238 238;255 255 255;51 51 51;51 51 102;51 51 153;51 51 204;51 102 51;51 102 102;51 102 153;51 102 204;51 153 51;51 153 102;51 153 153;51 153 204;51 204 51;51 204 102;51 204 153;51 204 204;102 51 51;102 51 102;102 51 153;102 51 204;102 102 51;102 102 102;102 102 153;102 102 204;102 153 51;102 153 102;102 153 153;102 153 204;102 204 51;102 204 102;102 204 153;102 204 204;153 51 51;153 51 102;153 51 153;153 51 204;153 102 51;153 102 102;153 102 153;153 102 204;153 153 51;153 153 102;153 153 153;153 153 204;153 204 51;153 204 102;153 204 153;153 204 204;204 51 51;204 51 102;204 51 153;204 51 204;204 102 51;204 102 102;204 102 153;204 102 204;204 153 51;204 153 102;204 153 153;204 153 204;204 204 51;204 204 102;204 204 153;204 204 204];
	c.color = c.color / 256;
end

function forSix_(c,borderColor,len_,colorSheet,data)
	%colorSheet 颜色表
	%找出第一个点 (x,y) -> (len_,sqrt(3) * len_)
	x = [len_];
	y = [c.sqrt3 * len_];
	[h_,w_] = size(data);
	%找出第一行的所有点
	%	每一个下一个点的规律是
	%		往左加3/2*len_,
	%		垂直上正负sqrt(3) / 2 * len_ （我这里是先加后减）
	dx = 1.5 * len_;
	dy = c.sqrt3_h * len_;
	for i = 2 : w_%length(data)
		x(i) = x(i - 1) + dx;
		y(i) = y(i - 1) + dy;
		dy = -dy;
	end
	%绘制第一行
	for i = 1 : w_%length(data)
		drawOneShap_(x(i),y(i),6,len_,colorSheet(num2str(data(1,i))),borderColor);
	end
	%第二行开始，每一行都是前一行高度加上sqrt(3) * len_
	dY = c.sqrt3 * len_;
	%以下边计算边绘制
	for i = 2 : h_
		for j = 1 : w_
			y(j) = y(j) + dY;
			drawOneShap_(x(j),y(j),6,len_,colorSheet(num2str(data(i,j))),borderColor);
		end
	end
end

function drawOneShap_(x_,y_,edges_,len_,color_,borderColor,varargin)
	extDeg = 0;
	if (length(varargin) == 1) 
		extDeg = varargin{1};
	end
	t = linspace(0,2*pi,edges_ + 1)' + extDeg;
	m = numel(t);
	x = repmat(x_,[m,1]) + cos(t) * len_;
	y = repmat(y_,[m,1]) + sin(t) * len_;
    if (length(color_) == 1)
        color_ = cell2mat(color_);
    %else
    end
    if length(borderColor) == 1
        if borderColor == 1
            borderColor = 'black';
        else
            borderColor = color_;
        end
    %else
    end
	patch(x,y,1,'FaceColor',color_,'EdgeColor',borderColor);
end

function forThree(c,borderColor,len_,colorSheet,data) 
	%colorSheet 颜色表
	%找出第一个点 (x,y) -> (len_ / 2,len_ / sqrt(3))
	r_ = len_ / c.sqrt3;
	extDeg = [c.pi_d6,- c.pi_d6];
	[h_,w_] = size(data);
	x = [len_ / 2];
	y = [len_ / c.sqrt3 / 2];
	%找出第一行的所有点
	%	每一个下一个点的规律是
	%		往左加len_/2,
	%		垂直上正负len_ / sqrt(3) / 2（我这里是先加后减）
	dx = len_ / 2;
	dy = len_ / c.sqrt3 / 2;
	for i = 2 : w_
		x(i) = x(i - 1) + dx;
		y(i) = y(i - 1) + dy;
		dy = -dy;
	end
	%绘制第一行
	hold on;
	for i = 1 : w_
		drawOneShap_(x(i),y(i),3,r_,colorSheet(num2str(data(1,i))),borderColor,extDeg(mod(i,2) + 1));
	end
	%第二行开始，每个偶数行都是前一行高度加上 [sqrt(3) * len_ , 2 * sqrt(3) * len_]
	%第二行开始，每个奇数行都是前一行高度加上 [2 * sqrt(3) * len_ , sqrt(3) * len_]
	dY = [2 * len_ / c.sqrt3,len_ / c.sqrt3];
	%以下边计算边绘制
	for i = 2 : h_
		isO = mod(i,2) + 1;
		for j = 1 : w_
			ex2 = mod(j + isO,2) + 1;
			y(j) = y(j) + dY(ex2);
			drawOneShap_(x(j),y(j),3,r_,colorSheet(num2str(data(i,j))),borderColor,extDeg(ex2));
		end
	end
end

function forFour(c,borderColor,len_,colorSheet,data) 
	%colorSheet 颜色表
	%找出第一个点 (x,y) -> (len_ / 2,len_ / 2)
	len__ = len_ / c.sqrt2;
	[h_,w_] = size(data);
	x = [len_ / 2];
	y = len_ / 2;
	%找出第一行的所有点
	%	每一个下一个点的规律是
	%		往左加len_/2
	%		垂直加len_/2
	dx = len_;
	for i = 2 : w_
		x(i) = x(i - 1) + dx;
	end
	%绘制第一行
	for i = 1 : w_
		drawOneShap_(x(i),y,4,len__,colorSheet(num2str(data(1,i))),borderColor,c.pi_d4);
	end
	%第二行开始，每一行都是前一行高度加上sqrt(3) * len_
	dY = len_;
	%以下边计算边绘制
	for i = 2 : h_
		y = y + dY;
		for j = 1 : w_
			drawOneShap_(x(j),y,4,len__,colorSheet(num2str(data(i,j))),borderColor,c.pi_d4);
		end
	end
end

function forFour_(c,borderColor,len_,colorSheet,data) 
	%colorSheet 颜色表
	%找出第一个点 (x,y) -> (len_ / 2,len_ / 2)
	[h_,w_] = size(data);
	x = [len_ / 2];
	y = len_ / 2;
	%找出第一行的所有点
	%	每一个下一个点的规律是
	%		往左加len_/2
	%		垂直加len_/2
	dx = len_/2;
	dy = len_/2;
	for i = 2 : w_
		x(i) = x(i - 1) + dx;
	end
	%绘制第一行
	for i = 1 : w_
		drawOneShap_(x(i),y,4,len_,colorSheet(num2str(data(1,i))),borderColor);
	end
	%第二行开始，每一行都是前一行高度加上sqrt(3) * len_
	dY = len_/2;
	%以下边计算边绘制
	for i = 2 : h_
		y = y + dY;
		for j = 1 : w_
			drawOneShap_(x(j),y,4,len_,colorSheet(num2str(data(i,j))),borderColor);
		end
	end
end
