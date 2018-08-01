const maxBus = 256;
const maxDev = 32;
const maxFunc = 8;

let inputValue = document.createAttribute("value");
inputValue.value = "f8000000"
document.getElementById("input").attributes.setNamedItem(inputValue);

let busSelect = document.getElementsByTagName("select")[0];
let devSelect = document.getElementsByTagName("select")[1];
let funcSelect = document.getElementsByTagName("select")[2];
let nodeText;
let option;

for (let index = 0; index < maxBus; index++) {
  if (index < 16) {
    nodeText = document.createTextNode("0" + index.toString(16));
  } else {
    nodeText = document.createTextNode(index.toString(16));
  }

  option = document.createElement("option");
  option.appendChild(nodeText);
  busSelect.appendChild(option);
}

for (let index = 0; index < maxDev; index++) {
  if (index < 16) {
    nodeText = document.createTextNode("0" + index.toString(16));
  } else {
    nodeText = document.createTextNode(index.toString(16));
  }

  option = document.createElement("option");
  option.appendChild(nodeText);
  devSelect.appendChild(option);
}

for (let index = 0; index < maxFunc; index++) {
  if (index < 16) {
    nodeText = document.createTextNode("0" + index.toString(16));
  } else {
    nodeText = document.createTextNode(index.toString(16));
  }

  option = document.createElement("option");
  option.appendChild(nodeText);
  funcSelect.appendChild(option);
}

function calculateMmioAddr(){
  const baseAddr = parseInt(document.getElementById("input").getAttribute("value"), 16)
  const bus = document.getElementsByTagName("select")[0].value;
  const dev = document.getElementsByTagName("select")[1].value;
  const func = document.getElementsByTagName("select")[2].value;
  let resString = (baseAddr + parseInt(bus, 16) * parseInt('100000', 16) + parseInt(dev, 16) * parseInt('8000', 16) + parseInt(func) * parseInt('1000', 16)).toString(16);
  return "0x" + resString;
}

function generate() {
  let Addr = calculateMmioAddr();
  document.getElementById("responseField").innerHTML = Addr
};
