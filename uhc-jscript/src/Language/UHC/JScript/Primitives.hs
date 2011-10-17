module Language.UHC.JScript.Primitives where

import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.Types



data JSPtr a
data JSFunPtr a
type JSString = PackedString
type AnonObj = JSPtr ()

foreign import prim "primMkAnonObj"
  mkAnonObj :: IO AnonObj


mkObj :: String -> IO (JSPtr p)
mkObj = _mkObj . toJS

foreign import prim "primMkObj"
  _mkObj :: JSString -> IO (JSPtr p)

mkCtor :: String -> IO (JSFunPtr a)
mkCtor = _mkCtor . toJS

foreign import prim "primMkCtor"
  _mkCtor :: JSString -> IO (JSFunPtr a)

getCtor :: String -> IO (JSFunPtr a)
getCtor s1 = _getCtor (toJS s1)

foreign import prim "primGetCtor"
  _getCtor :: JSString -> IO (JSFunPtr a)

setCtor :: String -> JSFunPtr a -> IO ()
setCtor s1 fp = _setCtor (toJS s1) fp

foreign import prim "primSetCtor"
  _setCtor :: JSString -> JSFunPtr a -> IO ()

getAttr :: String -> JSPtr p -> IO a
getAttr s p = _getAttr (toJS s) p

foreign import prim "primGetAttr"
  _getAttr :: JSString -> JSPtr p -> IO a


setAttr :: String -> a -> JSPtr p -> IO (JSPtr p)
setAttr s a p = _setAttr (toJS s) a p

foreign import prim "primSetAttr"
  _setAttr :: JSString -> a -> JSPtr p -> IO (JSPtr p)


modAttr :: String -> (a -> b) -> JSPtr p -> IO (JSPtr p)
modAttr s f p = _modAttr (toJS s) f p

foreign import prim "primModAttr"
  _modAttr :: JSString -> (a -> b) -> JSPtr p -> IO (JSPtr p)


getProtoAttr :: String -> String -> IO a
getProtoAttr x y = _getProtoAttr (toJS x) (toJS y)

foreign import prim "primGetProtoAttr"
  _getProtoAttr :: JSString -> JSString -> IO a


setProtoAttr :: String -> a -> String -> IO ()
setProtoAttr x a y = _setProtoAttr (toJS x) a (toJS y)

foreign import prim "primSetProtoAttr"
  _setProtoAttr :: JSString -> a -> JSString -> IO ()


modProtoAttr :: String -> (a -> b) -> String -> IO ()
modProtoAttr x f y = _modProtoAttr (toJS x) f (toJS y)

foreign import prim "primModProtoAttr"
  _modProtoAttr :: JSString -> (a -> b) -> JSString -> IO ()


foreign import prim "primStringToPackedString"
  toJS :: String -> JSString
