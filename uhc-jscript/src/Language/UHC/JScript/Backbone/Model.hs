module Language.UHC.JScript.Backbone.Model where

import Language.UHC.JScript.Primitives
import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.Types


foreign import jscript "Backbone.Model.extend(%*)"
  extend :: JSFunPtr a -> IO (JSFunPtr b)

get :: JSPtr p -> String -> IO a
get p s = _get p (toJS s)

foreign import jscript "%1.get(%2)"
  _get :: JSPtr p -> JSString -> IO a

foreign import jscript "%1.set(%2)"
  set :: JSPtr p -> AnonObj -> IO ()

foreign import jscript "%1.set(%*)"
  set' :: JSPtr p -> AnonObj -> AnonObj -> IO ()

escape :: JSPtr p -> String -> IO String
escape p s = fromJSM $ _escape p (toJS s)

foreign import jscript "%1.escape(%2)"
  _escape :: JSPtr p -> JSString -> IO JSString

