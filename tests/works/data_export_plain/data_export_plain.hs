import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.Primitives
import Language.UHC.JScript.Assorted

{-

So this would be somewhat of a decent idea. The thing is, though, that we'd
still be doing runtime conversion. If we're going to be stuck with that anyway,
we might just as well just have a primitive JS function to do this for us. We'd
still need to wrap the functions in an object, though. Would we need some
facility to turn the datatype into an object first? I don't think so; we'd just
have to evaluate the datatype and then call primToPlainObj on it. In fact, we
might as well embed the evaluation in primToPlainObj and do the evaluation
inside. We would then import it with type `a -> JSPtr b`.

So, in short: the original object export approach won't be good enough. In
common usecases, one stores callbacks in an object. These callbacks need to
be of type JSFunPtr (...). The only way to obtain something of that type is
to wrap a function using a wrapper, which is a dynamic process. Converting a
Haskell datatype is therefor also defered to runtime. In fact, the entire
process is very similar to a function wrapper. One could call it an object
wrapper.
-}

main = do
  putStrLn "data_export"
  add' <- mkMath add
  bptr <- mkBook (myBook add')
  print $ getCount bptr
  myFun bptr

getCount :: JSBook -> Int
getCount = getAttr "count"

data BookPtr
type JSBook = JSPtr BookPtr

data Book
  =  Book
  {  title   :: JSString
  ,  author  :: JSString
  ,  count   :: Int
  ,  stuff   :: String
  ,  doMath  :: JSFunPtr (Int -> Int -> IO ())
  }

add :: Int -> Int -> IO ()
add x y = print $ y + x

-- TODO
-- The current problem is that we need to do something like this:
--
-- main = do
--   add' <- mkMath add
--   let b = myBook add'
--   ...
--   where myBook add' = Book "" "" 1 "" add'
--
-- but the current object export cannot deal with exporting functions. How
-- do we fix this?
--
-- Perhaps we need a mechanism similar to wrapper and dynamic, which
-- dynamically creates a plain object from a datatype:
--
-- foreign import jscript "{}" mkJSObj :: a -> JSPtr b
--
-- where `a` must be a data value. If so, we should remove it from the FEL
-- and parse it as a token instead. Though, that would require modifying
-- _every_ FFI backend. Lets leave it in the FEL anyway.
--
myBook f = Book (stringToJSString "story") (stringToJSString "me") 123 "foo" f


{- foreign export jscript "myBook" myBook :: Book-}
{- foreign export jscript "{myBook}" myBook :: Book-}
{- foreign import jscript "myBook()" myBookPtr :: JSBook-}
{- foreign import jscript "{myBook}" myBookPtr :: JSBook-}

mkBook :: Book -> IO JSBook
mkBook = mkObj

foreign import jscript "myFun(%1)"
  myFun :: JSBook -> IO ()

foreign import jscript "{}"
  mkObj :: a -> IO (JSPtr b)

foreign import jscript "wrapper"
  mkMath :: (Int -> Int -> IO ()) -> IO (JSFunPtr (Int -> Int -> IO ()))

