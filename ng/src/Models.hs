module Models where

import           Data.Map ((!))
import qualified Data.Map as Map
import qualified Data.Text as Text
import           Database.MySQL.Base.Types (fieldName)
import           Database.MySQL.Simple.Result (convert)

import           Database.MySQL.Simple.QueryResults
import           P

data Story =
  Story { _storyID :: Integer
        , _storyTitle :: Text
        , _storyURL :: Maybe Text
        , _storyBody :: Text
        , _storyWhisks :: Integer
        }
  deriving (Show)

deriveToJSON (reasonableAesonOptions "_story") ''Story

ensure :: (a -> Bool) -> a -> Maybe a
ensure predicate x =
  if predicate x then Just x else Nothing

instance QueryResults Story where
  convertResults fields mbs = either (error . show) id $ do
    identifier <- k "id"
    title <- k "title"
    url <- ensure ((> 0) . Text.length) <$> k "url"
    body <- k "markeddown_description"
    whisks <- k "upvotes"
    return (Story identifier title url body whisks)
    where
      fieldsMap =
        Map.fromList (zip (fieldName <$> fields) fields)
      mbsMap =
        Map.fromList (zip (fieldName <$> fields) mbs)
      valueOf key =
        convert (fieldsMap ! key) (join $ mbsMap ^. at key)
      k key =
        maybe (Left ("No key found for " <> key)) Right (valueOf key)
