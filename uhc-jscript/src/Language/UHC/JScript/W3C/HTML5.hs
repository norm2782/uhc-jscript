module Language.UHC.JScript.W3C.HTML5
  ( Document
  , documentAnchors
  , documentForms
  , documentImages
  , documentLinks
  , document
  , documentWriteln, documentWrite
  , documentGetElementById, documentGetElementsByName, documentGetElementsByTagName
  , documentCreateElement

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
  , elementSetAttribute
  , elementAppendChild
  
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

import Language.UHC.JScript.Types

import Language.UHC.JScript.Primitives
import Language.UHC.JScript.ECMA.Array
import Language.UHC.JScript.ECMA.String

data DocumentPtr
type Document = JSPtr DocumentPtr

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

documentGetElementsByTagName :: Document -> String -> IO (NodeList Node)
documentGetElementsByTagName d = _documentGetElementsByTagName d . stringToJSString

foreign import jscript "%1.getElementsByTagName(%*)"
  _documentGetElementsByTagName :: Document -> JSString -> IO (NodeList Node)
  
documentCreateElement :: String -> IO Node
documentCreateElement elem = _documentCreateElement (stringToJSString elem :: JSString)
  
foreign import jscript "document.createElement(%*)"
  _documentCreateElement :: JSString -> IO Node

data AnchorPtr
type Anchor = JSPtr AnchorPtr

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

data FormPtr
type Form = JSPtr FormPtr

foreign import jscript "%1.elements"
  formElements :: Form -> JSArray Element

data ImagePtr
type Image = JSPtr ImagePtr

data LinkPtr
type Link  = JSPtr LinkPtr

data ElementPtr
type Element = JSPtr ElementPtr

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
  
elementSetAttribute :: Node -> String -> String -> IO ()
elementSetAttribute n k v = _elementSetAttribute n (stringToJSString k :: JSString) (stringToJSString v :: JSString)  
  
foreign import jscript "%1.setAttribute(%*)"
  _elementSetAttribute :: Node -> JSString -> JSString -> IO ()
  
foreign import jscript "%1.appendChild(%2)"
  elementAppendChild :: Node -> Node -> IO ()

data NodePtr
type Node = JSPtr NodePtr

foreign import jscript "%1.nodeName"
  nodeName :: Node -> JSString

foreign import jscript "%1.nodeType"
  nodeType :: Node -> Int

data NodeListPtr x
type NodeList x = JSPtr (NodeListPtr x)

foreign import jscript "%1.length"
  nodeListLength :: NodeList Node -> Int

foreign import jscript "%1[%2]"
  nodeListItem :: NodeList Node -> Int -> IO Node

data NamedNodeMapPtr x
type NamedNodeMap x    = JSPtr (NamedNodeMapPtr x)

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

data AttrPtr
type Attr    = JSPtr AttrPtr

foreign import jscript "%1.value"
  attrValue :: Attr -> JSString
