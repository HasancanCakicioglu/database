const mongoose = require("mongoose")

const ImageSchema =mongoose.Schema({
    name:{
        type:String,
        required:true,
    },
    image:{
        type:Buffer,
        contentType:String,
    }
    

})

const Image = mongoose.model("Image",ImageSchema);


module.exports = {Image};