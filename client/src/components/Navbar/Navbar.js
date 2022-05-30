import React from "react";
import { Navbar, Nav, Container } from "react-bootstrap";
import "../Navbar/styles.css";
//import "./styles.css";

function NavbarFunction(props) {
  var { onHome, selectedHome, onVerificar, selectedVerificar } = props;

  function handleOnClick(target) {
    selectedHome(false);
    selectedVerificar(false);

    if (target === 0) {
      selectedHome(true);
    }
    if (target === 1) {
      selectedVerificar(true);
    }
  }

  return (
    <Navbar expand="lg">
      <Container className="nav">
        <Navbar.Brand href="#home" id="titulo">
          QR Check{" "}
        </Navbar.Brand>
        <Navbar.Toggle aria-controls="basic-navbar-nav" />
        <Navbar.Collapse id="basic-navbar-nav">
          <Nav className="me-auto">
            {onHome ? (
              <Nav.Link id="nav-active" className="nav2">
                Home
              </Nav.Link>
            ) : (
              <Nav.Link onClick={() => handleOnClick(0)}> Home </Nav.Link>
            )}
            {onVerificar ? (
              <Nav.Link id="nav-active" className="nav2">
                Verificar Medicina
              </Nav.Link>
            ) : (
              <Nav.Link onClick={() => handleOnClick(1)}>
                {" "}
                Verificar Medicina{" "}
              </Nav.Link>
            )}
          </Nav>
        </Navbar.Collapse>
      </Container>
    </Navbar>
  );
}

export default NavbarFunction;
