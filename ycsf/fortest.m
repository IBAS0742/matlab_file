%fortest(100,'Using 100 points create one shortest path.');
function fortest(pointnumber,showMessage)
    a=rand(2,pointnumber);
    [f_d_mp,f_dis] = fext();
    %c = max(a');
    %yichuansuanfa(a(1,:),a(2,:),f_dis,100,50,false,c(1),c(2),10,f_d_mp,true);
    yichuansuanfa(a(1,:),a(2,:),f_dis,100,50,false,0,0,10,f_d_mp,showMessage);
end