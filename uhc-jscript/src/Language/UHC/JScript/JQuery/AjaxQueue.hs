module Language.UHC.JScript.JQuery.AjaxQueue (ajaxQ) where

import Language.UHC.JScript.Primitives
import Language.UHC.JScript.Types

import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.JQuery.Ajax

import Language.UHC.JScript.Assorted (alert, _alert)
  
ajaxQ  :: String -> AjaxOptions a -> IO ()
ajaxQ queuename options = do alert (show $ options)
                             alert (ao_url         options)
                             _alert (toJS $ ao_url         options)
                             _alert $ toJS (ao_requestType options)
                             _alert $ toJS (ao_contentType options)
                             _alert $ toJS (ao_dataType    options)
                             -- let foo = toJSOptions options
                             -- _alert $ jsao_url foo
                             -- alert (show $ toJSOptions options)
                             o <- mkObj (toJSOptions options)
                             return ()
                             -- _ajaxQ (toJS queuename) o 
  
foreign import jscript "$.ajaxq(%*)"
  _ajaxQ :: JSString -> JSPtr a -> IO ()