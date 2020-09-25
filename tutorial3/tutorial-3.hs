import Data.List

total :: (Integer -> Integer) -> (Integer -> Integer)
total f = (\n -> foldr (+) 0 (map f [0..n]))

flipArgs :: (a -> b -> c) -> (b -> a -> c)
flipArgs f = (\x y -> f y x)

curry3 :: ((a, b, c) -> d) -> (a -> b -> c -> d)
curry3 f a b c = f (a, b, c)

uncurry3 :: ((a -> b -> c -> d) -> (a, b, c) -> d)
uncurry3 f (a, b, c) = f a b c 

subLists :: [a] -> [[a]]
subLists []     = [[]]
subLists (x:xs) = [x:sub | sub <- subLists xs] ++ subLists xs

subSequences :: [a] -> [[a]]
subSequences xs = [] : [take j (drop i xs) | i <- split1 xs, j <- split2 xs i]
  where
    split1 xs = [0 .. (length xs) - 1]
    split2 xs i = [1 .. (length xs) - i]

splits :: [a] -> [([a], [a])]
splits []     = [([], [])]
splits (x:xs) = ([], (x:xs)) : (zip (map (x:) (map fst (splits xs))) (map snd (splits xs)))

splits2 :: [a] -> [([a], [a])]
splits2 xs    = zip (inits xs) (tails xs)