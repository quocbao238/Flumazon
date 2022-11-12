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
        res.status(500,json({error:e.message}));
    }
});


module.exports = productRouter;