const mongoose = require('mongoose')


const connectDB = async () => {
    try {
        //run().catch(console.dir);
        mongoose.connect("mongodb+srv://testUser:123456test@cluster0.vk6odsj.mongodb.net/test?retryWrites=true&w=majority" ,{ useNewUrlParser: true, useUnifiedTopology: true })
    } catch (error) {
        console.log(error)
     process.exit(1)
    }
}







module.exports = { connectDB}
