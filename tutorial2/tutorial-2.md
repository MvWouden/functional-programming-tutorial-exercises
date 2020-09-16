# Functional Programming - Tutorial 2

## Exercise 7.2

Give a pattern-matching definition of a function which:

1. adds the first two integers in a list, if a list contains at least two elements;
2. returns the head element if the list contains one
3. returns zero otherwise

```haskell
exercise72 :: Num a => [a] -> a
exercise72 (x : y : _)    = x + y
exercise72 (x : _)        = x
exercise72 _              = 0
```

## Exercise 7.6

Define the functions `and2` and `or2` on a list of Booleans. These should return the conjunction or disjunction on a list of booleans. Note that these are already defined in the prelude, so call them `and2` and `or2`.

```haskell
and2 :: [Bool] -> Bool
and2 []      = False
and2 xs      = foldr (&&) True xs


or2 :: [Bool] -> Bool
or2 []       = False
or2 xs       = foldr (||) False xs
```

## Exercise 7.8

Using primitive recursion over lists, define a function `elemNum :: Integer -> [Integer] -> Integer` so that `elemNum x xs` returns the number of times that `x` occurs in the list `xs`.

```haskell
elemNum :: Integer -> [Integer] -> Integer
elemNum n []        = 0
elemNum n (x:xs)
  | n == x          = 1 + elemNum n xs
  | otherwise       = 0 + elemNum n xs
```

Can you define `elemNum` without primitive recursion, using list comprehension and built-in functions instead?

```haskell
elemNum :: Integer -> [Integer] -> Integer
elemNum x xs = toInteger (length [y | y <- xs, y == x])
```

## Exercise 7.9

Define a function `unique :: [Integer] -> [Integer]` such that `unique xs` returns the list of elements of `xs` which occurs exactly once.

Example: `unique [4,2,1,3,2,3] = [4,1]`

You might like to think of two solutions to this problem: one using list comprehension and the other not.

```haskell
unique :: [Integer] -> [Integer]
unique xs = [x | x <- xs, elemNum x xs == 1]

unique2 :: [Integer] -> [Integer]
unique2 []                  = []
unique2 (x:xs)
  | elemNum x (x:xs) == 1   = x : (unique xs)
  | otherwise               = unique xs
```

## iSort

```haskell
iSort :: [Integer] -> [Integer]
iSort []        = []
iSort (x:xs)    = ins x (iSort xs)

ins :: Integer -> [Integer] -> [Integer]
ins x []        = [x]
ins x (y:ys)
  | x <= y      = x : (y:ys)
  | otherwise   = y : ins x ys
```

## Exercise 7.16

By modifying the definition of the `ins` function, we can change the behaviour of `iSort`. Redefine `ins` in two different ways such that

1. the list is sorted in descending order
2. duplicates are removed from the list

```haskell
ins :: Integer -> [Integer] -> [Integer]
ins x []         = [x]
ins x (y:ys)
  | x > y        = x : (y:ys)
  | x == y       = (y:ys)
  | otherwise    = y : ins x ys
```

## Exercise 7.33

Define a function `isPalin` which tests whether a string is a palindrome.
Example of a palindrome: "Madam I'm Adam".

Note that punctuation is and white space are ignored, and that there is no disctinction between capital and small letters.

```haskell
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
```

## Exercise 7.34

Design a function: `subst :: String -> String -> String -> String` such that `subst oldSub newSub st` is the result of replacing hte first occurence in `st` of the substring `oldSub` by the substring `newSub`.

For instance:

`subst "much " "tall " "How much is that?" = "How tall is that?"`

```haskell
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
```
