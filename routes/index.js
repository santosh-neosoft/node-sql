const express = require('express');
const router = express.Router();
const IndexController = require('../controller/IndexController');
//get home page 

router.get('/',IndexController.homePage);
module.exports =router;