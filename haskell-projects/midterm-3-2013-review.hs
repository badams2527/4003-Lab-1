maxf (Just x) y = Just (max x y)

data KnapObj a = KnapObj a a deriving (Show)
val (KnapObj x y) = x
wgt (KnapObj x y) = y

toKnapObjs :: [(a, a)] -> [KnapObj a]
toKnapObjs lst = [ KnapObj x y | (x,y) <- lst ]

mrg [] [] = []
mrg a [] = a
mrg [] b = b
mrg a b = if ((val (a !! 0)) < (val (b !! 0))) then (a !! 0) : mrg (tail a) b; else (b !! 0) : mrg a (tail b)

combineKnapObjs [] []  = []
combineKnapObjs a  [] = a
combineKnapObjs [] b = b
combineKnapObjs a b = mrg a b

data Clist a = Empty | Cell a (Clist a) deriving (Show)
listAdd x Empty = (Cell x Empty)
listAdd x lst = (Cell x lst)

appendList :: Clist a -> [a] -> Clist a
appendList c lst = foldl (\acc x -> listAdd x acc) c lst

listPeek Empty = Nothing
listPeek (Cell x lst) = (Just x)

getname =
  putStrLn "What is your name?" >> getLine >>=
    (\name -> putStrLn ("Your name is " ++ name))
