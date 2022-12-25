const mongoose = require("mongoose")

const test1Schema =mongoose.Schema({
    user:{
        type:mongoose.Schema.Types.ObjectId,
        required:true,
        ref:"User"
    },
    text:{
        type:String,
        required:[true,"Please add a text value"]
    }
    

},{
    timestamps: true,
  })

const Test1 = mongoose.model("Test",test1Schema);


module.exports = {Test1};