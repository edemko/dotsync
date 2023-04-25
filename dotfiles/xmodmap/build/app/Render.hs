{-# LANGUAGE NamedFieldPuns #-}

module Render
  ( render
  ) where

import Data.Map.Strict (Map)
import Build(Config,ConfigItem(..))

import qualified Data.Map.Strict as Map


render :: Config -> Map FilePath String
render = renderKeys . Map.map renderValue
  where
  renderKeys = Map.mapKeysMonotonic (<>".xcompose")
  renderValue = unlines . map renderItem
  renderItem Blank = ""
  renderItem (Heading lvl str) = renderHeading lvl str
  renderItem (Document str) = "# " <> str
  renderItem KeySeq{input,output,name} =
    renderInput input <> ": " <> renderOutput output <> maybe "" (" # " <>) name

renderHeading :: Int -> String -> String
renderHeading 1 str =
  "### " <> str <> " ###"
renderHeading 2 str =
  "###### " <> str <> " ######\n"
renderHeading 3 str =
  let inner = "# " <> str <> " #"
      outer = replicate (length inner) '#'
   in unlines [outer, inner, outer]

renderOutput :: String -> String
renderOutput str = "\"" <> str <> "\""

renderInput :: String -> String
renderInput = loop
  where
  loop "" = ""
  loop [c] = angle (renderChar c)
  loop (c:rest) = angle (renderChar c) <> " " <> renderInput rest
  renderChar ' ' = "space"
  renderChar '!' = "exclam"
  renderChar '#' = "numbersign"
  renderChar '$' = "dollar"
  renderChar '%' = "percent"
  renderChar '&' = "ampersand"
  renderChar '(' = "parenleft"
  renderChar ')' = "parenright"
  renderChar '*' = "asterisk"
  renderChar '+' = "plus"
  renderChar ',' = "comma"
  renderChar '-' = "minus"
  renderChar '.' = "period"
  renderChar '/' = "slash"
  renderChar ':' = "colon"
  renderChar ';' = "semicolon"
  renderChar '<' = "less"
  renderChar '=' = "equal"
  renderChar '>' = "greater"
  renderChar '?' = "question"
  renderChar '@' = "at"
  renderChar '[' = "bracketleft"
  renderChar '\"' = "quotedbl"
  renderChar '\'' = "apostrophe"
  renderChar '\\' = "backslash"
  renderChar ']' = "bracketright"
  renderChar '^' = "asciicircum"
  renderChar '_' = "underscore"
  renderChar '`' = "grave"
  renderChar '{' = "braceleft"
  renderChar '|' = "bar"
  renderChar '}' = "braceright"
  renderChar '~' = "asciitilde"
  renderChar '⎄' = "Multi_key"
  renderChar c = [c]

angle :: String -> String
angle str = "<" <> str <> ">"
