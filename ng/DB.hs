module DB where

import BasePrelude
import Models

import qualified Database.MySQL.Simple as M

connectInfo :: M.ConnectInfo
connectInfo =
  M.defaultConnectInfo { M.connectDatabase = "lobsters_dev" }

stories :: IO [Story]
stories = do
  conn <- M.connect connectInfo
  M.query_ conn "select id, title, url, markeddown_description as body, upvotes as whisks from stories"

main :: IO ()
main =
  stories >>= print
