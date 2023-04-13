var express = require('express');
var router = express.Router();

/* GET home page. */
/**
 * param for now
 */
router.get('/', function(req, res, next) {
  // res.render('index', { title: 'Express' });
  const {param} = req.query;
  console.log(param);
  // right..
  res.send(param)
  // res.render('index', { param });
});

module.exports = router;
