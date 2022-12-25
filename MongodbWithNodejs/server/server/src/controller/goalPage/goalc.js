
const {Goals} = require("../../model/goals.js")
const {User} = require("../../model/user.js")
const asyncHandler = require("express-async-handler")

const getGoal =asyncHandler( async (req,res)=>{
    const goals = await Goals.find({user:req.user.id})

    res.status(200).json(goals)
})

const postGoal =asyncHandler( async (req,res)=>{
    if(!req.body.text){
        res.status(400)
        throw new Error("Please add aa text fieedl")
    }
    const goal = await Goals.create({
        text:req.body.text,
        user:req.user.id,
    })
    res.status(200).json(goal)
})

const putGoal =asyncHandler( async (req,res)=>{
    
    const goal = await Goals.findById(req.params.id)

    if(!goal){
        res.status(400)
        throw new Error("Goal not found")
    }

    const user = await User.findById(req.user.id)

    if(!user){
        res.status(401)
        throw new Error("User not found")
    }

    if(goals.user.toString() !== user.id){
        res.status(401)
        throw new Error("User not authorized")
    }

    const updateGoal = await Goals.findByIdAndUpdate(req.params.id,req.body,{
        new:true,
    })

    res.status(200).json(updateGoal)
})

const deleteGoal =asyncHandler( async (req,res)=>{
    const goal = await Goals.findById(req.params.id)

    if(!goal){
        res.status(400)
        throw new Error("Goal not found")
    }

    const user = await User.findById(req.user.id)

    if(!user){
        res.status(401)
        throw new Error("User not found")
    }

    if(goals.user.toString() !== user.id){
        res.status(401)
        throw new Error("User not authorized")
    }

    await goal.remove()
    res.status(200).json({id:req.params.id})
}
)
module.exports = {getGoal,postGoal,putGoal,deleteGoal}