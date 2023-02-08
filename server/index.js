const express = require('express');
const mongoose = require('mongoose');
mongoose.set('strictQuery', true);
const authRouter = require("./routes/auth");  
const adminRouter = require("./routes/admin");  
const productRouter = require('./routes/product');

const PORT = 3000;
const app = express();
const DB = "mongodb+srv://vedasjad:vedasjadamazonclone@cluster0.1rn0jec.mongodb.net/?retryWrites=true&w=majority";

app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);

mongoose.connect(DB).then(()=>{
  console.log(`Connection successful!`);
})
.catch((e)=>{
  console.log(e);
});

app.listen(PORT, "0.0.0.0",()=>{
  console.log(`Connected at port ${PORT}`);
});
