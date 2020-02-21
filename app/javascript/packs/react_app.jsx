import React, { useState } from 'react'
import ReactDOM from 'react-dom'

import Button from 'react-bootstrap/Button'
import ButtonGroup from 'react-bootstrap/ButtonGroup'
import Container from 'react-bootstrap/Container'
import Jumbotron from 'react-bootstrap/Jumbotron'
import Modal from 'react-bootstrap/Modal'

import 'bootstrap/dist/css/bootstrap.min.css';

function ThrowButton(props) {
  function doThrow() {
    fetch('/game', {
        method: 'POST',
        body: JSON.stringify({throw: props.throwtype}),
        headers: {'Content-Type': 'application/json'},
      })
      .then(response => response.json())
      .then(result => {
        props.setstate({
          show: true,
          ...result,
        });
      });
  }
  return (
    <Button variant={props.variant} onClick={doThrow}>{props.throwtype}</Button>
  );
}

function Jumbo(props) {
  const [modalState, setModalState] = useState({show: false});
  const buttonProps = {
    variant: 'secondary',
    setstate: setModalState,
  }
  return (
    <Jumbotron>
      <h1>Rock - Paper - Scissors - Lizard - Spock</h1>
      <p>
        Rock Paper Scissors Lizard Spock is a zero sum game that is usually played by two people
        using their hands and no tools. The idea is to make shapes with an outstretched
        hand where each shape will have a certain degree of power and will lead to an outcome.
      </p>
      <ButtonGroup aria-label="Choose your hand">
        <ThrowButton {...buttonProps} throwtype="rock"></ThrowButton>
        <ThrowButton {...buttonProps} throwtype="paper"></ThrowButton>
        <ThrowButton {...buttonProps} throwtype="scissors"></ThrowButton>
        <ThrowButton {...buttonProps} throwtype="lizard"></ThrowButton>
        <ThrowButton {...buttonProps} throwtype="spock"></ThrowButton>
      </ButtonGroup>
      <ResultsModal {...modalState} onHide={() => setModalState(false)} />
    </Jumbotron>
  );
}

function ResultsModal(props) {
  let result = props.result || 'mess';
  return (
    <Modal {...props} aria-labelledby="contained-modal-title-vcenter">
      <Modal.Header closeButton>
        <Modal.Title id="contained-modal-title-vcenter">
          What a {result}!
        </Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <Container>
            Player's {props.player_throw} vs. Curb's {props.curb_throw}
        </Container>
      </Modal.Body>
      <Modal.Footer>
        <Button onClick={props.onHide}>Close</Button>
      </Modal.Footer>
    </Modal>
  );
}


function App() {

  return (
    <div className="col-lg-6 col-md-6 col-sm-6 col-xs-6 offset-3 float-md-center">
      <Jumbo />
    </div>
  );
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <App />,
    document.body.appendChild(document.createElement('div')),
  )
})
