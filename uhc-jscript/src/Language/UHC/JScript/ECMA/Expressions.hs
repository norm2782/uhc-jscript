module Language.UHC.JScript.ECMA.Expressions where

foreign import jscript "typeof(%*)"
  typeof :: a -> JSString


