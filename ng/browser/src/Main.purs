module Main where

import Prelude
import Control.Monad.Eff
import Data.Maybe
import Data.Nullable

import qualified Thermite as T
import qualified Thermite.Action as T
import qualified React as R
import qualified React.DOM as R
import qualified React.DOM.Props as RP

import qualified DOM as DOM
import qualified DOM.HTML as DOM
import qualified DOM.HTML.Document as DOM
import qualified DOM.HTML.Types as DOM
import qualified DOM.HTML.Window as DOM
import qualified DOM.Node.Types as DOM

import Control.Monad.Eff.Console

data Action = Increment | Decrement
type State = { counter :: Int }

initialState :: State
initialState = { counter: 0 }

render :: T.Render _ State _ Action
render send s _ _ = R.div' [ counter, buttons ]
  where
  counter :: R.ReactElement
  counter =
    R.p'
      [ R.text "Value: "
      , R.text $ show s.counter
      ]

  buttons :: R.ReactElement
  buttons =
    R.p'
      [ R.button [ RP.onClick \_ -> send Increment ]
                 [ R.text "Increment" ]
      , R.button [ RP.onClick \_ -> send Decrement ]
                 [ R.text "Decrement" ]
      ]

performAction _ Increment = T.modifyState \o -> { counter: o.counter + 1 }
performAction _ Decrement = T.modifyState \o -> { counter: o.counter - 1 }

spec :: T.Spec _ State _ Action
spec =
  T.simpleSpec initialState performAction render

main = do
  print "Hello sailor!"
  body' <- body
  case R.render (R.createFactory (T.createClass spec) {}) <$> body' of
    Nothing -> print "nothing :("
    Just something -> void something

  where
  body :: forall eff. Eff (dom :: DOM.DOM | eff) (Maybe DOM.Element)
  body = do
    win <- DOM.window
    doc <- DOM.document win
    elm <- toMaybe <$> DOM.body doc
    return (DOM.htmlElementToElement <$> elm)
