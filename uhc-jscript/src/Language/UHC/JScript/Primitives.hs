module Language.UHC.JScript.Primitives where

import Language.UHC.JScript.ECMA.String



data JSPtr a
type JSString = PackedString
type AnonObj = JSPtr ()

foreign import prim "primMkAnonObj"
  mkAnonObj :: IO AnonObj


mkObj :: String -> IO (JSPtr p)
mkObj = _mkObj . stringToJSString

foreign import prim "primMkObj"
  _mkObj :: JSString -> IO (JSPtr p)


getAttr :: String -> JSPtr p -> IO a
getAttr s p = _getAttr (stringToJSString s) p

foreign import prim "primGetAttr"
  _getAttr :: JSString -> JSPtr p -> IO a


setAttr :: String -> a -> JSPtr p -> IO (JSPtr p)
setAttr s a p = _setAttr (stringToJSString s) a p

foreign import prim "primSetAttr"
  _setAttr :: JSString -> a -> JSPtr p -> IO (JSPtr p)


modAttr :: String -> (a -> b) -> JSPtr p -> IO (JSPtr p)
modAttr s f p = _modAttr (stringToJSString s) f p

foreign import prim "primModAttr"
  _modAttr :: JSString -> (a -> b) -> JSPtr p -> IO (JSPtr p)


getProtoAttr :: String -> String -> IO a
getProtoAttr x y = _getProtoAttr (stringToJSString x) (stringToJSString y)

foreign import prim "primGetProtoAttr"
  _getProtoAttr :: JSString -> JSString -> IO a


setProtoAttr :: String -> a -> String -> IO ()
setProtoAttr x a y = _setProtoAttr (stringToJSString x) a (stringToJSString y)

foreign import prim "primSetProtoAttr"
  _setProtoAttr :: JSString -> a -> JSString -> IO ()


modProtoAttr :: String -> (a -> b) -> String -> IO ()
modProtoAttr x f y = _modProtoAttr (stringToJSString x) f (stringToJSString y)

foreign import prim "primModProtoAttr"
  _modProtoAttr :: JSString -> (a -> b) -> JSString -> IO ()


foreign import prim "primStringToPackedString"
  stringToJSString :: String -> JSString
