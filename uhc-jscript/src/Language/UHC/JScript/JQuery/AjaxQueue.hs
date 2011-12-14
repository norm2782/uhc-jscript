module Language.UHC.JScript.JQuery.AjaxQueue (ajaxQ) where

import Language.UHC.JScript.Primitives
import Language.UHC.JScript.Types

import Language.UHC.JScript.ECMA.String
import   Language.UHC.JScript.JQuery.Ajax
  
ajaxQ  :: String -> AjaxOptions a -> IO ()
ajaxQ queuename options = do o <- mkObj (toJSOptions options)
                             _ajaxQ (toJS queuename) o 
  
foreign import jscript "$.ajaxq(%*)"
  _ajaxQ :: JSString -> JSPtr a -> IO ()