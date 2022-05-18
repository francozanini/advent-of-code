{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_day01 (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/franco/.cabal/bin"
libdir     = "/home/franco/.cabal/lib/x86_64-linux-ghc-8.10.4/day01-0.1.0.0-inplace-day01"
dynlibdir  = "/home/franco/.cabal/lib/x86_64-linux-ghc-8.10.4"
datadir    = "/home/franco/.cabal/share/x86_64-linux-ghc-8.10.4/day01-0.1.0.0"
libexecdir = "/home/franco/.cabal/libexec/x86_64-linux-ghc-8.10.4/day01-0.1.0.0"
sysconfdir = "/home/franco/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "day01_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "day01_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "day01_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "day01_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "day01_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "day01_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
