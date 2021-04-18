module Main where

import System.Environment(getArgs)

import CleanData
import StatsReport
import CovidData

main :: IO ()
main = do
    (file:_) <- getArgs
    covidData <- readFile file

    let (lowCS, highCS, numDays) = computeAnalysis  (makeAllCovidData covidData) CovidCasesConfirmed
    putStrLn "-------------------------------------------------------------------------------"
    putStrLn "Results:    | Average Covid Cases of entire period            | Highest no. cases of entire period            | Lowest no. cases of entire period            | Highest Median no. of cases of entire period           | Lowest Median no. of cases of entire period           | Highest Rolling '10 Day' of entire period Period           |"
    putStrLn "-------------------------------------------------------------------------------"

    putStrLn $  "Open       |" ++ show(covidCasesConfirmed lowCS) ++ "     |"  ++  show (covidCasesConfirmed highCS)  ++
           "   |"  ++ show (avgCS $ makeAllCovidData covidData)  ++    "   |"  ++show numDays 
  -- try to run a similar analysis on the Closing Data (and other numeric fields)