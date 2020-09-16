exercise72 :: Num a => [a] -> a
exercise72 (x : y : _)    = x + y
exercise72 (x : _)        = x
exercise72 _              = 0


and2 :: [Bool] -> Bool
and2 []      = False
and2 xs      = foldr (&&) True xs


or2 :: [Bool] -> Bool
or2 []       = False
or2 xs       = foldr (||) False xs


elemNum :: Integer -> [Integer] -> Integer
elemNum n []        = 0
elemNum n (x:xs)
  | n == x          = 1 + elemNum n xs 
  | otherwise       = 0 + elemNum n xs


elemNum2 :: Integer -> [Integer] -> Integer
elemNum2 x xs = toInteger (length [y | y <- xs, y == x])


unique :: [Integer] -> [Integer]
unique xs = [x | x <- xs, elemNum x xs == 1]


unique2 :: [Integer] -> [Integer]
unique2 []                    = []
unique2 (x:xs)
  | elemNum x (x:xs) == 1     = x : (unique xs)
  | otherwise                 = unique xs


iSort :: [Integer] -> [Integer]
iSort []     = []
iSort (x:xs) = ins x (iSort xs)


ins :: Integer -> [Integer] -> [Integer]
ins x []         = [x]
ins x (y:ys)
  | x > y        = x : (y:ys)
  | x == y       = (y:ys)
  | otherwise    = y : ins x ys


toLower :: String -> String
toLower []                = []
toLower (x:xs)
    | elem x ['A'..'Z']   = toEnum (fromEnum x + 32) : toLower xs
    | otherwise           = x : toLower xs


isPalin :: String -> Bool
isPalin xs = f [x | x <- toLower xs, elem x ['a'..'z']]
  where
    f []                  = True
    f (x:[])              = True
    f (x:xs)
      | x == last xs      = f (init xs)
      | otherwise         = False


isEqual :: String -> String -> Bool
isEqual [] []             = True
isEqual (y:xs) (x:ys)
  | x == y                = isEqual xs ys
  | otherwise             = False
isEqual _ _               = False


subst :: String -> String -> String -> String
subst old new (x:xs)
  | length old > length (x:xs)    = (x:xs)
  | isEqual old fragment          = subst old new (new ++ afterFragment)
  | otherwise                     = x : subst old new xs
    where
      fragment = take (length old) (x:xs)
      afterFragment = drop (length old) (x:xs)