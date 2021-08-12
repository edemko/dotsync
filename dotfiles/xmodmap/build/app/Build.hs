{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE NamedFieldPuns #-}

module Build
  ( Config
  , ConfigFile
  , ConfigItem(..)
  -- * builder
  , Build
  , runBuild
  , setFile
  , setPrefix
  , setSuffix
  , reset
  , insert
  , Error(..)
  ) where

import Control.Monad (when)
import Data.List (isPrefixOf)
import Data.Map.Strict (Map)

import qualified Data.Map.Strict as Map


type Config = Map FilePath ConfigFile

type ConfigFile = [ConfigItem]

data ConfigItem
  = Blank
  | Heading Int String
  | Document String
  | KeySeq
    { input :: String
    , output :: String
    , name :: Maybe String
    }

reverseConfig :: Config -> Config
reverseConfig it = flip Map.map it $ \file -> reverse file


newtype Build a = Build { unBuild :: St -> Either Error (St, a) }
instance Functor Build where
  fmap f (Build go) = Build $ \st -> (fmap . fmap) f (go st)
instance Applicative Build where
  pure x = Build $ \st -> Right (st, x)
  (Build getF) <*> (Build getX) = Build $ \st -> case getF st of
    Right (st', f) -> case getX st' of
      Right (st'', x) -> Right (st'', f x)
      Left err -> Left err
    Left err -> Left err
instance Monad Build where
  (Build getX) >>= k = Build $ \st -> case getX st of
    Right (st', x) -> unBuild (k x) st'
    Left err -> Left err

data St = St
  { config :: Config
  , knownInputs :: [String]
  , curFile :: FilePath
  , curPrefix :: String
  , curSuffix :: String
  }
emptySt :: St
emptySt = St
  { config = Map.empty
  , knownInputs = []
  , curFile = ""
  , curPrefix = ""
  , curSuffix = ""
  }

data Error
  = SharedPrefixes [String]
  | FileNotSet
  deriving (Show)

runBuild :: Build a -> Either Error Config
runBuild action = reverseConfig . config . fst <$> unBuild action emptySt

reset :: Build ()
reset = do
  setFile ""
  setPrefix ""
  setSuffix ""

setFile :: FilePath -> Build ()
setFile path = Build $ \st ->
  Right (st{curFile = path}, ())

setPrefix :: String -> Build ()
setPrefix str = Build $ \st -> Right (st{curPrefix = str}, ())

setSuffix :: String -> Build ()
setSuffix str = Build $ \st -> Right (st{curSuffix = str}, ())

insert :: ConfigItem -> Build ()
insert item = Build $ \st -> do
  when (null $ curFile st) $ Left FileNotSet
  file <- pure $ case Map.lookup (curFile st) (config st) of
    Nothing -> []
    Just it -> it
  st' <- case item of
    KeySeq{input} -> do
      let input' = curPrefix st <> input <> curSuffix st
      () <- case prefixSharing input' (knownInputs st) of
        [] -> pure ()
        xs -> Left $ SharedPrefixes xs
      let item' = item{input = input'}
          file' = item' : file
          config' = Map.insert (curFile st) file' (config st)
          knownInputs' = input' : knownInputs st
      pure st{config = config', knownInputs = knownInputs'}
    _ -> do
      let file' = item : file
          config' = Map.insert (curFile st) file' (config st)
      pure st{config = config'}
  pure (st', ())

prefixSharing :: String -> [String] -> [String]
prefixSharing new old =
  let newIsPrefixOf = filter (new `isPrefixOf`) old
      oldIsPrefixOf = filter (`isPrefixOf` new) old
   in newIsPrefixOf <> oldIsPrefixOf
