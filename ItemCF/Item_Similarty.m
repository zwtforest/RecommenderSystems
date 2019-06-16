function ItemSimilartyIUF = Item_Similarty( Rating )
    [m,n]=size(Rating);
    %% 1.建立用户物品倒排表
    Daopb = zeros(m,n);
    for i = 1:m
        [x,y] = sort(Rating(i,:),'descend');
        Daopb(i,:) = y;
        id = find(x==0);
        Daopb(i,id)=0; 
    end
    disp('Item_Similarty 倒排表完成')
    %% 计算共现矩阵
    Gongxjz = zeros(n,n);
    for u=1:m
        userLoveItem = Daopb(u,find(Daopb(u,:)~=0));
        lenLoveItem=length(userLoveItem);
        x=zeros(n,n);
        for k=1:lenLoveItem
            x(userLoveItem(k),userLoveItem(setdiff(1:lenLoveItem, k)))=1;
        end
        Gongxjz=Gongxjz+x;
    end
    disp('Item_Similarty 共现矩阵完成')
%% 计算用户相似度
    W = zeros(n,n);
    % 矩阵N表示喜欢某物品的用户数
    Rating2 = Rating;
    Rating2(find(Rating2~=0))=1;
    N=sum(Rating2,1);
    for  row = 1:n
        for col = 1:n
            if row == col
                W(row,col)=0;
            else
                fenzi = abs(Gongxjz(row,col));
                fenmu = sqrt(N(1,row)*N(1,col));
                if fenmu ~= 0
                    W(row,col)=fenzi/fenmu;
                else
                    W(row,col)=0;
                end
            end
        end
    end
    ItemSimilartyIUF = W;
    disp('Item_Similarty 总相似度完成')
    
end
