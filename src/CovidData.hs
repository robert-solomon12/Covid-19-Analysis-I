
 module CovidData where

import Data.Time (Day, parseTimeOrError,  defaultTimeLocale, diffDays)
import CleanData

data CovidData = CovidData {   -- using the order that the csv file uses
                    statisticsProfileDate :: Day,
                    covidCasesConfirmed :: Double,
                    requiringICUCovidCases :: Double,
                    healthcareWorkersCovidCases :: Double,
                    aged1to4 :: Double,
                    aged5to14 :: Double,
                    aged15to24 :: Double,
                    aged25to34 :: Double,
                    aged35to44 :: Double,
                    aged45to54 :: Double,
                    aged55to64 :: Double,
                    aged65up :: Double,
                    median_Age :: Double
                 }
  deriving (Ord, Eq, Show)



data CField = CovidCasesConfirmed | RequiringICUCovidCases | HealthcareWorkersCovidCases | Aged1to4 | Aged5to14 | Aged15to24 | Aged25to34 | Aged35to44 | Aged45to54 | Aged55to64 | Aged65up | Median_Age
  deriving (Eq, Ord, Show, Enum, Bounded)

field2fun :: CField -> CovidData -> Double
field2fun CovidCasesConfirmed = covidCasesConfirmed
field2fun RequiringICUCovidCases = requiringICUCovidCases
field2fun HealthcareWorkersCovidCases = healthcareWorkersCovidCases
field2fun Aged1to4 =  aged1to4
field2fun Aged5to14 = aged5to14
field2fun Aged15to24 = aged15to24
field2fun Aged25to34 = aged25to34
field2fun Aged35to44 = aged35to44
field2fun Aged45to54 = aged45to54
field2fun Aged55to64 = aged55to64
field2fun Aged65up = aged65up
field2fun Median_Age = median_Age

makeDate :: String -> Day
makeDate  = parseTimeOrError True defaultTimeLocale "%Y/%m/%d"

--convert each of the strings to an appropriate type in form of tuple
strToTuple :: [String] -> (Day, Double, Double, Double, Double, Double, Double, Double, Double, Double, Double, Double, Double)
strToTuple (_:_:_:_:_:_:_:statisticsProfileDate:covidCasesConfirmed:_:requiringICUCovidCases:healthcareWorkersCovidCases:_:_:_:_:_:_:_:_:_:_:_:_:aged1to4:aged5to14:aged15to24:aged25to34:aged35to44:aged45to54:aged55to64:aged65up:median_Age:_)  = 
              (makeDate $ take 10 statisticsProfileDate,
              read covidCasesConfirmed :: Double,
              read requiringICUCovidCases :: Double,
              read healthcareWorkersCovidCases :: Double,
              read aged1to4 :: Double,
              read aged5to14 :: Double,
              read aged15to24 :: Double,
              read aged25to34 :: Double,
              read aged35to44 :: Double,
              read aged45to54 :: Double,
              read aged55to64 :: Double,
              read aged65up :: Double,
              read median_Age :: Double)


tupleToCovidData :: (Day, Double, Double, Double, Double, Double, Double, Double, Double, Double, Double, Double, Double)  -> CovidData
tupleToCovidData (statisticsProfileDate, covidCasesConfirmed, requiringICUCovidCases, healthcareWorkersCovidCases, aged1to4, aged5to14, aged15to24, aged25to34, aged35to44, aged45to54, aged55to64, aged65up, median_Age ) = CovidData statisticsProfileDate covidCasesConfirmed requiringICUCovidCases healthcareWorkersCovidCases aged1to4 aged5to14 aged15to24 aged25to34 aged35to44 aged45to54 aged55to64 aged65up median_Age


makeAllCovidData :: String -> [CovidData]
makeAllCovidData csvData = map (tupleToCovidData . strToTuple) (getImportedData csvData)