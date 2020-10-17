%求解思路一，随机生成多个进化矩阵，当前解+进化矩阵后，以多个目标函数总优化量和优化个数为评判指标，选出最优的两个矩阵
%然后对这两个进化矩阵进行遗传算法调整生成新进化矩阵，并加入当前解。当前解优化过程采用模拟退火思路，即使用遗传算法生成邻域解。
clc;clear;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                      %定义初始参数或变量初始值%
global N;global M;global gamma;global qulity;global lamuta;     %定义参数为全局变量，以便在函数中引用
global w;global beta;global alpha;global tao;global miu;global a;global xita

N = 10;M = 5                  %定义药品种类数目
for i = 1:N
    gamma(i) = 0.5 + i;
    qulity(i) = 1 + 0.1*i
end
for j = 1:M
    lamuta(1,j) = 1 + 0.2*j;
end
lamuta(6) = 1.4

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %算法主体，求解和迭代过程%
% for k = 1:1024                     %外层循环，遍历药品报销比例所有可能的取值
%     value_of_xita = k-1;             
%     pos_of_drug = 1;               %利用十进制转二进制方法
%     while value_of_xita
%         if mod(value_of_xita,2) == 1
%             xita(pos_of_drug) = 0.5;
%         else
%             xita(pos_of_drug) = 0.8;
%         end
%         value_of_xita = fix(value_of_xita/2)
%         pos_of_drug = pos_of_drug + 1
%     end
    
temper = 100;                                    %初始温度
column = zeros(N,1);
[revenue_of_insurance,revenue_of_tailer] = compute_revenue(price)
for i = 1:30                                     %初始化进化矩阵
    pop(:,:,i) = [temper *0.01* (rand(N,M)-0.5) column];
end

fitness_of_pop = fitness(price,pop,temper)

maximprove = 0
for i = 1:30
    if fitness_of_pop(i) > maximprove 
        maximprove = fitness_of_pop(i)
        evolve = i
    end
end
price = price + pop(:,:,evolve);




% end
    

