module Language.UHC.JScript.Backbone.Collection where

import Language.UHC.JScript.Backbone.Model
import Language.UHC.JScript.ECMA.Array
import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.Primitives
import Language.UHC.JScript.Types


data BBCollectionPtr a
type BBCollection a = JSPtr (BBCollectionPtr a)

foreign import jscript "Backbone.Collection.extend(%*)"
  extend :: AnonObj -> IO (JSFunPtr a)

foreign import jscript "Backbone.Collection.extend(%*)"
  extend' :: AnonObj -> AnonObj -> IO (JSFunPtr a)

model :: JSFunPtr b -> BBCollection a -> IO (BBCollection a)
model = setAttr "model"

models :: BBCollection a -> IO (JSArray (BBModel b))
models = getAttr "models"

foreign import jscript "%1.toJSON()"
  toJSON :: BBCollection a -> IO (JSArray b)

-- TODO: Underscore methods

foreign import jscript "%1.add(%*)"
  add :: BBCollection a -> BBModel b -> IO ()

foreign import jscript "%1.add(%*)"
  add' :: BBCollection a -> BBModel b -> AnonObj -> IO ()

foreign import jscript "%1.add(%*)"
  addA :: BBCollection a -> JSArray (BBModel b) -> IO ()

foreign import jscript "%1.add(%*)"
  addA' :: BBCollection a -> JSArray (BBModel b) -> AnonObj -> IO ()

foreign import jscript "%1.remove(%*)"
  remove :: BBCollection a -> BBModel b -> IO ()

foreign import jscript "%1.remove(%*)"
  remove' :: BBCollection a -> BBModel b -> AnonObj -> IO ()

foreign import jscript "%1.remove(%*)"
  removeA :: BBCollection a -> JSArray (BBModel b) -> IO ()

foreign import jscript "%1.remove(%*)"
  removeA' :: BBCollection a -> JSArray (BBModel b) -> AnonObj -> IO ()

foreign import jscript "%1.get(%*)"
  get :: BBCollection a -> Int -> IO (BBModel b)


getByCid :: String -> BBCollection a -> IO (BBModel b)
getByCid s c = _getByCid (toJS s) c

foreign import jscript "%1.getByCid(%*)"
  _getByCid :: JSString -> BBCollection a -> IO (BBModel b)


foreign import jscript "%1.at(%*)"
  at :: Int -> IO (BBModel a)

clength :: BBCollection a -> IO Int
clength = getAttr "length"

setComperator :: JSFunPtr a -> BBCollection b -> IO (BBCollection b)
setComperator = setAttr "comparator"


foreign import jscript "%1.sort()"
  sort :: BBCollection a -> IO ()

foreign import jscript "%1.sort(%*)"
  sort' :: BBCollection a -> AnonObj -> IO ()

pluck :: BBCollection a -> String -> IO (JSArray b)
pluck c s = _pluck c (toJS s)

foreign import jscript "%1.pluck(%*)"
  _pluck :: BBCollection a -> JSString -> IO (JSArray b)

setUrl :: String -> BBCollection a -> IO (BBCollection a)
setUrl s m = setAttr "url" (toJS s) m

setUrl' :: JSFunPtr b -> BBCollection a -> IO (BBCollection a)
setUrl' = setAttr "url"

-- TODO: parse

foreign import jscript "%1.fetch()"
  fetch :: BBCollection a -> IO ()

foreign import jscript "%1.fetch(%*)"
  fetch' :: BBCollection a -> AnonObj -> IO ()

foreign import jscript "%1.reset(%*)"
  reset :: BBCollection a -> JSArray (BBModel b) -> IO ()

foreign import jscript "%1.reset(%*)"
  reset' :: BBCollection a -> JSArray (BBModel b) -> AnonObj -> IO ()

foreign import jscript "%1.create(%*)"
  create :: BBCollection a -> JSArray (BBModel b) -> IO ()

foreign import jscript "%1.create(%*)"
  create' :: BBCollection a -> JSArray (BBModel b) -> AnonObj -> IO ()
