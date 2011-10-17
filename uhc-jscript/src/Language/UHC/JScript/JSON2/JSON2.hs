module Language.UHC.JScript.JSON2.JSON2 where

-- | Wrapper for json2.js, as found at http://documentcloud.github.com/backbone

import Language.UHC.JScript.ECMA.Array
import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.Primitives
import Language.UHC.JScript.Types


data JSONPtr
type JSON = JSPtr JSONPtr

stringify :: JSPtr a -> IO String
stringify p = do
  jss <- _stringify p
  return $ fromJS jss

foreign import jscript "JSON.stringify(%*)"
  _stringify :: JSPtr a -> IO JSString

stringify' :: JSArray a -> IO String
stringify' p = do
  jss <- _stringify' p
  return $ fromJS jss

foreign import jscript "JSON.stringify(%*)"
  _stringify' :: JSArray a -> IO JSString

-- TODO: All permutations for stringify

parse :: String -> IO (JSPtr a)
parse = _parse . toJS

parse' :: String -> IO () -> IO (JSPtr a)
parse' s c = _parse' (toJS s) c

foreign import jscript "JSON.parse(%*)"
  _parse :: JSString -> IO (JSPtr a)

foreign import jscript "JSON.parse(%*)"
  _parse' :: JSString -> IO () -> IO (JSPtr a)
