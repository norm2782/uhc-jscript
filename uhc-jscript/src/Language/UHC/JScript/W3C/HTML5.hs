module Language.UHC.JScript.W3C.HTML5
  ( Document
  , documentAnchors
  , documentForms
  , documentImages
  , documentLinks
  , document
  , documentWriteln, documentWrite
  , documentGetElementById, documentGetElementsByName, documentGetElementsByTagName

  , Anchor
  , anchorCharset
  , anchorHref
  , anchorHreflang
  , anchorName
  , anchorRel
  , anchorRev
  , anchorTarget
  , anchorType

  , Form

  , Image

  , Link

  , Element
  , elementInnerHTML
  , elementTagName
  , elementClientWidth
  , elementClientHeight
  , elementAttributes

  , Attr
  , attrValue

  , NamedNodeMap
  , namedNodeMapLength
  , namedNodeMapItem
  , namedNodeMapNamedItem
  , namedNodeMapRemoveNamedItem
  , namedNodeMapSetNamedItem

  , Node
  , nodeName
  , nodeType

  , NodeList
  , nodeListItem
  , nodeListLength
  )
  where

import Language.UHC.JScript.ECMA.Array
import Language.UHC.JScript.ECMA.String

data Document

foreign import jscript "document"
  document :: IO Document

foreign import jscript "%1.anchors"
  documentAnchors :: Document -> JSArray Anchor

foreign import jscript "%1.forms"
  documentForms :: Document -> JSArray Form

foreign import jscript "%1.images"
  documentImages :: Document -> JSArray Image

foreign import jscript "%1.links"
  documentLinks :: Document -> JSArray Link

foreign import jscript "%1.write(%*)"
  documentWrite :: Document -> JSString -> IO ()

foreign import jscript "%1.writeln(%*)"
  documentWriteln :: Document -> JSString -> IO ()

foreign import jscript "%1.getElementById(%*)"
  documentGetElementById :: Document -> JSString -> IO Node

foreign import jscript "%1.getElementsByName(%*)"
  documentGetElementsByName :: Document -> JSString -> IO (NodeList Node)

foreign import jscript "%1.getElementsByTagName(%*)"
  documentGetElementsByTagName :: Document -> JSString -> IO (NodeList Node)

data Anchor

foreign import jscript "%1.charset"
  anchorCharset :: Anchor -> JSString

foreign import jscript "%1.href"
  anchorHref :: Anchor -> JSString

foreign import jscript "%1.hreflang"
  anchorHreflang :: Anchor -> JSString

foreign import jscript "%1.name"
  anchorName :: Anchor -> JSString

foreign import jscript "%1.rel"
  anchorRel :: Anchor -> JSString

foreign import jscript "%1.rev"
  anchorRev :: Anchor -> JSString

foreign import jscript "%1.target"
  anchorTarget :: Anchor -> JSString

foreign import jscript "%1.type"
  anchorType :: Anchor -> JSString

data Form

foreign import jscript "%1.elements"
  formElements :: Form -> JSArray Element

data Image

data Link

data Element

foreign import jscript "%1.innerHTML"
  elementInnerHTML :: Node -> JSString

foreign import jscript "%1.tagName"
  elementTagName :: Node -> JSString

foreign import jscript "%1.clientWidth"
  elementClientWidth :: Node -> Int

foreign import jscript "%1.clientHeight"
  elementClientHeight :: Node -> Int

foreign import jscript "%1.attributes"
  elementAttributes :: Node -> NamedNodeMap Node

data Node

foreign import jscript "%1.nodeName"
  nodeName :: Node -> JSString

foreign import jscript "%1.nodeType"
  nodeType :: Node -> Int

data NodeList x

foreign import jscript "%1.length"
  nodeListLength :: NodeList Node -> Int

foreign import jscript "%1[%2]"
  nodeListItem :: NodeList Node -> Int -> IO Node

data NamedNodeMap x

foreign import jscript "%1.length"
  namedNodeMapLength :: NamedNodeMap Node -> Int

foreign import jscript "%1[%2]"
  namedNodeMapItem :: NamedNodeMap Node -> Int -> IO Node

foreign import jscript "%1.getNamedItem(%*)"
  namedNodeMapNamedItem :: NamedNodeMap Node -> JSString -> IO Node

foreign import jscript "%1.removeNamedItem(%*)"
  namedNodeMapRemoveNamedItem :: NamedNodeMap Node -> JSString -> IO Node

foreign import jscript "%1.setNamedItem(%*)"
  namedNodeMapSetNamedItem :: NamedNodeMap Node -> Node -> IO Node

data Attr

foreign import jscript "%1.value"
  attrValue :: Attr -> JSString
