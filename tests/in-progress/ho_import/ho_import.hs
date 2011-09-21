main :: IO ()
main = do
  putStrLn "ho_import"
  let res = foldjs (*) 1 [1..10]
  putStrLn $ show res


foreign import jscript "foldjs(%*)" foldjs :: (a -> b -> b) -> b -> [a] -> b
