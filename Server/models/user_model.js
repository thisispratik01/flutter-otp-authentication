const mongoose=require("mongoose");

const userSchema=mongoose.Schema({

    // name:{
    //     type:String,
    //     required:true,
    //     trim:true
    // },

    phone:{
        type:Number,
        required:true,
        trim:true
        
        
    },
    password:{
        type:String,
        required:true,
        minLenth:6
    }
});

const User=mongoose.model('User',userSchema);
module.exports=User;