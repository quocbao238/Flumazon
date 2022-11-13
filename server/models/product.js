const mogoose = require('mongoose');
const ratingSchema = require('./rating');

const productSchema = mogoose.Schema({
    name: {
        type : String,
        required: true,
        trim: true,
    },
    description: {
        type : String,
        required: true,
        trim: true,
    },
    images: [
        {
            type : String,
            required: true,
        },
    ],
    quantity: {
        type : Number,
        required: true,
    },
    price: {
        type : Number,
        required: true,
    },
    category: {
        type : String,
        required: true,
    },
    // Ratings
    ratings: [ratingSchema]
});

const Product = mogoose.model('Product',productSchema);

module.exports = Product;