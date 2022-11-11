const { json } = require('express');
const e = require('express');
const express = require('express');
const adminRouter = express.Router();
const admin = require('../middlewares/admin');
const Product = require('../models/product');

// Add Product
adminRouter.post('/admin/add-product',admin, async (req, res) => {

    try {
        const {name, description, quantity, price, category, images} = req.body;
        const product = Product({
            name,description,images,quantity,price,category,
        });
        product = await product.save();
        res.json(product);
    } catch (error) {
        res.status(500,json({error:e.message}));
    }

})
