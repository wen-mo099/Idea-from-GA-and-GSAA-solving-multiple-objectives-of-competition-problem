function [revenue_of_tailer] = compute_revenue(price,xita)
global N;global M;global gamma;global qulity;global lamuta;global w;global beta;global alpha;global tao;global miu;

for i=1:N+1
    for j=1:M+1
        a(i,j)=(lamuta(j)+gamma(i)+alpha*qulity(i))/miu;         %a为商品i在零售商j中的质量属性
    end
end
beta=1; alpha=1; tao=0.8; miu=0.3;  %其他参数

for i = 1:N+1
	b(i)=beta*(1-xita(i))/miu;       %b为消费者价格敏感度
end

for j = 1:M+1                                  %计算选择零售商j时的市场占有玿
	temp = 0
	for i = 1:N+1
		temp = temp + exp(a(i,j)-b(i)*price(i,j))
    end
    for i = 1:N+1
        conditionshare(i,j) = exp(a(i,j) - b(i)*price(i,j))/temp
    end
end

temp = zeros(M+1,1)                              %计算零售商的市场占比，temp记录零售商的市场占有量
for j = 1:M+1                                  %totalshare记录总市场量
	for i = 1:N
		temp(j) = temp(j) + exp(a(i,j)-b(i)*price(i,j))
	end
	temp(j) = temp(j)^miu
end
totalshare = sum(temp)

tailershare = ones(1,M+1)
for j = 1:M+1                                 %计算单个零售商市场占比，为单个市场占有量除以总占有量
	tailershare(j) = tailershare(j)*(temp(j)/totalshare)
end

drugshare = conditionshare.*tailershare

revenue_of_tailer = sum(drugshare.*(price - w))           %计算所有零售商收益

end