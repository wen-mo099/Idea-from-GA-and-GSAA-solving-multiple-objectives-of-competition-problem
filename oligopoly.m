N=10, M=5; %����ҩƷ������Ŀ
gamma=rand(N,1);          %������������,gammaΪҩ����������  
qulity=rand(N,1);        %ҩƷ����
lamuta=ones(M+1,1);      %ҩƷ������
w=0.7+0.1*ones(N,M+1);  %ҩƷ��ģ�۸�
price=ones(N,M+1);
xita=ones(N)-0.2;  %��������
beta=1;
alpha=1;
tao=0.8;
miu=0.3;
for i=1:N
    for j=1:M+1
        a(i,j)=(lamuta(j)+gamma(i)+alpha*qulity(i))/miu;         %aΪ��Ʒi��������j�е���������
    end
end
for i = 1:N
b(i)=beta*(1-xita(i))/miu;       %bΪ�����߼۸����ж�
end
temp=0;
for j=1:M         %��A��ֵ�������̵�������������
    temp2 = 0
    for i=1:N
        temp=temp+exp(a(i,M+1)-b(j)*price(i,M+1)); 
        temp2 = temp2 + exp(a(i,j)-b(j)*w(i,j));
    end
    A_bar(j)=exp(-1)*(temp^(-1)*temp2)^miu;
end
fun=@(t)t+V(t*A_bar(1))+V(t*A_bar(2))+V(t*A_bar(3))+V(t*A_bar(4))+V(t*A_bar(5))-1
d0=fzero(fun,0.5)              %����fzero��������d0,0.5Ϊ��ʼ�����㣬�ɸ���
for i=1:N                %�г�����ҩ��۸�
    for j=1:M
        price(i,j)=1/(b(j)*miu)*1/(1-V(A_bar(j)*d0))+w(i,j);
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
% miu_value(h)=miu;
% non_out(h)=sum(sum(d_drugshare))              %���г�ռ����
% d_drugshare_value(:,:,h)=d_drugshare;         %���治ͬ�����̲������г�ռ����
% price_value(:,:,h)=price;                     %���治ͬ�����̲��������Ŷ���
% end
% for i=1:N                                         %��ͼ����*****
%     for j=1:M                                                  %
%        plot(miu_value,squeeze(d_drugshare_value(i,j,:)));            %
%        xlabel("Degree of dissimilarity among drugs(�� )");     %
%        ylabel("market share");                                 %
%        hold on;                                                %
%     end                                                        %
% end                                                            %

%plot(miu_value,non_out);                           %��ͼ����*****             



