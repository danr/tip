module List where

import Prelude(Bool, otherwise)
import qualified Prelude
import Prelude (Bool(..),otherwise)
import Tip.DSL

(++) :: [a] -> [a] -> [a]
(x:xs) ++ ys = x:(xs ++ ys)
[]     ++ ys = ys

prop_rid xs = xs ++ [] =:= xs

map :: (a -> b) -> [a] -> [b]
map f (x:xs) = f x:map f xs
map f []     = []

filter :: (a -> Bool) -> [a] -> [a]
filter p (x:xs) | p x       = x:filter p xs
                | otherwise = filter p xs
filter p [] = []

{-# NOINLINE (.) #-}
f . g = \ x -> f (g x)

f `dot` g = \ x -> f (g x)

map_compose f g = map f . map g =:= map (f . g)

map_compose2 f g = map f `dot` map g =:= map (f `dot` g)

data Nat = Zero | Succ Nat

rotate :: Nat -> [a] -> [a]
rotate Zero     xs     = xs
rotate (Succ n) []     = []
rotate (Succ n) (x:xs) = rotate n (xs ++ [x])

length :: [a] -> Nat
length []     = Zero
length (_:xs) = Succ (length xs)

prop_rotate xs = rotate (length xs) xs =:= xs

