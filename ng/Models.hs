module Models where

import BasePrelude
import Data.Map ((!))
import Database.MySQL.Simple.QueryResults

import Data.Text (Text)
import Database.MySQL.Base.Types (fieldName)
import Database.MySQL.Simple.Result (convert)

import qualified Data.Map as Map

newtype ID = ID Integer
             deriving (Show)

data Story =
  Story { _storyID :: ID
        , _storyTitle :: Text
        , _storyURL :: Maybe Text
        , _storyBody :: Text
        , _storyWhisks :: Integer
        }
  deriving (Show)

instance QueryResults Story where
  convertResults fields mbs = do
    either (error . show) id $ do
      url <- k "body"
      return $       Story
          <$> (ID <$> k "id")
          <*> k "title"
          <*> return url
          <*> k "body"
          <*> k "whisks"
    where
      fieldsMap =
        Map.fromList (zip (fieldName <$> fields) fields)
      mbsMap =
        Map.fromList (zip (fieldName <$> fields) mbs)
      valueOf key =
        convert (fieldsMap ! key) (join $ Map.lookup key mbsMap)
      k key =
        maybe (Left ("No key found for " <> key)) Right (valueOf key)
