import Data.Ratio

f1 x = y !! length x
  where
    y = [False] ++ [ e || a | e <- y | a <- x ]

v1 = [(==0), (==1), (==2)] >>=
     (\x -> [0, 1, 2, 3] >>= (\y -> return (f1 [x y])))

f2 :: (Num t, Monad m) => m t -> m t -> m t -> m [t]
f2 a b c = a >>= (\x -> b >>= (\y -> c >>= (\z -> return [x*y*z])))
v3 = f2 [1%2,1%2] [1%4,3%4] [1%8,7%8]
