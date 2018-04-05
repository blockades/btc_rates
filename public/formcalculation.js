        
function calculateAmount(theRate,weekAv)
{
    
    var theForm = document.forms["cakeform"];
    var quantity = theForm.elements["quantity"];
    var days =0;
    //If the textbox is not blank
    if(quantity.value!="")
    {
        days = parseFloat(quantity.value);
    }
    var pay = (days * theRate) / weekAv;
    //display the result
    var divobj = document.getElementById('totalPrice');
    //divobj.style.display='block';
    divobj.innerHTML = "days per week @ €" + theRate + " per day. This weeks pay is BTC "+pay.toFixed(9);
}

