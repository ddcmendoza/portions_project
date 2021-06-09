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
        console.log(data);
        this.changePrice(data);
      })
      .catch((e) => console.log(e));
  }
  updatePost(){
    this.toPostTarget.value = 1;
    // console.log("UPDATING POST!", this.toPostTarget.value);
  }

  changePrice(data) {
    if (data.ingredient.price === null) {
      this.notifyUser();
      return;
    } 
    if(this.matchParams(data)) {
      let multiplier = parseFloat(this.measurementValueTarget.value)/parseFloat(data.ingredient.measurement_value);
      this.priceTarget.value = parseFloat(data.ingredient.price) * multiplier;
      this.toPostTarget.value = 0;
      return;
    }
    this.notifyUser();
  }

  matchParams(data){
    let brand = data.ingredient.brand == null ? "" : data.ingredient.brand
    console.log(brand, this.brandTarget.value)
    return brand == this.brandTarget.value.toLowerCase() && data.ingredient.measurement == this.measurementTarget.value.toLowerCase();
  }

  notifyUser() {
    this.notificationTarget.innerHTML = "Want to post a price for this item?";
    this.priceTarget.value = null;
    // console.log("Wanna post a price for this item?");
  }
}
