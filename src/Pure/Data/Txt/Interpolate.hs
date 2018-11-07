{-# LANGUAGE TemplateHaskell #-}
module Pure.Data.Txt.Interpolate (t,unindent) where

import qualified Pure.Data.Txt.Interpolate.Internal as I
import Pure.Data.Txt.Interpolate.Unindent

import Language.Haskell.TH.Quote (QuasiQuoter(..))

t :: QuasiQuoter
t = QuasiQuoter {
    quoteExp  = \t -> [|fromTxt $(quoteExp I.t t)|]
  , quotePat  = err "pattern"
  , quoteType = err "type"
  , quoteDec  = err "declaration"
  }
  where
    err name  = error ("Pure.Data.Txt.Interpolate.t: This QuasiQuoter can not be used as a " ++ name)