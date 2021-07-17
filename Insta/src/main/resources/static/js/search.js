const inputBoxs = document.querySelector("input");
const recommendBoxs = document.querySelector("#recommend");
const texts = document.querySelectorAll(".text");

inputBoxs.addEventListener("keyup", (e) => {
	if (e.target.value.length > 0) {
		recommendBoxs.classList.remove('invisible');
		texts.forEach((textEl) => {
			textEl.textContent = e.target.value;
		})
	} else {
		recommendBoxs.classList.add('invisible');
	}
})