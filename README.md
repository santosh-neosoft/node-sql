# Node SQL Application /Backend Task

Building a simple Node.js application for showing SQL database details 
## Getting Started  

 This application is written in ES6 in latest version of nodejs 8.2.
 1)  Design database - Create table and add their relationship.
 2) Create API for GetProgramDetails
    
    URL : - http://localhost:3000/program/getprogram
    Input parameter : 
    "version": 123,
    "client":"android|ios",
    "app": "learn java",
    "language" :"Java",
    “from”:15,
    “to”:100

    #client and language is a mandatory field
 3) saveprogram

    URL : -  http://localhost:3000/program/saveprogram
### Prerequisites   
You need to set up basic node.js installation.

### Installing
required labiraries 
```    
npm install express 
npm install ejs
npm install dotenv
npm install body-parser
npm install mysql