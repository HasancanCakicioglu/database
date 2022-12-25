const express = require("express");
const { model } = require("mongoose");
const {loginUser,registerUser,getMe} = require("../../controller/userPage/userc.js")
const {protect} = require("../../middleware/auth.js")
const routerUser = express.Router();


routerUser.post("/",registerUser)
routerUser.post("/login",loginUser)
routerUser.get("/me",protect,getMe)


module.exports = routerUser;
