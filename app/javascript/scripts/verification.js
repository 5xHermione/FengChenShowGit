$().ready(function(){
  $(document).on("click change", function(){
    
    let rule1 = /^.{6,12}$/;
    $(".password-signup").blur(function(){
      if(rule1.test($(this).val())){
        $(this).css("border-color","")
        $('.notice2').text('')
      }else{
        $('.notice2').text('*請輸入6位數字以上')
        $(this).css("border-color","red")
      }
    })

    $(".password-confirmation-signup").blur(function(){    
      if($(".password-signup").val()!=$(".password-confirmation-signup").val()){
        $('.notice3').text('*與密碼不相同')
        $(this).css("border-color","red")
      }else{ 
        $('.notice3').text('')
        $(this).css("border-color","")
      }
    })

    $(".email-signup").blur(function(){
      let rule2 = /^([\w\.\-]){1,64}\@([\w\.\-]){1,64}$/;
      let data = { email: $(".email-signup").val()}
      $.ajax({
        url: `/home/verification?email=${data.email}`,   
        type: "GET",   
        dataType: "json",  
        cache: false, 
        data: data, 
        success: function(response) {
          if (response){
            if(rule2.test($(".email-signup").val())){
              $(".email-signup").css("border-color","")
              $('.notice1').text('')
            }else{
              $('.notice1').text('*請輸入email正確格式')
              $(".email-signup").css("border-color","red")
            }       
          }else{
            $(".email-signup").css("border-color","red")
            $(".notice1").text("*email已重複");
          }     
        }
      })
    })

    $(".username-signup").blur(function(){
      let rule3 = /^\w+$/;
      let data = { name: $(".username-signup").val()}
      $.ajax({
        url: `/home/verification?name=${data.name}`,   
        type: "GET",   
        dataType: "json",  
        cache: false, 
        data: data, 
        success: function(response) {   
          if (response){ 
            if(rule3.test($(".username-signup").val())){
              $(".username-signup").css("border-color","")
              $('.notice4').text('')      
            }else{
              $('.notice4').text('請輸入數字英文大小寫"_"')
              $(".username-signup").css("border-color","red")
            }               
          }else{ 
            $(".username-signup").css("border-color","red")
            $(".notice4").text("*name已重複");       
          }     
        }
      })
    })

  })
})




