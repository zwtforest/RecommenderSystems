function [ ] = plotUserItem( Rating_Matrix,tarUser )

%% 
%设置最近邻用户N
topUserN=10;
userrel=abs(corr(Rating_Matrix(tarUser,:)',Rating_Matrix'));
[userCorr,userID]=sort(userrel,'descend');%降序排序
IdAndCorr=[userID',userCorr'];
tarUserSortID=find(IdAndCorr(:,1)==tarUser);
IdAndCorr(tarUserSortID,:)=[];

%IdAndCorr(tarUser,:)=[];

tarUserNeibour=(IdAndCorr(1:topUserN,:));
for j=1:topUserN
    numCli=find(Rating_Matrix(tarUserNeibour(j,1),:)~=0);
    plot(numCli,'-.');
    hold on
end
hold on 
plot(find(Rating_Matrix(tarUser,:)~=0),'+')

end

