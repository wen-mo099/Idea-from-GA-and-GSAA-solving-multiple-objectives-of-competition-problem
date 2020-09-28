function[drugshare]=share(alpha,beta,price,N,n,tao)  %计算每种药的市场占比
size=zeros(2,1);                                      %由于药品是N种分为两类
share=zeros(2,1);                                     %因此做数组冗余处理，两组0~N
conditionshare=0;                                     %超过n（k)填充为0

for j=1:N
    if j<=n(1)
        size(1)=size(1)+exp(alpha(j,1)-beta(1)*price(j,1));
    else
        size(2)=size(2)+exp(alpha(j,2)-beta(2)*price(j,2));
    end 
end

for k=1:2
  share(k)=size(k)^tao/(1+size(1)^tao+size(2)^tao);     %两类药的市场份额
end

for k=1:2
  for i=1:N  
    conditionshare(i,k)=exp(alpha(i,k)-beta(k)*price(i,k))/size(k);   %每种药的条件市场份额
  end
end

for k=1:2
  for i=1:N
      drugshare(i,k)=conditionshare(i,k)*share(k);         %每种药市场份额
  end
end
for k=1:2
    for i=1:N
        if i>n(k)
            drugshare(i,k)=0;
        end
    end
end
end
