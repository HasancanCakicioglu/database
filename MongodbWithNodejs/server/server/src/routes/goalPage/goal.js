const express = require("express");

const {getGoal,postGoal,putGoal,deleteGoal} = require("../../controller/goalPage/goalc.js")

const routerGoal = express.Router();
const {protect} = require("../../middleware/auth.js")

routerGoal.route("/").get(protect,getGoal).post(protect,postGoal)
routerGoal.route("/:id").put(protect,putGoal).post(protect,deleteGoal)


module.exports = routerGoal;
