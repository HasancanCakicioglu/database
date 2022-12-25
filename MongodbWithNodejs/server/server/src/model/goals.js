const mongoose = require("mongoose")

const goalsSchema =mongoose.Schema({
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

const Goals = mongoose.model("Goals",goalsSchema);


module.exports = {Goals};