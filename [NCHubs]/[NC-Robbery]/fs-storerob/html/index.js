var first = true
var min = 350
var max = 550
var gcard=false
var gcash= false
var cardCode=111111
var gType= "nill"
var balance
var gameType
var arr= [["cash","cash","cash","cash","cash"],["cash","cash","cash","cash","cash"],["cash","cash","cash","cash","cash"],["cash","cash","cash","cash","cash"],["cash","cash","cash","cash","cash"]]
var input
var bombed = true


function getInput(){
    $("#subbu").prop('disabled',true); 
    var enterdNum = document.getElementById("safePin").value;
    if(parseInt(enterdNum) == parseInt(cardCode)){
        $.post('https://fs-storerob/safe', JSON.stringify({}));
    }else{
        $('#container1').fadeToggle();
        $.post('https://fs-storerob/nsn', JSON.stringify({}));
    }
    
}

function create(){
    gcard=false
    balance= Math.floor(Math.random() * (max - min) + min);
    const div = document.getElementById('msum');
div.textContent = balance+ "$";
var i=0
arr= null
arr =[["cash","cash","cash","cash","cash"],["cash","cash","cash","cash","cash"],["cash","cash","cash","cash","cash"],["cash","cash","cash","cash","cash"],["cash","cash","cash","cash","cash"]]
while (i<2){
  const num1= getRandomInt(5)
  const num2= getRandomInt(5)
  if (arr[num1][num2]=="cash"){
    arr[num1][num2]="bomb"
    i=i+1
  }
}
var found= false
while (!found) {
    const num1= getRandomInt(5)
    const num2= getRandomInt(5)
    if (arr[num1][num2]=="cash"){
    arr[num1][num2]="note"
    found=true
    }
}
}
$("#cout").click(function () {
    $("#cout").prop('disabled',true); 
    bombed=false
    reavelAll()
})
function reavelAll(){
    
    if(bombed){
        gcard=false
        balance=Math.floor(balance/2);
        const div = document.getElementById('msum');
        div.innerText= balance + "$";
    }if(gcard && gType== "register"){
        cardCode= (getRandomInt(10)*100000) + (getRandomInt(10)*10000) +(getRandomInt(10)*1000)+ (getRandomInt(10)*100) +(getRandomInt(10)*10)+ (getRandomInt(10)*1);
    }
    if(arr[0][0]== "cash"){
        document.getElementById("b1_1").className = "fa-solid fa-clipboard-check fa-beat-fade";
        document.getElementById('b1_1').style.color = 'white';
        document.getElementById('b1').style.backgroundColor = 'rgb(93, 158, 255)';
    }else if(arr[0][0]== "bomb"){
        $(".btn").prop('disabled',true); 
        document.getElementById("b1_1").className = "fa-sharp fa-solid fa-bomb fa-shake";
        document.getElementById('b1_1').style.color = 'white';
        document.getElementById('b1').style.backgroundColor = 'red';
    }else{
        if(gType == "register"){
            
            document.getElementById("b1_1").className = "fa-solid fa-clipboard";
            document.getElementById('b1_1').style.color = 'white';
            document.getElementById('b1').style.backgroundColor = 'lightgreen';
            }
            else{
                document.getElementById("b1_1").className = "fa-solid fa-address-card";
                document.getElementById('b1_1').style.color = 'white';
                document.getElementById('b1').style.backgroundColor = '#6366f1';
            }
    }
if(arr[0][1]== "cash"){
        document.getElementById("b1_2").className = "fa-solid fa-clipboard-check fa-beat-fade";
        document.getElementById('b1_2').style.color = 'white';
        document.getElementById('b2').style.backgroundColor = 'rgb(93, 158, 255)';
    }else if(arr[0][1]== "bomb"){
        $(".btn").prop('disabled',true); 
        document.getElementById("b1_2").className = "fa-solid fa-bomb fa-shake";
        document.getElementById('b1_2').style.color = 'white';
        document.getElementById('b2').style.backgroundColor = 'red';
    }else{
        if(gType == "register"){
            
            document.getElementById("b1_2").className = "fa-solid fa-clipboard";
            document.getElementById('b1_2').style.color = 'white';
            document.getElementById('b2').style.backgroundColor = 'lightgreen';
            }
            else{
                document.getElementById("b1_2").className = "fa-solid fa-address-card";
                document.getElementById('b1_2').style.color = 'white';
                document.getElementById('b2').style.backgroundColor = '#6366f1';
            }
    
    }
if(arr[0][2]== "cash"){
        document.getElementById("b1_3").className = "fa-solid fa-clipboard-check fa-beat-fade";
        document.getElementById('b1_3').style.color = 'white';
        document.getElementById('b3').style.backgroundColor = 'rgb(93, 158, 255)';
    }else if(arr[0][2]== "bomb"){
        $(".btn").prop('disabled',true); 
        document.getElementById("b1_3").className = "fa-sharp fa-solid fa-bomb fa-shake";
        document.getElementById('b1_3').style.color = 'white';
        document.getElementById('b3').style.backgroundColor = 'red';
    }else{
        if(gType == "register"){
            
            document.getElementById("b1_3").className = "fa-solid fa-clipboard";
            document.getElementById('b1_3').style.color = 'white';
            document.getElementById('b3').style.backgroundColor = 'lightgreen';
            }
            else{
                document.getElementById("b1_3").className = "fa-solid fa-address-card";
                document.getElementById('b1_3').style.color = 'white';
                document.getElementById('b3').style.backgroundColor = '#6366f1';
            }
    }
if(arr[0][3]== "cash"){
        document.getElementById("b1_4").className = "fa-solid fa-clipboard-check fa-beat-fade";
        document.getElementById('b1_4').style.color = 'white';
        document.getElementById('b4').style.backgroundColor = 'rgb(93, 158, 255)';
    }else if(arr[0][3]== "bomb"){
        $(".btn").prop('disabled',true); 
        document.getElementById("b1_4").className = "fa-sharp fa-solid fa-bomb fa-shake";
        document.getElementById('b1_4').style.color = 'white';
        document.getElementById('b4').style.backgroundColor = 'red';
    }else{
        if(gType == "register"){
            
            document.getElementById("b1_4").className = "fa-solid fa-clipboard";
            document.getElementById('b1_4').style.color = 'white';
            document.getElementById('b4').style.backgroundColor = 'lightgreen';
            }
            else{
                document.getElementById("b1_4").className = "fa-solid fa-address-card";
                document.getElementById('b1_4').style.color = 'white';
                document.getElementById('b4').style.backgroundColor = '#6366f1';
            }
    }
if(arr[0][4]== "cash"){
        document.getElementById("b1_5").className = "fa-solid fa-clipboard-check fa-beat-fade";
        document.getElementById('b1_5').style.color = 'white';
        document.getElementById('b5').style.backgroundColor = 'rgb(93, 158, 255)';
    }else if(arr[0][4]== "bomb"){
        $(".btn").prop('disabled',true); 
        document.getElementById("b1_5").className = "fa-sharp fa-solid fa-bomb fa-shake";
        document.getElementById('b1_5').style.color = 'white';
        document.getElementById('b5').style.backgroundColor = 'red';
    }else{
        if(gType == "register"){
            
            document.getElementById("b1_5").className = "fa-solid fa-clipboard";
            document.getElementById('b1_5').style.color = 'white';
            document.getElementById('b5').style.backgroundColor = 'lightgreen';
            }
            else{
                document.getElementById("b1_5").className = "fa-solid fa-address-card";
                document.getElementById('b1_5').style.color = 'white';
                document.getElementById('b5').style.backgroundColor = '#6366f1';
            }
    }
if(arr[1][0]== "cash"){
        document.getElementById("b1_6").className = "fa-solid fa-clipboard-check fa-beat-fade";
        document.getElementById('b1_6').style.color = 'white';
        document.getElementById('b6').style.backgroundColor = 'rgb(93, 158, 255)';
    }else if(arr[1][0]== "bomb"){
        $(".btn").prop('disabled',true); 
        document.getElementById("b1_6").className = "fa-sharp fa-solid fa-bomb fa-shake";
        document.getElementById('b1_6').style.color = 'white';
        document.getElementById('b6').style.backgroundColor = 'red';
    }else{
        if(gType == "register"){
            
            document.getElementById("b1_6").className = "fa-solid fa-clipboard";
            document.getElementById('b1_6').style.color = 'white';
            document.getElementById('b6').style.backgroundColor = 'lightgreen';
            }
            else{
                document.getElementById("b1_6").className = "fa-solid fa-address-card";
                document.getElementById('b1_6').style.color = 'white';
                document.getElementById('b6').style.backgroundColor = '#6366f1';
            }
    }
if(arr[1][1]== "cash"){
        document.getElementById("b1_7").className = "fa-solid fa-clipboard-check fa-beat-fade";
        document.getElementById('b1_7').style.color = 'white';
        document.getElementById('b7').style.backgroundColor = 'rgb(93, 158, 255)';
    }else if(arr[1][1]== "bomb"){
        $(".btn").prop('disabled',true); 
        document.getElementById("b1_7").className = "fa-sharp fa-solid fa-bomb fa-shake";
        document.getElementById('b1_7').style.color = 'white';
        document.getElementById('b7').style.backgroundColor = 'red';
    }else{
        if(gType == "register"){
            
            document.getElementById("b1_7").className = "fa-solid fa-clipboard";
            document.getElementById('b1_7').style.color = 'white';
            document.getElementById('b7').style.backgroundColor = 'lightgreen';
            }
            else{
                document.getElementById("b1_7").className = "fa-solid fa-address-card";
                document.getElementById('b1_7').style.color = 'white';
                document.getElementById('b7').style.backgroundColor = '#6366f1';
            }
    }
if(arr[1][2]== "cash"){
        document.getElementById("b1_8").className = "fa-solid fa-clipboard-check fa-beat-fade";
        document.getElementById('b1_8').style.color = 'white';
        document.getElementById('b8').style.backgroundColor = 'rgb(93, 158, 255)';
    }else if(arr[1][2]== "bomb"){
        $(".btn").prop('disabled',true); 
        document.getElementById("b1_8").className = "fa-sharp fa-solid fa-bomb fa-shake";
        document.getElementById('b1_8').style.color = 'white';
        document.getElementById('b8').style.backgroundColor = 'red';
    }else{
        if(gType == "register"){
            
            document.getElementById("b1_8").className = "fa-solid fa-clipboard";
            document.getElementById('b1_8').style.color = 'white';
            document.getElementById('b8').style.backgroundColor = 'lightgreen';
            }
            else{
                document.getElementById("b1_8").className = "fa-solid fa-address-card";
                document.getElementById('b1_8').style.color = 'white';
                document.getElementById('b8').style.backgroundColor = '#6366f1';
            }
    }
if(arr[1][3]== "cash"){
        document.getElementById("b1_9").className = "fa-solid fa-clipboard-check fa-beat-fade";
        document.getElementById('b1_9').style.color = 'white';
        document.getElementById('b9').style.backgroundColor = 'rgb(93, 158, 255)';
    }else if(arr[1][3]== "bomb"){
        $(".btn").prop('disabled',true); 
        document.getElementById("b1_9").className = "fa-sharp fa-solid fa-bomb fa-shake";
        document.getElementById('b1_9').style.color = 'white';
        document.getElementById('b9').style.backgroundColor = 'red';
    }else{
        if(gType == "register"){
            
            document.getElementById("b1_9").className = "fa-solid fa-clipboard";
            document.getElementById('b1_9').style.color = 'white';
            document.getElementById('b9').style.backgroundColor = 'lightgreen';
            }
            else{
                document.getElementById("b1_9").className = "fa-solid fa-address-card";
                document.getElementById('b1_9').style.color = 'white';
                document.getElementById('b9').style.backgroundColor = '#6366f1';
            }
    }
if(arr[1][4]== "cash"){
    document.getElementById("b1_10").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_10').style.color = 'white';
    document.getElementById('b10').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[1][4]== "bomb"){
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_10").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_10').style.color = 'white';
    document.getElementById('b10').style.backgroundColor = 'red';
}else{
    if(gType == "register"){
            
        document.getElementById("b1_10").className = "fa-solid fa-clipboard";
        document.getElementById('b1_10').style.color = 'white';
        document.getElementById('b10').style.backgroundColor = 'lightgreen';
        }
        else{
            document.getElementById("b1_10").className = "fa-solid fa-address-card";
            document.getElementById('b1_10').style.color = 'white';
            document.getElementById('b10').style.backgroundColor = '#6366f1';
        }
}
if(arr[2][0]== "cash"){
    document.getElementById("b1_11").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_11').style.color = 'white';
    document.getElementById('b11').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[2][0]== "bomb"){
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_11").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_11').style.color = 'white';
    document.getElementById('b11').style.backgroundColor = 'red';
}else{
    if(gType == "register"){
            
        document.getElementById("b1_11").className = "fa-solid fa-clipboard";
        document.getElementById('b1_11').style.color = 'white';
        document.getElementById('b11').style.backgroundColor = 'lightgreen';
        }
        else{
            document.getElementById("b1_11").className = "fa-solid fa-address-card";
            document.getElementById('b1_11').style.color = 'white';
            document.getElementById('b11').style.backgroundColor = '#6366f1';
        }
}
if(arr[2][1]== "cash"){
    document.getElementById("b1_12").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_12').style.color = 'white';
    document.getElementById('b12').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[2][1]== "bomb"){
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_12").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_12').style.color = 'white';
    document.getElementById('b12').style.backgroundColor = 'red';
}else{
    if(gType == "register"){
            
        document.getElementById("b1_12").className = "fa-solid fa-clipboard";
        document.getElementById('b1_12').style.color = 'white';
        document.getElementById('b12').style.backgroundColor = 'lightgreen';
        }
        else{
            document.getElementById("b1_12").className = "fa-solid fa-address-card";
            document.getElementById('b1_12').style.color = 'white';
            document.getElementById('b12').style.backgroundColor = '#6366f1';
        }
}
if(arr[2][2]== "cash"){
    document.getElementById("b1_13").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_13').style.color = 'white';
    document.getElementById('b13').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[2][2]== "bomb"){
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_13").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_13').style.color = 'white';
    document.getElementById('b13').style.backgroundColor = 'red';
}else{
    if(gType == "register"){
            
        document.getElementById("b1_13").className = "fa-solid fa-clipboard";
        document.getElementById('b1_13').style.color = 'white';
        document.getElementById('b13').style.backgroundColor = 'lightgreen';
        }
        else{
            document.getElementById("b1_13").className = "fa-solid fa-address-card";
            document.getElementById('b1_13').style.color = 'white';
            document.getElementById('b13').style.backgroundColor = '#6366f1';
        }
}
if(arr[2][3]== "cash"){
    document.getElementById("b1_14").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_14').style.color = 'white';
    document.getElementById('b14').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[2][3]== "bomb"){
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_14").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_14').style.color = 'white';
    document.getElementById('b14').style.backgroundColor = 'red';
}else{
    if(gType == "register"){
            
        document.getElementById("b1_14").className = "fa-solid fa-clipboard";
        document.getElementById('b1_14').style.color = 'white';
        document.getElementById('b14').style.backgroundColor = 'lightgreen';
        }
        else{
            document.getElementById("b1_14").className = "fa-solid fa-address-card";
            document.getElementById('b1_14').style.color = 'white';
            document.getElementById('b14').style.backgroundColor = '#6366f1';
        }
}
if(arr[2][4]== "cash"){
    document.getElementById("b1_15").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_15').style.color = 'white';
    document.getElementById('b15').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[2][4]== "bomb"){
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_15").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_15').style.color = 'white';
    document.getElementById('b15').style.backgroundColor = 'red';
}else{
    if(gType == "register"){
            
        document.getElementById("b1_15").className = "fa-solid fa-clipboard";
        document.getElementById('b1_15').style.color = 'white';
        document.getElementById('b15').style.backgroundColor = 'lightgreen';
        }
        else{
            document.getElementById("b1_15").className = "fa-solid fa-address-card";
            document.getElementById('b1_15').style.color = 'white';
            document.getElementById('b15').style.backgroundColor = '#6366f1';
        }
}
if(arr[3][0]== "cash"){
    document.getElementById("b1_16").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_16').style.color = 'white';
    document.getElementById('b16').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[3][0]== "bomb"){
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_16").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_16').style.color = 'white';
    document.getElementById('b16').style.backgroundColor = 'red';
}else{
    if(gType == "register"){
            
        document.getElementById("b1_16").className = "fa-solid fa-clipboard";
        document.getElementById('b1_16').style.color = 'white';
        document.getElementById('b16').style.backgroundColor = 'lightgreen';
        }
        else{
            document.getElementById("b1_16").className = "fa-solid fa-address-card";
            document.getElementById('b1_16').style.color = 'white';
            document.getElementById('b16').style.backgroundColor = '#6366f1';
        }
}
if(arr[3][1]== "cash"){
    document.getElementById("b1_17").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_17').style.color = 'white';
    document.getElementById('b17').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[3][1]== "bomb"){
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_17").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_17').style.color = 'white';
    document.getElementById('b17').style.backgroundColor = 'red';
}else{
    if(gType == "register"){
            
        document.getElementById("b1_17").className = "fa-solid fa-clipboard";
        document.getElementById('b1_17').style.color = 'white';
        document.getElementById('b17').style.backgroundColor = 'lightgreen';
        }
        else{
            document.getElementById("b1_17").className = "fa-solid fa-address-card";
            document.getElementById('b1_17').style.color = 'white';
            document.getElementById('b17').style.backgroundColor = '#6366f1';
        }
}
if(arr[3][2]== "cash"){
    document.getElementById("b1_18").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_18').style.color = 'white';
    document.getElementById('b18').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[3][2]== "bomb"){
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_18").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_18').style.color = 'white';
    document.getElementById('b18').style.backgroundColor = 'red';
}else{
    if(gType == "register"){
            
        document.getElementById("b1_18").className = "fa-solid fa-clipboard";
        document.getElementById('b1_18').style.color = 'white';
        document.getElementById('b18').style.backgroundColor = 'lightgreen';
        }
        else{
            document.getElementById("b1_18").className = "fa-solid fa-address-card";
            document.getElementById('b1_18').style.color = 'white';
            document.getElementById('b18').style.backgroundColor = '#6366f1';
        }
}
if(arr[3][3]== "cash"){
    document.getElementById("b1_19").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_19').style.color = 'white';
    document.getElementById('b19').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[3][3]== "bomb"){
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_19").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_19').style.color = 'white';
    document.getElementById('b19').style.backgroundColor = 'red';
}else{
    if(gType == "register"){
            
        document.getElementById("b1_19").className = "fa-solid fa-clipboard";
        document.getElementById('b1_19').style.color = 'white';
        document.getElementById('b19').style.backgroundColor = 'lightgreen';
        }
        else{
            document.getElementById("b1_19").className = "fa-solid fa-address-card";
            document.getElementById('b1_19').style.color = 'white';
            document.getElementById('b19').style.backgroundColor = '#6366f1';
        }
}
if(arr[3][4]== "cash"){
    document.getElementById("b1_20").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_20').style.color = 'white';
    document.getElementById('b20').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[3][4]== "bomb"){
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_20").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_20').style.color = 'white';
    document.getElementById('b20').style.backgroundColor = 'red';
}else{
    if(gType == "register"){
            
        document.getElementById("b1_20").className = "fa-solid fa-clipboard";
        document.getElementById('b1_20').style.color = 'white';
        document.getElementById('b20').style.backgroundColor = 'lightgreen';
        }
        else{
            document.getElementById("b1_20").className = "fa-solid fa-address-card";
            document.getElementById('b1_20').style.color = 'white';
            document.getElementById('b20').style.backgroundColor = '#6366f1';
        }
}
if(arr[4][0]== "cash"){
    document.getElementById("b1_21").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_21').style.color = 'white';
    document.getElementById('b21').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[4][0]== "bomb"){
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_21").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_21').style.color = 'white';
    document.getElementById('b21').style.backgroundColor = 'red';
}else{
    if(gType == "register"){
            
        document.getElementById("b1_21").className = "fa-solid fa-clipboard";
        document.getElementById('b1_21').style.color = 'white';
        document.getElementById('b21').style.backgroundColor = 'lightgreen';
        }
        else{
            document.getElementById("b1_21").className = "fa-solid fa-address-card";
            document.getElementById('b1_21').style.color = 'white';
            document.getElementById('b21').style.backgroundColor = '#6366f1';
        }
}
if(arr[4][1]== "cash"){
    document.getElementById("b1_22").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_22').style.color = 'white';
    document.getElementById('b22').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[4][1]== "bomb"){
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_22").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_22').style.color = 'white';
    document.getElementById('b22').style.backgroundColor = 'red';
}else{
    if(gType == "register"){
            
        document.getElementById("b1_22").className = "fa-solid fa-clipboard";
        document.getElementById('b1_22').style.color = 'white';
        document.getElementById('b22').style.backgroundColor = 'lightgreen';
        }
        else{
            document.getElementById("b1_22").className = "fa-solid fa-address-card";
            document.getElementById('b1_22').style.color = 'white';
            document.getElementById('b22').style.backgroundColor = '#6366f1';
        }
}
if(arr[4][2]== "cash"){
    document.getElementById("b1_23").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_23').style.color = 'white';
    document.getElementById('b23').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[4][2]== "bomb"){
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_23").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_23').style.color = 'white';
    document.getElementById('b23').style.backgroundColor = 'red';
}else{
    if(gType == "register"){
            
        document.getElementById("b1_23").className = "fa-solid fa-clipboard";
        document.getElementById('b1_23').style.color = 'white';
        document.getElementById('b23').style.backgroundColor = 'lightgreen';
        }
        else{
            document.getElementById("b1_23").className = "fa-solid fa-address-card";
            document.getElementById('b1_23').style.color = 'white';
            document.getElementById('b23').style.backgroundColor = '#6366f1';
        }
}
if(arr[4][3]== "cash"){
    document.getElementById("b1_24").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_24').style.color = 'white';
    document.getElementById('b24').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[4][3]== "bomb"){
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_24").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_24').style.color = 'white';
    document.getElementById('b24').style.backgroundColor = 'red';
}else{
    if(gType == "register"){
            
        document.getElementById("b1_24").className = "fa-solid fa-clipboard";
        document.getElementById('b1_24').style.color = 'white';
        document.getElementById('b24').style.backgroundColor = 'lightgreen';
        }
        else{
            document.getElementById("b1_24").className = "fa-solid fa-address-card";
            document.getElementById('b1_24').style.color = 'white';
            document.getElementById('b24').style.backgroundColor = '#6366f1';
        }
}
if(arr[4][4]== "cash"){
    document.getElementById("b1_25").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_25').style.color = 'white';
    document.getElementById('b25').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[4][4]== "bomb"){
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_25").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_25').style.color = 'white';
    document.getElementById('b25').style.backgroundColor = 'red';
}else{
    if(gType == "register"){
            
        document.getElementById("b1_25").className = "fa-solid fa-clipboard";
        document.getElementById('b1_25').style.color = 'white';
        document.getElementById('b25').style.backgroundColor = 'lightgreen';
        }
        else{
            document.getElementById("b1_25").className = "fa-solid fa-address-card";
            document.getElementById('b1_25').style.color = 'white';
            document.getElementById('b25').style.backgroundColor = '#6366f1';
        }
}
gcash= true
sleep(1000).then(() => {
    display(false)
})
}
function display(bool) {
    if (bool) {
        $('#container1').fadeToggle();
        var div1 = $('#game');
        div1.fadeToggle(300);
    } else {
        if(gType=="register"){
            $.post('https://fs-storerob/regi', JSON.stringify({}));
        }
        else{
            $.post('https://fs-storerob/safes', JSON.stringify({}));
        }

        $.post('https://fs-storerob/exit', JSON.stringify({}));
        if(gcard){
            if(gType== "register"){
                $.post('https://fs-storerob/gcard', JSON.stringify({
                cardCode: cardCode
                }));
            }
            else{
                $.post('https://fs-storerob/gcard', JSON.stringify({
                    cardCode: 1111111
                }))
            }
        }
        if(gcash){
            $.post('https://fs-storerob/gcash', JSON.stringify({
            balance: balance,
        }));
        }
        $('#container1').fadeToggle();
        var div1 = $('#game');
        div1.fadeToggle(600);
    }
}
function displays(bool) {
    if (bool) {
        $('#safePassword').show();
    } else {
        $('#safePassword').hide();
    }
}



/*if (first){
    display(false)
    first=false
}*/

function getRandomInt(max) {
    return Math.floor(Math.random() * max);
}

$("#b1").click(function () {
    $("#b1").prop('disabled',true); 
    if(arr[0][0]== "cash"){
        balance= Math.floor(balance*1.1);
document.getElementById('msum').style.color = '#3bbaff';
        const div = document.getElementById('msum');
        div.textContent = balance+ "$";
        document.getElementById("b1_1").className = "fa-solid fa-clipboard-check fa-beat-fade";
        document.getElementById('b1_1').style.color = 'white';
        document.getElementById('b1').style.backgroundColor = 'rgb(93, 158, 255)';
    }else if(arr[0][0]== "bomb"){
        reavelAll()
        $(".btn").prop('disabled',true); 
        document.getElementById("b1_1").className = "fa-sharp fa-solid fa-bomb fa-shake";
        document.getElementById('b1_1').style.color = 'white';
        document.getElementById('b1').style.backgroundColor = 'red';
    }else{
        gcard= true
        if(gType == "register"){
            
        document.getElementById("b1_1").className = "fa-solid fa-clipboard";
        document.getElementById('b1_1').style.color = 'white';
        document.getElementById('b1').style.backgroundColor = 'lightgreen';
        }
        else{
            document.getElementById("b1_1").className = "fa-solid fa-address-card";
            document.getElementById('b1_1').style.color = 'white';
            document.getElementById('b1').style.backgroundColor = '#6366f1';
        }
    }
    
})
$("#b2").click(function () {
    $("#b2").prop('disabled',true); 
    if(arr[0][1]== "cash"){
        balance= Math.floor(balance*1.1);
document.getElementById('msum').style.color = '#3bbaff';
        const div = document.getElementById('msum');
        div.textContent = balance+ "$";
        document.getElementById("b1_2").className = "fa-solid fa-clipboard-check fa-beat-fade";
        document.getElementById('b1_2').style.color = 'white';
        document.getElementById('b2').style.backgroundColor = 'rgb(93, 158, 255)';
    }else if(arr[0][1]== "bomb"){
        reavelAll()
        $(".btn").prop('disabled',true); 
        document.getElementById("b1_2").className = "fa-sharp fa-solid fa-bomb fa-shake";
        document.getElementById('b1_2').style.color = 'white';
        document.getElementById('b2').style.backgroundColor = 'red';
    }else{
        gcard= true
        if(gType == "register"){
            
        document.getElementById("b1_2").className = "fa-solid fa-clipboard";
        document.getElementById('b1_2').style.color = 'white';
        document.getElementById('b2').style.backgroundColor = 'lightgreen';
        }
        else{
            document.getElementById("b1_2").className = "fa-solid fa-address-card";
            document.getElementById('b1_2').style.color = 'white';
            document.getElementById('b2').style.backgroundColor = '#6366f1';
        }
    }
    
})

$("#b3").click(function () {
    $("#b3").prop('disabled',true); 
    if(arr[0][2]== "cash"){
        balance= Math.floor(balance*1.1);
document.getElementById('msum').style.color = '#3bbaff';
        const div = document.getElementById('msum');
        div.textContent = balance+ "$";
        document.getElementById("b1_3").className = "fa-solid fa-clipboard-check fa-beat-fade";
        document.getElementById('b1_3').style.color = 'white';
        document.getElementById('b3').style.backgroundColor = 'rgb(93, 158, 255)';
    }else if(arr[0][2]== "bomb"){
        reavelAll()
        $(".btn").prop('disabled',true); 
        document.getElementById("b1_3").className = "fa-sharp fa-solid fa-bomb fa-shake";
        document.getElementById('b1_3').style.color = 'white';
        document.getElementById('b3').style.backgroundColor = 'red';
    }else{
        gcard= true
        if(gType == "register"){
            
        document.getElementById("b1_3").className = "fa-solid fa-clipboard";
        document.getElementById('b1_3').style.color = 'white';
        document.getElementById('b3').style.backgroundColor = 'lightgreen';
        }
        else{
            document.getElementById("b1_3").className = "fa-solid fa-address-card";
            document.getElementById('b1_3').style.color = 'white';
            document.getElementById('b3').style.backgroundColor = '#6366f1';
        }
    }
    
})
$("#b4").click(function () {
    $("#b4").prop('disabled',true); 
    if(arr[0][3]== "cash"){
        balance= Math.floor(balance*1.1);
document.getElementById('msum').style.color = '#3bbaff';
        const div = document.getElementById('msum');
        div.textContent = balance+ "$";
        document.getElementById("b1_4").className = "fa-solid fa-clipboard-check fa-beat-fade";
        document.getElementById('b1_4').style.color = 'white';
        document.getElementById('b4').style.backgroundColor = 'rgb(93, 158, 255)';
    }else if(arr[0][3]== "bomb"){
        reavelAll()
        $(".btn").prop('disabled',true); 
        document.getElementById("b1_4").className = "fa-sharp fa-solid fa-bomb fa-shake";
        document.getElementById('b1_4').style.color = 'white';
        document.getElementById('b4').style.backgroundColor = 'red';
    }else{
        gcard= true
        if(gType == "register"){
            
        document.getElementById("b1_4").className = "fa-solid fa-clipboard";
        document.getElementById('b1_4').style.color = 'white';
        document.getElementById('b4').style.backgroundColor = 'lightgreen';
        }
        else{
            document.getElementById("b1_4").className = "fa-solid fa-address-card";
            document.getElementById('b1_4').style.color = 'white';
            document.getElementById('b4').style.backgroundColor = '#6366f1';
        }
    }
    
})

$("#b5").click(function () {
    $("#b5").prop('disabled',true); 
    if(arr[0][4]== "cash"){
        balance= Math.floor(balance*1.1);
document.getElementById('msum').style.color = '#3bbaff';
        const div = document.getElementById('msum');
        div.textContent = balance+ "$";
        document.getElementById("b1_5").className = "fa-solid fa-clipboard-check fa-beat-fade";
        document.getElementById('b1_5').style.color = 'white';
        document.getElementById('b5').style.backgroundColor = 'rgb(93, 158, 255)';
    }else if(arr[0][4]== "bomb"){
        reavelAll()
        $(".btn").prop('disabled',true); 
        document.getElementById("b1_5").className = "fa-sharp fa-solid fa-bomb fa-shake";
        document.getElementById('b1_5').style.color = 'white';
        document.getElementById('b5').style.backgroundColor = 'red';
    }else{
        gcard= true
        if(gType == "register"){
            
        document.getElementById("b1_5").className = "fa-solid fa-clipboard";
        document.getElementById('b1_5').style.color = 'white';
        document.getElementById('b5').style.backgroundColor = 'lightgreen';
        }
        else{
            document.getElementById("b1_5").className = "fa-solid fa-address-card";
            document.getElementById('b1_5').style.color = 'white';
            document.getElementById('b5').style.backgroundColor = '#6366f1';
        }
    }
    
})
$("#b6").click(function () {
    $("#b6").prop('disabled',true); 
    if(arr[1][0]== "cash"){
        balance= Math.floor(balance*1.1);
document.getElementById('msum').style.color = '#3bbaff';
        const div = document.getElementById('msum');
        div.textContent = balance+ "$";
        document.getElementById("b1_6").className = "fa-solid fa-clipboard-check fa-beat-fade";
        document.getElementById('b1_6').style.color = 'white';
        document.getElementById('b6').style.backgroundColor = 'rgb(93, 158, 255)';
    }else if(arr[1][0]== "bomb"){
        reavelAll()
        $(".btn").prop('disabled',true); 
        document.getElementById("b1_6").className = "fa-sharp fa-solid fa-bomb fa-shake";
        document.getElementById('b1_6').style.color = 'white';
        document.getElementById('b6').style.backgroundColor = 'red';
    }else{
        gcard= true
        if(gType == "register"){
            
        document.getElementById("b1_6").className = "fa-solid fa-clipboard";
        document.getElementById('b1_6').style.color = 'white';
        document.getElementById('b6').style.backgroundColor = 'lightgreen';
        }
        else{
            document.getElementById("b1_6").className = "fa-solid fa-address-card";
            document.getElementById('b1_6').style.color = 'white';
            document.getElementById('b6').style.backgroundColor = '#6366f1';
        }
    }
    
})
$("#b7").click(function () {
    $("#b7").prop('disabled',true); 
    if(arr[1][1]== "cash"){
        balance= Math.floor(balance*1.1);
document.getElementById('msum').style.color = '#3bbaff';
        const div = document.getElementById('msum');
        div.textContent = balance+ "$";
        document.getElementById("b1_7").className = "fa-solid fa-clipboard-check fa-beat-fade";
        document.getElementById('b1_7').style.color = 'white';
        document.getElementById('b7').style.backgroundColor = 'rgb(93, 158, 255)';
    }else if(arr[1][1]== "bomb"){
        reavelAll()
        $(".btn").prop('disabled',true); 
        document.getElementById("b1_7").className = "fa-sharp fa-solid fa-bomb fa-shake";
        document.getElementById('b1_7').style.color = 'white';
        document.getElementById('b7').style.backgroundColor = 'red';
    }else{
        gcard= true
        if(gType == "register"){
            
        document.getElementById("b1_7").className = "fa-solid fa-clipboard";
        document.getElementById('b1_7').style.color = 'white';
        document.getElementById('b7').style.backgroundColor = 'lightgreen';
        }
        else{
            document.getElementById("b1_7").className = "fa-solid fa-address-card";
            document.getElementById('b1_7').style.color = 'white';
            document.getElementById('b7').style.backgroundColor = '#6366f1';
        }
    }
    
})
$("#b8").click(function () {
    $("#b8").prop('disabled',true); 
    if(arr[1][2]== "cash"){
        balance= Math.floor(balance*1.1);
document.getElementById('msum').style.color = '#3bbaff';
        const div = document.getElementById('msum');
        div.textContent = balance+ "$";
        document.getElementById("b1_8").className = "fa-solid fa-clipboard-check fa-beat-fade";
        document.getElementById('b1_8').style.color = 'white';
        document.getElementById('b8').style.backgroundColor = 'rgb(93, 158, 255)';
    }else if(arr[1][2]== "bomb"){
        reavelAll()
        $(".btn").prop('disabled',true); 
        document.getElementById("b1_8").className = "fa-sharp fa-solid fa-bomb fa-shake";
        document.getElementById('b1_8').style.color = 'white';
        document.getElementById('b8').style.backgroundColor = 'red';
    }else{
        gcard= true
        if(gType == "register"){
            
        document.getElementById("b1_8").className = "fa-solid fa-clipboard";
        document.getElementById('b1_8').style.color = 'white';
        document.getElementById('b8').style.backgroundColor = 'lightgreen';
        }
        else{
            document.getElementById("b1_8").className = "fa-solid fa-address-card";
            document.getElementById('b1_8').style.color = 'white';
            document.getElementById('b8').style.backgroundColor = '#6366f1';
        }
    }
    
})
$("#b9").click(function () {
    $("#b9").prop('disabled',true); 
    if(arr[1][3]== "cash"){
        balance= Math.floor(balance*1.1);
document.getElementById('msum').style.color = '#3bbaff';
        const div = document.getElementById('msum');
        div.textContent = balance+ "$";
        document.getElementById("b1_9").className = "fa-solid fa-clipboard-check fa-beat-fade";
        document.getElementById('b1_9').style.color = 'white';
        document.getElementById('b9').style.backgroundColor = 'rgb(93, 158, 255)';
    }else if(arr[1][3]== "bomb"){
        reavelAll()
        $(".btn").prop('disabled',true); 
        document.getElementById("b1_9").className = "fa-sharp fa-solid fa-bomb fa-shake";
        document.getElementById('b1_9').style.color = 'white';
        document.getElementById('b9').style.backgroundColor = 'red';
    }else{
        gcard= true
        if(gType == "register"){
            
        document.getElementById("b1_9").className = "fa-solid fa-clipboard";
        document.getElementById('b1_9').style.color = 'white';
        document.getElementById('b9').style.backgroundColor = 'lightgreen';
        }
        else{
            document.getElementById("b1_9").className = "fa-solid fa-address-card";
            document.getElementById('b1_9').style.color = 'white';
            document.getElementById('b9').style.backgroundColor = '#6366f1';
        }
    }
    
})
$("#b10").click(function () {
    $("#b10").prop('disabled',true); 
if(arr[1][4]== "cash"){
    balance= Math.floor(balance*1.1);
document.getElementById('msum').style.color = '#3bbaff';
        const div = document.getElementById('msum');
        div.textContent = balance+ "$";
    document.getElementById("b1_10").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_10').style.color = 'white';
    document.getElementById('b10').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[1][4]== "bomb"){
    reavelAll()
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_10").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_10').style.color = 'white';
    document.getElementById('b10').style.backgroundColor = 'red';
}else{
    gcard= true
    if(gType == "register"){
        
    document.getElementById("b1_10").className = "fa-solid fa-clipboard";
    document.getElementById('b1_10').style.color = 'white';
    document.getElementById('b10').style.backgroundColor = 'lightgreen';
    }
    else{
        document.getElementById("b1_10").className = "fa-solid fa-address-card";
        document.getElementById('b1_10').style.color = 'white';
        document.getElementById('b10').style.backgroundColor = '#6366f1';
    }
}

})
$("#b11").click(function () {
    $("#b11").prop('disabled',true); 
if(arr[2][0]== "cash"){
    balance= Math.floor(balance*1.1);
document.getElementById('msum').style.color = '#3bbaff';
        const div = document.getElementById('msum');
        div.textContent = balance+ "$";
    document.getElementById("b1_11").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_11').style.color = 'white';
    document.getElementById('b11').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[2][0]== "bomb"){
    reavelAll()
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_11").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_11').style.color = 'white';
    document.getElementById('b11').style.backgroundColor = 'red';
}else{
    gcard= true
    if(gType == "register"){
        
    document.getElementById("b1_11").className = "fa-solid fa-clipboard";
    document.getElementById('b1_11').style.color = 'white';
    document.getElementById('b11').style.backgroundColor = 'lightgreen';
    }
    else{
        document.getElementById("b1_11").className = "fa-solid fa-address-card";
        document.getElementById('b1_11').style.color = 'white';
        document.getElementById('b11').style.backgroundColor = '#6366f1';
    }
}

})
$("#b12").click(function () {
    $("#b12").prop('disabled',true); 
if(arr[2][1]== "cash"){
    balance= Math.floor(balance*1.1);
document.getElementById('msum').style.color = '#3bbaff';
        const div = document.getElementById('msum');
        div.textContent = balance+ "$";
    document.getElementById("b1_12").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_12').style.color = 'white';
    document.getElementById('b12').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[2][1]== "bomb"){
    reavelAll()
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_12").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_12').style.color = 'white';
    document.getElementById('b12').style.backgroundColor = 'red';
}else{
    gcard= true
    if(gType == "register"){
        
    document.getElementById("b1_12").className = "fa-solid fa-clipboard";
    document.getElementById('b1_12').style.color = 'white';
    document.getElementById('b12').style.backgroundColor = 'lightgreen';
    }
    else{
        document.getElementById("b1_12").className = "fa-solid fa-address-card";
        document.getElementById('b1_12').style.color = 'white';
        document.getElementById('b12').style.backgroundColor = '#6366f1';
    }
}

})
$("#b13").click(function () {
    $("#b13").prop('disabled',true); 
if(arr[2][2]== "cash"){
    balance= Math.floor(balance*1.1);
document.getElementById('msum').style.color = '#3bbaff';
        const div = document.getElementById('msum');
        div.textContent = balance+ "$";
    document.getElementById("b1_13").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_13').style.color = 'white';
    document.getElementById('b13').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[2][2]== "bomb"){
    reavelAll()
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_13").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_13').style.color = 'white';
    document.getElementById('b13').style.backgroundColor = 'red';
}else{
    gcard= true
    if(gType == "register"){
        
    document.getElementById("b1_13").className = "fa-solid fa-clipboard";
    document.getElementById('b1_13').style.color = 'white';
    document.getElementById('b13').style.backgroundColor = 'lightgreen';
    }
    else{
        document.getElementById("b1_13").className = "fa-solid fa-address-card";
        document.getElementById('b1_13').style.color = 'white';
        document.getElementById('b13').style.backgroundColor = '#6366f1';
    }
}

})
$("#b14").click(function () {
    $("#b14").prop('disabled',true); 
if(arr[2][3]== "cash"){
    balance= Math.floor(balance*1.1);
document.getElementById('msum').style.color = '#3bbaff';
        const div = document.getElementById('msum');
        div.textContent = balance+ "$";
    document.getElementById("b1_14").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_14').style.color = 'white';
    document.getElementById('b14').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[2][3]== "bomb"){
    reavelAll()
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_14").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_14').style.color = 'white';
    document.getElementById('b14').style.backgroundColor = 'red';
}else{
    gcard= true
    if(gType == "register"){
        
    document.getElementById("b1_14").className = "fa-solid fa-clipboard";
    document.getElementById('b1_14').style.color = 'white';
    document.getElementById('b14').style.backgroundColor = 'lightgreen';
    }
    else{
        document.getElementById("b1_14").className = "fa-solid fa-address-card";
        document.getElementById('b1_14').style.color = 'white';
        document.getElementById('b14').style.backgroundColor = '#6366f1';
    }
}

})
$("#b15").click(function () {
    $("#b15").prop('disabled',true); 
if(arr[2][4]== "cash"){
    balance= Math.floor(balance*1.1);
document.getElementById('msum').style.color = '#3bbaff';
        const div = document.getElementById('msum');
        div.textContent = balance+ "$";
    document.getElementById("b1_15").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_15').style.color = 'white';
    document.getElementById('b15').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[2][4]== "bomb"){
    reavelAll()
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_15").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_15').style.color = 'white';
    document.getElementById('b15').style.backgroundColor = 'red';
}else{
    gcard= true
    if(gType == "register"){
        
    document.getElementById("b1_15").className = "fa-solid fa-clipboard";
    document.getElementById('b1_15').style.color = 'white';
    document.getElementById('b15').style.backgroundColor = 'lightgreen';
    }
    else{
        document.getElementById("b1_15").className = "fa-solid fa-address-card";
        document.getElementById('b1_15').style.color = 'white';
        document.getElementById('b15').style.backgroundColor = '#6366f1';
    }
}

})
$("#b16").click(function () {
    $("#b16").prop('disabled',true); 
if(arr[3][0]== "cash"){
    balance= Math.floor(balance*1.1);
document.getElementById('msum').style.color = '#3bbaff';
        const div = document.getElementById('msum');
        div.textContent = balance+ "$";
    document.getElementById("b1_16").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_16').style.color = 'white';
    document.getElementById('b16').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[3][0]== "bomb"){
    reavelAll()
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_16").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_16').style.color = 'white';
    document.getElementById('b16').style.backgroundColor = 'red';
}else{
    gcard= true
    if(gType == "register"){
        
    document.getElementById("b1_16").className = "fa-solid fa-clipboard";
    document.getElementById('b1_16').style.color = 'white';
    document.getElementById('b16').style.backgroundColor = 'lightgreen';
    }
    else{
        document.getElementById("b1_16").className = "fa-solid fa-address-card";
        document.getElementById('b1_16').style.color = 'white';
        document.getElementById('b16').style.backgroundColor = '#6366f1';
    }
}

})
$("#b17").click(function () {
    $("#b17").prop('disabled',true); 
if(arr[3][1]== "cash"){
    balance= Math.floor(balance*1.1);
document.getElementById('msum').style.color = '#3bbaff';
        const div = document.getElementById('msum');
        div.textContent = balance+ "$";
    document.getElementById("b1_17").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_17').style.color = 'white';
    document.getElementById('b17').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[3][1]== "bomb"){
    reavelAll()
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_17").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_17').style.color = 'white';
    document.getElementById('b17').style.backgroundColor = 'red';
}else{
    gcard= true
    if(gType == "register"){
        
    document.getElementById("b1_17").className = "fa-solid fa-clipboard";
    document.getElementById('b1_17').style.color = 'white';
    document.getElementById('b17').style.backgroundColor = 'lightgreen';
    }
    else{
        document.getElementById("b1_17").className = "fa-solid fa-address-card";
        document.getElementById('b1_17').style.color = 'white';
        document.getElementById('b17').style.backgroundColor = '#6366f1';
    }
}

})
$("#b18").click(function () {
    $("#b18").prop('disabled',true); 
if(arr[3][2]== "cash"){
    balance= Math.floor(balance*1.1);
document.getElementById('msum').style.color = '#3bbaff';
        const div = document.getElementById('msum');
        div.textContent = balance+ "$";
    document.getElementById("b1_18").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_18').style.color = 'white';
    document.getElementById('b18').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[3][2]== "bomb"){
    reavelAll()
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_18").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_18').style.color = 'white';
    document.getElementById('b18').style.backgroundColor = 'red';
}else{
    gcard= true
    if(gType == "register"){
        
    document.getElementById("b1_18").className = "fa-solid fa-clipboard";
    document.getElementById('b1_18').style.color = 'white';
    document.getElementById('b18').style.backgroundColor = 'lightgreen';
    }
    else{
        document.getElementById("b1_18").className = "fa-solid fa-address-card";
        document.getElementById('b1_18').style.color = 'white';
        document.getElementById('b18').style.backgroundColor = '#6366f1';
    }
}

})
$("#b19").click(function () {
    $("#b19").prop('disabled',true); 
if(arr[3][3]== "cash"){
    balance= Math.floor(balance*1.1);
document.getElementById('msum').style.color = '#3bbaff';
        const div = document.getElementById('msum');
        div.textContent = balance+ "$";
    document.getElementById("b1_19").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_19').style.color = 'white';
    document.getElementById('b19').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[3][3]== "bomb"){
    reavelAll()
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_19").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_19').style.color = 'white';
    document.getElementById('b19').style.backgroundColor = 'red';
}else{
    gcard= true
    if(gType == "register"){
        
    document.getElementById("b1_19").className = "fa-solid fa-clipboard";
    document.getElementById('b1_19').style.color = 'white';
    document.getElementById('b19').style.backgroundColor = 'lightgreen';
    }
    else{
        document.getElementById("b1_19").className = "fa-solid fa-address-card";
        document.getElementById('b1_19').style.color = 'white';
        document.getElementById('b19').style.backgroundColor = '#6366f1';
    }
}

})
$("#b20").click(function () {
    $("#b20").prop('disabled',true); 
if(arr[3][4]== "cash"){
    balance= Math.floor(balance*1.1);
document.getElementById('msum').style.color = '#3bbaff';
        const div = document.getElementById('msum');
        div.textContent = balance+ "$";
    document.getElementById("b1_20").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_20').style.color = 'white';
    document.getElementById('b20').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[3][4]== "bomb"){
    reavelAll()
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_20").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_20').style.color = 'white';
    document.getElementById('b20').style.backgroundColor = 'red';
}else{
    gcard= true
    if(gType == "register"){
        
    document.getElementById("b1_20").className = "fa-solid fa-clipboard";
    document.getElementById('b1_20').style.color = 'white';
    document.getElementById('b20').style.backgroundColor = 'lightgreen';
    }
    else{
        document.getElementById("b1_20").className = "fa-solid fa-address-card";
        document.getElementById('b1_20').style.color = 'white';
        document.getElementById('b20').style.backgroundColor = '#6366f1';
    }
}

})
$("#b21").click(function () {
    $("#b21").prop('disabled',true); 
if(arr[4][0]== "cash"){
    balance= Math.floor(balance*1.1);
document.getElementById('msum').style.color = '#3bbaff';
        const div = document.getElementById('msum');
        div.textContent = balance+ "$";
    document.getElementById("b1_21").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_21').style.color = 'white';
    document.getElementById('b21').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[4][0]== "bomb"){
    reavelAll()
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_21").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_21').style.color = 'white';
    document.getElementById('b21').style.backgroundColor = 'red';
}else{
    gcard= true
    if(gType == "register"){
        
    document.getElementById("b1_21").className = "fa-solid fa-clipboard";
    document.getElementById('b1_21').style.color = 'white';
    document.getElementById('b21').style.backgroundColor = 'lightgreen';
    }
    else{
        document.getElementById("b1_21").className = "fa-solid fa-address-card";
        document.getElementById('b1_21').style.color = 'white';
        document.getElementById('b21').style.backgroundColor = '#6366f1';
    }
}

})
$("#b22").click(function () {

    $("#b22").prop('disabled',true); 
if(arr[4][1]== "cash"){
    balance= Math.floor(balance*1.1);
document.getElementById('msum').style.color = '#3bbaff';
        const div = document.getElementById('msum');
        div.textContent = balance+ "$";
    document.getElementById("b1_22").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_22').style.color = 'white';
    document.getElementById('b22').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[4][1]== "bomb"){
    reavelAll()
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_22").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_22').style.color = 'white';
    document.getElementById('b22').style.backgroundColor = 'red';
}else{
    gcard= true
    if(gType == "register"){
        
    document.getElementById("b1_22").className = "fa-solid fa-clipboard";
    document.getElementById('b1_22').style.color = 'white';
    document.getElementById('b22').style.backgroundColor = 'lightgreen';
    }
    else{
        document.getElementById("b1_22").className = "fa-solid fa-address-card";
        document.getElementById('b1_22').style.color = 'white';
        document.getElementById('b22').style.backgroundColor = '#6366f1';
    }
}

})
$("#b23").click(function () {
    $("#b23").prop('disabled',true); 
if(arr[4][2]== "cash"){
    balance= Math.floor(balance*1.1);
document.getElementById('msum').style.color = '#3bbaff';
        const div = document.getElementById('msum');
        div.textContent = balance+ "$";
    document.getElementById("b1_23").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_23').style.color = 'white';
    document.getElementById('b23').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[4][2]== "bomb"){
    reavelAll()
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_23").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_23').style.color = 'white';
    document.getElementById('b23').style.backgroundColor = 'red';
}else{
    gcard= true
    if(gType == "register"){
        
    document.getElementById("b1_23").className = "fa-solid fa-clipboard";
    document.getElementById('b1_23').style.color = 'white';
    document.getElementById('b23').style.backgroundColor = 'lightgreen';
    }
    else{
        document.getElementById("b1_23").className = "fa-solid fa-address-card";
        document.getElementById('b1_23').style.color = 'white';
        document.getElementById('b23').style.backgroundColor = '#6366f1';
    }
}

})
$("#b24").click(function () {
    $("#b24").prop('disabled',true); 
if(arr[4][3]== "cash"){
    balance= Math.floor(balance*1.1);
document.getElementById('msum').style.color = '#3bbaff';
        const div = document.getElementById('msum');
        div.textContent = balance+ "$";
    document.getElementById("b1_24").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_24').style.color = 'white';
    document.getElementById('b24').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[4][3]== "bomb"){
    reavelAll()
    $(".btn").prop('disabled',true); 
    document.getElementById("b1_24").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_24').style.color = 'white';
    document.getElementById('b24').style.backgroundColor = 'red';
}else{
    gcard= true
    if(gType == "register"){
        
    document.getElementById("b1_24").className = "fa-solid fa-clipboard";
    document.getElementById('b1_24').style.color = 'white';
    document.getElementById('b24').style.backgroundColor = 'lightgreen';
    }
    else{
        document.getElementById("b1_24").className = "fa-solid fa-address-card";
        document.getElementById('b1_24').style.color = 'white';
        document.getElementById('b24').style.backgroundColor = '#6366f1';
    }
}

})
$("#b25").click(function () {
    $("#b25").prop('disabled',true); 
if(arr[4][4]== "cash"){
    balance= Math.floor(balance*1.1);
document.getElementById('msum').style.color = '#3bbaff';
        const div = document.getElementById('msum');
        div.textContent = balance+ "$";
    document.getElementById("b1_25").className = "fa-solid fa-clipboard-check fa-beat-fade";
    document.getElementById('b1_25').style.color = 'white';
    document.getElementById('b25').style.backgroundColor = 'rgb(93, 158, 255)';
}else if(arr[4][4]== "bomb"){
    $(".btn").prop('disabled',true); 
    reavelAll()
    document.getElementById("b1_25").className = "fa-sharp fa-solid fa-bomb fa-shake";
    document.getElementById('b1_25').style.color = 'white';
    document.getElementById('b25').style.backgroundColor = 'red';
}else{
    gcard= true
    if(gType == "register"){
        
    document.getElementById("b1_25").className = "fa-solid fa-clipboard";
    document.getElementById('b1_25').style.color = 'white';
    document.getElementById('b25').style.backgroundColor = 'lightgreen';
    }
    else{
        document.getElementById("b1_25").className = "fa-solid fa-address-card";
        document.getElementById('b1_25').style.color = 'white';
        document.getElementById('b25').style.backgroundColor = '#6366f1';
    }
}

})



function sleep (time) {
return new Promise((resolve) => setTimeout(resolve, time));
}
window.addEventListener('message', function(event) {
    var item = event.data;
    if(item.type == "first"){
            var div1 = $("#container1");
            div1.fadeToggle(1000);
    }
    if (item.type === "game") {
        if (item.status == true) {
                $("body").html(`<div id="container1"> 
                <div hidden id="safePassword">
                    <input id="safePin"
                        oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                        type = "pin"
                        maxlength = "6"
                         />
                         <button id="subbu" class="subbu" onclick="getInput()">Submit</button> 
                </div>
                <div hidden id="game" class="game">
                    <div id="text">
                    
                        <h1>Register Balance</h1>
                        <h1 id ="msum" class="msum">....$</h1>
                    </div>
                        <table class= "allbtn">
                            <div id="mbt1">
                                <button id="b1" class="b1 btn"><i id="b1_1"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b2" class="b2 btn"><i id="b1_2"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b3" class="b3 btn"><i id="b1_3"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b4" class="b4 btn" ><i id="b1_4"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b5" class="b5 btn"><i id="b1_5"class="fa-solid fa-sack-dollar"></i></button>  
                            </div>
                            <div id="mbt2">
                                <button id="b6" class="b6 btn"><i id="b1_6"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b7" class="b7 btn"><i id="b1_7"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b8" class="b8 btn"><i id="b1_8"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b9" class="b9 btn"><i id="b1_9"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b10" class="b10 btn"><i id="b1_10"class="fa-solid fa-sack-dollar"></i></button>  
                            </div>
                            <div id="mbt3">
                                <button id="b11" class="b11 btn"><i id="b1_11"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b12" class="b12 btn"><i id="b1_12"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b13" class="b13 btn"><i id="b1_13"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b14" class="b14 btn"><i id="b1_14"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b15" class="b15 btn"><i id="b1_15"class="fa-solid fa-sack-dollar"></i></button>  
                            </div>
                            <div id="mbt4">
                                <button id="b16" class="b16 btn"><i id="b1_16"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b17" class="b17 btn"><i id="b1_17"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b18" class="b18 btn"><i id="b1_18"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b19" class="b19 btn"><i id="b1_19"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b20" class="b20 btn"><i id="b1_20"class="fa-solid fa-sack-dollar"></i></button>  
                            </div>
                            <div id="mbt5">
                                <button id="b21" class="b21 btn"><i id="b1_21"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b22" class="b22 btn"><i id="b1_22"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b23" class="b23 btn"><i id="b1_23"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b24" class="b24 btn"><i id="b1_24"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b25" class="b25 btn"><i id="b1_25"class="fa-solid fa-sack-dollar"></i></button>  
                            </div>
                        </table>
                        <div>
                            <button id="cout" class="cout">CASHOUT</button> 
                        </div>
                </div>
            </div>
            <script src="./index.js" type="text/javascript"></script>`);
            gType= item.gtype
            create()
            $("#safePassword").fadeToggle(1)
            $("#game").fadeToggle(1000)
            
        }
    }
    else if(item.type=="safe"){
        $("body").html(`<div id="container1"> 
                <div hidden id="safePassword">
                    <input id="safePin"
                        oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                        type = "pin"
                        maxlength = "6"
                         />
                         <button id="subbu" class="subbu" onclick="getInput()">Submit</button> 
                </div>
                <div hidden id="game" class="game">
                    <div id="text">
                    
                        <h1>Register Balance</h1>
                        <h1 id ="msum" class="msum">....$</h1>
                    </div>
                        <table class= "allbtn">
                            <div id="mbt1">
                                <button id="b1" class="b1 btn"><i id="b1_1"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b2" class="b2 btn"><i id="b1_2"class="fa-solid fa-sack-dollar"></i></button> 
                                <button id="b3" class="b3 btn"><i id="b1_3"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b4" class="b4 btn" ><i id="b1_4"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b5" class="b5 btn"><i id="b1_5"class="fa-solid fa-sack-dollar"></i></button>  
                            </div>
                            <div id="mbt2">
                                <button id="b6" class="b6 btn"><i id="b1_6"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b7" class="b7 btn"><i id="b1_7"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b8" class="b8 btn"><i id="b1_8"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b9" class="b9 btn"><i id="b1_9"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b10" class="b10 btn"><i id="b1_10"class="fa-solid fa-sack-dollar"></i></button>  
                            </div>
                            <div id="mbt3">
                                <button id="b11" class="b11 btn"><i id="b1_11"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b12" class="b12 btn"><i id="b1_12"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b13" class="b13 btn"><i id="b1_13"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b14" class="b14 btn"><i id="b1_14"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b15" class="b15 btn"><i id="b1_15"class="fa-solid fa-sack-dollar"></i></button>  
                            </div>
                            <div id="mbt4">
                                <button id="b16" class="b16 btn"><i id="b1_16"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b17" class="b17 btn"><i id="b1_17"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b18" class="b18 btn"><i id="b1_18"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b19" class="b19 btn"><i id="b1_19"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b20" class="b20 btn"><i id="b1_20"class="fa-solid fa-sack-dollar"></i></button> 
                            </div>
                            <div id="mbt5">
                                <button id="b21" class="b21 btn"><i id="b1_21"class="fa-solid fa-sack-dollar"></i></button> 
                                <button id="b22" class="b22 btn"><i id="b1_22"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b23" class="b23 btn"><i id="b1_23"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b24" class="b24 btn"><i id="b1_24"class="fa-solid fa-sack-dollar"></i></button>  
                                <button id="b25" class="b25 btn"><i id="b1_25"class="fa-solid fa-sack-dollar"></i></button>  
                            </div>
                        </table>
                        <div>
                            <button id="cout" class="cout">CASHOUT</button> 
                        </div>
                </div>
            </div>
            <script src="./index.js" type="text/javascript"></script>`);
    }
    $("#safePassword").fadeToggle(600)
    cardCode= item.cardCode
})