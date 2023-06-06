/* DROP TABLE purchases; */

CREATE TEMPORARY TABLE purchases (
  purchase_id INT UNSIGNED,
  user_id INT UNSIGNED,
  product_id INT UNSIGNED,
  quantity INT,
  price FLOAT,
  purchase_time DATE
)
;
  
INSERT INTO events (purchase_id, user_id, product_id, quantity, price, purchase_time)
            VALUES (0001,        1111,    100,        1,        4.99,  '2021-01-01'),
                   (0002,        1111,    100,        1,        4.99,  '2021-01-02'),
                   (0003,        1112,    200,        1,        6.50,  '2021-01-03'),
                   (0004,        1113,    200,        1,       10.00,  '2021-01-04')
;
   
-- SELECT COUNT(DISTINCT user_id)
--   FROM (
--         SELECT user_id, 
--                RANK() OVER (
--                             PARTITION BY user_id,
--                                          product_id,
--                             ORDER BY CAST(purchase_time AS DATE)
--                            ) AS purchase_no
--           FROM purchases
--         ) t 
--   WHERE purchase_no = 2
-- ;

SELECT user_id, 
       COUNT(DISTINCT user_id) 
  FROM purchases
  WHERE user_id IN (
                    SELECT user_iD
                      FROM ( 
                            SELECT user_id, 
                                product_id,
                                date(datefield), 
                                COUNT(*) as n_purchases
                            FROM purchases
                            GROUP BY user_id, 
                                    product_id,
                                    date(datefield)
                            HAVING n_purchases > 1
                            ) t
                    )
  GROUP BY user_id


