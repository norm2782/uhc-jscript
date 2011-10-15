module Language.UHC.JScript.JQuery.JQuery where

import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.Primitives
import Language.UHC.JScript.Types

data JQueryPtr
type JQuery = JSPtr JQueryPtr

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
-- Manipulation

getHTML :: JQuery -> IO String
getHTML jq = do
  s <- _getHTML jq
  return $ fromJS s

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

 -- Or return JQuery for chaining??? Does chaining even make sense?
foreign import jscript "%1.addClass(%2)"
  _addClass :: JQuery -> JSString -> IO ()



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

