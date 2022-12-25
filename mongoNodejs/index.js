
const express = require("express")
const mongoose = require("mongoose")
const dotenv = require("dotenv")
const connection = require("./Models/Utils/connection")
const apiController = require("./Models/ApiControllerDir/apiController")

dotenv.config();
let restApiaPP = null;

let port = null;


const initVar = async ()=>{
    
    port=process.env.PORT
    restApiaPP = express();
}

middleware = async ()=>{
    restApiaPP.use(express.urlencoded({extended : false}));
    restApiaPP.use(express.json({extended : false}));

    restApiaPP.use("/",apiController);
    restApiaPP.use("/api/auth/login",apiController);
    restApiaPP.use("/api/auth/signup",apiController);
}


const listenPort = async()=>{
    restApiaPP.listen(port,async ()=>{
        console.log("Rest Api Port Connected"+port);
    })
}


initVar().then(()=>{
    listenPort().then(()=>{
        middleware().then(()=>{
            connection();
        })
    })
})