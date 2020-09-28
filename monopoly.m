clc;clear;
N=10;n(1)=6;n(2)=N-n(1);    %定义药品种类数目
delta=rand(N,1);          %定义其他参数
w=rand(N,2);
beta(1)=0.5;beta(2)=0.7;
alpha=rand(N,2);
for h=1:100
tao=0.01*h;
% drugshare=share(alpha,beta,price,N,n,tao);
% Pi=0;
% for k=1:2
%     for i=1:n(k)
%         Pi=Pi+drugshare(i,k)*(price(i,k)-w(i,k));    %垄断零售商利润
%     end
% end
A=zeros(2,1);
for k=1:2
    for i=1:n(k)
        A(k)=A(k)+exp(alpha(i,k)-beta(k)*w(i,k));
    end
    A(k)=exp(-1)*A(k)^tao;
end
func=@(x)A(1)*exp(-beta(1)*tao*x)/(beta(1)*tao)+A(2)*exp(-beta(2)*tao*x)/(beta(2)*tao)-x;
x=fzero(func,5)   
for k=1:2
    for i=1:n(k)
        price(i,k)=x+1/(beta(k)*tao)+w(i,k);          %最优price表达形式
    end
end
temp=zeros(2,1);
for k=1:2
    for j=1:n(k)
        temp(k)=temp(k)+exp(alpha(j,k)-beta(k)*w(j,k));
    end
end
for k=1:2
    for i=1:n(k)
        drugshare(i,k)=[A(k)*exp(-beta(k)*tao*x)/(1+A(1)*exp(-beta(1)*tao*x)+A(2)*exp(-beta(2)*tao*x))]*exp(alpha(i,k)-beta(k)*w(i,k))/temp(k);
    end
end
drug_share_value(:,:,h)=drugshare;
non_out(h)=sum(drugshare(:))
tao_value(h)=tao;
x_value(h)=x;
end
for k=1:2
    for i=1:n(k)
       plot(tao_value,squeeze(drug_share_value(i,k,:)));
       xlabel("Degree of dissimilarity among drugs(τ)");
       ylabel("market share");
       hold on;
    end
end
%plot(tao_value,squeeze(drug_share_value(3,2,:)));
hold off;
%plot(tao_value,non_out);