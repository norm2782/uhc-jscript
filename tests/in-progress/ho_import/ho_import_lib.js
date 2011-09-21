foldjs = function(f, b, xs) {
	var res = b;
	for (var x in xs) {
		res = f (x, res);
	}
	return res;
}
