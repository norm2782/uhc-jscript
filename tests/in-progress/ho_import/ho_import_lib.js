foldjs = function(f, b, xs) {
	var res = b;
	for (x in xs) {
		res = f (x, res);
	}
	return res;
}
