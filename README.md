# Base_de_datos_personalizada

## Creé una BBDD para crear bloques anónimos, triggers, procedures y sus respectivas comprobaciones.

2.1 Cree un bloque anónimo que da salida por pantalla la tabla de multplicar 
de un número que pasemos por pantalla desde el 1 hasta el 11.

Por ejemplo: Si la variable “tabladel” es 5. La salida por pantalla será la tabla de multplicar del 5:
 
 5 x 1 = 5 … Hasta … 5 x 11 = 55


2.2 Cree un bloque anónimo donde declaré una variable constante llamada “salario_mes” de tpo NUMBER(10, 2) 
que inicializa la variable con un valor de salario bruto mensual. Calcula el salario bruto anual y con ese 
salario encuentraré el % de IRPF que se debería aplicar según la tabla de tramos de (Tabla IRPF_pac) y 
calculará la cantdad de IRPF que se deberá pagar.

Por ejemplo, si el valor de la variable “salario_mes” es 1000. La salida por pantalla será:
o Salario mensual: 1000 €
o Salario anual: 12000 €
o IRPF aplicado: 19%
o IRPF a pagar = 2280 €


3.1. Creé un procedimiento llamado “SUMA_IMPARES” que al pasarle un número entero como parámetro de
entrada nos devuelva la suma de los números impares desde el 1 hasta el número pasado.


3.2. Creé una función llamada “NUMERO_MAYOR” que devuelvolverá el mayor de 3 números pasados como
parámetros, en caso de que se repita algún número, se ha de gestonar una excepción de error,
diciendo “No se pueden repetr números en la secuencia”.


4.1. Creé un procedimiento llamado “IRPF_EMPLEADO” el cual, al pasarle por parámetro un numero de
empleado, devuelva los datos del empleado con el Nombre, apellidos y salario_anual y además ha de
devolver, el tramo y % de IRPF que se le debe aplicar. En caso de que no exista el empleado se ha de
gestonar el error con el mensaje “El número de empleado no existe en la tabla”


4.2. Creé una función llamada “EMPLEADOS_TRAMOS_IRPF” que, dado un número de tramo pasado por
parámetro, devuelva el total de empleados que se encuentran en ese mismo tramo de IRPF.


5.1. Creé un trigger llamado “COMPENSA_TRAMO_IRPF” que, al modifcar el salario de un empleado, si la
modifcación implica un cambio en el tramo de IRPF (Ejemplo pasar de cobrar 20.000€ a 30.000€) se
incremente automátcamente 1000€ el nuevo salario, para compensar el cambio de tramo.

5.2. Creé un trigger llamado “MODIFICACIONES_SALARIOS” que, al realizar una modifcación en el salario de
un empleado, actualiza una nueva tabla llamada “AUDITA_SALARIOS”, esta nueva tabla será como un
histórico de cambios realizados en el salario de los empleados. Campos de la nueva tabla a crear:

->id_emp NUMBER(2)

->salario_antguo NUMBER(10, 2)

->salario_nuevo NUMBER(10, 2)

->fecha DATE (Fecha en la que se produce la modifcación)

->hora VARCHAR2(10) (Hora en la que se produce la modifcación)

->username  VARCHAR2(10) (Usuario que realiza la modifcación)

---------------------------------------------------------------
--------------------- COMPROBACIÓN ----------------------------
---------------------------------------------------------------

6.1. Creé un bloque anónimo que muestre el registro de la tabla “alumnos_pac” y el de la tabla
“asignaturas_pac”.


6.2. Creé un bloque anónimo que use el procedimiento “SUMA_IMPARES”:
* Número de la prueba: 6
* Salida por pantalla: “El resultado de sumar los impares hasta 6 es: 9”


6.3. Creé un bloque anónimo que use la función “NUMERO_MAYOR”.
* Números de la prueba: 23, 37, 32
* Salida por pantalla: “El mayor entre (23, 37, 32) es: 37”


6.4. Creé un bloque anónimo que use el procedimiento “IRPF_EMPLEADO”.
* Números empleado de la prueba: 1
* Salida por pantalla: “Antonio García Melero, con salario de 25000 € en tramo 3, con IRPF de un 30%”


6.5. Creé un bloque anónimo que use la función “EMPLEADOS_TRAMOS_IRPF”.
* Número de tramo de la prueba: 5
* Salida por pantalla: “En el tramo 5 de IRP, tenemos a 2 empleados.”


6.6. Creé un bloque anónimo que pida por pantalla un número de empleado y un salario. Ha de actualizar el
salario del empleado si existe y comprobaremos que los triggers han funcionado.

**Salida por pantalla: “El salario del empleado (Nombre empleado) se ha modifcado el día (Últma
Fecha y hora de modifcación), antes era de (Anterior Salario) € y ahora es de (Nuevo salario) €”
