import {dbank} from "../../declarations/dbank";

window.addEventListener("load" , async function(){
 // console.log("finished loading");
 const currentAmount = await dbank.checkBalance();
 
 document.getElementById("value").innerText = Math.round(currentAmount * 100)/100;
});

// now we add query selector and event listner with a function in it 
//to decide what action/function has to be triggered present in the motoko file 

document.querySelector("form").addEventListener("submit", async function (event){
 event.preventDefault();
 //console.log("submitted");

const button = event.target.querySelector("#submit-btn");

const inputAmount = parseFloat( document.getElementById("input-amount").value) ;
const outputAmount = parseFloat( document.getElementById("withdrawal-amount").value);

button.setAttribute("disabled",true);

//we add a check condition to update only if the user has entered something in the input feild 
if(document.getElementById("input-amount").value.length != 0){

//this function call below will topup the amount but for us to view the changes we need to also call the function checkBalance
await dbank.topUp(inputAmount);

}

if(document.getElementById("withdrawal-amount").value.length != 0){
  await dbank.deduct(outputAmount);
}

await dbank.compound();

const currentAmount = await dbank.checkBalance();
document.getElementById("value").innerText = Math.round(currentAmount * 100)/100;

//here we reset the input feild
document.getElementById("input-amount").value = "";
document.getElementById("withdrawal-amount").value = "";


button.removeAttribute("disabled");
})