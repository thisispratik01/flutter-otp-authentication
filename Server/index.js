const express=require("express");
const mongoose=require("mongoose");
const app=express();
const db="mongodb://127.0.0.1:27017/Ecom";
// const PORT= process.env.PORT || 3000 ;
const auth_route=require("./routes/auth_route");



mongoose
     .connect( db, { useNewUrlParser: true,  useUnifiedTopology: true })
     .then(() => console.log( 'Database Connected' ))
     .catch(err => console.log( err ));

app.use(express.json());
app.use(auth_route);     



app.listen(3000,()=>{
    console.log("Server Started ..");
});