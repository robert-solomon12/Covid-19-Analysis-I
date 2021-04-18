module CovidData where

import Data.Time (Day, parseTimeOrError, defaultTimeLocale, diffDays)
import CleanData

data CovidData = CovidData {  -- using the order that the csv file uses

        statisticsProfileDate :: Day,
        covidCasesConfirmed :: Double,
        requiringICUCovidCases :: Double,
        healthcareWorkersCovidCases :: Double,
        median_Age :: Double
      }
  deriving (Ord, Eq, Show)


data CField = CovidCasesConfirmed | RequiringICUCovidCases | HealthcareWorkersCovidCases | Median_Age
  deriving (Eq, Ord, Show, Enum, Bounded)



field2fun :: CField -> CovidData -> Double
field2fun CovidCasesConfirmed = covidCasesConfirmed
field2fun RequiringICUCovidCases = requiringICUCovidCases
field2fun HealthcareWorkersCovidCases = healthcareWorkersCovidCases
field2fun Median_Age = median_Age

makeDate :: String -> Day
makeDate  = parseTimeOrError True defaultTimeLocale "%Y/%m/%d"

--convert each of the strings to an appropriate type in form of tuple
strToTuple :: [String] -> (Day, Double, Double, Double, Double)
strToTuple (statisticsProfileDate:covidCasesConfirmed:requiringICUCovidCases:healthcareWorkersCovidCases:median_Age:_)  = 
-- strToTuple (:-:-:-:-:-:-:-:statisticsProfileDate:covidCasesConfirmed:-:-:-:-:-:-:-:-:-:-:-:-:requiringICUCovidCases:healthcareWorkersCovidCases:median_Age:_)  = 

               (makeDate statisticsProfileDate,
                read covidCasesConfirmed :: Double,
                read requiringICUCovidCases :: Double,
                read healthcareWorkersCovidCases :: Double,
                read median_Age :: Double)


tupleToCovidData :: (Day, Double, Double, Double, Double)  -> CovidData
tupleToCovidData (statisticsProfileDate, covidCasesConfirmed, requiringICUCovidCases, healthcareWorkersCovidCases, median_Age) = CovidData statisticsProfileDate covidCasesConfirmed requiringICUCovidCases healthcareWorkersCovidCases median_Age


makeAllCovidData :: String -> [CovidData]
makeAllCovidData csvData = map (tupleToCovidData . strToTuple) (getImportedData csvData)