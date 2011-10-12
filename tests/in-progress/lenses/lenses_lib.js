function mkObj(nm) {
  mkCtor(nm);
  return new document[nm];
}

function getAttr(attr, obj) {
  return obj[attr];
}

function setAttr(attr, val, obj) {
  obj[attr] = val;
  return obj;
}

function modAttr(attr, f, obj) {
  // TODO: Is this the right way to apply a function from Haskell? Probably not...
  setAttr(attr, f.__evN__(getAttr(attr, obj)), obj);
  return obj;
}



function mkCtor(nm) {
  if (typeof(document[nm]) !== 'function') {
    document[nm] = new Function();
  }
}



function getProtoAttr(attr, cls) {
  mkCtor(cls);
  return document[cls].prototype[attr];
}

function setProtoAttr(attr, val, cls) {
  mkCtor(cls);
  document[cls].prototype[attr] = val;
  return document[cls];
}

function modProtoAttr(attr, f, cls) {
  // TODO: Is this the right way to apply a function from Haskell? Probably not...
  setProtoAttr(attr, f.__evN__(getProtoAttr(attr, cls)), cls);
  return document[cls];
}
