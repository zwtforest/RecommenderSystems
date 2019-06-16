%% 得到每个用户与其他用户的直接相似度矩阵相似度
clc
clear
load('rating_matrix.mat')
Real_Matrix=real_matrix;
m=size(Real_Matrix,1);
directPearson=abs(corr(Real_Matrix',Real_Matrix'));