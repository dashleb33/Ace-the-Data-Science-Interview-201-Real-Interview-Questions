/* DROP TABLE events;
DROP TABLE events2; */

CREATE TEMPORARY TABLE events (
  app_id INT UNSIGNED,
  event_id VARCHAR(10),
   event_date DATE
  )
  ;
  
  
INSERT INTO events
  VALUES (1, 'impression', '2019-01-01'),
     (1, 'impression', '2019-01-01'),
         (1, 'impression', '2019-01-01'),
         (1, 'impression', '2019-01-01'),
         (1, 'impression', '2019-01-01'),
         (1, 'impression', '2019-01-01'),
         (1, 'impression', '2019-01-01'),
         (1, 'impression', '2019-01-01'),
         (1, 'impression', '2019-01-01'),
         (1, 'impression', '2019-01-01'),
         (1, 'click', '2019-01-01'),
         (1, 'click', '2019-01-01'),
         (1, 'click', '2019-01-01'),
         (1, 'click', '2019-01-01'),
         (1, 'click', '2019-01-01'),      
         (2, 'impression', '2019-01-01'),
         (2, 'impression', '2019-01-01'),
         (2, 'impression', '2019-01-01'),
         (2, 'impression', '2019-01-01'),
         (2, 'impression', '2019-01-01'),
         (2, 'impression', '2019-01-01'),
         (2, 'impression', '2019-01-01'),
         (2, 'impression', '2019-01-01'),
         (2, 'impression', '2019-01-01'),
         (2, 'impression', '2019-01-01'),
         (2, 'click', '2019-01-01'),
         (2, 'click', '2019-01-01'),
         (1, 'impression', '2019-02-02')
;
   
CREATE TEMPORARY TABLE events2 SELECT * FROM events
;

/* SELECT app_id, 
       (
        COUNT(event_id) / (
                            SELECT COUNT(event_id)
                                FROM events2
                                					 WHERE event_id = 'impression'                                					 				AND event_date BETWEEN '2019-01-01' AND '2019-01-01'
                                GROUP BY app_id                                
                                
                                    
                            )
        )
  FROM events 
   WHERE event_id = 'click'
      AND event_date BETWEEN '2019-01-01' AND '2019-01-01'
  GROUP BY app_id  
  
     
; */

SELECT 
       app_id, 
       SUM(IF(event_id = 'click', 1, 0)) / SUM(IF(event_id = 'impression', 1, 0))
       FROM events
       WHERE event_date = '2019-01-01'
       GROUP BY app_id
       ;
       


  