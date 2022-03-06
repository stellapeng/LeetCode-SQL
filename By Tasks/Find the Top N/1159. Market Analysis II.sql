# method 1:
# Two LEFT JOINs + use DENSE_RANK() to find the 2nd sold item 
# CASE WHEN can be substituded with IFNULL
SELECT  u.user_id AS seller_id, 
        CASE
            WHEN favorite_brand = item_brand THEN 'yes' 
            ELSE 'no' 
        END AS 2nd_item_fav_brand 
FROM Users u
LEFT JOIN (SELECT seller_id, 
                  item_id, 
                  RANK() OVER (PARTITION BY seller_id ORDER BY order_date) rk
            FROM Orders
            ) AS tbl
ON u.user_id = tbl.seller_id AND rk = 2
LEFT JOIN Items i
ON tbl.item_id = i.item_id


# method 2:
# subquery in CASE WHEN + RANK to find the 2nd sold item
SELECT  u.user_id AS seller_id, 
        CASE
            WHEN (user_id, favorite_brand) IN 
                        (SELECT seller_id, item_brand
                         FROM (SELECT seller_id, 
                                    item_brand, 
                                    RANK() OVER (PARTITION BY seller_id ORDER BY order_date) AS rk
                               FROM Orders o
                               JOIN Items
                               USING (item_id)) AS t1
                          WHERE rk = 2) THEN 'yes' 
            ELSE 'no' 
        END AS 2nd_item_fav_brand 
FROM Users u



# method 3:
# subquery in CASE WHEN + LIMIT OFFSET to find the 2nd sold item
# note: LIMIT can not be used with multiple row operator like IN, ANY
SELECT  u.user_id AS seller_id, 
        CASE
            WHEN favorite_brand = (SELECT item_brand
                                   FROM Orders o
                                   JOIN Items i
                                   USING (item_id)
                                   WHERE u.user_id = o.seller_id
                                   ORDER BY order_date
                                   LIMIT 1 OFFSET 1) THEN 'yes' 
            ELSE 'no' 
        END AS 2nd_item_fav_brand 
FROM Users u


# method 4:
Two LEFT JOINs + INNER JOIN to find the 2nd sold item
SELECT  u.user_id AS seller_id, 
        CASE
            WHEN favorite_brand = item_brand THEN 'yes' 
            ELSE 'no' 
        END AS 2nd_item_fav_brand 
FROM Users u
LEFT JOIN (SELECT o1.seller_id, 
                  o1.item_id
            FROM Orders o1
            LEFT JOIN Orders o2
            ON o1.seller_id = o2.seller_id AND o1.order_date >= o2.order_date
            GROUP BY o1.order_id    -- THE GROUP ID is order_id
            HAVING COUNT(DISTINCT o2.order_date) = 2) AS tbl
ON u.user_id = tbl.seller_id
LEFT JOIN Items i
ON tbl.item_id = i.item_id


