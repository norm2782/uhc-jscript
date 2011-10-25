main :: IO ()
main = do
  putStrLn "var_ty_args"
  {- varTyArgs "Foo"-}
  varTyArgsStr "Bar"
  varTyArgsInt 123

{- foreign import jscript "varTyArgs(%*)" varTyArgs :: a -> IO ()-}
foreign import jscript "varTyArgs(%*)" varTyArgsStr :: String -> IO ()
foreign import jscript "varTyArgs(%*)" varTyArgsInt :: Int -> IO ()
