String.prototype.prodRegexID = function(){
	return /^P[0-9]{9}$/.test(this);
}
String.prototype.prodRegexNM = function(){
	return /^[0-9 가-힣a-zA-Z]+$/.test(this);
}
String.prototype.prodRegexBUYER = function(){
	return /^[0-9 가-힣a-zA-Z]+$/.test(this);
}
String.prototype.prodRegexCOST = function(){
	return /^[1-9][0-9]+$/.test(this);
}
String.prototype.prodRegexPRICE = function(){
	return /^[1-9][0-9]+$/.test(this);
}
String.prototype.prodRegexSALE = function(){
	return /^[1-9][0-9]+$/.test(this);
}
String.prototype.prodRegexOUTLINE = function(){
	return /^[0-9 가-힣a-zA-Z]+$/.test(this);
}
String.prototype.prodRegexQTYIN = function(){
	return /^[0-9]+$/.test(this);
}
String.prototype.prodRegexTOTALSTOCK = function(){
	return /^[0-9]+$/.test(this);
}
String.prototype.prodRegexPROPERSTOCK = function(){
	return /^[0-9]+$/.test(this);
}
String.prototype.prodRegexINSDATE = function(){
	return /^[1-2][0-9]{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/.test(this);
}
String.prototype.prodRegexDETAIL = function(){
	return /^[0-9 가-힣a-zA-Z]+$/.test(this);
}