import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "price", "toPost", "name", "brand", "measurement", "measurementValue" ]
  static values = {url: String}

  initialize() {
    console.log(this.urlValue, this.toPostTarget.value)
  }
  // Fetch with this controller
  // Set _post value to 0 if there's fetched value
  //
  fetchPrice(e){
    e.preventDefault();
    fetch(`${this.urlValue}?name=${this.nameTarget.value}&brand=${this.brandTarget.value}&measurement=${this.measurementTarget.value}&mvalue=${this.measurementValueTarget.value}`)
    .then(response => {
      console.log(response)
      return response.json()
    })
    .then(data => console.log(data))
    .catch(e => console.log(e))
  }
}
