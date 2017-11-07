module Main(main) where

import           Fraction
import           Lib
import           System.Environment

-- | main. reads the specified file 'f' and outputs to 'g'.
main :: IO()
main = do
    [fileIn, fileOut] <- getArgs
    s <- readFile fileIn
    let readFrac = mkFrac . map read . words
        mkFrac [x, y] = x // y
        mkFrac xys    = error (
            "no parse. "
            ++ show xys
            ++ "does not correspond to any positive Fraction.")
        in writeFile fileOut $ unlines . foldr ((:) . show . fracToSBR . readFrac) [] $ lines s
