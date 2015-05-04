{-# LANGUAGE RecordWildCards #-}

module API where

import Data.Text (Text)
import Data.Aeson (ToJSON(..), object, (.=))

import BasePrelude
import DB
import Models
import Utils

data Home = Home {
    _homeAd :: Text
  , _homeIntro :: Text
  , _homeStories :: [Story]
}

newtype APIStory = APIStory Story
data APIError = APIError Text [(Text, Text)]

instance ToJSON APIStory where
  toJSON (APIStory story@Story{..}) =
    object [ "id" .= routeOfStory story
           , "title" .= _storyTitle
           , "url" .= _storyURL
           , "body" .= _storyBody
           , "whisks" .= _storyWhisks
           ]

instance ToJSON APIError where
  toJSON (APIError e params) =
    object [ "error" .= e
           , "params" .= object (uncurry (.=) <$> params)
           ]

instance ToJSON Home where
  toJSON Home{..} =
    object [ "ad" .= _homeAd
           , "intro" .= _homeIntro
           , "stories" .= (APIStory <$> _homeStories)
           ]

routeOfStory :: Story -> Text
routeOfStory Story{..} =
  "/story/" <> present _storyID

home :: IO Home
home = do
  _homeStories <- stories
  return Home {..}
  where
    _homeAd = "Basilica"
    _homeIntro = "Basilica is heart in hand and liver at sea."
