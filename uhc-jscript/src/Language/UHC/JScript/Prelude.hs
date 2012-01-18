module Language.UHC.JScript.Prelude (
    module Language.UHC.JScript.Types
  , module Language.UHC.JScript.Primitives
  , module Language.UHC.JScript.ECMA.String

  , wrapIO
  , wrapJSPtraIO)
 where

import Language.UHC.JScript.Types
import Language.UHC.JScript.Primitives   
import Language.UHC.JScript.ECMA.String  

foreign import jscript "wrapper"
  wrapIO :: IO () -> IO (JSFunPtr (IO ()))
  
foreign import jscript "wrapper"
  wrapJSPtraIO :: (JSPtr a -> IO ()) -> IO (JSFunPtr(JSPtr a -> IO ()))  