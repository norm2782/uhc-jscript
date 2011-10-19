module Language.UHC.JScript.Backbone.Router where

import Language.UHC.JScript.Primitives
import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.Types

data BBRouterPtr
type BBRouter = JSPtr BBRouterPtr

foreign import jscript "Backbone.Router.extend(%*)"
  extend :: AnonObj -> IO (JSFunPtr b)

foreign import jscript "Backbone.Router.extend(%*)"
  extend' :: AnonObj -> AnonObj -> IO (JSFunPtr b)

getRoutes :: BBRouter -> IO AnonObj
getRoutes = getAttr "routes"

setRoutes :: AnonObj -> BBRouter -> IO BBRouter
setRoutes = setAttr "routes"

route :: BBRouter -> String -> String -> JSFunPtr a -> IO ()
route r s1 s2 f = _route r (toJS s1) (toJS s2) f

foreign import jscript "%1.route(%*)"
  _route :: BBRouter -> JSString -> JSString -> JSFunPtr a -> IO ()

navigate :: String -> IO ()
navigate = _navigate . toJS

foreign import jscript "%1.navigate(%*)"
  _navigate :: JSString -> IO ()

navigate' :: String -> Bool -> IO ()
navigate' s b = _navigate' (toJS s) b

foreign import jscript "%1.navigate(%*)"
  _navigate' :: JSString -> Bool -> IO ()

