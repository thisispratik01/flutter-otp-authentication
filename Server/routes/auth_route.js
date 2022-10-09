const expres=require("express");
const bcrypt=require("bcryptjs");
const jwt=require("jsonwebtoken");
const User=require("../models/user_model");

const crypto=require("crypto");
const { otpGen } = require("../services/otp_generate");
const key="otp-secret-key";
const authRouter=expres.Router();

//generate and send otp for register

authRouter.post("/user/get-otp-register",async(req,res)=>{

 try{
 
 let {phone}=req.body;

if(phone.toString().length >10){
    return res.status(400).json({msg:"This phone no should be 10 digit long!"});
}

if(phone.toString().length <10){
    return res.status(400).json({msg:"This phone no must be 10 digit long!"});
}



let user=await User.findOne({"phone":phone});

if(user){
    return res.status(400).json({msg:"This phone no is already in use!"});
}

let allData=await otpGen(phone);
const [fullhash,otp]=allData.split('-');  

// const otp=otpGenerator.generate(4,{
//     lowerCaseAlphabets:false,
//     upperCaseAlphabets:false,
//     specialChars:false
// });

// const ttl=2 *60 *1000; //5 minutes
// const expires=Date.now() +ttl; //it will set 5 minutes restriction on otp
// const data=`${phone}.${otp}.${expires}`;
// const hash=crypto.createHmac("sha256",key).update(data).digest("hex");
// const fullhash=`${hash}.${expires}`; //send to user

//send otp to phone no then send hash to user in response
  /* 
   here im printing otp using console.log() so that i can use it in application to check functionality . you can use any msg provider
   to send this otp to user mobile no .
   */
 
console.log(otp);
//sending hash in response
res.status(200).json({
    fullhash:fullhash,
    otp:otp,
});

 }catch(e){
    res.status(500).json({error:e.message});
 }

});

// validateotp and register user

authRouter.post("/user/register",async(req,res)=>{
   let {phone,password,otp,}=req.body;
   
   let[hashvalue,expires]=req.body.hash.split('.');

  let currentTime=Date.now();  //returns current time 

  if(currentTime>parseInt(expires)){
    return res.status(400).json({msg:"OTP Expired!"});
  }

 let data =`${phone}.${otp}.${expires}`;
 let newHash=crypto.createHmac("sha256",key).update(data).digest("hex");
  
  if(newHash===hashvalue){

    //hashing password before storing
    const salt=await bcrypt.genSalt(10);
    const hashPassword=await bcrypt.hash(password,salt);

    let user=new User({
        
        phone,
        password:hashPassword
    });

    user=await user.save();
    const token=jwt.sign({id:user._id},"passwordkey");
   return res.status(200).json({token:token ,msg:"registered successfully."});
  }

   res.json({msg:"Invalid OTP"});
});


//generate otp for login

authRouter.post("/user/get-otp-login",async(req,res)=>{

    try{
    
    let {phone}=req.body;
   
   if(phone.toString().length >10){
       return res.status(400).json({msg:"This phone no must be 10 digit long!"});
   }
   if(phone.toString().length <10){
    return res.status(400).json({msg:"This phone no must be 10 digit long!"});
}
   
   
   const user=await User.findOne({"phone":phone});
   if(!user){
  return res.status(400).json({msg:"User not found!,try with registered phone no."});
   }
   
   let allData=await otpGen(phone);
   const [fullhash,otp]=allData.split('-');  
   
   // const otp=otpGenerator.generate(4,{
   //     lowerCaseAlphabets:false,
   //     upperCaseAlphabets:false,
   //     specialChars:false
   // });
   
   // const ttl=2 *60 *1000; //5 minutes
   // const expires=Date.now() +ttl; //it will set 5 minutes restriction on otp
   // const data=`${phone}.${otp}.${expires}`;
   // const hash=crypto.createHmac("sha256",key).update(data).digest("hex");
   // const fullhash=`${hash}.${expires}`; //send to user
   
   //send otp to phone no then send hash to user in response
   /* 
   here im printing otp using console.log() so that i can use it in application to check functionality . you can use any msg provider
   to send this otp to user mobile no .
   */
 
   console.log(otp);
     //sending hash in response . 
   res.status(200).json({
       fullhash:fullhash,
       otp:otp,
   });
   
    }catch(e){
       res.status(500).json({error:e.message});
    }
   
   });


//login route

authRouter.post("/user/login",async(req,res)=>{
   //get phone no from body
   const {phone,otp}=req.body;
   let[hashvalue,expires]=req.body.hash.split('.');



   let currentTime=Date.now();  //current time
   if(currentTime>parseInt(expires)){  //used parseInt() bcz expires is of type string got from body.
    return res.status(400).json({msg:"OTP Expired!"});
   }
  
   let data=`${phone}.${otp}.${expires}`;
   let newHash= crypto.createHmac("sha256",key).update(data).digest("hex");

   if(newHash===hashvalue){
    let user=await User.findOne({"phone":phone});
    const token =jwt.sign({id:user._id},"passwordkey");
    return res.status(200).json({token:token,msg:"Logged in successfully."});
   }
    res.json({msg:"Invalid OTP"});
});

module.exports=authRouter;