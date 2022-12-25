const express = require("express");
const {getImage,postImage,putImage,deleteImage} = require("../../controller/ImagePage/Imagec.js")

const routerImage = express.Router();

routerImage.get("/",getImage)
routerImage.post("/",postImage)
routerImage.put("/",putImage)
routerImage.delete("/:id",deleteImage)

module.exports = routerImage;
