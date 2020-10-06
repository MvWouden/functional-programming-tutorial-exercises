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