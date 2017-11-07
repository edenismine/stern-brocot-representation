module LibSpec (main, spec) where

import           Control.Monad
import           Fraction
import           Lib
import           Test.Hspec
import           Test.QuickCheck

instance Arbitrary Fraction where
    arbitrary = do
        Positive p <- arbitrary
        Positive q <- arbitrary
        return $ p // q

instance Arbitrary SBR where
    arbitrary = do
        frac <- arbitrary
        return $ fracToSBR frac

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
    describe "fracToSBR" $ it "is inverse to sbrToFrac" $ property $ \ x -> (fracToSBR . sbrToFrac) x == (x :: SBR)
    describe "sbrToFrac" $ it "is inverse to fracToSBR" $ property $ \ x -> (sbrToFrac . fracToSBR) x == (x :: Fraction)
