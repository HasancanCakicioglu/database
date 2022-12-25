const express = require("express");
const User = require("../User");
const bcrypt = require("bcrypt")
const multer = require("multer")
const { GridFsStorage } = require("multer-gridfs-storage")
const crypto = require("crypto")
const routes = express.Router();
const Grid = require("gridfs-stream")
const path = require("path")
const connection = require("../Utils/connection")
const mongoose = require("mongoose")
const dotenv = require("dotenv")
var storage;
dotenv.config()
let MONGO_URL = process.env.MONGO_URL
let connectionGfs = null;
let uploadImage = null;

connection().then(() => {
    console.log("This is Connection inside mongo")

    const conn = mongoose.createConnection(MONGO_URL)
    conn.once("open", function () {
        console.log("Connection Is Open")
        connectionGfs = Grid(conn.db, mongoose.mongo)
        connectionGfs.collection("uploads");
        console.log("Mongodb connected created")
    });

    storage = new GridFsStorage({
        url: MONGO_URL,
        file: (req, file) => {
            return new Promise((resolve, reject) => {
                crypto.randomBytes(16, (err, buff) => {
                    if (err) {
                        return reject(err);
                    }
                    const fileName = buff.toString("hex") + path.extname(file.originalname);
                    const fileInfo = {
                        filename: fileName,
                        bucketname: "uploads"
                    };
                    resolve(fileInfo)
                })
            })
        }
    })


    uploadImage = multer({ storage })
    routes.get("/", (req, res) => {
        res.send("This is My RestApi Route")
    })

    routes.post("/api/auth/login", async (req, res) => {
        console.log(req.body)

        try {

            if (req.body.email != null) {
                const user = await User.findOne({ email: req.body.email })

                !user && res.status(404).json({
                    message: "User Does not exist,register user"
                });

                const validPassword = await bcrypt.compare(req.body.password, user.password);
                !validPassword && res.status(404).json({
                    message: "Invalid Credentials.Check login details"
                });

                if (user != null) {

                    res.json({
                        message: "Succes",
                        body: user,
                    });
                }
            } else {

                res.status(400).json({
                    message: "Email is required here"
                })
            }
        } catch (e) {
            console.log(`error login ${e}`)
        }

    })

    routes.post("/api/auth/signup", uploadImage.single("image"), async (req, res) => {


        try {
            if (req.body.password != null) {

                const salt = await bcrypt.genSalt(10);
                const hashPassword = await bcrypt.hash(req.body.password, salt);

                if (req.body.email != null) {
                    const user = await new User({
                        name: req.body.name,
                        email: req.body.email,
                        profilePicture: req.file.filename,
                        password: hashPassword,
                    });
                    await user.save();
                    res.json({
                        user_details: user,
                        message: "Succesfully registered",
                        token: hashPassword,
                        imageurl: "http://localhost:9000/api/files/" + req.file.filename,
                    });
                } else {
                    res.status(400).json({ message: "email is required" })
                }
            } else {
                res.status(400).json({ message: "password is required" })
            }
        } catch (e) {
            console.log(`error signup ${e}`)
        }
    })

    routes.get("/api/files", (req, res) => {
        res.send("Restapi retrieve all FİLES")
    })

    routes.get("/api/files/:filename", (req, res) => {
        connectionGfs.files.findOne({ filename: req.params.filename }, (err, file) => {
            console.log(req.params.filename);
            console.log(file)
            
            if (!file || file.lenght == 0) {
                console.log("There is no file")
                res.status(404).json({
                    error: "404",
                    message: "The resource does not exist,invalid request"
                })
            } else {
                console.log("There is file")
                res.set({
                    "Content-Type": file.contentType
                });

                const readStream = connectionGfs.createReadStream(file.filename);
                readStream.pipe(res)
            }

        })
    })

})



module.exports = routes;