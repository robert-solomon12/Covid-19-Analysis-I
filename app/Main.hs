module Main where

import System.Environment(getArgs)

import CleanData
import StatsReport
import CovidData

main :: IO ()
main = do
    (file:_) <- getArgs
    covidData <- readFile file

    let (highCS, lowCS, numDays) = computeAnalysis  (makeAllCovidData covidData) CovidCasesConfirmed
    putStrLn "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    putStrLn "Results:    | Average Covid Cases         | Highest no. cases            | Lowest no. cases          | Highest Median no. of cases           | Lowest Median no. of cases         |Total No. of Cases                        |"
    putStrLn "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

    putStrLn $  "Results:      |"  ++ show (avgCS $ makeAllCovidData covidData)  ++    "  |"  ++ show (covidCasesConfirmed highCS)  ++
           "   |" ++ show(covidCasesConfirmed lowCS) ++ "     |"  ++ show numDays ++ "    |  "  ++ show(totalNoCases $ makeAllCovidData covidData) 
  -- try to run a similar analysis on the Closing Data (and other numeric fields)