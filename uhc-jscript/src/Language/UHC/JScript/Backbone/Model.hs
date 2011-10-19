module Language.UHC.JScript.Backbone.Model where

import Language.UHC.JScript.Primitives
import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.Types


data BBModelPtr a
type BBModel a = JSPtr (BBModelPtr a)

foreign import jscript "Backbone.Model.extend(%*)"
  extend :: AnonObj -> IO (JSFunPtr b)

foreign import jscript "Backbone.Model.extend(%*)"
  extend' :: AnonObj -> AnonObj -> IO (JSFunPtr b)


get :: BBModel a -> String -> IO b
get p s = _get p (toJS s)

foreign import jscript "%1.get(%2)"
  _get :: BBModel a -> JSString -> IO b

foreign import jscript "%1.set(%2)"
  set :: BBModel a -> AnonObj -> IO ()

foreign import jscript "%1.set(%*)"
  set' :: BBModel a -> AnonObj -> AnonObj -> IO ()

escape :: BBModel a -> String -> IO String
escape p s = fromJSM $ _escape p (toJS s)

foreign import jscript "%1.escape(%2)"
  _escape :: BBModel a -> JSString -> IO JSString

has :: BBModel a -> String -> IO Bool
has p s = _has p (toJS s)

foreign import jscript "%1.has(%2)"
  _has :: BBModel a -> JSString -> IO Bool

unset :: BBModel a -> String -> IO ()
unset p s = _unset p (toJS s)

foreign import jscript "%1.unset(%2)"
  _unset :: BBModel a -> JSString -> IO ()

unset' :: BBModel a -> String -> AnonObj -> IO ()
unset' p s o = _unset' p (toJS s) o

foreign import jscript "%1.unset(%*)"
  _unset' :: BBModel a -> JSString -> AnonObj -> IO ()

foreign import jscript "%1.clear()"
  clear :: BBModel a -> IO ()

foreign import jscript "%1.clear(%*)"
  clear' :: BBModel a -> AnonObj -> IO ()

silentOpt :: IO AnonObj
silentOpt = do
  obj <- mkAnonObj
  setAttr "silent" True obj
  return obj

getModelID :: BBModel a -> IO String
getModelID m = fromJSM ida
  where  ida :: IO JSString
         ida = getAttr "id" m

getModelCID :: BBModel a -> IO String
getModelCID m = fromJSM cida
  where  cida :: IO  JSString
         cida = getAttr "cid" m

getModelAttributes :: BBModel a -> IO AnonObj
getModelAttributes = getAttr "attributes"

-- TODO: defaults

foreign import jscript "%1.toJSON()"
  toJSON :: BBModel a -> IO AnonObj

foreign import jscript "%1.fetch()"
  fetch :: BBModel a -> IO ()

foreign import jscript "%1.fetch(%*)"
  fetch' :: BBModel a -> AnonObj -> IO ()

foreign import jscript "%1.save()"
  save :: BBModel a -> IO ()

foreign import jscript "%1.save(%*)"
  save' :: BBModel a -> AnonObj -> IO ()

foreign import jscript "%1.save(%*)"
  save'' :: BBModel a -> AnonObj -> AnonObj -> IO ()

foreign import jscript "%1.destroy()"
  destroy :: BBModel a -> IO ()

foreign import jscript "%1.destroy(%*)"
  destroy' :: BBModel a -> AnonObj -> IO ()

-- TODO: validate
-- Validate is a method in the Backbone.Model class. It does nothing by default
-- and the user is encouraged to override it. It is passed an object with
-- attributes which need to be validated. If it returns nothing, validation
-- succeeds, otherwise validations has failed. Can we just pass a function like
-- this? Also, will an empty string count as success as well?
setValidateFn :: (AnonObj -> JSString) -> BBModel a -> IO (BBModel a)
setValidateFn = setAttr "validate"


getUrl :: BBModel a -> IO String
getUrl = fromJSM . _getUrl

foreign import jscript "getUrl(%1)"
  _getUrl :: BBModel a -> IO JSString


setUrl :: String -> BBModel a -> IO (BBModel a)
setUrl s m = setAttr "url" (toJS s) m

setUrl' :: JSFunPtr b -> BBModel a -> IO (BBModel a)
setUrl' = setAttr "url"

getUrlRoot :: BBModel a -> IO String
getUrlRoot m = fromJSM rt
  where  rt :: IO JSString
         rt = getAttr "urlRoot" m

setUrlRoot :: String -> BBModel a -> IO (BBModel a)
setUrlRoot s m = setAttr "urlRoot" (toJS s) m

-- TODO: Same concerns as setValidateFn
setParseFn :: (AnonObj -> AnonObj) -> BBModel a -> IO (BBModel a)
setParseFn = setAttr "parse"


foreign import jscript "%1.clone()"
  clone :: BBModel a -> IO (BBModel a)

foreign import jscript "%1.isNew()"
  isNew :: BBModel a -> IO Bool

foreign import jscript "%1.change()"
  change :: BBModel a -> IO ()

foreign import jscript "%1.hasChanged()"
  hasChanged :: BBModel a -> IO Bool

hasChanged' :: BBModel a -> String -> IO Bool
hasChanged' p a = _hasChanged' p (toJS a)

foreign import jscript "%1.hasChanged(%2)"
  _hasChanged' :: BBModel a -> JSString -> IO Bool


foreign import jscript "%1.changedAttributes()"
  changedAttributes :: BBModel a -> IO AnonObj

foreign import jscript "%1.changedAttributes(%2)"
  changedAttributes' :: BBModel a -> AnonObj -> IO AnonObj

previous :: BBModel a -> String -> IO b
previous p a = _previous p (toJS a)

foreign import jscript "%1.previous(%2)"
  _previous :: BBModel a -> JSString -> IO b

foreign import jscript "%1.previousAttributes()"
  previousAttributes :: BBModel a -> IO AnonObj
