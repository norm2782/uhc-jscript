main = do
  putStrLn "alert"
  alert 123


foreign import jscript "alert"
  alert :: Int -> IO ()
