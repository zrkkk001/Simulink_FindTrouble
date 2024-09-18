% V1.0
% 2024-05-09
% zrkkk
% MATLAB 2021
a=get(gcbh);

pause('on');
finda1=1; %编程语言
finda2=0;%数据类型有无写成doubel的 ，目前管得太宽了报错严重
finda3=1; %去除 仿真时添加在chart里面的观测信号 
finda4=0; % 在仿真时  添加在chart里面的观测信号
%%利用正则表达式对 3 4 5 点进行逐一搜索 
%(?<![*/])/(?!(single|\*|/|.*?\.))
%(?<!;\s{0,9})(?![\r\n])\}
%(max|min)\((.*,\d*[^.]|\d[^.])\)
%%
ch = find(sfroot,"-isa","Stateflow.Chart");
for iii =1:length(ch)
parent = find(ch(iii),"-isa","Stateflow.Data");

    if finda1==1&& ch(iii).ActionLanguage~="C"
    view(ch(iii));
     st=msgbox(ch(iii).Name)   ;
jFrame = get(st,'JavaFrame');
drawnow;
jFrame.fHG2Client.getWindow.setAlwaysOnTop(true);
uiwait(st)
    end

    for ii =1:length(parent)
        if parent(ii).DataType=="double" && finda2==1
           view(ch(iii));
           st=msgbox(parent(ii).Name)   ;
           jFrame = get(st,'JavaFrame');
           drawnow;
           jFrame.fHG2Client.getWindow.setAlwaysOnTop(true);
           uiwait(st)
        end

        if (get(parent(ii).LoggingInfo,'DataLogging'))==1 && finda3==1
           set(parent(ii).LoggingInfo,'DataLogging',0);
        end
    end
end

a=get_param(gcbh,"Name");
ch = find(sfroot,"-isa","Stateflow.Chart",'name',a);
parent = find(ch,"-isa","Stateflow.Data",'Scope','local');
 if finda4==1
    for ii=1:length(parent)
      set(parent(ii).LoggingInfo,'DataLogging',1);
       set(parent(ii),'TestPoint',1);
    end
end

 pause('off');
 pause('on');
