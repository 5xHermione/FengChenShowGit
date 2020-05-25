
$().ready(function(){
  
  $(document).on("click change", function(){
    let rule1 = /^([\w\.\-]){1,64}\@([\w\.\-]){1,64}$/;
    $("#user_email").blur(function(){
      if(rule1.test($(this).val())){
        $(this).css("border-color","")
        $('.notice1').text('')
      }else{
        $('.notice1').text('*請輸入email正確格式')
        $(this).css("border-color","red")
      }
    })
  
    let rule2 = /^.{6,12}$/;
    $("#user_password").blur(function(){
      if(rule2.test($(this).val())){
        $(this).css("border-color","")
        $('.notice2').text('')
      }else{
        $('.notice2').text('*請輸入6位數字以上')
        $(this).css("border-color","red")
      }
    })

    $("#user_password_confirmation").blur(function(){    
      if($("#user_password").val()!=$("#user_password_confirmation").val()){
        $('.notice3').text('*與密碼不相同')
        $(this).css("border-color","red")
      }else{ 
        $('.notice3').text('')
        $(this).css("border-color","")
      }
    })

    let rule3 = /^.{3,20}$/;
    $("#user_name").blur(function(){
      if(rule3.test($(this).val())){
        $(this).css("border-color","")
        $('.notice4').text('')      
      }else{
          $('.notice4').text('*請輸入3個以上任意文字')
          $(this).css("border-color","red")
      }
    })
  })
})



