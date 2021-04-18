module Main where

import System.Environment(getArgs)

import CleanData
import StatsReport
import CovidData

main :: IO ()
main = do
    (file:_) <- getArgs
    CovidData <- readFile file

    let (highCS, lowCS) = computeCovidAnalysis  (makeAllCovidData covidData) CovidCasesConfirmed
    putStrLn "-------------------------------------------------------------------------------"
    putStrLn "Category   | Average Covid Cases of entire period            | Highest no. cases of entire period            | Lowest no. cases of entire period            | Highest Median no. of cases of entire period           | Lowest Median no. of cases of entire period           | Highest Rolling '10 Day' of entire period Period           |"
    putStrLn "-------------------------------------------------------------------------------"
    
  -- putStrLn $  "Open       |"  ++ show (avgCS $ makeAllCovidData covidData)  ++ "      
  
    putStrLn $     "Results     |"  ++ show(CovidCasesConfirmed highCS)   ++ "     |"  ++ show(CovidCasesConfirmed lowCS)   
  -- ++ " |" ++ show(open highMedCS)   ++ "  |" ++ show(open lowMedCS)   ++ "    |"  ++ show highRoll  
  -- try to run a similar analysis on the Closing Data (and other numeric fields)