module Main where

import qualified Thermite as T
import qualified Thermite.Html as T
import qualified Thermite.Html.Elements as T
import qualified Thermite.Html.Attributes as A
import qualified Thermite.Action as T
import qualified Thermite.Events as T
import qualified Thermite.Types as T

import Debug.Trace

data Action = Increment | Decrement
type State = { counter :: Number }

initialState :: State
initialState = { counter: 0 }

render :: T.Render _ State _ Action
render context state _ _ =
  T.div' [counter, buttons]
  where
    counter :: T.Html _
    counter =
      T.p' [ T.text "Value: "
           , T.text (show state.counter)
           ]

    buttons :: T.Html _
    buttons = T.p' [ T.button (T.onClick context (const Increment)) [T.text "Increment"]
                   , T.button (T.onClick context (const Decrement)) [T.text "Decrement"]
                   ]

performAction :: T.PerformAction _ State _ Action
performAction _ Increment = T.modifyState \o -> { counter: o.counter + 1 }
performAction _ Decrement = T.modifyState \o -> { counter: o.counter - 1 }

spec :: T.Spec _ State _ Action
spec =
  T.simpleSpec initialState performAction render

main = do
  trace "Hello sailor!"
  T.render (T.createClass spec) {}
