const express = require('express');
const userRouter = express.Router();
const auth = require('../middlewares/auth');
const { Product } = require('../models/product');
const User = require('../models/user');


// Add Product to Cart
userRouter.post('/api/add-to-cart',auth, async (req, res) => {

    try {
     const {id} = req.body;
     const product = await Product.findById(id);
     let user = await User.findById(req.user);

     if(user.cart.lenght == 0){
        user.cart.push({product, quantity: 1});
     } else {
        let isProductFound = false;

        for(let i =0 ; i<user.cart.length; i++){
            const productId = user.cart[i].product._id.toString();
            if(productId == product._id){
                isProductFound = true;
                break;
            }
        }
        
        if(isProductFound){

            let productInCart = user.cart.find((element) => {
                console.log(element.product._id); 
                console.log(product._id);
               return element.product._id.toString() == product._id;
            });
    
            console.log(productInCart._id);
            productInCart.quantity += 1;
        }else{
            user.cart.push({product, quantity: 1});
        }

     }
     user = await user.save();
     res.json(user);

    } catch (error) {
        res.status(500,json({error:error.message}));
    }
});



// Remove Product From Cart
userRouter.delete('/api/remove-from-cart/:id',auth, async (req, res) => {

    try {
     const {id} = req.params;
     const product = await Product.findById(id);
     let user = await User.findById(req.user);

        for(let i =0 ; i<user.cart.length; i++){
            const _productId = user.cart[i].product._id.toString();
            if(_productId == product._id){
                if(user.cart[i].quantity == 1){
                    user.cart.splice(i,1);
                }else{
                    user.cart[i].quantity -= 1;
                }
            }
        }
        
     user = await user.save();
     res.json(user);
    } catch (error) {
        res.status(500,json({error:error.message}));
    }
});

// Delete Product From Cart
userRouter.delete('/api/delete-from-cart/:id',auth, async (req, res) => {

    try {
     const {id} = req.params;
     const product = await Product.findById(id);
     let user = await User.findById(req.user);

        for(let i =0 ; i<user.cart.length; i++){
            const _productId = user.cart[i].product._id.toString();
            if(_productId == product._id){
                user.cart.splice(i,1);
            }
        }
     user = await user.save();
     res.json(user);
    } catch (error) {
        res.status(500,json({error:error.message}));
    }
});



module.exports = userRouter;