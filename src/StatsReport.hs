module StatsReport where

import Data.List (sortOn)
import Data.Time (diffDays)
import CovidData



avgCS :: [CovidData] -> Double  -- average covid data values
avgCS all =  sum (map covidCasesConfirmed all)  / fromIntegral (length all) -- getting the average of covidCasesConfirmed 



computeAnalysis :: [CovidData] -> CField  -> (CovidData, CovidData, Double)
computeAnalysis  all onfield  = (highCS, lowCS, daysBetweenMinMax) where -- highMedCS, lowMedCS, highRoll) where
                      get = field2fun onfield
                      sorted = sortOn get all
                      highCS = head sorted 
                      lowCS = last sorted
                      daysBetweenMinMax = fromIntegral $ abs $ diffDays (statisticsProfileDate lowCS) (statisticsProfileDate highCS)