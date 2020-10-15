function assess = assess_fun(revenue_of_oldsolution,revenue_of_newsolution,temper)

improve = 0
for j = 1:5
    improve = improve + revenue_of_newsolution(j)-revenue_of_oldsolution(j);
end

count = 0
for j = 1:5
    if revenue_of_newsolution(j) > revenue_of_oldsolution(j)
        count = count + 1
    end
end

assess = 0.1*improve + count
end
