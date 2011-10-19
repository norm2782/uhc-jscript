
import Language.UHC.JScript.Assorted
import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.Primitives
import Language.UHC.JScript.Types
import Language.UHC.JScript.JQuery.JQuery



main :: IO ()
main = return ()

-- Main function
foreign export jscript "jQueryMain"
  jQueryMain :: IO ()

jQueryMain :: IO ()
jQueryMain = do
  showAlert
  sayHi
  addNeat
  showNeat

-- Show an alert
foreign export jscript "showAlert"
  showAlert :: IO ()

showAlert :: IO ()
showAlert = alert "Hello, World!"

-- Set the contents for to the body element.
foreign export jscript "sayHi"
  sayHi :: IO ()

sayHi :: IO ()
sayHi = do
  j <- jQuery "body"
  setHTML j "Hi there!"

-- Add a (hidden) paragraph to the body element.
foreign export jscript "addNeat"
  addNeat :: IO ()

addNeat :: IO ()
addNeat = do
  j <- jQuery "body"
  h <- getHTML j
  setHTML j $ h ++ "<p class='neat'>"
                ++ "<strong>Congratulations!</strong> This awesome "
                ++ "jQuery script has been called by a function you have "
                ++ "written in Haskell!</p>"

-- Show the previously added paragraph using an animation.
foreign export jscript "showNeat"
  showNeat :: IO ()

showNeat :: IO ()
showNeat = do
  j <- jQuery "p.neat"
  addClass j  "ohmy"
  jqshow   j  (Just slow) Nothing Nothing
