module Main where

main :: IO ()
main = acceptsNArgs [1..10]

foreign import jscript "acceptsNArgs(%[*])"
  acceptsNArgs :: [Int] -> IO ()
