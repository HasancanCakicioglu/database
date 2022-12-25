const express = require("express");
const { model } = require("mongoose");
const {getTest} = require("../../controller/test/testC.js")

const routerTest = express.Router();

routerTest.get("/",getTest)


module.exports = routerTest;
