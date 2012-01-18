module Language.UHC.JScript.JQuery.Droppable where

import Language.UHC.JScript.Prelude
import Language.UHC.JScript.ECMA.Bool

import Language.UHC.JScript.Primitives
import Language.UHC.JScript.Types
import Language.UHC.JScript.JQuery.JQuery

data Droppable = Droppable { hoverClass :: JSString,
                             drop       :: JUIEventHandler}

data JSDroppablePtr
type JSDroppable = JSPtr JSDroppablePtr

droppable :: JQuery -> Droppable -> IO ()
droppable jq drop =
  do jsdrop <- mkJSDroppable drop
     _droppable jq jsdrop
      
foreign import jscript "{}"
  mkJSDroppable :: Droppable -> IO JSDroppable

foreign import jscript "%1.droppable(%2)"
  _droppable :: JQuery -> JSDroppable -> IO ()