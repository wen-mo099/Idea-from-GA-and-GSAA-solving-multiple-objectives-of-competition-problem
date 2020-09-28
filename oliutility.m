function [condition_share,expect_utility] = oliutility(miu,lamuta,gamma,alpha,qulity,beita,xita,price,M,N)  %函数计算消费者在j买药的期望效用
sum=zeros(M+1,1);
for j=1:M+1
  for k=1:N
    sum(j)=sum(j)+exp((lamuta(j)+gamma(k)+alpha*qulity(k)-beita*(1-xita)*price(k,j))/miu);
  end
end
for j=1:M+1
    for i=1:N
        condition_share(i,j)=exp((lamuta(j)+gamma(i)+alpha*qulity(i)-beita*(1-xita)*price(i,j))/miu)/sum(j);
    end
end

expect_re=zeros(M+1,1);
expect_utility=zeros(M+1,1);
for j=1:M+1
  for i=1:N
      expect_re(j)=expect_re(j)+exp((lamuta(j)+gamma(i)+alpha*qulity(i)-beita*(1-xita)*price(i,j))/miu);
  end
  expect_utility(j)=miu*log(expect_re(j));
end
end

