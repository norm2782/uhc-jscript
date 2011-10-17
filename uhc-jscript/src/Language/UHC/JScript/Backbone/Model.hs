module Language.UHC.JScript.Backbone.Model where

import Language.UHC.JScript.Primitives
import Language.UHC.JScript.Types


foreign import jscript "Backbone.Model.extend(%*)"
  extend :: JSFunPtr a -> IO (JSFunPtr b)


