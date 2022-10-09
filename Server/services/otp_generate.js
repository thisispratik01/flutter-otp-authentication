const otpGenerator=require("otp-generator");
const crypto=require("crypto");
const key="otp-secret-key";

async function otpGen( phone){
    const otp=otpGenerator.generate(4,{
        lowerCaseAlphabets:false,
        upperCaseAlphabets:false,
        specialChars:false
    });
    
    const ttl=2 *60 *1000; //2 minutes
    const expires=Date.now() +ttl; //it will set 5 minutes restriction on otp
    const data=`${phone}.${otp}.${expires}`;
    const hash=crypto.createHmac("sha256",key).update(data).digest("hex");
    const allData=`${hash}.${expires}-${otp}`; 
    return allData ;   
    
};





module.exports={otpGen};