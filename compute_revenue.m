function [revenue_of_insurance,revenue_of_tailer] = compute_revenue(price)
global N;global M;global gamma;global qulity;global lamuta;
global w;global beta;global alpha;global tao;global miu;global a;global xita

for i = 1:N
	b(i)=beta*(1-xita(i))/miu;       %bΪ�����߼۸����ж�
end

for j = 1:M+1                                  %����ѡ��������jʱ���г�ռ�Ыx
	temp = 0;
	for i = 1:N
		temp = temp + exp(a(i,j)-b(i)*price(i,j));
    end
    for i = 1:N
        conditionshare(i,j) = exp(a(i,j) - b(i)*price(i,j))/temp;
    end
end

temp = zeros(M+1,1);                              %���������̵��г�ռ�ȣ�temp��¼�����̵��г�ռ����
for j = 1:M+1                                  %totalshare��¼���г���
	for i = 1:N
		temp(j) = temp(j) + exp(a(i,j)-b(i)*price(i,j));
	end
	temp(j) = temp(j)^miu;
end
totalshare = sum(temp);

tailershare = ones(1,M+1);
for j = 1:M+1                                 %���㵥���������г�ռ�ȣ�Ϊ�����г�ռ����������ռ����
	tailershare(j) = tailershare(j)*(temp(j)/totalshare);
end

drugshare = conditionshare.*tailershare;

for i = 1:N
    for j = 1:M
        if price(i,j)<0
            price(i,j) = -10000;
        end
    end
end

revenue_of_tailer = sum(drugshare.*(price - w));           %������������������

for j = 1:M+1
    temp = 0;
    for i = 1:N
        temp = temp + exp((lamuta(j)+gamma(i)-alpha*(1-xita(i))*price(i,j)+beta*qulity(i))/miu);
    end
    p_utility_of_tailer(j) = miu*log(temp); 
end
revenue_of_insurance = sum(p_utility_of_tailer.*tailershare)+sum(sum(drugshare.*price.*xita));
end

