-- | Binding for the jquery-ajaxq library by Oleg Podolsky.
--   It can be found at: http://code.google.com/p/jquery-ajaxq/
module Language.UHC.JScript.JQuery.AjaxQueue (ajaxQ) where

import Language.UHC.JScript.Primitives
import Language.UHC.JScript.Types

import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.JQuery.Ajax

import Language.UHC.JScript.Assorted (alert, _alert)
  
-- | Partial application of the backend for use with the AjaxQueue library  
ajaxQ  :: (JS r, JS v)  => String -> AjaxOptions a -> v -> AjaxCallback r -> AjaxCallback r -> IO ()
ajaxQ queuename = ajaxBackend (_ajaxQ $ toJS queuename)
  
foreign import jscript "$.ajaxq(%*)"
  _ajaxQ :: JSString -> JSPtr a -> IO ()