clc
clear
load 'rating_matrix'
load 'directPearson'
Rating_Matrix=real_matrix;
userCorr=directPearson;
%% 
% tarUser=1;
% tarItem=10;
topUserN=30;

%
[line1,row]=size(Rating_Matrix);
line=size(directPearson,1);
userRand=randperm(line);
tarUser=userRand(1:round(0.1*line));

%% Ô¤²â
sumMAE=0;
for i=1:length(tarUser)
    i
    ItemRand=randperm(row);
    tarItem=ItemRand(1:round(0.1*row));
    for j=1:length(tarItem)
        preRating=pre(Rating_Matrix ,userCorr,tarUser(i),tarItem(j),topUserN );
        mae=abs(preRating-Rating_Matrix(tarUser(i),tarItem(j)));
        sumMAE=sumMAE + mae;
    end
%% MAE
    
end
MAE=sumMAE/(length(tarUser)*length(tarItem))