import React from "react";

function AddProductLineForm() {
  return (
    <form>
      <label>
        UPC: <input type="text" />
      </label>
      <label>
        Nombre: <input type="text" />
      </label>
      <label>
        Descripción: <input type="text" />
      </label>
    </form>
  );
}

export default AddProductLineForm;
