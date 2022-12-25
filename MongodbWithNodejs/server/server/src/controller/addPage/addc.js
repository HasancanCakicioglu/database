
const User = require("../../model/user.js")

const getAdd = async (req,res)=>{
    try{
        
        
        const result = await User.findOne({username:"ayşe",age:45})
        
        
        res.status(200).json(result)

    }catch(error){
        res.status(404).json({
            message:error.message,
        })
    }
}

const postAdd = async (req,res)=>{
    try{
        const body = req.body;
        const userAdd = await new User({name:body.name,password:body.password,email:body.email,age:body.age});
        userAdd.save()

        res.status(200).json(userAdd);

    }catch(error){
        res.status(404).json({
            message:error.message,
        })
    }
}

const putAdd = async (req,res)=>{
    try{
        const deneme = await collection.insertOne({title:"JACLKİE"})
        
        res.status(200).json(deneme);

    }catch(error){
        res.status(404).json({
            message:error.message,
        })
    }
}

const deleteAdd = async (req,res)=>{
    try{
        
        const data = req.params;

        const deletedUser = await User.findByIdAndDelete(data.id);
        res.send(deletedUser)
        

    }catch(error){
        res.status(404).json({
            message:error.message,
        })
    }
}

module.exports = {getAdd,postAdd,putAdd,deleteAdd}