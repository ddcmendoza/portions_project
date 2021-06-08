import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [
    "price",
    "container",
  ];


  initialize() {
    // console.log(this.priceTargets)
    this.equipmentRate = 0.5
    this.laborRate = 0.5
    this.markupRate = 0.5
    this.rawPrice = 0;
    this.priceTargets.map(target => this.rawPrice += parseFloat(target.value));
    this.equipmentPrice = this.rawPrice * this.equipmentRate;
    this.laborPrice = (this.rawPrice + this.equipmentPrice) * this.laborRate;
    this.suggestedPrice = (this.rawPrice + this.equipmentPrice + this.laborPrice) * (this.markupRate + 1.0);
  }
  query(e){
    e.preventDefault();
    // console.log("CLICKED!")
    // this.priceTargets.map(target => console.log(target.value,this.rawPrice));
    if (!isNaN(this.rawPrice)){
      this.buildPriceSheet();
    }
    else {
      this.notifyToFillPrice();
    }
  }

  buildPriceSheet(){
    this.clearContainerTarget();
    let rawMat = document.createElement('div');
    let equipment = document.createElement('div');
    let labor = document.createElement('div');
    let total = document.createElement('div');
    rawMat.innerHTML = `Total Ingredient price: ${this.rawPrice}`;
    equipment.innerHTML = `Estimated Equipment price(@ ${this.equipmentRate*100}% equipment rate): ${this.equipmentPrice}`;
    labor.innerHTML = `Estimated Labor price (@ ${this.laborRate*100}% labor rate): ${this.laborPrice}`;
    total.innerHTML = `Suggested Price per serving (@ ${this.markupRate*100}% markup rate): <b>${this.suggestedPrice}</b>`;
    
    this.containerTarget.appendChild(rawMat);
    this.containerTarget.appendChild(equipment);
    this.containerTarget.appendChild(labor);
    this.containerTarget.appendChild(total);
  }

  recalculatePrices(){
    this.equipmentPrice = this.rawPrice * 0.5;
    this.laborPrice = (this.rawPrice + this.equipmentPrice) * 0.5;
    this.suggestedPrice = (this.rawPrice + this.equipmentPrice + this.laborPrice) * 1.5;
  }

  clearContainerTarget(){
    while(this.containerTarget.firstChild){
      this.containerTarget.removeChild(this.containerTarget.firstChild);
    }
  }
  notifyToFillPrice(){
    this.clearContainerTarget();
    let notify = document.createElement('div');
    notify.innerHTML = 'There are ingredients with no price! Update price/s first to use this feature!';

    this.containerTarget.appendChild(notify);
  }
}
