data JSPtr

type Book = JSPtr

pages = "pages"

getPages :: Book -> IO Int
getPages = getAttr pages

setPages :: Int -> Book -> IO Book
setPages = setAttr pages

modPages :: (Int -> Int) -> Book -> IO Book
modPages = modAttr pages

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

foreign import jscript "mkBook()"
  mkBook :: IO Book

foreign import jscript "getAttr(%*)"
  getAttr :: String -> JSPtr -> IO a

foreign import jscript "setAttr(%*)"
  setAttr :: String -> a -> JSPtr -> IO JSPtr

foreign import jscript "modAttr(%*)"
  modAttr :: String -> (a -> b) -> JSPtr -> IO JSPtr

