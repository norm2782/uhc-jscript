main = do
  putStrLn "data_export"
  putStrLn $ show myBook

data Book
  =  Book
  {  title   :: String
  ,  author  :: String
  }
  deriving Show

myBook = Book "story" "me"

foreign export jscript "myBookExp" myBook :: Book
