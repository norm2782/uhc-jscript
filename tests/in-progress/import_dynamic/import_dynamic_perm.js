function some_function(arg1, arg2, callback) {
  var num = Math.ceil(arg1 + arg2);
  var res = callback(num);
  return res;
}
