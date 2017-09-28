
require('dotenv').config({path:'.env'});

exports.homePage = (req,res) =>{
    res.send('Welcome');
}