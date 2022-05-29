const path = require("path");

const express = require("express");

const ownersController = require("../controllers/owners");

const router = express.Router();

router.get("/owners/:OwnerAddress", ownersController.getOwnerByAddress);

router.post("/createOwner/", ownersController.postCreateOwner);

module.exports = router;
