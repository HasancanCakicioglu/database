const bodyParser = require('body-parser')
const express = require('express')
const app = express()
const cors = require("cors")
const dotenv = require("dotenv")
const routerHome = require("./src/routes/homePage/home.js")
const routerAdd = require("./src/routes/addPage/add.js")
const routerUser= require("./src/routes/userPage/user.js")
const routerGoals= require("./src/routes/goalPage/goal.js")
const routerTest= require("./src/routes/testPage/testp.js")
const routerImage= require("./src/routes/imagePage/image.js")
const {connectDB} = require('./src/config/mongoose.js')
var axios = require("axios")


dotenv.config()
const PORT = process.env.PORT || 5000;
connectDB()


app.use(bodyParser.json({ limit: "30mb", extended: true }))
app.use(bodyParser.urlencoded({ limit: "30mb", extended: true }))
app.use(cors())


app.get('/', function (req, res) {
  res.json({
    author: "Coding",
    message: "heyyooooo",
  })
})


app.use("/home", routerHome)
app.use("/add", routerAdd)
app.use("/api/users", routerUser)
app.use("/api/goals", routerGoals)
app.use("/test", routerTest)
app.use("/image", routerImage)

app.use((req,res,next)=>{
  const error = new Error("Not Found");
  next(error);
})

app.use((error,req,res,next)=>{
  res.status(error.status || 500);
  res.json({
    error:{
      message:error.message
    }
  })
})



app.listen(PORT, () => {
  console.log(`Server is running on port: ${PORT}`);
  
})





// var interval = setInterval(()=>{

//   axios.get("https://api.coinranking.com/v2/coins",{
//     headers: {
//       'x-access-token': 'coinrankingeb375da17f92b43a9f929ef8d69810157325dec35d3e92cf'
//     }
//   }).then(result =>{
//     console.log(result.data.data.coins[0].sparkline)
//   }).catch(error=>{
//     console.log(error)
//   })
  
// },60050, "Hello.", "How are you?");




