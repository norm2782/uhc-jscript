{-# LANGUAGE MultiParamTypeClasses #-}

module Language.UHC.JScript.ECMA.String where

import Language.UHC.JScript.Types

instance ToJS String JSString where
  toJS = stringToJSString

type JSString = PackedString

foreign import jscript "String.fromCharCode(%*)"
  fromCharCode :: Int -> JSString

foreign import jscript "String.fromCharCode(%*)"
  fromCharCode2 :: Int -> Int -> JSString
-- etc.

foreign import jscript "%1.toString()"
  toString :: JSString -> JSString

foreign import jscript "%1.valueOf()"
  valueOf :: JSString -> JSString

foreign import jscript "%1.charAt(%2)"
  charAt :: JSString -> Int -> JSString

foreign import jscript "%1.charCodeAt(%2)"
  charCodeAt :: JSString -> Int -> Int

foreign import jscript "%1.concat(%*)"
  concat :: JSString -> JSString -> JSString

foreign import jscript "%1.concat(%*)"
  concat2 :: JSString -> JSString -> JSString -> JSString
-- etc.

foreign import jscript "%1.indexOf(%*)"
  _indexOf  :: JSString -> JSString -> Int

foreign import jscript "%1.indexOf(%*)"
  _indexOf' :: JSString -> JSString -> Int -> Int

indexOf :: JSString -> JSString -> Maybe Int
indexOf a x = mkIdxRes $ _indexOf a x

indexOf' :: JSString -> JSString -> Int -> Maybe Int
indexOf' a x i = mkIdxRes $ _indexOf' a x i

foreign import jscript "%1.lastIndexOf(%*)"
  _lastIndexOf  :: JSString -> JSString -> Int

foreign import jscript "%1.lastIndexOf(%*)"
  _lastIndexOf' :: JSString -> JSString -> Int -> Int

lastIndexOf :: JSString -> JSString -> Maybe Int
lastIndexOf a x = mkIdxRes $ _lastIndexOf a x

lastIndexOf' :: JSString -> JSString -> Int -> Maybe Int
lastIndexOf' a x i = mkIdxRes $ _lastIndexOf' a x i

foreign import jscript "%1.localeCompare(%*)"
  localeCompare :: JSString -> JSString -> Int

-- TODO: The argument to match() should be a regex. Define a regex type?
-- Though, in JS, just supplying a string works fine too.
foreign import jscript "%1.match(%*)"
  match :: JSString -> JSString -> [JSString]

foreign import jscript "%1.replace(%*)"
  replace :: JSString -> JSString -> JSString -> JSString

foreign import jscript "%1.search(%*)"
  _search :: JSString -> JSString -> Int

search :: JSString -> JSString -> Maybe Int
search a x = mkIdxRes $ _search a x

foreign import jscript "%1.slice(%*)"
  slice :: JSString -> Int -> Int -> JSString

-- TODO: The separator argument can also be a RegExp
foreign import jscript "%1.split(%*)"
  split :: JSString -> JSString -> [JSString]

foreign import jscript "%1.split(%*)"
  split' :: JSString -> JSString -> Int -> [JSString]

foreign import jscript "%1.substring(%*)"
  substring :: JSString -> Int -> Int -> JSString

foreign import jscript "%1.toLowerCase()"
  toLowerCase :: JSString -> JSString

foreign import jscript "%1.toLocaleLowerCase()"
  toLocaleLowerCase :: JSString -> JSString

foreign import jscript "%1.toUpperCase()"
  toUpperCase :: JSString -> JSString

foreign import jscript "%1.toLocaleUpperCase()"
  toLocaleUpperCase :: JSString -> JSString

foreign import jscript "%1.trim()"
  trim :: JSString -> JSString

foreign import jscript "%1.lenght"
  length :: JSString -> Int

foreign import prim "primStringToPackedString"
  stringToJSString :: String -> JSString
