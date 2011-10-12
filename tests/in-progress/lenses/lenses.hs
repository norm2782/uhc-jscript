data JSPtr

type Book = JSPtr

author = "author"

getAuthor = getL author

main :: IO ()
main = do
  b  <- mkBook
  _  <- setL author 1 b
  a  <- getL author b
  b' <- modL author incr b
  c  <- getAuthor b'
  putStrLn $ "Before: " ++ show (a :: Int)
  putStrLn "<br />"
  putStrLn $ "After: " ++ show (c :: Int)

-- FIXME: We're running into a typical JS issue here. We need to convert the
-- integers in the sum explicitly to numbers in the JS library, otherwise JS
-- just concats them as a string.
incr :: Int -> Int
incr = (+1)

foreign import jscript "mkBook()"
  mkBook :: IO Book

foreign import jscript "getL(%*)"
  getL :: String -> JSPtr -> IO a

foreign import jscript "setL(%*)"
  setL :: String -> a -> JSPtr -> IO JSPtr

foreign import jscript "modL(%*)"
  modL :: String -> (a -> b) -> JSPtr -> IO JSPtr

foreign export jscript "incr"
  incr :: Int -> Int
