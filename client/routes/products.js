const path = require("path");

const express = require("express");

const productsController = require("../controllers/products");

const router = express.Router();

router.post("/productLine/", productsController.postCreateProductLine);
router.get("/productLine/:UPC", productsController.getProductLineOwnerByUPC);

router.get("/products/:idProduct", productsController.getProductById);
router.post("/products/", productsController.postCreateProduct);

module.exports = router;
