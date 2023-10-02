-- Leetcode Problems

-- https://leetcode.com/problems/capital-gainloss/description/
select stock_name, sum(case when operation = "Buy" then -price
                            else +price end) 
                    as capital_gain_loss
from Stocks
group by stock_name;

-- https://leetcode.com/problems/count-salary-categories/description/
select t.category, count(a.category) as accounts_count
from (
  select 'Low Salary' as category
  union
  select 'Average Salary' as category
  union
  select 'High Salary' as category
) as t
left outer join (
  select case when income < 20000 then 'Low Salary'
              when income > 50000 then 'High Salary'
              else 'Average Salary' end as category
  from Accounts
) as a on a.category = t.category
group by t.category;

