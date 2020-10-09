{-# LANGUAGE OverloadedStrings #-}
module Pure.Data.Txt.Interpolate.Unindent (unindent) where

import Pure.Data.Txt as Txt

import Data.Char
import qualified Data.List as List

unindent :: Txt -> Txt
unindent = Txt.concat . removeIndentation . trimLastLine . removeLeadingEmptyLine . lines_

isEmptyLine :: Txt -> Bool
isEmptyLine = Txt.all isSpace

lines_ :: Txt -> [Txt]
lines_ s =
  if Txt.null s
  then []
  else
    case Txt.span (/= '\n') s of
      (first, rest) ->
        case Txt.uncons rest of
          Just ('\n', more) -> (first <> "\n") : lines_ more
          _ -> first : lines_ rest

removeLeadingEmptyLine :: [Txt] -> [Txt]
removeLeadingEmptyLine xs = case xs of
  y:ys | isEmptyLine y -> ys
  _ -> xs

trimLastLine :: [Txt] -> [Txt]
trimLastLine (a : b : r) = a : trimLastLine (b : r)
trimLastLine [a] = if Txt.all (== ' ') a
  then []
  else [a]
trimLastLine [] = []

removeIndentation :: [Txt] -> [Txt]
removeIndentation ys = List.map (dropSpaces indentation) ys
  where
    dropSpaces 0 s = s
    dropSpaces n s =
      case Txt.uncons s of
        Just (' ',r) -> dropSpaces (n - 1) r
        _ -> s

    indentation = minimalIndentation ys

    minimalIndentation =
        safeMinimum 0
      . List.map (Txt.length . Txt.takeWhile (== ' '))
      . removeEmptyLines

    removeEmptyLines = List.filter (not . isEmptyLine)

    safeMinimum :: Ord a => a -> [a] -> a
    safeMinimum x xs = case xs of
      [] -> x
      _ -> List.minimum xs
