-- The goal of this module is to test the following usecase:
--
-- A JS function can take an arbitrary number of arguments. The ECMA standard,
-- as well as popular libraries like jQuery make use of this feature. Example:
--
-- myArr.concat(arr1, arr2, arr3, arr4, ...); etc.
--
-- How do we encode this in Haskell?

module Main where

main :: IO ()
main = accepts3Args 1 2 3

-- The whole problem of this approach is the fact that we do not know how many
-- elements are in the list until runtime. For a stupid and simple solution,
-- see the next FFI import.
-- Could we use some type-level programming to specify the number of elements
-- that the list can receive? Like the type-level vectors we've see so very
-- frequently? This would require GADTs.. does UHC support that? More
-- importantly, would this provide a solution? We would definitely know the
-- _maximum_ number of elements in the vector, but would this be enough? Also,
-- would this be sufficiently more powerful than the approach below? At the
-- very least, would the increased expressiveness be worth all the hassle of
-- type-level programming?
-- Another question related to that vector... would it specify the _exact_
-- number of elements in the vector? Also, would this actually give us
-- anything?
--
-- I think the bottom line is that lists won't work as a pure Haskell solution.
-- They have a dynamic lenght. We cannot compile JS this way. We will require
-- vectors of which the length is encoded in the type. This, however, is rather
-- complicated.
--
-- Another solution might be to do part of this in the JS world. When we detect
-- an n-argument application, we generate a call to the JS apply() function.
-- This function takes the function name that is to be called as a first
-- argument and a list of arguments as second parameter. We would merge all
-- arguments into one list (e.g. by prepending the first arguments to the
-- n-args list) and then call apply(). Does the UHC JS lib already have a
-- function for this?
--
-- This function below is commented out, because the proposed interface has
-- been discarded in favor of the suggested approach below
{- foreign import jscript "acceptsNArgs(%[*])"-}
  {- acceptsNArgs :: [Int] -> IO ()-}

-- This solution isn't exactly pretty: we're still hardcoding the number of
-- arguments the JS function is given. The difference is that on the JS side,
-- the overloading happens nicely. Also, it's the way one would expect an FFI
-- import to be defined; there are no weird n-argument conventions.
foreign import jscript "acceptsNArgs(%*)"
  accepts3Args :: Int -> Int -> Int -> IO ()
