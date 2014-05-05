// Mean
// SUM(Xi)/N
function mu(dat) { var sum = 0; for (var i = dat.length - 1; i >= 0; i--) { sum += dat[i]; }; return sum/dat.length; };

// Variance Sigma^2
// (SUM(Xi-MX)^2)/N
function varDat(dat) { var sigSQ = 0; for (var i = dat.length - 1; i >= 0; i--) { sigSQ += Math.pow(dat[i]-mu(dat), 2); }; return sigSQ/dat.length; };

// Standard deviation
function stdDev(dat){ return Math.sqrt(varDat(dat)); };

// 1/N*(SUM(Xi-MX)(Yi-MY))
function covariance(datX, datY){ var cov = 0; for (var i = 0; i < datX.length; i++) { cov += (datX[i] - mu(datX))*(datY[i] - mu(datY)); }; return cov/datX.length; };

// Standard Score
// Zx = (Xi - MX)/stddevX
function z(dat){ _z = []; for (var i = 0; i < dat.length; i++) { _z.push((dat[i]-mu(dat))/stdDev(dat)); }; return _z; };


// With a data set
function confiDat(dat, a) { return a*Math.sqrt(varDat(dat)/(dat.length)); };
// With poll results
function confiRes(p, n, a) { return a*Math.sqrt((p*(1-p))/n); };


// Factorial
function fac(n) { var _n = 1; for (var i = n; i > 0; i--) { _n *= i; } return _n; };


// (N)!
//-----------
// (K)!(N-K)!
function coef(n, k) { return (fac(n)/(fac(k)*fac(n-k))); };


//  ^K       ^(N-K)
// P^ * (1-P)^
function prob(n, k, p) { return (Math.pow(p, k)) * (Math.pow((1-p), (n-k))); };


// Binomial distribution
function bino(n, k, p) { return coef(n, k)*prob(n, k, p); }


// Test the binomial distribution N times
function test(n, p) { for(var i = 0; i <= n; i++) { console.debug(i+" - "+bino(n,i,p)); }; };


// Create a binomial array
function binomArray(y, n) { Data = []; 
	for (var i = y - 1; i >= 0; i--) { Data.push(1); }; 
	for (var j = n - 1; j >= 0; j--) { Data.push(0); };
	console.debug(Data.length); return Data;
};



// Regression
// y = bx + a + noise
//
// b = SUM((X - MX)*(Y - MY))
//    --------------------- 
//     SUM(X - MX)^2
//
// a = MY - (b*MX)
function b(datX, datY) { 
	var num = 0, den = 0, muX = mu(datX); muY = mu(datY);
	for (var i = 0; i < datX.length; i++) {
		var deltaX = Number(datX[i]-muX), deltaY = Number(datY[i]-muY);
		num += deltaX*deltaY; den += Math.pow(deltaX, 2);
	}; return num/den;
};

function b2(datX, datY){ return covariance(datX, datY)/varDat(datX); };

function a(datX, datY) { return (mu(datY) - b(datX, datY)*mu(datX)); };


// Correlation
// r = SUM((X - MX)*(Y - MY))
//    ------------------------------------- 
//     2root(SUM((X - MX)^2)*SUM((Y-MY)^2))
function r(datX, datY) {
	var num = 0, denx = 0, deny = 0, muX = mu(datX), muY = mu(datY);
	for (var i = 0; i < datX.length; i++) {
		var deltaX = Number(datX[i]-muX), deltaY = Number(datY[i]-muY);
		num += deltaX*deltaY; denx += Math.pow(deltaX, 2); deny += Math.pow(deltaY, 2)
	}; return num/Math.sqrt(denx*deny);	
};

// r
function r2(datX, datY){ return (covariance(datX, datY)/(stdDev(datX))*(stdDev(datY))); };