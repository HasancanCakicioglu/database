const mongoose = require("mongoose")

const userSchema =mongoose.Schema({
    name:{type:String},
    password:{
        type:String,
        required:[true,"please add password"],
    },
    age: {
        type:Number,
        default:100,
    },
    email:{
        type:String,
        required:true,
    },
    createdAttttt:{
        type:Date,
        default:new Date()
    }

},{
    timestamps: true,
  })

const User = mongoose.model("User",userSchema);


module.exports = User;