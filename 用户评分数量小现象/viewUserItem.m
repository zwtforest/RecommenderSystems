clc
clear
load 'rating_matrix'
Rating_Matrix=real_matrix;
%length是计算矩阵列的长度
[line,row]=size(Rating_Matrix);
%% 
%设置测试的目标用户数量
numTarUser=floor(0.05*line);
%随机打乱的用户id
randLine=round(rand(1,numTarUser)*line);
%随机选择前numTaruser个
tarUser=randLine(1:numTarUser);
%% 
for i=1:numTarUser
    figure(i)
    plotUserItem(Rating_Matrix,tarUser(i));
end