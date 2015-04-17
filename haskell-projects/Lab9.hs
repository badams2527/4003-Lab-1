merge [] [] = []
merge [] l = l
merge l [] = l
merge (e1:l1) (e2:l2) = if e1 < e2 then 
                          e1:(merge l1 (e2:l2));
                        else 
                          e2:(merge (e1:l1) l2)

times x l = [x*e | e <- l]

ham [] = []
ham l = (head l):(merge (times (head l) (ham l)) (ham (tail l)))
