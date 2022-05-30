import React, { useState } from "react";
import Home from "./components/Home/Home";
import Verificar from "./components/Verificar/Verificar";
import NavbarFunction from "./components/Navbar/Navbar";
import "bootstrap/dist/css/bootstrap.min.css";

import "./App.css";

function App() {
  const [onHome, selectedHome] = useState(true);
  const [onVerificar, selectedVerificar] = useState(false);

  return (
    <section>
      <NavbarFunction
        onHome={onHome}
        selectedHome={selectedHome}
        onVerificar={onVerificar}
        selectedVerificar={selectedVerificar}
      />
      {/* If variable == true show that component */}
      {onHome ? <Home /> : ""}
      {onVerificar ? <Verificar /> : ""}
    </section>
  );
}

export default App;
