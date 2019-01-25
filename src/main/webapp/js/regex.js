String.prototype.regexID = function(){
	return /^[a-zA-Z0-9]{4,15}$/.test(this);
}
String.prototype.regexPWD = function(){
	return /^[a-z0-9]{4,15}$/.test(this);
}
String.prototype.regexNM = function(){
	return /^[가-힝]{2,4}$/.test(this);
}
String.prototype.regexREGNO = function(){
	var moto = this.replace('-','');
	var magicNum = this.substr(13,1);
	var sum = 0;
	var checkSum = '234567892345';
	for (var int = 0; int < 12; int++) {
		sum += moto.charAt(int) * checkSum.charAt(int);
	}
	var finalVal = (11-(sum%11))%10;
	
	if (finalVal == parseInt(magicNum)) {
		return true;
	}else{
		return false;
	}
}
String.prototype.regexBIR = function() {
	return /^(19|20)\d{2}[-/](0[1-9]|1[012])[-/](0[1-9]|[12][0-9]|3[01])$/.test(this);
}
String.prototype.regexADD1 = function() {
	return /^[a-zA-Z 0-9가-힝\-]+$/.test(this);
}
String.prototype.regexHOMETEL = function(){
	return /^0[1-9]{1,2}-\d{3,4}-\d{4}$/.test(this);
}
String.prototype.regexCOMTEL = function(){
	return /^0[1-9]{1,2}-\d{3,4}-\d{4}$/.test(this);
}
String.prototype.regexMAIL = function(){
	return /^[0-9a-zA-Z]+@[a-z]+(\.[a-z]+){1,2}$/.test(this);
}
String.prototype.regexJOB = function(){
	return /^[가-힝]+$/.test(this);
}
String.prototype.regexLIKE = function(){
	return /^[가-힝a-zA-Z]+$/.test(this);
}
String.prototype.regexHP = function(){
	return /^01[0-9]-[0-9]{2,4}-[0-9]{4}$/.test(this);
}
String.prototype.regexBID = function(){
	return /^P[0-9]{5}$/.test(this);
}
String.prototype.regexANY = function(){
	return /^[a-zA-Z 0-9가-힝]+$/.test(this);
}