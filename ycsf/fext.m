function [d_mp,dis] = fext()
    d_mp = @(x,y,minlen)fun_d_mp(x,y,minlen);
    dis = @(x,y)Dis_(x,y);
end

function fun_d_mp(x,y,minlen)
    plot(x,y,'-o');
    title(strcat('min length :  ',minlen));
end

function [M] = Dis_(x,y)
    M = [];
    for i = 1 : length(x)
        for j = 1 : length(y)
            M(i,j) = sqrt((x(i) - x(j)) ^ 2 + ...
                          (y(i) - y(j)) ^ 2);
            M(j,i) = M(i,j);
        end
    end
end
