import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.Primitives
import Language.UHC.JScript.JQuery.JQuery
import UHC.Ptr

{-

// define our function with the callback argument
function some_function(arg1, arg2, callback) {
	// this generates a random number between arg1 and arg2
	var my_number = Math.ceil(Math.random() * (arg1 - arg2) + arg2);
	// then we're done, so we'll call the callback and pass our result
	callback(my_number);
}
// call the function
some_function(5, 15, function(num) {
	// this anonymous function will run when the callback is called
	console.log("callback called! " + num);
});

-}

foreign import jscript "some_function(%*)"
  someFun :: Int -> Int -> FunPtr (Int -> IO ()) -> IO ()

foreign import jscript "wrapper"
  wrap :: (Int -> IO ()) -> IO (FunPtr (Int -> IO ()))


myCB :: Int -> IO ()
myCB = putStrLn . show


main :: IO ()
main = do
  putStrLn "data_export_wrapper"
  sf <- wrap myCB
  someFun 2 3 sf

{- getCount :: JSBook -> Int-}
{- getCount = getAttr "count"-}

{- data BookPtr-}
{- type JSBook = JSPtr BookPtr-}

{- data Book-}
  {- =  Book-}
  {- {  title   :: JSString-}
  {- ,  author  :: JSString-}
  {- ,  stuff   :: String-}
  {- ,  count   :: Int-}
  {- ,  makeTitle :: IO (JSFunPtr (JSString -> JSString))-}
  {- }-}

{- mkTitle :: JSString -> JSString-}
{- mkTitle str = str-}

{- foreign import jscript "wrapper"-}
  {- wrapMkTitle :: (JSString -> JSString) -> IO (JSFunPtr (JSString -> JSString))-}

{- myBook = Book  (stringToJSString "story") (stringToJSString "me") "foo" 123-}
               {- (wrapMkTitle mkTitle)-}

{- foreign export jscript "myBook" myBook :: Book-}
{- foreign export jscript "{myBook}" myBook :: Book-}
{- foreign import jscript "myBook()" myBookPtr :: JSBook-}
{- foreign import jscript "{myBook}" myBookPtr :: JSBook-}

{-

We now require all functions in an exported constructor to be wrapped in an
IO JSFunPtr construction. To enforce this, we need to modify the type-checker.
We then also need to implement wrapper support in the FFI and do lambda lifting
for lambda functions based on the wrappers


Why do we want to wrap functions in IO JSFunPtr?

-}
