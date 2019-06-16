clc
clear
load 'rating_matrix'
load 'spaPearson'
load 'directPearson'
Rating_Matrix=real_matrix;
spaPearson=spaPearson';

spaUserCorr=spaPearson;
dirUserCorr=directPearson;
%% 
tarUser=[2,8,10,50,36,89];
tarItem=[1,3,9,103,306,607,802];


%% 预测
for k=10:10:50
    topUserN=k;
    sumMAE=0;
    for i=1:length(tarUser)
        for j=1:length(tarItem)
            preRating=pre(Rating_Matrix ,dirUserCorr,tarUser(i),tarItem(j),topUserN );
            mae=abs(preRating-Rating_Matrix(tarUser(i),tarItem(j)));
            sumMAE=sumMAE + mae;
        end

    end
    %% MAE
    directMAE(k/10)=sumMAE/(length(tarUser)*length(tarItem));
end

for k=10:10:50
    topUserN=k;
    sumMAE=0;
    for i=1:length(tarUser)
        for j=1:length(tarItem)
            preRating=pre(Rating_Matrix ,spaUserCorr,tarUser(i),tarItem(j),topUserN );
            mae=abs(preRating-Rating_Matrix(tarUser(i),tarItem(j)));
            sumMAE=sumMAE + mae;
        end

    end
    %% MAE
    spaMAE(k/10)=sumMAE/(length(tarUser)*length(tarItem));
end
figure(1);plot(directMAE,'k^-')
hold on
plot(spaMAE,'k-s')
title('平均绝对误差对比图');xlabel('最近邻个数');
ylabel('平均绝对误差');
set(gca,'xtick',1:1:5);
set(gca,'XTickLabel',{'10','20','30','40','50'});
legend('CF','FSODCF');