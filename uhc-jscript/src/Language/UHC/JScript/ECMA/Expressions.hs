module Language.UHC.JScript.ECMA.Expressions where

import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.Types
import Language.UHC.JScript.Primitives

typeof :: a -> String
typeof = fromJS . _typeof

foreign import jscript "typeof(%*)"
  _typeof :: a -> JSString
