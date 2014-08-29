{-# LANGUAGE TemplateHaskell #-}
module Numeric.Limp.Canon.Program where

import Numeric.Limp.Canon.Linear
import Numeric.Limp.Canon.Constraint
import Numeric.Limp.Rep

import Data.Map (Map)
import qualified Data.Map as M
import Data.Set (Set)
import qualified Data.Set as S

data Program z r c
 = Program
   { _objective     :: Linear z r c
   , _constraints   :: Constraint z r c
   , _bounds        :: Map (Either z r) (Maybe (R c), Maybe (R c))
   }


varsOfProgram :: (Ord z, Ord r) => Program z r c -> Set (Either z r)
varsOfProgram p
 = S.unions
 [ varsOfLinear     $ _objective   p
 , varsOfConstraint $ _constraints p
 , M.keysSet        $ _bounds      p ]

