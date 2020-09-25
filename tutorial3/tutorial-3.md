# Functional Programming - Tutorial 1

## Exercise 11.8

Define a function

`total :: (Integer -> Integer) -> (Integer -> Integer)`

so that `total f` is the function which at value `n` gives the total:

`f 0 + f 1 + ... + f n`

```haskell
total :: (Integer -> Integer) -> (Integer -> Integer)
total f = (\n -> foldr (+) 0 (map f [0..n]))
```

## Exercise 11.9-11.10

Given a function `f` of the type `a -> b -> c`, write down a lambda abstraction that describes the function of type `b -> a -> c` which behaves like `f` but which takes its arguments in the other order.

Using this expression, give a definition of the function:

`flip :: (a -> b -> c) -> (b -> a -> c)`

which reverses the order in which its functions arguments takes its arguments

```haskell
flip :: (a -> b -> c) -> (b -> a -> c)
flip f = (\x y -> f y x)
```

## Exercise 11.14

```haskell
uncurry :: (a -> b -> c) -> ((a, b) -> c)
($) :: (a -> b) -> a -> b
(:) :: a -> [a] -> [a]
(.) :: (b -> c) -> (a -> b) -> a -> c
```

1. What is the effect of `uncurry ($)`?
2. What is its type?
3. Answer a similar question for `uncurry (:)` and `uncurry (.)`

### `Uncurry ($)`

1. It takes a pair of a function `a -> b` and an argument `a` and returns the result of the function `a -> b` applied on `a` to get `b`
2. `((a -> b), a) -> b`

### `Uncurry (:)`

1. It takes a pair of an argument `a` and argument `[a]` and returns `[a]` where `a` was added to the list
2. `(a, [a]) -> [a]`

### `Uncurry (.)`

1. It takes a pair of functions `b -> c` and `a -> b` and returns the result `a -> c` where `a -> c` is the function composition of the two functions given
2. `(b -> c, a -> b) -> a -> c`

## Exercise 11.15

What are the effects and types of:

1. `uncurry uncurry`

    The type is `(a -> b -> c, (a, b)) -> c` and the effect is splitting `(f, (x, y))` to `f x y`

2. `curry uncurry`

    It is not possible to match the type of `curry` and `uncurry`

## Exercise 11.17

Can you define functions:

`curry3 :: ((a, b, c) -> d) -> (a -> b -> c -> d))`

`uncurry3 :: ((a -> b -> c -> d) -> (a, b, c) -> d))`

which perform the analogue of `curry` and `uncurry` but for three arguments rather than two? Can you use `curry` and `uncurry` in these definitions?

```haskell
curry3 :: ((a, b, c) -> d) -> (a -> b -> c -> d))
curry3 f (a, b, c) = f a b c

uncurry3 :: ((a -> b -> c -> d) -> (a, b, c) -> d))
uncurry3 f a b c = f (a, b, c)
```

## Exercise 11.21

Give an alternative `constructive` definition of `iter` which creates the list of `n` copies of `f`, `[f, f..., f]` and then composes these functions by folding the operator `.` to give `f . f . ... . f`.

```haskell
iter2 :: Int -> (a -> a) -> (a -> a)
iter2 n f = foldr (.) id (replicate n f)
```

## Exercise 12.13

Define the function `splits :: [a] -> [([a], [a])]` which defines a list of all the ways that a list can be split in two

e.g.

`splits "Spy" = [("", "Spy"), ("S", "py"), ("Sp", "y"), ("Spy", "")]`

```haskell

splits :: [a] -> [([a], [a])]
splits []     = [([], [])]
splits (x:xs) = ([], (x:xs)) : (zip (map (x:) (map fst (splits xs))) (map snd (splits xs)))

splits2 :: [a] -> [([a], [a])]
splits2 xs    = zip (inits xs) (tails xs) -- import Data.List
```

## Exercise 17.2

Using the list comprehension notation, define the functions:

`subslists, subsequences :: [a] -> [[a]]`

which return all the sublists and subsequences of a list. A sublist is obtained omitting some of the elements of a list; a subsequence is a continous block from a list. E.g. `[2, 4]` and `[3, 4]` are sublists of `[2, 3, 4]` but only `[3, 4]` is a subsequence.

```haskell
subsLists :: [a] -> [[a]]
subLists []     = [[]]
subLists (x:xs) = [x:sub | sub <- subLists xs] ++ subLists xs

subSequences :: [a] -> [[a]]
subSequences xs = [] : [take j (drop i xs) | i <- split1, j <- split2]
  where
    split1 = [0 .. (length xs) - 1]
    split2 = [1 .. (length xs) - i]
```

## Exercise 17.23

Define the infinite lists of factorial and Fibonacci numbers

```haskell
factorials = 1 : zipWith (*) factorials [1..]
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)
```

## Exercise 17.24

```haskell
factors :: Integer -> [Integer]
factors n = [d | d <- [1..n], n `mod` d == 0]
```
