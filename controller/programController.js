const connection = require('../config/database.js');


exports.getprogram = (req,res) =>{
    var client = req.query.client == undefined? "" : req.query.client;
    var language = req.query.language == undefined? "" : req.query.language;
    var version = req.query.version == undefined? "" : req.query.version;
    var app = req.query.app == undefined? "" : req.query.app;
    var outputObj ={};
    outputObj.Language = "";
    outputObj.category = [];
    outputObj.name = [];
    outputObj.desc = [];
    outputObj.program = [];
    outputObj.output = [];
    outputObj.input = [];
    outputObj.runnable = [];

    var rowQuery = "SELECT * FROM Language "+ 
                    "INNER JOIN Program_Details "+
                    "ON Language.id = Program_Details.lang_id "+
                    "where Language.lang_name = '"+language+"'"; 
    if(client != "" && language != ""){
        getMasterDetails(rowQuery).then(function(results){
            console.log(results);
            if(results.lang_id != undefined){
                outputObj.language = language;
            }
            results.forEach(function(element , index){

              outputObj.program.push(element.code)
              outputObj.input.push(element.code);
              outputObj.output.push(element.exampleoutput);
              outputObj.runnable.push(element.isrunnable);
          });
          
          if(results.length > 0){
            return results[0].prog_id;
          }else{
              return results;
          }
        }).then(function(programIds){
            return getProgramDetails(programIds); 
        }).then(function(ProgramCat_details){
            ProgramCat_details.forEach(function(element,index){
                outputObj.name.push(element.program_name);
                outputObj.desc.push(element.program_description);
                outputObj.category.push(element.cat_name);
            });
            return ProgramCat_details;
        }).then(function(data){
            let stmt = `INSERT INTO requestlog(versionno,client,appname,language,timestamp)
            VALUES(?,?,?,?,?)`;
            let values = [version,client,app,language,new Date()];
            return saveRequestlog(stmt ,values );
        }).then(function(){
            connection.end();
            res.json({'data':outputObj,'Message':'SUCCESS','Reason':''});
        }).catch(function(err){
            return res.json({"data":[],"Message": "FAILURE","Reason": err.message})
        })
    }else{
        res.json({"data":[],"Message": "FAILURE","Reason": "Either client or language is not defined in the parameter"})
    }
    
   
    
}
function saveRequestlog(stat,values){
    return new Promise(function(resolve,reject){
        connection.query(stat,values, function (err, results, fields) {
            if (err) {
                console.error(err.message);
                reject(err);
              }
             console.log('requestlog saved'); 
            resolve(results);
          });
    });
}
function getMasterDetails(rowQuery){
    return new Promise(function(resolve,reject){
        connection.query(rowQuery, function (err, results, fields) {
            if (err) {
                console.error(err.message);
                reject(err);
              }
            resolve(results);
          });
    });
}
function getProgramDetails(programId){
    var rowQuery = "SELECT * FROM program "+ 
                    "INNER JOIN category "+
                    "ON program.program_category = category.id "+
                    "where program.program_category = '"+programId+"'";     
    return new Promise(function(resolve,reject){
        connection.query(rowQuery, function (err, results, fields) {
            if (err) {
                console.error(err.message);
                reject(err);
              }
            resolve(results);
          });
    });
}
exports.saveprogram = (req,res) => {
    
    
    var program_name             = req.body.program_name == undefined? "" :req.body.program_name;
    var program_description      = req.body.program_description == undefined? "" : req.body.program_description;
    var cat_name                 = req.body.cat_name == undefined? "" : req.body.cat_name;
    var description_image_base64 = req.body.description_image_base64 == undefined? "" : req.body.description_image_base64;
    var description_image_url    = req.body.description_image_url == undefined? "" : req.body.description_image_url;
    var code                     = req.body.code == undefined? "" : req.body.code;
    var exampleoutput            = req.body.exampleoutput == undefined? "" : req.body.exampleoutput;
    var difficultylevel           = req.body.difficultylevel == undefined? "" : req.body.difficultylevel;
    var input                    = req.body.input == undefined? "" : req.body.input;
    var output                   = req.body.output == undefined? "" : req.body.output;
    var isrunnable               = req.body.isrunnable == undefined? "":req.body.isrunnable;    
    if(program_name != "" && cat_name != "" && code != ""){
        let id = Math.floor(Math.random()*(999-100+1)+100); // As category table has not assgied auto-increment so created random rumber function
        let category_sequence = 4;
        let featureId = 2;
        let stat = "INSERT INTO category(id,cat_name,category_sequence,featureid) VALUES (?,?,?,?)";
        let values = [id,cat_name,category_sequence,featureId];
        saveRow(stat,values,"Category").then(function(results){
           
            let Pid = Math.floor(Math.random()*(999-100+1)+100); // As program table has not assgied auto-increment so created random rumber function
            let program_category = id;
            let stat = "INSERT INTO program(id,program_name,program_description,program_category,description_image_base64,description_image_url) VALUES (?,?,?,?,?,?)";
            let values = [Pid,program_name,program_description,program_category,description_image_base64,description_image_url];
            saveRow(stat,values,"Program");
            return SelectQuery("program");
        }).then(function(programDetails){
            
            let Pdid = Math.floor(Math.random()*(999-100+1)+100); // As program_details table has not assgied auto-increment so created random rumber function
            let lang_id = 4;
            let prog_id = programDetails[0].id;
            let codewithoutcomments = "No Comments";
            let codewithoutlogic = "yes";
            let exampleoutputtype = "";
            let runnable = (isrunnable == true? "Y":"N");
            let stat = "INSERT INTO Program_Details(id,lang_id,prog_id,code,exampleoutput,difficultylevel,isrunnable) VALUES (?,?,?,?,?,?,?)";
            let values = [Pdid,lang_id,prog_id,code,exampleoutput,difficultylevel,runnable];
            saveRow(stat,values,"Program_Details");
            return SelectQuery("Program_Details");
        }).then(function(program_io){
            let Pioid = Math.floor(Math.random()*(999-100+1)+100); // As program_io table has not assgied auto-increment so created random rumber function
            let prog_id = program_io[0].id;
            let stat = "INSERT INTO program_io(id,prog_id,input,output) VALUES (?,?,?,?)";
            let values = [Pioid,prog_id,input,output];
            return saveRow(stat,values,"program_io");
        }).then(function(){
            connection.end();
            res.json({'Message':'SUCCESS','Reason':''});
        }).catch(function(err){
            return res.json({"data":[],"Message": "FAILURE","Reason": err})
        });
    }else{
        res.json({'data':[],"Message": "FAILURE","Reason": "Db issue"});
    }
    
}
function saveRow(stat,values,name){
    return new Promise(function(resolve,reject){
        connection.query(stat,values,function (err, results, fields) {
            if (err) {
                console.error(err.message);
                reject(err);
              }
             console.log(name+'saved'); 
            resolve(results);
          });
    });
}
function SelectQuery(tableName){
     var rowQuery = "SELECT id FROM "+tableName+" ORDER BY id DESC LIMIT 1";
     return new Promise(function(resolve,reject){
        connection.query(rowQuery,function (err, results, fields) {
            if (err) {
                console.error(err.message);
                reject(err);
              }
             console.log(tableName+' Id field '+ results +'returnd'); 
            resolve(results);
          });
     });
}


