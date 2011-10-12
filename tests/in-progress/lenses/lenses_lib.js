function mkObj(nm) {
  if (typeof(document[nm]) !== 'function') {
    document[nm] = new Function();
  }
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
  obj[attr] = f.__evN__(obj[attr]);
  return obj;
}
