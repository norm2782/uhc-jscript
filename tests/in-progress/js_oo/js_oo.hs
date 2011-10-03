module JSOO where

main :: IO ()
main = do
  putStrLn "JSOO<br />"
  putStrLn $ ppBook objBook objBook

data Book = Book {
     title   :: String
  ,  author  :: String
  ,  ppBook  :: Book -> String
}

objBook = Book {
     title   = "defaultTitle"
  ,  author  = "defaultAuthor"
  ,  ppBook  = (\(Book t a _) -> t ++ " by " ++ a)
}

-- foreign export jscript "%proto[Book]" objBook :: Book

{-

The above should generate something along the lines of

function Book() {
}

Book.prototype.title = "defaultTitle"
Book.prototype.title = "defaultAuthor"
Book.prototype.ppBook = function(b) {
  return (b.title + " by " + b.author);
}

-}


-- foreign export jscript "%obj[myBook]" objBook :: Book

{-

Similar to the above, this should generate something along the lines of

myBook = {
  title : "defaultTitle",
  author : "defaultAuthor",
  ppBook : function(b) {
    return (b.title + " by " + b.author);
  }
}

-}


