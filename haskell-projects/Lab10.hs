higgingsType = ["The", "rain", "in", "spain", "falls", "mainly", "on", "the", "plain"] :: [[Char]]

inp :: [([Char], Double, Double)]
inp = [("A",4,12), ("B",2,1), ("C",2,2), ("D",1,1), ("E",10,4), ("F", 1, 20)]
manip lst = [ (name, v/w, w) | (name, v, w) <- lst]

sec (_, x, _) = x

mrg :: Ord a => [(t, a, t1)] -> [(t, a, t1)] -> [(t, a, t1)]
mrg [] [] = []
mrg a [] = a
mrg [] a = a
mrg x y = 
  let a = sec (head x)
      b = sec (head y)
  in if (a > b) then (head x) : mrg (tail x) y
     else (head y) : mrg x (tail y)

splite :: Ord a =>  [(t, a, t1)] -> [(t, a, t1)]
splite [] = []
splite (a:[]) = [a]
splite (a:b:x) = a : splite x

splito :: Ord a => [(t, a, t1)] -> [(t, a, t1)]
splito [] = []
splito (a:[]) = []
splito (a:b:x) = b : splito x

srt :: Ord a => [(t, a, t1)] -> [(t, a, t1)]
srt [] = []
srt (a:[]) = [a]
srt x = mrg (srt (splite x)) (srt (splito x))

displayList :: (Fractional t, Ord t) => [([Char], t, t)] -> [([Char], t, t)]
displayList lst = lst {-[(name, v, u) | (name, v, u) <- drop 1 lst, v > 0]-}

knapsack :: (Fractional t, Ord t) => [([Char], t, t)] -> t -> [([Char], t, t )]
knapsack lst w = 
  let ans = ("Start", w, 0):[ (name, if (v < u) then r*v; else v-u, if (u < v-u) then u; else v)
                          | (name, r, u) <- srt (manip lst)
                          | (crss, v, p) <- ans]
  in displayList (ans)
