main :: IO ()
main = do
  putStrLn "JSOO<br />"
  let pl = plainDull 10 20
  putStrLn $ show objFish
  putStrLn $ ppBook objBook objBook

data Book = Book {
     title   :: String
  ,  author  :: String
  ,  ppBook  :: Book -> String
}

objBook = Book {
     title   = "defaultTitle"
  ,  author  = "defaultAuthor"
  ,  ppBook  = ppBook'
}

ppBook' :: Book -> String
ppBook' (Book t a _) = t ++ " by " ++ a

data NoConstrTy

plainDull, plainDull2 :: Int -> Int -> Int
plainDull x y = y + x
plainDull2 x y = y + x

secondMain :: IO ()
secondMain = putStrLn "secondMain"

foreign export jscript "plainDull" plainDull :: Int -> Int -> Int
foreign export jscript "plainDull2" plainDull2 :: Int -> Int -> Int
foreign export jscript "secondMain" secondMain :: IO ()

data Fish = Fish {
     species   :: String
  ,  gils  :: Bool
}
  | Fush Int Int Int Int Int
  deriving Show

objFish = Fish {
     species   = "shark"
  ,  gils  = True
}

foreign export jscript "Fish" objFish :: Fish
{- foreign export jscript "Book" objBook :: Book-}



-- TODO: it doesn't like the fact that ppBook is a function...
-- foreign export jscript "%proto[Book]" objBook :: Book
-- foreign export jscript "%obj[Book]" objBook :: Book


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


Especially this last setup would allow for friendly interaction with frameworks
like Backbone:

data BBBook

foreign import jscript "Backbone.Model.extend(%1)" :: Book -> IO BBBook


This would require the obj to be exported as well, though.

-}
