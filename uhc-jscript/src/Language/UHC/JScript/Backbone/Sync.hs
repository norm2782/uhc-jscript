module Language.UHC.JScript.Backbone.Sync where

import Language.UHC.JScript.Backbone.Model
import Language.UHC.JScript.Primitives
import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.Types

sync :: String -> BBModel a -> IO ()
sync s = _sync (toJS s)

foreign import jscript "Backbone.sync(%*)"
  _sync :: JSString -> BBModel a -> IO ()

sync' :: String -> BBModel a -> AnonObj -> IO ()
sync' s = _sync' (toJS s)

foreign import jscript "Backbone.sync(%*)"
  _sync' :: JSString -> BBModel a -> AnonObj -> IO ()

-- TODO: emulateHTTP
-- TODO: emulateJSON
