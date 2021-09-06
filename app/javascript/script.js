const { check } = require("prettier");

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

	checkInputBoxes();
});

function checkInputBoxes() {
	const checkBoxes = document.querySelectorAll(".check-box");
	checkBoxes.forEach((box) => {
		const state = box.getAttribute("data-completed");
		if (state == "true") {
			box.checked = "true";
		}
		box.addEventListener("change", changeState);
	});
}

function changeState() {
	taskID = this.getAttribute("id");
	let state = "";
	if (this.checked) {
		this.setAttribute("data-completed", "true");
		state = "true";
	} else {
		this.setAttribute("data-completed", "false");
		state = "false";
	}
	sendData(state, taskID);
}

function sendData(state, taskID) {
	const metaCsrf = document.querySelector("meta[name='csrf-token']");
	const csrfToken = metaCsrf.getAttribute("content");
	const params = { completed: `${state}` };

	fetch(`task/${taskID}`, {
		method: "POST",
		body: JSON.stringify({
			data: params,
		}),
		headers: {
			"x-csrf-token": csrfToken,
			"content-type": "application/json",
			accept: "application/json",
		},
	}).then((res) => {
		console.log("Request complete! response:", res);
	});
}
