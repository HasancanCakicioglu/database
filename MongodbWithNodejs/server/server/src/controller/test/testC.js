const {Test1} = require("../../model/test.js")

const getTest = async (req,res)=>{
    try{
        
        res.status(200).json({message:"getTest"});

    }catch(error){
        res.status(404).json({
            message:error.message,
        })
    }
}


module.exports = {getTest}