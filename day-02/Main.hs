module Main where

import Control.Monad
import System.IO
import Test.HUnit

executeCommands :: [String] -> (Int, Int)
executeCommands [] = (0, 0)
executeCommands [instruction]
  | direction == "forward" = (intensity, 0)
  | direction == "down" = (0, intensity)
  | direction == "up" = (0, - intensity)
  where
    intensity = read $ head $ tail $ words instruction :: Int
    direction = head $ words instruction
executeCommands (instruction : rest) = addTuples (executeCommands [instruction]) (executeCommands rest)

addTuples :: (Int, Int) -> (Int, Int) -> (Int, Int)
addTuples a b = (fst a + fst b, snd a + snd b)

multiplyTuple :: (Int, Int) -> Int
multiplyTuple (a, b) = a * b

main :: IO ()
main = do
  handle <- openFile "input.txt" ReadMode
  contents <- hGetContents handle
  let singleLines = lines contents
  let coordinates = executeCommands singleLines
  print $ multiplyTuple coordinates
  hClose handle

------------------------------------TESTS------------------------------------

testBaseCase = TestCase (assertEqual "Base case" (0, 0) (executeCommands []))

testForward = TestCase (assertEqual "Forward" (5, 0) (executeCommands ["forward 5"]))

testDown = TestCase (assertEqual "Down" (0, 3) (executeCommands ["down 3"]))

testUp = TestCase (assertEqual "Up" (0, -3) (executeCommands ["up 3"]))

testForwardAndDown = TestCase (assertEqual "Forward&Down" (5, 3) (executeCommands ["forward 5", "down 3"]))

testExampleCase = TestCase (assertEqual "Example case" (15, 10) (executeCommands ["forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"]))

tests =
  TestList
    [ TestLabel "BaseCase" testBaseCase,
      TestLabel "Forward" testForward,
      TestLabel "Down" testDown,
      TestLabel "Up" testUp,
      TestLabel "FordwardAndDown" testForwardAndDown,
      TestLabel "ExampleCase" testExampleCase
    ]
