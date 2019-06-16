clc
clear
load 'rating_matrix'
Rating_Matrix=real_matrix;
%全部用户相似度矩阵
userCorr=abs(corr(Rating_Matrix',Rating_Matrix'));
topUserN=30;
topItemN=50;
%% 
tarUser=2;
%% 
%确定tarItem
%先选择出tarUser不为0的项目，再在里面选出20%作为测试集当选为tarItem
allPayItemID=find(Rating_Matrix(tarUser,:)~=0);
allPayItemLength=length(allPayItemID);
%选择前20%个作为测试集tarItems
TextItemLength=round(0.2*allPayItemLength);
%生成随机打乱的姓名：从1到allPayItemLength,共allPayItemLength个
randItem=randperm(allPayItemLength);
%选择出测试集tarItem
textItemID=allPayItemID(randItem(1:TextItemLength));
%% 将该用户测试集的item全部置为0，然后对所有未评分的项目进行预测，计算其推荐列表的准确率/覆盖率
bridge=Rating_Matrix(tarUser,:);
Rating_Matrix(tarUser,textItemID)=0;
%预测
tarItem=find(Rating_Matrix(tarUser,:)==0);
preRating=zeros(2,length(tarItem));
for j=1:length(tarItem)
    preRating(1,j)=tarItem(j);
    preRating(2,j)=pre(Rating_Matrix ,userCorr,tarUser,tarItem(j),topUserN );
end
%下一个用户时,复原数据集
Rating_Matrix(tarUser,:)=bridge;
%对项目预测值进行排序,得到推荐列表listItemN
sort_PreRat=sortrows(preRating',-2);
listItemAndpreR=sort_PreRat(1:topItemN,:);
listItemAndpreR=listItemAndpreR';
%
[c,ia,ib]=intersect(listItemAndpreR(1,:),textItemID);
%正确率(命中率)、召回率
acc=length(c)/topItemN;
zhaohui=length(c)/TextItemLength;

%%  后续也可以对测试集再次更改：
%   改为将所有评分的项目，随机等分8份，分别计算这8次的正确率、召回率平均值
%   当然不该也行