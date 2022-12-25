const multer = require("multer");
const {v4:uuidv4} = require("uuid");


const getImage= async (req,res)=>{
    try{
        
        res.status(200).json({message:"getImage"});

    }catch(error){
        res.status(404).json({
            message:error.message,
        })
    }
}

const storage = multer.diskStorage({
    destination:(req,file,cb)=>{
        cb(null,"./uploads/")
    },
    filename:function(req,file,cb){
        const uniqName = uuidv4();
        cb(null,file.fieldname+uniqName+file.originalname)
    }
})
const fileFilter = (req,file,cb)=>{
    cb(null,true)
}
const uploads = multer({storage:storage,fileFilter:fileFilter}).single("file")



const postImage= async (req,res)=>{
    try{
        uploads(req,res,(err)=>{
            if(err){
                res.status(400).json({
                    message:err.message,
                })
            }else{
                res.json(req.file).status(200)
            }
            
        })
        


    }catch(error){
        res.status(404).json({
            message:error.message,
        })
    }
}

const putImage= async (req,res)=>{
    try{
        
        const data = req.body;
        data.name = "newName";
        res.status(200).json(data);

    }catch(error){
        res.status(404).json({
            message:error.message,
        })
    }
}

const deleteImage= async (req,res)=>{
    try{
        
        const data = req.params;
        
        res.status(200).send(`${data.id} deleted`);

    }catch(error){
        res.status(404).json({
            message:error.message,
        })
    }
}

module.exports = {getImage,postImage,putImage,deleteImage}