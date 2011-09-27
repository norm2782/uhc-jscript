{-# LANGUAGE TypeFamilies #-}

module Language.UHC.JScript.Types

class ToJS a where
  type ToRes a
  toJS :: a -> ToRes a

class FromJS a where
  type FromRes a
  fromJS :: a -> FromRes a
  -- Werkt niet in UHC, multiparam tyclasses wel

-- | The JSNArgs acts as a wrapper for specifying arguments to an imported JS
-- function in case an arbitrary number of arguments can be provided.
newtype JSNArgs a = JSNArgs [a]

-- TODO: Do we need some JSNArgs-like construction for exported functions? I
-- think we don't need it, since Haskell types are more strict than JS types
-- anyway.

-- TODO: Do we need some newtype to indicate function params? It seems a bit
-- redundant to me, since we already know that we're dealing with higher-order
-- functions from the type alone....
newtype JSFunArg a = JSFunArg a
