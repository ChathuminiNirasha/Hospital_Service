<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Hospital Details</title>
        <meta charset="windows-1252">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="style.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
       
</head>
<body>
<body background="b2.jpg">
        <header class="header">
            <nav class="navbar navbar-style">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#micon">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                   
                        <a href=""><img class="logo" src="logo.png"></a>
                    </div> 
                    
                    <div class="collapse navbar-collapse" id="micon">
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="">Add Hospital</a></li>
                            <li><a href="">View Hospital</a></li>
                        </ul>
                    </div>
                </div>
            </nav>
        
                <div class="container">
                    <h3><font face="Lato" size="6">Hospital Details</font></h3><br>
                  <div class="tab tab-2">
                  <form id = "AddForm" >
                    <div>  
                        <label for="hspID"><b>Hospital ID</b></label><br>
                        <input type="text" id="hspID" name="hspID" placeholder="Hospital ID" required />
                    </div>
                    <div>
                        <lable for="name"><b>Name Of The Hospital</b></lable><br>
                        <input type="text" id="name" name="name" placeholder="Hospital Name" required />
                    </div>
                    <div>
                        <label for="location"><b>Location</b></label><br>
                        <input type="text" id="location" name="location" placeholder="City/Town" required />
                    </div>
                    <div>
                        <label for="contact"><b>Contact Number</b></label><br/>
                        <input type="number" id="contact" name="contact" placeholder="Contact Number" required />
                    </div>
                    <div>
                        <button type = "submit" value = "insert" >Add Hospital</button>
                        <button type = "submit" value = "update" >UpdateHospital</button>
                        
                    </div>
                   </form>
                  </div>
                </div> 
          <br>
                <div class="container">
                    <div class="tab tab-1" id = "tableWrapper">
                    
                        </div>
                </div>  
            
          <script>
              
              var rIndex,table; 
             
              
              function getHospitals () {
            	  $.ajax('http://localhost:8081/Hospital_Management/hospital/get-hospitals',{
            		  method : 'GET',
            		  success : function (res) {
            			 //alert(res)
            			  $("#tableWrapper").html(res);
            			
                          
            			 // $("#AddForm").trigger("reset");
            		  },
            		  error : function (error) {
            			  alert("Error in the http connection")
            			  console.log(error);
            		  }
            	  });
              }   
              
              getHospitals();
              
             	$(document).on('click','.updateBtn',function(e){
             		//
             		$("#hspID").val($(this).data('id'));
             		$("#name").val($(this).data('name'));
             		$("#location").val($(this).data('location'));
             		$("#contact").val($(this).data('contact'));

             		
             	});
             	
             	function deleteHospital(id){
             		
             		$.ajax('http://localhost:8081/Hospital_Management/hospital/delete?hospitalID='+id,{
              		  method : 'DELETE',
              		  success : function (res) {
              			  alert(res);
              			  //$("#AddForm").trigger("reset");
              			  getHospitals();
              		  },
              		  error : function (error) {
              			  alert("Error in the http connection")-l,
              			  console.log(error);
              		  }
              	  });
             	}
             	
             	$(document).on('click','.deleteBtn',function(e){
             		
             		var id = $(this).data('id');
             		
             		if (confirm("Are you sure to delete Hospital "+id+" ?")){
             			deleteHospital(id);
             		}
             		
             	});
              
              $("#AddFormid").on('submit',function(e){
            	  
            	  e.preventDefault();
            	  
            	  var activeElement = document.activeElement;
            	  console.log(activeElement);
            	  if(activeElement.type !== 'submit') {
            	    return;
            	  }
            	 
            	  
            	  console.log(e)
            	  var json = {
            		  hospitalID : e.target.elements.hspID.value,
            		  hospitalName :e.target.elements.name.value ,
            		  hospitalLocation : e.target.elements.location.value,
            		  hospitalcontact :e.target.elements.contact.value 
            	  };
            	  console.log(json)
            	  
            	  if (activeElement.value === "insert"){
            		  $.ajax('http://localhost:8081/Hospital_Management/hospital/create',{
                		  data : json,
                		  method : 'POST',
                		  success : function (res) {
                			  alert(res)
                			  $("#AddForm").trigger("reset");
                			  getHospitals();
                		  },
                		  error : function (error) {
                			  alert("Error in the http connection")
                			  console.log(error);
                		  }
                	  });
            	  }
            	  
            	  if (activeElement.value === "update"){
            		  $.ajax('http://localhost:8081/Hospital_Management/hospital/update',{
                		  data : json,
                		  method : 'PUT',
                		  success : function (res) {
                			  alert(res)
                			  $("#AddForm").trigger("reset");
                			  getHospitals();
                		  },
                		  error : function (error) {
                			  alert("Error in the http connection")
                			  console.log(error);
                		  }
                	  });
            	  }
            	 
            	  
              });
              
              function checkEmptyInput()
              {
                  var isEmpty = false,
                    hspID = document.getElementById('hspID').value,
                    name = document.getElementById('name').value,
                    location = document.getElementById('location').value,
                    contact = document.getElementById('contact').value;
                  
                  if(hspID === "")
                      { 
                          alert("Hospital ID can not be Empty");
                          isEmpty = true;
                      }
                
                  else if(name === "")
                      { 
                          alert("Hospital Name can not be Empty");
                          isEmpty = true;
                      }
                  
                  else if(location === "")
                      { 
                          alert("Hospital Location can not be Empty");
                          isEmpty = true;
                      }
                     
                else if(contact === "")
                      { 
                          alert("Contact Number can not be Empty");
                          isEmpty = true;
                      }
                     
                    return isEmpty; 
              }
              
            function addRow()
            {
                if(!checkEmptyInput()){
                    
                var hspID = document.getElementById('hspID').value;
                var name = document.getElementById('name').value;
                var location = document.getElementById('location').value;
                var contact = document.getElementById('contact').value;
                
                var newRow = table.insertRow(table.rows.length);
                
                var cel1 = newRow.insertCell(0);
                var cel2 = newRow.insertCell(1);
                var cel3 = newRow.insertCell(2);
                var cel4 = newRow.insertCell(3);
                
                cel1.innerHTML = hspID;
                cel2.innerHTML = name;
                cel3.innerHTML = location;
                cel4.innerHTML = contact;
                
                selectedRowToInput();
                    
                }
            }
              
              function selectedRowToInput()
              {
                  
                  for(var i = 1; i < table.rows.length; i++)
                    {
                        table.rows[i].onclick = function()
                        {
                            rIndex = this.rowIndex;
                            document.getElementById("hspID").value = this.cells[0].innerHTML;
                            document.getElementById("name").value = this.cells[1].innerHTML;
                            document.getElementById("location").value = this.cells[2].innerHTML;
                            document.getElementById("contact").value = this.cells[3].innerHTML;
                        };
                    }
              }
              selectedRowToInput();
              
              function editHtmlTbleSelectedRow()
              {
                var hspID = document.getElementById("hspID").value,
                    name = document.getElementById("name").value,
                    location = document.getElementById("location").value,
                    contact = document.getElementById("contact").value;
                  
               if(!checkEmptyInput()) {
                table.rows[rIndex].cells[0].innerHTML = hspID;
                table.rows[rIndex].cells[1].innerHTML = name;
                table.rows[rIndex].cells[2].innerHTML = location;
                table.rows[rIndex].cells[3].innerHTML = contact;
               }
              }
              
              function removeSelectedRow()
              {
                  table.deleteRow(rIndex);
                  
                    document.getElementById("hspID").value = "";
                    document.getElementById("name").value = "";
                    document.getElementById("location").value = "";
                    document.getElementById("contact").value = "";
              }
        </script> 
         </header>
     </body>

</body>
</html>