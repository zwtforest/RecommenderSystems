%%
%本程序未封装成函数
%直接修改赋值，计算预测值以及MAE偏差
%方便测试、单个实验
%pre为该程序的函数版本，传递相应的参数即可
%在preMain文件下可直接调用运行pre函数
%在simplePreMain文件下也可直接调用运行pre函数 以此计算预测值，以及平均绝对误差大小
clc
clear
load 'rating_matrix'
load 'directPearson'
%% 
Rating_Matrix=real_matrix;%%记得修改成自己文件的名字
%% 
%设置最近邻用户N
topUserN=20;
%目标用户
tarUser=1;
%目标项目
tarItem=10;
Rating_Matrix(tarUser,tarItem)=0;
%% 
%导入相似度矩阵
userrel=directPearson(:,tarUser);%%修改成自己文件的名字

%得到排序后的相似度，以及对应的用户ID
[userCorr,userID]=sort(userrel,'descend');%降序排序
IdAndCorr=[userID,userCorr];

%去除自身
tarUserSortID=find(IdAndCorr(:,1)==tarUser);
IdAndCorr(tarUserSortID,:)=[];

%% 得到前topUserN近邻
%近邻规则：1.对tarItem评过分的用户
% new_Id=find(Rating_Matrix(IdAndCorr(:,1),tarItem)~=0);
% 
% new_IdAndCorr=IdAndCorr(new_Id,:);
% tarUserNeibour=(new_IdAndCorr(1:topUserN,:));
tarUserNeibour=(IdAndCorr(1:topUserN,:));
%% 对tarUser 下的 tarItem 评分值预测 
fenzi=0;

for w=1:topUserN
    rb_aver=sum(Rating_Matrix(tarUserNeibour(w,1),:))/nnz(Rating_Matrix(tarUserNeibour(w,1),:));
    rb_p=Rating_Matrix(tarUserNeibour(w,1),tarItem);
    fen=tarUserNeibour(w,2)*(rb_p - rb_aver);
    fenzi = fenzi+fen;
end
rTarUserAver=sum(Rating_Matrix(tarUser,:))/nnz(Rating_Matrix(tarUser,:));
fenmu=sum(tarUserNeibour(:,2));

%% 
pre=rTarUserAver + fenzi/fenmu
MAE=pre-real_matrix(tarUser,tarItem)


