import React from "react";

function AddOwnerForm() {
  return (
    <form>
      <label>
        Nombre: <input type="text" />
      </label>
      <label>
        Descripción: <input type="text" />
      </label>

      <p>Ocupación</p>
      <label>
        Fabricante: <input type="radio" />
      </label>
      <label>
        Distribuidor: <input type="radio" />
      </label>
      <label>
        Tienda: <input type="radio" />
      </label>
      <label>
        Cliente: <input type="radio" />
      </label>
    </form>
  );
}

export default AddOwnerForm;
