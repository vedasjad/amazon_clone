const express = require('express');
const productRouter = express.Router();
const Product = require('../models/product');
const auth = require('../middlewares/auth');

productRouter.get("/api/products",auth,async(req,res)=>{
  try{
    
    const products = await Product.find({category: req.query.category});
    res.json(products);
  }catch(e){
    res.status(500).json({error: e.message});
  }
});

productRouter.get("/api/products/search/:name",auth,async(req,res)=>{
  try{
    const products = await Product.find({
      name: {$regex: req.params.name, $options: 'i'},
    });
    res.json(products);
  }catch(e){
    res.status(500).json({error: e.message});
  }
});

productRouter.post("/api/rate-product",auth,async(req,res)=>{
  try{
    const {rating,id} = req.body;
    let product = await Product.findById(id);
    for(let i=0;i<product.rating.length;i++){
      if(product.rating[i].userId == req.user){
        product.rating.splice(i,1);
        break;
      }
    }
    const ratingSchema = {
      userId: req.user,
      rating,
    }
    
    product.rating.push(ratingSchema);
    product = await product.save();
    res.json(product);

  }catch(e){
    res.status(500).json({error: e.message});
  }
});



module.exports = productRouter;