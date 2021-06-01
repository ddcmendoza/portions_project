import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [
    "price",
    "toPost",
    "name",
    "brand",
    "measurement",
    "measurementValue",
    "notification",
  ];
  static values = { url: String };

  initialize() {
    // console.log(this.urlValue, this.toPostTarget.value);
    this.notificationTarget.innerHTML = "";
  }
  // Fetch with this controller
  // Set _post value to 0 if there's fetched value
  //
  fetchPrice(e) {
    e.preventDefault();
    this.notificationTarget.innerHTML = "";
    fetch(
      `${this.urlValue}?name=${this.nameTarget.value}&brand=${this.brandTarget.value}&measurement=${this.measurementTarget.value}&measurement_value=${this.measurementValueTarget.value}`
    )
      .then((response) => {
        return response.json();
      })
      .then((data) => {
        this.changePrice(data.ingredient.price);
        // console.log(data);
      })
      .catch((e) => console.log(e));
  }
  updatePost(){
    this.toPostTarget.value = 1;
    // console.log("UPDATING POST!", this.toPostTarget.value);
  }

  changePrice(price) {
    if (price === null) {
      this.notifyUser();
    } else {
      this.priceTarget.value = parseInt(price);
      this.toPostTarget.value = 0;
      // console.log(price);
    }
  }

  notifyUser() {
    this.notificationTarget.innerHTML = "Want to post a price for this item?";
    this.priceTarget.value = null;
    // console.log("Wanna post a price for this item?");
  }
}
