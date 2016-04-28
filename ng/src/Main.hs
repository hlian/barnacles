{-# LANGUAGE NoImplicitPrelude, OverloadedStrings #-}

module Main where

import BasePrelude hiding (for_)
import Data.Text (Text)
import Lucid
import Models

data Comment =
  Comment { _commentID :: ID
          , _commentBody :: Text
          , _commentParentID :: ID
          , _commentStoryID :: ID
          }

-- (add-hook 'after-save-hook 'haskell-process-load-or-reload)

header :: Html ()
header =
  with nav_
    [class_ "typ-nav"]
    (do headerleft
        headerright)
  where
    headerleft =
      ul_ (do link "/" "Home"
              link "/hottest" "Spiciest"
              link "/comments" "Talk of the Town"
              link "/search" "Search")
    headerright =
      ul_ (do link "/threads" "Your Replies"
              link "/messages" "Your Messages"
              link "/settinsg" "hao (155)"
              link "/logout" "^D")
    link path text =
      li_ (with a_ [href_ path] text)

post :: Html () -> Html () -> Html ()
post title copy =
  do
    with div_ [class_ "typ-user-meta"] meta
    with header_ [class_ "typ-user-header"] (h2_ title)
    with main_ [class_ "typ-user-article"] copy
  where
    meta =
      ul_ (do li_ "hao 12 hours ago"
              li_ "edit . delete . flag"
              li_ "all quiet")

s :: Html ()
s = "commit ffea4ca34c05e229615b2e40a7b3839bd21e78f8\nAuthor: Doug Patti <douglas@fogcreek.com>\nDate:   Fri Jun 1 00:05:20 2012 +0400\n\n    Fix duplicate key for subscriptions test\n\ndiff --git a/unitTests/api_cards.coffee b/unitTests/api_cards.coffee\nindex 86d5..48807 100644\n--- a/unitTests/api_cards.coffee\n+++ b/unitTests/api_cards.coffee\n@@ -438,7 +438,7 @@ exports.tests =\n       ], next\n     , next\n\n-  subscriptions: (next) ->\n+  subscriptions2: (next) ->^M\n     date = new Date()\n"

posts :: Html ()
posts =
  with section_ [id_ "posts"] $ do
    article_ (post title0 copy0)
    article_ (post title1 copy1)
  where
    title0 = "Code rant: The Lava Layer Anti-Pattern"
    copy0 = do
      blockquote_ (p_ "TL:DR Successive, well intentioned, changes to architecture and technology throughout the lifetime of an application can lead to a fragmented and hard to maintain code base. Sometimes it is better to favour consistent legacy technology over fragmentation.")
      blockquote_ (p_ "short")
      p_ "In a way this describes the server codebase, though we haven’t been through massive leadership changes. What’s the right way to avoid this? It feels like a non-problem, but I also feel like I’d be foolish to dismiss it entirely."
      (pre_ . code_) s
    title1 = "here is a title"
    copy1 = do
      p_ "After a weekend of cabal and bundler hell, we’re now one square ahead on our journey toward a time-wasting, completely Haskellized Barnacles. One day Haskell will have amazing OpenSSL bindings, guys, but until then we have authd to do Rails' bonkers cookie authentication and decryption."
      p_ "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"

quickpost :: Html ()
quickpost =
  with section_ [id_ "quickpost", class_ "typ-quickpost"] $ do
    h2_ "Make a Barnacle"
    with p_ [class_ "typ-has-url"] $ do
      input_ [type_ "radio", id_ "no-url", name_ "has-url", value_ "0"]
      with label_ [for_ "no-url"] "No URL"
      input_ [type_ "radio", id_ "yes-url", name_ "has-url", value_ "1"]
      with label_ [for_ "yes-url"] "URL"
      input_ [type_ "url", id_ "url", name_ "url"]
    p_ $ do
      with label_ [for_ "url"] "Title"
      input_ [type_ "input", id_ "title", name_ "title", placeholder_ "Ask Barnacles: what's up?"]
    p_ $ do
      with label_ [for_ "story"] "Description"
      with textarea_ [placeholder_ "Tell us a story..."] ""

home :: Html ()
home =
  doctype_ <> with html_
    [class_ "typ-body"]
    (do head_ (do title_ "Barnacles"
                  css "css/css.css.css"
                  meta_ [charset_ "utf-8"])
        body_ (do header
                  quickpost
                  posts))
  where
    css path =
      link_ [rel_ "stylesheet", href_ path]

main :: IO ()
main =
  renderToFile "index.html" home
