module Language.UHC.JScript.Backbone.Model where

import Language.UHC.JScript.Primitives
import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.Types


data BBModel a
type BBModelPtr a = JSPtr (BBModel a)

foreign import jscript "Backbone.Model.extend(%*)"
  extend :: JSFunPtr a -> IO (JSFunPtr b)

get :: BBModelPtr a -> String -> IO b
get p s = _get p (toJS s)

foreign import jscript "%1.get(%2)"
  _get :: BBModelPtr a -> JSString -> IO b

foreign import jscript "%1.set(%2)"
  set :: BBModelPtr a -> AnonObj -> IO ()

foreign import jscript "%1.set(%*)"
  set' :: BBModelPtr a -> AnonObj -> AnonObj -> IO ()

escape :: BBModelPtr a -> String -> IO String
escape p s = fromJSM $ _escape p (toJS s)

foreign import jscript "%1.escape(%2)"
  _escape :: BBModelPtr a -> JSString -> IO JSString

has :: BBModelPtr a -> String -> IO Bool
has p s = _has p (toJS s)

foreign import jscript "%1.has(%2)"
  _has :: BBModelPtr a -> JSString -> IO Bool

unset :: BBModelPtr a -> String -> IO ()
unset p s = _unset p (toJS s)

foreign import jscript "%1.unset(%2)"
  _unset :: BBModelPtr a -> JSString -> IO ()

unset' :: BBModelPtr a -> String -> AnonObj -> IO ()
unset' p s o = _unset' p (toJS s) o

foreign import jscript "%1.unset(%*)"
  _unset' :: BBModelPtr a -> JSString -> AnonObj -> IO ()

foreign import jscript "%1.clear()"
  clear :: BBModelPtr a -> IO ()

foreign import jscript "%1.clear(%*)"
  clear' :: BBModelPtr a -> AnonObj -> IO ()

silentOpt :: IO AnonObj
silentOpt = do
  obj <- mkAnonObj
  setAttr "silent" True obj
  return obj

getModelID :: BBModelPtr a -> IO String
getModelID m = fromJSM ida
  where  ida :: IO JSString
         ida = getAttr "id" m

getModelCID :: BBModelPtr a -> IO String
getModelCID m = fromJSM cida
  where  cida :: IO  JSString
         cida = getAttr "cid" m

getModelAttributes :: BBModelPtr a -> IO AnonObj
getModelAttributes = getAttr "attributes"

-- TODO: defaults

foreign import jscript "%1.toJSON()"
  toJSON :: BBModelPtr a -> IO AnonObj

foreign import jscript "%1.fetch()"
  fetch :: BBModelPtr a -> IO ()

foreign import jscript "%1.fetch(%*)"
  fetch' :: BBModelPtr a -> AnonObj -> IO ()

foreign import jscript "%1.save()"
  save :: BBModelPtr a -> IO ()

foreign import jscript "%1.save(%*)"
  save' :: BBModelPtr a -> AnonObj -> IO ()

foreign import jscript "%1.save(%*)"
  save'' :: BBModelPtr a -> AnonObj -> AnonObj -> IO ()

foreign import jscript "%1.destroy()"
  destroy :: BBModelPtr a -> IO ()

foreign import jscript "%1.destroy(%*)"
  destroy' :: BBModelPtr a -> AnonObj -> IO ()

-- TODO: validate
-- Validate is a method in the Backbone.Model class. It does nothing by default
-- and the user is encouraged to override it. It is passed an object with
-- attributes which need to be validated. If it returns nothing, validation
-- succeeds, otherwise validations has failed. Can we just pass a function like
-- this? Also, will an empty string count as success as well?
setValidateFn :: (AnonObj -> JSString) -> BBModelPtr a -> IO (BBModelPtr a)
setValidateFn = setAttr "validate"


getUrl :: BBModelPtr a -> IO String
getUrl = fromJSM . _getUrl

foreign import jscript "getUrl(%1)"
  _getUrl :: BBModelPtr a -> IO JSString

-- TODO: URL can also be a function. This function would normally use `this` to
-- create a URL. We might need some notion of `this` here as well, so we can
-- define functions that use `this`.


getUrlRoot :: BBModelPtr a -> IO String
getUrlRoot m = fromJSM rt
  where  rt :: IO JSString
         rt = getAttr "urlRoot" m

setUrlRoot :: String -> BBModelPtr a -> IO (BBModelPtr a)
setUrlRoot s m = setAttr "urlRoot" (toJS s) m

-- TODO: Same concerns as setValidateFn
setParseFn :: (AnonObj -> AnonObj) -> BBModelPtr a -> IO (BBModelPtr a)
setParseFn = setAttr "parse"


foreign import jscript "%1.clone()"
  clone :: BBModelPtr a -> IO (BBModelPtr a)

foreign import jscript "%1.isNew()"
  isNew :: BBModelPtr a -> IO Bool

foreign import jscript "%1.change()"
  change :: BBModelPtr a -> IO ()

foreign import jscript "%1.hasChanged()"
  hasChanged :: BBModelPtr a -> IO Bool

hasChanged' :: BBModelPtr a -> String -> IO Bool
hasChanged' p a = _hasChanged' p (toJS a)

foreign import jscript "%1.hasChanged(%2)"
  _hasChanged' :: BBModelPtr a -> JSString -> IO Bool


foreign import jscript "%1.changedAttributes()"
  changedAttributes :: BBModelPtr a -> IO AnonObj

foreign import jscript "%1.changedAttributes(%2)"
  changedAttributes' :: BBModelPtr a -> AnonObj -> IO AnonObj

previous :: BBModelPtr a -> String -> IO b
previous p a = _previous p (toJS a)

foreign import jscript "%1.previous(%2)"
  _previous :: BBModelPtr a -> JSString -> IO b

foreign import jscript "%1.previousAttributes()"
  previousAttributes :: BBModelPtr a -> IO AnonObj
