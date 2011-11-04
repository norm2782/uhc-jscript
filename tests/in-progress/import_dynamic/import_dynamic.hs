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

{-

Suppose we get some function: function(y) { return ... ; }

We then want to wrap it in:

$import_dynamic.$mkDyn =
  new _F_("import_dynamic.mkDyn", function($__, $__2) {
    var $__3 = _e_($__);
    var $__4 = new _F_("", function(vr1) {
      var $__5 = _e_(vr1);
      return [$__($__5), $__2];
    });
    return $__4;
  });

-}
