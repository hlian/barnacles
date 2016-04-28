module P (
  module X
  , Text
  , ByteString
  , Aeson.typeMismatch
  , reasonableAesonOptions
  , (.:=)) where

import           BasePrelude as X hiding (
  (&)
  , lazy
  , index
  , uncons
  , toList
  , traceEvent)
import           Control.Lens as X
import           Data.Aeson as X hiding ((.=))
import           Data.Aeson.TH as X
import           Data.ByteString (ByteString)
import           Data.Map.Strict as X (Map)
import           Data.Text (Text)
import           Data.Text.Strict.Lens as X
import           GHC.Exts as X hiding (lazy, Any)

import qualified Data.Aeson as Aeson
import qualified Data.Aeson.Types as Aeson
import qualified Data.Text as Text

(.:=) :: Aeson.ToJSON a => Text -> a -> Aeson.Pair
(.:=) =
  (Aeson..=)

reasonableAesonOptions :: Text -> Options
reasonableAesonOptions prefix =
  defaultOptions {
    fieldLabelModifier =
        view unpacked
      . Text.replace "iD" "id"
      . Text.replace "uRL" "url"
      . (ix 0 %~ toLower)
      . Text.drop (Text.length prefix)
      . view packed
  }
