var web3 = new Web3(Web3.givenProvider);
var contractInstance;
$(document).ready(function() {
    window.ethereum.enable().then(function(accounts){
        contractInstance = new web3.eth.Contract(abi, "0x84a7d4b8BfCA2e6b7BD5be21cfeAa77AaC5e01e0", {from: accounts[0]});
        console.log(contractInstance);
    });
    $("#set-bet-button").click(inputData)
    $("#flip").click(flipAcoin)
    
});

function inputData(){
    var coinside = $("input[name=coinside]:checked").val();
    
    var betvalue = $("#bet_input").val();
    
    var config = {
        value: Web3.utils.toWei(betvalue, "ether")
    }

    contractInstance.methods.setAbet(coinside).send(config);

    
}

function flipAcoin() {

    contractInstance.methods.flip().send().then(function(res){
        if (res==1) {
            alert("You won!");
        }
        else {
            alert("you lost a bet");
        }
    })
}

    


   


