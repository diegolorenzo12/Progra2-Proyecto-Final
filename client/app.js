const path = require("path");

const express = require("express");
const bodyParser = require("body-parser");

const app = express();

app.set("view engine", "ejs");
app.set("views", "views");

const ownersRoutes = require("./routes/owners");
const productsRoutes = require("./routes/products");

app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, "public")));

app.use(ownersRoutes);
app.use(productsRoutes);

app.listen(3000);
