const { json } = require('express');
const express = require('express');
const productRouter = express.Router();
const auth = require('../middlewares/auth');
const Product = require('../models/product');


productRouter.get('/api/get-products',auth, async (req, res) => {

    try {
        const  _category = req.query.category;
       const products = await Product.find({
        category:_category
       });
       res.json(products);
    } catch (error) {
        res.status(500,json({error:error.message}));
    }
});

productRouter.get('/api/products/search/:searchName',auth, async (req, res) => {

    try {
        const  _searchQuery = req.params.searchName;
       const products = await Product.find({
         name: {$regex: _searchQuery, $options: "i"}
       });
       res.json(products);
    } catch (error) {
        res.status(500,json({error:error.message}));
    }
});

// Create a post requrest route to rate the product

productRouter.post('/api/products/rating',auth, async (req, res) => {
    try {
        const  {id, rating} = req.body;
        
        let product = await Product.findById(id);

        console.log(product.toJSON);
        // for(var _rating in product.ratings){
        //     const _index = product.ratings.indexOf(_rating);
        //     if(_rating.userId == req.user){
        //         product.rating.splice(_index,1);
        //         break;
        //     }
        // }

        for(let i = 0 ; i < product.ratings.length; i ++){
            if(product.ratings[i].userId == req.user){
                product.ratings.splice(i,1);
                break;
            }
        }

        const ratingSchema = {
            userId:req.user,
            rating
        };
        
        product.ratings.push(ratingSchema);
        product = await product.save();
        res.json(product);
    } catch (error) {
        res.status(500,json({error:error.message}));
    }
});

module.exports = productRouter;