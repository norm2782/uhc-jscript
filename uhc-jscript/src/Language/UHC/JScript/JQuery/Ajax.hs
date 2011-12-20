module Language.UHC.JScript.JQuery.Ajax (AjaxOptions(..), JSAjaxOptions(..), AjaxCallback, Callback, AjaxRequestType(..), ajaxBackend, ajax, toJSOptions, mkJSAjaxCallback) where

import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.Types

import Language.UHC.JScript.Primitives  

import Data.List


type Callback a b = JSPtr a -> String -> JSPtr b -> IO()
type AjaxCallback a   b = JSPtr a -> String -> JSPtr b -> IO()
type JSAjaxCallback a b = JSFunPtr (AjaxCallback a b)

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
                       

ajaxBackend :: (JSPtr a -> IO ()) -> AjaxOptions a -> AjaxCallback a b -> AjaxCallback a b -> IO ()
ajaxBackend cont options onSuccess onFailure = 
  do let jsOptions = toJSOptions options
     onSuccess' <- mkJSAjaxCallback onSuccess
     onFailure' <- mkJSAjaxCallback onFailure
     o <- mkObj jsOptions
     _ <- setAttr "type"    (requestType jsOptions) o
     _ <- setAttr "success" onSuccess'              o
     _ <- setAttr "error"   onFailure'               o
     _ajaxQ (toJS "jcu_app") o

ajax :: AjaxOptions a -> AjaxCallback a b -> AjaxCallback a b -> IO ()
ajax = ajaxBackend _ajax
                  
                  

foreign import jscript "wrapper"
  mkJSAjaxCallback :: AjaxCallback a b -> IO (JSAjaxCallback a b)


foreign import jscript "$.ajax(%1)"
  _ajax :: JSPtr a -> IO ()
  
foreign import jscript "$.ajaxq(%*)"
  _ajaxQ :: JSString -> JSPtr a -> IO ()  