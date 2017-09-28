const express = require('express');
const router = express.Router();
const programController = require('../controller/programController');
//get home page 

router.get('/getprogram',programController.getprogram);
router.post('/saveprogram',programController.saveprogram);
module.exports =router;