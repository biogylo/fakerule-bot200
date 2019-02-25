%Metodos Numericos 543 25 de febrero de 2019
%Practica 3 - Ejercicio 1
%Navarro Rodriguez Juan Francisco
%Falsa regla bot 200
%Este programa aproxima por el metodo de falsa
%posicion a la raiz de f(x) = power(x,2)*abs(cos(sqrt(x)))-5
clc;clear;
%Constantes
maxi = 20; %numero maximo de iteraciones
cifras = 5; %cantidad de cifras minimas de la aproximacion

f = @(x) power(x,2)*abs(cos(sqrt(x)))-5; %funcion

xinf = 0; % x l inicial
xsup = 4; % x u inicial
xaprox = 0; % x r

eaprox = inf;

tol = 0.5*power(10,2-cifras); %la tolerancia, cifras minimas para acabar
modif = true %si se quiere metodo modificado
rcount = [0,0]; %cuenta repeticiones

if (modif)
    modifstr = '\nUsando el metodo modificado';
else
    modifstr = '\nNo se esta usando el metodo modificado.';
end
fprintf(['\n\nFalsa reglabot 200\n\tEste programa aproxima de forma numerica ', ...
'\n\tpor el metodo de falsa posicion, los ceros de una funcion,', ...
'\n\tcuya f(x) = power(x,2)*abs(cos(sqrt(x)))-5', ...
'\n\nAproximacion',modifstr ...
'\nSe espera una aproximacion a %d cifras significativas', ...
'\nes decir, una tolerancia de %f %%\n\n', ...
], cifras, tol);


%grafica

res = 500; %resolucion
stepsize = (xsup-xinf)/res;
xvector = xinf:stepsize:xsup;
yvector = arrayfun(f,xvector);

plot(xvector,yvector,'r');
xlabel('Valor de x');
ylabel('Valor de la funcion');
title('Grafica de la funcion');
grid on;

%con base en la grafica, me di cuenta 
%que la segunda raiz esta entre 3.5 y 4
xinf = 3.5;xsup = 4;

if (modif)
    modifstr = '\nUsando el metodo modificado\n';
else
    modifstr = '\nNo se esta usando el metodo modificado\n';
end
fprintf(['\n n','\t|Xinferior','\t|Xsuperior','\t|Xaproxim',...
    '\t|f(xinf)\t','|f(xaprox)\t','|Prueba\t','\t|Error Apr']);
for i = 1:(maxi)
	xold = xaprox;
   
    if (i > 1 & modif)
        finfold = finf;
        fsupold = fsup;
        if (finfold == finf)
            rcount(1) = rcount(1)+1;
        else
            rcount(1) = 0;
        end
        if (fsupold == fsupold)
            rcount(2) = rcount(2)+1;
        else
            rcount(2) = 0;
        end
        
        if (rcount(1) >=2)
            xsup= (xsup+xinf)/2;
        end
        if (rcount(2) >=2)
            xinf= (xsup+xinf)/2;
        end
    end
    finf = f(xinf);
    fsup = f(xsup);
    xaprox = xsup -fsup*(xinf - xsup)/(finf-fsup); %agrega la nueva aproximacion al vector
	
    faprox = f(xaprox);
    
	signo = finf*faprox; %evaluacion de subintervalo
    
    fprintf(['\n%d','\t|%f','\t|%f','\t|%f','\t|%f','\t|%f','\t|%f'],i,xinf,xsup,xaprox,finf,faprox,signo)
    if (i ~= 1)
		eaprox = abs((1-xold/xaprox)*100);
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

fprintf('\n\nEl valor al que se llego fue de:\n\tx = %f\n\tf(x) = %f \n',xaprox,faprox)
