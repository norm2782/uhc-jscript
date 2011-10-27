import Language.UHC.JScript.ECMA.String

main = do
  putStrLn "data_export"
  {- putStrLn $ show myBook-}

data BookPtr

data Book
  =  Book
  {  title   :: JSString
  ,  author  :: JSString
  }
  {- deriving Show-}

add :: Int -> Int -> Int
add x y = y + x

foreign export jscript "addFoo" add :: Int -> Int -> Int

myBook = Book (stringToJSString "story") (stringToJSString "me")

{- foreign export jscript "myBookExp" myBook :: Book-}
foreign export jscript "{myBookExp}" myBook :: Book
foreign import jscript "myBook" myBookPtr :: BookPtr

