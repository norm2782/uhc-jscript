module Language.UHC.JScript.Backbone.Events where

import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.Backbone.Model
import Language.UHC.JScript.Primitives
import Language.UHC.JScript.Types

bind :: JSPtr a -> String -> JSFunPtr b -> IO ()
bind p s = _bind p (toJS s)

foreign import jscript "%1.bind(%*)"
  _bind :: JSPtr a -> JSString -> JSFunPtr b -> IO ()

bind' :: JSPtr a -> String -> JSFunPtr b -> JSPtr b -> IO ()
bind' p s c = _bind' p (toJS s) c

foreign import jscript "%1.bind(%*)"
  _bind' :: JSPtr a -> JSString -> JSFunPtr b -> JSPtr b -> IO ()


foreign import jscript "%1.unbind()"
  unbind :: JSPtr a -> IO ()


unbind' :: JSPtr a -> String -> IO ()
unbind' p s = _unbind' p (toJS s)

foreign import jscript "%1.unbind(%*)"
  _unbind' :: JSPtr a -> JSString -> IO ()

unbind'' :: JSPtr a -> String -> JSFunPtr b -> IO ()
unbind'' p s f = _unbind'' p (toJS s) f

foreign import jscript "%1.unbind(%*)"
  _unbind'' :: JSPtr a -> JSString -> JSFunPtr b -> IO ()


trigger :: JSPtr a -> String -> IO ()
trigger p s = _trigger p (toJS s)

foreign import jscript "%1.trigger(%*)"
  _trigger :: JSPtr a -> JSString -> IO ()

trigger' :: JSPtr a -> String -> AnonObj -> IO ()
trigger' p s o = _trigger' p (toJS s) o

foreign import jscript "%1.trigger(%*)"
  _trigger' :: JSPtr a -> JSString -> AnonObj -> IO ()
-- etc.
