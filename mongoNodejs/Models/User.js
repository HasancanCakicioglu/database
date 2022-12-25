const { default: mongoose } = require("mongoose");

const userSchema = new mongoose.Schema({
    name:{
        type:String,
        default:" ",

    },
    email:{
        type:String,
        required:true,
        unique:true,
    },
    password:{
        type:String,
        required:true,

    },
    profilePicture:{
        type:String,
        default:" ",

    },
    coverPhoto:{
        type:String,
        default:" ",

    },
    following:{
        type:Array,
        default:[],

    },
    followers:{
        type:Array,
        default:[],

    },

},
{timestamps:true},

);

const User = mongoose.model("MyUsers",userSchema);
module.exports = User;