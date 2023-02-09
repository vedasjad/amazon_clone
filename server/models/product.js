const mongoose = require("mongoose");
const ratingSchema = require("./rating");

const productSchema = mongoose.Schema({
  name: {
    required: true,
    type: String,
    trim: true,
  },
  description:{
    required: true,
    type: String,
    trim: true,
  },
  images:[
    {
      type : String,
    required: true,
  }
  ],
  quantity: {
    required: true,
    type: Number,
  },
  price:{
    required: true,
    type: Number,
  },
  category: {
    required: true,
    type: String,
  },
  rating: [ratingSchema],
});

const Product = mongoose.model('Product', productSchema);
module.exports = Product;