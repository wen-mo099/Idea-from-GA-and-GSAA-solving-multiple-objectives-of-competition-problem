%���˼·һ��������ɶ���������󣬵�ǰ��+����������Զ��Ŀ�꺯�����Ż������Ż�����Ϊ����ָ�꣬ѡ�����ŵ���������
%Ȼ���������������������Ŵ��㷨���������½������󣬲����뵱ǰ�⡣��ǰ���Ż����̲���ģ���˻�˼·����ʹ���Ŵ��㷨��������⡣
clc;clear;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                      %�����ʼ�����������ʼֵ%
global N;global M;global gamma;global qulity;global lamuta;     %�������Ϊȫ�ֱ������Ա��ں���������
global w;global beta;global alpha;global tao;global miu;global a;

N = 10;M = 5                  %����ҩƷ������Ŀ
for i = 1:N
    gamma(i) = 0.5 + i;
    qulity(i) = 0.5 + 0.5*i
end
for j = 1:M+1
    lamuta(1,j) = 1 + 0.2*j;
end

w=0.7+0.1*rand(N,M+1);  %ҩƷ��ģ�۸�
price=ones(N,M+1);
xita=ones(N,1)-0.2;      %��������
beta=1; alpha=1; tao=0.8; miu=0.3;  %��������

for i=1:N
    for j=1:M+1
        a(i,j)=(lamuta(j)+gamma(i)+alpha*qulity(i))/miu;         %aΪ��Ʒi��������j�е���������
    end
end
                       %�����ͱ�����ʼֵ�������%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[revenue_of_insurance,revenue_of_tailer] = compute_revenue(price,xita)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %�㷨���壬���͵�������%

temper = 10000;                                    %��ʼ�¶�
column = zeros(N,1);
for i = 1:5
    change_price(:,:,i) = [temper *0.0001* rand(N,M) column];
end
[revenue_of_insurance,new_revenue_of_tailer] = compute_revenue(price+change_price(:,:,1),xita)
assess = assess_fun(revenue_of_tailer,new_revenue_of_tailer)


    

