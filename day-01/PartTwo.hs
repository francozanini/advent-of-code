module PartTwo where

import System.IO
import Control.Monad
import Test.HUnit

countDepthIncreases :: [Int] -> Int
countDepthIncreases [] = 0
countDepthIncreases [_x] = 0
countDepthIncreases [_x, _y] = 0
countDepthIncreases (x:y:z:zs)
    | measure (y:z:zs) > (measure (x:y:z:[])) = 1 + countDepthIncreases (y:z:zs)
    | otherwise = countDepthIncreases (y:z:zs)

measure :: [Int] -> Int
measure [] = 0
measure [_x] = 0
measure [_x, _y] = 0
measure (x:y:z:zs) = x + y + z


main :: IO ()
main = do
    handle <- openFile "data.txt" ReadMode
    contents <- hGetContents handle
    let singlewords = words contents
    let result = countDepthIncreases $ f singlewords
    print result
    hClose handle

f :: [String] -> [Int]
f = map read

test1 = TestCase (assertEqual "example case" 5 (countDepthIncreases [199, 200, 208, 201, 200, 207, 240, 269, 260, 263]))

test2 = TestCase (assertEqual "returns 1" 1 (countDepthIncreases [1, 1, 1, 2]))

test3 = TestCase (assertEqual "returns 2" 0 (countDepthIncreases [2, 2, 2, 1, 1, 1]))

test4 = TestCase (assertEqual "base case" 0 (countDepthIncreases [1, 1, 1]))

test5 = TestCase (assertEqual "returns 2" 2 (countDepthIncreases [1, 1, 1, 2, 3, 0]))


tests = TestList [
    TestLabel "example case" test1,
    TestLabel "returns 1" test2,
    TestLabel "returns 2" test3,
    TestLabel "base case" test4,
    TestLabel "test 5" test5]

