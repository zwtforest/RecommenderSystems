clc
clear
load 'rating_matrix'
Rating_Matrix=real_matrix;
%length是计算矩阵列的长度
[line,row]=size(Rating_Matrix);
%% 
%设置测试的目标用户数量
%numTarUser=floor(0.05*line);
%随机打乱的用户id
%randLine=round(rand(1,numTarUser)*line);
%随机选择前numTaruser个
%tarUser=Rating_Martix(randLine(1:numTarUser),:);
tarUser=1;
%% 
%设置最近邻用户N
topUserN=10;
%% 
userrel=abs(corr(Rating_Matrix(tarUser,:)',Rating_Matrix'));
[userCorr,userID]=sort(userrel,'descend');%降序排序
IdAndCorr=[userID',userCorr'];
tarUserSortID=find(IdAndCorr(:,1)==tarUser);
IdAndCorr(tarUserSortID,:)=[];

tarUserNeibour=(IdAndCorr(1:topUserN,:));
for j=1:topUserN
    numCli=find(Rating_Matrix(tarUserNeibour(j,1),:)~=0);
end
%% 选择测试集
allPayItemID=find(Rating_Matrix(tarUser,:)~=0);
allPayItemLength=length(find(Rating_Matrix(tarUser,:)~=0));
randItem=randperm(allPayItemLength);
TextItemLength=floor(0.2*allPayItemLength);
%随机打乱的不为0的物品ID
textItemID=allPayItemID(randItem(1:TextItemLength));

%随机选择前numTextItem个

%diff=setdiff(allPayItemID,textItemID);
%same=intersect(allPayItemID,textItemID);

%allPayItemID
%将测试集物品ID置0
newRating_Matrix=Rating_Matrix;
newRating_Matrix(tarUser,textItemID)=0;

tarItem=find(newRating_Matrix(tarUser,:)==0);
%% 对所有未评分项目进行预测
%推荐列表长度设置topItemN=15;
%计算准确率、召回率

%取近邻用户评价过的商品的并集 与 tarItem交集
%对这些项目进行评分预测
newPayItemID=find(newRating_Matrix(tarUser,:)~=0);
rTarUserAver=sum(newRating_Matrix(tarUser,newPayItemID))/nnz(newRating_Matrix(tarUser,:));
fenmu=sum(tarUserNeibour(:,2));
for w=1:topUserN
    rNeiAver=sum(newRating_Matrix(tarUserNeibour(w,1),:))/nnz(newRating_Matrix(tarUserNeibour(w,1),:));
    fenz=tarUserNeibour(w,2)*(newRating_Matrix(tarUserNeibour(w,1),20)-rNeiAver);
    fenzi = fenz+fenz;
end
pre=rTarUserAver + fenzi/fenmu




