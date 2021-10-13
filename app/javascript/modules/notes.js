import { sendData } from "./http-requests.js";

export function checkNotes() {
  const notes = document.querySelector("#sticky-note");
  let timer = 0;
  if (notes) {
    notes.addEventListener("keydown", function () {
      if (timer) {
        clearTimeout(timer);
      }
      timer = setTimeout(saveNotes, 1000);
    });
  }
}

function saveNotes() {
  const notes = document.querySelector("#sticky-note");
  const event_id = notes.getAttribute("data-event");
  const uri = `${event_id}/notes`;
  const requestBody = {
    id: event_id,
    notes: `${notes.value}`,
  };
  sendData(uri, requestBody);
}
