clc
clear
load('rating_matrix.mat')
Real_Matrix=real_matrix;
m=size(real_matrix,1);
zo_real_matrix=Real_Matrix;
spaPearson=zeros(m,m);
%% 目的,求得user的间接相似度spaPearson（943*943）
Real_Matrix=real_matrix;
%得到每个用户与所有用户的相似度矩阵
for i=1:m
    i
    for j=1:m
        j
        %在i用户条件下，待填充的用户的原始评分矩阵
        newRating=Real_Matrix(j,:);
        %01处理
        zo_real_matrix(zo_real_matrix~=0)=1;
        %%首先将用户与其他用户的差集部分以预测填充 的形式补上
        %
        %将在zo_real_matrix(i,:)用户中为1的id，与zo_real_matrix(j,:)中为0的id 求他们的交集id 得到能够对B填充的项目id
        fill_ID=intersect(find(zo_real_matrix(i,:)==1), find(zo_real_matrix(j,:)==0));
        %
        %得到需要填充的目标项目，并计算其数组长度
        len_fill_ID=length(fill_ID);

        %利用slope one 算法 对  需要填充的item进行填充
        for k=1:len_fill_ID
            newRating(:,fill_ID(k))=slope(Real_Matrix,j,fill_ID(k));
        end
        spaPearson(i,j)=myPearson(Real_Matrix(i,:),newRating);
    end

end
%此矩阵中得的数据集 new_Real_Matrix是新的填充矩阵 以及spaPearson是每个用户在slope one 填充后的间接相似度
