function [ pre ] = pre2(Rating_Matrix ,userCorr,tarUser,tarItem, topUserN)

    %pre 和 pre2的区别是添加最近邻限制，pre2为对tarItem评过分的才能为最近邻
    % 经实验分析：添加pre2的条件后，平均绝对误差会变大，且个别项目存在被评分的
    %用户过少，导致低于索引最低值topN,同时也会面临，同时这种条件限制可能会导致
    %即使关系度不大，为了选择出topN个，而降低准确率，这也是MAE 值变大的原因
    %最可怕的是有些item 评分用户总数还没有topN个呢，这就意味着该item预测时，很难找到
    %tarUser的最近邻，以及整体的维度不一致等问题……
    %这里我们对用户对tarItem评分为0，我们可以理解为未评分，也可以理解未评分就是评分就是0来计算
    Rating_Matrix(tarUser,tarItem)=0;
    %% 
    %导入相似度矩阵
    userrel=userCorr(:,tarUser);
    %得到排序后的相似度，以及对应的用户ID
    [userCorr,userID]=sort(userrel,'descend');%降序排序
    IdAndCorr=[userID,userCorr];

    %% 得到前topUserN近邻
    %近邻规则：1.对tarItem评过分的用户
    new_Id=find(Rating_Matrix(IdAndCorr(:,1),tarItem)~=0);

    new_IdAndCorr=IdAndCorr(new_Id,:);
    if size(new_IdAndCorr,1) < topUserN
        topUserN=size(new_IdAndCorr,1);
        tarUserNeibour=new_IdAndCorr;
    else
        tarUserNeibour=(new_IdAndCorr(1:topUserN,:));
    end

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

