function [revenue_of_tailer] = compute_revenue(price,xita)
global N;global M;global gamma;global qulity;global lamuta;global w;global beta;global alpha;global tao;global miu;

for i=1:N+1
    for j=1:M+1
        a(i,j)=(lamuta(j)+gamma(i)+alpha*qulity(i))/miu;         %aΪ��Ʒi��������j�е���������
    end
end
beta=1; alpha=1; tao=0.8; miu=0.3;  %��������

for i = 1:N+1
	b(i)=beta*(1-xita(i))/miu;       %bΪ�����߼۸����ж�
end

for j = 1:M+1                                  %����ѡ��������jʱ���г�ռ�Ыx
	temp = 0
	for i = 1:N+1
		temp = temp + exp(a(i,j)-b(i)*price(i,j))
    end
    for i = 1:N+1
        conditionshare(i,j) = exp(a(i,j) - b(i)*price(i,j))/temp
    end
end

temp = zeros(M+1,1)                              %���������̵��г�ռ�ȣ�temp��¼�����̵��г�ռ����
for j = 1:M+1                                  %totalshare��¼���г���
	for i = 1:N
		temp(j) = temp(j) + exp(a(i,j)-b(i)*price(i,j))
	end
	temp(j) = temp(j)^miu
end
totalshare = sum(temp)

tailershare = ones(1,M+1)
for j = 1:M+1                                 %���㵥���������г�ռ�ȣ�Ϊ�����г�ռ����������ռ����
	tailershare(j) = tailershare(j)*(temp(j)/totalshare)
end

drugshare = conditionshare.*tailershare

revenue_of_tailer = sum(drugshare.*(price - w))           %������������������

end