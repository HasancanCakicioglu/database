const express = require("express");




const {getAdd,postAdd,putAdd,deleteAdd} = require("../../controller/addPage/addc.js")

const routerAdd = express.Router();

routerAdd.get("/",getAdd)
routerAdd.post("/",postAdd)
routerAdd.put("/",putAdd)
routerAdd.delete("/:id",deleteAdd)

module.exports = routerAdd;
