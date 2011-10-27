import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.Primitives

main = do
  putStrLn "data_export"
  let ptr = myBookPtr
  putStrLn $ show $ getCount ptr

getCount :: JSBook -> Int
getCount = getAttr "count"

data BookPtr
type JSBook = JSPtr BookPtr

data Book
  =  Book
  {  title   :: JSString
  ,  author  :: JSString
  ,  count   :: Int
  }
  {- deriving Show-}

add :: Int -> Int -> Int
add x y = y + x

foreign export jscript "addFoo" add :: Int -> Int -> Int

myBook = Book (stringToJSString "story") (stringToJSString "me") 123

{- foreign export jscript "myBook" myBook :: Book-}
foreign export jscript "{myBook}" myBook :: Book
foreign import jscript "myBook()" myBookPtr :: JSBook

