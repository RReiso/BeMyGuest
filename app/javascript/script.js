import { checkInputBoxes } from "./modules/check-boxes.js";
import { checkNotes } from "./modules/notes.js";

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