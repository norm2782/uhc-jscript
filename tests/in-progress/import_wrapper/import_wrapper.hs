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
myCB n = alert (show n)

main :: IO ()
main =
  putStrLn "data_export_wrapper"
  >>= \_  -> wrap myCB
  >>= \sf -> someFun 2 3 sf
{- main = do-}
  {- putStrLn "data_export_wrapper"-}
  {- sf <- wrap myCB-}
  {- someFun 2 3 sf-}

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


$import_wrapper.$wrap=
 new _F_("import_wrapper.wrap",function($__,$__2)
                               {trace(">$import_wrapper.$wrap"," <- "+$__+", "+$__2);
                                var $__3=
                                 _e_($__);
                                var $__4=
                                 _e_(function(vr1)
                                     {return _e_(new _A_($__3,[vr1]));});
                                var _=
                                 [$__2,$__4];
                                trace("<$import_wrapper.$wrap"," -> "+_);
                                return _;});


This is an example of the code that's generated for the wrap import. Would the
$__2 represent the IO monad? So in case our callback is in IO, we require the
callback function to be also applied to $__2, whereas we don't require this if
it's pure.


-}
