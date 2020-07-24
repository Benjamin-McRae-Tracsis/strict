{-# LANGUAGE CPP                   #-}
{-# LANGUAGE DeriveDataTypeable    #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE StandaloneDeriving    #-}

{-# OPTIONS_GHC -fno-warn-orphans #-}

-----------------------------------------------------------------------------
-- | Copyright :  (c) 2006-2007 Roman Leshchinskiy
--                (c) 2013 Simon Meier
-- License     :  BSD-style (see the file LICENSE)
--
-- Maintainer  :  Simon Meier <iridcode@gmail.com>
-- Stability   :  experimental
-- Portability :  GHC
--
-- The strict variant of the standard Haskell 'L.Either' type and the
-- corresponding variants of the functions from "Data.Either".
--
-- Note that the strict 'Either' type is not an applicative functor, and
-- therefore also no monad. The reasons are the same as the ones for the
-- strict @Maybe@ type, which are explained in "Data.Maybe.Strict".
--
-----------------------------------------------------------------------------
module Data.Either.Strict (
    Either(..)
  , isRight
  , isLeft
  , either
  , lefts
  , rights
  , partitionEithers
  , _Left
  , _Right
) where

import           Data.Strict.Classes (toStrict, toLazy)
import           Data.Strict.Either  (Either (..), either, isLeft,
                                      isRight, lefts, rights, partitionEithers)
import           Prelude             hiding (Either (..), either)

import           Data.Aeson          (FromJSON (..), ToJSON (..))


import Data.Strict.Lens (_Left, _Right)
import Test.QuickCheck.Instances.Strict ()

-- missing instances
--------------------

-- aeson
instance (ToJSON a, ToJSON b) => ToJSON (Either a b) where
  toJSON = toJSON . toLazy

instance (FromJSON a, FromJSON b) => FromJSON (Either a b) where
  parseJSON val = fmap toStrict (parseJSON val)
