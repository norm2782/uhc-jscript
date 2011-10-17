module Language.UHC.JScript.Backbone.Model where

import Language.UHC.JScript.Primitives
import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.Types


data BBModel a

foreign import jscript "Backbone.Model.extend(%*)"
  extend :: JSFunPtr a -> IO (JSFunPtr b)

get :: JSPtr (BBModel a) -> String -> IO b
get p s = _get p (toJS s)

foreign import jscript "%1.get(%2)"
  _get :: JSPtr (BBModel a) -> JSString -> IO b

foreign import jscript "%1.set(%2)"
  set :: JSPtr (BBModel a) -> AnonObj -> IO ()

foreign import jscript "%1.set(%*)"
  set' :: JSPtr (BBModel a) -> AnonObj -> AnonObj -> IO ()

escape :: JSPtr (BBModel a) -> String -> IO String
escape p s = fromJSM $ _escape p (toJS s)

foreign import jscript "%1.escape(%2)"
  _escape :: JSPtr (BBModel a) -> JSString -> IO JSString

has :: JSPtr (BBModel a) -> String -> IO Bool
has p s = _has p (toJS s)

foreign import jscript "%1.has(%2)"
  _has :: JSPtr (BBModel a) -> JSString -> IO Bool

unset :: JSPtr (BBModel a) -> String -> IO ()
unset p s = _unset p (toJS s)

foreign import jscript "%1.unset(%2)"
  _unset :: JSPtr (BBModel a) -> JSString -> IO ()

unset' :: JSPtr (BBModel a) -> String -> AnonObj -> IO ()
unset' p s o = _unset' p (toJS s) o

foreign import jscript "%1.unset(%*)"
  _unset' :: JSPtr (BBModel a) -> JSString -> AnonObj -> IO ()

foreign import jscript "%1.clear()"
  clear :: JSPtr (BBModel a) -> IO ()

foreign import jscript "%1.clear(%*)"
  clear' :: JSPtr (BBModel a) -> AnonObj -> IO ()

silentOpt :: IO AnonObj
silentOpt = do
  obj <- mkAnonObj
  setAttr "silent" True obj
  return obj

modelID :: JSPtr (BBModel a) -> IO String
modelID = getAttr "id"

modelCID :: JSPtr (BBModel a) -> IO String
modelCID = getAttr "cid"

modelAttributes :: JSPtr (BBModel a) -> IO AnonObj
modelAttributes = getAttr "attributes"

-- TODO: defaults

foreign import jscript "%1.toJSON()"
  toJSON :: JSPtr (BBModel a) -> IO AnonObj

foreign import jscript "%1.fetch()"
  fetch :: JSPtr (BBModel a) -> IO ()

foreign import jscript "%1.fetch(%*)"
  fetch' :: JSPtr (BBModel a) -> AnonObj -> IO ()




