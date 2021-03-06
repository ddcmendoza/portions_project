import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["add_item", "template","required"];

  add_association(event) {
    event.preventDefault();
    var content = this.templateTarget.innerHTML.replace(
      /TEMPLATE_RECORD/g,
      new Date().valueOf()
    );
    this.add_itemTarget.insertAdjacentHTML("beforebegin", content);
  }

  remove_association(event) {
    event.preventDefault();
    let response = confirm("Are you sure you want to delete this ingredient?");
    if (response) {
      let item = event.target.closest(".nested-fields");
      item.querySelector("input[name*='_destroy']").value = 1;
      item.style.display = "none";
      item.querySelector("input[name*='measurement']").required = false;
      item.querySelector("input[name*='measurement_value']").required = false;
    }
  }

}
