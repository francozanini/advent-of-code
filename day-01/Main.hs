module Main where

import System.IO
import Control.Monad

countDepthIncreases :: [Int] -> Int
countDepthIncreases [] = 0
countDepthIncreases [_x] = 0
countDepthIncreases (x : y : ys)
    | y > x = 1 + countDepthIncreases (y:ys)
    | otherwise = countDepthIncreases (y:ys)

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
