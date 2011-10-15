data JSPtr a
type JSString = PackedString

data BookPtr

type AnonObj = JSPtr ()
type Book = JSPtr BookPtr


pages :: JSString
pages = s2js "pages"

num :: JSString
num = s2js "num"


-- TODO: Do we need a mkProto as well?
mkBook :: IO Book
mkBook = mkObj $ s2js "Book"

getPages :: Book -> IO Int
getPages = getAttr pages

setPages :: Int -> Book -> IO Book
setPages = setAttr pages

modPages :: (Int -> Int) -> Book -> IO Book
modPages = modAttr pages


isAwesome :: Book -> IO Bool
isAwesome = getAttr $ s2js "isAwesome"


mkAnon :: IO AnonObj
mkAnon = mkAnonObj

getNum :: AnonObj -> IO Int
getNum = getAttr num

setNum :: Int -> AnonObj -> IO AnonObj
setNum = setAttr num

modNum :: (Int -> Int) -> AnonObj -> IO AnonObj
modNum = modAttr num


-- TODO: How do we deal with setting functions to be attributes on the objects?

main :: IO ()
main = do
  b  <- mkBook
  _  <- setPages 1 b
  a  <- getPages b
  b' <- modPages (+1) b
  c  <- getPages b'
  putStrLn $ "Book pages before: " ++ show a
  putStrLn "<br />"
  putStrLn $ "Book pages after: " ++ show c
  putStrLn "<br />"
  anon  <- mkAnon
  _     <- setNum 13 anon
  pgs'  <- getNum anon
  ano'  <- modNum (*2) anon
  pgs   <- getNum ano'
  putStrLn $ "Anon num before: " ++ show pgs'
  putStrLn "<br />"
  putStrLn $ "Anon num after: " ++ show pgs

foreign import prim "primMkAnonObj"
  mkAnonObj :: IO AnonObj

foreign import prim "primMkObj"
  mkObj :: JSString -> IO (JSPtr p)

foreign import prim "primGetAttr"
  getAttr :: JSString -> JSPtr p -> IO a

foreign import prim "primSetAttr"
  setAttr :: JSString -> a -> JSPtr p -> IO (JSPtr p)

foreign import prim "primModAttr"
  modAttr :: JSString -> (a -> b) -> JSPtr p -> IO (JSPtr p)


foreign import prim "primGetProtoAttr"
  getProtoAttr :: JSString -> JSString -> IO a

foreign import prim "primSetProtoAttr"
  setProtoAttr :: JSString -> a -> JSString -> IO ()

foreign import prim "primModProtoAttr"
  modProtoAttr :: JSString -> (a -> b) -> JSString -> IO ()


foreign import prim "primStringToPackedString"
  s2js :: String -> JSString
