module Language.UHC.JScript.ECMS.Array
  ( JSArray
  , jsArrayToArray

  , lengthJSArray
  , indexJSArray
  )
  where

import Language.UHC.JScript.Types

import UHC.BoxArray
import UHC.Array

type JSArray x = BoxArray x

foreign import jscript "%1.length" lengthJSArray :: JSArray x -> Int
foreign import jscript "%1.toString" toString :: JSArray x -> JSString
foreign import jscript "%1.toLocaleString" toLocaleString :: JSArray x -> JSString

-- TODO: How do we deal with the fact that this fun can accept an arbitrary
-- number of arguments? How do we deal with non-arrays being passed? Do we need
-- to specified a ToJS constraint on those? Or can we let JS figure out what to
-- do?
foreign import jscript "%1.conat(%*)" concat  :: JSArray x -> JSArray x -> JSArray x
foreign import jscript "%1.conat(%*)" concat' :: JSNArgs (JSArray x) -> JSArray x

-- TODO: The ECMA standard specifies that the separator argument is optional
-- and a comma will be used if no separator is specified. How do we want to
-- model optional arguments? Do we want to make separate imports, each with
-- different arguments? Or do we want to use Maybes? Or do we want some monadic
-- construct like Roman suggested? We might also just want to make a couple of
-- alternative imports. It'd be easiest for functions with a small number of
-- optional arguments. Funs with more optional arguments still require some
-- thought though.
foreign import jscript "%1.join(%*)" join  :: JSArray x -> JSString
foreign import jscript "%1.join(%*)" join' :: JSArray x -> JSString -> JSString

foreign import jscript "%1.pop" pop :: JSArray x -> x

-- TODO: Again we are stuck with the n-argument problem
-- | Push a new element onto an array. ECMA specifies that the new length is
-- returned.
foreign import jscript "%1.push(%*)" push  :: JSArray x -> x -> Int
foreign import jscript "%1.push(%*)" push' :: JSArray x -> JSNArgs x -> Int


foreign import jscript "%1.reverse" reverse :: JSArray x -> JSArray x

foreign import jscript "%1.shift" shift :: JSArray x -> x

foreign import jscript "%1.slice(%*)" slice :: JSArray x -> Int -> Int -> JSArray x

-- TODO: The sort function is optioanl
foreign import jscript "%1.sort(%*)" sort :: JSArray x -> JSArray x

-- TODO: Can we pass a function in this way? Or do we need to peek at the C FFI for wrapper ideas?
foreign import jscript "%1.sort(%*)" sort' :: JSArray x -> (x -> x -> Int) -> JSArray x

-- TODO: Yet again, the n-argument problem.
-- TODO: "array starting at array index start" can we assume array indices are always numeric? I think so....
-- TODO: Maybe we should model the n-arguments as a list? Or as some special NArg type, which contains a list?
--  newtype NArgs a = NArgs [a]
foreign import jscript "%1.splice(%*)" splice  :: JSArray x -> Int -> Int -> JSArray x
foreign import jscript "%1.splice(%*)" splice' :: JSArray x -> Int -> Int -> JSNArgs x -> JSArray x


-- TODO: n-arg
foreign import jscript "%1.unshift(%*)" unshift  :: JSArray x -> x -> Int
foreign import jscript "%1.unshift(%*)" unshift' :: JSArray x -> JSNArgs x -> Int


-- TODO: The JS fun always returns an int. A -1 for not found and some other
-- n>=0 otherwise. We probably need Haskell wrapper functions for these things.
-- We need to come up with some naming scheme for wrappers and their underlying
-- functions.
--
-- I maintain the following naming scheme for these indexOf functions:
-- - When there are few optional arguments (e.g., n < 5), create separate functions for each optional argument
-- - These function names get a ' appended
-- - Since the lookup can fail, we want a Maybe type as a return value, hence we wrap the import
-- - Since we're wrapping, we're naming the import after the JS function name, prefixed with an underscore
-- - The HS function then just gets the JS function name (possibly with ') and calls the import
foreign import jscript "%1.indexOf(%*)" _indexOf  :: JSArray x -> x -> Int
foreign import jscript "%1.indexOf(%*)" _indexOf' :: JSArray x -> x -> Int -> Int

indexOf :: JSArray x -> x -> Maybe Int
indexOf = mkIdxRes . _indexOf

indexOf' :: JSArray x -> x -> Int -> Maybe Int
indexOf' = mkIdxRes . _indexOf'


-- TODO: Same problems as previous one
foreign import jscript "%1.lastIndexOf(%*)" _lastIndexOf  :: JSArray x -> x -> Int
foreign import jscript "%1.lastIndexOf(%*)" _lastIndexOf' :: JSArray x -> x -> Int -> Int

lastIndexOf :: JSArray x -> x -> Maybe Int
lastIndexOf = mkIdxRes . _lastIndexOf

lastIndexOf' :: JSArray x -> x -> Int -> Maybe Int
lastIndexOf' = mkIdxRes . _lastIndexOf'

mkIdxRes :: Int -> Maybe Int
mkIdxRes (-1) = Nothing
mkIdxRes n    = Just n


foreign import jscript "%1.every(%*)" every :: JSArray x -> (x -> Int -> JSArray x -> Bool) -> Bool

-- TODO: the 'a' is supposed to be the this value for the callback. Maybe we should
-- create a JSObject type which can be passed here?
foreign import jscript "%1.every(%*)" every' :: JSArray x -> (x -> Int -> JSArray x -> Bool) -> a -> Bool

-- TODO: Similar problems to above
foreign import jscript "%1.some(%*)" some  :: JSArray x -> (x -> Int -> JSArray x -> Bool) -> Bool
foreign import jscript "%1.some(%*)" some' :: JSArray x -> (x -> Int -> JSArray x -> Bool) -> a -> Bool

-- TODO: Similar problems to above
foreign import jscript "%1.forEach(%*)" forEach  :: JSArray x -> (x -> Int -> JSArray x -> ()) -> ()
foreign import jscript "%1.forEach(%*)" forEach' :: JSArray x -> (x -> Int -> JSArray x -> ()) -> a -> ()

-- TODO: Similar problems to above
foreign import jscript "%1.map(%*)" map  :: JSArray x -> (x -> Int -> JSArray x -> y) -> JSArray y
foreign import jscript "%1.map(%*)" map' :: JSArray x -> (x -> Int -> JSArray x -> y) -> a -> JSArray y


foreign import jscript "%1.filter(%*)" filter  :: JSArray x -> (x -> Int -> JSArray x -> Bool) -> JSArray x
foreign import jscript "%1.filter(%*)" filter' :: JSArray x -> (x -> Int -> JSArray x -> Bool) -> a -> JSArray x

foreign import jscript "%1.reduce(%*)" reduce  :: JSArray x -> (x -> x -> Int -> JSArray x -> y) -> y
foreign import jscript "%1.reduce(%*)" reduce' :: JSArray x -> (x -> x -> Int -> JSArray x -> y) -> y -> y

foreign import jscript "%1.reduceRight(%*)" reduceRight  :: JSArray x -> (x -> x -> Int -> JSArray x -> y) -> y
foreign import jscript "%1.reduceRight(%*)" reduceRight' :: JSArray x -> (x -> x -> Int -> JSArray x -> y) -> y -> y


indexJSArray :: JSArray x -> Int -> x
indexJSArray = indexArray

instance FromJS (JSArray x) where
  fromJS = jsArrayToArray

jsArrayToArray :: JSArray x -> Array Int x
jsArrayToArray a
  = Array 0 (l-1) l a
  where l = lengthJSArray a

