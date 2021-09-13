// signup form validations
window.checkForm = function (form) {
	if (
		form["user[password]"].value !== form["user[password_confirmation]"].value
	) {
		alert("Error: Passwords do not match!");
		form["user[password]"].value = "";
		form["user[password_confirmation]"].value = "";
		form["user[password]"].focus();
		return false;
	}
};

document.addEventListener("turbolinks:load", function () {
	let errors = document.querySelectorAll(".field_with_errors");
	errors.forEach((err) => {
		if (err.firstChild.className === "form-control form-control-lg") {
			err.firstChild.classList.add("is-invalid");
		}
	});
	checkInvitationState();
	checkInputBoxes();
	checkNotes();
});

function checkInvitationState() {
	const checkBoxes = document.querySelectorAll(".check-inv");
	checkBoxes.forEach((box) => {
		const InGuestList = box.getAttribute("data-guest-list");
		console.log(InGuestList.dataset);
		if (InGuestList === "true") {
			box.checked = true;
			box.disabled = true;
		}
	});
}

function checkInputBoxes() {
	const checkBoxes = document.querySelectorAll(".check-box");
	checkBoxes.forEach((box) => {
		const checked_state = box.getAttribute("data-checked");
		if (checked_state == "true") {
			box.checked = true;
		}
		box.addEventListener("change", changeState);
	});
}

function checkNotes() {
	const notes = document.querySelector("#sticky-note");
	let timer = 0;
	if (notes) {
		notes.addEventListener("keypress", function () {
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
	requestBody = {
		id: event_id,
		notes: `${notes.value}`,
	};
	sendData(uri, requestBody);
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

function sendData(uri, requestBody) {
  console.log("sending")
	const metaCsrf = document.querySelector("meta[name='csrf-token']");
	const csrfToken = metaCsrf.getAttribute("content");
	fetch(uri, {
		method: "PATCH",
		body: JSON.stringify(requestBody),
		headers: {
			"x-csrf-token": csrfToken,
			"content-type": "application/json",
			accept: "application/json",
		},
	}).then((res) => {
		console.log("Request complete! response:", res);
	});
}
