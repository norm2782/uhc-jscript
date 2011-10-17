module Language.UHC.JScript.Backbone.Model where

import Language.UHC.JScript.ECMA.String

{-
data Model

-- Example custom model from Backbone documentation
data Note
data PrivateNode

-- TODO: We need some way to do object-oriented programming. We need to be able
-- to define a JS object and add methods to it.
-- What we did with jQuery was: use jQuery's global function $(selector) to
-- obtain a jQuery object and go from there. Is this possible with Backbone? It
-- would seem it is not. Another problem we have with backbone is that it
-- expects you to create custom classes, whereas jQuery just offers some API,
-- which you won't need to change at all.

-- TODO: How do you pass around (anonymous) objects? Actually, passing them
-- around isn't so much the issue. Creating them is. Would you create a new
-- datatype? Though, then you would have to re-import the extend function for
-- every custom class... maybe we should use a CPtr()-like construction?
--
-- The GHC JS backend does something like this:
-- data JSObject
-- data DOMElement = DOMElement { dePtr :: Ptr JSObject, deName :: String }
-- foreign import ccall "zdhszicons" -- $hs.cons
--   jscons :: CChar -> Ptr JSObject -> Ptr JSObject
-- foreign import ccall "zdhszinil" -- $hs.nil
--   jsnil :: Ptr JSObject
--
-- This is the C FFI way of dealing with pointers. In some way it makes sense.
-- After all, what more than a pointer to an object do you need? A newtype
-- could be used for added type-safety, like in the C FFI:
--
-- newtype DOMElementPtr = DOMElementPtr (Ptr JSObject)
-- data DOMElement = DOMElement { dePtr :: DOMElementPtr, deName :: String }

foreign import jscript "Backbone.Model.extend(%1)"
  extend :: Model -> IO Model

-- ... or would this be a case for dynamic/wrapper?
foreign import jscript "Backbone.Model.extend(%*)"
  mkNote :: Note -> IO Note

foreign import jscript "%1.extend(%*)"
  mkPrivateNote :: Note -> PrivateNode -> IO PrivateNode


-- So what if we would have access to the prototype somehow? Then we could just
-- tag on new functions... But how?

doFoo :: Int -> Int -> Int
doFoo x y = x + y


-- So we could do this. Would this be the same as
-- var Note = Backbone.Model.extend({doFoo: function(.....) { .... }}) 
-- ??
--
foreign export jscript "Note.attributes.doFoo"
  doFoo :: Int -> Int -> Int


-- Creating an instance of a predefined object could be quite naturally
-- represented by a datatype:

data Book = Book { title :: String, author :: String }

-- But how do we add methods to the a class?
-- Does it make sense to model it like this?
data Note = Note {
  allowedToEdit :: String -> Bool
}

-- Then we would make our own functions

amI str = False

-- And create an export

foreign export jscript "amI"
  amI :: String -> Bool

-- Though this is problematic, since there is now no way to associate this with
-- our new Note class. How does the GHC JS backend solve this?
--
-- Maybe a Map would be useful in this translation? Map String FunPtr or
-- something.
--
-}
{- data Book = Book { title :: String-}
                 {- , author :: String}-}

{- mkBook = return $ Book "" ""-}
{- setBookTitle book str = return $ book { title = str }-}
{- setBookAuthor book str = return $ book { author = str }-}

{- foreign export jscript "Book" mkBook :: IO Book-}

-- TODO: UHC doesn't understand the following two exports
-- TODO: Also, the functional world clashes with the OO world here. Would we
-- really need to define an export for setting each of our object properties?
-- TODO: How does the GHC C FFI deal with structs?
--
-- foreign export jscript "%1.prototype.title" setMyBookTitle :: IO String
-- foreign export jscript "%1.prototype.author" setBookAuthor :: Book -> String -> IO Book

-- Importing objects is probably rather straightforward and could follow the
-- conventions from the GHC C FFI:
--
-- http://www.haskell.org/haskellwiki/FFI_complete_examples#Reading_structs_in_Haskell

-- TODO: How do we access the "this" property (or any class property for that matter) inside a method?
{- foreign export jscript "%1.prototype.publish" setBookAuthor :: Book -> (Book -> IO ()) -> IO Book -- TODO: Can we have callbacks like this?-}

-- Could we circumvent all object-related problems by wrapping all those
-- operations in functions? Perhaps underscore could be of some use.
-- Alternatively, we could write some more custom JavaScript to deal with this.
-- We could then either hack something into the compiler to automagically help
-- us with this (I'm not sure how), or we could require a manual import
-- (possibly in the form of some library) of convenience functions to help us
-- deal with objects.
--
-- The latter option sounds like the simplest way out. Lets write some
-- Backbone-specific functions first and try to abstract from that later.
--
-- We could do this with a function like this:
--
-- function addPropertyToPrototype(obj, propName, propVal) {
--   obj.prototype[propName] = propVal;
--   return obj;
-- }
--
-- Then, when importing, we could give it a type like:
--
-- TODO: Here we see yet another need for a Ptr () type....
{- foreign import jscript "addPropertyToPrototype(%*)"-}
  {- addPropertyToPrototype :: JSObject -> String -> a -> JSObject-}

-- Now the question is, would this even work?
--
-- In the same way as above, we could have a somewhat more general function
-- to manipulate JS objects:
--
-- function setObjProp(obj, propName, propVal) {
--   obj[propName] = propVal;
--   return obj
-- }
--
-- function getObjProp(obj, propName) {
--   return obj[propName];
-- }
--
-- With this we could have
{- foreign import jscript "setObjProp(%*)"-}
  {- setObjProp :: JSObject -> String -> a -> IO JSObject-}

{- foreign import jscript "getObjProp(%*)"-}
  {- getObjProp :: JSObject -> String -> IO a-}
-- But how will `a' be interpreted? I suppose when reading, we will
-- still need to define specialized functions, which have the result type
-- fixed.
--
-- Would "wrapper" or "dynamic" make things nicer?
--
data Book

-- We need the next two lines, because JS requires a constructor function.
-- By exporting the constructor function we also guarantee that the compiler
-- doesn't get creative with the name.
bookCstr = ()
foreign export jscript "Book" bookCstr :: ()

-- Do we need to define constructors manually in JS? Or can we think of some
-- clever syntax  in the export declaration string?
--

mkBook :: IO Book
mkBook = _mkBook $ stringToJSString "Book"

foreign import jscript "createObj(%*)"
  _mkBook :: JSString -> IO Book

foreign import jscript "addPropertyToPrototype(%*)"
  addPropertyToPrototype :: Book -> JSString -> a -> IO Book

doStuffWithBook = do
  book <- mkBook
  addPropertyToPrototype book (stringToJSString "foo") (stringToJSString "bar")
  addPropertyToPrototype book (stringToJSString "baz") 33
  addPropertyToPrototype book (stringToJSString "bat") doCoolStuff
  return ()

doCoolStuff x y = x + y

-- function createObj(str) {
--   return eval("new " + str + "()");
-- }
--
-- function createObj2(str) {
--   return new this[str]();
-- }
--
-- function createObj3(str) {
--   return new window[str]();
-- }
--
-- function createObj4(str, scope) {
--   return new scope[str]();
-- }
--
-- Below does not work, but would be nice?:
-- function factory(clazz) {
--   var empty = {}
--   empty.prototype = clazz.prototype;
--   var obj = new empty();
--   return obj;
-- }

data Document
data Window

foreign import jscript "document" document :: IO Document
foreign import jscript "window" window :: IO Window
foreign import jscript "this" this :: IO a -- TODO: How do we model this?
