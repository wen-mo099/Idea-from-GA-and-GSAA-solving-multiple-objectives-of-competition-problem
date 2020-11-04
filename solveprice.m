%���˼·һ��������ɶ���������󣬵�ǰ��+����������Զ��Ŀ�꺯�����Ż������Ż�����Ϊ����ָ�꣬ѡ�����ŵ���������
%Ȼ���������������������Ŵ��㷨���������½������󣬲����뵱ǰ�⡣��ǰ���Ż����̲���ģ���˻�˼·����ʹ���Ŵ��㷨��������⡣
clc;clear;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                      %�����ʼ�����������ʼֵ%
global N;global M;global gamma;global qulity;global lamuta;     %�������Ϊȫ�ֱ������Ա��ں���������
global w;global beta;global alpha;global tao;global miu;global a;global xita;global temper;

N = 10;M = 5;                  %����ҩƷ������Ŀ
for i = 1:N
    gamma(i) = 0.5 + i;
    qulity(i) = 1 + 0.1*i;
end
for j = 1:M
    lamuta(1,j) = 1 + 0.2*j;
end
lamuta(6) = 1.4;

w=ones(N,M+1)-0.3;  %ҩƷ��ģ�۸�

test = 10*ones(N,1);

price=[5*ones(N,M) test];

xita=ones(N,1)-0.2;      %��������
beta=1; alpha=1; tao=0.8; miu=0.3;  %��������

for i=1:N
    for j=1:M+1
        a(i,j)=(lamuta(j)+gamma(i)+alpha*qulity(i))/miu;         %aΪ��Ʒi��������j�е���������
    end
end
                       %�����ͱ�����ʼֵ�������%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %�㷨���壬���͵�������%
% for k = 1:1024                     %���ѭ��������ҩƷ�����������п��ܵ�ȡֵ
%     value_of_xita = k-1;             
%     pos_of_drug = 1;               %����ʮ����ת�����Ʒ���
%     while value_of_xita
%         if mod(value_of_xita,2) == 1
%             xita(pos_of_drug) = 0.5;
%         else
%             xita(pos_of_drug) = 0.8;
%         end
%         value_of_xita = fix(value_of_xita/2)
%         pos_of_drug = pos_of_drug + 1
%     end
    
temper = 100;                                    %��ʼ�¶�
column = zeros(N,1);
count = 1;

for i = 1:30                                     %��ʼ����������
    pop(:,:,i) = [temper *0.01* (rand(N,M)-0.5) column];
end
max_total_revenue = 0;
num_of_nonimprove = 0;
while temper > 0.01
    for t = 1:floor(20*temper)
        [revenue_of_insurance,revenue_of_tailer] = compute_revenue(price);
        revenue_of_all_retailer_in_program(count)  = sum(revenue_of_tailer(1:5));
        if revenue_of_all_retailer_in_program(count) > max_total_revenue 
            max_total_revenue = revenue_of_all_retailer_in_program(count);
            num_of_nonimprove = 0;
        end
        fitness_of_pop = fitness(price,pop,temper);
        maximprove = 0;
        for i = 1:30
            if fitness_of_pop(i) > maximprove 
                maximprove = fitness_of_pop(i);
                evolve = i;
            end
        end
        price = price + pop(:,:,evolve);
        pop = nextpop(pop,fitness_of_pop,temper);
        count = count + 1;
        num_of_nonimprove = num_of_nonimprove + 1;
 
    end
    temper = temper*0.85;
    if num_of_nonimprove > 200
        break
    end
end

plot(revenue_of_all_retailer_in_program);

% end



