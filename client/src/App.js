import React, { useState, useEffect } from "react";
import Home from "./components/Home/Home";
import Verificar from "./components/Verificar/Verificar";
import NavbarFunction from "./components/Navbar/Navbar";
import "bootstrap/dist/css/bootstrap.min.css";
import { ethers } from "ethers";

import "./App.css";

function App() {
  const provider = new ethers.providers.Web3Provider(window.ethereum);
  const signer = provider.getSigner();
  const contractAddress = ""; //poner el addresss que me de al hacerle deploy

  useEffect(() => {
    const connectWallet = async () => {
      await provider.send("eth_requestAccounts", []);
    };
    connectWallet().catch(console.error);
  });

  const ABI = [
    {
      anonymous: false,
      inputs: [
        {
          indexed: false,
          internalType: "string",
          name: "_name",
          type: "string",
        },
        {
          indexed: false,
          internalType: "string",
          name: "_descritpion",
          type: "string",
        },
        {
          indexed: false,
          internalType: "enum Owners.OwnerRole",
          name: "role",
          type: "uint8",
        },
      ],
      name: "getOwnerEvent",
      type: "event",
    },
    {
      inputs: [
        {
          internalType: "string",
          name: "_name",
          type: "string",
        },
        {
          internalType: "string",
          name: "_description",
          type: "string",
        },
        {
          internalType: "enum Owners.OwnerRole",
          name: "_role",
          type: "uint8",
        },
      ],
      name: "addOwner",
      outputs: [],
      stateMutability: "nonpayable",
      type: "function",
    },
    {
      inputs: [
        {
          internalType: "address",
          name: "_ownerAddr",
          type: "address",
        },
      ],
      name: "emitOwner",
      outputs: [],
      stateMutability: "nonpayable",
      type: "function",
    },
    {
      inputs: [
        {
          internalType: "address",
          name: "_ownerAddr",
          type: "address",
        },
      ],
      name: "getOwner",
      outputs: [
        {
          internalType: "string",
          name: "",
          type: "string",
        },
        {
          internalType: "string",
          name: "",
          type: "string",
        },
        {
          internalType: "enum Owners.OwnerRole",
          name: "",
          type: "uint8",
        },
      ],
      stateMutability: "view",
      type: "function",
    },
    {
      inputs: [
        {
          internalType: "address",
          name: "_owner",
          type: "address",
        },
      ],
      name: "getOwnerRole",
      outputs: [
        {
          internalType: "uint256",
          name: "",
          type: "uint256",
        },
      ],
      stateMutability: "view",
      type: "function",
    },
    {
      inputs: [
        {
          internalType: "address",
          name: "_owner",
          type: "address",
        },
      ],
      name: "ownerExists",
      outputs: [
        {
          internalType: "bool",
          name: "",
          type: "bool",
        },
      ],
      stateMutability: "view",
      type: "function",
    },
  ];
  const Contract = new ethers.Contract(contractAddress, ABI, provider);

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
