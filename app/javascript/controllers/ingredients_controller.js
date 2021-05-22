import {Controller} from 'stimulus'

export default class extends Controller{
    static targets = ["counter", "container"]
    static values = {url: String}

    initialize(){
        this.value = 0;
    }
    add(e){
        e.preventDefault();
        const ing = document.createElement('input');
        ing.type = 'text';
        ing.id = `recipe_form_ingredient_${this.value}`
        ing.name = `recipe_form[ingredient][${this.value}]`

        const label = document.createElement('label')
        label.for = `recipe_form_ingredient_${this.value}`
        label.innerHTML = `Ingredient ${this.value + 1}`
        this.containerTarget.appendChild(label);
        this.containerTarget.appendChild(ing);
        this.containerTarget.appendChild(document.createElement('br'))
        this.value++ ;
    }
    remove(e){
        console.log(e.target.nodeName)
        if (e.target.nodeName != "DIV") e.target.parentNode.remove()
    }
}