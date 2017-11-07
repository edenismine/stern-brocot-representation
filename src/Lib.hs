{-|
Module      : Lib
Description : Stern-Brocot Representation datatype with a Fraction converter and its inverse.
License     : Apache License 2.0
Maintainer  : daniel.aragon@ciencias.unam.mx

This module uses Fractions and Matrices to convert to and from the SBR datatype, an implementation of the
Stern Brocot Representation of positive rational numbers. Every provided example has been tested. Run
@stack test@ for further tests.
-}

module Lib(
    -- * Stern-Brocot Representation Type
      SBR
    -- ** Conversion functions
    , fracToSBR
    , sbrToFrac
    ) where

import           Data.Matrix
import           Fraction

data SBR = R SBR -- ^ R descent then SBR.
         | L SBR -- ^ L descent then SBR.
         | I     -- ^ I identity.
         deriving (Eq)

instance Show SBR where
    show sbr = case sbr of
        I      -> ""
        R sbr' -> 'R' : show sbr'
        L sbr' -> 'L' : show sbr'

instance Read SBR where
    readsPrec _ str = [(read' str, "")] where
        read' [] = I
        read' (x:xs) = case x of
            'R' -> R $ read' xs
            'L' -> L $ read' xs
            _   -> error "Invalid String"

-- |rSBTMatrix. Integral Matrix representation of a right descent on the
--  Stern-Brocot Tree.
rSBTMatrix :: Matrix Integer
rSBTMatrix = fromLists [[1, 1], [0, 1]]

-- |lSBTMatrix. Integral Matrix representation of a left descent on the
--  Stern-Brocot Tree.
lSBTMatrix :: Matrix Integer
lSBTMatrix = fromLists [[1, 0], [1, 1]]

-- |iSBTMatrix. Integral Matrix representation of Stern-Brocot Tree's root
--  (1//1).
iSBTMatrix :: Matrix Integer
iSBTMatrix = identity 2

-- |mediant. Calculates the mediant of two fractions.
mediant :: Fraction -> Fraction -> Fraction
mediant (x1:-:y1) (x2:-:y2) = (x1 + x2) :-: (y1 + y2)

-- |fracToSBR. Converts a positive Fraction into its Stern-Brocot Tree
--   representation (concatenated 'L's and 'R's wherein each correspond to a
--   left or right descent starting from the root 1//1).
--
--   Examples:
--       >> fracToSBR (1//1)
--       >>
--       >> fracToSBR (1//2)
--       >> L
fracToSBR :: Fraction -> SBR
fracToSBR = auxFracToLRStr (0 // 1) (1 // 0) where
    auxFracToLRStr start end target@(p:-:q)
        | p == 0 || q ==0  = error ("the Stern-Brocot Tree defines only"
            ++ " strictly positive ratios, and " ++ show target
            ++ " is not positive.")
        | med == target = I
        | med > target = L $ auxFracToLRStr start med target
        | med < target = R $ auxFracToLRStr med end target
        | otherwise = undefined
        where med = mediant start end

-- |sbrToFrac. Parses a positive Fraction from its Stern-Brocot representation.
--
--   Examples:
--       >> sbrToFrac I
--       >> 1
--       >> sbrToFrac (L I)
--       >> 1/2
sbrToFrac :: SBR -> Fraction
sbrToFrac = matrixToFraction . auxSBRToFrac where
    matrixToFraction m = (m ! (1, 1) + m ! (1, 2)) // (m ! (2, 1) + m ! (2, 2))
    auxSBRToFrac sbr = case sbr of
        I      -> iSBTMatrix
        L sbr' -> lSBTMatrix * auxSBRToFrac sbr'
        R sbr' -> rSBTMatrix * auxSBRToFrac sbr'
