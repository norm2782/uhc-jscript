import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.Assorted
import Language.UHC.JScript.Primitives
import Language.UHC.JScript.JQuery.JQuery
import UHC.Ptr


foreign import jscript "getJSFun(%1)"
  getJSFun :: Int -> FunPtr (Int -> Int)

foreign import jscript "dynamic"
  mkDyn :: FunPtr (Int -> Int) -> (Int -> Int)

main :: IO ()
main = do
  putStrLn "import_dynamic"
  let jfn = getJSFun 2
  let hfn = mkDyn jfn
  print $ hfn 3

