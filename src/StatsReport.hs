 module StatsReport where

import Data.List (sortOn)
import Data.Time (diffDays)
import CovidData

avgCS :: [CovidData] -> Double  -- average  opening values
avgCS all =  sum (map covidCasesConfirmed all)  / fromIntegral (length all)

totalNoCases :: [CovidData] -> Double  -- average  opening values
totalNoCases all =  sum (map covidCasesConfirmed all)

differences [] = []
differences xs = zipWith (-) (tail xs) (init xs)

computeAnalysis :: [CovidData] -> CField  -> (CovidData, CovidData, Int)
computeAnalysis   all onfield  = (lowCS, highCS, daysBetweenMinMax) where
                      get = field2fun onfield
                      sorted = sortOn get all
                      lowCS = head sorted
                      highCS = last sorted
                      daysBetweenMinMax = fromIntegral $ abs $ diffDays (statisticsProfileDate lowCS) (statisticsProfileDate highCS)
