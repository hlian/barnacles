module Main where

import Data.Aeson (encode)
import Network.HTTP.Types (status200, status400)
import qualified Network.Wai as Wai
import qualified Network.Wai.Handler.Warp as Warp

import BasePrelude
import API
import Utils

port :: Warp.Port
port = 5678

invalidPathError :: Wai.Request -> APIError
invalidPathError request =
  APIError "Invalid path: $path" [("path", present (Wai.rawPathInfo request))]

application :: Wai.Application
application request respond =
  case Wai.pathInfo request of
   [] -> do
     ahome <- home
     respond (Wai.responseLBS status200 [] (encode ahome))
   _ ->
     respond (Wai.responseLBS status400 [] (encode (invalidPathError request)))

main :: IO ()
main =
  Warp.run port application
