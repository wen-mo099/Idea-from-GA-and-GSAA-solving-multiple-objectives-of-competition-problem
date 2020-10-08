%求解思路一，随机生成多个进化矩阵，当前解+进化矩阵后，以多个目标函数总优化量和优化个数为评判指标，选出最优的两个矩阵
%然后对这两个进化矩阵进行遗传算法调整生成新进化矩阵，并加入当前解。当前解优化过程采用模拟退火思路，即使用遗传算法生成邻域解。
clc;clear;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                      %定义初始参数或变量初始值%
global N;global M;global gamma;global qulity;global lamuta;     %定义参数为全局变量，以便在函数中引用
global w;global beta;global alpha;global tao;global miu;global a;

N = 10;M = 5                  %定义药品种类数目
for i = 1:N
    gamma(i) = 0.5 + i;
    qulity(i) = 0.5 + 0.5*i
end
for j = 1:M+1
    lamuta(1,j) = 1 + 0.2*j;
end

w=0.7+0.1*rand(N,M+1);  %药品规模价格
price=ones(N,M+1);
xita=ones(N,1)-0.2;      %报销比例
beta=1; alpha=1; tao=0.8; miu=0.3;  %其他参数

for i=1:N
    for j=1:M+1
        a(i,j)=(lamuta(j)+gamma(i)+alpha*qulity(i))/miu;         %a为商品i在零售商j中的质量属性
    end
end
                       %参数和变量初始值定义完毕%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[revenue_of_insurance,revenue_of_tailer] = compute_revenue(price,xita)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %算法主体，求解和迭代过程%

temper = 10000;                                    %初始温度
column = zeros(N,1);
for i = 1:5
    change_price(:,:,i) = [temper *0.0001* rand(N,M) column];
end


    

