import { LightningElement, track } from 'lwc';
import generateApexClass from '@salesforce/apex/GenerateApex.generateApexClass';

export default class GenerateApex extends LightningElement {

    jsonString='';
    @track convertedValue='';
    error='';
    

    handleJsonChange(event){
        this.jsonString=event.target.value;
    }

    handleRemove(event){
        this.convertedValue='';
    }

    handleConvert(){
        console.log(this.jsonString);

        generateApexClass({jsonString: this.jsonString}).then((result)=>{
            console.log(result);
            this.convertedValue=result;
            

        })
        .catch((error)=>{
            console.log(error);

        });

    }
}