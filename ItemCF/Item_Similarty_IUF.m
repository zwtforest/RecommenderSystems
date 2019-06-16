function ItemSimilartyIUF = Item_Similarty_IUF( Rating )
    n = size(Rating,2);
   disp('计算用于相似度')
%% 计算用户相似度
    W = zeros(n,n);
    % 矩阵N表示喜欢某物品的用户数
    Rating2 = Rating;
    Rating(find(Rating2~=0))=1;
    N=sum(Rating2,1);
    
    disp('项目相似度计算到：')
    for  row = 1:n
      
        disp(row)
        
        for col = 1:n
            if row == col
                W(row,col)=0;
            else
                fenzi = 0;
                u = intersect(find(Rating(:,row)~=0),find(Rating(:,col)~=0));
                if u ~= 0
                    for uu =1:length(u)
                        fenzi = fenzi + 1/log(1+length(find(Rating(u(uu),:)~=0)));
                    end
                end
                fenmu = sqrt(N(1,row)*N(1,col));
                if fenmu ~= 0
                    W(row,col) = fenzi/fenmu;
                else
                    W(row,col)=0;
                end
            end
        end
    end
    ItemSimilartyIUF = W;
    disp('总相似度计算完成')
    
end
