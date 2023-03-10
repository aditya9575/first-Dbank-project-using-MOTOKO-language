import Debug "mo:base/Debug";
//import Int "mo:base/Int";
//import Nat "mo:base/Nat";
import Time "mo:base/Time";
import Float "mo:base/Float";



//in motoko language this actor is a class holding our canister 
//so we write the keyword actor and then name our class i.e DBank


//for our debug functionality to run we need to import the DEBUG MODULE 

actor DBank {
  stable var currentValue : Float = 300;
  currentValue := 100;
  Debug.print(debug_show(currentValue));

//for time we imported time module now we create a variable to store the time and use the time now function on it 
 stable var startTime = Time.now();
 startTime := Time.now();

//now for testing the output in the console we use the debug.print -> debug_show 
Debug.print(debug_show(startTime));


//here we are using the motoko language's assingment operator to update in place of the current value
 // currentValue := 100;

  let id = 123456789;
//Debug.print(debug_show(id));
//here we use the print function then deploy canisters by dfx start then split terminal dfx deploy to print the value of text only
//Debug.print(debug_show(id));


public func topUp(amount : Float){
  currentValue += amount  ; 
  Debug.print(debug_show(currentValue));
};



public func deduct(amount : Float){
  let tempValue:Float = currentValue - amount;

  if(tempValue >= 0){
  currentValue -= amount ;
  Debug.print(debug_show(currentValue));
                    }
else{
   Debug.print("Not enough balance ");
}

};

public query func checkBalance(): async Float {
  return currentValue;
};

//as in this example we are calculating compound interest for 1paise per second 
public func compound (){
let currentTime = Time.now();
let timeElapsedNS = currentTime - startTime;
let timeElapsedS = timeElapsedNS / 1000000000 ;
currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));
startTime := currentTime;
}


}