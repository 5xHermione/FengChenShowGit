$().ready(function(){
  $(document).on("click change", function(){
    
    let rulePassword = /^.{6,12}$/;
    $(".password-signup").blur(function(){
      if(rulePassword.test($(this).val())){
        $(this).css("border-color","")
        $(".noticePassword").text("")
      }else{
        $(".noticePassword").text("Password must be more than 6 characters.")
        $(this).css("border-color","#FF5151")
        $(".noticePassword").css("color","#FF5151")
      }
    })

    $(".password-confirmation-signup").blur(function(){    
      if($(".password-signup").val()!=$(".password-confirmation-signup").val()){
        $(".noticeConfirmation").text("Password confirmation should be same as password.")
        $(this).css("border-color","#FF5151")
        $(".noticeConfirmation").css("color","#FF5151")
      }else{ 
        $(".noticeConfirmation").text("")
        $(this).css("border-color","")
      }
    })

    $(".email-signup").blur(function(){
      let ruleEmail = /^([\w\.\-]){1,64}\@([\w\.\-]){1,64}$/;
      let data = { email: $(".email-signup").val()}
      $.ajax({
        url: `/home/verification?email=${data.email}`,   
        type: "GET",   
        dataType: "json",  
        cache: false, 
        data: data, 
        success: function(response) {
          if (response){
            if(ruleEmail.test($(".email-signup").val())){
              $(".email-signup").css("border-color","")
              $(".noticeEmail").text("")
            }else{
              $(".noticeEmail").text("Please enter the correct email format.")
              $(".email-signup").css("border-color","#FF5151")
              $(".noticeEmail").css("color","#FF5151")
            }       
          }else{
            $(".email-signup").css("border-color","#FF5151")
            $(".noticeEmail").text("This email has been used.")
            $(".noticeEmail").css("color","#FF5151")
          }     
        }
      })
    })

    $(".username-signup").blur(function(){
      let ruleUsername = /^\w{1,32}$/;
      let data = { name: $(".username-signup").val()}
      $.ajax({
        url: `/home/verification?name=${data.name}`,   
        type: "GET",   
        dataType: "json",  
        cache: false, 
        data: data, 
        success: function(response) {   
          if (response){ 
            if(ruleUsername.test($(".username-signup").val())){
              $(".username-signup").css("border-color","")
              $(".noticeUserName").text("")      
            }else{
              $(".noticeUserName").text('User name only allows numbers, English letters and underscore. And max length is 32 characters')
              $(".username-signup").css("border-color","#FF5151")
              $(".noticeUserName").css("color","#FF5151")
            }               
          }else{ 
            $(".username-signup").css("border-color","#FF5151")
            $(".noticeUserName").text("this name has been used.") 
            $(".noticeUserName").css("color","#FF5151")      
          }     
        }
      })
    })

  })
})




