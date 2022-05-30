exports.getProductLineOwnerByUPC = (req, res, next) => {
  const UPC = req.params.UPC;
  //usar el upc para buscar la info dle owner del productline

  res.render("products", {
    //agarrar estos datos conectandome al contrato
    name: "",
    description: "",
    role: "",
  });
};

//retorna un product
exports.getProductById = (req, res, next) => {
  const idProduct = req.params.idProduct;
  //usar el productid para buscar en los contratos

  res.render("products", {
    //agarrar estos datos conectandome al contrato
    name: "",
    description: "",
    state: "",
    pastOwners: "",
  });
};

exports.postCreateProductLine = (req, res, next) => {
  //agarrar datos de un form
  const name = req.body.name;
  const description = req.body.description;
  const address = ""; //esta debe ser la address de quien lo crea

  //meter estos datos al contrato
  res.redirect("/getOwnerByAddress");
};

exports.postCreateProduct = (req, res, next) => {
  const UPC = req.body.UPC;
  const state = req.body.role;
  const address = ""; //esta debe ser la address de quien lo crea

  //meter estos datos al contrato
  res.redirect("/getOwnerByAddress");
};
