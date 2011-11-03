import Language.UHC.JScript.ECMA.String
import Language.UHC.JScript.Assorted
import Language.UHC.JScript.Primitives
import Language.UHC.JScript.JQuery.JQuery
import UHC.Ptr


foreign import jscript "some_function(%*)"
  someFun :: Int -> Int -> FunPtr (Int -> IO ()) -> IO ()

foreign import jscript "wrapper"
  wrap :: (Int -> IO ()) -> IO (FunPtr (Int -> IO ()))

myCB :: Int -> IO ()
myCB = alert . show

main :: IO ()
main = do
  putStrLn "data_export_wrapper"
  sf <- wrap myCB
  someFun 2 3 sf

{-

We now require all functions in an exported constructor to be wrapped in an
IO JSFunPtr construction. To enforce this, we need to modify the type-checker.
We then also need to implement wrapper support in the FFI and do lambda lifting
for lambda functions based on the wrappers


Why do we want to wrap functions in IO JSFunPtr?
Because otherwise a plain JS function would get a Haskell representation of a
function, i.e., a: new _A_(new _F_(...)) etc. Regular JS functions do not know
how to deal with these, so we need to wrap them in a regular JS function, which
takes as many arguments as the Haskell function. The Haskell function is then
applied to the arguments and the result is returned. This also explains the
name wrapper....
-}
