module Language.UHC.JScript.JQuery.JQuery where

import Language.UHC.JScript.ECMA.Array (JSArray)
import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.Primitives
import Language.UHC.JScript.Types

import Language.UHC.JScript.Assorted (alert)

data JQueryPtr
type JQuery = JSPtr JQueryPtr
type Selector = String
-------------------------------------------------------------------------------
-- jQuery Core

jQuery :: String -> IO JQuery
jQuery = _jQuery . toJS

jQuery' :: String -> JSPtr a -> IO JQuery
jQuery' s j = _jQuery' (toJS s) j

foreign import jscript "jQuery(%*)"
  _jQuery :: JSString -> IO JQuery

foreign import jscript "jQuery(%*)"
  _jQuery' :: JSString -> JSPtr a -> IO JQuery

foreign import jscript "jQuery(%*)"
  jQueryObj :: JSPtr a -> IO JQuery

foreign import jscript "jQuery()"
  jQuery_ :: IO JQuery


foreign import jscript "$.holdReady(%*)"
  holdReady :: Bool -> IO ()

foreign import jscript "$.noConflict()"
  noConflict :: IO ()

foreign import jscript "$.noConflict(%*)"
  noConflict' :: Bool -> IO ()

foreign import jscript "jQuery.sub()"
  sub :: IO JQuery

foreign import jscript "jQuery.when(%*)"
  when :: JSPtr a -> IO ()

foreign import jscript "jQuery.when(%*)"
  when' :: JSPtr a -> JSPtr a -> IO ()

foreign import jscript "jQuery.when(%*)"
  when'' :: JSPtr a -> JSPtr a -> JSPtr a -> IO ()

-------------------------------------------------------------------------------
-- Iteration

foreign import jscript "jQuery.makeArray(%1)"
  jQueryToArray :: JQuery -> IO (JSArray a)

foreign import jscript "%1.each(%2)"
  each :: JQuery -> JSFunPtr (Int -> JSPtr a -> IO ()) -> IO ()

foreign import jscript "jQuery.each(%*)"
  each' ::  b -> JSFunPtr (Int -> JSPtr a -> IO ()) -> IO ()
  

foreign import jscript "wrapper"
  mkEachIterator :: (Int -> JSPtr a -> IO ()) -> IO (JSFunPtr (Int -> JSPtr a -> IO ()))
  
-------------------------------------------------------------------------------
-- DOM

findSelector :: JQuery -> String -> IO JQuery
findSelector jq = findSelector' jq . toJS

foreign import jscript "%1.find(%2)"
  findSelector' :: JQuery -> JSString -> IO JQuery

foreign import jscript "%1.find(%2)"
  findObject :: JQuery -> JQuery -> IO JQuery

valString :: JQuery -> IO String
valString jq = valJSString jq >>= return . fromJS

foreign import jscript "%1.val()"  
  valJSString :: JQuery -> IO JSString


setValString :: JQuery -> String -> IO ()
setValString jq = _setValString jq . toJS

foreign import jscript "%1.val(%2)"
  _setValString :: JQuery -> JSString -> IO ()

-------------------------------------------------------------------------------
-- Manipulation

getHTML :: JQuery -> IO String
getHTML = fromJSM . _getHTML

foreign import jscript "%1.html()"
  _getHTML :: JQuery -> IO JSString


setHTML :: JQuery -> String -> IO ()
setHTML j s = _setHTML j (toJS s)


foreign import jscript "%1.html(%2)"
  _setHTML :: JQuery -> JSString -> IO ()
  
foreign import jscript "%1.hide()"
  hide :: JQuery -> IO ()

addClass :: JQuery -> String -> IO ()
addClass j s = _addClass j (toJS s)

wrapInner :: JQuery -> String -> IO ()
wrapInner j = _wrapInner j . toJS

foreign import jscript "%1.wrapInner(%2)"
  _wrapInner :: JQuery -> JSString -> IO ()

 -- Or return JQuery for chaining??? Does chaining even make sense?
foreign import jscript "%1.addClass(%2)"
  _addClass :: JQuery -> JSString -> IO ()
  
foreign import jscript "%1.remove()"
  remove :: JQuery -> IO ()

toggleClass :: JQuery -> String -> IO ()
toggleClass jq = _toggleClass jq . toJS

toggleClassString :: String -> String -> IO ()
toggleClassString sel c = jQuery sel >>= flip toggleClass c

foreign import jscript "%1.toggleClass(%2)"
  _toggleClass :: JQuery -> JSString -> IO ()
  
-- | One or more space-separated classes to be removed from the class attribute
--   of each matched element.
removeClass :: JQuery -> String -> IO ()
removeClass jq = _removeClass jq . toJS

removeClassString :: String -> String -> IO ()
removeClassString sel c = jQuery sel >>= flip removeClass c

foreign import jscript "%1.removeClass(%2)"
  _removeClass :: JQuery -> JSString -> IO ()


-------------------------------------------------------------------------------
-- Effects

fast, slow :: Int
fast = 200
slow = 600

--
-- The show() function
--
-- How can functions be passed? Which type should a callback function have?
-- Generally speaking, a callback functions as would be used in show here returns
-- void. What if we make callback functions return ()?
foreign import jscript "%1.show()"   jqshow0  :: JQuery -> IO ()
foreign import jscript "%1.show(%*)" jqshow1  :: JQuery -> Int -> IO ()
foreign import jscript "%1.show(%*)" jqshow2  :: JQuery -> Int -> JSString -> IO ()
foreign import jscript "%1.show(%*)" jqshow2' :: JQuery -> Int -> IO () -> IO ()
foreign import jscript "%1.show(%*)" jqshow3  :: JQuery -> Int -> JSString -> IO () -> IO ()

jqshow :: JQuery -> Maybe Int -> Maybe String -> Maybe (IO ()) -> IO ()
jqshow j Nothing  Nothing  Nothing  = jqshow0  j
jqshow j (Just n) Nothing  Nothing  = jqshow1  j n
jqshow j (Just n) (Just e) Nothing  = jqshow2  j n (toJS e)
jqshow j (Just n) Nothing  (Just c) = jqshow2' j n c
jqshow j (Just n) (Just e) (Just c) = jqshow3  j n (toJS e) c


foreign import jscript "%1.blur()"
  doBlur :: JQuery -> IO ()

-------------------------------------------------------------------------------
-- Events

data JUIPtr
type JUI = JSPtr JUIPtr

-- ToDo:  Probably the second arguments of the ThisEventHandlers and the first
--        of the EventHandlers should not be a general JQuery object but an
--        `eventObject'.
--        Also I probably should deprecate the versions without this as you'll
--        almost never have use of them...

type EventHandler        = JQuery -> JEventResult
type ThisEventHandler    = JQuery -> JQuery -> JEventResult 
type UIEventHandler      = JQuery -> JUI -> JEventResult -- TODO: Split this off to JQueryUI or something :)
type UIThisEventHandler  = JQuery -> JQuery -> JUI -> JEventResult 

type JEventResult        = IO Bool

type JEventHandler       = JSFunPtr EventHandler
type JThisEventHandler   = JSFunPtr ThisEventHandler
type JUIEventHandler     = JSFunPtr UIEventHandler
type JUIThisEventHandler = JSFunPtr UIThisEventHandler

data JEventType          = Blur | Change | Click | DoubleClick | Focus | FocusIn
                         | FocusOut | Hover | KeyDown  | KeyPress | KeyUp
                         | MouseDown | MouseEnter | MouseLeave | MouseMove
                         | MouseOut  | MouseOver  | MouseUp
                         | Ready | Resize | Scroll | Select | Submit
                         
instance Show JEventType where
  show Blur        = "blur"
  show Change      = "change"
  show Click       = "click"
  show DoubleClick = "dblclick"
  show Focus       = "focus"
  show FocusIn     = "focusin"
  show FocusOut    = "focusout"
  show Hover       = "hover"
  show KeyDown     = "keydown"
  show KeyPress    = "keypress"
  show KeyUp       = "keyup"
  show MouseDown   = "mousedown"
  show MouseEnter  = "mouseenter"
  show MouseLeave  = "mouseleave"
  show MouseMove   = "mousemove"
  show MouseOut    = "mouseout"
  show MouseOver   = "mouseover"
  show MouseUp     = "mouseup"
  show Ready       = "ready"
  show Resize      = "resize"
  show Scroll      = "scroll"
  show Select      = "select"
  show Submit      = "submit"

bind :: JQuery -> JEventType -> EventHandler -> IO ()
bind jq event eh = do handler <- mkJEventHandler eh
                      _bind jq ((toJS . show)event) handler

foreign import jscript "%1.bind(%*)"
  _bind :: JQuery -> JSString -> JEventHandler -> IO ()
  
registerEvents :: [(String, JEventType, EventHandler)] -> IO ()
registerEvents = mapM_ (\ (e, event, eh) -> do elem <- jQuery e
                                               unbind elem event
                                               bind elem event eh)
  
unbind :: JQuery -> JEventType -> IO ()
unbind jq = _unbind jq . toJS . show

foreign import jscript "%1.unbind(%*)"
  _unbind :: JQuery -> JSString -> IO ()


blur :: JQuery -> JEventHandler -> IO ()
blur = undefined


click :: JQuery -> EventHandler -> IO ()
click jq eh = mkJEventHandler eh >>= _click jq

foreign import jscript "%1.click(%2)"
  _click :: JQuery -> JEventHandler -> IO ()


keypress :: JQuery -> JEventHandler -> IO ()
keypress = undefined


onDocumentReady :: JSFunPtr (IO ()) -> IO ()
onDocumentReady f = _ready f

foreign import jscript "$('document').ready(%1)"
  _ready :: JSFunPtr (IO ()) -> IO ()
  
foreign import jscript "wrapper"
  mkJEventHandler :: EventHandler -> IO JEventHandler
    
  
foreign import jscript "wrapper"
  _mkJThisEventHandler :: ThisEventHandler -> IO JThisEventHandler
  
mkJThisEventHandler :: ThisEventHandler -> IO JThisEventHandler
mkJThisEventHandler f = 
  let g this jq = do  jQThis <- jQueryObj this :: IO JQuery
                      f jQThis jq
   in _mkJThisEventHandler g
  
foreign import jscript "wrappedThis(%1)"
  wrappedJQueryEvent :: JThisEventHandler -> IO JEventHandler
  
  
foreign import jscript "wrapper"
  mkJUIEventHandler :: UIEventHandler -> IO JUIEventHandler
 
 
mkJUIThisEventHandler :: UIThisEventHandler -> IO JUIThisEventHandler
mkJUIThisEventHandler f = 
  let g this jq ui = do  jQThis <- jQueryObj this :: IO JQuery
                         f jQThis jq ui
  in _mkJUIThisEventHandler g  
  
foreign import jscript "wrapper"
  _mkJUIThisEventHandler :: UIThisEventHandler -> IO JUIThisEventHandler
  
  
foreign import jscript "wrappedThis(%1)"
  wrappedJQueryUIEvent :: JUIThisEventHandler -> IO JUIEventHandler
  
-------------------------------------------------------------------------------
-- DOM Manipulation

append :: JQuery -> JQuery -> IO ()
append = _append

appendString :: JQuery -> String -> IO ()
appendString jq str = do jq' <- jQuery str
                         _append jq jq'

foreign import jscript "%1.append(%*)"
  _append :: JQuery -> JQuery -> IO ()

replaceWith :: JQuery -> JQuery -> IO ()
replaceWith = _replaceWith

foreign import jscript "%1.replaceWith(%2)"
  _replaceWith :: JQuery -> JQuery -> IO ()
  
replaceWithString :: JQuery -> String -> IO ()
replaceWithString jq s = jQuery s >>= replaceWith jq

-------------------------------------------------------------------------------
-- Dynamic loading

loadSrcFile :: String -> IO ()
loadSrcFile src = do let src' = toJS src :: JSString
                     scriptTag <- jQuery "<script>"
                     scriptTag' <- setAttr "src" src' scriptTag
                     body <- jQuery "body"
                     append body scriptTag'