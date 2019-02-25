%Metodos Numericos 543 25 de febrero de 2019
%Practica 3 - Ejercicio 1
%Navarro Rodriguez Juan Francisco
%Falsa regla bot 200
%Este programa aproxima por el metodo de falsa
%posicion a la raiz de x^10 -1
clc;clear;
%Constantes
maxi = 20; %numero maximo de iteraciones
cifras = 4; %cantidad de cifras minimas de la aproximacion

f = @(x) power(x,10) - 1; %funcion

xinf = 0; % x l inicial
xsup = 1.3; % x u inicial
xaprox = 0; % x r

eaprox = inf;

tol = 0.5*power(10,2-cifras); %la tolerancia, cifras minimas para acabar
fprintf(['\n\nFalsa reglabot 200\n\tEste programa aproxima de forma numerica ', ...
'\n\tpor el metodo de falsa posicion, los ceros de una funcion,', ...
'\n\tcuya f(x) = x^10 - 1', ...
'\n\nAproximacion', ...
'\nSe espera una aproximacion a %d cifras significativas', ...
'\nes decir, una tolerancia de %f %%\n\n', ...
'\n n', ...
'\t|Xinferior','\t|Xsuperior','\t|Xaproxim','\t|Prueba\t','\t|Error Apr'...
], cifras, tol);

for i = 1:(maxi)
	xpast = xaprox;
	xaprox = xsup -f(xsup)*(xinf - xsup)/(f(xinf)-f(xsup)); %agrega la nueva aproximacion al vector
	signo = f(xinf)*f(xaprox); %evaluacion de subintervalo
    fprintf(['\n%d','\t|%f','\t|%f','\t|%f','\t|%f'],i,xinf,xsup,xaprox,signo)
    if (i ~= 1)
		eaprox = abs((1-xpast/xaprox)*100);
        fprintf('\t|%f',eaprox)
    else
        fprintf('\t|\t')
    end
	if (signo < 0)
		xsup = xaprox; 	
	elseif (signo > 0)
		xinf = xaprox;
    end
	if (eaprox < tol)
		break;
	end
end
