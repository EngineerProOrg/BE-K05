SELECT stock_name, 
SUM(
    CASE
    WHEN operation = 'Sell' THEN price
    WHEN operation = 'Buy' THEN -price
    END
) AS capital_gain_loss
FROM stocks
GROUP BY stock_name