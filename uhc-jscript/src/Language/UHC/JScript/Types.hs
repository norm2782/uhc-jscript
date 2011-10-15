{-# LANGUAGE MultiParamTypeClasses #-}

module Language.UHC.JScript.Types where

class ToJS a b where
  toJS :: a -> b

class FromJS a b where
  fromJS :: a -> b

mkIdxRes :: Int -> Maybe Int
mkIdxRes (-1) = Nothing
mkIdxRes n    = Just n
