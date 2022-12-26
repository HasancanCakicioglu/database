const mongoose = require('mongoose')


const connectDB = async () => {
    try {
        //run().catch(console.dir);
        mongoose.connect( ,{ useNewUrlParser: true, useUnifiedTopology: true })
    } catch (error) {
        console.log(error)
     process.exit(1)
    }
}







module.exports = { connectDB}
