import { Controller  } from "stimulus";

export default class extends Controller {
  static classes = [ "test" ]
  static targets = [
    "price",
    "container",
    "rawmat",
    "equipment",
    "labor",
    "total",
    "laborRate",
    "equipmentRate",
    "markupRate",
  ];


  initialize() {
    // console.log(this.priceTargets)
    this.containerTarget.style.display = "none";
    console.log(this.containerTarget)
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
    this.containerTarget.style.display = 'block';
    // let rawMat = document.createElement('div');
    // let equipment = document.createElement('div');
    // let labor = document.createElement('div');
    // let total = document.createElement('div');

    // rawMat.className = "close";
    
    this.rawmatTarget.innerHTML = `Php ${this.rawPrice.toFixed(2)}`;
    this.equipmentTarget.innerHTML = `Php ${this.equipmentPrice.toFixed(2)}`//`Estimated Equipment price(@ ${this.equipmentRate*100}% equipment rate): ${this.equipmentPrice}`;
    this.laborTarget.innerHTML = `Php ${this.laborPrice.toFixed(2)}`//`Estimated Labor price (@ ${this.laborRate*100}% labor rate): ${this.laborPrice}`;
    this.totalTarget.innerHTML = `<b>Php ${this.suggestedPrice.toFixed(2)}</b>`//`Suggested Price per serving (@ ${this.markupRate*100}% markup rate): <b>${this.suggestedPrice}</b>`;
    
    // this.containerTarget.appendChild(rawMat);
    // this.containerTarget.appendChild(equipment);
    // this.containerTarget.appendChild(labor);
    // this.containerTarget.appendChild(total);
  }
  updateLabor(){
    this.laborRate = parseFloat(this.laborRateTarget.value)/100;
    this.recalculatePrices();
  }
  updateEquipment(){
    this.equipmentRate = parseFloat(this.equipmentRateTarget.value)/100;
    this.recalculatePrices();
  }
  updateMarkUp(){
    this.markupRate = parseFloat(this.markupRateTarget.value)/100;
    this.recalculatePrices();
  }
  recalculatePrices(){
    this.equipmentPrice = this.rawPrice * this.equipmentRate;
    this.laborPrice = (this.rawPrice + this.equipmentPrice) * this.laborRate;
    this.suggestedPrice = (this.rawPrice + this.equipmentPrice + this.laborPrice) * (1+ this.markupRate);
    this.buildPriceSheet();
  }

  // clearContainerTarget(){
  //   while(this.containerTarget.firstChild){
  //     this.containerTarget.removeChild(this.containerTarget.firstChild);
  //   }
  // }
  notifyToFillPrice(){
    this.clearContainerTarget();
    let notify = document.createElement('div');
    notify.innerHTML = 'There are ingredients with no price! Update price/s first to use this feature!';

    this.containerTarget.appendChild(notify);
  }
}
