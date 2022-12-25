const express = require("express");
const { model } = require("mongoose");
const {getHome,postHome,putHome,deleteHome} = require("../../controller/homePage/homec.js")

const routerHome = express.Router();

routerHome.get("/",getHome)
routerHome.post("/",postHome)
routerHome.put("/",putHome)
routerHome.delete("/:id",deleteHome)

module.exports = routerHome;
