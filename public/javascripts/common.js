// JavaScript Document

window.onload = function(){
	//gnHover();
	//snHover();
	//formW();
}

function openWithSBox(url, h, w){
 Shadowbox.open({
  content: url,
  player: "iframe",
  width: w,
  height: h,
  resizable: false
 });
}

//tab switch
//changeTitle is true or false
//default is true

function showTab(num){
		trs = document.getElementById("tabs").getElementsByTagName("li");
		for(j=0; j<trs.length;j++){
			trs[j].className = "";
		}
		trs[num-1].className = "on";
		
		for(i=1; i<=4; i++){
			ti = document.getElementById("tc" + i);
			ti.style.display = "none";	
		}
		tg = document.getElementById("tc" + num);
		tg.style.display = "block";
}

//button disabled
function btn_state(obj){
	if (obj.className == '') {
        obj.className = 'disabled';
    }
	else{
		obj.className = '';
	}
}

//delete confirm
function delete_confirm(){
	 window.confirm('削除してもよろしいでしょうか。');
}

//pop up dialog box[works_jasrac_associate.html]
function openDialog(){
	var obj = new Object();
	var dwidth = 360;
	var dheight = 150;
	var w_left = (screen.availWidth-dwidth)/2;
	var w_top = (screen.availHeight-dheight)/2;
	window.open("dialog1.html","","innerWidth ="+dwidth+",innerHeight ="+dheight+",screenX ="+w_left+",screenY ="+w_top+",resizable=no");
}

//show hided div
function hideShow(){
	document.getElementById("h_s").style.display="";
}

//shop_form
function chkPrice(obj){
	obj.value = obj.value.replace(/[^\d.]/g,"");
//必须保证第一位为数字而不是.
	obj.value = obj.value.replace(/^\./g,"");
//保证只有出现一个.而没有多个.
	obj.value = obj.value.replace(/\.{2,}/g,".");
//保证.只出现一次，而不能出现两次以上
	obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
}
function chkLast(obj){
// 如果出现非法字符就截取掉
	if(obj.value.substr((obj.value.length - 1), 1) == '.')
		obj.value = obj.value.substr(0,(obj.value.length - 1));
}

function isShopPhone(){
	var form = document.getElementById("new_shop");
	form.action='/shops';
	form.target='';
	form.submit();
}
function isShopEdit(){
	var phone1 = document.getElementById("phone1").value;
	var phone2 = document.getElementById("phone2").value;
	var phone = document.getElementById("shop_phone");
	phone.value = phone1+phone2;

	var form = document.getElementById("edit_shop_<%= @shop.id %>");
	form.action='/shops/update';
	form.target='';
	form.submit();
}

// menu_form

function isMenuPhone(){
	var form = document.getElementById("new_menu");
	form.action='/menus';
	form.target='';
	form.submit();
};
function isMenuEdit(){
	var form = document.getElementById("edit_menu_<%= @menu.id %>");
	form.action='/menus/update';
	form.target='';
	form.submit();
}

//coupon_form

function isCouponPhone(){
	alert(123);
	var from = document.getElementById("coupon_limit_from").value;
	var to = document.getElementById("coupon_limit_to").value;
	document.getElementById("coupon_limit_from").value = from;
	document.getElementById("coupon_limit_to").value = to;

	var form = document.getElementById("new_coupon");
	form.action='/coupons';
	form.target='';
	form.submit();
}


function get_money(){
	var point = document.getElementsByName("pointsg");
	var inp = document.getElementById("input_p").value;
	for(var i=0;i<=point.length;i++){
		if(point[i].checked){
			if(point[i].value<600 || (inp !="" && point[i].value==600)){
				var form = document.getElementById("form");
				form.action = "/systems/get_money";
				form.target = "";
				form.submit();
				alert("充值成功");
				top.Shadowbox.close();
			}else{
				alert(2);
			}
			break;
		}else{}
	}

}
function onb(){
	var num = document.getElementById("input_p").value;
	if(num>2000){
		document.getElementById("input_p").value = "";
		document.getElementById("span_i").innerHTML = "最高可以充值2000";
	}else{
		document.getElementById("span_i").innerHTML = "";
	}
	return true;
}

//***************
$(function(){
	//文本框只能输入数字，并屏蔽输入法和粘贴
	$.fn.numeral = function() {
		$(this).css("ime-mode", "disabled");
		this.bind("keypress",function(e) {
			var code = (e.keyCode ? e.keyCode : e.which);  //兼容火狐 IE
			//if(!$.support && (e.keyCode==0x8))  //火狐下不能使用退格键
			//{
			//    return ;
			//}
			return code >= 48 && code<= 57 || code == 8 || code == 13;
		});
		this.bind("blur", function() {
			if (this.value.lastIndexOf(".") == (this.value.length - 1)) {
				this.value = this.value.substr(0, this.value.length - 1);
			} else if (isNaN(this.value)) {
				this.value = "";
			}
		});
		this.bind("paste", function() {
			if (get_brow_type() == 'chrome'){
				var s = event.clipboardData.getData('text');
			} else {
				var s = window.clipboardData.getData('text');
			}
			if (!/\D/.test(s));
			value = s.replace(/^0*/, '');
			return false;
		});
		this.bind("dragenter", function() {
			return false;
		});
		this.bind("keyup", function(e) {
			//if (/(^0+)/.test(this.value)) {
			//    this.value = this.value.replace(/^0*/, '');
			//}
			if (get_brow_type() == 'chrome') {
				var code = (e.keyCode ? e.keyCode : e.which);
				// 谷歌浏览器下  ime-mode: disabled  禁用输入法无效的处理
				//if ((code < 48 || code > 57) && (code < 96 || code > 105)) {
				if (code > 64 && code < 91 && code == 13) {
					this.value = '';
				}
			}
		});
	};

	$('#phone1').numeral();
	$('#phone2').numeral();
	$('#admin_phone').numeral();
	$('#input_p').numeral();
});
//********************************





