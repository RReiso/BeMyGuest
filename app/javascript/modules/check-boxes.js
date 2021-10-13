import { sendData } from "./http-requests.js";

export function checkInputBoxes() {
  const checkBoxes = document.querySelectorAll(".check-box");
  checkBoxes.forEach((box) => {
    const checked_state = box.getAttribute("data-checked");
    if (checked_state == "true") {
      box.checked = true;
    }
    box.addEventListener("change", changeState);
  });
}

function changeState() {
  // manage items and tasks
  const objectName = this.getAttribute("name");
  const objectID = this.getAttribute("id");
  let state = "";
  if (this.checked) {
    this.setAttribute("data-checked", "true");
    state = "true";
  } else {
    this.setAttribute("data-checked", "false");
    state = "false";
  }
  const uri = `${objectName}s/${objectID}/state`;
  const requestBody = {
    checked: `${state}`,
  };
  sendData(uri, requestBody);
}
