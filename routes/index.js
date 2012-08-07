//GET home page.
exports.index = function(req, res){
  res.render('index', { title: 'Express' })
};

//Programs
exports.programs = function(req, res){
	var id = req.params.id;
	res.render('programs', { title: 'Express', layout: 'layout' });
};
