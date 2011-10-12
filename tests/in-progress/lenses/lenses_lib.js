// mkObj :: String -> JSPtr c
function mkObj(nm) {
  mkCtor(nm);
  return new document[nm];
}

// getAttr :: String -> JSPtr c -> a
function getAttr(attr, obj) {
  return obj[attr];
}

// setAttr :: String -> a -> JSPtr c -> JSPtr c
function setAttr(attr, val, obj) {
  obj[attr] = val;
  return obj;
}

// modAttr :: String -> (a -> b) -> JSPtr c -> JSPtr c
function modAttr(attr, f, obj) {
  setAttr(attr, _e_(new _A_(f, [getAttr(attr, obj)])), obj);
  return obj;
}


// mkCtor :: String -> ()
function mkCtor(nm) {
  if (typeof(document[nm]) !== 'function') {
    document[nm] = new Function();
  }
}


// getProtoAttr :: String -> String -> a
function getProtoAttr(attr, cls) {
  mkCtor(cls);
  return document[cls].prototype[attr];
}

// setProtoAttr :: String -> a -> String -> ()
function setProtoAttr(attr, val, cls) {
  mkCtor(cls);
  document[cls].prototype[attr] = val;
}

// modProtoAttr :: String -> (a -> b) -> String -> ()
function modProtoAttr(attr, f, cls) {
  setProtoAttr(attr, _e_(new _A_(f, [getProtoAttr(attr, cls)])), cls);
}
