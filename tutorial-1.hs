nAnd :: Bool -> Bool -> Bool
nAnd x y = not(x && y)

mystery :: Int -> Int -> Int -> Bool
mystery m n p = not((m==n) && (n==p))

min2 :: Int -> Int -> Int
min2 x y = if x <= y then x else y

minThree :: Int -> Int -> Int -> Int
minThree x y z = min2(x min2(y z))

charToNum :: Char-> Int
charToNum x
  | fromEnum x-48 < 0           = 0
  | fromEnum x-48 > 9           = 0
  | otherwise                   = fromEnum x-48

numberNDroots :: Int -> Int -> Int -> Int
numberNDroots a b c
  | b*b - 4*a*c > 0     = 2
  | b*b - 4*a*c < 0     = 1
  | otherwise           = 0

rangeProduct :: Integer -> Integer -> Integer
rangeProduct x y = if y < x then 0 else product[x..y]

fac :: Integer -> Integer
fac x = if x > 0 then rangeProduct 1 x else 1

pow2 :: Integer -> Integer
pow2 n
  | n == 0    = 1
  | n > 0     = 2 * pow2 (n-1)

pow2 ::  Integer ->  Integer
pow2 n
  | n == 0          = 1
  | n == 1          = 2
  | mod n 2 == 0    = pow2 (div n 2) * pow2 (div n 2)
  | mod n 2 == 1    = pow2 (div n 2) * pow2 (div n 2) * 2

maxOccurs :: Int -> Int -> (Int, Int)
maxOccurs x y = if x == y then (x, 2) else (max x y, 1)

maxThreeOccurs :: Int -> Int -> Int -> (Int, Int)
maxThreeOccurs x y z = (maxN, length filteredList)
  where
      list = [x, y, z]
      maxN = maximum list
      filteredList = [x | x <- list, x == maxN]

doubleAll :: [Int] -> [Int]
doubleAll list = [x*2 | x <- list]

matches :: Int -> [Int] -> [Int]
matches n list = [x | x <- list, x == n]

isElementOf :: Int -> [Int] -> Bool
isElementOf n list = length (matches n list) > 0  
