# RecommenderSystems

#### 主要是对推荐系统常用算法 **matlab** 代码版的编写。

---
包括了Pearson相似度算法，基于用户的UserCF算法，基于物品的ItemCF算法，slope one算法，TopN推荐，MAE，RMSE，topN推荐准确度，覆盖率计算等常用算法

---
[基于物品的协同过滤推荐](https://github.com/zwtforest/RecommenderSystems/tree/master/ItemCF)

[基于用户的协同过滤推荐](https://github.com/zwtforest/RecommenderSystems/tree/master/UserCF目标项目预测&误差计算MAE)

[Pearson直接相似度](https://github.com/zwtforest/RecommenderSystems/tree/master/Pearson直接相似度)

[改进的基于物品的ItemCF-IUF相似度](https://github.com/zwtforest/RecommenderSystems/tree/master/ItemCF)

[基于slopeOne的稀疏数据填充&得出的间接相似度](https://github.com/zwtforest/RecommenderSystems/tree/master/基于slopeOne的稀疏数据填充&得出的间接相似度)

---

>实验代码是两年前写的，编写不太规范，且有些程序时间复杂度上较高，先存在这上面，供以后有需要时在温故、翻新。

#### 关于编写协同过滤推荐算法代码中的一些需要注意的参数细节：


由于推荐系统方面学术研究方面大多是是离线实验，且实验参数较多，每个学者改进的点不一样各固定参数可能与别的学者很少出现全部一直，所有完全复制一篇论文中的实验结果是极其困难的。且很多学者在文章中并没有交代，比如数据集中测试集和训练集的划分比例、实验次数、随机划分策略、目标用户和目标项目的占项目的比例、由于传统公式的缺陷性各种为出现无穷大和为1或者为0时的处理、近邻数量的设置、推荐列表长度的设置等等，所有的这些，有一个参数不一样，实验数据都会发生很大的变化。

---
那些曾经踩过的坑，待续……

---




