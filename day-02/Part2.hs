module Part2 where

import Control.Monad
import System.IO
import Test.HUnit

executeCommands :: [String] -> (Int, Int)
executeCommands instructions = executeCommands' instructions 0

executeCommands' :: [String] -> Int -> (Int, Int)
executeCommands' [] _ = (0, 0)
executeCommands' (instruction : rest) aim
  | direction == "forward" = addTuples (intensity, aim * intensity) (executeCommands' rest aim)
  | direction == "down" = addTuples (0, 0) (executeCommands' rest (aim + intensity))
  | direction == "up" = addTuples (0, 0) (executeCommands' rest (aim - intensity))
  where
    intensity = read $ head $ tail $ words instruction :: Int
    direction = head $ words instruction
executeCommands' (instruction : rest) aim = addTuples (executeCommands' [instruction] aim) (executeCommands' rest aim)

addTuples :: (Int, Int) -> (Int, Int) -> (Int, Int)
addTuples (a, b) (x, y) = (a + x, b + y)

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

testExampleCase = TestCase (assertEqual "Example case" (15, 60) (executeCommands ["forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"]))

--- /                                                                               (5, 0) 0 | (5, 5) 5 | (13, 45) 5 | (13, 42) 2 | (13, 50) 10 | (15, )
tests = TestList [TestLabel "ExampleCase" testExampleCase]
