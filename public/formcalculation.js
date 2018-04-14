 function fallbackCopyTextToClipboard(text) {
  var textArea = document.createElement("textarea");
  textArea.value = text;
  document.body.appendChild(textArea);
  textArea.focus();
  textArea.select();

  try {
    var successful = document.execCommand('copy');
    var msg = successful ? 'successful' : 'unsuccessful';
    console.log('Fallback: Copying text command was ' + msg);
  } catch (err) {
    console.error('Fallback: Oops, unable to copy', err);
  }

  document.body.removeChild(textArea);
}
function copyTextToClipboard(text) {
  if (!navigator.clipboard) {
    fallbackCopyTextToClipboard(text);
    return;
  }
  navigator.clipboard.writeText(text).then(function() {
    console.log('Async: Copying to clipboard was successful!');
  }, function(err) {
    console.error('Async: Could not copy text: ', err);
  });
}
       
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
    return pay.toFixed(9)
}

function outputAmount(theRate,weekAv)
{
  
  //display the result
  var divobj = document.getElementById('totalPrice');
  //divobj.style.display='block';
  divobj.innerHTML = calculateAmount(theRate,weekAv) 
  //+ " <button onclick="copyTextToClipboard(pay.toFixed(9))"> copy to clipboard </button>";
}
