{-# LANGUAGE TemplateHaskell #-}
module Pure.Data.Txt.Interpolate (i,unindent) where

import qualified Pure.Data.Txt.Interpolate.Internal as I
import Pure.Data.Txt.Interpolate.Unindent

import Language.Haskell.TH.Quote (QuasiQuoter(..))

i :: QuasiQuoter
i = QuasiQuoter {
    quoteExp  = \t -> [|fromTxt $(quoteExp I.i t)|]
  , quotePat  = err "pattern"
  , quoteType = err "type"
  , quoteDec  = err "declaration"
  }
  where
    err name  = error ("Pure.Data.Txt.Interpolate.i: This QuasiQuoter can not be used as a " ++ name)