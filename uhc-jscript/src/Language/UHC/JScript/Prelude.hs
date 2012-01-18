module Language.UHC.JScript.Prelude (
    module Language.UHC.JScript.Types
  , module Language.UHC.JScript.Primitives
  , module Language.UHC.JScript.ECMA.String

  , wrapIO)
 where

import Language.UHC.JScript.Types
import Language.UHC.JScript.Primitives   
import Language.UHC.JScript.ECMA.String  

foreign import jscript "wrapper"
  wrapIO :: IO () -> IO (JSFunPtr (IO ()))