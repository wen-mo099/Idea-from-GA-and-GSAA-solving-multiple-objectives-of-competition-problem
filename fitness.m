function fitness = fitness(price,pop,temper)
[nowinsurance,nowtailer] = compute_revenue(price);

num_of_improve = zeros(1,30);
for i = 1:30
    [revenue_of_insurance(i),revenue_of_tailer(i,:)] = compute_revenue(price+pop(:,:,i));
    total_revenue(i) = sum(revenue_of_tailer(i,1:5));
    for j = 1:5
        if revenue_of_tailer(i,j) > nowtailer(j)
            num_of_improve(i) = num_of_improve(i) + 1;
        end
    end
end

fitness = total_revenue*temper + num_of_improve;
for i = 1:30
    if fitness(i) <= 0
        fitnesee(i) = 0.001;
    end
end

end
