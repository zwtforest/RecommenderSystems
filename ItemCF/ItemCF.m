function [accRate,coverage] = ItemCF(real_matrix,ratio,NeibourK,N)
    %% 将评分数据导入到工作区
    Rating=real_matrix;
    [m,n] = size(Rating);
    
    TestS = zeros(m,n);
    TrainS = zeros(m,n);


    %% 随机抽取20%作为测试集,剩下的80%作为训练集

    for user_id = 1:m
        for item_id = 1:n
            if  Rating(user_id,item_id)~=0
                randNum = rand();
                if randNum < ratio
                    TrainS(user_id,item_id) = Rating(user_id,item_id);
                else
                    TestS(user_id,item_id) = Rating(user_id,item_id);
                end
            end
        end
    end


%     for user_id = 1:m
%          Watched = find(Rating(user_id,:)~=0);
%          lenWatched = length(Watched);
%          lenTr = round(ratio*lenWatched);
% 
%          randWatched = randperm(lenWatched);
%          TrainS(user_id,randWatched(1:lenTr)) = Rating(user_id,randWatched(1:lenTr));
%          TestS(user_id,randWatched(lenTr+1:lenWatched)) = Rating(user_id,randWatched(lenTr+1:lenWatched));
%     end
    %% 计算项目间的相似度，得到项目相似度矩阵ItemSimilarty[1682*1682]

    ItemSimilarty = Item_Similarty(TrainS);

    %% 对测试集User进行Item兴趣度预测

    InterestP = zeros(m,n);
    W = ItemSimilarty;
    
    ItemNeiK = zeros(n,NeibourK);
    for  item_id = 1:n
        %ItemNeiK是ItemID和第i个项目最相近的物品集合
        [z,SItemSort] = sort(W(item_id,:),'descend');
        ItemNeiK(item_id,:) = SItemSort(1:NeibourK);
    end
    disp('所有ItemID的k近邻物品集 完成')

    for UserId = 1:m
        %N(u)是用户评过分的项目集合
        NuItem= find(TrainS(UserId,:)~=0);
        for ItemId = 1:n

            

            %Jiaoji为用户历史喜欢过的物品集和第ItenID项目最相近的项目集的交集
            Jiaoji = intersect(ItemNeiK(ItemId,:),NuItem);


            pui=0;
            if length(Jiaoji) >= 1
                % 计算兴趣度
                for j=1:length(Jiaoji)
                    p = W(ItemId,Jiaoji(j))* TrainS(UserId,Jiaoji(j));
                    pui = pui + p;
                end   
            end

            InterestP(UserId,ItemId) = pui;
        end
    end

    %% 将测试用户对项目的兴趣度按降序排序
    sortInterestItem = zeros(m,n);
    for i=1:m
        [PL,PitemId] = sort(InterestP(i,:),'descend');
        sortInterestItem(i,:) = PitemId;
    end

    %% 推荐准确率计算
    %当推荐列表为N时，对比前N个和测试集有多少相同的项目

    accNum = zeros(m,1);
    for tu = 1:m
        Testid = find(TestS(tu,:) ~= 0);
        accNum(tu,1) = length(intersect(Testid,sortInterestItem(tu,1:N)));
    end
    accRate = sum(accNum)/(N*m);
    disp('ItemCF 的准确率为：')
    disp(accRate)
    %% 推荐覆盖率计算

    recItem = sortInterestItem(:,1:N);
    recDiff = length(unique(recItem));
    
    coverage = recDiff/n;
    disp('ItemCF 的覆盖率为:')
    disp(coverage)


end

