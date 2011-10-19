module Language.UHC.JScript.Assorted where

import Language.UHC.JScript.ECMA.String

foreign import jscript "alert(%*)"
  alert :: JSString -> IO ()

