module Language.UHC.JScript.JQuery.Deferred where

import Language.UHC.JScript.Prelude

import Language.UHC.JScript.Assorted (alert)

boundExecution :: IO a -> IO a -> Int -> (a -> IO b)  -> (a -> IO b) -> IO ()
boundExecution calc fallback timeout onCalc onFallback = do
  calc'       <- wrapIOa calc
  fallback'   <- wrapIOa fallback
  onCalc'     <- wrapaIOb onCalc
  onFallback'  <- wrapaIOb onFallback
  _boundExecution calc' fallback' timeout onCalc' onFallback'


foreign import jscript "boundExecution(%*)"
  _boundExecution :: JSFunPtr (IO a) -> JSFunPtr (IO a) -> Int -> JSFunPtr (a -> IO b) -> JSFunPtr (a -> IO b) -> IO ()
  
foreign import jscript "wrapper"
  wrapIOa :: IO a -> IO (JSFunPtr (IO a))
  
foreign import jscript "wrapper"
  wrapaIOb :: (a -> IO b) -> IO (JSFunPtr (a -> IO b))