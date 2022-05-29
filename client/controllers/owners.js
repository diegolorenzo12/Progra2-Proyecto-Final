exports.getOwnerByAddress = (req, res, next) => {
  const ownerId = req.params.OwnerAddress;
  //usar el owner id para buscar en los contratos

  res.render("edit-product", {
    //agarrar estos datos conectandome al contrato
    name: "",
    description: "",
    role: "",
  });
};

exports.postCreateOwner = (req, res, next) => {
  const name = req.body.name;
  const description = req.body.description;
  const role = req.body.role;
  const address = ""; //esta debe ser la address de quien lo crea

  //meter estos datos al contrato
  res.redirect("/getOwnerByAddress");
};
