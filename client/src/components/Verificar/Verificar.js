//import "./styles.css";
import "../Verificar/styles.css";
import React from "react";
import {
  Card,
  CardGroup,
  Form,
  ListGroup,
  ListGroupItem,
} from "react-bootstrap";
import botella from "../../assets/botella.png";

function Verificar() {
  return (
    <div className="container2">
      <CardGroup>
        <Card className="card2">
          <Form.Group controlId="formFileLg" className="mb-3">
            <label for="formFileLg" class="form-label">
              Ingresa el código QR
            </label>
            <Form.Control type="file" size="lg" />
          </Form.Group>
          <div className="card3" style={{ width: "20rem" }}>
            <Card.Img variant="top" src={botella} />
            <Card.Body></Card.Body>
            <ListGroup className="list-group-flush">
              <ListGroupItem>Fecha de creación: 01/01/2022</ListGroupItem>
              <ListGroupItem>Fecha de expiración: 29/05/2026</ListGroupItem>
              <ListGroupItem>Manufacturero: Johnson y Johnson </ListGroupItem>
            </ListGroup>
          </div>
        </Card>
        <Card>
          <Card.Header className="block" as="h5">
            VERIFICAR <p id="n">MEDICINA</p>{" "}
          </Card.Header>
          <h5 class="card-title">Dueños previos</h5>
          <div className="card3" style={{ width: "30rem" }}>
            <ListGroup className="list-group-flush">
              <ListGroupItem>
                Andrea Garza <p>+52(99)750-0603</p>
              </ListGroupItem>
              <ListGroupItem>
                David Pérez <p>+52(694)650-9144</p>
              </ListGroupItem>
              <ListGroupItem>
                Margarita Cortez <p>+52(61)168-1871</p>
              </ListGroupItem>
            </ListGroup>
            <Card.Header className="b" as="h2">
              LA MEDICINA ES<br></br>
              <p id="n"> ORIGINAL</p>{" "}
            </Card.Header>
          </div>
        </Card>
      </CardGroup>
    </div>
  );
}

export default Verificar;
