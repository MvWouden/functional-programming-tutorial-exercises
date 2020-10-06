# Functional Programming - Tutorial 4 - Exam 2014

## Exercise 1

What is the type of the standard Haskell function `zip`?

```haskell
zip (x:xs) (y:ys) = (x, y) : zip xs ys
zip  xs     ys    = []
```

is of type `zip :: [a] -> [b] -> [(a, b)]`

<br>

What is the type of the standard Haskell function `concat`?

```haskell
concat = foldr (++) []
```

is of type `concat :: [[a]] -> [a]`

<br>

What is the type of the following Haskell function `uncurry`?

```haskell
uncurry f = (\(a, b) -> f a b)
```

is of type `(a -> b -> c) -> (a, b) -> c`

<br>

What is the type of the following Haskell function `plus1`?

```haskell
plus1 = map (+1)
```

is of type `[Integer] -> [Integer]`

<br>

What is the type of the following Haskell function `f`?

```haskell
f = sum.h.g
g = (\x -> (head x, (head.reverse) x))
h (x, y) = [x, y]
```

`g` is of type `[a] -> (a, a)`

`h` is of type `(a, a) -> [a]`

`sum` is of type `Num a => [a] -> a`

hence f is of type `Num a => [a] -> a`

<br>

## Exercise 2

A Dutch Citizen Service Number (DCSN) always has 9 digits and the first digit cannot be a 0. Many websites use the following rudimentary check to validate the correctness of the (9 digit) number `ABCDEFGHI`. First compute:

`X = 9*A + 8*B + 7*C + 6*D + 5*E + 4*F + 3*G + 2*H - 1*I`

Note that the last digit has a negative weight. If `X` is a multiple of `11`, then the number `ABCDEFGHI` passes the test, otherwise it is invalid.

Write a Haskell function `isDCSN` (including its type) that determines whether its argument passes the test described above.

Solution:

```haskell
isDCSN :: Integer -> Bool
isDCSN n       = f n (-1:[2..9]) `mod` 11 == 0
  where
    f _ []     = 0
    f n (x:xs) = (n `mod` 10) * x + f (n `div` 10) xs
```

<br>

## Exercise 3

Write a function `relPrimePairs n` that returns the list of pairs `(i,j)` where `1<i<j<=n` and `i` and `j` have no common factor (you may use the function `gcd` that computes the greatest common divisor of its two arguments). The implementation of `relPrimePairs` must be a list comprehension.

Solution:

```haskell
relPrimePairs :: Integer -> [(Integer, Integer)]
relPrimePairs n = [(i, j) | i <- [2..n-1], j <- [i+1..n], gcd i j == 1]
````

<br>

Given are Haskell definitions of `suits`, `cards` and `honours`:

```haskell
suits   = ["Clubs", "Diamonds", "Hearts", "Spades"]
cards   = map show [2..10]
honours = ["J", "Q", "K", "A"]
```

Write a list comprehension for `deck`, where `deck` is:

```haskell
[
  ("Clubs",    "2"), ..., ("Clubs",    "A"), ...,
  ("Diamonds", "2"), ..., ("Diamonds", "A"), ...,
  ("Hearts",   "2"), ..., ("Hearts",   "A"), ...,
  ("Spades",   "2"), ..., ("Spades",   "A")
]
```

Solution:

```haskell
deck :: [(String, String)]
deck = [(suit, card) | suit <- suits, card <- cards ++ honours]
```

<br>

Use a list comprehension and the function `zip` to write a Haskell function `locations n xs` that returns the list of all indexes `i` such that the `i`th element of `xs` is `n` (i.e. `xs!!i == n`). Note that the first element of a list has index 0. You are not allowed to use the indexing operator `!!`.

Solution:

```haskell
locations :: Int -> [Int] -> [Int]
locations n xs = [i | (i, x) <- zip [0..(length xs)-1] xs, x == n]
```

<br>

## Exercise 4

The function `iterate` creates an infinite list where the first item is calculated by applying the function its first argument on its second argument, the second item by applying the function on the previous result and so on. For example, `iterate (2*) 1` yields the infinite list `[2,4,8,16,31,...]`. Give a Haskell implementation (including its type) of the function `iterate`.

Solution:

```haskell
iterate :: (a -> a) -> a -> [a]
iterate f x = f x : iterate f (f x)
```

<br>

Define the infinite list `ints`, which is the list of all integers. It should be ordered in such a way that you can find any given integer after searching a finite numer of elements in `ints`. In other words, this is not going to work: `ints = [0..] ++ [-1, -2 ..]`

Solution:

```haskell
ints :: [Integer]
ints = 0 : f 1
  where f n = n : -n : f (n+1)
```

<br>

Given is the definition of the infinite list of primes:

```haskell
primes :: [Integer]
primes = sieve [2..]
  where sieve (p:xs) = p : sieve [x | x <- xs, x `mod` p /= 0]
```

Use `primes` to define the infinite list `composites` of non-primes. So, `take 10 composites` should yield `[4,6,8,9,10,12,14,15,16,18]`. Note that we skip the value 1.

Solution:

```haskell
composites :: [Integer]
composites = [x | x <- [2..], not $ x `elem` (primeList x)]
  where primeList x = takeWhile (<= x) primes
```

<br>

## Exercise 5

We are used to write expressions `infix` notation. For instance, we write `10 - (4 + 3) * 2`. The downside of this notation is that we have to use parentheses to denote precedence. *Reverse Polish Notation* (RPN) is another way of writing down expressions, and does not need parentheses. In RPN, every operator follows its operands, therefore RPN is also called *postfix notation*. The above expresion in RPN is: `10 4 3 + 2 * -`.

Evaluation such an expression goes as follows. We keep pushing numbers onto a stack, until we encounter the first operator. So, when we encounter the `+`, the stack contains `[3,4,10]` (here, the head of the list is the top of the stack). We replace two top numbers from the stack by their sum. The stack is now `[7, 10]`. Next, we push 2 on the stack (so, `[2,7,10]`). Now, we encounter an operator again, we pop `2` and `7` off the stack, apply the operator and push the result to the stack yielding `[14,10]`. Finally, there is a `-`. We pop `10` and `14` from the stack, subtract `14` from `10` and push that back. The number on the stack is now `-4`, which is the final result.

We use the following data type for representing RPN literals:

``` haskell
data RPN = Value Integer | Plus | Minus | Times | Div
```

Write a Haskell function `rpn :: [RPN] -> Integer` that evaluates a RPN expression to an `Integer`.

Solution:

```haskell
rpn :: [RPN] -> Integer
rpn rs = f rs []
  where
    f []            stack  = head stack
    f (Value r:rs)  stack  = f rs (r : stack)
    f (Plus:rs)    (x:y:s) = f rs ((y + x) : s)
    f (Minus:rs)   (x:y:s) = f rs ((y - x) : s)
    f (Times:rs)   (x:y:s) = f rs ((y * x) : s)
    f (Div:rs)     (x:y:s) = f rs ((y `div` x) : s)
```

or avoiding duplicate code (assuming `deriving(Eq)` is set):

```haskell
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
```

<br>

## Exercise 6

The abstract data type (ADT) `Fifo tp` implements a simple data type for the storage of elements of the type `tp`, from which elements are retrieved in the same order as in which they are inserted: FIFO stands for *First In First Out queue*.

Implement a `module Fifo` such that the concrete implementation of the type Fifo is hidden from the user.

The following operations on the data type `Fifo` must be implemented:

- `empty` returns an empty queue
- `isEmpty` returns `True` for an empty queue, otherwise `False`
- `insert` returns the queue that is the result of inserting an element
- `top` returns the `oldest` element of the queue
- `remove` returns the queue that is obtained by removing the `oldest` element

Solution:

```haskell
module Fifo (Fifo, empty, isEmpty, insert, top, remove) where
  -- Interface
  empty   :: Fifo tp
  isEmpty :: Fifo tp -> Bool
  insert  :: Fifo tp -> tp -> Fifo tp
  top     :: Fifo tp -> tp
  remove  :: Fifo tp -> Fifo tp

  -- Implementation
  data Fifo tp = Q [tp]

  empty            = Q []
  isEmpty (Q [])   = True
  isEmpty  _       = False
  insert  (Q xs) x = Q (x:xs)
  top     (Q xs)   = last xs
  remove  (Q xs)   = Q (init xs)
```
