main :: IO ()
main = do
  answ <- fldToN (f 3) 10
  putStrLn $ show answ

f :: Int -> Int -> Int -> Int
f n x xs = n + x + xs

fldToN :: (Int -> Int -> Int) -> Int -> IO Int
fldToN f n = return $ foldr f 0 [1..n]

foreign export jscript "fldToN"
  fldToN :: (Int -> Int -> Int) -> Int -> IO Int
