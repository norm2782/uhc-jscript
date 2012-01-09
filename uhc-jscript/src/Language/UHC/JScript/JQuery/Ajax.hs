module Language.UHC.JScript.JQuery.Ajax (AjaxOptions(..), JSAjaxOptions(..), AjaxCallback, AjaxRequestType(..), ajaxBackend, ajax, toJSOptions, mkJSAjaxCallback) where

import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.Types

import Language.UHC.JScript.Primitives  

import Data.List

data JQXHRPtr
type JQXHR = JSPtr JQXHRPtr


-- type AjaxCallback   r = JS r => r -> String -> JQXHR -> IO()
type AjaxCallback   r = r -> String -> JQXHR -> IO()
type JSAjaxCallback r = JSFunPtr (AjaxCallback r)

data AjaxRequestType = GET | POST
  deriving Show

  
data AjaxOptions a = AjaxOptions {
  ao_url         :: String,
  ao_requestType :: AjaxRequestType,
  ao_contentType :: String,
  ao_dataType    :: String
}


data JSAjaxOptions a = JSAjaxOptions {
  url         :: JSString,
  requestType :: JSString,
  contentType :: JSString,
  dataType    :: JSString
}

instance Show (AjaxOptions a) where
  show jsopt= "AjaxOptions: " ++ intercalate " " [show $ ao_url jsopt]

instance Show (JSAjaxOptions a) where
  show jsopt = "JSAjaxOptions: " ++ intercalate " " [show $ url jsopt]

toJSOptions :: AjaxOptions a -> JSAjaxOptions a
toJSOptions options = let url'         = toJS (ao_url         options)
                          requestType' = toJS (show $ ao_requestType options)
                          contentType' = toJS (ao_contentType options)
                          dataType'    = toJS (ao_dataType    options)
                      in JSAjaxOptions { url         = url' 
                                       , requestType = requestType'
                                       , contentType = contentType'
                                       , dataType    = dataType'
                                       }
                       

ajaxBackend :: (JS r, JS v) => (JSPtr a -> IO ()) -> AjaxOptions a -> v -> AjaxCallback r -> AjaxCallback r -> IO ()
ajaxBackend cont options valdata onSuccess onFailure = 
  do let jsOptions = toJSOptions options
     onSuccess' <- mkJSAjaxCallback onSuccess
     onFailure' <- mkJSAjaxCallback onFailure
     o <- mkObj jsOptions
     _ <- setAttr "type"    (requestType jsOptions) o
     _ <- setAttr "success" onSuccess'              o
     _ <- setAttr "error"   onFailure'              o
     _ <- setAttr "data"    valdata                 o
     _ajaxQ (toJS "jcu_app") o

ajax :: (JS r, JS v) => AjaxOptions a -> v -> AjaxCallback r -> AjaxCallback r -> IO ()
ajax = ajaxBackend _ajax
                  
                  

foreign import jscript "wrapper"
  mkJSAjaxCallback :: AjaxCallback r -> IO (JSAjaxCallback r)


foreign import jscript "$.ajax(%1)"
  _ajax :: JSPtr a -> IO ()
  
foreign import jscript "$.ajaxq(%*)"
  _ajaxQ :: JSString -> JSPtr a -> IO ()  