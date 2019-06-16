function [ pre ] = pre(Rating_Matrix ,userCorr,tarUser,tarItem, topUserN)

    %pre 和 pre2的区别是添加最近邻限制，pre2为对tarItem评过分的才能为最近邻
    
    Rating_Matrix(tarUser,tarItem)=0;
    %% 
    %导入相似度矩阵
    userrel=userCorr(:,tarUser);
    %得到排序后的相似度，以及对应的用户ID
    [userCorr,userID]=sort(userrel,'descend');%降序排序
    IdAndCorr=[userID,userCorr];
    tarUserSortID=find(IdAndCorr(:,1)==tarUser);
    IdAndCorr(tarUserSortID,:)=[];

    %% 得到前topUserN近邻
    tarUserNeibour=(IdAndCorr(1:topUserN,:));

    %% 对tarUser 下的tarItem 评分值预测 
    fenzi=0;

    for w=1:topUserN
        rb_aver=sum(Rating_Matrix(tarUserNeibour(w,1),:))/nnz(Rating_Matrix(tarUserNeibour(w,1),:));
        rb_p=Rating_Matrix(tarUserNeibour(w,1),tarItem);
        fen=tarUserNeibour(w,2)*(rb_p - rb_aver);
        fenzi = fenzi+fen;
    end

    rTarUserAver=sum(Rating_Matrix(tarUser,:))/nnz(Rating_Matrix(tarUser,:));
    fenmu=sum(tarUserNeibour(:,2));

    pre=rTarUserAver + fenzi/fenmu;

end

