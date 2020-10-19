function [revenue_of_insurance,revenue_of_tailer] = compute_revenue(price)
global N;global M;global gamma;global qulity;global lamuta;
global w;global beta;global alpha;global tao;global miu;global a;global xita

for i = 1:N
	b(i)=beta*(1-xita(i))/miu;       %b为消费者价格敏感度
end

for j = 1:M+1                                  %计算选择零售商j时的市场占有玿
	temp = 0;
	for i = 1:N
		temp = temp + exp(a(i,j)-b(i)*price(i,j));
    end
    for i = 1:N
        conditionshare(i,j) = exp(a(i,j) - b(i)*price(i,j))/temp;
    end
end

temp = zeros(M+1,1);                              %计算零售商的市场占比，temp记录零售商的市场占有量
for j = 1:M+1                                  %totalshare记录总市场量
	for i = 1:N
		temp(j) = temp(j) + exp(a(i,j)-b(i)*price(i,j));
	end
	temp(j) = temp(j)^miu;
end
totalshare = sum(temp);

tailershare = ones(1,M+1);
for j = 1:M+1                                 %计算单个零售商市场占比，为单个市场占有量除以总占有量
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

revenue_of_tailer = sum(drugshare.*(price - w));           %计算所有零售商收益

for j = 1:M+1
    temp = 0;
    for i = 1:N
        temp = temp + exp((lamuta(j)+gamma(i)-alpha*(1-xita(i))*price(i,j)+beta*qulity(i))/miu);
    end
    p_utility_of_tailer(j) = miu*log(temp); 
end
revenue_of_insurance = sum(p_utility_of_tailer.*tailershare)+sum(sum(drugshare.*price.*xita));
end

