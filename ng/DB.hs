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
  M.query_ conn "select id, title, url, markeddown_description, upvotes from stories order by created_at desc limit 10;"

main :: IO ()
main =
  stories >>= print
