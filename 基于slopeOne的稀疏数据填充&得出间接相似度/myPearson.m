function coeff = myPearson(X , Y)  
% 本函数实现了皮尔逊相关系数的计算操作  
%  
% 输入：  
%   X：输入的数值序列  
%   Y：输入的数值序列  
%  
% 输出：  
%   coeff：两个输入数值序列X，Y的相关系数  
%  
  
  
if length(X) ~= length(Y)  
    error('两个数值数列的维数不相等');  
end  
  
fenzi = sum(X .* Y) - (sum(X) * sum(Y)) / length(X);  
fenmu = sqrt((sum(X .^2) - sum(X)^2 / length(X)) * (sum(Y .^2) - sum(Y)^2 / length(X)));  
coeff = fenzi / fenmu;  
  
end %函数myPearson结束  