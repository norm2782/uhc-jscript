module Language.UHC.JScript.Backbone.History where

import Language.UHC.JScript.Primitives
import Language.UHC.JScript.Types

foreign import jscript "Backbone.history.start()"
  start :: IO ()

foreign import jscript "Backbone.history.start(%*)"
  start' :: AnonObj -> IO ()
