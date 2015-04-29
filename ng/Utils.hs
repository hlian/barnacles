module Utils where

import BasePrelude
import Data.Text (Text, pack)

present :: Show a => a -> Text
present = pack . show
