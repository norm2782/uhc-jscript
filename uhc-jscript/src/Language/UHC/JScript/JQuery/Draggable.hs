module Language.UHC.JScript.JQuery.Draggable where

import Language.UHC.JScript.ECMA.Bool

import Language.UHC.JScript.Primitives
import Language.UHC.JScript.Types
import Language.UHC.JScript.JQuery.JQuery

data Draggable = Draggable { scroll :: JSBool, containment    :: JSString,
                             revert :: JSBool, revertDuration :: Int,
                             scrollSensitivity :: Int,
                             start :: JUIEventHandler}

data JSDraggablePtr
type JSDraggable = JSPtr JSDraggablePtr

draggable :: JQuery -> Draggable -> IO ()
draggable jq drag =
  do jsdrag <- mkJSDraggable drag
     _draggable jq jsdrag
      
foreign import jscript "{}"
  mkJSDraggable :: Draggable -> IO JSDraggable

foreign import jscript "%1.draggable(%2)"
  _draggable :: JQuery -> JSDraggable -> IO ()
