#!/usr/bin/env runghc

main = do
    input <- map words . lines <$> getContents
    let output = latexianXcompose <$> input
    putStrLn $ unlines output

latexianXcompose [s, str] = "<Multi_key> <backslash> " ++ bloatChars str ++ {-" <space>" ++-} ": \"" ++ s ++ "\""
    where
    bloatChars cs = unwords $ (\c -> "<" ++ [c] ++ ">") <$> cs
