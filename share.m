function[drugshare]=share(alpha,beta,price,N,n,tao)  %����ÿ��ҩ���г�ռ��
size=zeros(2,1);                                      %����ҩƷ��N�ַ�Ϊ����
share=zeros(2,1);                                     %������������ദ������0~N
conditionshare=0;                                     %����n��k)���Ϊ0

for j=1:N
    if j<=n(1)
        size(1)=size(1)+exp(alpha(j,1)-beta(1)*price(j,1));
    else
        size(2)=size(2)+exp(alpha(j,2)-beta(2)*price(j,2));
    end 
end

for k=1:2
  share(k)=size(k)^tao/(1+size(1)^tao+size(2)^tao);     %����ҩ���г��ݶ�
end

for k=1:2
  for i=1:N  
    conditionshare(i,k)=exp(alpha(i,k)-beta(k)*price(i,k))/size(k);   %ÿ��ҩ�������г��ݶ�
  end
end

for k=1:2
  for i=1:N
      drugshare(i,k)=conditionshare(i,k)*share(k);         %ÿ��ҩ�г��ݶ�
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
