{-# LANGUAGE MultiParamTypeClasses #-}

module Language.UHC.JScript.Types where

import Control.Monad



class JS a where
  
instance JS ()
instance JS Int


class ToJS a b where
  toJS :: a -> b

class FromJS a b where
  fromJS :: a -> b

fromJSM :: (Monad m, FromJS a b) => m a -> m b
fromJSM = liftM fromJS

mkIdxRes :: Int -> Maybe Int
mkIdxRes (-1)  = Nothing
mkIdxRes n     = Just n
