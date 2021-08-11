{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE ViewPatterns #-}

module Parse
  ( parse
  ) where

import Build (Build,ConfigItem(..))
import Build (setFile,setPrefix,setSuffix,insert)
import Control.Applicative ((<|>))
import Control.Monad (forM)
import Data.Bifunctor (first)
import Data.List (stripPrefix)

parse :: String -> Either Int (Build ())
parse str = do
  stmts <- forM (zip [1..] (lines str)) $ \(i, line) ->
    case parseLine line of
      Nothing -> Left i
      Just stmt -> pure stmt
  pure $ foldr (>>) (pure ()) stmts

parseLine :: String -> Maybe (Build ())
parseLine (dropSpace -> str) = case str of
  "" -> Just $ insert Blank
  ('\'':_) -> parseInsert str
  ('#':_) -> parseComment str
  _ -> parseFile str <|> parseCircumfix str


parseInsert :: String -> Maybe (Build ())
parseInsert (dropSpace -> str) = do
  (input, dropSpace -> str') <- sqlString str
  (output, dropSpace -> str'') <- cString str'
  name <- case str'' of
    "" -> pure Nothing
    ('#': it) -> pure $ Just (dropSpaceR . dropSpace $ it)
    _ -> Nothing
  pure $ insert KeySeq{input,output,name}

parseComment :: String -> Maybe (Build ())
parseComment line = do
  let (length -> lvl, dropSpace -> str) = span (=='#') line
  case lvl of
    0 -> Nothing
    1 -> pure $ insert (Document $ dropSpaceR str)
    _ | lvl < 5 -> pure $ insert (Heading (lvl - 1) $ dropSpaceR str)
      | otherwise -> Nothing

parseFile :: String -> Maybe (Build ())
parseFile str = do
  path <- stripPrefix "======" str
  pure $ setFile (dropSpaceR . dropSpace $ path)

parseCircumfix :: String -> Maybe (Build ())
parseCircumfix str = do
  (dropSpace -> str') <- stripPrefix "=" str
  (prefix, dropSpace -> str'') <- sqlString str'
  (suffix, _) <- if null str'' then pure ("", "") else sqlString str''
  pure $ setPrefix prefix >> setSuffix suffix


dropSpace :: String -> String
dropSpace = dropWhile (==' ')
dropSpaceR :: String -> String
dropSpaceR = reverse . dropSpace . reverse

cString :: String -> Maybe (String, String)
cString ('\"':str) = loop str
  where
  loop "" = Nothing
  loop ('\"':rest) = Just ("", rest)
  loop (c:rest) = first (c:) <$> loop rest
cString _ = Nothing

sqlString :: String -> Maybe (String, String)
sqlString ('\'':str) = loop str
  where
  loop "" = Nothing
  loop ('\'':'\'':rest) = first ('\'':) <$> loop rest
  loop ('\'':rest) = Just ("", rest)
  loop (c:rest) = first (c:) <$> loop rest
sqlString _ = Nothing
