clc;clear;
N=10; %����ҩƷ������Ŀ
M=5;                     %���������������Ŀ,ȡʵ��ΪM+1
gamma=rand(N,1);          %������������,gammaΪҩ����������  
qulity=rand(N,1);   %ҩƷ����
lamuta=ones(M+1,1);  %ҩƷ������
%kexi=ones(N,M+1);
w=0.7+0.1*ones(N,M+1);  %ҩƷ��ģ�۸�
price=ones(N,M+1);
xita=zeros(M+1,1);  %��������
xita(M+1)=0.5;
beta=1;
alpha=1;
tao=0.8;
for h=1:100
miu=0.01*h;
for i=1:N
    for j=1:M+1
        a(i,j)=(lamuta(j)+gamma(i)+alpha*qulity(i))/miu;         %a��b��ֵ����
    end
end
for i=1:M+1
b(i)=beta*(1-xita(i))/miu;
end
temp=0;
for i=1:N
    temp=temp+exp(a(i,M+1)-b(1)*price(i,M+1));
end
temp2=0;
for j=1:M         %��A��ֵ�������̵�������������
    for i=1:N
        temp2=temp2+exp(a(i,j)-b*w(i,j));
    end
    A_bar(j)=exp(-1)*(temp^-1*temp2)^miu;
end
fun=@(t)t+V(t*A_bar(1))+V(t*A_bar(2))+V(t*A_bar(3))+V(t*A_bar(4))+V(t*A_bar(5))-1
d0=fzero(fun,0.5)
for i=1:N                %�г�����ҩ��۸�
    for j=1:M
        price(i,j)=1/(b*miu)*1/(1-V(A_bar(j)*d0))+w(i,j);
    end
end
for j=1:M             %�������������г�ռ��
    d_tailershare(j)=V(A_bar(j)*d0);
end
temp=0;
 for i=1:N
    temp=temp+exp(a(i,j)-b*w(i,j));
 end
for j=1:M       %�г�����ҩ��ռ��
    for i=1:N
        d_drugshare(i,j)=d_tailershare(j)*exp(a(i,j)-b*w(i,j))/temp;
    end
end
miu_value(h)=miu;
non_out(h)=sum(sum(d_drugshare))
d_drugshare_value(:,:,h)=d_drugshare;
price_value(:,:,h)=price;
end
% for i=1:N                                         %��ͼ����*****
%     for j=1:M                                                  %
%        plot(miu_value,squeeze(price_value(i,j,:)));            %
%        xlabel("Degree of dissimilarity among drugs(�� )");     %
%        ylabel("market share");                                 %
%        hold on;                                                %
%     end                                                        %
% end                                                            %
%plot(miu_value,non_out);                           %��ͼ����*****             



