module Language.UHC.JScript.Assorted where

import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.Types
import Language.UHC.JScript.Primitives

alert :: String -> IO ()
alert = _alert . toJS

foreign import jscript "alert(%*)"
  _alert :: JSString -> IO ()
