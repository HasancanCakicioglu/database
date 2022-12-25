const mongoose = require("mongoose")
const dotenv = require("dotenv")

dotenv.config()
let MONGO_URL = process.env.MONGO_URL;

const connectDB = async ()=>{
    try{
        mongoose.connect(MONGO_URL,{
            // //useNewUrlParser:true,
            // useFindAndModifiy:false,
            // useUnifiedTopology:true,
            bufferCommands:true,
            autoIndex:false
        });
        console.log("MongoDB have been connected")
    }catch(error){
        console.log("Error connecting MongoDB")
    }
}

module.exports = connectDB