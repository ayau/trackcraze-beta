
/*
 * GET home page.
 */

exports.index = function(req, res){
  res.render('index', { title: 'Express' })
};



/*
 * GET program page.
 */

exports.program = function(req, res){
	var id = req.params.id;
	//console.log(id);
	//res.send('user ' + req.params.id);
	res.render('program', { title: 'Express', layout: 'layout' });
};