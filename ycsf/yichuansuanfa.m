%%Test Using : fortest.m is something you can write .
%load xiaohongshuju/shuju.txt
%x = shuju(:,1:2:7);
%x = x(:)';
%y = shuju(:,2:2:8);
%y = y(:)';
%%f_dis = @(x,y)Dis_(x,y);
%%f_d_mp = @(x,y)fun_d_mp(x,y);
%[f_dis,f_d_mp] = fortest();
%yichuansuanfa(x,y,f_dis,100,50,true,70,40,10,f_d_mp);

function [pathmin,flongmin,numtime] = ...
                                        yichuansuanfa(x,...
                                                      y,...
                                                      fun_Dis,...
                                                      gens_Count,...
                                                      gen_Count,...
                                                      ihaveInsert,...
                                                      insX,...
                                                      insY,...
                                                      times,...
                                                      fun_DearWith_MiniPath,...
                                                      isShowMessage...
                                                     )
	%x                      >>> x label
    %y                      >>> y label
    %fun_Dis                >>> the distance calculate function
    %...format              :   [dis] = fun_Dis(x,y);
    %gens_Count             >>> the count of the gens
    %gen_Count              >>> the count of the genarations
    %ihaveInsert            >>> is it have a point be pointed as start point
    %insX                   >>> the point (if have) which will be see as the start point and its' X label 0
    %insY                   >>> the point (if have) which will be see as the start point and its' Y label 0
    %times                  >>> the process will execute times 
    %fun_DearWith_MiniPath  >>> one function to dear with the mini path (dear with the result)
    %...format              :   fun_DearWith_MimiPath(x,y,title);
    %isShowMessage          >>> wheater to show the message to let you know where the program going
    
    %x,y => dis
    if ihaveInsert
        x = [insX,x,insX];
        y = [insY,y,insY];
    else
        x = [x,x(1)];
        y = [y,y(1)];
    end
    %calculate all the distance of all the point to point
    Dis = fun_Dis(x,y);
    len = size(Dis);
    len = len(1);
    flongmin = inf;
    for time = 1 : times
        %len : one gen length
        if isShowMessage
            disp(['[*1*]',num2str(time),'th times going ...']);
        end
        chis = [];
        %form gens_Count gens as the first generation
        for i = 1 : gens_Count
            tchi = Randperm(len - 2);
            chi = [1,tchi+1,len];
            %make it route have not cross
            for t=1:len
                flag=0;
                for m=1:len - 2;
                    for n=m+2:len - 1
                        if Dis(chi(m),chi(n))+Dis(chi(m+1),chi(n+1))<Dis(chi(m),chi(m+1))+Dis(chi(n),chi(n+1))
                            chi(m+1:n)=chi(n:-1:m+1);
                            flag=1;
                        end
                    end
                end
                if flag==0;
                    chis(i,chi)=1:len;
                    break
                end
            end
        end
        if isShowMessage
            disp(['[*2*]',num2str(time),'th times get First Child done ...']);
        end
        
        %make the first horizon line equal zeor
        chis(:,1) = 0;
        chis = chis / len;
        %to hybridization
        for gc = 1 : gen_Count
            A=chis;
            c=randperm(gens_Count); % to decise which one hyb with which one
            if isShowMessage
                disp(['[*3*]',num2str(time),'th times__', num2str(gc),'th generation begining to hybrization ...']);
            end
            for i=1:2:gens_Count - 1
                F=2+floor((len - 2)*rand(1));
                temp=A(c(i),[F:len]);
                A(c(i),[F:len])=A(c(i+1),[F:len]);
                A(c(i+1),[F:len])=temp;
            end
            if isShowMessage
                disp(['[*4*]',num2str(time),'th times__', num2str(gc),'th generation begining to varation ...']);
            end
            by=[];
            while ~length(by)   % 10% gens will happen to varation
                by=find(rand(1,gens_Count)<0.1);
            end
            B=A(by,:);  %Varation gens number
            for j=1:length(by)
                bw=sort(2+floor((len - 2)*rand(1,3)));
                B(j,:)=B(j,[1:bw(1)-1,bw(2)+1:bw(3),bw(1):bw(2),bw(3)+1:len]);
            end
            G=[chis;A;B];  %J is the nature A is hybrid B is Varation
            [SG,indl]=sort(G,2);    % sort by the horizon
            num=size(G,1);          % the number of the G (equal the count of gens)
            long=zeros(1,num);
            for j=1:num
                for i=1:len - 1
                    long(j)=long(j)+Dis(indl(j,i),indl(j,i+1));
                end
            end
            [slong,ind2]=sort(long);
            chis=G(ind2(1:gens_Count),:);           %get the top w BETTER gens
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%
            xx=x(indl(ind2(1),:));
            yy=y(indl(ind2(1),:));
            fun_DearWith_MiniPath(xx,yy,num2str(slong(1)));
            pause(0.001)
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end    

        %get the mini Path
        path=indl(ind2(1),:);flong=slong(1);
        if flongmin>=flong
            if flongmin>flong
                flongmin=flong;
                pathmin=path;
                numtime=1;
            else
                numtime=numtime+1;
            end
        end
    end
    xx=x(pathmin);
    yy=y(pathmin);
    fun_DearWith_MiniPath(xx,yy,num2str(flongmin));
    %plot(xx,yy,'-o')
end

%create n integer from one to n's and not repeat
function M = Randperm(n)
    rL = rand(1,n);
    [n,M] = sort(rL);
end

ÿÿ