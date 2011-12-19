module Language.UHC.JScript.JQuery.AjaxQueue (ajaxQ) where

import Language.UHC.JScript.Primitives
import Language.UHC.JScript.Types

import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.JQuery.Ajax

import Language.UHC.JScript.Assorted (alert, _alert)
  
ajaxQ  :: String -> AjaxOptions a -> AjaxCallback a -> AjaxCallback a -> IO ()
ajaxQ queuename options onSuccess onFailure = 
  do alert (show $ options)
     -- alert (ao_url         options)
     -- _alert (toJS $ ao_url         options)
     -- _alert $ toJS (ao_requestType options)
     -- _alert $ toJS (ao_contentType options)
     -- _alert $ toJS (ao_dataType    options)
     -- -- let foo = toJSOptions options
     -- -- _alert $ jsao_url foo
     -- -- alert (show $ toJSOptions options)
     let jsOptions = toJSOptions options
     o <- mkObj jsOptions
     setAttr "type" (requestType jsOptions) o
     _ <- setAttr "success" onSuccess               o
     _ <- setAttr "error"   onFailure               o
     _ajaxQ (toJS queuename) o 
  
foreign import jscript "$.ajaxq(%*)"
  _ajaxQ :: JSString -> JSPtr a -> IO ()