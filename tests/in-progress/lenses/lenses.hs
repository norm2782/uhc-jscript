data JSPtr a
type JSString = PackedString

data BookPtr

type Book = JSPtr BookPtr

foreign import prim "primStringToPackedString"
  s2js :: String -> JSString

pages :: JSString
pages = s2js "pages"

-- TODO: Do we need a mkProto as well?
mkBook :: IO Book
mkBook = mkObj $ s2js "Book"

getPages :: Book -> IO Int
getPages = getAttr pages

setPages :: Int -> Book -> IO Book
setPages = setAttr pages

modPages :: (Int -> Int) -> Book -> IO Book
modPages = modAttr pages


-- TODO: How do we deal with setting functions to be attributes on the objects?

main :: IO ()
main = do
  b  <- mkBook
  _  <- setPages 1 b
  a  <- getPages b
  b' <- modPages (+1) b
  c  <- getPages b'
  putStrLn $ "Before: " ++ show a
  putStrLn "<br />"
  putStrLn $ "After: " ++ show c

foreign import jscript "mkObj(%*)"
  mkObj :: JSString -> IO (JSPtr p)

foreign import jscript "getAttr(%*)"
  getAttr :: JSString -> JSPtr p -> IO a

foreign import jscript "setAttr(%*)"
  setAttr :: JSString -> a -> JSPtr p -> IO (JSPtr p)

foreign import jscript "modAttr(%*)"
  modAttr :: JSString -> (a -> b) -> JSPtr p -> IO (JSPtr p)

{-
JS code:

function mkObj(nm) {
  if (typeof(document[nm]) !== 'function') {
    document[nm] = new Function();
  }
  return new document[nm];
}

function getAttr(attr, obj) {
  return obj[attr];
}

function setAttr(attr, val, obj) {
  obj[attr] = val;
  return obj;
}

function modAttr(attr, f, obj) {
  // TODO: Is this the right way to apply a function from Haskell? Probably not...
  obj[attr] = f.__evN__(obj[attr]);
  return obj;
}

-}
