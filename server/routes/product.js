const { json } = require('express');
const express = require('express');
const productRouter = express.Router();
const auth = require('../middlewares/auth');
const { Product } = require('../models/product');


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



// Cart Page
productRouter.get('/api/deal-of-day',auth, async (req, res) => {
    try {   
        let products = await Product.find({});

        products = products.sort((a,b) => {
            let aSum = 0;
            let bSum =0;
            
            if(a.ratings != null && a.ratings.length > 0)
            for(let i =0; i< a.ratings.length; i++){
                aSum += a.ratings[i].rating;
            }
            if(b.ratings != null && b.ratings.length > 0)
            for(let i =0; i< b.ratings.length; i++){
                bSum += b.ratings[i].rating;
            }
            return aSum < bSum ? 1: -1;
        });

        res.json(products[0]);
    } catch (error) {
        res.status(500,json({error:error.message}));
    }
});



module.exports = productRouter;