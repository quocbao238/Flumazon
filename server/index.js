
// Imports from packages
const express = require('express');
const { default: mongoose } = require('mongoose');
const mogoose = require('mongoose');
const adminRouter = require('./routes/admin');


// Imports from other file
const authRouter = require("./routes/auth");


// Init
const PORT = 3000;
const app = express()
const DB = 'mongodb+srv://baobui:bao123@cluster0.f4ig0xr.mongodb.net/?retryWrites=true&w=majority';

//middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);



// Connection
mongoose.connect(DB).then(() => {
  console.log("Connection Mongodb Successful");
}).catch((e) => {
  console.log(e);
});


app.listen(PORT,"0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});


