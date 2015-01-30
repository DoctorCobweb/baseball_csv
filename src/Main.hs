module Main where

import qualified Data.ByteString.Lazy as BL
import qualified Data.Vector as V
-- from cassava
import Data.Csv

-- a simple type alias for data
type BaseballStats = (BL.ByteString, Int, BL.ByteString, Int)

main :: IO ()
main = do
  csvData <- BL.readFile "batting.csv"
  let v = decode NoHeader csvData :: Either String (V.Vector BaseballStats)

  -- if csv decode works, then we will have a Right (V.Vector BaseballStats) value for
  -- Either. 
  -- in this case, fmap will be able to apply the function (V.foldr summer 0) to it.
  -- since v is a vector of BaseballStats the foldr can reduce the elements down using
  -- the starting value of 0 and the summer function.
  let summed = fmap (V.foldr summer 0) v
  putStrLn $ "Total atBats was: " ++ (show summed)
  where summer (name, year, team, atBats) n = n + atBats

