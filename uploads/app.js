var express = require('express')
var bodyParser = require('body-parser')
var crypto = require('crypto')
var multer = require('multer')
var storage = multer.diskStorage({
	destination: function(req, file, cb){
		cb(null, 'public/uploads/')
	},
	filename: function(req, file, cb){
		crypto.pseudoRandomBytes(16, function (err, raw) {
      cb(null, raw.toString('hex') + Date.now() + '.jpg')
    });
	}
})

var upload = multer({storage: storage})

var app = express()
app.use(express.static('public'))


app.use(bodyParser.urlencoded({ extended: false }))

// parse application/json

app.use(bodyParser.json())

app.post('/', upload.single('picture'), function(req, res){
	if(req.file != undefined){
		var arg = "uploads/" + req.file.filename
		res.send(arg)
	} else {
		res.send("No files selected")
	}
})

app.listen(5000, function () {
  console.log('running on port 3000');
});