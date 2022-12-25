

const getHome = async (req,res)=>{
    try{
        
        res.status(200).json({message:"getHome"});

    }catch(error){
        res.status(404).json({
            message:error.message,
        })
    }
}

const postHome = async (req,res)=>{
    try{
        const data = req.body;
        res.status(200).json(data);

    }catch(error){
        res.status(404).json({
            message:error.message,
        })
    }
}

const putHome = async (req,res)=>{
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

const deleteHome = async (req,res)=>{
    try{
        
        const data = req.params;
        
        res.status(200).send(`${data.id} deleted`);

    }catch(error){
        res.status(404).json({
            message:error.message,
        })
    }
}

module.exports = {getHome,postHome,putHome,deleteHome}