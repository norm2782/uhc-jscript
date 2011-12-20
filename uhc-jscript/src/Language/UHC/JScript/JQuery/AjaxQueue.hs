module Language.UHC.JScript.JQuery.AjaxQueue (ajaxQ) where

import Language.UHC.JScript.Primitives
import Language.UHC.JScript.Types

import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.JQuery.Ajax

import Language.UHC.JScript.Assorted (alert, _alert)
  
ajaxQ  :: String -> AjaxOptions a -> AjaxCallback a b -> AjaxCallback a b -> IO ()
ajaxQ queuename = ajaxBackend (_ajaxQ $ toJS queuename)
  
foreign import jscript "$.ajaxq(%*)"
  _ajaxQ :: JSString -> JSPtr a -> IO ()