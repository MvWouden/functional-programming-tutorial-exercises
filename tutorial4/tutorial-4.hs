isDCSN :: Integer -> Bool
isDCSN n       = f n (-1:[2..9]) `mod` 11 == 0
  where
    f _ []     = 0
    f n (x:xs) = (n `mod` 10) * x + f (n `div` 10) xs


relPrimePairs :: Integer -> [(Integer, Integer)]
relPrimePairs n = [(i, j) | i <- [2..n-1], j <- [i+1..n], gcd i j == 1]


deck :: [(String, String)]
deck = [(suit, card) | suit <- suits, card <- cards ++ honours]
  where
    suits   = ["Clubs", "Diamonds", "Hearts", "Spades"]
    cards   = map show [2..10]
    honours = ["J", "Q", "K", "A"]


locations :: Int -> [Int] -> [Int]
locations n xs = [i | (i, x) <- zip [0..(length xs)-1] xs, x == n]


iterateF :: (a -> a) -> a -> [a]
iterateF f n = f n : iterateF f (f n)


ints :: [Integer]
ints = 0 : f 1
  where f n = n : -n : f (n+1)


primes :: [Integer]
primes = sieve [2..]
  where sieve (p:xs) = p : sieve [x | x <- xs, x `mod` p /= 0]


composites :: [Integer]
composites = [x | x <- [2..], not $ x `elem` (primeList x)]
  where primeList x = takeWhile (<= x) primes


data RPN = Value Integer
         | Plus
         | Minus
         | Times
         | Div
         deriving(Eq)

rpn :: [RPN] -> Integer
rpn rs = f rs []
  where
    f []            stack  = head stack
    f (Value r:rs)  stack  = f rs (r : stack)
    f (r:rs)       (x:y:s) = f rs (op r y x : s)

op :: RPN -> (Integer -> Integer -> Integer)
op r = f (lookup r operators)
  where
    operators  = [(Plus, (+)), (Minus, (-)), (Times, (*)), (Div, div)]
    f (Just o) =  o
    f Nothing  = (*)
