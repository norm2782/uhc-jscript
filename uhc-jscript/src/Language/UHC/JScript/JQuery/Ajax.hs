module Language.UHC.JScript.JQuery.Ajax (AjaxOptions(..), JSAjaxOptions(..), AjaxCallback, ajaxBackend, ajax, toJSOptions) where

import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.Types

import Language.UHC.JScript.Primitives  

import Data.List

type AjaxCallback a = JSFunPtr (JSPtr a -> IO())
  
data AjaxOptions a = AjaxOptions {
  ao_url         :: String,
  ao_requestType :: String,
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
                          requestType' = toJS (ao_requestType options)
                          contentType' = toJS (ao_contentType options)
                          dataType'    = toJS (ao_dataType    options)
                      in JSAjaxOptions { url         = url' 
                                       , requestType = requestType'
                                       , contentType = contentType'
                                       , dataType    = dataType'
                                       }
                       

ajaxBackend :: (JSPtr a -> IO ()) -> AjaxOptions a -> AjaxCallback a -> AjaxCallback a -> IO ()
ajaxBackend cont options onSuccess onFailure = 
  do let jsOptions = toJSOptions options
     o <- mkObj jsOptions
     _ <- setAttr "type"    (requestType jsOptions) o
     _ <- setAttr "success" onSuccess               o
     _ <- setAttr "error"   onFailure               o
     _ajax o

ajax :: AjaxOptions a -> AjaxCallback a -> AjaxCallback a -> IO ()
ajax = ajaxBackend _ajax
                  
                  
                  


foreign import jscript "$.ajax(%1)"
  _ajax :: JSPtr a -> IO ()