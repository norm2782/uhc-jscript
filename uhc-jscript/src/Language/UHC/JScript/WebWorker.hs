module Language.UHC.JScript.WebWorker where

import Language.UHC.JScript.Prelude

data WebWorkerPtr
type WebWorker = JSPtr WebWorkerPtr  

newWorker :: String -> IO WebWorker
newWorker = _newWorker . toJS

foreign import jscript "newWorker(%1)"
  _newWorker :: JSString -> IO WebWorker

setOnMessage :: WebWorker -> (JSPtr a -> IO ()) -> IO ()
setOnMessage self f = do 
  f'   <- wrapJSPtraIO f
  setAttr "onmessage" f' self
  return ()
  
foreign import jscript "JSON.stringify(%1)"
  jsonStringify :: a -> JSString

foreign import jscript "JSON.parse(%1)"
  jsonParse :: JSString -> IO a

postMessage :: WebWorker -> a -> IO ()
postMessage =  _postMessage 
  
foreign import jscript "%1.postMessage(%2)"
  _postMessage :: WebWorker -> a -> IO ()
  
foreign import jscript "self"
  getSelf :: IO WebWorker