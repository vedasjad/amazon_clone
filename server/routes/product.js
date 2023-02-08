const express = require('express');
const productRouter = express.Router();
const Product = require('../models/product');
const admin = require('../middlewares/admin');

productRouter.get("/api/products",admin,async(req,res)=>{
  try{
    
    const products = await Product.find({category: req.query.category});
    res.json(products);
  }catch(e){
    res.status(500).json({error: e.message});
  }
})

module.exports = productRouter;