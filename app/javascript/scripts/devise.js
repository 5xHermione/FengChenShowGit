
$().ready(function(){
  
  $(document).on("click change", function(){
    
    let rule1 = /^([\w\.\-]){1,64}\@([\w\.\-]){1,64}$/;
    $(".email-signup").blur(function(){
      if(rule1.test($(this).val())){
        $(this).css("border-color","")
        $('.notice1').text('')
      }else{
        $('.notice1').text('*請輸入email正確格式')
        $(this).css("border-color","red")
      }
    })
  
    let rule2 = /^.{6,12}$/;
    $(".password-signup").blur(function(){
      if(rule2.test($(this).val())){
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

    let rule3 = /^\w+$/;
    $(".username-signup").blur(function(){
      if(rule3.test($(this).val())){
        $(this).css("border-color","")
        $('.notice4').text('')      
      }else{
          $('.notice4').text('請輸入數字英文大小寫"_"')
          $(this).css("border-color","red")
      }
    })

  })
})







