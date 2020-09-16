# Functional Programming - Tutorial 1

## Exercise 3.5

Give two different definitions of the `nAnd` function
`nAnd :: Bool -> Bool -> Bool`
which returns the result `True` except when both arguments are `True` :

```haskell
nAnd :: Bool -> Bool -> Bool
nAnd x y = not(x && y)
```

## Exercise 3.8

Explain the effect of the function defined here:

```haskell
mystery :: Int -> Int -> Int -> Bool
mystery m n p = not((m==n) && (n==p))
```

The mystery function takes 3 Integers as input and returns a boolean value.
It returns `False` if `not((m==n) && (n==p))` is `True`.
This means that  if and only if `m`, `n` and `p` are identical, the function returns `False`.
Thus, the mystery function checks if at least one of `m`, `n` and `p` is different.

## Exercise 3.14

Give definitions of the functions `min2` and `minThree` which calculate the minimum of two and three Integers respectively. (Note: `min` is a built-in function from the `Prelude`, therefore we choose the name `min2`)

```haskell
min2 :: Int -> Int -> Int
min2 x y = if x <= y then x else y
```

and

```haskell
minThree :: Int -> Int -> Int -> Int
minThree x y z = min2(x min2(y z))
```

## Exercise 3.17

Define the function `charToNum` which converts a digit like '8' to its value 8. The value of non-digits should be taken to be 0.

```haskell
charToNum :: Char-> Int
charToNum x
  | fromEnum x-48 < 0           = 0
  | fromEnum x-48 > 9           = 0
  | otherwise                   = fromEnum x-48

```

## Exercise 3.22

Write a function `numberNDroots` that given the coefficients of the quadratic `a`, `b`, and `c`, will return how many (real) roots the equation has. You may assume that `a` is non-zero.

A quadratic formula has two real roots for `b^2 - 4*a*c > 0`, one real root for `b^2 - 4*a*c = 0` and zero real roots for `b^2 - 4*a*c < 0`.

```haskell
numberNDroots :: Int -> Int -> Int -> Int
numberNDroots a b c
  | b*b - 4*a*c > 0     = 2
  | b*b - 4*a*c < 0     = 1
  | otherwise           = 0
```

## Exercise 4.17

Define the function `rangeProduct` which when given the natural numbers `m` and `n` returns the product `m*(m+1)*...*(n-1)*n`. The function should return 0 when `n` is smaller than `m`.

```haskell
rangeProduct :: Integer -> Integer -> Integer
rangeProduct x y = if y < x then 0 else product[x..y]
```

## Exercise 4.18

As `fac` is a special case of `rangeProduct`, write a definition of `fac` which uses `rangeProduct`

```haskell
fac :: Integer -> Integer
fac x = if x > 0 then rangeProduct 1 x else 1
```

## Exercise 4.32

Suppose we have to raise 2 to the power `n`. If `n` is even, `2*m` say, then
$$2^n = 2^{2m} = (2^m)^2$$
If `n` is odd, `2*m+1` say, then
$$2^n = 2^{2m+1} = (2^m)^2 * 2$$
Give a recursive function to compute $2^n$ which uses these insights.

First of all, let's write a function that would compute $2^n$ recursively without these insights:

```haskell
pow2 :: Integer -> Integer
pow2 n
  | n == 0    = 1
  | n > 0     = 2 * pow2 (n-1)
```

Now let's change this to incorporate the insights.

```haskell
pow2 ::  Integer ->  Integer
pow2 n
  | n == 0          = 1
  | n == 1          = 2
  | mod n 2 == 0    = pow2 (div n 2) * pow2 (div n 2)
  | mod n 2 == 1    = pow2 (div n 2) * pow2 (div n 2) * 2
```

## Exercise 5.1

Give a definition of the function

`maxOccurs :: Int -> Int -> (Int, Int)`

which returns the maximum of two integers, together with the number of times it occurs.

```haskell
maxOccurs :: Int -> Int -> (Int, Int)
maxOccurs x y = if x == y then (x, 2) else (max x y, 1)
```

Using this, define the function

`maxThreeOccurs :: Int -> Int -> Int -> (Int, Int)`

which does a similar thing for three arguments.

```haskell
maxThreeOccurs :: Int -> Int -> Int -> (Int, Int)
maxThreeOccurs x y z = (maxN, length filteredList)
  where
      list = [x, y, z]
      maxN = maximum list
      filteredList = [x | x <- list, x == maxN]
```

## Exercise 5.18

Give a definition of the function

`doubleAll :: [Int] -> [Int]`

which doubles all the elements of a list of integers.

```haskell
doubleAll :: [Int] -> [Int]
doubleAll list = [x*2 | x <- list]
```

## Exercise 5.21

Define the function

`matches :: Int -> [Int] -> [Int]`

which picks out all occurrences of an integer `n` in a list. For instance:

`matches 1 [1,2,1,4,5,1] [1,1,1]`

`matches 1 [2,3,4,6] []`

```haskell
matches :: Int -> [Int] -> [Int]
matches n list = [x | x <- list, x == n]
```

Next, use it to implement the function `isElementOf n xs` which returns `True` if `n` occurs in the list `xs`, and `False` otherwise.

```haskell
isElementOf :: Int -> [Int] -> Bool
isElementOf n list = length (matches n list) > 0  
```
