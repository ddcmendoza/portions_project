import {Controller} from 'stimulus'

export default class extends Controller{
    static targets = ["amount", "needed", "verb"]
    static values = {serving: Number}
    initialize(){
        //console.log(this.servingValue)
        this.recipe = {};
        this.multiplier = 1;
        this.multiplier_source = "";
        this.multiplier_source_value = 1;
        this.multiplier_source_measurement = '' ;
        this.neededTargets.forEach(element => {
            let ingredient = {[element.id]: parseFloat(element.value)};
            let temp_recipe= {...this.recipe, ...ingredient};
            this.recipe = temp_recipe; 
        });
    }
    compute(e){
        // let amountContainer = this.amountTargets.find(element => element.id === e.target.id);
        let recipeAmount = this.recipe[e.target.id];
        // let value = parseFloat(amountContainer.innerHTML);
        // if (value > e.target.value || value == 0 && e.target.value != 0){
        this.multiplier = e.target.value/recipeAmount;
        this.multiplier_source = e.target.id
        this.multiplier_source_value = parseFloat(e.target.value)
        // amountContainer.innerHTML = e.target.value
        this.changeValue();
        // }
    }
    changeValue(){
        this.changeVerbToHave();
        Object.keys(this.recipe).forEach(ingredient => {
           let amountContainer = this.amountTargets.find(element => element.id === ingredient);
           amountContainer.value = (this.multiplier * this.recipe[ingredient]).toFixed(2);
           this.verbTargets.forEach(e => {
               if(e.id != this.multiplier_source){
                    e.innerHTML = `and I have ${this.multiplier_source_value.toFixed(2)} ${this.multiplier_source} so I'll need`;
               }
           })
        });
    }
    changeVerbToHave(){
        this.verbTargets.forEach(e=>{
            e.innerHTML = 'and I have';
        })
    }
}