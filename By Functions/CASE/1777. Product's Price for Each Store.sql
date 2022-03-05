# method 1:
# CASE WHEN()
SELECT product_id,
    SUM(CASE WHEN store='store1' THEN price ELSE NULL END) AS store1,
    SUM(CASE WHEN store='store2' THEN price ELSE NULL END) AS store2,
    SUM(CASE WHEN store='store3' THEN price ELSE NULL END) AS store3
FROM Products
GROUP BY product_id

# method 2:
# IF()
SELECT product_id,
    MIN(IF(store='store1', price, NULL)) AS store1,
    MIN(IF(store='store2', price, NULL)) AS store2,
    MIN(IF(store='store3', price, NULL)) AS store3
FROM Products
GROUP BY product_id