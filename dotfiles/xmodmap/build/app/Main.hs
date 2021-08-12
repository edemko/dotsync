{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators #-}

module Main where

import Build (runBuild,reset)
import Control.Monad (forM,forM_)
import Options.Generic (Generic)
import Options.Generic (ParseRecord,getRecord)
import Parse (parse)
import Render (render)
import System.Exit (exitFailure)
import System.FilePath ((</>))
import System.IO (hPutStrLn,stderr)

import qualified Data.Map.Strict as Map


data Options = Options
  { outDir :: FilePath
  , inFile :: [FilePath]
  }
  deriving (Generic)

instance ParseRecord Options


main :: IO ()
main = do
  opts <- getRecord "XCompose Builder"
  builders <- forM (inFile opts) $ \path -> do
    contents <- readFile path
    case parse contents of
      Right it -> pure $ it >> reset
      Left i -> die $ "syntax error line (" ++ show path ++ " line " ++ show i ++ ")"
  let builder = foldl (>>) (pure ()) builders
  config <- case runBuild builder of
    Left err -> die (show err)
    Right it -> pure it
  forM_ (Map.toList $ render config) $ \(path, contents) -> do
    writeFile (outDir opts </> path) contents

die :: String -> IO a
die msg = do
  hPutStrLn stderr msg
  exitFailure
