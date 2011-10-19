module Language.UHC.JScript.Backbone.View where

import Language.UHC.JScript.JQuery.JQuery
import Language.UHC.JScript.Primitives
import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.Types
import Language.UHC.JScript.W3C.HTML5

data BBViewPtr
type BBView = JSPtr BBViewPtr

foreign import jscript "Backbone.View.extend(%*)"
  extend :: AnonObj -> IO (JSFunPtr b)

foreign import jscript "Backbone.View.extend(%*)"
  extend' :: AnonObj -> AnonObj -> IO (JSFunPtr b)

getEl :: BBView -> IO Element
getEl = getAttr "el"

setEl :: Element -> BBView -> IO BBView
setEl = setAttr "el"

jQuery :: String -> IO JQuery
jQuery = _jQuery . toJS

jQuery' :: String -> JSPtr a -> IO JQuery
jQuery' s j = _jQuery' (toJS s) j

foreign import jscript "%1.$(%*)"
  _jQuery :: JSString -> IO JQuery

foreign import jscript "%1.$(%*)"
  _jQuery' :: JSString -> JSPtr a -> IO JQuery

setRender :: JSFunPtr a -> BBView -> IO BBView
setRender = setAttr "render"

foreign import jscript "%1.remove()"
  remove :: BBView -> IO ()

make :: String -> IO Element
make = _make . toJS

foreign import jscript "%1.make(%*)"
  _make :: JSString -> IO Element

make' :: String -> AnonObj -> IO Element
make' s o = _make' (toJS s) o

foreign import jscript "%1.make(%*)"
  _make' :: JSString -> AnonObj -> IO Element

make'' :: String -> AnonObj -> String -> IO Element
make'' s1 o s2 = _make'' (toJS s1) o (toJS s2)

foreign import jscript "%1.make(%*)"
  _make'' :: JSString -> AnonObj -> JSString -> IO Element

foreign import jscript "delegateEvents(%*)"
  delegateEvents :: AnonObj -> IO ()
