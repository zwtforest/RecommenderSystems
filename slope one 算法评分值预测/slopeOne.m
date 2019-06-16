
clc
clear
load 'rating_matrix'
Rating_Matrix=real_matrix;


fenmu=0;
fenzi=0;


tarUser=1;
tarItem=10;

Rating_Matrix(tarUser,tarItem)=0;

payItems=find(Rating_Matrix(tarUser,:)~=0);
for i=1:length(payItems)
    TarAndpayItemUserID=find(Rating_Matrix(:,payItems(i))~=0 & Rating_Matrix(:,tarItem)~=0);
    TarAndpayItemUserNum=length(TarAndpayItemUserID);
    if TarAndpayItemUserNum~=0
    
        R_tar_pay =  sum(Rating_Matrix(TarAndpayItemUserID,payItems(i))-Rating_Matrix(TarAndpayItemUserID,tarItem))/TarAndpayItemUserNum;


        weigthpayItem=TarAndpayItemUserNum * (Rating_Matrix(tarUser,payItems(i))-R_tar_pay);

        fenzi= fenzi+ weigthpayItem

        fenmu=fenmu+TarAndpayItemUserNum;
    end
    
end
if fenmu==0
    preciTarItem=0;
else
    preciTarItem=fenzi/fenmu;
end