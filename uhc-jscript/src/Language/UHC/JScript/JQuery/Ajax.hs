module Language.UHC.JScript.JQuery.Ajax (AjaxOptions(..), JSAjaxOptions(..), ajax, toJSOptions) where

import Language.UHC.JScript.Types

import Language.UHC.JScript.Primitives  
  
data AjaxOptions a = AjaxOptions {
  ao_url         :: String,
  ao_requestType :: String,
  ao_contentType :: String,
  ao_dataType    :: String,
  ao_success     :: JSFunPtr (a -> IO()),
  ao_failure     :: JSFunPtr (a -> IO())
  
}

data JSAjaxOptions a = JSAjaxOptions {
  jsao_url         :: JSString,
  jsao_requestType :: JSString,
  jsao_contentType :: JSString,
  jsao_dataType    :: JSString,
  jsao_success     :: JSFunPtr (a -> IO()),
  jsao_failure     :: JSFunPtr (a -> IO())
  
}

toJSOptions :: AjaxOptions a -> JSAjaxOptions a
toJSOptions options = let url'         = toJS (ao_url         options)
                          requestType' = toJS (ao_requestType options)
                          contentType' = toJS (ao_contentType options)
                          dataType'    = toJS (ao_dataType    options)
                      in JSAjaxOptions { jsao_url         = url' 
                                       , jsao_requestType = requestType'
                                       , jsao_contentType = contentType'
                                       , jsao_dataType    = dataType'
                                       , jsao_success     = ao_success options
                                       , jsao_failure     = ao_failure options}
                         

ajax :: AjaxOptions a -> IO ()
ajax options = do o <- mkObj (toJSOptions options)
                  _ajax o
                  
                  
                  


foreign import jscript "$.ajax(%1)"
  _ajax :: JSPtr a -> IO ()