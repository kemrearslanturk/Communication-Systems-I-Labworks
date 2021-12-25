
function MSE=MSE_KorkutEmre_Arslanturk(x,y)

m=256; n=256;

temp=sum((x-y).^2);
MSE= sum(temp,2)/(m*n);
     


end

